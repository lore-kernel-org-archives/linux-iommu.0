Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013071.outbound.protection.outlook.com [40.107.201.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA68B3AB299
	for <iommu@lists.linux.dev>; Thu, 19 Mar 2026 21:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773956108; cv=fail; b=dRdCy/ihew1nploI2UbbFju0AS0KaPZwO59Y7TpHyO5tF6PQbQAmLhLs/9cataiDSBJSXsWRO47IwrZNrFzyequdSksNkR82qYi9BvX8h71qY0TkR1r2wPLxhBQsxcMJr7t84KhyeOlfaIcARJS7JHt45uoP+/m57VgO+fpERhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773956108; c=relaxed/simple;
	bh=C7w+j3BD+sDJ1af48iz0v8o57GIcPvJ7eMMyU8ytEdU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+ZvkLuGvb8bBtT1LOHSaqXJs0j6K0+K76RlCVJ+6uF7dZYC/mypVKKjKObbzTybQS3hRnt4gi5SJytNJjbUqDOkIyufqWaCUnuBqb5eMC8PiSxFSg0p1ReElmkQfmpN7Khl36+oQfYuIWzqBjSaIr3njtT9XfksUpOLm61SJ2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hJe5tZlb; arc=fail smtp.client-ip=40.107.201.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hJe5tZlb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hAOAL4Jhn0p4Xe7AhexSNTenN0Y1ZPkVxLz7mpk9Z4EResGfqX/uVMdVqY9/BjS3LzEEJvF/zFH13s5qaKI/XYR+OFoImgMS3zl3Gmddy/TtDFHZQzElnV9S4UVuTKWfUP5TRU51BIr8Gkp+pbb4Y1FWfKujL5SoVIaljTMPvQuMizIu30exyK6E0wbdYFK/kFG1Uhji44UJvddEpqikKS/DS0Lln0xUAH6VPxYn9druNyenPRolzL62SAnl+GgmjiOILfHWNbtVUpJYBv75Ztc0bWkn6z98pmXoapCnMrwn6mITn82THLplxXTtROfkr0ADILPvKrFk3z7eEAwV8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5bJF9hb3DuL9LFcniT2pzGdmXdpCc2s0vL/EeJWPjg=;
 b=JaFLdVa+wNywSsi1XMVrrZhbPOWGtA/flVMNbbR2DS/XKzk4/VKmFvSeTqCQlhhlE2+Ub2p+mLfaI53xaseR3LArDlXaFPUM3wQodWR9LRbuh0lNF5PupIGp/x9YCJN3N4yTHqVPpm2wuGvd4xAw5vo1GMSJtdWKcguEo+5o2iKTB2nRPjarKXAf1RTXG/OETIzf+t/EmgUrcFqEfPtX60p6tgGZSYFYD7KIIGcSeWbVVDKuIeUA9tviZqZ41yisiQu+9+u8f/LHaFefiXbtw0svXW3Fl4/T0Yxlpp6treV5cG6Sb5LxAWVHh8HDOieP9j/CAJxiJRiTkixPPCaD8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.alibaba.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5bJF9hb3DuL9LFcniT2pzGdmXdpCc2s0vL/EeJWPjg=;
 b=hJe5tZlb6JOa7Wwaqjllu/bghyHzRS5kuy5NEoolxTmn5t8qgBJO5sg1wGHf6IDVZxQ5pWbaz4zZBk0czjPznJg906K/kFTKgN3RjC79jL0Xd5Tb4pMO1+50dF6yI79Px+JRoRCPTjNY5bI9SKVOjK9Q+kzgsJvQt1xHqTn4Uy54rTmu0COdO4axCoMtcDRYL+8hPYyBbhUNXGN90ReD34r7qbgzXbqzEYxLRMtUEsckhoUyTHDV/UmuHgUvnY5Q3LOFNK9VY938tI03zgE4WcKR9XJS9WC9OJfXN+gySwppjhrF65PEemnp6JT3RAh9CGzolGvCIQRsCO/KK5i4ow==
Received: from BL1PR13CA0116.namprd13.prod.outlook.com (2603:10b6:208:2b9::31)
 by LV8PR12MB9082.namprd12.prod.outlook.com (2603:10b6:408:180::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 21:35:02 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:2b9:cafe::2d) by BL1PR13CA0116.outlook.office365.com
 (2603:10b6:208:2b9::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Thu,
 19 Mar 2026 21:35:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 21:35:01 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Mar
 2026 14:34:40 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Mar
 2026 14:34:40 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 19 Mar 2026 14:34:39 -0700
Date: Thu, 19 Mar 2026 14:34:37 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>
CC: <joro@8bytes.org>, <kevin.tian@intel.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <baolu.lu@linux.intel.com>, <jgg@nvidia.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rc v2] iommu: Fix nested
 pci_dev_reset_iommu_prepare/done()
Message-ID: <abxr7XrsK1WSmr7T@Asurada-Nvidia>
References: <20260319043135.1153534-1-nicolinc@nvidia.com>
 <dd72f3be-16d9-4386-82ac-1b8e06186e3d@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd72f3be-16d9-4386-82ac-1b8e06186e3d@linux.alibaba.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|LV8PR12MB9082:EE_
X-MS-Office365-Filtering-Correlation-Id: 820bcdd6-444c-4137-4f59-08de85ff60bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	XEkaacvWxa6ftwy7XzlNx/ZNSfiUBzW/byYv52cVHzg8+G+/0sHDBbrAZ53AdlVat/vUfcupaNPQ2jN9SavN8s4X7s51YyWxYzFEyCZOUvPl+8uYzznqCHwEoPQZwmaNACVn9K/SeIjKmbxQSXniR84WhyjSdvCp0dDM+bZ966Sjrej9Ozn7UeucGvusS7KSzsMjJGzGXpklaP9uLAC+e9LdrWgUQ2Ro3ruaMTd7QEhvbSA6OnGt8N6nMoDAcVDcRZDciURPjY2CJ9c+jLuKhMsnoYq50e1pFTz9uakZvobu1DgHuouYf9N9sh8iJ7RJSNIfSrbP6viCbb0Q4M9Ept1qMbJmdsgXeGCCgjR/L41OS9Jc8vJKNqVSNk5BNyqXqC1RUdierVd2TFoS5MOT+FhIBXSYj37i4M9grTpONESObJ+VS1uHWgge2lZYMi9VBY6Igwad6h8VJDsnA/gkTJJopQ9Z+Yjd3/WQoRU3CkXk1NzD5cD2Pr+TO033Co2LGNYSEjmE+x0sMCawUV79o6+5OUP2/YEnzncrCBmFFjivMLSXedvk6gMrbmOXKp/j5ZEfDxFdPMAKlCvp9IJ3wmud2SQnA3YryWXOIa6L9pYit645P/rv4lzewd7iV1Dl75MvXn4NbQ8YAunmJnG22Up8Lf6juKMkWO7nNeAdYYro6qMCiEiSNB4DKOH+RsKzAyS/Hjoh6H/U0XBjr7WCi0ZXjfr2ng4ubzGSwK5MZowrhnjE+ubhAgMEFgKCcM20INiSCt8DSdeROadFGrb2OA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ch97sn3uNfw/zh/l3XC8uzhIgA90f00z/PDPNX/T3zBzTjGFBFa+LvtZC+9pZJ3Rt9+eE/oNYgf7RzM3M0j6rqZvzHGR3nDRQg574YyAXaJWhqPXVYScwZLUqQAqhxgPjz1Wk/NZNChBzjcGRvzF+L9upUL5azp/PUhxY7EmYa7CYTttqG4gUJPfZuNyXVut00gv9oKyGz3Qbh4QexVSaw+z9ZYyoZNZweF/u6jgsy5TeoF0OUnJE/OBFK6AiMhJFDfX9P/dOtrzz0crBhY7ynw2bIv2/xUWdd/68Sx4iVmnJXzIpmW9D+XpPxz9vuSUHIikFrvYeAryCdZLFIlBpk9+ldqi+KulIGvcYL+25ZcYurLbQ4fzIRhTN6DN8ycslk2z5+3ZI0EjebR8lazzEXTuybb0LJceNKFhwuFzrwZn5Y/xMcmJCrBm09jLt8rO
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 21:35:01.7307
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 820bcdd6-444c-4137-4f59-08de85ff60bd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9082

On Thu, Mar 19, 2026 at 07:14:21PM +0800, Shuai Xue wrote:
> On 3/19/26 12:31 PM, Nicolin Chen wrote:
> > @@ -3961,9 +3962,10 @@ int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
> >   	guard(mutex)(&group->mutex);
> > -	/* Re-entry is not allowed */
> > -	if (WARN_ON(group->resetting_domain))
> > -		return -EBUSY;
> > +	if (group->resetting_domain) {
> > +		group->reset_cnt++;
> > +		return 0;
> > +	}
> >   	ret = __iommu_group_alloc_blocking_domain(group);
> 
> pci_dev_reset_iommu_prepare/done() have NO singleton group check.
> They operate on the specific pdev passed in, but use group-wide
> state (resetting_domain, reset_cnt) to track the reset lifecycle.
>
> Interestingly, the broken_worker in patch 3 of the ATC timeout
> series DOES have an explicit singleton check:
> 
>   if (list_is_singular(&group->devices)) {
>       /* Note: only support group with a single device */
> 
> This reveals an implicit assumption: the entire prepare/done
> mechanism works correctly only for singleton groups. For
> multi-device groups:
> 
>   - prepare() only detaches the specific pdev, leaving other
>     devices in the group still attached to the original domain
>   - The group-wide resetting_domain/reset_cnt state can be
>     corrupted by concurrent resets on different devices (as
>     discussed above)

That's a phenomenal catch!

I think we shall have a reset_ndevs in the group and a reset_depth
in the gdev.

> If prepare/done is truly meant only for singleton groups, it
> should enforce this explicitly:
> 
>   if (!list_is_singular(&group->devices))
>       return -EOPNOTSUPP;

-EOPNOTSUPP will fail ail the PCI reset caller functions, though we
could change them to ignore -EOPNOTSUPP or we could probably do:
	if (!list_is_singular(&group->devices))
		return 0;

But I feel this would be too heavy for a bug fix.

> If it's meant to support multi-device groups, then the per-device
> vs group-wide state mismatch needs to be resolved — either by
> making the state per-device, or by detaching/restoring all
> devices in the group together.

Per-gdev should work, IMHO, at least for this patch.

For iommu_report_device_broken(), I am thinking we could still try
a per-gdev WQ, by changing the mutex-protected gdev list to an RCU
one.

Thanks
Nicolin
