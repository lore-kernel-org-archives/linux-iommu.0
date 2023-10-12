Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2041.outbound.protection.outlook.com [40.107.212.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC63273C1
	for <iommu@lists.linux.dev>; Thu, 12 Oct 2023 12:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="InMxIPmX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9bzIQKnD8t8F53wXEEjn3aymgn0GMFau/Yya5XyBdL60m8SrWddJz9+g/d6YsLh1N//PoYzb+Pwj5twcoz0vgEFnLTmD287DF2iLIe4m2aPG+klT6JWgJubMybxAJ/ko8296+7zTFUg0gHGFCmXwkI+U7PanFvZk6iIClKpaaIprsZW4v0q7B5IYkWaPSOkBVhhDz4vkK5HgM5XX8DknA3NjUWvuDXZMPgrwS1yvuzpxNVUSPhgCbb6ha0XvzH83omQ8JGVWJHR2kdt10ds5Uebr+ar5D3O+hPgh3dHJLdhKr63yi6aNq8x4GEi725tSoBT2Hpo3SdcbCcQqRMFjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ztp+UPtYc/M487CPacbTBgsqn7ligOWOrafH7vZy0EU=;
 b=WhYrPmv2r75GdvFyAh/eoZNJKDGV0KxIHLaBZapT0xAZ0IoJy5N8hm5pcOo1PHrv5sozG6iqRAW3RLfcByoiER9/LSe9plj3J7jgUolN8QCOEARd8ad0ShDyGJnBtDypuzpylSTyVlEJiD/WngXm677P5CdQ6HTwSnw4LI5FX8ZGkL8ixuj2YqknK/DM9S1wTIVbaPqE3U9FdgXPqkNKEU8k449AqEv0W/M1gpnOcT7IxsHCIBjRpShwQswn9B9/hQGGi3NsO0CJA/wfTKqE5NTU2NR5IzCTdTSA7gXdCc+HWe9hmp0iKc6Wp4hKCOzxKRO13bteVbGrZWinLwBhvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ztp+UPtYc/M487CPacbTBgsqn7ligOWOrafH7vZy0EU=;
 b=InMxIPmXTeVrJ7LIAdNve+dAqksmh6pIxB2nNfh42SpJtDkpgMmigrFydhLHlUoyWqZkUhrg5f/pen4qTuhCv0cjD3Gj90+Ys7kH7Ye3lnzFvsMrohpPl0ZBS8R7jPRtAAR/mGpHcs3M3qMoNxg3q+Abu0ZwyfioE/ZuKzzvrbSxVvsP1VI8m9ys3cZd+iYGG8ykf76KBYP7OE021ctOaoEGXb/Fx8f5fgMc7sVTEEJIxUuPqy+/PVU6a/Z0Kmmvj+axnuTSft5t5kS4gIkb+ZzIc2ikvC2Ne8R09R/UM8AWd9v2NV+5Td4YPQ6ab8JmnaQySJh+taOoIdh8S6iqLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB8364.namprd12.prod.outlook.com (2603:10b6:930:7f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Thu, 12 Oct
 2023 12:34:33 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 12:34:33 +0000
Date: Thu, 12 Oct 2023 09:34:31 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Shavit <mshavit@google.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH 12/19] iommu/arm-smmu-v3: Put writing the context
 descriptor in the right order
Message-ID: <20231012123431.GG3952@nvidia.com>
References: <0-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
 <12-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
 <CAKHBV27FimE8Rnv2oaRb+QjRmYw2X27xGZe-UTjUz_ut5ipCeQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKHBV27FimE8Rnv2oaRb+QjRmYw2X27xGZe-UTjUz_ut5ipCeQ@mail.gmail.com>
X-ClientProxiedBy: BL1PR13CA0137.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB8364:EE_
X-MS-Office365-Filtering-Correlation-Id: 66f6b9af-1198-4699-157f-08dbcb1f9669
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oKxvzV1RQQCdxa73RKry0B4ejYLduCq75628nm1hf0HlqBiCwAzMAEELyaiCspMq6Fv8vCRXH63GasutOVEhR607EYKK9DYdvCoE8VIL5Pkmd17L2DzBhgf7fiWgB11VKaiYmnoqnnOo9c/3PDLqE6CicOFyHgXBoD11cDdzgKSp8rLZOK31rgN10VFp/PCrmptRf7rXIW+mKXCFbk4CBlb4Wf2fezJuGsuRwSkJklqFKtAolPMMFDyIoMQCcL4uCCdR4zflQaqDXjY8R/0Qb15gx8A5pQBP+CDUu6dvZOsKyCkG3v2hg3UJGQXvbiLSjknH7dOU2a9SZ1zUYmqVprQzPVcdS7NSE6fj6JQFnWc5HdDHpeSljJc352LEBKN6B0ebQeA7NSivNrReFmmu0uvVcLEFPQ9tutcPiSOWwskek4PtwJ3tq+A/ZdD8wblXaGoVg+CTUl0EPFiNJyRokHvQNSGnnKdoSRdt4c2RejqA7mNgQDnZBK2MKIp6VsGQ7yeS/wE3C9XZfuka6Gc5OcbQUGed7z9qMjjsBGqXi7laTS9tj1I3kwbyo8yoZZK0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(366004)(396003)(376002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(6486002)(478600001)(66556008)(66476007)(54906003)(316002)(6916009)(66946007)(2906002)(8676002)(36756003)(8936002)(5660300002)(38100700002)(4326008)(41300700001)(33656002)(86362001)(26005)(6512007)(2616005)(1076003)(83380400001)(107886003)(6506007)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ymo1NnZyWDg5VjZkS0l5L1ZKajdGSVkyNUpRWEMzV0VJMjJxTEhmOER0cjlH?=
 =?utf-8?B?Q09VWTVrekQyTDNvU0hmR3F1ZUtqL1FENWQ1TkM1U3lYdDhXTS9qL2tXU0dv?=
 =?utf-8?B?M3VNdUkxejZGNEZwRk54bGtHd1h3NkJPWmtxLzBvRVhxZHc3L0FVUjk4akx4?=
 =?utf-8?B?emd1aysxREZCaEE0OFh0Y0ozdE9YQzZLUDBQRW9DSFYzKzNEaXMycjZKbVpi?=
 =?utf-8?B?MEV0am90b0g3cFh4WXFwQjN0WWlLbVhaUnhhWkVnSW1xdnFVdkZjSTZzRWhk?=
 =?utf-8?B?SFBUWUt5TzJmaUJtQVl0ZVVaem4vN2xMOEVqN3BiaUhkRk1ablZ2YU4zMnNw?=
 =?utf-8?B?UzNLU0NsWkhYM0hsdVJTZHlGL3lEQUJlL0Q2cmF6WERmNEdsbk9qSEQ3a3VK?=
 =?utf-8?B?VGRUdi9WYWQ1dUNJLzEwRDhCeS9pcTZBano1VFRyK2F0dGgzdWhIV3p1by84?=
 =?utf-8?B?VVlWQ2Evai9ublpKcGphQmdmTFN6SklHd3F4MjVpSkxCT2twaEpDRms5dVBl?=
 =?utf-8?B?ZnpHYUx1WUd1WDdZNm96ZTRsTkJWTXY1aFdkNmVtVEpqUXhBM2xDTUtHTENQ?=
 =?utf-8?B?eWVxa1NMZDNpTWZheisvSG1HUlZxOXV2bVVGWWxXdm1sYVJwR1lXckh1L1Zi?=
 =?utf-8?B?TzU2ZHVrMHpDVEFBUDhsU2EzTDljVFZ5R3dldHgrQjJGcCtqU1ZrWk9mT2lv?=
 =?utf-8?B?NFVLYnBkTTBrZ0E2TFhrNXVvUHBYOElyaU1JKzFlZURiYnlLa1lhblpCR2Nl?=
 =?utf-8?B?aytDcXJ6VlRhQ0pBYXY1KzJ3VDJqZUs1eFhMNHh6cW5mRDNKeTJ0WEdIRVpG?=
 =?utf-8?B?VkgyWnZjMmFSMTl3UUJpdDFCd3kwQ1J3OHgzZWN5aEpjcUNmZjhPbDMyMWUr?=
 =?utf-8?B?b1hGWGZjR2wvRFJxYnpXT1RGUUk2NXQ4WjlvQ0hYYVltd1J0SFNnVlVnVjFQ?=
 =?utf-8?B?YzVHdUUzcElicSs4VE5PY1NpU3pjbXIwWFpvS3k1UXJBcGFlbGdxR0lwK3VB?=
 =?utf-8?B?cSsycTFzamp1NkVTK1I3WnNWU1RKeXl4WTF0UWFLN1U2d0xURVllWDRYazFy?=
 =?utf-8?B?YXdpdUZ4cjNvSjhDSlhlcXRjb0krekZMd01iaXdoWWx1RGhoSVIya0xPWXR3?=
 =?utf-8?B?S0hXT1RHK21LelhubGQ4SDRkSEpjaUxBcWVKMUJLVFRPSmkydWRLcGNLVTc3?=
 =?utf-8?B?Tyt3bitlR1RaSDcwNXNSekYraTNOOVlBS0JOYlNGbUlWUmVXekk2S0NOeXMz?=
 =?utf-8?B?dnhwTjhqakZlU1BxV3BBR0Y4d3EzekU3QUw0MU5hVDIxdmttbkV3L0l2TFYw?=
 =?utf-8?B?NEYvYjVNMGd6QkI2YS9mNnBYTjltLzZJemY4aEVmVXRYaytnN0RtZGhXNGx3?=
 =?utf-8?B?dzZtMzB3UmpXMDBtSW01MVIvWUdFbmxINlZ1WUFyU2I4MTNOZ3F0dlYzV3l6?=
 =?utf-8?B?bk9QK3VnZDNUWkpxRTVpdS85cXFreUVhSVN6MmZvRFlJY2JEOFBtNER1MjYy?=
 =?utf-8?B?V1BWL2NSZm9HVDkzZ0Vra2RXS3VLUlR6SG8remtiN2RRQ1ZsL0dDRHY0cS9C?=
 =?utf-8?B?YmJUeGpTUHFWMUxJa2hQZVMxbDdwT1E0dkp5ekxlZkQ4c3hrVXp4U3VmVkV3?=
 =?utf-8?B?YWVndm1IOUdiY1lmVzB3TGJmUDRNTGhDSUFOWGJwV2ZMbTVzdDVwVkVONmdH?=
 =?utf-8?B?aEh3WnhYNG12MmxTMTFJdDhqM0wzUFVJSFhSOFZnSTNHSUw1YkNLTUtzaDVK?=
 =?utf-8?B?K0dnbnEzYTJJcWcxanFGalBCcERySFZMaWpHdExvamZsWHNyMzBka0JVVFBH?=
 =?utf-8?B?S21pUENmbVpYcmlzaURzR0hvVXJTM29nOXdabFQwand2SXB0U0xMNjBLQVNn?=
 =?utf-8?B?R2ovWmtZWEVNbVdxSHQxLzJPSlRGbU9HejZOTEE5ajY2OXpaR044M0RrNW1H?=
 =?utf-8?B?YzN4Nlc1RnVhTVVjc0FGWGMybktzaTd1cEpVeVI5dG1PM09iRUIwTy9neUxp?=
 =?utf-8?B?L0FuK2pPZDJMTXU0SUpLdURabHNITUtyZVVkUXdPZGJCQWhLMTlvYlBjeC9O?=
 =?utf-8?B?K1JiNklVemcyVGVYYUxwYWJ2anRWeUFmUE9EWnl1SkpLaDZmdjZPU3JyRHFy?=
 =?utf-8?Q?oKIngYdzyjUN7pSWAA/jkKimT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f6b9af-1198-4699-157f-08dbcb1f9669
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 12:34:33.2606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MHJ/CWEDUm60F1aO1S5OeLOwIbYtXXxSMWJG3KlcL/rvZTqN/XCV9wJ/mphoBv6W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8364

On Thu, Oct 12, 2023 at 05:01:16PM +0800, Michael Shavit wrote:
> On Wed, Oct 11, 2023 at 8:33 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > If we are replacing a CD table entry when the STE already points at the CD
> > entry then we just need to do the make/break sequence.
> 
> Do you mean when the STE already points at the CD table? 

Yes

> What's the make/break sequence?

When replacing a CD table entry at this point the code makes the CD
table entry non-valid then immediately makes it valid. This is because
the CD code cannot (yet, ~10 patches later it does) handle a Valid to
Valid transition.

> > +               } else {
> > +                       /*
> > +                        * arm_smmu_write_ctx_desc() relies on the entry being
> > +                        * invalid to work, clear any existing entry.
> > +                        */
> > +                       ret = arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID,
> > +                                                     NULL);
> > +                       if (ret) {
> > +                               master->domain = NULL;
> > +                               goto out_list_del;
> > +                       }
> >                 }
> >
> >                 ret = arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID, &smmu_domain->cd);
> > @@ -2563,15 +2566,23 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
> >                 }
> >
> >                 arm_smmu_make_cdtable_ste(&target, master, &master->cd_table);
> > +               arm_smmu_install_ste_for_dev(master, &target);
> 
> Even if it's handled correctly under the hood by clever ste writing
> logic, isn't it weird that we don't explicitly check whether the CD
> table is already installed and skip arm_smmu_install_ste_for_dev in
> that case?

There is a design logic at work here..

At this layer in the code we think in terms of 'target state'. We know
what the correct STE must be, so we compute that full value and make
the HW use that value. The lower layer computes the steps required to
put the HW into the target state, which might be a NOP.

Trying to optimizing the NOP here means this layer has to keep track
of what state the STE is currently in vs only tracking what state it
should be in. Avoiding that tracking is a main point of the new
programming logic.

This is a pretty common design pattern, "desired state" or "target
state".

Later on this becomes more complex as the CD table may be installed to
the STE but the S1DSS or EATS is not correct for S1 operation. Coding
it this way eventually trivially corrects those things as well. That
is something like 30 patches later.

Regards,
Jason
