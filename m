Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2414E31E0FE
	for <iommu@lists.linux.dev>; Mon, 18 Aug 2025 12:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755521541; cv=fail; b=AscjdzgeaSBahILDNp+8axtI38DPPx/g1tWB4+UtEvreuhwHcrpz/1iouiySZekuLqTfB4xvR0fH/dKhLcESPmqhxA6Ip3LiZ2eJB+BuoqeMzfjuWtGQWG1iNG1pIRzWisUm2s/htN80vr2LutWhrxJwF6HsBBjGTVbMMe/hiiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755521541; c=relaxed/simple;
	bh=NJQj4Afp7YNM4uT9GDzMlURt3eR0bJqdipw71MWUfkc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7Hu0Mg4aSgvXrsbBw9B7YqefsBNLdnOBabm2zi/szaUbe/Pyp6k7pYWJ0oNRcvTJu4rWPT9xkv6ErfVkuua4IhSVfW6+9QtVLnmog0QHDEFp8zOh3D85XjwbFq/yRiRO/dr83F+ds/vA8x52B3KFrw9yeTbN1pTcLDbx6IshkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xeg78BHp; arc=fail smtp.client-ip=40.107.92.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xeg78BHp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DB5NdNMIP2pZRBQu1Sm258GMR/+iug6pnH5TXkIxPeFcg9mA8KaSZk0etLvJDD+JRp8A9KD4GjQRUZ5mBGPvLBts3i1gAVvlxm1KaQjvFF+BtmaD8BCGiDGfIyQZPKMiEeXqgenRYrN3Rq6nkELxmk6R7mr/gAaQI2IUn++hja4qnMG6Di9apUhKCW5ue4G3+k3JM2s2YqMKMV1YpoDJjtY7kMI4Pqkd8IijkCbrUqng1kBKRfXWX+Ix+4ZxMBTtoikb8xJjdik0RwMdZwAPK0SxBpXS7gsiRx0YA2fbe8gigvBtEfqQtun1mqBohiMmTd/Cf/mXmNjQVsWqK0pDFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlKKXOYwC3XViWgfcfOZ0t3ce10yFSVBjCdnPWT6HlM=;
 b=F38KWpGtB7cc6VfQcrOkRZekzy5Qb7NA6s93tBSJx/wjJmy5Iw22ACq0JBMKobx3SUzqSUx0SSbdsTnxfryCvBMYEsbE9yehLkAUzIpSAEwnI1E61w9VVE+tKLSei1+A2nXGkxJyPWzvPEY7mG42EkW5TnhZMuZWZjCheiZs37cC2w3UwbUnOfsPQF2ZkdFDw8DCweeA2RKonjjAQc8Y9pEW58fI2cyfkrctjNvLmm82NwjDyEHMhvNwr/Y4sXt9/VEWyKbe00xpCFgPmuNDQYzYAlK8A3PeQU+AWFU7N/ff7m1SZKJZodiDjtJcW9ayrLUZGWbIIvkNN8r6Gis8uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vivo.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlKKXOYwC3XViWgfcfOZ0t3ce10yFSVBjCdnPWT6HlM=;
 b=xeg78BHpIPracWuTZtwhsLw1SSe1WlF7i/DzPT+gJEBf33e/GIoShb1pI5+MppRnEKBGtx/mr8yb5+Ywnb/Iy4rY0xVYkaC3bTnDVtVcBc6mRVPmQSebnYo3FAiZMNKnAPPR785Jyz1a0ftlF9LCvIxbSAzkWA+mdB9anY63G1Q=
