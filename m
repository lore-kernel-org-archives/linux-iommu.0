Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B360137E
	for <iommu@lists.linux.dev>; Sat, 19 Oct 2024 02:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729303626; cv=fail; b=u0zg3TPBKtymj6ynzHd981n6qrrjmUBJxkbvU2MVutwezlogBxYbP+Lc3iDJXRw+76yvSmXxq4/lpH9IKGK0rqM3YNYIDSi3Y7ztPyeg44QMzZVM4AMJbXJmCXpWkKXdWLyTaSFOmVH4ZrH18vpu33hkJyLCisT9km8JMte9nf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729303626; c=relaxed/simple;
	bh=AsfzeZvzDEi5W0IpMc4EFcy4SBVENuzLm4ptoF8B5CI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pm4WtSjthQtE533Bm/fT/iM9iXwjiHwHIjUgmnLT8ptlPNU4SHDjDGlyRpy4qzFXQbVJ3yLBh+tZoNJQzEcDtApt44SiYE3SefvkB/32JExJgfVJpUIOuTyeJGSG4Dn6MFfSAiqvcPvTEYWQG+vCo31+EbiYbJ/p+CKIgVzZqgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t8eNXrrK; arc=fail smtp.client-ip=40.107.92.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t8eNXrrK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZneY8a8I81kI48zG+WJWDEJERajFEwVdkIe4GK8uXv0EGjUMB6oqmYy/+lMFJxzkOFYdi0RzusmRqUcpLzsEd+FBjJaxRXt1XD68crib6UXtDSYl/3PMWVovok3LR+ZO8DdRDhNRd3+d/acqKnFvVys6j7h294eKHzINuLg7rDEDWhFYkNygeUhptBywa/CXQyyIbjV4DBmsownNKQE8PFH2ZCWZD+7opy0/5m5WcPEEi1tPvJ3+rEqjnASp87jTkTzdtUN2xijoHlMcbEYpmtPZjnrBdrAlZ5+UCebAvjVt6RLzw/buUwGfXSzkQ+UPHjM/7F5A7/dIJWYQ6lKgiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMp6ISGdCm6laath+7femaoxeo1+VW2e/4WOqSHfQvI=;
 b=ZmxGk/4ONG/nn1OIyATwJ521sDBKFJKzbyqN9h/K2pDkQkPn4AN5YHiwZG1VRL809xe7opZbknNNTayE2gFJ3JtOmopQJdixMO/xBMIN+WdqVvvnJiRWF9KLuw1P9EsUJSCF9JuCqTLxTR2x1Za2PU2+178PJtfpHFYXXiYpVD8mquxYem8MdBrowYf+6DeyUAjVbB/wcyErh8gRxYMyguIoPs0z/Giq8Gv/cPP+Nzei2At2WLJRB4ZHAsQKhYbrGwKGycm2cMQ0t9o5JfPiBySfx/MoiG842UU2NZAUoWSh3+SzrF//N7yq37G0+dINB8F7WtL58AzRinffMnNjUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMp6ISGdCm6laath+7femaoxeo1+VW2e/4WOqSHfQvI=;
 b=t8eNXrrKqXE/A2VcvRPPT22YKeJ0SK+Z5z8od6gGjNETwInIWkf2+NCtoCGMFKraA4FTHzX7jJ5OVSNB/N8+RFMkT5do3U9FUkkSxg65vXDVfYObjFbGtyLzE5UmFdXlkkzuWlgbG269E43XD63zcdRNNyEeAODgrXmBOG+f5RpBJPW57F011svgp3upro8nx1STQuJ0F69dgN0XLGhLMBtZlbZdnE//jlr5v8HpvQmMBuu4DnvV/jPdn8KATv05y4++w+Xbn0VGz7HJEcc44KSHF5OCELS44OHlsOZjyIYsLr0zgIp8yesuT4Z8hR1qvjxcZiJS/VVaRNeM9NCleQ==
Received: from MN2PR05CA0057.namprd05.prod.outlook.com (2603:10b6:208:236::26)
 by PH8PR12MB6937.namprd12.prod.outlook.com (2603:10b6:510:1bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Sat, 19 Oct
 2024 02:06:58 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::21) by MN2PR05CA0057.outlook.office365.com
 (2603:10b6:208:236::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.11 via Frontend
 Transport; Sat, 19 Oct 2024 02:06:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Sat, 19 Oct 2024 02:06:58 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 18 Oct
 2024 19:06:51 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 18 Oct 2024 19:06:51 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 18 Oct 2024 19:06:50 -0700
Date: Fri, 18 Oct 2024 19:06:49 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Mostafa Saleh <smostafa@google.com>,
	<iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 2/3] iommu/arm-smmu-v3: Log better event records
