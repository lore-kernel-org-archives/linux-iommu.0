Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5525921A6F1
	for <iommu@lists.linux.dev>; Tue, 12 Nov 2024 23:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731455590; cv=fail; b=hQ1jaed1r+QEcKh5QChhLOwMcWYhLavBEpQgEWYINlgVaBvXgRl/lpGsYMqbGtbJB+VTXPSPm9tDNMgQLNDX7IjErfT2XtMx6DcN6kLbievVNP/N8wdvZsl3P6bkpxigbpguinLqPdFez9ztI2clHjiC0jIFAaRbHj1etlSOqic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731455590; c=relaxed/simple;
	bh=BHuYHfr9wxc7ETKfUqCFliiU1liGQVVc4566aLZeWAk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gv00wJ2SuCtjJaBsqPSUEs0MYN+IfsogoxN3OxivMuixBKmK1uktw0/zmKX6NQNjnGklY5zL/XOHNRt19cPg39X13J6cR7TnlfkxDHmtLaIX/iwuwIScD080Ue1pZ3VAAd4rFF0/6qyPo1OzW5i+/xa4wgInM5cRuI88wpkKg0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hdd2+rCH; arc=fail smtp.client-ip=40.107.94.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hdd2+rCH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zPHnlBL7KIWCpfF1TwMLLKKlTfxGgefSRASaTfAhGDXSIWux7u25IIvneXCtNNs/s7EjBsZKHfEv1PdJoM3Ce8gvjfUPgbZhzsAd6NLQJoGt7kaq+gsTxS0SKJXDi5xEgdKYadeHDXS4wgD20HczouuB98ud0GtiqlC7ASuwKb0ofP/ym/C0j0RGFQ1SEcAdlCjGQmqGeGaO0eUG63DnBpbqcsN1wC9E8N1ViWVo2qpI2Rd8QO8OnnJgsG1l14VKQdV4x+D7w46nJikj812aHCjdyE+QyQYLw4Og83UurQ2NWQ/LksOLgQATWbmYnLKGEd3hgvwabSft6ki9VYycjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pr9s9Gmd24W5Tt2rpZBOV+5MumT7IRjRfMVEepMs2T8=;
 b=LPzqT5I9+HBmOb7S/y/MH4nCDHRS4BCwl0H3CLEKEhagUU6D3jPU6lP1GTZjoDhMtZSgN2sgoqWZhAZvoMtIR+xzmyBYfs4eboNetUQNxnsdL8Uv/LWX2egwSSmTicyXXMAs2nL5S8DHjdQPlBZ2CO+livf13mARkDhGTKZhpsEAPWh3lTUltc8cC0ScYbfvB4HpmDnAEE54g+wFVS2oiicyexUA3R0rsAzi62yfssoymlzRFlIRa6aUcb1nhWrkISF4L3XpmQQswotVmiuN+xf0qYOmDP/zNEbHTc723leWtNyhFne/mI4rXcwCEuU7nOu9ctFf8FI6/U7fD2m+dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pr9s9Gmd24W5Tt2rpZBOV+5MumT7IRjRfMVEepMs2T8=;
 b=hdd2+rCHLnAwEKEaWwmeYDm0MJfn0s3QsuuC1EgR6UL2wvPz/Jmil0dd4wI69w/tsLP4t5cx5w39p/c/c6zzD7PlLm0zMG6iUSAtglDJe5oaiyZf8Pk01QT4yYeDtXvihAUWd10cA3Sq3KIUZtN3zli2HjEuj91XAi/aklR1Y3yu+iCJ8e3+EfWMupEoVFLQ4KbwxTFwIaPwwtUuA8q60cIIA6hewK8w1XW7GJzpNLq30R/mctbVASA+znmrR0q+dBj45/ee0524nnmes5seo6EFoZo4MkmkPZFb4edgsE1F/i/gNfrdiL7f6FvJPgDjHcOTYz9J0nr4VJl4NNtJOw==
