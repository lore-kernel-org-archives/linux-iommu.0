Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513B41C84AC
	for <iommu@lists.linux.dev>; Wed,  5 Mar 2025 17:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741194125; cv=fail; b=gLojUt1OK8uNu53cSQcNsArFvhpJ5paQDSpyF1WyzgaJviYvNwyXJTko3mm3Ln013P4R5A3KvCZvTJxXzAo9M1fVmZl1pqEyOavnqRh4cHx+BBnJhu6HQKM4japENVSRgiE/RMDXbjmPpAi9Xwb+2M1DO696sWnb+B4R9cLdoJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741194125; c=relaxed/simple;
	bh=t2Kuq2zR1zupP2PFZ7OKs+FgHVVKKQaMRHkIcEOBuNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=old+PCXlfdp+rYjgKEk6pHdi68EEtmDcf/QEFmWOnv2wplV/Tv2R7d3OXYhFTB8/tDr3QHDNACjmV5MwrYNgUHNoybTUtwhPTGzfb+wFSpENAGLYDPtIRVp47xs0CRtffLl8FOMvcwpsIAWZCRnxzb0Wf/otaii9524EWG0RT18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RUQkdFNF; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RUQkdFNF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FYGnNNcQl5bbeaKK4inXzI+k4GMhgP/hwbfFnyendgpS9SdcFXEPnD+NOmaIJkTMclp59ms0CEGmFv1jFOg6+wKvtyxX70mRBJuyzOjPicdzHa+wcpdh2q5zhCOoA50AR5IC8wbjEmEt4qaCPW7Hl16dq6QsTUFhtpH440WtKtfjn9dlL+KzlI6Tzykl/blwKvp/sd45xnhogXFIhGe7mimU4UwGmvBJ8kvZkquAYRdgBzihDULL6HgY0r4tL/Se4gLnJaWe/b6tGOJs110QcrNoDqdUaw+YQgMiEmCz2vo+xHYihUCwS9iXWYanqd5H9U9zNK2gIAasVZXk30VwnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CunznfMRwjEsfhduvEHUcMwu835DrHFGEjPY4E866I=;
 b=F97r6RDlsV1Pn+VcFss4wNcMpLNfJIs9pgm6fZ3hOx7u1SGxdZ+mI42W1/r1qEmrCeASN9Sc7F0cax8iXQkrDowLecvAj/5dRczU3uM3yzEHJ0MEtLvZL4g3CP8C8hb76T3vc+g+84jaTrRtiL70CSWwYm26a1jDFI+cnY9Q8Brr7qTVLyXsG+kBSDFK/nwGXLuGL8qP8pdkZOjiBqCpgRkHruNNs4NbEIZ7Ys1XAx4VvsPEUbBgBpEO8jGgQ/GWujaVMqjNyd30/tlC8gqmlG72FVtWQIYuKS/A7ICvRreHO64ZYA/6flPCBo9MWNfjSUtKQS9y+fnxE80pEStSzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CunznfMRwjEsfhduvEHUcMwu835DrHFGEjPY4E866I=;
 b=RUQkdFNFPK8296CQf5VAsQjUVYiuLFonE6ph3DOZfZxIozkjO154TVCrVDbcCNTmF8Nxtr4cGcvP4gtzMnZgjflkhdK+Ogj/HiRoZU91ya/cZudC3ep5DxiBoWFs8QmJiV7xEys1zjPS47efINlKLEFBz3gpaCm967ty6EgpZB8wYdOHw/01yIBI5hTfNzDlMsTwbw5dXasCoNv3f4xXInO5bgXWg4QKcs5Uk7ovQcj+aVOWCBNji8SvCaLxoUBgk7onDPi3F3FwL9qqJ+eKkmfuwhqyHeYdf4ZSik1KqPlIUi+F4I6vgp3SnjZGE58/E1p0DjxzkBZllhyixrw0ZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH3PR12MB8936.namprd12.prod.outlook.com (2603:10b6:610:179::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 17:01:59 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 17:01:59 +0000
Date: Wed, 5 Mar 2025 13:01:57 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH v1 3/4] iommu/arm-smmu-v3: Decouple vmid from S2
 nest_parent domain
