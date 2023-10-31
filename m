Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B48156C1
	for <iommu@lists.linux.dev>; Tue, 31 Oct 2023 11:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jI/04Exw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CDqOITMjBB5LNfgml6XACjnOqa7XQPglpKmGWr1XGXniaWEihP8xDHyxWsVxqNUlyBwLE0oqh1uX7ydXBltTObAIG+S+lUeTIAl4RKg7XhKBZJA3ftU9HinYZDcQbW3ZUCMWVRIXK+JKZSX8dK6zXi1ftw0rwCy59rpbih0mXSDJjydhW41P65p0GhnXma9K4OPbrRZN7hsxvGlnBHMxqEMEPanxmOq2tozNeYrig6UtrlbcRh9+7iQId0kjlQREWSwCTL9e5c8QxcKYkx6EZ7FDcWyBYIqNMpTQvhclT852KrAfph/OIEyaZPvkLmpv13lqkXkSyXV+a3AGh49Bjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vMXMMz+tbdYXeAGDzKECP9aLdFaI+RWqhHAslAL7SY=;
 b=C/ckVIeuYqq5samogLhRdGvl4mQNP0q5R+ksCDGUYX1nm7vAhF4DWptacMZPjcM0VMUgIZK/kJc8mAXCWvHLpcHTfW4xfKUODHHf0TzLn/wrBt8CkS6D55dw25WPL8tIKNKCqz6Dvi1bodZW1goST2eOlbKyNAR1h7glsKNycMHd7DOawcUNGbleIVoR1RieKTz06ar1wYcOn+J3cFYxnCmu3gTu7xNzSzj7l8f4vZSKsttDAUfR07M0GBHmzMDQJGtZqiIp61/einV1QV/EKa7P+w5s7mRKNJuPbotR1s3hzq8n3fxzpNUuTrSGSLrOnH8Ckh7CVlkBO4nIY0Z7ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vMXMMz+tbdYXeAGDzKECP9aLdFaI+RWqhHAslAL7SY=;
 b=jI/04Exwlnmr9EfdxpD3Z4ZDTRdj0UAXq6eOxYEa2LirXTNZp9u8ofuxzfuRpo7hqc3dc1W5NXzzl7YEXHfTXi0aYAndczNRGQWFjDIu7VF/liOnf0qlDG2NA5LBvWZN6AIhkdTY5d5khQIR5Mbb8bZ2zHhtnj+lDV3gw9Vq+wHpV3wR8VtXsaIKKuAbVZe3ckDTMDHWPJ5iOjtKleoaF+W6GeRyx7haL6QubJd8jm3a/2RK55190NKHkjCS7UfYsUFmjF5NCM2OCqlVHwHJ3jcILONbA6xyEpqkfzbh57uNhaKHvyTrqACdirDw2jCrBiJPC6wF1eicRqBkB5mBiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6628.namprd12.prod.outlook.com (2603:10b6:208:3a0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Tue, 31 Oct
 2023 11:30:12 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Tue, 31 Oct 2023
 11:30:11 +0000
Date: Tue, 31 Oct 2023 08:30:10 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH] iommufd: Organize the mock domain alloc functions closer
 to Joerg's tree
Message-ID: <20231031113010.GW3952@nvidia.com>
References: <0-v1-90a855762c96+19de-mock_merge_jgg@nvidia.com>
 <10a2d6ca-80a3-423c-9795-2b330fbfb558@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10a2d6ca-80a3-423c-9795-2b330fbfb558@intel.com>
