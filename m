Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011039.outbound.protection.outlook.com [40.107.208.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92E3376BC5
	for <iommu@lists.linux.dev>; Fri,  3 Jul 2026 07:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783062569; cv=fail; b=rZbuAgPBLAct/mpH3DPiBlg1DwYfumJhYDLYzpQ7eS3MkWr12IUS8k/SflV9DeR8gSisrW5cDrS+l8c3J9vb3rPNaK0+SPK7vXPE6wM8UD/2mqv2OCLt+pj2/KuZBqK5ks3WHxpz+slH7NGxJTVJr53QqYXAai6FFV0F71ZtLFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783062569; c=relaxed/simple;
	bh=i/A+6M4ltlV0bQBRLYx6arehHB8CJeSEcW4QU+KNIro=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hcBsmdyDMDUy3UXqTtYjXTzUtg8rdFDx9L4O4cLun++cCZ5JImNEzDqy5bgHeteDuQESkiJpubW2x2P7A12KrmwQJA5zIwzeQe+hMSEebvjhY6wlpTR2Epg5dXd41X+0fxq3MOCOyKJCNWV7Un4yCQDpXgCmXxPqYVApjsO6BKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Jvm06Gbx; arc=fail smtp.client-ip=40.107.208.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jvm06Gbx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ItfJIhKOWJ+fEYV3ElKVfhSw2w7l/sycMYBFspKqgeojmJs4Va6V8nrVAtaceaonFCdxbKFa5qN2sHRUYYoVziDwzb55xTTQ2eFfdjyVkWdOsGqq1wMe4bvPKA9DV8AIfIfMQsrUuVEcnSmmznHb4x57a03XzzNG6GeC/EKAoh9bSa6Rr0kG3OCG4nnVv6sp5MEcGdnwyk0j7GIGj3/JiHTiKvdTl+6lfb63rkgfv7OeWpM/wLtnVl4O4Lp0L6PfxSyl15I6wPsCL6P3SMyfAi35tWwanbv7l3cFOHYd3LsVsncn8tdk8t89ETsStGncb6RHVQXTp92LULzSs3FKxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipTox04d8yF6hs45Ol4JHySBuCcrZe1nJ7P/q1KLnQ0=;
 b=FPt++mH4wpFZn55lIoOMODIvI9M+rZBOAaMy333Eby34w0gPSIkDtus27M0Iz/1jT8t7Hj+3jgtG1hBbye3amipBxEjcNHuRAZVwGxXna6h0eJn3X2DhV8SGUWTSBnGhQKCRpwfrZ7OIjYZa6CRaGlG6TsnRtxSzaZgRX1ikB8PTbNT2uSjswtf9ca5i7pNOvkKqV2zUui1MAXR9LHRBOSV8R1H+FkqUFHu/8WbhcPfFUlVv7xOf2QvL+AYlmJMdtKfvBWrrLvY1qMvhkgUixJvrTV0I785Kb/Qvj7shApH51IuxFwD6tFvozCwL2M61gNMkCI/R9ragjbYuTa53IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipTox04d8yF6hs45Ol4JHySBuCcrZe1nJ7P/q1KLnQ0=;
 b=Jvm06GbxfzKXRAsKAdbP7I55NOMlPMK3syt6qvwkOZfajMwU0dJ8W3xoTxPnY82jq3u8E1Q6I3t+/R91Zq9zv6rQ3w4et0q6o0twZ9xq3AAe+yhB8qZ26wKg81Pob5uxn5A/hawrMOBJSorgY19ZAtZ3fFh1AH3fyAi9bof5B6NBG/ka5X5T1MoDtgR658YUHLIpkylAyyOBWgqL0BagbvACfvInFRspzC0CPePkRavc3Yhz80daJdn3ZJ2HBuPLf0NcYPFmhOcWrMnbhsBR7qx8y424wpJYRnXOsJTxHmKE9f9ER/3C8iBzkQKthOtX9b0U4T+Oo9FfseYyp7nh9w==
Received: from BN9P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::12)
 by LV2PR12MB5989.namprd12.prod.outlook.com (2603:10b6:408:171::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 07:09:23 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:408:10c:cafe::84) by BN9P222CA0007.outlook.office365.com
 (2603:10b6:408:10c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Fri, 3
 Jul 2026 07:09:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 07:09:21 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 3 Jul
 2026 00:09:03 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 3 Jul
 2026 00:09:03 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 3 Jul 2026 00:09:01 -0700
Date: Fri, 3 Jul 2026 00:08:59 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 3/3] iommu/arm-smmu-v3-iommufd: Require exactly one
 Stream ID for a vDEVICE
