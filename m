Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.2
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793373697;
	b=evi22jtpiCOPbI5BXaoPNqafdhL3Kkp4jgMr/oIR1R3q5V7QHoWm1EBaH+w5rMez1TFn
	 NuHlAfHt9NR2PevGFFKDUDQAlVavWnWevWwwZfXqyi5OIKiPaOfjXmHrYhEPRr88VKduQ
	 I9njPa+KR9hBUMTPYRl72mPwJEZzCtUhPZ3QoX+71VvetkemgzXV1q8HE9INZyB4wT/A6
	 pOth0soaufTU6Q5L8Gl9pKpr1RI5ii+bRyNXi6dW9wstUdHLeMdH/2k2y1GmHhlNE+iUk
	 7l/5jrvgTTN95JsGcWXjXsJHZdvgLE6BG7J2nBNAJf+3PIGDNZhEBlbsRjuACNoRDng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793373697;
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
	bh=/X0pcy2pH99y7ZsFCnyr+gMkvXmQZxCbV6roR+N3ttg=;
	b=5W44GAvkO2dBe4YC2/y4sdXsuuy964Dx93CZt2MO+WbIE5uHI774UFtZoGCBjnBHcRUj
	 NkuqSR6WrwRwTRmk2eEeAaTO0r4L0zNPRs6uD1Ab6bYfWpm4ATZqPc64eJcwlh2mm8eZt
	 h503ksNr10j9Sqk5kjHzGH0uPNOu+Rf4L6IDQSOKhc5zDRPFPsr0avKDGkG+pPZR48oqh
	 FEBvK+YG57F9vuLXVrVYSn4bAjCwzpL4KcU6anXEpUALvW3BBz0OWZovpUI5RWkC9FqQP
	 zrYWZAIXEOQFG0YjAey6V91pH1+EBFqw4KMS39YAWN9jwie1Cw/jPr9nCNhxIxgIBsw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Bg8VF8Bd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.2
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012002.outbound.protection.outlook.com [52.101.48.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A16E606A31D
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 15:21:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A16E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Bg8VF8Bd
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O0XnbFfuKu/Vggth42G/hdv8uIyfvzu4NHJtdscLc5nftx10vRH5eITc5fAtgQSYh/aYuq9oiOP4B9CKCvBtRDXyNv7Wm71hvGlnnZjk508OpZ6dBC01Ko0cCwqR5nxqHqv8TmhosrIDNZYiXEiBwcK7skQMSj4vu1C9nftC/VdEfAWWdg6dvQmACIk2M7fWpaZJZ+7bzUSiN17X+J1xOEyBYv1h3EiYkmy4uLgVysx+42w6ETjGT8zx8VhsO7LTufPEmy69TypOY/MvrmI9C9GpZ+SAn6jTGOckSudpWNjSxvFDG1mhs93K0zwcQOV2SG3RXfMVn9Tnvigt1sUtpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/X0pcy2pH99y7ZsFCnyr+gMkvXmQZxCbV6roR+N3ttg=;
 b=pK3x69DTlAsdmAo6cB21I/o4z7P6yD6y0t4FUNZeDF4GfPtDpP08OYLreLcxjuqV1Qa5ASxeeoOHefhvnRXEegRgc+Dtig6jOtZe3nXPUJXHWfHgA8SkaL6OcC47b5P12hXp7pumJclP7fjIzX822x/49JE0/tj5b0D3VMEALRJSZBYx8A5naFByZWl9owfMhHaaEOjgKy7pE0ri1x/UUKL2h/TKmZi/7pbhKcnr37VxpZxuMAAuM2DoOpDhCcJfD0ks3DiNT45QE6gnk+Wj3FwNz0E2o75e8B/MtrU0eKXXknYjxV5vOKTIeKWIoTskH0yqPQ//Nw1IJYJHm9jH/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/X0pcy2pH99y7ZsFCnyr+gMkvXmQZxCbV6roR+N3ttg=;
 b=Bg8VF8BdjjiC2siHEamS2aUAvTiEdFDH5btCzwccD9lTR1U3CjHsK/eeqtyPDJVEo2SUrsIqSHpyHcVhtIgF8AWZXpbFLl38W4SyajG21vghd1CWIxJFDUXojGV3vy6GSbgfNO6wkH5rffdoMC0TM8BfAD83twIIgtruHZJuITg4cWmESyAUw499YGor6hPOt24fvmu5F621p4/6FuXmO62ZkHeBpVya4Qic1wc4fR1FpUQverwJulm5ugsNVC+ELbtScnwLmae+XZarihemtAsTtTfQHWeMqEYk+Jd3U1SsJNpBlh3sc+5sbgjQ5pz/cqwduM0JHVZLwvpT1kANPA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by IA1PR12MB6163.namprd12.prod.outlook.com
 (2603:10b6:208:3e9::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 15:21:30 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 15:21:30 +0000
Date: Fri, 30 Oct 2026 12:21:29 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 3/4] iommu: Unpublish the old attach handle before the
 group replace callback
Message-ID: <20261030152129.GJ3734323@nvidia.com>
References: <cover.1790718296.git.nicolinc@nvidia.com>
 <73ebe081ed668c214628fffc546b9744b662afb6.1790718296.git.nicolinc@nvidia.com>
 <CO1PR11MB4835DF015165BA9306D022178C6E2@CO1PR11MB4835.namprd11.prod.outlook.com>
 <87fb7a3f-b6a8-4683-84e0-1b0d04dfc235@intel.com>
 <20261029184544.GF3734323@nvidia.com>
 <943304cd-112d-4bd8-ad3a-f70359f15aca@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <943304cd-112d-4bd8-ad3a-f70359f15aca@intel.com>
X-ClientProxiedBy: BLAPR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:208:36e::25) To CHBPR12MB731189.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|IA1PR12MB6163:EE_
X-MS-Office365-Filtering-Correlation-Id: 08b6dd78-db65-4af4-3059-08df36997966
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|18002099003|22082099003|56012099006|261028144727099003|4143699003|11063799006|10067099003|261022075727099003|261021121427099003|261022105027099003|261026121527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	wU8h7cwkmOpI+spe3leQ0DpFZnCAYhI9SP3QK4rOvf4ZE4RGKfUWHiSjRs0IHg7Sii6Cb5ucAFetEk2LHE7hgrYNlDXl/aOoqYbjlJkCc1HyUu6ZhfzBKYfZaXkzhaUk0FZ2sOrhccQAF2F9OPu/GRs1sx5jUXNqpoFMc4OA/HQhRPqpjV66WX6jL1p5YSOv2HNYKUqQP7mdViPDQrVy5q4CtxU8+OvFSw2WOvIY6tfWjs6JotlkG8sCACAube7IrmHzD7WaFFIycfPLeu2LHskxypftjUFjO7pyM1dRQHYGYUIUd7NyhaAZo1srR+B7onJqYGnIAat071uXbs5WndzInCEgNBRL+z+r6KE0r/mvGG04guGca8BJZ4KMZIOd1/R4IOw8jVIFiyWwrNLMsi8QOipcnX6qPz6lu1BgA17HtcHPopjo+FFdBRS+8qpPZphtRF/3RaNle5GkyNk+FiUJTHJ7FWAyG2Zi4OyfOQlrWDvjOSSUfrD8jDNEhgaoguxwckrGTK/DuiWpdLhtbbAFOulEL8qRAWl6OVxdsmt7bOElsptOpCR3tw55T2E4idKMG3ZLJxLVgNaSurAMkmARLnfPEEK/QtecelpzzjTd7gFtA82rvmSs4wxXQi653CpfinuT6j30Uc9fh/XS4DADvTl1omhxDI7iGirzLMM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(18002099003)(22082099003)(56012099006)(261028144727099003)(4143699003)(11063799006)(10067099003)(261022075727099003)(261021121427099003)(261022105027099003)(261026121527099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UosbIDZokG/B51w+kWUm4cgACL3sMHVBphHJOLouTBVgl9rREIcZJ5puzvUI?=
 =?us-ascii?Q?Z1NVh9Lh3GjNcnWxjxky9v23t1V2Ev4DxhZEZh1xAwgcvqK54OSqRp6IDeid?=
 =?us-ascii?Q?st2StI1C9pD3sYNovVcbJ6kTW95GLdqfYA5l6oNe+ftFlihwWuOcQCUU/Vo+?=
 =?us-ascii?Q?gSgvghdxbks7p+dxPM1l5RmflvoV6m2s3x2F97BmVE6gugJaEb36o9Ud+Y7c?=
 =?us-ascii?Q?1a82nDUzZ+hQjWeIKzsowEwn80QnQHMbzK2QZXV5FkeocBBXYnn4oUPgNR6k?=
 =?us-ascii?Q?ef7C9x2yPSI/Vl3S7fUdRAL86e8oG/GgexRuX2uqKzOCUOAf+f8OzWYiaUi3?=
 =?us-ascii?Q?j49slluMy6ZN3bsiiWTTXZ7WEuLYRq793rZ5GwfgmRoD3ULA6GepQ5rFmmZb?=
 =?us-ascii?Q?H9bfD8d7tG19UG3q1NwpOr/CvqhciNYlYLqbGxSy2/e569MszB6zO+NfWC2f?=
 =?us-ascii?Q?y8GlM+17/qO3k8RvP9SDRiSxbZ38MMfQ6soSCoR5xbw0YeYGU3mbIKfrGPt2?=
 =?us-ascii?Q?zPbK4kEcgI60MODA8Xo/f6/4eEDbQjWkfvxlSAhwKeHQPk+VYDeUAmni23kN?=
 =?us-ascii?Q?UT/dlwg3pGs89idm7UEm/Gi1RhepVBLF+St3a/PX1Z/gjvOfXAz5NKd1KpLq?=
 =?us-ascii?Q?L1DDul7ZsNkcoRDHn0a2/32mdl+keb/fwZRfUhwZ4SpWMD/NkMm7mTdE1ZW3?=
 =?us-ascii?Q?NMYwxom8ZQFAqAS78k24e/vyiY74B6kt3tJI4+/Q3JPBFS5g+907s0PhHYFi?=
 =?us-ascii?Q?sV9iUCkOg+X5Tbc39zuOZoBMik+aJQRgvsT0rQzlQwiFK3KP/8Zk2kGc2Mdh?=
 =?us-ascii?Q?FmM0mvnMX2LfCPG5skMy/KcQ6Lvx2yBathNoC+8awnI1bQ1ISBeXcimkvu+X?=
 =?us-ascii?Q?e0OvoUZO3YOK3ogZyLQUVYRA6zBkJOaZ3s3w3H2TDxcULIpxcYw5n/okRlDX?=
 =?us-ascii?Q?BrnYnMS477abAl4xz35yd1F7c57rzLG5nRqv630neTF0z+4/OGqz9AM4pRee?=
 =?us-ascii?Q?XX0FNJTUyHfveKz9eXrl+xDn83x+0UqXfdoUjHdahAA1JGRduxkzrCQ6Y8Xx?=
 =?us-ascii?Q?sVtHNmngcAsJ3onAzgpLTexNRT6CcUMoEV+1QgVKXTBY5yEX64YZSPRB+JnH?=
 =?us-ascii?Q?IXem9fegsbLjsuRVyJyfXejnBf+KeRxpckWdUOK98ewYStBUdAm0Pd91ScWk?=
 =?us-ascii?Q?LgzAm6Ncgbe+954/40WW4LgYuVC5mdP2ixhuafJvu1nnCnJWs+V05K2ut3cS?=
 =?us-ascii?Q?otWLMcO6KQwkqZw358QjzMjo5mSzavvGH34tE9SmfHNISxSGcfp9Na2kw01D?=
 =?us-ascii?Q?+skuDQpTD9Lgb2DikVnLjjAsn5uFEKBsx319jkVNcNsMVuwmH2HZceH9oiDm?=
 =?us-ascii?Q?eMLlW2SqNuwqy/z0w0qSUsV2pokb+RbZx0FfBiFrPo16ZxKksT6YmT46pcFb?=
 =?us-ascii?Q?EiG4vpm3PRYwbynsjvrdwpUA0miGZV9s7yqZuOEFWIZAlFvnXg9emfbaPMq4?=
 =?us-ascii?Q?9/L+OL1oJrPYonbyMFjANnJo9/awdeS4RYGvQ/Z8ypGFD1I+z9wrGIITrTC9?=
 =?us-ascii?Q?UT642k9uxJ8wIQgoOU1Z9KH7fRngj8vxe0j8mFdvuYDgXTu7vlPoSHsjRHmw?=
 =?us-ascii?Q?yi4ZXJwIi2UMn7bldL7mu7aeLR4CReJA/QsMmX49/d9oJqZ793FKqP3GyOjH?=
 =?us-ascii?Q?SVW19vWQJq5FxOYT6IjijwHrv3zSOS6kUZXi53iNBD0XBz0O?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b6dd78-db65-4af4-3059-08df36997966
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 15:21:30.5477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MIFU4OBYcrCv8kNLXOgOrlfPL5jclCC9voDWC0r4wyuorL66aZSJkls1emP4hkuK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6163

On Fri, Oct 30, 2026 at 04:22:11PM +0800, Yi Liu wrote:
> > I called using either the old or new translation OK, using neither
> > seems suboptimal. So returning IOMMU_PAGE_RESP_INVALID doesn't sound
> > ideal..
> 
> I see. maybe we can have a interim state for the replace window. This
> state responds PageRequests with success for the device. The device
> shall retry DMA and re-trigger PageRequests again. Once the replacement
> is done, PageRequests should be forwarded to the correct domain and get
> resolved.

Yeah, maybe we can drop in a dummy domain that does that somehow..

But that seems like another series after this

Jason
