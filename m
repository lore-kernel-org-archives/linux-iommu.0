Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795722666;
	b=XsDspweu9RZ1PbKbvY0CIj/TFEnlKKhRLgFFSHwQ7XteM+zE/8CBNw9xARXpJhV0Sf15
	 4Cb6IF4xn7fPVZX0/s1e/8B1Uvo5SUZOBchQvTQ+BoDK/dngzX4P6a30b6WIra3bhO34X
	 IS1pry2je0ctQlFWVzDmfslrZZz+jJEe97/Mb2WeyH/LdVUuuQmncWxMAEd2ldz9W58pT
	 9YjR21ms3D538m+GDff2bqPkMNc4/uIV8t2yxX9+xTdbQ1BmujAt7/xMgDOuC3yZTx4FE
	 N+66aVoCVSkR9xD/OrXxs/u+OMtAfeLllwlRqkhO/+Y3FPjvePZy+Tc6ILxhH/WuaCw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795722666;
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
	bh=q63NcjbuRTVNOwwsmo3RXMY2ftTuAGnWYAIoAowWDXw=;
	b=1PfinH3KJOuRvYXDYy232A4hJFp4dBxzENYRybMpmud/POnouZaxHXksrow6xXjPjEMx
	 eMQZVe/kJxVJ+MbsW/F5yP8DYS/B/4R3mKAEObVvCJoVQcMhjtbLCWwD6h2/jgYUANM/L
	 Qhzn84ziN4IFnuSeJs2FxJ3lmtnWOtu14uF6XQv8mAvap8Dqyjz5XQaBAS9tfwubgKQHU
	 fMONSEwfvVy9xq0H+4QtG0uQ3u0s5rxtT8927U40E1S3cyTZgaSOFKnh4+UMTQRdz/mrY
	 m/5V6dTeaDryvyOM7SqcxoV15WU3tlaW1EdvzjUXpjYEwPzYnfFjE4BP2mGYm9skluA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jQYl9x4U;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.10
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013010.outbound.protection.outlook.com [40.93.196.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0D0606A326;
	Thu, 26 Nov 2026 19:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA0D0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jQYl9x4U
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QnCRwpUaV8nz7SaM61VmoRaOGwpGJ05cWUqA40MQVOVWGFHhTSDbNrbAF04jUS++SxW+bt00zmk06Osl7WfqeVeCBtzaaItBSoNbPhkkYRkYGZbdSAAQEL3BDAGz2jwRJK5TjMJYQQXSTfV5Jf8lvDztkm0tws3S/JS8gIEAjG8RMpC4Kub+WGv9t965cBnjZF8zXot+jPvNsWIJTcEHVZc/CXd/0ZCF8K/JDA8C8xs+xxkY+w51UFcAk2BnGwF4EDLsn9AlkOWBVAMH+EawJUh8eAoiUAko4idTglvt9TQ9KIQBuZ5vi8qr2Kkd/SOuwb7pYfU+V8WtDWhHUxQvuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q63NcjbuRTVNOwwsmo3RXMY2ftTuAGnWYAIoAowWDXw=;
 b=lrmOsQ/plgQ6PM+0kmSnlBjP4Prtyr5Hnitje3rZriFT3EwBcXvRk3VBasaqsgKuyx3DBx0odoPLdzxw3uky4Uoyy4lGbXhBZ7UE9BK3qNQt/0Z3F+jf6kxRqr0LkpL21yvHJa4b/wA5yFMs9YDaq3h2GJ5J6SmMMMd4aSUfpR/b0+qz1Qq4uM+S++oid91cdLCtsWSKHDiFdogNb35nOBc6hLQCBHR0LnEhSk/HVzS4xL5bPrVx+W8y8jSos/+SiY8az75VFh5QaY0OAeNhpo9bhKLE+9OyCck4ZPnmlVRzFNqKQfwTGAaCvnKD3ddLCSON3I5+IUKA29whrez+dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q63NcjbuRTVNOwwsmo3RXMY2ftTuAGnWYAIoAowWDXw=;
 b=jQYl9x4UaS5R8G2iFSj1NP9mUULEYfSnWPqU64tsvEIDKsKXh34yGhVizNJBY2Ln1dW80XYwer3W7PvAwbnijvb4EjOhewEn4c66xovGPJg4GQmCW3XYbTxeIid+EMeAGMrWYDRMt/oHsOX30S6/SrqCAPObdWEcfxAZnet2JFQvzEmx4rK1n+O335o3v5W5713b8563gxlGcPrjDZh+mxrn7w1mZVhui5lJj4uxrCdgXH3MbL5akNBTYzWnFIB30+jjRGfcwAmVAWp+V1STP0n/FRw6vQrMpmewqTABA7GUMVIMmvLsPO8ZkW8f1Suowk5a3mwjAkSYpCjeHrhNAw==
Received: from BN9PR03CA0328.namprd03.prod.outlook.com (2603:10b6:408:112::33)
 by AT6PR12MB026552.namprd12.prod.outlook.com (2603:10b6:170:116::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 19:51:00 +0000
Received: from LV8PEPF0000005C.namprd02.prod.outlook.com
 (2603:10b6:408:112:cafe::48) by BN9PR03CA0328.outlook.office365.com
 (2603:10b6:408:112::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Thu, 26
 Nov 2026 19:51:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 LV8PEPF0000005C.mail.protection.outlook.com (10.167.245.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Thu, 26 Nov 2026 19:51:00 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 26 Nov
 2026 11:50:59 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Thu, 26 Nov 2026 11:50:58 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57 via Frontend
 Transport; Thu, 26 Nov 2026 11:50:57 -0800
Date: Thu, 26 Nov 2026 11:50:55 -0800
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
Subject: Re: [PATCH v3 6/7] iommu: Park TDISP T=0 devices in the blocking
 domain
Message-ID: <awiNn1APNeSba9fC@nvidia.com>
References: <cover.1794343501.git.nicolinc@nvidia.com>
 <6620f49a3bb96837034aba24b5131a9d8c7eec8c.1794343501.git.nicolinc@nvidia.com>
 <179563006502.253973.16635562157369118727.b4-review@b4>
 <awfP/IZxaVA7ET0o@nvidia.com>
 <20261126150143.GI114472@nvidia.com>
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
In-Reply-To: <20261126150143.GI114472@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005C:EE_|AT6PR12MB026552:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d050971-72fe-4acf-7880-08df4bf698bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|36860700016|1800799024|82310400026|10067099003|56012099006|11063799006|261021135927099003|261026140227099003|261026121527099003|261022105027099003|261028144727099003|261009223027099003|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	3vZcRzl+2d7etERuIRUAczQSSHVSivHA/1Xo+v+pLfscopLhbbc+z888X8n4Omg1KpEgGR5ay9qzsGklsJ+1wdmwaNYyBaRiq6rW/ddVA/MvprKmjbhu/DH1rLUbahdRIRw4sSyVe7uPmFsZoleoPkX8iyAhFDVu4uMQCtHOx88HHm78zSnIhpWt9HQe1mNF2SHY38L3YlG1/oCna0YHv7V2b/mjTw9vYCz7Vs58ckmPj2D9zuUfFECh4Jyr+vV6FfguOvGVrOqB2CasEf4eL8N43lCleVMwWxfRNRe5MZhKFGV5Ws7xV0oTzssidJ8pKmZavqRjtsO3yjVpM955XR9G2a7VjYO4dSCIWJYtVZ+xj39nqkPaK2vaIDMEr+8XH3D2C2P4Bchxc3U3acngc/fC47di33e361MLv+Wadu9+/yQpaQJ0d4/FWdoFgaWPXMwtl/XPWVQG/HW1bf9t9ksAlG7JpsL5oTvVPy41FGy8tvSwwChFLA/JrIuan7IilxL5l8olbEEOt6jp9cIUInEk4UtnhzhPgzu3oRYNToviPugMM2WJfv9bbYXI87yZ1exdpbaj8pne/hcEOUWObUq78KTho+AfKn6Jn3J75cG7xlPqvSYmZuJoTUnSL+sUmG9b6/CI16qowQgc13R5n4MXJsyB78JZcZwblyHiExUuFNkmkDustmhf+hYulXe9xLjuqRBL4CXKFD7awtrvlQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(36860700016)(1800799024)(82310400026)(10067099003)(56012099006)(11063799006)(261021135927099003)(261026140227099003)(261026121527099003)(261022105027099003)(261028144727099003)(261009223027099003)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RxrhHNCqo9WTEnQwctB5ccr7ZXm062bx3ZYvKRgyWhWQwmz9s9LXot8ij7unuPjA/RC7I6RF0Gx8K3r20wLZDFpZAjWWe3BGj+9oKk8IeGq/wOACA/Pb9Cf+xHfbbdIh4X7yCdx5W1FNGYk6aXeE9M/GIiMamo7zsxUvAbsinefvLz5yR4Z3cDmH8hBCPySIKQZfzQ0Eu6GL3HJK4SJKywnIb3P8QCTiGqusWKlhBJZk8fwERaURozEIM80K/Iy5+ZERlbIMm6iAIcBBOwkVllYfoBNh0kvuF5B8O9+xPIwzXlab1bU7hOX02Kxbpcm2E07KbPEEEFDAUFNUOGSsN7oi9u8PPabHca67rpG+FEcSc8jv4XxQ8rO0sC5aFCy2m+9wd7NXV7j8179H2bgr4ESv3MrFspWl84CE6Nbqvjp7OQEgr2SRtm9mkI2NtzVz
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 19:51:00.4651
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d050971-72fe-4acf-7880-08df4bf698bf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF0000005C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT6PR12MB026552

On Thu, Nov 26, 2026 at 11:01:43AM -0400, Jason Gunthorpe wrote:
> On Wed, Nov 25, 2026 at 10:21:48PM -0800, Nicolin Chen wrote:
> > On Wed, Nov 25, 2026 at 02:07:45PM -0400, Jason Gunthorpe wrote:
> > > I think this patch is the right idea, but it should probably be
> > > removed from this series for now if we don't need it to make a basic
> > > trusted vIOMMU work.
> > 
> > Without it, every device sets dev->iommu->require_direct for RMR:
> > 
> > 		if (entry->type == IOMMU_RESV_DIRECT)
> > 			dev->iommu->require_direct = 1;
> > 
> > Then, __iommu_device_set_domain() would fail the first test:
> > 
> > 	if (dev->iommu->require_direct &&
> > 	    (new_domain->type == IOMMU_DOMAIN_BLOCKED ||
> > 	     new_domain == group->blocking_domain)) {
> > 		dev_warn(dev,
> > 			 "Firmware has requested this device have a 1:1 IOMMU mapping, rejecting configuring the device without a 1:1 mapping. Contact your platform vendor.\n");
> > 		return -EINVAL;
> > 	}
> 
> This should be covered with another test if the viommu is bypassed,
> not by messing with require_direct..

OK. I thought skipping require_direct could be cleaner since we
would not need to deal with every require_direct call site that
can be easy to miss.

I'll add an iommu_cc_viommu_bypassed test here, and another one
to the release domain path too.

Thanks
Nicolin
