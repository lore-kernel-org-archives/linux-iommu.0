Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D603F9ED
	for <iommu@lists.linux.dev>; Thu, 22 Feb 2024 13:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708607466; cv=fail; b=L5eR4AktAt3nRVJQ3TnaLTbGIJ0W2wJAval0AH4t8CrhYxJkUJ7Cu3/cvuCgXq2LlSXzf00jSBh5Qq0FVXCNsmafNa7LfOtCOGFpTxwRzIDXm71sq3gposFswPoN4ktdv2DM6FQ5uWZa2bBjivjcpcM5RlBlj7CX61fElmTLyyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708607466; c=relaxed/simple;
	bh=sk+DJD6q06GqjhH46P0ATfOtX7ywiSckaJI0pXdvsHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rMToZDu2oRsZsNn307Xk0dqeX1cY25U85PW2jtROeAb7gXTX5vnIJFvpVBc9sLdwnJYstySxFMWAz8+vY8/Y2nzJtRxB4qN64zbPPNUHalj4NbAHfmCJy1mJywqnYs8j7Oz4VoSZ5CA8HBrikgUG7p+lYDG53UOpJUDFDwaLuFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S7oLugvS; arc=fail smtp.client-ip=40.107.243.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S7oLugvS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=faa1NtNFaBRB/iZtrEn/AJHwnz48QadnYAB4T0szBHOSaeuXZyCfgpoUbFtUQ3/mn149MbPXTBUv3Mkgmt4ZQjVIp7WbP/sVid+k0sbcHEJnTpcVnLswPcOe9xAhFnVjOhVYSdCSrtrVdPSQSlMHDvC3Rtzvgd7kVZKI5x+d0tMKLRbKeB3R8Bwg6HSbQENnn3uuX5huA3RQ0ABaxQlKOhYQCUfmdDK3g+W0ExPfZMpqLQA9dOXas2vOigQz3K/J16zqUfkPI/KTJTIFgzK7/V7g/a38FlDTnlDYD+cSWHkGQJxHfvMropf7eWAmwiADcN7Sk83gpOJwpNuRCfRZDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSCeKtxX7zbdLQL0KGZXXjojH4NQbn92hpW3XqOYg6c=;
 b=ZMDw4gYHsjAKf00pnyVaMkEYX+OQ9Mre57+OeuEvD5QtHXKnB5kybvr7fz68XKI8nVCDJz7YZ5HCrHdsEUDrxVYZo7lOdX7vsX7wVYEcf0sMHqFg08AiZAfos+DrVtcE21LaYWKabQPtx5TsrZIxwrHyrGQyElxO+0c1keyWb/Ok2OSz4SP47Cu6jO0KKlYX2OyQCgeQ5MmEmQf29cShVmFnUgGQutOG0em6SGxELrX0V8N5y8/s9gkW3jtdae/Svci+9CjVsetbNPqsK9zq7zX9gbr1YntZNirAuEme70B7PnZwK12B1CfFTW2Nyk9EVnuKkVXPvy0L8V91/xi5hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSCeKtxX7zbdLQL0KGZXXjojH4NQbn92hpW3XqOYg6c=;
 b=S7oLugvSiW0IIPUM43UTIdEHBuKFQgKpPzgGuaGtirVCA9ruOWWcOUKEwR2fq1M6QAVs2lVmeigwT8Y4AyzvGChVMENQsfMV8cGObGqANEIyJ026J1y6jaoNSsjj3PIaKPgw6w12xorlPHnGF4rToHIgNeTI3A6cVVEaBZ+01hX9j/NACSfdGPOF6YP+GCYzkP/MLpFgZz2d63vuIXUC/DMaT4x/AWC6THrjLdmVmzgOkeEwOEGuj9MKDiRYI38hjVB2YJC/0AyFP6UaS0tOvm7z6s6Q52gzthDRwVh5xlkuggdpGezmxz37IaM0jhPQU60aJUsQGNiHG5ur3PpWgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL0PR12MB4867.namprd12.prod.outlook.com (2603:10b6:208:17e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Thu, 22 Feb
 2024 13:11:01 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7316.023; Thu, 22 Feb 2024
 13:11:01 +0000
Date: Thu, 22 Feb 2024 09:11:01 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Joao Martins <joao.m.martins@oracle.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"mshavit@google.com" <mshavit@google.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"will@kernel.org" <will@kernel.org>,
	jiangkunkun <jiangkunkun@huawei.com>,
	zhukeqian <zhukeqian1@huawei.com>, Linuxarm <linuxarm@huawei.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 3/4] iommu/arm-smmu-v3: Add support for dirty tracking
 in domain alloc
