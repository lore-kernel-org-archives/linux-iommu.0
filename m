Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598872DF91
	for <iommu@lists.linux.dev>; Tue,  7 Nov 2023 13:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZDehB5wc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHe8Wvs0xwhqxEQAI6SjHreAPi8PNk5ZZAsihjUZ/3w5jR+p420WOL+GxPUVEw8IVWPhscvxWVLzxEcTqq4h5Fav6APB8lFJrfN/alJFd/oHv9GbjH3+rTJUKnGsxjX1/qx99bgeSZ6S2ApmW69/kbCHneP6yWgERENamQ3shHoz03tJV2VCeAvXgCAHf155Or6ITiZTVQtMoDr+XnBoa+P/VRjUkGMhHsx1EPRPlsAJHTFqYOqm87bHjTGxWaWJM4r7OlaOjqHOoY47I6tjhHZNycIKxkqW2mSBIUYxCkFxWRfGS74yWW6P+7gVf9a4Vu4A0bas9VxZ6xiwFzyJYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RTzBXU2SPIOHmPU0RpO79aW554v6H576IZX7MhB8Cgo=;
 b=fBIfQdv8WruCpd5i1tPrRhMENq5sNo53W96er1JHIQZt12t/VNTOvGvo8HgmnjVK5kY/+VnPpPyEIlBXHOtN5FdITdQ3zKtHVyyLICcYj+PdGseTNUppX5d1rtsb+VYLBo3ucc3va7/eon6Ubhwz9RtWW6BBWSeJjdkpEjwEB+sM1NsKotkoT3jiJXW8a55clldPkO32nf1ERKuYetDwrHVULArq1NSsjEEMNSbpnApQYJdrLie/DRoyap3nHsWsp+LJuUbs+Zoroj+FmYriEuRSig3rTLN5vHOTfLmI3IFk2ZumoL2e+HPROkQTPoV/BCJhjqPZ25G4+cADG2VLkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RTzBXU2SPIOHmPU0RpO79aW554v6H576IZX7MhB8Cgo=;
 b=ZDehB5wcV70xw4Nwq1TgGNVg5q7Z0fU8hPlhLssf7cuBCO+Y1iRN8E2hYiW+REaVEfjHWtKR5YJpO3k0dZgKfaKvWQKLQMYOhG7cRRj56gmKLGjfJM4DWb1QJgjwbkMYlui1o8rlkxVMyXGZYJvsI/APWdJlTJRHqeEPzIJFA4K9vgD7xENe/5ot9q7pmrYhIJZPvTeRXhDPUIYrcU9BaW6bhgX8Fp8N+1dQQmhkSWNIBEsdn+d+sjQdkjuQy+bfqw2BS1zQtOstz5Yrhflmx2rX8wbRO18kBHT9NGz9Zr8PDJkMqI7kxVU6gswqz5EmA9U5c1NkWqt0w6cbgfu6dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB8326.namprd12.prod.outlook.com (2603:10b6:208:40d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Tue, 7 Nov
 2023 13:09:18 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%5]) with mapi id 15.20.6954.027; Tue, 7 Nov 2023
 13:09:18 +0000
Date: Tue, 7 Nov 2023 09:09:17 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v1 10/13] iommu/amd: Consolidate domain flush logic
Message-ID: <20231107130917.GL4488@nvidia.com>
References: <20231006101624.5912-1-vasant.hegde@amd.com>
 <20231006101624.5912-11-vasant.hegde@amd.com>
 <20231105175559.GJ223197@nvidia.com>
 <5e95d78b-4c42-6596-c1b0-057e044197fc@amd.com>
 <20231106131303.GG4488@nvidia.com>
 <4267e033-6cf8-565b-9a89-492746c6c257@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4267e033-6cf8-565b-9a89-492746c6c257@amd.com>
