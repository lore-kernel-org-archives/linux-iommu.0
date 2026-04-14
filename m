Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010013.outbound.protection.outlook.com [52.101.46.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AB73E6DF7
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 14:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776176465; cv=fail; b=dej6J41p88kPIj0JXmpDYWwMh7thYVZcrvqhHZ0Z+VJWOjYFLl1+Ph3qAjZ4UsF8t3dBI+i+2W50N2Wxjl6BUiubWHCdBgGgT5RWNW+nS5uRNOMJ/pqEd8pjs4skkkRd2T0fFjcQrpg1tS/7wvoDOxfxDvElSrcacA3gpNd7r4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776176465; c=relaxed/simple;
	bh=gKmBef+nm6zf1NlDDm9Jc8vdMjKwuC1YQLkGwESLllM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X8DUpWqdx7F8CdRMf6R9inBxoA5QEUzWLzssvPFIRw9Z8RJJyci12dt9sz+tKGUGaQXEzAcs00viLajyR3YY9HPtWFsOmv9vrDyhnnUSyuZwGbE9OpZJuHXxkQaqAVGC3AFtiIS0TlGcoEczYStQ39/XHGtpuxO+Q9tcZ/Yx//M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tGCvGboa; arc=fail smtp.client-ip=52.101.46.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tGCvGboa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bv1hesu3IRhU8pU3c2tPe8hAuaL1aPMXBNNOmCeHk6/wJrhfxIyPmN3S8y+LQxKqxa93Mh5+dU8suQ33eeCnGzITtz24Drad+DWcRZ2ggWomCXsAtxWDU5wXNMaF0+pLVmo3M8r1vCNFmW1F4D5N2UOUrCh1o3xPq4BeLEawetLYyR5bXJssljiV7MZATY5i8JSWLuS+sczinNIUOUrAUQXS2RqPN/RwUroF2+ddlUfNEuVLoadq/HSQujCX7lV15qOATbcdoLMlxRqxB0lBposnb1rZcasq+Jg8Ure7ACQhnVe4RNr0VBRVrH8mjl/mOTXLQGHDQZTXoYUoKfoqQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BECVdri7H93GrC8TPSdrOphMJfU4YLTUy77oz29Oz8g=;
 b=T+SZ5jau0TLRtoNqpGJmzLPbc6qnM4jEg6J1NIlwn2/XRZtiuLrR2/W/nNhYhpxkezc/ZJZxQBb2dcoNmeR31dr0wQZg4e2YFVRhq8OA/qHZ/wQFKegGAlcQvpcd9Dw8U1dD6hQez0bh37EYd/Gmwn8IwppRRTTByFkx7sGTumi28ky+4j9CPpwhy3sZmWqrgDecddw5GQjAr0ZcA3sxxvF9pnvHWqOBMpNuwKLJPGj7cK2bOl/DIzgS5mmUjbgCNaB7Y27DPbTAWUGEPgIVCw/KEbZdfF0ke2l4PcV3F3WP8qT3e0X7dde4gW1MuJKHUW4hnAB7DersoCvEq9in3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BECVdri7H93GrC8TPSdrOphMJfU4YLTUy77oz29Oz8g=;
 b=tGCvGboaleRdPC35kxuoAiOTIkWRBYrEArFMP3pbHgbal5a9ourE7Vd4BuvnbS/mr2zS6UxB/KmJ3I568C+FzpiVHdqGQ8veu25PWwpvI7Pp27DwKCabKr3Fp1c+T8B0x0k/28bucaRPYkhejGGBjqzWk1kKl493vOMlKUATVWhuCAgdfzLNXYNwIm0vCI5irnIWFJxJQDhpYl9gB7lAko572F+eW9wyP5xbvlb1zyUx6Geq4SxxwwZo1JwZKtaTq0HEB/9gd1J/1z7cEmD/q4FMVsCIlEw/gzFL0rxuOlzsy3/+J9afYQWtH1U4/dmZ1WePGkDU/2fREhOhmQFJtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
 by DS0PR12MB9323.namprd12.prod.outlook.com (2603:10b6:8:1b3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 14:20:59 +0000
Received: from CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3]) by CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3%5]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 14:20:59 +0000
Date: Tue, 14 Apr 2026 11:20:57 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: joro@8bytes.org, kevin.tian@intel.com, will@kernel.org,
	robin.murphy@arm.com, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	xueshuai@linux.alibaba.com
