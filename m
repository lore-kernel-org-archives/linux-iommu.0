Received: from mail78-36.sinamail.sina.com.cn (mail78-36.sinamail.sina.com.cn [219.142.78.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330D515E81
	for <iommu@lists.linux.dev>; Mon, 30 Oct 2023 12:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.11.148])
	by sina.com (172.16.235.25) with ESMTP
	id 653FA53100003330; Mon, 30 Oct 2023 20:44:36 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7781334210394
X-SMAIL-UIID: D7303450D688423782E1840F836557A7-20231030-204436
From: Hillf Danton <hdanton@sina.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: syzbot <syzbot+45f6cae2ca8c1f71e529@syzkaller.appspotmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	robin.murphy@arm.com,
	syzkaller-bugs@googlegroups.com,
	Waiman Long <longman@redhat.com>,
	will@kernel.org
Subject: Re: [syzbot] [iommu?] KASAN: slab-use-after-free Read in iommufd_ioas_iova_ranges
Date: Mon, 30 Oct 2023 20:44:24 +0800
Message-Id: <20231030124424.1166-1-hdanton@sina.com>
In-Reply-To: <20231027125413.2151-1-hdanton@sina.com>
References: <000000000000d621b406088a2f55@google.com> <20231026110502.2046-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 27 Oct 2023 20:54:13 +0800 Hillf Danton <hdanton@sina.com>
> On Thu, 26 Oct 2023 08:41:08 -0300 Jason Gunthorpe <jgg@ziepe.ca>
> > On Thu, Oct 26, 2023 at 07:05:02PM +0800, Hillf Danton wrote:
> > > On Wed, 25 Oct 2023 15:32:20 -0300 Jason Gunthorpe <jgg@ziepe.ca>
> > > > On Wed, Oct 25, 2023 at 06:11:01AM -0700, syzbot wrote:
> > > > > Hello,
> > > > > 
> > > > > syzbot found the following issue on:
> > > > > 
> > > > > HEAD commit:    c3200081020d Merge tag 'block-6.6-2023-10-20' of git://git..
> > > > > git tree:       upstream
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=15013471680000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=849fe52ba7c6d78a
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=45f6cae2ca8c1f71e529
> > > > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > > > > 
> > > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > > > 
> > > > > Downloadable assets:
> > > > > disk image: https://storage.googleapis.com/syzbot-assets/caa5c1eed3ec/disk-c3200081.raw.xz
> > > > > vmlinux: https://storage.googleapis.com/syzbot-assets/7990a3a9f71e/vmlinux-c3200081.xz
> > > > > kernel image: https://storage.googleapis.com/syzbot-assets/015551ac9acc/bzImage-c3200081.xz
> > > > > 
> > > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > > Reported-by: syzbot+45f6cae2ca8c1f71e529@syzkaller.appspotmail.com
> > > > > 
> > > > > ==================================================================
> > > > > BUG: KASAN: slab-use-after-free in __up_read+0xb3/0x690 kernel/locking/rwsem.c:1342
> > > > > Read of size 8 at addr ffff8880283c9068 by task syz-executor.2/30372
> > > > 
> > > > Oh *ugh* I knew about this limitation once and forgot about it
> > > > apparently.
> > > > 
> > > >   CPU 0         CPU1
> > > >  down_read()
> > > >  up_read()
> > > >                 down_write()
> > > >                 up_write()
> > > > 		kfree()
> > > >  [..]
> > > >   tail portion of up_read()
> > > > 
> > > > I suppose the rwsem should be turned into a refcount and completion
> > >
> > > The line [1] syzbot caught is before preempt is disabled, 
> > 
> > So? It is SMP.
> > 
> > > so no lock is released yet, and the report is a simple uaf with
> > > nothing to do with down_write().
> > 
> > down_write() is one of the concurrent paths toward kfree.
> > 
> >         tmp = atomic_long_add_return_release(-RWSEM_READER_BIAS, &sem->count);
> >          ^^^^ This allows the down_write to proceed to kfree
> > 
> > 	DEBUG_RWSEMS_WARN_ON(tmp < 0, sem);
> > 	if (unlikely((tmp & (RWSEM_LOCK_MASK|RWSEM_FLAG_WAITERS)) ==
> > 		      RWSEM_FLAG_WAITERS)) {
> > 		clear_nonspinnable(sem);
> > 		rwsem_wake(sem);
> > 	}
> > 
> > And so if we are unlucky we can UAF someplace in this latter part.
> 
> Hm ... let me work it out.
> 
> 	__up_read(&foo->sem)		rwsem_down_write_slowpath(&foo->sem)
> 	===				===
> 					rwsem_add_waiter(sem, &waiter);
> 					atomic_long_or(RWSEM_FLAG_WAITERS, &sem->count);
> 
> 	tmp = atomic_long_add_return_release(-RWSEM_READER_BIAS, &sem->count);
> 	if (unlikely((tmp & (RWSEM_LOCK_MASK|RWSEM_FLAG_WAITERS)) ==
> 		      RWSEM_FLAG_WAITERS)) {
> 
> 					if (rwsem_try_write_lock(sem, &waiter)) {
> 						/* ACQUIRE on success */
> 						...
> 						up_write(&foo->sem);
> 						kfree(foo);
> 					}
> 
> 		clear_nonspinnable(sem); <-- UAF
> 		rwsem_wake(sem);
> 	}
> 
> Sigh ... the race between up_read() and down_write() exists.
> 
> Fix it by moving setting RWSEM_FLAG_WAITERS to rwsem_try_write_lock().
> Only for thoughts.
> 
> --- x/kernel/locking/rwsem.c
> +++ y/kernel/locking/rwsem.c
> @@ -606,6 +606,8 @@ static inline bool rwsem_try_write_lock(
>  {
>  	struct rwsem_waiter *first = rwsem_first_waiter(sem);
>  	long count, new;
> +	bool single = list_is_singular(&sem->wait_list);
> +	bool set_hoff;
>  
>  	lockdep_assert_held(&sem->wait_lock);
>  
> @@ -613,6 +615,7 @@ static inline bool rwsem_try_write_lock(
>  	do {
>  		bool has_handoff = !!(count & RWSEM_FLAG_HANDOFF);
>  
> +		set_hoff = true;
>  		if (has_handoff) {
>  			/*
>  			 * Honor handoff bit and yield only when the first
> @@ -631,20 +634,29 @@ static inline bool rwsem_try_write_lock(
>  			 * if it is an RT task or wait in the wait queue
>  			 * for too long.
>  			 */
> -			if (has_handoff || (!rt_task(waiter->task) &&
> -					    !time_after(jiffies, waiter->timeout)))
> +			if (has_handoff)
>  				return false;
> -
> -			new |= RWSEM_FLAG_HANDOFF;
> +			if (!rt_task(waiter->task) &&
> +			    !time_after(jiffies, waiter->timeout)) {
> +				if (!single)
> +					return false;
> +				if (new & RWSEM_FLAG_WAITERS)
> +					return false;
> +				new |= RWSEM_FLAG_WAITERS;
> +				set_hoff = false;
> +			} else {
> +				new |= RWSEM_FLAG_HANDOFF;
> +				if (single)
> +					new |= RWSEM_FLAG_WAITERS;
> +			}
>  		} else {
>  			new |= RWSEM_WRITER_LOCKED;
>  			new &= ~RWSEM_FLAG_HANDOFF;
> -
> -			if (list_is_singular(&sem->wait_list))
> -				new &= ~RWSEM_FLAG_WAITERS;
>  		}
>  	} while (!atomic_long_try_cmpxchg_acquire(&sem->count, &count, new));
>  
> +	if (!set_hoff)
> +		return false;
>  	/*
>  	 * We have either acquired the lock with handoff bit cleared or set
>  	 * the handoff bit. Only the first waiter can have its handoff_set
> @@ -1141,7 +1153,7 @@ rwsem_down_write_slowpath(struct rw_sema
>  			raw_spin_lock_irq(&sem->wait_lock);
>  		}
>  	} else {
> -		atomic_long_or(RWSEM_FLAG_WAITERS, &sem->count);
> +		/* see RWSEM_FLAG_WAITERS in rwsem_try_write_lock() */
>  	}
>  
>  	/* wait until we successfully acquire the lock */
> --

The fix above does not cover the case that signaled waiter tries to acquire
rwsem with RWSEM_FLAG_WAITERS set ending up with uaf, and again fix it by
bailing out if killed.

--- x/kernel/locking/rwsem.c
+++ y/kernel/locking/rwsem.c
@@ -1190,6 +1190,8 @@ rwsem_down_write_slowpath(struct rw_sema
 		schedule_preempt_disabled();
 		lockevent_inc(rwsem_sleep_writer);
 		set_current_state(state);
+		if (signal_pending_state(state, current))
+			goto out_nolock;
 trylock_again:
 		raw_spin_lock_irq(&sem->wait_lock);
 	}

And the updated fix looks like the diff below.

--- x/kernel/locking/rwsem.c
+++ y/kernel/locking/rwsem.c
@@ -606,6 +606,7 @@ static inline bool rwsem_try_write_lock(
 {
 	struct rwsem_waiter *first = rwsem_first_waiter(sem);
 	long count, new;
+	int set_waiter;
 
 	lockdep_assert_held(&sem->wait_lock);
 
@@ -623,6 +624,7 @@ static inline bool rwsem_try_write_lock(
 				return false;
 		}
 
+		set_waiter = 0;
 		new = count;
 
 		if (count & RWSEM_LOCK_MASK) {
@@ -631,11 +633,18 @@ static inline bool rwsem_try_write_lock(
 			 * if it is an RT task or wait in the wait queue
 			 * for too long.
 			 */
-			if (has_handoff || (!rt_task(waiter->task) &&
-					    !time_after(jiffies, waiter->timeout)))
+			if (has_handoff)
 				return false;
-
-			new |= RWSEM_FLAG_HANDOFF;
+			if (!rt_task(waiter->task) &&
+			    !time_after(jiffies, waiter->timeout)) {
+				if (new & RWSEM_FLAG_WAITERS)
+					return false;
+				new |= RWSEM_FLAG_WAITERS;
+				set_waiter = 1;
+			} else {
+				new |= RWSEM_FLAG_HANDOFF;
+				new |= RWSEM_FLAG_WAITERS;
+			}
 		} else {
 			new |= RWSEM_WRITER_LOCKED;
 			new &= ~RWSEM_FLAG_HANDOFF;
@@ -656,6 +665,8 @@ static inline bool rwsem_try_write_lock(
 		return false;
 	}
 
+	if (set_waiter)
+		return false;
 	/*
 	 * Have rwsem_try_write_lock() fully imply rwsem_del_waiter() on
 	 * success.
@@ -1141,7 +1152,7 @@ rwsem_down_write_slowpath(struct rw_sema
 			raw_spin_lock_irq(&sem->wait_lock);
 		}
 	} else {
-		atomic_long_or(RWSEM_FLAG_WAITERS, &sem->count);
+		/* see RWSEM_FLAG_WAITERS in rwsem_try_write_lock() */
 	}
 
 	/* wait until we successfully acquire the lock */
@@ -1178,6 +1189,8 @@ rwsem_down_write_slowpath(struct rw_sema
 		schedule_preempt_disabled();
 		lockevent_inc(rwsem_sleep_writer);
 		set_current_state(state);
+		if (signal_pending_state(state, current))
+			goto out_nolock;
 trylock_again:
 		raw_spin_lock_irq(&sem->wait_lock);
 	}
--
