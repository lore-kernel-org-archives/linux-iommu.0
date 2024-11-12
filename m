Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A344A230997
	for <iommu@lists.linux.dev>; Tue, 12 Nov 2024 23:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731454291; cv=fail; b=GvlijDi8DgQo3PybK6eM0ILPOfVI0PDa9UJoi8vmmxdRXxI+B2JchyA/Jmso3Jodwj/dT1RA+ii3Rym5MvY8Ctk/6muXvafqJRld7GAbF3JpfoxTsFWIwe09jHWMVOl031EJEVYIxr/fD5lJPm+O1Hl9LmfON0V5+yuYB4JK+uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731454291; c=relaxed/simple;
	bh=bkEgzQ0hlYMengXXDBr84KJrBYqUbv3n0xhoD1SPvXc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRiQKt+i3yBh0m4sWDjScLBv4dOyasidiY+nIHVzpaZ4GwfXvIIhwBUyUHC+7pGaAN3/dIxYSqwwRJ3J29TaEPOLmrkFCqaGsWhAPa77LZguBFE8lsEZByVPPMr/yVapkjNuTmxVa61roG50k5mwaCQ6bR3ctNT8Wz5uxeGLZgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JMZywdSi; arc=fail smtp.client-ip=40.107.220.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JMZywdSi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mM2QqoTZqIHcogH+pstQrnnKHtWL1ZrFhud4GQADsR8OkB1iWA/baVVXAfPsZbE3P2aNk7dEru2h97gSkbD1O1H6znmOpimZpoZZ8/wrB9LHqrGU0DJyIYtWOMO1B9pDpg2R5tOEigAW9lzTczdTW4IIzmfi5Xgzm0+l3xxrdNRSYMN4FoRQH8nam2Xa+HGuNNtX5dW5u8qjwcwSoikyroFchCZ8GV2TXIt4qZ8XIojWiZB0r66vHZ2GUPgjNXARARTS6QfYpX8gzTZG0eFb0w/03EydXAOHVu+om3XObwFZK5V+tZ4nj1fvpiLmNNoY2SSXhcMXWrXAA59s1eqoHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVE+cAjQ1XwXhHCrusTmDYyWmLPs8Lw+u3QRI88csoQ=;
 b=eZDCjOSWFk0btSuIhdM28ixzYx1OwTjAI2OG5DwcvILM6cQn92EJAE73bkPalRwm/3FZet3CyUnU8pgfQzPir90MgprfbFen0HekygKMXJ7x6u0cDUUWz9EuE2cEi9xFbxHU+pukPPBwgksGdEC4n5OSH2tzzMq7iVY3LKFMMW840d9dS5jTxyI1gd7yyaCJXxr+5clo4boTTcOFMYt71mC6n7YbK31nptfyfNZA/Ha07cmfFWyeShwxEaTtspCK1RBaYBJeu8cgFXZLOoJRg/Xrsb2caxoJDDZrO+6uPrj+XXuYI0gHHo6UuOhGdZM7jFivgO3KC/tcaPbE4TgOKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVE+cAjQ1XwXhHCrusTmDYyWmLPs8Lw+u3QRI88csoQ=;
 b=JMZywdSigU1bownefxDwWO6gHE0ry8PfVDHFmYP3In5pPTDmvEyElAnDdpQndAhdobouIqkR/A8Jzz4PA6BcnSA2lFebSsMUf5485ZgTS43HMrdlg1Fx3WF4EDzFL5wY/pd3YYse2sVdmDJes2e0Pa1uR7xcDtQ55Wsz3XtyfzV5XnrEBx0CAJoaXfAzZAZbU6lHY2qi+ECdDLhJViBwHXbo869gdNXqCgZX9OGAIhKgHjzOUX9GQFrq5AYh7VmevVDmwj1k2fVdxoF1LqMDXlZwsJgi1jkHn+zZwHarTwJoRhTW7GIcX/U/+mfTnCjOVHSdpJxhlpjWQcG1kHwOBA==
