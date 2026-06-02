Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011024.outbound.protection.outlook.com [52.101.52.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC9639B964
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 06:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780380004; cv=fail; b=kn8pYo+WEw2BfWG2CNdCwYPWzI26JrQb9fFrakLVLK90W2+YhDe7SHqqGGnaGERqsXX6AEBpDBUWl7/Vdyz0EKacOpPN4kSvDoWfgXZ8J9tuRt/ZpXBKrrrmxD0csyyB8ovq+uDXyfRScZ6blvmgBDpX5wGN5kl37iPzfACM8Lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780380004; c=relaxed/simple;
	bh=yJxo8RZBpxtkmuYTsuVCgcAKMyA+wxIT/ogDIUEQmsM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kv/Ihae5TLMjRkBHy5qtcmf8HEwc9o+KFm8Hq7dEFzdIszS91jEGGUj3xOGN9+KSAymCxzup5vDA3sES0+UntsDNUP2biihxhYZeCLjtbkE/ofcsu7mMv2zQ5OsRKNWEgeYnJYGWS7s7EqIeQeyu88LXdbHnQBHHS+bAf2boRV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RGs6pDqI; arc=fail smtp.client-ip=52.101.52.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RGs6pDqI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VKMWXnFQJ3av0GAX281Y+s1hI+gBGNzmkKw8VEmmUsOKGdCaVKnLzy8qyxVK5vPO+QiuVSKSzMVfexyou9N6a/pEzOiptKQe8D8bOm7cg5hpgRf2YMuSvyQ3AyF1uIGNOwR69p6+jhDPinkYK45tjmAA6hLSEOCnf/Px2Q24aLpGnEYk2dG/3+GoCInL2DBRmVBkEFdc5NvZ8uEQEbhxZumvAYpEbNOgqcn+vMP031Jk48QVcJ5z3T19Tlxmgrntzz/9/5qT6i3FIjuqYuakIxlp6PpxsSSgzmKUKgoYGCiWcyQe2Wg6g8YbVsc/I0CKu6rrk+7Ej1IjgeRurNPmcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A59f4bB3fj3QOTgEJWC74U7y6yOnYMv8ej5jObvFEb0=;
 b=Jcrgtqs7l9GticNryCoR2FUGrMGp63M46vsdWZSTp/wilnP4CwzM+TQEgfMTZ2VvDk6a0GSm6qt6pXo0OSSAfyI4rCr4QW4mOehR2ghxvcyNe89eKZ50QbdE9UO4QuK4yDcg2voriLoZv7depoaw3jbELMyENWj3UiJp/ICKPKK2IBXNpA8U0hZ7bmJe9D3CWsBpjH9zokj2L7SiIEA/hF0jEaZMNBu63t7WGknBzyGbqg5yCe8vN6DUz0OybTrTR4dpTThH8yFnWx+s8XaLXIYGDy8PU/l5dzMlPYcFF1pMDbyjMJRFy4ApjdKxtAXjKLvN38M82270Js0NLGp5zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A59f4bB3fj3QOTgEJWC74U7y6yOnYMv8ej5jObvFEb0=;
 b=RGs6pDqIkkbDk9WA6gslmS89raHebX35cb/oOZpevUfZO1Vzzudu3yeJJjxv4ReFfuqsna7zQk1+ZFiN/rorB5vNJdaIYwk0cIXa8l5Tnb3bVAnQ/n/ee2Ew4t0rR1DBe0JgKlX8J/cQ95y/YSV9D1KQ9E/vpFue+GSGpRbI8QYIh5q6tyvHoB/Raebs47LNV9+frrCBwL874SjRUCLD0d5lDyvfaUIDQ6sJs0/9z7XkPdimQoEqp3zhbBrhlYrlWqK92IghzzUUtiDD8YI/k02AO2MDG+S1zZSgVXXkaF2sa9ROPrtLAUY2BdWHDIfMqHGK6w/f0cp3uP/ljm1pig==
Received: from DS7P220CA0108.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25d::14) by
 CY8PR12MB7268.namprd12.prod.outlook.com (2603:10b6:930:54::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.7; Tue, 2 Jun 2026 05:59:58 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:8:25d:cafe::3a) by DS7P220CA0108.outlook.office365.com
 (2603:10b6:8:25d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Tue, 2
 Jun 2026 05:59:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 05:59:58 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 22:59:35 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 1 Jun 2026 22:59:35 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 1 Jun 2026 22:59:34 -0700
Date: Mon, 1 Jun 2026 22:59:33 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <iommu@lists.linux.dev>, Will Deacon <will@kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Daniel Mentz
	<danielmentz@google.com>, Ashish Mhetre <amhetre@nvidia.com>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v8 08/12] iommu/tegra241-cmdqv: Add a helper to quiesce
 VCMDQs
Message-ID: <ah5xRRn0IjdWiF8F@Asurada-Nvidia>
References: <20260601215909.3958732-1-praan@google.com>
 <20260601215909.3958732-9-praan@google.com>
 <ah4gYCgSO1bBOUTj@Asurada-Nvidia>
 <ah5QB0Hfpi9wZMLY@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ah5QB0Hfpi9wZMLY@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|CY8PR12MB7268:EE_
