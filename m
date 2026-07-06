Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013034.outbound.protection.outlook.com [40.93.201.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265A93C5855
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 19:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783367159; cv=fail; b=rSSoRhHT1q6puFQ1Xn988/gNm/kH37QXKswgAplefC0LBDhaRe4MoYADWxgSlNY36cPtkW8vOfLu9FtMfAkEwsrlvpXtoVUZfyoiMp8dRFU9Dn9TJr4zpSrWss9CHxV6CjdaIZzccEuUe/W6KpA+yIQXu87h6hfUOgxdzikNhvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783367159; c=relaxed/simple;
	bh=GWZ775BQbv5zd4hID20KFODKqVFimqjg7yIijjGwmrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gp2Lvv5U++AjeeyD9RnHqSNqvBdiPklYaM+qvtkZ73R59Qpi0RUQ9f2uF5xm6JnwPDfb/mdmxUtaZ2YUKyizVBz0CRzvXaKIj0e0U3vxGS0gnnx61uE1PELHBEn0kzIZ+1y4Tzq63+gh0xwWfjT1ucDXwx1hcla2lkB1ELt87/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h9WdVY9l; arc=fail smtp.client-ip=40.93.201.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h9WdVY9l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PaumaG5Mzjr23BjTZO3d8wheOdOHnrI8j/Zpp0oQD4QNSqeN2iHpaW5CYceEklBVL/Kg3hKTal1pu8KfwSJXjsaPXGWwK4NhOTlqcy1DesKfokPaw7nU0HUzwiW5veuLbF+0QMMMJTNMWVR6JtJsvNs4S8GISOCgifDyTO+RcLa+g59OPFn4EbXblLpW/CtSW25W9MZ6yW7o/S8SYZuQgOo2gMEgLrF1iIhU83tbDNdbA1PraL9BnqGuSDck2tqS2ktqcxKudjf0/c+JFVTQq2qJgruP6sDEy/82N1ZACb6dN+gi2Z/gb4IRDNlfiBaZavf/O5QG3BInUk2ppMO9GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2oICNrQ1xwCDaEpKno9l01thkboCAbHyhE5Bxiua46I=;
 b=UNDdmsNqw5D7/TF6lFL9C/1o6YYLvxzlOFuluCeOjOPIPqGzWJLVlT9ZbsT+y8jFlydEnW5iNZjb9T7AL25Ze4C9fWAh4nkP8bIN5/M7iXi/va5rD2bnZY9+0JQNL1w+5YVhmuLrOQEXK9ziVvN6X9I7p5pulOE5Nn8P3oeWNkmho7UYvKnJLYL0mvUpTRJGAXO1J7G6+BVrQT/nsoDjt5xjNZ2rzWxBEvWQdgLWAC33uW16oR2NXzRKd8DD69XhUE6U1okKO2as+KY26SGS76V3njS9qS66UbLg0hbdaPpJwlJyarSXABOjpwH+F2oLdhYaM+A/KUFK1l1q0LEGOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2oICNrQ1xwCDaEpKno9l01thkboCAbHyhE5Bxiua46I=;
 b=h9WdVY9lBOR3E5jQcBvXUeJWXqpfVejS1wt1+QEa0tzSEkMEFqncnd1f9i6LcXFYPE4Lua4hzShIz6qR9aTS2HxpD+gNrknrERpeIHZGhRv5fz92bCj9OSy3/BGyWs6t4vYBIOStTdagwjQIFA6O1LpLdd7xkknKBBfU5Agd5rUc6GAxpUXSqQu2etTriBr4JfjjuP96Uof5A/KJ25pgWSIzqowT5gMZAAvIPx5ag9sAPAcpDvvYL7h8EHr390Vbsj+Jkx4qZNxd202DeVWVxRGKfegMULg0btJbUluiYBz4zkOrc7JkM1TxbtpYwZ1jUpGI2jsblibF8YlCAycm6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB8248.namprd12.prod.outlook.com (2603:10b6:8:f3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 19:45:51 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 19:45:51 +0000
Date: Mon, 6 Jul 2026 16:45:47 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>,
	David Matlack <dmatlack@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	Pranjal Shrivastava <praan@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH v2 7/8] iommu/arm-smmu-v3: Change how the tlbi describes
 the invalidation
Message-ID: <20260706194547.GC118313@nvidia.com>
References: <7-v2-43074a57a53a+fb95-smmu_tlbi_jgg@nvidia.com>
 <f351b3ce-6488-4b8c-a28a-a3cb0b827750@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f351b3ce-6488-4b8c-a28a-a3cb0b827750@arm.com>
X-ClientProxiedBy: YT4P288CA0005.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::27) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB8248:EE_
X-MS-Office365-Filtering-Correlation-Id: 97079076-78ea-4a70-215f-08dedb972db5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|18002099003|11063799006|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	hMeCR8GiJw5GmRuTMPt6DxtqMwqTe7z7DTnu52JruT7eX01eiQ9pj87klOO26X6KiAlqX1qDNNlDNaAeB2v32QL8muPvYdNcu6M6dv7xJITQKkzcQK8fHqphViTZQ8ggh/i0w/HcSszC6B8zM3ZT48hCnrD/yIfwkRYFzAWDVRSLYa8Fog3jFfU2kXvyCHv6DRbdMMGiJ0WFa33O/5QmVQ9QimENhLjvCBXzx6M0SBqAaqvxIuNGkQiwiWn9o5XJG21fRPuBi3GeffETwE4JXDDH8Bu8kcpTiOUf1OlAspTVRbUuL/v/5EZjjwz8nLuorDab4owb2VwJjTOaIZSNLWK808hPyP8faH1o7jKh1N0i8zMDWqdUsJVveFt4b7+CguEIUQPNdx+dV3YWuv/DWLsGROIudS6I598MVmjLOefQ1WBFVDKbF/AmxbDMVEDVMVuLRzm1NKtIWL0ouEmBVi6YMcxyYFp4Kvl/UOdUZgVPWyV4jnijsJryo98/7kH6yZ6pZDZjSh3Z1ncwK6Ma8lj18ivVX5LgREn/bWBzF/MDneyCpNBZCyKfTRvkrL8QKqu+Cp6ctoaz+xV5r/inm+0xgzaCiJppNdir2Oo5bE1LoD0uN3StAxs6SOL5rDUbskAps6WsOJD44z+eBUyONgxfMn8gtQt7w9vc5ElDufU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(11063799006)(22082099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EA4I11rfCvflLhq0LbaO9agKvxsnUMhhx6n4VgqJXssXZJHjQ78bX+ZR0XZP?=
 =?us-ascii?Q?2Anf+UXHdnawSsLONNPHvIiG0ID79AuDkI+8cCXTUYUc+o52nIqqwYcVy+r2?=
 =?us-ascii?Q?688igMIm64m5Zhb0J04bLUrx8IHXr2Dv7NA3Zg3Uqox5i8P6VI+5NVnbkAEL?=
 =?us-ascii?Q?ZF0onW3nV+EB+GsTKUBQSVr9oxwYuZNlBZYMx0T/+iI64Fk9nFKWGqOP937n?=
 =?us-ascii?Q?37bgtyqlQiXENSITze01KyUypLrHhTl4nE/mA+gkxZUizmu/oZgxcsx4bKWk?=
 =?us-ascii?Q?jPgZHjiQ8Or2OSeaX3XDLTMmpaeYiaaJ+3gectFnmz+mKiAiveU/jtKmlmVI?=
 =?us-ascii?Q?D7Z8eA2r18DZL6i5sFoz0Q0UktxaryIf1i2t8BfkXikR5+XFNL5/q2XwhgC6?=
 =?us-ascii?Q?db2wVrET6YPe8E6PesTdRNht82kHwFWynLC/P8JgDlQD/nnypGLf3/xFLxkP?=
 =?us-ascii?Q?dRujviSPJtGIiycjqsYnW6hzj5KU6KyezO6ec+nUrocqBJKZrp1bxG5UIDBQ?=
 =?us-ascii?Q?5emzjxtY2yoGvz86FM74Fjp2lWcUC8QuWLpEU5t/BiWXPh/tlnhzp17WgLUF?=
 =?us-ascii?Q?YDWV3r+zv/dPhfoOC5dq/S05sctyKQs0ib9M4/85CzvW1IGWNgdFfqyvB5Zt?=
 =?us-ascii?Q?t4UHRX4GIgTYJRFicepmHpswYxkc+4PlKpdZoExeAxQUTEeADZ9P8yl5dogc?=
 =?us-ascii?Q?S31BmQGirpC/idNJItOeXrGwdg1rBYD6pKD2p9O6O1im+ZM4eH7YFeU1zxc6?=
 =?us-ascii?Q?Keh1RmMFVEy8I+isN00YdVGKv3Xv0v4n+ueaW4U5v5s6T+DHkCB6oIPLifrr?=
 =?us-ascii?Q?wk4XxD+HVgFHmRFyudnGOyyk3cWL2gjPi5Mg/GF9pc884FMA/hmmzAnP2yDw?=
 =?us-ascii?Q?0AojL5VBfZlug7GvPUwO808xCOChhngUFUsM3m2ZoZ4VI6xHM3E2zavCXt3M?=
 =?us-ascii?Q?2C4/SfARh5M1Zg9HfBVGlB7Dswj8EBLeQlkMSVl7JldhDevA/0u3IDOVcJob?=
 =?us-ascii?Q?uxGYy0jyGzasmjbkfzEboViaYEVJNJD/nRgc/GAmxdRP480qrYO+XQVmsZQe?=
 =?us-ascii?Q?VWa1uADhwqvTRtm7EWs8o7drSbFmIdYqe8p5W0z9VTEKlW0mG+kSPbWADltR?=
 =?us-ascii?Q?IFHo3PBx511oAHBQ8UMCGyMf4qoSrzqwPLnctbLg8qRvaKwYwaVltIn3Fm5G?=
 =?us-ascii?Q?0IFKkpF8vMGAgJQzNTKZ8LPspUzK6WL+SvpPx9f4XBayuKvDAEtUcBw6D5hv?=
 =?us-ascii?Q?3nV7u9Q4/NpMLIiThz/goVYd08uiCnQPXOlKsDwPeW7xhAEkj70spKkU3OQx?=
 =?us-ascii?Q?tz5ceZQv+z2WeDU4XsBZGmHLwULS90yLCCKi+VjwJ3F/S/kFsU8vhtjxycMe?=
 =?us-ascii?Q?wjyqwUGMXdoFX30JfRM5q6DjlxBsNK6OXTAtet/9fkLlIyAhKp73MFy3vg9R?=
 =?us-ascii?Q?g/8xwqHt0aRcyYNxrTNDUlgwHO1uEQcnT5oDLmsEhd5gvNbHi/Z5f66I5mNO?=
 =?us-ascii?Q?jcV9Gpcl6jJ1gVzatdbTBeO5obOC1KUVCVI6NineDPbNGyXUCvYmTEnmW3ky?=
 =?us-ascii?Q?WogDE5L0JjWWo+egqueUvI7KHmPJc8AyPDNG/ev4M6DBmEyW9g17IT5SOFpJ?=
 =?us-ascii?Q?OQXJv6uHUQgV0j2SvH8RKD7WEJoTdrewv/uyephE7RjQF+37P29VcTWwEJq0?=
 =?us-ascii?Q?WO4aMBcYbuhcysFeslsULaVOUQKw/TPJxfK7MLhlk6+A9nkM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97079076-78ea-4a70-215f-08dedb972db5
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 19:45:48.8422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nKmb3dGNCA2p/DY7uU0F6kvc/dlzS/hY2eVecqkqyBeZ+dP40AqF9U/rvp8/rBws
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8248

On Mon, Jul 06, 2026 at 07:00:15PM +0100, Robin Murphy wrote:
> On 2026-07-06 5:26 pm, Jason Gunthorpe wrote:
> [...]
> >   /*
> > - * Generate a single range TLBI command covering [iova, iova+size). Sets
> > + * Compute the TTL hint from leaf/table level bitmaps. 0 ttlt means no hint
> > + * invalidate all levels.
> > + */
> > +static unsigned int arm_smmu_compute_ttl(u8 leaf_bitmap, u8 table_bitmap,
> > +					 unsigned int tg)
> > +{
> > +	int ttl;
> > +
> > +	if (leaf_bitmap) {
> > +		if (is_power_of_2(leaf_bitmap))
> > +			ttl = 3 - (int)__ffs(leaf_bitmap);
> > +		else
> > +			ttl = 0;
> > +
> > +		if (table_bitmap) {
> > +			int table_ttl = 3 - (int)__ffs(table_bitmap) + 1;
> > +
> > +			/*
> > +			 * A RIL invalidation with !leaf_only clears out all
> > +			 * table levels above the leaf level ttl only.
> > +			 */
> > +			if (table_ttl > ttl)
> > +				ttl = 0;
> > +		}
> > +	} else if (table_bitmap) {
> > +		ttl = 3 - (int)__ffs(table_bitmap) + 1;
> 
> Maybe I'm misunderstanding what table_bitmap represents, but whichever way:
> - if this case means purely changes to table (i.e. non-leaf) PTEs
> themselves, then calculating any leaf level is pretty pointless.

Yeah, it means this.

RIL doesn't have a table-only mode, it always includes leaf
invalidation. So my reasoning is the best RIL to form has a TTL which
hints the fewest leaves, meaning the leaf level below the target
tables.

I guess 0/no-hint is the only other choice, do you think it is better?

FWIW, a future feature I've talked about to remove unused tables would
generate table only gathers, but currently it should be impossible.

> > +	/* 16K granule, ARM TTL=1 is reserved (SMMUv3 F.b Section 4.4.1) */
> > +	if (tg == 14 && ttl == 1)
> > +		return 0;
> 
> It's reserved in the absence of LPA2, i.e. when DS=0 (side note, please
> refer to an up-to-date version of the architecture - F.b is pretty old by
> now) 

Oh, I see the note is ment to be read that TTL=0b01 is legal when DS=1
and works normally..

> VA. If between the caller and the code above we can calculate that a block
> entry exists where it cannot, then something is wrong and needs fixing
> properly.

Yes for leaves, but, the above is mixing tables into this as well, so
at this point there can be ttl's for any point in the tree except the
top most level, hence the check.

If table-only changes to use TTL=0 then this could be a WARN_ON to
detect malformed gathers.

> > +	/* ARM levels -1 and 0 cannot be hinted */
> > +	if (ttl <= 0 || ttl > 3)
> > +		return 0;
> 
> Similarly, no format allows blocks at level -1, so again if that check ever
> did anything we'd already have bigger problems. In the remaining case, 4KB
> with 52-bit VA *does* permit blocks at level 0, but it should hopefully be
> obvious why that doesn't need special treatment here either...

Yes, the -1 test can be WARN_ON as it is a malformed gather.
The 0 level is just a comment than it isn't actually a hint
anymore. I'll adjust them

Thanks,
Jason
