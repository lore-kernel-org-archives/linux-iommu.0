Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97D92D60C
	for <iommu@lists.linux.dev>; Sat, 19 Oct 2024 01:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729302382; cv=fail; b=dqlRFFw9re8R6xx/Pkt0IMSQer+00EHtRXQ5H/Mb2BsnvyozY4WsxEUddRtgFZWCKqzwOCeazj675fH848NTgsICg43I+PDaEvqDAiUKQZA2M7TYUVTIRcTlQHqbG/qiKvUr0M/dS0ir39UN9XLxsLKPSUEzayOXIwGINh28u/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729302382; c=relaxed/simple;
	bh=2e5QEjs1rWXYPULVhEZoO+qKsvhzpQ7KvWfnmQe+//A=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMwCxZAuGqcrR+YkZFiu3iueeKMDv38FWpYT6CPjUO8xdBv7/Bg8dagVatCV+2QlATvs0fRUAEuiCE+Cq0pruOea5QIzZbtdfrDxycJG9ussAn2jzC8/zibD9OJnCCPKrYBTvLB3fcFJzvn73HB/XM0NK5GPRmZdMDK0U/axDjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xvon+vsE; arc=fail smtp.client-ip=40.107.223.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xvon+vsE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iikYpkHOhg99DuQ3jX2myMllw3m54BRE5q/FE7nLl5Rh5dPyRnKxGNE/kvdmuTBn8MR3iLRLc7x861qJQD55vI4xvkzLiU4jNJzC+Q41VuKozhs3hxcRhhRPSqCPkgCUixHO7+CVDmcH9Z+iSHktPrT//96pBAw9v12ar2+qTMKnAop5pufdB/Admy09i+diFtJrVRp0ZpCx7cvcbp0ccaxpXOodWd837cYwR7dqnJSy0EIsQYOeyD4sKomwFt2wcV3FqVc6IYO60TYtZOKP8H3HnGt6f8QBrRkp3HFO0H9XVbbDfvOUa+T9DyzoL9w2q5cp61IrYDApcxlBenthvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMG1a4qDh4tjXPG9ST0SOXmnVXUzRDIGujQgkrMY4Hc=;
 b=gESCTOwY7yHV5CSQ0wmtJfxS24JdhM41WDCK8BEq3F8HwxYIRNFzasDU7wXPhvzbwQxvi/OSgvQZFZKLMnpG7q6ytZEx3g6LUy7Kd8f8uKZ0cIQ08IiHF1qcdZ35BDEpy5z7nXSWtoC54u5OTCcuRCrGLJnP8NsSq3orkZVArdF4ApKoQ5p+TAky/K+iKx00E6nwHMQtR08UMo32J0SMC93C6Z65HEoCQCyE0/wZIhrnWhAeQPu0q4e9Jw10hS7VJxMqY9b2ra4G5WovlueNmh53o5K0Wm5EIwFZgc+e6tlTzzRWFNHQpFjmpLmAAJ28Xa6uD+ep4mEL/tfOnEFIng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMG1a4qDh4tjXPG9ST0SOXmnVXUzRDIGujQgkrMY4Hc=;
 b=Xvon+vsEG1ymerZ86TEXnGUVZEDV4AzYSw0LpzD2pJ7nopN7o2g/oCxaFWM8EVDrMtRTI7XxicX8dzDHMh54Q8My24sTYnp8XrlAlLr2o2xf35EoZCVYuQK/g54hvuhUy14uqCUtjn1lvUqFtb1i7a+6RsQchnr9uKp6stW5zkAQaqe/nn4D/3R1SzTMLym+yvcK62X+Uk9AVZWQVaeTH/sIGyh2/rvcNfi/ZJ7FcSBvGEcmTGY8CNuSD5os8xAWDV4Zed579zfvHtCEqb5WMJdjTwTia+LHYZuknelPpi1QLdcuWP/RQJ0xci0XvwmKlSltw9xpfbnZcPx0fyR1QA==
Received: from BL0PR02CA0016.namprd02.prod.outlook.com (2603:10b6:207:3c::29)
 by MW5PR12MB5600.namprd12.prod.outlook.com (2603:10b6:303:195::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Sat, 19 Oct
 2024 01:46:14 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:207:3c:cafe::96) by BL0PR02CA0016.outlook.office365.com
 (2603:10b6:207:3c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23 via Frontend
 Transport; Sat, 19 Oct 2024 01:46:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Sat, 19 Oct 2024 01:46:13 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 18 Oct
 2024 18:46:00 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 18 Oct
 2024 18:45:59 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 18 Oct 2024 18:45:58 -0700
Date: Fri, 18 Oct 2024 18:45:57 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Mostafa Saleh <smostafa@google.com>,
	<iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 0/3] iommu/arm-smmu-v3: Parse out event records
