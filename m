Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013027.outbound.protection.outlook.com [40.107.201.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB203FF1
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 05:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772171176; cv=fail; b=hQPhp2ZdhbymbcciJ0sqYQADGzxt2emDooWUb/xOPV5BvqZQ6RZfmjUeqtwk+GnJNPmoi8kMaGF2VS/ASbfg4q3iBFPEVtSBBLM24s5FsDK03Tcn0EtoZr/iK09gASOtynfspFWxxSQf9AVZXz5V7ojL9k+f13Zm1VWr1TmyUu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772171176; c=relaxed/simple;
	bh=x5h49MYjCpL5cwZc9BRyPey7gnr8bJQLAWFl5c83zqk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FjUFq0M0FTl5tJ1EJhTRi/WCNfDQyGRbCog+PmLEW2nU0YIDb1RZ2cES4ECpAhgK0IANK50YNZJzqqEpeiI+Ghd3wWNGzQ4LpwZw1OBLZsd6FwgmGihGjI+mYuB8P3pCXE1vZKPs6upVuuzVjin58WgSuUr4Tkp0vpIRrIyUaxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TyNDfw7G; arc=fail smtp.client-ip=40.107.201.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TyNDfw7G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZfJaD+OKPJQGqAWGX3VzMvEvBW1/IWGho158ZyptWHE+d/VQtUvm+2SijfviNczTFFNMNxCaZJNJW/bvc7WfHni+QZ2xnhIOi+hVNu8vY4882LEGvh1H/B1RqdyRdDKbWxiDZDFoTtO05qiGfcsKiD2KPp+sPwUsbPH4pgjs/C0tZCCbeMDL4Cjo1mDYK3+BPDt6yfb1uvyioB4zuqa3JPwOIxCchFw/UwZW5LXg+G5mhrf6oshP+ly5Eb1/ibrP/GevL3eFGw3I3dOwt4ye62nK/qukD5Iu9b8tODXJyTz7c/EklfDxSNGECKRtJ1URuxhFrJcYJ8P3zMjpJGgSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jeVfS5PhFDdb77I/23fsfNVBS2tR5CKycXwcNyHJfb4=;
 b=FW058YwyIJ+rnRqOrz594VgLDC2maef23ZbXIcq7Q9ZsVxeXc/j5OFW3uAFFb932w3cjQq3Pya37iZLcxAZugoY29hXD4w9rJQU6dqlBtOfyKl55S9YwuH1r2cd2ubDGPaHwc2HhN9TNEChjBSAydU0YIe/TtiQFx3Y49wTkP+r3ap+WktnX4Q5KF9fN6kbjLacae/6OcefQMcyJkkaKLlZyFkYno0d4AtgoxcNmeETCLGvTOhzeLfNNsG5Qg9KjrT+zSVtGKouq2JpZgCFM6f0tDRlLUn3y8T4glhuSzUaWHgCsl+fLtQXmC2bc9pOzcaXHdtIrPiwwWwdtq7Xyvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jeVfS5PhFDdb77I/23fsfNVBS2tR5CKycXwcNyHJfb4=;
 b=TyNDfw7G0bjbVKtII80VD5AeFah6583G5IB3biWKMyuyJmC3I+lkh6gh3O4Yd6Rsbp4ls0vTf3k4WBGQMf6YXmSs4zTBCrZhe1OrSytQ6MP57gzqvlJoKIcFKFjJ0VGxuIQXc1XBwV6F+46rxdpZ9F6DA58YY4gu0ht+0GpV8QnRa/lCoOtk3MJxO62IDrJOOfTgx1HFr7wUekehUn1axJyKjoFSH9YNbKUnOyYf2gRoaQH6FKc+FbM5ed2b106C1XUeiCiGCSc2pVzJqX7VS0mx2eDUUk7Xzl/urN6veCJ22iI8qlpyQhD8RDP/NOuPcng9ZcXh3qwSADRV7IB3Mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN5PR12MB9511.namprd12.prod.outlook.com (2603:10b6:408:2a9::14)
 by MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 05:46:11 +0000
Received: from BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c]) by BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c%4]) with mapi id 15.20.9654.015; Fri, 27 Feb 2026
 05:46:11 +0000
