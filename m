Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF6477629
	for <iommu@lists.linux.dev>; Fri, 12 Jan 2024 16:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="da0UEZaV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AU3MOT/nrflbQoNZCLMODAMPdaaA5vCQNU9V3hwnbKMEwDTJ2Hlgj/0E390ZNOI9ITzIGxzNGxaEO9AUJm2DaQ/ld8m7GhV0biAC49qk4womg/DmMEeE0ww9k4uWyRZOGgsKaH0cYw8BfTlmPOoaZ48nSxJeHgsOWVPPg6FggZLWa1LikEF3VACDlvjcX93Oe6PT3H/BiTSEDdRduS+r4Jo8NMlv9qubomo7jkmCKVwA7lpaehcFuwCrE7zR/k0eTdNlOS7VrxDYkDcwVSYV/pDjK17atEDG/cRlZ43ai7PAXrM6HJPjjBBz9iQWFOePww7YjnWgHvj1CBC6w/D5gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6iDVdsAFhBKExuWgG12JlBd+hKeSd/sHVKLuegyd2pY=;
 b=PIE9hhZlzmspda9qkPNFXmhdCIebYOkOQ90wBYGL9Ap+bQm99aLyEBf2upyF7i9bm3URnP/G3fTVDlgtZKQlqrvaofNXj91WFP5Uxr3Vj4kQdDurRIh7LsdxFPPmhktds600QjHb84b3yO7W/04x042t3apMqMkFFJNQ32Uuuz9co19kf8fWqhNko1zvHmurjsV8DUoSOJ4BJ4gVIIKZk0ir5u2ai3tXTh22cDftWJluf+0oxilJOiG4J/v3yp1fjyqjAs9+DgblAhajUTpCb6vveBMQi1rNzUXCm2BCB1lwTOCv7lUkz8BooEM968QyNa/KiiHalx3zXTohvOygcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iDVdsAFhBKExuWgG12JlBd+hKeSd/sHVKLuegyd2pY=;
 b=da0UEZaV8AWSuagI69OokVQlZPsGNSiyPJQCUtXDP6JrO6O+7YLNoijBn33ufwyYy+FxesspWN9nSUqmDKfpSWdZDDst6TPpfqfXqkZ9xN/kNStdqWX4N5qDE9juXy3GQNrWEWQ42kWpoH1BwRqh63bSdEqOhJLuFrjKMMqt0PRCCBvWqMM5RjEveVXvXIz10USoc0frOBYUgqKmdHAtSZfK4pQAuAanZe8Hub2h+NI5XW9OjGNS6bUVFv0BhjGUlTVEQUWEC0p8XvA/58pILMGkpvpYTqXiNbWuWOcX3n+fBwPGyMcBRVa1IQWs5JzqQaudUNKmBmYX8H8K7XtRhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Fri, 12 Jan
 2024 16:36:53 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7181.020; Fri, 12 Jan 2024
 16:36:52 +0000
Date: Fri, 12 Jan 2024 12:36:51 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Shavit <mshavit@google.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, robin.murphy@arm.com,
	will@kernel.org, nicolinc@nvidia.com
Subject: Re: [PATCH] iommu/arm-smmu-v3: Add unit tests for
 arm_smmu_write_entry
Message-ID: <20240112163651.GA815670@nvidia.com>
References: <20240103175043.GS50406@nvidia.com>
 <20240106083617.1173871-1-mshavit@google.com>
 <20240106083617.1173871-3-mshavit@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240106083617.1173871-3-mshavit@google.com>
