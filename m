Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6116279F4
	for <iommu@lists.linux.dev>; Fri, 30 Aug 2024 01:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724982379; cv=fail; b=lMslSryI8WK6fmOTIera3itYSFF3YoMN9cAW2iU82bLEf2Zbtr0l/sLTsBsMSGViw+FzI5vV13JB/U9JjlBFvCFmeq1b4NR5PihigOyGhdFBgpjyC8zX2ob/asQBMBlHRR/wLawFOMoIfKQCZMhf4rx1WMnqkNuL6azdUIl9Luo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724982379; c=relaxed/simple;
	bh=aePcsJc8HUE7pMmcMy8htZWrmIfAvxScTF4DSnrX9v8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J2Di1oxkZcXRCGMlVtGbOYwS1Rom3PY++Skq9XWgsrs4T/hHTA3rypVQneLVaacT5b13+PjKnEhid5AtXcFFkgyDp8MFRAZV5PNjAmYUl7xcRV+np4ZnkKL9an8GLKllnD8IvxCl52Qm4kx9Y5F1xLzGcAWEoMDFvweWzBTfTfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CI9iQCDB; arc=fail smtp.client-ip=40.107.237.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CI9iQCDB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BanSPWcNJaQHMZdgUSrjmZKNc6cV9AbOtNDbysunYl5Kg0s7kLCJbYUAFMYEykXXfjcEjjBK9W9tK/ptUKHJlyUdo1nM/1vWV4XCedpQZBIF7OZibTmP8AcbBaVxSLE0G8zhtlQ48krDbyuKqcMQoHXgZvLehIlN/lzc137tdPDeRHKJ/S+3IbpYB4Mjj6ZwKTgyDLeNbesjHalPMFll6bUKxzQZuCVDGOWhHzwJmJ4klJjGTbOfs4t73n1mGb/8bQGjs2zv+D9uU5f3VGTfh83PCk0MrIb1RzSbLW5v56ANs+p1YQ0THxjAGbg0e/AGVb6EFg3EiVFqwoihN7gF5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zl2uUCl8cLpjM3JorUBanPkd1Soqu5tmEw4wY+NGfh4=;
 b=dl2UcmnY97eONL2TdabHFCdCgXi6+6zaoGANluNMplbGAbViCn8v2qG+otLMx0nHwmFK6eJaCdZDJZR6EkMaInpKotUfNTakG/OTHHhTsODvtbxy2BnzZoxK8ZvK2rXdlKNmA3U/rbpTKW3mgDa/au3hMpUVIeaLgdoTtUWv9u1HLgac+8seSpAQUsjvZlB1WQ54iiRTjxamUAmwl7dWEL0ZGC1NDCTBF77LHln3caGLaXXYEFze8DtKmijLmGDpqAmdqosZlObQNE80Pfhe3xfVLrbYPxWvJqaiiWj07y/kjId9Q+MAeqmOwKQIA3zaax+2HHoz6WhSsxBcvsTIMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zl2uUCl8cLpjM3JorUBanPkd1Soqu5tmEw4wY+NGfh4=;
 b=CI9iQCDBCR9Quig5de5ICfOgR4z8mi24i6qklRdUq+iw2to5gjR+tRTJis0c3lJEqgXv6pXxvJ+xxKCTOkXdcHT+DflwisAHhGk0wwSnzVw4DdjxnHtQI4SKd59ZpEX5+b4+9XHDjEZDy2blISBStA7tvNX+vc8ZW42JCz6hOqo0ztcj4KeWvvc4u8L0ARKVIt6aLKNCPX6yU+UBQk4lm9VTjpFVd8IYpAxBlKpH6qq2mv8ODbMurvSlhhacj4iD8GheuyhH17UQhwwW34l3tNfRZdC+LTEIMbb95fC33Nnp7uYZRVl7jL4YlP1oqxzOWW4bMkAY7vRSF9IHST5jIw==
