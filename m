Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011061.outbound.protection.outlook.com [52.101.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A36830C16E
	for <iommu@lists.linux.dev>; Thu, 18 Jun 2026 03:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781754930; cv=fail; b=F4T/SWBh2YqiQk9PUrxv1llVfJN4MMUtkMere9mLvm9o6FvS+ZM+m7VlE9lD0JgbmAtPveeQ7fZtkkDhmgho3nDxJI1oCkZrgfMGnueL6C+g9JeFOd0K561lxj2G2aiMWaSymX5Ha9d5Uphq+uOA0wK+oQ6eSna/TJdHFuVwjkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781754930; c=relaxed/simple;
	bh=0hHLZxNUaTkMNLudk3ECejNeyLBHO9Lq+T5lurdnqng=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VvhyvjlDZS5uA2YRCnz3B2S92KVv2Gz9r/YVvKlFC+mP8ClJvauV1zFS4T6jgZVnLqnNtuGAWgDD16XYZBZag2ZuSGACx+vRLju0TUHhWBaIdSbZB2VjcZNV1RSB0EjyNQmbJvYKa99RkmhnlAXQsZH7gJiELnxvKvU+j4XEFS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MzoXGvA/; arc=fail smtp.client-ip=52.101.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MzoXGvA/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sXuaPsKGW+h5tTt3GKvWYkYvXci+ss0EkFLFJL0HVCsbs8wC5w2WP3oLTiwiCCE/ZUT56xnG7l/AzbubJOPyW18EeR3JtLnMWk5c/yNJ1nnpimV/Z7059Uuf1YiZXoq5IzdB6dgayvb7yBKKEpoBL2Md+SXagKl/NddMypwT8T1+XDdTfmNmwH5tvePPe7FXenD/yDEbQsdu/2U/99L5ofI9IJNrKbWu6RmmxGeqwvT6JcDwFVkuKGWPyFJsGiKq+HxsvmndgFwWQyckzc4q9Vomg1mQfbi3DDiKWf1nSIId6vJLpWcVmKrQFHQj87oSf02/cGBoSPVh1pNcTCqtsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuTOQQtTA4SGXrXc+nYne7RCqgIg8Ah8sYw3MSOV+eY=;
 b=WMq7vB20RgtEWSx+6T6nH2DZAdYNB4Vim/fKvtsuT/I72M98CZH0OjLSiHoxwOoFN9wMNWlTOiEjX6WBnvTu/3nqFBZ2CSkZSrFe24LUJSGRbBmNRfNdRucfswy+8n41Coyb/MLXfIdA7wG6c7jX6sNl483RM9CmJy/Wlmt62ZysRvwN40aBVEAAVQGVCNxF3ZJ6SOHGiiBDFsT6395wRdDL+70K5C/PbqUGs/GhSbMoos5qbDPjXkTD0wuKYk/fexynle7juRBAWjAmSR26BRlWdmqoi1PbztDn04hxiVn6rUbWRMx3sO0v9k8nuGzp1DQDeQ137JCiKjW2RHRl8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OuTOQQtTA4SGXrXc+nYne7RCqgIg8Ah8sYw3MSOV+eY=;
 b=MzoXGvA/d4LXQQjkNEAwrJqbmzJIDzMTK5jrRBKT3o0HCjgDlmVKoe/j5uewSUTlfbLNgeUD5vPEIA0LY2O2ogECNQXJkau9cl5gnYzMdi4voa48tW9p/qvbLwukJqaY7LdB8xiNIPBnm861zCtpmXctCA4eOS5ibLeick8T4os=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSSPR12MB999236.namprd12.prod.outlook.com (2603:10b6:8:374::10)
 by DS0PR12MB7727.namprd12.prod.outlook.com (2603:10b6:8:135::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.12; Thu, 18 Jun
 2026 03:55:26 +0000
Received: from DSSPR12MB999236.namprd12.prod.outlook.com
 ([fe80::8a48:f674:71b8:d21e]) by DSSPR12MB999236.namprd12.prod.outlook.com
 ([fe80::8a48:f674:71b8:d21e%5]) with mapi id 15.21.0092.006; Thu, 18 Jun 2026
 03:55:26 +0000
Message-ID: <7336b556-1781-454f-9c43-a42b4e4aba84@amd.com>
Date: Thu, 18 Jun 2026 10:55:18 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/26] iommu/amd: Add per-VM private IPA alloc/map
 helpers
To: Weinan Liu <wnliu@google.com>
Cc: chriscli@google.com, dantuluris@google.com, iommu@lists.linux.dev,
 jay.chen@amd.com, jgg@nvidia.com, jon.grimm@amd.com, joro@8bytes.org,
 kevin.tian@intel.com, kpsingh@google.com, linux-kernel@vger.kernel.org,
 nicolinc@nvidia.com, sairaj.arunkodilkar@amd.com, santosh.shukla@amd.com,
 vasant.hegde@amd.com, wvw@google.com, yi.l.liu@intel.com
References: <20260528051738.596013-13-suravee.suthikulpanit@amd.com>
 <20260530204407.3017798-1-wnliu@google.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20260530204407.3017798-1-wnliu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: JH0PR04CA0019.apcprd04.prod.outlook.com
 (2603:1096:990:78::29) To DSSPR12MB999236.namprd12.prod.outlook.com
 (2603:10b6:8:374::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSSPR12MB999236:EE_|DS0PR12MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: 36118948-9420-4c4a-0ee7-08decced6e2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	xZxtTiWuySCMNE3I7U2RoDgEjfvpaI9uDTl+NMGBTfi9dd/tukcLRhSWq7IuduX+LH1ejacdM24//fw6h0YhGeBtK5Je2NXW4JSCYERX+Amh7+XDY/EB3v3xa6+oUlTzmTrRMHwSqisRGmkBc9ar9t47V2+twVPAnqVim4/KZGxrP47yi6GOzqcRXrlw53ZjX/7Jk2EHQ/Ph7QNXPNmr5xq7KMNjuwOiQp7VaN4YkpKDwnF5uNAxvNAF9mHeEo+BpLTh/CZK1ZrcJbzWPZGOLlqxgIWEpaNxdZ87JDxCRzuQXHkD/DqHDqGLq9hxrBZjzkwCgpZJjAfmbZFHlS5yEOzLxykTi+/QXR3rJa+zbydO48IX26APk9NO9TAkz1Y3QIBF11DgXfkSrcBck3Rl6gnCd+Au7Kj6b0PUp2qx81tBpfUb1IX89N51rqnP+uE2e8BcMwBHP+FHXLKogmHyUt6tlE2KelXozgD+kRgDojs4WoJT4wh7e+hl/8GjV4jybX6t9ct643Gu879onJvnvNwLrngA7fsMH3COAFJ1VzQFAqMAk7kjut+il8HU01mV3c5b50FI/1i7qUesaAqLWICpOl8idH6srVTalVGx0iqzIqWS26qp/f/0X87ZamvuDTwDgTE5p7G1fS/txcODatntmP+OVx1UUjd1ZuU+JqqJpRdeaGbX0YSJVSkyOoMI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSSPR12MB999236.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVJ4K3VnVm5URXJ4cGpjMXlwc1FtUjhNRVR3REhveXUxanJtZHV1NXlWN0c1?=
 =?utf-8?B?cGVLUFp4RHNpeGNzZHNYTWVZV3BLWXkzODZxcDdxRnZWU0F6cnhtNzlpOG5G?=
 =?utf-8?B?T3hEODFsRXJKaTAyQWlzOGs0MzRLdUIvNS9uQzhBMDArcEcvdHR6NFgxaGxR?=
 =?utf-8?B?Y1JYbzA1Y045S1M3bldHMkc5bW5OVzN5Mll5SkRlbVZDMlBwRW1DL2cyeldp?=
 =?utf-8?B?ZE0xRFlQa0pkYTY3ajQ4T2RlMWtZbFRYZFJuSFgyd1VSemVBTno3NjlwTXBv?=
 =?utf-8?B?dE0rVVM4a1BseXY1NDVhZEw2Y3FTTHBvclV4M1ZCYnp3R1d6azRwWmdiTHFz?=
 =?utf-8?B?OWxuQ1phR0JhU0pEaVQrOUY0SE9VYlFIN2pZMDRqZzRUQmhTWFpiNTBubWRC?=
 =?utf-8?B?U1RKU09ZWWZERDdrcFJTWUsrWU1jQlBrZU9POHcyNk1QanNSRmlEM2MzRCt4?=
 =?utf-8?B?TjM4WVVET3B5VmQ4ZXM2SzBjZWFNYUdqZzdXcE1hZ2RIaVlyTVNXeVNENjha?=
 =?utf-8?B?WXdPVXlnV2ZlNzgrNFl5ZlBhelJlVHdIeGwyUzUyNFNkK2Vzb2V5bnY3ek5I?=
 =?utf-8?B?cUtycFB4MUxSNFcweTAwaHBnb0loM3g4Vi8rU21UWTI5RFBOQ3dFN1FDOFBG?=
 =?utf-8?B?RmtIRGlhNDhRQ1Awd1dxRmNYODZOVlp5ZGliSVRZOXBacS80L0xnWWFjZGtP?=
 =?utf-8?B?bFpzNnJnT04xTG9iYWQrU1cybEo3S3FuSUxyYlE1ZksvT1NtS3lBK3RaRUl1?=
 =?utf-8?B?ejZ0OUYvSjVEbi9TaTJXNHFBdGdYekZWaEFMakxYdlFzRkpmOEtNU3YwdmZ6?=
 =?utf-8?B?SU0rOEI5ZUtOdWdWbDRTNWNxb2JnUEhHc0lmSzZ2VS9UWWFxVzJCZnM0dFQw?=
 =?utf-8?B?eVR5QUhBUFliTVpSSEl4UjhwaFdTc0oyaWtKb2Q2Yi9DRktDa3pmdmYvNGpJ?=
 =?utf-8?B?aGVuZWxCbzlDeXB5TUVDalhENjd0bWxmR3J2citNTnNZL1NqZCtJRk9aRG5J?=
 =?utf-8?B?cUludkgwYmprNzN3dTUzNVpSdTBRL1JnTGtKUkZYU2hJRjhsWkpjcVEvOG9a?=
 =?utf-8?B?Y0I0VUV2aFA2KzN6Sk9aRDJKSjE1c2FTZ21Ma0NUN09vUTNLb01xS01SUW91?=
 =?utf-8?B?QjU0V1o5UHhYMllvOVg1cGRSQ2hpUVorN09HL0pidlhkUDVIM3JGM0l3eU9S?=
 =?utf-8?B?RC9lUGdxbUxZYW5yUzNEZGtuM3JrSVhUUTlONTFWY2tBMUh1Z0U5Z0YwcU92?=
 =?utf-8?B?RklaMHluRnVVK2hjSzNFNkdtaHkydEZ6WUZ3dEZzeHh5V3RyaDdmL0wrOEhP?=
 =?utf-8?B?RFhSRE1SaGwvK2luVEZZaGtnVXBTOFkxNXhqbHB1ajZ6NjZWbDVHTUErcTRU?=
 =?utf-8?B?R1Z3SmhsMFNTMmFCVWR6RVVha2E4WUJTYjRuZ21HRWFEU0NESElSRjNodFY1?=
 =?utf-8?B?MjJDOVhBdWhPQ2E5azJ2OFVXOXFZNGc2SHllVnh1MVJtdDNqeFhnelFJUGhO?=
 =?utf-8?B?VUcrZmtCZHEyeGdtZEpLS2tvNk9MYjZtbFRTa2h0eEtKQ2lCNkVSamF1TGRT?=
 =?utf-8?B?V2ozNnYvdEN6MVNYa09YQk5VV085YWRiZVR3L2lONnpaQkJIV2FQSHNsTnBK?=
 =?utf-8?B?MmFKLy9wWE5yMjd5bnpZNS9lTVdwWTNEckFoNXJuaGNjdlQwTGFXeXdabkVh?=
 =?utf-8?B?YVN5VWVvZ2JIYTFpMkNaTEpxWmUwaXlmVk1WMXNFUmxuc09manN4R0V0djRn?=
 =?utf-8?B?RVBFNGtWOVRQblZDTVFwZ3dBdjhsQk5HK3N4cjd3cDFDWkVTMzVYY3ZuMVcz?=
 =?utf-8?B?Qk5CMTJGQ2lhY3pZNy9LcWVUUk5nOHZXSW03djE0OXhXMGF2bmF2ZmxOOGpR?=
 =?utf-8?B?N0h6UXhuOTR1eU51YTc1K0tVWFd4azdtaHFNNjEzL1N5VWxHaVRQZWpLMHIx?=
 =?utf-8?B?NCtOYjM2OGdJSUZRSDR4aDcvK1gwUEt6RHZoNmFJb2hneTNUNXJsMnJWL1dC?=
 =?utf-8?B?Z3hVT09XSytWTXdzZkZUdzRKUjNzQnNaYjgrYnVNWjdTVVNIc1NERGUzcGNw?=
 =?utf-8?B?dGNhL3B3a0ZOZXRERVBwbnVlaExLVW5ncFVnVDNUekZnMnpQMlIxZDk0cEMv?=
 =?utf-8?B?RlBnajR2VkhkT0t1RHN2N0NyL2VUQXhwN3pVS3EyYnBKaHlzeTQ4eXdlUDBr?=
 =?utf-8?B?eDZaNWlsbW1sc0pJNTV5STV4T01OSHl6dWZsY2xocXo2bjdTTWFDQ2hEYkMx?=
 =?utf-8?B?WGZMNVVJTnY1TnF6cHI3VTR3TS9oVk1pbHpwYU51djZNd2REaVhUN1VRUXZE?=
 =?utf-8?B?bTZjTUNZUG1aajVjTVhVUk1jQ1pZeVVSWUgwQzBXbDdrSWxxTkZvZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36118948-9420-4c4a-0ee7-08decced6e2c
X-MS-Exchange-CrossTenant-AuthSource: DSSPR12MB999236.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 03:55:26.3705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iOj/rqanYOYpVIHqewq0q9/7uPXI0pWnBaa1M5mQQKKJdkT5u2YIkbiKJ0gVycD/dsLAlQp1M/303n8RkXyzjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7727



On 5/31/2026 3:44 AM, Weinan Liu wrote:
> On Wed, May 27, 2026 at 10:19 PM Suravee Suthikulpanit <suravee.suthikulpanit@amd.com> wrote:
>>
>> +static void __maybe_unused free_private_vm_region(struct amd_iommu *iommu, u64 **entry,
>> +                                                 u64 base, size_t size, u16 gid)
>> +{
>> +       size_t unmapped;
>> +       u64 addr = base + (gid * size);
>> +
>> +       pr_debug("%s: entry=%#llx(%#llx), base=%#llx, addr=%#llx, size=%#lx\n",
>> +                __func__, (unsigned long  long)*entry,
>> +                iommu_virt_to_phys(*entry), base, addr, size);
>> +
>> +       if (!iommu || !iommu->viommu_pdom)
>> +               return;
> 
> Should check if the page pointer *entry is non-NULL before operating on it.
> *entry  will be  NULL if the caller encounters an error during alloc_private_vm_region(),
> it may attempt to unmap and free a NULL pointer below:

Thanks. I'll take care of this in V3.
Suravee
