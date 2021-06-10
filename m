Return-Path: <SRS0=Vfdp=LE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC01FC48BCD
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 02:04:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B934A613BC
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 02:04:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B934A613BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8368960886;
	Thu, 10 Jun 2021 02:04:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LwQMF1HjQEed; Thu, 10 Jun 2021 02:04:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4C87C6062B;
	Thu, 10 Jun 2021 02:04:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29339C000E;
	Thu, 10 Jun 2021 02:04:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4CAA9C000E
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 02:04:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2E53840599
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 02:04:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c2FZVCRS-339 for <iommu@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 02:04:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DED6840542
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 02:04:15 +0000 (UTC)
IronPort-SDR: jA1Rq8TMjjHc6yoyJpCWTu836rMwRoOFMa3FueFdBwS5FzQAmPygQ8EXqRKeT6wqmhfGN9JwvO
 iup4yqZ2YB+g==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="202184327"
X-IronPort-AV: E=Sophos;i="5.83,262,1616482800"; d="scan'208";a="202184327"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2021 19:03:57 -0700
IronPort-SDR: YnzVUK56a625pV2xGaQ38fF4MG6XSPriJApDJVzgEu7wB+1eF0XetUOq5ieqoTzdcnv5HlVz4j
 YjuQXDZ2WeQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,262,1616482800"; d="scan'208";a="402500545"
Received: from allen-box.sh.intel.com ([10.239.159.105])
 by orsmga006.jf.intel.com with ESMTP; 09 Jun 2021 19:03:53 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 19/23] iommu/vt-d: Use bitfields for DMAR capabilities
Date: Thu, 10 Jun 2021 10:01:11 +0800
Message-Id: <20210610020115.1637656-20-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610020115.1637656-1-baolu.lu@linux.intel.com>
References: <20210610020115.1637656-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Fenghua Yu <fenghua.yu@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Aditya Srivastava <yashsri421@gmail.com>, Randy Dunlap <rdunlap@infradead.org>,
 YueHaibing <yuehaibing@huawei.com>,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 iommu@lists.linux-foundation.org, Colin Ian King <colin.king@canonical.com>,
 Will Deacon <will@kernel.org>
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

From: Parav Pandit <parav@nvidia.com>

IOTLB device presence, iommu coherency and snooping are boolean
capabilities. Use them as bits and keep them adjacent.

Structure layout before the reorg.
$ pahole -C dmar_domain drivers/iommu/intel/dmar.o
struct dmar_domain {
        int                        nid;                  /*     0     4 */
        unsigned int               iommu_refcnt[128];    /*     4   512 */
        /* --- cacheline 8 boundary (512 bytes) was 4 bytes ago --- */
        u16                        iommu_did[128];       /*   516   256 */
        /* --- cacheline 12 boundary (768 bytes) was 4 bytes ago --- */
        bool                       has_iotlb_device;     /*   772     1 */

        /* XXX 3 bytes hole, try to pack */

        struct list_head           devices;              /*   776    16 */
        struct list_head           subdevices;           /*   792    16 */
        struct iova_domain         iovad __attribute__((__aligned__(8)));
							 /*   808  2320 */
        /* --- cacheline 48 boundary (3072 bytes) was 56 bytes ago --- */
        struct dma_pte *           pgd;                  /*  3128     8 */
        /* --- cacheline 49 boundary (3136 bytes) --- */
        int                        gaw;                  /*  3136     4 */
        int                        agaw;                 /*  3140     4 */
        int                        flags;                /*  3144     4 */
        int                        iommu_coherency;      /*  3148     4 */
        int                        iommu_snooping;       /*  3152     4 */
        int                        iommu_count;          /*  3156     4 */
        int                        iommu_superpage;      /*  3160     4 */

        /* XXX 4 bytes hole, try to pack */

        u64                        max_addr;             /*  3168     8 */
        u32                        default_pasid;        /*  3176     4 */

        /* XXX 4 bytes hole, try to pack */

        struct iommu_domain        domain;               /*  3184    72 */

        /* size: 3256, cachelines: 51, members: 18 */
        /* sum members: 3245, holes: 3, sum holes: 11 */
        /* forced alignments: 1 */
        /* last cacheline: 56 bytes */
} __attribute__((__aligned__(8)));

After arranging it for natural padding and to make flags as u8 bits, it
saves 8 bytes for the struct.

struct dmar_domain {
        int                        nid;                  /*     0     4 */
        unsigned int               iommu_refcnt[128];    /*     4   512 */
        /* --- cacheline 8 boundary (512 bytes) was 4 bytes ago --- */
        u16                        iommu_did[128];       /*   516   256 */
        /* --- cacheline 12 boundary (768 bytes) was 4 bytes ago --- */
        u8                         has_iotlb_device:1;   /*   772: 0  1 */
        u8                         iommu_coherency:1;    /*   772: 1  1 */
        u8                         iommu_snooping:1;     /*   772: 2  1 */

        /* XXX 5 bits hole, try to pack */
        /* XXX 3 bytes hole, try to pack */

