Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617AA2397BF
	for <iommu@lists.linux.dev>; Fri, 25 Jul 2025 19:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753470117; cv=fail; b=b1wQUoVKR0/8xvUlvXjku7Pxszdgh2aMc/GA5/sVymFWBufFf8u9I62Zt/Ni6jqB/G7IflqlA05sHz4mDzomjZPVa2IPpccidvCyJgbc39s6iF+DcA25fPCTeIDys22orkc/JQbMcLi6BRTM8LJk13gRSveYrCkgl31a77P+cZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753470117; c=relaxed/simple;
	bh=YUuZ7GAsjsMTeJWEHHQtg5+zXY0rIJBz69ge/dTtV+U=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6LOZBFJQAFlpuhNTvliTR489kJA4X6Gpb/6gtRVcMwixpXAskcA8buHah15cf3p1heKh/9gF4zO7Wf6d5YE9R3MWIFiNrZg26zE0MerWzkQuU5rTZHyik/jqbDLlTYt1IzMWJB+mERPY23K2v1zIY5LW1RnwydlB2rnpTzdfeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=evKnbe1Q; arc=fail smtp.client-ip=40.107.94.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="evKnbe1Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dud1aaV4tdvZrgjL/BPVVVKthCsh8DyO8Lsk/36EhtJRIzL8ySdr3PF5IeQzNusNz639SkxFFhmZYryGlzb0Ab8q1GHEn0y4Xh0k27RM2wGm9rtqvy+vlqrWJ1F+8GjZQdZWo5LcdqXFfjvou9uRW/0ImwsdFZ1qfnMLyi0BhNaUuRHRpz+tKdIQC/ec8ZS6QVCUoyIAOxZPmmU0G4Hpk0Ai1emhmDRohYimQeGHiCBfOolNw0gbRvAp7PM/VUbAi8Eoz9l2sYMOunMEFBDi97sQPfxfWAo80zY751vORDYi3lAIkkq3HWvxIZ6N5Z9HcTnkNBr8XXaduF12oXBS1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EAlaGzg9pR4wFhSSDNUIYM/LMo1Uo9g/S2AJCwAPYMo=;
 b=vl9YnmSWTlmJeox6+nJuZQKNKWMj8xdiAUKXD8EXC5u3OlGNYi0BuQTqbBntG/767yI1PT5NSMdJOpPf+CMXqZLMSRW8nzvWM4ClP075nT94QDBcSKJzQVlWKDQJxqMMh6zmdk/hn4YTGz3a4jayVTwLuHgew/S5YPyQcXKJUDZ6mPiZYuweUKO8UBHe4d5qaIOx0ZUmmF/cIdA2l5e+uh5yABusky11vmVD5KkB1YtUxzx/3OzHZ4NRnOz8QOrz/9OkcydKZqinbju0mF93c+Tzdj0UGyrut7mM9nTBnaTzJRpzQqwDOhWUDDjL2h3ZBCqbc6FqWol1teP9NgB1kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAlaGzg9pR4wFhSSDNUIYM/LMo1Uo9g/S2AJCwAPYMo=;
 b=evKnbe1QwTWrpk1MClCFkwxKLgjgEv7kos3hUbRbiPSK9ctZDvGfaB6uiml9wkWNGcbge89dEU+dQ9sxTF8qZRHmZWcBbJTx8RkXJdPhC7agJKMGtHsCgcPf6ByS7UfuvwEJdvP9enD7cD4Bon9y1HgBh31iJpbL4y/1OvLFAxIX3FqRxjQvi2UkrRhrFsXOxWEPDC9iEPso8Li658EVpFM8a0nm0n6+r5lGBDdygA3IQryHze/arX2BJ1n0qP5bxKMP0lS7KizmgRBe9xiHwRyG2mxIDLx0tKnUYPO9HQIK4YciNKKdxgcumsP8vW9VOsz33FOCPfoHl3IEvbLNQw==
