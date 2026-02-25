Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012063.outbound.protection.outlook.com [52.103.66.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B49277007
	for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 08:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772009168; cv=fail; b=dFcILnDgGc8Klj6qcDvAlnHbZ/n4ISa6ZyoOP/QLdHiDHz38XtcFHfr9OluUGc7ig0K9g7CNySkPAkvCmnb1MULhV4Ccq+BYFIPPC87ABwRhndy5XD1jNv/j5R9AGk6qb22p8+xlviQMvX4LmzRk4LXhIajX+QYM37dtyN1OSn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772009168; c=relaxed/simple;
	bh=kwEmDK9Z415OvoagePdCs+s+TVxlJW1/tUazUNmcZkc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lY0DB+Jhoo093+WNULdFmKDMvoQaewVHZ7273ykEd8k9XT7qtr5hsWVRyAc0J3gTM376PKIvU3Z8F+hMl4Mci4O5qGqe7sGk3GOl1Yxaqg41oPDubFPCyuCPoRmvdlH8t+k7Q2fq60cDXT+wrRDqaQN5Scx0DO5Hp0EvyuQTNhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=V09S0OqG; arc=fail smtp.client-ip=52.103.66.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="V09S0OqG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S5UXkMySMRNKbzXe5tz4yBTtPdhkhmd4+F9ySZQAMCMi0tKiT2D4rpuWryzVwwEK4vKnK80sHFbAwtKwMiWA9G42DPW0vsV07n9uq1x3Qb6vSnDCAqpeG1oJ7hEsnVSc+andkBD2mt6cxXe61L5bzBcHiiAVVV2n+leL/MxCcNV/NIJzg3ihmuEH4xnGyvAOz0Ws5aU8DUZ5SzuF05PXIC32fcdrvBlV3Z7CgiREpQwroljpxoIosZvOBf7PJvWK+B5ZNk9XIxFQbDbe1Au9Cvs19Xcbum6tfzCVXeOKpayav2PN+XDyJUGZCJYbZ80gsHmbwACenjXAm7ZJmwAvTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bKmYU0c0Q3+TqUEwMsVxf0VBg7lJcMGWpt0Z9eGytn8=;
 b=MLOa/G26SN6Sh5jcwc5CU5d/EIBoprfwOo+AepFPCsN/jtc6bFcFzIhY0IHw+9YPZT0mVwyuoNfeBfnuktW0SNPzn9tPNVZWNF6QHQwGvbHIhTnrmiw5Qs4JLvTRhjV1JhkyTt6TuXXQxhk9HrdoSXZ8WQlTmbrvLGf22N8MZH2mxe1yBw3ZcsBCEj7TgYQWYDvU/W1IeiI1HKXc46KYBXGpr0+81+tAIP8FE6h9pqpmjosQrNimxJZ9rUShCeJGPwx4ExhfB4qWEVwFkoRnPpbO+/gCaSfYbWS6KK1zxrdS0iObqe+VFu9RfdRGBOwcOQ068G3rfSzhv7SX0LU3sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKmYU0c0Q3+TqUEwMsVxf0VBg7lJcMGWpt0Z9eGytn8=;
 b=V09S0OqG/HfS1wBjcf9S6Yvd77f7TYqiH74SCp2q8jhtwJQn8+xXY8lzZOua9/Dq32Jdz+kZK3nxiLXCfJYv+DAmXO+WT70wV+URFLcbmbQITBPEotqWsaZ9+5hUhkawnNdS0+uaC+gOcQAaPJ1oq670WhkI2wfntHSN3ICY/PUfsKyaS/WMLlxuW7oax9S7N0phFt61g/E3+BS80z7CO/wByfcJTcxIkcIFCb99Y6GBC8QRmbf/7WVWD/r7IvI8mgJimfs2cllayDBChjGT2IQEejSGydmnuMCyPaDSmToXYXo/4S3paVUV5nup7dBWHErnconmkV38WjeP/RY1sw==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEZPR01MB6008.apcprd01.prod.exchangelabs.com
 (2603:1096:101:221::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 08:46:02 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.20.9632.010; Wed, 25 Feb 2026
 08:46:01 +0000
Message-ID:
 <SI2PR01MB4393798BDE4F80A0B4B07A1CDC75A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Date: Wed, 25 Feb 2026 16:45:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] vfio/type1: Set IOMMU_MMIO in dma->prot for
 MMIO-backed addresses
To: jgg@nvidia.com, kevin.tian@intel.com, alex@shazbot.org, joro@8bytes.org,
 thomas.lendacky@amd.com, vasant.hegde@amd.com,
 suravee.suthikulpanit@amd.com, aik@amd.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <SI2PR01MB4393C9B731ABDA050A336166DC88A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB4393E7518DD5EB5839AD136DDC88A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Language: en-US
From: Wei Wang <wei.w.wang@hotmail.com>
In-Reply-To: <SI2PR01MB4393E7518DD5EB5839AD136DDC88A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0036.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:7::8)
 To SI2PR01MB4393.apcprd01.prod.exchangelabs.com (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <0b44f257-01c8-4729-8c13-836f7ccd12b2@hotmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEZPR01MB6008:EE_
X-MS-Office365-Filtering-Correlation-Id: 29b1bcce-41bf-4763-7696-08de744a4d4a
X-MS-Exchange-SLBlob-MailProps:
	qdrM8TqeFBv5zL3Pq3ogIg0sNnRYStpoMQ4oDPIOV2XGUJTwK2CmvBslkEzOZ8eEOMFoE0iDsYg1AKpUH0TwVuhJXgI8MPkKFjqF7gc9MR9M5M6nIIsz4SmzuwEzfpvRJg+LgVm+HaLQOGmpocRRcitiSWYYJXDCqiy+ZaAz+YdB6vXubffYBo821F4JI3LMLyjgLt/CTN8gpqarKwOXUnsis7N2P+7PnP7Itpidhn2YaGZh/uEzKVMkADVjNLDz5q2anMyCTICN6mlgR43c5WzwAG8l5jtXezsAzvVfkBQjkYiNVn/EzCN+zzq0R6hVqpyN+mJWBRanXpJboHHJC+ck95lP1zIrL80KtqhfbhHkJix5PkGqMmjo5aWgXIot+c73TDuWBqWNvAYYIJ/sQIzFLsv/w3q7EbrJzKfl2HvNXB9cpV/4OkeaMIYTzYQmUiYYXOHMnAPxKinbQUnerL8teNe0VXd0jJtv4Z5B62eiMEBqRDaUvwJrW4KkWsrr01ZwGVORfANZVtVPdfo1r+nW8nhSKrckqDySgfxxwCivwr2vXZQgbyf9eOWijINNuXMerrB1JSfSayJrxv4kPKqJYatqLKvnCkxRKNPsK+jNC1MmsBaAeECLutDlLEFOgNP0LE0n0d8DOWmTkfBGUFv8E2rQnl8opxc7oxcpvnELXrhha3BsOCFqsP0/J8xDPptcMNjgOAR8qeKCfUAHlq4pPoL5aG0UqoTuou0qEkgQD6ALsUD8qL0WyzhAAqyXHcjQ6gfFWlHtEDjpupUNEDX+5DPEyvsu
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|37102599003|461199028|51005399006|12121999013|23021999003|41001999006|15080799012|8060799015|5072599009|19110799012|13041999003|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SG5vamQvVmMya1dEZUc0emdURitsNGRubzNTRWt4dlI2VVVONmg4emtVUzZt?=
 =?utf-8?B?SHNnSUhhOW5hTzhFRVBuQTUwSi82eGZUcnFTMVZZUXVSRHc0ZFlXUmNuREts?=
 =?utf-8?B?WS96TDFyMVhOTmdMMzZxYmM5VkRlMlRDUWpVU1BUWktNNW1MU3FBRy9FZEsx?=
 =?utf-8?B?U1VkdWRJZDNGVXcwbkFGaXYvRlgvYndxcWpJVytmL2dkaFl6NnRTb3RWUUl4?=
 =?utf-8?B?VUtxSS9GVGlkYnhEbGNFSmEzbUR6Yjl2ckx0aUx4V3NsUkE2V0dodG52ZDhj?=
 =?utf-8?B?NGMySGhkWFFvSHBxMU9jWEdseDdManhPNjdGdUxDdVNZVEIzMFFnQVZDVDNI?=
 =?utf-8?B?Zk9rTVdaOHJNSDNpUlF3Mk5XUEw5YlNEOGJPY080K3BvM2hRMVowdE03Y1Z1?=
 =?utf-8?B?Q3RjRjdMTXNpejZJcnJ2MldWdW9nOXc2NTJzODk2aXM3RGk1dU9reUE0RllS?=
 =?utf-8?B?YkJ3ajRKdzJWVVh0cG5QVTNpVERSTjFuUXJRREo0WjNpSHNwZDdDMGkvMFNo?=
 =?utf-8?B?YVhWaEFyOFJjWnBBVG9rZ0pHd3ZKVEdPcTg0WVg2VkZmeWpjY1NkTTRQSG1k?=
 =?utf-8?B?dy9TazIzZi9IV0REb1BjT2VQamhFNHpoMlBkSkp0K3V4d3l2VlB4ZytIRTBZ?=
 =?utf-8?B?VUxjMEFPVVh0MVAyUUJjNkxkMXlKaWlNcmhaL0ZXMU50L0YwK1NYeUh2azdq?=
 =?utf-8?B?MHpGSlBYRUV1Qzg2UDdrMmVMSHNheFBOdUdNTmFER2tTNjg0Nm1CN1kybEFO?=
 =?utf-8?B?VDBpSlRtQ3FKRG8xc0ZKaU1aT0x2L1pqRUxuZkxieDV3eEJXODloekE0RDBF?=
 =?utf-8?B?WWd4c3RURDNyVXZWL082WmtVSmVuVzVlNVFUWU5yaTRrYTBiSnEzTTZJVnVG?=
 =?utf-8?B?UEpaZUJYeTZsdXc1WjFaTGY3TWpPQVdtRWhqeWdhWVVXUHMyYTlERDZXY085?=
 =?utf-8?B?eWJMb1IzQndaUVI1NVJtVnBUa1VMNTVYM2VtNmJzb3d0RFVCcHE3SWZKOHNW?=
 =?utf-8?B?RndOemt3dzZuK3lTWUM0U1cwUnp0dzE1ZFp5SUJBeVYwS1lBNmQyNGFHcm9Q?=
 =?utf-8?B?SngzaVdmKzRDbEJnUTAvY0Z0a1FPcTI2MEtUS1JzcWNYc0M2bXFnQXBRTjIz?=
 =?utf-8?B?WDIvZFkxRnFNdE9udmkxTlVzK3FxQU9HbUdnanZHaDNBSmhOMDE2OHhWbFht?=
 =?utf-8?B?NS9FM2t0SHU4dlZFSkZaQkJYZGRmd0c1c2lGcDlZL3hWdzhNeFA4RmwybDNi?=
 =?utf-8?B?WVh3U2pML1ZTc2QzT3VhYUtkTkRVanFyRUZXYVVJTkRGa3VadDlCZW5NSGR0?=
 =?utf-8?B?eWRjQlFlNkR0Vm5vL3k3YzdzbXZueHJ6bmFMTnZDQkUzeERGVVp0MlJYeDJ2?=
 =?utf-8?B?VzhLRUU5U2ZmWGhoNlcvQmhNeDBUV1VKSWJrWTJXbWd4NWc4OEJScHo3TENz?=
 =?utf-8?Q?l5BSW1RM?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ak55bHFsbkNsSEJaYkd4dFUrQytPUjh4OU84YU5SaG1vK2lZQmtrcmluMEtU?=
 =?utf-8?B?Qjl3WG1jZjN5WStOZkZEZXA3MTVkblN5eFE0V0dKT211Z043dTkwSkFNMUwz?=
 =?utf-8?B?czBsWHMrcHVBbHprb0RCK1lyenM0MDdpVzgyZEhNeFVZNE56U3FpSjBEMGRw?=
 =?utf-8?B?cW1jSjJiOWRKSDVmODF3ekJydzdCWXNOMmJBOGVXY3lpeWhLMVFRZHAybnJE?=
 =?utf-8?B?ekNKamkyUXRKMnNlQWxOQ3hIL2Y3UHQzeVozYnFyV09qYmR2WWtScy9zWHBv?=
 =?utf-8?B?cWJkZzlpMDFRc2hacEFtUnFzMk8wUVdVaFdQNENyZjNnU2E0dzhuTjJ0cWZo?=
 =?utf-8?B?aEFUSjdLWUxxYUkvTTlwRUprRnp3d3E3ai91bkh5a1phTnZHb0o3Y1N3bm8x?=
 =?utf-8?B?LzhFb2xLSlVtazhZUjdEem9mOU1JUUpmSU5iZXplZ3NOLzdOdzFFdEtpckhQ?=
 =?utf-8?B?TmE0TVBrL0daaEYrSFlVWTc0cUluVmI2ZGM4eVdhc1ByVXdGemp0T2FsNDlX?=
 =?utf-8?B?VkR5Rmw1cFltV2NjRXRQdXFtRnZYSWcvT2VicFVsK2ltc2FhbVZZelUrZW5B?=
 =?utf-8?B?T0NTSjRnSXJJVDNhVHJVMWRDVFo4SGc3L2JjeWhPRjhDaE5XZVIzWlp1NWxU?=
 =?utf-8?B?anRnWmtkRnRiTmVwMys4dEd2dzhGT3Y3ZTRReGpOQ1FGNENJUzZyZ0dJeDVM?=
 =?utf-8?B?b0xzQkh2eUVFK1BKSnNSQ1NoSkRLUmkvajlxUmRud0pabUEvd2xoU29RS25a?=
 =?utf-8?B?ZW9rejRHTE5pT21oS0ErcTZhb281TEYyYW9BaklKa3E4WmdwWlpKWHdYZmpW?=
 =?utf-8?B?Wmd3YytUNnF2NkdKNS9jYU9Vd1NFQ2ZhT2VYYXVUeUZkZXNHWCswTEhvMWJV?=
 =?utf-8?B?TDFlUk92TVEzblJMTEFZWkFoYUdneUpTMEVDVFk0NEJteHo4eUF2ZlZZUjR1?=
 =?utf-8?B?eWZ6dWhwNUN6bWZyYU1Td3crU0tMVTlRZjhVL0xIVjRxTFI0NG9VenBzT3RV?=
 =?utf-8?B?YTVWcDZFVEhTNWFZVU1tMXMwQzhCdkpoMHUrRVFjMTMxT1FGMnFyOUNFcFBi?=
 =?utf-8?B?OXVrTGVCYlZxdmNWQk8wSG4wRGx1T2FKVXJ6ZnNqMVhZcEtEU1hzTlF2STZT?=
 =?utf-8?B?QzhhOVBCckp0UXA3OXNIVk1KcjgvRnpmMjVjem11SzBNVUVnRVE1K3dGK1RU?=
 =?utf-8?B?WFRTb00wNlVtcEQvaHhKbVJJMUNuUmFVL3cxNHcxZ2VLNEZ3MlYwdFhaaWNU?=
 =?utf-8?B?elM3dzJrSDAvbWJKS0MreUtCUXhqUFFuSTFTQWZ6UnMrVk50aWx3OFlVVkxP?=
 =?utf-8?B?SHpIYVJ5M2hyRjZkUnMveThzdU5vb3E5NzNEb3pheHZIc1JpbFhnaFI4M3gw?=
 =?utf-8?B?MWNRWFE1VXVmRmVudVdPREFGVmlRRGVaODdQN2IxOVNKMitlTmxtTWppMkdt?=
 =?utf-8?B?ejk2V3QzRnVZbzQ5QlRoUmxlZG9tdEVocmREbU53T2pWc0lYcC9NbzFNZkpk?=
 =?utf-8?B?dW9OUm1rUW4vRmZNNUdoYzdhMTNERnAvcjZ4NGpJRFh0QXVLcFRFblJhcCtB?=
 =?utf-8?B?REpyMFB6ckk5Y3YydGtVTVZaaDdXMEZNTUNMRzgwamlQMXF4QWRaTCsxR0xv?=
 =?utf-8?B?ZXloT1phMU1MNHBydVVRdURvN05HVDZhTUFaTVlMQkFNUmlzZ0txcG9NZGNq?=
 =?utf-8?B?Z2g0M0c1Sk9jMHY1eDhWeFMrdGJsNmdBRSt5eXpXVUNkRTRCK2cvWTZBL0dR?=
 =?utf-8?B?S2JwZDlRN2xCS2htcW16QmpibmsxMDV2alFGenI5Y1dkOXlwOWVEWlg4aVF4?=
 =?utf-8?B?a2dFRXRCU0wxSXlqR0V2Yi9Id09nWTYvZWNyeitwWUJJbG0yczJIekN2UTRU?=
 =?utf-8?Q?fPvdG3DFyYStl?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b1bcce-41bf-4763-7696-08de744a4d4a
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 08:46:01.7967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB6008

On 1/26/26 3:19 AM, Wei Wang wrote:
> Before requesting the IOMMU driver to map an IOVA to a physical address,
> set the IOMMU_MMIO flag in dma->prot when the physical address corresponds
> to MMIO. This allows the IOMMU driver to handle MMIO mappings specially.
> For example, on AMD CPUs with SME enabled, the IOMMU driver avoids setting
> the C-bit if iommu_map() is called with IOMMU_MMIO set in prot. This
> prevents issues with PCIe P2P communication when IOVA is used.
> 
> Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> ---
>   drivers/vfio/vfio_iommu_type1.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
Hi Alex W,

The first patch in this series (the IOMMU part) has been merged and 
queued for stable. I haven’t seen further comments on the VFIO patch,
so I wanted to check whether you have any feedback or concerns about
it. Thanks.
