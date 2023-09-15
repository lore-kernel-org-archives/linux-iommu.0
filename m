Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A510D2FE
	for <iommu@lists.linux.dev>; Fri, 15 Sep 2023 08:27:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VcLmnFLFM2Ho/wn87HRp+jEEHeRFy8fRfeVTy+P6rfCrodcx528qJw1EiC6aSWTVLxo1QK0s2j7FxvCos2AdNZ4jdi2c1drLxA2FcUlDS5yfHBpsLQpHbQVNiCiAR5dxTer8PX1zf7rfAQ6U6tf9iRP3NeJ6m+yCG9vILV4FtdUQlnofe7GYzd29DYTNBFw55B7oX/a3A/HODYmbo3d5pZ9gFWvy3UjX2UGxUpoA1YvcQnI2Y5Tc1x4PA/Q8c0S/OXEVyO7K9bsQ5fwzlownaQbDNMhhDiYSMx0eLpwApJExvGpbZS15S1Ij/KDCHSIOysT5pZbR1zPDJdIK/9tVqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FIIZnfEDo3y373llPgfJUjkNNSUWcJBMusdPc/15crE=;
 b=oTsZklK9gzEvDMdx5lyOyEL4boIPdG+P97l3+KC0r7gG4bztmanorJKJpyyTRnwH1OKyUJkYP4thA5juvavE9iL3ZFp7I0WUGLOeqfxuK0zZ66DCj7vCfkyfwYjwRIyKVjSbBsjYk+2Laf7GdDY1pmPJDnkPJkA+e8Qoj8I62pknBVGSOie+WxrFqSNXuRhputROBpBT9fzkFF4D4AyBiW6ElFHUvNAX03FC+RxpuFY3fAKubm6OvC0ynVk0VSxYtJtfMgkNZ77s5Qtp7ucU/yOxyhG4a1+zILFwhGsSjgQLQ4iAP8KoJsw3IzMFor6o2uW6rjV2aKvnF8LpEtAHLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIIZnfEDo3y373llPgfJUjkNNSUWcJBMusdPc/15crE=;
 b=M7WSDX1fFs80h5WjUvIgdRSi3VPYRtOoUYXR9MaPhZtcqAha3wuEDGmYtIsikKf6R73J+7DsQZfBVlPokHBOCwP0x1X1KdF11NPCqJ2UdrZ3cR/w6I8jSQiy8+V5zveWjz7EgbpsIDBhKONZJaAChocuczs0CK5w6P64Q+CqUhc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CY8PR12MB8193.namprd12.prod.outlook.com (2603:10b6:930:71::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.21; Fri, 15 Sep 2023 08:27:07 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::cb74:f20e:dd21:d763]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::cb74:f20e:dd21:d763%6]) with mapi id 15.20.6768.029; Fri, 15 Sep 2023
 08:27:07 +0000
Message-ID: <57dfeefb-5a21-3e18-46f1-851de56a3037@amd.com>
Date: Fri, 15 Sep 2023 13:56:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 11/11] iommu/amd: Introduce logic to enable/disable
 IOPF
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20230911121046.1025732-1-vasant.hegde@amd.com>
 <20230911121046.1025732-12-vasant.hegde@amd.com> <ZQCSi6ROWVrIZEux@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZQCSi6ROWVrIZEux@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0212.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::11) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CY8PR12MB8193:EE_
