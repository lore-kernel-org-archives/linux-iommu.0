Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2053.outbound.protection.outlook.com [40.107.212.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ABA1096F
	for <iommu@lists.linux.dev>; Tue, 22 Apr 2025 11:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745322057; cv=fail; b=YFWmxYAfcJQO7ADSEsYpkHsEtN9TZgdmbBOvHSkNTfI4+tN/2B2Y0MMvBByWdcyAGWpo/FvqTZkxACKfuMSKYfipPV2tlkDuGp/+gwZ4abYumQqMfWYqs3w658E7WAwcy9tSl55F5vACUiKxaiCD8qdREL9Wkw1gR7MprUP4vZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745322057; c=relaxed/simple;
	bh=YXzHwDNGX/zTYDtW0gSDfNvAkt3ZFbeFU/PJUzaHX4E=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=eEHRGiitpfs+EeIAJAj8ckguqp5pE4nnHbGsjjv6sAj2/C/c1KQcmJsqB5L8VvHfJUnMvI+LqiACEWxVFpSLIa4Pc0NwevS6YKUnkXca7lnE+5ImFPbdhq4SPGgfQFMX/Wx1r2pX0FlkrVyWnnGg3EJS66Dnxrj8kBOEnpML7qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oVdGZHnB; arc=fail smtp.client-ip=40.107.212.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oVdGZHnB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u9N0r/5aYnTp8xCAkkzWabim0zSSsZcJCzUIn/nUaFHpl0Q24UkyccqO95xOUjPVLNsfGP+iaaDOVnsEL8emQ2TUV9jlCbVkgoojVXaLDwMK7CMFEIr4EQHI18dk6m18s3UDgWRxsLXF1tyIi6tO9QJ87C35Etq7nzk5zavYBRSFnLYBUSD4YY8StGO2LPQPam9MP2YXkeYURdmexqrg4Gls/7xhRgzwNP7HCvHDc0pGK7kpNJG7l3jmaTkAs6H6B/ZPKca5S2ppf2oJBs2+9K/WbUEbPw+Snef71AhGQPDTwlBm9j01Iqw3EY34HHMmIZzHbR4lDMCLPXnsra5T7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XrwBnD6iPp4rcT9HD3av+aSK0xvkPcFQJsCKj3JKLGE=;
 b=CFmw8s3U9hVk7ZDWuEi2PXkpfa8Z3lD2HbX+4Kf3qy4lURrjblVhw87tLGKzKk9+X/3ubWt5J+6vo8jT+F85K6haAZ2OH82S1R78wkUgyT94Opvjdxv68anfZ1tMm9GnLiDNvvyE6kD4cX8lL5jAeIB18db+DMbC3Olqa12AJDjy2U1PosARt+RA6TfUpVuYXvZxLztWGIILoIL2bOVEYOMlD3WEplPGg0AtHIkDGP+pFwegrl82s98STd49ClWv2Cc6v0n5vHMIHcIUyldmTzNyhd4q3oHPb1G6T3CfQJ1fefScm2sPW0Ici+DfbGCl5RYlyPITWmWV1VQ1xvmV8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XrwBnD6iPp4rcT9HD3av+aSK0xvkPcFQJsCKj3JKLGE=;
 b=oVdGZHnBAUAqEpfsDOipDVwgP+9pqD37lNTcRNgQXgzisK8uG3++yftW4AGzsF0drdryImx5qfSvjymoIv+TjFxdjxmE+J20EQUUgAaioLR9qiYjFkuS8uwGRVmi/Epmgd2ivuz061tTVHQTgkaCC05g5OrZ1ZjQ698ZaTXMcOy+tE8sRJIis5vSzAGVry4soBxftEWoDjD347keYmhj5OqgwR4lNVmcYk4tIgefFgTSfxxnWzjvItm0VfnoucdOmvHU2l62d/hWhKV8b5h7QVsJiQrSENHols9MT6RtKcrEs2bVOcIc4qJ+WQmVN2KW+KtOGmeR5ca9Zl75Uj9pzg==
Received: from CY5PR12MB6106.namprd12.prod.outlook.com (2603:10b6:930:29::7)
 by PH8PR12MB7157.namprd12.prod.outlook.com (2603:10b6:510:22b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 22 Apr
 2025 11:40:52 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by CY5PR12MB6106.namprd12.prod.outlook.com (2603:10b6:930:29::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Tue, 22 Apr
 2025 11:40:46 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%7]) with mapi id 15.20.8655.031; Tue, 22 Apr 2025
 11:40:46 +0000
From: Balbir Singh <balbirs@nvidia.com>
To: iommu@lists.linux.dev
Cc: robin.murphy@arm.com,
	Balbir Singh <balbirs@nvidia.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Christoph Hellwig <hch@lst.de>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] kernel/dma/mapping.c: Fix warning reported for missing prototype
