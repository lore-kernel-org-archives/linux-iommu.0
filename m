Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010043.outbound.protection.outlook.com [52.101.85.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809D4243964
	for <iommu@lists.linux.dev>; Sun,  7 Dec 2025 04:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765082261; cv=fail; b=Bz+R+K4MKIvO3zzGpslLt5yKj6FJ2zMuy1XOX0Epl3eIUJuVK5ui5qcZ/vj00IfuK8uEV3thyn4scPlK0n65QcPWAylAJm5lAqbaaq90DOnSMG2TObGhWF+pphJm+eTgkZo2obnA9G7vbhQuGnUCG3dHbxyDLKRMWDjsXfSsh9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765082261; c=relaxed/simple;
	bh=Ka+wj2YAIx35cAcG+LAiYDmQCKIUVGdFIKMWvGTddjY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B84LcOaLbwOmQAF7l3Qc3xUVIQyKIsi4C5JHhg/gbMHb7l2B2Yl128Q6ahLa6BcyJj/IOh9Cwqvd9M/qRejpaumFUaVO1zoXAVc/9XUzlqxPX7rXFchxXB8p9k9eCP20cNFMaX59Er9aTZ9/AMqvZz9AERUzgCIE6Hf8cYVvwFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FKSopptJ; arc=fail smtp.client-ip=52.101.85.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FKSopptJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JN6pMbpgaXAREQUyAdBKXZsC2tz6PxBxUCrj2y4V/e8TYFqZdWVxTRUUUg1H1tVa0GZAO04I89KyWuUWguDt/i+f2eItFI4VyR5Bp23FESaY+UQ+CuXysVyiWA28yYvzRaYkUwxmii/YScNHAaiEjZvvzih7sfuKHMHIgUxV+FleUaJYjV6ArEmLBbpkkYcnuAKVTUTGrK6sCPmBgorQ2BdDKS4zE73NhqJ7SWyqaO24Z3PI5BTvQqE9UNwkp+1M2h4+bIoo6BBXzF1bfgzZr7BnuWnUg3GXEc76gxYHDETqBFVNjfFVc3fapBFLDSWGRvkAU20pSRvB3od+zOKS2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afpksrLSIiuM5pMowGZ8a5ZhgCT/NZBQ2uCKcm2+3hE=;
 b=kCZbG/AdGvoThwWuJn+Bu8W2bgqqnVMmSjOsqzB9Ebzd4WpUxEqgdWw3ltNoLl3tGGKO+/xx3dAA6WFNsvWRbNb4/dCdH+z8RU68qV5WSPjNoqbcvFjkundw/Pps3b3vJ5Q2aSlFwkyRLTsbdSWVPBtp1lfgkOa++UMYU+LOuz6ZAGUCpCcW6cFcBWFvewmeizYHGHicPuQRLF936W8pF8zWMwQW2rKH+dlxnopx3IiVWGnu6PXyX342gUHjXnODaugK2fIHdmK2YgQa2lO6X56fJP6FAQ5A+PJczbn40YS1e9xRVhxVOU8ioHYm/Cp0AbXiYdRDCBFHdSdTvJoZmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afpksrLSIiuM5pMowGZ8a5ZhgCT/NZBQ2uCKcm2+3hE=;
 b=FKSopptJq1Jfo/4CPzOuqj+02FdHl8nVTRxS05zIdZBgectXCXO4sN0m7T2ywid+7vBp3TaXCFJe4ohTAJal6iBUaO1qc8F8a88aShxpnr3ilDQbSo6/arUAJkNQ443ARIySyds//m9cvpZ8Q7qtN2P15nCVJdauJM30/NZ7BXH38UvQIF6XaJMTPy1f7jrhbPJck7Zqml/5L2TCMlvGavq2V9FkuZR1qi67cYU+NgxqDqMRbSEhBxkhac2O/uzzW/Ygv7QE+/r0D9HXNf7NVUX1YWrXtN6/zk7JspM8z6V87Jz7Qvv3bFoZrrphhALMf3xzymdC7LPPQSOcpbSBPw==
Received: from SJ0PR05CA0210.namprd05.prod.outlook.com (2603:10b6:a03:330::35)
 by CH3PR12MB8754.namprd12.prod.outlook.com (2603:10b6:610:170::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.13; Sun, 7 Dec
 2025 04:37:35 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::b3) by SJ0PR05CA0210.outlook.office365.com
 (2603:10b6:a03:330::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.0 via Frontend Transport; Sun, 7
 Dec 2025 04:37:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Sun, 7 Dec 2025 04:37:34 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 6 Dec
 2025 20:37:34 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sat, 6 Dec 2025 20:37:34 -0800
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sat, 6 Dec 2025 20:37:32 -0800
Date: Sat, 6 Dec 2025 20:37:30 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <skolothumtho@nvidia.com>, <praan@google.com>
Subject: Re: [PATCH rc v1 1/4] iommu/arm-smmu-v3: Add ignored bits to fix STE
 update sequence
Message-ID: <aTUEikcWXWwKAS/1@nvidia.com>
References: <cover.1764982046.git.nicolinc@nvidia.com>
 <6ec73bb7cd03d90a0764f12c4b14071158163818.1764982046.git.nicolinc@nvidia.com>
 <20251206193408.GD1219718@nvidia.com>
 <aTSH5Eap7leYQtPl@nvidia.com>
 <20251206195752.GI1219718@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251206195752.GI1219718@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|CH3PR12MB8754:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e8adf79-6f4e-4836-0b2c-08de354a57b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WU6Gp9AnL/OXjZasDSJYzQm48KKBqt6I4bZshKFtchNgfSjbK4jBdeeI3pji?=
 =?us-ascii?Q?F5yYFbVTAzFyFK6UIgMLFExVakPTmZNKx8Xo6udUwUqBuY74KrijURv0MP3m?=
 =?us-ascii?Q?qfX9S2i4D7dXu5fa6kMzq7OFzOcl5bnAAbhRgCJdavmxrTU+TSxLvPBEzn9U?=
 =?us-ascii?Q?ge3Y74dSFlYA4vgu2jc++RWsrVZDh8nWkPb1umdI1CnawjObZkgNUyb4lJtX?=
 =?us-ascii?Q?rWIYDJYWm/UmdwDkWhEwYQgAEBkh4bvnbrX7p/PVoN0paYuqsQ1sCQpH2PjD?=
 =?us-ascii?Q?aVG2pAY/7XSWmWlA86rDG5wcSzaKvZ5HETS760PYPzf5pcT0xD/CrAx2dd53?=
 =?us-ascii?Q?uzogoov5Bd5nd5YCYM6DCbMgSbNXJgRhyqGBlhgFs0vIkRhBAs46HJuUv61g?=
 =?us-ascii?Q?NgcNgFIMsNSB83MVnk3BPvldkpxzv4i+GKXLZkLOCvKCa0nwBAF2mTnm3PPW?=
 =?us-ascii?Q?iFtXSbnCEvv6HXgak0PhLiGRz8ZmPenctUbPu796HSStEWW+MhaPPbwHNC5m?=
 =?us-ascii?Q?T5oxZAKJtJufGnymFmJ5pAdj830yjbhnO1C1Fs7GH7yz8h8jVIJi0MKzAEec?=
 =?us-ascii?Q?XqvkS+Wib7wWibcP3xMIj52OfySYWa9cg42vURfqE4qswFY7rvQJfJt81jEW?=
 =?us-ascii?Q?ZKC1zPITi0j6N8yMEb999KGaIANiYaofhJ8lFGDOD3XvCJxwQgymJ4yl+/C6?=
 =?us-ascii?Q?ZI+sWbFlEm4Ksc+A7Srjqxlif2hnSARwaTqGRDHQxTtA3stDlQ6EJ5/UORgn?=
 =?us-ascii?Q?WgEVTtCrbIk87484llyFOr0s3i1YPLUumduG/QaKU/vRYWVcA+Sc69Xbb/eh?=
 =?us-ascii?Q?tk54lZCo8agxOS/mrS2OkY2GOqJLu4ABBoAkCt6o9499AwihkT2xcEPt9Scy?=
 =?us-ascii?Q?lALqdzKnrMp10rwyQE9/Mrk1+5ZS6xdxyb+GLJdHmmTjx14RZ8G7Z6T5vg5M?=
 =?us-ascii?Q?qAajEvlumc7fDKSP9wPFa81JJLksSsIKF9I2C+kRqLVKBoxFdBRaxtUm7/lm?=
 =?us-ascii?Q?QglpIMy1EdSSgzAFRxgOrpfijUljIMCO6Q+3oJGAcxGhplSspBjUr56owjGs?=
 =?us-ascii?Q?nVyGm5SYlAO3WIcOGI0OpV/2HqZ2YhWwAt4IxUQWx+eXolYBal/1U7DmHbzJ?=
 =?us-ascii?Q?5WJLurZk/D/QUsZXe0sJEQZrLQjDcnGettdZ2e2KvskR+yyt6ABmOLZUvTLS?=
 =?us-ascii?Q?3R85H11N5vXaaWVlJe/91dGOI/MF2eFmucpcehd89x3grP73NN90d+RfV7xW?=
 =?us-ascii?Q?vpp4djJpGWWuaWYbNWQyPXZs6MH3QCQFREOcLraBAdysn/BD1w1+u/kKgDys?=
 =?us-ascii?Q?TsmXpvC3scTF/5GBOAxp2qJha0DGeqxwffPkGvIJ3u5E8/GdfadNmOv1riR+?=
 =?us-ascii?Q?3PGSR/b9B4PbjJyGKAqJRXGcEqksdOsieAoDDJulydumPR1vTZ/6ZSzGJ/mo?=
 =?us-ascii?Q?G+RVHJ2eLLA7nyRtv0IEJG4q/X5TzT5gfnv3xv7KsjNAKagW9C4fDE5iMBFM?=
 =?us-ascii?Q?Xl9cOy2FQXT5+XCmi7lTxGNtnCfXGAAnFqthvP2IlhQjI2xACg45KESCSQje?=
 =?us-ascii?Q?SgVJ/1o7ZWpGA52C69E=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2025 04:37:34.8133
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e8adf79-6f4e-4836-0b2c-08de354a57b2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8754

On Sat, Dec 06, 2025 at 03:57:52PM -0400, Jason Gunthorpe wrote:
> I think that supports more that we should do what Shuai suggested and
> keep used as-is.

Yes, that will be probably cleaner.

> Then ignored should be adjusted by the used: Only if both used are 1
> should the bit become ignored. Otherwise we can rely on which ever
> used is 0 to generate the hitless update.

Hmm, not sure why it has to be both used.

The unused_update is computed using cur_used, and the equation for
used_qword_diff is computed using target_used, either of which can
be affected by ignored bits, right?

E.g.
if cur_used[] includes ING bit, target_used doesn't:
    // target must unset IGN bit, last equation isn't affected
    if cur sets IGN bit
        cur_used should exclude IGN bit
    if cur unsets IGN bit
        not affected
if cur_used[] doesn't include ignores, target_used does:
    // cur must unset IGN bit, cur_used isn't affected
    if target sets IGN bit:
        last equation must exclude IGN bit on both sides
    if target unsets IGN bit:
        not affected

> @@ -1109,6 +1118,7 @@ static u8 arm_smmu_entry_qword_diff(struct arm_smmu_entry_writer *writer,
>                 WARN_ON_ONCE(target[i] & ~target_used[i]);
>  
>                 /* Bits can change because they are not currently being used */
> +               cur_used[i] &= ~ignored[i];
>                 unused_update[i] = (entry[i] & cur_used[i]) |
>                                    (target[i] & ~cur_used[i]);

If one of ignored bits is set in entry[i] but unset in target[i],
the unused_update will first mask it away, resulting in an extra
unnecessary update (though it's still hitless).

So, I think this might be better:

-		cur_used[i] &= ~ignored[i];
+		cur_unused[i] = ~cur_used[i] | ignored[i];
 		unused_update[i] = (entry[i] & cur_used[i]) |
-				   (target[i] & ~cur_used[i]);
+				   (target[i] & cur_unused[i]);

Because cur_used includes ignored, the unused_update will retain
the ignored bits from entry. On the other hand, having cur_unused
will also retain the ignored bits from target.

One more change that we need is at the last equation:
-		if ((unused_update[i] & target_used[i]) != target[i])
+		if ((unused_update[i] & target_used[i] & ~ignored[i]) !=
+		    (target[i] & ~ignored[i]))

Either side might have the ignored bits, so we have to suppress
ignored on both sides, which is required in the similar routine
in arm_smmu_entry_differs_in_used_bits() of the kunit code.

With these additional changes, nesting sanity and kunit test are
both passing. I will do a few more tests to make sure things are
okay, before wrapping up the v2. Please let me know if all these
make sense to you.

Thanks
Nicolin