X-ClientProxiedBy: BL1PR13CA0417.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB8326:EE_
X-MS-Office365-Filtering-Correlation-Id: 26c9fecd-b596-4a3e-47f2-08dbdf92bffe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iqYr3RafQ3pY7hdwnbsMUyX89QDwcW1TDGKnsRgRtzocadhCs+nCxj0SlG1+BU6IAgOaoUYhWPHC6MUq8FC94GpL1QwZCFUw0LnlqWRp4IcimFWW21AQrowG1udP5n5q9mWunPVGcYvt3YWMjkNAFE7U2JENTwMrQqfk8OJSU2mhSM2zy95bAK8HmMg0aw3HRbY4ClIXveLWJuKZUy5Lx57e42y4Cjk2Tg77srCpig9WehUKb3MM2d9XBBmDSNYC3oRygPZknNe1/sChj0sndYR5DWTu6XO/XCzTM31gh3PZrCmzrYrmvzbyzap6eq0XaGIWz3Pd1i50UpcAR+qEf6o3JffO5uGFQhsx9oj+AUfvQDd5Ecv7/PTVYUv2RIobW7RynSXFfj0m+9jUsOLpkZxz2KYKqjEzNO3VF8jTru4T2musDQEBulI9QUZKsKSn8MIJm5uTee9P1hGTSVuvkIVa14PFQwkpeyQkh3wzRqEqUtt8Wt0kgofFY+6rwJc65Dxo37eQXxFPVwfTh1F+vU2q0YnJVOPJwmRnTV93lJ1MaNMldi/fVzj6Hipa/95Y
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(136003)(376002)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(6512007)(2616005)(6486002)(6506007)(478600001)(38100700002)(36756003)(86362001)(33656002)(5660300002)(66556008)(66476007)(66946007)(83380400001)(2906002)(41300700001)(1076003)(26005)(6916009)(316002)(8936002)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XvKt1Vtw6Qc+8uXJVoT9+qhDP8tQ86S80fVnFiXPs2v2883JGo6RkBsl1fu9?=
 =?us-ascii?Q?djBQCnqxTny8BABp4ZCCVaghG9yH384Po4ZyGvnNvnouSENUz3ww8N0LfZAz?=
 =?us-ascii?Q?YUkD++CgyawkDseVkOkS5s+0pNvacfeW/X1MTiEVgwjq7JxIoFKTpbYWypxS?=
 =?us-ascii?Q?r4tQiluQCuwKz5YrUab1Cvyg5OrkcExj3QJmgTJc1ztqQiKy7NiU8Es52ai1?=
 =?us-ascii?Q?/0pNAY/e21eXQgkylAydXuY9XLv7in1PC0phRephqfM8XqrEw8HXg8t4Bqej?=
 =?us-ascii?Q?oDB1g+YHFfRDbJrciZ/iufd5IQPxPlq5/UXNuxR1UncmKiEW5QdppB80aKbz?=
 =?us-ascii?Q?MCNHeEZlZH1g0HTmSsd8WnuZtHbO3Ku7E6cvIgQwB7IsbfUzGI60zI6vB+Fs?=
 =?us-ascii?Q?qBgCggg9cqxznjbr7HG3bfFVy3ANdDjeLW4lCBwc1abTmUpSh2X1bclRyscm?=
 =?us-ascii?Q?fylcm+eGUSXtnoY3RHXYcKMErmpYFzx/1WbcQJxumaeqXMPa2PFN6YINAo+6?=
 =?us-ascii?Q?K/3BlLBzPJvigaTWsTDdGYeSZBkqvH2m076+sQIgfT1FwCXRAqztA3zagMOb?=
 =?us-ascii?Q?Oevi4TiozDh/gRkuiLb2/v9M9uN8U6fghctkZ3MoXLk6El5rppD9TJjssjHH?=
 =?us-ascii?Q?M+9g56+bCu+S9mWB1K+9psEDQFz31SgkF547iudWI0UxHqVA5gv0PbINTsDE?=
 =?us-ascii?Q?RaWUawAcIPnXAlb3uCyKZuFvYHt7RHO87jjxbw3TipSahQTjuovYUFRd3AQ7?=
 =?us-ascii?Q?EylT4AtLL9PAvFNY7yCa1OyD5sOXtcD6UIPwOAuJO41PYTbdM55gWGXA1252?=
 =?us-ascii?Q?NJUT/MG/YFJKOMtwPzNr98bDePOt6E+EBCFnPsy55wNfMVN5yIApQ0UOynYO?=
 =?us-ascii?Q?pj7Jafw7LuWfxiI4nbTWXlF8l32VE11vokYZhL2FJ8trn9934Ty7jkyEK36z?=
 =?us-ascii?Q?hW/YwBwrv+lWc97AJ+r2/tMEzxKVrJ27yfZ/3Tvj52ORFOuNGUaYDT7SsvsP?=
 =?us-ascii?Q?4An9us9Bgk8kpoAx8v3enaI3qijVn88EuSRiI7GS0+BSrHyX0N0WZO/XBGL5?=
 =?us-ascii?Q?AWJ/nSArKTlTHXR1SSzEGlPfrxCblZ1T1CvucErP7EC9u2LF5f//ina4mU8k?=
 =?us-ascii?Q?MYjbpkjFtcWESNxiAQmCmG+Guc8vkjCbch4EgP4/ow1FuFQYrGD5iFf6jC0A?=
 =?us-ascii?Q?C6T4sHDZAz/MFoPVcGY/CTEp+0ruuxorDnwe2l1BgtF2fIeU3xL73ybznKeH?=
 =?us-ascii?Q?3JphZpir+C/r7iGTUgOUf3QNAjQi3VkQNqZ5Whvr9K13+zTQJyaxYGZoRq/7?=
 =?us-ascii?Q?vMyAK7eOi0dsy2sqSnrm9Lu6b7+NeIqdO1t/40XNK5zABxnIKR0CdZH/DA8d?=
 =?us-ascii?Q?GMl9QNA6LSVTGg1G0su+FSlSDkBJW7/JV6QrtuXW1YUHpnmEHYFZnwTp5umR?=
 =?us-ascii?Q?Xv203PamNRrSZr9PKQevUmW0QyNTimuh3ZRxb0AyQ8IYn3qZ3PV3MPr4h32i?=
 =?us-ascii?Q?Hk/bnSa4WD9aqku86hgV/0fEbU75QF/zQAVc/bXOzV/UMElP0rBncEqRVrrT?=
 =?us-ascii?Q?YPJ2t5fDhSXNToYpD494Ljq/rthwwfUMsrmGkG+x?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26c9fecd-b596-4a3e-47f2-08dbdf92bffe
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 13:09:18.3872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Up44QNXHRY+WRw6RgqnFRGr2L1L5megehGXKpYNUItjjNOMQSei/yhS2zjtp203H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8326

