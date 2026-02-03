Received: from OLAP279CU001.outbound.protection.outlook.com (mail-norwayeastazon11021119.outbound.protection.outlook.com [40.107.157.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADF7334698
	for <iommu@lists.linux.dev>; Tue,  3 Feb 2026 11:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.157.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770118471; cv=fail; b=G8tTNczIV3ypKuovCO2OPeWTz0qLDmVIX4CZizsyCnwCQMKnqmbNszM/rdld6dory2U5A/n5YmekSwW3Ila3jXFztw9btJMqHVVcgLP+UqdUwT6I1SHyykD/wsqPJJdWDLWVDpkt1mT4AmYjeuN+aXe51tvnkT9Rexe9AxyGrA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770118471; c=relaxed/simple;
	bh=/C1YWcsp3Ti9kZfenfaZCTQkG1qX2UyLZ/aRI+UVCVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JR/vVJZR9vcdk6PtbSa78H1oEXR6yg6BBCv0GOgElHsMKjddsLQxgMHOu2f6eBrRbLBf4RxhUHAW+wov4PczZetKcR7SO56gY/0B8NwV3b709RB0HtNmTlcq2/SJM9fLDb0frak4vhxz1ZA+CdWjrTGiG9kUhck5SoHZ0vDqE1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolphinics.com; spf=pass smtp.mailfrom=dolphinics.com; dkim=pass (2048-bit key) header.d=dolphinics.com header.i=@dolphinics.com header.b=MVh/9Phb; arc=fail smtp.client-ip=40.107.157.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolphinics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolphinics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolphinics.com header.i=@dolphinics.com header.b="MVh/9Phb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uqVv099Qg5UQXvMKQsGiRutmkrSetmo8F5CmYmXS/CIzOgn8EdbqbgrI+wGRsrx1tLhB0TI/+MKvfUhdRykZTXFd+EZipqBxChqvFUChoUhEMTbu10YZ878FFCjtYvVvfTENSEy72iGV07CHsy8+jIwZKtA2QfHQz/QMN16dG6SWsOwyLpeanOXJI7qn8GCqIwU9JPOjhQySXZZhI3BsvEM6VvTFzpAvq0aFsfbPWh1T76LEL5eYo2dc2n5GayGLCy0Z9iQ7wmMHE7QvmsW7mGcC0XxOUUmiFsGGMm+VXw6k2s1wL8hVbT7mEMKKWDTchjV+2x3EONqJJ8rPpkdJqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MMxQdrrzpKBBsiSoRu1NAuCNy6j2HkC1hsCYA+p+JVE=;
 b=h2XbcxAhQJP9OGXe5uw3smB4jMENljGassb1+6d6pJ1nRhMRxvfFYSwy6XPJQDUpWJG8CRfDe/ufWEyvGyoGDu/JQFMeFO8QMCfxIssz2P/pyyMocu/o8WRZ2uGVhABqUUTzH8d65SoBfNtojMoa+QARov9ssN67KF/COw9gvOVsdQsNAQgplxhAfuJSJdszrNe/bbqF893Zaw7ha8P6M6SzzJGNxQIbG54MkauWxEClzKh963Ttdqjl9k9Xb+pBq9E13nPuFv2VEL6RrZgfcADtd7HERUegCrXvsMltW9lI94yBYN6QrbcuehZi/vUEbuMT/9WGS/R8z/h1cVYBjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dolphinics.com; dmarc=pass action=none
 header.from=dolphinics.com; dkim=pass header.d=dolphinics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolphinics.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMxQdrrzpKBBsiSoRu1NAuCNy6j2HkC1hsCYA+p+JVE=;
 b=MVh/9Phbm3rvNiRyvFOOuHEo1UZCQxnebSje3BOogqIq8Jxj+FAhkAeeEIeKClLGavPFzAM6qMiIvRM/6NgSJzMaE0He36cL+VTiOvO3373HJlfRTXYhuAuyf0Bi4swGmZIoqcorEcvHwUFIfpLHbh4jJUZRxDTs8KzJ6vwYERJVaSWu5XMsQbvxwafJlDoEyytjJWGuul9K3H6OOLOg3juOJ7U0OSGLYCptsSJygl+/zktyNfld8M5Rh5WoCBVyjL5Lad9MZvN2++aY1FXgyWXqpHyZS5ihclZdnKcz70PcqeSfMDQ0YizbmOGh50qSqrlQwkbGnxAi1aXkEZcVuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dolphinics.com;
Received: from OLAP279MB0055.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:2::7) by
 SV0P279MB1183.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:35::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.12; Tue, 3 Feb 2026 11:34:20 +0000
Received: from OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 ([fe80::c82b:8ba6:653a:2875]) by OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 ([fe80::c82b:8ba6:653a:2875%3]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 11:34:20 +0000
From: Magnus Kalland <magnus@dolphinics.com>
To: vasant.hegde@amd.com,
	suravee.suthikulpanit@amd.com,
	joro@8bytes.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Magnus Kalland <magnus@dolphinics.com>,
	"Tore H . Larsen" <torel@simula.no>,
	"Lars B . Kristiansen" <larsk@dolphinics.com>,
	Jonas Markussen <jonas@dolphinics.com>
Subject: [PATCH v1] iommu/amd: IRT cache incoherency bug
Date: Tue,  3 Feb 2026 12:32:10 +0100
Message-ID: <20260203113209.56978-2-magnus@dolphinics.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: OL1P279CA0031.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:13::18) To OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:2::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OLAP279MB0055:EE_|SV0P279MB1183:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fe9fe46-29c0-4b97-4f58-08de63182bbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GqDmbYp/tiZnxXhySxvWte27nScTuW0nK2cHTyWAQJh8Rn9gBK5n+B9qSsD0?=
 =?us-ascii?Q?nAXXheAQlZcteHtkzjcLSJZwbFyCoIIM8kmisyTGNTEkgZoJgCiyDtysmpCY?=
 =?us-ascii?Q?O1WgFqVfvpggaEwznIIWDrQFkZhuOK+9DNjnSotLM2Ai2dy9v9+3VrA7gsbV?=
 =?us-ascii?Q?g6WEXbp6p75H5LKJN0nRAqHt7Z89AzQIgJCukKXXx3neP7+OGl786Mo+EeOk?=
 =?us-ascii?Q?78fy5a6pgjR8emGINnLv+3e/qaQugDp0ixGrGxkgzZF9WGPOi8zCZ32zgJCE?=
 =?us-ascii?Q?O4huMXizA4JaSAmsEE1rlG3aq8BFSwWsdozzS8hGkOw2OMqRgi4SvU+PrI/b?=
 =?us-ascii?Q?EfG5EG2fT65LjYJQ6q55ZORR/6TssqQG5psNAa8iEYhJo4/bwPtDMBnzMG/k?=
 =?us-ascii?Q?D3vswcmjgR+59kCQQ5gj0lQS5ZSNdLJTDW4V1bKd4nWy5oukeigEsN/4VWuu?=
 =?us-ascii?Q?aspBmrUbBDCwjHhAAm2sYDks2ZqSs4WR0NNZboHWuS1vx6bD4Yz/7H+NkSvh?=
 =?us-ascii?Q?CtjpPVXvGsMYG0lZe4NUKZcpO4MXTPqSH4+xSNoWChx0Tsit8ogPAh6kZNeY?=
 =?us-ascii?Q?m+VwZ8jIfkZrgUJ4IzfQLcTDpK/TsebdZUJRQYSqgzNZCgSiztkoyW28oA34?=
 =?us-ascii?Q?9eViFoU2T7mT5Jsyj3CoiB0mxmZpCs9Fqu4dFFEHdIkMVOznIdfHxh5X5HIC?=
 =?us-ascii?Q?C50Oy7SFgzRfy3uG0gcSXDi93FnMKZfJpEEf0b5HDY10R8g7IwTSF9QQAVBh?=
 =?us-ascii?Q?yciz40lrHf9u5lwNGg1aERV3t7KrWL6lOhY4Hpn7nZP8GeGWyPuOFxSY7GD2?=
 =?us-ascii?Q?+D13rncAZTShImRBc0dPr3J+27f/JZqcInweKfw8V8OoxtwUGk3EWmF2AG4P?=
 =?us-ascii?Q?a0WM0sOcPA0CJ55ynEbRXZWELhtcpPRuPrNQ2hnsg/0nHeUaL9rne9pW3s+g?=
 =?us-ascii?Q?EmdPZBqpY9NIF02wBkawF2c0mxWLmqtidjw4Y6EF9qgdirQxtmXGzc53CgCq?=
 =?us-ascii?Q?Sx/QeXUI+PraVnqeUHRy6iQnNS8IX+cSDn1XUWuYE0fv6v4WmjadCXt2FzTD?=
 =?us-ascii?Q?cOopUJa/hBV/lYsqyF74jTn9AesdMgxWK5OzwH5eOo1/+W7hRiJWLOhh4FYp?=
 =?us-ascii?Q?mFD9mf/meKw2roQCjCo5kKRARWqI4wdXjutEj3HCWYAJuTLyEUt8OnDFLv0b?=
 =?us-ascii?Q?vgAuLbMaRzHNoovOzdcZYrvhRFXt2Loo938vw20bV7A2Q9jb1ESlSTRh+L33?=
 =?us-ascii?Q?uqdmx/UrxJRT5BJ+ExtMPWIltuYDlcxpKTDqh4jQOLksAqzy3oYVUCsRzqFw?=
 =?us-ascii?Q?u0viBWNIx20Ty/AmrxnAj983r6Y4SO8cbE0O94UO8VMODtL/vjH3kTP6fXfg?=
 =?us-ascii?Q?tkld0XBwoCHnh7zMoyw1Dh4Yyw5MUeyUp8Hq0Hzh6hyJ8OS1M72Ct4AXnLbf?=
 =?us-ascii?Q?NBA3gziXZr1ldkwNRu2iPvm1UkIR4Q9CwNktSQhmXve3fEOpQpulFv5m2Yon?=
 =?us-ascii?Q?LVTJM1jNw7n77+DY9WkG4ppYBApz6YqcV7Aw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OLAP279MB0055.NORP279.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gb3jIkxpkR8OqWpBP+NfDfICWu1mSBflDrZEHD5wCEW61Oz4/INO6Ubja+DH?=
 =?us-ascii?Q?ESSBZ8mF7+iKhC/Tbc9OkOL+P4A6oM5rumbCl2VJfuO9jxi4fOCBYVQrSIfe?=
 =?us-ascii?Q?y4VJ/vJCyb+Rq5O5Ekuby9RLzjUTdTSLWrQOb6SO4UIX6gU+OclOyW4Mko7S?=
 =?us-ascii?Q?TfWjuRJ3YxcpS57ecmGtpeW+35dNejFMH2BAJ5H1alYaMRu4I3SALQwHIF3y?=
 =?us-ascii?Q?HLvtqhzWXjVDHG3yBnMd4QZEmLSumGxajA2m1jOClWwTS4yCZELRHuKVSEsC?=
 =?us-ascii?Q?NssYwb1xeY1grlY/LMDnXwBWY7h1Qa383h73cSlaqrgtKYPrWoCZrhedBaXN?=
 =?us-ascii?Q?rA1/7es6Jzaj6EWAeSeVP3OHQRYnZmxrZpSWRymSVPr0Faot4gbS2iZEPFEm?=
 =?us-ascii?Q?kpMJP4ry5We4CSNPzI6uWA6w2AgkxBBVJyYxWu7sONw+WGx3CGHZ1z1vYB1/?=
 =?us-ascii?Q?COIW/YGi7xYXwsABhAWe67JupGGWD0IgDgxUJ72fiOxqJHGCs6cHm4o68PvT?=
 =?us-ascii?Q?qFcPpYzTW7dpXFyxmg8Y+Am2QkeEDMt9lR+7u44yQVMDHEMigtUOXyPad0cR?=
 =?us-ascii?Q?nPLdHipffXnU8KUeibF1EVImhPu8WZGoyE9V/4w0C6Bw94aQrpd68kiTuBaT?=
 =?us-ascii?Q?iGrwrpnFwrk3XbfZ8ySGnwfFgbJkDN5r5t3Jb3hk2jfXx4HZYEVw1+ibKhje?=
 =?us-ascii?Q?8+Ep33KIjghOXV0bYbqk2FjjWYOSVR7Rc8B/Q5n4KDEwIRdn9lGjucyZXdRb?=
 =?us-ascii?Q?PS7jZYor9vUisp58vOnh+LhlvdklzaztlkQqmqSYPQQaFFLlq2k67QOng67S?=
 =?us-ascii?Q?dDkuPSvwnOvnmROLDrac33HlVYAcWql5cc7YQwGtd6HyL0uAklxzfBSq6HJN?=
 =?us-ascii?Q?j198BDWaIqVXrom7BmNtE/ZWMEEan2te5HvKde6TxcGcXQva4/lFdyy7DSU7?=
 =?us-ascii?Q?L5kFy8BH2Amtvl02pfCh3rHs+X5TMDUYsE5cd8S7dxAMQPhmSiXJQMqMHS1w?=
 =?us-ascii?Q?D/eQZqk+aDdFY5RvD3SpaFHhlKz/hy4h7/K8WaySX5akI09cZJTzsjon7ro+?=
 =?us-ascii?Q?Eem/2Mt5xdzllY2bDWNfkN+gepsZeRT7hHN2N563cWR4MPuum7BtvIa4kAu1?=
 =?us-ascii?Q?ScOBorRLGdt2q+5WES1nWy1d1c7sys5esWqN6Hn2Wi2pK4hAq87ES1Femnxn?=
 =?us-ascii?Q?lwH7wIr0Q2KoxUPLflNNtHIk0s09PZ6EBy2wgIHpaMHkm/DBgdwFwGL++YjH?=
 =?us-ascii?Q?XHUaQh/m17pUI7fXolKZerD0R46dBhilM63F0sWGN+J8W4P95eez3E69h2SW?=
 =?us-ascii?Q?yfomLOeCF7wzCmX7yn5eVlgzcIJMyN8maxN9wRvJDSkuJVLK8RY7xKozELIQ?=
 =?us-ascii?Q?0GgVVRlEyu/YWn90c/LAEEbiWTMFUOUq2vP/wtc/b0zbucVyBcwu/igUkl7T?=
 =?us-ascii?Q?P7RAeDJVoYyeNMUW+tHb5aT1vTznc28W5ObAYSZL4vgzeWRSJVRJ5jyH9QzZ?=
 =?us-ascii?Q?xaX7Gznb3g2493p3H5HXGodGvo7nsy8Nw2mIdplpTxfmYS3GxWbT4TavEZA9?=
 =?us-ascii?Q?D4Grt6mcapqns2WnCrN5Rr80ag1se9F6W8gIhu2QdMMI/LP/Pfa9udJ7tIcu?=
 =?us-ascii?Q?JwnPAUR/MmVPlPqhCY6mYLiEFnbTDpURb0xE6NeRqkLDZXiljqhiE6IutJQI?=
 =?us-ascii?Q?Ubm2L4Cv736CN/T3ODlR8u9EKMuBleWqUOfgS1GoB8x58L4t5ZQS5toi74BE?=
 =?us-ascii?Q?lPPWH+3IZQ=3D=3D?=
X-OriginatorOrg: dolphinics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe9fe46-29c0-4b97-4f58-08de63182bbf
X-MS-Exchange-CrossTenant-AuthSource: OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 11:34:20.0389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7fb89e52-625c-45cc-a50c-adf3af1b0a6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n4JSSpEArqgWGJ0Vs2/k80T3lynSS8+MA2V+kzJQEgdfSaQ4fbXwyqXNrBOj2aXxCdgSEvmDAnw3BVu0sapTpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SV0P279MB1183

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

Link to original thread: https://lore.kernel.org/linux-iommu/20251215114952.190550-2-magnus@dolphinics.com/T/#raf80785292deb22aafe6a817424051ea0d1d28f4

Resending for visibility.

Changes since original thread:
 - Renamed struct pci_dev pointer parameter to unused
 - Rebased on latest master

Cc: Tore H. Larsen <torel@simula.no>
Co-developed-by: Lars B. Kristiansen <larsk@dolphinics.com>
Signed-off-by: Lars B. Kristiansen <larsk@dolphinics.com>
Co-developed-by: Jonas Markussen <jonas@dolphinics.com>
Signed-off-by: Jonas Markussen <jonas@dolphinics.com>
Signed-off-by: Magnus Kalland <magnus@dolphinics.com>

---
 drivers/iommu/amd/iommu.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 7c12be1b247f..404afcaf4bc1 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3103,22 +3103,44 @@ const struct iommu_ops amd_iommu_ops = {
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
+	int domain = iommu->pci_seg->id;
+	unsigned int bus = PCI_BUS_NUM(devid);
+	unsigned int devfn = devid & 0xff;
 	unsigned long flags;
 	struct iommu_cmd cmd, cmd2;
+	struct pci_dev *pdev = NULL;
 
 	if (iommu->irtcachedis_enabled)
 		return;
 
-	build_inv_irt(&cmd, devid);
 	data = atomic64_inc_return(&iommu->cmd_sem_val);
 	build_completion_wait(&cmd2, iommu, data);
 
-	raw_spin_lock_irqsave(&iommu->lock, flags);
-	ret = __iommu_queue_command_sync(iommu, &cmd, true);
+	pdev = pci_get_domain_bus_and_slot(domain, bus, devfn);
+	if (pdev) {
+		raw_spin_lock_irqsave(&iommu->lock, flags);
+		ret = pci_for_each_dma_alias(pdev, iommu_flush_dev_irt, iommu);
+	} else {
+		build_inv_irt(&cmd, devid);
+		raw_spin_lock_irqsave(&iommu->lock, flags);
+		ret = __iommu_queue_command_sync(iommu, &cmd, true);
+	}
+
 	if (ret)
 		goto out;
 	ret = __iommu_queue_command_sync(iommu, &cmd2, false);
@@ -3127,6 +3149,8 @@ static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
 	wait_on_sem(iommu, data);
 out:
 	raw_spin_unlock_irqrestore(&iommu->lock, flags);
+	if (pdev)
+		pci_dev_put(pdev);
 }
 
 static inline u8 iommu_get_int_tablen(struct iommu_dev_data *dev_data)
-- 
2.43.0

