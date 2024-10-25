Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1155920F3F0
	for <iommu@lists.linux.dev>; Fri, 25 Oct 2024 23:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729900737; cv=fail; b=CXyVmmDZCzJw2vMlvp3wC/Yss7LxbtEMQXGQGBy9eRSxybAkRCFRUkaAQM78APIBl2Re16fbSk7sqMLFen1/KJoDlyatKSt20pMR/3mtM5is1vooOPQGrIUUiDzlI35rbPDAvYFHlZ9el4F7dvqvRH9b4HSvvsnPF6o2rAhmeDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729900737; c=relaxed/simple;
	bh=/K/+mf8o36EgXf41uKsQ7YNWvnXQtNQm9cj+Ff0isDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Jio7varnaePgRpEbGv8RbSa7+SCYLcBWGDl+JANxas/d+uqP59GY21qKP9yf3kJcoLVGBGJrktTb1wYXYuUUQLrIxMOXaTQMy42QE5AWULJKbul45fKq0nPsrYdrcewy3VjXJjqzJT/78+JuaTWjG7ddmpAA8Lm3SMf0tG+PkK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MzuPowsg; arc=fail smtp.client-ip=40.107.244.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MzuPowsg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lgS1dRDYyIAMrCgZmswd9Sb+QWm0/YTyi83TRsRA9iT9/ZP3YW7Sbv3eriTkyvzRBLl7zx6PwA2YGGkbAu7ukTdbXNDXJ2KNsel2dSo6ZYBPFkyHkxp0jFr2h2qFi+z+S/HPPOboMQCHS8M8Ou/K9839GM3AH49f7xZAJJKg5fZNYDPFgACZminUFHioo3VHEkdps0llFkVO79T4GYDkoRvTCmRl085fc7InqvHjDxl8BFX9yTUE/KgCR94uXCxJfu1zPumN19ip1C43Gacd5ISl3wMfY8+6WE6cvXmvMobL9QjdF7G0UNIwA7WYuKKzs0QucqNfxeER77gxl2QUhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fF+FAWV/ky+qHQkBLiCBOPAEVK1IG5+t+qXuSBPsnio=;
 b=mNchl5noytEF4sFq2pGpWaNYG9SwA8YS77hZsv7v9vWL9+3ZAzDZ18jfQ91qurRppVT/x1Ig51UyU/mEAR6dTaL8/gCLDttNxtOoRIwIGF//ddA09dLZNM3snFPUGMgJOfzWl/6jCt/t8H44FAiuN77MxGY84ehv1GQMfLSTE99bXr59j32qex+oA01vBnNy1QSCD0TGA3EYkg4gn3T5DIbwfTqG2wwz9HXQpdlfu7dTymED//T5149+kE+r0CHvlerjC+eJJu5JyNyfHimlB+3erqHdLFINpz6MyiNz5KGJIeWDZIj44xacAR60PCvzBmnFsc1me/GYSDoP9l6GSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fF+FAWV/ky+qHQkBLiCBOPAEVK1IG5+t+qXuSBPsnio=;
 b=MzuPowsg9DpLDQZJ8ALPpv5njGqmh4HiXy4luYTuzxwrF2QzPRnrvexR4j0IdrTH77blKO5bkA0mjbbqlA/xmVkTcI48X+YrnStbFodF2u+9h0vFRC9qE8AqLgz20qThEQIo2iwUAeh2GbJFmbmNM/WGvomVItdxUPOuObvP+3owHEvqve3psSIz/ywX+CYVosxB1EpAade58iuPx1ZVFrSuuk5YFYHdZZhBMT4AAZmjCtgF2ZMD63xUEo1B13sYLsft6z0x+irAsEhdZ6E0r5XT0LCpzZH/R3JpWhkroKAZ3OAFsz29YDQ3YqOTuAdVD3rctfq0Pv2u9y32T+FIIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY8PR12MB7659.namprd12.prod.outlook.com (2603:10b6:930:9f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Fri, 25 Oct
 2024 23:58:50 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 23:58:50 +0000
Date: Fri, 25 Oct 2024 20:58:49 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Steven Sistare <steven.sistare@oracle.com>, iommu@lists.linux.dev,
	Kevin Tian <kevin.tian@intel.com>
Subject: Re: [PATCH V7 9/9] iommufd: map file selftest
Message-ID: <20241025235849.GL6956@nvidia.com>
References: <1729861919-234514-1-git-send-email-steven.sistare@oracle.com>
 <1729861919-234514-10-git-send-email-steven.sistare@oracle.com>
 <ZxvPhQZOBR7g56eh@Asurada-Nvidia>
 <2c7edd3b-61c7-4012-b825-4972c0efcec5@oracle.com>
 <Zxvl7J0mWkKPS4GD@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zxvl7J0mWkKPS4GD@Asurada-Nvidia>
X-ClientProxiedBy: BL0PR02CA0041.namprd02.prod.outlook.com
 (2603:10b6:207:3d::18) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY8PR12MB7659:EE_
X-MS-Office365-Filtering-Correlation-Id: c41f84e8-e879-456a-483f-08dcf550f8fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LK2nlwKL4rIHRIRASigxQBxrYmiIIYX5uvDrXfv7HQpEpVz2FswRXlo1/rmS?=
 =?us-ascii?Q?j26DlFd8bCekPZcD0xceCztWtza8oK+m+S+WtYCCn7JWvvr+ezeOcwjoBTfO?=
 =?us-ascii?Q?jbzMbLZCf3sQxe8beDu2Vi8tQgLC+vFFUvYA3OELK74lJj74//wNs9pQbASk?=
 =?us-ascii?Q?B8i8gCiw9EexxlUS4DvEMVHRqJLq4qi742HiTkh9qJKHSWr6PSrIV4uBZeFe?=
 =?us-ascii?Q?BW85We1QV010G6UWnhv8Jz1INN5ZyDdSpp6QUInM1//idBzLm1wbkEGdJMca?=
 =?us-ascii?Q?1O2L3ZrNY2ZGsSQXvB2Bj9g099ZPrx45E6juOchztE7pLpRfmDWUmCHFJVh/?=
 =?us-ascii?Q?43fLxrVKsq88SXy1+HKGlTWlDSwjLzzfToEsoSxLi7nRECxo9aLRtVL5yoBn?=
 =?us-ascii?Q?k5bzEQAHspXzwTR3OCRkHBUR21fSGiG1qGCCZ//Be8PxOvXTD2v9rn8d3JII?=
 =?us-ascii?Q?plbSaZ4CwzYOJ4BYhiEdKMre477N8nCX5BIWSXBKB1wEoXLJuQU5dCG7W++6?=
 =?us-ascii?Q?8AGf1t/u1nZ+b6JTpQwbxz1Z07K0M1vCrQbMcIIZcIhFtsxMGnMPSS5pYuY8?=
 =?us-ascii?Q?TQnso4MjmKNF5Rp3cPqPN3R1Cq7c6WWiGFw5iVkyQdaMEg9pjP9UAz66d4bF?=
 =?us-ascii?Q?FP3IH/2PH7H9Qj9dKN6uukQ94ZAe8V6ALmQStGiIl29EY7lb7qnYftrLRTu9?=
 =?us-ascii?Q?vf2lsu24DDU40aqcOVO8mBcOy2HJ1WEAHu89AnClD/RZ+NZPJ6EMjzJVggR6?=
 =?us-ascii?Q?KJZYiMbw22HXdgTSI6jyGsDD5JVd4232jlbQSxhlA/zj5MHCSQncEDZzjQhg?=
 =?us-ascii?Q?q9hKRdhzPoKpZxFLBxE1VGbEsRlfzmNojW/zmNcZL8nbd0VnEJiWKo09j6Ty?=
 =?us-ascii?Q?P2boUqFggiSS6OEc6rIJbeGrabnvklY63HtzObHwAT8qlFG010JVzz1fbbJP?=
 =?us-ascii?Q?KeZztPbNErfNOtl1SSGTqsE0T9NWy+K5BcwY2f4WCzqB7d9Pfnhbba66/A33?=
 =?us-ascii?Q?t3IpjVW7onobL/EXAlEOOfNc3NLZim99lrA97DmIPxQT6ZfGPjVfO4ks9kt2?=
 =?us-ascii?Q?E9aLuqpsrH5HU2CvTuI4po43mYQcX9SXBoDE7UG5O+P3w7cpl1lGohsRovYP?=
 =?us-ascii?Q?0q7mU72ijldbJ04KyuNqYCoGDqpjEhSA/sKgcpyRHtAg34ISxBdS5+q47FbQ?=
 =?us-ascii?Q?pjrPmOvPVOYTC1CFg8mcM5qA3Udkk2SehqfPhZlEY0TX7GPTnsTEKhkFUUTv?=
 =?us-ascii?Q?ydmtYE577sj9YqdGZ1J9ajZLbTSovAQcEWD2fGV6nItj01tpmCjYeF/oE7yX?=
 =?us-ascii?Q?rsHf8Dd1MK0foEg6xuNES54C?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Scby/7Sz5fQee4WBe4WizqVrCVGqQiwoXV8xmidfcJeUUht7pTUng0sLS2Dc?=
 =?us-ascii?Q?vF2hBB63yX4bfpo6NM8QncIzYh5gGYJ5Wd7lMJzLfem0I6NntUYCp6PA8/b+?=
 =?us-ascii?Q?RihmmAsITYv1ge8JzJlI3dz1CVm2aslo9KodDNa9FJ7YF+CqRuKXYh4QqF1e?=
 =?us-ascii?Q?QRfQLgVpaSevJo/i9qfA5bUmwwDulfT2LdQEhrRJxo6XV8uVfHqZ3vOgJ7lc?=
 =?us-ascii?Q?q71BU9yy1cJzY6kLVEMfw7tzbjobDGmAyc36OnNQm9muhNJiRICi5FjmynCC?=
 =?us-ascii?Q?KV18KgAMQPhSVtewglkeynVx7sAE6KAkyay0+aNHjk0uzQgvTvPzEU3xvdNf?=
 =?us-ascii?Q?U7nVbEy2rZja5VuHBYdmsPDYFq/4Q2m61tHzGycrchW18QhF2tJ2i3sx6x04?=
 =?us-ascii?Q?IWIczzIygcVmFDt7lvLzboX/Qmxcbluwqd0PYMcPh4GvHFxkt5k6CmcfTQbp?=
 =?us-ascii?Q?+n+UzSMKqI0o0HkSA/8ZlnKqBNbRSLmXR3oOnZNNuM8lTSV7kdrCIHVBE2qG?=
 =?us-ascii?Q?EjdEoHcnHwAYCVFSuYrSeq5jLv5ht8VUNCAenp2/kirHhSdGG/a5an+qcsX0?=
 =?us-ascii?Q?r57ax8EPYH0fkbVdAz46brpKWcI45hY1Y70mNLSjly4VysP0s/gbcYFlp7x2?=
 =?us-ascii?Q?K4EorJximc+21tRdao5jV1Q23pk7nuk7Q0/BOusib7ap9l+3xBaB1UeBVvLU?=
 =?us-ascii?Q?YM97RwHmiJ6yUvGTS4qd83pWHlEutapbPWfuMq1hkLbDymRiEa0y1M9ddMbL?=
 =?us-ascii?Q?YmWe+gEltd6GoC6/Z8NxOUzKjjNdUJ1gbrHNuAh3OtQ0Y9NHkBMM6bhurUyM?=
 =?us-ascii?Q?826Jkohc98Hl9oTFBGjXGgpj5S5sdlO+Mx4o85WjmpXZIm5avzgBqwTAClCb?=
 =?us-ascii?Q?332jiK8pIZ8Lb60xv5g45jC5PHwbhb2l9Ou2CmUwOX2dYETb3oMphSzL1teG?=
 =?us-ascii?Q?cHnx3tL7vMf3RdKFpn1AqinWdsIRgjycWoIYGy0LMWzcVfzfpRQ9fV4WcZ8/?=
 =?us-ascii?Q?EvRi68pnBmJblPi3XIvMmj/7YrdHv1oaflwkGEYnGbSf77bcQYKyZyN24DKJ?=
 =?us-ascii?Q?AYEQywZZS+m4pIXmSYOc1POOpVFF5wfchbxX+BBYzYWbdidSiaIfqoj/97XH?=
 =?us-ascii?Q?gsEBxny4XnkibVdKhX0/vck73faG//xmavFaO8Ml2JmHHoj57AjAJNXOx8kA?=
 =?us-ascii?Q?ovrrPclh5pNF3uKLE4sEfZdt8NHUeTe9ajQ1781vkPpnT5vu9i8XBeqpJvdF?=
 =?us-ascii?Q?XzMrndr5DLH3eANyWvxTjXbESD4egIDah6waKRRhI9l0DhGeVtrmjfqCPjKm?=
 =?us-ascii?Q?e8yHTbhK4n6ddckYT4eF7ZnyKYXWIUmvq/xzYp2HhkM4H341OZZ23ReYiuD5?=
 =?us-ascii?Q?puB/wBcfb86Yha6g1l9QE9fkPb1H5AaOf3WZYwc+yoFs0mn5uwKA6z+/WRcO?=
 =?us-ascii?Q?0xEi7UDFd0/IJnn00J7uVevP5PIWB6nSkPuBeT6UFNFTUFC+SuHcilG713/U?=
 =?us-ascii?Q?ST4TcwIqKy/B6LeB9EQQtE/GJUaVbfmv2I8u6EMCQGx07pmaV+MNHxYlEdsK?=
 =?us-ascii?Q?xvB2DkSkblUGai+BE98=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c41f84e8-e879-456a-483f-08dcf550f8fa
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 23:58:50.4352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0yns/n5rDkBZuPfbYgYdEYHQCXirYpzCE9BubsmyZq4ZJe25HLCR9rEZepaWDQKj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7659

On Fri, Oct 25, 2024 at 11:39:40AM -0700, Nicolin Chen wrote:

> > I will try to reproduce your failures.
> > What is your base commit?
> 
> I was using the for-next tree (rc1) from:
> git git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git
> 
> And it was failing, so I guess rc1 is missing something for memfd.
> So, it should be a false alarm.

Oh, that's exciting. So I will have to base it on a rc that works so
bisection works :\

Jason
