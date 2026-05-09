Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012027.outbound.protection.outlook.com [40.107.209.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073D9288B1
	for <iommu@lists.linux.dev>; Sat,  9 May 2026 07:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778312711; cv=fail; b=aN+ceUf/RXTwEnQQehEanT1ZkqYgrXVsJHhIRJTuY+lY/5wOVyhwR2Gv10Dt71YdIC3CuEblpWyml+K4THH3iwtJn3ml1l2QVeQLVAl8WcQHtcH24Cvjq9s+EH4fY22Y55/+GrVPWklkI4EzLkdAkmmE0mzDNeFxrNUynkCESlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778312711; c=relaxed/simple;
	bh=LbyppeKZICft47x49gjo2/S7vS5NRsxT43ibxTsH6LE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MzcaG4GYK67N7c5VgcLaMZuFNbq3u0hf4v7J25z5RjiUD6ay/HGZGRH+w4rEJgenDgy/yC6yTr+6hOAXDFZ3+xSX5aIlh5eweXxNufahxobM7wlVRSjwHaFcqJcIuTLWgwTyIJDpSVVMKx2HcTZxN6GmDfQUtRmUl0hskr866kU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A5GfF5ga; arc=fail smtp.client-ip=40.107.209.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A5GfF5ga"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l6gXb+jYgBC5wLHjEM3/a2uNHleIYOsPtbm97HgPgaeEmJzOKso+5wJ6zd+6RZsjGhOChZxlG4/sXxR0Fz37a65GcFh2QXDLkwdKzaGlF64BB1AzhZ1GsemD7kcAL2t1mFoI1KDQKyYQT2XIa+/VqdzwprEV3N5J7KPuROf7gU6OTWpwg9d9s6Gt7qa5X1iUxzQeQwUdQAFWCLbHMbXeMGtRsbBJCh3s3+q+YRBeQ8JICt81PPUjwxngjvkK9rffvy0wu3ECSC+hVoksqb5HLcSEDqVf97Le3kv5vI/hux3V2Cfq4QBknlHOx2C+/nikyFYBJqvTXc23HaVOJkvjyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EL3MUmsvOpRTtqFXsULjV0AcKyz+fbORgYJ6p4Aid4k=;
 b=ocSf01YLE9oQNpUdzQTz7mV7Lv+WiFTRebCcFFm5SkTQhe58Ji53vIx47dqfzgQ/iuTX/nT4DD8jP2vh0fHS9hH57Wb45lGf8HLSrrBRuj3y4/iw8ilfWIxiCPbE9jmBh4wgtI8pL73/ikVZr4OjKKLiVObdbJPf0864WLnLbIxzzVd8hmFzaYMAjQW1dUkDLZ8lpcc9/hEguMZmOHoSd2VhqfB69qBdvgOYLVLBjWqkopr3eu4NOAVcJnbTYXAzoJ9EyWtEWyGXc6U4IkAaQZIm9fSbUZinbTkk0QDNTukn049w8TfkYNNLIDc8rKu4vTUTPQaO9rSopKVp4OPGNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EL3MUmsvOpRTtqFXsULjV0AcKyz+fbORgYJ6p4Aid4k=;
 b=A5GfF5gaX+L9PNWEM6kMGA7ZMd4zYflZjl9IsU+ZcJUs4b9ZbgmZvKfHpN+UcdLNu7nciKOZOD6GwAXXXRPzOHK/vtSu82CjYtLAMSzRNaXTkswD1z5QzwGWNvG/J6vfT7bTb3XsUJ6tYDvqVBzApvQer51EmfV2mDEUjNwiaxd3Lh1fXpTXWVQTk2apxCKkaZU2tCNzHylMfhKYWDSlVFh+8c6ctj+bKMdvj2TSKZugqbO3tF16tRKjgxHpTsm9NbAS8GBS8g2hokT3UJzWuR0Tm6qb7y6YZZMv5s8sAeZ/yb+pznmyZ8zwIk9dujvLT5i0mzXmTDY17wGsg5o7zQ==
Received: from BL1PR13CA0390.namprd13.prod.outlook.com (2603:10b6:208:2c0::35)
 by BY5PR12MB4243.namprd12.prod.outlook.com (2603:10b6:a03:20f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Sat, 9 May
 2026 07:45:05 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:208:2c0:cafe::52) by BL1PR13CA0390.outlook.office365.com
 (2603:10b6:208:2c0::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.12 via Frontend Transport; Sat, 9
 May 2026 07:45:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9913.8 via Frontend Transport; Sat, 9 May 2026 07:45:04 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 9 May
 2026 00:44:57 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sat, 9 May 2026 00:44:56 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sat, 9 May 2026 00:44:53 -0700
Date: Sat, 9 May 2026 00:44:49 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "praan@google.com" <praan@google.com>, "kees@kernel.org"
	<kees@kernel.org>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"miko.lenczewski@arm.com" <miko.lenczewski@arm.com>, "smostafa@google.com"
	<smostafa@google.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "jamien@nvidia.com" <jamien@nvidia.com>
Subject: Re: [PATCH rc v4 3/5] iommu/arm-smmu-v3: Skip EVTQ/PRIQ setup in
 kdump kernel
Message-ID: <af7l8UKXIwTW/e/W@nvidia.com>
References: <cover.1777446969.git.nicolinc@nvidia.com>
 <25398d02373e7592d0555e7da9dbf33b3e83983a.1777446969.git.nicolinc@nvidia.com>
 <BN9PR11MB52764380FD823D9D33B302E98C3D2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52764380FD823D9D33B302E98C3D2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|BY5PR12MB4243:EE_
X-MS-Office365-Filtering-Correlation-Id: 8de808ab-2622-41e7-2206-08dead9ee27b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|82310400026|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	KCHMZdpuWQziJnlHMgqsJky/dj3+Ta3BVOQZM+V+w90rO3KXuP9ynaGjSQuMCIpaO5wtOd6mwKcfybY8Z/siJfY9c11NmAl/OeZJ8f6PLcq2XXFtsLYfU2Z8O+8aXum67ApnijRInle7QIOqKNVx7mCXmqZEeWdPRvkNwGPDAykSBGTmtsGpUtWE3mDpeqMxnWfuDF7qYME+KA0zaTYQ0hCTaeV8Fcz3+nSHAK0NmcrTKoh6qFDmwWGFlHROE+0UBH50RrA5Cavkigp96a4a2zNnEeaK+E8Y+S9m87ti8ftiUSroEjH6UYUM/EZJiexMCeoXjOw8ImyqcZ77LKc6u5Gh/r6FF7ghCTOQreXgqPkjF5aJm7y5+T631UoVTPfSp8wjk3o9so47wjPlaCxcalm15BkGm3X36fbEcZU9TKc1JCMwDz6Dp71GUpJOCEiOmrP3QtxaDYsTbvU8iZa6H2rsxFX3jYYKE0NDwAcE04VwH57UESW5+Fm7HDYZkY14UzA4wbCaiH4UlRZAyit2iYe2Y5pd9DUKkbXWAGS/05Py3xIy5Pm8xML1zReSDF1LKUlVwCGs51aw/vXB2JyAHP8cRY29IA3tUq2Py/nOIyrvDMO7vdwGanNNKFlQjG4zVKBXxueO0RFZvJGKWwLLC4hI+qpmzQ0YRH1ieWGn//BI71rPDYfDizq5WRp4dSCCp7WjcN2udzOJ2+ZD1eTRw6zDbQ1BC8gQY9UmLFci9C8=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(82310400026)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KjmI/EYjZY1hj2bn3lbT9NUpEsqcV0yMWw1EdVPKbEvomisUB2U933b5dWWWi/Z2muebKozrShN7phUwcrhpguxzG7o32DPSMdIykhivEffebIfrdMlyQYkFnHZAyMINEZW0z4wgmBZTY1uO7uSRWxzU0OlvM1A65wFo4846KfPFNGhSn7Z2Tfg1lJ5SCd99jHMvJSRvGKaKHwQHEDy4Sxqm+38/mubvMJsN3XWT88Xfw/rLxw3rG2ymbNQiVahojJkSQJ3itXfklzkSi3cZRxGM9pHwu6DvT+BATkI0z5xgaavTBu7DiWL7OANZgyEDJkU8k3BZ58sUJ85gIEP7BLwgWrw4GtqZsjoi6k8Ty5wx+TUWh1tEvcnX2/z+y8DM/RNa5MGmUOOq7XyvJQ/QvqiiMGKIutzCLeAhK7ZB1okoPFpsvtE+ppRY37kTbpse
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 07:45:04.7602
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de808ab-2622-41e7-2206-08dead9ee27b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4243

On Fri, May 08, 2026 at 07:41:20AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Wednesday, April 29, 2026 3:21 PM
> > 
> > In kdump cases, the crashed kernel's CDs and page tables can be corrupted,
> > which could trigger event spamming. Also, we cannot serve page requests.
> > 
> > Skip the EVTQ/PRIQ setup entirely rather than enabling then disabling them.
> 
> this is a refactoring to achieve the same goal as before...
> 
> > 
> > Skip the IRQ setup and guard their thread functions as well.
> 
> ... while this sounds a new enforcement (then better in a separate patch?)

In v5, I split it into two patches and kept your Reviewed-by:
 - iommu/arm-smmu-v3: Skip EVTQ/PRIQ setup in kdump kernel
 - iommu/arm-smmu-v3: Suppress EVTQ/PRIQ events in kdump kernel

Thanks
Nicolin
