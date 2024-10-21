Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54968137750
	for <iommu@lists.linux.dev>; Mon, 21 Oct 2024 22:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729551250; cv=fail; b=nUn5e06AIP4vTxjoiOjej/ox3nkQVG8LLfCz0PlCQXMI1aMCY0y6aaY+fvywOzXMtYC97tKVmBrltdxcOKF18UqolSfKRS3rO+x8UjMHx+6/lqjXDzhEkgJQLiS35Ie8miSR55DKiN2eUYGezgln5s5EbgcZ9sCyJPGB2gknviQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729551250; c=relaxed/simple;
	bh=SUWYWQEGSUGdUtaD4TSgZ5x+YA7lIO8meaHTEISgl0o=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bW+Gs6AAoUDwjCJ1VF7Q6lrumpnY6OvHSpleayfI2Z1ZcIfyb2Ag+9lESDjnpty8GYi5SkNul0iSCYY7OJEE2VFlnJrRvZmhRCshTw62hpDYyQKreCYKLObO5MJ7IhYVWoJE0EITW7KmNX3QWq5wcrVqqZeBb726ntyrsYak4jE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DF/2ZX84; arc=fail smtp.client-ip=40.107.243.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DF/2ZX84"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lhnBUfyx4AJBnXEBPXv+GYzzOF/Bw/b0oZ8wHJZfSXlE9lCCZfX0FDFqul70/yycHyKacjnOo4FBNKtHzeFOGuvl+Jq27j1iviJ3fl69ksxGJ7s/gpQd4fM9YpNAacYLv2slBDXWqHijhVrFzPH69XKsA7uHa3HRpUpLOgh5HTi71lQmT3IFRvi3891yJ1QGpRSKpPjc+ZUhGUkIyTB61XKb2vAlWYfuBcGkGpSpMHG54SRdJZUICUlLANxP2Cuh4kMYk7KuiZE7QQwwYmNOp1Geblhx84eKogjJZ0wywWUC3+KOokKntYVrDh3DKsw0866Fmtf9U9JxCkVhjRb8dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WihH8GGJYT36E1OjzR8UpWVERoqCqq2AQFMWrwM8un4=;
 b=C6R8X48ROcvuVz3WQQpSISD+G4W/pyOd8ZNSTyJp5cFFOo5Uk2gJU0k5tQymFSdseb6gMEeORo9zyzfZEEf+I/F1EirFxvjqMS9nLdgUy2Pl28ln/Q0zz7ujBFDHKIaRyoFwBEtqFquHHojajEou/4bMvokY0+ThuxSZns2XL2cq9ebEWPv9JDMNLfpwclNtm/MEZ01WiFlu5fAz9zw1psjMkOuR2b4xciIjrcX+Ke4Nfcifwtwckc1xIs1b1bSuLoWzgPYsPtsLhbjYnkFco6Rir21sW0j3QM5PUI1gVO7oos888uFs1LF9r1+52CXJghljJqXsZd8Yf9FjPxrqUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WihH8GGJYT36E1OjzR8UpWVERoqCqq2AQFMWrwM8un4=;
 b=DF/2ZX84iYSe012UD8wJszlfLS51jXzTyj863raacVX0iXwTykg/o3tNFWOFXre6r53pxxASOo92hHZkmr7DFgWYYdNngu20JzDVHEOjxap74SsEjoUcjIflPKoxxUiDfYcQKoLas37zMoZ+GYbkQ2OFbheCA8XgSGGZIHK8TvnZ2zrYFoWrMpF8NglKWanOmIeRkcLxfU6Ow/OED1rU9g8uE3IcWGMkYYvp6rVGdhaY94b549mJsvdjMXkyE7adxEFZEeHC7OZ9GmbTMs8LdjoSw80gMCPHpkJocpgvXO2N2dRcb6SFEa0O/aJ2NnNANfmer31l4AKC2zIcufzbAQ==
