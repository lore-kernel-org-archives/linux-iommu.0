Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010055.outbound.protection.outlook.com [40.93.198.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9508926158B
	for <iommu@lists.linux.dev>; Thu, 23 Oct 2025 16:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235328; cv=fail; b=L+nDdeFLTZRuyWEeZNVkK4rU1WHf64jpUEtVWIfi0LGjs6LEFTi0dlxxmpwk+E33lHoBiZr7HEYqVBFFkFNejHlkiuIrYIAOb8hanp8Ksn889JYJP5fEQ79H2WYLxmrt1jIa3iqBUgRteG/1Gx18HQasJ21L64cnVvnuvEEbCis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235328; c=relaxed/simple;
	bh=Ys1tT75AKsUHmTcgGBe4LLNfDrUccGZMXCpOiH0wFbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gSq9W6lM7VXGt2Z7ZDrg1yGgQqcHkhf8U2ZrCjMOPcwB2HdqQS5sOFM3F3QgVJPtpdkl5aUcWdFwYlOzPSEHk9ttzA1aWZTp91c8UJfxtI4a68JYi9xo0UqwWJWEcpmyVqG8CAt7Qv7IE9Atm6l7bmM18vX4D7DU0RLwfnpAsGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Dh6m46YM; arc=fail smtp.client-ip=40.93.198.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dh6m46YM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=unAa6jMFEo2Fr6FKjEDwVWUDh18RdaG4TfLp3hyy4eJOZSITBMqIpzLdl50d3ExAutoG3LEdoZ7roX2z9KY+5UiPruXsn2iQdSkT2DzO9yNIk2REMom0t88KNo1sVx5LgjOLWgbBJXxbB07DdVAtyX0j7aMa3UsXmxX6EgDWG7tiPjeu4zfi+ocV7ZjbMdtQmSZlwcHtb+DT4vPsaUbJeK2MXYSR6XyCdzhafd5fbNhEMsH9zDjULlPYsNghnv2mxcbzioipLt6EEcLzxsMWyQPy5/+d8Iuk7cqCoEAITo4ZFTFF6H4/OeYMw2y2zzwd+TR8ACaaUb96Rl+qHV74rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFOYrXw+UnMf7QJB6t43sbdRZ1QiLrprA/G4hxc+Rz8=;
 b=PiJhv5MzVZqT1lz3QiMhvAkMPFDDBvMu1pSsDIW96KOfzgcMKymomaj7P4+xQlEP9XeOE2zQIEZB1Z5SYIQhBCTXEmwAaqNZ//y49CZYl5/72H+G/5yhn1KezeCMAqSbbhoOFLeKsplhMi+FMLVi6pGf1/iHZA3RLsvBZZMnpTVF7hNwK01yN3hQeI/Fyq60RN+n/LffyE7Xo3Qn7p5TGi553Fh3J5UUwFsLntry/2tY2Ij/mGpVzw6l+nJKHZ5Eh+P50aG2MI7JrGrZ2QvO1vCWWlk+IpZuIPO499OV35KN3VNh1t92fXK7+xIg5tFwTMiVZPWR7lfvBJhyMjLk8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFOYrXw+UnMf7QJB6t43sbdRZ1QiLrprA/G4hxc+Rz8=;
 b=Dh6m46YMviu0YW9+b9M1NVxxu7qS/9Q0Qvdy1FFAwszQRPMC8WniaAkaYgva86cBAYfKQO1R2GXr5sgX6VOPy+pnPBZjE3RsSoQ3a8PUKGAPYEV/rcD1MtRzgy6xt0Y5m/QN74xiJAaEBrGjHNy4iO6RQXIEwDAjDnYtLeAfzrbZBIN6LLWa1ghKKqWBaYXKXPzbXqiDQMQt2FQ3eU6xZ4p/KXWMDnQDv/+5t6pgX+o+YfJB9nTnyNfUtb/hbh0AJF1YRWmveu7bTMK7e4Cuikfq8KIw4eqo3SwdRSiI8CtNstoiKH9qQkk1fPwoIBLjXbYme0fCGRyZkPmwur30Ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DS2PR12MB9640.namprd12.prod.outlook.com (2603:10b6:8:27d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 16:01:59 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 16:01:56 +0000
Date: Thu, 23 Oct 2025 13:01:54 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Wei Wang <wei.w.wang@hotmail.com>
Cc: suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com, jroedel@suse.de,
	kevin.tian@intel.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH v1] iommu/amd: Set C-bit only for RAM-backed PTEs in
 IOMMU page tables
Message-ID: <20251023160154.GM262900@nvidia.com>
References: <SI2PR01MB439358422CCAABADBEB21D7CDCF0A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SI2PR01MB439358422CCAABADBEB21D7CDCF0A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-ClientProxiedBy: BN9PR03CA0755.namprd03.prod.outlook.com
 (2603:10b6:408:13a::10) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DS2PR12MB9640:EE_
X-MS-Office365-Filtering-Correlation-Id: dad426da-ce32-4961-5007-08de124d7d64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k/lDv9BnQ33H6ucXs/QdMzD24or++KFR3IGTYPyevN+yox1CkkCzrkNMHtHd?=
 =?us-ascii?Q?JKdPJVtWmI26RkxCLdj9IUlHviFX8Uq3y+atR1q5odKTZdIeBJ37RGssS1+R?=
 =?us-ascii?Q?YxlHoPbgHPrIjOlcT5FAIPAd96nvzRxyCxPaiWOUHGox0lvaTvMaoZO8zaOx?=
 =?us-ascii?Q?ysQ/Ckr4lNdwZAvbDRNKPYkHODfkmMHRuXmI1JlBQ5NjEV9OHY1a5IaYWfSQ?=
 =?us-ascii?Q?mGF5LAXDSEqz1/pFMdLvN08HbEDz8ASJJAcpLao0hQKeh9mS46Oc0sCcMSEv?=
 =?us-ascii?Q?eZ/RDbECNFw1Hg7w5xdys+oY6cJEd/RAKchAEavcvVF2hFHj+MCJGF9XZ0jI?=
 =?us-ascii?Q?JIWq//4NZ1Q4W0FCzIZHTIL6/3mDgR5yPvMTMmjBFRG+LY3GjLzwxznhJmXD?=
 =?us-ascii?Q?0O833mPzP7zuO0w+4aYS1KUCYHRrXZ29vrsSJ0y8Xuo1ObzpJivAF+418MtL?=
 =?us-ascii?Q?qFOY+qZO/gbiMyDYjUifhjbh/+F9goOdRwLExCRUCGG+5f9scFk9hroR3M2s?=
 =?us-ascii?Q?AHlZ0iqGEfkuRWTX6JcX1g3jssdmU9jX8z7CaBHSdnEqeT7KuJKkmF7lgX6Y?=
 =?us-ascii?Q?/L8/XFYibDhCDvVZE6SQLUlQINwoFvyeOJ3m0d2qCfgDzGkZJJBjwwEwNNVZ?=
 =?us-ascii?Q?LoOHPxERE57km8apKc9CIPOHYGbboe7IXWOO0hR+HhV9VguMQojwBzHqCoc0?=
 =?us-ascii?Q?0V0nQEXdvNFvQRKOUN7uHHHdzL+mFi3/NV3bTQ8INdAU4QR5/TVEBgDtatRp?=
 =?us-ascii?Q?kqHRHzgSr/EDas0swqBuCuTXdGEjVcpYr7J52LDXODSdPwGn5FPwzrZ/77GX?=
 =?us-ascii?Q?lPbT3xNm+taeRcKmV5duHoUNCsMjeg1vnPH3avPuD13DcgTfNwsK/B2unkH2?=
 =?us-ascii?Q?JzmofYAp28j4AivtLVifaXeoMh1yejnGhLvPpU3Jxpkgg98rGgGP3B5o3iZR?=
 =?us-ascii?Q?HpRzJ9FyjrK5ok84qt1cQ9nwN6V6Pyl+v8Kv1sIORigu8/MtIpbfm7E/HPlZ?=
 =?us-ascii?Q?5wS7I6rJVfnG6gknwBpl066yLE41T/IwgAh7BOI0DkYzohva5WUkatUVdGwi?=
 =?us-ascii?Q?c7+gJVzf7YLqskX9ZdJq5V95Kg/rs4gj5z4izissCks4ct31qDu1bhoBCXfF?=
 =?us-ascii?Q?ppLjxOX+Acx/B2b2s3HcMhTWCM2JBVBK3NTlQMRFV1wJRUZYuCO2AshwtZHK?=
 =?us-ascii?Q?ggLdstFHAy/ADjmXlRo78+X/sPCSG1kTzEijbpKSKKqvoFLfYpdpQx5Yeyw0?=
 =?us-ascii?Q?KPPwxuGX4kqy3IW2in9mcw0s8JAft0uNyZWykhaY7Po4Eq6wqs8yUUj5KzHI?=
 =?us-ascii?Q?mr0cu2ckX1jEZYtBRw/gc9OhG1ebG7OUtpWJ4KAeYBoIYp0l71DRypld8FvI?=
 =?us-ascii?Q?5YyDSxdI5Wb6N1XwE1HRcDfGaQkbqRK6hwsL9n0IEREgb99/R4a1tA5fdzbX?=
 =?us-ascii?Q?Xne1a3g67DdBXDwYLZmclHfal03dePeq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nw8//2N9nyZvHo4IUrni3yLF0CmC2DyvwkbLQ5apikJ+EYdOPnhOFAFQN4eA?=
 =?us-ascii?Q?eb54lEvGmiOi5AzcD5XQtLKz460FVsq38h8w6Tk86XYBhCXnaDIoM7gQstrg?=
 =?us-ascii?Q?eiPOdHrWxrHBT1qpN4RuWHIjyzopb5FC2gVoUZFpVi5+kIXPAoABlK+K4gI7?=
 =?us-ascii?Q?PoTn9e8WnEF/6gAStJ/oJTU3ot7UVuyOes0Ce8rLk0mM40n3LhvFllgSkk10?=
 =?us-ascii?Q?YihbFR7qeWdlNfjbXphT78b7xyT4q8pBdBD3E8WVR6z9aHqnrXbr5TmRPpgo?=
 =?us-ascii?Q?BlIXOvTJupTFoX87Icor6/NOO1RhUSwtKWo6LPKUMU3mFBZcrp5nBVSofi3A?=
 =?us-ascii?Q?ym8KGRVsPG1DDjJn0F+F/m2myWipRuRoXv1BL46qh7vBkQdZmsS3qOfK9kbK?=
 =?us-ascii?Q?SsMTZ81iSQng2njVmD1mp0H1nwzfM9jSNYh2cA5klkm4ZXuzrsAVW+FzE88e?=
 =?us-ascii?Q?cr/ZunMlxKNFqPxGhH6+/3/KEI2KrRwHEvImTiwfkYmVMfA0aYDyT6nsz3hg?=
 =?us-ascii?Q?Oy29z1572PUHmMIToNxdXyuFsmI7+LUCoU4TYE9/3adJQjyB1qZvRRypXaeo?=
 =?us-ascii?Q?5wcf6v0jef4rOM6hbdacui5Qu7SshnR1owo20+WBx+2a2vtadxMRHZRIoMKa?=
 =?us-ascii?Q?k4BvUSSFFBmi6g+/gzgC8qEMKhOGAfqKP1ZX+K5mcCKZT5T25NN/U62n6P7A?=
 =?us-ascii?Q?amaydzjSYCYkoPP5go7ldUlAoRZfU0G5eVbZtlIQl+qKJ7ozkQTchHKPYeDp?=
 =?us-ascii?Q?9JZeyMz1EAz/6U4cFZrUhLrincw91AHTUoRIAwupfhWJKkptRgHBy0U2BHsa?=
 =?us-ascii?Q?tBQue7W2tz5xrPiFpAq+u4VCuIMieIbaor3hfozYL8UKkruQxPtod/wB5GC3?=
 =?us-ascii?Q?SAxjDujUdmccrWXFHokdNr6Cj6kV0M+SLJcoQU2cSbTw0SsdFOnUWRKd2d+p?=
 =?us-ascii?Q?qzGe99e6g//Pt68bbDXqf2Xt1diZmEctxpsczW8DKRMvqaE+wsANdhhBFyq1?=
 =?us-ascii?Q?643Gep8nHjoOGIOzWBbkAliaO7hAWfNzGmhwcmQUlPU4cLKGKN530AJ2N9yH?=
 =?us-ascii?Q?D+3lxOwFyXItgXs2oS1ZrlnIrZnPVZmEJhmDMDpgzLFJGa7BuOGzyPDqDzVc?=
 =?us-ascii?Q?nJ6VFTSBdXb2muyGGeEX04Px+TAk0omjBzYGWHG9R1C8+XYztJEyOtAxwGKN?=
 =?us-ascii?Q?d2SMJ3vr9GnnNbHt1dbsyGuYqciYAi/3V1MMwq8J0ZZUjPvtTGlpsaKqbfXZ?=
 =?us-ascii?Q?PhA3Wa9iG9KJPab9eueJbIhXrmw7TdZHS+0H2UaCUFwZwr7RyBqaeO9w2AyV?=
 =?us-ascii?Q?7uHWk6GG1jVdhe+SgUMYn72zm8lipH1lQjF5pBhhRw3IeYP0VRAY3EeeBlUr?=
 =?us-ascii?Q?Yy0Q4SZPnRazsDLqzU+d+OzXSapCi+dCfC/xoQMOuhkXOBtwVs5gGTMldyH1?=
 =?us-ascii?Q?kPQhBgfoyPY+SwoQZmm08+QvSzCiJX97r+D1zrUC93vk0pH3jJujVy5jgIBP?=
 =?us-ascii?Q?zZashlwLOJ44ICzsvaOrXv4Bjn6UEwTvcyjWnAAgjRJFf+WbdFoctVXEbIh3?=
 =?us-ascii?Q?0+x/gF7Kr8+zP4NYXhqb38MlNFwpPV/oU2TPmcqg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dad426da-ce32-4961-5007-08de124d7d64
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 16:01:56.0994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9cmQu0TdF9lfbcMNfbhEZR/+vRt1iPgqFsj0r7cJDuVury7qkuVKpB9uZitnicXg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9640

On Thu, Oct 23, 2025 at 11:15:43PM +0800, Wei Wang wrote:
> When SME is enabled, iommu_v1_map_pages() currently sets the C-bit for
> all physical addresses. This is correct for RAM, since the C-bit is
> required by SME to indicate encrypted memory and ensure proper
> encryption/decryption.
> 
> However, applying the C-bit to MMIO addresses is incorrect. Devices and
> PCIe switches do not interpret the C-bit currently, and doing so can break
> PCIe peer-to-peer communication. To avoid this, only set the C-bit when
> the physical address is backed by RAM, and leave MMIO mappings unchanged.
> 
> Fixes: 2543a786aa25 ("iommu/amd: Allow the AMD IOMMU to work with memory encryption")
> Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
> ---
>  drivers/iommu/amd/io_pgtable.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
> index 70c2f5b1631b..6f395940d0a4 100644
> --- a/drivers/iommu/amd/io_pgtable.c
> +++ b/drivers/iommu/amd/io_pgtable.c
> @@ -353,6 +353,9 @@ static int iommu_v1_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
>  	if (!(prot & IOMMU_PROT_MASK))
>  		goto out;
>  
> +	if (sme_me_mask && page_is_ram(PHYS_PFN(paddr)))
> +		paddr = __sme_set(paddr);

It needs to use the IOMMU_MMIO flag not page_is_ram, which I think got
mangled by the time it reached here..

Though broadly this points to a larger problem, the iommu domain code
should not be trying to guess if a mapping is private or not, this
needs to be passed in from higher level code which knows what state
the PFN is..

Jason
