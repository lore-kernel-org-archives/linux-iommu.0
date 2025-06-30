Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492C279D2
	for <iommu@lists.linux.dev>; Mon, 30 Jun 2025 19:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751313080; cv=fail; b=oBd4YuSRv43H3OsO0qFxTjy0SfElqOV9hJp7Nu1JhmU9yuocfPJW7ZSKd+DuDc4w0ydserhqDYkssZ/t3igcB03cpU2LMnA6zxmByQTpgTddWK8wLZaN8RimyKiMKTVv5Ko8NVCn6gqtzNxePk59CduVdkvGl8CrsLecY8eT3Ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751313080; c=relaxed/simple;
	bh=hKPEEhae42EEwEpz/6ZfC3reRl4mL/7pzHBBaWGYQ1U=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgnD+3R/GxQ8iY6VlNHNwFxXUs2sxExc9/15paZ906ByGDdkB0paw/gnvXtlkov3sXtzFG9k+OCs04Jd4grkNHnhCscBFOP8rGzsOVxKLAcD2FwDx0+OLdUFuSJob38S1YpZdupBqowKXA/CVYoFTtzSElRJ789e7FeJszNcGbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fuC2cZA4; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fuC2cZA4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=igiSrN2LQ4hZM9lJJZ2b5JLE3akm/qGl53mJLhJ0jQWQVfGmciuh7uKKSE6jEnDtSXFCO8CDdD92OXbLTZ9P5YlZVzkZdeiQuVbi//Ke/FchLS0FZ471/JGKWm2jp7+rDMIyabVqa8sjERxOjzdEobZ06qbA68Z9MbRgNdHoYC5xn5K4rgdrkDSpdZGotkQ19HIlbFiec5i1d+pstZ0G0JNdsjcqzfsDfB0tzL9tlMq/fT5KqhorCoeO9abIC+Z6dYwhxPDM/4Nkja21RuIi0aOlEVNeDZ/C6l2TrmjlyuY9HYpst3fCbU8wltxPLMvBZ5U33nDLu1cuS40MS/hJSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XRjPmltJkslEastg9NSFvvHYY4bfacacuX3TrLhCXJE=;
 b=g77r373jQ0GTLeoxDao/faqcZMj6uE/ksvnQ73zbKvdw/m6k0HVoOCZVbgo0mJCu3fYror/gou5PYcI0QxBW7pl3Grb7+0aEkwvKb6S++YW9KxhDox9yza6N8F2+y2SGa2AHSkuDe+bDuDftVn4gjgtESWjO1CoDvK8Ol++NFRf0Ow36r9YNp3XbrXerM4dWMJNThCK4xAJGtirTEC2NlvOAodQ7kXsA6xNkug9c2HI3OsJGT0gfk7UjivhJnmpWZc078ora/AHoPvLz8hSRaZL44Cc8A5b2WSfwHIpRuyQWj8D4TaGj8xao7eNBoAina9ixJdVNXAra1OEOo6ANFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XRjPmltJkslEastg9NSFvvHYY4bfacacuX3TrLhCXJE=;
 b=fuC2cZA4acRMj9AHY00gT/Op0wnjYqHuOZhsHAJzldFXkYlm/qqVYIfR5Bt+6RPKlw3pxqENVQigJcU8R2HprHOTBJJFGS25rh9RUeJMxP/d50O6GS3AgSLb/ehdsBsnq8fYyp3iRz+HToKXDDnuZ81+QNQbizDUh9ml2+kDEsnwwaLbTrEkXUlt4JPYL3LJEYZQ1klPaOLi7t25VXdhyxDwaIYBsYYvOtPjGY1L80K8vUfSYB1iexuskijr7/c8klVM4vsB0Y+cL/o4SZp89P6A61AH4FZ0cdk49/Kmon5hZTb/DamUa0F8jyN5+65pMG1oYDS+uJKCSsu8GY3GlQ==
