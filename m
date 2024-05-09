Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7919213C8F8
	for <iommu@lists.linux.dev>; Thu,  9 May 2024 09:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715245492; cv=fail; b=MFGG36CNlX/H6GOcPrSQUGQQi3xSbDoQLuRYfjYZDPUl/r6lddh9LwOFyQ6sfwMYE6jxJfDloQXvLV45rPjrNn/6kIA8+lTzPJbVzzz74iIokfapAxfcB46S1+nVLIMga4Dr9vBz9xfLkDeUbHTH/zXfLadnKVn6HgkTiMHzMgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715245492; c=relaxed/simple;
	bh=e+U/PrfLoQykJEr1vVfQrBn8EF0WhN00dp0yQ5Bf/8g=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YsjhyteGWKxb3UjaUtCI7LtYy9ZGPYQIPcjONrrv1IpYDL+CztAR+PNVNQuwkN//IkpJy+zWCF35znOgs3n7v/1a+eVt3nRkYyuddte33nf9NAfWAcD+yfSxlaqR1FAnwS2VcAa6yyuMJgCJ1Wtt8PeHEt67yxQ2AVvmNg+ywps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y1WVORGU; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y1WVORGU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPfwAj4/+Lg627rths2iHHu4DfLSxffPrFB6OnSKqZJby4/f4jDL/VGOXCTUA/vyKfSQYtQlcWLNCEHw6vLaxfuQ2UgwzwsB//vfdNwcdUeoBy7vLymHfr7fPAaRV9gHialAoKDCUtfqFSFyyK8m01YGsN6tJ19s+KbIol7rUa4A+Ljha0d1RSdouHelL85xcq3lDDDUpllpj6pw4oST8jaxKee9+z52UgHYjq7/mH9If4hYVZrfn4Mpd9VLb0sB5oDZplsMIQFJEL+l7L8CnJEr6UXDR/4k8lcbPnxFRIxzHjIx/iKJNkzFUj0kiPIENtqPLwE+2lKQNosbpVLQXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2K9U9sy9q3dwGaHvqYyO3KvV5NoMUXNm7e7hYfDrWg=;
 b=iDSZ8rV6e1sU0en7YAkKYd2bCkPD3/ws7myZuceQTZs33WAqcxQAsHwh9jzesKkDvsmCBOcO6XXs+x66ROdp1q8e/pdrQOIrGcLKXrrM2/klLoi3nEa1gyYQxg9YbLn5muOsu52HdgJG8nnW/Wo+hD/mhlWLK9Qij1uzX+EUu7eFoXpidPxLAgahm1CX1naTgvD8uWUvmjEzIyAg+BJWj44Wm203L+0B5E7XS82lIEKuKSZZnx/XhfAT+leuxJTmGcls52Yzvd6iamItnCCwlQimxssiGKnCZguA+mJ0BAgWr82L6dExGsG5/XB/3riUB32rQnurGGQA/qKjuIc8HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2K9U9sy9q3dwGaHvqYyO3KvV5NoMUXNm7e7hYfDrWg=;
 b=Y1WVORGUXzI8rKhV7ZJUztvUkRY8Bati0J/zLxYaIryty+lyeIWCZsxO6Rpxo6o3u1/PuZK2UBtvzsCnAysT8oJtPU9kNrIdIdZby1dXTVHMTjt8Ld1lIjyRUTq5MCGBtmxG/iyhPlzVJ/IehAzJp1r25S3208vbfNSDoZoR0FE8MKuU9XEXVHHIsiz8MGT0AVbiV8dA1tX6vrCpviV/cdO9T7d6Ejb4IB/RDUMHIPcmeqtcyEsUvIiZ5Xub1boJQt3a7nZPAy9PT5IBHw4XDSkxBX3l2lzidGU6v+tIQ2lbUEnqNUOVLkLRT8Vn3IprflPIFReegucnGpgL+KsIzw==
