Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013009.outbound.protection.outlook.com [40.107.201.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCC233E377
	for <iommu@lists.linux.dev>; Tue, 13 Jan 2026 16:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768320782; cv=fail; b=uYfuLUBpmOKqZkT/HYrFm6o3enBwVD8tNYMDQZGKrwM46iV+3Y+t3fvZmafHpaQg5VFVW4FMLcIQfAQEvLnWAz6YlExcXjcDa8NVE7QfIgwRt2iiZUxed+Y/Z/In9yMNzl9TwnwQUvjRV8Ivr1PI/B1zVvEgi3vTN/p+nbx4jHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768320782; c=relaxed/simple;
	bh=hfMJYYjWGkgfHQNDSsQw1g6QAaHv0EGYNliGQISH4NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RuQEbTrvA149WXV3IuXgJRtqNQHUjkNWPa0BDjchJJVUhW0kvXLR23Rm5MzCRTTmi7/uO/sa4dqM9E902wxgQEOxOPz7dDr7cty8P1boYtxlO9qEJ9baDHKIGsW2vL4hD3w5wd98aGQqiQYawycMA0xs9FApTbEWIoOwt/z4Qfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JCJBeir/; arc=fail smtp.client-ip=40.107.201.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JCJBeir/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HwOqPXZjCvxfvzV/c9skNaSsWay1tMky11HHkuwk417ZQt3yV+K1P/qsgiQBIBdjOdzmo/OmG3ZizRpCDl+JDGHqe/HUQeVwZZoRRsByqvQ/3rTvtutrswtchLKPgEtJ+fr2CtBoto0n9IkJ8Qjp8FeSNJuE0U78BexldCMdcqGYAEWkSlGlwGSJCw4TQu51jGEUP4sCbuYmN0wN4lE0tRDo1yS+lvUuWu5b0ssq4EuuKphowGIrl4Mz5IJNrTKJttVRPlyb3wgW964bB4lgVeuF8L5nrsIueD1LjYUey1NmtIm8In7/2BoHeY/+BbnkrKdDNHyYZCbI+iX5HLSvpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfMJYYjWGkgfHQNDSsQw1g6QAaHv0EGYNliGQISH4NY=;
 b=uJs3Ln+0RJ298na83ZomGrmSwQS/TPQFwuvlwehBMWdzrhkOuzDHAF/mw9XYD0IAYw46uGUT/1094Or996zZ11q5S5+gNV4YXVaFLbgez5LnzvaTE2orC2idXKspd56ORKVxj7kFa7ulypSSzxtFGTBIR1beXuaKoEAoEEJErj5xtMYYdDndxpEwqtnqCmVXLVPwDNlxik/gV0qcS5sY4FCjqlN0suzPmUkRMU9d/RQ5YqzgemiYSv+ihPbH+3qoVRKvQcWPwCq9U1hdTsc6RmMRTzsvfxjcu9bdkkfIq1PtrxauT8sFpgka6fIDBDCvW43Vv9l3JoO7XBCGRmPIOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfMJYYjWGkgfHQNDSsQw1g6QAaHv0EGYNliGQISH4NY=;
 b=JCJBeir/vATCjGBykOBVNovVkOXslsnmqBIyUVh2dtRDHH59BSTFuYKtN40Lmrns4Axa6BvzIkn3DFCQrUueNgnGOJy0oMBz1oxDVjQi9dhOBbPURfzRVqWGSjDDmaMKOkLB7lZxSB/mah9uAQP0zdRXbl0dv1sAgEZy/tJQuzEG40lRqcd7aNlhBXXS+GEQky67CE/tp5x126bLhm1aMmy40cVenhaBwWkIGudKuzXjZq0TAEGca3RJOUu7+6UmRhKVLF458mD+kgFWFERRF4RD8tTRS9jx0j6JAf6ZNbGjSwtmq4cfnmSb8YJTGgPUrNEkW2RvpxVGcgOt7F2u0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SN7PR12MB7809.namprd12.prod.outlook.com (2603:10b6:806:34e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 16:12:55 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 16:12:55 +0000
Date: Tue, 13 Jan 2026 12:12:53 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Will Deacon <will@kernel.org>
Cc: Nicolin Chen <nicolinc@nvidia.com>, robin.murphy@arm.com,
	joro@8bytes.org, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	skolothumtho@nvidia.com, praan@google.com,
	xueshuai@linux.alibaba.com, smostafa@google.com
Subject: Re: [PATCH rc v5 1/4] iommu/arm-smmu-v3: Add update_safe bits to fix
 STE update sequence
Message-ID: <20260113161253.GG812923@nvidia.com>
References: <cover.1766093909.git.nicolinc@nvidia.com>
 <58f5af553fa7c3b5fd16f1eb13a81ae428f85678.1766093909.git.nicolinc@nvidia.com>
 <aV7OBrH-TDiGRblt@willie-the-truck>
 <20260108003646.GA537728@nvidia.com>
 <aWUY-f3kvM94z4qh@willie-the-truck>
 <20260112161010.GC812923@nvidia.com>
 <aWVETpwlx9Rhs8Kw@Asurada-Nvidia>
 <aWZfUNXEka3GBf9s@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWZfUNXEka3GBf9s@willie-the-truck>
X-ClientProxiedBy: BL1PR13CA0204.namprd13.prod.outlook.com
 (2603:10b6:208:2be::29) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SN7PR12MB7809:EE_
X-MS-Office365-Filtering-Correlation-Id: e9b2b788-a1de-4bc6-6327-08de52be9c23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YC2CZ9KrkSO5UtPhBKbwIyg1kBSkTg794LSG5pL0DQ7CC/GBtNTaTAlTui/t?=
 =?us-ascii?Q?LEIqQjBYB3Xio01kN1QCLvMCZw8idOFI5OKuWCH/ZNhsrNb53Xpj0k06PQRA?=
 =?us-ascii?Q?3BgcsOVA/esy+Gvef072kRx1I2xolEnPfNE+/7bnfNJ71bflfDN8tPUVTdF4?=
 =?us-ascii?Q?GFapzmEPYluXQ5O5JTA+VmHJYCnp2DvNRCufOuNnUlJ7Ln+rBGLQ3dGPQdGI?=
 =?us-ascii?Q?LXx3+2v8dXEmPFK6qmC+gWPLWU0PGTpIdz6YJu0EB3aUN63XBwjJQOTM6LYQ?=
 =?us-ascii?Q?FIKHp6az6qG7fOXBscIrWBR+yrnFHdwnt1vDdKxEQrXppySTCXkKqnfPlQ23?=
 =?us-ascii?Q?pNbTKxJY/+5SI88rm27VVzjs5w7eoP1rgkKyxPDXNatFNXwDgtpO95xJTx/n?=
 =?us-ascii?Q?95E0y7NkCBr9W1BTywoIwadWJ4CoGGNPPcf3PzZ+04RY1N4nMHbdrOynlH9O?=
 =?us-ascii?Q?qoDvFuZpzX1FQmUOd2s6Z8tOhaOpF3VF0wltlvqzVxcNzKA5zjSjucbR0FIW?=
 =?us-ascii?Q?ncfXBL2IQYKsyh0wZldnETJAZu+C+1nD6NTbSuVJM8C8aRJeQKGpvDpukHPR?=
 =?us-ascii?Q?rwOfmraOFFr36SB+GtSuW1iOVtXmFGR6ZPfAsOQe/pI7PnV+Tn9h8a9P3/tY?=
 =?us-ascii?Q?Uv0BFijIs0Sf2Ok8y5R5nffzkuM0JEu2p4VJo0cW7Q1qE4RShffHgkvmn2E5?=
 =?us-ascii?Q?6q1rYXVNXmRVM5gKpffjKNEv8bH491ZVahEV6qS+09wGwlCb+98boh1R3j5s?=
 =?us-ascii?Q?TPbLlSFv4GvHjOTd0do5a2DOrgU+eF+3oC6PUH4y/myi7JN7zynDTvKiKqKK?=
 =?us-ascii?Q?8WMZMNmaNLylHcnTC/io6RKGINar6qTtfQ0UQhoyAStI3fkKb69htnKW1Apz?=
 =?us-ascii?Q?smydDe7Ix6ux4D/dO/A37Ueb9vLPKYlTACsoEScNf3SXjI1E2olISUtdwpsH?=
 =?us-ascii?Q?PYyUfPQbyciKu7nT163eBVRw574icEp0xZh/2+ErRx6Nr533u+GmMObOpFfw?=
 =?us-ascii?Q?OVPcjgUj+400XXMGHXJRm5NA9UcVTkFM+jLsPn1URMBIRM7E8129DA0UZ7M8?=
 =?us-ascii?Q?dZVIm98em2xmEtsacVOt3P88To6e8fWDgAzpWtbyf46jBUIkYVDaN36kT9L5?=
 =?us-ascii?Q?lxKkmBfQ/n+MH9FmuSYCCJqahgh8GTRvL2r4N7OEjcyqY/BAixM1zw9nYsZ/?=
 =?us-ascii?Q?V4wP6/a1l9UCpgmf2uuaI1ML3rNLMy5BzcHc6l9oVX3irOEVPoYGmiFbgtFM?=
 =?us-ascii?Q?tvgFNB8G4EYh7zZmVIcAbYWaedP+QyM5r0M/3X5pvMR2Q+/F2vYRYD8mnlKe?=
 =?us-ascii?Q?G/FudAdNqGxudBNEWdEwCBpMs9RBsEM92p+hBfLWe736C/IJW3XrLc6W7LJh?=
 =?us-ascii?Q?/JV7AhkAdAbfyJJnvId22Wk6eTJ3Jxb5s0xoIY2GoI5yAY/tA+1GsE9ZrhVn?=
 =?us-ascii?Q?TArIXmFCt2RBRPgPhtS3M3pmTwgw+282?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ce9wZ/P3sI/MbI30ELH1dzWBfg3KdYLZQZc8a/ez9niStLukJ7hb+aXk1uuJ?=
 =?us-ascii?Q?dJpU64pYBVbMQhzYlPLj6wiW7NXcXkf2yE3ojMjv3ZNrX5TfsYn8pyZLidrB?=
 =?us-ascii?Q?Fe/cZZfFswHX1EG2Y0AS6HfJiL4+Z9UwTzSs1zf+8ZetA2mfEkvAzgT6rzcP?=
 =?us-ascii?Q?w4+cr+/datv3WEzREIHTtC8dnFzM+ZN1MRBXDZHZN/85PfcyNePTA09LTp9X?=
 =?us-ascii?Q?TsI5rBTZk84xLAbfbfsiRmy0/lfQ+Kd3CuCH+YIZcqrG30g0Nj9DAtTpDAxi?=
 =?us-ascii?Q?8LCPmMs1mEZZwQlEjsDPyeJ5Hz9v4dZlaaAbRGxaDwjA7CJzyvhhInR8Vq/l?=
 =?us-ascii?Q?zxJycsDkdxoH8u8RLBHWSVOYVTP4xek+GmA20/lPhl2B5VuFr/5bC87askKp?=
 =?us-ascii?Q?AOJ8rvCh2NNbzUYAXBKgMouuff8vCYNp1rFRpQAABPD11h/ZtzO/9iKCILXi?=
 =?us-ascii?Q?dPZy8SpqIRAolNkMc+rD8rYAjsEtvuQANrmPgmIHpub8dHADGxbU7Fraoxc3?=
 =?us-ascii?Q?tf8qKYitQMdITQ/f+S1pa6mNP7VXGC9UKZtbMiZnDoZM5qplsMJerF+0QoiE?=
 =?us-ascii?Q?YYCqKlmfTNWPxtRHZ9m7e+kw2OoO6H5mWXlkV35raUcvGUOV6V4AMdRYa8kx?=
 =?us-ascii?Q?+YiqeXk5UPSNygYsj3yGD2gT+lVjV1mRpgy+/r4mHIq5HonsiZ/gGS/VBlUM?=
 =?us-ascii?Q?di2TOubhA/1wYyPqU6YxnlpxxNLZQPaBNheSe6BZ7UgZ2hNjsY+aT8ApgDjz?=
 =?us-ascii?Q?MWn5rCjMCphfJhCeuSkxjx02MCFYdsyKno2/uFXK33zv7Jae5bCSCduozGPR?=
 =?us-ascii?Q?PMmr/9oebAaEM9MayEiWuxpUomNPCnWTDXkR6AMUPslUZmIwBBEfXqGzBa41?=
 =?us-ascii?Q?1oJib8rzlDvNpMdbT3B7z+AbkBOlSCScBYXxxPk53kfrZpRNXeZwtSgk1k9Q?=
 =?us-ascii?Q?l6OS6ZgEswFicdC8gJf1mnJ7dTFfpAGxTOACNYRs7Cu4TdhDwXxqm9AgXjbM?=
 =?us-ascii?Q?NZsGAwx2nmBe226udHBY2pVyA7oAuLRn8utKns9hvDy7Qi/Nfdeww3ODkib1?=
 =?us-ascii?Q?vb0+Qy8HJ+8PgSwksCDEwhB6kvemPI+Y9sX3EP1vz759DobPaN6eVGQrJ+q7?=
 =?us-ascii?Q?yb9uOEqOJlMG+uL/wwHo6e3Wo/K+0VfLK8kwnYoxIpFzGzdg+iLtYfJlJqWC?=
 =?us-ascii?Q?avV40qbR/dlgPPhov1zU5IwE5tgo2/NagsodqH5hPPkyUIV5XFw0N545fLPP?=
 =?us-ascii?Q?OUSIOngtoSctFEmqZFPWBd5ZtyjNCkzQ2XSs+4eUjBt8Uskp5faFsOZZBhzz?=
 =?us-ascii?Q?858vUqHYEuF1E+AI/4V+K//yAgxQmM6Zk6scpN/ufeHXXujZrFo7nCVt1937?=
 =?us-ascii?Q?JU02FEFz6OLzmllKpe1vgIxuq7S5gzE2PIIrkkvEAcwBrFFVwL6AObq4xGcg?=
 =?us-ascii?Q?Qk1DsQgZmLmhf4lr78AewYXzDrFN6NISS93kzXokWUVFU4ldTxurUB7plNIf?=
 =?us-ascii?Q?m/ihZVrsoJtZMnDoPEBNuZbAKwaBqgnr830mAgnS52s0iOAM0gEB0lPoES/+?=
 =?us-ascii?Q?Gxs0R1534aUpQAfilABXXxj6MeF68erm9okJssEl3VCEoam6hXxy7ItlFBoL?=
 =?us-ascii?Q?rBufwWE+qAUtRZ/RYcqPEDPi5fBWCeeLpobw2xxpsiSGWiQAAvgeovPGKJeD?=
 =?us-ascii?Q?q7rx9tsJc2y9u/ydPzsqldO//7CR5P5mJP4IxDlcoRwe17Zop/PV4DZwC3mu?=
 =?us-ascii?Q?X7TzTSClwA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b2b788-a1de-4bc6-6327-08de52be9c23
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 16:12:55.1917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mEaOfaaPOQyUigk3qQCgoIuxApP5v6V6/eNCR5jZy457wNJAc0RhF0ejF9r0TaM/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7809

On Tue, Jan 13, 2026 at 03:05:52PM +0000, Will Deacon wrote:
> I suppose we shouldn't ever see the case that they both have S2S, but
> that's fine.

If they both have S2S then it works correctly? Any S2S forces EATS to
follow the normal rules.

> The spec also suggests that there's an additional illegal STE case w/
> split-stage ATS (EATS_S1CHK) if Config != S1+S2.

The driver doesn't support that either..

It is fixed by checking if new EATS is valid under old config and old
EATS valid under new config.

Also to support S1CHK someday we cannot allow the hypervisor to leave
S1_S2 and go to S2, since the HW can't deal with that...

> I do wonder whether having all the hitless machinery alongside this
> "safe" stuff is really overkill and we wouldn't be better off just
> checking the cases that we actually care about rather than checking
> architecturally and then subtracting the cases we don't care about.

I'm not sure what you are thinking here. I'd argue that v4 was like
that because it was correct with in the limits of the current driver
capability.

Adding more architectural checks the driver cannot hit today is a nice
future proofing. I don't mind doing it and maybe it will save someone
alot of time down the road.

It isn't like there is some easy shortcut to sequence this someplace
else. Eg the S1CHK stuff above, is very complex in the general
case. We'd have many different versions of EATS with different configs
that can be applied in any sequence.

IMHO two spec derived conditionals is a pretty light cost to deal with
that.

This series originated from customer bugs getting spurious STE faults
because a hitless update in the VM was not hitless in the
hypervisor. This is not just a theoretical need.

I don't want to try to shortcut things to only support a few things we
"think" should be needed and find out later it still causes VM visible
misbehavior :(

Jason
