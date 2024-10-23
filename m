Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7D713B59E
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 20:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729716342; cv=fail; b=Nn6bX5ZYdJQEvZGTg0AP0ZZRNUpmEGsRnFj632oDKGgMjfWkKtKDtIcfRQ4secgtxsWVVKE6DvYGnJlSKOC9RV8ZF4MAoef+ia9bCA5sheaw4bM+Ys439PxuNQ4QZpQva8KJVJwz5ND6tiguzogxQhx6Qg/h+xR/WmRIH1jb+pI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729716342; c=relaxed/simple;
	bh=AANKcPCnon5XHGlgIhgNgDrIFkApUHsnlSBOyf/+LRM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vs+ccBlh/RnFNl8/v7DNytcna+sjwiKHvR9VyA52fgAAdslplTXcMTciK5LqCRjuymmQ1DaMIVbYepk3XC1Aw1+GJTFAeSKpFroh+ro1/x8f0405KIIPAvkvpCxvQ0T5CJ+zGo2LMWJ5iolhqa/ZyS3H8ldpk9cjgDABafHRdyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AlknZzHC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=w8GZM1PF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AlknZzHC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="w8GZM1PF"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NKcS5m005207;
	Wed, 23 Oct 2024 20:45:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=0Xvtj0nqZlD6uCs7C/uS/xpMCl6pggVFz0Ez/7TL+GQ=; b=
	AlknZzHCEDA8DRGd8Wpx6UYbxkU5Zwy0sNt8MGUJOsjYZcaes66ITicEuck0jmof
	x7UbaL5CqkxkisMtPGQ2S4wwaQWLp+qApNvcWexfd8duuUG41xfLjbIwbKaDerMf
	5IU3GJPnTH6Qj0ZjrfDv5INLwGVGb2ENXlOOtVKABuHOcfdIjKTxi+kwU3j75Nfi
	bfZN+AHIwgEgRz9La4fKTIM7nCld/ZEXqlLaBcfq4eialVkFsXDh59URcVpo3HcA
	sYJrdRylM7WUAqf0DHC3i5ueigdoypCFft/m7MydsUM9M5duuDehe8JGSoQjsksh
	LrdR2Zyfl+iCUUQjgdw+2g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ckkr0efa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 20:45:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NKIAcc031093;
	Wed, 23 Oct 2024 20:45:37 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh21g1c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 20:45:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tFZdtZ/+KIqfpiVxl56pMOyj+jIbgk6066ysXjMZf/XiLRKr+nGJODK4xcQgNXiz5b8lcLK2jDAW9knV8KmUVPXqKdyORmTgIY5L2JyElsK8XqabaS8mVOM5lujc9hBAr5iuvaCamQBkIAFRrbXrg+ZNGwsjQl2OJG+sIghv79+sDPeOT9JXbVmlldZrtIDdzdRiX3Gpyb+XeVLDFkPzDZLvvdCtqIZ7zVAdbASlzetC7yEw8t/lPSQUi3pCDxCWSAyXqb/tx8y133pTKmecK3RfTlI/Y5apFCIYi8NpXchdSSIAZNKiZ6sKjuxN3caakQQr53GpZXwyD2pNoHmbOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Xvtj0nqZlD6uCs7C/uS/xpMCl6pggVFz0Ez/7TL+GQ=;
 b=A7Zdsnp7HPxgKFUUwMbliwVCTr/KE+aflYhIaYgi0tto/7r7JEV5hGgitCneAtV04Ekky8mR7BVjfVIdlAu0ePOGjJMCDl7AZfLzHmXz0jWDMh8B/VRnN1O0+Z1Cx8zEFmr1UxHFMtDAv0oPqrvQ9zT4Il6uqHkPkhrdSI11sUiA1DkWN0FDYkeYlyWedEikTUACPiSlkDROvdR80a+MeD8ZThQUtnz5BWVD8mmHqIGUd3vHfDVendPAKRdiCK22EpI5bUE/Zoay3tXaQ3s47RhCGrr75/est+q9LawGRBEWZT1ezMT0MaNU9tBhubAQydtTsx29O+ZMWjFcUgDrgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Xvtj0nqZlD6uCs7C/uS/xpMCl6pggVFz0Ez/7TL+GQ=;
 b=w8GZM1PFpZZqLwqfdivWfoaSy1hGQzxR5jyrmxYbogmD9l0w2N4b2C3ToiOaNlpQ89jeI6vmdXd3QoZck67CNPdLLkNDfcxTfrz9C2yaM6pFZKqPaMGUileVbo/mcK5JwbrzcHXe1dX1f93tNKEtzW0Ctt4HzLUCAN3Zev9jEWI=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SA2PR10MB4700.namprd10.prod.outlook.com (2603:10b6:806:11c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Wed, 23 Oct
 2024 20:45:34 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 20:45:34 +0000
Message-ID: <cc72218d-d4c7-4d42-9745-c5351fd8563f@oracle.com>
Date: Wed, 23 Oct 2024 16:45:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 9/9] iommufd: map file selftest
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>
References: <1729630838-24586-1-git-send-email-steven.sistare@oracle.com>
 <1729630838-24586-10-git-send-email-steven.sistare@oracle.com>
 <ZxlZbBP3XE6alSPe@Asurada-Nvidia>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZxlZbBP3XE6alSPe@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LV3P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:234::31) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SA2PR10MB4700:EE_
