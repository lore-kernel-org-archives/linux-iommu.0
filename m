Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794932486;
	b=TNg5+sYsPdx4e6k7BwyAFtMFNN0HwEvEB2hCdixu+C4HrHppXKZnXUzkrJx6lCh1AmXy
	 tTMzt8fqYMd69jMHCT3AgchnRKaoz7DGYztiB1m3SuDzb9MXR/29R9+L1F1H3R7MZI/tF
	 cLpNva1ryH6o4XkGSJdDKbMlybQyyJjLnHchBCOsHSqp9rTpO/nhW5/IDj8x6bHd0g6jO
	 B12ijORoxFcteVaev5Qc8tXatHHgmIAkQijFKbMdl2copxI4x4vcnfvfGFSn3AKrpuWWO
	 Wd/akg6IXB857hiu+bS1M97cAhAFjzak6ru3XKGTuXpLtQVMjVrXCC/yxiAKPCFBDww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794932486;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Date:From:To:CC:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-NV-OnPremToCloud:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=BJ2HqAGTJu9w4v2O5g6PU8J8xFhc3iruXNYooPtJp6c=;
	b=2zqsEGN4/wfDs2VjnUlnJbIG4wI1A3/7yRez40alJ/B4PNPQeg7858biZ0HMbSTCyike
	 a+W1OgQP6z7Jkp7v7HsKhaHU6WP9kXUzJFMLx3Fi6xqctHGXtyYy6x+n5QRpIoNpWEEDb
	 RcL2WSWeLJj0252OGO/9ptMlcO5U9CHIhr1zQhi66cy3xWJKOeOtRYJhJzbyo7NF9KMuw
	 ywG+EESZnZZXaGItWXd0SwKklqPWFvqOwYdk+v+97AYD+/eGDwXoZMesf+WsjQqEV5A6n
	 UxZevMteGgaSwXBWXhhqR+vHcSWpcR/jfPCxDbP6RWt9Ut+EYXd8H7rCWHEMrDki5fA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GgA9aues;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.13
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010013.outbound.protection.outlook.com [52.101.193.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05BD606A338
	for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 16:21:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C05BD606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GgA9aues
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UkLjEe1AFNo3e9B/JlgsfMwKnW8JnuSzVSfp2odvvsdGcA5uCTm6SbapElyRSWgRDGgOSGEfFhKkfLZ9SHK0pA5H6sL7sgu+PU5Ti4hDC0mtBmpfenhnufNhqixKsFUNSVm1EVXhxQ7++48bbH7dyfOSBx4B5TQ4Ne102U97DLGGFPShxjomQoaIwvtTAIOcu3L7babFIUe7OMJEO+UryZ+F4acyhmM9e/p2wSrm2Auoz2CODVwwUT+k6Z2berJzrf65/2FyZHcmUHJM/ZC9EWPuo71Dpoe6DNA2ntMV+I2mtgygB10D25Jr4+fv0ejUt/esqX5tQpS58RoApHkV/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJ2HqAGTJu9w4v2O5g6PU8J8xFhc3iruXNYooPtJp6c=;
 b=n1+fivEG3pOPrwVTeJlQk2i7rADJEnUs2mDdin1XccukKVu3hdMOSjHt04cnr6TFjTQa8bdIAE1PQjoqZCmZXkrx7AtmDQli4X6QhZFGpBIoXYMaHZf16oEJaSe2oIz8XtNodcbZf+nfzLPqjAX2lpitHAL9RxC9C7H2SqBztArddRthgeMn9VQdlkvnbItK2lub0tt1OM9cE9mtdJKXIwMN/AqRTDNymK0mfojWkOn+Fc6rCZSoXHcnwWg/6N5QWoIhqYWJaA1ESZjCsCrmlTdaymmkePfNUThdVTICEbfwDj8Q7boiPDLBV25LZ10ZHNnfXJAdJDPk9Z68ntn3LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJ2HqAGTJu9w4v2O5g6PU8J8xFhc3iruXNYooPtJp6c=;
 b=GgA9auesPnU0VhtW3rDjrQ7EGlgSWalJOww1/b3iQ/WWFdztzLl1e6/MGjnmtHHCB6Ucue0aqaX6EpahGNkAd9KzHlMJNJoEdLbMfTK9HmDGsfMQAw1npc/Tj5IdSXrXIEOUSLNBZcqFIujAzCxepwsgcSZKtXbvvve1ALvrCKPvuXCb4Zr20FAx/jO/qvyoHybm6utshn0GSHl5nmYqsuNlTFjElYugDL7uqeh1bqEgZ4YzEnI47fFgE2J8rOnJiaKfWPx8r6ypa0SaCddwhdRi2EDpy4z12vZGzsl8sDKXB5wJelB22NTLUnC33B5R9m57vZYqJ5gMpAMY5ZybSQ==
Received: from CH5P223CA0020.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::9)
 by DS0PR12MB7582.namprd12.prod.outlook.com (2603:10b6:8:13c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 16:21:09 +0000
Received: from CH2PEPF000166C5.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::1b) by CH5P223CA0020.outlook.office365.com
 (2603:10b6:610:1f3::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Tue, 17
 Nov 2026 16:21:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF000166C5.mail.protection.outlook.com (10.167.244.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 16:21:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 08:20:44 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 17 Nov
 2026 08:20:43 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Tue, 17 Nov 2026 08:20:41 -0800
Date: Tue, 17 Nov 2026 08:20:39 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: John Garry <john.garry@arm.com>
CC: <will@kernel.org>, <jgg@nvidia.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <praan@google.com>, <kevin.tian@intel.com>,
	<smostafa@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <jamien@nvidia.com>,
	<kas@kernel.org>, Cristian Prundeanu <cpru@amazon.com>, Breno Leitao
	<leitao@kernel.org>, <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v12 11/12] iommu/arm-smmu-v3: Skip RMR bypass for kdump
 adoption
Message-ID: <avx+14DDGycsF+LX@nvidia.com>
References: <cover.1793593923.git.nicolinc@nvidia.com>
 <22a06965287dd478ee92f8028ae8ac27e054555d.1793593923.git.nicolinc@nvidia.com>
 <4cf391ff-804a-46a1-8d3e-d0ff8442841f@arm.com>
 <avtYhjyAarKdi33b@nvidia.com>
 <4154cfd8-e877-45a7-bf1a-45e2ae560e93@arm.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4154cfd8-e877-45a7-bf1a-45e2ae560e93@arm.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000166C5:EE_|DS0PR12MB7582:EE_
X-MS-Office365-Filtering-Correlation-Id: 33728704-d37c-46a5-1853-08df44c6ca09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|7416014|376014|1800799024|22082099003|18002099003|6133799003|11063799006|4143699003|56012099006|261022075727099003|261026121527099003|261028144727099003|261021121427099003|10067099003|261026140227099003|261009223027099003|261102123227099003|261021135927099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	wdG/gFlareFoDjtk/O4SsKje50oPJXIYCKoXaFv06dr79K9HLmCRzu87TDOha4X5WqP8Oo8pj+ORud43t4yHKBDogtftx3FFHz01+gHG4oUW2n2BdGnz0qqp2xnSCdOr0vAvP9G7H6KFMl8HEbFPMaPwO05kx6uExpAnwmI/hn7GqZqe7RUX85yGfGaGv3igSeO+Xn6ZNuqkGujkWN+qyC9EaJIf/kRG/C2tXwH3ZqiuDzpcH5K4VyQhVDT4PCt3N5Da25H12wuRI/QQ4TJnlOUaBPffCo9Tgg/KnygBgUyFMUXNy2/kT8ZL6rF6cOvxjGBtvWJv0JcUMF1ylCUwE5e/YqQ+VzQtX1CJYRD9BTL2ouLY04nxPt7RJQUvzcOr/COCPVzO1XrdiBDTE5+cyahi46MeBLc1FQoPg1ros6IJbLTTqt7pl7gx9dU3p+M4luuKfXHqXNwNZjhIHlF7YVu9/XNhc+Tm0ePxUfn9RR6QOXq3PHwfQUVhfROCaw917t+7kww/wL2REiAGHySxiKf+zAwWajbGvZn4cZpog7Fv8G72RFenDktzh0jqFYM/WEWcj+WGzPRKokYJsocT4CAYhxU6djSg0tHTRDSzskiGrrezqw/XIt+cGcqdV61n3HoTysV39De1IMjgKIXrn3Hzs8N4EI/d/tlucPt10g2HfuhoQAqxkRuCoRfeQWiFdr8/LV70XUlwqhv8+gPMaA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(7416014)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(11063799006)(4143699003)(56012099006)(261022075727099003)(261026121527099003)(261028144727099003)(261021121427099003)(10067099003)(261026140227099003)(261009223027099003)(261102123227099003)(261021135927099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eZfCUSrop1PXZ1/2WpmJhbVinj6iQOYr6gYf4rEigXH53Rez5CKMq7HSPJp/kd/hUmiiSqVFJra8jaFKkwW0WT2RuKzKPlpHU50n68412IHVb2tcXPe6uks1vmZzM3h6j3zDdkgoWu9eq2qaXGqZR4bY4SDCyGGoWMdcj6Q5F8bp0zYdfq64LTIwZssIh5AxBG2/GpOQ2cOd2xuk1D9QwQGD1kX9xQ05Y8oLFrkhPq8m+OQs6DtYo6DUpkEsr53RW2Shmej495LiJR/gdkPqGJ1egLUlH0LTXE0i6seQanvkofE4aWO4iYN+5pvU0Y8gNb3yB4z2VnikC7nBqBvx4z/5hu7wrJJ5C0sDSpir9kuYZB9jOgxQXGKFXwWpxzGDXOAmD8jpbvqrxQ2JbBZg1Vpa6C3qpGi+p5a1ahuFtK3XsFDbtufJPXAPNH6o51C8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 16:21:09.2345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33728704-d37c-46a5-1853-08df44c6ca09
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000166C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7582

On Tue, Nov 17, 2026 at 02:34:05PM +0000, John Garry wrote:
> On 11/16/26 19:24, Nicolin Chen wrote:
> > > > adoption keeps the crashed kernel's table live. Rewriting the
> > > > +	 * adopted STE here could expose an in-flight fetch to a transient V=0
> > > > +	 * entry, or change Cfg=translate to Cfg=bypass. Must skip here.
> > > > +	 */
> > > > +	if (smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT)
> > > > +		return;
> > > > +
> > > >    	INIT_LIST_HEAD(&rmr_list);
> > > >    	iort_get_rmr_sids(dev_fwnode(smmu->dev), &rmr_list);
> > > Did you consider if we should sanitise the adopted ste against what
> > > iort_get_rmr_sids() returns? I suppose that would add even more complexity.
> > It's not necessary: both crashed and kdump kernels installed them
> > from the same IORT. If STE is translated, they are mapped as 1:1.
> > It's certainly not worth the complexity.
> 
> BTW, are those regions described in a file(s) in sysfs? I thought that they
> were, but I can't find it, so I guess that they don't (exist).

They would, so long as your system has an RMR in IORT.

Typically, a QEMU guest enabling the nested SMMU should have one
at least.

Nicolin
