Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012068.outbound.protection.outlook.com [40.107.200.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CC1322768
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 21:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776462301; cv=fail; b=B74d8N78cX8iLbQGaCiA0do63xnVTMHIPc9goXK7rVhJkggk8aEbwj6l372nHTfjREB29l5nNqyFYWVy+YXHIm4d+VFevcNYRz2ix9VW2rXNVIKyAzba8TwTjASjE0hX6L2VTcY6f/LM/9diSVLoO0X9LNjUu5g7BLeSSIMMXqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776462301; c=relaxed/simple;
	bh=7+7nS+aM2doM+5BTcDFccunHCFNARcSugMuIIC6g28s=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ayEoz9AYHhcmeFmwPUoc5yBS4ew8b+3shqd2ghN3Muj7Pol+b48HVhtzU/TRwnE1PS93qIXAyA6C+bRA4W+pCz70u34VAplZi1yIrtmR960tCqXkd2qVUlMX6q9p4T6dHc63JQzBa8LbjoU18yyFjQOMOM6KCb2jHx9WHPNqzrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FqdyBf+S; arc=fail smtp.client-ip=40.107.200.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FqdyBf+S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y5sf7h9GzYsFH55uEI9f0SQhWjDZ3eZc9bXtSxd5fSJvKBSvn5Ud0keMDceVHHrvq+5fXqtmzakf145cddLjU5FCQw9I0KSBg5Ld6JmahXUvegO8o9RSjnyR4aGf5wRdWhQbBU6VeutP74fy4jEYvqaAxlbLQUD+jqX4z5Sk6ZbMeKwe6z3CwxiIlAVcNAypZutvN98VdJMuRQDbtiaoePZTeUXjUS6ZjizX81bNn5VZnt8qAMuPzsDvKDryCtqAQ8yzo4hb6EoooDwinX8W1pLD+hxQ6PznoqLoHusZaLIcTbRkeyidhSpiO5RW/CaYDS/2RzXfNkLcrzVo/ieg7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXIwhmVF4xbRtIUDK68i/ab42EOnaBPReNPGuvdwxKY=;
 b=kQSaJWYzngLPT6NpF/ML0BYGKyN3hUt/FU8d/BfwsXKERFMmGbLYmQRC7O0MqWOrb33/lExxGSn+U2N7hMZS9BlmaQOfU6hyh+qJGsTvMeaUxUnNj+lywtdVl5QW0XhTrRZ44oqUv7s0m+hs2a9vKBzu+4VJUKC6/bbDkLbAl8eqA3PMoW9OLv80J02hfNORSKuZtKM8hLQ+vNuwTXKAeEzJxVFwsg71GUYuBU7rGHej1pQQ/YOZIzpHJlzsapw2/IBMK8SsP7r8OHYW3m4lCDUvywZKU8SSNZ6TRMC9I/EcIPp8Ai1PS9fu5/qQZvpK1mpsPC+JrzGCqxTRwszVNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXIwhmVF4xbRtIUDK68i/ab42EOnaBPReNPGuvdwxKY=;
 b=FqdyBf+SUhHgrf3IyczjkVM7hH9/LbMfv2cMZ60nMeF6ToUh/F1Z/0XT0U9oe6KbFdmoG91nQcCguPMBCyIss/p2kfRKxPwxsiSk82mSSdrwT73gziwA28ExmkZXuBGFlSCJmyKozk8fXBZC/ef96APGcKGNA1pdXlhEELq9D66eitM+kXwhKVzQk89r9qSuPu+fFi2S0uH9r31/ZfSlZ9HFk4qDIqtP5vacaNZBP4wR16hLUTKLeZz1dinFWkk1TIplz+qpuYKqJafWFA8000uEFKDzV0FDDyy5qyb+AFt19zniJFH4cocz3E8P6x+Su7bfwW/AYI/Bqngww2QzVw==
Received: from CH0PR03CA0444.namprd03.prod.outlook.com (2603:10b6:610:10e::12)
 by DS5PPF266051432.namprd12.prod.outlook.com (2603:10b6:f:fc00::648) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Fri, 17 Apr
 2026 21:44:54 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:10e:cafe::26) by CH0PR03CA0444.outlook.office365.com
 (2603:10b6:610:10e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Fri,
 17 Apr 2026 21:44:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 17 Apr 2026 21:44:53 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 17 Apr
 2026 14:44:38 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 17 Apr 2026 14:44:38 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 17 Apr 2026 14:44:37 -0700
Date: Fri, 17 Apr 2026 14:44:36 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH rc v6] iommu: Fix nested
 pci_dev_reset_iommu_prepare/done()
