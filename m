Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8F520697B
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 14:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729088564; cv=fail; b=C1b6RY5nzhCjAkD8RyoNsfSOHdLhLuUFel0r4fZVZb/80yZyb/gfegV/eUeUlqCiOTj00uSUZyCyAmlFQ+CJlguyC8OZD38rFCsuGPHPnVuQgRyHhYrZb/DlDCBVV5sKWa4HyzD2O9gpJnKSjAqeqwaNIrnGhRxJmxbi8nvndis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729088564; c=relaxed/simple;
	bh=vyxaKdUM/iDQ9DxaMWfaIwghttEERoGQuQ4frAGj1MU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kTgY5zlVM+KJrBd90l7ujBkj64ZaHyeb+rEAYc+3VD/xSaz9+rtPj9PxMcLnyDE39ufpSUugBKBucUTPDzBRd10924qk3OTAwtkDj38s6LVF+F5ilsqCGGa38To4HA92jH0O7xBBUNmtDBfSYRKzXPgE8H3OknEKUsGLJ6ZrDgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ldWWO6fO; arc=fail smtp.client-ip=40.107.244.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ldWWO6fO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IzHQ6Q065Ydufo3EATCOQQVUWrX9yf7VTlApQ32zCR6JcZU/sqUOqtkxrIVsb5PcrBoy+m6/M58uqkPWLa36zb7kb2SJwuX/T29SrlW9jTob4FfIH3yM3peZ9MQsHtkQW+3aC+eFqCYISxOI8xhbYYFYNexgF9Wv8+qvOs1uX5Si3e101/67KKeK6HH9hIe7VCf3EiWOpq88JA1OVpfYtq/eAS17KcACeGa3KWfknRiHL3cdXwtEN+XusV2ujyPLCgW70yIioZgC+W1bXcn+ZDS5lOuVwgNv+FF7pODXenQUVEVEhy3C9XhWTn0apoHCs2EasF6HUWXKtfc4eE9mbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSExl1siaOrsvcH6Xk63qv1aVXvOxGZubPLU2umSNQs=;
 b=K3FPxXc/cB9/3+8Bnfu+rBm9J0ild+lXt5jFukF+AU6fXi2wRIEYSBeE4RtE8VjTSwjfzFlsFjoL4JdLXBldEL9IKLLsfLDwW/STH/XevthWT3AaLIQ9iSO35hCbZJbuIffRnoCi9Iq6L17EPEix/UkiyyIyJsUOqcU0fIm1mt7x7cV2VosihHbhT9DV/xGBbg0Ot9obX662OeyqT6s0diJAfe+VRdwhSwtxOesmY9DArpmGRSVjH8is120Ve/KuX4gtD5eoCkm0V+M/5yTqCWzAaDdaXLEKFArNSt/IHvDm5up35Wx+gykj253PHqFFz3uSkwmJWsFXhVgc0bl+6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSExl1siaOrsvcH6Xk63qv1aVXvOxGZubPLU2umSNQs=;
 b=ldWWO6fO7PnZuDSYkzQCI6mqgbhwos4ZCG3LPyaipr0rnr70wu6o84hkNkANt/7a0u/SV9GhbFZ9NC3LRWIOXJH2BOxakLLN+9rCKPxpuSpo28xXsYYNZM2fTcAQV4xkd4UjpaWJbIGrtBtGW54injTacOOPZtDBq0uPrnT5R8PEAtiy4/0nBthrmcPlKD5qlXJh39sZknRTjXnwHtoV1CccP0Kat+h5QqQ5GEIKrGMQfO7suuM0+6o+W6QoA3Y0E5W6OjALjCG+wHOpVthMzi8DTPnYRVf6aKmsnEcMExmmD3y5FXSbvIuHJKpU3m9Wd48eaddvh5YeWHjNkfdQaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB7224.namprd12.prod.outlook.com (2603:10b6:806:2bb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Wed, 16 Oct
 2024 14:22:38 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 14:22:38 +0000
Date: Wed, 16 Oct 2024 11:22:37 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	robin.murphy@arm.com, vasant.hegde@amd.com, kevin.tian@intel.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
	kumaranand@google.com
Subject: Re: [PATCH v6 0/9] iommu/amd: Use 128-bit cmpxchg operation to
 update DTE
Message-ID: <20241016142237.GP3559746@nvidia.com>
References: <20241016051756.4317-1-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016051756.4317-1-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: BLAP220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::21) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB7224:EE_
X-MS-Office365-Filtering-Correlation-Id: 84664678-957a-4b07-c12a-08dcededfcc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4pzGkQtrS51y0eTfDihhlUFfdssozjx+1Hf8K0TJVexXUulILBA2857SYVFI?=
 =?us-ascii?Q?8pIgUY1z3A5nZJhPHPlRpB1Cgf6soM0wGzp8D5Z0rhLqQwlBSWxnGJcOI9Jy?=
 =?us-ascii?Q?TeTcGTkRQMxrVfwA5vviptULr8AVtyWo1UbCUoqP71f3w5SYaIydGEzP8k+V?=
 =?us-ascii?Q?KcldyVUY7uvWp4wiEDQlysso7NesmPBpBCR05CE1/abLO8FhkDzgcXQFfaVS?=
 =?us-ascii?Q?7U74oSlDcrezJ/Xymttu6VO0orT7aCi3Dtobkf7O4D+KNNgpCU3gUXpoTusG?=
 =?us-ascii?Q?EFC5JTM1ZxZzU/jTePj3UuduI9o58NnLPy48RLMHnCVqqtuC1dCgp1iqXf7Y?=
 =?us-ascii?Q?ic/JoTE7tmQq0GBU1q1sgrZ4ZdWeO7zt1PS8x5ext5rfbUE68YySsE+vxp1S?=
 =?us-ascii?Q?YENlu7wG23VObvsejndGcXcHC7SVYPVXoK/ksnixq1I9Iom09rPqOEuAw7d+?=
 =?us-ascii?Q?v2vRDASPZBVXGljQdk1ehYMrZcaLSQlcmwSEFTMuy3qhJhyNdhzBVLW/7vhf?=
 =?us-ascii?Q?+vVR7eNPcQA7SAaTrLbmjNxw9a0XrH9HfIfQYMaMT4VTtXjmJlCix56reLiv?=
 =?us-ascii?Q?20hqbOJtnAFyaNvje+TiQ3fL2a7B3Uq0x2xlBHaifIUFw1ncuoRttucsCfvT?=
 =?us-ascii?Q?PZLp0KgvgR0JOWEclBncl9tSPS/7DW0kPrpphxhbihTuSWdRXLvyyHg5naG9?=
 =?us-ascii?Q?qAZAyeYmHvlZ1Z9zj5hOzOwhsyBq7bHY0GxhJCybZ+faXPhmPHZrRBHtI0WX?=
 =?us-ascii?Q?8iMezmVTJQiP82qt8PyDO9tDbcvZ3jAX0lW8aTGwL0rtBaCkXoe1pTU7hVTH?=
 =?us-ascii?Q?sKTYBtWt1+xum+fGQqxihOH7trrI3LRd6ruKozCmKaS4WJkGi6VHl0XVGYeM?=
 =?us-ascii?Q?2gCYPFdSes5W3JaHLX6XLAhYumNPR1GBZISSzRml1sUco3TvjtefOwXogJv2?=
 =?us-ascii?Q?JoheBn1b61svBQ88YH0rd5SOslsLzGRLEGY6YZSLd6bE0O/9aTsweDtizYIS?=
 =?us-ascii?Q?Dc+ksB1syiRjzZYg4lxPRNZuWpHgOgVfGwEHYp9TaWgAFO1q828GPO3CtaLc?=
 =?us-ascii?Q?WZDiIoRQRXVL7mZ5tv4PdntDUgKpUgQwyJGmVQRsG4rqj5ugDVxduTTHKKJB?=
 =?us-ascii?Q?Ln57mLcANylyeT+dlXFERTAFB630WwDPw9XsSqj1zAYZYiGalUNEDRaf3ZhH?=
 =?us-ascii?Q?cEZsaLMVs2AMopKILdhD2DaLGivVTSVQ7VkDU/V2R1LN5FtVsaj3Bl30mkuQ?=
 =?us-ascii?Q?k8/kyiituqF19ZpLmRcJY43o+etlweCysTH8jSAO0Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hAJYQO8w37CInaRZOmAKdly/KKNcat+sCHYliGgXJf2Bgz3GyJcNJ7WofF32?=
 =?us-ascii?Q?dpwX7oxY1ZIFUE/5siv4Ti5Qj9j+/PZE2QBi2Gz3dGSWjoL0DWgtPKZ4L6K+?=
 =?us-ascii?Q?T/L1Q6Wgtbv53gsw7VFeERX71mgjf2ss6b2HJMXiflfKU3IIb4pXsi4BnEUN?=
 =?us-ascii?Q?30J/IBKk+YzuwcuGRVdyy1rf7s/Od8JbrC2or3kdxOEveW+nkOCkOwsi4Lov?=
 =?us-ascii?Q?gXSbQe41yd8WeNHxniwpvG/+5QwS1go7W8pbxqD0geCL1W/HST9tP+5rudOn?=
 =?us-ascii?Q?AO4AfY2Dp759lgFPg/K0/kBkW9M/6KK+9qDM/pScXkLfw7YSc2D/byjQFpp7?=
 =?us-ascii?Q?iLPzxw6fxDzzWnnpZp1ZNASDyvm1wRlROBgyMzZ+KFK7m3zsy0nJGW3Kdr2S?=
 =?us-ascii?Q?MBHfOwlJQkfBCd3UJDlzq+377tAkuuhcnF7DPa0JpC2TpNjZ2kTc9gkUISiV?=
 =?us-ascii?Q?e0J/weRpssouAqT/fh4TldQcCDQslFl71GO4NgczCH5SwcA3Y7hD0mNy4+MZ?=
 =?us-ascii?Q?X95UAdRGbnndhBK9eXeUw3Pc+p/Ef5IFVDrc11obx8yXxPlt6JpBqIwwvwPY?=
 =?us-ascii?Q?k5oVdNoMeJw50a1xfLKptXBFU8jHDZs61WihxbQ3TaUdufRlHAf+hscN3v7B?=
 =?us-ascii?Q?+fwZ8SLTYN2VPxjAzbgkAjfUq3o6Pve51dT2rKUM90FUDN3BCnZRSrcPvrUB?=
 =?us-ascii?Q?v7Mc3/oLaCN9PoLyafY061VZFxyICmJR3UAc3cFUHCNDL31g/fUAvNLvUyRE?=
 =?us-ascii?Q?lri5EgFkA3F2Lz832ikcsNxdEllRKOGIiQqq9VDW+D/Yqwu+RrW8L9ThXWAF?=
 =?us-ascii?Q?KuqBk0aZEXYSYH7I4g1o9F/NReiiU21X3WWXSwuGaiCgF874U8Po+JVYbieq?=
 =?us-ascii?Q?oz5+StzogCCiXDtbm1TWACwX7SWFSezc8nK2XRUdagUapVElLG3WzLdXxmm1?=
 =?us-ascii?Q?32UIFC8Aa6oYHYukokDP2eCNGl/YN99zY3PTPxEVVa+ch8AwwfE/NK4EY5a2?=
 =?us-ascii?Q?Ov0l+HyjoHabITCXMX8las08k2MypBexETbN+Y5e4MwYyiVrbk3hPbf/VCo8?=
 =?us-ascii?Q?3J4fEWFMNkCTpZpRraJG+p/kK/1MftvP1cpHCQIbn4krpW2NCh7PPpAhEH5g?=
 =?us-ascii?Q?b/W1Oa5UQTFJ+ONh1tPSS38TOQ4kYgqPjp6wML7b8i41xDO/HIrF6ukIR+aG?=
 =?us-ascii?Q?hacsZ1oQZ64F1JPxBxV6w9dpM8ZYcmXb5KTtyGpjq7+whFCp85hsPVDL6KyB?=
 =?us-ascii?Q?qgkpNHL7Gcmq1uwZe0sFeXQvoAhCn8yDCLf6jBlFH6eQ5+mYgdxKIDlxDdEP?=
 =?us-ascii?Q?NKMwSHU+bo1dH7+0YDDasuIsso1OiNliGxWg1QLXFdGZZkJSet50Tqt4upfm?=
 =?us-ascii?Q?n4aw5Tx9IjwuXwU9SenIhYhAcfi0fkSNAjzgkeASGchAbZ/72662VeKaQ2Ry?=
 =?us-ascii?Q?ySAPC+HaWDircqeLQ39OtAO0+aoaa+yLqE/miPUTNgdsn0HBStjt6Y8UB9Ha?=
 =?us-ascii?Q?QXOTEJy9JaipftJ+mbXKL5FUDvNIuxL6v3vTl/ihugW12IzMYUQSnCJzZVks?=
 =?us-ascii?Q?rIx1m6ZLW31t16kBnoE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84664678-957a-4b07-c12a-08dcededfcc0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 14:22:38.4881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w6lxPSGYjuxkLHRxjNGREVDBAAdBkuxYlJVrn1mUK4bjZ8yFQHisgwe8iKkuAtD6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7224

