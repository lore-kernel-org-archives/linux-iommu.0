Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D77200BA
	for <iommu@lists.linux.dev>; Mon,  6 Nov 2023 13:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XfBIv+J6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFT6HOE23/BqF71wisoun0tY7gcihs9qrtyu8jDaEV1ZvtFS4WKw+N5CmjVrdxssWBmvT1rEEVmBaVUL8iE+0J8XCQ0ZU1HyWrdl+wRVJrXmrSJSQJilA/6TelJfNG/EBSiucjZKD3MPYba/5IeiSMFe9rscRvnFoTV0RkNwV5iBw3copBqBx0u3jTfX/8H9dCOMMtruoT+Qw3+t++psyq/UA1ZaC4B6htI9mqLO3xFFB2XvhNla3qUQMu7eBUE0I8XCxVENED0Dno8coabonZHJzsKtxeDzNqddH3qIqFQIjk6HB5VGP4xHOm3FPeR6NYUj35akG5CbvaYEFH8zGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYtW4SjF03ZEq1F8+3l5vFnLHQdjFBG7WWMPz+GuNaI=;
 b=MDpo2IN+aY7qfMpGTKxivfvXVapNoGgQZ+dp9rHJWHpRLx5X8BgIoAJ5+HwVjVCvm7f02CP7SBxr0JIPvJQnTi4w0jN6k0dnLZr2tBZRhXln3om9Oi5RTootElnxtJBJs4hTqr/sZE5ydLkS1/Dn0ZOlsEzCUcgaot5X/vkDNExRaBHZOrpG2mc0/7TpZKd85OKE7maPW60IMqz1GVO/5dVi2tNMrKbe1pEEXGAzaD7lpKJL5JnDJbiTlPdxBK4TDbV3DsagpkrL/9Jthhvz6t+hw2f0WRBR8EFjg8JS/mfyd1KB+mb/sv91PIm+ApuT9e0h7igHqiunJWQIT2Iubg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYtW4SjF03ZEq1F8+3l5vFnLHQdjFBG7WWMPz+GuNaI=;
 b=XfBIv+J66/QME9MB1aIxug2KgyBWsE9LcgpGDVRuehq2meMW38/uA2sSomeYcqVEWmUUO+AqZutjPwrUUYHWhJu2X+AA1V6gC9KTgBft8obnnH4Ii9IZ1tr7j0J3XlMcqyHd05hAuqRc/wubqXN0Gkm8AeD9wd8ZhRtfdTovYLMFRirj5w+eVfx/9BD50dWHJmjZBf4DxBj0Ucuf1za/KwuxFTRdr5+U+bBim0pzoRak6XaV3i6VFbGPEovm+IevWvv16nduhd/QeE7xmOc/FdIkL6byn9GSEZck520p/aSj35h9EcwF3XNXqqWpjcmzobqPVlKH1f+zU4s1AG1slQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CYXPR12MB9338.namprd12.prod.outlook.com (2603:10b6:930:e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 13:13:04 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%5]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 13:13:04 +0000
Date: Mon, 6 Nov 2023 09:13:03 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v1 10/13] iommu/amd: Consolidate domain flush logic
Message-ID: <20231106131303.GG4488@nvidia.com>
References: <20231006101624.5912-1-vasant.hegde@amd.com>
 <20231006101624.5912-11-vasant.hegde@amd.com>
 <20231105175559.GJ223197@nvidia.com>
 <5e95d78b-4c42-6596-c1b0-057e044197fc@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e95d78b-4c42-6596-c1b0-057e044197fc@amd.com>
