Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010022.outbound.protection.outlook.com [52.101.61.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E71A3271FA
	for <iommu@lists.linux.dev>; Mon, 15 Dec 2025 20:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765831894; cv=fail; b=SQ+FVSrOFDC/6gH96/DwaKvo9m6ORylpqvxIZ89HgtqMVf5TVikHcYkc8giGLUKLmqbttU3BodogtYf96WcDtpdosWPkaKIZW/NaFDG0RsQL7awCY6378sjwCdHX26s9edV0oVQG6k7zvujUJo5+blVzcMVuKnQ74iPxG13q6UU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765831894; c=relaxed/simple;
	bh=suaHnznKCst/Zobn0dYlnq3akQ2RaQbzHWDA/g3EqgI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OmJAj5VPBIVShdFOL0rPIQSxy9uSyhKDPsnkrVs1arMs6jDvxGDNSE50DwJpeBDyyKovbxdEsWW1tVrmzc61yG9D2m5lPIzxG5K2SvxtUVB8VQ8id63uXzk9UnlMDpBUTfmUeQcovA3uDmAgFaCHKDj1PePjUu2v0WIfsStqsds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NdVLj0z7; arc=fail smtp.client-ip=52.101.61.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NdVLj0z7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UJwsDouZ9ybU8L0H23XLaap+p4x/RhriDBx1Tifzf3PbrL+qVS99SnA0/iXkfYz7+3cbwc8NpFdLj5BkxtMVj+nGIGMHxjFqoNqleT/A0NRbRZTTnExptggyM/61raLUURTykPEOhpGmmh+0/bDtKDaq06w9pyYBEaM0EU2fwbRyhn0c6nUpZG04sLRPkVsZo1K09EmrVvA09FKVi2LcEMk/Ogy/W42YAPP+Mf+/zoFmIxts8gmxwHetPYVnBbEmv2NB2GO01+MFQbHuQfuRMH9Vzh1JL/rdwo8lEymUZtNrC+tPU7Q6/lsGCF2ofQak5pk9g4jRWm/DrEjph/cGYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JX+V+W+1X2u/0NoJmb1ffRLWVHGWJOHCw1Adi8+j7ys=;
 b=KIQK006+TyxODM/RFFPLPf1AJbBOo1rQOQamt4jT/OkbMuru44rAeWh85ZDvLo4UzhkwYKNKLmugZOup/FnJgXrZ+8hkzHiaRvPN2a3MuEkDgr1xvhmc1awQafB2vZLC5IxAz9j5fqayf/dpz7/jzkznZAvJxsqrig4sl+Tbden6vKUVutXCvxFN2j8Fjl1uNVBeMMwo12bfMrh0K2se6LKulYW9Cw8YnJDmF8haa3gspwIJax9twpT4xPXqPwjdilvTYcTji6FjrIxt7KHW5z6CzhZ6Q9ouaPd9DxNA4UQsfrm6yFjb5w51fRpe+7RgpYQRzmEV3YwuUUGIIfFA1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JX+V+W+1X2u/0NoJmb1ffRLWVHGWJOHCw1Adi8+j7ys=;
 b=NdVLj0z7hwVTYywuI+W8oMjITmLgm/zqc7/pvv89UcL/cKOxcPBul/KEUMbGjR+CZnthOxf//URAVnq2sChNLDWT4fVEG67MRWizV4yCydCwJEEImzR2Hl5pSjvLk5BQ/AoeWo43ybBQ/E8iRZZsbXBQqEZDljX4eRNM0newEfFXLv3klmw8iewQnp0hB7/3M12+w9R0kiUGV1mZiGEUC+SCO4UMPp3uNUEuVqM66u3ZNgkB2LAXMiYpgiLzUyPYQgvR9EkZMjRKIl6BlQJAW+vtl5L67/YMCqBNKpy2rNoCEkFbuVtF6gAUW6NctLr/wKjLr/lNuzSUQMKlj+94gA==
Received: from SJ0PR13CA0125.namprd13.prod.outlook.com (2603:10b6:a03:2c6::10)
 by MN0PR12MB5740.namprd12.prod.outlook.com (2603:10b6:208:373::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 20:51:25 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::a2) by SJ0PR13CA0125.outlook.office365.com
 (2603:10b6:a03:2c6::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.8 via Frontend Transport; Mon,
 15 Dec 2025 20:51:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 20:51:24 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 15 Dec
 2025 12:51:05 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 15 Dec 2025 12:51:05 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 15 Dec 2025 12:51:04 -0800
Date: Mon, 15 Dec 2025 12:51:03 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Mostafa Saleh <smostafa@google.com>
CC: <jgg@nvidia.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<skolothumtho@nvidia.com>, <praan@google.com>, <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH rc v3 1/4] iommu/arm-smmu-v3: Add ignored bits to fix STE
 update sequence
Message-ID: <aUB0t4MSf624Wwmw@Asurada-Nvidia>
References: <cover.1765334526.git.nicolinc@nvidia.com>
 <cc0d4ab571e2e789ee1cddfa035379dc54f0601b.1765334526.git.nicolinc@nvidia.com>
 <aT87A1ur4htPjM5T@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aT87A1ur4htPjM5T@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|MN0PR12MB5740:EE_
X-MS-Office365-Filtering-Correlation-Id: 026cbcf4-cc7d-42c5-d486-08de3c1bb617
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OEEvWnRPSmZsSkJHNko3RkQ1N1BNMXJBT1hpZnAva3pQdUkvNGkzK0lVMlZL?=
 =?utf-8?B?RWZiWGg2TTVzNnNzcS9sSUMxaXBUek1wS1dJc05WRUo4NEdLZXZPR3l4SVlP?=
 =?utf-8?B?ZEJTRWJJNllZZ1piYVFUa2JKZ3BPUmVTbFBVRS9lYUVtUUovYXordWtQQzRV?=
 =?utf-8?B?b21pRnBkM0NMWHhMekI5NjYwZjlEamRYTUJOdWZMVUF1T3RTY3BTbko0OG5r?=
 =?utf-8?B?RkdKTm00K0tPWGFVaUx4RFJid0xyTk1GL3V1UjgweHR6VWU2UE1tTUZHOWQ5?=
 =?utf-8?B?R213eG1Ucm5ia0U3K0hGMGV0Zlp1QmZBRjMxTDR1Qk1oZUVBNjlkK01zN2tk?=
 =?utf-8?B?L3NmZnZZUmw5cCtQaGhweW0xUXg1VDlFY3FseEZJTUxHQXRZaTlRUWZ2UWdB?=
 =?utf-8?B?UTdVUVh5NXd4ODlDa1FLRzA1bE5lRE11OUo5aXJGa2lqNE13Z3dyVHp1N3Qx?=
 =?utf-8?B?OUZIMW9PL2ZMNk41NndhTnVSNnZRcUtTRnR4UVUrdkluVTlGSHdVQ0hUQXIr?=
 =?utf-8?B?cTR5MHluT2xBZTM5UFJYNklpNnZySnV6a3ZnQ0dhdTVyLzJhd0o2UWZTbkVw?=
 =?utf-8?B?bXdrdzdlb0JuSkRhaUhSaXNMZy9hU0oyWStBY2JBOWtiZTNvUGxUYndHMlhu?=
 =?utf-8?B?SWVkUTVaSzVvZVhNZEFmRXdhc2FmTzZHeFRjSjBQQVpTQzFtS1k1Q2ZVWHpq?=
 =?utf-8?B?TVFKR1JlSjZiK0h3cFZUV3Y2eVlYL3REK3dwNHlmODRqRlRLQlFhZHg4OXJR?=
 =?utf-8?B?dS9KMHBITTM5OUZkTUgrUzA2RVVOZE5UaW5HbDEwZ1ZGWlNOTUlhNkx0a1lC?=
 =?utf-8?B?NEtpaEEzOWM4bnNUTGl4SjdxcWZWYStld2JCSE9adjY1YnFLOCt0ZjJFcnBG?=
 =?utf-8?B?eUwwRlNUdTJ2RGVmRmNUYUlyZUQ3aTEwYVdLb3pCYXNodXIyYjhXZFB6UXJE?=
 =?utf-8?B?ZjhndWl5U0p0WTUzWmZxWTJyaWc1WmkxR1A1TkFPSE5YMlRFN09HUTlBb3lV?=
 =?utf-8?B?U2tXNWJ0N2JDVE5vQzI0SnlVdTNYeHFxRzN2UnZxWjZXRnZ5ZWhibGNMYVNh?=
 =?utf-8?B?VHhYUXpYV1hBRExsZGdxMmZJVTMydmRhRm1PREVpVXBNWGhNL1JOUDdrOE9w?=
 =?utf-8?B?WUJHRnJKL2xqcDhUbHk5SnRlb2poN0ZheEgwSXUyRmhkZ0NMOXhVMUlwT09x?=
 =?utf-8?B?Qmo5UkE2NktDVk5rN21aMG5zU2xrWm1uZDRCWllIWE9sSG5QTUtUalptZzJs?=
 =?utf-8?B?eEJOdDljZks1SnNlSHdkS3Y2TFdGbWlDRVJtN1QwN25ZRGE5eXJEM0xjRk96?=
 =?utf-8?B?K09DOGE0UEI3anVhcnNreG1hcTl1Vnp1VDBTVlRWbkhvcUIxWUcwU2Q1Nkt0?=
 =?utf-8?B?K2Z5bVl2VDFZVUtjZ1VRQk0vN0sxM0JkWnluVDRVUkVLVHgyWlN6QjQ0dHFW?=
 =?utf-8?B?T3puMHRqWkIwYTBHaE9xdm5SejJsS01ERlBYZHBGSTNVMm1rMGpSVVZlTnhS?=
 =?utf-8?B?VG5DZE9PTTl4YzhwcWhWUXNrYW9LQkZtZXQvSzJHRTRaUG9ZVVRjd1VkeEZ3?=
 =?utf-8?B?RDlLaEo5S0VhbzBWcExTL3AyQk5Ga2J0M2lJenJiVzZpTlk4aTRHQWNyVTBv?=
 =?utf-8?B?ZFI3YWpGNVNFVzMxSzI0bUxEa2hKVElIYkxLanpsZzVmVlRoRVRPMDdHWko0?=
 =?utf-8?B?Ti9VcEk0V1p3UlJWSHljd01CSTRLSGFhMVNGOWRmaVJmcms4RUI3WVdKaVZW?=
 =?utf-8?B?WThzalBhcERYVWcxclBxSldVWWZObGhLVTdUL0VqYzRId01uMUdKanBwTi83?=
 =?utf-8?B?WC9GZUlzcU5NT1piTzV6bjFuR2dRZmtuOVFZU1NEYXRvNmVwQm9wdmNqTVpj?=
 =?utf-8?B?UzZnQnlNb3FleW1sQ2JFMTFhNDlrc0piNkRYNUhkNHRQZmJzZWgvMlZDSHJr?=
 =?utf-8?B?eXVvYkcrRTJUS0UxcDV0YTN3L0NKOGNKWmQ2eExObmhqb1hCM1FOYjJvcjN2?=
 =?utf-8?B?c2ZpWWl1bGlQV1N1c2pGdnlhc1l0TXAydXlDUnlteStFRGs0NGRlNFFEcnZN?=
 =?utf-8?B?TDdBWXpwdGRwSHN2NldGcjBkSjhKaUxpNzY0aUM5cnBNazEwQVI1eE5XOEgw?=
 =?utf-8?Q?AvzA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 20:51:24.9821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 026cbcf4-cc7d-42c5-d486-08de3c1bb617
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5740

Hi Mostafa,

On Sun, Dec 14, 2025 at 10:32:35PM +0000, Mostafa Saleh wrote:
> On Tue, Dec 09, 2025 at 06:45:16PM -0800, Nicolin Chen wrote:
> > @@ -1207,12 +1223,9 @@ void arm_smmu_write_entry(struct arm_smmu_entry_writer *writer, __le64 *entry,
> >  		entry_set(writer, entry, target, 0, 1);
> >  	} else {
> >  		/*
> > -		 * No inuse bit changed. Sanity check that all unused bits are 0
> > -		 * in the entry. The target was already sanity checked by
> > -		 * compute_qword_diff().
> > +		 * No inuse bit changed, though ignored bits may have changed.
> >  		 */
> > -		WARN_ON_ONCE(
> > -			entry_set(writer, entry, target, 0, NUM_ENTRY_QWORDS));
> > +		entry_set(writer, entry, target, 0, NUM_ENTRY_QWORDS);
> 
> After this change, no other caller uses the entry_set() return value, so it
> can be changed to return void.

OK.

> >  	}
> >  }
> >  EXPORT_SYMBOL_IF_KUNIT(arm_smmu_write_entry);
> > @@ -1543,6 +1556,7 @@ static void arm_smmu_ste_writer_sync_entry(struct arm_smmu_entry_writer *writer)
> >  static const struct arm_smmu_entry_writer_ops arm_smmu_ste_writer_ops = {
> >  	.sync = arm_smmu_ste_writer_sync_entry,
> >  	.get_used = arm_smmu_get_ste_used,
> > +	.get_ignored = arm_smmu_get_ste_ignored,
> >  };
> >  
> 
> I have some mixed feelings about this, having get_used(), then get_ignored()
> with the same bits set seems confusing to me, specially the get_ignored()
> loops back to update cur_used, which is set from get_used()
> 
> My initial though was just to remove this bit from get_used() + some changes
> to checks setting bits that are not used would be enough, and the semantics
> of get_used() can be something as:
> “Return bits used by the updated translation regime that MUST be observed
> atomically” and in that case we can ignore things as MEV as it doesn’t
> impact the translation.
> 
> However, this approach makes it a bit explicit which bits are ignored, if we
> keep this logic, I think changing the name of get_ignored() might help, to
> something as "get_allowed_break()" or "get_update_safe()"?

I think "ignored" itself is brief and understandable.. Instead,
perhaps we can add a kdocs to make it clearer:

/**
 * struct arm_smmu_entry_writer_ops - STE/CD entry writer operations
 * @get_used: Output to @used the bits used by the hardware corresponding to the
 *            configurations bits set in a given @entry
 * @get_ignored: Output to @ignored the bits that are listed in the "used" list
 *               but allowed to be ignored by arm_smmu_entry_qword_diff(). Each
 *               field (bits) must provide a reason to justify that the entries
 *               can be updated safely without breaking STE/CD configurations.
 * @sync: Operation to synchronize the updated STE/CD entries in the memory
 */
struct arm_smmu_entry_writer_ops {
	void (*get_used)(const __le64 *entry, __le64 *used);
	void (*get_ignored)(__le64 *ignored);
	void (*sync)(struct arm_smmu_entry_writer *writer);
};

?

Thanks
Nicolin
