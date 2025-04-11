Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37484F507
	for <iommu@lists.linux.dev>; Fri, 11 Apr 2025 13:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744376523; cv=fail; b=f1ctdzH4etkwrXo78CSItGGOmZAqqOjWvpAOfcmzg4OT3LTFekvzOCTGGmRbM2CnGmpzqNUX77q/Z1aCa//gYkzV8VgmbTyoTqU7AWfMcm9/5BtB+F3K1L2jnGbwPpxWJhcwoWyP0e0twFneoLMGg4qTfG/7CZIJbTKSXHSBiUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744376523; c=relaxed/simple;
	bh=HmLQ1fWEeKZO3rHcd4SzSkLqjzIzVlMfvsgE4O19HZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bAmjUVaPUdhgnmUHoS0etqHO63jXrcqcPRXRqHPHLpPMv5rcttwaThwGIAe/IwdNkN1EMKIh2JqT5lxdrCPl952nFkZ/cov/n4MGqAjLH/ODbbgqNc5UPJn323U5wQculKmT7T0ryl03B23dmnMz0OcRwxDYrNAQTeXn9Yqm4hU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y7+L7LJJ; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y7+L7LJJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OsW9Kc/8oIaOrOraglQU2nnx2ILxYzeqJf0JFY870Bcf5ShY0lyC+8rantxaDoXxGMAutgG5cuzm5O9czqxvJgTIpzsssWm0i4ramwuxGiZH/lie1YhsOBB0ge5YAwMEHzq7zxViNqXP/joPF18tIkZCLC9kic0Hx1aKN4lEKdVN36RDzUhsGC7XaxkVaAkIgtZfGhiuzXwmWZ3de4PeZWHdjupyxUYdOOCgnzQ/C2w89r9n7jYE4EDN/pS669FAPVVBweSKhtG9AxceTw5hdTf+805PR918IPxGk5cihoNuFeU11voqaSl6Ikz6pStJly+QkNHqslcibKSrRi/DDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3AGtIGWH8NHFWzOxWB2hmsXtv9v9i7UtYdrDysKbtE=;
 b=c3nKh4Pv+UM7gfOwb+ksEhhYdNCNKIcs690oDhKVaNE4FMgkuzUcG6MLIAvMAJLrbjVWiFQ+OGvdSG9SAWeL27qZbgLqwou0VjSESk560t0c6iDDOk5wNCDBk0VzCqfCJ85zu9ghLwLpyk8yZD4eN/uUehgydyvFa6hc2nDZwSc7rs8A8dkf5AvOaNRXRd3FGETb+FsiSM5dJT1sCWzI4Q9fXvptyuYXY8mmQMTgUPAx23vGUJfbDzuz02FEXWykBPczxhTydveQOOcL/RGWZJxezJRNJeIeOgzItz9q4NDyCXNwaKxqdm0Pu93BPQDEi8YS33ybD7lbmmWr2abATA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3AGtIGWH8NHFWzOxWB2hmsXtv9v9i7UtYdrDysKbtE=;
 b=Y7+L7LJJLOnqGn5ilr71S6G8nlsMbuNISKSAUTSSMpWL9UcaWJhvPmtTNMH5cgnVsePCyHnAv0d2E6IWUz4cvKzOUrMsQaGv4sfOlBWyzL5nI0Yj6YSZq1s4XryOLT/y/nOf7RLJMzTG2QHeXJSmE5dOm0HQ0ED/QQHIYbWKI+qdooP3qIAISmaXpaUQmib0GYddlLJHcwMf9KC9lgZfnt2uvn6zNJ/Uw2oUnLRRAk9jLnf8Kpwsea8A/QJXBhXu/V6OBUpxxdLF8A5ubUvFAsamIzfccg0ON4ImHuko5bBA1Z3z7HwNWK3JJMK5x+KNXHj1rb8M4lYVljOazV3YRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN0PR12MB5929.namprd12.prod.outlook.com (2603:10b6:208:37c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 13:01:57 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8606.028; Fri, 11 Apr 2025
 13:01:56 +0000
Date: Fri, 11 Apr 2025 10:01:55 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org, joro@8bytes.org,
	jsnitsel@redhat.com, praan@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Allow stream table to have nodes with
 the same ID
Message-ID: <20250411130155.GD8423@nvidia.com>
References: <20250411044706.356395-1-nicolinc@nvidia.com>
 <b62f5ea3-99cd-4e9e-a2a8-cb325308ed34@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b62f5ea3-99cd-4e9e-a2a8-cb325308ed34@arm.com>
X-ClientProxiedBy: MN2PR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:208:fc::15) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN0PR12MB5929:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bc0f0a9-f621-49e6-e093-08dd78f909b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2VjIEkWTsjz4uk4inXaa7SGxO4mn1w5xKn07vnx1XF7VygBZ6ykJfv4TkfN/?=
 =?us-ascii?Q?et5wi0xHHQJu9OzWr8AiYBL1zPktfXKTOwMI2xdUV1pFCd5BjR4uLv5SBNqu?=
 =?us-ascii?Q?PXnCIiSjVQVNrDvKrhtYYNjRmKRja0fgFB3QkEx7wxoJA6ae8cujwpVp5pPy?=
 =?us-ascii?Q?2NzkhKiluS3JfL5m0816fXrVm4CdvTdZSkB7kp8CspScYS/6x+KtkhMQH0cZ?=
 =?us-ascii?Q?Fq0IpE0Qry7dDsF2h9BCShQ9raPsNGGfAdfaA2pkUQN9k5IcpA20VoTM5t2c?=
 =?us-ascii?Q?9J1lWtUpJXFYLVNiu35zkEL0uc1oJePRWSf5EbLMPRFZjWi3hWBJq50G9Kri?=
 =?us-ascii?Q?aJaduhJRpzFiu35KIXMZuVGb74581tjLQQSTDx/ZAql1lFZDv46qKoDHCoNp?=
 =?us-ascii?Q?+fqq9xPVf3KQ0H+5/ZlnLBQpnpIPUVKabUyqmr3xqYSm/aVRxcdGQw9oO+6M?=
 =?us-ascii?Q?Zi+FhymKVvnu7ZJyPwNQzUnSWh8AEL4tqirLr7ZrxrSvJ3NNkqwswHRSimFv?=
 =?us-ascii?Q?znTC7/kJ93w4KRKlL8EZpIfSuQLtb7a1OUPNPAtuLIp4bUQvbSU3KYrbZdOS?=
 =?us-ascii?Q?U7mobSr1A8TPNQgZTFwQ1TuP/AskXm2pjKCnmwTgISNZSwL5qhJe9jpiaCgd?=
 =?us-ascii?Q?Ayn98ddoxhJCUVbl4mec2JgS1D775pqdLeIezC/tjI6TS3D0GxbNDKN0XGVp?=
 =?us-ascii?Q?jk93nKotqwteFPa/qeIkMiEpI5fBcX3AHjOhxNzDxBRbXhuBR+9Y/3GR+99C?=
 =?us-ascii?Q?NqgRaiObS8T5lXABe2tuOAELn5YOja+tzOuMrNiRicjg4XT+C185qTCtS2Ao?=
 =?us-ascii?Q?D/tI+JQ2vF0go7CBg1ne4R9hQXgXjZu8p36EDncw3aDexs/EyT9TveCcrLtd?=
 =?us-ascii?Q?NZI4Dkr32pDfA6QrayUBaQat24fvfZjLq9VmeMr4RT5DGiSZSpYwgtNT6VTN?=
 =?us-ascii?Q?FJhH7JUtaAFp+WLVwZIB5ZhEr4BE7duegZ6HVDexXWIJy8U6q/AfhWEMZYAq?=
 =?us-ascii?Q?WCWJxself76RMa5vjz+9dxfBPmSC5tTN2luhvX72G+p6Nh/11A96s54ZfJ5a?=
 =?us-ascii?Q?wSKM3cx6QY2n2OicSOAvJXOz2J3qTisDVbO7JrDfOEBAMg1ZYWueCiTL5c1x?=
 =?us-ascii?Q?vuJ4x9Xatg+qtrpNPHdiewhaxZBBTu6si3MqwuwNlBF0e5IY6GXD1Yzwjwru?=
 =?us-ascii?Q?xZi0ylFO+yHTFebdEp3KNcmxAFJEubjWk/VpoHo1pgNTJDUQQcYDxTVJHX/g?=
 =?us-ascii?Q?RjJpB0roqL6sgnhLivvIvIhY67pF9uiKKajsP8DRCRKEhjoJQhUw1fWPz1Sk?=
 =?us-ascii?Q?aCe6b8y9kWFD92h/QbP0do4rjNGPDx5HO1/yYNzHb1rHlaJ3znhPOVPN1RFq?=
 =?us-ascii?Q?GciQTFxz+UJLySXX76Cvia7RDarmIy0IdsP0UkaVAM1djt8wnhcNMHXL6V+g?=
 =?us-ascii?Q?n+lipEsR22M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4Q/pCBSKeKhh0ojPURW7mlQsjxpK+pBAuv+8bzh8bZOI3bpQo8XVFwAY4klC?=
 =?us-ascii?Q?QsR6OSW+5g7QSr+JarlOmdFAEtDL26VFhPlArm8+HMo8RccSFo7rUlLW7crD?=
 =?us-ascii?Q?JTHQajkzhptg64fW+gNHesDPCLTODG4+Nfk2NA6E3VI93ozm0bivKHWn971K?=
 =?us-ascii?Q?JAa9OeqNejjamMATnSA5qoSrV8kYNqmKripEJUo3PfEgPedAGBsPHI0yB0zQ?=
 =?us-ascii?Q?H4LD4mPow0PNMOonx4aytovBv4/OzBNPeieDLOckRgHrXfgaeTzVHRfpXWim?=
 =?us-ascii?Q?kLkhzWVfyeegehUbJldLMICXdyN8LEfsoqG47SkkE48KosTio3WkheIoxOLh?=
 =?us-ascii?Q?N1JfpqWlEprv+a6RepxFafplPgjmEQCjiK8JpVfRLcMqHO06HtB6PEAE0mpm?=
 =?us-ascii?Q?iAX1LbwK3QwTaAjQL8joQJMnHk11zNKsKgPwvYQbAHCU66Kv9h6lUz4ov0Ui?=
 =?us-ascii?Q?4M7pAb6PcHChBIi4LpG/6Tk1XH2fNHAFdhx9aLb1JXpy5VNv/CDII5WeY/S/?=
 =?us-ascii?Q?YsRPHvcKaIPSvx8UnyiozgmDap/tyrX4wblq/JKSPTDrfFzNJ/DxkLOMrm35?=
 =?us-ascii?Q?mMccCbjfCGKUDrniQI8qsMBaPlx/U2Aj93LSzZQhKcB6aWdBgKwf9CTmQjS3?=
 =?us-ascii?Q?2mkdJmXS2JMzrHhOQ40nBS3iFY3iBmpyco5Gdzuzz+qtJKEdZ0mpSqjHXaq6?=
 =?us-ascii?Q?rRIY+Sablm3iL5eLjX1JQAUdgg2u67lxqZ5NAMY9o9EO7SFPlQC5gvtE0jcn?=
 =?us-ascii?Q?78H69bOoW8mzmAWE8Cmx3z1340c5AL4HHSC8Q0S7wZhmC8F7vATFpyyD0LVf?=
 =?us-ascii?Q?qZiekkvM8/doggDMkvWl3E5cE8ArTQsyjzQwq5In9N2NYDdIWaWukcKBm2WM?=
 =?us-ascii?Q?FrlgkToP1tL5cTkOzzyzRzsY9h7eRbsdgheIUTAy6t0yI57u9O5aubLQNBRm?=
 =?us-ascii?Q?qvahahNkXq9B89rE+jQVQ8KJmYVBMwBFueH1E9XUzi/wEr/1Ni1fbLqpw82g?=
 =?us-ascii?Q?qxpd0qM6x6+tha5czPwN/lajEN0Kgcq1xLV6OnBC5W4raaTYldICFk4j1XK3?=
 =?us-ascii?Q?tHRQ5/6b7dBZM9ARwzNwyUmBeKn/6k2zgVtNeLt0Mdf3pKN1Bonteq7IPTzl?=
 =?us-ascii?Q?LKVCTozZk3DUR4tVZjCpZ9dzACxI2o2jOiIamjR51b7oU91p0qPrPnXal2FX?=
 =?us-ascii?Q?wUqYaeUWgXxdQq1ES8xWOaaMJX47xpj+UdrUktGib5JGuVnIV6t3yMnWEy1j?=
 =?us-ascii?Q?naZR+9q+xyzT3e9m01aPEeRht70CI9RO7YKu52aypyCI19LvmF4ILFNSSoRt?=
 =?us-ascii?Q?QYAmJoy2Vm/tNMqZ616XKVOhRSDb8TGgbFJhdSeWBKR+o6IOy2L7j/Ttf3Vl?=
 =?us-ascii?Q?7OolgmSlVkP6aKH2l7lMSTz6NK/6sAhO+ZG0atEdp6widI6f5mG7ISmNmM2J?=
 =?us-ascii?Q?bw5mTccOZRSBLN16zqyseZOtjuyjtWE9p9+tY0yycSq046j1hDykzGMHBe9J?=
 =?us-ascii?Q?nqEobpTVqR1J+y/KMvLC5b3UtXmSEmz2y2/7q3Kr5nWbG0Sss3Fby2V0r2ai?=
 =?us-ascii?Q?pxxSQstW0b+Y7+11euVmJwxkCRoisQWUE/JjTaIi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc0f0a9-f621-49e6-e093-08dd78f909b6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 13:01:56.4606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ZkutvnLJEXT5ZLMPnB9L3lB84IZNQ7zpx2UwPRB4akqPseaIjFioC5TATyRDrH3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5929

