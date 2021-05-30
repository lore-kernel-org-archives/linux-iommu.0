Return-Path: <SRS0=A9HU=KZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A181C47091
	for <iommu@archiver.kernel.org>; Sun, 30 May 2021 07:51:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25D606052B
	for <iommu@archiver.kernel.org>; Sun, 30 May 2021 07:51:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25D606052B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E9C5B83A83;
	Sun, 30 May 2021 07:51:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 59YmT3HFPITh; Sun, 30 May 2021 07:51:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 42554839DB;
	Sun, 30 May 2021 07:51:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21F7AC000F;
	Sun, 30 May 2021 07:51:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C687FC0001
 for <iommu@lists.linux-foundation.org>; Sun, 30 May 2021 07:51:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A352E606AA
 for <iommu@lists.linux-foundation.org>; Sun, 30 May 2021 07:51:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CT8SoPVtzu-W for <iommu@lists.linux-foundation.org>;
 Sun, 30 May 2021 07:51:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2078.outbound.protection.outlook.com [40.107.95.78])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 730B160611
 for <iommu@lists.linux-foundation.org>; Sun, 30 May 2021 07:51:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qyazt8aY8Aoo3fsiSHo0D5JtC1kcw1xP57H/0ycaO65d01blim4PtgBXCVljktVwHVOXtg9Skfoa4CGlSk4DLnnDe1eF5TM6Bqre+XeahUp3CpDinUbmJ9Nv6wKvyd+OFTP7rJyM629dNcigVtfx0idGxGPtTEJjEyxH1a1yvWJWOSxx4wCl9JykCoOUdWcdFyhUcpMmsE3XJ/hWpg+dtFul/hW80UVdfRy5zqVJfDzNiYrj5DvtkJIioeyZJf4xj2RVfaSY51PBwzA3mMhUowHiZJ9GT7KWaisKRFEJoOUeiZ88awUvBCDBGp32uDE+I9QR+OvzsplDIKNBPIA/7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyTU/mfeiohh5yAg2UBmQgzw2czuXS8+Er107jxnbSE=;
 b=R59JzuZ4sa98xDeInEuqpz5AUGwR0Grsl09GDsFwSfVVpe+2pQSVgTjafq0Yopc9lL/H9/RPJgbjeCYfXfSmB9s2bl87b1km5UOazeB9azUDZAGan3dY1wMsINvp5n/rokqUQWdAZzncGLoMY+2RdN2D276QNMSuWUEpGd3Sl97sx5BUR68l86rzSLKdq0h3yEeonx8tfZgAWweTe1YJ6rwCCelERLWAXDQoQuIsP+JKD7nx+J1XdvhIkVgBYRl82VsCz+PdGqe4LlY+GXH5UjolkDoSVUFWXx7bxKi3j9+Pr5Im3D2EpsYad92hkLtweFLmW9Y4xHwf6ZJaSPGtGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyTU/mfeiohh5yAg2UBmQgzw2czuXS8+Er107jxnbSE=;
 b=fE12qyLJJXi+0EFIZSSb5Tl2xeGt1DNiC2BTZtMN0eAAti36OMRBH68HcQi9MzEOK8PhqOraUTPpoNlIQYbKW139krKQyQCUDTL49z+wTGjxycQLGxJJIYwTOkit9OJfxBLCcqAFMq1en3XM9WMAr1cAUtI0WtrpWGOz2aXD1h56W8RZHaAJkCLQs8033hAVm6Du3nyazfY4Hry2BiJZR7F42L49scwDCUuKZ2QI+eI3c+hrLJl+6hQUth5bU+aVu4oevTUpwGSvd8sa/oc0R0M/jaPjA3uc2CNcyAiwEIwGuQzZb2pTljJhtAHQcDAZkyS/1+2ncgxCDDEqK+xNPw==
