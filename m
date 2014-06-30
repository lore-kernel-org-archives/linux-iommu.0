From: Jerome Glisse <j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/6] mmput: use notifier chain to call subsystem exit
	handler.
Date: Mon, 30 Jun 2014 11:06:30 -0400
Message-ID: <20140630150628.GA1956@gmail.com>
References: <1403920822-14488-1-git-send-email-j.glisse@gmail.com>
	<1403920822-14488-2-git-send-email-j.glisse@gmail.com>
	<019CCE693E457142B37B791721487FD91806B836@storexdag01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <019CCE693E457142B37B791721487FD91806B836-0nO7ALo/ziwxlywnonMhLEEOCMrvLtNR@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Gabbay, Oded" <Oded.Gabbay-5C7GfCeVMHo@public.gmane.org>
Cc: Sherry Cheung <SCheung-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, "hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, "aarcange-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <aarcange-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jatin Kumar <jakumar-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Lucien Dunning <ldunning-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "mgorman-l3A5Bk7waGM@public.gmane.org" <mgorman-l3A5Bk7waGM@public.gmane.org>, "jweiner-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <jweiner-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Subhash Gutti <sgutti-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "riel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <riel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, John Hubbard <jhubbard-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mark Hairgrove <mhairgrove-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Cameron Buschardt <cabuschardt-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "peterz-hDdKplPs4pWWVfeAwA7xHQ@public.gmane.org" <peterz-hDdKplPs4pWWVfeAwA7xHQ@public.gmane.org>, Duncan Poole <dpoole-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Cornwall,
	Jay" <Jay.Cornwall-5C7GfCeVMHo@public.gmane.org>, "Lewycky, Andrew" <Andrew.Lewycky-5C7GfCeVMHo@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Arvind Gopalakrishnan <arvindg-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Deucher,
	Alexander" <Alexander.Deuch>
List-Id: iommu@lists.linux-foundation.org

On Mon, Jun 30, 2014 at 02:41:24PM +0000, Gabbay, Oded wrote:
> On Fri, 2014-06-27 at 22:00 -0400, J=E9r=F4me Glisse wrote:
> > From: J=E9r=F4me Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > =

> > Several subsystem require a callback when a mm struct is being destroy
> > so that they can cleanup there respective per mm struct. Instead of
> > having each subsystem add its callback to mmput use a notifier chain
> > to call each of the subsystem.
> > =

> > This will allow new subsystem to register callback even if they are
> > module. There should be no contention on the rw semaphore protecting
> > the call chain and the impact on the code path should be low and
> > burried in the noise.
> > =

> > Note that this patch also move the call to cleanup functions after
> > exit_mmap so that new call back can assume that mmu_notifier_release
> > have already been call. This does not impact existing cleanup functions
> > as they do not rely on anything that exit_mmap is freeing. Also moved
> > khugepaged_exit to exit_mmap so that ordering is preserved for that
> > function.
> > =

> > Signed-off-by: J=E9r=F4me Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > ---
> >  fs/aio.c                | 29 ++++++++++++++++++++++-------
> >  include/linux/aio.h     |  2 --
> >  include/linux/ksm.h     | 11 -----------
> >  include/linux/sched.h   |  5 +++++
> >  include/linux/uprobes.h |  1 -
> >  kernel/events/uprobes.c | 19 ++++++++++++++++---
> >  kernel/fork.c           | 22 ++++++++++++++++++----
> >  mm/ksm.c                | 26 +++++++++++++++++++++-----
> >  mm/mmap.c               |  3 +++
> >  9 files changed, 85 insertions(+), 33 deletions(-)
> > =

> > diff --git a/fs/aio.c b/fs/aio.c
> > index c1d8c48..1d06e92 100644
> > --- a/fs/aio.c
> > +++ b/fs/aio.c
> > @@ -40,6 +40,7 @@
> >  #include <linux/ramfs.h>
> >  #include <linux/percpu-refcount.h>
> >  #include <linux/mount.h>
> > +#include <linux/notifier.h>
> >  =

> >  #include <asm/kmap_types.h>
> >  #include <asm/uaccess.h>
> > @@ -774,20 +775,22 @@ ssize_t wait_on_sync_kiocb(struct kiocb *req)
> >  EXPORT_SYMBOL(wait_on_sync_kiocb);
> >  =

