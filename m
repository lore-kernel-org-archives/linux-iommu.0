Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010014.outbound.protection.outlook.com [52.101.61.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32945483800
	for <iommu@lists.linux.dev>; Tue,  1 Sep 2026 16:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788280376; cv=fail; b=T3+OyOq3JMNYtmPAifldoQChZb5RAS48oSsKRfC7dhZW6MK0+jAj/DioO5NYR/cdtsg4UEcqeOr2i3jjUsqjebIjSL+ziOnETy1vGVTsrn23hdF+/X5hgMhyMviS73BMRZU4mFL1/jS4eD79b0hvLvv71NUrLskZXg2n9Rbg7fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788280376; c=relaxed/simple;
	bh=ioZfLLun6IJG91dAGXn9R4cnEi6AQvYvlq/XjRXnxbg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oB+eU8wL16M8MaCBgQ0FGVnKAzeR/d4OZ9KDP6Qwy9rQ8urdMjXBErUHYuJX/PKwobJxRcbBcqYBsehDD0KG4D9bRBYBVlIykuFFIgn80ibuAnpWUYMmyrrQm41XNgPthymUefIfNif9FIM/dCtGgpvfONlKfNKMBMQNt63d2MY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OXjTqMUM; arc=fail smtp.client-ip=52.101.61.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OXjTqMUM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PTp7jwvcxnVH4EbvQXYTvA2jutX7/Lwsg1o/aeOhmKBzHCs/YwI8Fav/DV7vDk3D1ox97uAfggWSYKtlhBrXDAFAMdlW1Li2xeeJibs53h1p7ieLaM61g4f8MJHZR4r0AMgP17pmPVBXW8sUZfHALGCs454JN8wAgb8LUwOMI/o0icvKNivB8Jdx9wd28z5Yzv9Y44mzaDJ3vj/ZccmUILtGkxNM44Ttu/0Io03n1wOcbjF6iGvnN93jI411eTngvTEjsv13xGaBEpZfKnUKGUB0f7/99bOL0N/7mXs+5Fw1WmoT17Utdb2phEthYuLVzAhND5N2mYka1M4StfB9MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGa9HQJ5wIEgU3FCBp7PPMzCUBK77CJrGcDYBDuSauc=;
 b=yVqtZvB60i18sm8y/e5I99bIzseBRMT+cpfTsd0PpWvK2qDPKiJRJZuT+fw5V2dRBSzRIu0C7pc8bDOHb6LJ+djsB3ymERyEZHjuJr/tuN4/VgMiVP3kPaXSvO6DBpq3pumEoItpeSlluBnMkDZzvZrBMq4o0RGerEmm1CHaKRm9/4QPecvO7Xy70eHqDCt89cn/w/hQlbANhqCWHyY69T1yShl43frF/PyR1X4v6bjjzpXSAIiFfbQL7i97f7V9DooSQE+vSzlTjlwi90KshJsmZ5bwcUeS2FmdJ2+VSyq9oDuVAQ6pO3V55RKuvdK/nayO2p21MbHg6idAjHb8gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGa9HQJ5wIEgU3FCBp7PPMzCUBK77CJrGcDYBDuSauc=;
 b=OXjTqMUM3AeluiiV43dRk0gMjDpqwyvtX0+EVHsu3YJH7yC8Fy2FK0NUtsNqer8l7XeHXWXcubqlii5qPNekU/Rz7PMFHDMM1mrwMTFU3SPkUMF37kHOPYaYBuHjE81BOVV2Xwoq8bqoCesEU1tkcEmZ8XmZkYf9g+WO9ySWDlA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB999171.namprd12.prod.outlook.com (2603:10b6:8:388::22)
 by EAYPR12MB999181.namprd12.prod.outlook.com (2603:10b6:303:2be::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 16:32:51 +0000
Received: from DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19]) by DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19%4]) with mapi id 15.21.0382.007; Tue, 1 Sep 2026
 16:32:51 +0000
