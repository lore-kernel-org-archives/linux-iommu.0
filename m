Return-Path: <SRS0=KWJS=QG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB692C433FE
	for <iommu@archiver.kernel.org>; Fri, 19 Nov 2021 07:27:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF601617E3
	for <iommu@archiver.kernel.org>; Fri, 19 Nov 2021 07:27:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AF601617E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 49E7381CAD;
	Fri, 19 Nov 2021 07:27:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sOAUsY2xFKsS; Fri, 19 Nov 2021 07:27:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 841C981D11;
	Fri, 19 Nov 2021 07:27:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6799C003F;
	Fri, 19 Nov 2021 07:27:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C6D82C0012
 for <iommu@lists.linux-foundation.org>; Fri, 19 Nov 2021 07:27:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C259261BDB
 for <iommu@lists.linux-foundation.org>; Fri, 19 Nov 2021 07:27:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SF-6fOkZ_yKU for <iommu@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 07:27:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::611])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0C7FD605FF
 for <iommu@lists.linux-foundation.org>; Fri, 19 Nov 2021 07:27:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yb7arpSxG08qvRlL6yZIkk587yu1ixW5qbeAwpPZG1hVnkqYQsdKWj6YbL6wd8dJqB4o2zz7rpULqfFVTW0g/HX4HQM7UxR8R2tmimjgs0BpNmwpdQESFYXtVnQKSNakSEcrcSpTuIbh5hDMi8LqbW4AjmX0yfeE4QRV4V5TU7DLZOF9ud9H/vc20fpwxQKORV9ZWENilpwLHlH//W1ouhruP/iTgZNDigN8f/BKlM7JB2L8IFFwoh4bH4YcDklNcbN27ESaSPt8xu+WQkNl0Xy4srbtigILiYX49Kceixcfrr6H7rueLORmcS4CNPf7DI8NoXWxDB10ygkseFsoNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FCQuTRlxOn6XcYrGbcqc9ZJWKlLkdN4TwjtWXL80snE=;
 b=deon+cU0RUMd/5/1Dg7iK8lA+4aNu66GlszY2t2vqCPkl9A2FoLOqDboqsIsA6+8ybtu3mFW/kaOcpkBRPn0aLeXxjA8t4pcvkYY/n5kqh6CNulDw+KO7tCtBVGoZgChAb79N3HfNfiksFgIJQFPcO2u3k1Hkz0A38FabQ6RlJFIlfnI/5USDPHFYtzCVClgwwIU7+/8VABaZP6o+uLppFYC2FqBxFWUPgkUvPHwmemaQZGjtAgMs5yT3gZOtO4Sd1kFJwDEltKlovHPXNtZLIYZkyEUR+1dHmF44b61QZ+B/QlEZIGf1LgHp26MXrVXK8/QHxtOcZ1dwTo/yQoH+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCQuTRlxOn6XcYrGbcqc9ZJWKlLkdN4TwjtWXL80snE=;
 b=UV6QM/EieYZUDr4eCmtg4YyVOuB/uRbtxc5h1D3eQXzyRinkRxN+qyPawejT/oZwN1L4xo+G4uJd252ijUBS/QZ4j3kMiVScXOSdvFuwrh41C1UEgDicrxoNM2YYVAJ5KeR47AVjvx4YPxo4B6VdN6Tk87hqVBCek/NfuqEhyx4SQLUotbzsIYEdsrFUTDEdD4+BBMoAN7nY1L/e+ClseCMbpAarrVCik0HPVAgb1OSqvNrgdy9qedD8afYUOWqpZIo3I4kWdOh7ZDMycom9dZ7NcFfvnGJv2k77WFxIXzpREpBHv1BwmclmdR9w8Cp1oukMaxF6gOdXnDkdj3xeVg==
