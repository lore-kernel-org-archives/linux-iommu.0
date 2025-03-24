Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45BF1E1C2B
	for <iommu@lists.linux.dev>; Mon, 24 Mar 2025 22:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742853981; cv=fail; b=W7DBsYd1UECrba9DFgKMXn8ttTrAMBzuRnxVAsChVfq+yqFtzYO/G+iKdBqhvA5El4C/NHIYODXAayepkyPgebvPonH17H+gBY/UfxkSi82ghn3oTSaCfCwc5RY1kcHGvngsX98F5GUaAK7+pWA51/Mp1TI0tnWgRqYQ+OwVXuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742853981; c=relaxed/simple;
	bh=Ag3xFBr5sklEqKWYuE69paBu+UdTuBU05YxjNfrzbvg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vp5F2Q0qQx6r8l9MIwalPyd8VtFoGjFiTaqgpeDTeoNdHnc+wLeMBkzbj16atK1gRBG+oRTk0fsnBQxUk1b58NHXjAowedW5eDX43DrgyuUbRDD6TR2zrwxxvYfNk6yr2Z1XExB4/Hut/hSzjN+LCEERAJalmA+yrOoLuUxvoT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RD8EvEgm; arc=fail smtp.client-ip=40.107.92.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RD8EvEgm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CckvnVlMG7d0JGSQaNWc18+TQ/2tT7WH3S1WyIig0sgHUhuxpTNVcA/Mi/f+cAGTJPuWUEudXzB+WmYRC/QgHMTbYJgHSO1OS71k7to3PiN6GOZ4T1OT7mkeiNveXTt3+ou0yz3m1KKpBNcwa6/n7+2SqnLUfWqxejytqN9mCyx0HoYZT/xoWbtyCHE6I5rc1uSk8hdpCanCxqZ4b7fN5AUucsyJ13HN2qFYLnPZEWiMbiXDr0TPJJKHrRKe4I7sqENTR/hK4EOCJBCVF8LsyRfgyjlB+QiLa9XI3du+XU++pkwJdIzOC/XNDf9f+Y8BCiZ/ffTKhOD0EexQHKLEng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3J0feagq3sOEAsjmGyb73m9SraIJCgPLjnTnIHtmWA=;
 b=ImUPGfzGvHHVODbAXvzOadBuz7aMStHgNOQ/qnmZwLV8DBbfddLZK4sO2EquORjAgsvFipTK3710oF+2khSXQsDwJsy6DgMzCBdxWPtNprNetqUSGv2vSpD7eKoNgK6Pw1dQY4EWRAvVl3Hvt4SngSkzrm7eaNttxPp5v/JgGI1NNcr9RbWlkRXsjeoGuxcSUAMUYup8AnM6jENFYrRUAOATizU2T+Dt0e+x+oYt3gdNuJJdSOTBz8h63Hcs80iR6dFPlwcl9yeIBtiN8bL2ZH8+xRp3lfkiSUO56GZzbKg+AAu5913DggrA73+5KkfXAXR8CennUc7zuEzGbUc0zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3J0feagq3sOEAsjmGyb73m9SraIJCgPLjnTnIHtmWA=;
 b=RD8EvEgm8naLFLoikzK1ca1bkjxfoO6VAeXqu0mx6P4F7oGp7C7mTC62oYFF+W8nyljX/MqnDYe74YI/JdVeGNag6MX3wp+QAb+a4U1CRpp6S1QW8Xi8eIPfR4BFs8m9d3Fpcbg2Z3huKDKI/aVtWMEwBSsB6w8WglCcZwrGm/fgiVsPTiH55/uq4/AvIDiTxLRRYJcB/n3rI+8Y2+wqaafQtqlrgP6sVw/1q8kipAzhv8vtiObDRpLtyoOohrYSNIMNBokZKEwmXBfsiY6r58t9VeTO9TzfktDmXMpsJYb12ZNItvOHrubuv2vgdJxXreDopGy2drIoPTUna114ZQ==
Received: from SJ0PR03CA0354.namprd03.prod.outlook.com (2603:10b6:a03:39c::29)
 by LV2PR12MB5967.namprd12.prod.outlook.com (2603:10b6:408:170::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 22:06:15 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::9) by SJ0PR03CA0354.outlook.office365.com
 (2603:10b6:a03:39c::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Mon,
 24 Mar 2025 22:06:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 22:06:15 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Mar
 2025 15:06:04 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 24 Mar
 2025 15:06:03 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 24 Mar 2025 15:05:55 -0700
Date: Mon, 24 Mar 2025 15:05:48 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Arnd Bergmann <arnd@kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, "Joerg
 Roedel" <joro@8bytes.org>, Will Deacon <will@kernel.org>, Arnd Bergmann
	<arnd@arndb.de>, Robin Murphy <robin.murphy@arm.com>, Lu Baolu
	<baolu.lu@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] iommufd: import IOMMUFD_INTERNAL namespace
