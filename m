Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9223B144D1A
	for <iommu@lists.linux.dev>; Thu, 19 Sep 2024 21:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726780001; cv=fail; b=CwxGCGEO18hWKcjTyd5C404PY5kcRuKK8XtxEw6euV7tKOrpMuwO3kkNfp5zKU6fvE3yvwbYKR4GoDLvGrc6hkE9n3pRwmN85zOvIi1iV4Jlw7Rhio7RokpMj5Tko613dnZX5idy2wMTYib0QiWdzpgSK0tsggXTPcd6WvcKAK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726780001; c=relaxed/simple;
	bh=wVM3E2JKxo22Lu2AqGGKf6w/5OjZ8bW6Bv0HxKCFS3A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sOA7sFCTV/55hJjx7BRfqfdAo2W1XNWufOJtSRECmduEgoqfmhyPO1tb+mKLaQo8Te2UpR5UlV46i1n3TZ+RfdpSPn7HEM3jk6REedgc2aqsq9kq6OBXT21Y3lxLAHATRDd2HcU/mOgL7TttdnxOHEbCUl71F2t4ErWvAbLR2Mo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FsukIRY8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=p6sI76+K; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FsukIRY8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="p6sI76+K"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48JL1h44025497;
	Thu, 19 Sep 2024 21:06:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=b/aWmeK7Mckeds2rcOaLqh5uY2Ni/aJw+83FaBiOqW8=; b=
	FsukIRY8RENCPIx0qNQpi/e9rz7SY8tJaWeP3RfrLeAfXQMPp/NyZd5SFrff3JHk
	a64iP/SZvsFF8qcRNbyKs3qAHRHuJsd0av5pzMhVqV3e0SX4gyn5y4OT9hnHHatY
	adYP1BOarjDHCuRV7L1vk89EtqFRTfVWkcIYWor1AonUISR7jCFI3HVeLLDm4H4T
	yMlraDtEZ+H5cT7ZXHhkSWdqY8M/rIRfcNfcCbUhIEXeUHm/aeECmcnPa/NncqNt
	AN/7V6YpydgVs+RITCNCLXi6vn9h/yDU/HMA/9c2WgQZVYTIvkjvofQYwj47Guoy
	OkQKDBd4h+pHF82ctgWaYg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3sfw6h2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Sep 2024 21:06:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48JKTZmX000427;
	Thu, 19 Sep 2024 21:06:21 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2043.outbound.protection.outlook.com [104.47.56.43])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41nydyn9r8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Sep 2024 21:06:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Km0bpjHo1k9lZCgZ2j9+lE9h/c1t7O1MKN01zHg7pVbooWj3chse+3cUjIdgHfJmZwLBVHn1O1CmbSCc40ceKLo0IHRuBoE3m3ds1aGLtZDZUMwrCYi/kd58SE2mEsL5XyzL0uD14jxZ7ywldp0P/kwd9xTDaUxEynXJk+gYsxktiJx28D1e97WhN1GNu/vwMXXvaLHyKBUsU3WU8YAPzsG3U24JzSWJyFQUaOYa7PfNDRM8SWP4wX7SRnKa9hCahfGpGMWrP2yYeLSiolIkZMtdRwYSVUVRtjrMib6FoPcQWnJ6HKkm5euvLS9mB43ngyIl0mr83gqu2PhPdbue/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/aWmeK7Mckeds2rcOaLqh5uY2Ni/aJw+83FaBiOqW8=;
 b=Mo6SZgVmjk3r2nf83aqc1juRlp+ppN1boqK+tQBfmrtKSuCswIgHBXPnn88MGGaBUBAll8uMO1PahTzoL6fWP+6h9YVN6sgExq6Htw8uE8f6ou/O6ASAcenyAtsVMF+8NIkwOJPCzTdWvT+/kHGDPvMrfAFlk+oUdLeiqV663Oby9ZAZPcgBiLLYWX6nVmpF1ingzMqBEf7oN+4eUby31uiufmA+fd+yEzROps0o+Vq7YbRgzVxbfUc6byqMrNVLX9uZ/e2tIYog44K8AuZAQnpXpdcr0wqxmYZo/VOfrO2mHarXQEyMh+yY028Tg9WugI4+UamP2QK1VhjMQeqkTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/aWmeK7Mckeds2rcOaLqh5uY2Ni/aJw+83FaBiOqW8=;
 b=p6sI76+K1tQuVwXywhi3vahmW2WohwkQG7hGsoxgF4+9pTtoSLdWPWUvw46suY+rKI+kMOxpFvH4/tIgkv0vKFOJuLMVypBx/vqAMFsKFTjl1h+7sBZIp5Se7FEMZbtACpbo+ysgPnlvK5RxH+o9Gg6XYk/moPm5Pw9HLDMv7to=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH4PR10MB8123.namprd10.prod.outlook.com (2603:10b6:610:23f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.7; Thu, 19 Sep
 2024 21:06:17 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7982.012; Thu, 19 Sep 2024
 21:06:17 +0000
Message-ID: <ca95e882-46a5-4510-a0a4-2c12a01b1f9f@oracle.com>
Date: Thu, 19 Sep 2024 17:06:14 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 1/9] mm/gup: repin_folio_unhugely
To: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
References: <1726319158-283074-1-git-send-email-steven.sistare@oracle.com>
 <1726319158-283074-2-git-send-email-steven.sistare@oracle.com>
 <d25fc25f-34aa-458b-973a-f7de2438b837@oracle.com>
 <6aea6530-9f9c-4a9c-9c9c-2c29e8ae9e9d@redhat.com>
 <98004c8e-f941-480e-b1be-8f6fd925871a@oracle.com>
 <dd50a217-d492-471c-b708-a400c04e8444@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <dd50a217-d492-471c-b708-a400c04e8444@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0187.namprd03.prod.outlook.com
 (2603:10b6:408:f9::12) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH4PR10MB8123:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b80ab49-5bdf-4939-280f-08dcd8eee76f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2RlWGJ2NmRMcVIyUTZpSTNIUXl2UW5VWFlydkc0dnBPY29Ec3MwZ24vQlhy?=
 =?utf-8?B?ZDF6WS84U0M3SWhkSHpGSjJ2aUxBaFA1YlJrd1N5RTRrbWE1Wnkrb0pNeUFH?=
 =?utf-8?B?R2daN3dKYkdzUE0rY09RNmJuQ2d2bXBvS2dNcWlRcEZ4SkFXWkRQcThTYWg0?=
 =?utf-8?B?bEFNeU1xNEJzNFNzSnNBVkllR3RKZnMxNlFxUzJWa0ZPQm1rckVrL1V1N1h6?=
 =?utf-8?B?bFIyN2duTXBtZ2d0RmhDb3JsTWJmcDBpai82RGtjRXpCaFVtRHU3WHoxVkJY?=
 =?utf-8?B?UVFxa05YYk0yNmhXRUZtTUhVTlVTN240SmV1bWUrcmRHTVdYeHd1dW5LaFJq?=
 =?utf-8?B?VGdMbktxZzBmV2JBMXlMZE1ycmZOWkJwS0s0b0g1SE1GQjB2TXFpalhuM0di?=
 =?utf-8?B?ZzYyb1BhMm5ZVUd6NEJCWmY2T01oWkFqeFE2cWpmMGJySExobUFzVUtMRG16?=
 =?utf-8?B?YjZXc0pPS3FlTnp4WHE3SVFFR2p1Z2h5VW02WWtuSnNIVkJPRTE1Yjh6cDF2?=
 =?utf-8?B?bXhScjd0dFMzeUMxalRXdEhtdUJMRjJnUXliaHhRQmVnWm1CSG1pVkk1Yk11?=
 =?utf-8?B?WlloY29SVnlWa1dma0dHUndMbzhleTB3UGlrMVY0Qm9tQzcyd2ZVV2lKclZE?=
 =?utf-8?B?UVpEUGx1Y0MxelVKMHhoRDhLV0o2RE9kMjM3eHVSQ2o2ZnNGYUNWdTNpQ3J6?=
 =?utf-8?B?RmlraCtPWmtrY05BL3dYYkp0NHVxK3Q3ZnFlVnZZbXdzQUNiRUdmZmpYajAy?=
 =?utf-8?B?QWZUeVppWVlwMjhYOTgzT2RKelhnTldHYUlnQit3eCt2SUllcndIMDBtd25X?=
 =?utf-8?B?NERLRVRBMW9Rd1JnWFNQZEFVVzFRSEh2M0g1VGtROHJZak5td2RDZGF6YS9W?=
 =?utf-8?B?czRabTlXMUVuMWdHWjVLcHhlSTFQSXgrZm5CTVhCM1JyV0xCeERYK3pmcVNh?=
 =?utf-8?B?M2JrTnI5MHVqQktnZ0VIWUpJejFnQ2ZpbHovRitJeDM5QzhXbGlpWngyYXBo?=
 =?utf-8?B?dmdhOWlxeXZYYkpmV1JBdkNEOFV4OUNnb2Z2TmVraS9LS1RXQnV6b0lyK1F2?=
 =?utf-8?B?YTBucFgzdWxiZWhSYnBsSnpDY3hsTnhzL1Q2QmpIWWc2MHd4TmpsT0xnenB0?=
 =?utf-8?B?MEVqaWZUbm5IYjFCKzU4UjJZdGRFTTJRSjJONE1VdTRjaHgyUTRwbk52akJV?=
 =?utf-8?B?KzVVOWhvQ05IMHhhNXF2MFkzYVVmRXlLNUJleHFEYktFUXhzTVozRWxKSjZn?=
 =?utf-8?B?WGgxYitBelVoYW5mTGU2RW1vS28xSEdXYU1rTFIrSnVNbHBMMElhYlBLZ3Fl?=
 =?utf-8?B?UkZNcUs5ams1aG1SNWxYMFp1Tmt0ZzVOU1FJK2ZxcGt4WTRrUUJhUkk4dWRD?=
 =?utf-8?B?bmdkK1JSYnBlcndmdUgwUXlkbVVaUmJ0ZmdzSzZnYit3TllCcyt1R3RGSmdr?=
 =?utf-8?B?T21IZjhETWF5TTIyR3ZGblAzay9ZdUg3SlBJN1VtSWRiU2d0YzJZV3ZkMTVt?=
 =?utf-8?B?aC9qRm5HSXJEVFRZQ2xoeE01UUEzeVZjdTM1U3daejgycVJBRGNwU2x0cWE5?=
 =?utf-8?B?TVBiSnJoS3I5VDJOM3hpZzdjRG1IU0N1YllpWGpibmIrWWtKSzlROUNVYXRL?=
 =?utf-8?B?Skd2N08rN3pDQnRrL3gzWXVBb2V6b09IcllsQjJWemlmTWsrcUN5bEVESlNR?=
 =?utf-8?B?VzUySEczd0tGczZJT1dFTCtRZ05HRWhSOHVNeVJmTnAyRlJwcFJmb2xxYVZ4?=
 =?utf-8?B?SWYrZVZPRE05cUVlUkp1WGovOWhDbUhNNGxxY3VKQm5RR1lpOWdkNHlydzVw?=
 =?utf-8?Q?joBd2k6eCqR4suogZjtphGXdNefUQkAioHWCQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFlnSHlRb2tVTEF5ZlJvdHZLZUVhaG9PeTJwQi9UcnhzYXBtdG94bUs1Q0NC?=
 =?utf-8?B?NElJQ1BCUU4yTWpaWkdpR3ZTaVB3ZHBLWU9wYVpkTnVXMURPNTE2dEVvd1Vv?=
 =?utf-8?B?Qk5wSW1zSGYxMmZYV2h5eGZUcTJ2N2lxQ2owVyt2bDRtZW5LSnVsUVh6VVYx?=
 =?utf-8?B?Sk5PZkpUcWxFeklOdG5HMmQyWkk1MVo3bDVGM1lOQ1VSZlN4aEZ5OWQxY29k?=
 =?utf-8?B?Q1ZYNG1ueC8zSCtkR1ArZXdlZnBhK3lqRlRUMUIzNWJPekNrUGRqbUcwSWZS?=
 =?utf-8?B?enI2WnVGV3kzOFRYWmFzRi9yMmlaa3liWVM2Sk1sMmxvQmw5M3RPWlRyYmJC?=
 =?utf-8?B?dGNQMUF0bVV1WEljYUNuU01hSFNnVmJxdnNRbDhmOGJMN0hQcldYN0U1Q0VZ?=
 =?utf-8?B?UnA2VHhIU3F1VmUrZnlEVEMrUVBWTjNiYldSMVpuRW9EWlg0MWZVOWFacU5E?=
 =?utf-8?B?b1hhbU5sUFhmT1dFVEtVZ3gxd0M3RUMreUhjV0xmZ2szUzhha0tYTUpRUHc4?=
 =?utf-8?B?TWRGZnkxOW5PT0cvYnBUUkpDUlJFdHVSQ2xuK2NYa0daVVRBUnNRYUllbFZq?=
 =?utf-8?B?djhlMDRlQTdGZjd5YXJlcHJadFdPSjQ4aFFOZTFodjZEaUN5VE51bHZHL2w2?=
 =?utf-8?B?UXFNb2pqSExITDg4UkJwWXZmeVVLb2ppZ2taaGF4bCt6QUo4RjhTcDhXM3FO?=
 =?utf-8?B?S0RHY0hicXpDZFZnYm9yQ2ZyK3g2bUhLby83ZnpQV1pwMVV3bUV2cmZkWHJu?=
 =?utf-8?B?NEhsei80TEdCeGpxd3BjTHNqUVoxaE5KQThZZ2hqUG1uSzU1cTlhTDJiRFNB?=
 =?utf-8?B?QzhrRTE4S0o3TVQ4a0UzQkNicWxFYjBtQ3FjYmo0bWtCTjlBK0tnUUwrT0FU?=
 =?utf-8?B?YWZiQnAyWjlXR1ZDaGVTQ2JRQitqQk93ek02eHVlQ01KWmE4dTRtTlp1ZDkw?=
 =?utf-8?B?N1JKRUpkU1FDUGxKWmhhNE5GckFyOFlEZ0VpZTUrZU5zTDBUYUU2WW92eTVn?=
 =?utf-8?B?dmhVRXZqRDlSamFrUHNxTUVwSkpwZnIwWHM1cmhxdC83eC96UDRYdkJEd0x5?=
 =?utf-8?B?UndRZENEdExTdzZaNCtvcEY1cWxHS1VVNHVaZkhyc1VNbkNIeU1wcktXNWtC?=
 =?utf-8?B?cVlLV2UzZmlHN1FoU09EOWJWT1duNG1OTTY2TjAyWllRci9GV3g3ZlNHSDBu?=
 =?utf-8?B?Si9NTjZvamtxdmY0RjNNQWdyamNrNG55L2llSXo4bDdPeC9aSC9vOUFKYjhR?=
 =?utf-8?B?cngvRzJ4ZTJqM3cvbDVhb1hVTGFlNGFHYkpsblpIOVZjaVFkNG40bjVqS1dj?=
 =?utf-8?B?VHcxMm5iZjJSZGovd2srOG0zZ1JoaEk4cHdjMFZBQmZUaEE1bVc2WWlmR2dQ?=
 =?utf-8?B?SnpNeGsxbVRDSzJmVU1KV0hZQkdPREk4bURZZXpqeEIzcEY2bjZHWnJqMWxG?=
 =?utf-8?B?YVNqWFpUQmo3UDhwV1BCVFFqWU1INlMrOFdsTmZLSnc1OWxkeHU4TjROc1l5?=
 =?utf-8?B?WHlkM2ZRVUpyZVlOeFlpaXNkSnV6SXVCZ2h1MXU0SzU3a3R5YVNpZUFCWEVN?=
 =?utf-8?B?bmlVUmtoTDR2bnZrSFNTTXdPTkVPSFdRbmR1MU9vSzFRZnEzRm5wSjBIWk9W?=
 =?utf-8?B?Q1VrNjRvckxvOTZ4MjVoSkZiRVEvVEozWk93OGIzYmZFNXNkbGhoSjNycnBC?=
 =?utf-8?B?eXp3MDdLSkc2NmNYNzIrZTFIWlhrMnVzNldMOXV0WlQvVWljZVZzUUJxY1VS?=
 =?utf-8?B?SHAxSWQ4bENtUlRiS0VrZWozbXpzeTIramIrSlhQZlBDNUR3T2VUT1dMZ041?=
 =?utf-8?B?WTBVVElkRlYwb3Bqc1doY0c3UENxZldKbWMxRUgxWEdWZ2FXdzNHa3J5UE5G?=
 =?utf-8?B?SHRXUkxpYkh2VkREUDVrRXJIVFRHTWVRL3NGbStMNENmL3U5cmtYU3J2STda?=
 =?utf-8?B?bkVMK1ZSVGhHLzJMUlA4N1FLVTA4KzJ3STU3TFFPOUlBdHhWNGcvdkhOa3lS?=
 =?utf-8?B?Y0w3UE9aSnIvZks1bHlzSW5aMXhQdFNoaU9LUy9FYng2OE8ydzJ1L2tIWVlU?=
 =?utf-8?B?bW5qTmplbXRBbWlqVDlxaTlCb2Z5cm9ieE9qejFDeVlKL002aVdoMjYvNVlW?=
 =?utf-8?Q?LSPIBc8+gfRldBIkq3KngWkl5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3A5UO5jWIZKbkoLA/wMUkFJO7K6qgeCW5OJlE3BStjKgNTwNvKv3onQa6hSDrHJ8271nhisAPIYoeP8zqlEUYvklcFp0gm2Zxkr1GxRtFInhErvOrWOqCH/g7g07Em866XeQCfHNTOWfBkbWzOrXCKbGLrGqLXkoAePaFvtMqZ8orvEq7ZG8Mm60VCMv+2OZONLKVAH5gQ1YGojV6iAtC+Bqv3J/3W1S/SvHY9XFBikjHxYyk8vzexz8eJH2Wsztw4HV0BI6b4xD731ubImpy+wu2sK45h7iDDGFHG3qz6WdSYHeofWqpfj7ehGz2rkTi3SXZFkL34jNXBlw6oEv3E6Ka10Kbxw9zURF+es+3keWMft6Sl74/EWqH59nOcqaDrOTdxF+WzlAYhWGILJRYe7oiZ0r1uUQPHc7M+zyaxfR8hlHdtMwXSLLd3CKrY45mIJWIMBn9lc+D+ape/1EElqssdIPZbBvjF8wMstNHeBMcd9pY3MxRCoN1ByGdB40Cz/8FcqhFcED7qKgjsdjLnjQl4xbCi0LUHH6rIZ6W7kXqSw0AkbnNxdyGxf/fT0SKhcT8flX3FGWiNN2TCNK2YfeNVhxnxoClIflXZ6xJiQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b80ab49-5bdf-4939-280f-08dcd8eee76f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 21:06:17.7712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C+fyZ9gX/cMrA6qYx423vNeYANWXYaO3US1lMbct51NVp9mT5JdOYNBWiITgJHvmblus2sUIeR6nUup9mU4/+DMK08vYTnBDBf+nwWFWC3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8123
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-19_19,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409190139
X-Proofpoint-GUID: bqOuStu8Cob_VFZZc2EF1EXsYblZdvvA
X-Proofpoint-ORIG-GUID: bqOuStu8Cob_VFZZc2EF1EXsYblZdvvA

