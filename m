Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011015.outbound.protection.outlook.com [40.107.208.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4409947F2EA
	for <iommu@lists.linux.dev>; Fri,  4 Sep 2026 11:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788522441; cv=fail; b=OFn9s07nB9wGAejHy9sjhu4h9fwsBJ9oIphDktJ1KABR/dPEQnjrhcTei3TTjplaDP/CaZFn785orVGhgLrVdWCq/d06AM503yYnl3VQsHDAQLSqf5+eZ5Q56JkYRIZzmjsskRPrf/Iwjn4jneowRyvg6Qm5p2Q5KThB2LUCj6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788522441; c=relaxed/simple;
	bh=8/gzKUfvo4Aqpqj98o8tivODkYcoxXGyiTdZyzpLQqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DkBQxmCa1vA0k7am6GKJH6Nnc3MvsuuRoT8NfNk1XmtppNRpBgNtMr2inSjOXkuOn/kKY9QG3NYfMdiLEcUANcFpON4An5ckXQx4APdYp3XdibV14H6SPYdxvAlNTjzzWNAmtnFdLtXvnO6tpe7Vi42s129noOB+VR8eRurt2FU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qtkCgF71; arc=fail smtp.client-ip=40.107.208.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qtkCgF71"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4ycy6o7ckbZqtTuKVcscbRBt4uapNFEAsEx8pM/A8PApMGT+Ts5CqXUWDF3DVgaRysBWHQf2jB/iPaggDFY+6HnSTQjCLhiOseWOQ5N0xGSdJ5g63R6S+DSZ1uZtK1V92q87pDw08a1VyR18xZ8T57NqmZQKsPAi1r0cw9PEzroI0OnKOrXgPHN8FMeNSa+6sK+GExv3w2JyjTDv4aErTGIpYebyLyOFJEF7290dy0AgtTInTX6wZGgxG+zWjjwZoQvqdZVqLN8OQ31Xdwky+2gPIPxsG4fiPBxScumEPOz41pZ4/CXK98xjXBYvXFDW0aaxiNkw56fJdgldndvlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4dtimgsOiLWju7xR18BevpBC5wIYxueT8dwQIiAjWlM=;
 b=DpEDRkPOYJlFYRlPDtg4vHoQEVBXsB/SYCOlkfsTjZoDJHM9oABPgWA8fQKU5seKteOeIkAUeXKJ9R/eHh77Yf+/8/sjZRT+7JOhnxlwLaKSNeYjRG/WwQ/O198tHCZvVa20LsAs6fVw5YkMnCr1uRQmRcmMYczQmmrAgVZwbb60yEHQOBHtS7O577ZsgNd9tJbdRleSNc9rWhdBOBOwdkbhnWNKi835WSkTq7LNltLA5SRpLtREOla/9w9y4LiX9IYtWgMKzdkYz5NvFJQ/RE4R4dJQkptXhwDkuMTcaaAPAUx6mQKeT80oIYi0VjED/iarxEET7gvpmPTPcAnTrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dtimgsOiLWju7xR18BevpBC5wIYxueT8dwQIiAjWlM=;
 b=qtkCgF71heu11hOMB6FIyJEndGuUHfbv3/wwsT4YqjPCkOxBBPQRojIKa+1XrGDSH3yk4pQKrIm9kXouuZtocn6r0/uQSNvObIpgvP0aZWfnAsZkHC6fjL5gM5cfTr0J0jSfMZzgnNACgDG0hVFav6fDSXvfsMvmVVlfziqd3BbGg8PsZyZ3p4ZMh0fMgCScRDo/oPUFlEygCyJixn9VniQ8qHBKC0Jv+eVez0PmQCCyZTIfloWUwE0grnEwV/NIDUKBFRZC9ucHGzzcZUpPN7U1Mh7IkgghM8eZo+3bfPtOoj86WfGuF+H4aq5vbZbSKX+NSLo2zi2F0Yg72mmANQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV2PR12MB5824.namprd12.prod.outlook.com (2603:10b6:408:176::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 11:47:15 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 11:47:14 +0000
Date: Fri, 4 Sep 2026 08:47:13 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Christian Brauner <brauner@kernel.org>
Cc: syzbot <syzbot+7666ed2c3d42196bf7e3@syzkaller.appspotmail.com>,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk, Kevin Tian <kevin.tian@intel.com>,
	iommu@lists.linux.dev
Subject: Re: [syzbot] [fs?] memory leak in path_openat (4)
Message-ID: <20260904114713.GP4157646@nvidia.com>
References: <6a8efe2e.1d9ded08.62e62.00b2.GAE@google.com>
 <20260904-clown-zersplittern-sequenz-987f972a607b@brauner>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260904-clown-zersplittern-sequenz-987f972a607b@brauner>
X-ClientProxiedBy: BL1PR13CA0174.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::29) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV2PR12MB5824:EE_
X-MS-Office365-Filtering-Correlation-Id: 031c16d4-0fd8-4af3-aa9c-08df0a7a4395
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|11063799006|5023799004|4143699003|6133799003|18002099003|22082099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	4AlGJtedph6/qkf/YVVY28JadJ0T2oHrVM49x3ctovf58zZjU9jft8hXMxeloC7jLwdBDuTZp+cZKhaevdAZpgHBJ+G5pzA+ekRZiFRVnfeZlPBLSxXk8gWkzZhefeQgPzsHH45YaUFAKg0AZWkB9e034nAE93Yz3mKsZQ+HFyr1YdKZiapI3SpdigyN9+ewJUXLI/rUqOYl5kw6X6tbQI8heGrXWsb3DhDHeg93guiA8w7H9RPwFrR57LU910LvO6cpW9v7FGORmGthfEsNuVV3P1akR3+rpIYRLLCmdLM9iVHMCmX3zKImltdqQUDdVmtu14NNeCq6KpEnndGfgqVJwPEjXDKi2TELirDRZWBhYPboZ0iPmQtQNd5zOjKcZaqzQ7e9eatxtCKMwHO4hpQL2aWoF0i/u74ki5eXCeyrCzKhETmIhSAoRhkt2aI5wc41F/2F1Ur/rtiZNVRKM5OJZC1BTVpaNJmAcmyl5upLTd6TF8S5vuwLiZjkVFmthQttj7iAlYuq9pEqS7Gkccf+k9O25cKZk/4/Dm1zTXdbTMakYfSsOgRdbgo60PFTzh7pa+LjUyTjFBF+546TQ7Hx81vylvzKfn85RmyVGoBE73EOd6VwisdSt3di4xn959fny4nO6arGhL3YUuq6kX2VvP9hKLx+Ylsdsmp6NPs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(11063799006)(5023799004)(4143699003)(6133799003)(18002099003)(22082099003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STdmNVZVaVZ0bkE4V25xNnpQTEl6RUNnN1RsNDRsR3c5OStFektvWCszRlp5?=
 =?utf-8?B?Q2xienlLQlFuZUlRbDVGMENGU3RDYUl4U0xEbHpkRnJROEtsd0hNUk1yOElx?=
 =?utf-8?B?QmoxQ1cwNFJkYU1aUE1tZHRnRjUwLzhQN25PTTdsdnlTYUFZSUtkSXVKVG80?=
 =?utf-8?B?UE1KcVorMWhyT3hNSndEbU42TWQ2aWRqT2l3TTI3NGp0dGIwZk15dHkyNXk2?=
 =?utf-8?B?VDBBaHMzTzFpRTFRckhUQzlSanJvUmcxT2wzQU0vemlTTldHanlTMzlJWEtk?=
 =?utf-8?B?azBoeTZZOFp1SlZ2QkZJVE1DdXVRbzFHUGZsVkhrcmlRb091U01QNVZSVlp2?=
 =?utf-8?B?d0l6eEJCVDhuaXV5dmo3Mmtkc09ib01Rc1VoK3ByeE9BVWI5SFJva3dVQXVa?=
 =?utf-8?B?UklGSVQ0NlRpd05NQzBrOHBNdmxzdStoaFk4YTFURHlTd1M4bUJ2RmxWRFg0?=
 =?utf-8?B?VVRIeVVPTWlzSTdtRGdjc3o2c2RiVG9sY08wNjdzdkc1MzNiQzdXZEVkZ25O?=
 =?utf-8?B?RXFkOUxyd0ZrMFpZMzZyZHhEbm8zK1hHSkY1OTg2dHNNRk5XTE54UWFpN0Zy?=
 =?utf-8?B?YzdDTElUVTNmLzZzbXE5RmMxbWQ4SHd4cjhQQW00aWMwZndtZ1dPVGlwWC91?=
 =?utf-8?B?b2hhYlBIbGhRS3VFYmJ5OWdYdW5XeGRkbTVPdGFrelUwMUR6VTZCSUxZT3Vq?=
 =?utf-8?B?THF1OHBOSVY0WjY5a0t2MHVlUDFFOGh5V2JWUllhS1pyVEF1VUZuYTdSRDcv?=
 =?utf-8?B?bFBNSVBIdXZqcFVnVUhCdm1heXgrZG9yUjdmOWErZVlBNmhmRHJma09aaUZw?=
 =?utf-8?B?VDNIQWdMSEVhcE1RbWpGS3JOUXErM1c3cW5ESzNhSUhMcm5zcFhVVDJNVHo4?=
 =?utf-8?B?QnRKc0F6STRucXdOT3RaQWRTL2FUbmlxOHoraGZCUFM3TFN1U3JCUWloOXQ0?=
 =?utf-8?B?MlFiZ1AzSzNNS1JiQnRVVzlRajUxODYxakZaRFp6SEJvSE1uRWgwbVNFWFNl?=
 =?utf-8?B?RDdDR0ExRTd1Z1hpSkdYTUZCZEJDVWZQckNiVko5cUMzV1h5N0EyQnVnZmRv?=
 =?utf-8?B?cVd1NHlFNUtXRUdsSm9WRVhrU05FQUpvMUdKUG5kcDJBU1d3akM2anRWWThZ?=
 =?utf-8?B?UWIxeGtqT0h1UzZpdEtjeitJTkhzRVdsZTBEcVRJcUYyNk01cGtFbFU2MitN?=
 =?utf-8?B?b3lwa1RkYXl0Zko1RFY4WHpsTlJxZi9wU0xZdi9iLzVUSGFVT1hOMjhBUXJU?=
 =?utf-8?B?NytHenNEc0FwZG9MejVtR09OeE1XcW1tNi9jUStBcFZDeUZTSkRrODBKRHVi?=
 =?utf-8?B?cUY3L0pEMWwxZE94Q2JXZ2JEQ2xnend4TjhGR0dvYXR3aENTUWxwOHlZb3Av?=
 =?utf-8?B?eHV1bWs0cVE5RzFBeHFSNVcyTm82N3BaYzh5MHdFQUpBS3MrQmxRQW5pUjFt?=
 =?utf-8?B?WDBTbm9qcEw5aFhFSUNNRGs4Q2FESEg0Z2NrS3YxcDg2b0RTczU4N2h3Nits?=
 =?utf-8?B?bnd6ODEvb1psRlZXcGJVeElFRmJVK2Y4R2dLTy9Pb3FXaGR0M01leDJiekxY?=
 =?utf-8?B?UDFpblJDdXZxRUVCZkhDdDFjM29DbmJoMVVVSm9HL3VFajBXNk0wQVVUcXZp?=
 =?utf-8?B?dm82UmZsa0xZREppUk44eDlOcVQ3eGdkV3RYcHg5VEdlZjVTaU1hYlJRQ1pJ?=
 =?utf-8?B?cU1qZXk2S3Niam11Sk1XMCtzTW1xRUdpWE1CQkYzZHdVM2lOZzRKYU1qSmk2?=
 =?utf-8?B?U0Iyb0wwZTR0Q0dLY0lxS3hoRlRBV1ZrbUZ2Q0JPM1J1QWNJTGVzUloyU1Yx?=
 =?utf-8?B?ZG8zaWQvUTdGQmc3ekZWUnZMNXBLWWNOd0N0a2tRajVYNWNHR0wzQXNxeGgv?=
 =?utf-8?B?aWpPdFd3bXdyZTRkNTV0Smhzc0ZnWWVHTVZ4QkpMRnl2S2F5aXlxVXZLSi8z?=
 =?utf-8?B?bldzR1NkV3lOK2J0dEhiODJBV0srdjVYU3V5RTRQTWFtVnVmaWcyc0FkT1Nk?=
 =?utf-8?B?YzFUY09qSGtuaGlvU2QrR3lJdmtBUFhGWEMrRm9pVkJWZ1NDUGtKSXlod29K?=
 =?utf-8?B?cjUvZXFzZEpjYW9EWHZQWHVXQlFuSXM5Nk9BaU9DQ0N3elFvdysvZnlySVJr?=
 =?utf-8?B?bVA3aEZ4SGlycUtWdGw3WkR6TnQ1SDRDNmJVWUdOa0EveHZoRFZQMGNOR2U3?=
 =?utf-8?B?YThkZzh6LzFOUW1yVnVMa2hwcVFVZElKYU40TTVsNXE5aE9HMzFYTFV1c2ts?=
 =?utf-8?B?cS9nSis0UkdnTFFmeEFkTEU3UElISStBTXJCa3FFSnlWRjh4dWtGRGw0dk1o?=
 =?utf-8?Q?nt2jafBucWeMW6YI7y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 031c16d4-0fd8-4af3-aa9c-08df0a7a4395
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 11:47:14.8430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U3VtK121Q5M7A1HJPlqpRTdXSQpewlZejarxyX9xJq5Hoz7cFYQ9ZAxerL+YRqxW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5824

On Fri, Sep 04, 2026 at 11:18:02AM +0200, Christian Brauner wrote:
> Closing the fd does nothing. The hex dump shows the same pattern btw:
> 
>   - obj1 struct file @ ffff88812811f9c0, obj2 its LSM blob
>   - obj3 iommufd_ctx @ ffff88811161cd80, first word = ffff88812811f9c0 → ictx->file is obj1
>   - obj5 xa_node, its ->array = ffff88811161cd88 = &ictx->objects
>   - obj4 iommufd_object: shortterm_users=1, users=1, type=4, id=1 → the IOAS with ioas_id == 1 from the repro
>   - obj6 iopt_pages, kref == 1
> 
> Likely caused by f4986a72d6e4 ("iommufd: Add IOMMU_IOAS_MAP_FILE")
> 
> Afaic,t, this should either reject based on file->f_op == &iommufd_fops.
> But iiuc there's other cycles that can be formed.
> For example, via a vfio device fd that's bound to the iommufd. It holds an iommufd_ctx reference via iommufd_ctx_from_fd().
> So mapping a bound but unattached vfio fd builds the same cycle.
> 
> So probably this should do validation what type of file can actually be
> used like shmem and hugepage file.

Oh.. This is a bit of a pain because we rely on memfd_pin_folios() to
determine if the file is acceptable or not. I prefer to keep that
logic contained within the mm side.

The issue is we don't always call memfd_pin_folios() inside the first
system call. A normal user would, but syzkaller has arranged something
a bit weird and out of order.

So we need to figure out some validation to run before the mapping
step..

Thanks,
Jason
