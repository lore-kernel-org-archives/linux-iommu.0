Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010032.outbound.protection.outlook.com [52.101.61.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4922F52FE34
	for <iommu@lists.linux.dev>; Tue,  8 Sep 2026 11:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788867772; cv=fail; b=MbIorPNXdi49o0z7NTsIaOj6oLFOZGWQSaL4FrEaQyAhrRu/Y8S6KSYepSvIW+jGPjglRTsPuHDmv6GXlc6lhhD/N5+oeTVIFEpJ2aiDIkzLykJfTzM+phhxjg3Q1O3QWxYvH8+cfXzzVcfGTPPDXrKTtcH3WWRZGXHxl7DEykg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788867772; c=relaxed/simple;
	bh=sgLkv8wEVpTJQRlcbrFk6TCRCxLN3Cf0P/WvNWvuHSQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qSiKEF0oVoYzgTuJbC9WFw/G+bMjNsPjVRtqTxkLdYGULLTX8GzvYTWCFAozYjjbmn9MCIdtROlhnnz5fgjzGqyiI4aMKL8dVa8UzIywUtCuxnG41dLRhtRwWStY8bVLj0/+RrijpT8/z2tw+f9os7SvwcZIdHX59b4hHM4VOC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PGmOmf4n; arc=fail smtp.client-ip=52.101.61.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PGmOmf4n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TIhkIv27+ubABoqWGOR69yJrQsBSYJvmctNCLmmQlFzQQge6K44wwz3YkOTCGGC1XQF8wlGPDp+H+1vsVwFXT09wTQ8UC4SUr4aaAFB1V8sT4PtbzKiJhErRh/H66A+ubTKXd5l3bG3wNvoGMFquxyAFXX/L2qBYXhb8vb8/0uEbt8MQVd6on+KgYI9N4g+/NJmi6+bpziErd+s/71XMUdgO3POm4+kERvOeDibLhXHOhyXDR7t1M0AuoypiRoUwg27DDsuNd8kv6XEOApW7vVKF+HJv/g3k27VNZRLm/+Ba3QrH04hQOo5dnYQztYAxEcvHYrdRgWypbroOm1LiUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpKUJkf3f8f97dA0sWvsE4YiPL6BT+Ul7h08YkOCUGQ=;
 b=a9okztzdZpkkBG54u68eJ74KVXKHluHFNNjAdtLoZOymS0UwG/KEO4iDxfI3wRqHJCDzY9kjxcT4wGJahHWzJBWZZEQbwwqc9JrMJP038RVwPp7jqxGNB/0qOtHLNkzvgcOjWtMzz37laKOZHx2nwhb//i5qgKkSRlHL4TNzkNXlK0YUhj+eVsfN3BLHck3QblBokHC0u4/1yxP9QoRqj30C5yzwug59V027TZ0NSkF1Qezm/0crF6sBHejl/nAZNQnYZT0WlXUL0fjxvh2zHHLsJ3PJipGgADDH19mAHqWCJi5utP9cuWUPp6V2dNIAgNXlxzeCvzbkxShn2BsZsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpKUJkf3f8f97dA0sWvsE4YiPL6BT+Ul7h08YkOCUGQ=;
 b=PGmOmf4nw7jcJ0BzFaaYuHLoviXM0QabOo3V2r32a88niSrGsFKR4ZgJ+AMnvC9AtXdQgK8E847JClTmZsgthPl2q6EJOTPCpnf6p0MJZfKtzOrdCK7wIe4Ir5CQhzsnwzoNbXe9Su7GVjdJ9HtTaIU6p1VHCLqdP/v0sjaw4uQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB999171.namprd12.prod.outlook.com (2603:10b6:8:388::22)
 by DM6PR12MB4332.namprd12.prod.outlook.com (2603:10b6:5:21e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 11:42:43 +0000
Received: from DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19]) by DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19%4]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 11:42:43 +0000
Message-ID: <f854072c-caa7-4ca2-8b28-8dc6cccce9bb@amd.com>
Date: Tue, 8 Sep 2026 18:42:32 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/24] iommu/amd: Assign per-vIOMMU translate device ID
To: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 Sairaj.K@amd.com, jay.chen@amd.com, wvw@google.com, wnliu@google.com,
 dantuluris@google.com, chriscli@google.com, kpsingh@google.com,
 alejandro.j.jimenez@oracle.com, joao.m.martins@oracle.com
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
 <20260727132913.22475-24-suravee.suthikulpanit@amd.com>
 <23d80e6f-b4dc-45f9-856f-fb21b1905304@linux.alibaba.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <23d80e6f-b4dc-45f9-856f-fb21b1905304@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KU0P306CA0079.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:2b::8) To DSVPR12MB999171.namprd12.prod.outlook.com
 (2603:10b6:8:388::22)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB999171:EE_|DM6PR12MB4332:EE_
