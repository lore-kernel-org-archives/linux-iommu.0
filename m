Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.4
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793960143;
	b=bc6E6I9AMFr5KImDyS1YCETRGMGr07FYhS7t0BLW0HAwud2vBTiQnxm+Mq24wvRiyEet
	 xxaB5neEsx4/Zg4vcjja9Epm2NIII4myK9xpLUc1og+bkGQnKFNJp4d6Fdbl9bzUydZuq
	 tQKdsuBvsqV9joKkLhQHxdev7dC3zAB1LXTmurxby2LArw7TMjYD92Y1BG7n76B0+M4mL
	 LG7Fw6OOQAPOuzPNpuY/B4FwuSW8TlcK8GGCVI8h+AQtpN/5SsnKd0b4QPc/CCAzulCaO
	 8mLfgge7Kg3aqZLDvTl3+ttcASPibqjYdlvEFEbufWT8F22yPb0SRtgmP6/CwO4CYcg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793960143;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
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
	bh=iXkS0XgfjRkXOyGAE1aLFRMmzgS8EftDKD7C/NEHJlc=;
	b=YVeJDJCCISbRZVRxZ84ri7v5yr3RNGO601FVNxKeYRhWMPuN2TLmnYK3dy0NNzkBjV6G
	 EkNnqQibX9CZ483BEfppuYzycFv5yKR/pzW5eF7daw03Y5r4tpfo04Q/GxgCOrBz2tDp4
	 rnNDDghryAEsuUd+FLW4aaPpxD1pXBB8ozoXLrxTt/RMPKrpy7g5enho/jpQKylg3yGrC
	 ep/9gucyZspSWIv8MA1za9kSDZ02C2CGDdIvfnaeaqgSHprqREeAyc9d2vDB3xHIfgqNG
	 A6ol1AZG7U9ktH6rxLKZwHZOa1EDgrKUig0cIH9HlVp0fzuCi5PO7E4LOFQP7TuNVWQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0QiD90Za;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.4
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010004.outbound.protection.outlook.com [52.101.46.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68AD606A329
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 10:15:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C68AD606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0QiD90Za
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AfZh2zpIi4yrXrAObSfA41mmGGd2Q4fzmfqe14rQWUzpBrvZv/F3AAXLHzDy7HW6F9o7aUeQROchSL+/vVfdGLJKBl1hdcGvzNGjr3xlQRgr6D2wNXiF4BqFUCCCyFHm0bM6NZE3QXHRe6FAMMgNA1TeadDYJQ1Qr71V9CsH+Sit1lj7L8ffCsF2/xZYtcLvW/vm1keRtdnUUZP4/8mjZ+1wlplCofZph8TdTHI3UZzAQqlnZ635wP7CVbdvZPoWPYwWzyPY5Ih12BlejFBK2OGQDC6vMwqiX54R4px+5qp/vvAGZCy0BMtrhstecuwsCNv5QpHVvhybHCcg6h8jUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXkS0XgfjRkXOyGAE1aLFRMmzgS8EftDKD7C/NEHJlc=;
 b=sPM20cSq9SpQ+Hpxwr3bslELfeZ0yInaMI0fx6epZwl4/U4TQKZdBObsHsd4vOxPfyLS5lLFALPxjoUhRvplEadws3mVbL9cimdTRj4OVtiLgmuOFXyTPoZTJ7myhUlfRWxfj7vJIPEWccaBKYi13VSJGHuzQK2VCJQfPOJz3EGcbEro8gmGgeFdCe2oZXKjZQDtR0BqoJvtKV1RnnpgVjcT3l9p2tdt/Kic/hMDGyKcsfrHmZdRZh+UlG1REZfwle/g+j3kerIA+zefnUvpPT5tEIntFgF2Zn69tOA2ROlsLjI1l1QqcgA0ERN+UJmu3oSK2AxJ69TsKsgu4FuL3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXkS0XgfjRkXOyGAE1aLFRMmzgS8EftDKD7C/NEHJlc=;
 b=0QiD90ZaQGiapWIF2mMtVeXuqxtD2GFbhfva5p4LwOyBTLw6sh16/1tPdh5mY953QgtRe71zK1Zw9fW/PoBA1XcmQnGp6MpPD2I3Ced2E+xQ92WsW0e5FrkmxcBZWgqQxwILV1yJNPi/7eJw7pKGV2TUi7YnEBekLM64Jh8ReLk=
Received: from BY3PR10CA0020.namprd10.prod.outlook.com (2603:10b6:a03:255::25)
 by SA3PR12MB7997.namprd12.prod.outlook.com (2603:10b6:806:307::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 10:15:37 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::5e) by BY3PR10CA0020.outlook.office365.com
 (2603:10b6:a03:255::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 10:15:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 10:15:36 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 04:15:35 -0600
Received: from [192.168.1.149] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 6 Nov 2026 04:15:31 -0600
Message-ID: <1b1ef14a-f3d5-459b-94cd-e0f2407a0627@amd.com>
Date: Fri, 6 Nov 2026 15:45:30 +0530
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
Subject: Re: [PATCH v3 3/3] iommu/amd: Rename unity_map_entry and unit_map to
 ivmd_entry and ivhd_entry_map
To: Sairaj Kodilkar <sarunkod@amd.com>, "Joerg Roedel (AMD)"
	<joro@8bytes.org>, Adrian Huang <ahuang12@lenovo.com>, Joerg Roedel
	<jroedel@suse.de>, Robin Murphy <robin.murphy@arm.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Will
 Deacon" <will@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: Adam Pelka <adampelka26@gmail.com>
References: <20261106041650.24076-1-sarunkod@amd.com>
 <20261106041650.24076-4-sarunkod@amd.com>
Content-Language: en-US
From: "Jindal, Akshay" <Akshay.Jindal@amd.com>
In-Reply-To: <20261106041650.24076-4-sarunkod@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|SA3PR12MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d6703a9-6ff6-4938-c8a5-08df3beee68c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|18002099003|22082099003|6133799003|10067099003|921020|4143699003|11063799006|261026121527099003|261102123227099003|261028144727099003|261026140227099003|261022113327099003|261021123027099003|261021121427099003|261022105027099003|261022075727099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	iSnJ2wlqICO1J6Rk2gReD69EH/obp2G04VWFvWcQvjFjgKXtD0jnEjcFKzQ4HdBcGuMzRmC6VWfHXct3Oy+N0ijTIlnDDUECbymU2OsVytE+OLlit0z/jzoY6ZqQGNrid9gBa05CUlMLWo/y1/Zru+GcmYyrAOGFmZPrI0bOH3Ubclrs1VU98iToU1rD2M8WLLFpQiI2MZGkllfaWHGjMRUYi+VKkYN5znkG4Iykk4835wS7hH4VR7dDNw3KEvl45UFM7U1dXdPjK9zLTN6Z48MMoXxYJf+X2lcKaegpxic1qqrIih65vKnS2WQaR2qYioHD8HJs+uc9hl7/Op2IVd4QJPty/Sk0ImjCqrs12LMh/H1ofHSX5TFELMGXTPoVmZqi3RBOrb8yFz4WoOgQJnOwtZ+Wml7ph8Ohr+ug4lZeC7aU+Co4B3TR5tZDRUYat5RGjg4UCPbppIXtj8eOmSuA48BcBKM+fVex8pVafM0ebijqWYv5E45SAbofu3hUhwXO3Gug8jhxhJo7WlAMKtfjC5/sykKVD73YitB/HVZI+UvQdviO6quqr49DCVYqLwakS0bfYRkZVbosfxeQLH/IJaxuD66RWsu29CWS9sug+QHJVgusQnjtuafPCMdPuA9ZuuLDHLQSdYcGpcfc0yZaHxe59hwlJDAk/IOdIG3IerNs/KWK9czqoGYVEfupgHG7zWG/TieH5KArKAtq7H4I7KSv34RYBWKO+K//IJL6cjDpO7OsSWM/o/cioEPv
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(18002099003)(22082099003)(6133799003)(10067099003)(921020)(4143699003)(11063799006)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261022113327099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(56012099006)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1nZTX13BSVlpLLIgdwMvj3OfsgJi4TJSl4btsNdfUM9zhSjeLGJ5cwCEtL1CjJa++KQLRAomx4XAkD1Wy5rIKh/Z5/+S0LNRwgzmBL+hm2yBgcD4cP+oFf/5NFOQO9ZK14Hrn0ukl6zekWWu14ir1slwxbEGxC1huGX9TUThbHAB7Cwziv66+GOB7TPrPlQ1cKw6tnXkZlAHiZDc15fsonY0eo1vevMaPjBFgWc/Wm68m0eMYYWh27UR2FjCfu9cou/ydgXwmePU/k+unjF53j+vG1vF7S12WWpGR3EF+6gf0XvEvU01W4vGMWbBCUsskXpI1p7hCnMaSYq1h8sGYIIt+fVsEo5RJ5Z0ncYpIbybPymBJx92GWBjSCbuyDlkA27FPxqkOKqtUl9UAJ31RTk5CvPmY9CAola90WwED6AL7rBmVTB+Yk6r+oR6wfVB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 10:15:36.4837
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d6703a9-6ff6-4938-c8a5-08df3beee68c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7997



On 06-11-2026 09:46, Sairaj Kodilkar wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> Also, rename struct list_head unity_map to ivmd_entry_map along with
> renaming the unity-map helper functions and add error message when
> handling invalid IVMD entry.
> 
> No functional change intended.
Reviewed-by: Akshay Jindal <Akshay.Jindal@amd.com>
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
> Tested-by: Adam Pelka <adampelka26@gmail.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h |  6 +++---
>  drivers/iommu/amd/init.c            | 22 +++++++++++-----------
>  drivers/iommu/amd/iommu.c           |  7 ++++---
>  3 files changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index bcb88b476167..033cabc5b73a 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -609,11 +609,11 @@ struct amd_iommu_pci_seg {
>         u16 *alias_table;
> 
>         /*
> -        * A list of required unity mappings we find in ACPI. It is not locked
> +        * A list of required IVMD mappings we find in ACPI. It is not locked
>          * because as runtime it is only read. It is created at ACPI table
>          * parsing time.
>          */
> -       struct list_head unity_map;
> +       struct list_head ivmd_entry_map;
nit:
IMO unity_map term was based on spec, which was synonymous with identity mappings.
If unity_map term is not being used, then I would suggest keeping it as ivmd_entry_list
instead of _map, since it is simply a collection of ivmd entries
>  };
> 
>  /*
> @@ -869,7 +869,7 @@ struct ivhd_dte_flags {
>  /*
>   * One entry for unity mappings parsed out of the ACPI table.
>   */
> -struct unity_map_entry {
> +struct ivmd_entry {
>         struct list_head list;
> 
>         /* starting device id this entry is used for (including) */
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 1f0ca675df1c..9356efe14b3e 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -132,7 +132,7 @@ int amd_iommu_pprlog_size = PPRLOG_SIZE_DEF;
> 
>  /*
>   * An AMD IOMMU memory definition structure. It defines things like exclusion
> - * ranges for devices and regions that should be unity mapped.
> + * ranges, unity mapping for device and regions.
>   */
>  struct ivmd_header {
>         u8 type;
> @@ -1726,7 +1726,7 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id,
> 
>         pci_seg->id = id;
>         init_llist_head(&pci_seg->dev_data_list);
> -       INIT_LIST_HEAD(&pci_seg->unity_map);
> +       INIT_LIST_HEAD(&pci_seg->ivmd_entry_map);
>         list_add_tail(&pci_seg->list, &amd_iommu_pci_seg_list);
> 
>         if (alloc_dev_table(pci_seg))
> @@ -2319,8 +2319,8 @@ static int __init amd_iommu_init_pci(void)
>         }
> 
>         /*
> -        * Order is important here to make sure any unity map requirements are
> -        * fulfilled. The unity mappings are created and written to the device
> +        * Order is important here to make sure any ivmd map requirements are
> +        * fulfilled. The ivmd mappings are created and written to the device
>          * table during the iommu_init_pci() call.
>          *
>          * After that we call init_device_table_dma() to make sure any
> @@ -2606,17 +2606,17 @@ static int iommu_init_irq(struct amd_iommu *iommu)
>   *
>   * The next functions belong to the third pass of parsing the ACPI
>   * table. In this last pass the memory mapping requirements are
> - * gathered (like exclusion and unity mapping ranges).
> + * gathered (like exclusion and ivmd mapping ranges).
>   *
>   ****************************************************************************/
> 
> -static void __init free_unity_maps(void)
> +static void __init free_ivmd_maps(void)
>  {
> -       struct unity_map_entry *entry, *next;
> +       struct ivmd_entry *entry, *next;
>         struct amd_iommu_pci_seg *p, *pci_seg;
> 
>         for_each_pci_segment_safe(pci_seg, p) {
> -               list_for_each_entry_safe(entry, next, &pci_seg->unity_map, list) {
> +               list_for_each_entry_safe(entry, next, &pci_seg->ivmd_entry_map, list) {
>                         list_del(&entry->list);
>                         kfree(entry);
>                 }
> @@ -2627,7 +2627,7 @@ static void __init free_unity_maps(void)
>  static int __init init_unity_map_range(struct ivmd_header *m,
>                                        struct acpi_table_header *ivrs_base)
>  {
> -       struct unity_map_entry *e = NULL;
> +       struct ivmd_entry *e = NULL;
>         struct amd_iommu_pci_seg *pci_seg;
>         char *s;
> 
> @@ -2678,7 +2678,7 @@ static int __init init_unity_map_range(struct ivmd_header *m,
>                     PCI_SLOT(e->devid_end), PCI_FUNC(e->devid_end),
>                     e->address_start, e->address_end, m->flags);
> 
> -       list_add_tail(&e->list, &pci_seg->unity_map);
> +       list_add_tail(&e->list, &pci_seg->ivmd_entry_map);
> 
>         return 0;
>  }
> @@ -3178,7 +3178,7 @@ static bool __init check_ioapic_information(void)
>  static void __init free_dma_resources(void)
>  {
>         amd_iommu_pdom_id_destroy();
> -       free_unity_maps();
> +       free_ivmd_maps();
>  }
> 
>  static void __init ivinfo_init(void *ivrs)
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 699b5f530f11..d0308fbceac6 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -3100,7 +3100,7 @@ static void amd_iommu_get_resv_regions(struct device *dev,
>                                        struct list_head *head)
>  {
>         struct iommu_resv_region *region;
> -       struct unity_map_entry *entry;
> +       struct ivmd_entry *entry;
>         struct amd_iommu *iommu;
>         struct amd_iommu_pci_seg *pci_seg;
>         int devid, sbdf;
> @@ -3113,7 +3113,7 @@ static void amd_iommu_get_resv_regions(struct device *dev,
>         iommu = get_amd_iommu_from_dev(dev);
>         pci_seg = iommu->pci_seg;
> 
> -       list_for_each_entry(entry, &pci_seg->unity_map, list) {
> +       list_for_each_entry(entry, &pci_seg->ivmd_entry_map, list) {
>                 int type, prot = 0;
>                 size_t length;
> 
> @@ -3148,7 +3148,8 @@ static void amd_iommu_get_resv_regions(struct device *dev,
>                                                  length, prot, type,
>                                                  GFP_KERNEL);
>                 if (!region) {
> -                       dev_err(dev, "Out of memory allocating dm-regions\n");
> +                       pr_err("%s: Out of memory allocating reserved regions for sbdf=%#x\n",
> +                              __func__, sbdf);
>                         return;
>                 }
>                 list_add_tail(&region->list, head);
> --
> 2.34.1
> 
> 
