Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2071.outbound.protection.outlook.com [40.107.100.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21337221FDA
	for <iommu@lists.linux.dev>; Fri, 11 Apr 2025 23:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744414435; cv=fail; b=EHgxrK7HOD8xyg9YUOYXzU0fIMV22shACK+D/DKBijcW2uzuLjy1SvRC1mzzw1Weg3eMbBMHlz4lExLT98JBQvI0F7A2jOOqXHhWB55TrfbG/lX379FHDC3rTysWIuA02AiDoeaf9vyFQZbqZ0KvridbCCrf9tC147d75S/uuEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744414435; c=relaxed/simple;
	bh=RFWRGz6idvV8QbuEj/0TJfwnBC3gMixnQkrmhsItIn0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6UQcUOvnED/on7l37r/oTIR/WvOSRm4hJxkx0UhucavCjP59j9dmpYLlRJedBbhyb9h9Hec390QkeAZZq9EA5jj0so6TgdsvDTQuCBj1/KhIf3pC/XCVQkGTY2c9AG64AG6vXep2v5pO6sGoxcaoVVYqYcoj4rh9FJBgFoIi+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rJZCprbe; arc=fail smtp.client-ip=40.107.100.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rJZCprbe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/OfdYMaUQOf+5bbDvj9ijhtIY80znQL53IU88/BypVGVjvTwk0oF6UdK+bJf6ZNI+JZ5Hjy41XHxLfZmno5RtpnT+2HvHrUTaZoXmOCRqSYz7YXcW+4wT8ncDgmM/zWjT0zbjJ50sWFjQ5XVAMDfTt2U3WaujIi/CKLtresbEky40FteQW83IooG8Cr+zaQEV/+Lq8V5VSlCDfxRObpHunoR0hmUYL7E2brEg4Reb0TpjojPYa+i+RGh3Ow6IFgx6ieQ7sQ4lq8/dMavvV6nbHD3UDNY2oT1xYawrhpUMY51pPCj8UsUYe/6d985CsxQImGVZrhOEmPxMlnwtikRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZyRFEuj48Hf8Eod/Y+ZGv/wDfS+ooqZHDwn6qoOhNc=;
 b=CGA9Nfo8yVpberjtz/tbY6PwWwpQaOF1HNsJPP81+TqRRB3IN6yateAYBnl9pzQni7vA5ul+RlrFqkPxW0gSI9Zx8EFSKSXy3yad6EDY4aWSH5v3CzOBGyS+om/TvU3Ei40RinHY5QFmLxGm0cPxBod49zORHglTa9+PowwgkcQBsGmqGci54aMggMUPkBkGGqOskzyj/JKS0N9L82J0fkhG2YtDmBWvrkADepiyC6jsmUS5vfE/WiLy5PYY51VWNqiJTEG99GF0NzBgi9E1yiLcM+km+ReXg4OVmm7RSCmLC3wS0SoCL4hrTXAsVfIIpj7J/JOmq+uD8j1vUVfvGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 216.228.118.232) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=temperror action=none header.from=nvidia.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZyRFEuj48Hf8Eod/Y+ZGv/wDfS+ooqZHDwn6qoOhNc=;
 b=rJZCprbepluso5uD1tp4YgYrj5JBJPv9P5ypoWeVMJvYAVzcNm2y23vUFsrDHxXhKnvUiZ2pZLYFXgIUtN7zJI+rxb8OoOHt0MKv4fiXcQ3MlyDUdI0c4F6juVy+cxyjWxkvv8gl3ju45ezi6GQdUgac88Qw4HHHl3iFmZJfmEUBj7QX/cN667cpxxx0KMa0O0Z248dQ5xAE1oJ8lnrMUgbRjsEW8C3AZiQHZjaHlI055PwNRd4FtkSW8UHDbll/of1d6iAeII9PFTm/ukc4WpihLRjiqdrWZn66xFtep/gWpzxDa1NQwZInYlAwF2Ud6c4xwqa7+FpWNN01/mtvYQ==