Message-ID: <ZxMPVdRQzt//LBqG@Asurada-Nvidia>
References: <20241018180022.807928-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241018180022.807928-1-praan@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|MW5PR12MB5600:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f5a5c4c-03d3-406b-0e81-08dcefdfd085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qppaimiKjf7FYBVeBgGRxRrR8dMgkbtlOoLHQ/Jhuo2L8wxs1t1A3FPYkQ/z?=
 =?us-ascii?Q?QhyQnW3Ra96ANzVPGxV+mmGbfLa41OkIEjgbj7I34vxNsQ1uoNwZAzATr9gz?=
 =?us-ascii?Q?IwXrRIus2ZbRWpy9Pdok9aOHub8Rgrf9EsWW9kGo6gI7stIs25Er4z5iI1Qj?=
 =?us-ascii?Q?RRfc730Hx1BSjTqV9n2UWU8JCbIS4sKU04FZnh2Yf4Uldy1ypmxlzXKpvNg5?=
 =?us-ascii?Q?pplBKjwuFYlIk0akYLEvTbVihqUtuRnw6OE1kkNzamAgrX55FSdJ9bgrCiZM?=
 =?us-ascii?Q?QraHgiwpO5w7qz2uxvzciT/np88fJh1BUgexq/98GKfoK9KTfFbkOcvgMU73?=
 =?us-ascii?Q?ObG2yo+VH39ingnQAiRUCXZ6W/Tpmk/66M7+Sa476tAE6A2mtQrqslZMUBc7?=
 =?us-ascii?Q?Lyc+pIzl2kZhZ51P0QKUT5AUqr5fA4//O+b3GQ1ItyRcBWH2uyAh8pQqSCbH?=
 =?us-ascii?Q?hKnuSn5FLK9O0qO4uNSI0mvu7Asq/kcUj3ie+W8BQ8/2O2/K+WEhXlzsuyOj?=
 =?us-ascii?Q?mByTxK5+5WH7PnZUgcvhqBfRG7NQqoxZunbVTjwpfBOWbW7NxofXaSFQJGxk?=
 =?us-ascii?Q?tYydTqEGFvEutVCztBKCe9jQVIXCU6D72xHJP2f3lCNUc2MwFZ9zscTMowZR?=
 =?us-ascii?Q?L97OLx9C7r5PBGYHGkXP+Gp0//BfaglC2HhnWal3xLdmej9nXkHXAMnsf1TM?=
 =?us-ascii?Q?I1+Zzjxo2FGoGsPxRvNOAoaKkFTsn71hjvs+7gCy/B31iJIi7W8nLqk/iYMv?=
 =?us-ascii?Q?B/yfECTfbIL5TI/VhM5GDYL6CnIPTSgUl0A1H90hBqcWyMsUNeA60N9MqAJG?=
 =?us-ascii?Q?6ykAboO5HsncadAaEHkJl0em+uPkbtJVOKcKqF7llZfKnpRXsfb2HFhzK71r?=
 =?us-ascii?Q?/0G/S2CdTOlOjiClxgAZX2q7mvqTaZvpxo3f1cS332eWavUyYtZ1sHKVWTxC?=
 =?us-ascii?Q?u/aYumnNNV9FTP9x5OUxj5O5Ed5NNSkGajj4ZIwT+tTB4MUa0FdaKrXHkzOv?=
 =?us-ascii?Q?NjILYSL3v5gOr7Duuyi3/JbnJectv8EoBJMa5uxxODC5TAppNWnNlWMh+TJA?=
 =?us-ascii?Q?WJuQg94v8W3vsFKbqE0sh7NRRMLGxqovu3F2GktRMLAHfHnNsQOpGPYss5+q?=
 =?us-ascii?Q?rzQ1lBIBnSIghLLeFxxFGIIAQHxwzhoXeuUN/O93oxAeOqVZ9vbe5C/sEaya?=
 =?us-ascii?Q?uXDE2QwptKvOEjtzX7pxzY9Rll4+7PBt3KImB+6eEo5nrDq0cuhB1x1fXiAD?=
 =?us-ascii?Q?uVI3fnFbpMOQgHE62lJJ9NLLuLt7ZhXzWHF0C7V7F/choxv1HjgVby74bBdr?=
 =?us-ascii?Q?IegQhf6P+aY/4fTT2iVBbmF8MUVyrE1ex9wUh7aw84ONo75+4tYBaCVs5JCp?=
 =?us-ascii?Q?NEPF0KeQKV3d4iKGwXbkwklULTmZSmmHt1hn8ZF9Xs9cZ55EPg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2024 01:46:13.3019
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f5a5c4c-03d3-406b-0e81-08dcefdfd085
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5600

On Fri, Oct 18, 2024 at 06:00:19PM +0000, Pranjal Shrivastava wrote:
 
> As requested by Nicolin, some sample logs powered by QEMU:
> 
> [   85.410290] arm-smmu-v3 arm-smmu-v3.0.auto: Unexpected event received: F_PERMISSION
> [   85.410290]  master: 0000:00:01.0 sid: 0x00000008.0x00000

Thanks!

Should we print "sid.ssid:" v.s. "sid:"?

Nicolin
