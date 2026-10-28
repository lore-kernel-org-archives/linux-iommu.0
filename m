Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793191103;
	b=2tYs5zoZ9n9ibtF1wh25Txa4yFk9KCtvHDnfGT0XnGLFdX5BXGB6cTXA87NVjClLrCyZ
	 Y5grHA0iRTaW7+7KqLo4Ej0pMJevHpsmprGhNbG78AZXFKetvc4ghy2SDtHwzyb6sDchh
	 +DXb8lfcdcrBVJhWeJIKvrgv4sCaYmsLXJfdZpOKzVETA2unmnFYK0XcXpgPM6dlLbqww
	 3c/bhhv6y7jygvkil52ivNNw71vrAR4kL/ZlsgSjx6OYjGWdS+v1/zJvdPDvpoRPp0Vtl
	 3Rr2hAMo1HGRp7mOrWzt9M2FLK8NP6lGrGuRtW7yL6W8WMMndynQglWIVr1GEF9SJoQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793191103;
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
	bh=ehhlelUPDHGtOdSr3XJcikPbPNF0v5/FL0VaBPadzf0=;
	b=SHvRHKmv1fZm6YA5yxVn/HCbi/WzfARyaymbD9bj4JIhp3u4PgDjFNdCHDaSbwpcu/0E
	 soZYhEvpVtbRo1H1OP2xpjir8SGphN22urtl4qlW6bR6HYa8L0V2nYv7hDzBw828UCy7g
	 JhKdztcM824Da7QGk/oaeSRnacDfxfg/kLgZRLeZqHK1mA4Ara9dvJJHNvi1wCpyiLJ6u
	 HdJiwyWxWHhZQQOIziqm1zza96RZPNZ41XujR65Mjbmevv9un4WzrXD2eY9Bva5RvYm8W
	 xPcyFVcFZ5EPg0zzrcSYRxL/m7kt8WNAS6GCiIpvAR5Ji3cVa8PxxCbgQEc/uJdNroQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=rsn6BR4O;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.29
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010029.outbound.protection.outlook.com [40.93.198.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779AB606A31A;
	Wed, 28 Oct 2026 12:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 779AB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=rsn6BR4O
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O4pagCpG+a+CIPiKgCP/E5MNXFQgcSq/W+LSPFfWYCce74OV5FBJxXT9doi7oqfqbMqA0YYCJcakmXNC4ItQGfK1aCGgIaGhYVakeG1CV9VMZ9O/4HBbrhbV0+HDpVLBW5pcBTq5afrXAFDkfYm8Q+ql+5aAHJfqX3lK0C9AsCoyifglNo1K/EXGG6VAedNektxJJ79CG4FH7IKisw1FA7ey6XJHHHh+nPWFzlGqLk9usWwRhzxu4zmiIHn2cTH6Xid+n2XJm/IFlVe2UJrXcvV8DJRLT+lMeepDNwnauK4N+YzUP3vSGO7dVBgBVBK2VQevpzJ/GTEG8dUBEDZGrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehhlelUPDHGtOdSr3XJcikPbPNF0v5/FL0VaBPadzf0=;
 b=xRcC9Fmf5roxGVDZpLdrpH1jW3a209wbKf1QddeEgZWxX8cgM8JW/VNI4rXJq2OvdFm9DqEeO3emVzuCElSdIROrV68nXBRm/XnAgfrkeawAaoyGLJk1qyDpLJ7t8FeiTJNztFlsWu308D+dMMHkoRs1UxvoTL29PgzVr75YeiSuHABn0z5kuX/MKGa26aFh2ecsqLdT9AcxGt8HNQaKsY5lFSXiHC1d7IKOxKDZ/Iq/PB54cEErCp8srTWLpgH5K02+epEzTjqqRBmdvjwGBJj1IPZ+CfdvA+uEju7ov9/HxDhJHVurSHCL06/Cw18+JUrAQW+392RzAKKvXBbrsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehhlelUPDHGtOdSr3XJcikPbPNF0v5/FL0VaBPadzf0=;
 b=rsn6BR4O8fg6OQwkZzX2+vrWpdrdv5CsLdHQeGIvDdPACtbtvhzgAwgF0a9UKTQL3mTQq7E7MkBHrPr4NAk/aXcD+DZWQbw1kebQJwbb5LoLGFRACF2NNyOELMZBSyzDcfvpw8OPJKnpAglAuov/Df3p9KZrjqx6FOGPxdl30muQcUlNJ/rAoGVvxjrFu78Wy4GZBO2SEw1WUHmX9f1spxfi2PTIIz50IGpRad+xYscPH5oEy8RJuuZ8CRvFnVud7R4NL6ZywQS0FjQ6GNbq4YgaFMpyCDkh7I95n8T4vL/OGLncpE5ooamfWzgosorf3azFVT6ZopjIYfbLOL1EXQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by SA1PR12MB7296.namprd12.prod.outlook.com
 (2603:10b6:806:2ba::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 12:38:13 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 12:38:13 +0000
Date: Wed, 28 Oct 2026 09:38:12 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, "joro@8bytes.org" <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Gavin Shan <gshan@redhat.com>, Vikram Sethi <vsethi@nvidia.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	Mostafa Saleh <smostafa@google.com>,
	"rppt@kernel.org" <rppt@kernel.org>, Thomas Huth <thuth@redhat.com>,
	Marc Zyngier <maz@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
	"kas@kernel.org" <kas@kernel.org>,
	Kohei Enju <enju.kohei@fujitsu.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Ard Biesheuvel <ardb@kernel.org>, James Morse <james.morse@arm.com>,
	Steven Price <steven.price@arm.com>,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	Omar Sandoval <osandov@fb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Sam Edwards <cfsworks@gmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Pranjal Shrivastava <praan@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"driver-core@lists.linux.dev" <driver-core@lists.linux.dev>,
	Sonang Patel <sonangp@nvidia.com>,
	Ankit Agrawal <ankita@nvidia.com>
Subject: Re: [PATCH v1 4/8] dma-mapping: Keep DMA memory private for capable
 devices
Message-ID: <20261028123812.GB2541714@nvidia.com>
References: <cover.1789010941.git.nicolinc@nvidia.com>
 <abddd433493324a6bfdf8ba9710e96d90f0d1ccc.1789010941.git.nicolinc@nvidia.com>
 <SJ0PR12MB86145DBCF2ADDF3B85719531AB6F2@SJ0PR12MB8614.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR12MB86145DBCF2ADDF3B85719531AB6F2@SJ0PR12MB8614.namprd12.prod.outlook.com>
X-ClientProxiedBy: BN0PR10CA0009.namprd10.prod.outlook.com
 (2603:10b6:408:143::6) To CHBPR12MB731189.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|SA1PR12MB7296:EE_
X-MS-Office365-Filtering-Correlation-Id: e4adbab3-36ee-4066-d341-08df34f05502
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|11063799006|4143699003|56012099006|261009223027099003|261022105027099003|261026121527099003|261026140227099003|261021121427099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	ClENGOo2WVb5zzsMT4FEA+7sReqVNp6PHfAHAZwvoxEFTu3bXo0VsWZl7JTvUY0C3BJpsjulkFPlK95BHoM+/sOOTb347ySXdzmYNpgkS8rQh7Q/pcU8vAyxnVGdvglJqRpxwmeOy6pC1iQ0+wIbWO0KhWIhUFOOhQCNTQpUq3qNoF3T56OrzDyEc4LsIL0cDQiace9mE3AUANqsXZ9ce9mjL/M5TWXjCqRqEN00+SGajpE7NrDepEfwWnLJMHiNolNzczQdba4I577b9W5s9lTmM/sQykQaqr2PbPXhKCHr2ZEPn33oTp0qf8zbPLMVeQBnyHWjfgMU7Fo7vRUv2OL/P+JsKC3arAVT6h6Zm6FUdFq89m5QK+Zs2hx9iP324V5qtamHTUGgxdCcMGuIfyW4YegeZPxKJzaeM0S1/tWZIlv5V5q+MgoSTgBpU5DuRfhPW/llIQeTE0J5F1Z8fiIOj9xAViEzIL15GZjMDKnoWeUUjZJBQJCJ4SIE8hiVWxqbmlsfpLZNQDMn6qUbo3qTmLfsDaf2Wg2ljlVK8pUFdlPcoqREdu3KjIz7+KHO3R4c7De66SwtL8evcIMoAIM9GGmYHnRoioItTRA6RZL0AMhYWjKmZl8zwmBg2K3Dzgl4GyMbe09o8sQeFQGKrSqWIAmG5qwHjczi6xjRkt8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(11063799006)(4143699003)(56012099006)(261009223027099003)(261022105027099003)(261026121527099003)(261026140227099003)(261021121427099003)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cuRB7G+iSDw5ppLLew/fqbkH904ZL2hTC2V4Dl2YBEfgfoTzOP9cjVP/lT8Y?=
 =?us-ascii?Q?1R8bvtF0N1QwejBBastdTVckPezURx04pxjR04W24+pFq14h4SH1cbF2cxde?=
 =?us-ascii?Q?0F1hrDSiaH76zliBx7H9jNeIc/RsHRZSGCgdJUTfTXfiFQiBDQHqUlWLqbJs?=
 =?us-ascii?Q?GPI36bJOzP3ZHP751ONqDtMfvpzRcan+g0M1eGmUl5GHBYH50AtOVl0xXdrh?=
 =?us-ascii?Q?egWK9xcrL+1zPcLTo0jyh+BiCUH3cNPy8RONkxsTdrtxnCJ3z1XNa007O2QQ?=
 =?us-ascii?Q?5+t9YsarhhsNF3qj0tQk4tHdw2i5kKOJAXfZRdC1aA8gJ7o0f5eYFDudbQqj?=
 =?us-ascii?Q?Tp6Z2eONaQTR9FwyzfYCVaGQ1VpBjVICM4UDuUdQriuQ4pmvbpu5sLYZPlm2?=
 =?us-ascii?Q?7ZnwhhXCPiLQLB/ZfsmwKXmHCsh1vaPB4b1pQ7YGuG0Mi4LSLBJo0WR5lnE0?=
 =?us-ascii?Q?jaXtbIJ0SptxbTFNZezCY3xE8w8yudF8VW7Hm9fPU2NTobz52d+b1gmD9+QY?=
 =?us-ascii?Q?QaFEP7bNLUFH49sI4pwzXnKeqT3IEK9KGMteEv3Y8keks3+wjaroZOoBp7Lf?=
 =?us-ascii?Q?5QyNNFp5fBZBUjMHC3+CPJu79rPoABk94gNSUKIGlT/DOvUBK+wGf4W76LsS?=
 =?us-ascii?Q?C0P++XzarhXcHVEMqJNqt4+Qx5T4XHJ4vSgaE1/HyTaE0cIbWR/T88VyY94p?=
 =?us-ascii?Q?rCE8lTZu7Z6BHg8W7fppDZPgM632RMTR3Y92wDwwm3dY3/VBnEsd2+tSexES?=
 =?us-ascii?Q?i796L3RpuWHeVDFjyWuadsEDQ3BU5r0i5S0XDLxDQLxSb+QihOphgoCjdVm9?=
 =?us-ascii?Q?ifdWcvnGE94wee1UQf35Fi06GCrVVWjffWwC1p1quRzQc2yHnPcyIWDSn3Wg?=
 =?us-ascii?Q?zre/Ilo08PDXoaQlP3Yk/j/1GD8Z+J/S3iODMErnZwGCp+vMBPIfLbhWVudt?=
 =?us-ascii?Q?RRXpnuZZyIYJLv7XcYMN0I5fYrlNaWkpm9zrXsMnSf99KfVvhUfuwbE8afID?=
 =?us-ascii?Q?We1fpi/xnUaO7Tfkxif6IcLhzsxTuCu1CLTLato7ppIv7yopnjZBMybN7Y/N?=
 =?us-ascii?Q?duANkthyWErdvO8nxjc8bolsfrDSO8mS/VWgN8hsZtmWi/qqrQvW+2ygGdR+?=
 =?us-ascii?Q?VR7P9GwShTU+7jK1hFen2qJS3sS+hQaKWzd4N0dZIGEkKsgmX4/8aj+swAFN?=
 =?us-ascii?Q?9Oh55BMIrE5WPWBRn/71rGecyxIvm1yltcG5AAkz5p7OEa3X0NAghWmqIkLZ?=
 =?us-ascii?Q?ergTbW4rud0crpAI5kZVbSpHl/Chi+rM9NiKxdYl35t2zzuFUN2Ny/LmFGkB?=
 =?us-ascii?Q?TG1X+0mVr9FqO0S/OYiHhGpaNH2EQ6/ohxefc/nyqIybOfwLEQfuoiHas521?=
 =?us-ascii?Q?P6m2RN956WVL6M7SIUsf+haMfwTaMC05UGTIonqih7HQZjY2RlburWAEY+T4?=
 =?us-ascii?Q?MoqJax00n/XFqFzT5UQWvbsEfKANPGR5+zyD7GVyRTg/ifNLrCEWxsxZLlAI?=
 =?us-ascii?Q?lk7J/juYWTfjvH9q+JV1LJq2k1R+PIP6tWfxbFWOaqBnCr+v3TjosJ80gqEL?=
 =?us-ascii?Q?yjV/Yg0bnGErtCWijcD81CpSBLQ9N4G9Y9GVr1ZdlnLXIMcRGnL3KhwMdEPZ?=
 =?us-ascii?Q?dSLPeW5pXf6zDI6QNsjqg9pmxMQOC48NNo8YT2ATrDwqbZNAq7GStnn0Wt+K?=
 =?us-ascii?Q?oDIxLCgZAqJsy45JSYuF+9eqTs+Qh7JccRWdBiywDOAmeb3S?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4adbab3-36ee-4066-d341-08df34f05502
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 12:38:13.3956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GBsgkPoulxa5UCAYA0qnOBS/UMnCS0SOw99hrUAUOYj6C3JheKA3ZIy6Pty4h4zb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7296

On Wed, Oct 28, 2026 at 10:42:15AM +0000, Shameer Kolothum Thodi wrote:

> > @@ -1552,7 +1552,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device
> > *dev, phys_addr_t orig_addr,
> >  	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
> > 
> >  		/* swiotlb pool is incorrect for this device */
> > -		if (unlikely(mem->cc_shared !=
> > force_dma_unencrypted(dev)))
> > +		if (unlikely(mem->cc_shared != dma_require_decrypted(dev)))
> 
> Just wondering, what if a device with CC_PRIVATE set has addressing
> limitations and needs a private bounce buffer?  Or is that not a use case
> at all? 

Then it will correctly fail here because it is not implemented. This
protects accidently copying what should have been private data into
shared memory.

If someone ever needs this they will have to implement a swiotlb pool
for private memory along side the shared pool.

But a device that can't reach all of private wont' be able to reach
shared either, so it is basically fully broken, don't do that. The VMM
Should be setting the address layout of the VM so that the devices it
installs 'fit' within their addressing constraints. ie do not create a
VM with a 52 bit address space when your device only supports 48.

Jason
