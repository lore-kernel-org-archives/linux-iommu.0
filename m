Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CA1EC5
	for <iommu@lists.linux.dev>; Thu, 23 May 2024 04:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716436931; cv=fail; b=uQ5q+hzKdEwY4QaqLxMPJNGHLjK0QKObA+luB8AePKRshvX8SUBXtYPOfQpsq76ZXuE/3J+RJPujXG+eDgWF2ZkHA8/jEdJLCasuA6/EG5dyy9umLsIXdEgc+MOVKBNKig+6YJ1JsXvBkwjq9SPebWrwjj37DODYv9sAn0LKT1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716436931; c=relaxed/simple;
	bh=1VyyIyuGeXF+P+mXNm72RpNrub8EFrEY+IN1Tc/tGkw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJpceOZN9fI576RDYhcsr+WWKnpaOa6sMu5aNwX2v0brTNmCZIfwjTR7oF6c8DesTs4gOfsVMxjtOYJJEcCx9tM1xXXj3KT57SQks/NpMoIP1QFXLA63AakE/CCceQ6MaJzg6BkmlQkwd95fxzl6SMWlxSmbDK518OayEo8r5nE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JdErt27o; arc=fail smtp.client-ip=40.107.92.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JdErt27o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipOv/4D/Z4adzXdleNgwadkpNswyVkQku6F1Kw3gZ6EvMYG8ujbsPM4Q6RyRB7u49Q3hJ8RMBcm8PEIbuHPORZckjy0rqNW74CylcMjeuRyOy8v3Pxg+iPooe+mA0gEEztPQNLgp7daW9UKynHOZJpv2RkNwzP+CL9m0rkBMmYpRq3kXioxYqe4lta9AOOx5yhvTCcX1Z3lam6H5+yyT4woLQzT5oZxv2fidTwvDYkcCsiPGdK1qpZcqBx3+mBD4DqI+VS7j4rO5y8tYUrDLG+gEWa2FNN/oyRV2RJgJ8Zjik3hfyJKjNXMjcUkcw3RMKCNxU7+qPAuMXxfbS/RGBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqcJvF3RIFyP59Sa5TRtC0oqFCSO7fC8X/Q0JQ4LmO8=;
 b=jyUG7vd+G8DQjp5ate+rUY30qemyieePv2N8vUF6uaI0CY0QnWejzHT+dr0WJCilRBka/LpmfuHTncKcPButoGSZMlI5cYXX+9INjBK+BdjH5gyF1idZivo2vDDDoXDjqoNTvxZFpDz7n73qmq3A1A+1xGT5jqxTdrxMJauFk+EyInrEtAzJW+FykAjUucq0zCINUITSYlahCvK2j4CgWm2bxO2VNsGnRwSkjMpP71+0OOX6H2kJReF5Ph2V2PlaZDyYXpUAW568iF9zui0Wa0VSpF0MwzqYwWgarG4IEWfOIjTpOyBorjSSL8haGMwWKZNXWELVkX86Rah5rJcccw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqcJvF3RIFyP59Sa5TRtC0oqFCSO7fC8X/Q0JQ4LmO8=;
 b=JdErt27ouaQUyQknaN5aJAbKhBc1ZaJjxdqjSC9uGw2J0+Vi3A3XQVQtK4b/MAYECDxoDrn/dZGYBJQjyYNi9NBrOIiSWssi3+csUGbdAWZ3NJEDZ05d0Vn5Z6T8rDpo/nd5Z3k+jVLK1Lvg1Bpa9f7eaCIbX/954QQPfNNoni+C8VEsPwwQBqUzarKdJ2frCDtuAd2+zZP80qwUQ2Gg5+BIciJKXipMyEb65rve/K/wESeoUGOlvFtZl+WRfwsA5Zq+Xh3HSSqVEuNE6PPfb53PweiJ7MtoPvWSUdVoTZXfTAivtRCUj+y7uuCb6ZbEyE/x1E2iUKgPU5OJ3+fLQg==
