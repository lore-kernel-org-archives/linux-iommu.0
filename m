Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010039.outbound.protection.outlook.com [52.101.193.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C1822172C
	for <iommu@lists.linux.dev>; Sat,  6 Dec 2025 19:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765050905; cv=fail; b=K7N//gWkzsBCSFacTz3qmOyfHASZh43eQlipg86aU0i7g7VOCVVtPKQmzc0tUjLh0qvkHXAx6RiUmhN8Eh+LXB3DF+xRoml/LyjT0WKlldL5q8Ls0YUHXMhUIfQFhkdMJfiRvS0wwNDB2V4y5+PZ19eMVV0JKvLSj/TVimBIics=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765050905; c=relaxed/simple;
	bh=oS4RApbvuMy5DORcwQlHn8w0jP8geM04ayrpqToNA5M=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MvaBPqcfnojz7qJ9xutvFbOl2cz9uZ/45gdSQUai+IrURLzKyxXWnD9z36GgyNJZJGYee+z5cTOLbcrKxnKing2YRnHfnk73IxZQt/t+MFx1kSgwpJvZqIUk9K72ZCr327eMMQ6zMUKkuMWGi5DbKfdPpyKsGNWJwcuFEKn0+ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WwSP1w8w; arc=fail smtp.client-ip=52.101.193.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WwSP1w8w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K08O/weeY1EAk5VrCBVTvvJVRqCAmKz9vxqbgh0YiVxr/G4Ez8oBdn/H/B9r9aO1DB0womJ/FsYTvLztjjgEDBND7oMwc6UUSLU66evrY4cSwq3yTBRvC5tMjELXxwr7HM001rwnzYJfP71rFggPDx5lJd9aB9usJUTmth0BHjOSmQJH+LRnAQRqeIhIUIebq4KXSNUUeZxBaONMkK5y0qiOdK4pfvfKlELANb1PXbnDOKRCcZtAoGOCbF6il9Vh69If4mussXKe5sa9sfaTi4xxGkt7J85EkQEoRItoI6sZQtijoAgUdVDxefntQ0byrmBwMMIzFNggRapwJkafWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDsVDfxmFEPJbwfNR89J7jsoiBW3B5eUdzVVjawGQ1g=;
 b=CrViU3o2/lz2ImJgNQNYMqFjJbBqE+dHJoQuM6jinRryn6HRx+T/1bZhDiHVOEzKi5CxhQL3KicYOp2q9oSpOG8pinyDgdDQSJM3ebR3pAku2sItd1JEQ2s7FRXYHTIieUNhJQbgt++AzdRfy0pAuZ79EMNu7UyoxvIp9w2vO+VghrVQNwyFOoEJB8OG3IDdi+Sh8GGX1MDqyN8MOnq5oKhalhzi5RXTpek/JT0uXITiLdDJNiCNfbwAFSw99Of7w0gqECve8tCAgcu3HjKbBXBc1wEtRdOlUCy2KKMjfyg/9eNGsWUIEBmMsH4ZtZnnIOOPetaL3a3nOJnALY+UMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDsVDfxmFEPJbwfNR89J7jsoiBW3B5eUdzVVjawGQ1g=;
 b=WwSP1w8wLX6Z5Ftf+ut7F2pfFvB3Sfl3+yBMkFgJMeTCR4tOj76EbXlURfAUoJtJNkbIxdsX9Op4xvDT+ZhS+ECL4qyi4AYrGzL9FYHxIdESceIEwJIGSKW6ViJ+n6D8OfSXfpYyjIHCDIHhQTTFSxrgGFeojOrKK9HLMxd8jB+Wyxk7Hs9hbBhWlMXomadeOffsF/jpXBXqKKPTyJH/lU1/IGZyIMw5WnrUFfBZYmcUPCHZmTRlqry92iJ9uW1N9TQbFIvW10KshfTdkNiv6HfATIxYIjpidP2a7qV580zOvAngsOHe9L7a/r2YRFaSmN8VkatXWGA6BWXNcZmERQ==
Received: from DM6PR02CA0156.namprd02.prod.outlook.com (2603:10b6:5:332::23)
 by DM4PR12MB6112.namprd12.prod.outlook.com (2603:10b6:8:aa::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.9; Sat, 6 Dec 2025 19:54:59 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:5:332:cafe::d5) by DM6PR02CA0156.outlook.office365.com
 (2603:10b6:5:332::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.13 via Frontend Transport; Sat,
 6 Dec 2025 19:54:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Sat, 6 Dec 2025 19:54:59 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 6 Dec
 2025 11:54:58 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 6 Dec
 2025 11:54:57 -0800
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sat, 6 Dec 2025 11:54:55 -0800
Date: Sat, 6 Dec 2025 11:54:54 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <skolothumtho@nvidia.com>, <praan@google.com>
Subject: Re: [PATCH rc v1 3/4] iommu/arm-smmu-v3: Ignore STE EATS when
 computing the update sequence
Message-ID: <aTSKDmb2gqZb2Zne@nvidia.com>
References: <cover.1764982046.git.nicolinc@nvidia.com>
 <db1450e7a5989e51756a7ec3285d70ee90bae24f.1764982046.git.nicolinc@nvidia.com>
 <20251206194637.GH1219718@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251206194637.GH1219718@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|DM4PR12MB6112:EE_
X-MS-Office365-Filtering-Correlation-Id: fcf974bf-dba0-4327-9562-08de3501568b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+J9ATuy+dm97DgImvBrfKabKnhvYpBeeHpYfIVLCV2QcY0qQGaKzQRe88Zfs?=
 =?us-ascii?Q?1n9uWnWrdR+UAERAmRSx/mfoLxaxyOwCCS48oOwBTQp23XODQuPzTRS+V5vp?=
 =?us-ascii?Q?6Ho6VsFTr2uNfa7c818KzXTKeGuc+I0sYMhEilbkCz/RrDmW39w6GgqdAjpG?=
 =?us-ascii?Q?N56qK3PvnThErNcAnS13RwD4JQ1Jd2skLIP1VXy6UiP/UeCsSpjJEawhTL7n?=
 =?us-ascii?Q?rI3WLG2Nf2zSGtS8eC4kbgNuZNNyqvhOXr2wZjZaBZ9ZpQaWHiLRudD5jrRX?=
 =?us-ascii?Q?OMOY66BHxo8i9kfiirnP9ODOrmO3M9WXxVFsNUgzA3MVyZkD+yaA9Uh8tiEI?=
 =?us-ascii?Q?j+I98geupv/VmKD6BbPkrOO5R/xFMJi8B/Kv/6L8K1jxvsYIL2eFSGz9JU9Z?=
 =?us-ascii?Q?k+nSlwhRah/sueIqy+eZhvVgpFrf2yAJFJ+N6ooDnHSKSx3CUaKQxVaPnAUa?=
 =?us-ascii?Q?OdP36htkA6DJv+Ww7CODq8dZevMAdlRFmJL7FJraT+VfSMwdzNIGPnaJNfYk?=
 =?us-ascii?Q?P3Z8piSlPPPoNJ8MjV93vw83gbxEqyKxhNbYLZUf9Q9w5oEDbcz162LP4zk7?=
 =?us-ascii?Q?y4SU9fLjtA8yxYPXvNzMT4u2B/nzJQUANCbSaj2obDhQpVq1h9689DtPEAMT?=
 =?us-ascii?Q?MKB1NCo2/ZQgvLvVJQtL9HdkHW0/xQsmjVk8WrK0mVrLgcZQ41Q8ZvgilUdM?=
 =?us-ascii?Q?OwBOyENQC0SrOE47QL9D8tlJaHSEcg2MwlFoPZ2AafjMB2ZFCmShOcc3qgZE?=
 =?us-ascii?Q?NE+TblPBu7LexcrrtxlKz0XTC2uKHfhJl/V1X/N++N8YXGSZQvwBs17IZrod?=
 =?us-ascii?Q?ArsJUFBJ/7SbJTE5hTj5t8ZWeHItzMm9HDh6bB350yCUA+hy/hYHiJNL1iwV?=
 =?us-ascii?Q?qYV+/WeBX/sYclghuNMX/AWGzVNIzk/4i3FKfEgOm50EVHg5JkIoYQxm04F/?=
 =?us-ascii?Q?CClreaiV1TBndnsktgmPi/IX3zBqlMyIJCtQzmdVHLbMDWqJaPiMxVn5qn/o?=
 =?us-ascii?Q?2rdiyF/Fyk33NHgiGOPPuFStGETzfJvPtTRRBr7WwFtsJ0pRS9/NtdW80FvA?=
 =?us-ascii?Q?a9MYLjU7alJXq+IpjPQsdGBqFoc3I9dEZEmkRWXGqEva1f8tj5rpz5ZfnVHT?=
 =?us-ascii?Q?tGv/zeQpqLXTED0W1DaInRqHLCa3iZoIvXVKOkNcwj0vwGe4KUJo265uZNA0?=
 =?us-ascii?Q?Cd/6rfgdER/WxEOqJ9kWVqdJSCSVKB97uZUf75VOXetNBwFHxx6u7LAZwdqU?=
 =?us-ascii?Q?f+Bj3wA1/ljv3aqkeJqM5xDTajhl7o3Ub6WEPm1mUEBy5mzfgo1Y2CH8/CaJ?=
 =?us-ascii?Q?MkMp2OPgGKf26V48/JQYv09J++IgCQmfnYJciLMXirHZL4KhepRYXXrQGRjB?=
 =?us-ascii?Q?yAV5c8w4FA85a5co5y1G/YHO2SJ+MD4+OVIymAy/KNr3HEZZvk8KlQSrBIwh?=
 =?us-ascii?Q?rvlOYUMkVSUujqFGXg5/ritQ6X5K7vSrlrnlUTV33c+aLk5BBEADG0sH1rBT?=
 =?us-ascii?Q?/rcxGq9ulowQxvP7OAtjp0C+DXUc/UO7mXeKkiQ/NxoOlaYEFBsk3/p+BI4l?=
 =?us-ascii?Q?kxYl6yw7uN4AWRkTJas=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2025 19:54:59.4890
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf974bf-dba0-4327-9562-08de3501568b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6112

On Sat, Dec 06, 2025 at 03:46:37PM -0400, Jason Gunthorpe wrote:
> On Fri, Dec 05, 2025 at 04:52:02PM -0800, Nicolin Chen wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > 
> > If a VM want to toggle EATS off the hypervisor will see EATS change to 0
> > and insert a V=0 breaking update into the STE even though the VM did not
> > ask for that.
> 
> "EATS off at the same time as changing CFG"
> 
> In bare metal EATS is ignored by CFG=ABORT/BYPASS which is why this
> doesn't cause a problem until we have nested where CFG is always a
> variation of S2 trans that does use EATS.

Ack. Will add squash these two.

Nicolin
