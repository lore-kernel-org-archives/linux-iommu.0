Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013028.outbound.protection.outlook.com [40.93.201.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084AE25776
	for <iommu@lists.linux.dev>; Wed,  8 Apr 2026 23:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775692184; cv=fail; b=CKK8LAk5THC6UnPvfTK5ACW53F1Xz3s4H62GrVNdZLaiSRzImkjEpSpH3fkyu7M9KrkhyQKKub/zDvKkwo96MPZSPq+eRX0RTcK3NPSZZYBn4JYJcBcl3m/OR1pRbylORxB8AdqpEhV5ho5/DuowoyxUazw7t25qI7LJd7lnnFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775692184; c=relaxed/simple;
	bh=gXH0baV0Q49QlKUfmUNZH0DiACaVGYy9O4r+POgFYxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qPZjNUYXsiYLJhhHqy/1UGOhy5eDEsXh+gOGYNDd+aX2EtFTFzqF9ZW1wD95FhtMYbcXWPVTTj5NOLyW5Uso8CbSRAF/SBmpLXF+FG5KNnVBat5fUyFhES+WyWi9ytVK0c7LVI36gf67Cha7ChRl+gsFIIi6l+t8DuooZ6wPXnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ulfGRGXm; arc=fail smtp.client-ip=40.93.201.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ulfGRGXm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XpXVx9W07Ft4huSZXxHeFlFTP4N2FSXuWtMYFa6ljFcTCvjgVzf2Q0+lymz0rpV8CuKRpui/JltWnyXkxbZuu1Y//17LUPDRjZRLzLN+TlMIA2ucdJy7+0rFeG1M/NCJBWuSatmznYmHzc2NhpZrxjOjATI6H0aquYUyC68Mdup1u2STktnBUbeMXugyTVfTXUjK2gLZYkpWE3DUvglirjx6cLEipO6MrBnYfqoNfhmDnyAfpFn8auyVKWgNTYeUb8cgPU6tjckVtL4kg4iJky6XiV4dHw7fmkISUa3UFlLrwKR9fnjYdNgtlHXaTPyxVZzN7LlPRo3OXfoH6punTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IO+TGV5O2j7Vh7uyukSrv9jZtVniAC9k4XPeHR9Ok/Y=;
 b=CYbI2186p70si3QdQ4O3MZlJAgaFtS3VDoZ7w6jvI0mFhmqH8YAI8EBQBws6dizAHFffAmRJ5ZbqdeLxADaFB4DCxbs9cOoYXfZlPt0mgX/j+5w2JHPy7Xlsm/YG3GpjiPj+gyVC7zy658pDbgbmuIC42JMfdSXYz9Avep6LGqYIrQx/92YBRqX+EOtvbfHUPWMQLROpuHzLAo++kcMLBlb4GiS/5Hl4AMAst1awKgVLwW/IUNx4diuysM/jlB+r6Q6AQlg3ncjKUu8RCV1Hvg7qdt+ygfragXr5i8ga20jAQx7cPs6jTbYEz8pYmUjWDqW1vCWJFh+R5IOeAriMaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IO+TGV5O2j7Vh7uyukSrv9jZtVniAC9k4XPeHR9Ok/Y=;
 b=ulfGRGXmdkewDRVi9xPi/CiS/8jLlcXqGEd525QZzKxA84NRj/ayswRRoWT/Db+fzvf5gwle6mrZhNWh3Thw2Rc/bX7ORCZo0OFBvfPOtpwUTcsiW4GLlDJf8rDfY7KbpvQdRAagK3njKgsGmL4Hn8LYITg0Ca8kyocMKad5Vd1mYkMPBjKXT2rtJ74bq+ToiveBI6FOEAH0ijD+bz2AzZwpEGZw+Ya5KSbMcd2b1F2BZ55Td6DFZbGDzbdxnYmzfaQgV0zR/wqLm/Gyh4Be+uyeRkRlMIzJdkXHEBg+iTONHOLUOStJCs95lGes7vrirBW4z92+VCMyeazVeq0Llg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB8404.namprd12.prod.outlook.com (2603:10b6:610:12d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Wed, 8 Apr
 2026 23:49:39 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Wed, 8 Apr 2026
 23:49:39 +0000
Date: Wed, 8 Apr 2026 20:49:38 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex.williamson@nvidia.com>, joro@8bytes.org
Cc: baolu.lu@linux.intel.com, kevin.tian@intel.com, robin.murphy@arm.com,
	will@kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH] iommu/vt-d: Restore IOMMU_CAP_CACHE_COHERENCY
Message-ID: <20260408234938.GH3357077@nvidia.com>
References: <20260408184443.3077333-1-alex.williamson@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408184443.3077333-1-alex.williamson@nvidia.com>
X-ClientProxiedBy: YT1PR01CA0126.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::35) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB8404:EE_
X-MS-Office365-Filtering-Correlation-Id: 51a3b329-abfa-429e-26ec-08de95c97f6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	lE9fSv9w+oTNWNmDPYafQfz4fECZ/Vcm6GTxYsHpF8H3PBgA8cIwCnM4uRi9XrDEXd/BQfIAA/ub1ZT/LL97Slg+6mqUfv52h6RBgcETEDJ4V6XCWbuF9uiGrFvLVZdd6KH6nsZnxkAVtw9ZwhriwA/Y9jiAoeUgwryFTqrPhrB7kJqwoA6bH9JGEneFFmymlLnw5pBROZ1ZK/rLaLGuNHNwhHvaIcKZUycLMcJJL8Blxw2Xm6S8s+91mYJXacbb8SQ0awQO0xci90e0vyQjE9RtP7B/GxUopaBnEk9Y8YDQH19Is3RRDM/mFE+XSQdz9xqYQNvQlAlvDhXh3AYhewaZcV5Zxbh+6JRF1sR8f2TB+qEI4Q//MF6Olr67fcP0Y5Gt1X3PIqkuP9AYYm01gm1Rt8dzshc1BZq548kQOIpcjk+1UlOC7HLUKkKaEZr+pYgd3uEsvQoKPqRKC1PfdVCzBG2006m6mkBjU/FFT7kFN4VguzwKceA0ctgEmurevMlGj3PAoucCCqUCnBhGe+dbcYyFw1q+q2Oec78K2Ybr5r8hnyNb5yzjN4YtGvce4+Mxcajj+27IBhZ3VbS4VVkyxDR88RpR4k7CxAyFDKRAkxTkgq46/intUj/PwFEtWIKaPb5a7VEI25iwv2OH9aGN+vJ4m1M38pYgLYgXg4NS214mXMcGn3GDHcoE57gYw7fvLf0oqHL5w4gRHZziuzDfBIwGGMU1vzpWXtpap2I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cW3M2rsofaj/QYfSOO2JTr8JtUgoBsUdcaFfXx8tf0aTOnoTQXbfCgz9ajgP?=
 =?us-ascii?Q?5AxF9LuKwmnV5YdlR7xnCPtyYd5mJngBMMEyxiA8l+54zoLnLe1ZS95hsW/V?=
 =?us-ascii?Q?q2M2e4ZtNN/K6UbcrrGQy/rF8VDDsPq8+NTpvZmesyMjE5I5A6Lsx5dfk+8G?=
 =?us-ascii?Q?hHvTngIDGP2cHZ44rF6+wjBbrB9toVgCHP5A/iSjpWw1U1RBM9H18x56xvkb?=
 =?us-ascii?Q?V1hZ4dLfcanA1eRuG9KdvfU2Ky9FBTAqHA444G11luNqhgC2d9xydvcNnthP?=
 =?us-ascii?Q?dsydJYFEnUsdpTJjsRa7WYhDI2Xhu2CGO/yF/H604/9OOgSw4udif9tMMUDW?=
 =?us-ascii?Q?0+o/2vZwaVXRq3oNDnr1JZ7+d6husPUhDntEyhFjNjEwfOWfkhgAmZmGp1sx?=
 =?us-ascii?Q?fHLT7ew4xPx8k9QoKO/wSex59DxyC+7ti2SnfJf9LKxolll0CAk97E2anHd8?=
 =?us-ascii?Q?TE63JT9HZsQmlEYPYVw8vcTcfn9+xEmA3K05l12fAWJC4NP3EKQJpDsgasxW?=
 =?us-ascii?Q?AnZe8r5IdQW8mX9KACfSJQ7E5avrrP83+QA+9uRxqoGUdTBBD74RCCxreypD?=
 =?us-ascii?Q?sYcOE4CiQj1M4CNWrr+tukGxA9qTZhDdHD70t6R9ld1JXsHH+zf1Zebtp8KN?=
 =?us-ascii?Q?/MBOy64019P9ZX373esAjSPzyioe0n6kKdzK9txuK3SuqpkjiXRGOffHEsPx?=
 =?us-ascii?Q?bnex//ia9zUPO+jAVulcNaNLJ+SNjIKG7GLJtx5NnCm27TgMLrD5en5rEEJK?=
 =?us-ascii?Q?Fjht+ieWjHE/+bOKQ4FZV8GuyA8kXeZ6k47TnLnc2gcpV3hYfsP5C4lr0G6T?=
 =?us-ascii?Q?wBsCe05j09Daj39LYH+MAjEthCWOxlOCseyPTVwUAeyixn7UKo6RuEJdbwce?=
 =?us-ascii?Q?eXyOrkEGXyedfRRj2TqBNPq/zVEmc17cFyMmgJffRfYADO6enQnniExLKQmu?=
 =?us-ascii?Q?c6sc1bZrGWmcVlvbecAO9gPMvVYidElmqLuV5HX/qYq+GCJskepUs1Z3CKP2?=
 =?us-ascii?Q?0RkS2iIDIKdBphFgzapQE+MEIEFdnr1KzITWKQPYxrqhGmkSoPYhkZRTxmyX?=
 =?us-ascii?Q?b4q8olerhFPAIS8WCLEBjYWMtvwCoFoy6FzzjCUqt8GxmhuPkco7SgIcO7s6?=
 =?us-ascii?Q?TFkxrPfU2vGEOzv6Ujll7pn2LiQQV0+ziN9kt0f8hhffmjWqINMqbLdnEHS6?=
 =?us-ascii?Q?HBj14H4GhnFrcuKFDjK+IlfbaH+jfN6rZ0nfPx5rEa+7X/goMV73FRFN9QS6?=
 =?us-ascii?Q?lM6DW44bGn8t2wtWX2cjFveJebj7IyRYlR1+qjM0J9zgQd8mg4iAd/z3TuBH?=
 =?us-ascii?Q?9H9fxgNlcjx8kpxV+LQtNCF2e9puebTUlJ61fOLi0Ct3QiO4Kv1q0WBYCC7f?=
 =?us-ascii?Q?BOvEM1J0/R+Catj6DjO9dAjEfhc2rsUTBpXuB9OlBTn/slHmLeCcFMUv7DEN?=
 =?us-ascii?Q?a0e6ZGToQdscPx+no9nh3bkGRQD8bUStkl1F/EYsJa7bngknbOW8iGlL2kJm?=
 =?us-ascii?Q?hf34D7cukbirVn3TchN4vLFuvOKEp08bQq+36xA/7MaXHmYO2WbVtnJN475R?=
 =?us-ascii?Q?qbPAbwcWUEA64piZ3Kl/+/dsfA2hS2qloMLSlKKds+QR7N0vAiCaKeHMMAAh?=
 =?us-ascii?Q?GGWalM6na7FnNKr2kxIXMcH6scRariNHIeq25QjCeCK27CPZbByjMVsdgy8w?=
 =?us-ascii?Q?F2h1vdo3BgxSQhZ3tN/4GmH8Rc0SvrqFkpxfj1mEl3x9M5Kt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51a3b329-abfa-429e-26ec-08de95c97f6f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 23:49:39.5147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C551vZsPQ9d6MTj+QwjaSwvhtSn1iNSaHqDFWpX9JsXZGmhI3c3y1cIiToh4TAMp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8404

On Wed, Apr 08, 2026 at 12:44:42PM -0600, Alex Williamson wrote:
> In removing IOMMU_CAP_DEFERRED_FLUSH, the below referenced commit
> was over-eager in removing the return, resulting in the test for
> IOMMU_CAP_CACHE_COHERENCY falling through to an irrelevant option.
> 
> Restore dropped return.
> 
> Fixes: 1c18a1212c77 ("iommu/dma: Always allow DMA-FQ when iommupt provides the iommu_domain")
> Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>

I didn't think this was merged - I didn't get an email about it? Joerg
I've noticed alot of silent merges from you lately is that deliberate
or is something wrong?

But yes this is right:

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Kevin and I both missed it!!

Thanks,
Jason
