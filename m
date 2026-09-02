Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013062.outbound.protection.outlook.com [40.93.196.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C983476CD8
	for <iommu@lists.linux.dev>; Wed,  2 Sep 2026 12:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788351415; cv=fail; b=belH+xXGkcoa4R6sCfFVhEs2GQCdJB/rLPhvD11jzdWjjHMYk4gVWP8HtoKQ6Ar/NoSq4oh03HsV9eBOF00/UhsR17yT+bmXcbFMPfhNjxtKj3DQHJ1A1rMne5fQ0Bla5ndSCelVydu4TO5BFD006YJUtL5o+UKK0qJuXbdnNGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788351415; c=relaxed/simple;
	bh=GkEi6kayd4MDsImB+SNWu7ea/1J4xV1CuBfN39wsdjc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eFrQX1ZN1bwTW65wNKivrdqXdb/D/guyV7I7XQGPcakEvuLnQiNTHfNZSW6asXHa6MpzJytxmoTHBdgS2SZeTpHtjsYc1NOXWoMG9l0MAtyiSIkGQu5yR1KqjMX2gK8KQpFwaOdHU5lZvQP9jcDH8kR3mK7Gxvpwuw9sr40Ytn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tuCsOToe; arc=fail smtp.client-ip=40.93.196.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tuCsOToe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YtTltxyA4GG9VjHNu7azieUt+8b4F9J0ZJSb0AkkwEPh6fA/1g4CP68ZnM9lvVRlv5d8zPvBgkHvZdzMJcih7ZakBsdFhVWGEldHoUo11RisAz/AD/w5aQTQkplrjWDKkpBZS3PXWk3L3ORTXnzR5rWkRPL1sm7ZPg+aqWzr/V11pC5IesH5UMKd1Grkjkzn5xzE8VOWvwLeogljvkZUeUeCUn2z+j4yzTWvfdcJH7bl0emIcZ/7yxyeNQDbdQ/NLcRb7RsjJuiiW0clIIFx1wpYzYVHNc3Oj3D+3JPhSgXEs9mIeABdkqMqHL8oUKIC64VLOIFgjdgZj/tFAL/JFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4aV0G3gcv38rj5pP8pBCTA7EoKputjHnQ1g8vRQOHKk=;
 b=OFyN7jlf+GrCkt/OheXHZ9Gd8WHqivZK2Fgj9cSn+ESZ2st9QIpJPVbzMN3R046zqb8tQ3DsNk5l8P9kawOr3k0z/4tneFG3fj6fURifiwBV1PV+gtmkIrznnx1P+4whiFMH4nV+mGSdzh4mLZh/CWmeSlbabPm2W8A0keb489UNGYsmoLb9/J2fF4/g2EVG643Gy9I0Hg09eWljAfdQfFblCdVPeuylDzn62+6nQAPINuGzbuDn+BSiGdfpl0Xr6ne+FJdDkO1XhLETes9Ke+zXikD8ld4TuBIkGN6GfMzUH4h0lLwR+aus6yIq/5iXxwhrH32BDwX/NwUtYZvOig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4aV0G3gcv38rj5pP8pBCTA7EoKputjHnQ1g8vRQOHKk=;
 b=tuCsOToetMMvdsD5O+3D8oLMhOrge75AyGNKeULRiFk5Oec0HjVy2J+PkinWd0KF24noODu4TvRGxKzeM5JCsK0PjSxgSd9Xa31AyVy1r9qCkOFBUzpdGi41QCzMCLUFGmhtc9Chr2Ua5yQiFYZO88rjANJ448UcD/ydBoeRBxg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB999171.namprd12.prod.outlook.com (2603:10b6:8:388::22)
 by IA1PR12MB7637.namprd12.prod.outlook.com (2603:10b6:208:427::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 12:16:47 +0000
Received: from DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19]) by DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19%4]) with mapi id 15.21.0382.007; Wed, 2 Sep 2026
 12:16:47 +0000
