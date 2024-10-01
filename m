Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82521CF29B
	for <iommu@lists.linux.dev>; Tue,  1 Oct 2024 23:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727823615; cv=fail; b=MmEwyCrlP+yXWFPZcwj6Hvq1t5gmEVfXIUngm1bVFsf0Vckz1R2CaanAm95kkRtnT2VmNxo0Grc7DMab+1eRi1uwetPHoopbvDQSwvUuX1xiY4knmBRyGmqPV0Rb37iz3v+UqiwZHzakuARI+be/Zd8oJJNzv7ln00jP0HQwTdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727823615; c=relaxed/simple;
	bh=RVGlQH4UJFWRt//X5JDtwbG1hN4S8xkWtVvcx/ZmKko=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUiW5VfWiLjtwRKETV+wWbU+YTWbCMG+e9QJ69XZDtnvzO5p3yMZzs3mVs66xd6EYEoO25Ke+7akpPXyeewkrSfg6jDHzTxHgmBejuns7b9msuDV3GpWIuq8LMHYzBriWJD6YwA4tBh/DjGyMFyj3HqYwhROHHQhNjoeop6MMg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PID4vSxN; arc=fail smtp.client-ip=40.107.93.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PID4vSxN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sTZOMr5fRNUM4ZByvWSaPhfomahJX2hZhITrMUvKtRjwttU45G//A3Plp3tvh+flPKKmG+hJzlVsXA52DelvIBNcmuOvQ2YWCAOrcKV04PxF73Yn44Nie0g8/VfD6/QRF4/HPXGD4HJVsYMFdsHTBMuFr28VRH+4hmVOk1JUq9IXjZnhXnHx6D/OgF1ocYBx/lPFMUFLLQb/MxKJRjTbKNGPv24xyqVAF75uM36XCHsysHqzVeOjj4LTIlfyLh3ZgrGSJboz9Kw+FKgBjpC9+IsL1JRC0ZyAWyd8MVwoat+KOlQ+fdbQzmuTrkn+g48NBWelPjHksgTmf5ndv9/R9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3sOulxCI8dthr1Y6JLzB9avx2RqHYIEZALFMiHM4TMY=;
 b=xJoP6jihdDqLn29mzeRaF6PahimO7CywK5jTj6ZQKsbFYyCAVUOOK+D80fBCqqFlN9aAUT8AXDNCHrtsBvIxnEUtP/9CEZgOVK6PF3IKUx63FGJ4I+YMeSUBxiTq5BZeSUkaql+vrnXmv5UWiszAUMl0x3etua0bWhweFfECnG27KekkmmskEqRH5+vmlKWEhDxExYLnXr//gOQilUFwthazkG6A32OsR+eniBIlNaTp/5iBvlCVTcQfw04qfyCOxM2fWA7uyURZoftE+s8NmUOTjEPzNcc3DrRqHwgF4Kzn08aFv/NFMj3Whn2Vg7nqbF7lMgcYnYe/Yu8oX6+hvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3sOulxCI8dthr1Y6JLzB9avx2RqHYIEZALFMiHM4TMY=;
 b=PID4vSxN32wOYsQReAm+VqRlQCCnMB50U59Ge2MN68pV3bavGpx1CKIAZ1ytunNczCI+54MKdUo9i7ujJqW3Kd+UySUqeqMpBhM1TGhVaxwAF3wgX1rWzIxCA3jqKuvu040DAxvRppXZZj1ryRLKtebVonVGfO2p4De3CrffCbU6WdRLvq1VXrEXwG2Y+rOi5YP+CPuIG/WWyrAS5YGEDAA1BqjHUTnT9IQ7orQuZ8E+39S3t+9On6VObRZcLCz1kjvIzC2wDWkMTf4m3ln56tvSo5oHPmKe0LLgcdfxtgpBG5OGoBI6l0EhSfWoHItHNfxyoNj3CjfRjexhsHuufQ==
