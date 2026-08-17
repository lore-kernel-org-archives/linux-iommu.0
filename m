Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9EC3B42EB
	for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 10:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786961523; cv=fail; b=uwfnU5Hn+M//IhZti9eHjF+jshon1NNBEOYGoatxD+buhmrxU+0r98Hriv99KxCgv4D+XARVRVoJZgHAqdAfMdSDuqeJmwgcGDk8ufADX41dEVwTmc9zEc2GNJFSOjvxr7kIs7zGiS4JVkk5NibK/CjxglySk1Y68V70YTbOZGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786961523; c=relaxed/simple;
	bh=5fcZaOS4QFDZyAIhqyvIeumkv9ac52pyXqS2HIeCNNE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VVVqF1c7om2U7EGzE2qZNDQLem2at9K1TK2sCuLExUKtPhiY2rPuB/8HlJ1b+ZvUhv44RLRTIAhYJrapY4mQX4RAr7WOHbCJfv5QqnDpgRqyzLLQfj8B36iF0deJei7Xg+7nS7OzliCmAzytuyquXm6buRXNa/R1PTwRbBfOUac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iOzhgJoO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Zf//2PhI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iOzhgJoO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Zf//2PhI"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67H0MXAt3909441;
	Mon, 17 Aug 2026 10:11:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=FM7x/4I63Woe16DyLCdzgne4DPnFkuT1fwCdBZqa6Jw=; b=
	iOzhgJoOrIJSh6bNGriKVbCRZz21JCaUT5PlS9RIKZOu+M1m1HZdLcJfDmj86QqW
	EXzX3wdNI93alTB6+TQ4iSuV8KpiFAwXBDw7QKpZ5de/wc1QFBxhn8uGj8/pGGa4
	93kF4rX/mcWTLIa8dQauZDUm/vwITdXYw49S/WAP/dJNx9HIh6eMX3qa2fSH5bfH
	89g/s2/kLKjl/j7RFhJWkITCbuP/X9Si29Ybvfom6pMWnYXCx4nrD/cmJIX7uNO5
	AXa4dxD7Rh4fI7sIiS2FKSVwPuNGY6tVPkNwUbIsv3hiedt1lAUK077ibLb3uzXR
	ptTsljIPhVi/ER9TRqo8XA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g2f1bt47f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Aug 2026 10:11:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67HAA8HI002300;
	Mon, 17 Aug 2026 10:11:50 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010002.outbound.protection.outlook.com [52.101.61.2])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4g2ejb37f8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 17 Aug 2026 10:11:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=psTVIkzlv8ftXMG93EiHooKknbjLXHbRalQqBoRnx5tMosfH01gS9Hg7npm/yod91W9VyxXJXUY2vdFW+UYKceF7pTaMIr3Ex2onoN7q+VcAk/pXUpdU6baqtrTtsdDGdeuHq0UbKXrUwoOsAGvd1A5eHV42DRkEounwj3YWAvqU0oMfuQT62+v06s5j2Hv1LWbB8evvOMUKfI8yQWVRIlWPCtZzkcOWDukhbmMnluFrbdF3NQ30hOccaP1GqIVLWV2jN5TPvubTudAOv2Uh1Dt2r/n6JMomDQCaBUUmYyW3pzdT3b8g0A7RuMr6K6ZsXGji3FXgMp8SMqK2n5aCkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FM7x/4I63Woe16DyLCdzgne4DPnFkuT1fwCdBZqa6Jw=;
 b=xyU1hyumgM0m5F7phq5k08BXrNiq5bhuBv3o9z7tR5Hqj1BUqMb6BGMS4YkCwA4yW5ssynbGXroC1TSciuwlnGWw2yRGiM09CaaI3Ml/w6fAvLcJNyXM5uNvrjskdpsybko51O1K9hCVttbhfcLYHXm6XjpPTM3eJzoTLBpsFVzHQbZ9bbHcapLZTQPoKVH1skmaSoZN49avsY8s3qCeA+tfVFQnGi/gQBgSfB+Y/p3hKDtw7dO1Xa+Eec2dwlHfZaXTPLCcWDZZE8f41vWSk9Y2g2cA03cBXAVnzHMRewPW6nVyc6K3XKBnQq0KT5dsYtzgShDbwzj1Z5R92AvnoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FM7x/4I63Woe16DyLCdzgne4DPnFkuT1fwCdBZqa6Jw=;
 b=Zf//2PhIZJWWleW3aHXozQxJnMLCd3qByv27jcnDqZkUH/fRwr1L3H7MVolQvlNwdK3r48SHuUOnIkNwPBsANpqPcHqWzm9sCodKMaiF7zWRJB5m9D1lEIiIOzqBU1SyRsYVl+PjErAdAobe8dbhA/4VyUaelCQ7KQ6Inqrfo5c=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 DS0PR10MB997602.namprd10.prod.outlook.com (2603:10b6:8:314::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 10:11:48 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 10:11:48 +0000
