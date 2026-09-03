Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010046.outbound.protection.outlook.com [52.101.46.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED6034027B
	for <iommu@lists.linux.dev>; Thu,  3 Sep 2026 02:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788403304; cv=fail; b=HOuJSbh6Tc9pHcjQ9eFwvMy5Sr+v0r5/aggbENizug+4vPrFHnm4X4HtCCULe27M2+SJacXHKvO4CIIHuLhtOfCABHx135mtAcBX83H3aovhmf8Z1PWPOwt/32MKG1K7c3ExmHnxJN+wfozjxeFM7hdiMLpGry8xhs5HajOHoQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788403304; c=relaxed/simple;
	bh=iGsmd9bGrONe41b/sHa10EdIXR62ehMoVKCON6kRicI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NhjYlwyCEwfMP00kUWTyin273J8i6hSbCmZnwKoq99x7OfW43fD79RM9qwjAfmP25kM1F8+WHneXm+gbLrTziZmwMkcPMB7eCn+SrzNy/RSf61YOMbwdnn5Ulu+UJb7p1WALzdcbyAv8380WtFFc+aQclLMJpvke7S3YRwDqbbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0HAiZW7u; arc=fail smtp.client-ip=52.101.46.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0HAiZW7u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=izXG7Tvj8R19yc/YRgVsItyd1IpLOnyIuTGEzVQ6v5ncuA32GESkTy1ktzVQ+yw0usHeSIMB1QlGhdBChf3BWk0jV35kWVUU+F5lyTJSO48BnkexyaCuaMa487DYl5DKWS1p4c9RG9SSe4kqF/3ntb/r92EAYr7LNtrOwoZHLkVsADROuz77EfycgNwRtlL5BNr+PtMrwwfRy+VeKrtu4qXJQIodfzlVSO5DwU5RL4aSZcLf5oAXZxQ9tj7FEsoqO/16DtOWYtOjRp+FcO1Xcj+pt+fOAprjfVGif4t4HQR4XAuwFZ7I195Zg1kAmftKS8b1OaVsw8Y8Ln+YDajtog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gv4kSuUhVjPKv5I5OHmxJUM2YNrcqrHU6r0FfkCoiKk=;
 b=tamExSZQciAolu5H8N/wiIblb5c30JPrlgoj+sHwinD0W1TDfGIwNjELQ0JEVrhSixm9oETrU/Lqld/6XnK0CsNrak58ALJZJrmatY6fKXDBiQYOLeFTzYD7s0XwubHxqNKtsO7wAyGSL3Nz+KvgUmW0N6uViM3gybAd48eV82Oo7ET8+3bl69DTjd9YcwRaFbf0VQZFzeicud2LqDyeA4cpTaa3vWXdokl2RwmeWaeWgcWxe8T6A69jM2ylmvRX0rLo7XRt9fKjKJTR0LMMdx1XhiTn2ck45WE5dvnnvCuwUKarrvGvpIZjGJmOQpCunl1RL0gGsWi6c8pRr8ERZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gv4kSuUhVjPKv5I5OHmxJUM2YNrcqrHU6r0FfkCoiKk=;
 b=0HAiZW7ugJiNoW6C/i11eeNBdtvusLByL5cyNLx4Ou2QLH0DYhLjipj+ZGXxx6GoopkWkEv1kJifVfzy1IEbiEZS8/QKfW7K6uLtFbWwEOssqrxERTxMd4Qa2+bsJCMPDHTQn4khxh3UPBIjmM/Og2REUuci2Jke2WeEKiYjaOA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB999171.namprd12.prod.outlook.com (2603:10b6:8:388::22)
 by LV5PR12MB9778.namprd12.prod.outlook.com (2603:10b6:408:300::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 02:41:37 +0000
Received: from DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19]) by DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19%4]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 02:41:37 +0000
Message-ID: <073887b6-f226-4802-8a72-2d6a319f9238@amd.com>
Date: Thu, 3 Sep 2026 09:41:27 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/24] iommu/amd: Introduce IOMMUFD vDevice support for
 AMD
