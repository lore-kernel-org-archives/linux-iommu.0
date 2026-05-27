Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011003.outbound.protection.outlook.com [40.107.208.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E3A224B05
	for <iommu@lists.linux.dev>; Wed, 27 May 2026 02:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779849665; cv=fail; b=GwlFFBA9TCvRoLzPVKTiqbK96PfjBT9t0oFpa1bZeyzcv4jc5JZ/JS/e2PdQ5PrgJ+1H1ewGq+HPnKDFOIVn4josgfpFhC/Ynu5/VV0sNTPDcjDEQ8pLrd5Z0JKZVqaz9CIHxqXILeXG1G3mA6M1jiFhLsK3z3NNdjwwXgqDn8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779849665; c=relaxed/simple;
	bh=15m/pTiybAyenAsXpovoPddGpoqRymqDXNcA+tQSXDA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G6nX8Hcoi5pzqCCAYY4ROKM97XFvDyaerEQAMenAk2OqzY7KsYXwez+DhhkNUDWo6t+Yh4GrqyINueRxi2GhoYrWeu8AAaF4Cm8SO7vYA7RjWG86C1PAf2utHbXpSm7UdSe38uE8mjkh+ybt5M4arrDTW0poE2dvPRHPXDS/SzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RqEtPtr3; arc=fail smtp.client-ip=40.107.208.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RqEtPtr3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zml/9wiiexDQaVV+/4aOJDhljj3I0muuFbA6xHrzpW8vgjAEsz5vVf5y/H9wm5/Fx4IbcT2Ac2TW1JT9Y1iXHMarDh6UXCSr6KtUwvBjI1mOb+mFKMSN66d2ppkKj4KElLFayFXUbVM8YUrQH5+BK8zxEVi1p5i4os1SA2rYBAVBIgqHNqU+XoTphj1ok03ivnkI5u0LuhmQuG7bl4UU6pLBp3awjGIiv8CosclaHbCxsw9Mr0Ws2hF38PJzZwFXiKTSP3VoZPeorWJNb9/H1Xc0aCQgFngWkgVwzpm8RHtvnAnXsDMinPT7qzCH5u25I/xN5Kmjz7KOkw2hf3jtXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZzBqMSx1o8TRFdsCqVPcptv1wrHvd61VkooOhlTvBQ=;
 b=fHK1E76vDEx28pTY+gsceW6rRu32PphpQ/iI4TtPoGQhUgPN3OP752DShULkLFllFsTZ7Nus+PsbbDaE3EeHuiu1DSNBL3JWrvnHVNuG+MkmCRa6Lb+pKPjRFa6s5nt4Vx2mX21S2Y2pzg3qBdA9rXLKGZn/+ISKM/h/bU1Face8tTVmc9bBC9d8QIo6tPlDt+QNUR0SzAX38tLIUEo6tSVuP0yv0N94fyz+AYUoMn9VO+LUvC19ZOjvnS2kmJazvgVy9TqPdDwnUzh1RZ8xI+WMrVPN2Xz/zVdG5r6l377PspVzPVZG345BqKon0cVF+hdW0yHNOl906BuyJe3Ltw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZzBqMSx1o8TRFdsCqVPcptv1wrHvd61VkooOhlTvBQ=;
 b=RqEtPtr38+TAN560ov7IHx+uuYF5LC9cq1Tb8kmPB1HlErVzfBSbw/wv/cmYOB+3oEKN0zwiBTJGQdxU/rGPLBACkmjezDe3hqu4qWqbr0WKnN7EWZdYzwIgFSpdRLW9xjFjifh1ux0OLfqOdEJwzKqXrEzFQY9+FuRQvLObmNpmeOw2WyT8wdVUWqaGw6UpYOKXc5gvLtpHel1/6aI3lF+2qCIK3btssus7qpxOVY7mDsY8bBBfq93ubIHAg/iqCKeoxwct3SRSNOdRjpDae0RYlgNX6YOd52h13P7zl18gl8oR/p6fYNJSgn2ZN6lL/3ayZHyb17QKhaypnlfC9w==
Received: from CH2PR02CA0022.namprd02.prod.outlook.com (2603:10b6:610:4e::32)
 by PH7PR12MB6540.namprd12.prod.outlook.com (2603:10b6:510:213::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 27 May
 2026 02:40:57 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::30) by CH2PR02CA0022.outlook.office365.com
 (2603:10b6:610:4e::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Wed, 27
 May 2026 02:40:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 02:40:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 26 May
 2026 19:40:36 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 26 May
 2026 19:40:35 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 26 May 2026 19:40:34 -0700
Date: Tue, 26 May 2026 19:40:33 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Qinxin Xia <xiaqinxin@huawei.com>
CC: <robin.murphy@arm.com>, <will@kernel.org>, <jpb@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<wangzhou1@hisilicon.com>, <prime.zeng@hisilicon.com>,
	<fanghao11@huawei.com>, <jonathan.cameron@huawei.com>,
	<wuyifan50@huawei.com>, <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] iommu/arm-smmu-v3: Add Context Descriptor display to
 debugfs
Message-ID: <ahZZoT3tIP9jfp1d@Asurada-Nvidia>
References: <20260328101706.3448655-1-xiaqinxin@huawei.com>
 <20260520063714.2440584-5-xiaqinxin@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260520063714.2440584-5-xiaqinxin@huawei.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|PH7PR12MB6540:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fcd523d-030f-4976-ac29-08debb996066
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|7416014|4143699003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	JqN4+eHbMptEmwfmWjqoyiof+dk+aJ6noqluGwJS8Wrb+pBHBb7HzN6ksOcrrz2OqqXZI57iz4fQEwPPTuk2CXTG0Rttfyxs5+fTn1/lCr/QGhAY/MaHHoD8MfwzhNn5qzjl9BSM+v1anLF6a5VQy1/gWvuAB4MII6Cbnm0acSxkl697GFARL+sDp4cR9smeipsgZxySn4owmC5QrsPUkBRJjnkJU+83b+dhacsXNSEPWPFEktk/zF0K0z+NDKkrg6YDeTNE/F4YlxTxXUwoj5BG1cCwaGv8NjJAkPu0c+BfdS1I4uAIE15X+i2Pl2Frvpydf9QSgGp311gkuZsiz7NKB5kOY9gfHtdRMqzOO2Y6co+ruxnAMe8rNt2UxJl+wGBvhlZUYKF6nB68hpeJCVoD1uE5Lb/nzKcJUsrYYx+D6CMaP7VW50zXc9fj1NH8wMJRN8eQkCWxOW31kGQfAz+QQRPn47cp1TEL7J7ytTWIFQdBG62KrdvGrdYNrNRgZvgYC1n6WYrX4ocK/XCM1F61mxjsLM6A3qMorU+A/hjdVAqgiSf4kdjxSpf7PenJYNMehgnYoHW7IlvgaBz3Ds5EJsQHhHsyjkr8tPQDyKUZsK+luLnwjArrB/TtoZjgioUCG1yc3pZJXSWPyu23RwIhVXCnuxy3ma3umdwkJLuFUjNG2L1k8UCerRAzeBFEYo9SgoTIEw2wF+xXmoBJVBmtO3/xHRpQaDLrB6jYDB4=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(7416014)(4143699003)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	v+q93Z/l+kxqR/JXIBFul5idU4f8id2hANXDIvWJCOnyu0dC+vBs5JigrybMLzlH1lnr/MwLlQknpsQrSz4wkU/EMY4N02tprI73i+88IbeBALQm+4LQCpKAxK7/NihtbPdKBppYYFU6hulB4v9aqIepHkBMe+DcJGy16EGyTEGqqNc6iIdPVjQ5tx0pF0DdRnK4tZ431CHRjQjQ1UICdavjnIM6uSWZQY1CEQ6vM7ggJHhNw8fOeNwuWlLaiaEUjsYX8tXo4LEu7ZaEaRULzG7bEcGnamj13/CLZeZOvDutwCAfZM8LaHg/4wpshPQYhKE4NQ3q3etbExmLxWAw2hoTTYrDOSiaFp+Bz8zcqL0+zap4MhYYZbQcjGTn2XgJ7qDprf7Wait0NrVXeeD+q0Nwl40wMw93dJYv79bLw3k2iKFT7ckhby6nWGiMrqT+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 02:40:55.3297
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fcd523d-030f-4976-ac29-08debb996066
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6540

On Wed, May 20, 2026 at 02:37:11PM +0800, Qinxin Xia wrote:
> +static int smmu_debugfs_cd_show(struct seq_file *seq, void *unused)
> +{
> +	struct device *dev = seq->private;
> +	struct arm_smmu_master *master;
> +	u32 max_ssids, ssid;
> +
> +	guard(mutex)(&arm_smmu_asid_lock);
> +
> +	master = dev_iommu_priv_get(dev);
> +	if (!master) {
> +		seq_puts(seq, "No master data\n");
> +		return 0;
> +	}

arm_smmu_asid_lock fences against domain attachments, required
by CD (yes). But, it doesn't fence against a device unplug. So
this might need both streams_mutex and asid_lock.

Nicolin
