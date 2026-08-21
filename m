Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011070.outbound.protection.outlook.com [40.93.194.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DC936A017;
	Fri, 21 Aug 2026 15:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787327811; cv=fail; b=LPxUNV8lqGecpGN185G4Gkx8D1p1qNOn9aU4Yw5b7h4VAZ+Mp7S3US/uSld/YzNSNMIP4NPly+uqjaIsRwfREYfEYRgbtkMVaetlHpXSj9/h+9Cl4YTz4KT0LZiFKfW8ckGBCR0Od7ZPFlud+lNBlx5FHahrqB4YMPuUNPfR1I4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787327811; c=relaxed/simple;
	bh=MnImt4tjwKOhcJ3js3DVRly5+QdV60sG6ZlS46Sm0HE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kF+22pbN/cxHlx5EA1Ruo3UWdKrlYx9DEDWLY//UrTwKBIFs6+mj5m7TS8kp9x59yVXFl4TOcaJB5ZpWZXQVOEDWeLZ7IwpoYyGh6iV6kAC83BSHLR2rlArGRfTG3/kY/2mwYGtvXO8/PsSRu8Eej6Lre3wUFreAwyoZybeDKrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JhnIJZCu; arc=fail smtp.client-ip=40.93.194.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JhnIJZCu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cxjd++BZu2o6H4tgd2tH0ue7yRhJyLzf3b5RnZLZCCv6vo1OAb4VdoT5Jy1r4rjCGhcx1IGddaNE8eha0E5m7Y6d9PRhTrOintq70lU4UcVtNbQ0acyj/HbUBlDjXzhPcvfjTEEThH7PltNDTc1W/hLVzHG1hsL17ckXq5IpweKfK4q49yaNiMRgUHzU2MWPkEU+cBDsxrEvZ3i9jCsZlmAQeZ8y1Rs8ktovZc+pirkBINXcyJ2oO3zdJpwewtkW8yCTsl/1d9FdTtIub0sIPE4SVK4YNXHOr+fwd4sTqsYdJA+ZkJzdHKb8wHuSFUMfaNFZA7YXXyThnUvyfRIedA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAC6J7P5OtQqTKLjHJPOpEWNm+ifpscGWPjq287+JEw=;
 b=hH+5Hb/BL4aSAxars2FHeETdfTOlvOjFiBLrNX/k1I9Oi6Ug2UgW1EWiLKbsNT2PUg7TUVnOPkJqOZc5ooKTYXzanPNH1u/a7eRwovMJFQJwgRwCu4HOU82gKpSKA2r8eM+RSfU8hsJ6OkFomYHIXLgyse4LTcr8uOah2FGlExjCfTEYvH1kUzTGKqAa9zHd/lJNg9gwnc1oECisn+P3R8rnz+zINz6RgUnFsmsoy19TwaFa96j2LCC7GHlAU8JPTY9waU1YDDh5kBb9ukTAphtbyen+nSDaEfm4+6nXQ3rEuNAoL0qAl2Um8NdsnaHf4WIgXyVW93bNU8Z+S7R0/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAC6J7P5OtQqTKLjHJPOpEWNm+ifpscGWPjq287+JEw=;
 b=JhnIJZCuPZHGyA2mxcuEVFcS9Kol+eQpr9qQszUXvvyWTLd3duXACgtKbIjp2bQ5YrAryQYW5xql8OO1ZsQ+RZKHLk1dYDxdEbrO9H3ZRYAUbEXsZ6sDue/afNgV+fK6NkAXj1Nan/pi9WJwMEJedzQSr0PnIC8ejSsLhv4RYeI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by MW6PR12MB8952.namprd12.prod.outlook.com (2603:10b6:303:246::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 15:56:39 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 15:56:33 +0000
Message-ID: <c00c5e8c-bb30-4396-8436-335276360ae6@amd.com>
Date: Fri, 21 Aug 2026 21:26:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] iommu/amd: KVM: SVM: Add explicit vCPU running
 state to IOMMU interface
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
 <20260821055611.27138-4-sarunkod@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260821055611.27138-4-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0108.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b5::16) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|MW6PR12MB8952:EE_
