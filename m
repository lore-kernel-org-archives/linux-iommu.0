Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C1317A5BE
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 18:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740765741; cv=fail; b=U4UAgQN4CF/dkU1PRviNYcGeo6vAtAbDDBpdvnok1K6YC8F9HZfzU3Hw2RGzzs//NAi/mrAlAwXWOSYGv2v7pDYjoHX2IXSQ2UbGqa7/8NVdBqmTC2dWrQax/N7Dlznld0FLyyRV+wvPzPRrkmMUnW1A/GxXm2dF21z5SwJqVnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740765741; c=relaxed/simple;
	bh=5ynAgSNZ6wgdG/49oesc9XoGOHyBBf6vlGgim2R+3vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J6kQk/yLrZdOAExFInNiR0bfWxF1iLM3UeeGyu7h0jQl56fnVqCU9aU9ie8cnchQFWfpwFvpqk7HOAEjl0IUuFWUKKRd7WRmQHCp0lGbCx6Jc8f75D3eSzqetoy4XfSM065BPEXNj07CeJUJj74uDC47LTZT+pTESsSlwDyjTv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jRrN4Pnh; arc=fail smtp.client-ip=40.107.236.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jRrN4Pnh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jxzFqLUXouBKJn2KLG/vCXEDjondjsXJWZdlf9a6pRxOWRuf1gHAZPUIp9w4lLOBUifAvp6LjvXO/BrOE77PKG0QSohrQKguXibgKZHSDeUB+VsfoeeuhXMfYRYbBF7eW8aTaFe7GPwHvdUPgGBs0ojBwR3JQEZR0ihJXVfhhlW1ugF2t41MDPUHyj3fR7ovPESfRv1kj+TdTQAUAQaNXrqFHeN6H9zlAp36F9rGvleePucQDSkiHX15N5Dkll4OjKUddHZ0YYO4TMbyENarz9BHBAVNTWPt9a86odCJ15wTUQCe761OJXflO6rqjzqx18CAu7SPAsGJ8xyAhyu2CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yt1/PJTJXQp0bNwiEUtQkMqOcKPUVPgJGWBB3lE4K/g=;
 b=WMfVecsx9KxWqZ2ogrlYRk+QJlNaWr+g4NgLuU2EDWVYxOSAacVfr4M4l9utWJDFf8sKH063sk6qwTrlKW0IlJZ63Ppxl5cn5QXULpI62WFppLTQkwiaXdypNN0qnkOuVyEcSm8A9zahcGrY1tRAdRDWJxF1hLzsiqFUJIHhIGvZADYlsIr4W8eTzxzzS6JnySm7MHKL77+hOE2SrDfA5MCc3hSXWvxfYjYXZjfPuFT/V5FMnngkqq037/qds3jhQ2k6KTsi4QqQIoUYgYaBDK4gLuKSrrAPp65PCa9mPBgf4CeB3J7d3XdCuyhDc8UtOagY/4RNwTxJBlkFzyBW6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yt1/PJTJXQp0bNwiEUtQkMqOcKPUVPgJGWBB3lE4K/g=;
 b=jRrN4PnhiBgR1qnS6sgmUJ+2lqjnn+2iextIZL1RSgN+4tDoGJo4zhE658MD2SQgdZCt8QmzfTLl1TbpcLAKE1Z3WNieYiJdZJiWLDzodSreF0hihj3K/XinNbH9JeidbwMYDNS32ZIcgiTC7iNOwVOQVp6HxFAA7Mu22zIbBV4+BX3GGo0BCZSsGrocdk7x2crDEKKS51kz6R8ybw4/JrANUj+kvYZZvP0RZTcQvSO9+FlwwdduLcIFmwRF+Y4N3uOHW13Yd0liPwOnOjgLS5R17S0h/hMTAAYrQ3d7lYU6neMqQWx/lkXkYeEtuwvoItwMO7e8yrtSf+hYK4d4bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 18:02:16 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 18:02:16 +0000
Date: Fri, 28 Feb 2025 14:02:15 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, robin.murphy@arm.com, joro@8bytes.org,
	will@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] iommufd: Move iommufd_sw_msi and related
 functions to driver.c
Message-ID: <20250228180215.GE39591@nvidia.com>
References: <cover.1740705776.git.nicolinc@nvidia.com>
 <ece6ab9a0144eaabc285eb21a09da683d6d9951c.1740705776.git.nicolinc@nvidia.com>
 <20250228173212.GC39591@nvidia.com>
 <Z8H4VL+OUfi2+5eA@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8H4VL+OUfi2+5eA@Asurada-Nvidia>
X-ClientProxiedBy: BN9PR03CA0858.namprd03.prod.outlook.com
 (2603:10b6:408:13d::23) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN2PR12MB4063:EE_
