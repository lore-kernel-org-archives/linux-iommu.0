Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010051.outbound.protection.outlook.com [40.93.198.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459893009C1
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 03:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769483694; cv=fail; b=J5q08Omg8C6y9ATrs3K3Yw/1e5E5LR+wY7fUTyRyb/2nHmyUPisQLPrkFj0Bdlwh43g+F8Vh9s2h4U7sPz8tB/Ng+yKmeHbdQZR2SPFmudAyRNlpWti1AHjXpKFtzeuDdpBJ5yulAVdYSkj03yghEEyElL+iwLz+ezlNorRwsUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769483694; c=relaxed/simple;
	bh=D8wjMbGyNL1w+JF3dnN2FYZIpb6irshtLUzEqIZB9AI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WbV9nZWCLGYKDJtzIhk8Z6+2tsx2O7RVNhkaZ+eAIx0df4ceakxXWj61GqdXxIrqFS+sG1qZ68i7r23fhS8BR5/p8ogweg7cR1rR+ewPHTuj0OmQYAEM0PBwpJOrh5JP2BOJDhPWRxSykJiRg+91GX6g21Ca/c20686g+c+CYUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LzAzEIvW; arc=fail smtp.client-ip=40.93.198.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LzAzEIvW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I2lywwTpUaGNWW0CBS3QKB1aSpxLWIBjyGVHT0KRyti3IOzNWwvjrWY9DrRzdHnvnKPw6vOsk2IZekntmeHw+v/udv18e1G5soRAIahKUxqsKfxe4hZIXVscMv1/RSYZzF9d9tMP8DAtrbeFsGh6pTkGBcO/XX9uuXQWVC3OLhSSR3f44VbZen3p59oxghheiVLvp/8B5dm9TC+EYCWEurhuM18k0v+vk/mK+0vORWWGoDuQoIzwGfb0GTJwkB3i8WSqloDspYS4/+MKUzYCOpiT7K0zeMTV3tASQV3oovdljvTnHMCOsXZ7QRHZqCFhL630P8QGPtT/0I5Cx+l+uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZ62ZsMVfvb35FaLHuQZV9l5LCuo+TStRZygK9h/Vu0=;
 b=gXsO7/16nV+Dsq/s82Duqjkt8oCcrgZB7rJglD1wZX1eZ4qMlfQ85w8raVQFCWEdyqpbWWVfoPxk7H/EdzS5rQNv3+q+qzB4CyBSmA5XpsQHsIyKTXD4fmKK2h8oH4V7uWjPDyXMTg99IETXCWSEnlQpNJUuUZP7Gmlb4nZ51SGDcGmLxzGikefuunG4yeYWWLDM0a6GZeoezQc2nT7u2eCPEgpdp8zImMOeM9KhKhgvBcjdYD/elKJLkZb++nyiwp9cyFEt/crTe6qv+nVi9+PhYGZK1PQ/wk6z2Q1XUG0pdzMAzjef1qdpcEJs3XglbIK6J9YR6O3/4kYydCub4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZ62ZsMVfvb35FaLHuQZV9l5LCuo+TStRZygK9h/Vu0=;
 b=LzAzEIvW8m/ptL2gBwVD2kMqAhtDw9Fg6RQk0YWyLlSR9yu5kCYX3LtoSHuOstjzvQSITYkSpicSIukQxVRH6T95m2+Inl8x6wfKk7zDyyvOJ9RU860qpcfFDAQlzpDg34OtLO7WqCDI5GzW4J4imcoDvnN14uhTB3vJqfM8g0s1h0bSoZq4I3657+hTJTyJesx69GYXzSUL0GAc9jn5iXLSyDsn8tMpzyD+CIupG5Tsn3yT6QJj+lgoAxkqnR50khG2fulVH9A5YFT3S3kJCV+rrPrQPM9AidfFNr6IJUTSLQB3XXxjkVYjLq+oTN40lfUJteIw1L52i+031DyRbA==
Received: from SA0PR11CA0068.namprd11.prod.outlook.com (2603:10b6:806:d2::13)
 by DS0PR12MB7827.namprd12.prod.outlook.com (2603:10b6:8:146::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 03:14:48 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:d2:cafe::96) by SA0PR11CA0068.outlook.office365.com
 (2603:10b6:806:d2::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Tue,
 27 Jan 2026 03:14:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 03:14:48 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 19:14:36 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 26 Jan 2026 19:14:35 -0800
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 26 Jan 2026 19:14:35 -0800
Date: Mon, 26 Jan 2026 19:14:33 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: Jason Gunthorpe <jgg@nvidia.com>, <jean-philippe@linaro.org>,
	<robin.murphy@arm.com>, <joro@8bytes.org>, <balbirs@nvidia.com>,
	<miko.lenczewski@arm.com>, <peterz@infradead.org>, <kevin.tian@intel.com>,
	<praan@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 6/7] iommu/arm-smmu-v3: Add arm_smmu_invs based
 arm_smmu_domain_inv_range()
Message-ID: <aXgtmVXUBQuwCR7A@Asurada-Nvidia>
References: <cover.1766174731.git.nicolinc@nvidia.com>
 <06999367d001283744fd98eb7c1823afd516ce84.1766174731.git.nicolinc@nvidia.com>
 <aXOqVcX9YEC-Ikdt@willie-the-truck>
 <aXOrnMLLzZL9BtRT@willie-the-truck>
 <20260123200327.GF1134360@nvidia.com>
 <aXdlnLLFUBwjT0V5@willie-the-truck>
 <20260126152019.GK1134360@nvidia.com>
 <aXeQC3GjUgafuOi-@willie-the-truck>
 <20260126160940.GM1134360@nvidia.com>
 <aXe44sLQ3yUYiS9H@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aXe44sLQ3yUYiS9H@willie-the-truck>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|DS0PR12MB7827:EE_
X-MS-Office365-Filtering-Correlation-Id: d1713cb2-9e87-4e09-40f1-08de5d523a9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700013|376014|3613699012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pyWfzPaeg1/VnOxwIE3jW/Xj0gCI5NVSBmU1rpSu1PvbOeufs83yODyCD2JA?=
 =?us-ascii?Q?V6qFbUB/nPB/Er0xwMSoM6TYeRaOgrQb+cV/FcHajnZujAcSHggXwCGWNR4M?=
 =?us-ascii?Q?c0sh6NCZjeSdmHl2K55QW5gp1VqVZ0dBJIDy2aX+5wdvlr0bCMqWtj2GaC7u?=
 =?us-ascii?Q?g0F6tDQc3CgKu4uuvOVMQKG6idBwCdqkuaD5kZ7xUnYslhu0VPWc+JoM73M+?=
 =?us-ascii?Q?SlkhJum5WGQRvSzzASwm/ApoyYjaFqoiXU9fet5x/sYYxbjnDb2UWlVQ6fMb?=
 =?us-ascii?Q?SqqwR8bCgXOh3CQAl83XWrLyFhH8qsMHv6jeGAUlTu/KkA8RTkAvzHiLaUo4?=
 =?us-ascii?Q?jrG+He3ESnk8DcIyg59AQJaWuHqW8YbgP6GKn4aar9mpC87F88CAMQCCzVtM?=
 =?us-ascii?Q?bn76kFAqAePcF1KZmnOgfj92TdrULDARm+79rfgiaaL9fatXlJNrDkUMNVwi?=
 =?us-ascii?Q?tF8atdHWgseUJ4LXwm2Dxt4cOnbPGnlo3XIZBuWlc8inF1MXDd/mO256jkFE?=
 =?us-ascii?Q?8Q4MfZVeYRbS2wC9WmFOOpRth1kPv5KWtHl9dNS4jBo2LAespIze9J1nP5l4?=
 =?us-ascii?Q?rOamgZzOtbdssIykbr7RToc4AJc9CYy87SJwp6vPeOYDyfB7YMsvwAWAUQD8?=
 =?us-ascii?Q?FBfqsBj8OSabiSvyt3XQcZGWxv02JO5vho50jfL0+468Q1xjo0n3hgLOlBRr?=
 =?us-ascii?Q?GlVNXzQXgE0/rhizyS0QR+kDkiQasxwp0TA8CZ7POscE6HJPq8tJK+r4tDJV?=
 =?us-ascii?Q?34rCaCDKhtgzGZMknZg8SQZIc49xzN/amswKpPmJw1cJcytCVKmzQSvWgACl?=
 =?us-ascii?Q?51qOLbT6thhapxiQzz2tkj9ToDoKbw54UZ3QIpVCdyrbTgvbPVfZlRk65miE?=
 =?us-ascii?Q?tsjj9/BRVtLQBGisoPUxzMgHVN8IAIX1pUSjK6CXBi7GhQLGu3XBSDO6/CuM?=
 =?us-ascii?Q?Nrgz2D9BfXghjQFhSPBv7ycGs912r0IHi4UgiQzl45ZYe11ecZEzQq+1tcgF?=
 =?us-ascii?Q?m4BfdKnAoD4DFSRfD+7uepVK0+T2aPniYZNoK1On3yPpOWJyx37XbXLVWXqm?=
 =?us-ascii?Q?6wvG04OqBElo3cdlAM4AJSASdUiZ7oCapXTCeWOELhlDvE8tJJjlvqXq/K+r?=
 =?us-ascii?Q?9S5g+V5s8SEJ7fLQZ/+rfcmNBHJMRRmU82xmuELz5YIE52tnhccAc/jVNQJC?=
 =?us-ascii?Q?0DkrnAq10XifUoSaJ298PR5uKetF9NgNbPLz/RYW8P9YqfjJZ8erDszPLyjN?=
 =?us-ascii?Q?muKmtSrpe0Y+VSlv7gWP7//MxOprK4uqVeNobV1KpCjonuGaICVREEfQ+fzA?=
 =?us-ascii?Q?IOdF2vuZNR9AGWEDXYlRKL0SRsDgrNokrkxawHadR5cgB6lgV0943X5qcAZj?=
 =?us-ascii?Q?MkLo6xONMnf5iujbEqRhy84TUwoS1bWt/cxiliAdFuOWIYGd7/tq6azzwEZm?=
 =?us-ascii?Q?GF+cinHFbRBtXNDiCdF5z1DeHfLyF4peSXOTNRmfnQd74txIt7g3J87KzTtM?=
 =?us-ascii?Q?HsbZLZLlfxbjs7AR5Scrur9ZAKhOjEMUTGdDqD0KFivGnsBO85qQdnL0pNpV?=
 =?us-ascii?Q?Ud0FOvJ0hmDLaB7+kco4POPsN51rm/RY/kJXuVgddKdD4Yf1QerVKWeDG/Yd?=
 =?us-ascii?Q?Y1OdOpBIIYgmiSqxNZjOguWxMpmV58vkMb9AtctSlM9+XjBChe1P4E/eSrR2?=
 =?us-ascii?Q?JRgr85gvRGJM2E+ycC5PpB9tKj0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700013)(376014)(3613699012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 03:14:48.3840
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1713cb2-9e87-4e09-40f1-08de5d523a9b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7827

On Mon, Jan 26, 2026 at 06:56:34PM +0000, Will Deacon wrote:
> On Mon, Jan 26, 2026 at 12:09:40PM -0400, Jason Gunthorpe wrote:
> > On Mon, Jan 26, 2026 at 04:02:19PM +0000, Will Deacon wrote:
> > > If we do that, can we drop the smp_mb()s from
> > > arm_smmu_install_{old,new}_domain_invs()?
> > 
> > I suppose so, but domain attach isn't a performance path so it depends
> > on your preference for strict pairing of barriers. Currently the two
> > smp_mbs() are paired. Can we reliably pair smp_mb() with dma_wmb()?
> > Are you happy with that clarity?
> 
> Yeah, I think that's ok.
> 
> > My view is attach isn't a performance path, so having extra barriers
> > is fine if it helps understandability.
> 
> I think that the more barriers we have, the harder the code is to
> understand so I would prefer just to have the smp_mb() for the
> write->read case in arm_smmu_domain_inv_range() along with a comment
> explaining why it's needed.
> 
> I think that also means that my concern about the old comments on the
> other patch largely disappears.

I sent v10. Thanks for the insightful reviews!

Nicolin
