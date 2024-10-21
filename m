Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0D11CBEA1
	for <iommu@lists.linux.dev>; Mon, 21 Oct 2024 16:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729527118; cv=fail; b=kL9CjQtn0n+/jEs0M7vdkBmnD2a+9hdoUjKxH2UgGOxyU8e/r5+0ul90g3niW86QChf3kDjwd4RBCUmK51+SX0kNFWx/UDdW96yFQoLtHcRRXU0hH6fxPe6pfgRe0gxv+vlV0XGMVGht1B1x0wGxXMv/5d0utUuJQjieI577aag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729527118; c=relaxed/simple;
	bh=ibZMtZuFk19+JEDeslebD9nRrO+DRXcFvzcxRSfdgjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t0+04Jk6eUwzV+j3HhDoiPTlxI3phjZfUPnABtl1Jj2I8GYxes3AfZi1DYcDK0ttveY7eDCeoBB42/DzaG3Rp5GA9vfOHD0iOTLMLBEAkyN2LUIZgcjI2OXI3Kt7nGLc6V+SNlLE9Xqml3FrzXuzMkpDzIGeuNGOdvlvleJtlI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iuQipMtR; arc=fail smtp.client-ip=40.107.94.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iuQipMtR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/bM6xPfPNNCxL1Ljt6v9ysMG8rCC7nmjX4LUNUHYYd2tL2Rq6FVFCu3/nnUFZTIsHGowphYNK9RgAjO3tWBI0fNaU3WrQGITTe4ZQoEinIEoXVdl2lET86/CjDrBnVgPckQ2c264eaAii+7c0Kmn4lJN8pOMp7zK0kWWsQBZ1RpdYzF0ryQVE0OyAN/sAOQzELk2d/SYt8wHgQpcSQZR+ycQHyPjAjh20cdcs6Qfy0kcKqSgg6OEcNz5muvR82mtYR9hNvCa9QuV/pCpaiNP3rzVFH2xv0YaDKOhblFF4m4FJvA4Ch1uW9Gq+fZk+91JQUFU6L2sg9oqG+en2INXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4cfogAxmpYDtAet+/zJ6aaxvcBIUeDq19qcRSNo6XqQ=;
 b=g3sOhPyalmMbpAB4v5J2oh/0r/08IcfsSxp2W5nHP4cWNsWmV23O7pajyvW6AvM2KSR9/jDHYWikMCgp7DxSmvujZ3t2PRplylX6GYfisiURv5IgjaLYJrWn0RmOZhhQPguUZ6TUpsjeCAhsQg9x+qlbMw8nQExZ7/5eS3J7RrQOO6oKASTO1t4+3cgppYFg6AoBVzrqY4XDHkl0iZ+BxNfE//wOof8UDqKecv3BnDZaguEP6npKVgZo3nEkKgl7mwQzDJvUTP6F68akwSOAwbgyWlnpzaZyHS9WKklfUXqTcjbjmYNAWyNLXQISSiCp5ONvWdeuxD1EnejVTCYZJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cfogAxmpYDtAet+/zJ6aaxvcBIUeDq19qcRSNo6XqQ=;
 b=iuQipMtR7yrgZsD1WmeAgTxhcalsVTdawhP8NRjjbc3fvUU0HrbDh08xiWOUjtz155y3SaCOu+WNNSY0Q/8eWQzP+ci7wVFUhR2BBErwzMp9qzUraNiBoh2v4cPcaF5bl+OBEmdE8D8bGMVDL4+UEe5Zwonm2uQ06WJ36AzUfKMW8zglay+FftSaCtn0GRCm2mVHDAqsKRxY6wcSeEI4u/aQF13Qtd5PQG32R9zl/b99eQFCMlNyd/qoWTEflEfOJWNXT/QUB65DtkJsd1Up9AxqvTsm3H0cV3tIlOYXG5iKA0fgu8bbHpXU2uoQrjPijXokbS0Bfz9g/Wkmsu9E7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS7PR12MB8321.namprd12.prod.outlook.com (2603:10b6:8:ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 16:11:52 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 16:11:52 +0000
Date: Mon, 21 Oct 2024 13:11:50 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH V3 8/9] iommufd: optimize file mapping
Message-ID: <20241021161150.GB13034@nvidia.com>
References: <c4574487-346a-427e-a97d-6e1ee366ed1a@oracle.com>
 <20241018001046.GF3559746@nvidia.com>
 <279c7e80-1d72-407e-bfb8-d286760a5e11@oracle.com>
 <20241018160430.GJ3559746@nvidia.com>
 <dc59dc36-027f-42c1-971a-8218c658c5a0@oracle.com>
 <20241018175951.GK3559746@nvidia.com>
 <55027ff1-05cb-4ce9-adad-8dca586a26ac@oracle.com>
 <20241018231011.GL3559746@nvidia.com>
 <561a1712-8613-4f88-ae60-7f12a4b7c244@oracle.com>
 <9c0f4c03-6373-4263-b389-262f8018ad02@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c0f4c03-6373-4263-b389-262f8018ad02@oracle.com>