Subject: Re: [PATCH rc v6] iommu: Fix nested
 pci_dev_reset_iommu_prepare/done()
Message-ID: <20260414142057.GA2643091@nvidia.com>
References: <20260407194644.171304-1-nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407194644.171304-1-nicolinc@nvidia.com>
X-ClientProxiedBy: BLAP220CA0025.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::30) To CY1PR12MB9601.namprd12.prod.outlook.com
 (2603:10b6:930:107::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9601:EE_|DS0PR12MB9323:EE_
X-MS-Office365-Filtering-Correlation-Id: 1408c0cc-6989-4770-165c-08de9a310cc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	a4a6cOuu1iCiYfWXqgDO/2EeXGt+syzq3T1utQNFOibln8ObNjgl2d5IrKouDxYiqrvQ0darE2MBTBu0H/y1vVFOap1hZS1kvh5pMlts4bRNc/nKG2cPkcOLzJqK9c5FWAJa4Lc1n4THMwgLlYxXNkVBkRfx6siKsDpM0mEq7KwNsWSmjFpWiFGxnEkNv5R6OH+5y/2ibzck3vrXmRjYHYot4tgmmiWpA6/n9VvXoxmiBOlM+zTth1lt+lpcWyxyeTaYPwaw84RijLpLOYGjqF6bE/FyA28I0mAp2++cfoKjmTxleLxzYomrf32fs1pu8AEHrYUYsln96XtcjIuBlbMATzrChN6a8hKL6KVLocVQKsAVmbHdnXVWNJhkwSnEYSaCVqXc3tW5O/VsdTmoEu8u8qPhan+XoYY+LTOEwSEWM383vOKzoAEKPJAKmqCahOliEtc2ZhCtvUlOIlvBqv/vj2G3nlgjEcy6/EXca7jqXUdbkejjAzL99lE3igH9ks77kYCGlhzUd61ZLqyahEGRGbRxpwV+EdTP4AJ2T49efODoz86PvvoLk7sNiG1WxEe+NqBOww9hP1rycDqM5X8RzGMRxjWDxyeO2EX2K6NyWOqKEOetU4U2fnT7sM2xcwNerZbisuXacLFizI4rsY3ahPumQa89IlF5+sspLD283N3eN6OPhOh1DIuEtCXLgbu+zHi32SQix2vV0hK1rhBBG8o+97PXrsaQv6DbiRg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9601.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0XKQJq/QjMu8uukzp2VzgnmpYy009W6r+9XfkrfaM0N4Rid2VrWHtCUKuAAj?=
 =?us-ascii?Q?HDh7N1MzIy0chlbtrRzU5oH1Fdh6AH94v77BPh9biJ2DR0M4evqahYi23O2x?=
 =?us-ascii?Q?BAmVMk706CfQ0RtOBvfmFW88YZ4D4fM9CExdW2PFzaRov+0gKBVVjfdyLoUa?=
 =?us-ascii?Q?/4x4JKDE+gU+6xzfDKancQDAgPXeZS4KZCe622D8QyUIqpwroUwQ4gXJcSuu?=
 =?us-ascii?Q?1lFo443CJHnAULDyUZZXw+5CzxpNr1avQ/K9otaaWsiRoYY8sFmrt4ptugoT?=
 =?us-ascii?Q?bIN2KN3EpDg5y7hdm6NOzAVzgeqNPSCPMKlOmI5a+U9JpzvqLztpMDY8RZrw?=
 =?us-ascii?Q?gTrzE5fgVESK9KMsQtiJrE1tZ5MO/MuG9q7RpNFayNgJLqSvZjnIvTyIQtCc?=
 =?us-ascii?Q?2gqgS8kiEzljYx88umHoYajmjf85+766k2jsWMhnitlSi2uc6uEn6pxARvg3?=
 =?us-ascii?Q?WI1s3S8cn2lTBAPC4xuM8nq3fzr36SkHGsucETVzporRPX9EREgrg6KBygCm?=
 =?us-ascii?Q?x8x2DCVaKk0rXUnXX2rDkU+dlm422/eEWFTTy3i+A3KBxkpU6I/aiMtkmo9N?=
 =?us-ascii?Q?JShEVB93bJ7NkkCHMxvV4MuxLNXQtjATym1Bdb6CPQ88epar5wlNiU8vCtEA?=
 =?us-ascii?Q?eAJ05kyx+rZmfXz2Zep+QmHRwqwqNA7NtIfJ0wWaIOAt019fY0UVoXSj5PKD?=
 =?us-ascii?Q?oIBDYT7+u22DxrozOsFqYiMpE6vmD4NJx8x0LVdDHXwON4B8q78zFdiBX9au?=
 =?us-ascii?Q?rhcBF//1qonZIPHf4TXyKtLNQ9e2ALKUTL2HA1MfuzIL016hVZODD+oXrtDK?=
 =?us-ascii?Q?rYbyG0+Q0bdPt2BH36s/ifDMT4HHNcb6N+ylmYZRLm/B9vM2gABciCMutGXk?=
 =?us-ascii?Q?4R/o5yEsu58RB6DVNqE04ED99/dxxnOd1JliNjQObdtcUJtm4J/VubhhK8i6?=
 =?us-ascii?Q?sADpwkDG2vymkMS+/cWo66WTzLYoqyxIB0SYdix5sLrG5z9+rINsBLWIAB+F?=
 =?us-ascii?Q?L2k02/hj1t4EMRCqmYnNeSaJsXPWZiiQ47i0c3LCaf81grOWh60AGdfjI6DY?=
 =?us-ascii?Q?VPfZWW6I0LfnovgiEx7krh27bux+33MMPRqSW/PxkOx8PnSTY9bmPcxeA5Nc?=
 =?us-ascii?Q?tFe5ppdqhO+B6Q3dYz0mOos2O1YOL07cdLMyVIHBFlvWZeTkwRx+o8eCeM+V?=
 =?us-ascii?Q?NHqHjzoafM8x5RWVgufSFS/N7VfEcqnvL/AFUkRfhoOzpumFjtSRwZU8435A?=
 =?us-ascii?Q?Lhkk116glYuD4nUf7j7DqDjYgUSmbq3/3Z+SEYeh7VegJbXf/fwOhPT+YfkS?=
 =?us-ascii?Q?X/bVUC7fETi+PTa9rY8lz0n/N/EHZN+ftTSr6s53ryXkeYs8g0wqABQZiKF8?=
 =?us-ascii?Q?gVgCPqqbdMpaX58ChXkoNnIEt9yk/COmsc+GgosSy528rk45rJ8e3DQUsA4E?=
 =?us-ascii?Q?4UCdMo/rGekifNSoxSgNLe20jH1RSI4iazEviUTN4D+su5E6A1wrY1DbYdjX?=
 =?us-ascii?Q?LwNcffivepUt9RohgLtvO+eLVFFcUt+FjWF6/WYg2RRH/Ek9pe7Gniah4qF8?=
 =?us-ascii?Q?JxTnD2IRduN3VRZKWKU5Zo5xXy4QA+iIoJRWb7P9N2aacM8HpCnksrePgv/U?=
 =?us-ascii?Q?lH1ceo+eA2BaCNJDZ/uAbwUF5oNEUr78KahY9lBQ3cxaDOJAwwlb4inFkk+H?=
 =?us-ascii?Q?OZLQpWks+EQgAjjcyogWvoRLs99bAqPvqAeKgNjXZIc94w0J?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1408c0cc-6989-4770-165c-08de9a310cc6
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 14:20:59.3647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8vo3st3s8+pS5YgM0IqV3PYb8JNhD4roNr2VEEiS80TGskMRwv/1FCAt9zkSI+Hs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9323

On Tue, Apr 07, 2026 at 12:46:44PM -0700, Nicolin Chen wrote:
> Shuai found that cxl_reset_bus_function() calls pci_reset_bus_function()
> internally while both are calling pci_dev_reset_iommu_prepare/done().
> 
> As pci_dev_reset_iommu_prepare() doesn't support re-entry, the inner call
> will trigger a WARN_ON and return -EBUSY, resulting in failing the entire
> device reset.
> 
> On the other hand, removing the outer calls in the PCI callers is unsafe.
> As pointed out by Kevin, device-specific quirks like reset_hinic_vf_dev()
> execute custom firmware waits after their inner pcie_flr() completes. If
> the IOMMU protection relies solely on the inner reset, the IOMMU will be
> unblocked prematurely while the device is still resetting.
> 
> Instead, fix this by making pci_dev_reset_iommu_prepare/done() reentrant.
> 
> Given the IOMMU core tracks the resetting state per iommu_group while the
> reset is per device, this has to track at the group_device level as well.
> 
> Introduce a 'reset_depth' and a 'blocked' flag to struct group_device, to
> handle the re-entries on the same device. This allows multi-device groups
> to isolate concurrent device resets independently.
> 
> Note that iommu_deferred_attach() and iommu_driver_get_domain_for_dev()
> both now check the per-device 'gdev->blocked' flag instead of a per-group
> flag like 'group->resetting_domain'. This is actually more precise. Also,
> this 'gdev->blocked' will be useful in the future work to flag the device
> blocked by an ongoing/failed reset or quarantine.
> 
> As the reset routine is per gdev, it cannot clear group->resetting_domain
> without iterating over the device list to ensure no other device is being
> reset. Simplify it by replacing the resetting_domain with a 'recovery_cnt'
> in the struct iommu_group.
> 
> Since both helpers are now per gdev, call the per-device set_dev_pasid op
> to recover PASID domains. And add 'max_pasids > 0' checks in both helpers.
> 
> Fixes: c279e83953d9 ("iommu: Introduce pci_dev_reset_iommu_prepare/done()")
> Cc: stable@vger.kernel.org
> Reported-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Closes: https://lore.kernel.org/all/absKsk7qQOwzhpzv@Asurada-Nvidia/
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
> Changelog
>  v6:
>   * Update inline comments and commit message
>   * Add "max_pasids > 0" condition in both helpers
>  v5:
>   https://lore.kernel.org/all/20260404050243.141366-1-nicolinc@nvidia.com/
>   * Add 'blocked' to fix iommu_driver_get_domain_for_dev() return.
>  v4:
>   https://lore.kernel.org/all/20260324014056.36103-1-nicolinc@nvidia.com/
>   * Rename 'reset_cnt' to 'recovery_cnt'
>  v3:
>   https://lore.kernel.org/all/20260321223930.10836-1-nicolinc@nvidia.com/
>   * Turn prepare()/done() to be per-gdev
>   * Use reset_depth to track nested re-entries
>   * Replace group->resetting_domain with a reset_cnt
>  v2:
>   https://lore.kernel.org/all/20260319043135.1153534-1-nicolinc@nvidia.com/
>   * Fix in the helpers by allowing re-entry
>  v1:
>   https://lore.kernel.org/all/20260318220028.1146905-1-nicolinc@nvidia.com/
> 
>  drivers/iommu/iommu.c | 148 +++++++++++++++++++++++++++++++-----------
>  1 file changed, 110 insertions(+), 38 deletions(-)

This looks reasonable to me.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
