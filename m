Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C321DEFF3
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 19:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742585115; cv=fail; b=pHpMWO1ix7D2q/89KSyI2zkvAIVfAAVQi34Qxo+/k9p3VyA48TRUQ4XGrpu9aiDbxy/EK5zz2KFvjQAbTvMJARFA9dHSCQI5xiWBoYwc8vTFX2HfypQT9Q8KuDnLgkznaaBA/qqADXvrBijmhavXjDcHOGBAUVfKuufEPrZ+2IY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742585115; c=relaxed/simple;
	bh=3y2DOXc/85661wUaUZiZlu5zhXeMEZOXY0a6sG7bNoM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UaFz9vmCPObBraxoeRCMxGZ4bS9/ShJTn3NW6o2hgfiReNOv4Cl14C5iDxY9Y0rfSHo3Scs0mKU9WgE2gI9azWsh5l9PyLr7I9jjaZHFoeiSukJpzEWUZNg5jSpre5dLAMuaAb78pstUa4F0x0TAeUgGkM/Z5KimmVETF6gcF8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ugZarrEv; arc=fail smtp.client-ip=40.107.236.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ugZarrEv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FNu4XDSOasTOZ+PKumaIulfN7EsvNOlcUMWnbYOg0GzihzFEqIhQMyp7bNKmmqwtrMfpTYCChsNO1tQGryYZsgewa3bjjF5c8bg0Iz6pp3LKqtbZ4ngARMjgk3aNcLzZMCGu/jsk5V6qPwT9Ttvkx2K93lPau6jqs6BMYEwRgVdrUJZA9+uIznMFK0tMRnC3b5GBU+ClsVbIFsm96FCQbfz24VvVpURiYyiLchR9SddnNIHviqCRoCklK7LN7SihG8XvE+RhIOZyYmlqcUIXINDyP0CL3sdxB5zbHk2HEo3XaDdE0r6D7FDPIB0OnQgHAMmscs4kWSGg39HuYdYHxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I2U7B+6m1kXSdgvX4udslyQwbThZ6SOOeOUF6VoJ+4s=;
 b=hSx9+cuNXVWKOtxTgRFSMgKD331CPK7Ek6McozEm2jWT/Xa4kUeeFkl91YErtHptG7R39IbAICb+WvKCCY0Y+1zffWcuB/6iKgBBKFWzyjzy/wNy+wfCLMXJaWTH0ub9ZyNmxWkGCa302yedVD7cTj35O99FTKeSHDytSkKl/1Vz1IEom8f3wJ9rlfIDQk/7QchLsA7Y2pKYsuJO+ASdBf4ckASy1vlMhlRaMH/G/vTfzzznk3VyMl0nQqKfpAHVou/SLXugXts00XFwVoWIW8UX9NI+uUMrwRu6kVp+IwjQZSzC1guTeaDKFioxtEYuWwdxkeNLQrO4fnSkSC/QQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2U7B+6m1kXSdgvX4udslyQwbThZ6SOOeOUF6VoJ+4s=;
 b=ugZarrEvi4w/LYYx6ej/ns0C0F0vDx9k2bQ4HsRCgnAsXcnc4s8xlkUAmzaC4nW5pDNT3ucM+utnziiCadh3ta6HG44//OXUxKaZqePhW+pJp9prckEXm/JZpyj5/baee8BJxpLR31HhkE2uxQhafC8rLpcQ2a/SKy314fDWfOU5DZENMGsOHDVonyBk+GoioYcZnQ1edYFJtN6unZ0isTXcQDVOxtciZucAZlsgDAXj9xDM0L1GiilPxrpz6hvZisfgh16iEUUvNbpy5xStbSgg9zFvaFGZLqOMsHI7R7cWzbMbQKWeYJmYwJjzAMTggv23Ia0rqppnVc2R7hrfpA==