Message-ID: <7b4e4f45-2abc-40dc-8852-0da07e9de17e@amd.com>
Date: Tue, 1 Sep 2026 23:32:40 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/24] iommu/amd: Detect and initialize AMD vIOMMU feature
To: Vasant Hegde <vasant.hegde@amd.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, joro@8bytes.org, jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 jon.grimm@amd.com, santosh.shukla@amd.com, Sairaj.K@amd.com,
 jay.chen@amd.com, wvw@google.com, wnliu@google.com, dantuluris@google.com,
 chriscli@google.com, kpsingh@google.com, alejandro.j.jimenez@oracle.com,
 joao.m.martins@oracle.com
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
 <20260727132913.22475-4-suravee.suthikulpanit@amd.com>
 <13fe61ea-fa05-4eb3-9ae0-1a1de261ea0a@amd.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <13fe61ea-fa05-4eb3-9ae0-1a1de261ea0a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:195::19) To DSVPR12MB999171.namprd12.prod.outlook.com
 (2603:10b6:8:388::22)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB999171:EE_|EAYPR12MB999181:EE_
X-MS-Office365-Filtering-Correlation-Id: d529d427-784e-4a9c-e2fa-08df0846aa72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|10067099003|4143699003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	2LsiKgrgRsdbmYlICXdRsYqnYWNVs4XW7a7w5FLQbhiDWlHH/7BoyaSEZQlpWyux9cKErlIuifvVO5J837nrmKExogtrp0kpg+Xj4df4GsdMRytW7XKCgWwHgHQv70ikxQq7M2way87TBvMsXmSPyFMD1bm6xaVA9HNV9BlONU/IodlOhHeQ5/TgFqWwcYpXMfbYV6iauLQxcXM7jc3K53w/q6nP4vlQiCHk4OZBZ6IeVl3n1/dWw3XU2Qqo0I9PLx3+pC5GnZVEqcKv0MdvZh1OhCpA6tVX4VZszBaHHAXCgmIiwiTa6ktbqAIdln/nEwRfzO2E+OJcqaHluk8B88m8Zc6BkfIVzPqrEXxUTN8oDJHYgE/C+QLNi0S1b5yHg5zLWrWEM/ANf1iCaVn+WbJgrGk7+R5EFLeS53D8Rm9Ir0u/HfKOPI0wersxfjq67Dt/5xB1tMk5OkFy7vz/gKLpQod0XBMsKEE261iRCN7vD1/KSzCLjW3ClhrdOeDmO2jplCqP3OzLzypuMXlJ+JmwlrQZSDFytwACrmYuDiqlKnmg+H3WqBmhIreWFikjN1aG58RvN/EOAN1mc/yGhVNwzsi8hwd8CZef4nmTTG9i5Ycid6/4T04lZbl5GldQnUtJhsuX4wgudrh2XGcPkr0ePuOKd/I5FSW7MwQk/V0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB999171.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1NjdEY2QzdVUjNxT2ovSlRoQm54cU1XVElzYkFyeXV3djhnb3JtS1hjdkpo?=
 =?utf-8?B?OVREUFFzTlFXZ2JoMEQ3RFB1QjVqY2hMamRKVGxTWnRWWS9rdVU5RlRSZ0tI?=
 =?utf-8?B?Wnp6M3FNTm5lMDNHVkpIRFE3K2xCQ1pDTjdRRTdyQjYwZ0NxV0xSRFhNMjhp?=
 =?utf-8?B?eGE1RnI2QVpSSDJWdkp5QlVsNktWUWE2MnNVRkhnZWkyVVk5d2tTK2NUcnpu?=
 =?utf-8?B?SllmdkFrOWNGeFVWRVVwdjVrSWxXcm9tdkRsb3hVWDR1bmhxTEVhaEJhUk5T?=
 =?utf-8?B?QXhkQ3g5U2pjckZzL3k5d3g2Zmd6UkdWQnJxUk1xTURLY0YxYUtrWDRhTHpU?=
 =?utf-8?B?Tk8yNE1wempTR2J6YUxIYllBakRXTGE3ZG8zTlF0WUMyR29RK0RUYVJSOFV2?=
 =?utf-8?B?T0NZc21HeC9ueHQvVXQybjQyTVFhRUc0dVhiRGM5T0dNaGZtWktrK1NEV2FB?=
 =?utf-8?B?RHRybElKcEhKQWg2bk5lUE9ibUhUbUE1RkpsdGxmUHIvU3pJbGZkcWF6ZUNW?=
 =?utf-8?B?aDZqTWNXRXpOMmdZUUJvYVBWRkN0R1Q5S28vMXlOS2xLaWlibWIyd2dHK2Q4?=
 =?utf-8?B?N2EvYXlXaDRBd2RXalZSVHl0ME50OXpML2hkR3N4Nnh2RTlkL25IemRkK2g1?=
 =?utf-8?B?eFdGcUNxd2puYWFBbTVDRkVmSFRhNU8zSXMvZmIvVDg2OVBSdWxQMlFuSWUr?=
 =?utf-8?B?bkxMcThGaTZtdUZZVFEycTZQQWl1YWRZMXVNVmpaSU5oSS9TeEozdE95RFVm?=
 =?utf-8?B?blRJV1IzTXI2MkdOS3pKUXViV05EVXJhaStGREJIR05YeVNTVkk2RUh0Ly9r?=
 =?utf-8?B?dHpaSFdwcytiV0pFNGR5eWtHSW90RnMzN1A0OGFQWk1vQ0ZaSVI4TVNQVmdQ?=
 =?utf-8?B?ejd1L2REZ2QxYit2VDluZFNrMkNHWVV2cmthTnBBdXVlVDZTczJPT01pU0JL?=
 =?utf-8?B?eXV5VlBmNlRFT09TZ0Z6bElzT0lYNnJVZk5aUHFGdjIvMU5DbFhWbmV0aUR5?=
 =?utf-8?B?M3JDZnhtdEdqUmhJSXd4N2t4S2ovOHVWOWVSTHVpanE5K2tGNTVTbUNZcCtT?=
 =?utf-8?B?QjBMdWpSY1RQSlpMOHlVL005TDRFVkhFc2FFSzFqMWlxZXZvMVBva0h2a1ZP?=
 =?utf-8?B?SGVHcGJwbWJycWlWekxkcGFCdTFjWjIvdnhzUlZVdEpqL0xvbVowM0h5NUdC?=
 =?utf-8?B?eTRSQXo5NDBXajZoT0pPNDdsR3ViWFJieVdiNmNVMldQYzZuek4wVmVsTE5x?=
 =?utf-8?B?VXNMekZ5SXNuZjdQaU81aThpek1yMU9tRURiM3JkVTBOMlQ4SHFMcmh1clQw?=
 =?utf-8?B?eFNhZTZIQXhRN2FyeENEVUpEQnh5Z3U5MEs2S2lMbjUvN2VIdHMyamdMcm40?=
 =?utf-8?B?eEdIYW1BMFhNQkZFc2FaS1V2Mng1UERKRGg2UHozZEVwRSs4NlJrQzlQZXJW?=
 =?utf-8?B?emFmZW5FbHQ5aFk1ZU5qMFFnSkpsbWNqSXFrYlVJUHpOakZhTXZDRzFISE1m?=
 =?utf-8?B?MC90VzY5QkhhcXRwWFJEamdnYmpVSHBWSmtrZXVSRlJUbTNQQzVnYTlVQlNP?=
 =?utf-8?B?Y3FWZjZqNjdzV21DSWVPMlg0ZE83ZkhUNmtvanlpRDRuYldLUUhTTzJ5dzNl?=
 =?utf-8?B?OXZqZEh0UzZybkZLSDhNbytpbW9laXowVmppanVGQkE1MklFZThvY0FDVllj?=
 =?utf-8?B?NGYrYXZtTGV3OUtSMitoUTZ1ZklGUTl4K1duUWorS0VrYVBXcmxKODZ3UldJ?=
 =?utf-8?B?YlBhMHhHQW9aOFc3VktObEpEakI4NVVROHMyanJ6WVRUQzhZZmF0ZG5kRlVG?=
 =?utf-8?B?MlJQOVJGZ3ptNkw3SlE1MWRtV0I5TVovS1lnZWpXU2VWWnowM3lGLzhRcllM?=
 =?utf-8?B?eXNjdmlCQjBSWkFuVEdwaGx1cjhpR20veTdIZy9PaXJkdVhDbno2N3pSVldn?=
 =?utf-8?B?emdBYVMzRXpJMVcwdzNPSUhOWDhOZ0w1eHN1dzhtZmFSY2FQdVB4ZFVHYTFG?=
 =?utf-8?B?T2pvYkpXRUQrYjcxMGlURWcyQTZ3VFlrM1NvZnJvc0JuRnkxdHNrV0ljWG5x?=
 =?utf-8?B?SUJGWk5OYUcrNWt6aDhTNFRUd1BHNXYxOTdWZXM0ZmxqaTFscENTeGJKMGFS?=
 =?utf-8?B?WExON1NhdjR1WFZSNlQyQkx6S3F0Ui82QVZPbUpVaU1BUEtKYVRPa25RRU9i?=
 =?utf-8?B?TEhmWUhSU3FjRjdDcWlzcy9pTXgyaWEvanlZK09pekNIZlZTanF2LzN0aE5B?=
 =?utf-8?B?VjNmc3BibmZHM2JFZjA1RlVrZVBSMW5ObUxFcHN3dUxrR2FXTkVvWllkekJl?=
 =?utf-8?Q?Si1Fsbk2ZlPTNfv9sj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d529d427-784e-4a9c-e2fa-08df0846aa72
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB999171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 16:32:51.1608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WcU+8m0cW+eWe2HvrJQOmhmJI41nolDazUkY0aB4iqFPveg9P9wdjiLtdumdgMloW+1KcaFjnggIo4fdXsvX/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999181