X-MS-Office365-Filtering-Correlation-Id: ea1ae311-b160-43a9-03c0-08df0d9e4b6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|7416014|11063799006|4143699003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	nUaas/1LtCvOWE1u18Mmv1oTtLYKB5By8/5gtudEjw+4n5tau9SVM9OrwkOoYP6r//dDgOTpyVrDnjDM3/oarvuPFi1TH6PpWEHH4lugmHXP8AxmtCyOEgY0XCQCvKw9b65DTvxXY5yVu0UhYfr60I9b5AGACLsE6hy+lPYc8/mu+WEdbWj5cKPqNGbA6VKMNN5+V3vRu2SvnylG2+J+aHdcW2w170hOmZp86hZzAVKER9yzJF4yuBsle53pJsUlHmIQoyj7awoTrmj5OBrBz8X21xaJPPOWOj+qzm+1WOgU0vn8LgRsEr3pEVjDMpAe3NVmfpKi9hKW76oWckzqTs2FiogwxcCEKVzUPqWd0b1LVQLK3fI7cs8ayLxUNdxDoYL1BzMTE8B04QZeoa3q4yTz0JMQJBcABIhZTFdr9Hr0mgHrFWE37CXLgOVe/mEw9+o7Cef5NVBQspwpmNyXmKhMJM0LffuZ0o4YPYkKPJ05iL7aRav4Ad7Vb2kXzE90+cVEBi4Am/9AtPbq7BWgDnyk89AIaGi2ukpBbNh/ZV1Jl4oEMT0DRvz4SCpB3kz53FzcVybq7GOAlCYF4kOjQz7DXe3gwRWN3OE07/TF5uV1sV8BrX4Q+Mj+IzdlQNqL0KnL0iO9fd+QkmKfTl+/AJv24S/uThAik9enX0iHNh8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB999171.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(7416014)(11063799006)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dk5sd1RGZWp3U3dFNEIxQW45MG8raFkwcU1zZVNUV1VaYnFOMVplS09jVUla?=
 =?utf-8?B?WFlOL3BjUE9BM2pWMEFRM3BBSXdpNEhiek1RSW4vMzJmVHRrRk1CR3QyYkFr?=
 =?utf-8?B?OElzeGdacyt2aEg3Ym1xUU8yaFY4a1BaRGZCdkRweUx0VTRxN2szc29mSkFu?=
 =?utf-8?B?ZThtdDBxODVsY0EvUTJpS1E1VE1vdWExeVlZUm13bjVyNXN5K0p3QUd3bS8r?=
 =?utf-8?B?aUM0ZW53dkFmR0ExK1E4NkUrZ0U3K0Y0WVp1QldUUjZKUGFtT0ZUVzU1YWg0?=
 =?utf-8?B?NkV4WDRQWk1WbkNydThoOFBrQTJlVzZubXhxQWxSdU4yVEJ6V0h2Q3V6cEVB?=
 =?utf-8?B?R244SjhDYXp1QUc3eDJkQ1p3MWlWa3BIZlJnS0hDTWpXS1hvU096VnVEUnRX?=
 =?utf-8?B?Umo3eEJwaEh1Y2V1WjBUNGloWmNkeXYxVDcwOEliZ09wVjRJUlNCdDJTOFNW?=
 =?utf-8?B?dm9LMHRjM0x0WllmZWRJeVd6ZG4vRWZ2OFpzRmlZTkxBQlNBSVIyY1NIeDdD?=
 =?utf-8?B?b1dZL3d5MjVHd1JiZDEyQzYwL3BZVUZobG9yS21IMFJzQkgyQ3c4czJlNUoy?=
 =?utf-8?B?YUZtUTl0bzIzeHFiMkVibGM1L21MclEvdkNMTFI1VVJCZW9VelE2cnpqQlln?=
 =?utf-8?B?a0owaWt1NXZYTDVRY3QwWEZqRUs1SVRhUXNZc0Q1WW1PVmZnNDQra01XNmJ6?=
 =?utf-8?B?L25qa21DWHJ5UjVnTGIxK0hSU1RMUXNrL2hLd0dSd1pGT2RlQ3B2UUVqSnpk?=
 =?utf-8?B?Wi8wS3gzb29pVmFsZkVmcXh1bEhlUXpocmV1SUhXZ3habHdXSzM0K1ArUDIw?=
 =?utf-8?B?dVc1MzhEMHBPWnVqK1VOZ0dNVzZSMHh5ZTFIYlRTMXpsU0UxaEYzTmdheG1i?=
 =?utf-8?B?bzJWS1M5OHVBR2VzOFZpb3dUV0EvMmFqTnlTZ3F4YkNMaGZIS29JZEJONy8w?=
 =?utf-8?B?QXY5aUJMUWtmbEVFRDA1d0lvZTV0eHFmL21rVTAxNlhFRWZ1UVVETFBPVWVJ?=
 =?utf-8?B?VDREeWJDYWkycjhjUnJwK002TjBWTCtoY3Z6d2cyRm9HWTNFTlo1N3ExZExz?=
 =?utf-8?B?b3pXM0FqMC9aRWlNaDNXbHlqNzBOeS9NL2dvZ3U0eWYxeGtnbmZ1WE5JWnlq?=
 =?utf-8?B?WWFYYzFBOEZnR2lIalVWYzN5NWpZb1J4OUtMVUxLNTR1cWhXakxuTm1uWmJj?=
 =?utf-8?B?aXE0Vy9lUTB5UGRYWEFBaFBBZ0xDT0tSRnVkM25XRGVrUDNmbEIxWGgxbEdp?=
 =?utf-8?B?UWJJN21pemVSTXVranVtSVpoTTM3RlNnSHlPYXlZODZkTlN2N1FaWmg2UU1Y?=
 =?utf-8?B?OVhUdW5TTVpodjV6UHNBRVdNNHBzM0F5V010NjJTZElyM0JMNGc3VDl3NWIx?=
 =?utf-8?B?dStpdWNBY1p4SmhIQmtNenY1SnZVZmlTeGRHYWNVSWtaVDdOaXlGV00xTnRB?=
 =?utf-8?B?cGFSWnRUc1U4dUY1TUwrb2pueGVSdUlVYnBtdytwVjhOdS9vK1NwOXNrN1o5?=
 =?utf-8?B?Q0haaGpjME50NmNXbjZSSjMraXFuV3dlazg1cmJDRE8rSjdoUG9oNUFpTzJE?=
 =?utf-8?B?SGlySW1Cd0JRdVFLVVVnY2c5bFY1QVZWc1h2aEVUZHp1TmdzNFZVZDlUQjZB?=
 =?utf-8?B?RElsajBtZFhIdUpwaVVtOFVuZms2MDM4SFFveTBiY05vYnhBRTNtdS96VXZy?=
 =?utf-8?B?UFViVnR0SDFjZlE4eFdGVkRpQjBvZXJVU3FtOWxJWSt6OEd1NndVRzV1cWl6?=
 =?utf-8?B?RmdvQ1BTeDBQcWx5R2hOaTBuZmVETG0yOFhiVSs3WDh3ZnVPdzM1T2EvQTVl?=
 =?utf-8?B?V0lzTzlwb09LLzU0bkhNR0tJeVlXOWh4KzdFWHdyaGQrZlRSTElGTG1IYnlP?=
 =?utf-8?B?RS9hZVIwTXh5YTR6THNBbmM1SFNqYVR4NGFDZlh5a1FJbytqMW9GS00yMTlr?=
 =?utf-8?B?QWtQM2dzTmdCOGpXTElXZDZxMFI5UktGZnFPelg5L29qOXZ2RHhPRHVOWlR2?=
 =?utf-8?B?dmVPaWdXajY2Kzc2WGZFZU80M3A0LzR5Vkx3dHl6VThXbmJ1ZFVwOE5ZbVZs?=
 =?utf-8?B?S2pwWVcvL2pHcU85d1FWU1h0bnA2bmJxM3EyQmRhR2FJSk9xTVJBcG8xeHkw?=
 =?utf-8?B?K3RhSlpUR2Z1aTBvdmk2ZDZMcEVyYWZSaXU0N1JLUEUvanNONGJ5ZUNscVBH?=
 =?utf-8?B?RzZRSkdzT2VCN3NGSllYeS95OFIwd2Zzd1pSTURPSEpKZzgwYWhhVms0b0lt?=
 =?utf-8?B?eWVwWW00clBXN1ZhcWR2VzVlYlZVMjNXSlEvZXVMT0IzRXZkVGMvWnFNRXdL?=
 =?utf-8?B?ODFFZTBrMjVqQlY1eVA1eHVnOTduM3pMQmw3U0xJQS9ZclB1Z25yUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea1ae311-b160-43a9-03c0-08df0d9e4b6b
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB999171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:42:43.4367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OypRgGIQ1+E6b7QP0seW7Utdo40ozU3vF1OovXqXiVM/CWKVd0keQYIqCPLCOzE/vKvNQX4XQEJLWSJkpHqugw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4332