Message-ID: <20240222131101.GZ13330@nvidia.com>
References: <20240222094923.33104-1-shameerali.kolothum.thodi@huawei.com>
 <20240222094923.33104-4-shameerali.kolothum.thodi@huawei.com>
 <a47699c9-4f3d-4cd0-94f4-f19e117ea6a3@oracle.com>
 <dfdc7daf8bd14b04b9bd29faaa1e6a96@huawei.com>
 <5607ece8-ce00-4834-9ae9-f4aa16fc4886@oracle.com>
 <d6442be07c9d4f999286e073ed221984@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6442be07c9d4f999286e073ed221984@huawei.com>
X-ClientProxiedBy: BL1PR13CA0343.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL0PR12MB4867:EE_
X-MS-Office365-Filtering-Correlation-Id: 7865fd0a-3f48-4fef-eb75-08dc33a7b7c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SHgGZoxRdK72fQ8j1JJLbEsgmQD7aTy7kKi8kLT+8OtJxyLvnvmtmdzWXA9cMuqiFynXFnSil8dDX9Pm7+3eOHC+aozAlPP7tRF7z3XEqJwQRMqzvpFyRClZZ5Mu46MJwdrtYlXdv/NaFSrGcbMMRDWIYiFwGmn66/pmPO5WhXjiDsW2PSitjWT5Ptl83u2nODQWCm4inIT3v5l12NkIKQES3SMNtB1FOYqAt+tztkz6VRzxtQM8G7xjGiIoTyd5q5hxpk470UOkhVvgVpLNu5EIVeqQud4M8or3bghGE85fzVcVSF9TGf2Lrm5ereIRWzA+OFL6N/QIgGc+KxgAvESf5bqR9r6q7BFsKnX3G0jzW/JHVNPW7n6GS5cpNTBDLR862Yg6PUDhIZXNgw3y5FPsXifUecOpD3iuG+YtYqgxpadKoUTFwkgLq1h1IAm5C/gTxuIkDV2KfcfUu5oDHfGQfseN1+HhaYfsFR9bX9Mjox7P3+dMiL8KvDqUbdUBpphvwBg9QVySid94k6IoZ/+o5nBEdKhMMSmRqz7GlK8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BdWBfnF/vNZmFRdJByf0vG47QxttaLqx58AkpNMYTBvUdL6quubaNnHe4B4C?=
 =?us-ascii?Q?i6IoqE8a3OByv5cLKLAar4Z7dy+bJk8nEIPsyqSkEquDs23ZAOph49U8Rwmp?=
 =?us-ascii?Q?wKKTkhNM9l3OWfl8IgxIzf6rJ7rBL6vjkaTJozqXtkNfNG25wXcNMqO1uULg?=
 =?us-ascii?Q?lplKn/5oFu+3NxRBu+wh3Naa5gE9ZdFjOuJwpxNhE6EgHBbUKua/Tv4BHURC?=
 =?us-ascii?Q?LE4WxsGoiXlvz2Ao8DX0mP2iziJzWJSTyIjCXtjqLAj1AnPGajqlfPW8FMGX?=
 =?us-ascii?Q?U8+HVb6EI5kwbVEPbGSZassfevhCarvc9haOce/2ehauF5dT3YR+NygKm2Hj?=
 =?us-ascii?Q?+B4IzC3kaBXZnt/ANFXWa/tS8WZIV/tU7VYrlgXEhyPyDgtQOLq0KSnEtMzu?=
 =?us-ascii?Q?mcbtLplKela3UDCPRjbliTTJlv34ek2Cm8f4dpqhfSSs6vzDbsL5S+QMtRBu?=
 =?us-ascii?Q?TG/gjFjxc/3shfW+rZROPQjkJuD5GFhXNVu6o1gvP+xuzaiyiy4gCg2WrA7s?=
 =?us-ascii?Q?bt0uVrGfyOtFvZ0F4ewg4T9xljE5hoFf/zslEtLCnI6lpngNbl2M7K4AHl38?=
 =?us-ascii?Q?BsqKTST1nQD8LYAqO54OfXE0x6YRv4vsehJWtKCcDBl3X+FjjGXnrwP4NA7c?=
 =?us-ascii?Q?zuM3n2lawQVS5ZKPTBvlYGVwiopX58kJv7w9+QB20RpyN3UBvjbUuQSWJL22?=
 =?us-ascii?Q?1ecLJcV826o2iT6LD2b7FIrBV3EFbAFAYUHdifnu1CK64gmWhnVOc5MNArVg?=
 =?us-ascii?Q?S5HJwigX6HfRaYLcz18XRyJd83fC5nJCTFTtR5btnAelS7ekKfViGdCDVU3X?=
 =?us-ascii?Q?2Y/GFSD68I60utjqrNs8U79wFBNtBYHbnq2YDkWoTqJ+uMOFNZJoxpSY2ylK?=
 =?us-ascii?Q?ttdxdhZzZgeqOu5I+gPFZUxwaBzPYFy45ohNhRxZz15brM72SMPIRhRB+oAX?=
 =?us-ascii?Q?Ag3OcM+VZkMmOTm/Exbw6KuaPvZfXt6t9DDmwyqDR6zI1rvOALkF4qDu9cYE?=
 =?us-ascii?Q?aPTo2Foum9t7yFNDQrLdvn5rXp/6sLEJAKOQfGZ4FXfeOXqi9lE3KtIrZ03N?=
 =?us-ascii?Q?5elNavrP4WY/Z5XauCfYrOTws1S94GPCvWUQ6fUXxf4kinHaA671aghd+DNK?=
 =?us-ascii?Q?1UeGIMoZewLjtfQpycBJ6uecUV6tGflcoDux30T1Jmo2u6UUBfDY+wqX2uki?=
 =?us-ascii?Q?8fYdCxlsGa5owUimFTFFH/ygNKQchXCY9ARdjxDXAJ0YQE1+WPZfj/JRRqGw?=
 =?us-ascii?Q?IDwtgITXad7TYf/9oVGokWHOOfZBeCszGrT4A3Tgu42W1QGIBXWO0vw222h1?=
 =?us-ascii?Q?iAPJGPY4AP030B3WaSiinO0pWThALXp0uv2NJ7bBSyJweQq+70qDLmM2n8Je?=
 =?us-ascii?Q?j6lAUqWpv3tJF4de7YqqdOMh90ZVkH9CQMCJF9GrT1lXUYLcHfXKIbeB5VNu?=
 =?us-ascii?Q?D+TuO1XKhD16XeNMP4kifD00BL2gLmbUqCE8FLibYnhiqGuy0p+GLjX5juIk?=
 =?us-ascii?Q?oSYBw/pinlAKwv/peQ1fm8MEIuGfAN5BkmpYdUQkf4cETXk+KFgMUoO8MOxy?=
 =?us-ascii?Q?rYd1QeRT8RgUFT53ePv/nkl5EqoYCtlGEWyehQgC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7865fd0a-3f48-4fef-eb75-08dc33a7b7c3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 13:11:01.6491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5+A6iRE+Xyga8fh1i+yEP6DbJQVmonETjcdt+gDLBwSCRd5vPZMMfTKCR2X+ZAa3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4867

On Thu, Feb 22, 2024 at 12:24:06PM +0000, Shameerali Kolothum Thodi wrote:

> > > Ok. But do we really need to check this in attach()? As dirty_ops are added only
> > > if it is requested in alloc_user() and there we return err when hardware doesn't
> > > have the capability.  So not sure how this matters in attach() path. May be I am
> > > missing something.
> > 
> > That's when you create the domain with dev A. Afterwards that dev A is
> > attached,
> > but later on you can attach another device B to the domain. So this check is
> > there such that a domain with dirty tracking ops set will only have devices in
> > there that support dirty tracking.
> 
> But that only matters if dev B is on  different smmu without dbm capability, right?
> In that case we already fail the attach with,
> 
> >>>  	} else if (smmu_domain->smmu != smmu)
> > >>>  		ret = -EINVAL;
> > >>>
> 
> Is that right?

Right. Relaxing this is on my list :\

The other two drivers don't have this limitation so needed the check
that Joao described.

Jason
