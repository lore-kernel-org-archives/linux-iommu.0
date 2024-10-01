Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949481CF5E3
	for <iommu@lists.linux.dev>; Tue,  1 Oct 2024 23:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727823885; cv=fail; b=GEG1YhvPulRpz5/gzo7kgJiIE/HeH7dBgpBtf/JG/2Fcnj+D0W/9n40BE9Lh4VD6alYPm/i3q5vWm+kmJw/BqUlfnzyKg3EtgFE25QOr2xIAWvK0//1r88LO8gy6WZHDFAfPC532HrYwhYbt8JwDj4DOpLoPnreMlb3TPR11jes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727823885; c=relaxed/simple;
	bh=Cy9WWTPIVpw/p5SJ2SX3nf+gd7Ye7XeqvLsasm1KqMA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ENp6QfzXjOwdBAUdS7/drBZI8bWp0brvAK7GqGQyXNovvZFrsbGJD+Qy6yko6qFiHx1MqmE7Lze7q3W+C/lV5fiM/9VHEQCw+/XdQWzFBut0e0iQ5Tu9yQlIQLvPjArHkuyhGNP8xyYQ2j/xeAPm8/oyE8thx5t5iUWOcNzRHIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j+u0k8Oa; arc=fail smtp.client-ip=40.107.243.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j+u0k8Oa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kuwCfjZ+JBY80n2u3LAZAMyPLbHSQk4Fjl3E9EpURsJhcVRrUZk1u+bltbR29a6C5E189tn+YMjt6I+Ify5hW+fr7ivhxNYFeVQFXutFhOBAbvE59CKEpkSZjBD26dSmNlvnD1bkV1+O3pnQrpe/EWjYaJaL3+Rw+oW5rrfKQTp63Suzi7bsZ/sQGkU06WEB/O8pDWsj8HzoNCvM9/7XYJFTV76bHL15iEiip22PGjvqM+oXPWWejMi/3L/cuSQ5W6DCPhBJllu8dSXTjGqZ0uRrGLZHct8PJcOEBkzyHmAKqvePj9iPphhA1NHLkKiWKwIypuTyFE6XSjuQnS8uoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6XC9XAv9sr8F+KmTWZuDGMvGICzxKuI7/oMAKvpYyI=;
 b=HLTvwH4Y9OGO75iRPT622Fu/Vtl+fosDqfL6LV0f8/7lG+4YCs+EvCRZV6M7nNFi9lcwJhBUIFCCbhjROzbShh/Slrxgs4BSxj3BPioP/XuCsKGhvsfPe77gcOw+bdr4R+p+dtHtnqYrJ6wcx7kNI4wVrDzFKHGoecghhegG/QPg/yl5wor/kTj9Y01VD1nqv/3CLIiEQ3q0dGo0z6ICdkm6Ekw0bdZTtDRsnY+ivtn/UlohAY0IImgl2QKe1kJ1lVdE9OpzNF5H+f9vRTknVQX6v6kttx2G6s0QJFZOv9lzcAh9X+IhTxN0QUqOyF/Q9V6vyLL1PqAVeF9LNs/eow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6XC9XAv9sr8F+KmTWZuDGMvGICzxKuI7/oMAKvpYyI=;
 b=j+u0k8OaVxmWg2xob2eRKisiA4M+TbW9pH89ysSVgGyNk8nCojT2HKJ/mHiEcjdpHROnfPbscXa9VpmhKAzJz608MvHUDrrtSnGNjsW4qsFfSIa4W5pEX+ovUvInN2Axy2TiSxc80YthmxjF7ZmV6cym8o3Es7EI2YZ4k7AoeJ2eDvCksP14qPgXuhEy+5/t4SXV0hySTrlhz0QvnIHQT1CcNoF3PgV8NoEozMCd3DA6tuJeBBdb35Q5ThWLkuEFdncgGobxdfBjLwhtItmAXwcWHA3twZ3AD8Xs6QtsDorclD8qWzMqQVo+pnqxixnx/XSJcPr1NFSk8NuZq8Rn0A==
