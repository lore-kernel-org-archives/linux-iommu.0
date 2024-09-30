Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2089.outbound.protection.outlook.com [40.107.95.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434D015E97
	for <iommu@lists.linux.dev>; Mon, 30 Sep 2024 19:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727723735; cv=fail; b=t2WzkHE/OsG/auNaevssssw/D/4SEHtgBm8IHrhCG++zmIkQcStUpaxW1Yk75PtztKqPk8PuaFmuq9soJRmEjgkFr20kj7RV6ZDm74USGDtQCt2PupowC0dg5oozA6a2SN3IcmoNqwegupU55lAPbs9nWdaiN4RHJMqwLjXcqvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727723735; c=relaxed/simple;
	bh=I3bS5z7Nrd7yHI3+q+wUYtSrd43tkw11VEbLivK+UeQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+fYPGggzmuAvsdHD8/mb2elPDn1n3QrZnTDMMoX9/1N/54T6/6uwYSoK3jZvJ4QPIOjg5nlDEDnZJldOxA2GRccvC4UHHohmtu2KSB1llKDCWytHVxP0N6y+O0JHbsCrL8d5aOAY1HH4j+yC0DuTLHvWnIl9Zic8qOmsrbXBws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bvw+RSws; arc=fail smtp.client-ip=40.107.95.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bvw+RSws"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=apx5TM5Mxlm7F5DTMuC+ntfyXrswFS1szlv5KPR0tr4zqn6jiZQYta9cCo+ZuVHApckmWapzeSTbGL9uABdvGE7yyAcZ7x0yE2ieIkdf6frgAlhHZkWdj6RRqSfYNZCCWMEAl9/VJxzhPWeEkfYAq9JLKYhBTTT9n9hsOyWQqrycULK1lo/em3/XFLlKzNoGgxib1vXfO9fM9A9AhnBr9UPsIj3g3q+ndH//Kv0JDo2zrCjJ99ugPb8UMYb2jMO5vkFRPFe6HltgImkjMVY62hZ1IVQ6azbSTIJWE0voRWDkdUIt0ClAWWOO/6mmPo6Q3OlbbYERvCojOPX8iDZgqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRU/Tx34Pvozz9iT4h6fXz4vLie6Z0vUBNVgUAi+bRA=;
 b=qTEKTow7rfjoUI4LOXftremJihPMYBrh0pYboor9mHx7INlhlwca32GqTKUah+Knr2vDIjyZGE9KP7PMGl03iqVDf6QKtAlnrW4U7OTX/6+SsLkFI0cV9o7vPBLjAztRmLcpPlLe3u7hfTOaxxE/EIq1wG166Ip0uap8sKjm0XIXYShubAhconCda3xxIHaJAc9YhJ7638XgS5s0JnMvvcYK/8ZL3wCcJYnROjya5/CcCNkRgEQrFUJiDldN8r4rw0cC58/IyUS06d6AcN8BuQnQpMFXas3xfBehTbFm2VpWosL0YH0VNWb7H82K8X6qCxrgFeINQRApcBVpPTM6Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRU/Tx34Pvozz9iT4h6fXz4vLie6Z0vUBNVgUAi+bRA=;
 b=bvw+RSwsc3b4tAHPGGv45Vk34+yphAOYFgsoWTOgSI+/A9WkhQtAELhw5siKABsVniHVQdeFcrkhALFGUOp38IIgXil95db19ZBr8h34ywUzfSwj8wI5olmMkTXegBstHzR4NaNx6bMFuEnTMzdBYD3SuRi7r151BoWjgS70m5Q2cmGA0OMAzdiXrg9kT19jHY30KzRkFJvSwDv30hc66e44VeZZfuBeZrSawkZMp4Br3sIOk7jEelN/zblzVp749TtAaryK78zXsnJuBWArsJlR1562Xc4a4KdzETdnqA+zzB8vglcg6zDJ+UgOjIFGutLdtE2rfDnG2JfaKlxy6A==
Received: from BN8PR12CA0023.namprd12.prod.outlook.com (2603:10b6:408:60::36)
 by SA1PR12MB5613.namprd12.prod.outlook.com (2603:10b6:806:22b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 19:15:29 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:408:60:cafe::d9) by BN8PR12CA0023.outlook.office365.com
 (2603:10b6:408:60::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Mon, 30 Sep 2024 19:15:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 19:15:28 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 30 Sep
 2024 12:15:12 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 30 Sep 2024 12:15:11 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 30 Sep 2024 12:15:11 -0700
Date: Mon, 30 Sep 2024 12:15:10 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Mostafa Saleh <smostafa@google.com>,
	<iommu@lists.linux.dev>, Daniel Mentz <danielmentz@google.com>
Subject: Re: [PATCH v3 1/2] iommu/arm-smmu-v3: Print better events records
Message-ID: <Zvr4vmU7u2BY3MLM@Asurada-Nvidia>
References: <20240928005143.2378938-1-praan@google.com>
 <20240928005143.2378938-2-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240928005143.2378938-2-praan@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|SA1PR12MB5613:EE_
X-MS-Office365-Filtering-Correlation-Id: 03bc6943-1f8b-4cf7-f8b3-08dce1843f13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aYnQGXErdWpFnE2jHDgjk5z6cZGzVx0nG76UB7EHbpEBkIQxucADlfO06yvc?=
 =?us-ascii?Q?tg4OTDn6Y7AcsvWGlDCRM6g0whLfUc/9Pa+zaHSyeqrDsr7AU8IzGLaREyTT?=
 =?us-ascii?Q?n2Qkv/ZQh8E7NXBykXHwRZ+jB7HA2WOzgwykeYX3ILEmdyC6q55Q01Gfq7QN?=
 =?us-ascii?Q?fIcPMwuwmVhB+sE+p8Yp+ypxbMPMopdQWBh6Kj5Qe9MQUA9nytmVEFShJZJs?=
 =?us-ascii?Q?Sy/Cr+njCxNp+cCFCUTechnXXMM16nZNUifwWwDyHrFjjiSVOhvw8SoajQ7L?=
 =?us-ascii?Q?vOR7jD7GVs3MzsxI+OqRu0Rlbv2+z1dgzwSQEu4AHg3tsr0D5ULJfV9Q8lLF?=
 =?us-ascii?Q?+iUdzncH59b3bSROqPqWokkoI+JkeLCyyaB7IIsLWUKP09L0nYLHGrzDnqye?=
 =?us-ascii?Q?TNnu/kPc1h7VtbAR2+jjlVWf8utr2586AYaVy//YkVpsJ4Xm8pQB1N0FNYpU?=
 =?us-ascii?Q?e3GRd2Zhncm7WKFl9RtZJ7TLKA/85Ae2IiaGagbYiP5I4/BIF/BedBvICGOj?=
 =?us-ascii?Q?QW9O4jnMFPPgM4aHV1pX/nEiGo7pIXsketpBfZ+keqIxjXgXB7R3Tau9FlyY?=
 =?us-ascii?Q?hcI6Eq/vYkmwWypFGHCcVGa8rwJpiHb0dZxd6UPFimY9jOjRU3K6rnORsOa0?=
 =?us-ascii?Q?sl5z8DxV9x3AA9HasrT/efRBMY9/HK7M9SEeNMRzRXYVyT70XD1mFSbqj1i2?=
 =?us-ascii?Q?Z+DFag/MXlW3R5dv4Ok4EFTQwwUbVDPKcfLkhTbuTgrNKg2YiqKMPpG3ELth?=
 =?us-ascii?Q?v3RWhwPeBM3glijCvBj/YG1HsHIe5jBmx7wWhGzurxQcp296jbpkoGtVzLK9?=
 =?us-ascii?Q?4TWOxc8YAPU+yC1atCQ9bliag1vaclHeMgyRTdVBx9t1p+kMhEoOUTvTEJ7u?=
 =?us-ascii?Q?tg4NfKwOpyXPVr0/59NPKN32yJLE0tDo0fX24ZATogo9S58/Xoeegr/VJ+bp?=
 =?us-ascii?Q?tax0Nz40PgvIu7uCz9qjgi6Fz1DU0UPPvakOeSmxR4o9Ta/f/nxyK7b9bJ4P?=
 =?us-ascii?Q?k37q2G2q1BmqniYHNNWklNWRYSHUV8e8BadXKVnGLf0vdOvQj3GPWdC0+xt4?=
 =?us-ascii?Q?tQUh6y8c97ypBWhTiXR8gRPURm5QUmz9Ers51hL7PT2TJwmHyc23/UeEY9g+?=
 =?us-ascii?Q?5q/BmDlMCQQQtHYvE/NcGWXdAKd59v8tk8y4DHbSDDPHGwuKi2OFT3QfPl82?=
 =?us-ascii?Q?j/D5nc2s4nIrkSNeDL5DaazBoqFbFuHTSvsHywMVhL2Kq8XMLWdRMRDm4HR+?=
 =?us-ascii?Q?693Ezg2vmUFkVtTQZ+kw0uGcn7uiWb9X0IN8AlLoX5c/N3YcYwZsqcrWbs9u?=
 =?us-ascii?Q?ct8uOq7bZKC89iYHlo/68rWlbOPMsKToFJqgxv9KkE8pKMPqb0YSKqm191cw?=
 =?us-ascii?Q?TUmloJuzlEC8KncZqMrvW67+Ua8P?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 19:15:28.8098
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03bc6943-1f8b-4cf7-f8b3-08dce1843f13
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5613

On Sat, Sep 28, 2024 at 12:51:42AM +0000, Pranjal Shrivastava wrote:

> +static const char * const class_str[] = {
> +       [0] = "CD fetch",
> +       [1] = "Stage 1 translation table fetch",
> +       [2] = "Input address caused fault ",
> +       [3] = "Reserved",
> +};

s/class_str/event_class_str

> @@ -1756,6 +1784,66 @@ arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
>         return rb_entry(node, struct arm_smmu_stream, node)->master;
>  }
> 
> +static void arm_smmu_dump_raw_event(struct arm_smmu_device *smmu,
> +                                   struct arm_smmu_event *event)
> +{
> +       int i;
> +
> +       dev_err(smmu->dev, "event 0x%02x received: master %s:\n",
> +               event->id, event->master_name);
> +
> +       for (i = 0; i < EVTQ_ENT_DWORDS; ++i)
> +               dev_err(smmu->dev, "\t0x%016llx\n",
> +                        (unsigned long long)event->raw[i]);

Though I know that is what we have been doing in the driver, I
wonder if we have to cast from u64 to ull?

> +static void arm_smmu_dump_event(struct arm_smmu_device *smmu,
> +                               struct arm_smmu_event *event)
> +{
> +       char title[256] = {0};
> +       char mastr[256] = {0};
> +       char addrs[256] = {0};
> +       char flags[256] = {0};
> +       char other[256] = {0};
> +
> +       snprintf(title, 256, "Unexpected event received: %s\n", event_str[event->id]);
> +       snprintf(mastr, 256, "\tmaster: %s sid: 0x%08x.0x%05x\n",
> +                event->master_name, event->sid, event->ssid);
> +
> +       switch (event->id) {
> +       case EVT_ID_TRANSLATION_FAULT:
> +       case EVT_ID_ADDR_SIZE_FAULT:
> +       case EVT_ID_ACCESS_FAULT:
> +       case EVT_ID_PERMISSION_FAULT:
> +               snprintf(addrs, 256, "\tiova = %#llx ipa = %#llx\n", event->iova, event->ipa);
> +               snprintf(flags, 256, "\t%s%s%s%s%s%s\n",
> +                               event->privileged ? "Priv |" : "Unpriv |",
> +                               event->instruction ? " Inst |" : " Data |",
> +                               event->read ? " Read |" : " Write |",

Indentations are not matched with the snprintf(mastr line:
		snprintf(flags, 256, "\t%s%s%s%s%s%s\n",
			 event->privileged ? "Priv |" : "Unpriv |",
			 ...

> +                               event->s2 ? "S2|" : "S1|", class_str[event->class],

The previous flags have spaces: " Inst |", " Read |". So, maybe:
			 " S2 |" and " S1 |" here?

> +                               ((event->id == EVT_ID_PERMISSION_FAULT) &&
> +                                (event->class == EVTQ_1_CLASS_TT)) ?
> +                                 (FIELD_GET(EVTQ_1_TT_READ, event->raw[1]) ?
> +                                 "|TTD Read" : "|TTD Write") : "");

I'd try to avoid that nested ternary. Perhaps:
	char ttrnd[32] = {0};
	...
	case EVT_ID_PERMISSION_FAULT:
		if (event->class == EVTQ_1_CLASS_TT) {
			snprintf(ttrnd, 256, "%s",
				 FIELD_GET(EVTQ_1_TT_READ, event->raw[1]) ?
				 " | TTD Read" : " | TTD Write");
		}
		fallthrough;
	case EVT_ID_TRANSLATION_FAULT:
	case EVT_ID_ADDR_SIZE_FAULT:
	case EVT_ID_ACCESS_FAULT:
		snprintf(flags, 256, "\t%s%s%s%s%s%s\n",
			 event->privileged ? "Priv |" : "Unpriv |",
			 event->instruction ? " Inst |" : " Data |",
			 event->read ? " Read |" : " Write |",
			 event->s2 ? " S2 |" : " S1 |",
			 event_class_str[event->class], ttrnd);

> +               snprintf(other, 256, "\tSTAG = %#x Stall = %#x\n",
> +                               event->stag, event->stall);
> +               break;
> +
> +       case EVT_ID_STE_FETCH_FAULT:
> +       case EVT_ID_CD_FETCH_FAULT:
> +       case EVT_ID_VMS_FETCH_FAULT:
> +               snprintf(addrs, 256, "\tFetch address: %#llx\n", event->ipa);
> +               break;
> +       }
> +
> +       dev_err(smmu->dev, "%s%s%s%s%s", title, mastr,
> +               strlen(addrs) ? addrs : "",
> +               strlen(flags) ? flags : "",
> +               strlen(other) ? other : "");

It looks to me that you init-ed them well, so maybe strlen isn't
necessary?

> +
> +       arm_smmu_dump_raw_event(smmu, event);
> +}

I assume these prints would look good, yet, would you please try
triggering a FAULT to give us a showcase in the commit message?

> +static void arm_smmu_get_evt_info(struct arm_smmu_device *smmu, u64 *evt,
> +                                 struct arm_smmu_event *event)
> +{
> +       mutex_lock(&smmu->streams_mutex);
> +       event->master = arm_smmu_find_master(smmu, event->sid);
> +       mutex_unlock(&smmu->streams_mutex);
> +
> +       if (event->master)
> +               event->master_name = dev_name(event->master->dev);
> +       else
> +               event->master_name = "(unassigned sid)";

Likely safer for dev_name to be in the mutex too.

Thanks
Nicolin