X-ClientProxiedBy: BL1PR13CA0327.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CYXPR12MB9338:EE_
X-MS-Office365-Filtering-Correlation-Id: f3751216-c8a4-40a4-f298-08dbdeca1c5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TkE6hkBdph/qP4Y//uTjzjBsSTxrrSq2DkvTdHn9zyFrNNEEfXpm38OQHFF4RZ69TkaSVmOuAz++ymzYuSW2VtxhWDpqPpIWift7EKj5ZZtN3O67l0h0HqZeuhPnR7QsEde7f5wQb/VNLnrWD2ihB6CNENkSH+W1Msq1TggPZWK0h8ahCMvlpyAs6W8A4L2dF/EpVrhLe6OCW4rMA3R6j7yzL57qjsnU9QHvQ3bU/iY56TMeVKlJ0T16lGeBEBRiwCKhN5uxXpRB8+IQy0e5cx4M52K2hbTErD8jZE0Z4KehSIdcB/qCfiFfT9UlUXBAJxAgGhf2At/lv9yAY2E/0A821lUL9QdYjeJ5qXPLf5qyGX1hsaB8YAiQ/U5FvHMlLA4szat5JCyIhzcd4Bjhg5JcQXAcH+psXy5ggjG7KCxk3WduGC2pduCG/PxUvtKp1wJtxulkP7cP3xhwJzZkgR1ExGceVkWiIRah3Av8PVUrqeiIO5zuOqilCZyDpjsCjdtlYnNFoUJ7earl/wRRYUfz0iwv/O+8xEB1+I3rkcuNFPpfjm+/rSkQ7pzQet61
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(346002)(396003)(366004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(83380400001)(6916009)(316002)(38100700002)(478600001)(53546011)(6506007)(6486002)(66556008)(66476007)(26005)(6512007)(66946007)(1076003)(2616005)(5660300002)(2906002)(4326008)(36756003)(33656002)(86362001)(8676002)(8936002)(41300700001)(66899024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6/DjoJwqAbOLxUcSiBM1czQFAbeFQj+WLYgHO3H/PXwHBG7GQkMemABkcC/W?=
 =?us-ascii?Q?GzlT6ha58TG6Apq2fjj7+0s2Ua5uFdnzeDqq9dlBCRERYQXsZ/Nj4HVlliy8?=
 =?us-ascii?Q?uX7LL9XGxiA91Gog+MixY7mFNeGswPM6mHhxEDHJxfFPTDQ+QSQNOz5ANk1o?=
 =?us-ascii?Q?nMrXwoUF+YI8oyKEyzuHJwZ/6r2rivLnW2mqw8H506IGNkqGR3uUQFoHl9Eg?=
 =?us-ascii?Q?b6/tQCuiWLaafe/9jYV+DoqMazEHZcJyN4R1L3rZBN7dBI+i3iDZnAd8op1+?=
 =?us-ascii?Q?vbwPU6cJ+U4mAMvXsyf4wv1zzTheyj6RxMbkbRRLwgi6fufgJe3XzaT6Hxcv?=
 =?us-ascii?Q?/zJv9ifpdnZGDfZ7klDid4ubXfPxoNYmcgbz1Z9x7dNdhF4IpzyFTArT1gGL?=
 =?us-ascii?Q?ykRnUMkYVP5TCC7m9SpoYzn6xjIifDP4OPS0I73v6szp5Ihd27NqQfR2Jo5r?=
 =?us-ascii?Q?ZY3V8+iYOOC8o+fU2AhCKBh/qfXpQqcaGnZklVBbI+DwApUgPAhYssoWyhKc?=
 =?us-ascii?Q?TlIDJBbCU9zRBuBIgJunNHy1DhDqyjKeRPs+fVlAPsfW+WqjLLXviM0iRiTS?=
 =?us-ascii?Q?Ei2Ld+yZ/lOh5VWGBdddbrQZ+cvEBI2vVDokCpIa/NfQnVVnjqmR98S1cqvC?=
 =?us-ascii?Q?06HA/v37xUGfczKfC/qa3hxO3j32y7msdNolDsNe/BRaxSLGhfksU2mHNCMc?=
 =?us-ascii?Q?w+rkYXOSSPIW5cF1dpjF2AFbhMHpvRMxhvXQYVtesYXPZB2tAKyNh3lcK9hi?=
 =?us-ascii?Q?evshy8jbMo91SvnQNcgYJLI2JMRMdsRGDxtCkkhwka9uLAWlFIDg/afx8HUe?=
 =?us-ascii?Q?fPNFixCoEPAPanjLXx02Kdw/gZF8CfyvaDMpa33ItFdGq36mI3xYmMTmB7Ef?=
 =?us-ascii?Q?ppo7nj67/bYWj8EiS/pE6URARvcE1Jj75lByZtm0xyhKkyC6xaJO2GNg4++F?=
 =?us-ascii?Q?p8q6gAVYjp2O6PXCxvWZpHxL86OpsHe6exD6YtKsT0Bmt47EdWVs8dEVibJJ?=
 =?us-ascii?Q?HKrBx4JWTIbdzLppvHA64J9h757AFZMGoUvIH2Yx81Psv0r/PLJY2mAIFv//?=
 =?us-ascii?Q?JKe+VJ/6zowhuVa6twkB0gmYGRySI9hpLOfZ/HAvRxyZY1qiaveXN7uqw1Zt?=
 =?us-ascii?Q?7LjvBI+z91fv4ETlq0y1wMX5CpBbKEe1a7FVz0glYfB7seDyJFvg3tOT5IWT?=
 =?us-ascii?Q?T4EbZUGbvfxT17IB5NJ68uHR/lMPip8C+WkBWC/SJkfUroly8oSOT8FKV1Nh?=
 =?us-ascii?Q?pKtVzeHaR2AUxVSyRRKrcdUl4FHB3ap1IEd/uwuT3SEEp/D94dCHf91waOZB?=
 =?us-ascii?Q?ZY29KBVas7fkaz9wG32YADLdj29mmJUAwcnwxmZHz7VyMkh3Gxxv4BrgUHKi?=
 =?us-ascii?Q?daQVd07wOzgKqGyLB4uggXTyposyDq7Bu30MOl+PXykJRPn0k4yg0juXhk/I?=
 =?us-ascii?Q?g9dYkrT5OVHXNOi7+NWxx+HSigWiO8C97ewZP4VQ5yERYOpnYx4e8NVRIrO9?=
 =?us-ascii?Q?ennUKTkAzPvbydc/XtZL33T347rSo+wMpgXoMal92WPaXekoC5Aqj8ixvBlQ?=
 =?us-ascii?Q?NBYE8RUjDKeP9VFxGnPNBhzy/AWUi89bjE0M5AA7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3751216-c8a4-40a4-f298-08dbdeca1c5a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 13:13:04.4407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vbJEp5tqdrHBsdQgsgUix9gA0dYaEc68rGrIY6Ro7ktmpISe5lnyxofponYvlZXK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9338

On Mon, Nov 06, 2023 at 04:42:17PM +0530, Vasant Hegde wrote:
> 
> 
> On 11/5/2023 11:25 PM, Jason Gunthorpe wrote:
> > On Fri, Oct 06, 2023 at 10:16:21AM +0000, Vasant Hegde wrote:
> > 
> >> @@ -1557,7 +1583,9 @@ static void domain_flush_pages(struct protection_domain *domain,
> >>  void amd_iommu_domain_flush_pages(struct protection_domain *pdom,
> >>  				  u64 address, size_t size)
> >>  {
> >> -	return domain_flush_pages(pdom, address, size);
> >> +	ioasid_t pasid = pdom_get_default_pasid(pdom);
> >> +
> >> +	return domain_flush_pages(pdom, pasid, address, size);
> >>  }
> > 
> > There should be no such thing as a pasid for a domain. There should
> 
> We do have default PASID (zero) when we boot in v2 page table mode.

That is the PASID for a RID, not the PASID or a domain.

> > not be an api called pdom_get_default_pasid(), it is nonsensical.
> 
> But we have single command to deal with all IOMMU TLB flush.

This is probably a mistake..

> I have a choice of doing all checks in low level function (what this patch does)
>  -OR- add checks in all API path (like flush_iotlb_all, iotlb_sync, etc). If
> that's what preferred I can do that.

Well, you should not have concepts like the 'pasid of a domain' and
you should not encode the v1/v2 type into the pasid. I didn't look
closely how to sort that out to say exactly.

I can say that in SMMUv3 structuring it so that the attach op at the
top of the call chain knows what to do, and called a bunch of specific
helpers was reasonable. We know at the op level if we are going to do
a V1 or V2 invalidation because the OP itself already knows if it is
working on a V1/V2 iommu domain due to how it has to load the domain
into the DTE/GCR3.

So if you have:

   invalidate_iotlb_range/all_v1(domain)
   invalidate_iotlb_range/all_v2(device, pasid)
   invalidate_iotlb_full_v2(device)  // Clean every pasid
   invalidate_atc_range/all(domain)
     invalidate_atc_device_range_all(device, pasid)
   invalidate_atc_full(device) // Clean every pasid

As working functions then the ops should be writable to know exactly
which of those call based on the op.

For instance, if you have a v1 page table then you should have a v1
specific flush op that does:

   invalidate_iotlb_range/all_v1(domain)
   if (domain->ats in use)
     invalidate_atc_range/all(domain)

No maze.

Jason
