Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012031.outbound.protection.outlook.com [40.107.209.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3512352034
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 18:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779992127; cv=fail; b=RqUw6lkTW+B5q/p9DROfXjtHOMTc4chTqcRxZuGBIq1BT1Bw5vkQXXIGme0hNkOd2KRIh9z1KEJtefCXZGM3GFa/AvKHBjwu79lCIKpcfZ9I9CyqQsL3/cdSRPbgq/Igm0JSZLr9AK3WF/8XzYNtqhH9cpfz/UmnOgMMt1aYcig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779992127; c=relaxed/simple;
	bh=AYdC4fQXyo/37jkJk9gQLL/YL2+9ZCjtOo8W3cxezxM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQgHlZqMd9H9ao/Ku5E7rvSHkTlj/v0HiDRZIwEiBl4NXQ199J6inuSwR0WeUZjZwR7iWK5qrcFMN5ScOPGrIpOi/U5/oJj3UMDr78ZAiiQlsIl1i2sV4MFqeXXLZUhb/VGBLv01Txp6EMLmsEQJy1MuFE353Y9Zk0LkJ9DLC8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ALGual8c; arc=fail smtp.client-ip=40.107.209.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ALGual8c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=foyiqaBtZJDIlO/n4odJWtoDYKeMUBHaQ/Gx0s4X91r0thsvsAQNkrwUNZisqF5kPNH7XVsaBq5PanEQP3WZXyhINKNzwF38YU/xkoSCQLC5dlQYo2I3zdPT0NXgLNlMwzCes3s3RbcmimXuDOpsdBkGSm9yS9KiZAltwsNZQMMuDSYtQZ64PK4ZeEDdEAqGMlCNd1nQcQLkcw9VQR9FZJurK1LYdyXTGIDWigm4XIi8HJP5n8JW80NMsM18d5ikt6NJL8FpxdpMCYjgOvF+yrNy2YqrhtVa14RMhnqRcKiUxomBkqrJLOT1oVEwqhQC/IuyoChHLETdOr7haJIVbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLrMif0UGwQI+RGVPDKk/rtTXelEVd/ce6YJKYw+0D8=;
 b=PfMSWxEDAnfH/49g8T921zdvNHtQGLCz9Fd9F4AWrLFrKIWIKX2uymOYo9/8aSCeXQgV4g2eba5T1qoqt3GMRlWhQRKJjD4ED7zdF2ZR9JhrAa8RvaxOjCvxqMcL2PGW2yfkKeDzqe/j5JeQMPEwGV3l25BvNBISk6xE8ASBhQmZMi1WXLvNHuzSpCRBgELI/jAkwdZ35SyEDrCJ0hM+b0OX7gRxt3TAaOJC+xgP12e3P1t0jxhC7snDKUHLReVpzM+sB7Wsuf/YuH9XLT+KXCZh7Rde9GkUvhGLD5F+18d2AiSUDJBV9uudflf3g0y6rvA1SJrJrXNxoWxNpstZCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLrMif0UGwQI+RGVPDKk/rtTXelEVd/ce6YJKYw+0D8=;
 b=ALGual8cYiuJlHiC1RjFmg1GWrk9cNHmfO4Fw5nhW9EROHM7jDvDL4JypwEInOJmQjPC9Owb/un9oCl0BhMWawiOO8i9/LLLzJi/BwA+5LZzxcd/CfWUzswz27WhyQzfFCvVAHXVx6y6a6h6Kv7/V34P0bpaKtOlstPYeiE3pMjxivdMkCjZyzIzD/evxdYq6zT7XUvg56KfE31yrXOpQo9Lfbo6hE6GSN4O5BWEiS1I1fmFuoRGJa+uA7GguWonkRAyW6XvBHzJ3+v9De1C5Bc9qOfOLeV+AVBLo3yzJow7RlA8CKvhKMrzP6MtQrAw8foO35DtpIBj0dMUWHko4g==
Received: from SJ0PR13CA0082.namprd13.prod.outlook.com (2603:10b6:a03:2c4::27)
 by CH3PR12MB8880.namprd12.prod.outlook.com (2603:10b6:610:17b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 18:15:17 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::20) by SJ0PR13CA0082.outlook.office365.com
 (2603:10b6:a03:2c4::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via Frontend Transport; Thu, 28
 May 2026 18:15:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 18:15:17 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 11:15:02 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 11:15:02 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 28 May 2026 11:15:01 -0700
Date: Thu, 28 May 2026 11:14:59 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <iommu@lists.linux.dev>, Will Deacon <will@kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Daniel Mentz
	<danielmentz@google.com>, Ashish Mhetre <amhetre@nvidia.com>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v7 04/11] iommu/tegra241-cmdqv: Restore PROD and CONS
 after resume
Message-ID: <ahiGI5nXCeceMngD@Asurada-Nvidia>
References: <20260527221407.1756491-1-praan@google.com>
 <20260527221407.1756491-5-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260527221407.1756491-5-praan@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|CH3PR12MB8880:EE_
X-MS-Office365-Filtering-Correlation-Id: 543ade33-7ac2-4db6-4def-08debce51245
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|22082099003|18002099003|11063799006|4143699003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	73005ET5xL50vEOMEwmyimicvIxBPg4G5O5fy684ewgt8T5RQRD1wKjvJApClwel/mKNYIXGaEY53fgaS2lCrEutnATpdVw2kijODq4PCw1bOqc+0Qj/IKfyQXJLnuI3rXKhi1roskWctgQC01quVfkLrVPLlqMgpSSKlEH4P3MLavX43HGVhd5xFquGSf4HlOavMHNs+58k6TAsjYUs2Z6IliDvUrpX7TvGGoyNAM84fUwdmXcRkExw/nvt0MmL1UOGX4Ik8DJSMognTfA0KuqlwCMGQgHrTvEaLc2rsHKA1X3AFIvzI/xb0aLZRvAFvhjCDWQzD3pUJdfYtrz1BvjC2Y+TCap06Dm1z6jItsMjIMgkzaEsviofZ8bk+03U3Ws9COU+a0aEtFD0GOlWirk2ZjBKeButeQD00ogQ3gdmPfUqsQpPmltR4unitMa2HLxKWhQCA+sCQnZzlDDXM3/R5GDEBOiWmSXStqJsdRcryZsCHoKEqDMymWhlQGk1bzwkF7NuMbtjSkJq0dc07oN0yNrKzE5TYcnxm7sgvVfmGsIJ/5aJ1Zxi1BR3yTLls971Iifq95O1LZKcW4jlCl1ZisD4ESJOCqept5dWfBtiZCgHX3xRW+gitrugIDacDjpmR3FHvCE2hGDyfrJWX/OSHBjp1cQbS6CHljuXzf4IQPmeSllSqvKsHeviD//4zrvWzAiauwWJ6V0WYnv2DP/aj0eUzlk02NfYj0GqfIk=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(22082099003)(18002099003)(11063799006)(4143699003)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ROiZXoNRSmxUu5l1C/RGW5ubOl4CB/UtRUtB4vogvG2ZClTjOA3D1ygMBJXQIswpvSyrdWmfkRKPVjViU2bKct9+3a+OCtdPawf1NhOrTANzP0U0vWIhduxbcfDr+ctlekGalNi/a8fgI53PRh//iYHIyWi6eJisUqvbAhFBIrwSU1xL5fi8xDViYPFTASz3Fr3JUTbkiPW2ZxSZjHFcUmBxSI5cfo4cR2Vx1xug4BOShrne+ySnR/mcdvIncmK4yK7kt4m8YcT/E9Vd/PfZnT7DqB4DYsHlTY2TWROoM8RNxOnuMifcOK9iqc38iJ8DSR2NNxZKa9SdnMAcw20ykKDpWz8YsK1EYNZ1CG2u7pANaWB2jkysKp2iuUL+9VA4wHGIgZQ7YmBR+rylBJ0GdajOtwWx7nnNSowIFHsdMP9uiGhzJyJX3Hv2P4k9+GnQ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 18:15:17.2797
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 543ade33-7ac2-4db6-4def-08debce51245
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8880

On Wed, May 27, 2026 at 10:14:00PM +0000, Pranjal Shrivastava wrote:
> From: Ashish Mhetre <amhetre@nvidia.com>
> 
> PROD and CONS indices for vcmdqs are getting set to 0 after resume.
> Because of this the vcmdq is not consuming commands after resume.
> Fix this by restoring PROD and CONS indices after resume from
> saved pointers.
> 
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