Message-ID: <0f8c3b25-feb3-4a6c-b258-1e8a66ed238f@amd.com>
Date: Wed, 2 Sep 2026 19:16:41 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/24] iommu/amd: Map vIOMMU VF and VF Control MMIO BARs
To: Vasant Hegde <vasant.hegde@amd.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, joro@8bytes.org, jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 jon.grimm@amd.com, santosh.shukla@amd.com, Sairaj.K@amd.com,
 jay.chen@amd.com, wvw@google.com, wnliu@google.com, dantuluris@google.com,
 chriscli@google.com, kpsingh@google.com, alejandro.j.jimenez@oracle.com,
 joao.m.martins@oracle.com
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
 <20260727132913.22475-7-suravee.suthikulpanit@amd.com>
 <4a7d6c45-0fa9-43f9-b2f5-414449ce0dfd@amd.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <4a7d6c45-0fa9-43f9-b2f5-414449ce0dfd@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::8)
 To DSVPR12MB999171.namprd12.prod.outlook.com (2603:10b6:8:388::22)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB999171:EE_|IA1PR12MB7637:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bc248c3-52ab-4979-2f41-08df08ec0f43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|6133799003|22082099003|18002099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	q/vKlLO0BIcjNdzjhVk2q1z2R7FWWhufeO61it2b7zmHTYrg1ywyw0bZ8hEqB+7fyZJKmZShxZ84OeFS+cv7kU37N/0CmOObl7eNsNxK3M7G8hzUoocgt9BxxS3ilTTCLyFz/N38lVcZceY+ht3PgLiMIVlvz7s1A84JhiDUTFskMb98Yhd4wZ5HGuXbo2yioLb0weDPlXXh3fT4YSQI5t41Vowz0egan9JWn9wTYtCBkLQ7+vo1m9pCwvsyDXXZ4UeJPFc6CVLEdKsSR/BSXdSODBY449YnEIqz/MXfazk1XoclH4Y2aoU6nQCNQkwb8YVGLmT6ilrxh5SR9lKGgRSxPSYdpe5eTSRbFG/0SLd30a3YEUz2ls0XT5NSZLfsXB63SKp+Tz7OHWKPgJ8iyYc5YilmrzXV8u+O5YL/Rg4ypzlfdqtv8e0U251uKxGVYPa8uUrASmIbeX7VIJaxNM7RmrVnQJiNoGP8M/wurf8myrM5Yy1wagnIr5McCKpOw7zkKxsoR3EN03ucm3beUWwF4NDImGH2Mrz4Mht+twRG+iRi3yLTKKTz0qLlSAqIi0Dmad6rl4QgQ9RmuoGh4pG7XD6gJrOAWaJ8E7G7V9X1s56Pf3K/QRULwdj6YwGif2jUyw/XCcQEwsWVmvqaVn8Uo6ocj/jGOhN4wEFCZPA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB999171.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amRSUFZ3RGZHRE5HWXgwVzZrN1c0QTJrM1lwN2tIVDRFMWhJZHA4NVQzTFE2?=
 =?utf-8?B?SHJDVWl2TzVzR1ovaVNVKzJtbzNDQllLbnZZcittTnNnbkFlYkgycWszZTVo?=
 =?utf-8?B?RE5MQTBGZW5iWjRyQ0lQSUJxcSt0aitjdzRlUm9ET1VnVmhoMXdMS3ZXOFUz?=
 =?utf-8?B?Z2pxR3VSc3BKVGN4SWdyb2REMGIxOFloOE8wK0d0Z285Z3VXN1RlVjQvR2pP?=
 =?utf-8?B?eUdmZVdDRlB2WDlqSG1qa282ckdicHJWT2pCZ3ZVVFFDMGE2akp6eGpkUm5n?=
 =?utf-8?B?cHFmTGMzV2lQM09jNW5pdEI4cVp2RHYydTdDU1hkUG5tU0VTb056N1prVDln?=
 =?utf-8?B?NmJxejRtVVZYZkYrclU1VG1rNVNTWDE3WFgrdnNCa0FpVktiNnlXUTRkSEZi?=
 =?utf-8?B?dG5xdXNPdXJDZHd3Y2JNemJGWGZ1WTk0TFhOdTZ4bWgxQjBJQjJCVHNKdEZ4?=
 =?utf-8?B?dnhNKzltN1EzVTFTdTVmVUxsdklzS09kVlVsbVZkUmE2YmxiUU9TbFlCZmor?=
 =?utf-8?B?bTBRODBoalpralF5T2x1WHhreG5GSXNDaGJIWGdLd24rNk12VzI2b0ZnKzhK?=
 =?utf-8?B?TDUwVFRYNHJqZFQzeTRQUFpqMTg5MmNtS1dxZWV5a1FUcWlCRUV5U01sbmhC?=
 =?utf-8?B?M29oN0NBZ2ZoWm9KL2ZSN2oyMWpzblZLRzRHSnlOSFgya2dKV3RCa21INnpE?=
 =?utf-8?B?aXJBMkoxanRyb0FQNmpxdnZLL2MvK0c3c1RCUUxPNHgzdFU0V3N3dnZjYjhY?=
 =?utf-8?B?L2tIQ3ZRU0doTFF1NEVsaUpyOW9yeFlSeU1nS3p3dEU4bm5mVkJIRmJsTFRv?=
 =?utf-8?B?QWMyaVRlQ3l1K0VrNUY4ZWlGZW1vWmxDbjA5WHRQay9MVkNXamdvSEc5a0Fz?=
 =?utf-8?B?cmRLVGl2aUswZXN0bFFPcjF3M3lyeHdaZkpLS3dScUZuZlR0L2kyZjhIY3RD?=
 =?utf-8?B?L1pzL2R5Z2Y4STI5ZEZ6Qno4Um0zTVhNeXNZNkJGWHRmQ05SRk42S1Jndk14?=
 =?utf-8?B?cW0rcHJTWXROODNSKzJ1V290eTA0THRmaVJyek5KcHRWMWdtRDY3TzdqU2ww?=
 =?utf-8?B?M3IrT2hJSlVGc1BMZnpGM3MrVGRYOEMvTjNBaXNCRGhaK1huNTB3U3k4bTFr?=
 =?utf-8?B?Q1lRWGhKWi8xbDhzanBrL2RHSjRCV09jaSt6cnR3R0dGS3pqVFU0RDNPTkxU?=
 =?utf-8?B?MHBucDh3cnlBSk9mNGxmK2puRk1kMlQ3dE5LYlMzR0NVV2Fqc3ZJQkdWc2pl?=
 =?utf-8?B?TTRmVnNhTGhGVXZuS2RJaUhlTG12ZERaUi9RZm9PN2tPWElCZVpqT3VXcUl2?=
 =?utf-8?B?ajExUkgyTmFBWkxPSVZFeU55Q1lJdHpBMzZneklzcmhGSWE0YVVBNFNZcEQ1?=
 =?utf-8?B?aXVQN3lEUGlWRVFQaHRLc0VmZDFmZW03RUd0SzBuTVRSUlBSMFhvc05UUzJy?=
 =?utf-8?B?enl3dDY2alFHeGN4WURLeERMcXgvUzVDUFNMMlhFbGRIU2VtdDQrc0FrV3Ju?=
 =?utf-8?B?WG8vVFJNTnBycTlFQ2JLb1hadFhWODNKS21ZbXZ6eEtGdmlSc3lRRWJKb3c0?=
 =?utf-8?B?OVgyUXNacEIrZjZ1WURnZ25ZQ1VWbFJJMFZ4UjB6elJOSEdDVGJlZVRSa0Jy?=
 =?utf-8?B?SEIzVnlUN0tTaHA2VHl1RDhCeTI5dFN4eis2L0VwZEZzK0ZXQ2FHWTQ1QWd5?=
 =?utf-8?B?MU8zME1UTTV2RDhubmEwSmJGanVRY0NRcjYyeXhGVHBzZ1hocVp2RVVBNWxT?=
 =?utf-8?B?ZVJKUDhFemJ6QlRpU0I4NDh6bGVMbjNIcHdnNmkyM3ZaMDVaMmlvMnczaUhZ?=
 =?utf-8?B?aTRlNk5FVmhXbkFjRjdjNkZIYW9sbVZaT3EwUkUweHJyTHhIc2xwV3M1WUhK?=
 =?utf-8?B?anFMSktRYXZTNUN4VmYvK3ZGN0ZrUUpqVVpXZy9wcWdYZXFGL2NSdnVaYU9N?=
 =?utf-8?B?TE1NZlJaWE5LRi9MeExaTU1nMDhLMU5xdnZmcVhTOE9yaXhWSXR5bURPMzAy?=
 =?utf-8?B?M21vRWgxWnVCU1d2cHZPNkdGcXlwZmxHVHdnS3h6U3pDeDNiTkwxc2tteFZ5?=
 =?utf-8?B?UjFNU21OYk11M0kzcEVSRkFSbGNsUC9POTJJT0NZNUs0NEhKWUV6NlpWa0xM?=
 =?utf-8?B?K0FSTThNMzYrTjl2cGRxcldqdkFDYm40SGpSWG83NS9iS0s0ZDUvZ0p4WHVR?=
 =?utf-8?B?NExwWVdjTnozaFgyRlR0cE0zdU1mRmhmN1JVY0c2ZWlPUDFMeHlmS3liT3BQ?=
 =?utf-8?B?WmxSMFFEc0ZuTWVHY3haSzhLR0hVc1lqcnBCbjJJdWx1U241eXVSdEIzRzhQ?=
 =?utf-8?B?U1JuZmdyQ014SmM2dWJHbnhBQmtQbGJZOVF1dVp2S3BuVVFBWS83QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc248c3-52ab-4979-2f41-08df08ec0f43
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB999171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 12:16:47.5521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OGaVyZHqbn4lTscZ2zlLYLzUXr5Klvafpb8SdvQ88qExLUZAums3vFbNsK8AzFE/qNOUBAR4uGAGekRQzzvfFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7637



