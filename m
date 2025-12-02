Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A834A2F6160
	for <iommu@lists.linux.dev>; Tue,  2 Dec 2025 15:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764690563; cv=fail; b=lHLkktMHZhsnAKyjA8vQQmyF778YGKDkgPFy6Z4go50FGSmIf5Ep4ekZ/x+vTQjl6XHkhd/fBy9PYQVCyIoWG9lrginlMzgGE82UBa9MFk9H3HrHiMbitFB3X3z5rL4TSIXYcKPkmJ2cZ+7KBfSJ/D5/pSvP86wbvQqOBk/f+0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764690563; c=relaxed/simple;
	bh=Bgpw/mPg8lFF6EvoOcv3Ys3TmuieL7B1PiRxyt0ePy8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JIqOzGmY6NDHuyPH4KfJ6RzC0wfwz5Jxq7N0lbFA4vinxdr44CXQhCOuMoaIha+vMUgATup1tyfj6BK2ue6ywP82lTrkvQgYhMrbqOauBu7aPF4BG68Pj5sLnmJX25ek1f8iSHVhCk6tOqmLMWgH7IsnM5yDBV3fAkQowUEF3Y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ti6R8sCU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=t/nidHtH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ti6R8sCU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="t/nidHtH"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B2ENpDk438290;
	Tue, 2 Dec 2025 15:49:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=KG79jsSHzJSqhxHYRD3i5X/eD3O2mMgaUFYbV284R3E=; b=
	Ti6R8sCUMQpBsor3BexbSv5wXy4whD5TKZlI92V/V5j8ZDSOPfa4Am0p8QC1pGB4
	GwKeZBLe7QEO+UEV84W7bnYoqddiv5Q10l4WHThHTLrjntWCH6WJ4S+gn25idSlM
	/A8PvkIrXNtMBsJwXOTqHZF5Tf9zqv3CNiaObJEp8JYyolpEdfe0BQgI+7wYfj9g
	rfc4yaWsXeGDyzzswGZzohsqcZ2Xx9O1Y8fnlALTY0KTEqYCC821uW2ZDiP2ngkn
	AQPAqUWcHhXCZIaavLrLLHUbckVbOL+rmNSEEemzZ29ksseXZu3z+GQ2yqZcGWsn
	DXvWYP59QWzrJmSZhobZig==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4as845u5w2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Dec 2025 15:49:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5B2FIbwV016477;
	Tue, 2 Dec 2025 15:49:16 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010035.outbound.protection.outlook.com [52.101.85.35])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aqq999a5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Dec 2025 15:49:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mrmGku0HXWPDptUVyaDAZ5IpDIglyQChBeurZlXwYpivt0l1DlXVPx6/PNuNysH9LvzJt54pghE5uIJi3Z38oipjeT8eJTznIUELjNGxd8uiGL5GBfvIdnuVQbv5bBTmHg+kHLTS3ANvL2+b6XPZwR16LjbzWSj8QtJ+Ri2w3ZgjIVt4o54PRBLQqxG/Kz8EbietL5oeC0ccQghXWC7oE18kuVYMSu5j5EflSJ/wl0H3Sd0XrqxdTQRtF5GWYjqUauF1/66+hM4OOJjbPM5YPlXJA3GW/2f14zr9kZR979hniwupuwVQKXqjkx7syaoFAzai/N9ZcSEM/ZUAFGVNOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KG79jsSHzJSqhxHYRD3i5X/eD3O2mMgaUFYbV284R3E=;
 b=UNLoAbJHYcqD7r7JZeqDw9ndvvVWIdOj/AE93haaVGvIkRvjzL4+DaOkOBkvZK4gd49Tnzbq1y3PZ98NF5AvuiDD8ISkmCKviHq7AN3Dd4SX+1XFx7HbQB2DQ+AdzqY5V9Om2s3q36vDUdKS7fFC34ZRyya1P6FJYZKAvxHZa4E3XMF9y3ycuTqOC6Q7QPk+CUdGvDnL0UmfnYRIt5D+0hpOgplez/nL0Qp21jvgHDcYq2b6XuQDP1sHjgVSOGctYerWJsN8rKN5xpeUYE5KCdKG6DgrwDymCqn6CXoo3CipvaKE42QjAdZCOBw8CrfAndUZkLB6rPLEaZm8CPHk5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KG79jsSHzJSqhxHYRD3i5X/eD3O2mMgaUFYbV284R3E=;
 b=t/nidHtH262H5Gs0LaWi87C4ZqEX+2PZqNQfn1x1cKZfOPFn8+/cAFTqsmzWaI1JBd0ZFJJq8nE5N6X4zTBW9WL/dlK2T7lTzT92s/muZaSXOIBhrBM39Ze3TmsOi2BHUMkZB7QfWpYtwYGyf0AHUv/+0ZOpah2jISZO7odz7z8=
