Received: from OLAP279CU001.outbound.protection.outlook.com (mail-norwayeastazon11021092.outbound.protection.outlook.com [40.107.157.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726DB344DA9
	for <iommu@lists.linux.dev>; Fri,  6 Mar 2026 09:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.157.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772788986; cv=fail; b=OTS2Cr2BwAu3MVsvftt4fXWOeS5D3KboeN1v69EpPLBPUPtYmx1nmRB8v/OiCZl0DCWHAi8ImH74x2r2JAC7o6P3U6ll+si7YUxOwLPX/3omzAjMsXfQRcJBNx9AD6iC2CeF1vF+bQJSSK94vWnp0VtToPEFQc/Rx2hrtImJ99c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772788986; c=relaxed/simple;
	bh=HyCRrRTlGxDh9ke27oQl1QUDkiRxVHcxULjvOtOmrA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DUldmq/rA0shEdttyousnRDuGeBWQrEnHGxJbzBdY7K74gD1oePUwzSxFzdBDQLUQdyZJ/u52AZghlgLwy8avWV/FBiD1FwpH/iLZ2Kyoi3+gLe4A9OHYuGbqxg82o597L6Qg0ZIaFjfoum8SxmvDOtX+FBSJmsrccOFmvSEzkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolphinics.com; spf=pass smtp.mailfrom=dolphinics.com; dkim=pass (2048-bit key) header.d=dolphinics.com header.i=@dolphinics.com header.b=nBofFIvS; arc=fail smtp.client-ip=40.107.157.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolphinics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolphinics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolphinics.com header.i=@dolphinics.com header.b="nBofFIvS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nIfp3VrpRcdgV/DjzzMjCogPjnbvcXyr9Arhc8LO8ukj+M3UNTMmr12yENmy3vtveBGaBYx7SJtIiCeiToG5EUPGIb2h7ibfpGobifGjoCkR8H1KGcvvpelqqFplyjV8pVjl8OhmsrUEZ5zhurEgOs2t0HzeUka5ROZX8CBIt/jqE34LfBMV3VLhV7Bq4QlET/ekawx4crOAzg5RxQzWLR/5FMyi7KyOvz0As7zrIY28UTVzur/Z4u//8Fl7x2Ebu1CTXvd8a2rObZvA41uWNybrQAeeBh8i/0Xop0ZuPOnjO0XUapsAq3GChbf1DDAPmPYizdVmS1q6sr8gl84jjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07jwDdYluwzdqZ/DsPtnv9xD7UI8CMaPqQoVYi8errQ=;
 b=MHL52xSQ8o2jWX2ZITogZNi3Sdq3DU/TU0aC/uFzgoo+lPkPvdSnajxmyPGzydqzpShzANmNoDqgOmekJcAE4Gt7QTUqdUa3myy8FQUoEPuQB0YSv5bDffzASTVKmYhvGSEMJ8XyAcT+B0uqu3jxiYduYwQmbNVUhziB79nE+mHmb5ZNJn8nsZ9wMOpGpCCSkLfDlEjpBVXPFRWTwZdnCbQqoNJTs2iNr0LIvLScKydhxkrPBsk0tfXAvj8+wR8tLbL/1WhPyW825IkMfwfzceAWGCiucaoAsSw2a4+sqM2Xw6nrUwyDi0k4A1+N4Pk6YaCFCwdrVXjJKEScFAtbZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dolphinics.com; dmarc=pass action=none
 header.from=dolphinics.com; dkim=pass header.d=dolphinics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolphinics.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07jwDdYluwzdqZ/DsPtnv9xD7UI8CMaPqQoVYi8errQ=;
 b=nBofFIvSl0BxL+MOsuOQbjKsKg1Haf/18WhQPfbjeJ5qZErnc3xOBiHMf9IXSXhNt5W9P560es4d1l2np9JlFGzRW39wKLhwWtwWbkSsZnlmbraK6nx2T5SX4iLlFA6zZuoGFwXx+BXomQeQWGBp5dQa/XA912U/yLKr7TY9GbJJ33dm1BLnQb5mzHcbt0ZAQT8VXe2/O7SJhe33UwAyaPwaTuwuk0DLYcXzy/ra2vx3NjcA8CcuPbudsGwfAz78UP6Kw6hcKbxzQwblMi8PlfYLU8woHcxA/ZbS45nwBqkDIqbEYE1LNM42/GDSZEo8aDcFUGkZxRmki3rCKHAA3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dolphinics.com;
Received: from OLAP279MB0055.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:2::7) by
 OS5P279MB0536.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:20::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.19; Fri, 6 Mar 2026 09:23:01 +0000
Received: from OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 ([fe80::c82b:8ba6:653a:2875]) by OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 ([fe80::c82b:8ba6:653a:2875%3]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 09:23:01 +0000
From: Magnus Kalland <magnus@dolphinics.com>
To: vasant.hegde@amd.com,
	suravee.suthikulpanit@amd.com,
	joro@8bytes.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: dhsrivas@amd.com,
	Magnus Kalland <magnus@dolphinics.com>,
	"Lars B . Kristiansen" <larsk@dolphinics.com>,
	Jonas Markussen <jonas@dolphinics.com>,
	"Tore H . Larsen" <torel@simula.no>
Subject: [PATCH v3 3/3] iommu/amd: Invalidate IRT cache for DMA aliases
Date: Fri,  6 Mar 2026 10:22:30 +0100
Message-ID: <20260306092230.132183-4-magnus@dolphinics.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306092230.132183-1-magnus@dolphinics.com>
References: <20260306092230.132183-1-magnus@dolphinics.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: OS6P279CA0095.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:3d::17) To OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:2::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OLAP279MB0055:EE_|OS5P279MB0536:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a8a3b46-7dbb-4bbf-4bd2-08de7b61f6b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	Iz7xMvluGbQ7y2wgCui9O1+JBGQ87VinpySr74ZG0rJuuX//EEGtFQVzkjl/F2vJHH2NZSWY6pVZqnxz/RIflb22WrRhiM9lW3QM6HAZ+rkWORcvkYmq3cDSH4IgY54uToevlTbQuF7au5QQr4Gvsim5hPxiyg4ilhghGpKNDLV51LQMwFAyGc+azSHpXUsm+12igeYpU0caPiuWM8P1Z0iZjWiJ6jgXJQszxej3GArYIr9tqw+xHZtyQ8Nne3k0V0xf6t8RsyUP8Ejn1iBecfIR5269afvgllTUUQS39PtrJWOS+84xGsLNsCRsw0JHP9vuTGbyZIGGWIjekAAlWgW0dK+mB+p4Ra2WitYrbDzaaoqbLAlAExVKzSMex29Cp7BXhvs0GYZMqE8/eGCOjtRnj2hhNg+9767cJUHj+MYiWTFRw2JhlmdIi1dMbhpFjme8TMq3RmUCERpWtbLh1bPrmsjTvgBplQwe0guZxVUu7jsHRXgcj/0lm8Vqh8sRMW6SagTDeOHOV5BycbYcgarjeQyMs3W6md49ekImogD0AFlORJ6uQbMt1QVA17hnwh5YG8fG7AWhjsaAitZ0sdNmJEka0/G252OtIEDbna/XTJDrBIJ9NOqaWkvQxQ/hYxECjH9qlAY0u3V5vEEya2GFLJ47D9iHldoi28R+taurE2Pk881VxwEbRoxTngZhr+QtPsGWp9Gncrd/2A08unx6f27oNyIQFT4LW6mtLRQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OLAP279MB0055.NORP279.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AeGnCffsoCWPW37267HJ66vg1e49O19ggC7lHmhof36xMZsEMDZaqLnjTkAW?=
 =?us-ascii?Q?dPDmUgZyXLI7qdxvpwPeWoxIXGtjxCoxMUBhOQM0pOB+QLHmT7D5h9CZpJx2?=
 =?us-ascii?Q?sBowPhysYT0DgjxWo6ma0z2RDr8+yYsckF7vLiIppQLdPTeYel4pFraJ1WjY?=
 =?us-ascii?Q?pRsvKUmbOaHQEHVBMmeDtvXsDKIi6saTfxskvryOK87vKvgi29QConUSt3QR?=
 =?us-ascii?Q?jzIVExY01CZ3S6VWfXae78BIJbEN/HOdxohGhOnc/B7szy/Yt3NeziwwR3xJ?=
 =?us-ascii?Q?JJIE7Nx7Z6fvE0FuGWeMTIfT7DgZlCJgrn+akoDKZitRp1FJQ05qJmRE8z53?=
 =?us-ascii?Q?ph2iOWaNf4Wwk1hkMGs5+jxNhu2Dy7BsJwQOw1G6+8GLwvQPoJ1nfkxIlY39?=
 =?us-ascii?Q?btK+e9wwXlIKpiVa/UukWCtYRmQbRAkM54c72tdu/mGvfMD7XPVW9tj207aa?=
 =?us-ascii?Q?8NQ1zE3o2O2yYrL/ltwHq7WhSXEMPEDzsciz+iHILucdkeOdxnZmvTRFvVyE?=
 =?us-ascii?Q?n62DTH/4eEZ2WqHKRKPEiGDGTmgMUz1HwlTdoUTljEJ5iW19KKNKOk6rO++D?=
 =?us-ascii?Q?+kSL1nxgOfOnbMA3Z53bawNgpTWMa3uPqPz6xZBVftPDq2PH5Ek1iPfQqgBM?=
 =?us-ascii?Q?zAZH3r9s/3vxGq4dn3je9ah6fG4WGyr6bTchnyafh3YD8BaF8PDPAOm47zYA?=
 =?us-ascii?Q?lrdyXxqRQmHjTtWzIEHjDZE3kxDvpNMRQxtkjKipCVSJ1f8o2/BqnwChJyma?=
 =?us-ascii?Q?vvzf+nTbxJn50geSZH8REqHii2C6kBjuqMCGUKUKZUeZBzJHsjhRfgUTimmp?=
 =?us-ascii?Q?ylTAGlln0E8o/GEtvp34qhEShXL6wpIUTvoQu0ZOHeWFGS8DzN6jDZgkviii?=
 =?us-ascii?Q?JtX11KDPY2QVrsnxnGyKgqS5a0iKNytAwjLVJeJoGbaLyk3Aqsw6jDEbVJTf?=
 =?us-ascii?Q?N9JLBxrHIvqld1o183IpbgascT5IlQ/3YGeDYqvIPjkg0eU0kgbIUEyRQ1Vh?=
 =?us-ascii?Q?xjQW5bk2lpdBkw2JfYKx0A+PFEUFi+b6WpXZboOC+PEML3YUqJtJGODxNpFj?=
 =?us-ascii?Q?CONEAN5KYUy8zPfEWmmkuumkMvuUSjYijkRok9G7rrW9e57f6nlzEA44kPEg?=
 =?us-ascii?Q?fIjO4Op7ttysusarv4lkNCIhXtcF4PKdMU3I90kNfCDr7EatI1wYHB6wZ7Dv?=
 =?us-ascii?Q?OtztRE/7NlWQ+/tzwYve1CPcG+xntkzK3Xe7myz/JLxaYShflTVUNiv5oiSm?=
 =?us-ascii?Q?JKALdI4sGZhIFafGcEtv5yXFHcXm/M32XmJrmOiJWtLoLdGRFd0xKdKl0Cwx?=
 =?us-ascii?Q?he581d8ZFYGMP8TDFM7Pg9o80CJXqNb2spXj53Ys+UisPdJCI5QIPB9tOcro?=
 =?us-ascii?Q?R3yDBBROAOeNSAL4Dd/abi63n0uPMnQ6SYx+ItNPqPnwa4R37wqycxmmw0nm?=
 =?us-ascii?Q?0JSUnDfRWzpVvSfDyhvW16w/XJbbAqdG+NlDC48F8HqG81LIFSBGeZJE7vVB?=
 =?us-ascii?Q?LcrH56W9+eHY1lOx1ML2MEXQnowRYGZPSXQ2yD+Okj1JBs0nipClnogmKQND?=
 =?us-ascii?Q?mtJhVa5qc5akuJ3+vd2blAzi/+SkBsYZfmZHtexrPX/LubgebWJ/6SBRduKt?=
 =?us-ascii?Q?Xx8K/gAOUyn7O00p1N4kiw5auBballx1dyV6gLkfAysMO3SpJ1mlScffBixh?=
 =?us-ascii?Q?4OaN35bVR/rgumqNF6nvd0LUYDqLxpFkP4SZQsZt989cAWFxI2FXnTZh3T40?=
 =?us-ascii?Q?4HGw1Y2Btg=3D=3D?=
X-OriginatorOrg: dolphinics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a8a3b46-7dbb-4bbf-4bd2-08de7b61f6b7
X-MS-Exchange-CrossTenant-AuthSource: OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 09:23:01.5768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7fb89e52-625c-45cc-a50c-adf3af1b0a6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9uUjLdW1uNq2WdXkPt4QIPhKVD4KdEruJMO3wcZo9FmRe9ibHF9Dors5ejZ0p4d0ge+bElAR04mSHP5BiKzSlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS5P279MB0536

IRTEs may be shared between multiple device IDs when PCIe DMA
aliasing is in use. The AMD IOMMU driver currently invalidates
the interrupt remapping table cache only for the device ID used
to update the IRTE.

If the same IRTE is cached under a different DMA alias, this
leaves stale cache entries that are never invalidated.

Iterate over all device IDs sharing the same DMA alias and
invalidate the IRT cache for each of them when an IRTE is updated.

Co-developed-by: Lars B. Kristiansen <larsk@dolphinics.com>
Signed-off-by: Lars B. Kristiansen <larsk@dolphinics.com>
Co-developed-by: Jonas Markussen <jonas@dolphinics.com>
Signed-off-by: Jonas Markussen <jonas@dolphinics.com>
Co-developed-by: Tore H. Larsen <torel@simula.no>
Signed-off-by: Tore H. Larsen <torel@simula.no>
Signed-off-by: Magnus Kalland <magnus@dolphinics.com>
Link: https://lore.kernel.org/linux-iommu/26cfa307-6c33-41f9-a7a0-fbf202b38a00@amd.com/

---
 drivers/iommu/amd/iommu.c | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 5dec3502c8b3..d9a91d1a083e 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3166,6 +3166,31 @@ const struct iommu_ops amd_iommu_ops = {
 static struct irq_chip amd_ir_chip;
 static DEFINE_RAW_SPINLOCK(iommu_table_lock);
 
+static int iommu_flush_irt_for_aliases(struct amd_iommu *iommu,
+				       u16 alias)
+{
+	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
+	struct iommu_cmd cmd;
+	unsigned long flags;
+	u32 devid;
+	int ret = 0;
+
+	raw_spin_lock_irqsave(&iommu_table_lock, flags);
+
+	for (devid = 0; devid <= pci_seg->last_bdf; ++devid) {
+		if (pci_seg->alias_table[devid] != alias)
+			continue;
+
+		build_inv_irt(&cmd, devid);
+		ret = __iommu_queue_command_sync(iommu, &cmd, true);
+		if (ret)
+			goto out;
+	}
+
+out:
+	raw_spin_unlock_irqrestore(&iommu_table_lock, flags);
+	return ret;
+}
 
 static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
 {
@@ -3173,19 +3198,29 @@ static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
 	u64 data;
 	unsigned long flags;
 	struct iommu_cmd cmd, cmd2;
+	u16 alias;
 
 	if (iommu->irtcachedis_enabled)
 		return;
 
-	build_inv_irt(&cmd, devid);
+	raw_spin_lock_irqsave(&iommu_table_lock, flags);
+	alias = iommu->pci_seg->alias_table[devid];
+	raw_spin_unlock_irqrestore(&iommu_table_lock, flags);
 
 	raw_spin_lock_irqsave(&iommu->lock, flags);
 	data = get_cmdsem_val(iommu);
 	build_completion_wait(&cmd2, iommu, data);
 
-	ret = __iommu_queue_command_sync(iommu, &cmd, true);
+	if (alias == devid) {
+		build_inv_irt(&cmd, devid);
+		ret = __iommu_queue_command_sync(iommu, &cmd, true);
+	} else {
+		ret = iommu_flush_irt_for_aliases(iommu, alias);
+	}
+
 	if (ret)
 		goto out_err;
+
 	ret = __iommu_queue_command_sync(iommu, &cmd2, false);
 	if (ret)
 		goto out_err;
-- 
2.43.0