Message-ID: <58634d52-5d44-4ec9-b1f6-273b5c32b525@nvidia.com>
Date: Fri, 27 Feb 2026 11:16:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] iommu/dma: Validate page before accessing P2PDMA
 state
To: Leon Romanovsky <leon@kernel.org>, Pranjal Shrivastava <praan@google.com>
Cc: robin.murphy@arm.com, joro@8bytes.org, will@kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-mm@kvack.org
References: <20260224104257.1641429-1-amhetre@nvidia.com>
 <20260224123221.GM10607@unreal> <aZ4Q1HA9q1ojsVYY@google.com>
 <9d01b4e3-be5b-4c9c-8088-1d10f67f1fd8@nvidia.com>
 <20260225075609.GB9541@unreal> <aZ9Xccnn7JOikudb@google.com>
 <20260226075806.GE12611@unreal>
Content-Language: en-US
From: Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <20260226075806.GE12611@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PNYP287CA0091.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b8::11) To BN5PR12MB9511.namprd12.prod.outlook.com
 (2603:10b6:408:2a9::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PR12MB9511:EE_|MN0PR12MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: b6ef2e5c-f63d-416b-8282-08de75c382e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	ZHrcAjTy8kWHlb90EcFsJgvWFTWW4ENuQ/yQQ26eKHuPsSxiqxefD74Ft+EDdnbt6RvucODHdx+FWqq46AHyRydcTnxdaOAhN412AHLelCh72wrkiDxTM/O32XBreiE9V0IfBSWxK/cLyq1ZCC6JEUhd6ihXxyeUmeLf/OXxiLmDZltWWfUUkr2ck/ROHDvc8TqQWtSVK53bL/GQmnpB8O3KdQz/Gh7+ISR6iwqrgZV/OFeRXK/DIm77Wr0MJkhRipwp2D36XpMStcSXPZDD81dTsZ/QaMeeKGORYqlbW3N1cLbylnogFJ+KzF/R5IHqAY/mIeQn60jTBc8sPpcAg3uJeTLY9pumjylofQGeFppfRhjfXi/bGXtQno+sbxnYUqLIE/ycPLYx7/7J0BHLNzusE/ImaE6K7A2r/pWSxbUHTgNO2L1WKuBRqiE3/6ajZnpV3HNsbzoK4GdlZIXwYka62I90v080FpzrEfN9Nv9hIuiTyBBlsx2ObXkKX3wVCt4ARje1XV4pyeZV/1wVr8i8p9VRDfZMEIvoaHFUPEy+HNIWAI7vSaFE0CeJIoFFS41zCv/uul9qwXAQux7OTECtZdGmNXxvacjCvtHmhY/OVECoz2O/xQ0jvOKQoHfWs0jjAPOa0+Hxpc/k+s2KmlvcZQ3aPjsESsHmjcMegE4RT3iNH35A83eNHIoCgQ0OIs6WrLSHdCpauHTSabNSUrs9ueRVli3D71rt9i40z3M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN5PR12MB9511.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3VIb3hwblEzdnF2RmZKZkYzNDh1OGVpc0EzODhrOGprN2pxQlRNZFM4SWd6?=
 =?utf-8?B?bWVhZDVWaURvSGxSSVdobFFRMlF0djdCTVFhRTB0NXZyQXJDNnJ4Z0E5ZXR4?=
 =?utf-8?B?VVBZcjhpK21wbHhqdXhsaWhuZUdwM3ZtbEM1YjloKzNPWkhSejV1NDVMbVg0?=
 =?utf-8?B?ZUFHem96dFM1anQ2c2FCdHpSb0p5Uk1xb0F5M3VrQXE3b1g0Y2FMUzFLMkFF?=
 =?utf-8?B?cnBuUGh1WTFoM3libGk0VWd6bE9hakNrenF2ZVEyVHFmUXRHQ2Z4R0lqUS9a?=
 =?utf-8?B?WDhVVE9jQkVZc3Q4SlVBeTFGdVcvWE54ZWVOZmNiK2hxNFc5alNKQURNMXEv?=
 =?utf-8?B?Tmw5RDU4SHVUdGJpOG5rWGlHbG45ZUhUVmkrY3JDMUpSUTd2WFMxbk0xN0RF?=
 =?utf-8?B?MFJON2lLeDlTY0FyQ3E1R09LRHkvR0NIaGdKa3NTZCtiOFNWQWdCT0REMjRV?=
 =?utf-8?B?SU9TbXE0MUF1T3ZLS1pRNDJBaUJLY3lVbnBaK2pjcDRzSE05UmtLSXQwQmJS?=
 =?utf-8?B?dFdqN2l0eHdFR21raDNXT0RMUWNoTWQ2V0NJVUl2alJKTm1PUW14OWIySTY4?=
 =?utf-8?B?TGpkbFJhamhpZmFBd2k2NmYzV01hbE9nb05OZjBlVzNuNWZZRzRqRDE4MWNW?=
 =?utf-8?B?U0tQOHVmck1aMHJ3bDBuR1B0N2ZSY2tEdHprZWFVMFJtV3lESWw5OVBLWjJ2?=
 =?utf-8?B?NUZrZ0U3RTNUdTBTY3dJaFdPTlpwcmIxeEpieXBna3BpSWtaN2VQajl5Ykda?=
 =?utf-8?B?NEFrUjVMTXhEZVQyN0daRVd6R0FXUDlXa3BxbEFJdmJ3dThZc0RreWQ1Qmgx?=
 =?utf-8?B?ejFmaFRSK3dpcWxqSVpoMVZjVmRFTGtlTm8wWlluKzRJYjdaOVpUTUpoUGZV?=
 =?utf-8?B?aktZV0NESVd3ODhocmNKb3ZQMHB0dHIxN2xadlN3eUZCcG5ySExHdzdyOXhm?=
 =?utf-8?B?UlU4ZGRvZG1nUHpCYmhXUTFYTzBJR0NjWFowZW41ejBnbkFWVm9TOENjVG00?=
 =?utf-8?B?MXVyMStYcUU1UWtYb0xwQkF4Q2svSTdYQi9EbitWcWJ4dEJPa0RMTi90RVh1?=
 =?utf-8?B?Nk1XaTV0NjlxQzh2TkZqTElBdlVHNWFGZ0o3ekNSZ2VnaWhYV2MxZnBCejYw?=
 =?utf-8?B?SFJSZXdzVndEOWxEMEk5NUF2S2JlZU5DS09mYWVSaG9vWWpVY25PeEZ2UjRL?=
 =?utf-8?B?NXU2K2Y0VWlSamxVQVhSZ1Z1TTBmblVZdCtFVVhkMTFDKzFYWWNveDU2KzR1?=
 =?utf-8?B?Nit5eWhwUCttTTBoR2JyR2pnVkxaRjRpdjRYY01STGpFSDVKWVk4ZU13THQ2?=
 =?utf-8?B?a092WHBxVlJNakNQYndKOWhOOEIwRjc4ZVdtdk01cW9JNGkwSDMvcm4rcFc5?=
 =?utf-8?B?VDdLbXdqYWxCSkhoSUhqNkEwdXlJdHAzTE5DaThuRmZ3OWJ2bmVmRHpRbXda?=
 =?utf-8?B?S1JjeHlXQmNVK1FKbVkyQjZ0NE5pTm9hdjFBN2dlTjluQmdHeWFtR1lFcFhR?=
 =?utf-8?B?LzdhL25wbFNCWWh6T3lYQ2g3Wmw3NjA1a2xNczdNVzFEVFZ0SWxmdVNNT2NF?=
 =?utf-8?B?VVBGdjlWMHdEZUxqRmJJSGxRZzhiMXkxZFNIN0ZRcGQ2SVhseUh3bU9keGFm?=
 =?utf-8?B?VVhMcnhnV3FnQjJRTk1IWWlsV0ZOa2Y3UHFRT3lKMWhoMGgvQTR0ZGdpbEVL?=
 =?utf-8?B?RHhUemxGaG1kNjZYR0pJQjgrR0ZCYUF0U2tzYkJhZDJGbDNUS3ZXUmI4emUy?=
 =?utf-8?B?R1Fod0FWTk9hNnA0MC9WM3dsaTJtTGZEdUdYZ0dFaVFJNDBDeTNpL0JjNVhM?=
 =?utf-8?B?UmgzbjNMNlN5NnhEQ1MxTXo3K0NyY3JKYllYbkw5ZmF6THRadnM0MkJ1Q2pC?=
 =?utf-8?B?aG52NU96d2QxREhFVnVYTXIvTmpiZXZoeEFQN3pScG1TZENNRU5yN2RLb1hw?=
 =?utf-8?B?ZlV0QWFUOXJVZVJnN1pxbkRUeXY3cy85ditIL1U2L3BaRkRrWE1oOXBqbVBp?=
 =?utf-8?B?NHdOYmtkMU94Nm4rSFZMYjZBOGtJM0VEckFSZmZvSk8wWHZRblFYVHVJV09y?=
 =?utf-8?B?NVhqUE9GUks4c2EvWHY5MURJQXUxWW8zQkVrQzVHRnZmVllUQVRvOTNoTy8x?=
 =?utf-8?B?eFdLN3lkdEtad3JIZGVDMytpdVJzdzlwRStTT0dmbFpLak82L2ZxaGhUTWww?=
 =?utf-8?B?ZXZRK25Udmx4dmdhcXMwaEowa1ArWnJ6KzZ4TGxzL3VhNVVGUWJNcElLNUZH?=
 =?utf-8?B?N3M1cGJLQWxqWEQzdGVKZjNLSjIyR1FaNk1tT3djM0ZCYlFvaUFJMkUwbmY5?=
 =?utf-8?B?WkF2RDF1RWgyR1VCSHBkek1IcGc1M3BYSGIwZVBvVE8vUEVuZFV1UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6ef2e5c-f63d-416b-8282-08de75c382e7
X-MS-Exchange-CrossTenant-AuthSource: BN5PR12MB9511.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 05:46:10.9479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I8PNaZrJsqSAU7EHviiGq/1mTdluEfpmmBrq28axObhZB28pvvL2hNu1FseFkL3ntwK3utLXTzln2CQq+ZqdsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6293



On 2/26/2026 1:28 PM, Leon Romanovsky wrote:
> External email: Use caution opening links or attachments
>
>
> On Wed, Feb 25, 2026 at 08:11:29PM +0000, Pranjal Shrivastava wrote:
>> On Wed, Feb 25, 2026 at 09:56:09AM +0200, Leon Romanovsky wrote:
>>> On Wed, Feb 25, 2026 at 10:19:41AM +0530, Ashish Mhetre wrote:
>>>>
>>>> On 2/25/2026 2:27 AM, Pranjal Shrivastava wrote:
>>>>> External email: Use caution opening links or attachments
>>>>>
>>>>>
>>>>> On Tue, Feb 24, 2026 at 02:32:21PM +0200, Leon Romanovsky wrote:
>>>>>> On Tue, Feb 24, 2026 at 10:42:57AM +0000, Ashish Mhetre wrote:
>>>>>>> When mapping scatter-gather entries that reference reserved
>>>>>>> memory regions without struct page backing (e.g., bootloader created
>>>>>>> carveouts), is_pci_p2pdma_page() dereferences the page pointer
>>>>>>> returned by sg_page() without first verifying its validity.
>>>>>> I believe this behavior started after commit 88df6ab2f34b
>>>>>> ("mm: add folio_is_pci_p2pdma()"). Prior to that change, the
>>>>>> is_zone_device_page(page) check would return false when given a
>>>>>> non‑existent page pointer.
>>>>>>
>>>> Thanks Leon for the review. This crash started after commit 30280eee2db1
>>>> ("iommu/dma: support PCI P2PDMA pages in dma-iommu map_sg").
>>>>
>>>>> Doesn't folio_is_pci_p2pdma() also check for zone device?
>>>>> I see[1] that it does:
>>>>>
>>>>> static inline bool folio_is_pci_p2pdma(const struct folio *folio)
>>>>> {
>>>>>           return IS_ENABLED(CONFIG_PCI_P2PDMA) &&
>>>>>                   folio_is_zone_device(folio) &&
>>>>>                   folio->pgmap->type == MEMORY_DEVICE_PCI_P2PDMA;
>>>>> }
>>>>>
>>>>> I believe the problem arises due to the page_folio() call in
>>>>> folio_is_pci_p2pdma(page_folio(page)); within is_pci_p2pdma_page().
>>>>> page_folio() assumes it has a valid struct page to work with. For these
>>>>> carveouts, that isn't true.
>>>>>
>>>>> Potentially something like the following would stop the crash:
>>>>>
>>>>> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
>>>>> index e3c2ccf872a8..e47876021afa 100644
>>>>> --- a/include/linux/memremap.h
>>>>> +++ b/include/linux/memremap.h
>>>>> @@ -197,7 +197,8 @@ static inline void folio_set_zone_device_data(struct folio *folio, void *data)
>>>>>
>>>>>    static inline bool is_pci_p2pdma_page(const struct page *page)
>>>>>    {
>>>>> -       return IS_ENABLED(CONFIG_PCI_P2PDMA) &&
>>>>> +       return IS_ENABLED(CONFIG_PCI_P2PDMA) && page &&
>>>>> +               pfn_valid(page_to_pfn(page)) &&
>>>>>                   folio_is_pci_p2pdma(page_folio(page));
>>>>>    }
>>>>>
>>>> Yes, this will also fix the crash.
>>>>
>>>>> But my broader question is: why are we calling a page-based API like
>>>>> is_pci_p2pdma_page() on non-struct-page memory in the first place?
>>>>> Could we instead add a helper to verify if the sg_page() return value
>>>>> is actually backed by a struct page? If it isn't, we should arguably
>>>>> skip the P2PDMA logic entirely and fall back to a dma_map_phys style
>>>>> path. Isn't handling these "pageless" physical ranges the primary reason
>>>>> dma_map_phys exists?
>>>> Thanks for the feedback, Pranjal.
>>>>
>>>> To clarify: are you suggesting we handle non-page-backed mappings inside
>>>> iommu_dma_map_sg (within dma-iommu), or that callers should detect
>>>> non-page-backed memory and use dma_map_phys instead of dma_map_sg?
>>> The latter one.
>>>
>> Yup, I meant the latter.
>>
>>>> Former approach sounds better so that existing iommu_dma_map_sg callers
>>>> don't need changes, but I'd like to confirm your preference.
>>> The bug is in callers which used wrong API, they need to be adapted.
>> Yes, the thing is, if the caller already knows that the region to be
>> mapped is NOT struct page-backed, then why does it use dma_map_sg
>> variants?
> Before dma_map_phys() was added, there was no reliable way to DMA‑map
> such memory, and using dma_map_sg() was a workaround that happened to
> work. I'm not sure whether it worked by design or by accident, but the
> correct approach now is to use dma_map_phys().

Thanks Leon and Pranjal for the detailed feedback. I'll update our 
callers to use
dma_map_phys() for non-page-backed buffers.

One question: would it make sense to add a check in iommu_dma_map_sg to
fail gracefully when non-page-backed buffers are passed, instead of crashing
the kernel?

Thanks,
Ashish Mhetre

> Thanks
>
>> Thanks
>> Praan

