Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01067205126
	for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 18:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729275036; cv=fail; b=vEZkdkUmmjo4hQqPqvw5nrMZLYgkxoizNnxezpO1svcmuXZ/UH7kzVtC8ZoPPb/PR+UhTRfLfdFHDruMfgYdljbNodOG2yRJEqXKKJ7VNhErJ5cOiCANZIR5O41k42HWT58Tgt8/28JORVaJMOa7oaHL1xevrCwMuIQaPJfEwoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729275036; c=relaxed/simple;
	bh=T7PyP5vKIWoRc8AqjtEdmyN1IlkKxmyfFw0HBzofIt0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iaOxP23Toegjt+jnnnVXsWktoeLc79yhhFoirRdAJTWvQX2ggm2+T89GP2zb+XeTWk2kZvergidNByVhepkL6aPWdSwjOsuFsVayObPWnITU9Xn1ERiMSSWc3GK/JhQ9OSczfB7xcJQt62LTYkIFNkl+FJ2UR+89LEUxvAePGAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bwrSogjx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VHhEoMqv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bwrSogjx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VHhEoMqv"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IEBf1M005772;
	Fri, 18 Oct 2024 18:10:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=V35MGcTJEzx56c4uBr8YhzeawOmb68hlQqQWwaLiOtM=; b=
	bwrSogjx8tG9sOfTdScJmvwo1Rdk+cMvmR0Mup4MvMok0leWM4c6KRZK7AxvmA5v
	py1ueYqG6EE0i2PsseYv1ue4fVAvdZXaR26fRCjJt3n/hT2R8mmDFTdJboUODHYP
	yMEAvGghFaFSLnvEy9nmHLx/4TozmDOcFxAdFj0YnnxJb06Qg28k5WzBaYyMzHEJ
	RiTYJCy82d1Zht/qhM2Jrp9cr0UMavdesslXWYCe64fWF4X9u9Do4WQLvZeJAhEe
	l0NaMWjZpkmj7N4wqxPa+gvWnESd2HfalBt9fN+pk6dEnnpTZfZsBxkKsM72bADt
	kiEtfJEPRxeNXyaKvYZ5Ug==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427gq7sf6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 18:10:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49IH00vo014022;
	Fri, 18 Oct 2024 18:10:32 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjbw1cq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 18:10:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=an4KB+KV19Yc9UrOR0JduLK017r3/SFue8zw1gCKtEgfJEzTOktRlEKF3IDyNwyFrAD/fisjzhJiybbo7FIWOcoMYeE8/E5PNBlxVtgxy8FZSvRtkEzqNHJe1tOl/biYcNv4F40ZMe9axvNRAQqZ9dG8Wd7bav0PPh1hbsvcTqQsQpGiSVg0MRi2N9GvqlSeOzxU5F2dNjI2fswwbaLe9hdI1l2cgVJICjTmpeiRVUsSK062ieN2k0aeJMqNfMxiT4OaZjSBOJrNsfoY85CT/wxhW3khSEu4GHMAyKbY803hXzAxqh/nMgQGPeeGk/hGxWnaWuI871meWoxfR/EzzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V35MGcTJEzx56c4uBr8YhzeawOmb68hlQqQWwaLiOtM=;
 b=fjieszx/npyIRguvabmjEZZ/I6myVvwmivltZ1BEEQBXpuOX7GzYjcruG/bglRJ+zv0qVmpwGuUOqlrntQq2Z1VwwBcW2qOUoR2NrB8aeVWHKQ3MkJxhy+qczMmzZJAtj34NvJkUJ1VjeJvQuhsJIqlVE8bmZnAdWA5pu7vtVZe+72dZfIY7/iNYUMvb5KiS31BVPzUR9c/BgMUn5gsSf4y3NsOgD3P6m2RisxZp3KxfofdtA1RGEq0wf5NHg/mUxP6zpqszYWK3j8bio7KHd6c34t+Qm8xcHBQdzmZpkqxk+ZtmbPfpY5yOTJLv4TQ4wSFsUgse+S692Num6Vu/sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V35MGcTJEzx56c4uBr8YhzeawOmb68hlQqQWwaLiOtM=;
 b=VHhEoMqv3MEQYilfcgso1yhOLtg6r0EvOejr30PjaN/efi5JUkYxgA14e9+4xNBJfWQjHipYHRZ3yxSLhtT7RaVcvN9iFXLILmcbWBvCG1COStKxV5/RvitaYGP2QjQbc/DCstsw00BBkr7yjWm/skfb2dOl0Ec7MoL2EHiWwWo=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH0PR10MB7536.namprd10.prod.outlook.com (2603:10b6:610:184::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Fri, 18 Oct
 2024 18:10:29 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 18:10:29 +0000
Message-ID: <55027ff1-05cb-4ce9-adad-8dca586a26ac@oracle.com>
Date: Fri, 18 Oct 2024 14:10:26 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 8/9] iommufd: optimize file mapping
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>
References: <1728067700-32092-1-git-send-email-steven.sistare@oracle.com>
 <1728067700-32092-9-git-send-email-steven.sistare@oracle.com>
 <20241016130001.GI3559746@nvidia.com>
 <6fdad0c2-8b6a-433e-9405-016aaee40413@oracle.com>
 <20241017192418.GD3559746@nvidia.com>
 <c4574487-346a-427e-a97d-6e1ee366ed1a@oracle.com>
 <20241018001046.GF3559746@nvidia.com>
 <279c7e80-1d72-407e-bfb8-d286760a5e11@oracle.com>
 <20241018160430.GJ3559746@nvidia.com>
 <dc59dc36-027f-42c1-971a-8218c658c5a0@oracle.com>
 <20241018175951.GK3559746@nvidia.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241018175951.GK3559746@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0032.namprd08.prod.outlook.com
 (2603:10b6:a03:100::45) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH0PR10MB7536:EE_
