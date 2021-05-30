Return-Path: <SRS0=A9HU=KZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B2FC47089
	for <iommu@archiver.kernel.org>; Sun, 30 May 2021 07:51:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C9E561108
	for <iommu@archiver.kernel.org>; Sun, 30 May 2021 07:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C9E561108
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2FEAE403F4;
	Sun, 30 May 2021 07:51:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tkbpd4jdfCEP; Sun, 30 May 2021 07:51:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 33633403F3;
	Sun, 30 May 2021 07:51:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 039D5C000F;
	Sun, 30 May 2021 07:51:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E379C0001
 for <iommu@lists.linux-foundation.org>; Sun, 30 May 2021 07:51:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B1A3D403D2
 for <iommu@lists.linux-foundation.org>; Sun, 30 May 2021 07:51:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G3SALS80FL_a for <iommu@lists.linux-foundation.org>;
 Sun, 30 May 2021 07:51:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::627])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E6C68403DC
 for <iommu@lists.linux-foundation.org>; Sun, 30 May 2021 07:51:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QrgQ0/2jAVJoie4Xv5OvndvFT5pgFzvj8Qh9xuxyONMmuyP/6XybROZ+RcZ4LMqmxxrCX1NqPUulE9FmZSiK+mGK3kjfBVi/CE/v4sYW5XORb6r6RyX0QEAn5IvbEy5jQzR+qfh81S0BwDxJv8FxPUHn+bsD/ClkIqejzOa/Pb11MqgN+d2h5rTqMEy4yxTMcdYTlA1XUFl/sB7So4kZ1jd7V72ujNI/j+0lRFigUDUAL2owNjNPxL4RSLv3CICTYP51sDVybfqSuHR4dItOh0cyXBl1BFp8rj5Bg7YTf9YhVYLAfG9vXL772GcrYBb6CgU4C5qGyiUH2t9m9KdNgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mz8XHVDiZXtvhQEfutwsyMut0+Ahv0K9+uKnOp8LWPQ=;
 b=QvfpOfhl6hKPCbu/1tniAhcIVHsGVR3HGu/QIdYv7FBM6ggTlz5wbmmN6h3C5rjN+q+eBvRr41QLCFtkM2YvASCBetwVoUxF3DRdEyqIfufUAVC62UuzuQ+QZopFtMZnGzoiSSHI1tw36PWXVQYqrZzZOo9yA4QVtp9gUHi5niFOaa2ADW4C5msqX358wIV8ZPpfcMFQavKQCeLEBS0mh6mdM6H8F7ozNb0culddeYd6Mx4fHsKIBTsSZNm0BrCyyuFIatKuCpQVZz58enl+H6UVWamIPDF3zxQMKQ/c5fIkI/H9GSR8DJYgMJ2a17H8h4uEDpiyAwU4svGY3L5Y6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mz8XHVDiZXtvhQEfutwsyMut0+Ahv0K9+uKnOp8LWPQ=;
 b=izZPUcB/NIRCJe+BG4YR8J9jOgGVgD6BqsCccgZp03WyN4a2bQrhoHHZrK2leOA3RncRosqxnceJOH/RLB3b3tStvye7xn4rg8ipcomQqS1R8MIEaP7xL3S92gxOtdlE/9qcLWWccFIHYr6iQRO9y3aJLw91wA+hzFoHn7gnvQdLURMn6B7O2Ib248cJzZLXEj7lTSNlggNfxjXHxUUG0YC6IJkyZ6LG1do9ciTCjXtadNJFz3m5eIseGp3l+Gad8whn2ZVdA8eT4DOd+YtfY3y18uCK0YvoZYIOfZWF9WFdZoNpeUfL4od58CcN1iHLzNNzUzCYLzIi8scfvABuAw==