On 9/19/2024 4:11 AM, David Hildenbrand wrote:
> On 18.09.24 16:51, Steven Sistare wrote:
>> On 9/17/2024 8:25 AM, David Hildenbrand wrote:
>>> On 14.09.24 15:19, Steven Sistare wrote:
>>>> cc'ing linux-mm for review of this one patch of the series.
>>>>
>>>> This proposes a new KAPI function repin_folio_unhugely(), for use in this
>>>> patch of the iommu_ioas_map_file series:
>>>>
>>>>      iommufd: IOMMU_IOAS_MAP_FILE implementation
>>>>      https://lore.kernel.org/linux-iommu/1726319158-283074-7-git-send-email-steven.sistare@oracle.com
>>>>
>>>> - Steve
>>>>
>>>> On 9/14/2024 9:05 AM, Steve Sistare wrote:
>>>>> Export a function that repins a huge-page folio at small-page granularity.
>>>>> This allows any range of small pages within the folio to be unpinned later.
>>>>> For example, pages pinned via memfd_pin_folios and modified by
>>>>> repin_folio_unhugely could be unpinned via unpin_user_page(s).
>>>>>
>>>>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>>> ---
>>>>>     include/linux/mm.h |  1 +
>>>>>     mm/gup.c           | 18 ++++++++++++++++++
>>>>>     2 files changed, 19 insertions(+)
>>>>>
>>>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>>>> index 1470736..ba8344f 100644
>>>>> --- a/include/linux/mm.h
>>>>> +++ b/include/linux/mm.h
>>>>> @@ -2514,6 +2514,7 @@ long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
>>>>>     long memfd_pin_folios(struct file *memfd, loff_t start, loff_t end,
>>>>>                   struct folio **folios, unsigned int max_folios,
>>>>>                   pgoff_t *offset);
>>>>> +void repin_folio_unhugely(struct folio *folio, unsigned long npin);
>>>>>     int get_user_pages_fast(unsigned long start, int nr_pages,
>>>>>                 unsigned int gup_flags, struct page **pages);
>>>>> diff --git a/mm/gup.c b/mm/gup.c
>>>>> index 947881ff..f8f3f2a 100644
>>>>> --- a/mm/gup.c
>>>>> +++ b/mm/gup.c
>>>>> @@ -3720,3 +3720,21 @@ long memfd_pin_folios(struct file *memfd, loff_t start, loff_t end,
>>>>>         return ret;
>>>>>     }
>>>>>     EXPORT_SYMBOL_GPL(memfd_pin_folios);
>>>>> +
>>>>> +/**
>>>>> + * repin_folio_unhugely() - repin a folio at small page granularity
>>>>> + * @folio: the folio to repin
>>>>> + * @npin:  the number of pages pinned in the folio
>>>>> + *
>>>>> + * Given a huge page folio that is already pinned, and the number of small
>>>
>>> s/huge page folio/large folio/
>>>
>>>>> + * pages that are pinned in it, adjust the pincount to reflect small-page
>>>>> + * granularity.  Each small page can later be unpinned individually.
>>>>> + */
>>>>> +void repin_folio_unhugely(struct folio *folio, unsigned long npin)
>>>>> +{
>>>>> +    if (!folio_test_large(folio) || is_huge_zero_folio(folio) || npin == 1)
>>>
>>> Why not the huge zero folio? That looks very odd here.
>>
>> The zero page is treated specially here and elsewhere, it can never be deleted so
>> reference fiddling is skipped.
> 
> Please point me in mm/gup.c at that handling.
> 
> IIRC is_zero_folio() does *not* include the huge zero page.
> 
> Yes, we should likely be special-casing the huge zeropage in mm/gup.c, but it's not that easy because PINs can outlive MMs ... so *not* grabbing a reference could currently be harmful.
> 
> But that has do be changed consistently, not with doing things here different compared to other gup.c functions.

folios_put() -> folios_put_refs() -> is_huge_zero_folio()

I will run some tests with huge zero folios to verify the ref and pin
counts behave correctly.

>>>>> +        return;
>>>>> +    atomic_add(npin - 1, &folio->_refcount);
>>>>> +    atomic_add(npin - 1, &folio->_pincount);
>>>>> +}
>>>>> +EXPORT_SYMBOL_GPL(repin_folio_unhugely);
>>>
>>> Can we ... find a better name? For example, it's "large" folio not "huge"...
>>>
>>> And repin is really misleading. We are simply adding more pins to an already pinned one ...
>>
>> Jason suggests a better name in the other thread.
> 
> I would prefer something that simply adds more pins to an already pinned folio. Much easier to get.

How about folio_add_pins()?

- Steve