Received: from SA1P222CA0107.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::28)
 by LV3PR12MB9439.namprd12.prod.outlook.com (2603:10b6:408:20e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Fri, 25 Jul
 2025 19:01:52 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:3c5:cafe::bf) by SA1P222CA0107.outlook.office365.com
 (2603:10b6:806:3c5::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.24 via Frontend Transport; Fri,
 25 Jul 2025 19:01:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 19:01:52 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 25 Jul
 2025 12:01:41 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 25 Jul 2025 12:01:41 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 25 Jul 2025 12:01:40 -0700
Date: Fri, 25 Jul 2025 12:01:39 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Mostafa Saleh <smostafa@google.com>
CC: Pranjal Shrivastava <praan@google.com>, <jgg@nvidia.com>,
	<will@kernel.org>, <joro@8bytes.org>, <robin.murphy@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iommu/arm-smmu-v3: Replace vsmmu_size/type with
 get_viommu_size
Message-ID: <aIPUkzn3ZdgbKRzG@Asurada-Nvidia>
References: <20250721200444.1740461-1-nicolinc@nvidia.com>
 <20250721200444.1740461-3-nicolinc@nvidia.com>
 <aIDlsUvF2Xbdelvx@google.com>
 <aIEkZoTOSlQ0nMKd@Asurada-Nvidia>
 <aIEwzM7mKUI8-h9U@google.com>
 <aIKd1owebUNQeN1-@google.com>
 <aIKqaGMMpsIuAVab@Asurada-Nvidia>
 <aINL66r_1NO3Nx-f@google.com>
 <aIOvt+atxTQp57R/@Asurada-Nvidia>
 <aIPI9xv-HxTPWMUp@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aIPI9xv-HxTPWMUp@google.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|LV3PR12MB9439:EE_
X-MS-Office365-Filtering-Correlation-Id: d4f8ed26-28de-4aaa-cf76-08ddcbadb774
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4UlmwsR+x11PyrNqbwqXyER+o0AHs8aIJDxRJqJYwze1AodKZGCmJZU3E1SJ?=
 =?us-ascii?Q?YxfzlLTdTU5jKNLWioOxBc3gEZMLGgd6Lmzm9cKqLErjgSEYJAAWqtg9Qr9e?=
 =?us-ascii?Q?tQQd7kJiASS5P8fym28xo+XiFXcUhOWe8tMGT3hgs/QYSK4Bd1aLxyBDSYpa?=
 =?us-ascii?Q?J0dR1XerSdPiK+0hBYgaepju38bxPWI2sPNBUKZshrHNJkLPsl85t/ePMQi7?=
 =?us-ascii?Q?gD/z45syLxBeZQCWOVyteaLvtddG9dJtiViM8ztfM5R5Bb4sdyz8LxaFU/Bq?=
 =?us-ascii?Q?cN7ycxC0BIEuF52nrl8b3pDw4zuk21aWejuynBqywNvjtnVW0rNjeEDPYvSV?=
 =?us-ascii?Q?o05LwfY+EdXhkKofaBboS97nwqom2Rew5LoywPsj9LlSuqFfq6wboOIBpMLJ?=
 =?us-ascii?Q?3QKuJ41ORkgGwOFyzypFBRTAAG291d9DIh4AgHmRzthtSpiEnFtpH1djfSKo?=
 =?us-ascii?Q?1uiJGY7j0R+kcGmsV9jd0YXT4mVmZovz9GgQ832V/8RHHwf2UTOyBtydI6Fa?=
 =?us-ascii?Q?q08eXeJO29hgp6Pe43Me0TI7nLG1tGQANRces6p9QKikHiueDLz0x3DICdt0?=
 =?us-ascii?Q?+zn/jPOUx6XClB09LsmXfWwipG2tFDj+wk6iA4ec6OrsEotsWGspxRnMMMDC?=
 =?us-ascii?Q?Mz5Fa8h5ep35lniTKrXwvRj1p9caFWtcaehJzPa0chgUgi/18BDHAEImn63j?=
 =?us-ascii?Q?U6/iBvc15jMQzPwqBfPZ5sDWVodHalJKuBWdHfGmVT088mQZHKsB0xtytrW4?=
 =?us-ascii?Q?XQ4bo4vA5ELT1tvMpEYtCKmECrKh50Lp9fsCz9tewMcKq/SK4cF0L+ZyYEYM?=
 =?us-ascii?Q?IiJnSJslILhjwIvYVcUfU61O8uNkO8YVExQq9sr207F4L07P9nR7aOSnmpLk?=
 =?us-ascii?Q?iJnOUu5RXE1fbmoe6B9pIdfj63UUUZzpLQWzgmP7nnrueW2oLH92vuz0mnCZ?=
 =?us-ascii?Q?AJMpp4SluzYNVy4+nNC4uXKou5JY1lC9oa6RqyUy8EVARAQ4oWzCpyQO2T3R?=
 =?us-ascii?Q?53z4k3Tvu+XapWkN1xycLhFAqkbN1F36/dtIFBnzCz3uWVc6+hzlW5ZLN/ZN?=
 =?us-ascii?Q?7xh7C0Jz6RMNuYILYjKV6BnoSwkxeClAxXz2VwOKFVJgX+5Eo/yO268yfBrR?=
 =?us-ascii?Q?vgd+GTD6nMQYRIM5yh2q628QRJRRih36qKTvkmsCGP5dRWkmn7xEfs5NFNCd?=
 =?us-ascii?Q?GhafpGAQxqWBaFPo1H/iMZMdnt4a1xcBynZ1whTkpeQUAO8i7pieLkmaRXu6?=
 =?us-ascii?Q?SqYRzeGteL+eA/zaIJlY7bAuRBOYIsAQzBO9fd3rtHU2omjpHHq//cQ/Cj1r?=
 =?us-ascii?Q?3aKpM7BB75aONMAJbDhe6O2DDvqbqu5dslSxrE/vE1I21T6CLvKNQF9BwULQ?=
 =?us-ascii?Q?gS7H6XGz7B4TAYIS0Vkp76DytA+NfpI0TgAKfCwkaS43erlA4VALbusOQ4Mg?=
 =?us-ascii?Q?8BkIN0kJbj+BLs+kndMJuL1FFypHGrLiW5AOfJJacXFQH8c7QWo65y5pkgk1?=
 =?us-ascii?Q?Ub9QLpijM243c8HOwFlTyN2TKYmsvgZULN57?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 19:01:52.2621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f8ed26-28de-4aaa-cf76-08ddcbadb774
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9439

On Fri, Jul 25, 2025 at 06:12:07PM +0000, Mostafa Saleh wrote:
> On Fri, Jul 25, 2025 at 09:24:23AM -0700, Nicolin Chen wrote:
> > On Fri, Jul 25, 2025 at 09:18:35AM +0000, Mostafa Saleh wrote:
> > > > > > > On Wed, Jul 23, 2025 at 01:37:53PM +0000, Pranjal Shrivastava wrote:
> > > > > > > > On Mon, Jul 21, 2025 at 01:04:44PM -0700, Nicolin Chen wrote:
> > > > > Had the
> > > > > vintf_size rejected it, we wouldn't be calling the init op.
> > > > 
> > > > A data corruption could happen any time, not related to the
> > > > init op. A concurrent buggy thread can overwrite the vIOMMU
> > > > object when a write access to its adjacent memory overflows.
> > > 
> > > Can you please elaborate on that, as memory corruption can happen
> > > any time event after the next check and there is no way to defend
> > > against that?
> > 
> > That narrative is under a condition (in the context) "when there
> > is a kernel bug corrupting data" :)
> > 
> > E.g. some new lines of code allocates a wrong size of memory and
> > writes above the size. If that memory is near this vIOMMU object
> > it might overwrite to this vIOMMU object that this function gets.
> > 
> > This certainly won't happen if everything is sane.
> 
> I see, but I don't think we should do anything about that, there are
> 100s of structs in the kernel, we can't add checks everywhere, and I
> don't see anything special about this path to add an assertion, this
> kind of defensive programming isn't really helpful. We just need to
> review any new code properly :)

It could help for debugging purpose when writing new lines of code.
Kernel has quite a lot of WARN_ONs fencing something that shouldn't
happen.

With that being said, I admit that this particular line is a bit of
overreacting. Removing it doesn't have too big impact, as something
else would likely crash when such a corruption does happen.

Nicolin
