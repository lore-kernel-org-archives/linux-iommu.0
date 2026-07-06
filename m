Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012023.outbound.protection.outlook.com [52.101.48.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAF9421A07
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 18:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783361182; cv=fail; b=DA+U90nLzl7LbaP5D1a8uZIaP9LPVOgMDQpmVTBeys7mfhNyqvp9oA7iVbkN0lHaaUEeOInpSwHYdS5RPQFdri5etqESMHiv97xPbfzTTsdCkzpkR3C+Hd6SzXv2oUl6uL7RM6WiOAAZKmVsSQU6YWBWusCzq5Q0bNqIzg0NNq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783361182; c=relaxed/simple;
	bh=pco+7148XBgtg7vEhgaXxA3ZbPXja/mbm6PHEg5Zgl8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UP9T82I2xLRDfN6WgtCUao99xoQMpELEeoK2MIHGxxqlZhosI9CZQCex32mOCwE1IIJqIrZ60l4Pw4KReaLlAltsRJ4C0mnHeKUodm5r5oY4uT9bOU7oVAJc1L8Kw/AO6oKkYXK0GpOhvRF+CiSgF7OkWNP1YaE+Y4G1UaDKLEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QGoHH6os; arc=fail smtp.client-ip=52.101.48.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QGoHH6os"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XOuX2iN4Zrsj0+5IOdnAsMSqKcRN1R83HNv/6R7lymYPjzo1OTDX2hSvrcz6ZzfvrulUgNjKmniNt40BF5s3T1J2mzUhixafLN7tDtOX1hqJI1lojPAq74YKWO034AWGk0Ns9Cme9h9MZN4/Ythh0g7i5x+EYdDrhX8EfjEzncPymjnLJcFFK0qNTptmNVwGjnCyvwSIuJQZm1C1OTI+KfjNDGZ9FcDBgeXSnTcoMWiLZWoV5j4YajoMVY4J98GTS4RwYukRpOnOG8mtXCmYwNslfhEpTuJd071MyPHltz59O6xK4/lN427NSeaBK714yoTl/2lFXsH6/lckRgBwQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVVGMN6PK/kJkWTHWSER/f7OIYpir8udiz4NwUFLeq4=;
 b=eVOQQeYkDuDqMg0bxelFMhod8TnDEfNfk1gsHLSaSVxO1pD/QaXw0s2y8D/zGGO9DD+0MvWDz0PNzxMcEq4aB15WxaF5vrwUvp65UC01MQQkZhuWXb8OCsOCZDloiRVEeEinodp+Wy6oRE1j60nXx/9CKD38ifE8JUbKyFhtheySwacGkeHSn8ofjUzuUz7d9k4Dnzkz2Vdka+qQ3PbuSTAOptG2hKeAo5dj//A7QdsyF7iQ0cJSxXrYUIuvSBsVb4tFgetUCTSALmOHd9VmfXk+Oa3FIYnITew04nSks7765DfpDa9Ch3iC4QsEB4HZ3ED/V0LTREZlnvhfWLw57g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVVGMN6PK/kJkWTHWSER/f7OIYpir8udiz4NwUFLeq4=;
 b=QGoHH6osoSsUhXvvSQH3MuYSuHjwJReLqGDx2kZOXQP0un8H7W0KrmugTqnZxDZ/BZcsBtOyTM2vFZu+K1qMt9amPDrWwpHQSRgetIgpulOqfryrI+7KW3iP+OIQ3JxHtzM8MwT5SOAriumx0lwgd+hKiQp6FulyzzKFFVGniI+CB3cQknVaDgdkqqwbpMr2eKIltzyrB9uE27jC9+6e9y6dpE+DFYra6l70YL8IUANZQor54EzzXTahwBZRZXPB/xwZ0t4b5bHflILNyYi3Zuglb1+7VOuy81EmtET13tbTFpqGWjynIIkcLEM1i3ayPVPUREHue15pHOck62hFeQ==
Received: from SJ0PR03CA0002.namprd03.prod.outlook.com (2603:10b6:a03:33a::7)
 by SA5PPF8ECEC29A9.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 18:06:11 +0000
Received: from SJ1PEPF000023CD.namprd02.prod.outlook.com
 (2603:10b6:a03:33a:cafe::19) by SJ0PR03CA0002.outlook.office365.com
 (2603:10b6:a03:33a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon, 6
 Jul 2026 18:06:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000023CD.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 18:06:11 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 6 Jul
 2026 11:05:53 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 6 Jul 2026 11:05:53 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 6 Jul 2026 11:05:52 -0700
Date: Mon, 6 Jul 2026 11:05:51 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	<joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] iommufd/viommu: Publish a vDEVICE only after
 vdevice_init() succeeds
Message-ID: <akvuf1fIXTBY+/Jg@Asurada-Nvidia>
References: <cover.1783311134.git.nicolinc@nvidia.com>
 <1e05999347f4bf583edbc6a1312c857d5548708c.1783311134.git.nicolinc@nvidia.com>
 <20260706172356.GB118313@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260706172356.GB118313@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CD:EE_|SA5PPF8ECEC29A9:EE_
X-MS-Office365-Filtering-Correlation-Id: b4a7bf3d-53df-4d98-1c1c-08dedb8942d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|5023799004|11063799006|22082099003|18002099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	eKfIwIXZ4Iq/3uV2H0HvuKAFRstmEr0nzSQo5D0+5I2wQFILViba4cYmsgf7ijFm29/TV089yC2G+PKigyUyiBDfkqzR1V2bXLGNSudLBYtTeJ5gofo3D1L0u4eaZopjTNiHKSywDg/DNRm88WnB/wwN+ercUX0eWHT/lMSSX52P8texKyYULd9c9HwydZujl51Ie2SoyiY0PHn8UwHsVIJhCVgEMz3ZvIOtAbcTfgO3+ojHJ+Ed+twvds4h29HGvM6r36Zs0pbvn4DUpG7OpsWZHQxShWJ7eNNqagDqQNq0yMdrf95EP5BtVawJ2mnO8n1soX/zGleyLXOZG9nmZHsXqrL+oAYeQ6E0mUDLbiwn94onz+u26uJDFGFl4JQMH3xfdBEFbvMC8TV1VXsoSVDteQKKgBFRMBgpydqFaWDjKr8wDvTixqFfoPss5X9NFzzc60ws6giLRj7NlHaLZY43VM8WPCr6yVmrP7GMtJfhGHwLglezCf/PFK6XZf8NvSKbwq3qnw7zvc65sQuidVX0j03dgh7MYYiyNBzi+HnYEBh15xgmZK1RY6hbNcpwlN3bVgsocDeLcnE9RZIr4XFJs3i/vVKgBjmPWNWY/zoKKiPOsKG3tzRmmor+UXbfKpk4Jj1+pFOS6u6TiCx1I2XWW//bFjyGM7XqjxKTxKOFYq8XxQ52ra4jVD8zjyxvcj9v6PDhOhDGYVfg8c3fyg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(5023799004)(11063799006)(22082099003)(18002099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rz+UPThzitpisBHq61O1mJqW5vrS0NOFfQRL14BBjhVBmfy3GDv69A3wHpUROCQyqowxsmkVRFOwf4qgxLj8mKYjWXGerb6BpMgAgw30Q2wycEuOre/449J/SoJwKdDfPQd8fZGURyNqjTCk38VD2XB5GFt6G7IlvwHLhGXOXQarcbHTumvD4q3ZgUN40oDFwZX9wNzBhL53NARJUbuRvh5YVQjosNHG43vBG5Xs2Fjr7farZuHMm9Ofn6GhQ7tFbJKT2meNAuvyvTynUlpo15JQfRV1yEIePdVOrF9G4clxhgYOvVXF+M7MTd+Ap5OvkpNSKcIIeqGJD8fmrxqX7m/D90ny+7r9zdqEtwH842Hpy9XJrLwXr5Kphbgo/e7DB145YJciiParpKkx/luhSdbuyB1WKUet/yFtptekXIsPqR7/2dctaFi2ySFeaCtH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 18:06:11.1351
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a7bf3d-53df-4d98-1c1c-08dedb8942d6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF8ECEC29A9

On Mon, Jul 06, 2026 at 02:23:56PM -0300, Jason Gunthorpe wrote:
> On Sun, Jul 05, 2026 at 10:36:10PM -0700, Nicolin Chen wrote:
> > @@ -218,18 +218,28 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
> >  	 */
> >  	idev->vdev = vdev;
> >  
> > -	curr = xa_cmpxchg(&viommu->vdevs, virt_id, NULL, vdev, GFP_KERNEL);
> > -	if (curr) {
> > -		rc = xa_err(curr) ?: -EEXIST;
> > +	/*
> > +	 * Reserve the slot with a zero entry (reads back as NULL) until the
> > +	 * vdevice_init() op accepts the vDEVICE. Only the xa_* helpers hide a
> > +	 * reserved entry, so never use a raw xas_* iterator on this xarray.
> > +	 */
> > +	rc = xa_insert(&viommu->vdevs, virt_id, NULL, GFP_KERNEL);
> > +	if (rc) {
> 
> Why xa_insert() not xa_reserve() ?

xa_reserve's kdoc says:
"* If there is already something stored at @index, this function does
 * nothing"

By its implementation, it wouldn't return an error on duplication?

Nicolin
