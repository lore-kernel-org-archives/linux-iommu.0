Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011012.outbound.protection.outlook.com [40.93.194.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7027133ADA8
	for <iommu@lists.linux.dev>; Thu,  2 Apr 2026 15:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775144128; cv=fail; b=tIgqlFA1HIk6tFUHOYObLFJSsCf+A4EoPGrOjQzZ4pdp51ia4OG+JvJDoes0ZDBKcgRXgYe7D8T+ZMroR169pFscm+xbLjjqwjwxRZTX0JpHFMaOxyWaTwadCID2c5unPOAcIlwOn/XfQGFJgdICKdftU170SpVPrBGuumYQqH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775144128; c=relaxed/simple;
	bh=mwtdJHaGk1jcvCly3VVxujpIII02F+25aSrHE168O70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VTAIse18DHeVf/8v9oCTW8dVEcCruY9qpByRGazY4wxb7t8nkV/mDyKJifX6DSVjgpioj/jecd1kU3mTXYm8yXMpZXBta9b9v/GVs6pnAYO7fARdm/nIKIHJ0bu2bl1E+KtDH6bU3T/hqwWD2RaRW6EnJNzBeakqTC0Wwqa7lV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IEv7XKOS; arc=fail smtp.client-ip=40.93.194.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IEv7XKOS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bn/Po4UVXcjGmlSN7AJf48PMHyML5T/At15c9NpAeyKCyysAEic/z7dY7UyqcpWPba0DyD31v5fM4Eoa0EIUcQGouGmgoOnm3qG/sG2trnI6b3YGqk88T4Wu1jQuYGZXuC3Jk+HHWGa6sz/Fhw9t10lLwmgu0LLqVOGn9V+CdC4x0+eJ59bG7MCOKJrQILj01ZhzyJL2YrEYKvtIyLEeK7NX6izXMH7tvNGe9GL6h6td+VdQ+hVFniCCH/5tf+w/63aQuW6fy4OUggfDyKnPhQ+DrHV7eycGObyMcL58Cm1T/7munTTyVscNLVDlsnNBg1xG4ZBas75lqZNGdX9r6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nu3+zaat7ifctRM8DmQT4jNiD88VvIrO4flC6S6RvZU=;
 b=iPoAGT+/0jVduPLtESNMoBJn0iQ2ljk2accXCKipOp4dPqqUga2Kcti005WzgKYSMRem08ELHE5FiU3m5JJ5O2ZxFTKoryMnPgwL1uFvMz53OfK0EI2CM3B67lZzMdU/W2JPLrdMIOzMq3Pndj39exVdH7mVa1lb78mGJVClMQHm7kphg99gyAlnpLvkhhME4cZbxNPB2XoENevO1TOVtUbW0M/w4PCMIn/rpPGpPlqmZUm3fK3PyB+hYKy6saRZdYPicbb8TqTSE+hDtU6hEGaHaB0DI1V6l5plvHweipTh7kH8mXQcqXzk8sOYSI0MAxEVxjr1JCZF6s/Cxdo+Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nu3+zaat7ifctRM8DmQT4jNiD88VvIrO4flC6S6RvZU=;
 b=IEv7XKOStCu87qcNKOaDcBg4pL/BrK4lvfoRVrTN1Kdda9WBNAHThE1QkVbGiRncepFfxWypIl8dwJzuLupJyCaXdTiBWe3PiX/kdqt6yjsHp2qc9mX7b0t4zq6TI3P54aATzDo8/92TnOnHMHMOgSuORj+EFXGiCS/MUpz4ylmy1PMJawj941iZynfvERpEttj479VW0BE7TFFI0xgalkCPA9Zt7JT/PBYftvfS7/l3O9QVYFcDCuGWm9MVYPcR0szbigaZRScr3oAOLZN0gPd1GLv6GlrYxiajr5heEwAZNpvosuiYWq3/YevGEckeQYxf2ifwMV172tTi+EoGFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA4PR12MB9811.namprd12.prod.outlook.com (2603:10b6:208:54e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 15:35:24 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Thu, 2 Apr 2026
 15:35:23 +0000
Date: Thu, 2 Apr 2026 12:35:22 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>
Subject: Re: [PATCH 10/10] iommu/vt-d: Simplify
 calculate_psi_aligned_address()
Message-ID: <20260402153522.GF310919@nvidia.com>
References: <20260402065734.1687476-1-baolu.lu@linux.intel.com>
 <20260402065734.1687476-11-baolu.lu@linux.intel.com>
 <5b23df32-ed14-417f-b694-a191f4423aac@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b23df32-ed14-417f-b694-a191f4423aac@linux.intel.com>
X-ClientProxiedBy: BN9PR03CA0191.namprd03.prod.outlook.com
 (2603:10b6:408:f9::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA4PR12MB9811:EE_
X-MS-Office365-Filtering-Correlation-Id: aff9faae-399e-49cb-5c20-08de90cd74b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	3cJ09GOueCvXIkHMW1nXz2GaANJmK7iGBBGzPf1agODeDGlejMS7fNVbTNXxPQkPqf8C+m26YyP7qu9HhbJ2Klr2+v4ZQsQr3CXAWGms0vK8+jj5nCf+5pG7OHDqPerHGkmcUvEwvfGaF4nuSsimIJCU50G7Ov0/nuZS86KCaVF1Wv65nSMhkLLBAx2wvQ9jlC2lwaN++PaF0YwuGhqPk/3UvXWCHn0mYBovFtpd8BKBO16TSqRD81DUZmDxvAa67dZGCgv9TnebKvLrYKPs/EcPh+a6SI19m5jkKPJp4Y2etmuUG+8UG5qk/Rt6Hq3qKTaVlpWJB1ADAIEGo4SPC+i9pR6IJ3VUjjYdQOWJGoqNCvBqod++C/iaewx5ROO7yR+mt36b9qq9iZokyTjr9jTJKSmr59q+g7Esw1aHfpHqOvI1y53+21IDeDF058QIRZmwuszB+tDCBwDsXlymth9J/8xXU1VquKo5UTUM2ILVsYZzwE5hcxNKUC+5YaAsHKPBeJrH13Wh4OyQcABOAmBY9II/pTqF2PIvT43eRVf/00iVu8iQ1YhIbya0BpKve+XGsn0y3pYibR/i9FaS+2ta1X7PAKiwh8ohDTlNGCE5bUQmwtFKy63wIN5ziRyIu/F+YqGaWdlV34IzGxXpUG4kaliFLvhBfFXVI9eAzefyNuGH04dKKhfpSL80PwGgzj9lHvP8Sjd7TR5gniuQe5iJ7b27UC373LWHzO4z3X4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OgWVAygHtp34lDt13BxzOcg2ZDaUVckvOYjux5w2FYo9p9e5GeWQDqYWzrAc?=
 =?us-ascii?Q?5Hc6UQAmUb3dZhAlBRxZnPsd6+ZQHVOlCgsmTfUrv4QrpVFVwaLoYNo39Sxx?=
 =?us-ascii?Q?g8a6XOz/3MSBmt2JkxJBmx6jzMKfaTHKhsjEr33G0w325UKLoV5O52QSmr6E?=
 =?us-ascii?Q?xwzqrSzrwabe6HSlUXMHSSkjYouYccBlHtFg/ElrVtD1smxsUjtYBjpOYCba?=
 =?us-ascii?Q?tqDYRmgv62rXR6SWlmzk4Sz+nLQkWWnKf2ndoBtdrvRrN2LYBROonktR3dSe?=
 =?us-ascii?Q?k8gZe5/5MkTnMfXJfYFT6NNVb8K1jwfkxO7NPS4c7v0HiZdLulR5MDMBKUdz?=
 =?us-ascii?Q?XmArLHFEPEtD2yZDmE56e98HeF0Sch0othRMSyr/Ru6DqHB+aBjuj9lRjN6x?=
 =?us-ascii?Q?gwcUIhzu8C0PEMzXa6wGRXepCdE4DfoC1PtXV9+PI3207Jb4stc5U1TWWEC4?=
 =?us-ascii?Q?MJQ5ZIxp9xBbUYC9hhbwzkgTCXnRILIqYyRwvwYFf9nC1LwXzCSrG/Sky4B3?=
 =?us-ascii?Q?QxqrKqGFxAETQryKUgZCVy6qwCtMUh7LSxcnC0KgQNt4agPvNZHacmB2AtDz?=
 =?us-ascii?Q?W3IMUPgQjHYb1GFr4EVbJCEztZgjHusHuzBOARR6cmqVD7s5q0qIeaTJiQ9o?=
 =?us-ascii?Q?KH3pp/r7n3thm15IjT7+A39Wq6TzoD4zEYlpmU0TBskrgadGgAFohDFQyJWp?=
 =?us-ascii?Q?cU59kwbFAAjVfn/7VC8Z7rvAJnYqdje5RUfhIWE2cR5HiyU782M02Oy0qKEg?=
 =?us-ascii?Q?CH7T+ZjHRqOZFDoAAGt/fE2lBmQKfBUJVD2RNrPlZxHM0QKUm47X5T1cCV/l?=
 =?us-ascii?Q?c9JSD9JDZq24YSt5cpjwz+uJbupS2ld3m5//DkSXvvQUoxzHu1VRdHP1SNEB?=
 =?us-ascii?Q?1sWnCt4jUFCiUa9/0rhhWbuLvBK3fA6VwmmBIz5aGFlxvXfK4o0oQnq4RNMn?=
 =?us-ascii?Q?CYU0k0iHIipNraIX1AlwyhE96RzqOC5RTMMYmTJn/9+FpbYsEYTTQzK46Bjt?=
 =?us-ascii?Q?7RjyI1uhZn0SOjn51EAYP9UYtQCs8JqRy9RdGCqZfe2rUivyRUcjwuMl3dmx?=
 =?us-ascii?Q?gKfs/awcMBS4pPzZEEKP/clqLfMtxgegPb9GtRmj4MPvJo1M8jihmNZArE/3?=
 =?us-ascii?Q?zvKcHsPeQIAdDaI8csVv67Zv5lqj8YU4u/+ZaW0DOaTadsVPK5dpFq6+HOHD?=
 =?us-ascii?Q?KFJqd3ZqeFq180n+PHTxZUQ0Q19E2/elFeHabb7VXoCcYvmighUXdnAx1slW?=
 =?us-ascii?Q?r9A9dgC0sXEC2bfGaioRBw9odOqpJcAZIJ4+UtucI9sOAzxifqQ9VVGohx32?=
 =?us-ascii?Q?aSdMwE6y6rWhQfxT2QJgQqOW8ZUrEHTMEtJP3/EjXU7sEnowLchFj36LOHnS?=
 =?us-ascii?Q?aUmHQuDOtf3NeuT05JTxYRhmMnjPtzQznLKBs32HoOmsDX52V+pZlwcK0ms2?=
 =?us-ascii?Q?71p0AZ+Kq1D7ij4RfrKc/dp4kWX/dgbjBEN8MNa81dA4Sx3ad+upvSWkfy2u?=
 =?us-ascii?Q?yQN29mJeAkPAV5XpoPLParh7XKCJiOmlilaFgQi8mOSuJusN33a2IJsNj/l+?=
 =?us-ascii?Q?5cPwHB+egeZ9ob8oIOMc20a65/wCesGPMT1qEVKFk7ja8DiXhniUjEnj1O9G?=
 =?us-ascii?Q?e3mldA0CjFvg6+k0TezPnGu067Ytghdwm301jNuEwApA5v51cRiACI+NuMim?=
 =?us-ascii?Q?qL3A8qoC7Xn52wvgqhXdc4GaW4Gv1JTPUVkE4PBbEliYqATe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aff9faae-399e-49cb-5c20-08de90cd74b0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 15:35:23.5716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZuIhqrO8HeNZJlrcMQ8ugtAUTVxtvIJc/rOPmJ7jpcEqR9whJ4lENHwKQ6wqPIdm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9811

On Thu, Apr 02, 2026 at 04:39:08PM +0800, Baolu Lu wrote:
> On 4/2/26 14:57, Lu Baolu wrote:
> > From: Jason Gunthorpe<jgg@nvidia.com>
> > 
> > This is doing far too much math for the simple task of finding a power
> > of 2 that fully spans the given range. Use fls directly on the xor
> > which computes the common binary prefix.
> > 
> > Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>
> > Link:https://lore.kernel.org/r/4-v1-f175e27af136+11647-
> > iommupt_inv_vtd_jgg@nvidia.com
> > Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> > ---
> >   drivers/iommu/intel/cache.c | 49 ++++++++++++-------------------------
> >   1 file changed, 16 insertions(+), 33 deletions(-)
> 
> Hi Joerg,
> 
> Can you please remove this last patch from the pull request? The AI
> reviewer reported an issue in this patch.
> 
> https://sashiko.dev/#/patchset/20260402065734.1687476-1-baolu.lu%40linux.intel.com

Yeah, that's an interesting remark. I think this is enough to deal
with all of its items:

-       if (unlikely(sz_lg2 >= MAX_AGAW_PFN_WIDTH)) {
+       if (unlikely(sz_lg2 >= BITS_PER_LONG)) {
+               /*
+                * MAX_AGAW_PFN_WIDTH triggers full invalidation in all
+                * downstream users.
+                */
                *size_order = MAX_AGAW_PFN_WIDTH;
                return 0;
        }

1) Yes AGAW_PFN_WIDTH is in "PFN" not byte notation, so it is off by
   12 bits and we would errantly move to full invalidation too soon
2) Yes, if sz_lg2 is BITS_PER_LONG the GENMASK explodes, in this case
   it should trigger full invalidation even if ulong is 32 bits
3) Yes, we sould retain the 0/ULONG_MASK means full invalidation, but
   this happens properly now because of the above BITS_PER_LONG check
   so no need to bring back the other check.

I'll post an updated patch

Jason
