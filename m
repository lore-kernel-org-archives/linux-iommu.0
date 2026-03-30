Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011049.outbound.protection.outlook.com [52.101.62.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7256C277C9D
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 11:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774869988; cv=fail; b=YCduw8v3e8F7O43QgQMgCmiHcolyou/0F9EmjTErmLd0xyj/iFMYiloCdbXyTA+i0JZgIU3t1lPVdXJwXfvk+qWB5PvSK2nyqpdzye26Q/kK1uWhYlv9T9lFY4tqk0H7qOGx/I6Q8qKKZ96O0yDKosdTc4MKeRiQEpj+DtDapBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774869988; c=relaxed/simple;
	bh=hwRAncm6+I8sEW11e1MQ5eKhmZsuCQiVfJVmAiIOTg4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RnES+XsRYQ7Ipdc73e51Gu2hMOg03xOdSBcignx9ov66UezskOlmDYr/DyJ07WOWUMoCoq4PO+qCsPkDseHYTXVV4rVH+utvOIMUjmQ4HEfTBm2tofV+128ILCae2r5VHJYZSi1eKUiRjgtLFQkbpzEg1IC6EOiZ5oYa4WubOT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r6k6sgvH; arc=fail smtp.client-ip=52.101.62.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r6k6sgvH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P26m6SNSgDqiNpqck9qdK8/B7es0keSWAxFwqWLR+C//3OV7+G7GSrC5l3wMbcZL+lo0ugF+N9s1XrYwSoi/WkKQvHTWHchKxvWKX4AgefagcEiZ6hhaojA4AOixvbwfgDfvPy8CXsp3AncWvT30c4MyBYcgb6/RnXwIl4/41KNp/NWm4OdEKSni3FouoVRsOYLcOn+2cOdS0OKW4fQPkhcRp3wi30ODunaqsUsPz9eaxKx0QkXtRg2z+7Fj64OfV8118PGLFxU32AmnuPyFoKPxm+LHTDKo9DVXK0CzjKN1dTdCEokQWmzQ4OQFtN+ww3u9hJUF1agyoM/aZr5Wzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ypcS/TE1MXd0BXokJ8aYPxWhHFlU1Zs/rsG9WN/9mcs=;
 b=e2bGnriTjDedhl6tE6Yiqdxpvt+SqOPS0nwyDyjdkNx1af/O0fg+ASqbBCik7ohGBb0e+uN+HqYY3r/CV5jn7GYzZK+iGyiNcJu+tJx8NsDM+VTzRYzfRnaSiF9eQOBCYusTKNLmcphceuSq5K/TNSy+2sRp9lSlEJtSzNoIIkJAFBH3fKawu37dckHGlKm/Ftqt4ZKfwNAwVRnwqc1mUa52qLa0OV5Va3X4FqcAVlwcpRVQKfW+9tNCAnQOw8jP8WgU1sEZN9Po6FgvepAHhNAGcYX8/QJyHqktvKrdT22nurw2IEMATywNQHqzzLnJzJ2ugpL5IG/QFJNZ/cpMnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypcS/TE1MXd0BXokJ8aYPxWhHFlU1Zs/rsG9WN/9mcs=;
 b=r6k6sgvH4q7xD0UyO0k8gYheNB6qoISW5EJJ9Ot+mSZU0xJB1l7LegycQ2dH4XKEY+g1Ip1B5MEji22tkOsoOjJEA0tHgWVjxtokren/YEyilAq0x6QpdLmtp48TfcbSnqgIvMIxkeALEHFoquhbXd6Oagh3ZYRcHeYPWaOvnD5Fkc2FftN8vrWXE3MAb8Xi/ceOi2zc/z09F4kQ7rAbIz4jH+VvFTWuiOX5VMqVZbOoFRuTM9tEGo1YwpW/txGFNAHy+00zHDL5LZu+qENbtIjcsrf0kD6wp09XgUTOuldvs/WU/vjRzBeYX/5/iFknRtDyESaV9GjAKE5ltu+IJQ==
Received: from CYZPR14CA0034.namprd14.prod.outlook.com (2603:10b6:930:a0::19)
 by BY5PR12MB4178.namprd12.prod.outlook.com (2603:10b6:a03:20e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 11:26:23 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:930:a0:cafe::fa) by CYZPR14CA0034.outlook.office365.com
 (2603:10b6:930:a0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 11:26:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 11:26:21 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 04:26:06 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 04:26:03 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 30 Mar 2026 04:25:59 -0700
Date: Mon, 30 Mar 2026 04:25:57 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Qinxin Xia <xiaqinxin@huawei.com>
CC: <robin.murphy@arm.com>, <will@kernel.org>, <jpb@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<wangzhou1@hisilicon.com>, <prime.zeng@hisilicon.com>,
	<fanghao11@huawei.com>, <jonathan.cameron@huawei.com>,
	<wuyifan50@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [RFC PATCH v2 2/5] iommu/arm-smmu-v3: Add register display to
 debugfs
Message-ID: <acpdxdjFQl1V0b5k@nvidia.com>
References: <20260328101706.3448655-1-xiaqinxin@huawei.com>
 <20260328101706.3448655-3-xiaqinxin@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260328101706.3448655-3-xiaqinxin@huawei.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|BY5PR12MB4178:EE_
X-MS-Office365-Filtering-Correlation-Id: 790ab2a4-b729-4915-4b4b-08de8e4f2ba0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|7416014|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	lxapYNx1jIcCk16galpgKmTdl2iIK7DjKTpo6ZuvREt5vH8m9MVj57/PcuCC/7Wmr/RUBFM5zCZV78HUnGy5zLPHwc23kVtm7FocQwpGZK1yg5CMyb7MC5sKNyPz90m7lVksoIv28YElq5KPiIGhxvHgWEWh3mAqvzclh6VtxjfJnfTwQ5A25Ma6WOIqXjhFEitBZT8gjqBjMRRFWEDX2s+Q1iGLc3xFJmD1H+X4VDWyMTnWXSDogkkEXLvvMkeaKCs5+TNgh9Ma0GunoNZZA3jyu6HcXI4flEn4crSjbP8ngDEjDVeffpnPw3iMMdmSRmAb/+4oNBGeCjst8pnfp4W2r6rPtwmCrPMsM0fy6KeIyn+k+HdTVpRUBpeYfcNmuOdPlJ43Q01SHLPxCCPU6OnrLcm0Fx29cHYwAxuYOwE7gYS18a18a2b7uyHDZnQg4z4j5ksmEiH8hOK037aC0mY2Hv0VutbNUg9S/d6XAkvoMDEZp40WtDiBnyQnTFWS5JjkoJc3YI6m4gj6uSo1XUHVF9HBrB2UugBNhlFw7H/YeGsKtrOAbzd84jELhWOprUHMH+4SG8nnU7Y6m4jaYn/GvNICOfEA1uR/R/txBsYVXNftyaTMG8/b4chGujkfo7cVeAlFgwMTDoCIa22vUwDRiCbPlYK4HuV0HwW5rgIClQJ+13W+6PIg47NHvS1e7QnqhSqSO+55WalNdH6WTJCDTa62a4FAPzpRKcptJvkRUQnWgTfHUCE9foZofBDBKHXXfr8BRKK+1KIuuUyY8Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(7416014)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OTmmrR2hTxbgTS7N0RS1cDgtxG/0AaiMPURoO9pMb4apG3bpMHVY8oWe6aiCXbvZJD9VZnuV/WyLP/+Vm7Rqf4Tkwtzp6QHnk3h0SzpowFuvKo0fS1CnO4OXAPuasczKwnxH0Yz8Udbr0kP0sIui1teLBNviu+UPeWteeXeNFYsP9hSWdSh7Yz89gDf3PT0N3rp95hR7Qs49HVzoVVRnr2Z069KAZ0mlEebH3rJl0DmnIDGQCZqK923SKYEbrM5r9V6+EzBkwVAMs9bP5z2/w18ruB1IoaiiHomo3oX2vDvK48ceuL9zVI8s7pQ77+r1BGtTibDE6h/kfYTQ4yJFYm6oe3S4G5pyzT47BgYlxzzsB4VIraSU4fR/vcYfwsJeZQIGbzUVLj2EFFrhS99oYqKR0/GL49KOwvX5uhCm7HvT9S7qHmBerKP0irSekyUR
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 11:26:21.7985
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 790ab2a4-b729-4915-4b4b-08de8e4f2ba0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4178

On Sat, Mar 28, 2026 at 06:17:03PM +0800, Qinxin Xia wrote:
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c
> @@ -5,13 +5,18 @@
>   * Directory Structure:
>   * /sys/kernel/debug/iommu/arm_smmu_v3/
>   * └── smmu<ioaddr>/
> - *     └── capabilities    # SMMU feature capabilities and configuration

Nit: perhaps the last line in every patch could start with '|-',
so we wouldn't need to update it every time.

> + *     ├── capabilities    # SMMU feature capabilities and configuration
> + *     └── registers	   # SMMU Key registers

Maybe replace '\t' with whitespaces? The final file doesn't seem
to have this line properly aligned with others also.

Nicolin
