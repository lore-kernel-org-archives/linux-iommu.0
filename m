Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC1519EEA7
	for <iommu@lists.linux.dev>; Tue, 13 Aug 2024 15:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562023; cv=fail; b=jXdFdC73aEH66ejRnlIa/K2mdyOwmuLOfogq3oFzsfYaWCt/o4sSh2lCfuIHwFhUpSSBhKreR9HZL5+Fh4D7S2EyO2AnJbdKVYR+mPMpA3fg6UayumfRwny9Oevel17ARI+PfD5j6oMP0iEP72lSJoL+3bCI+RwEy8vPRgXc4js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562023; c=relaxed/simple;
	bh=gtdn5wELeY+oqIPEqR0uWsBjhqWqSkEBVcnHrTyXjPE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BUggfs6eB7/FAOCwV+HjIeaRGApa3ara1OT1+QUhebBILhMcqag7hgqR1lgn1ykfpGW9zavQuN6wUGvtGlIrhval9s5PasPv9twugVhIu8mE6izx3Pcg26SLg8XaaMdodJLFqTsf4PFcOqbxlbmU0YslGqvxexEu8M+Q5c1dgTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U711MX1j; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qBbqbSjE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U711MX1j";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qBbqbSjE"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47D7twvO009231;
	Tue, 13 Aug 2024 15:13:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=sa4HfJc6IOdb+C0wMgENOyFPL88hqMfZE/2YQjr/JOg=; b=
	U711MX1jFMce/jWeLtgzFIE5xzE2kEfwWq7AtKG/osMwm3IkobPSmgkYcyWj0I2Q
	b6seseQs/GhwniSx02lLrf5GjhBKQCbfFD7vjxmd8admnYOTYm1k8n1+2qoBq09E
	EqXIc2P3ZWZ5bKoBA3Xz31TKDEP5nORkYiWXdYyhCVs62Q+vlJZyVOtMLC49/7c7
	AyYwZ0WUMkfcVLN64UxZUKJpWsDp/2PiorU+Cs3DGhUPisTLY5Qtg/pvqIfwd9yd
	m76+0A8d8STUrpIcKdpvs6kqOYOTDO/NvT3k+L2Epw7tnW3qjkDAKdf5QQ1y6tA2
	zDk0d95+6WbR4RC19I2yxQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wxmcx3ym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 15:13:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47DDsVqI017604;
	Tue, 13 Aug 2024 15:13:39 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40wxn9jpkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 15:13:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u7GKAn3P61YAuXYuQs44Ma+x8KV/v/G59L2Jx5/cDcjJ03r37LvagAXSwbWv2elHFq7QaFZa78xciHa79SHZ9SYoMKtGhfU2gGA6LjT6ew0hkaFoUGJZZyG/y5L7HrveeAOJxaRPBYs47aeKDjfYeJKqUhcmwk3oGjxm050toaAL/MtQenc9KZHktKOxunDiCDaKx4sQ6Z4aDLuYTfGigY2QWGKOFsjHfWr9jKuGG1koS/mXDfmvkJ3irxD+e4GGvDcrtSPgSum2daZnTY4TgKyxWhqFF4RYr8reT1CPdoEv6YPH2roJCyBn7Nsg/YPf077RRvQSwOpQpMNwlrASNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sa4HfJc6IOdb+C0wMgENOyFPL88hqMfZE/2YQjr/JOg=;
 b=bmJMX9MWbIvAvLA2zprs3zgBVrjwgTXaci0ucWG7P6FLyjqZ6u4WE/5NiwIgnyw0sEsdLVlONnINCvVve10aK1jQda7wj91DXPMb5tOUDo4X0TtKG4pkPWUIM7hlloXLL1x4PR1EkOxKNG1Tr0aQM3ck+JDxP9RPCyTdfyDvNgNPg9WGPqXJV96IpbO3ZlSOdmk6j81fuKjMJF0sAAUYnGCtqNcPTD6Zqp8dMHxwFAmxvMVoWzFd/3WIi5AlZpGYq0eu06Ef1W2E9QJapI7qul/GlQ9M96Q/YYM1wAcF9ih8w3HkyCj7FJV79iJt4DfLt+U4xIEQU46Y2pnHZoTyAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sa4HfJc6IOdb+C0wMgENOyFPL88hqMfZE/2YQjr/JOg=;
 b=qBbqbSjEyw4YpXybzknH3gCe4f/OtYvoahNYLA+2qr5lRSZnDUjaiMWXinupdYMZNHenkuUcW+5AtV2WoGstqNVnqfIBw8WsIUcDbO4saeni1gaQQDTfZJ7Onp6i6K6aV+3QXXzDBFUoHSJe2A1ILjvVL0Y1o59AVfSm47lZ2Qk=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by MW5PR10MB5762.namprd10.prod.outlook.com (2603:10b6:303:19b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.13; Tue, 13 Aug
 2024 15:13:26 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7875.016; Tue, 13 Aug 2024
 15:13:26 +0000
Message-ID: <932486d4-1704-46c2-8b12-4c122969030a@oracle.com>
Date: Tue, 13 Aug 2024 11:13:23 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: mapping files for iommufd
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, iommu@lists.linux.dev
References: <a745cabd-5e38-4242-b3b1-da02c1e670a8@oracle.com>
 <20240812184005.GQ8378@nvidia.com>
 <684a3618-ee15-4f85-ab44-3de0527f91fa@oracle.com>
 <20240812150516.3e33c5c2.alex.williamson@redhat.com>
 <b48cba98-cf51-40dc-9f57-4c1a7c493f78@oracle.com>
 <20240813143620.GW8378@nvidia.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240813143620.GW8378@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR12CA0020.namprd12.prod.outlook.com
 (2603:10b6:208:a8::33) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|MW5PR10MB5762:EE_
X-MS-Office365-Filtering-Correlation-Id: 46110ab6-44c2-4219-c7b9-08dcbbaa7b22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVMzdk9PVlpnRzBsMTBnTGlFcHR5akNnRC9qaERKaUdhYStFR1JsdWZ1V09y?=
 =?utf-8?B?NGEzZHJHZnhZVWk2TTZGS2orT1JvT2hWak5IWEt0aVlEZklZcnlWSmdNbWw3?=
 =?utf-8?B?ajJFc1dmVGVCT1JleWFnS0l6RGVsblRpek1ZSGF0eUs5enFMZWNBWDI0cnF0?=
 =?utf-8?B?T0w0NVgxU3EwSHdFWisxZnBiMCtuVExtQjJVOHoxUExuRmJuYzNvbWpURUEy?=
 =?utf-8?B?Yk9HRHNGWFJQQWdrYjN3cjN1U05PNFEvM0tpUC9salo0S2tOWVdleWVKbUxq?=
 =?utf-8?B?cU9VRzg4dmxzeHpjTkZzTUU2ZUlxdnJEQng3SzFGdXFEZm1ab1JMRk9MR2la?=
 =?utf-8?B?cmd3MG5EWEFNSTQ2ZUJTVDg2VnhXRXAxY25DNWZ5SGgxSThnV0psZ3FPTXFE?=
 =?utf-8?B?TktaQVpIN0dVYzZNYnFyd0dJMkRBcHJCdGlXOTVDVUNSUXZMZXVJdjlFRkJj?=
 =?utf-8?B?Z2pUQ21ERjZsS1laMUx5U3dyUjUxd0k1djFGZDJSa3hiM1BPWjExd09wTVhQ?=
 =?utf-8?B?aEtpSm5IZUNIN05RTFpmaVhpVHJRaSt3aGh2dmJUWHBOdFk1MGpiM2lpa1V5?=
 =?utf-8?B?RGtXbkVLekJZcXRPWDNlaUVlbDUyQ2NxOXEzYmNyZ1FIL2VucERlQU0wSi9T?=
 =?utf-8?B?YllVRGdOMUV4am5aanBDNS9sRXE2aFpQUGw4ckttelpPRFVWN3h1cDRmemtO?=
 =?utf-8?B?dmYwaDAwWmc0RXAyMkkvOVRNWXg2aDMwMUlIMWYrQWxXWnVEdEdCZXU3OXV2?=
 =?utf-8?B?dlp5R29DUCtxZnlickI2WjR6MFMyWHdVdEtibHlIdW5XZXBnd1FvYmpMOUVM?=
 =?utf-8?B?MDdYTjd3elh1QitLak5Ya1BzZFB0M2dlS0FqRlB1MzNlcEZpWEJJcllNdE41?=
 =?utf-8?B?WUR0bE1hNldPZGVDQ0tIS2hyNG96R0NzTHB4bE5CaDUweFVPYmQxcjkrQ3Ey?=
 =?utf-8?B?S3ZoMUhrQVJxMVUrM2tHaTFBcVl2WUZkWm1jUnYzY3gwdkJkZ3ptUE5ncmRQ?=
 =?utf-8?B?T0xKdEd4SE1SVlBoQXVobDhPZFJJRmw0UnlNY3E4L0tRVVNXbkxEdmVmTk5V?=
 =?utf-8?B?VnhPRk9KSGkyRVRkVXZLUUVBV2xqU2k3dVNTeHBDeFpzTm1POGZFSlp5OE85?=
 =?utf-8?B?ZkdtOTl0cHZPL1ZqSGtRMnozZ1hIaTJjZ25GYzBZb2xaU2VVcUM1Zmhuc1FY?=
 =?utf-8?B?K0F5cVRWUHFNellnQUNVSENCSkxCR3IweFltNnRLWjRHV0RYaGozQWFsY2lm?=
 =?utf-8?B?dENTWlk5SHhHRzZTM2hkUTB0OGUxZU1uQjM2OHZENFlrSVYvTEVoSnl1Vjd3?=
 =?utf-8?B?THhrRU5ZNnduSFZMSDZHWHg2a3FZY0Mrb1o3djJSWnppYkw0OFI4aDR6cjJ0?=
 =?utf-8?B?MHMzSXJuUXhNQ3JNR1Q1M0puMVQ3SyszcUpHcjRxZDBrNW5VMlYrRENjazFa?=
 =?utf-8?B?WXVUdXBUY0JuTmpLZG4vYnJnT2dhMEdJMGoyTVZzY3BkR25uZ2NwaE5jb29o?=
 =?utf-8?B?T1Q2NTZ1S05NVzVWdHFsbzg2STMzLzkvRkZDZWFNWjcwVE00SzVKOVNJWWdV?=
 =?utf-8?B?cU45OU4rRUJ6ckJiVWMxblVreFZxeEh0azE3T3ZuMjk0Q0c4Z3BybHRWcXlZ?=
 =?utf-8?B?SVJxRUQ1NDdRSHB4VjdXdE9VNkpUalVMYmovVlRyM3pvck5UVXJwS0FhR2JU?=
 =?utf-8?B?RXVoRVVlUkZaem1CQjVqSTdRdUhmV3pFWG9weERRRjdENnFEL0tkbEFUVHd2?=
 =?utf-8?B?UVN4QVM3SWgrelVLbDYzNTdCTHBveVdMRm5GYS9KWS9tZUlWelAyQWJXaXh1?=
 =?utf-8?B?M2swdUJsdXBMclFady9FZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFdzNUE2MDUvc3dyWmttYS9DeS83MnRtcUFJa25jMXVVUXVGN0hVazYyNmdK?=
 =?utf-8?B?eldSTmpkQ1IrT1pMWGJ5UE1kMEM5UEhCYXdmVUNmZnlWTTRnRm9mVW1pWmF2?=
 =?utf-8?B?d3lLQk56bXpmUlBFQkNmam0wTjR1akRsdU8zdzZmV2dJTkplQkYxZWJ1STNn?=
 =?utf-8?B?T24wcWdOcGZFcGo3N0NOMmZEZHZ5MU1ORUtlcnVLeEZKNmxac2tkRU8wb09w?=
 =?utf-8?B?bUNDOTl1ellSd0ZJUUNucndGaTZBV2tyZ25VS01FSEVuZnJscGw1a2RSbWdo?=
 =?utf-8?B?VTlUb1R0TzBCWlYyK3NBcXRuN3hLMTVsdHdFK0FCUURYbnhmOUtnQkxPWExZ?=
 =?utf-8?B?RW1xaG1HTDlrTjNvWXhsN1NWRmJlOW5kNERaOU9kQjVBRTlqMzVwa3o0RlJH?=
 =?utf-8?B?eXR2b3ZSUWl5eGRtcWdpd3kra3lHSVNQSEpSeHJpb2ZSemZXaTBpTDN0UWFP?=
 =?utf-8?B?NlRNQngzRHh4bXV0Zm5vNHZpR2ppTGwveklxSXBUOTlpdGN5RUIvSzNyajl3?=
 =?utf-8?B?a2ZBR0Z5K3NMNUsxR0Q3NFJRTlpLYy9nQzBrVFZvK2ovTHlEaVYxcGwyNEph?=
 =?utf-8?B?STRXdWt6K0xrTlRSTCsvNGVlMXkwZkV2VVlLMDFhMTNIR0M4NS9DUHJ2cG1R?=
 =?utf-8?B?dkYrOUlEWVVMLyt6ZFFZaDd6aHorVFBpUVdsSzRkSnhpa2JJcVhGR0xCMzU0?=
 =?utf-8?B?TmxINllZb0h2eENKR1dZcy9pVnZwYmc4SzYxZVJxQnUzK1ZVbU5mK3BZeHJU?=
 =?utf-8?B?TE1Dc1hmeTRWOFB4RFFlbzYwYXAyeHRIMUVZTE1qL3U5QVhGeXRBM2E1V3FK?=
 =?utf-8?B?ckNZQktxOXpVcndyejFHaHlCQUl4NGdKSzZVY3ZPeEhjbGw0SFNRZnRTQS9i?=
 =?utf-8?B?OW5aU3FPUjljMHQ0aWNlU2NIc2g5TllsdVh0SG94L1Y3ODdsV1VzaVR4a0pW?=
 =?utf-8?B?YVY5OTJHTFpDMGhZSEVFenRkclRKMG1OOFFycFFaZytzWHJZczB1YTRucTh0?=
 =?utf-8?B?OEtab3RqN3YyRm8xNVpSQzNmZmY0TUNLd29YMEoyNWdxTHVMcG8weFdFTGly?=
 =?utf-8?B?TktWKysrV3Fpc3BVa3pxaCtINVVHeHZzOTRGc3BJbnJPNWthSDNvWTJVNmIz?=
 =?utf-8?B?YmpHdWRHL2hnY3dvMXZtQ2gyY3VuOGVDaktlbmdyNWJKUlJJQ3pnWlduK3Bj?=
 =?utf-8?B?bFRLaDUxZENWZ3hHNUpjbm9aNjFJck9Td2xubDVWS1I3cmdXaE5MYlh1ZzNo?=
 =?utf-8?B?UWxxNHBEUzdRRUFLZWFhOGlaV3dKZEpCL3ZSbVJBV3EwaEgyTS8yUlZaYjZH?=
 =?utf-8?B?ZmNRbldUVXFwMmFTdkJtNmdRRUVDdzhMaVM0TXRQdVZFOGJIZ1FXNDFhM0gz?=
 =?utf-8?B?VW1yb3YyOHA1Yk1ReUEwZkNXMDExWTlSK09MMWxYTHRwdFM4T0pkOFQrYWhY?=
 =?utf-8?B?VUZVR2VqdXFQN1NGQnF1aXpiUmRVVmRGSlJGU3dTa1kwdGl4WTlaUzhXSC9O?=
 =?utf-8?B?cGNIdUxXQjhJVTJYVVIwK000cDlWemF2a2oxZHFkNUl2bjdhODY1ZXpqbnhH?=
 =?utf-8?B?TmdBakphdm9sSWdlamF5NTBiWWMwSWlFT1o1dHNwWEN5ZFRmZHdabzh4VnRk?=
 =?utf-8?B?RUdmMTBPMVBweFhjakt5TkJWRXN5WnZubmlKdG55SXZXSTRMaU0zQWNTdjNy?=
 =?utf-8?B?SGtuWDZpT3ZwSGg3Y0o2MWgvUXZkdkZUQmtLSWFQaG10Zms3U2pNaVZmMmN0?=
 =?utf-8?B?ejFUUnhUTHI1NkpKYkY4S2FuRkNwQ0Y0QVd1alFHS0R6c0dqb0Uvb25saXlQ?=
 =?utf-8?B?R3U4YXpHb2psMHpmaVpOMUFrUXNFdGNOZEJKNW5ZRmtzWCtrR2UzR3J3RWdi?=
 =?utf-8?B?QlVxM0R3WFhCdnFpRkJ5UnJiMHZ5bkhxajk0SnpmS3N3dTNzLzkzWVBiZWFm?=
 =?utf-8?B?cllpL0NiZlFZQUpjSkM5blkvWmdRRE50dmh6SzJXbFpWcmFwcjkrRVJkeCty?=
 =?utf-8?B?UlluMFJyS3RlWWFZYXRGdlA0K3pDWE9yaVh4aVp6VkxCYm5SdDEzOW04RCsy?=
 =?utf-8?B?TXFXd1VxOWF5L2xLMklMT21RdkF5R1dQbFdXaW4zbDljRWttV1cxZjZ6d3Zr?=
 =?utf-8?B?bDMwdm9FdC91M0hRelUzaGVOQ1VpbDlQTU1TUkI4bmFvcE1jbGVCZGJjR2M3?=
 =?utf-8?B?WkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZoTMd1MfZkmn1ju8E2JOsqSw2l8x+x4767QKoWyiHI8oWDj4qC0SUNmUXY6uaeTaHJoB65foSAXohpO3s8E/brtFhf7OIH6Sw5qikNL387Cri1fRJMfhNPXZY1PMAqRnekSYGiXsgdEw2g1SIvxB1AO6erg46U4WEg4Yth4NFA+ceYO0vD7T4mF37ljjLEOBIquqnfV9Bol+bf/AZfP/iYLi2exXZsPeiB55zyuopUXh9NC7ohaCCPHCdwaVJfRiYAVHXUFrpHQB5+t8a3hL4cntpHiGhiZ57ZuWO+h/gD818G2sOpFg/8aIidNog/qaqDxJ42tv0M3xt796R6s6N+/RWKxORU87C9rbwS2s/gc6UBDb5DJToASBx4x/OysLk11/obqm9YteIOrje2udT0BErdFipmBMFLfs8+No8OjfRS/lZlYOkiUzhBt4SHRbS9q7GSpkJX2Ytjsff972KkW23MqE3vMvSjsrFC4HXkZ6cD5HVFrIouziJ8IOuYT4/Ie9OorBMkHrjjfv2p9PKyd/frJCkqT5c27KwtCFIHFUdH21QRKSxWorZ7RDQBFljBQDpAJTOkCcOroHlG6neFw6QNratXwBC4mltqID614=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46110ab6-44c2-4219-c7b9-08dcbbaa7b22
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 15:13:26.5477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 29HhjVcaEoO9ZujYWxArJ+UNRJwoGk1WENuY+sHu8AGbMptE2OCvKEICeIlNDSl/ybRMcZc+jmDoInscvTfSZnIwC9VcoUWaY+Ck12gGgj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5762
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_06,2024-08-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408130109
X-Proofpoint-ORIG-GUID: jl94slRvSA-TuEyQU_HE4Wnbpv5G_uTy
X-Proofpoint-GUID: jl94slRvSA-TuEyQU_HE4Wnbpv5G_uTy

On 8/13/2024 10:36 AM, Jason Gunthorpe wrote:
> On Tue, Aug 13, 2024 at 10:23:10AM -0400, Steven Sistare wrote:
> 
>> The correct explanation is my test succeeded for an older kernel, based on 5.15.
>> It failed in 6.9.  This change in 6.4 (which Jason quotes from above) appears to be
>> the reason:
>>    8ac2684 mm/gup: disallow FOLL_LONGTERM GUP-nonfast writing to file-backed mappings
>>
>> I do not question the need for that fix, but I am surprised that QEMU users have not
>> complained about new kernels failing for hugetlbfs plus vfio.  Maybe most are still
>> on older stable kernels (as I was).
> 
> hugetlbfs is supposed to work
> 
> Normal filesystems are not

Thank you.  I flubbed the hugetlbfs test and created a regular file.
Fixed that, and it works as expected.

- Steve
