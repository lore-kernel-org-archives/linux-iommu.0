Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C93A7C
	for <iommu@lists.linux.dev>; Thu,  8 Sep 2022 00:12:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcDsdMd+j6CnmPWOSNkugEpAAG0jb1Ustd415xkYIns9xJpzOR3ZmMH8HJVxxaPXOZej10XxU/xdnzDGbVen8VzCWuPUoDU6MlfwwMCcqdF1R6iRuNhkd6+u9BmDR00Vd6SUsLFYDOUAvUUzqu9uC1muUgg4SQZgIYAfjYPkcit7cuzbjaOpKZiXbrlw9AUY1EA6NLtU+qd4UvJe85Wcpn+ZrJ0poQg6F6uCaunm/txx9joeAfnZbmaTVfrAz4hOqip7wJTt4nPhZI/d+ib+rneL7X2adtZ0QOQ34SD1YUIa1v2waJTHhwvW43FMuUynzHXgtc7JO3T77S6UPjRMNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y88GUm8btg067Wc6+DCoc42umLyG6esYgUrhuxula1g=;
 b=SQkAM9dMQZYa6+62HjdAnwQe0pun7WOFMzmstQFYK0u6zTtBAT9TTjIpw+Cl/ehkGT7u8YZeb4sBAeSCq3EiS9UrlWrhBPqvzrUvmS5xoVW+NsJpfh4U4QkpT1OG0Yv3rR0ujPXWWfM4zQOAtBuoqIONCaTlZeiOUDgtUXhZP2YB3o89W6XJzIbflwMI+cUgHt/ZnEzAtK4h7F4dQNw6ITxuPOE/wQyCJDP0VMXDaXgUKG9ER2tK5TK19z6Jg5bAlQjvnLzYhzFyzBJzDHX0VX/nOKf7fCoF5bcpr+TW8oWA/4bSWLpKsrR1+BEE5+m3z2ob87OcYIlWPMPRLnLEzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y88GUm8btg067Wc6+DCoc42umLyG6esYgUrhuxula1g=;
 b=UedUU0FtQ6kE5SfI3oB2StFikSFZgVXC8svoH8veojkjmyBu7DkdU/Kc3J+kjWI9kmfmu+FApqcVB3/iZR+swCb1eiYaYwgE9Xvu0ezWkA0jQejRRPwuZ3ybdGE3AaV0w77+uZ/S51KmLwN90S3Q8VNcO/v4QiJXT4WWgH3L8mXwOknqMcZgDnokmvxuJdGoiSosFzvdQE5Xevkup9lPweUh+oWVnsp19JLCsCl8ocED6t32PgDgWQBZp6orTK6wvXHje/ccIpqkLOBfEJG4q6QpdewRK/5kPukh9PbWpw2e3rS4nyIDEC2/F6xJPyOvY+d7TZi4N2h64XWU3VWYVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN9PR12MB5177.namprd12.prod.outlook.com (2603:10b6:408:11a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Thu, 8 Sep
 2022 00:12:20 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5588.018; Thu, 8 Sep 2022
 00:12:20 +0000
Date: Wed, 7 Sep 2022 21:12:18 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Vasant Hegde <vasant.hegde@amd.com>,
	iommu@lists.linux.dev, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v3 0/9] iommu/amd: Add Generic IO Page Table Framework
 Support for v2 Page Table
Message-ID: <YxkzYpSq/MyFRQu1@nvidia.com>
References: <20220825063939.8360-1-vasant.hegde@amd.com>
 <77d2ea43-9752-b5f3-78ef-8cdae944eee4@amd.com>
 <05f9784b-15b6-2a9b-2d9e-19e1430f74e2@arm.com>
 <YxintMDEmzSXJUl5@8bytes.org>
 <YxjMQpGYaHfsiuL+@nvidia.com>
 <252a02d3-3c62-f2ca-e2ed-f874a31b17e9@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <252a02d3-3c62-f2ca-e2ed-f874a31b17e9@arm.com>
X-ClientProxiedBy: BL0PR02CA0058.namprd02.prod.outlook.com
 (2603:10b6:207:3d::35) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e3dab36-4102-49dd-8419-08da912ecb9d
