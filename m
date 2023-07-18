Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325B6168BC;
	Tue, 18 Jul 2023 19:06:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8gBb6e4W9vlsqAcmiD3oBHKMBt83MkWOl6BqM91JtRiGdanXbAsV91crrZCe/bvlfMy5zH2s/cz/eeynelY4Yi4NTXdZMaP3lux5TlaL231GIUhUDARjVwxY9RgbTKyfI1bmFVOPb/TKPsNHaryk+K28ntuOUn42R3d0HElidS3bztShTSnTTJ3kMNrfJkVgvl84DHSktayanQFffPTQIv6Z22gkk2LsUAUYn0XgrcKiBQAzBf9grPXhoBC+xaIMXG7f9mxVuljQB2gQxVekKaVNkxTCBTuJi8uYrKI/wtHbEtYQwFXBDOR/gOcrDNtZ22t4b7IFd7DMwY+I4/z7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WsVGvn1CLzcH649pQIKz9cVx8Rm/xdS4JuFMWCG0qS0=;
 b=NNO9ETZRk8xKe83wovrL6zkCE85Qle3dNUG7f5GIqW6BwNhadX9DclyOywN5AZBQ1lSrQbF/CO0T6jH3JzgfI9Y5wvqqle53+HZdkxIWJstlrAY7jW3zc+T+8wrb1Uj/XCAVfddz2d/wSNs7is1jfL6HWivbxItMLVldIjI1HGHOvRxOhiWC0AZrSqrD7P66tck5XsnNtkP6+kWHJ6oqa1/bZHtmptw8quAqeYbvfMfBxeYRdXPweH6JvAgZ4zOvkmdsfasEDqusT3m2NKJOyWvwhoHl6a9oHaS0h+xanA3PDWXQdCOPja7dOZVdHnpbV0saVUAfbreYoZuTxxmMuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WsVGvn1CLzcH649pQIKz9cVx8Rm/xdS4JuFMWCG0qS0=;
 b=hQvpA+lxTz5wGXZc8GAknw6ktHYpCQy/I9YoQ2quKCCb0P6cfkJShLmB4od1lUbXP+tQ48vRktn/EUaKYOPLdcA8T3tpFIHXRyu2dRs59OYXfO5IyVuLtYdmc/divMeITchhMdInaj7LiZIYDY/4H//zqWkDnqqvOvKyy3INe1TgcXJ+6bPi2Z80uCwnQOS9r/rXGc+8qXonAszfKf7MOLmt++R4aXys/prSTTTVlB1E63hG8KxiOhTuSlL9967XQtiCg7yN/tIP35JIsqFBq13jp9VjLiO0Oi+BQAmoEZGp10JLf+YORkYwuWTZW7pvCGdfMUS3vEFBIWeKHOOp2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by LV3PR12MB9329.namprd12.prod.outlook.com (2603:10b6:408:21c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 19:06:01 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 19:06:01 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Heiko Stuebner <heiko@sntech.de>,
	iommu@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	Orson Zhai <orsonzhai@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Holland <samuel@sholland.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Will Deacon <will@kernel.org>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH 07/10] iommu/ipmmu-vmsa: Convert to generic_single_device_group()
