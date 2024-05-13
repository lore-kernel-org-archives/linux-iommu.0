Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2063.outbound.protection.outlook.com [40.107.101.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F6E13329F
	for <iommu@lists.linux.dev>; Mon, 13 May 2024 02:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715567406; cv=fail; b=tVpYZyIuXY5W/Dqbu8tOBZ60PMIM7cPZJyEhzBMWuh3m+ulbpQ5QLikRas83Rs4O1DspJ8EvnETeO1O4qJaKTAu55RRNZZjMpeB1KvgeGHeoMaOkm3WQ90IB2vB25AIRW3XBuzk1lnsb6HelRdQT2DQq4oKQkquCtuM6w+0iDmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715567406; c=relaxed/simple;
	bh=m3DRC5POY0ejJGhhtcQOXlqfcGN/2KNlyYhPyN5ToYQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnNKNKv67bl3xn8wSTCLRjhx9kz0w8G2xbRkO9Uc+uGFb8QqvXTXS3r8N6cgsoYej1SLaGlcfdT9esAaOvWeCoVVPwS5CKUrgMgrPMlr0n9H2fxB4U5rz3RDEcfrF/d8Rw1LMA0EX5CV+xyoGEuL/KJQFYTNtollAxWCeC4H89s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Mwis5F9X; arc=fail smtp.client-ip=40.107.101.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Mwis5F9X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fkw0wLA8wbCGNyVjMGeQeRz7E6YS2Fm7aQ2Y4tRUFdn5HT4mipq/Xz5iEMmtn9eWET9xEKO4U8LCosqlDQI1gwhrKRI+pppS49py9vyKEo+wLEKmGdgs93WFSEUcsvdkei5BLAVtLVZseN7XGEDiwSIZ7gr/ivmZEX9fZiLVgnZejbF4CKPVvvd72Um607Vj0lKZZz21vDEZM7zY0AxeSQzJZHeH2z+xRg61oQR8ZRJY8Z45+3tlYu8q7i2jm+PANvfCVKubnYbljMOSi3iwIH/l/+PS9E9jtyJm69pv7IKLYgZKuMI0Tlja9OjbJyIAT+RjwtE47S1px3CK/YnpFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSqiiIvnsnAgvOyabL+O7zTeGfrW5fSz6OmE0rAn/yw=;
 b=kSfhL+OwN2wGGV8FoOy2WJOIduZvD3IoB2Y1TEIUIlDSWMXeGAiUlr/7ipsFPgKY9e/fqGCS/IBQZJwqfHpJTQrZwNT2rf+GUrd6oRmhofss2Djv/S+YzBsi6chXqjZX1jaXtLV/TUiRPLB6SIvwzy40OXhCo67jPMfGNdFCCtHlBKnz32PrZNeQqkO4O+BUzrgtP72X7tJpCkJkSwWNtgBlgRDQGC3HTlqjUuKgsYBFYwhRazXeu/sLj1UFjdoAG3gL/2L6hdszNK6ivYFuSDq9oGDYAFa6738q8f9dbXfFSHDqyGRlq9yszHCWUE/kwALSa6PF06cy4DYGYcRAHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSqiiIvnsnAgvOyabL+O7zTeGfrW5fSz6OmE0rAn/yw=;
 b=Mwis5F9X4A2rpZ+vfc8syN1KX0WKRrEe4B9xay+BLOWxFEVJtonAG5/dfAOq9l4GVnJnS6QzNN/0JF+J7IQpLheuPfSjV5rxYyC689aAslfy8iFen+IjwuirvN7AXDHlA4qkGuFmFiGgmYeYYwXuyNDXCSeS7MDU22H9aYWZMlFcNn3UXnzqb4zCRHYSC57e5O29I+Ic6O3259mffF1sgPbpeip+CNHAiBm82I+DLGu2d8OO1k7FVXCdx9UWFr4nA1Y4rJPP+1s6AXarVDpbuiNPdAd82w/RuYXnE6z5xOWLC2NyoZhzMBLVoawIV8ShgDGR4Ba2AAYCxo/xXekugA==
Received: from BN1PR13CA0028.namprd13.prod.outlook.com (2603:10b6:408:e2::33)
 by SA3PR12MB7784.namprd12.prod.outlook.com (2603:10b6:806:317::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 02:30:01 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:e2:cafe::69) by BN1PR13CA0028.outlook.office365.com
 (2603:10b6:408:e2::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.22 via Frontend
 Transport; Mon, 13 May 2024 02:30:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.21 via Frontend Transport; Mon, 13 May 2024 02:30:01 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 12 May
 2024 19:29:46 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 12 May
 2024 19:29:46 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Sun, 12 May 2024 19:29:41 -0700
Date: Sun, 12 May 2024 19:29:37 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <kevin.tian@intel.com>,
	<suravee.suthikulpanit@amd.com>, <joro@8bytes.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<yi.l.liu@intel.com>, <eric.auger@redhat.com>, <vasant.hegde@amd.com>,
	<jon.grimm@amd.com>, <santosh.shukla@amd.com>, <Dhaval.Giani@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH RFCv1 02/14] iommufd: Swap _iommufd_object_alloc and
 __iommufd_object_alloc
Message-ID: <ZkF7EY+COAPYNWwU@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <43bab81816a7bb08fde868a43d62c439ede91f9f.1712978212.git.nicolinc@nvidia.com>
 <ZkDDlMouOmfTaRRg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZkDDlMouOmfTaRRg@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|SA3PR12MB7784:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d10fbc8-53b0-4d14-8d49-08dc72f49728
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|82310400017|376005|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pDXFK6C5mpp1JPECB2QaTKXmd5HEnlzqh7gkkbm/y6aUf9lDcx+5HLdqqKXn?=
 =?us-ascii?Q?eJVmSlUxvnGrHxrY5scwBORnKNnDSfsAEO0WwAZ1lqgS/XXP0LakPEwofl/D?=
 =?us-ascii?Q?8dKEG1CqHpeJnqMVQGE6w3cK6+HT51g8sDyUeiwPSJyJeRTGhSxjyb0MXRKk?=
 =?us-ascii?Q?uCMuc0D5Wsx1JTaa6zRNDJStpyD95X5iS+dyu+ethlMUYZo2W957ePFLUuru?=
 =?us-ascii?Q?txolTGkQCU0ef8URWAKrgVSfy+PJ6TCZ0uEuEcjmixSFC/wWYlz8CE+BB/Kj?=
 =?us-ascii?Q?rTbUOMwG6+LiTAy+ep+4ZGJkXVFijmSQHdokUWdoK1egd0gmK5WQEjP+3yBK?=
 =?us-ascii?Q?0A7Nz8crbPUdfQE1uXN43z2JRUqaxXhwQQi3UuH2htDnF0WocfFPJcoGJXB9?=
 =?us-ascii?Q?E93j4EUGP53PgF9dK5ibyvURM1Dsc3a0Lr4Y+gNCikns7rSbihaRz/ETlUTg?=
 =?us-ascii?Q?LM8uT4tip+2adTzOEW+sFOvY+dzAIl1B57NiZvQsKQmyscck9OO6wLB3xMlu?=
 =?us-ascii?Q?BDskBj4Bhcc77GWqXTQOVql2aA8YfIApsFbubqmx8Kh9VFHNvCDSl3Hf/9jr?=
 =?us-ascii?Q?wsb3ZN+Iyl1fcj9n56UQxVpODB9HcAEDLStCTtiZ0xhYbVBrqcvyAzXETIO3?=
 =?us-ascii?Q?EcUopxDW3n+uWykGl5j1qOabrVh/4y4Ke6JYv3qnv46eJCYW/kZwOAi+wO8i?=
 =?us-ascii?Q?IJW2o0ZQGdXip7yuTI7yLMWP/cTJqmF/92cJvWTEFGCQiB/C1vdIglRETwWv?=
 =?us-ascii?Q?JWQbtQ8RMcXRDH4ELS6A61d6caJh4sy0XdpIhuRaEAadUHyoTtr0NMTOWf1J?=
 =?us-ascii?Q?Jjc+u44RfRLC/KzjuM7QsTZX5sRfkORCh7z+6Wfn1BVJ2lOE2TKU3z6oKaXP?=
 =?us-ascii?Q?qQIit8xXegluA3kjTcRZJe8Vhnh2lGfIohm4wY+tyBR1R/q9oBR/WEWFofNx?=
 =?us-ascii?Q?KtWVQuYON/DE/+Hb3yaA/zdDGx+46nh50HJGnBY/J6inQz25yp+uU/3TuCo0?=
 =?us-ascii?Q?iP23/tYnix9NVw+H0+T8U3hck2U49ydr4BWhaCioHbWqE2UVgxtd8xOKFLdj?=
 =?us-ascii?Q?xf2rihE2muv4EzWtby8a4Ne2mAmPZhWhDPGvMNE3/UplLmcugwp4MD/UTgnr?=
 =?us-ascii?Q?FFOpQ4Qb6ov7FP36XqhrqtFTmt7f6PTfpSKHZGn4HokpHMP72jItVZ+CqKm6?=
 =?us-ascii?Q?Dq8E4aDYsGsaeyFZ7sG5Htlenque61VMlals9snI8v8XvXPsD1GE9IzLQ8bx?=
 =?us-ascii?Q?GmUUo5AbYQ02yP8L+ZBUip2DFJwlznzX4AyRgbNTWiGRsqbC4dEvK27MyPNm?=
 =?us-ascii?Q?i+YyxmhlOgSjG7ySCTmJclJ48xjsBAB+3+3BP5o0yum8bXizXaswSzObbtwy?=
 =?us-ascii?Q?u3cqwnMZgOYlrXUi8qUoey7nsBd5?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(82310400017)(376005)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 02:30:01.0715
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d10fbc8-53b0-4d14-8d49-08dc72f49728
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7784

On Sun, May 12, 2024 at 10:26:44AM -0300, Jason Gunthorpe wrote:
> On Fri, Apr 12, 2024 at 08:46:59PM -0700, Nicolin Chen wrote:
> > Currently, the object allocation function calls:
> > level-0: iommufd_object_alloc()
> > level-1:     ___iommufd_object_alloc()
> > level-2:         _iommufd_object_alloc()
> 
> Let's give __iommufd_object_alloc() a better name then
> 
> It is a less general version of iommufd_object_alloc(), maybe
> iommufd_object_alloc_elm() ?

With the level-3 allocator, something like the followings?

level-0: iommufd_object_alloc()
level-1:     __iommufd_object_alloc()
level-2:         iommufd_object_alloc_elm()
level-3:             __iommufd_object_alloc_elm()

In this case, this patch will be:
"iommufd: Rename _iommufd_object_alloc to iommufd_object_alloc_elm"

Thanks
Nicolin
