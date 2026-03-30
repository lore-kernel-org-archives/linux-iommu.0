Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012013.outbound.protection.outlook.com [40.93.195.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A90372B2C
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 09:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774863621; cv=fail; b=uu5Z9rxmXZxe8+ltTR1GTkfwhEVypqrgsAMimgoCMEXV8COB3ZtM++/8vgz4L9iuMdnaJ/nzpTIqGSk93CtX4FkGgzhJX7AXeq8sBL2LlwuOr1FC6OEKxRYSNvfN2fI0MTSvfq7b5p6RT156qYaRvJakKJSKjBeR+h7dwmNX3cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774863621; c=relaxed/simple;
	bh=ctVsiZ/Gw8HN5HrdjD5QOB7T431dRflCHMhSsiSHcjw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Npamc7yihX2dFLEe14g/iQAzSDpsgL765MYOiRGBrBhxJN+umnEjzZIvmsyU04ah0H9g82JTxgGz1MEjf8yDba+DCA7GF3xSsRx/LoU/rRyPaPa9WLTF2rwRcx1maRAp0ZBdMu1oVsGF6VlFrWhAscmOLdGBj2gLlNuqUmLQZxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gl2VAP5c; arc=fail smtp.client-ip=40.93.195.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gl2VAP5c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U58F8R2cX7y/5ksC9yFF7mxeT4G4SYrsnN0fI3BGvDcBs19u2LgGXBDZNc8bcTjQAafsrmiPEl1fjNKH37ZKW1Y6QsNt41vsoA1WIezEefEp3DtFXYfTZ4Pzd+8qUUyCaSnAf7WF/LNLfTkf7moWmADzKiCqoPVWI0fmrUu9kBL8h7GYfYKqawAgOVOq/KkJ/pPqrK2TTdbTLqN/dPkNJwGxDUPa+h+mlexQWrXXPnE+fxPu6WGeepPykEos5Ilb8p90ol7iVXI9YyRMXmRRy8XBC9MBZ9jLImHbDyou1A/Go9lf6XyXLVVkh9SW114PXd5K0KFi5IPiXFut6s4xeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgMdsIYo7DWY8uD40Z09zbkuaYyUahPIdT9ycjcCOJs=;
 b=vNksS7Ka/6+QUgYj8Ia7F9voq0elx1iE1+nrGmVU7I+WNrPlewby43yZ6Hn6Gi+S/smU6U0quZQ2LlHjMBBljIOwvXkR5hsVC2n/4Av1CMow5VHFDgYZtP0xEJW9FAfKp4A2hJjwuU0zDFQye8SoSpNsAiX4Qvv6JR0Tj4E8yHdmZ7MCH/0a6+7qQPm0UQGMhjuKtQQRao+doGgtIUeEaFAO2UQBSGUABW/6cjAZ8vIzrYbLCuLqVPg5y1Z6dtDlhqUoIIXiv0qhJLigaWNPLNjWjyr4tolW+3zvBpkpBCwFNZ0fbnWonKKtRL9pyZT89Kb1i/t54e4JF11mZ65IgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgMdsIYo7DWY8uD40Z09zbkuaYyUahPIdT9ycjcCOJs=;
 b=gl2VAP5ct9shpF5wlxDRcYAD3lqoijI4abmatDcGW9RglElg+hiS2/4BM2SapQ2ZbjObAQ6zyFQxvaiguY5/4hKas1hL8pCeqUdGoYGF2nzzzchNWb3zcLrfcyT4jL2eTawRNvLTVJTNZuaLZca3ESEhFt6z0uE85ws/Z1vrNLTVQyzJENl1tIvgn7Xf5oF0QMmQ3tp7d+ptHHKbY3Ne3iwKUQQ4IW4uxWkyedJNNgW1kMUT2u2bFwLr3FXFqvJiH+XuYroBt1LtZOv+QfYLsx9DPvAqJTj4Y2kfWTcGesWPLpZJIYSIMUlRMhTosEkrfxpDW3wubPrDpkVzjVeYzQ==
Received: from BY5PR13CA0004.namprd13.prod.outlook.com (2603:10b6:a03:180::17)
 by LV8PR12MB9081.namprd12.prod.outlook.com (2603:10b6:408:188::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 09:40:15 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::47) by BY5PR13CA0004.outlook.office365.com
 (2603:10b6:a03:180::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 09:40:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 09:40:14 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 02:40:03 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 02:40:02 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 30 Mar 2026 02:39:59 -0700
Date: Mon, 30 Mar 2026 02:39:57 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
CC: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>, <yi.l.liu@intel.com>,
	<kevin.tian@intel.com>, <vasant.hegde@amd.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>,
	<wvw@google.com>, <wnliu@google.com>, <dantuluris@google.com>,
	<chriscli@google.com>, <kpsingh@google.com>
Subject: Re: [PATCH 01/22] iommu/amd: Make amd_iommu_completion_wait()
 non-static
Message-ID: <acpE7YTrfV7KnUks@nvidia.com>
References: <20260330084206.9251-1-suravee.suthikulpanit@amd.com>
 <20260330084206.9251-2-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260330084206.9251-2-suravee.suthikulpanit@amd.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|LV8PR12MB9081:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b292af7-0572-4e2c-2414-08de8e405898
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|1800799024|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wANajItEj8JLtJVqsHmi7yiiGCvICk1HMGlqNRyct8BBd0xtmkfIlFdCFYttiJ6oN3kftlYRN0f4pEEP746dZrwCzpGSOnK+a1g8J912o9qLuaBfpIgkdq5302+OTLZ+M9zQqimivNFSBoHoH0DUV4Uh1RLrJtNfix6Cr/C3fgHyBsYIgHcA7mgPbpTPmMNe3XynANFAQZZAWA6FiNVrUygmIOSp7NxKVPgjf5lmPWFV5q7DTieKYa8w0YpdgCjm4DZ/4nP+L3lNrRoRhLgyaSGCOlQR2FtERneQtmFk7lPNgvnTU3lObynZmTCzlcMRCDo2LUT/2+5hdnKBRaqmUduYkQ+U3uHINxQ/VAxuTPvM90yj1rwLl8Rf3r3gkdUyd8McSPaYV8+NgqD/C2uXui0SYhsxpZvelMxfhgnH6j83YKcr4enUTQDLD48SwX1krjgWQ71wrffik/uwjRUv5KP/R72kbtvwE9a38krZu3mKwqXmVY430T4z/MW4jM7olV6tAQA/d0RghzWFlQ8q9ShF6nrdg3CvH44F+KNMHVd7ITM5bqrYyywly4CAcwDvlbMRNK3hhENgvBYtEkxechKEHCufwMmQJWGTwo6M3LDBTsRqiNPK+z8YEA1GRKDpKmvz5s6/B+r3RmzJCIqPEsdKi+Q3Hee5KZeEadjIWIFQ+PqgbsseQN2SSeDU9u4gRm11tS7+orEGf5MD/KdYCA3y1HXYrvg2q6QShhGuQRTKSW2jSUHZ0pksNNbZKoRNGrasW2IDTilEY+Lq+J/S7w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9d9tceSPZ1fJVwkdOmI4dS2UipNRl+jm8DuLrcmJpMyqpBZZxU3TVw1qmmEljMg6tFgULkw+Zs/JyOcf0mtQvSmzqt5C03KjlPNAlVuVoH7LxoWR5MZH9CuwY64UwliiREezfRe/02XkW0l5DDf3wQzO+/nP06RQCNJ/fRWt0jW9sz25wJK95lWi6o7uAFiTavOik2jAOuCMHeeY0G/IMX5uEw9T82G0+8K+jgc2obYn8JH3W0szXdvg+vUEYn3EnC7hv6T6SLdgS+Xli4uXh5m5GlzJs2Oxz/NHUoY2YkRjgHgy9fjxECkWeaESvnRXiAUDgxXxgTzduRhTmiKIfa53FoBqyMaX+A6McxOJ2y/C0XsP5s7YIh2xgXVMhs5kuMfIDlwjFcFvbmJfmrZj/MSPWun4eKvG2KG2ST/IocjO7aJgFLOav6vhGiAr34EZ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 09:40:14.7196
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b292af7-0572-4e2c-2414-08de8e405898
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9081

On Mon, Mar 30, 2026 at 08:41:45AM +0000, Suravee Suthikulpanit wrote:
> This will be reused in a new iommufd.c file for nested translation.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
