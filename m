Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29862538A
	for <iommu@lists.linux.dev>; Sat, 26 Oct 2024 19:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729970048; cv=fail; b=JmRaCCwsnZEaa3L8RfuMEo3tOwjU0AisJyjmFyYfIqmK2FFAwZcjnHh8nhZqPR8gabFxvx6G9p9QMPKJK0X34mX6qvagTF5wyNVVWpKgcS4A8Yq1BSrBvWbwz7cvOMvpLC0nc3EFiiqKCj8CCWM2q/TCMGle/oT2Y5xarO6If74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729970048; c=relaxed/simple;
	bh=sjFCJDnsFBMv8zplJwuLGmgabmnCaYtXGL9AfePssj8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=evo6oHBfN/Zh+Zj4qjZ+sf18glM//4V6QmsLmJkg3FVDtMrWsghOS2aOpfKMBZ5xc4R/YgSRfBFtXaR8dZcl0P5FJXbPN0+88ORGD4PRPT3SYP0vXVmv4ezjOSM3q0pehInJAt3JxUJ0OoO71vxXgDVAeEP/jHGB4RNSqure0mE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AuTTrTbR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NPUy7j1L; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AuTTrTbR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NPUy7j1L"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49Q6hEbD016191;
	Sat, 26 Oct 2024 19:13:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=gsXQGxIQfyknnQFhmGhTBAPxJxhrVU2xJBBJ9r1ZC5k=; b=
	AuTTrTbR1kic2gX5PSy9qJ1neODGXQdweV5XBB8Xu9D8eoGcnk5YZYVqwSneU2mu
	nJpquhOGBvOx9bEG0CQtyO/nZMRREjVaQJeiYBwmeG18uLPqMIyqmjOvn7BwE/j9
	bf5QVdE8kZKtkpxBKjPlbf5C2/TNOTiwHU8gH4A6s7k183DPIMuZTjkJirwNVNsf
	pMAC1T0+x3htuUPKTeqUhejUm9ojEjZ/VfJI5b+COUN4JkQscbAMegvMj0BeXwFf
	xCUhYC1+Jc/qJtDGIEy1wW2tpM1vVaseV47F4GZMHNu46KtAHBXR4aooJHkrGLLZ
	gl9a40vDga0Oetv3ogiQCw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grgm8ks9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 26 Oct 2024 19:13:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49QDVMGZ031206;
	Sat, 26 Oct 2024 19:13:57 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42gpvap6wd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 26 Oct 2024 19:13:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n1BNPUg1nj8zIGVyyzDOfXvnvtAoiMtrgX2DbzjXyvfEHho+oiDpIb7fcwPoijnze0TtaR3af7Ps8RKY1/pPvwd/YKiiaFY2R1OT3XZQd78JvgeU09JXORqkrsy4e1u3TyxEVn+fJgR1/f5s+91xyjf7ulDB2rAP9Z4X1R4ZWkc0JyRSfCR2GC1TXWJgizHVKXC2I+ILar3QV+MZ7mTTT28MtKxWPdzofzXZOkYSLZJdH+YmODTQgM9gXyQKstd1ldNQhnJePlkrrIJvhTBgZjsRMbxOw4uljgYc6jpnaPwBGtL7UEfXaMrAem8ISk3dfHleLf5wdl5E7Dxi0l3DoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsXQGxIQfyknnQFhmGhTBAPxJxhrVU2xJBBJ9r1ZC5k=;
 b=AoHXfzuoMTYB+1bmbEC5FdAKehejrwa0cpYAN7YngKEwvAbVzuDJnVoaV7+FGeLh4d0Wn3AnVO8rmWZIPkT8TSoYGVnAQuzKZOvd4AfHF/RMVZp4ZK1gqWTtdn42VCmxilik1rd/QcUP9+Dam+7RpDUNiJP/8dmzyzmjNVAKL/VAWTy1CaavBQQiNI/aybhVtj2ffnkptCvMP3FDnbZzwlO73RtTOOHCSUu2CXjlXowgfcagBpXPOguO9MhNaQGM8rZxYmJKfcIZpXCRFTD8LGTYQyNOYSM0W9SHfbq2O4/DT3b4fpfX9f+W3Z8T2/aggUcFUwPM2XPWxQWa/sJBOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsXQGxIQfyknnQFhmGhTBAPxJxhrVU2xJBBJ9r1ZC5k=;
 b=NPUy7j1LCWimBr3HgpgMda7mPUq8r7bbM1sQb/JInNMAZVk0L86QjNEwkCVF/3u9ng7ClIto461OE9URXVyIuX6abbFCD4xKUl8tWZWekJJbNacnjhiPm9gVlMhlL1TpHumZcOcWcuDGT0ua62yYSkG1bpYI81V56qNE/jV3RzU=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by LV8PR10MB7774.namprd10.prod.outlook.com (2603:10b6:408:1e8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Sat, 26 Oct
 2024 19:13:54 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8093.018; Sat, 26 Oct 2024
 19:13:54 +0000
Message-ID: <37483959-3ff1-44fb-b3f5-f1c0859de1ef@oracle.com>
Date: Sat, 26 Oct 2024 15:13:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 9/9] iommufd: map file selftest
To: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>
References: <1729861919-234514-1-git-send-email-steven.sistare@oracle.com>
 <1729861919-234514-10-git-send-email-steven.sistare@oracle.com>
 <ZxvPhQZOBR7g56eh@Asurada-Nvidia>
 <2c7edd3b-61c7-4012-b825-4972c0efcec5@oracle.com>
 <Zxvl7J0mWkKPS4GD@Asurada-Nvidia> <20241025235849.GL6956@nvidia.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241025235849.GL6956@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR16CA0057.namprd16.prod.outlook.com
 (2603:10b6:208:234::26) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|LV8PR10MB7774:EE_
