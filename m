Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.0
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795752960;
	b=LAmd7PzA9lMnVI1Chubw0CWHgJki1G+qmrNq79t/z4/FW63pnAsYFg3w5CyTmCaU1Mhl
	 vs8VoRm6Pyi/7S0FrkKFRz49EHJZ1zHGBUQ18iHcd1yALEJZidtwZZeRm63c7t8UpF1uZ
	 2OVk5gYAmsQ+jR1YwuGRgpzedEkK6H5oDECQN+hbEKSCLY9MJLNXBuZkVwUdPJdt1+ei1
	 2Abd7z+ug3BGteVFFsDoVRVJfw4rrtbfsyP30GJ9r5clRgmTqbte4v19MqjMXU+r6m41o
	 ysrtDuYJmhCo4ORRjacFkqW7x5ycd4Bf9UU7CvUN4MS/FLnaoJg3r3DgVhPnS/wd9/g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795752960;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=CczS2gSEWOAA0ynUxZllFT+5n8yR5fbIXnl/iYmkE/A=;
	b=Xqv34CiD4kwoEDtWt4ale0PKuIq4JtSvuY+xhBbSlYSK1DDltAld76wAavdsixigKdSY
	 /TrSsDhrQ3lca+iQ+tDMwZSoWfpXXb/N5r5ge2LojRCHDCwLyk9usGeoI5E2EkP252re4
	 CyxOGh9I9+Wo1CIAPNd1dfx8eeQ/b5NCZoxiRrQd7Ad8x3zNNEZSmVImLYZoHwYnlAQOg
	 N2DwmWAX3Qu/674RrHljGB2UiKgybWbJ5JtWJgYseN3ZbcmuHvNFSklLEuLjnkUsNAE2f
	 vrFM5b0ELK5HVYCLVlRYCHYeeQifXyNB/IYhCzPRoWbzcL90C3bS2YI01UrZWjjRzuw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ayubFQvj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.0
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011000.outbound.protection.outlook.com [40.93.194.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D44606A327
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 04:15:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0D44606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ayubFQvj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ujdMdI9sMfvLicKD20sHykXF8jr8tZ/ayZJxmtmcNJPWfDOODVmGZJOZBHnTMVVXVfKMu1PP+3+/yezcbludtlZMeaj41rNSYJFS897VefaytMNFc4iMZ6NQ8VYqdLq0vRediu6H49HMfzwaTlUabZ2mYKbjSm67WYWrKRRKq78Hb/iKXkhDQwRmeloTupB+9GyhKsRy+5WtsQ6K4raB+DzcqzWALRgR/GMoFybXFVZgeqL1ROTAWUnBjkHXikDtWE++abO2+N0TFbgm0oSEPhVCreaJIyBvnMz3lsnr5iJyIbbbRjIrDGyVM0EOTi3y4tseCpJmVn1bgDvFmcBc4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CczS2gSEWOAA0ynUxZllFT+5n8yR5fbIXnl/iYmkE/A=;
 b=mc4H8JYlz5qzw43O6vc6dZjQFue0P8x7z4ynrmvZ9yJkIaEpctTO2uCey0gVVvDk02hAl0G1W45NSb+hVvjuo1x3hj/KwaI/qRubwVoDFd6phpKGgkRupqeb8VMEvw+GqnGzUVUrIISx3GMPAedBCaMlCRYNTmaqVUEGDMXyXvQwwd6ZpUutKvJI2sFSPVcGZcRO4TIE2Z6TT2rwW3WvJqaYfhR0bvJuYn8ycijU70hTClN2Nmcq6xg0fNsGYYHcug35XXvsTitnclYf+IJCWG9C3FazbUrSJYm3XtNYTvlViYW3OhR6air/PBQnB8FWI/HvKCd+Uj6xp6YPkBqFOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CczS2gSEWOAA0ynUxZllFT+5n8yR5fbIXnl/iYmkE/A=;
 b=ayubFQvj8r18u5xhn8qhtmnLt0GBlfv+iodjr2+JP+QAHdren4Xiypj7uHwErFx8nFOKvhokRHT6B+w/Xy9s9QkvAVYnfrTzODjRuoJk/l5CwjyTHbQKX0jo98CRcJISS4828oFSp75Nnc/wjIe4cer5kwo3Z96opATOVvKYPm8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by DS7PPF539334D8E.namprd12.prod.outlook.com (2603:10b6:f:fc02::945) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 04:15:56 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 04:15:55 +0000
Message-ID: <6e27254c-17eb-4858-9b19-8c4503974b30@amd.com>
Date: Fri, 27 Nov 2026 09:45:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] iommu/io-pgfault: reject partial faults after device
 removal
