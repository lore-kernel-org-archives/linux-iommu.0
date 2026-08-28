Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012006.outbound.protection.outlook.com [52.101.48.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98098376490
	for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 15:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787932323; cv=fail; b=ZVEfu0F6UuHjfCWtjBGKcl7bbBWcFZvjr3JFEFT/0Pl1hR96l9/jBJi3alQ+BIQGBZLmwQ/7iNV88WZmmlAqHLSPEAFPX5lOfpikkFuzVaFjWp2fTmpLDxpRt8OTg7QfzaiZa7+g63txk2ffbwoPCPHjalDJg+vBealIx4dARA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787932323; c=relaxed/simple;
	bh=4KM40vTqajdC/nDeLN5w3uKXz8b3OFqFmKoPRQ0+jyE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aIQy0Z6zJee50OyVwekNoR8VIbdCUW1O5a9qyC6QAiX+s+9rHSbLTHCpHoCqroc9S5vTlxsadcbeCOEVcV3qvuIxDEXLbBuWcIAkFUmc/pA50BB1PJ+kzTXyBXjdvMh4+vj5SNKvS5Ilv8oGiwYO6JK3dwt/bqYtFWTWUKc6T30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l2P8szl1; arc=fail smtp.client-ip=52.101.48.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l2P8szl1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZkCs21mtrfPcl/l6kXE/LEwatbiKbfz/IrIKd1EbxVpKrfokpjgFtcKiUMcGWQV2hh3LHGlmAeeE/UxrcrRXe4wCU6nH269LY3Ma8giGPgdVqLW4avpIcTdbM0qDThp0F5zJlagzpJOLxhQPwlZ3JTxK3IPQfBk9MWlGudXXIG6HHuWJmJtMgJkSl6ixRw9jMDhQauwoAIh3rnQ+UsFhTSl/V9oUKcOXdPF7TX4tTGwBKmwuO2Lsiiz4jnAGBiqHBo8joHQqf6PlzlR1xq3ukgLZmcsQ6YUICjzBgWLr0Hnuw2KBxU1HIQB9Ctgz2fgQNT/hlZIt9RnaC7L6RQy16w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmgsPmW3iKnKr1pRc894hOmrT/H1572O1cUohF59kMw=;
 b=BcrNLg2kjMvtg9b4RkczNzVAstDo3906vIINp9XmY3dtw6ukNkDsX/rRCVfyjmZ7e4/QXOAI5XC9PTh6vw1ELjW0xjfeutgaPhe/LyvM49cb87yuUILFnVbg0E5X3GsGLM92PtdCpQ7M+iys5i+YkVcF8jWq5Q8g3dxZzDMSFGzdcLwuycF+wY/eoUaxoN73ahY+Q4gnGeAXTm/GjpmmkRiBajEKZ7rslqDxgMD3P1oKmDlzJC96+dUKhRz00mZvfBot/LzUUlvsGR0qUanlNl5Yq/Ycl0vWJqBkm5lq/PpTgeW+M6bjBXUXhUJl4rC2zr03fGiVEsPuARzslz8cuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmgsPmW3iKnKr1pRc894hOmrT/H1572O1cUohF59kMw=;
 b=l2P8szl1xHfpbNIWnCfXMXShG38s0EwxPYQ1c1Ny6/72/U0mgm2ISlsIJT8lmfAwvtXxlpIri1GZV92aCCmcse+Mkc6LG7AnKcAP1bWfr2Rdh+K4Go+ndCAa2L+SdbiJcZ3z1yW6s4HcS0vayOLs6TxbePhuTSyLXXsZNoqOVwY167DjiLon3IS7YhYebX8vF7JEH/Jw8GRmvIqHUeayMCxxxJj6cc9h8Vf4PW2HRcW+VMO1kzE6jpwLD1cFCD2dE4ZvRyj9CGhBg8RS6CNZzzA6AhQmcW0uuHS9cRS6Mc6P2klBJIT5mUcYqCnpKSES6f9XzCqoWsOgVw9ktJ1F6A==
Received: from CH0P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::34)
 by CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 15:51:55 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::15) by CH0P220CA0017.outlook.office365.com
 (2603:10b6:610:ef::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.11 via Frontend Transport; Fri,
 28 Aug 2026 15:51:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 28 Aug 2026 15:51:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 28 Aug
 2026 08:51:18 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 28 Aug
 2026 08:51:17 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Fri, 28 Aug 2026 08:51:17 -0700
Date: Fri, 28 Aug 2026 08:51:18 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Mostafa Saleh <smostafa@google.com>
CC: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@ziepe.ca>, <praan@google.com>
Subject: Re: [PATCH 2/7] iommu/arm-smmu-v3: Prevent rbtree corruption from
 duplicate streams
Message-ID: <apGudts94pqFL20G@nvidia.com>
References: <20260828125409.1921538-1-smostafa@google.com>
 <20260828125409.1921538-3-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260828125409.1921538-3-smostafa@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|CY8PR12MB7705:EE_
X-MS-Office365-Filtering-Correlation-Id: f265d673-5bb6-4ce9-0bc4-08df051c4789
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|10067099003|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	y1rBw821mxY2zYBx3dw099KH4PqiqIInOZ4dfWDVWZbR3kQsTbn5MsEI66ng24oGU5qX7CAId/r0ZU0bo0hLrxSiBopPv70vp1VwfBqR8nxJ3GHjauLYU2zYqo8xOrSb+ro0R9LjarTSKew1bQkxm3xXeOYqkZmCZFUryH23bXOVCEKYHFAKsttYwh+KqdKzV9cUI+Xn1eW4q5E+BGyI23vQb3VmwyiAO9rz29OkgaVTTzCgv5xB6JRItRzYO8XAiLLVi9wkB4qoFoUS/Q9CwsEhP4WTOvvyUlMJGijQfKE+tg0QiLVPY7WH5JAZ4jVLEpf+UIA5d2zfyflIECm2wLEUn9SW8RMoUQaP4ZaGIpUzeASsizKBLL7xg0H2CMefttTdVpcLZZJ/gUVxG7KHuQfzp+VeJ0UKboVQ2jjFrHePZqmve031AWzafiwdFATk++hjpd5u0v6V/9XDD+rUYNybdTnEP56c8MV2GK7n4ijN+dZwX4n0L79X2TEYgyj5J1J3Qk+RuLjI9xTWjpwY+FxazuTAzc+2RxRIxFK1Alzt49BEy1aGj0t6wiuWopjHNv0+0vKxQLogVxOFBh//LLAOlJgNN/6kmwlnGo05HEi6HrAUeJuHNvSJ4NF/2ACJwC8JNhKrr0OsDrOMhurIR5YC2es+I61sUnZyqj+sIvXa/5rfemph5iL7ZqOklns0zCGnpJSYQ0KgO4epsgNkKw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(10067099003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7eOhTPLg1cEgD403fDj6f7g1ssBBUmqjnpg2ouw6yFJmvUY8c75+rB5h8RYFbF9pF7pjpxJZlE7J57wRhCwF8WdgxHvT5IpI/66gCYTxk2lxhBwHrpouFm7TcjvVdzYEA9zXEjZaTxsOfX7lVxmKXzlvEf++PEVCcQdAx5e+PNFbvolJbw09O1eWTYiKoYDhIlhxI4T7xju38ypL+C4pJHJqQLw1fBsHraKNuIKw425CFusvHvX2HdUy/OmRkEuHqyB8S5z6Hd8EwsEsooQorrwzx8tN+ij96Rd2lWaV8LeMq13VQUzrvMF7I17Jvagv+ACbqf+wvxqmQhZxomQPUSBJvOsU+cxLdqw2ZqWiAjK8J1/cb6iENBsSgXhNPOf591U9gx05IJLiMfq2jwcC1n0EgjmzrC6dlkorSon0hBqZMApOMXI1hdJdafaB8Kq/
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 15:51:52.3895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f265d673-5bb6-4ce9-0bc4-08df051c4789
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7705

On Fri, Aug 28, 2026 at 12:53:37PM +0000, Mostafa Saleh wrote:
> In handling PCI devices with duplicate IDs, arm_smmu_insert_master()
> will continue the loop skipping the duplicate sids insertion in the
> rbtree.
> However, in the error path of arm_smmu_insert_master() and in
> arm_smmu_remove_master(), the code loops over all fwspec->num_ids and
> calls rb_erase() unconditionally.
> 
> For the duplicate streams, the node is zero allocated including the
> parent pointer "__rb_parent_color". That means rb_erase() will think
> that this node is root and it will corrupt the tree which includes
> other masters not being removed.
> 
> Fix this by initializing those nodes with RB_CLEAR_NODE() and check
> if they are empty before erasing.
> 
> Fixes: cdf315f907d4 ("iommu/arm-smmu-v3: Maintain a SID->device structure")
> Reported-by: Sashiko <>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>

I submitted a similar patch a while ago :)
https://lore.kernel.org/linux-iommu/9136477b9c737a50cecc38f2ee6704a01510169a.1783044582.git.nicolinc@nvidia.com/

And I think the fix tag, as mine posted, should be:
Fixes: b00d24997a11 ("iommu/arm-smmu-v3: Fix iommu_device_probe bug due to duplicated stream ids")

Before that commit, a duplicated SID gets -EINVAL and errors out.

Thanks
Nicolin
