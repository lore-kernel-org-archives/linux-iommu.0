Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8031E3D9E
	for <iommu@lists.linux.dev>; Mon, 30 Sep 2024 19:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727724762; cv=fail; b=X++cDa4w3lUjHi6zapnl2L4Ibj5eIpq2jSPKVZTtKvXbJZo2H4tVGeVqClIm7KfDP22nzB6aNfWE6t4dj2NoNVx7Y36AI3nESb+TiecssIyOsnvVy+NCGzO6BQLYsRvyTStUx36dnJ+8pCIgYxwDyoQGK9PBzTxYBRSaRp1lJJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727724762; c=relaxed/simple;
	bh=NiGEoR/hIN7+K+0T32zrUe+HmJMVFasKXx/OYu8t8YM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AwCueEpD4CRkZoLrqr/cw4jypDQ6yspwGGZS4uEnnMRoZ+MKtKePFyMB67uFR3hBmR/2G8OMztu5V5mszZBthQUbXjm11z7n+79G03+neTQsnN8fiXIqi7e8NAE5cy5q+wTsA97W7yZ+8c5J1jJBkVfQhpJIyUdXjbHhAnPlmFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eqvd3dvM; arc=fail smtp.client-ip=40.107.236.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eqvd3dvM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jvyQIByAowzM6Ux2A7FmJD+oRpmCJaTiWCxzFACVJGRlZ67o+Mc/Bh85I6dQzKc4u+pi83AJbC1uIjGqI0qWlFqBmaMBLBPXqURQsHchphV8gnqGXBafV3AhE0cbbu7ULa59PBgQfdeORFK1Ex/j32zXAOyI1uxjOLO736tiRkNYaONLrYtwhQW7HF/frYoE8PbAsZulwbLXJxze2WCeleDgIeTTO9LJVGYXmljfkF+DwYldXyPL+tsoxO4+/ErBiZwTpdH9Qmk+G3B2E/incdRvvujAS2t0f6Hm3F1qkCY86/bUizJQHWjP4aj6xVFS+OHC3/5l6a6q+357GAI/cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3JKgn7DaQna1UmNZvX5tK8wek20iBKrRalghd6cmFc=;
 b=j0kdyv7/PoSjlDpv+ILIF3SI0CF4LoVioj7FkrIZxfVVLB9iFU6AiRMQpt+2cOWqkZHMBNKji3wLqycanjDsB44x1hWNA+fwiziVP+rhXW4Vjlpz2OUeswhcji9D5MsbbIT3M2GxxspJo1PYLaIIX1aSyglQsukAcUceJbBZD0WhHauMhTXkI2uSLLrKaZ5HFGOYOL/FRV6W9vWLfJbjmAf5NTNrpGm/syl5P4qQQNBBXyRrVde38ajJOQhGUuSI/US7pfM5aoUSS7FqAk959qbiELg594Ee8rZMtBY2h1LJp80wOa3h/NGDAJ+tfykloHPq5kvSpq2iM2xcoCJw7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3JKgn7DaQna1UmNZvX5tK8wek20iBKrRalghd6cmFc=;
 b=eqvd3dvMUvIFmXhPGmkvGNJ3frwrz3XAhIYVR+8duWgun/K5QHOUvxutqYEsrizflARmt6iM3nFNFVc7GZx4NrOXopBY501pyTnfcV1O0SjVMzC0fkxfMdHGEFGlsFvcRNpg4o3hIL2FPamtWwzvvumWeFstv5LdHOvw3gpCuuxmPzqMSnjb5yWr0BrY8ZW6Ici1cUVk/xvrRnSOp7cJXVsoREfN0rGL1e8DZ0JE63rFzyMuJB558j1t/Rc0pxqw/z3+UsOwpeZr11hALapJ2NcGidPwb05n0SyDWrHNyV2mbyC+18c3N1SADH2l4ynFHsLYUn+cDdIafNNLnxQuKA==
