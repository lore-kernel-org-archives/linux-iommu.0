Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012042.outbound.protection.outlook.com [40.93.195.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F004414
	for <iommu@lists.linux.dev>; Sat, 11 Apr 2026 00:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775866001; cv=fail; b=qqBbm1qZNg7lN7H92r+7dRdC2reL7CXUkcK/bDsTZcCygq8wu7jQKvf1zC9MWJeiV2rkx49xBf1tgIo8UsgJPoro24evWG4MJrL982xiU36zxhvn4sosr6EyP4sxQtSSRJOkaTArqLQQ33fPgz4371IG3bpUTWklPpeturd1dBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775866001; c=relaxed/simple;
	bh=WNaT5OKbbMFWnaMnvfZIrSP4Eopx7cNxcmgeTnGMRaU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jf/VHv+Bxm/DxCLA2YudC9MlLppxEuqXnLapcON990YgNw6Xz9n2N1cGKkkqWm+JEa1DxxZezVJ7YW00g3QgBensdoZ5CcjpADlkFps9QAS5tpmo946vLGi6Nbk5HgAd/Y+mY4aUh5oW6ey115PaoqpfxkeAseW+Ia7pMx4KmT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gGxaWdVB; arc=fail smtp.client-ip=40.93.195.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gGxaWdVB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kicW6tb361cGrlDWTbWHH67CYUtOyw92T347VxSKKrb0XNvqhofweeS5Ev3LEPJOf3FkXYS4Gb0iRsbjWXgw0XNqWvmcCaov7jFZBGd9AoB5xzIIZpP4oLovFJPRB6UlD8bDYrmp4JCZ5h484QbAg5TPwQr06ocd9Lk+rF7ZD2dRxvG55mEzwaJuRRV9i3jVxqdFVxue2i+zOx/YqFi7kcwId1tyOjlOjRk8z7GxiSr3dDJ4dG94EdRqrJPL8QWFazhP33NSwyFb2xNrHy3eM8qlf7fbsBRKj/nZbWv+irwHQ0my1P5OjVE7FXa+cXCDx8MLbRJIfRYImBFRMt8YeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0+e+g4CbwEmgN+HXC+e9w9/Yd6s3MlCcRlMtalmEtg=;
 b=K8ZHXqaIHB2x/mTyNm1fm+7JjvohEd2EVdNNkXVrvV8rdf9C0U7NmgrKXQNs6U495Uqh1DXm8V+44jK2aDbjmqnuMWirfFXpJ0Itoz/pgk/a4rFe0w10tCY4tPadjU+dXS/phzIpqiitqWdeXBZZdkB3WVuJNkoaAig9fbWUtu64pskhg/lIlA/xUCVD6Tdt40Sr6wTYNZhTxpi0dtotC2QVOTYF+hXBg+5IIg29z/XBADR56qsgRiya3U+bH7wCRDBZdy7YJ8BPPBtI8Z2A9oKOdRqkCTEG6A9G0ieR1XO9zd3MTL/vlyOO9ATtFPo6ZcVr1kzNol1Jec8nLC834w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0+e+g4CbwEmgN+HXC+e9w9/Yd6s3MlCcRlMtalmEtg=;
 b=gGxaWdVBM0I1zBWKUdYJa7ngirwrRhdfrxK/0F6L/AG68/Yrf10MQXqv9myVMBframMaaF7q+l7runz3L3yEYY9i8VTk0r9eGK3qCdRwSpuraHlTHaHncG6rx3vwAp25UCLwAgYgN6N3errtHiaQIhGi8H7sOsrA17z5AA+u4DZVKKPjuqFIaAfrzwADqkzajdEU+OmBZ8PwwCbTwQJf/TgZwHuE8U1XfeMDH+eDwFsD1P3ZouaphHJ0HsKWqm/2An1BfHZVTJ5YcSOAuu/VrBCVy4b+PHpIP34QhTU5ZdCozA3MHcievGkRRZv9jb5XAXL9zJVY2UUFXKoPHGKe1A==
Received: from PH7P221CA0086.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::13)
 by PH7PR12MB8107.namprd12.prod.outlook.com (2603:10b6:510:2bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.32; Sat, 11 Apr
 2026 00:06:35 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:510:328:cafe::95) by PH7P221CA0086.outlook.office365.com
 (2603:10b6:510:328::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.43 via Frontend Transport; Sat,
 11 Apr 2026 00:06:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Sat, 11 Apr 2026 00:06:35 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 10 Apr
 2026 17:06:19 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 10 Apr
 2026 17:06:18 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 10 Apr 2026 17:06:17 -0700
Date: Fri, 10 Apr 2026 17:06:16 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jpb@kernel.org>, <praan@google.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<jonathan.cameron@huawei.com>
Subject: Re: [PATCH v4 09/10] iommu/arm-smmu-v3: Remove ASID/VMID from
 arm_smmu_domain
Message-ID: <admQeGt9a3bUJNEQ@Asurada-Nvidia>
References: <cover.1773949042.git.nicolinc@nvidia.com>
 <b6d87a722635d29e896b277cb60f0208859073d6.1773949042.git.nicolinc@nvidia.com>
 <20260410002734.GC3357077@nvidia.com>
 <adl0aEfBAKmBsMs6@Asurada-Nvidia>
 <20260410232500.GD2588311@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260410232500.GD2588311@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|PH7PR12MB8107:EE_
X-MS-Office365-Filtering-Correlation-Id: a6eb531b-4319-4633-e982-08de975e31de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	LOWnL94/JGEyu8xOaJBNWxVSRCpAelbRkNiWv4fuKO3AFknbk7ig0voG+ardVwNm53qEnZ9vwUweYsjZ8l/Dy+1vZfpAoYaxy+HcMT++3l2B2UUmvvl4Yd6C0x/27CQ4bMMGRtWPcHCcPKRmXTwCocNqH+HWh53n62MfGtEMuYib+ryL1GrUApqu35YOxJwbuG/yH/ALJ0HkWIKujcDeV7wowmeXTzVG9CfanyVp4YTL2AfNyz0qVBpSXq98m8KChg3kvB01qwlBALHtkb21y4SvphdbjL0GwklnrDqxKzzBw6mrkk8eFKLFZqNwfLjdjyCuiocfslSO6bLFj6VG76AX+Hsa9mrM6m0cpVKcnrNdmQNWbAofHjMrhea+5PxQ0zZ91bCMlssKbAAtzVS8zn81+aQ488bYDHqcgXGnvktIHq5aYZgMQr+/P5z3XKQQcG0IfFKix86McbXjrA3lW1dTUt0dzjTUcryUzh6Dos0oYZ0ux9dbS/HY18uTwLgNQ3dpS0JU1cRy1n7G6JqSVDSXIafQvBM5lGQpc+mTvmATmBB0nnj2ZUz+hk2gexBZGi4Y4YkJsz/X5dG1OAhjfBvukfHaVnIVZ3GzJZqhfDwC0A01mPmdAoMSdiujUp27yGAXcGdpNcYB6QdcKBRPb+Ab9C3KK0Kd7ZJCNYYRokW7TUmfSQYs8hN606VozbUvDZjLCkaTpZLz42SSCquyVjKBwhz5HUpFSjnR3Q7GemnGcPitTvXpsaaFV6SkveH8ThYLs/wdjHIlkFWTol4adw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fb299x5173lYveXVcMujEzuP71wyO8az44/EyfpXOdoRY8qrWI5ShbCx135hG3sS3iSJbMegMeX94CRSmoO1wmzNzXgA52CxsoSdwdpMS6v6y26PBwzdnf92NjFn7BH228N/6yMj9ze/JCk+Z7VD6SgLfvAWITINxNNUzFZ0aqIZqXSerdSs1WadPi2m0kjTPmqHhgHuYTiYEQfPToOk+u8/ItjwGDQKehsw1KD4q67lzkl6EdgWKjIjg4L70ynyO/ITIl7JnYEblU4Fhdwdzo6v0QFLX/Ji1ChM2WEqnt+ElxYJAPoBjVtiPe0I57+yTnfyWtpunMdefhpIy8saLmdq6PXz1Y+NvgS63+tafl0n87bjtJQffBO91lTlfVDE9AVafdY7IzEt7r+MLE2exEAvcigt9Z5l6vj2PSEzviBqwBOfuNy6aGvffdxEKl2k
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2026 00:06:35.1379
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6eb531b-4319-4633-e982-08de975e31de
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8107

On Fri, Apr 10, 2026 at 08:25:00PM -0300, Jason Gunthorpe wrote:
> On Fri, Apr 10, 2026 at 03:06:32PM -0700, Nicolin Chen wrote:
> > On Thu, Apr 09, 2026 at 09:27:34PM -0300, Jason Gunthorpe wrote:
> > > On Thu, Mar 19, 2026 at 12:51:55PM -0700, Nicolin Chen wrote:
> > By taking a closer look, I think either the arm_smmu_domain_inv call
> > above or any concurrent arm_smmu_mm_arch_invalidate_secondary_tlbs
> > call is a NOP now?
> 
> That sounds right, with all the changes there should be no cache
> flushing on the free path since it is now always flushed on detach, so
> the arm_smmu_domain_inv() should be deleted here too.

Yea, I did that.

> > We reworked the ASID lifecycle, which now ends when the last device
> > detaches. So, ASID was free-ed in arm_smmu_iotlb_tag_free() that did
> > a per-ASID flush also.
> 
> Yes, so the comment is:
> 
>  Notice that the arm_smmu_mm_arch_invalidate_secondary_tlbs() op can
>  still be called/running at this point. Like the normal detach flow
>  the RCU protected ASID may still experiance harmless invalidation.
>  However unlike normal domains the SVA invalidation will continue
>  into free until the mmu_notifier_put().

I updated that in my words but this reads more accurate. I will
use this (fixing the typo experiance).

Thanks
Nicolin