> >  /*
> > - * exit_aio: called when the last user of mm goes away.  At this point=
, there is
> > + * aio_exit: called when the last user of mm goes away.  At this point=
, there is
> >   * no way for any new requests to be submited or any of the io_* sysca=
lls to be
> >   * called on the context.
> >   *
> >   * There may be outstanding kiocbs, but free_ioctx() will explicitly w=
ait on
> >   * them.
> >   */
> > -void exit_aio(struct mm_struct *mm)
> > +static int aio_exit(struct notifier_block *nb,
> > +		    unsigned long action, void *data)
> >  {
> > +	struct mm_struct *mm =3D data;
> >  	struct kioctx_table *table =3D rcu_dereference_raw(mm->ioctx_table);
> >  	int i;
> >  =

> >  	if (!table)
> > -		return;
> > +		return 0;
> >  =

> >  	for (i =3D 0; i < table->nr; ++i) {
> >  		struct kioctx *ctx =3D table->table[i];
> > @@ -796,10 +799,10 @@ void exit_aio(struct mm_struct *mm)
> >  			continue;
> >  		/*
> >  		 * We don't need to bother with munmap() here - exit_mmap(mm)
> > -		 * is coming and it'll unmap everything. And we simply can't,
> > -		 * this is not necessarily our ->mm.
> > -		 * Since kill_ioctx() uses non-zero ->mmap_size as indicator
> > -		 * that it needs to unmap the area, just set it to 0.
> > +		 * have already been call and everything is unmap by now. But
> > +		 * to be safe set ->mmap_size to 0 since aio_free_ring() uses
> > +		 * non-zero ->mmap_size as indicator that it needs to unmap the
> > +		 * area.
> >  		 */
> >  		ctx->mmap_size =3D 0;
> >  		kill_ioctx(mm, ctx, NULL);
> > @@ -807,6 +810,7 @@ void exit_aio(struct mm_struct *mm)
> >  =

> >  	RCU_INIT_POINTER(mm->ioctx_table, NULL);
> >  	kfree(table);
> > +	return 0;
> >  }
> >  =

> >  static void put_reqs_available(struct kioctx *ctx, unsigned nr)
> > @@ -1629,3 +1633,14 @@ SYSCALL_DEFINE5(io_getevents, aio_context_t, ctx=
_id,
> >  	}
> >  	return ret;
> >  }
> > +
> > +static struct notifier_block aio_mmput_nb =3D {
> > +	.notifier_call		=3D aio_exit,
> > +	.priority		=3D 1,
> > +};
> > +
> > +static int __init aio_init(void)
> > +{
> > +	return mmput_register_notifier(&aio_mmput_nb);
> > +}
> > +subsys_initcall(aio_init);
> > diff --git a/include/linux/aio.h b/include/linux/aio.h
> > index d9c92da..6308fac 100644
> > --- a/include/linux/aio.h
> > +++ b/include/linux/aio.h
> > @@ -73,7 +73,6 @@ static inline void init_sync_kiocb(struct kiocb *kioc=
b, struct file *filp)
> >  extern ssize_t wait_on_sync_kiocb(struct kiocb *iocb);
> >  extern void aio_complete(struct kiocb *iocb, long res, long res2);
> >  struct mm_struct;
> > -extern void exit_aio(struct mm_struct *mm);
> >  extern long do_io_submit(aio_context_t ctx_id, long nr,
> >  			 struct iocb __user *__user *iocbpp, bool compat);
> >  void kiocb_set_cancel_fn(struct kiocb *req, kiocb_cancel_fn *cancel);
> > @@ -81,7 +80,6 @@ void kiocb_set_cancel_fn(struct kiocb *req, kiocb_can=
cel_fn *cancel);
> >  static inline ssize_t wait_on_sync_kiocb(struct kiocb *iocb) { return =
0; }
> >  static inline void aio_complete(struct kiocb *iocb, long res, long res=
2) { }
> >  struct mm_struct;
> > -static inline void exit_aio(struct mm_struct *mm) { }
> >  static inline long do_io_submit(aio_context_t ctx_id, long nr,
> >  				struct iocb __user * __user *iocbpp,
> >  				bool compat) { return 0; }
> > diff --git a/include/linux/ksm.h b/include/linux/ksm.h
> > index 3be6bb1..84c184f 100644
> > --- a/include/linux/ksm.h
> > +++ b/include/linux/ksm.h
> > @@ -20,7 +20,6 @@ struct mem_cgroup;
> >  int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
> >  		unsigned long end, int advice, unsigned long *vm_flags);
> >  int __ksm_enter(struct mm_struct *mm);
> > -void __ksm_exit(struct mm_struct *mm);
> >  =