Received: from SA9PR13CA0174.namprd13.prod.outlook.com (2603:10b6:806:28::29)
 by CH3PR12MB8878.namprd12.prod.outlook.com (2603:10b6:610:17e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 23:53:04 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:28:cafe::19) by SA9PR13CA0174.outlook.office365.com
 (2603:10b6:806:28::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.15 via Frontend
 Transport; Tue, 12 Nov 2024 23:53:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Tue, 12 Nov 2024 23:53:03 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 12 Nov
 2024 15:52:38 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 12 Nov 2024 15:52:37 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 12 Nov 2024 15:52:37 -0800
Date: Tue, 12 Nov 2024 15:52:36 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Mostafa Saleh <smostafa@google.com>,
	<iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Daniel Mentz
	<danielmentz@google.com>
Subject: Re: [PATCH v5 3/3] iommu/arm-smmu-v3: Avoid redundant master lookup
 in events
Message-ID: <ZzPqRH57RjNS+lJ8@Asurada-Nvidia>
References: <20241112083018.1662104-1-praan@google.com>
 <20241112083018.1662104-4-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241112083018.1662104-4-praan@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|CH3PR12MB8878:EE_
X-MS-Office365-Filtering-Correlation-Id: b1322ed1-3140-49b4-c8d6-08dd037525ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vdk90sRUX55cRqNPzITijDvbc7om6X4uiEosxMMQrHp/ClBQ6be6yzND7yct?=
 =?us-ascii?Q?L4/v+7zH2KTjkvftuGGCB7/f++s+/A47PmCHLuXiS1fDLeZSVH4N8xoKpMqy?=
 =?us-ascii?Q?x5ZtZ9hxQ5ypBC5iV0pgkeVuaWF8ABWn3z99bqajGH26FNgGkhnlWm47sNJO?=
 =?us-ascii?Q?ZUsmmY/aA5FqMuWEdRzJV8JwYPIp0WH6CZmHDnj+UccW/T3V20OfUafQYn5v?=
 =?us-ascii?Q?VfAvgEbV8JAcQGYlkWlDoPnRGWc2kJf0FND5yFOsDVzJOZ66ldFduwoLRuwA?=
 =?us-ascii?Q?yM8VTPazmYdemQcWDVobTsl31kVxJZWKo2L+CvzabCFV3tPwTMIYRbeyQ7R8?=
 =?us-ascii?Q?oUQ617CjVGympHQTsuT+TAq1t9edV4tURGzH9tGNPLrKT6nbH+3/v1y9SyeE?=
 =?us-ascii?Q?o0E4IitK6Hn0lO74EsP+RsmMlM74pNx3GA/FRqQoXwDhnOXjAVqGveEKlWeZ?=
 =?us-ascii?Q?uWqXqcIJwPTJG2mdOmVCzqX9y2HXA82JLywW/1qiBZm5wHFLRLRjzv+Jt/7H?=
 =?us-ascii?Q?xGKaOgxImqfl2l4YiZ2QKmVt3SxrQC4ucTgkO9by+BnIcEyw3TX6PT1hQsn6?=
 =?us-ascii?Q?bmFNIcuhlWNJLpU3HgCWAS8meX0ygn6RUvlUzkPkFSbb4WKaWKpMHZMRbeyd?=
 =?us-ascii?Q?IkdSonbt9xfJyNWCm87a7IT7DCGKco7jh0LWekLmevQGzQMlqma4L3XYp9P3?=
 =?us-ascii?Q?oQGh6kXVJBUgD1NMBtwvzOk706JjQCw+ysoiib5XrVZ56UZZVrt+e6ILGnOQ?=
 =?us-ascii?Q?1k8Pxd2A/A2wJZt4awPXqbGH4VTzQO36UnGK88Grhl3AuMtMsISHIKeLEn9M?=
 =?us-ascii?Q?L431heXFK8UXAT4cnvAbsU+9IWkCqrEnAnpm/ux3iaAzQ7IXdauJCj+viYFr?=
 =?us-ascii?Q?zRB0pV5Jmp0WLxWE0EOTecM8hewxBuzResoRmoxtQIb3x1YzPKXWJnlSW5x8?=
 =?us-ascii?Q?m0mPZV3lwgB7rYg9CkFL/tEcYy+3poVtP6XN+k2zIoZuF2370OwG1sGON1g0?=
 =?us-ascii?Q?rTnclEjTxJzshYpdkjBDAkdckrM7kd1zWURuYnm5Xm0BJmOheMtv5cBLm+ah?=
 =?us-ascii?Q?2USgy1xEiZCIXQmmS262LJbHVpbAnD7c6sr8WkNcVcIRcSfgwPPsUD/qT3x4?=
 =?us-ascii?Q?nTjhg7dDOQec76L83qpErZEyJvpvOa8S8aNZxESIh/HbFS5IlN1u8XUArGIJ?=
 =?us-ascii?Q?WznEyUR6tMk3+6QRIBklvaj0JpzP/QGNvnGp5RO7RwMs4PtEhZAksNVptzMQ?=
 =?us-ascii?Q?gkw3CZbFuld7179b0CelHETYEJWNxXvxgZC+J6M1VNA7/l+e+1nTvEbyiLuT?=
 =?us-ascii?Q?GMVaun15+Sd9qvDvYaTfhqMBybM2YbCWQup0/v9+dC6+d3l6dNLSsxph5DtD?=
 =?us-ascii?Q?8Kw2ibSHowquCs9e1O3G/jPCc0/JAd2nfcw6t7E0zbwey1BGnw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 23:53:03.7469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1322ed1-3140-49b4-c8d6-08dd037525ed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8878

On Tue, Nov 12, 2024 at 08:30:18AM +0000, Pranjal Shrivastava wrote:
> Remove the call to `arm_smmu_find_master` in `arm_smmu_handle_evt`.
> 
> The call was primarily to retrieve `master->dev` ptr for reporting iommu
> device faults. Since this info is already available in the `event->dev`
> field, we no longer need to lookup the master to fetch the dev pointer.

We only protected the "dev" for dev_name() while the streams_mutex
is still required against arm_smmu_remove_master?

> @@ -1857,17 +1855,14 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu,
>                 flt->prm.pasid = event->ssid;
>         }
> 
> -       mutex_lock(&smmu->streams_mutex);
> -       master = arm_smmu_find_master(smmu, event->sid);
> -       if (!master) {
> -               ret = -EINVAL;
> -               goto out_unlock;
> -       }
> +       /*
> +        * If the master wasn't found while reading the event or
> +        * get_device() returned NULL, we shouldn't report a fault.
> +        */
> +       if (!event->dev)
> +               return -EINVAL;
> 
> -       ret = iommu_report_device_fault(master->dev, &fault_evt);
> -out_unlock:
> -       mutex_unlock(&smmu->streams_mutex);
> -       return ret;
> +       return iommu_report_device_fault(event->dev, &fault_evt);

Apart from the question that I asked above, it'd be convenient for
my vIRQ series to add on top if we can keep the master here:
https://github.com/nicolinc/iommufd/blob/66b3f9cdb39920880fb052b53f11ceb16af007fe/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c#L1782

Given that your flow is:
	arm_smmu_decode_event(...);		// get event->dev
	if (arm_smmu_handle_evt(...))		// validate event->dev
		arm_smmu_dump_event(...);	// use event->dev 

Could we just keep the driver as it is, so your flow will be:
	arm_smmu_decode_event(...);		// no event->dev
	if (arm_smmu_handle_evt(...))		// get event->dev 
		arm_smmu_dump_event(...);	// use event->dev
?

>  static void arm_smmu_dump_raw_event(struct arm_smmu_device *smmu, u64 *raw,
> @@ -1927,6 +1922,7 @@ static void arm_smmu_dump_event(struct arm_smmu_device *smmu, u64 *raw,
>         }
>  }
> 
> +
>  static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)

Should drop this.

Thanks
Nicolin
