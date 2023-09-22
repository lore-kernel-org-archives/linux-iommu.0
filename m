Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2078.outbound.protection.outlook.com [40.107.95.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D002168AA
	for <iommu@lists.linux.dev>; Fri, 22 Sep 2023 12:18:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKW5CyUE8MaPMU9ERC/DOpoz1BZy1+0fOhJxvhXIMANfm9ngKtylut5GykVdar/qOaXH/Is8lKJ5RN7vsUuPShPLi+BzX1VcBo5dZPIUt/vgAxhFEWDCx6nYG8iMChVWZuVspOQHuJHPOxU9VJJecDba2n2GKEzmGaQrWP4c6LkuCph8FvrzqT0CPUWb0M1k6kGo20xyhQzKiwc3bz60J+G1Vv0glrDI/JIbNEt4hG2QaVxshDv9BPwcKoDM32lqJN45IAz1jkRF/JYXz8nUmY9Ic5LIQqxyd73DyVMhxAwpIpaPa4jrbcnP9RFQsGwrGvuuZvtiNsssebbQmOHHSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hxlad77XhkOHZrjbRd4Xe+LTocwmJNe9XLeuwjO30Q=;
 b=nSwV6gkMSfwKcvdzwPh9r+3WjoysiDijGzqb1nSkJnKn6tKXC3mnM8ROQbbYDpINiCZ+Ctlnr4CBLN5g/M+aPSnst6lG0EHcdgaADhuIp5BWMNkaQrdXMPwhG5bPhsTAqnUInZu2kmpf78ig6Inc+yI8bBN8NaVipxRpU5jEtKfxy4ezTb9bmhG5inxkCD2gX+eNSP6b1uiL1KJzILrU4IMx02idbpBoQKk0TQWZJOi8TfFRX1tUmqv00t2eANmGI0PkQIdWsqrq1dP+HZqr2S55c8++fTuDs5e/o2CLr1vbbt24p3cPCYLKG5vCQ7Qa1SgFA3YHsQknLWAQbZBPuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hxlad77XhkOHZrjbRd4Xe+LTocwmJNe9XLeuwjO30Q=;
 b=nBSfMd9+nUGaT/r8H3j70Zn9eUh2i3VAAAYm4B+gSUnleFo6dU1zbF1YCgQ2vWoM2/v9zUEiwVgwwh8bhD/PKbMqOhxuQ4duVIFJmH/MkBz9nWNcUrPhm4BtPUEpoJDSyB2D45LCvaytVT5xwT2QA/iiF0KI/73jrF429sA77Et5QlY+GgFZgnwh4VgDOSmZEUXN4eLC4nVMAdnq8ZbV1krnI/PEpuN+3rxe64ZbjfH1Dj39sfPvejlMmLPV2GEdUR3WkOXStsuAL9IW79pYsr9lWuuRf3EKol5eN3drOTOO0HW7bE+LQHf6okWotcRiS6IUSrrlg+jmCCb+5TfytQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB9011.namprd12.prod.outlook.com (2603:10b6:208:488::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 22 Sep
 2023 12:18:14 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%6]) with mapi id 15.20.6792.026; Fri, 22 Sep 2023
 12:18:14 +0000
Date: Fri, 22 Sep 2023 09:18:12 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
	"Hegde, Vasant" <Vasant.Hegde@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
	"Huang2, Wei" <Wei.Huang2@amd.com>,
	"jsnitsel@redhat.com" <jsnitsel@redhat.com>,
	"Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH v3 1/5] iommu/amd: Remove iommu_v2 module
Message-ID: <20230922121812.GM13733@nvidia.com>
References: <20230921093140.6162-1-vasant.hegde@amd.com>
 <20230921093140.6162-2-vasant.hegde@amd.com>
 <BL1PR12MB5144C5ADC106D450EA73C511F7F8A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <20230921141415.GN13733@nvidia.com>
 <BL1PR12MB51449627A11B2BDA55B97C8CF7F8A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <20230921163154.GO13733@nvidia.com>
 <19c7c139-b002-384f-5766-b87a8013029e@linux.intel.com>
 <20230922115927.GI13733@nvidia.com>
 <a4770035-9f1a-3bff-2ff2-d6b9c81e2c0b@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4770035-9f1a-3bff-2ff2-d6b9c81e2c0b@linux.intel.com>
