Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011060.outbound.protection.outlook.com [52.101.62.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2F43546D1
	for <iommu@lists.linux.dev>; Thu, 21 May 2026 23:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779406040; cv=fail; b=djgx2UymsxJ+usE1HB4HDYQjZQf5N1Q0K966YAlRYvQjJj3/3xwHa97PHxaWcWG4uD68sYIeyh649VgEtZf7OPMUIq9ppxTT2BPtsf7VuG8RCrxhpwvLmC0rfon2gLuMcxr+x0BhyEMU+RJKbv/bcBCQJDoG+a+2Ok0oKRX0HiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779406040; c=relaxed/simple;
	bh=cuPkPoZ6wOmb/ANKq4vfeDeiBxuxven2IZEtwOpcgHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EuinmUS4AMqhGipjj65SvhJmuaBmWxaXQixRHaWztC66AKvtD9/HR4GADd9XY2FyhTyUy5QIjqnbnRS5sa3DLD3Nshzwu63TtCF57RvmIw4wWyF1ig0WFGmncQ8nn3oQ0IGL8MHGOV4CWBJFi2OWU8M5CYOvuEQdcn6h6lwZnoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nDPzxFsQ; arc=fail smtp.client-ip=52.101.62.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nDPzxFsQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MTmtULaL1Eu8aWNPXcjDaG+RxoSuNH0xnMZvR2N8O+ZIqr+OvuihSxVq39NZYQ0t3+JWcnHQ7MCkVtuOPStEzd5HQNNZ5xKk+pa8uO6mzWLxacmmwD/8z3F82vdX7wJ2o9w858upcmiIgZjo9nmu4WGKO74f5eviY9vnkvnQ4qUOm9oTYJeE1uZEZHrWw2gli4XikhhD3eJ0PP6K1PI/AglCeEDL7oKM7HAcacXZmqidJmGMmuGsq0qy0jS+XPqOph0QZlLsV2kDSjYzQdVWL6Yw0iWpVuaj4lAKcK0wRopXIYK/R72cgGfhM5QD5SSqOC2p4ecBj1fFCURrHlooUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IG8IE/M6CBBKBvo9Slh/WX1JfTSbxoibn9OROai7BNU=;
 b=NSb2CXfA5VhWfbE8SqaP8JTJACu0t4melzDjBNJyhn7IAPOpDLbHCq3NVnbgNlQ85axXCj5bveyO27XTfOuSVoTGnZHPLTslq2H8E/B6UwUYLts2zphlQet9Fnu+RyoKYZVq+K/a3Y5O4dLCFrdBDYNn88CR8jwdqE0cFjVKRZX47DsVb/yqUgb99LXOqk6WjjTvXlMGwIr785sSt8eKVbn3DmroqtoDaNqwacljulsHNs4HQrdB5VTGGfEVv8oDnr+e2weDLgKYWHETpZeAc5M3qPs9s0ZNRkvUlXLl/SSiVs7CPDuv24WJAAHlGo0KyhHV4xSzrNFVmndOoY4QUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IG8IE/M6CBBKBvo9Slh/WX1JfTSbxoibn9OROai7BNU=;
 b=nDPzxFsQju624Ap8tJ9ii5/qi/cywttE/FZElEbmp41wdwzkucpEkpW/O4vefl8q7OMumsa4VgZ6oVPI0E8GdEN9NwM5JvZkx7Bb7OV9Sa8rQ/NiqkL5CDsd2zWVYfR9Nu6ReQf2zDwfNYsgwIUuFKO6cQMpFT5tVGU3ErJHJKux6xfdwRE1qR6C0ebhAbyK3fRWe6w0m1V3LWBNR2YvqNsEaunniAsvU4tuer6+9B4jyXS0BJL1eEc20NV27bbktPcnHGExk5XlTIkkHFrO+RVcQ9fGXyWYgsbAMooMlQaLqtd9kQnj46jMc/LGvhjACgLTFf7QYydCxeTqPIlafw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV8PR12MB9135.namprd12.prod.outlook.com (2603:10b6:408:18c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 23:27:14 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 23:27:14 +0000
Date: Thu, 21 May 2026 20:27:13 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH rc v1 0/4] iommufd: Fix veventq_depth boundary
Message-ID: <20260521232713.GK3602937@nvidia.com>
References: <cover.1779070992.git.nicolinc@nvidia.com>
 <20260521143004.GJ3602937@nvidia.com>
 <ag9IjD98g2pHiGlE@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag9IjD98g2pHiGlE@Asurada-Nvidia>
X-ClientProxiedBy: YT4P288CA0087.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::24) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV8PR12MB9135:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d7a627b-9f71-4057-aeb4-08deb7907db7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003|5023799004|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	N4f/LdpyCk1H48xNV7vmjvEmBw1Xpj+sGic/hcJStwNd55CSg00bv8gGjB2dm3fDaQFJssDXhLZ+uTdTrVjs6xXwmJQFnp7pVtDlSLomyHGSD4sOmNCfWeoiYYPBY8qDSKj/5j3OpgwwfFJ8SZHS3I3iRy1wYbv2s821gK9XpjoAn1k6k5M/UYLPawGIACJIcnrDXp+LmZmbIePU+smoOh2t31UHAU/81jsGaiTdGPj8lmJqgP22+d1QkNvLZFbCLgR9jPmAbFH57aXEP6h2xVW/bheVw3LPCSaQ86QmO7fSHXUOKxewurTJKS95TCWdbf84lSrcuztIgghEGTvoFJr5LRYSDZaftyR7oE4l5vn4Wy0YVfz77pk0zbgh0ap7O3VxJluLlpWG8NT8FZ7+g7Ft2Y+DNntYXcdL/fmsg65Yt3A5dIrFdvid0AymjFNj+Tm6y94mxr1Zhph4bQ+Kb3leoQmJOnMkhAycKjCkgNgj2IujxyrL0FlXe6EcIhgX8b2FPQpmUSXhGaErlZBcPHn0OZTRQypze/Wf2lQfgKfRBqUJm6A4Rov9ixozmCY8UxXODyq831PGyrSduiaIGwSaCykpYRx4JGobHPilxIY1Y50uzK5yGyA/owbH2UynFIboioDVaOh4lrHEh6YOJOx9fEJ4HsGEzBM4f4l6zav50wtvzmUkybvMKbpO30dT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003)(5023799004)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YxUT58qWFVurtNVXnxn2PyjpmNunV0i8ignGiMCvOhGhLMtkMAlQVhRsI018?=
 =?us-ascii?Q?LJZiFINMDvRVn8fipwvTfXddFSdxWK6BLM9p/IH8AVkCd2OMH0BBul7rFzvZ?=
 =?us-ascii?Q?kgG1kIwRAs+2Zp8adqGJDPzPmwea1dqn3HmfELRStKDtu3CTxVp6FrbUtlYz?=
 =?us-ascii?Q?FpvtcfOBDX+mDvioELISFuFdDXJrYgVk3u+UBQlCudbA5u1ywKApeU9bNXKQ?=
 =?us-ascii?Q?+zr07X1nVbzCD4DhP0KCZ3YDPKmIkSAGZ5cX3JqPvNYQHGx2SseO2NRUCzqX?=
 =?us-ascii?Q?t5wRHueRKXRdwS/vHx7mqc0N8sJcKynns3vD08HuHd/4/dlsaiByLX6UeJjx?=
 =?us-ascii?Q?eaz0O7Zurhe0A1wVPGi79bgnNr/ZnRlBmC/v99trw1i8YsAIN4mxKF1SFtbR?=
 =?us-ascii?Q?A3eZlfWqB1gfchXisJKysIjWWC8OgKgQvGzyaJL88mSA74OwQj6oW1EC1Q1B?=
 =?us-ascii?Q?MJ5SiD6FuZYEowB7OdEaVO4yVX67Y3alLSOsSIT8UnRSizmQz5hSvd+fenY3?=
 =?us-ascii?Q?E7czCqLVUhe8Laz2Gx/3ia7tj1zKyUC0SVhY60n0xVGRauiM0BCjaJS81oa4?=
 =?us-ascii?Q?xpbl2509+JYVQR4xPMrUrXYdtci/UN3it2bjOogCtPxhasFZ3Sx5ifB465fL?=
 =?us-ascii?Q?gjJpR1v3IA5BA3M9vV+vX30MfA2TdUH1tcg0l7JoVti8U888R+H4Mno9zquU?=
 =?us-ascii?Q?U+KbCFtoTciIexipSQywsHZKCQHWfhYLH3x6SFX6/rd21Zuj0Jk6B9rjFYRI?=
 =?us-ascii?Q?uhJl1Ts7cw59xyRIhVut9S0wYiQDbLXNX+iK4MXmycm839qP/Q21vLQMcrfK?=
 =?us-ascii?Q?sUf0VkU5QUsqEjAzWXXjqVMcTh/NNWVhjW20nL0qpigVcRQZNOEUIiOeU1vJ?=
 =?us-ascii?Q?mvlXWxfdxRuuHTBQw3/sx/4Ck5GG2nw4YN3Q3SvZQN0f52Iz7ANtwlqwE+xN?=
 =?us-ascii?Q?7TK0GVfS2jds3eSIErFuN+4mvl0FsukyQwYd1itbc37SIFrqWu9kJvHeAPph?=
 =?us-ascii?Q?awzkPI1kfvFs8k7pK3KFrfBJGn5c/0oqGhNWxcKfFnHbdi5SgvC9kIyF/yJg?=
 =?us-ascii?Q?/iZbDXuYbrQQq47K/TMK3vTHfi2kuO5cStL1oko9PNJ2bwnzmMiER3DCM4o3?=
 =?us-ascii?Q?qBGxKEokxbZipzKe8MFPs5qPgKW2uM8LkGFEM4sa5DF27suJfte5y6dFqREs?=
 =?us-ascii?Q?D0BX3vncx15dWbL1L2mCP6fEyFd4Ez2eYd4nTiTSj4zas+Li/Bq8m7FWTJdB?=
 =?us-ascii?Q?Eg1oo3JbED9Yif+UVt2lme+aEDdaGS49MvnxDyRejhf3z1qoJVc6rCDV45CB?=
 =?us-ascii?Q?I/oLj76dYIlsIUtIhcRar8PVfZvAnteH5gpwzrHvSQqMAecQ/o8HSETFHuof?=
 =?us-ascii?Q?LfAQ5sUFR16EydDo4P5xT/1526TUTuE6zBK16NnruxSWZ/JBIeBavLi+b9KC?=
 =?us-ascii?Q?jBRMdK/H896L6F+Yv1LFM0C1C8PMOYeVebUIU9YcIGqBIJvx7xUTKCxYr3dA?=
 =?us-ascii?Q?KsVoliyq8XK1j7/sbo2PU29Ql74umtCK5oZquLmez3jM3xNc4/OrGdLnDzVb?=
 =?us-ascii?Q?gSO7y7R4dgVsFdYjyckr2HLrK1LjKMeDekPgcjhrmo0EoN9HwfGL1oFw18Sk?=
 =?us-ascii?Q?T990G1nVoQJs27we+nElPkMMiUodX22L946xR9sjqzpi/aOHOeb1ha97vKYX?=
 =?us-ascii?Q?125v/H3Oi7JmL7wFU4xHdx9dHkLCH6BCLAVO64GBIDJ4Pm43?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d7a627b-9f71-4057-aeb4-08deb7907db7
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 23:27:14.6997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w2Rj3CZstdAfiNHs9Tg6eRvmkyX/yWBhUQmoW+q1lgVYSqoAQb+BS+u1mnhYM4p4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9135

