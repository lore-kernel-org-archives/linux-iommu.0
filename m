Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013041.outbound.protection.outlook.com [40.93.201.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0100C2701B1
	for <iommu@lists.linux.dev>; Tue, 25 Nov 2025 04:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764044097; cv=fail; b=OEPT/1/S9/2QTkzpTe8ihgeAMiaDQwdmGPCmsYrbp/f7QJ9RIotXuT9ZINhAc/s3h6PjS3qRYXxDOMk+d00P9lTxljzIPe5OiLkXZG6/mLMiJEgIpE8rW4at3/JlMG0MP9bVcN+KeeHVzb11wFbFD0uC56aB6+k83cp1LlAFTJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764044097; c=relaxed/simple;
	bh=gGFhVICgk93V8ncE9YEPmq3pi9Z8enZxEnUIaR7hJOw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wtkp6VxJ9Wo611DzpA42C8o2XDqZvko3UHYS1kbydsCcI1GNIVs0TwRqJo0fyhD626G9bKq3yYbaflULHCcwYzxkIU7QSeJgyg6F9+LiQEeQI7Qe1puxAF3k6NkenGetjbsez0fcLAJgR1vYcMpQgKU+CskMBLqMn0f5y/9FJ08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sxCxUTLP; arc=fail smtp.client-ip=40.93.201.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sxCxUTLP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TGvO/OY4FeBTqwBr8XkcDJo9HmOByqqBrT4VjihzDbKcP6HLS0blTZSRcrWEHP8lqLBAtts9+CEKuZw1ca4/sgQUweNL11lQK2eFjGHh9QbSa+HmkhRqQz6V5prsdNLD9YjcH1Nd4AYrlcb1Go8TtFcYesS6xmgYB/uOHGIGokjbQShaOz9qMhcH8eWRU3RzSXkifKaSjRI9nzIjaOZAGs3gsYSibXaWM0iirWnuJL30G76YJ7TsgnqXNAmKuMp+LBv2TnP5imYQV9DyX9/zEQP2YJ1mVrBkgRScsxnZT5n9SPLZhoZliNVZqOxdzC4GG0EKj4kxhUmv6AHGVhknrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1n7SrvDxnUEaiKxNV+Oj7BxRu0XEsMlZSrXU5cmk8E=;
 b=QPcb+elxKReVbNIcfECaCYuaWuUuEBrdvBWB2YYybi2j5wzSyklEDvsgDTWn/FN36qIpWl1zPnyuEo8uJm+XwVsaLdgGSeq8lOd5VtUEcDIDxCU/HoH7FbVLKDleRa0trR1Wc1pgO75h++Na9A7Exhq8vYhxF+LCEaiRzIRWi1FK0sSpEfzNQnwJ2laSzFlY+BUdQhNceg0u7E+QMQ/wLpTXxOqwC91H5Cbn/6c8OD+Ox4OhCHFKIvjdfYZo78jhhh4UmIMW4YC9tCdIBDdNOteSwYK+PIr8RfJdb/ncQtVyUORhTCUfj/78q1CJzOET3l3st2KC3N6LgHb0h49ktQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1n7SrvDxnUEaiKxNV+Oj7BxRu0XEsMlZSrXU5cmk8E=;
 b=sxCxUTLPUqASx6rZfuBBDKHs4cqlGp1EQOhrliBouPTUT/9smV2PC8RUrj62uujq4zekgsXYiY+F+4Dz8RuzEdloVDhgLOYx/5WtblkGCb1AKUzHb7DPv8mgc066Xoy4kbNxUX8JSbMnLkT5JWYggjb25zYJ2XbskDyfCx8TB3MLnTE1/as1zptTSikpIA+RQHgJokRVPd1uQfcJW+qjJUW0fGoMYv0EA0d95N7nsP2FMwLaGV2dHKA7y0UQlVDbt1OYRnSkCiRJzHnOu2ryi/YsmFxVx7tU6kDQcKvOllU/v3MkOSEDwxi7Dhu8vZj9JslVAU2bRYw4TND2hgsxEw==
Received: from DM6PR08CA0056.namprd08.prod.outlook.com (2603:10b6:5:1e0::30)
 by DS7PR12MB5840.namprd12.prod.outlook.com (2603:10b6:8:7b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 04:14:49 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:5:1e0:cafe::82) by DM6PR08CA0056.outlook.office365.com
 (2603:10b6:5:1e0::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Tue,
 25 Nov 2025 04:14:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 04:14:49 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 20:14:41 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 24 Nov 2025 20:14:40 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 24 Nov 2025 20:14:40 -0800
Date: Mon, 24 Nov 2025 20:14:39 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 3/7] iommu/arm-smmu-v3: Introduce a per-domain
 arm_smmu_invs array
Message-ID: <aSUtL9qxYa6/GCfP@Asurada-Nvidia>
References: <cover.1762588839.git.nicolinc@nvidia.com>
 <eea7bffde13574e099212e3b3823a0f192d6aec3.1762588839.git.nicolinc@nvidia.com>
 <aSTRRyTBh1nATwBa@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aSTRRyTBh1nATwBa@willie-the-truck>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|DS7PR12MB5840:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b9e0a95-b60d-445e-947b-08de2bd92d10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7Ijf22WFcv3FaKn28lVyXUZyiEaR6KHv3JRu8vdzQeHsdKOnwfCipMqVPnAP?=
 =?us-ascii?Q?YeahfZnqmCfEMwoah17xg3Mgy4LqLwy04o7qKfHu0qf7sjLMyUsxqtPTRToB?=
 =?us-ascii?Q?+shw90bI4YoJ0VizHHQOD4Zc3mx36mrB7JHPdtOSA4mcZ7x0FJqpnnKaPiFX?=
 =?us-ascii?Q?lHm/7mlJebVjHPBsvD+42MPI1TEw0uvPAaCV2PO45Qg7TJhqANfnhxXk4Ccj?=
 =?us-ascii?Q?WdRZct7JG7buXzHma/2cwTODYAK9YTQS7ZFgALget3oqR2CT7fCh3u27gkUM?=
 =?us-ascii?Q?0Zbux+isYSgIrYr7GHFWBrzitvGYfftozo9R46xgevJqJurO4HRz249xHUg0?=
 =?us-ascii?Q?z7oxbvfIxAkzYv1YcYbxH5fnMvsQKQP2Eh/G6qLFFYOpR4jlPcc2FJaicPVS?=
 =?us-ascii?Q?eRkHg5NhRalRqKqXLW8IVuWRnKeodqGL+GbqFTGel8eidgQLN36gHlLtsj/P?=
 =?us-ascii?Q?H/feJ+OzIuHdv5spqN5SadyoZnyoqbOBFFpBpfdsYBk5mNVVsx/lsiVC1gc1?=
 =?us-ascii?Q?Ppz6K+PZI7ZDbuTP1o1MEKjPuF2X7iShDeJHIwM4m68RiF0e5Mv0jLA+ZGpi?=
 =?us-ascii?Q?p3DnGv5f9+2Ene4kcxL0RRmAxpXOepBJ1bItZj0y1CBMZvSsXXINGykogcFY?=
 =?us-ascii?Q?b9NqX7CamA6tSm9oP9bBqFfArco0q2fnPLxSAAWS7ARGG00I1Ej0AmVffugt?=
 =?us-ascii?Q?KeEy4HEAWblfuX+pm38vnVrS1+zlpsDi/P1pex22OEU4mafCczA3BOrqLrBW?=
 =?us-ascii?Q?Y/EMR9WRrvr8jSYQDb8Txkd5fPhCn+HCw4bzhflQWi3GHl2rzYMYX7u0QARw?=
 =?us-ascii?Q?poR2pAhzLfW8+h2VF+v5kDDocK/ClOqHvj47GzmfeMihf+Lid2DjulN56fXz?=
 =?us-ascii?Q?BsrQ2bFXmdsB53OTT5QVAit8abnfexqAzJ7ov9o/ZsEaHCGxX49MDe0mvQIW?=
 =?us-ascii?Q?o8BhTyKwoGB+l6vQAV0jvx8AqPuiMG1QxoKaJSAOufO9Ahd81Lkxb7AcxAC2?=
 =?us-ascii?Q?pO6o20O3OCNOXjjayb3mCpcgs0CeMOSZLNKnrjc3cUjDYeqdUoTR34s52gtu?=
 =?us-ascii?Q?xZ/gnlrhqyX4dnJVLpKMJwulTBXme6ZkJk6QggHu4YjnMX+ZLgQolyrf43cU?=
 =?us-ascii?Q?nMfQzDBQtiMUbhUnH/u/VteG0eWLgan0lh3GN3dFIb7iaSaVHME/HXI1rpMi?=
 =?us-ascii?Q?KNys4VhVYml3yQ5K7zHASmX1Q/SaZ0R+5xR3/uChiqzVyTUAD1EhzzuskqLh?=
 =?us-ascii?Q?JsrghO4fhc2XxsOPz8JospMKOIU5va0i3vbQtN/IOOCi/20YbHaEDo1q2/z3?=
 =?us-ascii?Q?faX7s1yvFk7hyighg5DIug+5/B9cmvlmm/0rkK17Qc9CKsPIBa+TcxyJU9Am?=
 =?us-ascii?Q?tt2XyhA5UbzZv2lTXiuUIv9nMPElsn/H1myO4vpKQYHs6VHESB8MRmhPzqNK?=
 =?us-ascii?Q?h+7TWyybL6sOU3fEZDyXfyiMcsJc/qSQI1C1Rum8ifgYvLl1Uzu9NiWBNPN0?=
 =?us-ascii?Q?fEVZS0rTbf8q8nn4i0DUhjnGS65+nS8Pkyz+MAwOYenKB3XX/P3c0lqGzipZ?=
 =?us-ascii?Q?6sI8lh879iF2Jt0cm/8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 04:14:49.6079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b9e0a95-b60d-445e-947b-08de2bd92d10
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5840

On Mon, Nov 24, 2025 at 09:42:31PM +0000, Will Deacon wrote:
> On Sat, Nov 08, 2025 at 12:08:04AM -0800, Nicolin Chen wrote:
> > +VISIBLE_IF_KUNIT
> > +struct arm_smmu_invs *arm_smmu_invs_merge(struct arm_smmu_invs *invs,
> > +					  struct arm_smmu_invs *to_merge)
> > +{
> > +	struct arm_smmu_invs *new_invs;
> > +	struct arm_smmu_inv *new;
> > +	size_t num_trashes = 0;
> > +	size_t num_adds = 0;
> > +	size_t i, j;
> > +
> > +	for (i = j = 0; i < invs->num_invs || j < to_merge->num_invs;) {
> 
> Maybe worth having a simple iterator macro for this?

I added two macros:

+#define arm_smmu_invs_for_each_inv(invs, idx, inv)              \
+	for (idx = 0, inv = &invs->inv[0]; idx < invs->num_invs; \
+	     inv = &invs->inv[++idx])
+#define arm_smmu_invs_for_each_idx_dual(invs1, idx1, invs2, idx2) \
+	for (idx1 = idx2 = 0; idx1 < invs1->num_invs || idx2 < invs2->num_invs;)

Thanks
Nicolin
