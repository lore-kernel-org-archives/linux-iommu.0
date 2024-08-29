Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0307E15A858
	for <iommu@lists.linux.dev>; Thu, 29 Aug 2024 06:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724913381; cv=fail; b=ISX8FnMHLdLVp3dk9XhCryoeKXyux1NcAmPGkj7/yH27581CNwkC3INbs7A79+8PEwHXQ47lS2ryI+vuqETgYCUl81SvrdRwi4BSjB9m5tkXFqnQOf9p/LBK7jpiWE2St/rkptw0au7yXeRnGOv2WuvTdEYq4Tjzjocmt5rSZAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724913381; c=relaxed/simple;
	bh=0k/vYUl3i0kMkXh7td8iEK004PemMAGQp6juvYw8Mfo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KcJqRTT+kgv12pr0yeIvVcUOhZobqtqLOaYcwlkSrKyu0pOF5YKB13gfCdJ5AoH9CfPaB2ajlhMVFxwONE/wnvbUvoB31dbY48L50ZMg6jhWAC4ZIgH68RYG6+6cvraaAGqoI8EzBy1F4ro+t6evYp0zaszOFA36FT/ybqV10to=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N/krtW3l; arc=fail smtp.client-ip=40.107.93.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N/krtW3l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NCvkOoDXtLexTHHqVR54ohJs7yojhm7rAaiJnuaeOCk3mmIR0gMqAZE7ZWdrOHMRKfPJcERbvRpQgXXi3KpOAygQZt42/YNZ/R529jIe+NhSWCQNbYNr4hTLgGc6CiwA9pCrj23mPuOd+0JC8r1E7xTZV8OAmRlWjeUUXPZ+Bh72Xt4s8C4c+PMKNKhMkiNGDTrUALSwbtfV/NvK73bqemwkYo6W6xJEOwlkuG7T4/7G8UvhHtmHvvyH9fX3y7OveEv4dNN7KbVeLyOnhb//xUZL2AD1fbfMTVUSNyRDKoMkeAJYqhSad4YI5bYw632d1IBOr/nkyBcdWEehgEwaVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QNNWiTkZ/Bhj5DTcRMnf+pGQgFaEHD8JQEnqLJq6SI=;
 b=XGPPNSndShIyK4RAl3rJtUNjt7QnvJOStG8BT8Yl+9oxw5YhODHKGCdd5MSqVLeCsmMxhR5E1VbudslZns5UvEoZnajLD73SokkZtZBAvB2yC8A7HHSvXfW6PNF/XHlMDxOlEAFZNyOhDO/XrYTkv4TAJppz5xcHmMkPrebVuP+XBaJaEvluJ8FlhtrH9fn3w1nRC2kt5fePYqwzRxj+/tG9WUYoePCJ7raQYq9JmGUOJrMCRuXBeZJ0e86fvVnG7bRnxmNfE91tSN4LXsMX7V017mHtEnxv4wED76y3mbeyOHYJDQPPUPLJc/n+R4kpBMWe/DsCvNnLW4niNyzULg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QNNWiTkZ/Bhj5DTcRMnf+pGQgFaEHD8JQEnqLJq6SI=;
 b=N/krtW3lkF739SYn0p/lIYGL4/n6dYR6L8kMuxDe6KgNcF/WFtJU04qojJSow8nUy7cOuApd54oygXf1uOa/+vVee10OZYxCVWpsJGHEZT6wpjLuRfbJhSu9nlIaeTNwu5xYD1yA4tAWzCxZxVwKpFgk+8xMnIvxa6ZNs4GhDDysG+plQNUf0XXoVsNcN0KVAP/AxYdPkbK0qhy7l43LXLFn9jba4LB+Wk4ixL7xgiDSyU3HV1C0acduzvmSUOuaYeGTd8dzY6purGnLZxN2Jf/JggF2knTVajhJ8qqls2kFB3h3zYPFlUXBj4VZ/R8q7dPvq84dVF92ZL/uP3746w==
