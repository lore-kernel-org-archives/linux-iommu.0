Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0D01C1F20
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 19:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740770011; cv=fail; b=nClGXLQFOI3cgZE+tByW3Tji3YDmMrwRbseB9J4ursh6n/PjImkevYVbAODMBD2CEVTamcz3SyB1XXmv4rowrLtiBTgM1bBFMpSxtxanJ8xZ06/7QFvhYoQ5YK85IgCXtqWjP+Ac9gzJDBam0t9NsaG8F11JV3BkDIxcuwuWGac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740770011; c=relaxed/simple;
	bh=Us0Um4+UZZRUeSnToVryC7lWh6BjwcwIex2YNfjdCbU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=igFfds08k/eGZ2/ElsLSaxiPlAvNtQuKhhndOvAdoMrYh/gUg3AwT6vx8FgkjFokkblbXGgIpKqKpATraKdgRubN3MiJgWJvLRzKCRXgiyFi0r+Gv/OY/Wa6iOOFwUtsV3dpqfVD/ejz0BLaDkbi4neNrjhFH06TYpfRSw59z3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s/c6M6EJ; arc=fail smtp.client-ip=40.107.223.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s/c6M6EJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O8hVKcJegnThFnTY8vmFQrHN/SCvIIn0bexxMZpo/OsXnn0jEJuHqr0wwe/Xc6XakLO/TBNdh3JMv9PJ2MOV1YbG7YmmylSQpv3BR1msZj1JKlm0ioWJ+ikXyQXJTHj2e12WlS6LC3OipxTec7jFFScHL2e792HzMJW4Gf4tzAJlZ5UTW+agfQ2TAB0ZYsowJA53+vz/4b91rSYQeGCn7RzOUkbl7/4SQj75oDeVtlb4yVu0ekDu6DBdfBisFeoO+IziIow2Y7OL2aoubvvmB1k3Sw56kcjT1B//wZCA/TpcH41/pDmiBVluYmGEAOVCACpYwYYnTFEN3lW1GmXWIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WwjvfbT27kIlqFunIY9cR4lnQs5WqS6gfIY34p4+Uts=;
 b=flOvTLkBSBcLRdb0ZYiV2YGWy5UAHiR0m/UeDPyl40TL7eH0/IJ7Vflc0DopfGw8AI/FKfcvhasghQvDvwMBraHGTgZEFHWX8bSBCwytyaeAh0hmKxu94sj03xDwB+rUX3qY10tm0p3cHs2philNa7lMtzgo/WRRepC/pczh7DFkq0Qu3VbUgTu7ERWaZvr7++LyK7/oSCtqz1rBfMZS1cuTuvcvO2bwZU/yxFfeIAIL148s/SINttqkFzlZaGZSc6BeIFqVhP7rFA0uxSdFHc03qm4yoU3XcBYCRjIzuRAyhJGeR/tW2DoX8p3rDYZyW+cuewra69FPif9duTsd0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwjvfbT27kIlqFunIY9cR4lnQs5WqS6gfIY34p4+Uts=;
 b=s/c6M6EJirEEiWXHITKs002VEmBHdX8iSzbqdsuQI7fmqi1o7d/Qz/XWxXWzW1a7ObFlWbTxUbIvdkd86tzUqBvO5UZSzpwiJDNURc9iyUyyxH6j3ozr2/qk4ioZ9+2dt/LvYOn16i1iveD5vafSntdKCqN1dagZZ+uAfQlljYqZdAx27K/7mjAPSvaCh6TrOH04ut8DQaVhI4pLouxhwqx51oo8oRcyzGx/j4aDqV+nuUYTmdPmbmqNaddhswVzQSB7nnL0dpQ79D20NJ/EcO66z/VMRnGbf43YOZ5Ms6iELwALvbC/rCgZ90XRd6H7Q9RgNj86AG4znS1DyKa9XQ==