On Wed, Oct 16, 2024 at 05:17:47AM +0000, Suravee Suthikulpanit wrote:
> This series modifies current implementation to use 128-bit cmpxchg to
> update DTE when needed as specified in the AMD I/O Virtualization
> Techonology (IOMMU) Specification.
> 
> Please note that I have verified with the hardware designer, and they have
> confirmed that the IOMMU hardware has always been implemented with 256-bit
> read. The next revision of the IOMMU spec will be updated to correctly
> describe this part.  Therefore, I have updated the implementation to avoid
> unnecessary flushing.
> 
> Changes in v6:
> 
> * Patch 2, 4, 7: Newly add
> 
> * Patch 3, 5, 6, 7, 9: Add READ_ONCE() per Uros.
> 
> * Patch 3:
>   - Modify write_dte_[higher|lower]128() to avoid copying old DTE in the loop.
> 
> * Patch 5:
>   - Use dev_data->dte_cache to restore persistent DTE bits in set_dte_entry().
>   - Simplify make_clear_dte():
>     - Remove bit preservation logic.
>     - Remove non-SNP check for setting TV since it should not be needed.
> 
> * Patch 6:
>   - Use find_dev_data(..., alias) since the dev_data might not have been allocated.
>   - Move dev_iommu_priv_set() to before setup_aliases().

