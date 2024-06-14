Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFF718130E
	for <iommu@lists.linux.dev>; Fri, 14 Jun 2024 18:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718388759; cv=fail; b=od2Dj4IOiOtvPZwyXVujTVoPE3LzH2Q4PPvnlx81nHNi/iv87lZHpVnyEHakU5nnnkrr6gsmYB1ftufdG2B1TbiMeSHrzbRq1rnCRDTR5W1YdImTspL9d1ePm2ifByBR4myvAalEJQcOs4cLjOmagQcU/kVoc3HAJc3SqFthncw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718388759; c=relaxed/simple;
	bh=s4ueqlIj/bQftCJiyGUbxJnAlT3RcaZPS3rcOJ1pNs0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0NSAE9BdMoshWWVOc1j3lwlAT8aaY09JSPZHS5wEsANavHRQj9AwOrua9ID1pITMULxXcE5eMEpsCB45FvGniLwjUy2Z+ti5F6btxErobETsm8D5cQnb39OLIfDkADo6nV3adBjjHGBddAZhYt8rNv9MZ8OUveqXoLMvt4PGzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=COru0A9j; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="COru0A9j"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lONfaiy8AUnRpkXXD+JT1gbE3zFm0qN4dJryA98IUtNfIeQws7B+REC12AoEzhlMMby7DQNEEPzCn9XI5zBKS34CIiZM8jjLYv2h6t65PJcXI4pJqchE0xh6dtjWv7hV10KtfoQO55GKb8uLEA4O/bAQ5Pa9QV85vqfQTkG8HwlTkUWQFjruENY1dxiambSf0NgSQg8Uh/azWqWxGhANzBhhGYDP5pj2QO+cbE7tJ97pspGwIV/c6Z+7+6RVaSkJTAGLJBXGRUMNr7DPAgCnD783GXuVjWxbnaqW1riWy6tYfP6cPf1EkR8GEhBMlol32lkfwH34xCLzwF/7TjNybw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/W8oMzIMvkvmHUe4Y49JHfJiCDgfrJAHbeL/8UEUvrY=;
 b=Pb09OSxyPSJQ2yVP0mufkqM7x8/SKEpBcIqnDGbyyXAqzJf4jgi2V6eiN6TorOszqGth2YIbx5RUCLSEal7fcsN+0P5uhMQkVdaUZ/oTk7NBaDqOrZ0hAIH6l7vAYnfMaOzJ7OM3ZsYxOBjzteNN1SDqjQ+yWdbZpIcRqvaV1VGmp5APC3+p1YckaCb3dPz3N4PBdgSKRmECGdDCCO+dnPtFckt49pww3qX6cRL67giSc1K8e/IoBqKM5QaZmphMafdi7LPOhMpDnZWAbFQgb/C3yP2wBTPnh5p6RjKmjvrB4PY+wwklBI6rO2gKRc8fKM5T6KW0ALhx1C60UXcCRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=sifive.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/W8oMzIMvkvmHUe4Y49JHfJiCDgfrJAHbeL/8UEUvrY=;
 b=COru0A9jCFWe5YLw5GzpOLcB4YaMMFqa3SKivDwFZhXHyHgyXlBTx71i/pR5rynYmXTJ+koyHHHxvhMP8wKl2lGitVKrBG9tzruPzgYRa8nyNVli4+ZD1jJW+MxSzorK7puE7yiK/QuAXV3BkRNd3fH0ZaQ/2WunAko76RVm2NVMPErrdc1GJUzsynzojcwThCRowU8ZQvbbKcJq8mgiXgfZJr5uSL+hx+/VPcvY2Rfa14QBHZNjJcQJVRJoFiONl/TJMHUuhB+3NVkYqAi4JZsNhopm7FTsVcnd0ZNPT4qsDGylSU68Ptn8FElkWS5WzuS3Ih7bjibWtybx6Jw/7g==
