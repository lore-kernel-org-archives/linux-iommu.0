Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795668582;
	b=M9V78L5u5dKHoyPBDyIZhCvap992E+G9IhT62IEpt41InMe/5F4OsDmSrpXnw5V1gimk
	 GJAf+Go2k2Ky31fMFxEtgFFHdM/59PBGHE5FYvN3mb88mf/pYEruM598NyGvEcVNE+a66
	 twJK32NbZzyZV4mi55vJcsT6gwo7GRPDyqZpXjxKkBc/8HtiKvjC56KAnuoo3Wvj8xs9F
	 5mRkaiK6P4xSIRsbYREJ0aG8/iYpm8cykV9LWE48YRWG60lEZX9RdIj7ynJ2Ce8ihh05j
	 hmfxTR5paN0dtrZhFmckoxpt2gX+vBY2GXVe4Hju4cF3b88got5uqE94xm6ihYjLGig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795668582;
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
	bh=oTFo0Rw/7DHbNoZbxEv8LzJpx2dUQSB5cwVqUfkR7/w=;
	b=D1v6lQPQHGdAPo224Ax4dQcSyvJu+9BP89z2RnGX+xx+NqUh//30fl9F04DOgcLiB5St
	 5xknLvG2QGO8BSQcsvZywjL7S/w1y975LuDpYkcrS+XCWwGo3emynb2NqY7KlXVwNs1Z/
	 io6oWT3k6cio5xztWdvwaXtv5PfwTi9XyEON3+i5Gwb3l66gdu6sAQJz+qqKqjHnGOIV+
	 6tWwPyPlf66MFuQcSJOISyBzW3e/p6dj/9xhC/T49F+aqSatzUfCN+x2+LqDphJUuJOAu
	 37LNLKXyhbleCGMqA5KIhS9kWzl7ExpWzkZReUx3vzrulqah663mrIsRwoFUBQHQRGQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=twmqGP6P;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.12
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013012.outbound.protection.outlook.com [40.93.201.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A4E606A31E;
	Thu, 26 Nov 2026 04:49:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96A4E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=twmqGP6P
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jj91Enme/8nrPZ/A00TfrJ9+/3hD7TefVfZUBHdoUQn3mNBjbzl4gsxpwyxhfCQvtwcijyRXKYMtPKY2kFujr4dxFwphKogKy6mcGl62BJhGKETIYaAjNzYu1TzCbrdRdlT30iSoC72wQejiXTzazquJvgof+y4bmZ5LS00fZD++caFgcezT8f5dNBnhrKtsIhXPnBCxc+LInk6Cmkiz58its5/2iYe854ZNxNYavwxVoPkvkvcmjbVaMLxC0wyPnh+H2GiRIhoRlFHd7Z3CgqTkel8y3KseFb1soPGtcinnyAc6dpoQU/nnrFCZMyD0VURDicqbRB6ETu6GmcB+IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTFo0Rw/7DHbNoZbxEv8LzJpx2dUQSB5cwVqUfkR7/w=;
 b=bN5p6E/53sXHg4lv8EL3A2FxNqYDSC2ctKyVhP7mNBIjj0QPVbSu+VQQIMJQuK7nhWOCvIkBSO34QAgJk84vZnWZ9MkltlgJVzWFgaFSRkIsX0YYfT+Uxh7h7Ug0eUbUFAZ81W9Q/LVQPs9qjDXapeBImveHBbmH9qRL//CHu1KBVScn/4Cr1cTO48/chLjjoLPkph6HbQVHIyhz4hzWiWK6M7AKmJ/I38uuMe0mqNwNgoMoKgezZ9vLwZxU5iO65EIP+kqgdqKh3UDjj7L2+ZPBwB+7pgspsP7BB0eGukhSisw45y+lZBLcraaSMSh0xQu2qrs9ZhzZMfQPiEK94A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTFo0Rw/7DHbNoZbxEv8LzJpx2dUQSB5cwVqUfkR7/w=;
 b=twmqGP6PcNOjS+Z4BqGWeGugNCcrQAN15APlItt0CM9ln0Kc+qfR47SFaJ1ugowJeGFyBOFWTNGkVjluwrQYPj87PkLLk/du//5uQuXv5okxh37aAoi/Upvkr5OhKmffDjjN4p/Agu66QRczFDXmUCuPjqbV7Q7xrOyVBVl+SodbL+ynF7Q4VFVa6HiXLe/3ba0XEZeqLcAcnFvmEMyZfVVq06VueVXJpVHCqlbsyATGSSORgm0Mzba11Vjxxe7/tgywzO9MSugkvgisYk0Q/8qEI8VfV81BdGE62xEPFR9i/3sKdJjVpjgoxUNN66M1cFAtO/CpCY4zUhRowKkEtQ==
Received: from PH3PEPF0000409B.namprd05.prod.outlook.com (2603:10b6:518:1::47)
 by SA1PR12MB999230.namprd12.prod.outlook.com (2603:10b6:806:4de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Thu, 26 Nov
 2026 04:49:37 +0000
Received: from PH1PEPF00062F31.namprd03.prod.outlook.com
 (2a01:111:f403:c95d::f) by PH3PEPF0000409B.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.688.5 via Frontend Transport; Thu, 26
 Nov 2026 04:49:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 PH1PEPF00062F31.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Thu, 26 Nov 2026 04:49:36 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 20:49:34 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 20:49:34 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 20:49:32 -0800
Date: Wed, 25 Nov 2026 20:49:30 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
	<rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Johan Hovold
	<johan@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Mark Rutland
	<mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pranjal Shrivastava <praan@google.com>, Mostafa Saleh <smostafa@google.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<driver-core@lists.linux.dev>, Sonang Patel <sonangp@nvidia.com>, "Ankit
 Agrawal" <ankita@nvidia.com>, <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v3 5/7] iommu: Introduce TDISP T=0 state for confidential
 IOMMUs
Message-ID: <awe6WgoiKaBTgINn@nvidia.com>
References: <cover.1794343501.git.nicolinc@nvidia.com>
 <07ea92910895a2b0db33afefaa3a0ef182b2968c.1794343501.git.nicolinc@nvidia.com>
 <179563006502.253973.9155049351516451537.b4-review@b4>
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
In-Reply-To: <179563006502.253973.9155049351516451537.b4-review@b4>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH1PEPF00062F31:EE_|SA1PR12MB999230:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d8b0823-c4b2-47b1-a05f-08df4b78ac48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|82310400026|23010399003|1800799024|261102123227099003|10067099003|11063799006|4143699003|56012099006|261022105027099003|261026140227099003|261021135927099003|261028144727099003|261021121427099003|261026121527099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	26jMLUpKdNSBFVy9USpNlR957/ZR1LSGIBE7iZdXG2PdGtZfKM/18ipu8SJAK2qyW7vDXUQRKtt/WVi/sHf9McxV9b8YqY/3uu4vMNyYrNky0tnyJnnrfsLHc9Wg7muNedS6h5/QTS5FB8zMs2Bmewc2ywTKT4nFaeBcci31R9RAh5rarpFKJA6jYwYZvx0FzrUqxC3pz6rtsiccKpW7Eu2YWJuDGy7MJnqoSAOljn1FYQCfPD6k2MG6qDeT8rHh3kxmW1pUSA6wpx9Nihsw/ENPRGcYYH0pMpdeYJY9QmwhhjX8ftAvx3T/3kZeVamZ1MH8loUUqQX1BnkmRNvlFILWf036wE4xmp/b4HzO7aElCPr3HJUsgwW9tmmDDM/upFCsMJoNWnpIW+X3oqELyLVRk2tthcMJC31k4yh3iKZe8qr1oHSqTDVpDtJ6IsKUn1fOUTADdooTZcJbCIwN22dhPiCN0t6MrQlX35ebo2fpfPXZoh77/DhZHYtIBwaBAdu+P0pz3LSMEjHAf6ehPoBb1G65E4wjATjoSygk9m82WEIxmPvThakYIOLh4D+XjAW0QzUdF01nJRafCG0T4bUeKv3K1sab9WJHvWlUhh11PAz230tfqBwulzYEkSPQVS0NWjCBTSFT4lCArxOSOAEk3QtG2zhTNd22IGZK6Norf+PoIuTxEeursXz2LXe8dBcKG73r7QCSxcDRllQNNg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(82310400026)(23010399003)(1800799024)(261102123227099003)(10067099003)(11063799006)(4143699003)(56012099006)(261022105027099003)(261026140227099003)(261021135927099003)(261028144727099003)(261021121427099003)(261026121527099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6QAaRp71Z3MnLwKuj4bk5qoCnuNU5RPvQVYRUgO0ZZukpIap4yXNzyDRSX1+7pI42+Cd/NfSt49tFZ11nKnCYwHhH2ze5YCGgfSO+ppWzbSWaVfthHzZyYhlP6wnJOpailStmKBm0Ff8G93j6FYosiv8qdETllX6CPy7aVF3yzc3XWfEiUVWZ8xeT5VZrpthAD3nDJ4DHN5N+92aEqRUMKuZJ+M6GRTpn5x+eIJ8ta2EMJbuLqRgRkgd2MXjLCNJcUJeFycbWO2qFbaV5AlHnS+AYo5NzeLUphp10TWf73zVlw5En+mesoMnLDN4h16h3M2VBoVIcb7bhGOc7LCnZET6Szl6OPdavHj1YLlBP4ByfZTVD0tkt5zlTX06IuhdL6btcjPlxSrLMBj8q4Mp5oCZpwo2+pLWy01NjvJQrnyEBGeOi8x9eI0TNBm1Q/dC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 04:49:36.8021
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8b0823-c4b2-47b1-a05f-08df4b78ac48
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH1PEPF00062F31.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999230

On Wed, Nov 25, 2026 at 02:07:45PM -0400, Jason Gunthorpe wrote:
> Though I am wondering if we really need the ATS stuff. Why do we need
> that? The pci_ats_required() in the hypervisor should force ATS since
> the hypervisor is not going to construct a vSTE or use a nesting
> domain that would inhibit that? Can we just drop this whole patch?

Ah, you're right. It was added for non-pci_ats_required (non-CXL)
cases where the ATS state needs to be in sync with the hypervisor.

However, the justification/usecase here is pci_ats_required alone.

One small concern is whether VMM always exposes the underlying ATS
state or not to the guest VM. QEMU seems to do so. I did a test by
dropping the patch: lspci in the VM still shows: ATSCtl: Enable+

Nicolin
