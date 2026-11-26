Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.26
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795705044;
	b=o9T4eO0Dyx4LxrGHEcURQM6162lllXOev8e449CXK6rlwG7GWAfCZj/L+bFKmkBw5lBz
	 JLTNbEuH0/kbzFVSyRIPnScjHRWl6eJdKXV3sK6u03NA5nIpOMJ8v1QZNgxTqm2NdAoTY
	 l10U3kcBa/RdsfVwW8F/q/F/B+IGT6seCPogwUWcEvbxL3N2E7SMN0XeuQhy14Sv/iW44
	 V26gm8Rmbc1y/NEN8CBXcp9xfpbAKbyiQc9pRI256o2zuWI0PvbixtbGJ49MPJzyj5VY4
	 5Ba1C2/dSUbBNM+qiAv01D7nTs3QqWEO+DeuQZD/D54T1Herfq/jM1t70dFuo+Sxgzw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795705044;
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
	bh=l939RF+Ks9Dtx1gdslC3Fzs4rnwdWZMh58x80xnBVpo=;
	b=ZRO6CdeOx9YLgc9wHIj9twAsk7T/u+I6FZYWhhMMRoQI/NC3Pb0nkjX+6ToQgScmSRGs
	 lveSeFh2GfgD8mUb9YAPeZrjCxGCicKgZ69/U3PfPJQ2VmV7r4GqFtLWH7wMhPLnckbzY
	 1p31rS/WHwwsF4mZwbcgt3pDX5MpIqiPR0uQmsCQmoe7kr7x/smgYa/b1q8lSPBXtEsLp
	 eTxtYuXNG5AQ49H0VtZK8cIOnyg7FLT+WMsy+ilVhE+hM1X5rW7UCJ2oHxkkddEyv9kSM
	 9tkHEjyIbVmlRqZFcJfcvgn7nnUMav9OK780np/cTNcUuieDR4JA2RzU82NmQvGaWig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=NzCUj5UR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.26
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010026.outbound.protection.outlook.com [40.93.198.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7E3606A33A;
	Thu, 26 Nov 2026 14:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E7E3606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=NzCUj5UR
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i1LNC0PCh2uL8MXBgj7VMnS6Q6BnnT8mZbicybk9AQ6ZQwHMXVUmzp5EsZjsNeH0K2uvVUO84xIDeDw++J7prrP8f17y53ryVoYsUyfqt7WIS+XXhExWlCd27dQrtgiWdtfX/ctLLUZRkcoYPY7qHW9DvgFFceTiUD2yKlQN2TLY8yUMHcwJH99xdZ2+lEIvgrkT0WG5mRRDASj3MeCG4z3ZmL4xN13buy8u4KVHQTPRSEEsbUK0xKWUys899r3A55Gt/TvRcHMiBwts9R1OjYSZqfUqCMXyj9lFFGkf52zm8E5CUh4NepXneiIeIR8gFuZRemJNLYQ2XUUFb5XGiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l939RF+Ks9Dtx1gdslC3Fzs4rnwdWZMh58x80xnBVpo=;
 b=teP3pEwmfO/OzqHrUy2hRz6ly8R17YEGkXaWb9Oq+aCWGf1HWtk63Ywcm5O/A5Wswg6yWIKdhXFKDrxm6WXYjqIKbdsEr51DZOGgeRUo+g1I3yfz23jUzf2EMMmsbY2bEhRxkQj01UUZPYNB+ZKP8IpZd3KRXKH42u8S9eymTiT7YECv2bqU7G2zH27putWh8EmIxiUSV+3H/6sh7kLisUq5UeuHDf8ud1X+FsMqRuXH70TbJ/uk3CDgD70GOKv4EpomHU7kq0XChm6VXt/DJKqTtu/9dPROGy6RyOjdvt9gp5DsFBhQW9CtS5l1qvpu57cEYy1KVAayklouD1gM6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l939RF+Ks9Dtx1gdslC3Fzs4rnwdWZMh58x80xnBVpo=;
 b=NzCUj5URvN2I4HtvJQlrfnxIFO0CAovjMMfNh0m8tpXEcl/VitwGJANkr6lhe8qlJa8qoEMbZtMzva+zeoRY8EpNNlB9MjPFbTLsGt9Gt4xSFID+NQ2HC/2UST1TfunIopzfeSYv+sIlx+tZw80G48jsREkOjTUAQi8EGrIfEYecL/1ijx393Hpb81bUzZ9vKe5O8nV8GXDTM7FsyzZPePyFB8V+a5RlBRSm7LLvl1P0+NwUvduT5bKTgPRlHQl/q6goKT/2bMFbZkz7stnjkNEVjiPxIgL6BJYP9mFQ9ZXJlj50gQ9+4d9GOsnCALMd4QVJJ23d8IydHIza7x8Y3w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by IA1PR12MB7662.namprd12.prod.outlook.com
 (2603:10b6:208:425::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 14:57:17 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 14:57:16 +0000
Date: Thu, 26 Nov 2026 10:57:15 -0400
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
Message-ID: <20261126145715.GG114472@nvidia.com>
References: <cover.1794343501.git.nicolinc@nvidia.com>
 <07ea92910895a2b0db33afefaa3a0ef182b2968c.1794343501.git.nicolinc@nvidia.com>
 <179563006502.253973.9155049351516451537.b4-review@b4>
 <awe6WgoiKaBTgINn@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awe6WgoiKaBTgINn@nvidia.com>
X-ClientProxiedBy: YT4PR01CA0465.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::26) To CHBPR12MB731189.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: e6aa1895-a9c9-4c85-7d39-08df4bcd8fdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|10067099003|56012099006|11063799006|261026140227099003|261028144727099003|261026121527099003|261022105027099003|261021121427099003|261021135927099003|261102123227099003|18002099003|22082099003|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	CmZD0251tjwKq5PRBBo9eF0DTxAXmbKuXH8RwKswDwDB43lgYl/9Tf/PfPdjsjf1YDyeSPOBW7aMUHbpZnhkMLmH0V50A5CP1IYHXWrNfAQndRK0VOF6n43Ahr1qUDWVB6u4jUO8K2Ka4DGXT9/61lGujQAb1RPKITwpqeo7BUZ46KCxkpo5tR9Xl7tcwxXeG/VFJ5ycNWfuzskVOJseqIJ+4en4xvRQuJbnl0nWKY/PtzXPt33vNlUboUmZn4d91HH61xN5jOhEz5Kl0TdhjooaTdgQ0K5BXVkbqJbKvGBZrDeT41jNV0HWe9BYq/XFavHjQHxh2y7+KkYPbXG2qz5knB3WU1oyVsP0dgvqwUX7xwx2dL+7IVFfK7kS2OhwH4WKybMjJxn9p2Ac+/gybC4CxxCwEVxUQQccm+kLe7YAk0yzhoH7yy8w1O0MoFY8N0qmG87g1sCGLuRzbFU5uYDK28muBW6W0J83t/JPRNDsl5tS3BJ2yjuc93ddaEBNZIA90gIV4N4f5OTP0PlRJxXc5ioJRJN3iKuqTUmF9cEXv8oQeLwnLmdgXXtfXOeO8gAQ/edmDtTOkWusRy+7/KGI1ZYyoTKZ+761OTrGrJyQKN29yLdUHOylQzcP0gq8VGu+b3sMTIsrgH1hk6rVf0utXPyUkcSec0HXaA8OdPE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(261026140227099003)(261028144727099003)(261026121527099003)(261022105027099003)(261021121427099003)(261021135927099003)(261102123227099003)(18002099003)(22082099003)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EyMGHvtmFdlnBfSOy0A5c3KmgUNDL3VqIBxwe3OYAQmKPfgD313pHGk336Nk?=
 =?us-ascii?Q?qzflcl2tntcz2b/hgZKCATTxkesJJ37d5RFSsjxjz+gBeXAb1sXFjqevoWZF?=
 =?us-ascii?Q?gIiVJZAAnmty0dIk1l+kFg9KW3ZGLp0rrv3Qdw+wUEcoj2n3Iy1YoqHnyhGo?=
 =?us-ascii?Q?PEtKfbhey02eEy5ESY/DvH9fZ0X2qJrnOZ2h7zA+UZjD5BpKumpktTx2eS/p?=
 =?us-ascii?Q?PvSFw0+YwdJYZfFjO+AMY+UMTqZcgXTfXlezXrmiOjXymZxdVvmImJQ5edhv?=
 =?us-ascii?Q?W50gZ9TpVIyUpYDiqUwmwrTIrlOtxvTOjIuLfnJ6qCUFUVUdrfgaRdD0HbEk?=
 =?us-ascii?Q?7GviC8YGR8n7A1BuSF7xN+fZjluieV1U7/uYrCXy5d4/0V1SDFLP/lWr0R6o?=
 =?us-ascii?Q?mu1pzdiIf79SvMCAZjkZYLk32HIk+0GWhEyTPJBqIVi8/YaybGXN9X31096B?=
 =?us-ascii?Q?LoYYhOiN2ZD4DAe1LKFR+jPhcDjZN9dK2Qk1rg/NB3zyJnQ4kMCcblJvcUyh?=
 =?us-ascii?Q?Qiu6ovr234YeGR4AjrqoXMF4zgq4FZHXdhYvw894eEOGSikJwczEOyCHFNJI?=
 =?us-ascii?Q?3cbsHQ2eEK806MGN4QUnJqKk6m9n7Vppq8GIseWcNDHqTuG49dQiCFuMQ6yc?=
 =?us-ascii?Q?XFkr7zrr8gA1bgE/TvzDiwG1mhMhJSo+VfHV/PfeBEYkKdGXO7eKzAKNyZeI?=
 =?us-ascii?Q?GqoVhuAexVviUC3xWtY+D1XFAr3N/Xwx9EIQYiqovoIwQHk5XHkmyfqqqaI5?=
 =?us-ascii?Q?Avw4PrXgxuOwaGX3G5R+r1aisb25/40LOSrWw7m/tvMptTC4VhRXBHeE/qR8?=
 =?us-ascii?Q?EKreobDuXcJStzwGLqxK2QD8xmvCJoKKI1X8HH0gV4ozfBAHw7kR0N1gcgMa?=
 =?us-ascii?Q?6cziGhY6YKjMOml+jDtCGBcAJEGA5IQcXCZ+/HXrY0SN2Kwcq4KG6zQJnWr7?=
 =?us-ascii?Q?QkUjhOxQEyWJ8+329bpDIPDHlzBZvRW3eBXtomK5t2Wib0rnFeDF1870hmpL?=
 =?us-ascii?Q?Wg3H1ukEMPMjTXleCqGG8c8b8K/HaMnofbmjHOY5vZZr2Ji6zCBcEvIOoOb1?=
 =?us-ascii?Q?PyFpZ878nbkhnZTCIjjWTRz8fp5S6SV6Kt7oMpBOEzu7YRDvSC3MBhqkTcmJ?=
 =?us-ascii?Q?6irTUuEbPovxSraFhx77OJKG+A3pouTQ/dwi0Dr3RTZg7WnvJRe0DfaMnW1u?=
 =?us-ascii?Q?Wa9HIsOU6/PhjYDMc6JwA45+O+pX44/5j41zQT1NiGhb8yPn1QRvTboWC3bF?=
 =?us-ascii?Q?3aXBS3gDN2RvqfnngppF9SAeCUltwuyHTGlxFuqmSMNP+ImxuFcCiILf10yD?=
 =?us-ascii?Q?UMS5uOcC9NEe/YK906DFOIvenrZgIAWeB85eJ51YLRm1ss0THOZcgurCpur0?=
 =?us-ascii?Q?AEj4orf5WFoAtozlkuvwf6juGAaOU93zPq05FjGs4emnkrVgmiOv8RY/X15k?=
 =?us-ascii?Q?0muhv35lYICMrVMtCnjtuHIwXxqobar/l8Z4ksC/MoC0U55Z+N93ACTt600F?=
 =?us-ascii?Q?zAlYqzt11vL8EIHKP1dhD6y2PUUEEE1Pr6yFsviTM+0A2muJjq2Myjv+RJQZ?=
 =?us-ascii?Q?etbYzAHc4gUorMRejDDjoh7DgXrlRwfyCIoZPhknBE1YgGVmpgYsw8NVStG5?=
 =?us-ascii?Q?5hZ5Ve9QbMuysV+pHVtyv94/vVbjg7edo7kzBifAwFubsabYfRSlMP08g+8w?=
 =?us-ascii?Q?IsANqUz/L80mW9VpwtCHF6rbRpF0NMdGqyyT2A7HdyE/yZSKqp4PSNM3SZ0g?=
 =?us-ascii?Q?gwwVRESEag=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6aa1895-a9c9-4c85-7d39-08df4bcd8fdc
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 14:57:16.5789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 00SdFspDSZDtTxKqEONpawg7JYXIIWDekzqJdJ6CBdgz++ps1v0stnDJ6tSuuEls
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7662

On Wed, Nov 25, 2026 at 08:49:30PM -0800, Nicolin Chen wrote:
> On Wed, Nov 25, 2026 at 02:07:45PM -0400, Jason Gunthorpe wrote:
> > Though I am wondering if we really need the ATS stuff. Why do we need
> > that? The pci_ats_required() in the hypervisor should force ATS since
> > the hypervisor is not going to construct a vSTE or use a nesting
> > domain that would inhibit that? Can we just drop this whole patch?
> 
> Ah, you're right. It was added for non-pci_ats_required (non-CXL)
> cases where the ATS state needs to be in sync with the hypervisor.
> 
> However, the justification/usecase here is pci_ats_required alone.
> 
> One small concern is whether VMM always exposes the underlying ATS
> state or not to the guest VM. QEMU seems to do so. I did a test by
> dropping the patch: lspci in the VM still shows: ATSCtl: Enable+

It probably shouldn't do that, but it is also not harmful. The guest
PCI controls should be fully ignored by the VMM..

Jason
