Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D1F7C433F5
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 18:00:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 035AE610F9;
	Thu, 28 Apr 2022 18:00:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2iKJT9k6DA2a; Thu, 28 Apr 2022 18:00:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C778C607A3;
	Thu, 28 Apr 2022 18:00:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D07AC0039;
	Thu, 28 Apr 2022 18:00:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E175EC002D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 18:00:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DCB0E40160
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 18:00:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I1z3POEnC5JW for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 18:00:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D81A3400DA
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 18:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651168850; x=1682704850;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=gcCHMN2R3ZV830nUOD2eh8/g6lV0UH2wZKBz4H8GihI=;
 b=llZwwpajZY+WCUgakwDFiX/IntZ7A9cRtQrw1jMKMSoWrkzWxTLV0Du8
 2XiMyXGUkcLr6gep80CfZMRjTI/QZ84hVczB/i0KqsPYyrj6uAs5ndjVX
 88Xv0XNBJdYBRtxqkM5X8rxcMrZTXEqtT98tmu84hjGJnO94f+VC6RMPd
 oIv9FLjJ3rPSRRhSfvoIpp2A7YjqNn/eduO2Twtb2KA7L05ZFf/S47Jel
 EBYU51ZWrF6k8wNtOZgr8PvUmEMhr4HP/Du/mNGjxawBF+Sqp+k2o4m++
 N3tcyNme4UDADIo9V+A6WzKNGgtTNw+lupOz9gQ9GiGYE6Pse9ZO+cSO7 w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="266187421"
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; d="scan'208";a="266187421"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2022 11:00:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; d="scan'208";a="596910482"
Received: from fyu1.sc.intel.com ([172.25.103.126])
 by orsmga001.jf.intel.com with ESMTP; 28 Apr 2022 11:00:33 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Jean-Philippe Brucker" <jean-philippe@linaro.org>,
 "Borislav Petkov" <bp@alien8.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Zhangfei Gao" <zhangfei.gao@linaro.org>, "Will Deacon" <will@kernel.org>,
 "Robin Murphy" <robin.murphy@arm.com>, "Tony Luck" <tony.luck@intel.com>,
 "Jacob Pan" <jacob.jun.pan@linux.intel.com>,
 "Ravi V Shankar" <ravi.v.shankar@intel.com>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Andy Lutomirski" <luto@kernel.org>, "x86" <x86@kernel.org>,
 "linux-kernel" <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org
Subject: [PATCH v2] iommu/sva: Fix PASID use-after-free issue
Date: Thu, 28 Apr 2022 11:00:41 -0700
Message-Id: <20220428180041.806809-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Cc: Fenghua Yu <fenghua.yu@intel.com>
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

The PASID is being freed too early.  It needs to stay around until after
device drivers that might be using it have had a chance to clear it out
of the hardware.

As a reminder:

mmget() /mmput()  refcount the mm's address space
mmgrab()/mmdrop() refcount the mm itself

The PASID is currently tied to the life of the mm's address space and
freed in __mmput().  This makes logical sense because the PASID can't be
used once the address space is gone.

But, this misses an important point: even after the address space is
gone, the PASID will still be programmed into a device.  Device drivers
might, for instance, still need to flush operations that are outstanding
and need to use that PASID.  They do this at file->release() time.

Device drivers call the IOMMU driver to hold a reference on the mm itself
and drop it at file->release() time.  But, the IOMMU driver holds a
reference on the mm itself, not the address space.  The address space
(and the PASID) is long gone by the time the driver tries to clean up.
This is effectively a use-after-free bug on the PASID.

To fix this, move the PASID free operation from __mmput() to __mmdrop().
This ensures that the IOMMU driver's existing mmgrab() keeps the PASID
allocated until it drops its mm reference.

Fixes: 701fac40384f ("iommu/sva: Assign a PASID to mm on PASID allocation and free it on mm exit")

Reported-by: Zhangfei Gao <zhangfei.gao@foxmail.com>
Tested-by: Zhangfei Gao <zhangfei.gao@foxmail.com>
Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Suggested-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---

v2:
- Dave Hansen rewrites the change log.
- Add Tested-by: Zhangfei Gao <zhangfei.gao@foxmail.com>
- Add Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

The original patch was posted and discussed in:
https://lore.kernel.org/lkml/YmdzFFx7fN586jcf@fyu1.sc.intel.com/

 kernel/fork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 9796897560ab..35a3beff140b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -792,6 +792,7 @@ void __mmdrop(struct mm_struct *mm)
 	mmu_notifier_subscriptions_destroy(mm);
 	check_mm(mm);
 	put_user_ns(mm->user_ns);
+	mm_pasid_drop(mm);
 	free_mm(mm);
 }
 EXPORT_SYMBOL_GPL(__mmdrop);
@@ -1190,7 +1191,6 @@ static inline void __mmput(struct mm_struct *mm)
 	}
 	if (mm->binfmt)
 		module_put(mm->binfmt->module);
-	mm_pasid_drop(mm);
 	mmdrop(mm);
 }
 
-- 
2.32.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
