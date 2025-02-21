Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0840820F09A
	for <iommu@lists.linux.dev>; Fri, 21 Feb 2025 14:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740148807; cv=fail; b=mQSk0Y+L+4GVLX2ih4ad/ZXbqawp+CBc3Kn+0u7+Bc7NXZ6RJdxH69996DThG0HQIFHNDW3oSEoIsrN7mu5hbFxWOyDA3vAkpRGLleVTPhHcZsp8qqivJSIyWhTZEb4MZjJW+I4ggyu5qV1KpqO/1eP9f5rEXGSPWiUDOhOPe48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740148807; c=relaxed/simple;
	bh=X132arYIZjvsPpgLhK/lULynVXPcLeuVMsMu2gOnCKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WgAMjDy/+Wfu3qjgXHBkWFGtcPHKY3aMnZ/qysp7aCgoR8IK/HFixdff7BpRdbRxJfDIAF6cd2o9PCD4DyycQl3Ykd5Fd+v/nzUhBOMCqz4Bc856qYhgeBhZFREapLvr+DOnKgDNm/BTIw05V14k/KlOPS/54Rr3c2bON6qcpUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mhj2azbA; arc=fail smtp.client-ip=40.107.244.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mhj2azbA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JvhoVNj5pEW1RZ5dTchAQALOOynesCf37NktVfiQrteHKqLyTQ5McqepBs+pxD2ncUbLAAiIFEA72OglSoTDlusVrqfu+pjM+cU0pGZog2ACUy3YUTfcsIPuOMLL6rSWmJ9L5b5gQmsEdoid92fsI/rqJgDDZHKNR7p+PM2Vkee8jTvLT7c+I1nJm5oaL1bEClrgTgukChQmCt2l1ComM8nPRcEmujMEW7skIRoyWc6XQop52IDVTu7oArEXfCY35xV03/N8EHsko7s9+v2QGT2Jj1+8q+JRD4hG93zo0Q9L83peb4LZNUY1vNxI8DPly97HigziJgLn5pNZrC0v2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qlzm09Y9ZAFVMMN9IJvuEgnpuDYOwvZRNpilFRwBSlA=;
 b=k8Qb7HWpEYFHWP+oTdzKRR2A0kafdF0LiCNSL0D+cYn5w2RwioGL8QiddSFuWsVmn/aktG6kvJKfl8HsALwSpugpWM+aPpcrRsxyB4jYw8G3F4QXtRNPojNdme5lnycJTBHulkFjl7yJlKmK0SSVuzfxZNlXBLGDsPXNY/VUBFuHgMyOB9Ez1XLlPevXWSM4WOGlKRA7CH8j37ZNctacHROvw2IhH+l43y63axB0W+bsRtrMwpLaBFJrJD8+jR1OxN8cIKh68OePzgVkbP0hHByV2ase9L+u8omcgBPBlMkMVy212xu42UstbeOdZ9xPW6h/cgJxH+jPA4FKn+bU7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qlzm09Y9ZAFVMMN9IJvuEgnpuDYOwvZRNpilFRwBSlA=;
 b=mhj2azbAbjX9qE9lv85RN0fOIz2Cv4PyxvT93VYMg+59DD9Qoi7IN51hOIlXgQ0jHUNrtsUxjNk+LBk2u4AMp1gaB1mEsxdVkK08sQwuakSnHLs4VJfsbegxbCh1WgOgGkkyDTeRCqkqgoAp1bZlip22oE53qdDQmPYUsSGsq9Jb9Ns2RFPT5WiCXDqTs0/9TmElEqyaRBVX6XSnbhihzFgjecGoBTmDmw5BB545mJjKnb4bbs/hhJ+RxdBsxDZawZ6G5bWqF/ObYbkS/YahHgH6HGZV7bTC6aQCzTmxQZhljYQAW+wK1ZkD6Yqqkb6Pj0qljRGH1rYgBhIcP2KBZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS7PR12MB5864.namprd12.prod.outlook.com (2603:10b6:8:7b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 14:40:01 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 14:40:01 +0000
Date: Fri, 21 Feb 2025 10:39:59 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, tglx@linutronix.de, maz@kernel.org,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	shuah@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	baolu.lu@linux.intel.com, yi.l.liu@intel.com, yury.norov@gmail.com,
	jacob.pan@linux.microsoft.com, patches@lists.linux.dev
Subject: Re: [PATCH v2 7/7] iommu: Turn iova_cookie to dma-iommu private
 pointer
Message-ID: <20250221143959.GA272220@nvidia.com>
References: <cover.1740014950.git.nicolinc@nvidia.com>
 <949e28875e01646feac5c4951b63723579d29b36.1740014950.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <949e28875e01646feac5c4951b63723579d29b36.1740014950.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0448.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::33) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS7PR12MB5864:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d79e37d-3606-4ae6-b830-08dd52859ea9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7bAMF55cadcBuP0HLO8/NuL/Zh3cebhOyw576cvNCv6tsUsNRUwJyH6pJPg5?=
 =?us-ascii?Q?41I2f/emcdvRuQ5BU40k1mb/8gfRp/Vyla4LUG9Za46Z4oaBtxQvnxBIoRtL?=
 =?us-ascii?Q?p1m9JlUkb3LfcOp2ae9Va5JFSfq5PdjOPZ+3k2bvqxe8kM2NSyM01hOcVzGs?=
 =?us-ascii?Q?tjHYp3MvgLmfRhaCMpZ/52khYOWeXLMQ0LJ0tjz6QqflKncyFbKCw7ll7yiY?=
 =?us-ascii?Q?GJsoWw8HJQp7gYP5TLD4s+tOPEvAazbMw9zcKdiY/MEdafIB/G3ogU5DyZMT?=
 =?us-ascii?Q?E86Wq2D5fxqu4Wb4zRF+bV6t8JqRRi0o1zIeJX7iWpYaDmpFD13UU3fOQAA4?=
 =?us-ascii?Q?/XUTBNU8Fg3UTWRmRVs3rkDSIsjC1cVeIcgUHFqbgVUhZpgQj2QtBteDrcGx?=
 =?us-ascii?Q?2Ojub95+Pj7rN3dYzXCbHJ/1sNK/F+K3tiHtKLWBWkuvN1etMetdyReBvJEC?=
 =?us-ascii?Q?kCgTt/g23+/Jw9NnCmJ5v4SjjrNfO4d+JEksr7lSJo7h0Vu+f8FvzP/6Hzsf?=
 =?us-ascii?Q?+R7Z3CNKL0R9hf6GqMHHMp4lRsLDke2wPs9KnbvRdIpldYB30jx62u26eOad?=
 =?us-ascii?Q?EYj81HvNHqyhwR8Su+jMbVftQsnjbPeBmguXoHUq5Oroxq5OhiBAyg/nqPEI?=
 =?us-ascii?Q?68GVCw7vX4gzPgvlZWNzc2t8cDrf/OS1MAM+QgrOTiX3p3HGVDvkA5Est4tm?=
 =?us-ascii?Q?c8F79cDn5cfMSDK4lL6qypcDazvTCor4x8Q9ITkl59cMScgKq4loxKW81FGd?=
 =?us-ascii?Q?scwrifXTDlIwlOsqxm6BdcEUU1AwTZgPtow7/BXAUBgZcHhQKWVfXX3wswy5?=
 =?us-ascii?Q?ggfRYHoFytks8w/4mGFzyhMfbF4xXdIWog1jU1bBEWzaZNc+LlfmCvHfGHV4?=
 =?us-ascii?Q?9GsKLxBb5B7sXXmeM/kbDgURlJJkkKj94lxZbgKfWN5ZHgEAooD8tlQ7m4Jx?=
 =?us-ascii?Q?uC/auhMuDHvRNaxyDQMjbAhT4Jm1fPT9m3z1UEIX1i3M73HbjVbMYkfVKYk0?=
 =?us-ascii?Q?rkmKsqTZmPbe/V+rgbOR0Fw/XX2R5XD7RizOvM55YvbVBBcwrdboCMsqOSy3?=
 =?us-ascii?Q?BgXUb1M3zJz+GofyZ1Ni4s7W7EnMj92LHZlRZ2+opkH1y5OrF4jizaGtr3pn?=
 =?us-ascii?Q?41kXj5M2iCQkA8dwk+Kjc9kT9KeRxgbT+yvpFpeJSlyeFDCJbWCXleneKHDI?=
 =?us-ascii?Q?bmic3G11nRrCf3g7sG0xYF7Sb0MhCK3LAHWz6KvH9EYEJA3nIlY+a7ub/r6w?=
 =?us-ascii?Q?6iKvGPFRcJdLdFHphwNzE5qu/Vr69ehx6caJETHIUHB8f7PfokWVtkwziY8f?=
 =?us-ascii?Q?h8bvdFo1PLRclW9+aBiFmJ64F4CjgiZjpANLv2o5AT9+kywoApFf84IjkY+r?=
 =?us-ascii?Q?dUl5GknqeWjIWaXVX0L5zHMxmJCX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AfUeRmidxBsC1HYWx/JKh1EF5Y2IygF1uHIar6HXsex4dyiNpIdiJljedJCO?=
 =?us-ascii?Q?Y0mp89NXv+kLbw4NtrBqzPLybFNTHAkHWJQP5BYviGu3GcoWdt7lpR4FvHaX?=
 =?us-ascii?Q?8xvT8Bb22lWzpNHmUlbkehEnFXO8/RyHvh16xdc1KHwFipyjAIuhvJDrKWpF?=
 =?us-ascii?Q?KR1NGK6NAbyfYkzglmzI6DLq4jJGf6fRt7+5OFdC2N6DhqZORfN7BR6g5q+U?=
 =?us-ascii?Q?6pd55M0cIXNfpJ7+S68sAS+hoOLk1zOzBVs8yjxi4EDXOAxzzyGjVrSRh7ne?=
 =?us-ascii?Q?AZ3SVHCXehGBwiASf7a1OufGK56mJV7dbTpcb4KaTzjKvRZgzeeQ7nA/+I1Y?=
 =?us-ascii?Q?0wtnbz7I7A72uxfu+fn8xXdiD7/k7BIabFoOfUI7Z2SArmohj+ycBm/DwmD8?=
 =?us-ascii?Q?y4I+YE8qde755uPq27lQsIE3UxVwL2zdHY3NV8NBum8E3yald0iwvzKMlGCu?=
 =?us-ascii?Q?VrY7lZYm+VLVlqCEK1oD4kNIVHT2ewx2aNWyLWMWfFbhO1dSFLlIauFC9wz+?=
 =?us-ascii?Q?KjBAfNzhVSGatvwlj2vFRjLI50k4BNLkhmDychKesotWyS48BEQkYcg/Funq?=
 =?us-ascii?Q?fakwTXB4sbprQMyI8lLf7se4fC5+2ZlSj7muCyO8vCKplTqHnYboRYGWHpH3?=
 =?us-ascii?Q?ZpqO2FYvOO7uFHJDV+H4VT7ocKXoVz+lcw6gihOP9ixybTr5fs+NNT84Z1eb?=
 =?us-ascii?Q?6rJ8aahrHliIE6cKk1o12W4ZVhN4fjEkEp+OtvS5I068oHzZFYeZqDVdrNxt?=
 =?us-ascii?Q?5UwapDtv4dLMkETJ5t121rPJLQ5FfFnjXI2jtYoxtLcrhecKKuC/BN3mFP7S?=
 =?us-ascii?Q?urBaiLlPf7JJpLql7E7nJz/VR9LsFk5vqE4JvuRDbE7SKi8Pofj6EjU1pGd3?=
 =?us-ascii?Q?WOXxK+vo30cv4G9VDZWIz0izl/K56ogBkUKRrTph0PHCJUSveP6RzNbLpKo6?=
 =?us-ascii?Q?3jTLVOYmmjtMFb2hzpg39hqLyIi8NN7Tl3yp0mDvdHbDPrppt4XBTtJ3VoqG?=
 =?us-ascii?Q?R1vvYCJ+oP9u24RgEiYfo1uhrqghV89/fgTRznyUPsMtxbQ5FXbejN2DddP/?=
 =?us-ascii?Q?P4Cjgo/b4yYglNhuyX/43DecoiQ3xpuhESD3L3Fm9eTmD73E3aAeX9ladef+?=
 =?us-ascii?Q?ePuYQd3n+5VeEyGaK/nh69t5pJm6ya+jZyrbCH4kgFrVZBY//DA72yZ/dv0p?=
 =?us-ascii?Q?2aHMjqDzUsq1uf4BzbqmZDez/efvOkb4I+Q7OVjZsh/doeEQtUQavuwbzm+7?=
 =?us-ascii?Q?x9mWQAr5eFZTq3U/z792/FvGTbP0EehRxlP17iLtgSHsZA/Jw+scvIXsAUJc?=
 =?us-ascii?Q?Dmyzlr0zo/trCPpug8rkDPPry3DN5bf/2A34yiHFaOtYsrJhHd4GUSbqgdI0?=
 =?us-ascii?Q?dCZwoUlncBoW1pO9v4nxTkU7RzwxVWtGgbJiDP/me1/+B2wbyeR0+xwVm8fk?=
 =?us-ascii?Q?B34KGB9dX2/i5f+UgjQ9K7jehx460vID51OnZlwV9wDjeRdrplp0gIbNqkky?=
 =?us-ascii?Q?elvGSddVF4nycW5svphcmCt7zecfeNm4M2z3UsgwM8+/MXSL83JIDuZI9dcB?=
 =?us-ascii?Q?ob/s+C8VUd7wi4YgRmyU4LwHkSld+XvSPsw+bBuL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d79e37d-3606-4ae6-b830-08dd52859ea9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 14:40:00.4619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dST6HHA8sE7WxTdMi/7J90fPp/ej6tNtO5HwRHpwUOkkGCkK+75ZxwUHKxcKBKq1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5864