X-MS-Office365-Filtering-Correlation-Id: e71bba9c-431f-4f61-d9ab-08dcf5f25518
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MUNqNUJxNWdYMWxTQVFoSjhaMnA2QWVoTkVvNjlSL3FFMUxvTC9lcS9pK0Zl?=
 =?utf-8?B?a1I5T0xrZ0VrOThOakF1YjEzOUJrWnRWS0tHOUxSK0xMUTNody9XcC95WmpZ?=
 =?utf-8?B?Ym5Wa0UxNUROUVgyOFg0b2ZBNllmcHVLQUs5OGVtUDFYV0xHak5lRVIxem41?=
 =?utf-8?B?K3dyOVlMRkJxS0pEZGI3YjVYUHFGUjRMbll0MmhQUmhIaUMyM05TTUtNNFpT?=
 =?utf-8?B?clRDUnhrUTFJNiswcTVZVm4zRTlZT2ZUZ2hIdG1hWTI1eW1Ma2xZRnVraTJD?=
 =?utf-8?B?TlNYTVU5ckZmZzVvZTErZUFIM3ZPZC90TzNSa1p1MVU5OG9tS2VQR2VoMnJH?=
 =?utf-8?B?SlB6aVNhSGxkaDFWTkxaTWd2bkpVWTl4T3ZXR3c0TGhzODI5MzFnczQvMC9M?=
 =?utf-8?B?ZW1FbjRtSWppRVZYdWpBanlPT0loYzl5OXNQRStkbmIvTFBTZTA4bHJnb2ls?=
 =?utf-8?B?aDRPNHNVZGF3TXhoMXVaQytVRm9haVZ2WnU0bjRjRkkxaUNtQ2FNek45cjdx?=
 =?utf-8?B?WlVlUm5SMmU0NGtZSS9xMkFTeHg3OW94U25RN0FTeUtTL0dISWdLMGUvdXh3?=
 =?utf-8?B?YVZ4dkZBUUdLNzVCdlY4U0ZwaitYT05vdi9MdjBjZHZsRWJkSWZ6dTRLSG0x?=
 =?utf-8?B?Qlg5VGMvWlZhYnUwaU5hdkdJdlc1TjE5UWh2enk3ZDE0THYvVzlvc1lOTGNX?=
 =?utf-8?B?SS9qUGtWRzBjR3kzS1JGTmJVeE9vSER3MGcxUHpVYTJTQzRISW11UzJsM1J1?=
 =?utf-8?B?UDRIMk9hdndFOVN6Y0VCaHpDTlByVnhrQkVqNy9BeTZpYXM3REZlcWlHNnYz?=
 =?utf-8?B?ZEkwMU41dWNDcE9CVnh0UTZvTkw1emsyT1VKWjRpQkI0dFNWalVma2c1dUo1?=
 =?utf-8?B?VStwckJkdzV1V0FOUjYrNGN6L2cvWW13a2VSZjh5eTR0dGV6ZzBvcEhNaFI1?=
 =?utf-8?B?cUdHcHRjQXNxQmZuVnQ4Z1FUeS80YkREUUlUdHFXYk1XOGUxVnRTd0IyV2FV?=
 =?utf-8?B?VTkrNlY5Z3pmclVUT29RcjcxcjU0aGVJU3hoaEg4WHZoY2RKV2MxUUFPQlhN?=
 =?utf-8?B?STFHNlJ6bE5EK1FMTERLSkpnaVhEbGN4UytZV2xtUWJLWGUxNXBFdlROdS9x?=
 =?utf-8?B?QjFHY1NEeFQ5NnJXdEw2UGtCS09KRGZrQjlkRVV4eEc1Ri9VMllnTnd2UVls?=
 =?utf-8?B?N0tDRkF3L1U4VWxLWjh5OVlnc0ZSVG1zYjU4TWQrcHBncmY2VDAxUUxFdXhw?=
 =?utf-8?B?blgvTWRCVEdqMWNsYUp5aVpNeTdEY09JYUI5M0MvSlBwamoralRMcHJnYWFP?=
 =?utf-8?B?MkZYY3orMWM0a3dQdHM1VmNnMHRmQzdZUzdIcGtyUUltd0F2TStQSGhwL2tu?=
 =?utf-8?B?RHFkWnBkajltY3VER1JQQStiMFBLYnhqUTg5UTV4eHVscVovS3NtTG5SWWdB?=
 =?utf-8?B?N2VyOURIN2hXdk01Y2EybXVQSHFvUnN2MlVtK3FldkxmNWg0UUZNbXE3SXdL?=
 =?utf-8?B?ZmpTSVlOa1FNUTZpMHNacmVOUDd6TWg1NmFtdzVObGN2NkFOUmJESGkySzRl?=
 =?utf-8?B?d1M0YnZBYTZRSG5aRExqRks5SnU5aDNEcFZrYnNQVVFOV2FrM09UeDhBM2lP?=
 =?utf-8?B?czd5RjkxaUloSzQzVDVsUEh2REljRS94YXhaVGV1SVMwKzRIZkJJUmxXbEZK?=
 =?utf-8?B?Vm1TMHQ3c29kek00cXU4RTVaTy9INUNIVlRNUnc4UURLZ29YZXhKVGdYVWxi?=
 =?utf-8?Q?tpSBlROmeI2HJ3OgT+eStnpnmA2R8mDVv8scWTu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUNwdysrRERtTVU4cnkrU05XRXI4dzlDUS9mMHphaERzV2VUeUlhOCtzWVlm?=
 =?utf-8?B?bVh6a3BDdHlLbkNTczJpVnk4NFVYVFYwVFhqRVdWcmFYaEEwU3dZK09PV1Bi?=
 =?utf-8?B?YUVOakVtMEs0TXNHcHlqdXFYMUMyTzNzQS81WWpoV2JVUUJFenFxZE9qN05N?=
 =?utf-8?B?NytGWjA2a3U0R0w5MDJ2Y3ZMTmtyWjVLbFNwemxCVWYyTU9lbkhwN0pDdTRN?=
 =?utf-8?B?aWFKTGlDdDRuRHRpVVdLR2M2VzJ6OWRQMEZ4NEQ5dkNoYkRubSt3WHFsb2Ni?=
 =?utf-8?B?Qm1uZ1phNWUxVlViR2RxRzFYMGdoTjJIUmpnQ3hCTXdCR3IwQWxaSkFDZ2Q5?=
 =?utf-8?B?SXRiWXUxSXZmZWQ1YTFEYm4vVlFHSXIwT2wzU0wxQXg4U0hGK1NpbW01U1Rj?=
 =?utf-8?B?dit5Tk9UMVZWZ3B0bnFNdVNwOE10WVl3SGVjQnloa09tWEMwZ2lCeHZBTith?=
 =?utf-8?B?NFRiaGNSNVBGaWFhWkw5eFE1UlEwbTV6WkFCbTRYNElkdnYrYk5TNkp2Mnpn?=
 =?utf-8?B?OWVSWTM2a2prcFdQL082eHFhYnRoNFU4bDZuY2QveFhlMzl3NXpaUUlTK2JL?=
 =?utf-8?B?TUxWcHlRYWRKNEhueitTSWp2WmVocnZuMW1xL2h3d3dRQmtqUC9ZQnA1a2Fs?=
 =?utf-8?B?UGpYK0hHMysrWVBISUhJRHR6R2xRQjVlWHROL0ZUQ0pVd0phRGZSSkNreHNW?=
 =?utf-8?B?ZVBTMUhhZGc1SkpleWpTUE9mZGhKdVZobjVsMzJIVDdxVlhObjBjY1pwSmV1?=
 =?utf-8?B?d1lncFJmSVVLaTErV1BHVVFrbzdrcXc4cFlzTCtoay92bHhsV2Joc1hyQnNS?=
 =?utf-8?B?QWtYQXRXNUVMYmhvUEVvVXdMY0VSQ3RwSitxQ1o4KzZmNFY2b052bGZReXRq?=
 =?utf-8?B?SU1vS0JUWkt1SHAxeGVnTE9kQXhZRGF4TXNxT2MzZlJrTjN2SmNIRnZFUExW?=
 =?utf-8?B?bThDTlplNDZNN3NNVnBIMmwwUWRYZi9UTzhQTWZRWlppV2E4aE9DRFJSaklx?=
 =?utf-8?B?TVVrTmFjbXh6S1FmS1ZBeVpWVDdLVXJ3dlVsQ1VYNmFCbjR2Sjc3YUV3TXpU?=
 =?utf-8?B?bkJSSW4wZTJaaUdxQkJHc0RBOEkrMU5aNG5helR0TjBvbCsvclFKRThZWUN5?=
 =?utf-8?B?OW0wRFVNaG51RHFvVTF4OWU2N2lkaHpBQ0xsbmZObllmcWtmanpqdURyc3oz?=
 =?utf-8?B?U1F4YTdMMUJibFVkZWZtdlFubWJ2MTdiWERtaUNDc3puUGRiZjJ5N1V2bHVM?=
 =?utf-8?B?aEF3QWo1eHR3ODhWbnN5ekxnTWQvdmJaMmlSalNFdDhRRWd3WXF4Ny9wOXBP?=
 =?utf-8?B?NzNaYjNkZ1pEb0lDTlk3MVFFMXJnc0N3aEpyOW1rNkllMnc1eHkrb1U2R05U?=
 =?utf-8?B?QUE3OE05RytVdWE4REtwMkVZOXJ3L3BCR2l4Q0dkQkp2cW9kcDhpdFFscGd1?=
 =?utf-8?B?c2phdm5KYi9PaU5GSkRQZVFZc0R0QUdwejI2czFzazl6bkFXbHpLejdrZjR3?=
 =?utf-8?B?S0YyajZEL0d2ZDhqaDZmNzRmRnB3WVlNZVRkVFhPNFZ5eUVBK2RpM0M5c3Mw?=
 =?utf-8?B?M1ZqdkJKNTRNRTdmR3MrRzIzaW90SHdMK3VhMGVzdzlQNXlEZys5VERYWmVo?=
 =?utf-8?B?dmlkbXVxTTRERzRTaUZ5RURCNXI5K0RJMEFLOWVJRk13dzArSzBScVRYeHgr?=
 =?utf-8?B?VUk5LzZETzhPUHVObVg2aldiNFV6QTM4eVhQNmxlZ0l1K0pZK1BzR0NlczFs?=
 =?utf-8?B?anhValczUnlvcFpldlNCcVkwWmM3MVJZaDVSQ21OVU4yR2V6UVNIR1g4VXc2?=
 =?utf-8?B?a3NiNHRvUFlCbDI5ajZKNWROb3RWWUxhS2RjWmlzY3lHWkNhQ1ByTVl0eUsw?=
 =?utf-8?B?TExpYTVQTCtBVXc2KzZBNkZieXcrdXNqdks0SS9Fd25ZTzRrazBTRGhnRHR3?=
 =?utf-8?B?UkNBcjB0dW0xbUN3NEJ6MG12dGVwMmNDcUQyN05kSjZEVGRFYXVwK2VsTFRY?=
 =?utf-8?B?ZFFLWVFRYVhrT3ozRmJTREc2MGM3Wm9XTGpQdEREOUF4ck9MZ2R6UENjOUNt?=
 =?utf-8?B?bFE5U0JVV2NUamZHb3kzTEJ3dmZWQ2JhaWlyazVoajhYWHFZNC9NZTB6eWpR?=
 =?utf-8?B?bTNqTzNXb1dKSWFWMlpQMUNMSUxTeC9XNWF5UDZ2eS9yL0gzWThtckxReTNU?=
 =?utf-8?B?Mmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Z3NtUVz1aDfJY9vh5cF32V6eKj3KDro/Xunx48N0XP9phdWqLHQ8x++hrq0d0xrXjm+WzCcMADDUbqbSQvm4FSalJQUU0CoIM3rsOgz5Y5oTX/TTR4QumVEGlrvCELMPSc9VuhIe6bxYIoyzcO2WbZaRRxRtLi2pmt2cZO1LkDn1LrLqD25AyaHjyMsUVcCxpcOC41tisuyuZrf0keShKvgcZGUU6Y1LDbh1I8ZkGd4PJEcx5ghSZA0hl+fj8+Eiec2iZz7x5dY5YNGNljYcfJ0NSANxvu/dr93VtydC5UodRhu1ML9KsDzFaFZtfx+1kClvJ32b+YKJz1703C6hza00u3ieuOjbRAqE5aBmwTyx47kSUicrIQMTLDbR49GznDnii3jDrX6GYD/CFyHS4VyYP3yZeAvK7fa2/s7+I6bSKAUHXm5rVoDLy+w3vt7U3a264WdJUNGcsv6usi6ycL8wqJZfC7eHlo1m4CLotQj9psXzqbkkJWTE1M/rlcZcEJcVAp28zGXRQ1dHrGDkzrPixGDyLjhk8jXwokkJEMmmhH67QaEwRSxqy6cdxY5ygOSnEKXEBL/MjLhPf7R1DfZeyg0HnbTJbLnlQBG8Cbs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e71bba9c-431f-4f61-d9ab-08dcf5f25518
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2024 19:13:54.0026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 93CRJiHbm3HeJMLtmT8lOBO0gOZrmo886/ln4UXBGkyHNrDVusaR+kMgMdM4pI2nDIwiM14jTLyOTXOanR/erGVsCaCzODMpnoWHo6Tms30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7774
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-26_04,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410260164
X-Proofpoint-GUID: vFvvFclSSkiqpx_OKKNiZwt-cT9GBjkl
X-Proofpoint-ORIG-GUID: vFvvFclSSkiqpx_OKKNiZwt-cT9GBjkl

On 10/25/2024 7:58 PM, Jason Gunthorpe wrote:
> On Fri, Oct 25, 2024 at 11:39:40AM -0700, Nicolin Chen wrote:
> 
>>> I will try to reproduce your failures.
>>> What is your base commit?
>>
>> I was using the for-next tree (rc1) from:
>> git git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git
>>
>> And it was failing, so I guess rc1 is missing something for memfd.
>> So, it should be a false alarm.
> 
> Oh, that's exciting. So I will have to base it on a rc that works so
> bisection works :\

I'll test builds on arm to identify the minimum requirement.

- Steve