To: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 Sairaj.K@amd.com, jay.chen@amd.com, wvw@google.com, wnliu@google.com,
 dantuluris@google.com, chriscli@google.com, kpsingh@google.com,
 alejandro.j.jimenez@oracle.com, joao.m.martins@oracle.com
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
 <20260727132913.22475-17-suravee.suthikulpanit@amd.com>
 <916adcd5-63fd-49b2-b175-c7b509991e37@linux.alibaba.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <916adcd5-63fd-49b2-b175-c7b509991e37@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KUZPR03CA0026.apcprd03.prod.outlook.com
 (2603:1096:d10:24::10) To DSVPR12MB999171.namprd12.prod.outlook.com
 (2603:10b6:8:388::22)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB999171:EE_|LV5PR12MB9778:EE_
X-MS-Office365-Filtering-Correlation-Id: 94cc25bb-9b22-4432-0699-08df0964e029
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10067099003|4143699003|6133799003|22082099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	szulgLqn0ZOm4DTfRxStHK3NXMTD6rHtmj/Nim/NBr89QQX/CEsNedJQ+Jljp9aZd5upk2Xiox2/1e5p7upmFawkGD4qsjLfDCF9Pi5erRhx0KSXP/wF9s9mUrRkEDgo/whyMEzBsf+QUw163svMCRo3P/GoTTl+vp3dtAdTx8gVhWOToV5tzJwxYmLffoSmACsYx7Tn0HmL+d1B0+1rLq3EIrwzLT2OqaoD7yxW3+oheMJf10/jRyUfqb0m/iGUfIq61DrY2nbMKi7kk+yPkeilK0OBv1ZyB9gsiwTqsR7xF9nDKGhpMef1lXkM/FB4rgvj3IElEpnxbMTmyR0k3bhDMEuVb6ZYR0NamCv/KjBCrv9ZwYLxGtbHd2yJzwklNvBA5/0yJyzfUm/jZpN087c/MCzWXVlzcKmWfy7QYAiQ/FwtXo8fqkFtLT0rPcwOgAdFlxh3+6E5gmNTK3w5qRaq6vt1SU1pJYW7BqEnOT6U8l9TmICiQPcSLvA/YWtlyXap0Mya2itZT5j7gUxIRCqKdh++d9di0SylzW4OSIAHohgHGl7YUCqjXiLAhX2KrOpaNg+qBChQ2xqcsOSuoOeSOCoyRpf1jEifF/8bX9ddzfGzr5YAQXGCSE4qEDD/YVEM1ozGvH91F6o2AikPKQW/Yisze42YJBaIcfQcpWg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB999171.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(4143699003)(6133799003)(22082099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFloWGZVSVFHU05CMXlsZ1pGRnJseHk2L2hOc282c3puTlZKVUpMNlFsRHZK?=
 =?utf-8?B?UGlpckxKVWllU3hNTVB1Z2VrU3I3eHR6UEd4QkFIZFJRRGxUZTlQa3A4ZWF2?=
 =?utf-8?B?SHNySzVTa2pmUlorOVMzak5rN1hKUE0rZ3BQRVJHWFpSTlowVEVRQVFvN0tX?=
 =?utf-8?B?UlNqbHd6d1kydVd1OU45TUpWZG1VODdJY2JGR3poMkRwcmRmU3ZJZEJIY2tn?=
 =?utf-8?B?aXkrWHJQVklQcUxIL2hCNVBZVThhWDV5am9rb3BnU0QxUHB3MzU0SmVqSWlD?=
 =?utf-8?B?TVFHOXVhSUdWS3ByYTF6V0QyNWpEMFhITExhc2MwVlVySHRyaVVLWWFNQ09h?=
 =?utf-8?B?cjh5VHhMWUE5Rzd5YnBHNWVOZTNFa3JRUFBDNlp3REE0UVBNbVFqYVg1Y0Rl?=
 =?utf-8?B?TmUwM2ozZ0JxSUp1cngrbmp3SndseDg3MlJxKzJoTFVSd2VHVWJTUEJyUUVy?=
 =?utf-8?B?UzRPMWQweFcwU3Y2TkllSDBZSDVBNExoekNZQStid1c5WER5TFFFL3NBcFk5?=
 =?utf-8?B?eElTVm9RTXJ1MVRHWXV2ZGVwalIyaGRzeU5jRDYwZzBveXRub1dUNFNsRC9z?=
 =?utf-8?B?Q1lHdlhGQWg5YWFwK0UvT3RRREc3QTVVSVpWSkVpcjkraEwyQWQrSEVwYllE?=
 =?utf-8?B?QjlKUHBITEN3eVQ3ZFhRNEJ5d092QzhvNVdkV3hzczFnMU5tQ3Fvd1hWWkd4?=
 =?utf-8?B?aXFFOGlkNTJFNkF2blBFd3ZFZUFRaldUa0xJNlZtbFh1aHErWnExWjdSUUps?=
 =?utf-8?B?bStNaTRKQ3g4ZWpuQ245TGZVYWlpelI0Z3JrcTUwTGJMeGF6RC83T2N3Znhn?=
 =?utf-8?B?SVh6b3pCV21DQzdyQkw4VlRNSVYwVmluS1c2MFgvWTJEY29JVGdQTEJUTE5n?=
 =?utf-8?B?WEQ0NVhIODNOU1U1YUMxSkJsV1hDaGZVQWdkR1J0SUwraVRGT2QxczFhTENB?=
 =?utf-8?B?NE1EdmttZDlXOU5Pd1Q2VmVRUGg2ekRwbkRBSmcrbzduS3lBTjNuVTd0Y3RM?=
 =?utf-8?B?bEd3bTI1VTUwU3VleHlua0pEK0tSQnZ3ZzRzeDVRak5EMFFNK3NocGE0WW81?=
 =?utf-8?B?VzFWeFQ2R3NOZmtPbzVVUU1VRTVRazhSSFZLMnYzREN2RGZjc1VranVGY0xC?=
 =?utf-8?B?dkVLWm1rc0tkUmlzNjdRbHlOaHVJOGlyRkY3d3QvdGloV01Bbm9aVGpVQlBU?=
 =?utf-8?B?dlo3eGtoZGhURmVEUlgyNmp3dEltcktKVHhhclpkb1hKWWl0VHFsZmVvdTNh?=
 =?utf-8?B?YlE4R0RiTXA1b050RzVVNkl5Z2pKZkJJYmd4U0RkNHhBMlEvd1l2bm5QNDFx?=
 =?utf-8?B?d2ZpZ1NYVElVKzhuSVNVMmZnMUdBZFc4NUFHRE9pYXgwTjQ3THlJV1IyY1Vo?=
 =?utf-8?B?WkdPbUZpdnA1TGc1MFZZKy8zVlg5bFpGUmFrMXl3YXVwS1hDRHZQZ3ljVVdC?=
 =?utf-8?B?c2tQVnBaRndRSW9WUVJ4TXQzbnBlSU03L0xuKzVsV2hqdkM1L3JldTJkdjJH?=
 =?utf-8?B?ekM2TTVuTlFlT2hEMVZER3duRUdRbWZkVVNNVWZaS3VxamExY1IxWDg4eFRZ?=
 =?utf-8?B?dk5VeVZ3VzlwaTlLYmhTZERwZmRodWNFc3JGZVg1YktRZ0FYajc4bEFVdjBh?=
 =?utf-8?B?ekhGMWhaYnRVY0VESTlFNkttSURDRWJkQzVGcmFiYTAwMjNFSUUwTDMzNTVt?=
 =?utf-8?B?ZndVcmJNZGtjVnRGUlRteUExOEJGMUEyblhDVlRsTmtOa3d6dEcrYWM5ODlw?=
 =?utf-8?B?eHFRcU45Nkkyd3Z5WGdQaHdpb2ExbDhmTG44SzkyamhXL2J5YUR4Z0N0OStB?=
 =?utf-8?B?eEF3TkNXZWlsYWt6UmxXYjBONCszQ1cvWkFPZE9JK25SaHVQNDhSSUMyZFZz?=
 =?utf-8?B?RUNVWmRBUHBRVHNGSjhvOVlmQW03eHZKRDZ4OXkwU3lrcWE3cDdYS3BMR2xP?=
 =?utf-8?B?M2Yza1FrbEdRMkY1aS9mTUxNek5tK3dRL25EOUg2Z0dPR1ZTRHRTOEEzU1Z0?=
 =?utf-8?B?T1g1R2poekhVRUxjaHNWK3lZSjBTODJ0QTI3TVJLTFMzWVErMXd0TUJlbW1V?=
 =?utf-8?B?aUJTdmdvbm1BSFlpeGJhM3BIejhNeEVnUGZ0RW0rMHdFU25xUnNkMjRFUlNO?=
 =?utf-8?B?aURDNkJsalRyZEN0czgvSnlaYVFiSDVGN2NRa2FnQ0krc1pFM1ZnVmZWTEN1?=
 =?utf-8?B?TkgyOWFrNTNOQ0VKeXVpbmJ6VE9ETGUzMVlUcVJiOHY1RVd4eGw2eWtocGRO?=
 =?utf-8?B?enNISTJRK2U1Q0cyZmQ4bXV1bWYrL25YcmZ3SzVoR0IySGVuakZ2Q29SejZ2?=
 =?utf-8?Q?MRNZoJsXbRK7hbw6A3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94cc25bb-9b22-4432-0699-08df0964e029
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB999171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 02:41:37.3443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: at8pbxj6m0Q17jOg4SMnqOdpO3cO0kdtDv5ZFgMOI33n/n0Tpz6++u2Yrmh3BLCZ0wbUmeYmDXJVBz9c8JlXIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9778



On 8/19/2026 8:34 PM, guanghuifeng@linux.alibaba.com wrote:
> 
> 在 2026/7/27 21:29, Suravee Suthikulpanit 写道:
>> Initialize vDevice for AMD vIOMMU by setting up the Device ID Mapping
>> table using the guest device ID.
>>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> ---
>>   drivers/iommu/amd/amd_iommu_types.h | 10 ++++++++++
>>   drivers/iommu/amd/iommufd.c         | 31 +++++++++++++++++++++++++++++
>>   drivers/iommu/amd/nested.c          | 27 ++++++++++++++++++++++---
>>   3 files changed, 65 insertions(+), 3 deletions(-)
>>
>> ....
>>
>> diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
>> index bfc4b0ec22a9..1975b2932107 100644
>> --- a/drivers/iommu/amd/iommufd.c
>> +++ b/drivers/iommu/amd/iommufd.c
>> @@ -9,6 +9,7 @@
>>   #include "amd_iommu.h"
>>   #include "amd_viommu.h"
>>   #include "amd_iommu_types.h"
>> +#include "../iommufd/iommufd_private.h"
>>   static const struct iommufd_viommu_ops amd_viommu_ops;
>> @@ -126,6 +127,34 @@ static void amd_iommufd_viommu_destroy(struct 
>> iommufd_viommu *viommu)
>>       amd_iommu_gid_free(iommu, aviommu->gid);
>>   }
>> +/*
>> + * Called from drivers/iommu/iommufd/viommu.c: 
>> iommufd_vdevice_alloc_ioctl()
>> + */
>> +static int _amd_viommu_vdevice_init(struct iommufd_vdevice *vdev)
>> +{
>> +    struct iommu_dev_data *dev_data;
>> +    struct pci_dev *pdev = to_pci_dev(vdev->idev->dev);
>> +    struct iommufd_viommu *viommu = vdev->viommu;
>> +    struct amd_iommu_viommu *aviommu = container_of(viommu, struct 
>> amd_iommu_viommu, core);
>> +
>> +    if (!pdev) {
>> +        pr_err("%s: not a PCI device\n", __func__);
>> +        return -EINVAL;
>> +    }
>> +
> 
> to_pci_dev() is a container_of(), so it can never return NULL and the
> !pdev check is dead code. Worse, for a non-PCI device it yields a bogus
> pointer which is then dereferenced through dev_iommu_priv_get() below.

I will fix the code to check dev_is_pci() properly.

Thanks,
Suravee
