Return-Path: <SRS0=urD1=5S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA155C43331
	for <iommu@archiver.kernel.org>; Thu,  2 Apr 2020 16:03:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A82CB20757
	for <iommu@archiver.kernel.org>; Thu,  2 Apr 2020 16:03:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A82CB20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 76CC788B47;
	Thu,  2 Apr 2020 16:03:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3hZLVYKdgxmI; Thu,  2 Apr 2020 16:03:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2658188ADB;
	Thu,  2 Apr 2020 16:03:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09A26C1AE2;
	Thu,  2 Apr 2020 16:03:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3AFACC07FF
 for <iommu@lists.linux-foundation.org>; Thu,  2 Apr 2020 16:03:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1F732883F2
 for <iommu@lists.linux-foundation.org>; Thu,  2 Apr 2020 16:03:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RETsbD1RN3uR for <iommu@lists.linux-foundation.org>;
 Thu,  2 Apr 2020 16:03:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 33399883EB
 for <iommu@lists.linux-foundation.org>; Thu,  2 Apr 2020 16:03:24 +0000 (UTC)
IronPort-SDR: 5pgb0vztxVwAJ2dyI/xy97cLy3OFAveCB+dePjSl4hXJXejhgy/2j9p7hhsHtPpgsKuPeWS7Gx
 RJrpR1HHcDZg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2020 09:03:22 -0700
IronPort-SDR: +PTP4JYn8XK4q0RknKK20vQVFoXwKNg18a3TRxi854Bd++K8fHXvnUFPJ0LsjZVpMxxc77RLVV
 bFcOXo+vokeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,336,1580803200"; d="scan'208";a="450978955"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by fmsmga006.fm.intel.com with ESMTP; 02 Apr 2020 09:03:21 -0700
Date: Thu, 2 Apr 2020 09:09:09 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH 00/10] IOASID extensions for guest SVA
Message-ID: <20200402090909.4475d430@jacob-builder>
In-Reply-To: <20200402122633.GC1176452@myrica>
References: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200401140301.GJ882512@myrica>
 <20200401163842.09c8e1a6@jacob-builder>
 <20200402122633.GC1176452@myrica>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Alex Williamson <alex.williamson@redhat.com>, "Wu, Hao" <hao.wu@intel.com>,
 David Woodhouse <dwmw2@infradead.org>, Jonathan Cameron <jic23@kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, 2 Apr 2020 14:26:33 +0200
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> On Wed, Apr 01, 2020 at 04:38:42PM -0700, Jacob Pan wrote:
> > On Wed, 1 Apr 2020 16:03:01 +0200
> > Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:
> >   
> > > Hi Jacob,
> > > 
> > > On Wed, Mar 25, 2020 at 10:55:21AM -0700, Jacob Pan wrote:  
> > > > IOASID was introduced in v5.5 as a generic kernel allocator
> > > > service for both PCIe Process Address Space ID (PASID) and ARM
> > > > SMMU's Sub Stream ID. In addition to basic ID allocation,
> > > > ioasid_set was introduced as a token that is shared by a group
> > > > of IOASIDs. This set token can be used for permission checking
> > > > but lack of some features needed by guest Shared Virtual
> > > > Address (SVA). In addition, IOASID support for life cycle
> > > > management is needed among multiple users.
> > > > 
> > > > This patchset introduces two extensions to the IOASID code,
> > > > 1. IOASID set operations
> > > > 2. Notifications for IOASID state synchronization    
> > > 
> > > My main concern with this series is patch 7 changing the spinlock
> > > to a mutex, which prevents SVA from calling ioasid_free() from
> > > the RCU callback of MMU notifiers. Could we use atomic notifiers,
> > > or do the FREE notification another way?
> > >   
> > Maybe I am looking at the wrong code, I thought
> > mmu_notifier_ops.free_notifier() is called outside spinlock with
> > call_srcu(), which will be invoked in the thread context.
> > in mmu_notifier.c mmu_notifier_put()
> > 	spin_unlock(&mm->notifier_subscriptions->lock);
> > 
> > 	call_srcu(&srcu, &subscription->rcu,
> > mmu_notifier_free_rcu);  
> 
> free_notifier() is called from RCU callback, and according to
> Documentation/RCU/checklist.txt:
> 
> 5.      If call_rcu() or call_srcu() is used, the callback function
> will be called from softirq context.  In particular, it cannot block.
> 
> When applying the patch I get the sleep-in-atomic warning:
> 
> [   87.861793] BUG: sleeping function called from invalid context at
> kernel/locking/mutex.c:935 [   87.863293] in_atomic(): 1,
> irqs_disabled(): 0, non_block: 0, pid: 74, name: kworker/6:1
> [   87.863993] 2 locks held by kworker/6:1/74: [   87.864493]  #0:
> ffffff885ac12538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at:
> process_one_work+0x740/0x1880 [   87.865593]  #1: ffffff88591efd30
> ((work_completion)(&sdp->work)){+.+.}-{0:0}, at:
> process_one_work+0x740/0x1880 [   87.866993] CPU: 6 PID: 74 Comm:
> kworker/6:1 Not tainted 5.6.0-next-20200331+ #121 [   87.867393]
> Hardware name: FVP Base (DT) [   87.867893] Workqueue: rcu_gp
> srcu_invoke_callbacks [   87.868393] Call trace: [   87.868793]
> dump_backtrace+0x0/0x310 [   87.869293]  show_stack+0x14/0x20
> [   87.869693]  dump_stack+0x124/0x180 [   87.870193]
> ___might_sleep+0x2ac/0x428 [   87.870693]  __might_sleep+0x88/0x168
> [   87.871094]  __mutex_lock+0xa0/0x1270
> [   87.871593]  mutex_lock_nested+0x1c/0x28
> [   87.872093]  ioasid_free+0x28/0x48
> [   87.872493]  io_mm_free+0x1d0/0x608
> [   87.872993]  mmu_notifier_free_rcu+0x74/0xe8
> [   87.873393]  srcu_invoke_callbacks+0x1d0/0x2c8
> [   87.873893]  process_one_work+0x858/0x1880
> [   87.874393]  worker_thread+0x314/0xcd0
> [   87.874793]  kthread+0x318/0x400
> [   87.875293]  ret_from_fork+0x10/0x18
> 
You are right, I was reading call_srcu comments too fast. I guess
rcu callbacks are still in softirq not offloaded to kernel threads.

 *
 * The callback will be invoked from process context, but must
 *  nevertheless be fast and must not block.
 */
So even atomic works in principle but not a good idea since it may take
a long time.

> > 
> > Anyway, if we have to use atomic. I tried atomic notifier first,
> > there are two subscribers to the free event on x86.
> > 1. IOMMU
> > 2. KVM
> > 
> > For #1, the problem is that in the free operation, VT-d driver
> > needs to do a lot of clean up in thread context.
> > - hold a mutex to traverse a list of devices
> > - clear PASID entry and flush cache
> > 
> > For #2, KVM might be able to deal with spinlocks for updating VMCS
> > PASID translation table. +Hao
> > 
> > Perhaps two solutions I can think of:
> > 1. Use a cyclic IOASID allocator. The main reason of clean up at
> > free is to prevent race with IOASID alloc. Similar to PID, 2M IOASID
> > will take long time overflow. Then we can use atomic notifier and a
> > deferred workqueue to do IOMMU cleanup. The downside is a large and
> > growing PASID table, may not be a performance issue since it has
> > TLB.  
> 
> That might be a problem for SMMU, which has 1024 * 64kB leaf PASID
> tables, for a total of 64MB per endpoint if there is too much
> fragmentation in the IOASID space.
> 
OK. Not an option here :(

> > 2. Let VFIO ensure free always happen after unbind. Then there is no
> > need to do cleanup. But that requires VFIO to keep track of all the
> > PASIDs within each VM. When the VM terminates, VFIO is responsible
> > for the clean up. That was Yi's original proposal. I also tried to
> > provide an IOASID set iterator for VFIO to free the IOASIDs within
> > each VM/set, but the private data belongs to IOMMU driver.  
> 
> Not really my place to comment on this, but I find it nicer to use the
> same gpasid_unbind() path when VFIO frees a PASID as when the guest
> explicitly unbinds before freeing. 
> 

Might be the only option now.

Thanks,

Jacob

> Thanks,
> Jean
> 

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
