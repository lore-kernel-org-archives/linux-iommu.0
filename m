Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012016.outbound.protection.outlook.com [52.101.53.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CAD36DA03
	for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 17:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785086405; cv=fail; b=Wt7RweDLUWa40hDJBdfycWRVBKnMhvtUw+EtlhytLW79B2oMrQF/kwVPtFCpCPI4W+1ekCfuFGY5BQpCI7Gy8+y12LXZPP7Hz/vRK2/M65SR68YplVZ3ME27aQmCST2l5dLX96TXlFjwxwiJwrVKIaGwcReNJBdelZY3P5FfaNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785086405; c=relaxed/simple;
	bh=8oOmnHGW1J8J0MXWLE5gDpxEfUyuNakdb1msjwyKCGs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTYPr87YEqXWFFalQoYXb2pQaRnxvl9Le5fozKxnj6QspLhBXsovQwZthgCJ9DRUnHVMkG0PRRyxYmmXlCNYw3c0irEaFNuWiLdXXAojTVwTIenobgosHQzrBA3PLIlcSAOvaPYzP4xSZYizWYd6puA+WmVUO1yaPYGX3NHQSzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZuWWPnRQ; arc=fail smtp.client-ip=52.101.53.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZuWWPnRQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RFOydrvHXW56FE1iFSLd36mWogs3sYWJvdCHb1DT2c1zuJirj/c1J4iYT7rWxLwK3GgWDPrtSyQmbAxiEZy26K4aC5MxkTf1QYhQ29fTPIcKw58P124CTI0j3kMid3ljTLriz1fqMshAu7DWhb7hbhkI31usHmz8ZYi+F4HRLnvwABT6gpxB0kX2OyGraksWYzw812ytyDLtuNhifCpaa+HxVEg2R2lyDNZV50zTywWZy+L5S1V/TfgLsrt83Ncc54tXtiyW9ljnkxYpLtCFKxU4uHD6kGorzO8MG19ZwCF+CGu9a6SGUjWkb6sg9CVib9EBDw9YJSkdakoV5aUGgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aIEX23kjadTe/5txJIx3jZERgl8Gi5UenD30cwicvVc=;
 b=fy5QO3qbU2Qr/3eTVJuni2nCsTdThgjwTN77eULXpUEz5Wgn74AJNRp5sv2F6kQLdfGwMSghVpmxou8TlT8UyzZTA0mZLDZQDW22ROSXF7Z7p0x3B5Z8lE6XYJsdtS9CtxpiWEmRy3P9dGLPUFYfaCmyKoxaxg5i2Tz2y2HKzJxgqOEaO0f7ZRa5HR0c1bDoc30WfdxjtFjq1N1JW1szqnzvMHYxaLTtMtKGPhOxkj+V2JTP8+rlhSwJGCslrBjOoudTbXUk8fdotBfKZkkyk0Ze66lSddMMWd4zx+NoTHL9QE7O/qwp5QCeC6ILnvpQTuQ9+sgfcKA7S0C1KSnr0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aIEX23kjadTe/5txJIx3jZERgl8Gi5UenD30cwicvVc=;
 b=ZuWWPnRQHDg378qXSRvId5F17zepYXIP7X+xF1D31Y0Y++mC2Lj/EzSUZVRrf6JDDJ6XKhgdMlO6BROvacTRlPNwQVgSZKEBuwN+RJIJlzSjhyaGqSK74KLteTy1dmC9ZwpCd2ft/rxJucPoYs7mUjxNBuli6jYC8UXkK3Bxw7dL4YTUiViYZt9N0D9zcR167bi29NeHvacfCtguwOUkwjMJqJIRnIxokjKaGgc20lEQz50UEeacRYnQpY2o0SqXCmiDpYR1sdYOEmbcFGMkg/4GJgsMqy2YAv4GdNps5HmqfWSY0RVE0j7dNHxfqeSVUlqDrrEfVJPfAijgHMayvg==
Received: from PH8P220CA0028.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::6)
 by IA1PR12MB6020.namprd12.prod.outlook.com (2603:10b6:208:3d4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Sun, 26 Jul
 2026 17:19:59 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:510:348:cafe::46) by PH8P220CA0028.outlook.office365.com
 (2603:10b6:510:348::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Sun,
 26 Jul 2026 17:19:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Sun, 26 Jul 2026 17:19:58 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 26 Jul
 2026 10:19:46 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 26 Jul
 2026 10:19:46 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 26 Jul 2026 10:19:45 -0700
Date: Sun, 26 Jul 2026 10:19:43 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Ashish Mhetre <amhetre@nvidia.com>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <corbet@lwn.net>,
	<skhan@linuxfoundation.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@ziepe.ca>, <linux-arm-kernel@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v9 3/4] iommu/arm-smmu-v3-iommufd: Report
 CFGI/TLBI-repeat erratum
