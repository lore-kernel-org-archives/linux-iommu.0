Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010063.outbound.protection.outlook.com [52.101.193.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9924772A9
	for <iommu@lists.linux.dev>; Thu, 13 Aug 2026 13:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786629552; cv=fail; b=t9ryXer1RaeoyveQV0MeDUql8maUUP5sY7l/aTEEO8Gixu6gznTeXiB4LH6p6sucP1joC+chwJF3EZjpCcBES7U0JN3oupC7OACg/W+T0zv8tCbKv6A2n+Nl+pyCv8g3fTZYyjKbGKLoobwmR3ziTAMcoFJKYYXNYasVZAypMcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786629552; c=relaxed/simple;
	bh=pOvMqofseItbMNP/QIE5t/CVRi2V9qsYImE8aJlOE4I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XPlfVnkDNaGEiIDp7Wx0pzWvW0c7i4H7yHyxjOcsrUXGrwgp+vQkJKQIrsU74JeRWfOyt3qLcJaVEqyktB7Bh2XAx2Ddt+u0jXTxMHX+wBDtl2IigVGG2V7QZWmE5s3SK+WYsICGfAfFLuUGpcBxzMXg0xXPPM2UmAFSUU/rHo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MDzhZCvv; arc=fail smtp.client-ip=52.101.193.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MDzhZCvv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E/ot0nCqT++VuOqFAvPIqE0BStCFrjIqmbsCN6atmryxD+AMl0QZQmW1J0cxDEfadKvF2SN5ISxlTyXPO2siaSBO9BDmHWh3sEpIfxV8eJU0oMlIL+ZnuDkU0ll2m4A2zhet2s8g+56HSHVLJzlKhSnlTjA7UrVHwZiaJcRsp3ft7ERY7GdEjJcUJ1oaJK4pwWJgPlHFW3dL6NW5QwIKa9hoClB6N89C1P6B14fzM7L0AWlqdM7OUMLb4K8vpVSPICPn/7Fi8zfNi5nBdA6pNKet9eJxS5U2Kgd/JfXxSmyUS99xygIpigpCCIgyAHV9u3l+OAVVKISV5PQTqJJexg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bQHBHGCbHCsbZuKzxJJkNw/0pqGIOwgHOEVgSMXl0g=;
 b=DwfiAPzmDd6p7QrWJyN85Ta5cjwOwIdKgsQ/IOQCuQRI+TFLqyEwpfA93sk/73OvS5F/gX8E2HnKua1Q8MV0J0jCDjuqVBR7vfztC0NUj4bd0iuXJdVqKsahfpf61tytPhORiM4Uy3PFjLbprNgLSX0gELYO/7gdCGDyfSU60gXDBWVsAo3uCo+NnSKVdd8dQWvcAHSpX6pUso8lvO6bkDAG53n4BQwqfY5K+sCgJYccZjC0b48Hv9ByLhD6T1sXgdmYMkWrjBUealid5MrMe5Hu97x0if1ZM8FPxpX4NSs43FscTbC9MplKwcNUo0TNR0K7rT6JA+yN0fgXlrh5/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bQHBHGCbHCsbZuKzxJJkNw/0pqGIOwgHOEVgSMXl0g=;
 b=MDzhZCvvX/RHR5ocfPEfKMTjRUP37PLg9GY5fKINqGV5akMlG89kv1zrDN8vEf5/vQagCXqeGRpwa1t6t3wkHkEgT+XD0mIjX0FeOz1ppkkSvGCJDvly9k4Ex74STXDQ+fL6T/vrLEeBQOTxFy7Be7PBxCGRjCG10oqG9Iz+6J8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) by
 BY5PR12MB4179.namprd12.prod.outlook.com (2603:10b6:a03:211::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.15; Thu, 13 Aug 2026 13:59:03 +0000
Received: from DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e]) by DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e%3]) with mapi id 15.21.0292.018; Thu, 13 Aug 2026
 13:59:03 +0000
Message-ID: <697be383-2de0-4c6b-91c1-9887d23ddc9b@amd.com>
Date: Thu, 13 Aug 2026 19:28:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] iommu/amd: Use MAX buffer size when SNP is enabled on
 Family 0x19
To: Usama Arif <usama.arif@linux.dev>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com, bp@alien8.de,
 Joerg Roedel <joerg.roedel@amd.com>, samuelcrossley@gmail.com,
 "Srivastava, Dheeraj Kumar" <DheerajKumar.Srivastava@amd.com>
