Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010037.outbound.protection.outlook.com [52.101.46.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EEF383C85
	for <iommu@lists.linux.dev>; Mon,  4 May 2026 18:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777917740; cv=fail; b=ufWaKdo0vBh623/i93M4+J/WEy/0JMsTE11gd1baBA3bt7LQkA2LMb+wmz2IfLO27j74riE0bXu1+6nRot2BQvaMenj7huGU+dBAVxbDNm874XTXaG976RXOjmk+dwXRrmshG8LzAYFbSaqrrBYOqq4xgp2VriMEZ6S5UJdd4FE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777917740; c=relaxed/simple;
	bh=2gSeqV+LEpJY5ok4CUAeTpZburj44FSO41TVIU5kccA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2wcMO61qNIn0e4PBcILsaoU46TPk7aLAQOzMNyxsvZ5aOZRh0Nys8ofWxS5pS4qYOnJMGFsX+Lk1JPga9Vk+TGkovtVGdX/YN/XjvRFpNulvPPp1Sl8LGLh11QuJ884nzz8tAdn8YllijqPa+OpEL/lbZkcUa1S3ZSJ81asRgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f35YncGC; arc=fail smtp.client-ip=52.101.46.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f35YncGC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LIbDpL5khsJOCnmpbhR99JPqpzbPb5Py23EskKV/xgr1xdVIOxXR/FMz2QYl5E3dkeyz+/s4YkdfnQ1kX5vJtevC1KTKgNdFsRyFDA1MCP7VzC7+T/xgJPnp+uY0JZ69bIqQRHBYPbD85Vm8nmSO2py7QWmj0tSw0qaU6MH9YEo7NMgVAngOxb7+T1AwxyefurtQSPMw6p7fQ621ONwVdH6/i0BUEUvsakcoIEszdkzXKbVzvURkfzLCfBd3K/YGxwoN8z4OVKXXCASKQ+sj0wh5p4IDgQ0GHogzGkFta97kTlNMNY0Cm+51fkkGVNs89YehYhhPhLbbbmHAMI0q+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1uSB165F3JIbQBpIP4BWmW5u19mWLcX9LO9+Y9mVLVE=;
 b=UB3TgAvYLxRNqAr080zqfmgjO13ljS7ieL/VsrMJkrsJE8D/8IZwdNZg1eTF2FzXTt3dzAkd+tG8rc2HPMMnbvOwNV9SYNfaaIxxMBZqYWG/+iT1sbi/LmXV5DSkUa6agUU10XjYasGkMkMH05zd1VqbQcSVpfyz82ePWKzeTYasrXH/gC6UMQ/g9gLDRnqEQL6XGmaWB+vJhjv6uexAhDdwGFOQ59Ost2KVAZi8vF3WKJOAub86bM1F6/1y0gqq63U8NLrMTfzRBPLZRsdwxM6oFY8qCxEWkz+C8RnWQO75E28M6pMILXTDyXMgYv1K8LUdFz5QreL4U8AhxXEoGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1uSB165F3JIbQBpIP4BWmW5u19mWLcX9LO9+Y9mVLVE=;
 b=f35YncGCu4Jpb0ML2fgngtR7xJ8avwXflMAuHDaTt1fCE/RBb1N/Tda2zcUhpgG2FSrP2astHizae202NnPtlJPwvq5jJYTJzBA7r460jxGUaqhVM6Nk/nVF198d7zllrrzes2U/4zo7GbQRSPQFOMTbzPbbODSqtbXx/TJO2i5ZiYfZQCfHNa5j4WeO6CwDNPrOiizcPvy5rYbMsWj7XBizwPUlUI8tVv9e/YpxAbYlTloBZjJEORVHP5rP1+VYZ6fZ8LK4Xc7XtH0X8SHZPiq6Ym4gGUpHs7Tb9/u0T2CMoWKx1skGSsu/f3TodfJN7Rt9//ypEugOfi5krkmiEw==
Received: from MN0P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::17)
 by CY3PR12MB9632.namprd12.prod.outlook.com (2603:10b6:930:100::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 18:02:15 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:531:cafe::6f) by MN0P222CA0011.outlook.office365.com
 (2603:10b6:208:531::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Mon,
 4 May 2026 18:02:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 18:02:14 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 11:01:47 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 4 May 2026 11:01:47 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 4 May 2026 11:01:45 -0700
Date: Mon, 4 May 2026 11:01:42 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <iommu@lists.linux.dev>, Will Deacon <will@kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Samiullah Khawaja
	<skhawaja@google.com>, Daniel Mentz <danielmentz@google.com>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>
Subject: Re: [PATCH rc v2] iommu/arm-smmu-v3: Fix inconsistent ATS state
 tracking
Message-ID: <afjfBi+vw/Ywkzid@nvidia.com>
References: <20260504163842.2692314-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260504163842.2692314-1-praan@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|CY3PR12MB9632:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e23adc9-4a11-41d3-aad5-08deaa0745e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|7416014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	e4XuSzBLvG4DWa9PRgY4udXiIeka30A/xX9X0rOFpf5wxIcJu4M2SMWPsMhjgGn/BgJ3CRn/ifOD3+x3+jtAow/7b2BaOUVzoX5D1xq2RUSDPYZaXczFnqFOSbJ+Y+1NDoioi08ejlgVOKUg+7Ruy5N8n0j203by8KTAebrSJAq0RioMPUr65MC2TB5Jvsq5nT5mlFlafvyMFiOgB6czPW+27grJm0BLH6nwFSTIUUt4bnLxudt1xnfHkm/QVI5nOzUm3RWO6WQzOOtL8Ry95MCaYIqHWFxQ1el1ASaKFUvxGYCaaGYtYUIfv0ueFCvHl5tKb6c+zXIut2TnTc7M9isoOwabG0/KjIFRs9qHivihYfhemWoom63xd9aS2irb1eldVhPXbIFoXrtJIgUL+hvLhRIkgNNlixPxhXfj9rVdG7fmENU9Sca2HdqxvveJmmZIVdh1DiScgYxlwDXsj9hujXXpSuzPBB9Fj8XwZZoc4/jLfXiG0qFzFe8DteWEO7+LP5rOZKRGUjoI7T8Og72FgOhOcAy9rc9JTRC6WH3Vi853DDCpkWXBajrb8DakZvodpRhlsxd+FwvDM8b44QnLHOuxL0VtF8AkVTBYZ1H7ymnFosTlGYeqy64HYsYXxKjBSgE5P9Y4oMLcLmlltA5Bw53i1c9wBIP1D0Zpf9EaVP0S9NfLtAd2EzflPnRxyeSgiaH76nTwWIq13faWXRQuhIHQB20njUKeXAG8+7o=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(7416014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/9GZvDqs9T77v6HpUiZXCkvrSrmHCh4+BBRuJ3hE73N7XThkcTbmYPAEa+j9YTF3QGUH2YdGwsdMsYbSxUwIftO/TmXvWy80sPDMcAirbbDVnQ4F9euNoG4Kyrj+NpXpNkK7cs3dsDCr20CoRP4mK7JFNUx8V3h9W4ppVamYjWR3m3jqRfqp56t5bnT8n3aq1HBOeSSPYsrZaDbKdv+34KO8vQCCBOV3HAoG8TmUOZuEphJkZ6Omx6SF2ozVBD2OaA5Z1U0SPr3RXxWIHZQZyoD8rcEe0Xbr8f6SdRTmOqYu/jjVgN9XttzmplRmWqFP1XVLmkSrhHZhWJ/QhLcFjInowiQ922t3fHiZ+8fZW9ZBf9qD+aEAzxBNDB+EZJ0vzayd3DoPV877ifcS+YpZPghR+s8gsFqjaU3FWuVBHQcVb73aPps0PfczzFRG1mOZ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 18:02:14.5389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e23adc9-4a11-41d3-aad5-08deaa0745e4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9632

On Mon, May 04, 2026 at 04:38:42PM +0000, Pranjal Shrivastava wrote:
> arm_smmu_enable_ats() ignores the return value of pci_enable_ats(). If
> pci_enable_ats() fails, the driver still updates its internal state
> master->ats_enabled to true in arm_smmu_attach_commit().
> 
> This leads to a state mismatch between the SMMU driver and the PCI core,
> the SMMU driver operates assuming ATS is enabled. Later, when detaching
> the device the driver callspci_disable_ats() because it believes ATS is

Missing space: "calls pci_disable_ats()"

> The issue was exposed under heavy load when running a VFIO-based DMA map
> stress test: iova_stress [1]

I wonder what's the real reason for pci_enable_ats() to fail:

int pci_enable_ats(struct pci_dev *dev, int ps)
{
        u16 ctrl;
        struct pci_dev *pdev;

        if (!pci_ats_supported(dev))
                return -EINVAL;		// unlikely

        if (WARN_ON(dev->ats_enabled))
                return -EBUSY;		// unlikely

        if (ps < PCI_ATS_MIN_STU)
                return -EINVAL;		// unlikely

        /*
         * Note that enabling ATS on a VF fails unless it's already enabled
         * with the same STU on the PF.
         */
        ctrl = PCI_ATS_CTRL_ENABLE;
        if (dev->is_virtfn) {
                pdev = pci_physfn(dev);
                if (pdev->ats_stu != ps)
                        return -EINVAL;		// maybe this one?
        } else {
                dev->ats_stu = ps;
                ctrl |= PCI_ATS_CTRL_STU(dev->ats_stu - PCI_ATS_MIN_STU);
        }
        pci_write_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, ctrl);

        dev->ats_enabled = 1;
        return 0;
}
EXPORT_SYMBOL_GPL(pci_enable_ats);

> @@ -3051,8 +3051,9 @@ static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
>  	return dev_is_pci(dev) && pci_ats_supported(to_pci_dev(dev));
>  }
>  
> -static void arm_smmu_enable_ats(struct arm_smmu_master *master)
> +static int arm_smmu_enable_ats(struct arm_smmu_master *master)
>  {
> +	int ret = 0;

Seems no need to set to 0.

> @@ -3635,7 +3639,8 @@ void arm_smmu_attach_commit(struct arm_smmu_attach_state *state)
>  	arm_smmu_attach_commit_vmaster(state);
>  
>  	if (state->ats_enabled && !master->ats_enabled) {
> -		arm_smmu_enable_ats(master);
> +		if (arm_smmu_enable_ats(master))
> +			state->ats_enabled = false;

This alone isn't sufficient.

First, prepare() does:
	if (state->ats_enabled)
		atomic_inc(&smmu_domain->nr_ats_masters);
So, unsetting state->ats_enabled would need to balance that:
	atomic_dec(&smmu_domain->nr_ats_masters);

Then, arm_smmu_master_build_invs() adds ATS invalidation entry to
domain->invs during prepare(), so a per-domain invalidation would
still send ATC_INV, which is probably ok for the PCI device, IIRC.

But the device's ATS entry would not be removed from domain->invs
during detachment since master->ats_enabled is reverted here, which
would be a memory leak. And reverting that in domain->invs could be
a bit painful to do in commit().

I am thinking, maybe the call sites of pci_enable/disable_ats() can
check to_pci_dev(dev)->ats_enabled instead of master->ats_enabled?

Then, we keep master->ats_enabled as-is, so detach() can revert the
nr_ats_masters and ATS invalidation entry in domain->invs.

Nicolin