Message-ID: <Z+HXPDuw+x7CK6a9@nvidia.com>
References: <20250324210329.2809869-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250324210329.2809869-1-arnd@kernel.org>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|LV2PR12MB5967:EE_
X-MS-Office365-Filtering-Correlation-Id: fbc063e2-fc60-466b-df32-08dd6b2018c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5CzPZHKDRTDkkXqAfbww8ouG6y04kbFwotmV5kkKpFVOmfsTlDxFwSsHp/YK?=
 =?us-ascii?Q?nkB6dBJP9iL4ws/j0ke7+3Cu+aEm3Tb9H7fdD5NGj59EgmnpYnTHNzc8cKZM?=
 =?us-ascii?Q?r2pcJgNARIH2sK2Gwcj8B3wXHfs8b6p6NNr1HW+0TjSFnhs4+uooCbs/ZmVB?=
 =?us-ascii?Q?paDiTpV31B0fNIIl367pXYgRcfjQM3QVT7C8cugEXFdMEyCpTubikTO7th7f?=
 =?us-ascii?Q?eLQPZglDh9irxSZmevZsZXMAI3ERhNNWlV3GdMsg+N7QXkngUqD+3L9d6Chm?=
 =?us-ascii?Q?Eh5v3aVjuvZsh3FNBfKgMX/Xwx1qkWA8QiU23RIMA6oqX37PYSTbSQ7biWaH?=
 =?us-ascii?Q?UKG45HzGPsqqLBNdOuQUTqkfM7xFemCaX4uPDfybFlpbIBUUwymDXeRwczAL?=
 =?us-ascii?Q?qvEqe5mgKAGSSokYad7pWkzbE5F1T85G6eJg4Z08S++dZnzwsKQ+T4LFX1fU?=
 =?us-ascii?Q?z1g4EFFb59gf4dh05Kk58Lg7FZSlZHDfaYm5WlJjRjpOUbz15+su4KiALwWT?=
 =?us-ascii?Q?CpL7h/kqIRXTGe7WkBmlDfz1e3jXbdu8gJBovInZddgbXLXIxH+peKDX46Gy?=
 =?us-ascii?Q?2tkYHwmCY5sSXSQmbYXHfu6N+Y+j6V2rnOH0PgLCINosVAtNOkaLGppLEtba?=
 =?us-ascii?Q?PGuZNRe1AnKugvZEiHeEAfCRobVS8Cl8xcRxFtV3jw8lGFzP4UZLqj0lOoIl?=
 =?us-ascii?Q?PB/2UHaO/fblc+4Rd0C2PfoKiZDjHuShI/e67W3ZObbYwiT96lUAmVUCFSJ3?=
 =?us-ascii?Q?o1wrH6IOssP5IJ2XjJcupAJsUtJcb2UZ4RjGaetDUCjANsDuqzLgR126qah1?=
 =?us-ascii?Q?BG2UBXZfVfOoFXHZWUJ1IJnGHhbHURGoMRHz21X8UN6MOBBTIQahjUCSF2dj?=
 =?us-ascii?Q?1fG9rBH5ZRnN94Cd7Sr+JVRO5o02DtJCGHBs23ltpDxdLpEXSsZ8w9Hvy3Fg?=
 =?us-ascii?Q?QDpffZUV6ULvzeF+W51N5d1KaffTK2/Mpcx9ZpIyurnMOichJrsx/9uIcqbU?=
 =?us-ascii?Q?ueesr+XuBdv2vTAlV+mIlt9jxIJ7AjXZQkrztsm5wMsyFIC3dv5Ar/DP/Gi0?=
 =?us-ascii?Q?gesPTUe51V+MR3um0nY4MzJFmz9ChBGDmKRNWPzDUL5IsYkRllZORhJezwGP?=
 =?us-ascii?Q?b3gmU+CvfHxv+WRqoL6oKcNC7zyh1wHrqPhREH1NOMBEONrwK1dME18XDml7?=
 =?us-ascii?Q?f/jqulqd+WN+pcCDn0VNgWlV6WcwccJqFwXR72KHZh39+KDaWi6ozGD4OuSB?=
 =?us-ascii?Q?wdIUmXYKuB6xQGDbYH2e13m2xvduMQzPXiHAglolcak6G1oIuznd35Fhhn1/?=
 =?us-ascii?Q?+2Wpwk5kVHU42oVbbhCSEkCrDToyv5GQ6ERZFCQJmxorsK7el81kBbaYcW0L?=
 =?us-ascii?Q?92vuo36RQ8YRPPyFXcGRQ4paGtxpGsMmwI3ZSthbOxN8VKPxqDnyqWKNODEu?=
 =?us-ascii?Q?APEo3Vs6mKETngavDaUGdGi9oCj9SptcFfjW3yP/lIAdumQ4u0pksIxIPJJ6?=
 =?us-ascii?Q?w6dvLPi2AQEasky1UEJuEXJ/f4pRyRiBiAe+?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 22:06:15.4937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc063e2-fc60-466b-df32-08dd6b2018c3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5967

On Mon, Mar 24, 2025 at 10:03:22PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Building the iommufd driver as a loadable module causes a failure now:
> 
> ERROR: modpost: module iommufd_driver uses symbol iommu_attach_handle_get from namespace IOMMUFD_INTERNAL, but does not import it.
> 
> Import the namespace as needed here.
> 
> Fixes: 916a207692ce ("iommufd: Move iommufd_sw_msi and related functions to driver.c")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Tested-by: Nicolin Chen <nicolinc@nvidia.com>

Thanks!