X-MS-Office365-Filtering-Correlation-Id: d2674f8a-025c-4874-e933-08dcefa02605
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cEFsVVJXNDF3cDAvQ3ZvMWwvTHl1QVYxUUw0V1NQRDNINVJRUXFCYnFub3Y5?=
 =?utf-8?B?eFNXV1lpemRUN0ZLN3g1SEZDUTFVSm9DTEJLMms1MTBKaDJnRGI1VEs2S0lp?=
 =?utf-8?B?c0NpSHB3WmtoSHRpeC92dWI0Q1paRTYrcGY5OWdYaEVyZUFiQTRwSVpVWTMy?=
 =?utf-8?B?RDBqMTRxZW85T3p5ZTRiUm5ieHdVWWxqL1djcFhVWk52dWJXcmRpeG81K2Ns?=
 =?utf-8?B?WHhMN3JHK21qQm5VVmVLWmx1R3JNdHNnZmdKN3JyTnhIdjg0YVpOdVdRWEJx?=
 =?utf-8?B?QXVia2EyUlQ0UWJQMTI4L2RCNjJLemkzblpQQ0hHc2lYVms4cHVoM3p1Y2ZL?=
 =?utf-8?B?MldhN3VKd3RUd0tIWTJTQkttb3FoLzQxSXl5Z1hJU1EzMXJZTHRTZi82cS9a?=
 =?utf-8?B?SEF5SFNYbzdhVEtFZzA3bStxZGNjcE1EVG1qVWZsVU5acDdFN2xWaDFOMmV6?=
 =?utf-8?B?ZitPWElVNFprbGtoSjIvTUR0NEc1L3BuN0x6NEZsa1NBbGgvMjF4TnJxS240?=
 =?utf-8?B?ZVZlRk82WWVlRnY2dWVuUjNPSmxTUHZrOFNoZi8xa0RVSTE3dWJpVkQxUVpK?=
 =?utf-8?B?V29za0VvWHUrWWJYWHhPcUcyK0dySklPWlcraVUzTnNYR3pUZUgzWE5qOUEr?=
 =?utf-8?B?ZVB5NWZ0UE5iUHIxUEZ1QnhPM3J3TlVoSE5TRStrVVNyVWgydk56ZmsvQ1k2?=
 =?utf-8?B?cnhmczVHNmFHbFcvbnYzSmxFbmx6RHZ4WHNsTWpzaGZhMnp5THE1VlZUUGRN?=
 =?utf-8?B?V2JNWFAvdy9SamVzcy82Y0xTMXlheStjQ2dOV3NCNU9lNzZISjNMOFlGdDBI?=
 =?utf-8?B?d1lzbm1qTGk5RHlMTlNXaDA0NUJzYi9ldE1kRVBBMnRneWtta3F2WEdhRFNB?=
 =?utf-8?B?UkhqT3hGYWh2cGFzNit2ZEoxdzR3c2w0aDB4Uzg5ajRaK0lYeGUyWE5YTHJy?=
 =?utf-8?B?WWkzeVl4ZWs5dEVETWlWVlpuWGtRSFZVZTFUcVYxa3Jra0p4ckRsM0lqME5v?=
 =?utf-8?B?bHIvWkRJd000TDZ5dWFPUlJncEsveDdydXBrT29YYnk0d0RSRWlad2NRa0N6?=
 =?utf-8?B?MXFoWDNBdGt2cEN4RGZKbkZzcUZSWWUxSVJDTE5uZVE4V1l3SzF4YmFJZStM?=
 =?utf-8?B?Y3JHZkRYUUxsVGVPYkdiak1CdVl0Tm9DU1VIMitCa2pwVG81QXVLay9mWWg4?=
 =?utf-8?B?V1Q5ZDJ5MmZFOUtOTnBUTjB4TkMwWlBsZWswMW9LRStBUWN1U0xYQUtVeUVu?=
 =?utf-8?B?amdYS1NlUURlOVd2ZWUzQVVSWDkrRDhERy9LNHU0ZmowMHM1SGFoMnVRNjEv?=
 =?utf-8?B?SGh3QXZqM25zSVJaN0FSREpyN2NpNlk4Q3I5VituaVhmSjJzeWRRRkxKdUx2?=
 =?utf-8?B?dm1ZTEhmSllIK1FCZXNza245REYzQnlPQ0Q1SERKaEpnMXg3MENJdkgvRWpW?=
 =?utf-8?B?by9OY0pCWjVyc0lCWFZJNnloYmZTdjN3eXNzbkRFQ1l6RXFpL2pKekd3VkZK?=
 =?utf-8?B?OUhlZW5xalAyQ1FjU3FuVEcyRUdJNTNZbEhUVlJLMFU4N0dQbUNEL3dUZS9m?=
 =?utf-8?B?MXEwSlAxdFRUNXlzQUFWeVM0K0pVbzhNMWRyWERQRk9XR290eGVCSUxqcmVQ?=
 =?utf-8?B?Sm5oamhBd3ByajEzNXVIYjQ5QU1nZkt6RkVhVFFYUXdQTnVKeGlkTGMxcklt?=
 =?utf-8?B?TGtCM0N3Q3Y2cWpGM1VNaTN1WkZDdXdmRU44MEhYbjhDc3ZmUTNjbGxEZDFU?=
 =?utf-8?Q?ik1Df2Lwwln4r/tpTiST7WzfghxJcqsRHMzz7IE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXVUakpCc1FBYmZSSFNBZ214MUNqM2RXOUg2TzZIZ0E4eXNmR1RTOUVFL1Bz?=
 =?utf-8?B?ZkpUOERyNUNCUjlsY290WmNxd3B4N0pRcWF2eW5IQ3VmdWJkWWViV2pLeVpk?=
 =?utf-8?B?bi9Fcm1TZXhXTEJ2N1A5WTZIdG4wTHoxMjhxdExMTU9OS29OQjYvd3B3MEtn?=
 =?utf-8?B?MnJsdFlYS1I4Rk1UMTRsUTRiUmwyWnk4QkEvenJPd3QybEJaeGNTbWdCRXh0?=
 =?utf-8?B?dzl4U3N3TTlpa2VLZ2FFZVE5aEJnR2hsQmthVnZyNUZleGxWVmtOcWdteWZ1?=
 =?utf-8?B?c2pMTGp6OXNiRC8za0UxRThjUitTS2FJSndPY0VTMCtMTElpRC9ES3I1Qjhz?=
 =?utf-8?B?Lyt6T0gvMW5rczR3VFV1cWJqUENwZ1FFaFMrTmJEdlFCVDZwTnM0YW5lK0Vq?=
 =?utf-8?B?Y1BCdWJhbkRTWkJxUDQ5REE5YzVXaEFrVlV2T2NEcTJPa3gwYjRzL2p6ZSt2?=
 =?utf-8?B?WnZ6KzJSTE1SWGhadFEranhXR0l3T0I0dEswTGVrUGEzYkFLZTdDdXNybGxl?=
 =?utf-8?B?dkFpTUwyUUIyaVZVdkpKYVdUeGhORVBwOFpHSVdrdzJlYmN0M3A3TS9JLytV?=
 =?utf-8?B?YjZ5QzcvbCtocWVjVVJYeHltWXQ5LytnelVYTjRob3F4ZmlTTkhJRDF2REph?=
 =?utf-8?B?UUc4VzB0bUhDNFdxRk5MMXVGYjA2VzB2ZDVwelBVMEhSTGUyTzFSazdwRlE4?=
 =?utf-8?B?UnhhQTJ0NkFiL0Q2cjJXSVZkVWtnNFN0TnA1dGFybXhwck81N0tDZUhGZlNP?=
 =?utf-8?B?bGN6Q0FHV2VVSUJsVXpYeXhGaGFLcUlRVlVKdHRaUVJEWEhwMmxrK3hqbDhs?=
 =?utf-8?B?QkRKVlhnOGdKUGFmaVFMd1BHa1BpdVBNV3ZNOHl3YVczK3RtZk5OdGpId2wy?=
 =?utf-8?B?TzZNYlUwelJ5T01zejFlbE5kTDBMOUI0UFVVQS9Na3B0UnM2OUlMWTQ3Mkc3?=
 =?utf-8?B?a1MycjhRUHdyUnB5QjVMSCtQaTM5NnFraXNPaGNXL3dPVG8xQUVZRmRDYmpi?=
 =?utf-8?B?QkViR3BHRHdTdVR6Z0hmdURHNzg2Slk2YUQ3anNFd2xqVDlHRDErcTkwK1dC?=
 =?utf-8?B?THRMbDUxUkpJUmhtMVpESkI3Q3I0Q0pmYjc3VjBlRlBKenhhQ3hrdmd0d1dO?=
 =?utf-8?B?OVZsbmpQZDBCVDgvRG5Xdm8wZS9kbnk2bDQzS3pXY3NObjd5ZGFpRHVQVFdB?=
 =?utf-8?B?eDRKRkNhOEVyVWQ0VzRaMUlBNGNFK0FpOGF0QnNQeW5BSnBsVFh5NHIwVlRv?=
 =?utf-8?B?SFNMeDNOV3VBOGRwc2tyTXFIa0U4cENPekNIN3RseGJ3ZkNZd0VHSXhXa0sz?=
 =?utf-8?B?NDkxWkFTWCtESHZreGdFUjVvaStnT1lrZlJhUGQ3NEVlUVF6SCthSXlUL2VE?=
 =?utf-8?B?OTErWkdPNndpOTlmVlRidEczVGhuSHF6azVhbEFXMGJMU2F2YUg5VE5KZ0ky?=
 =?utf-8?B?Znc5L1R2cFM3bitFKy9wYVFFb2E4QWQ1TnBZdjdjOWhRcDhtekVKS0k0WmxD?=
 =?utf-8?B?L3JtSE43c0FvOGExWjlNT1VOdjNPUGcrSmpKRzRFNWVNZTdDVHd0Z0huVG1p?=
 =?utf-8?B?MGQ1WXRhTEJxK1pkS3l1WDdkZWNXYUxIdzJEY2w5UWhhM2tRMlBiSWFmNzk4?=
 =?utf-8?B?QmZ4NDh4YjR0eVdXalJJbDFhWmR4NnhrUkJHOU5NU1QrZ2NmMUM1MGp4ZzIv?=
 =?utf-8?B?SUNGOVNEb3E5MjljbmVvenlFODBKNzZtM054NDFRZFhJZEM5WFRRMFJyRUhS?=
 =?utf-8?B?UmsxYTFLdm1DTUFqOHdpeUE4NEYxSExtMnV0Z1hjc3ZZdHZIVk0rY0l2WmJC?=
 =?utf-8?B?S1pUdVNNc3N4b0lNSHlXU0YzU3UvNmpjQm16TEE1dS9uUEdMenBuSHJ3SUND?=
 =?utf-8?B?RDZxengvMnNxWGNIV28zb2FoUVFNVmZGL0RORTZsMmRBS1JyUkwxV1NwMUo5?=
 =?utf-8?B?S0Y2N0QwVEp5VGZhaUdUMWwyMmJ5SlFvS054a1NJVUg1S1dCVThleU8zYlhF?=
 =?utf-8?B?WStBRG1MZWdid3VmWWl3a1ZQTVROMmg5SExwRDJtek9ENmZVaTlIRVIvM21N?=
 =?utf-8?B?L3NZbkh2ZWZsbVUzMUtZTC96M1N4bEZxTWRtR28zQzlYS09GM0c2ZmNIQlow?=
 =?utf-8?B?YmlyZTc1TzMwUDBzdkMzVjM2TkxnSjY2QzNXOHFxV25DcXFwR2I0RzJzUzJM?=
 =?utf-8?B?Unc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	10qWHUAgko2kTFIc/FZ9fdAtiPff/z0a45Cd60x5IS1FvTQUPeWdDL0jYp3M/YgigouHA6Idvx5JXDb7kS5QjVPKHldAA5QYrp5K88e1FBycsGM0Zqk+6n9OqR/0X9R3j7uZbJ1+sOTIKdYgzKy9KGucuVUfWQf29JpdW2jpRdufRzWzxV6RatcK7z1gQgX6RU6D9Qpv82T+fBQgXH1Z2gjI/7TCwSI+paDSO8blSNdVkXRm0vYn8Q3VVcqRZfqLMbPDPfdJmQVBPdSSxRS+ZV+/uczOfzhWsf92g5jk0BpzKnVk04tVCaVrg6TdZ+ERaXjRbv3dO7wiQyUJE9XOnH5+xxNhXrSJ1GhjJtqevNygzJJkfIoSsePk9zn5Xm4yrGSiR5jzKxfDpB5ijh0BIShjwAmywJ1iifcqQa5etfMRWfNP1TghrIagixnbH9cBjVsIGCyIB6O+Gj6MmWG4cVJfX3YMaThghM7echIlPviv2MCQe1Y9ouyjrGFbDDYkFk6+ikNg0VPA7ne54W+4l92mb9A/VrcNZWtw0g+zB9GXtUVvDUjKQN8DRUsEq9vfcFhESx0kx1AqQksqLovKAontQA0bi5sM8GQ9V3XV4pg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2674f8a-025c-4874-e933-08dcefa02605
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 18:10:29.3444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fWui2HJHFYmqrAdxjoPrB4mp134Wqi04C088PqX0Vr0DL+wxc6kAaN0XmlBbDNAbZinQsfSBwv4vQma9zz3Mb5ZknycLMUA6DGjI0BXP0d0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7536
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_13,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=951 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410180115
X-Proofpoint-ORIG-GUID: VOYSurYan5HO-sjCJhuWuTHoywPJ1mao
X-Proofpoint-GUID: VOYSurYan5HO-sjCJhuWuTHoywPJ1mao

