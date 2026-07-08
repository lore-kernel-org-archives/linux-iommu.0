Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012037.outbound.protection.outlook.com [40.93.195.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4293E3033E9
	for <iommu@lists.linux.dev>; Wed,  8 Jul 2026 14:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783521503; cv=fail; b=sXjA4YifghZkZsqSDoWCr5HRdmfemGZkyRct1Z8YIZhmYfq30EcyB3Ky7uYsgXhHAhsm4Oa3pcpbxl97v9OyQx9phm9YaXXaHR9q7EDIMAPEIfom7AkYKJFQvIqIHiwJqSRWFBlRyv/4VVLJJO3LDJI2pubxbD/HT/WdQui6zAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783521503; c=relaxed/simple;
	bh=sJajDyNzXY/BOdlAMs9UaiaJ1plaSCZaz5DT+MqH1FU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bIxTuvREV5l/VAcG8R1qFYGLW8OgCFj0s4FWFcKsOdddPeGH+wbuhS5LordAFy31IZYlYs8qeitXv0ApXZRMKtKYk7fYSVkCNybI15FPb1eFnYu/vz3RKhW2mirZ9pNSWuXxQ+enfzAbM97RkmJPFQguZoM8aCIHxohwUWxiY70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FihwWP6n; arc=fail smtp.client-ip=40.93.195.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FihwWP6n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IvxatlxoyW00TixYH2lp3CGGBMYvFIxGtOHzP4UvEQVePqARiGGYDMA9i2rH9pTVeenXKA/HKjD8ox0b8tFlyspG/Ohr5v4rxIfxRI5TxqXsJfiHQnRjgmL6LPvMEpernIhGeakNBnYVYw+ogXGfRU2tHD3lFcVir1Y3JxJrW95c0eSJuE6/Ej4rbFuSJmj06y1jM8Ngy7D1L/OK7U1RwrflUXXo5u0o3e0IIE9nOGmuYANLC0cCBGTlKn/hht9qZDytb+BBpU2VVlGAmn6tTda6kyiPP/3pBTgZVCrvK0VTQa5JobBAzhIAsggibqhYwMFEGMgJzzwS6nlmNd4FcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6VAqjivv/IvAbv7Jmwhaj46hGkwSUFgTCTwMEqnnoY=;
 b=MlkrzzlLFDcVvoX+JQONzaUr/cLdIf5ld00DzsVu/5w67bwLtQhc/dIceUAteE4zFotLO7vBDwSGzkjOeM/YgysmBEdrqfKYlYVhA/VGRoj6lyRrWKJ7DB7JpRQfPe10Iu6ERRw4EVutg39CfMudXzUuOwVSvJkOIuCo5TIJHzTT+q2CglcJx9hSxS6bJaH2W7v2dhraA5cEZ9ihIKTEJKUlAeB+MOAd+eKM4EKOoqjQsB5MIGwmNbCTzgaBoNMYGzbyOuLEqWYig0MgIoiIhNERzqvXIMr24tt4u0ut3USkef6NZOWgI4N9oMM3E3nzP0blyW1MfZHzhv7hVR3OSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=smail.nju.edu.cn smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6VAqjivv/IvAbv7Jmwhaj46hGkwSUFgTCTwMEqnnoY=;
 b=FihwWP6nkiQ8hgsiVjGppvvN1KidmT85+76axhV82Ff7/WhBbqJTnEAjutUGkX/VzLCeYwxM2hRe1vBsO7mv5qW73rE5wkoniu9gymZe6snRv6hzIMY3Y4uR58n1l1ddgJHoroYBucCVhSiJPr/wUhUi/g1dQv2gz89qHBtufQo=
Received: from DS1PR04CA0025.namprd04.prod.outlook.com (2603:10b6:8:243::13)
 by SN7PR12MB7909.namprd12.prod.outlook.com (2603:10b6:806:340::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 14:38:16 +0000
Received: from DM2PEPF00003FC2.namprd04.prod.outlook.com
 (2603:10b6:8:243:cafe::11) by DS1PR04CA0025.outlook.office365.com
 (2603:10b6:8:243::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Wed, 8
 Jul 2026 14:38:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM2PEPF00003FC2.mail.protection.outlook.com (10.167.23.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 14:38:14 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 09:38:12 -0500
Received: from amd.com (10.180.168.240) by satlexmb08.amd.com (10.181.42.217)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Wed, 8 Jul 2026 09:38:08 -0500
Date: Wed, 8 Jul 2026 14:38:03 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Peiyang He <peiyang_he@smail.nju.edu.cn>
CC: <jgg@ziepe.ca>, <kevin.tian@intel.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <syzkaller@googlegroups.com>,
	<baolu.lu@linux.intel.com>, <nicolinc@nvidia.com>, <joro@8bytes.org>,
	<will@kernel.org>, <robin.murphy@arm.com>, <dwmw2@infradead.org>,
	<suravee.suthikulpanit@amd.com>, <vasant.hegde@amd.com>,
	<yi.l.liu@intel.com>, <jpb@kernel.org>
Subject: Re: [BUG] iommu: KASAN slab-use-after-free in
 iommufd_auto_response_faults
Message-ID: <dhvcdnypilztuwxx3uivdie3ejgfh7zfkufhihmxvhkhdnh7gv@ywwlp56mxzwa>
References: <B4F28798E2E784CA+d29f723c-b2b5-4b67-8d1c-4f7b9b0b27cb@smail.nju.edu.cn>
 <29F8ABC41A81139D+fc011ccd-cc15-4f64-bcc7-88e5d16184d5@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29F8ABC41A81139D+fc011ccd-cc15-4f64-bcc7-88e5d16184d5@smail.nju.edu.cn>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC2:EE_|SN7PR12MB7909:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f3ee308-a923-4de0-bc95-08dedcfe8b4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|7416014|18002099003|22082099003|6133799003|5023799004|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	WapO6mVR6rU6KwMjxJjgBSYwdFBcZpKHcLqp0EXc1ThyymTb4eeAHTppurAYIsfPvNzv6mP8bwlt86dYRZW4W10Z+VIPH5G74xUAcZ6ht6Eym/PJwAMFDZJ/gp+EVG+ysLvjZ3P11uo/etqQRVKfF1sA2iCXLTl0h6lWbmWX0sI4LtdNxYpQ0M7zOGihH44qRf5a9etncveSXVHTSwBh8gt15Agn+vqJnTwuP/JzCUB40fwy025S8vq2ESfOsVKiWoV4UWtbGhaM+YlkrcKVTxAkvjnDxEsmFFcDXzxOrZRMSLeWn/lY2z45JZufLWslIXtllKsJs4yeePUqbIIr4Z689kvncWqM6FPT2rPJEVxIhokoXaKcuv5c3W9dfpy2jenMtWLWgOojS2dm3WSlnVMfaG0pgzEtHvFendrXTMkGJVtMBcwOMBqVvQM1ey01nVizOGU02j8CoPgOqYt8q+wGDOpYTskyOIVssi8XVM8FiW7FLueJGPbSohagK7HHBCby44VGLCyWZO1BPQmm5cYouS/UGXpHQ6SmVqawGlQENgm3hYOvjGFqwcHh9bGIqtrMmHdqxzJFTZTWkD1YqyJouD2shnRsy5QnCPhv1/9/5uDtdw6uujMqjWDJv5q3lAIruybEoN1zdUx/+ehp4CsKvek42N+4rwSb1tWVd+l2lMo1p6v7XMBemeHtmjPnJel/ruvyE79DlYm3b539GQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(7416014)(18002099003)(22082099003)(6133799003)(5023799004)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FxUl7ldSpRyDx+HIFAXwo7R/1vtE1eWk9AxTxYdoAw5ZK4rhxB9NwO7Tvs37U4P+cjO+zSNxnN6WqwqPC2coa5XuLw8ax1XBkUdZ1OcxJ+xbyg8rnYeyXTdizSFF9Zj+dozwx5ivQKwze8ubg61KSvKrcAGqtqfQRF1vS3HZFc9wnN3TT9QHNGjodoqJCe09/jC3uNOtnbwlsqIKFWK54koqtie9s7ExGAy/f23QSQcLRc8eDHQ7f3eYjnDrl3/8pX8ESPKF1h/lCTEXxQ3S/+0qeYKarIjHaod8y6zGdI+6sPk2GkjdSCb6MUqLPpYAuwaAyZ3PgyI+jKsv+q3fC+BnR6KiHz8DJspcWWWe/mXOKV1BwAFRB0u8OddtbfmMrib6Wdzifh42CTqHHQIqK2mO1GI8zpDrikCa9e4QpIxw6ZnhWUm8KWYP0j3Gtzbn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 14:38:14.9434
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f3ee308-a923-4de0-bc95-08dedcfe8b4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7909

On Tue, Jul 07, 2026 at 06:36:40PM +0800, Peiyang He wrote:
> > The analysis above goes through the iommufd selftest mock device (M). We
> > have not reproduced this on real Intel/AMD hardware, but the same lifetime
> > issue is not specific to the mock driver: Intel and AMD both have real detach
> > paths that can reach the very same iopf_queue_remove_device(). This is exactly
> > what iommufd_hwpt_detach_device() triggers, via iommu_detach_group_handle() /
> > iommu_detach_device_pasid(), right before it calls iommufd_auto_response_faults().
> > 

../..

> > AMD (drivers/iommu/amd/): the evidence here only covers the RID/group-detach
> > path.
> >   blocked_domain_attach_device()     [attach_dev, RID]       iommu.c:2883
> >   --> detach_device()                                        iommu.c:2398
> >   --> amd_iommu_iopf_remove_device()                         ppr.c:270
> >   --> iopf_queue_remove_device()                             ppr.c:273
> > AMD's PASID path, blocked_domain_set_dev_pasid() (iommu.c:2900), only calls
> > amd_iommu_remove_dev_pasid() and does not reach iopf_queue_remove_device().
> 
> Hello Linux kernel developers and maintainers,
> 
> After further analysis of the code, we think that this UAF should not be feasible on AMD devices,
> but still feasible on Intel devices.
> 
> ===
> AMD
> ===
> 
> We found no path by which a real AMD PPR fault can land in an IOMMUFD hw_pagetable's
> fault->common.deliver or fault->response.
> 
> A real AMD PPR fault is always PASID-valid: iommu_call_iopf_notifier(), the only
> iommu_report_device_fault() call site under drivers/iommu/amd/, rejects PASID 0 and always sets
> IOMMU_FAULT_PAGE_REQUEST_PASID_VALID (drivers/iommu/amd/ppr.c:107,140-148).
> 
> find_fault_handler() (drivers/iommu/io-pgfault.c:118) resolves a PASID-valid fault only via a
> per-PASID attach_handle, or a fallback to a RID-level NESTED domain gated by ops->user_pasid_table.
> AMD does not set that flag (only arm-smmu-v3.c:4389 and the iommufd selftest mock, selftest.c:861,
> do), so a failed per-PASID lookup is simply aborted on AMD, never delivered to any RID-level domain.
> 
> The per-PASID lookup cannot succeed toward an IOMMUFD HWPT on AMD, because the
> AMD domains that IOMMUFD can allocate as HWPTs do not implement .set_dev_pasid:
> amdv1_ops (iommu.c:2663), amdv2_ops (iommu.c:2741), and nested_domain_ops
> (drivers/iommu/amd/nested.c:291) all lack it. Therefore, if userspace tries to
> attach one of those IOMMUFD HWPT domains to a PASID, iommu_attach_device_pasid()
> rejects it with -EOPNOTSUPP at the !domain->ops->set_dev_pasid check
> (drivers/iommu/iommu.c:3625,3641-3644). The AMD nested RID attach path is not a
> substitute here either: nested_attach_device() refuses attachment when PASID is
> enabled (WARN_ON(dev_data->pasid_enabled), nested.c:244).
> 
> AMD does have a domain with .set_dev_pasid, amd_sva_domain_ops
> (drivers/iommu/amd/pasid.c:177), but that is the kernel SVA domain path, not an
> IOMMUFD HWPT. The SVA allocation path installs iommu_sva_iopf_handler()
> (drivers/iommu/iommu-sva.c:298,327), not iommufd_fault_iopf_handler(), so faults
> delivered there are not linked into an iommufd_fault object's deliver/response
> queues.
> 

Hi,

Your analysis is correct. Currently AMD is not affected by this bug.

The UAF requires iommufd_fault_iopf_handler to be registered as the
IOPF handler for the device, which only happens when an iopf-capable
HWPT is attached via a domain with .set_dev_pasid implemented.
AMD's IOMMUFD HWPT domain ops (amd_iommu_domain_ops) do not implement
.set_dev_pasid, so iommufd_fault_iopf_handler is never installed for
AMD. The PASID-less path through mock_domain_nop_attach is also not
reachable via the IOMMUFD fault path.

The existing _test_cmd_trigger_iopf() helper always responds immediately 
(read+write on fault_fd), which is why the current selftest  does not 
catch this.

@Jason,
Is it worth adding a test variant that triggers an IOPF without
responding and then detaches — to cover the cleanup path in
iommufd_auto_response_faults() as a regression test?

-Ankit
