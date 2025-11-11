Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013020.outbound.protection.outlook.com [40.107.201.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C6229C347
	for <iommu@lists.linux.dev>; Tue, 11 Nov 2025 18:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762887251; cv=fail; b=imQUHV13jkpCiN/8SHH0np/2aVy4WQcmu6mpP4bos+WC2JkrXv7Ugn0K0q7MaRAFl6bAbK8biCv+54SIkH08Yt0WOmSdaQj9UXxZf88z5Nl39cBKlkIyffCEiTSuLksFuIV0bFgrtxxSwi4/UYM5Ug76270pgDAK5Z/4Nvp80SQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762887251; c=relaxed/simple;
	bh=pOOwNRCqfKmFRuyosPppnX96YAIUFxfnsB4H21S/pHo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6qc7XOx6niusxJIYsJYvhrsLv+MrgwcdFZHe/u9uvm9rYhScybM8YZscPsxqeDcFK1OdkybIZEgpgmxf1j+AY57WDVJsD6ItpF+XjCLEYsLanC9agOOHUS/YQGfu2t/Rgu4lSLupHOwpCwxllZvh88MJocpOxqfH9gQkYVDyMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A7V9kNN7; arc=fail smtp.client-ip=40.107.201.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A7V9kNN7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bYWqjoOXRlrCvgIkdEZZvI4AL0RplXmDKe5SWVJNALMItCG0cVN8RG4bC9Pb9YoCrKEt4nOLkOPlRCcB4uvf5Mzn56VYj1fVgvOPv6WazQFArgkDF9BJ4WxXRHJtJDy47N8RIEIZ6Y37YQDJig1zsNxNKetiP0i/cweQsx85fs7FlAtGU2bxw8jjPJqHzlRGcLi6DrWNiKHt6umKGTH9MRQ6msrzx7dvnuiJsGsHYDCKlYxZvF7DKX18FUzI3KkFJm2KGGtCsqbm+h6EWglszTJAhfArtFpf3O95fyT0joUMFUsg3z3MsA8I6pL+Kr9E05FznAQ+LmYeUhtzqti8XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBwGRr5WrcPHbi9gEPY164jiLMQGJozZD1IPSrcLy0A=;
 b=czgmebCKmiejPPK/Jw6sBZ/1QsTcm/6mbvLCSCvzFToopY+4qbeOApd0giZtMf88iAN8GaziTCLmUgHzAa6eiSsH0APosyLtXVrWf3u8LL6F2KRxXBtdUn5r2g8I60WNQqqbS8kapyHo1UtZnxx1tgpRHGaDmrSG+R6ap8tsN8yH7E3OMxTivXLvqR9S3tkaX9lO8AbfeyNnmG2tM5qxoaq5yvS90gmVW01/bnxAgCNauxiaqA8Ta/p9rVxbmAVx4eTKNBfw+ghw87Oa2jBQYSY3b/b1WERZxlQt/loQYNMEU5ViqCDewOdQ94r5fv+ha3OJ+NG1J8SKO+oOBeOrmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBwGRr5WrcPHbi9gEPY164jiLMQGJozZD1IPSrcLy0A=;
 b=A7V9kNN76YVIm8TVytt0pxNJHlIMAUvKsXWscQxSCQ0kvYRV/u7ZcfoIOhKmShWIwwQn9D8x2zAiIk1fI8D2btf34BSVQ0kvdXGI2dByszKV5As4yWzoXLQMCO7P71IAf03m8a2qRyigQ0Oc4s545yTSeAyI3itiU64EvrELstXBGiF6ywYlBDPW+/uAm1uJEGsBAN8qFOm/rmvvhWs4p1wLWb0uSbyUXGbYtc2xide8Yk+QFhBvFyWeajmG80CV+4u0mU4+OkKjJwVIQ2ZA+ti71k3hyffx5rP+sK2ftxJ/rEhqCiMZjvvU5gxsNMsbnY8rxyA+xg19ixElcefWLQ==
Received: from BN9PR03CA0594.namprd03.prod.outlook.com (2603:10b6:408:10d::29)
 by DS7PR12MB5790.namprd12.prod.outlook.com (2603:10b6:8:75::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 18:54:06 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:408:10d:cafe::1e) by BN9PR03CA0594.outlook.office365.com
 (2603:10b6:408:10d::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Tue,
 11 Nov 2025 18:54:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.0 via Frontend Transport; Tue, 11 Nov 2025 18:54:06 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 10:54:00 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 11 Nov 2025 10:54:00 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 11 Nov 2025 10:53:59 -0800
Date: Tue, 11 Nov 2025 10:53:58 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, "Joerg
 Roedel" <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Lu Baolu <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] iommufd/driver: Fix counter initialization for
 counted_by annotation
Message-ID: <aROGRiysoG5ufXeI@Asurada-Nvidia>
References: <aRL7ZFFqM5bRTd2D@kspp>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aRL7ZFFqM5bRTd2D@kspp>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|DS7PR12MB5790:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a90ac4c-1e84-43b7-b6f5-08de2153b0b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SmDdHWU158h8/NGlPNDHQrlXZZfWO8rn2YdmCTOR17ZKtpD2m/7DFldKHaDN?=
 =?us-ascii?Q?UAxrS+6LmcQWTHuIslTWVC0pY2UQ9oYuVUiew75GVdwTFsfjhqfE8wcpKUQI?=
 =?us-ascii?Q?zpSwCLZH4gLGoVFCxFSPmx05YQE7DMLab5KTgKKFnF1Ptr1XKp2aZyK7ohrO?=
 =?us-ascii?Q?fIXEapN5pArcsAMq9dzyF34/7FvbwTdc3QORqDadderZ3a24AEvHiYdemDl8?=
 =?us-ascii?Q?pisyg0T+GmxVnSS6gbysCOy1dRpG9xBfqLGGjdnfZGN8HYE7BxjgUHQweKNe?=
 =?us-ascii?Q?bBF8m1ff/+bunVe9a349L03EME3WJYQ8ZTc19y13hgRjBHHhU/hE2qnZgFYP?=
 =?us-ascii?Q?gu54evDvIwm7Udpnh3kNB14iKs4QN5z7bdh3IwfVmVNcu0U0UFUC50CiL7dY?=
 =?us-ascii?Q?BdnLWk7Tpf9AfSitKjn8CPQim9X5NYWvhoS9kZ+gXuluw8RhrhkGJkYWAP6d?=
 =?us-ascii?Q?yoLAK6DG8qRmdr36ys760z90O9TBZWPLIsKku9HcVEii1j8MJG2WqwCufgUc?=
 =?us-ascii?Q?779anYrIdBIzPxJHSGSECWuV56kXOFyDdSAXpyziHsD7jUnFSftlpbkWVLdW?=
 =?us-ascii?Q?s9Wux445Ul+z3GkTUrz3D3d62wHkwLvqcboBovBugTPfXxvekjb9RerqMLoR?=
 =?us-ascii?Q?WcOigg7KxUg7m5BGhjMAk7fQdLf3lopTa5lHRUq4tFOMtSEHSkD7zlo8l2kI?=
 =?us-ascii?Q?Sfmypsgw6CTzPjKdmpusS4M2etjid/KZNO6TtebVcOiykDr0Rk+S5jN0CreK?=
 =?us-ascii?Q?svcTV5XEGWiUkDxy0p3SI195l79D/N/Wng50wCgEQTUJDkOma6qBCmuEQj2k?=
 =?us-ascii?Q?DL4PTwn9NivFWnEWBYHoHm6nZ4lGKZF+svmRV18oB9x7CIC+SZYFLso8jffJ?=
 =?us-ascii?Q?JmRyS4wJMNBdiILfZwLEVc5BcZ5ZAkyCTLLHTtEdX12M/8qJQ2Ns2jsE50B2?=
 =?us-ascii?Q?4eTtYxqZ+4FAfpWNYLDi3BYY0Ap9WrzAsqnW9qPvHh9RtXZuTphHS9HSGnav?=
 =?us-ascii?Q?Qt8o5ZXiuOyaVPzjrvrDlzm4gw4lKg1iHo4ehkL/AnO0SvQyj1JEsJe8kADy?=
 =?us-ascii?Q?bcxPGHFlBAxZjeBeRVWaw2SGnisODhqcprnyqOV5H+GOjrHt9r82CpdJxZML?=
 =?us-ascii?Q?oZ9y58ki6Ej6YIyGx/JEeMrngTuusP2Nn6eZMZeVbSJNf+YlqaAjGlqG9+Tb?=
 =?us-ascii?Q?WIh9heZeMlTfCg+VeJHcETtptUBcUpbiQC9HDlurt6gUFC+wB0jIpxGcddUs?=
 =?us-ascii?Q?/KJvPpRhtWc6NM5wbH9a4eL8M61DdSFpWHtifk0c8OGtjJgiuKb1ozK1C7Et?=
 =?us-ascii?Q?7cOG6n0xhrWzgNkDmTqMsm9T7foq0y1Adu9riYIZsnACqbUAfKQ0OVCYV7po?=
 =?us-ascii?Q?cPOzyt19NN9tlW768gh37bs+lt0blrJvIbg4y7h0NWvK7rUHmZUCCVfSh4Fr?=
 =?us-ascii?Q?VIDECSHjKsDnxvF+GAwWr11UdMyY8fcUyXT085QQNKT27ZHylqM8JbbPPzyS?=
 =?us-ascii?Q?HlglhGb+5WZoquSil9sxmZEo5lFkV33qmcqsphEG/Fzrp5IooLJE5UPFQqRe?=
 =?us-ascii?Q?NTC3qJ/gd2HvxHHL3eQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 18:54:06.2369
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a90ac4c-1e84-43b7-b6f5-08de2153b0b8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5790

On Tue, Nov 11, 2025 at 06:01:24PM +0900, Gustavo A. R. Silva wrote:
> One of the requirements for counted_by annotations is that the counter
> member must be initialized before the first reference to the
> flexible-array member.
> 
> Move the vevent->data_len = data_len; initialization to before the
> first access to flexible array vevent->event_data.
> 
> Cc: stable@vger.kernel.org
> Fixes: e8e1ef9b77a7 ("iommufd/viommu: Add iommufd_viommu_report_event helper")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
 
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
