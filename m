Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.64
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795107089;
	b=IsxHxqZLYh1IGcZzEIOOIrWcIpyfz/WMcwK48/6U2N3g37brT2N2nCME2BMZn5RlTthB
	 JVXr8QbxoGIvznOfRqPfc3X4I+HusW+9YAb5YCtD4j5vs/hCo0OgxUbk6mAtp2dj3zQjo
	 OzOQnhAGMpqfaqkyLPMpaXzRXMivXVDZi+EqLgzKxDAoe6C7YeroaFnkPINTeTX6cj8Qz
	 PIntgwUHk26c9pFOYCzku3voNq9tI1YZByNU9ohtAlLG/Q+ftWx3JdzUoGJU2FMQbRSJI
	 FbHWklB1TXC8cPpGHZ+fUfeh5su/UJ145UU2RuRDuTXZKWKeb2ONvlh0efUlytXNHDQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795107089;
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
	bh=F7dD34vYVgEIhrODdioIEmA+HIADJyQjsjtb9GQQ3FY=;
	b=mfZAD7DL7sCz10qABYWtBQPNZvBxBvFuwGrcDxv6Nh0rpcDnCgw2w0+fKbD+T0rD3jnC
	 2829qIiKexBuVUd9ss9evvwh5/F6Hf69dhkVaun6EJXvAmrW43zM6mpvqIFfMb4vhPgW+
	 Zl22V+Ri3GAp2gdLPx7gqjwEJIHjUvxz6jhn2TNG939YAprw9PRtmhkg2H7LiBEl+DbNi
	 6sq0Dono77Kwk7Qtvg0wEEBdIrPQHHaXT2Ut06mX5vZ+YxAzfJfAvmGfBOvmcnSso3SUh
	 waWWFf5RfJX4Kfeo2YMg+pfHdJMMgCRrwpjMHnoaTNmeqXS23Zr0ohu6PSDH0MbqzqA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=YE2brgLH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.64
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010064.outbound.protection.outlook.com [52.101.46.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232FA606A324
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 16:51:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 232FA606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=YE2brgLH
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t79vv7P+x/qE4WsoAk+ioz9viX4ZRHuPqwh/doYxMbPxF72SybQZPmWvgr08I+0+s0WdNgJ20q1R8g42xiyJIJMct5y3MslMl32iv79if6PI6gZhsEneLbo5GQK9x4cPzgPtcVc76WUce0alJGhkjnXdVIUD7raQKkWfoTbVvvjZ44TSHjpP2y8julaxB77yg2WkJjE5fo2u7p0dVq744AnXiD1M5EX5YO8cujqhK2YaawPnDskzintC0vLl7Esi1eLSZbtZme3UoobHQKre2s8p3MOar2eNwx0CotWdK5ize5jb23sp/zCWOISyXitWkRfd5kRKam3V0rMBH6mc1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7dD34vYVgEIhrODdioIEmA+HIADJyQjsjtb9GQQ3FY=;
 b=f0Qc+gPS4GA1Ml+C6/nmS5k0D3IM08FuOsNIMQ27sxZSUND9LpIlqF++b22qsdM754Hb+yDmEymueGVbO9GDsI8239OOjsjsWD9gvWRght7DnFa0F3Fzcen0mlPHjZriB2PKuXfDgqlHo1s9nwIVpbFDeejXkeYwo5JAviwadfRA1GxJXiQFM6oeKazQiAhcSuD2d44HFZcx/5Tib6RWHGa0jUIeULnVAK7Ahw6EHiu5e55NJeu5a0GiMcivT8wiabi8IXMFojnwNCX3MVlxr0e/TNiKBybvAmsFkXTJJ5KloaNCpTZSI1chjgLzSggnFXDA9aE1xNgU/3F5V2qjZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7dD34vYVgEIhrODdioIEmA+HIADJyQjsjtb9GQQ3FY=;
 b=YE2brgLHjWv/XMDq8lR3/iu2arg/jvkdyxI6kOo47cf1U+5eTz0eHnLCTIfVT6Nh3znCiPmigzyCopmD43bhxdkyuNYpfvmfotEqsfBrMKvhh1izkwcbolEMKKkWkMUVBUcHwZuX357Xp/AGXYxd26Oz54UAYmLmrBMgKTUyUYA8cWQVnT+AAjEmUCBIsD9ezBILBUiTEI9UpeLQ6V03EpmJL35Oj9sS6xqP7HbicpH4f+7mpjw7129mnIfHFmEnkeWV88So+R+rzf7CPm3g2Ok8t3VYLSTqcp+IBmA9Dg5BeOo+9LqQQSaxmzOnJrjwA+ZKienjWoMrUxrkAe3yIA==
Received: from BN0PR04CA0151.namprd04.prod.outlook.com (2603:10b6:408:eb::6)
 by DS7PR12MB8204.namprd12.prod.outlook.com (2603:10b6:8:e1::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.14; Thu, 19 Nov 2026 16:51:22 +0000
Received: from BN7PEPF000000A0.namprd04.prod.outlook.com
 (2603:10b6:408:eb:cafe::33) by BN0PR04CA0151.outlook.office365.com
 (2603:10b6:408:eb::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Thu,
 19 Nov 2026 16:51:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN7PEPF000000A0.mail.protection.outlook.com (10.167.248.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 16:51:22 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 08:51:01 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Thu, 19 Nov 2026 08:51:00 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57 via Frontend
 Transport; Thu, 19 Nov 2026 08:50:59 -0800
Date: Thu, 19 Nov 2026 08:50:57 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: John Garry <john.garry@arm.com>
CC: <will@kernel.org>, <jgg@nvidia.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <praan@google.com>, <kevin.tian@intel.com>,
	<smostafa@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <jamien@nvidia.com>,
	<kas@kernel.org>, Cristian Prundeanu <cpru@amazon.com>, Breno Leitao
	<leitao@kernel.org>, <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v13 04/12] iommu/arm-smmu-v3: Pack the MSI vectors of the
 used sources
Message-ID: <av8o8TV3JO9W4dtb@nvidia.com>
References: <cover.1794942324.git.nicolinc@nvidia.com>
 <40570c344d7fce94c4e80316503a9162bb31cb62.1794942324.git.nicolinc@nvidia.com>
 <dc59b81c-997d-4f79-bd95-be4981e4dd24@arm.com>
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
In-Reply-To: <dc59b81c-997d-4f79-bd95-be4981e4dd24@arm.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A0:EE_|DS7PR12MB8204:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e6bdfd8-e984-45b0-198b-08df465d5771
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|7416014|82310400026|1800799024|23010399003|261021121427099003|56012099006|11063799006|261022075727099003|4143699003|261021135927099003|261026121527099003|10067099003|261102123227099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	vOkAdZ3eFXyo1vWuUyLid6T1AqDmfH9mefPAzf0foothqHaZzP4O5wPHT2ZpmIKNR2e/f0axH68GUMRE7f74xryZmGG9Vno7xj10spVidfxOjcRmkT9voJ+FizCgqQ5dJOhfkISY8B4d/VvsS0ql3OX3yAjpwoWH8mbokc0FCt/QMZTN4gF5qk14y1tnz1OF3Jwb8kwB58lyyCNLu8fe7yyKD26zuONKgW4oxfDhSLENQvzQOPdoTicO5qa9YKHnSTelJQy9VyuQUHW92M3165PrDGnO0Kdt/UsQZYv3n/0RRyInUfwPIw4/sQdvjFLLSQSZazbmOYhI9tVK6ZoEgpNz1YRTova3rsAt5Cqcip00WdYuqDsaeFJPnuaFh3wvmltM0q0nHgJVxypkWV5Q0kC/uIkuTlEMCXuoZ+VfYhVa8pZzv/ct6HBc2yBOmPugpmS3pCGmb7Bn1Ybqc6OUo4E8BubExXalNAPERnZqvb7Yv1z5mCAU+DXtH1rPXWU2LSXLnVuMzmObv8Vuxs8vttybwSTJn8w6eKUVwfDOjbVRwnfElLoyQFLHul5XEUubvLzy4BCViBbCN4FTsUNuiZYmeHTnIBXzdpewbX2baWIKG+Jac+KpqnP1MYWKpp4uX7/uRHoy1DnQw18d3XzTzVZn1awAVicFBLfoUfgOMYt9ZPFriYEGa+5//LLXc7OI8MZVapZI0gCZTFL0hcCIxA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(7416014)(82310400026)(1800799024)(23010399003)(261021121427099003)(56012099006)(11063799006)(261022075727099003)(4143699003)(261021135927099003)(261026121527099003)(10067099003)(261102123227099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hyoqFm/klnxEUVosDXEDkjpSTVecVj9TajRKFuNZWbGupFmuW42jPgc0n3hblF5onAEBozfd1YshcqnXXvzMUXoJ4NmGhhQ9DmpXehZBcHgEw7F0B5ydWIOzZ6FGsYCz3A9fhjcp1VwvUU7+4jch+YZsR8dpG07iZ3eQA0TFc/m0n9fYEhRiaF0k41MbiQ4vruRmOzo6wyEdyC23/np0TEGCpPhWmUR3ESzmmglVdbJatxsGYmOeASVKJu7hghOYINPMKZAp1FH+ioxnspq09qOIHv1v6aKKsRtZOHSetyHxOKBa8Ro0+lEitwga0UEYMlWF2vIUqc7C5yhOOzc9oyB/kQTauYSzTdHfZRS0++mTlAS0OvMTVpN/TNtalcbvF8E2Y8PmQOAXV8qB1/orZTQR3WLWtqmHFZ05LrPOQjyaAOInIHrf/u7TSVLQkj49
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 16:51:22.0947
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e6bdfd8-e984-45b0-198b-08df465d5771
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF000000A0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8204

On Thu, Nov 19, 2026 at 10:55:41AM +0000, John Garry wrote:
> On 11/17/26 19:21, Nicolin Chen wrote:
> > arm_smmu_setup_msis() skips the PRIQ vector by decreasing nvec, which only
> > works since PRIQ_MSI_INDEX is the last index. A subsequent change will make
> > the EVTQ optional for kdump, whose index is 0, so that trick won't work.
> > 
> > Pack the vectors of the used sources instead, and record the source of each
> > vector in a new msi_map, for arm_smmu_write_msi_msg() to find the register
> > set, regardless of the sources in use.
> > 
> > No functional change intended.
> > 
> > Suggested-by: Jason Gunthorpe<jgg@nvidia.com>
> > Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> 
> looks ok, so FWIW:
> 
> Reviewed-by: John Garry <john.garry@arm.com>
> > +	/* Map each vector back to its source for arm_smmu_write_msi_msg() */
> > +	for (i = 0; i < ARM_SMMU_MAX_MSIS; i++)
> 
> Some might prefer using brace when body statement(s) covers > 1 line
> 
> > +		if (vec[i] < nvec)> +			smmu->msi_map[vec[i]] = i;
> > +

I don't intend to respin the whole series for this nit.

But, if there is a more solid reason for a respin, I'll fold it in.

Nicolin
