Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793299639;
	b=yQTb2ItF6gmn9zdqc74iApXQT+ocUcQXoixg49pzr00f2ow1gYokqZaq3yYlkX3C0PZt
	 6rJrC72YBpc5ndNrVL9mok995uRzhphRg/8Rs60cRvGtaOjje06XQ9v7O46iXpXFfx8jd
	 KGI0GPqcnRy5qZCgarMtcZGHU8Ns72LDe7ATaYT0I+hsaCtofwEQOenzLnmzP706VC6fO
	 kdqWMLSj9Odo23OT4He+6CUzDDv9wlGKlEgjZJobkYBW794oCauU2YjTELHR2oasm2LQc
	 jRkCU3K8jJiMDSTLF0yNEWnst1Qu9PX3kpWBc+e6ALqbafC4bWhRYZdJoZbJV80C1IQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793299639;
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
	bh=shbrpUA6y7l8WbNh5RXfpZF0o65hPQTvja+lgz9Zq9k=;
	b=YyDU9ammWC191xzd3rzRkyEqQoKLeuMNTjR6NJc5Q0cRZPGvFL5WI/PX8uM5JlBOPx/i
	 evAxX/RW2kvt9xyOeWYadNYZzufqPULj/BqP9qXa/Go5eVIsduUDY0xy+z/45FF7pMk5w
	 CZ6+c78XKp9dX6ZxhjVnVh6C7FrOnZ1JUV7k2nuDoLkRd+zCel+GusXUA9gRP82nXJM6E
	 rLcKB6uTru8hmg+vm9YNjDCaSw9RGW8HZaQKMO9/7Jir3xI646kPXogljDwhldHSWUekL
	 Ts+KSH7h26NnoDdFXDnawUAk89nHeXVLs7Vytrt4WWtuV31vE0PbA2akL9xY/CoAtFA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=odLdbGOd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.29
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012029.outbound.protection.outlook.com [40.93.195.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ED8606A31D
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 18:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9ED8606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=odLdbGOd
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JrF1ssEXCPF8qYngddS5/Y4IUuNpaTAzkkDfGerjKH381IF0PbIHFVAknkuy2qQV1gNpOeKM12vkFDZ5+29U+ArIpxmJXDoTnUGjbuV36gOdfumhi+zA7uJmfQ38XB8io0sKC6DSKLdc1sKKqCKhO/InCpvn7SiHz9YyIZm2BY5XfM/tHsEaDTzgoll64ktccR3JgZ0Cq1PsxZ4zrqieUcWMz4p1Uolz7bwrR5BZIIpqiTfCZqIjwirEyOg1rZoRtoWOU84d+2G6kviBsW9je+zhAtEvMmzCx1i/Yk0zsHwCALvLmmw0jxI3kdSRxDaFsbp8LDjl3WAGzJsjSUAa4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=shbrpUA6y7l8WbNh5RXfpZF0o65hPQTvja+lgz9Zq9k=;
 b=F+JhNRRddmfOBRNBgKAgUlP3vuro4RhrOPBYHyaZK9E+6pb4FMbCDwq8Ns1NYHXbnIppXbNXmIZ6UhS5zWQ/uhrmvzRqjUe1w+iLhUq12m5mU1rQT1nFFDmxhvnS82LhiihyKsH4UL1nRgqq+Lq5yxxmXU55lcpe8TPW0gOBttZSUW6MD8T04gUtXCADBQqzm3DAxQ/MJhpLLRjkrRp9nyCElaw4H9AajUm6t/WMaiq2l+v534o46MGVLjWaG/zwNPefcbdly8e53GR32Yc0tquiqy1pbWSNl9Vh4j/1ohmk0BM4SRJD3ByCS+x7N87A7llcrEQubIR+uABwrAJWqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shbrpUA6y7l8WbNh5RXfpZF0o65hPQTvja+lgz9Zq9k=;
 b=odLdbGOdjnEunyfybwEmjqef0khHoeVjdGW0VctgkkvMTmroa/Q42o0LBqn7CbIeQlpgEtHnUolMPwYissmtrevDdzIi38L5PY+XmPF+UdP0DHaiO5gBrs2gkY00Vxpm1vN6UyULSA2EU3S0OGt99+NFxXJ2snedI6JsE0lAVzAscInKo29rC6ss2TqbtVawOrmIbtIaMX4Z7Zdd5VtcEHTLnh2ddeZyQcnxYmtYhCn70C0B3QSLOzttdzqlPYvRIQj7p8Ekv7zRolHnVr5VQqjq8A4LDmQAvHpKP27NCLWNvMd7wulXLq9Bbo3L2rByqyawe8k76Ja1AyAIhEMO9Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by DM4PR12MB7694.namprd12.prod.outlook.com
 (2603:10b6:8:102::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 18:45:45 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 18:45:45 +0000
Date: Thu, 29 Oct 2026 15:45:44 -0300
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
Message-ID: <20261029184544.GF3734323@nvidia.com>
References: <cover.1790718296.git.nicolinc@nvidia.com>
 <73ebe081ed668c214628fffc546b9744b662afb6.1790718296.git.nicolinc@nvidia.com>
 <CO1PR11MB4835DF015165BA9306D022178C6E2@CO1PR11MB4835.namprd11.prod.outlook.com>
 <87fb7a3f-b6a8-4683-84e0-1b0d04dfc235@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fb7a3f-b6a8-4683-84e0-1b0d04dfc235@intel.com>
X-ClientProxiedBy: MN0P222CA0007.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::15) To CHBPR12MB731189.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|DM4PR12MB7694:EE_
X-MS-Office365-Filtering-Correlation-Id: d6271012-23cc-46a7-270e-08df35ecd778
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|22082099003|18002099003|261028144727099003|56012099006|4143699003|261009223027099003|261026121527099003|261022075727099003|261021135927099003|261022105027099003|261026140227099003|10067099003|261009221227099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	Idhn1WYkoxQJSwfwe3QoV9/kVcWjONv1C+lWQUlmMvQcm2tauhxE7sglkQEMNdelL15ZYYAm8Gt15nDnyLp8AcN8faEQh/+uWG6+4S46gSSjRomlgjWrgZDxglUmIftXs1fe9hjhNTysbAfIaM2syRa0uV/ax7RAaLozI01BerodI9Nwbr2ajH8vTeb4qfQuweKRAvWFCjsiRxUZeXgLaHbjlM3Pjnv8mtbNq+7/lfE5QLikf3z9GgakOmpUcuCDpqWqhBIl8+p7MlAPh3SNz2JtsxPUfaCe+SSj0z+YN1JZu7tvRu9LE+Vn1JKr4KbJ6yoFahTWql8A8hblZbsb64VFnVxVN7zlWyzxbX+V/FDNggfFnJEuRcxOkWJD4QbKiT94EL7aWUjGMPHtUlRmgBcK9bRlSQ0uwHTMAoP0wSfcyihFzcmLf+OT/gwIcnlPOnXBr3xp5oKNiV5PWWEGKRA/U97hnZWqnHgGc31Cv7yd9dl/uARxLJuzxZnTz2OiBUVv/0wvESVHzlq1xL9hNGoCNmFl3LN15RCXqY+bSfmrxYIxIoHnQaQdy9oSsIOgIJlaPuxRxR0ruRQCOKwlw+nYHR1SUIxMPxZ6EJf2tyDaJ4P9NE//Fgu9BdkOxfUb+I0FjBg+gFE3gNqQTpAXlSVvAI5/nZK1dFLLULN03iI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(261028144727099003)(56012099006)(4143699003)(261009223027099003)(261026121527099003)(261022075727099003)(261021135927099003)(261022105027099003)(261026140227099003)(10067099003)(261009221227099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VwSyqgCuXtNorfJpf+fG8g4urrGaxpDq3wpSVw/Da23JwjgUVrKiPZz3j/tE?=
 =?us-ascii?Q?VSctcqvPF1iwtUUBw86fHtoHXuOIUu1bRxguPh9v6p2wdGqZ9klW+sUXSDeN?=
 =?us-ascii?Q?Qh4j8UbD46EWdKAFAvs/ys35f7vX2NKAFmzZ5MbzPl2iSay7DNw59c2FPC++?=
 =?us-ascii?Q?zhsF2Fe3uPDwTzwnb+TPj60hmQ0FqKEH3JHoTxsXse/FpPR8HcdRNNOKEwOw?=
 =?us-ascii?Q?n4xyZEA+qBBj2eGNas9H07yt7jLmEuQCpkSiORo18GkcVkh0pg6nwjWeyV9y?=
 =?us-ascii?Q?EJx8cAPrw4GyG4nIFMj+QTEv07Sgr/zA59j8Z08zOCmZYngcx0knmDeHoI31?=
 =?us-ascii?Q?nKbULTSgX+MjM/0K5xaQbtSGt+rZAV7/5rtpDM8PGWsTIly7LpReM8dRmy8u?=
 =?us-ascii?Q?vkVr6fY8OMqjbc2OMu48fDpSHN+RPSe6UEGei59u0/ZT9mKPaT5vDQI3+MH7?=
 =?us-ascii?Q?brnHOL2WDtng9o6W2CwtIWSYukXzipzsTNdJsk/85YdJyxDsF7dKb9iPSfXj?=
 =?us-ascii?Q?oNsOlDS4H2eQphxgqkeqkTURuZtNAXJSS5yY5azRPN7aQoz4500VEGD82DON?=
 =?us-ascii?Q?ZYyoHLfNR/zSRZ3a5M4GpunuKgz8Vg4oKxehDlD1FKdpIqQItb9hPygWofSx?=
 =?us-ascii?Q?/4eDefg+LQoMYvJzMLs2hbFVRiuQg7EI6PcSyIHL+HX2N6bYKFcvezI8wRed?=
 =?us-ascii?Q?J+rk/1UKLYvasVOZHXYj9y1u+3E6Z5eO7kHt9SQUV5lTxiW3wq2go1n2zoXZ?=
 =?us-ascii?Q?Q7wLN8Ny4aEV1nwx2+oyhKMdIr2flTD43hHt6i82REU7Q8yqb/UDfo0ZRBVO?=
 =?us-ascii?Q?GNUo/l3BdzYXhkKjvH3NgKYj+dC0uWZknGkFZC0PegDdXU+l8W6qVib7q9tQ?=
 =?us-ascii?Q?plsfgIl3QWBijPn2fti/h9Z3aFFUGxwoTLSiaPwSqBFI3ipZWbpovoXy2Vzf?=
 =?us-ascii?Q?p/0eXXAbGdNq55Wz4nynoTJeCVTMjXRd842LAgiFSBFy8hKD/1IYN4k6EMCj?=
 =?us-ascii?Q?iA95eMnxbagQga5X3Jp5EUNLRb9nR4cEMdei5bHDKlx4+cYP841N6nxc7XUQ?=
 =?us-ascii?Q?9VVTSPlLfy7DXLq9YdB4e2b2XKeFsl1rlGYkYIJhPvR3h+HaCFAYo8N+Ios6?=
 =?us-ascii?Q?rQZfoW/6lM9EUO1NctJx4yXqKDP78FfLlHmhEGw91NfBQjc2wN6zGuNQjKlT?=
 =?us-ascii?Q?P/IC2RYm2OfaSvfl2FC3gv2pHPN/8kTzCT+HYeYg8KJCPqGFrV1r3FVwxk+0?=
 =?us-ascii?Q?9UdGPVEazxvF4oXpVW3AeMj1flDTSVdXptP/wWip7gmh1gEEH8rSN160eHKR?=
 =?us-ascii?Q?r6dFV9EVJlAV+WkK2+l4+O67gvWcyMPIurx1Q6eFDKaEuWYX3HcmxseE/JXj?=
 =?us-ascii?Q?Qd6rhfgz+BB2bENWJUhCC2OPCohrGUmzariA09Jynvi4W1l503VLklJH29D8?=
 =?us-ascii?Q?niQ4vcJSBe8ve/9VIx9FXyJQXxNP7eIITKuCRIt66vUkr9mGue9V+w+rtgeh?=
 =?us-ascii?Q?QMUYDRN2AFmkIovZ/Qkb7ezeK+KMztUIUHvwMon6a+B5Kk+MLCd3Tso09Nec?=
 =?us-ascii?Q?P0XofdwxIKJEw+/oQw8Pl8q01F0qtmBTxR/tGz5jjFtLuZBfof3TyKdJZAKJ?=
 =?us-ascii?Q?0WHLoNQXL5LC+2OzWyyQ4/GjojCd01mr2a/DSd2xOY9eqsuyn7GQFNU2Nbhp?=
 =?us-ascii?Q?v3tOW+RiykFBt1JKosWFxyCH0POvmUawAcfdgjvcH+uxbrwr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6271012-23cc-46a7-270e-08df35ecd778
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 18:45:45.4344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: It0asX7RljbMvgsNXw/aYw7Akl+8rarBcAmDWSPwUMDVo0GOpvr1+W5np7YvI5tA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7694

On Thu, Oct 29, 2026 at 07:00:18PM +0800, Yi Liu wrote:
> On 10/29/26 15:25, Tian, Kevin wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Wednesday, September 30, 2026 5:52 AM
> > > 
> > > iommu_replace_group_handle() looks like it hides the detaching handle ahead
> > > of the driver callback. But in fact, xa_reserve() calls xa_cmpxchg(), which
> > > stores only when the current entry matches @old=NULL. For a replace, there
> > > must be an entry sitting there by definition (i.e. @old cannot be NULL), so
> > > the compare fails, XA_ZERO_ENTRY is never written, and the call decays into
> > > a plain read.
> > > 
> > > Therefore, the old handle stays published during
> > > __iommu_group_set_domain()
> > > and only gets replaced after the call. This creates a window, during which
> > > an asynchronous fault path might hit UAF:
> > > 
> > >    core, holding group->mutex          fault path, no group->mutex
> > >    ==========================          ===========================
> > > 
> > >    xa_reserve()                    ,-- old handle stays published
> > >      no-op, the slot is occupied   |
> > >    __iommu_group_set_domain()      |
> > >      driver attach/detach ops      |
> > >          iopf_queue_flush_dev()    |
> > >                                    |   iommu_attach_handle_get()
> > >                                    |     reads old_handle
> > >    xa_store(new entry)             `-- window closes
> > >    mutex_unlock()
> > >    kfree(old_handle)  [caller]
> > >                                    UAF: old_handle->domain->iopf_handler()
> > > 
> > > Replace the xa_reserve() with xa_store(XA_ZERO_ENTRY) to unpublish the old
> > > handle.
> > > 
> > > Fixes: 8519e689834a ("iommu: Extend domain attach group with handle
> > > support")
> > > Cc: stable@vger.kernel.org
> > > Assisted-by: LLM
> > > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > 
> > Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> > 
> > btw I just realized that neither old code nor this fix can actually support
> > replacement with lossless fault handling, but I don't recall whether it
> > was the original goal (then destroyed by a following change) or intended
> > to be a future enhancement...
> 
> There was a related discussion[1]. With this patch, a page request in
> the replace window gets IOMMU_PAGE_RESP_INVALID instead of being
> serviced - spec only says re-issuing the same PRG won't succeed unless
> the mapping changes, it doesn't forbid retry. So I think this is just a
> more conservative instance of the failure case Jason already called OK
> in [1], not a new hazard.
> 
> [1]
> https://lore.kernel.org/linux-iommu/20241105151042.GC458827@nvidia.com/

I called using either the old or new translation OK, using neither
seems suboptimal. So returning IOMMU_PAGE_RESP_INVALID doesn't sound
ideal..

Jason