X-MS-Office365-Filtering-Correlation-Id: e5eaf479-ad6a-46af-dc11-08dcf3a3a496
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dUFOUkdLUklHdkFHNHpxdC8xYjYxc3JDbmtxbFFPU1Qyc3ZvQUdjeHlTc3hB?=
 =?utf-8?B?UzdNUE4zVWp6djVjODRQcHNON0VDYkJMNmZzNHhGSkoyNzE2UWtzMVB4QVFn?=
 =?utf-8?B?ei9KZEZJY09KcUY0cnhhOGNPbjc2TU02NFprWjJ4N0pVbTY1R0VrekVpc25Z?=
 =?utf-8?B?Y2o5Z2R2MmwwTEMzdDB0WUthZzA2bjZnQmhETVpWK20rcmg0d1pzZmU4MUhO?=
 =?utf-8?B?WU1EUzBTY253bTJBdWdXSVM1Y0REakZQZ0dTQWdFWmF2QThzTFhXMG1NK0xE?=
 =?utf-8?B?alBLaWRuVmN4U0dpellJVTRubEU3eVRVNll2SzJUa2N1cDJsN2JFbEp3K2RV?=
 =?utf-8?B?MnV0c2hlWUFqMFg0MXZRZ0JMNEp6ZkNxU1N0a014bk44b1RNWnZTWXBwdHhM?=
 =?utf-8?B?OTJ0Y2g2elIxYk5Ua1V6amNnT0VmU1FPdkYwanJPbkY5blpjK0tPajFrWkVL?=
 =?utf-8?B?Y0xUWW90YWphcFlzY1U1ekNnenR4V1hwT3VGcDd3bjZCdzNrTk5SUzdBMFBj?=
 =?utf-8?B?enNhM2pwWGxFdGZCSkdYRjhtdzEvZ1ZsWG5RdVQ2dDZUM2lMM2RHZ2l0YVNM?=
 =?utf-8?B?OXdEN0FDNHk3NzQrb0tRYkZMejg2N1h2MlNqRGZvTWlxcEpYckt0eFl0VnBE?=
 =?utf-8?B?ZFA3eStoU1p6aGREUVA1TTFGTHkrVkp6RHViajlzWng4ZGZuMS9SMXpsNjd2?=
 =?utf-8?B?Q29PYzdxNllSTkdBR3RyZ2l5QXV6WVVoR0lKeGcwMFVyenhjc0dISEZrWUN1?=
 =?utf-8?B?UFF1bkVqazhpcDB1QmFDcCtNenRBMWs4OEdKeXgveUtMUVFIb3Z6ZTZjbmR1?=
 =?utf-8?B?bC9PT21rdUUyRndYbmp5ZnVzU0ZIRDhackRuVmo2OTdWNUNwMkw4WXhIdFN2?=
 =?utf-8?B?LzVhSFlMSk1pRWlSaTkwWGFpRHdMRlpXdzVrYkhEcTg0enF2NkVoTXQ2NGhq?=
 =?utf-8?B?MnVGcENvazZTSlJBa2RWM3dDTlMya1NCOHk1MXFKOW5naCtiaWo0S2VoMjRk?=
 =?utf-8?B?WGkyZ1ZLYWR0VlZycGw2Y2U4Qm1UdUQ5MkoyeU9kelFQdlFBU0FLcUhlRVk0?=
 =?utf-8?B?TEVuR2llNUtVL3M2Q0IyYW9aeWhJL0YzTklZeXlFcVI5WVJRQVhBaWlnZG5D?=
 =?utf-8?B?UFdvdUNmRVFqTWxodk45RlZ6TkRNSXlkdjlHWHVJb1JXbDNKc3lnSVpCL1dm?=
 =?utf-8?B?NXdYVmFqdDZTYTBOMHllZ1JOdUtzWTEyNDdSK3lDNjllZkMxeGRPRnBuSkNK?=
 =?utf-8?B?T0Z0UlBnZnV1bzAzMU1Jc0RSZTdCVHF2YnE2Y0ltMFpvemdBT2x4VWF0M2hK?=
 =?utf-8?B?OFZLaEQzSTdzM25vbXR1cklXcHBPbFpmeWpVTWpsME02YVF6aU5aVnpIQno3?=
 =?utf-8?B?Z1pUUUVuZnkwdVYyRWRyUG9zakNFVmkvNURhd0NHYno0TGdkZk12NmtINk85?=
 =?utf-8?B?U1FHVVBjWHB6N0p3S0YwRDA2STg2ZEtnMTFtQnM1RmNsSyt1WVNNWCtISjhS?=
 =?utf-8?B?V25tdVU4NC85N3k1TW9SU2M2VCsrWk1CMGZ6OFY5Vm5MaHd6elBoem43VHZq?=
 =?utf-8?B?MDhWOHRON2RmbTJHak83aTNXL2VhZC8wcDFxdlY0U29xN3VVb2FBMGRPd2ox?=
 =?utf-8?B?ZXhQRkRNcmwrM1NseUhYMlFobis5UXlDWEJ6amZQSENTalpkRmxUeXAyRHdI?=
 =?utf-8?B?UkZMcXN1OWRFTS8wVjZMV3U0bG9ZdFZMa1NTM1ZIMk1FQ0E2QjdVWlNrOW5k?=
 =?utf-8?Q?EwcaEZWq1qCCNmKpxNVwJgLZBotFgdZ52zKzwFL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1pzQXowZVJIYjJiYU5NU1RVWnVxd09MMFZvNUZsWm9TZlZELy9VVDBCZEda?=
 =?utf-8?B?YzIvMllUQ0ZtVzVtSDdIRmJOaTE4ZU8xODArTHVTRnVTbHBtaEhVdWpxaHVi?=
 =?utf-8?B?T2NoS2dmTk5oeHd6Z2pVbWs4TkUzdjlKc1BNRElYT2xGQlRDTHVLeWxzZ3dM?=
 =?utf-8?B?ZnQ2b1ZQcWxLaTZCZVFITHRib29IYnRNaU9Id0VGdGhZTG5NQk03MUFYTkdW?=
 =?utf-8?B?YktjRkxBazdNWmNoREtpR0lyT2plUjE3YW5hb3FCTGU3V2gxeTFGdFJLbXRG?=
 =?utf-8?B?bjJPYTdiNVVRK0NQbkllS3ZndDVzWTQrdXYrZFpCZ0ZnaDVFTHJyS0xITHhW?=
 =?utf-8?B?eXFMK0pPVkQ0S2M1UGJXV0FQL00ySkpNRm1yQ0Y3VU1UWEhpdG5oQWpyeVhG?=
 =?utf-8?B?RkU5c2hIZHBSNWNVRERhTDhtcjB3aElBMnllbVExbnFGZUI2eUg3cDRERVhx?=
 =?utf-8?B?RC9RWDJDZHppb25rdEZHMi8zc1g1RUNlQUg3dVFNUVAyOHd2VE5pZ04yRUg3?=
 =?utf-8?B?WGlxMFRmL3EvcFVuNExXVm9UMkZ3c2luYXlEUnZ0aXNHUXJxL0pzSUlEY1du?=
 =?utf-8?B?VkcrZDdPMUdkVExKK0lSN2NsNERXMWVpR2Qzc3dQTXM5dGhaMzdVTWlBVmJv?=
 =?utf-8?B?V21wa3VjSlpLOGFmeFJSMEoxYjhkN0pEQWEzKzdKVm1ZYTJlT3NFWktaRWZI?=
 =?utf-8?B?eVAvdmJ1b1M1cFJXOU40QkJwTFNrUFprbzNUWHY5Z0srN3VDNFg1Tk92eUk5?=
 =?utf-8?B?TVp5cTVScEUydWNtcDFpT013Wm1ENHAzNHBqdzl2TlIzRmtRRXRnR3VTTjQ1?=
 =?utf-8?B?RlhCcDJGdXF5WUY5OGhtVXY2U2hoUmdIeEJPSnhYdVVBbUtqWGZkWm9NazZ0?=
 =?utf-8?B?ai9EQ0FXWHBLYVhqN0JvaUprTW1PYWVZR1Q2SXlucGRrT29FRzZrSWJDc1FH?=
 =?utf-8?B?VE5ydGRSb0FsU1hCVFVFZUx2Y2hDdUJLbThaR1phbnNwNHBwVWtobUdlazR4?=
 =?utf-8?B?bDV3R3NTYVB3OFEzbGhMTFdWZFhSSzdyaDNKNWx2SWloOFZRS0J6NkN1MWkz?=
 =?utf-8?B?RXV2U1JBaEdrTjRNNTB2cit0UFlKV2tDMmxyTnRsVmhvMHNYYW1KSmh3a3kw?=
 =?utf-8?B?OC9xOSt3QWV3bHlOMVpoMDM0aHBQRnhta2dmZ0syTFl1SUVjc1JqOGpHcXVm?=
 =?utf-8?B?TUJKcGxodXhkcXk1SGprdWpTdXpGc3FIUk5UTGp5SHZHazA5REJTdjlHZUtr?=
 =?utf-8?B?NDByaGJDZGhCazRINmNqUW1RM3NObmQrMmF0MFR1ZWV6WWh2WlM4K0FseWww?=
 =?utf-8?B?TUdOdHdSdG0vREw0TDY1OTY0ZlpCZXp5Z2lmb20vNU81ZVNKMWIveGpjVzJP?=
 =?utf-8?B?TzZaT05sM1VuT09VcDJBNlJ6dUdsSi8zT2lDNHErclhwbGlPbGZaQ0ZxRW8w?=
 =?utf-8?B?cXMrcmgwbUg5OHNqVHR1ZHpZREJXWmg5c2V5U284U09NREQ5dG1uQm5MaFFI?=
 =?utf-8?B?djBTN24xbHg4bGt1UnNvRVVXN1dySm96am5WQW9INVpEd1FiRHZSNERBMHVW?=
 =?utf-8?B?TnhONVhHT2lqMnFZZ09wMms5bnBGWXRJMnp2NHMwK1MrZmZzZzZ2QWQ3Qzg2?=
 =?utf-8?B?eVZyc20xS05lS3liVUo3aFpvUHlVTGtaM0dvc1Yyb1F5NUN6MElWNFNvMGZz?=
 =?utf-8?B?aEVvM2gwQkgyb2JrbGMzeUJ2QXRWQXlRU1E3M2luaVkwWUQrTjR4SlFkKzJF?=
 =?utf-8?B?VHBtQlFpNm9iL2JMcVd3YW5oU0tFUVlVN0hCUytJcXpFZ0xJd00reUxJRUxV?=
 =?utf-8?B?MUdRY29GMkVBTTIzNllQVE9wUXU4MkFyUGdaU2VaaE9YbXRxejJIdUdXYkZM?=
 =?utf-8?B?UzFaNGhwWWh2VjdhSmtCc214WTkrc1BKNjlic2o5MkNRaE04aHZnZU9vbGZp?=
 =?utf-8?B?SGkzUkZUQW1ZVnNRQ0V0dUV3TEg1aHQwMFRCRFpSZldTOGM1eU1SemtFdDFR?=
 =?utf-8?B?WEhyZVpmbTdPR2NMZzM1UjFRZElSKzBrbHkvTkNqZzN4blpCV01UQU9hT1Uz?=
 =?utf-8?B?bDFvVHJmelBheUJlcGxWb2VQcC9Xcm5CZHZFWnVETUxhekZ5OFN2bU1vbHVU?=
 =?utf-8?B?VXJ4NWRJdUxyalJqMjFaODRxcTZkWDRIeUVtTUI0bGo2T0hDTkMyZFdySHJu?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Y5iF7HUWQUuSTXzJIHMbvDZbhh5ahIQ9WUj+lhLWBW4HPAOFM2SQ554LwlNxhLG9x5hNz6iAWCA1XJsGpTKlqUUfQ62rrB519H2Us3hfowCIgMSWiHmyh0bkvteHZPHHIPFg4UbHXO5gwDuRhJCTpZvkAgS2UCA9fgAYW6PENpqxHIszmDniM8BeU2Bd54rB1RvuCA4F6XB/RTXqnjt9lI16J6BOcAx8FrAY/79X8x4Eg7ahs9NevfPnBZOophze+wZUEiedV0K0Eb10yZU7sxdY7TBFxA6b39hj7YLBekv2q6A57fX+LpwzUs/pNzP1gD3NuoAPFXJCxKQMlqiXPzNbu3sHq6ZDcx39aK0QrXFCD2M8vh0+idvQiULNT6KxXy3MkEaOnNynwXhObkdA4t2mlWy4qexOrWs+tykekwOiGvhmFKtx/yBbaQ47L2+usHQojhdHS6AYYHAhCHfkfOlPlWSz4bqvBKk82/KuGW7o2/ETAx1g1lIhyH0UuzJAL6rPNCJ4YrFHvqilKxbpqbADZHpCMm/gXp3I7ixI45O52e494IgP7DtoveorrG9f9HcHUn7WlaFP7M+Jo/jFQBUuAb4i1j+DAjcnr8tGDv0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5eaf479-ad6a-46af-dc11-08dcf3a3a496
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 20:45:34.8024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z5XIiktFG6dt9TI7yZfSMWZw1pFceT9XJYRHsYrJIbSAxbEZdDCeHEg4vxf7D3UbSpdoGZlpO+igseGo/OGbZqXeesdet5fxHOWWD3YhPI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4700
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_16,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230132
X-Proofpoint-GUID: 2ojuKVvUyt78xw78tD2yvNxJVFdGdr-Q
X-Proofpoint-ORIG-GUID: 2ojuKVvUyt78xw78tD2yvNxJVFdGdr-Q

