Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEC413CFAF
	for <iommu@lists.linux.dev>; Thu, 23 May 2024 10:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716460845; cv=fail; b=VEitg/1emZ1iQ/EUrTtVP0tknXATNR+hb5sNswRyO6UH4CRm8axlJWjB9Vnx8cmEA260MX4VnphLoWbHpMWw2PpvsTwIPjIVGhFpldDRr+Uyo+gzsvC4ACt7Y4z5xThYhAX7iR4Mb2P8mf+OkLqu4XIPrRs/EEbQd+azjs7FWrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716460845; c=relaxed/simple;
	bh=4sGHe7qTSgh4kCYsHZnqHqbO6gqfsgeVmYR62JV+RcY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ieXHVzHE8fT+W+L8jjAiUg6jMBsd24COF5rq71dvtnqT+7aT1v89k4D4VSy2yTshdYvDETsG1+a/hmtkn3HR5sV3XUEjtP29lCqAZrMsqYz9FBxxQpEX9n4QlAvX+gcaNj1Z9yNgEQ/urmHdvJrX2G2kzoS/VUaEId8u635pArQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=npU09icX; arc=fail smtp.client-ip=40.107.93.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="npU09icX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1CzCKQmQ4w5liUSr6mTAYvozjWEm4QycWuMKpBcxol1mRCGmHAsK6af6NghTYnE/T8w/q+kW06IAJm2C3MYH41706AhCYALTo/tQJHLaEYviMmYERyO2RW29pH8yJQ87dPhFuLKt3xqZ+V6rGm4RjKdBTi4Zw4Vcy1F1lXbOE9VZHbS98dAvv4JNzaMBKQVjfcPJSpnXquPzv+gswSzBq/EIhHoUXvu0kdmV7eCDo18ZDu8ct96CVZKYmFepo4Qe/VOP0M9PODErIOVQvUt0Zt82QLPttjkfAbvB9cs5DYQa9+rknGtWrgJnQ4wFl7nZ+uQ+MLmWDCT0lYfOapEGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJPW3P3hjESHaBglB2CrG8PWbM9x7tGg1ozNuEQE56s=;
 b=h5WkL/yA+rZgHvYOSHnIGuUMhT35L0f9ItkGljO2wP5YXkaTk500RKqF/EEVGX0RquhCZlr3PqIcEGOWqEAFFsIrttbCQYt2Oq9O0OxUoJIxpOonXNrJOW+4DSeHDqSNwfeZPvwEv6orETeh/Ojs7Ny6WaKQ8eWRkVOxkaae6U/IVyLZok/Nq1O++lkK3hIjdDRtuv4TmgFed1KrNsY72qAXjqVcXmJcgDDhF9beDN4mKedRnDMKlelph7UbqCdMOk/PH1+rXgIYlApIxZ++wMiUvQbovtw5wK9/nTHvo+yaD4shDCBz3bjTxtbVsh7OAvMwEH8SNoIqaVI0GIz6dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJPW3P3hjESHaBglB2CrG8PWbM9x7tGg1ozNuEQE56s=;
 b=npU09icXIlWDdVh8uAGb/vNl/yUZHkqeiWDYo1QWVv8/6mMKuTndJwCs88XIzvyTAC8RqJ+OuRH7wt3qcyFQUV/tHsCB+EECNx+13l1n3l1mjgKZ42XrB1Uyen2x7yD9ULG8eDmNTbwFtNAeJKykxPOE4Yn69jskhKzPPXoMbZk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 IA1PR12MB6483.namprd12.prod.outlook.com (2603:10b6:208:3a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 10:40:38 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::af7d:5f4f:2139:ebd1]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::af7d:5f4f:2139:ebd1%4]) with mapi id 15.20.7587.035; Thu, 23 May 2024
 10:40:38 +0000