X-ClientProxiedBy: BL1P221CA0028.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB9011:EE_
X-MS-Office365-Filtering-Correlation-Id: 85301fc7-8543-4ccf-5504-08dbbb65fec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nQgRX4N8DGRqE/+XyLrXif2FCqmA8SHMRCZi+bztZIjmX1KKWwHB9jyQXhaM6qkvbWuw2F3rugBGd57wtYfdjsqnd9AYa/j6iI8V+sWXRZ7OShdnKV7vdgQ6PP0tWNWyvKtiRpy8AHaEZ1jVtWMFUKYQnxjchAmePV9sGxH1pUwlcYznirrZFODA2rQ6NKdPsVZBNEmqxSkQaHUCcQqUDrbMWvPXNzWBg6A6wPyCuXfiUt/nFejxkKgv6dufO8EX9C+A0SERwMoFnDH9elpqOGQWM/3zyc4zLAzEADmjQtNmSqXD89J+tQfgUgJZ/SOARKiVdqDSs6P0ali4CyBtkM1Ulc61ONvCo3VQBxhL/HGIH07YlzPkRCIiOTYvqMP2jz//I97KrDyNz/aOIQH3w6wSUu605fJaGFGoXDc0tDbe6T5gVO6lCxrpEFDLiD7U6W6rmyRXjKRoPD1Ylv7bMcrWtnLgoNP1YE05Uja1RkcAa079FVTmEunvlcyVGdZ1Ce1PLy9j8sCehXXy5kkb7yEUFxjpF4Z2r1yfZDpqvnoCuUYPeugbn8FI/Zb11yF/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(376002)(136003)(39860400002)(186009)(1800799009)(451199024)(6486002)(33656002)(6916009)(6506007)(66946007)(66476007)(54906003)(66556008)(478600001)(6512007)(41300700001)(8936002)(4326008)(8676002)(26005)(36756003)(2616005)(5660300002)(1076003)(86362001)(4744005)(316002)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?asKFPKM+e0TV8yNkUskekMv/lg+aXZf6QGtH2yNBb3oAB7k6C2GajQeBIYsX?=
 =?us-ascii?Q?jo3Q5ETOieBER+kjMI3iov/XR7o88itl7y6cLiED8MpmyELcS9oAKtzPokS+?=
 =?us-ascii?Q?teoJZmBBS+/bWt3Fq18sMblqKjaQVSZq4q/WHPaqweDBtYLd0abTK9tqf1+O?=
 =?us-ascii?Q?/mZ5diCmS6MVaCcoSofW3aKtR9Fd/E6opOn4kruNXIjVip1hQ0Hduk4X/yPw?=
 =?us-ascii?Q?m1Na5vDaBPwu5kOoRKROyH3DAfdFIhissRnAjblwo/jwDVkBgP9yJKt/pCQ9?=
 =?us-ascii?Q?QYmZHsrquDEboKomjiVc2UfFC7GrhNV/KTQ3zyyTrk40YopDusofKzGLxaA6?=
 =?us-ascii?Q?aNJAG97/AnQHnlhgsNDPQ9L/IuMODxf7zyJdj5hRbHG+cBzn7nnCzAY+Oevt?=
 =?us-ascii?Q?LYV+Gtz3Hu2OQw4M0RdID69NXG1rjOAGVIzHkn+2z0ql6SySoJpYOHobdKCx?=
 =?us-ascii?Q?1E/yl0XtH97YLOPBv1BGxUqSDgjAEZlaHTrdzBmJ+2/JYM8d1LgBYXYcWieq?=
 =?us-ascii?Q?5lRbpw0JvBhARipW+k2d0NOCXwjdvtYcNNfla6kT28Nyd26jzLXA2gz1SGml?=
 =?us-ascii?Q?ks6xC77dInesxRr5C1834s/fqPuDjwZqQqovbqTzL1uUTaaFLmZW7iyJ0BSH?=
 =?us-ascii?Q?KYB1t08ZfamAAUd/0bxmkIU79uaXeMlgJh9AUsYLcjaFkekLZTTRlK6f8XvM?=
 =?us-ascii?Q?VfsWO8mto/smop3dKvXJgr6XjLSWNoZJ/XP0ELvgNvN2Q+JIgkanBukjcsTi?=
 =?us-ascii?Q?7r5LxRP4wthH1sY65ESDc/dYx30OjoXQwTRJRTvOMQvP6AgAfJ+tCRlPO/0i?=
 =?us-ascii?Q?bJp2OwfTk8BOKpXkWZvhY1y8JaswLl0cOh7U716tDc2vuI7qkE9lLCqFxujf?=
 =?us-ascii?Q?mMAB8fQHKK89CIufHBpLDzkzC6oW3WH0ZC2pKMgsOZMdwx1u0p9/87YXI11K?=
 =?us-ascii?Q?K1LyMDdyqwoAaNWlmbjQW68QfrDqQG3gWOgBIEiHeuCQf1YfRI19a/ZF7l/9?=
 =?us-ascii?Q?Ejdh3dMfSU0i/U2PHK78+8Rf0hvDsK/DmnOSbKU2pWVfIj4wI0qVhaGIhlQW?=
 =?us-ascii?Q?NwikAp3wqRhuGxHj2SZ9wo+B7bJSwK1A0klqBm7TucApH4ioChNac/Vnv2xP?=
 =?us-ascii?Q?7sOMhhZvFGK7He3BhCXM09R4xfD5Dr9jwc3LLaiEr1dUJwKQCEuQFLUSgm1Q?=
 =?us-ascii?Q?ghepT3hQFfOfOyjXKhv0hM0pvusrAXnXRbrtm/nRqBKkIxLMbZPLOtPpVEUF?=
 =?us-ascii?Q?79VlCWDJAJ7DliXZHYcZxuPLnmA0UUZBYpt1eKeK67xWiMsN8agm3SaRE7sK?=
 =?us-ascii?Q?Ekc4ATuIFTYQRTwF/lmU4/cuMwo04zJTHvUf2zsPDCl0NKBclG5KAACZQIR5?=
 =?us-ascii?Q?tZ+5L6lGjWvFHVvYp/uEcf8SIGvfRwKY6S5gWSeE2fFBPnZ+Uyvl0GwkKrDl?=
 =?us-ascii?Q?j8+o+oErcZ/VvgSbQQv6IgytW5ePdNLU45JV1lRMySNHZG8b+2ybrpEiP3T2?=
 =?us-ascii?Q?QAvsH4BXpyNRdE4wTN6cct6PzJOlk4B7y3Up6gtynUiUX/hp1vXMgyVSR5xx?=
 =?us-ascii?Q?eoeFM1AYodoncVqS8XzlE4fsPu8pqa8jabIZROh2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85301fc7-8543-4ccf-5504-08dbbb65fec8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 12:18:14.6370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GhGwYPJmQDj2w+14oPRS3wan636fZPjitrsmPeaPfqpSB7XPOgqa1mb5pU7rVy2A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9011

On Fri, Sep 22, 2023 at 08:13:02PM +0800, Baolu Lu wrote:

> > You might make this argument if ACS is also non-isolating though..
> > 
> > Regardless I think we need to get into a position where the iommu core
> > is deciding if PRI or ATS is enabled for a device, not the iommu
> > driver.
> 
> Agreed. I ever had a series to achieve this and it may be time to
> revisit them.
> 
> One additional concern is how the core knows whether ATS should be
> enabled. In my previous design, the IOMMU core turns on ATS by default
> if the device is capable of it, but the driver could enable/disable it
> from its driver probe() callback.

I think that is a good place to start, maybe we have some command line
and/or sysfs like we have for the default domain policy.

IMHO iommu drivers should not override this.

I think it was a mistake that iommu drivers could override to identity
domains. If we need quirks then the core code should have the quirk
list, similar to how PCI works.

Jason