X-MS-TrafficTypeDiagnostic: BN9PR12MB5177:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LtlElSSBLH4DffjHM6oLUyPlYdDcBMlHZQ8iGtOFCpVPdmUWcDh/KYCyJ15ZGr0JpDkbogUClD/Og3XtUcJ0zosgm2UsH8/wlwIsNI02SxD6apnHfFTyeXijWNSm6yxtF3Ny8HZwU7OywBKXcy04V0/wZtonjCOnpOiJU7DyCy7BDlY4ETDmm9+rKFqVjSi7tJ+VWssVl8X111UtIM306fVkn+5LioIM9U1wtb1RC5Z103i8sjJ5ZJ6eVLVZ8xPmMGhba+E2FMeD2Xmz5V/ZPF7hguOCYixeQTkhlwpgOQ8AXIRkWsKDAb3jghvCq5b31eEuVysnmSVzgFy9uYrMYWfD4cc9KE+fP0QKAmnfSTCjM7c+MdXE4WZZ0GD/EIJko8kJ/196GYJxF84Siv8pll19GMqaq0b1Ay8Mam9xLJViRDQchbDq0LGkKr1J7kSIZj3X2gqcnjdXAKzNhP/k0fWL+IqMDQUPU3H1LPh7+fn8venAhyNGPqyPyLG6Cx7JoWP8KzYNDjKvEUiHkGsDAWN4HHAOa/ZGCpw8Cv3Gl+/MjGeJRYQp4uWI8FKvRG4pxr27FE6ReLvyIdLK+DemLxPD//zBH/JoykjEMxUUToAcEfMOPhYr/ODHv5qCV7YuZeDKwmRCHVRNXff7lKdOCY/BrTkeFSRTOMb2ee9lCE41OXUd745uVCxb9s+nvR+1yJgHhN3NQWrgw+KOLkh0s0BZW6WKwsG7XCtzPGiWWEAatnsCeTBv68a0ry7UeH3V
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(86362001)(186003)(2616005)(6486002)(478600001)(41300700001)(26005)(6512007)(6506007)(38100700002)(53546011)(83380400001)(316002)(5660300002)(66556008)(8676002)(66946007)(2906002)(8936002)(54906003)(4326008)(36756003)(6916009)(66476007)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ENVMxb4Bygg/JiPGEmYEWYEPGr1hvMOqJ/k3oJP47S8iGInNt/Jtgl74sL+U?=
 =?us-ascii?Q?xcRnr3XW2rMFfwmP8NFYEeqzXtDT6aABzz8tYvHqEvMaq65lQ32yeGcJCED0?=
 =?us-ascii?Q?oiC5OecbpmkJJ6fGsI0A7Z8MGGNJTFi+TIBkah0LQ5kQLM0YjoLRxEVXMwEd?=
 =?us-ascii?Q?2NuO8JQ55sVmv2HlVCFFIoaOPac16nqc59mbcfMAfVD4C2MIPWo+jVLKsZp2?=
 =?us-ascii?Q?mvdKbp/nhGCxM8nXf12Gzyox5NOTv+Pk6xDS+LoRgBn3w4z2havg8JkIiWWq?=
 =?us-ascii?Q?U2ddvuPYiIwMIwcHY37/zps25Z6Hdjrv3OnnqTNVCAtau1MyZNdPxBUDRpJO?=
 =?us-ascii?Q?M1SvQhnnFJws1hN7nLoIU0ZEl37IwxmeZ3mAk2yRb60ruH19jkZrlQ8lYZbg?=
 =?us-ascii?Q?odr4+PIkDiCFMtwkfPxOg7Zzpd5E+GB/HfA+IJo3PfrfpCidQWgXtxSg7A6n?=
 =?us-ascii?Q?6Yi/TRJUg4VdF0ZeXprEEY4cdTVUt7noBBQM0RsEzGIaG2R19u6XopF0xFF/?=
 =?us-ascii?Q?0W0ByqdSayi6YS9kLqB/LcmRd3mcUCizsJZFdCSAc8PqMahC96Gb+RehuL3z?=
 =?us-ascii?Q?Q8JpT2eDeEaHMnTqaK+1PTfsPeQL1Twh+GwZzrTofPF6HUPicnjcf63Zie3f?=
 =?us-ascii?Q?EhBI25EcY8IZ7J579fSM6OZtMxIZSkzTK/WOr7NX8fm3AupHQCDTGczqC3ML?=
 =?us-ascii?Q?xOiMPK3BL70r8bzhtXksybaP5ySIgDHx0XUIIryCyazXUFfG8h2452Kr09Rc?=
 =?us-ascii?Q?ct9i0Xl9+OAtE0Ep/60QsIGVv7R/Qqwret8Y9mrsn+3Cly6GS0Ut0S6Km8MP?=
 =?us-ascii?Q?tXRs1dPs4pqxzuZtwqdLT+6JosUZpd+4d2AucXC3EqVtoVcsj6wdNlrwm6AQ?=
 =?us-ascii?Q?YxRi9d5D5NWw1iLd1YbjEmahioxz/K97DPulqc7ECkyK5K3pQREOzsYlMU/V?=
 =?us-ascii?Q?9Pd4UDgJgITL3Ls+qHZnaaJ6oq2Y527VUr9EZv9FtWswiDIrJmmXfTAzBzUv?=
 =?us-ascii?Q?jalOf+amXt9xAZ822VYelxI0X6Cf50MyHptrkAE/AROWTW4dOl3XXY/5X2SU?=
 =?us-ascii?Q?gy/VTGvDN6nvFD1zRTKaZIzDf3bIffM2RL25B3AHFObk3pdo3251Zg5OYimM?=
 =?us-ascii?Q?lf7GYV6JRk4dze1lMsJwO7Tn8MUYgyobn9t95AgVIc/K/GEKP+Nuap+1E7lb?=
 =?us-ascii?Q?vuMqHiWlJI1Fkdp228GaMU9WWxCFODq38nqHH/6lc5dNByv8xkAvbDuuU8fL?=
 =?us-ascii?Q?mW7dozinmVUi4jEquS2flQzl/NnY2CCDeV6BcGYYOTlfiQsB6p0hsEIzbv3C?=
 =?us-ascii?Q?Jma/xLkB517gb13RTJJQedKJkGWGXyfZRrrT/8YI0fcj3jI+AbQAaOzLsHD2?=
 =?us-ascii?Q?pIXgQY4abKT482hvinacFsAfr+v3a6gyEUBLFzq8A/xCuo+viqCsoZSneg11?=
 =?us-ascii?Q?zd6HdLHfEy/SYLesAs1ThKNm9T6ic8gkslrxmUtQdlONUWnxAS+FtzzDCUJL?=
 =?us-ascii?Q?rfp64zmHvz7Znp4AiA6IBtnsFs190s+gcbTKrz5Z+A4xdXRC7PnEbOc9W0tW?=
 =?us-ascii?Q?HOnlLUTLxt1O6xq7TmcEBgv16NTPp/BUJry7e/d2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e3dab36-4102-49dd-8419-08da912ecb9d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 00:12:20.1497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nMYCaQSqfsT7xTjD+jmyVI0eraJ6nrHb68F1OIaSV+23f/2Ml8WqEV9kHDGVN4mv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5177

