Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013051.outbound.protection.outlook.com [40.93.196.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3857B65192
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 18:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790791951; cv=fail; b=MqTIMYcgNgzhSpQJAtp8uk2dhTlnybrZzmb7LlYqaio5gFhEFlkkvKRGRIy+iNUq08P34IsqlhdcP25pilWHdMYvcf5PSbau+hBo+6HzY639g0Vm/O/+3tlFRuh8TGM7CNfPJfvEtCsurgg6IgrUGerHNVgkIIg5gcuqSdK4B+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790791951; c=relaxed/simple;
	bh=SsNh2xiQ8Y3/CBklSOm8dmLphqaHkeECk42/Q4pyvLM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUUFfscJ/pq/Le7i5K4H80CYmoiViGmqd1vF4fEZfpL+oJpDG56CTbMnoZHSCXjYfN2y+jqKYPv1m+k6b1TCVksPA3p6w14aO2rVI/GblH1lNt4XNefqyvO/xKW0V1/K8TghXRRvK4Epbxs3hTJUCfAC59vFQxHiwyQGhxl1T9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DDe2ahDR; arc=fail smtp.client-ip=40.93.196.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DDe2ahDR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wt050UO68/gnObmRp0lKIjMrFTFugswaOczqNP9HhZZ6R6xdb9vZ/4huCAOdvhjTZTOkMHZ2siK2XkhF3iUZ7SdKzyL7XgGIMPm7scHUzkba6Get32JP8jOojyo1YP7HFjjY1OaX8QurSj1XimvlZcW5ytJVmjEIxQ4RPQhvcin8SRqJW9xJTeGcpWqWkRLtbmpRHASdOL7zJEEbIb8oJZH8hM/1zNlfjJyoy+iGMKxt4Y0GYuTPDYeuWpLmkvx4uNl8yoNc7/K/wgo5EXkne4M+l9rxkqNvK5uDKHhHC6v0XFEuwlvau+7Y7ypQuNQb0GnKADjEQcCxnG0BjsNLmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MlVNtksnZMNArGISGJluDS8pd/34+GDyaZ64wnMYQmQ=;
 b=iY/R5TABeiw5wDF/ILP7ezavocuQdL4RKN13L8/u2CaZfNY4Iwzo39JbNPuHbIbmX89QgSftrbh8fSDUhhK28wqZGNJDFrYMa8vWsdMsrVqo6r/kFfw80wYLilI2a1KQ1sOIDDFF+d1pZJ9d2VXZrgqOZnr9oGXiO6UMQ7qOHY7ZSC3ZWeAOOIyx4nMfD1uTlGUPx4TTSpH7wOOXSea8sfqUhIoxZdUxX8NmnqoEpi+ZAzNiXZtF5ykDw99u1wdcUGAVYAypMb4kcs3ilUNmVY5MJASZyIswABLSTwBHxMC3DSIk2E0PQy+eFRXJjDmfUZxuI37K9QSk55PaKauHYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=oss.nxp.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MlVNtksnZMNArGISGJluDS8pd/34+GDyaZ64wnMYQmQ=;
 b=DDe2ahDRuh/aWnAPVhoYefHVM8hj8/HoO+SAwVAlU9AL76hRA+8t1Cu8FusGmW3au2MplpC60VqvbZ2nqvETVECufOC1Fqntt/46+FgU5OqPyGEEU85L81i1YpIVykBu8Nq8WZd2WfdjZPYEoQTRVmTW4z6FNE/2xqTjs7mFBGy0jvd+2gXkPx/wyPYoAEZE+qcHZmxkSddAyT5aJ83y8SVouw41xHXLDyyF2Pr19kF2GrfeRQF3sHtmqNGDe6bSY1JLwN+J5hND04XI0h6JhXUbs+faXqGCl0gkAXpCq41Zx00c055iHwFH/wParYEt0498sn53k8IwafskakasWA==
Received: from CH2PR19CA0001.namprd19.prod.outlook.com (2603:10b6:610:4d::11)
 by IA1PR12MB8357.namprd12.prod.outlook.com (2603:10b6:208:3ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Wed, 30 Sep
 2026 18:12:24 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::66) by CH2PR19CA0001.outlook.office365.com
 (2603:10b6:610:4d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 18:12:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 18:12:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 11:11:56 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 11:11:56 -0700
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Wed, 30 Sep 2026 11:11:54 -0700
Date: Wed, 30 Sep 2026 11:11:51 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel (AMD)" <joro@8bytes.org>, Jean-Philippe Brucker <jpb@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Peng Fan
	<peng.fan@nxp.com>
Subject: Re: [PATCH RFC v3 1/3] iommu/arm-smmu-v3: Support shared SIDs in
 insert/remove_master
Message-ID: <ar1Q5y/xoa+Fcex7@nvidia.com>
References: <20260930-smmu-shared-sid-v3-0-8abe6c1b4c20@nxp.com>
 <20260930-smmu-shared-sid-v3-1-8abe6c1b4c20@nxp.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260930-smmu-shared-sid-v3-1-8abe6c1b4c20@nxp.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|IA1PR12MB8357:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d3355d9-241c-4d3d-891c-08df1f1e60b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|7416014|20046099003|22082099003|18002099003|13003099007|4143699003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	aeyoFC8LSfb2vB38aEDOac5dzJUU8yM+nPgJBiQZdqq4GmYVllbNhUO60wZpSNPNc3nNvBkEr1R72DhdPqeBi9fY5bJHkpDLZXJB0tFEOeW1/uPlaFH18B+FhC1uYkAZPlvS/hqB2HZGT0feu7BVjizt/z2ful5aX309Z8mz/8cYqqFK5+D+d1OTGfC+M17ZeYOijk+6jSASyS0irF9p+JlXsR+kAmsgoFNGFgSzEgnC2CuxlOLDK19cBd2BPh8Js5hBigA8n89ERha/0gnzaVO2c5hIGr+16ScrbcjsCSKQW928AGJyJoEaPIOLXYHcH2Fmr5cDbrAo/U+CaPUFe3/Rlfk4KLZI2FSUL1zMo/owdJuLhVFozK9KshvEkkINcOIM/iIKi6E/6gowoNpm1NfBJkH7fGC+++CLbBN9oV0bqTin9aKWXIAeCAkzoZsjGsr3KpfPmqF3xmxh0mXDGgEh99zYuUWupbwI8MpXqlOG0TriV5GF+64jCdFnzT8CBuI+mvfBNtFBRy36IHWPiIpdfR+Qr7fHsQOLw4RzmCqh+9PAQk3zakPme8FyXn7QH9zQHg3w4Rpix23907L7Ew5a/xzoYAm6OvztNPD08X+Mz2vDF27qrsiwjO4UKqdFbp96wCoKgBu5m4dVXRYNhiHCWT9D2QWOMohpXboc49EIPqfLqQUpmp0RYgtU+wdLg97l8+HSBgN3s0iKH/EVmQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(7416014)(20046099003)(22082099003)(18002099003)(13003099007)(4143699003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Zk4Trw0nlEichuXutExvHrHqogIA160jyyfVRj+kfVW51xRRsAQPn5ZrukT6OyOELhR5Ag4/Is/YTDBRWxhiO+PiaAEpCRGmvN+dsb0bmyDvyvYLShq5Jpfr3YOhg8VNg9xrwPCjT6HMUTBoacmidMq1J7yGMyNMHFELc7BgYyDXsUJycnGS4nTAlGkyi1ZYO0bFZJKswWNj5IZmtooacJM0fzUhAfxJ2wyBrnfsw1eGiLTeoArpBJCmL6v78/4pxXbhCb6nwm1ByWCofrALTuU23vGZkiF0OH0YWEXUCCQUXm3dP14yyAq8NE3cx3um6IeLhAsbnoOdgxFnQJlXz6qVQLCM3N6nnxW5aRwEI75PIycRXXypjKhw/Li0HbZkxWngXDBEvK7FD+Wqkmles1qtmV1kxNj6eBvZVh1WfXwCVkM1kxXbo+X3jqO0Q16R
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 18:12:24.0236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d3355d9-241c-4d3d-891c-08df1f1e60b5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8357

On Wed, Sep 30, 2026 at 07:25:01PM +0800, Peng Fan (OSS) wrote:
> @@ -4115,7 +4128,10 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
>  
>  		new_stream->id = fwspec->ids[i];
>  		new_stream->master = master;
> +		new_stream->ste_installed = false;

ste_installed is zero-ed.

> @@ -4136,23 +4152,29 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
>  		existing = rb_find_add(&new_stream->node, &smmu->streams,
>  				       arm_smmu_streams_cmp_node);
>  		if (existing) {
> -			struct arm_smmu_master *existing_master =
> -				rb_entry(existing, struct arm_smmu_stream, node)
> -					->master;
> +			struct arm_smmu_stream *existing_stream =
> +				rb_entry(existing, struct arm_smmu_stream, node);
>  
>  			/* Bridged PCI devices may end up with duplicated IDs */
> -			if (existing_master == master)
> +			if (existing_stream->master == master)
>  				continue;
>  
> -			dev_warn(master->dev,
> -				 "Aliasing StreamID 0x%x (from %s) unsupported, expect DMA to be broken\n",
> -				 sid, dev_name(existing_master->dev));
> -			ret = -ENODEV;
> -			break;
> +			if (master->num_streams != 1) {
> +				dev_warn(master->dev,
> +					 "Shared StreamID 0x%x not supported for multi-SID masters\n",
> +					 sid);
> +				ret = -ENODEV;
> +				break;
> +			}
> +
> +			list_add_tail(&master->shared_masters_elm,
> +				      &existing_stream->shared_masters);

This version still uses the duplicated stream structures, not the
shared stream structure that I pointed out here:
https://lore.kernel.org/linux-iommu/arG6hmng3NddGEHm@nvidia.com/
?

This will have problems.

  master_b->stream[0] --> new shared stream (SID=X) {shared_masters}
           |
           ---------------- shared_masters_elm ----------|
                                                         v
  master_a->stream[0] --> existing stream (SID=X) {shared_masters}
           |
           ---------------- shared_masters_elm -----> {NULL}

First, the owner (master_a) doesn't add its shared_masters_elm to
any shared_masters list. This would fail the test on the owner:
    !list_empty(&master->shared_masters_elm)

Then, ...

> @@ -4167,14 +4189,38 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
>  {
>  	int i;
>  	struct arm_smmu_device *smmu = master->smmu;
> -	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
>  
>  	if (!smmu || !master->streams)
>  		return;
>  
>  	mutex_lock(&smmu->streams_mutex);
> -	for (i = 0; i < fwspec->num_ids; i++)
> -		rb_erase(&master->streams[i].node, &smmu->streams);
> +	list_del_init(&master->shared_masters_elm);
> +	for (i = 0; i < master->num_streams; i++) {
> +		u32 sid = master->streams[i].id;
> +		struct arm_smmu_stream *stream;
> +
> +		if (i > 0 && master->streams[i - 1].id == sid)
> +			continue;
> +
> +		stream = arm_smmu_find_stream(smmu, sid);
> +		if (!stream)
> +			continue;
> +
> +		if (stream->master != master)
> +			continue;
> +
> +		if (list_empty(&stream->shared_masters)) {
> +			rb_erase(&stream->node, &smmu->streams);
> +		} else {
> +			struct arm_smmu_master *next;
> +
> +			next = list_first_entry(&stream->shared_masters,
> +					struct arm_smmu_master,
> +					shared_masters_elm);
> +			list_del_init(&next->shared_masters_elm);
> +			stream->master = next;
> +		}
> +	}
>  	mutex_unlock(&smmu->streams_mutex);
>  
>  	kfree(master->streams);

.. when the owner stream gets freed with the master_a, the shared
stream would UAF:

  master_b->stream[0] --> new shared stream (SID=X) {shared_masters}
           |
           ---------------- shared_masters_elm ----------|
                                                         v
                                                      {freed}

This should be changed to the model that I suggested in v2:

      |---------------------------------------------------------|
      |                                                         |
      |     |----------- shared_masters_elm --------|           |
      v     |                                       |           |
  master_a->stream[0] --|                           v           |
                        |--> stream (SID=X) {shared_masters; master;}
  master_b->stream[0] --|                           ^
            |                                       |
            |----------- shared_masters_elm --------|

When any master is removed:
 * Delink its shared_masters_elm
 * Free the shared stream when its shared_masters is empty

If shared_masters isn't empty but the owner is removed:
 * Give the ownership (stream->master pointer) to the next master

Nicolin
