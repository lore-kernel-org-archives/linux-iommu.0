Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011071.outbound.protection.outlook.com [52.101.57.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869A23C1415
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 12:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774873220; cv=fail; b=SkbG8LK5lpR4ZaMCOQ/JEYTAQhgU6BMiY0KkE86biJhKoqSbFFZ259taEtGnqtxzVhAts8lTKN41Jd2oCwdb7H6AIObHCqExdsdyUQKQpDWJYx27ov4MxFO7/1nB37JzAHzsZPIlzKoS9Y8h/1lJcz4K6BbOOalTLRug+dl8SPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774873220; c=relaxed/simple;
	bh=L1o6qI4h+uus2uqohF5NCgcYWC4oMClEZ+WCOs70kaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XiD1NEPcEn+p9Blw2ZQHRGhy/UQ1OUB85XXNN2ii8nxKJCNjr2RJbkeTWXdj3keO71W12wcSpq4CytpYeBSw2Xy0+pFo3a88KSfVFL6Vc1C6F+cwxbodVL5PZMRL6eXxWJ4v79x14Nt2djjtCWBAvidgR9BdPM6/7ACjZhTWqME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dCcUzurz; arc=fail smtp.client-ip=52.101.57.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dCcUzurz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WbLJd+fY9CYaVYPaaL8ifeyy/gILAc5IgIEmz/1+5CTjSQyYbd/zwlqbFsTRL+maY9qK3zxWeE2qshiAHTaNPvPqvw+qhZuLi1Bcb18xfoPtkEMvAXCoUh2oISkcKF2CQzKcaBi1FDwnHjqJFeQDNsUxgd6cK7oZ04hyJ4GLFDgXFYg74lfEmgnwvPn++WC0OIoS9qK+vKj3OVKP0CKr6p1h+SsLxQwXHEX1KNv9Yy8ErDLO9JE7HyaeMgBwoHtg2Ds5gCGr5sNMQsSA5NdEq1TsvtItDp5xD2s/2BtNCOYYsF8WU8XLCBGLU0wmUtMmi3bxwF8MaJmVamFbxDOzYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJLWcbdLt08r/xMOi1Vq5nMFjpliIsGHcMnABjU9eMk=;
 b=MgGZl4gMdT/Dw+U8Bzk+vnvo8nITVyieCJT7iBaK7vNzFdzMA9uZhVNTKKGzbB8gKd98mQOwWmJoiSVlWC5T6Gd9bh3kwqIu6KXySYM3Nivuaf2p0kGnV0L4yrvu1ujItDyBxbTvUEwvaewCvsOuH2xE0kf5VjqbUwE4ps/HIJahUvFR2E5HZ3qHfeR+wiecsDpk0NUEyO1lWSmzux6claUWvUNFSNkLI5CB6QNYaNwLSS1dT0CyRE8eR5tyhLCuNrBYPAfPjNDmwVetUDNWTG3ahO54QG6Nhi+9tBkLZaSwIlgLzn4AeAn/Z+spsEe8cTrbGnvZk0vEKuBbfSJyPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJLWcbdLt08r/xMOi1Vq5nMFjpliIsGHcMnABjU9eMk=;
 b=dCcUzurzpBsvep0PmTwaEiMQJSlMsuAQYtZPI5d1BXJnYXzxomSjs9eNiLCB9p0yZ1o3UJbka/KNPgyeGTofM05EnRCm5uwhSinir2JHFqC+GIiVBD7p9xvtQvGvG5nKNVbjzGKd6H+tedi/kCM5CV8M6E/iOmd7kSmPNYWt3Bl9VrK77aXK3fZWu1fJzBx//DF3dudGYm7hAqGhVHxcmDVABBGcCz8mkEdR5JCH7/5udRoxBIH4+8/XDZfr2iafkP67AJUplHfmgDtv2xtwMc0Z5szOFBVcqDxwAyRSy+Vs/hKGb/4cnYj8WMzhW1MBZFQvbdCvnfmxKuaEo485Yg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB5806.namprd12.prod.outlook.com (2603:10b6:510:1d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 12:20:15 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 12:20:15 +0000
Date: Mon, 30 Mar 2026 09:20:12 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
	vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
	sairaj.arunkodilkar@amd.com, jay.chen@amd.com, wvw@google.com,
	wnliu@google.com, dantuluris@google.com, chriscli@google.com,
	kpsingh@google.com
Subject: Re: [PATCH 09/22] iommu/amd: Introduce domain for IOMMU Private
 Address (IPA) region
Message-ID: <20260330122012.GG310919@nvidia.com>
References: <20260330084206.9251-1-suravee.suthikulpanit@amd.com>
 <20260330084206.9251-10-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330084206.9251-10-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: MN2PR15CA0037.namprd15.prod.outlook.com
 (2603:10b6:208:237::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB5806:EE_
X-MS-Office365-Filtering-Correlation-Id: 84a3e125-d81c-43a5-ea85-08de8e56b218
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	O96EK+dulyJdx9uZkCGlIyquqZHcbscWAPPUUUI6tJ7QxEIWYGbELXGG0nH3ofjc9z7ZQ6WSjObwyCeV40xdwUuzBmh3GER0mCoKbXVe1nRDamnWMK4zp5cz4pm7d9SPArDfGcHcc10MYbxR6/1PyrjazpE6xQyKQONoI0bvKbnlhPxlvorLnNxZKJ0p2jk1Erd7NIX0IBqoI1vkUTdx3bd8siTEC4r36Vxp3AoJl2gJUtATZYj9N5D1ITQRm6g0+G1PKIFMlViIrKJQuxksU13LO5kqAmlFm6HLtpfnXxj6FsBM60jwLj0r5bnakF5ohh9sLfMrIhWZSYKAfuwHwnezJOxInciIQpa9mCn3e1ayTrTPboKrB31x6HN9aa8/eOQf5SUYOLSu/uRBTfUdieOtlRyjN1AFTqsu8pFSiAnUVTC6fgrO3jIDK2ydFCR4f8IxEVPOUCaICuvGrhUGZAGe30ptmlLkqjlX8DU2PICCSZ8ftusKcAql/3gVAgeGdrfdLq3Zo69ovdLXDT/wxW965Z0/JVuE4oBmIMkMpBtYyd1gQAtxuFi2nq4Ad4Ns9JEy1m9k/DG8ZVWPeaaYwEIip3QuOjL39eUMcsaZV82r6IXxVDYxCw8CtbuauYKP+NTtuxvg1W1TRjhKSdWp7AlZINEYjZD5bgaFhOIv2EUSxJ8aHq93clHksSwiyLxHPgmY4eVC079/fS52aA95KZ2s6ECyZZ4rV/+11vemHPA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6df0+ygpCCHRwFh98ZhCetlBwdr+G9vOHQzSkJQYHP8BuNe5+9AZX6KamR0j?=
 =?us-ascii?Q?kV/947G4ujYjvQKhLv+fpWEhtt/u6ZAK6icudsasYNdQ7/+eDakHaHJ7x2hq?=
 =?us-ascii?Q?TI5GOFv+NHJyhfV44qs9SUHJaB6KNKYKPR7B0up3zx5pFWg1gLlvkhxKYF2J?=
 =?us-ascii?Q?Sb2FhB8DuQnVoyCd5ZQDAZKVF5OnZWJo2MQn/wB33Hc5B34mHzidvX/9lS8U?=
 =?us-ascii?Q?k8G1zCiIaVsckka6CY0z2ahORx2O5ApPoqWtP2MWh0Nq8IXcwLb4I0b3i3Hw?=
 =?us-ascii?Q?PbRurvb7bfffIv485dFU/WpBlppj4T1Bi5NRHsXQIuovXwJHVw9AmbOzNohN?=
 =?us-ascii?Q?k6qLhENE9o+BX3AOmudOLREUoz5f5+ySVGfGmuhFfKj7bIW+3aCpjXj+/jhg?=
 =?us-ascii?Q?AWbdRdUamgDNIacCEkX8qCSo52vbN0WY5+bf2Axn15Nj3RCiDK3mkX+vgzQH?=
 =?us-ascii?Q?jMhKbHPloek4hPuxzGKnBOmGJdWEv1k/jkxKM1Lm7et2hXxxuKTnpvjkUSLC?=
 =?us-ascii?Q?j9KgeH8Tf74fmjiVpLQj1gNR/+4ARv0U3MkB8vbphWWwIzuJ7/1ZOT2GvZc6?=
 =?us-ascii?Q?XlFcqeBNcbWa2I5SFUYET6JiXO0msox2LK+oK2B/ga6cnoM7aFNfF+RlKvy0?=
 =?us-ascii?Q?k6mN5+ukh1NIqKmdNxqr4sr9ahHY/20fGc7G27/CFVS37vU9nEaOXK3XMhX3?=
 =?us-ascii?Q?qtF2K2irCRyqWwnjku0i89OjR3MfsO0hVdR42WgTfoe7daje45PO1jA0EjjI?=
 =?us-ascii?Q?U3Y+AknuRcSp/TAXCkKzxPT3MRJpFj8zpP2KzNjEMB+5Kit0P6GZzubmWqPx?=
 =?us-ascii?Q?SFWzlt61Y/T7hm5HYtvIld5Oh9rws4BKtKwrLscUo1WSwCPKYsamEaaAoFyj?=
 =?us-ascii?Q?Gp+h06AL312PJ5oHRfXCeQjxCZ8w6xL9IMnSgecWNoNBvMjoOzsCj+AzgB8G?=
 =?us-ascii?Q?AIKBZsOY0BuGBZpwqAMOtkVF3O9fR/EYJte6WVT6yJlwvNBjp5JMe7ixrHgw?=
 =?us-ascii?Q?yz0GKGqpuV+nu8DVZgRNzubAfYl9qcn5jPOVmPgwq3d2JCyN5Cy4PPPedqua?=
 =?us-ascii?Q?ueNPvCywJsTqU+LhLoSTPyc5cBtRkNBL2VidlaenfFxioZhH3TIcqR3HVLK1?=
 =?us-ascii?Q?TageCexJespfMwEiX/6iZfNtlUUtadKLlkx61g4wVPPNqPArCMRlWtbahKaj?=
 =?us-ascii?Q?vfY3L/UL+NGEBX4YjRWisN1CTc2aQ+eE3eC4DSuI89sTIq55hzMOcYmAbFC1?=
 =?us-ascii?Q?fogF91vHTVZf4tOugkUmGQPN5EaXQmBp+x5Id9g2p1M1mRQ/gK+9EZWIsyKE?=
 =?us-ascii?Q?vPq//8MYj7aE0e+VGiwGSiFCHSixHhlxJPVafayzIX42i2ALei11KKJnpLlM?=
 =?us-ascii?Q?LTSniKim52bVy058mnAv44xWb9CLOIFIzSNASxCmmu96EncO7nTT863AhrQY?=
 =?us-ascii?Q?C6LhKD8x9flmbUrncF7lAulnrJARlnikMjiSqfXREjy0LvQghKnMslMdbhi1?=
 =?us-ascii?Q?DtZTsksO3npW7+KINvDgFCK7J5qAGk/dOcqE1K/hGbLssAbwXv9dVk8UqYUp?=
 =?us-ascii?Q?oCDvNmN5dDOulyWmROY1qih5xaPA/U07k66T2cHLYkr7UcpjLCxNtcPtFb8h?=
 =?us-ascii?Q?04XcgiPwgrmZIMhsbk4KplkNfydaFpoqZFBpHkG71oLVD8IWeL3BwvD1UMW1?=
 =?us-ascii?Q?0d2sc7xwADdShriV0ujNWbwtj4X7mdojTaeKT56G5elsMOSX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a3e125-d81c-43a5-ea85-08de8e56b218
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 12:20:15.1560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rFEECSdTzq3AhxzRmAfH14KHQqWfOyPWciq2cX8laXRvipXOxQWv1RI33EIcvwaA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5806

On Mon, Mar 30, 2026 at 08:41:53AM +0000, Suravee Suthikulpanit wrote:
> AMD vIOMMU introduces the IOMMU Private Address (IPA) region, which is
> used to manage data structures necessary for IOMMU virtualization within
> the guest.
> 
> Introduce a new domain specifically for IPA region for each IOMMU, which
> is stored in struct amd_iommu.viommu_pdom. This domain uses AMD IOMMU v1
> page table.

Why can't you use a normal v1 domain with all the normal existing code?

Afaict it is not special at all other than it has a specific dte index?

Jason
