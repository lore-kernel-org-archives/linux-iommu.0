Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013017.outbound.protection.outlook.com [52.101.83.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB14355049
	for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 14:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790086182; cv=fail; b=so+i7tI3pQ4GbJLuxXbfcmsX681+8T7W93mNTVg7etzlrxCQtChOe5CGXfeZqrMKBw9ycClWXktaXctzJHpbwwhg4w2jyUlIo0zM4/Fm6JzsBiwdnNc0LftMMhIlkktX+mgFwkMHbr5RDzqVqTrA9bVigK302cIICWYRzLDsDzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790086182; c=relaxed/simple;
	bh=427QmRfvF+Uf04Yg98jhCbDTDSLrDWWZAz1S3ZF2png=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kaMpxAq11Vi2+om+FQtByi+iS11FFzIILk6I903rnmA1hBU+G2vbsrhV1ODCglDywXiggG6VYk3QXzOvSErSMzPqC+B/bGgfO2qOvil6mWQtcQ95vTIOdyLqaYFmDk4YebjczDn3nnMSm7Xfmev32IeZcQkMP0DRvYFhCr7jG6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=U2M6NdbD; arc=fail smtp.client-ip=52.101.83.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="U2M6NdbD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oAUUQLPcxZlSd2Mfc/wSO17+HW56P/FTYRIRgmpIZxcgjitLLlA2fxaQfoI1a/LgeIqHaoYJOsB3/8il2EsA2GF3ibzF8p0L+kP53h/xDq5XpWQnxLmnIq8efkEC5gBWfDlDPtz35qRqUpHZcQaMkFlANrp1JfCe4PlT/omKok3LE2JmgGWE3RRZZTv0f79VgY1KJ0yFOl/lPmAXMg3vZXNJ580laA8I49lHNPc+5+5TtbKFeuEP9VbfbxQX/dRrPaLc3Oc0rqIzf0nlQ2VhsHl/K2rgSHPM9ptowIfuDmDEkwpg/2Mc5UZFQm5NG1NrguMvLM7JytYhYMRUGnN2ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcEmOegIQstPE4tx/39/EBfjM/ApKso1D+9TEGy2Uyk=;
 b=A6AtLZ8n33bsq+kHdab1G1klGV2v/Cy2vDPhMrjN9ziOAFOlWHJ3o2eKOxlay3PDIBEfG6x1BSHhALKja9dM3oQFfIhyAa/E/XY7b27eWRMjCLTU4/ZQnz11rxMqIZxkS12V9qYfDBUGr7ew8d7VdeMb6nBrx+CkyqNOcDDa+N696zM74KDUlNd0bXEdUstfnKLLJ2fBD7paedf3SPZfHmFHJTwG8MKo8owltjHmPh6dv5OnUtT4IFcm8/uYt0ewJUhRaKaeaAfnSH7ScKmLe8fTlxWn9S2/pnRrgbnC4lFDShz4XSGDqfa3QaYZnQdxhUAopudV07QxEcoUaT10vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcEmOegIQstPE4tx/39/EBfjM/ApKso1D+9TEGy2Uyk=;
 b=U2M6NdbDo+/KGGn/gBmAnNsO6IjNHYBMRDaZWAkugLbLxFaY80JoF96FSXl9qb2/C7Bj69UtRYhlanTzXRijrOGH/+/vozs9mC/IMr2yByXWAXIbIqvEIVgrBzeTqe17icJW9GeE/RzgmT9AR3E3/+tyzO5wsCrtThzQcOmLbZc9J9iy4GQKOtvmsBzOGrV8lUkWJvBC9vVTZzozC6uC0A6ahnxHCx1GdtZYhXstFDuyo2QMxiuSVKQX0arIdgYcWmlsxVbV45MD/NIh0xKvuw2bNl6m+L2orwgbntYF0m2YXjN9QCjYLYD9mIFQqWHm0/HSGpXQ3Oz6zTYruUmEiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by OSKPR04MB11343.eurprd04.prod.outlook.com (2603:10a6:e10:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 14:09:36 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 14:09:35 +0000
Date: Tue, 22 Sep 2026 22:13:56 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jpb@kernel.org,
	jgg@ziepe.ca, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	peng.fan@nxp.com
Subject: Re: [PATCH RFC v2 2/4] iommu/arm-smmu-v3: Support shared SIDs in
 insert/remove_master
Message-ID: <arKNJH2YWQT9KL7x@shlinux89>
References: <20260921-smmu-shared-sid-v2-0-4b656ce68178@nxp.com>
 <20260921123846.1663580-1-peng.fan@oss.nxp.com>
 <arG6hmng3NddGEHm@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arG6hmng3NddGEHm@nvidia.com>
X-ClientProxiedBy: MA0PR01CA0107.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::15) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|OSKPR04MB11343:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fa7ecef-ce9f-4288-9faa-08df18b321c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|23010399003|18002099003|22082099003|11063799006|10067099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	dnJarWEIPb6WwQse465wJ2dG253u/uUOjNWr61WHuv7MNkkPnaJyjdCV07b53w6q2q25RTvzITNt90ZB1MkZ4Y2AnAvzWOOmqkKTEBlkvw4+r+qyGaM49f7ZzmqRPAST1IqqgBhrQBBDyM392mdbFAuoTbUK6jvTmsR3P/xj60hGFhFiF/Eciwrg1PwTIYDUZifvTTnXxlYCxN7YcNmYJN2CaWO6dPlCByq6b17j2sTNYJpXAOGcJxHqsSRe0Tg0CGA74tMgjpPH8X2JEmjGsqvjvl+rEW4GLfxpG2iEcCNgFlY6EkD6Uoz5UcFZKkxGN4xjfMV/5TYoAaemAnWM3ObnYb60X3SEcYSOWD8xlfNphX/Usi9W8Zwsv2wMYgugfzmSgtVn3FtKkAgo9+2lc5dBQivnU1GgQ6s8iW3ux6VJ81+Q79i1sPVQ+7G0F97VQ4iXK5ybhnTITNrBP5GibPf4W7mwdaYo4lRyq1a03GfA8FqsxCgHchsyWpD05t7PN9i1HORgep62iqu6dDjy4aRnNf0/tNJd7B6ueKQUrghLEqxBkuJPvA/7XDhLx3an+sFW5fArjpNlv1bBkAtp8lGaEIwp4P4bYpC+pDB+FgvWa/V/xWIKmGyiDlMLS6FJw5+/CZ11OTInt0lRbzj2tb6G1GPiSnDKw0Hs/CNxQQo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(23010399003)(18002099003)(22082099003)(11063799006)(10067099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PfAc2O04aeG6ILpWQ38Abjug64jJC7nqaLND5UUltwhZ9PRcUj4YzXwwtnK0?=
 =?us-ascii?Q?AE6n6lBFg6twKd4QTiQrh4AyCKrHo9Jl8OBjB281E1ePAm641H1oz2ChKi+E?=
 =?us-ascii?Q?ZIbvR092dXbRoYrt1QSgA44XJfa6QbwYEYRjPeRZL9ZmvU0pYk7sxXXiYlPJ?=
 =?us-ascii?Q?3jHeHlONyzcNcYNh/IO7S0CDINQcp2QETDv0atagLeTB9zhIiiZnYlM9RT5g?=
 =?us-ascii?Q?aZWA1RMA3h4yJ9P68exuoJi0jiqo3hbcNS0nqUg1vwl4StbI8gYErK/4cFUS?=
 =?us-ascii?Q?5D15aaGHX0vAyDULySjZSYkX1KEbGlcmMzttL/Fk6PqF448Pmz2VzarsY69v?=
 =?us-ascii?Q?7JMtNWzt5StGsL/ZvI4lyQEhn5gH5qw9W8MhqM3QGfujisY7IllVrumfR8VS?=
 =?us-ascii?Q?YqvrxYXXOaa5IpJ5xSgbCqsYO4jkyHAyGQpo/3tDsYfjzjB/eC6uIQov3UTp?=
 =?us-ascii?Q?bmp7Ab9osBQbJ5bmjFRtq7d96lowl77Y1zbNERC5fMmYpGx4ZqPG4qxYumXx?=
 =?us-ascii?Q?9sUAFzj+KeCvM81KN0eUFoEAENSZhpcgylEYIe7em5wvSiSL+CjPBnFoncKK?=
 =?us-ascii?Q?25cMnyl6PqXMYxjV109ZDfT4C5/XYhh3gEP42VL+r8vMCiQ4iVOap8FejoWv?=
 =?us-ascii?Q?wXNt1OavOGJdLMXTMVA5s2nS17cDIUh14Z63d+mR9Wani/2WcLK+j+G65n5T?=
 =?us-ascii?Q?0gEgIHtoVDkJ/FbBGyl9i7uhm7eANGx4+f14ebMe/O0TSRQbUxTPvQ4uiKk4?=
 =?us-ascii?Q?rXhKqCyBqVgYbEyJ2Vt1rjI2V3WMRrdapqmpcmYTIA1u164KCNpx/TAoxrdg?=
 =?us-ascii?Q?3bSGBn3biyoGcTZPkodzqfd1jYQl+qpTPD9Eus4kgX0NmFaNK/JtcZfokZ+X?=
 =?us-ascii?Q?dSA6KBf5AFiV9oStChOPQIMQ153WZEU99BjGHigV9mDXLdWat+XIy0XP9OJI?=
 =?us-ascii?Q?KRmb3tfoavxGtZCXsSZHsWTTX4xjEpb8embkMv3SgG9MyBW4u/479Ux47VtL?=
 =?us-ascii?Q?1DTKb8y8YmLe00um6aYLM6aQSX/CvESSEHPJJzsdoEiov0EvbZkBfcSK83s6?=
 =?us-ascii?Q?tfr7tjMkVXjb1Xi5BhEnSh2x2QVeaiZ4+QVCq1FVsXtzZzpP7Pcp6og4xiJr?=
 =?us-ascii?Q?jRbRbj91VhQnltz4GIi6pjOs9RSQwOqNEz1t8U2cEYUiFkHTBfjl9DoDmh1N?=
 =?us-ascii?Q?ExGi+AxDN2lfGEMra4YgRJltycSm5uLpuC8odjYqfR3L6oTHxCNYLHVU+B2V?=
 =?us-ascii?Q?dzw0IhCX1wDAlBYNasf8TM5eJ4zBJtaBgdqmPGe48Yrmz+qOAZPoIDxBTv1G?=
 =?us-ascii?Q?dLTfNE0rWc1aJWUh/e+dCFUn3lVdthYPN5oPvSqHDleBOOrLBiwpZIfgtCx5?=
 =?us-ascii?Q?bFFrX/YE/qRF+Ys5VyyKkH0KlpxW5mOfYgzDfNBpqXiC9n9f49T4Bf/Fan8H?=
 =?us-ascii?Q?6Ks+Up9EXzFj74KIXm0QvH3TFL/BP+fCR23E0rNFsll+WmlMKgyj5ohzCzp2?=
 =?us-ascii?Q?09sH5qinViQnNektNhtaQX3rJedFazryIgq0sGg9/AEnKeiY6KtmX4XpeVMD?=
 =?us-ascii?Q?VJr61S6ifgD2BX6RchNE8ymCtQAiAYHCfmlJdsCjbBC09RKABfdzT/7Eu9pX?=
 =?us-ascii?Q?qXeDcpYouVjTHyrh8voUMs+PcHPNmpVilcw/zngaZw/NqPAkGMLMRlHHnHAA?=
 =?us-ascii?Q?fNA4qmXeArKys5BomCNsBgJuuv30VKOpnKlrg5KPKVwdpgoq9/Evs+M+53gk?=
 =?us-ascii?Q?c3LSXZvxBL3AS54tCOaVp272t2RW6wC7aIURCCi5p0WsZaGhaZA3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa7ecef-ce9f-4288-9faa-08df18b321c5
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 14:09:35.6423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3lJo7gCWHIfm0ta7365ciGUgwPSFia1Bvx81zl4lJEv8E21x/q60nOH+gXL89/8WSs4si+FZjidCLs+ocSUbj0774rEjqSggpwFnZemZTzsqqvjzSXHh+Rf5V4voY8yz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR04MB11343

On Mon, Sep 21, 2026 at 04:15:18PM -0700, Nicolin Chen wrote:
>On Mon, Sep 21, 2026 at 08:38:46PM +0800, Peng Fan (OSS) wrote:
>> @@ -976,6 +976,24 @@ struct arm_smmu_device {
>>  struct arm_smmu_stream {
>>  	u32				id;
>>  	struct arm_smmu_master		*master;
>> +	/*
>> +	 * ref_count > 1 means multiple masters share this SID.  Protected by
>> +	 * smmu->streams_mutex.
>> +	 */
>> +	unsigned int			ref_count;
>> +	/*
>> +	 * When ref_count > 1 the STE has already been written by the first
>> +	 * master; subsequent masters must skip the write.
>> +	 */
>> +	bool				ste_installed;
>> +	/*
>> +	 * Links all arm_smmu_stream objects that share the same SID across
>> +	 * different masters.  The canonical (XArray-stored) entry is the list
>> +	 * head; non-owning sharers are linked into it.  Used to transfer
>> +	 * XArray ownership when the current owner is removed.
>> +	 * Protected by smmu->streams_mutex.
>> +	 */
>> +	struct list_head		shared_link;
>>  };
>
>SID-sharing masters still allocate their own streams. Though the
>SIDs are the same number, they own duplicated streams linked via
>that "shared_link" list.
>
>  master_a->stream[0] --> stream (SID=X) --|
>                                      shared_link
>  master_b->stream[0] --> stream (SID=X) --|
>
>But maybe they could share the stream structure directly? I.e.
>
>  master_a->stream[0] --|
>                        |--> shared stream (SID=X)
>  master_b->stream[0] --|
>
>
>The stream structure would still need a list for shared_masters:
>
>struct arm_smmu_stream {
>[...]
>	/* Every sharing master, ->master included. Empty unless shared */
>	struct list_head shared_masters;
>};
>
>ref_count could be simply !list_empty(&stream->shared_masters).

Agree.

>
>
>Does i.MX need to support SID-sharing with multi-SD device? If not,
>the master could have only a simple shared_masters_elm:

For i.MX, there is no need to support SID sharing for multi-SID device for now.
Not sure, in future there are cases that needs SID sharing for multi-SID device.

I could update in V3 following your suggestion.

Thanks,
Peng

>
>struct arm_smmu_master {
>[....]
>	/* Supports num_streams == 1 only. Empty if SID is not shared */
>	struct list_head shared_masters_elm;
>};
>
>> @@ -1024,6 +1042,11 @@ struct arm_smmu_master {
>>  	bool				ste_ats_enabled : 1;
>>  	bool				stall_enabled;
>>  	bool				ats_always_on;
>> +	/*
>> +	 * True when at least one of this master's SIDs is shared with another
>> +	 * master.  SVA, stall and IOPF are disabled for such masters.
>> +	 */
>> +	bool				shared_sid;
>
>Then, this could be !list_empty(&master->shared_masters_elm).
>
>Nicolin
>
>