> >  static inline int ksm_fork(struct mm_struct *mm, struct mm_struct *old=
mm)
> >  {
> > @@ -29,12 +28,6 @@ static inline int ksm_fork(struct mm_struct *mm, str=
uct mm_struct *oldmm)
> >  	return 0;
> >  }
> >  =

> > -static inline void ksm_exit(struct mm_struct *mm)
> > -{
> > -	if (test_bit(MMF_VM_MERGEABLE, &mm->flags))
> > -		__ksm_exit(mm);
> > -}
> > -
> >  /*
> >   * A KSM page is one of those write-protected "shared pages" or "merge=
d pages"
> >   * which KSM maps into multiple mms, wherever identical anonymous page=
 content
> > @@ -83,10 +76,6 @@ static inline int ksm_fork(struct mm_struct *mm, str=
uct mm_struct *oldmm)
> >  	return 0;
> >  }
> >  =

> > -static inline void ksm_exit(struct mm_struct *mm)
> > -{
> > -}
> > -
> >  static inline int PageKsm(struct page *page)
> >  {
> >  	return 0;
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 322d4fc..428b3cf 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -2384,6 +2384,11 @@ static inline void mmdrop(struct mm_struct * mm)
> >  		__mmdrop(mm);
> >  }
> >  =

> > +/* mmput call list of notifier and subsystem/module can register
> > + * new one through this call.
> > + */
> > +extern int mmput_register_notifier(struct notifier_block *nb);
> > +extern int mmput_unregister_notifier(struct notifier_block *nb);
> >  /* mmput gets rid of the mappings and all user-space */
> >  extern void mmput(struct mm_struct *);
> >  /* Grab a reference to a task's mm, if it is not already going away */
> > diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> > index 4f844c6..44e7267 100644
> > --- a/include/linux/uprobes.h
> > +++ b/include/linux/uprobes.h
> > @@ -120,7 +120,6 @@ extern int uprobe_pre_sstep_notifier(struct pt_regs=
 *regs);
> >  extern void uprobe_notify_resume(struct pt_regs *regs);
> >  extern bool uprobe_deny_signal(void);
> >  extern bool arch_uprobe_skip_sstep(struct arch_uprobe *aup, struct pt_=
regs *regs);
> > -extern void uprobe_clear_state(struct mm_struct *mm);
> >  extern int  arch_uprobe_analyze_insn(struct arch_uprobe *aup, struct m=
m_struct *mm, unsigned long addr);
> >  extern int  arch_uprobe_pre_xol(struct arch_uprobe *aup, struct pt_reg=
s *regs);
> >  extern int  arch_uprobe_post_xol(struct arch_uprobe *aup, struct pt_re=
gs *regs);
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index 46b7c31..32b04dc 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -37,6 +37,7 @@
> >  #include <linux/percpu-rwsem.h>
> >  #include <linux/task_work.h>
> >  #include <linux/shmem_fs.h>
> > +#include <linux/notifier.h>
> >  =

> >  #include <linux/uprobes.h>
> >  =

> > @@ -1220,16 +1221,19 @@ static struct xol_area *get_xol_area(void)
> >  /*
> >   * uprobe_clear_state - Free the area allocated for slots.
> >   */
> > -void uprobe_clear_state(struct mm_struct *mm)
> > +static int uprobe_clear_state(struct notifier_block *nb,
> > +			      unsigned long action, void *data)
> >  {
> > +	struct mm_struct *mm =3D data;
> >  	struct xol_area *area =3D mm->uprobes_state.xol_area;
> >  =

> >  	if (!area)
> > -		return;
> > +		return 0;
> >  =

> >  	put_page(area->page);
> >  	kfree(area->bitmap);
> >  	kfree(area);
> > +	return 0;
> >  }
> >  =

