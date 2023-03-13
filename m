Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1136215AC
	for <iommu@lists.linux.dev>; Mon, 13 Mar 2023 06:35:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UWiL8tct1ozsq8657OvQwyk5VymPNzvnaT3fSY6DSHHZYUaq59x0lqcKijXTCGy65eTbt9VPTlvRvzbxxEzSL6J6cx18GWhurHNlPxZf6umCsFBYBFg0qCXISeb3+Kbw+85MESPK/+rbuFxT5ogZscbIcM4Dsw1+spPZt/wY5GT8C1SEPE/iczNztyNwoMq7ycDXTON0xZi+IBKm/Fxxhi4fD95bdW3HZJI33adxmnduq7IXa83h71nedlEiwemS5pBXuNVv7TMswPWbmtZePbj2n3Xc3Q+h15ujU+o19i50T6Oa0/sZjP6iZemZL+Ao/Mvzl3V1Tml8Q8sYV14/CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqdS8TGQ3aQ8IRNYDkUkxQbdeskWL2coI3H5J4Azvm4=;
 b=EreuWWwvNR9prjbGznNqybdhoKLyBbyezRFha4uRNm5nST+VXRRgMGyOy3k7/4XisDzURgcfYHlooA6JWz8lYIBnMhoRyFjiM4ZJbn2XLFrjmIm/R6B0Xh0KjUcaQYuOmMyo+Es48YJrae48i5FrGIjx8ksbfHOIMvZUUyebtaL1Ab5RgPM42OSYLLRLxXBOgdbj9aGCeclWk2byXFVu5gDOUxm5UNB+jP6XpSA24hQLrz3wpsyIE5H09v74XUK8eoP92LpK1wx8NY/7H61as7S2Yh5HtgcVi7U8ED4w/pt/9QiDOc43CbBbo5ZcfzK8ZPv/hqCvUQ2MNVasiSSkHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqdS8TGQ3aQ8IRNYDkUkxQbdeskWL2coI3H5J4Azvm4=;
 b=pXzDBdvEi/BbCypT2nFuiKrEN1ZsjLCSXAeCpAyqEvrKynooCCMukCSKYZ8s9I+mASgIa944Hh8A9nvis7paME9QJWfoHyDuwp61jZbvxZC+nKMSjChBH1CflScWRWcRSXzD9mZ6X9EpXa5Vr0OQLqx9FEVR/oVvo+bdh5H+avo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 06:35:01 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::70b7:99ad:2e50:8cab]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::70b7:99ad:2e50:8cab%8]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 06:35:00 +0000
Message-ID: <c47d7833-0cf9-97c3-17bf-87ca0911fcbc@amd.com>
Date: Mon, 13 Mar 2023 12:04:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/3] iommu/amd: Allocate page table using numa locality
 info
Content-Language: en-US
To: Baolu Lu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
 joro@8bytes.org
Cc: suravee.suthikulpanit@amd.com
References: <20230310093130.6064-1-vasant.hegde@amd.com>
 <20230310093130.6064-3-vasant.hegde@amd.com>
 <72947a6e-228c-9432-b6b1-2735b0975cb8@linux.intel.com>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <72947a6e-228c-9432-b6b1-2735b0975cb8@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::6) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CH3PR12MB8535:EE_
