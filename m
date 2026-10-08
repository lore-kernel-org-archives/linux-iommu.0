Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012043.outbound.protection.outlook.com [52.101.48.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E692E3976BA
	for <iommu@lists.linux.dev>; Thu,  8 Oct 2026 17:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791480785; cv=fail; b=ggSIlC6HTJ/SZddWV8rO1cshKLd1L4EDhY9dj1Bek7DTsSLUhDPSYM9R+emXbSqhTzoT+HH58U7nPdDW5eyUQnecXmmpStca4oixj09/BXD5xa4/Y+oiOy6zlLklxsr+ItVbIkiEF7rZ9EusZ9+XiYdINBkOP47ZKR0CYF5MrbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791480785; c=relaxed/simple;
	bh=N9tqa45kPhC8CIsbchtmed7rw5pXfY7Mny380qGFk1E=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D40ImC7f/NJmF6RkGzR4bOFzVbgLytKpY/k7q1UMYcrBFfQurV8wEBi2zcj0mAJxFCPWMEYts+eHEASjyZFsc2ye+vFpW3jyRHghLmdOwctEmG5RIcmc9IdyXNL4JCEjS4OJ1g15gP4wQbKknPY8I1aA9XeyK85IefY+JRPTSuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xj7vw/WM; arc=fail smtp.client-ip=52.101.48.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xj7vw/WM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kdtdBvuyGBkekygsoWH+GXCkfKa/rq8YEQAuOzjXySEBxpvsbae7mvo4q4H8ARqY6GRYmoh2uKMzqZSMb86iA0XYf3xEJcCSzUmcm0Toqu4myuOTgCwZHOlb4UcA57yRbkeMn1duOkgFPXewTgZAh5aeaAx2Mxpy9xay9pyooc5uwAIURp3cdOVodf01HMfcrKVBod7nrV4iHDpXOPgaHEi0fsBGUtV/KkCuRIppE1uYz4VYFayc+po7MHkZroZ7RknsWK4FKwmC354soZFzUMk9Gib5ir90JQjoBICn5vVNfZUmxJMsrJ3RrrqEeunr8ZdxNDxtJ4b1ZFVALd3Hug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8u8H4QYJiarOEqRZ8ZbXOONzxSr4hNvAmbzJoELjm0=;
 b=nP7QZ9IyP2nXQB4Njdls2XvwH/HTfwySHDqen6TL8375KHrnRAhmlNdM6KDWLcDktd0AeBh+xQ9A4mxieMOccaQu2qV0bQmdMX8I0CjGUGgJQhQ958y2Zk9kCI28iX0wTA8pIvnJEWTL2iVRSN9IlKRcif15b6MufBk8Mksz6ODMtCo+3zrDEdcphfyPZ7pkKQ5Fwp2891NGYB0RcIL0efTHg6HEX/tEzX2qDMcu18sLOHsueN62pSNM24vJkMet2nfBuHDzHa978AlvOa9elvLFNLGLoZIA7mET5shhsa2dnct41SGMzeSio7ukRzgNt63RB22UE6NKfGkPMFioYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8u8H4QYJiarOEqRZ8ZbXOONzxSr4hNvAmbzJoELjm0=;
 b=Xj7vw/WM+BmjotnO6HFyxzHGCxuul5S2WTImFKNX4l9EHwCwpsOxM0glaH5o2fIva/ceMk3sfVLj/vJH5Y7oMc0H5+wSzZlTbWcK9CPUIO2xyfbPo9WZuQUS9N20AaYVyySLHt7ahx2B/WQxcoJqQWMYu828FPTkFxCP21Afc4OIXPQI+jUeoXA9JGwcupocC26jMhdxSywWeBm8oagLvxFqa5znaljX+GrkjlYXMx4AtYHf21aqSMrRsm9ekiKavIocaxxPmrY0j7WriyGTwMydY+YZvyV+zWieeLpcsuq9mghEFzri5JjM6bq5oZ5AJVzSokpp60S6Hbg+UUw+AQ==
Received: from MN2PR06CA0007.namprd06.prod.outlook.com (2603:10b6:208:23d::12)
 by DM4PR12MB6206.namprd12.prod.outlook.com (2603:10b6:8:a7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.20; Thu, 8 Oct 2026 17:32:55 +0000
Received: from BN2PEPF0000A991.namprd04.prod.outlook.com
 (2603:10b6:208:23d:cafe::18) by MN2PR06CA0007.outlook.office365.com
 (2603:10b6:208:23d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Thu, 8
 Oct 2026 17:32:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF0000A991.mail.protection.outlook.com (10.167.248.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 8 Oct 2026 17:32:55 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 8 Oct
 2026 10:32:28 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 8 Oct
 2026 10:32:27 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Thu, 8 Oct 2026 10:32:25 -0700
Date: Thu, 8 Oct 2026 10:32:23 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Will Deacon <will@kernel.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Jean-Philippe Brucker
	<jpb@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Thierry Reding
	<thierry.reding@kernel.org>, Krishna Reddy <vdumpa@nvidia.com>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH RFC v5 2/6] iommu/arm-smmu-v3: Allocate streams
 individually
Message-ID: <asfTp0KxWIyxmcnz@nvidia.com>
References: <20261006-smmu-shared-sid-v5-0-169a59c671d3@nxp.com>
 <20261006-smmu-shared-sid-v5-2-169a59c671d3@nxp.com>
 <asbTEPMJvm9T00c+@nvidia.com>
 <7626c1be-305e-478a-a017-548341d25419@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7626c1be-305e-478a-a017-548341d25419@arm.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A991:EE_|DM4PR12MB6206:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a4f6afc-e8a3-4ba0-bab4-08df2562302c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|23010399003|82310400026|1800799024|4143699003|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	p+jLB/3ZkFpni6t04v3S4LLHD9AxzXZcKBy72q+dnoN1tw2MNUkopiSE1xIH2rowXsIfxZ+GCZApPFVazZgMXWkRlc5oV7Sdol+Ezwx2iUVxRiPQKW2Qnzt35nL7I1Pdf7VFo4tjicE2qcQ9RSFnzwR0/u5/+Qi+TIwxVEZnJLgZK7eOiRlzl76HGeW631f2xxHjKCJSUdkFAYIjjq/f7dG5eplKgDLE+u+Ukc8/ZCNwMTiCC6u/usn02xatRRO5Z1eRapB+dDw0KCNeH/jaS3kCWAJNCUNos4HXa10mv4synkBQ7uF6d8eZ+jKhhcGbknGPgCW9V+YBZv4cjseuPKzVnxZ+necBz+LSO6NEdKRlcf+6JPdzPW7vO8I3mTAZEakXqcAwkO/agMIPvUZehi4kQA7SfGKRu4sjUs7C72K4XQdAvWOu2PzUFGxfmujcdBTiGwAoSQPgM3rpwDjAP4AwyOv1b4hYhkomukFzdOIEFSVxzXBBwHQmRIufGuyZioDKRq84jfNjwrmZ/21t0rqGF7NkliK5PPaRMYJw7GZyjIWSbk0SlMhIrkRiwLWErIUhbEE4fBnEY0N0UOxlfgG3UhnQbgnAQyt3xjiSEnlWhitTCNCKDsaqJCeMdFiPaLTcj67WRyJOsNRNWTe5bCsU/TWXB3wm5Niz/O3hAvHSasB/rnZzQBapsb+8jWiDlRoXN9Roh6XM5Oe9RR4Npg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(23010399003)(82310400026)(1800799024)(4143699003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	T9Ua8oRnqjyMJR0UEoEIZmwLc27Z4hkekcuqtEVR1ApwyxOkcfav2weeIbioXt8hqqeoodNk0reUJOH/E+Ces7P5Kfgrah8itsISuuKxoakt2Iw1nV1aPJDoqf0R89DSNF2y7iTOBm7xvYQKxFUVfGvm2zhJonIz65z/43I0qxtGtFk+LGiqJwf6pr0Kho9mBpZ6IQqL5mtpnZWnC43FuJLi/8gY4vdN5MjsOdws7gpYgUPjfpD5OmU3Xwt8ydDXV0kSi3uVSTpRhS9UznigHcXvh+QBfG1qE4Iu1POZMC2I/odls082ptziL+M8QhoTl1GcrkHA6IyZ+kGo3UqYZc2N68CIl8zsGcKM6tD6PJrVU3G45YaFMykxwaVzFmURDgzRCbNUHL5++w5ifI/Lca95wOlPWVbutsLLwaDe3qUm0kwq0ZAXp5znY+j+QpV5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 17:32:55.3171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a4f6afc-e8a3-4ba0-bab4-08df2562302c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A991.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6206

On Thu, Oct 08, 2026 at 02:21:43PM +0100, Robin Murphy wrote:
> On 08/10/2026 12:17 am, Nicolin Chen wrote:
> > On Tue, Oct 06, 2026 at 08:19:08PM +0800, Peng Fan (OSS) wrote:
> > > diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> > > index 6644075c1431e..bc62a3d5a63f9 100644
> > > --- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> > > +++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> > > @@ -1257,7 +1257,7 @@ static int tegra241_vintf_init_vsid(struct iommufd_vdevice *vdev)
> > >   	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> > >   	struct tegra241_vintf *vintf = viommu_to_vintf(vdev->viommu);
> > >   	struct tegra241_vintf_sid *vsid = vdev_to_vsid(vdev);
> > > -	struct arm_smmu_stream *stream = &master->streams[0];
> > > +	struct arm_smmu_stream *stream = master->streams[0];
> > 
> > Sashiko raised a concern of an out-of-bounds pointer dereference.
> > 
> > Though it's practically not possible, probably it would be safer
> > to move this behind the check:
> > 
> > 	if (master->num_streams != 1)
> > 		return -EOPNOTSUPP;
> 
> The IORT path unconditionally adds 1 ID via acpi_iommu_fwspec_init(), so
> num_streams==0 could only potentially happen with DT if a fwspec was parsed
> using #iommu-cells==0, except arm_smmu_device_dt_probe() would refuse to
> probe the entire SMMU if that was anything other than 1, so no, this
> definitely cannot ever be out of bounds.

Yea, it's unreachable. So, either way is fine.

The num_streams guard is already there: doing a dereference after
the guard is a common practice anyway. And that drops the Sashiko
false positive.

Nicolin
