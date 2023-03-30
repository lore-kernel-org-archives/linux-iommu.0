Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25CD29B0;
	Thu, 30 Mar 2023 16:49:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DoLpqos7JwCyf+rwQbwy6nM79Hn0hidxUzgGiKqyT8aDr8VpLWcUdfX7uaKyOxsewBgY3V10UzUYRAyUe66sPCPv2KAePybQXwTF+cu1uvlMrMkaCriV4E9IVtjlsdUqe1MXALBWnsHiujWkQYGcJ9RXX2VjDCkRPSMrjLxDfgwoX2eR/0NTWBrHGZxznnSyaMbPT06unXOhGpjcYzHZMwxcgQIpn62E5oiywG4inoLU9nO+rzUecm+3b/rNY3K93pxKxZY3EM2TSTItowAGwuGR8QyPTCeqIiGwX4m8TXwbKGC+oOMJTSmBe59eO/r5pHDbifWE+37cNjl3I5S7Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUCl/+NbER967vINvPe4FEWnBgNM6glbvE2FD63J88U=;
 b=j3secMUtDwcVc/WWjP6y9rKK40mJFPzriuSV+12fIMcZSq2DROSwmkmJo5uTJoAhynHL7lUA7bzLMtrqmFfS30Iz6E6RmfHKIpBUeHv1g5OpQ/xNMbDa4cIlPgDv4GCjuRM+EvEBcvqcexYMnGJHcbgxg/CdvpkEOjVXCkwV/TB4vNlolJYa5Gx2zWjWaG2gqrvnIOv8vvg9k4hmFIytrTs01TmVG2/4mtfrBL7Ags9by72QroVsnDUSKWlfmyq73bmjRkW6nCapw74SY+O0Q0myyNXkAPV9LSLXOtNs4QqJc+Su7R/I68F0sdpf7BjdtakhvCg1I4pKlMkZYPOvOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUCl/+NbER967vINvPe4FEWnBgNM6glbvE2FD63J88U=;
 b=uPZlC8BVvbfVo9+W1Q+DZinsNFlDiGDxKPn893+lZLoR6WSGgEp0/slFnKKMzoCqRqyq4H0h5WacKpGWH97IDZ22K0/2bF6RjNARyLHavqIS0oxHC9E5jS97Sk+C8FN/1Ui/OHsCZcO/JGT0jREOD3ohe8/OW6JCP4DUzPtSh1utn/p3wg2pWDaEp6LD6XfGovGuFCBx9MFpwALVstI+jydYT9TX8/Ja6bIGbvcbxzO4jCw2pmu5tYCU4Z8eRzicuS1SH3s2l9wQGefFGRrx6RsN3vauuveHth6KCy/V7jlzRDvH9WTyBWIdISNh8oKvAGcb/x/qw0Rg/0vTykgfUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB5761.namprd12.prod.outlook.com (2603:10b6:208:374::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 16:49:34 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Thu, 30 Mar 2023
 16:49:34 +0000
Date: Thu, 30 Mar 2023 13:49:33 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>, Tom Rix <trix@redhat.com>,
	Will Deacon <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v2 08/14] iommu: Make iommu_group_do_dma_first_attach()
 work with owned groups
Message-ID: <ZCW9ncbAnoWsaN+W@nvidia.com>
References: <8-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
 <6f0e39a3-3a46-f9e3-614e-e6e3c88b59ab@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f0e39a3-3a46-f9e3-614e-e6e3c88b59ab@arm.com>