Message-ID: <aeKpxLiykT8O4k1X@Asurada-Nvidia>
References: <20260407194644.171304-1-nicolinc@nvidia.com>
 <BN9PR11MB5276D60096EBF15C5753C4BB8C202@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276D60096EBF15C5753C4BB8C202@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|DS5PPF266051432:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c9810d2-37d1-49f1-ef23-08de9cca8fa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	B8L/N5HrPBJHvTvzXvxmCQR5zc5PQpa4YSePUtEvtrmYulC/Dq9Ip3tTMVv+tKL5pWFMRzy4pEVROkt1JLyur9Cnfzi36l1Y9HrLZ5E0ZHe9I2scNq8dciz18GiM9r7zVC/sXUPsAdkTNwEgaR1oqyVS03qH8pTg5NjztQlNbQ2zg+08bM6XyiBdiauoXUEv6i+wtT0oYNzhgZuze06vIwQaE/Esy5fQvWoDZnFzzktS1pu4MwHwyjD9F5qSJPWXM2Ckci+N/7fIgKC+QAAwf743E/3CwSjS7ftkPBGTwBFVSZR/vM1gX8BndcXvW2O/i+PyTGedYZI3iLlTHJOa8R7rsF+e0DXwjSlCk5XkXUD5cnUhuMEncaEPDIJILvdDTi17m1X61WA/lZBf7n7v3h3VtvRAfmRD3Y6VRMb2nT0/s98egk8c4z+hYT3Na45Jcz6+JrC2Af4Pdv0Tx+xM3qu3BBAbi2ExzMd0elZz3LU8qY6QTclcPTeog6CBPOQDmUxca0DDJyWEeHUBJftkCFPcoxOvM97IlhpLqK9vcAgrch/hs1WkgzfZ6faQgw4rI0nZk3wUw60zVSGXIVo8g0nh2o5rn5P63KlPyp28/9EToPHuIxqG3MwMQApm5mkymHrJ9aG8bx5CCJDWTb6YkVZoJqjJ378iWCr5VROO9b3+n0qFY/QiGfG5EKyoDYoXbd3J+25KRu/M79wVoQOg0dcCsodtMpKcP5R3Zm8seroppucH4QWMmn3tnWqNLnGu6Hnjc6941NammZ2jYTM7Ug==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sRi0FftA/4UhyYWrKT5KLBSaS8ALffPQdfWl+K4M6psaNgO/j8qMbygpasTXr5DGsGPK3/sBjJ+JZ/uKrd7WTZWWUa1SqsH0Zglu4TX1vBouWBtWaP5uOIJA1GUAMRQLsGG2tPLdU8JnWLWR6rd5onntBCS8+WXNmPYoRCSp0eVN2sZHm/KpXWX4U6yl8QTlycuLtWWw6ogZ4RJOk6GgzSdQrWCeWiZN7zTr0xsl3oyPgsiqQx1lQVE+iDJq0uO9myJYsGlDSdV/IRWCYmZ/H40c+xzsfUMfZB//BKYjmjCNXF9S2w/s8ecp4QxoA2sse8mbNsNXiYE6Zp+JdOTW7W/3mrEJlkTXuFMV9VofuH1WYz73ZZJKSKC0yxafEtIlX6lzVLnqx9vPaMMB2Ty1yXcC6kdxEhiUd3wStk1eEKR8s9LC1iUSx+EzrNxMzZhQ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 21:44:53.8794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c9810d2-37d1-49f1-ef23-08de9cca8fa0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF266051432

On Fri, Apr 17, 2026 at 08:24:27AM +0000, Tian, Kevin wrote:
> one is that iommu_detach_device_pasid() is not blocked which can trigger
> devtlb invalidation in middle of reset. but it cannot fail. so the right fix is
> to skip the blocked device in __iommu_remove_group_pasid().

Yea, squashing this:
@@ -3556,3 +3559,4 @@ static void __iommu_remove_group_pasid(struct iommu_group *group,
        for_each_group_device(group, device) {
-               if (device->dev->iommu->max_pasids > 0)
+               /* Device might be already detached for a device recovery */
+               if (!device->blocked && device->dev->iommu->max_pasids > 0)
                        iommu_remove_dev_pasid(device->dev, pasid, domain);

> another is a use-after-free concern upon iommu_detach_device() in
> middle of reset. In my thinking it will trigger WARN_ON before any UAF:
> 
> static void __iommu_group_set_domain_nofail(struct iommu_group *group,
>                                             struct iommu_domain *new_domain)
> {
>         WARN_ON(__iommu_group_set_domain_internal(
>                 group, new_domain, IOMMU_SET_DOMAIN_MUST_SUCCEED));
> }

Yes.

> but I haven't got time to think about the fix carefully. 

I think we could squash this:

@@ -2469,9 +2469,2 @@ static int __iommu_group_set_domain_internal(struct iommu_group *group,

-       /*
-        * This is a concurrent attach during device recovery. Reject it until
-        * pci_dev_reset_iommu_done() attaches the device to group->domain.
-        */
-       if (group->recovery_cnt)
-               return -EBUSY;
-
        /*
@@ -2484,2 +2477,10 @@ static int __iommu_group_set_domain_internal(struct iommu_group *group,
        for_each_group_device(group, gdev) {
+               /*
+                * Skip devices under recovery: they are already attached to
+                * group->blocking_domain at the hardware level. When their
+                * reset completes, pci_dev_reset_iommu_done() will re-attach
+                * them to the updated group->domain.
+                */
+               if (gdev->blocked)
+                       continue;
                ret = __iommu_device_set_domain(group, gdev->dev, new_domain,
@@ -2513,2 +2514,4 @@ static int __iommu_group_set_domain_internal(struct iommu_group *group,
                        break;
+               if (gdev->blocked)
+                       continue;
                /*


> the last one is trivial that goto and guard() shouldn't be mixed in one
> function according to the cleanup guidelines.

I don't think this is mixing. The guard is protecting the entire
routine including those goto paths. So there isn't any goto path
that is outside the mutex.

> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

Thanks!
Nicolin
