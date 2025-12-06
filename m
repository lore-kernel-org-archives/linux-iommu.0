Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012054.outbound.protection.outlook.com [52.101.43.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151E51E86E
	for <iommu@lists.linux.dev>; Sat,  6 Dec 2025 19:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765050403; cv=fail; b=b0Nawmr7BKgeNDa9mqZ2VlG7KttxVOp/H0rnN950KcCm87sl5nbiaANjWnaeqyypzbIOk+fuS7mPtJm0iGvTr6d2fISztBdljNoSEtWWrUrnebvfPfu6/RTK6XyjeVyGGjnT5QJ8iVV8rTR4MtmnzNXluiNRqgzXJ46fwULCRyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765050403; c=relaxed/simple;
	bh=EuOq0XK9OhE5bLjiqIC3XCvtll8c853XkuaRXGC/XwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LVlRhG90ymCi8k4ZJL3KacnIBfBfkptgdRLqejU+tUSdRsfHimM7Z+kLcbTSj5la/NmojIG5pjnFIY4yD0vBjNfXheL9McbEWxQ7Z1/xScxqkM8ejYcaTwffSBsr32dxCcLdyN2EGxf2uFuNzmm1YziS90574XHQ+QogEE1HyrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TiuKBKso; arc=fail smtp.client-ip=52.101.43.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TiuKBKso"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HebbgWk8uqp3yEpElQAV/GHap2+X2bQHWIeWzTgAFJ+Li0rmmoccxv68QPI+xEvrn3akow8KZYkgGIUMu6WJGfuDP6rfKD9obwQMmCGjzcWXKQqwVqlfyLK9x6FlNqwMAgbGlfLoFmeYTpJU6+WjQZblAH5Wwudf0WqvUhYq3oUhrN+yHYxB/bMcJ1asq4g8hx2wT2a8wHbHqwoQ0h/C/l94canNX2Dn/mlvBK7fs78nkcM6Ai7/V/KN8ieNpXLZhG9+yON9UwdKPNFvZdw//UDB0xNYzMhh5Bw8EaUOXEGQyE8Rw6/z780q7LSD4819KL4jD8yRBGK0YamXGZ0l+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LO0pQjwOJloTbw99Jxz6qd0bDBgwf773CndLOGAt4s4=;
 b=UJHLUPvPJpQmqclFIGhrN5Be4fRTN5hIJIVuFU+jQnENStTWn6b723eSbdOdKDBDAAlBkq4MX43cHwtfOKWZ0TdfsP+K6Aj4+mKJQbZM4Hqh6Oavz4t3vsBmDXbwQtYW0UdcB0Zs2DX+g6D23HBoOobjGmtKgpOvn54KJ1afknCEqe8DpKs3VpZqF7WbtE1N5dY1IJl2VymRrpwnRG0kqOvKo3k++GhxVsAnGryyLB6+0/v5IkXJztDLoKECrpCoLj4GopkJH5/F/ONfBptM6CoXreIQDis5wLRnnxqPKAH8nHizMOixi2KmBZa7N13TKXUaGQEOAIB9QIbC3kRmxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LO0pQjwOJloTbw99Jxz6qd0bDBgwf773CndLOGAt4s4=;
 b=TiuKBKso2kdk3R3YFRwlkBA8eWNKWNQGhA+NC+8UCq9FdtzlpCafQvT5sJqTxoyVGxIaX1rsmxKkdIWXZ3ditLYUoRaMOeeRWh+8rZj3fELgeioCuHCSNbXtZryagIUOD+VUlXBBMAjgF7feFeqbnwVT5O+yjfjVa9s3WYGdD8zP6h4vYz30tXnqSmPAfO8cc4lTcqzgcz5Jh6fHwM+NjHgtfQj4s1iSGViPzEBV7Jmc45d7T/YuIBvjNogKklnWYllsUsjuw/0/LC7k2v0aH4YBHZEpWQaFRuezpFITgQTPDxZJKh4+sMitzyUodLrGzzjZCCP/dkiLO3ecfI8KrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by CY8PR12MB7659.namprd12.prod.outlook.com (2603:10b6:930:9f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.13; Sat, 6 Dec
 2025 19:46:38 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9388.012; Sat, 6 Dec 2025
 19:46:37 +0000
Date: Sat, 6 Dec 2025 15:46:37 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, skolothumtho@nvidia.com,
	praan@google.com
Subject: Re: [PATCH rc v1 3/4] iommu/arm-smmu-v3: Ignore STE EATS when
 computing the update sequence
Message-ID: <20251206194637.GH1219718@nvidia.com>
References: <cover.1764982046.git.nicolinc@nvidia.com>
 <db1450e7a5989e51756a7ec3285d70ee90bae24f.1764982046.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db1450e7a5989e51756a7ec3285d70ee90bae24f.1764982046.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL0PR01CA0017.prod.exchangelabs.com (2603:10b6:208:71::30)
 To MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|CY8PR12MB7659:EE_
X-MS-Office365-Filtering-Correlation-Id: 786dd8a1-9bc6-4efb-7933-08de35002b56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YdWoTEIpdPVD18z0Si1qIdQNqv74JN/5k/TIw9Bdlo70dCfAULgHHiJ03pNf?=
 =?us-ascii?Q?eFR0Yw75KK3GfDDlq+s1qi+4hohvual8r7HGpVFnbVPJWq+j1w8ZSVgieTtv?=
 =?us-ascii?Q?lP5l479imWvXDtQqH+K/HZIABVK49gQ48V8//MMPaoR9t2+DSjAKystne2EB?=
 =?us-ascii?Q?cItUtxgpHRllNEW/CHm1v6z0HOA93Gk3MTHecksX/alQpy3/jpt6sBhwnxzP?=
 =?us-ascii?Q?HT3jJ1Q5M7s4QmcFCJFGlWWhoXjCffmAUJgFpNHdSQWU5uAtqUz6s7kD6Syu?=
 =?us-ascii?Q?jP4sbeWhE42J7NJaicXsbXVeM/rwS2RWo/qiLOXJ6qaCqx/LMWZoCdZtF1mv?=
 =?us-ascii?Q?/IESrQSzAYFJLWZweXMQlDbysGApNW0ZgPbTq4x4sZEVtLk5rw8/MsXs0IaA?=
 =?us-ascii?Q?M2LsDaHy73Zl5pwPaQuVCBqeCPPpUnKFnK0JOF+8Jtvro1y7/ic7diny085+?=
 =?us-ascii?Q?ijyhushknSaTF74aPOZ2Iiyyo1n6b/VdWPMFsp+ag36eaIm2GIr6B9Ui4u0B?=
 =?us-ascii?Q?84Ouvv7aYSo+Yo3fvfnNGlrP1eO1VnW778DOOx5GqKv2yj0Ds10cb+TrRGNw?=
 =?us-ascii?Q?NbyF9+ZSyn+7SDyttszNhq6gFoWfN7CWFDPdl/GapzYqKvis7JQdiEul1N51?=
 =?us-ascii?Q?hA2Dstd4nVcak6elXnmlIfZNvzq4oUMxzuPK5wjpCLeyvTVfQocqlNhhsgUv?=
 =?us-ascii?Q?MVmhbe2fhsg9D8UphuMCAQf4LJrSuard198Bfh0z+tyY3xwLPH34tRKZvNlj?=
 =?us-ascii?Q?uIgiIBD7i/+W7GGHRdqA+/zJNsRrko4dWfh55z56b7vTCtiVlJi7o2Dbnldz?=
 =?us-ascii?Q?qWXHuMn4azNJ8TYSWDoUKKp9grV0C1hk4Oc806BFut8uEf5Flv5BDh6W3OAJ?=
 =?us-ascii?Q?kmEvC9SlDOI0S2mqFCThGj5VCXcqIw2PqjAkIG6TmHfgJajbS65c85ZaGJwg?=
 =?us-ascii?Q?y7FldkiSGORzV+NQvJL37qSnmgJwswZ+1TPOIubKjr7i6Pdd9rtwu2hVpBzO?=
 =?us-ascii?Q?a6n3VYh9HbQG/c8eatmhvXTsk1WYEKrxDHM62+HVTpB4uMGbZ7jzt4ShH0z4?=
 =?us-ascii?Q?Fz71YRbIsLCNyA/n6hAN5hQ+zGlxdmOaHDbG1c0HO+NE3MrfhN0nkDvBpMns?=
 =?us-ascii?Q?T4tN/buZUiVWEe39EPVK6aZ8NcBl5LfXSOmb+o8AxZ/GarP0xoqZz7GYJkNU?=
 =?us-ascii?Q?TVOd+96GXm6Fyj8Y5hvhHjnnScIaLzamckk0PIfXriYNxK39cJSqrBG9B4c9?=
 =?us-ascii?Q?KLikknnQG/OISadWDSNPvRgLtSpEuIgjGJMblJJQgTybJMGuPNNO+LJ5i0YG?=
 =?us-ascii?Q?W1oBmFS6/gASLBXNuigtpybbECwxxUNpEU47vzELXW0tpKhQHZaYm+4/FhcL?=
 =?us-ascii?Q?wA7uI48engH+yffMxUA7Pr10AB2IkFUAvniJxrPu5GGo52b+zsWo7dAYEBMi?=
 =?us-ascii?Q?4No4XMCYFODHZ87W+4wg1Ptw2y6I6JnO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A558E3eO+/IJ7vfm9PJyh62jDpXdXcUZpw6+rZwu6stZX4eFC+idTTBJs0KQ?=
 =?us-ascii?Q?kenbunnYgIOQxtBMWYm6m+h/qJMC1Jgbo9tGvm0yPFLNrf05X+wqG586MQOh?=
 =?us-ascii?Q?RJi4f8XAwsWuEKpTc8BcCRatEs/Fa+dgVv4OvVK673axglDrbqr0PEBFk2yc?=
 =?us-ascii?Q?sYqPWNlk/WwVpztQTPmrKUcWIELHaX8mFQ+wEiwuStQ9t+XRF0H4HEPt5A2l?=
 =?us-ascii?Q?hzJxceaFFGE0rSZtyBXN61F5z5tTJpLJkliM1mc2s3FxEBuwnjXjLfSlkmAk?=
 =?us-ascii?Q?HSmkqoMU6KXwvRvnDbNcdnDZOU6X7uYGp7T8sEKkyBARxa/2fmrCE/yJ6KeM?=
 =?us-ascii?Q?BBasdlqQfNxGNk/LUcC8npntPrSVJTTzvWscvogrqANypcs26u/gX4ni6cTs?=
 =?us-ascii?Q?3Fk1ywhY3Kem97mfLbGTpAHKhHsl+6mD6Z4FFsKyjPFoQj8Voy+GBWDLIt1L?=
 =?us-ascii?Q?ZyePIfEfeTwpv0yWA7zZKorz5eQwjAmZsavLLAMxnFjFCoaVMDF9pj6y2kAl?=
 =?us-ascii?Q?lgJu4ALJdsPKxXPFYDKw4RnTzmSRXGHttuhoqrHW6dr6Z7TiyoJ2w12n+FgI?=
 =?us-ascii?Q?7eIsa0p6w5Epz5hNoC25WFshcCvyq+p03BIkLVr5IU7UbmajNO0M6+Rp9iXZ?=
 =?us-ascii?Q?FRJFgsiXFmb5yquiK2h3ThRHNqeqjCbTcl4YZnUbhlD2egprc0IKBGceqUB8?=
 =?us-ascii?Q?dRzEE5ZamrOBF878WEC2yF9+S1BQ7sISJF/FEWOxTdobnl8ZQFESr2bV/57w?=
 =?us-ascii?Q?Oh/ZH45GDtrQY3G2GqRp3mZIYLnyhCqkNfl60pSGbgpHtBWc0tN3nmfTA0DG?=
 =?us-ascii?Q?O5/oyRi2rhFE2WWswKYaIrxEuIEWCb6ekBNcPLfHwF355jt3UxuHnxISfY65?=
 =?us-ascii?Q?hNsuDKpeX5jG7CKOLjrLc1exVhRTYRbiIAN6PrvxKf7WKVUmeOix6Qmk79Fi?=
 =?us-ascii?Q?tbNhdZhWQJ6YOnBWDYHLgl4NZV+rGuHEc/6aPol6/s1FpEVrWXFJMxPMl9S9?=
 =?us-ascii?Q?rSvvPVHH9JrqdrdWIRBUsJZfQRRrMy/yJ6jMNsHXQHlSS/IbvSzPZKUGWo4o?=
 =?us-ascii?Q?D5Yk7pK8/p4gvQdM4qPYtgum+y0kwXUzWoe7B+k8EF2hbqsrCIQItHsOjiny?=
 =?us-ascii?Q?aggBsNKsEZTrws/tafvm9enzKP1F9YhipqQwb7AUG1UHc7YXqUehXsfIQDiq?=
 =?us-ascii?Q?PrT7TW10Rave7l/X/WFhlJvBMqbXo8imRKMG8yOpuUQpMLylbuGyYYWj7IKH?=
 =?us-ascii?Q?vhvohX+NO5QeDHRHmw/5blXdRdDAgUuKa2mbSHCOiOSbMm9dZf+8YBmnY/EK?=
 =?us-ascii?Q?r5XX+22vgR/CrlL2jZdXtHVWUlSaEErMhqfJGcE2UhwjCFvc0Zj5NUogScsf?=
 =?us-ascii?Q?pMJb9XE5dkXVTdNU1lpd9y0pvJwplZ1UJZ+4gWvNcUXGofOUtLj/fpBkCRdF?=
 =?us-ascii?Q?lAFmNps5qTKfznwAkYcunKYfBoX7RcCSjY4JbdK8yTRG8j6Aw+s9vIFvIkmc?=
 =?us-ascii?Q?GPLa4zqOHHhW75EWCS39gqgYDc/3ZHzJRX9ci1A4GegTyPlQofbHziPtM6Gc?=
 =?us-ascii?Q?4lK0iBkZAuSOzn7J8iU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 786dd8a1-9bc6-4efb-7933-08de35002b56
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2025 19:46:37.7807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c2LcPubMJASq/YfP7tIcWt0t553bwPgMRbMtwzdodZF9koKQO6vZ+c4wX0+9E6QG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7659

On Fri, Dec 05, 2025 at 04:52:02PM -0800, Nicolin Chen wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> If a VM want to toggle EATS off the hypervisor will see EATS change to 0
> and insert a V=0 breaking update into the STE even though the VM did not
> ask for that.

"EATS off at the same time as changing CFG"

In bare metal EATS is ignored by CFG=ABORT/BYPASS which is why this
doesn't cause a problem until we have nested where CFG is always a
variation of S2 trans that does use EATS.

Jason