Received: from BN9PR03CA0749.namprd03.prod.outlook.com (2603:10b6:408:110::34)
 by CY8PR12MB7196.namprd12.prod.outlook.com (2603:10b6:930:58::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.28; Fri, 11 Apr
 2025 23:33:49 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:408:110:cafe::f1) by BN9PR03CA0749.outlook.office365.com
 (2603:10b6:408:110::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 23:33:49 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=nvidia.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nvidia.com: DNS Timeout)
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 23:33:47 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 11 Apr
 2025 16:33:47 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 11 Apr 2025 16:33:46 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 11 Apr 2025 16:33:46 -0700
Date: Fri, 11 Apr 2025 16:33:44 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
CC: <will@kernel.org>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<jsnitsel@redhat.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Allow stream table to have nodes with
 the same ID
Message-ID: <Z/mm2EQAQtOqpVCy@Asurada-Nvidia>
References: <20250411044706.356395-1-nicolinc@nvidia.com>
 <5c8d16f9-246e-45d0-aaac-45b7712cefb5@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5c8d16f9-246e-45d0-aaac-45b7712cefb5@arm.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|CY8PR12MB7196:EE_
X-MS-Office365-Filtering-Correlation-Id: e862acf1-dcce-4877-550e-08dd79514f05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/njed4UD6T0tK31Gn9cYA128booAxSNlX2u3u3FSaE2U5ddqXplUKUxKvORO?=
 =?us-ascii?Q?XEL+6CVHs2LOf/noOaGD3ne7cGsmdvfx9pE32740x0L4hFE27O9igRSsqHW4?=
 =?us-ascii?Q?7apd4o+XwlaDvgUbL2vYzIlGa/FdMPjYK9FHrYD9OvzpdAAzq6Ay2fsf7fVt?=
 =?us-ascii?Q?OHvT3okgLT88UXyNSIv0RrdjymOAt5th6JbKYiXwiTWbXwlr0gkfaX0Rp4vO?=
 =?us-ascii?Q?sKgooDGlS/vLViQ8LDNAEyU5RtXXTKAMEcHX1EZFaPzf/HAgIi5iWvxcPJRC?=
 =?us-ascii?Q?fDI9kokE4MGc1XnrjEqHo/5L4Qx7SEHtRF22bgziyZuIkf68RTurz7KFreEW?=
 =?us-ascii?Q?RTldRXZ+UbxdTEy81YUilsZ9eULYVI7WRE5uimgn3YMEztqrQ0erToy9nGlK?=
 =?us-ascii?Q?kdBXlCTcIr761c6F+LAFPPzqKu3o1Dqemmf4UYUsdZ8M5HEunbucHCg+ixkw?=
 =?us-ascii?Q?nI+lx/QrJnABfcvaUKSfQSVkH6LapqxpVJVNTi5aEqiskcb92McbVO1LNogh?=
 =?us-ascii?Q?P/dmeEwOsm1wPoTYVz8wMypJAmzHIvY368HVHV0UvMi33LcBDzhd9FO1rzpC?=
 =?us-ascii?Q?WxeI9pElCxRRpVp4w/Xfc6FGMyK8vwo5p4NIXNIrPPSe8vfp+gwkVkBz9tt5?=
 =?us-ascii?Q?fpm/OhDzTosmalHkP9dF8N209RbD6rg8Kto+Uw6LqpMH/XAHFTx221oYqwnn?=
 =?us-ascii?Q?K6reBMuz7oqNpAULmNXBXdpZoVPZyuUAZ3nuNPUTuPJaplCsdVAChylHnsZX?=
 =?us-ascii?Q?5PoMQUGrjPKKOWr8wIRCv8tGVylc4fxVl34fGW5RRrpp6l4zM/femKmx28qm?=
 =?us-ascii?Q?dJQoZAFafGtLtaZ8H9dTHSc2dMTTtYuL2ARnXfeHR69gmsqJww6xv1seOVk7?=
 =?us-ascii?Q?kIYGmpQSnGme6mxcmjLzh6k9aN6hEA805k4Eux5A7HK5RNyZ+GWcOcfytnvn?=
 =?us-ascii?Q?oVK+HmG2j7ZjK05KTcEOraqZxIIO/jFJLWP3OzBdOCH47+GSy2smqJakD2U3?=
 =?us-ascii?Q?DAfta2O1JX6L9Kp7Q+YKYgV6kl1Tg/FQqIagzO0U0tGimzJzzTPsevZ+gorh?=
 =?us-ascii?Q?JM/qUYoI8dE6tMBlSjihL+VIeTuIdgAXCtqi76YjUqIr6DMYpepzLWeaLugX?=
 =?us-ascii?Q?fSnjom20JY8REIkNwNWdpvCoy+keo7lyBNJEu5qrvyCtVjnxOENagBb0I7RB?=
 =?us-ascii?Q?zv9nqXVAeHXT1OCsDe5J4mX39SwcPxQNHu7WM9RgwA1OGik5LOXZyZV7IQnN?=
 =?us-ascii?Q?OhPYVCAfBArkHXPhxvsWfaqeTa7wqE1TN46A92GW94Qpg4ASSmnrrzD3aYn8?=
 =?us-ascii?Q?PPjQrv2EUbQAGnj82grdwrex9OIQfD7e8yfSwbjwj7uUkdruic+1/P926ITL?=
 =?us-ascii?Q?pjEluEwlFTKwlwIm8vNrADb/kWUc+k9bbllpjEcukhS4sw2y0YrWdOScyInp?=
 =?us-ascii?Q?eFCluLWArOXsMMt5nNcQwSTMopJ9raH1w09OK7puIDcgRN8z7mV0t83JSZrh?=
 =?us-ascii?Q?W+NfgCK+ofKrVShQPjqyDxNvVqMvjiT4jxNB?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 23:33:47.9821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e862acf1-dcce-4877-550e-08dd79514f05
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7196

