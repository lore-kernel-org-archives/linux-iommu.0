Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD38142E86
	for <iommu@lists.linux.dev>; Sat, 12 Apr 2025 13:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744466121; cv=fail; b=Knf0V2PuVIL9K3Efy82fxevnXs2RIfgqEweLtK+7MbYn1EoQRMPX4Ci68OvnleWMMxt+WOV0/x4yKEC/dBAYp19p0ikCC56cQ5rUVEIKP2+UzV9TuQAw3rwm3zTqfgTIJV9hk28yK3swbZelQV/BaEo9FjJ4AtYrTHCGdLMmmNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744466121; c=relaxed/simple;
	bh=dZ3W6RbGTG+4GE1O2MU3bs7PK3MvsL7o0pIVzgS09pI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aWkKA+sGWzKLH/7lY4lQDbVogN5sfJyS0npYIA45QFOiun+LTERCm0adPwtLJsfROEgcpd7/RDK4VybaU7uvVQwPoBhi04cT/OXhS2mzT1vak07wKBIvnhU4AIcLqGgZCS7YSUWXcNKbly512MovDZsd54OhbgbunyfMG9C77OY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s/+O/alt; arc=fail smtp.client-ip=40.107.244.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s/+O/alt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HK10nbVHmv++hnSTpTm+j1iC1vD0pUlNbfSUQMO+UCOw9deHdEvSs8vf7eQr0PZUN/bh6Lis3m1bLIyyf6oyz53xRKJDo65fhzZdGhk8T8DBcLBqT0WVN+89T3z1B91ko7crTEF/QsQ4WRhGznTAuBvyZfELGSjtfcIY3ovZX+6Tz8o0nXWguMZsQJG/oXtUNoiwb48l1vDorMlcZc+zhhHVjrW7HY153ySIHSXgiRilwxqI3tBWyJFK3A3VB++Ru/CdcGd7ZpwenhBi0xgAcqrhijEbl6/s+LDUu2rPTeqq00XXy//msmoYlFXjNgnqkKqeRgMvC4u2ww6vkeA7iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Plouo65+x3yPm9ZvGPQ7J0eE2kfUyJwhNdEUBteeXTw=;
 b=gz5HZNocVlRKWTVNi1Q2slvMQFKslcdSLt4brK4hI0XwVhp9Rvw0St8rhe6kS7MeGtXclAzeP8Ncl90Huppad1e5/3FJTsR8BnoTvptVkZTwpKWi3WrD/ZTqENB5iTY1UvsGA7dKHIeXqjYqeVpDwXE5hDDCZGDy3G2NYuyUaCvcvUjSpcUDkn9rEw0TwN0YF9ZkaPGCc5efrpRnF/nbj/LnIi1v7Ipw1WM21fX/r81UfH6pmL+ClnDQ5P29j7at+DLf9G/HuZLbdu3E5/X+pXkf/WmKjvJL754Et0MVF2wWLVGqyd7ZRzGE5ArfsoI8lkq2VT8wCUYfZX1w76coCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Plouo65+x3yPm9ZvGPQ7J0eE2kfUyJwhNdEUBteeXTw=;
 b=s/+O/altpb8B27Y/Yn3XLlETqdK1lv0I0kEB3PCex2kOoifIxttMVnpikfM57JF2wPQf5gHcT3AE4PrpOlKsX+0X1KaxKl+xX4K0kwwD0BBw7Xn7sWJLxHTydDv+NsTlL0kEUVP1tM2bLnIBJQBjYKArfeIE3j/u9CsfIpRClV/icys1/VNMyUYpA9x2O1bSp8s7XzHQbQVcZBqZWBSGA+x2UK2CxnAXkcIIbikRP2Dpo30zBQe8vNOXVb3kYdyWwqgGeXisR/ZC1IUuMneK+Xg+6CGwinP58ks7IhshyX5COcWHZfMOIkMmtkHBLwO0ig/wMoy2QmZ6nXEjCWfLow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH0PR12MB8824.namprd12.prod.outlook.com (2603:10b6:510:26f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.29; Sat, 12 Apr
 2025 13:55:16 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8632.030; Sat, 12 Apr 2025
 13:55:15 +0000
Date: Sat, 12 Apr 2025 10:55:14 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>, will@kernel.org, joro@8bytes.org,
	jsnitsel@redhat.com, praan@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Allow stream table to have nodes with
 the same ID
Message-ID: <20250412135514.GA329420@nvidia.com>
References: <20250411044706.356395-1-nicolinc@nvidia.com>
 <5c8d16f9-246e-45d0-aaac-45b7712cefb5@arm.com>
 <Z/mm2EQAQtOqpVCy@Asurada-Nvidia>
 <20250411234419.GC252886@nvidia.com>
 <Z/mupP6m0gRbeYtg@Asurada-Nvidia>
 <Z/ngeFHmygxnPn6f@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z/ngeFHmygxnPn6f@Asurada-Nvidia>
X-ClientProxiedBy: BN9P222CA0023.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::28) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH0PR12MB8824:EE_
X-MS-Office365-Filtering-Correlation-Id: 840c7353-cc39-4f47-31b1-08dd79c9a6d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OfgpKoMMXWu/OlXoV6OrSRZmqtA310iqdHS6CIytzAkUDJvSVhFBK4/r8w8C?=
 =?us-ascii?Q?9mYtvuka3PohyTynZFvpgAYD3pA/lQgoWzBM7/k9++ydAHAi9S1H1cV5pHA1?=
 =?us-ascii?Q?qoxth8NtVG5PyAbpNGR9w0BRwQCSBMSbM1/ggqLUGtbrrTCkU67aUowmwNOX?=
 =?us-ascii?Q?3WsAxVLGzFgvMaVeKqPlYz6/UK4GcWtCU/MSv/kSIbLCC6IvljsikjTM9XJt?=
 =?us-ascii?Q?a/4w6EPiNyoZ9jkfAIgaPgYBW8FUiKnsBXthoxkrZsyXvqLGueSvfGzfVKTH?=
 =?us-ascii?Q?U7R8/mTmvw5RiHXul5Ac9mpfxO+nGpptq2F1FSCqHZ97BorHONcpdHsZBtm3?=
 =?us-ascii?Q?ClkZc02vxAgbqUK4jWkc6h8hEuvcyW6UykPSay5pzW0Nn0o/1rZB1jzkTAhc?=
 =?us-ascii?Q?5RG4HHA4f9f82B0uZvC+3S9pZ8jEVmXVsMcoViK5mqL853vXvIUqY3aYHvEF?=
 =?us-ascii?Q?8FYhYqkZubz25w5NpjNp4rmmUYvBVVU7A7jwM+205PqXJJh9JWz/JoG3jLty?=
 =?us-ascii?Q?FhqYPti6Bm0c+D/OoFvhX3cgMZRLyLTHpKLQrod/eCqs1MWVXHoB7ufk9ECX?=
 =?us-ascii?Q?md67wa2kUSSWXivfzWhsS2t+aWi4Z9siNEJ7SLSR7FDrsNgzRzgjxbR5L4VU?=
 =?us-ascii?Q?RuJRxBHMO3m4hW1la5wLHqD9f1RtroYvUok0bKy5cy9YI4FKYmz1hH6Ufh0G?=
 =?us-ascii?Q?VI5sILQITASLHtpl9mtRNx3TQudeAQ7wM3WZr5iszolAx5Y4M8NtjG2x1dye?=
 =?us-ascii?Q?dZ2OXbeXQ9eZ/xcHCcwgAkARuYDHNSZyv45a89RlkpHlKzSwsYGseOC2AfCU?=
 =?us-ascii?Q?Avfq7UZFGQL98BmTIXPPfsCIZumUqzYEZPq9yzRPZeMvUAYl0+9JPGzwjFPA?=
 =?us-ascii?Q?beRlD0nlOqUAzCtW4fPpysw+ofKn0cLMzpojMWn8ZZkzZOUkD9HeyG0FI21H?=
 =?us-ascii?Q?dB0XXRaUiBqIrkSV+engkDgeYak8tiNXu9XWpeGEzgWj2a46iN75EPtoM3jN?=
 =?us-ascii?Q?DKmEG38D5ZsYhoNlIWgzJFoPCx8ulqtcBI1E4R055LTgcqZk0cWXcXIexNxn?=
 =?us-ascii?Q?4y/yuJbg12gDMB3w+DgSPLNnz3RL0yFuX0xmsdrwyPyVCk1RhNxmfydwFYXO?=
 =?us-ascii?Q?YrRXzDVjnxXryJHA0cwJnbQC8KUOH5kKx9+jGUL0AZ9qkq75a5Q1Rj4Iqwsb?=
 =?us-ascii?Q?qLgF8GGxhc4E5VJBdVk+kyP0xbxnCP0J8EpygyA8nkTDpwpCZsXys/Y8mEM7?=
 =?us-ascii?Q?TMXAwKLfZGKUh/5GJwkSW0GncXqRJq8MjJcxkxFAwPntpgfEehoLH6XNfDSe?=
 =?us-ascii?Q?f9cRWD17f3hzKx692U3q0FplU9RpVODLSxOoHYTYe7sAp6UxmXKqp2Xrx6mb?=
 =?us-ascii?Q?rZA+aDAbfoZ/ESbR7aIett35M/zD7c95Y4uJKFAczsWcCMhjhneEygiUQKLU?=
 =?us-ascii?Q?LfBAt3OPv8I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v9L3I6FKgdjOhp0ihnGkH1tniIZY4Lr9PPjRNaa1NukYAARJDAsVNMgWJaG3?=
 =?us-ascii?Q?C9+LceqB2f3IsoLeM64QhAy42VaGwr4gtb4cjep9C5yULHBt4ry2s9JwcOk6?=
 =?us-ascii?Q?ayxTz1RGcIxj0Yg6UrET1W1q6jMH8yFhHktzv7TCmpZvwUMLBMl7Ggbcy3uL?=
 =?us-ascii?Q?n6jTTw5IUPz3Vnj0RzJkY0fS+Bf+PM40xKLd3ftLEKB/36AVn0+U2xQpWnOH?=
 =?us-ascii?Q?8y+mscpJD4qtm8N0xOvsF0fEzTwlG8EnWw4SPHjAPnr46049z2IIwQ3AbGoD?=
 =?us-ascii?Q?8jGKv83oYNmKE82wNsFVeu5Gjjr5NmSF151NurUR7lrDeBWT3PeTS/FJjnqy?=
 =?us-ascii?Q?gqU2PAjgngdYz/rW+twxt4fXpLwLFIQeDOTyA/cGAhFhwDfFgGsI12CvSrhR?=
 =?us-ascii?Q?LbrzJWbRjGqL4rzIFSZNqn6sAi4L54qiUhf57z0SDWfrzLrZFkbDAvIc1oc3?=
 =?us-ascii?Q?ngxhFx6yvlnrsS/mg2gAg30IwIJgawjsdK+cJO1r87V2LALvyve/GGYSQkrz?=
 =?us-ascii?Q?/QeR+2xd5bYRRZvQg5sPuVSI9ogEPaOJDdTPHUxQ6YrSJ1ECHUpUCJyiR7tK?=
 =?us-ascii?Q?6uzcNB1rWkFEuRLMRruF/U5/BMV9PiI0MKUUjgbXsbXAAKgoRL4w+VgHVphR?=
 =?us-ascii?Q?YvV4ONy+pc5xz/2lA/HIbm1hwaikZk+QvXkgckE5Jy2M9hgCleFup7pwL2k6?=
 =?us-ascii?Q?Q2OSyq/CK8WN6XLfztjqhY5oMdUwVbRjcySHLUHI7ZFIZa+Ey87boSJeaxVk?=
 =?us-ascii?Q?mnU0kiq/GamhiA4d4uueVoIiXrQYSexeiM4cAbpZ1DI3G6unqoekh2Rbc0QP?=
 =?us-ascii?Q?8lGzhekxo36W50qN0A4GCcfJzgkDJMoWvczEgD5T5AepcYA2qIf5IpkZy3Le?=
 =?us-ascii?Q?zphjL2VcAOxER5aWb+CazIAUoPad4C2a/QiwdmtsY0TNtkWwz/UWDAKo2sjN?=
 =?us-ascii?Q?Txr1VEpk8p6MbOnJXSAodCqRKwoTLFnuv48Xpnm78ueFOp3CZc5bJUWSIEJw?=
 =?us-ascii?Q?OEaXdNYvHUs42OT7RDtdaPg8WNSPoFZOrubWrwEYsmPHI97AjptSXy3GKPUU?=
 =?us-ascii?Q?3qja49QXlwz800dUpo14VHfFj5k+143RCZDCP/Un4vUmlLNbH9wULXeWbNgb?=
 =?us-ascii?Q?90w/LG+4ZFzuQbhrHh5rAhSE4dB3zN/ofCib2ZuixTDJgSdoNKikVFrIz1K6?=
 =?us-ascii?Q?PWHWVf/flFb3dwdj3C2Ej6XF5XZx6AWmKmnJta0CBlXkTqkH4pun3FNmIQSI?=
 =?us-ascii?Q?9A2hlb98njwwcSe4mxDCju52Akx3IK2RkoyMwmuGYbMjh291p2DWlvUCiKNy?=
 =?us-ascii?Q?plDdvMUSoUHggyLfgl+T+1PHsozA+JT1/wQblsEkYrNFoIJ1Vx09B5W2h7Ci?=
 =?us-ascii?Q?V0Lv/yycz+9aoqhlLA9s36ySrdZ3SvPhDrFvKOTF76dmP9vLxqE4ELDaYK7t?=
 =?us-ascii?Q?5ZmTDJ6f86XVnLsYIMOSgecUWPDhbsFI5u7eYS16F+WdJZX0Ifus05VDc7FC?=
 =?us-ascii?Q?LsuqN610MWL9GBnduP84MJ67P0KM9BSx2/6a3+buYYtjwBpp7JFKjPeI5dlP?=
 =?us-ascii?Q?gS883i8ugIwuZcy1lnC3Hnho8TB4gbfIeRL1fQin?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 840c7353-cc39-4f47-31b1-08dd79c9a6d8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2025 13:55:15.5014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ncOqAkgS/WJbQ47eE4SyTvjPAavKOoLeFBb70rSWQTk44FlsqRgciGKeCpqX0u8p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8824

