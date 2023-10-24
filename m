Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2068.outbound.protection.outlook.com [40.107.95.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B86266B2
	for <iommu@lists.linux.dev>; Tue, 24 Oct 2023 11:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bg+pwgF9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crYBQMMkfWnbXcyXLMxOzs1ydl4qcBUul0nsKEB6tuaiyYaFCtFZTQZj81tdaxSvXJnMwj0EV1uaB3CbO2E+9AVvVDjeSy8XcBlburfOl8AwCv3VArB/kGCk2fFJSMmYbtyb1/++Q70iJb7nZB2ol3lJMDyUjbXkHxy3t1rOXeKTAbyyiRo8xCg1UVykWMnt03Qc2XGjT1QsOb2ShrnajHSzhu98U438ga7AGOFIA3kLKLPq7px6Wz0a13ln7hqRC/Ytr+2nLTL9pEO55hC+eiHxH4Cyw5MFnEB47Adqv+ELw6O2HmvA43YMy/X2c9Y1gBbUK2icCBlndm6s7nOGdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLYpOEVkpCjeCKQTPN8DQdr2qP3ttexbxcRe2ZN0gtQ=;
 b=kV1V1b4y8up3H+cYvwZyE07YbK/YlV2qIOlhnzgxt8U+fEKppE7D8kZ9JAzX7MtVGqivUs9gtxmrUcZQmCNzZ3wuZyHqzv8SD5fCN/NipX+Hbh5IzPs7i5HQQbFKq6zh58qoPRssAvb6iVXBYJLpsIuenScASujSOzaTQQxB28xAg+wlmrgmdzWWPskAh+VrOomMDdDWgzBhlCsbAhZSbwRptLOPeghx0HRT8MdVh64CMdI8kBG9TonUgZsv8Grb5D9QE/02zLdp2M54DVsaiSnyTP9GVE4E0sQzFjq6qYfzUXGdQEAO1M2LFdKmuXwrVPYkDvZoU2kRMj+ZMwJzCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLYpOEVkpCjeCKQTPN8DQdr2qP3ttexbxcRe2ZN0gtQ=;
 b=Bg+pwgF9hEBLZ+WOr060TzkcfFKwY2m/2buprVE/LSbhkMq8X7N1q0v2PggROfDOX3xtKK0i1zUPn2nM6yMLKWgt3sLL51gO2HvsIrh0xgtPNmsW2T3M9BG5LRJnoMf8H04A1JsIJE322tjqopx8TuawE5MpPiUBsyAoECHsnRT9W7iFoLiplG8B/MMvnc8W1KFPICLutnFhOtxpaa7gRWotfBeiaAr6Z9d7M5xJNw8DfP50R6SKb3pSW0XO6Be7uUUqLHGTEpUvfWMOu5hgwt9333KkhvHjfJTzEiaDjwLEypyWv2PG29w3f1rImSNOyDXGIr+trtz3wFAA3M1/ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY5PR12MB6105.namprd12.prod.outlook.com (2603:10b6:930:2a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Tue, 24 Oct
 2023 11:50:26 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Tue, 24 Oct 2023
 11:50:26 +0000
Date: Tue, 24 Oct 2023 08:50:24 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Shavit <mshavit@google.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH 09/19] iommu/arm-smmu-v3: Hold arm_smmu_asid_lock during
 all of attach_dev
Message-ID: <20231024115024.GA911568@nvidia.com>
References: <0-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
 <9-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
 <CAKHBV25tgz6AE_pB46-8WeN78q+gXnjXB-4MEE_cpqVV7xSLcA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKHBV25tgz6AE_pB46-8WeN78q+gXnjXB-4MEE_cpqVV7xSLcA@mail.gmail.com>
X-ClientProxiedBy: SA1P222CA0080.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY5PR12MB6105:EE_
X-MS-Office365-Filtering-Correlation-Id: 15ceaa2a-8356-4b22-0602-08dbd4876983
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PXxRoiToKaeOAVbpIe/fPaL66BKzVN5kS9ks0yqAin2LNkStqkVxskTVCHAxYe7287zspHHT/C/LcsjC9OBbQFOliYpYPWoS9aMDjN3zF0MJqHijG7N2Mj+RRVeB5FgwT6Gv6s2MLgrQgfEocfaJuPwzzCuN8zwd8ESt1v/K+51oYSezO8ufAAE4DtlxuEowXjF/8Nuf2obW8g7n4F3D31IU2PfKQeAyDm1BRSMWKykBURQ+BuTQx/dyqi96i16V3D5MDemoH1jPVxF1Ee1IE+I+umn+1w7Swo4X/C7UibAuohU35p2f4nNA74kubqt8onZQS/UhnuvTjTydiDU/7hvC59IbKr8+iP1uDtIylz4mpg7CJVc+SLta/6NHg44xFP1buSWjNBmkzJI21zeL+K198IACuHUYwpkm9QeF3v1Oq8FF3xa4xB0wQ8EDyS5iK8JWyl0JF4wVqXLKgQxJT9UUKvUeEFRcbnEaajx+JSH+s0OTv1YqJ8asBbga4Gye0AI6l89VmNfTEHRr7jLJ5Ht0ywszoWP5dQaQDWZlUSeMobNE/PC7UmRGrcgGyB2S1EetrRR0Q+DfM4rBafZtHSQKwTitZqkkLx2zxPwYrbc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39860400002)(396003)(366004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(26005)(478600001)(1076003)(6512007)(86362001)(6506007)(316002)(6916009)(54906003)(38100700002)(66946007)(66556008)(66476007)(36756003)(33656002)(2616005)(6486002)(107886003)(4744005)(2906002)(83380400001)(8936002)(8676002)(4326008)(5660300002)(41300700001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5nVW2SGm4erYhKagLJNt1mhQmag4/G0etW4bfi3eI1gcRGh/XpZ66LPYM+Ve?=
 =?us-ascii?Q?qx2I4WQWNA35rgJFHBiTMWWZ+8Oblb679QvoyY+vUxTA2wzcgYhyLejSzIjh?=
 =?us-ascii?Q?apIZp5C2WJfh8A11NgAI6hZxGg3klBYhx5kP5TjClLNhFPSNZQ04s/moelhd?=
 =?us-ascii?Q?0Yya13+SN2JH+hWIh+n1K/2A97zQTeGrSL2ehS7nutiA+wSnYlnIHrzsLHDY?=
 =?us-ascii?Q?mz7srLBhBxqZjXI3eTBfSjJJVKnTLdPZztIHpvFJ+4wh24Vk62jnVkoiJOm4?=
 =?us-ascii?Q?GglBpkmLnz0/Dz2E1Xp2gVV2UwRtyUGZ9csevwjNMTzrgAHmTAzEZdNJm87v?=
 =?us-ascii?Q?NmYODByq9IGjhgUNsUj8fT9IPcKcZB+GJSfU1CWy3FyznvlrwJe/TF36GoGa?=
 =?us-ascii?Q?6GGMJJTaO0sAAmTSd1Tiux1crpqXG5C43vqxk0Jg1jBmZxUk0nPc8+7w1LYB?=
 =?us-ascii?Q?78sWwbGfM6w+f+L3Az/T+zyGn3b8VQ+P933ynArv1Fywd1zmAIlzTAqactHd?=
 =?us-ascii?Q?/Cyvena4nH1OO3edekOgm9metvu6e+8tZI50NNoJo4FAgIJXOHQ3wxOJsIM+?=
 =?us-ascii?Q?MPZx4YW2+Q2fKgDYc/tlOMm0Bd18yJjQ1YfZL4d3tedp7WktNzzilkBBZv/5?=
 =?us-ascii?Q?xFqpj24BikUadUjjxwoZkKeLs3OJcbSdCUtjhIAMK+tPdAugjeXXY2bKl/KA?=
 =?us-ascii?Q?F9MwgXmuumsBW2hraSeTlD3EdZNNC1slOJdqdy6H/vwhmueDur7QwiMK+6Vz?=
 =?us-ascii?Q?oSOR4t07nwMmIMSNWAr99Zk9AI87mB2c2LtsjCQCioLh206sFDPOj49Nr6fJ?=
 =?us-ascii?Q?8pObxwl765/32/F3lU/XUAt01jEdEAzASyWCgT/4yazU7u8cw3fY8uHTPpkR?=
 =?us-ascii?Q?MAopBl4F4KlKVnT/fps6NEDIfITF1kA1VctS+Gczzgxut4ZJybUXqPl7l6eN?=
 =?us-ascii?Q?Djvpo0jzpY4jEcvf9hFp8EOcoruXbB7ZqS+6BuomgBKHocogh9coCdJLCoQ1?=
 =?us-ascii?Q?uy/Jxuf8WogZqL480MiRxixhByOfspfSntVrxkcQCIkKfVv2Kho/SFZ7hF3I?=
 =?us-ascii?Q?wKrxB7SorC2QHz4bSEgKHNL7/M3sUMFvkI16X2AvZYHtaDuekWZe+aTErbwp?=
 =?us-ascii?Q?oksgoSELWbdcrvTcVQGzCzYuN4kioZZijX16E1g9EjkBt78FB/OxnlcGO/n4?=
 =?us-ascii?Q?b7+AAVXYPIu0r1CDDYkhaSjxJzfE8wFH1vuvhV/RwlEoLtMEPUA08I3Gsx7R?=
 =?us-ascii?Q?4vBwTKRv2zb5g6kIbxaGrb7MuY8h1dj3CZKvnmCtUrDxA0ezyoJDzoNCeS+f?=
 =?us-ascii?Q?70Kv+VyqnUypAegpFbQmeWeCL4wT6P1Gof2a1wLedjTv0EKZ5V/OKrFi2tnl?=
 =?us-ascii?Q?5uqN1uVzs2LeJqJpXkGvCYPBAtg4DjbZCgYsUJqFlDPsYsfGFs6yqgsIpsfQ?=
 =?us-ascii?Q?nX3Pk08w7ofteHgUODGKpmKKaT4pW+LK1RTtAb+LGFGmvWBTk4CP+wgrkDjB?=
 =?us-ascii?Q?Jb7VWf5UMRhk56N4mhe02rrgtU6pTg7c8MucE/dNnujWK2SdUtKGOZR125We?=
 =?us-ascii?Q?Iw434TbBVObmibw2n1S07pHi23K9nUc2iQ+czAyA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ceaa2a-8356-4b22-0602-08dbd4876983
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 11:50:26.0312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 36qveVt7VZ1t0f7rvbxBHEjtI74SL7jyLKzQMnyKA5zLkG73Zo1T/gFgIfRquZbu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6105

On Tue, Oct 24, 2023 at 10:44:36AM +0800, Michael Shavit wrote:

> > @@ -2549,7 +2547,17 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
> >
> >         mutex_unlock(&smmu_domain->init_mutex);
> >         if (ret)
> > -               return ret;
> > +               goto out_unlock;
> 
> Oh, missed this earlier but on a second look the asid_lock isn't
> grabbed here yet so this should stay as return ret.

Yep, there is a hunk in a later patch fixing this, I moved it here

Thanks,
Jason
