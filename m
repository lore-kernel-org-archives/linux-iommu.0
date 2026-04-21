Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010037.outbound.protection.outlook.com [40.93.198.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E0F39E6FE
	for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 17:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776794251; cv=fail; b=Lqi8GzsQlrHr0bOsqBAPJMyB4j+RrLGCVSiA4bsH4gl7bPrgIIllA2fGYK/65yNI+YN4pGI8KocjJLH0TfhRGmi+zbD4bFXBVFOH/mlkUu/ZgxFNQBu5kuII3TLtPeY+0rXi+jpzx0NhgN+UjtjW4v0zu3L+lCqpeDrB30eI9GE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776794251; c=relaxed/simple;
	bh=b/fDLIgdoYOM0ztb4y6+MbMvDKIhacEuu/hl1V/M7ao=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pf2nXBwXtSTZt1DyooFfk3NYPBs1yKhxP3P5/U74p045gcXEvQ6Q8A2P0JLBy3UmcKSxkm/B/W9HHskx++kjxqV25gS6Qpo9IWg1sWKIu7jHCzutW1ovDEZu/0N7h7rNOwc4IzkFilpQGx96AocJLZDhcT9UQ8AmNUY7Hz5xNXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C8higzd8; arc=fail smtp.client-ip=40.93.198.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C8higzd8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EmlUOJv4SFVSst8OEJ2LgUELjtuSESMmDwVdkZrwu8WUfso+dbBII6BpcDF3N1jrEyxm7+Eqp7z5JCk6fABPdHVRvlS9ikFeMJ7xyan2Ntrjei8bw29LG9V3U4EgucvBvGeX2v8dcqsmLUCFwMKwz1bBvnWbdELpREgTsobsc9gHJxwLfNBRWJdWspN6M/2zpiN4NmHYsZxf3Vp80FbR8EHMKbrA1rpoBJiwnC+rGlBaeWAQZwioD6dWIsqMSqim2wQXvGV1SzOPo4GPZs2sd8OdiUbfGVmnOPzDnikqh8U4GBDO99jqbQFs1JnzF21Hl2DKtQRfl6ksNh6qWzLE0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNEycRPSgoAm00oSBHYPW4/8X6M/+CaEuM70KyK/fnk=;
 b=LovZlgrgyQhrm+MbrVDrZkdirmkEUyP+Kx5ApsuCKiTxjKm54Nnb14omwRr4C4zJxw2E1RDic+XuYy4YoBfO3/hJSmlTCHu/tFxIpXR/V10Rto+pzpu29BoWCcbYD2nqZl+59lMw7DX2E+uZvs9EgI7upNEChm8ZshzapLFRERs/xWfzYbg+HSkiDyMPJevmX5DZiL+clr3IOHrVgMt7e4vtLxNnwCebRNXpGsee1KTQBJOwV4lLoUy8RJGSmGZ8VwHL11wvFTvfYXTEa59xftMuIj0TfBSWZAUyLBxRZu/K3QIos2wiz3U3FFkCwHQFH1WAdQIVOEnoKWJuXSi+/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNEycRPSgoAm00oSBHYPW4/8X6M/+CaEuM70KyK/fnk=;
 b=C8higzd8EWhIneRTPrV5P/Z2a9Bn3pVeyvVDlEVe1LqDX3tyr6b0ttTTFYRvMDSIAxBZXDjCVLRlo3LasD4VxMvTmKY9FljH2R1akEBnKjf5lvulhlQMJVUT8A5cpOfBz3/6oRMWsMo546CBvpbR3JoJs41N83KWCfEH0VEZPm5s4HfJ+E5d06M2WosFkGrz3N3dF05/19E22F6eui78s9+M7S0jRU4soxfYnbyWvFy+0+pH8vgM5k0YOF95bNXdlp+uZvv1249dhxunIGETtW3bTpoRalwyXNOpJiynKkqFqxjWgtNWi1bBmAznZDvRV5XaOTw3QPK2kUI2VXRz2Q==
Received: from IA4P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:558::7)
 by CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 17:57:25 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:208:558:cafe::39) by IA4P220CA0006.outlook.office365.com
 (2603:10b6:208:558::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 17:57:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 21 Apr 2026 17:57:25 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Apr
 2026 10:57:06 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 21 Apr 2026 10:57:05 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 21 Apr 2026 10:57:05 -0700
Date: Tue, 21 Apr 2026 10:57:04 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH rc v7 5/6] iommu: Fix ATS invalidation timeouts during
 __iommu_remove_group_pasid()
