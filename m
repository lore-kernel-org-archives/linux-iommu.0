Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C174618B1A
	for <iommu@lists.linux.dev>; Fri, 27 Sep 2024 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727452779; cv=fail; b=Z5hHLpJzcbdruIxgV75CpA76dNJR2lh+xFZsF/nDENeHpkfYeyPf+Z6FjvDxtRL2Gr3c72sgZ/2gYQSxxt36TUBGt+zg+hKbTXGCTY94k6i2MTJ5+L9Wi4qmr15SBND0R0h29xUottK8zxTawj7ZorwV5vrql5v/5noaSijpni8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727452779; c=relaxed/simple;
	bh=eA+/nI2ly61GxqXdVoEcL4CRTqR+qaDp2PjFOyVbjlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YkmNkIDIfnrX2aIqxWhtTfBsFvZBmDSgUOYNCTlkQ0hcn0/gSMdiM0C2HqXHg34QlC4EFoJqbDhB6dMSf2lcW5ghQ3Z+6sGKZ9ROdA9TOcIIKrhx0jw8r5saeQaM2GMi/7G6nykDoigKC4fWy5dt1SgZPL3mbE2nT6aDVTlR/BA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PfGxsbvi; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PfGxsbvi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M8KHc5GIvnJpfHjtCh7WhCLzwSWwq8lw9q6FbGtO2sp5qjJB+CjNEJRPDoi4ex/0b/P+YT09j1bzaAErrVyywREx8k8S35p99mgGd7Nc3qYX0JpLuht+x1M57IgbSd38Xt699mId2GJwA1H7fEHZ4Tx6q4dINQxAx8V4oCbH8BGaWDrqQTlBCK+tuAkzzrcvUDif/UCnvtANs9Z4nqExkgkwu7Cs9ZbsZt2HYPpI8uosYzG6tTF827U3IHlP57WMfgIL8uPX8x1TUG/pWj0UOqpmzPho6v04Ykyfo1oSR8lpDzeU3LKbZNTuoAc1NOh8smULWU8hd9bd1cxzR2NHtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PiyUkwn6eLR2IyR0dJKIvGI0wwaJEN2lRzC0akB7ek=;
 b=GfYDCjnU6g5YNRhB0677+n9CdiB40BZWjjaKbmeKqQyj+YdHlHYPNghzOrcDUl27IEQ/T+MLijxzlptUw8fhmi8gUMo+ZuWVKH437vvHzva4GhQcmsi3xjlq++UeMAOhXkntS3z0gprlT5yQt4bOFuvzpKUgAJF5jeKuBfZPKQlJJdLXSic9HYofofTa3skW5/c+9zZUN4n8xzMPsr0NzxTkk1pLthbSm++pUH/JqAhOFbgrpmtdTII0ZCEEy5AhLT+sXo7z7lgDbx7a8FJdrwcIC1K32XwNH8KjKG1KKDC8j1uKdnSY56U6sCERAv3osv4ySZkeBQygkQMs41vpJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PiyUkwn6eLR2IyR0dJKIvGI0wwaJEN2lRzC0akB7ek=;
 b=PfGxsbviaJFKq9rERHA1cQWzt3QInBQCJIt0R/A9jJGR1lBATbo7+UKXQoNMfwopxnVCCxpGNKvR7ZYdqCowWUUcicJ9rI3SFQEuWbeZDVtWAs0rzxAHIkRAOSt088ryxwIMwWjHlW6uL6jBbTI4f0Plp4J6UXZZ1blM+4ZTIzrEWF9deof5bkxZGh7pUSxIbpu824w+DXvanRSvET2IoNg19DdxNxw1+0VJTbA68bxY7r8IUcyBrdAGSv/ei7y6LqGWBP3mBMwHdxxaTKrmPUEMKNkbxwJO5cc70CAZdqyuD4ufdqTouuhS5d8L8QcHKaJ7o67cJ3FOBxbUsdyzWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB6564.namprd12.prod.outlook.com (2603:10b6:510:210::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Fri, 27 Sep
 2024 15:59:29 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 15:59:29 +0000
Date: Fri, 27 Sep 2024 12:59:27 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH V2 1/9] iommufd: rename uptr in iopt_alloc_iova
Message-ID: <20240927155927.GE4568@nvidia.com>
References: <1727190338-385692-1-git-send-email-steven.sistare@oracle.com>
 <1727190338-385692-2-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1727190338-385692-2-git-send-email-steven.sistare@oracle.com>
