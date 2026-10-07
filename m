Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010046.outbound.protection.outlook.com [52.101.201.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879683D7D6C
	for <iommu@lists.linux.dev>; Wed,  7 Oct 2026 22:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791410491; cv=fail; b=c96CKLYGzydwfZffR6v05+ZIuCeUq/ytZnhsAO916DSnEajnJR1QUmN/dcECANTLKnySsJHfROxhWg0Agg+VWNu95SlCuoDI3kt7dAE1DUu4AwXhvYhbhw3raAeJsn86mbCvm0tVH23YgQYnX2HlFa7hJBWCzCU9+vDxVKnkBd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791410491; c=relaxed/simple;
	bh=EmVC5Haqu31CENrYJW8PITyOU924Oy690xiMGKEWiYo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hiDTqo2dlvtu0f7+AlXu8NzJR5Xf2ZubbFIk6vJkvLdB4OY4N3oxkSLO9emzlVe5QU7QfUYwtXNK3WqzidLMrcTbOENv681ypmAaPX0fXcZOOcUgmn5KEELfY0CDOR4+Cg0rxwBPU9mNEnZ4rroik1XfQGv7drd9NqeCV2OeYIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CZ9UEM4D; arc=fail smtp.client-ip=52.101.201.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CZ9UEM4D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mvw318jJKjlBEeWZd7w6fWougfxF9mvJrA18IsJnaJ4NEWXlk7KL21McSohBe9TsLh8qBZdayEFxAdnebon+LC1IdK/hVPTW0gn9adiYRZcwee9YanfUvVl3q7gxnF3wSMblh1lwv+ZBz+MpPjniHZrk4y3N7aiD9p9gh9LWH1C8MRDGM35zrzoBs84vdqOJTJ2kyuH8+Bsy8siCv0oVatinHI0fOOR7n77RvUIVlYpnEAfFyWqqO+BIVP5TXWxI4X7Xni8nbStodpulYTk5gWVAXmU+Q6UXuQ41fkX72dDM1DmK3/evqD+/QbL4U8koD+ldmXwboDphrwePm7n1vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=edPXbpBxSzf/yUOqzhUDGS03yn1CW22ktw9p1UhyPhM=;
 b=pn3oMOL9Fz6e5r5GbRSV3H8kM+kD+eFJ/Xnc1SkdRJwOUHUbRYH7jzMxtkKniVn8ELsnx2ReNSVXY9C5BWeRXTr9MUJ4i/5TSByjVITjHsms8prqH4ySoOJ+z0G4+Kx00jJyU2d/TqRpSrOmqO5eBGpZ9zPpIzqLIqL6Y0gqg8wOajKpOQJrDWigTDk4WQyGXm/KiZBowfkLQWwlW3cqQeJ/CwlrmhkBNpATDZ4E7v82vHnQHuEksOFBi0lAw86G1oPVAsKn7ZF/72fqQRZnU81vm3WWc/93eo//PYokpcqdNoDYskqWwgWdjw8EXAkevI3aXF9AZE4L45qmhh3HtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edPXbpBxSzf/yUOqzhUDGS03yn1CW22ktw9p1UhyPhM=;
 b=CZ9UEM4DpGgMBH3aoQtE8AKB0VYxxrWl1dcsITyx6yNmygF+3/ss/bI0XbhbJHU+JQ6yC5cAF9tiOFpkxM5FWEdC3AdZfQlhIywy4jkAoGGFwAcZpo8ORcykU6tY3Q/1n9FicOTtZqm1x0nEynZaEh4RSmZGNeS3CrqJrFYi41jH9IkTeuFTjYpXI6BsU4EZbn2sL1lCioODz3K+PpYNVr4THIjqjGEzT4HS9QYkS7qqdfeZPZ++M5WKN211b0sz/GxMxioC27qugMq20uM74+5bhswgPn0m7iPhCkmYvJxFpIbZF+gtsojNhJioufYsb3G86QCqym3L2kTUp1X9Uw==
Received: from PH7P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::19)
 by LV5PR12MB9826.namprd12.prod.outlook.com (2603:10b6:408:2fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 22:01:25 +0000
Received: from CY6PEPF0000004D.namprd03.prod.outlook.com
 (2603:10b6:510:326:cafe::93) by PH7P220CA0012.outlook.office365.com
 (2603:10b6:510:326::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.19 via Frontend Transport; Wed, 7
 Oct 2026 22:01:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY6PEPF0000004D.mail.protection.outlook.com (10.167.247.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 22:01:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 15:00:54 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 15:00:53 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Wed, 7 Oct 2026 15:00:52 -0700
Date: Wed, 7 Oct 2026 15:00:50 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Samiullah Khawaja <skhawaja@google.com>
CC: David Woodhouse <dwmw2@infradead.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Pranjal Shrivastava
	<praan@google.com>, Robin Murphy <robin.murphy@arm.com>, Kevin Tian
	<kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, Shuah Khan
	<shuah@kernel.org>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v5 16/18] iommufd: Add APIs to preserve/unpreserve a vfio
 cdev
Message-ID: <asbBEn8GMj9NQ7I2@nvidia.com>
References: <20260921004834.2601285-1-skhawaja@google.com>
 <20260921004834.2601285-17-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260921004834.2601285-17-skhawaja@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY6PEPF0000004D:EE_|LV5PR12MB9826:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cc7d515-f651-4bfc-de15-08df24be87bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700016|23010399003|1800799024|22082099003|18002099003|4143699003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	2oROZAE/JYZGEiAH2mNPl+JmzdDsBXCAL875xUo1OXMmlvQ55HTNQir1YK6vyHcg14dLcDs7nTH4jG4PDzLYF49Swjfa867s4GAiEaIm1m4FxUU40caHOTaClR8yj+/lnjd7Ji01lhzwdAX18VBtArcLQU2ojTiG+u1AC83KFpdSxum9MheACmxgn0WBxlAeGDDB25jwPjdadtZ7YWuMcX40gx2wp++j6a/ZhuHhIwgnyKDyZo4+j8KUJx1Mvootv+AfyJDhAWhxz/GhdWq70EiT5KuXyAGQF3x/j5aYbjV9pYPqtblBd91aJedwyF/IEVozm7XgxWMFqhuct5PGvP24T/iUGTYIbTiaRrqCWvbFEXVG2wMCFYSkODcpT3SGZh4Ro+8m1iWSk7jvp/krxW+Jk8TxpMDocGPXPIq1vL/RoK8fPbXjwDLUHVxbUXgeyUZTY6oKhVdjaRY41sVKF1elDUviwhhsikYH2HIhtQfC+cLwFJ7GNNidEa6MJcE2nQhHpsW5qNFjvSO4/NTq7/o6dYycdjWP7Oa6RxRARMIar/CLzKTj3wZSXsI42VB5W6mEnbXkthQfqC5h3oA8e/XD+QjdnN1QIdkPdeOM9qwNF39M5mqnz5iqBZ5D/C+guyRElaVzwI3fVJUPoxCZOqxiUpgOHv3yu7869FJj1UEZWkUS965qJBm7xT76TX/WSlmuD3woUwjuCn+47Bf7dA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700016)(23010399003)(1800799024)(22082099003)(18002099003)(4143699003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TivIsf8Bf+b0On0mXueOb/f3h2cN7En0cMzAgfKYs1VEwz2ArepcM1OM8eIwJcOsA1doYE1fkBcBkWisEYo/SnPlxn7kL7sDI1s6HlM5uCRZTu2o8t4Ysy/+MQXINVPgziu3rzqPdJ/rjnZ9c1mncHJ7cgL08Kg83fFt9NrQAYb6PeitlOasBaPpDRmwAEyUcw+z10EemxVZXCr1mzqZw83gut0acfyk7uwnMaKDzH6uC7M7yPPVPsS3GxdZlQNX6zL0XNJd790keJ2C9O7ky1XYqcEhMCxd/Z6eIYOSDxss7GPP+9xRgkD8RVnyAdOchMPdEi6uzAwQRACkW8fkpHXrS+e2a36EbLAb8/IoHYPJw/h+IjeL8fAjGMN3eY5qklRYcgXwpsCZSDAUNsdTg45ZVRdiK6s+ZpQFmYJfA9jERbIQZVm4xxvYENDx5EwV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 22:01:24.8845
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc7d515-f651-4bfc-de15-08df24be87bd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY6PEPF0000004D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9826

On Mon, Sep 21, 2026 at 12:48:32AM +0000, Samiullah Khawaja wrote:
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> @@ -686,6 +687,10 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
>  	int rc;
>  
>  	mutex_lock(&igroup->lock);
> +	if (iommufd_device_is_preserved(idev)) {
> +		rc = -EBUSY;
> +		goto err_unlock;
> +	}

You might need the same check in iommufd_device_do_replace?

> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +static bool _iommufd_device_has_pasid_attachments(struct iommufd_device *idev)
> +{
> +	struct iommufd_group *igroup = idev->igroup;
> +	unsigned long start = IOMMU_NO_PASID;
> +
> +	if (xa_find_after(&igroup->pasid_attach,
> +			  &start, UINT_MAX, XA_PRESENT))

Nit: it could fit into a single line.

Nicolin
