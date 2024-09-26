Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE7015AD96
	for <iommu@lists.linux.dev>; Thu, 26 Sep 2024 19:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727379978; cv=fail; b=uWKxY9492X6Uj8AEOzAz1+atv/OhSfEAOmtAe+zI5uSgDgK2qYaBCeQSlCIJjpcB6seIJa6mDI6MEcfXSzMS6Vv9+E8u/MzHfLE9aaDLKb9ZLSLv355NInYMtnfW3082/DNlUVmhWPwKYn0/l/IszqK25p4ZCUKeVUMqjjYWjKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727379978; c=relaxed/simple;
	bh=x+Vmuik+Frm4R1GytPG8b6jS/EslA9vdix1p8xEuing=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s7FkZJVnfxpOMpKxKIOrXP3vY9oxUpXZsTq9sc4a+ahWeYrJIz7LE8rEMTIi/F0ZVVYjXq3J8Fw+LqXgwoqT/c8sSq4RbhZF4EVpkbg1MqfTbuPzbgBqpbxD0SB8VlvQDNfGLvYyyLXXuQ/PBwqy5VT/hEj1kjRftJGWI2IaXF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R/L6zCDO; arc=fail smtp.client-ip=40.107.93.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R/L6zCDO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uS/UKWfUfbHMKlUdt3smvBCdz545n/qjCpC13Xwog6QAA4Zjrsmfqi4+MRR+prIoml1dOf08K+Ppcs1LAXbzhJ6K4I4WwMmKjuiI9mzgAWgO13cfn8wlqTvozDzBNWGhyN5qqKtACF+CbdZs+aPaoeQMMjmYu4Zv9rLh1nDgrP04k1JXlRxFOFoALng8bxKOfqNMIf5yBu43Zmlzpy6tg2Cu2zHyTRzvjPmJKBUTLOz2GwET1XnZzMFsXFh4w/NYmy79swQL4/Pa0K3WtFYvqBdMouxNREVSvKMTJuxRUfDISn3F6s3wWWd7E6Nvtwa4CtW6TmzOIQSBDD8EQQ1rhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y59ZOPHmtE1J17WL5g7WCnG5fWAr0/ZYdrteXSoT51A=;
 b=QCkdQP0pBtpiadv2Wov7WX+7zZz7ayOyHFpZjUu7ydHDgIYMwTHh+HClqODjyYtFzr4DrfVVE0x0D1+o5oFIIpRxmmb1T9W56oonn2lan06lftBZjjuOcYlPKl7CeOFnR1pg0h+WPKU9NewfD7uDFsdc0EuzCUekjl3bwIccMcM9VrJ3RdhKl91sAl+wZYwzdNfTu4JnTaunaeMAfgCtV/e+T8Vg/f9qgqYeFYARju4jU2qUymkRHDUqDKjNx4jEsD8hkspBIcYiZfSHGq/A1nzAwX8fRHWFx4IgAFYU7gP4ngQRHAdevVIVDKqt5X4L1+usbMgj9JZqTRPDd4u88A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y59ZOPHmtE1J17WL5g7WCnG5fWAr0/ZYdrteXSoT51A=;
 b=R/L6zCDOXj+WGZ3EmMOutNjguXeamKxrQ9SpyLVWAeFN7Y16NU1l9iDx/+yLd1alOBhHiPDNBm+73D/hiJo9nYWUA1hvA2ovcyt2PxBUvwgCx/tnctxCunYF7Td0tSIeWEj63IUQXV2ew2g2z6GlejAl0dtmMDwgbkY+ltQif3MM9UpqJ8k0FI6PbF3o78nedqx49IgwtUDbTOI/y1k3R4ii6lqjEqJs5nGxfoG7HYjd4YIixF1MHyvIKN4EzU9Z6x7D61xk/0c7/KB6F6RuupDz0OZhszmxABK1vtPfXvArQzO6lGJeGYc6Jr+ETC2IAg/LE51Ey5ddWA9TDXmjUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB6208.namprd12.prod.outlook.com (2603:10b6:8:a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Thu, 26 Sep
 2024 19:46:13 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 19:46:12 +0000
Date: Thu, 26 Sep 2024 16:46:07 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	robin.murphy@arm.com, vasant.hegde@amd.com, kevin.tian@intel.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
	kumaranand@google.com
Subject: Re: [PATCH v4 2/6] iommu/amd: Introduce helper function to update
 256-bit DTE
Message-ID: <20240926194607.GP9417@nvidia.com>
References: <20240916171805.324292-1-suravee.suthikulpanit@amd.com>
 <20240916171805.324292-3-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916171805.324292-3-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: LO4P265CA0051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::13) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB6208:EE_
