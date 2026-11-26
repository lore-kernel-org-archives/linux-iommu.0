Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.58
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795722832;
	b=36xSmyUNp7SBVjDPFjQembl3oQA8hI4ktJxhBUdg3Azflx7GOfJxFh8yg6PsZVW5lUN1
	 OmHXum8j2uP5qqoOxvJCaGZSsqaM9N1rYS809utUQthyox1DnuLXFEzyY6uuW17PKtpKP
	 KyywjvTFYTnWgat69Cwj8yapRbQEYXKEiLOgUW0iKv0cPQjE4Zz1wGGcaaY/MqBvIb37t
	 6BuFdcMdrJqJ2/SZ5h1jcnZyzm72225QMz7ZJfAAH5b/SqgQpLOrxtLSvRoMDe9BIOIlw
	 bDQkjARKrgpwILeiYKfJBHNSh21EgASsprh/VVm4a4ipOhAHzSxXYaUZNla89nJcb+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795722832;
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
	bh=5pzjMfSOAYrC4INZAMlhdfagkrpHH8MThHdzwsCvk4g=;
	b=qFKwiMPyePlxbukDedEzYfSuX8fXH2CwUlB3VqdUNXiApl+wynJHJ27Ju4tLW2TkkNJ6
	 bhVsfGzCUOoKcjIGgQwPFFluI303vnyD+bRydRCSZ6DM1RB+DNaGPlwpU4aXHNeSeLUNo
	 Zz+HPEvgpTFlajg3uaxxFHYY4otyFnk2VBX5qLTzvgaWjwF8+b6ux1/le2JHIqbh24MAl
	 Q4VD+hgZj9PM7vafvroubJPNN0js9pqmADV6gcISVaiCT0pPLUWYachAwaEKD4i+1BPcu
	 OCv6h10k5ellgLCyOAHz4bjD1grQJ4+4JaQLxxFW2vxZP0tAxfTggrbzJjCHEUh4Q9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=VVhTuy2f;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.58
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011058.outbound.protection.outlook.com [40.93.194.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAB4606A31E;
	Thu, 26 Nov 2026 19:53:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCAB4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=VVhTuy2f
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMOGThBZTEdhhg/qbue3xdfW565bOG/vZ63ASoA9HrSiUVDT55FTqeAm62K9kSKS2HZw/LLiaKGhqXm8tf5f8eDJWBfmag7fDcakrrdFv+JHu7CAl27NWIpDT5RA5gyAlL0biWrSVnmRq64CuY3M2C+a97Bfbucfp0/i10A20a4NTrnFjZcqfNSUT1R8l0iU20/WqYWRNHbPLRz0Auj9zz2BHRytW9LQ9sKLfthQ3L8+zXU/GjQ4B+SxQKKewLBdqksgQnjHa8BQUVjku0pPH487nOwWffhW1MRi9hHzq8cuVguj2hMNWcz1Ui6wSI6BjgSq9nS4bhCxn+u1qeVi+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5pzjMfSOAYrC4INZAMlhdfagkrpHH8MThHdzwsCvk4g=;
 b=epKzBVWEa3crOzfsrPfec4H1iyhVAOkugUsPuVGfzWDf3tjINaFcLarbV6IssMxpZ46nt5iCrStqNoT4DMXlsOQH1RnN/u8WruKZebb+z5WFEQPmH5OrbHOWMhiTyRFmq18GZWF8kR3RG096g+SaduCK+qoSMXgU1gLzwnKQ5z+Q7LGyPZaO9CaDsCkADymat1sTGSHpx8bzGs1mA+ss9IX0BElrv6hYY6s1ksWN9GvaRey2qE3TzluvbBJEmbvvW2AvfEd2jeR0iLFmqJnT1+sairnMmILjcs5iOsIv9sceBmJ4YSHyj0ss/0XRjQUk78g5xmYB1t4U/bC9BvM27w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pzjMfSOAYrC4INZAMlhdfagkrpHH8MThHdzwsCvk4g=;
 b=VVhTuy2fL97Y59aeWrmyyfXdNrrIqeF3/RHj3giqdmKs1Re8rv0DPBqsBXM3qfAlSjq48iKd2KIrH/7EzS4rwluwQ/T/KbGiGrx0kYI9vKQUkJRKtx8gAMjV+GP36AwkDr7fcCBHui/KVdPdjmPoytXp/0ukLLjPJWZkIrnBRMPjNh1YhPwzaEo9fr1/LAiHRm4BJMQkAJIBG0VBFmqwDnFhDAuOQWtx4uuNlHEhBTGJMFNngnQkkmmOjelvT9U6KvPRSuM7Rpyu3GHp1pFmLdGVdHCYYYcaGToQP3RS4Sz2H7EDmvFfUZXejp7B/9Rk2fWwPc+vyXEQHMxJckVS8w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by IA1PR12MB6308.namprd12.prod.outlook.com
 (2603:10b6:208:3e4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 19:53:47 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 19:53:47 +0000
Date: Thu, 26 Nov 2026 15:53:46 -0400
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
Subject: Re: [PATCH v3 5/7] iommu: Introduce TDISP T=0 state for confidential
 IOMMUs
Message-ID: <20261126195346.GJ114472@nvidia.com>
References: <cover.1794343501.git.nicolinc@nvidia.com>
 <07ea92910895a2b0db33afefaa3a0ef182b2968c.1794343501.git.nicolinc@nvidia.com>
 <179563006502.253973.9155049351516451537.b4-review@b4>
 <awe6WgoiKaBTgINn@nvidia.com>
 <20261126145715.GG114472@nvidia.com>
 <awiLcoPfk0xxEL4A@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awiLcoPfk0xxEL4A@nvidia.com>
X-ClientProxiedBy: YT4PR01CA0162.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::28) To CHBPR12MB731189.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|IA1PR12MB6308:EE_
X-MS-Office365-Filtering-Correlation-Id: 033831e8-bd03-44a4-fb40-08df4bf6fc20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|4143699003|6133799003|22082099003|18002099003|261028144727099003|10067099003|11063799006|56012099006|261102123227099003|261026121527099003|261022105027099003|261021135927099003|261021121427099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	y/ZLcIveiN4UcUI3MAxkB8oT3SWiSgd5L6r3lqkt7VWoHgLwW6OZKulcB5QnsnM2mbaN/YEA+6MdK+2uE4lTX2enyJHWt1+mMT2T2Aq1XXcOydo9VE1r/NocmXmAj8NK7K9EIsNgVtvc1Yu3Ky2G/7IQXzOjd3kEyBOyGheUBy5A8LUd80a1UB/NmR8pbcjmK0GsxO9uvicM+7Zy8BQTAnL7qMg1PcFys1AcjZAr/dBZZ/g7I3FPDntOpZVsdBDZ3/WrwIA21bkZu08iWhRbal+K3SHYa2dDOzQFrsP1u5wv26HP1DWPdDq6utJXY7C3eFoJObbXxJ5FD6pIHUFJaibCz3Q57FJPiOBdwSZV1EuyHEhr5qDkdA/3jCQUFHkkXvdTD7tEPSWz9Gz82oZnLrmxgEhmFUFEtAs8TM6ENHj9BAyttat/DeyuFbm7kXnLkEvxMw+ryx4HMhtO5sPfKneFnVmeGPVMkwQw5cEiUqhnb0L5E/CSenwEp+Dr7hTWRgECunNxe4YRTHJLd0izlNaMHuwZawJoSjqW8AN0E3EcVgAlf3B/Z82QhpHLAYe7QA7wyEDgsBWhdbQt0bwk5sSiM/C2KgjOzNBWI/T1u3F3lHGmINoApfKGKmxn4jDpQzRwl8BbMd2dq1xPQiGAjhNO5uHLzHPewDTHmQEgsrI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(4143699003)(6133799003)(22082099003)(18002099003)(261028144727099003)(10067099003)(11063799006)(56012099006)(261102123227099003)(261026121527099003)(261022105027099003)(261021135927099003)(261021121427099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tw7DJf7MZsOKw7QyK6i4R9Y0q0Ozo82p8cUwdoJlB8qYJ7UghS3az8KlDIa/?=
 =?us-ascii?Q?wEAQF/Ptbwmch2YbjnUr8ehV4dThQYowlxps9x01aXYSAqhxZIuqJEW41VmB?=
 =?us-ascii?Q?u0ld8mEfQ7jlzJoeMG0InmFnEYXd6Eexlcsh9e/V3NtLvdx2YYNyjs/FYQ99?=
 =?us-ascii?Q?pW4gU0+oxa3ZpIy586bpF6hPfMR29K2uqZEQXoCWq7SVMjIo46nmYhDJqJKn?=
 =?us-ascii?Q?h8cgTPX6zuWpjMHktNkmfdgxWiXwdk689fROWrO9yvvGIZmycotluKBda5kO?=
 =?us-ascii?Q?0y7ZOwOCD30eN59W+E/HxtSVO7DzLKWA8sugQsnBMjJ4OumTQKnOuwhVYs2D?=
 =?us-ascii?Q?JbQoIqy52gTXcGTeEmEXs74gVd2e73GMyxruJPl9SAkBT9yOCQWk5kJySBPp?=
 =?us-ascii?Q?Yr0X8BANzrqfDgEGhxWn4SKTcCcBHZBzA0oWm9F9eGLldmbqvnN0yf7wcIiC?=
 =?us-ascii?Q?FWV3D07hpjGtGHpxTnkE4cQJ5MNweJ6PmLA/oiJYJok2d7YyFmhDTIdJyWV1?=
 =?us-ascii?Q?jNZv3AXrhhnJVLGiXZBCKokCmN4wGEwAG5ybg6wI9+DkJy/hN1nkLuqy7Ayt?=
 =?us-ascii?Q?QknHUmMKe99+TE5Z+qQqD3jWkhZj0AbaWXhgz4Z3xQEH2do9ienD2FR+lOPE?=
 =?us-ascii?Q?YFrlTHAIPBxDGewIRk4rbJaHX6MZVzJlntsnjpnouqgqS23xRLTIVPsIHX+D?=
 =?us-ascii?Q?ZOZ2Ywl10qtCFezYvOIZGQ2jNH+AO03Tvjy3RLFMB8PnHtTzHphvJBVE0Lcj?=
 =?us-ascii?Q?KgIBpnlT72YRFJ5Ppf7qE0u5nZhb/WLz2FYmqggvvjuqMB3fyQQ0YoaV7Lhi?=
 =?us-ascii?Q?C8JZreoq5TsfQpzYbrOCYaQy3GY1BcKhrpjxQn5UorfTBRKbflyAwbkiuLmp?=
 =?us-ascii?Q?E9UFZbGRryGGZG9bBe+a8JOe64n+wTnPzJ2PMiuhE5hlX+mVxQRbHlMUl/CO?=
 =?us-ascii?Q?hj3+UOS/BIAhWdiuOpw0kJKkZnyfWM7uVSU6P9Sm3w9qYtaUb9Dfczl/Wf2V?=
 =?us-ascii?Q?fkvPSXM8600RFAsCc8Zkr60fdoMLQ9LCEePLYuNJ2VhFFNmV2QTMOZ5rUIo9?=
 =?us-ascii?Q?bXwL7CnpLcyF/+I3PmzLfFPD1nPBYA2uWQhCqSAbyvpZ//Xjzh+Nt2meZRrq?=
 =?us-ascii?Q?T8iWCyTL47QcxmrtNg5/4nc6e6hZB5KcwljngSJz2UuhRoan3KcDfDqllyZG?=
 =?us-ascii?Q?aDwIN16UMmeCET+U7MuCdDI4PNl2G9WdJ9KcDeMRsu0ICr3ssbHu6JIuv4Ow?=
 =?us-ascii?Q?v9aMblIBWaxxLgCPwS38Yk0Y4Ro8CZERVKrlc2etRmLi0WiE5u1NleF5rGe8?=
 =?us-ascii?Q?49XCJBdXc+zAxINjpJ8hfvHewsiAk3F6vC6TVwnsn/TEDJYAKVXgRV9LEG1e?=
 =?us-ascii?Q?VoQlMGQgew4tlHGGQwebIFEYGcq0xD7GKatPSo+0d0fSvMZB2xv1lqUsknL7?=
 =?us-ascii?Q?4YiMz9/1+kJV54cmhIQt4q0UBiHMu74tbc6oORzfS3BoKs2jAbSp6DbImjDy?=
 =?us-ascii?Q?uF9WJkukNMTAUVelbbwCtbNeZBgP/TnE74dFujFReoqufVAdC0xQD31K/mrf?=
 =?us-ascii?Q?LXBShK23kIRCNaOQta0wlAEjQFvnFP2FxDzhFOkYDtEZOL9lyzpPolnSBLx2?=
 =?us-ascii?Q?ymaqHbhR+o/Vwfs6Yq+zkS+T9ECuYgUww/RsdRi9YIipSaEjellxU2TI149K?=
 =?us-ascii?Q?Xw1S9OZP8l05a0bA9QZVwYR69qg2OChkceTaSC1TzumMlqtv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 033831e8-bd03-44a4-fb40-08df4bf6fc20
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 19:53:47.4999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wYdCdMkaG5FsE+5Jg+nEN2+jpUaxSSaHVJTb+CEnxqaJ47/jT/7YuGcYR2NQNcso
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6308

On Thu, Nov 26, 2026 at 11:41:38AM -0800, Nicolin Chen wrote:
> On Thu, Nov 26, 2026 at 10:57:15AM -0400, Jason Gunthorpe wrote:
> > On Wed, Nov 25, 2026 at 08:49:30PM -0800, Nicolin Chen wrote:
> > > On Wed, Nov 25, 2026 at 02:07:45PM -0400, Jason Gunthorpe wrote:
> > > > Though I am wondering if we really need the ATS stuff. Why do we need
> > > > that? The pci_ats_required() in the hypervisor should force ATS since
> > > > the hypervisor is not going to construct a vSTE or use a nesting
> > > > domain that would inhibit that? Can we just drop this whole patch?
> > > 
> > > Ah, you're right. It was added for non-pci_ats_required (non-CXL)
> > > cases where the ATS state needs to be in sync with the hypervisor.
> > > 
> > > However, the justification/usecase here is pci_ats_required alone.
> > > 
> > > One small concern is whether VMM always exposes the underlying ATS
> > > state or not to the guest VM. QEMU seems to do so. I did a test by
> > > dropping the patch: lspci in the VM still shows: ATSCtl: Enable+
> > 
> > It probably shouldn't do that, but it is also not harmful. The guest
> > PCI controls should be fully ignored by the VMM..
> 
> Would a PCI device driver (running in the guest) check the guest
> level ATSCtl state for its ATS pathway?
> 
> If VMM is not supposed to read through the physical config space,
> without this patch, I suppose ATSCtl would be disabled and ATS on
> RID might not be functional?

VMM does not bind guest vPCI ATS Control to the physical ATS control.

ATS is controlled through the vSTE only on all arches.

Without a vIOMMU ATS is controlled entirely by host preference ie
always on if available usualy.

There is no need for the guest to read or write the vPCI ATS config
space, but it does anyhow because it doesn't know it is a guest.

Jason
