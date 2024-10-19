Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C401CC17B
	for <iommu@lists.linux.dev>; Sat, 19 Oct 2024 01:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729302993; cv=fail; b=fd6aq5rnbMOcTlMnxA0rQJhkldAbnrPuJKIsgxSJxhIUfxWo1ZXmVDYhb6bMv17QJnuYehLVJfrT4rRGAzExTQOnEJIWHTZpRlji80fiqb2CktpAK0zKXAip5K/1w89leMWrEI1avU/hK2XkUTKa+BwTvpFbeedGRFfc/PJ7SOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729302993; c=relaxed/simple;
	bh=UBUmyVS87vS2kPv/yDpKPYQYogz40hnD76qa8TCu0yc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tlDY9e/4jQTXxC2Tm6qEu5nYnpwHdaxbAwJJWWb8QSSqSIREPbJXWuFpuaIl68PX+SVLzjUylCEi7C8DPXYTyh8OPayUT8oBmH06tPfKTSK1U+z29XP2XBjRngLBs4SROaiH7cHjqladSDDjE8pzgdDQa0gAaGdb1AYHyyvzFmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NzKFH35a; arc=fail smtp.client-ip=40.107.94.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NzKFH35a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EwL/iWafWnHDjGIPl3xNhwiOveQFTz+HTiSHiACXP9qHCO7zlsHjk0vdUPQruiCh64bdR5IExCtilSNfQVMBYAry8WD8lq0bn9IqLirzZ0fIFOp5mr3s0g0njd6/vMcJIZVm4rmOh+HcOzPwrqlMHT1DB5C0In/5DXHvIM1rz2UvJbGcQvelb5w734bOeTx6e2QFZ0nXAdUqSImPlRFQflmCke22BlWCrHs2hfzv+elfSVlKby3kbhAcMjnDeJ1Glxu/V5dSzOA2sOd68G1GMD5aldJs+YuLJTLTZX3TT/ETTO/lxjlS84seFZdl7dk6NDyy75qa0riJGu5iTIBdlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5i/W67KRV9q2fyCW2LlIaqhFWp0kpoT8UvVVFVfl6Y0=;
 b=oa76Qpiw+5KjO5TEXjKr8jCP/nTXYhNQ4tqGsA3Pk35M0j8QyKPzUWWc2VJUUKOnyLQaL0zojzqDq7V/wz8TmicLVyaSeF0m4OaGvN2GRdUtrnvfexLj4Q0tVTcxKGAO1pzWRguuai2UQVOf7CTDvFiyoCHb+fgIyvAXMzFGN55bvnciOK+dy7BW5KRyt/T8GmCUK9LhaRbxLzMKeYU2zS+fi5lOoPYno9FnUzym0VT5LsqUAFROLbEOVGN7YMSZe4DNjA7KxYB3t8jp8wPRWN8wnBLqWuOzjvoha1Ve/kbnzuIlSe5r1i+LXkoNjeT+5AbNfzE7y7jmJr9ow71nmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5i/W67KRV9q2fyCW2LlIaqhFWp0kpoT8UvVVFVfl6Y0=;
 b=NzKFH35a5bhenIcpKxvyCLdy8P/DBrV1fIto0Fa2h9030+f+4qI6P+ucmZnFbIg/vP5OSaSF4YUAD3qW29oiSosE4DcejTbU5NK5mG7z3ITFFcpkt+oMYtkhFfA9kuRXocW3Z8PI/4RzlW9nR2moiTrI3bCANqo6zuTq8hegPLxsnj56jNUnmoL3E4nDn2DIyYbM2gHEIPTLbuA6zv5V5F4l8nQfLpAoxe/DcyceDxup3ejdyYotmHS28ZH3DjoqKSI/+LJpZ2M0hLCccUP3f2kkeAgeo/IeERC8YWQBsycEwSRuGHCvOQjnNzFAaffhm182tn0xZK+tKviE0UEgRA==