Date: Tue, 18 Jul 2023 16:05:55 -0300
Message-ID: <7-v1-3c8177327a47+256-iommu_group_locking_jgg@nvidia.com>
In-Reply-To: <0-v1-3c8177327a47+256-iommu_group_locking_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR04CA0034.namprd04.prod.outlook.com
 (2603:10b6:610:77::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|LV3PR12MB9329:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fb92bdb-ba00-4676-f696-08db87c2062e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hlAXMSyVIbdanwBuBtrtZUvcWBar8IoWNa/ssUdPmsrz3i9o+GtMlSZpkzgTwmogDFcyqzQxeT3hXGpPnwLB0ZguwE21HxCBNWcKZ0GMl32vnN9BQu/T1E62nrZ+9fY3LSDjou3KeKgRxREYu6N/bU4ZcU7KDl0ffhirBwEuh7+4wu/GXYmhj0+dUOWliijiZTfLdXUdg/8BuqWNFI9ugo6wXqy876puwdn2RvekZgbNJcGHlKyfYHyyncambHeJzSeJyYlXDoVYmXkT02IQNgI06z7rG5BZGeTkqwqtfIy9RvH5dgGNhXpv2VPC+tzLBzTHPHYiSnAJviFoOAUwEFRLepHeyK/qjSkX9blvXtDuyV0jWB3nAr+IFzvJCTDo5oi4QyH+r8L/CuOxEpawK8cAfAPSqRRPqOh1oFcuN2CVBS6qjro0JADqBi6bfOP4EjOP8K0gArND4Fx1YRVdna08biRbZPcq/4SV3bhfwhOLKDyMHCp1Q/roaG0WyV+pzeE38znNOJCkMAJNWOcMV6+fGHIVywJycvWgHHpBdTejIwluAAKVoKs952rBFwNiiiNNlspmSBJarNXYJ+8M6hXfJgyEXIgtAzRvdxUSxzK8+XXZNBq4ZESjBkIeUPI5sAfcXp/lxgwDsBU2sQ+8/A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(451199021)(2906002)(110136005)(6512007)(38100700002)(921005)(2616005)(83380400001)(186003)(6506007)(26005)(5660300002)(86362001)(36756003)(8676002)(7416002)(4326008)(478600001)(6666004)(6486002)(316002)(66946007)(8936002)(66476007)(41300700001)(66556008)(4216001)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qs85dXeNUQ1t3c2bR9ULYBC5CsVpLnvOuQXxjIS+rdrw7jyodMwf45eARpJW?=
 =?us-ascii?Q?w9xR9F+M32lcVOfbQxu4qyGcN5kKPx1+BaGCnHoAh2RZF7mSR7q87yDDYSqU?=
 =?us-ascii?Q?nBCkyZjv07DxaMmXNWV1RQl6FkTt7mEW/kaH8upyq7PcES9arJMmH0ykLPLe?=
 =?us-ascii?Q?RoJdbQa/RI5xpjbXJ7nk8aXKHje9sdEZK1EKJi/eIFippUbKwVEoG5njKylE?=
 =?us-ascii?Q?8IEzgS+wYJek7FQTriQ+tcrROYv5bNrYh3pQwZFs+GgyzWXn2CYtzmddIvAt?=
 =?us-ascii?Q?wOorP5qk0jqkrVexrBPp19kknVLGsHeYSKQJee0K6h2YpBk4++DOI+d9i/gw?=
 =?us-ascii?Q?KMMCL6ffmAPtMKj+/hwAFGi9dgKBvSnL95kaqXanm0g41h4HvASVMLrkD48C?=
 =?us-ascii?Q?iwsBvAn3HatFXx7EvHHshUgO9SYqVwYdt5jIE/wZAZ0hHhkwq+/WkRkNxNpK?=
 =?us-ascii?Q?tozwpkvEFVyXXsJ47GS1YDo6RCzwhDlhBVMI8VkvE9IpzhWVuR6bZ9pmwgbg?=
 =?us-ascii?Q?TCtvDthBPNHOKrVzEpT/PdP/Y7Guux3gfGU+zLqbNpAgq5oszjwEqDaDLjwq?=
 =?us-ascii?Q?awapOHBE5sXKzjP/I/4kGY0CEi/pKDZlOE3eDEYFmJ8tWGOLj7hclDv75WD1?=
 =?us-ascii?Q?uXK+wSNP2Fk6MU/ccV59qqexd66oX3vtfb9Yg+0VPUUySTV4DqlY4p4zCW/b?=
 =?us-ascii?Q?89IGrIitWKkmPXP2HouFf1BpTqhffD4jGcsXQMoRvOW8gshBuiybXUmNPssQ?=
 =?us-ascii?Q?E8MRoriW0lUjCTUNXTOkHoBpuuHM1GyTO1EUL1yP5CESQw8syA9GcQW5CEbq?=
 =?us-ascii?Q?eCboAp4UPvoaHtw9KAxw8uVY95CL1d8OdPVcluV8SckEGDT8j8hDYTUsy/Uu?=
 =?us-ascii?Q?PIw1u6r88PRfqAhuUghZAIB46ITUzwKvjNHsqTQmu+z9ZLVV//c44gAVO5Fk?=
 =?us-ascii?Q?ResfaBL6JePg3u6ZFCVXTX4atxxEf7hwRcFKytk8s0TvMnbuavqGIw5HX7ob?=
 =?us-ascii?Q?eaxdLf/5vmxmHZiu2j1Hwsd5rn4jmRukSUD8bfQt5jMGwAaQGmVBxVZOTuSb?=
 =?us-ascii?Q?EssWuueun2lGJChD2cYDcH4kT0dXZkkKa0cR0pu9CU7q64d+GxBu22xtoXge?=
 =?us-ascii?Q?2YpwcnBYPlAay5mu3nv5iRvuS/Mu37jYlzKxfp6nMOD3+8ybihUaG5f7UXp7?=
 =?us-ascii?Q?5eqxTj/+ZSkm0b9xoUtrch2D/Qw/pa+U8Jfg+vpKT2bMz7+1wxTPFr5x+pQD?=
 =?us-ascii?Q?dj4x5WZet2nYQ09tqk+gM9koxbx41+B7dC1z01HiyAwAtgnrCD6/WJA1Bh/M?=
 =?us-ascii?Q?fZDW54/YWpp/X4aqj572zQu+8wKc4++jx6tqsvqczb7CFxtlukbfP7zQAsJu?=
 =?us-ascii?Q?d5tCsxv/x78A/b6T5MImJJLMK+4C7TRFIgbHDw0T/Ga+w6WhXZuwt5EuROYp?=
 =?us-ascii?Q?XXm/6KfEM0diwMp7nmxZmKVesPk9LFvrktSfhhdkDteFh5tXgaBnY5p143lx?=
 =?us-ascii?Q?84nJXHadjsqzvV7m3pTZMcAbV7caK2s8S4HWCFPWySvXbNAXb/A+h9muRR3v?=
 =?us-ascii?Q?jwVFeO1YaKwo4xoCv7MU35E3xTRaLX/Xi0XdAnho?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb92bdb-ba00-4676-f696-08db87c2062e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 19:06:00.1834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xn3fkm/SMRAnW668dEfmGhtRda7gQauv6AbwAOnoke91lDieonY/1JH3TV1bcAAg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9329

Use the new helper.

This driver is kind of weird since in ARM mode it pretends it has
per-device groups, but ARM64 mode does not.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/ipmmu-vmsa.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 9f64c5c9f5b90a..55b9b29221461c 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -63,7 +63,6 @@ struct ipmmu_vmsa_device {
 	struct ipmmu_vmsa_domain *domains[IPMMU_CTX_MAX];
 	s8 utlb_ctx[IPMMU_UTLB_MAX];
 
-	struct iommu_group *group;
 	struct dma_iommu_mapping *mapping;
 };
 
@@ -832,28 +831,17 @@ static void ipmmu_release_device(struct device *dev)
 	arm_iommu_release_mapping(mmu->mapping);
 }
 
-static struct iommu_group *ipmmu_find_group(struct device *dev)
-{
-	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
-	struct iommu_group *group;
-
-	if (mmu->group)
-		return iommu_group_ref_get(mmu->group);
-
-	group = iommu_group_alloc();
-	if (!IS_ERR(group))
-		mmu->group = group;
-
-	return group;
-}
-
 static const struct iommu_ops ipmmu_ops = {
 	.domain_alloc = ipmmu_domain_alloc,
 	.probe_device = ipmmu_probe_device,
 	.release_device = ipmmu_release_device,
 	.probe_finalize = ipmmu_probe_finalize,
+	/*
+	 * FIXME: The device grouping is a fixed property of the hardware's
+	 * ability to isolate and control DMA, it should not depend on kconfig.
+	 */
 	.device_group = IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_IOMMU_DMA)
-			? generic_device_group : ipmmu_find_group,
+			? generic_device_group : generic_single_device_group,
 	.pgsize_bitmap = SZ_1G | SZ_2M | SZ_4K,
 	.of_xlate = ipmmu_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-- 
2.41.0

