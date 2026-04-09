Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010023.outbound.protection.outlook.com [52.101.61.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59865371D11
	for <iommu@lists.linux.dev>; Thu,  9 Apr 2026 23:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775776678; cv=fail; b=AcyCamcnbaMa0+0TePYgNJTTnpURWIKupbQnWz4kD8B43TCpHI6UWJS/Gg42pHV4JUTyQF0VMnuNTg6qsWyeCDMW5ZYDMXot4b+CrJXlWZ0N31lyU+1iXtB7Aq7KmGHGGt53uU98pJKkDZ1aX4lBbpDbzuc+8EhB0IM+8MH329o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775776678; c=relaxed/simple;
	bh=1Q27BfxCmBsBOl8r3iBRTJvMHbLrsSwCu17Te8yKuC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HcdukZvbRpG8BeM7C3sxne90IGPduJbOR5SsO4p0i+U6RRfdUpeONM39/1pGRGZWEXHCi2NB3BX13EAFQ/bzjy+Wt1MZXXcAWyYM6ayGaYjqA+oi3ZfSZ9Eb+39vVtPLJ/vaX+TzXTzP9FeOroJDhiYZJSF8amperCnkhNyNWog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dDIGKY3w; arc=fail smtp.client-ip=52.101.61.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dDIGKY3w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IIl7QqZN5Fg1ddngBpozjrt/XB8Y4S710UBbMSOh0gbf4ippnX2hgt88ib0BMiz/D3LjAtyzgg1PlzKiOVIwgrPdmJq+EohOwF9m4AK9/c9esrUaHB28diTIedD1Pj99fToMqyWOtytYxDXVxhZ/V0cr858jhzVxa4ezilBTXeecN/LwFOb6eWvD/cdm/L4POoO1rShESP2TtUi7uTxXyZMysS2DnjNU95bzlWzXq1Z0cpNkhDHLtBlEpLPrmdF0gS3xdiem0ph9uONKuQzHroQ9A4f/UlsIzz/D3p7xjlGCNFMoN/HggK9VqGt+OFQT3nUVsj2sBYuXBc1yMBWyqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=va1h+NHUkYUSRoQytb8hQbTiAWlModC8/3U3lOEk2yI=;
 b=HeMthjTQh10Nj1YpC8NX6d7Egc/zbBwY4oggfif8HjCDwBNARcshxaf2QnAZi9NFMsnCFNhGjFo+nWNbAgZMdrX8F9af6lkGPBIgEdxGPRtx0vkKtzR3Fq1CMDbRMfxL32JMBf6jQ7P5yBGNpM4xNxZ9Dh08pOfj941fHgEbVlc6YiYKLBfN2FRb1shgz2An/Bl+rOQJI6O09XaK1UDsfqr5GZpzIQ5+aH54CJttvRm117sEOmNruJNs+2/3tiOKF2Q1bI7fUhfwBSA85JM2OgOvueswZnji90k1r1oJdL9P0xyQ9mIEh9V1ssRu9tEuj41fbnXfsVjuTWz1WUnmbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=va1h+NHUkYUSRoQytb8hQbTiAWlModC8/3U3lOEk2yI=;
 b=dDIGKY3wVymb8mk2UU/pl4KAl/ZHgIHqmAWJAzp5396PtsYCicAqPmb1ZTUKOyIzE/nLPpwDM+kX1Ha+aOnQGsX4E2t0WpK6vUipYn+L7sRxynz1IBxmIy3+IQpfX580bffZ6pbrnzJUXx1uQCMr3ZdCIk9TdLJsyZn/hhPZCdinDNcUd9dxqfVfesxX2kjMZPP9zAM3zcDQ8BZUt1ap36lwxIxui13ZIeT4Ybwq8jucHreZkXXL+oAI6R8ge/YSFoTplCtZc+4D6Y5vonrl0skPzaucYFAojgNKHyyJohwbyTXwP4dmBPMdq63pxWi+A/BeaK4+sCBJx0MFpgI3Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV8PR12MB9272.namprd12.prod.outlook.com (2603:10b6:408:201::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Thu, 9 Apr
 2026 23:17:53 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9791.032; Thu, 9 Apr 2026
 23:17:53 +0000
Date: Thu, 9 Apr 2026 20:17:52 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jpb@kernel.org,
	praan@google.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
	jonathan.cameron@huawei.com
Subject: Re: [PATCH v4 02/10] iommu/arm-smmu-v3: Pass in arm_smmu_make_cd_fn
 to arm_smmu_set_pasid()
Message-ID: <20260409231752.GW3357077@nvidia.com>
References: <cover.1773949042.git.nicolinc@nvidia.com>
 <d629f81f2a30bb6fa06ec00b35134cb6bab80a48.1773949042.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d629f81f2a30bb6fa06ec00b35134cb6bab80a48.1773949042.git.nicolinc@nvidia.com>
X-ClientProxiedBy: YT4P288CA0076.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV8PR12MB9272:EE_
X-MS-Office365-Filtering-Correlation-Id: c5158c87-92e2-46fb-a448-08de968e39e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	602YH0nW/vMMXizsKT0qlP+yd+nBqiHCnIAuA0WLPcR+VuVX4GGkW2y52rjBs98q0+x4Ki1asGgqG/NUn5rPYimhAHZvsd6l+PfI/1m76wlZ+libP6+EEnDX9T7s0gjMKMt8TI4zO7Ng3aB1htMjfZTn66Ra/hWYs9gWTg3ikQU1jrf0ylsp8lMEioShydCgz92a1ZmZLtK3gPavGDOzONS46SVZbTuDm7ToG1AC2FHsKRGtZtOdEHq+ZspF1AT9FX7fgVRCEGbKgstik0eGdNtPznCv5ec3SyiWhGbFbVKoWcmEm/aUvx58Z1VYPvS1P3ab2ITgXnXvxK+d1YyVG2xbOYySf4yX1RLU3LNoKKSCIlXzgnFNZ0EwbZo3g/4EA89mwEM6P5m3ZsRui9Dr5I0PGFbjLCSzzb0EhI5/yyD4QdOH066SbZWq0oSrhlwoa44kn83nENpXctqlZvltsuXWwvVVA+b4ZhzxvGptijx3/JiDfGN4PxMMIJ496WXFZhQ1iL+jJEQbAJ5U7QHwo0cPGBAMURqVS3tVLQ4NwxyMW2XshQzNPG/dNDAP4fdDwPdyINLq8q+T7SejuqEdjqvNXgWDpGo7IFh7FQtCiWZnq9eijTLhAHiGsgWHwD+nsHwnp3MAhiy10K648QzZqJqDc8oAEIapXZ9S1e5Dx5yFPeWT0VW3uUnK6QVn8SNtdQNvLykKhAZJN9uG7IDEEXM2WtEtcT+TUnaIH7+VTwQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+yL3l+42hHUS7vXIvJTIr9nUyJPAQPnnu9b/U2Z1ZYJbWAZDH4HLAAaatB3t?=
 =?us-ascii?Q?4h74lPBud/Hy2iz41tFUfpSp5GG+vayDYfxYF+igBED+5N68IfcxKJBZhV9I?=
 =?us-ascii?Q?m+07kW2cW1pk2k0c7YH7XCPXrDIFk94Mg0SUS2/HB8jS1x7qhYzYnLFAwNgA?=
 =?us-ascii?Q?33JqQndaZOf/fGnT44NKPF8lipYSVFzGrscsm9r+3JWF45b8uMHtdeurZlhL?=
 =?us-ascii?Q?kM+v1BoEqosljkK+BejLtMX3SAYZEitIO4rTvKKO8agPNGA8FO6NEG/h2RyY?=
 =?us-ascii?Q?s+nGarMrp4GfSZPmD4GPHUW0QAKOM1eXwMVxZIB6TKjVUGToWEL3WBsMBl+3?=
 =?us-ascii?Q?4EbxTjEbfnLmw/M8gQqf9Cc6LTl/SiXsYjdfITN2xolJrs4Idic7kIXNnF+E?=
 =?us-ascii?Q?k9T/j4Bc4HQHi1pxl1KdY5bifvRasdh8BRBxFQ2dtMLkZfnardKqkIU8im7x?=
 =?us-ascii?Q?xaale5HpZr2ChMUQf8NWF0UciiL0LDnDtxcTNPaWwCl9Q6pao9TgzeoyodYq?=
 =?us-ascii?Q?R32F67KQDTCKueW9voufA3Ym8e9MGxhpOHtEAiZvw6sHGt3Ymo/jnkydpx+8?=
 =?us-ascii?Q?RL66T5I6Ey8SRXTGoIYT2J38F/uY1mFTHu+t0ijAsL13oEAS2IzKxTiBs6VH?=
 =?us-ascii?Q?7xTrvSmxXAkb+H098muQCeJ+h0CCSwj+FwNKDU0Yuoi7AInKbMx6z6xr+RbE?=
 =?us-ascii?Q?ZvfDztMdugG+XAAi1beRoA3I+Qy/8N6A81gBjziSPVzYGSfPerSKpII8Nhwh?=
 =?us-ascii?Q?jEsTshzNtTvWK1mThjpqFp5PS6/k4VGLG7GLcJlqSOUZ0TkMulSKIqRRxQk6?=
 =?us-ascii?Q?qSAubpiqAfG58uPOmgdyWKnw7Yez1+9Ei5loImTJItm35uoKpl52QA21bWbA?=
 =?us-ascii?Q?yxDG+Ug2MSXOWKpXIZ8K3dUtPfxvLE2fmLCBacfVRi+oRxA/vOV/XenCshXp?=
 =?us-ascii?Q?NqYDKP44DuUb+OSu38yIfqNO42MtzoxWTcr+sbH6/N9C50asRdHBivuEWLX4?=
 =?us-ascii?Q?piFgFJKO92P1qamsWijaFQhj8g8tSNWeUcwB0kifxvs4+ZjWx2+SvsfH243s?=
 =?us-ascii?Q?FzqPxVgBkIeL08YRbusRiZKquD3fUk4zUqnQDx/HfBMEHifNZ5PHwhbpmCu5?=
 =?us-ascii?Q?QH0WMIdeSVNaq8JcLlE+lpvx/nv70UQz9ZTacmyzNvS9jN7neGngOXvIZkw+?=
 =?us-ascii?Q?iV0ZY00Qb371v/wrOZHDDgi6a4In5UKy74JOTF9RsfRUwkTCjffo0hEYekT1?=
 =?us-ascii?Q?SBTLgH/Z5OxbN0pv9nBnAhShMbskj0+2GjK7c8UzPi3NKcvS/pL814eyXTZ4?=
 =?us-ascii?Q?nVPfsHi66KkhOy2vv69JVbyXc89IAWcdHY3ZSevYjN7RtGTZ+vc3emDdcQBS?=
 =?us-ascii?Q?I9+NsRfc8AnLue5jBCFrlqMaheUVw9szrEflFZF6Q55ZEPz3NhP/aElK9EjI?=
 =?us-ascii?Q?WF5TdMLKO6YZ55jLFtU6WYzILnTYUEfwQFf76OGdd4X899WRIPzqJfDpToK6?=
 =?us-ascii?Q?0PqKb0DawSTRblu+vr4iATZ+m6N5QBRgge07qwACyh2oW3/evBeXC12GCm7S?=
 =?us-ascii?Q?957aZCjnGTb8FMCVf33DXnplMBx80qWgHAI9lD5mOXypKpYGeX6T0GmfGdcl?=
 =?us-ascii?Q?UTZZLxwUMknCTUC4rwJyI2Yopf8WuGUMnuZ3HJbbL/cfhV8ppWUE6QtQJ4AM?=
 =?us-ascii?Q?9tyZ9I1YEqrDagW+phWHMTsHs85l6MnmmSzhULYmVlSjSQc/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5158c87-92e2-46fb-a448-08de968e39e9
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 23:17:53.7405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nok0mEh2J8Q9oReoCH5ZhSpZ4TLBREH4mzCzZcSiNSljMeM5DLPWL1BjfiFgD1BQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9272

On Thu, Mar 19, 2026 at 12:51:48PM -0700, Nicolin Chen wrote:
> To install a domain (CD) to a substream, the common flow in the driver is:
>  - Make an S1 or SVA CD outside arm_smmu_asid_lock
>  - Invoke arm_smmu_set_pasid() where it takes arm_smmu_asid_lock, and fix
>    the ASID in the CD.
> 
> The reason for such a flow is for the timing of arm_smmu_asid_lock, since
> it was too early to take the mutex outside the function.
> 
> Tidy it up by passing in a function pointer for CD making,, which supports
> both existing functions: arm_smmu_make_s1_cd() and arm_smmu_make_sva_cd().
> 
> Then arm_smmu_set_pasid() can make a CD inside the lock where ASID is safe
> to access.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  7 ++++++-
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  4 ++--
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 19 ++++---------------
>  3 files changed, 12 insertions(+), 18 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
