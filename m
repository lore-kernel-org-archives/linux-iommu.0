Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011069.outbound.protection.outlook.com [40.93.194.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87832F747A
	for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 16:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787933683; cv=fail; b=Posj5fNjY8cBEo48XWd4JTq/ZvivENVZZGNaxAhP964mKxRgCxl+l9IJ+iSM20E6liIU2kxUYIyMzSPhZ1kbKx/BB69bVNPhiXAK20dd0hBNKFvPWuN9M2Bd0wM5qhy5Xtdz6CZtQOwQupPjpUt0VOaNu3tRQgaTxyRckfaKibI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787933683; c=relaxed/simple;
	bh=uF54GWnL7eY4elMpLEV4BzOuFuoPnPsPGIRovAESsPo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r37I5YOdslTj12YCH1K8Fx//r4Gif1YkHMz6C7f95XoZgZ2K/uNcsf3Hxr8kJZi+8Tkvcnb3tz/4m9XJB3ftDDtrKGgLJuDUGQofSXCIJe6Jhsngqe7oStIRL+Y2qoTtJRpKoUi5CuCP0CYYH6JrJwT/BePf+IU9TzBJ3usTfz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=somCYBQK; arc=fail smtp.client-ip=40.93.194.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="somCYBQK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O/YkgYnOJ7hRH1crn5tI8U4fxl7ZRhBS0Ix0cOAKaN1LuoI8TUsoBgWNlAa+VNEYl1eca9k4CaoyHbkIUwkeRNxyk5FdTKTSw4vBoUXuSS8Jyj00OIKCATa3yZMdLLyjb5HFxlhVuPCuK+6Bw3GuUNKmM5VmLNKi3OFW3ZDvDcxwZXTxkwgSSH3NwT1XfVc/wHtwrkgIsDRHyAPvI2lgOgQTdLolwIkIQFoBLpFWlLreSk4KqJbWE9MNeQcxKY4WoK6ZZTgwCOrRYrnV8DqoVqqS8QKZj7Jz2tNims3XQDGbYGNqQTZvhDotnNpTX/xqmnj/Fb2ybYlMQQnZuYOVlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSV0od7ACinm8gsz6oh5IkCznLcgn4BRfGrVmXROI4I=;
 b=yOhUOirI65SPCnCJyrnzy7IwfxAiGgHRcIEtbwh2VT1JDtHynmK5baJHIaNl6dnf+dv71dIOE8nC8qV9XPC93UCtwThuOVvwRLxUu9zg7HQZZPUVYD4Vhp4QJg4NlqcfcHGs3EGsoXsGeG2X2Tn2RpVH2/N0D0CVPJxHIreAePWzZ0QFY/tCxWdvvLCnlKRJwnZ6zeSgiIOj5N0KlWSFgNDdWvUqp+90tHYJgJ/BzZ+AnHfuDPf60GxuUYvKGekPrGdxiT62iGJOHAIJap8P2nnzKf0wfreMUtPt2vgxmOgWCWHc0Cqxill5CcLWeCg8EJyKnd4ZYhIQW67fgXDzIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSV0od7ACinm8gsz6oh5IkCznLcgn4BRfGrVmXROI4I=;
 b=somCYBQKpve+/iSaAppHiC2+M78jy0C5bKztGTYwJ+/BWo1dRJGS+042k+NCrgiRCbuxvX6YtO+y5u+9iEOJNMuTlaUrlHA2k3MMVgV7iNxTaOpzrZFkFGfjWRcXh2fQjs42h5TuzgbDEQoJoIIe1Zlg78M8NNTeu6yFpKyZqFI4QJqWfTw5cSohklrZVdbz1eNIFkoVDB2GSrNIS03JQR2l2UiBjamCyZfiOSHiljrKY1fPs4yZwD1biNLwoJ4Oop8Y41lRmjAMRRNmxmcnuKD5GqbObI0dlEYVFC+GPhFMvUJbnMBNtU0wy9yxCfXZkFz7WZewzNhSptG7riQe5w==
Received: from SA0PR11CA0018.namprd11.prod.outlook.com (2603:10b6:806:d3::23)
 by SN7PR12MB6958.namprd12.prod.outlook.com (2603:10b6:806:262::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Fri, 28 Aug
 2026 16:14:35 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:806:d3:cafe::92) by SA0PR11CA0018.outlook.office365.com
 (2603:10b6:806:d3::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.11 via Frontend Transport; Fri,
 28 Aug 2026 16:14:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 28 Aug 2026 16:14:35 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 28 Aug
 2026 09:14:06 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 28 Aug
 2026 09:14:06 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Fri, 28 Aug 2026 09:14:05 -0700
Date: Fri, 28 Aug 2026 09:14:06 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Mostafa Saleh <smostafa@google.com>
CC: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@ziepe.ca>, <praan@google.com>
Subject: Re: [PATCH 6/7] iommu/arm-smmu-v3-test: Fix OOB in
 arm_smmu_v3_invs_test_verify()
Message-ID: <apGzzm+O8XfCQRLY@nvidia.com>
References: <20260828125409.1921538-1-smostafa@google.com>
 <20260828125409.1921538-7-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260828125409.1921538-7-smostafa@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|SN7PR12MB6958:EE_
X-MS-Office365-Filtering-Correlation-Id: 440d5c61-1f3f-4c24-f744-08df051f73b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|18002099003|56012099006|10067099003|6133799003|22082099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	lZ8s8NRV2i+8kP8S+KhSqTMcQsFQhS1Z8XKghX2HggGL24ES3/+avVdC3CH9uxEUNsfRSQHZ0l/8L8zrgE6L+/j/7DjT/B4QEP9EhWUrrplIgJ/rpZxC94vETZBjH6a5DW89QkrnIIybvUwGkUoe4ImpB+yaNCT3tWkfpMrQTISIZx3uWVRHmLwsGx6LM7PW9CvN9J761XD9Au5nD4QLdwcnBap3SV2PKs6uqCmfHxmnQRts2mgDtxztBGjdnK/Fc40oTJRp6CTdwv0Y5ZxCkRJdEmcaKWCACIsJe/KphiTetTKEzLE5ffwYXJL+jhbHt//zzw/wJm4C2LG00SLGLnWzXNlNPSJqO6Y6Qn8OeQdzNafR811zifSzqAsM3Zmnp1FoQSs3n8W2r5VLasspvKIS70DNIQ2pErHOZlw24cPoXIP1U5rol3P6SWoLnZ5WpdEO6ZG4F/MMRDX3nbfawaQHIEf09EOjFQdmorkL6yQK+6L91rBNnK6ULsX5ffCpj/WZMi/aM8P+MM7EK6yQaIw0SQ4f2xdp04se3K1qUQYeDZOAW1TS0fEuH1OZVZSP/1ma4oLQ3GrV/lgYDxmT75K8lsWLpfQvymogzlASdcBJ8WBnvH07jTp+XhsCTozAxDkBqvmAGMyRADN6sRgacyxmcqz6RmkgZ3SMo0t88rM2NiCyIBM9to831zKYc1hLQTsuSF/VEMT0+7/ffDARpw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(18002099003)(56012099006)(10067099003)(6133799003)(22082099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pZVeRyhorGFjwxDK3QPtNIww3EAVsOl0RSaKYxYpEZXzVa+dcweTiijEzIIWO4niJxkBXbsaSJJAHNiI6i3PuYruq+yOaN6h9I+FRyXaMACDG4y8tZEW+INJ3rT4DLOfCt4doUKSI/YH3RuA007DeW6XzTsfNhoGqHiHaGz704VJYvU/kNKKTfctv033GKgZ/4oC8MUjrIHWS5epLFvYi7BYe84cS2Vvt0hJ6XLV23MPYzQ2W/QxrYYeICjBLfDTbu4mrreirQlFnb9QYK7SBmy93OylgUNCwoldYqhgGjo71WhZSD56FXtH9EcTGgFKnCDXr88Sm7uxoJUVyV/rfBnMlisTS/0wc9+9nN+G96dX1xB21eJuozGT0R9MI+Op1LT/erjCWDQ8BcY/Yd7WjzFsrz1D5beX4zVH8r7iOG2bjdDmSkT6VxRBwHoqYvN4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 16:14:35.0967
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 440d5c61-1f3f-4c24-f744-08df051f73b0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6958

On Fri, Aug 28, 2026 at 12:53:41PM +0000, Mostafa Saleh wrote:
> arm_smmu_v3_invs_test_verify() validates the array bounds using
> KUNIT_EXPECT_EQ(), which triggers a failure and continues execution.
> If invs->num_invs was smaller than expected, the next loop over
> num_invs would blindly read past the end of the invs->inv[] array.
> Switch to KUNIT_ASSERT_EQ() to fail and stop the test on bound errors.
> 
> Fixes: 15a2a5645ad7 ("iommu/arm-smmu-v3: Introduce a per-domain arm_smmu_invs array")
> Reported-by: Sashiko <>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
 
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