Received: from BYAPR02CA0064.namprd02.prod.outlook.com (2603:10b6:a03:54::41)
 by PH7PR12MB6635.namprd12.prod.outlook.com (2603:10b6:510:210::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 19:32:36 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:a03:54:cafe::38) by BYAPR02CA0064.outlook.office365.com
 (2603:10b6:a03:54::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26 via Frontend
 Transport; Mon, 30 Sep 2024 19:32:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 19:32:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 30 Sep
 2024 12:32:23 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 30 Sep
 2024 12:32:23 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 30 Sep 2024 12:32:22 -0700
Date: Mon, 30 Sep 2024 12:32:21 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Mostafa Saleh <smostafa@google.com>,
	<iommu@lists.linux.dev>
Subject: Re: [PATCH v3 2/2] iommu/arm-smmu-v3: Adopt arm_smmu_event in
 handlers
Message-ID: <Zvr8xUEHNg1GiA8V@Asurada-Nvidia>
References: <20240928005143.2378938-1-praan@google.com>
 <20240928005143.2378938-3-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240928005143.2378938-3-praan@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|PH7PR12MB6635:EE_
X-MS-Office365-Filtering-Correlation-Id: b2f8ade6-eae9-4bb3-5f24-08dce186a36c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v3yXAptnN86Wrvkez8WuruprGzzFYOuDVi+UPatD763Y73iCoZTSb3HFOPS7?=
 =?us-ascii?Q?VwrydFT3QznI9Xy6PFOe7gzZ7BhDDX0KgdPCpgzn7Ybhbeb5mW7iHEEFFNO6?=
 =?us-ascii?Q?wEvJyKp5PxT96lMr+zG2wf7fVwpWnpUMJNGDpew3rYYA2fCz36QAd5PYEW6d?=
 =?us-ascii?Q?QLPRKwugULbiIho/+SPG06gTNafYN63sjAkoZxcxDmECgav0mH91/1aVBXbl?=
 =?us-ascii?Q?IF5gs2SZk79NFzz4oBtzLkpWtAahLKdVlJCLJrBk8W9VcwML2GbwwUTIfa52?=
 =?us-ascii?Q?5pnMc0J1XOC/ZAZxTow0YO4OyFa20uayjLGiZqKh0W66kJZ+EOu02Efn9Xs4?=
 =?us-ascii?Q?aYjQ/2i/J/6wMAwSYseaubhilAxi/38bfAG8N0TxOlu8VoC9QkZeklhbLCaz?=
 =?us-ascii?Q?cCNRRkwARdqGgLs+M9GLxEN1F2ukAflJP7q7DLuzBkFOCmCHL+fJMAgDkacI?=
 =?us-ascii?Q?GQ9zphboYqXgjO9kLO1vVb3lYBp1x9GpfEZak0r0jJL4BWdrZqykX6k1tyoJ?=
 =?us-ascii?Q?QfGfArcN+mud8JrkdIoqqqCBAS/HxkPsBnpygN+QP2g3GKdRDHjHg2sILPK0?=
 =?us-ascii?Q?Usja7rIn07WVJOBihdVMxXP8moHMRtaey86tvvK2ZsoQu1tq1tSnKM3RV7dz?=
 =?us-ascii?Q?iAjytSHQ6xSnj1jXNYoiLoJjhjiDPGjZrUOhgKEkKkgta/7QaD3k7MPfS3KU?=
 =?us-ascii?Q?Lr10TC6z/H/4fhPcZ7iH7poL0/EI0v0pTnRz60L0F0SzbAbek2rWnbj3kfid?=
 =?us-ascii?Q?YinfhE78Hvd+4BHZuFynDhFiRf6kMoNpVqQ2eG6O0S0D44aCY16AV25bf+xR?=
 =?us-ascii?Q?tIvA1qYjuzDrkmfQQFIG3PnVOM23pdvExj+GY45cVinFGF8GYKtonfF5RwZ9?=
 =?us-ascii?Q?JIA23hyHwDIXqwR7/biZTymG9x6QViWimfco1RIhTZ/ivoXgZIo3GKwSxQmK?=
 =?us-ascii?Q?WPCIxAubkbCsYjaAJ9xD8QulnTTx79BxDLmxCuKwUFmkFOQcXBkYcsvq2H54?=
 =?us-ascii?Q?FmAXkERiPM+FVwsQse5MCVPpKPSuQkLlvHhB3k4dakkEvlP10w8wA/Lc+gru?=
 =?us-ascii?Q?T/xm+K3ox3BdhGK0o8XiKyRpZMvEtJyUHKgMDylcBnhp49uLG/pjmqAro4TC?=
 =?us-ascii?Q?icaOoPjEzwd7bPLucMMar0OelrSGCxEkAaJr1K94gZtuPzSKi0lsiTjnMJxV?=
 =?us-ascii?Q?flehDabhbU678Wvsgsf2WtV2XElAm7xftqBQNltWSZ/tK4z3gM5I1nwWLcA9?=
 =?us-ascii?Q?hQ9NWaD2VRar6tfekfFy0d5DXQ1kA4P1ilEdnsdnsQ6mbFoGd2cqQBYD+ZhZ?=
 =?us-ascii?Q?OX4fwcS+iN8nRjoKe8BrBqp4jxv0bT9B42XTMAh4BOYOqM/RZu2yopG9igEb?=
 =?us-ascii?Q?DXb/T6SAIyhBIvJXZ7eVPx+kZXBj?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 19:32:36.2955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f8ade6-eae9-4bb3-5f24-08dce186a36c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6635

On Sat, Sep 28, 2024 at 12:51:43AM +0000, Pranjal Shrivastava wrote:
>  /* IRQ and event handlers */
> -static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
> +static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, struct arm_smmu_event *event)

Looks like we could stuff an smmu pointer in the event:

struct arm_smmu_event {
+	struct arm_smmu_device *smmu;
	struct arm_smmu_master		*master;
	const char			*master_name;

Then both this arm_smmu_handle_evt and arm_smmu_dump_event can be
slightly cleaner.

> 
>         mutex_lock(&smmu->streams_mutex);
> -       master = arm_smmu_find_master(smmu, sid);
> -       if (!master) {
> +       event->master = arm_smmu_find_master(smmu, event->sid);
> +       if (!event->master) {
>                 ret = -EINVAL;
> +               event->master_name = "(unassigned sid)";
>                 goto out_unlock;
>         }

The PATCH-1 already did arm_smmu_find_master() to event->master in
arm_smmu_get_evt_info()?

Maybe we still need a wider mutex to lock arm_smmu_get_evt_info and
arm_smmu_handle_evt.

Thanks
Nicolin
