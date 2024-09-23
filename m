Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1223198E6C
	for <iommu@lists.linux.dev>; Mon, 23 Sep 2024 13:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727098276; cv=fail; b=o/U+RrvX+b0f3l4kX7UwXgoKXU7UDkLdipanD2AnemL4g1mmejPNUwqcb/liPsERi8/RmgP5vWDsrmaiNM53ImZOeD4N81nI5IGfLNiwNgb7zXT6EldneC1a2MFl27q8VenmvSzwKadr4cg/O/orTXVqLAz4VFICMDmhKguxje0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727098276; c=relaxed/simple;
	bh=pXR80aJef86nWFJj+jL7a5N9gUM6V6YIR4AC6crtVBI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=osrNjCLSYmpplxJIC1HiJFSb9nYhVun5ypHEpyvlC1qQBN/p6NG7/24pc4ql06obPexMeoJni4CYlSeQaUs0SvRb0ZZHN8J9wAyFXGXWZEje2ASdDZk0YHoiTsmtP3P/+8sFSNZUOVs34117L7X4kkDH5UMrki3rkHx/uy43uZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BDaPNytJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eH5WkgjQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BDaPNytJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eH5WkgjQ"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48NBiXHi009101;
	Mon, 23 Sep 2024 13:31:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=yOqaYmhiKYg0E19nsnehVKWnnEkumP5HNR2dTHuZC+Y=; b=
	BDaPNytJFhiDMQjflZTZi1FyDM8rybxRRbGDvoYnQSrnAnZk4lAwcI/HtvJcfV4b
	7Ou1YBbe7aLgSVaLuqPHXZW9IFDeIYz8tFehLvKTl9nx8e7jM/O4N2Ih1caq9hM8
	w3a+lW3CDPx64sczehcK8faIwaNmLI0LiWSHSaruKzxqo4OjC94GPeUqnRZVQBhI
	UzDSkgS6EoVaJxoi7jP2dXHds8j9gk0A26hBq6MnY11hraNN+rhfoLXcQzg8khTk
	nw9NSCTdpFeU4YY2pDb2EO12xrTlascF8O7VkdG5MrlGjGSPrpUSyHxiI5Jsc6K/
	kQnAzEHHzA14lyD4AZjHZA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41smr14raa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 13:31:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48NCKS2E028739;
	Mon, 23 Sep 2024 13:31:11 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2045.outbound.protection.outlook.com [104.47.74.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smke1w64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 13:31:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pxj3HaPxkfPuuZjAIZoq6NfxSHvUQnFVu5hlHMlacvO2TMg5UhHgR0sAwAxuY9gyugtpc/sRqWnKGQufqhACzgNVVPloy4cRefMneNENWok2b60S+yTqF4Sslwq6auDuN01BaKMS4U5IEAmgfV7KSNP/l1wVYJdMG+tiSVvkVBW4UExwkjKpCrCqH98Z61edfPtfq6UEhryzNs4hb9SRRrjAAwSQf5nIZwM+EQ740GH+grz/epynCzyw20C1cXiClxNrXzPDk6Gkb/PveSKwbCo0g5QR4aEicbpOdZXb9j4BtqXCJAcKeqdLZ2cg49O0HON1gcd10EHvDXBxY1mN8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yOqaYmhiKYg0E19nsnehVKWnnEkumP5HNR2dTHuZC+Y=;
 b=jSfwiscvpfi+0wqg8Ok+nDN5Pb3MMB2GZeTrmr4nNHjA+ZxDGVpaAclNIdbXsJ75TyH8eHhOolm4kuTq68dp4KNvi83YN13No8wea00/MMplvO910p06B2VpB6XYaxtZyUdePdQIUsOK24hegnf3wlLO1gk4XjXd3xCuUth3sCkTuMOZlpuFUHt9YBz3febjeO+1JSWHmayA+OFGfzhDLH1onniS0CDVNS7JJ5smNtNux4K1cXQOVoYancFlnFDZFTbk9aRUBXTggUx6Oz8KcmuccciyuGoQ4MUx7s2wfFDFx2YzKnC7+13lnu3//LsyS/Kdhnm+Z3mDoTUOSdSgew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yOqaYmhiKYg0E19nsnehVKWnnEkumP5HNR2dTHuZC+Y=;
 b=eH5WkgjQZb5cnbFXyNcKTj/5ZJPe+G4KO0mGkM/KREnAUHqY+TVnA6cOuidAK3CqE679WGcMT1UU0/rcvM3VEaQIr8UGofx9KNsU7FX1IUZrxP09HhiWFuj7Pd7vTvLgt7eFH6GaCYvW2+lzjUddsanF3Ta4vYJ+8OC2AnWWqEs=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SA6PR10MB8085.namprd10.prod.outlook.com (2603:10b6:806:43e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.12; Mon, 23 Sep
 2024 13:31:09 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7982.012; Mon, 23 Sep 2024
 13:31:09 +0000
Message-ID: <24c5d785-230c-4d21-8fc1-44baee00f398@oracle.com>
Date: Mon, 23 Sep 2024 09:31:07 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: running iommufd self tests
To: Yi Liu <yi.l.liu@intel.com>, iommu@lists.linux.dev
References: <d4475e43-0d6b-4f22-bd26-37f62ccaa1d8@oracle.com>
 <ae3bca38-9efb-491a-bbaf-184e7d51e491@intel.com>
 <0294059f-90a1-4e5f-92df-9c25d2c30667@intel.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <0294059f-90a1-4e5f-92df-9c25d2c30667@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR03CA0053.namprd03.prod.outlook.com
 (2603:10b6:408:e7::28) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SA6PR10MB8085:EE_
X-MS-Office365-Filtering-Correlation-Id: 75ddc474-d0c4-4760-9cae-08dcdbd3fbdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dHB5TVM3TXBpZVE4L3ZFU3Z1Y0ZZeGxzZWJxTk54RkMxdFNRSlhlYVBtRVlI?=
 =?utf-8?B?VjlmMFFmckM4R2M0enpxemNVTmQzZXFkbXpKaE9tTFFzcGQrYkhlcEY1ZW1t?=
 =?utf-8?B?VjJaeDN5OGs2emFWMWtwekxPa2h4NWJqVzdxZk1icDZSQXJqb3QrajNPemly?=
 =?utf-8?B?dXZ5MGg0Q3RBM2Z2MzBCcGtiQlF4ZFJrNXVTS2FORS9USHpBUlU3cUJpSFU0?=
 =?utf-8?B?QUdkMzU5aXFRd2xSOCtsZzlUbDNFNFZydi9MSXY1RlRVSU8wZGVwcURFWFlT?=
 =?utf-8?B?bHQzTkhSL0Q4aXpqNWI1N2RleCtYMEdCQmw0eEFaYjQ3eEF5d2txbURjU2x2?=
 =?utf-8?B?cytDdVp3TGtod2toT3haNHlJOWxpNFVQb25tZ09GTjdKRDFhbHIrcnFzREVF?=
 =?utf-8?B?dGgzK2xaQW1jSHBITVFzajJ0UEVzVFU2MTR4cWJkeGFLZklUMFNyZ0tUVStX?=
 =?utf-8?B?YXVIUFhWa3lDMUFwNWpVQ0dVT3V3Y1JxMHRSeSs2S2tlYWkraTB2V0ZMYWpJ?=
 =?utf-8?B?L1phM2RUK1hmNEJZZjU2SWw0SlJ0UjFVelYzTTBVN1J1VUp4a2xWVjBXM3BT?=
 =?utf-8?B?YjVvU3pnejBvR25NOWtwWDVFclRGbHJoUVMxb2grRXVzeHl5V3FyZk9OSjVP?=
 =?utf-8?B?TC90clhMNzh3R3prZi9IcUM5ZUNub1JkNCs0WFViT1dCbmxPUUJGWTZPb2VJ?=
 =?utf-8?B?WDZMSjg0NjhzSE1LeUNqdnl0UkprOXNsb28rSE9PL0o0eWU0YjMydk1vSnVW?=
 =?utf-8?B?L0ZWZ2VDZXBtb0Jkb0VxWXFkNjVLTEw2ZjMzV2hBNU43YkRudUp3bVVoUlp1?=
 =?utf-8?B?QnM4Rjd1TTFjbjVZTHIrWEFPTTNmU053YWx0WXhOcGR1L0VQeERpanptY2tX?=
 =?utf-8?B?ZzFxNFN5WEcwUEdUaWNBS2MxbzVkTDh3cmFOY3JRemdwbGs2emsrTXBjTUNB?=
 =?utf-8?B?akZBTFVOWnhZSzA1WWZRSHZVWFRTY0psVFBnNHo5MUJ3cXY1MGpUdTZpTnVz?=
 =?utf-8?B?b0hqamplQWpMb0dKenVQZ1d0WmV5OHhRN3A4NEVtelh4OG1lVksrTWxqcndx?=
 =?utf-8?B?dDlaQXpJLzFUSWFyOFI4eE5SR2VXRnB4OGZhd3Z4ZUJqekFITkRmaVRBTUx2?=
 =?utf-8?B?RjVtR3RPK04yWlowVnM0UDBJb2dSSWFiYjVJdGt6UzZFc0UrYlY4OWtadTRI?=
 =?utf-8?B?anJGa2JtaG5OK2FJZTNpN2ZqMFRNbXNqZWxTci9YSGdVUWVTMDBqdzZvTWJX?=
 =?utf-8?B?WHFFc3h5N3I1YXdMK2Z2VmVuN2FoQXgvMzVVUlBrMkQ4dDExZlFCTEJxVHdz?=
 =?utf-8?B?MHdTRlgrblp4dXBqaGZSU256emYxazdrZk9hdXE2V2FyRW1JNVdFQ3RBV1l2?=
 =?utf-8?B?TWRyN0hVR01LY2FNcnVQR29QcjVxU1hvQkRYWVJYd0pkWituNU5tTHQrdGdk?=
 =?utf-8?B?bXV4aDcxelFkWFM2bFhCUWd0c1F5eWdIVTZaRWE1M2lUdTREL2hCRWg1Mlpz?=
 =?utf-8?B?N0pMUVBBd2FpOE1Ec0MvMzQwZTlWQWJLMG1IdnZqN1FrK2drb2pqQzYxcmNH?=
 =?utf-8?B?SGZNa0xxVmkzaXpDb1YyMC9LajVZbC96NHNaN0lxczloNWxRWjQ0My9yMmhm?=
 =?utf-8?B?WVNpejNxVG10OU53UFVjL0ozdkpmdmU3RUNFWFd2S0dVcXAvc2VkTnJ6RW5v?=
 =?utf-8?B?SjB6WXk0N0FKNHY1M1VodmlrSVpnWGthSDg3bEZUcVcxbUFRREcveG53UStT?=
 =?utf-8?Q?4UbqrzFL0G35SU2bKZSYjg313bUdeJNwj73KQkd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elRvWjV1VVQrWlZWNEpETytUTUgvQS9PaEVyeHdaZVNnR1dBcFgvNUQveHdz?=
 =?utf-8?B?NjFXUm5SWEhSbitzdGhlbWhNMzI1SloxUUZXZkNWNEpzemdzT1U4RzFKblJh?=
 =?utf-8?B?akNHMzkzWTZxb2NrUUxmNVlSUkk2cWZYNXQ3VStOUklGS1R3djY3TzhreFdp?=
 =?utf-8?B?eGFBZGFBT3owL1ZnZ25La01FSFArY25YODdqeDU0VStWK0ZpRDNEcDh1cXRj?=
 =?utf-8?B?MWJ1cHp2aG9HYVNnSlR4eEN4UEpYeXBISkJWMTZ5OVBCZk5wSWc3RzJicThk?=
 =?utf-8?B?R0JXYlowWFN6aUxrYUFQM3BtTDlqaVBrN3VudEVLdnQydHY0dmFudlMyK0JF?=
 =?utf-8?B?cDZWOTFTY2NtTnozVzA5cUd3S3BkUEhOZVpITlNKcytOMjhpTGErUFJDVVlV?=
 =?utf-8?B?K01WcGNFcHl3QldJbDdzWGR6S3hiczlZN2RxN1NWS1BLcWZVU0pMTHA5WDRV?=
 =?utf-8?B?dW1PN1ZadkFid0NOcWJwOVIvMHRESGtwUlp2a2gyc2xVNlgxczFjU05vNFM3?=
 =?utf-8?B?b3E1NCtid3YrK2VPVENKUUZjMjR0Nkl4YTBDNmNLK1pOT1dDdWJ0MnNKcHBE?=
 =?utf-8?B?VlhHVGVhcERPcFRQeXZmeVZIZXVxRitXdVI5bk93bnhRWGdHeWhGUnlJQ2pW?=
 =?utf-8?B?WEh6V3RXRElnNjI3bnIwNFdNS3o2MHdBTXkzd0x5R29jWHBPZzczY0N1YXR4?=
 =?utf-8?B?QkxnN3lkTFdoVE11Si9CRlRUaEJYaVg4Q0tDaXY4WEVCRUVmNEh3OHlVdnYy?=
 =?utf-8?B?VWppZFlqeUNiSkxvUUZyeTBXWHR1VGliQTExQ21yYmVOcnhJdmFHVitUV3o0?=
 =?utf-8?B?ai9xL1FPZXQ0N3BrdmZ5UDVha0FiRDNqOG5rYUFScHJSWklRQi9ralVwUXN5?=
 =?utf-8?B?Z284ZjBWTGtnSUpSekhRL3NvUHptMU5tdU0ydjZ6elA1d01SZXVKRnFsNklN?=
 =?utf-8?B?Q1hERlJGRTVLSkZaaGt0RHZ2c0xCRTVRMkNaSWY2SGhFQ0thd0JmTUFvWkor?=
 =?utf-8?B?K01JTG8xek9VS0g2di9tZmxqQWRGNUUrY3dJNnhRVkRXb1pweFNPMHBMZFNw?=
 =?utf-8?B?ZWszUnozeFpOdExXWkUrMnNhNEFJVFdISXFwaWVXTm9janVDSWpINXFPU0h3?=
 =?utf-8?B?MlN3TmVVQlBpOXZrRS9NL2FVcUxuSGY1K2Rzb0dFTGxpdlFjdWRrNmFLdlI2?=
 =?utf-8?B?TXhJMDlPNFdOOUlPRGRoRm5QS1ZXWnY2YnludW5jcEM1K0pQVUt1aVBqYjRi?=
 =?utf-8?B?TnBBRWdXVW9NNXlBYTlUQm5PTHFPYVB5b0wwUExHcFRiNTRndXh1TGh5eWdz?=
 =?utf-8?B?YmZQcGFyb0VEbTVTRnBGTkt4OFp2dW1JVnBwQWtLUUkvYlRta2tqMFk3QkxL?=
 =?utf-8?B?N0Fmc1k0TXhlbTZTK1NCejFCMmwvZDlXWDVyQlZXOWxxMUpYc0s5ajl6eGRC?=
 =?utf-8?B?WkNQRTVES2hkM3BHTUVDTVpFcnJ4RjYvSldtL1dvUXhPU3JoKzVEMzdsQkxR?=
 =?utf-8?B?QmNjTlphTGZYRXNnVDFxRTIrZXhoNHZ0WUpXdW9wOUJSdC9BOUpFU3FnWXpV?=
 =?utf-8?B?MStIa1JFOXNIaEFvUk9vYXRhSlFHb3hBUXlCTStyTUdxUzIrRWhOUDFiUUVY?=
 =?utf-8?B?TDNhRVBESHVURzhyRndrSlZaS0JXZHYwdndUd3BuclFianBPOFFqL1dRTWRp?=
 =?utf-8?B?YURXRTFiZEtRTENDTFUrTUpxbGJVbkRQY3kvenFQeUo3NS9GYjVURmtXZmxw?=
 =?utf-8?B?dmRkUDRXNnhQY2ZlcHBYYVFUbFVuMkNFSU5MYnBVRVNMbEJUQmY1YWFhL21q?=
 =?utf-8?B?K1h3WjZhMWgzM2FjU04xNVl4VmpCOWx6eTc2dXdzOG11dXpOU3NFRVJWRjFG?=
 =?utf-8?B?TmhHcUlwOTNYWUZ0RFBCOVo2aXlVZWRlMjZ6elZQK2k0Uyt0a3RXM0s0MXdD?=
 =?utf-8?B?aHNiK2ZkS2RoWXNSaVhHVmFyOU1SeTlxQzd3OGR6NTdpbUdwV0oxcGREZ2RC?=
 =?utf-8?B?SEVnYkkyNUU2ekJmSmR5NjZRNk15NDhlNTd5bWJPYzdwT1dOUllsSEs3Z3BQ?=
 =?utf-8?B?anFEVWNtRjMwcWFCOTRtUnVkZWQ4M3BqUTdCZCszUWJUa3NVdytZTGZVSklP?=
 =?utf-8?B?YjNlN1hZSTBHRlJOTm8raTdUY1NDcDM1eUdHSVp2MVJlTDl2K1FLb2t2L2Yv?=
 =?utf-8?B?N0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4JInJDnZIrWG3OR9xXPT9DuUK9DZT+mxn1PRa0Ko45vdyb3P8NHx/bg6tVyBKKtBenHz5F5sGoEbuaZqjsqoKqo57ez0MDvYE2DRD67tBn8FudLwz5KhO254kG+LpTOrAliSMZtfOK1I7wivWaLTEHIV5tyXOfCOZFk2W9z21S1rYyJ2eMZaFQZbk7GGkN6vmQNRqrIiNNbIiq/yWcqoAJsrAq8o2Nl1WloSHX9VDziq4PNSbRV3ODtDxQV3Qnm/6XembGV+Sg8PG9DO/buOJ4yoPjN3cKgJvFuKyO8jWcT6bGzC9HwhNNYdN/R9x834bc+OOond3JbdhHMxpMDYFJUdysaVLsVsuY6RLcavUXa8e9sh3Om/wn0p2MXEcVG2zx2oFtmIJC7Xyantrs46DwcTeFxOMXie/diZCZe8n6FhsJFJ+zr1YL2cfc+OKUPbvQQr48adVDQsGJM3NccJD1noZbUBCV5J1li/ahXuIdyU0ol/SfpxXscSK876Gp+bwsfipCqKPohfq4AwrjAgfZxUndsFcq4V3mKKZKTRH6K7ryQ1NH+Ejte1zJXoeL2wM5dgUcDonqpVFPAQ781xKpR0jjA9aDgTSCLOeqmfLsE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ddc474-d0c4-4760-9cae-08dcdbd3fbdc
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 13:31:09.1005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3aR6Ekns32H6aTYRCwXYj3kDwewp3u3r5HU1c+pUBiMSonDeXGzaVVdC1/fVbJTH9GNU0+Cj6OQvMg2L/w9GlKYkZtMdA5iWPzTDDdQ4Be4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8085
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_10,2024-09-23_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409230099
X-Proofpoint-ORIG-GUID: aSBjo_KW1irCZpIA2Cb2upKS3NJRX-Q-
X-Proofpoint-GUID: aSBjo_KW1irCZpIA2Cb2upKS3NJRX-Q-

On 9/23/2024 2:32 AM, Yi Liu wrote:
> On 2024/9/23 14:16, Yi Liu wrote:
>> On 2024/9/20 22:22, Steven Sistare wrote:
>>> What userland setup steps are necessary to run the iommufd tests?
>>>
>>> I build a 6.11.0 kernel with:
>>>    CONFIG_IOMMUFD=m
>>>    CONFIG_IOMMUFD_TEST=y
>>>    CONFIG_DEBUG_KERNEL=y
>>>    CONFIG_FAULT_INJECTION=y
>>>    CONFIG_RUNTIME_TESTING_MENU=y
>>>
>>> and make the tool:
>>>    make TARGETS=iommu -C tools/testing/selftests
>>>
>>> and try one test:
>>>    modprobe iommufd
>>>    iommufd -r iommufd_mock_domain.one_domain.basic
>>>    FAIL
>>>
>>> It fails in ioctl(IOMMU_TEST_CMD) creating the mock domain:
>>>
>>>    iommufd_test_mock_domain()
>>>      iommufd_object_alloc()
>>>      mock_dev_create()
>>>        device_initialize()
>>>        dev_set_name()
>>>        device_add()
>>>      iommufd_device_bind()
>>>        device_iommu_capable()
>>>          dev_has_iommu()  <-- false because dev->iommu == NULL , so fails
>>>
>>> I suspect I am missing some configuration steps related to the
>>> iommufd_selftest_iommu device, but I cannot find any documentation.
>>
>> As far as I know, iommufd selftest is broken for now. Baolu has a patch to
>> fix it [1], and I had a test patch [2] based on it as well in my testing.
>> It’s originated from Baolu’s patch.
>>
>> [1] https://lore.kernel.org/linux-iommu/20240111073213.180020-1-baolu.lu@linux.intel.com/
>> [2] https://github.com/yiliu1765/iommufd/commit/2af6b607c28e8d86f73f2390c954b5953651da60
> 
> correct the link for [2] :)
> 
> [2] https://github.com/yiliu1765/iommufd/commit/ff0772d155c1ae2841e7b7ff0d7ca889271b81b2

Thank you!  This corrected link applies to 6.11.0 and does the trick.

- Steve

