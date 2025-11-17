Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010021.outbound.protection.outlook.com [52.101.201.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582B930E822
	for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 05:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763356914; cv=fail; b=kW7pNPauCKsxjGveZ6q9CJj5zx3BsjJvg1BrTMP7/6E9wEf3NLtFlu97TVHTPHZ4d0wRmbjwDEI4uIrLlhJ2ZLKCxGCRpx1xQmfx6SxU4SIQpUU0rkn0qTiXAHOO24fTXW4mhqVQ76mI7txC/Q/gROHSpsyQLKupSUIUNACig1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763356914; c=relaxed/simple;
	bh=q9ztj7PJHnBTKQJZFW9xDtRT96/jZcdjF36uI76jn+w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYQ41rxJI8Oid8tO/UQdUzRKvL5523bq9I8k8NmoGiQO7bTGuQOmiP6Nd67hlHUVUHBmIilq911BOLsB08AXp/rE+vsO10RaJR0XFyQ46jc92RH5WSC7j8sygcbN55Le+LqLy+0jWqm/cnavIFv7qrlNohw4+1n0zFec/2jF5Io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Zse9WqOi; arc=fail smtp.client-ip=52.101.201.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Zse9WqOi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pF1rup8TjauVytyMMlufPTAZi1/DYPP7K9e5l9DTR8y/inDze108m+/236pGByZB+gPMNgmsyaKWVHwbujQddIsF4ORV/JoyJr/9SSbPPbG6fEi/FpKCcqdCKCU76jtcMCTHPonQzKp0H2gvzu7hjFdLd+1ksWq8muzaB8O3D4LnkWw6uhjO1gl52wkv2CYvjmoWc16qonOgXWH0dyOXx02ziMrugmhU5E280dbdOfGdzIuEN78KfW5gTIGq0qvgRofdIWSC/ovtLcuLt1/TzY1n4Rcn0cVzS8F4Jkzz9DfVUZl+XDdEuTN0vGnlFBqdrjbHrzfmi31jwuKptz3R0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1GYKIihe5HhG7C2ReEdGjlsIWfq6YchPZg7nyraoW/s=;
 b=tEOeCpBqDrBFykic0/FUOP/Afv6zofK7FqqltMjOFSFiO4k93Xre7Jcj8tVlweJmXhsih13dqrEOnLFoHtjvAqka/pButufaYBCDrdB7JZYJXJNxWw3OcRAENWjpv/Qt3DIKePIzJnEzU/9gXn/7Y+vM6orp7RuSdy24fP2JbctfREEetWGwDwQn/U0ldaMDLk9L77Iqkf5GWsVw8koqbfqIOzx3pzql27O9eEi47qjtx7uCITyqWcyZs3G/MTX/hiUtXXmxlds2bb4aaHcjqbdItSXRlKqx5rhySc6W5dCtrnVmtsujtv7SlY816BL2P3HC2g/E+oiNqYAgKMmn5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1GYKIihe5HhG7C2ReEdGjlsIWfq6YchPZg7nyraoW/s=;
 b=Zse9WqOi5JpO0MP1zXwpaPq3jBS2K3E9S+xUNNKhqhknify4u3FLGqEXykQQz5qa7XtAuq+LE5Y37Up6wwCw7c7wVWz7/ogvnp4OtURE3JzZ9L3tjxwfzCB6DupriJtg4zmKMa+QO07nRn73Jaa670XZDXhwG8SxLi+cwlc4ddQ=
Received: from DS7PR07CA0018.namprd07.prod.outlook.com (2603:10b6:5:3af::27)
 by SA5PPFDC35F96D4.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 05:21:50 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:5:3af:cafe::fa) by DS7PR07CA0018.outlook.office365.com
 (2603:10b6:5:3af::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.21 via Frontend Transport; Mon,
 17 Nov 2025 05:21:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 05:21:49 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 16 Nov
 2025 21:21:49 -0800
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 16 Nov
 2025 21:21:48 -0800
Received: from amd.com (10.180.168.240) by satlexmb08.amd.com (10.181.42.217)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Sun, 16 Nov 2025 21:21:46 -0800
Date: Mon, 17 Nov 2025 05:21:35 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <vasant.hegde@amd.com>,
	<ashish.kalra@amd.com>, <robin.murphy@arm.com>, <will@kernel.org>
Subject: Re: [PATCH 1/2] amd/iommu: Preserve domain ids inside the kdump
 kernel
Message-ID: <7wueupy7eekotvlskujbg3ltfx5moc7g46oaseadpud2gkeea2@x2k254g6aqcq>
References: <20251114104442.23296-1-sarunkod@amd.com>
 <20251114104442.23296-2-sarunkod@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251114104442.23296-2-sarunkod@amd.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|SA5PPFDC35F96D4:EE_
X-MS-Office365-Filtering-Correlation-Id: 77f79653-4d19-4f30-c8e9-08de259935f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PdDRUhDCMGPuNVg1J66DDwEjgOTwszCqhDpgeszUq3YMsEf4rmcLS0I4Hj8y?=
 =?us-ascii?Q?kNcTDEAolkAKMCgUlPSdXB4q02O3ex34VIhLmaNooLrO7XQmxZcjPpRUGXfn?=
 =?us-ascii?Q?a0zGPNkg/dUVivj+whiNvnpAmDsB6OKQk9PK1fe+XXu+iKm8Nd1u2FFaYIBn?=
 =?us-ascii?Q?nZHOLtFq7q+0sqdKYsvZlrLrq3/1aQ35ukbI3ZK9F0XAkb1TFSmqOZYPsrN9?=
 =?us-ascii?Q?6zRUW09zj5m+66KyXXACRiXA+ubzjoqDzBkWgcaEJ55CE4IuB5DcVXZ4fOO2?=
 =?us-ascii?Q?haLnHIVRHuzjKYnVWs+FuLqZJsF/9bleuVYfYSFMtM3+H2mAvEUSmNJrOfwK?=
 =?us-ascii?Q?sCqrAkTkX0M64fyKDyq37j43sWf3LOJ8Q+MSvXvSTbZaA0ncroMxNUSx1RfS?=
 =?us-ascii?Q?ZVeh2BM13lR4+WyKOBlulPiXm6VTrRklTirKpA40/R1J2yF7hOH3+kjur26r?=
 =?us-ascii?Q?2cAl1Cfy60yTJ9PCSxLLWo75WO09gF9sLsKkAdmgdrWcTZAHNzs3KDw5B6BC?=
 =?us-ascii?Q?vfxsjlieMH+/NySX42l44+uQOKiRgfBnJOSPu2ujrrfq2O61pzJ3KQ1AGAsN?=
 =?us-ascii?Q?FoPiPTYOHraKEiAV0FYyiNiWuhLExKsXP8bZkARXjUycoH2GEguflRHasZVi?=
 =?us-ascii?Q?aSZxkfQpxnaBMPpj8lFCv1n1QBLGDxKgsNl7sCvKsarpvCeoQlcdX/oxHRgZ?=
 =?us-ascii?Q?5s9u9EuBwRru8sL5myuHhug7vug6KNYgM3stNh8EUlsXoeQ7vY1AlapPu5Q4?=
 =?us-ascii?Q?kjb9mP7toiLFdzf4ZPMKBTJsXPTsuwU3Im2TLLxmvIhvh/YCJGdx+WVk7fG8?=
 =?us-ascii?Q?Fp7uYhsPrDPBGus4f5Zr1i1c0UMw76sB7Xdhpfli79xBT5aystFWJj8Qph68?=
 =?us-ascii?Q?GLS6YvbApL1HtMv5toawUNTYmi7JL7pNsMlCp6OYCq0T/DICP9V1rMA0iUPO?=
 =?us-ascii?Q?tPE7mTU4nEtQ4VBVQQa1u3+FP5pT3Q/CnyfJS8In/1KVMWsmCpzRmrMECH/2?=
 =?us-ascii?Q?QPvpiRsvOnRvDNKHeOlRsFI+039RMGh8+D3vq6oqEw/gUuOihCTemK/Jz1+Q?=
 =?us-ascii?Q?/LBxIcwM3BX+Edf+oIMETQFuUxBCB75OKu4gRdgfh4Bt2tGyeW42D98RJ3T8?=
 =?us-ascii?Q?+Ppzo4gBYMHvsMrbp7Dxyeq8RBKYigntcg4EkzK4NYVikTdhFP6ZIF4Pp+N/?=
 =?us-ascii?Q?wCN79yo/TbIO0IVO8c9UQ9gzgiiUL618QaXK3uV9xxvl0bFWdEN1Iki350aM?=
 =?us-ascii?Q?EzaKQBIkHiVRbrYTaXEvQRHIv1LRmE3+FX3nbtghIliAaZk41FZNlXCSLn6m?=
 =?us-ascii?Q?iYxxU8tZJHrwba+O1ZkpCKe8LJ/mqRnzx83wCu2gBRFjobUtE3V7Ama1WKd7?=
 =?us-ascii?Q?grWGLL2bcgP+My6pokkhn2GpsGmox5gPpiKBexA4vixog09MA1JxVUzib+K0?=
 =?us-ascii?Q?NDiApQeQaNvKAmfkRs+dudTuwpCmTVFDUOdKvOQG7SZ0GF6tLBrwrfHBL2uJ?=
 =?us-ascii?Q?EHmjVzpvuDTcVHuM/sY6Zy6dIpmkiTSS7wg1oiQ1re/vXvmua+wCAYkFQ/kn?=
 =?us-ascii?Q?KeIsNh8rYN2TSf3494s=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 05:21:49.7723
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f79653-4d19-4f30-c8e9-08de259935f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFDC35F96D4


Hi,

On Fri, Nov 14, 2025 at 04:14:41PM +0530, Sairaj Kodilkar wrote:
> Currently AMD IOMMU driver does not reserve domain ids programmed in the
> DTE while reusing the device table inside kdump kernel. This can cause
> reallocation of these domain ids for newer domains that are created by
> the kdump kernel, which can lead to potential IO_PAGE_FAULTs
> 
> Hence reserve these ids inside pdom_ids.
> 
> Fixes: 38e5f33ee359 ("iommu/amd: Reuse device table for kdump")
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
> ---
>  drivers/iommu/amd/init.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index f2991c11867c..9375fba1071c 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -1136,9 +1136,13 @@ static void set_dte_bit(struct dev_table_entry *dte, u8 bit)
>  static bool __reuse_device_table(struct amd_iommu *iommu)
>  {
>  	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
> -	u32 lo, hi, old_devtb_size;
> +	struct dev_table_entry *old_dev_tbl_entry;
> +	u32 lo, hi, old_devtb_size, devid;
>  	phys_addr_t old_devtb_phys;
> +	u16 dom_id;
> +	bool dte_v;
>  	u64 entry;
> +	int ret;
>  
>  	/* Each IOMMU use separate device table with the same size */
>  	lo = readl(iommu->mmio_base + MMIO_DEV_TABLE_OFFSET);
> @@ -1173,6 +1177,25 @@ static bool __reuse_device_table(struct amd_iommu *iommu)
>  		return false;
>  	}
>  
> +	for (devid = 0; devid <= pci_seg->last_bdf; devid++) {
> +		old_dev_tbl_entry = &pci_seg->old_dev_tbl_cpy[devid];
> +		dte_v = old_dev_tbl_entry->data[0] & DTE_FLAG_V;
> +		dom_id = old_dev_tbl_entry->data[1] & DEV_DOMID_MASK;

Consider using FIELD_GET().

> +
> +		if (!dte_v || !dom_id)
> +			continue;
> +		/*
> +		 * ID reseveration can fail with -ENOSPC when there

s/reseveration/reservation

> +		 * are multiple devices present in the same domain,
> +		 * hence check only for -ENOMEM.
> +		 */
> +		ret = ida_alloc_range(&pdom_ids, dom_id, dom_id, GFP_ATOMIC);
> +		if (ret == -ENOMEM) {
> +			pr_err("Failed to reserve domain ID 0x%x\n", dom_id);

Can we use ratelimit, as in kdump kernel pr_err can be bit noisy.

-Ankit

> +			return false;
> +		}
> +	}
> +
>  	return true;
>  }
>  
> -- 
> 2.34.1
> 