Message-ID: <8b7e86a7-6cb1-4007-bd99-1c4be8e6828e@oracle.com>
Date: Mon, 17 Aug 2026 11:11:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: dma_opt_mapping_size returns way too low sizes when using IOMMU
To: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
        linux-nvme@lists.infradead.org
References: <20260817083654.GA23414@lst.de>
 <86f7fbdc-3c7f-4d84-871e-52ed3cfe8d58@oracle.com>
 <20260817091840.GA26843@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260817091840.GA26843@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0397.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::13) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|DS0PR10MB997602:EE_
X-MS-Office365-Filtering-Correlation-Id: b383c117-bcc6-4bf1-3d5b-08defc47f2d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	INZ4NbgT9SLngpa+WbTZW/Ib9MHQaV8FDP6r+sZ4NxlIEhj7fEHXUN1IJIlDUVuK+UDLj3eTi0kgkB24x8uHfAWkWmeD174/E1+R/0l74ppyAyOV6enkaRRPP6igYRAYj8YuNgtQTty+6iXsSCaxZSqQ3I9sj4Htd1onkAVNmSt/C/mytozyMvRIsFgxM7ze8UmX3MYthUviilD4mbyiVqwDWd0rZKjlIo/rqCuBf1tqaDkOcdNc5H6TZj/Evz4QceulvkIHUqZDKYevOWkfc0NuL9RL3lpISC9D4tu3luo5dmVoJr33QN4lVSK/kk+Iv5RYS8jHVHa5zYiws+16rNj7t3LbN77VWVVLeeP9JLoE1IBThhtJgmMabo07p3oWuvDr50Om4xVvhkIQxjVhMNX8kUxrOmqVOUHbFopPIBbMJTIlaK2zqoHEOkfA8bL6iZK/sBuHRaDJ9u1xa51ew0ka+KS+W2A8AugTBcPWACL0g/U0KtHUAVIqTkjW7Q2IqbeZL09YS7d5uyxslAjGZ+xM/7oYIc1doY908QN/xr4EZP9r0kCLK2RUIAHyU0cNPSPAd98LpU84V6aMPG5KE2eIwyhhAt7TDoxXsHaOcqDtwWyuyH0rWahKOTPu5xSF2uyxfE1JguxIwXfYmOjK3Or6QgeW81quluijnQfLD5E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkF5YXVkQlNQSkU3M3ZrNlJTYTJWVGtCNkZnSXFRM3cweHNib1FJN0ZUODR3?=
 =?utf-8?B?c3VGdFBaZXFlelM0b01mTk8vdTc5WGZHN29mODJsbVhtNlJXbDByZnJnaXpk?=
 =?utf-8?B?YUJBVm9uNHZRdjhrMTFEQzJGTmtJRjUrZkk3ekt3Mm5xTDJFKy9ZVkVld3dB?=
 =?utf-8?B?bFd3SHZOR2wvSENBSXp0TXk3cXg0NnoyNVMwSEQ3UURzZWV0Szh4bGxvSmRF?=
 =?utf-8?B?SzdYTVRWeGxScUZQTHpMUXZIUlNac3Uzb3owem9NaDZ5MEgwVkFFMk52Yk82?=
 =?utf-8?B?d01pR2QxNDQyVG5GQnNTcWt4TStuUzc0LzNXNzJ5dDFmRFRoZzIwUDNtTW1D?=
 =?utf-8?B?azNkVE9lWnJSNW1PcVo1VFlwdlBHTUJPbDI3SXdYblAyOXA1Q0c3Z0R2WXhY?=
 =?utf-8?B?eEgwczlwTUZmeXpOQzR0RnNVR2FCdDhyVXIrNTlmWFMwS3FQUms1RDNrOGtX?=
 =?utf-8?B?b0pFOFd5clZnS3hNN2JKRlpwaVZ5RGY4UjM4bjNDTUd1Y003RDRMVFZ4Zmpk?=
 =?utf-8?B?d3ltTDNsOFZFWkkrTEpHNzlGVW12NUNrZmVNYzhiaXJIK001ZEVUZDNXUEVU?=
 =?utf-8?B?NGxxdFJMVUZ5eUNmM1dWV2ExZDU5NUpOb21sdWlET01wRnErR0w4RjJvZkdH?=
 =?utf-8?B?cnlVOGtFYUZvWlZHN2JGSGYvbkZqamVqd0dNYkhPcjlRSlIyNmFadCtvTWlq?=
 =?utf-8?B?Zk9lcHlwQjFMTnpGVDdmZTBNOFdlQ2srUEw3MkdOR3M1TEx2ckowN3c2MHdU?=
 =?utf-8?B?NFBTSmc0S2c0U2U4SDhHRGF0M2NkQlBXZlNFZWMvODJOVWhobWpiL2tLdmpW?=
 =?utf-8?B?U0gwOWxJUkFCaHlzeDZTMlVjcFlxYWx5anIzaUpuSmZZejFyRmRubXE0NmNT?=
 =?utf-8?B?T1hBei9NOE1nOW1JODFoSzVaUWdWK3g5UFFLWG9aN2QzTU5VT0dnNGVCYW5Y?=
 =?utf-8?B?WWdueDBRd2tINTIwVUM2RFdtVklvbDVnWTVyK0VjZm00NUg5c2RFWGlqTWtJ?=
 =?utf-8?B?YTBTMUhRdEZHQnpRa3ZLRDUyTTEvTUd3d00zTUNJcWpxeVIyQ1YxTUw2U0dt?=
 =?utf-8?B?Z2RUZVdBWlNNWjlzYmhwajAyL2VaVkhZR1U2MWNadHp4bnBnVFFTMnoxK3VD?=
 =?utf-8?B?c0loeWJHeWlhZTdoYlNvWnNyMms2N2dRR1JuREo4WDFPTjRzUTJabWE2TytB?=
 =?utf-8?B?M1hZcVJBUFJEZUplV3RMT0E1RHNoOWNrZUJFdHJNcy9jcmdCelRvektyU0FS?=
 =?utf-8?B?ZDQvOEFCWUsvdE5QSksvak1XOGJBY0FnNWhHcTBQNnV3UEdhblBoZ0w4dnpx?=
 =?utf-8?B?K0xSYk1Fdk9qUnlCbW5SRTE3dDNNTFNLWnRZVmVzWFBaY3IwU2MwRXBKcUQ0?=
 =?utf-8?B?aVZFWWp0Q1QrZkRTQWxsblNlN2pRdWx6S055Y3dmdE9jMGIzM1FkS21PMHU4?=
 =?utf-8?B?dlJHWkx1US9PSm9qZU1uWUZnT1NZZmg4Y1VzTFg2Y1RjRzVOQ0VIeFZyeGVX?=
 =?utf-8?B?amxFR1ZPeUJMcHBnb1hsSkpOYlZkZWRHRG5wVEhSRkZoZWYzTkRuNEZta0dr?=
 =?utf-8?B?aTlYNUNoYlNEQmFaMkd3N3RmaHpDbHRaUGhNL2hhTE80OVpyQWU0Nkg1V1R0?=
 =?utf-8?B?S0QvTjhRakNkamsvY1FISERLSmZlY1ZGQXpmU0JHbTczUG52L0VKckJBekpj?=
 =?utf-8?B?d1g0U2JCMzVadGEvVUJ6dHJKNVNtZUQ3amZFcnUwYTBUQ1RaWTRibFQ4Vnd1?=
 =?utf-8?B?WE4zZTBjcVBYQ0wrNVRoMEl2cFh6RC9haTJHKy9aMlB6WVNHVVprWmk1Y0hq?=
 =?utf-8?B?NXJJdk5BaEx6aXMyZHhUK21TOGZBYnorTWZ2cDN3L0REOWl5WWg2aG52UnQx?=
 =?utf-8?B?LzY1blpQRlFSUVZwV2JIa2h5Qk1MeENkamMwcXNnbGg5TVZiVHlFYXRobmRV?=
 =?utf-8?B?aUNLSHU2dDl0Vi9QS0thT0p4OGdqSVZrdHorTXNDcmxtR1o2VEw5dFdnMnJw?=
 =?utf-8?B?ZlpXbVZ1ZE0zL0dYSVhueWZtZnFFdE9SS25BL0JVNFNsREY0UzBPa0dMQmpB?=
 =?utf-8?B?M0gxOGxRYnc1V0xrVXZKQlhyaE0ySXpmbUNIajBkY2ROV0JINEIwMlB0ZkVo?=
 =?utf-8?B?R2xvUElDd1JCaE9yNUIrQ3k3am9rLytvemlSb29YWExualMwZStYTTc2dnpu?=
 =?utf-8?B?Rlo2Q3A1TWZqWHNOM0ZFMVBBR1pCMW1PYnJuZXBVZ3kvSnE2d29BNUxEVDB1?=
 =?utf-8?B?YkY3eFBSSENSQWVDRWJMai9xTTRNQVpSMjFwVnFXQ0l5a0YxZFgzOHhpbGNh?=
 =?utf-8?B?MGhVcUZJc0czYm1KV0o0cXNJTHp5T1lzT3NVZ2U4VlhhL085RDJSbHdYZ0sz?=
 =?utf-8?Q?MBAUgnZ/JdhVPnGM=3D?=