On Fri, Apr 11, 2025 at 08:39:36PM -0700, Nicolin Chen wrote:
> 
> I figured that we could do something smaller too in SMMUv3 driver,
> somewhat similar to what Robin did for STE in commit 563b5cbe334e
> ("iommu/arm-smmu-v3: Cope with duplicated Stream IDs"):
> ----------------------------------------------
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index b4c21aaed1266..4b66e8ebef539 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3393,6 +3393,10 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
>                 new_stream->id = sid;
>                 new_stream->master = master;
> 
> +               /* Bridged PCI devices may end up with duplicated IDs */
> +               if (master == arm_smmu_find_master(smmu, sid))
> +                       continue;
> +
>                 ret = arm_smmu_init_sid_strtab(smmu, sid);
>                 if (ret)
>                         break;
> ----------------------------------------------

I'd write the above like this though:

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index b4c21aaed1266a..97b9f8d7fb3340 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3389,6 +3389,7 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 	for (i = 0; i < fwspec->num_ids; i++) {
 		struct arm_smmu_stream *new_stream = &master->streams[i];
 		u32 sid = fwspec->ids[i];
+		struct rb_node *existing;
 
 		new_stream->id = sid;
 		new_stream->master = master;
@@ -3398,10 +3399,20 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 			break;
 
 		/* Insert into SID tree */
-		if (rb_find_add(&new_stream->node, &smmu->streams,
-				arm_smmu_streams_cmp_node)) {
-			dev_warn(master->dev, "stream %u already in tree\n",
-				 sid);
+		existing = rb_find_add(&new_stream->node, &smmu->streams,
+				       arm_smmu_streams_cmp_node);
+		if (existing) {
+			struct arm_smmu_master *existing_master =
+				rb_entry(existing, struct arm_smmu_stream, node)
+					->master;
+
+			/* Bridged PCI devices may end up with duplicated IDs */
+			if (existing_master == master)
+				continue;
+
+			dev_warn(master->dev,
+				 "stream %u already in tree from dev %s\n", sid,
+				 dev_name(existing_master->dev));
 			ret = -EINVAL;
 			break;
 		}

It seems like a reasonable rc fix, and if nobody has cared about DMA
Alias support since it was broken in 2021 maybe we just leave it.

Jason
