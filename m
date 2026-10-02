Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011049.outbound.protection.outlook.com [52.101.70.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8371F47A888
	for <iommu@lists.linux.dev>; Fri,  2 Oct 2026 10:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790936616; cv=fail; b=g9QEB51mu+6FV59qnCE8/29cgkkIInEO4GEOZd6PLmVGxpa7pD2l2K7yGSe98T1rYtFQgFkiRkbS8zJ17wrL5lqU0D/F/vxOemxneSSn5F/4O3nkJmyYeDwzlxTqfBDy7Ic/Tz1p3uBU5MgYyjlvM2xcGjY4uHXzfI/PjcEjebc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790936616; c=relaxed/simple;
	bh=McUAozAyRreNdL4qBTQk1IXUHvsrb+FDPlN/DURYqq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E8cQ7ryHmSvU+nHNwv19lct8/a+5rLD2SEt4ktq4Y90VV+MexCO49chOmgvn8cvLoZcIlOQnWWk0QaAbJ4WBJxGKoErbdmPFcLQwXO7HV7pvlZ+g+BlYK3kB6lxxB6saXD+Tv7yZ9zaswSVjv80GuI/JTPpfr6hgdAAteQlkVJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=jOPFrxSs; arc=fail smtp.client-ip=52.101.70.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jOPFrxSs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f3HfFDs2wpM/kEo0DJW1tETQ2Vpfoe6oS9dHTEkCwkg4egFugj0MEZDYBO1PZxE6vOzYOOSKtgA6WTrMktbIbpEgjen9XHouFUCrhKjKpVFn9+C+CLZMjw09l8bRykAAM8dJ6Oy2QVA6XLzj9VipoMeHuM4M9BvJmFj3AwKxl5PilIQHxiAjGVFDyfMX2ZPCMOMPGlJZ4HfVapwUS+UgO5cmjIShR9OgcSNH3R+CHMYYZW94mZpJ16h/VEsmjA514vpOM6hxJsGVkuNUqhBC71062UT9zNN2Z0TTmaIVV7Bs5XlU4RV9QL27ckJ4R5NzVitdgErqDlxwxcj3CRAAjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=81J7t6bCBGYFsGSPkDbKdH4Z5e5KYVg8KuZ6fRScFfc=;
 b=XMBy3SfBlgCFbt+HW7n6vlmIT2ur6OOkhT46XwQbTbBZP6Aj9OOagCtNFrwYbTPVbZhTK1Vk0DQgErPyVJzfAh1B6yNPv7HEQdkBeF2BV3iqTQkdFPi4anQ3ZSqxYLNm2AAv4/bnYzswH/Jr9l1pQxItCiUWzehMPcYmvXlvgyP/aqnP7gsPwZrbt6P9RnWQhk3mQhInfQlv84ToZWA9FrpOhawfFkjiBiFm17VHSbTdyklwuRqo1JJTAjeBCpYizoRYWPFa3lZmO1wNW4M/HoVac1hw8Eb+IbdTdQIdx84jae/mAQO46AdIubaguqtLi/w1t7Cc0Y1OGxDRsaOVRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81J7t6bCBGYFsGSPkDbKdH4Z5e5KYVg8KuZ6fRScFfc=;
 b=jOPFrxSsq7DMLYnd5o9Ezo/8RynC/cbnOnklV28jO50wZycOM6IPSUK29PcoUb8x6kjHhXdKMdA93dtJxQmKGVKSMkhIxuvHvNfQ4Eselc8d+7RN1OnzWawn69/KzICNnL4t6VGh1PIyz+rL9V7hzXs57eVRQd/ovXuda0H/SIFSBsaWCmauY1LO6sY8QOMHRItBnm3pil0DKeSimUgMkoJXBLyeITwi1mXqR8UYdqy50/Rw4eQCMOxVTohOUwJcakVatNLU+4/U4ArcUYxqV49o4+A1Yl5xM6qClEbhRjU9WN8zqdOLwJ9sMAMfMmfHlhaX4gprckdUzmC7zOj4lg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by DB9PR04MB9259.eurprd04.prod.outlook.com (2603:10a6:10:371::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 10:23:30 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0451.022; Fri, 2 Oct 2026
 10:23:30 +0000
Date: Fri, 2 Oct 2026 18:27:58 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH RFC v4 2/4] iommu/arm-smmu-v3: Support shared SIDs in
 insert/remove_master
Message-ID: <ar+HLlB2oyiz/cgD@shlinux89>
References: <20261001-smmu-shared-sid-ver3-v4-0-06b34fb2e691@nxp.com>
 <20261001-smmu-shared-sid-ver3-v4-2-06b34fb2e691@nxp.com>
 <ar6Vou12yzoZ2z8I@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ar6Vou12yzoZ2z8I@nvidia.com>
X-ClientProxiedBy: SI3PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:295::19) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|DB9PR04MB9259:EE_
X-MS-Office365-Filtering-Correlation-Id: 34e80bc4-ee72-44ef-917c-08df206f349b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|23010399003|366016|376014|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	g4GgI4paL2rkwd3U1J2RWILl+VnMd6LKFixHWsUkXydUX1ppI4RPHXI/11+8KhmiywNjW1BdH7XcHl39sxqJ/i+0aVatRYG83lwvcx9SQkBVRKKkGSzZUj8fNPNVEbiWBVSvBHIQlv9QF+h2vDEVz/p/mVGCwIN6EiT7F9HjoU3DScmju0eASMAbPfwhEP095sRh4KRZq6uN4V6BgBgO8ittENFpeMyeEoEkg9BCApWtjt4YqqvgNw9vxvBeCvlbpZiwT4iGLAViuGD3EzTysvYxC5jCgY6cVU5J2G4McDKYjzGpXJGsjVOxC7ae41rfVTfCulZweYDFWzaMk73fQLK/zER2XSdCYb9GFmwx0EKz9a39KPIE/RpD5jIyYl08JjHyQTJaZbrEeLE+jaZK5ozo+xq+R+I2GgOt0RIHWreYCz9npdrClFyFzq+UvIy2K9evyRd/TOS6iJ4JS3+RJU/j9vSABDWsd+c++cwdHSoPRAfsLWffgmyoG8xMPuC2522gFiQxCur+u0F4sujiwtS8QUFZkPQwcSUxF5TyW31Nm4WtBA2kMftE/GZDf4Rxhu897dr6tqQ7S+QTi7lLlsBIS+mr59eZ3/XAFmRVEAWaHHIDkMJrlNWiVJIZNHAUBqPI1EBnPtnrAWM2jtQL5nxYDmWB1O+pZR0yNiLG4tE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(23010399003)(366016)(376014)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3r14yK2ntpuFNNrq+XK7XHEv0xMMCZrl+nIzlNx4SEj6Vqa85Ef01PEdE8k7?=
 =?us-ascii?Q?kClnj5Cq769JV6uyilWLw5j5mUww4UNVrInPKi5TnhBtY6uqeA6pnmWK9N0d?=
 =?us-ascii?Q?8/WrSHowN8SxVLLbHSxuPHchVJ8jnP8Nriut+oGuLyURX2DHjr+SaqlFUNuu?=
 =?us-ascii?Q?VMx5vDscBxqdmxJehnrhE15l/YykXuSD2apMalyVeDjvePru68M/mvjRW4oB?=
 =?us-ascii?Q?qCw0fs5m9I3SOfwh55RAKfvUuXexfwzDQUGLE/o5hW8BSOIKy0GcbR88gpSA?=
 =?us-ascii?Q?xQB0vHSkAmoWyqA5lqmnnSYTKua/HkdHRs5xaSRQtPZa8e9xobw3fwNpJubq?=
 =?us-ascii?Q?4BbnoTLrpXO65M06uCoUi1Tu1R9i8U49o6HFdmWz1Nc5OJJPwcyNAyKUHSI5?=
 =?us-ascii?Q?gfSttBjKeMAiExWUKs9XMtPfccfqgOgLRoFXB+1c1pL8OGpgsFLll4Gd6mce?=
 =?us-ascii?Q?hRh3cJUfwF3eiNqv5n4wU2xxe2JIXDAF1GxX1RHvfFjH5yB9fPeEsWd5C1qo?=
 =?us-ascii?Q?0xqDqeNqOEOi+QEQhJDKx2jP0+ajmNw/Tl1e12lHhT/pL1G8v9MJUjOdVWyR?=
 =?us-ascii?Q?nfLoXQ69Du2TMhFEbW21rhVgtTvEw0TQxdbhrrLNSdIwHt/5eh7N2V57eeQz?=
 =?us-ascii?Q?h2oOA301l0y7T5Z2lktd0gbZDZFCR3LSJKSdopdyItvwP7oY07Q3+6kFsXSt?=
 =?us-ascii?Q?I8W0bh6Amjn/vTweZipcax3tzVGQZv/V212sfw4svX9N7a4As6HOKvtsUT5G?=
 =?us-ascii?Q?AVTyH59LaXlf6WPNify7kM8FnBGBNUNMywNCqU7m4RlK2giYs/ZMdilCOalp?=
 =?us-ascii?Q?NPkH3qrZCjJLM3mTpM5sTjeZ2NX+6ieoBVJ4ELVUcJJOiZpdzToKDaz1t2F7?=
 =?us-ascii?Q?knvSYXQcEA8E5LO5mpIMxhoIhVDwszjbMJwSYkfy5251eyDWsWnR5aEnz1y8?=
 =?us-ascii?Q?iiJmuQs8WTTqcQJJ5VJ9RjdAJAoxgjICKn902F0LqDvYMJv72PyQy1ZuTbjW?=
 =?us-ascii?Q?DJ9KT2rWwD4Ni+dFgUeUXjuBQ76aAhFtPfFcnv3+AWCLeaeBw3rTPHyuaDkN?=
 =?us-ascii?Q?dv/ocMgpxRY9mhNxUG/qZbwusTxTFyOdYZEEbPFyfYAavmZGyVvri5nD8e5i?=
 =?us-ascii?Q?dOZlO++xh4CrmpkMk9fdHZ09tqmO2cGf3/ApoyNh1AGFXeQkyXVbODiTsBFP?=
 =?us-ascii?Q?LDL3xHYV2T9gy+LzSjsmuKzf06D8mZ1Uoi4BMpGFJ1cab3rO/rcSY8JSO34z?=
 =?us-ascii?Q?xGs27iUE4+SU+HWiGZpgpOhu4wUfoZlBDzQStK+IxcvyRtW30CQkm/hE9iJD?=
 =?us-ascii?Q?U1WTmD7RVfQKkn7LIPCSUkabF/rdNBGjW1/X0BS11qO2MywVGNrF5st/wPYb?=
 =?us-ascii?Q?0N73GIPBGUFfHU3s8TfAs4nOndmR7j9v6fAcK/iPbR4M3pRJaAD5x0LfuJX2?=
 =?us-ascii?Q?g6yD0vSVr/NE8ZpF/9x2I1dLWMrlNKBCfhOH7FRQZDUrujnTwDUXaYXVn9/+?=
 =?us-ascii?Q?Gjfw1fCFw8QPjce47+TfY9zzEX/zRwYRwjln7EGhwiLvNrLnu1r2I7wNHwDU?=
 =?us-ascii?Q?iPhICE0Dg38/iu0svN+zvxyGalQHCC5Vdyi6qQzbBWxZiT8/pVBkmQSGGeNE?=
 =?us-ascii?Q?sQMP4l6ytlXFGRYljFKnFmsFEwgYj9+PULBXYSaGNDepIAqifXB2qY91zPI2?=
 =?us-ascii?Q?3Sc+Nj+LrI82QTthCIGeh7rB0iBL8Ye9UdG3CWH2DPf9BC9rqdBk49xZmqZo?=
 =?us-ascii?Q?YcmkEc1ImA2u6r8wvvH8Wj94f4uAcsqqKPnNvXb7Vffof5y7h2t1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34e80bc4-ee72-44ef-917c-08df206f349b
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 10:23:30.7032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lzrfbqhhH08SJjN6q4vprGxY2lv/E2sVWVoT2toozFwBwU49t6RQ2JNAowp6Y6ECC0D/WOjPB60/EKmHk6XqYSLhNdYPweKgetL/vxy1sRaS69J3spEs0OkpzVt610lu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9259

