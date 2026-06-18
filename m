Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013045.outbound.protection.outlook.com [40.93.201.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68502F8E86
	for <iommu@lists.linux.dev>; Thu, 18 Jun 2026 03:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781754883; cv=fail; b=IXS8d/Bp/ybNtx5FunLa5Aktcu6ibzoWWoPQrkcT1dSGWtLbwIJXWJer1ruvpBNfdCHUvp8kSi6JIh0vGQgJy0C8Ir1qysPbVMQfsP97lMgSHF/97oiSBocbpdTSL4ZIGne073y4kXUCRpuII+tNFy8maLkm9AvtN+Q7d0TSj4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781754883; c=relaxed/simple;
	bh=cNVIDzAkU+HNHXCph35hy0GUFmKVKnyMmzIE9xLBVz0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jy/K8JmTauwPfX9tD2sxSbceocEYQ95Zp2EWqzcfaCcnXBgRGmem63X43VjWP19cNbYJBqDM+p6d/er9XtBNf8rQh7LrawZ2N5qI16O3x8tTu1JyqK19ijfFBNFbh4SFAfXtEWj/muyNM9bVuyXOVEuyOzDqXWxbx3Y0O4QmLwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HN25Eqcb; arc=fail smtp.client-ip=40.93.201.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HN25Eqcb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YQJIjJeFqo3UR6W08TdvJJHbCaPHWnz1UnU2r6Kr9zLWY7ZbMOKHpHx39FFWo8J6JgZW3cXmoeb+kVKuI4sVwtK7hrckKKJryY0Skqx0MS40hvViPECIMgxthf7VvBoE8TSzWITwv32cv9bJNhxtgYHIxE0I4GI+jVB6EwS26gF5jJ2fMJstNFNTwWVrVKh3fZqGD/Ra16kxtKPtszcmxgQoUnSGCkh9PYTuUUP3mX6ZXLVKJRKxM5H77sYdyUKsQt0bDhxiff5Mowz6SEQ3hCtXOKAysB29d5zuzYoL5s0FFyqzob3nmsk9e8UfScQgJg2IFC0+cE6+UWq9l8e69Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KoSXcTGo2Mi2cjdRTq7xxf/MhuOid4/2wIOCg386Qis=;
 b=OVbzz6KOEA76qX9tqyNsl6jAC7SuUyMgZN+yluspLkncxP3IRCkGJLfLryDZ+w7HeLquFEhICqRt50DX5ACgdjeIEK11FYc8pngsDdFmLoaYFuSKGkZECi39s9wsPkSq2X8zyRlk6wmyvraZfAItU8Nul4EqBS7lCgAddcOS1nd5EEdw0+srfWIRrdUlhXM3KIcicOfOzgiuVwcQa/ILHT6GNM/qJhqhULajk5T2UajyhePtRsaGGHzUyw7kbaVzobx/klqLU1FD7bI/+osng3c7wQEbpAIL5cLygiGGeNVTx3Jr81YAJ3H2oPpB46TKjBwtB+M6TJqm0ytDwoHVYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KoSXcTGo2Mi2cjdRTq7xxf/MhuOid4/2wIOCg386Qis=;
 b=HN25EqcbbXwNa6WV0K7GGh32dTLMJQWPVgFJxVfKDAEylX6ODoykQnH77LU54UMZ5sM98igXHYHQjb3H0J5RslB06PPwoo1yXJlEqDJmyfIDruVuNGDi04clwbHi0PyVGYV6rDwlpfEsB7fvpITh8E0226GD9hKbRM742aflPsI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSSPR12MB999236.namprd12.prod.outlook.com (2603:10b6:8:374::10)
 by DS0PR12MB7727.namprd12.prod.outlook.com (2603:10b6:8:135::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.12; Thu, 18 Jun
 2026 03:54:38 +0000
Received: from DSSPR12MB999236.namprd12.prod.outlook.com
 ([fe80::8a48:f674:71b8:d21e]) by DSSPR12MB999236.namprd12.prod.outlook.com
 ([fe80::8a48:f674:71b8:d21e%5]) with mapi id 15.21.0092.006; Thu, 18 Jun 2026
 03:54:38 +0000
Message-ID: <07283097-0089-4a16-bb2a-0b297ad7d0d9@amd.com>
Date: Thu, 18 Jun 2026 10:54:30 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/26] iommu/amd: Add per-VM private IPA alloc/map
 helpers
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 sairaj.arunkodilkar@amd.com, jay.chen@amd.com, wvw@google.com,
 wnliu@google.com, dantuluris@google.com, chriscli@google.com,
 kpsingh@google.com
References: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
 <20260528051738.596013-13-suravee.suthikulpanit@amd.com>
 <20260601130824.GM3195266@nvidia.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20260601130824.GM3195266@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: JH0PR04CA0037.apcprd04.prod.outlook.com
 (2603:1096:990:78::23) To DSSPR12MB999236.namprd12.prod.outlook.com
 (2603:10b6:8:374::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSSPR12MB999236:EE_|DS0PR12MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: a9bafa21-e268-4793-524c-08decced51b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	jc6lI9MUNPBxYTug+Qe4tQTWbsMY271Ph2pguOts65wH6Nd9WLDdt/Ago2fjoWwR/JUWgUg+yv85QX4L7qZig8JdmihiG9wZIJP4B5pbb7Kls/W7ZbVb4ed/dVq+q5U+mmjFFf9cHhtPyIjlPy99YzxGl0IXa3ET7R6rBP7xVKNCvX8znpjCAarMu48KAx2x6k/zxG5jVLW7V3EmjmKsjI9gVN5UzCB2FAADLLsmKSg1gipnvNt/7HnFzMbpdOAW6dfmNABkRJf0ymcUhxkQC/HQi8LjfV88t9z2+3rGLQs0O7XRcFr4g5s62hd4a8QTXM2D5t/PFRL3289ZaAlYDrelaZ2rySfi4wBVCP1U8xTVCiDtvy7eI1TFddF5nUBMvV+s3ZcLQPEevrUxzY1+KghnFy1enGVE+VpHBkzXC0bH4pzrnkN3NJV4Faf3LNk+ooO/4b/vz3yHSXhkq3zAuaVj0JpRc7G2MlCDiXoeEGTktJvR+Ex7mF/r4LkwNjrnDyOMokx5RrMkZ8AsrYkqqre9iYykl1Ew3+tUXmvi2gpzMp0r8g5ONN4wk7EtLo/vUXxr+QnCoNh8dcwDok0kXrH7y+Yu+OXL2Q9s/bYC6BWzn4bQ/zYyDyA5+XckxBiRU8Aca97Ar+iBDCPLf+l1wV/t+kAAJFa6mEo3R9doTk+ejNGe/K1qtqOcYJFOckzi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSSPR12MB999236.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmtaZ0lVcGxqbkNRWURpYmxRMjBTWk5VZmNsOUlLR1lxQkdtcWJheERPcGtm?=
 =?utf-8?B?TFhkNityZXJRM1pmTEtheXdCM3llcW8wQkFKOFpzMm9mMi9DNTkzMVIzdWM1?=
 =?utf-8?B?YVZuaThqeFBBYWllcVVBbEcvcmREa2YwVGYyQng0RUdldVdFN0h4b1dNSWNk?=
 =?utf-8?B?OFNUT0o3RjhCQUV3d0RVdU5sMmtSSW9LR0xoenZEcWlaemZ6SDEzM0M0UldN?=
 =?utf-8?B?MnNldGpOVGhteFlpbE9oZXg2eUM1L21KSmRybEVENmRkc2RpVW9wOXV1QzJN?=
 =?utf-8?B?WjA0YnJsaHpYREpENXFwYTFTT05DNUdPd29VTFJMdmJVUW1uZXAra2ZQa2d1?=
 =?utf-8?B?TEVlZ2ZETmczcXBWY3gxdE5mQnRocTVHVXdTN1h0WlQ4UVFscjhYUXAwa1Nt?=
 =?utf-8?B?UXAvWmdHdStobzBsLzh6cVc4bTQrWTJlY1N6VHVmdC91aHhEdjF6NkRoVzVq?=
 =?utf-8?B?cVhocGtNNW9URlJJWnA5RkVXR3hiZG1QT3M1cVVUZ3ZBS3hrdUd2ekM5bjRr?=
 =?utf-8?B?eGF1SXY3Visycmk0aUJEY29wL1NYd0RYMFRIK0E5c01ITmVVS3IrNzZuQlQx?=
 =?utf-8?B?bVNBcFRqU28xenJjK0J1KzluZ09STnlackUzOUliVGJ5enozMkJFK1NmTW1B?=
 =?utf-8?B?SFZvRmcyYVVmV3YzN3NJcy9OeXhSa1hVMVYwbzBKQTBFRHd1Zko1aGRxMzhU?=
 =?utf-8?B?V1h6TElsTXBUbVFUZU9RQWpRM2NIMTNKeFRkMTNGZWJEVy9VaWgvNzhpY3Fu?=
 =?utf-8?B?Z1Jzd2hkNnlrSm9KYWRlYTVVOFpzbFJwSitoZ3ZFOEdsZWJlNzhtZko1dllX?=
 =?utf-8?B?ZkpNbGhKeGRmRUl6OElQekpLMjZ4Y3F5M3BzV3NSek4vb2NmV1BnMTNXNmFS?=
 =?utf-8?B?WmpPVmVCa0hUT0ZDNmw5d3Z3MmJEdGV0bFBXRmNzanN3bFZyWUc3b28zVUFQ?=
 =?utf-8?B?TW1LNHRIaHJ0MWdkRnhRa1dydG5XRmZ4NURoOGV3eitQM2pwa0Q4OTZySUQ4?=
 =?utf-8?B?MVcxSzBiTWFkUWdSblp1RVEybGFTbi9KTzZwWDI3LzFySk5MSkxYQnJ1cFNi?=
 =?utf-8?B?V1dBaVNYcGdMNXR6RnVvRnE0dTlGRVFGODNXV3h2QTc0OEdNZ2JQNzdjL3Jm?=
 =?utf-8?B?Yms1VE5hdStkeHRiK1JwUW1tY3p2MS9XMWVINnd4eTF0ejU1MjNlY2tkdHEz?=
 =?utf-8?B?b2ZNRUpnZzd6QUNybGxCNTF2dnl4VnA3SlRJTUNlcFdWZDBqMmZqVHQzdmQ5?=
 =?utf-8?B?bTEvWEluZGV4b3JxemJWbXBFejVKbm9VR0d1WHIrbGJmRVVMK3ZuVkozS1JT?=
 =?utf-8?B?Tllrd3ZrQlVzZWE1UHFaWVpsRWsyRHdRTmR4d1ZQUTJWbXd2dTBOK295SDRO?=
 =?utf-8?B?azhwaC9nQXZXM0t6ekdoeGhwa2tVaGxyb2h5ZkVkVzNveUYxblNNdjhpUWly?=
 =?utf-8?B?YzZhY0Q4ZkdMdWM3STBhdkU5MFdSK0VDZnNaVkNBRTBuSkpOQlJmS2VGbzha?=
 =?utf-8?B?TjA1OU5pcDhEZzlOa2lHb0Y1ZU10bXlWT0xaeTNwNXU4Uzg4MW41QUo5ZGgz?=
 =?utf-8?B?TVdzVkE1MlRERVZvWTRZQkFycHRjYjRTRTdib2txbEY5b2N3UnNxMEl5eVZJ?=
 =?utf-8?B?MU4rT2U0ZUVLS29jQVUxb2pvM3M1RzRyVG53c1huVGFCVVlzS3NrUEYyTmV3?=
 =?utf-8?B?VjZsWlE0VWFVTTU0cUVQR3hZTmk1T0tMa2hXTFR6NVBkcXQvWmRtb25HNWpk?=
 =?utf-8?B?RmZHdWtiYW9kZElsTm9CbFZiMXZqSUcrbXdtZWVtbmtzd0U0dDE1UXNPS3hr?=
 =?utf-8?B?YlBmTDFMTE1ocGcyN05RSzZyQW9pWER4Z3FwbktRUG9kQ0FxRitLNW9kSlgr?=
 =?utf-8?B?TUc2VnNWeUNzSks4aEZ1bk5KdnRMOFpVWHJrVERCeWw3TXJ5WjFvaDY0RDRZ?=
 =?utf-8?B?NXFMRnhPVWtvK0VlYXVSUWIwSW02UjZkSHRNallaeS9SQ2ZTRFgwTjJUV0JD?=
 =?utf-8?B?dlpNWjFGWERYV2prREljWkVJUFgzNzdtWmFOVXhheTgzOERzbEtWbkhveE50?=
 =?utf-8?B?REl1aEVtakZsWFNhWkQ4SWxldVBPcm5HWndKN1pNKzZ5RWVoM3FSQ2NNVml6?=
 =?utf-8?B?OVpkMXpGRzhDdFJxY2xUMFp5cUFWdy85S3pVZjVoelZ1aGdIRXVFUUUxa2ZP?=
 =?utf-8?B?ZXZzQ0xySjJWTkdRUDcwVlRwTDd4clZUNy9QQ1AzZEtvTGNqTitobXd6ODlF?=
 =?utf-8?B?c2x1bmxzdk1qU0FCZjE1djM1Y3pudXFXbXROcXFPbThXRDQ2WWlwazNVQ3Ex?=
 =?utf-8?B?MmwvQXR4Tk9abHpBYlVMVFcyN3JNdFFaUjFWaWUzSWZ4Rk9YWlQ5dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9bafa21-e268-4793-524c-08decced51b2
X-MS-Exchange-CrossTenant-AuthSource: DSSPR12MB999236.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 03:54:38.8020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SleqqiUH7OgBuIwV7dv/uaFLIBaiph0LaYPwcE8VHTw4/Vhyrqx6nwnslvmmyICTA+vJln3hS8d9UjkwLsA85w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7727



On 6/1/2026 8:08 PM, Jason Gunthorpe wrote:
> On Thu, May 28, 2026 at 05:17:24AM +0000, Suravee Suthikulpanit wrote:
>> +static int __maybe_unused alloc_private_vm_region(struct amd_iommu *iommu, u64 **entry,
>> +						 u64 base, size_t size, u16 gid)
>> +{
>> +	int ret;
>> +	u64 addr = base + (gid * size);
>> +	int nid = iommu && iommu->dev ? dev_to_node(&iommu->dev->dev) : NUMA_NO_NODE;
>> +
>> +	*entry = (void *)iommu_alloc_pages_node_sz(nid, GFP_KERNEL | __GFP_ZERO, size);
>> +	if (!*entry)
>> +		return -ENOMEM;
> 
> No cast
> 
>> +	ret = set_memory_uc((unsigned long)*entry, size >> PAGE_SHIFT);
>> +	if (ret)
>> +		goto err_out;
>> +
>> +	pr_debug("%s: entry=%#llx(%#llx), addr=%#llx, size=%#lx\n", __func__,
>> +		 (unsigned long  long)*entry, iommu_virt_to_phys(*entry), addr, size);
>> +
>> +	ret = iommu_map(&iommu->viommu_pdom->domain, addr,
>> +			iommu_virt_to_phys(*entry), size,
>> +			IOMMU_PROT_IR | IOMMU_PROT_IW, GFP_KERNEL);
>> +	if (ret)
>> +		goto cleanup_mem_attr;
>> +
>> +	return amd_iommu_flush_private_vm_region(iommu, iommu->viommu_pdom, addr, size);
>> +cleanup_mem_attr:
>> +	set_memory_wb((unsigned long)*entry, size >> PAGE_SHIFT);
>> +err_out:
>> +	iommu_free_pages(*entry);
>> +	*entry = NULL;
>> +	return ret;
>> +}
> 
> This all seems duplicated from the prior patch, you should try to make
> one helper that does this alloc and map sequence.
> 
>> +static void __maybe_unused free_private_vm_region(struct amd_iommu *iommu, u64 **entry,
>> +						  u64 base, size_t size, u16 gid)
>> +{
>> +	size_t unmapped;
>> +	u64 addr = base + (gid * size);
>> +
>> +	pr_debug("%s: entry=%#llx(%#llx), base=%#llx, addr=%#llx, size=%#lx\n",
>> +		 __func__, (unsigned long  long)*entry,
>> +		 iommu_virt_to_phys(*entry), base, addr, size);
>> +
>> +	if (!iommu || !iommu->viommu_pdom)
>> +		return;
>> +
>> +	unmapped = iommu_unmap(&iommu->viommu_pdom->domain, addr, size);
>> +	if (unmapped != size)
>> +		pr_warn("%s: unmapped %#zx of %#lx at %#llx\n", __func__, unmapped, size, addr);
> 
> No flush? Or does the gather work for the special domain?
> 
> Jason

I'll take care of this in V3.

Suravee