Message-ID: <ZxMUOfH7GoY71FxD@Asurada-Nvidia>
References: <20241018180022.807928-1-praan@google.com>
 <20241018180022.807928-3-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241018180022.807928-3-praan@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|PH8PR12MB6937:EE_
X-MS-Office365-Filtering-Correlation-Id: 8835ffca-ea68-4ecb-9b52-08dcefe2b66a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vxVCgnqg9CTF/stljAqfsNPFXxCwpNqb/x1A8SZsBTsqB6f438ihxLDuQMIb?=
 =?us-ascii?Q?vbZluB4JEKMOnOJ1TNlC4XKxrd8FvV5YSwlBELOODSGnm8BYiXwq3GxFRPmo?=
 =?us-ascii?Q?4t6C4NhjqNf6GtOKdBAl6HwPEQhE/X4TJTga2IOPXwqtss2ecCPCCYkH/e5Q?=
 =?us-ascii?Q?jMrlFI0D9+AEMvL/efeGqSfbeyMxfdY6DVeoIJyVwJ8vhMUaiycL78ixz/6Q?=
 =?us-ascii?Q?WUAguEQSH9KDVxL5abmF+8jgLndnkgofKK9DI9Pp+c/b1PeJ4v6VbXV7/Awe?=
 =?us-ascii?Q?I63GbLUPqjrH4sVb18DzYcZSLjmUP5B2Xf+cCscR9C7HuPSvU4fjb8apO4xt?=
 =?us-ascii?Q?mmmuCWpw0nr7gQUcEfeTwGPZ1y8C1cZ5kzM107l2xYuwuF+k2/AUJOiW15/Q?=
 =?us-ascii?Q?w3+0RWoJJs9xltymGbabAOhfN1g4BjMbwSP/WRY58Cj8WqPMiYiCGPTeG83c?=
 =?us-ascii?Q?EAE6z42eov400w6S5Yzt1erlRYwT8D+CfEjakiucPvQgte20sftUfXUfExY+?=
 =?us-ascii?Q?RJeWMtTCrJoxi+Dpz9avFnyNRES4RaNK1ZP6isqBnl3ju4q1UbhPMObGJfd3?=
 =?us-ascii?Q?/9c2vHvH1iA78Tb5nYkp13Rc+8ENvBSJdmrCSjViLgSI6djWZ00MMHJOfspN?=
 =?us-ascii?Q?HzbcZGyRHyTJLsB2p25VzRt93qKmHXMObB9nVs5WRHEBxJVNAVZlwuNMBkWa?=
 =?us-ascii?Q?4XCyKTDm96A0iWoCp4LE5b3UdOjCvsZXhfcVR3fi/sZEDAcQMVMHGOagBsjM?=
 =?us-ascii?Q?UA+uMdVYeFxtf1KbkSd69pw0E0biSk4bGuJfuZwxA++kGyYAc4dS4qf1Dald?=
 =?us-ascii?Q?lJ6U8XqeNJxOZSlx5mOYL81+Bn/sm0iLDpqb6dxGIXtGTtWkVdJ376tn5L3m?=
 =?us-ascii?Q?uliEMfYg0JJ4xUNmyD5UNh279Fz46LyfGXGY+6nhvdNQkvGiydvJ339EcCs4?=
 =?us-ascii?Q?2siImwOG5XD+NnhjvDYec/ENW/8kdbazEwK/HL/FztkrMN+U/sUd3lJXtXd2?=
 =?us-ascii?Q?gVxo73fN6JosqgU2yJL22vVUlOJy+wWgMIdrJM+DyAPiuta/92CF5zcue3WM?=
 =?us-ascii?Q?+uY2KhL17t7jg87qhInpeNeayvMcjO7KO6Hh/KFBUv5ELdpTAMI90N0ZY/R7?=
 =?us-ascii?Q?E6r4AH5fX/mR7ocE9vfsMjtDqsyJLvmRzm/qe9II7YH7TOnGeIroHVFEIQgo?=
 =?us-ascii?Q?v2hMaV5861jWRBVoKK5LGQ5doUmnkRoexkjWWj6LPocU/6OExImoIXHmtOKI?=
 =?us-ascii?Q?xS7st/5cZrO3MxlhK3ujDUrEKcO55zw65ciZ/IvbrWo4rtVd8Fxghlh2ETg7?=
 =?us-ascii?Q?kisYNws/H9By2b0OTle5g0xlXRLdq2vVP1SPw+1BgvEtcYexowp2tVHD9joe?=
 =?us-ascii?Q?RknkvGsZcC9P997uoY+RXwSMc3ZqM5TWGWmGkQS0BaUv0LezEg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2024 02:06:58.0448
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8835ffca-ea68-4ecb-9b52-08dcefe2b66a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6937