Received: from IA1PR10MB8212.namprd10.prod.outlook.com (2603:10b6:208:463::20)
 by CH3PR10MB7701.namprd10.prod.outlook.com (2603:10b6:610:1a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 2 Dec
 2025 15:49:14 +0000
Received: from IA1PR10MB8212.namprd10.prod.outlook.com
 ([fe80::ee8a:bd21:f1cb:c79a]) by IA1PR10MB8212.namprd10.prod.outlook.com
 ([fe80::ee8a:bd21:f1cb:c79a%3]) with mapi id 15.20.9388.003; Tue, 2 Dec 2025
 15:49:14 +0000
Message-ID: <15be97c9-b287-4376-9fc1-9d574cb23d82@oracle.com>
Date: Tue, 2 Dec 2025 09:49:07 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma/pool: eliminate alloc_pages warning in
 atomic_pool_expand
To: Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20251202152810.142370-1-dave.kleikamp@oracle.com>
 <8b72d722-5e68-404b-bcb0-04b7daa2a24d@arm.com>
Content-Language: en-US
From: Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <8b72d722-5e68-404b-bcb0-04b7daa2a24d@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0090.namprd03.prod.outlook.com
 (2603:10b6:610:cc::35) To IA1PR10MB8212.namprd10.prod.outlook.com
 (2603:10b6:208:463::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB8212:EE_|CH3PR10MB7701:EE_
X-MS-Office365-Filtering-Correlation-Id: d816659e-378d-4ccf-2b54-08de31ba5810
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emVkckY4RWlUS25EQmduenVXY2lUMEdERUFuZ2QxT0ZxODRMZ3V3OGtTcHYy?=
 =?utf-8?B?Y25KS2tUYjJoeGgrV1p1MXYzWVk2bDJ4eG5VYmR1dDJGRU5uRzRCc0JNdkQ1?=
 =?utf-8?B?SlBZWHB6Vyt3eWJXQ1htQ3NoTXdCNkN2YTBXemNlWFBHOW96UXlXalArRC9x?=
 =?utf-8?B?OFRpTlFaTzlpWDh4YTZnVG9pUkoyMjhxVnB5OU1PS3ErUE81bWhVMUhXNjc4?=
 =?utf-8?B?UGhEV3ZPTjZGczBHMjJOa0R5QTA2VEMrbVVEZFBDejkzN0xZN3R4M29zV3FL?=
 =?utf-8?B?U29qcnFYUE1Ma3pYRzdyRFZRNU0zVmJTNFVqcGw2U3VVdmdqTndVSkpHR2tY?=
 =?utf-8?B?MjFsSTErQllkNFM3SGl3TGFuWFJSbFJQK2hUM3h1N24rYzhZMFdLdWExM3dG?=
 =?utf-8?B?YkNRVTRNWW5mNnNVNDJSd1RGWDREamRvQzlsUk9JMk9VM3ZvY29pdDhVS2tR?=
 =?utf-8?B?MFlPZ0wrTFJ1WTY2Z0g1alZuTkZOR0diY2d3TnFha0kzdEdzRGhIbXQvdGVE?=
 =?utf-8?B?Mk4ySG8vUHh6MDlyRDhUbzRWanY0TlJyTGt0ZlpoTzRMQ2FRY3FrWThFUENM?=
 =?utf-8?B?WDJaeEY3UjFFU0NLT0VwSVRTWjNmcHJzSkY5L3lseUN5MC9kNTBOcklnazBo?=
 =?utf-8?B?WFF3a2FSYlcxR0NDYlZuSEF5NTZjbjUyeitERFJoRmNndHBid0JQdkl6dDZ2?=
 =?utf-8?B?dk5Kd0dPOGlLckFneE1tRFJ4WUZjN3dVMHI0MXgwekw0NUhsb2Z1ZFNMbEF3?=
 =?utf-8?B?cVVSaW02WkFXR0tLbXd4UWo3MDczL1ViT1Z6M0hOTUlZVjBETzZFTWRKWHZ0?=
 =?utf-8?B?aDdwWUs1dmpVd1pzMVk1ckFpOUhXYWlyQ0hUMXVGZ2ljSjJRUHRBVnFuSlV4?=
 =?utf-8?B?RWxmeGcvaXBiV2FHb3VaSWEvd1RKbUw1UDMzY0N6Z25sRVJ2R2RrbjNuTUh4?=
 =?utf-8?B?cktwVWF6MkNMWWtmamlQNkJLTUhoa3ZCN093Qk92dytoZk83RXFmaCtjWDhZ?=
 =?utf-8?B?dUFWOWZqVlJJZkFzTmFLaUs0TXhGcWxxbVdTbk1TVXNsSzBxQ1dxOFp3cDhI?=
 =?utf-8?B?eWhwL3FDRlVObElMLyt5VEdkS3hHbExscTlZY3Z3NmtYVkdSY0EvcWZ2UHUy?=
 =?utf-8?B?NDFGNVR3MGF3Z1JYOThVSEc2anNhWW5GOWpRakFRZ2JtMFVlOVhpblpBNGVr?=
 =?utf-8?B?ck94WUFLaWptL3U4VEpRdHJTVUVQQWx0RUFXdWJkTGxjVnhIQS9xWUg5cE4z?=
 =?utf-8?B?d0Z0NlUrbytxeStPRXNRZW1tdHM2RjNYdDkycE05aFJxcGdNQlNzTmplM2Jx?=
 =?utf-8?B?QUhRK1NkODNrMTlRWkFaaUI5eW84d1ZqNmI2SjAvTU1CQjR5cnc0QkVMVGYw?=
 =?utf-8?B?V0dZWVlDSS9tbDVZYUMvcjd3L21nVkFCSzA4NEs4dHdZOVJvcTRLT0d0bDgx?=
 =?utf-8?B?dGNaZnNreUdZdDFtMUcwV25iYjltKzlvMC9QbnV2N3BPb3F3Wk4yeTBqelAx?=
 =?utf-8?B?eS83TUQ4d0JMOEpLRE1NdHVzVy9pMWpDOCtJMXBrc3NPeVZKeGMzbk92Sm9I?=
 =?utf-8?B?ZlNmQUIyL25rTEtrWDVqQy9PVUJkSWNkcVpzTXhzbFZMZ1p5M1Q4R0VURGZs?=
 =?utf-8?B?bUdvVjRKQlFIa0VGMTFEdmI3TEtJM0JQazVwVnhITklydWkyUEp1a1RmeFhj?=
 =?utf-8?B?MG1PNFNuNm4yYXgrUTNVb3JQZjlCeWtjV3VTanVYOFNiK2VlU1p1WUs4ckZO?=
 =?utf-8?B?alBiNzlDRFZYSkc2RmZ5bFlaaGZ6aUplY1l0ZzdOSENERml5WEZTOGxHd2Y1?=
 =?utf-8?B?dEdESkVteU16TmMwQXRKTUpQRytjMGhSc1ZNUTNVRjY1VGljcmFTQzgrUVBn?=
 =?utf-8?B?WVplaXF6bG5UQm94UitqOG0vWDlwenpLdG9vQitUU2dTMXo5RUZWQ1JZUmRh?=
 =?utf-8?Q?J2YVZZx6IykqLNi3BnDq4a6L/yakH6kN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB8212.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RU9PNGV3cjluNFVMTmYzOGx1U0oyVDZFQXlSQlNxT0lOMGtoN1l3aGVCd2pi?=
 =?utf-8?B?a2t1aVo3MG1ScjRIMDd2dGxiUmsrVjJLYlBzR1JMbG1ibFpVbGhoTTBtalFZ?=
 =?utf-8?B?UDB0ZVh4a3NiZ09xcHMvMzBVUVlVSXRobjIrZzc1K2Y4cXd4NXNIMDkrT0RE?=
 =?utf-8?B?ejBQNTNOM2J1YUdUVzJIZUtnbFRGWkVGZFRsODViMm42cU54Zy9XYlhOanNj?=
 =?utf-8?B?UjhMeTBCSEw1bE1EZTdNbVBqZmQ1emh5dUU4cllJbEdPRGtaMFU4bm1FcXJC?=
 =?utf-8?B?bGdGODBnL21VdW1QVWxReDI2OE9RL1g4VjJ3akh6Y2pjZExlOFJuZXpENkNV?=
 =?utf-8?B?YitMcVN6MW5vQ0pZUFphSno2WFJGNktzVC9pTDQ2NytJR2VGNmY1UHBBcmNk?=
 =?utf-8?B?OGIxSUZudXFHNmhQUzR6cWs2QU1sWU9oZU94YVQ0dHBMc1hlcHpmTVdwaDJQ?=
 =?utf-8?B?THpkdlRlOXVjSmZxZjlFektGdFJKV0U4SXE3eDBPbDFWZGFjb3JUajVzZHVx?=
 =?utf-8?B?UFFtK1l0RGlFUDV0cXNtcTEyN3BneUlMdzRhaG1ndzNIM29FWHgrdUowd0dE?=
 =?utf-8?B?OHgxNmdvbSt2RWhDUGw2bTVLVnp4emZHSGdkM0hHa0Q1M296eUZuTXJuVFc3?=
 =?utf-8?B?dHU5dU5HcE1lZ0J3S1o3dFEvZVA0WFhkN205TFA0UG4zdXZTcGpXUThkQ3Js?=
 =?utf-8?B?b3NIOUtma1ljK2dLbjhJc3ZIZjZhTTJXU3dyazZJZm9JclRGU0hnTjBiMmNL?=
 =?utf-8?B?WWNLZEo0KzZJcDZKS1Ruck1sOThmbGdPaDZLc1dlbDhCS3NzelFzSEtaMFYv?=
 =?utf-8?B?SW16YUxTbEd0Nm9oS042aWRsZTQ1VUVyM1dXOVFOU1laMnRsMkpuOUVuaWlS?=
 =?utf-8?B?bEVUUWdLMlZVc3QwYjJZTHNOSDV6YXFCcHcwbFNPMjVmejI4aWdZYm8xaDFD?=
 =?utf-8?B?Q1ZLS3RXWFlsOVlrZndMNlpna1Q0ZElKcUZBaGNhcU9MQ1Y5b0hSN0pOL0kr?=
 =?utf-8?B?d1RvQTRmYjhNSlJaRVBkUWRxdFZaYWVtUkhNbkNYMHp3YWNmK2JtQnJMUm5O?=
 =?utf-8?B?aEp2MklVaHZQblJydEZYQS9uOUxVK05qWG16WVVBclFWbE1ReHRKMFRjWXV1?=
 =?utf-8?B?QTJuK3hTMm95RXJ3Y05ieDM1dTNnODUwWWgwelI4Mll5T2NOdkZuL0ltV29J?=
 =?utf-8?B?Q2lwQlV2c3BMa1VqempDcis4TDNhd2kzK1ZYOGxzNHd3ZjVvZE5uNnRENGVR?=
 =?utf-8?B?QURQUU50VnA2QU5YSkZWVXAwN0hWQ2ZDeFM1YlArc21FeFBiQkUycWZCNkFi?=
 =?utf-8?B?dm5qVzFxYStTNnV4dE5QSmIzYVBUeExhM0lRalQvYzNWdUVzbEtWR0J3ZWJS?=
 =?utf-8?B?d2VieWxEWkdGM0xqQkp5ajV5cXNYZnA3WmhzSkM0cFBwdUxIWjJncVFCV0dj?=
 =?utf-8?B?bVVQOGlmR1FWVkFxVXVSbzl3RW5xNjA5b2ZDbzFTSGhjeGZDWUJYVGRSczNk?=
 =?utf-8?B?ZHg1THBMRi96Q0pFTk5UL2pRUHl2K2Q2RjZtdzZWU1BDV0FjalJ0OUpmTHBL?=
 =?utf-8?B?R0I0R0U3WStsRWJocFloeEFHVENIS3REcU9nRnYzNi81N3NwTmhEYURXOFEv?=
 =?utf-8?B?UTRPYlM4dHkyWHA1eDNSeEhLUm1kY2RKYmRndXE2WG1PV1Q1TU5ZM3NETk9Y?=
 =?utf-8?B?UEkwTUdsSzd5S0JJZ2RlbmVyK3ByNFA1TmlRSmp4cSthVGtOVkJjajBUai9Y?=
 =?utf-8?B?eW1rNnRXZ3ByL0Nsb0sva3czZDlVNHFiL1daRml4YlpqNWd3WjdGL2FWdGFY?=
 =?utf-8?B?QlpRdjByVmJjREdsTWJDYVJKSUE2WVQ2Tm1lNWNWdkdJV3ZGNmlWMnJxVkxK?=
 =?utf-8?B?OTZVYmxPUUg3a0JqUUdtZWh6OCtHTTB6b1BzR01nTFNKeko3ODZkNGd2Zm4x?=
 =?utf-8?B?WEMvNnlwM0dDSkJDWlp4NlhXR2MwbExWbnByd1QxWXpFMWVjbEJNa1BCM2d6?=
 =?utf-8?B?UFR3dHdnckhhdzNIczBwV0JWRzdSaThOOXU3UmpsRS9tYzh3ZnJibEVQT2hm?=
 =?utf-8?B?UEF5dTBrUHd1SFpBazhmcUFrN3RLSUx1ekJuV25NWnA1cXh5eXh2c0VPMVdl?=
 =?utf-8?B?WGpWWTl0QjlkRGJ6VjVtQ25HQ1FwYzk4K09OUEh3bzhYaFd1VWdIYThDelMw?=
 =?utf-8?B?ZGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vEudCOVLmH3nkVpJWkKhcNZGSaYNunmw1sfDuQdCivBT7IGNNZzXxoPLNS4s7HiWhtkUxx93MYcJYZBG7zrz1A4LQAYudr5TyKfqCUM2Ch2Y4/bL8CreKB1WKX/2t0IbqezZVXJ4THMT8XGvI7YnGwTgEL47LYEvUpn9cn4JRNePmDpTQCPycAsjKgOWjP43cf+2Fri2D3NvVWEVqnCeB6N7EmHqXVd+AqFr9dp3R+woXt8rV+xDxKSOwwGGMoN/FsPZ5YHjgMP9WDHAcbYcaaUAMUmGFOpHAg4qY6C6/kfAKT6eAsFGXYflHnodypTxGiWdsst4R13/kF65QKr1OY1P2Fr5gYjgehtFlp3Eef0CKJiNz0vNy9IyT12eIBXZLkSFzqNh91g+xZxwdOH4LIDPCbRLIeU92jZN6KzK2DF/puyli4T0u6u7PrUUyPSzlO2GXFapf1DFn7KdnLNFdnq7/YljbiHlcSrmMutR5boX7MsClKWdu7HZCfsKZau+VHuURzxt+0g6ij7N7NGx5cBO5EHtEzYJV2kk1cWY1bDQKAN//5UsM2IguWf078V/cHBJi4kiuXPGQnHkUWI/aOdPcvHcJQUxI3nh7J4WeMU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d816659e-378d-4ccf-2b54-08de31ba5810
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB8212.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 15:49:14.5471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cr2aLqMCso4U29x5PR7iTDXQHRbZsirvJwmbkEJKdZap2M6V3Jt/aSf9lO5MPAD4llsdYoL8SdT82mPvw4RC3w0NEM8IodzFJpMiEhT6QCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7701
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512020127
X-Proofpoint-ORIG-GUID: Dy92u3KBZ_aVmSRXauYESC-MqEveiuPo
X-Proofpoint-GUID: Dy92u3KBZ_aVmSRXauYESC-MqEveiuPo
X-Authority-Analysis: v=2.4 cv=W8w1lBWk c=1 sm=1 tr=0 ts=692f0a7e cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=7CQSdrXTAAAA:8 a=5_iPY1GKw_LI9wnSNTYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAyMDEyNiBTYWx0ZWRfX1hGqZNth3TAv
 N6FvKkfzU++8l1o7T9lCiANIZelN124fdHI+hRvCY9eyaxi0rBQyQnZTEebr4dFq/aQOYO9qPoJ
 tQaqdO5TjMBVUw8HDg2tkkkLgbzt5STFm2lW3M39hf27s15pISw2UwWqI2NkPElmB5IkjW+/ZD3
 +zjRO0x7FbukuNPFjp4QbKJfr1kA/9aSimoWbMxTVyv8ecT/qK/vlhCtIFGCUACoJzMqQIiCC6W
 WwjhEeyyQhp3K9s1Sgu0UG2CF/vt0YNhClZGZoVyhj91J+NNY9KAFhqjr28FWEbBGVe3Ow4OjIc
 poMcusLB+xA5CwmFrn5I6KccoaifjFozakTaDEAoFTLsLw1dno08ZU8AibxraLbP0xHtWtp56fS
 xHvP6Hx1HEW6btqV7OCI7f4ySudkfQ==

On 12/2/25 9:47AM, Robin Murphy wrote:
> On 2025-12-02 3:28 pm, Dave Kleikamp wrote:
>> atomic_pool_expand iterately tries the allocation while decrementing the
> 
> "iteratively"?

Oops.

> 
>> page order. There is no need to issue a warning if an attempted
>> allocation fails.
>>
>> Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
>> ---
>>   kernel/dma/pool.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
>> index ee45dee33d49..26392badc36b 100644
>> --- a/kernel/dma/pool.c
>> +++ b/kernel/dma/pool.c
>> @@ -93,7 +93,7 @@ static int atomic_pool_expand(struct gen_pool *pool, 
>> size_t pool_size,
>>               page = dma_alloc_from_contiguous(NULL, 1 << order,
>>                                order, false);
>>           if (!page)
>> -            page = alloc_pages(gfp, order);
>> +            page = alloc_pages(gfp | __GFP_NOWARN, order);
> 
> Might be nice to keep some kind of warning if we entirely fail all the 
> way down to order 0, although I guess if it matters it would show up via 
> the warning on dma_alloc_from_pool() failure soon enough anyway...
> 
> Either way it certainly makes sense in general;
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Thanks

> 
>>       } while (!page && order-- > 0);
>>       if (!page)
>>           goto out;
> 

