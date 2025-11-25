Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010000.outbound.protection.outlook.com [52.101.193.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD66279918
	for <iommu@lists.linux.dev>; Tue, 25 Nov 2025 18:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764093841; cv=fail; b=dGwpCVWcm+OELxGUCyyxDlHBA0aTGQTfmMis3h5P16w7UXil7YD0br3Aon2lcdB8SS/nHX5rgZkixgRB3scLjZvKk8XT7k3vJ8iOy+fOUdj+OQ4aAVjN+0a8sn1Eas0v1BHEyUHD22UE8Dae9qjRCi9r+sKAkQYU6NwYbyomjDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764093841; c=relaxed/simple;
	bh=TK0t7xCwZA74Aizd5CZtiCj4PYp+L7n1M5Y7dios+oA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h1gSyiKNc+tE9eoPJlOgxsXsdappdazwgrOHRa1A3b66qgeljyA2H8muhxa8IAZW230wl73R3dj+QHZwDcHdhUGY5DoDL1frA9IlkbMr80xaf2dQkN2ETLgbF8Qe0M4JIeq8PJsuSinqXIz9dZQL+ZYOc0bsitMg9qB8jWkDALk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q2YYmKtq; arc=fail smtp.client-ip=52.101.193.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q2YYmKtq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dQk2QOq5P9Vj84aTumxhDjUI4ELOpbEjz3HiiV+vUCpYfwagy9Ylh7s1uJodwCqAJYWbgormwuAbgrbiAQeJi7As7ZHsZRx9Egz6J45RT5h8xTKeuyPHU3Nst9bre0mC9jD4KkvMT+lTXf9xd+T2WnDTIwyDV7pnGOYmXKx96X+icK9pAawGyGzKnNtZoD/x0B7OeAEOYLMrzva5a2q9XpM7twu0NhDf9W8nRw6gFWL5eucc8gYN5R+0womt/ElUELYr3af2Ry0ksh6lPWXGjp+U0B61c7NUwf9pafd9tDVF5tWlunD/eJOHaU7HU9rFmYpPdDaJwDdirapqyE7tRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1lw00Zl2lVUIt78SbMvBj+H9BFhyfXZ35yOTy/U2s2Y=;
 b=VayYMeCWn0J80hrdpKrXl711/+gS1OdACUvkcrsHAptWaXn1DGw6R5UmbcDKC9+nMMUG8wSN8qm8/fNTFSPJfKE3OXf6xoPv0tD9L1pzLrAWox6pJrVsfsB7UDDJZZYO9/kGnCINfizoQzpYqjNXi568dnIRrktYY0G1sLQSUnwEYiQxJ2DGZGISXCuiCf73WLd/fnmEcbC+mA6oCSbEkOVx5MXDGZOt7d6qJa5DXadP30v83joeVVmlyQdKckcTT5MibqloKQrxxIVSk7Pyh5P9nqOlKRkLEUtRAiSyDCkmQZzz/ohWBguqM/b1VvIMggLnomU9hlXc9L+pumlcrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lw00Zl2lVUIt78SbMvBj+H9BFhyfXZ35yOTy/U2s2Y=;
 b=Q2YYmKtqHkJojfNfQWsLhE8PJyT78NH3SsTWa/hiRTW0cu6mKGVRuBDTlZCD9wCu7gQtEySEoYAVIyGjFmI9WqjeEcpxi6yjcncp5ybqh5JBcMfBKPSyd1uCQN0sPStyAF5m6HySlr7twoAcvBqr041hL9V0GgZWG6gv/A3GvIemug3X1YWKDuaSs/2ZeUCvbTzjSzEkTDfDQ2v+fK7ttgAjolcoCyfeptAF484Jy8PzMVa0COFPMhMfakvPOzdt1qAXbyPUIM9rjYgLFcPDXLeV10U7c45ttyuaLDZCxYdO4zL07PiW8kHIGBYLYD7ZpNuLGWhvpvXO9L3IRALWhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by SJ5PPF6785369A4.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::997) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 18:03:55 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Tue, 25 Nov 2025
 18:03:55 +0000