X-MS-Office365-Filtering-Correlation-Id: 319d2e88-d3d1-48a0-f1f2-08dbb5c58bef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JTolQBEbpxNRYNMjvAbAY1HyXHcsfoRPIBqimLhdF3xmyiGq2n1cnQJRK7l7XCsxk9Tqmvvclifvv/UpX9I3AvmfJIYUbb7K1np9Ij5gNfyA5CdU578DaIgG5LCDeBRVpvvwVkt5j98EScG+QfBRKNVpTbb3P+RPcAwR13kzxdMHwh3LlwfmArnibyuzKFfv2M3K0KwMilKpfRIbgtVMN793G289VXEsnIKlcXB4KfrgDIDiZFAKJzbPy/D/p3ieiz2J+JPBfMOm6zRhfZ3OetdhEi2dytRcvL6lekPMm8Nfb1AXzGKGdEogD6b5iezRVENPS9Amk2inlC3n3HqTG8A0eJKYP01uolsuXypuiDoKlvoxTFPcY1H6jfxnQpiIMNufgwiKGUEnEQBSsEWtsrcY7inCH8C7QAkvf3YEG2ryEgo73RinPkd0VdM04EVReMG6S6NtqbzAyplWZqbaV0cQGWpA08fuV3xZt4yNMOBGIRGXKhe56WweqW4jncZdzukSKdD/qG15EaGscEDfoUdVmL+HLAEIdte/YOCDnZcM4Pb4xAFmAni201+5BbjyNrqjHVwszx2/ku3vk/jdm0wPsIYKNiw1XXIka2l489Wq3zY8qg/oFKb/fS7n83qHZ2ZXN17S4WZtRc6GwT/AWA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(39860400002)(346002)(376002)(1800799009)(186009)(451199024)(83380400001)(478600001)(38100700002)(31686004)(2616005)(6506007)(6486002)(86362001)(26005)(6512007)(53546011)(6666004)(31696002)(2906002)(44832011)(4326008)(8936002)(5660300002)(8676002)(66946007)(66556008)(66476007)(6916009)(41300700001)(316002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGhPSkd3Sk5TM3dlWUZGWlYraGZKZk04T05vVW9XYm9CUWljeU52Rk0rZUVn?=
 =?utf-8?B?NnJ6bStvVVBNRVRDSDEvMnFMUHhRRllsUlpjODgwL055T0lhSmg4aFk2MVlC?=
 =?utf-8?B?MnRYdXV0OXFNSkVOZEZWMlk1NmN0Mlh3SUZ4Z2NoU2RLV3NjNVFpbHRpT0xI?=
 =?utf-8?B?UlV4TityTlJocjNTS0FYWFpieWYveFJRYXFRNmFoRnB6ZFE4UmZRTC9QSERj?=
 =?utf-8?B?UWpkeTh2K0E4VGZzcEhzWC9IblY0MU5tYmJQRUpZN1NPZml4b1ZJdkxobzlJ?=
 =?utf-8?B?QWRtLzJtUGN4VFhtRDVhOUZvRjV4U3FaQ0JieFBSdGhkUm5kQXduUEtRSU95?=
 =?utf-8?B?d0pCV3Q1Q2h1S29wZkJuaUR3aE5uRSs3bEpsS2haSVVTS0F5SnozMEJ6VlBX?=
 =?utf-8?B?bDltSGVXclBEZjR4bEVtUmh4OHRiNFN2NmF5Zk1aaCtSVDFaaVVGZEJGQzRo?=
 =?utf-8?B?WnZzTk1sT1hCK0x6OUN4aUdJbjhKd0tUSmczWmEvaDhrT3RVOWlZd3pBT0V1?=
 =?utf-8?B?ci9QM1dsVEFnZjdielpUVmJhWGVFc3BKM1BvWXpVMEJKRjV2QWk0akRhNENv?=
 =?utf-8?B?SVd3djUxcVRsM0o3RXRpSUlmNDJKdXRMdmsyUjZzWDhiQTF0Z2NZdVF6TkZ0?=
 =?utf-8?B?SWtwcDBGVTBUQ2dLQk8vV3M2cVhad3ZoTkQ4REpOSUNmU0pEVDNkazN0R20w?=
 =?utf-8?B?RnNuWG5NOXdNRTZJOW1VK1RkTFcrMkxIbmJSWUJJR1Y5K3pBMXdpU3B6WXZx?=
 =?utf-8?B?STVoNnFPSS9IUGd0Uk5rZEthdjcwL2daVXA2aW5VYTAzL0VBZUdrUEFaWHpk?=
 =?utf-8?B?bm9sUlhhb3JWbURqSkowTzJYZHVJRTE3ZUM0STNVYXNWSDFZbGgyQzVWdSsw?=
 =?utf-8?B?VE45Z3B3ckNMYUxUSjkvc01hYTZrSGNTdHRybVF3Y2ZHc2lTSmxCWlByRGpX?=
 =?utf-8?B?SjBqOEVqUkkrTk1rV2VCUGloMXlBd1lUVnBheGppKytzM1JaTmUxb1VobXoy?=
 =?utf-8?B?WnUxZFlkbk9naXU0c3BYdithK1JPN3lJTDl6elRxMmViSjloYXQwUmU1WEFM?=
 =?utf-8?B?cXE0Q1VLbzB4U2IvOHBJREdGU28rQlMwNkhzVGVOcTM1d01hNjB5SFpTeG9s?=
 =?utf-8?B?djVvaG1TZXhOQVRTaVQwQ05tUGUydnY0SUg0S1lESlRuN3VlTFpkaWRHeDFj?=
 =?utf-8?B?WEl0K1ZTbHRzWVMzVHVaZ21RYThucHNScVdRcStidGpHZVAyMG12TjBBbW55?=
 =?utf-8?B?QXIzYmVQSFVNR0NSSGxGUUFFY1BuRE9yS1NCZy9XSUVRUGJGTkFOMW1iSG9I?=
 =?utf-8?B?RmNTbXVSV2MyZ1NPMHhqcHorOSt1LzBYQkZwV1FDQzk0M2gvRTJwMzM5c3Ew?=
 =?utf-8?B?cUhWcTdKekt2NytVa3RBNThzbWlOWlF5Z0Flc211d2pnUTlISmVER0FtTHVl?=
 =?utf-8?B?MXk1V25RREZpeElTNUx2MXBrRllmVTgrTVZMcytOU2VBd0VhWVY0U1AzVEZw?=
 =?utf-8?B?a21HbWtNMjhZVHU5aW5nSndjME1KbGpsUExqUkpGVnkySENkSnphcjFLalBu?=
 =?utf-8?B?ZDV6aEpOZkFlVHlrVEJ6MUc2RkYrZDZVVFhYc3dJa2c1V01CQWlBUCs0RUZS?=
 =?utf-8?B?STV4aldheG5KbWxWVFJaVytpNkJpTE50ZVBWdG1DakNVWk1wSDBFK1JnWW9j?=
 =?utf-8?B?RGkxSURxWlVVRU5tWVRWandubnBxeUcxWHU4dGhObXpzZU1kZXhmRTR1Lzdp?=
 =?utf-8?B?ei9ZdW5aZHUvYjU1c0ZwbXRpNkRlVjJBK3AyeG1BZ002aVgrQzEvdEVubVhh?=
 =?utf-8?B?S3E5c2lIdkt2K3dKdVVtREdNdzlZWi9WbDNMbDBpNnhXSzR0V0MxZEovSHlh?=
 =?utf-8?B?TVZnR01vb2phcGJ3NThxMnJhSXB5S0ZLOTNCcDl2QjloT0RjclNCMVMyNytO?=
 =?utf-8?B?TFNzSjRadW11QmdZQk1CeEg2VzkyWlUyKzFnUVM3M1VveUhEK1IxZ25meUtM?=
 =?utf-8?B?UC8wbjM5Tk1IdjYvNFU1NGcvdUMrS3cyWTdndHlQTm9LaWEwZ0w4UG1vOFZL?=
 =?utf-8?B?aUNGaEhpeXdvNmU3c0VJbWltanpLekVkd2VNVXJZb0JxZTVkMU92K3BLTnRy?=
 =?utf-8?Q?Rdf1QdonQwxutzQPLBO+UAqRZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 319d2e88-d3d1-48a0-f1f2-08dbb5c58bef
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 08:27:06.9480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xbuURS2vvCxQn3BV+bK5bb5GELou9CRWE+MjqEfrwrT+ecxq3crWNQQr9L3LF4s3MVMSHz9YfxRZDsiqk+sY3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8193

Jason,


On 9/12/2023 10:02 PM, Jason Gunthorpe wrote:
> On Mon, Sep 11, 2023 at 12:10:46PM +0000, Vasant Hegde wrote:
>> diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
>> index 2891f67a6ca0..86c0cb836a71 100644
>> --- a/drivers/iommu/amd/ppr.c
>> +++ b/drivers/iommu/amd/ppr.c
>> @@ -9,6 +9,7 @@
>>  #include <linux/amd-iommu.h>
>>  #include <linux/delay.h>
>>  #include <linux/mmu_notifier.h>
>> +#include <linux/pci-ats.h>
>>  
>>  #include "amd_iommu.h"
>>  #include "amd_iommu_types.h"
>> @@ -306,3 +307,58 @@ int amd_iommu_iopf_remove_device(struct amd_iommu *iommu, struct device *dev)
>>  	raw_spin_unlock_irqrestore(&iommu->lock, flags);
>>  	return ret;
>>  }
>> +
>> +static int amd_iommu_iopf_update(struct device *dev, bool enable)
>> +{
>> +	unsigned long flags;
>> +	int ret;
>> +	struct pci_dev *pdev = dev_is_pci(dev) ? to_pci_dev(dev) : NULL;
>> +	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
>> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
>> +	struct protection_domain *pdom = amd_iommu_get_pdomain(dev);
>> +
>> +	if (!pdev || !iommu || !dev_data)
>> +		return -EINVAL;
>> +
>> +	spin_lock_irqsave(&pdom->lock, flags);
>> +
>> +	if (enable) {
>> +		ret = amd_iommu_iopf_add_device(iommu, dev);
>> +		if (ret)
>> +			goto out;
>> +
>> +		dev_data->ppr = true;
>> +	} else {
>> +		ret = amd_iommu_iopf_remove_device(iommu, dev);
>> +		dev_data->ppr = false;
>> +	}
>> +
>> +	amd_iommu_domain_update(pdom);
>> +
>> +out:
>> +	spin_unlock_irqrestore(&pdom->lock, flags);
>> +	return ret;
>> +}
> 
> Same remarks as for the SVA, this is in the wrong place.
> 
> iopf_queue_add_device() should be done when a PRI enabled domain is
> attached to a device, not in feature things. I also want to remove
> these too once ARM is fixed..

You mean we should do this during first device/pasid bind time?


> 
> And the iopf is a device wide thing, it makes no sense that some
> random pdom->lock is protecting dev_dev->ppr..

Will fix it.

> 
> amd_iommu_get_pdomain() has improper locking, it needs to hold some
> kind of dev_data lock to access dev_data->domain. (and really this
> would all be clearer if it was just written dev_data->domain instead
> of the redundant function)

It helps to get iommu from device structure. Its useful and we want to use it
other places as well.

-Vasant
