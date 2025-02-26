Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF143270028
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 23:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740613536; cv=fail; b=foi9Y/Zw8Je8uU3RNowJ+emeuEJmsFHey5CEDIjGeb8Vz5FigeYNju+fjZDTwnAVKyxlT4+ntoLijk3lLonWq+RDod8pjSjQ9yTUFNzu5wTHa/vEno6JySYAT5xUpKHE+BjaaCthpddp+DCopyG3/lkrreweFoKSTVkBim3O6V8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740613536; c=relaxed/simple;
	bh=HOWqr9orGDMB/h/kCjwIJrYM7h992Klh5sAD9fd+HYs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZkLqVQb7xGlG5IIAZvjmdfNb0Sh2BDRaR8UV6Q2kAIi5uiK9jEWxmFV0mUHrCjSoH2qrpaBto2qqEw0uDs6Dq1pXadcPtycjYWB/XHxDiJMcaC2bM0YmdYoWwAnr/jY52X/oDzKWiHcf4ILxYUycBGBcTITE7B0iZuHtWBU7eAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fzAlUZ3H; arc=fail smtp.client-ip=40.107.223.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fzAlUZ3H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PL5SyqlVDFaTIBfN8j+QcK7Muj+eNdZVX22EOq+JIxJMWR579ZkL8Ra+hnHHjCNEyGfMfN24pqEiPy+556nDm56jRB/69Hb4rIlfRx22Xsab9bwyhGcIxGQ5NGqgSCCNw62cwl61plVcSIxGxGHbg8c+K3DHfO03U4vJPgFoKKKlXUbgOKzAEuuN4P1PqNVR6q9YwhWVL1oWEH/jnnH74z9REec8VLRxhAasZNmMWvMFwOnBHlBpYzQ5vyAEzG7Hh9W/aWzRsyYJydtOyGWQuOA9gD/o+ecMaMVlMpskJciVSblXU+rU9dubHsI36lz3Thz8LF9oH2DOmMiVOuBapw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/5HEvbFAC0slZ5yfgbRKJw51fV4w6HMwztd+DBKUgE=;
 b=mZZwbYKGQLJB0DnwdIVUH3y0tBw/rn/IXLfTqRalt/4oi6U1ZwK/oP9oCpSWLa+FRhs0KW7Dr1SmhddFGM+UwQ49tWeKF1xvKMVS+Cyn1jONazcS+Sxx+iVbd7h5O8ouR1M9lKKdkjzcVwYvDWFzOCYl7VBaU9iqqI8mgo0+HXdYvJbPU7SrSQ6LYc89qxDGxpldMuoIfUtRz7OmgaBQ354Ju/DhGWHqisCmQ36/UTShAD5l4b8+PgXk1Yzz67uE22VYtkQqGMdbpkYZ4RhQAJmPnMTeViC53tI6CqDTQKyGQuxwNOG2xK0Il+Of4juK1XxLyDI0lrfR5TdA/vReFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/5HEvbFAC0slZ5yfgbRKJw51fV4w6HMwztd+DBKUgE=;
 b=fzAlUZ3HxkREH0MnY29mZqU5w4Hy9pIMYQ++BRsqB7c97Fu3hFqoJAQo4qvCj9vUMTGnVqY21aQtAa5ktMbgnog3ABuY0gDM00xzj94P+oMcD2DMpNGhIPoV/9l2xGtJNo/OI444q67H+wbfTUzX5fNH6SEvSrW4983svrrdaIvBLAfgbL3ASrSQbl2Bthva5a8u2eFUlE9VxkipU3VLjHFQJTyplevYPbD7dRysVpXKkkHc2rRFmzKjvHU1BS93BYUAwvhF9q/65ZUio9YmsrY2RWuX2Ivt+6iuoc1cSu4+QfOlZEdcKhXCucgbjWRnAhvzud/BW7EiD7NLKyJhoA==