Received: from BN8PR15CA0013.namprd15.prod.outlook.com (2603:10b6:408:c0::26)
 by BL0PR12MB4708.namprd12.prod.outlook.com (2603:10b6:208:8d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Sun, 30 May
 2021 07:51:12 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::17) by BN8PR15CA0013.outlook.office365.com
 (2603:10b6:408:c0::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Sun, 30 May 2021 07:51:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; 8bytes.org; dkim=none (message not signed)
 header.d=none;8bytes.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Sun, 30 May 2021 07:51:12 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Sun, 30 May 2021 07:51:11 +0000
From: Parav Pandit <parav@nvidia.com>
To: <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH 1/5] iommu/intel: Use bitfields for DMAR capabilities
Date: Sun, 30 May 2021 10:50:49 +0300
Message-ID: <20210530075053.264218-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210530075053.264218-1-parav@nvidia.com>
References: <20210530075053.264218-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6712caf6-c442-4c18-770c-08d9233fb209
X-MS-TrafficTypeDiagnostic: BL0PR12MB4708:
X-Microsoft-Antispam-PRVS: <BL0PR12MB47083AC99878EDC2D4BC5313DC209@BL0PR12MB4708.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X2JknHfF5y66fn4k5SRSfMwsmQE9jaEVbyG5zloJpwcfB2hKhxiwOtxI6fpTO15YtEf9FZHOFvWh88G0zTaiA3ezcvIz0DqzTteXoP/8LJDyntFutbHls7qa3ufYnkWuaYlczG7pJTc8R5itFZJI+F507pJTKbCY+KJF7MTmPlKavtzWSOg+D/dbTVfJJy5w+hPP7Z4TMGIFId+yYVZCO2VQuXtr685iYq4nFJRG6b1mwco9MHmMT2mpk86KQMfyMbOcd7TCKnpkSx0IfP7mzQSnwg/PDO4Qx2HYyYb7nKTHxCIMc7NoTRpKeCxHhW68MZMz2K2NphwtBewoPHe621LWl93PgNsTsUTj0zKTRTo+t/HLW8sqj3F5IW5h3Jbn6L9qW4FfIQGF23QLIdbddJoVJVbNxay3uprUaphjLMzxVjby5BRKfpcXyK0uuqY1BzyinxzK+yV4D7c31UErEjSTNqsa7W+m9w85j/mF3PK1qgb3aKe7owhtGiBsKrva3+LP8XykVqPiYzQPH5YDr2m92UgK0HGvS6dYa4rsVT0WkzguXK/q8W6NcEjMl01FcSF+9wkTBlENLL9YgLL5j5Nzzs2SkCyAZYlA9hBqa/i2RTHXjIyi+N6OYwO6ISiRWDcwSvTqOSZySiROTnrfLe8ScAvS/BhvkIURLcZwohMnnTtInmk4Vgs7r333N8Ei
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(39860400002)(376002)(36840700001)(46966006)(36756003)(2906002)(47076005)(70586007)(1076003)(16526019)(82310400003)(36906005)(316002)(54906003)(8936002)(86362001)(356005)(478600001)(7636003)(26005)(82740400003)(4326008)(83380400001)(6666004)(336012)(426003)(186003)(70206006)(107886003)(110136005)(8676002)(5660300002)(2616005)(36860700001)(21314003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2021 07:51:12.4713 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6712caf6-c442-4c18-770c-08d9233fb209
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4708
Cc: will@kernel.org
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
        struct iova_domain         iovad __attribute__((__aligned__(8))); /*   808  2320 */
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
        struct iova_domain         iovad __attribute__((__aligned__(8))); /*   808  2320 */
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
---
 drivers/iommu/intel/iommu.c | 18 +++++++++---------
 include/linux/intel-iommu.h |  8 ++++----
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 708f430af1c4..cdbf4513df9d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -625,12 +625,12 @@ static void domain_update_iommu_coherency(struct dmar_domain *domain)
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
@@ -641,18 +641,18 @@ static void domain_update_iommu_coherency(struct dmar_domain *domain)
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
@@ -665,7 +665,7 @@ static int domain_update_iommu_snooping(struct intel_iommu *skip)
 			 */
 			if (!sm_supported(iommu) &&
 			    !ecap_sc_support(iommu->ecap)) {
-				ret = 0;
+				ret = false;
 				break;
 			}
 		}
@@ -4508,8 +4508,8 @@ static int md_domain_init(struct dmar_domain *domain, int guest_width)
 	adjust_width = guestwidth_to_adjustwidth(guest_width);
 	domain->agaw = width_to_agaw(adjust_width);
 
-	domain->iommu_coherency = 0;
-	domain->iommu_snooping = 0;
+	domain->iommu_coherency = false;
+	domain->iommu_snooping = false;
 	domain->iommu_superpage = 0;
 	domain->max_addr = 0;
 
@@ -5124,7 +5124,7 @@ static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
 static bool intel_iommu_capable(enum iommu_cap cap)
 {
 	if (cap == IOMMU_CAP_CACHE_COHERENCY)
-		return domain_update_iommu_snooping(NULL) == 1;
+		return domain_update_iommu_snooping(NULL);
 	if (cap == IOMMU_CAP_INTR_REMAP)
 		return irq_remapping_enabled == 1;
 
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 03faf20a6817..2153c6cbef7e 100644
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
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