Received: from SN7P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::14)
 by DM6PR12MB4060.namprd12.prod.outlook.com (2603:10b6:5:216::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Mon, 21 Oct
 2024 22:54:03 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:124:cafe::4b) by SN7P222CA0002.outlook.office365.com
 (2603:10b6:806:124::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Mon, 21 Oct 2024 22:54:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 22:54:03 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 15:53:50 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 15:53:50 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 21 Oct 2024 15:53:49 -0700
Date: Mon, 21 Oct 2024 15:53:48 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Mostafa Saleh <smostafa@google.com>,
	<iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 2/3] iommu/arm-smmu-v3: Log better event records
Message-ID: <ZxbbfPaSjZPYMV5V@Asurada-Nvidia>
References: <20241018180022.807928-1-praan@google.com>
 <20241018180022.807928-3-praan@google.com>
 <ZxMUOfH7GoY71FxD@Asurada-Nvidia>
 <ZxX0KsBBND6v6yqw@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZxX0KsBBND6v6yqw@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|DM6PR12MB4060:EE_
X-MS-Office365-Filtering-Correlation-Id: 87cedd36-4ec3-47ec-ccb3-08dcf22342cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JF0vXApFLdHQNdwbXv18V36X5Swev/qMRjm31/sFSulVVVrTlW+2GftstQc3?=
 =?us-ascii?Q?g6LGocqxesMCyLIBKmUCafOikSlRCGS5Gq3d1rTgcSPhYIN/2cGkWBzOfk+q?=
 =?us-ascii?Q?A+zaLHuQCGGl+hGymp1OaGJ/dIAdWzQHKVzlv9Z7Aj6NEgJiG/2fsRymru8e?=
 =?us-ascii?Q?DMWmcvaTmWUv0RzbFcn4apRTP9KUW8SiQi50Uud4swjRlg+rycAD4uKF4780?=
 =?us-ascii?Q?3w/xqK4TWkPeQYmvSLeXgCZYC6jeU6n4rz70Aus0l551TjWeYTaUASDUQkaL?=
 =?us-ascii?Q?Kn1KSODq+XlOw8l11EZHiN5CadUR77TwIKfSt3TSaRJEa2YZAPwHyuGVtCGX?=
 =?us-ascii?Q?bJgmDboMFk3z1QKNNKhQHbXo38Sl0Cmvwfw5FLKU+YDIf+pBlVQFMbQ4BHfx?=
 =?us-ascii?Q?/Hcs/oh0EOP1vf6IfzR34EPFHYk1ThTDIKG6BC3wTwknz2L2I2eTXE2D1fNL?=
 =?us-ascii?Q?GbouRrmfLxx8EV6AWnjLVleO58A7cVlfFZgBFVQ/glGV6uLDuLVZZKXRQ/tC?=
 =?us-ascii?Q?kSHc0ePyS6GD+n2dCDg5qb+X8EHmrCtMMxah7OoAyvUA+gRu5l3YXQ3tFgk6?=
 =?us-ascii?Q?rjO2Qm5GIjaiQWNqdZeujUZNYqtzQFTj4BhEMPam099RDo8Tlzj3iTBwWH5N?=
 =?us-ascii?Q?ZWr8BkQG7dX+gMwWX5of6qYCRjapH3+dvr6F+HlTjpkdkcrfkmKEH4TqXwOM?=
 =?us-ascii?Q?IWQohRUY8JWpsol7IX73D2AN5qCzXaDi1rSK9KNLcsfymvRjXk+ml5IrC705?=
 =?us-ascii?Q?YPdv0B9kr/hWRPgKSEuoaZ4AKmiSNnim76oPvRYBKuPtn2Gn0EaiPv3/4phN?=
 =?us-ascii?Q?mtm/MJIzsPeloBFcocCs0mAvVSb0SrxTlFrPPGqijJH18q2gq9pemmlXVX4A?=
 =?us-ascii?Q?fDrmrfqZGSJ+bB72JZaQ+Dk8nb9fPO7xNOWZeZQn0gDa/RP0YNuie5JiaPA1?=
 =?us-ascii?Q?FXBH0VMHhPDSnGR1NlSoos9DVfx0bgbaG0vo02r7wdwdf2DRxvX+IMLIhfIM?=
 =?us-ascii?Q?jYBAxN0TTQQBWhuai8Pt3Ai4Hs4lwosXwisLP8pj07GOrzXuXZPK1Y0PWf7W?=
 =?us-ascii?Q?tsGCfqGSz8jkfu5+tjtLg4pRJcXr0nfvFihhYjYucG6wKdFYRTrdLnxGG/E7?=
 =?us-ascii?Q?QPZ75rKGnJ6Ap2Y6tyKDmxzes/mCqMykRq9VQa3hIxdLbOjmOeXLwu33E8sp?=
 =?us-ascii?Q?YWcX6m0EeEoU3bHJMaepP8BsvbrUmalpNomrdQ4oQt5BFYBoQMXAxB2ig30O?=
 =?us-ascii?Q?iBlWqRht7jir7NDgiqJg54U1Sy6aylhJcCGlidTXZ+x1NUsG/N1y5cNUVN2p?=
 =?us-ascii?Q?wqY7d887cSinPlKKdpSZJ0/AWCRCwgReq5LvYnd6LkNwbZGWxh70geQKFx27?=
 =?us-ascii?Q?Sme7HdE9IXLK7rh52Cg3KLAq0l8Xx1qClxEQn4NuyPczsDw70A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 22:54:03.7078
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87cedd36-4ec3-47ec-ccb3-08dcf22342cd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4060