X-ClientProxiedBy: BL1PR13CA0387.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB5761:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cb88949-4ac7-4fde-2358-08db313ebd64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aP0tSO3DcvTqxcKj0VElwCNDYgSdB9R3U7uLqp7r0LIXAMEbGAVIZqYD6BrTBuxJgRUO3KOHFV7MKepcHKu/iKsKqTMofNEoI2GqFtuSHHN3ffRQ/+xAqAT87ApuKuZSqyymbiO/yDYTKm6dCC4CaQoIIQV+kesMSDTe+/0TTx2GXLAE5F2B67ELjibirwpEk3OEjelHIzX2WoP6ANdeUr7UZkwx1yGW7DH8EDNAJej4oz9UsbeVi1Ufw6EkD2ieXxkBIIkETjYqGQA+zoNFscKa+q+XbRc4gh5efmG8xIM8uwRsPP43jK5ZvPc5e+BYBz8Zc6lr8LL/R50iXEQwKL+TOqAQHy9btEq4S/S9OnjaIajF7YkGTCKfEBlKn1IroTM+ADAfkBVmQf5JrY9Di5fLnJBAt4HzUcFX2FwOD9e/pJ0Qi39Cp/U3BSpMJEytGT9K6q9hP3kV16x7WTbEs/PJ3d6yHXPcNZ4AAJCD072QGuaK9g8J9jFPhkN0PvE6S6z1uP/NJz3aIjtL/2jAtogSImD1p3b6WvZ3NnAiXt/UJx9o/VRug1i8DKAwERtqkIZV5BH26WUk10rTtM7VYel4jdaVQxhJss2iY+sA8YWsxpFVZ/rdWKHs+Z1vAj/Fz2q/tNPOX8mVaPtMtsLW3S8pQmLg3moXfZ4g+jl/bSo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(366004)(396003)(376002)(451199021)(2906002)(83380400001)(2616005)(66476007)(5660300002)(6916009)(7416002)(478600001)(36756003)(41300700001)(316002)(6486002)(4326008)(66556008)(54906003)(8676002)(186003)(8936002)(66946007)(86362001)(107886003)(26005)(6506007)(38100700002)(6512007)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KW7lLAatqpnKGxFHaU5LqHB4Z7eY8ErjKZNJNM38RgW2FvHg1/Qy+sSPli47?=
 =?us-ascii?Q?Cpr68GKjwww1ghCln3hsiuGYJAU4CK2Kl6o86TjlYeJN9J3Iz+uNpdCHVj3g?=
 =?us-ascii?Q?hgAI7oppt6OpdquUkJdQJBcmIaFElh8VM6xUOfxJ+Prves9Up7p/K9kqcoZl?=
 =?us-ascii?Q?3SgEZ76TRxBaJkDX+uJb5WtTl4H+Grawb83NWviUAOP/C3CT0nWwBmjp3482?=
 =?us-ascii?Q?Q9DjbQUGTCDXizOZBJDoROE95SGtxPvhm/Y7jgDK8CYiyyX9DYpjHwe/iUgI?=
 =?us-ascii?Q?Nzg/MBd9vrLO4IRT/IYXeSfczuwaB8yXQasD7hkYcY47ML6DhG0InS3eXAE5?=
 =?us-ascii?Q?lln+EgPBOKosGcm0xBsd8UNTo10WWdcyKHEnuoFZIbst0p8clA7T+2rHJrhW?=
 =?us-ascii?Q?jA2dmZzdqe/HxNi0xFbMchbLpPA/Ne5SNunOUvSc2k/aNIL062Ilzi961OM8?=
 =?us-ascii?Q?43KgFTzKRG4RQhjbSPtAsbo38n/do7w7FSjgHl2ifBNvH4RFes/T9CbenwUz?=
 =?us-ascii?Q?V4zfUPYxJa50cOiuc/NQEdWxk7jFJ/gZN3m+CycvkXGGH5x+RqmU8wxOHaNC?=
 =?us-ascii?Q?DKIUc866g4gsPL9kamBDBpEQMoWdEEWwIasDyyDN5MiajmHB79sUfpnq70jL?=
 =?us-ascii?Q?crgpMN4RtJmtSvtphs9l/CChCczS9FAIyB+gcY9N8Q4V4mN71hebkDy7ltHr?=
 =?us-ascii?Q?HL4xCHt8JHDCktlmxdlAt6OSEuP+Daim6plVEsXBEY0TA/ZLzzMvqzXklOUQ?=
 =?us-ascii?Q?q23RH3NuuTVjp7nMiOEF3HYOgKA3nqEMqVYpyB6E6o6pQ+QnVF+uFK+6Q0JH?=
 =?us-ascii?Q?54eAupPADZUULLIg8jCbw5JwED169AwQ18JQX7lRZtKPIv2619YhEBbo3lNc?=
 =?us-ascii?Q?wyHGa6bDNNMuwFZn4bTLI9cAJI3CrUyoAEG5RcHAsMndpg3bkg0X4l/GCatE?=
 =?us-ascii?Q?Xwn7iIBdyV64X/TO2z0CIgw5Ev0wgtfbCqiA0+asXccEOZ5mh/0vJn/r1F46?=
 =?us-ascii?Q?TBWabi2smrlZ4YXMY9nYySXtQSi0nho4A9H1yHirjkI72uyFnKwmoDn7ALfB?=
 =?us-ascii?Q?ikkMx1iQTaZEIgZ+lieJ4SvQ42206Pi2pEGlXZrsmK66qJQOcvtemV52GH8m?=
 =?us-ascii?Q?IGfvDGxUE5oDDl4A6kH4OenaAg2caiDoLk0CF5xux2O8osCLFIMXJOCNp+E2?=
 =?us-ascii?Q?/x6JN/579L/h8uhVtBFaz6FHAq4TFGJH3tzdh+EBskUBWpCknZB2Gfsj1aTT?=
 =?us-ascii?Q?VWGImzlObSOVuQGIBWZhmuNPgBXXwR+Hv149znmIoBmE2ZCLZrAnmTBKHlIW?=
 =?us-ascii?Q?bRcWssti+ffCuPLJZ1cuhsssy56pwOASjA0cqf0tuIJ6B76hyttvkSNhTqpf?=
 =?us-ascii?Q?dr3P6SQ4dG+G0AfS2Nkswyxdd/svyu3CkRSYla4YrL/fPjuWyMujzoDz1G1w?=
 =?us-ascii?Q?32rbUHU+xSVtvpqX43v9k+JUjiCLPxpYnuzWCIdCnfQFDtcIy9mRL9smnh7W?=
 =?us-ascii?Q?3PSFaJRzi5aSdKx++j3K6/DVxxs/gdBnzc8rY5i0Pfg9oZRsw5A6rs0sN5Ny?=
 =?us-ascii?Q?QP3v7+8pSGYP9//YAfVefCLxAx3rnOShUoW9Tc87?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb88949-4ac7-4fde-2358-08db313ebd64
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 16:49:33.9978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a8W9GZtipyvkvoZ6QenkoqcYgWQt7EDdP4lIVQKJK00RYKzd8/a4ykVAS4tP7WPB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5761

On Thu, Mar 30, 2023 at 04:54:27PM +0100, Robin Murphy wrote:

> In fact I struggle to imagine how it would even be possible for a device
> which *was* present and active when the previous kernel crashed, and thus
> needs deferred attach, to somehow evade bus_iommu_probe() in the kdump
> kernel until after the rest of its group has managed to get as far as
> binding a driver to claim ownership :/

At least the Intel driver seems to use some kind of global flag
VTD_FLAG_TRANS_PRE_ENABLED. So presumably if I, say, get into a kdump
kernel and hotplug a thunderbolt dock I will see a hotplugged device
with is_attach_deferred = true?

> And even if someone did manage to achieve all of this, is it really
> beneficial to let this device start spamming IOMMU faults and/or potentially
> corrupting whatever the kdump kernel *is* 

If it is a freshly hot plugged device it will be idle with DMA
disabled in the config space.

If it is a pre-existing device that is already running it should have
already been handled, like you say.

At some point after boot the kdump kernel is no longer special and it
is just a normal kernel. It should be behave the same on hotplug as a
non-kdump kernel.

Regardless of the lack of utility, it is logically wrong, the code
reads wrong, it is easy to fix, and it doesn't harm any sane system
that never has owned set in the kdump.

Jason
