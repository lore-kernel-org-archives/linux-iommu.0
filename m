Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012002.outbound.protection.outlook.com [40.107.200.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20145199920
	for <iommu@lists.linux.dev>; Sat, 11 Jul 2026 00:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783731198; cv=fail; b=H8S2r09c5v4w8WkA8SGGlqryaeKAx+LEUBJJ9MaeKhOtxvh5x2zi1vCOkSazpQtigecXg8xD5pFkSFUB/hPyl2FBfbm+EKIlB4ROgCZo/cNknWy/WYuTpEIXREAcQy7QptQYmqhijblV3Qt5Im3O0dcds98BPFc90QGRkzm0Wz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783731198; c=relaxed/simple;
	bh=rdKjKizq4zTSthTtNIFo6jdT7qhPuNHEwuanmNkP3zM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kbsnPRzdC274QyCJIEqHSa0K1e136YXIPVRniSN+IAVOVRbEgthXDdH+oWITIeRiGpAIa6b+CSAf7PZ7fuQ1BsHIngwr7b6jh9EnVZV+ujD5ewNGz+vdBtpRvlxwaLhd7WmCy515omfh9uPsMNU+lur/tW7QdVtpxCNOC66vNYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dakR2vwx; arc=fail smtp.client-ip=40.107.200.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dakR2vwx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZikPOyLR0ldhJsJoyF3ZskgDSintBOiI36w8Q/B+Hb6gnifLLp0JvrAGxWfNHUDTWU5GmdXSxQuf8L2Y3kEQQGWdWigV1WIw5aJXVn7+UVa3rfA+8rL6lnlM3GPtXnlCNSHh2fkVikY3UBm3hDmL9hwUL5+9W4Jxg2zwWP3J9uJ8NYSahzqfPam1QAiJKmnbn7Wto5amzmlHUTcN8jHwaRKer7fK0l8xor1DJeWwKHlzkD0R4KsLp1sZVISFYIhnqr4VLSSkhptLd52HTWUvJ92MUkJHbDN5MMeoM+Ug7T10YTJqlPz7WpPEf9apcz/fv1p72+ZDBS29Tz21A71EpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3uqZAf7qxqdfpkgt8ilhQ9CoD/4sK7elysVgFiXLPI=;
 b=EAYVGt5pAudj6CLFxXUzojXTn5Lq13FFudJ6nmMTZhq7+pMFPgsUd/rAq+9of5DPgZmWWmBOa5XKQoxNjTiL/QwHnNxGthudUZBLAots0AezYvn6povlSWqOqTc34MaDvkYfAFebN+JVUSlC4Y7ixlSYhVo99XFDO3EwRWzpqZcGvBr4bbyc9ufqmCoZuSNCdCoUz/arKiweotKkqZ6VLhv2H8INTk7C4faEiDkeDgAEdx+A2kYpHyBUO+L3L9xs+Cu8R4nd1KNSq2cJaaMx7czRWtGmRveI8/pi1zJFttT3RX79pE4kLNEi8fhjxKgpV8Hhcl7JnzvaCWtCESd4oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3uqZAf7qxqdfpkgt8ilhQ9CoD/4sK7elysVgFiXLPI=;
 b=dakR2vwxUwgZHVFSPMPPuC5FPFe2Dy5KBd0zkEyKNcfsVhR9RLZVqvQYrKpGyBmcg/RKHB8Yb1VZ+p1EsSmrrUmvJTIAMlGFdT9tXmxWLDBDVbWaxYnXeHEijJ9ExuOt3LlcAB/PsBbb+cfw/KGJqClwv/MjVKUelrBaY/WkHmIZuB2kAm184e94AiD9jsQuojbrjbx9jBC6d+0qTl8OU9Vvke+0H66uPS8DNbt7L2HaqmmrfQL4IQ298gWUCQfdSouyKWENwRIc1lLV5ykMznNfPDyN5P6J3dmY5r7c04r7aHhUGp7M1If5YnMJKXUGgtP2flDFnq7+eUL/XfI7fQ==
Received: from SJ0PR13CA0078.namprd13.prod.outlook.com (2603:10b6:a03:2c4::23)
 by SJ2PR12MB8955.namprd12.prod.outlook.com (2603:10b6:a03:542::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Sat, 11 Jul
 2026 00:53:11 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::1c) by SJ0PR13CA0078.outlook.office365.com
 (2603:10b6:a03:2c4::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.6 via Frontend Transport; Sat, 11
 Jul 2026 00:53:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Sat, 11 Jul 2026 00:53:08 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 10 Jul
 2026 17:52:57 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 10 Jul
 2026 17:52:57 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 10 Jul 2026 17:52:56 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kevin.tian@intel.com>,
	<smostafa@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH v8 2/9] iommu/arm-smmu-v3: Skip EVTQ/PRIQ setup in kdump kernel
Date: Fri, 10 Jul 2026 17:52:43 -0700
Message-ID: <327616f41b75c5b3d4bb0b4575627b86b6586887.1783729633.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783729633.git.nicolinc@nvidia.com>
References: <cover.1783729633.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|SJ2PR12MB8955:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f3c391d-9fef-4ea2-3100-08dedee6c662
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	iIZJ4Ms2fAZWgpvBx0DU6yE401Eo8FqM/P2jZ58b2sEUs46G8pA2QCanoASm7bRlKxkEi4zbmcBVYY2F4iyvzfdOS9Z4Ag9TlxcAfCNktD+EXsmspVn63ewUPWtVy8g3fos2LP6/cxOSBG1W/JhZqaV+oDzKYLIaS6bTFxNPVahMlmH/x+bKTbnkkjFg8wzMcj+aIcM2RhubZcriWgzAnKI/oLs6EuME2G4n+lrFzZgdW1XwzdoY93zhaDOZEJCv2slpW/A4HveQO9pujBO5cy88eGHcyoPGXenoOxF7TkN18MT5wBpVKotVICmqIuqYjpxBweyh9mUKl+dYIeffxfPWFIhgbUJOp3Kdp1reXCDlJqXyj5BcH0HeT3VgWVLku4/SR/WO85cmWdkLqFmzh/Y290ceSA3vPKysAJ48rP5v8rGb6bsEEEkMvTjr+KEtLEcqmXtE2yi4fUMJ8TplfWGIb/5JDGxEicp+x6g9Hl7MFap9c87b3XfhhHQls/smAuvaAzH4W2dLeT/NbDP8J5jB4d+hLxjXb41X4C3VEYUd9ki1945jIuqby6rI8UzAV9HMwPTcn2K6V1N3dDw50uiBJMCAgzyQYAHon1oiPN4dXLaL05Wmh3rUanRUybSq48VVSEq1NtNSXBmduqhpipB96cie7GiElbidZfHk5EC4OasT+NGZrFs0Y5i0rixy1uVUDLIbsp8TlmXf86w8oA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	P+K5Qwd8/7Pnw3YEQZbhIJDxTKTidalLsW+Oiv6oDSx0SKwwGl5ne1ItbrMpMyRxp9LsoT1Uy2eGNZzKf/IyST5IoKSKjyBcdHWs7ys8SiO559NuLZYsJMKGKVgl6P3Op2PjJh4NimwvJEYbOMXMVCX3frBi1KVS2/ZDkC/ZBXbYYBgJ1RUo1KaKj6pvJ+I4S2ejTgBKEnpTpk+t7G/VJKgy5VjIK1GiblANOlHNuvy1Z5QHYw4CPzZDd2tAOxCs04JCtEolBtB5YJ1zOCm3gjQYb2Raqkr3vClKzrHwgG/eKZB9nQJmBroAnLea0rMYDy1YZwEpTSSGXIWOpCKr0V6kMJoSUPsWQnHB4SQzZ3zhza1bP3dP9haFtQ/ffFwduDFjqDH5EcryqMVmfbyp47FfsgYfwAX5DkTNt3Jjlu1s7q+ObcMpJdPiTBuwKBWb
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2026 00:53:08.5039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f3c391d-9fef-4ea2-3100-08dedee6c662
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8955

In kdump cases, the crashed kernel's CDs and page tables can be corrupted,
which could trigger event spamming. Also, we cannot serve page requests.

Skip the EVTQ/PRIQ setup entirely rather than enabling then disabling them.

Keep the queue allocations themselves, as their Q_MAX_SZ_SHIFT-capped sizes
are negligible against a crashkernel reservation.

Also add some inline comments explaining that.

Suggested-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 44 +++++++++++++--------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 404790d2c7210..175964b923716 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4821,21 +4821,36 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	arm_smmu_cmdq_issue_cmd_with_sync(
 		smmu, arm_smmu_make_cmd_op(CMDQ_OP_TLBI_NSNH_ALL));
 
-	/* Event queue */
-	writeq_relaxed(smmu->evtq.q.q_base, smmu->base + ARM_SMMU_EVTQ_BASE);
-	writel_relaxed(smmu->evtq.q.llq.prod, smmu->page1 + ARM_SMMU_EVTQ_PROD);
-	writel_relaxed(smmu->evtq.q.llq.cons, smmu->page1 + ARM_SMMU_EVTQ_CONS);
-
-	enables |= CR0_EVTQEN;
-	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
-				      ARM_SMMU_CR0ACK);
-	if (ret) {
-		dev_err(smmu->dev, "failed to enable event queue\n");
-		return ret;
+	/*
+	 * Event queue
+	 *
+	 * Do not enable in a kdump case, as the crashed kernel's CDs and page
+	 * tables might be corrupted, triggering event spamming. A disabled
+	 * queue simply discards new events, without raising any global error.
+	 */
+	if (!is_kdump_kernel()) {
+		writeq_relaxed(smmu->evtq.q.q_base,
+			       smmu->base + ARM_SMMU_EVTQ_BASE);
+		writel_relaxed(smmu->evtq.q.llq.prod,
+			       smmu->page1 + ARM_SMMU_EVTQ_PROD);
+		writel_relaxed(smmu->evtq.q.llq.cons,
+			       smmu->page1 + ARM_SMMU_EVTQ_CONS);
+
+		enables |= CR0_EVTQEN;
+		ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
+					      ARM_SMMU_CR0ACK);
+		if (ret) {
+			dev_err(smmu->dev, "failed to enable event queue\n");
+			return ret;
+		}
 	}
 
-	/* PRI queue */
-	if (smmu->features & ARM_SMMU_FEAT_PRI) {
+	/*
+	 * PRI queue
+	 *
+	 * Do not enable in a kdump case, as we cannot serve page requests.
+	 */
+	if (!is_kdump_kernel() && (smmu->features & ARM_SMMU_FEAT_PRI)) {
 		writeq_relaxed(smmu->priq.q.q_base,
 			       smmu->base + ARM_SMMU_PRIQ_BASE);
 		writel_relaxed(smmu->priq.q.llq.prod,
@@ -4868,9 +4883,6 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 		return ret;
 	}
 
-	if (is_kdump_kernel())
-		enables &= ~(CR0_EVTQEN | CR0_PRIQEN);
-
 	/* Enable the SMMU interface */
 	enables |= CR0_SMMUEN;
 	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
-- 
2.43.0

