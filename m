Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012027.outbound.protection.outlook.com [40.93.195.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1703B47F5
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 09:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774863317; cv=fail; b=Gyl1T5dtqqZwZedNyCQBMPtC5sk7c9TvWC+semyX/bwmTxlalXIju/8+ZI7feCEaLAZr9qzL3s8oDPXmiB5D0+r7pNXLfhRYWjMFLgaWfmjx0ozboi2U21ogvcwuLT6bDu5s6j+ijAfqkJY6qc7vRGIhhhQzqclu9cfo0q46U54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774863317; c=relaxed/simple;
	bh=Lr7r5qK5T7fTN4BQxv6KBY+UI0G214GeK75Uk4AzoZ0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXy0Np+iDQnz/tjJnTluHKqZRPHx3qnRn57S02xHJsfCZ5/mWVmadq1QqxHzlibgoEltkAhZh9UogNhkOFnKbPmc7GSeQqDG6nLq9/OvB0pCFpH/ujoZKpzt6kb5as3ReoxB9v74XUJo4uT59LN7wHB7hZF0uLt0HTlzhbY+pUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DXY0WT1K; arc=fail smtp.client-ip=40.93.195.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DXY0WT1K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f32WG6lQxoDysZss35k2Ad0PKtTxhArOgEQd30oecMZdvP26Mj54PaRgZ66c+oNbPLG3w+kyc2TIKro1V5qmw6Ml3sKKCjLSMvK+Zu0MYvydIvmG8RRG0qnmupKYyV6LWVtcaUSJBVh2BccnrR42hOHioCH+vefqJP0Hx70EutMBoVMxCQxshvIQlFIIrVc3gxFCMfDnl7iFh1HBGwcHj7diWr/3tynDk7rPNPwdHZSqOcQWqXuX2ghvwyvPy0fudH4d6Wal+KvjOo1t4VK5lIed948nm+QqY6SJ1TBc1UhzP05w+sS/5Rqyd+ahzgtjNXasevJspkWJ31sGB669dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vcTbQFV8qkKeIM9r5kND5lS4l1X6aTVBv7+aoqjGHYs=;
 b=WG4aAwYrqysyxrzxpDneUX2tHDfWQhnCMvJORcIosWQunDE7mD/z500yprVsaEuQNIG1sNEU7s7ppywgFrzlFTbkktkIpgJBccz4iQ5noz6eAWrRzFzJrPsek7AJliIe/sf7UJUEi193dCh5wj5+rETf9W2ShDeMg9RQaVepvZdK2yY0QU2Ld6WSYxYp/NFNdn19LzMK6wZ20ipYpinSoZwBlLLkqlLXa9wIPW0/sHIu30Jz5VfyW6WPJc2vWZ81GnkZq4xlvBSQMdfxO3eAFGe/7925RStOjq16kcTxnFp5mQozZ9O5WcOoS8YJw9X2T4a2CoM4zbmCXP0jdtN3TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcTbQFV8qkKeIM9r5kND5lS4l1X6aTVBv7+aoqjGHYs=;
 b=DXY0WT1KGkOZbsHlGysrMNNmVH3FLkgZy9q6fDXMq+1S/ZwEnN60Y5bSaL+uti9TYpbSA+PIRgvBnwaHBxygzKS+1YhMzYjl4CiW02Jxr8c3TsQOPFPtoUkzAcmLZb+jXzz9nDIBkY5DvrrSGKRcniFeT0A7Uy4ohEF8We0JOh4dpMMCyeHRULxUzuACv5ASNhMXhJOwAnDol9bIaDyhNIZerNRaF4fkNzfzR1KkMxHrFvmnfopZTxU9FWZdsfM+ijOHRTWZDy1QhTT+d3wg59MEfgRVgghTKI8nwaMUFrrsJOugEpOwJO5TbT61bpxlfhD7Faup6m5JmZWIaZa5ng==
Received: from MN0P222CA0030.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::32)
 by DS2PR12MB9749.namprd12.prod.outlook.com (2603:10b6:8:2b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 09:35:11 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:531:cafe::cd) by MN0P222CA0030.outlook.office365.com
 (2603:10b6:208:531::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 09:35:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 09:35:10 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 02:35:00 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 30 Mar 2026 02:35:00 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 30 Mar 2026 02:34:57 -0700
Date: Mon, 30 Mar 2026 02:34:55 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
CC: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>, <yi.l.liu@intel.com>,
	<kevin.tian@intel.com>, <vasant.hegde@amd.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>,
	<wvw@google.com>, <wnliu@google.com>, <dantuluris@google.com>,
	<chriscli@google.com>, <kpsingh@google.com>
Subject: Re: [PATCH 02/22] iommu/amd: Introduce vIOMMU-specific events and
 event info
Message-ID: <acpDvyrd5Yz/luK/@nvidia.com>
References: <20260330084206.9251-1-suravee.suthikulpanit@amd.com>
 <20260330084206.9251-3-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260330084206.9251-3-suravee.suthikulpanit@amd.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|DS2PR12MB9749:EE_
X-MS-Office365-Filtering-Correlation-Id: fe45b173-b853-46ed-1c90-08de8e3fa38b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|1800799024|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Acv/kzievfzCKe6sf517x6AtvLVgmzA8o2pDW/nMHfFnu4dtekjLZxJJniS0rTIXMha53HRum+VvMGXAhUr3SlYyytSB056eOtnV9aXaVp1zJl+ONVPrHscBrH66RD7H3jvMe565MdBPYZFD6cXU8/i+EeeUBm41Bo0HpSFu8U2QE5uhzZpYMDiOzx5KoaVk7s2BQlArT9fD1q4yLKK4Gqs1ViXEn+smO49s3HC9eluxuHxiN8Z+pwNhX0HDcry5IDEIamJe3NPAhAvci9yGPOgRvuVMNoAbRVx9k5zD+JIMmC+q0GPZLB2E+FC4Ggz+Z/iVaq/HN+yQ+Rs7QxALJSQbk/XpIq9h859dPYgnbSQpfbAfrw64gexzm+k4gTHAuf1wzYAITuYbxI5ci7ILSpMJ8w52Zy8GcydrbLI5iA7d8WoZQnAXLXp1DBMvXfdUcJkrCqkHMTnbF8R1a8q1I0b+bSJZHdTnOb1oS+DOqKotTZoQ0Vx+ybLCbcAm3YZsjGTXfSoeaFf1ioqI+vSB4B7p659ibiB8mgsbfsRKRbLlW8RiZnnltulRWhDOU0E8hSP+xYarjQGG/1M0lVAB0M5qVxLvF6Y482QiEvthu1rLzgvGI37O/+d+nnn/uo1LDNWwstjCUNMWpgpinMNiJXJauus8ekHPqErDz2H8b5FPMDJKCSP1xL6sRoR9E+2J5i0Nt5ox61Adognowv2ogxZkrgCZ5ieaBfeO1SrMK11PXABmymzd/rJJ1wNUaNbOJgqGbBEXtthteurZrt8cWg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	24y8i/g4P4ADPrzgW7hd/7XdK8lb+m2JdbvFAyhNCEzn6hzysAKF5FafPZ85nL/O6Xdu6oyY4s0pOKYvKv8dC5Z62i9Paxa1PmoEZwGV9Cvdzv0thXz28k1Oo1L26WkR4xkdLMYuoYKSh8cVaHCqCgxOmTQjD8YNMisIcMKU+dNe6fBkJZe3/sDJxkeVlS5uUAe907U4OaMISyFVO7SCKKt6yJ3cgBUkG9tnSYchtchBWmOgxKpay1Garwe5WnLBhEXWMkONz+D1WHnGYGSL8gvKGBlMkdMgLBbTnvUdEccECVGx46II/eltrKGTJgwb+0+QzQSG9IA4ida+tQAWwM3nJg7QaPS+P+ydhnv37Hr/GVYXFfOIjVYDBYEduf1SzrMxMiCc3P2k0Pzh6sENAfpg9+SmHSYU6ZZPDWm9c+s4dNQ4xZefq8yJwRv/mWYI
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 09:35:10.9086
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe45b173-b853-46ed-1c90-08de8e3fa38b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9749

On Mon, Mar 30, 2026 at 08:41:46AM +0000, Suravee Suthikulpanit wrote:
> @@ -927,29 +927,42 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
>  	}
>  
>  	if (type == EVENT_TYPE_IO_FAULT) {
> -		amd_iommu_report_page_fault(iommu, devid, pasid, address, flags);
> +		u8 vflags = (event[0] >> 27) & 0x1F;

Hmm, I don't see this vflags field in the AMD vIOMMU spec
(48882-PUB—Rev 3.10—Feb 2025).

Anyway, perhaps define a pair of SHIFT/MASK macros like other
fields?

Nicolin
