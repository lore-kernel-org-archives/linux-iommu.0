Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012001.outbound.protection.outlook.com [52.101.43.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3490327E1D5
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 23:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763509484; cv=fail; b=Ei1hvNDkdhjk2CM25128sqGA7YzKFZR0pF+T6VL3GfWyewe7DpVpX1TdCNXh1mlT8LEp4ro9FBosZXbz2F3Re6QDcdWcyEiKSh92lbmJJMUC9aqeKLBzLrcJfh8XsyF6c5hqWmq/e0qfpap62cBdAbFt35QDXzIs2lyOc5oEBzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763509484; c=relaxed/simple;
	bh=ydkeB/r6ZbDX8D83SCcy65lylUKGFfebdc02LcVu4Wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MKmcMv2ZQoWMPNkjcfOIs2iKTi7HvY7sAAsdhAt/riTVsFMmbRulqejHBmfcAaRwXn248n732dNsK8WqWWQfeyK5ki9BF0xJLs4KGQjhoJCww8CtiwB53ofl5mUqeGxEX1hbxnZKGiOtsc12N0hSgdg+DdaDAZiYZ7mkjaXC6w4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I0ixqp+H; arc=fail smtp.client-ip=52.101.43.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I0ixqp+H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SUCHabXPGtxa3ZiddaS0d5bNkE5BE+khz97TwEj/VESH6Gk3+rlm4/0ydhHwsYYwbWsZbwGId2pDhW2rEzj4OAIZKAfd6OsF/dA3NteVz4lgfuDMNR4CDpY27cTJkfruMvt2/EemO9aptDeNnfSifvxAmdloVrwHS3mLnpQNGL8y6YhUXx1dXz3kf84/12KTLO0j1eXxpDF3DexPSCSQ4cMefxr4zNO5ypPhBxfdk7TrVDWG3AWQQa0XUMcNPktQeos+c085Vu9ePqRlZDopfmQr5fPWCwEmey/W6eH9C6rOs0eDjT8XKd8okw97o5BW7zQg4fuvoc+Xu21jOtZs3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34iSgRIDPec9i5Y2T0d4Xi4z4CkUKWqNeZ8gEFd6qbo=;
 b=C+eEVeE9QjJgiOhoeYHD/P31DBBZy5uroopCzL9uYEhhB5FHOle6G60BNVQ1jAXR5oHsmU1BIqg3jBRvikdYkueibLs8dOdwu5Wh6lRvCQ58AYJQlIXPydE+KJqsVCdPNNDdWE8z0J0Xk++xwJ29B9Wlr/4NN7QZGp60/6sCUsMVzIaY8eqchcCrjqaR7bN5CF9f8Ot5Lu/Y7PkfgV3m+NMwkK/ppWhIYwfoF8MWe4iv39iCyE+9O5/QCAj/xX0mQ4GlDvUASFDqH/paGURRNBOJzodMC2oiKwrOVp55lMaymEjyH4JdWlZKluVm2mWdo7bo+WSAMNtclk1rGEwLCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34iSgRIDPec9i5Y2T0d4Xi4z4CkUKWqNeZ8gEFd6qbo=;
 b=I0ixqp+HKmonzCkcBg9v9A+RnZrHajPj1yxCCh4adJYA12jGac8I3lSZBkDlk/pDQLN3yiDH47VAQ+o5JKZ3DDKtbnMUFYGH9wCz4NRFuO8Oqg+BypO01JzfqyxiqYWeKOLEQfZoCo59fxTBNE+Jdg56NL3mudWm+LDM1LFArP2kHMHZueHh9gbJbjFSoNmrKZKVYWN9UDU5w72ug83yVfEeYBygfllmLxi5+wDCnFSoqQ4XVqgYuI5mCFXwIeIFdww6lhpjjvodwTLmNz7zBl6Y0UfTIf4zyeq9ehEzmglWVIMH/vuI99IQTSyyzEsPCvmGNwygrmVPgTHxy53eEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by BL3PR12MB6595.namprd12.prod.outlook.com (2603:10b6:208:38e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.19; Tue, 18 Nov
 2025 23:44:38 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 23:44:38 +0000
Date: Tue, 18 Nov 2025 19:44:37 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: nicolinc@nvidia.com, linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	will@kernel.org, joro@8bytes.org, kevin.tian@intel.com,
	jsnitsel@redhat.com, vasant.hegde@amd.com, iommu@lists.linux.dev,
	santosh.shukla@amd.com, sairaj.arunkodilkar@amd.com,
	jon.grimm@amd.com, prashanthpra@google.com, wvw@google.com,
	wnliu@google.com, gptran@google.com, kpsingh@google.com,
	joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com
Subject: Re: [PATCH v5 04/14] iommu/amd: Make amd_iommu_make_clear_dte()
 non-static inline
Message-ID: <20251118234437.GE120075@nvidia.com>
References: <20251112182506.7165-1-suravee.suthikulpanit@amd.com>
 <20251112182506.7165-5-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112182506.7165-5-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: BL1PR13CA0180.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::35) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|BL3PR12MB6595:EE_
X-MS-Office365-Filtering-Correlation-Id: 35985269-1aa2-47e0-aed9-08de26fc6fd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+56BI+0OzxsAXbD+Qdk39CsWHJ0nH5co7WvQKh+bCsgQzw7vZ721SVOTaTVc?=
 =?us-ascii?Q?9+8tqxXacacPXvyoE57G16WxG4ybfyTKYSjr4fsXCBz7JfCGabK5MyFBG4k5?=
 =?us-ascii?Q?2nLcqJrAUjmd0XvukYHkzeFpZGK6/dtdvWTcfLegTSx9qc6r/soaxF9vJ4CY?=
 =?us-ascii?Q?2Uh+MS55TofgVKUiB6pJJztwKMiA+6durPnhUsWqIm4DdgDrRg2XibDvOrsT?=
 =?us-ascii?Q?9lyeF5mnYvMQX1g11IEV8vUuHhanYaAH15Iy6EYY+Nlmt1VROHT914oZoavg?=
 =?us-ascii?Q?BP+kXQMn5nPd6hIElRc4aSADyKzYRa7FzrQkz+3OVmdnOGLOQd4e8iRzQ2Re?=
 =?us-ascii?Q?fMlwBvtdB7jHLjpCXhg2fL3YiliTfILwy6qaxO8AoGPdZSh5UVH/54RWN4FU?=
 =?us-ascii?Q?7exiM/AbPhfijCQCDvflVN+zGSJkedH37sNN9iqQgWU4YuLZQafACFOOnrLK?=
 =?us-ascii?Q?KX+gRHHDZTtJSGW7rHqVSv9Vp1eKbFU2CruypZFgqCprsSbn6Q5TRMlRjlfa?=
 =?us-ascii?Q?x7XSHwM1Q5xWqym1pRQ2lgTXU7rbGwnrEUsCy2EcjBDT8TzP8tuTY9JzEwjF?=
 =?us-ascii?Q?OEaMKd81C8Gk5zjhoYPfNXsM7HAegrJkIMxLKIWOiasDr7jCCqWzy6nIZ53z?=
 =?us-ascii?Q?lJ2EbuVjm7opN20i8ECs+BmOqliX1IZlBV+CBCO3ZLIwJJV483ZXx9TkhN4Z?=
 =?us-ascii?Q?we0wYlWGnl0xrXKwfPJd78wbQDzSTZ/28HVSpMlKGlZ9R3IIv31WIyWBlfDE?=
 =?us-ascii?Q?T7ZSrLK7RiWPbH3rLMztA+rWD7n+5aRqSSRf2oTp27weCxsr2bi0sJPUokw/?=
 =?us-ascii?Q?qCbAThXpAlHqG5LhiLJSkB53a7XnCmbVVvT5fZD791ievhoobdrv852jKTEj?=
 =?us-ascii?Q?SykkxzCLCyh4Y2+Egok6xwIJH/zSiBpeTbjYkxSvyKUze5uq8PrC7mj+Wdb/?=
 =?us-ascii?Q?2fIKZKyFvVRRdaRh5Udo7H+FZ2WyudXKZx5K3D50ZQJh7Yp8RbH/BIE0eWcJ?=
 =?us-ascii?Q?ZelQfPTga5hXCMj9t7RgRcAc+lspNZG8am0gFMRihqV5NT0J46X1B7hM3lyG?=
 =?us-ascii?Q?5vAhJMy6ZF1YHwpjJhL+fCbprQrsjmi96nRTndef+AUw6WQANILtDBNdDFDp?=
 =?us-ascii?Q?FtJX7sOPz+v2YfTfi+kZtpOVu19XDFie6349KGkGyZ/FUr+ndR6f5C/7gPLc?=
 =?us-ascii?Q?kzLN7ucA1bbOg41rlnKdR9Mk0KawaTVN/b8VZ9H05DXg9cRFT0LOuDlLrfib?=
 =?us-ascii?Q?yTJ6Yz005c8QxnHhmbA+hygWtrmcepDORf7y3NNeU7T4sZfmJbJXehRFYffp?=
 =?us-ascii?Q?CdE/OOnb/exXKcojKg0oguy/ZVkLWXx4a+72clKMf/ZM3ONMJIipBtRvV21p?=
 =?us-ascii?Q?Ol7lWnl+QBbEGAk8MiELajLNfoSZC0lnzcfxwZTfmNsVy3EIQ/lCOY0PVpfH?=
 =?us-ascii?Q?9PlDjl/AAccEKgemkyIc9qXKbTORe3DR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9PVBMxxfERGdZMaBGiQmCRFE6bR2nME+nT+j37PqNPoa9iyckUMqvK8sAROQ?=
 =?us-ascii?Q?kPs+LmOFQ841BVKimpftthai4tNwuYDXmqKP/p6RiTlcx96qxJBsECJ9AnDd?=
 =?us-ascii?Q?Q/UEJT7ziz/mk4wJ7YiR03fbsjjIVU1LWmj3Gog4GpN4TIqIOKCsH/e4m8T4?=
 =?us-ascii?Q?AyS7omoKrrYjK36UvaOgvff/v7rXVoMAz/PSlf5VGD8wEOvIMg1LuhrVhqOc?=
 =?us-ascii?Q?Ym9V9awI/KfzCyrAvfVGqVtO0XY59Mma0vOrmRgASYz8KziSaPNmXEpzeUxu?=
 =?us-ascii?Q?Rb0tspOfoU9jKCQDaAfoxV5dUxpQWFBqlSVcMwpQvNFvYO+0ghiKorX4NJxD?=
 =?us-ascii?Q?FAJhGMiiVSwQdTjEkZidX4i9JPrPNvaCpchTML1ONvbT4kKXULonmSvLOpLO?=
 =?us-ascii?Q?0g3PfQEyQbAoUraJ9v8RKmf6E0PTIajpNJ3o5mn4M/gL6rsuUDstli8Shm7T?=
 =?us-ascii?Q?mJTheG29jLwgCEuoff8y3XjxqRVd8snM87OjrLbws97m44XScKVDUNGD7KEE?=
 =?us-ascii?Q?oHEjSqyCiZ7cEqJPcEpIEJwWWjUMIwgvS557Ly1AJG+DUB0Fb5Ze4hrv460e?=
 =?us-ascii?Q?ZDB9HgumUZjfyons/OdHdniILxBYRBiuVlSsOuRtl28VfYW1RroxqZDD85N6?=
 =?us-ascii?Q?7LYjap1Ev0HOWkdfypsKbY84AaCAMKfohKSz3f5hgAkbOe0sbEIibwDkCVLG?=
 =?us-ascii?Q?TTPaPAabpq2gtNbWLiKZDsxXaMM6S3DtyW42gb8liLKg4w2ogZWjwmx4mxxO?=
 =?us-ascii?Q?kgdvwC7mlBj37uVN07xK5mZS6n8Vl2QKJAGaemd85RjbKkko5YLT7Mnz5Uez?=
 =?us-ascii?Q?Gg8G3SVRxKuCcypLitA7KN5btrnYBYDA6csPs857tvFfbBk0Ci6RmyjIBLOy?=
 =?us-ascii?Q?5ypFHPAlibaQNjDza97+NA8CCTIYNHf77yOvud5ZyaN9TCmrR/xsVE7GGmtk?=
 =?us-ascii?Q?cFZW1LU0Qd79tZc455KaezJrqnFyv5ctY8yIW61+fX7vQkqdt0xMXTOYyB83?=
 =?us-ascii?Q?6ATb21Wzia5ezrn6kz+FreXAKmw7z/ao+IrwGQMrTqtI0+255vKJSeH4K8DD?=
 =?us-ascii?Q?7PdT/H48eXagKvkpWmYZxEJ0nKTqZygIzzOOOIgBHW8PVCsQXZcRHQ3f3hFV?=
 =?us-ascii?Q?odu37KA+h5+BUlFH3h54GYZmjspYwOUtmjKGcgqBYjnEk8VwpR8RuLeyrUYw?=
 =?us-ascii?Q?4V3tZAThRREJM7o40krac76Q659Ebk47ljF5g2mXI2NlVwrX6BbHPSpZnyAC?=
 =?us-ascii?Q?XCjLBGXmPEu/crvDGiqEsWVA/IVvbkdd173uVk2Kb/dvZoqjt1uAtfvr1TW5?=
 =?us-ascii?Q?mSBADV2Q8LaivNAJwkYqkn4FbQ0fWE6Gtrw0ppGia8e4T/NsIZBRWE41tImv?=
 =?us-ascii?Q?D3ulf6o22hNZELz7eGEP5D/6ewR/fBRT1kqxWwIqY5v6jydlNxV73aRNcJS0?=
 =?us-ascii?Q?0EJcsTnpJOJ1qRAgbo76H2ZHjpL21aAUDWbkbIckMT40RHqCHY1NA2PjKkrJ?=
 =?us-ascii?Q?ucLqalpaW7/uExW2FIktKvxhc3bdwPvZaAHBb8e2NTlIFOmhuq320zBXJ99u?=
 =?us-ascii?Q?KSGE87s/GNhKsBVKaS8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35985269-1aa2-47e0-aed9-08de26fc6fd6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 23:44:38.4377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: euBEO+R1xoST5EtDmWx9Fp0uk+lU11eucXmXeuP9fqH4VM1jzu+mh8T/qkZtneSo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6595

On Wed, Nov 12, 2025 at 06:24:56PM +0000, Suravee Suthikulpanit wrote:
> This will be reused in a new nested.c file for nested translation.
> 
> Also, remove unused function parameter ptr.
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h |  8 ++++++++
>  drivers/iommu/amd/iommu.c     | 13 ++-----------
>  2 files changed, 10 insertions(+), 11 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
