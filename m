Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012015.outbound.protection.outlook.com [52.101.43.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587F73D3D09
	for <iommu@lists.linux.dev>; Thu,  1 Oct 2026 17:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790875085; cv=fail; b=qN1nQhX9/0HQTXZ1fq8/q6ifIZipwFLMVjw1zg/Eyws63he3A/7nqVuwxqennwmLXOQp7AZnfufvbXpMaDGwvePgFBJzF94wwFa+9X4eUQBwDNJXTT1EEx3gWtehRhKzq/76bL7ebJk0cXyb/rwiWmULB0wVjkt/HaxWBQjAM7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790875085; c=relaxed/simple;
	bh=/3kLPRmH16kVgue6HvW7zRztZ5bwlYWuI+tvmPCKAqE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSMAMt5QROpNmqde38tkYquIAw6pn7+haFX2nuT/tBxkRmdZyN9VzbnD9V4Wkqs0fcC7Ht3W0z0xTbsYbnJdUQcTK4CvcBMWnoCYcz2sryRbPR+xJkQvKpt0Ma/U2MnM9ON7Em8cU50gVf2Ge54L+PrBmEV0rrCsqJyaNiJYKFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WveHJbpb; arc=fail smtp.client-ip=52.101.43.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WveHJbpb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mrkLzNYxa/83qygWlP5X4HJcmTEZaI40WHZtmOi/qcQDgrbDj5chEfcIBc8M3IamGR1X0rIicNtzbOKXNDCtE7CkmE2aeeRz+SeqC8JMlcH5CUa3iV5bYl681FZW8h2xSxui0CxTpFExHEiIGHyx8eIjqJFOoVfl2f57RokbPti+p/FrLJeS4ZJWWm7N79uvm3wDZ2X8tllG+jCgxNjbMTHrlTdtWF19D3ag6T2NfSoEsqszR8UJHNqTdL5eJYZBd+dE8f31g/MLwM6pgcAUyP1EtOlSQuISLCZ1191VtQ338w3UAc816WuQ55uNXqCIu2LTyId8FSiKXFT05JO+YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ee6xd4y5jtj6j6zwrrsmp1h92zt6kolZhRMQlPpZPsg=;
 b=wFwb5fZ+y743SDJZm4YzbeAvX33Iln/uuniwOsEAL8MQuw3BI9+FpCXT9vDPCx+HJ6k9Bvi90ybtsAEDgiG5tPOnGN24HIEPkRYywGRIVrReJ7ruAqgPUeHNbn09TB2c1WFFpFQWQEQoR3EtJv3gj6XywmBIvGs1FF4NAa7N1PjEIpe7CKJ90nSyQcD3UyJPhRA6Szec/55JYEjhdaDEnsTmgW6PW+PLiU8V5nLWSMH17vBOyKgKfYIQlhPnYxd89piFp7TQ2h8bbnTvsn/jfKYZWnTXFlhMi+pyMmW2y0yatOH8sCUV5pFS6ZSnAKxioroulzK4CpBZ6nF+lx1YKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=oss.nxp.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ee6xd4y5jtj6j6zwrrsmp1h92zt6kolZhRMQlPpZPsg=;
 b=WveHJbpbRTsuQuItE/CxZpqtcZRYcqOUCBiUtLw+KR4+bAUR6utBau9XAVDwQncCXQtx6tVFMMBPAJeHFA5U85VHsLRdQrSEFHO+Ki27SAsEy1lX3o6cNADYVkgpj0hYVsdJvdbb6LiA3TsWvjx/vuaqNsNut4S678JOcgqQ9+tqsv0d6P71LY7xpZWHQTZ7a+W0/Or707pPT/7ZwIdaMFHNGl5r05a16N3a1W+AN27eb1KK/mrLf8G1qa62XmAtlS96Ds/pR4gYL5V+GantZFjpXEKlFqO8O15nv6fBTngQV0HfXzl43hZr6umQfHcdasYKsAhxROOSqlhKGvR2ww==
Received: from SJ0PR05CA0090.namprd05.prod.outlook.com (2603:10b6:a03:332::35)
 by CH3PR12MB9342.namprd12.prod.outlook.com (2603:10b6:610:1cb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 17:17:57 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::3f) by SJ0PR05CA0090.outlook.office365.com
 (2603:10b6:a03:332::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5 via Frontend Transport; Thu, 1
 Oct 2026 17:17:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 17:17:56 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 10:17:26 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 10:17:25 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Thu, 1 Oct 2026 10:17:24 -0700
Date: Thu, 1 Oct 2026 10:17:22 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel (AMD)" <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH RFC v4 2/4] iommu/arm-smmu-v3: Support shared SIDs in
 insert/remove_master
Message-ID: <ar6Vou12yzoZ2z8I@nvidia.com>
References: <20261001-smmu-shared-sid-ver3-v4-0-06b34fb2e691@nxp.com>
 <20261001-smmu-shared-sid-ver3-v4-2-06b34fb2e691@nxp.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261001-smmu-shared-sid-ver3-v4-2-06b34fb2e691@nxp.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|CH3PR12MB9342:EE_
X-MS-Office365-Filtering-Correlation-Id: d3801db3-3b30-4882-a484-08df1fdfef6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700016|82310400026|23010399003|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	BzEfiwOMij/YJ332MF3btfp6D0jdevC066zgOwKD1Ocd82KM2XsUvEBUy4KpSnAWzaqHSkayuM0Ce8aliW9L0G0dRSMh9CxJxRR2FkjchBB7oTId4c4racn1IBlRL5GnjYMLZWYWVWYzGJYWMTR0kv/Gdaqyz/77o14BUjtr3A2Jrs7S0AM6ZcCsRDbMMo7NIJJnfwyy0kLeawtV4qmYwMQQMPd3/RcIYfUWjhxxLP/Zq6IFfDCUEdhYwMVQp2tsJsdsCd6qwRVxax9DqMiBKx+W/REVk1KD/DljudoRBF8w/xvH3vFDQ4JvT3u7R0T8u6LvMZjQcEz+XwediT+rcJPzQrrOdNTRpNlsJHCck2Mkfs+UuPtiPn/xx6QYhCMsCOdeOFtPtZ26oSOthWa7RrWNtnn276/4VaQtaFy4EpIHpQDhmyZ4+ZTTzF99A4HLdD4O483ZGvyKpNVSGN5klbIQfxY5IFY6CP04oS19OLFcWM0+WxVy0B6nW+59P+RS80dfO5U+ByzilnTXPXgl1/vhSVlAKesUMq8QiehbUXs7JOBaVofqrs2oUCt9iSBoDRZzP0Usq2ApqsT7pSHAXvIQYXanNxHVnvfxG8+Lq2jzYxd6YmxO7oIdZFSaKtjzuAPNNqYPkBwqWooeS0c9Se0c3uN3l6FVECucuG/HQEl4/ROWlY8dequx4QYnDMUGoutuwV/NQQ1+Viuhq4t+2w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700016)(82310400026)(23010399003)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	smCMSQazNul6DOqSAur+hCxW4k4Z42wIKQMz8eIYSJgp+iJ7Fd3yXxX/O4PbyAfXjoHBXoYba57fSYMvWppycseh4wzabqwlD3L+FAkArAdp35qHHeL79R0y5MQHcW5d5GRzzzw/OwRjyckRFNMmHkLeCMVAQy5TOGtu1JVKdaaVgncYFEXRBKmO3Yd18X/pNGYGlfylcFEc+fxs3BYsEwXTWHyseP/stkwFx83dPj4CTuPwH0KLExndWOatVHV6qYwynxk3ZXxnzZKv1xyrlCAvsxijQgVs7dJd6ZFEVhY9z/JpdPcTvkFS8rm0HJseBgsEIizIfiiGD8xDYDoqfgbjL4G7q+fsBKgTokOIQUta15UvO5Hi92RyCAo7YqdCpCOIYIbCOXh3iTa49CqkmT7R/q+fyzZ3J9F+4nyT8iisBR2XJ/hUOzwEP/V8HvpV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 17:17:56.3540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3801db3-3b30-4882-a484-08df1fdfef6b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9342

On Thu, Oct 01, 2026 at 08:49:59PM +0800, Peng Fan (OSS) wrote:
> -static int arm_smmu_streams_cmp_node(struct rb_node *lhs,
> -				     const struct rb_node *rhs)
> +static int arm_smmu_streams_cmp_node(struct rb_node *lhs, const struct rb_node *rhs)

Why is this changed?

> @@ -4136,23 +4151,33 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
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
> +			if (master->num_streams != 1 ||
> +			    existing_stream->master->num_streams != 1) {
> +				dev_warn(master->dev,
> +					 "Shared StreamID 0x%x not supported for multi-SID masters\n",
> +					 sid);
> +				ret = -ENODEV;
> +				break;
> +			}
> +
> +			if (list_empty(&existing_stream->shared_masters))
> +				list_add_tail(&existing_stream->master->shared_masters_elm,
> +					      &existing_stream->shared_masters);
> +			list_add_tail(&master->shared_masters_elm,
> +				      &existing_stream->shared_masters);

Masters still hold duplicated streams for the shared SID. And their
ste_installed flags are out of sync..

    master_a->stream[0]->a's stream0 {ste_installed=true}
    master_b->stream[0]->b's stream0 {ste_installed=false}

What I have been suggesting is to have a shared stream:
    master_a->stream[0]-->shared stream0 {ste_installed=true}
    master_b->stream[0]-|

So, the driver would need a rework first changing master:
-       struct arm_smmu_stream          *streams;
+       struct arm_smmu_stream          **streams;

Also, arm_smmu_insert_master() needs to reverse its allocation:
	for (i = 0; i < fwspec->num_ids; i++) {
		stream = arm_smmu_find_stream(smmu, sid);
		if (stream) {
			// link to the existing stream
		} else {
			// allocate new stream
		}
		master->streams[i] = stream;
	}
	if (!ret)
		sort();

Nicolin