Received: from DM6PR08CA0044.namprd08.prod.outlook.com (2603:10b6:5:1e0::18)
 by MN2PR12MB4223.namprd12.prod.outlook.com (2603:10b6:208:1d3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 19 Nov
 2021 07:27:37 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::4) by DM6PR08CA0044.outlook.office365.com
 (2603:10b6:5:1e0::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend
 Transport; Fri, 19 Nov 2021 07:27:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 07:27:37 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 19 Nov
 2021 07:27:36 +0000
Received: from Asurada-Nvidia.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Fri, 19 Nov 2021 07:27:36 +0000
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
Subject: [PATCH v3 2/5] iommu/arm-smmu-v3: Make arm_smmu_cmdq_init reusable
Date: Thu, 18 Nov 2021 23:19:56 -0800
Message-ID: <20211119071959.16706-3-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211119071959.16706-1-nicolinc@nvidia.com>
References: <20211119071959.16706-1-nicolinc@nvidia.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6bc2af9-d686-4246-4e11-08d9ab2e101b
X-MS-TrafficTypeDiagnostic: MN2PR12MB4223:
X-Microsoft-Antispam-PRVS: <MN2PR12MB422330411894C3FF36E66859AB9C9@MN2PR12MB4223.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PiepUiWlsgJFSHSgoVIzblT859f33ot+emXh/ax4Izxh14p/7gyPNI5H8XKUdql5Pi0BoYMrwgj0FZ3eumKDoY+0c72USfo/FDUoG21GO8qA2U25jFDxoTnqmEsQ/gFJ6FlXo7I5YWkhzX9a3p9uBenODlOZTEnZpS2ZCIDuO64l0nSfMLmyJemi2FamiflcBeEPRNjJzwBd8tpkEcM6N8QQ9UH9nMebTgd+FbfJwJmkAm+wul0A/6MS3+pdMzVmHaHEhfiFchCEPJPA+e2QXCOxmKdBxmTnZYCiPz4ngAOJ6O7cH0lY/o6uHofRjCTSlXPDX0bdNSjRJaLKWOiAWduT/l/wLDyXWtu/Hj/lux1o/gyCbSfpfn2ZO8RI9EIaN7BrQOVkaf/oeGija3drq5h5qzJZEM3SvKSoILNDeKtf62MJJ+Rxbl9+cBLeoSCvagLD2NbNnlwFj18/QxqaazUcQaPrpVddDH1UQEg7PvS4iMan9KV5v/LBJrnGrFd4qw3EtaDprVl5twd3IvsjymFInm/a6ECQeJi30diRpujhYtEAhZrKL7aEkdFEBWFX4wgIEnwLAX0f44T4dG+sjknRX3Z4nAWdsudfC2CYx5TiORZHG2VxMNjlv+I//lmQixFx836HWTtNXBMLGFtjLaavi3kB44CHr26d1hpRutqfT3Re/yG16rYC5ZMD1xk8KaDiurMN/uv8D7QzlISCaQ==
X-Forefront-Antispam-Report: CIP:216.228.112.36; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid05.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(26005)(86362001)(508600001)(107886003)(83380400001)(7416002)(36906005)(5660300002)(47076005)(336012)(6666004)(7696005)(2906002)(1076003)(4326008)(70586007)(110136005)(7636003)(36756003)(426003)(356005)(8676002)(82310400003)(2616005)(186003)(54906003)(8936002)(70206006)(36860700001)(316002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 07:27:37.5146 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6bc2af9-d686-4246-4e11-08d9ab2e101b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.36];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4223
Cc: jean-philippe@linaro.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
 thierry.reding@gmail.com, jgg@nvidia.com, linux-arm-kernel@lists.infradead.org
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
From: Nicolin Chen via iommu <iommu@lists.linux-foundation.org>
Reply-To: Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The CMDQV extension in NVIDIA Grace SoC resues the arm_smmu_cmdq
structure while the queue location isn't same as smmu->cmdq. So,
this patch adds a cmdq argument to arm_smmu_cmdq_init() function
and shares its define in the header for CMDQV driver to use.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 6 +++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index e6fee69dd79c..6be20e926f63 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2922,10 +2922,10 @@ static void arm_smmu_cmdq_free_bitmap(void *data)
 	bitmap_free(bitmap);
 }
 
-static int arm_smmu_cmdq_init(struct arm_smmu_device *smmu)
+int arm_smmu_cmdq_init(struct arm_smmu_device *smmu,
+		       struct arm_smmu_cmdq *cmdq)
 {
 	int ret = 0;
-	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
 	unsigned int nents = 1 << cmdq->q.llq.max_n_shift;
 	atomic_long_t *bitmap;
 
@@ -2955,7 +2955,7 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 	if (ret)
 		return ret;
 
-	ret = arm_smmu_cmdq_init(smmu);
+	ret = arm_smmu_cmdq_init(smmu, &smmu->cmdq);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 7a6a6045700d..475f004ccbe4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -751,6 +751,8 @@ void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
 bool arm_smmu_free_asid(struct arm_smmu_ctx_desc *cd);
 int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
 			    unsigned long iova, size_t size);
+int arm_smmu_cmdq_init(struct arm_smmu_device *smmu,
+		       struct arm_smmu_cmdq *cmdq);
 
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