Received: from DS7PR03CA0068.namprd03.prod.outlook.com (2603:10b6:5:3bb::13)
 by CH3PR12MB9219.namprd12.prod.outlook.com (2603:10b6:610:197::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 06:36:15 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:5:3bb:cafe::d0) by DS7PR03CA0068.outlook.office365.com
 (2603:10b6:5:3bb::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28 via Frontend
 Transport; Thu, 29 Aug 2024 06:36:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 29 Aug 2024 06:36:14 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 28 Aug
 2024 23:36:04 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 28 Aug 2024 23:36:04 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 28 Aug 2024 23:36:03 -0700
Date: Wed, 28 Aug 2024 23:36:02 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Mostafa Saleh <smostafa@google.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Daniel Mentz
	<danielmentz@google.com>
Subject: Re: [PATCH v2 1/2] iommu/arm-smmu-v3: Print better events records
Message-ID: <ZtAW0hVPFD6JbLTL@Asurada-Nvidia>
References: <20240827193026.3993039-1-praan@google.com>
 <20240827193026.3993039-2-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240827193026.3993039-2-praan@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|CH3PR12MB9219:EE_
X-MS-Office365-Filtering-Correlation-Id: 942442b8-27bf-49f4-823f-08dcc7f4e18e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YvPCGLALxd8KMDFUtUfR85gJ3hKcjLunasmsmHP2ozLOAGL60+Q2x4d2tjsJ?=
 =?us-ascii?Q?gFArYQUiJhItl8he1JjCSbuIA8hpOJV1YnVqvhj1ptXHpSrdSCzBryUnezR/?=
 =?us-ascii?Q?L4BtTFfCPxjCHxKPaj3I0O2fZf44dcsDiy1b0Vw5zkqs9wwxa6N9ss8m5fYG?=
 =?us-ascii?Q?Ljx4kFjv1Qk6O7DUPdjLbeR9S3bP/7JMWA0QobIZR+71m4eaDu2BFLipHGVf?=
 =?us-ascii?Q?s2tWVXb9cKZgHwAMLBMqSxg1K8vNR6rAmdeAm+mS5ztP1VCUIfKB8/4xdc1U?=
 =?us-ascii?Q?WKVytX30OWCpv1LYfojBkDZVQIepw0WDolRDLGHSGxrO0lhh+xgoGCAFpqvM?=
 =?us-ascii?Q?pj351fRNoB5/NUPbwnpFAu2hFwAoCP56fBX0d5xGMGi4oVju+d3Cr+FCM2yC?=
 =?us-ascii?Q?TCoC2Vp2UbAneAkl8Wt7LBfhJzZMavlxDK2QRvMjl7PQjetxBZDgX8j4JWO5?=
 =?us-ascii?Q?PKNE82MYaox+jW48VjaMjuJMuE7z2kaH0CP86q5cCMc7lNbG/3XgflOdPJGa?=
 =?us-ascii?Q?cK0WTuSphopeQj7CObk4TTFncvHcrhBHdjYzzX/TUahstADm3dqdAPp0Amol?=
 =?us-ascii?Q?mJMXgp1doJn5BwnlziFnT6RVG68gI/D5jPaESIbrptxMDXxEaf6WcV0OSRJg?=
 =?us-ascii?Q?nXNQD6naXNR4hVukAQ8qgWzqiQTucqh+p3udc8vddCMJB1kp7qWINh45A/ka?=
 =?us-ascii?Q?DIPFvf5I/XRjeeS3k+YXWxhj27dcxSAeQalpW9IgU/K4SGPlTCQDTQNj47ul?=
 =?us-ascii?Q?ygT3PMpObGN7SC/1og3NurD484T8wvOr8bZ3rMFGRzuFIX2ww9VzWwvF/Qm1?=
 =?us-ascii?Q?CfxT0/Vb4Ud5vSKqhlJT7tI+38deEnRk6G8nu/v+3inLWjyZTFAaSQyj8XME?=
 =?us-ascii?Q?+61ODXb3ccNpiwB4vkLNrJ+Vma0j+CJtHBP8B7ky8qnyUeWNoHSgRufzg95O?=
 =?us-ascii?Q?1pQ6YOK4rp//Sk4XvuLtcdPRRHP3Lw59P+zhfgpoyULtSDUL374Lu7nvDM3G?=
 =?us-ascii?Q?H15j6ijXk2WRdh1y7Lfnbkv+C47UyVoZ4w5WKPd7R1XknPiG0C5VgD7h0HBI?=
 =?us-ascii?Q?cWbu1967NJrBimoxkVrj953hWG5yV8Vay8s/GOiNH8Pl3/M7HEoKkbPYeeFe?=
 =?us-ascii?Q?eOLBCUJ6SDODLJmozGpXB2srNdcuCnuTAD4atiLx8+5iO4u9f8TdPLbGF5AV?=
 =?us-ascii?Q?Nojkw/R7hl9WL1JBnW7XhEmj6yPzXP3g7SefOlywUV88p6z4kQpyoXJYy9zw?=
 =?us-ascii?Q?ZR8vLPBz7ADQAku/udIolxrDXRO1cNkDTCG/e9Tlw5h9peuZ5K7QtUdTgf4h?=
 =?us-ascii?Q?TMCrmyS6jGA4W66aBThsPjZ5yX+vWqoAlUu3ie1y6LBjbWgAyDjx/DIuH2Kh?=
 =?us-ascii?Q?G7nexb9O+9dzCQNj/okkBs5r7dNqVYNrD40hIBxKH2enTTbFFVwk1vWDuika?=
 =?us-ascii?Q?pInB7VDpeO+7xWxMQI7agHl/UXMonk4m?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 06:36:14.8522
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 942442b8-27bf-49f4-823f-08dcc7f4e18e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9219

Hi Pranjal,

The prints would be very helpful for debugging. Thanks for the
patch!

I have some personally thoughts here, so hopefully we can make
it cleaner and more readable.

On Tue, Aug 27, 2024 at 12:30:25PM -0700, Pranjal Shrivastava wrote:

> +static const char * const evts[] = {

s/evts/event_str

> +       /* Bad config events */
> +       [EVT_ID_BAD_SID_CONFIG] = "C_BAD_STREAMID",
> +       [EVT_ID_BAD_STE_CONFIG] = "C_BAD_STE",
> +       [EVT_ID_BAD_CD_CONFIG] = "C_BAD_CD",
> +       [EVT_ID_BAD_SSID_CONFIG] = "C_BAD_SUBSTREAMID",
> +       [EVT_ID_STREAM_DISABLED] = "F_STREAM_DISABLED",
> +
> +       /* Bad translation events */
> +       [EVT_ID_TRANSLATION_FAULT] = "F_TRANSLATION",
> +       [EVT_ID_ADDR_SIZE_FAULT] = "F_ADDR_SIZE",
> +       [EVT_ID_ACCESS_FAULT] = "F_ACCESS",
> +       [EVT_ID_PERMISSION_FAULT] = "F_PERMISSION",
> +
> +       /* Bad fetch events */
> +       [EVT_ID_STE_FETCH_FAULT] = "F_STE_FETCH",
> +       [EVT_ID_CD_FETCH_FAULT] = "F_CD_FETCH",
> +       [EVT_ID_VMS_FETCH_FAULT] = "F_VMS_FAULT"
> +};
> +
> +static const char * const class_str[] = {
> +       [0] = "CD",
> +       [1] = "TTD",
> +       [2] = "IN",
> +       [3] = "RES",
> +};

Unlike the event IDs, these class code names are still uneasy to
read. Though it'd result in a print-format change, yet could we
simply dump full strings instead?

> +static void arm_smmu_get_evt_info(struct arm_smmu_device *smmu, u64 *evt,
> +                                 struct arm_smmu_event *event)
> +{
> +       /* Pick out the good stuff */
> +       event->id = FIELD_GET(EVTQ_0_ID, evt[0]);
> +       event->sid = FIELD_GET(EVTQ_0_SID, evt[0]);
> +       event->ssid_valid = evt[0] & EVTQ_0_SSV;
> +       event->ssid = event->ssid_valid ? FIELD_GET(EVTQ_0_SSID, evt[0]) : IOMMU_NO_PASID;
> +       event->class = FIELD_GET(EVTQ_1_CLASS, evt[1]);
> +       event->iova = FIELD_GET(EVTQ_2_ADDR, evt[2]);
> +       event->ipa = FIELD_GET(EVTQ_3_IPA, evt[3]);
> +       event->privileged = FIELD_GET(EVTQ_1_PnU, evt[1]);
> +       event->instruction = FIELD_GET(EVTQ_1_InD, evt[1]);
> +       event->stage = FIELD_GET(EVTQ_1_S2, evt[1]);
> +       event->read = FIELD_GET(EVTQ_1_RnW, evt[1]);
> +       event->raw = evt;

Maybe we could define struct arm_smmu_event in this way:

+struct arm_smmu_event {
+	union {
+		u64 evt[4];
+		struct {
+			/* Bit 0:63 */
+			u64 id : 8;
+			u64 _res0 : 3;
+			u64 ssv : 1;
+			u64 ssid : 20;
+			u64 sid : 32;
+			/* Bit 64:127 */
+			u64 stag : 16;
+			u64 _res1 : 15;
+			u64 stall : 1;
+			u64 _res2 : 1;
+			u64 pnu : 1;
+			u64 ind : 1;
+			u64 rnw : 1;
+			u64 _res3 : 2;
+			u64 nsipa : 1;
+			u64 s2 : 1;
+			u64 class : 2;
+			u64 _res4 : 6;
+			u64 impl_def : 16;
+			/* Bit 128:191 */
+			u64 inputaddr;
+			/* Bit 192:255 */
+			u64 _res5 : 12;
+			u64 ipa : 40;
+			u64 _res6 : 12;
+		} f_trans;
+		/* FIXME Add other event structs */
+	};
+};

Then, event would be just:
+		struct arm_smmu_event *event = (struct arm_smmu_event *)evt;

Not sure if Will would like this though...

> +
> +       mutex_lock(&smmu->streams_mutex);
> +       event->master = arm_smmu_find_master(smmu, event->sid);
> +       mutex_unlock(&smmu->streams_mutex);

Same as I pointed out at the other patch, "master" is unprotected
after the unlock. It can unlikely-yet-still-possibly race against
arm_smmu_release_device.

> +static void arm_smmu_dump_xlation_fault(struct arm_smmu_device *smmu,
> +                                       struct arm_smmu_event *event)
> +{
> +       dev_err(smmu->dev, "Fault: %s client %s sid 0x%08x.0x%05x:\n",

"client" doesn't seem to be used anywhere in this driver, I would:
s/client/master

And it'd feel clearer to have an "ssid". And perhaps adding commas
to separate them too.

> +                       evts[event->id], event->master_name, event->sid, event->ssid);
> +       dev_err(smmu->dev, "\tiova = %#llx ipa = %#llx (%s%s%s%s%s%s)\n", event->iova, event->ipa,
> +                   event->privileged ? "Priv " : "Unpriv ",
> +                   event->instruction ? "Inst " : "Data ",
> +                   event->read ? "Read " : "Write ",
> +                   event->stage ? "S2 " : "S1 ", class_str[event->class],
> +                   ((event->id == EVT_ID_PERMISSION_FAULT) && (event->class == EVTQ_1_CLASS_TT)) ?
> +                   (FIELD_GET(EVTQ_1_TT_READ, event->raw[1]) ? " TTD Read" : " TTD Write")
> +                   : "");

Indentation should follow the existing printk() in this driver. And
those ternary operators at the last field(s?) are hard to ready..

> +static void arm_smmu_dump_fetch_fault(struct arm_smmu_device *smmu,
> +                                     struct arm_smmu_event *event)
> +{
> +       dev_err(smmu->dev, "Bad fetch: %s client %s sid 0x%08x.0x%05x: fetch addr = %#llx\n",
> +                       evts[event->id], event->master_name, event->sid, event->ssid, event->ipa);

Actually, the "Fault", "Bad fetch", and "Bad smmu config" doesn't
feel very necessary, since we prints the event string already.

> +}
> +
> +static void arm_smmu_dump_raw_event(struct arm_smmu_device *smmu,
> +                                   struct arm_smmu_event *event)
> +{
> +       int i;
> +
> +       dev_err(smmu->dev, "event 0x%02x received: client %s:\n", event->id, event->master_name);

Looks like it would print another title that's sorta duplicated to
other dump functions yet less informative?

> +       for (i = 0; i < EVTQ_ENT_DWORDS; ++i)
> +               dev_err(smmu->dev, "\t0x%016llx\n",
> +                        (unsigned long long)event->raw[i]);
> +}
> +
> +static void arm_smmu_dump_event(struct arm_smmu_device *smmu,
> +                                struct arm_smmu_event *event)
> +{
> +       switch (event->id) {
> +       case EVT_ID_BAD_SID_CONFIG:
> +       case EVT_ID_BAD_STE_CONFIG:
> +       case EVT_ID_BAD_SSID_CONFIG:
> +       case EVT_ID_BAD_CD_CONFIG:
> +       case EVT_ID_STREAM_DISABLED:
> +               dev_err(smmu->dev, "Bad smmu config - %s client %s sid 0x%08x.0x%05x\n",
> +                               evts[event->id], event->master_name, event->sid, event->ssid);
> +               break;
> +
> +       case EVT_ID_TRANSLATION_FAULT:
> +       case EVT_ID_ADDR_SIZE_FAULT:
> +       case EVT_ID_ACCESS_FAULT:
> +       case EVT_ID_PERMISSION_FAULT:
> +               arm_smmu_dump_xlation_fault(smmu, event);
> +               break;
> +
> +       case EVT_ID_STE_FETCH_FAULT:
> +       case EVT_ID_CD_FETCH_FAULT:
> +       case EVT_ID_VMS_FETCH_FAULT:
> +               arm_smmu_dump_fetch_fault(smmu, event);
> +               break;
> +       }
> +
> +       arm_smmu_dump_raw_event(smmu, event);

I wonder if something like this would be cleaner:

	...
	char title[256];
	char addrs[256];
	char other[256];
	int i;

	switch () {
	case xxxx:
		/* If duplicated between cases, put them into helpers */
		snprintf(title, 256, "%s: Master %s, sid 0x%08x, ssid 0x%05x\n",
			 event_str(event->id], dev_name(master->dev),
			 event->sid, event->ssid);
		snprintf(addrs, 256, .....);
		snprintf(other, 256, .....);
		break;
	...
	default:
		/* snprintf raw title */
		break;
	}
	if (strlen(title))
		dev_err(smmu->dev, "%s", title);
	if (strlen(addrs))
		dev_err(smmu->dev, "%s", addrs);
	if (strlen(other))
		dev_err(smmu->dev, "%s", other);
	for (i = 0; i < EVTQ_ENT_DWORDS; ++i)
		dev_err(smmu->dev, "\t0x%016llx\n", event->evt[i]);
	...

Thanks
Nicolin
