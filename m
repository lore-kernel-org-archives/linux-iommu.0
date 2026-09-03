Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011066.outbound.protection.outlook.com [52.101.57.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406F4345EBA
	for <iommu@lists.linux.dev>; Thu,  3 Sep 2026 03:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788406065; cv=fail; b=piugZ4gNmwwH6G9e3WNPV5E4m1+O2cBSXWSHlPSwHD/qXk/O2NoamDnCeTF++MapKr/V5rdvVAVQXV9Pe0UU1+NhWsNsNX0s8on5LhN98OtYCJwUgqvtKtuAzEJVJEdbuoRq/aXY7wiO5FtSAfKFpKQlfPoRkJcY6br7x0rmwhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788406065; c=relaxed/simple;
	bh=Zk2ZUPxLwYfCz1i/lfhcpIx3xVbKsQm9LogPHVmJQhU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s0uH9RhbzQlrW+mbLJeAXE68Eh9ETpFAUcuDXuj72T+qg6+DhjC+PB3u61wMhYDoAcRU0MCzXOJ4PazELacJe8o7IC50ZVXf/dljAHf2HiqlWWioU6FvszA+T6mkyW/yXLnWsMtLKcoC1V50DpN5+hXqInJJBWv6wcKguXWjfM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hZKWp6nl; arc=fail smtp.client-ip=52.101.57.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hZKWp6nl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IIDHI7ZnplE40ns4c2Tn8jhWbupQed/LIePdkfeTofrGSGl0hWKnxn79rfYx9DU0Sed2R8sFu/e8Kmf23RAsHYiosx5OyUY80Af7jZFqt0GCuuolAcLiUBfUhK1g9W3BnjaVrt7RRVV4jmY5Or/8b+G84lhZPMjXo8uk4H53HidxMT9wu3RDkgxBIPHnlKPM6v90u7kLRegA9T/P4T+qHZHZahaKCTHENVvfd3m2IZijPCo+/nlJgYQwq3ip+hSB9jFqSK0FkaWkjWrk2O9G6oruRzh400LXcKbM3FWBHlR6T7Ca4jRxa1Z3MhrMVBPXpEDCsK31SK9DTpPJkkcEig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHCemdusL1T96AlIYc+4f8Z3JXZObVyZQIdWU+zR5nI=;
 b=lQ3Gpg6o+ynQHlpUKrrs703900lHFYNGgYI6sTrYYk4ogGNckeMjJpLr+REDDHsaMdkYNuiRaybmzt8bjbXpBbGdVlbyjgGmbvuhhw/i5q9T0JdCC0xPsruHhhKPT+LjhrxYQfIHPCZWALEmjPf1ePmmIuR8Rwi7wE0HyGLsJFVIQUeM5dRuN0vG5cQ10/fo5RwWTsgv0HzfgApUHfc61/F3UfiGt35gTlMnbjLLAgVxYgNy3cOOsj6LP7GwG1F5KBzPpR48B5NAtG5pcDk759XVWbNzLaLaYIywZgDe6g5p8gLEenJpcOtnsgHEO0EF+lQylAm/KSVM7BnW6oKwsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHCemdusL1T96AlIYc+4f8Z3JXZObVyZQIdWU+zR5nI=;
 b=hZKWp6nltxOqzz+l521SkC6qpLOqr7lALIPtTuRdEMwlF/JCJ7RkxQn0xMjtSyMu5zUPCK7HLyl+pmVbI8Kif5u13Mc6k2f/9wxkaGXl9hTfYUhVnuTQT6satp4VVPRIxOr0VSkvTYU8E8xCw1TEIKO1xbObVf7hW+qNypAVnM8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB999171.namprd12.prod.outlook.com (2603:10b6:8:388::22)
 by SJ2PR12MB7867.namprd12.prod.outlook.com (2603:10b6:a03:4cd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 03:26:27 +0000
Received: from DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19]) by DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19%4]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 03:26:20 +0000
Message-ID: <8781af88-6006-4604-93d8-82b9b67269f3@amd.com>
Date: Thu, 3 Sep 2026 10:26:10 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/24] iommu/amd: Introduce helper function for updating
 domain ID mapping table