On 8/19/2026 5:18 PM, guanghuifeng@linux.alibaba.com wrote:
> 
> 在 2026/7/27 21:29, Suravee Suthikulpanit 写道:
>> Allocate one translate-device-id per IOMMUFD vIOMMU instance from the
>> per-segment pool on init.  Program translation DTE and VFctrl TransDevID
>> after MMIO reset; clear both on init error and destroy.
>>
>> Add per-vIOMMU trans_devid_lock to serialize DTE and VFctrl updates
>> during teardown.
>>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> ---
>>   drivers/iommu/amd/amd_iommu_types.h |  7 ++++++
>>   drivers/iommu/amd/iommufd.c         | 35 +++++++++++++++++++++++++++++
>>   drivers/iommu/amd/viommu.c          |  2 ++
>>   3 files changed, 44 insertions(+)
>>
>> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/ 
>> amd_iommu_types.h
>> index f288a7b384d0..39cf2c588106 100644
>> --- a/drivers/iommu/amd/amd_iommu_types.h
>> +++ b/drivers/iommu/amd/amd_iommu_types.h
>> @@ -559,6 +559,13 @@ struct amd_iommu_viommu {
>>       u64 *domid_table;
>>       u16 trans_devid;
>> +    /*
>> +     * Serializes translate-device-id hardware changes (DTE, VFctrl) and
>> +     * coordinates with pool relocation during PCI attach.  Lock 
>> ordering:
>> +     * pci_seg->trans_devid_mutex, then trans_devid_lock.
>> +     */
>> +    struct mutex trans_devid_lock;
>> +
>>
>> ....
>> 
>> @@ -124,6 +153,12 @@ static void amd_iommufd_viommu_destroy(struct 
>> iommufd_viommu *viommu)
>>       xa_destroy(&aviommu->gdomid_array);
>>       iommufd_viommu_destroy_mmap(&aviommu->core, aviommu- 
>> >vfmmio_mmap_offset);
>>       amd_viommu_uninit_one(iommu, aviommu);
>> +
>> +    mutex_lock(&aviommu->trans_devid_lock);
>> +    amd_iommu_update_vfctrl_mmio_translate_devid(iommu, aviommu->gid, 
>> 0);
>> +    amd_iommu_clear_translate_dte(iommu, aviommu->trans_devid);
>> +    amd_iommu_trans_devid_free(iommu->pci_seg, aviommu->trans_devid, 
>> aviommu);
>> +    mutex_unlock(&aviommu->trans_devid_lock);
>>       amd_iommu_gid_free(iommu, aviommu->gid);
>>   }
> 
> The comment states "pci_seg->trans_devid_mutex, then trans_devid_lock"
> as the lock ordering. However, examining the actual code paths:
> 
> In amd_iommufd_viommu_destroy():
>    mutex_lock(&aviommu->trans_devid_lock);          /* viommu lock first */
>    ...
>    amd_iommu_trans_devid_free(...);                  /* takes seg_mutex 
> inside */
>    mutex_unlock(&aviommu->trans_devid_lock);
> 
> In amd_iommu_trans_devid_free():
>    mutex_lock(&pci_seg->trans_devid_mutex);          /* seg_mutex nested */
> 
> In trans_devid_relocate() (Patch 24):
>    mutex_lock(&aviommu->trans_devid_lock);          /* viommu lock first */
>    mutex_lock(&pci_seg->trans_devid_mutex);          /* seg_mutex second */
> 
> All paths consistently take trans_devid_lock first, then
> trans_devid_mutex (nested). The actual ordering is the opposite of
> what the comment describes:
> 
>    Actual:   trans_devid_lock -> trans_devid_mutex
>    Comment:  trans_devid_mutex -> trans_devid_lock
> 
> The code is consistent and there is no deadlock risk, but the
> comment should be corrected to avoid confusing future readers:
> 
>    * Lock ordering: trans_devid_lock, then pci_seg->trans_devid_mutex.

I'll update the comment in v5.

Thanks,
Suravee