Message-ID: <20250305170157.GB133783@nvidia.com>
References: <cover.1741150594.git.nicolinc@nvidia.com>
 <0429d554fb0f54f6d79bdacacb3fb3e7877ca8f7.1741150594.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0429d554fb0f54f6d79bdacacb3fb3e7877ca8f7.1741150594.git.nicolinc@nvidia.com>
X-ClientProxiedBy: YQBPR0101CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::19) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH3PR12MB8936:EE_
X-MS-Office365-Filtering-Correlation-Id: f9fc1c68-8e11-4907-0a30-08dd5c077142
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MHOXwZoHtVJpHm9Cq11fLhyOCoUpnAAFhOiBLoO6cCQJfWzS/DNA3+/d40jm?=
 =?us-ascii?Q?SlHBsI/PDkkt+4acVTr/lWkV5OVcYn5T/PILIC2fYsXaltaJaWMDRHLH0Gd2?=
 =?us-ascii?Q?IZu5GJvpRdxjTMYmWi4Co8bsDGhcmS8eJsMdqhXsJWjehkuy6dNg6D9r4ew2?=
 =?us-ascii?Q?LqY3C76cqmXKWUkwyvXYlEGC+eagl7btQwr8YTpAjUrP7Ghwm7iiKkBesqCK?=
 =?us-ascii?Q?r4bzt3pIyhmdvSdJRwby3AmC+h9IP3BL433zS1vNfXmVSOfpIINgobAo+Adm?=
 =?us-ascii?Q?7mTk1u8PN9TufBChvxudjpxs7Mn6qCfsYOno8j1SW7pqs2sPrHZqbmZgFsqp?=
 =?us-ascii?Q?90vntG5vADXRw18JNdNq8zP2FBDzulIBr05ocUSAIL9JybqowW5jtR6VlsUo?=
 =?us-ascii?Q?3345dt1U9Ybyj5NaDEMdMjI70bzHz8FZ4Ev6yL7HBNvJGjBJKq4FGalHe+P4?=
 =?us-ascii?Q?AVcd0NtiRCy2aunRj7Yz2Tfwht+wpO9WB6cRgYkQWEzu6JUrBDxAO/cUDD2B?=
 =?us-ascii?Q?Wa7/LMWJJdLywcoUCx0w4C0g6t3xo+FIUYwZyVttEXSpKUBtpv/rflW8cNXS?=
 =?us-ascii?Q?Esq0INc+TOlO2brdihfQQi7r1xDqJGq3T1af9abVyYHI6FPM5lWrdwxuUhfK?=
 =?us-ascii?Q?qE0aJ5pCeUnYnJgGX+25pVFV2vv6hJWV+65qnymgQOp/xQVbFgZSS1YH8w8W?=
 =?us-ascii?Q?PptY0vqsrofv/JS/We9UQs81n81/lh0qLX6W+vltfwIbzmL1TJe6ud/4NyJw?=
 =?us-ascii?Q?/xgbG+hOVur0F9hnarwpcgqMETMRIII46zPLXiV45EMGLyd5uKMgv4gYNnnz?=
 =?us-ascii?Q?yWLsOhs74ZvBdR/0g3+MqLbADAc3f2R2P7k3z/yWNHbU/l36Dq8T7m1g23fX?=
 =?us-ascii?Q?ZNnf0+tPhUvHU94LKXXiqkUmf7xGp+2wEe+Wqc6WhEvViVVHGIxpQrzyGAHT?=
 =?us-ascii?Q?nK67bgxiR+IQwRT2tw1D6OJvuD/qA2OXowuxEr60upOppWRGZfAyiNvTxV5B?=
 =?us-ascii?Q?y36gH5aKVWol5gUibb+nm7htUn75bixJrfrx5Ab7kKNSZvi3mBv+ajyDwFnd?=
 =?us-ascii?Q?90oTN+iROoQGeIXoByiJhZ8jW4MgiYdZ1kmfcWoROHczBRzogToqTcHfbZRo?=
 =?us-ascii?Q?efJFM+zjagaHeiGvQU6nUPG2hh+P48va8ZolqVarI0292ljp9K957KEvqpgL?=
 =?us-ascii?Q?ivmCf/p+Y0th0l2dLfxb6xY5WN8yDSJ9Z30xAS8XJ3JlmgC6HkHoG1AjZDwi?=
 =?us-ascii?Q?JZys4EPECZM3IVAD9gtgXcctYFomxRF3Ay33VjP/SB+a4qtY5kjoCQcoVjdH?=
 =?us-ascii?Q?icDvjk4yK7/9EGM9Ufjij6MgJGwDjNdUaZ/bj53n5bgtCOh3LMeEgetHz8Qr?=
 =?us-ascii?Q?i1NARVMtGf0635w+kfjpMW3mqPuz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fk7ABcltWi6r49P3Quig5mS6BmtXVMq+wxwZnKbZEyhEmSivJku5GDjUW6uj?=
 =?us-ascii?Q?H1Y4+Q7jdHFIcZFpdjYdRulhNTtAogiKR3ARIy1PO9mzBMGXHE6QJk9Pbn9C?=
 =?us-ascii?Q?cmuBJ5UVIYLRen0U7suIv6BahkPmkwBdy9uu3g87X7OwNQt95NAJcVxLudp0?=
 =?us-ascii?Q?/HOY04bApeH5jR/eUQIDebcfh+61Wzumguv8xwc0zKopHVCAYn1cByGB8qBA?=
 =?us-ascii?Q?ip1r0/ueisyICiItIkL4mE5X29dEnGAFIEkKHZvlu5oSH8HlVcRp2NNZQo+K?=
 =?us-ascii?Q?RsgSiFgOMixkjJOQojZhbLD8VkswGAfJ3K26ejTvMiaO8NEzw97gorlasMR/?=
 =?us-ascii?Q?ymnKPh+O8vBTfMESznf5o9YPIP1dD+Be2I/Sh+0fYMy2MuCj5mjlWIDQipi7?=
 =?us-ascii?Q?0/lme9PChpJP4/GV5zrtYUTJHQvkFv6HtKd0g2jSy8T1N++8ozDAig+IbDON?=
 =?us-ascii?Q?+vCs641jGVJLvMHpqjd75p3fPZVRnysx6sH5eMITScDQ3SE0vg2m/3tZbXmF?=
 =?us-ascii?Q?W30UB1XmvVw4zOpQKtGnY9DBaF+KzchP1GNfmk/FG3Cz1+FFj0wpWOkguA3C?=
 =?us-ascii?Q?unbWCXKdS64hQBoEveYRhhFGa2Ex7Pko2vA7TsB6d9rvHoo0D3vBgLZfWDYn?=
 =?us-ascii?Q?UWDx3U8MWu3cBTAO5Ij0xc29mw+hYaKUL9Q7Gel5Y5ZU+crXHDDwDlU3+s8s?=
 =?us-ascii?Q?0P2vyFl991eU+AxkMUKOWDhh7IQhi2uWGo8Po5N3X9J/QVcMFJnrHHYy9X1z?=
 =?us-ascii?Q?P7bUQK9jWa9cEpE1ffs61Qz/6rhCY+cVgBuYZ0G2Myo2qMirhYtqhqA4zgAz?=
 =?us-ascii?Q?uSlEYq7G7h2efqluI1u9LXyz2NWHQgkY4D+RTldhKEnJvZNrsYwHj2z031o3?=
 =?us-ascii?Q?OgmXSP6/ixoWhSyHLOv/YIGxscZCFP06p18QGzv/w4PQxlo8N1FbDcnJEHhb?=
 =?us-ascii?Q?uhOM2IG1YTxxedVzU8eXSqbOvfKXbDqwwPMKWyYO/+JdBwfdMoIIB7Pzrmz+?=
 =?us-ascii?Q?BGNW8vrIP4WoeBrZG2Nqq5JjGjF7e0fH4E1NmaMPkqn/cC6/LaeDRi8pLYUc?=
 =?us-ascii?Q?/KPtQOLS8eW1fC3Zv2Bkz7+DEhpbQqKPQnZOmBBZz09UxDGBeLH7sV0KbXrf?=
 =?us-ascii?Q?SPYlX+7SDJ+RSUZR6LkMde9Fsq2KB/MRjVjzmQRr0sa8ohMcXwcbF9h7Nk/p?=
 =?us-ascii?Q?bp3WQedv0h2EE4C1LwCv+foSCZK44JPbJD1JC4Nlk5PmdwuwVaz0Aky9RGEQ?=
 =?us-ascii?Q?Vg31YoOrr5dAtcPqBWX8Se3NESluEpLQfuMUzeuK0C17yw504AVMJK2puW0J?=
 =?us-ascii?Q?Uq2JymlsjrD0i5IHboYSQ+Ga8hsBdGI0P0nbUTcD044fSIpHaXY0ChWZ1VpJ?=
 =?us-ascii?Q?9TnA6XQNU7JCGaCcqs00vVZnNP4Fe/MLm0UyC0BvmOVsPRf09WEtDAW5SFAn?=
 =?us-ascii?Q?WaXGq2+dFqKmgN9wv/5Lpwq+yLt6dSYyPkS7xu1hfWvCpvv1krbE2VNC90LF?=
 =?us-ascii?Q?wAObyp20ZjkXxuac+umTGpSBJwZ4fNtXgKzok99eI+1QP5Xbh59U+3FCJGQi?=
 =?us-ascii?Q?Fzt+NW17C3JNTb9ys37xCnnas/tP3atAqNjJs9vc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9fc1c68-8e11-4907-0a30-08dd5c077142
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 17:01:59.2817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mIC1xTr4gK0Hx4htW4uVne0rJEGOJVdaMoHryuUPISYRhpSRDqOz6PvMvEA6EtGI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8936

