Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013012.outbound.protection.outlook.com [40.107.201.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E6C3009E1
	for <iommu@lists.linux.dev>; Thu, 18 Dec 2025 17:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766079205; cv=fail; b=idnJEOBz9TxbV9+HZTY+NO7ieIzhKKvZri+ZyirwCkDxbGBgqdYNDbI/Al6Co0AE3mRT4JAk7S9rJ++JMDUgT657Xxaz+YTFt7MGBu7JH1zpQ8ng3vxpBViHAFN4DuL7zV92kD+MlJRW+pzp98WCi89Iom8Kuv9IqwmTaJPCTw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766079205; c=relaxed/simple;
	bh=o2b56pa2tQZKegPGgaXonV6gVvKNjtzr4x3+0lb2xXg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2r8S/IIo60YjGp0z1ltY/Uf+S+kjFK9yA9OUp9GA2QYRXRZaV9CbTHOdGX9XlZaOKvkg8rjPuoSWzz2ZGesFLCacFRP5g3MSGwuH2K0enODNqkJJGJzigc1lMqpGHz/P32CURVlErkTejWGfVRnIexMnC91maqbwU7XLVt/y5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H65+TRTY; arc=fail smtp.client-ip=40.107.201.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H65+TRTY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O5fykLUJq/07GxxT1RqLcEZz8lzI8FD2qJmaEwsPFjzQNr+yqFwmRliXvbhMDo9cxGcUW0nPMbhGQjc2QLicJYqhSXtliCUeB5pIb5U3mMiaz5E4rwmI7jA7MgQRFE5LBJtz7sQRXa0xMn6WjaQ/uBHIbJG4xMrjPsRNeWUcgT5KRg34Q9ipQsyCTaOYjkNL1Iqo6v7rabUVrss2SVaPWisBtgueQAWIsLMsjdD6xy9/dF0c3D9mWBwcxmi/V1W62+gZvi0/3BnvqjJmex/9/+Kq4Wrz/N5Ok66co19dp5Asm47x9m4xZaKP//x8SeA4rpfqt/wtz97DdM1KPTTngQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZFjn5UhHRG6VWHOViMfg46+8hCCuJpdB0JjceEp/C1g=;
 b=hZLE9sDSqhAWnG8u9ObwePIT58TW4C439Tg3912O+TjC4yqRuVGCojcWK9ZM+/dP7mlG96lFne6QKKtQ3PVY5iRYQn6xUBZ5Uq/YG+8XDyFS4ljr6YDB55Qzd6vdk0oa67wVwHQbTrN5GRcV8t//3+GjcNbag09iYNi4c5Cy3OX/2Bivr02tpHElpP0G/MbVy29GFOu0kqEgbfZw4raBV6T5otGKxHz86mdOc7SqQIDVMhRcNP/dp9+Kr60H+3r1DHm8zjvpnFU6tWRHcET4aDyw1PySKZyRTGlTOPlwjFRt81xPbWRoqS6C5a8PoN4nclrVWDOs8jI10WFLe2Wssg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFjn5UhHRG6VWHOViMfg46+8hCCuJpdB0JjceEp/C1g=;
 b=H65+TRTY4GM8C/mlopTjEh20CW/5HFqg3DJT/wYFS54LaoyZSKTR/30zkdp5yG7Ud5GsWVTTDSADhADJxrR2mvKWflQxHTYPEn/SfQtrEhpcwhnMMfw3ON3smlE3Y/zfXO+s/QtzFKy5OF2JRETKRi1+2IHS+gLxl7SIpFFN2gEbjoDfS7YhhWPVCMAxbz4JEEERPZsxtQbdku4Lyvn0TEczmZqQ8O7tXF0F1yma5sBgmGhn2oiPDgbVDJARQQWxQFL4sCKynl195gCwm7kU6HuArHZNzL+FI7AS6F7tBVjnSUhaXDvDVftN7rwhritOMvswejaSJROb3p610I45Pw==
Received: from CYXPR02CA0082.namprd02.prod.outlook.com (2603:10b6:930:ce::29)
 by IA1PR12MB7661.namprd12.prod.outlook.com (2603:10b6:208:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 17:33:13 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:ce:cafe::8c) by CYXPR02CA0082.outlook.office365.com
 (2603:10b6:930:ce::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.8 via Frontend Transport; Thu,
 18 Dec 2025 17:33:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Thu, 18 Dec 2025 17:33:12 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 18 Dec
 2025 09:32:45 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 18 Dec
 2025 09:32:45 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 18 Dec 2025 09:32:44 -0800
Date: Thu, 18 Dec 2025 09:32:43 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Mostafa Saleh <smostafa@google.com>
CC: <jgg@nvidia.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<skolothumtho@nvidia.com>, <praan@google.com>, <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH rc v4 3/4] iommu/arm-smmu-v3: Mark STE EATS safe when
 computing the update sequence
Message-ID: <aUQ6u+s8YbPiLC8Z@Asurada-Nvidia>
References: <cover.1765945258.git.nicolinc@nvidia.com>
 <adf08c3b9f289188aca4fe80e506dca7aa48aa19.1765945258.git.nicolinc@nvidia.com>
 <aUQvAKjVUT1L3N7j@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aUQvAKjVUT1L3N7j@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|IA1PR12MB7661:EE_
X-MS-Office365-Filtering-Correlation-Id: b7825688-bc31-4d30-7886-08de3e5b84ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0YzeFplSkFCdkt6U1ZJTFBYR0MvczEwL1lxbVY2RS9ORFVKZEJkUzZ1dVdy?=
 =?utf-8?B?aGNYM2tDMElPVm1WQUVpWWNyYjQxSEV1MmJvMGZQaEMrbDhJcys0eC9ab2ZP?=
 =?utf-8?B?S0NiRFpKOXVIUnFISUJFRHhCUU04a0xUbnFaOEFBeDloNTRxWDZGV3VhTjZ0?=
 =?utf-8?B?WjFIQ1haZGRUaERFd2tCcmJ2WHRPQXJBR3FEa250N1RVWlAvRlJSeUt1UFZs?=
 =?utf-8?B?NktjL3ZSTkU1TGpDV3Q4dmZhUmd2UXVRTkRFWGpDenBPN1JDbmNVeWxoU3Vl?=
 =?utf-8?B?dTdUV2JQaC9HUzIzUkxHTFk1ZGgxQ3BFUWc3UHpNQ0c3aHRQKzdDdkNnY3NJ?=
 =?utf-8?B?QUNlSk14bXoxWlJiS1U3WGhrcFZCRHB2ellmWXNlNVZVQVdaOEltUXM0ZTZh?=
 =?utf-8?B?RmJYSXN5cWNrcXNUQWhBRHdWaHk1bklvMWdCZkZSQm5aL1lwWk9CSWdMS3N0?=
 =?utf-8?B?UGc4WHZib2VXTGx5cGlWRDZFT3d2L3YwUEsyMEhFVmtHODV2Vko4M25NeVRq?=
 =?utf-8?B?STJFcXY2SzA4VFkwMXpOWFdUNVdobjh6bWdKNEVMZzJwNUhMTTlVS29HcGQv?=
 =?utf-8?B?eEkvNUt2RXBQN3p0QXVuMzZhZjlYMTRIeVQrWjl2WDVic04wS3Uva0tNamhY?=
 =?utf-8?B?TkFaV09mazY0NUE4WUlGQmUvMjZ0TFg4SVJQT0txdndKTjQxdnJFdTYzR2hv?=
 =?utf-8?B?L3VPLzVabXNuWDY4VVZ2WDhCdVpSK0VIR2dBam84ajZGM25odHJnZUNuOWxi?=
 =?utf-8?B?VW94M3dEYmxDdEY3VkR3Tms3T2wrSEg0VkFaOUU2MDh0T2k2dlRkMk1aRW1z?=
 =?utf-8?B?SG5kRS8ydUxieWo3UEtoQWRCMWtjYTRCZkNmQytybjh1elpPUy92c0IrN0t5?=
 =?utf-8?B?aUNJUitPVWl3bTJSK0Z3SXplKzJJaWdhRzE1Nm1icmFvVE5ML3loNTNVT2Ji?=
 =?utf-8?B?NCt4NGpHaFJpRjdGRXVHaldUZ0JJUGlKcndNeHU5UWNXUzZjUFE4V2YzSWJD?=
 =?utf-8?B?TmliNlErcmNOeUJEUDBzNWpOM1R5TllEb1JhbmN1TGt4VWs0YlRZRTMrTHJ5?=
 =?utf-8?B?dW5zYmc4YWR0c0tlZnQ1RVpIV2t4NTZKbjc1OFVWS1ZrMkdNR0hFYWVxb0pH?=
 =?utf-8?B?Zm50R3d3VU9IcllmcTYvbkRQWThhc2YrMFQ3a2swR3Y0VzgzSlF1MzF6RVdz?=
 =?utf-8?B?T0U1Wjh2c0pNaWNKYitRZmxjclQwTk1leTQyYXhseDdVd3hFZ044UHl1d1JU?=
 =?utf-8?B?azkwd2JCTFhEUHJGYk82QkF1cjZ4R0tFUU4zbDZMVVI3MmFPNm82NE9GZDhz?=
 =?utf-8?B?M1RWUEZNa2V2ODhUSzJzY1djSHhaVFdOQjIyWThzM3dSQk9ZWUdDZmxHSGRF?=
 =?utf-8?B?ejQ3aGZBaDlHQkpxV3R1ZjIwbnJMU3Q2NVE2MUxEcFY1Rlh4dXN4RWkvTzcw?=
 =?utf-8?B?ZGZENG5vWXZTT2VFbTYvZ01BRi9SOHVNbEdMZWFwSTd3RVZoOGQvZFcyUFB6?=
 =?utf-8?B?YzFzZW1jV3UwZmVxOFFFM2FDREV0YVBISm83eklMaFVYK1JkNUlERi9jMjVr?=
 =?utf-8?B?MFJ2U1g2eE5JRkc2YmhKeU5aVWNDS29XVFRjN0M0b1hzellwOEcvR0xpN2J6?=
 =?utf-8?B?UEV3TWFzaEZ0WFU5TGw3UUlrcURWcDZuK2I0ckc3MXBaTUhRamc5OElUaFlG?=
 =?utf-8?B?MEUvb0FVNk9KSjNTSTNTRmhPRmJQSHZIMUwxdTZHSUt3amtzamJ1c1NTRkls?=
 =?utf-8?B?OGJJS1JYWTZpeFFEVWUwL0Zydkd1ZWVIYTNITkFGd2NBZGx2QmQ2NkQyemJV?=
 =?utf-8?B?bVlqQUppMzNWMTBOSEFsaUxHSmlDQk9CODIzZEIvbEcveFdwM2xSVHlsU0Rl?=
 =?utf-8?B?RVhDWmxPdzJGejdpeWk1OE1ReGs2OGFTSTZVaTJGdmxrZ3NhQ0NDWFc5NWt2?=
 =?utf-8?B?YW05NTgvclY0bkxxTXpJTjJDdmlSVHdva1JOdnNjN0VucGxIUDVuQjF0eWlq?=
 =?utf-8?B?ZlVHTWpDYVBxTms4aERYZkkyZktMMUh5R2l4YXdBaEwra0REWWs5NHZRMmQw?=
 =?utf-8?B?Tm13bTZNbkZqZ3FXbmQ3Y0ZUY1Zpbnk3TVM2Q0oxeWJiQ2gra2QxQ0Jwc25O?=
 =?utf-8?Q?G61U=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 17:33:12.3165
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7825688-bc31-4d30-7886-08de3e5b84ce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7661

On Thu, Dec 18, 2025 at 04:42:40PM +0000, Mostafa Saleh wrote:
> On Tue, Dec 16, 2025 at 08:26:01PM -0800, Nicolin Chen wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > 
> > If a VM wants to toggle EATS off at the same time as changing the CFG, the
> > hypervisor will see EATS change to 0 and insert a V=0 breaking update into
> > the STE even though the VM did not ask for that.
> > 
> > In bare metal, EATS is ignored by CFG=ABORT/BYPASS, which is why this does
> > not cause a problem until we have nested where CFG is always a variation of
> > S2 trans that does use EATS.
> > 
> > Relax the rules for EATS sequencing, we don't need it to be exact because
> > the enclosing code will always disable ATS at the PCI device if we are
> > changing EATS. This ensures there are no ATS transactions that can race
> > with an EATS change so we don't need to carefully sequence these bits.
> > 
> > Fixes: 1e8be08d1c91 ("iommu/arm-smmu-v3: Support IOMMU_DOMAIN_NESTED")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index 12a9669bcc83..a3b29ad20a82 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -1095,6 +1095,15 @@ void arm_smmu_get_ste_update_safe(__le64 *safe_bits)
> >  	 *  fault records even when MEV == 0.
> >  	 */
> >  	safe_bits[1] |= cpu_to_le64(STRTAB_STE_1_MEV);
> > +
> > +	/*
> > +	 * EATS is used to reject and control the ATS behavior of the device. If
> > +	 * we are changing it away from 0 then we already trust the device to
> > +	 * use ATS properly and we have sequenced the device's ATS enable in PCI
> > +	 * config space to prevent it from issuing ATS while we are changing
> > +	 * EATS.
> > +	 */
> 
> I am not sure about this one, Is it only about trusting the device?
>
> I’d be worried about cases where we switch domains, that means that
> briefly the HW observers EATS=1 while it was not intended, especially
> that EATS is in a different DWORD from S2TTB and CDptr. With all the
> IOMMUFD/VFIO stuff it makes it harder to reason about. But I can’t
> come up with an example to break this.

Hmm..

I think the last line that driver controls pci_enable/disable_ats()
should justify the whole thing? Are you worried about device still
doing ATS after pci_disable_ats()?

Thanks
Nicolin
