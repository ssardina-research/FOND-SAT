(define (domain no_running_1)
	(:requirements :typing)
	(:types 
		 cell
	)
	(:constants 
		c0 c1 c2 - cell
	)
	(:predicates
		(at ?c - cell)
		(adj ?o - cell ?d - cell)
		(broken)
		(scratch)
		(end)
		(act)
		(l3)
		(e3)
		(eff_3_walk)
		(eff_3_run)
		(l2)
		(e2)
		(eff_2_walk)
		(eff_2_run)
		(l1)
		(e1)
		(eff_1_walk)
		(eff_1_run)
		(walk_unfair)
		(run_unfair)
	)
	(:action continue_3 
		:parameters ()
		:precondition (and (not (act)) (e3) (l3) (not (eff_3_walk)) (not (eff_3_run)) (not (eff_2_walk)) (not (eff_2_run)) (not (eff_1_walk)) (not (eff_1_run)))
		:effect (and (act) (not (e3)) (not (e2)) (not (e1)))
	)
	(:action continue_2 
		:parameters ()
		:precondition (and (not (act)) (e2) (l2) (not (eff_3_walk)) (not (eff_3_run)) (not (eff_2_walk)) (not (eff_2_run)) (not (eff_1_walk)) (not (eff_1_run)))
		:effect (and (act) (not (e3)) (not (e2)) (not (e1)))
	)

	(:action continue_2_bis 
		:parameters ()
		:precondition (and (not (act)) (not (e2)) (e3) (l2) (not (eff_3_walk)) (not (eff_3_run)) (not (eff_2_walk)) (not (eff_2_run)) (not (eff_1_walk)) (not (eff_1_run)))
		:effect (and (act) (not (e3)) (not (e2)) (not (e1)))
	)

	(:action continue_1 
		:parameters ()
		:precondition (and (not (act)) (e1) (l1) (not (eff_3_walk)) (not (eff_3_run)) (not (eff_2_walk)) (not (eff_2_run)) (not (eff_1_walk)) (not (eff_1_run)))
		:effect (and (act) (not (e3)) (not (e2)) (not (e1)))
	)

	(:action continue_1_bis
		:parameters ()
		:precondition (and (not (act)) (e3) (not (e1)) (not (e2)) (l1) (not (eff_3_walk)) (not (eff_3_run)) (not (eff_2_walk)) (not (eff_2_run)) (not (eff_1_walk)) (not (eff_1_run)))
		:effect (and (act) (not (e3)) (not (e2)) (not (e1)))
	)

	(:action continue_1_bis_bis 
		:parameters ()
		:precondition (and (not (act)) (e2) (not (e1)) (not (e3)) (l1) (not (eff_3_walk)) (not (eff_3_run)) (not (eff_2_walk)) (not (eff_2_run)) (not (eff_1_walk)) (not (eff_1_run)))
		:effect (and (act) (not (e3)) (not (e2)) (not (e1)))
	)

	(:action degrade_3_2 
		:parameters ()
		:precondition (and (not (act)) (l3) (e2) (not (e3)) (not (eff_3_walk)) (not (eff_3_run)) (not (eff_2_walk)) (not (eff_2_run)) (not (eff_1_walk)) (not (eff_1_run)))
		:effect (and (act) (l2) (not (l3)) (not (e3)) (not (e2)) (not (e1)))
	)
	(:action degrade_3_1 
		:parameters ()
		:precondition (and (not (act)) (l3) (e1) (not (e3)) (not (e2)) (not (eff_3_walk)) (not (eff_3_run)) (not (eff_2_walk)) (not (eff_2_run)) (not (eff_1_walk)) (not (eff_1_run)))
		:effect (and (act) (l1) (not (l3)) (not (e3)) (not (e2)) (not (e1)))
	)
	(:action degrade_2_1 
		:parameters ()
		:precondition (and (not (act)) (l2) (e1) (not (e2)) (not (eff_3_walk)) (not (eff_3_run)) (not (eff_2_walk)) (not (eff_2_run)) (not (eff_1_walk)) (not (eff_1_run)))
		:effect (and (act) (l1) (not (l2)) (not (e3)) (not (e2)) (not (e1)))
	)
	(:action walk_l3_fair 
		:parameters (?o - cell ?d - cell)
		:precondition (and (at ?o) (adj ?o ?d) (not (broken)) (l3) (act) (not (walk_unfair)) (not (run_unfair)))
		:effect (oneof (and (not (at ?o)) (at ?d)) (and (not (act)) (walk_unfair)))
	)
	(:action walk_l2_fair 
		:parameters (?o - cell ?d - cell)
		:precondition (and (at ?o) (adj ?o ?d) (not (broken)) (l2) (act) (not (walk_unfair)) (not (run_unfair)))
		:effect (oneof (and (not (at ?o)) (at ?d)) (and (not (at ?o)) (at ?d) (scratch)) (and (not (act)) (walk_unfair)))
	)
	(:action walk_l1_fair 
		:parameters (?o - cell ?d - cell)
		:precondition (and (at ?o) (adj ?o ?d) (not (broken)) (l1) (act) (not (walk_unfair)) (not (run_unfair)))
		:effect (oneof (and (not (at ?o)) (at ?d)) (and (not (at ?o)) (at ?d) (scratch)) (and (scratch)))
	)
	(:action walk_unfair_ 
		:parameters ()
		:precondition (and (not (run_unfair)) (not (act)) (walk_unfair))
		:effect (oneof (and (eff_3_walk) (e3) (not (walk_unfair))) (and (eff_2_walk) (e2) (not (walk_unfair))) (and (eff_1_walk) (e1) (not (walk_unfair))))
	)
	(:action walk_eff3_explained_by_l3 
		:parameters (?o - cell ?d - cell)
		:precondition (and (at ?o) (adj ?o ?d) (not (broken)) (eff_3_walk))
		:effect (and (not (at ?o)) (at ?d) (not (eff_3_walk)))
	)
	(:action walk_eff2_explained_by_l3 
		:parameters (?o - cell ?d - cell)
		:precondition (and (at ?o) (adj ?o ?d) (not (broken)) (eff_2_walk) (scratch))
		:effect (and (not (at ?o)) (at ?d) (scratch) (not (eff_2_walk)) (e3))
	)
	(:action walk_eff1_explained_by_l3 
		:parameters (?o - cell ?d - cell)
		:precondition (and (at ?o) (adj ?o ?d) (not (broken)) (eff_1_walk) (scratch) (not (at ?o)) (at ?d))
		:effect (and (scratch) (not (eff_1_walk)) (e3))
	)
	(:action walk_eff2_explained_by_l2 
		:parameters (?o - cell ?d - cell)
		:precondition (and (at ?o) (adj ?o ?d) (not (broken)) (eff_2_walk))
		:effect (and (not (at ?o)) (at ?d) (scratch) (not (eff_2_walk)))
	)
	(:action walk_eff1_explained_by_l2 
		:parameters (?o - cell ?d - cell)
		:precondition (and (at ?o) (adj ?o ?d) (not (broken)) (eff_1_walk) (not (at ?o)) (at ?d))
		:effect (and (scratch) (not (eff_1_walk)) (e2))
	)
	(:action walk_eff1_explained_by_l1 
		:parameters (?o - cell ?d - cell)
		:precondition (and (at ?o) (adj ?o ?d) (not (broken)) (eff_1_walk))
		:effect (and (scratch) (not (eff_1_walk)))
	)
	(:action run_l3_fair 
		:parameters ()
		:precondition (and (at c2) (not (broken)) (l3) (act) (not (walk_unfair)) (not (run_unfair)))
		:effect (oneof (and (not (at c2)) (at c0)) (and (not (act)) (run_unfair)) )
	)
	(:action run_l2_fair 
		:parameters ()
		:precondition (and (at c2) (not (broken)) (l2) (act) (not (walk_unfair)) (not (run_unfair)))
		:effect (oneof (and (not (at c2)) (at c0)) (and (not (at c2)) (at c0) (scratch)) (and (not (act)) (run_unfair)))
	)
	(:action run_l1_fair 
		:parameters ()
		:precondition (and (at c2) (not (broken)) (l1) (act) (not (walk_unfair)) (not (run_unfair)))
		:effect (oneof (and (not (at c2)) (at c0) ) (and (not (at c2)) (at c0) (scratch)) (and (broken)))
	)
	(:action run_unfair_ 
		:parameters ()
		:precondition (and (not (walk_unfair)) (not (act)) (run_unfair))
		:effect (oneof (and (eff_3_run) (e3) (not (run_unfair))) (and (eff_2_run) (e2) (not (run_unfair))) (and (eff_1_run) (e1) (not (run_unfair))))
	)
	(:action run_eff3_explained_by_l3 
		:parameters ()
		:precondition (and (at c2) (not (broken)) (eff_3_run))
		:effect (and (not (at c2)) (at c0) (not (eff_3_run)))
	)
	(:action run_eff2_explained_by_l3 
		:parameters ()
		:precondition (and (at c2) (not (broken)) (eff_2_run) (scratch))
		:effect (and (not (at c2)) (at c0) (scratch) (not (eff_2_run)) (e3))
	)
	(:action run_eff1_explained_by_l3 
		:parameters ()
		:precondition (and (at c2) (not (broken)) (eff_1_run) (broken) (not (at c2)) (at c0))
		:effect (and (broken) (not (eff_1_run)) (e3))
	)
	(:action run_eff2_explained_by_l2 
		:parameters ()
		:precondition (and (at c2) (not (broken)) (eff_2_run))
		:effect (and (not (at c2)) (at c0) (scratch) (not (eff_2_run)))
	)
	(:action run_eff1_explained_by_l2 
		:parameters ()
		:precondition (and (at c2) (not (broken)) (eff_1_run) (broken) (not (at c2)) (at c0) (scratch))
		:effect (and (broken) (not (eff_1_run)) (e2))
	)
	(:action run_eff1_explained_by_l1 
		:parameters ()
		:precondition (and (at c2) (not (broken)) (eff_1_run))
		:effect (and (broken) (not (eff_1_run)))
	)
	(:action check_goal_3 
		:parameters ()
		:precondition (and (at c0) (not (broken)) (l3) (act))
		:effect (end)
	)
	(:action check_goal_2 
		:parameters ()
		:precondition (and (at c0) (not (broken)) (l2) (act))
		:effect (end)
	)
	(:action check_goal_1 
		:parameters ()
		:precondition (and (at c2) (not (broken)) (l1) (act))
		:effect (end)
	)
)