X-MS-Office365-Filtering-Correlation-Id: 6339e4c8-1da9-4f64-d959-08dec06c2d70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	jINwkB9xJmHTF3xH6aeEqk4KZxpAMGA9TEYUugU+ifMTnKnmM+1Ctj01KM9RnNGMXTwHjPPKKDb7cUWfcjaktd+ehWotMTSXHHO6lsYDESrFZ4o88j2a4m4TjuJp2WUYRD9/YvIBL+gnZA2aLd6YyjaEK26v4SUW6U0OhbGtie9W4rk3Uaem+krwF9sGEU9JP25uAqfEMB4Jte9WwBBM7JLwJ10AhwRBbqOQVm09eDKyKsxK9nH9cavSCfBhIoOXxWGOqzfYh0Ab84nY0s38ogpi/MmhaAG3BlNDDKCM9EPw14kKNN/rXXcrN0rO4yTC5Lh9pD1QmrXNMHIabGguswEYeDi3A8kkWyQyZL2goH1R9Fx1GrtoyL1MOHjhXT5ZnBW6m9viCQGeM5bgv36ECv973Ljo/TOal7Wblou0xrOJ4ucE3Pt0y1cTj1w9ePVt3RWBj68TSLmuYz+/ZFXQSIaFHd7v04zyBGJ5t1jfRpZ7tFBGYjEwXi4bDgOt3yPnjBDq5WHtfdppwA52HzAu7ipOKb18P4nhtvMy/eEbE6KayXTpUhvC+4TbzpeYr1cRSu2y0ZO6B1kFxdGAkrEmKvm4Y5TEOMVGdyTTwIs4wkeHvMcwyjY6kItWZpYADhQ8qTLA/vYh3W8rY1q1Qu1SwIhWhq6Bhd1R4RrWqMEfaV/w/WgkGkIgPCg/7PFD/owx1frT71zIRyJ/VHQnMJijJZKQuxz5URIhtIebfyCHRpk=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0Y2oOF0Biul5dXynFUCZhrp0Ik7/58C/Q9dJPa6r/N6m9Id3WhVl/BTa9Ysr+S6/IpwAFO46G3gGvAGnDf/T5u7U1kUxNYniC9wArZ46vVXQhHgu6n3NlPrd1A0/PZsPVQzmaexXH/nDZEGQBap+xdqqdkH/Ka8xZPqItVnrMLwfHx4KBJVNKwUijxXWNgE1wRqO5Hmt4JlMHJYAgy+Va6s5PVmlJLCgigrJK2dWVm5WJ7sdBT3Np7EK/CNfN7/aLnVOY6eyJW5D0GzX8rJoH4/7VqR/+Xd2nL13kAQWDoj3V/Xowo51eCDjVSUAtAqw/+ThHUBKHuiEEwECH+CwXG6mxz7FNQWctBSwj0pK2zIeev/iSJzstuuembuJ4o3QSCYU/pYguMbKxY5ZNiWFv+eA5yg0a12gqO7mLwRZ3dfsEyJ9xc3xuzYvMfK3au8D
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 05:59:58.3264
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6339e4c8-1da9-4f64-d959-08dec06c2d70
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7268

On Tue, Jun 02, 2026 at 03:37:43AM +0000, Pranjal Shrivastava wrote:
> On Mon, Jun 01, 2026 at 05:14:24PM -0700, Nicolin Chen wrote:
> > On Mon, Jun 01, 2026 at 09:59:05PM +0000, Pranjal Shrivastava wrote:
> > > @@ -887,7 +887,7 @@ struct arm_smmu_impl_ops {
> > >  	size_t (*get_viommu_size)(enum iommu_viommu_type viommu_type);
> > >  	int (*vsmmu_init)(struct arm_vsmmu *vsmmu,
> > >  			  const struct iommu_user_data *user_data);
> > > -	int (*drain_queues)(struct arm_smmu_device *smmu);
> > > +	int (*quiesce_and_drain_queues)(struct arm_smmu_device *smmu);
> > 
> > Hmm? What's the point in PATCH-3 adding drain_queues then?
> 
> Well, you suggested in the previous version that STOP_FLAG needs to be
> set for the secondary CMDQs too
> 
> All we're doing here is renaming this function as it also sets the
> STOP_FLAG on impl-specific CMDQs now. We can still call it drain_queues
> if you prefer not renaming this.
> 
> On the other hand, we can add a dedicated queisce_queues() op too that's
> called before draining queues. I found that to be unnecessary as I'd rather
> have one impl-specific op handle everything for impl-specific queues.

The renaming is very confusing... I'd leave it as drain_queues.

Arguably,
	atomic_or(CMDQ_PROD_STOP_FLAG, &vcmdq->cmdq.q.llq.atomic.prod);
could be even stuffed into tegra241_cmdqv_drain_vintf0_lvcmdqs(),
where there is a for loop already.

Nicolin