Message-ID: <bf2ea452-75ea-4091-90fe-c83062729b76@amd.com>
Date: Thu, 23 May 2024 16:10:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] iommu/amd: Use try_cmpxchg64() in v2_alloc_pte()
To: Uros Bizjak <ubizjak@gmail.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
References: <20240522082729.971123-1-ubizjak@gmail.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240522082729.971123-1-ubizjak@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0086.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::26) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|IA1PR12MB6483:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bdcc1f5-e8e0-490a-6eb3-08dc7b14c911
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWhCdWtCdjVaOUhjMU1CRzRpaVlURHhOcldMYnNjSWlBcHAwd2NuWUJ0V2M5?=
 =?utf-8?B?OUhZaHg0VG95aUtQTG83c1kxa29HbXV6SVlxZGJkc0RkblJNaDJLQzhHRjEr?=
 =?utf-8?B?RFErdnBveUxPQk1uejlDTnFCbmx6K2Izc3Fhc1Z5VE0yTm1BQzNoWVZvditL?=
 =?utf-8?B?OElxaC9CUlpORXEralJINFFtc0tJWHdBZ3Y3SUx2aHlPRGdKUHAzcTZnRmJT?=
 =?utf-8?B?Y1EreGlrcVEweDdTL0dXamtNeVhkSFpNU0dHeUo3YlV4OTBaZ3N6d25RQ2tB?=
 =?utf-8?B?ZSs4ZGJiZ2s3b3ppcDArZFQzSmc0Y3RkUGVJbXVJdXdJRjRQT0lIOTcvMDZD?=
 =?utf-8?B?ejdtMEkwQU4wb1VRaytEcE9VQzJkK2RrRFZ2WXQzZ3lhOXJVUU9VTEtGakN4?=
 =?utf-8?B?Q1JvUmdUOHhRS0lkRFNWeWdYdUs4bjhPdGVGTll3N2RXTEt6U3l0bXp1bURy?=
 =?utf-8?B?UnB4ZlkzcjVoYmFLSll5aGpGSit6aXFPNG9xVUgvY3JhNlBqeWVTYWhkcDN0?=
 =?utf-8?B?bGdYUkJBbFhlTFg3S1lqdWI1NzZWajNGOXo4Rm9HczRiQjc0cnF2RVd6dmNC?=
 =?utf-8?B?WHR1Z2FKdkpGM0hUZDBJUWJqb0RmL1JzUmwyWDhpWVN6RUlBSmkvYlNqWWN0?=
 =?utf-8?B?WmhqSDhBc1dqcURKNWZjTm1QKzZXWGtLOFI5dzVNMWFlaVVoZVY1NDZ6Wmp5?=
 =?utf-8?B?VHd3Nkk3a1Nzd2FXcWZIMlM0K1Nzb0xDaWh3TkEyd1ZIcHl4bDJGNFo2TmZQ?=
 =?utf-8?B?NlN4UXpqb3VlN2pmQWNRRExMcEtUdmNKblpTVWpxdEc3ZmkyVzVFMUlCT29W?=
 =?utf-8?B?NUdYd0RQOHgycGw5ZmF6Ulo2aXIvSXEvMjRwKzdRbmtmZHE1THgraFN6d2pV?=
 =?utf-8?B?VnZ3dFdFbHk4bXk5dXNIMDJPUnBtY092eWZZOHZyK0cvRjc1MkdzeEhnc2Jo?=
 =?utf-8?B?bDRKQjVXc0xSaGRKbmd4TDNKdk9zbHphM3NlOVZUTTYwWFptbkVUSzBCRE9J?=
 =?utf-8?B?MW1SenphQmtSUU0rU1NiUjVEWUxqN2svNjJLcGh0ZWdlZUdSQ1M2Y1pxUnBJ?=
 =?utf-8?B?NGpTdFp3QzJGUTRnTnlaNm5TSmdnTFpsQzIvMXhZL0JNQVJrcXd6SXppOG9w?=
 =?utf-8?B?OU5iUkRUN1ZvU0JSU1hlUjQwcU9EdFd3TklNTXVRQ29WTWRuWHozRnNrRHJj?=
 =?utf-8?B?azhoOXRncXl1SVlrcTVwMjhqRWc2U3B4clJWNEtNMmZtZjhDZGlzVUpDRDBX?=
 =?utf-8?B?OXpSNGQ2Rkpzd3BjMGVRRVFYaWhrQUs3SWtCdzFSRE1iYVRTOE5FSTBZK0ZO?=
 =?utf-8?B?VmVyVmJiQnRFbVRWZHdocDloVHI4aGc5SmVWcEIrV2xzczRXdjdxb2RGNGlt?=
 =?utf-8?B?UFFLdXlGNXl5UEhJS3hlaUg0YXUwelErSmxZNGRkUDBhVlZoVTBsRVB6VmE3?=
 =?utf-8?B?WUJrMmU5a3hnN1ZxYThlZFZOVVczSVU2OHlvRHdwUG9uNWZhbWRvNU5mdENG?=
 =?utf-8?B?NW9hek11d0ZZemFvNmNPbzBFME1FTjBLcTN4d0d0bTJUU1RrTUJyZXJ6ekNY?=
 =?utf-8?B?WlpjQ2FXdnk2ai9paVRLbk13TG1Fd3lNbmpBQVp3Yi9WL0g2b2piR3NoNWZZ?=
 =?utf-8?B?WmlCWmhUeGMxYXY0OHZ0c3Z4QmxITzFSTWNDa09LY2lQbG4vR09PdFlGWGlo?=
 =?utf-8?B?ZDlsTnRXNHdyc0dZMTZodGF6Vmg4c0VsM0Q5L3RoZm9OejFIVkJpR3ZnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0NGRWhDbXc4Q2NJcERFZEZNdytuZlJlMHFTemdJd1hVMXFvb0w5TEJMNERo?=
 =?utf-8?B?MDNiMmlNclBlK0h2cm9kbEUraEZnVjNKdHFaUlJobEtaSndsOVo2cThoTmFW?=
 =?utf-8?B?TUpRSDYxT092M0ZxRWxEYzVLbGpFYkJydjIyaE5QMlY3WmhJdWVhZXc5Wmls?=
 =?utf-8?B?cUxYRllsdFRtVEQ2dDZBdDl3SW5BcEZNTUhtQ085QzMwRExDVDhodG05czEz?=
 =?utf-8?B?NEV0R0c3NGFhSVo0bmtiRTczbmRNdDRtaDE4d1RzRjlkbWcyUDNtdzRZM0xy?=
 =?utf-8?B?bVRFaytSWXU2VGFtdXhzbW1OYU9sUEFOWlVaSWFlb01tUEc5SmNPSUExTmoy?=
 =?utf-8?B?d3BBNjFSdnd4N2NSVmQxek8zLzVCRldFL21LdlVIa3Y3RTFOKzh4SGtOQ3c3?=
 =?utf-8?B?cU1UalQxMW4wdFNoZ0kvQ01wVzJEQUJtNzRoeG4zcnVzaXNNWjZEWXdmN1pB?=
 =?utf-8?B?U3hndldmNUU2ZlI4Um81bzNVZ3Q4bnBjcHpWQ3JuU2M0S0daZlMrVDhsbGVr?=
 =?utf-8?B?bnhMTU5DOFVMT1NEeWZaNzBiQlhCOW90dUxxRUd6aThUaU5JeDRCbGNZTUlI?=
 =?utf-8?B?TnF2MXlsM3BDcEU0eVRDRi9VWnVKdldHMFdDbHZrSUQ5VStlVDlPN3VxRXMv?=
 =?utf-8?B?bGRmVmlUQ0l0clJ6VmRuOEU0dFdNMzBsWVp1NVQ4RkFkWEdvcXdaYnQ0VFo4?=
 =?utf-8?B?c1NRZTNNWjBYSXVNNXFlK3NXS013dWordzRtUFZadzArOVArU1dIR2VHUE5Y?=
 =?utf-8?B?YXdhN0NSY0I5ZjFmV0w3VWF4V2NmU1NqeWdxTVBlaHFKSlMwbHpHVkl5U05l?=
 =?utf-8?B?Q09aQXEwZXE0RFpFbG9ocS8wQWtrVmpBaDdxeE1ySWFpUERtaTNUUHVCRER6?=
 =?utf-8?B?L0o4K1VzYVFZWmIramd0RFBCY08rYlh4V2xjakRyNzJNUVVDalpZSTF0YlAy?=
 =?utf-8?B?REdnblNzTis5ZjdJOU1iWi9YY0d2b1dGTUM1amdoYU9XaituTjdsRGtsVUJI?=
 =?utf-8?B?azRDK0JXbU9IZks3Z1Z5UEtSb2ZOdklkcytoVXVYY0U1STI1VEFWRktmS2hZ?=
 =?utf-8?B?QnFNUGdPNGVvTUFXeHlsb2daZVdlckFrOHhaN3N4emw2d1JDQ0lXamtRRmlS?=
 =?utf-8?B?cUZ1NzY1L21SMW5TWmxHN2ZyY0xlNEw3azVjOEMvOUhqSnQ3bE01Z0hUdm1p?=
 =?utf-8?B?eEIyTTN6elJQOG12RVR6TkNBdFN2Rnd1N2k5TXpzWXZ4Mk9pRGttOFhSRi84?=
 =?utf-8?B?VE5tcHRpaUd5b2dsdEt3MXVqTTZ2WFZlSDZPb2NyTDd0dnNmclRUZ3dNVGZ3?=
 =?utf-8?B?dXo0QVBTa3dDbVBDZG1wODh0aHU3ZlBIcU9YM2REd2Y3d0g4NnJFMmdPYmNr?=
 =?utf-8?B?NXdiMURadGZ0SXJTSTh1ZEVNbmdOUktQdFRXY1VsNGp3N0c5Z2lmcUJ2VTEx?=
 =?utf-8?B?Zy9udGVkMW1KVzl3RVlOUkZkNHdTbUREa1M0VnhvUGZaTWRyTHVCYXdBUXY3?=
 =?utf-8?B?bnF1RW04MWwxUlNmQnpOd09RL3FOMGVFTlZpcS9Ca0pyL3J3M25TaDg3VTcx?=
 =?utf-8?B?ZzJROHRnbG16Q1dqV2ZNV1lYdXFhTTJ1em1YZ2FjYWJORXg4NWl2aFVaSW5m?=
 =?utf-8?B?cWlpdzRwUlZBRlladGRXYzZSR2dOamhQRGh1UjN2Rk9PbUF2dUJQMDFNaG9z?=
 =?utf-8?B?NVlPT295WlZWem5hamp2SzFRS1g4Q1hHZE9jdEtLRFdvMzhJcCszb1BjQzU0?=
 =?utf-8?B?d040WGFIK3pXdGxTYjdUNjNJbU5tdWdqM0RHcG9pSUcwMFMzdEJsU0NnbS9O?=
 =?utf-8?B?ZHg3MWFwV1dBZE01S1JzdzdPS1M5aHpxK0lnTkNpd0oxZHY0VE5HYUpiQlpV?=
 =?utf-8?B?a2J4NzFzOGViVWQ1enoxUUlrOGVDMmJHbjRXTjFHWXNHZWlhbmcrS0VvNUxF?=
 =?utf-8?B?UldacFIrcU1FU3htdFZqeTB0UGFHMTMvN1VmS0hGZm5LL04zWXZVYjhTRzMr?=
 =?utf-8?B?NGkxeTBOU09WYkpGUXpPZDdZdGFmQTdIZnh1emxKNFFWQVNyWksxd21SWFRi?=
 =?utf-8?B?aUJOS0dwMGt1Nk1qTk0rL21FV2Z4aVlpUDNLdHNZb1Z3YTlsQ1VXSWNlL1Vq?=
 =?utf-8?Q?NcQGix4vz9mMzyhBeLJCU1ScU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bdcc1f5-e8e0-490a-6eb3-08dc7b14c911
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 10:40:38.6142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lZRD6ziPMcUWnaXYFg+CC6MgonJz7G8M5vddpAyU5AZQjNinvOuVC/YOOtuRvrACdWXKYXo++5CG1PiDTtQjpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6483