I wanted to see how far this was to being split up neatly like ARM is,
I came up with this, which seems pretty good to me. This would
probably be the next step to get to, then you'd lift the individual
set functions higher up the call chain into their respective attach
functions.

static void set_dte_identity(struct amd_iommu *iommu,
			       struct iommu_dev_data *dev_data,
			       struct dev_table_entry *target)
{
	/*
	 * SNP does not support TV=1/Mode=1 in any case, and can't do IDENTITY
	 */
	if (WARN_ON(amd_iommu_snp_en))
		return;

	/* mode is zero */
	target->data[0] |= DTE_FLAG_TV | DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_V;
	if (dev_data->ats_enabled)
		target->data[1] |= DTE_FLAG_IOTLB;
	/* ppr is not allowed for identity */

	target->data128[0] |= dev_data->dte_cache.data128[0];
	target->data128[1] |= dev_data->dte_cache.data128[1];
}

static void set_dte_gcr3_table(struct amd_iommu *iommu,
			       struct iommu_dev_data *dev_data,
			       struct dev_table_entry *target)
{
	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
	u64 gcr3;

	if (!gcr3_info->gcr3_tbl)
		return;

	pr_debug("%s: devid=%#x, glx=%#x, gcr3_tbl=%#llx\n",
		 __func__, dev_data->devid, gcr3_info->glx,
		 (unsigned long long)gcr3_info->gcr3_tbl);

