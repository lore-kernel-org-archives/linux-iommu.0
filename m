Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012052.outbound.protection.outlook.com [52.101.48.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81685352FA5
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 22:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780005868; cv=fail; b=l9qSO9FqfN9G7c16GEPb3Zj2Gnsgf+ft/IMgDB5amj6rPQfKpt7YM+zf+YEaNMBTiu48TxAo6Oqs79rmg7QeMyTZhWkDA/6M5PBqoOGjngf0IF1Zb96VWOHuy0dyAbS80x7qPVGGrjIo9kvRiDM03fEf0y9uEYqxg/qQJax2caQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780005868; c=relaxed/simple;
	bh=DbVuN7AbbOC7BXo5wby9WzXGGaOakK81s2OzNKaC0wU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMPj75DreEJ0kRGjtO1rIALGdjPR2AE/M1iKoeygKpLmku4hpUiu1ic9L77/O/s4TZvl2grhf56B75Xx2Wm7EK2RT5IM2tcN3cti5VZ8kpCoXpAfxAEwdCTrDz6HWzz0z1rhLnL53pG05OI2qZPUZJdQUTVY7nlfPUIHEw4m0R8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o1ZVzb1q; arc=fail smtp.client-ip=52.101.48.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o1ZVzb1q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DvR8ynBaN6ldnGOfssgYw/8dp4rXWXkKYZ0qsUimiqcJu0osFr0BAQRv/SbKbJTB21CdRknAp1deotQKJRYKu0RcatxDb6WwU9aeNnfsq+wo6wliJOjo0VF9UJUDRzh20lj91sp3tVbIQgsjyg73RzSzptsdmTUrzsdaH0fGxyjQ/QwvElferTK8dcW94izYuzWhijS1fcJTwnJNEPCFIUWvyKTQdHAuxzmLdDyDuz4L4ehDmI6jONdBnJYWpGpvpmJWztEN8SfNYe/duVsE4Igz1pImJ4rbB17A0VIopp03TqxQIIhP9PBjRtNU1zLjkBj4ersyOAgxxqTrvVUBWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eti9pXzQG3cT6FV4sWsTWIO6JqppvEGgUzIy6cHiLyw=;
 b=MnMC7XlsgsKep7fi1NlMhcUSz6G4EWuxMhhFTSyGgkMweN6YViBC5UNS6VKUvqQLYmak6U63DfzKrsHcQ2c24jLp6o9Nw8DjmsSp7M9BAtLPmTQuAGXBx7LlEis2MmPC7kI33XA1UPlmoRXOkMGr55y5G1iD4RTahxvARaj6dP9ZjaysFLg2gOX3Eqrp4gLzEtcgLGNRBhuN59cR7769qlyT8CSrDr64xn2k2zxq7ST7E9lgfCiZMcL6mUb8i+DesoYlu1+s+/jHs8c7OoD1dYfCzTYU+/1ftH0cDXdPaUOagKthWMQu6tHVBHn3bwfdyt/JM/7/ej3hrjvoEG97Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eti9pXzQG3cT6FV4sWsTWIO6JqppvEGgUzIy6cHiLyw=;
 b=o1ZVzb1qe8KP2FXzy/MZArl8idNHMyDQ9x26ws/jJFUj6KT5AC3NwB3ALUVUj2Uj20JHgG36797KLOj+bXATZdUF3444tfu2ftROZAns9dM5kRUpTTcmjk/rb7EoTbQC6308cy+oAlWMa3t29mPqDGHa8hxetj2iyVE8NCeejYNaEffqgVdnbKaCJBi/sUn6scAaK7W5+HIhp6WT427Xk2UI5CORrrsIBTy7oEyZ+3qaElRRInhaEX4Vt7t3q9Sey5NqdTvXVkYOiaQhdWo375UZQEbzq1IMUqdviaGJolaPDprmlxkJO2r90UVnwiJfAjDph//zcRthVBT7GMiCww==
Received: from SJ0PR03CA0058.namprd03.prod.outlook.com (2603:10b6:a03:33e::33)
 by BL1PR12MB5897.namprd12.prod.outlook.com (2603:10b6:208:395::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 22:04:21 +0000
Received: from MWH0EPF000C6186.namprd02.prod.outlook.com
 (2603:10b6:a03:33e:cafe::41) by SJ0PR03CA0058.outlook.office365.com
 (2603:10b6:a03:33e::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 22:04:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000C6186.mail.protection.outlook.com (10.167.249.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 28 May 2026 22:04:20 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 15:04:01 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 15:04:01 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 28 May 2026 15:04:00 -0700
Date: Thu, 28 May 2026 15:03:58 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <iommu@lists.linux.dev>, Will Deacon <will@kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Daniel Mentz
	<danielmentz@google.com>, Ashish Mhetre <amhetre@nvidia.com>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v7 05/11] iommu/arm-smmu-v3: Cache and restore MSI config
Message-ID: <ahi7zvOsZlRZi5Gb@Asurada-Nvidia>
References: <20260527221407.1756491-1-praan@google.com>
 <20260527221407.1756491-6-praan@google.com>
 <ahiLFoRk4xaxr2vn@Asurada-Nvidia>
 <ahi6MJaAene0ogY8@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ahi6MJaAene0ogY8@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6186:EE_|BL1PR12MB5897:EE_
X-MS-Office365-Filtering-Correlation-Id: db5d1b73-bafb-416f-e4a4-08debd0511b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016|11063799006|4143699003|18002099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	KZNo3/5Oo8T/FS9k8F8sLakuYmPpndYfeQB5/UhnswE8DFJtfDi5I7hTP1jvWOUvrhr6Zm/8RYqijJ8Cm38cKrAQj5JPsNmsGbSTJTe5MLTlABgGTnsXpRR3k+bVNHzPu/w23egwfLW72jYpOw8osCaeCy9cB/8vol9B616snWwaHHoL/d7qap6rynEQdL8UCSoXe2wRX2lD2Sv6nP9QsKHJA3wEFm3uM5H1sspDlXmNJC+2M2BaeYRPQ5t8bBVjKY2RIQ3/iIAtStd8LBC59eWDoiFBGG6Cg0ZYw/hGKOAcPIhH5Xw8wSZ9RchB6LxC+xucIcXxqtdpUmbo8dd+Wk3etKqNYfn1OIv6n2eYwxX+/EIByHyztyZ2M5ORs9PJ7WsZf2UQp4+Fug1Iyhccrz2G5mqrCUYMKPbMAo576uTuHuHC0meMRsMTBgHgLIJsun0uu6YoMn30uiY9FKfcGYwkaQvCBmjSMCTOaa+C1ed09XgDrl2NHsFXB/7GHW9zK92ANGE42QM2omQeNpwpQEcjLznIUCK1CykMUeNagf8+WIkxgM0BMfETeR6QP5iuFe2gEpOc1mZmE8csOnPnMBH3fxSmYrLRk35CsA8LR2Y1JapOrnYc52yiU/smT+3aML5Gn74OdyLB/pB8f9Sy6jWk56RXco85gmYpjExAxWX2dyxQyO2bF2N0+TD3V/Ow+kiIu78MpfZX6ApD7jBSDEsry49PC2i10u+JAP1k40U=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(11063799006)(4143699003)(18002099003)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QyKaxS72xgu4uhvXKsQwbyXtOcfUx9jFlMlM3U6QxxxLSrtzvkSPwP5/aqDVVVsjYcgobkQ79Xrs1KrelbEXKLqROmsHSPWngAfQIRikFVKxso++rRvWiFHTYgJPPu9h/r+eT1XBNHUyNsZ8vLjTNDs8Oc7uUv3YvSagbXJp+DcU795RiIX0xTzBSObPut3hE2RfBPcpEYB0rJ7eyEvOgWCi7LZVOkcZ9V2uv6jM/49R4CUDxl6gFwPqibzeiY9/mf21AI6zzGulEsI9JcIlwxq7w8/ubVsXZ9I2C1O1cc/TXWM1z1ykOAfzP/dOJ5Pz0c24drcS5jBIRQ3/q3qXg8lXi3kFfe9UTZg9mtoPW3bftRRXT9h4HjfzxReLqcZeBEk6kXfoDXW5SBYGOvB6yYj324yDSc2pNMDo/r1unBgc+XNUaAi1PytPEi8MkyuF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 22:04:20.1084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db5d1b73-bafb-416f-e4a4-08debd0511b0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6186.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5897

On Thu, May 28, 2026 at 09:57:04PM +0000, Pranjal Shrivastava wrote:
> On Thu, May 28, 2026 at 11:36:06AM -0700, Nicolin Chen wrote:
> > On Wed, May 27, 2026 at 10:14:01PM +0000, Pranjal Shrivastava wrote:
> > > +	get_cached_msi_msg(irq, &msg);
> > 
> > I wonder if we could use __get_cached_msi_msg() since we got desc?
> 
> We could've (and that's a nice suggestion), but unfortunately it 
> (__get_cached_msi_msg) is not exported via EXPORT_SYMBOL_GPL() :(
> We could break modular builds as CONFIG_ARM_SMMU_V3 is tristate.
> 
> Let me know if you have a strong preference about exporting it, we can
> add a patch in the next versions.

Not necessary. I see all drivers use get_cached_msi_msg() too.

Nicolin
