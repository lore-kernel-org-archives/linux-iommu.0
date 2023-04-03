Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FEB6FA1
	for <iommu@lists.linux.dev>; Mon,  3 Apr 2023 15:24:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZw6TsbOtavNeM861mhVoKB1YibgoZYgDUOjG5TyGQd33+0Q9whGHQw+eLRDjJJt2pdsctZdm2Kkcy8m0SyyG7nLfOu0cHD9CHuuTC4Bm3/fy9C9td9ySoxlZHDybD/V5OZJ+LtTKcKnEq74JLs84Wcp16BtX2SnbKh2CbKqINCf0O4SU9VoLP32gXd1E4/21VwolzQ60Q17jaeNmUAm0e2s29S7N5Tmg6g1GMYf7Gab9JKw22WF3bAYu5xemZCpVXSjbn+lj3WrckvM/TPTLkq7wNFUGdpD7CxLeUKjTVvzYMw1kSP91BGoCBcr+7Hmbyhj/0ZHSGg3YC1zpVfDPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NzzVDJ5YRNGVPCEcI2RV8lK6+tHTQpoxA391l7BvTes=;
 b=fQIhS/tRHt+Bx1Ppmkx12CFAAu3LQ3D8sIaON1azWHLyEQFN8dKHtSHddxYugSefcM9kPdQbiOxC3OqFwddbgheXAiYRIeEVAi2Wltpze5gmdHcZmcFPMblQj3KODVu8pvTKpQJ6xsreqzKcHke6okcigfcn56VKa3ynKIp7t+dWSWLFAF5lkO/xuIcR7bQdouIfiPMqFkEkQ0yBlerUkkN1aIoPY8bxkU+g1vMia4J2u8y5jHXXJaU8ZIF9VzKiaEyHKpsA8X70JH9z6dTpQt4wNJ4HFHFXJnx9W+kRu/ut6AGVLgidEHqmbgtVFMw3ZaaLx46FRZndsv/2vY+oaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzzVDJ5YRNGVPCEcI2RV8lK6+tHTQpoxA391l7BvTes=;
 b=I1bjRrTKeuoPIU3b6E7tYpsmbuM6f5DKgWD5+RjxJOOIgg8QyLCPVizkyHpZQfUDy8Upnv1/lNn6R3bG4auMR4muvVMH7KPkIgujBhUFTlqT4ofrhWe4A9yzlYDNfIMfhQw79v8dfJPg0iF9GYFuTYHF82zS/aidCPmmrIQWpVPb6Sd05yUI/ZhChcQPGebeZypuseI69/VAFeWyRMHwUMXJC8RZE2NApZo5ShA0P3Jc97JEVGSNVz3au1r5JiFvZGKfK6YWd5QmEp0g4wgT0jRs+LNbOhcVOy7qsSz1ASj0yy4BmNsIAjn98FJ6J/4kUXUT0Ysuj7fpirKNkqBeIg==
