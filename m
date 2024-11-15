Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEEA1E9099
	for <iommu@lists.linux.dev>; Fri, 15 Nov 2024 21:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731707197; cv=fail; b=Q0uM3vwKIfGm6DcV8WfFNOGGrZ2Gh03IIkypPel9/EG0wYeK8J1nF52CAEMWrCERiiF69T5shjJ6JB+2qwHBuqe0EjsqZ6EYtA0JAQB7Gwu7tRRXOYLrSe9TOq4qZCv7znrnpLx7+J2n8R+utlMOIV1K0nn2nurE2p12G1GPlEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731707197; c=relaxed/simple;
	bh=lWx4GCwbZtCdmzThV3wRi6YVOTLdOgoFnhRWzEQL6Q8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rBseTcTROwwpjBs9filOt8IKQhU9RmCi0jloxxOJZl95z0cn9yWGcPJZkDhkQ8foYIYB8tG2pl4B2u8zavUTccsDQkrxS1tmL0mB9dW7EA8KA25srFEcPGzumMseTWS+4K09RfbVIqBkVXaJxlp/o5vZ/u6yEYm029fO7eMw2BI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ow5LgAyu; arc=fail smtp.client-ip=40.107.244.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ow5LgAyu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ahRcRztoDttMAk6lJKcC2icL6E6KNsRE7r51x5B+6U4YeIyEs2aGQ3yz+Q1FcRSYAgkrYdUwmWIqgNhqyHRKpy4OkZeWOoMp3jVWNA+T24gaROmz1pv/ZBec0ZnzQsXCKrzXI6cq3liYAkKSSrUcCGw/xERkZP1/XhkuLFHR41RTeUi33FdDM7M/L5K//BUNzROxdr6P3ep9njbSjGDNGrDwobnSIilsjQlAAUE7HI1QxyXJl/FY8J8hma+/Lrrhxv7leS9f7S+CLaGR55LWuHcXfj8PIp4v82Ef1EIsUUfiuWxgYNWBM51mLCc6xd3Tqc/I2Af1Nv9Olx/hS6/6dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDKr+TY7PcnuMfbsyltmp5Ia+0MfNLfzt8Fx7ESqI1M=;
 b=ReKyHSdio8byMPhwrOyWA47ihrAzd6s/zM/jRZ9SJb5JPBAzlQNDAQmVBnWjngGFmZWCH4Rt5oq7RJbW4ktkcvN1cHktREiNDZU6kmZ+nr8+OLCpSttLsJIw037jwi4YioXp6Kb4jGbK7t890ssMZbi9l2qSZskWw3XkdRLDcE1Qn0tvp4d5nNTd9FxI1pTvLj36qM21p33ngSKKgpvfyZmBqKa1IXHo1YPl9T2AmhPNLLpitVVNPiyLgMS6HO07mvD8Jd4RM4E4vM2La8g+06sFrzHuA0HUdc/ZeVqGRKSnx4WWzFDzWGUUfkYKF9RjbOh/+CdTmE/rqMc4B0HWbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDKr+TY7PcnuMfbsyltmp5Ia+0MfNLfzt8Fx7ESqI1M=;
 b=ow5LgAyuSYug2c4QJGhT3EsrQ3al1P6dPRVzNpvPZmeYsWq1kLIPgG5WR9zdJySR8nlJwaOcx7UXySvrVHF0Ki2+/IRO7SwIh63pcaG2G2pEdBhVSe/vUd7tTlCk85gGoMb6I4WtKcvAMEuVKnyuNGMZA632LFPBClw7Rdkgdy3R1dMjlnHTFhEIPv0a2fn7zwNgpDDP7w1yfDCfRmPW6O6ReroIbR5HISHnqWZTh0aPPq1o3N/BXaxm0Ig09SUXAwpqr7ApgYYtu6AVQA5OrXB3JY77lyYnypinL0O53dFEnKgJWcasGoNftgaXCD+j8+435V9YpLpA45UMKUC4Yg==