> >  void uprobe_start_dup_mmap(void)
> > @@ -1979,9 +1983,14 @@ static struct notifier_block uprobe_exception_nb=
 =3D {
> >  	.priority		=3D INT_MAX-1,	/* notified after kprobes, kgdb */
> >  };
> >  =

> > +static struct notifier_block uprobe_mmput_nb =3D {
> > +	.notifier_call		=3D uprobe_clear_state,
> > +	.priority		=3D 0,
> > +};
> > +
> >  static int __init init_uprobes(void)
> >  {
> > -	int i;
> > +	int i, err;
> >  =

> >  	for (i =3D 0; i < UPROBES_HASH_SZ; i++)
> >  		mutex_init(&uprobes_mmap_mutex[i]);
> > @@ -1989,6 +1998,10 @@ static int __init init_uprobes(void)
> >  	if (percpu_init_rwsem(&dup_mmap_sem))
> >  		return -ENOMEM;
> >  =

> > +	err =3D mmput_register_notifier(&uprobe_mmput_nb);
> > +	if (err)
> > +		return err;
> > +
> >  	return register_die_notifier(&uprobe_exception_nb);
> >  }
> >  __initcall(init_uprobes);
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index dd8864f..b448509 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -87,6 +87,8 @@
> >  #define CREATE_TRACE_POINTS
> >  #include <trace/events/task.h>
> >  =

> > +static BLOCKING_NOTIFIER_HEAD(mmput_notifier);
> > +
> >  /*
> >   * Protected counters by write_lock_irq(&tasklist_lock)
> >   */
> > @@ -623,6 +625,21 @@ void __mmdrop(struct mm_struct *mm)
> >  EXPORT_SYMBOL_GPL(__mmdrop);
> >  =

> >  /*
> > + * Register a notifier that will be call by mmput
> > + */
> > +int mmput_register_notifier(struct notifier_block *nb)
> > +{
> > +	return blocking_notifier_chain_register(&mmput_notifier, nb);
> > +}
> > +EXPORT_SYMBOL_GPL(mmput_register_notifier);
> > +
> > +int mmput_unregister_notifier(struct notifier_block *nb)
> > +{
> > +	return blocking_notifier_chain_unregister(&mmput_notifier, nb);
> > +}
> > +EXPORT_SYMBOL_GPL(mmput_unregister_notifier);
> > +
> > +/*
> >   * Decrement the use count and release all resources for an mm.
> >   */
> >  void mmput(struct mm_struct *mm)
> > @@ -630,11 +647,8 @@ void mmput(struct mm_struct *mm)
> >  	might_sleep();
> >  =