Message-ID: <aee6cCAoHt2Vhv4y@Asurada-Nvidia>
References: <cover.1776551790.git.nicolinc@nvidia.com>
 <8914b746d0e19b05a26c1fc5d14f170336faa3d2.1776551790.git.nicolinc@nvidia.com>
 <BN9PR11MB5276FCFB54325CC9A3E048148C2C2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276FCFB54325CC9A3E048148C2C2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|CH8PR12MB9766:EE_
X-MS-Office365-Filtering-Correlation-Id: f6454627-b394-45f1-00a0-08de9fcf7214
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	6U3NBdczrS1WNK592w0piKwqM1T8+76+SIKl8P9HxhAb0TaVVz/bM4Clh+6WwRPM14ej+1wcrwGK8n241pnP4HyIExa+Ed/iuHSAhNNc2voEcsUXLanpTYtEZzCm+UEcMwhqEeW4nK9DwC3HaVV0TE8RESqg5iCtP/JpVZHffzLroySTB+Q0MsP0ctAnxs5ZHt5RdRODh5mV+jPhtlNi9arf74djycUoxXQ0WEpekS9m4lbpxle5yv2P5Ez3isUkhecoPFpz5Pwdi9qP7dgjjXYdNhNbJnapN7l+wThCXnB/u9CnCeRZVZdzwu2juLxjk/5p0DKxsEZ6ZY5i7e4TFbxPkKnNmgCA28p0aDAe+krPDnQ/H7OijogZH629jJqMzlq1if9y+hhCDRDJDFCyPaAtPV0ZsgNfd3wpIS6eIJCG3aLgqBfUkxedH3hBuDOfl00GqvoRpw1fjxhY8sSomHSfFqdTzUREJ6HrjYMbhvYY+TanQsZZ55P51bUmpb7Uf94pz8+HPgsAa3Ddg0NoU19X4QCfDgbF/cYuedobH/dhvLuvi81UO0SiFaCoL2R+P00w26ao3D8WtyqOTCCvUnbIr+ENTNiSmn4SqiaCuxhfe6gTH32PJv187dA6ru1VX4uKjSNuXcgB1RsnaGwcVSSULjVifGQFIVRfzLZmUCYUGDTsVQAeikauVbnqRwDE+yifftFZe5HyPUR4/VFrm+8gJge3rmhv9pxBGdKHyelT3en1S38iyRWdCYy/zGBxhmWHoEfNv6DKPDyVk6EEbA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	byiAUF7skMbwTDXgccLyu6wkUEXOEZE/zSRolvolrYol/n/kaqRnWLe+PsrFI+4c9aBq31EjoutVUDqA+H3uCwvkpAphoZtYtZJY50k/SyquPjtTYYKh/tS4FCjT6Vf/45TbShei8/CmeAuPBPwczC8Yw4Epyw1qeXTdWoZ+HMnN61k1YiEv0FSIt//AKLpv94jkLzJ428I57ifQbZ7NFRBLsq1W5Umk77Xm2vmiKaOyOSg8ykkLLIqh9WameB3xdR/fJkZxVztL6hw1b5vE3U+6Dpc4H3uGrl6P76r9/RVfJMzDIAB6OiaqHoKEHx/KqQGnMMR7nbV84iucecqPWjz1QZ6y+rJyLgOS65hEjNU+kR0gvDArDUYoajoI+V/O73z2bsVnOIvXfhRpBjOqeNsBf2Aket5klX7t/6C1FV+MYSsVomQGC2JD8Kko1p5A
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 17:57:25.2427
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6454627-b394-45f1-00a0-08de9fcf7214
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9766

On Tue, Apr 21, 2026 at 07:15:34AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Sunday, April 19, 2026 7:42 AM
> > 
> > If a device is blocked, its PASID domains are already detached. Repeating
> > iommu_remove_dev_pasid() is unnecessary and might trigger ATS
> > invalidation
> > timeouts.
> > 
> > Skip the iommu_remove_dev_pasid() call upon the blocked flag.
> > 
> > Fixes: c279e83953d9 ("iommu: Introduce
> > pci_dev_reset_iommu_prepare/done()")
> > Cc: stable@vger.kernel.org
> > Reported-by: Kevin Tian <kevin.tian@intel.com>
> 
> It's not reported by me. Instead, I just tried to copy the words from Sashiko (same
> in next patch).

I think you should take the credit, though maybe we could add:

Assisted-by: Gemini:gemini-3.1-pro-preview
 
> btw not sure whether Joerg plans to enable Sashiko auto-reply to the iommu
> list. I feel most suggestions there are positive. 

That sounds helpful to me.

> If it won't happen near term, suggest you find a way to check Sashilo manually
> for future patches.

I use AI reviewer too, but it didn't report these corner cases.
I will add Sashiko (gemini-3.1-pro-preview) to my routine.

Thanks
Nicolin
