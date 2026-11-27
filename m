Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.58
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795809119;
	b=SqPCMn8pdm1T6SSt1hnF1eduJDdnsaqpR1CudI5L8CeTMloZBoDsB/FYiTnqlVW7g1/3
	 oydY4WHvILpDU6yxxC+0suJW0gqvrwt+Jvr9F2IFanM3CuKWahXYzvOwUaiJc+/btUMpp
	 EQr78jxfGim+mntynzIalTo1XC0qcs1EfP4wv5HiEjcuP2npi5KxLYQu3A1ikRXmhYi5U
	 wNQ3LHErnER1HNsCvruzIl3j4B7CK3vD3KTnkFGBgPRaoqZjIZ5Dxd7FK+SHdHcarDK5T
	 Bii3kxIKAtg7DzxNsPZ6Y0+M17lRhu2/rFrgeEQcZOxoz7BEdzuhRwcGaT6RKCPxFWg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795809119;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Date:From:To:CC:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-NV-OnPremToCloud:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=sszx2dCOUrs1iIqSfZgFE+TowPKkpE+xPVt07ojtwj0=;
	b=1Smf+ufFpWwI3Ax1GhNLt7TSFodbiu7chZWH7yKmaNX+0zYvmiNSy+J06JnfZVMnZwf5
	 7rLerFxafYGz4EoJLh2wOMOf3RJME2RJOHI0iZrWO6VZO6em/OchIJ8OeutcuhvF2xXVE
	 22vkslolW1F1Xe8ChP/RwK6dzBmvFRg+mvuu0QmkueO3nS+lbax4gSLtN7SeYYyYKCiBc
	 09rr90Gn7W2yXwY1Dc1Nw70XBPhRXIxid8WM73MZrfXXBU0yOMVt/tpPVJuTxOiUkOt+W
	 7M1s5YW73kJ8sNxT2u1ve/E5cKiTir2/WzneET4GuYlU98lfibrSfKo2zNCrK3Z1Eiw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cDDGOJX+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.58
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010058.outbound.protection.outlook.com [52.101.193.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE497606A31F;
	Fri, 27 Nov 2026 19:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE497606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cDDGOJX+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NIbDN4HEmC1ZhAN58El6HGxhdx2XrBHfCeD2H8XNVD8wq+3pS8t0Qs7QPBAjFI8D57wmWsdCrrRfKfRlLcJTLM/psFNPnkrID9nIe5ICM1yousFuQFIIzopOcSvOro0gXzjESWr+VAPNWbnqOvTI42Y1uW9JLFmwhMPXEqyOrOV+0f9TdTs/gQhumoWXF8J8c6MkzDTryjy1fXqKjZ936xIvf5l0CE+iINd1i4QIK5QdO/rs3wht0wAlS9MJw+S/1Loi2VJXrT65tEw7n/jTIgtuCcCHvK2PjxuRo/vp9pWpu653BzVzjn5QFzy7p80nKvu22hK9u8dbvtZmJizOLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sszx2dCOUrs1iIqSfZgFE+TowPKkpE+xPVt07ojtwj0=;
 b=buMM0vGDjif9IAVlvkXkldZJY83GVxqgALifJGGvQtK1hdvi61BZMopzqA6ivtyxbAiDvGwmFv3cqTNlGfvyqq7QSCsNA541YlxiS4bPmg1HJPIiCe7FaVa/P1nh+hg3YuzCwsxYBa9RllfeCX6gyHh+bC+8lsgqf3qtRHm/tkoCdakapfBVGvo8Bsl1DronAkw39hwyLaja0hdMhXi3/6sMxNytUyoVMxaRyRJsmHCyz75piWocgUDiT7vZAw6CGsrqjL6B/lt+SLqr5ICBeHzadlPpyd+73qaoC/YmkgoXplMdbXcYW4n5uBQepwkGsqPvIc5KhBv6JuB/xwR1SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sszx2dCOUrs1iIqSfZgFE+TowPKkpE+xPVt07ojtwj0=;
 b=cDDGOJX+1tTlDnt5JA3ZpiL4exfgtqqp+4Hub/8b1KdHdVJN/xkm69hYozUPCr9aE/FOZU4PpBhMLCCHweHflRP1z+nmZiIzQFUYB2eR2hV61m30QVP5YYuJOZ9ibkhWWob7NAJdtpF0OUfRFPaiWlgcjTC39rgzUePeTTUogDWPGhI1MjRbufKnD3im3aIOOej8ZlODr8jlpyFH5vOW6uiK11k/z4a2XukTtn70LDoX3LUQa7ca3x/XJA2fKK8nO8QVoRcjfk7KwbXiSYoTRpIH77N4jc0hhecB+uOg1L1y3iQDyMQbxRZqdRHapGlGXjzJ9a4f4tPJSCnEPcox3Q==
Received: from BN9P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::13)
 by LY0PR12MB991900.namprd12.prod.outlook.com (2603:10b6:404:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 27 Nov
 2026 19:51:53 +0000
Received: from LV8PEPF0000006A.namprd03.prod.outlook.com
 (2603:10b6:408:13e:cafe::59) by BN9P220CA0008.outlook.office365.com
 (2603:10b6:408:13e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Fri,
 27 Nov 2026 19:51:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 LV8PEPF0000006A.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 19:51:52 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 11:51:39 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 11:51:38 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57 via Frontend
 Transport; Fri, 27 Nov 2026 11:51:37 -0800
Date: Fri, 27 Nov 2026 11:51:35 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
	<rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Johan Hovold
	<johan@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Mark Rutland
	<mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pranjal Shrivastava <praan@google.com>, Mostafa Saleh <smostafa@google.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<driver-core@lists.linux.dev>, Sonang Patel <sonangp@nvidia.com>, "Ankit
 Agrawal" <ankita@nvidia.com>, <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v3 5/7] iommu: Introduce TDISP T=0 state for confidential
 IOMMUs
Message-ID: <awnfR/U0Bi95B3UT@nvidia.com>
References: <cover.1794343501.git.nicolinc@nvidia.com>
 <07ea92910895a2b0db33afefaa3a0ef182b2968c.1794343501.git.nicolinc@nvidia.com>
 <179563006502.253973.9155049351516451537.b4-review@b4>
 <awe6WgoiKaBTgINn@nvidia.com>
 <20261126145715.GG114472@nvidia.com>
 <awiLcoPfk0xxEL4A@nvidia.com>
 <20261126195346.GJ114472@nvidia.com>
 <awiaoX4RrQPP23OY@nvidia.com>
 <20261127174215.GR114472@nvidia.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261127174215.GR114472@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000006A:EE_|LY0PR12MB991900:EE_
X-MS-Office365-Filtering-Correlation-Id: f4dead4f-01e8-4709-8f4a-08df4cbfe274
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|7416014|36860700016|1800799024|6133799003|18002099003|22082099003|261028144727099003|11063799006|261022105027099003|4143699003|56012099006|261021121427099003|10067099003|261021135927099003|261026121527099003|261102123227099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	Pnt1MOhHf2rDg5+LEdy4eCyxzHmjsU2v5GbrKZkilPeuK+Dto0IeTGdQcj99GfRar6PySYBxgPatVthAEDsAoFPCgNgfqf59hYgx4JG1T8pci5A8IB3WHFa5cPyMfzb7o8w26p+UvBPO4htxql1Jw0375MKasboJZD056rotwQ5LrZImI7Z7q3cl2LD9VbU2Yc5n/wm24Y+OXbuqFR91yfetebUdr0cYswSLJKr+pM464YGm1hDcyErOZKcKqxdCDsdsWpTT8GLGlnnp+o83yQ0IxVHRksfziHIJwnFHJa9CNwplqpdfTeyf4FPRvc98k/NTwuujZ75Qs6rfPnF/h6NIFZB5yY6lOwzwnMtWUlE2gz10jk+EsdimcuQu8pjo0cu088mf1rbjaqQ2Pdo2uNbIeTWxJASlzhVM9aYwWSU+EgaT34/f/kIRZ0fdrdt8q5ONkoBP6gMzth4eiOFzWpLA4oPJD6+SrgYzpSOMi5Uy5TrXfJDUal9AJRqGUouKlfHuKp764LNdzj8miWJb6rzfhUHK4uDJpQL6mfmFss84wA9bMqasvUe7jVfBM1gj/968FbwPindiB7pXKJrvQesuWuqvC1fsjPzoqLAigzPFkZxECKCcMUnYqZuND8dC9kFHbKFdUcuuNvgeeu0UKaUsQAXiGcBIf5r559u/roY+dYSVUFxDaVf/DxfE6bddoeA0LXWb37EEcrTTcEyc5A==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(7416014)(36860700016)(1800799024)(6133799003)(18002099003)(22082099003)(261028144727099003)(11063799006)(261022105027099003)(4143699003)(56012099006)(261021121427099003)(10067099003)(261021135927099003)(261026121527099003)(261102123227099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WJTLQJ2R2shfwyR6hO7MHawE/zb0wsCVcBwKuAsLaU3tsKMdDCXteJ9fg3J80s636PEy319FbNKQck/YUrTaHK6n3njL1DbsSp9EMSdLjszubCvBG8mt8DfS0U3Jht3LmNctKFHxlH3JP/e8NRxZT2cyICwRjGWdESC2eOZkjIYxRE5QX0S+Y5JJ/HiLh5Erls6l3fbHt4kjPkUhCUWXbsboM3H3WAn65mlDYqz0BSdFhnbxb17xWRcnWaBkRD+cUvJgGpBmGCPFluEnqSdAIyvmwMvhGiESaBgT0lLUPC6dJsSK7x4X0XYRkfi77Y2eWsvIFUxfzt0XlXfORfy5vu/XxlUrzeG4pvv5i36x9NwFqTEYR8I5dwHC2tgGRcAYdsw2tyPAh5RhRx4crmOL/WO56Z2n3HlGKYMWcMx2vk0/PkXb9aerEIzuBjrFDRwf
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 19:51:52.9589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4dead4f-01e8-4709-8f4a-08df4cbfe274
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF0000006A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB991900

On Fri, Nov 27, 2026 at 01:42:15PM -0400, Jason Gunthorpe wrote:
> On Thu, Nov 26, 2026 at 12:46:25PM -0800, Nicolin Chen wrote:
> > On Thu, Nov 26, 2026 at 03:53:46PM -0400, Jason Gunthorpe wrote:
> > > On Thu, Nov 26, 2026 at 11:41:38AM -0800, Nicolin Chen wrote:
> > > > On Thu, Nov 26, 2026 at 10:57:15AM -0400, Jason Gunthorpe wrote:
> > > > > On Wed, Nov 25, 2026 at 08:49:30PM -0800, Nicolin Chen wrote:
> > > > > > On Wed, Nov 25, 2026 at 02:07:45PM -0400, Jason Gunthorpe wrote:
> > > > > > > Though I am wondering if we really need the ATS stuff. Why do we need
> > > > > > > that? The pci_ats_required() in the hypervisor should force ATS since
> > > > > > > the hypervisor is not going to construct a vSTE or use a nesting
> > > > > > > domain that would inhibit that? Can we just drop this whole patch?
> > > > > > 
> > > > > > Ah, you're right. It was added for non-pci_ats_required (non-CXL)
> > > > > > cases where the ATS state needs to be in sync with the hypervisor.
> > > > > > 
> > > > > > However, the justification/usecase here is pci_ats_required alone.
> > > > > > 
> > > > > > One small concern is whether VMM always exposes the underlying ATS
> > > > > > state or not to the guest VM. QEMU seems to do so. I did a test by
> > > > > > dropping the patch: lspci in the VM still shows: ATSCtl: Enable+
> > > > > 
> > > > > It probably shouldn't do that, but it is also not harmful. The guest
> > > > > PCI controls should be fully ignored by the VMM..
> > > > 
> > > > Would a PCI device driver (running in the guest) check the guest
> > > > level ATSCtl state for its ATS pathway?
> > > > 
> > > > If VMM is not supposed to read through the physical config space,
> > > > without this patch, I suppose ATSCtl would be disabled and ATS on
> > > > RID might not be functional?
> > > 
> > > VMM does not bind guest vPCI ATS Control to the physical ATS control.
> > >
> > > ATS is controlled through the vSTE only on all arches.
> > > 
> > > Without a vIOMMU ATS is controlled entirely by host preference ie
> > > always on if available usualy.
> > >
> > > There is no need for the guest to read or write the vPCI ATS config
> > > space, but it does anyhow because it doesn't know it is a guest.
> > 
> > Hmm, I think we are talking about different layers.
> > 
> > I get that the physical ATS control is decided by either vSTE or
> > the hypervisor.
> > 
> > But both the ATSCtl state and pdev->ats_enabled, in the guest OS,
> > reflect the vPCI status.
> > 
> > Since VMM isn't supposed to read through the physical PCI config
> > space, the ATSCtl state would be disabled.
> 
> The VMM needs to see that ATS is available on the vPCI capabilities.

For cap, yes. I meant "Enable+" vs "Enable-".

> > And pdev->ats_enabled would not be set, after we drop this patch.
> 
> > I agree that there is no need for the guest PCI device driver to
> > read those two vPCI-related states, but if it ever tests either
> > of them and gates its ATS pathway on it, this can break, right?
> 
> Normally the guest without a viommu will not do anything with ATS, but
> the hypervisor forces it on for the guest. This is OK because without
> a viommu there is no invalidation to worry about.
> 
> So the ATS state in the guest was never correct anyhow and we just
> happily ignore it and appreciate that the hypervisor forced it on for
> us.
> 
> When we added the viommu then the viommu has to control the ATS
> because it is responsible to issue the ATS invalidations, so now ATS
> is controlled via the vSTE EATS, not through the PCIe config space.
> 
> When we add CC we create a new problem, the VMM no longer sees the
> secure vSTE so it cannot use that to drive the ATS anymore.
> 
> Instead the VMM is going to have to emulate the ATS enable bit and
> route to a VMM controlled vSTE for the T=0 translation. When the
> device is in T=1 mode, and a vIOMMU is enabled then it should reflect
> the ATS enable into EATS on the non-secure vIOMMU.
> 
> Otherwise, in T=0 mode, when there is no vIOMMU, it should continue to
> rely on the host kernel to set ATS to whatever it wants when it
> attaches a simple S2 domain.
> 
> Thus, in T=0 mode there is no reason for the VMM to manipulate the
> ATS, just like it doesn't manipulate it when there is no IOMMU driver.

OK. Thanks for the explain. The takeaway is that the PCI device
driver should not rely on ATSCtl or pdev->ats_enabled for ATS,
like what they wouldn't do that when there is no IOMMU.

Nicolin