X-ClientProxiedBy: BL0PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:208:91::39) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB6564:EE_
X-MS-Office365-Filtering-Correlation-Id: 1949d898-6e25-43c5-690f-08dcdf0d5e2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eERKPvroIcSeh08dzeoJG3VhO3kRKU5fsZ+Py9lLbMYI+JJt/A8pSaQzZ8x1?=
 =?us-ascii?Q?TCmJuZNwv0LLZ7lx/9bmNNwWgaJIUutRQUykoDG2CBsKB2GhycDiy86pSGbi?=
 =?us-ascii?Q?4yT5JHrZpDh3FWs6ZPRKxo4hywdj31GrYlo9uGCtvBgFPBsIP/NlCEEY79T2?=
 =?us-ascii?Q?YN8hdfwpxs3sVw2PVUKbJggwBKbHjLvugH0Q18jgBZ2r5FZwa6KnKRzFgNmn?=
 =?us-ascii?Q?V9nLtJhI6KZfZbwNa0LLCfPp8AqhIfBMBgwU682pCMuLWbgsEpJ7AU4z4Ne9?=
 =?us-ascii?Q?QjT0TVBSgkYazgH8cZym01YWhC10EkPxuolf6UJVZyfxBBRCdB4TVO4tZihF?=
 =?us-ascii?Q?kkFmj8dtqZfehc3mafJWzyqSSWMi8cJCfTmmvi9PSXKcu+U9leB5FFCrZ94U?=
 =?us-ascii?Q?25PjXpoZss7ezAdvUVNleTxACYXkjVBj9KM8sH2f+fJlPmmpN9VF12LBLRRl?=
 =?us-ascii?Q?Gozd/Qy6SHeULFuU58YDG85ScDVrO5K5rmnzINBQaSn3vklJ7PLqAWasyID7?=
 =?us-ascii?Q?NiZs9H7BfzL1iKfNH8mVZapPkz+aGcVfDeTOJ20ABM1iylbY+B0U3DQ/X1Ie?=
 =?us-ascii?Q?y9pPyZLrAa9SUFdZHaYN2qvl/uNBhF7Wfi0Qqny/m78uzZk90vFUqA4ChJp0?=
 =?us-ascii?Q?DklVxN1cQyOLGe7Oqg1ZcX3nV3G4k1M1FteiNz1dVsN59GaOEb+h2rlSC/Uv?=
 =?us-ascii?Q?PF3EdS67nCymZ7QQV/wJEtKD18d5O6LoZiOwoB0MMMH6VfNyAPm8+5RG5zxW?=
 =?us-ascii?Q?+DgHq1CA215uugtzQ6abot7s57703X9ebKLTsedF0QEo1tQdjt91b2s2lZum?=
 =?us-ascii?Q?MsFrA1KPSmr303HTPo3dj3RhOYGjsoeXTDUgWf9YF42rCURBGiZcXC+MIxIT?=
 =?us-ascii?Q?TI2HS9bL93JUAPyuXWTHAhuOg0uMMqe83BTpVVIj0SEQy2ITwMujhpUJkNu5?=
 =?us-ascii?Q?LMgT4vuZ7cjXz3cnxdZU7UYIFrLuJm/le9S2YVtrik8gzkDNEYzFky2WwDyl?=
 =?us-ascii?Q?1vw2+lmu1KJGE5SqC4OYs3RWK+cm00Y38p4XmNs2hNONfZAfilLom/0LShH1?=
 =?us-ascii?Q?yzZofPEEUCsQifIeqr9bM5ikPN5L+RRYCnwMSs2AtdFJnkn97O51Umw2IG2f?=
 =?us-ascii?Q?QG1ZwxfirsN1Vslg8ln50UNdxqH63yDERmmAOklCvPoRRORUaBUR/tBVcmZn?=
 =?us-ascii?Q?s5veUr+1kFOU3SpHbOHEfJII7Ve0HQe2u8ixMgU1KHsObgfdJmcMDy7I4YaF?=
 =?us-ascii?Q?Om6gx4nE01IzK/n9nK7pmxc3cAY5IrHtHn3b53y7dcyAcq8CnsMHBVsLQeEQ?=
 =?us-ascii?Q?J2DMbNHXYA2TjwhffEKu5Pn2sqQu9DqZC9aMwjEQJ5uwLQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lUleypwqAmIX9a/B15bkcUsp+c19mVnztwGPNWDMjnKq4HkJ092O2OlEttyu?=
 =?us-ascii?Q?m8mReebEh9fuYBXh9IJYO2AOG674VY2jMTCgsGQhsjQOANEU3VPjCQLMLuSq?=
 =?us-ascii?Q?fpIvhznpha3yN30T8h/0IaNILb8GD20EQubf66u1YV3pxJNz9KKwewH36EmE?=
 =?us-ascii?Q?w69trOOyBN4FBTAqs3z8qye9l2vdfENm+a7sCrRATai6xpkUkZ8OrUL+/LzI?=
 =?us-ascii?Q?DamHmaYpENpFqdtSBKPYLej5Pxehi2/jEEWIPDm+9a1c8swDIYF/ywfw060K?=
 =?us-ascii?Q?QqJ3mpaTijBwojv5GE+cbwD2C7xPAgFA1O2oVaojn5jpQlitlCcF2/RDbyG0?=
 =?us-ascii?Q?04aGIm1LnmnOnrR5OnFtGubBZ6SgM4+JID7tityOP/BGrPvSuXmIbL16EBN7?=
 =?us-ascii?Q?X1EdPu8WplXZMn/6aSqLBCMtT1c9+DbkHFNXwuIfb3+dZhq3pGnqyqZjNeQz?=
 =?us-ascii?Q?8Y6OANy0ZR5vkN1v293fXefmO4LiKXTT5OrdFcJN/6mEWdYE3vxcT4xBDqn8?=
 =?us-ascii?Q?nA3VL1eryciSDBCJ7tgZtgTfNLLvGe+dOveLrty31ex2wp7eTlk3W4AhcCBs?=
 =?us-ascii?Q?OVGIiHVhcVQx5PhM2YgSJq2K5+DsyRV12HrnwCV9tO4HoFglDcLYBJ1Urc8f?=
 =?us-ascii?Q?j0ARLK8zXRGg8LisDByA+UErjXGVAtDTfoanBSW9RcEpqQ+UbyfmoYz460IF?=
 =?us-ascii?Q?hgnV7VsU5bpGcS2+Qq/s0Cc5KcdnNUCDX3kQhaMOJZk384gdKByrXVqpOqQc?=
 =?us-ascii?Q?2GD+PlcTOhrIuNkbF6r44GDC6b8qQ8FWP92rChiLoPmKU6a54/kn9oc6QubI?=
 =?us-ascii?Q?uJs6KEJS1gp6TOv4J/J+mGPlSQdoR1i81Ng65tHG411NFor4wWyHcQMO7Q/p?=
 =?us-ascii?Q?VuBETzcwhO/UsXj5aWXQSk9oRVn9uHPgnhBQLKuaSeb19y4m8DmCwr/FJ+Ry?=
 =?us-ascii?Q?/C4ktqJ7c17e+jbxmTc62vw3gK8YBOE64TNJtQomWQVaIk9O/Ts78ek5db9b?=
 =?us-ascii?Q?HGiZQyvF56k2moDH3YWht1hzZl123Wc3D6jRVBoNRaY5KJAkqk3/M+HtP12K?=
 =?us-ascii?Q?wVYF9NvgnedLYPw8APcJqGJJSuOlgo5Vo4MJeeNKKyt9pbeD2Rz44HarwvzZ?=
 =?us-ascii?Q?Rpi4LNFoMiNqKjU28mQMqfiAYafyEZICkVqPJemM37fxifOrHSlyNddsc1Md?=
 =?us-ascii?Q?nMlBDMNfti5QRQbfmmR9hubY+YBP30ELRgpKt9WaVMasZ6Kr2VXSys2ehDgR?=
 =?us-ascii?Q?hW7QA0Z+It4M8j8FMuvwSvZhXi9GtQeWO5BtLwbddhfC5aQvOKDK3ZNESG9o?=
 =?us-ascii?Q?POTuX1xHM1l7lsX1TtJF5xA/DAmn0VgeiJaQXdDvY+7A6ZmW64tFn6RuwH63?=
 =?us-ascii?Q?/5eGbzA3fSFyWW9h1r6s37c86o4kFF0pbr//OILod+tyjquEPtMKUT74uAvq?=
 =?us-ascii?Q?GKc6UojMhwzY1m7MmAF2HQyFh0STdjYe+GTH10PIB8HpGdEHKhYJw3PA2k6U?=
 =?us-ascii?Q?y17R0uIN0EM7AhOE7qCSPao+YgLVsHHmxQ8q9doV+2GM/rz2/D9nraN7r2uI?=
 =?us-ascii?Q?gpBFKBCdfZKpdYhYDMw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1949d898-6e25-43c5-690f-08dcdf0d5e2d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 15:59:28.9006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e4CCYQUVciUUFgEzrMVUPSWJEOAItUXM+kD2wl8YAu/GeB7iw5dhPlBA/4nO4mly
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6564

On Tue, Sep 24, 2024 at 08:05:30AM -0700, Steve Sistare wrote:
> iopt_alloc_iova takes a uptr argument but only checks for its alignment.
> Generalize this to an unsigned address, which can be the offset from the
> start of a file in a subsequent patch.  No functional change.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  drivers/iommu/iommufd/io_pagetable.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