Received: from SJ0PR03CA0234.namprd03.prod.outlook.com (2603:10b6:a03:39f::29)
 by SJ5PPF0AEDE5C3D.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::989) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Wed, 26 Feb
 2025 23:45:28 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:a03:39f:cafe::e9) by SJ0PR03CA0234.outlook.office365.com
 (2603:10b6:a03:39f::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Wed,
 26 Feb 2025 23:45:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 23:45:28 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Feb
 2025 15:45:21 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 26 Feb 2025 15:45:21 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 26 Feb 2025 15:45:20 -0800
Date: Wed, 26 Feb 2025 15:45:19 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
Subject: Re: [PATCH v8 03/12] iommufd: Pass @pasid through the device
 attach/replace path
Message-ID: <Z7+nj5ZpAtpdO9IO@Asurada-Nvidia>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-4-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250226114032.4591-4-yi.l.liu@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|SJ5PPF0AEDE5C3D:EE_
X-MS-Office365-Filtering-Correlation-Id: 12956c6d-01f6-444c-c649-08dd56bfa657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iFBd5cT0oi+YybbCcxE2vnV1kZf4poP/+DaopFOdxwxWwqpDHsL/c1gJQosO?=
 =?us-ascii?Q?kc6TW7zi4lF6XczQVGUEWR6rqtSIz8U4iPndAXnAblQZIlSnb2mffZxWzC7k?=
 =?us-ascii?Q?SnKFl34BgaW1T1K0iSJlMvGGix6ss3kYMGG2fdZ7duzfDSZ/wR7P7jd8m0z+?=
 =?us-ascii?Q?loGAd/NZxe4D73xOJuY5XUO64TTTvdO+u1LWf9ff6h+GoYHViYX/qBZ3mz3K?=
 =?us-ascii?Q?5VbD0mMRtu0IlMKutHERziqB7dYfL7a4TdAdzhnru1gEYUyGGJspzlOH7/J9?=
 =?us-ascii?Q?4U4F16/Aw+aYK/Io9HELlWZ/qBlCeBWZ1nBQt1TyDM5jgbmg+47MP+wfbZ++?=
 =?us-ascii?Q?7aI4XQmzgnAhK3t2tnaKoUc9gGINwaKhfwpVv5c+d0M386f122py3UjwrS8f?=
 =?us-ascii?Q?WoMt6Vc5LAcjztAm1Qnyx/QTtwUM8e8oqdJus3PLTu+NgTmiZdwUtIX10cvS?=
 =?us-ascii?Q?qit3uQI0+7V5z3Y4hYyEhaX0OjO77EsmOY2aTqUpzkm08G7uoeIIhzIZ0z3v?=
 =?us-ascii?Q?g+U2/5cA3TEkZSewNnMf5fHeXxP43iP91t4WMF4a3kMENNA/Nzfn9CFZeyUK?=
 =?us-ascii?Q?mGqeHES2G72nJra9p8jAKOaqrr1YjpRF3qZQXe9p/sZS9Hhxmt2rokqj3cmq?=
 =?us-ascii?Q?hHLtfvO/bG19SrhW/phSqbKxq3NlvnY5USgdlDqJ3rTn+qg8qPfvIkV+ts8j?=
 =?us-ascii?Q?rBiyDj3z1cHICKlFFq1b1A7iTgu8sVzkbOKbfbF7RGslfg689im32uFndri/?=
 =?us-ascii?Q?mRkqe229Aj2kWvHbII6CDjz0cAk8UyM8suyBjgs93t4nkiXofSexbbgHYmFz?=
 =?us-ascii?Q?zIMJEoAo7lSD5V7uRFbb2cbQgc3E6MyR7c/Jlg9FqExMANYoZ+ZZzfxk/aHy?=
 =?us-ascii?Q?VEtFnSnJsqnKioOXlzX6eYKfldiwbR3xizW4Xj0gPPo66r2acg62a51sGmkS?=
 =?us-ascii?Q?gcER9Kzld4vjmgXiaQ+GQUk/g94KFwJhLDcFVmDEMhZ3WE+hKi4ujJ+1GlNL?=
 =?us-ascii?Q?f2b/w0OXNAhyUpw5PIByXqGcg1e4zErlOGNA+RBnewN1x1JUcmRssghD/0hC?=
 =?us-ascii?Q?xVVFFBCIETqOUWSlS2LWCgrHd5GE5x4MzT2tU+Xo7rdt9EkMoxVntNkiEPPQ?=
 =?us-ascii?Q?Cyf08O11tDR5CAV9KUEuVOKniDTFfATPFNWtSHKiwq5ZLZqBwzQ8dkkeF3PI?=
 =?us-ascii?Q?prhuSwo52oVh3g39FivRBg5MDWQ7KAoJ5pckLSpk+SSS2+TVYDvN6bC4nA2V?=
 =?us-ascii?Q?08vBmnEZEzaqhy9+mzxuyX4J0m4nBUHh81ehu20Y+qVncRFGlvEZw2OhD0AF?=
 =?us-ascii?Q?iQeK0yvJsStbJ3+XpDAoomy/W7ZKWnBKbXtTfKGpouKSBryyGu6xTerlkY5K?=
 =?us-ascii?Q?g8eM9q1eDxWqZc3EK2/dJRfXYmS8/IinsUZTNImdd7vln/4888q5VngpN+aq?=
 =?us-ascii?Q?/7fcgiuzLZeZYdtb3ztXhnJ/a3sXvWLHFQVA/KyATGKe+gUNBrGyIx3Br18I?=
 =?us-ascii?Q?z6CXJC/h7v0nkWs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 23:45:28.5521
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12956c6d-01f6-444c-c649-08dd56bfa657
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0AEDE5C3D

On Wed, Feb 26, 2025 at 03:40:23AM -0800, Yi Liu wrote:
>  int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
> -				struct iommufd_device *idev)
> +				struct iommufd_device *idev,
> +				ioasid_t pasid)

I think these two could fit in one line.

> @@ -187,7 +187,8 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
>  	 * sequence. Once those drivers are fixed this should be removed.
>  	 */
>  	if (immediate_attach) {
> -		rc = iommufd_hw_pagetable_attach(hwpt, idev);
> +		/* Sinc this is just a trick, so passing IOMMU_NO_PASID is enough */

"Since"

>  int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
> -				struct iommufd_device *idev);
> +				struct iommufd_device *idev,
> +				ioasid_t pasid);

Here too.

Otherwise,
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
