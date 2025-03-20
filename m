Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2062.outbound.protection.outlook.com [40.107.102.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909362236E0
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 19:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742499785; cv=fail; b=T6pAbqr1QeEwFcsSD8mWvrQz40SXXAKguWPIyfyU148YG/N57MEfjVRfWjRcZGOIs5vDZdwZJjiN+CbwtIr6bBbkMM2ksmplX332DB4yqJnl0xm2KYHqM1k81o/RexZrroAMLvhwDPqipnGuywYmvobzLHbASxh0j/4Y2B8BTKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742499785; c=relaxed/simple;
	bh=pZYloAOEKOdoEdsESEWhg/gkbRSJgRDQjXrWkZjrQ5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YwBfY3Ku/9eBeOxgmP2ODDKEtkSnGg+VtEyYgLmQtJnWZvmROb5VbkIAbbroHs2XiTMe8/KAea0/FaOq9RK5y6ogk9eSCdiE9n7UlQhtLJl05QrwYl2TtFJh31j5nvAaqo+8uTxptGoqs1PZZeGq1bRH6RagPpO+cmyIJnSng1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PlWXMtCg; arc=fail smtp.client-ip=40.107.102.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PlWXMtCg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sBXu1npHz5tYcYnSPbw+Mp2aGeVxqBG3igubGazsDHAVk9XhsaVmtTSmTJo9Etrkww0twgNurxztv4buZ2cWgGdcqGhrcnXyLLbvFkMTVWZUWXDD0a60PntR/AcPgCJ86RTVppAoPv5vImGme7zsBX2byVUt4M/Zwjpx7tB7iX6gtPfxcjLfa9+NJ5pFe1QbejFI/jQNr967yREPNhrZ9thETACgLclGccYU1j9rR93v8pUbgN2wFIM55rarfhTSveBSrcEY0NzY3v3eL7jV8SpK79e6lUiKwfrlJLv6AKoJd8J8/1qLb14FPgkuefiDC1SLfhf36x5G4ufIfTyOkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGuijdc9Xxj+G0husTPfR46gSblE6esQBY0PFtGWGnY=;
 b=LG8GPgIsWi6I2C0F7ZHU50VlNKUXKkaMkwSJrOap1P7byjUJ2pxE73krijgaFRCKLq10OZyzGvwD2Bp6JrWVbuAgc2oD1OGNxTKCAyVgta6Wyf15Znac/n9GQNroEvdJ06QvN60EFVT0/QTCwA8mF4SrqkO6KN6FGNgeo55+H5VZs0LxGkkqszYyAdSoRYVTI3SxJoZbtqaEsZZ/i/kRG/ggbxza+hMu7XwWQuBdPYWDXRC5xqqZlY0Y0YDTNhIsEQylweYv76HwzD90s+vi5pjo+hKR6p6jU2lAcbvqav/WG0B2I7MNeL/H0WcJ6mMAzkmS7G5IqHZQfiwyJRWeAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGuijdc9Xxj+G0husTPfR46gSblE6esQBY0PFtGWGnY=;
 b=PlWXMtCgf1mj5T4yoLbsrri3J8ansHv1/dscxk1WeIwLB1DROg/eFgGuzqpNjxJKmmCqVBhDgt6vCFC0gX7VTNJimmEd2IPMJ3bC0sr43ybx88gsqZ30Xik/CmNcH9Nv7oxHeKcjmo5VkU12I3srcA3CsWDbrItSFvZUY7kKJdb3LIEIWQBf0EARYkR4UNjEKgD3u3+WhKhr5iWiFuU48SBI8PQxeSjqOUyAavahWh8w6Yt1OubBUhjgGK6jhmLdxMiS94oP/MEpoMjHMzQWfH4BEfmBm1sePoZriFxQTDzHkaWAzCqbwfQMGCPD4+z9gZh5aeUPDemF12JiSJxlcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH0PR12MB7840.namprd12.prod.outlook.com (2603:10b6:510:28a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 19:43:00 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 19:43:00 +0000
Date: Thu, 20 Mar 2025 16:42:58 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: Avoid introducing more races
Message-ID: <20250320194258.GK206770@nvidia.com>
References: <09d901ad11b3a410fbb6e27f7d04ad4609c3fe4a.1741706365.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09d901ad11b3a410fbb6e27f7d04ad4609c3fe4a.1741706365.git.robin.murphy@arm.com>
X-ClientProxiedBy: BL1PR13CA0172.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::27) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH0PR12MB7840:EE_
X-MS-Office365-Filtering-Correlation-Id: aaee2a94-4c77-4d24-97e0-08dd67e76bc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iqWOIrOnc8K5VleQw1cfzluUeiZsorBJj1L1WEm4Dyov9boHGlSdFjnPPBeF?=
 =?us-ascii?Q?yzVtnnchLojV3syzSROhW8qgL1zsUawtMdaSEC+B9Ue7C6OZEOyQkkv60thu?=
 =?us-ascii?Q?bzUVsyfvbqI/kKDej/nz1RUI4qkVY6tQKMOyZO0QP0dMoMolOa+WLSJnkHpu?=
 =?us-ascii?Q?VmnVefl+hyV9RM97GpdAAJ8YYVZkmJ4+7NqHDEd53GNoDPf8L4ciioaovHCx?=
 =?us-ascii?Q?jyzLY+0TILQTY0dLhAr3qEHbV6HjwCPoXHmVR9tH9hiWjqcf4qyQcSv5jHdE?=
 =?us-ascii?Q?CThs4qMESHI4Px8EnPYrtDhp1piRVYlETs0A/2p7XmakZmPJP+wnq8M7ofg4?=
 =?us-ascii?Q?Waawoxo9IBJb522ldWyxjNdL5R53SgKIQ2wV9OaK/YTMD1e3VlBfbP51ZHiC?=
 =?us-ascii?Q?1yH5g1PTm0Eox/rkB09LBWn9duXcDTAJX1uEhoHBafnXLMCMghH6hQmJ0ORj?=
 =?us-ascii?Q?NfcTHzrbiRQqZqOJ9k7SC4F1k6Bm2j4Pd/MUPXIEBkXX/EXiF8JqnJZhzwE2?=
 =?us-ascii?Q?TyvK5v+OCMkjkHu1uJr0b58sWSAcQvA4mv9L0SN2ysrXNXi0Pho40bKJCgFd?=
 =?us-ascii?Q?ycDlpQrI8Ix12KwHWR18XgnWAjGiQpwVbUdd4aAJdcd9vbnMIo53F35bNmli?=
 =?us-ascii?Q?jsCSJfU97uvBeSLDcsJeT8wwcfpYlHX8vDdRlIe+OXT6qBaK/ZXMSUe2kx5J?=
 =?us-ascii?Q?nDwP2uM/BLAcmyLWWXnhu5F9IMqs09y8se2lJ/4QAS7Cd7MpbsmvaO0IJDos?=
 =?us-ascii?Q?yQCo/3IqktBxheLWLFVSBghS1+pBUsXitricjQOXGHvpWOIFhthsAXnepy/E?=
 =?us-ascii?Q?y7aUnQomwhsZNmsxch7j6XyCbiDmphGkjsBReP0WSkw5XETq7ZPt74MKjMXs?=
 =?us-ascii?Q?6FxmGxiK/BY7EJA4DU3mOsLfOBY9xIgzwo9Q/cOwSe7jQbMmux9MMhArPI8d?=
 =?us-ascii?Q?rKLZhwYr673C21e26i6bnlsEaiCZ2JXSrx30B0YEM0F4r7+vdPiXcyBps4HW?=
 =?us-ascii?Q?AalEQzyT+HdhSkrov2iwPq8zCyYBJPj9QupIIRdkUYTUlg6N6wJe6jr2y0RD?=
 =?us-ascii?Q?gGF9CVn5/5vUTuzycmRzSkEzRJgdW7bEmSBdpV9cAJxu9JracL7wn9QUkBWW?=
 =?us-ascii?Q?jnSBWlWxTZWuetGxYxumnv231tLqtdalI/SkkeiyqnbLKSItpUyVx1YzWsun?=
 =?us-ascii?Q?xosx34ykC6WNv16aaFgyMIS/tFj3kOJcxUoASEKYeFCyeMVrjmv1MnFjGqwH?=
 =?us-ascii?Q?l9iClO0hjpeh1cdOakZMgrtx+4z1gs19Ayt5tphbve67NzxGIqcOmH6WELYF?=
 =?us-ascii?Q?Vk8ChMQbsgqJFwphZhg3Hn+bssZSNxIRZAqhV8ra5smqLlm/aJ1XJgNgZ0Jf?=
 =?us-ascii?Q?zQmJhBb+3eWC9lUkREuAD2L5Pmy0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XO4kCeslD5dO5ScFAjjS7v8qLyTTZaXo2KzaORJnT37eOvGpYXyUpeGUo+bJ?=
 =?us-ascii?Q?dAdAfMVOnmsaf9sXFeX9F5sbV//zwH1FDNlYCfXlamzpqprxv171HFHqkftI?=
 =?us-ascii?Q?nANjKUKZvsgrHWTJ8PMw2RMROnNDlz0a5MRMhiiTPMdObJq+8f4urk0I5tBP?=
 =?us-ascii?Q?6fuYjyYWto1B8cTb+yKodXc07B5cebFPgTRcICmSVCwTkgU/agGi6wqJeSJB?=
 =?us-ascii?Q?3JBayl7/0y5RQqi93gFPLzZ6op+motT2hG+tEaEy00xbzLfKXUln5bao9nKf?=
 =?us-ascii?Q?3dAjK25Oon2HgWuNkntpA8m+r+kmxu1ypDe1NoYAgaoWtlN31+/sizpls6Gt?=
 =?us-ascii?Q?HjX2NxccXkLPc2bo5MaRKmmM36lRwWUpSsIonOeGAZYvnAZ1d1IEo1vQPniC?=
 =?us-ascii?Q?fz8FVGKzEJsuafd7MfBlbQpY4t3ptX3fyoqj4LV076sK2RRllq5JSacIFhUF?=
 =?us-ascii?Q?FLFcjU9CwvcYRFkInCDr9KZre5d5LaLWnQ1B1Kl1POjlrB2xzTAY/8BGmKtQ?=
 =?us-ascii?Q?RFv4kFARuoMpBiyJTXFsD1q70K6xlVUk0U50uwrlNZ1XRMz0smUQ/dijfO79?=
 =?us-ascii?Q?o74vMx1SByKvoP47u3G0X8ceC6d2iIEWsF10baUpgIo1UvUzILe5nDbcrQ9C?=
 =?us-ascii?Q?tBbP23mEEvpVL7Ec2n7FWtEGoxRkvsd5LYaA2GjabhGsXyPq0ZzJ1Y+0vFuU?=
 =?us-ascii?Q?zpSY8F01/cjFPszmWtLBCv5uJ07OR1Fdke3VsYb1CXiFG9sB7vCMq5Lf6Fo7?=
 =?us-ascii?Q?TAjPbOmqEnqY8on1rBVaAGmtF6G4SDbkWvZwVXiWm2NVj7/ExqWUCFDI+v/r?=
 =?us-ascii?Q?L8m9vVtbHcgmCrvAf94fsIbZZsCGhXL8SRjDRcnO9WtG5BhP1HVLCCW36Mq6?=
 =?us-ascii?Q?soxth/Uaon/umi08HMUhYoCQiI6ZMsHVHGPBEhU0+VRoUSsMkbAqx7A0BypW?=
 =?us-ascii?Q?KAZVrQpqKjZ6QxiHleGZL7o3jR15XIqz/QeNvBJnSiOYxXEQzdXHMPfbZwEb?=
 =?us-ascii?Q?cPn2v0qA+ybJTb+VHB6KsQBV43h48b8KkVGq5a4ImnoUeEJ4uIAg6RnRmKyi?=
 =?us-ascii?Q?2+NsPZUJmu+Sa7/5XnrN+5yAtl06JWp2hruJi1/xE7yhKvo5V7UubTQ+m/ZX?=
 =?us-ascii?Q?Qaaayhm+OXAodJx1hy0ZjH58s5rtvirX7YMRWPT7AS8t4IHuNIwc9rmUHC2N?=
 =?us-ascii?Q?cFHuWIg4RAskf4obhlB/eSA/O6mJkayjdvCac962Y1zBz1GMY3rFNNfTdq1m?=
 =?us-ascii?Q?sFdKD9x2WaRAh2zKlApM0XWY3LMiDJmNv6pFhlTsPcVXxChuIaE89OKTqrCB?=
 =?us-ascii?Q?pbnZ/yLYA4sV/pKmBldIzk8SC2FSJuZUktqLUg4XqaTa7Mbk0GLFuFyhpplw?=
 =?us-ascii?Q?H/6nsCmUUGNnm9ZQR+m6vx7SiObqgDiMfFaM0ENVDfRHrqgWJQsvb5BSBc9Q?=
 =?us-ascii?Q?c7h4nm91VQisya1lkefDdRzq3Zdc4A+SOrtfFJZLu3QR9sHdmQmUbguH+3dU?=
 =?us-ascii?Q?0BPlatDCGMpT/7YOaAXDIDft0xiLvkSiZ8k/y71y1qwC0+Krsa0L1QFk1TUw?=
 =?us-ascii?Q?93BO1RQUxOOBlEFwvcL6QPzHVhozMARkVQ5WW4N9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaee2a94-4c77-4d24-97e0-08dd67e76bc2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 19:43:00.5906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nV1SjwcnwUI5MFZTdaOpPmhkrUMCMfu0PIW95hyqBSq6jj9UEycOvpjBNDWFHaYM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7840

On Tue, Mar 11, 2025 at 03:19:25PM +0000, Robin Murphy wrote:
> Although the lock-juggling is only a temporary workaround, we don't want
> it to make things avoidably worse. Jason was right to be nervous, since
> bus_iommu_probe() doesn't care *which* IOMMU instance it's probing for,
> so it probably is possible for one walk to finish a probe which a
> different walk started, thus we do want to check for that.
> 
> Also there's no need to drop the lock just to have of_iommu_configure()
> do nothing when a fwspec already exists; check that directly and avoid
> opening a window at all in that (still somewhat likely) case.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> I was rather expecting to send a v3 of "iommu: Get DT/ACPI parsing into
> the proper probe path", so I'm grateful that v2 was picked up, thanks!
> This is the difference as a fix/squash commit instead.
> ---
>  drivers/iommu/iommu.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
