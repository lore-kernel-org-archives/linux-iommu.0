Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012047.outbound.protection.outlook.com [40.107.200.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5B62E8DEB
	for <iommu@lists.linux.dev>; Thu,  9 Oct 2025 14:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760020580; cv=fail; b=CYyM0BFoaQuCmmQLaBpohC2M3iIRkOEKHJ4CIYmfj/K2c129gdZmylT+C70cwrfP4XDOhaHuc8yZnZ1xrPSl6yWphdtotQoX7yqj8D91W/gZnpgucoWOkWTinboUPSMhSfWBUkUzD0UdeiCoVGmyoDJF5aDkLt+g/DJbJB8uGs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760020580; c=relaxed/simple;
	bh=Hg9cbig1svXVo2cboFo8j7fFzxKB6mKVV2wzmdY20RM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QmnBFWzboYX2HPlZTiSgivr4a6FsNa8mR9BzkTh2c5fwQORmpSq2dc49gNKAu0yXGUZ63scremm3jDmDywDe68WSrvAmt63YaKOhobNZX6dufN9HBGycXVSbP3a1DyeAEBHvvntIeHyCKq6WcmjXdCrXdxL6upyQaD4pz0umwUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YXjV3hEJ; arc=fail smtp.client-ip=40.107.200.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YXjV3hEJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KlcGB7oubO0myQFnNzhqwff7p3QDZv5X6MCadTjGUsQ2TfLvD3UDeEXy9wignGEBqsLpHaj/Yh66+HLBSJfxJAXyY1gomV7It7Lie/4aF65yAdmCQ28hCACLVFWbZf7qhpAYlCci2WYhVOMsO7iH/QFv2Xp/pXZCcXZ7WtKBFPBJCmw5itHQKv/QLekIh2iLa4ZAUupN5Jrr3isk4xT4bUFxiAT3QyhES616SXOos81jMPKoySNOCmaQa7vb2EWjehRpWc+W16Rly+XBebperZUWSYgrBDNHpi7ZZdkt4LX2uvEjtorcBuLcdtnn09BZNEf/tGZneeTU/lmCOFIdVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hg9cbig1svXVo2cboFo8j7fFzxKB6mKVV2wzmdY20RM=;
 b=SswhuIGIc3QiAXaLRJswLctY0m1yOqHbwkAGMGay9/uORMlXnnRpeJqGPFxYI74WfEQMGeBzaOa9V8Lvp/sXwNU5vIRa1d2Bw+rogT33YABLjr/OKF/8knUOO370ScVxavBwspqapumR8CvIbOL4eqc7f2qopDres8BIBNnDH9hJ68nfxpWJ3mvqXTEEhBlk7myxc/PujNun+2Qi9bEMDxkt4P/demYPPgqn3OSmtFWb4K2Z9boFqluWCX7PHZgPshMnh9pQpK2czex/j75Mc0Ja/NIqW6yOtiG/UD6r9Bl5BMJ5madoDFXZer4+lBhDeKtK4VzTtctf0RgTl1uYzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hg9cbig1svXVo2cboFo8j7fFzxKB6mKVV2wzmdY20RM=;
 b=YXjV3hEJxTsaVkyQ+sVXQvtQ7bePditGLxeN+T3LwcjkHjhcntT3RTxSFf3FjXsS6tMe9Y3xbfefXtOF946TRFLXvUdmm+z4eog5l0S3SZUPiYLRRfvVcHCOlvlqjnLgW5xDqVFirhidI2+TFuGK+6isGn1eRDH9PSw0yZl92qpSTLfir3Bf8NKlfIwwr96yCB2YhD0dkJ/DS2t4AY8cBu0JqhFCO+Enas3zJ1IpWGcHBabJkzuKFVo5KxPpBRaSWa7tBxdMAg5dAEX8+Nau8vNHQxEUJ2xDwIS6IqsKryg1lg80ou1tSgJHFf8OXu/tPQ0fpVSKYkUFEPTB34kgAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by MW5PR12MB5682.namprd12.prod.outlook.com (2603:10b6:303:19f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 14:36:00 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9203.009; Thu, 9 Oct 2025
 14:36:00 +0000
Date: Thu, 9 Oct 2025 11:35:58 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>,
	nicolinc@nvidia.com, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, will@kernel.org, joro@8bytes.org,
	kevin.tian@intel.com, jsnitsel@redhat.com, vasant.hegde@amd.com,
	iommu@lists.linux.dev, santosh.shukla@amd.com,
	sairaj.arunkodilkar@amd.com, jon.grimm@amd.com,
	prashanthpra@google.com, wvw@google.com, wnliu@google.com,
	gptran@google.com, kpsingh@google.com, joao.m.martins@oracle.com,
	alejandro.j.jimenez@oracle.com
Subject: Re: [PATCH v2 11/12] iommu/amd: Add support for nested domain
 attach/detach
Message-ID: <20251009143558.GC3839422@nvidia.com>
References: <20251001060954.5030-1-suravee.suthikulpanit@amd.com>
 <20251001060954.5030-12-suravee.suthikulpanit@amd.com>
 <20251006145900.GT3360665@nvidia.com>
 <3e27de73-61a1-4977-b0a1-629ffaa81032@amd.com>
 <20251007234313.GE3474167@nvidia.com>
 <32d2a380-ec66-4087-83f6-339f22745889@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32d2a380-ec66-4087-83f6-339f22745889@amd.com>
X-ClientProxiedBy: BY3PR05CA0047.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::22) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|MW5PR12MB5682:EE_
X-MS-Office365-Filtering-Correlation-Id: 73ba0bc0-d511-43dc-b59c-08de07412ab4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6bIS3++dlTCzrLy+JEdtH7vN82ubU+vkDC7F1sJILm1k3xSO38fonFaQcRM8?=
 =?us-ascii?Q?Isfu8SaU7MT00UdUe1L2a54wrLbno/iq0y+U6wpEWnLoJnhqRDdTV4bzLt5h?=
 =?us-ascii?Q?P+qr0y5HxYCPnPKIVH6p43Vw0zDpu4jQFLYbqEYETFL7Iidn+fiPyYi1nSiQ?=
 =?us-ascii?Q?oAN6gicJFprSw/hn7CO6zYkjrlWsa/bQX69HNBeCTGDDxA4o8NDsYxTH4sZR?=
 =?us-ascii?Q?BEyRCNt3Ijwbv2TNBM8MEsuDO75IIEJ1GJI52QS+PmF3gm1nsrD+xcdCs2BF?=
 =?us-ascii?Q?u9ylS2VdmglVzxO3KP/3kv+xyHdo9bwEcyYYnhSI3aySe4ZIXXte1Fd5f97H?=
 =?us-ascii?Q?09rA56oUWXsDfJCxo6vTz/pwdzm4lbE7EZCnRVaAgg4r1NeoMJWBsFDhYdHQ?=
 =?us-ascii?Q?sCcoUmSvXDe6x5dx2sVYBVScXsWJwCxsyPY9zT129v6kYkQI/59SRwzcOLEe?=
 =?us-ascii?Q?VP7kdyNmhnlfYgp4r9cd3p5/o+H5QZzjt5OAqHaN0xoZbvfsA+YMbCvazzWC?=
 =?us-ascii?Q?gOOmTh1P7fC83bi7j9BvM6dnA858nIlCtvVzzUoiY0X3YM3eNSUbJiINORk9?=
 =?us-ascii?Q?B0PjukwrMajiO8kywfsJ51KCW6H2IHpLbjuZQeF57g3q/Gk96KaS0D+k1t9e?=
 =?us-ascii?Q?utbCeKQw/H9LSRMN70L0De3Rqw535z3N5l3x44H0LhcYl1f7vr96JQIhE93S?=
 =?us-ascii?Q?LaC1ajKwORQZrxZXtd+y/77pCM+ftOIQPC/LVZm3L2JCKLNUgtc16Q48R1vN?=
 =?us-ascii?Q?KjIcNyU0gF9mYArbsuv5YvcvgJzutKh2kHH0+yU/cV59Foa0lS0BZDAcf6Uo?=
 =?us-ascii?Q?xgjIU3tT5SJB9t9PT4bIg5JTsuLZQyDfY9/5SL4hm0PoYVadMR15Yj6Aku61?=
 =?us-ascii?Q?VcJCtBPCtqr5n0wNhZjj9d8yJZfZx3mstpMUJVWuVE1AK4dAt4cdLslYJ1Ye?=
 =?us-ascii?Q?1KvP/LIe8hZ6UvfPjdaB51zk+AD7Tp5QEhbnrpc/GVyJ+P3M65ssBiHQa265?=
 =?us-ascii?Q?DMrwSyHHOFWT5Ji49HBeIkuKL/9m876t4c6iN7c2hXBTjJaf2q7KD9937uuU?=
 =?us-ascii?Q?xglGuPTPUTcefLldho/H7zjJsrulRiE3rzhF0hS1pQ9/Wpo/ejMssrDG2cnA?=
 =?us-ascii?Q?mM5cJ52kx/s2IUDcimnlXdgXMATlsieRAhjtfZzxN8GDFE1t/FfVqAbLvqjc?=
 =?us-ascii?Q?tOIRKVIDFAZgUhEta+eXSk+QqE6xH/eUCJzxn8bms9JqWjtQLSEVakzKHE0T?=
 =?us-ascii?Q?+R9apcp2leuEdxKBV8I6UNVpM77tUPdxwA41VxoRY5+i0WZvl+bacLd5sGDi?=
 =?us-ascii?Q?SNjNbxC1x9C9QaDkmUqFmcnV/DD/ic7brXYSK7IP+1/1BZz1jYDr3SGGGNUP?=
 =?us-ascii?Q?lo0weWWcuhJGsqcLLYWGGZ91iQLFey//viqnx02VepbDudJB4uoT67/36qL2?=
 =?us-ascii?Q?lQ+WmMfYdQ4lztJoCEqqz0lTL5htIGjj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ycrkOBe6YTKicsOffwXqOznWjsrFcF/Msr4IXAuZzWbvzuhCqoRoIwDjNJfr?=
 =?us-ascii?Q?dPOV8O++0G7d6xvaoX1a91V/uj0VTRI/ssLcYV+bSziHUcFDn69ZTek8JF6R?=
 =?us-ascii?Q?WzOLXcjCzdyPzrCKGaP47ANsYorBeC4VBSuEKej+7Z5Y2As70QvbT2ZORp8G?=
 =?us-ascii?Q?xSbeplD/HVURbdIolMAS5pcSsbP7J2iu1hTcWUa8VzaNRsgQs1O1eRpU+aGL?=
 =?us-ascii?Q?w3RhZC34bRRITv6WdaHmEcjyojT77OJUM5Jg4l+7HQZ/5dkSUykUN2ZwpKTw?=
 =?us-ascii?Q?Epgx1NppMqmuPXn/XCMz708Ijh9HAhyluyBomKWC50Lx5dxnhUc+t+FeK7mP?=
 =?us-ascii?Q?g1XwN9YeTZW8icKJcbWyJlv9EOIJWnpQX1f0rHRpL67jd3y/JNB7UC/KXrnE?=
 =?us-ascii?Q?VucYZPx9NE69CMfosBcgCMQYKscqaAwmfmtsMCDK7vFsFh4bT2bLL+byqQPz?=
 =?us-ascii?Q?PKxLQsjbaRKLqApl+oxam1f9nmXnjQ6IWCoi7CQ0egMywMCBhMwbAxlkwkQP?=
 =?us-ascii?Q?eF6JT4fr0g/r6jwGXAKSKwiqKVkhUcL+SKClc/P/J+8sjbd5Zdcbcg7ne3Gs?=
 =?us-ascii?Q?Ue9xRljL6ZnEyX2QGxIA4iV+k+lqLqJW577h7hkZHvkwEz54gS34PXdSvOEJ?=
 =?us-ascii?Q?b2Guz83MaYGxlkfhimRai0uDjJN4fTlaJX/Pa9jNwONYBIPQvHxnk0MrjgkZ?=
 =?us-ascii?Q?IlnZLo+oQz6flxlS4qtxHone7KKYSOC6gbhoNMU0jBvY4rqC4Tmr+Skz0VpI?=
 =?us-ascii?Q?la+ijNJfKpT5O4ASQEgwos+fb7m0vkJxcoY7bovQBiC5tvpaMEC9mcaiDKxW?=
 =?us-ascii?Q?HLzPELt+hZAZZcX/CJWtNhOHt4zAGFlNl6e1WZ6f5CaZ1w9Ro+GnjNGtaRZZ?=
 =?us-ascii?Q?//euWnjGPVyu8xNpCBEnyfhGQnulpKpNIK6pBRPabN0eRc5bZErrWgljZGtH?=
 =?us-ascii?Q?Dq/NA6sDrYO2rqJaI9r4zuNuX1X5/y8P700gQ+QjgqlL/GcXdK+7Cmjinc66?=
 =?us-ascii?Q?7kmnGideV5fGgrd+yviwSUWNs7LXUUghu+7OYU+FdiPrvZQS4SpI9j1tLv8/?=
 =?us-ascii?Q?g/V28G/qNHeYN7aBC3vEWIbq+dngVXIsGH5J5G0qY7GPyXYjJgDxVcIqmRpP?=
 =?us-ascii?Q?+D1XMxhcffqcTQS1xcCyDvpoqCNZZU2bMyEO46h+Hcak+Aoemj0eCYOT96nt?=
 =?us-ascii?Q?Vx2sr/YmhEjKQDQoy77CT606ImjWphQQDLv3wkn4tO/X5tcCrejb1t292bXH?=
 =?us-ascii?Q?pt9o7Voh5va+zUUnVLi9mVtXbzhjwI4dqYePw4JBim202cxGol+WntaTY69o?=
 =?us-ascii?Q?xvLWNMb4j7znXWo2yiD+4ZUyZ8r0hpnx7Zgu7LzxhuSJxgNm179OWeH+ivUP?=
 =?us-ascii?Q?0XFCFNzAepAvb8Vm/5ZrWWj5hU0VgSqcDVIfTYrCjRSheniYOFUSEawT7dyo?=
 =?us-ascii?Q?6ciQw0HnFlpWSJoWqggGe7H6qbh3Iz6txqqkWI0w0YXvIfECl0+5NH4q3Nrx?=
 =?us-ascii?Q?PYEvBHRniEE0ZTsthqFEHZc5V+UvSmM+X0Hzg6+gkuDPDlE8DWP4ZExQaell?=
 =?us-ascii?Q?VYbKogmGvG6nDZzdSiOEVcWhzSsfU0rcRF2UtLxu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ba0bc0-d511-43dc-b59c-08de07412ab4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 14:36:00.5483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cqv43xoWKnxynKrOQb7FQf9EvLgJwwEFXFGSzX21B7p5/w8JrMRUGn0AXo3RDlR6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5682

On Thu, Oct 09, 2025 at 12:48:27PM +0530, Sairaj Kodilkar wrote:
> > > Here, we just select only what we needed for configuring guest page table
> > > specifically to be programmed onto the host DTE.
> > Everything you don't pick up should be checked to be 0. VMM needs to
> > filter out unsuopported things or generate a bad DTE error.
> An alternative can be to introduce a struct which only contains relevant
> fields.

We don't want this as a uAPI, use the normal DTE and have the kernel
check the things it currently support. Future kernels can support new
things through the same ABI.

VMM is reponsible to 0 out things the kernel shouldn't see or it
handles on its own.

Jason
