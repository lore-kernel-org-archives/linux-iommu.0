Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012007.outbound.protection.outlook.com [52.101.48.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFFB54147D
	for <iommu@lists.linux.dev>; Tue, 13 Oct 2026 19:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791920164; cv=fail; b=UFtmtxJDvkK/QWKF/B8Zg+496mT/f1DBLFJs9HSn1L7o25wv1ZrJSlOBgMhMLzEmEdyQ68+UgFTSeKsvYgBmcVdFQuZq9Zv5ecRfEueJx5ZxF2eQheELKXaNfQ36NFD4RZTkyUTD/WOIXMAQhYUoeo8POzouzxG62mmoc71+Jes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791920164; c=relaxed/simple;
	bh=7GKagMjp9w4UZCKTV793POlGSHcCYhBUivtmap38B1o=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0UTL8MTR4cIiQ/dIHgeplrKSvEl2pm9oy+40PKn2y+mpvagDWf+L4deCNkblhJDerFvYMnSYpXhYxEYPhRLTojzoiIJqaAck103Ygg/DYZJ6VpQHwsXyXd1Mmdo8Sqa2wJUpsrJvS7lJ9eknaM7kc57UyXM6U92h0Fu1C55O3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aMgtdzsn; arc=fail smtp.client-ip=52.101.48.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aMgtdzsn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xkR2q+xAuBy42531A4N7olBn3//0i1sZdIyb9fUjijNGM8/NhF5vhqjxG43r6VDDRjqC0+1rNJnjgupGqjg91q3OqbxWNzdv98yBH2YlJN/I42XOxgTUGq1jkVZbT43AnYF+Q699rG2NL9Vl2OCETrE5XucoS9dwO0vW7LP4jYyiD6vBth0Kpr+tG0bSyeNMWkE2AzyxuoNR8JvE5pG18BTDNwrhf+bYxpKVYNN4JTOYvIPgwfpdtr42vVZA79DqeBNeFUMCQn1FdzzkmLWXQcigXhNHnEBa3HRsljhCiYzgZdH8CwWIHYooYur6NuEgO/6zUXZm/s/cZLWaCJOrAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vzeiI+gayp9EAe7RxgwBRYceR2ZzbZYo/guosxXjHcE=;
 b=sSRXBmRGF7i++o+mzmVaqknwdky0cNr6sW8/vkUnDLbNwYF+EtRxgjIpmPNTojqj8dYblhKdV82OS8X+Jry+vl2Abw6ronHm1ndhAGIgEJQWqt5rPvlD7QkuPXNUKNRM/EKtxVD7XNCBgUozcv0EdyTwELbSYCnkRJ+KDfdnsT4p7VsMyCWCS1E5uPYcbJ/LVbVM5Jp1sfo1PZfLrxomofI+aOvzlvOBfxiKT6m1QOZa30JR/4tT1FxMVqw0K0WBSt9CcU1rWUfKoIsRBWpvZRBigKZxc/oEkSTSGCZa5hwdjBbmFrKvpRBNQ+pnMIOHYz7HSW2mYeFBKm9DXdm+ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vzeiI+gayp9EAe7RxgwBRYceR2ZzbZYo/guosxXjHcE=;
 b=aMgtdzsnRyVI+0R+pQjLpFuQLoOkYQgkuMvxm15a7zR0aYzsVbZSEf5XittQ24PS7QwzFCnoJJV/ylhgwZ4uUmngY1WinXPcJInVLFwcA5yBSM5LcNLhv6ftQ2w2j4QCnkugoOPemd32cgGiHMkRs13diD8nHQcY5jnPMBcIiCoZMImH1+okn92j24T5ys1ry6xfR+q22LWmIX6N2/CwyQYCnrYG9d6XSNNiIYlcot9tg62GDRR4ueJ/qRsEtlPwsHTmTGbqEOsmX/8oRwZh8J0D3U3LRMbVBq9fveGd6y1YnNihOWBK97cKX1WzNxUkGgrFARBxqXIC030MCG0WiA==
Received: from BN0PR08CA0004.namprd08.prod.outlook.com (2603:10b6:408:142::22)
 by MW5PR12MB5599.namprd12.prod.outlook.com (2603:10b6:303:194::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 19:33:50 +0000
Received: from BN1PEPF00018072.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::7b) by BN0PR08CA0004.outlook.office365.com
 (2603:10b6:408:142::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 19:33:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00018072.mail.protection.outlook.com (10.167.245.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 19:33:47 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 13 Oct
 2026 12:33:24 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 13 Oct
 2026 12:33:23 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Tue, 13 Oct 2026 12:33:22 -0700
Date: Tue, 13 Oct 2026 12:33:19 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Peng Fan <peng.fan@oss.nxp.com>, "Will
 Deacon" <will@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>, Thierry Reding
	<thierry.reding@kernel.org>, Krishna Reddy <vdumpa@nvidia.com>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH RFC v6 5/5] iommu/arm-smmu-v3: Wire up shared-SID STE
 ordering and feature gating
Message-ID: <as6HfzpcalIh6SMs@nvidia.com>
References: <20261011-smmu-shared-sid-v6-0-cb76b89dc612@nxp.com>
 <20261011-smmu-shared-sid-v6-5-cb76b89dc612@nxp.com>
 <aszfVNP6DGzWYdK0@shlinux89>
 <as1zR1wc7ERxvR1F@nvidia.com>
 <e8c22eb2-ed1f-47c7-b2ac-c56ead1cba8b@arm.com>
 <20261013124400.GI14213@ziepe.ca>
 <4d2a05c3-f7f6-4348-a3b4-c8f3ffa79b6c@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4d2a05c3-f7f6-4348-a3b4-c8f3ffa79b6c@arm.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018072:EE_|MW5PR12MB5599:EE_
X-MS-Office365-Filtering-Correlation-Id: 789ba8b1-6d6b-4d1c-0180-08df2960e704
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|7416014|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	YHQ6YIVvHu4uVyyc1qOayqYO3DNPsoNptiMcCHhOpCvVG5fH3BpRom87ajdP9KarkMqFnAQ1vBku0ZEEs/J2NaPpKHsHr1kfYgOta1Sx/NxgTC91qYWYJCL17dqabAKpyeUwxUOSKZz8tBKpdExVbV9w9pS6hSszTsszKu9PWDwGAgvm5HI4ZcE6HfEQejISIrReL+sYSxkZtVY8Dvward8/BTwV1RZHsBX4s91ZNDyvc64TthX0uNZItq7/jkRBM91SHqT1jbhObGYRLDfPgHMHowl9hym2NXrlj96LNDF+1LkFoG1hLoqjVdXXgnhR7lt7MH7R7UvoxzPaXh5PRus5bbINCdmYGq3Ymo2ycSmiXj2qn0nrTkQM9MJVsVgI2c0qgxGWDpUS/8gM6a4EriMKkWYoo2AvDho2t5eLWz/te7VwRvbLWDr6x6O3Qol4WD8XZQa5LS4tmNcMbcwwee6a5qSRCrp10zfV+E4EGvEmB9DofbFVWt9UOnUszBDJKBUU2HrFHdOjC1c2Cg55EDf7B0wQ1mBkD5RgnQPeYCN0OTLyTgUBxL2Tm3p9/VBhxacSaGFz3RqWtEugiLfccBCPIxfNiApJk4sH7A8ahKMRfCuLajJXK3Zd/I32MBvEg4GVjoEC6MxcgVsyEqBax935B3m8obKj2QoyObwhS7TpC0amvPqhR11zSDNj/986aM71dqy85g1mu6gY8ufyjA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(7416014)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PCFai6p/keu6aQQuiIu+aBSK5VYZVFP3Beg4qYQ7yTXWMgTMErz+JAObrNNhwcHIPuwAwAJfEIFYmIXnvXIzOEDByyjjlwXDTqt9ZaqEBGqHCZ25yHYZIcdJWCXRM6Ou4umiyjS1WRQKP/TiV6eRSsYhRzFFYtAMDYb/Bx1DNxihG05DBf/J16gOtAfaHPUfXY9T0aHTzuSBP80wTpcrNMwcx0EfBSwyExJLnqfFvVTYOdJxDrr9o8nnsyMHnLvYHB37cTHJSU+xOwZE4bbo8bU2d+nRzVy5+wpldWqK+sdK7WLr6Ig0Hc03b4U/5X3/qlRYlmEsgGVwIZp2vCV7Eshtm9pgGao372vtaiphCDs/vmGqnZHrgHOyD+D8gEfD56HrrasTweWflKT1Z5bwoWUB0Aq0+XWZ4HEv+9MitnaKesmKB0JdrqDvw6JaC/od
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 19:33:47.7432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 789ba8b1-6d6b-4d1c-0180-08df2960e704
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00018072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5599

On Tue, Oct 13, 2026 at 05:23:21PM +0100, Robin Murphy wrote:
> On 13/10/2026 1:44 pm, Jason Gunthorpe wrote:
> > On Tue, Oct 13, 2026 at 12:22:06PM +0100, Robin Murphy wrote:
> > > If we're not going to support PASID for shared streams (which I suggest we
> > > don't...) than we shouldn't strictly need to worry about CD tables anyway.
> > > So rather than having to special-case CD table sharing for shared streams,
> > > perhaps it might make sense to generalise back to a "default" per-domain CD
> > > for non-PASID use, which can then get switched for the private per-stream
> > > cd_table if and when a device does enable PASID?
> > 
> > If we have stared STEs then the group becomes the per-STE data
> > structure not the master.. We don't have any way right now to do that,
> > but it would make some sense for the group to store the shared CD
> 
> That would be precisely the aforementioned special case that I'd hope to
> avoid. My point is that the CD represents the domain context, so we really
> shouldn't have to have multiple copies of that per-device _or_ per-group,
> _unless_ it is attached via a PASID, since in that case it does need to be
> copied into a per-device CD table (since the per-domain CD table was indeed
> the wrong move in hindsight).
> 
> So what I'm saying is that if we're going to make anything share CDs, then
> ideally we should just make all non-PASID devices always directly share the
> domain's own CD, then if we just enforce that any devices sharing StreamIDs
> must be non-PASID devices, it should all work out, we save some memory in
> the normal case, and never have to be concerned with rewriting any STE with
> a different S1ContextPtr for the _same_ domain except when enabling or
> disabling PASID for the (single) device owning that STE.

FWIW, master->ats_always_on would be a special case here: it is
non-PASID but needs s1cdmax to be non zero.

But yea, that sounds like a good approach, though requires a big
refactor.

Thanks
Nicolin
