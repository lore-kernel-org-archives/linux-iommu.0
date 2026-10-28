Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793192370;
	b=m5ySAqwrZB0RAFP3nwZzBv85auPNuGkOAjsE+IPFRNLH3E7B+xBhl20NojNNozMmj14H
	 kwQ/UUZggLDSGEsiMYHHGPdwsoChjBEGZ1zM/VFtLYwxjpB6WrP6jHWdOkgU90Ljh1Ujj
	 XmN7pB2U5juBhZ1V30so1tbddIENqs5zoNNH3V6EpM5Xsh++sCouDKsXpyNvhNCrK5riN
	 K5Js9gPsltOw7lZCWmpNP6jJHwRq8ECAbN5Z6RQHDxONYfZUeGqPKsFxKH4ILOvTXYRpg
	 O15uxAbJ/QwXFOuoBj1EACFhxk+ghx9KCKYkmO3zqMnoVGqhIeq61/pYmzyxuPitNfg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793192370;
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
	bh=/DYdoj1zKL4rwO2KREFbt2DYXMr4kfMjdDmj8SehfRU=;
	b=WsZDvOjsOO3io1+pCWA11JPo4HIVispTgzYDaGDhpgWvMtrJToqyODlqeyvxEztczKGI
	 N1JBPC7tQyKm32/wOPdBNENaWNaJCsEaqTO+ZyVZ+/cjb7jHTmWHUOMy/NLpJbgZEeaWM
	 Be83g+urgvx+75bqW0fl0Yc12OiL7DiUcYANRZNA9A97KBfyLLc8HRoSvjsNGn3Rss1Im
	 bDGSj8ntHrpD2ShNduGQf4MLvRxam4ossg2IXN1Cdo9r6f/szXn8xxpksyffE19wRlA6L
	 Ng1MIiH5iMGhVzhTAg0zGHBoenYjSreZYOCLOWKZwAEMJo1QHtiav9wmQ6UiTscuwyQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ATOHtvyd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.31
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011031.outbound.protection.outlook.com [40.107.208.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A409D606A32C
	for <iommu@lists.linux.dev>; Wed, 28 Oct 2026 12:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A409D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ATOHtvyd
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f4T2LjorJnXGJLwPVLp1DHGRVTrmNRqDGnCt2oOMUgtPfYBKKIY7KhNbiU8T7VvBBXim+eOsMmQDNDJPhAt2JauUNcECoaaoIn53lFx5iMvps83PyTnI3Gn/mlD2Vjbr5Ugi2/TLbuFRnmN2hot5f8b55EqyWzpkaGdWSTwY8Q06RmxgVZD+mHLh3wxDVnh6zOAbj55yfzO4gaAbkTfvErcmtGhdmxM2Yqn1ZLq8cm5mubqHdQH+8TVFahFrr29Sp7DMAFuUM9AO6G3QQWKvD0L6WXvOOUECOqA7RacZ167gNDU/ilVAhFdS6pUuFvULlA7R4toEkfVMbhpQLDlQTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DYdoj1zKL4rwO2KREFbt2DYXMr4kfMjdDmj8SehfRU=;
 b=o9HpgwWSvPU9YPjeWVyIkmLI2ZXk3wQ9zrz21euh2pocNa70aF7qG82dvnq79sn1O9lvk3ofBh/VfUb4XSQRI2g6mMIuxvUsk/JXhiIzsiMULKADVzp0JKqkeRYDe2UCVHLuLEYMP1Xp8NHBsxYHCc9byYdBrOMBOla0x+qE1BFhono89TkHt2w0jZj4LsGmO02VqsmrLkxC7e4JtmPI/G16gj3TBrJvLtDQDQNWPI+UH+YPcNn9ypJspCKiZI9wDqv3y1zl3hE4D+a96WTQmTbgTmrpSbbGcDX9Nr4PvnTRGCgr0qH1cpNT4liYggOtbhzRHV5ouLkLZKgLQiYjvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DYdoj1zKL4rwO2KREFbt2DYXMr4kfMjdDmj8SehfRU=;
 b=ATOHtvydFasO3ggW25UxL8hUu4/g7eZtcYdWfyfa3YsQKNeS77ALQ7Kplyk3dYlW2sf4GnQ3Im5TvfUjTKedmhr3J8gHD761MQMmGsOsjhcrsKofCCR4/WAT6L9zgL6p8pmRW2qvHawCKiuIVtk+uLEyscSYDIdDNOLnMppoIS0Z51A2qvExkqGoKFL1795Vsq2NG6izkt72Y6BNmCPjDJwrALIQw6CNwELvBs/Y4HPEI73YDSuX3VnCgCsNc+DeW8YCIKat9ezcmAf4QRgjAi3YneyxbiSSIDhUN0Bdnasr2f+EJUwvEYKA/aMeqqTpSk/fF3F+SwZ0KQXj5qQq3Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by SN7PR12MB7835.namprd12.prod.outlook.com
 (2603:10b6:806:328::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 12:59:11 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 12:59:11 +0000
Date: Wed, 28 Oct 2026 09:59:10 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: fangyu.yu@linux.alibaba.com
Cc: Ankit.Soni@amd.com, guoren@kernel.org, iommu@lists.linux.dev,
	joerg.roedel@amd.com, joro@8bytes.org, kevin.tian@intel.com,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	vasant.hegde@amd.com, will@kernel.org
Subject: Re: [PATCH] iommupt/kunit: Read an exact NR_SECONDARY_PAGETABLE
 snapshot for the leak check
Message-ID: <20261028125910.GB3040767@nvidia.com>
References: <20261016152343.GH13920@nvidia.com>
 <20261019032455.36913-1-fangyu.yu@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019032455.36913-1-fangyu.yu@linux.alibaba.com>
X-ClientProxiedBy: YT1PR01CA0141.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::20) To CHBPR12MB731189.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|SN7PR12MB7835:EE_
X-MS-Office365-Filtering-Correlation-Id: f3efa58a-4ff9-4372-c546-08df34f342d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|7416014|366016|261026140227099003|4143699003|11063799006|56012099006|10067099003|261022105027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	lHeoLftJDCM35lWt7RKvJ8o4JYOWcvJ5a7lcuybKjPZgzQu+ua6vnjh2JE3LjJVOl7KNMzxUjn/8x6D8HkMVsC1NsUX1YOm68/vUxgvr80obZ1MDdkRJ6K2Y4ubCpKtPAYbDH/jSauQdusP5MljRXgC+oIMur6ZlDlD9rqPQ1qU4mliX4lu1ukTrUwUT/uktBOvwb6nx+kmEwhy8PyQUDg521z61ZSLY+s1YnNmcxut9nbShdMnwxtC8xNk2jvqNCXlpa8lMfQzsew6Fqaz9bpiVA/Fquqefg3ZxJ0FAoOncG+vHaKqyrfnmtd4e4IosSH+Lg8CJodQeppGY8jArhsZZ3sm+0JXKJ9EHAOmpt5PtUmR2dldy7TXoiZHHnX7aGsnb1F4uCU6thQT03aaq4MdxMPwnyhX2nxMaajVktMnSYheaz9bsh0OdOU5S2VnNK3hD6IyurP4Zpwc9g4BWhkG3ZoMxv9iT0nq5ssvMbZC9orU5GOC3gsTtTlERg27LV6FXGzAyfn8wsrRCG2bY1zjDadG8nQmTJIWSjKstJUXvT5BfYgABZ/lojYUSn/19bJX/h4heVJHvQl9AfEut5hapnb1dHMcBIU0arXDf7TIfVaWU57CtwvjsbmM1113mhlknydnaOEFQTR6EJwIZVcMYKv4o72TXwqH8I4jb2k0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(7416014)(366016)(261026140227099003)(4143699003)(11063799006)(56012099006)(10067099003)(261022105027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lHNmD6Tlm2yVitp15eROTFlr9IKL2bjZSszyo2k5J9qXnuZTSoR0EuLTe61g?=
 =?us-ascii?Q?bqfLuwpYFgRu/voWHREH2CDH+mI9bi6kdZp82stUfhf9ucQ44mrH2pqG1zF7?=
 =?us-ascii?Q?CkRtzGaA//f8GlFrtUbCzufm5noTd0SwIDO+p7Nq64MkLWK84CcOyJHhSg3j?=
 =?us-ascii?Q?9ojstkafKlLtAZkNu8kkCfHACxwZmhaNrmu37J+mhfXaJNiwvwccUJ7LXE3X?=
 =?us-ascii?Q?4nAR8vC5MYgjDqyoVHEx41un3Jbz1dXHz12LkST/miYqdSPEYfHLMDF83R/0?=
 =?us-ascii?Q?LKzD49n8Y0U/xjIShHDz0h0WpJG6KKiLN56/oQUzgObB8B/aOmbhMoYlfQ3x?=
 =?us-ascii?Q?tdrJfzEBBT+g/vdkZLmo8SqZsrJS5aROwkNtaUPQFVUcDFeykiAD0PeJq1yx?=
 =?us-ascii?Q?q3fTU1Br0jDhn8+TzCQsKwyn7bwcDxraqgewExEv8ZrkyLnN9wj0kvoBz22C?=
 =?us-ascii?Q?sH+V5Pzb/pRHb4GX76+o0etADteDWSxR98AYxc9qaLh/zOTILScu8RinoNbu?=
 =?us-ascii?Q?hP7OQbfMldXxzNLi8A4FYVk7pgOfURCLBhF89quyun5t8O/SaTNvzypAm4qm?=
 =?us-ascii?Q?wwvL+KXFxXqZc4DL8YEghXOQeSFSgPubJcebI/BiD7769UQ9s/TyDOBcjRTm?=
 =?us-ascii?Q?SpZDbAEM06C2Nr43Zcgeg93QnlzkfHdN89eDm8i7LaqYq9RTRCA6F99mYOgm?=
 =?us-ascii?Q?Or5/RuJTV41Nf16rHr6SFFm51RYlkHMKqlrLOr3sQax3dbtPqDCYGhL+RUel?=
 =?us-ascii?Q?CyvafIAsmcbuFgm7mXKa05qEI0Re6h7NSaq0/H5isBr4IkZ8D6zcjCSOf6HK?=
 =?us-ascii?Q?ALy8vdEChB2oZB3m6ehZlq3yRFUyUi8yackDF8+n/r6b27Dwdn7dv26XR2H+?=
 =?us-ascii?Q?5A8w8j7JENpwvjBqC3xu2pwthQ/5dcETVdyarsXE+10wNK1kSy/CeeId4vFi?=
 =?us-ascii?Q?iqWtbj/R3/IzxsulO/2ndwOgIV2IVrKysYlvSIDf1BIJozoruDJpiGekZ63v?=
 =?us-ascii?Q?HahyB+PIb6wsx27KlUswFrH5n8Y4jqpumA0sramq48S7ZABlwXoQKYo7AJ4o?=
 =?us-ascii?Q?5zsrO3mYr0I7WQIZLYgIweCTQ/MDvOxlfK/DG3GpxY2+phWbUiMLfpWhQvn2?=
 =?us-ascii?Q?yFLFB4IpJeKzOTkEFCULhs2tPzyfq3n6icDbGleJBNsgdvm5Y1diGErIi/rw?=
 =?us-ascii?Q?YvntdykbqMFkQQ4mMF8pIINEMuW2hmzjScoJVKoaj+y+JkXrmAc55+nvlA4n?=
 =?us-ascii?Q?1k7DUdZeuOLmUsz8ZfHx1c6qePvWS3EuRUow+N4mLRysD/IhSCS2oOd3aNoW?=
 =?us-ascii?Q?1Sgl7l96zPutjOQovwWHRYlbMYP4kMPME5/nEcuusS0EN5vNHadS80SnNfab?=
 =?us-ascii?Q?ydF3JAqB3sTa0/GeQGX7RH1/uRR9mvxGrIkH4h0/4gyzvkLBnSWtCB31coVE?=
 =?us-ascii?Q?CjZ1qtsphNtH6xyaqoMX9bELugt9I2ibvC5/tb+t1DOVSFE/FkfD1Upj1D21?=
 =?us-ascii?Q?9NK4e+GD2segkIOzXcLaY+Rn/owKAB0V9kkaePbOKQAdCWtxrkSEIO6SFzbr?=
 =?us-ascii?Q?4MhX3YUuoqzR1NhZDHTsJcq7R4fxQZ6R6WDdHMMFuQi/nnF4ow3UDw18Z0R7?=
 =?us-ascii?Q?MNFplPMtbbjjNjaiJnsW/DlFKsmZZXqYjuDH+EhPVUhZhwFj0yplTv9+sETR?=
 =?us-ascii?Q?fG5sYgElGWJIKndgirZluCxiNTKRuS3U16JZj6A7+tESZ7px?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3efa58a-4ff9-4372-c546-08df34f342d2
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 12:59:11.3698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qH1J+UQpaW71dWVFEPpq+b0OavIBDYOW+dt9sVPZEYtaalfQFWQrgY2QvQeI8QuR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7835

On Mon, Oct 19, 2026 at 11:24:55AM +0800, fangyu.yu@linux.alibaba.com wrote:

> The run fails consistently. In the example above, 14 of 21 tests
> failed. With the proposed fix, the same command passes with 18
> passed and 3 skipped.
> 
> 3) Could you clarify what you meant by "disabling the check on !SMP"?

Just 

if (!IS_ENABLED(CONFIG_SMP))

With a comment explaining it

Jason
