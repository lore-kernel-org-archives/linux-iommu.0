Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC0E1DDFC
	for <iommu@lists.linux.dev>; Wed, 18 Oct 2023 12:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B17vUXqS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jh/tSO7Omjx0+ep8DmGuoOIlTU+HD+wctrXQ4aNbqkAG0dnkagpD0dB/8Yjv0mJDyCPgBLdJPHCFnyX1PfXybIZqvWolNswGH/cNvVViuIkRQPBjCz2GZ1yH6RKbnvJuZMCWOcEXgL7Ga6dcb5DygBNerju7Fbve6L1jtTs9ViUV5EQ4jdocjcZtySdqgtQNNpik29okCglRTd1J0KhoBAZkQT+7vKED3Fh1v3MuU+teAirn7xzEsLe1UK9Gsu4/SG44rDlVcBTCn8L28w3sm4VZzYv8YbR77B7LgOi5EtuRf64jJDh2oWY6jnyyCoBKBtWNmF9aBJEbTxJy0mkr8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGEEwNgMGqhIkyUbLcnhgPIhlQul94Rwn7bh/Hucvbc=;
 b=M/jC7Aq5WIcOD497k3N2ujB9uhHne9aS8lmFDcFJns/G08twPG3al0CpIskoroMQVgpmUmoQTW5ABShG4IGQOun0rc9Gs+kzWmkY3v0kOUYCdO4r20aTeMPDCvFhg3ZM7JwG26LIJGlKIA5abNNsZmS18wJGD6TYRwe0gcMYWNZUUACXoRdeD+lFnk4j0Ru7mrizyf+aWngrHDNOdaHBKHf+iSS/ddV1pKSKGu5Rc6KPaHyl4uZVh//EuwL2ZSaw+LEWVVBA6yxS6gRubRyLYeV5T9tsbEuZLzYVKBp0Y3KoKFprRHJpuHBrRropvspGY1iRUUs65j7YZUt4MJZXrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGEEwNgMGqhIkyUbLcnhgPIhlQul94Rwn7bh/Hucvbc=;
 b=B17vUXqS+SW7MyhgozdvnJzDVwgo06C9hy3dS+ccP0NyuW0ECKz/FqvNRa81abjqxa8UGR0MNg8EWBDrF8YfahWSJTacQiPsMQlOmNyMgx4oty9XGT2tIzE23z4gFiM0nLmPsOnpTydEDeMDiQyZdSrjBuTO2RzJkgiD7jm1bLUj87BmlY6p55zt2b/QEH1aTxu+S17FR4fsaeHKDsDyNi2CAE0mQCUk3z/NTF0xt2W73WrzW0dBllDAByptgtfm1dQZT0IAM5rB6kNFzkSEfg+7l+6ZBOfrLLM2NaMfif24N4/tZ0Mwj5KM1kiSAfqZ3H16Uy146hZFjRgyl3w8tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB4886.namprd12.prod.outlook.com (2603:10b6:a03:1c5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 18 Oct
 2023 12:26:25 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 12:26:25 +0000
Date: Wed, 18 Oct 2023 09:26:23 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Shavit <mshavit@google.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH 15/19] iommu/arm-smmu-v3: Add a global static IDENTITY
 domain
Message-ID: <20231018122623.GT3952@nvidia.com>
References: <0-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
 <15-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
 <CAKHBV27_4fg0msiQz+55iuOj8SPsnK+JHNjq2UnN0mF0hFuqjg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKHBV27_4fg0msiQz+55iuOj8SPsnK+JHNjq2UnN0mF0hFuqjg@mail.gmail.com>
