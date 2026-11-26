Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795705151;
	b=kDsqydwd/FmURAVPNLnbRZr+rFQJg1qsmppSvS7jh3oikzAY8A6CfW7PwQanr1LkyiY4
	 5cpdstRwXBShrF+3BlgF2/GxAMy9bywC9faxQcxTs0ODBoKDE0nr6z0zBl+lxdoo9Sw73
	 Tvv/tYTtuxrKn2PoV+0bIfcplfP6a0PwecF5tXXkq90rNLUJK/JfsDffGToIG+M0+JmO9
	 jdRfPDzRdOoulx+4b3daALNs7pGjXPBIrSSon1NPXjiMKkD3pRfzTpDWc8KDDRWTDOkjD
	 1SK/jeBUV+Aig9KfDEhhULVvAaRw8EHaFUZOZwyZADOVPVaMumYy+eYB45hzp1nX2BQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795705151;
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
	bh=zJwqm1E80+fPDKXL55TmgDt9UCpJfQGOsnfuaHdzqJY=;
	b=op+HycJlSAyrLEZ+a+fohjT/F/oDAPdya7x/LG0+ytparSWkjUwiRIs5vX0wsOsdyx7p
	 xi3cJ3Eb2KhM44EZm4ETEOgVGzlz6K5qZLJxV4WaE5MECA86WK+lHeKb/LjDd/qDzGmCW
	 FSsL13DTdX36IvmFs+v9UXSK26V9yefd0PzZt/DCYwkaL8O0Jy0xPaoARQiSYYSaZ9lz3
	 d004pExoilHT+fuzow96PaG2hLWCj4LEY55WC3QVp0eIj/JjS42FZPqGevOtUz4NBQQqz
	 6ja/NGezyUO789afh3qNhQzARMKYS6hBt3gl9d3T4tmzTHdNXLFzVFCcij2hfKHsdgQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="TnCfLt/F";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.41
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010041.outbound.protection.outlook.com [40.93.198.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B496606A323;
	Thu, 26 Nov 2026 14:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B496606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TnCfLt/F
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kt6irQ/XuIIXPnzUBLPU0Gwu7N6+QzttwfhCcC2BjhzKTpokuMG2uRAAFJlgwhhTYI9jLtttT1/11ZPKZJuJKjhXZxQYUHttFUbuCSTFq7J+6lXLJ0Z3osyMkjL+J+mDiKoqqr1xSjNetSQ+dkdlkG2RDvKDRtLfrOa3HCxsqTPbh7UeSmm2xTc9YRbhkajsODslhx6/B331bFBXvXiioxH7Lt0edoehZe+W3TOvFUVRHX5G8iMatB+xYvfMlU4CjyAk8ek08D10l+1mwCVrUjrIK5BYX3v92p8A2JYhRWgJMjNa11BDVDUd4bdk6CBYugNyC/RvcQPWyj9d7NeBWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zJwqm1E80+fPDKXL55TmgDt9UCpJfQGOsnfuaHdzqJY=;
 b=hlCqpT5vmHGBnA9PAlIdmCdGqrh8N5C0LztrcfZCkBW7Kn3og5MYmsFrzFOMZSWy5DLaWkVQImhLc2/QjfRNG9Nv107kB1eOQQDVfMfLVUlNc+VcOZLBQvvfzdZd3KzbWracWZ1HBRT+DEoDAJJGbn17nhbSOBD9QTJD0W7xmDj7SlCSfokrjgFQD00Um7VoRck3a9KuuXPwzSyk06ZwOblHmqG+uiSkKCkyy31Ss9ED4Z9avgqPzf2WX0M3Hs/Z2m8vVlmFQiFssenA0ABhDsl8+rScAonQX3bJxAsKARn9Ev0Dm2I5ZDSVwqCSmPKp6BdrUwrcKF3Te+q7acRUKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJwqm1E80+fPDKXL55TmgDt9UCpJfQGOsnfuaHdzqJY=;
 b=TnCfLt/FawHdJNNTqG6ioFofokJJmrJnzTytwXQtVLKyiqRAJCv5RVsZV4TrMLqw3Gxikfuu/4BIEkbRwdGOZsN9vr+MCeo6h6JYuZDbKCUEoPjuYOLWZhdJ4UNFhwvZSZwuFXVf10CaYkcreO7mhAiOfpLNny38p9n6jy4t3ad0xpRzymiEu2CYf5jFjQhh5w7sLoy5K6iA577nxyWvBQjteYDwWVJT1W0MWo9CcG8nE25YfWBxbQIOYY6XAtMHBBnQPAba8EYdsBEauuIyIs79EwaMDRPY5vGDkHzJxafDFYnaCftXJPvID8CyWrRB0bAoH9jJ9ja3Th5swMPMzQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by IA1PR12MB7662.namprd12.prod.outlook.com
 (2603:10b6:208:425::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 14:59:05 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 14:59:05 +0000
Date: Thu, 26 Nov 2026 10:59:04 -0400
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
Message-ID: <20261126145904.GH114472@nvidia.com>
References: <cover.1794343501.git.nicolinc@nvidia.com>
 <07ea92910895a2b0db33afefaa3a0ef182b2968c.1794343501.git.nicolinc@nvidia.com>
 <179563006502.253973.9155049351516451537.b4-review@b4>
 <awfRnebqhJZxkzzh@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awfRnebqhJZxkzzh@nvidia.com>
X-ClientProxiedBy: YT4P288CA0063.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::28) To CHBPR12MB731189.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|IA1PR12MB7662:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fe602b2-2f32-4d94-32d7-08df4bcdd0d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|10067099003|56012099006|11063799006|261026140227099003|261028144727099003|261026121527099003|261022105027099003|261021121427099003|261021135927099003|261102123227099003|261009223027099003|18002099003|22082099003|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	82ShJeXxIs9xCRJgUOdCIxCvCMAhSH6YvBg5bQfgBdRuuuiBVQqZUEoZd/xL1SROHLUKkAZQ75XHMp/tKIuM3Ybchv/6cCT+A8tEn3yWR/IhanuyNMrWPF4yjllTkGfQmXJteA11ZcnRbj3eBvjdgT8BwLwimj+qAmB6wigNd0T2gLxeR40OW1cgKTfP3rqwydG8MJ6sKJzh2pJSmQsphmJCdTYj0chXXVr14w1USSBky8zT1cVCdff9/x3VQLYmWeutExFm98xWcJZakg5AEno/PvsKzOlUn5X9rlaBBEwTqkwQ9eZB8w4Jid2MlEW1r0FhBSxOrdWvQokoxeAwwfXI3BuSutwKD6G18uqyqcK1o6x1e9Jn2vq6/kJAO/kxdm9/+rc6xbJO727xmo7AV2X9myM8pfbgmaku0eZYuos/jKvtZJzd+kmF8L46c+XQ7JbzMbmxylLDrYmBfBlUujFfFMwnEUs68CcuBiF3KQWdxKkelodpysUxzhaF1LDSGkO323ruyKF74WKD7fca1mDJ5Zn6T7HLldrDvRfwvVimFJZL+zqGB3QPjnfPjkIRm4hEvwFTXpVPTISDIccfQyvhsZmNwYTd7ALCoJPcK/U3VYbJ1kAvBUQnGbuNGGvQR2GMnPtLdEc2nPnMLLInXCneKR2H8mLvlM5Afd5oQJ0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(261026140227099003)(261028144727099003)(261026121527099003)(261022105027099003)(261021121427099003)(261021135927099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X09wMOWn032JEFy+YNCX7yK17tX4VNbXMc6dEJINn6ATQBr2pAvmtcwe/2Ja?=
 =?us-ascii?Q?4Q1BHdB3nrdMJBlNNlHReyhnWNxhqv+IpzA9DTzkErk1jBtil08xa2U3UYui?=
 =?us-ascii?Q?rrD2t0fmWBuCvB1xImONGq4zDIvdXk6ZafpWifBxwQGWeI0IIOlIeBTyrpN7?=
 =?us-ascii?Q?/BUyCIe3FJCkUyHnyLYb2pdCk8GP43uFjFJI1r1rcoiF8Xc9DhLGH6q0fvtX?=
 =?us-ascii?Q?c/FA7yb3uKOz2xjBt6BZq6YUVE5+q5qJM2tlSfRssHr7O2AKhVTtq/mQ67aE?=
 =?us-ascii?Q?oeErBXlHezSRrmk/aUTNeyijQfilJVotn85Ct0hf3/BbqwIZYK+q7eOulwzU?=
 =?us-ascii?Q?GxMObYSHW6kBHiDcHBd4tg94MGM1oumtozov1T1p16gH7ZoulzxXFaF9WqJ7?=
 =?us-ascii?Q?WQEK5keiF2esEXFJcrVzg+AsHD4RnlN4ols9Ykw/Olk0ROeohkvokDB6YLOY?=
 =?us-ascii?Q?zjVT05qf48h7osOEAr+37mOqI84/7eBpcMCZW9YtnDQob5d+bV+oEuygo5hn?=
 =?us-ascii?Q?ADOYYm2iuBZJLga7lBlkDcCxMTN5FSe5JCyPsVwouE3RSEnI+xJWOg1jPJSq?=
 =?us-ascii?Q?+MkNvKx7SKXyE5pCVbGXAzY5QjppbvFwNd3uSWpPXchNxjKssVwGKO1qSSvB?=
 =?us-ascii?Q?m0pNIeJFamEZ8rVBhV5rfBjOptTafNdLRUCQMxjdr8x4bipRIJe7QmNv+T7c?=
 =?us-ascii?Q?RYA3dbtH3CVIJzvVTcPXpqeHWXgv/YZItyNl9ZsgRn6+/CHHqtLGBbqc5vYH?=
 =?us-ascii?Q?/9ZAs8eyWPUPRAXimJYakAiPoluZeqUuORTT8h3ZJ3yMMXbxc3EIJuosApYm?=
 =?us-ascii?Q?jiGRBbPT8GBjCMsTZWlsdfOWpo6cz1UnUUCK0qakcoISowujEtf8SWyoNSIB?=
 =?us-ascii?Q?yYuvqtc7zWljTa/cgSRtPG/fF+Iye/jg42nNf9JeZtuZgMwkr1NbFgxdhvwo?=
 =?us-ascii?Q?4RGG55Dbj+w/QOpryLJqDKE7I6Nm84AnxfZm/Lz0dS39iTUI7IfgwMu3CRKt?=
 =?us-ascii?Q?x8LK2w22GnbDRYorYPqwU5EOAWQZcpvG6T/etI+ys9O1qLqC+hAT4Sskjcu8?=
 =?us-ascii?Q?ui6PV5UrBTPbVHf8wF0JBdApLjFJCD+o53owneFQwfqToDzJRZzLFHwpyQlw?=
 =?us-ascii?Q?C4w0TDLzCfl70lgtXgyLRmmfkDmHWl5hnXpqUGSb1AoVhSlSlLRdmFqVZeS5?=
 =?us-ascii?Q?uNvfu1mri37VkvcaZgReD2AXQ828VD7JfnWkjSKfE9y5z0vA1fo7Q1mn1KTi?=
 =?us-ascii?Q?h+0Z+yKH5GtOUWTFZ28oeV6BjfU2xIB+/4owGhqAps2EkazjZjOIo9AsUD09?=
 =?us-ascii?Q?G7TPX5XpPSv4UgVWi3WdXwKrfY4iouSEOnTMm+oj+W7apQh6dvu4FMKO+uj9?=
 =?us-ascii?Q?VX7yEIF0ws9YJcsmEXVzXgZ99fx8KhxaxO33gchBk1QdRKgVZr1KrDuFrLG2?=
 =?us-ascii?Q?LogY2ZH98nZ18cdnKc1VAcDyiPXOnXd8Cu1MZl9R+Vogi3fncj7MNIPZzppH?=
 =?us-ascii?Q?7eiIwkIOqBkEmT1K3hetuIIlOAIlxlLzZqKPn7o2yEqbfEW565CE48ECqbXV?=
 =?us-ascii?Q?+TeQaSek8bg4/H42ukvTxylFhKGykTE2+81AASn+Xujpm1dO/1yg+VzlJ/qm?=
 =?us-ascii?Q?2J2PoBR0hYdZz+T6IAVFPyZx70Fw0o2uluXEqza3gPRobEz3RtLBDZ5TCU4f?=
 =?us-ascii?Q?QNA7BNcoMURGCWZ+7lwE0Fxd6Olkde/L63MWyGIyFqohxam2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe602b2-2f32-4d94-32d7-08df4bcdd0d7
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 14:59:05.4948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7KfKkh8ivDn9HsCKtYeO/1DYpq4+/fxuCUQFXomHCLWyktZDX6Zyys09GeUowmAM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7662

On Wed, Nov 25, 2026 at 10:28:45PM -0800, Nicolin Chen wrote:
> On Wed, Nov 25, 2026 at 02:07:45PM -0400, Jason Gunthorpe wrote:
> > > [ ... 139 lines skipped ... ]
> > > +static inline bool iommu_using_t0_stream(struct device *dev)
> > > +{
> > > +	return dev->iommu->iommu_dev->confidential &&
> > > +	       !dev->iommu->tdisp_t1;
> > > +}
> > 
> > The logic looks OK, but this naming is weird.
> > 
> > All PCIe devices use the T=0 stream by default, so this function
> > by its name should return true for normal PCI functions
> > 
> > I think this function is trying to say 'iommu is bypassed', that might
> > be a much clearer set of naming to lean into rather than focusing on
> > CC.
> > 
> > 'iommu is bypassed' means you can enable ATS without having to involve
> > the IOMMU driver because the hypervisor will activate it in the real
> > HW.
> > 
> > So the names would be more like:
> >   iommu_viommu_bypassed()
> >   iommu_bypassed_enable_identity()
> >   iommu_bypassed_disable_identity()
> > 
> > With kdocs focusing on the main property 'a viommu that is bypassed
> > means the hypervisor sets identity translation while bypassed and PCIE
> > ATS controls ATS behavior'
> 
> Oh, whether we drop this patch or not, I realize that we would
> still need a helper.
> 
> "viommu" reads a bit too wide than CC. Since "confidential" is
> renamed to "cc_private", maybe "iommu_cc_viommu_bypassed"?

Yeah, maybe thats OK.

From the flow it doesn't actually matter if it is CC or viommu, but
those are the cases that trigger this..

Jason