Date: Tue, 25 Nov 2025 14:03:53 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Will Deacon <will@kernel.org>
Cc: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	jean-philippe@linaro.org, praan@google.com, smostafa@google.com,
	robin.murphy@arm.com
Subject: Re: PRI support in arm-smmu-v3 driver
Message-ID: <20251125180353.GC520526@nvidia.com>
References: <1256faaa-e9cd-46a6-9a42-25aa74b984a8@quicinc.com>
 <aSXupxMeHLajOmDW@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSXupxMeHLajOmDW@willie-the-truck>
X-ClientProxiedBy: BL1P223CA0018.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::23) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|SJ5PPF6785369A4:EE_
X-MS-Office365-Filtering-Correlation-Id: 89da81af-f538-4252-f33e-08de2c4cff68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6pg5FDwj9zrrQOEOEPt5nX9Xn+rWYzIR6WMVmwYr95W/H8Gj0AP0T601d7sV?=
 =?us-ascii?Q?fwyeQMMEMLdPSMCIfzIpSHXIVjmB32WS2TDkE5dnC3LCz5kAzn0Qg2eHAciF?=
 =?us-ascii?Q?RHVH/jFBdZSv98uk5OUO60WgMl3TdbGnNIAgDQzEO6Cs6gPH3KJw1WUaR6Q5?=
 =?us-ascii?Q?FEA7VvKCX+pehUK+o+wAwnctrFczp22f+vKT4pg1rfyP2UYzjv9Ib8WWX9/o?=
 =?us-ascii?Q?EbAbauEiHnBk8ptCK4wptuYBISbHgg75XkipSZTDoN4sKmMTMP9fxYIKNarb?=
 =?us-ascii?Q?JjzwSLvZFml/fpQem82CutDQhfkjh5EIzcT0k90enlNSeuRwEg2V0JLsu3rT?=
 =?us-ascii?Q?6pCI181eXDnFRUN3iSwKHsfmeMyuV2nPgGUtGFj+F50jNRj4SO84lU5tc3mM?=
 =?us-ascii?Q?WTrmziXdXYX3r4+GyVOa2lEHjIf034CJLdjlbiGugJrrTdIwISCSmPMzX5kE?=
 =?us-ascii?Q?eDlFTSMeCzk8k0GXE6a2zOLuPGGbED/gRk5qUh+YNA8guAYIWy4/oa/wFWR1?=
 =?us-ascii?Q?zwcL1VF3HzKhmg50uZWHWPqRx4QlG4S+23cj13EFJtILZ1JmAiqozS5PqAWA?=
 =?us-ascii?Q?FYn74yqnExk1j6SqTv+z1T6yUwn+0Hbae0/fBmaOYwUBIlLYkLNCNb8Q3AEt?=
 =?us-ascii?Q?ETDZ+DNiakS/G8iD9ZfCdlcAQgibxII1NYQxSxqVDZwazQ8hAKN2Ytv3yLRR?=
 =?us-ascii?Q?zi+N05nFHzb4rhktx3GW0Jf3MyYhSt6bapxVoe8ZBuo3WERsGHniCiInDmXq?=
 =?us-ascii?Q?ps0gd60rWXSh+4AeKvtVbXcD8MgsMx2uNM+J4Q/CaLJFJtwDVnytoZgdpYbd?=
 =?us-ascii?Q?yt4BHcVy2oHXVy29duV7TiQxyYptoDAxvSPcgbNI7rlGQ3hPu/v3Sk82zVrM?=
 =?us-ascii?Q?ReDns4FwLD76gFKDg8KMJeFqZS58Jk93T+tPwKDmGntHk/hWu4Ock9ArT063?=
 =?us-ascii?Q?pOxIDvvwFXHRMewFc70zU93sEjcL53LWQLMju/tvCsUcBREplQ/YZBi97ejs?=
 =?us-ascii?Q?dr0mLlVcL2ieXSfKvwgEwZgOR6CDxuTbKTMW/un8boOWMAaN+0AjFr9TCfUR?=
 =?us-ascii?Q?1fXipTd9VbnCuVFC2r9q24Fbok/2hp+zJHzwzxGK+KM0cW41DZ70cMjbn9Y6?=
 =?us-ascii?Q?ABc0lPx5CrI2b+q0WXRAKTQY5CFJ6Npj/104ir4DJZ35lZNO04HIkvHzC+Xh?=
 =?us-ascii?Q?04P6zIu247dQfn2taLsdmWK6PNGeKwxguktmleiIUSK4duVYFAvhnBHFRXo2?=
 =?us-ascii?Q?R9hbhtnWaVrAqiHLVnLTy/enMQ70Fh+exLaHp5TgVMw1iGYzkzGxCMim3kk1?=
 =?us-ascii?Q?s64QCoOr75cTlU+9cz8ssaqdTERCzWoC2zomYhhFqlRuMIxJs1YKpto28fSs?=
 =?us-ascii?Q?CDOhYo2W5wPXUhJgnxClTlcReN3Tt7lDHLlOapzTS2+M18SuxXMBPn1S5R50?=
 =?us-ascii?Q?cP8MiqA5mDm3Y54TQ0Al0EiVGIAsWlY/Rt19sXsNyYwElk1LSu/Alg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JrGRsbcjxKwv10KfuuyjfBZcLslTIJVA6A2XvfxM1T7w8ynXtRs/7n+1xOMv?=
 =?us-ascii?Q?5ZTRxbyddS//wDbpcBJuDda7o27mOmhILq/3CkxGfkDuDc1LvkwMy5lBhTgq?=
 =?us-ascii?Q?p5gXDYHEHbffauCzKIsjn2GW7lz7/uEXVF3y/YYcghyDPGGmc0drPVWYmfa0?=
 =?us-ascii?Q?e/rD/jkXgi1XggrrnAMvtKGujQF+3jDt68+DkxnrKfAlWYjNSiyDMJnV7E6G?=
 =?us-ascii?Q?6qYWZhw6xX0lg43JrtZbKr2x33x6PzbLAd5bFJ+rLOxlqC7yOFo6cubGxH0r?=
 =?us-ascii?Q?tAMPV+8JrsLPxXo3WhzgfKBNWO/Z4HN+YI7TYGkv827Ta9dkz/BMVUf0o44b?=
 =?us-ascii?Q?oSpGoNCppZeW/GOYn7hsmD3SBbzcc4yTodf+UadTD1L/+NEft6nujV58QXwH?=
 =?us-ascii?Q?fmlTE1kQbrIn3AyiqrygUoRCnc6CxVnSmBT2OYfuz5AuE1OvToi0FzcHYT9I?=
 =?us-ascii?Q?qiqEzi89Tvw2L17TjrMU9shdC+laSRrNKSTHTRiaAIKAFqY+wBloULw+AHqA?=
 =?us-ascii?Q?i7GowRt1VvqONyBtpeFSjpyeTh5E91AA0vG4oCHEOv4Frl3irKCsBBYxOnQ6?=
 =?us-ascii?Q?NGHiWGEtD6xwKCjKUAx7pIILuIht2jSRvzi5g063Uzh13ddUqO83UPiiHbZb?=
 =?us-ascii?Q?Ku2z0mhCurhG6j5GANT+Tcr1duCPdLrPn6chh08oD92+JaOcbk68NsDEDi0W?=
 =?us-ascii?Q?E8+gjij3P4xjTfo0VPOMBwuwn5EEKiCanBXqZU488ZXCmmcgaHhzXRCNohAE?=
 =?us-ascii?Q?hTOUkotOMxUKm98g3nIKebb36hyIdLfRg8i7lHmC8hD/QGe/Gq1TtFyYOyz/?=
 =?us-ascii?Q?LOBRDXUSyjpFYloyafcC4Yd5vIwf6dzaEGEZiMzj0cdpB+rxHoQLgm/52Xh6?=
 =?us-ascii?Q?wbFOEKocEgRLKuOBInyQTj6KKOO9gAP3olKrjogQ+d80AWV21JMGbC4CluQN?=
 =?us-ascii?Q?DMQhMqbuHxnOiYMjhk4VYcps5vNqqD0mvFISZXS4OFe0rk4EkmdD/e4Z1ysp?=
 =?us-ascii?Q?f27xgUcaJMN7l2UUcHijXuT6AxpTZBWoEAjjWZWQVKeIeWC8E1vpND90iUpp?=
 =?us-ascii?Q?VtrPB4nPpff/gm5ic70R/cMmT6Sxp7De4o7ONumHj5skXYGPjuQQQbIAUKjv?=
 =?us-ascii?Q?iE5pHH+o/Jx9N1lF1ePtuFp4UH6y07ErGdxQ+x0oP2zZ8ShE+EcBp4n3X8s2?=
 =?us-ascii?Q?utiYlhHny70u51ithM8p8glY+QPf8dd7wKPnep9GlAGIehpdnxGPWmmt9AD9?=
 =?us-ascii?Q?jAw27yfHLek9M1qv+094yskZVxOQOhqjvezA8Q7hSmWfphpOo8aJrK4Vapl/?=
 =?us-ascii?Q?uu+Q/Uisr2KuBHlmWOve7Jw6LM8I/EgyQZXb8rbqzyWhDt6XNPONyMC0kkK+?=
 =?us-ascii?Q?2vx3sMPyGxoqbULznhham3PeqLP+bE33SLifAxcadtGW7Q0+H6u9351txGFm?=
 =?us-ascii?Q?sRm6L6n3Sj6X8r7WeHaK/Zt6e2GNU/+XFlZVPjAJ7hZphHJ7DUC6hQ9+drhH?=
 =?us-ascii?Q?3gJ/Mz5+bkGmfGyWVH5A0LGnUpey5S+VwN4y3eOoiFaI+4ntdGOnalowgoUg?=
 =?us-ascii?Q?uZX/OiGdw5/QPPQacNg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89da81af-f538-4252-f33e-08de2c4cff68
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 18:03:54.9785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IlFUphKcDvGaD3/0+dKX4G8Xo8IEO52+qV8wNCgUS3YJCuh8tzIcsGWLwQ6Us5JH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF6785369A4