X-ClientProxiedBy: SN6PR16CA0043.namprd16.prod.outlook.com
 (2603:10b6:805:ca::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH2PR12MB4133:EE_
X-MS-Office365-Filtering-Correlation-Id: 279b41be-d898-4070-ff58-08dc138caeb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	42JMoNlxAKqHI1AQn2X80XRI9owQ1gibL57a7yaWuspAS+iHESZgDzcKa+9uMC9XBYeVveJY+2VSuTrYR1r4KF052aBBhZo+HnYeQ6HPixF0r/MPw+reqFJ0krX9EgetascR63MHXzSfM+3nXsi8hLcUFdvDJivTnQ0CZLo2ZmWD+YHDKZc4XOr3qqQjNpnaqDcAskhEay/MCS9EcbmfdCgaAl8caqRz7egBJbFnxfUH34fDVomWTFnTdXyzGsvdpAAGvKpGCPHEJlmnX10VXozBs2xmh+r4GDWXoSRqG1tY30hVDFLAcLog8OO/eUcGz04xMt2Rv73u/oCGxhGGtZ5wGK+uMfNK5d+NKteidoZyyNmd6XK2ZY0KWOnMmf8XRxoC5e5EiqGt7c4wM+pEnqDLNbINw4QNJ41FN7HPUutnb3he/INpOVT589WS1H7hvZlkDMTFAoIpKzIXoZUHNPUJzEHnT2vbCVu2Ub1Q9pQ0qfKjoP24KQFNl8/th3w5SvV7UsWUG7/UxTDaXND3SFWWVlHRkJ/nho3pXh6UTtQjlI1fu7bCsz5dBt5KdMC2g1pskR3tYpISppu5bIpamTDHeWOm7dTymdcOWXkV66E7UgxKpXS2PJQH4jr/6j+o
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(346002)(376002)(366004)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(6916009)(66476007)(66556008)(4326008)(36756003)(66946007)(8676002)(8936002)(86362001)(33656002)(316002)(478600001)(5660300002)(2906002)(38100700002)(26005)(1076003)(6512007)(6506007)(41300700001)(107886003)(2616005)(6486002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?et0AWnfJJzGvP6qiQtj0u1Lh0oA+k6Rw88EwU9i/NXZL44qe4+sBcpRATuDt?=
 =?us-ascii?Q?Gy4iJIKoI4XvDkAlnMw0+RiCDbqweE2DXq/p0W20syNIFiov5qgAgrEc6cmO?=
 =?us-ascii?Q?8Zo5zzd9ezSH4g8Z6l8EDPCOIGiEu79LAohLg+5rFK+Bb/fSERpFfgctvMbo?=
 =?us-ascii?Q?eXLK9k8bz3P2t+7YBuykaFoWlQNYlkLL+K4Cbw6FFyjYSThRMk62FFGgdIBR?=
 =?us-ascii?Q?v3CxYA4vqMcmj7H3kzASU2sQp6crevOSdFP+XzfyOg1+67c4j66hkAdHNvLW?=
 =?us-ascii?Q?MP2thNqwxaoEX9t8FQYrRecRk3sQazK+b53ZOSEAKqWprih1/ai4ojgwVZRc?=
 =?us-ascii?Q?dpm2oj/YsNHdSBjozdXRRl9+eoBKMkMV9ha2bfoHPfgK4NKHCRpT7zr/dFIZ?=
 =?us-ascii?Q?f/gJw2voKfELxjer0r1yXWl8lh92j8CdJVGiVayE6QJMzU7eJ8gb1CCIJYxs?=
 =?us-ascii?Q?XSVXkU8qK3gCHD6FACjmJ/DCHXbV5JQWL4CWku6n6psFYDiQf81q9V5VT5ME?=
 =?us-ascii?Q?e3pcYIrYUuguVbSng6+MKCSNo6TeEKoOSdTDPJahLf/nu2mPz2c4CP36aNRE?=
 =?us-ascii?Q?lupv2/lpzDQ2y7cwBTfb3Dxpd+orpjcAiQgFnDygAGWtLYbu7RTKneB12BYM?=
 =?us-ascii?Q?MYIWA7DLonmkhMVzQIasHpVMBtAtQYY/iHhURp+YeL5hdXWxx+xo6/xKQkvh?=
 =?us-ascii?Q?La7atAAlIbrDJ9g7UnjkJ3XQLCMIJRd+ehfZNkCm3vdr2dJbC4uiybonerxP?=
 =?us-ascii?Q?fjOD+x2A1bFge8kYHTsXZs5dUrSj/r7u02WycXFjuq0v0nHc9EMichs1Se9U?=
 =?us-ascii?Q?JW97ZjFn9GV/XfEjH3Isi3ZmDeXuaSMwYhUjM2qwcgWst/PPUcKgiZtpw7Wz?=
 =?us-ascii?Q?7sw0PhKYkF6b6ZOjTjyvLwkoY6mYyCiJ73bERcjjhr+MGu7hnxdh+ItdWC+V?=
 =?us-ascii?Q?FO58vfNEgywQ2IYdH8TUrhPVuNErnOWToTQjRI8IlV0zXKPs/b9mNnKgCgQZ?=
 =?us-ascii?Q?w+thn0OssB3zMgzg8s9AAAlKGlz3EGff1KsLj1W0sCye5OOueqCFVNSSomQP?=
 =?us-ascii?Q?Sg0y+jlRlyJ6uvA76Rv/1ZMAbBoj9U4OzNtsIWX9EwcEdGmBkEtgHKi40TPa?=
 =?us-ascii?Q?KuQdsuMsahXXa3HR+8fG0qE6xBfE5cBoftyFzllwJJIcYrPgXIhviJW4c+ZD?=
 =?us-ascii?Q?qj4ta1eygHgb5qjgg4Jy0PprlS/ThIr8Q9rZf1Z5ZlbpHnmb85CA4zPFg2+Z?=
 =?us-ascii?Q?Y5jrIasSsuO8sTXm2Z9xj5DO5PMIPvm/a1trIC3o7E8jyYb35opqDCfOYJLb?=
 =?us-ascii?Q?YWvssyv1ChrEs0+ntdHKSspsV45gKGIkC4Y6zu0uw6bEzPsb0gfwKv85jm6G?=
 =?us-ascii?Q?uXpMC3R1kvFhehQitZcrQLx1AG4VVUmPYFROrvdU+ch1TM3iwTqj39/dhwy9?=
 =?us-ascii?Q?sFu57J8JydgoSma/0Ug5DDoe+idO/qODrOCHagg3FSk7uSV0Fo3V80JlyuGu?=
 =?us-ascii?Q?tBzm7XJThy+PdmIJZkwelC0ZfqPX/eyDnHpCnK0As5EV+qMMAgUCF0mOiNBq?=
 =?us-ascii?Q?jpSTGjnKjG7Vdst+O6p+OTMbCT0QosLEtluoK/9R?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 279b41be-d898-4070-ff58-08dc138caeb7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 16:36:52.8839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E038Gr1e+9wprtX9PsXL1rwU6o+5vI1akQxOws8NWmwptU7gsGdiSGLZOQdXGLXR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4133

On Sat, Jan 06, 2024 at 04:36:16PM +0800, Michael Shavit wrote:
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
> new file mode 100644
> index 0000000000000..59ffcafb575fb
> --- /dev/null
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
> @@ -0,0 +1,329 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <kunit/test.h>

I added

* Copyright 2024 Google LLC.

Here, let me know if it should be something else

> +	arm_smmu_get_ste_used(ops, ste->data, used_bits.data);
> +	pr_debug("STE used bits: ");
> +	print_hex_dump_debug(
> +		"    ", DUMP_PREFIX_NONE, 16, 8, used_bits.data,
> +		ARRAY_SIZE(used_bits.data) * sizeof(*used_bits.data), false);

I fixed up alot of these weird sizeof things all over the three patches

sizeof(struct arm_smmu_ste) is the correct way to get the size of the
HW structure, no need to peek into data. This is because we use the
struct as the pointer to an array so the whole struct must be
correctly sized.

ARRAY_SIZE(x.data)*(sizeof(*x.data)) == sizeof(x)

Sadly there is no ARRAY_SIZE_FIELD()

I also made some hacky patches so smmuv3 would compile on x86 and ran
this kunit on x86 - looks fine to me

I'm going to put it in part 3, just because it is new and doesn't have
any RB/TB tags like the rest of part 1.

Thanks,
Jason
