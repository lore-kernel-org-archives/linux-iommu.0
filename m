Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2087.outbound.protection.outlook.com [40.107.212.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B17347AC
	for <iommu@lists.linux.dev>; Wed, 29 Nov 2023 19:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xz8owtA6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFCjLfyzvfFN28pBEwkPsDzukULv3skMSxcjPKYf5Q153kmU/PoVUl1vSXVTxNnQl751lskd8rgFKjEagIkOQksPtbqqpc6JshNFLdaJvXEp3uVnCndbGSoVzeNdhZnerp9xfxGylpwK2PFj78zRRaTV1ybLK0VpP9rCVm8pUAvRdutiMExMhSHYn6HAasbgN1sBr4b5fB/11WNK4MUyu3iHv0Fnd29qpEW5+HMU8Jx80c9rhvw7jIOfK5WEHFtYzRQ23UJy7VJlH0hqGZvMDTSNPNMo8di2UWSIy0OtloNXEa01cMlggpDFxcgqcAEi1QRHqAGDw1AXa0xquKC71Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YhJXpcO9PXP8epaHP5i78bhU9OowI3rWHxNxENN3dsU=;
 b=no1VTNF4HFO3cTn1IAT5cAPTUSXlRGMLAkA+6kXuojzGOEiNEqt2XxMlUUYTGFgXZ+45/8iqYSJwOJQhfhXkUBqb29QirhSxEF1Wz6xwXnFEb4vrUsAx3A4W6foRPDFsbhcqtrCZ/xdpbLXTkHagKlf3mWQoA/XBjeyWG8dKZP25dc5BBZfwuI+YP/jHDqorsR1n7wVXvWtMgZtVie5jgfJcFCRe+yb3yxaVbD2Iki7WMQ/j0SMTYkKfZXpzWiety1LUkK2zBcWQbDBdFySmTB63nhiyUM/hlHcTxp43qjsWHPsFpGQTsl8cvGqNzXF1vwmU19r5bUd6OleMCiCy+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhJXpcO9PXP8epaHP5i78bhU9OowI3rWHxNxENN3dsU=;
 b=Xz8owtA6/c6xD9iyElBMUpptUEdLnAYc69izXaPvANZPPmr7BBixINuWsWv1zghMbO13NfSmRanTSEtC13syemKcFHTKcmnJMjasdjbb1/2KIykE6yeZ4f+mb3xdZ7zjhjqd78NaX9XFSC7KkfxZkOZ71jb6x4ga/S3ZT+GYorphbgZtGdx0QjTTMSvKMoXdhayTsjmym+OKUq3hQzmpYNTu84RRqXs/Fcg6JENQK6JJKOY8rpngDqVre8nGsHfMN7XPXl5amPovUYW0slQyygGNED2hK6TPJbPbTxaJj1YZzoAV+W3zAYhr2A/LWBp/KUOTW1x+jt2wN5i6rDpwWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB6491.namprd12.prod.outlook.com (2603:10b6:510:1f4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Wed, 29 Nov
 2023 19:42:36 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 19:42:36 +0000
Date: Wed, 29 Nov 2023 15:42:35 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	robin.murphy@arm.com, will@kernel.org, joro@8bytes.org,
	kevin.tian@intel.com, nicolinc@nvidia.com, mshavit@google.com,
	eric.auger@redhat.com, joao.m.martins@oracle.com,
	jiangkunkun@huawei.com, zhukeqian1@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH 4/5] iommu/arm-smmu-v3: Add set_dirty_tracking() support
Message-ID: <20231129194235.GC436702@nvidia.com>
References: <20231128094940.1344-1-shameerali.kolothum.thodi@huawei.com>
 <20231128094940.1344-5-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128094940.1344-5-shameerali.kolothum.thodi@huawei.com>
X-ClientProxiedBy: DS7PR03CA0084.namprd03.prod.outlook.com
 (2603:10b6:5:3bb::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB6491:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f62ee06-1e84-434b-4c69-08dbf1135688
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MdNwydtxURJCQsDePUB49zegGHupl1vo/8wc6BZ8SADoD0w0rCzlONl1pVpJrrPcHsiFr/dmKeye61nLDiexXK6WYzKbMrQ4n+qlkSygy9zaMkkvKHK9iCTw8TPgJu7z13UjJLwBVnreXgdlsAv/ZH0+8W4GB9N28DigSBPGxOdvaBitSpVAkADpIjrnQIq/31+yFEi7yL8dekLNWyRnKlFxlLiFodirg9dEA356EqcwpcW/Plnncyw+judUyEV8nNEUMdxVLOGnsot1/DCJ2gJXK76+4j8R9nhwcukX2kAJvHbdhcU7xRyxPquMKLvsY0/VOzlbugH/cLVa08yh6kP+YyIOEjUwxgZyll1krOPYDIWHJCtSnnU2UMLiZmIvdYcxCdYkKJ6WKUedmuGdEK4yql1P3kU5opbv2XyjZCyhDlAUFdQkfg90+3AepFC0p0sMRhCrQhYi/yMFu9jAjRZ4EjOXWjDdCI4vS0Z/YwIUJlNigNp95nW11sJvryLX9cSe4MM85nLaIvz5r+LTaiH2WdPgzM0TQYOZAAqtjhmnMx9YddQHUH19ektT52ZfsvUMFXGg7E6v1QLxysFH0zdMVf+T+MvDxxoeDmsUXF6pZyU32bS+eR4J+CqBV+lV+KshBJoYFo+EHMvb65pdhDd8MA2NHrN/gBf5vmOrv2Wkn7m4SwrLcVsOmpgUdjT5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(1076003)(6512007)(2616005)(6486002)(6506007)(478600001)(41300700001)(4744005)(2906002)(5660300002)(316002)(66946007)(6916009)(8676002)(66476007)(4326008)(7416002)(8936002)(66556008)(38100700002)(86362001)(36756003)(33656002)(202311291699002)(26005)(27376004)(14143004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KsobCXYHfKtagi0I8FrNMxloYKVmWb7++YJzSmEHInEpHxeAfOAk0uZLyip9?=
 =?us-ascii?Q?q4rYX2I37okn+uEyR1zLRdGUbGvMiUK/cFzIIzoVrHr+06lDF1r428qfGuAo?=
 =?us-ascii?Q?1CVrt7dsiIGEzVdzAfaLTaicOnHpmLqkXTaJC0Us6D1fYjEGYkRT6A8YxMY4?=
 =?us-ascii?Q?3w24U3/+vdQFe86MlqPWhCrGQ3NX08OJXGcQoGWL97ngnAmtGy8mzNwTRUCf?=
 =?us-ascii?Q?5RIIFpdckZ91V8HnIaStP1l7/gcBAAM8d9QZGiVN1eapn6DwmvTbTj7h2xOB?=
 =?us-ascii?Q?hAxVUigP49fGFLalc0i3E1BruPbucANFYSPs+AQVCerI0xfCe+muUVSaLRjL?=
 =?us-ascii?Q?NX7X//U7UUD8MuomkgICdkhhP0WgQOCGzV16gsBnWS2X4RNqAA6lTRpvrJ1E?=
 =?us-ascii?Q?PRNiXcNKrm7Ujfzyy2FS66qrmnxs4bdyJhnLDEiXZsIXwwskIqpYZpe66rse?=
 =?us-ascii?Q?0hv+eUbe7vuOrtWGQmywtTmQ/1+h00010VCDm8ocWwaKm7Z5yXJCNfsTZAXK?=
 =?us-ascii?Q?Sdg0lNIN7JEtJ7BOF7ElBEnJmZeDBtlnGIp3Jo2j+6j2yIUAX5oP5L1/Wof6?=
 =?us-ascii?Q?lKgXp2/xIfOGkd+t/xzCDOvNUIDBGbON7JoL1eWxAew2n5Z1q0k+gjf2ETW/?=
 =?us-ascii?Q?tEd7CabTEUtpG7EVdh0W3ZubaLW3cF+lLGfCMqIIW+QEckwQaM7jenkv5aRf?=
 =?us-ascii?Q?hQpTxiFWIy2VLVENRUzh2QHBLCbg5A0B5aPWRgRl5Cf+4XxVtPsQsFEZUcy5?=
 =?us-ascii?Q?KjzCGYhA5QVK+DEnD5A8liNJlnAb9wNh4Ypx7irduRJ4pZuOv/AmNHlXCzSj?=
 =?us-ascii?Q?oFSt9EMBfr51FjzEiJRSnLmcHHisBrsvh4EjO/TZTkcElA7cJTF2v42tKr8K?=
 =?us-ascii?Q?Hgu8zX2gvEx/MnCz8p5oMCMMOnDnZLBP71DAi5nQe0PgfwRRs/J3ZKAdYpDN?=
 =?us-ascii?Q?Lv4BD/yLiPtcFkt7ovJ2LVf9kXWGat3EJ/Qa1gWFkG7ci1YSw7q4V2GDrTlF?=
 =?us-ascii?Q?XQ+U98/ulWoRwkSiREA0tUjfopTy7PfUjY5U4jBD/3dBnMKHcvJD3mok+kNb?=
 =?us-ascii?Q?mzibi+bsqIi/i7GJNEG4vwVqjDOLMzREXQp0KMYqlf/gHwhCPuilJyxQXGZp?=
 =?us-ascii?Q?KPwE5Mkv1l21ScnaoWpT9gAx8YCdRI0AwcCXNZSxJlkJ+ZkgDbSwmh8MWPBU?=
 =?us-ascii?Q?oXMh6yNeUeIe58r/XUWmQQzkG7GoWdC5S6aK0aLLELzewvXeRewiUGK6WDv1?=
 =?us-ascii?Q?4CVC5dDBQ6AV+/NNsAufkCd+ZhBdeDNvGjwyjzKNcP1ysoy1Cy7xvCnL7cSy?=
 =?us-ascii?Q?nIEp3q15+LWH8ibojW+Ukj05m/doZMAeLTewg+49YIV+1JR6XJu8zhfUuOsI?=
 =?us-ascii?Q?NDQdYbp1gVreOTzeMc1tp5YHpo6WFXvVTY+uUlgYbmW3bYpww55PJKHdjLdF?=
 =?us-ascii?Q?7hmbpqeXruTtgCR5C2t/+mEA53xNcRlPo/T4/Vk06lj35eIxlJrHcu2iucG5?=
 =?us-ascii?Q?gH8WtwsVkk9wfuXYGbtVx60Ai9BKpfpTvVWgdTllMZQZutnqXqLFVRcI4z5E?=
 =?us-ascii?Q?oqfd6H8hrcnEguTKOkThd4y5Wru58yh9kRfemPOM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f62ee06-1e84-434b-4c69-08dbf1135688
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 19:42:36.2401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E0QmGN9y2YOavYDho7ySA3AclKi/DhasMU0iRgettny7l2S0SfD+1t07059vQ7cJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6491

On Tue, Nov 28, 2023 at 09:49:39AM +0000, Shameer Kolothum wrote:
> From: Joao Martins <joao.m.martins@oracle.com>
> 
> Dirty tracking will always be enabled with DBM=1 modifier enabled
> by default when HD is supported.

Is this trying to say that ARM doesn't have a per-table global enable
for dirty tracking but instead pre-sets the DBM bit to avoid the cost?

So on smmuv3 to enable we have to clear everything and disable
continues to pay a penalty since we don't go and mark all things as
dirty again?

Jason