Received: from DS0PR12MB6415.namprd12.prod.outlook.com (2603:10b6:8:cc::14) by
 BY5PR12MB4178.namprd12.prod.outlook.com (2603:10b6:a03:20e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.33; Mon, 3 Apr 2023 15:24:36 +0000
Received: from DS7PR05CA0050.namprd05.prod.outlook.com (2603:10b6:8:2f::9) by
 DS0PR12MB6415.namprd12.prod.outlook.com (2603:10b6:8:cc::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.33; Mon, 3 Apr 2023 15:24:35 +0000
Received: from DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::3d) by DS7PR05CA0050.outlook.office365.com
 (2603:10b6:8:2f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.28 via Frontend
 Transport; Mon, 3 Apr 2023 15:24:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT096.mail.protection.outlook.com (10.13.173.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.20 via Frontend Transport; Mon, 3 Apr 2023 15:24:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 3 Apr 2023
 08:24:22 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 3 Apr 2023
 08:24:22 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Mon, 3 Apr 2023 08:24:21 -0700
Date: Mon, 3 Apr 2023 08:24:20 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Robin Murphy <robin.murphy@arm.com>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "jean-philippe@linaro.org"
	<jean-philippe@linaro.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"peterx@redhat.com" <peterx@redhat.com>
Subject: Re: Cache Invalidation Solution for Nested IOMMU
Message-ID: <ZCrvpFqrUZH/9pYI@Asurada-Nvidia>
References: <ZCoe3+1q5ZLJsmeC@Asurada-Nvidia>
 <DS0PR11MB7529BD4A1AE9E75E1408DA4BC3929@DS0PR11MB7529.namprd11.prod.outlook.com>
 <BN9PR11MB5276462BC1879715BC15380F8C929@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276462BC1879715BC15380F8C929@BN9PR11MB5276.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	DM6NAM11FT096:EE_|DS0PR12MB6415:EE_|BY5PR12MB4178:EE_
X-MS-Office365-Filtering-Correlation-Id: 11dc6d62-2e18-4b6f-e657-08db34578810
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	k3qZSQXpNTNJsz9gc92GwxgooLWCTQPShfVQG3vp/6rjLGJ/qQPv1u/NtpPmtBfoWbbh52JRLaIYSNHmvBfT09y2jtA5dLewOi0nhbnbgo+BorehNd+z8fC3RBR69YFV7Cp8LiuXT/O/i2Lz2ZsxEXpHsf09RUqOZEy+oFBBQkAStm4c4m+HBZMYIhNA8eCAhB4E6DG1wUzYw+p6QrzpDAP1cxFs8pgSQeGp1WjTyziV19fzvKhj4nZxygFQsXpcWCoLji6fMTuOAbC+W0B4UfBCHHgBBUuk/jF74QrHgs6hutDMJhafF/q9RWgdp6nSm7kNrEtmkvqhR3dw2MvGhDVXHTqNWIVJWo62LP5Cc+35ABSYlZt+AceDQXe3EJ6Z0qjqWkQln8367vBOXQMWTt2HyOjUcYxoP9ZYXnVpEWTEFsH8fV8aYRjdJtkZOomTy2IKOe6exQDX+2OIPLbeNKCcI8tZtWQh/lHA8WTcLut6jttedFy+JyzW4uBSUHj2aqywEKwJSMgl5k+1aS/mH+wqLEvI8wUkx+de0a9hrryJW4VKPkpoa9+Nwe1xsnYtq/LdI4fdEoJbjLDAkVRXA6lSPUiYeIWN6/GRtUVGOMTXZKdaTK+jSLaNa0Yy3TxLlNElMs41+AjbNqo+yG7HtDtNg3P2U+OVA0VSXHjsMq17ziM6ECgv3QUc6wLg6XvRmSKtoW287Lf1kFFd8eNY+4++ab1QbNdBUnAyqIkSTL0BRKn6OTgzIqwp9SAO+A8cm0NDZ27QEoZSJZU8GXkOmpmUsI2xNoSmkGMHz8nKZjmFZ7wFdFGHoo241gUnyWEF2kXmZdKaSoTfrHBTKIsmng==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199021)(40470700004)(36840700001)(46966006)(40480700001)(55016003)(40460700003)(8676002)(6916009)(70586007)(70206006)(36860700001)(54906003)(316002)(478600001)(4326008)(8936002)(7636003)(41300700001)(356005)(82740400003)(5660300002)(426003)(186003)(47076005)(83380400001)(336012)(34020700004)(9686003)(26005)(86362001)(82310400005)(33716001)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 15:24:35.0946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11dc6d62-2e18-4b6f-e657-08db34578810
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4178

On Mon, Apr 03, 2023 at 08:39:02AM +0000, Tian, Kevin wrote:
> External email: Use caution opening links or attachments
> 
> 
> > From: Liu, Yi L <yi.l.liu@intel.com>
> > Sent: Monday, April 3, 2023 3:26 PM
> >
> > For VT-d, except for the device-TLB invalidation, there is no RID
> > information in the invalidation command submitted by iommu driver.
> > Device-TLB invalidation would be somehow an included operation in
> > IOTLB invalidation if the page table is used by devices that has
> > enabled ATS. So guest VT-d iommu driver may not use the Device-TLB
> > invalidation. So vRID->pRID conversion may not happen for VT-d side.
> 
> Guest can still submit a device-tlb invalidation descriptor. Just that it
> could be skipped as a nop here if the host always invalidates device-tlb
> when handling the iotlb invalidation request.

In either case, it sounds like RID isn't needed in VT-d case?

SMMU needs vSID<->pSID info to verify an ATS invalidation.

> > VT-d side requires vPASID->pPASID and vDomain_id->pDomain_id
> > conversion.
> > vPASID conversion may be needed later as we may disable guest PASID
> 
> vPASID conversion is mandatory when we enable vSVA on SIOV device.

vPASID is allocated at runtime, so the hypercall timing is a
bit different than SMMU's vSID. But I think it could go with
this uAPI too? We'd just need to turn the uAPI to a shareable
one.

> > support at this moment. For vDomain_id conversion, there is a gap.
> > Domain_id is not global today. So if there are multiple vIOMMU instance
> > exposed to guest, the vDomain_id would have conflict between the
> > invalidation commands submitted via different vIOMMU instances. Even
> > we may make its allocation global, I'm also curious when and how should
> > we build up the vDomain_id->pDomain_id relationship in kernel. Maybe a
> > new iommufd uapi just like the vRID set? or it may be part of the
> > device driver's attach_hwpt uapi (e.g. VFIO) as this relationship should
> > just exist when the hwpt and device are attached.
> >
> 
> IMHO we need a vDID->hwpt conversion i.e. the kernel wants to know
> which s1 hwpt is covered by a vDID. From this angle adding vDID at
> attach_hwpt makes more sense.

I share the same view. A "vDID" is HWPT oriented, while that
set/unset_rid_user uAPI is for passthrough devices. So, it'd
be probably better to go with a different uAPI at least.

> But honestly speaking I'm hesitating to introduce native format and those
> assistant APIs for VT-d at this point. Supporting in-kernel short path
> won't happen in short term. What we defined now may not fit the
> requirement when it comes.
>
> With that let's continue to define a customized simple format for VT-d iotlb
> invalidation, plus allowing the user to batch the request. Having extra
> packing/unpacking overhead is negligible compared to the long invalidation
> path at this moment. Then we can consider native format as a 2nd
> supported format later when in-kernel acceleration is being worked on.

It'd be okay to do it later for VT-d, so long as the uAPI we
add for SMMUv3 would potentially fit VT-d too :)

Thanks
Nicolin
