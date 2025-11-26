Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011026.outbound.protection.outlook.com [40.107.208.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C9E29D269
	for <iommu@lists.linux.dev>; Wed, 26 Nov 2025 08:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764145299; cv=fail; b=gj9fiq+tro0aeY71kK8W9TPXemwMe6jrngeR/8bH1mQcmkuZG3984YUrkmPzrEE+ybL/W88uZhxmEFw/1DnTZ/56Hs3DG9/VFbbIWSAY1n0IID4bnivWYeIS6lTVjkEkvAbcewQm4UkPSiDhFk2vZ3IuhOxLOQpkNNIHBMxp/DA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764145299; c=relaxed/simple;
	bh=wFRMPEQqkiJODKVJsxkb75mYT7zmcXMFj19PLQLMMfI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jo8OwwIdIKci4q85iwRzqKeXZoWxHQX1Djp8gmdAMM9CEbfXPymMTQEdtdkK7UGljUdhDWXKPR0yRsoqdi3i75rf3dNd5YHye8ZsvnWR+dPkWmit3OhuEhtWNxcl+sIJuB0cp/VLyokKtMUQukT3+sN+jQj3gxcm7dz2VujA8Ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zVMeptrj; arc=fail smtp.client-ip=40.107.208.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zVMeptrj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P1QzBkCO/IdNeVTF5X+vsAnJImkOZEuuIs/FcrJKaWBeAPv2R6Ql7Au7qif7fj3NsAG1SKHmSCjeuZVvqWMNqWYiVgL6+6uv3VdDe9AoXvUeBEiQJ6Yerfdbml+ij1zgX27WCtnVL3v4sT2q9jU94mEy8E3DJihEGNhmnQN87W1DNUQ+Gu3aLLYpSqtgb54dELmwHiZjFzhIPHNBe0EQkQ2+Foa+KFXEsnfVN9RZ+rzWEc0KtwtuQUjZ6Mmq3umTEM0+txHzLGgIc/qoKC8yLFyqJOshsXiNnqoO2xHotDcm3KFfb7KYiL1lCzD2iiadlojvMxoseHjNo0qahZkQxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8v45jl2XRhRFV+HE2MUiUPp3tstZBQL6dVuHHJi9AI=;
 b=x5F8ecZ1UFNSkJ0BhojcPfLERH0B++PupmG/2a0cnvG7Ew/ieFzL3BMskY1qhVE9/26SEerTrPKWOVzIfMDLPrxzFJZQ+TBKtLbf3MNSYPConSY3thNKrLI6xTktI4US25ffmhoaSt0om5UfR4YI6gyxmSIG5/cAR1HE4UfpEn98rwfJZzr3fXEUtCWdLPnv9+4eD2ny5PV9xbqGEViJACb87wxXVzVkJ5f0TvZvCknJoq08cqxIoyd3vS61wVpRvTozBrONRWTHiFUOoDeXl+EfPI9wSSOXZSKSue2zTSdEh/EGmdDjswPJdYAooLoj8XInj3qWqqSYXP7ykd3BdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8v45jl2XRhRFV+HE2MUiUPp3tstZBQL6dVuHHJi9AI=;
 b=zVMeptrjyqT2IT5/tm8DOnqQzDWFWvFrphR8MzA6Re7RBgFftq7K/eaP6XwjXu/JuxuAM9F0C+c+E2ar8F19Tm7jhoMbUCQ9w+Dk/ub7KGfXAa51Mi1juzt3lrT6U+EXYOLifIv7e8AyNdjstKGNruYk6MB9LjA7OTfrPR3uFw4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS7PR12MB5888.namprd12.prod.outlook.com (2603:10b6:8:7b::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.12; Wed, 26 Nov 2025 08:21:35 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::a5e0:9d7e:d941:c74d]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::a5e0:9d7e:d941:c74d%7]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 08:21:34 +0000
Message-ID: <b15c4495-3765-4af4-8cf1-38c64e8fa69e@amd.com>
Date: Wed, 26 Nov 2025 13:51:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] amd/iommu: Preserve domain ids inside the kdump
 kernel