Date: Tue, 22 Apr 2025 21:40:34 +1000
Message-ID: <20250422114034.3535515-1-balbirs@nvidia.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0043.namprd11.prod.outlook.com
 (2603:10b6:a03:80::20) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	PH8PR12MB7277:EE_|CY5PR12MB6106:EE_|PH8PR12MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: 41bd8683-f5af-4633-6ebd-08dd81928522
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mVQmOFsI7yEl8/lQfhfj80D4wMrn15KU2t/Fi2gYUr2DXlv4wLojfOvCMDA+?=
 =?us-ascii?Q?/CKWu1DC3x1QQfYhmImrEY/pbBIMJwkFK6R9J5ACSpf7AbPgiNLgRmBdA5MN?=
 =?us-ascii?Q?VbqjLGcYopyD1e0iRwHJiu09QOsCl6+4TNjFz6XaTMtdW/16lmeD5Bn2hxDR?=
 =?us-ascii?Q?5uKfrM+fMLOnB+zRq0h1n4i0vHmJGDxJpU5KQ7Y/fzFCajYl0CSkdcuhXLat?=
 =?us-ascii?Q?A9bX4OPSDRHhAMSuvdITJ72whaDrKNoIEjV55+yFpJ+aZNQOx49+i9fSG5cC?=
 =?us-ascii?Q?BXQf1QqQITPYyjlK+315Z92Vwk97b8uuo8EBkU3DV+nDbZnIFybDeK7guln1?=
 =?us-ascii?Q?nLHTWqqJ7QmDt8nnUELiZ2ZvbVDB6ZgryGGDa+nydnz2i4jLxDLqrCwDg3P1?=
 =?us-ascii?Q?BFp1oYfJsgPB1ohlOh66J/424763ZsDtVAMupLJsDuaWVxuFWyiLJ9H5YSzJ?=
 =?us-ascii?Q?XGffxcGwm2KQD/e9uB5sCX004640EITTqa1LdMDpaTmuEj31awhrCD7wAcI8?=
 =?us-ascii?Q?GBl39OA1Za1BfJAWti9UsLEt+RbzA8K879pxG2VN9mBiaHBxWxXyUVjD+yW8?=
 =?us-ascii?Q?yWXtNF/xkjRAtQO0dfM0Ig9V7u1OEg3DPwMJzEjKr+/szhPs1bmPaXT/ys5+?=
 =?us-ascii?Q?PPNSSpfcRuO8GEgztsWkTb7Vo/eonkMR3KHpwPYKRf06/rAqQ0usHFw2mYIq?=
 =?us-ascii?Q?5495hoVZ9PDDh4eEus88d/ZzLEYGVIbvnV2Xkb/BY/5r2On4ng59doo5xk1H?=
 =?us-ascii?Q?PTMa0IKcr86IWhtV70sXtgbQKHTzgnj2Waaemn6O/AzGuGJyUoF5SMz8Rsk+?=
 =?us-ascii?Q?9Vdqlar2u4fbCVnrokiSB/LqbYnLu4t9Rw0ZwAqOkHRRRxw0w+V6iVJP/tVn?=
 =?us-ascii?Q?v0CaFhQTIqYfdkZ1odDxroWHuzJmhIjn9PdaeGOTKkf+jOItt4+7K1J6P5Td?=
 =?us-ascii?Q?UF14ZBAtcEVQ2bxH97+UfPl1fUddkZ/czOWCLQbk1KQyThFFVW8zbOj8WBvT?=
 =?us-ascii?Q?pE7MDet4h0vVfOBYgvctmidyn/hiWbc43LwCzoo+b0sKWQjkEO7LKET1BiLR?=
 =?us-ascii?Q?oWNhMObktGbRx6YCAMiTQO9NR/axg7X0h2HQ2WKdUAN8XEnYNEFuQuGOpTpo?=
 =?us-ascii?Q?vQCg8yP2SM8Kkk75TiKESajkpZkThMubnB8ZsCE/HJwdvBhgYXP4X/yhg7f2?=
 =?us-ascii?Q?yM/kknFp/u7Sz2nugG5NqXopeP+et00AtgkDMbmdOLk3qRI/ms16Ejg06pYM?=
 =?us-ascii?Q?3Pfv2H+BoNlSiH0Ofu3alkqUuvRlkpaI6Iy+lk+VWvapZ3VyoEdpVR7Pf10q?=
 =?us-ascii?Q?xDU/1KqRDo0smWgRNTiWEaHmaz9S1n43K52sPalwkdCgdZ67a29aNme5A2ri?=
 =?us-ascii?Q?rAY+sCvTyWl5bASCc1d2AVwnNQYRaWuTFKfN9SZjYKOkNRQlP0Xv0tNv4VkG?=
 =?us-ascii?Q?EM14yCxdR3g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6106.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7mjWIoHr8qsA37c+pyMFQiJgNz5QiJ42nMOlX6JKXvAHljSY0dL6zpb7dp+1?=
 =?us-ascii?Q?FJNn2IBag3nBqYC1GxPZjPMc2CZsNeaC3sFH8OKfwTDi9HdtSsncZ7Z2wIAi?=
 =?us-ascii?Q?G8kU1zP/yyXXbao6Hp+BeFFrvmEC4V62OlyfYSOjoe75mWW+Q4GrOLlI9ajI?=
 =?us-ascii?Q?LcKvBsbfbrNJ9dtH/cQSiYIER/LcNJub8ZaSluYgydwsfJXto8u2Xjmktn3M?=
 =?us-ascii?Q?x+C65kAMZZCBKFqdvTYaFIKPMS6JsTw4xne/VDcQvpVPqQzU1I2JjXCxIv1B?=
 =?us-ascii?Q?jLMVKL7v2s7MJr0BzRBWFJSWgi1/+F4SUWHX9VAxc6i05VsarkdrgHFudG9l?=
 =?us-ascii?Q?H4LFcVeP83Z7+8q2yP9/DeONM8mc6G091cYknlUuw6SPoIUaCUHr34xi6aUW?=
 =?us-ascii?Q?cGcqnac3G0GIlrO9t6vfO9taNv64mTfruztYwzFP9tg+i5ddigcMIDuffVDp?=
 =?us-ascii?Q?nvBtdk05Zeh1UJZPn+PjpgSSvgV4ZDT7A9cF3Pe2hSuQMRRcZHXyfbwccQgk?=
 =?us-ascii?Q?0XnKaN4SUL+atjzapgQkVrYkOz+8FdfTrD/t8NE0zFYZ7ffO/zRzzHnXmNqJ?=
 =?us-ascii?Q?+J2tH1SEDAP3xzJPqkXgJU+PRBsvg4TN2cyBtVb30d6Qaz+9Y2K/SEnMjqMr?=
 =?us-ascii?Q?Xi8H6Jnbw+CpvEFiyVjivpRpOXohEqtFgzqDeJnEHd0fP8z6q+BctFu88iit?=
 =?us-ascii?Q?H8AqAfI+/+m4+xVqQIeUhC4RIeHDVEtNcM8XHTI6ucuf1YjCrXz256yNJbFu?=
 =?us-ascii?Q?T8FSqRkBgnt55Awr8yLl9rmWoTJ90ZzaW0Uyzz5ObcjRBa7qWDesWBhNVwR3?=
 =?us-ascii?Q?/w9+G/tOeJbswe2jPzz/CV0yHVPlMNNZYLp261lOzK8hdvrNJC2SM04knK9R?=
 =?us-ascii?Q?hvhzlIT6MKEnRWwrgU16+VyabF0psTR7QxKQ/ZOT2JnArhXVmHs1B1WALsTy?=
 =?us-ascii?Q?ZB9ycOf2wYIlYNi06KxBP/+okbmaSSK/b4eP8ESbpNoq7iHghyCxrnBalfqf?=
 =?us-ascii?Q?4J/4zWS9YenefR5aJzfl7bkLee167nlO5DDGXOQUNfcAjmpDmg+8c5L6F3oS?=
 =?us-ascii?Q?96m4cOKvMshQt7FzhifzZeYMemWN7nRaLpXAARYFkIicFUhSj/Ixv4BmYcos?=
 =?us-ascii?Q?lA3Y9x2GXe9POQebZ1HPCktkka6vqlicYJtNTHgTM+LrGAsHoBj8vZrj1io8?=
 =?us-ascii?Q?RZfjwsruekGjQyrJmARD3B5uMuMUz0W0dK+fVvMkFI1MzBWKHYrDfPzG4xPR?=
 =?us-ascii?Q?A8BTzL9fcq6U4iSDyXxdkHBmAAoTkRq+oDyBn7U/f28xg+29JVGAqG77t0Od?=
 =?us-ascii?Q?dYHuyrfOd+XuZfI2t21XSSGfqh/G4ow4GRArvbuQTIPNrYuYFSvyQnlSfjIQ?=
 =?us-ascii?Q?oeFvdFmfmtO++f5zbd9ZZ6BdnXIWHdtNUbSLjsXPnRNG0wVMsRblMXBkmUYF?=
 =?us-ascii?Q?WD5IUJuVq0wAOXEzPfnaceMf/fb1QzmW/opea/fAbHNV+9iXFjqfC1Mf3DFG?=
 =?us-ascii?Q?dExkbi/Sa8LDH1OsHcSencc3UKcM8Bk/0CuXtoQCgNFPw1JgiSgIC6igLzx6?=
 =?us-ascii?Q?frGMreaJWeWz74mAVFeEsfh9HmHOoR9xqINV+m7o?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41bd8683-f5af-4633-6ebd-08dd81928522
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 11:40:45.8754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I0Jigj9FnhcoZM0xnSJZfDUgoIZ15DLxKb2qhC8e2w/kqIrXejFKji/AHvT7w/YPRoBcxU8tvcllWqhkwa4XsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7157

lkp reported a warning about missing prototype for a recent patch.

The kernel-doc style comments are out of sync, move them to the right
function.

Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202504190615.g9fANxHw-lkp@intel.com/

Signed-off-by: Balbir Singh <balbirs@nvidia.com>
---
 kernel/dma/mapping.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 67da08fa6723..051a32988040 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -910,14 +910,6 @@ int dma_set_coherent_mask(struct device *dev, u64 mask)
 }
 EXPORT_SYMBOL(dma_set_coherent_mask);
 
-/**
- * dma_addressing_limited - return if the device is addressing limited
- * @dev:	device to check
- *
- * Return %true if the devices DMA mask is too small to address all memory in
- * the system, else %false.  Lack of addressing bits is the prime reason for
- * bounce buffering, but might not be the only one.
- */
 static bool __dma_addressing_limited(struct device *dev)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
@@ -931,6 +923,14 @@ static bool __dma_addressing_limited(struct device *dev)
 	return !dma_direct_all_ram_mapped(dev);
 }
 
+/**
+ * dma_addressing_limited - return if the device is addressing limited
+ * @dev:	device to check
+ *
+ * Return %true if the devices DMA mask is too small to address all memory in
+ * the system, else %false.  Lack of addressing bits is the prime reason for
+ * bounce buffering, but might not be the only one.
+ */
 bool dma_addressing_limited(struct device *dev)
 {
 	if (!__dma_addressing_limited(dev))
-- 
2.49.0

