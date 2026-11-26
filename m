Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.55
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795705309;
	b=z5BmBA6OIEyXi+TiplfCDOz5nOI6twQbMVyhlBGGzVzhrfK3+T8Wv3DlMH36r11sWrvH
	 dG5jbLqE6BaVJA4VZQo2I2EXjnvB4l64zttv8WFMmHisw3MbMU+nWO/xfp7lqHswk2VWJ
	 Wv7+qXarnOtLvCoYVehMsr7josIjIoyDWs/I/OvfQwDyqBoB/qvC0Vh1Qhm7hwN3mTRak
	 WxIEmsppl6aYxoDga8x9KIAyTZxp1daztyB3ierJYFEZmHZzHlx3TX85y5aw8rNDG2yHl
	 tk/tWwLP/7yZeAQ/ZdZFF93D05kQbknmCBcUuyZDhg28j5xqWcibmpu1dsBuBGUHthA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795705309;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=zF1rh4d1avWAvpXeyhGdSvsSDDGN1c/DM37uIgG0fcs=;
	b=BxbGPhvNKG8VpsL7q7z2D8TmHgiw1LoNeDaHDwYYpahkZyzKZviiomyPEnypXKnjWTAI
	 jL2mtkSvRF3OMyo2+Z+GLKA/bHdJ3AzSO6aVrRpqBRd1I/GeWksvqj650O6hApZ48SU1R
	 XhEzGu5e2hfkYEgJkpAXj/3YFxefpYhvUgR+1IdvV0qXXe3hwZoY05rCkkzuMeTC1ME7R
	 MxIQR0gFNpUaDusr6IzIUmVLq3FtwZTtzgu14jW1CfO7gOfgWCVQVEPDgFjNagT36KrYW
	 Ov02j3z5VP/z4q9bj7x5M17uXSodKa2hMBa+oXfDIaXMWrZZAt3EqwZgNoMl1mf9ojw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=MKWRS15u;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.55
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010055.outbound.protection.outlook.com [40.93.198.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A2F606A334;
	Thu, 26 Nov 2026 15:01:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16A2F606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=MKWRS15u
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sdOgS8Z2bVoBBhit0hiamm+9EY8/LQhDxhO0HUUum+j50RiKP03gIPGeXFV4eSXbEm/7/gjJBx/3MZsBEMz0jpUU6J1XDsogslFk5F/AXmLm5NC74KjIcg9rfjUZGubxIZ4CfRO/vSaATtuftT7A5GvkXTm2PJqzzhpdw3AOXuduLwbqFTH//0/RLz+4g2xtJpCsnCJCZUyYwSWK75c/J26TGvGjB6wNEKI+oOYch2tmS4OjjgNbzbxOWRyyJV/fKqUk6ZXd2eLkW6Gn7OA7rtfjFGjygd8mZ7NGBgLAMtimaL4iPpSVGIm3bunXyiUsoYJxdsda9o8Y+hxSQokDng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zF1rh4d1avWAvpXeyhGdSvsSDDGN1c/DM37uIgG0fcs=;
 b=ESPa+4VWV9ybPaC3vMSfA5hTDRauBxOhm/zj82EgFqmk5f9nXPDJw5arbOA72KfTn0GywpYES1T4dqUOhzqA+NxQ+UZy/0eSf9o4+895UBxenobvt7k+Hi8JU5+HwruUuBe1o0QOD4Us3zrcYbuwj7y9Aj8bfmAGCZ0C+i2RUJtMLoQXOGj4UYxSGBq9OqxMCkUPq8f2nhljy/yOlex32SOQuhrEIzJ0mnBiG8rfmVf6AyD0/7iX9PCnkyYpJBC839m55mn5rG9GDGPmS/Um4q4RlvhlRTpwFP45sLleDrCLdP8AFaKB1n3DtCdxyL8fWCuSIz9XNfK7YB/P+dms3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zF1rh4d1avWAvpXeyhGdSvsSDDGN1c/DM37uIgG0fcs=;
 b=MKWRS15u4N7Qv7QUNzQwoTaUXMSNcBYAQOphTr9m7Rtlmx1tzG9TZJDSdmfTQpztWHKEMtaKNDl5a8o9f3m8z8TadFVzhwMSqW3xwmt12QFyQTxacywjN4ui0eIxgWN5UBySrXdNJV4O06xftvWwVT2/XStCiq4Mp+MipdcnBQV4ckA57rSGlqqov2xt1+ERtTkcOQOpl0UbUqFs7+dS/wUo0lcWP0A6ucskv6LlXJdXOUNrVblVvm44ZJz2ihcaDu44WeYZlGOshvvAyVNUWKe6YSXQfHYj4cG8vwwswWRM+Kr5H9x2RBo4gau9zVQKDK7Csviw4qHtmHvTUNAXFA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by CH3PR12MB937665.namprd12.prod.outlook.com
 (2603:10b6:610:39f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 15:01:44 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:01:44 +0000
Date: Thu, 26 Nov 2026 11:01:43 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: joro@8bytes.org, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, rafael@kernel.org,
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pranjal Shrivastava <praan@google.com>,
	Mostafa Saleh <smostafa@google.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, driver-core@lists.linux.dev,
	Sonang Patel <sonangp@nvidia.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH v3 6/7] iommu: Park TDISP T=0 devices in the blocking
 domain
Message-ID: <20261126150143.GI114472@nvidia.com>
References: <cover.1794343501.git.nicolinc@nvidia.com>
 <6620f49a3bb96837034aba24b5131a9d8c7eec8c.1794343501.git.nicolinc@nvidia.com>
 <179563006502.253973.16635562157369118727.b4-review@b4>
 <awfP/IZxaVA7ET0o@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awfP/IZxaVA7ET0o@nvidia.com>
X-ClientProxiedBy: YT4PR01CA0407.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::21) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|CH3PR12MB937665:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d59d82b-31cb-4a18-ae26-08df4bce2f55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|56012099006|10067099003|11063799006|261022105027099003|261026140227099003|261026121527099003|261028144727099003|261021135927099003|261009223027099003|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	7dBl6sTtcfejSpMBOyKQPD21wy8+FwLT8LOLVHh2C0QXdBtKe6ouRcaoUq1mS/hHEOsXO67VXuR1dFBJcfptCjbqVeU5y1KWT0SMrUN6vRA5LKzcSZPAo0RzGKQ1RIbstELz0vPTqI1tjib1EVvhNo7Bpm/vlf6Oz+cXlaLJrXbHWdgBYN3mwGGqYquOCgZ+Eg51yT0sT4BRJteTFwxvH0D46+GahieNvFSCtK8I8sOlO6yrStwO4D3ZWKQJHDAagx6k2zfFhe8FquJvZeYf4U/CCYSS2XHdb+UtwYbDfC7lsACnHGkZA2Rdc11+rDa8Attb+rIPmEuDDye05snfWcZLXEX/PORrmoqXNph3efgpLOVHM9mwYeGiTlOSoGfVRR2lCML9cxdMUy1EUHaYDqxpZK8+laS1OHCku1OKkcNUFUtpDMk+P0dWoVsoIof7NAYF3FqB5p1qPk6YKZWlxb3xrtLTB/qsGdobAfSMlrQnk8Fb0mEyfMlMJZV5DxEyXDtrqUBqz53ET/vRYoeASXd5QN51hx6cJGAgLIWC2E983VAbmy6YBrnC3BS6J48in9T0/OnK8mf03W5hH56wqcLRirA9kJkaCFoUsZaI01q0YGOyJl81qHxCk+2rleVBMrsyOaaSce2A2asfro4dC2Wyjx1PA6plIlCsHcG7dCQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(56012099006)(10067099003)(11063799006)(261022105027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021135927099003)(261009223027099003)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tddHllNb6/Sm6wk4lHcPKfK/2bTCvh+6fFGQNUYEiHy4GH2arzELgHjVVn75?=
 =?us-ascii?Q?cyTRt7UmbnbyKKcCJ0ARAXogTvnx93xB/3DGw8stwvKSUEC8vcFIaf9++Mrn?=
 =?us-ascii?Q?3aO8EXJBDRl7bWMSUgqO7gNx+Nnihot/2YIvyXFmmqfTSGkB/+zqbxk2Knl6?=
 =?us-ascii?Q?DDgVTgZJ9qDC318X18t4rsS69AhY3hp9369q6RzH2Qbeyv6j8Zcsw1k3Ulgk?=
 =?us-ascii?Q?rE1uWDrySHuNL8QVvk01cY3X5n6Rn9ZByqbC7ZrQfl0Pz238OrushlscP7bU?=
 =?us-ascii?Q?mL2TH6tOfqsOhUsGTmOTzM7BZmSKBl95GG7VNqxVGJXePcXSpe6lyf8YVbLC?=
 =?us-ascii?Q?A60C0MqZmZP8TO07NCa9HcGo8dVFddbTGHXiAQmkFo58NUFgp8bTRbqWFTzD?=
 =?us-ascii?Q?QnaNPGvlqWiEJCb74zbeXm6OqFjZTWh4phwPNZf6JkCV+JvefF6pr4X5sNqF?=
 =?us-ascii?Q?4aoLTX+Y5bxswU8415zozy2H4hwKug7nc2QaQmIo9/7LfzSoTagfhNepLDai?=
 =?us-ascii?Q?rAlW3hc1PVZl+j3CKkbjOUaLJIbaJkaY3aGf3RUBoEz7nc+8wwEWIRyUhSNp?=
 =?us-ascii?Q?+2rCz5fJWj4MHTIkPsbM2v1kT/01cuPmEDMu34twNZH3gX00nvsMfTyQIKEY?=
 =?us-ascii?Q?0eS3J2e3u8osQ/Ivg29m674pc2sVGC1qd4N+l1Zq0ml8N9toE0zLyhNXh9A+?=
 =?us-ascii?Q?HGWlEm9ebeMUOC++7BaJNfggn/q2nrRmb5hr1musPVfxKhs9gDRVaGsQeqhk?=
 =?us-ascii?Q?aaAgaiduj8qucF6smpO8mbay+kk6R8y7DglzZR879vXyRZiKMpp8i9YiyDcm?=
 =?us-ascii?Q?TIWKjolBDlRPvCOM++wwTVKtTV8ylTz5WjbRVIN9YnMhr8WqC9aOGunYSZQw?=
 =?us-ascii?Q?X7yH3eIhIHgF9HSsDFszL8emmJmcdwm7cxQaH3u8iUMR5RfC0beXjwt7tr3P?=
 =?us-ascii?Q?IqOXe1vimG1ugrsnwVLZn1JJrswXuyoG7utWBj/qqpiSuB3SRXy1EW64T3MW?=
 =?us-ascii?Q?YydqNXniEho+nRsvrptP4pVp07Ym7rCtQdVZBdgqmfN4KALa9p8n6r63TPCx?=
 =?us-ascii?Q?+p40ycxrilgZM4AztGr4Hz066TNYcGWo3HlKUiIF1WobYPYdVsS6QIyjAn0a?=
 =?us-ascii?Q?G1VXpurlDg3Fhn30MADEMBo6hbxf01JjLtkYLOCScNzQ0xTlTPIL8ao60rsq?=
 =?us-ascii?Q?ANM2DzdhfxZT86UcdRK5XOslRdBqJFk7c9N+STuI+SYkZfvR6nGxV9sXBhTl?=
 =?us-ascii?Q?qxxhvxqbw5i7crc/bfM/wnpxTDEV/lB0B1ip5y4ceE2CkbiIvOvfWS8sqQiD?=
 =?us-ascii?Q?aylgkDTPMucg4QncwrLVsREGszAGB8B9qF/N4z6ZX3VsKaoKFmGsipXGmyjg?=
 =?us-ascii?Q?3+TI62j6vkGqn6dwwPaCrBwig/itQ6pAnh0PpspNC5D4xY7q6sVJPYR2g9uU?=
 =?us-ascii?Q?MrDo6UB4pB3GfaFrHiAmMU138xijTYUx3FCSuEbLff7FnNXNSFw7OrM8ZTwj?=
 =?us-ascii?Q?6LOctqpilfVelT4UezCZBNI+jz5N+VNir1SoHkuwVP8JgV1dJNRKZ/q94B9e?=
 =?us-ascii?Q?BsrLp5R4FokWlmjRGWracxcrGtnXSx1sEwIvbrn4SuA/xXtZCC1Q7kgTE8RQ?=
 =?us-ascii?Q?AKEDl4qmVeezdOW4CmUlgIg+p+MoYA5L2jCHqwWD3Ii4Xa5OXm/mQc0S38LM?=
 =?us-ascii?Q?zoZEcA5je+OMBk0qBIyl7UJmIzwwAjQ4aYh7ZokYOe11r1Sr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d59d82b-31cb-4a18-ae26-08df4bce2f55
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:01:44.0745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 83s5HH6aRnZLjmRq3ZjCN5hjnsUeEWLHbP1nsUk/7Byz20RIphALV5lm7+GxVNG/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB937665