X-MS-Office365-Filtering-Correlation-Id: efc94276-f8c0-4a21-39ff-08dcde63e067
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mJ6SbhmW6XDe00wSi066ae5Nlk9O5o5C6QkieW+I3RyfaF++Y36NwOq9axs7?=
 =?us-ascii?Q?E8v75XUtcXdc/xnz2+68A25QaR/RbWEkfFjOrqgYecAizJGZTMaqAaNfREhQ?=
 =?us-ascii?Q?2NNFXiGd4z2Vp2FMnXYynuDUJ7UwLK0L2Fd/V06h3tNS/6ZWMl0h+QUq5SAr?=
 =?us-ascii?Q?dJSSL1W4mfNDCkDDb/Ld1sFqJ9Qh78TzmALhqiMErDj6as+b/BmZ0BM/cwG/?=
 =?us-ascii?Q?KJPF6BQ2yycoekyiG1ykWvjAScmXuXJOKV429ZlsGuMoEbGl8HYa08YnTPQs?=
 =?us-ascii?Q?x4K5sx0qsTKXS/eyGSxNY/hP9dujYsP9xGsDEqFMrqtT/Mx6gYQ/CQrzc8To?=
 =?us-ascii?Q?T+/UsYJwuMbSXas/8y878tyOhFW8sruWwhhbfGc2nsBiiKPhZnu4XPzY5Djb?=
 =?us-ascii?Q?crSZeA91PNrGVHzjHqhrtTU1W+j0XVzTwpUC96jPmJvnW20Cp1Cy9nOU91Op?=
 =?us-ascii?Q?khiddX0gor33ghNRTG85pjK+UQxeNrI/3k3YOS1AFvM7oUyElakXyctdzjIl?=
 =?us-ascii?Q?tC0u7Kb+/MTV+s38k5N4iEqVmQizRmo+Fs3dlqDAK/QTOczxexfpqzNowFzC?=
 =?us-ascii?Q?dDXHj0T3rvOlPPcqkqff7kK3bLAjmZD7zHC+R61poWzbKk5q/d13QHymZiIz?=
 =?us-ascii?Q?ZTF5V8QzrC8Or6FWtAOwsZPtEMaoYhGcAJ/3VVrSkDm4kFgMWrlfZxLp9lFy?=
 =?us-ascii?Q?X18qgQ/osBSoCZrYqmCLLlQWyJkW/hOWvDkAJBUzt++HW3l0DHCnVi4f/8wR?=
 =?us-ascii?Q?s42bBWBiEV8YVJ5eT2cIYKW7nLKZTM4LAKQ3pwC510AfxwyhwzYzd7J4l3BM?=
 =?us-ascii?Q?0Jdxanik5t/8+0Ru2QQbv2Gq2S91tAHfahhHmxtojn11glcioG6RkjImWQth?=
 =?us-ascii?Q?6dUv3BZCAL1W/7WF7fUAg3OPJOtorjggA4vMPDw/DXHoW34dH80hI0163wuI?=
 =?us-ascii?Q?Hqixp0bp9m9BWjsFtaEJlrbeouPGcO+dS0xJFmQcEpGfeZ6rygB54bgAZ9/P?=
 =?us-ascii?Q?UzmH6FRy+9H9OqsNJUxKTBA2PZDFWlC8k+AV67WGDlA8qSccD9oxajONvMla?=
 =?us-ascii?Q?bXtnRL96YLDxaausasi/xbqCUKIXlVf5d9/i0W3iflmbyx3Q8Fweyh8AgIjz?=
 =?us-ascii?Q?4PrrfiXknOwdPihXP+k1vt69dBvxY1kHcXc7vWyz3OmLwVc5OuLtJ8tcsNHw?=
 =?us-ascii?Q?yLNTRYuvGyedDzcJk4huMttvEuubC2YE29KByIdkQM60OD5rr0trpF6W/lrS?=
 =?us-ascii?Q?2Kcxg4x0zTN4VosvLCCFGpSAreLjXTkhHOEOx84f+g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DpQcJLuuFQIDkj6HFXlLrRni14Y/e3Vrullsc51g+4k4JE+1xYRoEPQqIieH?=
 =?us-ascii?Q?M5rTKHFc86+/qLTPC9iOYrVVfpEqv7ukKk8MFl8DTVYPL/I63Khu6inYLRU8?=
 =?us-ascii?Q?GMNz0ZsqTHDrN2bxPiZeVMGOXSD6NqdpnGAH+3ml2WO7aP2trvb7UXGJ24hV?=
 =?us-ascii?Q?EaFxIBjugsNjYMMODPD12yOigvX+mZsioe1WI24o9ZaGehGIOx41IsVcWAPa?=
 =?us-ascii?Q?wf3oxi7oZCA3fcdr054ARCaKdOiHbXY5neOj8cMFyfl4qM9KGt8Ng1MXeTVB?=
 =?us-ascii?Q?x3VL+61pyYtRBGUOskHp+j4gtADBteDfy9XhSSrsV/cFuwlvt4O/gFQ1JQtR?=
 =?us-ascii?Q?dld1V5g68t92N7ce0LZGfRQCaYbIaHpb10ZQIL3FDXnqy7ykRvoBZgZSy02b?=
 =?us-ascii?Q?n7jlOFB00zdJS3lQQlyM0qOYqbDGZlvpE999TgHVfgj/aykLT9OeRCnlAFmO?=
 =?us-ascii?Q?pwQQmKEz53U3nU60rPHnLSkbUvtk8TgZU0aiSj32caA+upDSGBs17qnzC/td?=
 =?us-ascii?Q?mZ2wIbDHCLxGynL95eD8bw9Ceizv3yfuROLU+cuJWRwox24zZ1b8n5wDyvPI?=
 =?us-ascii?Q?0H/diaCUAKXTxWuKKC35/FBLpOjHGgJAmgvLnmnaM6HsW4JX+ONBitsM+wNr?=
 =?us-ascii?Q?mK51jwh/R9ZSVksvXoaG1Em7f6IVElQr2wpg3RNCGJUAqZ8Vc6QoglXeujXl?=
 =?us-ascii?Q?eFJTyqMa9fJy8zN6gvJCPYnD28CXXEo0skGCytdeJDPh/NRZSOPVUWaC4oIL?=
 =?us-ascii?Q?xYpZ/O0oVoIFqTbtpaFpeeXvdzmIvvh7Q4vMatM01xWQNmMe6BkmxlW14sde?=
 =?us-ascii?Q?IQvgFYvRUOLnWPz26qTUHHx2Xx2KBho61w/x08nEyiyktovhFuNglorkNJ1V?=
 =?us-ascii?Q?DUD54+me+K5GFo8UnwZ7GbqWjgtu4190MElz0Ke3rVVBJKMUNM3YSXBA8OEO?=
 =?us-ascii?Q?NDyRBdJ14OYIpP1UBeesF/+qkcbgZG1gm9KmoiLvLX62UT4mBs36Al7qCbOt?=
 =?us-ascii?Q?xfPArlcEDBZtkTcSGDn0XlQK18cKkLzkRbFk2VKFQcBs/9oOe304Q/xFdu4u?=
 =?us-ascii?Q?VlGn8fBseaGwtKVo2gpT8athKQDEOUj8tCH6VO4fpurlYXSXm/+DBeI2HNXW?=
 =?us-ascii?Q?SejPojxtj83HMUlcGzfFOK99pMpqQpjDDElqinn7NWBi9FwkXqMqroLmyk+l?=
 =?us-ascii?Q?QfAEE/FUpiMSHLmdS9VVoVs9t4ZCSSjbKg5HJMtHQaKbSZcv7prF5SJ+Baez?=
 =?us-ascii?Q?r5iOgUvAunpoFFLV4UfSCMHNToh0pEKFvf+6TQXp8uTN5c7qoLSTdyxBBCxc?=
 =?us-ascii?Q?y0DIcA3JhqNA4CMdaEM2x/qpHuDMzTpAy0cCTMxHDsLGRsy2hFADk7Rj7yvm?=
 =?us-ascii?Q?DyAgMu6NeExkWC54rz8FF6LRcof/yjwUNSc3v48X520j08UgSUmTzrWzzl3t?=
 =?us-ascii?Q?ywO+QXmgx/N3Sg419Oe/+EyZwUCZ34PcGYsbc9hfhljO1aKvi3aObxGroEP3?=
 =?us-ascii?Q?8LKfZMjUz6KsMdtfuNl6AtHP6WJQWufSy8LrDRHFRBQeLiggBD61u0Zmr/HI?=
 =?us-ascii?Q?Nyk6VWbj3EtDPePLrzL2Fws+Qj1KEb38LzqkJHO8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efc94276-f8c0-4a21-39ff-08dcde63e067
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 19:46:12.9025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ich89lc/bESRRzi7jps0On/Yrp+WTn/thfpwmbl64MpElRDIF84VqQX/jJU3f+V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6208