On Mon, Oct 21, 2024 at 06:26:50AM +0000, Pranjal Shrivastava wrote:
> On Fri, Oct 18, 2024 at 07:06:49PM -0700, Nicolin Chen wrote:
> > On Fri, Oct 18, 2024 at 06:00:21PM +0000, Pranjal Shrivastava wrote:
> > > +static void arm_smmu_dump_event(struct arm_smmu_event *evt, struct ratelimit_state *rs)
> > > +{
> > > +       struct arm_smmu_device *smmu = evt->smmu;
> > > +       char title[100] = {0};
> > > +       char mastr[100] = {0};
> > > +       char addrs[100] = {0};
> > > +       char flags[100] = {0};
> > > +       char other[50] = {0};
> > > +
> > > +       if (!__ratelimit(rs))
> > > +               return;
> > > +
> > > +       snprintf(title, 100, "Unexpected event received: %s\n", event_str[evt->id]);
> > > +       snprintf(mastr, 100, "\tmaster: %s sid: 0x%08x.0x%05x\n",
> > > +                evt->master_name, evt->sid, evt->ssid);
> >
> > Likely I mentioned in the cover-letter, maybe "sid.ssid:"?
> >
> 
> +1. I like the idea. Maybe let's update the log in ppr to follow this
> as well? Does that sound good?

Oh right, you mentioned that once.. Yea, I think that would be
nicer.

> > > +       switch (evt->id) {
> > > +       case EVT_ID_TRANSLATION_FAULT:
> > > +       case EVT_ID_ADDR_SIZE_FAULT:
> > > +       case EVT_ID_ACCESS_FAULT:
> > > +       case EVT_ID_PERMISSION_FAULT:
> > > +               snprintf(addrs, 100, "\tiova = %#llx ipa = %#llx\n", evt->iova, evt->ipa);
> > > +               snprintf(other, 50, "\tSTAG = %#x Stall = %#x\n", evt->stag, evt->stall);
> > > +               snprintf(flags, 100, "\t%s%s%s%s%s%s\n",
> > > +                        evt->privileged ? "Priv | " : "Unpriv | ",
> > > +                        evt->instruction ? "Inst | " : "Data | ",
> > > +                        evt->read ? "Read | " : "Write | ",
> > > +                        evt->s2 ? "S2 | " : "S1 | ", event_class_str[evt->class],
> > > +                        evt->ttrnw_valid ? (evt->ttrnw ? "| TTD Read" : "| TTD Write") : "");
> >
> > Should the last one be "TTD Read |" : "TTD Write|"?
> > Otherwise, it would be "S2 || TTD Read" combined.
> 
> Umm.. I don't expect the event_class_str[evt->class] to be NULL ever.
> Hence the logs would always be in the following format:
> 
> Unpriv | Data | Write | S2 | <class_str> | TTD <Read/Write>

Ah, I overlooked that one :) We are fine then.

THanks
Nicolin