X-Exchange-RoutingPolicyChecked:
	NrFXd7LVBG6XhZk7pGZn7efh8rhBdkAioqeT11ELks9u0SELv0kiXArh3O69HqEFEl3gc0icQNMwWviKgQl5GGekiy+NO7PbQUold2oX/YMfFbcW8naNW3780V4ykXMRNCbnHzNeZy/RUQdcTNLZofOSApOwQXh76+zIQFxaKlvN4gKWjVcDSxOHLIv+nRzCNlpgX+GTaeA4bJ3AEliYF45cvelBMluIBLr5/ymYsGYgG4xFkkUP3TMpEfBH6XJ0+vPnS0zFCow5eowZM1cC5ZV14lFmJvg+eevrye6sv4zkWH9RrWn8p+F4LuKsJ3pvCUXOpGQ01mQP8e/V3xTkKg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wCBk6Y1TfUodnUeZUk1fg1euJl8gPVOPKlchVvi8bvJV2lBpuXHP1C3p8RAZHlc3FuX9Ljh2uXIGFVmV4GluMMjl/nmAwdw3Dr3+/9HssutLT+auWG2d7YDnpCYA2hZA27Uf3nFLZ7fGaa9JumbcMs8Bn8GOds8xzBEs+zQG8PCigYjxPyMSGXYXNEBXbTOdkiVEbwcP7BkTnoXo0+LXkpQK/WvV73Opjyf06QF4aC14+E7WFoBXps5KtDE/4w4wA92/5MmR0sQeoOrT2bET6Y+IDpPqr50me7Imz6t2q6vE3BRIjkeR1VkkdBWOUtz6SLOys1LFg1RV1lFvo3lpYjW11fk2oKlO0iwNC8SvpFnAl2/7kNBaeRjTv3N8jUVKXNAFVp7ZM8oiNkcXT/zC+eXwGv7vI0VhOO4+oyxF0t8vKbmrNHgWvEDbIqpwaUDsTBD8tbZN80YrvJBLg2Jki7jP9e8Pg6u/H+6T+FieRJxccxkvJ3k1vpH2qnlRd3wTFOH2rXNLnyUJxZafOMP0jq3z09G6u0koJemX/U/Zkg0rsStZUe1+mgyCZVD7Kot8+NfGnQPzT8T948vhYjWpxwvCT+ph5GrfKEDs9PW98aM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b383c117-bcc6-4bf1-3d5b-08defc47f2d6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 10:11:48.2984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cjaFjY/Hz089nRmJThW2wsQzSbnJsvMv4wKOZ0/tnnPSPsG9QhYq53HVhhCR8r5P7GqG3JMXZcjXPnjcArbiaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB997602
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608170075
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA3NSBTYWx0ZWRfXy5eI6jp/uCGp
 E3SKP1ushDtN5IyavOM6fb5/FvwcsT0TK9Lq5Xvf1irwPtXzNIeIwHylIAQivWEBUGGDAsPh2BH
 3+XcClK7i0kJMc2Ku+w5T3+DTd0esoF5DfZbQ+gUz3oi5CRJ7/ItdO4XZE2btvxXYyS0n6qFKIq
 jvk0uGiKeccLtkCguVUD0mjwBC/zWpa0/O8mTiFmr+1HVrXgjG0+DH1cRvEK9F29807mec3p/9Y
 eUTedi5b4/emQXl7jmn/xHoiWqwzGu+MdX+IbYkXo2zeho7yauNq2gcskvMLAi/hSm00sA2HbUa
 9bohgoZ9F7jllGY+KcXJi+5KpY/42veXjB7tuHUDQQYff3Pqwg6qFAlTGcrLW0YWbL+yVPSvYDL
 cU3rkDENRdvC1ijY7aKm8/wkFleGg0fYBKUMMdaaGSpdj4hsDr5IK+5W09pFso9smmrTi6aLlGY
 rSrGhsbYiiGqP3GPVtg==
