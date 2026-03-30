Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012009.outbound.protection.outlook.com [52.101.43.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9B217C220
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 13:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774875638; cv=fail; b=lpNkhjqFwf2cPxpbuzooCCNqAopjYRoBV2oev9qQnSil9Xjly43luzQi+Wg9NeRnFxJTxHhgVQ/jgZbBa3kv4cS77JblXRywAnC58YJZVV61t9sr4/jBHr6xWB9KSWMzA4radreRSnpBnbe4bedsDW36lZWn5Y93xvEWLdf2/38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774875638; c=relaxed/simple;
	bh=wP8qisA1L6PUocnkd3dHv6TnypCRuWcwpISQbkuc6aY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fax6sidusJSc9U4TJMtqLUwkC7Vkf8igq+oQTWAyJW1vFtzC5b44EZ2bBeTSYwGY3JtriGvenylJvrG/1faTeaDx91UaC2+R5SeHy2QYW04y5PHUf4eJzaw4NLyQWMc3pxIGL+sec7d0ZpoAbL1RVKtakcDYe7g7pGOZ8xG4nfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FzSN6uMY; arc=fail smtp.client-ip=52.101.43.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FzSN6uMY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uYDHhQjzeB3CZIT0HQCQzGRM8F4iPUySIMkJafgDORO8n3ZndA1XHLBYAWOL7pC00McVi1+cP4OV66Xte+S+H5QQY+fLW/4f4NsSNXBIQ+mgiT9Khk+gb04wyWfZgiGQgeKR2ZF0zyjeDxPb2fI35VLgsxc5VeLN0TiI1nO9cjoaII7AT1sozVo+JtemOSAtoWywLl5iAl/YqjCkC2zcvrdu4G7k1Ik8sWCgExc7yWwZJlhOqnSjqkKbqbC9jJ8NOYoD7vqIcTEi/G635ZeU3mGImLWSNbOCJEv+daBMcBV0XTPsZfQIKAdFKEVUnMMs4MwCneQCSky4DVwKB7oquw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMCo7oFnW3/M+ttbK16dSYK/FUE4cXF3DZZ2E5aLos8=;
 b=eS39oRP8v/9JT+pJP7ln3nZl94VKl+h1Bw/xPUsP8gkqMPh4Esrc/sNhg37J5AWWK94nyhYdXkZxaBcqHlgF8crZSBPuHJjPlWlcCxjmTBxJQTxNiCRLRhjiDkC2V3l5VWjSvc1NG5QM4OcK2KaZQrvRrPu9seQ8B75cawItsMaUr3kPT1kOIRPwsnBhfc5qpjHQOM/ambb6bGfi7me2hn63Ze/UgA0rXZhMbQn4ZI6By3muNoEfOTn75+3YMSn9hCAb8gWylR/urv6EZWvj6vMMxU6lvK6OOwckQDJMJ8W0uNsVFzlMd9KheSwT/vBQ5uBpB430iLcbbMwgHGODfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMCo7oFnW3/M+ttbK16dSYK/FUE4cXF3DZZ2E5aLos8=;
 b=FzSN6uMYxncJvjNABjamMi96Fl5ILqraejaBHV+w4sfKwhuxH/u7Qv6fReOqcXidBdppaLKJkT8XsZPuBSMpruwr6OX4CpNMK5rTCwbN72sBCDQNkNsicViOr7V9qYoqA4yIo77H1AmuLsCjxouO0KoxAA4CrF1MeTh2oPO4rtgDLYe+XrNkYCZ3+ZmEkO0TswYSjQWSkZ0FYppeEOis3UdqXChR4pYAsvD7GWhgFjwgclrTqIF74VuHHNmLECoHKdBHfA0Ek4dM7iJoD+ADlCe+PQd6nfeadEOu8V8tWzrjMB7vCqKgw7OEiomAAvMX0fnQiETiq5osObl+g+Wqnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB9343.namprd12.prod.outlook.com (2603:10b6:610:1c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 13:00:29 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 13:00:26 +0000
Date: Mon, 30 Mar 2026 10:00:24 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Dmytro Maluka <dmaluka@chromium.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] iommu: Lift and generalize the STE/CD update code
 from SMMUv3
Message-ID: <20260330130024.GM310919@nvidia.com>
References: <20260309060648.276762-1-baolu.lu@linux.intel.com>
 <20260309060648.276762-2-baolu.lu@linux.intel.com>
 <aa9W4ZKYWHr9-UNy@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa9W4ZKYWHr9-UNy@google.com>
X-ClientProxiedBy: BN9P223CA0006.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:408:10b::11) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB9343:EE_
X-MS-Office365-Filtering-Correlation-Id: 910a6041-9a1d-410b-85be-08de8e5c4fa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	DXYB3mQOviTjti0PGT4JiSFbdDB6Rr+uFjqbK2dfSgozwcN9k6ik69GqJFnPmuHSEpLxUNBCp060Ap5LPsUYtOcRhmJbJvK2JKzqkGSt+2+SwWxoUkPJ+faejcADckdGFUnwkaA/IR3SIjDazp00yuucD7IEbV9OVz4J5/5YEGKwEeC8eBv2RbY9oCcUalSYGDuy03fM0Me5CTmNzdp+9RPPBXeiKDxYPjEqIxPE5rHyCHYA5oGluPGOCDbkzGvg9NlxnBYwyMnYCk36m0dkIK5mJpo7qJMIQQbkgtQNgxztaUSzl6lAAXWu1aAmlacRjsncvYnZ+pnIJBk/YzBQSARUoJ6Fm5s7m6GKI+h0ni27FWuKnF7usz4BxS7AFTYKJRV5muq1AD6E1cax006t393+BdEbg+oZPztdLJnQc/XsI+r3BuZH95p/wvoxr5RW0fyYik7NOV90nLdDMWYArgs9MZ4mKohAvVksw63M4MGDkkoImc+jDD0/3K2cZxD5aQg77l/v1a8dSTamzuKKTFSKz3OJupkbolCa1NYfxrZbk48rHjsendU4tth4MjkHOKg7mYfnsDuGsVFOet6Mj7IRYaf41E3/KqaaVuz+OWu7pCkiVWmvUPM2xKntuQTJSNhqFsKZUjIftaSuKDvdl2G24JluWBf6xLuu9vsoN9E7wmMUxhsjuhCPSfxB8h5akRomtWIglk7c3XE8LxWQU8Xr2Oafi1+yM5Q2WAaJCBg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+3IJ+S6sWwDXSw4CA57l52Bv4NcZ8+m2/SmDPk4maAAjMxCerw0XQJis9vyo?=
 =?us-ascii?Q?B6dt3cXRw514NpPr62Y1KOTPMxRpDOTeRtQTOKNXOdRj0d7TmZhD0d+IFlXT?=
 =?us-ascii?Q?uxQCDMJi5fEeiwtJnMcNv9LnHkUlX1fC/KIs1Dpc0LQK3yI5AqaRXF70nFqn?=
 =?us-ascii?Q?n6/SUstU5r2zbKhCSvgGOPt2pnnRjpCK7x/tqwjNUcjRGWzYxsBe0/kQzine?=
 =?us-ascii?Q?3kioMQv7KRWIsXOYpDXNht2TtSs6Ld2XpflZbghgNDpgn90r9LuakhW0wYRS?=
 =?us-ascii?Q?PV4LmwrZRd6R8CDtG/eg4YfZ23xEyzT2eiXAuJ/vpfq/+Dc5uHZCM2KutJxO?=
 =?us-ascii?Q?NF06Hy29piacqi657c+xkX+3s9/e4bH4XdVNGGQa1RV/gvN15IM9KUZp4LyB?=
 =?us-ascii?Q?pCUO42QKydujU16URFZFNFzucosvY+Hgmr7oW3g/f97fvazPBgoiqJYrdRnm?=
 =?us-ascii?Q?3b0NcZjo+aaehIALPfvzXdvP9s/37HmXDF5hQwxGjqd3Iq/+XAG2q7ELmq1O?=
 =?us-ascii?Q?p2IpRb/PSKogE/DCEcWhVrIErr1th5H6prNf+ccbbwbpPsmJUy0ler/ofP5y?=
 =?us-ascii?Q?RDp2vjPenQC9ey+x/IjZf58o2Rsv7mBcGn4Uv7aW2M2NBNcWQwcha478XYdC?=
 =?us-ascii?Q?up4fEn32QZeaD2Aufo3V5QndpGxy186hVbJPGM9PbmwyE0BYWf43iehI4WdY?=
 =?us-ascii?Q?qoRN2JIJrJHobwYof6fVZ/CUptKBpqkPd3AdB+eyj0Ke0rVQ6EBL7GqObCVI?=
 =?us-ascii?Q?8Yibo4lJr+5EIBS/OIjp+/F84hmdr8A7KpOyIZJ+cRdz4kh1HKSXry0cu2Gw?=
 =?us-ascii?Q?hWj1wcAXdHJfpSd0rIM+BCo0tSo1A2UkEQ1sLhaJZHSk/9j4LjTNVv4mxpgJ?=
 =?us-ascii?Q?Xwh8LWQGIbo0DKQM6L2KuXogQhn6SnZNe3AlHepdvNB1Mt0b8/yEKep/GgD4?=
 =?us-ascii?Q?j5gJq2wq1tqy+LUGeCxzJj05P+NfPg+HBIBwqfkITK2h80zV9h6ermXVj8t9?=
 =?us-ascii?Q?Lc1YOFk2DJmOs2C5fxuqe3AO1fbvawW8V814Iact5UIUtDlBlHNz/ehAV0PL?=
 =?us-ascii?Q?m7yZce6QCZiNh1wrbMJy3PN/Z7VrdKVfbryymZ2p7V+gz0FYUho7g0AHDGir?=
 =?us-ascii?Q?JMB24apZm5X/xLIeveCj1ey/lFBUmVFHJimwOHlHSJFICoEEzFeFd/90TPYM?=
 =?us-ascii?Q?l8irgLsb5axmezNSBTwBtdI0FHSTK1VfwyQn7Bum8SwvqyTfJe07OJEHBudI?=
 =?us-ascii?Q?2Ub8YWilN9/KFrb0LiWfMDYOtYXL2wefrszVHoEZAZTloFAyExDqcde+TI3C?=
 =?us-ascii?Q?+7L91tGd1wGwGujoLBHFnDbJ+hkObzYNf4XvuMPfehdaPdFOQNTIoD7UC0jv?=
 =?us-ascii?Q?XbLrNj9xymBpUm21eiTBnPJpZaYEK3wFJtuMTex5D+wxdiJlWIJTHjiYZ5NH?=
 =?us-ascii?Q?xjPOMV3Z1EOImpAvi4nxdooEwf+JWtJg06XJHDQBsOtMSgC+uAxdwEPGz4NN?=
 =?us-ascii?Q?Xd8AhqwuPl7GlC6r8ukQw5LZIwH/brIRdQhAYukGUcBX9djssgGemCAx1BfZ?=
 =?us-ascii?Q?vUTYZcBdhIeP+fpMRDDTkWLsa72JWWRpsBQKwgBObQvCo1w4fdc2F+YNAZBL?=
 =?us-ascii?Q?yaJq8bgl8RH3AT2wPzwnccb0m54NQtlES61RtjqYi1/WZVAYnWcFi2uKqv6B?=
 =?us-ascii?Q?EuMWf0n9u7g9Vzkru+EUpZID+wNFyMNAx1Ckv7VB+N92eJrE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 910a6041-9a1d-410b-85be-08de8e5c4fa4
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 13:00:25.9809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qt65V0GWN4oNNMZZ6NUZ1xQkUadvvaxS9Uj6hsMvNjvYUSw9ejaZd+wCSa62ReRi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9343

