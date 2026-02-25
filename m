Received: from SVZP279CU002.outbound.protection.outlook.com (mail-norwaywestazon11020130.outbound.protection.outlook.com [52.101.180.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AD830CD81
	for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 20:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.180.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772051038; cv=fail; b=TTQjO7TAe62Tu6lhgmpkOtQPeR5e/5Zre9B1atVPi2Ruo8mzrpEsX8dQ15GsxQHMDFAsmh4DtFl0TtmzOT+wbOUddCJwd5S1cNPg+HnSPCahO6RpKTAogdeirxNPZ7Qglhc/FqZVyMGDwhE3m+7ySD8aPdhAjD1Dx2L8tng0PKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772051038; c=relaxed/simple;
	bh=HyCRrRTlGxDh9ke27oQl1QUDkiRxVHcxULjvOtOmrA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cBMGHRAas3izcWsRIm2l7tOlhxHPzcbiRVAicmkKy/mRR7Y9Tzg525WX03WWpXMrkjJGVpCT1W32CPV8dCiF9Bj2wcDFLS1ale+PaGkp66VMyTPtOem3aQT0h2aIcqgPcY2hkl0mONM1Z1B3xQxlQlhhZou7efkEaL8IxdxpL4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolphinics.com; spf=pass smtp.mailfrom=dolphinics.com; dkim=pass (2048-bit key) header.d=dolphinics.com header.i=@dolphinics.com header.b=lIESUAqD; arc=fail smtp.client-ip=52.101.180.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolphinics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolphinics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolphinics.com header.i=@dolphinics.com header.b="lIESUAqD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SNekTaz+taX+2yuZOQ9PPeaAAsUXpUUgkbPt/4dnVkFlzSWEZs0JvQOutOnXit5EOLzX4M7jkKXFW1v9JrUYHCM6o/J5k3g0Z+cLAvyD2yxRUHtE7y+y/VWgkz58j6QAMsghUeTwil+/XmEcvPyXiPNdwFBbLyf0Qmr2aXzs9nyc8fYTACcgZSBGHaeaceMFBz8dEuV1qHBx/6wPXngGMLI0DzcaSToUTs4tBT0MFze6DqF0h0CaKaarXKEoqwxCawDbU3ziUSJXxJUBrq10QgZXdMHDPK7PqQiPh/stvNPaFuS3dEnqwDhMIAk+l+75mR3sDVvH4Jjjw7N16q3Nxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07jwDdYluwzdqZ/DsPtnv9xD7UI8CMaPqQoVYi8errQ=;
 b=eqcycamFO45tny2TqFU3BTBKGV3Yg8F0vTLI0I7PvnpLc7lqrcrM/9hbZJwfkatovBZkjzmYqd5sSnIe6F6Ff2H4sNrxPmb74domNM3T7mcYyKN4VrL99UQqw9+0zi+KyMWuegmopOIZ7srNXhwFjw4VF1SUtd0QgTsLjmbEN5nkFecphHkwJ9rMBEMC6WBGLM/jEUN3OuY7RbVm74zc8QdP5mxe1RBPjye1XMj1InvJHPvqFD2HCR8dED9hXFyv4LVTuKFOQtdCy5s3ZmHZWMW5LI7Az0HPm2QRoa7nqKjqULk9eEZy3xFVleC8OPPPPxxI4b9/5+RwpuoF94PRog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dolphinics.com; dmarc=pass action=none
 header.from=dolphinics.com; dkim=pass header.d=dolphinics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolphinics.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07jwDdYluwzdqZ/DsPtnv9xD7UI8CMaPqQoVYi8errQ=;
 b=lIESUAqD3g9VkcUfWcpaFXM4/wQt3PksDhCaK/5vpo8tEuKW7iEKy0Bai2VFtR/k15Io+I7DU/BAsVFyV+bL6H8S4dswwh4EXGKzQxqJSsvLK+s5jGTOFEVzRnWLLtRnJDPvXW+E54co2pp8Koady0Ai2o1at/R18WKlAQooZnlQ/EWJZdXwZlK8uFOVJ1amT1EJCjvbGNGERFKADDdhhC09Lq7gJXTkIkqjPt7BxO3nIDax2SMWR/IdRABTdJpPkyGJim5KKamc8KweXYnNAOkUAzLJvjKR+wOqv+3c1CUKingYxvdDt8XNU3Ut24oHJ3bPTUSsBgEanzST7+oMFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dolphinics.com;
Received: from OLAP279MB0055.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:2::7) by
 OS5P279MB1039.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:56::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.23; Wed, 25 Feb 2026 20:23:50 +0000
Received: from OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 ([fe80::c82b:8ba6:653a:2875]) by OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 ([fe80::c82b:8ba6:653a:2875%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 20:23:50 +0000
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
Date: Wed, 25 Feb 2026 21:23:30 +0100
Message-ID: <20260225202330.23027-4-magnus@dolphinics.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225202330.23027-1-magnus@dolphinics.com>
References: <20260225202330.23027-1-magnus@dolphinics.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: OS6P279CA0111.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:3c::13) To OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:2::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OLAP279MB0055:EE_|OS5P279MB1039:EE_
X-MS-Office365-Filtering-Correlation-Id: 606480a4-9a37-4c21-16ac-08de74abc948
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|376014|366016;
X-Microsoft-Antispam-Message-Info:
	+xYUh/jYCJaZk/0mL5B+wW/HeqFp6uu6nQueFZuA1irT0Fsz8ZmJ7uk27SqaaQPejIRqAlsIVg6l/WARiJylzVAI5Mnk8V4W0FDn6XdEVOf8eJlFruE3AY/sdT1hrIdZy0OJR3cMKLz5m3yLIsXAlBDT0Ukr5xOsDd1lXeOgACkR7+0ihE+bfx4zEX66huGE7zrSAhsKFrWHhnVcr3Y1mNVIESllaBEs/sT6uGDQ4S1XV8CJjf8MoA0vAJYhxmwKIKomWb3nLErLoxNwSkoyRFkqTErQjCTids0M1wrktb86fV5oHR/HGrlLgrRu9JDu768K96O6CfpE/ALL8QRugImRsrqNPfikfe/LcVkvta9tEpFyDd36yYM2SzY5mBKD3Jouc7xyPUFZzB/WKm5wWjCCyTGhUNC/z2tlXXYKCG0EnR3kGDRlEhRJZup2d/6UugeiRr+6RkOYmvAoHbjncGuGqZFIwJ5F/Or9jKdQKYIsoEDuDWh5UzH3FWZr1pHUIuL9E84+NzBCsJhGKdbbOfZgpkKtsX48J/BCjDHSMr/H9NxxpHiduRLBuKBMeJO7xgCNpVtgvXjslanyoUk/EDlMSmZZjM7CSs83uk3wxiWFgnTSoN+bZVYCT4wo/EP7XrNZtryb7wMZXxtAkJ2fXnVm5X8GTzqeBB8MCD6m5jquvM3uKC3iYrH1PEXxY8jpWNJT8QaGvpc2j7P3mNMlNVN74813QvCEkXM4Su5lSIU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OLAP279MB0055.NORP279.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2qGvTTEvVQBCSrsLvAqekSwVLA1rAQyuu91yBIdTNqgGZzOGat/fcw84elVr?=
 =?us-ascii?Q?xGWhHNBrg25B4iAlT0VWovLekjPTJCLCrorE1g+alGulMuAZzDhiUfiNAK2P?=
 =?us-ascii?Q?avErkB7H5gBHn5YiBYZWT9Rc8pdQeBEjoUwv8JYlgXwkN8qo749Z4lDnEe1O?=
 =?us-ascii?Q?z7rdxXcEGF32DhjY4O8qnwpY1U/4dqFwRSTb8jj3fa6s7IjX2gdQEk4hXyBo?=
 =?us-ascii?Q?VvdUlgCiQ4yED3jOXCAf7ViXOPph7gBcGStTL8HGQdpHX5L32ehXjzQaq/Ck?=
 =?us-ascii?Q?bSsLAGutSvE853DuCY+WpB47GtTDjXK7KIMMAmh3AMSUM+xvQsvVBZS9KEzk?=
 =?us-ascii?Q?hNA8AnjpxD8ezLC2A6A7OIRZuJ208nWcf1ImARdRkJPmXnqjHV13Wub2Qkmz?=
 =?us-ascii?Q?QTTseqsynJ3nHNNbujLIMWoO/pEaVWEDv+LL+iDlMKBbz7vYnTkaeWjw/HGc?=
 =?us-ascii?Q?7Av2AVQpo8GZ16/2VouhSOvslxUM4HuswaPAp9da2QsHtw9nm/fkjt7gKssP?=
 =?us-ascii?Q?QXtNrF9QhIgS8tfxFbAw29yl3Wo6ptNxp2WWFJ0m3vpeBgWv8KZb2Bxg+OD+?=
 =?us-ascii?Q?1u1o6BQOVwreiGyzlvV5QQ5empZaRVl3VUY+3NyWQvfWr6BsTzdZCg8CFkAS?=
 =?us-ascii?Q?ZO7EofSPDr8K8zK0fXFpk25iO+qrhgX2FbtNXhyF0JOZ6NfzYCZRlWttISN6?=
 =?us-ascii?Q?nDK/8TqsrfDng8uJ7k+9d898drOkhUCLnmKpHIAfctKr1jiaPhzqU/Itnh2d?=
 =?us-ascii?Q?wDV5AthWYGif4hZ+paz+y1OElIn6iz7Wwo+cC4IhHzfO6qP1oWSOG4YoISpd?=
 =?us-ascii?Q?N4YQsBUw3o3gjmPaSowhiP66cyZSkmOYnn7MNQENYfpouk0APmqQ+WDzZase?=
 =?us-ascii?Q?aqJW9PfiKvTt2DfscbytEJSudIaIg6peN0Jw+kOUUcJANQp7pEVF3kpPuYJ+?=
 =?us-ascii?Q?MATRAhVmHHeMQQfN/oKssIQ/bvAVuBmO1po13FcCLYXu7mwFJYEO7JwOKL/6?=
 =?us-ascii?Q?Q4449OB/OLyCq+YAKDyv7GzoPs1y2edKTdGJsgNUlE5CQ++drPwRBPGChy2h?=
 =?us-ascii?Q?zs1ahepyA3M79/+utSDCk6rAAdkFsLIQ4C1NOJv+GeSad2sE4Yfv9hS04Vib?=
 =?us-ascii?Q?8yQsv0DHSbuOgT4lzE7OHn1x22MDqE8hzv3sVXycmttWUEVPq1ouSeyWK2PK?=
 =?us-ascii?Q?b7JGUIShI+nhSPW70PNImfFFMH2LEV89OopSoSH70PUcKSGqhV+1IqR2KWBt?=
 =?us-ascii?Q?W9wVzTeWauHptzPkgus7n94Iiqxp4uweTDnvDwRTNo4UHroKvASTiR7X6n8L?=
 =?us-ascii?Q?9QYKG5Y0pYQjDKhpDeGm/rcdU4u7I2MB4ePEwUUZZIN3D5wl6n/mdUuqOD0G?=
 =?us-ascii?Q?0AuEDkkXNB3rFPWqvGdn0U5AmayTas1OGn4+B85lxYJYzOv/g+awjMtcdC1H?=
 =?us-ascii?Q?E2IGZLf7Lscmw+uiFxnWE+ZIzaHzINBLB2n18KXKMnNU1sA0tT4wz9dAvBga?=
 =?us-ascii?Q?HKt+07/dqtYyJa+NPu5uOkZ7DLjChUOsOSBqS0BGd1X9oeCrrmz0Qoyo6T0O?=
 =?us-ascii?Q?tXGciPxPZFWucalpUEhpVyCutqq19ElwUhZxrwIdD5WpIVottDXl5oWEa9XB?=
 =?us-ascii?Q?NT8SeQc8prp1FyDpVvRTUB+D5Ng9PNE5qBSywchsUL4Ezrb2QWaW4K51uead?=
 =?us-ascii?Q?72WcgjqKS2d0LNYpf2l0SBlwGwHsTuktF4mJvDPDMNJ36HnIt4Nrmqc5iEvg?=
 =?us-ascii?Q?dwuvl1ElqjhfaiiNbzjOQLswJ+m2QOI5DNkDiTUPj5zrLpHB+khcnBy5IVDU?=
X-MS-Exchange-AntiSpam-MessageData-1: bz7xP2kfctuSUg==
X-OriginatorOrg: dolphinics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 606480a4-9a37-4c21-16ac-08de74abc948
X-MS-Exchange-CrossTenant-AuthSource: OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 20:23:49.9699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7fb89e52-625c-45cc-a50c-adf3af1b0a6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I+uUPbhZbMX5TrPObmS23NeuBA6o478n+WiNEE3cBrzBJBVBmuUId7oMOYldjsFh9RdlYiHEuKEZdAyKiWYgQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS5P279MB1039

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

