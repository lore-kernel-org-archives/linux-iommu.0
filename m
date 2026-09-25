Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011013.outbound.protection.outlook.com [40.93.194.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E774119F9
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 19:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790363000; cv=fail; b=tStgNLcRKefIqukwDM5mUKzwfCncHUx4SPrmCUU8Fi9Ui5qCXeorfbipgGcj7fPid/UAy0mQwcFxkdC5KTBKhSSDiFe9ZmFOnCkLln2v2526r/7RPjeRTHX+AZxVk1LXc/C9J+H1n742E5WIYUOY3iVBHM7O0c20PEERc0nS3Gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790363000; c=relaxed/simple;
	bh=dJlE4IOqPTTrXTD+VLUQu/Cvzd04Jd5OyjnDx0U3640=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UO1eZpmES9CYokzwf77YPF52/a9Lp/dSYwIJLgdzEz7DvcxLwOYHbd62lYLn8Gy/tZrh359DSPq3beSble1rKYfRfAyeZv2OW/h9Bn9/qi6Ie4Kg2u/UHuaq11qGeG7aL3cNMwojPtf0mJC/0VZYO9fZmrwZenFsF2D8Jza7zSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KkdmDpSL; arc=fail smtp.client-ip=40.93.194.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KkdmDpSL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxychBACHZ36ga7GL0kuGesjUg2JmAuYavkYm5b1+IqPCEG7seKrnMsotBWnjvGXinuEZZGvwgkAl3Q5wtnfKaHz5VdQy/zf+Fs+rPbu6x6ncZo+ZJwe6/z8bJbaZHhhNPNwKzHXxRtJeauikQUbj3ATAGgqoH2X5awqGm4oQjJ39wTJaNUPQFEWrj2ngIbxb9CUABomytSstI5nTU1uzLgYGAl2GPr+9tq38iRcs1NZwlhuzK81yjeoDeVFGHLl0aEuxhQ8gfYblJr9kHzjYryFZGOSb4RwL+Ik0kW6mwGXMsvaOVLZO4B65Rfod+tqQ1YdTH71kYXErsyJ9pNy/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBi18/xXdAPob2GzHEq6ZlYC4cyY7Cyfriu6dj9911o=;
 b=fVqtcTDy0dJMtY9sbdd1sDgzPzYXrjtHDwkE5BLa0lCeWGJB37z1Cwb+mmeXTzt75r7M/NmLhpOCc0JlwW7ONZO0QbIB/P+L8TAJYnXo9ma1cCoXY4mXU85hTVFucHuGl/rm8rveVkaPzJygq5Oxbh7swWPpCuNL++XELwxmbc47znm9BK92HPxj6/V8y6s+sbrgGdbgcZ4BsPY5lkCKBf+Vg7GR6bJwMZ6ygu5HhUEq3JqpfZy1AKX6/RrqAfm2Kux0qNaTN02Iz0kD0GP5uVhZMR3HqD9deRIkwexx8646BqeXxFAyqkNj7/nxzFCt+rvZgzJEyLjc99kstnEgKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shutemov.name smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBi18/xXdAPob2GzHEq6ZlYC4cyY7Cyfriu6dj9911o=;
 b=KkdmDpSLQBvOVZiCKT2xLvqK9JRIzopjSSLFH22thjpwSCIxCx4NPYI3hBjxdUXRtCpDaJvQ2yxWqhhVJN3cH5QzCruUPZroG0fEb0O3mdRiFtRjUFGpEi+aWLXagIRgR8v4MfsI1M738EWhTL/Hq7kdoOP8h8GfmwYs8MkKyyJJjerstEJQIpX2KQken08uUs5Il7SNhjv3H/mrCbmjpT0o/HpO4JclU3IMrp+v4xB32g6AlWG2j8v+lmaH3T0+fRr9P1yghFqab7LBoKYTrZw8R0CZ8KHwO9QKHY/nnzdYLMdNtrtENWDGgJ+kLA3AJW9x9PKNResvgPRcP5dpAA==
Received: from SJ0PR03CA0014.namprd03.prod.outlook.com (2603:10b6:a03:33a::19)
 by CY5PR12MB6527.namprd12.prod.outlook.com (2603:10b6:930:30::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 19:03:03 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::74) by SJ0PR03CA0014.outlook.office365.com
 (2603:10b6:a03:33a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Fri,
 25 Sep 2026 19:03:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 19:03:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 12:02:44 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 12:02:44 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Fri, 25 Sep 2026 12:02:42 -0700
Date: Fri, 25 Sep 2026 12:02:40 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Kiryl Shutsemau <kirill@shutemov.name>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Breno Leitao <leitao@debian.org>, "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Krishna Reddy <vdumpa@nvidia.com>, Pranjal Shrivastava <praan@google.com>,
	Mostafa Saleh <smostafa@google.com>, Ashish Mhetre <amhetre@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>, Yuanhe Shu
	<xiangzao@linux.alibaba.com>, Kyle McMartin <jkkm@meta.com>, Usama Arif
	<usama.arif@linux.dev>, <kernel-team@meta.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 1/2] iommu/arm-smmu-v3: Add a cmdq_max_n_shift module
 parameter
Message-ID: <arbFUFs2PDKK07Pv@nvidia.com>
References: <20260925141532.1274962-1-kirill@shutemov.name>
 <20260925141532.1274962-2-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260925141532.1274962-2-kirill@shutemov.name>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|CY5PR12MB6527:EE_
X-MS-Office365-Filtering-Correlation-Id: c4f472be-c3f2-44d9-7424-08df1b379ff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|23010399003|7416014|376014|10067099003|5023799004|11063799006|3023799007|18002099003|22082099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	JZOGyC6N09Cg7+zL6MfHZ+ne3kumyRsRcbaQcVupOIiv/2dVNxkgC2wXqhGjGqxiaksuel6JjDXoSMTiAobackNZgjmgpvaTxdvPSYdkhvTtS2UBdgJicL3OGxopzWZeiJrx7XNOY3MlL7gsvxo1d3Q/y34Hn/sI2ZHmOU8dVCclSHV+2HTy+/MMk2ZW6g/9Q96ii5RvzQBZN2aZXIvq2v+4CuZ9ZJLcxhUXvtyLyp2g9iaI2IuPR/qKsP479kwWUe5KQMxBlnLzBrmZd45ePh9XVaQjMnUOUQTAAVIVrQiAe9pkAwa2+9h/O3dVFgNaOZNi2RMn5/9RolB62+5U+nJCraU4nmGA2qmQoRXlAj9T81xPTwBXLyeA7tNLDejLyV2tYQOcozCc7cW4CXwi4DocCPtJ5uKbANK5/urR/9lU1to+ElyqocYkcUScV5T9jLe1ctm7X4C0F+jzOUMHfCmrwEOgsy9zTTUYFj/8XJ4o8Arcd5BWqRDgjnqpnWnuOQ7CJiT4BNlzrFLiHt6JgjqbHNbSZUJHd9sYjFbXJo8+Lu6XPRPOsKMKZ32uuoB/LAArxwIcCZ/DEL55I6/vOqJy9M/riYo/d43ZXgxV2YDLKpOUnuX47Fp/vx0kM0SUonD37b/wC7E6I416/BEJp5SYX8rXZX9T3iCuxLgZm1Rh+DcLaiV5tfazBam9036N1iJcCchIdtVp+gewUhvQQA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(7416014)(376014)(10067099003)(5023799004)(11063799006)(3023799007)(18002099003)(22082099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZUuxc2ZAKlbPJXzUGmTxDQG8w6DiKxAdpfrBMJuubcx5srJojuXl8GRV373SvbtxbedaKLP9a/eRo7/dOX1hCtbaCLIIsskloYGGh6kzrR1yHxKeRRoKFREb/l6iSYqqeyDpm/oK1Wujy3G24Hq6m1DaIuk1MgZJCxDapFMrhonTQlDDrqh8QTSdaFzMPctT0QAwEK1uuC6lfiOwJs/RvAR3+RC81ocQ+Gj5lSBW7uolUALSlzZkcZ11OElQrDMVvxGVSriXHKFL9PNg+jNq5VAzzORI172Aj4PFJ9IPl7BU76kyiVn63JCZ4t2QIx0D8Yph/lVYvcR+zRj/rg2YoRptYMde2zir6yw5f0s627JQN5qGy38fjazXRSSB36uqT/t7zZPqNz8j9jsdyQu1L4KSLRAOaORqwDS+a2FQzF6as90P5yJQ7mMRlBWYOfig
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 19:03:03.0135
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f472be-c3f2-44d9-7424-08df1b379ff0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6527

On Fri, Sep 25, 2026 at 03:15:29PM +0100, Kiryl Shutsemau wrote:
> From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> 
> The command queue depth comes straight from the maximum the hardware
> advertises in IDR1, which reaches megabytes of coherent DMA per queue.
> A system with several SMMUv3 instances pays that per instance, and the
> Tegra241 CMDQV pays it again for every VCMDQ it preallocates.
> 
> Queue depth only bounds how many commands may be in flight before a sync.
> A machine driving a handful of devices, or one with a tight memory budget,
> has no use for the maximum, and no way to say so.
> 
> Add cmdq_max_n_shift, a cap on the depth given as the log2 of the entry
> count, the form the hardware itself takes in the LOG2SIZE field of
> CMDQ_BASE. It defaults to the largest depth the driver allocates, so an
> unset parameter changes nothing. Decide the depth in
> arm_smmu_cmdq_max_n_shift(), which applies the parameter to the IDR1
> value, so the queue is allocated at the requested size. The Tegra241 CMDQV
> sizes its VCMDQs from IDR1 itself, so route that through the same helper.
> 
> Floor the request at one page worth of entries. Without the floor, a small
> request trips the CMDQ_BATCH_ENTRIES check in arm_smmu_device_hw_probe()
> and the SMMU fails to probe. The floor also costs nothing: coherent DMA is
> page granular, so a shallower queue occupies the same memory as one that
> fills the page.
> 
> Assisted-by: LLM
> Reviewed-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
