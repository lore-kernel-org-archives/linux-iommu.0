Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168446F067
	for <iommu@lists.linux.dev>; Fri, 28 Jun 2024 21:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719610212; cv=fail; b=JQzM12RL08lG3TrxegYelGn2lcONB4a48pbG/d/kDWIbODIxR7WyIQK7QI4koQTzAT9EzqDOuF0m+zr3/3OjJ6G0jb1vtbb0EwJH6nQSra5MCiIk/QB7vUxwcBAoJWFd/aoKnROs7n812w2W15Hl8cKFPGbAuvjPjdC9661v+sE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719610212; c=relaxed/simple;
	bh=9WrvZFdJsE1zRsMJerhoGRjuj4fDVWmSVEF24AQM8Q8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+tYTJRGWnu+20W0boMEm9atZroCjK4xCLRmg8iWm3fh7N6yh8XDmEIh+x0uETXA5bZGVTIlJ8I1BWHNbHisuz0IVE+JFqqrU26KACdWcsZ/5AWjPGg7ldUzBAHXsXYiLaq12CoTAkTvqTaXGzOqKpEuiKuyIZt72OGfkeZ1OsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OuhSqM7I; arc=fail smtp.client-ip=40.107.237.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OuhSqM7I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmIObKThfeOb3NkPS7fwKEuJTLiWex58kIWbjbZpRsqRI5/mr2QDIPj6VekTc44pEuqRg8qSz/q7DpzBLOtJFVt/Pi8eJLOMLRziBSgUCioPHsNlrUGSYFI9S4+77tp2QcfFWJp/lvhVQt5sIvKeeqeIxVZc34djNNzKtO6HeSeYzHKyLd7hJrX49X8yIxocLAS5ujnRKXTYVh0IQmlGhCOsB/LM24mXDbYXmxEuX5sB1ktzaurszLWkP/y6psuazvopQ4Z+PCXr+mTH05PHNjJ06qDUNztIAfeteAtpzJfjc4Bx1R4IKSckn/UNDzZ7Zxczc+kOpWX7yAbmw7JXVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/Tvdn0oswTUCEQeZHUsGnaHtivCYsM7Spn/Wpd/Gio=;
 b=hdc75+boFHxTDF5tH0jXGsLrgPw1uHy1eh7ftbqfnh+TjgAFESbE+3gCzWPHBbuBp5HH88Y5rfqu1dVX79dOh56s9vFZsRiK1D1B0MrR2xb5yJ7PnMpDrIDcAtE/5LSeg6Ihw3eo1PWLNXmNrW533o1kiltnQW8owGkt3FjKBozHcvCPqsGz3a+RvnV+WqMZQFXqv2c3FIXRsT0YlojLle8htb6Pt0DQyjIjM/HlxKSCfzycJ+qvdKIeEXneqsPiSuCJZdn+L1IA6/CeNrlZW1ZDViF9XCC553L3mGzB/XA2Iw1nRrWX3kvKWNjm5meupA+yX14JZba9k0Bl6wFU1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=ucw.cz smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/Tvdn0oswTUCEQeZHUsGnaHtivCYsM7Spn/Wpd/Gio=;
 b=OuhSqM7IKpk1fMrt/2CtmyFT1Th/oiEW7YCDg6RuTxTU8arVXc/0uKSsHcvioC4KW4QND/qlQ2l6b34BX4QjEqsnsJCqc1XUdPXf9AN5+rWoUm8iKR3WWQ9zS7jMXcvj31WpygTp+pV+K0be1Lhi44XXtB1k3zgqM9Fm1TY9UJMTscGi07BHWStD0oea2vQbX0kb9eWTGJiTHy70CFp4xs3biPLTmtkTQBwEPkCts1W3gKWx9dmeecPHGg7Srh4Ow3DRp2upcWW6RxBcDoRK5QzXRkQwrLxQP5E7Wq7nrScsI6Y1S4dyTXe4DW8SN52RMSEoVlI98Kd53QqHtv2hrQ==
Received: from BN8PR03CA0016.namprd03.prod.outlook.com (2603:10b6:408:94::29)
 by SA1PR12MB7245.namprd12.prod.outlook.com (2603:10b6:806:2bf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 28 Jun
 2024 21:30:07 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:94:cafe::49) by BN8PR03CA0016.outlook.office365.com
 (2603:10b6:408:94::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28 via Frontend
 Transport; Fri, 28 Jun 2024 21:30:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Fri, 28 Jun 2024 21:30:05 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 28 Jun
 2024 14:29:50 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 28 Jun
 2024 14:29:49 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 28 Jun 2024 14:29:48 -0700
Date: Fri, 28 Jun 2024 14:29:47 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pavel Machek <pavel@ucw.cz>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <thierry.reding@gmail.com>, <vdumpa@nvidia.com>,
	<jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v9 0/6] Add Tegra241 (Grace) CMDQV Support (part 1/2)
Message-ID: <Zn8rSzCVoVBYTf8R@Asurada-Nvidia>
References: <cover.1718228494.git.nicolinc@nvidia.com>
 <ZnXBrhcaiHqV9sn2@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZnXBrhcaiHqV9sn2@duo.ucw.cz>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|SA1PR12MB7245:EE_
