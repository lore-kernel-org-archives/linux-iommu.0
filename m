Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D02414A87
	for <iommu@lists.linux.dev>; Tue, 24 Oct 2023 13:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PeC58eSH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WB/HMmJXim369Tk7KUL7GfR+lorz5ad8YmkWGW97v3yaKbHE1qWRyHYGtTmA2pCS6TYSQF1Y8Vyzipdypd5xWvrjId6eTHb1sxr49HUNSZ07mn0SdVdz0/6a+tn1km9bR0jo+1imYg9VPGriW2DV8ml5ShsiwxTOCnS1YE2XzzhhAtir1z8/3/tivJMdpL1ijDBDMDNpmWNgithxWbWhK0RbHwPPtVgkbryQswOcKYN5IeFqFdQh6RiGPihyzos3wXdzxE+IEsjERTzRi6CXqATkDCxTT0V+e+1x+Bodfkl2LGSyXoV3bgUWo9m9pBwB7W1W8bUGymevWI8/PD7JMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOY9NzgxvtUtu3DUwL3QHK0K8nf2K2abu8zSyB6pSSI=;
 b=MjNwTRJ/Jph4vbCBClaMyj8oIPclRsjpTx1aXzh8rlxtknjCrJ7It3Ga2dEqk4vwet78ST3vU2KfN9WiY/YtegVL+xif5vzW6PeSJjHA24HRYTFO9Dt0h+jOrhZ58g7kwtmmZ63RVw4sbhHZ2d3BCpdTTzLeW28W69mZfOoT106zsw879Yb/8RZSvp6T+KjavRk9lyuJm21m7J8ixywwaBIRRoub4AyxOdpjZ770PTMDg8795EwusKbAAhIKwy4yXNL02gJthHkon82uEXzhLGSkW3Wi8My2n3BOL38fi/LhT0cBde4MFU6mIKfn/k9ipZLBzi+WmKNRv3YTzKCT5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOY9NzgxvtUtu3DUwL3QHK0K8nf2K2abu8zSyB6pSSI=;
 b=PeC58eSHmjR79JMXjd01mJyfhz/bvt6MvDHqwgd2/uX16BrvfsTE1rNjBaJhmit6KO1KBsmnAxpZl0thXG6U1f1OW9m3Y6jgPKKBBiFpV7EOAh295tLuw0vj5Jiga/Yx9MromJ47l057ygpTLcS1BAj7pf/pQ+LoqoPuRhQAswqt1efXNMBu3X1Vx3sg6WPePWWuLyHhjgpc5n0V4WZIBPqq5J/kuK4uvt2srpxw5aZH5pjtZL1+Zhwn5unaZyTBy72fBTM/zvPKhRAcXzE/0MZmmGWblcAWst6zgcH9xRJpffXNff+p8UpBVCs25LOgMdB0IKzEjqwjDCT0RGXO4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA0PR12MB4462.namprd12.prod.outlook.com (2603:10b6:806:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Tue, 24 Oct
 2023 13:05:54 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Tue, 24 Oct 2023
 13:05:54 +0000
Date: Tue, 24 Oct 2023 10:05:53 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Shavit <mshavit@google.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH 18/27] iommu/arm-smmu-v3: Make SVA allocate a normal
 arm_smmu_domain
Message-ID: <20231024130553.GC911568@nvidia.com>
References: <0-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
 <18-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
 <CAKHBV24eDXh=P_h0515FKgcNi3L+pYaqeLK93kA3KC05G6vL+A@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKHBV24eDXh=P_h0515FKgcNi3L+pYaqeLK93kA3KC05G6vL+A@mail.gmail.com>
