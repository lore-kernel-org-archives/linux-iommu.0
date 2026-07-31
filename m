Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013068.outbound.protection.outlook.com [40.93.201.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB13A35C6AD
	for <iommu@lists.linux.dev>; Fri, 31 Jul 2026 05:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785477516; cv=fail; b=lywHCTBDBN9NSmh7hkh/02HkROTcdMDzE60B9RjrQ/5aiy8F7PPRs95A8C7S4ajNlxKjwyJfDwAH6j61NuBK3oOYwJDUH68sA9NkL1rfDP90ZPbak5Cgg64zQVCO4r2WhojKEk1xXQfn/3Wfyr79tNYph/I5xmoQSvcuinBBiHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785477516; c=relaxed/simple;
	bh=BTJk5Ttut2JDLTlC663gMAHiYl16rF1yEItZwbc+mwE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nU9DeYE5vVHwmjdjhutgyZxD3AEAH+z2zm+ooT4afJMDF5iUMsHH6q6TgPjW7l3W1bPoVijgF+CDb0yUIV3j1hgdfIpmR2+Dg/sUHN96qqyXf5qgciLg2e9RFIGmTrtig+S21CrVOhZ/KQZGIhCTHN6Ievs1FsgLHd1Q8JtEcOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gsU+bE3H; arc=fail smtp.client-ip=40.93.201.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gsU+bE3H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oq68crtN9yQuTvpdMxzwSY1pxg3Y5al+cj8f5br24lBCSr0QIOt9q6RZEolrewOs9qHxfdHYvPF0F8BF76n4D4u0mX2LKAOdS4RFidOY+HYJIHUnSUXHrtg2VTzMfi34HTGSN5MOG1bbWkpTKJWTtkcQgXYrEYTRoQs9QyZoEQVLdXxy+2U6C9zTwql+PGggnGDGiCNwiBwLix7H8NUyNAZZLzJOJ8P1C4Bu+D4fw14VaB8CLBOpnYHTIC2JaZo3BgSno64msngRcYHAvl36k3qOgQjY0IofVJL6S+4Gp++GjvO/1ACpUk/BgU3dgJTtyMC/rXULH7ixaDcHw5JPUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSH+I+YTNVY8aISRLViNforhatn+0Xuiiy2hyD4X698=;
 b=SSQ67PpG8tKHhb24oRfwwv5+wpTKD5q2UwgoWZoVnco3Y1zoYcaN7JkkxShGggvcv1CFIotx3hVtRosebuJf5robLt5cEQyRQhBMo+HeY9qXmk+HtlBnJWTWDiHmaxFVRpT7njP/SHvDEAkoBJLnnAccbHBn9i0gzpY277e5JvsriduZV5lcRImhfsEZQGysL8S2GS1JtJxuyGBMFNfhL3fhtW1drcjmxUvdIUikbh06IWdCFqsH5XTNww+fUWGQslbUJ0/wLl9sHknkKwvDpyImRJG3TVCgH9zcnv++/coFH0GVGh9tz42MiEJWzdKTXDjHKe0R+H3SYCcxwy68hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSH+I+YTNVY8aISRLViNforhatn+0Xuiiy2hyD4X698=;
 b=gsU+bE3H1kGT7RJ04zw40NMM2Z6u0tkIW47mHNCtrFCLjWOpn4VBuGbQ2IfSGn1DxEYUSmWFskuMhD0YrZ5ieqLmQWJxviKP4HIVLbGZxbW8KqnhWpjLJB+Yy6y4VbNzc0JMJ+AVlKLiJPwQSB52Ot2j7Nt3u/75fvciVXaqYOM=
Received: from DS1PR06CA0028.namprd06.prod.outlook.com (2603:10b6:8:23e::8) by
 PH8PR12MB6722.namprd12.prod.outlook.com (2603:10b6:510:1cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 05:58:28 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:8:23e:cafe::5b) by DS1PR06CA0028.outlook.office365.com
 (2603:10b6:8:23e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.16 via Frontend Transport; Fri,
 31 Jul 2026 05:58:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 05:58:28 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 00:58:27 -0500
Received: from amd.com (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 00:58:23 -0500
Date: Fri, 31 Jul 2026 05:58:20 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Samiullah Khawaja <skhawaja@google.com>
CC: David Woodhouse <dwmw2@infradead.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy
	<robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, Alex Williamson
	<alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, Pratyush Yadav
	<pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, David
 Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>,
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v3 02/18] iommu: Implement IOMMU Live update FLB callbacks
Message-ID: <fjma5ub62ia4pbcvs4yek52r6jlhut4fidutow3g5uhf6iel3o@iqx3a6bm4q2e>
References: <20260614233728.2212104-1-skhawaja@google.com>
 <20260614233728.2212104-3-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260614233728.2212104-3-skhawaja@google.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|PH8PR12MB6722:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f07407c-1660-4f68-4e58-08deeec8be2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|7416014|18002099003|22082099003|4143699003|11063799006|56012099006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	55sN9s6RRZCrXkpJjcY1/a1p5oiA9dyLx0CBc8nyR75pQ+7/f0T4GSRAlJPkJPh6xLFpWgHUTBkV6B94jkQRMUPIEoNT43Qinf3PULDf/crTKNTljjPyiNuaCh4SQPOxQe9L31JGctsYafiFdkswdkR5UnxHM9fR1jzNlsPvYe9yVyU5K5aofmzGlsJLVsoH2eKvHVvRjOOZid96tj2n47/ToiLI0Q1gD6WBKiyfQyvWRuwomGaM4rkOO99NsMmksTVawWEKVo8NvJ6NfeAZQo7uI2ZPL9kwZnmmGCu5d5QR1CEYv3g8MI8NxkkEKKcsspmA1dFjCY0oOo3cA5MxUqmUVS5GE+wc0M+86WOez8MveIrbuToFHOzOki6UWABdsFfixiwBqP/mR/GSJfOVA1kbsrRhcv53WnqDd/UGxaJf3A9S1ubWyYJnsmKImRqIU5eG1uab+d0a/zRuBOnoREFZiNzXDhbjs/fAVyeZ9A4B4C8JwllRQ5LgUG6liEuFSR+MuYozXZ9alG6O6/0eK9PUb06jrRejOyhWQftny2+JsWhlAb4+AzEXQNAmtS1WXsn5h9/usBPcRRdjARxIpoAaaY6jw2WuIVwZXitSkOH3gjFccX9I05WFQ0FuPkWVA4QyXF6667ZnXR8JPrE4ZqDT7BLk80LWdYcPYm0m3tu5HfaTdYt6PAvDBtwFKtJXCvWrSmCe/w4EgiqxNsH0IQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(7416014)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NE1nQE2oyAGUylSxmH/1pxpm1I2rnjCo4lTaDPIdOl2bniJBO3jxMoP3SaxQmL5AMuAol7QKTvTnQ2SOF/FVx1JiA33EAyMm6olHrSVw1gBl5i8efUxgTDWcu3Cj99PLUr1nUeK0EEmls9Xxiib0T9dWSzyId/MKr0mnhGfoMRWc0n2EPsBH+sqTHg6SryDvz76vfrjkIB5L0a+dPcpTZPcBo1RbWly6R7pCs9F4Rlz8/VhLDF4LNd+0r4UtkAJYnDyVwm1M8hTt8rGvhZ1qO31wUxMk1GknHT5BUzHDZY/U/9vX7UlS1HB9nM9xahkNkLd7hrziScQRJNGFwrBsLpnD1X7boEOQLY1CcdGxJtxr/Iu7Em5FHNjDABp7E19r5bX5dWBnI+VbddSG5F6JyUBL47JxRhVplnYQMnSrQdoOkeecwAIG7uwJAFKQDkA6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 05:58:28.4028
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f07407c-1660-4f68-4e58-08deeec8be2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6722

On Sun, Jun 14, 2026 at 11:37:12PM +0000, Samiullah Khawaja wrote:
> Add liveupdate FLB for IOMMU state preservation. Use KHO preserve memory
> alloc/free helper functions to allocate memory for the IOMMU Live update
> FLB object and the serialization structs for device, domain and iommu.
> 
> During retrieve, walk through the preserved obj array headers and
> restore each folio. Also recreate the FLB obj.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  MAINTAINERS                      |   9 ++
>  drivers/iommu/Kconfig            |  12 ++
>  drivers/iommu/Makefile           |   1 +
>  drivers/iommu/liveupdate.c       | 212 +++++++++++++++++++++++++++++++
>  include/linux/iommu-liveupdate.h |  18 +++
>  include/linux/kho/abi/iommu.h    | 207 ++++++++++++++++++++++++++++++
>  6 files changed, 459 insertions(+)
>  create mode 100644 drivers/iommu/liveupdate.c
>  create mode 100644 include/linux/iommu-liveupdate.h
>  create mode 100644 include/linux/kho/abi/iommu.h
> 

../..

> diff --git a/include/linux/kho/abi/iommu.h b/include/linux/kho/abi/iommu.h
> new file mode 100644
> index 000000000000..d06f251a2df4
> --- /dev/null
> +++ b/include/linux/kho/abi/iommu.h
> @@ -0,0 +1,207 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Copyright (C) 2026, Google LLC
> + * Author: Samiullah Khawaja <skhawaja@google.com>
> + */
> +
> +#ifndef _LINUX_KHO_ABI_IOMMU_H
> +#define _LINUX_KHO_ABI_IOMMU_H
> +
> +#include <linux/mutex_types.h>
> +#include <linux/compiler.h>
> +#include <linux/types.h>
> +
> +/**
> + * DOC: IOMMU File-Lifecycle Bound (FLB) Live Update ABI
> + *
> + * This header defines the ABI for preserving IOMMU state across kexec using
> + * Live Update File-Lifecycle Bound (FLB) data.
> + *
> + * This interface is a contract. Any modification to any of the serialization
> + * structs defined here constitutes a breaking change. Such changes require
> + * incrementing the version number in the IOMMU_LUO_FLB_COMPATIBLE string.
> + *
> + * Memory Layout of Serialization Structures:
> + * ==========================================
> + *
> + * Each serialized type (IOMMU, Domain, Device) is stored in a linked list of
> + * arrays. The first array is allocated initially. When an array is full, a new
> + * array is allocated and its physical address is stored in the next_array_phys
> + * field of the hdr of the current array.
> + *
> + * Top Level (struct iommu_flb_ser):
> + * +---------------------------+
> + * | - iommu_array_phys        |
> + * | - iommu_domain_array_phys |
> + * | - device_array_phys       |
> + * +---------------------------+
> + *
> + * Each Array contains the serialized objects of the respective type. For
> + * example see below the representation of struct iommu_domain_array_ser.
> + *
> + * +---------------------------+   +---------------------------+
> + * | iommu_domain_array_ser    |-->| iommu_domain_array_ser    |--> NULL
> + * | - hdr.next_array_phys     |   | - hdr.next_array_phys     |
> + * | - hdr.nr_objects          |   | - hdr.nr_objects          |
> + * |                           |   |                           |
> + * | objects[]:                |   | objects[]:                |
> + * | [ iommu_domain_ser ]      |   | [ iommu_domain_ser ]      |
> + * | [ iommu_domain_ser ]      |   | [ iommu_domain_ser ]      |
> + * | ...                       |   | ...                       |
> + * +---------------------------+   +---------------------------+
> + *
> + * Each object in the array starts with a common header (iommu_hdr_ser).
> + * For example, the layout of struct iommu_domain_ser is:
> + *
> + *   +-----------------------------+
> + *   | iommu_domain_ser            |
> + *   | +-------------------------+ |
> + *   | | hdr (iommu_hdr_ser)     | |
> + *   | | - ref_count             | |
> + *   | | - deleted / incoming    | |
> + *   | +-------------------------+ |
> + *   | - top_table_phys          | |
> + *   | - top_level               | |
> + *   | - restored_domain         | |
> + *   +-----------------------------+
> + *
> + * This pattern applies identically to iommu_device_ser and iommu_hw_ser.
> + */
> +
> +#define IOMMU_LUO_FLB_COMPATIBLE "iommu-liveupdate-v1"
> +
> +/**
> + * enum iommu_type_ser - Type of the IOMMU being preserved
> + * @IOMMU_INVALID: Invalid type of IOMMU
> + *
> + * IOMMU type is stored in the IOMMU HW state to differentiate between various
> + * IOMMU HWs.
> + */
> +enum iommu_type_ser {
> +	IOMMU_INVALID,
> +};
> +
> +#define IOMMU_SER_FLAG_DELETED	(1 << 0)
> +#define IOMMU_SER_FLAG_INCOMING	(1 << 1)
> +
> +/**
> + * struct iommu_hdr_ser - Common header for all serialized IOMMU objects
> + * @ref_count: Reference count for the object
> + * @flags: Bitmask of IOMMU_SER_FLAG_* flags indicating object state
> + */
> +struct iommu_hdr_ser {
> +	u32 ref_count;
> +	u32 flags;
> +} __packed;
> +
> +/**
> + * struct iommu_domain_ser - Serialized state of an IOMMU domain
> + * @hdr: Common object header
> + * @top_table_phys: Physical address of the top-level page table
> + * @top_level: Level of the top-level page table
> + * @vasz: Virtual Address Size
> + * @sign_extend: FEAT_SIGN_EXTEND is enabled for this domain
> + * @restored_domain: Pointer to the restored domain (valid only after restore)
> + */
> +struct iommu_domain_ser {
> +	struct iommu_hdr_ser hdr;
> +	u64 top_table_phys;
> +	u64 top_level;
> +	u32 vasz;
> +	u32 sign_extend:1;
> +	struct iommu_domain *restored_domain;
> +} __packed;
> +

Hi,

nit, The v3 changelog has "Replace bitfields with u32 flags", but sign_extend:1
looks like it was missed. this is 37 bytes, the only arrayed record in this 
header that isn't a multiple of 8 (iommu_device_ser is 56, iommu_hw_ser 112).
The arrays are strided with pointer arithmetic, so the skew accumulates: from 
objects[1] onwards none of the u64s are naturally aligned.

Looks like a leftover from the bitfield cleanup.

-Ankit

> +/**
> + * struct iommu_dev_map_ser - Serialized mapping between device, domain,
> + *				    and IOMMU instance.
> + * @attachment_id: ID of the attachment between device and domain.
> + * @domain_phys: Physical address of the domain
> + * @iommu_phys: Physical address of the IOMMU
> + */
> +struct iommu_dev_map_ser {
> +	u64 attachment_id;
> +	u64 domain_phys;
> +	u64 iommu_phys;
> +} __packed;
> +
> +/**
> + * struct iommu_device_ser - Serialized state of a device
> + * @hdr: Common object header
> + * @devid: Device ID
> + * @pci_domain_nr: PCI domain number
> + * @domain_iommu_ser: Domain and IOMMU mapping
> + */
> +struct iommu_device_ser {
> +	struct iommu_hdr_ser hdr;
> +	u32 devid;
> +	u32 pci_domain_nr;
> +	struct iommu_dev_map_ser domain_iommu_ser;
> +} __packed;
> +
> +/**
> + * struct iommu_hw_ser - Serialized state of an IOMMU instance
> + * @hdr: Common object header
> + * @token: Unique token for the IOMMU
> + * @type: IOMMU type serialized state belongs to
> + */
> +struct iommu_hw_ser {
> +	struct iommu_hdr_ser hdr;
> +	u64 token;
> +	u64 type;
> +} __packed;
> +
> +/**
> + * struct iommu_array_hdr_ser - Header for an array of serialized objects
> + * @next_array_phys: Physical address of the next array of objects
> + * @nr_objects: Number of objects in the current array
> + */
> +struct iommu_array_hdr_ser {
> +	u64 next_array_phys;
> +	u64 nr_objects;
> +} __packed;
> +
> +/**
> + * struct iommu_hw_array_ser - An array containing serialized IOMMU HWs
> + * @hdr: Array header
> + * @objects: Array of serialized IOMMU devices
> + */
> +struct iommu_hw_array_ser {
> +	struct iommu_array_hdr_ser hdr;
> +	struct iommu_hw_ser objects[];
> +} __packed;
> +
> +/**
> + * struct iommu_domain_array_ser - An array containing serialized domains
> + * @hdr: Array header
> + * @objects: Array of serialized domains
> + */
> +struct iommu_domain_array_ser {
> +	struct iommu_array_hdr_ser hdr;
> +	struct iommu_domain_ser objects[];
> +} __packed;
> +
> +/**
> + * struct iommu_device_array_ser - An array containing serialized devices
> + * @hdr: Array header
> + * @objects: Array of serialized devices
> + */
> +struct iommu_device_array_ser {
> +	struct iommu_array_hdr_ser hdr;
> +	struct iommu_device_ser objects[];
> +} __packed;
> +
> +/**
> + * struct iommu_flb_ser - Top-level serialization structure
> + * @iommu_array_phys: Physical address of the first array of IOMMU HWs
> + * @iommu_domain_array_phys: Physical address of the first array of domains
> + * @device_array_phys: Physical address of the first array of devices
> + */
> +struct iommu_flb_ser {
> +	u64 iommu_array_phys;
> +	u64 iommu_domain_array_phys;
> +	u64 device_array_phys;
> +} __packed;
> +
> +#endif /* _LINUX_KHO_ABI_IOMMU_H */
> -- 
> 2.54.0.1136.gdb2ca164c4-goog
> 
