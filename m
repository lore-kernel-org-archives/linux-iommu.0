Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE6F1A2643
	for <iommu@lists.linux.dev>; Fri, 25 Apr 2025 16:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745598357; cv=fail; b=oYjDc9ovlG1oQOOeznajn5hm45YYLWKxqggr2Axwm/KCsbDXsDIyaXQMqvQPHs3G37+DlL94//hCzdnu9bmVQI1jVATuKc1l6pdC/IZSW2wW9meh31RSm73B3bBI9zXy2SjrjToSn4zzcY76kFU5pcHstpAMCsV3MZqt7oSUerY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745598357; c=relaxed/simple;
	bh=hoocMjWLm7pP9G907m8zxRXsmWMLT3tG22itoUpvM14=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJudUDXYb/Hu4S6aSaIgseSK5N0ZKQf3Jck77dDkhtJjmHSSHScUxrkIHp2d5K01Dg6V1ygFP63o90UfFMu7AL+AfDSzIFQnKaRiLijLqUvUl/Beir4FPetTpRiq2Ghw5BH7cmU/Xdt4C+WOPjQGdW67AZaEwjXHQMZCVPGD/4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KUb16g1s; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KUb16g1s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UsKE/cFtbdg2ypK2tHT+eqFiVN6Nq7aJ63z0RLgs2I+szdtV8L6P82070GufhvP/MKfmsuMup08vwEnybk1QS/pNA4wyk+SsDvVzNVpaYlyI/BxKLWjLfJ3BQLkx+uXQfEpBdO4+CwfTSqc4OBIMaATpSeJw5V+udggMHUF7Y+k4LNzS9Btgs5IqxIDf/x+D0rvdV97tstT6D8EnJdjYdLvoi58RinYqVa6rEbPj1hxHEm8xZv6hamxLHOhyg+KE0zQeHG9X1RgZrw2GYG/FuGbZcHAHaG/YkyeAASWBPTIJSbjOwUZS8wnLppxaoGKqzRlWKT3ODt3IsFyj7NgvUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K58g+GAiJARfzwSaSn1uWoZ4fiksKow5ElFdtsluvFI=;
 b=vAi0AqHloQ09zXPkkJ9EakGOja8AgOOW4Cg7xHY4PWpSCnZpO/yDS+QwVv/YzRPOe4LIIb5ySs21HZxEFFCQYowhaQC34bynpiKF04gz4P4sI+sJV0zsZmJBynMcTnhoXa3a1tMfQ0lJa+fKEa6ATJzibE0OTkd59d1NINF9wHWHQJ1oPW2vnKkccX1Y4sh+g2J1arf7pJ3QutUT6eC0kUTVfGECjvVljP59K4qbg/iM1M5fqUvBQqG7WiNMK09EQyKLyKuV1b5MndpkNx+DOt9wCw5WrjGnq9pYLfqO5N5RVAR7eq9u/aItnGE/yNyr7yLdRvIGZ9239sCfet+lpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K58g+GAiJARfzwSaSn1uWoZ4fiksKow5ElFdtsluvFI=;
 b=KUb16g1sMghYLTJmolPJceEk8Hqzfh/AorOnpoTeyf2p9ji3lIMZrzAqGz+f0TAhSWI9tqrJS6u5FPfv55nJHUIaNu//RsV601ZvnSrUgys2IK3FTZuwikZtE3tB1X9PcLPTtFR1VRAxL1ZnwrT3r+jmIumvI24f4IRwAcGzVMs=