Message-ID: <amZBr9/0sbc8Quu0@nvidia.com>
References: <20260726081904.1408859-1-amhetre@nvidia.com>
 <20260726081904.1408859-4-amhetre@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260726081904.1408859-4-amhetre@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|IA1PR12MB6020:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f4d9d9e-ea13-4ed4-6129-08deeb3a1e79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700016|23010399003|6133799003|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	ViBsd1cADbd/jQ/GvfzlorbUn5QnTZzyXmBlXhzvIB1RdkMW0FuBQX0z7XohiI34BlEQf6virvjC7qbP2vEdzgEXXXuz3bbMD3zYy/zlqg34Zr+OR8j9Ai8AxCwHHozCn3U8MbFGL61wEoaZBIdeGmKWx6tQSoY0Bb7iy33znNjIf7nySTAoYD9KAOc7nfiusNprjfIzTcP+XmUVzcoU4OKnjlDIn2bj8nkCxh0NZBV/JnFDxCeoujeBTeUsFYNAEh6nfijQcA+tDVbLKCTMKl8CmWnvGA8xKFCAW6jvzggNskwPt9IB1pSs5m8WeTd6xvIBCiAu/kamuN7ti+YuVj/34lTwNAHy8fdjqE/UMF4QSH4qnPIzfa/VelIlfmJy2gwbrSamqz7Suj0Y36C67qdZjhxu5suCbECD5CrIW7J+mWYwEbZav2A7k6of5wHiEUzElFsES7p8LBwL4wz0ZH47YEzOfYZrMlV1HRiUy86wFptpKPhYq3EVrRfwjzjUiEjtVnQGB+UYQf2mOQfcB3yv7Fge/WAeUzgvM8p0hXUvmYgkpjNduMUh/yzugOxi+q08MpocMeQKQwKV8kAZb8Rnw5ozTK3b0uA23gDjrxAfsDM+KbXTS3u53NTf2wu/7weOATLCCdFtMqu9mMXbtiz+qsDyVpZthzrjSfzZt2qJnYUfCFaxKlmUc0FQD7JTPrbZ52wxuToXLq9vRetGUA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(6133799003)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0Tz0Vk/bCYDRaEEv+NDtahjYNx5kIT4a3zQH3sijnTvouFsOevprwLrVi1YpZJcJg35Zt2lDHQPdmJz6C83gMhB7mStdSd9iHRH5LNsWG1qnGvJJJ8L1Abmh/7PTq8qVT4QEzlAHlfxNni5fnJJ1cITwaSaauwPbu7Cc4d5isaJeJbBb2oYNd3JmH/fE6JW90nDA+4eGjt2kYMXQQOGEOWz2L5KgVhOUN8XiUazj2Ds6hQd3ApiSDsWeUJoqDDEvvXSHCDs4JlJOcn4uNJEZh3ugyNiOVDA8XjGom6N6QkkUvq5AWQ4/2tKQU8U6s5c8V43h2rh/ixRNC2/CNAo6LCJIRpbNshWdkjtIqrNap7i/aEnRTGdW1Yhmc1y03o5uVnr7oetJDl2/CviNPpjx16YlEwlF97CofsCeTY6LnW8iJacO1sPbXYcoaaK3/gOq
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2026 17:19:58.3663
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f4d9d9e-ea13-4ed4-6129-08deeb3a1e79
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6020

On Sun, Jul 26, 2026 at 08:19:03AM +0000, Ashish Mhetre wrote:
> A guest with access to VCMDQ generates its own invalidation commands
> and must apply any invalidation errata before submitting them. If the
> host also repeats those commands, each affected invalidation is issued
> four times instead of twice.
> 
> Add IOMMU_HW_INFO_ARM_SMMUV3_ERRATA_REPEAT_TLBI_CFGI to report the
> CFGI/TLBI-repeat erratum to user space. This allows the VMM to expose
> the erratum to the guest or apply the workaround itself.
> 
> Use the raw __arm_smmu_cmdq_issue_cmdlist() helper for user-provided
> invalidations so the host does not apply the workaround a second time.
> Add arm_smmu_erratum_repeat_tlbi_cfgi() to query the static key when
> populating the SMMUv3 hardware information.
> 
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
