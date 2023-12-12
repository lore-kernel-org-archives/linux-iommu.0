Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FEA5812B
	for <iommu@lists.linux.dev>; Tue, 12 Dec 2023 14:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CLqMHP59"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7Hg1sR4rwvphZfIMkrMuf1Sfjr1z3SZUAsxxQ5laf2peqz8q85AVWauPtlKQULHLnol9OEBegGX1Xjh0Y4wjPwf3xRZ9myxnWxuGcEyb94xKvExxtxHiGj73eSmOXNydVYKy24OfQiCC+IgCbAGHsacCT4gewtQ1mXIvjvFrynLUI3Y/pgtN0R53JVaaTxfikc6oa00y0UCVMo0+QVQK741Kh2KFnOu/Fe9On8keR5fck0ZGMxOOQDgkCkQ058C1F2pU9GgGa7nbWcr8ysdi1Y8Gi7QYfI6ekr6uDi9uujlKwgFCC+sBKSp6UPytRRKhLfd9M1lWNvaWkC0MGeVhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vy81q1QZhUI+6PsIHUup+toXNglXgMjvjI8Xs/IlVa4=;
 b=Vxh0tHMlK8gJAhKKhVy9oaO1CXsOjgHDmocXzUD48VnFYEh4vgVZm4TCHxEYdXIFX/6dn9RFnYw9NtkSEi8XydS3G85Cgr1DfxFUTAr8N/VfkAph2oIr1m9u978zF49iigOwRAXJjCWUR5/uouO86wkG5QcXBQkvO2/myIQv+yBEdW6uIGRzuVVG2e7ygruvv+FJCGykmsSPqIspptqq2vP/peC66VelO5dl+crT4sxsZ/9Cb6yWUbhR8hPUQRaCZVVNaXgJOMIcpqUztR1X36yVIbGHhV1Otqot/t17l9jkoMYz5lr/ff8QACm3aNP6S022Z1LdF/zuafv+sFH83Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vy81q1QZhUI+6PsIHUup+toXNglXgMjvjI8Xs/IlVa4=;
 b=CLqMHP59ZnEOebdFyhVu3EjGZgBrD2gdXlq3I0LnH0Ukl36dmKpjKag3xhV7JWVH9eRshky+tTVs9PJz9LgLSgGqkl9iUfZP8VWyahUb1ZqGJpAURazu9eUGaRVvqLj1lO4W2Ms4l7HmUSG79O3XXuL4gofwR3kA3Rj7i4vLq6FIaUOoZ+/6R/BCY8EMX5Hti2DSyNbpZYblU+mmUBH72I3gYBD4b3GtnF+b8K6Edb5Okx7STFhgDRFEAw4zSr9rVzoGvQyazTeTdPdOhqk096fje2CT0dxWVca1H2YOaS4INQM0pUuJ9JFSR1BiU2O8mF/9KJW/l+/+Cn7FMa4r/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW6PR12MB8834.namprd12.prod.outlook.com (2603:10b6:303:23c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Tue, 12 Dec
 2023 14:15:17 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7091.022; Tue, 12 Dec 2023
 14:15:17 +0000
Date: Tue, 12 Dec 2023 10:15:16 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v2 2/5] iommu/arm-smmu: Convert to a global static
 identity domain
Message-ID: <20231212141516.GE3014157@nvidia.com>
References: <0-v2-c86cc8c2230e+160bb-smmu_newapi_jgg@nvidia.com>
 <2-v2-c86cc8c2230e+160bb-smmu_newapi_jgg@nvidia.com>
 <20231212132708.GB29569@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212132708.GB29569@willie-the-truck>
X-ClientProxiedBy: MN2PR02CA0032.namprd02.prod.outlook.com
 (2603:10b6:208:fc::45) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW6PR12MB8834:EE_