Received: from CH0PR04CA0072.namprd04.prod.outlook.com (2603:10b6:610:74::17)
 by MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.24; Fri, 28 Feb
 2025 19:13:26 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::3d) by CH0PR04CA0072.outlook.office365.com
 (2603:10b6:610:74::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.21 via Frontend Transport; Fri,
 28 Feb 2025 19:13:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 19:13:26 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 28 Feb
 2025 11:13:10 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 28 Feb
 2025 11:13:10 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 28 Feb 2025 11:13:10 -0800
Date: Fri, 28 Feb 2025 11:13:08 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Joerg Roedel <joro@8bytes.org>, <iommu@lists.linux.dev>, Kevin Tian
	<kevin.tian@intel.com>
Subject: Re: [GIT PULL] Please pull IOMMUFD shared branch
Message-ID: <Z8IKxIoJMoctougb@Asurada-Nvidia>
References: <20250228142933.GA105053@nvidia.com>
 <Z8H7MwT2Aln4ODxG@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z8H7MwT2Aln4ODxG@Asurada-Nvidia>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|MN2PR12MB4333:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ee1d3e2-c09e-4c56-a5e9-08dd582bfa78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3AVduewS8PolazLIVoCNjt4pJd/PURMIRQxoaQ/bUXixvmHdAn6jZMsfnTO6?=
 =?us-ascii?Q?pmvQEv7WNF0sJw65yS+Wae3KDRs3VUViJ4xA2GhLY5m7ABvapySXF2muvKKm?=
 =?us-ascii?Q?sJrI674YiaZJMCYzCH6Mq9n+IlowW3CNDrlj89u5Xfvaul1St6zw//81yQCC?=
 =?us-ascii?Q?Pwgj7XqLRYjW3Ed3q6qwFh7mDO7oUO0V9lhOaImq3S1J7SM3aJMs+qJj4/Cm?=
 =?us-ascii?Q?qucaESqqmy/pbxmFBf1CC+X5pMW88QKDzTRDKU5FHKdEJNpDHdg88uiFd1hS?=
 =?us-ascii?Q?/ZUzYAbv2nFt877EVp/X7/rNvJ7UEYjPkDQSJs+WFWNHZhJWT5D7OMacq7wB?=
 =?us-ascii?Q?j0yRN6FKu1yf/g1B8VPNoJSLNrX/HTjnng+4LYzmD2ggpWBHNNltIENumzU8?=
 =?us-ascii?Q?BaKEjlXdn1uhlRKrXyIxzOeRz6Zcc8L2Lu5D+ZqtFMK6MPdFvPgjuxJlnKNI?=
 =?us-ascii?Q?Vvg1vLMMS14cr94Ig2fxVe570uhQtj6aoqy44gBgxiN34IzAHUsT4mf/07J+?=
 =?us-ascii?Q?HxdV2bDRKmhFBkSu6sANKQUS75bKKuJ9mOfNtRDqv5S7ndgwZUHkc1uCpOzF?=
 =?us-ascii?Q?u/uBAP4D9byTvwVsgnrv7z/VitHCQsJyK9gh4km57eMl348ef431j6E8ISg9?=
 =?us-ascii?Q?y6XUurgIrEgni7bbIw7AvrhAT0wib3AJM58H+mPUmYuughknG+Jq6HCec661?=
 =?us-ascii?Q?NUdNhPDbw2fgcndFC3PDNVbOq/wR6Yxv11Wb9S+UjVZcYY5FJ0pzG7zaoSib?=
 =?us-ascii?Q?KaM+vDAV58phtbYqZLeZ/nTwo7Y6XjB2tQHQkWjrd8mnfjQ4FJrLZWR1JhNe?=
 =?us-ascii?Q?zlQR4POGkKkwR7CbHuj1Y5uMlfaqiFOI6IbZgizELKRfe9OTcYVoN+Do+sTA?=
 =?us-ascii?Q?4bDpuwTjTd9XJnqOK4VVChArunVbz8TuH3tTtwD3oPVALPTu9AqT7LASWsSo?=
 =?us-ascii?Q?FNY3qxl41bq85X7qb/oID3OF+yqxJiKPVFEXVwm/Nhys8vb4hbIyLmGZvL4q?=
 =?us-ascii?Q?DRKyl1kuwQmbjUMzJ1EtHBH2jCgse4jpZn3IPEZNI1bD15Mf3dH5P/yzGnX8?=
 =?us-ascii?Q?FNF1y16a03XGXvlyc1tiCGC65EUbzWZxO/FlApXCNUyq97HeQE3g5mXkIW+h?=
 =?us-ascii?Q?6n2d37qjp7qF6ZRDifrE/jCt9JpOpimMlDjxu5sCZgAdARrbddKSKcFRn+Nx?=
 =?us-ascii?Q?VAzmgR0BGGO93uMKbsfXd/3TCH0XYLdYHd+frIgonZJde9JA8lV1em0GS2ld?=
 =?us-ascii?Q?m6EUvMVeM9JR6SvsTsPTaattsTPpuCnV3Tv5Tves3XI+suEzPBszW2st4RaD?=
 =?us-ascii?Q?wIOHmRo6SmQXNQyQqky3Ps/yYUPdQi3FLQEU/EFuNmbGi9YGpaeVwiRCfgug?=
 =?us-ascii?Q?A9hjkDKULXO0CwEV1D29Mgu03Ey4m3mmBppacl8x/kGjmMGxii5H9hFA8ZPj?=
 =?us-ascii?Q?yeOMmbX43e8xzat2KRSol6/YOtG8RAlXxZS9VfKLbVVmr0GaZZ9igsjnNqDb?=
 =?us-ascii?Q?Q3itu3eTd+TssEY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 19:13:26.3964
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ee1d3e2-c09e-4c56-a5e9-08dd582bfa78
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4333

On Fri, Feb 28, 2025 at 10:06:44AM -0800, Nicolin Chen wrote:
> On Fri, Feb 28, 2025 at 10:29:33AM -0400, Jason Gunthorpe wrote:
> > The following changes since commit a64dcfb451e254085a7daee5fe51bf22959d52d3:
> > 
> >   Linux 6.14-rc2 (2025-02-09 12:45:03 -0800)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git tags/for-joerg
> > 
> > for you to fetch changes up to 5e9f822c9c683ae884fa5e71df41d1647b2876c6:
> 
> I see the tag "for-joerg" is pointing to a different commit that
> is on v6.1-rc3. Should it be "for-next" instead?

Oh, please ignore this. It turned out that the tags in my git
repo wasn't updated successfully.

Thanks
Nicolin
