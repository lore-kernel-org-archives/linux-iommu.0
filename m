Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACA11E529
	for <iommu@lists.linux.dev>; Thu,  9 Nov 2023 14:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F+B8VgcC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0vjrnISOGcWWIUmzk9cB+nNT35DB14HagKWy9K47e8S37N7m9oaVneEx1gV008sWMt2Lf+LJqE7po6gF86NXZknJFnhnB4I2RABAE+O3laxRRCnD0bROSb1wokdbGE2BzaX7sCSPLjUKrw/p+as971/EAwzUZCXZEZjaNSmwodf1U5mxZo18LKzioL4PqQ04qwne42qrwOqn3Rf6xsOzhrzfdPjJktNFrJ7fezxK0mqAiBCvu7lXLlV9UAVi1zIlXSBBgSP/xAjmM1ArtRWxhwfGT8mE0pm65/FVp9JXuFiTGsMiVLb7Q6ZQ2qYtCEcoXVGDY6HdLL4CXyAXDLAIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4w0MrJUmRDU2aa9aT5ZqyCyfJUnUY1drWgDQXA9PUtM=;
 b=Gv3XLa0Ji9gT+kTB81o6tHHxziQwHX2T7DTVIw8jYl3SgjmjJGUrPzXR0TItUpwifYezmM/NhljoeiclTl79oBTenax3T452X97p+nchZmhzsmLMuFMgRZAcueEMPBUSYssF1a7ia8WwLcRXZTi3g2MBvJb/HtW2aUXxfGfgGtAOAR8f3BU23Ie4MC3kWCbSyVEaCkPQakXaXNhjIvKU+kZHcyYCBIPhoaK6WVTP1W2WdZke1vhqX2RS1wM1nS4/AqteAmISwwSr3fFCMgOcbI/1CnjHjcHCxjCdTwxVJ3IekYbaAXT6GE294PJvf0SKrWEf7vOQM1vvmuNxtvZUhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4w0MrJUmRDU2aa9aT5ZqyCyfJUnUY1drWgDQXA9PUtM=;
 b=F+B8VgcClEWG1NnLE/ZrYUbcbb5dkIugHIIqeQxbf8D30795nWOhNplZ6fjqyd/eeYEwqxFXOSY+Iv9obWYnT3K0vvTTVOWmD5CZ5ceuknxeNv7GRisg/GYG1bTyptujgRlHuLI63IeTt7W1brv9/numXpPk6+XoofUAU+o8aw5e7l6aEfkdXrFKc6DJKm6CK/EF+ToEuoHiobGlXIa0qIZ+fhdHwVF6eVBPS4FKYmgWrYcNvIsc3HAVdq2vxmZqJpdv3YU+qOY63vDMSMZGS8UZRf2pnPaYZk5rUOrEt1rnPJAs2vmY7oINKUmkSpCCOOv1sH8SMCSMeU7UakhsXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN2PR12MB4517.namprd12.prod.outlook.com (2603:10b6:208:267::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 14:10:58 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 14:10:58 +0000
Date: Thu, 9 Nov 2023 10:10:56 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v1 10/13] iommu/amd: Consolidate domain flush logic
Message-ID: <20231109141056.GG4488@nvidia.com>
References: <20231006101624.5912-1-vasant.hegde@amd.com>
 <20231006101624.5912-11-vasant.hegde@amd.com>
 <20231105175559.GJ223197@nvidia.com>
 <5e95d78b-4c42-6596-c1b0-057e044197fc@amd.com>
 <20231106131303.GG4488@nvidia.com>
 <4267e033-6cf8-565b-9a89-492746c6c257@amd.com>
 <20231107130917.GL4488@nvidia.com>
 <875d1c5e-05ae-7248-3823-38a5e1e2fecb@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875d1c5e-05ae-7248-3823-38a5e1e2fecb@amd.com>
