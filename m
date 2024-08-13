Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AED19D076
	for <iommu@lists.linux.dev>; Tue, 13 Aug 2024 14:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723559024; cv=fail; b=X9JMqUI9vQHENUHo6ynElcv7lM0NyqLrml4bk5VC8PMv9hlZnRuh7hm8Kao3Cl2YQS81nimb3T1pcI4ZfvhbRw37XDo8TVLtQ7+c0JvLprKQuvZZBPEcoyeZFkYv5Fx1aNbhbCAT+sqW77mWtY7XgbBai+ronNJjgowYaTt5y94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723559024; c=relaxed/simple;
	bh=RJZng96qjhOneXGmdhn/jfIrl2yd5oU6TKCDCDFDrRk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ThuF2SA8MhO+/XVnRCb2u3Xj9GuhOlXJ6MBbTcZL/EFKtsts52Cc88IbdR3cL53GQ/W3fvtAaKuALNqYacq8+utX+Db0cBPpD31GkCBkH5Y4BhFP2R/i5Dj5CO9Lprmojk2FJTArUWZn1cyTsEDwgDaaSe6gY+Xv/GimE0OO124=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Mx6XLEJV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eYxzB1Uk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Mx6XLEJV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eYxzB1Uk"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47D7twmE009231;
	Tue, 13 Aug 2024 14:23:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=yoSPnt4EcI1qxHrArdlStjaHGIb5it+tYRLlfUX/M5s=; b=
	Mx6XLEJVkvqIJYf9vkqcEKqljI3ug4gkEpZWKU5ZF+Gga10scZRn3CEoDU7A/XAC
	TfhGjwmC36dbPy6zmUVnUy/3231vdxMq5P4aMfUrNsDiOhUOT1YWAaXIUBCwRBAg
	54CY0wUNZCQgqVAOxPQ/6zKAakyfs9GF4blOSu7fps9sFh7iFP60r4atuNYaP+ip
	6AYJUxH5MQVW69Oq41Absp0tcg0bryYjyWJwwBdVUCvH13LK7dqpueKiXgColS7D
	PlkGufm+qzInIBbic4dh723z1SAxptVYjTd9uEbGzuhZPZ/slJp6RkzzKZOH7um3
	iqe5YZrz29TBA6MOQHNufw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wxmcwyhm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 14:23:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47DCnG93000660;
	Tue, 13 Aug 2024 14:23:39 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40wxn8hte0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 14:23:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OjK/j4V36WiKQqigGH+qap5PYhYlukAykudEH0gkjRl2TLGagerZR96q0iX6YaQfAgzRLqX8oAs6UIvJFERiJxqvVxk9siK8svdmKvY6HIXyin/agpeCYR9FlyHjUHVkPqmmEIPXKjTsjeraiwFpMx0qWkfzcOGKHn+zfh1SL+0ahRxKd0xS5sYZWYsy0EgLHwNT93nkzDWK9SgOOgUJfNyL/Zz4iKuCnTnzs0EWHJUB+fz1kShdVqfCuYRbfa2/bNX6tF9nRJZcCPUt5SqD8NmjwJqTOR+iUmUYSplo+alz27FoB6yIfhXD2l0kGAZdjuDiHk3s0mdNRuPAu52Qrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yoSPnt4EcI1qxHrArdlStjaHGIb5it+tYRLlfUX/M5s=;
 b=BX9M6ILr3pv5VtVQy32qiL5zMmNe1djNctBN5fgAmqDMrymoQrEjnvQwvK/omTFXToa2M9kHrV8wx6hhLaQSkFBgyDGBqEt1BoyWTfJ2v3vp7Wc1486y3znki90ZjJdBo1lTJHUGhvWi9nLUZ4TNyiaYACX9eXE7++Uwpb+e4RoZlsoCdpM1pXDMZUIPdxyvwnw2kfV6qqFyTmgrmixuykWeHV80F8NVTTV8E7ougw6qcBfB+A1JfAK296GED/lHRFkn4v8ZMO5O78XzBkUPGPWL9U9jIhz457yrVJWGwazB/Qd8f6TT4TJgIp9YereA7TT1jX7XIFpLdh31/05JWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yoSPnt4EcI1qxHrArdlStjaHGIb5it+tYRLlfUX/M5s=;
 b=eYxzB1UkWHftEmd+hAqaRH1ZgXizkdBPSMERm7VZyqElWrxuhdeb1Rhsfnbk+CDDbGd9Ifsl5oVLL4BMe0tJz/qiX8DPPaEDfmFugSjWThXONHt4DrkW305TdZ1VzsFHbc8SnSYleLrFeeIFETH2MgMnOwf7mPmM03FD4iiaN9E=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH2PR10MB4389.namprd10.prod.outlook.com (2603:10b6:610:a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.15; Tue, 13 Aug
 2024 14:23:13 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7875.016; Tue, 13 Aug 2024
 14:23:13 +0000
Message-ID: <b48cba98-cf51-40dc-9f57-4c1a7c493f78@oracle.com>
Date: Tue, 13 Aug 2024 10:23:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: mapping files for iommufd
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev
References: <a745cabd-5e38-4242-b3b1-da02c1e670a8@oracle.com>
 <20240812184005.GQ8378@nvidia.com>
 <684a3618-ee15-4f85-ab44-3de0527f91fa@oracle.com>
 <20240812150516.3e33c5c2.alex.williamson@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240812150516.3e33c5c2.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR12CA0024.namprd12.prod.outlook.com
 (2603:10b6:208:a8::37) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH2PR10MB4389:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b883fbf-57c5-4b2c-8acc-08dcbba3774a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkZuMGdNWGRGd1I0aG1udTVnNlcrRjk1eEh6Sm85K2h3VUF0M0F0RXZrbE1q?=
 =?utf-8?B?N1NRT01JRVFRTEY5S3M4emZIUHhxV3d6MkY1bzBuczJOK2IzMFY2RGNWSjN6?=
 =?utf-8?B?cGc2K0g2QmxDaFl2Z2h4SzluWDBmSUNBbUhsN1BhMEFaYjVVTUd1TDhBZTgv?=
 =?utf-8?B?Wit3aFI2ZXJROGdhUHR1empscWFuSEZ0aFlRcVc2QjdidTBIaERQcG5jcVBO?=
 =?utf-8?B?azAvSThmVVQ3dmhYSGNvZHJLZzZnM004N21QQkdGdHVpVnZwb3hzaFRyblFw?=
 =?utf-8?B?bkJ3VDNyVjB3UllnSmJhNzFHU3FJOVJQc3Z1UEZ3eUZBNkZ1TDl2N29WUGNE?=
 =?utf-8?B?M1AyeDdBNGxKYlI3RHE4U0V3STlKUUtJK1ludnZQblBmR1R5YnZpN2JxMHE4?=
 =?utf-8?B?ZkVlSWNkNmxuTS94Sjg2bEU4UXhaNGVHZEo4cDBUN2ZZN2h6TmRqdmRpWTNu?=
 =?utf-8?B?SWdBQi9kbEs1Vjl5N3pTeFFWd0NYMXFNMC9lNVI5VkxsenJlbWhMbmtIUmF0?=
 =?utf-8?B?TnlDMU5ZaFlUNWg3RExjdlA4aWg3aW9CVHpGOEx2cW45cndnMlRiNzdxRHdw?=
 =?utf-8?B?ZlJEYVp4bGVJYlVjSW92WTFIeGc0YW9SY0hDVjJpTXhFb1hxMFRjOFdIN25G?=
 =?utf-8?B?S1c1VU5SWG52SUVidE5sTVNyOVVhcnNVK2ZHd0p1N2VaNjd3aHJEbk9ZSzJi?=
 =?utf-8?B?M3UwS3NSQ3BKMUhyZzVMVUNRd21xRUxUL1JhaWlBekNMOENzSzY5VTJyQzZh?=
 =?utf-8?B?bHBzU3JaeHJlY05HTC9CcDZPbFEvRU8xd2F0bXZnWnZzSFkraTN2UFNveFZJ?=
 =?utf-8?B?R0M1QTJmQlBjQnBoaDNTM0ZrRGNDS212NWsvQ282REhMb09DNVBkbUZnc0gv?=
 =?utf-8?B?cE1QTkdBd3hjYkFXRnIxbU9NZWdOWUZTb1dmS0tKRFZ3dWY1WDZWdUI3RmxF?=
 =?utf-8?B?dytOZVVvL21lSkZDVjBiclJ0NWRYTFY2NkNGQlR0c0JucndoMUNlNXpiY3VH?=
 =?utf-8?B?Q1dzSk4yZ0FKYzJkcU9DMzZWUDlrMkdVNkU3SFkzRHVXbWVIeGtFckZ1Z1hG?=
 =?utf-8?B?K2phZm5Rc3owZUVtdk1raFA4aWtVTkkrMmtmM0wvcmZFZmV2NjU2NzRLTjRi?=
 =?utf-8?B?MTNUbE5LNGF3N2E2MGg4S2tuQUVQalBxbDB4dkZkWEVTU2l3NlY3Njl4MDEw?=
 =?utf-8?B?bE1XdXgxWmhiblIxQ0hUcFRXNGVTZXByc2VBdUQ3TC9RNncvL1dPUEVIU2Rv?=
 =?utf-8?B?Q0VCbEpEeWJ4Wks2ZjF0ZnNCK1k3RVVlNHhVWUlCaENkc2xzdWJScC8xeml1?=
 =?utf-8?B?SHNKUnlLYWJQSVNBSm1OczVuYVpOWEFEWTZZR3V4N2I4THU5T1BFUy95U1k3?=
 =?utf-8?B?dmRKZVI3UGxsdUwzRy9rZ21mM0VLQ0UyQ2J3MHppakNScFpTSUp0TXRSRWcy?=
 =?utf-8?B?aGFadkFtQ0RiRzZGNlJVMk1wU2M5MDVEYmZuVXRheURJbWU3Z001NlNzanI3?=
 =?utf-8?B?RHRqcW94blV2UTZKanU1M05vNW4rbHNVcEpnRzBRNVpMVmxIWjN4ZFlGc1hO?=
 =?utf-8?B?VEJkeHNnMG8vbGd0QlRPUjVUZUNyMDJ6dmFxaG9pdDJHK1lmcEVQcjRPSTlo?=
 =?utf-8?B?QkJBZCtJZ042T0JrRTVEK0JCUFMwNEtRNlpFR0xQRjE4Z1JhSHEwSlZJaFFo?=
 =?utf-8?B?VldHZ081NVVESFlHZnlvbWpJY2psM28yK0JtYlY1UXVjc1NZZVY1Z0pnSkE5?=
 =?utf-8?B?YXBqU0tKbU5aY2FNOVcrSGdFdzZHRmVmRFYzSjk4UCsxb0NpOVlxNWZwVW0z?=
 =?utf-8?B?NFBXRXdYc3Job2ZwcmlPUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEN2Uy83b2QwZ3FsQ0VDcXd2aXZNSjUvcGl1MlhOYXBLTTd0VWpTVGhuMnF2?=
 =?utf-8?B?cklXVmZOZU5ydG56L3RBczFLUnYzaG1EQUpPKzYyVjdQU2xaV3dkMHVvdTdm?=
 =?utf-8?B?SUNCcXRVNXdaWVFzZGxlWVI4MGJaVnlqNEsyY3lkUTNaZWQ1dHU0M3QzZUlT?=
 =?utf-8?B?cmNLNkJQcUNwZEZhazIyamJkR2NpSWQzRGlRYUZYRFRnMGZ0SExzdVdhZFc2?=
 =?utf-8?B?Szk3dTFkZGpyV3k1UFVVQmtuZUtQQklIc3JocHo3bU5YT3NPUDJydGNucy8y?=
 =?utf-8?B?cWhleGRKMUVDc3h0VzJneExqR2pZejl0RXZHcVVDTkViNm9BRTQ0N0hoOUlx?=
 =?utf-8?B?VUxSZFRlY2E2OHZtaW9FWGZBS3FkWDFsVUYySkp3ODJ6bWN6dTljTXpYRTlY?=
 =?utf-8?B?K05hQkpLSUZwT3BUS251OUUzSFFzV1hUeXF6Z0Z0ZzNjVm81ZHNCa0dPcHpY?=
 =?utf-8?B?b1ZiTjB3VnRPRHQ2V0djRGRWUjY0ekZBNWh5SkZia2FLWUFxUHFIYlRzOG5U?=
 =?utf-8?B?d0grN0RFYWFwLzBCbHNObWE1TnB1bS9YZGVDVE1hbzB0V0FsYmo2bDJUWktU?=
 =?utf-8?B?RmJISFF3WDEwSml3RitIM0MyZlRLMVdRbXNzZDhOeEVVZ0VEU2VUejFCTkhr?=
 =?utf-8?B?RXhmTjg3WHFVQTgvd1JGNlA5TlpoUkFSd3Q4U204MzlXUVJ1SXFZVmFCNHMw?=
 =?utf-8?B?TDRpVWVRa3NNQ2tRQkNTM2VlN3V0VU9GbVcvK1NQOXF5RStKNzRTVzFBUFVH?=
 =?utf-8?B?OFhXTmZVTHdybGZrVFk4bnltaWMyT212MVY5d3FPUVFJL25oM2lnZlV1aytu?=
 =?utf-8?B?b0ZROGt0NzFBS2t0WTd2dEN2UWdEcE01SzY2QkZ2ZzJ5QkJPYWYzandrZnp6?=
 =?utf-8?B?bi9JVlY5c0FiR1MvM1c2WDhheHBaQ3dBbDM3RHFUbG1oQkEwU05JVit3R2xU?=
 =?utf-8?B?NkU3Skk5VDJJWDNvODZVNTRmM05Md3JIbk1pbmIvSk5lYkVhQm1iakZjaUlR?=
 =?utf-8?B?OGFMRkJqQ1Y0NkZvNlRhcUZFZDdrWHhMNVhQV3FabmZMVUwyeTJxWVZlMkpu?=
 =?utf-8?B?cTkwUzRpWUp3NnU3dEMyVnR3eThDM1E5SlM1NGpoUXVzZkhmcEhaK252WEt0?=
 =?utf-8?B?SDR5d1dzaXFuTHJmY01TWHhmSndtSVZpMG5pQ3lPUG9oSlFta3VuemF3RHB6?=
 =?utf-8?B?dFJIdDZGQ2tqbjRQd1F4Qkp3NkU1M2d2Z3hqbVp3eSt0dUdqbmFOVkJGZUZm?=
 =?utf-8?B?bmQ5VkYzUmdvS2s3c0EwZ2lWQS9Ca0JzK0dNdmlERklRaGVQOHJwaGpZZ1VQ?=
 =?utf-8?B?Z0NkUEdVVWkvUmZVeEVxNW96MjdidzlyTlNyTVdoL3ZGWHBNVDV3L3FCbzRX?=
 =?utf-8?B?N1VCZWZSdHpGUVEzWEFsN0k1MmFRMm5TM3pGbFkzUmJWMS9keUNqVnBkQThl?=
 =?utf-8?B?cWN5R2dQWFk1SFd5bjY2QkwrRTUxdWozaEIwdDdIOE1IUHE4cUtKYm5VU3NR?=
 =?utf-8?B?SUJkakRockUrRDJLSWM0K3hVZTIzYi9rdDhjemNTTlN3bWk2ZlViMlFEVUJp?=
 =?utf-8?B?MjNTWjh1aVhCbFRnakpMYkkyUjFHc24zbDN5dEpqSHRJVVNuVHlmdW1taXhy?=
 =?utf-8?B?bnNnRjFsNjFkazluOTFod3UzVzJpWVhacXB1NHdEcEQwekdFRjVHWnduclVj?=
 =?utf-8?B?OTB0ZzBZVW9xWkFpWTc3bXJMUFVXMG52dkVhS0hEYjJyYTJ4N2t2Q0t1bklY?=
 =?utf-8?B?cXhGbGpKNmxHWE1hQnRTa1NMaHN0cFdJN3lWQVd0cGprTUFhRW16WUJBSkpQ?=
 =?utf-8?B?Q3cybHJLWDVWanh0Y1UyZFRRRGp2Z0xzNm83WitEUk15Y1FkRm9Xa1VVMCtN?=
 =?utf-8?B?L2lmdnc4NVFoQ29TYzNoTFdnaUpzQkpvTzZKdHptZURabnluRXVJOVhHN0xN?=
 =?utf-8?B?NVNLZEY1WHZ5MHpDc1pxN3E2ZkVRdytSRlFOSUl3ayt3dFlMelMxQmFTQzZj?=
 =?utf-8?B?ZW1VMEcvQTRienJFaTBacHRBQ3NNVHBXNUFjUmhpT1FrRElFbjhESVkrUzhi?=
 =?utf-8?B?Y2xRc2h0aWlYVEV5OHQyS2p6YVJiNnBJTXBveWV5YjZ1eHZpU0JDME1lcDhv?=
 =?utf-8?B?ZXIrZU1wT1BqNjF5allQNEVSWVRJQlBmNlZJNWQzOE5FZnRUdzA1aUM3WU5E?=
 =?utf-8?B?UHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lHDaJeZW3yEMebiqiYlp+BCV5zHPWV9xwkXr2N3MfQiCB1TKIritDJRpz97Mhp1khBlgp1VYRQQV4vZtctLgikbK/PaWH4qFfRIFBzC4qfD8jZdJVmLjR+YGSi7cl2fVSmKxnC91GU6zWvg9/1RYTml13MAM35h5c83NrhCl0tgpAaaqzJGuf3YebLP7QK/w6LMhj4li6m2iPgaLUela9izm6MDR1DFPCA46t+mknvjQ3eyYPBdsTgX2mG8jJnTws+kc+fS6BQymqccdgGJAIUrClU+UdR9CO9teWNzpmmWfOhY6kigCi0xBAx9p29MbZSLxM9tDPp7i/y/e7O9a+TGg2w7dytNUbkvb516gKsMeZXY+Lw+Jb1R13UoPhDNlyPjwpvsnHqwtMiJRY8LZniXdkSREpC5IMK5B0R8pFzCx7tSsAJ6UXcx0ckbUCkm8969tzMPbDiQjFKvqyfABd/n+ztnmeBbCOirD+zuY65s5MLIlo7fdfuTn8vQ88VgrBrNtKGsVYRB9k0b3wE5H1B1Kle1XCPdLWZ19Fz0bPdUvsdZoWNiKs/rIqyPKJdKdz1lW5d9GCy/pBaLIf3pKjgE35UPs+YlD+grLz/7CJZU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b883fbf-57c5-4b2c-8acc-08dcbba3774a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 14:23:13.6575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QTXWNN5oipKJgvtImSiddLv16y5IfFVTeepCnx3rKm34eIdEdDno9YaVjUhGzMOOAeHcQS+jHPhfnSkX8V7eGLQ+cZz/Am8llfE/rlFEV0A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4389
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_06,2024-08-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408130104
X-Proofpoint-ORIG-GUID: bJdoI1UcsSeqYLx1qYDnstlHC0byBwrJ
X-Proofpoint-GUID: bJdoI1UcsSeqYLx1qYDnstlHC0byBwrJ

On 8/12/2024 5:05 PM, Alex Williamson wrote:
> On Mon, 12 Aug 2024 14:56:03 -0400
> Steven Sistare <steven.sistare@oracle.com> wrote:
> 
>> On 8/12/2024 2:40 PM, Jason Gunthorpe wrote:
>>> On Mon, Aug 12, 2024 at 02:09:11PM -0400, Steven Sistare wrote:
>>>> I have been using QEMU to test legacy vfio vs iommufd compatibility vfio.
>>>> I find that backing guest memory with an ext4 file /root/guest.ram
>>>> succeeds for legacy but fails for iommufd, with EFAULT in
>>>> IOMMU_IOAS_MAP -> ... __get_user_pages -> check_vma_flags.  Ditto for a
>>>> hugetlbfs file.  This is with unmodified kernels, no live update changes.
>>>>
>>>> Is this expected?
>>>
>>> Yes - I'm surprised that VFIO is not failing though?
>>>
>>> /*
>>>    * Writing to file-backed mappings which require folio dirty tracking using GUP
>>>    * is a fundamentally broken operation, as kernel write access to GUP mappings
>>>    * do not adhere to the semantics expected by a file system.
>>>    *
>>>    * Consider the following scenario:-
>>>    *
>>>    * 1. A folio is written to via GUP which write-faults the memory, notifying
>>>    *    the file system and dirtying the folio.
>>>    * 2. Later, writeback is triggered, resulting in the folio being cleaned and
>>>    *    the PTE being marked read-only.
>>>    * 3. The GUP caller writes to the folio, as it is mapped read/write via the
>>>    *    direct mapping.
>>>    * 4. The GUP caller, now done with the page, unpins it and sets it dirty
>>>    *    (though it does not have to).
>>>    *
>>>    * This results in both data being written to a folio without writenotify, and
>>>    * the folio being dirtied unexpectedly (if the caller decides to do so).
>>>    */
>>> static bool writable_file_mapping_allowed(struct vm_area_struct *vma,
>>> 					  unsigned long gup_flags)
>>> {
>>>
>>> Why doesn't that fail in the VFIO case? I didn't notice anything
>>> special there that would make it work???
>>
>> vfio_dma_do_map -> vfio_pin_map_dma -> vfio_pin_pages_remote does not call GUP,
>> it just grabs a reference to each page.
> 
> Can you be more specific, because...
> 
> vfio_pin_pages_remote
>    vaddr_get_pfns
>      pin_user_pages_remote
>        __gup_longterm_locked
>          __get_user_pages_locked
>            __get_user_pages

Right.

The correct explanation is my test succeeded for an older kernel, based on 5.15.
It failed in 6.9.  This change in 6.4 (which Jason quotes from above) appears to be
the reason:
   8ac2684 mm/gup: disallow FOLL_LONGTERM GUP-nonfast writing to file-backed mappings

I do not question the need for that fix, but I am surprised that QEMU users have not
complained about new kernels failing for hugetlbfs plus vfio.  Maybe most are still
on older stable kernels (as I was).

- Steve