On Tue, Nov 25, 2025 at 06:00:07PM +0000, Will Deacon wrote:
> [+iommu list and usual suspects]
> 
> Hi Pavan,
> 
> On Tue, Nov 25, 2025 at 02:22:05PM +0530, Pavan Kondeti wrote:
> > I am trying to understand IO fault handling in Linux w/ SMMUv3. While reading
> > the code, I understand that SVA domain creation allows taking IO pagefaults.
> > arm_smmu_enable_iopf() checks if the master support stall upon fault
> > feature or not. How do we handle page faults for PCIe devices, for which 
> > transactions cannot safely be stalled? IIUC, The PRI handling in the
> > driver i.e arm_smmu_priq_thread()->arm_smmu_handle_ppr() is not doing
> > anything. In the SVA support for SMMUv3 series v7, I see the support for
> > PRI via "Add support for PRI" patch [1] but it is not merged. 
> > 
> > Can you please clarify if we can support SVA with PCIe devices w/o
> > pinning the memory?
> > 
> > [1]
> > https://lore.kernel.org/all/20200519175502.2504091-25-jean-philippe@linaro.org/
> 
> The only SVA client we've had for SMMUv3 in the upstream kernel is the
> "uacce" thing from HiSilicon which is a platform device (rather than a
> PCIe device) and so I think the PRI support just fell by the wayside due
> to lack of an upstream user and no ability to test it.

Right, we only support "stall" mode in the driver, not PRI right
now. PRI has a bunch of differences at the SMMU level.

> I'm not sure whether or not Jason has plans to implement PRI but maybe
> it's something you could help with if you have hardware?

I've been waiting for someone who has HW to take this on.

Honestly, I'm not entirely sure what the missing gaps are, at least I
think we need to get the PRI information and package it into the fault
queue and link it back to a PRI response.

Jason
