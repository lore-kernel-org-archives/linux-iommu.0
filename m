Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE83200110
	for <iommu@lists.linux.dev>; Fri, 27 Jun 2025 19:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751052049; cv=fail; b=NsvLlpmPbAYzbJJ87jcT6SkKIWjmj/rY/xEGBIMJUvguRjgXHtGjz32L9J+391KCHKOOJbREy5zAZ0ZTgj5wLNkxVFdr5mXP/WeKSoXNcoxtCDnat9mEJeGjKAtBHoySn5ES2HIiUchhh1LP6fvXL95jNvySaBLVDzFPOOQDjq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751052049; c=relaxed/simple;
	bh=YtSpBDZ78AEbUIAhnZOwi2sIX5bjOewTduPAHxGM304=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iMYfEr3ydXRGicj9Mc7MlwVbmvIXAltQMgItacCLq7spacyE40Ur8eCeH90gRBAOC+Sm6xKN2zFqX24tWn9Ctw5UkFETkQ4vwoZlA+tsNg2LCj3115NQ5LPnnnKSH/VYABeNilzoBR7icV2aGw7zU/Y07RLcUJa71HLZoHSFvBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2/YiHW/k; arc=fail smtp.client-ip=40.107.236.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2/YiHW/k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xv/5+C9GPaWjTN3X/BzS8zrCNn5Y0N7Y5hezJ3DDkNp4rEHDMt/KX6euGGP3HRbv1807E8qbGsK8099V2wc5WG7J9YZ4x4yPfd8vhDXtTZvOHhTEtRYtEwAX9kBdim6cKHbxyKvIwb5hS629GxxwSKQ+OH6AeZcDQLlA35hQywlyh4mrdWkflr7+XG6Vn6FHdaToZKeIkKctPgXq3+tzEMFWq+/e6HPOG8vewom2s1HVNegoYCxifSdlQ1beA88dRyagV7PyduRCjCJ0z4p1SR11vyIqW9B6tYR0rWNWdInJp+rgf0ZARctZKx8VF758w+XT76vpkCrpS3r9bWfFBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9R5EwGZp/YgmDHMTa+c0cAJrUCYj5y9yhBSGza6Sx80=;
 b=lrZSfuIzPdJ8rllPwan2vGtaSWSjVODZR9ZacMbpeR6DIwFdgGC9WrmV5BpJrMcOk2BtcN6lAzAI6DtY1Uj8w6zQhsRzlpd0k6F+IczthrDXTD3JgKqrT2I9SC8MWmMzmqLz6YZJlLn60Pz/urkNV4qNRGQ99HjAsVxq1rlYybxVwbuSMpjyfCDidq5PQtN6uJP46jtnj5bT1rjjzH9Bim3Tl2hj0UVEg/cTc8PZZt3agVKliW/6GaFdQ7RSDUvGc9gvQgu8nG3NwLY4iDZXG/LBGQ0yODL4YMlM6LKMYsiMlPw9U4wYjU/qB/rhUhP7mDug+NMTTLLGvmL0GspYBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arm.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9R5EwGZp/YgmDHMTa+c0cAJrUCYj5y9yhBSGza6Sx80=;
 b=2/YiHW/k4KttDGgVP/hRYhcp9AM6L3Rpprqh/OE6HxqhS6w67t2Dc9dPcaNxDpxMd3PjeF6JkI0AooINmB2uMWSw0fVtzGPm+ZtyYwgODFJf1hRZybjAXWSlswvuSCyBXMFdsYsGeq52f72GmFlwm8Vo5NLrGlzQ+UNm/lwxzkU=