To: Jason Gunthorpe <jgg@nvidia.com>, Sairaj Kodilkar <sarunkod@amd.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, joro@8bytes.org,
 suravee.suthikulpanit@amd.com, robin.murphy@arm.com, ashish.kalra@amd.com,
 will@kernel.org
References: <20251121091116.25663-1-sarunkod@amd.com>
 <20251121091116.25663-2-sarunkod@amd.com>
 <20251124144458.GH153257@nvidia.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20251124144458.GH153257@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0263.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f1::11) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS7PR12MB5888:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a674c5b-8bef-458b-e9ac-08de2cc4cfce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGlHdEYvOXpiclRXTEEydFdWd0N0T3N5djlKSE4rdDlOdFZVNU95NmNRQ015?=
 =?utf-8?B?ZVM5VkNtek9MOHBEZzZ2YjhCTG0wcEZZMDNWdWtTRGhKN0lyVXFSb3NLVmNZ?=
 =?utf-8?B?ak9DVHlaK3UvM2VaK1N6UHVwT3JxMzVLOGxCT0QyZnQyZnJCd1BTeksvNlJS?=
 =?utf-8?B?WXZPOHkxeTNBRTMvdWZ2Q1dUelNLZFlUQ1NlMkFmOS9qbXcvQUduVTZHVXh6?=
 =?utf-8?B?MmsvTjcwOFhLdEJld2w0cDNlWUJ3SklTd084djN3c1VKcENGdXI4KzN5Tm40?=
 =?utf-8?B?eGFMLzE1YkNyMXcvVHN5UjNESEgvKzgyZE43UnZmZUFNcjVULzZycVJicmsr?=
 =?utf-8?B?amt5V3FUbUZKSHlFb3A5ZUlMUFFPQmZ6eGp6WGdXYmxpdXYxd1hyeXloVUNP?=
 =?utf-8?B?YjBuN1hkVmpjYnFVN1ZieW04U3lWTTdxdEN3MXgzY3dFQllBbE9lZEtaVjdi?=
 =?utf-8?B?ZzU0MkwybW9QbklUZUdndHFxU08wdUtmc2xpdWJMMjFndW90YmlDdHVtR3U2?=
 =?utf-8?B?SkQ2dEViNytYSWppT1lsNDh1UVJERExjNWRTR2JKUUtRS0NUSmQ1c3V3Z3RB?=
 =?utf-8?B?QmtVaENVYjNDWVlBYm1TZ1BhZFNzSFBJRkhoTC94cEVveHJqQ01iY2UyNHJQ?=
 =?utf-8?B?c2RZTllkVFpLb3dIRU9QWFJyd3A2ejdTL0J6RE56bFFuVUpvOUVoTEJZcnVy?=
 =?utf-8?B?LzRGVEhQcG9ab3VZblF5QnhTQVpPcXFRaE5OM3pMWk1hb2tnN1JCaVFvcThy?=
 =?utf-8?B?WTFWMk9uVHo0SmZ3eVlVN0xUc0hXdFdiRmppQmxIYnhkTFZ0QjFtOXBPWTNz?=
 =?utf-8?B?SGJrSC9EN1FGSFpwYnd1T0JwRzVyODV3V0x0N0VlbnprVU5GU2FEUklIM2RY?=
 =?utf-8?B?MkRvbDJMTGtWQjZRNFVsUFNXbmdrMWhLTTRJM2h0bDV5bkJ1ZXFyY3NROXhr?=
 =?utf-8?B?V2RyeUNMdFk2RUQ5UzVueUY2TzcvaHBTL2FTYUtLRFE1N0tQaGZKQUtGNk9i?=
 =?utf-8?B?NzloVm5JSUMzTnk3Q20ycTY1VFRtYys2M3VzSmxVczQ5Y0RqS1RIbnk5Qm5K?=
 =?utf-8?B?K1RqZlZnenlxclYvRVZSRW9FSDJIU1RsSnhYdUV5VU1JU3licTJQZU9WSnY3?=
 =?utf-8?B?d3NPNzJCbDhsSnh2UUZQNVNHUTA5ek9HbURXdXhEZ0NyWS9RaGhraDh5bEpQ?=
 =?utf-8?B?Rk4yKzExSjJpbDYzUUNlWW8ybXU1NDFYYWlzKzlYRWUvanV0TEVCRmFjSEVW?=
 =?utf-8?B?VzRzclJlYy9YVlU4NlZ0WUZ6cE9sR0lMaFk4czZqdHcyV1A4UWtZYWIxTjRu?=
 =?utf-8?B?YWN1WWt4MVBjSnYyRnJxNXlWOU9HZkErY0hFdFB6a2pJRWZBZHphMVhTbWJS?=
 =?utf-8?B?S1ZrNkROL1dHV240U0E5NUtpTXhtaGZrQm1TaldyK050ekhCWldHMVp5MG5T?=
 =?utf-8?B?TkJtL3M5b0FxdEZXZkR0SnNhLzNFU05rdE43YW15ZFhxV1M2LzVEblhmNUxQ?=
 =?utf-8?B?Mjhnb2szUTYvQlNocGFJSDBsZExPNHB0cFFvNG5ObWM4VTBnSlpZV2lJY25N?=
 =?utf-8?B?Vldad3U3QnZSVEpxKzhoQU1zclozTGp6NjYrVm5kNmYvbE1PYVVMT3dBb3p6?=
 =?utf-8?B?cWJUMGhzNmtBWVhYcDVST2dweWcwM09QRVhPWFhmTHhPT2hIV054OWdVUjZL?=
 =?utf-8?B?czU4bG5RYVdYZWVVbmNxOFIrelNQd0tIbjJqNmQwdmZYdjkwSitXeE5DK2J0?=
 =?utf-8?B?V29tcEFPK1lxSkhZZmdPUnFDMjFweTNFMERTVmkwbUdnSmNQVGFIWEEvWjFw?=
 =?utf-8?B?cExrTVZOSDI5SzNFek80Sm5BdFFla3pvZjFURTlTUTJmQk1OUytwMGJPUnRQ?=
 =?utf-8?B?UGRIVEhoYVdMSDRTa2NrbjBoenRQcnpBbkRJaXhmdWtkTGk5WkFYUE1rQ1I4?=
 =?utf-8?Q?6UbcbLi4FtkaBwzmpibUdmgQjA39Tk/Y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmp0WWtUdEhXN3RWcnBqekNQY2VVeFduSGZtbWFmZG9VYzFUQzdUUXFnWk40?=
 =?utf-8?B?SlNZbzRXT1ROTGo5MVNGV2F4NW0rM3ZQbkl5N0kvdGpydnd2b1lndXJ4VTNp?=
 =?utf-8?B?dWtIRHd0dHZWczcxTnp5TnRQQjVyU242TTV1YXFXQmRHV3k4RTZlNERnbVAw?=
 =?utf-8?B?bTcreTl3Vjk3cDNtVVFGTjZENVRzT01UVVBRN0JYc1NacVNkU2Zta3dLb3I0?=
 =?utf-8?B?ZzJwaS8vTkZMNDRFczVoUTdxQWREM3RwWXJTV0hETWtWMGY0ZjVmQWp2ZVdo?=
 =?utf-8?B?SXVONHdaRlNqa01VRGwzUjRrTE5xaFVEWW5vL0dwekF4VG91cDJNdEpQR2lE?=
 =?utf-8?B?NkZiaENGcXJSVU1PU2p4WEhieVgrclI3c0UvR1ROSERpcU9CMFh1RDhTREdD?=
 =?utf-8?B?eWF6aXFKR2lDUWpIbzlGalVPeGQzQVYvNUZYWEppSnBWUitxaGV1bFlzTDY2?=
 =?utf-8?B?SDVQeEdmUEQrQnVxU0s4amZJTXNDUUtrZTI5SGlxOFpFQS85bnUwUUpuRkpM?=
 =?utf-8?B?RU1Cbk14dExtREFnNU1VTTBwZnYxc05VTVo1SlZDbURxQUFXVGd3ZC94cUFF?=
 =?utf-8?B?ZGVjRmVJb2luN1JITkVHZFFKUTVQQk8zWFNKeC81bjNDTmdrLzVSQzgzR3c1?=
 =?utf-8?B?N1h3UXh5UzlESGdGT0pUajZJNHRPVVFKdjBlKzJOUHJOT24vQ1RQY0lBOEZI?=
 =?utf-8?B?TS91THNtVk50cktYSmpxWVdJblhYTEo3Z3JYN2gwZXp2dXhkN0Q0SElrMmll?=
 =?utf-8?B?RDlJYVRiaVlaKzBnNGRCZTRhdUhLYmtMRnBGbkFtcldtajZVZnIwQUNqVUdC?=
 =?utf-8?B?eFpZVXYzd1hYOVB3WVAyZXFzU3NVQWhpcU5Fa1hnRCsvREVwSkxuWXZjejJ2?=
 =?utf-8?B?ZmtBTVRkVkJ4Nk9GMGEycnhaQjl3TzVWRUd4VFpjdFNldWh0TVliTXJITHBs?=
 =?utf-8?B?THUvMldLZm9lUWc2Rnp0SnZpYlNUcUxhTGJGYkxOL1c5SXBrMTNxKzRTYVdu?=
 =?utf-8?B?SjVIM3lEM0RXY0twTWh0SVlCUXNsT0tBSmtldGpxWE4wamRmNThtaGZMWStQ?=
 =?utf-8?B?cU13WW1LSStKcDRFV2pYY0VOYW1hR0FVdGhidDBpMGNiL2pKcGlENUVDYUVI?=
 =?utf-8?B?R1pPbWZPTUh2cC92Y2tmTzBhaEhBaEFGS2xzUXhocCtFdHZhbFdjWCtaeDA3?=
 =?utf-8?B?dVVBcjN5cjd2U0tZci9ScE5MNTBUNjM5dnFXVlg1WWFHREs4UXpnN3pZaGVE?=
 =?utf-8?B?UkNzVFlaQVREQ0x0eEtocmhhL2J4YTF6ajVpdmNFclM4c0JRcU0wUCtpbmRi?=
 =?utf-8?B?ZjMvWlRaVGRPL01TaEhrYnlsaUg3N1FjSy94Yzg2bnNnZ2JqeVV2TG8yZThH?=
 =?utf-8?B?akFpWGZPbUYxdXJhcDZQNERLdjZscGR0U2hFMXBwV3p3SU02cThTSHBXVVFK?=
 =?utf-8?B?V1dDMXFoZmFWeXBYR29GSzdzbEViZnhDY1ZsaVdqWXhYbmJWYUl0NCs4YTdF?=
 =?utf-8?B?bENzNVJmSDF6WEgyYXRXbktkeElhUExURlozaXZJaER0MGdVdlRXWnY1bmFn?=
 =?utf-8?B?MlZ4amdFamVVbzBXVEFKTEpLRStIZHpsZjN3V3p0UmhRNVV5NGxmQkZSQ2xC?=
 =?utf-8?B?S01ocEtPaUk3TnNObzBqeDF2eTZZSXc2TGw1QmpsUHpKaXVRN0JEaGh3YlVw?=
 =?utf-8?B?b0ovVE5VQWhreFZSeTkzaWRpV1daMHVTL2taYnBvK2grcGtqV0JJVDVBQ3pI?=
 =?utf-8?B?SXh2UXFnUWdBb0U3aC9sMlI1dG9qdmlwN2VTbWVJdEt2WnpWdzRVRmVWRm9l?=
 =?utf-8?B?MHFKWnhNdW1CNXJTT28rSlIveGU3aGQzNG5ZV0U4eCtMNUg1b2YxQU1QRmR3?=
 =?utf-8?B?UFhwYnNxUVBoT0NvQ3lkVHY2WmZFZzEwVmZHa0JpcU9GeldrbGRzbjZ1ZklF?=
 =?utf-8?B?UzVEN21BZ0tOMXRPTWVsRWhBZVRFQmtncStMTmI5Skw3ZVMxeXYxNHN3UCtk?=
 =?utf-8?B?OUpTNEZZVHpIT3NLMWdtaktScGJQY3NISkxDTGpFckM5aThPbWJucHV5QWhM?=
 =?utf-8?B?amtJc2NSSjBjZUxieFFUYzA5TThncUFxQnBhcjdVcjc2Z1pxa3JWRk9uWHkz?=
 =?utf-8?Q?4VDS+raJkdWRfG7no+JcWtSLo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a674c5b-8bef-458b-e9ac-08de2cc4cfce
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 08:21:34.8420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zELndc1VIJIhZj1i25JEMWgD39fO6NH1y3IEY1YNbBEHKRhV5yOZCNbUWZt7QU2KYoDW3e2ZlC0+f3+rr5MmrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5888



