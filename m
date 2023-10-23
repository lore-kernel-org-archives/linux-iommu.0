Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2046.outbound.protection.outlook.com [40.107.212.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699B365F
	for <iommu@lists.linux.dev>; Mon, 23 Oct 2023 00:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dP36L40o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8tEpAL8gc5RgPml0LjhtISRbDvxFVbnhhilHH8+nDC+bzavZTJneRnprPr6aZd0iuQBgW+3E/ioakKQvITZK3WxK9TDXxO87i3agS0m6N8RZwR97WFEATWtoC5NO+5YfF0ua9LTwJ/uXtYOKouF1U0vSuGJdj14uI2FkPeEM8MoZ+sOwcs1Qi8P6M3nvaPR4sFNC2IlS4kOSE5NFSpki+kmclmCi2l7rhiNsWrDSySw/xiWcQZZayKHcDGkpba5gIoRS1KH6cIUnM9bzFHnMxcRIN05d5OqFdKGOb+eDuUPuUgI9ldsyRbWzqr3FnAGCQxgwCT/LJwNNSRnjrcp5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qwO1Th6Z+9yoDbPdksweGB5h00UNH3NhiyxfAdWdCQ=;
 b=KUnhnVL5SpQ3uOhS8dPMpp0b/r/KDQBot0Wcz5SrZ6ODb6nmdW2JfU7spGhj1r8D2nhu1QM+sImMxIWplP7bgHaVlDt+h2oMHrJbd2ERx4MuSFhXpTS9vOfA4exmz2g8DSBINLl8Zc/5syn8EtPeytHDAsIjvpe7sADeeNjx4OZv3QxVbkwZMdGwbpdW+qH/urT4BiEydtVWVOF58lE/gzYg7Kbj3jJZBG62UfSlJFKNSdlIKDII/g2AQGNnzi1Fzt4iFmixToflq+pDzN8Osn7O+4+/arUFE3iqZAEInHGZgveAYNG2lLCZWkFFeLOllrKq/o4ZP9vko0oPiXbw5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qwO1Th6Z+9yoDbPdksweGB5h00UNH3NhiyxfAdWdCQ=;
 b=dP36L40oOWtzw8noyn3Qi8lVHD/OEz7xOIW5Zfbg+WCaGvWsxVHFYsOINO2p0em7WtAKpkWC+cJXQUX8wZ6J3LYZBaXHZsR5s0FxruVO68ReKgm0igQbNY7/0YGtnrfEY/8AMMFU87PlwvK7CyIfjx/1iArZUzupHmSQjiz9uGTPksUR3Rplok/qlwXqTWzR3iWbGF4OvHIVqXkYRW6jCnGhfVqy7OKP40sKqctkUkHURNRqEI9iXxgcBhANXrbkpadY7vLJxWBBzuQ7kud3LBE0bn/SS74wSkQMGT9gAcTKYtOniuZ7dWAu/IsKaNEgK1UWmkEgGpv5cp8OPLzA2Q==
Received: from MW4P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::28)
 by SA0PR12MB4558.namprd12.prod.outlook.com (2603:10b6:806:72::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Mon, 23 Oct
 2023 00:25:57 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:303:115:cafe::a0) by MW4P220CA0023.outlook.office365.com
 (2603:10b6:303:115::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Mon, 23 Oct 2023 00:25:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Mon, 23 Oct 2023 00:25:57 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 22 Oct
 2023 17:25:53 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Sun, 22 Oct 2023 17:25:52 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Sun, 22 Oct 2023 17:25:51 -0700
Date: Sun, 22 Oct 2023 17:25:50 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <joro@8bytes.org>,
	<will@kernel.org>, <robin.murphy@arm.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <yi.l.liu@intel.com>
Subject: Re: [PATCH 1/2] iommufd/device: Drop enforce_cache_coherency in
 iommufd_device_do_replace
Message-ID: <ZTW9jnyhBNZm8p0+@Asurada-Nvidia>
References: <cover.1697848510.git.nicolinc@nvidia.com>
 <5593200da9015fee7b2e8195c2998f36148d83de.1697848510.git.nicolinc@nvidia.com>
 <f840af3a-45fe-477e-bd45-2bee95b8c8d5@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f840af3a-45fe-477e-bd45-2bee95b8c8d5@linux.intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|SA0PR12MB4558:EE_
X-MS-Office365-Filtering-Correlation-Id: fbf5f747-86fa-4796-ea19-08dbd35ea054
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	L58ghE8Vi8rAV/VfFtVCnEuBVCDGcfGXSwCSnTtL7uTSmNVdMvnEKMyHq8e1QdJCHiAcq38OJQSYPVhfo5k0ljHGBZSKbaYDItL1/uk7tNtat7xPEFzw/O9ZWiU+htGrZAm7UE7g1PHmcCT99l3reD9KC10PAZaPwm2erRlAHK1DX8+ugCbaPftvxMkD2VCXRNCveWbgPos34sO/0nAOei9XmQ7linapiW558Y7Re45jkGCyTMAk+yOnYcjwE5G7ugnWtE3HSHdZGCc5nURE5uTmitYT1hT5NfApyqRMT2zkDWD6eDI+xpKWml8BZJdyGIkBQ3YD3yReoFt3gzzIw5Omxf38oXgBtoE1eqCwJ3OaYUMpn3r6hV2c25FVoP/VC3bBd36TmeWrmFwrNQtOmf3PYzE+7lDDSOpGzonPQ31Rv2E1QhG6VXMqqhPFYe2hk79/9teRNlrHsiu2ooF1IpFb28LIduFACJPlubuKnU8EhT5YHxo6KLCAnegkOCFAU2x6iu+vRXmgTH1hfvySixJyDytZj9W/KSPSO3LoRxNTZUdBz0XXn8ILiyWQZmRK/cB+mcKbyYW06RQwgOhdwsB2X7JL3StOBErNtVM5QHNpKZwpXrMk4kO7b1oLYVafv7lA0aekQzEtAlQ/5TX4qEZ6oYSpO4FtGVZENB30FE6l69vA4Ed6iZ/AVXMiz3qfyj+I3e30ltXV3DO3rPdyzk989UHhcvwIYtK33i9q1E7cSHQe+XMSf1BDo+T8gjiZ
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(186009)(82310400011)(64100799003)(1800799009)(451199024)(36840700001)(46966006)(40470700004)(33716001)(40460700003)(55016003)(8676002)(336012)(36860700001)(4326008)(41300700001)(5660300002)(4744005)(426003)(8936002)(47076005)(26005)(9686003)(2906002)(40480700001)(86362001)(54906003)(6916009)(70206006)(70586007)(82740400003)(356005)(478600001)(316002)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 00:25:57.2581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf5f747-86fa-4796-ea19-08dbd35ea054
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4558

On Sat, Oct 21, 2023 at 09:25:18AM +0800, Baolu Lu wrote:
> > @@ -465,6 +455,8 @@ iommufd_device_do_replace(struct iommufd_device *idev,
> > 
> >       igroup->hwpt = hwpt;
> > 
> > +     list_for_each_entry(cur, &igroup->device_list, group_item)
> > +             num_devices++;
> 
> Minor: How about using list_count_nodes()?

That's better I think. Replaced with:

+       num_devices = list_count_nodes(&igroup->device_list);

> >       /*
> >        * Move the refcounts held by the device_list to the new hwpt. Retain a
> >        * refcount for this thread as the caller will free it.
> 
> Either way,
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Thanks!
Nic