To: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 Sairaj.K@amd.com, jay.chen@amd.com, wvw@google.com, wnliu@google.com,
 dantuluris@google.com, chriscli@google.com, kpsingh@google.com,
 alejandro.j.jimenez@oracle.com, joao.m.martins@oracle.com
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
 <20260727132913.22475-18-suravee.suthikulpanit@amd.com>
 <c5f7f26f-ea3f-48a8-a2ac-5320155fd824@linux.alibaba.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <c5f7f26f-ea3f-48a8-a2ac-5320155fd824@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KUZPR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:d10:33::13) To DSVPR12MB999171.namprd12.prod.outlook.com
 (2603:10b6:8:388::22)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB999171:EE_|SJ2PR12MB7867:EE_
X-MS-Office365-Filtering-Correlation-Id: fb6dd413-e0c0-4493-c126-08df096b1f77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|10067099003|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	6E/6EayU7GhNe6uwW6peCHsBaphhQ1RGvRNKor1T3ZZ4NeyZ7RAHSFLmmmQ8P4emsF3G8USVNKoLetSMclUJwRkXmpT91kiHe6C7M5sjLdOz+IMUTZti4nI7n0y+627W0DkmuKmii7H/5Ghpf0VweTDiCKKyJCVHTGAm8CZ2lat7TMFb59Lp8DrG8JI4FdTGs03x78FbfC/t2mLqdp98EqxDWnOQz6HgMQ37AnMC5O/0FyYyj2RcYT69LifGu6RNNozwgmmLEixwBrMcjyO0+Ru50y/kk95zFrLnNcuamRvZtUSb42uNJnMxfXGv+yIdlOBfB+ZwcPKWYsZnhZUX/G8amI7F9eZOM4niPkc8kO+sAyFysBWaAICS2bFfEnB0b7B5JN0TLDxQXES4e3EzX5oNCZZXeJgtzx+kEpFHBnEwzn3V4Ol/tTODTIOq4mEiSccfehi1rqTKbuhs7avitHE6183Q+Y3kC1nVFA4urQSoKG5UaYIao7LzbqWfMPJC+SNRDo7mmEV90MJ1amquvaqLnvWI0qSB0qBhGHRNuEezHHGFyBvHfgsDFaKJTzAGuLhDQAWijmZgrjNJn3UNdyTtM2Ne9eYQdzm8F8Y/O4AdDKZpw2/PICjannPwwue/jt9zRC5p8hU0TMJHW4tF4H7kMKKVLRfkb8cVXu864sY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB999171.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(10067099003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlU5Zno3dkNKUW1lUXhHK080VTNrVklwVjRhSEtMdThzTUtkcVZ4UWE1aUE4?=
 =?utf-8?B?THNzTzEwRDduaWltRzk5dUx5VUNYUDQ5eGorRzFqU3lLTnQvNmN2elhtMEYv?=
 =?utf-8?B?cDJ3dHVtM005TVpQeEdiTkt1Vm56VjdFWmtvaXJ2S2p1K3ZtajMrNCtCQXFu?=
 =?utf-8?B?QVlrZDB1R2F6c0Y5TjVYKzczMFJPbjB6R0VRTHBSVUh4c2EyZFdwNnRleXcr?=
 =?utf-8?B?RFZ2dDNnbU45SDF5OUhVSmMwUG5DMW43MTRLYTluQndNRExtNGsrOFRXUzN5?=
 =?utf-8?B?QjZTYVgzYUwwRUVXQklOcVpnOWUrN3FOVVhaRXd4TisvRk9HbEgrcC9MSUlo?=
 =?utf-8?B?dUVCcWlFVHpKamVkeDEvQXBwY1BhZVZoMWtSdnh5NUd4ZVNGYloyQlhGdWxh?=
 =?utf-8?B?NXlsNTdObmoyZzRvRjZka1hqYXgxam9McGViUE5qZUduV2Z2ZlpMM1NwUmpS?=
 =?utf-8?B?VDNpWFI3NnFpUHhuZEZMeDYxM3d0Mk1wOTc0bEF0YlZRZENwYmg0aTc0akJn?=
 =?utf-8?B?VGNJdWFHWHlTa09IanZsL3JrMU1Eb29icXBCU2MzOWFDSEdhcW11V1M2L2tB?=
 =?utf-8?B?VlJ3RDVoTHZjVzB1cHVtM3NrNG8wdFpzekNqcVVwWSsxaEt2dUh5UHZFazdz?=
 =?utf-8?B?RlNSQkt4SDBQWGZVcVJ2MVJpT1NBdUtvV1ZXS1d0VUJBVjJmTkgrd2ZhOVVi?=
 =?utf-8?B?M2lIanRQMHJEUnBsemJuN1VBSGl4L1dnRkFhak5KQlljUytQOEhONVcvWkZi?=
 =?utf-8?B?NUpiU3ZrWFBDWHh3Z0tob3lhU0M2eXhwVXBhVlpKTjJNb2FkQmdYYUV1a1Ji?=
 =?utf-8?B?ZzJDei9JTDRjcGNlMW9sOWo0d25mS3V0OWw0amxGaURraTE3ZWM3cWV3TXVr?=
 =?utf-8?B?Rk9JbHdDenhlbmkxamsrS0RBVEQ2U0kxdzgyMHpKRkdLZUhHYlV1QVVBSDVr?=
 =?utf-8?B?N1dvUVlJSWlxL1JQbkJmN3pIOE1IY3Bla05yYlR3MHJVcU5LZ3Nyb3BORC9P?=
 =?utf-8?B?RU5WVGhJQjNwdWZid3BBTWJlekNQekJ1MnlSUzVyZ3lBQ1JHUTZOZUZTK3ZD?=
 =?utf-8?B?cGxxYkIrRXpaVXNNWWdkSjJFOG1neFhyNWlUd0dMMlJ1YU5kZ3dBZmYvQ0xz?=
 =?utf-8?B?NFdrYWJnMzVuNldrNUdERjNJbkNpaXpjWXdNd0RnR2U4cG9RM3N6bTc5WG80?=
 =?utf-8?B?Vkd2Wkd3RmdFYlB0VDE4UmdzWk5xRitaeFFKMG5PdjhGcVNiUmJnZVZCRDI4?=
 =?utf-8?B?Rkx1UzA1OTdqcHRETTYyQ3Frd3dJa2ROWG9OMVQ2eHlOaWVucWxjMEV4ZnNI?=
 =?utf-8?B?ejk2VWVmaTJPaG9ZaGxtVkQ1ZHRNVWE2QjJaaDRyaEQ0SWE0UmNwa1ZZaGV2?=
 =?utf-8?B?NnRSR0gvUmgyVHkzOU9uS0hzWTRtdGdGU2V0SW9ra3lERjV3MHc0ajg0K3Nr?=
 =?utf-8?B?ajNWM1dtRVlHQWxPUE5TYno4MkM0NW4wMTdGd242d2hkL0NIdXI4Z0RWQlZl?=
 =?utf-8?B?cTB2OURpdlZ6dEhoY25HV0lEeFBqTStSQXBGSWxQUEpHL2U5MUw1S3Y1NW5Y?=
 =?utf-8?B?cjEraXR6K2dPSkxEbllBcjdBeG5DVjFKUCt4NjgvVjFPZ29odS9ueGpLN0Fu?=
 =?utf-8?B?MjhhQ09nYklqYXNDZ3gzazlqOEN2blNuY0QzcGFUS3NvRGRqOGVwaHBiRGp4?=
 =?utf-8?B?KzBvYmZxV1hRWWZoQkRKVjgzUmpJcFdCVm1ERlFKZWI2ZllybmxQbU1Gc2Jp?=
 =?utf-8?B?V1hEZW5IWDVBdURHOURZK0l4ZW5tNjN0Z0ZtSFd6Q1hFWDJyNitjNUduYk1Z?=
 =?utf-8?B?TEZjSU94L1lCREwwbFdlNUhDTGdjSkVyci8xQWg1UFhIMS9ObGJxWTl6TUlP?=
 =?utf-8?B?KzNGa0JocjlCeVZsbmI2VDlzWmpPazc2SnpEVTEyWnI0dmxYdU9Nc3BTNExx?=
 =?utf-8?B?MGNLRFF4TzJ4Sk5jZmJwcndTV0t6YldBa0tUQ1NnS0dZWm9EeFZXYzdWM0lu?=
 =?utf-8?B?TXB6UUhFeVVwdkdrWFVJOGhDZFh0bXdOTXdEKzhWY1FheGxISTNRS3VLNTAw?=
 =?utf-8?B?Zkd2c1VMUkJmS3BDazlVbG9sSTN4STBvR0k3aWlJOWpSSXBMMXZoby9paDlu?=
 =?utf-8?B?MU96MmFUUjI5TytOaVorVWREWkpVeUhvNytMSEZyTDM2UzZMN2dCdTFBeUd3?=
 =?utf-8?B?RlhiZDNjS09LTUhFSXhWY2dGeGRsWHVlakZ2QzZFOUd3K2RJZ1JwTmpPOThv?=
 =?utf-8?B?d0MwSFRSOVl4N1RDb1RaK1lkSG5tYmxORVV4NE5rdDMvSzlpMjcySHlyMk55?=
 =?utf-8?Q?UrV18vcTZ2YmArPqfv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb6dd413-e0c0-4493-c126-08df096b1f77
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB999171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 03:26:20.5538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XM8YTULEPPlwUxiCO2PdNUrdeo5LrHB7Xb8QULOdDPvrbbqv5VaDl6EsA23WARk4iRm5nVSiWveyf4PBztrmXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7867



On 8/19/2026 5:45 PM, guanghuifeng@linux.alibaba.com wrote:
>> diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
>> index 91d0dd3ac912..708f2c7496a4 100644
>> --- a/drivers/iommu/amd/viommu.c
>> +++ b/drivers/iommu/amd/viommu.c
>> @@ -40,6 +40,8 @@
>>   #define VIOMMU_DOMID_MAPPING_BASE    0x2000000000ULL
>>   #define VIOMMU_DOMID_MAPPING_ENTRY_SIZE    (1 << 19)
>> +#define VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL1_OFFSET    0x08
>> +
>>   LIST_HEAD(viommu_devid_map);
>>   static int viommu_init_pci_vsc(struct amd_iommu *iommu)
>> @@ -420,6 +422,22 @@ static void __maybe_unused 
>> free_private_vm_region(struct amd_iommu *iommu, u64 *
>>       *entry = NULL;
>>   }
>> +static void viommu_clear_mapping(struct amd_iommu *iommu,
>> +                 struct amd_iommu_viommu *aviommu)
>> +{
>> +    int i;
>> +    u16 gid = aviommu->gid;
>> +
>> +    /*
>> +     * IOMMU hardware uses the domain ID mapping table to map gdom ID 
>> to hdom ID.
>> +     * If the mapping does not exist, the hardware would generate 
>> error in the event log.
>> +     * Therefore, initialize all gdom ID entries to map to parent 
>> domain ID to prevent
>> +     * unknown mapping scenario.
>> +     */
>> +    for (i = 0; i <= VIOMMU_MAX_GDOMID; i++)
>> +        amd_viommu_domain_id_update(iommu, gid, aviommu->parent->id, i);
>> +}
>> +
>>   void amd_viommu_uninit_one(struct amd_iommu *iommu, struct 
>> amd_iommu_viommu *aviommu)
>>   {
>>       pr_debug("%s: gid=%u\n", __func__, aviommu->gid);
>> @@ -432,6 +450,7 @@ void amd_viommu_uninit_one(struct amd_iommu 
>> *iommu, struct amd_iommu_viommu *avi
>>                      VIOMMU_DOMID_MAPPING_BASE,
>>                      VIOMMU_DOMID_MAPPING_ENTRY_SIZE,
>>                      aviommu->gid);
>> +    viommu_clear_mapping(iommu, aviommu);
>>   }
> 
> Use-after-free in vIOMMU teardown ordering
> The teardown path releases the DevID/DomID mapping table memory
> BEFORE resetting the vIOMMU state:
> 
>       free_private_vm_region(iommu, &aviommu->devid_table, ...);
>       free_private_vm_region(iommu, &aviommu->domid_table, ...);
>       ...
>       viommu_clear_mapping(iommu, aviommu);   /* too late */
> 
>     Since the IOMMU hardware may still reference these tables until the
>     guest vIOMMU state is reset, freeing the backing memory first can
>     result in a use-after-free by hardware.

Thanks. Fixing in v5.

Suravee
