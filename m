Return-Path: <SRS0=Z7Xn=ZO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD96C432C3
	for <iommu@archiver.kernel.org>; Fri, 22 Nov 2019 03:08:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5990420679
	for <iommu@archiver.kernel.org>; Fri, 22 Nov 2019 03:08:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5990420679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0FC5F88A10;
	Fri, 22 Nov 2019 03:08:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A0BLF+R4n2Em; Fri, 22 Nov 2019 03:08:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 528C2889B0;
	Fri, 22 Nov 2019 03:08:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34BCFC1DD8;
	Fri, 22 Nov 2019 03:08:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14CF4C18DA
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 03:08:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id F155B870D2
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 03:08:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0UkQIftg5pz1 for <iommu@lists.linux-foundation.org>;
 Fri, 22 Nov 2019 03:08:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 489B08709E
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 03:08:22 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 21 Nov 2019 19:08:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,228,1571727600"; d="scan'208";a="232540432"
Received: from allen-box.sh.intel.com ([10.239.159.136])
 by fmsmga004.fm.intel.com with ESMTP; 21 Nov 2019 19:08:19 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 0/5] iommu/vt-d: Consolidate various cache flush ops
Date: Fri, 22 Nov 2019 11:04:44 +0800
Message-Id: <20191122030449.28892-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Intel VT-d 3.0 introduces more caches and interfaces for software to
flush when it runs in the scalable mode. Currently various cache flush
helpers are scattered around. This consolidates them by putting them in
the existing iommu_flush structure.

/* struct iommu_flush - Intel IOMMU cache invalidation ops
 *
 * @cc_inv: invalidate context cache
 * @iotlb_inv: Invalidate IOTLB and paging structure caches when software
 *             has changed second-level tables.
 * @p_iotlb_inv: Invalidate IOTLB and paging structure caches when software
 *               has changed first-level tables.
 * @pc_inv: invalidate pasid cache
 * @dev_tlb_inv: invalidate cached mappings used by requests-without-PASID
 *               from the Device-TLB on a endpoint device.
 * @p_dev_tlb_inv: invalidate cached mappings used by requests-with-PASID
 *                 from the Device-TLB on an endpoint device
 */
struct iommu_flush {
        void (*cc_inv)(struct intel_iommu *iommu, u16 did,
                       u16 sid, u8 fm, u64 type);
        void (*iotlb_inv)(struct intel_iommu *iommu, u16 did, u64 addr,
                          unsigned int size_order, u64 type);
        void (*p_iotlb_inv)(struct intel_iommu *iommu, u16 did, u32 pasid,
                            u64 addr, unsigned long npages, bool ih);
        void (*pc_inv)(struct intel_iommu *iommu, u16 did, u32 pasid,
                       u64 granu);
        void (*dev_tlb_inv)(struct intel_iommu *iommu, u16 sid, u16 pfsid,
                            u16 qdep, u64 addr, unsigned int mask);
        void (*p_dev_tlb_inv)(struct intel_iommu *iommu, u16 sid, u16 pfsid,
                              u32 pasid, u16 qdep, u64 addr,
                              unsigned long npages);
};

The name of each cache flush ops is defined according to the spec section 6.5
so that people are easy to look up them in the spec.

Best regards,
Lu Baolu

Lu Baolu (5):
  iommu/vt-d: Extend iommu_flush for scalable mode
  iommu/vt-d: Consolidate pasid cache invalidation
  iommu/vt-d: Consolidate device tlb invalidation
  iommu/vt-d: Consolidate pasid-based tlb invalidation
  iommu/vt-d: Consolidate pasid-based device tlb invalidation

 drivers/iommu/dmar.c        |  61 ---------
 drivers/iommu/intel-iommu.c | 246 +++++++++++++++++++++++++++++-------
 drivers/iommu/intel-pasid.c |  39 +-----
 drivers/iommu/intel-svm.c   |  60 ++-------
 include/linux/intel-iommu.h |  39 ++++--
 5 files changed, 244 insertions(+), 201 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
