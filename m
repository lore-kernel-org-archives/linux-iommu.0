Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CBD23C8CF
	for <iommu@lists.linux.dev>; Fri,  7 Mar 2025 16:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741366679; cv=fail; b=YNjwvbwdcozjTnUzoiDmRAuJzr6pIxeuIUCh7hJLVyVCwEa5ScurYS7zzYO/EYx6TDYDLe53hOKuD59UoWN1jq4PWw5SVB0EgJeq7f3qjwo63R0G6l6i7Dzo3nwBUt43L4MqNME5A405DhRg5qrHivQNYtrCvAaoqb+uHtQebp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741366679; c=relaxed/simple;
	bh=ZAecX/XIFRh2jerYqXnf2R/BbV6d9/cSBVbzofj4Zs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gbfMMJ/KQwdprrScwjHEQzkFYeekRjrwGwhPPkp6uwWpmPNuLsKan/ycyYL+RqZ90LtTz7EiHBcL9GYdCmzKiGDeWtAEbJxv5/CwPwihQ0FWqR2zklX9oMs3VcJ8wfooR28CkxBfRBCWrjd82iD4WdM1zrcix2ULtqAU1xkKJ0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XqnEFtJM; arc=fail smtp.client-ip=40.107.237.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XqnEFtJM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1qCBm7TImjMpkEnj9flgWJsWaffHZ7zpiFVaNVO2hJkJEBoggJevhYu72CD/MpyNgBuA2PdcZf3VUrvkozPxS103BY2b0Xf9TDYEuBPExcW3DmJ9Who9kBcJLSMpRc3pnjiVZlUq/XdIqUABXpAW95DqerewfDKVIY6mMTCyDPdNJy9IenXszxQy56Sm0Y5+pN3xZA/8E7M7aWr6zbwuU43pQ1EPmfN6mfZ/16+bwmMN1K15Bb2EXttpqfk7lmCZtY7nHA6AHFzQm81W39oDGzj8aQL0mtQN5XoWGP6P4H75ItmLO5zN7vAZ6VF+jVBQvKafoqxhI39+6uEEJYhqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZ3EKhWtQaSD1pqQHjEiqCpk8hbVwlxgI59ly4JfuOI=;
 b=y5qJoG0VbpEb6LCx77KOl/PKRaFLWIZPCoTdSrRuMeaQMPMZipcIto9BIZP68Vn98Eieo0nIfOhYK/+NTVkQ8lye7VRCytGrnmncpy8BCAeRlAvlCFBkvBssE63JBrxZCLRaYYWSeTahoVdEkSvoEALbOfqHlfBZ2MDgt5Wu2JW6SSbjraMvLXGuGdgtRe/FAyfxsWUzn/csvWKka+g7daytTfmJYfudY9p3Vc/Uo9gaRT0pZFrSYABYsROPxuFWCoT04BM+w/Sl1DBaXD+lZFWuCLFaierq2vAWUa36s4BDmGdEwlPWHPx/gAFTojQ13GdCCIWmL4UoP8yM2xRzrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZ3EKhWtQaSD1pqQHjEiqCpk8hbVwlxgI59ly4JfuOI=;
 b=XqnEFtJMTmILuna5oV/qeOHcJPhlHGbuAs0MESb+Ahn8yM9pn+52rmDpDy25G4eWHMLgjEdYUe2h7vbfn8/E2ebrrBr3ZnLUNJkrOgYq+uuLc8rMaEt0AKgmy2lM3+MoZXIK3ABTyy9NEljfgmsQZyTLybcJ/jALS8AMUdBHRmUO5XBcH8rn7dLMmwKlLbgDmm3IMAQ+k9ZebZKo2734ffo6nIybfkt/AZ08PUK3BP610hTN95Yo0NETumN7V8l2tpv93wwpuNdrJZvSF2VYwe01LRuBOGxeh3nQeCHYt62gRE7YWDj15kRx1UlFNaVG0NP34wpdPxN1yplPybfLsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9)
 by BL3PR12MB6546.namprd12.prod.outlook.com (2603:10b6:208:38d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.18; Fri, 7 Mar
 2025 16:57:53 +0000
Received: from MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f]) by MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f%2]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 16:57:53 +0000
Date: Fri, 7 Mar 2025 12:57:51 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>, aliceryhl@google.com,
	robin.murphy@arm.com, daniel.almeida@collabora.com,
	rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Subject: Re: [PATCH v12 2/3] rust: add dma coherent allocator abstraction.
