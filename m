Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012057.outbound.protection.outlook.com [40.93.195.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F91347533
	for <iommu@lists.linux.dev>; Mon,  7 Sep 2026 21:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788818252; cv=fail; b=rxV3Y1v5qGNaTATrceWFBECpStIl5xjzeUHKhh5sMvS+To2ldrheQL3uSSvAbvfMV7hyxSNJIq6DxsV8v0Ml2UPmZALPsACXo+OIOv4PcDu4Vg+fUO7H812eWaiFgTy2bqsEqWAUbdlL2bFD+7UGuT6u4JzEHXRdc+WTi+DIPoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788818252; c=relaxed/simple;
	bh=r1e4pNaw8fFH5Q6Dgrsb0iKfnY7kJh8qkuvYnaIelGk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVIw53xwnfM/NaCYDGDwguVMfKIqimrczJwXKfbX9wtmS3kuWho0xlsjBA7MCQNxHRZVgr0ABche+fjukZLtY1MMypdY2sX8xhfQtWJxoo6YT/wONgNsB7jqSOq8eYt2Wy8baNxQLusS/s58hqmnG5JrmZXvKPLWqEStsdDUEQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ACWo3OcS; arc=fail smtp.client-ip=40.93.195.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ACWo3OcS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CkM+FWm1a43do98J2WQahmyQTe0ZFJpxaodaUYhk+DVVozEwfuaW0KcI+74FvGkfUvafrUNd35fmuNI1oHSdeW9lS1PbeJ94CtGPGut7j5q3ai86TV4uPtG28D3vLcIM6VX71FxU0e7pdBXPb1nqlg7i8YPNZToGc/IxuTzcjKIbc/WMHOS+3sxQhTT1Bd7Qqoatdkroijgbx6zVB0AoJ85MQQrCUaLQLGuwCTx99AsJod7NGvaNjxG7TpYn3mtdUlZJTGw0sUUu6ZF8kqiCVibHGWt1Op/38jlwdtM7cSNXabwVE7wK5HhoR+U1vVcflDDJUX7ARsJblVdqgMOJhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GevQuxYfWTQIe/XavKA5EkTQTapmHU5usYbZc151YI4=;
 b=nbz25Sx4Dc43YShMlSRzVjBoFThA1NgurWMsmqZjcMLvEBv+hnypLKtiUWdut2WAqerc7sYtOjadu+RcdM/1x1oLV+fl9TAHvX7LejlBla6JOO5s5z2aHqHWQ4i1hFLrUu7wbZ6n2vgY9eYn8LeIX6byczNoAQGYMt6PpLLCfsqFwjaoU2zogqxiKQ+joWI9Y+xrd7oY1mLfuyBnuUciqRBGP5pipoS4nYfZF8wv93TJpcerT5aIkoIDUIwmb7djRIF4ksm2wggt3u7SvXBktmMUI5GdbVlX0eS7LryNheE54mucLIYk49C5nhd8TfiNe25xP4RK28ppSJTfJhQD7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GevQuxYfWTQIe/XavKA5EkTQTapmHU5usYbZc151YI4=;
 b=ACWo3OcSAimmpOGEYRVMTlZGu9twlFk6bHu0WZaqtoO0QULTNVDH2vVcaIJbkrcm6Llci3OwqQHcSyC3Iz2nyCksRgyWSexL5ymtkI6p6ESdvZne8FdZux7CNKdkx4RmmtJBYHO9llZSXXdc0IrBhiiP5rM1c1MPtHPMt8PVVtkCyi/83lYbm6FT+GZFL/EubwzFLe6gInnuiHsX/wEfnbLMwotei+D1xOx5nVkfmtFQMs3wCClUFWhhyiFZB2EwVRl01nu9wdBlrylpweT19AxQCDb8Nl4L0YlGlXDUtm605vG3rNiW3FFRya6bwF6emL0D8T3MzlQtmQper8xrPQ==
Received: from PH7P222CA0017.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::20)
 by SA1PR12MB6970.namprd12.prod.outlook.com (2603:10b6:806:24d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.14; Mon, 7 Sep
 2026 21:57:26 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:510:33a:cafe::29) by PH7P222CA0017.outlook.office365.com
 (2603:10b6:510:33a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Mon, 7
 Sep 2026 21:57:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 21:57:25 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 7 Sep
 2026 14:57:08 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 7 Sep
 2026 14:57:08 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Mon, 7 Sep 2026 14:57:05 -0700
Date: Mon, 7 Sep 2026 14:57:05 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>, "Pranjal
 Shrivastava" <praan@google.com>, Mostafa Saleh <smostafa@google.com>,
	"Thierry Reding" <thierry.reding@kernel.org>, Krishna Reddy
	<vdumpa@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, Breno Leitao
	<leitao@debian.org>, Kyle McMartin <jkkm@meta.com>, Usama Arif
	<usama.arif@linux.dev>, <kernel-team@meta.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] iommu/arm-smmu-v3: Default queue depths to one
 page in a kdump kernel