Received: from DM6PR06CA0048.namprd06.prod.outlook.com (2603:10b6:5:54::25) by
 CY8PR12MB8362.namprd12.prod.outlook.com (2603:10b6:930:7e::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.25; Fri, 14 Jun 2024 18:12:34 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:5:54:cafe::a6) by DM6PR06CA0048.outlook.office365.com
 (2603:10b6:5:54::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.26 via Frontend
 Transport; Fri, 14 Jun 2024 18:12:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Fri, 14 Jun 2024 18:12:34 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 14 Jun
 2024 11:12:20 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 14 Jun
 2024 11:12:19 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 14 Jun 2024 11:12:18 -0700
Date: Fri, 14 Jun 2024 11:12:17 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Zong Li <zong.li@sifive.com>
CC: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<tjeznach@rivosinc.com>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-riscv@lists.infradead.org>
Subject: Re: [RFC PATCH v2 09/10] iommu/dma: Support MSIs through nested
 domains
Message-ID: <ZmyIASyk5pfm8hwa@Asurada-Nvidia>
References: <20240614142156.29420-1-zong.li@sifive.com>
 <20240614142156.29420-10-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240614142156.29420-10-zong.li@sifive.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|CY8PR12MB8362:EE_
X-MS-Office365-Filtering-Correlation-Id: 77e81f9e-e287-4e50-5e2e-08dc8c9d90ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|82310400023|36860700010|7416011|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KbBppKAo8dnFBnk2f5NsOlF+CU7HFZ3a3+7bWMOs8EWJSNikZv6PA99Jb2/7?=
 =?us-ascii?Q?sUUqwRnsQ1x3wlQSLSGcBm8ccPvb9Sm1mGW2y/+PCyvSIwvLDtICWHnyljH3?=
 =?us-ascii?Q?8YuJ5KKRnD7Tmnqo1Jv+s2di8oCMq6NlC2LmSuB0zgldMy17+7+FNUbZWNce?=
 =?us-ascii?Q?wmAqtXsuWEdVXcvN9mymix4l6gGq0RGKNT8fEeuLPme5g5JC5a8WKPjpdy3I?=
 =?us-ascii?Q?qvIKIkqzNjn5ayZOwSAFVM5WidxdE23Rip2Ar1S9wTOX0MJCA5OLDoT8KNPr?=
 =?us-ascii?Q?mNaRlGiU99Yeg17EFTXRgYcLJE8SvgMBhCc338m1GheXxzH/Hsgv4BV0jLOA?=
 =?us-ascii?Q?S+lPR874g4NepE5H3mqAPo5CfQySuTdmkHM6V6KVbXSULRGu/7OzYNVzYADj?=
 =?us-ascii?Q?m/hVx0+n+zdKjiWsz1zNUmA+n9kBo1IXTSVCJ/Xh89DmZ/d7t3aFjW07qnmw?=
 =?us-ascii?Q?F4P7dEDrMTA02n01SFR/SdpN2gLV3L9QZLm2W2AnTwfe5ooFPqRvanGB8qUj?=
 =?us-ascii?Q?hrrz82Qv48Urr8BJTQLcWoIDYaEs4z+dxHxpcamfhRouQbYnYFDjyppH+LPS?=
 =?us-ascii?Q?lr+6k9xFxZqZRI2k7e8soZkcDmd3Pe0tMOaImrWaEpSgDBCJvihQVm1cRWdy?=
 =?us-ascii?Q?uRpHWVoSx72uN3q+NN5xKUiJlcXWRNp3agL0jnydguD7xqMTG/OVehobs3Og?=
 =?us-ascii?Q?ejpyE7mpc4Gwm5LwKbkbyIwz6DUh0JadCXsVZZaPaP0WQ99JJxXH/IY2a1lR?=
 =?us-ascii?Q?SsCM4Kgk6j1nlO1ojiHqeT5AOXbyV3QV7dsJnaOFvkQ2voKiVOumSwtVVm45?=
 =?us-ascii?Q?ekFzGXU4P3B8pAx1cBND4AKzcCZojayqlQXuEj1aeYc6C4/t0NgHtiCl7coZ?=
 =?us-ascii?Q?Unqfrs8h7wXpGW8AkpPw8uJM5vCBB+o2LZePeUhkVSfr4w0cP8/5vzY2ADRB?=
 =?us-ascii?Q?gxEHElqnXNaMRqxa5+knvHhUtoF3A0TMLBZcoLn+FQTR97A38cJnR5jY3Oca?=
 =?us-ascii?Q?jfby/dYtDziYEFxUiSO9iG+5LUXf7jrVbvNX7RkttJDbGSFkgWT/TZ/CZqoS?=
 =?us-ascii?Q?VlDadhcMmgV22uLya7lrdYqJlcb8UmNlXAIvp1+xAPWKUXfIJFWyp0HmuWkJ?=
 =?us-ascii?Q?9GVSuxWaKd+Ot721m1KE+szyx9cSFcyFB/X2tLbkTAdkMilepXuoHZ/Uocds?=
 =?us-ascii?Q?i6QYzG9S/ZYcbv6E3yVsB45xnjLuVM24X3j5HPr22mB/1lDEjW4+OeCug/2p?=
 =?us-ascii?Q?V1eSFFyMEYlFmCS5THttUS4rbfINuUx6ERxx2mGfa3mPuAmxFI+9+bZh6j4K?=
 =?us-ascii?Q?cn76x4W0cGc3Cx3BUJO9yJTG66emjN87lqU2H3AiKeGpSd0PQZlaTOpo1eR8?=
 =?us-ascii?Q?72KptEeLKk/Xj8hkKkwUfLkQdibRn1vsvkALavB/PsmK1wrGsA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230037)(1800799021)(82310400023)(36860700010)(7416011)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 18:12:34.4248
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e81f9e-e287-4e50-5e2e-08dc8c9d90ba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8362

On Fri, Jun 14, 2024 at 10:21:55PM +0800, Zong Li wrote:
> From: Robin Murphy <robin.murphy@arm.com>
> 
> Currently, iommu-dma is the only place outside of IOMMUFD and drivers
> which might need to be aware of the stage 2 domain encapsulated within
> a nested domain. This would be in the legacy-VFIO-style case where we're
> using host-managed MSIs with an identity mapping at stage 1, where it is
> the underlying stage 2 domain which owns an MSI cookie and holds the
> corresponding dynamic mappings. Hook up the new op to resolve what we
> need from a nested domain.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

I think there should be your Signed-off line at the end since you
act as a submitter :)

Thanks
Nicolin