Message-ID: <20250307165751.GT354511@nvidia.com>
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
 <20250224115007.2072043-3-abdiel.janulgue@gmail.com>
 <20250305174118.GA351188@nvidia.com>
 <Z8mlAxsszdOH-ow8@cassiopeiae>
 <Z8m9j3SwWHqaCTXo@phenom.ffwll.local>
 <20250306160907.GF354511@nvidia.com>
 <Z8qzP3CR8Quhp87Z@pollux>
 <20250307124809.GL354511@nvidia.com>
 <Z8saLZAylcVp89n_@cassiopeiae>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8saLZAylcVp89n_@cassiopeiae>
X-ClientProxiedBy: BN8PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:408:94::22) To MW6PR12MB8663.namprd12.prod.outlook.com
 (2603:10b6:303:240::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8663:EE_|BL3PR12MB6546:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b005a15-4833-4ae3-ce39-08dd5d993342
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4hOPmLLsXAxgkJQ/0bRk/JgL9Vo6jA97+p//Oc6gtzaQ0lMRr/O9Q96jIX4J?=
 =?us-ascii?Q?nDkKLvDihOyarNIzM0wOjZrAMX1rWrxcpisxvXvXLESO8yvg06ucMUur4cPZ?=
 =?us-ascii?Q?WaJNcFiHxn2/5Vgt8PpS0Hdh5/6C76e8A0dfVomowfo9AdJph2ETiBHlJjBG?=
 =?us-ascii?Q?Dka7ZER0AIJ0ZBEb2O7uSVB8k/87/tB0xzSkqHTZUwCsjaEkl2AYWNWx7mJb?=
 =?us-ascii?Q?XPX4foe+yyGTy+MFRcdS774G92cCXGs9Kqqx5iF5BdApIgDVAkyblMIN02oL?=
 =?us-ascii?Q?FUT82s6ksV1EXp4I4meY0Aa9CHAfmlACEjkuLK1JdZP/9w6e8+rVSiIRfBLu?=
 =?us-ascii?Q?mNUiuF4sZqeCbrzUhJKu8HBUcZxKDmZfUf7lFDvve/Y/adELQt3rRkbPfLSf?=
 =?us-ascii?Q?pjRQKLQgtWho5en6cnz6mGhDUHLOfjb1uubDY2uLGFwWTk0bXGfeDBaLGy4W?=
 =?us-ascii?Q?XrcTdj3xpoczfKJscmIaIj+VMSKzg0ZzIjbivAKBpPzYe+VBPefPLY60Jptv?=
 =?us-ascii?Q?CgW43/ESHkiEscaCd2+ZVP/KP7U632lDmayqoarEuJlbimY46GQJReh3T7ZF?=
 =?us-ascii?Q?R7rqShF0j0Bc8F4nLi1KdSjj+MPPXymHvxSbtGUCQyEUzJsDPvsKeN1ZFZJq?=
 =?us-ascii?Q?lR0TmMAGXuoMHmMmRcn3NOeRyyJ7WDMSKI07Kilz1kU0SMo6JHeJoU1bUs3T?=
 =?us-ascii?Q?qXGT5GC3acjpGEKcBmCNo9kTb26iGmVotkGW5Y5XdLJU+eBeSiFdT6pTl/bp?=
 =?us-ascii?Q?U8aPlTLZol1RFKSI+WoXjjleH2OhYp/ciMoeI+nuL74x9s+60f9XqEdf33SQ?=
 =?us-ascii?Q?3jbiaVWCFMKLSqHT3hsZjE8oRTLh6V2OZFXugXCgzTGrfrqU4JqpsTSbmC8R?=
 =?us-ascii?Q?+jAnb/VB20lPB7L2TFZ9Vzhb9onstM5lFqkxaHdZTjo8No2QAOEHtJt8eVua?=
 =?us-ascii?Q?lJhVFx6KsyKZ7VgZRcChCqA4RbBebpntmEyLzveDIzf3YYbTJtKu/o+vTxKU?=
 =?us-ascii?Q?63YKdOEzZBIzcBbLiqpG52zIpcLfDithYn92IfDQVRHN8jd9lWijSu5JSWBU?=
 =?us-ascii?Q?6jK6bV6KydODuLHhLnp2jYngDqiFwVl4LC7kRrglHVjX94fg2I/ko62dzU6H?=
 =?us-ascii?Q?fYExPo+NmcDSYGgvLyIGXUePwkFomy165bJHEL9EzmHSUJIHK8C0SygwKBff?=
 =?us-ascii?Q?nJ3LqmFWeLapA5+bueFEY0wsu59FBzOfy2hKNZyuaGK9SyUJQeStpxBmWD/c?=
 =?us-ascii?Q?5QnERM+7/JM8pPVHaEaam0Xt5JZUURu+W+A3Be8+ubv+GTbNTidKpRfwZHMT?=
 =?us-ascii?Q?58Py+Qk3JyqBpB/T2eJCyu/pVIFj9sK/qfwV6Dmda71MCeHntK3AFe1BsprH?=
 =?us-ascii?Q?RAflVpnco3REddDpcoODoEMczUEE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5So/iiP2U9U8HOYvaa10ohjdCCO8ICgDqETe+Oxp4UT+piyTChTaywSbulG6?=
 =?us-ascii?Q?TVKBp3iCj+Zy1QrkQtgwbjtdLOWdtHHFlAZr3qm6zpDky4jxoCn2ReYgv3Pj?=
 =?us-ascii?Q?Qf2psTDISR7HKbSEhKKqwkRE0MU+TioCycDfrmYD8VL0x2AJSHJNtVZIK1Zp?=
 =?us-ascii?Q?uzkIDHq9TPCUzohQoqQG6QFdFl5Fj0k+bmAR1DqGUTYu4S1tDIEoZAoJygY7?=
 =?us-ascii?Q?WAGnNW6RZVQWf9REYUa9g/yl2JUxo8j48AfW+JpsPlOkGY0B3zr7LPx8KGko?=
 =?us-ascii?Q?wm3b+sUcZIvWMumYsapjiXj2BkLohjyenHwEEvuBtg4dp0cQRI+3WbD1CICC?=
 =?us-ascii?Q?b16sdpdpkKpO62q/pGXH1IP85OjDu+7dkwqir9p/Z5DqKCd9Wwz+URYOzYV2?=
 =?us-ascii?Q?EPWoA/fSzzRzaC8BVTI5VLzum458UCfrDOZQQJn5UC6rKKw39dbHOtyYS05V?=
 =?us-ascii?Q?kEujtdN3YduWQwfHa6sNpDTJHEBTCk1A+c/fMPKey+GjDj6l8DWvQnJ4Jv9v?=
 =?us-ascii?Q?lNTYHANRQWGxeBs8xg9VXji1gUVpsTObZnksGbnJXn+RKMQn1fwPjXDu6BxW?=
 =?us-ascii?Q?Bs5gnEoskcBenxXYdYijYFouWwePOrze4f6Mgp5i4GQJuCw0v/slk7YFN/nU?=
 =?us-ascii?Q?UuA97SRU3R218a+WxRWbR5Lw1aba5ooEP1mRAzPBRznGul3oob62Q1plIOJK?=
 =?us-ascii?Q?5GiirGs1t5H4FW+raGsfaOgDVBwAqTXJaRhACle4TGt9etwtf52YUzIuQ+09?=
 =?us-ascii?Q?blb/felCgZ1lQwC3W+xzLIjZmbtnzs9ovdtL8OOQgRiqYyxVvd3nhfZAj1z9?=
 =?us-ascii?Q?MRlmwBItfeZQnddixW/9enUo7Rl/cgIDGlp83l21NiLgOvMZkVEE2K35kOZg?=
 =?us-ascii?Q?/0T+lfa0g4lihHckMXFEP2MWUp6aP4093jngX4sbGt8joEtf3cvCXw4lbYlX?=
 =?us-ascii?Q?BR+rFdMZnq+MnnO3zxINzbfzhWObWrVzYK9nd7D3zBZ52A4MavSkauS92X5o?=
 =?us-ascii?Q?0GDDuMr4xPSVOa6BsfZfQ+tYFOVckMEWfUQxX3aWkIrAr5m9ERVteDWZWJl8?=
 =?us-ascii?Q?4towhpI45WFUs52ZN5KyIfTzYOpKSF7HBVSkjyxvyA7CPEuXzUFf+crpj976?=
 =?us-ascii?Q?AwIb/zG0gKNL8EkVo0DbBJ/uFxwlIf+zpuQWdhQWRjJJihbTyKWKj5RM4KmX?=
 =?us-ascii?Q?/wv8n96wf9F3DyQvnoogLlgRTerI0ojzJlKcxPdVoujYaBwhshWakaaOL4+I?=
 =?us-ascii?Q?6ahXwzeqJWeODVDan+MQdW/6uWMH2Jh0F+abP7/VcYKgJ37ei7Tfsv7+q3Zr?=
 =?us-ascii?Q?GZAC2nRGDcsQ4/bLogoxcCByZwghIdwITzPfxtX5yydLi5NurA8chlHreus8?=
 =?us-ascii?Q?i60d5+AWaOaZRYD0nZ9w9BjIeFhPnBvwpXbBZUuNKFo3w9EXbcurt8yu/b+c?=
 =?us-ascii?Q?5OgYiN0dSDLaFtpT6NkyLWypkWso0XCz+J0HNY86S/KCUqCjAo1g8TdLoAe0?=
 =?us-ascii?Q?pw8Uyt1F4lcBPmub304qPxG2laAfCO3LFtPjs/Y80dVaailJMHpxV9xcWREe?=
 =?us-ascii?Q?a8Z6Whk20E5RV7g/ZRA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b005a15-4833-4ae3-ce39-08dd5d993342
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 16:57:52.9411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ++sT6pTM3574GPwY1frLOjLZVJwZb7k4X7VPXPEiwMqBHaDgCKHwscYAVZfqn/zw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6546

On Fri, Mar 07, 2025 at 05:09:17PM +0100, Danilo Krummrich wrote:
> On Fri, Mar 07, 2025 at 08:48:09AM -0400, Jason Gunthorpe wrote:
> > On Fri, Mar 07, 2025 at 09:50:07AM +0100, Danilo Krummrich wrote:
> > > > The actual critical region extends into the HW itself, it is not
> > > > simple to model this with a pure SW construct of bracketing some
> > > > allocation. You need to bracket the *entire lifecycle* of the
> > > > dma_addr_t that has been returned and passed into HW, until the
> > > > dma_addr_t is removed from HW.
> > > 
> > > Devres callbacks run after remove(). It's the drivers job to stop operating the
> > > device latest in remove(). Which means that the design is correct.
> > 
> > It could be the drivers job to unmap the dma as well if you take that
> > logic.
> 
> I really don't understand what you want: *You* brought up that the
> CoherentAllocation is not allowed to out-live driver unbind.

Really? I don't want you to use revoke to solve these problems when
the kernel design pattern is fence.

I thought that was clear.

> > You still didn't answer the question, what is the critical region of
> > the DevRes for a dma_alloc_coherent() actually going to protect?
> 
> Devres, just like in C, ensures that an object can't out-live driver unbind. The
> RCU read side critical section is to revoke access to the then invalid pointer
> of the object.
> 
> C leaves you with an invalid pointer, whereas Rust revokes the access to the
> invalid pointer for safety reasons. The pointer is never written to, except for
> on driver unbind, hence RCU.
> 
> We discussed all this in other threads already.

Why are you explaining very simple concepts as though I do not
understand how RCU or devm works?

I asked you what you intend to protect with the critical region.

I belive you intend to wrapper every memcpy/etc of the allocated
coherent memory with a RCU critical section, correct?

Meaning something like:

  mem.ptr = dma_alloc_coherent(&handle)
  make_hw_do_dma(handle)

  start RCU critical section on mem:
      copy_to_user(mem.ptr) // Sleeps! Can't do it!
  dma_free_coherent(mem, handle)

Right?

Further, if the critical section ever fails to obtain mem.ptr the
above code is *BUGGY* because it has left a HW DMA running, UAF'd the
now free'd buffer *and the driver author cannot fix it*.

This is an API design that is impossible for a driver author to use
correctly.

Even worse it actively discourages the driver author from thinking
about the lifetime issues at work here because it has this magical
critical section that advertised to provide safety, but actually has a
great big hole in it that the driver author has to understand and
mitigate.

I don't care one bit if the HW UAF issue is in scope or out for Rust -
I *EXPECT* driver authors to prevent it regardless.

> It should prevent all safety related bug, but the one above is impossible to
> solve, so we have to live with it. 

You have to live with it, but you should not *ignore* it and should
try to make the problem visible to the driver author and provide
assistance to implement the correct design patterns that do address
it.

Revoke is doing the opposite in my opinion.

In any event, I have to leave the keyboard for some travel, so this
will probably be my last posting on this topic.

Regards,
Jason