On Thu, Oct 01, 2026 at 10:17:22AM -0700, Nicolin Chen wrote:
>On Thu, Oct 01, 2026 at 08:49:59PM +0800, Peng Fan (OSS) wrote:
>> -static int arm_smmu_streams_cmp_node(struct rb_node *lhs,
>> -				     const struct rb_node *rhs)
>> +static int arm_smmu_streams_cmp_node(struct rb_node *lhs, const struct rb_node *rhs)
>
>Why is this changed?

Just thought 100 chars is fine here, so ...
I will drop this change in v5.

>
>> @@ -4136,23 +4151,33 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
>>  		existing = rb_find_add(&new_stream->node, &smmu->streams,
>>  				       arm_smmu_streams_cmp_node);
>>  		if (existing) {
>> -			struct arm_smmu_master *existing_master =
>> -				rb_entry(existing, struct arm_smmu_stream, node)
>> -					->master;
>> +			struct arm_smmu_stream *existing_stream =
>> +				rb_entry(existing, struct arm_smmu_stream, node);
>>  
>>  			/* Bridged PCI devices may end up with duplicated IDs */
>> -			if (existing_master == master)
>> +			if (existing_stream->master == master)
>>  				continue;
>>  
>> -			dev_warn(master->dev,
>> -				 "Aliasing StreamID 0x%x (from %s) unsupported, expect DMA to be broken\n",
>> -				 sid, dev_name(existing_master->dev));
>> -			ret = -ENODEV;
>> -			break;
>> +			if (master->num_streams != 1 ||
>> +			    existing_stream->master->num_streams != 1) {
>> +				dev_warn(master->dev,
>> +					 "Shared StreamID 0x%x not supported for multi-SID masters\n",
>> +					 sid);
>> +				ret = -ENODEV;
>> +				break;
>> +			}
>> +
>> +			if (list_empty(&existing_stream->shared_masters))
>> +				list_add_tail(&existing_stream->master->shared_masters_elm,
>> +					      &existing_stream->shared_masters);
>> +			list_add_tail(&master->shared_masters_elm,
>> +				      &existing_stream->shared_masters);
>
>Masters still hold duplicated streams for the shared SID. And their
>ste_installed flags are out of sync..
>
>    master_a->stream[0]->a's stream0 {ste_installed=true}
>    master_b->stream[0]->b's stream0 {ste_installed=false}
>
>What I have been suggesting is to have a shared stream:
>    master_a->stream[0]-->shared stream0 {ste_installed=true}
>    master_b->stream[0]-|
>
>So, the driver would need a rework first changing master:
>-       struct arm_smmu_stream          *streams;
>+       struct arm_smmu_stream          **streams;

Ah. So I need a patch list saying:
1. iommu/arm-smmu-v3: Allocate streams individually. Change master->streams
   from an embedded array of struct arm_smmu_stream to an array of pointers,
   with each stream individually allocated, to prepare for shared-SID support
   where multiple masters will point to the same stream object
2. iommu/arm-smmu-v3: Support shared SIDs in insert/remove_master
3. iommu/arm-smmu-v3: Group aliasing devices into the same IOMMU group
4. iommu/arm-smmu-v3: Wire up shared-SID STE ordering and feature gating

>
>Also, arm_smmu_insert_master() needs to reverse its allocation:
>	for (i = 0; i < fwspec->num_ids; i++) {
>		stream = arm_smmu_find_stream(smmu, sid);
>		if (stream) {
>			// link to the existing stream
>		} else {
>			// allocate new stream
>		}
>		master->streams[i] = stream;
>	}
>	if (!ret)
>		sort();

Thanks for the details.

Thanks,
Peng

>
>Nicolin
>
>
