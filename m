Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F041130F91
	for <iommu@lists.linux.dev>; Thu, 16 Nov 2023 15:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oWq5p3pu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2b+g55UbC6KaSqsGw+DWRV0GXUjjuMtkZJ5SyRpZ+M6uOZ/ygo6OKLsGOmFFqCpM69kVLxBb9fBXEIQTWi8pBwkbW/DPBiVgQ9pFJfESapvY4NqZ+KM4Vxn7ow0afMGR5chAWHELBgcHt7T2NiC4X7kziGn0jsIDq6EStjH2e5/1CKAv6YbOF3jF22qWCviFH9/nc/+x9jTJJHp9r2VthmiGASbTj9vyn5GvoEzSe7FDYUn4dofGNuhcap1hygONr02CQ4AWI925xqYhM8EbdblAx9xyY2yHvGTbfkpZQ+o6whbh42bjlEKI0+xHz+pSJ1fp+fnakkC6Wtty8Cknw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMTTkBeJtgcpx9EfJ0EpFAyVqGWy4aiDq3DaXhtYy+Q=;
 b=nBkfjQDSmWBb2zb3sZWeZUNtqAzFJywLksUFOb4uoTr7i5d01FzsIBHGROezGXc6rzxb54GECV3vDGSC8wZ84+yNLBfgltial/AuPBA1EPwr1nTv/vc6FUHNDzz4a68UaGUenNz3W4GGiW1l4eehDrcSjwV35A7WIiKFbxBZypQ0aPj3SBsZ4TlYbfJC/R9DGvHla+LlVyuu9SSFwCGsnWjTjz/as7NBOVOPN3UYAqXyOC3diBl8OmQVkwV3TaSbd19DgERpoke5Xlz2YTMDybQ7LHutuJ/KjbO81ARox0DfJ1XXaDJ8ZMhyHjAPij4hh4ltR+Ui8qQ+YtwbL4E9oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMTTkBeJtgcpx9EfJ0EpFAyVqGWy4aiDq3DaXhtYy+Q=;
 b=oWq5p3pu20R5F4suYQIEgN5/3IHMeWmRD8acoHk8lK5ha+RmtV9vDiogtCO8JLjRBQtL6qWIJRFlZTGoVHJPmRtGBqEecz/24FkRiSNHErEEAuiU4Hwmh6gXgoZbAnO/K/b7hIxkGLRgQ0gp6KWpiWO2Gkj9B9zyg9o+qBskm/OIlj+qt35JT4NkNRwEu0FLjEpBvLVZ5tLPdAMNwIELxY+JbjzUOy3D9+RneEzzBicMNLMZezBcOqdJI+BkKQchDvf6valSMvi3EFLcG+9yP4OY6RFGweoGFbwy1+baEZ0MJqfs0GHA9SBlLUi71sE0KpdjOXDXCjDm6MlxAMgbJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB9254.namprd12.prod.outlook.com (2603:10b6:510:308::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Thu, 16 Nov
 2023 15:44:36 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 15:44:36 +0000
Date: Thu, 16 Nov 2023 11:44:35 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Shavit <mshavit@google.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 16/19] iommu/arm-smmu-v3: Add a global static BLOCKED
 domain
Message-ID: <ZVY44yzfiPiwaVC+@nvidia.com>
References: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
 <16-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
 <CAKHBV26_HmRixNa1cZ-W6U3UBbRK1zRzXN7QS9XgqL1zZy5LyQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKHBV26_HmRixNa1cZ-W6U3UBbRK1zRzXN7QS9XgqL1zZy5LyQ@mail.gmail.com>