On Tue, Mar 04, 2025 at 09:04:02PM -0800, Nicolin Chen wrote:
> @@ -2249,10 +2249,22 @@ static void arm_smmu_tlb_inv_context(void *cookie)
>  	 */
>  	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
>  		arm_smmu_tlb_inv_asid(smmu, smmu_domain->cd.asid);
> -	} else {
> +	} else if (!smmu_domain->nest_parent) {
>  		cmd.opcode	= CMDQ_OP_TLBI_S12_VMALL;
>  		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
>  		arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
> +	} else {
> +		struct arm_vsmmu *vsmmu, *next;
> +		unsigned long flags;
> +
> +		cmd.opcode = CMDQ_OP_TLBI_S12_VMALL;
> +		spin_lock_irqsave(&smmu_domain->vsmmus.lock, flags);
> +		list_for_each_entry_safe(vsmmu, next, &smmu_domain->vsmmus.list,
> +					 vsmmus_elm) {
> +			cmd.tlbi.vmid = vsmmu->vmid;
> +			arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
> +		}
> +		spin_unlock_irqrestore(&smmu_domain->vsmmus.lock, flags);
>  	}

I see.. So this just makes a 3rd classification of invalidation
protocol that uses a spinlock and linked list

>  	arm_smmu_atc_inv_domain(smmu_domain, 0, 0);

This is no good, arm_smmu_atc_inv_domain() is invalidating against the
instance that created the domain.

IMHO if you do this you should set domain->iommu = NULL to indicate
that the iommu is non-valid in this mode to catch issues.

Jason
