Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012037.outbound.protection.outlook.com [52.101.48.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C496130B51B
	for <iommu@lists.linux.dev>; Thu, 23 Oct 2025 13:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761224922; cv=fail; b=WjJ3NcNB0inaaaddCD42kWpXNtqLFB1Aw7lFWwHIlI8Ho1Wv6ue6MLkc28CJvKTKi4J79S3SBSf76Ts0hpVI8/J8XfCnRBNhEYIm9l//c8gswXiWsqzNsDCdb/lnRpmD9JFDaAsomgMn78dpKK/vwX6c3zq1M4xkfTkHk/hgJOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761224922; c=relaxed/simple;
	bh=JLsSj/BzjWZEUXRcc/35nNK6ylrJHkH3iCcWMVpNdxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BiXEMphEFzo7I1bW39SnU+q0TN+tdOK4afsHmbPmEY2XL05zg7+8c7tRb3wcIluTdNdf5oZctofJhQ54KzCiBVL1zbTmOG7+1xLcgJkEwGUNwIIDvOCSws2JS7vpXjLY5V+olhtkMLV1R3iwUzVJHLiBSv9FND2mIT/UlZYPOb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=teaeP64+; arc=fail smtp.client-ip=52.101.48.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="teaeP64+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a6wkJV+3+g2UHqa3gcG4cvKTv2fKlRFmZQNKxERvKzo7XeYU7OgQlZOEkyQnLPxKa5INs0Ijn2fqQ12qrVNRctMIVOcqFVyYE278jNkU3W1jm+UU+/BxZbq11J6Ft1jXF4uKa5a/9Pxr5A/3Ffh0q82vM0EfNX2wqj4W+mBgJtSKp86QBR50CcnoRXsD4h8T5t4qLa9gFxjOJgHj4CRKNuEiA19xeIqrjqQW0PxYyw0q9YmBKhdmsBljNWL6i8IXpEMaccGbw2ER7ObQcIYROaKFEbpqJ6e69lfy2bM/i0fF/2frwF+kBXWcALPK6mTmnTy3fr88Yi0goqtmRq90Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnQ5cAfwX2B0ej7moGQsyO9MgjGwr76bBn94K/WKZeo=;
 b=PYdtB4d5W1JuA8bRzqVJh8FcGA6C6op5GkbD0R1YaMfLRDvvcl5uEMVoiZbFAxBIvkFacv2pVl9FdfmeGapRUeHhXDTf+/Z4EmWUlOyMEPY1WDKHp4r3m06AZNUK6sm+rRfuhjbqCkzVVusVZ5VpH5CiaNdaEOq4t3ed6lczBBQiHZxwo2eLvgGG68ON35X4P5UUoVJ/yqRV23vykzui9C5SCVV+jyXWjRYilakM5LPrl4xEXGFCwfveZrIC5V7obqHPUTqw88fB8ADeZy0slTAXixsm2OWloxF+6m4cYaA8SetopxtlU6rpPvduQFA3gpaCtmvbT0nJqG/kdGHcJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnQ5cAfwX2B0ej7moGQsyO9MgjGwr76bBn94K/WKZeo=;
 b=teaeP64+yWbKprQdb6xefgxE2hMq3KC/voXao2e/0+jPWvefRiugA0QPsbIZ5xHUUo1ICCIwveE0x9s5Yjk66zwjqYe9+DGEqFPS5apVcXeELfrKZJoApHdHDa7ms51erw+DG6yOftLkqT5HuLwNKhgFiAfv+Rk1mnsaVpmC5FtU6dM9J0t2ePIXdsks3P0YfTf0JgyQzKqAPxjTTf983OLPBFw4yZwpWTcwt4yMl3fuzikNhX5uPDykWZPFpFj3qBVBSnYfVCZCc8LqvVvkpZBvfmn21aDgF128luBrH+DX4hypUHq2ZDqfVbtsbRG6EtEhE2c29wkxi76bv0us0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by MN2PR12MB4455.namprd12.prod.outlook.com (2603:10b6:208:265::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Thu, 23 Oct
 2025 13:08:34 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 13:08:34 +0000
Date: Thu, 23 Oct 2025 10:08:33 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: nicolinc@nvidia.com, linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	will@kernel.org, joro@8bytes.org, kevin.tian@intel.com,
	jsnitsel@redhat.com, vasant.hegde@amd.com, iommu@lists.linux.dev,
	santosh.shukla@amd.com, sairaj.arunkodilkar@amd.com,
	jon.grimm@amd.com, prashanthpra@google.com, wvw@google.com,
	wnliu@google.com, gptran@google.com, kpsingh@google.com,
	joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com
Subject: Re: [PATCH v4 15/16] iommu/amd: Refactor logic to program the host
 page table in DTE
Message-ID: <20251023130833.GF262900@nvidia.com>
References: <20251021014324.5837-1-suravee.suthikulpanit@amd.com>
 <20251021014324.5837-16-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021014324.5837-16-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: YT4PR01CA0084.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::9) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|MN2PR12MB4455:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b369d1e-6edc-45e3-46c4-08de12354585
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w+3Su7VgZ1g4qzmWEJ27CDgOKK14UNpXpaQfQIe6H1Dtz+SgHohC5TBSdlDs?=
 =?us-ascii?Q?/f9zRHvIwP21hVzpVEEE/DJ7y3Vb1+31qHzRBLnpmR/61q8CuMaMlV0iGCdA?=
 =?us-ascii?Q?lu2WhWYhgv86z6wpX2TDTiXyj8omRIAscXOgYqv/t6tHhElEyDBz0j0WZVqG?=
 =?us-ascii?Q?0Lqjsh4pEdeG7slh9rjUhoQ/K46NLyY9cCwKANulS/40xbHZAmRbx07e/ebh?=
 =?us-ascii?Q?IxtlVhqpGp8m8z4r83MnYxUz+qI/M3sBlUpRv7o/300pIdtvOElya1uTrpbf?=
 =?us-ascii?Q?0CuUUJZWfGYJGYchKvuYWgFkVeBjEwpPVb9Xdv2fwSjYC6HcsSoIWY+Cq9MK?=
 =?us-ascii?Q?j8ezW/AiZEyG2EvBYWGOMrKy9014CKHAH8uzTZeHZDn2SGxuUCZ0XfkeiBWn?=
 =?us-ascii?Q?EgiXEy5Tg3KqTUI8e7jcg0nq0h0TbHf7eTI8d7rD19/+RLUCKbbBxyHfCZfg?=
 =?us-ascii?Q?BI/ng7bqqwVx8+xVSmwvJk37lggAPBxTmu9O/KvWMcRW44Re0w5qE3CyljAS?=
 =?us-ascii?Q?9QHz5a43qZgx/eDzPVfOZHml3Exbzk8vDDKvtrVPQXDhfvSsfiQfhIUEjfJj?=
 =?us-ascii?Q?dR2p2DAsLQXxXjNzhI3jsNl4BmvlEl0EKF2jqr9MkeejGFXVe1JDGflJKwb6?=
 =?us-ascii?Q?uxm5He73ntzZhtDg6KTigJoR+S5wDPujJ31RaJw/piOqkjsBVNf52geLlV3F?=
 =?us-ascii?Q?hh8aa5se1pV0IoVwcD31fFFc7xWnNSbzHGEOkrr/YW+pZ2/jB/oiigZBOsHI?=
 =?us-ascii?Q?pUq8tV7v5MeULVCgJafCqg11wS9+Nt7jnznShNKpDZoEr41yj6Jxfvd/lGiR?=
 =?us-ascii?Q?s2L4Cj1zO6QnM65ysys28ZPn4aW8DYXEi6OY8UUN9sRpROuhoxAPu92gNrpY?=
 =?us-ascii?Q?qv7xjBe0i1hb911vBOr38cwsJMk+E+h+RyHN12LhmHcSYA7mZ3HIDzAFLSJo?=
 =?us-ascii?Q?SizcA4w6wwlflljJ6ll01vxj1RFGHSyNdhlBKtOicP1gJboaa3gIR0oU2XwM?=
 =?us-ascii?Q?Z0HBhNhcr5YKILij6Yxv2QkZOi+Dm9SUMaJGpcx7aC9kNRbjoLJVxMowqSgd?=
 =?us-ascii?Q?qMv/ZTzPXnmbsugJlebwZuEb6MQJklNBVhbFySO3orMWVrsEfHSV2gtZTgom?=
 =?us-ascii?Q?h7AzrCDnxvPf9cT4ihXm8oIVt7Tb+3yQYwOAW9ZGzmbBDT6B6C4cEn3hZ6EU?=
 =?us-ascii?Q?RASF+frvP4kMFizLzcpRglk9X4UFFkaCus72y7Tf5Vz4ZqBiFnq5OyUkDalK?=
 =?us-ascii?Q?gPgqTR2fk6yZXF0lKExfkW8PoPfxomRI3STgJ6avzOjxDhsJ78whOxuG5bI3?=
 =?us-ascii?Q?BoQgjKK5U+Qh3vfn+I4+O3s1Sn/xAKUS3l534xUELrI5DIB0r9wIeCtOvdsn?=
 =?us-ascii?Q?kY5inYrij+gJ5P9ylfZVXY1ySlHd4AfeAUMKBcQFW/S4M7YZXSpgMoplkTBR?=
 =?us-ascii?Q?JVYFCDFyTcBN7Ak/cEcrmDX521CvoG+f?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RIH7qZ53MGIiQERgOEtc38kA75xAbzTLzg2iUIJ+kd4P0nKp6ExcgROtc6ib?=
 =?us-ascii?Q?vJPFyJCJUs8AWtCyWYhGQXj1Vr4xNoL1RLMHLny7JvsfiJVsGndzCFdpPmio?=
 =?us-ascii?Q?TGRxsc5+s8hWgnzQrc/X722BvwYJbu6KNtyp/BmOHPav/ooPjq1SQyz2QSpv?=
 =?us-ascii?Q?1nHdDqir2o+yXaNh58P5oSnPF+H9HfvFvNwT6LkcCPvYGlIVqLP7NF8aWWzL?=
 =?us-ascii?Q?PRuRplZX8uJ1Yh2nhtQYQPVa7GwmYU3GhxUaOgIHP0K7xybEVqIsxSQ/8Glh?=
 =?us-ascii?Q?LcbhjruvKW4YQ6w5EcGptOfvFgASc0WXk4EzxMLoP2j8EJdJcYyP6JR2Zfxo?=
 =?us-ascii?Q?2WxsDPKH+th7njLn8zkt/PCMp4zTMtMAAEg6obkFlfR13A6UqzhadMcOlq8g?=
 =?us-ascii?Q?heBHux9VY38nvGTt9hvGr2dqjwup8rWtTtWVaf8gEv3cMQBbig1HNr5fwIE1?=
 =?us-ascii?Q?snP65Lzk8iuaJy3Nj5raaIJIta7/cxf/r0uF6BTUqTeDXn1/6WyhoSgotXef?=
 =?us-ascii?Q?ScOUqX0kvCXZvDBM6RjhUopSx6lfeM9KBPDfYcfprLppyJDGlqBZ7LrxKaaO?=
 =?us-ascii?Q?T9LSWpyNq5896HhuVTGYDYT4E6pnqn0q9sJSETB8WjMeKVZIpgWMTAMjdJRW?=
 =?us-ascii?Q?qeEpMl4kpf03q/n8hu7947Vfr/VRwPqwIQ0lmLj3lRmokTLcXDU/G75viCt7?=
 =?us-ascii?Q?1Kqo7iYAaUq6QE9P5PRVXbAcTQDOkNIBQX7RtNDllvVJPckRwDStdK8mM3Br?=
 =?us-ascii?Q?eAZ7CkQQ9Pr2I2M5xzCpXHJqHWF2/ona9gvQSrI/mNjt313sSNBizin9iDH+?=
 =?us-ascii?Q?e7G6m5xZVC/o4JSAepTOjNcvK2mirZfbtIWDWve2RLDZujrSmauSFrLeGwSZ?=
 =?us-ascii?Q?08e1AsLOCWAofC6VPVQK4VzIIcPSXaGCrn/YlTn4T6RFE7dGNu5cuat26ppN?=
 =?us-ascii?Q?F57VbZ4m0S3o15IJLMjv1J4f+1R1gLQg2dNQAQKaPD5qCY9F7pxO56GnNjJK?=
 =?us-ascii?Q?psoyQU0bjbGbyCuA9hSgmw9EVTgaVtcwcmS7wWWJ12hG3xqccnxMIQ62YJf3?=
 =?us-ascii?Q?/flMnZ7rwdkTWucSEhsK1jfU9DnCU0k1oXg2/lulFoswarCbAkFNj0+Rhg1u?=
 =?us-ascii?Q?TrV2Tsc+oJZHQ6pHLO2sk+1BjTm6Jhfg2dxnkWH4nv2tSU8WB9IJduZ/vbUy?=
 =?us-ascii?Q?Eno5viFulFmEyh3nblWl0ZZj6JsdKyb5FvHoSeGkZRakC59ymjS9Loc6g9I2?=
 =?us-ascii?Q?1rpj0eTvZUUIGibODdO0G0FsGFDtJ3iujsoJ8xPmpG4D2wdsf2QhzMXW/UIg?=
 =?us-ascii?Q?rWxTc7lWERiyG6iZGY/x/ukypSKVjPXmS6h500p0dF2TCqP250yOMWEEwI1s?=
 =?us-ascii?Q?cuuHOz1g/1lD79gBgbyCP8t0Wpym9kozrpKHZ5EGcSZOoI1vj9lj6MnK5NWZ?=
 =?us-ascii?Q?aIxtPcyCQQ/F0lFe/6WSayTNCIeqqRlSXGWePNEM0dmcEyN4RMwAqKvbgiBT?=
 =?us-ascii?Q?dsr9q3B1Iy7KD7tqxER0/s+bIfiQc9XTsx1Ek/pEImZ6NALNJwow0yktBrAa?=
 =?us-ascii?Q?n85qjOSnNkSaJyOfgXk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b369d1e-6edc-45e3-46c4-08de12354585
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 13:08:34.4507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d9HCGI4yhAQrIvzCeBjOlwIr/oZn+URPY9MGBbTgsvFCMS7GQ1JuS09noQBqJoP8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4455

On Tue, Oct 21, 2025 at 01:43:23AM +0000, Suravee Suthikulpanit wrote:
> @@ -2088,37 +2104,28 @@ static void set_dte_entry(struct amd_iommu *iommu,
>  	else
>  		domid = domain->id;
>  
>  	/*
>  	 * When SNP is enabled, we can only support TV=1 with non-zero domain ID.
>  	 * This is prevented by the SNP-enable and IOMMU_DOMAIN_IDENTITY check in
>  	 * do_iommu_domain_alloc().
>  	 */
>  	WARN_ON(amd_iommu_snp_en && (domid == 0));
>  
> +	amd_iommu_make_clear_dte(dev_data, &new);
>  
> +	old_domid = READ_ONCE(dte->data[1]) & DTE_DOMID_MASK;

This old_domid stuff doesn't make any sense. I think the commit that
added it is bonkers: 36b7200f67df ("iommu/amd: Flush old domains in kdump kernel")

The problem is that the dom ids that are present in the re-used DTE
table have to be reserved from the domain id alloctor at boot.

If the kdump kernel tries to create new DTEs it MUST NOT re-use any
IDs that are actively being using in DTEs already or you get data
corruption. Randomly flushing IDs is just getting lucky..

Not for this series, but something to think about.

> +	if (gcr3_info && gcr3_info->gcr3_tbl)
> +		set_dte_gcr3_table(dev_data, &new);
> +	else if (domain->iop.mode != PAGE_MODE_NONE)
> +		amd_iommu_set_dte_v1(dev_data, domain, &new);
>  
> +	/* Note: The IR, IW, TV, DOMID are needed for both v1 and gcr3 table */
> +	new.data[0] |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_TV;
> +	new.data[1] |= FIELD_PREP(DTE_DOMID_MASK, domid);
>  
> +	if (dev_data->ats_enabled)
> +		new.data[1] |= DTE_FLAG_IOTLB;

These three should be merged into the two functions so they stand
alone. These sets have to be made in the next patch, doesn't make
sense to open code them in callers.

Like this, it is simple and readable. It directly answers the question
'what bits are set when the driver creates this kind of DTE'

static void set_dte_gcr3_table(struct amd_iommu *iommu,
			       struct iommu_dev_data *dev_data,
			       struct dev_table_entry *target)
{
	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
	u64 gcr3 = iommu_virt_to_phys(gcr3_info->gcr3_tbl);

	target->data[0] |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_TV |
			   DTE_FLAG_GV | FIELD_PREP(DTE_GLX, gcr3_info->glx) |
			   FIELD_PREP(DTE_GCR3_14_12, gcr3 >> 12) |
			   (dev_data->ats_enabled ? DTE_FLAG_IOTLB : 0) |
			   (pdom_is_v2_pgtbl_mode(dev_data->domain) ?
				    target->data[0] |= DTE_FLAG_GIOV :
				    0);

	target->data[1] |= FIELD_PREP(DTE_GCR3_30_15, gcr3 >> 15) |
			   FIELD_PREP(DTE_GCR3_51_31, gcr3 >> 31) |
			   FIELD_PREP(DTE_DOMID_MASK, dev_data->gcr3_info.domid);

	/* Guest page table can only support 4 and 5 levels  */
	if (amd_iommu_gpt_level == PAGE_MODE_5_LEVEL)
		target->data[2] |= FIELD_PREP(DTE_GPT_LEVEL_MASK, GUEST_PGTABLE_5_LEVEL);
	else
		target->data[2] |= FIELD_PREP(DTE_GPT_LEVEL_MASK, GUEST_PGTABLE_4_LEVEL);
}

void amd_iommu_set_dte_v1(struct iommu_dev_data *dev_data,
			  struct protection_domain *domain,
			  struct dev_table_entry *new)
{
	u64 htrp = iommu_virt_to_phys(domain->iop.root);

	new->data[0] |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_TV |
			FIELD_PREP(DTE_MODE_MASK, domain->iop.mode) |
			FIELD_PREP(DTE_HOST_TRP, htrp >> 12) |
			(dev_data->ats_enabled ? DTE_FLAG_IOTLB : 0) |
			(domain->dirty_tracking ? DTE_FLAG_HAD : 0);
	new.data[1] |= FIELD_PREP(DTE_DOMID_MASK, domain->id);
}

(It is nice to sort the fields by the spec order, I didn't do that)

Looks like an identity one is needed too:

void set_dte_identity(struct dev_table_entry *new)
{
	new->data[0] |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_TV |
			(dev_data->ats_enabled ? DTE_FLAG_IOTLB : 0);
}

Then the whole function is pretty much just:

	amd_iommu_make_clear_dte(dev_data, &new);
	if (gcr3_info && gcr3_info->gcr3_tbl)
		set_dte_gcr3_table(dev_data, &new);
	else if (domain->domain.type == IOMMU_DOMAIN_IDENTITY)
		set_dte_identity(&new)
	else if (domain->domain.type == IOMMU_DOMAIN_PAGING && io.mode == V1)
		amd_iommu_set_dte_v1(dev_data, domain, &new);
	else
		WARN_ON(true);

?

(though how does IDENTITY on a device with a PASID installed work?)

Jason