Received: from CH0PR04CA0095.namprd04.prod.outlook.com (2603:10b6:610:75::10)
 by SJ1PR12MB6146.namprd12.prod.outlook.com (2603:10b6:a03:45b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 12:52:15 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::5b) by CH0PR04CA0095.outlook.office365.com
 (2603:10b6:610:75::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.19 via Frontend Transport; Mon,
 18 Aug 2025 12:52:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 18 Aug 2025 12:52:15 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 07:52:15 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Mon, 18 Aug
 2025 05:52:14 -0700
Received: from amd.com (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 18 Aug 2025 07:52:12 -0500
Date: Mon, 18 Aug 2025 12:52:06 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Xichao Zhao <zhao.xichao@vivo.com>
CC: <joro@8bytes.org>, <will@kernel.org>, <christophe.jaillet@wanadoo.fr>,
	<suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iommu/amd: use str_plural() to simplify the code
Message-ID: <2ja2sy7xnwdgjum4e5d4xutqzxh6vkbcidn22uc7hkye4lnnrh@2nwur4tgjtrf>
References: <20250818070556.458271-1-zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250818070556.458271-1-zhao.xichao@vivo.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|SJ1PR12MB6146:EE_
X-MS-Office365-Filtering-Correlation-Id: 088e2c3a-07fc-4565-8060-08ddde560ed8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QdzqzDkaUKfBZR1ZpOWGa79IbOFu6xPeVsfCEErrrbXIlzpbGOs6X6XXpbuZ?=
 =?us-ascii?Q?nqXU1uMJYhBXNpWClpsT1OJaOgvHwdpJXmmN2B58cPQpCRLM9l7Es94yGDbQ?=
 =?us-ascii?Q?N8myWOJmrn0bQ5xnaWiKECDGRJrK38W1vy8XspZ54HwyGNjdvBSElvAdOTkP?=
 =?us-ascii?Q?ZSpiyG8DL5u6D/aiL4du6Tn3jL6+OVr18xA9awFJ1qJQEAS0Bw84Y8MBK/I2?=
 =?us-ascii?Q?EimP+ho2mUG+XjsibSdmRq9l0aBNhqzZ+b5Ba1m36xn+FtIjI4ho2Ud0nmMY?=
 =?us-ascii?Q?1p6b47WibTlnvcqAcFMjwZNCtXY/KUQcEzYAmpYawKMcd76oyxLfzDetuny3?=
 =?us-ascii?Q?qnJFo6BvsBhI3G2YGyuA6LtdYjYuIY5QB7yULYnGqssQZXZ7xDsHJpFw5Cb1?=
 =?us-ascii?Q?yNUoV2oLQyUOgNlnCGruAr4tzXLKykJRF2TX8+Bd+kMkUv67a5Fh3u+sjQ+A?=
 =?us-ascii?Q?ITW+0zKf/EHlkQoqrqlfT2Ue6R154ARtL4CiGH6r7GzoOiK/+exeNucl5ob5?=
 =?us-ascii?Q?gX4rsJMCTY+YQxjA8jnFxUl+1bQjbOXW+ejuXh+FQOujyIP95AAWavJXZ/UH?=
 =?us-ascii?Q?S782Ym5itLj9wHTtFTUYMn8kG+pRHsuGhDsxRu3/Gu4GtQn/l3a9PBfYgC65?=
 =?us-ascii?Q?p/T9da16DmKcZgQ6b/bCNZh5xvUANqv3gXRqeBJnwVYOIGC8V2UoVPqm8zCc?=
 =?us-ascii?Q?jRqNLSEO26BVRmJ1houw01a5OUjG/ixs2P/tXA0NbAZfTSuf1nAtYbELYvKo?=
 =?us-ascii?Q?/Xh3NENNvSxEPeEoabVHjYJgSZa1HotdpFux7ioi6l5HfF7cpjGLwBirTDqp?=
 =?us-ascii?Q?WKdfJdcnO1VUJ+IfUpOYqON40+HUe0KzXKhQYFiV3Yl2QeL6YGQz9LPj/5V4?=
 =?us-ascii?Q?fT9k3NVSzgGwacUM/xHMTQUIowzhBbBWKKvq10NMMfTMJZAnLSkeiZri0B1n?=
 =?us-ascii?Q?9u8dWlRTx1y+NE3zJ7OQPoFJeq+tXd9hu4hyJMCtyhYhR2H+g4ru7szlaaXL?=
 =?us-ascii?Q?RhAlRoCyK/2BPcmbg7I5WoWxYGyrIbkpgqIT394LsXjjzfCQSR0dT8gzvdO2?=
 =?us-ascii?Q?eQRl/7BDMY+XF1YuB1Jmb0eytRmO6aCX27dF0gN9JvUGt9dGHid5BmGXyW4m?=
 =?us-ascii?Q?GisjoZZPBxLs3ftvwKccKyYYc/OdBPVklfNfLayj16veYdDL/pqZpXttAtZj?=
 =?us-ascii?Q?0yLy33mINgThCy2C71ktZpH4MtSh4LfOZ1/EI0ntEdj2Nnd3tW0sIYQx0U2Q?=
 =?us-ascii?Q?u1vpGOKr3z7egr4YZCqK+jwlUmtjJgVF3vK7JO3T0o4NFoKfKBM5VDeM7lnn?=
 =?us-ascii?Q?IXKDHuLaKC+8ysM/a+Lyqr4VmoGiF6iVlZgEhRc66FSUCa2NzvH4BzgG7DfQ?=
 =?us-ascii?Q?YarBUXjYpUzJtY3jqvuEiArNFMN74CQ7OZKFbAiLCkJXh41V48DSBIbfBcNk?=
 =?us-ascii?Q?FyXrqUDJWAGNp87WkahcKWhHrjgqky6RhD37bgkpODNANI745FpLgRrVGtqK?=
 =?us-ascii?Q?LZ5fkelfQOyKjLkPnLwTJPcXqwhIIaCm+ALV?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 12:52:15.3555
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 088e2c3a-07fc-4565-8060-08ddde560ed8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6146

On Mon, Aug 18, 2025 at 03:05:56PM +0800, Xichao Zhao wrote:
> Use the string choice helper function str_plural() to simplify the code.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>

Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>

-Ankit

> ---
>  drivers/iommu/amd/iommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index eb348c63a8d0..fc11a5dab8ec 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -14,6 +14,7 @@
>  #include <linux/pci-ats.h>
>  #include <linux/bitmap.h>
>  #include <linux/slab.h>
> +#include <linux/string_choices.h>
>  #include <linux/debugfs.h>
>  #include <linux/scatterlist.h>
>  #include <linux/dma-map-ops.h>
> @@ -265,7 +266,7 @@ static inline int get_acpihid_device_id(struct device *dev,
>  		return -EINVAL;
>  	if (fw_bug)
>  		dev_err_once(dev, FW_BUG "No ACPI device matched UID, but %d device%s matched HID.\n",
> -			     hid_count, hid_count > 1 ? "s" : "");
> +			     hid_count, str_plural(hid_count));
>  	if (hid_count > 1)
>  		return -EINVAL;
>  	if (entry)
> -- 
> 2.34.1
> 
