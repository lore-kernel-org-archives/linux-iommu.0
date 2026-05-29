Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011012.outbound.protection.outlook.com [52.101.52.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED501A9FA0
	for <iommu@lists.linux.dev>; Fri, 29 May 2026 00:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780013708; cv=fail; b=J2+GCpSCM2+3Wuefr+ThYeiAnJeHFuDaneHvOrkmAHFcBmFnlrIf+WmXdlJzT90pgAs5gd9/xEh9rqgsyjJdf4eocqJhwxlS9Q+CeXoPPcrXQmW4J8ViFSFb8DSkcRIWQOzpx0RbvO5kByZO/fR7Tcb9EeGKZEeqhVBI6t9aOa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780013708; c=relaxed/simple;
	bh=UQ4sU9bWEPQej9zBKtSYfAK924uPBlVQWd2+g5dr7iQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sYnesFjg1ePLh5fvk7C/FZM2TNdut+sIm17zXwGGlr/O65mBny21EPBAYjzDGzlIXaHkycfbEt/u6afviNcQCWtwHh+Xss1MglzkQVsTVeGA/QnhEVzJj+TlzPUUdvMr3yf7oGpaevRQQr05y6CwpyFVAd9Yq9CLRVZ9cYdtwII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LyxA/fYG; arc=fail smtp.client-ip=52.101.52.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LyxA/fYG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EIoREG/RjBAcAQNdBh1DLTqcJlAoHbr8W9KnclOwUgrkdzNEEDDSiNekJX4fuC5xM7uOQmZqZooXp8G2i4ZBRVdoQJPfe2uYlkllMBqdOJ5kFOy16LWkCreCia+73da1zg8tv8JOTLPVjZlcoobHBkKeFBphT892Lo9LFxsJbXGdN/SSvt1jI6C7KTFRleyLb7jgRfQODGY4r9mFYq2HT5y39/zWe4Jg0zz4KRk5eJOjMVZ6/yd595A+wWwfZMDi/7AKb+CYAa6ewH59rTfwPhN1AQGqLcu40Gfoyh3ksYUuzoTl+hUPmSbvksIpKOkmQIxn90dqvQ76XfdERqaoFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FgYQO8hDaBV4RVzFngUU7h7OgpyOAOQJz8ZTZqHyyeQ=;
 b=E6Y1nfTy3cbB0YHG1QtLPn5tE+cNK6dxxEDw9kGT2h/zYtEgXUUobGtily4IEni6RkhMmxkIoVvvV+HMeVovZzCqR04OYkMbnH0TzqdrJUgiF0CYB0Y339NLJP5D095yM3hyfxtowaO0OHkMUib1ATCY1UFvWsRU0BIM00cC70nTKKXgTUbHvI7kVBu5CsCyCRjCAwh+UJ+q2BgPJcd9z+nNdw2YiVYxNo7NnbPPPSwgZFS9euw/OfybA2o2pLbAYgxnrd7zJw0/iGMrHP2hFnAZm/XXLhJX7hdNYlPWQ9J/eunHDXuQTQlf2fSZIFhjlvUpjoF9BgRDiFDUBKz0bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgYQO8hDaBV4RVzFngUU7h7OgpyOAOQJz8ZTZqHyyeQ=;
 b=LyxA/fYG6u7+UhDCgIUbq8D2n4U5z3Nlv9I8OApqOip8UNsnjjdYshj1uSDiPsYnOW3J81pW14JSucHj7VKPmMhdeF7Pye/KkWOo0AGkWQwrd1cmACj0gdBFQ24ATvkK394nguzStnwm4WQeWHURapK9R8Adf2OrQGXJE4go69OGn+LHTZtlMxpr9GntCvayr3zws3v791mPhMlk1CabWKCxAsMKUYCNwSCskqEd9WBo5a7cQZqj6JXo6Gf7SpJQocDqYkZzJ179DCA7dXxIFulapCODT4UfmMhGXtfw6g0rHqNcoF+vr/3Oh3dd3+TC2t3fdU988h1lFxWX0cozng==
Received: from DS2PEPF00004554.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::516) by SA1PR12MB9513.namprd12.prod.outlook.com
 (2603:10b6:806:45c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Fri, 29 May
 2026 00:14:57 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:92f::1002:0:4) by DS2PEPF00004554.outlook.office365.com
 (2603:10b6:f:fc00::516) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via Frontend Transport; Fri, 29
 May 2026 00:14:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 00:14:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 17:14:39 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 17:14:39 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 28 May 2026 17:14:38 -0700
Date: Thu, 28 May 2026 17:14:37 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
CC: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>, <yi.l.liu@intel.com>,
	<kevin.tian@intel.com>, <vasant.hegde@amd.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>,
	<wvw@google.com>, <wnliu@google.com>, <dantuluris@google.com>,
	<chriscli@google.com>, <kpsingh@google.com>
Subject: Re: [PATCH v2 22/26] iommufd: Add hw_queue_init and split queue
 alloc paths
