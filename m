Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010032.outbound.protection.outlook.com [40.93.198.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5B919B3CB
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 00:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792024457; cv=fail; b=O1JLxkdKGh+taufNQO810cRIf8PnPSy+vpt+appoho5uL+j9f01LzikWfepf0l1FwnVu9EwwZyHhC0W4hooeuDoZwRgeRRsFrl/nTapHyUI35ipzS0P1SPPdT9aHgH3xlH6rIOi2hDME7bjDO74RgAxqD8LgPrhYrZkyNwD+CAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792024457; c=relaxed/simple;
	bh=gdpHs1lXTR9PRnygz3bP5jgBEnySp1RwGn0rf+TyYak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZW1aGhB+Waeg7XdGauCZdVcWySoxpHS9Af6K9zYxvHJIGpPNj6A99QaW4xGCitnVSbmN4Xm72jjSlPrh/CTq5+57Zbjauma6sEApf+QLU3fKjaZloianvyYvQwPZAaIhcE5VkaGSixLU33g+RliW/aSmCd2evrRtFzLVSKjkexU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YOLQvWGV; arc=fail smtp.client-ip=40.93.198.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YOLQvWGV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ozoa0rAXlHQSIoCYDQAAUyOYBlKNJQ38XnscXYERHHDPES/OSJDADvvCqw05S/4h0AMrje2Hj+S8Pf5LEJUMj3HbO/BCbkb4oqrAPx905SkERxy7mQvcRso+xOsTrN7GlJlX1ZKA+i1AqoBfFbk/gZMcnODiIUJkq4w8qLsDF9Y0PpuL0VYfR60DxbTRADZI3BtzJkqYmXjbec1sp8/IW7TA5ysoDizQPBvnClBZnGoc0DELzT0FHr0OIOYXjG9P7oXBijENVPXHbGh9H9K+J+stvtBYlsYhn5BLxykoISuKzYvtJDEnjNvBX9ALqiH/35MpxEUn3qBEF0RMXNmH9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1S+qnc8xvU3ZpZu0C/FtcJ+SRjmG+xqFyM+KcfeAplM=;
 b=OO0zY1czjbYlv6zgEuo83/CyuK8/WPACtloWkytewn7bfDgGmvEq1iyJkQPb/u74YGELPDEPMJa53xOn7+QjWJUS0K3c/W27lcf59yHLjWvn37a12A5ITegQsYAK3x5SirQWQKGuyJ9cgtNvgpdlulVEr3x/TL6TUO7bMUqKcgYUDPZbtjgoE/s8+kXkI43UPqkMq1YiPkIFwsm2otJ9q8HhcaOxbN7K+RpqiUXz7mgH1mYjIVqpMdwMNZ/vwtrn1QO9c6azl2Swp+K6qIznG91Ny8hPH3t6DPgEiqqnC4yYRLwpzgdiBhXUg9sr9M0GAUCoDnk4PwaIIK43J/ro5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1S+qnc8xvU3ZpZu0C/FtcJ+SRjmG+xqFyM+KcfeAplM=;
 b=YOLQvWGVaeGBqBLTuDaDzCPaeJvPcCcYUvISezCnKox6U95cI2CveAyhrEcy6Bwo/LdbPAT+F04mcRbk5eOQlIEsqNLG4eDIj5Y0L3MzdJ5oyYI4toAcK7WPQqsIJAP9zut6JkpFBPeEVcok/7J+FjNyrdmWk55NUiOXO6HntSWy0jwvJwWTsnAu5ZTP1teU1LbqdL7gOtXFfQX2378xbuEGNYKKoAtrooU/zA2zfhvgxi/Wv/5RDvcAw8NrihVd+XzmfE8BAD0vTz5j2LXfHQHfLmfmG6zy8ZZBd1l3MamZsbYVyGF8/HYqUmIa9InsMo6lxQHeg0oIhEvL+cTvVA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by MN7PR12MB219968.namprd12.prod.outlook.com
 (2603:10b6:208:632::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Thu, 15 Oct
 2026 00:34:13 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 00:34:12 +0000
Date: Wed, 14 Oct 2026 21:34:12 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: samarth.colleges@gmail.com
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommupt: report the whole contiguous group in
 read_and_clear_dirty
Message-ID: <20261015003412.GA13920@nvidia.com>
References: <20261013165814.3092559-1-samarth.colleges@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013165814.3092559-1-samarth.colleges@gmail.com>
X-ClientProxiedBy: YT4PR01CA0359.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::23) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|MN7PR12MB219968:EE_
X-MS-Office365-Filtering-Correlation-Id: 710a2084-8c38-4818-0d9a-08df2a540912
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|6133799003|22082099003|18002099003|10067099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	l46xG7lJtj00Juw9w9Ltqe4WONEnsjI1Td/luKCDW+EKac1wllz7SdwDa8HpA5lt0HYzfyVg1edAB8IhjQOcxDhPrx4csCoLFhrorTXu0bHww1yate0L+RRYIhCfH+52b6XPFMnFX/8dr/WNh5Sh9DbLrWs8W4O4AEArUdVLidZsIOPgirYnKMYJXYDa09Y8mxOdjg7J2y5Fdhm0uyC4reLOupmz50/LWdMxXLeFzQfo5nFiPwycYRpeAwQUAb3AV5BotSsE8yoqV9N9MS/mK6tpcgFxstEscQBsxrfEHYDylVmylF8a2TEEKCo7ArufnRsIvr0FVYlOdT3zWI5LdVtil/IdhPb/J8WWrn/UPTsxIl3P5bA4gIwf0MrsD+ht6iTDvdtnOMaGjU5haAT8X50I0rMhnZ7Y2QyNSajoE/1jrxD7slPh/gQv5p467BjTjZCWUDBK4Eogd9PhP1phdwjCopHzZBwLq63w0b0rNaNMlWAQG3ISRWEN9qhMUyYMfPyoAez03Eujc8MzoInhDyuC+AHdhkZt65O945bFqCHJCr/byIhJYtAYQl0W65llLEIqUFt48HYGyVF1n1B7Lu0am5zTcMja3OmqlWHLYYJTR3QeZJnKsm8dITWj7/utZdoEHvYUxFRnIHslq2JCQw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KoInXrCHIwmXWiGoRVz+pw/EW4sF3wT3ZTn6ADOMoKxod1iInMuBzSasJdnD?=
 =?us-ascii?Q?VWgU88ue6qyjo2VsU2QVw9iS0IgBdDqt+lutfBpw/0iBrNynj8F5rSfVG0Hx?=
 =?us-ascii?Q?zdvNWXjHE6fsUzjIIm2A0QhZKrFwhVLF2dq8NiG7zSjQwPuVQ1THuuSGpBsW?=
 =?us-ascii?Q?Hk0Ur0e2e8mkg19ib56amCnW1NBVQX1Acwl6V0aL5zvJpvZG6fBDAcYLfKF6?=
 =?us-ascii?Q?hLIJFiEJaS9QVwu/3Pq5zFphJmSjdsiEsp7QyUEX9QeSiz6y7XVo8jSZgKRz?=
 =?us-ascii?Q?V3+E3uI9TDKmnX5kV5h7azwppCydjlTXrWrjuVnFoCatmMlFgOhPCRkxjIMy?=
 =?us-ascii?Q?TQ0TMiiODwhJ8NTWPvg6rCQMhkbA2Uxa4tU/IzBxyo/diAGm6nhfVWfNTSbx?=
 =?us-ascii?Q?vSb//JiVEgDqTh2w6hwuujsEYjnX3rjl1XCM47tkDrpPdgrtlQQHE42LtIOb?=
 =?us-ascii?Q?EBOZwYpeXGLEX2j3u+Ws6Ygpm1pFqV+0Mnrs7QBpwHPpFQbLZZ64ZeZMhbmV?=
 =?us-ascii?Q?q3NQFv1iT7UuUjtMxPlKZ/n1Lc65O6ZB7i0UIo93laaRYE491/DlnxwsiCK1?=
 =?us-ascii?Q?R+DPtkoMyYgdcKgJYybySsD7/MNK4H4wxxI3LABTNmoMOS0qqPTfT1hQc5ss?=
 =?us-ascii?Q?5FESFwcYNJwkh67j4+fTIH/aJLopRJsbCWwb/UJROSURAJkpYbeeUhyVJ6Gi?=
 =?us-ascii?Q?CHS5yUxx5uck8b1wxR40NnOULNIAVLC8Jr8j5aJxPtyAioDSrCKXb5vEX3eX?=
 =?us-ascii?Q?KkrqJ5thKovV1jbbCF4xDHAgd/B0fIiN4s1beZhHTKL0RfwoGgZVXikUl2G+?=
 =?us-ascii?Q?uxpTPWTRty1es+y0262bs5pnSUHbQKrrYJrWzRGyjH3Nfk9+mKFcS1G82mgR?=
 =?us-ascii?Q?rzHY7sjht9PX+2rsPO0CN54ol8EEkpUykTdhfJC56wZc70YMUqB1ZWeZpaJl?=
 =?us-ascii?Q?NgZKvrCMxYc9i5zqsWcrqRi7/Rrtww/RCxT+tcRdopt9Pp+Tqeddifqmw3+9?=
 =?us-ascii?Q?SvP7ofFe1LdyIR1vXcxc/qT0k4jPickM+ic6eZ0dTZzRBDTQh98ZHsq4zFyC?=
 =?us-ascii?Q?Syc5y2NT1BitR1pgZ6iMpZRzY1NgaQZ0yw3uD7guwcOOCD96rxsH7c5zbHXi?=
 =?us-ascii?Q?reiMXj1uZS1knTlCgkPU5ccOvvmbjHaKrLiO2vR1XZRCKL9ADgqq7iNjmSxt?=
 =?us-ascii?Q?pTazIBz4c3TxpSCg7FMFF3PIfxl7FZdVtnDfPKFQyx24GAM/2iT16LG7XQHn?=
 =?us-ascii?Q?wCElLLsKayrTUFhhj4y45IMCEtooisvD7mDgbb0aLyt5TC8zbJDC85pWNge/?=
 =?us-ascii?Q?mTuYtRt/gZuoRh9SAM2Gknar24jL2B7uiIRoSR4S00eEdn2OomxtSMlwUJVn?=
 =?us-ascii?Q?GjwE34Mdvy13142+/+HXOfNH1U6O7LGmHWGmBp/o9kYPuMG6+sB/dHKqhmL2?=
 =?us-ascii?Q?9QZnbeo38+nPs+zON2zVpUFmqR/6fFa1INp/iIVGYe8Iup6rQ9gd8+Imx1v7?=
 =?us-ascii?Q?SJ/EgTXF9kbnck4VeYnmB4LCzKvM95FIF72o59udwgmOf03GT7yQV3blpfNS?=
 =?us-ascii?Q?iI+nwuCf5mlOLKoQc7mtTUGUO04RdpEVYxbVvPXLc6+LFX+esOSEh/jW0AIz?=
 =?us-ascii?Q?pj9sqw/7dRBVl/BvOapYc95tWWfikdzBV1FqUp7E3BxX8dbCQ7PWUrvD0CY8?=
 =?us-ascii?Q?vwcM5YLhkND0j5aIgL2rklKBAxcT9lZGDtFLyASwvpc94FAb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 710a2084-8c38-4818-0d9a-08df2a540912
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 00:34:12.8466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pgk5pSYF0C2wOC8kQ/6XtYTExtO56HWUfa7m6nt96C8fUJkIj3yPvgrEeIdbSy5S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN7PR12MB219968

On Tue, Oct 13, 2026 at 09:58:14AM -0700, samarth.colleges@gmail.com wrote:
> From: Samarth Narang <samarth.colleges@gmail.com>
> 
> The record_dirty() function computes the reported dirty length of a contiguous
> (multi-item) leaf group as:
> 
> 	end_index = log2_set_mod_max_t(unsigned int, pts->index, num_contig_lg2);
> 	end_index = min(end_index, pts->end_index);
> 	dirty_len = (end_index - index) * log2_to_int(pt_table_item_lg2sz(pts));
> 
> Here, log2_set_mod_max_t() sets the low num_contig_lg2 bits of the index to all
> ones, i.e. it returns the *inclusive* last index of the contiguous group.
> However, pts->end_index is an *exclusive* bound, this can be seen from the
> definition of pt_range_to_end_index() which returns of the form "index + 1".
> Also, the iterator stops on index >= end_index. Therefore, subtracting an
> inclusive end from an exclusive bound will yield one less item than the actual
> length of the contiguous group.
> 
> For IOMMU dirty tracking used by VFIO/iommufd live migration this silently
> drops the last page of a contiguous dirty mapping from the migration
> bitmap.
> 
> This patch makes end_index exclusive to match pts->end_index and the span cleared by
> pt_entry_make_write_clean(). Also, the same length is passed to
> iommu_iotlb_gather_add_range() so this fix would correct that as well.
> 
> Fixes: 4a00f9434891 ("iommupt: Add read_and_clear_dirty op")
> Signed-off-by: Samarth Narang <samarth.colleges@gmail.com>
> ---
>  drivers/iommu/generic_pt/iommu_pt.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
> --- a/drivers/iommu/generic_pt/iommu_pt.h
> +++ b/drivers/iommu/generic_pt/iommu_pt.h
> @@ -248,7 +248,7 @@ static void record_dirty(struct pt_state *pts,
>  	if (num_contig_lg2 != ilog2(1)) {
>  		unsigned int index = pts->index;
>  		unsigned int end_index = log2_set_mod_max_t(
> -			unsigned int, pts->index, num_contig_lg2);
> +			unsigned int, pts->index, num_contig_lg2) + 1;

This is a bug, but there is a bigger bug here.. The function is
supposed to record the entire entry that is marked as dirty because it
can only clean the entire entry.

Taken with the patch I just commented on this means the system call
should be failing if the entry does not fit within the bitmap.

So this function should look like this:

static void record_dirty(struct pt_state *pts,
			 struct pt_iommu_dirty_args *dirty)
{
	unsigned int lg2sz = pt_entry_oa_lg2sz(pts);
	pt_vaddr_t start_va = log2_set_mod(pts->range->va, 0, lg2sz);
	pt_vaddr_t dirty_len = log2_to_int(lg2sz);

	if (dirty->dirty->bitmap)
		iova_bitmap_set(dirty->dirty->bitmap, start_va, dirty_len);

	if (!(dirty->flags & IOMMU_DIRTY_NO_CLEAR)) {
		/*
		 * No write log required because DMA incoherence and atomic
		 * dirty tracking bits can't work together
		 */
		pt_entry_make_write_clean(pts);
		iommu_iotlb_gather_add_range(dirty->dirty->gather, start_va,
					     dirty_len);
	}
}

Along with the patch I just commented on to make iova_bitmap_set
generate a failure if the iova range is not recordable.

I will update this patch in this way

Jason
