Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62384211A15
	for <iommu@lists.linux.dev>; Fri, 11 Apr 2025 15:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744387090; cv=fail; b=DrSXCoo65f9n6Rz1tTJcLozgPLwlEnBCfRPWom5Unj3sDfbk/C5jC5QPVQu16LFYR9YU/olZxswRK4YGG0qek7dnN7KlR8/qFRUyWWNqQ3wtjnSbfD3norEKc9KrKTkSnenIqDrRFunoxkFuGlq7HNaVd8/2lBR3pqq8R8Oroh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744387090; c=relaxed/simple;
	bh=s/btlxmTvXKrnXE4CfOJD5btCF7sUFRUkivpG/RaLes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AnUbJOptlKYCl9MelHYYQLFjMzZy5ZgPSJyWdIsgs9/XxpFdeWxkFNWsBAgAg8H5+OAlmskKPw7orcR10zZU4g9l0DPahRgLaH9kcfhbp9Y/J0wruLN7d2NaA8R9vx3Q54m0LwWJuOZWT0ZinHpgvRsPzXJV6mvf75TZKLOd8O4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rOMQ+nA0; arc=fail smtp.client-ip=40.107.94.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rOMQ+nA0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BNBFNyHKVvh9U06g3LrI5E4XabOV0b4ZycwLuNjB3NuTQPdR4PACdJwETuDAqi2o4MhNHeu4uffGJ/H/7pMMcgD89iQ/zoQgSQrHd1hrg7XWH9xHx2ZAZlQauwH6vDN7NuJMb09VIh20CH3Wx+R72RG+glQMyc7tatS8wbT4i4o9dXa9DdDhzM0Xxcgi7EM1cmU3Kh5VT92hYI0ZHtqdxSizGNUnCT4/EV88OFpV04YJO4kNfv6GALiJ4FA4vri9bG+dxyM+h2hADR4cIOGWqTGZ+2oqKC1ttKXNP2whF37IykBhHe6cKLcy8WzRbGDc7oLiT9crp4ALLvAOzIPToA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfE+yRCAhHjU4vmJ5my98/I0X/s7bBdzPoRwXo0930I=;
 b=TM5aEdgybcotE/46OZJQjmBPrnEdOlxKrN4yc5Eq1VcBIFSF2iYTp0Td0tLeWYhjMIT66f+unPaFuH1WJZia68el35p9NEZDFdh1UVgZLdsJPyp94OM+VeH+z2tIcJ1tEhh25em9QFlg3p1UDXCPmnHw2b63zIN6zRTWyenZPV7I73SPEXvltNiGViC9Amyx82AimjMAru5Ae6sn9kkIlaWlec6dtkm+LpGHegox+Es49pOmavleLsZNuhYeck5XNDaNqF/ZpJ7zw2sndNJCTyQ0YjZ+z/1M0QFdVYcF9WK/dvvlNBi2IxDBZ0O0AWbTBDWDF7aSlgd+BnVjdvBBog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfE+yRCAhHjU4vmJ5my98/I0X/s7bBdzPoRwXo0930I=;
 b=rOMQ+nA0vcMCu63UpclKTz2bikO18pstrDS6F+YX1gW9jg0BjyXqIqmoBUMEBWi3RxFdTf5GvAlXGbQUbyg6/KQRTLVets6qyTLz7ELgDCEKqdLFR4kOR4doEkyDUjhbOhm3n2BHdP8VGJqzGCZANHjsgzHcvMfUky7stXR0IpKunky2lVyR+zY1KHOY6Jdil6oCIdJCP2gpjccuwNYhoXv6+TdcjYPEsyQ+YaoDUrrdyQqIsifAAa1Usc2MXcYPYtIL0BAPCmgEiKCk+qZgZtRcHAC6iJQJuVyl1DaaOdrU/M+ZHc/XK+ol47avn5/3KiltX8PYTTYhKo5hQEfZYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH0PR12MB8175.namprd12.prod.outlook.com (2603:10b6:510:291::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Fri, 11 Apr
 2025 15:58:04 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8606.028; Fri, 11 Apr 2025
 15:58:03 +0000
Date: Fri, 11 Apr 2025 12:58:01 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	nicolinc@nvidia.com
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fail aliasing StreamIDs more
 gracefully
Message-ID: <20250411155801.GA252886@nvidia.com>
References: <39d54e49c8476efc4653e352150d44b185d6d50f.1744380554.git.robin.murphy@arm.com>
 <20250411152122.GF8423@nvidia.com>
 <Z_k6MqMcVO068Mq8@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_k6MqMcVO068Mq8@google.com>
X-ClientProxiedBy: BN0PR04CA0052.namprd04.prod.outlook.com
 (2603:10b6:408:e8::27) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH0PR12MB8175:EE_
X-MS-Office365-Filtering-Correlation-Id: 80ceda2a-fb34-4745-214c-08dd7911a3b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qvChacWSS+Z+SwAKEotOnj7GTxoZRlt4bC+Ky4O8KqB06llnUSsupIz1EI9F?=
 =?us-ascii?Q?7nnv0fI+fpsjx3Mwts7yzYU5aFeTfE92rmHmOzidv+EVU8k5s3e8yTd+dCcY?=
 =?us-ascii?Q?XxO6vv4eO0iDcfLKQ6dsrZwPv7lB1p4iXf+Myb/QTJQiYBwqVIs6oBAw1r6/?=
 =?us-ascii?Q?2c3Qi17xWj0iEzuSmldmSFv7GNP/75MOMpjec+s4RK5Q+EtY7lxxrI1OzEZd?=
 =?us-ascii?Q?cEQeTe4v12ilBNAupkf1yQvNly4WuekPYegFBkhJE/IXRuwEOSQoV8+9AN1O?=
 =?us-ascii?Q?RkvqPhfpKaVQHuexWAFtS0GCBJAuJ9dZY6yIGHqbuP04HvPG49mPBdcyrACX?=
 =?us-ascii?Q?r7M9XhSODBhkydvWZM5v5a2oxY1htkJ0cu6Y3leLM3/kT3YfifIFoCUDzRVQ?=
 =?us-ascii?Q?JDsTgFSOlE/MGAmimq24moqyudFDyv6BwxX4MEad5jH2FTe6PkYkG0/sihwl?=
 =?us-ascii?Q?k0xlQcSEg+NStbhgS94yxFLxg0rqbL2ElKGtYdNQfyn422+6rYEJ828EZdyg?=
 =?us-ascii?Q?8lvclkbSZAbuYIKDLVUL18CMjA9ooSdmpqUiguSvmfzvqOKt55NF4/s6usZp?=
 =?us-ascii?Q?R9luTdi2ADa/L6g5NwTa/6OdTsmDKoIhMf2sN7hzWkW+vk5swW/88FWH5XO5?=
 =?us-ascii?Q?UY08iw7jnUzQh3BZ/qGCSu2XNDl4+9ZQG5enjjbjsleQjtlF3CnYXQRtmc05?=
 =?us-ascii?Q?bJY0GaaYbZt5I0kQA+7QJQ9cCNEXphcZlxNmYq44WYZNo6Of4cuczgPHQmCq?=
 =?us-ascii?Q?r7IYzDgAaEn+xjhGIl+iBoIuAdByZGZYrHZfkhnf9Fvi+ZVmWrdp9O7WTkmS?=
 =?us-ascii?Q?F+55t1Gmmxv+MLRlDt3gYMWoWhgAqaXCkzN6/hPENfR+9yzFb4oCAZvfZ6x4?=
 =?us-ascii?Q?Lejg5D41vP56QbLOkNFziHNgrfzf1aDwSJUd7qU/3ZeJH//mu69q/iCVLk34?=
 =?us-ascii?Q?TxXOZdaEZHRhK1biBY4IYuuttcBLwRrmrIwwO108UfUbZKzcFSUCLA4sdKtM?=
 =?us-ascii?Q?R23YchXp3q6210chgeSN8lf65MAC9B6wS/M9EqK9hluFb6/LsdDUOzM/lMvc?=
 =?us-ascii?Q?P8OkIl/na6nis318Fx38TZKihRrSWy04FhOfAoY33U4sup8px6rqXL2dYxaE?=
 =?us-ascii?Q?KA1Eu+NaJ0SxZmBX6/nuavQGj7u3JytDuEEBIQ21zBCZkloOOOC94RAgQ4ji?=
 =?us-ascii?Q?G1yQTm3FQDN9Z5IpbgYtTevQ3/VKPN5qxw+vbHejlMw2A1rAD+TbyaKOGQoP?=
 =?us-ascii?Q?BO2y+VVP8F9sVAoxLvNnr+3+U87kkB6Ru3MIdwTgK0JHqh6FtVZiK5XqeN2q?=
 =?us-ascii?Q?8oY5SJxQCDj0A1jwBUWSmSNNg7CBXD5RqFLw/ebKt93ZfoDKtZUwSy5xweaz?=
 =?us-ascii?Q?l5fGCeyNEK9hSJl1hQc02hbQvUzJewEYMCmic6oEqG4ZUTYOiXpf3odURL/t?=
 =?us-ascii?Q?Xr4TOf1HlpY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MOopT25X0vMpdXaV8nJ/V2xNAGcaVNweraosoOLrBv61mGkdPd2kXSkcm332?=
 =?us-ascii?Q?Zs//ZJpK5khsVMGcYJ/osIx6+0tY4+E1Efa/gYNx+saZhZ3fPGO8n6UYBNFm?=
 =?us-ascii?Q?Txax/QvZwg+rCl4sdTc7lR7p2yg5ly2jqrzK9+3cFLTXOIyCEg5Y6RO2hENm?=
 =?us-ascii?Q?UhfLz2ixg7gcKqBBDgU+7LyG6GHnaHGiBUi3plnZ9fJCKqplJot5g0c1ozWl?=
 =?us-ascii?Q?/cqUrqPWmwO16xNSydbd9ep59XXPaEMcPEmWh7VqkJ1CYzZ1my6UdYSZ0pHw?=
 =?us-ascii?Q?X/1fL2Sl2t8LsGHij/0G26hgT9Fyl8wLd2UUgC0l0wR1eyhMS5nAGhXtwD4l?=
 =?us-ascii?Q?26ZMutf+MJGiFHDIwLUeQt10qKlWtZkVw38KCqvLZiSqjWrCeIUhVcZBdP+C?=
 =?us-ascii?Q?H+obQ/+q/Fxmfps/rsnNBA3Ofec934hZ2AfRu2/9AYPZu8nM5uirpvdN8SS8?=
 =?us-ascii?Q?RWoncD1kaNcV8Grb/PHxNGtl2Bg/V8Hp+5Ewj65u9OfpeHRem7AI+mZX3NOc?=
 =?us-ascii?Q?gnOk6GFdhbiXact9xR3JmaF2flB7fCwDLghqUUdQtHrzdryhpu2iUs2TKKQO?=
 =?us-ascii?Q?pc0Zaf+RkhwkfE78pj+V/QVOV/IEF1/xjfOCIENx37gZuxgZ0zr9PRYG22Uj?=
 =?us-ascii?Q?YRNM49tiVyVcnt1yrt4/xcZJAU3+Qwa0gXOWF64D0G+N6a5DXTZuu4VAsAcZ?=
 =?us-ascii?Q?z9Ggdg3T+O0Wak2OnSPVihXyHb4e8O/7SbDSKBjR03q1Iubg5/8Hvdjcph0L?=
 =?us-ascii?Q?PLPLNhHwhvRAIpHbBzMZxWL9ZN7tnrKRJaV7N5HEXn6nof1TPdz3uostQ5n/?=
 =?us-ascii?Q?X9zXOjhwvkp82OzblDTEPddYydFftHhEyU7vjWiP5jHTWcVthvH39eVSFhJr?=
 =?us-ascii?Q?XwpqJLJShw2u4ZELWzQr+uLnqz0dqx45ZYUf54iHUQoBwHBBOVvusZ4n1CXP?=
 =?us-ascii?Q?ZUu9UzrPa0l1SWV1IjhxPg3gkUF9kDnZzHa55d270wMX2h7hw/0flqvVuaXe?=
 =?us-ascii?Q?fvNxRDYUtOtgGQpU149ZzI/bMlOkIqfm0wb37VaOt2rw1REqZPvmrpc8tMlb?=
 =?us-ascii?Q?HdxXjsldz2F3OaAlkHQwNls25vJUE8/CNdLtFArlK4KO2HZGX1G3BsRE1Dxc?=
 =?us-ascii?Q?eUC7iin4whH8bHR88YTgxV3pm3RrDZVITyHDYXN9yVOeSzVAHZfzJXZUukvp?=
 =?us-ascii?Q?eew+vyNEjSgQStFW9kAhw9m6OJZMa6t8/QnGOzL5/pGe5RKThPQ3r3Us31dv?=
 =?us-ascii?Q?N1QD1bj9Rc5wQmfFAfV1ugTjQEPx/9v8uXs6XgltaVgoxv/auNdQmfqgUvH2?=
 =?us-ascii?Q?Wu4rvVGG38asd2RPbSBiT/FiwscsBh6sK6rAuTqumy/wnNIaQaddnFPN9vSi?=
 =?us-ascii?Q?4KhaTvKRS+pkzocMKvB5c4FHsbMnmEogL2BLVVvAfGP2mZ/TXh3vNUlLjSs+?=
 =?us-ascii?Q?T0PsAsaKbwokeV3kg4xo1a73YsQUn722GzX/ipks6j6o6zEB2dDEj9Xl0YlX?=
 =?us-ascii?Q?2Tjk3kek9iERS9bnTXn7OHe2us/V8VveizoQDd+NlL4dygAupG4u0Yrk1ugZ?=
 =?us-ascii?Q?+8cCiYpqVlPDbzElVXShfzT7wkyC1swzYMzJBAp2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ceda2a-fb34-4745-214c-08dd7911a3b9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 15:58:02.7226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KE+B2W82PNgYkgFWoskFg6T8TGNLKP0YYoVVj41Lz2s+qw+fxEQoowjheuNn1CSC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8175

On Fri, Apr 11, 2025 at 03:50:10PM +0000, Pranjal Shrivastava wrote:

> > I can't think of a reason why we'd want any per-device failure to also
> > abort the whole iommu registration??
> 
> I don't think this change would abort the iommu registration?

Right, this patch causes iommu registration to succeed because the
only the ENODEV is ignored.

> The probe_iommu_group would simply ignore the -ENODEV. Or are you
> talking about a case where we don't return -ENODEV?

Yes, I mean the current situation the probe returns -EINVAL because
the SMMUv3 driver knows it controls the translation but cannot startup
the device due to the SID conflict.

> > It would be nice if the dev->iommu would record that the struct device
> > is inoperable and then we can fail
> > iommu_device_use_default_domain()/etc in a contained way.
> 
> Ohh okay.. you mean the dev->iommu_group == NULL may give an illusion to
> <bus>_dma_configure that DMA is allowed? 

Right, IMHO it is the different between ENODEV and Exxx. ENODEV
(ideally) means the iommu instance doesn't translate that device so it
has no information to add. EINVAL means the iommu instance does
translate and then we can be pretty sure DMA won't work since the
default STE is abort.

Thus, IMHO, the core code should ignore ENODEV and assume if no iommu
claims the device that it is identity. This is what we do today.

However EINVAL should disable future device drivers probing on the
broken struct device because most likely the DMA API won't work at
all.

> Even in that case the iommu would block the DMA right? And upon
> inspection of dmesg it would be clear that something went wrong with
> the probe?

Yes and yes. A better chance of the system booting if the iommu is
left registered and running with only some devices broken/disabled,
which is what was going on in v6.14

Jason