X-MS-Office365-Filtering-Correlation-Id: e357636c-be57-4f80-7188-08dbfb1cc3fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+KFKTTcCmOn21Ly3QCc0O8ctJ0BfoEUNG+3wTm6eD06g8qU1gYrek38445KRiixA+SE+p7tDvWYKf8ZG+/KOEUTZo555uKqyy2NrDETxl3x/MdNe+/lcZN5MIWBaU4Eij8DtzGDQsybfMBz2GlCGImToQCdzHR0+c8YF5PfslFfz0cyS4wvdojmF/cq6zAmBujj99fZ1NPCrZfzO+lclRDgLa7T2qxVTXpS+aFSxb6XEahxLtsgbcQ6ZT0+GGhuAJ06f4aL5e5XW2LVqHUuVo25pYMpFChFy9qxbCauNufpsZFmK/OVWqNI9WPoxiohgG4imwtfMVenkpr/junnNEC+asHovgKoGfHP7IDc2dB7VOs01Z0qAcGtn+VftcecOUECZbxR1h+Y+CcaN9VMRWJJPisQVSmGqiJOGz1iIeS1vZTo6hDj5TNLPZAMTPBXC8AZ1ki1NGClvr7QEcdBed3fc8UMxYgw7UbS6fnADqL/ncGDeVB9gDOkgM8K53awSUuIrQNwp1XXV+ZBsEKCKbsLCIM3HAP+6tzBwHUjm4tZ4E1tUCYZ1Wns7rNDQfUz6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(376002)(346002)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(26005)(66946007)(66476007)(66556008)(86362001)(33656002)(36756003)(38100700002)(83380400001)(1076003)(107886003)(2616005)(6512007)(6506007)(6486002)(2906002)(54906003)(6916009)(316002)(478600001)(4326008)(5660300002)(8676002)(8936002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fCkZs0bDnFx6Tg/7OvEyFN2nIme3kWXYpZyHBQEzBZW2WG1m3CX15d56lY+w?=
 =?us-ascii?Q?y12uvAAUFqg9gk6AlKmEegMGFhGMenvDvvYMzoqkLS/6NvttGB8EiPmkHRnG?=
 =?us-ascii?Q?vW4kMU9O5XS7HJ84Hd+sy9ouKDa78DwSyxwW0QkZZJu5GsSxugzfbNym2JGk?=
 =?us-ascii?Q?piRkS3Mo9vW44uV5FAUm6U6lut+jmwttfk6ofabbpXOWCshXUTqRwvXdxHSH?=
 =?us-ascii?Q?ar5DseWVF0OcRIrVrViLdLIxV3sG6aVZQ6JsbRKKt+kp+xUyWb0rA9GTfzgb?=
 =?us-ascii?Q?wKI4Fm73q3vcIRTYdY6BSJBXBfsOOL18Q07Cbj9MURByYsknQm/GSUz4Pnu5?=
 =?us-ascii?Q?RjtiihxRQtbQhwVxpJ1QPV3BP5NEF+Prwdt1AN0zog1jUuL02ZrADFekrwsX?=
 =?us-ascii?Q?NbjvdI29bSm6C8Yl1ZBspfWw0WD95Y7D6QWS5HsTvbq6en/w0IUp7TpazbBw?=
 =?us-ascii?Q?53VAH+IuxYoAheIzbg3SniMzj91Ud2AJe53HFgxhTY+w5N3QecyAFbug0SYZ?=
 =?us-ascii?Q?ETK6emoILzdp/4a3LfTNd1Ni0QSsq6kLqJFGjAIDEHLJK5g2PEXzKsCL8g4p?=
 =?us-ascii?Q?85ofCTQUoMzWxxva3/op8KRZocJvIT5DGgap91VhA/vmdJJH2/whPftqtD72?=
 =?us-ascii?Q?WOyVMkf7Rf++GgrJGvkLqbQ44bIQ7QIfH+pRQYMjHLcUSoyTA1aCn2WLox27?=
 =?us-ascii?Q?bKhPgcdqNstJBzVBZ6Eb1+ubYk9anet+C0+hRbOro9LME6CsTghAMwloH/sV?=
 =?us-ascii?Q?1Qu9gzwxGj7ohVQgrO5saHB3pyOh59GXylXry8YAan9NNNW30NXuylh9KRCr?=
 =?us-ascii?Q?1u/XxE9wQoFSexqRvuBvcOfz95EAP0ga88ZOXnmxS1RqMj3pUNlgnRuwMRUz?=
 =?us-ascii?Q?NNForCfgxpOCNVGP8LgEPz+S+0BmjUcOInhuMa/DtT0Ag4abFupkS0qg5FXe?=
 =?us-ascii?Q?sAbvauViaYS4esYIu3BSV0AK159OYh6uXOk3wazHb6ZjIYYOSVeXGeG71ClO?=
 =?us-ascii?Q?D+XclGE7quW8UGOzuRH09nWBUhZkukAka/TWLNu8DOWxu4o1P1CrlK1iMAB3?=
 =?us-ascii?Q?8z3CQhHn3YeRFS88GJe4mvQC5flT9Rd5qwTq/RzwrwSniMKC0iwFg/dPaPy8?=
 =?us-ascii?Q?ndosb4QgW7wF2YQVmgY8xKerO3Dr3tre4Gu6dmtIYM1URJv9lzNQs7wyr+PC?=
 =?us-ascii?Q?2MloowOgnv7s+MsUSAY+1AH8FGfoptk8NBD+XmWWrp5IuA4LsuQk9gN6RUtP?=
 =?us-ascii?Q?sUWF/STeElsjgQzyfhKrIw+8olofwv5rGPsyXHMl+OwXXGOlOo2ek1desxM6?=
 =?us-ascii?Q?YY8ktQA5c9zuWLOIGG3YshkM9BxRq03pIgKKRNucsTI4QFQL88QuWBeWXfWT?=
 =?us-ascii?Q?3HRjRjKt/iQ7HKiCx/OiY9nZgvZ0aXfJL2rehj0IK5tIKhuCsPMNxYIY+dkY?=
 =?us-ascii?Q?EFgWB3iFxT83ceWCgKu1rROTlp2qaOf80Shm/Et/UXqNjoVwNUL85Qf31DJb?=
 =?us-ascii?Q?53rMJiVsIu11zxmCHg9Tt/G0wtE8R3CDowlTxZQBdiwPeDZ6Pa4537/ibS7H?=
 =?us-ascii?Q?i6MaUGCgkBG5jBuwZTudq3WyjtMdauyfiWcOqggV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e357636c-be57-4f80-7188-08dbfb1cc3fa
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 14:15:17.0013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PLezrTPnFaAN75TMqUycI5s+1gqhnfNA43yNTxpCgBETZmRVsglvQam3Bav7JIVN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8834

On Tue, Dec 12, 2023 at 01:27:08PM +0000, Will Deacon wrote:
> > +static int arm_smmu_attach_dev_identity(struct iommu_domain *domain,
> > +					struct device *dev)
> > +{
> > +	struct arm_smmu_master_cfg *cfg = dev_iommu_priv_get(dev);
> > +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> > +	struct arm_smmu_device *smmu;
> > +	int ret;
> > +
> > +	if (!cfg)
> > +		return -ENODEV;
> > +	smmu = cfg->smmu;
> > +
> > +	ret = arm_smmu_rpm_get(smmu);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	arm_smmu_master_install_s2crs(cfg, S2CR_TYPE_BYPASS, 0, fwspec);
> > +
> > +	pm_runtime_set_autosuspend_delay(smmu->dev, 20);
> > +	pm_runtime_use_autosuspend(smmu->dev);
> 
> This is cargo-culted from arm_smmu_attach_dev() with the comments dropped
> and it's not clear at all to me that the autosuspend delay makes any sense
> for the identity domain.

Indeed, however it was how it worked before this split up.

> So I think it would be better to either drop the call to
> pm_runtime_set_autosuspend_delay() 

I looked through it more carefully and this does seem like the right
thing, so I will drop them.

Thanks,
Jason