X-ClientProxiedBy: SA0PR11CA0103.namprd11.prod.outlook.com
 (2603:10b6:806:d1::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN2PR12MB4517:EE_
X-MS-Office365-Filtering-Correlation-Id: da8457b3-4ae3-4f41-7239-08dbe12db256
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2H7nA9eH2M3/3uZEc01g9w/1lTDsqlAcb/NsU2wB3PKZ5aYD2sceXD/pSZ+U7AvgioFM+fk5gEP7XkNI82hBmXaWmjpQevLG1E6IQKJGGhDYh+LBIIGTRhEo9wHtOxSsdQ4baVlaMmuJOBIZmlmgL3hKU8MSwJgHfPc+JljXrwEgaK63sx4wz4OiWRkyufh6enjthAo4D1VKsva/j71mKVnm6f3zJpSwDmSSPmQaMvQBdyBj6EeCtzeblbyV35p7lOcUTFk7m80CRFXpGxBcjDkFE9v+Z5vf5huXptQWXakn1xCMXUfKLcgm4KcFCe2nD3YGFFilETMFuKJimfffxxmgfpbODgF17L/anf7kq5yj/t9lvM0v1pHElC1rZtMUhmM10jxAMGgxCYkAEjxEN3O3igNOiqItMzEW+0gOm8IMU8mmRJceqcZfQy4T4bWOsIh2lbeWzJoH7mc+0tQmGt737tCjG+NVkY+93dgLMqUxpUfriCp2Cr1pnA1X8pAJLQaiYEGLkRSxc9cfikwpWyDrrWIpDD6snjflwkXg0lY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(136003)(376002)(39860400002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(86362001)(966005)(6486002)(478600001)(6512007)(5660300002)(53546011)(6506007)(316002)(6916009)(66556008)(66946007)(66476007)(41300700001)(33656002)(38100700002)(36756003)(4326008)(8936002)(8676002)(1076003)(26005)(2616005)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JDA7/5oqiFzNg4H89CMHlqJcGzci/BMwCo3UjlU3keHGw5jDLip/gCW+XpX/?=
 =?us-ascii?Q?6c43KyOaJdT3GnWWOxyJHkYqE9MR2oE/CjRlmun+lx/lT6aNlqQoScBZQFHv?=
 =?us-ascii?Q?7Z75xDtUvbx8CgVpnxgLQ7eUcA0mc5m3tduK1DX1Uo03ADr0rwAURNdASgdL?=
 =?us-ascii?Q?8YkCbY5Bp1NUZReMrWEGZ3j909WHZkUF8WEMg1TaBE0EuUwwoLlTLtkZkjHU?=
 =?us-ascii?Q?Qyyg9rBKOdEzOcZdl4d+7dZZA/3r1QIfiW1X5WiFER7OdJaD5uNjboHUzYHl?=
 =?us-ascii?Q?DHX7e0tSzf//bdairM/tujKyt09hHgKnmTP3w0G5Vn+vdokqdkc2qZi6JU8B?=
 =?us-ascii?Q?nXMwae27f59Gzf/+Mz3xntyqlp461Hs3E2MaMa8fqKGhaNAcsy603WY5Kcg8?=
 =?us-ascii?Q?iMuhqqXJSTZHhRPeouMGP1XjMKJhvWzUImNDcMmiq4VWwmHORgZJc6aXSRyp?=
 =?us-ascii?Q?49aeupWvgjoDBVAXSPZ5HhNLhew4W125fb3b+hbHdmZf4QyOPBw6IZe7ds9W?=
 =?us-ascii?Q?A6SltcMEhv+uSh2AuDuu6x6X2AlO2ByU9zq4B79osqzjNmtNVWe2HzDOpZeH?=
 =?us-ascii?Q?0jP/nMUYRQ5+UhazjtPOZKhGu8qfCzghm/bnAvW/I3U+ETeD5yGNml3W3EKu?=
 =?us-ascii?Q?FjH4H9evvAXdfOiLplJyXm1TVetlwmSsDqLcYKrUMw69iAlpyoRKSNvPxELu?=
 =?us-ascii?Q?90Goq6mqYhM4Nz+Q4oVsfGvggPrnDRBoYhkvidPdouU0RXOXgsTpZxWLsdqs?=
 =?us-ascii?Q?q7KOillppcE+i9FVlLUT9MzOCPgNxS+MKaE4kdL0YPCmPUuaHJrfhGIgZbCr?=
 =?us-ascii?Q?rTiV5ke9efVakmNtmsjQdomb17BJS2sAEiLDaiDTgt1w7NwXTtZkb73zaqXv?=
 =?us-ascii?Q?zWX4Bq9CBkJH8UTUWCr6bJDOFij1SsgnIyQyuyHWdUnk1yFft5YdkPFkFMuI?=
 =?us-ascii?Q?UpNFWLIw+3leAtt5dRarPQMzH6+446gEn2hzaIQXMr7OSbsJ6FknL/0E0i94?=
 =?us-ascii?Q?mIgfqkx07lp66WzfJSfShU7DFALC++OtYAkN3WKWfM1TNNUMjaLQWS8vAtsX?=
 =?us-ascii?Q?CvpK/NAQ+JGEnUuKVL93bgrka5T3qZVyRgIqn/8Qehj7QelrVyCZYTy7GaQz?=
 =?us-ascii?Q?tvM/J8znxlzIU/mhCpU2kY8Wxl3hPqWeq82RbxJlZAFi0B0fPjyluMivF+Of?=
 =?us-ascii?Q?s1ujWcFpi/pjr8VSfKWROHnmxH/2M2vj167RkiKOWUA/vPnBFxA3zobopNoI?=
 =?us-ascii?Q?wOXnEfk6qxAdrdR3dhZ4H8n9i3vdiLRt4TIaDtzSEJo6Lf3Yw0q4R4Aiteky?=
 =?us-ascii?Q?KsK36zNcS3YmwU7j9rX3pgirIy/Z+JWXC8t2cyr4XV2K2qis3SpbnuwyfH7j?=
 =?us-ascii?Q?Gd/rbObNaUsihh2rmxpITHiDQZVR0XxW370PMzZ5M2h2ItNKxtzsXinDX6Tk?=
 =?us-ascii?Q?wupm/bxd7boFskQzDzdBKbxXMtI2BohnzT10t7D9GsPHPHTdiPNn5cwZ6MJD?=
 =?us-ascii?Q?2LjJGRfIwn433Jk0hr1u/i1sYzuZg8ohHh/Qj7D57uYHjOU7tUcxrmLhvOF+?=
 =?us-ascii?Q?RBmNDb41S2KAbc6BYdl4tuxn+naKE/uMTRqFXRWu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da8457b3-4ae3-4f41-7239-08dbe12db256
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 14:10:58.5963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1OMvmSr8yMzeyt+y4SmYcZTPXGsnRJC1JKIKbIZ/FtAFhLEw1jjGB5/pLfMKM5gI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4517

On Thu, Nov 09, 2023 at 07:22:09PM +0530, Vasant Hegde wrote:
> 
> 
> On 11/7/2023 6:39 PM, Jason Gunthorpe wrote:
> > On Tue, Nov 07, 2023 at 10:14:17AM +0530, Vasant Hegde wrote:
> > 
> >>> I can say that in SMMUv3 structuring it so that the attach op at the
> >>> top of the call chain knows what to do, and called a bunch of specific
> >>> helpers was reasonable. We know at the op level if we are going to do
> >>> a V1 or V2 invalidation because the OP itself already knows if it is
> >>> working on a V1/V2 iommu domain due to how it has to load the domain
> >>> into the DTE/GCR3.
> >>
> >> AMD IOMMU invalidation is based on domain and we have single command which takes
> >> PASID as well. Current code does have separate functions but that made code
> >> duplicate. So I try to consolidate all low level functions.
> > 
> > It is really not different from SMMU, invalidation commands for S1 or
> > S2 tables are constructed differently.
> 
> I don't understand ARM completely. So I don't think I understood the entire code.

It is really similar, of the three AMD and ARM are almost twins. VT-D
is completely different.

> Looking into https://github.com/jgunthorpe/linux/commits/smmuv3_newapi tree,
> 
> As I understand you have S1/S2. I guess that's something similar to V1 and V2
> page table. 

Yes

> arm_smmu_tlb_inv_range_domain() function basically checks for S1 or S2.

Yes, I haven't touched that yet.

The function is always called from an OP callback:

 iommu_flush_ops -> arm_smmu_tlb_inv_walk -> arm_smmu_tlb_inv_range_domain
 iotlb_sync -> arm_smmu_tlb_inv_range_domain

And in both cases we can arrange things so that there are S1 and S2
specific ops that already know exactly what they should be doing.

> domain_flush_pages_v1()
> {
> 	for (i = 0; i < amd_iommu_get_num_iommus(); ++i)
> 		iommu_queue_command()
> }
> 
> domain_flush_pages_v2()
> {
> 	list_for_each_entry(dev_data, &domain->dev_list, list)
> 		iommu_queue_command()
> }
> 
> /* Invalidation based on domain */
> amd_iommu_domain_flush_pages(pdom, addr, size)
> {
> 	pasid = INVALID;
> 	gn = false;
> 
> 	if (pdom_is_v2_pgtbl_mode(pdom)) {
> 		pasid = 0; gn = true
> 		domain_flush_pages_v2()
> 	} else
> 		domain_flush_pages_v1()
> 
> 	list_for_each_entry(dev_data, &domain->dev_list, list)
> 		__device_flush_iotlb(dev_data, addr, size, pasid, gn)
> 		
> }

Looks logical

> /* Invalidation based on device */
>
> amd_iommu_dev_flush_pasid_pages()
> {
> 	iommu_flush_tlb_range(iommu, domid, pasid, addr, size)
> 
> 	device_flush_iotlb_pasid(dev_data, pasid, addr, size)
> }

When does this happen? There were only two places in ARM land where we
needed a non-domain invalidation:
 - Flushing a PCI device ATC in an attach op callback due to a
   translation change or ATS enable/disable
 - Clearing an entire cache tag before returning it to the tag
   allocator

So I would not expect to see a range here, or to have the ATC in the
same function..

Jason
