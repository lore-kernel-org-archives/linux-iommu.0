Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39565137E
	for <iommu@lists.linux.dev>; Mon, 20 Jan 2025 19:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737402430; cv=fail; b=cbz+1ljj5kL3WiNpZ2H3rZHrWdT+41ZM19SAyKapheI4MozztjK+EuMN09MIQZ6jJ4kAeni1jQz0sEa6et45fPVigBDc+vaKXbwbDKEpW3JjS+RtMG4jxyNS6WHvoJF0ao8IprxtzQJUTXmoMI1HbJOysyAnxwMMcVrx0R0jGQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737402430; c=relaxed/simple;
	bh=DqtowrMjoObnTnRVTEUah+yS37smm+m+dUWf07R42VM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+/7atO/1SHpQIcIPY54PaOHQPlx7URax8kPJ5qHjeSXzI4MPBNYE0bZ6EimQEJT7a0NRPpmklpxnz3YggcSpPniWtDGSSzTmyqp4i5IXcrmYBxpFyb0HetPsk2GGt2qhYUEoJvpIoq4bPMUFNos0Cz0kxt2u13mGFYf9o5RNHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=np7q3wbC; arc=fail smtp.client-ip=40.107.93.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="np7q3wbC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jc57K70NPSKh+1Qqx/Sl6+qvvdJmSxUb29IR4pDspj+lonyF5bKybfEx5hT0z2Kxr+xji3722EQnKvhNcX1OSSFxRsKA5uEadfGP3CJAuP7aFS5pRJSAReiGc9cwEMrDuQeqH5kkOrvnsuDsUpYg0oNqN7P5AA4yRFf8rG6M6wGfHUp/MablWa9a8EQ4AZj+dRVQgKp8vfK0s5kNKhDCYuOj+uO9pLofkpQGj2kA8/SB2oZWyeXZQd9Ui2/sI/5P/8xAkNw0YEq3FBqMdjMQy3/hmm/vtwEv1B1PQo9qsziYV2e0OcrBel9VQLQ5eq4Z22LV03uaueP5UyAjEADABw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RolSe6nxv4Hq6U0Pne1uL8MGPGFVwLeUsoYGT6GuT60=;
 b=ZnCxDEcVteoKbEqRqPLvWYu5vEatU7A3nRJgsB4omV0nN4lIRqEGIHj3+Sk/61tsNWWr1ZUrmglM0HjeTTFc3tmtrMkftomhpuwZjbvmY0q5wmwsYy5Y7T9eIokag2VIZe885BOwoVatKjBQbbyIWYczV6GUPcS0ueFVx+t3BWnnDyP+NeU7mv0E1o/uYy54ATY08sKy06VUlqYidySiyHoSdHFSzYR69DZEQnnuFKnFzHGlz6z/KOzq8dUaK5k0Hvp3/eawzf+n9+Yg8Eg0GVjE8yEIGUIJpyK4kg7qyxW4z+EnoP3yzUHzpeF/WjvpsYrZrryK9Vq8ywhXkUr0CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RolSe6nxv4Hq6U0Pne1uL8MGPGFVwLeUsoYGT6GuT60=;
 b=np7q3wbCyU2pJhRpKNFfacdG4CNwwGK3Sv6DR+vRzhzqpbPJ/yNio2/tjwaG1PVkeaNVRuE4OUES/SrIkKuI8D/EnKbSggJprvmNRf+E6lpgMqhb9eIrLew0y3QmqBCHWU/3RNJYgVrLtXYp+r8i3AsxYJc9zxkaYzEt1UVz7h1/KUvMZUWJEfTupXcjoso1baEosf4/+iBnnQWnjiQS8FxzcxiLUTOK6oFs0NbvKvzIpbEhPZWgWiUvLoXDivUHuwsd/vje+vsY40vdU/hF2Ul1RRsR1+DOkWWwuP1WK4Iqr88LpWH5C5h/TsIZtqETlh/BjcNWRYblFfbd2Q87FQ==
Received: from CH5PR02CA0002.namprd02.prod.outlook.com (2603:10b6:610:1ed::14)
 by PH8PR12MB8606.namprd12.prod.outlook.com (2603:10b6:510:1ce::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Mon, 20 Jan
 2025 19:47:05 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::61) by CH5PR02CA0002.outlook.office365.com
 (2603:10b6:610:1ed::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Mon,
 20 Jan 2025 19:47:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Mon, 20 Jan 2025 19:47:04 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 20 Jan
 2025 11:46:55 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 20 Jan
 2025 11:46:54 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 20 Jan 2025 11:46:53 -0800
Date: Mon, 20 Jan 2025 11:46:50 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: <kevin.tian@intel.com>, <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rc v2] iommufd: Explicitize struct iommu_hwpt_pgfault
 padding
