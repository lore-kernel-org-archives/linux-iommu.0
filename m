Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013061.outbound.protection.outlook.com [40.93.201.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFA83515DF;
	Fri, 21 Aug 2026 15:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787327791; cv=fail; b=O5XVkl8q55xZG8HDSmSHYU6mTZQzXs9RlcVCu4a0lsnYwOXezkgjmKfncjx8AnNaGVHUeSPYrwZFldvXpto0EN2/EqrctGuT9HbfiGy5HECcR2NWP+YyHgKGD4VBDhQS97MmQddioeLFggvO1mk9smno4CGj1eCDVi0SJ1S7VJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787327791; c=relaxed/simple;
	bh=9+f+Qr51KXQi+RcyNWqp+Kr/JUO/DJqV0hGg6LIHt6o=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Cwdn2b8gPBEDAxnqTxdIcyXj8imL2YqNlbKHFLLGxjpKlu0M+Rtku5lb9WIheefs7sr6HaT1jGRp5Mdl70V8GjkJJzTYHFlQkTK4KTgv5/SrArcMO19GMxAgrtp3VUiwdffbWqDRY9SMx9V61zRsShSwdO42fnTGp17iKc3jmRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iD9pQCDj; arc=fail smtp.client-ip=40.93.201.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iD9pQCDj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MInZNLEWRZxNOtMPCL9/3+vNtuGHab7N4z+xa0D5ShUVEcvILYul8jQx0sgBYBaowpc6r970DzO8Jrpbx7froVzajPSW6fks9H/6KFV61G/wHkgX7jjN1j44fvq77gQCzT2ZC3imoOkyj5JQOw7mb3rQemnOr74KwA8rziuJi2jitqtiuRDEpDJvAZRg0L/8KTA2NkPvCeyiwtGZdIFP3GXsJxb9IDyl+umYLnOSnGQiZwgcMfUwNkTdWWXh90iPlzICyV4w20Fby6PcEkyOC3xZKAtDMFo/gJ7WZO5nuFvs/uFKLyXtxRuhJqzIgYYVlpyN7WNpX4Nm0HvbrJ4S3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5PtvkfEd7Bb8p5aY8iBbrul010TUX47yZtIYuAHr0I=;
 b=OhPosXtmmHigP+v+CQV1oHeJTMXFvDbMGQ9zYZeib3Ex7uy+VrfafVLjdEBv416pkwMGhSfspzXHKawV+beHgNP/cg+rqgu49zI3vuG+vkvalvJRryWy7BGgdR+5rJRXFcwb2eKE8fz6YNt/C5s3VmMW8CH4eNGKv7HhUSnFz48MmBtWJS3GO9wbxradWs1P3nclhjaBlioNAdKqPeitw78Cuc+F2J7NdQ6kxghFNJBfO31j+LwSmym38/gOfYy4h2oHekxMhL+4NyICwdo+M3ojSZH4V6wc68kJo3721GGRm3unMPYQ4Rp+/kpPlqBwnqe8g34zDZqJXCqlqt6IKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5PtvkfEd7Bb8p5aY8iBbrul010TUX47yZtIYuAHr0I=;
 b=iD9pQCDjSadW1m0zn6pept/i7tB6w+RM9xQfJjyna8pTtUHZchFg3CyCZ4mJodDQcPi5UvdhYL9+PBKQYjgEwVtD05xe4ES1476tH2PVDX0MdpUqP/SYr6OcLtFPsL47LbXVnrpRs7X0F3aluhr7L6Mse5oIhn3vijXBNsHt6rs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by MW6PR12MB8952.namprd12.prod.outlook.com (2603:10b6:303:246::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 15:56:07 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 15:56:07 +0000
Message-ID: <6f4c5050-3928-428d-8d0b-5646f2333b15@amd.com>
Date: Fri, 21 Aug 2026 21:25:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] iommu/amd: KVM: SVM: Rename ga_log_intr to
 wakeup_intr in IOMMU interface
To: Sairaj Kodilkar <sarunkod@amd.com>, "Borislav Petkov (AMD)"
 <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Breno Leitao <leitao@debian.org>, Christian Brauner <brauner@kernel.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Eric Biggers
 <ebiggers@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Kiryl Shutsemau <kas@kernel.org>, Li RongQing <lirongqing@baidu.com>,
 Marco Elver <elver@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, Sean Christopherson
 <seanjc@google.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Thomas Gleixner <tglx@kernel.org>, Will Deacon <will@kernel.org>,
 iommu@lists.linux.dev, kvm@vger.kernel.org, linux-coco@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
References: <20260821055611.27138-1-sarunkod@amd.com>
 <20260821055611.27138-3-sarunkod@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260821055611.27138-3-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0109.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b5::14) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|MW6PR12MB8952:EE_
