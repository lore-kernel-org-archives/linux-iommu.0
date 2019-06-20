Return-Path: <SRS0=IV2l=UT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D34C43613
	for <iommu@archiver.kernel.org>; Thu, 20 Jun 2019 10:44:59 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5781E2070B
	for <iommu@archiver.kernel.org>; Thu, 20 Jun 2019 10:44:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5781E2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 16960B1F;
	Thu, 20 Jun 2019 10:44:59 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5D762AE7
	for <iommu@lists.linux-foundation.org>;
	Thu, 20 Jun 2019 10:44:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A83B57DB
	for <iommu@lists.linux-foundation.org>;
	Thu, 20 Jun 2019 10:44:57 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B44D8316290E;
	Thu, 20 Jun 2019 10:44:37 +0000 (UTC)
Received: from xz-x1 (ovpn-12-68.pek2.redhat.com [10.72.12.68])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0DD8419C5B;
	Thu, 20 Jun 2019 10:44:31 +0000 (UTC)
Date: Thu, 20 Jun 2019 18:44:29 +0800
From: Peter Xu <peterx@redhat.com>
To: Linux IOMMU Mailing List <iommu@lists.linux-foundation.org>
Subject: VT-d deadlock issue on device_domain_lock and iommu lock (5.2-rc5)
Message-ID: <20190620104418.GA9657@xz-x1>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Thu, 20 Jun 2019 10:44:42 +0000 (UTC)
Cc: dave.jiang@intel.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi,

With 5.2.0-rc5 I can easily trigger this with lockdep:

--------------------------------------------
Jun 20 14:37:37 xz-x1 kernel: ======================================================
Jun 20 14:37:37 xz-x1 kernel: WARNING: possible circular locking dependency detected
Jun 20 14:37:37 xz-x1 kernel: 5.2.0-rc5 #78 Not tainted
Jun 20 14:37:37 xz-x1 kernel: ------------------------------------------------------
Jun 20 14:37:37 xz-x1 kernel: swapper/0/1 is trying to acquire lock:
Jun 20 14:37:37 xz-x1 kernel: 00000000ea2b3beb (&(&iommu->lock)->rlock){+.+.}, at: domain_context_mapping_one+0xa5/0x4e0
Jun 20 14:37:37 xz-x1 kernel:
                              but task is already holding lock:
Jun 20 14:37:37 xz-x1 kernel: 00000000a681907b (device_domain_lock){....}, at: domain_context_mapping_one+0x8d/0x4e0
Jun 20 14:37:37 xz-x1 kernel:
                              which lock already depends on the new lock.
Jun 20 14:37:37 xz-x1 kernel:
                              the existing dependency chain (in reverse order) is:
Jun 20 14:37:37 xz-x1 kernel:
                              -> #1 (device_domain_lock){....}:
Jun 20 14:37:37 xz-x1 kernel:        _raw_spin_lock_irqsave+0x3c/0x50
Jun 20 14:37:37 xz-x1 kernel:        dmar_insert_one_dev_info+0xbb/0x510
Jun 20 14:37:37 xz-x1 kernel:        domain_add_dev_info+0x50/0x90
Jun 20 14:37:37 xz-x1 kernel:        dev_prepare_static_identity_mapping+0x30/0x68
Jun 20 14:37:37 xz-x1 kernel:        intel_iommu_init+0xddd/0x1422
Jun 20 14:37:37 xz-x1 kernel:        pci_iommu_init+0x16/0x3f
Jun 20 14:37:37 xz-x1 kernel:        do_one_initcall+0x5d/0x2b4
Jun 20 14:37:37 xz-x1 kernel:        kernel_init_freeable+0x218/0x2c1
Jun 20 14:37:37 xz-x1 kernel:        kernel_init+0xa/0x100
Jun 20 14:37:37 xz-x1 kernel:        ret_from_fork+0x3a/0x50
Jun 20 14:37:37 xz-x1 kernel:
                              -> #0 (&(&iommu->lock)->rlock){+.+.}:
Jun 20 14:37:37 xz-x1 kernel:        lock_acquire+0x9e/0x170
Jun 20 14:37:37 xz-x1 kernel:        _raw_spin_lock+0x25/0x30
Jun 20 14:37:37 xz-x1 kernel:        domain_context_mapping_one+0xa5/0x4e0
Jun 20 14:37:37 xz-x1 kernel:        pci_for_each_dma_alias+0x30/0x140
Jun 20 14:37:37 xz-x1 kernel:        dmar_insert_one_dev_info+0x3b2/0x510
Jun 20 14:37:37 xz-x1 kernel:        domain_add_dev_info+0x50/0x90
Jun 20 14:37:37 xz-x1 kernel:        dev_prepare_static_identity_mapping+0x30/0x68
Jun 20 14:37:37 xz-x1 kernel:        intel_iommu_init+0xddd/0x1422
Jun 20 14:37:37 xz-x1 kernel:        pci_iommu_init+0x16/0x3f
Jun 20 14:37:37 xz-x1 kernel:        do_one_initcall+0x5d/0x2b4
Jun 20 14:37:37 xz-x1 kernel:        kernel_init_freeable+0x218/0x2c1
Jun 20 14:37:37 xz-x1 kernel:        kernel_init+0xa/0x100
Jun 20 14:37:37 xz-x1 kernel:        ret_from_fork+0x3a/0x50
Jun 20 14:37:37 xz-x1 kernel:
                              other info that might help us debug this:
Jun 20 14:37:37 xz-x1 kernel:  Possible unsafe locking scenario:
Jun 20 14:37:37 xz-x1 kernel:        CPU0                    CPU1
Jun 20 14:37:37 xz-x1 kernel:        ----                    ----
Jun 20 14:37:37 xz-x1 kernel:   lock(device_domain_lock);
Jun 20 14:37:37 xz-x1 kernel:                                lock(&(&iommu->lock)->rlock);
Jun 20 14:37:37 xz-x1 kernel:                                lock(device_domain_lock);
Jun 20 14:37:37 xz-x1 kernel:   lock(&(&iommu->lock)->rlock);
Jun 20 14:37:37 xz-x1 kernel:
                               *** DEADLOCK ***
Jun 20 14:37:37 xz-x1 kernel: 2 locks held by swapper/0/1:
Jun 20 14:37:37 xz-x1 kernel:  #0: 00000000033eb13d (dmar_global_lock){++++}, at: intel_iommu_init+0x1e0/0x1422
Jun 20 14:37:37 xz-x1 kernel:  #1: 00000000a681907b (device_domain_lock){....}, at: domain_context_mapping_one+0x8d/0x4e0
Jun 20 14:37:37 xz-x1 kernel:
                              stack backtrace:
Jun 20 14:37:37 xz-x1 kernel: CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.2.0-rc5 #78
Jun 20 14:37:37 xz-x1 kernel: Hardware name: LENOVO 20KGS35G01/20KGS35G01, BIOS N23ET50W (1.25 ) 06/25/2018
Jun 20 14:37:37 xz-x1 kernel: Call Trace:
Jun 20 14:37:37 xz-x1 kernel:  dump_stack+0x85/0xc0
Jun 20 14:37:37 xz-x1 kernel:  print_circular_bug.cold.57+0x15c/0x195
Jun 20 14:37:37 xz-x1 kernel:  __lock_acquire+0x152a/0x1710
Jun 20 14:37:37 xz-x1 kernel:  lock_acquire+0x9e/0x170
Jun 20 14:37:37 xz-x1 kernel:  ? domain_context_mapping_one+0xa5/0x4e0
Jun 20 14:37:37 xz-x1 kernel:  _raw_spin_lock+0x25/0x30
Jun 20 14:37:37 xz-x1 kernel:  ? domain_context_mapping_one+0xa5/0x4e0
Jun 20 14:37:37 xz-x1 kernel:  domain_context_mapping_one+0xa5/0x4e0
Jun 20 14:37:37 xz-x1 kernel:  ? domain_context_mapping_one+0x4e0/0x4e0
Jun 20 14:37:37 xz-x1 kernel:  pci_for_each_dma_alias+0x30/0x140
Jun 20 14:37:37 xz-x1 kernel:  dmar_insert_one_dev_info+0x3b2/0x510
Jun 20 14:37:37 xz-x1 kernel:  domain_add_dev_info+0x50/0x90
Jun 20 14:37:37 xz-x1 kernel:  dev_prepare_static_identity_mapping+0x30/0x68
Jun 20 14:37:37 xz-x1 kernel:  intel_iommu_init+0xddd/0x1422
Jun 20 14:37:37 xz-x1 kernel:  ? printk+0x58/0x6f
Jun 20 14:37:37 xz-x1 kernel:  ? lockdep_hardirqs_on+0xf0/0x180
Jun 20 14:37:37 xz-x1 kernel:  ? do_early_param+0x8e/0x8e
Jun 20 14:37:37 xz-x1 kernel:  ? e820__memblock_setup+0x63/0x63
Jun 20 14:37:37 xz-x1 kernel:  pci_iommu_init+0x16/0x3f
Jun 20 14:37:37 xz-x1 kernel:  do_one_initcall+0x5d/0x2b4
Jun 20 14:37:37 xz-x1 kernel:  ? do_early_param+0x8e/0x8e
Jun 20 14:37:37 xz-x1 kernel:  ? rcu_read_lock_sched_held+0x55/0x60
Jun 20 14:37:37 xz-x1 kernel:  ? do_early_param+0x8e/0x8e
Jun 20 14:37:37 xz-x1 kernel:  kernel_init_freeable+0x218/0x2c1
Jun 20 14:37:37 xz-x1 kernel:  ? rest_init+0x230/0x230
Jun 20 14:37:37 xz-x1 kernel:  kernel_init+0xa/0x100
Jun 20 14:37:37 xz-x1 kernel:  ret_from_fork+0x3a/0x50
--------------------------------------------

domain_context_mapping_one() is taking device_domain_lock first then
iommu lock, while dmar_insert_one_dev_info() is doing the reverse.

I digged a bit and I saw this commit which seems suspicous:

7560cc3ca7d9 ("iommu/vt-d: Fix lock inversion between iommu->lock and
              device_domain_lock", 2019-05-27)

More interestingly, it was trying to fix the inverted deadlock...

The thing is that even if above commit is correct on the ordering (I
still feel strange that we need to take a per-iommu lock before
another global lock), that commit seems to be an incomplete fix
because there's still other places that are using the other way round.

When I read deeper into that commit message, it seems to be telling me
that before reaching iommu_flush_dev_iotlb() we've got iommu lock
somewhere but I cannot really understand how it happened because I
cannot find a path that iommu lock is taken when reaching
iommu_flush_dev_iotlb().  So I cannot understand how that lockdep
warning message could trigger.

I reverted that commit and now everything is good here (no long runs
but at least previous deadlock issue is fixed).  And with that, IMHO
we'll actually have the correct ordering in the whole repository that
we'll take device_domain_lock before per iommu lock always.

Is there anything I've missed on why we have had 7560cc3ca7d9?

Thanks,

-- 
Peter Xu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