Received: from SJ2PR07CA0009.namprd07.prod.outlook.com (2603:10b6:a03:505::6)
 by PH0PR12MB5679.namprd12.prod.outlook.com (2603:10b6:510:14f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Thu, 9 May
 2024 09:04:47 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::29) by SJ2PR07CA0009.outlook.office365.com
 (2603:10b6:a03:505::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48 via Frontend
 Transport; Thu, 9 May 2024 09:04:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 09:04:46 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 May 2024
 02:04:34 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 May 2024
 02:04:33 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 9 May 2024 02:04:25 -0700
Date: Thu, 9 May 2024 02:04:18 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>
CC: <will@kernel.org>, <catalin.marinas@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>, "Dmitry
 Baryshkov" <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH] arm64: Properly clean up iommu-dma remnants
Message-ID: <ZjyRks2BPeGg0wMD@nvidia.com>
References: <d4cc20cbb0c45175e98dd76bf187e2ad6421296d.1714472573.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d4cc20cbb0c45175e98dd76bf187e2ad6421296d.1714472573.git.robin.murphy@arm.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|PH0PR12MB5679:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dc49c03-ab01-43ea-c213-08dc70071331
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|82310400017|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LU14fgp01pxId9bi5H9ARUDgmr6JdozJkbMddXwXGJiU5VCznxnKGWS/Ka91?=
 =?us-ascii?Q?JdCjF4pJITcQMGk/8KldIMqQ30vtedXDxexfIOLL1gBalvWPX+jpEFjaD3li?=
 =?us-ascii?Q?+vvhrAwtf1g3jPtwgGi8ljxoQLlFzBAGTZzSiuB6iv577o86o9oxh/G18PKf?=
 =?us-ascii?Q?NIdKsJxDWp6CCR5pDNS7eZKTe75TyKnT/rUYb0io6LkKILtIrvSY6YbDhe8O?=
 =?us-ascii?Q?OuaX2ADXA1dmJnoEx5Nrs5YbjwLzk11TJkitKGlns/WpaVv7dCXmw8ylay6Z?=
 =?us-ascii?Q?12ihps+88zQLhCSaTjYADHg4cQrjEMDjb52hzi2St7aWDEpX6Xpv5XQsZuB7?=
 =?us-ascii?Q?Eqm9HBxEAbST3moRkevt/H8jarodIHLFDRWbDYZjOE+Ffs47fN7W/QRZMikZ?=
 =?us-ascii?Q?QzIXU6L1qZ9B+i0dn+0jwV1wh1uK0zerqNnPHOL8641v43HgnezvI8uCRgmA?=
 =?us-ascii?Q?AHi2p5X+ahX9Hge5wfum1r/Z1X5vYEOJaYoWh3gFa6x5EAb+ab8EOQ3UmtJB?=
 =?us-ascii?Q?SKcUrQP3yzu31VabHXAGu4aHNx0D34vsOxWt5xTCyYAHpdORPnX/mFm9a/OJ?=
 =?us-ascii?Q?aELH5OsTcE7O/8+4NsKNgnTbgPHH0C9Kg2qyVIyoJvo3V7nOQ3rc9NalJxVV?=
 =?us-ascii?Q?qGtooTEaXsoCcLbloSX5lAjl6mX6zom4jHob4B+sseXzIH9kbihi8kUH1Pjr?=
 =?us-ascii?Q?RoS2fnQhcH8QmMtKVzwW8xfZDQmttpGUDpnojHZlYljRwMkF6Wty7GAkoyr0?=
 =?us-ascii?Q?Kniomt2e246cDhosTe1ek5oW+mXGIUncu9fGGoMk5eXtR8yaSnbqXg6e25dN?=
 =?us-ascii?Q?7fAOzxyIg0/RoxAYSlXXsAXaRi9ejej5LnTeGqEgX9hyy8MCywtWVkgM0e8e?=
 =?us-ascii?Q?WsAuF+AF2r0jXgGNCHWbrXG1fDtpMNhkjdQo37F+NITxQZeh2BFs+vN2PhwH?=
 =?us-ascii?Q?I+6iW1hzFKej0AKrtfcYdxwoM8QAONYMU/Lbs3kM8Lm5j4npB6ZlCzObrp8S?=
 =?us-ascii?Q?j46CTDQh7isGvXsnnr/b4DnpgtXAQiHXZFhLXIeh6exaGPONbPT2e0/RNpAD?=
 =?us-ascii?Q?lsPnsUitk7Zahc2XM+574IOAVx7V7Ha5qWd/4rxlKXpwghpkb8L6zSeeu6CK?=
 =?us-ascii?Q?p9bdoJe1fbgRmeL6eQu0rN/f90h9g5vlIdICsMAb/jGaytCZSb0JXUuTwQ3g?=
 =?us-ascii?Q?u1xHDEPv8XZ5ojfHLRsOMjufMzAjojlW1ZnUCm6sGptg5amjzvW40t5dP/WC?=
 =?us-ascii?Q?86Aq9TXXMzFoO8wPDpher0F6pu20yiNahvDbYL8x1wKOV/SP5Mz31EcO7ME4?=
 =?us-ascii?Q?6a4yPvmGz7km6ZOOpNBgjjQqOpbJvSyo65qDsR67wi5RlMa9xlb+NMIybNRX?=
 =?us-ascii?Q?W0tVRaE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(82310400017)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 09:04:46.8565
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc49c03-ab01-43ea-c213-08dc70071331
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5679

On Tue, Apr 30, 2024 at 11:22:53AM +0100, Robin Murphy wrote:
> Thanks to the somewhat asymmetrical nature, while removing
> iommu_setup_dma_ops() from the arch_setup_dma_ops() flow, I managed to
> forget that arm64's teardown path was also specific to iommu-dma. Clean
> that up to match, otherwise probe deferral will lead to the arch code
> erroneously removing DMA ops set elsewhere.
> 
> Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Link: https://lore.kernel.org/linux-iommu/Zi_LV28TR-P-PzXi@eriador.lumag.spb.ru/
> Fixes: b67483b3c44e ("iommu/dma: Centralise iommu_setup_dma_ops()")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

This fixes the breakage occurring to my system too. Thanks!

Tested-by: Nicolin Chen <nicolinc@nvidia.com>