On Wed, Nov 25, 2026 at 10:21:48PM -0800, Nicolin Chen wrote:
> On Wed, Nov 25, 2026 at 02:07:45PM -0400, Jason Gunthorpe wrote:
> > > [ ... 28 lines skipped ... ]
> > > @@ -1238,6 +1238,14 @@ static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
> > >  	unsigned long pg_size;
> > >  	int ret = 0;
> > >  
> > > +	/*
> > > +	 * The direct-map reserved regions are still fine because the T=0 stream
> > > +	 * always goes to an identity mapping. Skip them: recording the request
> > > +	 * would only refuse the device its blocking domain.
> > > +	 */
> > > +	if (iommu_using_t0_stream(dev))
> > > +		return 0;
> > > +
> > 
> > Not sure about this. If we are allocating a paging domain then it
> > should always have the direct mappings setup in it.
> 
> Hmm, is there a paging domain for t0? I thought it's always on the
> blocked domain..
> 
> Even if there is one, t0 would ignore those mappings, since it goes
> through the underlying hypervisor path, right?

Right, but this function is part of allocating a paging domain, the
above argument is we don't use the paging domain in t0. So if we are
going to allocate one it is for t1 and that means it should have this
stuff in it. So why have this test here?

> > I think this patch is the right idea, but it should probably be
> > removed from this series for now if we don't need it to make a basic
> > trusted vIOMMU work.
> 
> Without it, every device sets dev->iommu->require_direct for RMR:
> 
> 		if (entry->type == IOMMU_RESV_DIRECT)
> 			dev->iommu->require_direct = 1;
> 
> Then, __iommu_device_set_domain() would fail the first test:
> 
> 	if (dev->iommu->require_direct &&
> 	    (new_domain->type == IOMMU_DOMAIN_BLOCKED ||
> 	     new_domain == group->blocking_domain)) {
> 		dev_warn(dev,
> 			 "Firmware has requested this device have a 1:1 IOMMU mapping, rejecting configuring the device without a 1:1 mapping. Contact your platform vendor.\n");
> 		return -EINVAL;
> 	}

This should be covered with another test if the viommu is bypassed,
not by messing with require_direct..

Jason
