Received: from OS6P279CU014.outbound.protection.outlook.com (mail-norwayeastazon11020075.outbound.protection.outlook.com [52.101.178.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057653CFF7D
	for <iommu@lists.linux.dev>; Wed,  1 Apr 2026 11:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.178.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775042451; cv=fail; b=qu7zEZAU7Q8sRQBvyYvr8eWShvd9PKKQIEDa+Enu/vXz7oxFoO/sucmMpQNlXU4/LXoLu8oLHYbv0MHXro6nYPXwwUzamGPMhZ9C/9J4NYAnreZwFzEoLow2UJeT8+3EkCgSxq/Wwmbsjx6Fl/Mun6+TfPEyv3pf+aSscwDDdNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775042451; c=relaxed/simple;
	bh=Ax9QfRtBpPquzPE4Bc+NcPVOP2CacDnMSxsr76SHcd0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bsnkhJizHVMdpeqQ32H3yg3WRNQVvcrMW978F8bmsrJi60TjFwiy+Tl6jLhSZ7keWgwv2Ixlgnk1V08Ak9wMa3Wo6ByCyv6oXI/A4s95w/rCOPprj5kiMn6GBj6zwv/oJK+lbV0ULVRX5cz8K45/jDZevB4mqzqkQOgaED1oclI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolphinics.com; spf=pass smtp.mailfrom=dolphinics.com; dkim=pass (2048-bit key) header.d=dolphinics.com header.i=@dolphinics.com header.b=pZQyZtok; arc=fail smtp.client-ip=52.101.178.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolphinics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolphinics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolphinics.com header.i=@dolphinics.com header.b="pZQyZtok"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qMNOsbLrm3p6IAwIL3YRZDyI3mhPuc9rTCieAa3N9YVd0dcPmpdKk0xiK++LL1ps7Asjiyg4CGQOd0BNXV61/4xuAGZsNBDXHu+Q2VfNw8yicbah1HZWIYGXD6espTO4B4oYRjcK0FFZA9U6GiyqEy69UNr8kl+x2v9SLirL4jTx1g6UsUa4PG+CAY2s7lfSlVfBE5u+nAuhoKZox5ORmsGUBBYebNw6xnuQb8MIwtQTjVXHQFyi4xmh1SgwfgMdLXx8s5itFq2eLa8bU1aJQblSS4vzKBt0MKLhXpd4TvCyI54GAvGZ3b682m0wJ57bSvdGSvk4/2bFOHQn5HoVvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45/7pJDxUDaqzDW/5VSzb+vFN6gL6HrTpV4pGp1gN9I=;
 b=bYSzL0kA4yw3BBJ/0TQ/09I/VB/HLQCBRF9RNZ5UUVl5p96sMqHV0bqwvU3dieWujIvot8/IsO3JdonlLzyT7bJgKV7yKNzjn4qpVUTyC3A4wwNHE8lXgNkoAUFRGZT3+47qw2aQXgyVVFZLNxVlLgIGzQozSPiy0irNCMtuTx6iv0rT/9KqZBO1NJCUix85bTkVDYbIHC7C/taxcEQVLhKQnEcUjEIsuUQQbZGo3Ijoac80J1vR/ThjiBr7MgpCaTr2e8k6lo5lCITuSXpwCkAq4qb74aaei3BkeHcCMxOzAyRXmyuLg/EU/bDbe4mO4tB34XUuunciOE7Mnu9QGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dolphinics.com; dmarc=pass action=none
 header.from=dolphinics.com; dkim=pass header.d=dolphinics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolphinics.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45/7pJDxUDaqzDW/5VSzb+vFN6gL6HrTpV4pGp1gN9I=;
 b=pZQyZtokly5kK2+YzXcsRmvxWsfbSkWr8wMeQadR3HWHDnr7yYYWZYBIQxpo6dhOyzcYgZ8pE7UBlPH48Q+AAdqeEHJVzVQFgEPOnOHXT9Bhx3jPKknraenDyq1oFTT7n/iWgiJ/q0dtbu+cWVw0bJZlUwzaJDy+07Q+pDSwDFxM9mQeLFLHOyKIeorYG54nLM5+3w0zkpHPErNmYSdSp7MRuwUvVY2ZS4mKXuUuyRQIj6BZGHJWeHGwdPxRTny2N5PJM8kBvtt+7y/Uq69+G7UKqtNb3Hd13hm088g/eewEpUHdtqjaBav+RHeWV824a4R5exhwcE8n9Hy9E7wPKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dolphinics.com;
Received: from OLAP279MB0055.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:2::7) by
 SV0P279MB0658.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:21::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17; Wed, 1 Apr 2026 11:20:45 +0000
Received: from OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 ([fe80::c82b:8ba6:653a:2875]) by OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 ([fe80::c82b:8ba6:653a:2875%3]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 11:20:44 +0000
From: Magnus Kalland <magnus@dolphinics.com>
To: vasant.hegde@amd.com,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	linux-kernel@vger.kernel.org,
	suravee.suthikulpanit@amd.com
Cc: dhsrivas@amd.com,
	jonas@dolphinics.com,
	larsk@dolphinics.com,
	magnus@dolphinics.com,
	torel@simula.no
Subject: [PATCH v4] iommu/amd: Invalidate IRT cache for DMA aliases
Date: Wed,  1 Apr 2026 13:19:22 +0200
Message-ID: <20260401112021.76806-1-magnus@dolphinics.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: OS6P279CA0152.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:39::9) To OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:2::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OLAP279MB0055:EE_|SV0P279MB0658:EE_
X-MS-Office365-Filtering-Correlation-Id: 53d2ba94-d62a-455c-2b3c-08de8fe0b772
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	gE24XyycA0wHs1xUNrmSIRtvetK04c/Ml6KnwherAqO/GvnU1oefC2QVaniTcbbNQ/OBhY1C6fsVqqPTQ33Jr5OeDVEJQSHOt4a4CFBsQwkLZ99laf3IqCrtXLXfOTxzQl63VI4ISoP9AJr87CtUPApQaNHELey17K+cMSFhL7upTQyV/DgjyaxTkB+8bYvgzAhtPGIEgZI9jF47Bn0VvG4srIRFbLKB6F6E0b+/WIB1AkclPprr8k094mtTHnBbMQwnxo5gQqxLYjwwkig11Go20GAx/gx9cl+8N7t2QIdmo9S0LTLZX8PipU2a8c5yjzcu6RYspvrMHQmZy2XuhvHGFUim6a2Qfx8LDhyp8rVvBx1SLN5w42qod109DcCAYHM9k0T5MXHAoDQFMfM9sn6sdRM7CkWMQsSC+PbsTJAzw2g2YEmIhKW01TF6+YYSZD3KfT1aNp72rieMm71CIcv7PdbERZTyyh+dtkVvx7QXB/k09WHKIhpgDMaXuV5/F5PlrKtKNi6SpkFfJV3JYuRG8oTPCLyKKskyfRTf1rqAbn9iFhudLiTqaPW4RfRmc3EywNDnG3xYhqV1860RyiPHpQVDqWm9FTI+0AKq2GYZE7uzYeKUvQ5g7vAR2JJG4QPV9IITcs8vyV0ObToyQkkn14TAWJsCG3+2+eEnkZPXRhVwHup+uKDpdAm2H2wN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OLAP279MB0055.NORP279.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v0mX0iXOtjIxP21UewsbfrfFXv7RiFE0lbTD7hb3grf4d/ig40S7YWQsvd5H?=
 =?us-ascii?Q?mSNMYhibHA9qSIk9QvWO7cHCStEshpK9RlldtHdJ4hhoYFHh/IcZuuVshaR8?=
 =?us-ascii?Q?RRbl7l1jkOe8egOCW4O1KNGiKdXuF3r62/aSizx3ItPJeD4VGVrmGIoOi/zm?=
 =?us-ascii?Q?tWEIoQL3+Adl+gfzNn4+pv7ejWw9cvXLrMTw11TePo3cJ8m8QfQqB7nuK4Ww?=
 =?us-ascii?Q?U6dnGxRqcBaXWr9Uvzezl52MjWitnQxPyS1XgAufDT/ZE1zs22wxkKo2snG1?=
 =?us-ascii?Q?GdUlc+CfzrBG1AadNix75CI6ER94yKIGvMLgcPJv8jSL2ObzeSeQgY/pnH8u?=
 =?us-ascii?Q?8uIVXeEcLLJAtD3IYII7BiCIxlp81nGTmBx83nYJYB6Yuw4NokjDkFkdReKw?=
 =?us-ascii?Q?AFEot7vM6C6YUCALQ/WKHzkcgb+wFZVrn291pwVgi8yU5Ivs7wJyFQ6zkYPx?=
 =?us-ascii?Q?EyYGuWqhZVZr0qXItn6f6JS29GVoNg88UzqKy1LVqIzWAyS0ro2ospxmEIf2?=
 =?us-ascii?Q?Vn6aZ49ayV92mWqEeKI1fbALY2ZOcNJjW8UGbiZgfmykFpICRPDjCNwlzw9X?=
 =?us-ascii?Q?U89OD8I2kju+e9IkEsny7J1wwRG26E38WMnGivN1QvZlDgUX6o6p25iYmb20?=
 =?us-ascii?Q?ClHQs42wPlP2XD9VxdOrzEMQZXdFIt4O3EWBrmiZbBmkF76zta30iknfpB65?=
 =?us-ascii?Q?1DvfgnPBD9d1Gb3/Hlym5aXzTy/smADNKeJd6Do61El8fNRVGPBTTvkZawrI?=
 =?us-ascii?Q?3vS5oJ58sT5pM3CZGMvU506pHiJhElO7AMk2tSnnfSboub0q5Qe8hyNm+mUr?=
 =?us-ascii?Q?o9Sc5ikUgsEfsbEB6B6dm/gTVxn9Dr3cKj1rW/CAhtpkxiUE47MoK1wMCv3+?=
 =?us-ascii?Q?1o3GZakm/rpjVE+hma4nJRERUOHeNE+ME3dnN9AlfJzgAkHAh+2vORXpPDdj?=
 =?us-ascii?Q?cmNBgmgGeQIF4pucZVNvpIJnNlR0fRRPzl84tBAXDxHXYrEzRqiCpW0YD4up?=
 =?us-ascii?Q?uXWo8lcTynBO142zMM91Z1bFXz0pwggMFTTHTLTJnOKxc3pmlwj0Yvp7ttjh?=
 =?us-ascii?Q?ee5rdgY8NtndwCM6mPTLKgeJL2MlVJZ0Usse8WdJJhMxRmcjdjWmt+7T0a7k?=
 =?us-ascii?Q?8qHDzAw3tZEpls1EMQRRpb8LfpExcZikoR4UC+iwfpQiGm1Tt1A4ATU1MwZw?=
 =?us-ascii?Q?FJadNgdlVoTvtkUX4uQgQ0tkfKAAI59FL188CblIlR7hfyKpbPsQ31b0A1fi?=
 =?us-ascii?Q?okeKiaDz+8qsSq+VNSXayft+HtPVBigsiwFFjEXXhlO1i4iHEi/FV/icNhT2?=
 =?us-ascii?Q?fpxsFNsBfnc0KgZyfgN5I1nIwJjDqlHMf7pDUfABtAMbob04DYQFNACzgNiN?=
 =?us-ascii?Q?6U7civdlS5Z1IqFgwEYWMplIMq5ZMUqyIOSnuApfmpSQTZ9gYBsorfBo0Wd4?=
 =?us-ascii?Q?rXY1fxoDjX9HuwHdkRo8s33rAgx0gqEB4jH37pLB/lXmMFIQnDpeqdkl4lTW?=
 =?us-ascii?Q?QOy0phc1ukSo+C5eRuv5KrupAo27wbd9OSnYiutmO4NELLgPr2hPgjAzIrnf?=
 =?us-ascii?Q?5wTjC61te1IMLmCbN6M3uNxT6OvCO7IbIMcVxbloSp1xs73CEa3Razs5hq0m?=
 =?us-ascii?Q?LR8weMxAT3DEdwkoKWpN4/KtDRHl7npIumETNsHbvge8uxZNofgqrzKiWTJL?=
 =?us-ascii?Q?6dQqNxqVavLSLFLz3tLu8BLE75yc/aGx5SIPJQCGERODhDosDZwhqaUNLf1U?=
 =?us-ascii?Q?U7AhHUCLmiYcPBM2h3/VxvEMGjSw1DEab6Dy7jdV3fKnkO36FXcX4xGI2Zpy?=
X-MS-Exchange-AntiSpam-MessageData-1: 3kpU3F/jBn4a7A==
X-OriginatorOrg: dolphinics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d2ba94-d62a-455c-2b3c-08de8fe0b772
X-MS-Exchange-CrossTenant-AuthSource: OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 11:20:44.7747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7fb89e52-625c-45cc-a50c-adf3af1b0a6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0gWsgrNN7qn3xpwEvndooPIyUdJYANvAjo/EhOEs+BKxnGXdKq1t0ZHPE7N6iGjDUpQkzGS/h+OVtv5NJX0E3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SV0P279MB0658

DMA aliasing causes interrupt remapping table entries (IRTEs) to be shared
between multiple device IDs. See commit 3c124435e8dd
("iommu/amd: Support multiple PCI DMA aliases in IRQ Remapping") for more
information on this. However, the AMD IOMMU driver currently invalidates
IRTE cache entries on a per-device basis whenever an IRTE is updated, not
for each alias.

This approach leaves stale IRTE cache entries when an IRTE is cached under
one DMA alias but later updated and invalidated through a different alias.
In such cases, the original device ID is never invalidated, since it is
programmed via aliasing.

This incoherency bug has been observed when IRTEs are cached for one
Non-Transparent Bridge (NTB) DMA alias, later updated via another.

Fix this by invalidating the interrupt remapping table cache for all DMA
aliases when updating an IRTE.

Changes since v3:
 - Revert back to using pci_for_each_dma_alias (v2), but look up pdev with
   search_dev_data instead of pci_get_domain_bus_and_slot (lockdep). This
   avoids changing any locks
 - Rebased on iommu next
 - Tested atop
https://lore.kernel.org/linux-iommu/20260401080017.117549-1-vasant.hegde@amd.com/

Link to v2:
https://lore.kernel.org/linux-iommu/26cfa307-6c33-41f9-a7a0-fbf202b38a00@amd.com/

Co-developed-by: Lars B. Kristiansen <larsk@dolphinics.com>
Signed-off-by: Lars B. Kristiansen <larsk@dolphinics.com>
Co-developed-by: Jonas Markussen <jonas@dolphinics.com>
Signed-off-by: Jonas Markussen <jonas@dolphinics.com>
Co-developed-by: Tore H. Larsen <torel@simula.no>
Signed-off-by: Tore H. Larsen <torel@simula.no>
Signed-off-by: Magnus Kalland <magnus@dolphinics.com>
Link: https://lore.kernel.org/linux-iommu/ea4cfd4d-9ad2-4451-a896-9f0435e72a06@amd.com/

---
 drivers/iommu/amd/iommu.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index f22a7e9ecfdb..217da630d847 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3186,26 +3186,42 @@ const struct iommu_ops amd_iommu_ops = {
 static struct irq_chip amd_ir_chip;
 static DEFINE_SPINLOCK(iommu_table_lock);
 
+static int iommu_flush_dev_irt(struct pci_dev *unused, u16 devid, void *data)
+{
+	int ret;
+	struct iommu_cmd cmd;
+	struct amd_iommu *iommu = data;
+
+	build_inv_irt(&cmd, devid);
+	ret = __iommu_queue_command_sync(iommu, &cmd, true);
+	return ret;
+}
+
 static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
 {
 	int ret;
 	u64 data;
 	unsigned long flags;
-	struct iommu_cmd cmd, cmd2;
+	struct iommu_cmd cmd;
+	struct pci_dev *pdev = NULL;
+	struct iommu_dev_data *dev_data = search_dev_data(iommu, devid);
 
 	if (iommu->irtcachedis_enabled)
 		return;
 
-	build_inv_irt(&cmd, devid);
+	if (dev_data && dev_data->dev && dev_is_pci(dev_data->dev))
+		pdev = to_pci_dev(dev_data->dev);
 
 	raw_spin_lock_irqsave(&iommu->lock, flags);
 	data = get_cmdsem_val(iommu);
-	build_completion_wait(&cmd2, iommu, data);
+	build_completion_wait(&cmd, iommu, data);
 
-	ret = __iommu_queue_command_sync(iommu, &cmd, true);
-	if (ret)
-		goto out_err;
-	ret = __iommu_queue_command_sync(iommu, &cmd2, false);
+	if (pdev)
+		ret = pci_for_each_dma_alias(pdev, iommu_flush_dev_irt, iommu);
+	else
+		ret = iommu_flush_dev_irt(NULL, devid, iommu);
+
+	ret = __iommu_queue_command_sync(iommu, &cmd, false);
 	if (ret)
 		goto out_err;
 	raw_spin_unlock_irqrestore(&iommu->lock, flags);
-- 
2.43.0

