Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2074.outbound.protection.outlook.com [40.107.102.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A731A2554
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 18:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740766023; cv=fail; b=XwqiJ9V8i4AlsCSJiWQHei8AMYHkpBKX4pZG8jTRH9Tvl8L2nWnRuI+9c9t8FbfxLyBCOH11I+/pb1CoShNY8lNDhH4zBFOujF0IK66zhCEzwJJMSbG/zJM5YcNk+cuhhU231hm/5V5w8x8NZSpIzutn2+V9xipoMq2ynQ3mgtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740766023; c=relaxed/simple;
	bh=EdU1b+y1dOlzu/j1AuAIeymFFuvXj/5jJ48pb5AmWTU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SheYSh60U/b5QnZjKWvVJ05EzcH6o+dIolcI59ka5i2+Swpoh61Gvc2oFZuZuWQeLDeyicnYuVZMpdWmq1F5zgsl4QnSizza6v2XmqHFHHY7MMS8aXB0oaOcN9VP/KMLyb9X4beksVEirpJvNQCgcecaHduvGgpAKVR/Tx0uibI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oMtuYKNW; arc=fail smtp.client-ip=40.107.102.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oMtuYKNW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dmaZ5nKhLpw9N2YcIyggqFAGrDSkaGUScg8mWywzVM8KNEmVUxPE7FE9eFThc7G/aDC7qdnZ9NfjcTrZ5Bbyn+BAhI9fyB8e3fEcboy6Fc1C4S4w8iWKRZ1ehjAJJoLXn56KgBizejKoLXxQLUBEh7/vP7zEFUWq4y4q88keYcJ5QdI/BUxgySbMta3yk/RGw8CCrH0hnjg2k8C2t9snI/A35BDE+BosyO/KEUc4mVvTuSDu06fP70mphm2y3TIyu3RzycFgEFcpGF6NHvs+PP5DhuJrGnJrt8P3bjZrELu1Qv63R0OxrCjPZglm4L5m4fIGp0CIONwk0YCGjmMq0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g14dCqkGbqY5flDr27oNXDanQ0XeWgER+YWOgAgu3+o=;
 b=gkEvqlp44tUBGet6TRJjaN8b7Ou2ZskO+ZsrkSR7y0KxTpOqi/vI4+QWUDanSI6nEKKyrGsbyd0aRh2jzFC1RnvsPknIUeijDN3XkIgS9yD4pZBPY7O0OOLjXNDJ00BpDTmBHWhCT+VMAPQ/Sa5wJDad79lLpPdIUxQiDtp8B86kZWkZ9eWUfv+0CATiLJQ+IntsvqJ516y0spKIJ1xAy8u/OjyXVGNyvIQWP7OmloFc4KolVuW6bwjT1QrBEajSeHeniiAdyVftHrmPGaQwGQHbiqVseIdzBRG/8IObgReXbCe4k5p9HBKuKMD9XTdOX3kmU5M7nWIzkWdayhmnMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g14dCqkGbqY5flDr27oNXDanQ0XeWgER+YWOgAgu3+o=;
 b=oMtuYKNWzIRfouBPfKPHTMhLZlGrcGgCpGIIfEB52kA/rbVs5xgKmWe2btVfET30Zlb7QWej12pM3+n9bfvPY9BPlv0yxu9HSn4Xf4BHg9gzWf6hn2QYoGVtRgzJLzGsTsJwpOAbGaGdDnqp+YpMWD3XwBAFSl6bG09yc3pxvH30dPNRBPoxQjYz+NivNWftnY4sq1uA4owd56gAQhxRF1bF5BTcOE7ohwsnrwkaZQuPVhCnl+yb/Hfhud3LX+Oq5ZkWOWfzmCfQ0MMYYtDRq7X+UvTaK/ui1MOa5Uu7nfa72OXf9kcitFIAoB9i6rWYrwB8BTSBoZTpk/zN/UGw1Q==
Received: from BY5PR17CA0050.namprd17.prod.outlook.com (2603:10b6:a03:167::27)
 by CY5PR12MB6108.namprd12.prod.outlook.com (2603:10b6:930:27::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Fri, 28 Feb
 2025 18:06:55 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:167:cafe::9d) by BY5PR17CA0050.outlook.office365.com
 (2603:10b6:a03:167::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.19 via Frontend Transport; Fri,
 28 Feb 2025 18:06:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 18:06:55 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 28 Feb
 2025 10:06:44 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 28 Feb 2025 10:06:44 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 28 Feb 2025 10:06:44 -0800
Date: Fri, 28 Feb 2025 10:06:43 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Joerg Roedel <joro@8bytes.org>, <iommu@lists.linux.dev>, Kevin Tian
	<kevin.tian@intel.com>
Subject: Re: [GIT PULL] Please pull IOMMUFD shared branch
Message-ID: <Z8H7MwT2Aln4ODxG@Asurada-Nvidia>
References: <20250228142933.GA105053@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250228142933.GA105053@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|CY5PR12MB6108:EE_
X-MS-Office365-Filtering-Correlation-Id: 42fb7c2b-b7b8-4ef6-d82a-08dd5822af8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9TVsxVMmqXxiXGM+G5Po7HUpSIzX+xjTM35cTLEl2ARBChSv2n1jRGZXo8bI?=
 =?us-ascii?Q?rRB093JNwKeB0KNjqBNKMaI914+7uBwHxgN7pGH2J8cfF4bECslE7x4fahq8?=
 =?us-ascii?Q?gSCi4zfeJFjiJDc9teYlIV75PNKksPQqiS/XJ5KhzWdC/yey8EVmKYP+hOhi?=
 =?us-ascii?Q?Cwn74rL52wFmLFZWN2r/x73/5CUg5d8/xzef0Wqef0KHZ+st1hvo2VQuUMFm?=
 =?us-ascii?Q?HttQPt7kzaTKLZnSgbmpydAR8luWsfFJh2fIX2hJpMYLXIlK+oF299VYW+z9?=
 =?us-ascii?Q?xkrbTOQ+qLChNbLW4qX815aoSffx/CzOj5i8euOLvwWVZ6SNFdjXPVpOQ98J?=
 =?us-ascii?Q?iPuwjR5n64DE5yIIVdNCyPWpwn7YBEpNHR7cObHjOjtpuvQtLG3If9AEmPiu?=
 =?us-ascii?Q?XF9Vc+XuAnZ7P7DoD08WWUr5voBxNd2DkfM0uShnOev4sBxGoTBHC1RpItfO?=
 =?us-ascii?Q?TLLtfpaUgDfLEUgWEXp0zFTFOFL0W0nsKVKs1617O0rtgLRNjLmGq3ZQkeN5?=
 =?us-ascii?Q?o9g5swISmXK3G2SgEq2dCtdNQWlyjbxUZeAvBgS0JqWkouZNB0oniF0ykjCL?=
 =?us-ascii?Q?5eX5wqSJexBmgFFwWc+Le1f7yQUQfyGzvLMV7C0vI4LxOf73aRI7A749t77O?=
 =?us-ascii?Q?xNjoUNra2+gGItVDYEa664vgKwXQ23XL9iJUNwYJR1ioOvBzTxYtNW6FYyLE?=
 =?us-ascii?Q?YfBajM9Be3Rg1qdsY9LbpIXb2fAvPZOzlmFVSHwvm+vqzHGbK20GSv1u/vaP?=
 =?us-ascii?Q?jgFuzj06E+KF0HxF6izg8xFGqFDRREy1q7YQbENeWqdsML5eTCqchy3Y5Dtm?=
 =?us-ascii?Q?YyuXLhtgzlB17sSOVjzXRVJcxpeJUMGVk7qgespxlOwgpld955Zvu6SvEDPW?=
 =?us-ascii?Q?gpd7UiPtmTmrTzCenD9XtmTevydQDt59FF7MlJfJyHkNQ8bugqU/u6LpnhGz?=
 =?us-ascii?Q?FxE3CCUu3VUVkz5DNXtzCAw095SsEQ1LH4SQHI2RKPtiQ6e3ATzKj7naPNu3?=
 =?us-ascii?Q?xJMzvULc/vwu6H8B+NbnLePQfGrYSsYtbL88llvHZZJZZZvXyg9oVojIwwjh?=
 =?us-ascii?Q?BAkDLpZSzR/O2bUWYM3MZZVDlh+KYqrVowF/8xTvb47FgAHye8CZlAhM6bN5?=
 =?us-ascii?Q?WS4PHLHYy1eU23AfZO2WbNNnUB0DqYbbzaxD9tPpkLTmlhFc8zWXQb5pN5wo?=
 =?us-ascii?Q?RRnJrYFnr94wUJQnauap/aK8SPqhUt11A6uFWSLUkzUBhtzCBIx0URwj2Hyh?=
 =?us-ascii?Q?+t/DzoeXYraq0t4iGGgl989KsyWwOCz/SMNye6uoFG0GX7Bn0eQuY9vxj/qV?=
 =?us-ascii?Q?OlJjHBalOLcpCFKo6tIKxm2OWkGlc3ZqEHdeYQgjBmPNIys2XKQ85uS7OGjL?=
 =?us-ascii?Q?KuQ9ve+wvgoVuBiAqIKe8fsc6VqRat0Xay+FcGwHf1biXuHzxjgzxEX2pu6V?=
 =?us-ascii?Q?CjTflYj3B2djP5ZKZilJMkAgufn/qBNnTye/Toe9ySmmvIAUmVacCiJQPWrk?=
 =?us-ascii?Q?ong0tS3rRxLgNN8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 18:06:55.3541
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42fb7c2b-b7b8-4ef6-d82a-08dd5822af8c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6108

On Fri, Feb 28, 2025 at 10:29:33AM -0400, Jason Gunthorpe wrote:
> The following changes since commit a64dcfb451e254085a7daee5fe51bf22959d52d3:
> 
>   Linux 6.14-rc2 (2025-02-09 12:45:03 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git tags/for-joerg
> 
> for you to fetch changes up to 5e9f822c9c683ae884fa5e71df41d1647b2876c6:

I see the tag "for-joerg" is pointing to a different commit that
is on v6.1-rc3. Should it be "for-next" instead?

Asking because I cannot find these commits in Joerg's "core" on
git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git

Or maybe it's a different "core" branch?

Thanks
Nicolin
