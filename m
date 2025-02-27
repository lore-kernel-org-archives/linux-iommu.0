Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E281DE2B3
	for <iommu@lists.linux.dev>; Thu, 27 Feb 2025 16:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740672253; cv=fail; b=k/pswwVuLJbSlpAAd1vaAFE82DciXjRCjBlCmUvpo1OLWJi6kmM09hJsk11+Si+aIfQrkTbKUkXYzi7tFaGOoZBAtz431XsKwCXloPD4B2xYR5Q2bz+nex3zOOMk0XrLZsRJcCIg+I0Ypq6kDmHJtC65ZR2C6VMW4oo0SZgmWm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740672253; c=relaxed/simple;
	bh=qXUV2ALBHu2eWiVno4v1x+TqlKlfNyYm/9MNy0o78K4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QJIpXHwZtNkgO1aszWGT7knjENPvORTi4oq97QjyADTiPs3Hn1LEVmp7XVJ9fdEoZ5UKBcXn5t3PbNKbCHeGjUQbDIEZZFnOFUCNUGy7cdSAuTCX+qpJVuCweMyhhJDnUpoaXZ3OMCsgJc6IAGdyRwgxcWBQqNPssT5BGWGE0HA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=odcr6d0S; arc=fail smtp.client-ip=40.107.237.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="odcr6d0S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eqr4Yigra/dczepf6KiRSRLC+02F9G1YNwbBh4nhBM4nYsHIX6ZAAj10Xo1iyUSz0aa4zOjCXY6PM1fE+JQDMW8WjgqOa+tk271/C+SjAiioLiybNXsNLBZLrbV677s5RLobTP8bsUOorhiEykT+CjWLqPVYM/CvHmdYKD+J0umMEBfA5RCwAT6V+ZUA22rPg2jJEWuP2x09bhDwHfD+JlZfDitWxTI3fhUTCHdRW/3wkSoAuX+ul2vIirCX9MIkl7Nekd1FvbMFTk0B00OJkINo8TXSDSkMsxZxPLy9njZrRRCgIywxcZd8WxB0GVOqA1/rWyia9HIEMnbewOjShw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XO9YegCPOkcFgioLhA05ktTGLvJL0C44Upoy/TrawGQ=;
 b=ANOHxtgw7mKReGV+tJCjGU642xWJBslPb1AkCHX0t5lg0SeaafNs2xigKY76JCx40Q8nXIZPX7YhfFe5VN8b6cQMn8YVif5Hsr5iblIfJNVaFd4KqqI+8cs+UDgNgJhf7TUpM6MPnEO19cYh3EnQQGjKnAZFv/NI9ABwE7rdyyQ34L4V1TXIbzD3C5T8/9zQSK+91w/c2vxkWolFOA/23OLDuJsPJnOkvpDWdt6wFQcSyMFl4Ie9gSGhPQU9V74/llNTscLO1HamXBv7vBHqJ5MFBdzuPkyymQ+ErrURjbASPkeO1Tnm07rr/pZHQXiRCk9+F4LWT+jnFudtFxnMgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XO9YegCPOkcFgioLhA05ktTGLvJL0C44Upoy/TrawGQ=;
 b=odcr6d0SvYnjhnEXwWGEdrPT3iQP0RzcCTS1KPyF5Pi2x9JvNwphyOswBKjSTxEAcdAOuXcoyXt0jrxSCHz1ILR7BfnEBjX39ymAERf8TOPQh6yiixW1SjH/sUanbHf1yt1raMikwzOZ+r8RBVm5mNCvdB0UEEVWd4EthcutsDg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CH3PR12MB8533.namprd12.prod.outlook.com (2603:10b6:610:159::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 27 Feb
 2025 16:04:08 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%6]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 16:04:08 +0000
Message-ID: <cc4cf4ae-2d29-4747-b655-df841661b82a@amd.com>
Date: Thu, 27 Feb 2025 21:34:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Add Secure ATS support
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Robin Murphy <robin.murphy@arm.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>
References: <20250225105829.52223-1-vasant.hegde@amd.com>
 <be9d2ad2-0f9e-4d06-952b-4cfd6ae53447@intel.com>
 <ce86ff90-377e-49fe-9c4e-d2ad7abeeec8@arm.com>
 <20250225145518.GJ545008@ziepe.ca>
 <b630b6c0-a25c-4230-8abd-a48b7dc27216@amd.com>
 <BN9PR11MB5276B090C61D1F059538AF7B8CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <BN9PR11MB5276B090C61D1F059538AF7B8CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0094.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::34) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CH3PR12MB8533:EE_
