Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792672266;
	b=ajD9BLzq6AaNwzf1OYPoqwRu9LFJbb9UOVByIDMPxC5LaAi4LNGRV1tqrivRRBVhL+MT
	 EtmsJ8CHIfU1OUR1XHHmLRXMh/RsjlxPWP6llVkKVr9KU9BX3AuyGTHkf5132fedmXwFd
	 Qukl+jhrQSlbkG7BAczIOaH9hALKQ2mJz/IkpJgJpuPgqQ8qeJ5HOsYTWGkhvml48Dhys
	 pkUWDG/AlsTQ3+wei4EXhjn5COr9CyP9s3KZTmBBBPp6HzGxHbpdXyF2l5nrsl+lwceAL
	 a/Z3QMGLt6GrmFvhnl47MH0zZYHIDucEuxMCVIgOmQLHxnzwtO1kZLEva9JmzM21q/Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792672266;
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
	bh=RTyGLxnbCTqT6HIRI5lkLKq/oYEB5sAsVvEJDzosXo0=;
	b=UWl0FZmgv8YGSgHM2fHcEo6oATgDPahtBcF9Ym4pFLC3wApn93s27gJDxAsBb2gQEAX5
	 lsfSQ/QEMHSOuQzzynGTBpbTNoEXa27jC/CngoRDCAp10jeT7/AddsM/wUZXJfakDPV6P
	 MEpahLk5ssvm8QFnJcIhBByMRx6MtEQfqG7ophMp57cQSGk1D0A8OgCxDmAsoYzQJbZnd
	 8RDh6ys8e52MNFWO1l+rp9QGMOQ7oYr45rtx+S4v/zVgOWLy89HID2sU7jyOC43Lduosh
	 CXAFQYwv18Ull3c+Q92ryd5O/XLi+vDgI4hwyakxxk0LabHR6bHgaipnC+rue/97z0w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=UYUbPTyZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.49
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010049.outbound.protection.outlook.com [52.101.193.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ED9606A31B;
	Thu, 22 Oct 2026 12:31:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21ED9606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=UYUbPTyZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NGjdyKehaSnV+KJztIbsIAprjJDmiuGnzysoIh+ATnu5ZtOY6qx959jVocHVqs6GPZ7QyBqSomQOZ+hCRuEuklkQH9IhpgvQHFtQzBaioDP9x9Z/NLuq/lR63t+amVaqbmyZrnPQmRppt3bP6Pw/f2QCGba7p/LeacKdg52ezzp22KASEz2zwzYrY2N7mGquNqWL4Nh7tMVLYLaNqsHwVLYrXHxUUC4DeRzxJwMq9XSOH/twjmdbd9K3+5EseMNE7P0QQg+c9nySQJBRbzt9lpxoc1JrfNxRe1Ar302fP5mITMrwK60FJ8+PXANguVy4YJpM8iyNWiP5WfqRyZgrgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RTyGLxnbCTqT6HIRI5lkLKq/oYEB5sAsVvEJDzosXo0=;
 b=cD8Taa1+lMkIi3fi9AhHCj8xmYfodSGe/PcNlje8b9wagaCqN/Swf3D6M3fEoinaCGjr1aM2UaR3ezPDXP9QAra2UY4HFUkXZfkRJBnktwpeFyTZLVi6f3c2dU4Gnz61Nh/2TSlPadQydQK/8kJggT7EIjrrReWZrKh5t5XpsHPyFm099FYKluUXLXskpRzh0RAQ46OYAEAVZOhUauNBO7C1jrNaukclPAvQiw/H9MAqgZtfBF443bqTnUsOWmjmKtu7/LcwVfB+ZkbuhSykvUDvuspifhabFk7ahmxY1cmywq8cUpBMJXct8oKE9j8jxVdBAIHjz0g90+NvdBPdEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RTyGLxnbCTqT6HIRI5lkLKq/oYEB5sAsVvEJDzosXo0=;
 b=UYUbPTyZiIy+DCPqBhd4ffzcrbzunVgiqL3mewdpp9aJ8fvR0bMQ7s82dU4wKsU1dYwpuZvSKcjb9hlHyOXh9VM2TJQCBe4El1gG+sIJ0JwVNqY1LmY49Q5Hzj05DMyAhsPmX0zC02ZoCJ0bwmZHMRu5Zj46GA3D/jEztPT/0Y2IKa5jBpPSMvWH4LscZqfgGyKSCrXYJCZcTS0StjPAk30BEEX0M7ZwrmuwYBWp3I2Kh+E9fubLMWdRMFr29a5nSRYFILI6m8LyndFWfpVmXvo6AJ9U92w9kQgRuR3GyT5SkTX0dK0ZcVTkUa0tByBMHiHKLpFrNVEaCiIiXNw0TQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by LV3PR12MB9095.namprd12.prod.outlook.com
 (2603:10b6:408:1a6::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Thu, 22 Oct
 2026 12:31:00 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0546.016; Thu, 22 Oct 2026
 12:31:00 +0000
Date: Thu, 22 Oct 2026 09:30:58 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v6 09/11] iommufd: Add the vdevice TSM request ioctl
Message-ID: <20261022123058.GC3008132@nvidia.com>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <20260917140159.1163281-10-aneesh.kumar@kernel.org>
 <179027891417.104879.282447770434616733.b4-review@b4>
 <d9304f91-2371-460b-8616-15a4f96c5674@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9304f91-2371-460b-8616-15a4f96c5674@amd.com>
X-ClientProxiedBy: BL1PR13CA0395.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::10) To CHBPR12MB731189.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|LV3PR12MB9095:EE_
X-MS-Office365-Filtering-Correlation-Id: 1655390f-5aee-4481-3551-08df30385473
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|4143699003|11063799006|56012099006|18002099003|261009223027099003|10067099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hMe+yJxuYWLQnN9gnqW4b+N2AfDfDtrctjsHzL/BOXLpQZv/jNtQj/1PcQCCOUMfCOHFPdQ3jcCn9GQzY8S2LFJCY+khielmnB3VTZqBm0CXVJ7tRAE2vuA7v+pKT2/WY1n02e/1HMGHITyPdtHl3RulinCyqs/DI4VPQfr5/eqZ3T21WtYrHpDTxMPX1+7bReFkxAPUYsoLykPjzy6ytMUtI6TyCcDoGGKnyD8T311XcUBAsjmuEIKA1JdR1oUJwpQ+0Gj3P6r17mF/axB0vZTz0gXRzif5GefHiAvKu5NLVL+FxSAgm+QDpJvVWcu0KSseGCLW3oIoWEeSpOq7MaLpl1gzlztHViAvTzB1cJTguCvzOjH6MJcGW1pvaQTj3uNE8H38ZWxLPjeSEAT3mfoUWC39sA2V3BC9HVnhqbCxtjCG1q8XQkgjzEdb9sTn3ZJAtv678LMq4adamyzh80Z8ICKmouUMEq8u0aVB60T9nwFTXgM/2LQvATDJsQKWBhmuH6l8k5LYz0Ng/hzpo6gb0SHkVdfrrK/YsL8cRJrZ1VeBSFrdeJWK1TobXnodQ26I2TlRC6KDChvrUyeU+TER/J5cVL5f+fNs+XGja1TGcJy3pXXc5rwVaHPh4DLBknUy1YT8NQnUDtZTzc5TzfPtjm8m33UXXoGxuGK1g7U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(4143699003)(11063799006)(56012099006)(18002099003)(261009223027099003)(10067099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZfOD2kZymtuLDeSKd72v8EI38xZHZ2C9xEKK6bYwQcZza0SeKnuWeo62kiD+?=
 =?us-ascii?Q?qNYKn8NxR0ntuLzVgh8bTC6jLAlPxWjc7NAOE8kY9sV93rbULoRVyClgNceO?=
 =?us-ascii?Q?UUnFOZXSFPlrtBb6qzdNmMdM75EWPWVZkgwEGD3XjTrPj5msLKev9e2xVg8f?=
 =?us-ascii?Q?V5dGpRUDFIPw3o08kIws0r9gxsAUNRhIiC1qcC9eob1FacFx/Zp489W3AG81?=
 =?us-ascii?Q?H+FGVecYZlMnHUyRZN5KtnN525XktkRhQvaNtB1VUXZrlRxqbZdK8JD1oStU?=
 =?us-ascii?Q?jzbElDhwQcftEn2nlWHr9DEmH5y6Q2hC7aaugDnYgXAnjKUPvkSRd27LXFUC?=
 =?us-ascii?Q?wyOfskx6D/uK1mabrq+5+rYsd+7ir3hK5qbDoDKPFYm9B12kAu7HrfqC/OYc?=
 =?us-ascii?Q?AMgQfE9mFzCzrZ/u8341ZQ8GvwGqZyftBrOSrjXyZxarBgn2plPG9zJqZOc3?=
 =?us-ascii?Q?nL67l2qZ9xyMjaCw8Xo3WT8NiCzEa1zjeiMR+AMK3Obqsw1Vr9dhGRMbb8lf?=
 =?us-ascii?Q?1J7f8EP49VY+38OFgHCvZsLCqq5VlIfnHUXXrR+ecIjlUPuZzzG9lIIi9Hmf?=
 =?us-ascii?Q?CiyWju2CPRDWgtzCWKIK8DJHW8H1ZvG9Z8KBAYmS7I0x+vvkUVbXc/dNJ4zc?=
 =?us-ascii?Q?l/sOe/w7lQ9BY12ncDhXZ7ri11WXR4D+6o3S0FhgSwXkQ6fqXfIBQUTl3DmK?=
 =?us-ascii?Q?RNsl/iV31vUi2iSxdjRj22+btMEgdUVCWaoQMP+o/3Gtr+QKXhZR8LRz4C5u?=
 =?us-ascii?Q?mgaa6Uqrw3WZbIj+Dya6xACIGm2M+OWt1Mw619Nv5cV1j4ifUCDFHFZilujb?=
 =?us-ascii?Q?cDYF/DgTm5nAUYk8kjqB2WTxv1LUxFJOSVHk/ZoJ+KTHRXBaaHUhkbapct/0?=
 =?us-ascii?Q?QFjQ6d6C+jSnI5V8Vm05sDQtkNo9OV7cZz5TNF4Su3xCOreYrtOC3QMFFgda?=
 =?us-ascii?Q?3iRA7487BxHU990egAcxiUBhAtzmbMXweCb/yNI+x7a/XuJON7iq4NXuecHj?=
 =?us-ascii?Q?OhaqJEOm46At48qo8UqO3iCFVVhekUdlsmGNLMiXcK9mFkf2rKJZSyfnR24M?=
 =?us-ascii?Q?5xJgx8GiMIUyLn/XA734vRm/IqxWzlDMyuEFnE8gF/2gxy55K6qJVA9qzQvI?=
 =?us-ascii?Q?nhDXZhjS9EmGEaiVYpydnTliL9CnoKRfjiyee+sLXtbbnVqRxiljsq8Uim7M?=
 =?us-ascii?Q?Dgr4Chtsnw81YPDM5OHB11P6iq6gOA3kTVhFbE3U6z9mgLm3vpTdC/1ldReN?=
 =?us-ascii?Q?zBs2L3Y7m1y1Hm2Z5eJgkfyxTo1mG5JJP90VjurhZ3Cm3AEAvTPCsiYXGRXO?=
 =?us-ascii?Q?hyl5irxXcIccecGt77svAu3+BiG6+zMOxQgj5aBn9+M5ZnQn+MSLK2n0KqCC?=
 =?us-ascii?Q?CzseDcqFfdQjQkKYUIc/Sq22SzbLDKLaCBLmYhRdtve25/ign79rnLSzOCc8?=
 =?us-ascii?Q?XsJWifqv7Web+8PGhACgghGGdmbUMPSbnVLqBo/mbWcy9UqPZxoPxp732Pm6?=
 =?us-ascii?Q?4Ljk/oZV3yVm3YrvG0pbyDLkqz3lZHy7dIBmytyIghkSAM3XEJnFD6Cziz3/?=
 =?us-ascii?Q?fqfI1Eenh7h4YpsgSQSjdEVzYDwMYcf4pCm/AeozwKXexqF30xSkHv+8V53l?=
 =?us-ascii?Q?GhuSuUNUL2zcZbSRurTQyJ7sm01IAdVZixodg6iZ9rHJBehLYNQRAM8BLdc8?=
 =?us-ascii?Q?RyKmjEeg5F63PfigAeHgyCIEXa1v15ULg6D2eotbLnRZ6p/K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1655390f-5aee-4481-3551-08df30385473
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 12:31:00.3900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s/bsln4X0arI7in621dUeFXFdbCjm8LjRrJUMqD3Yv6NeJqNID5OYVzgJzbCcD2h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9095

On Thu, Oct 22, 2026 at 06:16:04PM +1100, Alexey Kardashevskiy wrote:
> > > [ ... 34 lines skipped ... ]
> > > +/**
> > > + * enum iommu_vdevice_tsm_guest_req_op - operation for guest TSM requests
> > > + * @TSM_REQ_VALIDATE_MMIO: Validate MMIO for the TDI
> > > + * @TSM_REQ_SET_TDI_STATE: Set TDI state
> > > + * @TSM_REQ_SEV_ENABLE_DMA: Enable SEV DMA
> > 
> > That seems wrong.. The hypervisor should not have control over T=1
> > DMA.
> 
> This is a guest request to the PSP which does control T=1, the HV is
> forwarding it and does some extra stuff while there. Probably could
> be decoupled and go to a separate ioctl().

Presumably the guest request is encrypted/authenticated somehow?
Otherwise it is security broken if the host can forge a T=1 control.

If that's so this should just be some AMD_PSP_AUTHENTICATED_COMMAND it
doesn't need more detail?

Also, reminder, since none of this is actually multi-vendor before
anything goes into the uapi header it needs a concrete public spec
reference to what exactly it is carrying through the uAPI.

Jason