On Fri, Oct 18, 2024 at 06:00:21PM +0000, Pranjal Shrivastava wrote:
> +static void arm_smmu_dump_event(struct arm_smmu_event *evt, struct ratelimit_state *rs)
> +{
> +       struct arm_smmu_device *smmu = evt->smmu;
> +       char title[100] = {0};
> +       char mastr[100] = {0};
> +       char addrs[100] = {0};
> +       char flags[100] = {0};
> +       char other[50] = {0};
> +
> +       if (!__ratelimit(rs))
> +               return;
> +
> +       snprintf(title, 100, "Unexpected event received: %s\n", event_str[evt->id]);
> +       snprintf(mastr, 100, "\tmaster: %s sid: 0x%08x.0x%05x\n",
> +                evt->master_name, evt->sid, evt->ssid);

Likely I mentioned in the cover-letter, maybe "sid.ssid:"?

> +       switch (evt->id) {
> +       case EVT_ID_TRANSLATION_FAULT:
> +       case EVT_ID_ADDR_SIZE_FAULT:
> +       case EVT_ID_ACCESS_FAULT:
> +       case EVT_ID_PERMISSION_FAULT:
> +               snprintf(addrs, 100, "\tiova = %#llx ipa = %#llx\n", evt->iova, evt->ipa);
> +               snprintf(other, 50, "\tSTAG = %#x Stall = %#x\n", evt->stag, evt->stall);
> +               snprintf(flags, 100, "\t%s%s%s%s%s%s\n",
> +                        evt->privileged ? "Priv | " : "Unpriv | ",
> +                        evt->instruction ? "Inst | " : "Data | ",
> +                        evt->read ? "Read | " : "Write | ",
> +                        evt->s2 ? "S2 | " : "S1 | ", event_class_str[evt->class],
> +                        evt->ttrnw_valid ? (evt->ttrnw ? "| TTD Read" : "| TTD Write") : "");

Should the last one be "TTD Read |" : "TTD Write|"?
Otherwise, it would be "S2 || TTD Read" combined.

>  static void arm_smmu_get_event_from_raw(struct arm_smmu_device *smmu,
>                                         struct arm_smmu_event *event)
>  {
> +       struct arm_smmu_master *master;
> +
>         /* Pick out the good stuff */
>         event->id = FIELD_GET(EVTQ_0_ID, event->raw[0]);
>         event->sid = FIELD_GET(EVTQ_0_SID, event->raw[0]);
> @@ -1833,12 +1917,24 @@ static void arm_smmu_get_event_from_raw(struct arm_smmu_device *smmu,
>         event->class = FIELD_GET(EVTQ_1_CLASS, event->raw[1]);
>         event->iova = FIELD_GET(EVTQ_2_ADDR, event->raw[2]);
>         event->ipa = FIELD_GET(EVTQ_3_IPA, event->raw[3]);
> +       event->ttrnw = FIELD_GET(EVTQ_1_TT_READ, event->raw[1]);
> +       event->ttrnw_valid = false;
>         event->smmu = smmu;
> +       event->dev = NULL;
> +
> +       if (event->id == EVT_ID_PERMISSION_FAULT)
> +               event->ttrnw_valid = (event->class == EVTQ_1_CLASS_TT);
> +
> +       mutex_lock(&smmu->streams_mutex);
> +       master = arm_smmu_find_master(smmu, event->sid);
> +       if (master)
> +               event->dev = get_device(master->dev);

Here, get_device is called upon a valid master...

>  static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
>  {
> -       int i, ret;
>         struct arm_smmu_event evt;
>         struct arm_smmu_device *smmu = dev;
>         struct arm_smmu_queue *q = &smmu->evtq.q;
> @@ -1850,15 +1946,10 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
>                 while (!queue_remove_raw(q, evt.raw)) {
> 
>                         arm_smmu_get_event_from_raw(smmu, &evt);
> -                       ret = arm_smmu_handle_evt(&evt);
> -                       if (!ret || !__ratelimit(&rs))
> -                               continue;
> -
> -                       dev_info(smmu->dev, "event 0x%02x received:\n", evt.id);
> -                       for (i = 0; i < EVTQ_ENT_DWORDS; ++i)
> -                               dev_info(smmu->dev, "\t0x%016llx\n",
> -                                       (unsigned long long)evt.raw[i]);
> +                       if (arm_smmu_handle_evt(&evt))
> +                               arm_smmu_dump_event(&evt, &rs);
> 
> +                       put_device(evt.dev);

then, here it puts unconditionally.

Maybe we do need a memset(0) to the event, then here
			if (evet.dev)
				put_device(evt.dev);

Thanks
Nicolin