Hi

On 8/10/2026 3:13 PM, Vasant Hegde wrote:
> .../...
>>   }
>>   
>>   static int __init amd_iommu_init_pci(void)
>> diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
>> new file mode 100644
>> index 000000000000..f4b5f96d4785
>> --- /dev/null
>> +++ b/drivers/iommu/amd/viommu.c
>> @@ -0,0 +1,29 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2023 Advanced Micro Devices, Inc.
>> + */
>> +
>> +#define pr_fmt(fmt)     "AMD-Vi: " fmt
>> +#define dev_fmt(fmt)    pr_fmt(fmt)
>> +
>> +#include <linux/iommu.h>
>> +#include <linux/iommufd.h>
>> +#include <linux/amd-iommu.h>
>> +#include <uapi/linux/iommufd.h>
>> +
>> +#include <asm/iommu.h>
>> +#include <asm/set_memory.h>
>> +
>> +#include "iommufd.h"
>> +#include "amd_iommu.h"
>> +#include "amd_iommu_types.h"
>> +#include "amd_viommu.h"
>> +
>> +int __init amd_viommu_init(struct amd_iommu *iommu)
>> +{
>> +	if (!amd_iommu_viommu ||
>> +	    !check_feature(FEATURE_VIOMMU))
> 
> If check_feature returns false, then return -ENOSUPPORT so that called sets
> amd_iommu_viommu to false.

Actually, that would print "Failed to initialize vIOMMU" in dmesg on 
older systems, which does not support the feature. We don't want that.

For v5, I will clean up this logic to make sure that the 
amd_iommu_viommu is false when the feature is not supporte.

> Also how about renaming it as "amd_iommu_viommu_present" ? Because following
> patches defines another structure with same name. It works, but add confusion.

I'll change this to amd_iommu_viommu_enabled in v5

Thanks,
Suravee

> -Vasant
> 