On Wed, Sep 07, 2022 at 07:16:32PM +0100, Robin Murphy wrote:
> On 2022-09-07 17:52, Jason Gunthorpe wrote:
> > On Wed, Sep 07, 2022 at 04:16:20PM +0200, Joerg Roedel wrote:
> > > On Tue, Sep 06, 2022 at 05:35:13PM +0100, Robin Murphy wrote:
> > > > Will this series also mean that the domain shenanigans in
> > > > amd_iommu_init_device() can be replaced by just making sure the GPU gets the
> > > > proper type of v2 default domain in the first place, so KFD can use its
> > > > PASIDs on top of that directly, and the audio driver problem goes away
> > > > naturally?
> > > 
> > > Yes, on IOMMUs supporting v2 page-tables and declaring a default PASID
> > > this hack can go away. Unfortunately a lot of AMD IOMMUs in the field do
> > > not, so the identity mapping hack needs to stay around.
> > 
> > Why can an identity map be attached to the RID in v2, but not a full
> > translation? It seems like a very strange design that entering PASID
> > mode completely breaks RID support..
> 
> FWIW we have the opposite problem on SMMUv3 - if we're using PASIDs then we
> can't bypass the RID, it *has* to map to a translation context (as PASID 0).
> I can only guess that nobody's yet tried the combination of SVA plus
> IOMMU_DEFAULT_PASSTHROUGH plus the device sending MSIs (and not on the dodgy
> machine where MSIs bypass the SMMU in hardware)... :/

This at least makes more sense to me, SW has the ability to apply a
translation and if the requirement is an identity translation it can
at least make one, at the cost of performance and memory..

So, looking at bit at the smmuv3 code, if arm_smmu_write_strtab_ent()
was called with stage == BYPASS on the RID then it sets a STE up for
bypass operation and there is no s1contextptr, but then
arm_smmu_write_ctx_desc() will come along later and try to access the
cdtab?

It seems like it needs to upgrade the STE to have an s1contextptr and
point substream 0 at an iopte setting up an identity mapping?

But doesn't this mean that the SVA is the thing that doesn't work if
the RID is set to identity?

Jason
