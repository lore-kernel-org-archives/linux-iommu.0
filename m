Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012018.outbound.protection.outlook.com [52.101.43.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24431DF248
	for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 23:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774309169; cv=fail; b=BDSdu+zALDNSI0fV03mSss4mxnJOxTsKAL5DJM7hwDOulotnyqWlBe0zttckB3/TsuruVEJozDF8b3Y2Y+dneAf37CgyxVgo6sGi5ApCz1vIH/VpaU8JF5wetNixh+7NoM6+xRIJAO3Mq4O+U/2bpDB+hqaL5jgOCvg4SxMPQ7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774309169; c=relaxed/simple;
	bh=E75o0yALzhimHVaCl4XySYPAgAaPFYDlgQ25JiDkf6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kWNLbCHHn0sSF/QfBrNNZ2JiGvQ7EI4npdCJwmlQD84n7ZuGp7n1+9wKh1BtEWbQuOgDd8/yLTtwdyC9lW6/ZVE4m/K/K4wbJCfSmqkkyaiSixI/OhCduubThhh6LxGHtsLzLyMNZUVusM4MvWIves9jbwWoV6L+Avy+PtEWbqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=joojDL9E; arc=fail smtp.client-ip=52.101.43.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="joojDL9E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cYpOYve4mzlUL3QzegyFOXH7m+8qheP0qiNt1cK/jNYeLYS4mSPsVLcGvK+3I8LF2LtOi68+LydMv9I0U0dAXGMjFGx2h2lfI+iWcOCr981vapUQwxf/3pIJK96LfcQaDI81O1L28YAhWsROVlVcS5F4pPi7Hdxcr8bx4xlf93eXgTZITsFyy2N+OQvR8yvxHE/PCgVyu5RJqN6oh9sfxBGLBo1/yw4PpycivggdFrymOSqlzNaM2CI78Ue6BqG054qao4TQZvUNPhEHUhvTfyJlldnP4Zrij1+IAEcqN31z+g9TosgAal3w4QEK2kWMeNVxR3ktQTzAet61a+6vXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCuxfgLKJao9yLUDaSFwGGWkoQ2g/tJr6VMY3bUvPbM=;
 b=FTvkSZ/MWDTY25Abrekaepoi2tI0L2BqKbDt77Lly6WD2jc+/vJ4BScV5R9NkH0SABIA2lJqF+hEyQ1il+EIP0qkfQO4GK6Ot9Kzc4rkC7RV1jNzXhmrow0OvWlC/PClowgaNUWWhPwBqKrcOosFiL+00qhHc7IJ4OKgjw09lu8EtLyFyZSYM08ChAAauMYFZJLFZqWXD3LNfpYfXMoTmlOr09IL1Pz3U6juacVZLq1q0kOB6l4+UwI87vvwuQHrcSXXtyAuZjObMqIIEo/ym5dfJecGF2kXoZL50P/vwtopk7tRAChq7r6eGwV06DXSf51ayuR68iqqndgQ5qy9lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCuxfgLKJao9yLUDaSFwGGWkoQ2g/tJr6VMY3bUvPbM=;
 b=joojDL9EIwKjmh3Pmt5PmnBMKvhS5sYcaNJA3OiXQllRM7va+bFBI/eP+Id6D9BnrSvBp2hh9ynK3xBZYZTlzOg1CYM1H9tAyrp4OBOeL58h4H4eg+USXg6NiE9KrVJwLOOWhbeRq9lOi3oEQ6VRhBqh29RA0XQWRomao27u05wAdEi4drMkFix58YfClxATxOiPOEFXSWbHCXhcBC1zHXotwZ/0O7/1hejZPbT5Vmw89Z2MWpMmSfC3zz8EVPCXblwqHDuU4VKQ4K3tkwGATHAyIPvvtZY++nE4bzLNohkAbo+Ku+tMs6g3LtG7CxCKNUgxTFfXDRUQuuX8tXyH9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN2PR12MB4486.namprd12.prod.outlook.com (2603:10b6:208:263::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 23:39:24 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 23:39:23 +0000
Date: Mon, 23 Mar 2026 20:39:22 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iommu/arm-smmu-v3: Do not continue in
 __arm_smmu_domain_inv_range()
Message-ID: <20260323233922.GU7340@nvidia.com>
References: <20260321225041.11090-1-nicolinc@nvidia.com>
 <20260321225041.11090-2-nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321225041.11090-2-nicolinc@nvidia.com>
X-ClientProxiedBy: BLAPR03CA0060.namprd03.prod.outlook.com
 (2603:10b6:208:32d::35) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN2PR12MB4486:EE_
X-MS-Office365-Filtering-Correlation-Id: beab67ed-9594-4b33-5da2-08de893569e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003|3613699012;
X-Microsoft-Antispam-Message-Info:
	XG04As+k7mlPAFIrtQvjIxo7VLadLJuPe5lN5Vlv5kZGHUU0jEtTXdrVrAyaX81Dm2YArWSAV8H+jdHOiTwZGLwiNg0bTid28nSB8R/zu2Dqwd4PBCsmsNVI4AX/XHh8uIcObHlFZawzUKHtEIo0zKvQNVWOjvMERoAl5mfDKESdqqOKxfSYmVUy9OqiZpQH7ARh4Oc4cOC+6tz19g13d0YSuePwvqfIN7PDHBHh+axdZPzPF5TH06zhRBZaDx1XEkUCobrdj01NQVljibfiR8rxEOA4bN2keB1CkT0x6EXdrpARGpS21lHfaJugAAnuYY3Te1Oo0e1tizWDMzhjWwcQWIeGyEX9Yzq5ktgJ1NscDIgT5cKxA3wFVZuzV8amD0r7+dsTDenPrSdWqOeM3ntPfJOuYqX4evetB//0UcdTLSMjIJ5IKlFmJ7hbLunidRUMdws44XWJL/kgb+plV1wfdgwCTLDSmHElRfnUk8njZ4/8mZbBHNzhbzSHh16xES92mIDYSlLpxdVepWfCjnQoJiQRkEWfaXVdVN9JN33XZ30oQ5E0wYoYLuv96F+9+4PBGpKevyui6MX4Tf+fdLAasd/beILVPWp1Ur8thrAZHceVGNYXUudVk10maLxBen5WReBwgfy1XDbvsSTOBf+GkIeBpGSAxs5rRG4dnqDM+v+3PqYY7lSaJJKNWNRHfgSID0aQPwrUwL0YMpPgdnPlR4XK8198QJMV8kfgMqp/JLOARFF/lDw6DAu3WJWp1FEJAJEZWrFkTUSQrUcgoKJUJYfoOvk3fqdzPf8f0Tg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003)(3613699012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YmaeWMXdexZwLC9jwj3ishbecvBn5E3aeT6HjL2WFwc4Hmrv8rK3sahZNHH0?=
 =?us-ascii?Q?pbQ0e4w2Ud3LcpcGh3Z+xUjX22H2FZRSlc9dGWxxSQZcGpmFlrWEPkPYNqC7?=
 =?us-ascii?Q?T/L5Q+pcFj9e2U6vkbnQT3BhioqheNNQwAGVZjuFFw07MZW3UNUKRI1zaSeU?=
 =?us-ascii?Q?sCVfJdLhg8kdNZcMIConHu1tjZbXN7jabB6/0CFrpfYOFXeDztZVvszsg33a?=
 =?us-ascii?Q?D0wPNMfE+cWiNdymPPw8xinhvhH9VfEkiC6/N30ry1cjS0g7b4pb+uA2+bVB?=
 =?us-ascii?Q?VUYn6xH5NyyEjJHs/FOAAUH7BzPX5Q25Vpzz29/I9rx4VAXGC4RtARPAmiW/?=
 =?us-ascii?Q?1sPe42AjaAd38a6N+GKXrytTVWbwe53f+k7QBKVaa8/TYbmvfFlCEo2Ngm68?=
 =?us-ascii?Q?Tz1ZLURVx0bSRIPoYdFGbr/KHPY6wa26g3iUUvGJb5mwlQ1xkMwjloQdIU7T?=
 =?us-ascii?Q?GsvlH2lTDATjv87j+u7tOwwbwRXDhVh1+5Xs1cZ1fLQ9u18p5wQE5NjXCdK4?=
 =?us-ascii?Q?EsSDjTnqyTY80baidTLV5SmyqRzhWGYalZoywR6W2/JerFeWQh4ScXxYfJSM?=
 =?us-ascii?Q?2W12FPbbdAtE+Ox0Bjv7IPNCzuYVnWeUkrzrf67OBoiWMjh/EvhUi8U8S44a?=
 =?us-ascii?Q?YTCbAZwxRZmKzklNRybLfgulj+uxMqVMemmvYYBg7thRkRVwkRv+XUcIYPIB?=
 =?us-ascii?Q?M2M1kif3ePO+24Y6YSufFqyRIiFxbh8OohTkjgpdMLLqG5KMWW90I7b0xp+c?=
 =?us-ascii?Q?gxnhucQ9sMygoKB55KFSPSNPut0Chj4T8o6GO5s4jRkgwpAzelQBS02mHTrR?=
 =?us-ascii?Q?WmhfmrEwBkFtLdr6S369nvDkTLOk+I30InW4WFRFnGHl+zDtT6+lRfgwaeUr?=
 =?us-ascii?Q?avuivAjt9PBZRxraQFVnTnSbwcZ0Jasex9KUFwGUaWxSiHLjjtDtleQsrz/d?=
 =?us-ascii?Q?96OsxBcQVb71wxPrrFpcNbEIzuMr7QUhQIJQZCzoeP+GBHGlh0oOicYN5itM?=
 =?us-ascii?Q?/IlRUmzz2dIAoCQDF+yo/TgAwjAzBC/+gwzFU99f9DtuLg5gwNMnfvYvOg/i?=
 =?us-ascii?Q?LBpwXeNFUEKKzahGbbxXTR4cDYuC1Yx3pFls2enMhQOIXzJYaXQXs7pda/DO?=
 =?us-ascii?Q?DJ12N7DhKwnmgkzV4BkNtHpRKLz6b6K86piV/d/gUTfItIuCFNtZRoBxlNXL?=
 =?us-ascii?Q?DwS0Bd7z5FVmMDcFfF0GR2ObgJ6iN0ro89ybh4hIXQCi2choa1X/aC6wYhdh?=
 =?us-ascii?Q?T1nKr/ASpj2S4Rt6qFo+E5IDaS7n5EfGhp9QL2wxd4UavctNn2agusCeePm5?=
 =?us-ascii?Q?r7nU6Z2dDh9Jnaaiwrlu1MwtygCR5NKtFKtDCwLsgqbPvVQSpRpaYBvlA1ME?=
 =?us-ascii?Q?ybTAOpYUJhtvuEFyE3HYF7POsIkjnTupb37atHAAmI5uXghOr6jHpzMXh2Ox?=
 =?us-ascii?Q?w13bl1B9IgzXiNGKWGlp7YglINKBmWAD8uaIOTjlTBt3guL5+6nnqTzUQGzD?=
 =?us-ascii?Q?4OwUELzA3F9RwaQ3M0bRfJQL1WgmaLuRBSZKRDLr7PB9IgPmPytHje6YyGJw?=
 =?us-ascii?Q?cfWExZvH5+yXoeF+ca9J7bP1LpyKFIMDT0a9QWge+GyMlHS93jbK+JkgaXRQ?=
 =?us-ascii?Q?kss300C5umkZ8FSOcfFlHTAex/36EIBbsEDOk3IoYK5uDNZo+1Tc5fLWOQ60?=
 =?us-ascii?Q?LEoyePEonGPCuZWgxgMbq3ibED7OpFBscYLuJxG5oJ3tC9/v?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beab67ed-9594-4b33-5da2-08de893569e7
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 23:39:23.8603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7sb0q7Clf9nINDj9ac/1TKIkAmoQg6ssTL3hyLqraqRLe3XG+JrNW7J1OmkhDyKq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4486

On Sat, Mar 21, 2026 at 03:50:40PM -0700, Nicolin Chen wrote:
> The loop in the __arm_smmu_domain_inv_range() is a while loop, not a for
> loop. So, using "continue" is wrong that would fail to move the needle.
> 
> Meanwhile, though the current command is skipped, the batch still has to
> go through arm_smmu_invs_end_batch() to be issued accordingly.
> 
> Thus, use "break" to fix the issue.
> 
> Fixes: 587bb3e56a2c ("iommu/arm-smmu-v3: Add arm_smmu_invs based arm_smmu_domain_inv_range()")
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