On Fri, Apr 11, 2025 at 01:10:29PM +0100, Robin Murphy wrote:

> This is adding support for StreamID aliasing between devices, and as such it
> is incomplete. It's not OK to just allow devices to arbitrarily rewrite each
> other's STEs,

Okay, yes, we should be checking the iommu_group before permitting two
devices to share the STE. That is an easy fix, see below

> Aliases can only be permitted within a group, which means
> arm_smmu_device_group() also has to check and account for them in the first
> place - note that that applies to PCI devices as well, because as
> soon as we

On this system the alias come from the PCI DMA alias support and
pci_device_group() is already correctly grouping things.

Aliases from other places, like the IORT, never did work..

> allow StreamID aliasing at all then we're inherently allowing RID->SID
> mappings to alias outside the PCI hierarchy in ways that pci_device_group()
> can't know about. It should work out basically the same as SMMUv2, just with
> the streams tree in place of the S2CR array.

You mean the logic in v2's arm_smmu_device_group() to consult the
stream map to select the group if the IORT is creating aliases? Yes it
could be done..

However, this is a significant regression fix and I think we can be
confident there are no IORT tables in the wild that have aliases or
they would already be broken.

How about we add the missing validation that the group is the same,
that is easy to do and should be there anyhow:

static int arm_smmu_streams_cmp_node(struct rb_node *lhs,
				     const struct rb_node *rhs)
{
	struct arm_smmu_stream *stream_lhs =
		&rb_entry(lhs, struct arm_smmu_stream, node);
	struct arm_smmu_stream *stream_rhs =
		rb_entry(rhs, struct arm_smmu_stream, node);

	if (stream_lhs->id < stream_rhs->id)
		return -1;
	if (stream_lhs->id > stream_rhs->id)
		return 1;

	/*
	 * The stream table can have multiple nodes with the same ID if there
	 * are DMA aliases. If multiple masters share the same iommu group then
	 * they can use the overlapping STEs within the group.
	 */
	if (stream_lhs->master->dev->iommu_group ==
	    stream_rhs->master->dev->iommu_group) {
		if (stream_lhs < stream_rhs)
			return -1;
		if (stream_lhs > stream_rhs)
			return 1;
	}
	return 0;
}