Received: from BN9PR03CA0901.namprd03.prod.outlook.com (2603:10b6:408:107::6)
 by LV2PR12MB5726.namprd12.prod.outlook.com (2603:10b6:408:17e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 23:04:39 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:408:107:cafe::1b) by BN9PR03CA0901.outlook.office365.com
 (2603:10b6:408:107::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Tue, 1 Oct 2024 23:04:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 23:04:39 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 1 Oct 2024
 16:04:25 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 1 Oct 2024 16:04:24 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 1 Oct 2024 16:04:24 -0700
Date: Tue, 1 Oct 2024 16:04:23 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Mostafa Saleh <smostafa@google.com>,
	<iommu@lists.linux.dev>, Daniel Mentz <danielmentz@google.com>
Subject: Re: [PATCH v3 1/2] iommu/arm-smmu-v3: Print better events records
Message-ID: <Zvx/93XR6XB/cID0@Asurada-Nvidia>
References: <20240928005143.2378938-1-praan@google.com>
 <20240928005143.2378938-2-praan@google.com>
 <Zvr4vmU7u2BY3MLM@Asurada-Nvidia>
 <ZvxhKfUtXse9Nqxs@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZvxhKfUtXse9Nqxs@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|LV2PR12MB5726:EE_
X-MS-Office365-Filtering-Correlation-Id: 479e85ee-c808-4aa4-3e37-08dce26d6da5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iIsqG3/PfUDKfznzLEkuHkB7VEGWuHzP+7631rofk5MCshsFSxJDiM3pjviU?=
 =?us-ascii?Q?LUO9niKIyHWY6S87AVd9Ft30mocKlcfw2koPr/+Ed3DGT30i+m57mNKpdzQE?=
 =?us-ascii?Q?sf82v39jlgUdI+6S5PCueWXfqEtUU6kB0hKyRceM1uMgAY0fdHWsBC4vh+2H?=
 =?us-ascii?Q?Qd82MQYiY8PtXll0n8lUxYQFwo0WKyYq4mX2y7N3QJoT/ii4yclGspg1h5g9?=
 =?us-ascii?Q?Tw6d2ucxjDiUxa2xv41xi2jbqyWqMyayJad8rDY5sCjqoikIGq+lYPR7wmih?=
 =?us-ascii?Q?ingJDIxXbBmnhE/8Uw09DhFkmyENvVAxWBRMq1bimrIz5zp5l8+4HEQN1eP+?=
 =?us-ascii?Q?aKJxueeIsduceAi2vPchJnFBRYcS/hIVAEfTUt4P+6QlenVJN0xHG4I4u+zj?=
 =?us-ascii?Q?Ibh0Y78A+3L/YAs4XNMWWHVQl47PfZcP/T2Opt6pz5y4krzS/hPuQVvpeJXd?=
 =?us-ascii?Q?LHpvK5JXTF8WCe08x9cZQyQYwbyaY6X09EpDJTB0MS6FNkSLeRVXFcws62Z/?=
 =?us-ascii?Q?02HD2x9S4LtrKfoWs96wEIGUnRFlgMnbBX0+AKTye2XaIIb5dB+lazoBNezp?=
 =?us-ascii?Q?GgKJ7IstOmy9x+tqq9HGBjipSJe6S4t7Yo3o/5baLls0738SVP9nsZz/iPBg?=
 =?us-ascii?Q?2rOSMI116dmB5tyk+KcYenwBJxBVDqaOmm2Z71O6d3NXh7Gy9SyhqC8Y7rDQ?=
 =?us-ascii?Q?hS4/R0CQ4haoDiiZsoyNVCF00SXpBXFupDLKH+OoqdFBhyeeYHRPaenE2kM8?=
 =?us-ascii?Q?E4FPRAXlecWDyYS8XVri7GdZ5EmXoCEd9Q11reAC16QkYcpoTBrm9jW8i/Yo?=
 =?us-ascii?Q?DK/ZIW9wLD2uvP7lJFY6LmYGw05VKQTKiJu7/OZWVgg6POkHXpptTVSM7UUX?=
 =?us-ascii?Q?7kbHbECetFpXJdVrGOagGwoIY89AlOYx8LCO7UVJs8NKuWNicySiOQUe7kat?=
 =?us-ascii?Q?/td0ewgMU3uryT7Gz9px6IySOtl7w2/zAH7KFAMyFoW70/pV3d+AHsaZ5bJI?=
 =?us-ascii?Q?TnCa/YU0CcR4oWFJLnAVSMbJ7WLdf2z/C4Tx+kZsD2AmyTYOf+l86e++s6EL?=
 =?us-ascii?Q?2KgZJIsixKoJzVNznZ2lkvagW29Kbzn0rFnxfwwJtK1lMBm5T0xe6IuDS5zL?=
 =?us-ascii?Q?FEBCcN3UTnxIjEsNYJ1qnLV/6F2U0hXYYqR3Od3xEcXu0C162k5LmXZoTibK?=
 =?us-ascii?Q?N/MmI8167skQ/RjjToGt1ueZ8cU9xiGEXOMHfcEGSTUIwrzz0cE/++iOWPbg?=
 =?us-ascii?Q?SyjmBAMjdXVxuMOi4N3JiqGSnvu7fmgFXOELt3pAvvYb31wHeBt9/k/BhARP?=
 =?us-ascii?Q?oV8S0Emfjq4pRZhrfhzHTzf+3aQZmVkH6osIFoyrfErLEgXSZ+RE/Re6zvzF?=
 =?us-ascii?Q?lZ5EXvxyBAX3hP9O02tYUKG5DXFAZJCPWhgrWr7gZcwzsfqHw3zwvut7oQQ0?=
 =?us-ascii?Q?5L9YFC+HE1Mw/spMgfC1Jxc2WtUsmA9d?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 23:04:39.7376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 479e85ee-c808-4aa4-3e37-08dce26d6da5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5726

On Tue, Oct 01, 2024 at 08:52:57PM +0000, Pranjal Shrivastava wrote:
> > > +static void arm_smmu_dump_raw_event(struct arm_smmu_device *smmu,
> > > +                                   struct arm_smmu_event *event)
> > > +{
> > > +       int i;
> > > +
> > > +       dev_err(smmu->dev, "event 0x%02x received: master %s:\n",
> > > +               event->id, event->master_name);
> > > +
> > > +       for (i = 0; i < EVTQ_ENT_DWORDS; ++i)
> > > +               dev_err(smmu->dev, "\t0x%016llx\n",
> > > +                        (unsigned long long)event->raw[i]);
> >
> > Though I know that is what we have been doing in the driver, I
> > wonder if we have to cast from u64 to ull?
> >
> 
> I think we can do that?

I think so.

> Are we avoiding potential compiler troubles?

I assume so. But I am not sure what's the back story.

> > > +                               event->s2 ? "S2|" : "S1|", class_str[event->class],
> >
> > The previous flags have spaces: " Inst |", " Read |". So, maybe:
> >                        " S2 |" and " S1 |" here?
> >
> 
> Ack. I'm guessing even in the worst case we'd get to 78 chars so adding
> a space should be fine?

Well, if we want to manage the length. Perhaps printing them with
no space at all could be a choice too. Just, if we ever add space,
we'd better keep the consistency.

Thanks
Nicolin