X-MS-Office365-Filtering-Correlation-Id: 53ac6b52-788b-4ee4-37f8-08dd58220944
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w31peT+/lbiyQz4ZQuMYEqS4hx3kYwnG3yMLaaGCY0St8IymPmZBWPDNIkuW?=
 =?us-ascii?Q?RdgEQzCEeGjDiSsXrCTM90PaOp+esfuQcIm9epUBZl4yhkg+wjaxalzLfqu3?=
 =?us-ascii?Q?xjUlkPZnpanTMpAP2da2I1dguI/IfAO4QfFhUGnWEIbsNebAtnlbwwW/DK3P?=
 =?us-ascii?Q?ZRecQ1mXKExrJWuQICrNpXOmFw25aZVUdqZkhBdoNuTlitjTYbBpvvSy1LCa?=
 =?us-ascii?Q?dzLub8Ge0Zc3eFnY8/TumVZceBarb2XEsbeZMsu2s2u8MkI3xR/94Wr6knP4?=
 =?us-ascii?Q?bJcVMzUHLXfO0V9Ns60pSU2GQ9EgEg/dr7tDA3uhXatEEhibcUpMsVQua9Rb?=
 =?us-ascii?Q?c5pwHNrOnV2LHPkR+z/GIJhiHxCAY9N7mupz5u/bQJ4aPLvE0xM2w5Dgk7cZ?=
 =?us-ascii?Q?plNe2noksQMpnKE8+fEJ99RJ4dtqc6MS4vKpZJtZNAf7SH0POmJB1qHLN/2c?=
 =?us-ascii?Q?bxtaU/k4yjcjqdjnT3Uq8TwoFPbyn6SzzQ4H4/VcWmwdZcwDrDM0cSm2EIsZ?=
 =?us-ascii?Q?Whgl0OVT+VCcRP8JzwgX6RopXudSy8JiW78Y8ezEKQ9L3FlULxE8WLSaYAzo?=
 =?us-ascii?Q?l8iGxDPhK2h+Sfp5+Zud3jIzBoQO4VwcpHG7IeHyyE+0LbJlkHvepG0/X6vM?=
 =?us-ascii?Q?1O1C+sqfMaAK9rYY5zPtdgp81LSpEqz4wBQbSAWl/uQ6AqXgj9eSqvJdtfne?=
 =?us-ascii?Q?B9kTJBn9XvGf0umzo+z93hD6B41G6katdMDP3pgrsrIcgSRwZ8H5aY/pLMzq?=
 =?us-ascii?Q?OY0epkQjrc/vSdD/XWwdFxCgizgStUxjfbjxwvAOUmLXapH8YhFoyGcrCPH0?=
 =?us-ascii?Q?sE5A/Ptu5acjcFnH82HZ1Sj+H/b7hx4h5CmASl7xz1wQPVka0u1meURDlQss?=
 =?us-ascii?Q?poSh/cUaxr8vmm3uZncQREi42+qp5jVe3DV0WJUavSdEoCLd/lk46hZGRdA/?=
 =?us-ascii?Q?CH1XMYWQEMbuGU4f7zjeiLF3eqtKzmmgSVfASt1nivGlsobzajX6KJRn6kPr?=
 =?us-ascii?Q?poix0369BnXBYD7F3wZ8uW8pNeVS6JOL8PDYCS7ApAJ3vGLHJ/0P3PowdGE9?=
 =?us-ascii?Q?D29cWJHJ+1Ku72ZKjrQo5GQVh5Fm8kCA4P0C17H9lJHUjgh4E+eyJPgpNeFG?=
 =?us-ascii?Q?k1mXDStfdgt0Vj9D4HxG6eqv/2FTAqabE8viojCQcxO2CrfJqRZ8RLuXhBau?=
 =?us-ascii?Q?4Wo1AyUgXm4I2CfhalEAqy5G/uv3XbOc+G4aZSMAFOkx11MCeY4U0bs6wOZr?=
 =?us-ascii?Q?b/JAZykkuXrgx9iFY58M/G5hBtyzL/pobOpv1nnQJCXJya6KhCet22xGKFdH?=
 =?us-ascii?Q?kSAne4ThqprNnBZqJnHu8JrmPOibWSkv3qZj4tA0FIPAIot7YpjM5n1OiKH0?=
 =?us-ascii?Q?C3LqRTGmmzP0zvjN+MJqhzeGpieM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?654vM5SFLtaxboIJPdX3lJq3pJq1orm5rIWhCoTXsdUyHt0DG1MevcIUZJ+0?=
 =?us-ascii?Q?mFeNVsE2RWYntO/aOcvCaSGgaJ/QXH8+/qriRocqno6/h5XqOOBgxlde6ypl?=
 =?us-ascii?Q?n5dh5a4IB+HjejstlLCa7LTlR2vn+pUgPqpZoGEBC1Tf1jRkpavWUJbJKI+d?=
 =?us-ascii?Q?rc+0NytgO8VjfCUjFn3QPNWqfL6TMbxbdx5CK/qnu94sF/UQI2YoK5GsULcn?=
 =?us-ascii?Q?CAtzAra3NoxQgHNYcu/C7ZyEsLuXBXazNfGNRuj8zxhiOgILVZONi2a95wk7?=
 =?us-ascii?Q?goP1eKRbm4fZpooz32zCaiByv34zw6XY11humzkNX9uLEke9GH2aeEEIibnd?=
 =?us-ascii?Q?e9YVTxzIwe4QKVU+GjOCJ87uAA7EgzxZRcCzmCKN76jwTrEmaW1EFK44JKHO?=
 =?us-ascii?Q?tuUWVZ9MycrFS+xtDDEU2810N+whO4mpcvGY1TbaSrnr0gpW0ufMBE36zF0U?=
 =?us-ascii?Q?s3ELY788ZvQ0zgmttZdcbgnc8ri9NTCWcU/6GFoZkEttLP1y6O6GY68tvGaZ?=
 =?us-ascii?Q?cnjdwN0EKONQ86q6418M+Uq5vFa/UsLsUzoIyU34ACIS9vj0M6tGSZ9RJjgQ?=
 =?us-ascii?Q?Ia4ml3j2l2eC/1AKQLel/1U+jz5p4CkEPGulqGDbk92XC3hMRJAa8JK3hKXZ?=
 =?us-ascii?Q?WpOrGDsNg35/vTopLiQHjzvOi3AUdUskdR0EYCa1m/DvEx0YQGGNsOf5gTwG?=
 =?us-ascii?Q?Z7C5estakGUJ0x5IJ/d9FV6PGQHoVX3nEImEBsMhF7wjcmJNXW61+BXle3Z3?=
 =?us-ascii?Q?F56Sv9Vy/2alJjxkKS1I1me6BznAkam8vZLxxCCDLcpou7S78FRzp0pBUk8E?=
 =?us-ascii?Q?d949kR8HBJd31rJErFQ6vNhasDLl5r7cJat/cYtZJwUms5usrwXa7DbVhErf?=
 =?us-ascii?Q?5QRNvI1bUmhoZMZq7HzOar9vI3xoEi0Nq0ObTymL2E5buwbiVReCH6ZGcc8B?=
 =?us-ascii?Q?xA/MnjEJy8PlIKlgv7FYGjX+3ozG0UHObaQ0vo6vLhIM/rhAPSkVtxrS2PdY?=
 =?us-ascii?Q?kMHKHrdcQPmpUMOpGK935rk7MgbktAqypmEOk1p5WV15n/63yHuSbS3zSThb?=
 =?us-ascii?Q?S+fsSVV5xKWUX9N4yhDt6ZzfvkCI04FM8MsT6ULNHZRlWhfRyDc91IEJBqh6?=
 =?us-ascii?Q?x6689XBxPCkqNLELb9X/fJYfkaak+IPQXXhhfMnSNZ2omurEYRloo2bhfTVX?=
 =?us-ascii?Q?JFos9pewPD6Cv0KscLvMaVKLtxTTVVz14OyKHB9ztRe2j1aPS+zHS57+XcJi?=
 =?us-ascii?Q?+iUNuQz/hw+CjZyD1KMH5GtxZmFc9+AO2yX5VwuTghyBhKdvIb/3ZqrXeFg/?=
 =?us-ascii?Q?zp8g182mR7IIxj/HWDP5Koiz3EfoEN8ruKSvj+LAUZGQPLcN83ci+21yJkcz?=
 =?us-ascii?Q?nHYXB/x6KTR0N79FftrUnfIVr8q374wQiIoN5oczgIkBjDHFi4omGBK+UCd6?=
 =?us-ascii?Q?PT7d5rNR/NtmI3CtH1oXiLA3XUrabauHM2SzydBbJGSL5g8WZv8TW4VszarH?=
 =?us-ascii?Q?UJ9p0gqT2spTndIqEzNvhQVLJpggXW30eoIB011T9Nhe4g4wl2BL3/wk829Y?=
 =?us-ascii?Q?ggqwFQIgGeOwxSnCjH3uGVKj3NgrdvwZkxdEhKqk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53ac6b52-788b-4ee4-37f8-08dd58220944
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 18:02:16.5259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qbyXBrmFlw6qVlt7Aph9Vs/8fiInYpf1tH+pe28xDAEIPUvTKcx3XrdY9cKC4Kgo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063

On Fri, Feb 28, 2025 at 09:54:28AM -0800, Nicolin Chen wrote:
> > Stubbed out too if CONFIG_IRQ_MSI_IOMMU ?
> 
> In that case, the other caller iommufd_group_setup_msi() could be
> {
> #if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
> 	....
> 	iommufd_sw_msi_install();
> 	...
> #endif
> 	return 0;
> }
> ?

Or a empty static inline
 
> > I'm still wondering if we should use a function pointer, how big was
> > this compiled anyhow?
> 
> Hmm, you mean the size of driver.o? It's 192K (before) vs 212K
> (after).

Yes, but use the 'size' command to measure before/after

Jason