On Wed, Feb 19, 2025 at 05:31:42PM -0800, Nicolin Chen wrote:
> Now that iommufd does not rely on dma-iommu.c for any purpose. We can
> combine the dma-iommu.c iova_cookie and the iommufd_hwpt under the same
> union. This union is effectively 'owner data' and can be used by the
> entity that allocated the domain. Note that legacy vfio type1 flows
> continue to use dma-iommu.c for sw_msi and still need iova_cookie.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  include/linux/iommu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index e93d2e918599..99dd72998cb7 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -216,7 +216,6 @@ struct iommu_domain {
>  	const struct iommu_ops *owner; /* Whose domain_alloc we came from */
>  	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
>  	struct iommu_domain_geometry geometry;
> -	struct iommu_dma_cookie *iova_cookie;
>  	int (*iopf_handler)(struct iopf_group *group);
>  
>  #if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
> @@ -225,6 +224,7 @@ struct iommu_domain {
>  #endif
>  
>  	union { /* Pointer usable by owner of the domain */
> +		struct iommu_dma_cookie *iova_cookie; /* dma-iommu */
>  		struct iommufd_hw_pagetable *iommufd_hwpt; /* iommufd */
>  	};

Ugh, there is a problem here:

void iommu_domain_free(struct iommu_domain *domain)
{
	if (domain->type == IOMMU_DOMAIN_SVA)
		mmdrop(domain->mm);
	iommu_put_dma_cookie(domain);

It calls into dma-iommu for all domain types 

And if !CONFIG_IRQ_MSI_IOMMU then this isn't possible to protect it
against iommufd owning the cookie union:

#if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
	if (domain->sw_msi != iommu_dma_sw_msi)
		return;
#endif

I came up with the below, but I will drop this patch for now you can
repost it as a cleanup series..

Jason

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 3b58244e6344a5..31d53552dc4790 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -418,6 +418,7 @@ int iommu_get_dma_cookie(struct iommu_domain *domain)
  * number of PAGE_SIZE mappings necessary to cover every MSI doorbell address
  * used by the devices attached to @domain.
  */
+#if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
 int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
 {
 	struct iommu_dma_cookie *cookie;
@@ -439,6 +440,13 @@ int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
 }
 EXPORT_SYMBOL(iommu_get_msi_cookie);
 
+void iommu_put_msi_cookie(struct iommu_domain *domain)
+{
+	iommu_put_dma_cookie(domain);
+}
+EXPORT_SYMBOL_GPL(iommu_put_msi_cookie);
+#endif
+
 /**
  * iommu_put_dma_cookie - Release a domain's DMA mapping resources
  * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie() or
@@ -449,8 +457,10 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iommu_dma_msi_page *msi, *tmp;
 
+#if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
 	if (domain->sw_msi != iommu_dma_sw_msi)
 		return;
+#endif
 
 	if (!cookie)
 		return;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 022bf96a18c5e4..f07544b290e5b1 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -456,6 +456,12 @@ static int iommu_init_device(struct device *dev, const struct iommu_ops *ops)
 	return ret;
 }
 
+static void iommu_default_domain_free(struct iommu_domain *domain)
+{
+	iommu_put_dma_cookie(domain);
+	iommu_domain_free(domain);
+}
+
 static void iommu_deinit_device(struct device *dev)
 {
 	struct iommu_group *group = dev->iommu_group;
@@ -494,7 +500,7 @@ static void iommu_deinit_device(struct device *dev)
 	 */
 	if (list_empty(&group->devices)) {
 		if (group->default_domain) {
-			iommu_domain_free(group->default_domain);
+			iommu_default_domain_free(group->default_domain);
 			group->default_domain = NULL;
 		}
 		if (group->blocking_domain) {
@@ -2023,7 +2029,6 @@ void iommu_domain_free(struct iommu_domain *domain)
 {
 	if (domain->type == IOMMU_DOMAIN_SVA)
 		mmdrop(domain->mm);
-	iommu_put_dma_cookie(domain);
 	if (domain->ops->free)
 		domain->ops->free(domain);
 }
@@ -3000,7 +3005,7 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 
 out_free_old:
 	if (old_dom)
-		iommu_domain_free(old_dom);
+		iommu_default_domain_free(old_dom);
 	return ret;
 
 err_restore_domain:
@@ -3009,7 +3014,7 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 			group, old_dom, IOMMU_SET_DOMAIN_MUST_SUCCEED);
 err_restore_def_domain:
 	if (old_dom) {
-		iommu_domain_free(dom);
+		iommu_default_domain_free(dom);
 		group->default_domain = old_dom;
 	}
 	return ret;
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 50ebc9593c9d70..b5bb946c9c1b19 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -2271,6 +2271,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 			if (!iommu_attach_group(d->domain,
 						group->iommu_group)) {
 				list_add(&group->next, &d->group_list);
+				iommu_put_msi_cookie(domain->domain);
 				iommu_domain_free(domain->domain);
 				kfree(domain);
 				goto done;
@@ -2316,6 +2317,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 out_detach:
 	iommu_detach_group(domain->domain, group->iommu_group);
 out_domain:
+	iommu_put_msi_cookie(domain->domain);
 	iommu_domain_free(domain->domain);
 	vfio_iommu_iova_free(&iova_copy);
 	vfio_iommu_resv_free(&group_resv_regions);
@@ -2496,6 +2498,7 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
 					vfio_iommu_unmap_unpin_reaccount(iommu);
 				}
 			}
+			iommu_put_msi_cookie(domain->domain);
 			iommu_domain_free(domain->domain);
 			list_del(&domain->next);
 			kfree(domain);
@@ -2567,6 +2570,7 @@ static void vfio_release_domain(struct vfio_domain *domain)
 		kfree(group);
 	}
 
+	iommu_put_msi_cookie(domain->domain);
 	iommu_domain_free(domain->domain);
 }
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 99dd72998cb7f7..082274e8ba6a3d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1534,12 +1534,16 @@ void iommu_debugfs_setup(void);
 static inline void iommu_debugfs_setup(void) {}
 #endif
 
-#ifdef CONFIG_IOMMU_DMA
+#if defined(CONFIG_IOMMU_DMA) && IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
 int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base);
+void iommu_put_msi_cookie(struct iommu_domain *domain);
 #else /* CONFIG_IOMMU_DMA */
 static inline int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
 {
-	return -ENODEV;
+	return 0;
+}
+static inline void iommu_put_msi_cookie(struct iommu_domain *domain)
+{
 }
 #endif	/* CONFIG_IOMMU_DMA */
 