References: <20260813131833.2808948-1-usama.arif@linux.dev>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260813131833.2808948-1-usama.arif@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0248.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ae::11) To DS7PR12MB5766.namprd12.prod.outlook.com
 (2603:10b6:8:75::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5766:EE_|BY5PR12MB4179:EE_
X-MS-Office365-Filtering-Correlation-Id: 36cc891d-b697-4eb1-d2e2-08def943082e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	sfmZHnu2IMMLqhs1gPMbULneGFo5TnQ02mPA7zU9+RqXtniXYNyuS37HxN5qQYC6xKSYEyUherSm4QPrQJUXjG0oaw1jrixBWbZ4/azP86Rmuv3JeXv03jfPucDykbAf0prLIppJ6Yf4m38CbW/iBhRpacWocR+uwwALIJukCcmBG1hAI/blEQcdrP9LylNBBMrnC5Qr+qzMZeE6ws+4XU+5Gi/Lg70bouol3i/lg6RBmZAx7CqRUDq+MJtd4WvfKshQd69EkBNgb4nc+wZlYx1UCJGbAPkKN/nXfrzprk+oQuTqdVVtJ7W35HDDc4ckgsojKjPK6bT9aqRPkUNHJ3n86UCv2V+hm/lkg9jG3Us07n8LDCksNK9luz2aFwIx25EKPX3gQSULV2K+bdDxbiy/Wgbm6i8sACwM01urFkHw5lM+pA9IYwpWOzlWk6/Wp4uZEfEVvEAlU29nK0qyzX2zU8SQP2kuikFBistAW/ZSYnfQgNpwdBlyyZZ+7FR/4z9R2TBJIxuNvhcTj7MbutO8gkDGxwoHn2zwdtOHZO8p+Q37bGGgV8zOs81HR/pPQfzKOkBJPkh0CEEPCs2o0wrGgT092Fy1ZNRN1FTakc/EMC4rBKe7lZCoBF1Ipl2PmLI4lnrOGGIpCmoSSnkMlcZYGCOll5/4X9Jd8SB7e2A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czd2TnRvaExKd0lUYUxpTVE0Tk1DMDJCMjRIdFVTclE0Qjg2S1pDOUtXQkM2?=
 =?utf-8?B?WFEweUpPdmF6eER3ZmNISGp3QmQwdFBxbXZOZTVZQStsR0poSU40LzBpejdW?=
 =?utf-8?B?akEwNEl3VVRkZnJ1cm5ZeEQrbW1JejZIOFE2RTcrN0pQSUI0eUluUHlmaUdz?=
 =?utf-8?B?bUpKSWdxMndMaXZ6ZHNEd1dQb1BaWmtiZkNXbHlJd0lPdTB6TmVqSERMT3Rx?=
 =?utf-8?B?VWdJdVRQdmd6N1ZIZ2N3dHEwN2I5cHlodjNVbDFZNm5zbXRQWXZGSE5SUE44?=
 =?utf-8?B?NHNFUlVuTFBQeHpPRXMyc1RuNXk0UHNqNWpxS2dmYm1yUFNYTzhIVSt2S1ZE?=
 =?utf-8?B?MnViSUc2UXFldmgzTHZkK2tPWEYydFcxb2JSb3FVTm1wTWR6eUcxV0VUb2ZE?=
 =?utf-8?B?RlFXZTlNdkFKdUVpVXpUZVpKRGVsTlFqWXNHbE1LN1dHS0M4dUtjZzdJUWxt?=
 =?utf-8?B?dkNBTHp6Uk5lNUxtZHYxWnBIMC85ZmdUMEFlcHFsYVIyUWR3UnR4eGVrb2tS?=
 =?utf-8?B?UE5SZmd0dTdFNHJwNnJPamNVYjNjTFhnOGFZOUFCc09QajRsbHFBQXpUeEtn?=
 =?utf-8?B?bzFFUmxzdmlKNFhoRFNwMnI2Qjl4NlpwMzlFek1iOThEL214UnVhWExNUlZx?=
 =?utf-8?B?YzJ2c0hVdE4zWDExcmFwcFZxSVhSQ2k0bGU0MUo2ekhOeHorYXFjVS9oUk5y?=
 =?utf-8?B?NmlHZ0xwMWNCa2hHUGs4bER0QzBCYnp6azF5V2JqUHprR0pIYnBPZkFjdzkx?=
 =?utf-8?B?WWFVdldCQVBwU1padzB6RFgxOWt3bFZZSVZGU0ZMRmMxck1mLzZ0NlQzd2Fk?=
 =?utf-8?B?K1AyckV6YWR2NmFYWWw5b0dFTVpmaDhIU3VhWml3eVM3T2h3MnI2MmdLZEoy?=
 =?utf-8?B?VE5HV3JVSU9QL1JsZ1Z2SUJERmZzRXFkeUlOL2JueEZ3WGxyMWJyb1M1T05m?=
 =?utf-8?B?QWt5NGZYNE0yZTAxTXp2UWFXL0daclNpU2JaWVdHREVTQUdVcld1K0dpYnNE?=
 =?utf-8?B?VkJPaFFiSDgzYXR3Um5NZktsazBScFl4VmFzZ25YODJHQlJTOGhiQjVlVEJZ?=
 =?utf-8?B?OTgrOE1LVjVic3hUYlZmSUN5RnA3RnRJbjJMYmVjZEI2SEFkRGxwOXFWeWJp?=
 =?utf-8?B?RFBDa3IwUUp6RWZNaStCK3JIVTBkcm5qSHladjcycnRhVHZEL1FHRW1qa3dh?=
 =?utf-8?B?THdRa1pyd3hjbHoxdTJGMzBQNjdtaEx6WW1FWG00QjBKSWs1YWdaT2tKTDAx?=
 =?utf-8?B?cUh6azcyU1I0SXErcU0wS2JkUmVYSXRxRHg4SFJ5bHhQeENkWUFEK2g0QWNQ?=
 =?utf-8?B?M0JlcmpwM0JvRG50SEV0cWxzeFYyNjEyUWwweDFLQ2I5QmlhUXk3VzJZN2Mz?=
 =?utf-8?B?dEd1MzFuV1NPUFpSWHlGcGxlbFNzVnpOVjJac09GYUlKOUFDQ1NvcVlvUjBH?=
 =?utf-8?B?U2VMdDEwcVpLK1VWeWdUSnU0M3VTblJ6cmJNOE9xUTEvUk43RUZ3TmJNT0Zq?=
 =?utf-8?B?MlZLblhDQ3gwMDNQaHNKUytEcDQ3c29kcVZzbzlFK0w0eE44ZlcvR01ESWNW?=
 =?utf-8?B?OEU0dm5JVmtHQUNuMTlKU1J5VmVjZTk4MjNQWVdyZ3p6VkZ0cHRNbVQxeFFi?=
 =?utf-8?B?TWNESmxTS1A2ODNGbnZRdU1seVVibUpYSnJPdUdIdzFjK1QyRSs3Z3RwRWQ1?=
 =?utf-8?B?NmNMQWtzSlRRYnppTkR1dTlndk1BTVY3YU1EamZRUWU4VFFLOXBwTkdFWFVo?=
 =?utf-8?B?NlNLR2JBUEswOStDTTc4RzJzQzYwclZva1dNK094K2FkRGpIMlZOS2xnS1RC?=
 =?utf-8?B?ZVJGZGs4VzN1UHNyTEZhTlc5N0RNNGg4a3lQQlVUQ3piSHJpMDhFREdhYXRm?=
 =?utf-8?B?WTFBblpqQk9EVVQ2eWlkUkhZTERHVUdhMEszNW9KUXVqNFJlaktJVmc4MlQ3?=
 =?utf-8?B?b3RCY3RqK3EyUS9ZaVdTTng4Nk1NN3EwM0VCUkhpeCtSeldmdTlGSVBHUDhC?=
 =?utf-8?B?TVAzanpmWFZkWXdnaEkrNzdLWjNLMDBIU0NIUWdBYThGRU5oVXV5bGxLUnYz?=
 =?utf-8?B?QjBmSVlOMVd6bkZ4VU9UbVdWWXJJa2IrK043YXp6M3oxTUV6WWxrMDhsTUxM?=
 =?utf-8?B?M2p1TzFLLzcxZWNrdlhFSXlxS3E5STM1OWhrMTNXYWtkL1RIeUVWMFpXMWJm?=
 =?utf-8?B?VUI5QTVIVVlCbHYvRG9JdXkzNml3TDloTSt0Ui8yQ2trS0k3SHNscWxPcVhL?=
 =?utf-8?B?N3YrSkFIOTRkZ2dDdVFMVjA0S00xRzdmVmRuTk1vTkhMSHR3STdYbm9DVVMx?=
 =?utf-8?B?RUtVdSsycG9qajg0QytTVEtSWFJQdHpMV3hjNEdOK3R5UjBEamFEUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36cc891d-b697-4eb1-d2e2-08def943082e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 13:59:03.0385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: owHkKlxAOc8BwYqroAvKtOzNA0kklWcok9+QPjhR2wdTg9KsWHlSJ82UC6qwuctgsaajWG0S/pq78FbVVfVBLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4179

Usama,

On 8/13/2026 6:48 PM, Usama Arif wrote:
> [You don't often get email from usama.arif@linux.dev. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> On Mon, 20 Apr 2026 08:42:02 +0000 Vasant Hegde <vasant.hegde@amd.com> wrote:
> 
>> This series addresses CVE-2023-20585 [1] by increasing the AMD IOMMU
>> Event log and PPR log buffer sizes to the maximum supported value (512K)
>> on affected CPU families when SNP is enabled.
>>
>> Use MAX buffer size when SNP is enabled on Milan/Genoa. Impacted buffers:
>>   - Milan : Event log (PPR/GALog is not supported when SNP is enabled)
>>   - Genoa : Event and PPR log (GALog is not supported when SNP is enabled)
>>
> 
> Hi,
> 
> This series seems to break kexec in our production on Milan hosts with SEV enabled.
> This is on the 6.18.43 stable kernel backport.

Do you have dmesg?

> 
> If on top of 6.18.43 release, we revert the 2 commits, i.e.
> Revert "iommu/amd: Use maximum PPR log buffer size when SNP is enabled on Family 0x19"
> Revert "iommu/amd: Use maximum Event log buffer size when SNP is enabled on Family 0x19"
> 
> kexec starts working again.
> > Could you help in fixing this issue?

Sure. We will try to reproduce it internally and get back to you.

-Vasant

