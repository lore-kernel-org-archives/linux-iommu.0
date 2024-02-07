Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2041.outbound.protection.outlook.com [40.107.101.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DD035280
	for <iommu@lists.linux.dev>; Wed,  7 Feb 2024 16:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707323538; cv=fail; b=R1AQ1GTOW0gq+FaNij+8eu148vPdR4mFqdgfDqjqNNmaqzqOWtz/3e0X8KGn4+6TE2SiUhMVWzqXXzf51rOdag2zpnS6nzfnQ9Kyjx5krAQyJqxc0j8asP4Sw02xTS18ic4X34Km1x6njEShOai7Q4ZRHl5a5a1+o94ySLmMvhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707323538; c=relaxed/simple;
	bh=cXS7YFi8SvUDwyRinZhZYuJZjpT8MUxUujBszTQfnuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NB4XRsJ1dAcGSl0aT1e9Nyn73qFGOpStER58rzoqIGHz7BltF5U4W7PMsCB1ndgy7VMmrwghYaL6poH7ziDYCG4tB13MTtrpDFAxXKPI/jSp2Urnd1LrFnbeLJudMz6R84fW7qiHvMNqMqNVcbiE9K5OggardKXtQ5ZAfNNg/80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pG7rEC9O; arc=fail smtp.client-ip=40.107.101.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pG7rEC9O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivDK9YSTwzwDvFWeqBxEWUxHfpsJ3lQ3faK8n33oBqNVS3Kbt8RqT0Dy7LfQYZm/GyJoCWT41keB4EEj8eKxE0egzSUjUjp4dNOtCELm2vR0cOA8ohTWzBMFsVIhZqMsz43ZC756rDzuEdt3a8cEWvzBBWMHRNG8LysilDA2jhOmghalqB9E4SWa0WQQSKUcx1jraGjRfuquggRo4bPZuADQKl7m3M/2Nn7OUbUHcHsIrH3HifEfPVRUAU2MU+2XK7XVtvX97hSHPhd4yxgUPz+UDBfULiFY1MMdS9vi1naTJYpnBlmyBaV3juVC05Lp1DHGftU+3Vr2cJzDtT170A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0C6zdoeuvccAXGpHjfZpthXZ0lW+Zza0CSd8jO9fpQ=;
 b=eRwxHcxeENYYdmDK+7TVmkfuueCFKU1TqxFE1tNclhnbYtl1jHIgOYAYZe5Eof4rmKnXORe79XlDypthYiTRzU/nbeed0XNaNJBbD6ki6EdonrXUhVhwUSLkfVFProxq8jXAE6Y2m0mToGGzscq3f2ojksvd+rXaUyOK0ZfY0YgL+ZfwuFxWl9gmFlSWAGshcZWCVJXpI23vf8fBFLumsvOg7ucVTAj7Gh/xVvUGLEtk37KIHb1dzTcmTrRhaNwpVer+ZDc/zpNOhrunKvieWbankj5NpbpfikgMSxxKKADqpOp8Wqj1ZWpWujB6eRxU7r5cLyRnWCSkD78tSEyb8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0C6zdoeuvccAXGpHjfZpthXZ0lW+Zza0CSd8jO9fpQ=;
 b=pG7rEC9O1JuHqQY3c1Udx6bdWC8O1xIJrrzaEgpaFNnT1gY9vV8gK+iRLXmyBbw07K2rI495KKmz09SxMakvIW8WiouC/JGJkU1ZT7/7myfIURH+IwlIw0I0ihQHINA0pu9ahPeGYhFxJyIorYRlg4nO0JlFONpezWOf/LfmTEBi/9fJC+zmMwWAF+QL5gXWoqVCNKjsUmGT3npx1k+b1lQXfUYtcn8OAiCKUxbd2ijf02nGpvqfDNvXkDd2GBG4flnerSGm4brER8aZwbbIhNfA+8SyH5oJu2L2nZdOfzuS9mcBGjZ71lAGx5RGh827S6SQfKlNgncLIhYJVkKE6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB9044.namprd12.prod.outlook.com (2603:10b6:8:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Wed, 7 Feb
 2024 16:32:13 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7270.012; Wed, 7 Feb 2024
 16:32:12 +0000
Date: Wed, 7 Feb 2024 12:32:11 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	Ovidiu Panait <ovidiu.panait@windriver.com>
Cc: iommu@lists.linux.dev, sbhat@linux.ibm.com, robin.murphy@arm.com,
	will@kernel.org
Subject: Re: [revert commit 83b3836bf83f09beea5f592b126cfdd1bc921e48]
 [mainline] [6.8.0-rc3]kernel BUG at
 arch/powerpc/platforms/pseries/iommu.c:100!
Message-ID: <20240207163211.GG10476@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <798229fe-906e-441b-b7a3-44c475cf1e9f@linux.vnet.ibm.com>
X-ClientProxiedBy: SA0PR12CA0023.namprd12.prod.outlook.com
 (2603:10b6:806:6f::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB9044:EE_
X-MS-Office365-Filtering-Correlation-Id: 86139fea-16f8-485e-27cf-08dc27fa568d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bhVz7DwF6t9ZDgrdZ4v6X6aF5tXkrK0q1RllJBHf1WCdasW1tJmyfehp0rJKFzqbd/n47XGJ1TC+M4b0XJozWWrzxAsTBYBPXFw0E7myi1HG46xxhobPE6F/PrldCgaaX+gL/nvJNrdwwVqCkFT6t0QqbH1kSNkAbriQEO8ayG+x6siEkajgSUM18bk83dXi+4CFwZBHDEtduchrnE6vWCQzQ1nbMPFXtWqFK7C0qHb2Z9VUGlHpjtTfnW4vw9M9noN1F3UK3TF0XQns+Xo3iU9kaAoMEUtHYwT5a+WY8OMISlObOhFAfiPv7NL9EEx6sUo9KO/+mxWk/sYR03Q3J6Cm4QD8nNf1dU46DyICEbJJ8v65n+Xz6XBwSms1dldpR78NMaGsO2xE2QwSu2hGNGMByrq+nT+VxfURhEQgJowVwwKHNg6HCA0kv47eEWfdYq0ye8zHXnhlgj5peVL9bG/JMGdljkb0P9Jn2SAYLjsZEZnHLIy+A+d7TkjJGQVvfb7SaVLZ8031WTRXzjN6wfNSQwlPUnwlpSPa3dDhmHqQeOoP2JH6R1G8ttRC7ZO0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(136003)(396003)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(2906002)(41300700001)(36756003)(26005)(6506007)(1076003)(2616005)(38100700002)(6512007)(83380400001)(66556008)(6486002)(5660300002)(478600001)(66476007)(33656002)(86362001)(316002)(110136005)(66946007)(4326008)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+0MEpWr11MkFrFBPh+ozITzr5diWUATElIsrynZOahzL3QkALFO+tO8PS/Gf?=
 =?us-ascii?Q?dbBE60Buwk6aPdjLKh2uf6g1xq61vMOiUTFAf+Oz3r2tasPFHB8bmMhdh3XN?=
 =?us-ascii?Q?v725YL8jqxXGVxYUeWd65nK6JEAyoa5qO4QnPWI+Ln+0byuRhoso5CGA5zLL?=
 =?us-ascii?Q?vzNnAF6RZy2uufLrWaovcT2u96UWz2r+CwWyojKxQ7ODPYW1If4ED/NSwCOp?=
 =?us-ascii?Q?BPisBuTYg8cpgwEI0ZgLaMXGFEnkaoi2F0fhHUwHqS+hmrES5eZaYWxL2sb9?=
 =?us-ascii?Q?0TLVKTWIdq1Zek9om0cIk36QQOWJ9e4saXisfPbzushJuh5ROwkM5JUVZAog?=
 =?us-ascii?Q?Q4iUaeNabyUT8xeZItBGNIoOsCeaCrg7jSWh9+j3tod1i46sQipGpMraRp85?=
 =?us-ascii?Q?oJHXoBeL6YtjJrUDciXyw6Uuuwb3Ky3p44QiDm+iX3vZo8A5mR3ELwo0dCYs?=
 =?us-ascii?Q?2Gf8v3NMSLD31UOk1MMA1TRAijFaW/GKeq0UCYXM4rlq1ATPpPlPGUZRkKlo?=
 =?us-ascii?Q?XO0O3kItq2is1BStyDbedGtHe3qYymQ+oCndvQY0Mm1F7C77LPwJObte0vNQ?=
 =?us-ascii?Q?1kOH2gei5SLBcRiPESrcIXuSq+U1KDQFMFuPWx6JM3n3NtjXlFIT3kPvQ43y?=
 =?us-ascii?Q?9F2tsty1gRHyNp5w+TisQAzx1veGaAQxwwZH01Ewsc6o+O8JLuzzmwtv2q9r?=
 =?us-ascii?Q?Yqv8Dy4ReN6NxTV9pJtvwvxwYGCJgeV5WENeluZkJLyqaYOVAT91/6s7j7gN?=
 =?us-ascii?Q?ovEDNqBc4Zp7ZEaG11MzBkxM3R+5vH5CsonfXbLeuLqnz73izGzzp4bU8Iwu?=
 =?us-ascii?Q?Tmsi+4OPlB8Q3FdY/rsBY6kEoMlTTDmdGcGVUhOsIFxG1QIuo/RajEX4z0Hi?=
 =?us-ascii?Q?UfxpCX8eLlljqh0IVBQr/9Yxi2zBvd8y38ypV3ZkAlesJd3F+6TjJGXd77ja?=
 =?us-ascii?Q?WEWnzutwJKjos+/RFs3JaNnZXJ69WSksj5F6foqDVk3O2lz2F2Kg3AffPRf3?=
 =?us-ascii?Q?ydNYrYU0hYmTaTfYzxBB5EzzVqcbKBTmSHTuZCfQ57JckBIz1M74276kJ4lv?=
 =?us-ascii?Q?39zDA1HCeE8LhOIRvfs5HwQ7VIOdCuwI7/uKbH7zBu3bRcFmACSoLmDB/p5y?=
 =?us-ascii?Q?o/rplKDPCjg3QqKucX/XqYkSa3ov5OOCqtaqX8wnpI7bwF3Nb7mb9gI/O05T?=
 =?us-ascii?Q?8J/k/ic2TkD8Lr7OPaFv2Bw2k7UOX537jBvgBUH+gdBglX76KwABS2dYnNPA?=
 =?us-ascii?Q?diltHhDEc+C3+CRLdI5zuGwxe4ypNhtN1804xOjS2H+NJo7hxRAu+4zhzupZ?=
 =?us-ascii?Q?3p3Egy34CujJ11bPvmu4A55o6GtxNIPbc7j1ClyrU2sNBUwSLebtb195Kus+?=
 =?us-ascii?Q?sgtCNNxoERV/DDbmHucyDyhi3Bn525u9tTEMfJXwA3O2+vCPtIAneLwsVolU?=
 =?us-ascii?Q?vGVxwaUrxXNra79EjRTElW/A42o5kl9m/DUx+/qdPsnUabrJNPlrZl3txVLd?=
 =?us-ascii?Q?xwBHb1uwfeQl8iz6p7vlCYDN2UJXE/ynpbk8R7xomG7AAwE6slB4ZEIioQSA?=
 =?us-ascii?Q?TfqlU+idH61qK8YxljHfptppFZvwSz6d1NJGhHA6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86139fea-16f8-485e-27cf-08dc27fa568d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 16:32:12.8316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y8z6hBupUrNsBtf8QBzXLfpTgo61kg3dk5lngHl/ouXN0hpBokp7smKYdFIpxQre
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9044

On Wed, Feb 07, 2024 at 09:53:30PM +0530, Venkat Rao Bagalkote wrote:
>    Greetings!!!
> 
>    [revert commit 83b3836bf83f09beea5f592b126cfdd1bc921e48] [mainline]
>    [6.8.0-rc3]kernel BUG at arch/powerpc/platforms/pseries/iommu.c:100!
> 
>    Reverting below commit id issue is not seen.
> 83b3836bf83f09beea5f592b126cfdd1bc921e48
>      iommu: Allow ops->default_domain to work when !CONFIG_IOMMU_DMA

Well, you'll get probing failures if you revert it, so this seems like
a false bisection.. Though no doubt it will land on one of the earlier
iommu patches.

> [ 7843.149112] NIP [c0000000000ff4d4] iommu_reconfig_notifier+0x94/0x200
> [ 7843.149123] LR [c0000000000ff4cc] iommu_reconfig_notifier+0x8c/0x200
> [ 7843.149129] Call Trace:
> [ 7843.149131] [c0000013aed5fae0] [c0000000000ff4cc] iommu_reconfig_notifier+0x8
> c/0x200 (unreliable)
> [ 7843.149138] [c0000013aed5fb10] [c0000000001a27b0] notifier_call_chain+0xb8/0x
> 19c
> [ 7843.149146] [c0000013aed5fb70] [c0000000001a2a78] blocking_notifier_call_chai
> n+0x64/0x98
> [ 7843.149152] [c0000013aed5fbb0] [c000000000c4a898] of_reconfig_notify+0x44/0xd
> c
> [ 7843.149160] [c0000013aed5fc20] [c000000000c4add4] of_detach_node+0x78/0xb0
> [ 7843.149165] [c0000013aed5fc70] [c0000000000f96a8] ofdt_write.part.0+0x86c/0xb
> b8
> [ 7843.149171] [c0000013aed5fce0] [c00000000069b4bc] proc_reg_write+0xf4/0x150
> [ 7843.149178] [c0000013aed5fd10] [c0000000005bfeb4] vfs_write+0xf8/0x488
> [ 7843.149184] [c0000013aed5fdc0] [c0000000005c0570] ksys_write+0x84/0x140
> [ 7843.149189] [c0000013aed5fe10] [c000000000033358] system_call_exception+0x138
> /0x330
> [ 7843.149196] [c0000013aed5fe50] [c00000000000d05c] system_call_vectored_common
> +0x15c/0x2ec

What is all this?

Why is it reaching into the iommu space and messing it up from a
notifier and then crashing when it is not in the state it expects?

If a DT property is being removed shouldn't that be achieved by
removing the device first and letting the normal iommu driver release
flow run?

I have no idea what this is doing, but it looks sketchy :\

Shivaprasad/Ovidiu can you look at this? It looks like some case with
hot device removal?

Thanks,
Jason