Received: from SN6PR01CA0035.prod.exchangelabs.com (2603:10b6:805:b6::48) by
 CY8PR12MB7659.namprd12.prod.outlook.com (2603:10b6:930:9f::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.26; Fri, 25 Apr 2025 16:25:51 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:805:b6:cafe::4) by SN6PR01CA0035.outlook.office365.com
 (2603:10b6:805:b6::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.32 via Frontend Transport; Fri,
 25 Apr 2025 16:25:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 25 Apr 2025 16:25:51 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Apr
 2025 11:25:50 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Apr
 2025 11:25:50 -0500
Received: from amd.com (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 25 Apr 2025 11:25:46 -0500
Date: Fri, 25 Apr 2025 16:25:40 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Joao Martins <joao.m.martins@oracle.com>
CC: <iommu@lists.linux.dev>, <suravee.suthikulpanit@amd.com>,
	<joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<linux-kernel@vger.kernel.org>, Alejandro Jimenez
	<alejandro.j.jimenez@oracle.com>, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 1/2] iommu/amd: Add HATDis feature support
Message-ID: <g3xrnjfs6zekogfohud2s7kdvphx43e6mdh3vfpllynrwokxwf@vvetz2j2nrai>
References: <cover.1745389415.git.Ankit.Soni@amd.com>
 <6282a5c349812a311a67a8522dc5e4aabfe3ec3a.1745389415.git.Ankit.Soni@amd.com>
 <596ed125-c995-4e2b-824c-b7929c852754@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <596ed125-c995-4e2b-824c-b7929c852754@oracle.com>
Received-SPF: None (SATLEXMB05.amd.com: Ankit.Soni@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|CY8PR12MB7659:EE_
X-MS-Office365-Filtering-Correlation-Id: 309b193f-794e-4768-bbc0-08dd8415d82b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mejqhlQgFhLA+YhGFj+C+IH5jZsVmgLL9VAQ4sGai1JTJAerTW/X3q9pF2Y4?=
 =?us-ascii?Q?KNm3rQV9Q2lRPp8mY7sO7RrKN08EyT+6C1/2DlPaVklKx2VCD3HMMiTy6yPz?=
 =?us-ascii?Q?sAVoTQjlKyleXcDjn5ff4cQ+HVJkg1n+v+DOhRtDR0vhxj/P6znvQl5M+azs?=
 =?us-ascii?Q?Uy2uVw8D9cV4HZ9Xr3dMgMqs6nSYOvT1HNq9qaNhyobG9qoyuYF2s1FBKqWM?=
 =?us-ascii?Q?/2nAJFiykmS762FTvIjSjl5Td3rJNKDPZcboktzzw/7QvaBpShaBjX1cDYOI?=
 =?us-ascii?Q?AkMsioAPefKPeWVV4UqPOLPVzlHYUtL8ZzJU2DfJh8tpnC7gBoEy7b4RPqe7?=
 =?us-ascii?Q?FHQlb7NratvAp+J/v1qT1BKSZCxxNm+iZindmOFkuUeOMSedNQWoHcQF6EzJ?=
 =?us-ascii?Q?5IzhCUC3rn2/6y7Mfm7gVKmIvMFOHqBCVUJZha82pBDaMGkw52lcD4Rz8vad?=
 =?us-ascii?Q?gvvHF2tW2K6BDT1AAIEO8IA3cdfujYV13ZfF5KQDDkGuEAtEJ6KPMH+gaAGV?=
 =?us-ascii?Q?f3D+ZOLPdawE99w6MdfgbZBRfAgNkn4MdRWAFFYUgECASZRMS1dNDpclU8EZ?=
 =?us-ascii?Q?K/A0v3IS8ptAe21H23tNmv9NuXfeGCPcMZ/e2dCRpSJnFKU9U3xw2K11FDmn?=
 =?us-ascii?Q?X5R4mbbur9tjNZAw4cdpMFQoyHSiFUZKKwvFIgiJ8oAASg3KYxchhrJIMRDH?=
 =?us-ascii?Q?h1HVPQ78SpHerusQlJYQ5+Y6+/4CSgioJgjlMVBYvFSlDBsjzHkJOyEw2Yqd?=
 =?us-ascii?Q?As4eM6PRv//07MDb7RJP7lgTr33T3oY6BS/mKGRnhCzOWj71UobIBfXMHdD5?=
 =?us-ascii?Q?Oo//mafRiSgHH+Ulv6r1Scc9gOsE2kKSAqt6/M8PO21WqoLU5ekHCRWsgLKs?=
 =?us-ascii?Q?J2xZuWRbYCsiTs0Vwd/rA8snOaBYoPYLd1DCQe+tjtVrTfIO8TpmpC3KODS6?=
 =?us-ascii?Q?aAa23P9iNLuV6pcAKIunH9qeq4a+O9GFyrcULU0ANbeepDD1NH+6hZYE3my0?=
 =?us-ascii?Q?PYJX58jCydItpK88GDzTTQeMAlGTVf8DLhcrGgJBybwqn4XdTeHkOZKqhrOS?=
 =?us-ascii?Q?VAnB2xp6iBTBjUBpvQw091pUyvCLowytwASZC/Zj/RtUyJJGn4j1AHyMVrgG?=
 =?us-ascii?Q?5SJYsWq2CqoRzklR69cbSiQ+IpwoeVvYLbQyFNqErZzz+0HxX89CKBbFoFy/?=
 =?us-ascii?Q?bY5JkRSSbOdlEhN9PEFmbpNJ1NW2m98l6Uh7AgGn1OyxygGThH/ZXL+Mvoj9?=
 =?us-ascii?Q?t9XnltCUeZz5joIjGThDwLTESMHpl7pCfQO3/LHesQCOhqQDIfX4UHFtqsrM?=
 =?us-ascii?Q?AkJhbcH2tB9Dhx4obDWlk6MxTZjamKOY3lSC3YSnoBAplJU4huqu4wyu971o?=
 =?us-ascii?Q?/9mrS0KG6JKQj2AGVDySKA3HTVRq7NXd0srm+0FUivtvwrkFDpKL0SLbLLpd?=
 =?us-ascii?Q?ii603KlhzoBAMLnKfq0HYJJyDIBbfWqIwNFRstZBtJVV5n4jjbTMtW3gtuDN?=
 =?us-ascii?Q?Mq2vhm6dMfck/xeuOdOAP4YP+oZhvuGEBbIC?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 16:25:51.1621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 309b193f-794e-4768-bbc0-08dd8415d82b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7659

Hi Joao,
Thank you for review this patch.

On Thu, Apr 24, 2025 at 01:19:43PM +0100, Joao Martins wrote:
> >  {
> > +	if (amd_iommu_hatdis)
> > +		return false;
> > +
> >  	return iommu && (iommu->features & FEATURE_HDSUP);
> >  }
> >  
> 
> It's strange we seem to somehow have host translation disabled, while it
> advertises other translation-related features like the normal case.

If HATDis bit is enabled driver will ignore host(v1) page table related field,
this includes nested page table.

> 
> In any case we should probably follow Intel's example (which does similar thing
> to HATSDis) where we only call invoke IOMMU groups
> iommu_device_register()/iommu_device_sysfs_add() with DMA translation enabled?
> That should simplify most of the patch as those codepaths are not reachable via
> kernel/userspace? Unless I am missing something ofc
> 
> See also commit c40aaaac10 ("iommu/vt-d: Gracefully handle DMAR units with no
> supported address widths"). I am not sure what else is the closest example here
> besides intel-iommu equivalent.

With intel patch you mentioned above, it seems that it is mostly handling 
"second stage translation support" disable, which will eventually disable dma 
translation. And in AMD case, HATDis bit indicates host(v1) translation is not
available, then attempt to use guest(v2) translation, and if both page
table modes are not available then disable dma tranlation.

Thanks,
-Ankit