That change will narrow this patch to only enable PCI DMA aliases that
already generate the correct iommu groupings. Other sources of alising
that don't generate the right groupings will continue to fail as they
do today.

Then I propose continuing to wait for a user before adding support for
more alias scenarios to arm_smmu_device_group()?

> > +	/*
> > +	 * If there are DMA alises then there are multiple devices with the same
> > +	 * stream ID and we cannot reliably convert from SID to master.
> > +	 */
> > +	if (node->rb_left &&
> > +	    rb_entry(node->rb_left, struct arm_smmu_stream, node)->id == sid)
> > +		return NULL;
> > +	if (node->rb_right &&
> > +	    rb_entry(node->rb_right, struct arm_smmu_stream, node)->id == sid)
> > +		return NULL;
> 
> This doesn't really work - the whole mechanism needs to fundamentally change
> to mapping StreamIDs to groups rather than to devices. Then it's really up
> to individual callers what they want to do if the group has more than one
> device.

There are only two callers. One is using it to print the log message,
in this case it will fall back to the unknown stream ID path and still
print a log message. This could perhaps print the group ID # instead
of the raw stream ID but I wouldn't do that in a regression fix rc
patch.

The other is doing stall/future PRI, and I don't think we should be
doing iommu_group based fault reporting at all. Returning NULL
effectively disables it.

Jason
