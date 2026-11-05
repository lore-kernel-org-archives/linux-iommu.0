Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793897005;
	b=a6DfAgDC/6GD4/FqH1jIYJuysylu2o9GVkRsLrZiOrxoLiegYDHiDy2ie32+qksibo20
	 pI87Zk35kZVpDN5nDzm6zjSlk4SECfecgOPGYhttmVpkplCDoaSEQO+qy9gUAhlA//aS4
	 mpl7UkOOwEnu44l1fZ+zbZwY9Q5pdPvvFzQ8ADJvAFrm/n5cns9DglUxDVdzfUhOTNe9g
	 I9w5BdDZyuoIWDfgn6NbZ1/j1BAYUy3cZCPX0Ojh/meSAI60Ksd3Dwc/x9KoGY9wdTkkM
	 /HwmS31wljT8gg1/NAocltahHB1b9TQhOeYCiVuG9LyO2Ol+QuGrt600+4MhyXqnQRw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793897005;
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
	bh=7wTw+CiFDE24NsBm6rSxTVIyG6XQvHdqqI7iSnCm1K4=;
	b=3YwcRCo+yxCywNX5SO/+ZBZN1VCMouptOkh263mXjqnJR5QUFvL3lLPD6leTGu6yDfLY
	 6XdfyhswTnZpd8XRDjO32wNfxm96A2ibvNwMyJURLfvmSrr+yMpxDnsmvIFY91L8t+43e
	 MwJb/6IP9cVuBe1w83zJdbv98nhBmmcGt+CHWl2pBNnsddJ51MFuy8KNPLW5yMhbN1yIp
	 DnF6q6KlJ+OFUyqGMsbdFMu9n67nQX5yg/QJYVmovIWfyKyFRLAXi6NO4X0lppqBnmqzb
	 IAVw2CCPOmUUkdE4PhQ6BhH9uVreNmxR5eW9Whw0uBGsy2Mlh2pHLeeI9jXna1eDUPg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=sw6FOdJX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.34
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013034.outbound.protection.outlook.com [40.107.201.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C48606A90D
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 16:43:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55C48606A90D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=sw6FOdJX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E0+DOA9pJAWZXEps9v1yyHJSsvxdGI/LLYQ+MtcuMhcfJJU+Pq/Z66zYgaPE4gWoEoWe9Sb6ZjrHBz/sZsbPNbCjA/SoMZ1YanbrdZuClPbfd+BsLk4NXR0An8FZ3TPu8kbqvryJ74IuZDlN+C/17ZBj5bWkeEjcblTfz9m/5Aj7fCOVyG0/FxiO/BAt/Ti0xnNvVKLbt//+D1xLPHx8Ha/LXPyn6DgoBxt2fsu+QGvqPMwdH9TkEeHGt1MHQj+0t0sdOMb3SH/Dm8L8OPpSfWQE9pscuS/8HAvvnedIJRqPaCfWsrT/Xu2tp+VaA0yW+pmftE31zxDVpVCavN5NHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wTw+CiFDE24NsBm6rSxTVIyG6XQvHdqqI7iSnCm1K4=;
 b=PycGpfLs0nn1tt3TjcJFFPdflGlDbOOCsmjK8aVI0V2FmxgzpZYOw2l95WpyCZG9eX57s3W1qQ0Zh5HSKRoBf3jiyz2MiFrCpTUD+ExGI6p+n/z64ZX161G1hRqowXOdDN4KPlRQvmiIfEYtw8p06oGe2Q0CHTQArHAkRqnmu0vN8tYwekRQ4ifPtGlL37SHP1um8OalIrxs7rNTX5hPDi2tPiDw1SupIpSVBneIJC901sXklm4dv4tqoIe379nF6x0JGC61RgIC9LKHa/QyKOkMxpa6ECJ485xVcQDww2PcdiHx4bys62DyGo7txYxXMBVg41fBWW8SlA2Gigvqpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wTw+CiFDE24NsBm6rSxTVIyG6XQvHdqqI7iSnCm1K4=;
 b=sw6FOdJXEAa5+Ovpa+45LeYLa9+EVECWfA7G3MfTxWtYfayFKmwS678CdZd6/igA9RZhGu9/3XeDEVEUM1L5hhYen2HIkFnUxcatqQjOvq14fZt7fUBSg9XHSNlOv35dEJy6lFHhOj45IQY/GDcJwYoL8exGbXF6tqc4owGL5/U=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by CY8PR12MB8409.namprd12.prod.outlook.com (2603:10b6:930:7f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 16:43:19 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 16:43:18 +0000
Message-ID: <f38a27e0-9327-4e4e-bb64-84c7386af46e@amd.com>
Date: Thu, 5 Nov 2026 22:13:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Remove iommu_group_mutex_assert() from
 amd_iommu_clear_gcr3()
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
 Max Zhen <max.zhen@amd.com>, Liang Wendy <Wendy.Liang@amd.com>
References: <20260814104029.71021-1-vasant.hegde@amd.com>
 <20260817135155.GB1415075@ziepe.ca>
 <d5e053c4-34d4-417e-ade5-f7f461f9e426@amd.com>
 <20261027182407.GH1685504@ziepe.ca>
 <63ac9043-0658-4535-b42d-0e29eb37ac88@amd.com>
 <76242acf-e8c3-4c44-9558-2751112fc5dd@amd.com>
 <20261028121701.GM1685504@ziepe.ca>
 <a9d4b05f-4935-4c25-9029-2b572a31c314@amd.com>
 <20261028151036.GN1685504@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20261028151036.GN1685504@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0107.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::15) To BL4PR12MB9505.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|CY8PR12MB8409:EE_
X-MS-Office365-Filtering-Correlation-Id: 72326400-ce80-42fa-e6cb-08df3b5be514
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|261026121527099003|11063799006|4143699003|56012099006|261022075727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	TDEHdXSklePaHJM7xjFYTQeFwgJ9AtY351MeyfO4O+BUFKk98OryTOX5nDiG5Ydz2t5oSXHXZVIXN8q54UY/CrxgjKrzvLdz20Zljhe0A7EE+PSXWcUXDbyv0Oi1iC6xQIszGi4Kdg5UyBeh4ZVc6BO7fP1WOjd11C3yvOrnn4zLCTFdy6HYI+EaCVX5yOnOiiqP1wkOPrlirm/nSyWZEG3szm05q0M6Yk5FkPuaRNf+iZJeNFoq6Js2Me8SQwnD+2H5+qzpoy8qYQLSbC1sVNnKHjKMPMgAq4TI7laMcI+k2sLAmNPNqkhkf2jygLYPgOPL7FvH5nbAIIAv2FszuTUnBPGyjAP4MUe+sNLCG04uRr+YJZmBaKTpuLtMxHZ13h7XI7HtDi/YQb3qsS8onaPALo3PJ9PeW/7T4UQAtTxgA5vVs2ePjQzi87arPKcJIPr52MgPVWZsodH3T4GXPYH4106+bpIcoox01hiT11NAGCaZChIEch41ciYLbk9mVJGL+PcxDODgP3RaQL8Sd+UDx511oiGR309v3USOv2K2pD1yadXSzF1ln6g5iEH5M8BfnOYNw4oPkWTwotQHZvR/TPEMYw1Dt/jATgzl12jcdgLneU/IPsWl7sKpJEG3j2f7k/aA2qtFWIntB3NG/ycdFx2c33D2BQEc7AOddUw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(261026121527099003)(11063799006)(4143699003)(56012099006)(261022075727099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGFpOVgweGhrTlA4VnJmWFRteWJuOWdJT0U5WEx5Yzg2QzJRY3Uya2h4ZTVr?=
 =?utf-8?B?S0dkODF5N3VBd21WMGxsemVJZStGSjBveUY0ZUZyUVFGa1ptbkd1SmdDSWM2?=
 =?utf-8?B?N1NzOWxTcmtyc2tCV29FS2cyRElaM3ZQR2lpNkI5ZEJra09ZcE5STjdHWGFU?=
 =?utf-8?B?Z1I0Sys1UHVRTzZadHBwY0lMU2xDd3FRVHU2NTRCdUd6WDlzc044bDZPMTJ1?=
 =?utf-8?B?UjNGR0VIRWo5dVM5TVRGLzJqb0QzN3UvekM3Y3paNmtiZ05ya3hZNzE5dHNC?=
 =?utf-8?B?bHBXR3pIQnBGU0RnaVNubVAzN3JsMGJJVTdMcU9GZUliY3JYMEhaNzFiOGQ0?=
 =?utf-8?B?bmpJeVZsWFVJb2l3UC9BVEpPei9HRkM3M3FPTzVxaVN4Ty90VmdOQUdxbTBI?=
 =?utf-8?B?eE8zY00rbmx3cXlJVXVGRXBGOWhBcVZFWGZwSkltaVlhSXdtZUduSEkwQThM?=
 =?utf-8?B?TjRqY28wWXdtV3ZRMkpNaWs0VVVibDdtMzUvVjBmbW9CSGY2MU1uL2FJV0Q0?=
 =?utf-8?B?Q3lNWjdXWHV1MytvWGtJSzNPWFBXZmpUTHViRDlrY1F1ZCtjaUltV0hURCtN?=
 =?utf-8?B?T0JHenBMaFFCUWVRNjdVU3hVT3NQcW5FYlYyRHQ0akVFVDA2c1AvYytLSkpM?=
 =?utf-8?B?TFV2Z2N3WllUdWJUV1lueGJVckVEdVZ3WXo4ZHNxZDgvbXVxZlFEQ3h5ek9T?=
 =?utf-8?B?bGhsT3FOakNCRWc4LzJWcEI3eE5UWDl0Smhxc3Y5NTlVMmJtckk4MXNKV1hk?=
 =?utf-8?B?cW5xUUFxcTdVRzNWZk1uelZYcmlYOEdGNS85VWFKTzNpR0hseUh2eHphSmZ5?=
 =?utf-8?B?K0xURm8xNHQ0YUdLTFhuRHRXelFZLzhrYTNuRUszM2VOOFhpcVBiOFEzZDlP?=
 =?utf-8?B?UEU4MW9YR2x4aU94VGhzWW5HbGJnVWQycXZhNWFZUTFjNFlMa2d5dnAwZ3FC?=
 =?utf-8?B?ZTB1WE1ha1lndTNoN29yWE94cTRzdGtwMVpyVzhOVUU2cnJlMmRIMTA0dVlv?=
 =?utf-8?B?Y1EzZCtDNmNaSE9iQnZvMHY2TzFYeGxTVXFOeHptM05CSHdDUllDVGJYaEww?=
 =?utf-8?B?T3Y2ekY4Ky9wK3ppVlRyWWxsVFVCdHZYTXhFY1JZYjkySGxPMmpGVVVKRGJi?=
 =?utf-8?B?RHBPanN5Tjc0ejdHT2xEUmFFcXkwTlF5cFNKMVp6TFg4SFBSYnVVMktTakIy?=
 =?utf-8?B?UHdPZCtzeWQxWFlqK3E4YVk0N281VnNId2dMQ0xwamxPdnl1d2lVQXV3aXgz?=
 =?utf-8?B?YWF4bTNTR2tBRUZSc3QwdzVHak5VK0syRDlCU2JhcUtvbHkyWC9CQkdkeVhD?=
 =?utf-8?B?ZVNZWk84QWdJZDlTWi9ObmZSMnhWQXhBVEQwMFl6MTJURlFDVG5GZWtld0tV?=
 =?utf-8?B?NCtvUGFKMU1Nd2kwZ05mbVVjMVpqZXVibWJreVZvRDFJbFRNNzF4ZW40ZFFq?=
 =?utf-8?B?MnhldGpJKzhPM0RudmpWRXFDRldBdFZ3eTFwU24wOTdvVDNIZzFSUE44N1VK?=
 =?utf-8?B?dWpiRFlRZmxCYkZ3N0FJUUxqYm9MZmlSKzRNWG04OWdZbXIzeEs1MTJScE5x?=
 =?utf-8?B?UnhPYUhUQndyUVVaMlVUM0F2QXNMeGQyMXpBNldpcXlOWFNDd0NyUjFPNFpx?=
 =?utf-8?B?SVY0Rmhkc0FSY1dvY2JBMGRFSHplL3JXSXhxeGRjVG5ablB0L1FteWZCeVBD?=
 =?utf-8?B?VGFxbkZDQktjYzFXUW12TVN5SUIrczlOWlVHb0RWZENsbFJzUzdCbnVlMjVJ?=
 =?utf-8?B?a3NnSmNZSXZsaU1PUGJicWVmazVXVnF0TVZXaXlXdWxiNGRsUXlTdlMyamRC?=
 =?utf-8?B?S3NHWWRkMTl3dXRvSkFteml1ZEd6akdsaXlEV252TFdXR1RJMnZxc1NKTDRi?=
 =?utf-8?B?bzcwWTFKM1B0QmV5dnd5ZEdiS2VqYmZ5bWYwWUlTZG9OVVplcEdvb3dFaGlG?=
 =?utf-8?B?ZCtOdEoxTFJhRnBYMVlPblF1VmMveW5hakU4eWdmVFV0Y3Rzc1c2QVhKTG5N?=
 =?utf-8?B?ZldocWxKeHIvUXJFc0N0Z05iTWNobzV3cm85UVdjdlhPM2FjbXRWcHFMZVdZ?=
 =?utf-8?B?YXRibzRYVkNEekdZNTZxOWdGbVI0SVphU0wxUEg0TUFweWI0MHVKMkZmc0FG?=
 =?utf-8?B?RWJTR3crM1grWEZ4UTZkeXIxdGNxV3lBQzhIaHZPdjFnMFJNajYzc2ZzWHRa?=
 =?utf-8?B?eEN1cCtQN0h5bDFLK0pmcy92VjlQa1hhKzNBY3JkMGN3UE55RXF2dU8rbGdH?=
 =?utf-8?B?M0xjWktxbmlKZWlvTjI0U1FNT3FBQ2xZSllIZ1ZsWEFGR3F3WTdEaFhDeFUw?=
 =?utf-8?Q?OuhN47bqoa69KN9pUB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72326400-ce80-42fa-e6cb-08df3b5be514
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 16:43:18.4914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b0lyHmxLS+Z2/fjQXDm9ZVurpyEsf3aotV6T+sx/8pB6OY3pEKziAaDxN5YW5ZamOuQ97VeLHTppl7V3r2JbwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8409



On 10/28/2026 8:40 PM, Jason Gunthorpe wrote:
> On Wed, Oct 28, 2026 at 08:22:17PM +0530, Vasant Hegde wrote:
>>>> Actually we will hit IO_PAGE_FAULT if device tries to do the DMA. One way to
>>>> solve this is to have dummy page table. During sva_mn_release() will switch to
>>>> dummy page table instead of clearing GCR3[PASID] and then in
>>>> iommu_sva_unbind_device() path clear GCR3[PASID]. That way it will not produce
>>>> the IO_PAGE_FAULT. Does this makese sense?
>>>
>>> Yeah, ARM was going to do something like that too, but it turned out
>>> there were bits that disabled walking.
>>
>> Ok. Let me run some tests and see if we have dummy page table with Present=0,
>> whether we hit PRI fault or IO_PAGE_FAULT.
>>
>>> When this happens PRI is still enabled, so we need clean logless PRI
>>> not-present responses.
>>
>> if dummy page table doesn't work then should we skip clearing GCR3[PASID] in
>> mn_release path?
> 
> No, that would UAF things.
> 
> It has to work or SVA is broken already!

We did some experiment. Setting up dummy page table works fine. I will fix it in
v2.

-Vasant