Received: from MW4P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::6)
 by SA1PR12MB6727.namprd12.prod.outlook.com (2603:10b6:806:256::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24; Sat, 19 Oct
 2024 01:56:27 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:303:114:cafe::16) by MW4P222CA0001.outlook.office365.com
 (2603:10b6:303:114::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23 via Frontend
 Transport; Sat, 19 Oct 2024 01:56:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Sat, 19 Oct 2024 01:56:27 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 18 Oct
 2024 18:56:17 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 18 Oct
 2024 18:56:16 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 18 Oct 2024 18:56:15 -0700
Date: Fri, 18 Oct 2024 18:56:14 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Mostafa Saleh <smostafa@google.com>,
	<iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Daniel Mentz
	<danielmentz@google.com>
Subject: Re: [PATCH v4 1/3] iommu/arm-smmu-v3: Introduce struct arm_smmu_event
Message-ID: <ZxMRvtullDF+gDe/@Asurada-Nvidia>
References: <20241018180022.807928-1-praan@google.com>
 <20241018180022.807928-2-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241018180022.807928-2-praan@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|SA1PR12MB6727:EE_
X-MS-Office365-Filtering-Correlation-Id: 75e1679a-8246-4533-719a-08dcefe13e6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JhkvcUyAvWKe3SIlMd/OWjT6ufyH4Adc23SQmdJZUh0A0j884FUimWlygk3S?=
 =?us-ascii?Q?BoV8xAASa7zSmAsH5NrJpzUWYhjlh2e0jwOeM6B4tZNT+O5TrWP+WmOfk6Gz?=
 =?us-ascii?Q?ZeFDF8fkvD8MxyBgTji52TwygNCBd+ZVpMTRWGA8dU5zA58HgrPN+uzbvsGW?=
 =?us-ascii?Q?OSHAWZLLtFkWYG8WHbNQv2o+fhLeNr706/yv3eO6iNexbMv/MqhC0nL1lMbb?=
 =?us-ascii?Q?TEKSDW7FLfuqzaTTeJEIEBfNEAQh+Xo/rRAUoBS7iybzDXLx/hHTVzIWNGH1?=
 =?us-ascii?Q?UTvsumdRXOgZoHXBuHQpslRd7yVR38go5dor05EtJx6alLuecHnXb7ohd0c0?=
 =?us-ascii?Q?J6pKLk8KmwgVKUG3uj/8ZoyZ9gFi80FgYEQqXSSb1svmk0G2g6M7kh6EHISg?=
 =?us-ascii?Q?dP5GVsniFgafYannDaDkCpFJZbAkShBxlZoXqruHE9ScbvITVSbl86NmHPNT?=
 =?us-ascii?Q?gRgVbXxNo+nsNO4fPaxd5vVZ7qSMqDjjxu4QbWjbAX83kP2xDVDGkZhAkeIS?=
 =?us-ascii?Q?zkQgMMJCzogc/u08ytcEzys8A7CpoeGBJBTPWEcrteLYC7eMdmp+l5RkNGZd?=
 =?us-ascii?Q?ysl8bgp5i/ipye9s21Lwmez24bLsRj2QuX5vERnUD77GkU6Jccpx/tAWtTv1?=
 =?us-ascii?Q?N+6lGm8CO67zaYWXBFff/dJ/Bv4EJrm9sdO4p8CG5ZyshYtetH6mqAGpTFR1?=
 =?us-ascii?Q?9RJwK6BjMkP4avbliDWjCpyZdfVM0B6rOhakQOvRe/x/V1q3Z2zcL+pOCGXF?=
 =?us-ascii?Q?anPAziW2orxeWsudvL9qqkhBUvEpL4clwo3wO5Fob9aRzdFSfhnp+4G3jvXX?=
 =?us-ascii?Q?tCKHzFAWpG9Be84csxMWlEuz6KKbs3t3k3dQEiKUmBYXPEItOb+QLw90TCo6?=
 =?us-ascii?Q?wFeEU0TkYRqB2l8WAcaotx3DGKZvUV85Rb8ODfB0p9N2HgG5PyC3T1s650fx?=
 =?us-ascii?Q?cYzgvAUrUqshsiR99KyDPoKETEFzkq3dsoTJS2qO4Q6fhHnxHAB52aQC8jWv?=
 =?us-ascii?Q?yz3fxV7LJjb636RyNaZt/ZaG5Wl1iPmk03m8Zt1wyB9kygGPhT/fVlCNdT3M?=
 =?us-ascii?Q?Fkhw+34cfVlaOzbM4l5Pd/KYrmci8+dAvMS/sltnnZDgHNm/JnRR72w7ftgw?=
 =?us-ascii?Q?u1MB2+xXwlMilTIU9kmti/G//yn3s0+rvQWSDGyVdJdZanXw30RlAh+47qnM?=
 =?us-ascii?Q?uw+ufadbljX8RFZw9QiIPN5CM5YPwhyscefq1nLOTGGlxv2ZUyEjV161t9GD?=
 =?us-ascii?Q?C9+DCIbiPueuKUxduzfa94S+zRvWNIjqj2xopBE+6fWN9ujcGQlpUCJkuOmu?=
 =?us-ascii?Q?vM3MHCNWfrQdkN1FTT57Z4hBKL53B5c4U0wERkZENyMFvybV5CIE9LPFBmqK?=
 =?us-ascii?Q?LxssEDB/q7gTd5N0grFYuPMyAqfg3jbIRBMMO+oiqdlhm13X9g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2024 01:56:27.2688
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75e1679a-8246-4533-719a-08dcefe13e6f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6727

On Fri, Oct 18, 2024 at 06:00:20PM +0000, Pranjal Shrivastava wrote:
> Introduce `struct arm_smmu_event` to represent event records.
> Parse out relevant fields from raw event records for ease and
> use the new `struct arm_smmu_event` instead.
> 
> Signed-off-by: Daniel Mentz <danielmentz@google.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

With some nits:

> +static void arm_smmu_get_event_from_raw(struct arm_smmu_device *smmu,
> +                                       struct arm_smmu_event *event)
> +{
> +       /* Pick out the good stuff */
> +       event->id = FIELD_GET(EVTQ_0_ID, event->raw[0]);
> +       event->sid = FIELD_GET(EVTQ_0_SID, event->raw[0]);
> +       event->ssid_valid = event->raw[0] & EVTQ_0_SSV;
> +       event->ssid = event->ssid_valid ? FIELD_GET(EVTQ_0_SSID, event->raw[0]) : IOMMU_NO_PASID;

	event->ssid = event->ssid_valid ?
		      FIELD_GET(EVTQ_0_SSID, event->raw[0]) : IOMMU_NO_PASID;

Or maybe would better memset(0) the event, and then:
	if (event->ssid_valid)
		event->ssid = FIELD_GET(EVTQ_0_SSID, event->raw[0]);

>  static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)

>         do {
> -               while (!queue_remove_raw(q, evt)) {
> -                       u8 id = FIELD_GET(EVTQ_0_ID, evt[0]);
> +               while (!queue_remove_raw(q, evt.raw)) {
> 
> -                       ret = arm_smmu_handle_evt(smmu, evt);

Could drop that blank line in-between as well.

> +                       arm_smmu_get_event_from_raw(smmu, &evt);
> +                       ret = arm_smmu_handle_evt(&evt);
>                         if (!ret || !__ratelimit(&rs))
>                                 continue;
> 
> -                       dev_info(smmu->dev, "event 0x%02x received:\n", id);
> -                       for (i = 0; i < ARRAY_SIZE(evt); ++i)
> +                       dev_info(smmu->dev, "event 0x%02x received:\n", evt.id);
> +                       for (i = 0; i < EVTQ_ENT_DWORDS; ++i)
>                                 dev_info(smmu->dev, "\t0x%016llx\n",
> -                                        (unsigned long long)evt[i]);
> +                                       (unsigned long long)evt.raw[i]);
                                          ^
Could keep the previous indentation -----|

Nicolin