        struct list_head           devices;              /*   776    16 */
        struct list_head           subdevices;           /*   792    16 */
        struct iova_domain         iovad __attribute__((__aligned__(8)));
							 /*   808  2320 */
        /* --- cacheline 48 boundary (3072 bytes) was 56 bytes ago --- */
        struct dma_pte *           pgd;                  /*  3128     8 */
        /* --- cacheline 49 boundary (3136 bytes) --- */
        int                        gaw;                  /*  3136     4 */
        int                        agaw;                 /*  3140     4 */
        int                        flags;                /*  3144     4 */
        int                        iommu_count;          /*  3148     4 */
        int                        iommu_superpage;      /*  3152     4 */

        /* XXX 4 bytes hole, try to pack */

        u64                        max_addr;             /*  3160     8 */
        u32                        default_pasid;        /*  3168     4 */

        /* XXX 4 bytes hole, try to pack */

        struct iommu_domain        domain;               /*  3176    72 */

        /* size: 3248, cachelines: 51, members: 18 */
        /* sum members: 3236, holes: 3, sum holes: 11 */
        /* sum bitfield members: 3 bits, bit holes: 1, sum bit holes: 5 bits */
        /* forced alignments: 1 */
        /* last cacheline: 48 bytes */
} __attribute__((__aligned__(8)));

Signed-off-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20210530075053.264218-1-parav@nvidia.com
---
 include/linux/intel-iommu.h |  8 ++++----
 drivers/iommu/intel/iommu.c | 18 +++++++++---------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index f5cf31dd7280..2621eff04c82 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -546,7 +546,10 @@ struct dmar_domain {
 					 * domain ids are 16 bit wide according
 					 * to VT-d spec, section 9.3 */
 
-	bool has_iotlb_device;
+	u8 has_iotlb_device: 1;
+	u8 iommu_coherency: 1;		/* indicate coherency of iommu access */
+	u8 iommu_snooping: 1;		/* indicate snooping control feature */
+
 	struct list_head devices;	/* all devices' list */
 	struct list_head subdevices;	/* all subdevices' list */
 	struct iova_domain iovad;	/* iova's that belong to this domain */
@@ -558,9 +561,6 @@ struct dmar_domain {
 	int		agaw;
 
 	int		flags;		/* flags to find out type of domain */
-
-	int		iommu_coherency;/* indicate coherency of iommu access */
-	int		iommu_snooping; /* indicate snooping control feature*/
 	int		iommu_count;	/* reference count of iommu */
 	int		iommu_superpage;/* Level of superpages supported:
 					   0 == 4KiB (no superpages), 1 == 2MiB,
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 65458aee0d95..430ef2232d47 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -626,12 +626,12 @@ static void domain_update_iommu_coherency(struct dmar_domain *domain)
 	bool found = false;
 	int i;
 
-	domain->iommu_coherency = 1;
+	domain->iommu_coherency = true;
 
 	for_each_domain_iommu(i, domain) {
 		found = true;
 		if (!iommu_paging_structure_coherency(g_iommus[i])) {
-			domain->iommu_coherency = 0;
+			domain->iommu_coherency = false;
 			break;
 		}
 	}
@@ -642,18 +642,18 @@ static void domain_update_iommu_coherency(struct dmar_domain *domain)
 	rcu_read_lock();
 	for_each_active_iommu(iommu, drhd) {
 		if (!iommu_paging_structure_coherency(iommu)) {
-			domain->iommu_coherency = 0;
+			domain->iommu_coherency = false;
 			break;
 		}
 	}
 	rcu_read_unlock();
 }
 
-static int domain_update_iommu_snooping(struct intel_iommu *skip)
+static bool domain_update_iommu_snooping(struct intel_iommu *skip)
 {
 	struct dmar_drhd_unit *drhd;
 	struct intel_iommu *iommu;
-	int ret = 1;
+	bool ret = true;
 
 	rcu_read_lock();
 	for_each_active_iommu(iommu, drhd) {
@@ -666,7 +666,7 @@ static int domain_update_iommu_snooping(struct intel_iommu *skip)
 			 */
 			if (!sm_supported(iommu) &&
 			    !ecap_sc_support(iommu->ecap)) {
-				ret = 0;
+				ret = false;
 				break;
 			}
 		}
@@ -4506,8 +4506,8 @@ static int md_domain_init(struct dmar_domain *domain, int guest_width)
 	adjust_width = guestwidth_to_adjustwidth(guest_width);
 	domain->agaw = width_to_agaw(adjust_width);
 
-	domain->iommu_coherency = 0;
-	domain->iommu_snooping = 0;
+	domain->iommu_coherency = false;
+	domain->iommu_snooping = false;
 	domain->iommu_superpage = 0;
 	domain->max_addr = 0;
 
@@ -5131,7 +5131,7 @@ static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
 static bool intel_iommu_capable(enum iommu_cap cap)
 {
 	if (cap == IOMMU_CAP_CACHE_COHERENCY)
-		return domain_update_iommu_snooping(NULL) == 1;
+		return domain_update_iommu_snooping(NULL);
 	if (cap == IOMMU_CAP_INTR_REMAP)
 		return irq_remapping_enabled == 1;
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