X-MS-Office365-Filtering-Correlation-Id: a3362600-ee2a-4637-2c7d-08deff9cc5e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|4143699003|56012099006|11063799006|10067099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	vkVVaKZ2/1f2XdjZIgkRVkif0PuzO6Oui1F+WJBgcfhEIjhpOdWttjST/SEBbxe4604W1IBmQsJapsiwOnC5W3RYFsnl3v0zlUuGvB8WzLo6Yod690Pk5ksFTXn4PAs7Cr90KJNB8OWm+YenjBP1VGR0e7lPkMuysSMVIy+h0rmadLLHEKjj86cYqZbWY9OoqzUvsl74Hh97/kQrgiN3EYAljitrItUw3NBmkZiW9Atk/RqqEzjqFcnPi+dAQeASZ3tm0Qdp8AKBtL9FLDGmQ6GT1jFM5JVEGOzzTD4KxAkkLJnqibNlg7/+TH2Tq2PgM99JDPeq+RgkJVvCRonCG8iWcFqkjo/X2gIm22Vm6U00YnR1wwSHwGIAJ239OLTnXw3L5fyhN9wM7hijvtKu0Y1vKL1ElcpRfesfVbShja6wU4JYCRnOJ0PZMKAPeNccnWnSs9BUrD4h02fxznv5TrLReGNJuRk+A3t4034l4O8lxVRT9wSE3tSSaBe0MF/tIwJbOcvzChXp7NXIS26kyfIJ2LMLSfJEAnyYrxwpPOIdUXi+nGSpe6gb9xKzK/k2Gt+46m1g3acM6KQHJ7Ot3QW2W+I+Um/BiBHm4Hg8idSjz4FW8u41e4Q7NQ2HRlptfJNkyY3loFcgpdFgRPq1NxxEqFxrjna04ZfOokaeHrLrsxoo4m1y/ks/mpA4dmxHTmNQNEGUiinQl7Vd46EvVQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(4143699003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Uk1RL3JXZXRvbjRuSWE1UWpJVkxEYm56QVp5c2RyamhjUEJ0RVZ0YVBOUkkr?=
 =?utf-8?B?ZnZ2dno3M0ZPYksxUTlqTlpSN3dZK05KUGFtZzlueUE0bVBaS1RDUlJROVAx?=
 =?utf-8?B?V2M2dEJzYVFrb0d1bW9jTXVQWHkxalFaTFZ0R2dSaEF5b1F5MVlNUGx2NXAy?=
 =?utf-8?B?KzViWmVJbldsY2k2b1YvamJqQi9VOC9EaTJ2dFg3ek9PVXQvVHhTbTJ4ZmRp?=
 =?utf-8?B?TUcvTkV4a3JZL1Y0a01ML3FkYzROc0JYTDc3ZkdObFNVL21kRTBQWHdzUmVq?=
 =?utf-8?B?TGtSRDNBdHlMZDdzUHhOTEwzL1BXQ1pZL0tOWWYzdzBnQ2RGV1dNWkVEN3lW?=
 =?utf-8?B?dHVlZ2NJUG95YUFhQlpoUkcyTW9oMnNIYVFuQ0FvS3k5eURJUVpYblpOU2Zo?=
 =?utf-8?B?WTMyNW5kWXBEelR5d1QyaEFCMExkcEJrWjhLUmxORG5nQldvYWJzSElENHdP?=
 =?utf-8?B?ZUFBeGxRQ3dxaUZuY3JyWVdRZk81RVVuRjlCRlp2Ky84WEp5cldadnFFa1p2?=
 =?utf-8?B?aXBTY1BsdWhDanBQdkVYdlFLTkxQVisyNG5zUStEU0tWeVQxL1hiUWk5YS9z?=
 =?utf-8?B?dnEwaThDUDNtZHFjUDEwSWtEZjd2bkZLMHlzQnp1OGxqbEo2NjN1SW5paU96?=
 =?utf-8?B?TWRkb3hBMlFyTGFHZEtpaUV2dm9pWlpnMEY2djhSMzFQSGtvYzBpcEllY1dP?=
 =?utf-8?B?UCtGSTlKYkZML0RBVVd1QTJ2amllMlNXeDA2M0x4Y0k4SmVEMW5PZlVTRkls?=
 =?utf-8?B?ZnkzcHVFbTJONUs2OExIeVgrbnliQWtJL0hrMFMzRGJwR1llTy9LNHpNQytp?=
 =?utf-8?B?cCtQTStJZE1QRVNZQTdpTmdhOGdJRW1rNVBzQUVrT2l1VWNXZGgxa0dGRStV?=
 =?utf-8?B?MHdadDFvZnpYUjRYNFh6SlRGM3Bpb2l5cEhlOHlWUmkvdnR4N21pQkpLRk1F?=
 =?utf-8?B?UTViSC9tbWdvU2NqbERta094WmViVFlMZXkzM21VQkM2N0pWVXNjcE1OcWR2?=
 =?utf-8?B?WXRGcEZIcFhvcjBQSmF0Z2k5TkR0WjZ2dVRvZlFQL2FKWWNEY2lYa0dBQUkr?=
 =?utf-8?B?dG9lYTEveHlnczVZVzNHUXpjSG03aXAzOEcyVXY5NmdFRkVObnpMeU90WmZ2?=
 =?utf-8?B?dEFBQWFXZlZ2WTIvcUtjQ2JnaVFxandFVFdyTmNHc1cxcDEyL2R3SEtxczRS?=
 =?utf-8?B?akc1TGdiOXF2ay9keUM0QzZsc2FEUkkySVYzc3V1aitkTytjU2RrSldlcTcr?=
 =?utf-8?B?K1g5cXlXNE5kRjNLRERIckRQVi93bVZFUVpTY2pWNTRkeUhuWnNTbjVabDlZ?=
 =?utf-8?B?YjRXb2c1Ui9uUFlVTkN6REpiY2V3UTF6QXlQNkZGbzBHaXZ6TXBIR29QdFN6?=
 =?utf-8?B?OEREWFl5c0hTd0d3eE0zV0FNcjI4ZkxCK3NRVGdlRHRaM3VZN05PWHJ2czkr?=
 =?utf-8?B?SHA2VG5XVUk0bUZ2K2pIM09ya0xWM1ZhTkIxZWYvaHdMT0xtMzllck90YXpD?=
 =?utf-8?B?MWRrWEY3eUxhTFg3NFBnRy9iV3FNdjE0VklNSU9wQS8reHo2NUQ1dC9PZ3FP?=
 =?utf-8?B?WDlDZ1hQREVmem1Pa2FuQVdMRzQxMC9IYWszY21QRDd3VDZQR094ODlTa0Uw?=
 =?utf-8?B?ZmRXMVZzbmhiaEw4clYrMGxmVGFqTnd1OW12TlpCUWlxRCswK3BrNXl6OGh2?=
 =?utf-8?B?L3Zhcm5PbGNqck9hSWVnM3ZCTHJ3SU0wNlozNkxMbGg5TjZneTI0dWJSbUN0?=
 =?utf-8?B?RXllRlRBT3VZcWdUc2xuWU4vcjBob3lFclBxdHBiQkh3QUxnZU1uSFg3THF5?=
 =?utf-8?B?L3Urek1Sc3JtWXdXZ2ZWRy9SR1hxODFQNGxRWWdYWkJjcHBNK2IrMjF6dlo4?=
 =?utf-8?B?WmlQV2FMSFp2cWNWUXJ4dEFER0kwWmVkbFlVVHVTQXdSOUJnSHZjcFhsNTNv?=
 =?utf-8?B?SHRJUktzejhyN1RWTUVRZlczSG43WitXeGV2clRuckNqWHBLa3dRQ1Y3eUls?=
 =?utf-8?B?eVZZdVVLQnRMMWtqSS9YNzJVaDRrM3BnY1REUk80Y0JEL0E2aXYrNzgrcE5a?=
 =?utf-8?B?TUpIUWI1dUZPbXlyc21BWEZ0YlZHMEkwNmtzc2w4VXBsUE1kNFkwNTllalYx?=
 =?utf-8?B?ZSs4SlgxVklkbGExNkVmY1BoclNWQndNenhGWHN0ZWNHZ3RMeUZHaVg1SUI4?=
 =?utf-8?B?aHRBZFdNOTZZamVxVmpPQmdKL2p1MmJBVDA0cUNzS1RXY1VBVkhDU3hLSm5N?=
 =?utf-8?B?YW1CMTNKbEtFeFVmVkFkR09IU2crUUZESkRueWJXRHZXemhTWG1yUWc4clBw?=
 =?utf-8?B?NHMyNnhtdngzMnVmVDNFSlVSdFJBV29hNXM5cHJMY2hpS0pQTGxhZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3362600-ee2a-4637-2c7d-08deff9cc5e9
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 15:56:33.4957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V7yI+tDx5ZI5mb8LNyTPR2o7khIdnOzrIXgMFCfnscHdut7Q3NkEtVkXYuoIYMyFb1hMthqm7fwVCPa+vkcnnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8952



On 8/21/2026 11:26 AM, Sairaj Kodilkar wrote:
> Guest APIC Physical Processor Interrupt (GAPPI) is an AMD IOMMU mechanism
> for notifying the host when a device interrupt targets a non-running vCPU
> (IRTE[IsRun] = 0). Unlike the GA log path, GAPPI delivers a physical APIC
> interrupt directly to the host CPU described by IRTE[Destination], with
> the vector carried in IRTE[GATag], while still posting the interrupt into
> the guest virtual APIC backing page as usual.
> 
> In GAPPI mode, the IOMMU delivers the notification to the host CPU using
> the physical APIC ID in IRTE[Destination] and the vector in IRTE[GATag].
> KVM must therefore supply a valid apicid even when the vCPU is not running.
> The prior interface inferred running state from apicid: apicid >= 0 meant
> running and apicid == -1 meant not running. That encoding breaks once
> apicid carries the GAPPI destination while the vCPU is not running; the
> IOMMU driver can no longer derive vCPU running state from apicid alone
> and needs an explicit indication from KVM.
> 
> Add an explicit is_running indication to the IOMMU interface so that
> SVM can pass vCPU running state to the IOMMU.
> 
> SVM calls amd_iommu_activate_guest_mode() only when the vCPU is running,
> so keep is_running out of the exported prototype and make it a thin
> wrapper that hardcodes is_running = true. The IOMMU internal caller,
> amd_ir_set_vcpu_affinity(), calls __amd_iommu_activate_guest_mode()
> directly and passes the running state supplied by KVM, i.e. it handles
> both a running and a non-running vCPU.
> 
> No functional change is intended.
> 
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant



