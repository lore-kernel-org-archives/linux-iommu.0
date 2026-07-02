Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010008.outbound.protection.outlook.com [52.101.193.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C463C7DE1
	for <iommu@lists.linux.dev>; Thu,  2 Jul 2026 10:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782987930; cv=fail; b=jNgUWPrmP8882ti1fc8GCIovbJswTIL0zNcORAkAMvZdzwVTyoAFWq2o4dV3RkQXIzysplLFDfesfX4V1RFuYSypG3qJSYx7UMUl7F5Xoi5qZJsZyfMUeUxcSHJd61as16YE80oofQ/Y/h6NlVsd+ZZa9lDAVB5V3+fW7BSgoZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782987930; c=relaxed/simple;
	bh=4AoIOT7bTj4K+xtLNVy6g6Z9LwXKfIHZwt1avopiZ8g=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOAP35R8PFoHUC9nmedCCLb+SAgnPl405jmvFozsugqmCmA+iGtLK2fbIh38AM77D3oNMH/ZrIAawA7Vnyb7XhqvheM/T2swngu/6zNpUJlMiUTeJl8oEhk2RoQTBoq/va3i2p1kLUQJ53VV5SIg+SKc88VuSFQKjfJw09bB+R4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pCbjNNoq; arc=fail smtp.client-ip=52.101.193.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pCbjNNoq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cYxCIaEemu/q1365zfcR5bYa2yc/z40qYtZZQHVnY0FF7OuYONjEi5HNtzNjeNSM61UMy2SFz6Hi0nLM4m/zg8z8MDpfdnEEK2yy7cJYXTbJoByy4vsDmqBqMNB97iz722insnucVQFEZ5RGOXdf3QOVjn+q44l2jtzCyLfoi8jGZ5cF4DPkIIJlEsKEcGZwIV04ojUJyTyGUP7Wu9mlYr42Lcn+Jj032+M91GKEqlHagyRBtbAp38V9aVaW8HetHppaU2xGNm9t2ZfC/K2eqVMaiGVGBdwPLvGsnquT1xkLmX5ecBlVpOTuxZLxV5HkcYEoNVwPLSgHMJkdGRjYrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HyXbIFwy/u0adQfaL9fjj6nbSogx9FEFmkEvE7jd1nU=;
 b=dBFNxG6dhQ+tqdR+lKTsF8yKhB00OGr7BEciYhyBBalJoJoUnS5QGdVHHidfhE/MAxdeUvX2LfSIr5p1sAGBny5qW3T3jgorEML2W11PpDtnP1dK7lXhwdk4t/oBpozpEnQW59JJeBRa1R5XWqSmEySql+msvT+9FpX7lGNw7kxb+eRYrTd8Ak/Er7YvAjQE8PMK3l/5ygpPo5EeeW6m0mE1kCI+ksZkjYWOTXpNXO3Hzqa8dnb5XU2FFvKkybTCQo4tFi9DnLOsW8mAKKleUfVtBtFSGSC7Wn0Uf118qGqyIJdnw5lQT8WNDJY20dYEQWKGPOr+tmRfR7kflAcUgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyXbIFwy/u0adQfaL9fjj6nbSogx9FEFmkEvE7jd1nU=;
 b=pCbjNNoq4QNJBEnkxMyhgou132CDTxePB5Vs8AKLbMMGBXm010Db7iNRcLzdYkT3rGc2MIIx4VaPpnvZIx98yHUOYoM/uCQcJaYo04beBD8vMGkDRCBnUIpx0UumitSnpf1yK99UsstMbl4dos+FzgYO+6QNsrG7Ozc3GuMd12A9F/lTdLHBqLuN5cKPYkPG4feJyItKbW7YE4yVZkBsf4qxUS65VCIqyEhsxCGZRHw1S5rbxDKK2f0miL9B6Vv/ySeZ2H8BhfINQcUc3ub5IUPi2zzOK04quYDQMGObtOCMAhHtH5s7A8zEpZ9Uv8jWQDASdQndmFYhtoqFNHxG7Q==
Received: from BL1P221CA0043.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:5b5::13)
 by IA1PR12MB9063.namprd12.prod.outlook.com (2603:10b6:208:3a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Thu, 2 Jul
 2026 10:25:14 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:208:5b5:cafe::8a) by BL1P221CA0043.outlook.office365.com
 (2603:10b6:208:5b5::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.10 via Frontend Transport; Thu, 2
 Jul 2026 10:25:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 2 Jul 2026 10:25:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 03:24:59 -0700
Received: from localhost (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 03:24:58 -0700
Date: Thu, 2 Jul 2026 13:24:53 +0300
From: Leon Romanovsky <leonro@nvidia.com>
To: Honglei Huang <honghuan@amd.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>,
	<m.szyprowski@samsung.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <Ray.Huang@amd.com>
Subject: Re: [PATCH] iommu/dma: free the entire IOVA reservation in
 dma_iova_destroy()
Message-ID: <20260702102453.GE65299@unreal>
References: <20260701092033.422867-1-honghuan@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260701092033.422867-1-honghuan@amd.com>
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|IA1PR12MB9063:EE_
X-MS-Office365-Filtering-Correlation-Id: 79b35759-075c-4f65-672e-08ded824344b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|22082099003|18002099003|5023799004|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	SD/B9KTbkbNVrY/QnNXCPwLOnfEgnkM1FQlHTFRLGzucoPcFn49vMaDmZjOtvycQmMb2eY5IuhJKjbI36zV3CTgZPkggPtGNlrESfz/gytJo7AZdVq6be02ZDc+X+40bY5ROtWpchDMP4d5Ecz/OjP8dOLlzQTcyrZ7gdBBh9sN2cTNA1jrsiwEtT/oAc8hSnYMB+PkFvKmV5IDoYhfIvDYt7Q1pJDpkiwKYLuul58SmaZ8cBqIttwKO3ZnLAgJjj/D2WzmgXlQTy36kboN6wMbRl1aeStkeCGy+niNVPRO1vG70xZPyTDD1PqmhsWPeZLyZCGR+ZIBwaCfcFbku/IGj4P0f40L6gEYZNXxLnEucXwxtqWQrV7vinnUSXLBsajlfIh42PuOQqURlfmZTj570tAcFnmTB9GsPTJoYpglRlNv5jgegxHMQIgjrbWYfQAb0PvWrjBc4fbUHuTANNT23a94mElSlFdGnOVOMykKimMZjRwB0II7X3kwwS8aJpXHMqgTP3woXFJhNDO+eajnp6lRz4YaJ+HW7gTLIlTRaK771Re3sqACtprSO6I0xVy6zdwXLm+NMPRE+X1OyqU/lqUpnRKUYJa+Jq25s+MoHXvM0Ku0TnT01cn8bJY9bS9gU1RLdqJFuTQqRrol4zKA7p0ogcj8U4P5dRRkyRV2acPJbUOi9ZL0qgxQcXSUdwQ7az5NivScDFaZAbEDlbA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(5023799004)(11063799006)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ROV4QQytrOV++pTFr1MusYpZrb4Xbr9E4OrYqQwFuCWR+A9zMkE9q9ePQM28f/7+ankBs/IwJLtkdKCgE97y9Nm76I+b9uBk4vAgRq6QZmJaq1owvNPxo4d8mWq1EX1uABD/kauNfbmjsISDTscRJCd7JEQE2xJw0R1Jovp6UjeYZ3mialX+j92bJ1E9AN5Ydbw5aOO8FKPYXFM6/JtDI5DbZlU3PB6x9W/sYqNoCZG5CBT8oCawrhAhyKRhxA5gikl9lLXEdQ7hD5YjUG+8+WnY4LxQxEBM5IehVQwQPykVKqR02b9kQyHwtmDKWInuJ4lv3T8xvJyWhKxGhoROqmzGJQcmd9GBMKQjGYL4lirRCXCAch7EsHaWcP8S8pcxdpB+yXkGkbAK/LnMWTynuWutvf+7dUu7y80snB3qJ5AjyDUE9dVOih6F4pxwwMlF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 10:25:13.9148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b35759-075c-4f65-672e-08ded824344b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9063

On Wed, Jul 01, 2026 at 05:20:33PM +0800, Honglei Huang wrote:
> dma_iova_try_alloc() reserves IOVA for the whole requested size and
> records it in state->__size, but callers may subsequently link only a
> part of that reservation, for example the drm_gpusvm mixed range case,
> where a device page range is linked incrementally.
> 
> The doc for dma_iova_destroy() is:
> 
>   "Unlink the IOVA range up to @mapped_len and free the entire IOVA
>    space."
> 
> However __iommu_dma_iova_unlink() computed the amount of IOVA to free
> from @mapped_len rather than from the full reservation. When the
> reservation is larger than the linked length, the tail
> [mapped_len, reserved size] is never returned to the allocator and
> is leaked, contrary to the documented contract.
> 
> Free the whole reservation using dma_iova_size(), mirroring
> dma_iova_free(). The unmap step still operates on @mapped_len only, and
> the same iotlb_gather is reused so a single IOTLB flush is performed.
> 
> Fixes: 433a76207dcf ("dma-mapping: Implement link/unlink ranges API")
> Cc: stable@vger.kernel.org
> Signed-off-by: Honglei Huang <honghuan@amd.com>
> ---
>  drivers/iommu/dma-iommu.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 9abaec0703e..bb29c82d1c8 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -2096,8 +2096,11 @@ static void __iommu_dma_iova_unlink(struct device *dev,
>  
>  	if (!iotlb_gather.queued)
>  		iommu_iotlb_sync(domain, &iotlb_gather);
> -	if (free_iova)
> +	if (free_iova) {
> +		/* Free the whole reservation, not just the linked @size. */
> +		size = iova_align(iovad, dma_iova_size(state) + iova_start_pad);
>  		iommu_dma_free_iova(domain, addr, size, &iotlb_gather);
> +	}

Probably the best change will be something like this:

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 9abaec0703ef..56173e24c8cc 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -2068,10 +2068,20 @@ static void iommu_dma_iova_unlink_range_slow(struct device *dev,
 		arch_sync_dma_flush();
 }
 
-static void __iommu_dma_iova_unlink(struct device *dev,
-		struct dma_iova_state *state, size_t offset, size_t size,
-		enum dma_data_direction dir, unsigned long attrs,
-		bool free_iova)
+/**
+ * dma_iova_unlink - Unlink a range of IOVA space
+ * @dev: DMA device
+ * @state: IOVA state
+ * @offset: offset into the IOVA state to unlink
+ * @size: size of the buffer
+ * @dir: DMA direction
+ * @attrs: attributes of mapping properties
+ *
+ * Unlink a range of IOVA space for the given IOVA state.
+ */
+void dma_iova_unlink(struct device *dev, struct dma_iova_state *state,
+		size_t offset, size_t size, enum dma_data_direction dir,
+		unsigned long attrs)
 {
 	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
@@ -2096,26 +2106,6 @@ static void __iommu_dma_iova_unlink(struct device *dev,
 
 	if (!iotlb_gather.queued)
 		iommu_iotlb_sync(domain, &iotlb_gather);
-	if (free_iova)
-		iommu_dma_free_iova(domain, addr, size, &iotlb_gather);
-}
-
-/**
- * dma_iova_unlink - Unlink a range of IOVA space
- * @dev: DMA device
- * @state: IOVA state
- * @offset: offset into the IOVA state to unlink
- * @size: size of the buffer
- * @dir: DMA direction
- * @attrs: attributes of mapping properties
- *
- * Unlink a range of IOVA space for the given IOVA state.
- */
-void dma_iova_unlink(struct device *dev, struct dma_iova_state *state,
-		size_t offset, size_t size, enum dma_data_direction dir,
-		unsigned long attrs)
-{
-	 __iommu_dma_iova_unlink(dev, state, offset, size, dir, attrs, false);
 }
 EXPORT_SYMBOL_GPL(dma_iova_unlink);
 
@@ -2136,14 +2126,13 @@ void dma_iova_destroy(struct device *dev, struct dma_iova_state *state,
 		unsigned long attrs)
 {
 	if (mapped_len)
-		__iommu_dma_iova_unlink(dev, state, 0, mapped_len, dir, attrs,
-				true);
-	else
-		/*
-		 * We can be here if first call to dma_iova_link() failed and
-		 * there is nothing to unlink, so let's be more clear.
-		 */
-		dma_iova_free(dev, state);
+		dma_iova_unlink(dev, state, 0, mapped_len, dir, attrs);
+
+	/*
+	 * We can be here if first call to dma_iova_link() failed and
+	 * there is nothing to unlink, so let's be more clear.
+	 */
+	dma_iova_free(dev, state);
 }
 EXPORT_SYMBOL_GPL(dma_iova_destroy);
 

>  }
>  
>  /**
> 
> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
> -- 
> 2.34.1
> 