To: Qihang <q.h.hack.winter@gmail.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20261117015409.25492-1-q.h.hack.winter@gmail.com>
 <56be2b4e-aefb-413b-8f72-0bea1f9e96db@linux.intel.com>
 <CAH78GvuUtU=zhe-Qbn9k73D3U5n1Ye1=8wtQqR7vCEpDzgNUJg@mail.gmail.com>
 <aceb9e9f-7ba3-48e2-8945-95179f22581d@linux.intel.com>
 <CAH78Gvubo20uU4ntOxzd-+B6GHpUovL_wYQt9yahF-8=x3sEVA@mail.gmail.com>
 <4420a997-82e9-43e6-8ceb-5ede44594c51@linux.intel.com>
 <ecc47f2f-d0ff-4aa5-9d46-6a0b9ed8c468@amd.com>
 <CAH78Gvvf92NrPTYU=hMs92FavwX67NpgeHBRqZ6TDziNg45-tA@mail.gmail.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <CAH78Gvvf92NrPTYU=hMs92FavwX67NpgeHBRqZ6TDziNg45-tA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0239.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f4::16) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|DS7PPF539334D8E:EE_
X-MS-Office365-Filtering-Correlation-Id: 69f9d348-1ce5-4cbe-61f9-08df4c3d21ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|4143699003|11063799006|261009221227099003|261009223027099003|22082099003|18002099003|10067099003|56012099006|261102123227099003|261026121527099003|261026140227099003|261028144727099003|261021121427099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	ojsTiP04ZGOLnEHVFHbCITGdUYDDgmQ4w9rMtz/IAQHbaA3JZ4mh3n7x5j+bnEwjGzBgGlV92hZBtLvD41yPO4eunr+Zuq6HDb6hsbxexuux6wQyY1XOhIcFZ5dYvz/4a9sKvMyp98th1KKM8N1VUIOqW9lRueCVwfC0Z5AjVHM4cUP2sDOL5olcPtmbLu2GsE57MUD7ScGUNfZDgaYAuMEBjyvzaTRhQ34e3lYr9gPOY9og2T7hZr/iv3vX+778ijs2SZUmU4KH6/xOko08p6PaeadK4yygSpz9n3mUfKxUMEBrS8Q6uftUkexYnKXs2H843FdmtXIDv+vrk4/sg+oyuMSnmRxc8EpO8aj9y9HwbB7L5d9c16EICgsbkQEp7EvczLqLbOXIDJENlT3+NY9AdVmFEdEeTqJXDfhABTVCQkOf3JULTgNxlN0XVk5RaMp+mJJzGXW3mniO9roG70YoU5mRuIuYduR31HWd4K3VCHRqb0a/Y5K3ssJNG0UC0idXbLCmbd2VQfb032KfasIIURQ/HvA7NjsMUBX1eRcs590Am+NJhkyp0B+KGcuMUza0APUJkygiI4bErpeFIeTG96nYI78xUySOtz7e/P4XFxT22i74hULopEh/LZ2i
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(4143699003)(11063799006)(261009221227099003)(261009223027099003)(22082099003)(18002099003)(10067099003)(56012099006)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDRQQjcyUE03YytCRGxUVG9JSGl2b3g4bFlGZ2xJNzVsY1c3WVBqWlBJK3JS?=
 =?utf-8?B?bXkzUXptQ2FCSVBpWlBvUlpheERQZnQ1Y1AwU0xVdCt0R1Y1M05ZWkR2K1d1?=
 =?utf-8?B?THVGNm9Sa3k5Ui9HeHRnMTZsNXBxRUJtVzFIM2RHUjZ1VENTaHNTYXYxQU5t?=
 =?utf-8?B?akJidkdyRGFvaGVyditjS2lnLzZzWkxHRUphbHB5NGNSWnNUelYzMFZEWVNn?=
 =?utf-8?B?bFlFU2pIQ1BCS2JXUDA1ZldKaDh1V0RBOUJHVStTcmo4MmtMbVFtL1JDOXE1?=
 =?utf-8?B?L1lhY3JCWDZ5SXp1QzNwdjRHVFJoWmxrY0JVc2ljb2pTQlhhTWl6aGZMSVQz?=
 =?utf-8?B?Z3E3T1pWSWR4MXpHRDR5VVBrM2U2SDlhSy9ST2E3VHlRVytlV3c4TzFIaWhv?=
 =?utf-8?B?UHpqYXRJMkNxUWVXbmozM0tTYkVLSWhqVWw5YmFwQnRFWTBTcXdjMm5JbnJQ?=
 =?utf-8?B?SVVlMktTeWlnZkVLKzhXWDRmWmQ1a0xUeEhjeU8yOU53Mk00bXdFMDJjK1dn?=
 =?utf-8?B?ejZ5YVVYZlRTVThMU2RVK3RtOHV4MkdJbzBycm5vdnlBOWZCN0lEem52TkNo?=
 =?utf-8?B?MGhUNjhTZytFK041UHdtdGpzVTJSdlkwZllpMmdmdXlxZ3VGNXhnWFYyZkxo?=
 =?utf-8?B?d0xqaVp2b2MvNkh4cDRkSFQxSnUwemF4UDExNkx3MDQybUw0TTZ0SmRLdC9J?=
 =?utf-8?B?T29wbGRiZm1lL2xldXRmUlN2ZjFlaTdMelhVQllqU0pCSnFGdnFZR21XL1hE?=
 =?utf-8?B?RjNDMUJQYjBKa1ZuWVdlaDNDU2RFelBWL3V3WjhiM3pLZmNsTFVjaGJoV2Z0?=
 =?utf-8?B?WHZZemx4SkZ3MUg2ZDdFdzdiOVVCaG05OVo0NFRCa1FCN2tqTGJZRHR3RWRJ?=
 =?utf-8?B?aTlwSzMvNTljNkdmb1JmYXQ4K3huVlNJbTdCcERMczBCMTNCcWJsRXpnN1U1?=
 =?utf-8?B?UUViLzZVMkQxZ2VQa0NFejQvYXA0Z0xnTUo2QVZXYnp3bkxDR3pOM09jUTFt?=
 =?utf-8?B?bXVFOEJSVTVVWS9WbVFvQjZySjR0NFFVTFhIUlByZ2V6SUFuUFRPNmdlNmx1?=
 =?utf-8?B?VzNzS2IxYVEyc0JzcVZ6U09vRlpyeGRGQWt4NVJ4K0J5bWtLVW8vTUdsZk1q?=
 =?utf-8?B?K0x1QURSK1ZlODBQYVEzV3krRWF0d0FGZENaY3BIeG5QN2lXeEVjcWVtTjA4?=
 =?utf-8?B?c0hONkRXNEpiUmd1WkU5amRsNko4MkViRUFUd2JZOVpHMzlKU1RER0drc2pD?=
 =?utf-8?B?eldOWmpTeXRGaS9TTituNkpmSUREUU5ianFqVnFwTWNGdjlCckE3V1JYYnpP?=
 =?utf-8?B?VkdhSjVqajJYZnNBaHVsbTEzYmxlOGVES1NNTzRraWdtRWZTeWgzbjh1azlo?=
 =?utf-8?B?UnJ3TlpFQmh6Yk9RaTFCSmcyQjlCeStrb21mTEIwRmtZVHRyZ3d5alVqMElF?=
 =?utf-8?B?TEtSbUtzQzNzdk9OSHRLeHlNYXVYZmkxV3N1Wnhkc1BNTU5vVFJnSVlLMU9p?=
 =?utf-8?B?cHBDbk5pQlVZYVVxRmRoaFI4VUlzQTUzUGVxdlJGeWFCNGdBbHFVUFNYVVZF?=
 =?utf-8?B?WWRlRUlubFlMWmZPWEIyT3c1QzZDUzlPWUhES2p5aXZPak14VHNQTmgxdy9i?=
 =?utf-8?B?RDdaV0pmSVowUExpb1Z6dTJrM3RZN0dxdXB0TUljMGFpTzJBL3FuamR1c3Ez?=
 =?utf-8?B?ZHFMcTNBUXJXRFRwTVFhREIxSGFyY1hRTmZrcE1RVVNrQksyT0o4LzllcEtY?=
 =?utf-8?B?NlJVcWZaQmVzaGtHOFRvWGp4cVVjV05Db0Y2RTRVRHZxbEtFa1BoVEFDQTlr?=
 =?utf-8?B?SnpHSGx4RDV0c0s0ZUlSVGRkTkV6SkJoa2lXWmU5di9DeFN6TUxnREZhOERY?=
 =?utf-8?B?ZER0UHpwNDhHVXRxaE55QU5hUFZVV2ZURGpvV2xvblhseE42djNwdzVUdUZp?=
 =?utf-8?B?Q2E5UDNsS2lSUmE2dzhVajhSL05sQWZwYnhhY3loNzdCSFptM1N0Q1c5RjJ4?=
 =?utf-8?B?dXVzNzlaNmJtUm9wRWtDbnFRdmNIaGdDK3hKRWZ1ejdrSkxVcjF1eU4rQ1VI?=
 =?utf-8?B?Vnh2NVlBVUFXSHBUZDJheVgyMmZrWEZVSXd1dXFpbnQzUUw2YUE3Z2VWdG9h?=
 =?utf-8?B?RzJ4RW9tNFV0anFvdVNWQWhUZW5Oem1NeDF5elUzelpid2o5emVidDNOL05u?=
 =?utf-8?B?NEw1YXRvVVUyZ1c3L0dad1VOd2lhTkxMaDF4VFRTTGlIeTNpUE5WTUtuODF1?=
 =?utf-8?B?V2g2S0w1MEVVelpCWkY3cFZrWllpZ1dtYmhUZkZTUVpIQitoTGVLRm4xVU8r?=
 =?utf-8?Q?kTpKhoQgTPBhc8pKkc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f9d348-1ce5-4cbe-61f9-08df4c3d21ea
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 04:15:55.7404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vvuT1BmLQktOd4BS+jEXCxZj1gJwS1hStcdMVEqaxkEwhaHuxvi7yVvoC/wlVbyYddBT9VK7K/2xJ4BGJ7nyAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PPF539334D8E