On Tue, Nov 07, 2023 at 10:14:17AM +0530, Vasant Hegde wrote:

> > I can say that in SMMUv3 structuring it so that the attach op at the
> > top of the call chain knows what to do, and called a bunch of specific
> > helpers was reasonable. We know at the op level if we are going to do
> > a V1 or V2 invalidation because the OP itself already knows if it is
> > working on a V1/V2 iommu domain due to how it has to load the domain
> > into the DTE/GCR3.
> 
> AMD IOMMU invalidation is based on domain and we have single command which takes
> PASID as well. Current code does have separate functions but that made code
> duplicate. So I try to consolidate all low level functions.

It is really not different from SMMU, invalidation commands for S1 or
S2 tables are constructed differently.

I would say the driver should have a way to issue the commands and a
way to construct the commands. Pass the actual command in instead of
passing in a mess of arguments to try to guess what command the caller
wanted.

> > As working functions then the ops should be writable to know exactly
> > which of those call based on the op.
> > 
> > For instance, if you have a v1 page table then you should have a v1
> > specific flush op that does:
> > 
> >    invalidate_iotlb_range/all_v1(domain)
> >    if (domain->ats in use)
> >      invalidate_atc_range/all(domain)
> 
> That's exactly domain_flush_page() does (flush IOMMU TLB and then flush device
> IOTLB). Just that I need to fix upper layer function and pass few extra params
> to low level functions.

Yes, but that is not always helpful to bury it like this because the
ATC invalidation needs to be done in a few places seperated from the
IOTLB invalidation, and sometimes done without a domain.

Jason
