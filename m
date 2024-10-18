Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2046.outbound.protection.outlook.com [40.107.101.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183672022D5
	for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 17:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729274401; cv=fail; b=C3s0dStmsLzB7P0X0h/tRz1OaEW1iABOMMIjUxC3EJOCiCJiHZYyY8rpZlIsoVw0mBaI6xtn3FtMcX0r7L7W5Tsy5+i/fK8ek1kVRgZvMvACWRet/drrGut3yDykkFj9WWSfucCUu3NpUvwhwB+LKSlbI26U894TVqTb4Qc4I4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729274401; c=relaxed/simple;
	bh=t56xo2cfNuPyLZrvguYQJ369NUXQZHetAuuZih3vP/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RnGAH3R484W0eRR7wPuF+Ju5kn3nlV4wPLN60msnU8nWc3eA/UcVNPuHwfj4GrdgDz/triCMXdiHbLYy7oGuZFmF2nzthWe0xqabqwa0NjtArW+KQlUX+Er7W+WiFVAJNA/q8ZRsVcd3FV+pz2/UjjTU7SgRICb8m6C2nUUdW3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qYKka1eS; arc=fail smtp.client-ip=40.107.101.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qYKka1eS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pmV3LTZbjrnY0p3u0oJcfUoBqhhMO9aCDv4JOyq+Fq9AFaYwMrBiUEyL/2Kf1ODOLOPyB+2jz4jHGJWMiOiqd92uXaocvCXTv8oeighlpuIdczL5KSnFvZ85xz3MAqi7t/enc5ds+X6PO3K//EJMcxfIXxN1uzqCtnhPou7vjb4ge62ZFlwOG3SlNJwLdVNW29tQB/KV7E/lu8O5ZsHK5galIpsrOzsT0qarDDnVM1okkvJnal0G/QBzGYs0jNq7FFoyV2yHYFhZRIpE0iQo/9L0376Dp9Cw3TS1xJsmCw40w8dGLopcVxvCj2nWiqJAjeTFj0CA2weFAFJfjtz34w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rrr5qVP4C5pT2lDegKLQQ4xMWQqiwdjZGkrTr2Eh+xQ=;
 b=ix/I9nhq4lM5qCbBoujz7RWkEaPe3Ypp9Aemom0mcBl/reY+49sxIWZY7x96hLHolZob7b1Ja2QjcSK/MHnKddSwIGBlVWNgA/g4maO3GRXBfqtjLgXsKnYknBWqZD1oq5sqxe1HVlbHX4vNVL+lDynq0937+zpn3CSovjd9vernCOnIGHPZCQHPK7bWQtd+N5mnuDXd6cFUT2csvZ6xkf+n2pVF/N3GSgbnONTHg1os4NiEP1OjGJh8fqUeUXNvMj5J9oQ+Gk8VHK5LbFjUKIzpvPtVBnXcdHP0v0R2jThOiVhNyPFYuaA8fB/dxrAKYZ5AMcjoCppgMxnlA0A/iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rrr5qVP4C5pT2lDegKLQQ4xMWQqiwdjZGkrTr2Eh+xQ=;
 b=qYKka1eSKl7LN/Ral5T0n8RnsWJAy5/Pag9UKeaEUAOdjQ/En/eDBanriMQLiGzvS43RhmDIjNmnW7XqdrQOHxIgYFGUsr3BT2MkGa+oVTVmPvspSAD9SvxW6wqMXwah4Bggl91BE6pMVrKvmrOuUFNi9y2ijgggzvmyPwOYXeJzVULtk5iwZb9NhT2gSOukZVpi0NLSDkLzg4lGzd9ViO4Z6vBSeJSBA5OaSf3EhxxJddJqQWfuvBu4svG9laQ6HR8+GF6GByQkP5kgW1FLlXOFmiPuFM/ZY74P5Bwr1L50nUn3zlNTceuKggRem6r40c/gCIpzsYNT6yiPwtGp2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB6068.namprd12.prod.outlook.com (2603:10b6:208:3ec::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24; Fri, 18 Oct
 2024 17:59:52 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 17:59:52 +0000
Date: Fri, 18 Oct 2024 14:59:51 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH V3 8/9] iommufd: optimize file mapping
Message-ID: <20241018175951.GK3559746@nvidia.com>
References: <1728067700-32092-1-git-send-email-steven.sistare@oracle.com>
 <1728067700-32092-9-git-send-email-steven.sistare@oracle.com>
 <20241016130001.GI3559746@nvidia.com>
 <6fdad0c2-8b6a-433e-9405-016aaee40413@oracle.com>
 <20241017192418.GD3559746@nvidia.com>
 <c4574487-346a-427e-a97d-6e1ee366ed1a@oracle.com>
 <20241018001046.GF3559746@nvidia.com>
 <279c7e80-1d72-407e-bfb8-d286760a5e11@oracle.com>
 <20241018160430.GJ3559746@nvidia.com>
 <dc59dc36-027f-42c1-971a-8218c658c5a0@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc59dc36-027f-42c1-971a-8218c658c5a0@oracle.com>
X-ClientProxiedBy: BN9PR03CA0530.namprd03.prod.outlook.com
 (2603:10b6:408:131::25) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB6068:EE_
X-MS-Office365-Filtering-Correlation-Id: 94117819-c90d-4341-4767-08dcef9eaa4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U5H1hoUHFB3quxXUFqQG9dzRO1klB3sCQDarhfqdmfOoeMAgOHvfELFdi0BP?=
 =?us-ascii?Q?rjixdlHMOaWNxYrGzVo2yvut2JNbB4M22t8/D5ENGLXYPnKycF7jG68F3gc4?=
 =?us-ascii?Q?V1C5KeOlzAxtroTYyPh9NMHGvCXM+ldGAXPTo7pYgBpv0V4n7r+IY1NJW9dB?=
 =?us-ascii?Q?Ue/ocKNI8AR0IvI+uCd0OUjIr4mlebfRhDT9Di27MHTvuKBsPIeP5bPQvHj8?=
 =?us-ascii?Q?i5S/6dEl0y/uY9NaYZCG+oXigW2oivKEYYixC7MzLryP/er/R2Ru4YryUDSZ?=
 =?us-ascii?Q?LMhtrUVPFHIa3fXDpzsxNp0Xl1cuyEZw9n6h0nH2qzl1s8118h7HoJeIR+dA?=
 =?us-ascii?Q?HABuec7HO34MTclmtD4uAvEmrFROPA6bnkmC+X9VgVxPZ5eHdcnI8GWMdPCs?=
 =?us-ascii?Q?Ny+ISTLWsKoUZNShkrAjtfB3nI9mzwE2vEPe/q6GBAqqBtYOHf3e4LDyZLCZ?=
 =?us-ascii?Q?m46lt02IDAlvRKkeHSXPOkgLgXBwhxZVY6eO6ChE5hToYKZ74ojBOt3sdG3j?=
 =?us-ascii?Q?xhb2Me0nbJyFaZzdKqU5qshcrks9REg1RIEsJ74fnan+XyaMPljblVaAzSk3?=
 =?us-ascii?Q?hp7Iw8C8tUo+SQ0YnmVoVWQY++xAZJGXTlNoWuvzBOloROWrSco0PMGHcPSP?=
 =?us-ascii?Q?be72qi3MmjvrhUfqP7ubVdVMhBWkUW6oTz6xAL3nOVLk5IjhmBQctc/CQIrk?=
 =?us-ascii?Q?tjbl74jTzTp/aIf0PeUhFUBy4VkHRnijqfK+i3/1c+cAp0w+s5knLMpk3Nvl?=
 =?us-ascii?Q?QOIFURoKeqM/+WNz3Ro5uegJefetuyAIAg/fe7HaSQUtxCnDxV/gRizJYv7h?=
 =?us-ascii?Q?/KDAos81ebGlGIAPx4Xi2dxnVQbeN0O259ZWrgOBe8PyWL5ShSWYbHEyhSi6?=
 =?us-ascii?Q?XpHTdS7INuZ9lkBiO+t6wXoOpoHM9+vP5TT7mWdX58EqJ7YugVw1+FdTjMvl?=
 =?us-ascii?Q?mgJQ0MLO1ZVmfpvqcjUntC8kuBbZSHP/57glhu4DyK61jQAP5ff9rzJVROkQ?=
 =?us-ascii?Q?vZV/XlTnfalhWkOwKYwg34+jNqQOwI47NXoCbxVMXA9coi8YyHX0eFzjy6+6?=
 =?us-ascii?Q?R4Cn2grtb6UaixhZRggSGYc0VzMg7J2ecstZ0uIB9RLt01RmZVFOsA7fB+Z3?=
 =?us-ascii?Q?qRkF71a3nBhkgbzF1Z2utiJQCWJ8dY1xKKD8bU60BakpUzGmmBxloMwt8ul4?=
 =?us-ascii?Q?ST2Ei2ILZYI5IcFmDzaMwM3l0cIeiIRTjgAINZbKTlqNm3CmZZt6t22aQDKU?=
 =?us-ascii?Q?x2UXxhYeKS8p/bHIqmWiknTGvBOTe8tZe52ArRZfcGMUD7GOTq445YF2phon?=
 =?us-ascii?Q?iZnCaO/xV58UjDRGZHeUyPYl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C9Xpf6TqMJHBlwl5oWyw46pv2DecEAMZ1Xc6OJs6hlaeOADZnhzg/Il5cEaW?=
 =?us-ascii?Q?0mfEn0GLhDkWt56SVrNqZf+U/+/BCNLIpf3hoswcfzHvEmzb1+ED3uJW2PmK?=
 =?us-ascii?Q?9qpLe3y6nPEzTj3/pDMaSr/yuM6Edtt+MZSpBW/2xWXoarjEBsjprHS80rK8?=
 =?us-ascii?Q?Nsu+sdRzU+4Lf1G76AEMvH5zcEntrKCNsSlNhJ9EINM2aDW9lDyjB2ysxRut?=
 =?us-ascii?Q?XZqdU8AvoAvNnX84OA3J26nZ4yOFGGdmx901iVnnaCvq8D/mvyIdz8OfhEnM?=
 =?us-ascii?Q?yhWedMQnT/G8IwUIYvq6eowagTuzPUIEMDEyANiOSzpY1kONOPFWlImZDjjg?=
 =?us-ascii?Q?rFuIb3sK5r4gbE/9nOR7+TffkqUmQOBloP7pWseVmd0AApgBB6/U0K0jk8sX?=
 =?us-ascii?Q?LdUM3P2Gy+CrzYto6SFsQtFW3GtOa/abdiCKI6WdsK1G/oUN9Og7BBMJPoOh?=
 =?us-ascii?Q?VqS2Y4lIKqKJMA5JeEO28xgI0n4pvtLUe6EtO9IHkKtYnPeBC2d2UHhEyFNo?=
 =?us-ascii?Q?EbGcLOvpX3AxkRMRPDVv6cehrLNJAx2Vga+acDjGnQ/uYaSVwTTWXZa/bops?=
 =?us-ascii?Q?T79QO7dchUnJpE3UjTE19LbLYJBH3XfxrSfAfsKeAbjgNRlZupDuckTzOnWs?=
 =?us-ascii?Q?3msWOkanu5Frv534paJcdYPU0c+c4HhZ+u201hZ4RjPv21wdxJ9RZCQbCv9+?=
 =?us-ascii?Q?Km2vJPdZzhOukLzaz5q7HtbhwSYjO8H7JcgDB6XFteWyhd+DQB/cTxGvWThV?=
 =?us-ascii?Q?jPf0BbWjGn4fmAe1Xm4R5yV5MkAv3l010D4Sk7sKJg8MqUknfImeQPqZlT2W?=
 =?us-ascii?Q?EjadxJ8VzXDSXJ7iCvWcxYfdL0LEpk9YZk+G0MQR+7VS5H769VhptH+GrITj?=
 =?us-ascii?Q?He897yZKucWLIE8dgZbyhzsk+TWxtjmEpXIsezFCOcTrm55KtghhMZVmastw?=
 =?us-ascii?Q?DEAP/u8013nNWbsT66rzkYLCmDtm8/aeC+C37272CFZgOTRvH3tltPQfw1PG?=
 =?us-ascii?Q?SlDqiEwFMpl5Rgh6Ehq5juQDfyIAAtg1OQhQhLGpye043+jqwxMYNLRauArT?=
 =?us-ascii?Q?/eJTZ1k+CPzM549t/iA/AbHB9dxJ5wguuW8xESNx3BbybhbumcFDPOtDFLno?=
 =?us-ascii?Q?3HKOA7jcUQVQzchM/m3VuOzFKAvBQYWXlytwNhxE3ROAfDKZQRanoKJ9REav?=
 =?us-ascii?Q?SQKV98UcQWkQTun9WeOQYLEyrBOROnGeyYT2EQbttaOmfOKAAiZiVieuQ8Bw?=
 =?us-ascii?Q?yzOYapf50VeBLkya3bIDBpWRLm4439pVQIaKKMHCx1ermiRy95dvkUu1w7wS?=
 =?us-ascii?Q?I5Zbpi5wy22WjqI9rn8NXgOPi/qLgaJCv32/MnD8Pz810M4oB+K1vAvRqQwE?=
 =?us-ascii?Q?aCVVZgDg/EynH6iFJaTEMAy6sYUvPYXp+XfEVUoU1W5u7bQscbLDge7MzMay?=
 =?us-ascii?Q?2IbYSnJ8sQPvbxOLuIKbexFJhwgMd+AHIe3GHKUEkOZnHH1IEVS0C8cwOK6d?=
 =?us-ascii?Q?P6+zBQMh1yIqlJFgRl0r0sI2DQ/XUDJgkTOvU7FItbBdmCddpPLFjuw8+sAb?=
 =?us-ascii?Q?ZXrKe+IkyF5Efe4tWQI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94117819-c90d-4341-4767-08dcef9eaa4f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 17:59:52.2431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H1D5sevJfbm/RfVp0EFGqbdMaqPFH9Fw9oguRehRUos61k0jNvA3v73o46xS+bm0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6068

On Fri, Oct 18, 2024 at 01:54:12PM -0400, Steven Sistare wrote:
> On 10/18/2024 12:04 PM, Jason Gunthorpe wrote:
> > On Fri, Oct 18, 2024 at 10:34:39AM -0400, Steven Sistare wrote:
> > > > Ie instead of things like:
> > > > 
> > > > 		batch_from_folios_huge(&pfns->batch, &user->ufolios_next,
> > > > 				       &user->ufolios_offset, npages);
> > > > 
> > > > Where npages is the total number of pages inside the folio list, it
> > > > would be nfolios.
> > > 
> > > The problem is that a batch may reach capacity after accepting only part
> > > of a folio, a condition I forced in testing by reducing array_size and
> > > MAX_NPFNS. We need to track which folio is partial and what is the next index
> > > to use in the folio.  That is ufolios_next and ufolios_offset.
> > 
> > But why is that such a problem? The ufolios_offset already handles a
> > partial folio.
> > 
> > If the batch fills you leave ufolios_next alone and adjust
> > ufolios_offset. The next iteration does exactly the same as the first
> > iteration and takes the partial folio.
> > 
> > The refcount has to be handled carefully as the the portion that has
> > been put in the batch needs to be refcounted at 4k and the remainder
> > remain a single ref, but that just means adjusting the refcount after
> > putting it in the batch.
> > 
> > It seems like it just works naturally and avoids the double loop
> 
> Yes, I can squash the nested loop in batch_from_folios_huge.  (I was off
> point because I thought you were suggesting something else).
> 
> Do you want me to delete ufolios_huge and its special cases?

I think yes, if you can get to one loop then it would be a degradation
to sweep the folio list an extra time just to figure out ufolios_huge.

Just check nr=1 in the batch_from_folios_huge body if that helps

Jason
