Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010037.outbound.protection.outlook.com [52.101.56.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C8D3BD649
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 18:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779993688; cv=fail; b=J7kNXszHCo/nDVBKBttQdvBfZFPftyuGah1uyfqknHSkvc+DJVMM+IsnXEyZE8q+7QdD9uIXApz/vjoXhq68JjpvjRMgKa5ymoYfex68VdijdhvAgo7Tm9n2ctbni6wBb7lEbCqpmHiDv5EZoEiVJBD0AaYqZzsWZhSCr13eUOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779993688; c=relaxed/simple;
	bh=ff0lmcDqKiXTGLEA8XlivkSv1ZzGvhYU/oniWkKy7xA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWbHxp1uqJ7BJoilfziKyQrikNQh6UrRzNhlKLCOqWj8tNV6MHUSimmj+WvDRaePzwEuhqgKwDBDJMO/ZjVx5vlfG3tdLYbsXD6//r1kxCVJn0GuyKTYXyzXzyURzQJwogvA3L4hPTGhQSYFa5qK4WnYWy79E+PIUNlURPj+iAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ta4aS32v; arc=fail smtp.client-ip=52.101.56.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ta4aS32v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CKM5CRrT6P6HkfuD/HsZrFzTC46zl+Hjgji7CjREuOol1MabD7ta5jeFH6g3uiLk6hjmnIYdURrDN0i7l2caIaRyFakq8HSmR2ABqAbn0BxxoWvD8/0bdT8fXNvOhBqZz+wE9y9hh/M/duW2OZ1jCRX5K4XJ/wVy/Dk1GVXg9e3Spmgob+4JtDe8VfYDe4ZtrvjNx1c+kItjiKGIYaynwf77ITl9CW/6XDmhLfdJJWwLUzPSj6w36FX0KA/gsvmnRk834ZGESmExGx8PEjkBKu+bNp8DOF6b492gR/V1ygU95xsMjdCJfBXA/6lomoxW5CLqd8rBL8iErRisCZ+iGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0/WakMNsSLxxMvouoZ0SDPTy3b2Dlfufd3QoGL2meU=;
 b=zL6TXmgCwo/YCYISkWbYoGxm8CGvX93eK/qNdYpFN0QTQZD0hLeRhjy7hs290O6FbQr6YB17dgJqOUH1GmLVVHCtug8mo5Q/92irLMmSw55aqn5b862pmGvWE73k6DyEw58CSOqVI9CLDLhR5CFJru0xVv+vD9G77r5ICYQQj5QiRIMgCU0SoOGI3lGin0zCE34LZAYMdgisq7OqotuZQqDNTExcqzXOwOHMctJsnx/ZPoxiYzdlGIU71rcAEenZce2ZyqHcbaXZLFUjsCWb39rt8wTILut9uz42B0VX4jfFTIw33aV1PHJQo3oW792Xfw7WE6kIB8/sY5mFyZmtaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0/WakMNsSLxxMvouoZ0SDPTy3b2Dlfufd3QoGL2meU=;
 b=Ta4aS32vuC4SkvVQe8qCQ1O9oHhO1ebc/6uOaG8aalkgIqBq+WJcPgS+UWsui32gOjUUOkPFLE1wqHQ8tJSibpu5KFXsMvCTNI3izHm3rPCK+mkP4lq9ErKUeG+N70lIQ6vEc+ao68ErQrlukxQqnw9C5ipg39dP3IqtineZEXYbT0nnM+C7HNdRHWc/E5Khgm+JCffjNpxqCYjJu6r0ak6glYb9E4TNTF9XkP7EoIOL977whTjFqO2SSd000B4N7/oRqeoR7g9v7MO4gJaXyH9ectHb336oNFzsEu8d2wULPZImpPBLacBJc3ZE5W50Y6EjufA0FAZdRxByFH/z3A==
Received: from CH0P221CA0027.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::8)
 by LV8PR12MB9182.namprd12.prod.outlook.com (2603:10b6:408:192::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 18:41:20 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:11d:cafe::9d) by CH0P221CA0027.outlook.office365.com
 (2603:10b6:610:11d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 18:41:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 18:41:20 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 11:41:04 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 28 May 2026 11:41:04 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 28 May 2026 11:41:03 -0700
Date: Thu, 28 May 2026 11:41:02 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Ashish Mhetre <amhetre@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@ziepe.ca>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 0/2] iommu/arm-smmu-v3: Tegra264 invalidation workaround
Message-ID: <ahiMPld3ePBapYFz@Asurada-Nvidia>
References: <20260528101617.4068249-1-amhetre@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260528101617.4068249-1-amhetre@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|LV8PR12MB9182:EE_
X-MS-Office365-Filtering-Correlation-Id: ada2fd8b-dedc-46bf-def5-08debce8b602
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|13003099007|56012099006|18002099003|6133799003|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info:
	67v9lf76o2QK3AQsdfWOKSTi6m37dewUarr0HSkL93tdygouheCoElchzsgRYSNpz1S+kg0VF6basyM5cbvdgeuVX/pPM/BeUkgRJvYEpR3KeBk/zt3Vy9DQNiJ0vlEbatCMb16zJEvequxncgiJ7cWigw68okqG+0JaTocCl11n4kBiRlKBH6rfs/+0WP62ZanktcBDqdDx6qu4uIuxyiiHXtw2d0Ne63g4PhVQt+sh7uKIqEEAuyD55RzbtHGuFo+1M58fsLoQnLzb6McHduUBMje6ScMTGy2y0jLMYKDAoM/ruHbjZi+QUTuZDqoxG3T4ExLqBJgxTynJITqAan6tsURcdZiANG+TF/O2otEXKFDMEOzrurA1PKbliSuesrTjKRFTfFDr8MHrGSZjBPPjPHjS1Bya7l2cIDUX1m74HFO5r0VjYrMOlCFWqh3GpEUeMnZpz8JuhYFI9s1yZkTFATnsTbUGAc2NCdiYGeo1+/HvlCw/Rc9WgMZqjYe0cgj55tUkKOZTr+oA/tNUg0GrgPG2hk/02eRKBypYtwLPJu9ONidL1vEQlxRiqHGznPJL9tZAzIq06qOlLlFjwWIfzPtx9/QtXDoIJvi+lknEWvGmWZOy3+atrEOeZKGDFmfx3fRQ136GXvuG+08fPUHkzgsJm4PVUOAQlZFNqs+5WPTC4Y8+pxvIslznIzSH46E4mmmj7asuCin0h2JCj0ZzIswRqYfj9gkZqt94Zp8=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(13003099007)(56012099006)(18002099003)(6133799003)(11063799006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xE++WpptN39SjW5Lsbf5yduynJ7c4wVoOPczYpzK7ZR7XV1q2IvywFFGIAwHrDJuiH+QcrqPQy9NVMjd3qO4ZjRhuTZR8Pb1/ZyGoiRcR+1H5F+nCWbRnWLqf6O46ILnUT9LSgHiINgpr9o+Vxcr7aMnjE4tIlLGScfKKAve9mXZY+Bq7U4wb3IWye/EeM9fyWuYt/UPwdXCUhRbZ035Ljap8qHvxsFJmgmMHrSKhAuS9ybL8cGUE3KPA2Oe+UVsh3kmjwV754kcBDau2GdI6IxbpZrICum0Pst2IGYQNZNIejZhFJk5bxgMSyFzdDzUENSe8vY2L9M5T0Zygz0yuA7V/MRuqH2yYeHkqhb9UDeE2dyNpvyy2ICQZADruGt1YByL1T2JQhP1wvQRxNlJx6kC8Tm8pe/w6BXhxyy22QD2dRe9zJqfb8CC9iN/aOm+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 18:41:20.3861
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ada2fd8b-dedc-46bf-def5-08debce8b602
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9182

On Thu, May 28, 2026 at 10:16:15AM +0000, Ashish Mhetre wrote:
> Nvidia Tegra264 SMMUs are affected by an erratum where a TLB entry can
> survive an invalidation that races with concurrent traffic targeting
> the same entry. The hardware-recommended software workaround is to
> issue every CFGI/TLBI command (each followed by CMD_SYNC) twice. The
> second issue must execute only after the first issue's CMD_SYNC has
> completed, giving the sequence:
> 
>     TLBI/CFGI ... CMD_SYNC TLBI/CFGI ... CMD_SYNC
> 
> This series implements the workaround by hooking the duplication into
> the single chokepoint that every synchronous submission flows through
> arm_smmu_cmdq_issue_cmdlist().
> 
> Patch 1 detects affected instances using the existing
> "nvidia,tegra264-smmu" compatible string and exposes the condition
> via a new ARM_SMMU_OPT_TLBI_TWICE option bit.
> 
> Patch 2 wires the option into the CMDQ submission path which is used to
> re-issue the cmdlist when @sync is true and the first command is a
> CFGI/TLBI.

What base-commit do you format the patches from?

Sashiko failed to apply for running a review:
https://sashiko.dev/#/patchset/20260528101617.4068249-1-amhetre%40nvidia.com

Nicolin