	gcr3 = iommu_virt_to_phys(gcr3_info->gcr3_tbl);

	target->data[0] |= DTE_FLAG_GV | DTE_FLAG_TV | DTE_FLAG_IR |
			   DTE_FLAG_IW | DTE_FLAG_V |
			   FIELD_PREP(DTE_GLX, gcr3_info->glx) |
			   FIELD_PREP(DTE_GCR3_14_12, gcr3 >> 12);
	if (pdom_is_v2_pgtbl_mode(dev_data->domain))
		target->data[0] |= DTE_FLAG_GIOV;

	target->data[1] |= FIELD_PREP(DTE_GCR3_30_15, gcr3 >> 15) |
			   FIELD_PREP(DTE_GCR3_51_31, gcr3 >> 31);

	/* Guest page table can only support 4 and 5 levels  */
	target->data[2] |= FIELD_PREP(
		DTE_GPT_LEVEL_MASK, (amd_iommu_gpt_level == PAGE_MODE_5_LEVEL ?
					     GUEST_PGTABLE_5_LEVEL :
					     GUEST_PGTABLE_4_LEVEL));

	target->data[1] |= dev_data->gcr3_info.domid;
	if (dev_data->ppr)
		target->data[0] |= 1ULL << DEV_ENTRY_PPR;
	if (dev_data->ats_enabled)
		target->data[1] |= DTE_FLAG_IOTLB;