Received: from SJ0PR13CA0228.namprd13.prod.outlook.com (2603:10b6:a03:2c1::23)
 by MW4PR12MB7167.namprd12.prod.outlook.com (2603:10b6:303:225::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Mon, 30 Jun
 2025 19:51:13 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::2a) by SJ0PR13CA0228.outlook.office365.com
 (2603:10b6:a03:2c1::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.18 via Frontend Transport; Mon,
 30 Jun 2025 19:51:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 19:51:12 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 30 Jun
 2025 12:51:00 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 30 Jun
 2025 12:50:59 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 30 Jun 2025 12:50:58 -0700
Date: Mon, 30 Jun 2025 12:50:57 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: <jgg@nvidia.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<will@kernel.org>, <aneesh.kumar@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <joro@8bytes.org>, <robin.murphy@arm.com>,
	<shuah@kernel.org>, <aik@amd.com>, <dan.j.williams@intel.com>,
	<baolu.lu@linux.intel.com>, <yilun.xu@intel.com>
Subject: Re: [PATCH v3 1/5] iommufd: Add iommufd_object_tombstone_user()
 helper
Message-ID: <aGLqoSTOfppG1MbB@Asurada-Nvidia>
References: <20250627033809.1730752-1-yilun.xu@linux.intel.com>
 <20250627033809.1730752-2-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250627033809.1730752-2-yilun.xu@linux.intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|MW4PR12MB7167:EE_
X-MS-Office365-Filtering-Correlation-Id: d1752e9a-fc9a-40ec-41fb-08ddb80f77bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d1igaRvnDFWpQIX1myKclwfdnrwbEf0/HhWMsW203hG35bSRY7c6C3+HWCAb?=
 =?us-ascii?Q?SrBLfyMffZQGjdSv2UWc26ag5wZAV63sqNqf2q47o8RRCymlAKC8HEiTtl7w?=
 =?us-ascii?Q?skeGwmYtPdIwdSzxJv1aaoV6ZA1/1OORVXjobrN5/qfe+vwyEW7s305TR00M?=
 =?us-ascii?Q?x00xZMK3twxX3qdwCPRWngmr+4YrJaGhQ2Y3SSrO5Zv0UduFzinCijms/sPb?=
 =?us-ascii?Q?MuK6qotacOfX8An1gxl3HKAxzvjlYKyb8QQmRbZMbxNjQGRQuuH1maH6beAs?=
 =?us-ascii?Q?NABjxCPNsG7abP6Zp654EcjpcP6QSk+iC8K0nGAEF5iEY/q7HsnUdxpZZQb1?=
 =?us-ascii?Q?xXKAax/LgTqyW3ZyVvMhNr5dgmAABDjGkgZsaY/daceagePOePpWlMKLILkH?=
 =?us-ascii?Q?4jXM4+tk2bgYay3rLW+0TP7zVgSjAs1KCoGmiC/7sGITgwoAeFOLz5eHlWRu?=
 =?us-ascii?Q?opMQ41KlLnSFv4QoI5Sji5wnBVke8Yxwx7BuDH9gIOOaWa+Ri53yaIvZ58Az?=
 =?us-ascii?Q?fKOb8qZ7GvxBWI7ZtsK6V/PbXoB6VgZVx62rbykjbBbncg6gv3Kzo48MA2v3?=
 =?us-ascii?Q?nUs2OgLCEBE/gVUs4l9WcYL53nXHz39gP3v5+FCX4KFenGfvtc+4nuW1TEHT?=
 =?us-ascii?Q?WykmXWRZN8uc3AjOon/mwDC7Wj61LlF5mStOGnPodsjbUrSMeUA12Pp3vwax?=
 =?us-ascii?Q?zPCuBNcAeA1+6WMbjitD5Xv+ROc6hjQYBkEHjOlmToNrOoQxfTU5bGMT/Nvh?=
 =?us-ascii?Q?K2p6+MH+Z4/ajYfzkiyhy4PHa57cDFOgnN7828HxursvcjphH4nY9y7ex66Q?=
 =?us-ascii?Q?UtX02VlCyw+Lq+kqqGcZoVAA8wDUMNLXRuepEEidAUZ+Js1QOfYiJiuhQDor?=
 =?us-ascii?Q?VzFb12RGcjw61RohfFjHfB47KQcmRDcu3XXU8F8NaRq3p5mMY/4wlS4qEgxX?=
 =?us-ascii?Q?yqSky+zRF8oYbehWUQ5kkIqbnY11rXC+gXt5JLbRlNfEF5SPZi1AAp8Oie62?=
 =?us-ascii?Q?Kv6lpgDMHTL/3vtjumMYOgBawLjNs0+IlrvL5KNijk/tRINFQm0gH+lPvi4Y?=
 =?us-ascii?Q?KzbOAaFuS+xNY2cU4nroAHuDY5xQTDgpmDonD9+lmfNclRkIj8A44Xm154GI?=
 =?us-ascii?Q?7PpasnXuf9wkRSiYZVpmAwX3eycAHrz8nqbCFktjR/5lEGP7vZo3Fx1Ytk/J?=
 =?us-ascii?Q?7CTlgd9j6mEZVI8Epc5skk+WMOccB2eJPPKHBMiaL6PIr/N+jZgGUANppVth?=
 =?us-ascii?Q?FeZm0M5kLPEONBEOKisfMExVdgq+2iNhNCLj+peEoJKiOGEefpL9PKhsQmxW?=
 =?us-ascii?Q?YgIw2p3kleQLq7++DJMWpUPwUaPCAoWEzslPheedJmJ6oWpBB+/H20LWOYFs?=
 =?us-ascii?Q?njg9FqjMsohGMZfy2sf0Uo6NXx2TFn6WmLNdI8pkVlIT2bctdh5EhZqQrY8d?=
 =?us-ascii?Q?msLdA9J9iPEUCNxjRxVoygWuz+9G6ZaIF5Xi0mAq2uMkQu5H1jLXLa+rVF1F?=
 =?us-ascii?Q?+wksK1lrh6MIgHIQ9Lj4XWuXZ18F5G+qS7pf?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 19:51:12.8990
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1752e9a-fc9a-40ec-41fb-08ddb80f77bc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7167

On Fri, Jun 27, 2025 at 11:38:05AM +0800, Xu Yilun wrote:
> Add the iommufd_object_tombstone_user() helper, which allows the caller
> to destroy an iommufd object created by userspace.

Should we describe it "partially destroy"?

> This is useful on some destroy paths when the kernel caller finds the
> object should have been removed by userspace but is still alive. With
> this helper, the caller destroys the object but leave the object ID
> reserved (so called tombstone). The tombstone prevents repurposing the
> object ID without awareness of the original user.
> 
> Since this happens for abnomal userspace behavior, for simplicity, the

s/abnomal/abnormal

Nicolin