On 5/22/2024 1:56 PM, Uros Bizjak wrote:
> Use try_cmpxchg64() instead of cmpxchg64 (*ptr, old, new) != old in
> v2_alloc_pte().  cmpxchg returns success in ZF flag, so this change
> saves a compare after cmpxchg (and related move instruction
> in front of cmpxchg).
> 
> This is the same improvement as implemented for alloc_pte() in:
> 
>   commit 0d10fe759117 ("iommu/amd: Use try_cmpxchg64 in alloc_pte and free_clear_pte")
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>

Thanks for fixing it. Looks good to me.

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant

> ---
>  drivers/iommu/amd/io_pgtable_v2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/io_pgtable_v2.c b/drivers/iommu/amd/io_pgtable_v2.c
> index 78ac37c5ccc1..664e91c88748 100644
> --- a/drivers/iommu/amd/io_pgtable_v2.c
> +++ b/drivers/iommu/amd/io_pgtable_v2.c
> @@ -158,7 +158,7 @@ static u64 *v2_alloc_pte(int nid, u64 *pgd, unsigned long iova,
>  
>  			__npte = set_pgtable_attr(page);
>  			/* pte could have been changed somewhere. */
> -			if (cmpxchg64(pte, __pte, __npte) != __pte)
> +			if (!try_cmpxchg64(pte, &__pte, __npte))
>  				iommu_free_page(page);
>  			else if (IOMMU_PTE_PRESENT(__pte))
>  				*updated = true;