Thanks very much!  I will fix all the nits.

- Steve

On 10/23/2024 4:15 PM, Nicolin Chen wrote:
> On Tue, Oct 22, 2024 at 02:00:38PM -0700, Steve Sistare wrote:
> 
>> Add test cases to exercise IOMMU_IOAS_MAP_FILE.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> LGTM overall.
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> 
> With some nits:
> 
>> ---
>>   tools/testing/selftests/iommu/iommufd.c          | 136 ++++++++++++++++++++---
>>   tools/testing/selftests/iommu/iommufd_fail_nth.c |  39 +++++++
>>   tools/testing/selftests/iommu/iommufd_utils.h    |  57 ++++++++++
>>   3 files changed, 217 insertions(+), 15 deletions(-)
>>
>> diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
>> index 4927b9a..3d62951 100644
>> --- a/tools/testing/selftests/iommu/iommufd.c
>> +++ b/tools/testing/selftests/iommu/iommufd.c
>> @@ -3,6 +3,7 @@
>>   #include <stdlib.h>
>>   #include <sys/mman.h>
>>   #include <sys/eventfd.h>
>> +#include <asm/unistd.h>
> 
> Can we add it to the top of the list for an alphabetical order?
> 
>>   TEST_F(iommufd_mock_domain, ro_unshare)
>>   {
>>          uint8_t *buf;
>>          __u64 iova;
>>          int fd;
>>
>> +       if (variant->file)
>> +               SKIP(return, "redundant test");
> 
> Why is it redundant? A line of comments maybe?
> 
>> +/* iopt_area_fill_domains() and iopt_area_fill_domain() */
>> +TEST_FAIL_NTH(basic_fail_nth, map_file_domain)
>> +{
> [...]
>> +       if (_test_ioctl_ioas_map_file(self->fd, ioas_id, mfd, 0, 262144, &iova,
>> +                                IOMMU_IOAS_MAP_WRITEABLE |
>> +                                        IOMMU_IOAS_MAP_READABLE))
> [...]
>> +#define test_ioctl_ioas_map_id_file(ioas_id, mfd, start, length, iova_p)     \
>> +       ASSERT_EQ(0, _test_ioctl_ioas_map_file(self->fd, ioas_id, mfd,       \
>> +                                         start, length, iova_p,             \
>> +                                         IOMMU_IOAS_MAP_WRITEABLE |         \
>> +                                                 IOMMU_IOAS_MAP_READABLE))
>> +
> 
> The indentations are a bit odd here. Would you please do git-
> clang-format to fix them?
> 
> Thanks
> Nicolin

