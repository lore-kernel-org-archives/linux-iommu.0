Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.27
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794206142;
	b=OXRLNlWIATYFtcAn6kEKNb3pRwnRLxmwcZmyY3UC4WgVfBPMqj97g0o64MwFL/r2HOVu
	 5QgGMfH7B/7wc0KNeD1imYDf3lHFNlEimeizVynOmzSbuSFUGRahJQ0PEeUK3LXxxXgX7
	 L23xPF74Gc+vgp/Rgwwgf+gSHiDkwRd75AIw6R6iJY42qNxE1N8NAW6THWOg0VJZJIlrw
	 RBjVgKFGM0bvQ/hbXhsRQtaojo+MmZqbzKsk/LgwKCFDlrpazLCMpbAda6ogAwQ4CobJr
	 PV/iYuKwcclSMB3YsaU60BzaqozFXWEJh3AJd30W1FpTzyZO+dLxTaOuGr5p9eWqo4Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794206142;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:CC:Subject:Content-Language:
	 To:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=p2SLFQgvqloo0C4rxLEYp3jr3N9LHg5suTGY4RPZoPg=;
	b=ar+tpADJ/h8CKiygrQmSIflLorwmLuZQKNgts/0kEtFLwLIyNvu0IWJ+f9te/y3G4Nys
	 vnCCaTCRIEjS3m9Kx0uaQikmveFUlqCXE49C7X7aiII07ZaKfCMQeJiA5ySLlpWeodyO0
	 kz8WiC/Nrr/AUYVMtQAm1HUWz4CYpOT73/sxlad7nOfKldPb13lt5e7Tp4PZNOgX2H/J8
	 mOhmAWyhniYVYD+5Rt+6wZQjQ3kvSGhEX4N6iNk/CvNfgs/T1pxtu4IBMpV+MH14HOHZf
	 Q/nMfx0Vxh5xja3cGpvC1uCfkjLZwuO0zfFzByEfISRlOjqzWBO8f53SaYrm+3GZtsw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CO7X0HqK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.27
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012027.outbound.protection.outlook.com [40.107.209.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A7E606A321
	for <iommu@lists.linux.dev>; Mon,  9 Nov 2026 06:35:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3A7E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CO7X0HqK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sm0B2nqkz6LEJGtcnUMm3jT8Up/IYco9BJgNENx1hVbn4llR8DFR1DPvd6VtZYAd93uWM57rjw35NgV+uAte5dVL+qGGk8nMBif/M7PQg8Onj911qDrs+RwngQp8Bj9NP7qwmTwdPeWVW/g9+Huqk+yiMDcvaKfAEfS54DseWbDPXl8r3w1TSSYWRXtaWakTgOlkuY204eAZqdLj04+vJUSP8c9t/22aGAkwqCbRdMTSUOrgF3n6pzYyDlCPJYy8F0iq3w1bgy2oyOJcfzfsyGVjhhe7T8C/K3d/z0nDo6liFjvj1tdLlm+ixeSbU2dZKeJjxji1lgcE7PlFxw/H1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2SLFQgvqloo0C4rxLEYp3jr3N9LHg5suTGY4RPZoPg=;
 b=kryrruejJQ9ABHihhBfUq8nvcG8ZIze2O6mljaqRFvtKIJEi/YXaF00BiD+kWV5POHdozT71zPWhLVjJglZfqpBjrlwCoAQYd1Uuvp5enJajl4dxm7DkureZJU7Vm155b+UGOTpEgkCzr2ThhxfL9N4raNixN0mW6jcXhlll34hd5SWgUgT/o+GLQZIZj1YoKhv5O+PiiGovw0BOLjbpQMyyP3N5TlVqtZSpHrbYjGh+qfbWODQ1yK50rksm7riZ5548w3gdXlYQowB3osMFqgiVzd1QtFGfL8TRc1sesm7tSVg42J9j3CirCPs2atgAU6omyweHjuhFkS769CuzcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2SLFQgvqloo0C4rxLEYp3jr3N9LHg5suTGY4RPZoPg=;
 b=CO7X0HqK3XQOt5jJisj8DA4RZWIRAI/t0TqcMwAT1beT4zkceaSFOYNTP6B14Oyuzb1ZSIzfR7+dPwkjC0Ry/EEzAf4p0NnTQqP5ftRKEXSuSMh41R0c8fmHMrwp4fRUh/R0Ioii97AYS/KLUtYEYLForUsrWJiZO5vp98M0HRI=
Received: from BN9PR03CA0296.namprd03.prod.outlook.com (2603:10b6:408:f5::31)
 by AT6PR12MB727359.namprd12.prod.outlook.com (2603:10b6:170:116::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 06:35:37 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:408:f5:cafe::75) by BN9PR03CA0296.outlook.office365.com
 (2603:10b6:408:f5::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.12 via Frontend Transport; Mon, 9
 Nov 2026 06:35:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.0 via Frontend Transport; Mon, 9 Nov 2026 06:35:37 +0000
Received: from [192.168.0.108] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 00:35:33 -0600
Message-ID: <cf6717a9-1ede-481f-9d38-186a50c970f3@amd.com>
Date: Mon, 9 Nov 2026 12:05:30 +0530
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, Adam Pelka <adampelka26@gmail.com>
Subject: Re: [PATCH v3 3/3] iommu/amd: Rename unity_map_entry and unit_map to
 ivmd_entry and ivhd_entry_map
Content-Language: en-US
To: "Jindal, Akshay" <Akshay.Jindal@amd.com>, "Joerg Roedel (AMD)"
	<joro@8bytes.org>, Adrian Huang <ahuang12@lenovo.com>, Joerg Roedel
	<jroedel@suse.de>, Robin Murphy <robin.murphy@arm.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Will
 Deacon" <will@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20261106041650.24076-1-sarunkod@amd.com>
 <20261106041650.24076-4-sarunkod@amd.com>
 <1b1ef14a-f3d5-459b-94cd-e0f2407a0627@amd.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <1b1ef14a-f3d5-459b-94cd-e0f2407a0627@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|AT6PR12MB727359:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cd78a0c-a166-4519-cf5c-08df3e2baa9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|921020|11063799006|4143699003|56012099006|261021123027099003|261021121427099003|261022113327099003|261022075727099003|261022105027099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	uRi5OJ0ALxxBtolH3Y7Bsv33j9h1AKC3JguoDIGTYaxqq3bkryaywpbpcSgRJqwV+cSUsTjbaOCjhyf1a2Rp2i08FgprNC9gmoQG502HBlkYDzGlHOKKtnxXoMy5oQSnrHlumSTY7mwUOfJyxM7/RPNhQmYBuhla1cAFN/Mzmfklf0+oVK3PrjCAS+7VFUKP3IQfPQmF9FETgvi8pCv8SpAm0vog3hNcE+NCN0GCRfR7DMP4P4Hb+X1Bra60Mdh77yM/LBpEvpLEO7RpF2RoJrtqzvz47jy3tETNsd933IEFpF1d2+V3QT5nMF0hzmOxzC3KmT+4qbBFZBl3/K9HECELY+PZEDDEJdFWLlgpnOIZzpjifejTFFDaLMqmRefKfWX1zE67viybOzGabRDGJAfM10BUxlWiFczV7TOUf/4+4BHmFLkqQl89809FsJeZh7JmuG95z7gMWn8hAm3hWJPOW4uhsctdGx8XiRyJWRkVDP6Esx85mn0Ojqb+iv+9WawPiVwWNencf7qMnMVb47oM1WqDCf6+YZCOq6rF3785FHgFLEcvIxR7SNKsfS2B97AODedIVDHOvrp4oeBG8Oj4OfsEsE9blarSgoGL8+hEKF+AGLaR+q2W4B/zBKqfSMBF1bJb093jHq1W4psse9DsmddjD4qOD+xJ93I36f1054FFCBZJ7KmyLzHQtNhWVfDW/9+p1z8MvfZtVp/XG50I8Zr2gg33ybaDI6LJdLNyuHHgJy0E7ae1o2JV8X8X
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(921020)(11063799006)(4143699003)(56012099006)(261021123027099003)(261021121427099003)(261022113327099003)(261022075727099003)(261022105027099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qzgVGwsatWwhRSJyvNIrK60gSLTivW4I1v8c8oXgzuhW81KN9tkdly2Fww5lnVO8s7uNtNbB5lxz6F6qcRKL6annTW3QqnKNIhzGwVrSI6AHwz3Q9NCJSg9Cd6Ee7HIkJdWWX/G9eWbZtMcJtC6mhqHG/A6PtGCgpxqcPpkIAqzUV5bCTsLQcSmLwHbHH9Lp7etjhy3TBvCCL3WvQznB6pYo96Z5JxWVkxtU06ds0igF8aMibKhDjYV8SoRr5MbRKKi9L0hc0IL3eTkWS+4VEQSe8OOE1eDyqAnvgma3D1ve9VrpogLheK8mdLwve5tnqwP5eYlzVi+FQ53jmw2ekoKa3dEVaEloficyeb4BerA2aR5lnSnWNNRT3PnaEg/Gl92nY49/CJZzrZWuW2BztHkjCUAZjTPZhxqnM+OdaA+lwpqiJJs6derJ0vXx3/xb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 06:35:37.6499
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cd78a0c-a166-4519-cf5c-08df3e2baa9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT6PR12MB727359



On 11/6/2026 3:45 PM, Jindal, Akshay wrote:
> 
> 
> On 06-11-2026 09:46, Sairaj Kodilkar wrote:
>> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>>
>>
>> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>
>> Also, rename struct list_head unity_map to ivmd_entry_map along with
>> renaming the unity-map helper functions and add error message when
>> handling invalid IVMD entry.
>>
>> No functional change intended.
> Reviewed-by: Akshay Jindal <Akshay.Jindal@amd.com>
>>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>> Tested-by: Adam Pelka <adampelka26@gmail.com>
>> ---
>>  drivers/iommu/amd/amd_iommu_types.h |  6 +++---
>>  drivers/iommu/amd/init.c            | 22 +++++++++++-----------
>>  drivers/iommu/amd/iommu.c           |  7 ++++---
>>  3 files changed, 18 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
>> index bcb88b476167..033cabc5b73a 100644
>> --- a/drivers/iommu/amd/amd_iommu_types.h
>> +++ b/drivers/iommu/amd/amd_iommu_types.h
>> @@ -609,11 +609,11 @@ struct amd_iommu_pci_seg {
>>         u16 *alias_table;
>>
>>         /*
>> -        * A list of required unity mappings we find in ACPI. It is not locked
>> +        * A list of required IVMD mappings we find in ACPI. It is not locked
>>          * because as runtime it is only read. It is created at ACPI table
>>          * parsing time.
>>          */
>> -       struct list_head unity_map;
>> +       struct list_head ivmd_entry_map;
> nit:
> IMO unity_map term was based on spec, which was synonymous with identity mappings.
> If unity_map term is not being used, then I would suggest keeping it as ivmd_entry_list
> instead of _map, since it is simply a collection of ivmd entries

Sure.

Thanks
Sairaj

>>  };
>>
>>  /*
>> @@ -869,7 +869,7 @@ struct ivhd_dte_flags {
>>  /*
>>   * One entry for unity mappings parsed out of the ACPI table.
>>   */
>> -struct unity_map_entry {
>> +struct ivmd_entry {
>>         struct list_head list;
>>
>>         /* starting device id this entry is used for (including) */
>> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
>> index 1f0ca675df1c..9356efe14b3e 100644
>> --- a/drivers/iommu/amd/init.c
>> +++ b/drivers/iommu/amd/init.c
>> @@ -132,7 +132,7 @@ int amd_iommu_pprlog_size = PPRLOG_SIZE_DEF;
>>
>>  /*
>>   * An AMD IOMMU memory definition structure. It defines things like exclusion
>> - * ranges for devices and regions that should be unity mapped.
>> + * ranges, unity mapping for device and regions.
>>   */
>>  struct ivmd_header {
>>         u8 type;
>> @@ -1726,7 +1726,7 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id,
>>
>>         pci_seg->id = id;
>>         init_llist_head(&pci_seg->dev_data_list);
>> -       INIT_LIST_HEAD(&pci_seg->unity_map);
>> +       INIT_LIST_HEAD(&pci_seg->ivmd_entry_map);
>>         list_add_tail(&pci_seg->list, &amd_iommu_pci_seg_list);
>>
>>         if (alloc_dev_table(pci_seg))
>> @@ -2319,8 +2319,8 @@ static int __init amd_iommu_init_pci(void)
>>         }
>>
>>         /*
>> -        * Order is important here to make sure any unity map requirements are
>> -        * fulfilled. The unity mappings are created and written to the device
>> +        * Order is important here to make sure any ivmd map requirements are
>> +        * fulfilled. The ivmd mappings are created and written to the device
>>          * table during the iommu_init_pci() call.
>>          *
>>          * After that we call init_device_table_dma() to make sure any
>> @@ -2606,17 +2606,17 @@ static int iommu_init_irq(struct amd_iommu *iommu)
>>   *
>>   * The next functions belong to the third pass of parsing the ACPI
>>   * table. In this last pass the memory mapping requirements are
>> - * gathered (like exclusion and unity mapping ranges).
>> + * gathered (like exclusion and ivmd mapping ranges).
>>   *
>>   ****************************************************************************/
>>
>> -static void __init free_unity_maps(void)
>> +static void __init free_ivmd_maps(void)
>>  {
>> -       struct unity_map_entry *entry, *next;
>> +       struct ivmd_entry *entry, *next;
>>         struct amd_iommu_pci_seg *p, *pci_seg;
>>
>>         for_each_pci_segment_safe(pci_seg, p) {
>> -               list_for_each_entry_safe(entry, next, &pci_seg->unity_map, list) {
>> +               list_for_each_entry_safe(entry, next, &pci_seg->ivmd_entry_map, list) {
>>                         list_del(&entry->list);
>>                         kfree(entry);
>>                 }
>> @@ -2627,7 +2627,7 @@ static void __init free_unity_maps(void)
>>  static int __init init_unity_map_range(struct ivmd_header *m,
>>                                        struct acpi_table_header *ivrs_base)
>>  {
>> -       struct unity_map_entry *e = NULL;
>> +       struct ivmd_entry *e = NULL;
>>         struct amd_iommu_pci_seg *pci_seg;
>>         char *s;
>>
>> @@ -2678,7 +2678,7 @@ static int __init init_unity_map_range(struct ivmd_header *m,
>>                     PCI_SLOT(e->devid_end), PCI_FUNC(e->devid_end),
>>                     e->address_start, e->address_end, m->flags);
>>
>> -       list_add_tail(&e->list, &pci_seg->unity_map);
>> +       list_add_tail(&e->list, &pci_seg->ivmd_entry_map);
>>
>>         return 0;
>>  }
>> @@ -3178,7 +3178,7 @@ static bool __init check_ioapic_information(void)
>>  static void __init free_dma_resources(void)
>>  {
>>         amd_iommu_pdom_id_destroy();
>> -       free_unity_maps();
>> +       free_ivmd_maps();
>>  }
>>
>>  static void __init ivinfo_init(void *ivrs)
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index 699b5f530f11..d0308fbceac6 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -3100,7 +3100,7 @@ static void amd_iommu_get_resv_regions(struct device *dev,
>>                                        struct list_head *head)
>>  {
>>         struct iommu_resv_region *region;
>> -       struct unity_map_entry *entry;
>> +       struct ivmd_entry *entry;
>>         struct amd_iommu *iommu;
>>         struct amd_iommu_pci_seg *pci_seg;
>>         int devid, sbdf;
>> @@ -3113,7 +3113,7 @@ static void amd_iommu_get_resv_regions(struct device *dev,
>>         iommu = get_amd_iommu_from_dev(dev);
>>         pci_seg = iommu->pci_seg;
>>
>> -       list_for_each_entry(entry, &pci_seg->unity_map, list) {
>> +       list_for_each_entry(entry, &pci_seg->ivmd_entry_map, list) {
>>                 int type, prot = 0;
>>                 size_t length;
>>
>> @@ -3148,7 +3148,8 @@ static void amd_iommu_get_resv_regions(struct device *dev,
>>                                                  length, prot, type,
>>                                                  GFP_KERNEL);
>>                 if (!region) {
>> -                       dev_err(dev, "Out of memory allocating dm-regions\n");
>> +                       pr_err("%s: Out of memory allocating reserved regions for sbdf=%#x\n",
>> +                              __func__, sbdf);
>>                         return;
>>                 }
>>                 list_add_tail(&region->list, head);
>> --
>> 2.34.1
>>
>>