X-MS-Office365-Filtering-Correlation-Id: dc73817f-9971-49ec-40fb-08deff9cb695
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|4143699003|56012099006|11063799006|10067099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	enNDqKukRHb9Lh9a/lusGrffLuqqFT8ILqJVMzEXATnQd8lhmwhS3TP4x74xbUZMJZVT6hG4F1OFwfCv/K18s7nOgp2C/nkVNuI1Iwq4gsJieN1C1oJneU3GcH/4wDNO/TOaG2C26U95Kkh7visGu4SfdlFdThoALH/MnTjZQhBOatHKXcCdbXWufXFErZ8qWa4aK0LwjVHcMlrdOJYptWvlXKJgvGdk4AlMUd4WxJkZdpW7S5JTIlUIn4yT+GTeLVbd/T/IgpcOikcsU+iCqL6EKv6W5JWgp8wpkFmzbaKdFPliw9q7Ka2tZdVyzp82FGz/oRN/tUgUxfe9l+UbIVaRvObRuHbScUYj2N15pqk+BSQKlU5l1FuYT/rPcqY7AlvzANhOVVL4jyNFxnYPtxZZSaEqa25vdDY4RAGlsdw5CIisYxm57IxocovXzeO5jOgWP+XL97qmmLRnZHzakfFb4J21A+g4asEN+/ZWwdPjNkUYwxlBbPVzSxUZ6SR1hrpj0n+AEmmctOeUbGQF86R6P9P124XQs/E1asyPe91ljqrKmSfGVWKD5gghOIXJMY4PWTYzYBUr/4otoD8zhyd3fnJyfP6loAVrao9K2wvoKfQvtRA3W8mo4LGaWUP0SGxkr4LzAL284Zy3z3L5ordkQkeL8tWiPoox9ohtx5Fx77wEKWYBeuOPp/LNjoG6ZA+hZ3Om7fibumdU3ufXlg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(4143699003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzl3LytkTWtWOGZYVUU5cGRValJGVFY1UWk0bUx2dHdxR25oOGRwWUIrallN?=
 =?utf-8?B?QU83Nkh0Y0RDZjFLQUZMTzRjK0o0djNpYm8zOGdaUU9FdU9HUGZDaVN6NG0r?=
 =?utf-8?B?Y3hXZ2VhWkZJOFkwZnJlRWg1MVR1KzhweGNUbkJlMlM3MGYybWdsM1pnZklD?=
 =?utf-8?B?TEFWK0lXRWVDVlRRSS9DODEwK2s0Y0VzUDJBVmFaQVlSOTZHaWgwSVpuMjZ5?=
 =?utf-8?B?MzJqSmpjLzNuem9IOWJnVnp4SUJVOUwrb3pETFRqbnBRYkNscHY1UEFQTGYr?=
 =?utf-8?B?cXFIQURHZFQyT0tKVENmOHRhWlE0cCttYmdqYTFZaUtoU3JRSG02bUFqcVFY?=
 =?utf-8?B?NWJJWDF0QTFzRlhXM0RxM3VxSk9wOWxGRXdlYVV2bXJlTXBHUnNPa1J3Slpj?=
 =?utf-8?B?bldKM21zdlAvVWt0a2s3cmx5S2hZdjkxMzZ0NUNsK3dRLzRyd3ExdVNJSnNB?=
 =?utf-8?B?R3ZxemdweHhmVmZLOGZ2WTBJQllFVnByUjYrOG5DdzJpZU1ZeU9CT1RTaUkv?=
 =?utf-8?B?Q1NLT1p3a3NoOEdYKzhjRTgzaEJNMGUrOCs0ZXdPWk5LOCtyNnhZTEFSeXU1?=
 =?utf-8?B?cWI5Nis1Qi94Wjk4UnhFejlkbG9HaU9CWE1EdVJ0L2cwR0J4US9DWkJnWXY0?=
 =?utf-8?B?b1drcGRTWDhjV0w4bFEwMy9kRHE3ZnhCZHNDVWl6M05CdmNEV0c5SFVOZUxy?=
 =?utf-8?B?SlEzQ1oyNEdteldmSHJFVEJMOUlOL2hBMGhBL2MzOCtzb2x0UmtSbXNUS0tD?=
 =?utf-8?B?WGsrOHQwZTdXQVgzOVB0ZHF1ck9lNXJWQXIzVDhWVllLUFJGK1luWHU3MjJ3?=
 =?utf-8?B?cHpVeVp0MjMwTElPQ2lPQlVmSFVOMHZ0KzhuSmd4WXVMdHkvSzhsMWVPalJh?=
 =?utf-8?B?a3MxOUlZaUp0T3Z4OTZIcXVxYTZiN1ZzN1R4dWZrV1F1OHlUYzRNN3pzclNq?=
 =?utf-8?B?U2Q4U2hXWGNxd1ZpZ0MvNm9VZGppUWhkRTE1a3NXTTZCZGozR0pMS1IvUzNY?=
 =?utf-8?B?cE9FdWRVTzhRRTBER0VGSktOMllDQW1wUHY0cUFSbGZWU1UwOXdnWEZzb21k?=
 =?utf-8?B?end1eEMxSXlpdDlsakdVUjYrM1ZKUUdaS3J6ZUZ3NCsvbG15UGVoZDJmV1E4?=
 =?utf-8?B?dTdOcFF3YmtZTjlMVlFWMlZXK2VRSlVTeUg4aWRFdmNmMEl2U0ZNeEEzYWMy?=
 =?utf-8?B?UC9wd0FJNWxmK0hxZEd2dWQ5cDR6Y0tERTBUZFR4azNOT0FuWjREa0tvVTB0?=
 =?utf-8?B?b0IxUVFGQVpzMjdrR3VxdTRFMnVVNGhGNGZxTjNlSVIwdlFDb2RqTnFlek5a?=
 =?utf-8?B?RW9kUzl3M0RCT3Fsa0NkMloyMWlMZGJEZU5tVktLR1ZCL282VXFwUWJpdmtH?=
 =?utf-8?B?UE1McUhMSWJldFB3akM0emFmbDhGRm1uRlpzWWloUHltdStKLzZldkRGY0Nq?=
 =?utf-8?B?SXYrT1lyZzdLM2JoQWE5NkdhNHRucGVkMzlOVGQxQnBrVkZLUWthM0ZzMEpQ?=
 =?utf-8?B?WGNOaW5QSDlIRExTT3RCYVJObzNud084VU1xZFdkTDI5cmpDTEhrcEQ4bnZ1?=
 =?utf-8?B?NFpWTUMxVzJhVXgweXRUVlhKZHJyN1dmb1ZxamUxWEtVT0FCNjNNSm9tamQ3?=
 =?utf-8?B?RXNaTXN4K1JjMG5FaU1JRWFwaVk3NUdxWG5zYW9PNS9jdkpRdW9zT0VDblNO?=
 =?utf-8?B?a0Qva0QwUG1ydU4ycVBrUk5xcTUyTEFCejNPZ0V6dTVXaVFlcG11NUZWWXBH?=
 =?utf-8?B?Y0NzUmducFNVSloxbEl1ODN5a1B6OXE0NllyTmFmR3JVc0IreEJrL3kxd1VB?=
 =?utf-8?B?dU1pcDJpSzYvaVE5eEhNZVFRMnBLTDFDVTc2TEljbmNybjVUUm03ZG1QVEVs?=
 =?utf-8?B?UFNOVDB2Rnk0M0ZNTmtNZldycWRicFIwSGg0L1RIWllZWE8zRlNlSUlLcDRp?=
 =?utf-8?B?MXdSWFlmOGtHYU1FQzJHRHNUK1daNlYyRmNwMmlhdDM0NmpzejNHbFFvdDd3?=
 =?utf-8?B?QXhldWtTUzkxYTRySy94SzFPMGlIaCtjL1JRbld1eDZCd1h3cVFSdnBpZTAw?=
 =?utf-8?B?dUt5QVhkNmlIcElXZWIvZUJMV2ZoMXFheU5kaS9MeUp2UFhDRDIwTUZoOTJ3?=
 =?utf-8?B?OHZuOVpDYTBSNjIxdmZpNHBpQ0JqNGYrb244VWRjeHNlZ05MMkhscmM3a1J0?=
 =?utf-8?B?b3Yzd3QwZGZ2bngxaUxOb3E1Q2NMdDE3bEhrV3QzdDlPL3E3RWV4K1RJWjZT?=
 =?utf-8?B?blNkaXB4aVMwRU9KVkZnSWFJdlhUenRsRTY0WUhRTFVaKzZQUGJtZFpWNTdV?=
 =?utf-8?B?ejBsNUtYNCt1M28weU0wNU5UN0ZMdTlzY2U3eS8yNlEyMjlyOE5CQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc73817f-9971-49ec-40fb-08deff9cb695
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 15:56:07.7540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2IvzgDw04ry/LRFkvisfgJ55YBKvZ1sWxnnVz9XxwUgfjsCZPxtogyTWrfxCfK/QLz4Ly6ILtgV8Nrc7Cyt0Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8952



On 8/21/2026 11:26 AM, Sairaj Kodilkar wrote:
> When AVIC is enabled, device interrupts are posted into the guest virtual
> APIC backing page regardless of vCPU running state. When the vCPU is not
> running, KVM may additionally need the IOMMU to notify the host so the
> vCPU can be woken, historically via the GA log mechanism.
> 
> The existing ga_log_intr name is tied to one specific hardware mechanism.
> Guest APIC Physical Processor Interrupt (GAPPI) provides an alternative
> host-notification path when the vCPU is not running, i.e., IRTE[IsRun] = 0.
> The KVM-side intent is the same in both cases: request host wakeup
> notification while the vCPU is blocked.
> 
> Rename ga_log_intr to wakeup_intr in the IOMMU API to describe KVM's
> intent rather than a single hardware knob. The IOMMU driver still maps
> wakeup_intr to IRTE[GALogIntr] in this patch; GAPPI support is added in
> following patches.
> 
> Similarly rename the synthetic AVIC physical ID table shadow bit from
> AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR to AVIC_PHYSICAL_ID_ENTRY_WAKEUP_INTR.
> 
> No functional change is intended.
> 
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant




