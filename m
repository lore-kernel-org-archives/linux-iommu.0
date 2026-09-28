Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013071.outbound.protection.outlook.com [40.93.201.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43055496D5E
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 10:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790591084; cv=fail; b=hjB+6XxMF5Xogv2eg0kYIJ25ve1mb1pZclLSGFFjv/4pCJ3yMxVNqpbUW6zJkFP79drN9oT/cg2x6QMkM9ZOGSB0qE4AfaHUm7RJPLdSgkwTm75GXjaF4Cblt7NP5pQqxsLtk3SkojA8/zC4kcPQ760R2tBu0EA3jS9srdFTQQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790591084; c=relaxed/simple;
	bh=PC6knf5QSaqJvyyfCj7WbzXRH03phu3Wk9eaeGY08k0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b64mWQSQIq6yNsHLUWIERk1FY0CYcsZDwKLumT6prTXmMEs5MnGjkGZcB0yTLmF8Cf4hvol6RUUiMYhfzU+XaWs37BJynkh6kMNlSFxTgC3+aHx9BRq7VwVn8+QpAd/VNjk76G6HmCYudoj0IZDHv+VdYwZAXnykPJfN+UtDm4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=de+NgQl1; arc=fail smtp.client-ip=40.93.201.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="de+NgQl1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SWjMNDWo7iUGyWq0QhAcR3WjNeiXz6dVmeSjuE85CPrF9L0iNpvRhWfbQBY6qb3r5AXBNNokjSwwq0zikNQK7yLYjSqnOjKobSTn68WDKlAzmhqT2ENhiUqpE8y1GNtdU/5W/wAn+8vF1yOAvFmQi7qq1LOIwY4UfSbInwTgT1G8AJAjeWZft/YrPUb+d4pE9ZGrOrci+Tvl7cVKPGH3iTYipcuu3oKp+xcpm19Tq4pjYdIfhn4S9RZr/EEPSg3VzsMJw2NmV9XUc3izUNKQgBG/yJNWWkD9INIy3bXBjjZb9F5/J39eIJl0xnA46hnMmiu1WcH+v6dUBGavctbnUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Pldnu0DdAiRML7Mxtgiy57lCxJ+x+LKc8UBo5bDXQU=;
 b=wu0fsMZpUgkF3DAhk+i+68rghhLfsCYBbMy2F0eH8AdSQekAWAn6+AYqVnPGUMDpx2oI72KvqCLeSKQzobER8tKFdwwcvUOvLJIYh8YOb/dDh0Fe0vQ9gb/2syxE3AuYjYq3I+WkYQbyKntSAqxfeB0PzJVbj9HvwNQe3UaL28onHpfLbUWgurcBGKlIF9V4IFs74kCrfneetmxO4QlwhpmgQsipgyyakXybP2IJdvpaeVBjr2iLPUksx8h936nvK04Uob4wwas4fHobXoVLRzUpb6j9B1lFaBMEYYVPPqBsQrshssw+TjcbGB7cihy9EaiWuniTbSVunrV9Wslybg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Pldnu0DdAiRML7Mxtgiy57lCxJ+x+LKc8UBo5bDXQU=;
 b=de+NgQl1CVyj4EnhYxeZkJ5kIBk54EJzYMoBJLuKOKT9mOUTMo4vTCubnbdndnXPjgNmgt6GGfBakbYKPgyCSL2UOqC0Y9KEdB93qMsJVnw8WH7LHxA7iRpMOIB/HGHsrejjZRTRTCnvRL5Iv8q7t1XOnGEhHosQNmiEiv7D8Zo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB999171.namprd12.prod.outlook.com (2603:10b6:8:388::22)
 by CH3PR12MB9456.namprd12.prod.outlook.com (2603:10b6:610:1c2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 10:24:38 +0000
Received: from DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19]) by DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19%4]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 10:24:38 +0000
Message-ID: <7afc648b-6d4e-4b06-9601-995b6acc7577@amd.com>
Date: Mon, 28 Sep 2026 17:24:28 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 23/24] iommu/amd: Assign per-vIOMMU translate device ID
To: Guixin Liu <kanie@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, joro@8bytes.org, jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 Sairaj.K@amd.com, jay.chen@amd.com, Ming.Shu@amd.com, SooJin.Tan@amd.com,
 wvw@google.com, wnliu@google.com, dantuluris@google.com,
 chriscli@google.com, kpsingh@google.com, alejandro.j.jimenez@oracle.com,
 joao.m.martins@oracle.com, guanghuifeng@linux.alibaba.com
References: <20260914184750.222939-1-suravee.suthikulpanit@amd.com>
 <20260914184750.222939-24-suravee.suthikulpanit@amd.com>
 <d4a0360a-fae1-484d-81ca-c926e4450265@linux.alibaba.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <d4a0360a-fae1-484d-81ca-c926e4450265@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KUZPR06CA0005.apcprd06.prod.outlook.com
 (2603:1096:d10:30::7) To DSVPR12MB999171.namprd12.prod.outlook.com
 (2603:10b6:8:388::22)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB999171:EE_|CH3PR12MB9456:EE_
X-MS-Office365-Filtering-Correlation-Id: 744b7a96-2651-4bba-7107-08df1d4ab305
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|23010399003|376014|22082099003|10067099003|4143699003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	UWQR+Whg3ZVJG38/jxwK1TR7qNMTh766bVwjm/NC8DBAa3bG+CnXxth4MnHLF5lLsrInfaUo0Sljoa1AAWMUhYRbm+rkoEv7+GWWRz+UARsoFtZ8iEYFTjd27ImKfaZ4BY+JARglmlT6ATzM4AFf+/qMk6cLdxmGm64DhTN6vINC53MkNB+Ojz2MbLWxEW31y6uXnC6n3oNOXDvaXqgHetajnWz3aYc25f0LUHiCUxgKkH1F/G0kHjsaBvdXz6zCPorPUzAP8vNIIfem/tKyLmvbE0oxVYalAVm3CcVIXe4paOdcY2Hy+JUSLTnaSDR1ZMS6E7bbgezcP4oEPfpjMLFCAq6iq3psuDzBnurlY3cZc3q2M6lPX86hGOT7I1wqbd1MdVrRXvfW5HYhQjA5+qRdZHkuhlp0L6WHsTPW8KAegHpWE6AcC78y6CbZfU8DKVUcyt63Tezgg2Lx5msSXC+dq/nqdkpA8RCX0by/Oo77pc2JAh2Rs19KAi1En1y6X6vP/Lu/qkxpX/lSlcJWqTPxR/dC1FESH++fbKqSfevYB8SZ6RRnQOhzNOkxmsHb3ort6REUvoB/I9vN0Sb27NNISVYxcoGlWDze/zJqmfxnpCjgHHZJyPXhknTnwKieFZGmT3Pz0owQEnFnm6b1u8AqNpvB9p7w4TQqxVk8e4g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB999171.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(23010399003)(376014)(22082099003)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azBGRlJkdW83bHR6QnhJSmZQQVhiM0VpTXBDZWwwTTNHd0VQTXJlL3Y4WUFF?=
 =?utf-8?B?NVJYb2k5QWJ2N1NBazJjRUp0N0hCeXY1N1pGakcxc1Z0Q3h3bXFLZ1d3SzdF?=
 =?utf-8?B?U2JQSHhQbGExY1pXaXFSTmtpaDEvL1lFSVZLVUcyN0pUVXRRVStDVTA0UFUz?=
 =?utf-8?B?dGJTd2RudkYwd1ZZY3VSRE9Cb3lSR0NjYTdGNWJLcndXeEI1UFFiczVwYTVW?=
 =?utf-8?B?Tyt0T0FsQ0NkY0ZxZnBZbEJ4MEE4OUZQaW5xMmFRSEtMY3kxelVMdnBpRDBD?=
 =?utf-8?B?cTQ5TWpwVnhtZnNpSnhxK0JDUWxDK2xWYVI3L2Z2YzAzTHZKbStuQVFvUTJy?=
 =?utf-8?B?T0IvVWJ3c3dYcW5YSkt6OWNEY2l4cFRqck5LRzQ1SldkVm9XMnh0NUZqWWRx?=
 =?utf-8?B?OG9SdXNBVEZ4OGptU0tVckg4NmZJSVhucWRSQXRYa1NJQ21tQW9yWVdNdy9Q?=
 =?utf-8?B?Z3NtSEoyV3hsaEhXVituQ3lGSGZXQml0U21OTUxWMlB2NVlNNit6QVBvYUZZ?=
 =?utf-8?B?RGwvREd3cVlYM2w4ZlNjSUVhZjhiUFVFM2VLaVgwREYrZHhDczlZaStFSEdt?=
 =?utf-8?B?anVOVzFnSWpuNFp0emVvZEF1MHNVcXp2emhXbFRxUDBFSFVQWDJWWlBnVVYv?=
 =?utf-8?B?Ti8wbFdKQlpGVXRXVUNTY0VvQVZyMjlNQ0hNNlF2c0FjTFpqQTA4UDBMZXBI?=
 =?utf-8?B?ZDFUc1pSWmZ3SnFzdTYzd2EyTm9RSTg0ajJZeFMrUUtJa3BDaHNkYTUwaVZW?=
 =?utf-8?B?Z2RrUmpYd3dXOWVFNzVqWDdoYXdIai9lUXFkMUNGUjB3Nmludjl3eHduOG5O?=
 =?utf-8?B?YkFtMTdETFloNlMyalNrYXVUbGxORGp1eWVlNUFzRk9nNFppazdJYmhoN1Bt?=
 =?utf-8?B?RjdXR1g4VGJKR3BMNERFSGtUcitoMHJOR2dHc3FLVDZwbHNzZWMzdUdCM2Ur?=
 =?utf-8?B?UEpTcldKSTE2NHpSRGNFNjhjdHdvbVAwQ1Zha0o4RitaUEFLT0VZejJzUVJn?=
 =?utf-8?B?ZittVTlZRkIxQ3Y0K0NxWEFwVmIzc0hBeXJaRExNcTZjUHBDaHJyVmltZGJh?=
 =?utf-8?B?V2NFWVhPeFNRMTFzMDZDSlRFaXhSNkhQWWdzNlBQTjB5SWtSMUkwY3ZOVG83?=
 =?utf-8?B?a2N2eXdtMjJRRXU0L28rd005bnI0dGlwQzhMRnlOTll2MUp4YkdreU0yNEZH?=
 =?utf-8?B?WTNPVnBld0FsdTgzNHpyT2srYWk4Z2ZWVFFINWVZZnZDWHVlNm9ETUJ5MG9l?=
 =?utf-8?B?VUV6aEo3bnNBUmdzQm94dGJKVFdMQU5jeTJidncvZVpHaTRvdVFsb3dFdXFR?=
 =?utf-8?B?b2M1QnNwaWU4SDJqekM4bjVxMngyV2RUSXZjb3l3dXZnbjMzUnJISmVPOWZm?=
 =?utf-8?B?bmpSLzB5NzRzNzhRWm9pRmhsK2JRTnE0aVhDUmhaSUViOHJjbHV2Z0hJV1dw?=
 =?utf-8?B?UDg4WityRjZrL2ZZenNhNS9YSmxLVzZNb1N0QVN5ZlpVbVZsWHZ2SkpIMFJS?=
 =?utf-8?B?RGUwenF1ekpGRk9qZmZjNGVEdURWZVBUU0k4MjQzVUNTSjNlT0Rwei9TQUFT?=
 =?utf-8?B?TERCcXY4V1MzYmFFbUdaMUpPaUUwOFJod3Rqc1dmNmdPbUROTTlyY0tmTHhD?=
 =?utf-8?B?cG9yemtQR2l1dHg2aUMxL0M4QVkyVHQ3NjAyaWJlWVdpaE5RaitVeWhCR0JO?=
 =?utf-8?B?Q1RtRzFaa3liL05RVWFySlNhMkh6dHhqUHdIR1hvMmxTUGs3RzRubUFGM292?=
 =?utf-8?B?N0RGWTV0QUhkOVpRSzVzVGlKM09vOHJmcFRmSUJVMVZ4RG1uajI4UlhScUU1?=
 =?utf-8?B?WGpYaXljMWNYZDVMK0VyZmVsRkJxVWpzYU15d0l5NGI0QlhHWnJwV3ZuOG42?=
 =?utf-8?B?TWZYMkVjWU85d0lSK0M4bHFvWVVJKzVzL3B0YnhvazZRS1RHNlNhdytkaEk4?=
 =?utf-8?B?ZlMwMjd4QjVybm9pMktIZ0V6YXBPNi9lalk4ZVZUeHRlYzNpSHlldERRVnhQ?=
 =?utf-8?B?UU9WazdGUXk1T1pmN2V5eHJrWUVvVlFTZzRiSS9tMlY0YTBCQ3pxdlB2Tkwr?=
 =?utf-8?B?ZGxzU0pKZmVSQWtpTzZmUWVKRWpSN2pjTGZzdWlZVjVvekFzRldGS2V2QXdG?=
 =?utf-8?B?RC9vWEZ3c29MWHpxUFV1Y041L3ZTMDV2Z1F4RTJjbW5GRDBBck51M2R6SElU?=
 =?utf-8?B?MnVFTHE4OFN0TGpQNEdCZVQvWlZKWDhtQTYvTVdRM0JmUVNOcDRRVTkySXdU?=
 =?utf-8?B?OFlDMkNWcFBOakhNNVR0cHRUa25QUko2OHp6RDhJcjVwUkp6c215RjE3dXk2?=
 =?utf-8?B?b0Zya042MzdiZUJFVW9XNWpQNGR5MFllOUJ3NGVSYkY4NFl1NFpVUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 744b7a96-2651-4bba-7107-08df1d4ab305
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB999171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 10:24:37.9466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S9dpVuqLfHiTZrskCMYsFRBV7KfMlOfJy0emhX/GTITFGsszfXb2/qpCXajB9rxIlVuWHNvW9ZvVXekku+CTOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9456



On 9/22/2026 2:09 PM, Guixin Liu wrote:
>> @@ -93,31 +98,63 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
>>   
>>   	data.out_vfmmio_mmap_offset = aviommu->vfmmio_mmap_offset;
>>   
>> -	/* Reset vIOMMU MMIOs to initialize the vIOMMU */
>> +	/* Reset vIOMMU MMIOs before the trans_devid is visible in the pool. */
>>   	ret = amd_iommu_reset_vmmio(iommu, aviommu->gid);
>>   	if (ret)
>> -		goto err_init;
>> +		goto err_trans_devid;
>> +
>> +	mutex_lock(&aviommu->trans_devid_lock);
>> +	ret = amd_iommu_trans_devid_alloc(iommu->pci_seg, aviommu);
>> +	if (ret < 0) {
>> +		mutex_unlock(&aviommu->trans_devid_lock);
>> +		goto err_trans_devid;
>> +	}
>> +	trans_devid_allocated = true;
>> +	aviommu->trans_devid = ret;
>> +
>> +	ret = amd_iommu_set_translate_dte(viommu);
>> +	if (ret)
>> +		goto err_init_unlock;
>> +	trans_dte_set = true;
>> +	amd_iommu_update_vfctrl_mmio_translate_devid(iommu, aviommu->gid,
>> +						     aviommu->trans_devid);
>> +	mutex_unlock(&aviommu->trans_devid_lock);
>>   
>>   	ret = amd_viommu_init_one(iommu, aviommu);
>>   	if (ret)
>>   		goto err_init;
>> +	uninit_on_err = true;
>>   
>>   	ret = iommu_copy_struct_to_user(user_data, &data,
>>   					IOMMU_VIOMMU_TYPE_AMD,
>>   					out_vfmmio_mmap_offset);
>>   	if (ret)
>> -		goto err_init_one;
>> +		goto err_init;
>>   
>>   	viommu->ops = &amd_viommu_ops;
>>   
>> -	spin_lock_irqsave(&pdom->lock, flags);
>> -	list_add(&aviommu->pdom_list, &pdom->viommu_list);
>> -	spin_unlock_irqrestore(&pdom->lock, flags);
>> -
>>   	return 0;
>> -err_init_one:
>> -	amd_viommu_uninit_one(iommu, aviommu);
>>   err_init:
>> +	mutex_lock(&aviommu->trans_devid_lock);
>> +err_init_unlock:
>> +	if (trans_dte_set) {
>> +		spin_lock_irqsave(&pdom->lock, flags);
>> +		if (!list_empty(&aviommu->pdom_list))
>> +			list_del_init(&aviommu->pdom_list);
>> +		spin_unlock_irqrestore(&pdom->lock, flags);
>> +		amd_iommu_update_vfctrl_mmio_translate_devid(iommu, aviommu->gid, 0);
>> +		amd_iommu_clear_translate_dte(iommu, aviommu->trans_dev_data,
>> +					      aviommu->trans_devid);
>> +		amd_iommu_free_dev_data(iommu, aviommu->trans_dev_data);
>> +		aviommu->trans_dev_data = NULL;
>> +	}
>> +	if (trans_devid_allocated)
>> +		amd_iommu_trans_devid_free(iommu->pci_seg, aviommu->trans_devid,
>> +					   aviommu);
>> +	mutex_unlock(&aviommu->trans_devid_lock);
>> +	if (uninit_on_err)
>> +		amd_viommu_uninit_one(iommu, aviommu);
>> +err_trans_devid:
>>   	iommufd_viommu_destroy_mmap(&aviommu->core, aviommu->vfmmio_mmap_offset);
>>   err_mmap:
>>   	amd_iommu_gid_free(iommu, aviommu->gid);
>> @@ -140,6 +177,17 @@ static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
>>   	spin_unlock_irqrestore(&pdom->lock, flags);
>>   	xa_destroy(&aviommu->gdomid_array);
>>   	iommufd_viommu_destroy_mmap(&aviommu->core, aviommu->vfmmio_mmap_offset);
>> +
>> +	mutex_lock(&aviommu->trans_devid_lock);
>> +	amd_iommu_update_vfctrl_mmio_translate_devid(iommu, aviommu->gid, 0);
>> +	amd_iommu_clear_translate_dte(iommu, aviommu->trans_dev_data,
>> +				      aviommu->trans_devid);
>> +	amd_iommu_free_dev_data(iommu, aviommu->trans_dev_data);
>> +	aviommu->trans_dev_data = NULL;
>> +	amd_iommu_trans_devid_free(iommu->pci_seg, aviommu->trans_devid,
>> +				   aviommu);
>> +	mutex_unlock(&aviommu->trans_devid_lock);
>> +
>>   	amd_viommu_uninit_one(iommu, aviommu);
>>   	amd_iommu_gid_free(iommu, aviommu->gid);
>>   	mutex_destroy(&aviommu->vfctrl_lock);
> Should destroy trans_devid_lock too.

Correct. I'll update in v6.

Thanks,
Suravee