X-ClientProxiedBy: BN0PR04CA0041.namprd04.prod.outlook.com
 (2603:10b6:408:e8::16) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS7PR12MB8321:EE_
X-MS-Office365-Filtering-Correlation-Id: e48bc946-1026-4352-c84a-08dcf1eb1321
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HmOJ3gwHRnm5CgrolPJ2oUJWMBuwCy+xl538WnGoUH5H4dgxnHVEl5RyQmm0?=
 =?us-ascii?Q?fujWu+frEGEaMGBJYxRO1egghb+xpSrbCH2xgCFJaLXO5QnGBIQtl/LktN1B?=
 =?us-ascii?Q?obylRPy6OHfcLITSqv1DbA6a0xMBYiKOkzoCSR2GZqpFbbxH604pDw33Pdcf?=
 =?us-ascii?Q?zJ5m/UyGKaYimBhrDWJdWClgbiLPzx2W0JjWuNmemUFGOM/YJEKxoA9glkZE?=
 =?us-ascii?Q?zIaz+/AIOgUvE96urs6+yvP1oJ0ni9WwqN2fSw18qKxPn7GYdJEMj57NkNms?=
 =?us-ascii?Q?RI+zETf8pLjB0h/YAH3Bdr6r3YQDFHHdI7To6y9P/5AdWMlE6EZyp2gqTW5Y?=
 =?us-ascii?Q?7MbpDRtgDVyprqGwJhUmAW+76Ln/odN0/xiY4rzAdUZ3urH1je4oH9NvhRGX?=
 =?us-ascii?Q?/dZ8kWgRMgDCpnoIryNO6s52567zw+3PP9H5+DzC48D4095SjqvFySGO0bPl?=
 =?us-ascii?Q?SRT2VmXD6zOAVOH/NMr+86LW7Wqp0TJ4Ua4UbInEiRsRZ2aluBMqeufuTOLE?=
 =?us-ascii?Q?/srQfEth+W/NmXHpnTVWsLroscQWEhbzX84Ar+0yrJYWr32JunbGnQBU6v1c?=
 =?us-ascii?Q?QdwmOkg/+0IcM2wva/oJ04/AAyOi/9w/j2fejDfEvsXK1msk8hX22xcNf2um?=
 =?us-ascii?Q?sGAscnI0ykrpBEVjmZXTaP2at3P4OSgpLHdDXP4zpOyi2BlCYCIwdXcBlTGt?=
 =?us-ascii?Q?JOPQCfNn6xGdIXimfTyIyZNJRJHmYaAwG9wm8SaC090KcY25mbMHMNHrmRbH?=
 =?us-ascii?Q?TMaRmjbP2yAbbClJEGyGLYUmsT1UPCrSqw02+89dapvleYHNdKZjFjykkkZd?=
 =?us-ascii?Q?Vyl8ca/brbV3HvsLnCYin3Bz9bYmQ0Fsb5yO9c1eVxThvQLZAV/xCM3afbed?=
 =?us-ascii?Q?MKiURiUTtjnX/I568Wk3mPfe72PTZSpy5XwkhhGzyS3g8RYkFWEIH9LzV515?=
 =?us-ascii?Q?7upHJRntrzCj+uAr4nX6JRDKJ0WRPxPfuwP0UPNlReVhi1GrOwdVkP8k2UVK?=
 =?us-ascii?Q?k3ZdVtBlK8B2TfTHUO+7/u2nlDQZLiUaiNTPGI6vBbMvUxqkxJzGFNl0fPiM?=
 =?us-ascii?Q?KauD50VzfsIcUQp5GG0q6HKHYUBrRw7P5F/sns1j+zRrzztjhyGxMn9Y+jHx?=
 =?us-ascii?Q?2OMlraSfeSA6HgXHMArGLkv09EetbC4tIWsahIFRJbh6DhNJEa1TdCJLNTxM?=
 =?us-ascii?Q?MCuHD6QmiJRGBDDwt0dEUXLiwiV3qIqhR0W0SoPQokykESXnIenytU4aNLqk?=
 =?us-ascii?Q?kWAzTuCZZnYvRDT2vWOZciLvqPaNYtJZUM5M8GvhGu051AdqB1/RSDLEqwo1?=
 =?us-ascii?Q?uCU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4cCoimsUVod9cj/MFshdgO/Cl8ld+ErDc8ppPUF3aySC+LYKfqMttmPouY1S?=
 =?us-ascii?Q?Yv/ofw8uDM+7qR7bGild1VXmJULhsKaZvo3pH4SMIehh8odpznkDr9vRufDQ?=
 =?us-ascii?Q?BKOpDao82SNjmgeFlgl1Rdbl8srGUb4a0MLOE7UV5ViPrnYiXDWb+8D9hzXN?=
 =?us-ascii?Q?VfhwHDVPOqgWg1HvbWKz1jedS160mcSTcazY2ImAA5Diuf/YkZa6KLOKATUy?=
 =?us-ascii?Q?Nj1QgUHbDqysnx5VwJTEX9g1OA1285NoKaOK7PUZON/kJOgO5vjKhRPKFJx8?=
 =?us-ascii?Q?HnL+oYb9PgeVYzLzttWbjf4JwjT+OCCjQN38jcX+Qde/sQgX35rGBVFtPIPj?=
 =?us-ascii?Q?72ANm+HiUQlt4xnIFiIOJK6zcB4PGDNFqxeazsEXbsEnJsHaY7UQ4uNAyTeL?=
 =?us-ascii?Q?vsPjE8zKJMfEQmEaUT3qnL63aN41trzqTwU0Kazk3f7bm5re1gvLQUsXC45i?=
 =?us-ascii?Q?IbGl5vgj2jrf+2ciAoyB0fPMrqlFmJGfJi0V7Vg5DsfjhdaZPXyvh01m7+Oh?=
 =?us-ascii?Q?0BvqbJwUbJDbMcpX1HkDpTNJuFlHDeqCUzQDLJKGvGWgphElVc3syKVwJIPA?=
 =?us-ascii?Q?oM+9f7/hQbQtUTQUkYDSyx9HlBjQbHtarHWfZqBmLnsvjNm3rB83vVxJf/mX?=
 =?us-ascii?Q?+RNcEhfgRBbUO9u0h+PLbChShE+vHLM+H1+VoSv2gkH6oGbbzJcZgjt5wMhz?=
 =?us-ascii?Q?WafO3qfqF4fSyMf5/d4bzCKfnDWMFCsfSEYzoCwtKcdfSRg0842bnMXEom6S?=
 =?us-ascii?Q?ZMUKWj41Yys2C/i7AqUdSWfylFe4yEDGcoX1MZf91vTvXOroLeblfoauXXwK?=
 =?us-ascii?Q?OOcZ4dPiUmTEVqt+dr1dOTXMq7dWOjXoljRfb7A9SRZkCLm0gYHNvPvgT5rW?=
 =?us-ascii?Q?W9qkErP5D0ktZ/YUHWV2lsTqucalSbaH+8GvGqFX5vLZRgh/t7Zj3i+Urey0?=
 =?us-ascii?Q?5YiaUMttABE4vLiwncjBh0jZhAuCSyjrpBFGKvP/Bm2tr+cStXKYv9YmQl9w?=
 =?us-ascii?Q?d2X+ey5cRDOCRxGFu6wXr+0I+WJ8nUeAe1FAkDsFe2piDA+BdSeTWbbZJWNZ?=
 =?us-ascii?Q?vIAQaMoWtU/AJ8ZFwaDuPwFoZLaRJCMmrZKQ6WTeTXgpxsFa/KWJzcXMppnk?=
 =?us-ascii?Q?ZB7uuEi6ahbxBUnT+MIaDuhOk3AnKSjgfNCGDcKAXX1UqEZ2tE1mCfUxEnjC?=
 =?us-ascii?Q?KcysfE749BuY7nRIhiG2rkcZLGCfnznoaTsflWULP/++ZhC05woR4d9sc/ia?=
 =?us-ascii?Q?wXyA1pQT5KdST2aj3H/nZ0AIBqlDOeJ1mdV3ma6lzKsmwciLmnAWEGn5tnr4?=
 =?us-ascii?Q?euu6Tj7Xq+hwke/vzVBEvKED87M0zoqSVsGva2iUmXRXtzOdNduq1vichev2?=
 =?us-ascii?Q?olaW8Z1GIMiIQRHLADrbqiJcvfbfms2SQzrnWs5JL9oVFFlaymPNSJakhYDj?=
 =?us-ascii?Q?ZXqxh1sHQlSyYXNdw7wOYteaihBvYBHV92niSpSUQatGMriX31+XHxs4cOa1?=
 =?us-ascii?Q?kGnyn7PW2DNGKXQ1qLHpxShi/q8+dIh0QHwk500NHkxEhMVbY5HFkLttNJeC?=
 =?us-ascii?Q?N5SCAa/Rs0GizYDaDg8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e48bc946-1026-4352-c84a-08dcf1eb1321
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 16:11:52.1930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R/u5jbvIWVriSdyD4SlfPJI0puyr1TAkisp5yXayOTJMufZOVCc6PpxPON3OrDzg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8321

On Mon, Oct 21, 2024 at 10:29:02AM -0400, Steven Sistare wrote:

> Despite this I can make one further simplification of the V4 code.  In pin_memfd_pages,
> if !upages, I can skip folio_add_pins and instead call it from batch_from_folios.  This
> guarantees that in pfn_reader_release_pins, each folio to be released has only 1 pin,
> so I can call the existing unpin_folios and delete folios_unpin_partial.

That sounds pretty good, if the loop in the memfd_pin_folios() can
just be computing npages then that is a reasonable place to come later
and optimized by changing the mm code.

Jason