On 8/10/2026 5:00 PM, Vasant Hegde wrote:
> Hi Suravee,
> 
>> .....
>>
>> diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
>> index f4b5f96d4785..014ae16bf58b 100644
>> --- a/drivers/iommu/amd/viommu.c
>> +++ b/drivers/iommu/amd/viommu.c
>> @@ -7,9 +7,15 @@
>>   #define dev_fmt(fmt)    pr_fmt(fmt)
>>   
>>   #include <linux/iommu.h>
>> +#include <linux/amd-iommu.h>
>> +
>> +#include <linux/fs.h>
>> +#include <linux/cdev.h>
>> +#include <linux/ioctl.h>
>>   #include <linux/iommufd.h>
>>   #include <linux/amd-iommu.h>
>>   #include <uapi/linux/iommufd.h>
>> +#include <linux/mem_encrypt.h>
>>   
>>   #include <asm/iommu.h>
>>   #include <asm/set_memory.h>
>> @@ -18,12 +24,130 @@
>>   #include "amd_iommu.h"
>>   #include "amd_iommu_types.h"
>>   #include "amd_viommu.h"
>> +#include "../iommu-pages.h"
>> +
>> +LIST_HEAD(viommu_devid_map);
>> +
>> +static int viommu_init_pci_vsc(struct amd_iommu *iommu)
> 
> May be viommu_find_pci_vsc as its not initializing, instead find the offset.

