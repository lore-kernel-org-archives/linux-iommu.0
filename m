Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010021.outbound.protection.outlook.com [52.101.193.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8236C30BF68
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 20:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773433189; cv=fail; b=A3uE3mi05552KW9bUKXd3YcPxRNZz8JBy2VqIFHYkjnDztZpn45u/r9P1Y7YdMGo3F5WwslbMP/PaSecFx5PR5x/po3YagIefRqqorG2Y2b4jr+bO/s4/gGDSjI5Ymfz4H4oASH75SpybwcHoEMLLXD3iPw+T/WHp+SrcTMB6co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773433189; c=relaxed/simple;
	bh=3+Q/Mh3iWV+AnRRHfwvJ9qubhhW9tgcFpKbRzEpKCmE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FV6+aTzrWB8S9Ke/OyKKVWB6b390AE4EcSaM4XuH3pUUrIwzdrMRcaSVGnPeQ0q/RFnqlmqGwtSOSQBCQPL6Rs9taBW3symbEeAsYunFuuI4dLg7rt3e25Mfst/rq7feWr3v26RBTQmpg3aUGjWHMMi0cKxqjKLW+47VsGOImZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qLQPfrSu; arc=fail smtp.client-ip=52.101.193.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qLQPfrSu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZHLJ/XAmxvGvhSjTrtOEQZoiVPkCHSagvobUoIyT1cl1eIL3p8RiH8GjrXVaTFKKKVBnWbcecFScibDHgoHk6wueDTOhd+f1NvKGvvkPZVK0/h5+AXgDU/+PGh+GDHrMpskKUZ66V9V0kjrsLkIetpFWtPyOsrHAETR89SgCrVZQWAVop0T5BKYfIJ4b9pSslMHOypvjvCDg+Z+WkQS55VLXYZyaGbUEths4eFS0ho9rS/dDb8YpnfWUIiFMcQkuPVgxjdZrYhL/fT0xznujnRuu7XLqb3PL8ifkvvEU4YVmsTtfVEsjIwkLjcfYIQRU2PtWgWCt+LquiQi/8xMqXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5RPO8EweR+XYYZbjlCPhU3Ks3HUHdWTfIbEh3DDy9Y=;
 b=SkmBt//lOZKwU6yANlnCiApsc5XMSCpjyG+Zs6zKwUWCk1xo3k3eDsjcY98YqNrEerXSWzQTdrOhD/6jUwVH3/naPaPs09jCO0a7GevSvQWMU0adKHIyLv0+LXLI09crobiq14hZvTfeO2kRYd/XQNQVL/Lr9WA/4zsO3Iy52HfWWxCZhqVXLUUaMd3gnmUbtly+yyb6fimb5EuZ0zJ48yEjqhKByzQQil+/zAQROhKIDNcjaNL40KeDIk4Itubs15Y++kE6GOd0Nb78/e6idVQPpumrgLvm1OX7/mowAYgz0TVgsdpqHIbPC0UzHI36B6nFE1VqK3t0YllaJtnCTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5RPO8EweR+XYYZbjlCPhU3Ks3HUHdWTfIbEh3DDy9Y=;
 b=qLQPfrSuV5sHYgU1ZTNVN/SfM41Wekby5vjSdHINGhqKCgBqfJZ29A5qFr+EYHm7lfUgzASsIKM0airoNTFLGN/GiysXJ07IxrOxoZ3BAZ6t4qnvb8mT+X9x3B1QJPVu7wjafE7HkPMpaS5xfnE1G42yOjtu9VkFvNk+kx/zfHkztOgEtEUaWlFiq4dCc8I0JunBR5pAIQKWDBHeSkUP6URsda+pknExiTueXz4j1hSnIcUtLii6peJnY6GYmlNqvfYdg/CrcBbAhumtabZgr4zNBPQRTIwAsELxRQPHwmOxlD8UiFoOTll3zk+u8JADnGF+X8K4Q5vVBwylHGm/tg==
Received: from CH5P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::9)
 by DS7PR12MB5815.namprd12.prod.outlook.com (2603:10b6:8:77::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Fri, 13 Mar
 2026 20:19:38 +0000
Received: from DS2PEPF000061C7.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::33) by CH5P220CA0015.outlook.office365.com
 (2603:10b6:610:1ef::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.17 via Frontend Transport; Fri,
 13 Mar 2026 20:19:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF000061C7.mail.protection.outlook.com (10.167.23.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 20:19:36 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 13:19:17 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 13:19:17 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 13 Mar 2026 13:19:16 -0700
Date: Fri, 13 Mar 2026 13:19:14 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Qinxin Xia <xiaqinxin@huawei.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <jpb@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<wangzhou1@hisilicon.com>, <prime.zeng@hisilicon.com>,
	<fanghao11@huawei.com>, <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [RFC PATCH 3/5] iommu/arm-smmu-v3: Add Stream Table Entry
 display to debugfs
Message-ID: <abRxQqNlGGzcbkim@Asurada-Nvidia>
References: <20260313104351.3502293-1-xiaqinxin@huawei.com>
 <20260313104351.3502293-4-xiaqinxin@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260313104351.3502293-4-xiaqinxin@huawei.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C7:EE_|DS7PR12MB5815:EE_
X-MS-Office365-Filtering-Correlation-Id: 096461ef-e1be-4282-5c03-08de813dd8e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	s+eR0H7EhM+3jThmoNnqULLayC8gtdTAR3hxN9D7tk1mxfb40LBXsAIqfEJORO7rbs9Y5V+qf7UgFo4swEtGLz7FEWMsYvIKBsLHEh+amkZkwGtM57Q2qeFUzwee/rO5lQrbr8G8VPSPDOoWSN0MWfzY6cAWjUsR6DqwKC8oMAEFv55TcXOSzyC9MqPwgi15uI0arm0kVE0a2q9W8N0NrBlT9cD4jL1kW3OP1kv5MsAHtUfXJ3baMGq7EglFhDmMKkmiD0WySDIkO184ww9k0izdJRBbDqDn9zPyU33XY0iwK6PFXeY8Ne3KCtS3Ln3w16FVyRwkVz2yUv1rVsZeB6NGBCFKBDF2eAA5aq38d6BFguJl/h64h7z212FrAwstWeP6E5z5JxKJVv2nYBw58zK+FRg3Iism+9huoLui3Qyld2anWwhUPtR6+1ABxmZ2egn4CZ12cNYAub1Ok1aIb7uYuyp3j9eUa4ycjrt9UvvjVIp/oEtml6zQMSVB718DujU/YKyIi3F4vsW0PA3lIYOMteAfrV/rWl4jodHBOJQyO6az9fn4SrruBBxxCe3LOI+0s+84xI0RDdgDenXDzZgqSpspqpxo22PpAIoWv1BHUt2CRNfcAvuDoeuYbBThD5qFFdajgVu2BDZrIPQ3Oajw1mjw+3XTXSywAAlgzBXIcBxFkDWR/A8uUrgXC2yHQQ8qXptyaKL8l/tKlTEYCYF3YvQ+r2eI4Y+hFqtC3HZP1pmSDaaJHkHHlDvaycusJvlG4FD5NBydPpNCnEGnVQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ykANuP5YmN+WePXF4rx0SiiMecQH/YD5Xz8bJbxitLYl3TJPHm/V7HXE7FfFKfPOj7xNJkKKRPgWuWgqsFIMflcyk5hUAod5TwBKv7tTXd95tuMq7UDkKS9fiufTZjUyQ8SOIrWav2CD4YOW6FCvJDDdsk+h7HY2rsliRgDJc09CfmF3q1HxhNQBFjINOvms9G9QBoyiPTbGiX2dqi230XGAD9iXb1lc+P3964LOoW86AsWDEHV1BJ7Jlyb6czOEtOg1RKIf7HqiYSs4MHtKFRplwW+EsrOfJ8dJb4fwmy260Gi+Mnu4BkXo0fzdRstQz6s1syfyEraM/5OaEvflR3uXLUy0X9TXUSuXRbBzCQF/2BKqNSaW2tlghEnLPcfevczp4FfzyI4LRtyjLgLucohey8eDpL88ECxUJ3MpltaZ4V0dFDVjYdunMigUS/A9
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 20:19:36.3627
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 096461ef-e1be-4282-5c03-08de813dd8e6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5815

On Fri, Mar 13, 2026 at 06:43:49PM +0800, Qinxin Xia wrote:
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c
> @@ -43,6 +49,8 @@
>   */
>  
>  #include <linux/debugfs.h>
> +#include <linux/pci.h>

It doesn't seem being used (yet).

> +static struct arm_smmu_ste *smmu_get_ste(struct arm_smmu_device *smmu, u32 sid)
> +{
> +	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
> +
> +	if (sid >= (1 << smmu->sid_bits))
> +		return NULL;
> +
> +	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
> +		u32 l1_idx = arm_smmu_strtab_l1_idx(sid);
> +		u32 l2_idx = arm_smmu_strtab_l2_idx(sid);
> +
> +		if (l1_idx >= cfg->l2.num_l1_ents || !cfg->l2.l2ptrs[l1_idx])
> +			return NULL;
> +
> +		return &cfg->l2.l2ptrs[l1_idx]->stes[l2_idx];
> +	}
> +
> +	return &cfg->linear.table[sid];
> +}

arm_smmu_get_step_for_sid() instead?

> +/**
> + * smmu_debug_dump_ste() - Dump STE details to seq_file
> + * @seq: seq_file to write to
> + * @dev: device associated with the STE
> + */
> +static void smmu_debug_dump_ste(struct seq_file *seq, struct device *dev)
> +{
> +	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> +	struct arm_smmu_device *smmu;
> +	struct arm_smmu_ste *ste;
> +	u32 sid, cfg;
> +	int i;
> +
> +	if (!master || !master->smmu) {
> +		seq_puts(seq, "No SMMU master data\n");
> +		return;
> +	}
> +
> +	smmu = master->smmu;
> +
> +	/* Use first stream ID for debug */
> +	if (master->num_streams == 0) {
> +		seq_puts(seq, "No streams configured for device\n");
> +		return;
> +	}
> +	sid = master->streams[0].id;

These might race with release_device that would destroy master?

> +
> +	if (sid >= (1 << smmu->sid_bits)) {
> +		seq_printf(seq, "Invalid Stream ID: %u (max %u)\n",
> +			   sid, (1 << smmu->sid_bits) - 1);
> +		return;
> +	}

arm_smmu_sid_in_range() instead?

> +/* STE debugfs file operations */
> +static int smmu_debugfs_ste_show(struct seq_file *seq, void *v)
> +{
> +	struct device *dev = seq->private;
> +
> +	smmu_debug_dump_ste(seq, dev);
> +	return 0;

Could unwrap smmu_debug_dump_ste().

Nicolin