X-ClientProxiedBy: MN2PR19CA0021.namprd19.prod.outlook.com
 (2603:10b6:208:178::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB9254:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c739ed5-4cc5-415f-bd7d-08dbe6baefd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vjm25XvbMfaAOMklirjzCcU9N+nlfNksDyjnljbfFDjxR063M5JZIOJOU0Mx5jxodRhXCcuTXsqqVqJrX/o7p5zOyKGBx1M7ofSfZEpImOGDdAgCwZu45DnMcL31LmJwn+kQjJu43nILrx4PA5vMvG11E9NlW25vdSIOZnTV+d6/z3abg1f3i3+yiCWQ+XNXWRfHy/ynYJGXHr5cYVAqOlXNn5uSy6r0G4AaHIfxw0ypEioEnYwD9Ltx331emanUQX9cRa/joaJ5S+Lo3nlUOClMGJMntRIoFzejUCN19xCc5+XNvreLbNZKHgzptDSgChfA544newzDoZvEEx8VVBhRmPcrvbKHiDwm/0Nywn9patygQiDSrLDeUY3SXBMsFiAQmFMiXsgJFaXqVfxhJl0m7BwjJrBkHBomGELTUzCN5qdTktvYpg2E53QCx63CRd0L2k4RnLB0qLAej7vaENLNX99+qpVgoniyvMmpp0CsYC0LBamhFwy0ojp5LtkqTfxKfLY+3N7KA0W9QVGdSQvwG3qPTl6KiQx6s6t2IAi7towc/WXcIjyXv2+80XJN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(346002)(39860400002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(6916009)(316002)(4326008)(8936002)(8676002)(5660300002)(2616005)(66946007)(6486002)(478600001)(66476007)(66556008)(54906003)(55236004)(41300700001)(6512007)(53546011)(6506007)(15650500001)(83380400001)(4744005)(2906002)(38100700002)(36756003)(86362001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXk5bEM3enc1ZTRDa1VOQ0I1ZHR6UUZuY2xIem5Yb0F4L3AzTHpJMFE3QkZ0?=
 =?utf-8?B?QW9sYUVEeE5oWkhBTk1CRW1nU3ZIbU4rMjFJQVlTUjFvNmptWm9LS3FMSWJh?=
 =?utf-8?B?UytvVHhuU1hnYWdhcjQ1LzFpMHlHbWZlYVRiLzFoTkNBUFkzb0VGWkFiK2RS?=
 =?utf-8?B?WWs3MlJ1UGJKSGhrWm5teFk0L1cwMWE3WXBlRVV3VnJsd2VNMzY5dE5lRWZa?=
 =?utf-8?B?NkNma241LzJLS3JiczhMM0ZhUU1VZ3dSZnY1RFpxODJBSnU5YUp6S1F2cWU1?=
 =?utf-8?B?eHQzaTZyUjFZZGNPSUdLMVBFckZSYVNBbUlkSmYvd3NCLy9CRW9KaFZGd0hs?=
 =?utf-8?B?UmdFb0dldDV0NEMxSHpocWdzTmI5ZHVZZTNLeStWMWhFRFNzbGxOdXJBbmVL?=
 =?utf-8?B?L2VUa2ZRbHkzN3lTcUxaN2VoUzBGQis1V2ZZdWlyOUt0c0VhaGMyMjFWTTRj?=
 =?utf-8?B?cFY5T20vT1BQbU5QOHI2TEVRVkpDeXAyNW5tcWV5U0pYa0l0WGpaQXk5OVZX?=
 =?utf-8?B?ZFNhSFlpTzF2dGxUMWNvN0J4Njk1dHdFaWkzTzh5Nkppc1JSMGF4Q1U1bnJn?=
 =?utf-8?B?WmdZWmxmSnlXYWFnUXA4WnVuclByOTdmU1lQeHR5RkgxcUV6Q1QxYXRyb3pN?=
 =?utf-8?B?WlNkQXlJeHJhNTdpRkdvelVXOCsreFI0V2ZTa21sd1FXbE9wemVtSy9CcGlF?=
 =?utf-8?B?djJsUmc5bzB1SldmNkJYNmZjZDJPWjBZNW5qOWE1Vzlmc3p5WVVFeFYvYVMx?=
 =?utf-8?B?amk2TDVlN3ZyRVN5ZnZIdlJMby9xK2Fnc3dCQzIzd000cTl3VmlYa05JWnY5?=
 =?utf-8?B?VjJGdmFJRGlYQW5vZEJQV2wwbGZHSHRER0JSeSt6ejY2anpxbDAvSUJycU9s?=
 =?utf-8?B?Z0wycTkyaENFL21udDFWRWwxQlhoUE1CWkZLWXphc0oyVGxtaE1keFoyMEE4?=
 =?utf-8?B?VnMwd1NuUGFPYkdKY3BQeXNnbUlCTFZPS2hwQW1PVUpXanNhQTVhZGV3N0tq?=
 =?utf-8?B?QTZJR2p3Q1dwTTF0L3RORHBHaEI4OVVrT0NHbnp1TWFyZDdueWdyNWRaQmgw?=
 =?utf-8?B?U0gzRmoyOFBpQkYrbWFjc0Y1eXh5QkpIZ3Z0clZGT24rVkxTWFg3UXloOWJI?=
 =?utf-8?B?SkV6TmVEOGZyRmFXYUlxR0o1VXdJNlRPdHg4NHdFNUtuN084d3FTUzdxbTdI?=
 =?utf-8?B?MGZDQzR0RFhnZGx6U1VCaG53RmpNVDMwRVpSZktGVXhvK040Ni9Vc1QzVHdF?=
 =?utf-8?B?STZINXMzblJ2NlcrdlRZQVFybS9SMFlkb2VOL0lZOFlvVXVqWGlwVWNoUy82?=
 =?utf-8?B?MEtSUlZJSmdYdktLN1dEOGU0cFFYVVFSR2tBZnY1OTVoZEZ6bldFdVY5N0FF?=
 =?utf-8?B?bWUyNFVINlhWRVV1U3lyWXBYUjV5ZjBVWjNOem1MMDdyZTBtaTRjSHpITysz?=
 =?utf-8?B?bE9jRTdSU0VuUUErUU1rZlRJblJtZmdvYkJPc0VNd1h4MTJNdjh4N0poS2ZE?=
 =?utf-8?B?Sko2WEc5QnRYM3g2WEFuTlhnS3E0V3Jac3dGKzc0S2tselFnRnpPSThBWGtY?=
 =?utf-8?B?UGE1QUc0RXZVUnFZSzl1UkJRM292S2NpblcxemNDdFN4TjJYKzlmVGdKdXVY?=
 =?utf-8?B?bDNVSndpNkVaRWk2cGpXcTM4dVJYd1pWTUp1Z3BHTE95alZ3dU1rVkRscDUx?=
 =?utf-8?B?NVNzSy9tTUVTWFNXdEwwYlFnWWZHZFFaOElrSlhiMGtYUzVGNDhhZ0NabDNE?=
 =?utf-8?B?Q01VQ2gwb0k2Q1pWKytXTVVFOFpCZEV2ZldqY2tUZEUvNDJHaWxvclI3a1Bu?=
 =?utf-8?B?aVo4Uyt5RzFsREFJeGtIN3Jnb0o1cEVUWkZjajgzMjB4R0tscldyekNsRlFz?=
 =?utf-8?B?S1Exa3Z5Zk5HM091K0wyb3A4dW05aTlzK2EzK0lUODZyMFNQbnBGNUFCTFVq?=
 =?utf-8?B?V2J6VHdUa0FRbEsvNFV0akZsVGxZcGhqL2N1TkpMemlURUc2eDJiemd6dlYx?=
 =?utf-8?B?amhMSk5tbDNFNko2R3VYOTl6MnhyaFJoMWxwUHJzNzNkd1pUUGFWTytZV090?=
 =?utf-8?B?dUN5OEozc1hBVE9qUlRBT0gzdHZZb3VxUkZpckU1YkQzdDY4VTdGcXFZeVRH?=
 =?utf-8?Q?sWAwz0OAlOpxtneZ8Ju+2u8ui?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c739ed5-4cc5-415f-bd7d-08dbe6baefd5
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 15:44:36.6278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rK3x65WFKd6aSLqPN/8eudGcAvpFmuZeV9OoN3Vipxzbdc22dOQ9JgdH+fe5kn/S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9254

On Wed, Nov 15, 2023 at 11:57:39PM +0800, Michael Shavit wrote:
> On Tue, Nov 14, 2023 at 1:53 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > Using the same design as the IDENTITY domain install an
> > STRTAB_STE_0_CFG_ABORT STE.
> >
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Michael Shavit <mshavit@google.com>
> 
> Are there any subtle observable changes hidden here? IIUC the iommu
> framework would have previously installed an empty UNMANAGED domain
> but will now end up installing an abort STE instead.

I don't think meaningfully. The empty UNMANAGED domain is a fallback
for drivers that don't natively support BLOCKED. SMMUv3 already uses
ABORT for this use case in the pre-boot and unattached devices flows,
so if there is something wrong we have an existing issue already.

I suspect there are slight differences about what gets logged if a DMA
hits ABORT vs UNMANAGED, but not material.

Thanks,
Jason