On Mon, Mar 09, 2026 at 11:33:23PM +0000, Samiullah Khawaja wrote:
> > +	for (i = 0; i != writer->num_quantas; i++) {
> > +		/*
> > +		 * Check that masks are up to date, the make functions are not
> 
> nit: "the make functions" looks like a typo.

the smmu drivers called all the functions that build STE and CD
structs 'arm_smmu_make_xxx' So they are the 'make functions'

> > +	} else if (used_qword_diff) {
> > +		/*
> > +		 * At least two quantas need their inuse bits to be changed.
> > +		 * This requires a breaking update, zero the V bit, write all
> > +		 * qwords but 0, then set qword 0
> > +		 */
> > +		unused_update[writer->vbit_quanta] = 0;
> > +		NS(entry_set)(writer, entry, unused_update, writer->vbit_quanta, 1);
> > +
> > +		if (writer->vbit_quanta != 0)
> > +			NS(entry_set)(writer, entry, target, 0,
> > +				      writer->vbit_quanta - 1);
> 
> Looking at the definition of the entry_set below, the last argument is
> length. So if vbit_quanta 1 then it would write zero len. Shouldn't it
> be writing quantas before the vbit_quanta?
> > +		if (writer->vbit_quanta != writer->num_quantas)
> > +			NS(entry_set)(writer, entry, target,
> > +				      writer->vbit_quanta,
> > +				      writer->num_quantas - 1);
> 
> Sami here, the last argument should not have "- 1".

Yeah, I probably botched this when I quickly drafted it

Jason
