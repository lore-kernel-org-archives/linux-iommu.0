Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010071.outbound.protection.outlook.com [52.101.201.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FF147DF9B
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 18:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784055029; cv=fail; b=NDx+glst9RUGaS7M2C5TbYo7VW5uFrP1XuMfxX1AMTvS/pechTgvdLSFmEev39I/FVVryIDfv/Pt19O5zCZUCHqI0dyf1oFQUbY7SF5Nj9f1uAMi8Q0Bgr+2LasbwGVx71UjxQSc5GRhO1w0cEzBUPnLFzrlkUS9bea0yDCZ1qE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784055029; c=relaxed/simple;
	bh=DyJZI9219ibGPsq/PbG9a4jowoaTrAt4oYtGRxg4Me8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+Nu9rPTwU9wmuHRduClvAfxO/nDMIignKk0v9/Gs0mmSyCYl7iLILo1h6ILFGLRJyQ0UIymlM2kmwglbpWXe9uVVcckp7bcLIc8RWUsS+Po4DNn2ZQ+tzbxwnQgIDv6lCjg6pjvJrn5ryBQ9u+7DLhvorDI1IDlGG4r5UJ6LNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aOAjXZC3; arc=fail smtp.client-ip=52.101.201.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aOAjXZC3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dTpHUq4QR+v/5IGG0kplX35Z+ciFD9L+Zb52G2WELYlp0SJ/deknig/1DN2mO7nvUajo2uZR5mb3/VJhZ0rDYgLIPiafo7N70rCOYGH9k3IrLKA+HEFnV2nbflXJK3U4+TZkto6NHPSU7DSsKgnQEbOtHZ/fm/6U0FKabl683FDpcfQyZlMqzgz0kO/PFp55SgOWu+68KLV6svQYB0ihQycdYvZCMrsJ4Twvplm9l+KYClKQq82jv1QWXeFYdh2WHjFCihGj7ASckfNhhLfTmAlpknQp/K0WZ6YQyqzt4JpmCBqsYUPpQtXsUkUsQGzFq9mkWATIGpIHMJqlhWOibg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTZEt32HPbRon9jG1gyZ9CeJ3Szq+KvzRwLrkOaLGys=;
 b=PRAtzalF/0tzaqGoqk93jqqruMyiQXOVEFmmKCtnDcP9IG3UN0kA+/MgkstJxVAmVOWFdqnqxOrW1L5qdRcwI13xF94v7G2WKhrvXV13I7Q+zcezKop0k7+Yf2uLHv5q5Fq95K99akftAqgYhsMlN1hT5MjQdL8mK96CHkknuydHJlHEXIPt1d4CrMp40XAouTs18b3i0w65dkAVhfERw8iaCi8uphmj4jb3nEHaZyEAHPmD90C5TA9RVak2VKW+Fq+YPlhkCpgeVGCvKuQ7rWhWsl8aRpiQkOqUPmSaxvNFgZv2zCsjYhEvv1ZR1JK1cbFXZyigBIPUUZEBzHYFqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTZEt32HPbRon9jG1gyZ9CeJ3Szq+KvzRwLrkOaLGys=;
 b=aOAjXZC3K3IezItBEkCxkx+QH16HgUGiD9C6hcKq8rBhdlk1qNLrXqrgm1Js7cnQSMuBLjEPBxC5Jc0nyQbXDXdRaeac7Tf7s6BhzTvUu3f8/soc4G09jlNtHyMLGt2OrgckcOEWCqjLba+ReTe1E1q18yP8N3Q+MpOqorD9GOCOco9Lk0/8vNNoUQodLvrKyp6OrDiCDzpwhQd0tXVxTFhzbeF7GH4iyVjdFXvVWUimyQm9xaJ57EmuoZDiRnR4swBAHIZaHVnhdfwIdM+/Xy7IJ0I30bAojqZASb7HHDGsBiQGr4CxHRmWb/hLgJwOvbmrVDEln3wVAFYJMLj+2A==
Received: from BY1P220CA0042.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59e::17)
 by IA0PR12MB9011.namprd12.prod.outlook.com (2603:10b6:208:488::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Tue, 14 Jul
 2026 18:50:20 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:a03:59e:cafe::84) by BY1P220CA0042.outlook.office365.com
 (2603:10b6:a03:59e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9 via Frontend Transport; Tue, 14
 Jul 2026 18:50:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 18:50:15 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Jul
 2026 11:49:54 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Jul
 2026 11:49:53 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 14 Jul 2026 11:49:52 -0700
Date: Tue, 14 Jul 2026 11:49:50 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, "Kevin
 Tian" <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>, "Robin
 Murphy" <robin.murphy@arm.com>, <joro@8bytes.org>, David Woodhouse
	<dwmw2@infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/5] iommu/arm-smmu-v3-iommufd: Reject unsupported
 bits in invalidation commands