X-Authority-Analysis: v=2.4 cv=D/937PRj c=1 sm=1 tr=0 ts=6a82de67 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=VwQbUJbxAAAA:8
 a=i0EeH86SAAAA:8 a=bRcv_FBpQJmN_0Ok9L8A:9 a=QEXdDO2ut3YA:10
 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-ORIG-GUID: hzQuFvUXjsQrapSPhtOnaDSpTCPqVn5t
X-Proofpoint-GUID: hzQuFvUXjsQrapSPhtOnaDSpTCPqVn5t
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA3NSBTYWx0ZWRfXxP7M033KhWmE
 gsMotU/F8HixkZ+aH67Q93M9Tz3qabNMZ0T0Dw2kmDVxJIwrPHk9d1fTrbsFZBXvwDIr2CCtX+J
 NvhIRFt9M6IhDFpfFcpOIHxju5DuVwSh0qfxDBujW+fjV6YIYM5A

On 17/08/2026 10:18, Christoph Hellwig wrote:
> On Mon, Aug 17, 2026 at 10:12:25AM +0100, John Garry wrote:
>> On 17/08/2026 09:36, Christoph Hellwig wrote:
>>> Hi all,
>>>
>>> I got reports that NVMe devices were arbitrarily limited to 128kiB
>>> transfers in recent kernel. 
>>
>> How recent a kernel? This NVMe and DMA mapping code has not changed in 
>> years as far as I know.
> 
> This was hardware QA moving from an old distro kernel to a "recent" (aka
> still old) one.   But I've actually reproduced it locally on an
> upstream kernel.  I guess most kernel developers or power users simply
> do not run with IOMMU enabled.