Received: from BL1PR13CA0087.namprd13.prod.outlook.com (2603:10b6:208:2b8::32)
 by DS7PR12MB6165.namprd12.prod.outlook.com (2603:10b6:8:9a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 23:31:22 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::fb) by BL1PR13CA0087.outlook.office365.com
 (2603:10b6:208:2b8::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.14 via Frontend
 Transport; Tue, 12 Nov 2024 23:31:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Tue, 12 Nov 2024 23:31:21 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 12 Nov
 2024 15:31:00 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 12 Nov
 2024 15:31:00 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 12 Nov 2024 15:30:59 -0800
Date: Tue, 12 Nov 2024 15:30:58 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Mostafa Saleh <smostafa@google.com>,
	<iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Daniel Mentz
	<danielmentz@google.com>
Subject: Re: [PATCH v5 1/3] iommu/arm-smmu-v3: Introduce struct arm_smmu_event
Message-ID: <ZzPlMlE2gpH9DQQ4@Asurada-Nvidia>
References: <20241112083018.1662104-1-praan@google.com>
 <20241112083018.1662104-2-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241112083018.1662104-2-praan@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|DS7PR12MB6165:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f20c996-2b26-4ab7-c1b9-08dd03721def
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QgqlGVnzEJhTPGI+n6QZjBzj/OEaStsxoWKK4HkkkM2me790NC4re7HQdTi/?=
 =?us-ascii?Q?U/35/0j4HVLD5iU25VMdWog+Zy7D63TL7/qfEEL+jaoNtwKBq9egVwjZP7lf?=
 =?us-ascii?Q?VQRIvEpawfDpnD4JQSAECEQnd9rM+3IMubccJ55k0LWxoi/7rCNmwyOs7Utq?=
 =?us-ascii?Q?4CG8Y4aHfJyPs6eUnkUU/bw1r2cQGjH0GhxwShZ6OaUBUNSsW3Sq7fIa12dt?=
 =?us-ascii?Q?gJS1cqxY47Q/5TwUMYQ2ZzaCcMLO1W2yAISwtnKjNnzse9gJkbfsTHWWO1nf?=
 =?us-ascii?Q?77lrGyyZuJ6Tlm+mqL/fkOfMZ1pisHCpylpTwySsRl/viiLRBGPUMpryWDQ8?=
 =?us-ascii?Q?RK58kK5F3qyu1SD1ZLuI6JnwXoOw2bisjFTxDh6WRYz1+1oGRv5QRJFOnO5p?=
 =?us-ascii?Q?lRM5LYKnNjXN6t7nkorrMg3oI7syJnh8/qZ8AUSCcoWRRC/xvvD57yemcfKE?=
 =?us-ascii?Q?9IEqIFYEfS1tvtoQ4XmXQouXjdIzqDLQtHOfnYhQVFxWYtfulda3nj3X34AF?=
 =?us-ascii?Q?TFLUCYsnJGcv8VLlkbnNpsZ7mab1SK1N8lcWSI7knkJuO0FvjKiv3qQy8amN?=
 =?us-ascii?Q?hQ39y3ytNuN5qDTcQpJDboUzvkgEZ3XgpumQO1uNRY+7n9I+FwBGUC2A1zFG?=
 =?us-ascii?Q?XCQ/igadmclEohQelysbAa1Hg1EDjXWhtGWs/jNLu9aB9NEEMBGXCR0J+oa9?=
 =?us-ascii?Q?z5NjG4c937bZhDKAHNsHYJ+Z+D80E8gKtWvnjEGvjZPr8odSk2oJd8Yb5uRB?=
 =?us-ascii?Q?twhAa0bzU2lfDpvc6bsOzt2Q4wL6Y4ltsVaFp27Fl7BeftyvAYCoBoVyfZ5x?=
 =?us-ascii?Q?wDluP8wA4zI2uKKv0MPA9O9d4iVpNxz9Gw656c8e4BSSdhXz6SS5Pk4HUd1U?=
 =?us-ascii?Q?zgJJDzQWh03A71lmuZ8aIHSmEsgztkrI9s/go8eEyhKyaQuXzeIq9TY8O02i?=
 =?us-ascii?Q?Sg9mmsBm2HvR8Xc2ixTxnkJXnmslepy3MBUeTjbx7xVJvmxo3HAxtRSTJlq3?=
 =?us-ascii?Q?CAHGhYoeC31Omv0J297eh5eo3ZNB4f6DBCG82fazkrEk4NpgDTK7LJcUIFme?=
 =?us-ascii?Q?7JUdURj87G5B585Tzo47SkVH4Z6Vje1CWEYR0qQm+UvUnD8voOzhSu8CA8ox?=
 =?us-ascii?Q?cpXil2HCLAEEPoJfViG8oBe9hfefOxvgyo1vVahxDqBEcgW64x2Ya0pPlvni?=
 =?us-ascii?Q?9W5N+RifKbfYqhz667cHw5MkOLkEP6/P0otKUsj9t38HyHSllN/rIE5PCR6F?=
 =?us-ascii?Q?fJ77/V359u2X1Tmi94hvN/sv8zaWhf0z71vJMBAIuAhBQITNjUjXg99mhtg4?=
 =?us-ascii?Q?fWnqE/VMJeexxo3QOavjHqR9ufdG9zGWcR4c+yaEmMabk9+arqVLTCaNrLmZ?=
 =?us-ascii?Q?pvYtxw8lqT/rTjtLCpcdQDWTeUqAAt/6UrNzj1noGUmTLBbUuA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 23:31:21.7854
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f20c996-2b26-4ab7-c1b9-08dd03721def
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6165

On Tue, Nov 12, 2024 at 08:30:16AM +0000, Pranjal Shrivastava wrote:
> +static void arm_smmu_decode_event(u64 *raw, struct arm_smmu_event *event)
..
> +static int arm_smmu_handle_evt(struct arm_smmu_device *smmu,
> +                              struct arm_smmu_event *event)

s/arm_smmu_handle_evt/arm_smmu_handle_event

Also, given that these two define "struct arm_smmu_event *event"
nicely, ...

> @@ -1820,25 +1836,26 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
>  static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
>  {
>         int i, ret;
> +       u64 raw_evt[EVTQ_ENT_DWORDS];
> +       struct arm_smmu_event evt = {0};

I think we can keep the existing "evt" for raw and simply add:
	struct arm_smmu_event event = { };

So the patch could look cleaner, less the "s/evt/raw_evt" part.

>         struct arm_smmu_device *smmu = dev;
>         struct arm_smmu_queue *q = &smmu->evtq.q;
>         struct arm_smmu_ll_queue *llq = &q->llq;
>         static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
>                                       DEFAULT_RATELIMIT_BURST);
> -       u64 evt[EVTQ_ENT_DWORDS];
> 
>         do {
> -               while (!queue_remove_raw(q, evt)) {
> -                       u8 id = FIELD_GET(EVTQ_0_ID, evt[0]);
> +               while (!queue_remove_raw(q, raw_evt)) {
> 
> -                       ret = arm_smmu_handle_evt(smmu, evt);
> +                       arm_smmu_decode_event(raw_evt, &evt);

Drop the empty line in-between please.

> +                       ret = arm_smmu_handle_evt(smmu, &evt);
>                         if (!ret || !__ratelimit(&rs))
>                                 continue;
> 
> -                       dev_info(smmu->dev, "event 0x%02x received:\n", id);
> -                       for (i = 0; i < ARRAY_SIZE(evt); ++i)
> +                       dev_info(smmu->dev, "event 0x%02x received:\n", evt.id);
> +                       for (i = 0; i < EVTQ_ENT_DWORDS; ++i)
>                                 dev_info(smmu->dev, "\t0x%016llx\n",
> -                                        (unsigned long long)evt[i]);
> +                                       (unsigned long long)raw_evt[i]);

Please keep the previous indentations.

> 
>                         cond_resched();
>                 }
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 1e9952ca989f..abb543d987f6 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -771,6 +771,22 @@ struct arm_smmu_stream {
>         struct rb_node                  node;
>  };
> 
> +struct arm_smmu_event {
> +       u8                              stall           : 1,
> +                                       ssv             : 1,
> +                                       privileged      : 1,
> +                                       instruction     : 1,
> +                                       s2              : 1,
> +                                       read            : 1;

Feels odd to do so...should all of them be:
	u8			name : 1;
?

Thanks
Nicolin