Received: from BN1PR12CA0011.namprd12.prod.outlook.com (2603:10b6:408:e1::16)
 by IA1PR12MB6115.namprd12.prod.outlook.com (2603:10b6:208:3e9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Fri, 27 Jun
 2025 19:20:44 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:e1:cafe::d0) by BN1PR12CA0011.outlook.office365.com
 (2603:10b6:408:e1::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.21 via Frontend Transport; Fri,
 27 Jun 2025 19:20:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 19:20:44 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Jun
 2025 14:20:42 -0500
Received: from ubuntu-20.04.2-arm64.shared (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 27 Jun 2025 14:20:42 -0500
Date: Fri, 27 Jun 2025 12:20:37 -0700
From: Stefano Stabellini <stefano.stabellini@amd.com>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Robin Murphy <robin.murphy@arm.com>
CC: Michal Simek <michal.simek@amd.com>, Will Deacon <will@kernel.org>,
	"Stabellini, Stefano" <stefano.stabellini@amd.com>, linux-arm-kernel
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>, "Linux
 Kernel Mailing List" <linux-kernel@vger.kernel.org>, "Sarangi, Anirudha"
	<anirudha.sarangi@amd.com>
Subject: Re: SMMUv3 interrupt handling via custom logic
In-Reply-To: <43acfcd8-b359-448f-bbb6-da1b71a64f45@arm.com>
Message-ID: <alpine.DEB.2.22.394.2506271219070.862517@ubuntu-linux-20-04-desktop>
References: <0482d84e-871b-4522-b94b-29a97c87ff66@amd.com> <43acfcd8-b359-448f-bbb6-da1b71a64f45@arm.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="8323329-533866934-1751052034=:862517"
Content-ID: <alpine.DEB.2.22.394.2506271220360.862517@ubuntu-linux-20-04-desktop>
Received-SPF: None (SATLEXMB04.amd.com: stefano.stabellini@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|IA1PR12MB6115:EE_
X-MS-Office365-Filtering-Correlation-Id: fff2ccaf-5178-4994-899a-08ddb5afb6ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UDN6ODBqOU1qMGNKOUEzRzZ4TWV6WHhXeDdMUHpwVk9CRnJJcHFFaXA4TnNm?=
 =?utf-8?B?bnA0ZTVzR0wwekpyOU5kWkZTMTZrUVU5dVdrbTUzMG9uMTJNajZjc25NTTZU?=
 =?utf-8?B?ZjBUZWFNUUhpLy85bllqM3NnbzMzT3ZncHJsY1k1eU53ZDNoSlRiS2M0SXM4?=
 =?utf-8?B?WWR0a3pCTHhuQUk2RGpBUXdUcld3bTBJTVFaTGlVVkZGWUlVQXk4Ry93ckdx?=
 =?utf-8?B?Q3ZBaU5vcSsvRXROa3kwckRzTEFzMFBsdEw4aXd6RkpybDBOWS9NSi93RWlF?=
 =?utf-8?B?dStRK25wZ1ZrS2d5c2FtV21ETCtxZmUzZXZlYzdsN1B1aFpvSk50VkNzTzE3?=
 =?utf-8?B?SFIveVZES3UxWUozUnFBaEpnSnhoeHpnVEt5OEowWVB0RDFlOGxNcnRWYWhV?=
 =?utf-8?B?M2s5Um9oeVd0TDdWcGJNSnZuZnlQd0xoU0YvN3hOZGFzQ1pYZDM2cVd2YlZJ?=
 =?utf-8?B?bktEQUdFV0UyYzZmWEtja2NBUnJubWp4ZUtsbjZZQnJPdHlIZWMwckd1WnB0?=
 =?utf-8?B?THI2L1JJTDQ5Z2tyTlBheUhSaHY0ZnV3aXMrV3Y3TkJrRWRWenQvaHVGSEF1?=
 =?utf-8?B?b2Q0UGUxaWRCcVFLc3FKeU9uWW9UejM0eXEzTFVISWNSazdoT2oxSGlsRkxt?=
 =?utf-8?B?S1ZCUWVCNzFmMkhUaUxQYk1XU2oyZVFmZXJQYi9VK0h4djJUdVFsR2RYYlk1?=
 =?utf-8?B?TktQRzRYZlB3NEFhVU1hUmR4TW1IcCtWTTloRVRQUFNyTjE0UE96YlBxYm9X?=
 =?utf-8?B?ZXhDemtYNmFkRWFhY2pZeHdpaW1XRHd4UDZMRXhHM1M1NWFBWHU2VmFDZlJC?=
 =?utf-8?B?elFVaXZGaC8wTFIvUldBamhEaElXNW9xN3J2M1hZdXM4YzJzU1pEa09EZUlq?=
 =?utf-8?B?Q2x3UFRZN2JSa1VITG4yMWRTMDl6MDl2N2FJc2tGWndDeG9SYUdMQ1daNzV6?=
 =?utf-8?B?SnoyVUNveDBId3FQamNtZndoQWFKdzZsQkVKZzQzTVRCbERFVzJzRGFjTmd4?=
 =?utf-8?B?UVVGOFA3TzRKMUllQjdSbS9qdzR5OWpHT05PdEwzUitFYW0waW9WU2gzTWdh?=
 =?utf-8?B?YzVmNFJSNUlnUHM0YUVDd0QzTlp3MlkweGlzM3B2NGpNQ0Q2VEdaaCsxcERR?=
 =?utf-8?B?L0QwTCt3ZDZpakxFdkRnT2FoSUtWZzk3eU9iU2x2QjBla05FcVZOaTMvOGs1?=
 =?utf-8?B?cGZ5em1vUFppZGJqWTFQc1c1bHozTHdhUDMreDBodkVRR2xkZnNhKzNqVXVL?=
 =?utf-8?B?L1VvRXVIY2xjU1ROMlFzSS9uWko2S1FqL3BDaUE4UU4za2dMOXllVmlZZVN1?=
 =?utf-8?B?Zk5BbEhoWlJ6K2ZYRGk2MTlNOUhtcVh6YmxQMDVsOHd2ak90dXBYNzVrMGZN?=
 =?utf-8?B?NlVGTjVhSTE2cThXMDdpMG1ITGxHSEN2ZjBueHpiMjdDbzZYUHFGSmEzSTgz?=
 =?utf-8?B?Uy84UDFkWTh1K2ZQQVllYWhYcEhaK3EzRW5JSmtzYnhReE1va2ZKZkd1b3py?=
 =?utf-8?B?d1o0V1dnSGRNZnlMUzl1ZFJ6dmI4K21hRk8wbFR4b05xcTl6Rk5wQ3pBQWNO?=
 =?utf-8?B?R0t6WkZYb2ZwZnZHSnkvU3VLQUZnRnN5TUMvRnNzMVE3VzA5RWt0VnJldkov?=
 =?utf-8?B?SWpSeDBoUElRNWlNd0MwRmx6ZUZqdEVHYkJzUXhOUHdseGFPSnkrZ0JWaG5O?=
 =?utf-8?B?U1BuWDl3dmxyMEVnV25BL0pCdlViaS9IODZXY0o5MU9XQkV3a211aFBMZ2Rz?=
 =?utf-8?B?dmF2alYvVGUrZCtJQUNORitZYUtmb0toaUtYYllFOUdFcDhkNmgwQmVod1U5?=
 =?utf-8?B?eXI5RVd3U3k5R1NWLzJvaVhnNU9VVHM0ZHdacmx5VWFUSTg0T0I3QVJVd29S?=
 =?utf-8?B?andsQ2preWpVeU1pYk5tOGhsczNLVWtETlpkZkovY2htWnZ4Y1h5YTVoMm9S?=
 =?utf-8?B?RExSbmxCek5jcnM0SHNOZEFUWk5YcHFWTzJTWjNEOU5ld3NFS2MrMXNUR01O?=
 =?utf-8?B?N0VibjA3TzI5QWtkZDZnNFdMSG9DMjhNWWR0Y284Szd0ZUR3V0hjS1ZIMC9k?=
 =?utf-8?Q?d7aHwa?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 19:20:44.4650
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fff2ccaf-5178-4994-899a-08ddb5afb6ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6115

--8323329-533866934-1751052034=:862517
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.22.394.2506271220361.862517@ubuntu-linux-20-04-desktop>

Hi Will, Robin,

Long time no see!

On Fri, 27 Jun 2025, Robin Murphy wrote:
> On 2025-06-27 8:19 am, Michal Simek wrote:
> > Hi Will and Robin, (+Stefano, Anirudha)
> > 
> > We are using smmu-v3 in our SOC and I would like to ask you for
> > recommendation how to handle our interrupt cases.
> > 
> > here is description which we are using
> > 
> > smmu: iommu@ec000000 {
> >      compatible = "arm,smmu-v3";
> >      reg = <...>;
> >      #iommu-cells = <1>;
> >      interrupt-names = "combined";
> >      interrupts = <0 169 4>;
> > };
> > 
> > but it is missing one important detail which just arise that actually there
> > is additional HW logic which deals with SMMU interrupts separately.
> > There is a secure part (global, cmd, event - gerror, cmdq-sync, eventq in
> > DT)
> > and non secure part (pri, global, cmd, event - priq, gerror, cmdq-sync,
> > eventq in DT).
> > Based on my information all these interrupts should be acked once handled to
> > be able to get another one.
> > The driver itself is able to handle them separately but we didn't create any
> > solution to reach custom HW to do it.
> > 
> > I looked at f935448acf46 ("iommu/arm-smmu-v3: Add workaround for Cavium
> > ThunderX2 erratum #126") which introduced combined IRQs but it looks like
> > that there is no need for additional ACK of that IRQs.
> 
> Per the architecture, SMMU interrupts are logically edge-triggered so there is
> nothing to clear at the SMMU end (the "interrupt status" is implicit in
> whatever condition caused an interrupt to be sent, e.g. the event queue
> becoming non-empty, SMMU_GERROR becoming different from SMMU_GERRORN, etc.)
> 
> If this is an Arm SMMU IP (MMU-600/700/S3) then the physical interrupt outputs
> are most definitely rising-edge. If somone's stuck some interrupt combiner in
> between those and the main interrupt controller, then yes, that interrupt
> combiner really should have its own driver.
> 
> > The HW logic itself is handling secure and non secure settings for SMMU
> > that's why would be the best to avoid directly mapping it in Linux.
> > 
> > One way to go is to create secondary interrupt controller driver
> > a) ioremap one with notice about secure part because we are using SMMU only
> > with NS world
> > b) firmware based to tunnel accesses via SMCs and allow only access to
> > limited amount of registers
> > 
> > The second way is likely create any hooks in the driver to be able to
> > provide additional SOC specific hooks.
> 
> If this thing is munging *all* the SMMU interrupt outputs as I suspect, then
> the big problem with that idea is that "the driver" is at least two separate
> drivers (SMMU and PMU), 3 if it has RAS and you ever want to entertain the
> idea of kernel-first handling.

Yeah... I tend to favor simple solutions when possible and the secondary
interrupt controller driver approach is looking increasingly complex.

In addition to what Robin mentioned, I understand that this email is
directed to linux-arm-kernel and the LKML, so the focus is naturally to
solve the problem for Linux. However, let me point out that this issue
also affects Xen, all hypervisors, and proprietary operating systems.
The "big problem" is even bigger :-(  Complexity will multiply very
quickly.

Do you have any creative ideas for how this could be handled more
simply?  Maybe with help from the firmware (e.g. TF-A)?
--8323329-533866934-1751052034=:862517--