On Mon, Sep 16, 2024 at 05:18:01PM +0000, Suravee Suthikulpanit wrote:

> +static void write_lower(struct dev_table_entry *ptr, struct dev_table_entry *new)
> +{
> +	struct dev_table_entry old = {};
> +
> +	do {
> +		old.data128[0] = ptr->data128[0];
> +	} while (!try_cmpxchg128(&ptr->data128[0], &old.data128[0], new->data128[0]));
> +}
> +
> +/*
> + * Note:
> + * IOMMU reads the entire Device Table entry in a single 256-bit transaction
> + * but the driver is programming DTE using 2 128-bit cmpxchg. So, the driver
> + * need to ensure the following:

I wonder if the intention here was to use a SSE operation to do the
256 bit store from the CPU side too? Just thinking aloud

> +	if (!(ptr->data[0] & DTE_FLAG_V)) {
> +		/* Existing DTE is not valid. */
> +		write_upper(ptr, new);
> +		write_lower(ptr, new);
> +		iommu_flush_sync_dte(iommu, dev_data->devid);
> +	} else if (!(new->data[0] & DTE_FLAG_V)) {
> +		/* Existing DTE is valid. New DTE is not valid.  */
> +		write_lower(ptr, new);
> +		write_upper(ptr, new);
> +		iommu_flush_sync_dte(iommu, dev_data->devid);
> +	} else {
> +		/* Existing & new DTEs are valid. */
> +		if (!FIELD_GET(DTE_FLAG_GV, ptr->data[0])) {
> +			/* Existing DTE has no guest page table. */
> +			write_upper(ptr, new);
> +			write_lower(ptr, new);
> +			iommu_flush_sync_dte(iommu, dev_data->devid);
> +		} else if (!FIELD_GET(DTE_FLAG_GV, new->data[0])) {
> +			/*
> +			 * Existing DTE has guest page table,
> +			 * new DTE has no guest page table,
> +			 */
> +			write_lower(ptr, new);
> +			write_upper(ptr, new);
> +			iommu_flush_sync_dte(iommu, dev_data->devid);
> +		} else {
> +			/*
> +			 * Existing DTE has guest page table,
> +			 * new DTE has guest page table.
> +			 */
> +			struct dev_table_entry clear = {};
> +
> +			/* First disable DTE */
> +			write_lower(ptr, &clear);
> +			iommu_flush_sync_dte(iommu, dev_data->devid);
> +
> +			/* Then update DTE */
> +			write_upper(ptr, new);
> +			write_lower(ptr, new);
> +			iommu_flush_sync_dte(iommu, dev_data->devid);
> +		}

There is one branch missing where GV is valid in both and the [1]
doesn't change. Ie atomic replace of a GCR3 table.

And maybe this will need more branches later for the viommu stuff?

But otherwise yes this captures what is needed just fine.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> @@ -1256,6 +1342,16 @@ static int iommu_flush_dte(struct amd_iommu *iommu, u16 devid)
> +int iommu_flush_sync_dte(struct amd_iommu *iommu, u16 devid)
> +{
> +	int ret;
> +
> +	ret = iommu_flush_dte(iommu, devid);
> +	if (!ret)
> +		iommu_completion_wait(iommu);
> +	return ret;
> +}

Maybe this doesn't need to return an error since we can't handle
failure to flush DTE tables..

Jason