Received: from IA1P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:464::11)
 by IA0PR12MB8931.namprd12.prod.outlook.com (2603:10b6:208:48a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Fri, 30 Aug
 2024 01:46:11 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:208:464:cafe::18) by IA1P220CA0022.outlook.office365.com
 (2603:10b6:208:464::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20 via Frontend
 Transport; Fri, 30 Aug 2024 01:46:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Fri, 30 Aug 2024 01:46:11 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 29 Aug
 2024 18:45:56 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 29 Aug
 2024 18:45:55 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 29 Aug 2024 18:45:55 -0700
Date: Thu, 29 Aug 2024 18:45:53 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Mostafa Saleh <smostafa@google.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Daniel Mentz
	<danielmentz@google.com>
Subject: Re: [PATCH v2 1/2] iommu/arm-smmu-v3: Print better events records
Message-ID: <ZtEkUQ7tI3Nb0NOc@Asurada-Nvidia>
References: <20240827193026.3993039-1-praan@google.com>
 <20240827193026.3993039-2-praan@google.com>
 <ZtAW0hVPFD6JbLTL@Asurada-Nvidia>
 <ZtEKMknbGaD9q170@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZtEKMknbGaD9q170@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|IA0PR12MB8931:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ce6b89c-e4fa-4d9b-0cde-08dcc89586aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/TaiMYLaHaYu1eGR1s4++eL6FQXeTCVnmF9AD2mgnjWl6YGrP7SiMCO75rEK?=
 =?us-ascii?Q?TYAe7M11IJphllcfg4dYbVQ2W87ajkYEK7KAOfCMtXTUqhrcmBGgs98UQ3Zi?=
 =?us-ascii?Q?BlYV5Fgf0w+s8RlcfPr6Z8D1NIGZtjXd6V/6I9RoxrH8GzSs8zzvjADd01Rq?=
 =?us-ascii?Q?3kHUoT5hPEPPPcvCVqVmQgN+OSqNsE/Wpk/3qH7pX4LA0Z/6rSb38MwDWf+L?=
 =?us-ascii?Q?SUuTa/Mh9+5osoNPA7DHtZKEWvzan/5DCzbvkF/HfXkDs2G7JsvypoWbAMyp?=
 =?us-ascii?Q?jA8owO1iDlUn+tlLFTz9PJ3SlSdaYSQZzwb16bwjI3pvf5y1pvgCmLnNHJXE?=
 =?us-ascii?Q?PaseRP1h5C9lyQBmauyEz2qdgJYjxnWl/kdKvyd0gcYr04e46j1Xu/8AW7ub?=
 =?us-ascii?Q?RCDvB/XiDF4BXyy16DCt0O2WURtu2ABkjw6HjclZxxFlhSK4qSURtsb8te7s?=
 =?us-ascii?Q?Nyrk55RCO7NTV3gLZhQVRk/Va1lgj+yH1lIQXqmEIEt5BG2WsmWTlC2acRJt?=
 =?us-ascii?Q?VFEJz51ybp9WwmuV5SvnRdx7QSo0MRSIKPvMa4srx4FDXgG9xdw2VY9i2Eyo?=
 =?us-ascii?Q?oJRcKcy0TackDav97xWSUv7cMouZ4KdGDzJkkAJV0sm2SZ91wqx3VrnxYLlO?=
 =?us-ascii?Q?uWR0TbB2GUFQ3FtKNXyLLIvLzZB8RyA3MbsNhYi6YUVjRTV6Bs145DpfCESb?=
 =?us-ascii?Q?36tWNgMB5uw3fq6LAoo6dEdWLxvf+LjgVnaqZcVIrM4St96NBrYGItvj7k2S?=
 =?us-ascii?Q?g9XQcw1bGxddxdrZDShijzdulBDJeBPOeWj7YLiapwx+mGH9BAXAT839D9v6?=
 =?us-ascii?Q?XaqKnyA5PZHeY84YBkyi4wZumPLEosj6+GTs7vc6AuMKTCu/YPqutCqC/2Nl?=
 =?us-ascii?Q?GX27URX5N7dak4xQ06sD3CVG2hS4bFjq3+57OxZwOifuhg8LPP9GDfAiCI7y?=
 =?us-ascii?Q?mxsBcLSKGCXMRi1Lj63EU39Aau1e7NI3pCq0QZjBUD4nI67Kakb/zipVUyjC?=
 =?us-ascii?Q?PnpHOuafrG32Al6ucBhRIZNuaSeqMaVSjWWHz/TwVxQKTQsIvwVmDVmmSDc+?=
 =?us-ascii?Q?w6vaEgWxABV7bfZoPvo+boafgoxKnJjIpsGQ1DflgPITObMGFoLxnB3ehU5/?=
 =?us-ascii?Q?b6pGtrj+0kO4LxKtdT5ht1F/0I66udK3nmYKem4p/GV0YIgTz1NY4LzMTT4p?=
 =?us-ascii?Q?7Hb2dORe1Ey0znAyxo2QVDjbeJwYtKhgGNzX9BIFnf+p2iBfphjccDEdhVZA?=
 =?us-ascii?Q?j4d0CUQVQBgRV+oARkjFyICRQ0zjqB5UQ6q+G+Ui2DB0zKT986S35av8JyLX?=
 =?us-ascii?Q?rZbwwMmae7O9PAb+02Z/X0gD5X54kYmDHmmQIi4KbJHD2YrvOyecaOibIkHd?=
 =?us-ascii?Q?ESPOqBeGqIhhRQq5M7VQW3HGHa1kN+zJb/0NDsh9cKIlpisKgTglJ97Z0Jvu?=
 =?us-ascii?Q?BRU58r3Dki9rwgsd5kC5MFEdeH9hg6hS?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 01:46:11.2710
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce6b89c-e4fa-4d9b-0cde-08dcc89586aa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8931

On Thu, Aug 29, 2024 at 11:54:26PM +0000, Pranjal Shrivastava wrote:

> > > +static const char * const class_str[] = {
> > > +       [0] = "CD",
> > > +       [1] = "TTD",
> > > +       [2] = "IN",
> > > +       [3] = "RES",
> > > +};
> >
> > Unlike the event IDs, these class code names are still uneasy to
> > read. Though it'd result in a print-format change, yet could we
> > simply dump full strings instead?
> >
> 
> By "full strings" do you mean "CD => CD Fetch" as mentioned in the spec?

Yes.

> > > +static void arm_smmu_get_evt_info(struct arm_smmu_device *smmu, u64 *evt,
> > > +                                 struct arm_smmu_event *event)
> > > +{
> > > +       /* Pick out the good stuff */
> > > +       event->id = FIELD_GET(EVTQ_0_ID, evt[0]);
> > > +       event->sid = FIELD_GET(EVTQ_0_SID, evt[0]);
> > > +       event->ssid_valid = evt[0] & EVTQ_0_SSV;
> > > +       event->ssid = event->ssid_valid ? FIELD_GET(EVTQ_0_SSID, evt[0]) : IOMMU_NO_PASID;
> > > +       event->class = FIELD_GET(EVTQ_1_CLASS, evt[1]);
> > > +       event->iova = FIELD_GET(EVTQ_2_ADDR, evt[2]);
> > > +       event->ipa = FIELD_GET(EVTQ_3_IPA, evt[3]);
> > > +       event->privileged = FIELD_GET(EVTQ_1_PnU, evt[1]);
> > > +       event->instruction = FIELD_GET(EVTQ_1_InD, evt[1]);
> > > +       event->stage = FIELD_GET(EVTQ_1_S2, evt[1]);
> > > +       event->read = FIELD_GET(EVTQ_1_RnW, evt[1]);
> > > +       event->raw = evt;
> >
> > Maybe we could define struct arm_smmu_event in this way:
> >
> > +struct arm_smmu_event {
> > +     union {
> > +             u64 evt[4];
> > +             struct {
> > +                     /* Bit 0:63 */
> > +                     u64 id : 8;
> > +                     u64 _res0 : 3;
> > +                     u64 ssv : 1;
> > +                     u64 ssid : 20;
> > +                     u64 sid : 32;
> > +                     /* Bit 64:127 */
> > +                     u64 stag : 16;
> > +                     u64 _res1 : 15;
> > +                     u64 stall : 1;
> > +                     u64 _res2 : 1;
> > +                     u64 pnu : 1;
> > +                     u64 ind : 1;
> > +                     u64 rnw : 1;
> > +                     u64 _res3 : 2;
> > +                     u64 nsipa : 1;
> > +                     u64 s2 : 1;
> > +                     u64 class : 2;
> > +                     u64 _res4 : 6;
> > +                     u64 impl_def : 16;
> > +                     /* Bit 128:191 */
> > +                     u64 inputaddr;
> > +                     /* Bit 192:255 */
> > +                     u64 _res5 : 12;
> > +                     u64 ipa : 40;
> > +                     u64 _res6 : 12;
> > +             } f_trans;
> > +             /* FIXME Add other event structs */
> > +     };
> > +};
> >
> > Then, event would be just:
> > +             struct arm_smmu_event *event = (struct arm_smmu_event *)evt;
> >
> > Not sure if Will would like this though...
> 
> Yea, I thought about this too but I felt that it'd bloat up the code
> for every new event that's introduced.

That'd be in the header. The IRQ Handler would be always clean
and fast.

> Also, the printing would become
> more complicated as we'd have to log different fields for different
> events. Additionally, I don't see that many unions being defined
> elsewhere in the kernel.

OK. That's a fair point. I think we could have just one common
union for the "good stuff" fields. Then, if something isn't in
the common union, do a FIELD_GET(raw)?

> > > +       mutex_lock(&smmu->streams_mutex);
> > > +       event->master = arm_smmu_find_master(smmu, event->sid);
> > > +       mutex_unlock(&smmu->streams_mutex);
> >
> > Same as I pointed out at the other patch, "master" is unprotected
> > after the unlock. It can unlikely-yet-still-possibly race against
> > arm_smmu_release_device.
> >
> 
> Hmm.. are you suggesting that the `master` could've been removed by the
> arm_smmu_release_device while we access it in an event handler?
> 
> As in, something like the following situation:
> 
> 1. The evtq_thread gets scheduled
> 2. arm_smmu_release_device removes the `master` & its streams
> 3. In the `handle_evt` we dereference `master` which has been `kfree`ed
>    (also, we don't return -EINVAL like we ideally should)
> 
> In that case, I think I should add back the `arm_smmu_find_master` to
> the `arm_smmu_handle_evt` along with the locks. Nice catch! :)

Probably could lock the entire iteration, master pointer could
be then passed in safely between the helper functions.

> > And it'd feel clearer to have an "ssid". And perhaps adding commas
> > to separate them too.
> 
> I referred to the log in `arm_smmu_handle_ppr` for the sid.ssid format.
> If we'd prefer a separate "ssid", should we change the one in ppr too?
> LMK, what you and Will think about that?

Didn't realize arm_smmu_handle_ppr does that. It's fine to keep
the format in that way then.

> > > +                       evts[event->id], event->master_name, event->sid, event->ssid);
> > > +       dev_err(smmu->dev, "\tiova = %#llx ipa = %#llx (%s%s%s%s%s%s)\n", event->iova, event->ipa,
> > > +                   event->privileged ? "Priv " : "Unpriv ",
> > > +                   event->instruction ? "Inst " : "Data ",
> > > +                   event->read ? "Read " : "Write ",
> > > +                   event->stage ? "S2 " : "S1 ", class_str[event->class],
> > > +                   ((event->id == EVT_ID_PERMISSION_FAULT) && (event->class == EVTQ_1_CLASS_TT)) ?
> > > +                   (FIELD_GET(EVTQ_1_TT_READ, event->raw[1]) ? " TTD Read" : " TTD Write")
> > > +                   : "");
> >
> > Indentation should follow the existing printk() in this driver. And
> 
> I'm sorry but I'm not sure if I understand what is meant by "the
> existing printk indentation in this driver", do you mean aligning the
> next line with the opening brace? For example:
> 
>         dev_err(smmu->dev,
>                 "failed to allocate queue (0x%zx
>                 bytes) for %s\n",
>                 qsz, name);