On 11/25/2026 1:33 PM, Qihang wrote:
> Thanks, Vasant. Patches 11 and 12 cover the teardown paths I was
> missing.
> 
> One question on patch 12: when the completion wait in dev_update_dte()
> returns, can a PPR accepted under the old DTE still appear in the log
> after the drain has observed it empty?

I am calling the drain after dte update happens. So if anything in pending in
buffer , it will be cleared. I will post v2 soon. Please take a look.

If anything is pending, I can sort it out in the followup series that I am
preparing.

-Vasant


> 
> Happy to pick this up when you post the follow-up series.
> 
> On Tue, Nov 24, 2026 at 4:53 PM Vasant Hegde <vasant.hegde@amd.com> wrote:
>>
>> On 11/22/2026 1:09 PM, Baolu Lu wrote:
>>> On 11/21/2026 10:13 AM, Qihang wrote:
>>>> Hi Baolu,
>>>>
>>>> Thanks for confirming the VT-d ordering bug. I'll keep this series
>>>> withdrawn and won't resend it.
>>>>
>>>> I still have one question about AMD. detach_device() calls
>>>> iopf_queue_flush_dev() just before amd_iommu_iopf_remove_device().
>>>> That flush only waits on the iopf workqueue, while the PPR IRQ thread
>>>> runs amd_iommu_poll_ppr_log() and reports the fault through
>>>> iommu_report_device_fault() directly. What ensures that the thread has
>>>> finished reporting faults for this device, and cannot report another
>>>> one, before the device is removed from the IOPF queue?
>>>
>>> + Vasant
>>
>> Yes. Its a bug in AMD driver. In fact we have bunch of issues in AMD driver.
>>
>> Below series fixes some of them.
>>
>> https://lore.kernel.org/linux-iommu/20261105044801.399466-1-vasant.hegde@amd.com/
>>
>> I have another series which handles draining. I will post it once above series
>> settles.
>>
>> -Vasant
>>

