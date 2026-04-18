Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013065.outbound.protection.outlook.com [40.93.201.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BA5271A71
	for <iommu@lists.linux.dev>; Sat, 18 Apr 2026 23:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776555722; cv=fail; b=lm9LOd3YJjmW9xv6p2oDligkLIvmqAQR8uBVjXDNdas9OII68q6liKnR+1p967ZWXbxS3KNaXdqSyiYp6ZjhgzfTsEORt+A08vhwfi6HbvSWgdmQ3I0m50unmhjX7Mbte+TknwerqsyX6YCmDXmcXxWv1xF+TbkFSZXsykrSdz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776555722; c=relaxed/simple;
	bh=s/sEuPI5iul2pB0P0Fv4cqUoU/31AMDnsIJlHETHE7Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nwKuoyAiQbpP7s44AgBxGkrFYOkWaY6xPStadYDBMogyZdcktEf0Aqvii8br6lyhK5kXePbTUz8NS0+fRPC/hcMZEeJHKScwayLPq1TkJ5klQB+0Cg1Q671jzpdkmS1xAbFI9Su0axZF2KN+KoFfOb1SuywWm1Uf54HwVSCvxS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qEGRc6i2; arc=fail smtp.client-ip=40.93.201.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qEGRc6i2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ShrfuL6yD0zt9UYrFYvCeuDccfBv3boq/eCaEcmrwUDYUvlFWMYmIGyixImmzv4hupiLo1gvmo8yCtM1os7RBI2EShDFJX+sQUl/33XPQZsIoiYG71GJapD6LmYCCXKQ9722MFbrBO7EilagbkAk4HxBRt5Zbh+C4ZmIXs//B5xOedkWP/p3kC9LM18iDaVXgjHLf7+SPm8Cw7LOsFL57fuNsv0URbvm7kpWrPmh2EwIQLFgAaO+a+BgXPuNQMEf5Neh3uJoeoLGhklBW2oc9Jrf1/mZsDhYBADkuLY9ObQwfRu8WPiwsDg3JgZBvK7Y3reqlfFYA2BW6XwAlHAP6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bxPqLlMuj1Si0oG0TJZeNAeQOJMNRDxdokGfgl5mps=;
 b=ujMcJezH/WuNGXTlLh3WKjPBG4ttSD2vQoY4kzOTitPfsWUs84UUeNRO7fN8KPWQlYEHkj0FOvqk3Qtr2aMpjS3o0FoCeJiCYJx6vcSXFwDjoQ4y3hlJuQQ0xGOW7olZsg4n8s/pr5fzHSFmg1Jn+yqvvkPAt/2IL+Y0WdqZpOqtZJcQ4zWzp3z2kgQUp01apNy2B5QiUfK9W8j81Xt40owFssg+rNeoVwl3D6k5kWlX5HGBxr0bzYjEdSrPazkhTtNjPOjvHtT7ChfxNXhfE3Ae9Cjcnuk1DJtvMZnYN3dPGIOUmp4akLPPvYSkUjBDFq1pislG/zFtnqzLDofamg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bxPqLlMuj1Si0oG0TJZeNAeQOJMNRDxdokGfgl5mps=;
 b=qEGRc6i22DwG6mrzWhMAV3NalgnAcTn9wbrMvmNcIcWi/rXgsUCAT26v3t8Sj/TLmTxuuaNTVPPgApH0lVwAWuIRN1mfjB7fJ3asD+gaY2AvoKAuEelqGhVn3dJo/GaayyhGpYNATCGqYvvNC5xgNmKUffV9pjEh/r9tbtAic+o03lwFj6Ie3TzyhEEfCXu1cIoHuatb1GpWEIlvTGs8o09ssXojjCZi13AnX6xnucPSZdjfzGojIn9++/3FJSpQGegJ4ihOTcKH9lRpPavcXbILw2T10nNz7kWm9EKvwR/UMTSSqY8oOC0Qll7GmZu37fqU7cNYncgRQaPbEVDhPA==
Received: from BYAPR03CA0012.namprd03.prod.outlook.com (2603:10b6:a02:a8::25)
 by LV3PR12MB9410.namprd12.prod.outlook.com (2603:10b6:408:212::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Sat, 18 Apr
 2026 23:41:56 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:a02:a8:cafe::56) by BYAPR03CA0012.outlook.office365.com
 (2603:10b6:a02:a8::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.55 via Frontend Transport; Sat,
 18 Apr 2026 23:41:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Sat, 18 Apr 2026 23:41:56 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 18 Apr
 2026 16:41:49 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sat, 18 Apr 2026 16:41:48 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sat, 18 Apr 2026 16:41:48 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <joro@8bytes.org>, <kevin.tian@intel.com>, <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<xueshuai@linux.alibaba.com>
Subject: [PATCH rc v7 3/6] iommu: Fix pasid attach in pci_dev_reset_iommu_prepare/done()
Date: Sat, 18 Apr 2026 16:41:34 -0700
Message-ID: <3f1b73fa5162e55ffbe497508aeea1fc7cee6e2c.1776551790.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1776551790.git.nicolinc@nvidia.com>
References: <cover.1776551790.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|LV3PR12MB9410:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c54046f-1860-4bc7-1124-08de9da413a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|13003099007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	rCtzkPR+XLFqwbw688KPU8WH/3ut2nGh2bAb/ZWFFMQMKaKC++7epCPwaf5s7ErbvkNNhpYHjGqRqmafqqbkP8iqpjYCEYrS40krct0vFD/QzmyEdQEsEa70d22dcGHCZupRBz0Q0ijnc5GaqNQ6LtjLPS/iNB6mIsHZ/t6e4UPOEbOvhi5ls/BecklxBBOMZGvTz62ddFASju8oxsiFKKb8QnVD71XRzh/9NENXX835guMG0hD7UAbueMV8B7h8R78RlI2TNyxlRtfSJgcBnuR7WE+hTa/aQ+9NSIdFK/hOFw41AbDhjco2efIq2vLO9f0Eq5dgtceV1bb8Yjg4ZLtxL/FpZN/G5L38gsAXsw4m8RTe2Q6WV04i6fR4fs2Fkuy4gEyR2Vj5cb5Ogh6ZRhGTWTUXrdxn30004NjQP7sBR0TrZNJvYPSl561i8Nq/1g1w/b3jC2cb6fZGUtlSpoOLXtTAeMG2EvP/J4L0lajNKpD4nIWStqI6o9bTkQrigncJXiS/Xzvwhm2XUf+OoGOdVYLGL8jvvf8ue4PU7anjbBqNDO4npEvrwx2wbyYvi/w6GtbJD0fwgQ657lsPInBQwS63STpG3/P0KRnO1NnGClqWJ+qluKPrXXrStskR5yTKTXK7/Dsp/0DjTL4xE573HE6qKwfQC2zS0PCITqHUPwKUBjwy46O5Ypac5UJYGXyUbFENoaKeC76Me92G/CLDOuhkovgYOs845nAdyT39ATjGwGX3su18tBoJ1CFWFwAxhDROPZ/tK7lXzfsVTA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(13003099007)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	faHvzf4w44D8c9WEeQvZCzwe7RV3Ohat7EVwz5MKdopBf9YcZ7XMt7Ta+S+RCyrIIt4tCf4jDAh8ZVqT7ywPtCgyOiKPIZq6efHxTrkgvn19d2FVw8O3NgzXTZInzp6xk8mm+K0ZE4OwB6qn26r5TW2KH3fzd+X+id68077AoL+kSyPNo203fuAoQdIohm+0+nogvFcaAoq5gTFE2w5hPuOb015LdgktR/RdXWiDqz+Xp6Yh9sn0t189c2x1En2BTm2qNZ0V28J6BT1tjZyYxLC5MQ1zw56UaQgy0QM/9+Pa+JwgxbYnIURbtSQZINpNwaqMbcZxIV1ejKjuf1z6PXvpgA59HjeE6h0IIThAAPfLBvZa2BGe2oSUexVckCbV58Bl1O/LDBrGKfzjsDqgtfFyF7J5hX+lLt1tb69AVEn4ZrCxHkViZTvl+j19PviJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2026 23:41:56.1924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c54046f-1860-4bc7-1124-08de9da413a5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9410

Now the helpers handle per-gdev resets. So use the per-device API properly
to attach/detach PASIDs. Also add max_pasids check as other callers.

Fixes: c279e83953d9 ("iommu: Introduce pci_dev_reset_iommu_prepare/done()")
Cc: stable@vger.kernel.org
Reported-by: Shuai Xue <xueshuai@linux.alibaba.com>
Closes: https://lore.kernel.org/all/ad858513-09fc-455e-bbc5-fe38a225cc78@linux.alibaba.com/
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d5d9102b9d750..e9ffa562b614f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -4026,9 +4026,14 @@ int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
 	 * The pasid_array is mostly fenced by group->mutex, except one reader
 	 * in iommu_attach_handle_get(), so it's safe to read without xa_lock.
 	 */
-	xa_for_each_start(&group->pasid_array, pasid, entry, 1)
-		iommu_remove_dev_pasid(&pdev->dev, pasid,
-				       pasid_array_entry_to_domain(entry));
+	if (pdev->dev.iommu->max_pasids > 0) {
+		xa_for_each_start(&group->pasid_array, pasid, entry, 1) {
+			struct iommu_domain *pasid_dom =
+				pasid_array_entry_to_domain(entry);
+
+			iommu_remove_dev_pasid(&pdev->dev, pasid, pasid_dom);
+		}
+	}
 
 	group->recovery_cnt++;
 	return ret;
@@ -4090,10 +4095,16 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 	 * The pasid_array is mostly fenced by group->mutex, except one reader
 	 * in iommu_attach_handle_get(), so it's safe to read without xa_lock.
 	 */
-	xa_for_each_start(&group->pasid_array, pasid, entry, 1)
-		WARN_ON(__iommu_set_group_pasid(
-			pasid_array_entry_to_domain(entry), group, pasid,
-			group->blocking_domain));
+	if (pdev->dev.iommu->max_pasids > 0) {
+		xa_for_each_start(&group->pasid_array, pasid, entry, 1) {
+			struct iommu_domain *pasid_dom =
+				pasid_array_entry_to_domain(entry);
+
+			WARN_ON(pasid_dom->ops->set_dev_pasid(
+				pasid_dom, &pdev->dev, pasid,
+				group->blocking_domain));
+		}
+	}
 
 	if (!WARN_ON(group->recovery_cnt == 0))
 		group->recovery_cnt--;
-- 
2.43.0