X-ClientProxiedBy: SJ0PR05CA0143.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB4886:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cab0a2a-9b88-47ff-ec95-08dbcfd57256
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uSvbvS0L+KfSL32HboMJdYQ8mnqjMNLl697JuBsd6Fv6arHXlM/L2Xd06o7mr+MudGY4TUEPZutJghheQ3lVBqMDa7XckRsrKr4IVLwZHwujlkCLUM3C3tKLjah3M2wcQU5CAJDM2pZ/oY5ApWRuDSHHDJ3O4wY+mw5U82s6kSwU1CqjG7UTSC1nkQyN5t+77JnHgRkGsQY2Polr26VzCU9Mk6dyitbWGCce1/uW+l8vWfSJ77+/hf7XrwT8IDJyG1MCovo5q72AmZnWpI/8ZpIgHCOXka4oIn2ZoQqct55w0b49dHAKwaRZ4aE1M0toWYDlqrasCAB7dCnISGl2YCGXEFkdQ0Pbsc8ovoC7dkpmQWldrjU5AI4XH6GJtbKbwRoAVERkoE+qqWH6nu+9aoFg/xXK9cqaOLYXDB9WhLM0kQM9IsEa8DZTYrGbCdPU5L5ktPfeZ15XbGWZIAVy1Hz+bEao+RZmY0vyOHcRTpETwLojGuNLpVGtr/vSw4WzpUDn8zeyDYjb/tVW3TEF63tqXfWsoACVDXU57LQaro9IHhTXuUrxzOHTd2ws3QP2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(86362001)(41300700001)(53546011)(5660300002)(33656002)(8936002)(4326008)(8676002)(38100700002)(36756003)(2906002)(83380400001)(54906003)(66946007)(316002)(66476007)(66556008)(26005)(6916009)(107886003)(2616005)(1076003)(6512007)(6506007)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEM4aHFXNGxBUThuMmpNWFNRNjZkMThaeVI4OWZvQnBid0ZzUUJQMm05NTlC?=
 =?utf-8?B?TkJtQXJXRHFlMWNZVVJodk83cDVTNTRCOUZsYkx3dzRLS2dQSmQ2YTdwSThx?=
 =?utf-8?B?V1ZkakFkY1dVY0plelg2MElGaXZFNGhHZ3pvL3RESXZ4eCtmWldvZTIzVGdE?=
 =?utf-8?B?TkpjNWNXczRWN1o2WXhhU0lTMVlFN0pha0JoNVB3NjhwRHZRNS8ySzFuMkl2?=
 =?utf-8?B?NE1jYllYY1dUcUw5NTJtUTU1cVFhU0NhYjZETjlVWEJ0SXMrdjl5K2JOUFc0?=
 =?utf-8?B?S0xjVXpsajQ5L2pSdXNaRTYxeVVTUlhueXdZaThyUndTQnlVUk9GRzFHbzNE?=
 =?utf-8?B?UDJadXE1cVJkYUF0aVppSnJFb3pIMzJTd3Q2TGxac0NDRDhiUVR4aW43KzNL?=
 =?utf-8?B?a3N1YVU1MCtFeDh3TnhzVWdVSzlzdjFsZGxBQmg0RWpMRXdYbWFYQmhxTXVP?=
 =?utf-8?B?ZTZkck1sY2tldWZNQnVJdHNlc1FVZGJDRjhSZENHWnZGZ0poZTNiem5aUkZn?=
 =?utf-8?B?N0dkMXlTaEV2N1ZBdzlDa09sSExmdDZySVFBMkdyTXhhR3N4d0ZPUlRDOEhD?=
 =?utf-8?B?MjZlaXhnU3g3eUpLd2lFMkxlTG42dkI2VTNKN3pxVzRHYlJUenhVRDVNbm54?=
 =?utf-8?B?SFNsaFQwdTVVRUoyMGVzb29GUGN1Q1l5NjAweE9DOExsbDN3S04wYTFZalJN?=
 =?utf-8?B?My81cUhnZUxKSWdSbVVzMDJUK0EyQnVUQUpWOFpkOUdnREZsYll0dDRYbnJ3?=
 =?utf-8?B?RzlVSVFJSk1GTmlDU1hWRlUrYlYwTVRBSnB2OURQS2ZHK0E1NHVWOXgxemd3?=
 =?utf-8?B?WWJqRnM2dVJBcVVmL09UV0grSWNLZUZ1QlVoOVZ2VTE5dVVNQ21vZjZuMU9v?=
 =?utf-8?B?Q0hmK0t3V0dSRmFBVHhrc3VRb0UwZzliVmdTZ0szTUgyQjNXK2Z3SkF1V1dk?=
 =?utf-8?B?S25CVmsraEswS05FNDNiL3FMbDRYa0FCaDZQb3ZQQjUzWVJUdGRtcXBDbDNJ?=
 =?utf-8?B?M3hBeVVIUVBkWnI5Kzl4K2hTMmQ5Z2pZQ0lYZnFCNmxoa3o5cHd0cnVqUlR4?=
 =?utf-8?B?T0VqcFZyYmFSenIxYVMramxzU1BjUTE0RWh3WDVuSTl4MitNc29uTWZBaU1n?=
 =?utf-8?B?cUxlNVF0SHllQUJNU3FWZ21QRmthcC8zRVd5U1pMeFlkV3FoVVRHbFVwTXhk?=
 =?utf-8?B?ZmE1a3NqRXd1K3RQUTUybmtlMmx0N2lLZ0pYNUVsOXRIYS9KTHkvVVBLZFBi?=
 =?utf-8?B?QTRueEsweXV6UUVESUVGVUJjaENyUld0OVFzdllqZUxZMXhkdWhIWWJNd3Zo?=
 =?utf-8?B?SlZEaWM4Tno1YmNIc3dEZXlSNWFpUE9OSVZMTlM1SXJpbExnNEE0RThIeDlH?=
 =?utf-8?B?ZFlhT1dkYXd3blVJWVFMc0w4NTd2b0o4QmFObUVpSmRzRmhnbWxEN2ZkblVH?=
 =?utf-8?B?cGFBaE1DR3c1WGExQWh3S1ZoVHd5WTgxT2psbUhzOGJ6c2pNTkRNRUx1N3kz?=
 =?utf-8?B?RmtRVU8xbGtUSTVUa3RFdDNZYTJCV1NQcXN2cHMzTUticzJlUTB3T3dkVmxj?=
 =?utf-8?B?dnV2Y01tSXlHUFhnTTFtSEkvTjNmb3RsTWplYVpqWlFtMmkveUxTRkFCVHdu?=
 =?utf-8?B?T2pZekt4SHhaZWVoT2JWZVM3d0dXMll4U3ZXSlVzM2NSWEMxQVNzYVk2N0tC?=
 =?utf-8?B?bTYySTg3TFY5QVdUR2M0SGM5dXNLNjRKclNNMnlqQzVxdmdEREJLQmVJU1Nm?=
 =?utf-8?B?UHhwR0plc3RKOS93Ni9lWVFSUVRBYTVFckgzcFJqeE1IYUt3OUZzSTJHNk81?=
 =?utf-8?B?WkhQMEtVTTNTOHVSSXQzKzh0dEloVmtMVE5ZL2pOY25ibnJVWnFVZmcvcmk1?=
 =?utf-8?B?czYzM3RKbG9EWEVYSG9WVndjWVowSDExMlRUMzk4RGlJMUxwUFdaNTNkSThO?=
 =?utf-8?B?UmoyK05XayszR1FkRlVFOCtsY2VzMFVhTFVxeVFpeENOUk5Gb2tlamQ1RGc4?=
 =?utf-8?B?OTRpbkhidldGVG92dVk2elBsVmVKa25YMVp1WlFBMWVPUWNUVFA5Q1FEOXN6?=
 =?utf-8?B?K3pBNjQ4Q1l5enY3bnovbGVIVS9lS0RsY1UzU1dlVmVSR0s1MXJLYzRVc01R?=
 =?utf-8?Q?omNXS7Saliqz6Y2zDEthtTAaX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cab0a2a-9b88-47ff-ec95-08dbcfd57256
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 12:26:25.7403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aip3jfDfOtW2EYG+NGPiSFhry6pk5RmzcXNgmwxr5MsnN3gKKgw7HvOc3GmEqrPz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4886