I'll remove this

> Also if we pass vsc_offset to viommu_vf_vfcntl_init() -OR- call this function
> from viommu_vf_vfcntl_init() then we can skip tracking `vsc_offset` in amd_iommu
> structure.

Ok. I'll refactor to consolidate viommu_init_pci_vsc() and 
viommu_vf_vfcntl_init() and remove vsc_offset.

>> +{
>> +	iommu->vsc_offset = pci_find_capability(iommu->dev, PCI_CAP_ID_VNDR);
>> +	if (!iommu->vsc_offset)
>> +		return -ENODEV;
>> +
>> +	DUMP_printk("device:%s, vsc offset:%04x\n",
>> +		    pci_name(iommu->dev), iommu->vsc_offset);
>> +	return 0;
>> +}
>> +
>> +static void amd_viommu_gid_ida_init(struct amd_iommu *iommu)
>> +{
>> +	ida_init(&iommu->gid_ida);
>> +	iommu->gid_ida_inited = true;
> 
> Once we remove `gid_ida_inited` may be we can call `ida_init` inside
> amd_viommu_init() itself.

Ok.

>> +}
>> +
>> +static void amd_viommu_gid_ida_fini(struct amd_iommu *iommu)
>> +{
>> +	if (!iommu->gid_ida_inited)
>> +		return;
>> +
>> +	ida_destroy(&iommu->gid_ida);
>> +	iommu->gid_ida_inited = false;
>> +}
>> +
>> +static void __init amd_viommu_vf_vfcntl_unmap(struct amd_iommu *iommu)
>> +{
>> +	if (iommu->vfctrl_base) {
>> +		iounmap(iommu->vfctrl_base);
>> +		iommu->vfctrl_base = NULL;
>> +	}
>> +	if (iommu->vf_cntl_phys)
>> +		release_mem_region(iommu->vf_cntl_phys, VIOMMU_VF_CNTL_MMIO_MAP_SIZE);
>> +
>> +	if (iommu->vf_base) {
>> +		iounmap(iommu->vf_base);
>> +		iommu->vf_base = NULL;
>> +	}
>> +	if (iommu->vf_base_phys)
>> +		release_mem_region(iommu->vf_base_phys, VIOMMU_VF_MMIO_MAP_SIZE);
>> +}
>> +
>> +void __init amd_viommu_uninit(struct amd_iommu *iommu)
>> +{
>> +	amd_viommu_gid_ida_fini(iommu);
>> +	amd_viommu_vf_vfcntl_unmap(iommu);
>> +}
>> +
>> +static int __init viommu_vf_vfcntl_init(struct amd_iommu *iommu)
>> +{
>> +	u32 lo, hi;
>> +	u64 vf_phys, vf_cntl_phys;
>> +
>> +	/* Setting up VF and VF_CNTL MMIOs */
>> +	pci_read_config_dword(iommu->dev, iommu->vsc_offset + MMIO_VSC_VF_BAR_LO_OFFSET, &lo);
>> +	pci_read_config_dword(iommu->dev, iommu->vsc_offset + MMIO_VSC_VF_BAR_HI_OFFSET, &hi);
>> +	vf_phys = hi;
>> +	vf_phys = (vf_phys << 32) | lo;
>> +	if (!(vf_phys & 1)) {
>> +		pr_err(FW_BUG "vf_phys disabled\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	pci_read_config_dword(iommu->dev, iommu->vsc_offset + MMIO_VSC_VF_CNTL_BAR_LO_OFFSET, &lo);
>> +	pci_read_config_dword(iommu->dev, iommu->vsc_offset + MMIO_VSC_VF_CNTL_BAR_HI_OFFSET, &hi);
>> +	vf_cntl_phys = hi;
>> +	vf_cntl_phys = (vf_cntl_phys << 32) | lo;
>> +	if (!(vf_cntl_phys & 1)) {
>> +		pr_err(FW_BUG "vf_cntl_phys disabled\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (!vf_phys || !vf_cntl_phys) {
>> +		pr_err(FW_BUG "AMD-Vi: Unassigned VF resources.\n");
>> +		return -ENOMEM;
>> +	}
> 
> Redundant check as previous check confirms both vf_phys and vf_cntl_phys is
> enabled. If we want to check non-zero address then we have to remove bit zero
> and add check

Good point. I'll remove this for now.

>> +
>> +	/* Mapping 256MB of VF and 4MB of VF_CNTL BARs */
>> +	vf_phys &= ~1ULL;
>> +	iommu->vf_base = iommu_map_mmio_space(vf_phys, VIOMMU_VF_MMIO_MAP_SIZE);
>> +	if (!iommu->vf_base) {
>> +		pr_err("Can't reserve vf_base\n");
>> +		return -ENOMEM;
>> +	}
>> +	iommu->vf_base_phys = vf_phys;
>> +
>> +	vf_cntl_phys &= ~1ULL;
>> +	iommu->vfctrl_base = iommu_map_mmio_space(vf_cntl_phys, VIOMMU_VF_CNTL_MMIO_MAP_SIZE);
>> +	if (!iommu->vfctrl_base) {
>> +		pr_err("Can't reserve vfctrl_base\n");
>> +		goto err_out;
>> +	}
>> +	iommu->vf_cntl_phys = vf_cntl_phys;
>> +
>> +	pr_debug("%s: IOMMU device:%s, vf_base:%#llx, vfctrl_base:%#llx\n",
> 
> better DUMP_printk ?

Actually, I prefer pr_debug().

>> +		 __func__, pci_name(iommu->dev), vf_phys, vf_cntl_phys);
>> +	return 0;
>> +err_out:
>> +	amd_viommu_uninit(iommu);
> 
> Its odd. We shouldn't call amd_viommu_uninit from here. May be call
> amd_viommu_vf_vfcntl_unmap() ?

I'm fixing this in V5.

Thanks,
Suravee
