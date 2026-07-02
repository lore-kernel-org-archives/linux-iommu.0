Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013069.outbound.protection.outlook.com [40.93.201.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B31823EA84
	for <iommu@lists.linux.dev>; Thu,  2 Jul 2026 18:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783018517; cv=fail; b=brO4Kd3lIslXC24DYmqalYMUEeFYN96FCkuBjPMzW6TaUHcKNs8XFLKiw82ad5NkgPdXmGLPzmxpyAZHbuTBECscXwpDqwjAQFKu/j88L5xmRdTcAd44SYLX0T5nOB16IEYKQBEL1kpYfHaZyQlkiYaOblimkP7rx10EJgBs3hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783018517; c=relaxed/simple;
	bh=NLPCVXuvm4ed6HaVlpZ65djG2OcBEJ+E/lJuiOqHpiI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNNczc5VhBs98Vd0uTz3XT78nzYlHedpqmC9YjWdz17RKiJkMzKhaJjmk4WjzHAseiCIJ066JuTFZeY8B+2zHjGTBdiOLnQHfw8zLGW21a54jTqjQx524UMjHH9P7q1bL1nqYr5r4siuvGY8Ytka8v96Cbs72P+CU2IpxBOsZVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=agvjK9H6; arc=fail smtp.client-ip=40.93.201.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="agvjK9H6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iGBbG3Tfg7IknPN0e17cGlc8FdCjfa2oHb3LodHyfPLCF2DEaCT2Ob02c9Kc0tZ3OIim1QwCGMNBOWL/5bLcu83hcTK4boAdPH+/toDPMOnOCqnl7+D/ngpE8VMWFd/s75cf5Dtx8V+O8UK/KsyuFQRQb9CR+d3ubfMNZLK9GQNyX7/BGjOHzuLQ6JIpyiG48BzkuGpPbjZeAyNjwx6GBCxmVfc5GvINRxLjuTklLH+DipkSotPWuG8ZG6AWcznIsICbwPVxDIUIu/i3LzJcWR5QEwX9aBjAgsOWnZ0kFuC30543UF65rT6OwQxYBeAcLzRIm1fVgJZVjxLT3mPXrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkXSuQOdgbSwDj1V811Je84c8RPbs+Agf2zsvl3ScOs=;
 b=UR0BtkF7I9M0TSrbiOR/kJtc8WAQi1HjJQNRuxNFtbB9O9J/S5/pwBUhy/qGDizYULklH73D+TB251NZB5OfQR+SxkAeRKJM0BcIlwVTcFL6bvBOrHy1sb2s1F/q93cmHqyIit1wQmm9cbau+E7YPbmFyezjZHqM7fEofrF53UAL/7RblCkhnBIuwl8ZOlPL43V31iYPTWF8JVeJuD8sYlvU/qKACKBUNKv/b9LAr9b01bkMIPqsQocomR6f/qMHD7E2UBYWvqqdBa0CUUuNjSXlyQvdKmxmG9Jbfk48speKo3v/DNyVRNHdfOSfhZnbjaDOguwioxw71P+rOoUgrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkXSuQOdgbSwDj1V811Je84c8RPbs+Agf2zsvl3ScOs=;
 b=agvjK9H671xvgLxi4jlpw92MoLQw79ecvXSdylk85+N2xs2iA+ytoXCy1EjzKilhgxnfasQUn0JTYvoo5i0veSw+loLQPm1NtYAOQRQTgYrBskR/fSXJGE7BI0N7oUexZi+Kds0uA4j+trzI/BZL4ExXCmsX/1PUK91dY5X0Nev6RW/8Aivcv3msVr+nCNs8379yvM6zsmBgY8EPcUPkR2tFz9kQrPF0XOE78ID2LZV+ot32dZ4x1SWaRR49Z8fIPGevkwXGKTL8Ob0o62lmgP7gSymk5dm3pJKrTquVUSZfvzqKRCBxxEn1xAnl4jryPUNpzS6riWI8bfIfQWLYqw==
Received: from SJ0PR13CA0131.namprd13.prod.outlook.com (2603:10b6:a03:2c6::16)
 by SA1PR12MB6995.namprd12.prod.outlook.com (2603:10b6:806:24e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Thu, 2 Jul
 2026 18:55:07 +0000
Received: from MWH0EPF000C618E.namprd02.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::57) by SJ0PR13CA0131.outlook.office365.com
 (2603:10b6:a03:2c6::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Thu, 2
 Jul 2026 18:55:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000C618E.mail.protection.outlook.com (10.167.249.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 2 Jul 2026 18:55:06 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 11:54:48 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 2 Jul 2026 11:54:48 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Jul 2026 11:54:47 -0700
Date: Thu, 2 Jul 2026 11:54:45 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>, Kyle McMartin
	<jkkm@meta.com>, Breno Leitao <leitao@debian.org>, Usama Arif
	<usama.arif@linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Shrink command/event/PRI queues in
 kdump kernel
Message-ID: <akaz9UYyPm2yKr92@nvidia.com>
References: <20260702112825.781750-1-kas@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260702112825.781750-1-kas@kernel.org>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618E:EE_|SA1PR12MB6995:EE_
X-MS-Office365-Filtering-Correlation-Id: e60abf73-13a0-40c2-8e2d-08ded86b6ed3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|7416014|36860700016|23010399003|18002099003|22082099003|3023799007|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	qhmWypZVyo934Vu/f6WJjgclIgO5xQhMrYpR3QGC5zLbllwGchcRpWzrhLeLtByFJcSrTjf3dYTvxRL3vQKLfj2J4fpCTKuPj5UOdeCUPdUU/3lJKbRO73vvFWWpuFgmqZzC1Up7fmQWTrOdp1yPXEUOW4jvFD1pQTa4049Gu6pgExaaXRO0lqX+mdxyxgyxSIrqXdQoMt6PlCrc5in282mezQfmtpFhlK/0ACIDlDFKDO2xHaW7ljEg5ofo78NS6T8CNgK5bzvuESsMtazQuTIS6p4x5fxuVNSltzuZP2Jn+FRdGgNVmrw6y8ZVoSPafL5RcaqwTcqSbg58P15q5iRQTjb9SkcIfpZNBzVHT1ahcuhR70Bj6QcO1VUs3GO1zSWe23WDR5OE1/jpRmoesA0pFNyDA3SC9H5JCR5DsD08IgrdXS83duX6fFF5Lqq3LqHx2EGeC5LvexfASjWnFIzx9f/w907D6RnWWwvsA3XqeUu47MpjCq1a1lIa0HmSCjiuAVqWL7ZRU4wgOHz2UBWlQthDS4o7IyJ9Pormj2WZyyQ+tCb06va7VTeSkFXGMCN1R0wc3G37ZUdyp9bQZQB++qllE8hNLAaTlZmV8qErgwZ1TpK89F6/Q00aEZHEIOIcHXUsKneS2yAH8QxSV9qfI2IcR1QumEwJmcAJx1cwSMSSGmTsvSHpSi/aiwAqH2rP5l7S/ABiFsgm/dsOHQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(7416014)(36860700016)(23010399003)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	A6q8KGyY+kv987wZZtgrYEdwlLH3xZHFhE1Dm2Dl2uJsTxoO/RkQ+VraaBWC/F22DxI+H+Mph+BhRoxgpmicN9079+aHEL7VkfMMP9Gm2TaSWQjdG/uLnftLFdtkTc7V2qOLGX3hwCg3+kyNVFKBR0/R26REJ1WZGVs71O9xOTr6tdMN8mVtnX/DYglViduiJE/CtypfCir9ZNSW/Cm9YJVVmr9OoijNBtykf2bbji3XV9mNhRzk/Ee0pYnCaH52ndK+/OJGKcxEfURIpOxyNz0M/2BiOSnaLeNnRPwdVHIw0lvHTlFqmkNoKl/pJjOpLcvCuzOs+v1Gw4KXWRW94zTAQM7yw27zrvu2R/WSq7rQz/8qFCN/NwolVGOqwIVOKWnk8CMBmbW6Gn44dsVM0lm1N6/mxxJx+shd+rbGp6ks0dvCcovDHIBpHDBqmfPz
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 18:55:06.4554
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e60abf73-13a0-40c2-8e2d-08ded86b6ed3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C618E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6995

On Thu, Jul 02, 2026 at 12:28:25PM +0100, Kiryl Shutsemau (Meta) wrote:
> The command, event and PRI queues are sized from the maxima the hardware
> advertises in IDR1, which can be several megabytes each. On systems with
> many SMMUv3 instances that cost is paid per instance and adds up to tens
> of megabytes of coherent DMA in the capture kernel.
> 
> A kdump capture kernel runs from a small crashkernel reservation and only
> has to drive the few devices used to save the dump, so deep queues serve
> no purpose. The queues carry invalidation commands and fault records, not
> DMA data, so dump throughput is unaffected; a shallower queue only bounds
> how many commands may be in flight before a sync, which does not matter for
> the capture kernel's small device count and modest I/O.
> 
> Clamp every queue to a single page when is_kdump_kernel() is true. Doing
> it in arm_smmu_init_one_queue() covers the command, event and PRI queues
> in one place. The command queue still holds at least one batch plus a sync
> (256 entries on a 4K-page kernel, well above CMDQ_BATCH_ENTRIES), so
> command batching keeps working.
> 
> Suggested-by: Kyle McMartin <jkkm@meta.com>
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Reviewed-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