Yea, just to keep the same coding style, line wrapping can still
happen to 80 characters in general though.

> > those ternary operators at the last field(s?) are hard to ready..
> >
> 
> Hmm, I wanted the last fields to be printed only when the fault was
> F_PERMISSION, in the same log. Any suggestions on what might make it
> easier to read? Some helpful comments around it? Something else?

With an "other" string, we could sprintf on conditions inside the
"case F_PERMISSION:".

> > > +static void arm_smmu_dump_fetch_fault(struct arm_smmu_device *smmu,
> > > +                                     struct arm_smmu_event *event)
> > > +{
> > > +       dev_err(smmu->dev, "Bad fetch: %s client %s sid 0x%08x.0x%05x: fetch addr = %#llx\n",
> > > +                       evts[event->id], event->master_name, event->sid, event->ssid, event->ipa);
> >
> > Actually, the "Fault", "Bad fetch", and "Bad smmu config" doesn't
> > feel very necessary, since we prints the event string already.
> >
> 
> That makes sense, I'll remove those in a follow up patch.
> Although, I guess we should still say "fault" somewhere to hint folks
> without arm-smmu-v3 knowledge that the event wasn't normal operation.
> 
> LMK what you think? I've had a few interactions where clients tend to
> ignore the current "event received" dump considering that to be a part
> of normal SMMU operation.

Well, we could improve the event_str with human-readable ones:
	s/F_TRANSLATION/Translation\ Fault

> > > +}
> > > +
> > > +static void arm_smmu_dump_raw_event(struct arm_smmu_device *smmu,
> > > +                                   struct arm_smmu_event *event)
> > > +{
> > > +       int i;
> > > +
> > > +       dev_err(smmu->dev, "event 0x%02x received: client %s:\n", event->id, event->master_name);
> >
> > Looks like it would print another title that's sorta duplicated to
> > other dump functions yet less informative?
> >
> 
> Yea, I didn't wanna break backward compatibility, people might have
> tools to parse out the existing dump, lol!
>
> On a serious note, I believe it'd be better to print this as some
> implmentations might have some "IMPLEMENTATION DEFINED" fields which
> people might be interested to look at.
> 
> Although, we can dump the raw event only in the `default` case, i.e.
> when we don't have a dumper function for that particular event ID but
> that might still avoid printing the IMPL_DEFINED fields in fetch faults

Makes sense to me by having a different title for the default case.

> > > +       for (i = 0; i < EVTQ_ENT_DWORDS; ++i)
> > > +               dev_err(smmu->dev, "\t0x%016llx\n",
> > > +                        (unsigned long long)event->raw[i]);
> > > +}
> > > +
> > > +static void arm_smmu_dump_event(struct arm_smmu_device *smmu,
> > > +    
> 
> I thought about something similar as well, but then referred to Robin's
> comments on [1]. Also, printing strings in 3 different `dev_err` logs
> could result in interruptions from other logs in dmesg, I'd prefer to

Ack.

> see the entire log in a single `dev_err` for ease. Although, I think we
> should be able to do something like the following to achieve that:
>         ...
> 
>         dev_err(%s %s %s, strlen(title) ? title : ""
>                 strlen(addrs) ? addrs : ""
>                 strlen(other) ? other : ""

That is fine, though should break the lines too. Maybe:
	dev_err(smmu->dev, "%s%s%s%s%s\n", title,
		strlen(addrs) ? "\n" : "", addrs,
		strlen(other) ? "\n" : "", other);
?

> 
>         for (i = 0; i < EVTQ_ENT_DWORDS; ++i)
>                 dev_err(smmu->dev, "\t0x%016llx\n", event->evt[i]);

Maybe merge the four dev_err iterations too?

Nicolin