On Fri, Apr 11, 2025 at 04:13:01PM +0100, Robin Murphy wrote:
> On 11/04/2025 5:47 am, Nicolin Chen wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > 
> > ASPEED VGA card has two built-in devices:
> >   0008:06:00.0 PCI bridge: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge (rev 06)
> >   0008:07:00.0 VGA compatible controller: ASPEED Technology, Inc. ASPEED Graphics Family (rev 52)
> > 
> > Its toplogy looks like this:
> >   +-[0008:00]---00.0-[01-09]--+-00.0-[02-09]--+-00.0-[03]----00.0  Sandisk Corp Device 5017
> >                               |               +-01.0-[04]--
> >                               |               +-02.0-[05]----00.0  NVIDIA Corporation Device
> >                               |               +-03.0-[06-07]----00.0-[07]----00.0  ASPEED Technology, Inc. ASPEED Graphics Family
> >                               |               +-04.0-[08]----00.0  Renesas Technology Corp. uPD720201 USB 3.0 Host Controller
> >                               |               \-05.0-[09]----00.0  Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller
> >                               \-00.1  PMC-Sierra Inc. Device 4028
> > 
> > Being a legacy PCI device that does not have RID on the wire, the system
> > does not preserve a RID for that PCI bridge (0008:06), so the IORT code
> > has to dma alias for iort_pci_iommu_init() via pci_for_each_dma_alias(),
> > resulting in both of them getting the same Stream ID.
> 
> Hmm, actually, this doesn't even make a whole heap of sense, and it's
> not what's happening here at all.
> 
> The bridge *does* claim its own RID, and per the aliasing rules the
> devices behind it claim both their own RID and the alias to function
> 00.0 on the bridge's secondary bus, like so in action:

Yea, I just found out that the bridge does have a different SID.
It was actually the VGA controller itself having two fwspec->ids
populated by the IORT code. Then, the SMMU driver allocated two
separate streams with the same set of device pointer and SID:
  pci 0008:06:00.0: arm_smmu_insert_master: fwspec index=0, sid=0x10600
  pci 0008:06:00.0: Adding to iommu group 21
  pci 0008:07:00.0: arm_smmu_insert_master: fwspec index=0, sid=0x10700
  pci 0008:07:00.0: arm_smmu_insert_master: fwspec index=1, sid=0x10700
  pci 0008:07:00.0: Adding to iommu group 21

Perhaps the duplicated fwspec->id should be avoided in the IORT
code at the first place v.s. bypassing the fwspec->ids[1]?

Thanks
Nicolin