Received: from PH7P220CA0069.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::18)
 by SA1PR12MB7245.namprd12.prod.outlook.com (2603:10b6:806:2bf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 21:46:29 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:510:32c:cafe::9d) by PH7P220CA0069.outlook.office365.com
 (2603:10b6:510:32c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18 via Frontend
 Transport; Fri, 15 Nov 2024 21:46:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Fri, 15 Nov 2024 21:46:29 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 15 Nov
 2024 13:46:25 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 15 Nov 2024 13:46:25 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 15 Nov 2024 13:46:24 -0800
Date: Fri, 15 Nov 2024 13:46:23 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Mostafa Saleh <smostafa@google.com>,
	<iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Daniel Mentz
	<danielmentz@google.com>
Subject: Re: [PATCH v5 3/3] iommu/arm-smmu-v3: Avoid redundant master lookup
 in events
Message-ID: <ZzfBL7/crImODK7H@Asurada-Nvidia>
References: <20241112083018.1662104-1-praan@google.com>
 <20241112083018.1662104-4-praan@google.com>
 <ZzPqRH57RjNS+lJ8@Asurada-Nvidia>
 <ZzdL_mC7ZiWVjtoQ@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZzdL_mC7ZiWVjtoQ@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|SA1PR12MB7245:EE_
X-MS-Office365-Filtering-Correlation-Id: 268209dc-f76a-4932-9b6b-08dd05bef667
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?309TO/jPFnVdY5WNnJzCllIb6q8WSgsBoM6QFZ+MOp75RNEKnCGCrXGDlIKC?=
 =?us-ascii?Q?UFexikMpPy7aCSRDbsr30yH/OvpdxgSL/yeCvRYxrOUBoTnCUDlsG5o+bkoY?=
 =?us-ascii?Q?9cO78uLZGXzfqGCYpIainVdjn/1alnuqZzhqjny5TU2uxGhm6lRjHN8JR4K3?=
 =?us-ascii?Q?w4Eb/NI45VO6XtB3gy8DyoFgsbXQQoyFYEcSNX3HMs/EwDcpU3vwvSRBCdJa?=
 =?us-ascii?Q?Sa005tyVBgehfyYqhDYhSjgmcJkdqlNShxakVtYZ1yx6MsjUVVnqUH1C1osX?=
 =?us-ascii?Q?V/5++xX1DHi2GPHKOwfV7F/fJLNf+c8wsv6SLNFuViWU+S98vUGJ+ONwCTQS?=
 =?us-ascii?Q?nd//SpVSV5zQj1sgt3O3cUCN3+rrHlbCMgfphvomI4c27vn57t2kKUi7ZEsn?=
 =?us-ascii?Q?1KYifb3Dd7I5kQNhkArOIpccbLavc/EF/lpzy/AI6Bk5hU3rVTMdf582jK41?=
 =?us-ascii?Q?nCJAaAiJEnn6rQK1weDcXnzcI0eEgRditTA0S/IK7HlaFZa52L0QFkK4xmP3?=
 =?us-ascii?Q?55BsIjeLwSgUCAIujsmlFls7K3R9rL0LDRJvs36oVUuaYrOu+Cl5udViQEAR?=
 =?us-ascii?Q?ZePl4eaAFln5groggHJVfzKmOCzZjPGAhev6S0Dw16qonfxHuMPzfi6j9tCk?=
 =?us-ascii?Q?k4Gs+dLY9vDKBWKvo4CvlMpg8/fTXuAa9JyXeErLpHrVpRygikt+TH7OdNaq?=
 =?us-ascii?Q?krBeLP7s+0DOoGNYXDg0F08u35wuqgKkKQtJ2ZQ8TfJD5PVpUtem2YPm2bkx?=
 =?us-ascii?Q?dBvX3dZyEK2aW9xinDSVXK6/B5VUieHrU3Z9KP7zvbviqwLXKhwnEOWe7myh?=
 =?us-ascii?Q?e8Ko70VqYyYvoORVo0RR1S/CXt1aUg3nzCvApVhc9UZ+No+FqB41mDc71sXZ?=
 =?us-ascii?Q?XL+8OVAM7PzqP+VvXebmDw/YC+LxvRCwgEsiBUkYqAN7loYqklKRAn3ai0b0?=
 =?us-ascii?Q?oavzJg1TcPkvdYtsIEfWoMheD9WAonlPykwwOe6n/TCw7vC8C667fFK2i8Tf?=
 =?us-ascii?Q?EyGv+SKmGFyN4eGfV/xCKDaN8kVzjw8/P2n1zl3u+bCct0u9pn1IGgpENX2B?=
 =?us-ascii?Q?Srmfjj/iOhL4lCNvK6LK9FuzFwa3g/sq8UwMt0ZSyzw27yBXBuxL+5VnFYdN?=
 =?us-ascii?Q?XlfybXYas+qKuTzKfhqzmtnzv53bAN3yOMhXlb6kCnjqUSf1REo6p8IV9VY9?=
 =?us-ascii?Q?2L7fAUS+1MfZnNHk2ntmhcQgaIpkv2zPxrfvzbRzVTk1RRTlbjLAM5GyZ0f0?=
 =?us-ascii?Q?CB/nJGp5ipm/VA/oizeb6aQtqVSemeeN2q4yflKAMnIsdX3PPnLTiVUnBBCZ?=
 =?us-ascii?Q?695Shb/vcDFC3Tq9js5eFNMQ5Sinai1kYVHfThyLIkBt3du156zTKWE19Zt/?=
 =?us-ascii?Q?YrXNvDAD+h3stB6Nn14bE3nSVazmk7lj7dHmrIrbKsploC+Rvg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 21:46:29.1451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 268209dc-f76a-4932-9b6b-08dd05bef667
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7245

On Fri, Nov 15, 2024 at 01:26:22PM +0000, Pranjal Shrivastava wrote:
> On Tue, Nov 12, 2024 at 03:52:36PM -0800, Nicolin Chen wrote:
> > On Tue, Nov 12, 2024 at 08:30:18AM +0000, Pranjal Shrivastava wrote:
> > > Remove the call to `arm_smmu_find_master` in `arm_smmu_handle_evt`.
> > > 
> > > The call was primarily to retrieve `master->dev` ptr for reporting iommu
> > > device faults. Since this info is already available in the `event->dev`
> > > field, we no longer need to lookup the master to fetch the dev pointer.
> > 
> > We only protected the "dev" for dev_name() while the streams_mutex
> > is still required against arm_smmu_remove_master?
> > 
> 
> Umm.. as per the code upstream, we were just finding master because we
> wanted to pass the master->dev in "iommu_report_device_fault", thus even
> if the master is free'd by arm_smmu_remove_master, the struct dev
> wouldn't be free'd as we still hold a reference to it here due to the
> call to get_device in arm_smmu_decode_event.

The iommu_report_device_fault() needs to dereference dev->iommu
and dev->iommu_group, both of which might be NULL if the master
gets freed?

> > > @@ -1857,17 +1855,14 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu,
> > >                 flt->prm.pasid = event->ssid;
> > >         }
> > > 
> > > -       mutex_lock(&smmu->streams_mutex);
> > > -       master = arm_smmu_find_master(smmu, event->sid);
> > > -       if (!master) {
> > > -               ret = -EINVAL;
> > > -               goto out_unlock;
> > > -       }
> > > +       /*
> > > +        * If the master wasn't found while reading the event or
> > > +        * get_device() returned NULL, we shouldn't report a fault.
> > > +        */
> > > +       if (!event->dev)
> > > +               return -EINVAL;
> > > 
> > > -       ret = iommu_report_device_fault(master->dev, &fault_evt);
> > > -out_unlock:
> > > -       mutex_unlock(&smmu->streams_mutex);
> > > -       return ret;
> > > +       return iommu_report_device_fault(event->dev, &fault_evt);
> > 
> > Apart from the question that I asked above, it'd be convenient for
> > my vIRQ series to add on top if we can keep the master here:
> > 
> > Given that your flow is:
> > 	arm_smmu_decode_event(...);		// get event->dev
> > 	if (arm_smmu_handle_evt(...))		// validate event->dev
> > 		arm_smmu_dump_event(...);	// use event->dev 
> > 
> > Could we just keep the driver as it is, so your flow will be:
> > 	arm_smmu_decode_event(...);		// no event->dev
> > 	if (arm_smmu_handle_evt(...))		// get event->dev 
> > 		arm_smmu_dump_event(...);	// use event->dev
> > ?
> 
> Hmm.. looking at the vIRQ series it seems like we'd anyways need to call
> arm_smmu_find_master here as you're adding more fields to that struct
> and plan to use them here. 
> 
> In that case, I don't think we need this patch [Patch 3/3] ? 
> We can keep the code as is and simply populate the event->dev ptr in
> arm_smmu_handle_evt when we lock the streams_mutex as you suggested.

Yea, that works the best for me.

Thanks
Nicolin
