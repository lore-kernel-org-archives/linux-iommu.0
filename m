Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012060.outbound.protection.outlook.com [40.93.195.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CABC2D2495
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 18:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780338503; cv=fail; b=Q04snCRF7hqpr8jUWi0eGINqsHy0nw4qAV5sZ6pAG6LgqS+SRKLapgWOKJRlS61Exic4wnbKXNqKnpgGF5X9Izp4gHT2e6tOtto/DCiG4mMylPBHuDQH1rFA4dPbXsYM/quX/YRCsDZ5lhildd86y0X8cPJi2CnYxhu61OYAMx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780338503; c=relaxed/simple;
	bh=zo1NeUwCT+t0XgOoV/rXcEFktYkl+7+HdXm063Pr7z8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Th7/2n+EFC5LkZOJHTauXlhyR3JYW6i6rE3agJNea3ti1CqqpafP4hhR4CiETi/TTbzevtbdei3aeq5RIuXUzq2ghRgMl4IOiMI/5TbagxLqcWTzMzr5yzjIwvWTTELcq+N67kkjS+xgkvyzEuzPpolrW1mhnyIrKTSeUKRDgZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=snTLkq7+; arc=fail smtp.client-ip=40.93.195.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="snTLkq7+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dU1CoP3tnxIxtx7C1R6vibxwVMhtTpJySCf2KECKbFZAiqaW6qUNr7G9ZQXl8mgGW3HfT6ItEN4pH/tDjoqUXSA4Xm4AJfzWHa9FSCVbcc+8Ie9QSBMY+1vzs3rZv3ZSVZkDCQhgIZ/8bBO6n91PpaFvo0n4KN9u1pjfx2kWNbSn24fP6MqJMMr68ne/fVzWXj5XhZCTRzBwCfqnqIGr3+D8/Ta3XAtw4WqH43CthbtmelZ+QZd611/hMgjVLNozcwCqkYtPOsA4gLl/4bF4+/8Qy+yS1xzv25CICL9YlJoe3xm7S4d1TgxbRjKmMxtZGcnKLBxiXU1639DCouCnIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QcTIe/1F5e98usd7Ht2vbDLgx8tMIUfYbqnQB29oZdw=;
 b=iBnAb/wpafV1qshHyIkCOjAOYbjq1Um3IUpmghgTzC86Las2c0tEbzdeZb54FJjfXUNoZHsY7rMZqEcTCCnt3vfmnA4nw1ileK0j8wH+kmCZRruoZ059LKs49RArTfO7Qqb2WlQsmeFQzAKP87pQOsevJwv6GpBR3L+3H0UXdyej5z6iE0tVkih/4mkSRh2FqOGsA8Ar/J5xwHlSTOIglvaefXqZo+qpqnRSBlEpgZp/w1Uz/YEckmxQhUy7Lr8gs9FNga+yCjbx83VmHBEnrIE8Cc0FyW+O8aVOUHRw4tXu6u2AnOOIXP0f7GvJPRloF4bydijAEPn/goBu+2TNgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QcTIe/1F5e98usd7Ht2vbDLgx8tMIUfYbqnQB29oZdw=;
 b=snTLkq7+lSDen+ro5ySrWjYAvpWncn4Osritd/NkPsaMALFZy6k0unVwPDIiDbfF0hil9p/YzNEIYy22A+p2ujAdm4i/EYbS8z+6+wmEOcMifdzEZ+l1t/ZqWLv0kqUmn7zA5ZOniXmLIGfFK2O8WX5ENC2cbVk3zgS5kyExQDwSuyWvGK531//PpU1QMzXNBe+wZq5IUWKlRwMsskA3FGzIAqh7PDsR9GuDCrKw6hfJ+zRxuSmB4hAufpEhL1QAlHr1r/pdCOGpbkMNwJC5kpRNQOpW5/JnsVhQY+kT+HaVZHhYSGYSWvt8sXxuaf+BMdiIqcdUcDDnaehc0nXitA==
Received: from BLAPR03CA0113.namprd03.prod.outlook.com (2603:10b6:208:32a::28)
 by DS2PR12MB9799.namprd12.prod.outlook.com (2603:10b6:8:270::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 18:28:17 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:32a:cafe::40) by BLAPR03CA0113.outlook.office365.com
 (2603:10b6:208:32a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.15 via Frontend Transport; Mon, 1
 Jun 2026 18:28:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 18:28:17 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 11:27:56 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 11:27:55 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 1 Jun 2026 11:27:55 -0700
Date: Mon, 1 Jun 2026 11:27:54 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH rc v3 0/4] iommufd: Fix veventq_depth boundary
Message-ID: <ah3PKufmQ7wZEX0U@Asurada-Nvidia>
References: <cover.1779734952.git.nicolinc@nvidia.com>
 <20260601120754.GF3195266@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260601120754.GF3195266@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|DS2PR12MB9799:EE_
X-MS-Office365-Filtering-Correlation-Id: 97880bec-7ab7-4b06-9d3e-08dec00b8ce8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|22082099003|18002099003|6133799003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	UXCccA8EwN47jNbzXlX+VQK5lTC4WdG+K4O5lZIWt0nlPl+oI+uEDXk/TqXzsMQyysxa4dV6numdPeYpKOALUnYVKx7BSC1cSmkamBz6/0TMK8k7+habveVc3LCwV8aG712tY7EHgP3ripL6su43XXz3FAioD5Gh53XD41ulA6XWDnRbon5kmUwd2rpcsdPyXvmE5jf3jCb+fkwUQVllbNwnTDOxIDtO43uP+HT6iqlRmzbQwRH3mWJiWnsD04svM7VaoP2KO/DySYbCFAYIUzrxAdGwam5QiSLujj8SNhhn0UMHXkoHNUC7+mCdOHI7hnXf0B1AyXAuo4BW/0kQB3gvbvqMIcQLJfiQegvdWx1eeFiUkzRmiV4kfaDSgPFRFx5Yf0CEozy1CCq5dsE93r4juKkAgK52lgURIE7C17TaHivMcEjLOpUbLANuEf2P+j+gEQkCa88YX1tSK9Nqg8k/Xh68K5vLXNsWqslpOsXrRTWTqpLYdBTq5LJwf8SCk6OKMjYhs/kWrhVj+9U/ngAYPiwxMRa0pglSO32ZlJtAnfHUYzKp3hnslt5HdSjjINmUSjD59xKj2jtnhGbTIu9szkMuB8U5CWflOGtEntBZckm6D7kJWymdCn07HCQKfj5pLdfuo9Ao+0kZP/ECMpZf3cncZ+dwuVJITcCqSCCDAlk0uEXpcA+JCKDE2zf5NCFsFixWJh7DiWHR/AVGvAY6vRLAe+2BvWZ0krdwcKM=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(22082099003)(18002099003)(6133799003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kUH1uCGK4LhxldbouJnQAPw2ThLvQ9qwyDzMeeOdtjUcSErbk2mUGy5IFE9+ZtNXlw0um5BAy3P5F+28BCwd2RJJ5jz1qYX8opWriWAS3PicoY3j65DLzSZ0j79oJgoLbrPhWzG2yau9zN9r+wQK/Jp7wYPXMWuO3bEmwSE1Es5MjE78a2XX8vyJ9wLvOUuMFJOcLl9ob8gPC69jJdLe8sYEtUXodrovaKi9c+iyHOOWD0sMExFMAeG2uRaLZMEaMsuFxuAYS1wYwYbyZjWK5MUvB0ocZ/Edzqvnb2yERGDT/fkmsIN48LyAu/C31ig798yU8cp3xlkanhLo/LTIN/eCVNFd//WOWRwd2izai631vR14fi/bZNc5P1PADFVnOhPFb1QbwJAZgqnDc8d3fS1dkSkznArK86H/qgIOFXLuY9RARQqYZvsiO322bBg+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 18:28:17.2543
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97880bec-7ab7-4b06-9d3e-08dec00b8ce8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9799

Hi Jason,

On Mon, Jun 01, 2026 at 09:07:54AM -0300, Jason Gunthorpe wrote:
> On Mon, May 25, 2026 at 11:51:20AM -0700, Nicolin Chen wrote:
>  
> > Nicolin Chen (4):
> >   iommufd: Fix data_len byte-count vs element-count mismatch
> >   iommufd: Move vevent memory allocation outside spinlock
> >   iommufd: Set veventq_depth upper bound
> >   iommufd/selftest: Add boundary tests for veventq_depth
> 
> Applied to for-next

Would you please update your remote for-next branch also?

I have a followup series to send. There would be some dependencies
for git-apply and Sashiko review.

Thanks
Nicolin
