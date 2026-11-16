Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.56
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794856040;
	b=u7o60bdAQuFOd0bMg5RCfAqr/3Ff7MOwUaFsjtqtM8RbzJ0IjBxInwnPkAwe/La93fYr
	 KUWgttWsK/sNYMw5AOh58HTiL4JSwKPU+X9pqHH9MmNDGuEvy92IOWeNexXXgCbFZvyTa
	 dMyHd+eIAidXrKK7fEtgYAv/lxbJD25zZEDcVlh+kVeguBA+Oks3qL/O00lisAMabEWaG
	 8ECEBrft37JcE3sFEpiSpWZ+xbnLoqUZOhlM8p/auDeUHDB/sgJqwNmbuktEEAL8HZpfO
	 bPmFctIGaRQKF/GRToYl9Iuu64X5e0ajZr9TjfuHmTfaUbIjaEwYnr3J3uvdzeCK/WA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794856040;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Date:From:To:CC:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-NV-OnPremToCloud:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=oTa0jRXAcAEZGOOg9O66CQ7hjTflUS30dW2gfCinjyU=;
	b=GfxPph1OtkqcrdDdFy8d46u2Yr7mJmM3wjf4E/+l6Zw2J3r2Qe03JckYqtVNLimyC5oT
	 5KdvZKzfFPuw3GARM/duA8/8ID1/hSP7NhYD8l7pfti5bSxbTomY4yl03mX5YUqOlzVrM
	 nrIQhjJvCg1AfecbtumbWMmLvGNMJl2c+MbgNHy7PKf3a8n8nkF4ucug/KyfnQv+Af2n2
	 13a9sj8OfnqdsPKEb+hkuDmV+cRf3xWWzCcST6+vLvM46cdeiUhj+OALChHOLOrT8Mvj+
	 fmz26EadNMaTh0kBgameCDLGBNHvi0OYKMC+KuryP0fxOsgR/wVF+xh0gE0POXR/Crw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=O7nQhY8o;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.56
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010056.outbound.protection.outlook.com [40.93.198.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9324E606A8A1
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 19:07:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9324E606A8A1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=O7nQhY8o
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tC7PAvzRO560HpMVnEAThaaUHS+Q5ovsq2KT46wGOSK9R9HNuVWQWQUuQrFl2W6IfFm59UMRHaJQD8MBA6m1fTI3PfJINssJQm9h/IKi+Li9rXPA3w6tE+hGaGRM4tK6RzuSvWMoCHE+qfcimrG7P4pC47wjNjAln3AfNf0bOx1FKi4xTCBNmFowdgaptDO5t0d0mI7uMlQ1P5Z38QhuujfYgza2ucU68RlkM55WCaSNhuwBIuLz3IKdI3PLIoXgXg9py2D9rBHI4Bs2C65cqIh/eWXlSOuRai9uGhajGfMECdE9h6fJQDlmqiNeCZQc8XZttgQ4l2UjFUoyheR33Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTa0jRXAcAEZGOOg9O66CQ7hjTflUS30dW2gfCinjyU=;
 b=Kc22oriH4ovHSmPZ3NW/b7qfdpyPNcsjKa831InkTVD+95qnZ9c24a10NLKEwGp05KDZoWnQ6rsD+mkx8fH11OnGAaJrKLrT+NqGRtfU7rrXCQH5MR3+szEocjn2HCAixG2KFbG1LcPxQ850SuJu9yPTEAg1AY/XHacn/f91rBFjFngP01PZb8W2kS8oaHxAnO6q4epJeahD2Mmq8HTiXIhML0PbA+m0oZYgDO/TD5QAafFaTm0JkAYd+Doedqf6m2y4VRuWTxBMgFUCPZbPyPoPk6JQXHvadeXeyDcGrAs104OeMnxPZiXoY7ri8W8+V85oFQ5mVdqDi8u4uZdJ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTa0jRXAcAEZGOOg9O66CQ7hjTflUS30dW2gfCinjyU=;
 b=O7nQhY8orjHoBbNX9uF5PclI0OnMYDJZDgtRSdwEsoSe8lO8wPgy3Akf8o1eBNqTCfrFCqc5xKr1ft1H75r7oz3yE0MJoo++MBSr1ixzhltJBN5D/4cuGg2I7z3fhSVnnQXj98eTop0vMQBgE0ZCZsHCm+MDYV4xKeJwk1HCzFX3jKuW8NT9HAWH1hulQa4IPJbiHpyxeeZOwwZF9aHWrNzytKhKeWdyV4UoBY40g7F56wiFXDmo8n2eKucueUKSXddfFYb0hs74lbu9CFnHGoL5es+dGn9ptjkHDNFSkNXHP4aeAU/tmuQ22l+yojlIixqD9lCvAnl0FJf2uAhwXQ==
Received: from CH2PR18CA0030.namprd18.prod.outlook.com (2603:10b6:610:4f::40)
 by CH3PR12MB8354.namprd12.prod.outlook.com (2603:10b6:610:12f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 19:05:22 +0000
Received: from LV8PEPF0000005E.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::a9) by CH2PR18CA0030.outlook.office365.com
 (2603:10b6:610:4f::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Mon,
 16 Nov 2026 19:05:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 LV8PEPF0000005E.mail.protection.outlook.com (10.167.245.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 19:05:21 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 11:04:59 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 16 Nov 2026 11:04:58 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57 via Frontend
 Transport; Mon, 16 Nov 2026 11:04:57 -0800
Date: Mon, 16 Nov 2026 11:04:54 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: John Garry <john.garry@arm.com>
CC: <will@kernel.org>, <jgg@nvidia.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <praan@google.com>, <kevin.tian@intel.com>,
	<smostafa@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <jamien@nvidia.com>,
	<kas@kernel.org>, Cristian Prundeanu <cpru@amazon.com>, Breno Leitao
	<leitao@kernel.org>, <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v12 06/12] iommu/arm-smmu-v3: Disable the EVTQ and the
 PRIQ in a kdump kernel
Message-ID: <avtT1pIptUUm23Qg@nvidia.com>
References: <cover.1793593923.git.nicolinc@nvidia.com>
 <325a9bb2908f4a163dd3a82099341dbac4ad304f.1793593923.git.nicolinc@nvidia.com>
 <87102de8-0abf-4d33-a43b-85a83ab29ac4@arm.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87102de8-0abf-4d33-a43b-85a83ab29ac4@arm.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005E:EE_|CH3PR12MB8354:EE_
X-MS-Office365-Filtering-Correlation-Id: 508fa863-826b-4fc1-feba-08df4414904a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|23010399003|36860700016|10067099003|11063799006|4143699003|56012099006|261022075727099003|261021121427099003|261021135927099003|261022105027099003|261026140227099003|261102123227099003|261028144727099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	vct+bDQsEF+zRqGrkvtmgghocmoCtMubzw/S2jMRi+fQn4q/UNk+m+3ko5ZB8y0RF1eN6wqUCwCZzAKMAPjTgiCaDk6SPOpj7jO64olLILrEXimQzi2bCSsfmi74qiSvy3Dab+FdoalKh+TO6K/G3KNGnAUVuTVgk2Bcf5jwji6a+J2/pRjrL6a3BVmO6rIw03tURXizqXEJpgzi8cK0P3CznPmOScInGF36UJoRI9HhVsZFTq+tsKx09LhMHwrZwTglvPaEQHPBBtUfiRJVakHtsEnz1Oqmxg1SFQQgVLlQu3rubYNAmj7S6nPeVzXln0QmrGeGaBVkiKrUr4MpCkXefGUTRBBPNdMFgcfpjBZ6TGeqN/EUrPB1Lc4lCUasey0dMQvzq3/1cQgqdLmaUEMxR94bIbFgHKtYbmNu3Yzp94egxXw1hWmkiJyvWeNOcSJqRjalY9bfF/EzmAW2vbxjDqFC+bk+NlWRZi3WL6vLYy/2kjoWTJYO4gtmqwedyS3wEUzDeR9tNbPxG6mCAFx1EQD25jS489/MM+7bPsI6Z/A47bO0mzQXUhYmwaO5D8iryZhi0bPpuRne4SQDc1t1Rqo3IB6zbz7jvxgWNLOrKeGbLJbhL3JELlXQ9UIH8C3hY+FVjzPd+zAi1SuagTn8Nwj50tyNr5nQay/aD3V4fcInI5uhg6dZBQEWcLuyLhQZJy83gkkloohw8RVYtA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(23010399003)(36860700016)(10067099003)(11063799006)(4143699003)(56012099006)(261022075727099003)(261021121427099003)(261021135927099003)(261022105027099003)(261026140227099003)(261102123227099003)(261028144727099003)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iIWT+qNL9yfW/Q5+H+g5Bd4xgkUFKqWjo57E54dSf4e0gO85y1MGMsCB29g0aRl6r0Q45eJ3V7DnikVs0bg7Q5FZxe3i99Buqhhx9o2iB2tbM7y148mqay6YrsO3ZnuKuFbQEZxO1tEQXwpsixq+4k7vaeodLW1XWzFARMULRpITbxzH2cODClNiD2czJWUqQX+54exIaPN7rw0Y8Q+4P0gLPFB8Vf5JCVPARnmEoINxfIZAg3gDHP2TRoAwarGACM0oND0pM2sHK4n0XCODr+kncXgzXNB+lPSfm1q7Z81sG8VsGfVU8NCShEM1ITUr0Nfs25UhgHE8u3H87EBNsDhnvUrU3tkdIFWt+OVdJmyqW9K87XhP9Oq8T8nyqbnV5aKehchPEUjWo1An+6/HCtt8SpHYo6Gmg1KYNIFp4cr8KtpkQNnPIUaoJ30+RLY1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 19:05:21.8841
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 508fa863-826b-4fc1-feba-08df4414904a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF0000005E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8354

On Mon, Nov 16, 2026 at 11:08:49AM +0000, John Garry wrote:
> On 11/2/26 05:19, Nicolin Chen wrote:
> > A kdump kernel cannot use either queue.
> 
> I'd say a "kdump kernel cannot use either queue without potential problems".

OK.

> > @@ -5573,6 +5570,15 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
> >   	if (arm_smmu_sva_supported(smmu))
> >   		smmu->features |= ARM_SMMU_FEAT_SVA;
> > +	/*
> > +	 * A kdump kernel wants neither queue: the crashed kernel's CDs and page
> > +	 * tables might be corrupted, spamming events, and page requests cannot
> > +	 * be served. A disabled queue discards new records without raising any
> > +	 * global error.
> > +	 */
> > +	if (is_kdump_kernel())
> > +		smmu->features &= ~(ARM_SMMU_FEAT_EVTQ | ARM_SMMU_FEAT_PRI);
> 
> It's less than ideal that we unconditionally set ARM_SMMU_FEAT_EVTQ at the
> beginning of this function, and then here conditionally unset it. Can we
> just conditionally set it once?

I see the opposite. Conditionally setting would need two pieces of
comments. It's neater to have it here right before:

	if (is_kdump_kernel())
		arm_smmu_device_kdump_probe()

Nicolin