Received: from SA9PR13CA0169.namprd13.prod.outlook.com (2603:10b6:806:28::24)
 by MN6PR12MB8565.namprd12.prod.outlook.com (2603:10b6:208:47d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.20; Thu, 23 May
 2024 04:02:06 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:806:28:cafe::5c) by SA9PR13CA0169.outlook.office365.com
 (2603:10b6:806:28::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19 via Frontend
 Transport; Thu, 23 May 2024 04:02:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 04:02:06 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 22 May
 2024 21:01:56 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 22 May 2024 21:01:56 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 22 May 2024 21:01:52 -0700
Date: Wed, 22 May 2024 21:01:50 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>
CC: "will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>, "jon.grimm@amd.com" <jon.grimm@amd.com>,
	"santosh.shukla@amd.com" <santosh.shukla@amd.com>, "Dhaval.Giani@amd.com"
	<Dhaval.Giani@amd.com>, "shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH RFCv1 04/14] iommufd: Add struct iommufd_viommu and
 iommufd_viommu_ops
Message-ID: <Zk6/rpwvh5lMck2I@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <8610498e3fc00000e78bb9cef6fac9f6a54978a4.1712978212.git.nicolinc@nvidia.com>
 <ZkDMSfd9BXmsFfb+@nvidia.com>
 <ZkGKKoHnykAdGJq6@nvidia.com>
 <ZkOJgvMNFaZZ06OO@nvidia.com>
 <BN9PR11MB5276423A0BFBDA8346E1ED3C8CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240522133905.GX20229@nvidia.com>
 <BN9PR11MB5276267BB1CC4AA7008AFBFC8CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN9PR11MB5276267BB1CC4AA7008AFBFC8CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|MN6PR12MB8565:EE_
X-MS-Office365-Filtering-Correlation-Id: 63814427-f490-4926-0ebb-08dc7add1ca7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|7416005|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QVVMdEg2RFMwdzh6Mm4reHZpYTBudXRyamF3L3JrVE42aXpzbU1MdEZxTURj?=
 =?utf-8?B?ZTdVWHF5UEUvd3FvdFFEV3VyMTJRaXVsQWZFbEZab09oc2xRdk1NdlFIUGla?=
 =?utf-8?B?YktocENMUW1aelNrOG5CWVlpa1EzOWlHRjhwYTEyK0xVMTNhbVhuRHFrazRs?=
 =?utf-8?B?T0ZtTVI4dDhBWWgwZkY1dTMxWDRZZHpzMlhENFNQaUZqK1QxZkxJVzRUclZv?=
 =?utf-8?B?WGpTKzZhR2NvMnZRQ0lxUnFjelMrcDFUMjRTK1F0MjF2TW9mQ0NUaTl3N2JY?=
 =?utf-8?B?bGZ4Q3JzVlR3ZEN4elR4ZndYN28xdHYyVjBMSVBNT3pXQjFGb2kwZGM0dlpv?=
 =?utf-8?B?bzhuYTJBSStkWVo5aEhUT01GekcydTB3VS80OGRzZTZzQmFNVzdOKytNUVpR?=
 =?utf-8?B?Q3NzVGVMYm50YjhQYnpRQTJ6WU5GMitDOTEzemZoMG43bVZTNThCck92YXFG?=
 =?utf-8?B?MWFSZHYzZTc4bklaQ25EandkZGZVdWRoaWJvTEhFOUs1dVFWVThNNFZzc3VN?=
 =?utf-8?B?enpQWEtLVGxtOWs4SWc0UDhnVzlVVDQwYk03VmM3cmdlSEtXL0phUGZZZEpa?=
 =?utf-8?B?RkU2QTBBWW1na2dpelhoRitXdXBWU3pkVzRPd0pOUkxHUkMxWUozR0I0UWow?=
 =?utf-8?B?ZENsbmkybGhZMzlrUlZmMkxsMXc1TWRON2x4L25LUkNRWU54ODVNZzhKNktm?=
 =?utf-8?B?VzFZdUJTL09yamNyTngxT1VQK0l3NVhBTmNOM1B3UEhORWVUYmVvWVBib1Fo?=
 =?utf-8?B?WlBvbVdOcUpVWnpaUU9VUnNpcUUrU0VBaEM4aWVsNzVwalgxT0F0Q0FwZ1JP?=
 =?utf-8?B?QnYwRWtEU2FkQk9EYXcxVW1maFNMbVpxazdnWlBCOTZCNGgwaDA0M3pQa3Mw?=
 =?utf-8?B?b0VmZUlSN1pMTVVUYThEc2VoNjBmWmxhNXFMT1ErbTJHVk8vQUppOGdtYXhL?=
 =?utf-8?B?UWFHeXpXZGZaQXVDT1ZKNDRmUnBPZ0R6SlJpcDJCZnB5d1NFcTA2eC9LVVhi?=
 =?utf-8?B?RHAzV3I3TDMvQ0NiYlZ2WDI1SHpVRDIvVjlUQzNrRFo2SlRheDNtS0h2ZjM4?=
 =?utf-8?B?QlNjTmJvcnRhVVlmUEgwdi84a1lWMkVsUXJDUHFDSG5GczF3a0srOXgxaVIy?=
 =?utf-8?B?UjdIaFpBcmp3NUVjRlllQUQrQnVxbVgxTmVMbnVYM1dna3h6KzhsYTBmaFV6?=
 =?utf-8?B?UHVXRUJuZFQzc3pLdnZPcEwvTUdaaW9Ca1NaNVFJQjNZeWhmam5EdHZBblUr?=
 =?utf-8?B?aHVLQ3h4ck0yTVNYNTNiQjIyVWoyNEYxUmd5Wm9xNmtVT1dsMnhpZDNqMndS?=
 =?utf-8?B?NXJlQ2FRaXFwclpTNk5DNWhSRlFnR05tWjA4aDhFRFl1bkxEaGpQeTI2dXpP?=
 =?utf-8?B?RG55cWhzWVFGMUNWLzJpTHUreVY4eFJNOHdhaXlXQmdOUlh5YlJMTThPZHpB?=
 =?utf-8?B?K3ZTcG1xL0ducWc4REJIRHFDNmFOY1ArbExXcHdGL1lzWERvdFpqUEg0cGNX?=
 =?utf-8?B?eWhoZzBTRE9sUklGd0VweEZQOTdRV2QyM29DWkdKNCtEWGVTalAyZXFiekNn?=
 =?utf-8?B?c3ZOSW5BRGR2ZmdxYk5scjBaalZLZ0lYOUZ1TFhNYzVRQ0Q4QjFFemVnZ3p4?=
 =?utf-8?B?RS9DSjZBK1ZwNXZDd2JnaFgrZXdrVGdzcXcvclgyRjBMUThualBPV0lMUGJ6?=
 =?utf-8?B?MjhlSTFjbzdvRW01U1Bxck5KaVlubG1qekwwcnlQT0FjR0V5QzJ6VjZ4eFY0?=
 =?utf-8?B?Q3kwNG9TeC9vY3BYM1ExOTFaTG1NYVVETXppZVpjMW5hWitGanJsNVpHVkFM?=
 =?utf-8?B?YjRNaXJLRHJoSjJsWlhTYTRYeng5aFdzYkd0Um1KZ2lvTDJhNGNReU9ZUEk3?=
 =?utf-8?Q?u55rsrloGZK5e?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 04:02:06.4651
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63814427-f490-4926-0ebb-08dc7add1ca7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8565

On Thu, May 23, 2024 at 01:43:45AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, May 22, 2024 9:39 PM
> > VIOMMU contains:
> >  - A nesting parent
> >  - A KVM
> >  - Any global per-VM data the driver needs
> >    * In ARM case this is VMID, sometimes shared with KVM
> 
> In which case is it not shared with KVM? I had the impression that
> VMID always comes from KVM in this VCMDQ usage. 😊

Not actually. I guess that shared VMID is for BTM.

> > On ARM the S2 is not divorced from the VIOMMU, ARM requires a single
> > VMID, shared with KVM, and localized to a single VM for some of the
> > bypass features (vBTM, vCMDQ). So to attach a S2 you actually have to
> > attach the VIOMMU to pick up the correct VMID.
> >
> > I imagine something like this:
> >    hwpt_alloc(deva, nesting_parent=true) = shared_s2
> >    viommu_alloc(deva, shared_s2) = viommu1
> >    viommu_alloc(devb, shared_s2) = viommu2
> >    hwpt_alloc(deva, viommu1, vste) = deva_vste
> >    hwpt_alloc(devb, viommu2, vste) = devb_vste
> >    attach(deva, deva_vste)
> >    attach(devb, devb_vste)
> >    attach(devc, shared_s2)
> 
> I wonder whether we want to make viommu as the 1st-class citizen
> for any nested hwpt if it is desirable to enable it even for VT-d which
> lacks of a hw viommu concept at the moment.

I think Jason is completely using SMMU as an example here.

Also FWIW, I am trying a core-allocated core-managed viommu for
IOMMU_VIOMMU_TYPE_DEFAULT. So VT-d driver doesn't need to hold
a viommu while VMM could still allocate one if it wants. And the
VIOMMU interface can provide some helpers if driver wants some
info from the core-managed viommu: a virtual dev ID to physical
dev ID (returning device pointer) translation for example. And
we can add more after we brain storm.

Sample change:
@@ -623,6 +625,18 @@ struct iommu_ops {
+ * @viommu_alloc: Allocate an iommufd_viommu associating to a nested parent
+ *                @domain as a user space IOMMU instance for HW-accelerated
+ *                features from the physical IOMMU behind the @dev. The
+ *                @viommu_type must be defined in include/uapi/linux/iommufd.h
+ *                It is suggested to call iommufd_viommu_alloc() helper for
+ *                a bundled allocation of the core and the driver structures,
+ *                using the given @ictx pointer.
+ * @default_viommu_ops: Driver can choose to use a default core-allocated core-
+ *                      managed viommu object by providing a default viommu ops.
+ *                      Otherwise, i.e. for a driver-managed viommu, viommu_ops
+ *                      should be passed in via iommufd_viommu_alloc() helper in
+ *                      its own viommu_alloc op.

[..]

+int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
+{
 ...
+       if (cmd->type == IOMMU_VIOMMU_TYPE_DEFAULT) {
+               viommu = __iommufd_viommu_alloc(
+                               ucmd->ictx, sizeof(*viommu),
+                               domain->ops->default_viommu_ops);
+       } else {
+               if (!domain->ops->viommu_alloc) {
+                       rc = -EOPNOTSUPP;
+                       goto out_put_hwpt;
+               }
+
+               viommu = domain->ops->viommu_alloc(domain, idev->dev,
+                                                  ucmd->ictx, cmd->type);
+       }

[..]
// Helper:
+struct device *
+iommufd_viommu_find_device(struct iommufd_viommu *viommu, u64 id);

> > The driver will then know it should program three different VMIDs for
> > the same S2 page table, which matches the ARM expectation for
> > VMID. That is to say we'd pass in the viommu as the pt_id for the
> > iommu_hwpt_alloc. The viommu would imply both the S2 page table and
> > any meta information like VMID the driver needs.
> 
> Can you elaborate the aspect about "three different VMIDs"? They are
> all for the same VM hence sharing the same VMID per the earlier
> description. This is also echo-ed in patch14:
> 
> tegra241_cmdqv_viommu_alloc()
>         vintf->vmid = smmu_domain->vmid;

The design in the series is still old using a 1:1 relationship
between a viommu and an S2 domain. I think the "three" is from
his SMMU example above? Leaving it to Jason to reply though.

> > now. If someone needs them linked someday we can add a viommu_id to
> > the create pri queue command.
> 
> I'm more worried about the potential conflict between the vqueue
> object here and the fault queue object in Baolu's series, if we want
> to introduce vIOMMU concept to platforms which lack of the hw
> support.

I actually see one argument is whether we should use a vqueue
v.s. Baolu's fault queue object, and a counter argument whether
we should also use vqueue for viommu invalidation v.s an array-
based invalidation request that we have similarly for HWPT...

Thanks
Nicolin