Message-ID: <ap8zMY3mRV+VTJS+@nvidia.com>
References: <20260907095835.1233352-1-kas@kernel.org>
 <20260907095835.1233352-3-kas@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260907095835.1233352-3-kas@kernel.org>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|SA1PR12MB6970:EE_
X-MS-Office365-Filtering-Correlation-Id: b66bff7c-c596-4d64-ba99-08df0d2b00ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700016|23010399003|82310400026|3023799007|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	TZJkUp5cBq6nrPQEdXXRHNr31BCn59tEm1tRuoaKcOu8hVPVHdoIjapbluqm74aun1nELMfUgs0HUkNJ/bMkxO1CHarQLkBnrXjim+BK7w5aOr+Crujr8E+/pZ5M7NoynWcAO3wJ2wXlVwFxA+uLldPvR/HPqj7tQZtZ0zZUPqp62Fd25pYKY+fzQj7NHqwNCL9Mcr+FJ//auOq/45ApJQKp6G3i5NAVCV+Imn9FazN/FZkROFGTwgTsYTtO54+j/bZDottYYw4kRjCujpMU9xP7mlniSs/ETT5XYAOkOm5hnFKoGHmjwWBW7ZPOonwSTzkQedSr1McPRtvw1Ufz4cnBtaObIpag09fQSmoyl6NlFP4bH8DVfaT4vMi1kiNBi2cibSdozb5TVsYlMN3VbrGZygVqucx62AQxNdTTJttf1lAbDTO9ohmb/k5rgbubg9ODGSSosx2h3p43lx6cDSmhdHqzUTOQZFGW242/6jf0/LW13Y9i8lP261wSUwnwocFcou+AZoxcawxbS3Se3zDoZPo47SctmWkYgVSZ+9HQhMGWk+5G7NtoW3vO4oYPaevWZRY0yRFidzH0huxHC/GyI+ImKaWLEF150FpqAWZ+nihB7R8rYEP2yrG0yv2Kybw5FQKViygr0aRU2ca0EU9aeV5CLpRRip2f5u4iUyKiX0JeP+ghLjfBkBSkWA7LDLffb+q7qGhTJ6BdQDm/Dg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700016)(23010399003)(82310400026)(3023799007)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	seZawaODw08vs1mgU2NXgT4Z/H3VtjvOojG1TJkkEg0vsfmKpvAlz71RWxJmkWur/8PODY8vUhbjs6JaVQ3RX2Q9Dzt9Krwc1EFEYcgEarJXtqouQd7EBU2GRbV72I6jN1aDDzLxm58M7B58mBgdZDqoFaUs/+HXMFKYpUmJpOrPKSgqvzYnqHT0ld3QYqLmfhmk4yBxL2gUE7wEc18adx1ySsCZFsYH+bMAk7obFUhqainuN/RXlUSi/OrXf8Doxb5NM/zYtJUhNNm/nDfZsw/oMU/UmrHEs3xoJVOLWBSFVS4zvUKt2Qdy7/yScJPl0wSNhkj/g2KqQrOQg9p3GabvKQbf9bBGvB7t+aVtIS/nEolD9zkzr/EGN+msNT0/lIpfK3fcd7KFVXAeekfsVfLbCcnvbOOjGa664OTigiq2OB86KWbh4N3oNWp1TCFg
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 21:57:25.4273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b66bff7c-c596-4d64-ba99-08df0d2b00ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6970

On Mon, Sep 07, 2026 at 10:58:35AM +0100, Kiryl Shutsemau (Meta) wrote:
> All three queues are sized from the maxima the hardware advertises in IDR1
> and allocated at probe, up to 4 MB each on a 4K-page kernel. The capture
> kernel already disables two of them: arm_smmu_device_reset() drops
> CR0_EVTQEN and CR0_PRIQEN. It still allocates both at full size.
> 
> A kdump capture kernel runs from a small crashkernel reservation, and every
> SMMUv3 instance pays that cost again, up to 12 MB apiece. It goes to queues
> that either serve the handful of devices used to save the dump or are
> switched off outright, and it is memory the dump itself needs.
> 
> Default all three depths to one page worth of entries when
> is_kdump_kernel(). The queues carry commands and fault records rather than
> DMA data, so dump throughput is unaffected. A shallower command queue only
> bounds how many commands may be in flight before a sync, which does not
> matter for the few devices that save the dump.
> 
> An explicit cmdq_max_entries still wins, so a capture kernel that wants a
> deeper command queue can ask for one on the command line.
> 
> Suggested-by: Kyle McMartin <jkkm@meta.com>
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Assisted-by: Claude-Code:claude-opus-5

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
