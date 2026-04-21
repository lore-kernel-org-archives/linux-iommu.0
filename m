Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011004.outbound.protection.outlook.com [40.107.208.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A8A7260F
	for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 18:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776795053; cv=fail; b=pceLacLQqvISSdCLZDDggpMVd8jXxrBdRcQnTRnUjxbr049Hkkn5FIDcNiadBqyklHsXKd9CpRxQydmFrwaDsuc2VbDo5tHJRjtqtvlO2/v7nKVj4l0WQMRlFRr6nRIooAZ3SzSPs1nypd4DxYzkSkGWHRzzh25pCFIWlcD53Rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776795053; c=relaxed/simple;
	bh=CaAPZbVe4mYQ0E3sqev5i9EJu5n7gxuWwlS5KGcvTbs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdlxBP/sByGTNCUn8lnxgX4TC3NZ5uAD4ns2vUW0ZhDky9p292xWEfWHqU6KHoN1y8csDJhQpd+3YDmpuUCW2RZILWqjyd96YJjLRc5MZl2Qmlga5zMWt/tFkKHF1PwLsOcUkG4Z8zrMB6iMHa41gopyUdOV8/fvmUoAPHbaaAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V5SFvnfs; arc=fail smtp.client-ip=40.107.208.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V5SFvnfs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zJ4fIsfyei+p3aFIIS/0aCglFN1am0WDI8huM89IWKCzWhxCtIW6PHjrFLestPSjqKECaQO8cVfggRlZwngC8IyyAPF5LIPrQ18s9ICvXoAcpSs/SqpUvjLNjjV7+6v2lamx65bfnoCdCu1J3WbFvtKnCc9s14WZHKh77xITg7ADcfcRqMzlK29FWHlEWTjJh6EnG7GzEuhjqYWHv1txnuIw4Dkj2GMy/9gS5D0dxZI0uf1TB/hRMbmtdmtnbIw2isLOyukUZrlANE2r+jkw8XRERfOwwitc9/VQvhe0YuJnvfOgE+7t3ctXWnUx5wm83KQJH3F85x6SLn1b1+dcwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLmKLZmNSZi6T4LroKSL2sbC2JOjXsOw6EqTxf+v9ig=;
 b=se8btJB9t4l1ZcE81BbcpY10KWP0p7iPrBjCNZMhSF+7W6X+gJWZM3stJGSZLf/QoVrCYPbVvyxVdpa7RuVe1+icWcmS7zCKzFz9x1FBBOLX3vHHPGga+3p/uEBpdIJ5z7dEQzCLuvlyQfBPNw/XI1fW6s0zxRPM1A9P/DwHZu5Od42dknYQ5/y58FDADhc+pyv7QzrAu/AaLw86KGZYN0sYFlcqBAWHbkJxTHUFoTOMFBG02zvoppGjZ/V0h0lfjgqLhn+Eeq5njWYM+uscvzHlYKIOr8dUdKYLYKpNEDhM8ba1bwNCfjZjhIIZDf9+574kDzezWOipEJtjsSYvMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLmKLZmNSZi6T4LroKSL2sbC2JOjXsOw6EqTxf+v9ig=;
 b=V5SFvnfs3XR2agNcKT569RBcbs8otaMMg6k+TG6U0Iqzqj9Mbfv4wxTYe97AJHFxLbDFlQ6btE53DmYzdF71HUgy5oGDTC821pAFN/e0Qgd8b6UK/Alb82bqtfAZih3vsDBVa4gpPn3Wop8Pa5Ucv4LuL8tCUOFjyv0dbNbY4/1xN/PRtK3k2dXFWBKmG/cbRDVG8weULeTO0pJGon/zKCzUW7RMX3f9++vBLbJBnzy8Fio9X/WnzqQo39eRW7pAOC9JoLMUQiJ/kmwK5e6Byny6gsgjgLGn3bfdUhWR8stM94zLl7LPbInPXkBKJT2RND01a+bix7vvsiwDgSaugQ==
Received: from SJ0PR05CA0142.namprd05.prod.outlook.com (2603:10b6:a03:33d::27)
 by DM4PR12MB7597.namprd12.prod.outlook.com (2603:10b6:8:10b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 18:10:46 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::fe) by SJ0PR05CA0142.outlook.office365.com
 (2603:10b6:a03:33d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 18:10:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Tue, 21 Apr 2026 18:10:46 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Apr
 2026 11:10:26 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Apr
 2026 11:10:26 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 21 Apr 2026 11:10:25 -0700
Date: Tue, 21 Apr 2026 11:10:24 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH rc v7 6/6] iommu: Fix UAF in pci_dev_reset_iommu_done()
 due to concurrent detach
Message-ID: <aee9kIdPftQC7/xT@Asurada-Nvidia>
References: <cover.1776551790.git.nicolinc@nvidia.com>
 <96a8ab981d365bdedc5dc705df10414ccf578c9d.1776551790.git.nicolinc@nvidia.com>
 <BN9PR11MB5276B1F1CF1BA54FE69B8D968C2C2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276B1F1CF1BA54FE69B8D968C2C2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|DM4PR12MB7597:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b6113ef-dc69-4cbf-fc6c-08de9fd14f7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	FrYf2sQOE1aEWHNloQ+7mWmR2fH6JO/rqDoZd7R3eYF3dyRt2gGJkpTay3IvqoejqX74ixB39ns3FGvXITwybWRRRhuAy6rKAwXD10qHJawtx5B4pgCvzvviOyhk6ZSDuiyMlDs9t6SUm0eiL8E/lYfY5MlkySPS3Q4S2L0Y/Zz3uDEysHs5sYBGY4sRqbY24uNKZwxC3GIPIE99kbUJyh6548Ii9HTX43IRhbYftmd9sAQTfxDXYmxbiiDHtiy1Cuooj+BcADw23Dz8e8UF4BMGJhcuGpv1QhQJM8zOT1U4fEeWD3/Uq9w58n/u44VT95H1XKl+Pyh7/Wrcl1H91bjT1j5VAmK+zcMsIBsASZPbGdu7NT7UyRt93vHr8K8o3MQpbiKhx3U1WzzivjuGZcUsAe6J1T0EdflVISbtZTEDWozTsSx+JyNRcDxPc3R0h+/rqj54SDwojj0TZuT6D/1Ey4KY7c15R3Gbo4Was4fdemuCmNPV5/7Lr6AlKggDoHRysGtZZ0NH1dXnaxJQXa/zy5aUN+bdIdwMNPjIGvOHG2CGNJAJPWkydAqv32vcIXG4C4Bld5YibH6kXBOXFd4k8rKns/pxY0pIvAycojk1uAAm6VaL8AAnzX4iCBPxYv8UdT4AYUvYqtV/PFKLI3V7xTGEbbXMRIj5ucdUpLbzIjcISdOurNz1R+Th7KpF++nxJPthNZdT2hgYd+FSTpnHRKF1aNxj8lzXygmOj5/3+th1b+gCr89XiUVXSKm1yPvAIiGAkPJSEKeMQC+sUQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XiqQDH9Ryo6n5pqIvopimrwrd9OSV3lZ/xlInSSdOMYUKnqr7RfPeeWep82Wdt62kxVoVaYs9y5kYSvTrOKxclXqW/eIheDi1YItvxSJmzPhECvGB53//LM+khYx8Sex85eu7JKTcI3DAyblLESTsYLLFFAEkHuw1dI8rwRGS3RdaEKZg5Rm5zwTQsnex3JNmOyUzGWdhaGlcJwQ1CsFfew7Lwz+fkySGmFgcz1nkH0zVjaVGnyivmlaJtVZZKCfeqoVIMQ3zHTf4M2VgpRHL75Aa0CSUtqUYRy1/lrtTtvuwpFozqB0QKiQA5m4b11cWJcz28jPNUSnrRmcubI7kz+JN/k7V9NZyqmInLS2lCauVts9MA37RZo9Yyg0MbzR8g8o8JL/xMFBFKf6SxQ+b4Wy7r0cNdeYTENF4WKVs/MH9QcmwUfpioqm9fkdoUey
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 18:10:46.3380
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b6113ef-dc69-4cbf-fc6c-08de9fd14f7b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7597

On Tue, Apr 21, 2026 at 07:41:03AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Sunday, April 19, 2026 7:42 AM
> > 
> > In __iommu_group_set_domain_internal(), concurrent domain attachments
> > are
> > rejected when any device in the group is recovering. This is necessary to
> > fence concurrent attachments to a multi-device group where devices might
> > share the same RID due to PCI DMA alias quirks.
> > 
> > However, IOMMU_SET_DOMAIN_MUST_SUCCEED callers (detach/teardown
> > paths such
> > as __iommu_group_set_core_domain and
> > __iommu_release_dma_ownership) should
> > not be rejected, as the domain would be free-ed anyway in this nofail path
> > while group->domain is still pointing to it. So pci_dev_reset_iommu_done()
> > could trigger a UAF when re-attaching group->domain.
> 
> As I noted in my reply to v6, a WARN_ON will be triggered before any UAF:
> 
> static void __iommu_group_set_domain_nofail(struct iommu_group *group,
>                                             struct iommu_domain *new_domain)
> {
>         WARN_ON(__iommu_group_set_domain_internal(
>                 group, new_domain, IOMMU_SET_DOMAIN_MUST_SUCCEED));
> }

OK. I think this fix should be just "do not fail MUST_SUCCEED" or so.

> > @@ -2482,6 +2485,13 @@ static int
> > __iommu_group_set_domain_internal(struct iommu_group *group,
> >  	 */
> >  	result = 0;
> >  	for_each_group_device(group, gdev) {
> > +		/*
> > +		 * Device under recovery is attached to group-
> > >blocking_domain.
> > +		 * Don't change that. pci_dev_reset_iommu_done() will re-
> > attach
> > +		 * its domain to the updated group->domain, after the
> > recovery.
> > +		 */
> > +		if (gdev->blocked)
> > +			continue;
> 
> This reminds me one thing. Ideally the blocked device really doesn't care
> whether group->domain is the one before resetting or a different one
> changed in middle. It's blocked then doesn't refer to any non-blocking
> domains. After reset is done it's re-attached to whatever group->domain
> is at that time. 
> 
> Then sounds there is no reason to block attach/replace too. Just skip
> the blocked device and update group->domain then it will be picked up
> later at reset done, just like done here for detach.

There might be devices in the same group sharing RID?

> Sashiko [1] gave another interesting comment about dma aliasing caused
> by PCIe to PCI/PCI-X bridge - devices behind the bridge share a same
> RID (then same device/context entry in IOMMU). In this case unblocking
> devA could prematurely unblock devB which is actively undergoing a reset.

Exactly. I recall we talked about it when introducing this entire
reset piece: there was a piece of condition in the reset helpers
skipping aliasing groups, then we dropped it to focus on singleton
groups for the first version. Maybe we can resume the discussion,
but I doubt we could exclude those RID sharing cases...

Nicolin
