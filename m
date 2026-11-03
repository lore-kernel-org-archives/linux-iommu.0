Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793723196;
	b=ifYIw7EUxA3MHnFYyBdw96AOqlTd3UJxqGxIrVaRwJ9LoddsUFG5kR43DfHcB67mUAHa
	 x6b629a1XlhYZRj4c1tzO3TpORvY3J9u3H+vO5icIRicE39GSbeYheFUfRQYOkvGsyE/b
	 egU4ZMhecnMhCjy53ETubd+hSOgvr0tjiVqpOArSFcJG3W7aXZnHhYVK5UAuMKjrm0xq7
	 +6YmGDz9zcM7ZPNasYtEMn43XkeeFPKDPIzdkvsbxGOiFmL4s7UhjXf52l3caCRsat7wb
	 VhyW54sa7mAAT04Jf4yA4i5/ytpMf2IbHxhrFX80VhwQlHXvnkGzfEL5jVjfL3gs3tA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723196;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=6zyMxWVaLRlrzyt0tmMAewN95mt1HurEOoa5PZ+1XiM=;
	b=lOXFrT6yxu/t8aorUoatH2x+H5748sWHmvBmkPSKepCCHG90C4onGGemm8r9UQk6fIHJ
	 gCbQo9zX7d82KJL8jmUA3bNdFCEJ3/vUKyL+O2EOHffD1JC9/BO2sxUGgPZ2a+C8Zg0bp
	 21XekEY+Otq4+x/QKvVyLWYXzABIGnJF3G30+H2y6z6I98B6fM5+K/NQWGdKBdkmKf7Ex
	 x3vwmLmjYnXEDyYRmaQJpxmnwh9Lpx6SRFi+Y0gQ0lJJ3WWz10ZCEpDs87mJ6CyTW0gQu
	 gVa+san5fSd5bMVMMRrA2HCLe+TZUePOyHXGxFbxflJ9zeUZ+GqHqWc9aKb4mhCCifA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=fa9GrIOj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.19
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010019.outbound.protection.outlook.com [40.93.198.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C10606A324
	for <iommu@lists.linux.dev>; Tue,  3 Nov 2026 16:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13C10606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=fa9GrIOj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xypmjGs1kSXMUZDFXKDayybtsseuc3iUrikOJx3ZN8G09pp9nk7Jpv1uQIpiN75Q6TRtfKbg5yQvhhQupWq1fKIG8lfJFPRrhKc3HVKQvVEAS1Urh7RMkIv6GqM/tQ9q/6LBszwaHsVlYk2x0fuxVFXRCPIs08E8qFN5FZibGweXq5qc/4BTYXiXrbqaMSdrG+Af0RUwLggUYK8EN3woULYIwN02CryxYe2DwWoXWMpEq8Sye+xHnxa8JcqpAVAFhdC7i8XTBFzJIIUJJ2twBj4bpHMIB84TAsblg/DmOVvFmM0a7znYB2LaVl92YgJpxTQaYVIR3RI8HGpNyGsinw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zyMxWVaLRlrzyt0tmMAewN95mt1HurEOoa5PZ+1XiM=;
 b=QKDBFM6iVo4YjOmvcaRfS5jM4HvPUNDOD0KOmImCxJJUqCS/fX2idbBdy1GeN2UdyswhhpFbdEGNTCgH7ws2cgGubmxvGVLhA5aEEc9xA3pKdQ4iatSXPQLW0mwBcEnPou7MhjazIAbE4lDVc05CJp/d538B6fKFC0/v7tfk7q+DE3h5YdyGuzHP+7zEnJhjoZm6RT0YAzNeneoOJUnR6z1LXr/DuFYav5oiBtdoqI3GMBUW5+6wFDSVo7/cIsjl32yqQYtklk3cHbihfUW6i6LT036talb7IdSdSyk63s+4kHXAVKFGIZn/cazWshbEFQs8LVQ5yOAgeflQyMIo4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zyMxWVaLRlrzyt0tmMAewN95mt1HurEOoa5PZ+1XiM=;
 b=fa9GrIOjfxkvoyllV35c+8hEPOpOJcfs3i8E9F3yWTdAd8V0+VmiTDB5yTxWe31zbjH2lVg+0LPzEPuC0uOFWkCYJDwx1Ky7mXDz454HAOTWS7hpzSoYTIh5WcejgadPxDfT8GLEbQCWWR+aCLoQEFRl3pP5Ttf+KC/ItJk/fRY=
Received: from CH0P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::6) by
 SA6PR12MB999201.namprd12.prod.outlook.com (2603:10b6:806:450::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 16:24:49 +0000
Received: from CH1PEPF0005BD5E.namprd02.prod.outlook.com
 (2603:10b6:610:ef:cafe::95) by CH0P220CA0008.outlook.office365.com
 (2603:10b6:610:ef::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 16:24:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0005BD5E.mail.protection.outlook.com (10.167.244.247) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 16:24:48 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 10:24:46 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 10:24:46 -0600
Received: from xhdradheys41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 3 Nov 2026 10:24:41 -0600
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <robh@kernel.org>, <saravanak@kernel.org>, <akpm@linux-foundation.org>,
	<david@kernel.org>, <ljs@kernel.org>, <liam@infradead.org>,
	<vbabka@kernel.org>, <rppt@kernel.org>, <surenb@google.com>,
	<mhocko@suse.com>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
	<baoquan.he@linux.dev>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <iommu@lists.linux.dev>, <kexec@lists.infradead.org>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH 0/4] kexec,mm/cma: do not run the next kernel from a fixed-base CMA area
Date: Tue, 3 Nov 2026 21:54:25 +0530
Message-ID: <20261103162429.2053989-1-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.44.4
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0005BD5E:EE_|SA6PR12MB999201:EE_
X-MS-Office365-Filtering-Correlation-Id: a2b4ae8e-8581-444c-18c2-08df39c6fb08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|23010399003|36860700016|56012099006|10067099003|18002099003|261009223027099003|261022075727099003|921020|261102123227099003|261021123027099003|261021121427099003|261022115727099003|11063799006|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	LuLvjFVnDBrU91Q4OP1QehB+udeusNPB+vvs0j90Avj7BssmtFwsSk44ipPx0vuEzIbSoFEfJzKt0p6DIFQXKuiyIho98OXIX1fwhWzoDRcheUHmaHxwrBWX6R+lNY+zt2YzPCExmbviL5znD4p+PLmTvpI+H2AS7duxJOmHTBs9IXmXmz0BJw+AdsJD+AmRnOTnfI3UYXH/N2Fv5NW3bujojxwdpyuQmrlxxXQshFSudNzIE8Wo6lMR7KV43nusWgNVgEN3+fKflrJP/CXSCyHwykMT/vyB5oBSS+XaGLO1wfzy+PdsNMmrCJAkOuDH77PuK26BNDuAUrErSHAxlL9nG/MVAT/4uiV5RyWNlx2lAFYdQ0aMnLxG1H0U90F/GXsl7p0mLQTPdq8KeDmyaEveHcoAd/v+aP1vMk0XQ9kwlCoXjDrlAleBQsRj2h2yomkGrbpBDTSaMQ/jQwz/FtteeXxNWH7JZgvn/ImhK9ScFGTgHlPK+6UgruXAPWFqa2/dweNkWDTBuIYbK62/3hsuah9A6XNyIkuIeVPQMWRfV/rSmlGnHVlWjVruRZWiLhtrESn4okvFp+0hdYVXn9Kwaqjsdt4PoIMu+9UcJwvW5aUTT7FFd+MHx9yQZzUWYdWR5xzhVWlphCgfGTrkdRbM6Nw4CdsabJl8UrBVYm/9tYvFT0+Jv4c4PtXwYvkQ
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(23010399003)(36860700016)(56012099006)(10067099003)(18002099003)(261009223027099003)(261022075727099003)(921020)(261102123227099003)(261021123027099003)(261021121427099003)(261022115727099003)(11063799006)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dNjv3IiiTvWJOExdT+n/aXaOt24uPeJgwW9EHjE7jKsEpmeVAQMMigmVO3akbgxqlZOB9FcA7UyxuzFLLdbpaV8G/qkqMN7IFVop+2uHY8g4467tfR/jKDHJzWwTVo+zdZEUAUYBwJ6HF4c24K6B5B/g8z3o3c8C2rL7fQ8Z5UkoYgj2QPNVcEXemXid2STOIMYcAQz1CluVSYC+Naz8Mn/COk1fPHz0VV/YY3N9jv6ihcPficU8XGbb/IdxQxYUa13gRp8w+d5MqLpmerGZI5tF5pcgu1lPIel2LSaKgGxRWA8yjGv+wVg+H6t0c8rlO/pfQ4yWnH3KPIxCuVU9jbLpRYZwkZazssrLRkcxIzprd4jpv6B+ClVf7RLAej2Z022rPMX1kgU+gFD6fhf6hrtBafhL9xmCnuFTqrHQzsKKvC/G9h3/TmrYo/ei237y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 16:24:48.7263
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2b4ae8e-8581-444c-18c2-08df39c6fb08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0005BD5E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR12MB999201

Since commit 07d24902977e ("kexec: enable CMA based contiguous
allocation"), kexec_locate_mem_hole() places the next kernel in the
default CMA area and it runs from there in place. If that area has a
fixed base the loaded kernel declares the range it is executing from
as a shared-dma-pool, and cma_activate_area() frees its own image to
the page allocator. On a VEK385 that corrupts kernel text within
~300ms of /sbin/init starting.

Patch 1 is the fix and stands on its own. Patches 2 and 3 close the
same hole for a device tree placing a shared-dma-pool over the kernel
image with no kexec involved; patch 4 is an unrelated cleanup.

Changes since RFC:
- Patch 1 records CMA_DYNAMIC_BASE rather than CMA_FIXED_BASE.
- New patch 2 answers the RFC's open question (Pratyush): -EBUSY from
  node_init keeps the reservation, so refusing an overlapping pool no
  longer frees [_text, _end) along with it.
- Patch 3 reordered after it, returns -EBUSY, rejects a wrapping
  base+size; both Reviewed-by tags dropped for the rework.
- New patch 4 drops the duplicate alignment check (Mike).

Tested on VEK385: with patch 1 kexec declines all three device-tree
pools; without it the booted kernel refuses the overlapping pool.


Link to RFC: https://lore.kernel.org/all/20261014145731.3431527-1-radhey.shyam.pandey@amd.com

Radhey Shyam Pandey (4):
  kexec: do not place the next kernel in a fixed-address CMA area
  of: reserved_mem: keep the reservation when node_init returns -EBUSY
  mm/cma: reject CMA areas that overlap the kernel image
  mm/cma: drop the duplicate alignment check in rmem_cma_setup()

 drivers/of/of_reserved_mem.c    | 14 +++++++++++
 include/linux/cma.h             | 10 ++++++++
 include/linux/of_reserved_mem.h |  5 ++++
 kernel/dma/contiguous.c         |  5 ----
 kernel/kexec_file.c             | 12 +++++++++
 mm/cma.c                        | 43 ++++++++++++++++++++++++++++++++-
 mm/cma.h                        |  2 ++
 7 files changed, 85 insertions(+), 6 deletions(-)


base-commit: d6bcfc94eb4da6e089c5473970cd96727292fd97
-- 
2.44.4