On 11/24/2025 8:14 PM, Jason Gunthorpe wrote:
> On Fri, Nov 21, 2025 at 02:41:15PM +0530, Sairaj Kodilkar wrote:
>> Currently AMD IOMMU driver does not reserve domain ids programmed in the
>> DTE while reusing the device table inside kdump kernel. This can cause
>> reallocation of these domain ids for newer domains that are created by
>> the kdump kernel, which can lead to potential IO_PAGE_FAULTs
>>
>> Hence reserve these ids inside pdom_ids.
>>
>> Fixes: 38e5f33ee359 ("iommu/amd: Reuse device table for kdump")
>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>> Reported-by: Jason Gunthorpe <jgg@nvidia.com>
>> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>  drivers/iommu/amd/init.c | 23 ++++++++++++++++++++++-
>>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> This seems OK
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> But the a point of this work was to remove this code:
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 48bca4dc8eb61f..1cd799913cbcd6 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2024,7 +2024,6 @@ static void set_dte_entry(struct amd_iommu *iommu,
>                           phys_addr_t top_paddr, unsigned int top_level)
>  {
>         u16 domid;
> -       u32 old_domid;
>         struct dev_table_entry *initial_dte;
>         struct dev_table_entry new = {};
>         struct protection_domain *domain = dev_data->domain;
> @@ -2080,7 +2079,6 @@ static void set_dte_entry(struct amd_iommu *iommu,
>         if (dev_data->ats_enabled)
>                 new.data[1] |= DTE_FLAG_IOTLB;
>  
> -       old_domid = READ_ONCE(dte->data[1]) & DEV_DOMID_MASK;
>         new.data[1] |= domid;
>  
>         /*
> @@ -2096,15 +2094,6 @@ static void set_dte_entry(struct amd_iommu *iommu,
>         set_dte_gcr3_table(iommu, dev_data, &new);
>  
>         update_dte256(iommu, dev_data, &new);
> -
> -       /*
> -        * A kdump kernel might be replacing a domain ID that was copied from
> -        * the previous kernel--if so, it needs to flush the translation cache
> -        * entries for the old domain ID that is being overwritten
> -        */
> -       if (old_domid) {
> -               amd_iommu_flush_tlb_domid(iommu, old_domid);
> -       }
>  }
>  
>  /*
> 
> Under the reasoning that:
>  - domids in use by the prior kernel are reserved in the IDA and are
>    never used by this kernel

It looks like on non-SNP system in kdump path, if it fails to reserve old DTE
table, it tries to allocate new one! Looking into code again, it may be OK to
fail in that path as well.. so that we will have common flow.

That needs to be fixed before removing old_domid check.


-Vasant

>  - domids in the IDA must be clean
>  - There is no reason to flush a domid until it is returned to the IDA
>  - detach_device() calls amd_iommu_domain_flush_all() before the
>    domain can be freed and the domid returned the IDA which clears the
>    IOTLB
> 
> Please add a patch?
> 
> Jason

