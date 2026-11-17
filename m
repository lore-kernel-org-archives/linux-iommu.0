Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794932350;
	b=xjcLyC5UUUVOaU9YIE5TgqH9+YCGlfPB6OSC9cWa+d5V7BQFk7gA9D/lHxKe1i8I6znK
	 y/X9WETS4zn7rWyIpqszXH1uNBfVEQeZ/ywo5plZxx8qWcjUFQX9PujGTJbfrSdcdRkz5
	 a96g2XlsZ7HZr/NbM4VxZsYIB0cTSpaTehqkwK4eC3bFdbk9Z63UXBGTaO3uPsk82OpkT
	 OrWIveKDNUDpM3zhKwwaZylJPKtO800CoiV3XNCZT7rSGMTJpra7j0rYP8k17tKgcJnse
	 JBrIEoSzc6Ip9LKcRz7Fmlc9lzczV4Lt1Ipln1WWzTsQJ+IvKZRMusVmHVDCPaa93dw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794932350;
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
	bh=Vfefdmi5LHLQg3QcoRZyzJa/lentw8FxH+B9x/6gbK0=;
	b=v3MdXGKR5km+vnZKdtFBgcCLKM8TAx6PpgcXttm+AquvcK4d1ZU2iBDXn6Hiss2ra5J1
	 BX5Mi4+kWJ/su/lI/ayGjhcxvQvxmNgVLtCH8vVr99povFONvXtRhq4GLoeqycfCHNbua
	 ckui5l+E44UoDIeaVsm76pTjUSDfLYe9wY2usNkiIZ7S/Td/sUzD5d2hafvtd8wbEJ2mA
	 1cIZ5S2UtJIsR01ZmKXtRzVppgTk9RLiDVX8x2gyTwx+IuAr7ivhQscMykix82WpgLTjo
	 I/WJs3tYJrvvLsbbOSTDEoyyDFlnop+vBbLCdanR9kTpB4SVD/htAJW8CaEbMw/OYEg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="VTM/hrwe";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.22
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010022.outbound.protection.outlook.com [52.101.56.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80487606A32C
	for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 16:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80487606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=VTM/hrwe
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qDrVsK6jNbOwOYiiajivTIYvel7VxHPM3VxeepdwpPexzIXUxeSMZWJ7stBVGNBTbB6gCIXCG4Lcd0mam4TrZGsr2EllmwMH3blfpctRmvVmBEsneobHSwPZWXD8qYT8bDOmNh6TgnReVBGA4zb7G7t8fQE/AsYynfJUVvt8/L6p2cB/8dpao44OEgiT1/3fV1tW/1geGHLdf0d1GicWDgbJFcCm/N3BQFW+5FGLN2TGyMAQTYZT/tSsHPhrCQ32QHxRgaOMlMAF9TNn21jMhsqaPIdAsZ354a30m624/1r6qDGRifTf9W1WNikrymgPDN92SEabgjsH15UO/QcJSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vfefdmi5LHLQg3QcoRZyzJa/lentw8FxH+B9x/6gbK0=;
 b=Av3gfNBPRdNNKv4teicMiPll3PHVBiyho5/mVxUugj03Ae2FwM9acBXIvpoN+k7zR7vrWRIxcIh6wKPp9gv8AeuL82CBpMgj6oJ32E0PEcjvniIHc3dYyAc3UniEOqU7rOpuX0rPUm0BH4Onpvp0BDitZcYt3U1J9izmAGrJkIZ6MMKVomzYPYezsbsHuCMlfGhYMTd5OW9WZN2h6LvDgC0+rL0V4QQmFFRf0Q2lIh33bzcVwaJ2bmLtGbuPD++nxRsV9rl7BV1DXKJtSj7WZNpue850+f29w/zmFPjswsCv5D7DgpYFR03m1UlZIUrkdGMR4W5Jck9M9Eq0yAHBBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vfefdmi5LHLQg3QcoRZyzJa/lentw8FxH+B9x/6gbK0=;
 b=VTM/hrweUpaB1M2HB7MGz7fPsC0ydz3CnF5J//Nq63YaBnxHUOxDQcTiPa6UkQXMqV5j+mH4gzcA4u0p7+6Tah5LFUREYgmoirLjb40jxzwoGT2dnj8ak50YUN2ib3Oa/raKOtanXcVixMPqTNJFDbZZAbf0ZFgcPCBj9/e5XFgq/cTx8+6W5A35XV7Pr9lhtPvPOVdEGQrqKiaFmupDSdQk4nsXl1iXnheL/U8Nx42JT52boUP0cxty4e9u4Kr9pYRTJm62bCUuwK5Z+I9Qkc5llvrrcQxedKNMG9CNZLavpFD3XgBTFSqmxYxIvT3b7TL4jGL+ije7j+qGEGXgSg==
Received: from CY8PR12CA0003.namprd12.prod.outlook.com (2603:10b6:930:4e::8)
 by CY1PR12MB9604.namprd12.prod.outlook.com (2603:10b6:930:108::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Tue, 17 Nov
 2026 16:18:55 +0000
Received: from DM3PEPF000265C5.namprd03.prod.outlook.com
 (2603:10b6:930:4e:cafe::2a) by CY8PR12CA0003.outlook.office365.com
 (2603:10b6:930:4e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Tue,
 17 Nov 2026 16:18:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM3PEPF000265C5.mail.protection.outlook.com (10.167.23.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 16:18:55 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 08:18:25 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 17 Nov 2026 08:18:25 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57 via Frontend
 Transport; Tue, 17 Nov 2026 08:18:24 -0800
Date: Tue, 17 Nov 2026 08:18:21 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: John Garry <john.garry@arm.com>
CC: <will@kernel.org>, <jgg@nvidia.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <praan@google.com>, <kevin.tian@intel.com>,
	<smostafa@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <jamien@nvidia.com>,
	<kas@kernel.org>, Cristian Prundeanu <cpru@amazon.com>, Breno Leitao
	<leitao@kernel.org>, <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v12 04/12] iommu/arm-smmu-v3: Pack the MSI vectors of the
 used sources
Message-ID: <avx+TaUG+bcPz3/o@nvidia.com>
References: <cover.1793593923.git.nicolinc@nvidia.com>
 <0d28afd67694fc6882e0ff5f054027488b1cf816.1793593923.git.nicolinc@nvidia.com>
 <db4f83f3-d35b-49b7-8570-04e158125b53@arm.com>
 <avtSD34Rj5+XAz3t@nvidia.com>
 <cef6ee03-7b2a-41a2-b7bf-b321ad6a03b9@arm.com>
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
In-Reply-To: <cef6ee03-7b2a-41a2-b7bf-b321ad6a03b9@arm.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265C5:EE_|CY1PR12MB9604:EE_
X-MS-Office365-Filtering-Correlation-Id: cabed2b1-e738-4646-5c86-08df44c67a49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|7416014|376014|1800799024|22082099003|18002099003|11063799006|4143699003|56012099006|261026121527099003|261021121427099003|10067099003|261009223027099003|261102123227099003|261021135927099003;
X-Microsoft-Antispam-Message-Info:
	+rXxMTHsQJ7BXpkIfxotWR3dKe8knM3VqsOLjHmjDWmuwUE8iptU6u58d+cw8eRocs4VHfTjVRj0MJq4qAE7zYXmPNsUV3bJW/OiEcQYnaSdwFiT+lrq3grjyVoJJ+5O2qknzT/hxHwHkPwSg3LOT2VSwHInzNJHwS9RhefFUv6BJuvZRMjvovyeV4hn+plnFlWWlNUvnEtLzR3fuF0vv+kLja7v+32BsiWByqhUiMfymNbHb0vq4WOby1afpxx30NsX0ym9vVT2hZOf2pRJLwHKo1mf+nFri62STWTdf7iXVcqBDtmnWuTrgsVhbe0pa0d89ogi/qEHaWOhHVHEfIq8e0IDY1ojKlLIWogcWf7hi/OcfZUAYAyGFSvdXEkk7Q/AWOFFUxty7N+n0mkHv39RV7j6ZLKxE3AWkHQrKfxrJUQQuvSsSgf70gzI5y3LhavQTpAkKEaXiOfREgsINE7wJ87mZ0x1gIIDfKZzYIq4+WgQEPSHEwE+NRkAQlivhYPgcz5HIjPxQ3GQugaL9nNCojcwCdAFcam/fJEAm0hGwJslECgX4zfSTPN2KlBDQuULSRSv3FHynAaMtXNk9V3Oy+asLqnPAoalYsVuESabu8jL9MvfNh8JtzGElbZpWdZmMiAtQ2DtYWsfGmnCmewgWL6JIC8lxxMpPBWpyf8pWpx3mxlyvEcTW94M/jWKx0iJHVRQmudZXFI6O7oAuQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(7416014)(376014)(1800799024)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(261026121527099003)(261021121427099003)(10067099003)(261009223027099003)(261102123227099003)(261021135927099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FS2/0gvFdOapSrg8XxzLUxieW+D0yansqSSKJsq97f1anq1VG7g47mCvmSXUKPpSlAXbZS8s5AOpjTCTif9gTJB1o++0mMKdMNjNyuAGwYmh6YIfI+ba+a46I66GlY1O/xu+aEL7EPWP/EB7LH+HwDLHNdvAoqKxnCh5OuOZSQ2IEto9BFlieO+3h/w6tAfvO4XBroJRM8kPgMYtfIqbWvXuwl95oNyXLNo09PF96LUUj8bDyyqNatkZD2K7vbcq5Sdy0vE3DjaZisCpOBe2HTir8+5B3b5nLiwG1Th+pIC4bGOeh0wftRhZSGHs1H25+fmT973wNVqHGGucV5Y7uOev/Zk3yvCpjV8lQ+9yDZiQKBLzcuN+uRWTi3pbU+VenRcY7GOqQCoqwilQubblKZeilcUImfWGq6ErgPm8iYvVmDF+RrOLN21m5FnmAYHW
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 16:18:55.4533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cabed2b1-e738-4646-5c86-08df44c67a49
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265C5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9604

On Tue, Nov 17, 2026 at 02:30:20PM +0000, John Garry wrote:
> On 11/16/26 18:57, Nicolin Chen wrote:
> > > > @@ -993,6 +1000,8 @@ struct arm_smmu_device {
> > > >    	int				gerr_irq;
> > > >    	int				combined_irq;
> > > > +	/* MSI vector index to enum arm_smmu_msi_index */
> > > > +	u8				msi_map[ARM_SMMU_MAX_MSIS];
> > > should this be an array of enum arm_smmu_msi_index, as in
> > > arm_smmu_setup_msi_vector() we write a enum arm_smmu_msi_index? I am
> > > assuming that is why enum arm_smmu_msi_index was relocated.
> > u8 is optimal in cost of memory; ARM_SMMU_MAX_MSIS is needed here.
> 
> Since ARM_SMMU_MAX_MSIS would be 3, I don't think that the memory saving
> would be so large. And since the next member in arm_smmu_device - oas - is
> unsigned long, I'm guessing that a gap is formed anyway.

The comment above the u8 is already quite clear. Not sure about
the point of pushing here. Fine. I'll change it in v13.

Nicolin
