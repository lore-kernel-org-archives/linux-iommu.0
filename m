Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010002.outbound.protection.outlook.com [52.101.46.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C1A2D8DAF
	for <iommu@lists.linux.dev>; Fri,  7 Nov 2025 14:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762524444; cv=fail; b=aQ/FRtzE15+nQsW8vRiEmHWzcWC7dXYCFLOmQagUdhMhQxex5H7vFeThvtVjD3ghXR1JN1BMyf/8GxIBUAy+qLZ9yvsXHp3ojDbbpEH41Fz/TraI4Ri58n7QU4uTVeiSRttqyfWYYG8gmTzZUqO/EasJQ3B30Ig/xQ7SQvCDpnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762524444; c=relaxed/simple;
	bh=Ep9aDrA6RSKkd5OZlYu3J8tdwTcsjee15X81WNHPIZM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eksHL5ZsopxEnTfWrRJfHAC6w6raEqbCRje6Frv10r9RQB798N/04EpX/bEeie80dHmOY9mag6RxcGqqu+iG2aKJUsP5oQJc2IMWpYZ6qb5FkyCTVJxXeCa8+HeSF3mB9FCpCdr2Xi/cGEh5d6elRMI1AN6y9si4XkmRxwsPpiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bqzVLpgh; arc=fail smtp.client-ip=52.101.46.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bqzVLpgh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FeI2LO8NtZcDNFQq2B/AXzG6TSAvXuXQN9142nfAYvKscAVznWvrkDg5oPLmf4R4iGFBgSMBK9CB6k2Tr3bf0P6ZHvaw8j8AGvTzgmChsYfCy7m/gb71a4eqF/CQHZd0T3xhMOxNZ6NjWH0LP5MR493+KQ30L+5MbDpkaP1f2zd5r0L5G0rSMnXBdaTS2JlThxR3F1vdA2eY3LeplzqbkEIHfxe+28XWYGYDIFi3WoQIZsPdJgHHXR65Q8S1EB3iIYMnnZzStoO67IPhAVEuTcsJDEpzC+cVPLHh0+GgOIVwYAxIZoNKat2JuJyTEc09d039qOkf+ODYcbIBVPkPaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7tB9Obc7A6oQNJW0/9KpkbjzZL7nOCQejlkJysmJCQk=;
 b=KOHbRdx0Aom3CZlxROk4kCR1Ka2RhcqMSqNsXNNcFwWKv/TfYylW2uGQHrG6rOeoHtGzg//F4z/VAOYc0VbOrwyh/KbXxWK3QSk10lp6kz1PVagPrJGJUzsY/V/rz6LxO9iQrrJ1up/9sSB9zONQvDbYXtyCNPHieV4ALXamQNhVuO2APiXl93z9HBxvnT5ga6S5eaWg8IoXnV7j3TmTiILtKTQkOymnxapU0wv3BHmmNQiVoLHtspRs0VEmGp45/j16HpGA4FQZAfiSVn169Hj0ONiBrB+3cDeo2MNtLzDegulWDDGkyYQ+Jf7i0ZjWKRB2E9tUyYHqsqaHKZKqOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7tB9Obc7A6oQNJW0/9KpkbjzZL7nOCQejlkJysmJCQk=;
 b=bqzVLpgh6Ae1qg47/T88r8PKgPk8lh+XOceSXyK2JV6IvdA87Q9rl/mWVT2gyx4HHcipNvH+Jmz9sL7HeGj3W/KaKKLGcBpor2C1EnBoJEQfr7jPOzajrL/xrXEh2wlFdrrsINuljbXf1QLDzRYiBCNsu0V6qUFnbYl2tmRJ3YY=
Received: from PH0PR07CA0097.namprd07.prod.outlook.com (2603:10b6:510:4::12)
 by BN7PPFA8145BD40.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6de) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 14:07:14 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:510:4:cafe::6e) by PH0PR07CA0097.outlook.office365.com
 (2603:10b6:510:4::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.13 via Frontend Transport; Fri,
 7 Nov 2025 14:07:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 14:07:14 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 7 Nov
 2025 06:07:13 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Nov
 2025 08:07:13 -0600
Received: from amd.com (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 7 Nov 2025 06:07:10 -0800
Date: Fri, 7 Nov 2025 14:06:59 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
CC: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<suravee.suthikulpanit@amd.com>, <Vasant.Hegde@amd.com>,
	<Santosh.Shukla@amd.com>
Subject: Re: [PATCH v4] iommu/amd: Enhance "Completion-wait Time-out" error
 message
Message-ID: <mmmsb4pp37slzy65ez4z5i7z342zx3vdxbll5axuio2ugdzzbt@i6yurbrb7k2o>
References: <20251105080342.820-1-dheerajkumar.srivastava@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251105080342.820-1-dheerajkumar.srivastava@amd.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|BN7PPFA8145BD40:EE_
X-MS-Office365-Filtering-Correlation-Id: f6ae6a31-4021-40a1-f22b-08de1e06f3dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7E1O0HedS/CffI44DQqaMbVofen+xdT1y4UF/QcS+7qPuDYrJztgpzPUFHLM?=
 =?us-ascii?Q?uc4bTIgKLHY1U4FIQepRACbtUEOA+bJV/05lyIHs7f7LTL9RGr7pE7VjUvEL?=
 =?us-ascii?Q?OMtAOsaH73TxDJJMDxCDRw+RmjgiLTwCDEzA59vYjOQgvHOk2B5K0zyqOmfI?=
 =?us-ascii?Q?8+3bgtGdNiGFNVi/WyTz3atbnlhyyrUeOtNhFTgYphCTZgQ5H8kvxq685WvN?=
 =?us-ascii?Q?39DGoQNb9QMi48OJlQTpDFUf/8luMox7h24Oe4Ul66vBH/n6kZ+/rfqxdTQ1?=
 =?us-ascii?Q?4bCBnHVc6nK3LE+weKiSdLqytZ1A2TIsx4rmoU8PfajO+RIQ7ApepeycTa07?=
 =?us-ascii?Q?C1tKyngwMErKCoq7qQrXo7HiAIv0Lb/g0cpFEYSc6TV5XhpEaMg5hwwUN+v5?=
 =?us-ascii?Q?HODcRVDAG/i+QTSuHNlM12s3wGdiXJAZZaoX7LdxoWTgQ6+PKDWC9tcelmVY?=
 =?us-ascii?Q?eIu8OMD5VhVJLOFIrX5GDniO5SCux2TilZYXAgwuI1Z5dSIae8y0xZmE2N1v?=
 =?us-ascii?Q?DLqajwHzKNyv3XoPu12np6Lf+ft36iU7SZ3OELAMuF6R+WvIYHQCsZiD71S2?=
 =?us-ascii?Q?7M9oJhVxfsMPinq/oQj3UmGR25osQfqArLsXjGQdJL9tJF8DEP62xNO5n40q?=
 =?us-ascii?Q?qSGT+Sx8cEEnyHMwTPMjPftRu0P47L/iDeKtC1yrE0SNdSO6Yv3JfsEth0qc?=
 =?us-ascii?Q?QGHUm7TJKMoSrXToLtmvuoG1IUrVwqDm6iL2oe+LYGg9KCv+KRSlNoKYSEmz?=
 =?us-ascii?Q?zSDnXvET6iLGPYKQ8HcpT4eM5f0XCLTCs9ASJYza+qAu4m1o6/3z46U3e+UM?=
 =?us-ascii?Q?tf8pFLMj8D+Qnm8gNn8s9eyrUZ74xqW3Z064VhBGnNVVhygXLlJSwxe3mPmT?=
 =?us-ascii?Q?ndK58DTZ1neLjmdAm0e6oEJvVa+qMRPAP+XJIpwvn8FkjA+jgyY1XXiTgSKA?=
 =?us-ascii?Q?SOAKk7OlWZB3qcfjgwiyP28MCbsbPnx9btpokSRRSbyvlTVI5uXONQDLyl6u?=
 =?us-ascii?Q?q6uN2y7AOj67ePrSxuHQ7HaLOJ3uS0UuO+nfjSMK9WQW5FlcKwDK9S4wQVgR?=
 =?us-ascii?Q?TKo6pOK81bs8Dui2bCjsKDjUTNQ5QGUhgaqOqYbQWL1KD3yZERDdOQeFqYOa?=
 =?us-ascii?Q?cStM124CRz9oC5Ywt0G8W+0dz/k8tqxo/p3ZLcq0NAoRURNXcGcyEZXNx+wO?=
 =?us-ascii?Q?ZPJFmJKMRhSIz0nHQHplki1aup0lgh1Og4MzKovdm/Pu/+vIILIkqld3J94d?=
 =?us-ascii?Q?x1xWbHKSemu2cV4qgUrVQaB8R/sENTUn3Xq8nZohCCqDrfMVDCrH5nmw2OtO?=
 =?us-ascii?Q?VDFNZu2vj0FeRu7gVf6ecuxoH/RbOX7I7Vq7ouhBSvAuDwjNCjlBHKF0eUST?=
 =?us-ascii?Q?TKisxv63erJVi1xe3RtiB9PIO2h/1UpVo9Mb/hTyLRb3O93TcKPuctNcXZPH?=
 =?us-ascii?Q?FR0cQkc/vABjeHovykTkb6FotxQ+DNXagsShU4G1/PeYVgThc4PXmKkQEeQW?=
 =?us-ascii?Q?Cki9enZNJjzMPog+ctJfhRXCzEQInUUUL8F9kifeckeu6yiGzZ+QYEzAkK49?=
 =?us-ascii?Q?tFXghtFxFoPyLJbcvcc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 14:07:14.2285
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ae6a31-4021-40a1-f22b-08de1e06f3dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFA8145BD40

Hello Dheeraj,

On Wed, Nov 05, 2025 at 01:33:42PM +0530, Dheeraj Kumar Srivastava wrote:
> Current IOMMU driver prints "Completion-wait Time-out" error message with
> insufficient information to further debug the issue.
> 
> Enhancing the error message as following:
> 1. Log IOMMU PCI device ID in the error message.
> 2. With "amd_iommu_dump=1" kernel command line option, dump entire
>    command buffer entries including Head and Tail offset.
> 
> Dump the entire command buffer only on the first 'Completion-wait Time-out'
> to avoid dmesg spam.
> 
> Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
> ---
> Changes since v3:
> -> Dump the entire command buffer only on the first 'Completion-wait Time-out'
>    when amd_iommu_dump=1, instead of dumping it on every occurrence.
> 
>  drivers/iommu/amd/amd_iommu_types.h |  4 ++++
>  drivers/iommu/amd/iommu.c           | 28 +++++++++++++++++++++++++++-
>  2 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 95f63c5f6159..7576814f944d 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -247,6 +247,10 @@
>  #define CMD_BUFFER_ENTRIES 512
>  #define MMIO_CMD_SIZE_SHIFT 56
>  #define MMIO_CMD_SIZE_512 (0x9ULL << MMIO_CMD_SIZE_SHIFT)

It's worth adding comment for MASK 4-18.

> +#define MMIO_CMD_HEAD_MASK	GENMASK_ULL(18, 4)
> +#define MMIO_CMD_BUFFER_HEAD(x) FIELD_GET(MMIO_CMD_HEAD_MASK, (x))
> +#define MMIO_CMD_TAIL_MASK	GENMASK_ULL(18, 4)

Since HEAD and TAIL masks are same, may be, you can use something like
MMIO_CMD_HEAD_TAIL_MASK().

> +#define MMIO_CMD_BUFFER_TAIL(x) FIELD_GET(MMIO_CMD_TAIL_MASK, (x))
>  
>  /* constants for event buffer handling */
>  #define EVT_BUFFER_SIZE		8192 /* 512 entries */
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index eb348c63a8d0..abce078d2323 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -1156,6 +1156,25 @@ irqreturn_t amd_iommu_int_handler(int irq, void *data)
>   *
>   ****************************************************************************/
>  
> +static void dump_command_buffer(struct amd_iommu *iommu)
> +{
> +	struct iommu_cmd *cmd;
> +	int head, tail, i;

Since readl returns u32, prefer u32 for head/tail to avoid any surprises
or sign-ext issues.
and similarly use %u in pr_err() below.

> +
> +	head = readl(iommu->mmio_base + MMIO_CMD_HEAD_OFFSET);
> +	tail = readl(iommu->mmio_base + MMIO_CMD_TAIL_OFFSET);
> +
> +	pr_err("CMD Buffer head=%d tail=%d\n", (int)(MMIO_CMD_BUFFER_HEAD(head)),
> +	       (int)(MMIO_CMD_BUFFER_TAIL(tail)));
> +
> +	for (i = 0; i < CMD_BUFFER_ENTRIES; i++) {
> +		cmd = (struct iommu_cmd *)(iommu->cmd_buf + i * sizeof(*cmd));
> +		pr_err("%3d: %08x %08x %08x %08x\n", i, cmd->data[0], cmd->data[1], cmd->data[2],
> +		       cmd->data[3]);
> +	}
> +}
> +
> +

Remove extra line.

Best,
Ankit

>  static int wait_on_sem(struct amd_iommu *iommu, u64 data)
>  {
>  	int i = 0;
> @@ -1166,7 +1185,14 @@ static int wait_on_sem(struct amd_iommu *iommu, u64 data)
>  	}
>  
>  	if (i == LOOP_TIMEOUT) {
> -		pr_alert("Completion-Wait loop timed out\n");
> +
> +		pr_alert("IOMMU %04x:%02x:%02x.%01x: Completion-Wait loop timed out\n",
> +			 iommu->pci_seg->id, PCI_BUS_NUM(iommu->devid),
> +			 PCI_SLOT(iommu->devid), PCI_FUNC(iommu->devid));
> +
> +		if (amd_iommu_dump)
> +			DO_ONCE_LITE(dump_command_buffer, iommu);
> +
>  		return -EIO;
>  	}
>  
> -- 
> 2.25.1
> 