On 10/18/2024 1:59 PM, Jason Gunthorpe wrote:
> On Fri, Oct 18, 2024 at 01:54:12PM -0400, Steven Sistare wrote:
>> On 10/18/2024 12:04 PM, Jason Gunthorpe wrote:
>>> On Fri, Oct 18, 2024 at 10:34:39AM -0400, Steven Sistare wrote:
>>>>> Ie instead of things like:
>>>>>
>>>>> 		batch_from_folios_huge(&pfns->batch, &user->ufolios_next,
>>>>> 				       &user->ufolios_offset, npages);
>>>>>
>>>>> Where npages is the total number of pages inside the folio list, it
>>>>> would be nfolios.
>>>>
>>>> The problem is that a batch may reach capacity after accepting only part
>>>> of a folio, a condition I forced in testing by reducing array_size and
>>>> MAX_NPFNS. We need to track which folio is partial and what is the next index
>>>> to use in the folio.  That is ufolios_next and ufolios_offset.
>>>
>>> But why is that such a problem? The ufolios_offset already handles a
>>> partial folio.
>>>
>>> If the batch fills you leave ufolios_next alone and adjust
>>> ufolios_offset. The next iteration does exactly the same as the first
>>> iteration and takes the partial folio.
>>>
>>> The refcount has to be handled carefully as the the portion that has
>>> been put in the batch needs to be refcounted at 4k and the remainder
>>> remain a single ref, but that just means adjusting the refcount after
>>> putting it in the batch.
>>>
>>> It seems like it just works naturally and avoids the double loop
>>
>> Yes, I can squash the nested loop in batch_from_folios_huge.  (I was off
>> point because I thought you were suggesting something else).
>>
>> Do you want me to delete ufolios_huge and its special cases?
> 
> I think yes, if you can get to one loop then it would be a degradation
> to sweep the folio list an extra time just to figure out ufolios_huge.

So now I'm confused again and don't know which "double loops" you want me
to eliminate. There is still a loop in pin_memfd_pages.  It calls folio_add_pins,
which I could push to batch_from_folios_huge, but it also counts and returns
pages.  It must do the count because the caller calls iopt_pages_add_npinned().

- Steve