X-MS-Office365-Filtering-Correlation-Id: 331e12cb-e78f-4132-f4d9-08db238d11da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ecHASOPVSepXaV7ewugGfxqRq+Au1I6Q2Ij1AM6KZE7Sf+LEqQT0fgBZrmP0trHAhNEnlRfPT0wEW+CpA5wbBlIkIA+wq6O6WF5eIeF52krtQBir2CCZUKb4u+oCNq4heZ65Nmx+m7GbV+EZQXT0hHQYBKFD7o7Ug+0V8N6rZ9hYgj4JKkp/iKgOEf89/eiqV2LOxLoRSNQe02Uj+bkwh7l90Onbahf52Hhv0gc8IEYY7wRQ9l5xp10t2FpOTXHDj+gAdn2xK2+RS2odUJmY2okgmz4V1vobx1mk2MwL1yZD82gFj76tXFgTEPdGyNLVDCQiTDXC1Gj6bj7tzd8Y2ECYL5rYMt5z8RegJDrhcbHkvKuRWujmq9+oTu7osoAKkN5z3+jlTmK5IO2XTVESmvbYq+W3Untp1gPDaz5T3c78pqBIu5nbCLZllvuSZcpVb0b3f0bPHNhdTMKy4nw24zhoNriFIFJmUNpW6Ep4FcSilUppKcNR2X5FaTswMjqF27ep+U9hEvbnjNzAC4/4ubB/TyEY3U8R6nWHuoNwpJ/Ob12R8ltcLGkBPJIW1sBHafLQ2Y4haYBmlvoM7x2C+5RalYJVc/0QL9ed3NbAu5IPIls7t7uda05LF488z3QNsXzuNx22Z66yXEMjMcJoDY+QSm8WEuG6pmWRWC7powF28nlWu+a7VwdbPIw3/kqPWcQ3wM7x0aqY0uXWp/TbnjZLdqbTFYNInhK+FWmsKOQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(451199018)(31686004)(8676002)(4326008)(66476007)(66946007)(66556008)(41300700001)(316002)(38100700002)(8936002)(5660300002)(2616005)(478600001)(83380400001)(31696002)(44832011)(86362001)(6506007)(6512007)(53546011)(2906002)(26005)(186003)(6486002)(6666004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emZxRnNLMkQvWU9yMC9Zd3ZoTEwzaGpuUXZudFNBMStKZG9zSFVQVWViS21p?=
 =?utf-8?B?NHRUVEJzaTRBbVQ5dDdmemNLeE1NUkJDMFV1V2ZHQWlRR050eGVYa2xlb3lF?=
 =?utf-8?B?NTk0OWNPcG85VVhsTDBzakdYK2MxV0htZHo2NkhId3k4djUwQXhMYUZXWFlz?=
 =?utf-8?B?dDJ0YTJZaGpCTHYzYVhKWmZ1K2EwWStjN2VZUS9LSUkwaU9oM3ExdjNDL0hB?=
 =?utf-8?B?LzNiL1lrRTRJVnZzNm51azdEUzNxalFUbkdSaTVIOUlrZGkwdXJPbkZwT01r?=
 =?utf-8?B?N2haVC94L1lMZ0MxUnVkQk9yS2dabFBNLzE2S2tCR1dhQzI4TmZ5a1NGU2ow?=
 =?utf-8?B?QlJZNW1ESjJIeVhBOVFOTkRpR2xWSW85cjZsS0FCZTBzS1gwSVU5dVFPOTh6?=
 =?utf-8?B?TE40WHVNdjNRcGEvZnJUUTdNNVdmSTNjb2dSMmdFT2tOQjVSZ3NhaFc1eWFv?=
 =?utf-8?B?QWU5WTdQRjFuN0FjUFQ5UDg0L1NsUTlYZTBwaWVVK2JMQ0Q2azJsYWhlcEdp?=
 =?utf-8?B?TkJsb0drR05kdllJYjgyYXo4ekJQdmUydGs5VEdJRzJaTzQzRnpjVWlDTTda?=
 =?utf-8?B?VGJ5c0t2aThSZDdMRDZKTno3WFdhbXpJWTB1OWpZNXpCVUU1SGhlRFdrMVlI?=
 =?utf-8?B?RG1yVmFiNG1vaFh1ekhVeS95YUxBdHR4eUJTdW9WQjdRMVZJU0ZoSkdReGU5?=
 =?utf-8?B?dUF6aXZDOVpzWFJGSzl1dGJNRVBneGR5dWhXZzc2Wm5yK0dLMlpkcTRKM0Yw?=
 =?utf-8?B?ZG9BRFUzTGNveEtXZmhUUjFxRVNNQmo5Vnd3SU5YYStlUHA2QmlzWkg1NzZa?=
 =?utf-8?B?bUs4NDFEMk83RzBuQmlNbGpKUzYxbGlyRFdtSFVLVmtTZFE4d2ZFeGtCYWNF?=
 =?utf-8?B?RmhNSFd2YVkxYm10UElnSzdyVUMrSHNHQkJITE9oQzNXUlhUYWdTRkUwbmhO?=
 =?utf-8?B?WGUxazVpQiszd3o5TDBwTFh6ajkrZHBkckF3SEtBL1ZlL3JSSFJlUHFqcEJ4?=
 =?utf-8?B?UHJ5alpHT1UrNndnd1VOQTJ6WnliVEg5a1cwTEpOMkpjNXQ2Rko0T28rL3RL?=
 =?utf-8?B?aHZKM1RHck9hZFk5dU1hT2RCbzQxUEI1TEdJTHYvYm5JWEF2MEkxQ0Y1Z01P?=
 =?utf-8?B?Y3NzZkZQcEhyck5rYWNYYXFHREpQOHo1NjN2aXRCU2VscW84VXJLT0VZWER6?=
 =?utf-8?B?OUVIeER5a0dqd2dOblNSemNaS0paZDBSbzU2V2NPaEhrQzFobHVyRzF1MEYv?=
 =?utf-8?B?RVF4YTVCdGJaZWEwMzdpZzh1a1QyZDRkMnFHb2p1VXlOSmQyTndpeHVRSXpr?=
 =?utf-8?B?NXJzcWRjajVHQnAzSDVPeXBWWVE3V1lneThNbi9aYUZaMjJVOHFnVjhVd2dF?=
 =?utf-8?B?YTVIclhROHV6LzdJd1NYeU80ZE5nanlEcmtUaWM4eVduYnlkQTBTM1hTQ0Q4?=
 =?utf-8?B?dVQ4Rm5pOTRSMDBCR2dQbXk1M3pNS0tmNmlJby9CYW1ITnNxbTBxT1RsN3Zr?=
 =?utf-8?B?Szh6WlJEWUs3QXAyV20yclZXZEh3TE5Bc1Jqclh4aFhrUTRzSzJldkRlSGxZ?=
 =?utf-8?B?bHB2YUM0d2NpeEdrdkZFNHlITXR2Tk9HKzNoNjhVLzJNbGhqbWhMV0NiSEZB?=
 =?utf-8?B?cVFHWitIV0h0L2xXTTZzZnpGMlZRaFNNdjFLNWVQaGJDVVdFYjhOMDdDU21D?=
 =?utf-8?B?bDFGWGZMUmRqR2VISUg5SHhyanV6UjdEZjRoRHMxcWx6Z0pURmtoWHphdUlN?=
 =?utf-8?B?MmtlVEN1VnFRSTVyK0lkeS9lWFZGcllUWjVrRjhhbW1TSHlMeTIzVGxYaGQ5?=
 =?utf-8?B?clJLbnFGK3BlN0VISU9EcUQyRGtZeldiL0NEbHFIMmhpalNsT2NreUZwcjl4?=
 =?utf-8?B?R0QxeXdaajB5Yi9PcEh4QkdKcUZqd24vMzduSlIvRElIVzNDYkFUbnk2SHY3?=
 =?utf-8?B?YjduRVVlK3krUzc4R0J6UjdnMHFWekpFYXVkWkFicWsvSUZDS0VMc2xnTTE0?=
 =?utf-8?B?NFpMYjNSMDdLSDJ1MTc0dXBwd2hqZ0ZmMVZWWFZSY1JFckE4b2REZWdZeUEr?=
 =?utf-8?B?K3lFeXhTZVp1ZGhYcURxS0hFRUxCci8yNk1pM0pINmkvUVNtQXRKVUdjeHFy?=
 =?utf-8?Q?4NYmNdLekNPQhSNLf8dIeXn7G?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 331e12cb-e78f-4132-f4d9-08db238d11da
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 06:35:00.3886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jvwvHTw6suXmuBpqUzhI21gwpJ0T8rXBDYzjzNmRP9Ia/k3x4cbeluJoxEKiNJbFd9K/9Osx/EaKFUChGPoN/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8535

Hi Baolu,


On 3/10/2023 5:14 PM, Baolu Lu wrote:
> On 2023/3/10 17:31, Vasant Hegde wrote:
>> Allocate page table pages using IOMMU numa locality info. This optimizes
>> page table walk by IOMMU.
>>
>> Reviewed-by: Suravee Suthikulpanit<suravee.suthikulpanit@amd.com>
>> Signed-off-by: Vasant Hegde<vasant.hegde@amd.com>
>> ---
>>   drivers/iommu/amd/amd_iommu.h     |  8 ++++++++
>>   drivers/iommu/amd/io_pgtable.c    |  4 ++--
>>   drivers/iommu/amd/io_pgtable_v2.c | 16 ++++++----------
>>   3 files changed, 16 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
>> index c160a332ce33..916e888a941a 100644
>> --- a/drivers/iommu/amd/amd_iommu.h
>> +++ b/drivers/iommu/amd/amd_iommu.h
>> @@ -122,6 +122,14 @@ static inline int get_pci_sbdf_id(struct pci_dev *pdev)
>>       return PCI_SEG_DEVID_TO_SBDF(seg, devid);
>>   }
>>   +static inline void *alloc_pgtable_page(int nid, gfp_t gfp)
>> +{
>> +    struct page *page;
>> +
>> +    page = alloc_pages_node(nid, gfp | GFP_ATOMIC | __GFP_ZERO, 0);
> 
> Out of curiosity, the caller has already input a gfp, why do you add
> GFP_ATOMIC?

I missed to remove GFP_ATOMIC. Will fix it in v2.


-Vasant