On Thu, May 21, 2026 at 11:01:48AM -0700, Nicolin Chen wrote:

> FWIW, it was added to address a Sashiko review also:
> 
>   By moving the allocation outside the spinlock, the precondition check that
>   skipped the allocation when the queue was full is bypassed.
> 
>   When the queue is full, which can be common during a hardware fault storm
>   if userspace cannot keep up, the code now unconditionally allocates memory,
>   copies data, acquires the lock, and then immediately frees the memory and
>   drops the event.
> 
>   Can this tight loop of wasteful slab allocations, memory copies, and
>   deallocations exacerbate IOMMU fault storms by adding unnecessary CPU
>   overhead?
> 
>   Would it be possible to add an optimistic lockless check, such as
>   READ_ONCE(veventq->num_events) < veventq->depth, to bypass the allocation
>   when the queue appears full?

That seems like nonsense to me.

> > 6) What do you think about the "but done has
> >    already been incremented by sizeof(*hdr)" ? unrelated issue? If it
> >    is simple lets add a patch here to fix it
> 
> I added a patch but didn't include in the series -- Sashiko would
> raise more questions against that patch...
> 
> I think it's a separate bug; Sashiko pointed out another in fault
> queue as well. Both bugs are at failure (corner cases?) path.
> 
> I'd like to address them separately.

Ok

Jason