On Wed, Oct 18, 2023 at 07:06:55PM +0800, Michael Shavit wrote:
> On Wed, Oct 11, 2023 at 8:33 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > Move to the new static global for identity domains. Move all the logic out
> > of arm_smmu_attach_dev into an identity only function.
> >
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 82 +++++++++++++++------
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 -
> >  2 files changed, 58 insertions(+), 25 deletions(-)
> >
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index 26d3200c127450..1e03bdedfabad1 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -2149,8 +2149,7 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
> >                 return arm_smmu_sva_domain_alloc();
> >
> >         if (type != IOMMU_DOMAIN_UNMANAGED &&
> > -           type != IOMMU_DOMAIN_DMA &&
> > -           type != IOMMU_DOMAIN_IDENTITY)
> > +           type != IOMMU_DOMAIN_DMA)
> >                 return NULL;
> >
> >         /*
> > @@ -2258,11 +2257,6 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
> >         struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> >         struct arm_smmu_device *smmu = smmu_domain->smmu;
> >
> > -       if (domain->type == IOMMU_DOMAIN_IDENTITY) {
> > -               smmu_domain->stage = ARM_SMMU_DOMAIN_BYPASS;
> > -               return 0;
> > -       }
> > -
> >         /* Restrict the stage to what we can actually support */
> >         if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S1))
> >                 smmu_domain->stage = ARM_SMMU_DOMAIN_S2;
> > @@ -2459,7 +2453,7 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
> >         struct arm_smmu_domain *smmu_domain;
> >         unsigned long flags;
> >
> > -       if (!domain)
> > +       if (!domain || !(domain->type & __IOMMU_DOMAIN_PAGING))
> >                 return;
> 
> Confused me why we were checking against __IOMMU_DOMAIN_PAGING instead
>  of IOMMU_DOMAIN_UNMANAGED/DMA to match domain_alloc, but ok it's
> clarified by the final patch in the series.

Long term I am trying to remove DMA/UNMANAGED from the drivers (we are
actually getting quite close!). A domain created by
domain_alloc_paging (later patch) should be tested like this.

Jason