X-ClientProxiedBy: DM5PR07CA0064.namprd07.prod.outlook.com
 (2603:10b6:4:ad::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA0PR12MB4462:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ffc88e0-18f1-47f6-1cf2-08dbd491f4dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	c8rf77hrw7zfYsb+ejxGWeM+B6eqyE9E0NS6UKSZFQ+xwsofMGLwSslemGxtBoT6Kg7eFTlcW2dbvZcO9V3OHqJDOJMep9gAed7Rd+/aCOJAFxDcIarQWGAH7fEjK5Kjafe7+zg/nuz+S4k3YFmO9nppfFHofkfjbt+lJHqiMGBBMLuq1bbM/HMQyVY5vn/try2GlKRyox+M+FDdkm1sQo6mHecve0DkYLf0hb+uYdYDWsHUIUboAvuoIuTniISAIeQZfHpXhnGfkFDRyM1c+tZ2pQtua3d98wF9B8bwcaBqIG/7iV4g1gJb4YalTCr1ZRURDmYespQUlXOxf+12sXmQG6HvfrZMTZbDy7vumOMEU/B5nVHJeUUaMpBUb7b+kH3zxcjccV8Y83tCNFUEUHxGEjOVW6VMmLD757zGuJ1cDMeImscYP6EwVNjoq2j7aGFhjTTcuc0jyyCYWidW/J6Ctaj/Lh2Fk4Ydc0CwPgbPPXS7j3kdgNkaw3FC7+srMauO7YeW2n2/Bwicd4PDK6IeH7CNxOumQFDaYfechcpmbEMJQDuFq4XigFhSniTwFP5qf/D7w/xpAmSmpeIgySLxdfEU9tIbg28Qe094exeyyN8wykSWA1F3cE8dClXF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(396003)(346002)(366004)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(26005)(38100700002)(2906002)(4744005)(86362001)(36756003)(5660300002)(4326008)(41300700001)(8936002)(8676002)(33656002)(107886003)(6506007)(1076003)(478600001)(54906003)(2616005)(6916009)(66476007)(66946007)(66556008)(316002)(6486002)(6512007)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xlNKI/4E8ROoL+wsmEGNLs7Kn7lyc/zMlsh96BjPb4P4U6iKeqJ9Q9s48GD9?=
 =?us-ascii?Q?VDHls4r4SCHIBEXwQBC+Xn9AxLNIvkN2tBm3wWWWJy/1g9Fo464wL23gXAut?=
 =?us-ascii?Q?y7touQrcFIwRpsrAUsKL39UnCKgUMhHsc/LlMgjd/aaCwgkjjxGPVfKKHJkg?=
 =?us-ascii?Q?FBaIE7Nb/fiEd46UP8S/znhLkHfaSyQ5QjB9RoyGKLxBHmJrtVoHL8rBaDPp?=
 =?us-ascii?Q?L1gePGKuxBULM34kmhQs5AI8VEUaFMOtv6gvDZEYPv1wk4T8t0NBpi1vbquA?=
 =?us-ascii?Q?eHRlikrPy1yUr0T/3INjCne+clBsLJOuTLO4FjQEC2Motwoyzb4wjeLadc39?=
 =?us-ascii?Q?CP4TelvtFSY2o9Zfl2rw3w2roQvXyVipysRFWj37AdiObjcd7FJoDnwiStxQ?=
 =?us-ascii?Q?MYvVY5LL7zCWFSJCklnrQFWfgZLetoXSYKUMy//aL+K/2BMuqMg87poSKmTR?=
 =?us-ascii?Q?6L8JnzhmXCvVywupTThtFp4RHtdHQAd9IHNmOmFVBZysmIYPTvxX5QZYb/bf?=
 =?us-ascii?Q?8XSkYpiUhK+lIj+rVKNQv/66EfPD54H+q31jTcyS7AFfgPRHA9+fvSV6lG7n?=
 =?us-ascii?Q?3A6o5GVRH/onJkt5ZACjS2K2862ZvdBEGq7ZcTckGC1QA2rCEaSxhsU1r73+?=
 =?us-ascii?Q?dCa0/A7j4xaXY4yM0gKhKu3IDm2hCs15VCZFeYFpmcxJmbwlC4RNesxx0ul5?=
 =?us-ascii?Q?nViXUU5tiNejeqD4l3eQX5n3V0lj83sEdPSc60piqrUOlOsgfSthAaxpnKMj?=
 =?us-ascii?Q?1eWXRCJc0Z4booCUOvrxOFKYgmPRiUR/AcsecCRnb9K7QtcL4YQ7O/ynNb7B?=
 =?us-ascii?Q?Mb5wk/Xi7/Oy/QjLR8REX+YDdI82sR6qjQDAjovBZEZ/QUCQ3RNNNz9gnu3k?=
 =?us-ascii?Q?20FUkNXJDz7p87BhAoHSF6vRSAh+eSc4U1O8LgVOeuTsJ5RliQP6Bit2TDSa?=
 =?us-ascii?Q?SUPAldFMBTP9E7ANsdOhcet+NDVzWId4TuP2Ptt+szhKCe8B86HRvvUoSaUI?=
 =?us-ascii?Q?i3Ua7TJjyW+Jkdos9h6849Gofr0gt0n9tGkCW1LBuZ3U8r2cb2G2mYXVfPl4?=
 =?us-ascii?Q?BnjE59girNGw1h1yQfsl19fg+ICbPd4uOPzclXC6Nu09z6TOZbO+QGGG6pGD?=
 =?us-ascii?Q?UhaA5B5hqmSNM98cEVf5eaFsxp+lGSleNr2o3RAemcy2yBVsMUU635MmMQxj?=
 =?us-ascii?Q?MTeaio+2m7VFrtPKIC/t80JonzL67hyde9A5FQudXYIFglv5IlO8MAhOaYjm?=
 =?us-ascii?Q?h963s5Si8TaGAodc0AoOiYAOIz7/lDn2Pk4UcPDOxaUiX35DTw6l+YCzoDc9?=
 =?us-ascii?Q?mrZdTzfUmAA66GuP+gFNhDR3QIHFLSQjg5wBk7eUKkB5vugBVzEcuOhzRSW7?=
 =?us-ascii?Q?1vuqq72+F0HETGRlJW0u1gVAnchnMcHkJTqTgj/gAc1+hfmjgrTOQUlJTAk5?=
 =?us-ascii?Q?K+4A8fWAMI1Ftnr3z1jNBjfj0S6X1tG/xdElpwpruAiN6vFwrj7vvQbsrrMq?=
 =?us-ascii?Q?eG6Y5wbKNrWCF+pBqyO4j6WxxFVj+E1W2LHwUYEyV2ZL0rI1Qs2m7iZLICUV?=
 =?us-ascii?Q?tfxKuYS/GQe5ssjE3gvSUzIsJN6e6jf+L3luRqF/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ffc88e0-18f1-47f6-1cf2-08dbd491f4dc
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 13:05:54.7850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZrqKvsfbTioWz3pibjwLkljYC3KUvlAgGUR+cOZTBFeH3xx6RDOrGZUzS5graeg8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4462

On Tue, Oct 24, 2023 at 04:58:53PM +0800, Michael Shavit wrote:

> > -struct iommu_domain *arm_smmu_sva_domain_alloc(void)
> > +struct iommu_domain *arm_smmu_sva_domain_alloc(unsigned type)
> >  {
> > -       struct iommu_domain *domain;
> > +       struct arm_smmu_domain *smmu_domain;
> >
> > -       domain = kzalloc(sizeof(*domain), GFP_KERNEL);
> > -       if (!domain)
> > +       smmu_domain = arm_smmu_domain_alloc();
> > +       if (!smmu_domain)
> >                 return NULL;
> > -       domain->ops = &arm_smmu_sva_domain_ops;
> >
> 
> This will break SVA if cut here. Can probably leave the domain->ops
> there until Patch 20 replaces them.

Yes, done

Thanks,
Jason
