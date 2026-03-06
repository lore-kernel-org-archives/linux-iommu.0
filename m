Received: from OLAP279CU001.outbound.protection.outlook.com (mail-norwayeastazon11021092.outbound.protection.outlook.com [40.107.157.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7541833ADB8
	for <iommu@lists.linux.dev>; Fri,  6 Mar 2026 09:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.157.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772788981; cv=fail; b=KNeIzWuOaH7iW3sKO4xKpeogOfGYkXwPVGuQxMdMuq3/fk8vvalzEGhcVFo2suQvwHF2G5oVi/OreA3M5tgcZceUgURdZ4IfXeLOUeFwFV3bu+jPaOOSl9L0/Ev19WTBRSKezgN9L5MtThSaCKWEyVMHCHEDEweaDvpwjXDfKy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772788981; c=relaxed/simple;
	bh=NjuMnR87/OpXQ2hN53OIRaAIdutwoH6d+iRgSwe4gAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TLBMCjh/haW34KRtLeWzGiC66KSZOu2/qiBjuVOHBX6zPLnSWhM+16RXlSayU/J6iU+fDi9KUjQDOgvrf+GdHFGTqnt3eAOlX/3TXewhuj6LJYydB2vfd8NvZoKGAr+hTNFvX2wuS3E/fcYRPyBjvoySq/QG1VG9DzLGW1vgn1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolphinics.com; spf=pass smtp.mailfrom=dolphinics.com; dkim=pass (2048-bit key) header.d=dolphinics.com header.i=@dolphinics.com header.b=awMgbqH9; arc=fail smtp.client-ip=40.107.157.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolphinics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolphinics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolphinics.com header.i=@dolphinics.com header.b="awMgbqH9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JLQMoGP397IQpL5YqZ7t0vbowB9SvCPsvBuiNRM6OBzKkTY+IXXYLGKgc1+Aa37WfYc4izioWnWjC7v+UuL9z/0nQTwZHnd+HSNwgRI2RzPmcBOvbPH9/n4mX1AmNa37o+ElOro0yS//lZoAnDD+07hYMKjxfWiuPJVDxLfsJN2iQd+8VxKN3pbY8NZ5D9EXquTxPid/14b5rMGike2EHFh2C/+MxOeqqitNVV4qHDRYTskmI3OYJ/ybkHgyFN/Cn0h/YKYsc7buNyqBkeeGsB1MYINsb+226xSyMsVXgJhEmkDtu7xccPMjgVgvzyYTKFA/iWBr/DcfF5dMqUsSJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZeL/czZJS1tAsSdl0OlvVoI4Cu3FZDl7gZSwzbbxv0=;
 b=kx+KA2DqnAQ+4sAYcycoQURfQoG19/+Q0PD698nwhdYIRoPvwo5BIGKTPC/BvYQvCqHMRO7Qg+RF+7QP2lh7W+Pbj7MVdbRaIJPC3Mk5Y0lwTdysmmeUtddOQECNnOskQO9KUG7rkKYk7qrKA0973WwJp5T0mZGaDX/gIQaYgxs1391kplQsBKY+zmDe8UbtbV9VykzPvx1eHXi40fM5TvPs9zpbPkll314rfQ9aV7pqdpfulfDn6TqRj506ALhyzj6CKVwUSvhBDDMkmFvB+D5qxc+DhweOdh0dl9eNUUGiV3Yb3c5SW7qdLWycQ+aWfBNIxlBYQKuBBexVHGePGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dolphinics.com; dmarc=pass action=none
 header.from=dolphinics.com; dkim=pass header.d=dolphinics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolphinics.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZeL/czZJS1tAsSdl0OlvVoI4Cu3FZDl7gZSwzbbxv0=;
 b=awMgbqH9TxpkQuV9Ko71dmBKSPtuWDgCXNPkxM5F5EIIyENxvCJwwTPGQgwHa+736Tep2SuLQo5OuvpUq1LvQzAvVYTXGeHWpGvE15PoBrE/rmuUQ+5x3EJpARR1t7W+0P5orP2ERXESHdnO5xILgnW5aQqkSor67KWaxubi0SGIa+I34/ghQtCTE9uoE7lcy7xtvF92dUOc3Ny8xd7Ex91NjymC5WX9UsdZVLaB5rdF7iUgUffTJr0NbweFKrIseauj8RorMqt3jSGLua/cbLDLVjwb8EwURG8/bPTUS6Dxtu421+s8EpPeRLm0M3gtsPHMwfJXgD2UyNudrJ65lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dolphinics.com;
Received: from OLAP279MB0055.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:2::7) by
 OS5P279MB0536.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:20::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.19; Fri, 6 Mar 2026 09:22:57 +0000
Received: from OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 ([fe80::c82b:8ba6:653a:2875]) by OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 ([fe80::c82b:8ba6:653a:2875%3]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 09:22:57 +0000
From: Magnus Kalland <magnus@dolphinics.com>
To: vasant.hegde@amd.com,
	suravee.suthikulpanit@amd.com,
	joro@8bytes.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: dhsrivas@amd.com,
	Magnus Kalland <magnus@dolphinics.com>
Subject: [PATCH v3 1/3] iommu/amd: Use raw spinlock for interrupt remapping tables
Date: Fri,  6 Mar 2026 10:22:28 +0100
Message-ID: <20260306092230.132183-2-magnus@dolphinics.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5ba83fa5-3101-4f90-10f4-08de7b61f3fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	HHoPQWyCuigzv0435eaYGi4lV1lPzorT/zoI1f++AUbhz7QgBqivSj0MAGVNiYn25NQiLuPbPHOTmQsBaMSEsm3pYM1F+QwpAaFnDt9dt670ROYREmSu3WX4rezV2qPbLoZnsojTA1Um5HtxJ/aDabZ4uRI1QGeZLZ6/MFJa2MpdQ9sJaDTPMEqnbwS4f6Rkgl2ASRaIcdV6KOvcaDnCx902W2ebbSKSu2PNYGR1G3ANKFxPnvgOCKYuxn8EtWVWmjVQ5NrVXnhL/YBev+leI0sFpQ9Ngn69QKhfAu4jBqHQBkTzO9lONybW2Wh8THswb535qJTWpzAfN7Cw1AAbh2ulsHx5XFzDuyPVD8weIbrCDy3NZKeZqFCpQ39moscRq3iAobvQL6gJU3ipPuy+VF+/f/gLmtvxf3UUvTZez9yRvLG78ZnBH/vswPfdUiuSCwNDD57bZnUXxp8CfPio/21NQ19nGVz64IQy6NVfZjB/ZzKuy8FKa8zIBp3atVPb9FPGQHkurKQPJ+QCpKHc5CKsWrBe+xd7FE4J5Q1YpY8tbZ7GfhZBdOS7+RZuJhg4LTRJucMMCUk67L4kddml/hqPDMF589ycz/M9v7nuT39LAzDMEdDvACUnMCGJwkE4+60747poN9Y7qH6dh7JZ0Ukl7ePlNGOWYwprGtxwd++mVsiK6A6UUEJqAv1l4i4+Pmy+dMczdHgl0Fqs1lo1Rmwl745tYdnjCsr2N73fkJY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OLAP279MB0055.NORP279.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+YVnUIJMCsY9mBKKUdeMn1S34115AnuSpSI5chFJwESFgnIALnxByVvBvlqv?=
 =?us-ascii?Q?6MrOhZmiu0ntJdlWrYfVceRxJ1NkYpSm+YHQ09aXpHlexixQbyDma/E5K5RB?=
 =?us-ascii?Q?f1JCs/POriGIZXjIGaQDLZ4EYZpL2F656K1BXZjXvF3uOUo9NKtEn2ks745i?=
 =?us-ascii?Q?YqXUImRrbIstqinsCac7JOcpjNIVDDbCnLVLlwy/J9/u0YpI4XAahnELmdHx?=
 =?us-ascii?Q?iE6+vE4f8sDQFXv6cqEyg5cFMbE2nWWH9HbVJ58gMuUUpZIjKECiNmO2d4mx?=
 =?us-ascii?Q?G3Cazzndi/Vl1fs8OPKFDSMcU9zeozAoYlk4+GcCZqrdpQyJReddg+ypXXbR?=
 =?us-ascii?Q?Oa2tLphFctabsd5hV/ZOyv5dQUMFlVUwQTIzpf2m2azRE5hRqnMAJGZOqiUR?=
 =?us-ascii?Q?CpxKNatAyfZw8vM7pMR8gamQHolom5lxbE1NnUDGzPUMgXbbJQrL++oHaUKm?=
 =?us-ascii?Q?n05V6lh33FwSt/NorYnnLI7+w/W9cpzDsCU0GoRY7J0YECQMKhInaP2jymkF?=
 =?us-ascii?Q?XdxppvI4ZIjOuN1w8ehj2yj/55+2yipD1Mzc7xVdxSLd3YqRuTi92t9FFSgV?=
 =?us-ascii?Q?EyScbRcQ9NyZ72CZWFX16MBerUS7Cg6yk6lxNqzn+b9ir72UBW2soFUflO1o?=
 =?us-ascii?Q?8G2nasIT3AedHGz8GtgUgdDVvCxcvSbCFhzWJrtadV1U9ZNBI/Wzjub+OvUN?=
 =?us-ascii?Q?p6pNl9vfgQE4t1RONBolpCOefrBpxmhqDBY/1PYrEfKBdi7bCAGhA43lX+P0?=
 =?us-ascii?Q?F5sycME1+LNwrYCt3zAGeXbvqr0aZDYhrt+5VR8sglamDWCcAyzUG/w4Ktq8?=
 =?us-ascii?Q?6n9C8FrL+1EqTGdTb0j129o5Z2bx3AsujyySgHkpqniwgJ8zc1AxjUxefgNb?=
 =?us-ascii?Q?l6bkoB3FulQJo+1f7KnZGsxUgc3foGfFjy69Tw9xG+VhoYm+dtchMwQI5fhd?=
 =?us-ascii?Q?oVD5EVhN+dvLSQflKEsH0EwXv0Zllc2XKJYdhwO77cUXGiHiP3XvFnkVhxQf?=
 =?us-ascii?Q?1Lw9Jb12vIdAVfuWoPtZ8UW9KoSnfQ6Eys3fFPNqfEKQzv2sZA1F6feOoUUy?=
 =?us-ascii?Q?vPL5DIiG1rIYEtEUZeaBgpRqO/AnMftWur5hC+rLoJLkP7ZXkhba6O+RtA6Q?=
 =?us-ascii?Q?hQ6Vg3rKQFHY7TjnpI1/3cUpEzoN1pOX1gOE2UQUx48ibvodnXSaiWED1k3o?=
 =?us-ascii?Q?8MzXWLif8P8cc5i2qKSGoM5dESzBCzkhgEgPshonJJB/193O7aexMb/Nvkoy?=
 =?us-ascii?Q?eVa0oiJUIssCBr8CRuSVrcokaZKFf1G6CLS9YVdXb34pEj7uEzGUVP6CyTvl?=
 =?us-ascii?Q?aJoSGpX3dhWIjVW2H4FCz81HraVmr0/NY+qU5qFnCUAs8kQ9ALYAAMms7nPT?=
 =?us-ascii?Q?MMNtJ3kTsvV/JHEOEz30Ycs8H3EuiK1zzhM386bagDgerXalLqS/7yqyFpZK?=
 =?us-ascii?Q?cKEMxhbQcGI+BcONx+ObxBFmmBuo9Wtzp57OogeBDx0/3kM//ULY/c1gQDLZ?=
 =?us-ascii?Q?r+uspxXT1/jRk/n5w93Qf6SjIWQuHUrDaqDS+v1t3e3ZBXDJv9QIYXxqzZyz?=
 =?us-ascii?Q?kMkcEwLkW6APAR5MxrYMJzOlHcb92pLloeuo4YH/kjQX5VPFQauhHRwtO6jT?=
 =?us-ascii?Q?G4emE+qr+9VmzhI6Z4qqom+szXhqYo93gISQXii6Enzpj09YG28+Vcrg5CTl?=
 =?us-ascii?Q?Hjd4SHY6X76szc3ENHqmTL54jXWytI3LC70TGqSQW6n/dZoouC7zEp4Xtnzi?=
 =?us-ascii?Q?zmNCiyicMQ=3D=3D?=
X-OriginatorOrg: dolphinics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba83fa5-3101-4f90-10f4-08de7b61f3fe
X-MS-Exchange-CrossTenant-AuthSource: OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 09:22:57.0170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7fb89e52-625c-45cc-a50c-adf3af1b0a6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: idzMzN2NvM/dJflp9k0AeJXbNLQGMDp8ViQty7xnpvrgYpFhNzqJbJRQJQ/GT8B+HRJlKA5YjRdC8w8fQ46tJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS5P279MB0536

Use raw spinlock for interrupt remapping tables since
iommu_flush_irt_and_complete is called under a raw spinlock.

Signed-off-by: Magnus Kalland <magnus@dolphinics.com>

---
 drivers/iommu/amd/iommu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 81c4d7733872..f3193c6428c9 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3164,7 +3164,8 @@ const struct iommu_ops amd_iommu_ops = {
  *****************************************************************************/
 
 static struct irq_chip amd_ir_chip;
-static DEFINE_SPINLOCK(iommu_table_lock);
+static DEFINE_RAW_SPINLOCK(iommu_table_lock);
+
 
 static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
 {
@@ -3310,7 +3311,7 @@ static struct irq_remap_table *alloc_irq_table(struct amd_iommu *iommu,
 	int nid = iommu->dev ? dev_to_node(&iommu->dev->dev) : NUMA_NO_NODE;
 	u16 alias;
 
-	spin_lock_irqsave(&iommu_table_lock, flags);
+	raw_spin_lock_irqsave(&iommu_table_lock, flags);
 
 	pci_seg = iommu->pci_seg;
 	table = pci_seg->irq_lookup_table[devid];
@@ -3323,14 +3324,14 @@ static struct irq_remap_table *alloc_irq_table(struct amd_iommu *iommu,
 		set_remap_table_entry(iommu, devid, table);
 		goto out_wait;
 	}
-	spin_unlock_irqrestore(&iommu_table_lock, flags);
+	raw_spin_unlock_irqrestore(&iommu_table_lock, flags);
 
 	/* Nothing there yet, allocate new irq remapping table */
 	new_table = __alloc_irq_table(nid, get_irq_table_size(max_irqs));
 	if (!new_table)
 		return NULL;
 
-	spin_lock_irqsave(&iommu_table_lock, flags);
+	raw_spin_lock_irqsave(&iommu_table_lock, flags);
 
 	table = pci_seg->irq_lookup_table[devid];
 	if (table)
@@ -3358,7 +3359,7 @@ static struct irq_remap_table *alloc_irq_table(struct amd_iommu *iommu,
 	iommu_completion_wait(iommu);
 
 out_unlock:
-	spin_unlock_irqrestore(&iommu_table_lock, flags);
+	raw_spin_unlock_irqrestore(&iommu_table_lock, flags);
 
 	if (new_table) {
 		iommu_free_pages(new_table->table);
-- 
2.43.0