X-MS-Office365-Filtering-Correlation-Id: fb21e57a-48a9-44f7-64c2-08dc97b97a68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C7Bh2XsDgynxbBlo6X2kBu9UfwCSMl9V2Wyl9VOeN7t7cOq+1g5DRLMfRUXG?=
 =?us-ascii?Q?zJ5Jm53yiPrGC5HXCdmPrBPiZZhEnAbqE2Bzosq7WvdS0L7hHUzNh/DGX/oY?=
 =?us-ascii?Q?tqE20K5of5NvBY64cX7u8522koug0/hTBb272KyiUYeyCgmvai27AVXhBmQS?=
 =?us-ascii?Q?0Kbda4M73tq6UckhIjfAMrZNvS5UmlaeChIw3OU7pvJ+mSu3tQuKC1cZuK5P?=
 =?us-ascii?Q?J7pMH7E4DnTTrw37wYwncMdID60cYOa80YBfVFCP3xdfT5HZ+Pxy2CKU9Wq7?=
 =?us-ascii?Q?GizEBstoZc/iJTZVMVdVSHQT5cwdQS+a0QLrwL/Bv3ByyC53KbhvjAIbFgt9?=
 =?us-ascii?Q?7Kzjqq3/SsLQX/t8TltbUE3QFs1ih0TtB+PHBhsBlHgNzlVufnR1qKSc6K17?=
 =?us-ascii?Q?6/urTQX7hNlz0QT2iaAb3UxKvdW2LkvyC4exHLxvwwr6Eocu78DIlSnb7O4F?=
 =?us-ascii?Q?PXRZHqicRMnBqSSQ4EuONeE0EoPuq88NOwzvrMpvQLRUJY9p2elbibjzFJDn?=
 =?us-ascii?Q?OLQItsuxt5BJl6Uzj4TL1al8dzerUP0dBl4tyGM4grzLDDr4wdNoKNbDOjPN?=
 =?us-ascii?Q?IrE4gVzoMhAjRw7ezR/zXaxZUE0VMqlxPRETQOhGJy+RacYE6HBYfl2d0VpL?=
 =?us-ascii?Q?8GbgWoKiPoAlbVvaiTXIbcScI2BKlEYC0QxEqV+pCvJ7QDXiWPM0jnn24ckC?=
 =?us-ascii?Q?lZtEoqvark3QpBpw+Dz8aqIYl2KD8ieSjz+jPnjXwCt6dVVgjXHHcSR+0cCP?=
 =?us-ascii?Q?JTgNCnQgxO3SpaC60dzxkctmHR96psDR17Sdf2zVe/2SWjVeu1VLj5dy1KV4?=
 =?us-ascii?Q?MQiLFoICgqf0CD/s/ylxDWPi68SuW92QeA6pRLGwufC+rxhYwhkglChMdlHc?=
 =?us-ascii?Q?DaYt11faGCS0KjFyZYk4SvcAbOsOWMG8pf/7ccCGWpQx8cEiYsndP+CL4WZR?=
 =?us-ascii?Q?uXh2+qFdAxc6iVbpQA6atCH6/ZSG29pXUjBf1UoHUCzTVxCm2TgjgvLOIfRJ?=
 =?us-ascii?Q?Dcirat+PZWGjIxsdG3pFPDV/W4j671DhuHTgpGfPvM1NWA03Fn5eMgc4FRtM?=
 =?us-ascii?Q?Ac6k4I+az1l4f9aWd0hxCg2xONEnVntexN9bk/IHOn1S6hkh1KvzXyZooUh3?=
 =?us-ascii?Q?axK1XURNnlaSzWzffcjR7064J3Snes+YwqvcbvkEsxFcqo7hx4gh6CQZ/xAr?=
 =?us-ascii?Q?zHuJwcL40swsiH+XY6xor386UMc+P1kyGrjKhfGmFgELu+X74AyEe3WcGAqk?=
 =?us-ascii?Q?TILzT3ZGZIIqSqBzLQOLghG97ANIIi76Hd3u64d0TW7ETwp+VbGm89fP0vCG?=
 =?us-ascii?Q?F5BtbUYc4Lh0AQg30Wk9ZNcgvDUlyDOpIbjt8EoAfampAQoNclihZiWqYZmx?=
 =?us-ascii?Q?emszyq61PnnJDPk171p9PD20Cs7rN2ZERh4kqS4ioPzpAVhSglK/FphtdxOn?=
 =?us-ascii?Q?jgU41ZF16u3LofTomAUi7Y8OPztr7nSF?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 21:30:05.6298
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb21e57a-48a9-44f7-64c2-08dc97b97a68
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7245

On Fri, Jun 28, 2024 at 09:26:00PM +0200, Pavel Machek wrote:
> Hi!
> 
> > NVIDIA's Tegra241 (Grace) SoC has a CMDQ-Virtualization (CMDQV) hardware
> > that extends standard ARM SMMUv3 to support multiple command queues with
> > virtualization capabilities. Though this is similar to the ECMDQ in SMMU
> > v3.3, CMDQV provides additional Virtual Interfaces (VINTFs) allowing VMs
> > to have their own VINTFs and Virtual Command Queues (VCMDQs). The VCMDQs
> > can only execute a limited set of commands, mainly invalidation commands
> > when exclusively used by the VMs, compared to the standard SMMUv3 CMDQ.
> 
> Text is block-aligned without duplicated spaces. How did you do
> that...?

By OCD? Nothing fancy :)

Thanks
Nicolin