Received: from MW4PR03CA0332.namprd03.prod.outlook.com (2603:10b6:303:dc::7)
 by CYYPR12MB8730.namprd12.prod.outlook.com (2603:10b6:930:c1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 19:25:07 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:303:dc:cafe::2e) by MW4PR03CA0332.outlook.office365.com
 (2603:10b6:303:dc::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Fri,
 21 Mar 2025 19:25:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Fri, 21 Mar 2025 19:25:06 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 21 Mar
 2025 12:24:53 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 21 Mar 2025 12:24:52 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 21 Mar 2025 12:24:52 -0700
Date: Fri, 21 Mar 2025 12:24:50 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
Subject: Re: [PATCH v11 00/18] iommufd support pasid attach/replace
Message-ID: <Z929AnYWDo22N5S9@Asurada-Nvidia>
References: <20250321171940.7213-1-yi.l.liu@intel.com>
 <Z92iIdpNz57WDYyS@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z92iIdpNz57WDYyS@Asurada-Nvidia>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|CYYPR12MB8730:EE_
X-MS-Office365-Filtering-Correlation-Id: b4254195-53ae-400f-1754-08dd68ae1630
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2MMa0srWXZXnUmau79z/ikuVEwG35aa6eAUvfbBYAe735QqcHe3Twmpan/9z?=
 =?us-ascii?Q?FON6zzXhkO/7BjxxnQAlttDWFvr8TVjv6Mdl4sKywYzKnA3AfMd3MZsQQU1q?=
 =?us-ascii?Q?baDqDuqm7apg3XfX9pys7Mjvk1NxpVIndgPzYRoRY4lglZSbNTT5UNBC0ztT?=
 =?us-ascii?Q?MC3LbL4k8oxWRKxT24bqkMWbtps9Q9YfTx2097YbDL9txmffKdFQB8Mkon/P?=
 =?us-ascii?Q?5M7vmCFbopWZElInpR/OArzuYEcxd1PNiOG5QHchCBLanBuOT3dQn7iXWqQv?=
 =?us-ascii?Q?fybNY0zvIYmdfYt1fxl7oAEmv4FJwmjybTAtvcqy1/mMRh7lWn+hoJmX0EOo?=
 =?us-ascii?Q?w2lejlrqOptFcQTnu5lc8GkfSN+lN1gmjn5I1J93EALoBHj591rrF6fZGqoe?=
 =?us-ascii?Q?iXfnoWONDBM4kD73H9bXidx2o+xbw37LBSLt13RX5bj0Q/fLOK/PjTgwBwsR?=
 =?us-ascii?Q?6clXOKHtZeobllEaMW1Kvw190NSGR2F3R2vi+4Q7UEb4Hg+N9LlTw9zxK6X2?=
 =?us-ascii?Q?Jv7sV5avWrPxcmRzoLo8ZgvM0u1rJP1K6vmGB2utnsmhsz+JRmAQAo9MGv6L?=
 =?us-ascii?Q?ZEYjhfSeBrzVrXKgeP2ZwMu7Jg4ZRsg4+YI8/buu0v74xeNr56ceBQMxN148?=
 =?us-ascii?Q?jZ9YsDhstIrx0LITnqqV6L+W+NYMVJCF+Oe5ieJLElzUn1XBCCXJNdTr5dqA?=
 =?us-ascii?Q?9sCrf2ck/jH4zBmFPpZFADvYz8vOUMVB2tEijEtPalb7yQjcJcX8rupYwEoP?=
 =?us-ascii?Q?cO1P9PRFnVOlamLMzujk1TrD1CfenPJxozIyeUmfdPsiEMYJDLMf5+DG4TMJ?=
 =?us-ascii?Q?reknTn7Lcim0CqcB0nuSfcvrZqJn1VUU4rHNT2BpsNSqpwnr+ytKWh2ZsToS?=
 =?us-ascii?Q?X0aYW0/BJstahJDudtwPassXgJZJho8vNE/9IoP96c4v/hK7+jVMsi27Y/q7?=
 =?us-ascii?Q?7uVXQQQMwx0yd6xjQBkj6/bjXTmZrXjeu/8FSI6nhfGZCff57uoJCOvj932m?=
 =?us-ascii?Q?VPPqF1LNR2jwfO9si2jw27yXPMg3hyoM6TuHCp4LebiHzTtEUlm+33YgM+M3?=
 =?us-ascii?Q?kw09JJxVfXxf4QRrqDahkpmWrhYAD+cpDVad39Yy1o184mq9Fr/oCWGko9yK?=
 =?us-ascii?Q?TzHBLoTvX8wTjmB6dLcvbW9rlXnFYi6GnhvcvhDSvAQQdGaUjiX2S4kAEN2m?=
 =?us-ascii?Q?5Eq1Baqc0z1IdAaaceFFTslM13f+OQstJ2oTWA9odJsgu5mOfDnx1WnCPfc+?=
 =?us-ascii?Q?k8YZiRxJvNZvGRVCpnVduhuSekH0ZXTBdT+8RQa5Tcmcgdt883B0q+Sl8Pez?=
 =?us-ascii?Q?8tpUUhPT6e5geXY7PPYavNOTbOpW3B7r6qhK8HnfErnRBUJOQE7btDfjtKJG?=
 =?us-ascii?Q?5irb5BlyG+DMaXQRr14Fkah74cn1qH4Yh+Hix1eNlxGiJ121jo2GbL8ehq+V?=
 =?us-ascii?Q?iStVgD4JrzNTFURvgYtWeAcnlwY1Gmry5EzTUFMNwuV2d3BI1awpASYa9mo4?=
 =?us-ascii?Q?4nJwnZU5jeAC2qo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 19:25:06.2170
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4254195-53ae-400f-1754-08dd68ae1630
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8730

On Fri, Mar 21, 2025 at 10:30:12AM -0700, Nicolin Chen wrote:
> On Fri, Mar 21, 2025 at 10:19:22AM -0700, Yi Liu wrote:
> > [2] https://github.com/yiliu1765/iommufd/tree/iommufd_pasid
> > 
> > Change log:
> > 
> > v11:
> >  - Handle is always valid for the replace API, hence drop some meaningless check (Nic/Baolu)
> >  - Avoid inline helpers in .c file patch 02 an 06 of v10 (Baolu)
> >  - Use xa_load() instead of xa_cmpxch() in iommufd_device_do_replace() (Jason/Nic)
> >  - Fix a memleak in patch 11 0f v10, it's due to an order broken (Nic/Jason)
> >  - Make the auto_hwpts always be non-pasid-compat to avoid confusion between
> >    the RID and PASID path
> >  - Add pasid-num-bit as 0 for non-pasid-capable mock device (Nic)
> >  - Misc tweaks to the patch 17 and 18 (Nic)
> >  - More r-b tags
> 
> I am running some sanity with this v11 using the iommufd_pasid
> branch, and will give Tested-by in the next a couple of hours
> so long as everything works fine.

Tested-by: Nicolin Chen <nicolinc@nvidia.com>

Ran selftest and nested SMMU on ARM64.
