Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011050.outbound.protection.outlook.com [40.107.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A89E3B813A
	for <iommu@lists.linux.dev>; Sat, 17 Oct 2026 18:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792263180; cv=fail; b=etHC3d7NZgCsn0TkmcK+J8KM8m1LPPaFNjnWr1ls0FMZM2Rne5H82PFJXozUyNH1bqBr88Y1SgvtVsilorijnEenXfpmM37clIbVVI3EjVSvmFJQpUPeUvQdI4m7MgFEuS2NlDT9uBRW++YCGjxJTmPbv7avTnyntX5weVMmDm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792263180; c=relaxed/simple;
	bh=fRjqPKHGPYYWwIQKbhIQe4YUC72OBJb2LsnJJO0D4EA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGtszSV4G7laJjFIJ/YA0wKn1o2Hjc8R+TGaY7/vKEWVVGizfKAwxkuoABgdUhkS0EFdaXU7aQCRXSD6svUUzKIAPZmgYV73PjmlnL874DEYxEww3iJS1iU11z6B9cXosiuZcnfDjoXYk1Jl/pb/R6NAcsICVJoXj7nIbVagiBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ULXkPGq+; arc=fail smtp.client-ip=40.107.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ULXkPGq+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SOtauT+41YUPIDGcnPR48TmjHAp8ZZ7eGxE8zC1yC2hKG3dZVIPIs70eGpyw6UROLWdLSn4oXjOjZ8aR2dPZsIANrhAF1q80lPaxPxWTeh5UxKoNXZB0lX8q9MOKIorpTouMgCUCmgR9qfGhdpEME6eLc48gXVKT3VDF1B5hQQ/GotmOpS4+0+0m7bO6sMqo5vRO0wx7slUh6pJBt77CVxF+VySkho0xrkfyp1C/f5qi/f3SMwrALj53TzjDfmk0ut9VsnWPWWE2glEW73M2Bo6eqeuUzKBHJOIxuviM+uluhK6mSyDuPNIfx0LuLvvWnXKHB49gRxH/TBTWWt8gvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fnG1IHbKdrW5+1vo0oRNSVva4D3AZOkREuzQNjGzOQQ=;
 b=e0vT2W9Ex53WmycrAcotrx6F1UkdYWwKumNWRs/qHBScoOOThpNLktaUqEcQ2qqtvFtf/bYRUl0sWCTvDpJnLuWstYwWMNw43ri6oak0z2YH4626umhiV1QeD6a1sE1LhMCI//kZ9rytO/t/aX4xH4iilCrbDkCgdkJcq3xlZvg2ugD/YGzHFH+Hm/N7SUJ2CaHNlP+RG2lUJ30a+Jm/hokvG/ovBE7zJUgT5QnRcvPp9ogJdJugYY5M0zZhZ1vMnW5PVb1XD6GjG/CFNbFb0UnWaWjRxDoS1HSNMru2SaNCNN3hJADGSaFae3kKYrdzWhrIkUiJZnEkMI9SK5zTSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linux.alibaba.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnG1IHbKdrW5+1vo0oRNSVva4D3AZOkREuzQNjGzOQQ=;
 b=ULXkPGq+nWguu9U8G6cBRE41jRRuvsCdmfAPXmWTZU5o6ba1b7wLqtAJICo4CnNpZiHyeURO4CBo0+w0mKu3eRRo8J+kJ7n7GYBi5z9PtwBYppZCgtAGOT7QOe4jlwaPq9vhX5u7CNhYi+aDVNipuoenYPmVpWDhVACzoa/DhZSFyK56iOsxlRkUMalcACNJIrPFdE8twhLCeKFPSdyIy1FZd2rTuNKxBLtPTquzFZyP7x6AxYfD6HKoxH2Aq+A5YdQk84V883revaB8QgMgKVyxdQQc0NbM3aeuoyBOla0mfaVkjZWLcdd4oeqvGmQ4L4Hhs/TKmLmOwpilVt5RsA==
Received: from PH7P221CA0058.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::28)
 by PH7PR12MB5951.namprd12.prod.outlook.com (2603:10b6:510:1da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sat, 17 Oct
 2026 18:52:52 +0000
Received: from BY1PEPF00026964.namprd05.prod.outlook.com
 (2603:10b6:510:33c:cafe::a3) by PH7P221CA0058.outlook.office365.com
 (2603:10b6:510:33c::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Sat, 17
 Oct 2026 18:52:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BY1PEPF00026964.mail.protection.outlook.com (10.167.244.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Sat, 17 Oct 2026 18:52:52 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Sat, 17 Oct
 2026 11:52:51 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 17 Oct 2026 11:52:51 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Sat, 17 Oct 2026 11:52:50 -0700
Date: Sat, 17 Oct 2026 11:52:47 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <praan@google.com>, <kevin.tian@intel.com>,
	<smostafa@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <jamien@nvidia.com>,
	<kas@kernel.org>, Cristian Prundeanu <cpru@amazon.com>, Breno Leitao
	<leitao@kernel.org>
Subject: Re: [PATCH v11 00/11] iommu/arm-smmu-v3: Adopt the crashed kernel's
 stream table for kdump
Message-ID: <atPD/yTKA1Jw3bS1@nvidia.com>
References: <cover.1791226953.git.nicolinc@nvidia.com>
 <27f2e050-10c0-4a77-8d59-00a95a162912@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <27f2e050-10c0-4a77-8d59-00a95a162912@linux.alibaba.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF00026964:EE_|PH7PR12MB5951:EE_
X-MS-Office365-Filtering-Correlation-Id: c068e7dc-89b8-4488-eb35-08df2c7fd8db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|23010399003|7416014|376014|4143699003|56012099006|18002099003|22082099003|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	nIbCEIq3wVML9+dCGxIYI3EwinKQcP0XZ4qmrXUiTF/YJmXHKQUssjrGx9vx1B6zLqm/mBl2nmVTYX5N8m910MkajryUGTRLCUfp5QXLhSXiw7lQW3Oa1cGWhknBN6Zmshzk09b0+PQBzSgukXmSk5RxO7fFolFFSnIupeefgrpgV3XEzz29QCr0V8IjSbUOJCmHf0aOBz6/u1cPTzxa2Ivokrotk75mkqsL6PsPhjk48xoSN6jmYfpfhMm78qlh/vFcibuXwypoJOYPFUFGXRTEikXxZJlQBIQMqmET3MAyOWuvFkDxHT6qByg0vKycOky0Sh2oetPRXDatQdIQAjepWebhR704J+WjVUxRLQf2YhWVx9MwOWv/ejtbx+r648IwFCkMGMMBrJYaujLjZsb7stHIonaEKRJ1dHApBiSH/n4y7WtjXC0oppn2isSwGIw+uy0dMZfS0r2ZDW609EQy3u7Vu0KVX6x/WLVCjw6OgDDtMgTtfR7DCaBk0FQmCgvg4RLe0dmTCKtV223xe5fRYIHdfAeRi08dpIte4Lm5135XyIaH336Y8hi+f8ld3+IZsySYYmKHRCGGYdgnDkXuv/HgM2J69jJFsgF/BBp5w1oSUN5ReWRDsabYStA/GaT7lkEMeuDxlSj+ukmQ79GgBFzpzbEnDybU3Y2E7tOnj9uuplHJwRJuCiBLqgBK8ckMMNlnsbMfhTlViKHxvg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(7416014)(376014)(4143699003)(56012099006)(18002099003)(22082099003)(6133799003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Y/2BpgpMVeCtGiTgQupv+bCDJRhQptll+bf64fDbZefIoMkcYZyAZjNRX6vmWSMiNavp8wFQlAu0QWH3TaZ4n9qPT6oS+Ps/AKxU2G+CAdlfh244TxSudtXAWME8LInkzQr2VTPoX2XZHhQJc97aRccS4UiMRiaeMljm8ZsfHnN4e+nX+juzT5I4pJY+x1MuiqnrRa/DyJ/LFj+BAo9VDzGYMe425eDYHA611TjKxqamVWhz5xtKGp9rtJoQl7H9XKipfoRBu4BHNT+WiUEaLRKuQKGHaukoUw7NGS0frUtPd2ThOG0gWGTDDSb25OlV3mMvr9m2FXc2pqQ8Wk/5PiiV56eJrfs/ZvXrOu16I2uvyrWmkAjJ2ftXEyIVsfD58Bx+6t/Sbg78SB2iu4SZTRjgfMRNvifV4yLJjd2z22FecOGAb45opFfXc0zBf2DT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2026 18:52:52.0503
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c068e7dc-89b8-4488-eb35-08df2c7fd8db
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF00026964.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5951

On Sat, Oct 17, 2026 at 04:19:20PM +0800, Shuai Xue wrote:
> We tested this series (v11, backported onto our 6.6-based kernel) on two
> arm64 server platforms that differ in how PCIe errors are reported: one
> with firmware-first reporting (GHES/CPER), the other with OS-first AER
> plus DPC. The test triggers a kdump crash (echo c > /proc/sysrq-trigger)
> on an otherwise idle machine and compares the capture kernel's dmesg
> between the unpatched baseline and the kernel carrying this series.
> 
> On the firmware-first platform (10 SMMUv3 instances):
> 
>   Unpatched, every SMMU logs:
> 
>     arm-smmu-v3.0.auto: SMMU currently enabled! Resetting...
> 
>   and the destructive reset immediately aborts in-flight DMA. The capture
>   kernel then drowns in a storm of GHES/CPER records together with PCIe
>   AER "Poisoned TLP" (Data Link Layer) errors from the devices that were
>   bus-mastering at crash time. Devices behind the reset SMMUs fail to
>   recover in the capture kernel, and in some runs the capture kernel
>   hangs in the error storm instead of saving the vmcore.
> 
>   With the series applied, all 10 SMMUs log:
> 
>     arm-smmu-v3.0.auto: kdump: retaining SMMUEN for in-flight DMA
> 
>   and the capture kernel boots with zero AER/GHES error records. A
>   complete vmcore is saved and the machine reboots normally.
> 
> On the OS-first AER/DPC platform (8 SMMUv3 instances):
> 
>   Unpatched: 8x "SMMU currently enabled! Resetting..." followed within
>   seconds by PCIe AER Completion Abort errors reported by the root
>   complex, along with DPC containment events and EDR notifications. The
>   NICs behind the contained link never recover in the capture kernel.
> 
>   With the series applied: 8x "kdump: retaining SMMUEN for in-flight DMA",
>   no PCIe error events at all, a complete vmcore and a clean reboot.
> 
> The baseline symptom is load-independent: it reproduces on idle machines,
> since even an idle server has periodic DMA in flight (NIC rings, NVMe
> admin queues, etc.).
> 
> Overall, on both platforms this series turns a capture-kernel boot that
> used to be buried under fatal PCIe error storms into a quiet one that
> reliably produces a usable vmcore.
> 
> Please feel free to add:
> 
> Tested-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks for the test report. I'll add your tag in v12 (on rc1).

Nicolin