X-MS-Office365-Filtering-Correlation-Id: f8b40c6a-2857-4598-a322-08dd57485dcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWU2eks5VVVqM01yWTFpeUsrUkEvWFBEYU5oekdSZ1Z6Z1M2SWZuQktjMzZD?=
 =?utf-8?B?ZVd2NmxBS2NDSjJEMTFZaEF2aUgxblVWSmFxTEVybUZsMytiWUljZlkzZlZI?=
 =?utf-8?B?aW5jakJ1bS95Z1B3cWlMdTZYWDEwN3hKSXJBZjRTYXpXblA1SVh5ZDIwR2VR?=
 =?utf-8?B?UmV5VnF3MVR4azVsaFkyWjBZMDZiNEZmQUFmbzlYd2ZkSHpQVzQ1NXdXTTU0?=
 =?utf-8?B?VW1IRnZxdGRPbjhad2lPT1hpb05rbFV2TkJDQVBsYjVYNkZWdzJDV0ZUNERi?=
 =?utf-8?B?QVQxOUtxb0xFZDM2QkhPVFZ3NExtUjVxQlYwYTYyZ2ZaK2V6SWoyVjNuY2Ni?=
 =?utf-8?B?b1M1QU5pZWdaOGxYYnRrWW1pSzMwcmhuaUcveEZoc1ljaGdqQmhEMEVXRUJn?=
 =?utf-8?B?aDBUeWRXK1FQcGhmSEt5NlNidHp2c2duWDdoREhwODVHam4zMHFReTdONC9u?=
 =?utf-8?B?N2FmVlBQYlV6WTBHSlBuYmk1MlI5a2xQR2JYQTJaVnZIbGk5bWkvZ0FSN1hV?=
 =?utf-8?B?bWUxc3BOZzdjN3l0K3hFaFZLZ004aUpyOGRxWjFzTVhVUXFZOEw3UFVjMmg2?=
 =?utf-8?B?NzJ4ZmlVellxMXpnTE9hTnN3VWlFZWRVNEpsUGJsTXdqM1B0OW5ubzBpMzdI?=
 =?utf-8?B?MWFJbHZ4ZVRkeElzLzRUaFVPMVhaMkpUbzB2cEhObHFub3hLQUtYN0RITnBS?=
 =?utf-8?B?TE9GY3hLdnJIa3BHUXFLZnY5dFZNNXFFTW5RT0dvYTBUdTZSKzdMbUsrcEZn?=
 =?utf-8?B?UlZpdTRsMGt5WkpIUUVyWGJCbnhOYmpLN3l4VWdGVHh0VnF6MG51aVJ0M1dP?=
 =?utf-8?B?UHlnRkZPMUNNdkl5L1U2R2NyRFJoa1U3OGk4ZzIwYjJCSERsaWtMVkgwMitJ?=
 =?utf-8?B?NCszN1lZeCtqclZwZ0pKcmk5SFVXU25RQmRQUDFzL3NnWllkYkZ3d2NseFVn?=
 =?utf-8?B?MlVUTzRNcnQ4cjNXWG5lUXZRa3NQS1FwZ3Q5MHcyNDdVRVJSSFM3VmF5OTFX?=
 =?utf-8?B?VlMwSmNFSDdKdmhaL1VucE9kdjUwM001cVg2bk10VUx0VnFTZGRuS2tXREor?=
 =?utf-8?B?S0YvZnIzYmN2MnRpVUFlUjRHMlo3YXQ1L3d1S3c3SHdIeWYvcjIvdjZLRkxy?=
 =?utf-8?B?dmxRai9mcjJlWG0zRVhjYVBYMlZHUkpkUE9qZmpiWU8yd256WnQwRTVicEVt?=
 =?utf-8?B?SjN3eW1sbUw4OTh0L0pGcTZORHI0Ujh4VjJyeEZhcGRIdkl6YzlTWUFURUZ6?=
 =?utf-8?B?eFg5OVdUMzdnY2ZSOU93Qll2RGl4aXV2U2w1RklUTmkrZzRqV3AvaWlPQWQr?=
 =?utf-8?B?ZXNIeXlhUkxjTm8vbVBteXU2RkttV0lRRHhhdyswL1Z3TnVCZHdwM0NhQlcz?=
 =?utf-8?B?QWt5dDROT1h1dTZIUHpnM3Vlb2c0Mm9OcjZWK1hoQzZBTHQrWjlQa214NlpQ?=
 =?utf-8?B?SndqYU4rRmZ5VXZwSnBxeWQyZnZPQVp6cU40c2kvVjJ5M3k3SXNuSWhOTXZO?=
 =?utf-8?B?b3I3alVkTVhSV09NUDlOU0dEeVI3RU1wa1JSSis4ZGZlMnZpRGFUdzJXMGt3?=
 =?utf-8?B?NW0xTENNaTlCSmdHVGI4dlJQdm13enZTMUE3YVZPOWtuMVBkVFpaZWdxKzhQ?=
 =?utf-8?B?R2d6TjNvdld4QUhCYWJpM2JqU1VBY0R6VEF4YjRpSGpXWFljcFRVaTJFZWx4?=
 =?utf-8?B?K2xDSFQ3Q0plS0oyQVBWQnM0ZzR1dG5EamFsb3RROWtFSTNzNnhzVjZtdFBl?=
 =?utf-8?B?MHcyQVlVWTR1bVE3aTVLRGNBbzI1QzJXRXJ1OVVnYlFzSmZ2RjA0bGZEbUl3?=
 =?utf-8?B?MEVJQ3JPVWJsNk56QmhidDIrdmt5aGZxVlRQQ215OGRTWHNBVEpmcTZCd3dI?=
 =?utf-8?Q?wvHp2gBPYRH2b?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDloaHRMRDRoME9ITWlWYWU4OTk0ZC9MeDhvdk4xZ241T0JSRytjMG40WjNq?=
 =?utf-8?B?aTVoOE0rdVNlajgvTVpCVUxCdkg3ZjBiZ2tZbnkvWnpnSFpPVFFmOWxacFBL?=
 =?utf-8?B?NUc2MmREdkdvRjZpcmdSeGdSNkIyaHFLcGdaQlhHYWJFWkhiU3RtTUgyT3Zt?=
 =?utf-8?B?QmtZOU9LVXdIVm52ckd1ak9BbzVFZzFGQndYczc1YURrUVpLZ3RFSWlaM2sz?=
 =?utf-8?B?Q2JOVE45d1VUQzErNzh1NWFwdTFZYU5rNHhtQm5rZmYwYzlNZVRpeGRjSWNY?=
 =?utf-8?B?dW5OSHJ1bFltbFRRRGFCYTYvOHBhSVJJcDRPbUdNc1h1N2kwdGp6Tmorditp?=
 =?utf-8?B?ZVZWdE5sNENiem1TaFkxNEljb2RWOUx4SzZucE1ybUQ3dHh4ZW01bXFOcmRE?=
 =?utf-8?B?MytYbGpKUnYxcHRmVm5QT0JnT0tSbFZsZ2NDZXE3QVpTeER0TDdNMGpWNlJr?=
 =?utf-8?B?djBHSHlhSHFtTEJla3hyREdqa2ZGVkpybGc4S1JnUk1ZK3d5YkpaZXdtRFVo?=
 =?utf-8?B?UWdYc2p2T1FsWE5Ic3lBem1BcWF3K1lUeFJXSHhPUFZlbHVxa0hxSW1hNkx4?=
 =?utf-8?B?dmUxYlpRN2lsZmszNzRQODhLMlpQOWNaVmRzVmYvS0RHRWduUFA2WUdmd3I3?=
 =?utf-8?B?TGZ2TlNZT3drdXpzUWdDRFAxSE9BTGQ5T2FzM2l2cTRzMzA0VERZWGlHV2ZL?=
 =?utf-8?B?MERqMFQ3ZVBzNWlicW4xcVF6YXlQV3lRU2JZWW96NmdET0NvVkdNbTlYTGJR?=
 =?utf-8?B?QTMvYTRyZmNGa2diZlovaGZPT1Y2NTBwYVluMGxZRnkzbHdMV3piWTNXNHVL?=
 =?utf-8?B?Tlk4QmxrNEloSUQyOVVXbE0yVUtHcCtxUUZWb2x1Tmp5ZU9HRmFxQSt0TFM3?=
 =?utf-8?B?M0crN05ZK3BSMTRPd0svVDIyMXVEN2s4bW4xU2twbGl5OFJUWDhJN3VkUmFh?=
 =?utf-8?B?YWI0MXpMb0VmWmN4ZWFtWlNIZEJlS0ZQaVVDTEZCWldlbHcvTVBxaDhUZGty?=
 =?utf-8?B?TGI4WE5DSGR1RU8rN0UxL3paejhaelJEbytJejBuOHpDRUJ0NEd3VTVsRGp1?=
 =?utf-8?B?YzdPZjJzU0x2TVFlSmVoUlBVL1pCQStWK2Y5U2hBVTVLZ2cxaUtTb2dhQTky?=
 =?utf-8?B?SW1pZko3SXBlSHZwWG9ac2d1cEpyaFdwNVdYemRkcUE2RndWNTl5aXpsaklT?=
 =?utf-8?B?SHkwQ21uOXFsZWI5WXJGWWNEeUZTTjJXbkZyejBQU0xIbGNQQTJZTGlCbHZC?=
 =?utf-8?B?L0ZlZjZGdkFWbnBCWEVLazkzVGVlV1RHMTZXOHNNQUorc2tSeTJLaVBYazg4?=
 =?utf-8?B?NVNuWDJmTVM0YTgvMjZ3YUlmRnRDejEwOXYrTUhGWTdBbThUdmQ5cjQ4U2JM?=
 =?utf-8?B?YWZ0c3NsOHFyeGcrZVlqVmJDV2J0U1BzTzlWWjJTU3A4eHBvWjVlWFM5TnY0?=
 =?utf-8?B?WnF4dkFJMGZHaUhhcGFDN05ya08vaUpnZHp3YWpIS3hsbG9CTkVld0dqREZo?=
 =?utf-8?B?US9VYWRlUEdva3FiamE3NjdXLzNBSGxtcVdFbHc1K0pMbmwvMm4rN3hjRkU0?=
 =?utf-8?B?bFVSOXZhVWZsQmV6RDBiNWZ2dzUzR2pSNm03SGRwY296Y3F5bml0eUo3cGFL?=
 =?utf-8?B?S1FneVEvUDAyRWJWc2pDQ2VBL1drVzRMdlQvWjNyaFhtaXEvQitFUVh2NFpp?=
 =?utf-8?B?eE1maDk1ZXl0SWNkMnVhR2pCajRlRWp5M2g2QnJiN2hLdWt1L1Q3WFRsUjJy?=
 =?utf-8?B?M3RnVG9LZHRJQnRTTCtNTzNGYys1TDJ1YWNCKzMrbElYV3BwQmQ4QWNxaytl?=
 =?utf-8?B?U2swZlZTeVpMeHNJZjNiL3hGbmVYRERENVlGQ0tUSW0yKytZZHMxdWVnSW5I?=
 =?utf-8?B?R0lhdytjNnZlRzlQR2dNeGhSYXg4ZFM2NjZoQi9hNkoxK1EzVmdROS8xWGZZ?=
 =?utf-8?B?ZFExMVF4c0dsZVE5WVBBdjZCYWc3UnVRQzQzT3hobTJPdnI0d1BwOVJuWFdI?=
 =?utf-8?B?UUZOY1I5M1RGNFFBM1QwMTZnRFZPYlVTbmV2bUVERVpSL2Q5VWYyZHVxUHp6?=
 =?utf-8?B?Q1d6TGlod0tNN0FVNWF3a1pjcHc5SW51TVptaFNwa1lMYUdFRXFKc0kzdWNs?=
 =?utf-8?Q?XmOKUUUCG6Eb0xy4kz5UYOZsz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8b40c6a-2857-4598-a322-08dd57485dcf
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 16:04:08.3083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fPX3H8SaYlzJIfWImLFLtl5JcRWu5+lSoZUtcGiPycGdEwgVIilN5YPZHDR8pyQEcbQ17/GUjDkLvu+vTtcXmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8533

Kevin, Jason,

On 2/26/2025 12:40 PM, Tian, Kevin wrote:
>> From: Vasant Hegde <vasant.hegde@amd.com>
>> Sent: Wednesday, February 26, 2025 12:47 PM
>>
>>>
>>>  3) TA is an IOVA and the IOMMU runs it through the full translation
>>>     to validate it. ATS is just used to signal non-present
>>
>> Yes. AMD does this when Host page table is configured.
> 
> Here 'signal non-present' implies to support PRI.
> 
> But...
> 
>>
>> We need to consider various scenarios. For AMD:
>>   - Currently on baremetal, we cannot enable SVA and Secure ATS
> 
> ... here it says SVA/SATS are incompatible. Any more background?

Sorry. I should have explained it better.

To support SVA (PASID/PRI), we have to configure domain with AMD Guest (v2) Page
table and host page table will not be set (DTE[Mode]=0).

  GVA -> GPA contains translation and GPA = SPA.

On ATS request it will send GPA back to device (which is actually a SPA). We can
support secure ATS, but ATS response will contain the SPA.

-Vasant