	target->data128[0] |= dev_data->dte_cache.data128[0];
	target->data128[1] |= dev_data->dte_cache.data128[1];
}

static void set_dte_paging(struct amd_iommu *iommu,
			       struct iommu_dev_data *dev_data,
			       struct dev_table_entry *target)
{
	struct protection_domain *domain = dev_data->domain;

	target->data[0] |= DTE_FLAG_TV | DTE_FLAG_IR | DTE_FLAG_IW |
			   iommu_virt_to_phys(domain->iop.root) |
			   ((domain->iop.mode & DEV_ENTRY_MODE_MASK)
			    << DEV_ENTRY_MODE_SHIFT) |
			   DTE_FLAG_V;
	if (dev_data->ppr)
		target->data[0] |= 1ULL << DEV_ENTRY_PPR;
	if (domain->dirty_tracking)
		target->data[0] |= DTE_FLAG_HAD;

	target->data[1] |= domain->id;
	if (dev_data->ats_enabled)
		target->data[1] |= DTE_FLAG_IOTLB;

	target->data128[0] |= dev_data->dte_cache.data128[0];
	target->data128[1] |= dev_data->dte_cache.data128[1];
}

static void set_dte_entry(struct amd_iommu *iommu,
			  struct iommu_dev_data *dev_data)
{
	u32 old_domid;
	struct dev_table_entry new = {};
	struct protection_domain *domain = dev_data->domain;
	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
	struct dev_table_entry *dte = &get_dev_table(iommu)[dev_data->devid];

	make_clear_dte(dev_data, dte, &new);
	if (gcr3_info && gcr3_info->gcr3_tbl)
		set_dte_gcr3_table(iommu, dev_data, &new);
	else if (domain->iop.mode == PAGE_MODE_NONE)
		set_dte_identity(iommu, dev_data, &new);
	else
		set_dte_paging(iommu, dev_data, &new);

	old_domid = READ_ONCE(dte->data[1]) & DEV_DOMID_MASK;
	update_dte256(iommu, dev_data, &new);

	/*
	 * A kdump kernel might be replacing a domain ID that was copied from
	 * the previous kernel--if so, it needs to flush the translation cache
	 * entries for the old domain ID that is being overwritten
	 */
	if (old_domid) {
		amd_iommu_flush_tlb_domid(iommu, old_domid);
	}
}
