Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793393828;
	b=A6+qVfcJcC4t6+bhAWEEAvAwyArOtx908DHMOv20E1fs71MBz1LBpfWBJ0NWXoutGaQZ
	 uSvCiceVSRmR230B2WFRq26ZRpDZkPNkl7n1vA4K9qHscP1Je2eovmVZlZykEYD95G9Vr
	 +cXcZEKDA+hL0dfkNot4fkG1UeQPNjjTr4lbhOVUL4K+pOPwexHfU909maRzD4QE5vQqn
	 uzMaCq7PjE8moiG0RwzEQoT5TGRa/SIxMmM08oyC0uEjvl6oeVO/79ztN09OKQ1X6bEkv
	 ouoRw0fKXFbgIcCuZHsHxWzwik9NRqZCik1Hv2DbmOsOSv6uZtMM879c3fIW34NHvJA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793393828;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Date:From:To:CC:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-NV-OnPremToCloud:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=pkXhAAFxdrywU3msLORhtm+R/KgsTgeImnWjlCDw1W4=;
	b=siBuh7i0OXUDhvJcuhQb6NhpYnxMWn6W7viw1whodhunZhIRCW0t2DQ3SWWPO2+nf09p
	 K443vd8Je/rDBmCoxPAsJBwVOMXlIj1lrIiw37zwUtZaQIRCe1lFS1GsxKpY/HdQQMYEp
	 QphCXdhB+Mbq22UHtuyT7FxcQhU6qPRbHjYyflenSRu4IGwBn7tKtEs+zP6GbRntGN+7c
	 c2LQRRnYOiJPvTgTZAEB6mSRTIaJlF8y135Qm0qOSh1JTpLTw5twSj1vllnEImoC4qfBr
	 PUSG5Zc4ikZZQj/n5XtU9ZDbT65DFXyUm4SAp1SiwS6TbXu67uT924B8AX7dRaI6irA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=YjamefHb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.31
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011031.outbound.protection.outlook.com [40.93.194.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C8D606A31C
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 20:57:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6C8D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=YjamefHb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vHvLLKGQDNA4LUZvunT18Rfwmg5qJlUAvpnokBVtgi7PJ+6KGbXvux0QlCCgpzoaAhf4bYdgoni4PVKJinpJL7tmZ7TrRJRjg93AIyd+YD/EgUeOZRlx6u8XXdPUwEjVjtR9BpsWNFIZUCpPBqmHTtYCkjl7RKolkKPD1gwJsamVfzd6f1XV7SqRSmwIklj6zRYze0JpKWzWn6czxnpcZDQ766dy0jNvVKWCpqo6cbyVX1NudPPzs7rqGeUAyMqEimURp7wvkBsU4PDU4xmXz+novzA47YkIYbaCQC+65Qqi3qYcBr7oc9QqPknxZIjv5rAUs3wRFrpuOGJL7k3MQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkXhAAFxdrywU3msLORhtm+R/KgsTgeImnWjlCDw1W4=;
 b=fDpnOitGb7MFCpmaDp1+89g4fq6T08xr1V2EQ9n/JKyUIBJoAMclRWVrgGwIDNmQysl924vCBNH8S9hb2tlA6QQxf/Td8ai3B1eOcR8wrugUald3ZnsPG77yKWZ7jiDlU+y5VKDUZxA8ZbS3nE4cFJ39gRPHL4UiYa8BZzNX0HS+ZVXWVHXTkKTCTDcqwDiWzrtgZkYv+nDCC1RHI3PdZq2rfLdEbWw6izUf/ivEMex1nm7fmyzKkSHSW1OmFunWapKrv+zXWQgDBqZkaAUKtfkTHtYpk/yEQfyH9KOhTm9YV9c28nW9tNoiVKicaSORPJoWQ2BQ5pzNkREPqy84Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=oss.nxp.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkXhAAFxdrywU3msLORhtm+R/KgsTgeImnWjlCDw1W4=;
 b=YjamefHbkzg7DwXPDDWLY2TlPF3i5n3hfi1+S3Cj3BR9hAbsWQCEUor3ukAVuK1WV1pwWXB+XWR4u+NR9U4dfha1r8kf6i+/FGv3AjxtdD+fXNt9c5lcZpIi2DbZRisXAvYuK69jdDKNrUrF/892o/DybIdplInySqthklYLRopV75bDzVE6l8W/xQpaIHwSjdzZ+h47Xupg6GbsJY+kAtBeYFMUAVxQYHr0VJwVWu21cHLl2LOMM5d2tFyUgt0nZ4eYEP20I6F5O+rOlc4cSSINcFjQaoUUvGyiwO3ul8tVfwu8zMMstf8t0n3P+k3SYnbO8QjNpW0wU3RTUlOKag==
Received: from CY5PR14CA0011.namprd14.prod.outlook.com (2603:10b6:930:2::20)
 by MW4PR12MB7213.namprd12.prod.outlook.com (2603:10b6:303:22a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Fri, 30 Oct
 2026 20:55:13 +0000
Received: from CY8PEPF00000056.namprd05.prod.outlook.com
 (2603:10b6:930:2:cafe::53) by CY5PR14CA0011.outlook.office365.com
 (2603:10b6:930:2::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.10 via Frontend Transport; Fri,
 30 Oct 2026 20:55:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY8PEPF00000056.mail.protection.outlook.com (10.167.247.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Fri, 30 Oct 2026 20:55:13 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 30 Oct
 2026 13:54:57 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 30 Oct
 2026 13:54:57 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Fri, 30 Oct 2026 13:54:55 -0700
Date: Fri, 30 Oct 2026 13:54:52 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Joerg Roedel (AMD)" <joro@8bytes.org>, "Thierry
 Reding" <thierry.reding@kernel.org>, Krishna Reddy <vdumpa@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, Jean-Philippe Brucker
	<jpb@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH RFC v7 3/7] iommu/arm-smmu-v3: Plumb the CD table into
 the CD helpers
Message-ID: <auUEHLb8kCUUMoAG@nvidia.com>
References: <20261030-smmu-shared-sid-ver7-2026-10-26-v7-0-961726ebd6ab@Example.Com>
 <20261030-smmu-shared-sid-ver7-2026-10-26-v7-3-961726ebd6ab@Example.Com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261030-smmu-shared-sid-ver7-2026-10-26-v7-3-961726ebd6ab@Example.Com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PEPF00000056:EE_|MW4PR12MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: da94ae3a-2509-4944-87d9-08df36c81807
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|23010399003|7416014|82310400026|261026121527099003|11063799006|4143699003|56012099006|261021135927099003|261009223027099003|261022105027099003|10067099003|18002099003|22082099003|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	H8SFPcWKkHLORr3vvw8FM98AmrJmlmjdEKqX/HR4Z9/dv0tJBt4dYVSZiutK5c0Zcy0F9wU+5nsVP9597jmGu/m9qUBXF8YC3nBAg7POIBBd4WXcRA32WvuOyC+e6yMotHbKqrYt5mMzjEf6slCHD8rBU04+xwIuqB6BkioOqjIe59M8jRJ64VGyWIiLJ4ZpB74dUK8qKVcorLKjThKWcuXWKEQeRkKT+9xAJ6POIf0HmK9bc3tfbJI1sF6XFedHJ4Hd0w0geFwV+SiFGnt6jGHFyRoNrRBF35QIWli82J4/rbGRIKTKtJyGPsFbmOrk9udTeGOgCBk+6AlW9PcBZ4MOozfc1jUekjKl5Y4JyFZYysUmoDZVb/EIapRRPNNdtTOhcKRDMnSJE3iVBLheiawh1NyzIUF8/4zplI9faBuujpihIZowvtBXpESfu0N5VUcUd6csNudu7JwNU0DYyydxlKvFeOxL+rvb2l+JZAUoNYCJx0gVXIq88Cn10CwPdgfognFgz1hfQ/7uRMRO5HQNi/6WTv2FZUnuqKsQWCl3VSBwWXzJ6pnFAxRzK7TQ8+kvjmXOymFh5ZOTWiZmqz+wwCmKw3V+gAXYmljzVYVZFZ56L0Ept5BY9vC4d9mSF0E7VYfuvZtdNznF55Fkis/a0vpsnwv4tjF8Ok/ell9aZB5xXs1UlSuy4fARvqVryIUH+oPH2FhYlgjwrWsk1w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(7416014)(82310400026)(261026121527099003)(11063799006)(4143699003)(56012099006)(261021135927099003)(261009223027099003)(261022105027099003)(10067099003)(18002099003)(22082099003)(261028144727099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IhgB8LUBCS5oBtMfq3IuYRzkbq+0W+QIVgkTsA8KcPYsRGkm0w0ZqquFowPwMSjG/KBbGsiC/XqeDFH+NgKD+JeH+CX7AzhQ+GYmWLQWjR/pQHN0G1N3Ovkug+bRKhdQKbEQchP9T0At5CStURvnZvsEPlWl4PTsfHcjsAeUbKL2EJoZFR6hnTIoo7tTvMkhb+KqrfqCx9nd9oWoG400hgsqxfu/SgXBn5kC+X9p8HsIdss4VNdAQdO99h8gfTtEv0RNukGRCvGRqjQnbxqKpOn2olg0Rk6Tpo1KbAq/0t2PDypauFnER6ohCGHW8rcOPSOdDYSdpAb57bD0NzWgjBFiKMQRIcRYVwjXHDN94LpQm9AY2VSNF/iV1LJejFQbdDvEbXyjI8Q/JQpZmZIw6UzgpiTLJwS8YKDFZzkJYgjBh9VBdu4NgKOPkXmd0RHE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 20:55:13.3464
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da94ae3a-2509-4944-87d9-08df36c81807
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY8PEPF00000056.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7213

On Fri, Oct 30, 2026 at 08:09:35PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Refactor the CD table allocation, freeing, lookup and STE-building helpers
> to take a struct arm_smmu_ctx_desc_cfg pointer instead of always deriving
> it from struct arm_smmu_master. Add master wrappers so existing callers
> keep the same behaviour.
> 
> Prepare for domain-owned CD tables, where non-PASID streams will point
> their STE at a CD table stored in the IOMMU domain rather than in the
> master.
> 
> No functional change.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

With some nits:

> -struct arm_smmu_cd *arm_smmu_get_cd_ptr(struct arm_smmu_master *master,
> -					u32 ssid)
> +static struct arm_smmu_cd *
> +arm_smmu_get_cd_ptr_in(struct arm_smmu_ctx_desc_cfg *cd_table, u32 ssid)

Just keep "arm_smmu_get_cd_ptr", and change master to cd_table.

> +struct arm_smmu_cd *arm_smmu_get_cd_ptr(struct arm_smmu_master *master,
> +					u32 ssid)

arm_smmu_master_get_cd_ptr

> +static int arm_smmu_alloc_master_cd_tables(struct arm_smmu_master *master)

arm_smmu_master_alloc_cd_tables

And in the other patch:
arm_smmu_domain_alloc_cd_tables

> +static void arm_smmu_free_master_cd_tables(struct arm_smmu_master *master)

arm_smmu_master_free_cd_tables

> +{
> +	arm_smmu_free_cd_tables(master->smmu, &master->cd_table);
> +}

Maybe fold in the condition.

	if (arm_smmu_cdtab_allocated(&master->cd_table))
		arm_smmu_free_cd_tables(master->smmu, &master->cd_table);

Nicolin
