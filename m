Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011068.outbound.protection.outlook.com [40.93.194.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAFC37B028
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 13:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780318808; cv=fail; b=tkrJ0QWVpLrJgW275Fkp3MUQ69f+Mf85XoksSIudEapXp6k/8eyP2HCNIFdxbLqPoYLbQ5ynvVI/hTwZdJRJ3oUzghlXpmLBiDvqUXUYQH8Dg8y/H3dHoYDu9fnHoh3yiUxkbqzT2uzt9vyWLrfC4A824KBV4KkF3ECpzA+uIh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780318808; c=relaxed/simple;
	bh=9yqpVjZ5V7c7aBwn+U3P3sGmI0vv7+qRVVoo/7nlHOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I7xTxHtI/LibAgsLy09RWT/InlhaLD1m8LT+lqdqtAlpUQKRdlu5RPcELxWw4zUvbnMjeXc0cLtwUJ6Ix6ZxZwkCLARd9dM1bUNwyBDA2w530MoBI/g2tRtIdPC6DU/v/6+Wc+wJsXVOCKbZMJhnVZdenUBWHPRKZoKKhoBjh1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DL3UkFpt; arc=fail smtp.client-ip=40.93.194.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DL3UkFpt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ic4+B9XoVOJdY67wrSR0nSmZ3RGGsdUNoLalpHr7Gi6XBrZ8UvBvalbY/BAiTj90qox8hwo92DTYAoq8oRy9no4q5t9VdhjF1Fk5qPcSZgNa0UqthYA0V7MKFBVkSQL2m8fGCB+YjnFM0Yvhtzm6K+05oe8N1mb1WeaIUCg6Ev5JwrOum68/oKBL71agXoZUXbPlKuojCDWsIvOEV2ArqyRiB3Ut6ydH12yjMo8XzsKHF5PZMNCst0igOKZec61uNw8xCM4Ha8zagrO0ZFTH+H0ATdU8nUFVmmA4rKJn8270FniePzJSbMwcwmy76APm5EDfeBgo0U0Dm2Bq0PlVvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qZyYCoJZXa2dcqN+/IXKDyRJRVmj4/osO5Fzjv0Oow=;
 b=pvvlbkj31MY4rCNNSumXUVWw9fRKnzOXypCjnoFTdsJNnz/m8d86ui7G92ctq2MHRMXcS5iSu0UuRlzrZbZXMkbau1M4YA7s0etS/3p6XrvjdBQAJWQxyUQ9/w5A78yg5Avoakjf4XUCZECRSrbb6sMovvneSigWMK0t4LQEz4QqF8Dw9xIBDRJ9APcL0tMa3fqiXxB5nwN95C0tJioECFq17qyWJYh1XUKXPAmWnD7BkAeep9HuP31S7yQcbmVKQ9Qg/4EVHnxqGQAHgSCgcUvgcJ3vErHiSrzmNRJt5chv/WALxIg0h6Gu4+pPhiaAhLHwVY9AfCKi/UmFFGDu/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qZyYCoJZXa2dcqN+/IXKDyRJRVmj4/osO5Fzjv0Oow=;
 b=DL3UkFptmmnb6XDFSdF2EisaUvaCrLqa2JMJOvABgb0yFPj5Rv1ZhsgdsBwpr3fziVqm11NjaBnPUdO7m2Ak1idUFKJn4c+r93U+fipihgGB0Z76OyO4kf0zTYqHl+M/u3lb6xFHPTBiN7jqPyrwowDFRD4wrXdScCfUxB0l7gStIA9Wu0xcjGIWDj4D8RgTi2+S8T4qo4DClJ/dyqW+3KKRowoO38Tv+6dZ2JwenVLH6EIF3Yp7u2O5WsXVYZK+GQeFm31C5VsMYHSwJRFwq6hmMhV85EQ/nWiu71rfhqSH4b1vp9/LwR64DRNJwIvF+4ayp9fAyxT8YVv6IY47Fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH8PR12MB6940.namprd12.prod.outlook.com (2603:10b6:510:1bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 13:00:00 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 12:59:59 +0000
Date: Mon, 1 Jun 2026 09:59:58 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
	vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
	sairaj.arunkodilkar@amd.com, jay.chen@amd.com, wvw@google.com,
	wnliu@google.com, dantuluris@google.com, chriscli@google.com,
	kpsingh@google.com
Subject: Re: [PATCH v2 10/26] iommu/amd: Assign IOMMU Private Address domain
 to IOMMU
Message-ID: <20260601125958.GK3195266@nvidia.com>
References: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
 <20260528051738.596013-11-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528051738.596013-11-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: YT1PR01CA0076.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH8PR12MB6940:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f4d2b57-5606-4aef-ae8b-08debfddafb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|11063799006|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	wJnRBUz3mu/ZTZK3fCb4RBS93bj1t3YasJBJAXPNAVGBbSjqWw+8s5LY6qGs4RkZswr2pydhb6EwzJj+RXyc2kkb1FWQRQKUQCwYL8RPwFqWr5kjzp6+iEzbAku2eOIf6jOp38jwK2zNhd0+zuF91ockj4Xoq7EYjvCESxd9BOcXCmUuY0ro4TMpNsSQRlfdCbhz1gs2Lxq63ZttJbiJLXPJNpnUn+BEodmeeW3SWSUIoDs7/Bei71Nkt59HTUlmAMKvQ7sR5AM5BsFidjHTtTb7JQepVnNvRqw1/stx4dZHnRFWWvGmY1LCu6HUYTXEEezh/HAPrZ0TMPOXc9/5Twg82wNzIhElfwjaWhR9OphIytzFg2zmsCFp5Z2wP5iazF4L/uGoqJNlL8mmdKFEjZZ2IpSCiGkjsXqNsd61uNHNrg/zwalfGf6vZEJB6E7IYDI4qxx2ehsPd8IGE6XpA0sTDhLid6UjId1Q9tFNKuQxFuiH9dC0zulpVaRJOKdlnE4QbuEurzHlyOGmKnq3NjmCrYHPkB94ydlmDkh2iIW7Ly1OPQHkPI4F+0d9lXIULbQuph7KKpVfF7NSLa5m2XPzYLjlfsLc0g6CU3PJLenmnVrQRPDkX680jmYHDw7dMvVwpRMLfdQcKki0FIN5shZfnOm8xD4Q13w0ADraIbhn0hgjTbOLxXEIsLJYsH2X
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(11063799006)(18002099003)(22082099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z8DNPz4YMaU3xnc8KdkjHonbgSdheDC9e/Sks/doIo/CJa2zjYP8hGXNQjqV?=
 =?us-ascii?Q?gaIKvxU/qNPZvrUE0u4LCiXCgEtOc9ZE0c0bCkgb+8DrDRu/epuiXxhpoZk1?=
 =?us-ascii?Q?3KEiXVICKvOaJVj8AmD5oPEzdW/xksd+kemOpaTtUsmYZyuwIGhtbDcmsyrv?=
 =?us-ascii?Q?p0AR+AOO7h1ABdkNWJ22V/+z3D+LyMmlvposMKLu+Hzzik28WZomDeEc/4Cp?=
 =?us-ascii?Q?lx9xoWLO/g0oLudg3+6IDp63qbB1mzkn69EgvJj0+mGfNdjIKQje3+1cMON8?=
 =?us-ascii?Q?eEVbUAlzmJ1c1WYLFyy88ElCn7GlTfrZvCT7/HTi1xYpRVi/SXcq+Nub1xfk?=
 =?us-ascii?Q?PXXdYYR5A9FuouFCsDNc8a1ab0nF3lU5+L8R4X6tWnovM5F79xLO1X3zqxfb?=
 =?us-ascii?Q?xn1joWBvAyZ6KRp9kW20QWMqAVOrWijuT/1h4HyHzHZYZFIT0RyqxYZHl75I?=
 =?us-ascii?Q?xJy+W+YPt8MnwQ1ONWKljEViXB079TKBdUVPOWEjQiFEi2p+mQq1PcWe0d5a?=
 =?us-ascii?Q?MmY4TOHpY21UOdQbMd8mVetetKE1H/MogJYmYdQqa+Y8TbdAwEOjXdqADO3r?=
 =?us-ascii?Q?p1YGj6r9Pd0rf+ejFGuQ3EPGv4jG/J65H1zK/MZ4ilQ8HpxukiJgssFbRLZ8?=
 =?us-ascii?Q?eq4HK863CtYqs9AbNSc7G9eJOI0xdsqAPDhp9d3UE2voxLYYXqQie/DPRvIK?=
 =?us-ascii?Q?PhA/twBpn5VTOJNuc1rr9TsmlGXcizXd8+Zct7pbG44Kmz9Eq/wzQH1EQMQo?=
 =?us-ascii?Q?bhot4ZwBSe4VqFwQihba3B18EKV2qKnUcq4cSVk1qHbRhmeGwwRHirZgGkH4?=
 =?us-ascii?Q?0v85ECIlOn1Qd3+7bP+awb95uX9CSA5x/UP7/xqnChnj60/InNR3hsHq6jv1?=
 =?us-ascii?Q?8VS/8n34kFGUEx7xYk62vHROkT9fhVP6BDkRvgEjfBvZvT3p3bnO6M+V4Fwo?=
 =?us-ascii?Q?fq1sa+rugmbCTnW1PTdPfkkcExlxBh0MSYU/LuuTAlDVG6M2NtKp1/+SkkIO?=
 =?us-ascii?Q?IPZ6juychICqgjhmdX2HRHTIf4Nd4jD9HDfsInMncZCz+XdnxHqQfHOAaH3/?=
 =?us-ascii?Q?84+TtxI/5Ifn/OGXKfcaEzssoyd2aG3oHti047AOxBP4HZjJXnFh5HLs+lFT?=
 =?us-ascii?Q?W7phcF8bbFw9sWQtxjMighv/dg25WvM7gnVs7CgPtmNKUsHogt0wB0mzAyCo?=
 =?us-ascii?Q?z73DykeTuwt4nNfXiXvL8Qj1zBXzUM8Vq9FfWX0vnBTKuUkc6kAYF5N3WRem?=
 =?us-ascii?Q?u0vj35kMYF6XpHx+XSOkAgXPgqLT1YYGoebldkBRhLzumC/TkzWo571og+59?=
 =?us-ascii?Q?9NLLeo7coKCsR99uAIMcJOzznh/zrWkv2nkxVCEC5dZo85XmEkfoMFYE7sw3?=
 =?us-ascii?Q?WmH5MufLjolqMKYZMSlzMvEhlYpr3lOSKKaoPI4gvxQM/aWzFim6PcheivBf?=
 =?us-ascii?Q?7z8kw2huc0A3f9NdZj0G0dcEODYPLI/bFe9x3g+CZxstT3R+CxfeJ/RR44aL?=
 =?us-ascii?Q?r0ra7EuzOlikfv9MKasa+YZwpEQwmkvCj8w2CJTzmcwTSZuLzK1RQouSE0Yn?=
 =?us-ascii?Q?ROlNQyt2m8cI5rqfMiKISqJ7vQzIlllc2sl9KRnX7rjhDfmaeHuQeGf4R0OF?=
 =?us-ascii?Q?ghjl9zG4xTvc6c2QPZA25cQb4RFNTrsdwXTWPtYtpvP4Htx6vWnPuFuRZrbb?=
 =?us-ascii?Q?qdeb1/3g0MRiyExk2H8SfFTyqvyME7dU0yB6XAnk+Cf4ND1x?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f4d2b57-5606-4aef-ae8b-08debfddafb3
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 12:59:59.1761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iwftZ9jW0Lbnr9mgXgN33klt4mo3uAvivoows3rPBptUXwKeixmoo0y3L5ECmxfH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6940

On Thu, May 28, 2026 at 05:17:22AM +0000, Suravee Suthikulpanit wrote:
> By setting the domain ID, pagetable mode, and IOMMU v1 page table in the
> IOMMU Device Table Entry (DTE) indexed using the device ID of the
> AMD IOMMU.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/viommu.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
> index 63360eef6b0d..14426649074f 100644
> --- a/drivers/iommu/amd/viommu.c
> +++ b/drivers/iommu/amd/viommu.c
> @@ -173,6 +173,35 @@ u64 amd_viommu_get_vfmmio_addr(struct amd_iommu *iommu, u16 gid)
>  }
>  EXPORT_SYMBOL(amd_viommu_get_vfmmio_addr);
>  
> +/* Set DTE for IOMMU device */
> +static void set_iommu_dte(struct amd_iommu *iommu)
> +{
> +	u64 dte0, dte1;
> +	u16 devid = iommu->devid;
> +	struct pt_iommu_amdv1_hw_info pt_info;
> +	struct protection_domain *pdom = iommu->viommu_pdom;
> +	struct dev_table_entry *dev_table = get_dev_table(iommu);
> +
> +	pt_iommu_amdv1_hw_info(&pdom->amdv1, &pt_info);
> +
> +	pr_debug("%s: host_pt_root=%#llx, mode=%#x\n",
> +		 __func__, pt_info.host_pt_root, pt_info.mode);
> +
> +	dte0 = FIELD_PREP(DTE_HOST_TRP, pt_info.host_pt_root >> 12);
> +	dte0 |= (pt_info.mode & DEV_ENTRY_MODE_MASK) << DEV_ENTRY_MODE_SHIFT;
> +	dte0 |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_V | DTE_FLAG_TV;
> +
> +	dte1 = dev_table[devid].data[1];
> +	dte1 &= ~DTE_DOMID_MASK;
> +	dte1 |= pdom->id;

Why is this editing the DTE in place!?

The special DTE should be entirely deterministic. Call
amd_iommu_make_clear_dte(), and use amd_iommu_update_dte() to write
it like every other DTE.

Jason