Message-ID: <Z46oKvURNEjl0XRZ@nvidia.com>
References: <20250120062411.1589-1-nicolinc@nvidia.com>
 <20250120143719.GN674319@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250120143719.GN674319@ziepe.ca>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|PH8PR12MB8606:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f5a80f9-8b2a-4d1e-79ff-08dd398b3743
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JHOp39Q/urueiPjSMT3KQQpG/yiRvrikdDG9jouXTyQ2jlROqwFhNAL22l+B?=
 =?us-ascii?Q?NM2JiSIXkUlyLB5NXW/HivvmLg6GHxkw217wHUMEgsHA3YhX1E9LZihLUkTk?=
 =?us-ascii?Q?jiovsmsrjKyJDGGGMNnb4ngD5En+e6FvA+IALE7jJmmk4QrD+va64baIDNM+?=
 =?us-ascii?Q?xn1wcShR47P+lb504sFEOFSyoZlQnm3EVCCU54sNEr6YI4bvjl8CMUKwoHGN?=
 =?us-ascii?Q?ThqSpZ6GEErwzY1PKrUD4skgPW4libysDHOhCgXIRWdcf26TuETLvIOpa+j0?=
 =?us-ascii?Q?+2Bho1UTqivCYS8SkX9CbKzmRZVPddYXG8CvVf69Px1Bhmw4V2yKxaZLjedp?=
 =?us-ascii?Q?FY3mgBGLQRo4IoXcyj+HOYkvB6DDQEX17SZGBF+H27988EWJskKwxm50x0qF?=
 =?us-ascii?Q?JEpP4hRx6jrrruzHzZ7dHPv+IG1Gec2Di0O1VMaZ+6vEFt2u5Lxe3hcdsfEE?=
 =?us-ascii?Q?DkubGuswCoP8+KudjtlM5vMiWynH4E6J4bvmdE5YWspoG7uUr6JuE8axlOW7?=
 =?us-ascii?Q?eioiWifgg01ZDAOuT6QOmDVNMXPKiOAr1wSHvGw7VnYMihlUfRGjSB4Kl8LL?=
 =?us-ascii?Q?RJI64k3LtDK/ZJyVd8C1tLRyQtR9Vt4DbefH68j1M1NdQmfaBtbZbJ2JIhij?=
 =?us-ascii?Q?5cENiZP7IzIXC5kgVHb0XerGyZSah7pVhSGSr9gG+bd4RadXA1O1PiBzxivU?=
 =?us-ascii?Q?w0wI4qirCL24ER0+YWKObYqwOGjUjWGoM3D3gcev1lsbvEy7nVJu7TrQL+6r?=
 =?us-ascii?Q?V7bZs89gytHLkqmDVSnbJTJX45NBZDZiVjTX8w+Iz39TcdMP+8BYOtYOdwsT?=
 =?us-ascii?Q?wuNInmOCmeHoGSvizmE22EN+h2Yctv6HoyFAHL3Wfra90jgfymWEftBj033q?=
 =?us-ascii?Q?oGdU53253/VCMadgGl0QTlNbkoErSDOrM26lnvpmrTZkAO7aUmWMAp9n0BoC?=
 =?us-ascii?Q?IexBWVgIy/WPPkJMya1Awm7UGPENfpggXshAHzw56llXn3OJH8pKeDx7ZULZ?=
 =?us-ascii?Q?whq/5kSyFnKOYhUhWdgQTJIgxvMkzny2t5eRhqTblBxlX8Bxv6ufbd05ehtG?=
 =?us-ascii?Q?4Sa4ofkt62vUCTXgfs4UMTf5PE83KfTMLiE+EiyOFyPBbVQJo4p8M0Tdaszp?=
 =?us-ascii?Q?Kcr/bjErIxtxeSXFrSgCCee2BoxP/J/cpjnrpE0yU6HEN7nDi8OWqZd7FGh/?=
 =?us-ascii?Q?UMcTzNd4Ir4oKTcjs6Inicjxp5B30Qy7VfQOiFt1C3SI8Ep7yrT9I+N6CVCd?=
 =?us-ascii?Q?DL33K3UEn31w+kTIAd0ETR8wIGX1UMyBKdi5qZ9c/c1cQKgttksnuiwO39Oo?=
 =?us-ascii?Q?6WZhS5/dfFmsLJ/mqkIQ8yBgwwzYMk5Oqeq4yfRARGp0qBYZTVRsaOefP3AC?=
 =?us-ascii?Q?OPfaTj7qoJ2iTSPTJXoWxy3U3V/IN4EUyws1kbSreYQi8X0fWkxYMX5t+KdU?=
 =?us-ascii?Q?nQ7uPwRxgWbTYWah4ASzzkjxmwlKBgqkGA3KCSfoGQSqAzgSwDojXy39UFzM?=
 =?us-ascii?Q?HUEu1eV0w09wao0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 19:47:04.5166
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f5a80f9-8b2a-4d1e-79ff-08dd398b3743
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8606

On Mon, Jan 20, 2025 at 10:37:19AM -0400, Jason Gunthorpe wrote:
> On Sun, Jan 19, 2025 at 10:24:11PM -0800, Nicolin Chen wrote:
> > --- a/drivers/iommu/iommufd/fault.c
> > +++ b/drivers/iommu/iommufd/fault.c
> > @@ -253,6 +253,7 @@ static void iommufd_compose_fault_message(struct iommu_fault *fault,
> >  	hwpt_fault->pasid = fault->prm.pasid;
> >  	hwpt_fault->grpid = fault->prm.grpid;
> >  	hwpt_fault->perm = fault->prm.perm;
> > +	hwpt_fault->__reserved = 0;
> >  	hwpt_fault->addr = fault->prm.addr;
> >  	hwpt_fault->length = 0;
> >  	hwpt_fault->cookie = cookie;
> 
> Yikes, so it was leaking kernel stack memory through the padding too.
> 
> We should zero init the stack struct to be safe:
> 
> @@ -247,7 +247,7 @@ static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
>  {
>         size_t fault_size = sizeof(struct iommu_hwpt_pgfault);
>         struct iommufd_fault *fault = filep->private_data;
> -       struct iommu_hwpt_pgfault data;
> +       struct iommu_hwpt_pgfault data = {};
>         struct iommufd_device *idev;
>         struct iopf_group *group;
>         struct iopf_fault *iopf;
> 
> I can fix it up if that is the only change

Sending a v3.

I think having the zeroing in iommufd_fault_fops_read can drop
the "__reserved = 0" iommufd_compose_fault_message.

Thanks
Nicolin