Message-ID: <akdgC/kKGZ6fE00Z@nvidia.com>
References: <cover.1782767110.git.nicolinc@nvidia.com>
 <b98248fb8a7ba39beeb684d27f064897e6ec8ef6.1782767110.git.nicolinc@nvidia.com>
 <SA2PR11MB4844DD8A0367D8E909123F868CF42@SA2PR11MB4844.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <SA2PR11MB4844DD8A0367D8E909123F868CF42@SA2PR11MB4844.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|LV2PR12MB5989:EE_
X-MS-Office365-Filtering-Correlation-Id: 81f41c58-a3b1-48ea-e0a6-08ded8d20188
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	KoQoO5vN663M0+3mnfaLoAb8DWBGWL/S0jNpiL7Uvt6FUScXfbXPXksr4anKiwDa9fOPaywpKn/IKHbCyfCnCVDuUIG5QewoAL2RxMqiasFWE8OoWIR8WaH3xjax4jUr862vgVmbAh0AWfYEaMmKkSyP5pF1Kx9QN7dmu4tV51uVkF4vitqw7jeXklXpIvSSsDAOup0TymbRs+Gl9v8X9Ps7Mg+BTGPxd15RJgxjVM4ISFlW5qkxwQDB4weHR94eK/IjqfQ++FWKreeagrw8cIQscxAAKY2SvpvG5hzW7tm3eWutcskfma86adQrcG/kJ6wTQu8aJvUJGeBG5RrRrO7Iy2WW6k++ZXHpshNBhcXWX0UISs4ffqTm+icNTbDzUomiTDqLXV8h4QDcVHJGrXcsrbhGOE69L4d1xG6RoFlZJQIccgmjGhNTTYE0ZSKZo/liVV7h5RR0B0e2uU0S1A82stWF3fCaKY16HiqpeV25R3CWZA2npN8Qj9ZyLoYXPlKnEeGpHGib0kvW0uBffr1tB8m0GSa3RMZZuoa1/O435wD7GLpqjqQ6e2R5aahd+A8GicR/v3P2B0BsmzY+HfkCym9N9DP3AHBv0aaGkbG3Y6fnZxYe95yuAhwLarWseKsu+ToShjbMWJYHULQ+xa/8fyZORvjVDfXM8y7jHUTMGF/8WnIM2u+KY7Ai+o3duz/K1wVQ8uxS2DCINQ+UKg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Tu8zzAD0+17D62RczBbiOmQe4e5ErhbWIWstTRw2KGRBxpeHpanqcnaBBPcBSfDQHOyt9e1/6ODig0NcpaOfhMSbDAlNTohXNneGNIyoK+bAGLxi6XkstYrZjnArX8B6UpFI+roLSE0lYG4BovI5wCBO2mbZqWsPgrLggaGO29uD7v1WPfYbg66ZhC0UYbgMhEMQNIRIvctXsC3azd/Z564X7qocMc75kp8Gcxj+3x54CispsVmgJT+fbTsD855UG5JnDCKKytyfu/FsaAoQOfpVo0rSRHBfATmZOmoNjrvs06rNm2a8vJai/jZNqpvFFE4SfS4CAk8U3Fdgfat74kaWWt5dYfGL9W6M+8B1l6uen1Mu3N/hXxBg9iCtcbfBw2o1UK/73RIj/22H8IUJB8YbDPxJBRHhXPiyDFQc66wIxrMXeXObta2a8wjYljH3
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 07:09:21.1631
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f41c58-a3b1-48ea-e0a6-08ded8d20188
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5989

On Fri, Jul 03, 2026 at 06:40:22AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Tuesday, June 30, 2026 5:16 AM
> >  }
> > 
> > +static int arm_vsmmu_vdevice_init(struct iommufd_vdevice *vdev)
> > +{
> > +	struct device *dev = iommufd_vdevice_to_device(vdev);
> > +	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> > +
> > +	/*
> > +	 * arm_vsmmu_vsid_to_sid() maps a vSID to master->streams[0]
> > alone, so
> > +	 * more streams would leave the rest stale and none reads out of
> > bounds.
> > +	 */
> > +	if (master->num_streams != 1)
> > +		return -EINVAL;
> > +	return 0;
> > +}
> 
> - EOPNOTSUPP, given the comment seems to indicate it as a current
> limitation hence may be removed in future? otherwise with -EINVAL
> this may be documented somewhere to get attention from userspace.

OK. I will change it and other places too.

Thanks
Nicolin