> >  	if (atomic_dec_and_test(&mm->mm_users)) {
> > -		uprobe_clear_state(mm);
> > -		exit_aio(mm);
> > -		ksm_exit(mm);
> > -		khugepaged_exit(mm); /* must run before exit_mmap */
> >  		exit_mmap(mm);
> > +		blocking_notifier_call_chain(&mmput_notifier, 0, mm);
> >  		set_mm_exe_file(mm, NULL);
> >  		if (!list_empty(&mm->mmlist)) {
> >  			spin_lock(&mmlist_lock);
> > diff --git a/mm/ksm.c b/mm/ksm.c
> > index 346ddc9..cb1e976 100644
> > --- a/mm/ksm.c
> > +++ b/mm/ksm.c
> > @@ -37,6 +37,7 @@
> >  #include <linux/freezer.h>
> >  #include <linux/oom.h>
> >  #include <linux/numa.h>
> > +#include <linux/notifier.h>
> >  =

> >  #include <asm/tlbflush.h>
> >  #include "internal.h"
> > @@ -1586,7 +1587,7 @@ static struct rmap_item *scan_get_next_rmap_item(=
struct page **page)
> >  		ksm_scan.mm_slot =3D slot;
> >  		spin_unlock(&ksm_mmlist_lock);
> >  		/*
> > -		 * Although we tested list_empty() above, a racing __ksm_exit
> > +		 * Although we tested list_empty() above, a racing ksm_exit
> >  		 * of the last mm on the list may have removed it since then.
> >  		 */
> >  		if (slot =3D=3D &ksm_mm_head)
> > @@ -1658,9 +1659,9 @@ next_mm:
> >  		/*
> >  		 * We've completed a full scan of all vmas, holding mmap_sem
> >  		 * throughout, and found no VM_MERGEABLE: so do the same as
> > -		 * __ksm_exit does to remove this mm from all our lists now.
> > -		 * This applies either when cleaning up after __ksm_exit
> > -		 * (but beware: we can reach here even before __ksm_exit),
> > +		 * ksm_exit does to remove this mm from all our lists now.
> > +		 * This applies either when cleaning up after ksm_exit
> > +		 * (but beware: we can reach here even before ksm_exit),
> >  		 * or when all VM_MERGEABLE areas have been unmapped (and
> >  		 * mmap_sem then protects against race with MADV_MERGEABLE).
> >  		 */
> > @@ -1821,11 +1822,16 @@ int __ksm_enter(struct mm_struct *mm)
> >  	return 0;
> >  }
> >  =

> > -void __ksm_exit(struct mm_struct *mm)
> > +static int ksm_exit(struct notifier_block *nb,
> > +		    unsigned long action, void *data)
> >  {
> > +	struct mm_struct *mm =3D data;
> >  	struct mm_slot *mm_slot;
> >  	int easy_to_free =3D 0;
> >  =

> > +	if (!test_bit(MMF_VM_MERGEABLE, &mm->flags))
> > +		return 0;
> > +
> >  	/*
> >  	 * This process is exiting: if it's straightforward (as is the
> >  	 * case when ksmd was never running), free mm_slot immediately.
> > @@ -1857,6 +1863,7 @@ void __ksm_exit(struct mm_struct *mm)
> >  		down_write(&mm->mmap_sem);
> >  		up_write(&mm->mmap_sem);
> >  	}
> > +	return 0;
> >  }
> >  =

> >  struct page *ksm_might_need_to_copy(struct page *page,
> > @@ -2305,11 +2312,20 @@ static struct attribute_group ksm_attr_group =
=3D {
> >  };
> >  #endif /* CONFIG_SYSFS */
> >  =

> > +static struct notifier_block ksm_mmput_nb =3D {
> > +	.notifier_call		=3D ksm_exit,
> > +	.priority		=3D 2,
> > +};
> > +
> >  static int __init ksm_init(void)
> >  {
> >  	struct task_struct *ksm_thread;
> >  	int err;
> >  =

> > +	err =3D mmput_register_notifier(&ksm_mmput_nb);
> > +	if (err)
> > +		return err;
> > +
> >  	err =3D ksm_slab_init();
> >  	if (err)
> >  		goto out;
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 61aec93..b684a21 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -2775,6 +2775,9 @@ void exit_mmap(struct mm_struct *mm)
> >  	struct vm_area_struct *vma;
> >  	unsigned long nr_accounted =3D 0;
> >  =

> > +	/* Important to call this first. */
> > +	khugepaged_exit(mm);
> > +
> >  	/* mm's last user has gone, and its about to be pulled down */
> >  	mmu_notifier_release(mm);
> >  =

> =

> Hi Jerome, I reviewed the patch, integrated and tested it in AMD's HSA
> driver (KFD). It works as expected and I didn't find any problems with
> it.
> =

> I did face some problems regarding the amd IOMMU v2 driver, which
> changed its behavior (see commit "iommu/amd: Implement
> mmu_notifier_release call-back") to use mmu_notifier_release and did
> some "bad things" inside that
> notifier (primarily, but not only, deleting the object which held the
> mmu_notifier object itself, which you mustn't do because of the
> locking). =

> =

> I'm thinking of changing that driver's behavior to use this new
> mechanism instead of using mmu_notifier_release. Does that seem
> acceptable ? Another solution will be to add a new mmu_notifier call,
> but we already ruled that out ;)
> =


This sounds acceptable. You can check how i did it in hmm :
http://cgit.freedesktop.org/~glisse/linux/log/?h=3Dhmm

As it had similar issues.

Cheers,
J=E9r=F4me

> So,
> Reviewed-by: Oded Gabbay <oded.gabbay-5C7GfCeVMHo@public.gmane.org>
> =

> 	Oded