Message-ID: <ahjabc5FruCGlfwE@Asurada-Nvidia>
References: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
 <20260528051738.596013-23-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260528051738.596013-23-suravee.suthikulpanit@amd.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|SA1PR12MB9513:EE_
X-MS-Office365-Filtering-Correlation-Id: 430b5e4f-7523-4cac-4c58-08debd175104
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700016|6133799003|4143699003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	mkA0y4PWJBSCknziPiFXJWBXYyDWdZpUO7WEzuBjM6yNKha7lU1eMjl3ztchM+ONYXX4pB8WVYalnLgqf18tjVYkr1zELWgQHKqetNpMZbACnF/N+y+mhq2uQcTMUf0mo8KzpRTZnillyMUFMYIyOcBwz6H4Jnp26uDxrSarJDxP9HR3RN6ccylGJeKeOs4ooVAFTexbn+jOs/oTP/oRN48yuQXWbaakS83g5S5mvfK9MJwNTCR8516nSJl55Tvjw7b9S/lohqFtjvhdBNwDHCSgUaGDK3ShxwsflkZKrLc9CYjbG8Ecr4527tjpt4PewRUVq6NFvLaV6j+Tw+jJYmukT8EblRDRS674JhPT2comIuvxzF26XcW0q8OGPivCvMjntB7UpTbOTO7t7Oovv+LRL/cXeLZx1ldIYd1KGfUHdpq7bEu/HcAcyB/4zB4zep858lW2DrLfzyWzymgLg0aCxMQMboipOVPjlCR+88YAGVc842+uVhCfpR/9HBFlBMWCxSOYZnBlrz4PQ+3fEIVkEcL5NidSDkBN0GM5pqFVLa0ZFgKh+OW4YJjWyvJ5jQlAzJd0hIJ7eqUfYMcNHdPcS3rNQSrU3UJ5kuRAuR1z8HGiYa4Z7///Yx9Q+lPKw8UMzQpdTuVCN1brJboU91YexOf0dT4WI7V4rBsQNS8I9kJ9GLBHojnl8WvCxdx+h02DDBvBMDz5tTkkJM/vAzHZBfhQAzqNwR+bY+zAV0A=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700016)(6133799003)(4143699003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	l5+fTNLAV2eH/qP7GgzRaaXOE9aaPQVqd9nxOxv+agbxLe7XaSHvy2q+2EuLO18p9GhdhUPAwil6jTq1HnEGauocyrZfQF/iw421iJdQlm4AZqU6a8x7rlOzOUmd5CeCIyS2FXT7RJBRuw8XI4YEIxE903KGJk5HzWLW6g7Nhr6d3z7I5Nbaqdf/F6T3wZr7/bs0JSJmGEGV2T7nvMmoe/874OKscRrz0x3MUuV1mqSsGX/ZhjoAz0C8qj2MBr8VeYBI6hBZTiohyghe6ACzaDO/m5UDqQolE5HbN0wCRc9FVluKz28Yb3UGR2ToXq5rRVpCY71i8IgnfX9sRt9/ccEhGcDy98IyZORQaF7Et6Lb4gax+oz5VbEZS2auqebDbet8H1K0NkvWv/tEts4E5/gLrUb+3tJpPP5L8QTjQ3LRWk8uUA5F6EZjfq8ROhfr
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 00:14:57.3531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 430b5e4f-7523-4cac-4c58-08debd175104
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9513

On Thu, May 28, 2026 at 05:17:34AM +0000, Suravee Suthikulpanit wrote:
> Splitting helpers and dispatching from the ioctl keeps
> one uAPI while making the contract explicit.

Why split? Those two new ioctl functions look quite redundant..

I imagined that the original ioctl function just needed:
[...]
-	struct iommufd_access *access;
+	struct iommufd_access *access = NULL;
[...]
 	if (!viommu->ops || !viommu->ops->get_hw_queue_size ||
-	    !viommu->ops->hw_queue_init_phys) {
+	    (!viommu->ops->hw_queue_init_phys && !viommu->ops->hw_queue_init)) {
		rc = -EOPNOTSUPP;
		goto out_put_viommu;
	}
[...]
-	access = iommufd_hw_queue_alloc_phys(cmd, viommu, &base_pa);
-	if (IS_ERR(access)) {
-		rc = PTR_ERR(access);
-		goto out_put_viommu;
-	}
+	if (viommu->ops->hw_queue_init_phys) {
+		access = iommufd_hw_queue_alloc_phys(cmd, viommu, &base_pa);
+		if (IS_ERR(access)) {
+			rc = PTR_ERR(access);
+			goto out_put_viommu;
+		}
+	}
[...]
	rc = viommu->ops->hw_queue_init_phys(hw_queue, cmd->index, base_pa);
+ 	if (viommu->ops->hw_queue_init_phys)
+		rc = viommu->ops->hw_queue_init_phys(hw_queue, cmd->index,
+						     base_pa);
+	else
+		rc = viommu->ops->hw_queue_init(hw_queue, cmd->index);

and then it should work?

Nicolin