Yeah, they don't like any performance hit.

> 
>>> Both the NVMe performance numbers and common sense suggest that this
>>> is NOT the optimal DMA mapping granularity.  Can we pick a saner value
>>> for iommu_dma_opt_mapping_size that does not restrict common I/O sizes?
>>
>> Note that SCSI does not use iommu_dma_opt_mapping_size() for clamping max 
>> HW sectors, but instead sets opt size / max sectors from this value (so it 
>> is not a hard limit there). Could we consider similar for NVMe?
> 
> We could consider that, but it would still reduce performane..
 > >> The reason for which we have iommu_dma_opt_mapping_size() is that
>> performance can go through the floor we can't use the rcache for getting 
>> the IOVA, i.e. we need to always alloc and dealloc an IOVA from the RB tree 
>> for each mapping, and this can greatly reduce performance when the IOVA 
>> space fills.
>>
>> If we increase IOVA_RANGE_CACHE_MAX_SIZE, then we just get caching of 
>> larger IOVAs and I am not sure that is a great idea.
> 
> At least on the four different nvme devices I tested, the larger I/O
> sizes made up for this.  But maybe the details depend on other
> factors as well.
Are you saying that you tried increasing IOVA_RANGE_CACHE_MAX_SIZE and 
got better performance?

As I remember, I was told that the value of 6 for 
IOVA_RANGE_CACHE_MAX_SIZE was originally chosen from the value then in 
max page order, i.e. the idea was that we should not be getting 
streaming IOs larger than that value. But in looking at lore, 8 was very 
originally proposed, but I can't see any discussion on why that changed 
or any relation to page max order.

Some time ago I did try some work to allow IOVA_RANGE_CACHE_MAX_SIZE be 
set per IOMMU domain, but it was not merged. We went with 
dma_opt_mapping_size() solution instead.

https://lore.kernel.org/linux-scsi/1620656249-68890-1-git-send-email-john.garry@huawei.com/