Message-ID: <alaEzoL6uMhtMWmo@nvidia.com>
References: <cover.1783539724.git.nicolinc@nvidia.com>
 <194fec44b30b7b4233d218686cd76d63208932ff.1783539724.git.nicolinc@nvidia.com>
 <alYC3bNbXY9l0eVn@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alYC3bNbXY9l0eVn@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|IA0PR12MB9011:EE_
X-MS-Office365-Filtering-Correlation-Id: b2af055a-a6cf-4dbb-2b53-08dee1d8be5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|23010399003|1800799024|36860700016|18002099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	W7h9/lwZwiF66vdnUNJZkZ1xlzrq6OzFtHZuzwNmqOKB1fTjpwP2T1acSTRqbV4b7HZeHknC6UDL9kNHNzBNk2q5BNVA1vBFjKv1EeTExMDnInhXH6KOmwA+2cmsvr3Zio9RBSlRvrYq1iXaRMgm6RzsEbv51MLiK+c4po18dILZSxqGepKxrohhMcZWWsy5ggIvaytWjwd+LwfiSWIumk4wYlR4rCrWC9lqTIbFVNxbcGMHxyd8r2dVvpzOIm+az+FhMC0X+XDlAt5ORFUwobx3iHPtiTvKcINr3RyPQCVX7yDPywbF07DTHlNfEqE6UHBMSzemdQdZWisWl+0h3JEM0M+w2+lSxxij5WEPPijURcyd7Gphqgu7kejey9Un57P+Z8kjthouVcVaOwrhE9yOFZmKXDyrl62MgbvGfuOd0IYJZtPZ2KXohp6SV5hqlpOEYjd7ZA/r3S7vvOjPtp8EJKxLRKjx44zvwRvHUzivONdLpC2KmvnH1yAH6Zu8nchp9a/S3kgn/l2wGZhPPnM+qriXl9ba9e8rc7yGso5Zn15rgB4DNcF66RZ9/FTt93JQ40nb5xUQzDAszXD0SAZRuzTFhA2Xduc9w2Do6IQMGQU18J4sTtuC4vypQ5wWGTBudx3HBr4FfZvEkSZzlom/YZ/xGiOveL9c3imMh7e28g5CHvDnqfp3wsCKIUdK5SUl9GK9sx+GTCwPmacjPQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(23010399003)(1800799024)(36860700016)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	p0Dg6qCRq63DlyLdqjxj7OPlC/f5GSX/sx8aOGJuOcZvBEFxFB0jRkM8NRiDGfkf/K5jUShSTIra/mPgJ+zHHLLPpZsdpZV6NnE08+eNgGy65pgx9KI5d54Okk974nFZE4ShXe3tsuoAd/ov7jTaFEV2TwkwqQX06qMZe7QPT9dWafMEfEXhgOxh6o+w5HqG/uk+rhsHj88+dHuRXxS5P4qE+z6iBZmMZ1dRvR8rzODZAzlwcLva3XO96rI14UCzOZgjm6cjgCcWKYwrh4T0fHrstid4AhebltL8+i+TgvqnxphJOHkPI1Ewkigphmgw/FrcNLTHlpC8F3xqMZPoRhnTuxVnH4P0NAUkEewA41wkNk+xOEmNxcWxFXJf0g7ADIUvIiX+6hSyWZmJTz0qEan4OqSdI4qgqdAQ2+MYgAMIWAej9zZkLDKcg6K1l5JB
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 18:50:15.5356
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2af055a-a6cf-4dbb-2b53-08dee1d8be5a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9011

On Tue, Jul 14, 2026 at 09:35:25AM +0000, Pranjal Shrivastava wrote:
> Regarding this series, since we are formally adding support for the DS 
> bit in this series for range invalidations (preferably as a separate 
> patch as mentioned above). We should also update the uAPI doc for struct
> iommu_hw_info_arm_smmuv3 in include/uapi/linux/iommufd.h? Like:

I sent v4 that should addressed all your comments here.

Thanks
Nicolin
