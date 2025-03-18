Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D9420B807
	for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 11:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742298399; cv=fail; b=IxZ7vpPNRb1phy6ZorilDPRF7RFgo8n+ZsForeUn5Q5YwH/vQc45Jhu4uobWRaS28iFHo8LKo3STkXhrEYKHaIYh/P/127QPSJtvnbxbU/nW8T5AeG2B4t1pqBVpSB+u5+IpQ32NYA1hkQz7VJ4TJywtsawwXBYU7p508jRTI6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742298399; c=relaxed/simple;
	bh=rfbe4Ae6Q/hmeysvkRD7up+sji5xKa4BmQNJYdLiccA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IHZJWtHs0WEUUThZBUdDgdtBDH0fsFNwgsjuSBNd8PmPF1uWbi0mVte+grzIqE4/jouZ9UkyCLQBCylfR4iAesBFn0N381JFyvNW2kZScfQTRBxXpMovmWAIwarQfbpt92weuhDiURMGEPge1XYivMnD06QaGN13Rha1Mse6Qm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SjmaGRec; arc=fail smtp.client-ip=40.107.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SjmaGRec"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vXxnxFVaotgDe2K9m15hWDhvlbEXPO/8OmorQsxfpVTFds5tpYA9tfvWFNse5ag0ZcFh1gPAHFxBUr4v9viemTYS9zDQZi8cNhkOyvmm/ssN3ZHxINBW0i004++ef5mxVwaURDvgpmqeubktxRj8foa12t6fB9VgRtLXsyiZIzR9ZnzfCoC8YqUQ762UqYJAoBeqJ3lMVR4smHfnSllP29HpGI4oyzKcJOTm1O6oxmAmZm54+PN1RJ6f1cRWo7we594+xLcZH2E7CbO2XS8zVcQz3pMpVVd5uWDIOcz0BC/K8qW9JamR9maPnWjhmxsPFUe8c1yZYHneXUg6y0xlOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1PMthr+Z3YCrGH2Y54e/oZnhWjb1K1JJjNwvNQCTTm0=;
 b=r4uAfkF4MGG0Lc+nwUlWmp5guzukbAezttrcyKDyWKtfW4XOEgKnz/K8TZSrYSMK/WLc60BsVbntAuyb5e6zSOgRW5+gzbYeYX42XoaRC1rjEL7EBxORYbsspqYitWXWJWj+ZrJztjNNRgVaEe+QXPVUk1SQ60geo5hOJZ7Lm+UQaR8aMhqLZ+jioGeq4/nbLKDVyJUAXz7mTemW9RERcYwJwIaLHQCfj0wM3sHbkJRcHtydvW9JebKCPWXxjrqVb4NjeLjj/v0qJWpBKblLsUdynCEsVDEre7IeLIVHyToFBfjRKaj2NOwg+nwfNGIBAmi6muXzz/8kpnorewJARA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PMthr+Z3YCrGH2Y54e/oZnhWjb1K1JJjNwvNQCTTm0=;
 b=SjmaGRecuwDF74elSxoT2keQf+QQLORz7Hp+4oZo9HuZVeOqbfzKPwkI7ovDhcVj2YF3DsQrA61nNGpcnNvC0zobjqkCo7w5ezrl7IQWYs8wxv18N/gwOP6XCmMtttEdR7P9hUQEGOUqd7v3IWzHoEC6mZN+o/MQVcD1rOnE/VvJiWBUC6S3jTxVXB32f+bauQWXcPDHeYL+R2JptjKHq9Ag3wUyqdHxvQmqs4M9DKiENey/dCYXFn7jK8Egz3So5BiGEidCwZ3v2GsvnnTSxsjHPzkDmAhkhEML6aDLAAOXBoZsduDfnOmlPXY2fErR3F7EFaDtbiuJ4NOeoJWwqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV2PR12MB5870.namprd12.prod.outlook.com (2603:10b6:408:175::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 11:46:31 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.034; Tue, 18 Mar 2025
 11:46:30 +0000
Date: Tue, 18 Mar 2025 08:46:29 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, nicolinc@nvidia.com
Subject: Re: [PATCH v9 01/21] iommu: Clear handle->domain in detach
Message-ID: <20250318114629.GD9311@nvidia.com>
References: <20250313123532.103522-1-yi.l.liu@intel.com>
 <20250313123532.103522-2-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313123532.103522-2-yi.l.liu@intel.com>
X-ClientProxiedBy: MN2PR07CA0027.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::37) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV2PR12MB5870:EE_
X-MS-Office365-Filtering-Correlation-Id: 2580d93e-ba73-4545-48e8-08dd66128659
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cVU7UqhtzDTw52ItvCPuizqesj8DWCuuuATux/jXvx3BivtFApFBefZKPH0P?=
 =?us-ascii?Q?pZ/4L3FAObmgBdzSuYA5cr2yZlShnctUvjwbRRO6n8M//Kh1tPpyDZw3caat?=
 =?us-ascii?Q?nuxByhpaywmaOM1PNO644d8OPPYUhCcMTZor6ao3VQ+grEMWFjDKB/iCyfiB?=
 =?us-ascii?Q?XpqnDAu9eufQutYaKUMzsjbUxhPTd2R2qr/f0ZAPxtMI+03KaC2Okna0WvbT?=
 =?us-ascii?Q?JTI07amsBqnw6OT3+HrdYgV4ir++AINUvS7MIxB2JVQL1pEdS1mZ1O1pxgl4?=
 =?us-ascii?Q?YrLUN+NNdVCMHeu3Dxytq9YAgcPYKnran+yW8DyD0XipdxhRuAnLmLHrB0sJ?=
 =?us-ascii?Q?T6jKSzeQx8n34lrMdeaCbOLoC21awPRGkpQvrueSViZb+RnOM3MwOY5wzo18?=
 =?us-ascii?Q?JujVsY+NutxtqQvOaBeg8R+x/tDkas3Rg1G1ucIy2ktKOSUFcB1dwA8AmWV/?=
 =?us-ascii?Q?1KZIv2IkJvZOniuAvNIoNbEqFj29MZ2OqKL7PKFGRymEPjEsxizTxFRZqmzY?=
 =?us-ascii?Q?AVOiDOvU0LpaKIpV8iPZso7an4AI3gE6Aki56sCmVSBYwG65F5LeoFbE3YDP?=
 =?us-ascii?Q?KrMOe/5tIaAEQDzvIGI3mlX8tuH+IcaI0G4uGyeJZ2P9/hxOKNOradP364CJ?=
 =?us-ascii?Q?8LuAFp47IoGo65pRd6XuJwsg5oguvefswPinqjqot0ReXYA4snpsZfBCVUoS?=
 =?us-ascii?Q?3VeMuYHhoPOjxAv24eGP6yhLq17v7kBrOsONdG0hoqXqz17s/VSd18j83o9N?=
 =?us-ascii?Q?ik6kTIoEDAQdJy32SB3BdTfzSkWWKbDi+V3jhf1aHXbzaTw++jN+L+cRM0EC?=
 =?us-ascii?Q?awAnrwH9KwqpuRA/V3+/OfjUNIwn9YyxOsDALF2GHVq1tO9TDIFIeu9KRsyM?=
 =?us-ascii?Q?HCnk4fXh1XFkLtQHmMJYE+26d4jRrUji5Vf2z8wnsIABTzthUz0L6/UgF2Gz?=
 =?us-ascii?Q?5FW2yJugTo62fpFCi3Q6s9dAYSpHzkkux9SpbKeJBnmj7TVRD1q/2SGs5W9k?=
 =?us-ascii?Q?44FwBbuodCGdosudS9BrWtO4QZvlP36nTNUcvDyeAH7oOiJU7rjmDvInYjWX?=
 =?us-ascii?Q?a5t7UrqIU/uMmvq+ora/ZtuVKv/RYdnn/ktBBZbyxmGrkpKwl3ohzlRrWirx?=
 =?us-ascii?Q?T1JCyAE/nZWHcKX5h70W32efQljgM8nn2trZNL6Pc6Ub7r4jv2lfJUVZT/kn?=
 =?us-ascii?Q?j3K9Z90IydNb8xJVr5L1I9o6bTvPbHcoEp5IvmrbpAiOkICahEmjiCOrddRq?=
 =?us-ascii?Q?95zmZ5M37q2/wZc74bAKVGIcKl04Fs0DWKRDMGGDg1hWeXY1WFI0OkgXl9RZ?=
 =?us-ascii?Q?PbkXkwzpYCJqwgWhYd+Y6obJNh0NUA+6k7yXLgt6igNdtG04QbyIBAxXMj88?=
 =?us-ascii?Q?EqJfqXyxb66C0EoeSrTcnFtDFUDT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nD3ejmI/4PMJ5RR0zMXsTNR1EXrLPWnJeloifwHlh3o6yQkY7IvHReo/bmD7?=
 =?us-ascii?Q?9hpfSWsJgbWlG0Q9FLkoQIKMDKwAHt/x2GBXlu7SB7b9yqtOybNhvkXl6Yv9?=
 =?us-ascii?Q?dmji8hdW6M+lWIC7ESPBBFn6zccgofoes2jaSCyVvu/GI3l/4eY6qC+/oqwP?=
 =?us-ascii?Q?zDJrbTbW3QiIlHHFC0YFvaiTRKm0xfJ54FoKCcCkEImaBYZhYyadx3xdOOEo?=
 =?us-ascii?Q?EQXXvyOnscBcqAdBEDHVQvmweta8lraeK3kSHwCgAOfIWRcxGjfssgd1cZgY?=
 =?us-ascii?Q?JfR2vqK5BldnXojoTJK7ND+2R7VIERKs7BwP6hO2cbYZy4tHeJLoJvzWvXYz?=
 =?us-ascii?Q?BaUTzje8RrCxdjZbb5MoYlPjW/He92xpx0xNfP3P+9H1pCyjtr4aVmk7SdpY?=
 =?us-ascii?Q?NasdhlBhxe9QtLA5B4k9kt6v34XnuSgh4mvFVga9VOMsEaw2dKErZu9fV1WB?=
 =?us-ascii?Q?vQlUNjvHlKVEkLVRYWqUFttI9W0mxvtUiM97Ojd5NIwScyNONqD3K+WVK4UH?=
 =?us-ascii?Q?e19v3Z60Qy5VQT2dRN9n9YFHfSCwXrjFOFclAmziqXqDjRePFIIP74kqXWAV?=
 =?us-ascii?Q?qRMNXo8QYuBvdtGMS4lykwQLQxTB3pMgGF+RnI/rujXaJqht1TJSNIx4Na3v?=
 =?us-ascii?Q?Xz/O1X0QAIPpLBRSiDOU+U0rtHQShX7S8HQ4U8up0qD6x+xgvpLi3mgCb9FM?=
 =?us-ascii?Q?1qTyRvaSkABVANWxakyGTIqyM5jzZd/5ipHgtwa8ire9O/P2Chy3VtmdBs/F?=
 =?us-ascii?Q?UU3v8wRJGOTXsxo7Y/FwruXV2fnLLejfLD5kyaQKpOG8oW+zKxJXBa6fnJFU?=
 =?us-ascii?Q?Ae2avsYbRJyT4Y0xOns/5Ca8JUKXiuLV//xTzh9rT6qs9UpI42DT5HySvAUb?=
 =?us-ascii?Q?NeLiUt2ShrPKwBgiVKZe/YgUE8pHToHnGyh7F6nMjABFCTIosl+xzAF9ssa3?=
 =?us-ascii?Q?MZ/laqEHdWEbOnasL5X0SK58ed8EnkhuEs3/4fq/ly251+DtFKyoSh3J8VpK?=
 =?us-ascii?Q?po8jOdklu0h6DM1DE65OUTuMQBc2pa/aUdkwPTEJtrxVXQBsnoAA5sOFRuQF?=
 =?us-ascii?Q?qx2cxuaW0xj1PpQeBR4H+TqQ788jFE+BewCqK4nLfxRsbcta2bUaBI+nV3zu?=
 =?us-ascii?Q?hCl59DUxV/OnR/PPAHZ/e19OZ8/yNlSZm0W76nQ0x4kWeDQXSA6/Rhb8/A94?=
 =?us-ascii?Q?zDtc4XJ5fjA+6tH/epVqot8i/9uTDcJdwtSUro1BtuSyiYfZpy2Psm/HgyCf?=
 =?us-ascii?Q?o1UtxaVMPO48tIWJw/+zrkvgDYOvDfhPegc8EX4Mgpnw7W1IisZ+V6mlZZgh?=
 =?us-ascii?Q?6t+Y6zaYa40yVZnjPr7sbZkS+Lx1zlODMqSL70xmGiFw4k04bQtqUtcoRtaQ?=
 =?us-ascii?Q?nq3LVPjZCLq01DlXFr/ip/0mSfb5aqm08T97n1evtXt0bYDnSnoqpbQXy/ga?=
 =?us-ascii?Q?lgMfIhQkDKYPI/QffbN91gVbQVKAVCAEVPJemKXmNZXqSK3GuFlAkJzUgVAm?=
 =?us-ascii?Q?2cWlrvBIWOIqMbJgu0Wbr3MwAeVEeiem3H6KHq24qX4lZhPORDSQ9LzmF0af?=
 =?us-ascii?Q?IJItrZ/X33GAZIem1RmkQgs40FCsA+KBooLfpGyc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2580d93e-ba73-4545-48e8-08dd66128659
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 11:46:30.7390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7dRkHcuR8v02ZCtVt84N27YVKbQ6DnUa4r059IBOBtYqOuxxwYpsrHGbaIzjfSqN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5870

On Thu, Mar 13, 2025 at 05:35:12AM -0700, Yi Liu wrote:
> The iommu core sets the handle->domain in attach/replace. To be completed,
> it should clear handle->domain in detach as well to avoid potential side
> effect if caller reuses a handle.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/iommu.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> +	entry = xa_erase(&group->pasid_array, pasid);
> +	WARN_ON(!entry);
> +	iommu_pasid_array_entry_clear_handle(entry);

Though if you have to respin it I'd probably put the WARN_ON inside
iommu_pasid_array_entry_clear_handle()

if (WARN_ON(!entry))
   return;

Then it doesn't oops the kernel immediately after.

Jason