Received: from BY5PR03CA0004.namprd03.prod.outlook.com (2603:10b6:a03:1e0::14)
 by IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Tue, 1 Oct
 2024 23:00:06 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::f5) by BY5PR03CA0004.outlook.office365.com
 (2603:10b6:a03:1e0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15 via Frontend
 Transport; Tue, 1 Oct 2024 23:00:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 23:00:05 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 1 Oct 2024
 15:59:56 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 1 Oct 2024
 15:59:56 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 1 Oct 2024 15:59:55 -0700
Date: Tue, 1 Oct 2024 15:59:54 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Mostafa Saleh <smostafa@google.com>,
	<iommu@lists.linux.dev>
Subject: Re: [PATCH v3 2/2] iommu/arm-smmu-v3: Adopt arm_smmu_event in
 handlers
Message-ID: <Zvx+6qBY3og8lRWe@Asurada-Nvidia>
References: <20240928005143.2378938-1-praan@google.com>
 <20240928005143.2378938-3-praan@google.com>
 <Zvr8xUEHNg1GiA8V@Asurada-Nvidia>
 <ZvxjcpQCFM5SU9P-@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZvxjcpQCFM5SU9P-@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|IA0PR12MB8374:EE_
X-MS-Office365-Filtering-Correlation-Id: a06cf120-f4b2-4e6e-119c-08dce26cca6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RPNOjFRbh+8Hy1rZZ5jwfn8evu1sjFm624/PkNV5AxWHWGdWVSSYDK8uQEFx?=
 =?us-ascii?Q?ZAfiS1re3Of02I+egTwvinR4ZYwP1nYIi5hIhXa5+u8sNiasKg3zVpJceNIy?=
 =?us-ascii?Q?RKDl+M4BI8/lVse8c45J078eRj43X3+fxFTfNZVvOUy55KWUBqMLN1Mts3Rs?=
 =?us-ascii?Q?/7J/MNnrZhuPIo8En/JAQy9J6ZB5uPiSgC+dF5tcnDFeWMEDcI1TRfZF61zQ?=
 =?us-ascii?Q?5Gpf8AOmZP2IwnVJsQbPo8OVXy5WdPpdNbxty/0nF1W0kN5URST7quWbGk3h?=
 =?us-ascii?Q?zeQ1jppWQxYqWX7oAbNUEv4r8Z4YPPnWSCbJxJiBbZ52ihr87aC+GcPIUnp8?=
 =?us-ascii?Q?pJOf+kSWxq5xNvEoctYEiT4X5pszdjllXuGz/blTHUN9ux104CnLbHJEQzEY?=
 =?us-ascii?Q?/E77yw1P/wuqD4ikKYes/4d7oGcnwxDK+h5yabYGewerAQ+tBQqSOGQL+qPO?=
 =?us-ascii?Q?Lxa9Lh85nH2SJ8UTKHjANvgMbBVPg/cFrpvFMv++NzV0heR9KMsPjOkasdC+?=
 =?us-ascii?Q?WD/rioIzqEv3LE3WwSlsrsQZdU4EN4YXSTIC/xCc2/k4+gcszi07rv9XO+/f?=
 =?us-ascii?Q?hzRGYqwjjKzu2EeRO4Q2wVXUqvHco9Tt6sCw7DaK5VXcVSF68Z2ymSzGrAP8?=
 =?us-ascii?Q?zhJkgHQkUDncHAXXoF8tY8APnFLcNEgEa9ZsnV85/Ls0dhcdC7Lz2nUOx5Dm?=
 =?us-ascii?Q?p4igxa+HT8wkiFsLGW1i0xujlhXp99z2AjDYy6Kgu8pHoS7jY3WHdXphJ6cl?=
 =?us-ascii?Q?uRvk3kONLIOl1ZN5KDaw6zGmixziv73+C9Zka1wze3iM8brHb1VVcU2eFbB/?=
 =?us-ascii?Q?w+l9KQiWiXVSkcp0xpn11zkYiEpaRytTpA4qeRztcMD1v98FRCjKxEXtRsec?=
 =?us-ascii?Q?oc7p0sb16F4ESUw5MZx1fo49z7KJL8A0KuUHP+svX5CyqBSMwPtZafRdpVXk?=
 =?us-ascii?Q?OW1fuxYmv9L2oao+nuNr75qHxIY/NnSTELn98MOA0zbbgqI8Xi78mcygpdMR?=
 =?us-ascii?Q?R3yada1mxdUPRaU3SQk5D3FX8QJgT9JvHCBxQFeUQ7u+SBcJELQ77xNRaY0D?=
 =?us-ascii?Q?8SM8eSBt6VvuepDSHU7SNDnvJuaS3vuT7Z+21BolLjgqU2pLwO6tc4CAnclJ?=
 =?us-ascii?Q?YaZRvOKvBXimDC1ekXpSViWp5Oy7Roff8ijmyEOrQM2M0vr4wY8fBHzKQIPu?=
 =?us-ascii?Q?162Uiq12gAEOLIq827agu5a3OCmlEwvtN1uM29cl5WNnlyXQ/wqqY36qDPJm?=
 =?us-ascii?Q?Gy6ZT6Ov+dzSnnG/2nJrYaPmdymJ9izaby8YUOhKuSWBdQpt6B67nof7FFoq?=
 =?us-ascii?Q?VhX8uQGnHmn/4kwZgmp+70+x3zfjY64mpcuHD0MPYrYD6u0q0hcp9C2Eqizw?=
 =?us-ascii?Q?TwZ4P4v21ibifsJPgWvpdxnOT3K3EKsPiji13h/ApFfiZlR8PtP2KkT0CiGU?=
 =?us-ascii?Q?PW2FIBT9UquFOA25vR1JurzfErudedbu?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 23:00:05.9452
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a06cf120-f4b2-4e6e-119c-08dce26cca6f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8374

On Tue, Oct 01, 2024 at 09:02:42PM +0000, Pranjal Shrivastava wrote:
> On Mon, Sep 30, 2024 at 12:32:21PM -0700, Nicolin Chen wrote:
> > On Sat, Sep 28, 2024 at 12:51:43AM +0000, Pranjal Shrivastava wrote:
> > >         mutex_lock(&smmu->streams_mutex);
> > > -       master = arm_smmu_find_master(smmu, sid);
> > > -       if (!master) {
> > > +       event->master = arm_smmu_find_master(smmu, event->sid);
> > > +       if (!event->master) {
> > >                 ret = -EINVAL;
> > > +               event->master_name = "(unassigned sid)";
> > >                 goto out_unlock;
> > >         }
> >
> > The PATCH-1 already did arm_smmu_find_master() to event->master in
> > arm_smmu_get_evt_info()?
> >
> > Maybe we still need a wider mutex to lock arm_smmu_get_evt_info and
> > arm_smmu_handle_evt.
> >
> 
> Yea, we did, I'm wondering if we really need to read the master_name in
> arm_smmu_get_evt_info ? I mean, we can find and populate the name here
> itself under the safety of this mutex and entirely remove that lock from
> arm_smmu_get_evt_info as we anyway will dump the event after this line.

We could. I guess the two patches organized in the slightly odd
way that the arm_smmu_dump_event() gets moved around in the 2nd
patch, so things look a bit redundant after all.

I think we could do two patches like:
PATCH-1: Add struct arm_smmu_event and swap all FIELD_GETs with
         the structure members.
PATCH-2: Add arm_smmu_dump_event() and put in arm_smmu_handle_evt
         directly.

The master and master_name are not that necessary to be in the
arm_smmu_event. I would keep both of them as local variables in
arm_smmu_handle_evt and pass master_name in to dump().

The dev_name() returns "const char *init_name", so it'd likely
be safe to put the arm_smmu_dump_event(&event, master_name) call
outside the mutex.

> I'm not too sure if we should hold this lock for the entire duration of
> get_evt_info and handle_evt ?

It should be fine for being a mutex. Yet, shrinking its scope is
always optimal.

> Also, shall we rename it to `arm_smmu_read_evt_info` ?

I'd probably use arm_smmu_event_get_from_raw()? Trying to high-
light struct arm_smmu_event v.s. u64 evt[EVTQ_ENT_DWORDS]. Yet,
no strong feeling about that.

Thanks
Nicolin