X-ClientProxiedBy: BL1PR13CA0178.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6628:EE_
X-MS-Office365-Filtering-Correlation-Id: f18afede-a031-4978-d775-08dbda04bead
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	m6Yoz5OFOpWIacUk++cS107AQcdxr/CvJyAPTOaL//cA8P8DFf1X8fb66uxFZG3kQwCXbG6QMko3DXX7C6eL1rNrCueNUxZmN8RpkxXmSD7+QBM4iOGoI5iDtmQXWt09LSdFmugKoAsusVODLqb2pjRVsBnD7zppgeCfSSQYgmS8G+cyz70gD7OoH99vk6B6NCwgV4tuUgCg7ATMmTDYC04yHCZ5Vd3k2eUGyw7pDSuWv2sxZ+qgzR9wSxFByHNTjTHxh4kNgYv7YH1BoUJa+cUN0Z1gfHPVq7ESutrh6t4DxYuWncc5Y9UAS8z+wkilmdevC/WcQ1ehkYoNn/dpHosatv2rTbA/vIIQVFHccgoOj730rs2CDIoq3C5d22g/adnEihVBmYRKGrmhGyHxLP//mLbaoeqyziddMpKrZNwb3XuNXuZqn1IPLhMxGZxMk+2NXchH7jxoF/pK/cLd5CXhdR7/bIj6r/cZbvwhwQM5FZf080YA89prjN8wjVw6x5hWqj898W0U0F5FZ85cLhkPTYKw27s9sMmYYeq/e5vvgJRVzY7loZ9KxyrzR4ps
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6506007)(6512007)(6486002)(478600001)(83380400001)(4744005)(26005)(1076003)(2616005)(107886003)(2906002)(5660300002)(66946007)(66556008)(41300700001)(54906003)(66476007)(8936002)(8676002)(4326008)(316002)(86362001)(36756003)(33656002)(38100700002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Cxc9tGnLJerCtYw89F2MPnEaU8++6UqZpQiwWcAVj0UxU5WtmjqyxAu6lSaq?=
 =?us-ascii?Q?XbBWQgbZqI+Gc3FF4fcA6B92PszHtpF7CWYMsoyLvuCLSP05PQ0b+s8AURJ8?=
 =?us-ascii?Q?Vy3oHd45XtlHCO9JCxmKfQUtxA5bYFr56xAAsOZbItv7x8d44ovmiIWsQMRI?=
 =?us-ascii?Q?EOpbMLI8Wjo4S5XkGAQcZ971mCs953VoY6KZRil6eZnidcA+wW4GF9uL2DR4?=
 =?us-ascii?Q?t0emUXINF9dXdPMYQuAGRg6Cab/NtHsOkBUsy2ECZPTOthtq01wqnaB0Q/vQ?=
 =?us-ascii?Q?xQOq5e1BHYicrgCPlxZcnlrHj7nW3jIKTturiMjm+ODF7FJhgPIUn3O7NCvt?=
 =?us-ascii?Q?62QbEEcCsMfAMYpGEua8iJv76TmjiYgfu7AERkpSGuO+57Sjnz9WYhdZYRB/?=
 =?us-ascii?Q?WAWKtVqexUFCX5AHqzld0eZhrmO174QhRe3vBlXCOrHmXDeGwnWcP7AZAzf4?=
 =?us-ascii?Q?ChySDWP1C1nqvbqWuwIIgpjRHFidUSbZfzJboRl4ZwzHscBKCQ/cHpH+kuyg?=
 =?us-ascii?Q?heShumozvKz1iUF3VtLaxeVeaLSm7u6rHLi3xrXeh72VNC8GDTZmv6jY9xgy?=
 =?us-ascii?Q?RE5S3NQgFXR4oFpxvD7+r5bzqSNTvQWQjMXkvRketHph/+7K30WM1uK1MCgZ?=
 =?us-ascii?Q?9Kte41KAtgiIzl4woFmjdeho/hZybC7jHn3ELEWGlqzyYt6AoEPN0f1vgaCB?=
 =?us-ascii?Q?Pe8OJkejSGyEtsdyWhWOxF0xYzm7yrUsd4ZDm9Xp3wJxgZNS2cNW64zCJs7F?=
 =?us-ascii?Q?fW5AyDUFshvuPyhMoVfMyFay69nCBgeJXBPU8NwdGO83OYlX+w0kKUbudFIj?=
 =?us-ascii?Q?vU1B2jtQIKvp/QfYEl1WdaA+IAYMQNpxxqF3tMzq8q3S98J+2FTTTSUpxd6k?=
 =?us-ascii?Q?lAI5BSt85aYJmSYdzXf/svDwqqZWJjDyNabTRPVzn7LHz+1eFUm4lsDt3hVD?=
 =?us-ascii?Q?5+wtLi37vN81hku35p1hjUVyeTPTHhxl4xutkRdXAQ+4jJHRnpLUq+5Q542c?=
 =?us-ascii?Q?QDK6Qyqkuwj1IGfkHpIGaq4YEeGVaDVWZVI2WqN5Z2U36ivPVUsHnki/KkFI?=
 =?us-ascii?Q?w5B41+S7k5WtWhBKBj2xUptzUabLzUlShcEb0jBn/SixfZAeYcLJsrYrHV4K?=
 =?us-ascii?Q?yBY61ZPsbTzUJdiJzJGGvoAfWN15lGRDj4W2En0wfzv0qtjhaYfxvKruYUPH?=
 =?us-ascii?Q?SB7CnvwkQvzYMHFACUYYWlz0jsYic3kCbjZXlUFk9KzeyMiSy3naDT3l89up?=
 =?us-ascii?Q?agzWLuJDL9um0B/ldSl6rWIFzP405OT0WUkZUuSFWNYOAlnfpxOjsAh0U2PX?=
 =?us-ascii?Q?WxauCqy48HsYTNZpRHopWiDXJs4kHQMnLf3vpqh5LMizevLzMWaP+DF0l32u?=
 =?us-ascii?Q?04BhudlIuF7cQ8Z/fdQ61ZoutJoH35oS8onoTn7xboqHL3QQEmAowc76dt7g?=
 =?us-ascii?Q?gyvcrOaF5HKX7NKD5mZCSwvOswiZgVXU8W9UiMCezEdIkepQ6Va1c5rvHQ+N?=
 =?us-ascii?Q?6i5AX//ZRcFha+JW3udz9wUpJQJujxlnRXR5b19by4eddaCp/CIQ+FLZY9Bm?=
 =?us-ascii?Q?HuLDylzQDA+kzcyV3hQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f18afede-a031-4978-d775-08dbda04bead
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 11:30:11.8128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IyaI+5VI7LPj6ONgcuSxVFa1yXUS2ySurMklYht5yE/BkaK7iAdk+VW6hnJAv7k0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6628

On Tue, Oct 31, 2023 at 12:13:50PM +0800, Yi Liu wrote:

> > @@ -264,16 +260,11 @@ __mock_domain_alloc_nested(struct mock_iommu_domain *mock_parent,
> >   static struct iommu_domain *mock_domain_alloc(unsigned int iommu_domain_type)
> >   {
> > -	struct iommu_domain *domain;
> > -
> >   	if (iommu_domain_type == IOMMU_DOMAIN_BLOCKED)
> >   		return &mock_blocking_domain;
> > -	if (iommu_domain_type != IOMMU_DOMAIN_UNMANAGED)
> > -		return NULL;
> > -	domain = __mock_domain_alloc_paging(iommu_domain_type, false);
> > -	if (IS_ERR(domain))
> > -		domain = NULL;
> > -	return domain;
> > +	if (iommu_domain_type == IOMMU_DOMAIN_UNMANAGED)
> > +		return mock_domain_alloc_paging(NULL);
> > +	return NULL;
> 
> a nit, will success oriented better suit here? if otherwise looks good to me.

The merge deletes this function..

Thanks,
Jason