Received: from BN8PR15CA0015.namprd15.prod.outlook.com (2603:10b6:408:c0::28)
 by CH0PR12MB5074.namprd12.prod.outlook.com (2603:10b6:610:e1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Sun, 30 May
 2021 07:51:14 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::6f) by BN8PR15CA0015.outlook.office365.com
 (2603:10b6:408:c0::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Sun, 30 May 2021 07:51:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; 8bytes.org; dkim=none (message not signed)
 header.d=none;8bytes.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Sun, 30 May 2021 07:51:14 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Sun, 30 May 2021 07:51:11 +0000
From: Parav Pandit <parav@nvidia.com>
To: <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH 2/5] iommu/intel: Removed unused iommu_count in dmar domain
Date: Sun, 30 May 2021 10:50:50 +0300
Message-ID: <20210530075053.264218-3-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210530075053.264218-1-parav@nvidia.com>
References: <20210530075053.264218-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85ccb133-1870-44e7-d334-08d9233fb2f7
X-MS-TrafficTypeDiagnostic: CH0PR12MB5074:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5074035787F32AE8A03DC13ADC209@CH0PR12MB5074.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p02DE81eWJxmNJrbhJ8o0cOykKXeZ50teMKYEqkCONDSpZpqikSPXqMfLGrTLi6mK9F3YUlemVwMsPWVEU4764AhKa/vAFBdQtt4DbSSj/bVh4BV4bPMWenRfC16Si3pmWTMtt8udopTmX30PXDDA6fNkKsQXtgrmhBViyRYLLQoMDFiizaEPs6o9e6UmYD554uwPpbdEEMhx5TugNxqXy7Hi/+2H/N7qCwaD0ItfNMg3D4AYMttZAIGFF1I+J8AVf0xi3wFM5Twc8DUnDZMAtYc/uJnw83hpfR5DMnRy1HDfSkz5hnIWf8l20mTtBvjot0nLLG8sWgIzh6U969ksu/bHNnDjHSOI22xVfhW5bICF7lIDl8JG2Kt8XvFgsPWaTAIRmqWLmLGvQzNR+xMwiWurwQEgsNkzQ4q4ekiaTk/Sp6/d0J8q8zFRViOKecXv75IXJ1yNLj3oaeYp5SKXZ6RQAaz5+2t7eMropZ0Sm+JM64juW9Nmi2OLkmU7CRmO7u4EBxcBSpRRcSZdl+wlEnAIzlA6lWEDRnXRC57mO966MsisWPd+PjwEVuAFXwsKrnJOHoduYPmXX5C+MSNk07myijj1cIIBZBLqG/pPEcNVHIQ5t8/i102/eg8JK3WbGbz4837gIs+YdNJee0B9xC5IbhOqWNEUJJJNn4pad4=
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(46966006)(36840700001)(36860700001)(86362001)(36756003)(16526019)(186003)(8676002)(54906003)(1076003)(7636003)(356005)(110136005)(2616005)(426003)(70206006)(5660300002)(2906002)(47076005)(336012)(83380400001)(6666004)(478600001)(82310400003)(70586007)(82740400003)(8936002)(26005)(107886003)(4326008)(36906005)(316002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2021 07:51:14.0404 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ccb133-1870-44e7-d334-08d9233fb2f7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5074
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

DMAR domain uses per DMAR refcount. It is indexed by iommu seq_id.
Older iommu_count is only incremented and decremented but no decisions
are taken based on this refcount. This is not of much use.

Hence, remove iommu_count and further simplify domain_detach_iommu()
by returning void.

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 drivers/iommu/intel/iommu.c | 11 +++--------
 include/linux/intel-iommu.h |  1 -
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index cdbf4513df9d..51be77c48108 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1919,7 +1919,6 @@ static int domain_attach_iommu(struct dmar_domain *domain,
 	assert_spin_locked(&iommu->lock);
 
 	domain->iommu_refcnt[iommu->seq_id] += 1;
-	domain->iommu_count += 1;
 	if (domain->iommu_refcnt[iommu->seq_id] == 1) {
 		ndomains = cap_ndoms(iommu->cap);
 		num      = find_first_zero_bit(iommu->domain_ids, ndomains);
@@ -1927,7 +1926,6 @@ static int domain_attach_iommu(struct dmar_domain *domain,
 		if (num >= ndomains) {
 			pr_err("%s: No free domain ids\n", iommu->name);
 			domain->iommu_refcnt[iommu->seq_id] -= 1;
-			domain->iommu_count -= 1;
 			return -ENOSPC;
 		}
 
@@ -1943,16 +1941,15 @@ static int domain_attach_iommu(struct dmar_domain *domain,
 	return 0;
 }
 
-static int domain_detach_iommu(struct dmar_domain *domain,
-			       struct intel_iommu *iommu)
+static void domain_detach_iommu(struct dmar_domain *domain,
+				struct intel_iommu *iommu)
 {
-	int num, count;
+	int num;
 
 	assert_spin_locked(&device_domain_lock);
 	assert_spin_locked(&iommu->lock);
 
 	domain->iommu_refcnt[iommu->seq_id] -= 1;
-	count = --domain->iommu_count;
 	if (domain->iommu_refcnt[iommu->seq_id] == 0) {
 		num = domain->iommu_did[iommu->seq_id];
 		clear_bit(num, iommu->domain_ids);
@@ -1961,8 +1958,6 @@ static int domain_detach_iommu(struct dmar_domain *domain,
 		domain_update_iommu_cap(domain);
 		domain->iommu_did[iommu->seq_id] = 0;
 	}
-
-	return count;
 }
 
 static inline int guestwidth_to_adjustwidth(int gaw)
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 2153c6cbef7e..50a006cc8c05 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -561,7 +561,6 @@ struct dmar_domain {
 	int		agaw;
 
 	int		flags;		/* flags to find out type of domain */
-	int		iommu_count;	/* reference count of iommu */
 	int		iommu_superpage;/* Level of superpages supported:
 					   0 == 4KiB (no superpages), 1 == 2MiB,
 					   2 == 1GiB, 3 == 512GiB, 4 == 1TiB */
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
