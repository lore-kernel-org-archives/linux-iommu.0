Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.33
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795102136;
	b=N5E9z+zMikAR8ST7put4/Ik3WFFKRWiQXK7z5x2IbZ3UIs6r5H6fEnYyR9HPTu11utTq
	 362uWmj6k74kxEypoV9u7YY00H1V29IZkUcscCHqzHiPLkZ+BFjupNB87fSkB2gcypr1p
	 l50LB/UX0px/M8CB599ojN86DsteWy0CKZGsYMb6ltNYeIkdG6TjGldIZXv40CuXUMovh
	 db1Lecq4dAEsO6eGJ27JqqHmdKrzKoGKOdRWBTWBKoMsdAXPNMPEcRckZKq+irwdciL6j
	 1VBzCpjB2RxWjcJUYCzw5lZeYogh9tTRiCyQsPu0/QhsbGnSf0f5ByyzprJvzMx51Vw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795102136;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=zIL0m0NvxjSMP6Rwn+NxbWq77tkVA5JqyttOK4jI/fc=;
	b=zZjuAp888r5n6unle6fGgsCkDJGmd3hURFStR6XbieEbrnr4WsKz66o0iostxTwgvxbu
	 qo8ioKaHJFst43TlmqHNM0wkI3MPukaaDXrCXXGaCRfZE2JhlwLC0sSC9H9uBvsvYZE9g
	 Evj0JNhcBeb+Td2qVrCtliSvHnjvdBc69wntSO5p/3zwvFy+ujm9+4lV+PJsLSQn3i61T
	 /2ipcRgkSrJOAbcPLc1TVgYkN7ONoYHv9CiG73ciM0zi2TQXsKDkm26DpiKHPbUKl85V8
	 It1PU3pAgIopcC0OEMkokLRvc0MSelOat5tBV0jXHGQyAV+OgGMXhDh0qhp5h71S0sw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=dy591xwR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.33
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012033.outbound.protection.outlook.com [52.101.48.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC4C606A339
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 15:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CC4C606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=dy591xwR
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oYGKN9Q3hGBz00jheTgng3k9H6xNQnscACd0lZDO7mJsFwGSg5JM9FNxA43Y/NG22Kog2nfOVbFbZHdH/30FQWGpIf5OvN4fSI1z0dQYeJWcnHJm8Alcls5lbb+Gkue3aNKxxpTeVfHLjVEZEL/sn6e+xuWXGgTTC/5aLWBOaUVbqN5P244wrC9BqClanehHIDXfQXdFB8RFmGxfrRdUmcRLRwfxDURjQFUeOkSwZsBOrjlbTtFH556vXqkub+VuaadqS536x2k/HfbMSlYXZBLI1Q8Bm+migcAjJh193ry3yAkaxjdDzA+Greo2FdLubvfy9TN2ZKAMoAdG+gig8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zIL0m0NvxjSMP6Rwn+NxbWq77tkVA5JqyttOK4jI/fc=;
 b=upkSEebYLSo42EQAJLKdGtAuyAFND/u9mJxQbTIQbm50PnAmIM7px6xIknOx2OvDKr6Ocx6P+78cftxkNBVpf8uQAsqro5nwi7VpBOohaT+o7Oh4u0MALMbBNq9OUIW6p1i7SsYvfUMJoJjsknjcm3CtmC27EIuYwfnMguKEehrFtXd/IEm6NupvJJrgnCylh1gGRz877u/xAd8e5cr2yQcKn5Sc7lmUX37QACDekNhRTIE7PUi8GCVADctrlftGmdzj4k2BcCz4hsQU/EolgCkECHwUjRjt0xiwPiY5lTjLKY2dNwMLMzWwStZgq5wT64SQ1sTV3Bt8sNqyi26u0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zIL0m0NvxjSMP6Rwn+NxbWq77tkVA5JqyttOK4jI/fc=;
 b=dy591xwRldrdGF4Yh5POHoN74Dt3kqzQWm8z56Wxf2wmBSIDkLmk1ON5nl70Cd522FhO9RtCriIybjo6bvqmT2dM2F+/KMvxfXB4VQMojQ3Gkj2bQ9fOFE5iTkqvWwlS4R4uVxZQpcK5LA7Z9anlWkNegPoIcO+tinodZDAMaFs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB6837.namprd12.prod.outlook.com (2603:10b6:806:267::10)
 by IA1PR12MB7567.namprd12.prod.outlook.com (2603:10b6:208:42d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 15:28:51 +0000
Received: from SN7PR12MB6837.namprd12.prod.outlook.com
 ([fe80::42e1:d1c1:d50d:b2d0]) by SN7PR12MB6837.namprd12.prod.outlook.com
 ([fe80::42e1:d1c1:d50d:b2d0%6]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 15:28:50 +0000
Date: Thu, 19 Nov 2026 15:28:40 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc: joro@8bytes.org, suravee.suthikulpanit@amd.com, vasant.hegde@amd.com, 
	will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Restore three-stage vector cleanup for IR
 affinity migration
Message-ID: <fjjla62leitkeia5jfxxrp5t766nph3qsdb32whd4yrbfvyhe2@d7ea2smk3gjg>
References: <20261015042347.1823813-1-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015042347.1823813-1-guanghuifeng@linux.alibaba.com>
X-ClientProxiedBy: PN4P287CA0016.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:269::16) To SN7PR12MB6837.namprd12.prod.outlook.com
 (2603:10b6:806:267::10)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB6837:EE_|IA1PR12MB7567:EE_
X-MS-Office365-Filtering-Correlation-Id: 851e9da8-0634-4ca3-098a-08df4651cfd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|261022075727099003|261021123027099003|10067099003|56012099006|11063799006|261026140227099003|261028144727099003|261021121427099003|261022105027099003|261026121527099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	zHiHg9cdWrIwQTH9IqV3j8q+BX9xtzsQm5pkiKz984uprXj1T/BnS0OihiL/5IXJrAfMeca51Btqc/7V6fN23/yemzHcET+e8BXrr/v+IxSPOIC3V/t/bj+XDML6hBq3oB0Pu6ULLGvKWsc72ruL9XFJwHST2Mt8wpegji4Mzlge3I1XeMI823ISZxw7a9ZX0j7H7Bfrh9P5xp0XIP3rYuLu9Nrd2F9iPU89WvY5FtyeUxZn+RrPoxxOO/QSC/ATpfkdtdF3Q1UVGvKupJr1v9tfISJ6BfDouHGjzVBTMJfKuKb0CaFlmPxxUEq6TEQAVu480DFmAZXivqkadEVK8408QwPouC60oJRwJG6h81aCMZ601Adht3PIeyab8m2iUJCdvYdG/9N2cDJqAjPRvZTBdFME2EJTIWbXM5GroAe+HEj+ZSKtkwFxCv9G7LTQ1UrqF5Jy9y5tQXF8bze509hRqZZ3FOdxcHcUaG9nBFw9eV9G0yezKRzWTxmGq9YL6kwPwTORP/DyJg0i+DvBdc0f8Yjj+0xpfjC+9l7HlxGeeysjv/gEO0+NioDmK43NSkOB0TQHwpRI5DnrNwjg07wj382J0UiP3BNZJtrTAUbSnWOnC31c83O6YC7S8WWnug40pY0pK5SGjjfiw6hzju3XTLdNREntnMHSDJwpJ/4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB6837.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(261022075727099003)(261021123027099003)(10067099003)(56012099006)(11063799006)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261026121527099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BA0by0wwOp+QohajPqryy/VPOQSdwtC7lmxUNkk9cJcw2yRzFy1Dwfywo1Q8?=
 =?us-ascii?Q?Ykqap1iqzYtoBvqzv0vEeg1DXsOzKtzTPkv0RcW6QFEHepNCiAoQC6o7lkZl?=
 =?us-ascii?Q?G4ec7WIb2MhgssXoHCq/RYJwGVbq+CnzZEqSpUmj96XmyYffEJ1+jiygL9AU?=
 =?us-ascii?Q?XJ8VJDVDKi4mRBOCwKy3nnm/KYFg9bIMFvWWZLiHHxZX3fgGhtIPfg8dakmK?=
 =?us-ascii?Q?LnI3df2cnOXoBzriNOelM+GTXRafmmiZMHCdWl8Vq3UiDNx1OLxlmbEI08vP?=
 =?us-ascii?Q?W9vxi5+tDzdoySsQkD4sGwZHoShQ5uW2WDVzYY1S1j1jPy6X8sBPQKU6rUtx?=
 =?us-ascii?Q?3t4CSXw46IYIK0DKV5YKCptjXtHHsLJHYRH2dzt90mqITV5HDGVLhaxY+sln?=
 =?us-ascii?Q?lDHNb/HdUNUiOwHFJGtvL4N3zouSsFtGqUfhBk3MigSzlPNLQQWyqn3TokLN?=
 =?us-ascii?Q?OpjWeAT/JGEKwsMkWHgHwkU5EOxwh4FslcumgFOhVjDYWvSLJkImVHKYMEVa?=
 =?us-ascii?Q?dRzukFgJUxbEdFSs9bweGrQXGaDCaGxCFl/xhayOsEhTr+nncHl6sUEHlhUW?=
 =?us-ascii?Q?78j2oVxHvlKw1BpemzZD7O3DBQeIDECHpwUorPX/JpSKtY0SwBFhdfC8KLeL?=
 =?us-ascii?Q?TCZawTm0MAxLdXbuTnjv6VN5HxiFtFKgx4ee4ONcHgR+nZFYGdDVR7E3hkGB?=
 =?us-ascii?Q?PLLXVmm6Qj23s0UgKnGwKrPEMy0Zu6Lgp68p8W3nZ3x1Fz9lSDf4ZBADQuMf?=
 =?us-ascii?Q?yerVNxiIa0vdTuooNCwbcTSiAiF7cboEYeArh2SKuYPc3krNirOQtkFclnrR?=
 =?us-ascii?Q?u02/sIENvtSMQlItaEAVvB2E+Nsj+JpayhFMnbBUaKVb+D4RnfEG0iEotdK5?=
 =?us-ascii?Q?ShUzJk6jKd7Mx5BYA48whxo+gWB2qKusdj+N0aREx7nufSgK3XS8cu3XcTsw?=
 =?us-ascii?Q?bW49GADa0qTZhvV/uIusTVKAlhFMw3vGoR4JgspX7hrjxI8wKdPKEaq75fdi?=
 =?us-ascii?Q?HflAwPg1yXNtaIn9jh4Lk8zBIW49db03z0EhUsxC2VQEqwLyrJDjvOY8ohrJ?=
 =?us-ascii?Q?MxD+Jv4Dob5JfzFszz3AoWEf/aeNwK/MauJx3wyQEcH9DI4V8hROufT1jbEp?=
 =?us-ascii?Q?0VKQ/q7ydyl5VjzcDVIwPziCssD8nBzeIHVnHQ5zrAUWIK1s6NB8XtPqespX?=
 =?us-ascii?Q?56wHPH9aU/6VkmSEBlxi2c67mDbl/IKRhFfgjRxf1Ni34tKQbnn0jzhTK9ow?=
 =?us-ascii?Q?8LKLPIbkqJn1hdKATr2bc1IzgbAghXNVYD2/p5paK9XaotpEB7YSOHozzKRo?=
 =?us-ascii?Q?ADn320wYrz1kILx3ZPyiAn1uzVADQZI8A71eWMMUy2pKmPiMDT5rBfLyi+Zn?=
 =?us-ascii?Q?cQRxTobaZ/TkfpALvtEA9DxoGobj0JCM+5PDZJ2UFk9Fn9ipEFHAE1D5qs8w?=
 =?us-ascii?Q?LB3KBAHraz/StczIHTWvcmAKWoFIUVDqiSbsdDb72yt9sFgmfAltihm7WP4k?=
 =?us-ascii?Q?ejxDEaH5oXIM3O4Qd89Gmf5Gkk2h95DIez4g0Lhs0nf7jVsftLpTBIZF2RYX?=
 =?us-ascii?Q?wWIVfqGKZSxPGyDfHrRGlkTlhU9xKaaB6JghR51KS5QmsnkF8iS4zVQCqZt/?=
 =?us-ascii?Q?KQUYBwY/3i8EDmk/U9B63nNT0eRGgStpu2NXtTlfnbf1NAjB8hWp584SOq6d?=
 =?us-ascii?Q?/uGQrjSXn/nNOJbcvwi07m9jRw+oQLRoaOnde1u+p5Sq4imVx8EvkdF8Wwqn?=
 =?us-ascii?Q?79rZj0NfFg=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 851e9da8-0634-4ca3-098a-08df4651cfd5
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6837.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 15:28:50.8991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DwsItX6hFpYtChcLdbMxw8ad1UYo5PF36LLTVz42yeBV7bmw2QUAk0VjgUTa3c73RmKgl/4qbOebun4LSDVDBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7567

On Thu, Oct 15, 2026 at 12:23:47PM +0800, Guanghui Feng wrote:
> From: Guanghui Feng <guanghui.fgh@linux.alibaba.com>
> 
> AMD IOMMU specification (Rev 3.10) does not define interrupt message
> draining semantics for INVALIDATE_INTERRUPT_TABLE + COMPLETION_WAIT.
> This creates a race between vector_schedule_cleanup() and in-flight MSI
> messages still transiting the Data Fabric after IRTE modification.
> 
> Intel VT-d is architecturally safe due to explicit interrupt draining
> guarantees.  VT-d spec Section 6.5.5 states:
> 
>   "An interrupt request is considered drained when the interrupt is
>    accepted by the processor Local xAPIC (for fixed and lowest priority
>    delivery mode interrupts this means the interrupt is at least
>    recorded in the Local xAPIC Interrupt Request Register (IRR))."
> 
>   "Interrupt draining is performed by remapping hardware after Interrupt
>    Entry Cache (IEC) invalidation requests.  For IEC invalidations
>    submitted through the queued invalidation interface, interrupt
>    draining must be completed before the next Invalidation Wait
>    Descriptor is completed by hardware."
> 
>   "For index-selective IEC invalidation requests, hardware only
>    guarantees draining of non-committed interrupt requests referencing
>    interrupt indexes specified in the invalidation request."
> 
> Additionally, Section 6.5.2.8 (IEC Invalidate Descriptor) mandates:
> 
>   "As part of IEC invalidation, hardware must drain interrupt requests
>    that are already processed by the remapping hardware, but queued
>    within the Root-Complex to be delivered to the processor."
> 
> Therefore when qi_flush_iec() + qi_submit_sync() returns (Wait Descriptor
> reports QI_DONE), all non-committed interrupt messages referencing the
> invalidated IRTE index are guaranteed to have been delivered to the
> target LAPIC IRR.  The subsequent vector_schedule_cleanup() is safe
> because is_vector_pending(prev_vector) will always observe the drained
> message in IRR, causing the cleanup timer to rearm until the interrupt
> is properly serviced.
> 
> In contrast, AMD IOMMU spec Section 2.4.5 defines
> INVALIDATE_INTERRUPT_TABLE only as:
> 
>   "instructs the IOMMU to invalidate all cached interrupt information
>    for the device"
> 
> with no completion condition, no drain semantics, and no ordering
> guarantee for previously-remapped interrupt messages.  Section 2.4.11.2
> ("Invalidation Commands Interaction Requirements") limits the completion
> guarantee exclusively to DMA transactions:
> 
>   "Invalidation commands are considered complete only when the IOMMU can
>    ensure there are no DMA transactions in flight anywhere in the system
>    fabric that relied on translation cache contents prior to
>    invalidation."
> 
> The words "drain", "drained", or "draining" appear zero times in the
> entire AMD IOMMU specification (Rev 3.10, 48882-PUB, Feb 2025) in
> connection with interrupt messages.
> 
> Consequently, iommu_flush_irt_and_complete() returning does NOT guarantee
> that old (vector, destination) interrupt messages have been delivered to
> the previous CPU's LAPIC IRR.  The immediate vector_schedule_cleanup()
> after IRTE modification races with in-flight messages on the Data Fabric:
> the cleanup timer reads IRR clear (message still in transit), calls
> free_moved_vector(), then the message arrives at the old CPU hitting
> VECTOR_UNUSED -- producing "No irq handler for vector" and permanently
> losing an edge-triggered MSI.
> 
> Fix by restoring three-stage cleanup semantics for the normal
> (guest_mode=0) path:
> 
>  1. Change amd_ir_chip.irq_ack from apic_ack_irq to apic_ack_edge,
>     which calls irq_complete_move().  This ensures cleanup is only
>     scheduled when the new vector first arrives at the new CPU --
>     providing a natural delay (device interrupt period + PCIe transit +
>     IOMMU translation + Data Fabric delivery) that far exceeds any
>     residual in-flight message transit time.
> 
>  2. Remove the unconditional vector_schedule_cleanup() from
>     amd_ir_set_affinity() for the IRTE-modified path.
> 
>  3. For guest_mode=1 (AVIC/guest interrupt virtualization), the IRTE
>     is not modified and no host-vector interrupt will arrive (interrupts
>     are delivered to the vAPIC backing page instead).  Retain direct
>     vector_schedule_cleanup() in this case to prevent move_in_progress
>     from permanently blocking future affinity changes.
> 
> The combination of stage-2 natural delay and stage-3 IRR gating
> (is_vector_pending + timer rearm) provides robust protection against
> the AMD-specific lack of interrupt drain guarantee.
> 
> Intel VT-d, Hyper-V, and UV platforms are not modified as Intel is
> architecturally safe per the spec guarantees cited above.
> 
> Fixes: 5478844b12d3 ("iommu/amd: Move interrupt remapping to its own file")
> Signed-off-by: Guanghui Feng <guanghui.fgh@linux.alibaba.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h |  2 +-
>  drivers/iommu/amd/iommu.c           | 46 +++++++++++++++++++++--------
>  2 files changed, 34 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 8241ef922519..35024e3f5b90 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -1037,7 +1037,7 @@ struct amd_irte_ops {
>  	void (*prepare)(void *, u32, bool, u8, u32, int);
>  	void (*activate)(struct amd_iommu *iommu, void *, u16, u16);
>  	void (*deactivate)(struct amd_iommu *iommu, void *, u16, u16);
> -	void (*set_affinity)(struct amd_iommu *iommu, void *, u16, u16, u8, u32);
> +	bool (*set_affinity)(struct amd_iommu *iommu, void *, u16, u16, u8, u32);
>  	void *(*get)(struct irq_remap_table *, int);
>  	void (*set_allocated)(struct irq_remap_table *, int);
>  	bool (*is_allocated)(struct irq_remap_table *, int);
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 56262f6b1f70..60e769384e8b 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -3634,7 +3634,7 @@ static void irte_ga_deactivate(struct amd_iommu *iommu, void *entry, u16 devid,
>  	modify_irte_ga(iommu, devid, index, irte);
>  }
>  
> -static void irte_set_affinity(struct amd_iommu *iommu, void *entry, u16 devid, u16 index,
> +static bool irte_set_affinity(struct amd_iommu *iommu, void *entry, u16 devid, u16 index,
>  			      u8 vector, u32 dest_apicid)
>  {
>  	union irte *irte = (union irte *) entry;
> @@ -3642,9 +3642,11 @@ static void irte_set_affinity(struct amd_iommu *iommu, void *entry, u16 devid, u
>  	irte->fields.vector = vector;
>  	irte->fields.destination = dest_apicid;
>  	modify_irte(iommu, devid, index, irte);
> +
> +	return true;
>  }
>  
> -static void irte_ga_set_affinity(struct amd_iommu *iommu, void *entry, u16 devid, u16 index,
> +static bool irte_ga_set_affinity(struct amd_iommu *iommu, void *entry, u16 devid, u16 index,
>  				 u8 vector, u32 dest_apicid)
>  {
>  	struct irte_ga *irte = (struct irte_ga *) entry;
> @@ -3656,7 +3658,11 @@ static void irte_ga_set_affinity(struct amd_iommu *iommu, void *entry, u16 devid
>  		irte->hi.fields.destination =
>  					APICID_TO_IRTE_DEST_HI(dest_apicid);
>  		modify_irte_ga(iommu, devid, index, irte);
> +
> +		return true;
>  	}
> +
> +	return false;
>  }
>  
>  #define IRTE_ALLOCATED (~1U)
> @@ -3933,7 +3939,7 @@ static void irq_remapping_free(struct irq_domain *domain, unsigned int virq,
>  	irq_domain_free_irqs_common(domain, virq, nr_irqs);
>  }
>  
> -static void amd_ir_update_irte(struct irq_data *irqd, struct amd_iommu *iommu,
> +static bool amd_ir_update_irte(struct irq_data *irqd, struct amd_iommu *iommu,
>  			       struct amd_ir_data *ir_data,
>  			       struct irq_2_irte *irte_info,
>  			       struct irq_cfg *cfg);
> @@ -4153,7 +4159,7 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *info)
>  }
>  
>  
> -static void amd_ir_update_irte(struct irq_data *irqd, struct amd_iommu *iommu,
> +static bool amd_ir_update_irte(struct irq_data *irqd, struct amd_iommu *iommu,
>  			       struct amd_ir_data *ir_data,
>  			       struct irq_2_irte *irte_info,
>  			       struct irq_cfg *cfg)
> @@ -4163,9 +4169,9 @@ static void amd_ir_update_irte(struct irq_data *irqd, struct amd_iommu *iommu,
>  	 * Atomically updates the IRTE with the new destination, vector
>  	 * and flushes the interrupt entry cache.
>  	 */
> -	iommu->irte_ops->set_affinity(iommu, ir_data->entry, irte_info->devid,
> -				      irte_info->index, cfg->vector,
> -				      cfg->dest_apicid);
> +	return iommu->irte_ops->set_affinity(iommu, ir_data->entry, irte_info->devid,
> +					     irte_info->index, cfg->vector,
> +					     cfg->dest_apicid);
>  }
>  
>  static int amd_ir_set_affinity(struct irq_data *data,
> @@ -4176,6 +4182,7 @@ static int amd_ir_set_affinity(struct irq_data *data,
>  	struct irq_cfg *cfg = irqd_cfg(data);
>  	struct irq_data *parent = data->parent_data;
>  	struct amd_iommu *iommu = ir_data->iommu;
> +	bool irte_modified;
>  	int ret;
>  
>  	if (!iommu)
> @@ -4185,13 +4192,26 @@ static int amd_ir_set_affinity(struct irq_data *data,
>  	if (ret < 0 || ret == IRQ_SET_MASK_OK_DONE)
>  		return ret;
>  
> -	amd_ir_update_irte(data, iommu, ir_data, irte_info, cfg);
> +	irte_modified = amd_ir_update_irte(data, iommu, ir_data, irte_info, cfg);
> +
>  	/*
> -	 * After this point, all the interrupts will start arriving
> -	 * at the new destination. So, time to cleanup the previous
> -	 * vector allocation.
> +	 * If the IRTE was actually modified (guest_mode == 0), rely on the
> +	 * three-stage cleanup: apic_ack_edge() calls irq_complete_move() when
> +	 * the new vector first arrives at the new CPU, which then schedules
> +	 * the cleanup of the previous vector allocation.  This avoids a race
> +	 * where in-flight MSI messages, still on the Data Fabric after the
> +	 * IRT invalidation because the AMD-Vi specification provides no
> +	 * interrupt drain guarantee, arrive after the old vector has been
> +	 * freed.
> +	 *
> +	 * If the IRTE was NOT modified (guest_mode == 1), no in-flight
> +	 * messages exist for the host vector and the new host vector will
> +	 * never receive an interrupt (those go to the vAPIC backing page
> +	 * instead).  Schedule the cleanup directly to prevent
> +	 * move_in_progress from getting permanently stuck.
>  	 */
> -	vector_schedule_cleanup(cfg);
> +	if (!irte_modified)
> +		vector_schedule_cleanup(cfg);
>  
>  	return IRQ_SET_MASK_OK_DONE;
>  }
> @@ -4205,7 +4225,7 @@ static void ir_compose_msi_msg(struct irq_data *irq_data, struct msi_msg *msg)
>  
>  static struct irq_chip amd_ir_chip = {
>  	.name			= "AMD-IR",
> -	.irq_ack		= apic_ack_irq,
> +	.irq_ack		= apic_ack_edge,
>  	.irq_set_affinity	= amd_ir_set_affinity,
>  	.irq_set_vcpu_affinity	= amd_ir_set_vcpu_affinity,
>  	.irq_compose_msi_msg	= ir_compose_msi_msg,

Hi Guanghui,

Thanks for the patch and for the follow-up. We tried it on our setup,
on v7.4-rc2.

In our opinion upstream is still the better design, and it has no
regression here. Because of the problems below, we do not see a reason
to change it.

The patch starts the cleanup timer only after one interrupt arrives on
the new CPU. That is the difference from upstream.

1. On our setup, a quiet line never sends that interrupt.
   move_in_progress stays 1 until a new interrupt arrives, and the old
   vector stays reserved. Upstream freed the old vector in 1.77 ms.
   With the patch it was still reserved.
   If we change affinity again while that flag is 1, the write returns
   success but the line does not move. The new CPU is stored and applied
   only after a later interrupt. Upstream finishes the move in about
   2 ms, so the next write works.

2. A level-triggered line never calls apic_ack_edge(). That is the
   function the patch uses to start cleanup. The move stays stuck even
   when the line fires. Upstream does not have that problem.

3. The shared timer can be short. On our setup, a fast batch of moves
   off one CPU never waited less than 758 us. A wait under 100 us showed
   up only when a move joined a timer that was already about to fire.
   The patch uses that same timer and the same IRR check. It only starts
   them later.

As discussed, the machine is safe once COMPLETION_WAIT has returned.
The patch makes a normal affinity change worse for a quiet line and for
a level-triggered line.

-Ankit

> -- 
> 2.43.7
> 
