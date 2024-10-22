Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF28B1714C8
	for <iommu@lists.linux.dev>; Tue, 22 Oct 2024 13:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729603630; cv=fail; b=kHaiVydphri6Kc0CQZXfRYiiJSaf0Wk5LYBq98aEaAS2n9rz42pbSOAJ4/lh3t1SY21Ea8pWJkMX9NuNAhcEuQpQRbVolmN48kScnfxD9cp2LKwZfaQEFTsEbFqxngKyUzn+yNbOKs9pZJKd3N0S4cEqe3C6ftS2LeOIvnReFYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729603630; c=relaxed/simple;
	bh=fUlKx1x8JGZVUTaQ91eF6pFmJY1r0xTIph3HIZQukkw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a3p/F68mBOLrs6bmfi5CsmFj/w0/Otogxv8yKBEfygvLuhuc6Ji/yOVJ7PxcH/bKdIP2wMajq7AEHbNQ13bpi1hoel77Y6N2/h0YKtvuUJkKovZefh0dmKEziZwjQ54ohoACbw45yMhAEx6/YlBScfBMomyDs+sIh8XJ3HvhDaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JdsTlVWJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yGRECk1k; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JdsTlVWJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yGRECk1k"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MChc2g004596;
	Tue, 22 Oct 2024 13:27:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=feLLasJDiigB3q8M5mQj5UzZPllEFfeSuE4mmOm1wy4=; b=
	JdsTlVWJA7LgIX7qIwGvyEoawE1Dc7YsPCv++IhK17PZqgoffg9hr6gofYsnotvp
	YET1c0PAXXLAJnKWNqmVPaICfXRQOe+thjZxG8l8tgYKYhkBqynXDCE0FtfWlg8a
	bJtc4jAJ+L0ZTR1nYru5hXx9RTCXcsKVgGzqv6RC5L18ARrA6ZOLY+D830z1ljcJ
	w7X+Z3QCMhIA0s2tVlM8E/2UMaPrZU2sWXmHVtOPnxYDuQaXJZItrYbw6adKPZ9D
	jjguel/Q+IQwlXHlwjRZifsjf83Z/Fyvmk5jTCCDGOZUqxHCYIi/cGnnKGyQkeR6
	7IgQT8jqCBt5acxqFNefzw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55uwhv4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 13:27:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49MCIo0Z026242;
	Tue, 22 Oct 2024 13:27:06 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42c377nq9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 13:27:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LvwbgyK1RfZyDdNMorLP0m9y/ghL2Mgt2oqRvXiAnZzRspjYKCR0mlVA1fUHU4CPikXZFc9kPyMcjR+j9qEWySZtnR3DOBgT5dK/oz6+m5zsUH5HxqyzPM67sMhHxUXt2QKJKXkfRi1N350cUR/TTQhtEAgzlH7SpH+u9KNJV2CqzeTV3d+o1Il+lc0YDp2+ueQgsg+u4hsi/DrbU0IzMh7sUohVbWKplBv+t52APJyIXRRL174chO4XoJgIGEV7a6jT2f6x9QBALgDEleWdU7VOvQ0UAEvkLlN5XmN3MatSUJtEDeDZ9ECOAYoBM3dInMYq3EjXrNaOmEQmhIE0zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=feLLasJDiigB3q8M5mQj5UzZPllEFfeSuE4mmOm1wy4=;
 b=tVYxCqYKyKbghwjXKER1dBKnv6iB0S3nuMwyzr63HNhY92sHYl3EySLGOP/DbqxfPgmfNTqrKMozkSTnWgR3g+tx7UBA5/KnAdSPjmj2eSZ5hGb9RnOOXtbv/pHKG2aTbmj0njCZ8LpMAIYV6xdKsG0ElHnH2Ilke9Z6uFHCM3BCNkrwZ2bYUf6hjNqIvP2Ti+qeL3pkUqJlcJhjm3Ezodt9/j3s4xLqRe+GoopLApMN0Ozu0GU41bR1e4cJ5lKOjOOp4mDpyrBFoOJixyIx07mJKKqtGFrQrLLbw/2evFDddZLXa2wPGDpR7AiFIGqZRmCk0XH4wg9ztwu56wu8jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=feLLasJDiigB3q8M5mQj5UzZPllEFfeSuE4mmOm1wy4=;
 b=yGRECk1kzv8foAcEJqhReS+2wWlYo6aWOf4wXvlVq0V2Qd4WFsJ3yg99/EFsd0VfGMwPNSXto8ALUXMovt96UqCGuXsG1kenco5xLjrOhGD2fJQtjCyT6DUOaBX5T3zk+oKYsXttV6D/AUe+sBreBb2KQoNOgRPCQHdeYoi+jmA=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH7PR10MB7009.namprd10.prod.outlook.com (2603:10b6:510:270::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Tue, 22 Oct
 2024 13:27:02 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 13:27:02 +0000
Message-ID: <4cd1c3f8-3223-491d-9f57-46072ef8482b@oracle.com>
Date: Tue, 22 Oct 2024 09:26:58 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 5/9] iommufd: folio subroutines
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>
References: <1729286856-127844-1-git-send-email-steven.sistare@oracle.com>
 <1729286856-127844-6-git-send-email-steven.sistare@oracle.com>
 <20241021173021.GC13034@nvidia.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241021173021.GC13034@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0079.namprd05.prod.outlook.com
 (2603:10b6:a03:332::24) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH7PR10MB7009:EE_
X-MS-Office365-Filtering-Correlation-Id: c5679787-348a-425e-40fb-08dcf29d36b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjVIY2kvckVOS1NIVlBmNlRqY0VMWjBNZCtHWEhoWW5Ha29PbGFEbmJlVzRm?=
 =?utf-8?B?azlBemp0MkxQSkVLdXlIeWpaUVJheWRTQ0xKRzYwNHRwbDRuenV3MS80ZG03?=
 =?utf-8?B?UkdKNktqS3BGWk5DNkNTRWtRZFpIWk9NS3haUUdhUHFkT2VRbzlkdXgzR0ZS?=
 =?utf-8?B?SlhJdTc0T1M2R2dtZVFobW16YktBUUh1ZWJUMXJML1lHVGpNUW1OVUNRYy9j?=
 =?utf-8?B?WWd1bGNpcUFldzV6NkxoZHRtTVVtcVU5bTF2aEtNbmI4MTVHd3UrUGtJQzV5?=
 =?utf-8?B?V2NrWmxPOU5RRmg0SjJ6aWVmNXVodEZEdVhocmc1NzMxWEdZcFNjZnJRek44?=
 =?utf-8?B?dmwyTlhtOFU2SytFTDBJbFVNV3lrWGsveVFRMmt1QjNoYitGWk9WSFBCQVgw?=
 =?utf-8?B?L3cyVmt1eG0zdkt3QlhidnVHREVmLzhRVVMxaTBwajFTK2hxUERreDI4dXQ0?=
 =?utf-8?B?Y0E1UG9kVFRWM0dWcE1wT244WnpnNU5ONUI3cWJ2Sm5nZ1JZTHNxMzF0YTN0?=
 =?utf-8?B?eHp6OWJadk9kQjBoS3BCNU9GTmtSQjVaaTBKNmFFQTF6NGFGcUhUTHRiRXYv?=
 =?utf-8?B?MVFWZ2tNblptMHpkTUxkUjBzeE9scXNwOTAwV3cyV1RaYWswblluUDJhTWdY?=
 =?utf-8?B?UWJsU29mR1lsaWl0bWhXTDJpVUUvdjNZdkVlUi9KS3FsamFITm9OOGdUN1FI?=
 =?utf-8?B?VmtwbEQvWll2dW9CZkx0U2pBS3ptdHZWSWxEQXlwcm1sWjZJUnJYWlJhVXY1?=
 =?utf-8?B?Vkl1VHVxbjIvMmFNaTFVSEkzTkQ0MytIRGhnTGhDMUZVRlJJajBORVBZY0Ev?=
 =?utf-8?B?VjFmVW5CUU45K1ppRFByeWw2ckFIYlNpTUZCOXVnTlJxWlQwektrVVdQT1l4?=
 =?utf-8?B?R1Y5NUhHUFppZWNpc3VJQXY5bWJ4YjMvSGR5ZlFqcWxONmJDOUNhczlyM3RN?=
 =?utf-8?B?M0pSWk5NTGJIamR2OStOWHBldTZCRG1wUmxvMG55eEpZMlNmcnpZOU5NZ3B0?=
 =?utf-8?B?eE1lbkw0ZUh5RVpTSjhvckRud1dmN1AxeHNESldnTVBKVlpKWFlGRFo2VEpB?=
 =?utf-8?B?emhhOXk4RnkxbVo5R2VCUnN3YnBMemdUMnQ0UzFzRjNUNEF1eXdaUndaOXNV?=
 =?utf-8?B?VFUyRnpDbm1HWFM0TXNMZ2RNR3gyVEhaUjNmalhHaUNHS3Z3M1dWOHdGckJT?=
 =?utf-8?B?am9uZ1NQR2VHU1BmaTNKcXV6LzBjeG1qWTRNMkFaQ01XVzA2OUV3MGdyVEZj?=
 =?utf-8?B?ZUJjT0IzTy96N1Y5UUUrVnRqVHFPRFBoc0pLZXkyYlNUKzB6N0ZQaEJMSGx5?=
 =?utf-8?B?bGJLMGF3S0M2RFdVV2lFVFM5OUxxVXNYbXU4SlhCMFVkOGFvT2JXcXFxTWVL?=
 =?utf-8?B?eVUrTjljOUNGRGtlYWVDUFZjQVBhWDEwaUJlTzdHR2RVVUpkQkJtSEpPblNF?=
 =?utf-8?B?SUJYQXVZUVNGNkpseW1BZU9NYWQrd3B5ZS9WcVUzV3JNeGN2K25BblFhSENU?=
 =?utf-8?B?YmpDbGFEa1BYUUdwYWJFR1Uva3JiSXB3aEtucVp0Y25tK0tlVVdJU2xmcEl5?=
 =?utf-8?B?eTZMR2d2djlqamJsTEZGQVA1TnFDMVgzQnJzTXMvenRac2RSRzZBOCtmbklI?=
 =?utf-8?B?aFAwVDBHWWZhbFM3RXVBQUo4emh6R2V1d1NQdEN4cUlBdC9DNXNCNmh4Ymxt?=
 =?utf-8?B?blR6aU9MeTlORWwyWWlSblRER3NGeTNKbFk0cnErbE45TzNXVHVjNmk3QVJC?=
 =?utf-8?Q?0i8ZnqQLc4NUZOHyngUw08vlsYeF9yXd4Y+E+oc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmtlMkQ5R3lOS0VRUFV5bWVlWEJLWTlWUDBKOWErNFp4c1JGeDdNRzd4K2xl?=
 =?utf-8?B?ZkxpU1BTM085ei9HVkt2ZUl6SXYvaHhiK2xhSHNIanhUUEtuOWRGQmZubnRz?=
 =?utf-8?B?VXczakowbEp5NlpsYmV4RitVN1JqVnlUbnROTjh6bDFvUGJwcUNIQmJIclR4?=
 =?utf-8?B?a2FoclpHVXRKUDA3cExmOHlydHBMbFN1MzZXMUQvVFRFdmpNZlhpQkdNcHpD?=
 =?utf-8?B?QjdodFZXaFdRQU5MalBMV3UvQ094L0h2c0p2VFNwNjV0RWN3dk5TVXFNNkxF?=
 =?utf-8?B?ZGV0NkM2TDVXZC9PeXpQaHVwdWs0bU5WV3UydlhZb1lZS2F0elVzK3NTSXRm?=
 =?utf-8?B?MVRhd01mNFhzT0FXUU5PMm1RNk5mbDhTei9XUEF4QUlkS2lBbzhGK3pSaStD?=
 =?utf-8?B?M3MvbktnUDBCVXdMamxQVU14S1ppUGlHeUc3TmpNd3AySG9md2xPY0Nva3hO?=
 =?utf-8?B?bDRVOHRDSnhFUTh1Z2Q2YnNiY3NhTGpuR0VNNWpkWHBJaXJNeituMFpyUi80?=
 =?utf-8?B?RFV3R0hCLzR2dmZaQUNnSC9SdVlSSklwNjVTM3AxZ1JYSERiOXQzSXUzYldS?=
 =?utf-8?B?OFUzK3NzdGhnNXdYNGFGbHF3UTNGU1BiMVFaQWM4NzRsTmlBQzdUd2J6Sno1?=
 =?utf-8?B?RXdFelg0dmJRYjlxSHNsRWJkdnFscytTemU0ZDZxa3VYczVJTW82N0VkdHpT?=
 =?utf-8?B?VmhMbzFHbmtoRmk2TzlBT1BJOVB5d3F5c0lMbHJtN0hIOWFNOHVSQ3lQWWhS?=
 =?utf-8?B?MUVWMVZKazZRL3N5Y1d3Z3ZZbGM4R1FLM0Ewb045WVo2Sm56djA0dHZtMG5j?=
 =?utf-8?B?ai9VNjJ6K290dEs5cjg0eHJpdzcreVhlQ2tGS0lhZzVYWEN2Z1J0ZnlZWWo1?=
 =?utf-8?B?NWhlcTE4ekdXWkZ3cEtNSDkzNDhhUG5XMEthTjRvanpyaVdVRzRLSC8vek51?=
 =?utf-8?B?MGtIMzNuWHI2ZytVME1CRVQyc2ZVQzBxaVBGSUN6Kyt5ZXV6VWZHejF5dnVE?=
 =?utf-8?B?Q1FGaEJOZEo4b1ZkMU9DWDRJSU44VzdEamRSYkI4elgzbUQxRXZ1NFljRGdT?=
 =?utf-8?B?ekJmRUxldXpNTEtlTmxSajEwcWk0aWtFRmxZZW1IblExeWsxQTZvZW5reXhi?=
 =?utf-8?B?TTF3RTc2ZUlXSGpHSXpCODduRGdUOHA3WkRwR2tGUGlndk9rNUovRmlhOGJY?=
 =?utf-8?B?VFJwYnpVS2d5dnpDaThVZVpaaytmY0t4UmtJS2kvWG5zcEtJVnRTdjJmMml6?=
 =?utf-8?B?R3VoMWlWNDVmaExCdkpzN3c0MU1GK3FRZ1lhYTNoVnMyRHIzL2RhdWc5VXFI?=
 =?utf-8?B?TzFJcFQzUE5ZMTVVWWhTbkxSVzFsZUozSERyT0t4d3ZGY3U1VVlRbnZYeTQw?=
 =?utf-8?B?SHZlbWoxalBnaDVWeHBNNHIvb3N1ZmRFdDREQ1VYc3cvckV5RlZaNk02Nlox?=
 =?utf-8?B?dHR2U1RlVmVONHcwQUgyd3ROd2NzTmhNbWNvaDFDMkxGeG51TUlHeFlmYkN0?=
 =?utf-8?B?TGtJeHZyWFZBZVByOFpSeS9XazBkd3BlVW0vSEg2WWxleXJkcE5DdEhQY2dn?=
 =?utf-8?B?NzM1QlNiTlQ3aEt4OFRjanJWcGpiNnprZHJZT3BpMXJyTjZTT0t3a1ZQZHFL?=
 =?utf-8?B?NVJlNTJrVzYremJaOTRIUDcrK0pTSE5GclNGdUNMQU9sRmdLVENQZlJwM2Fs?=
 =?utf-8?B?VmRjVlF1NGZYYVFpS2J2eW10VEdwbkg4QW5IUFpXUStKdWZBam5DclMzQ1dC?=
 =?utf-8?B?dGtPTThiTWFSaysxUjJpdHhhdmIrWklwQ2JnTU9rb2F6QlhvcUwrSVBJTWMz?=
 =?utf-8?B?dm52emNoektpTTcyYi9XYm9LajZ4OVMxR214b3U5TzcvdTNqcFI0N0pqTUNP?=
 =?utf-8?B?Rm9TWVdzN2l4UityUnhwWndTS1ZiYy9WTXlISlJaVDRIaldZSWxHTDdONHl0?=
 =?utf-8?B?TlEyOTF2V1I4bEZBUXpjTmNDSnpiUVhldGZvTW5XQ09qVFlENDZiYlROd2Zw?=
 =?utf-8?B?T1h6WGxONXZYRGpSdTlNRG1mN3ZsWDI2bE1YWnZweVN5cWlieDh5REF0a3V4?=
 =?utf-8?B?dEVhTC84Q3Y3MS9WbVZqeElML2NJS25pbW9jMllhTm1oM3dKVGlFMEdDR0xl?=
 =?utf-8?B?ZXBteTdNSld2ZEpScEg2cTNROHVYWXlUdm5RaEZiSUpBdWJsSUk2NWdBd3VY?=
 =?utf-8?B?V3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gtlo0KEm+qMBP7nNqaN3rbxWmYSKepzJBWVnsg6BQBeEkHwHLH2JepeX3BqRXtFvQbzj8kXOQ8x1Bvt0Tv5Pa1+Y7yHyspe6Y4ajuZB/nenCHo+REhyjeV3sqGyLom5BUQmvQkdxEshK1OzqqUjYP/TBlkmxgcrsqqseALCNiBAKz4rWqR5bHuKqar+1EPd3dSDT+5QxD1keT7OkfKWeXoQunWVIY/6TYYFP5vJBmhOcq5a6OfRpOHYC7Sjt9qUp6b5MIgweKA5eVLU/dTu2ejrlUuMX0fWlUOzCpRlC+PvL125knNCtdQO8WhKAbVHiG/CnTVC7rfqoOGilofdcsXUuDGB4z11ZAI9T5pplZz9p7HAfvmgvbfg6HKO1firRUQBO0qrW12dCH1EKVPciAs2cJsgTxKeVm1QqSzXLN2s1EIQJziNgWqCLCPKDEa19hTBT0nWnjueJm9/M0mQhEpohT6v7Q52+NJ8YJaa62hRT3EBJJv1R4Qg+FJXezHiVC5vpC/gisvfK1YTgA+JedXxhMN10niRUDJ3p/KFK4TyrPNiLgZvmVlJASQo1zJ8VBuJWGEXvfMnlkadiAtXnc7iRNUIRemjue20vPes3pSY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5679787-348a-425e-40fb-08dcf29d36b7
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 13:27:02.3412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T6ihfAnfCRo5I+p2LnCybmSE5tZ797vU1i2H/V0+zsbFPmEUowkuJSpH2w/rWk8sz6hfIPlRgSBiWYKn3B78qEKIkPZpzaHH6UeysVGnDN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7009
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-22_14,2024-10-22_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410220085
X-Proofpoint-GUID: 3cXDGXDg51Sx9ebDVzu3TlmQLy7QfYuc
X-Proofpoint-ORIG-GUID: 3cXDGXDg51Sx9ebDVzu3TlmQLy7QfYuc

On 10/21/2024 1:30 PM, Jason Gunthorpe wrote:
> On Fri, Oct 18, 2024 at 02:27:32PM -0700, Steve Sistare wrote:
>> -/* true if the pfn was added, false otherwise */
>> -static bool batch_add_pfn(struct pfn_batch *batch, unsigned long pfn)
>> +/* returns the number of pfn's added */
>> +static long batch_add_pfn_num(struct pfn_batch *batch, unsigned long pfn,
>> +			      unsigned long nr)
>>   {
>> -	const unsigned int MAX_NPFNS = type_max(typeof(*batch->npfns));
>> +	const unsigned long MAX_NPFNS = type_max(typeof(*batch->npfns));
>> +	unsigned long n = 0;
>>   
>> -	if (batch->end &&
>> -	    pfn == batch->pfns[batch->end - 1] + batch->npfns[batch->end - 1] &&
>> -	    batch->npfns[batch->end - 1] != MAX_NPFNS) {
>> -		batch->npfns[batch->end - 1]++;
>> -		batch->total_pfns++;
>> -		return true;
>> +	if (batch->end) {
>> +		unsigned long npfn_end = batch->npfns[batch->end - 1];
>> +		unsigned long pfn_end = batch->pfns[batch->end - 1];
>> +
>> +		if (pfn == pfn_end + npfn_end && npfn_end < MAX_NPFNS) {
>> +			n = min_t(unsigned long, MAX_NPFNS - npfn_end, nr);
>> +			batch->npfns[batch->end - 1] += n;
>> +			batch->total_pfns += n;
>> +			if (nr == n)
>> +				return n;
>> +			nr -= n;
> 
> Looking at this a bit more carefully, MAX_NPFNS is 2**32 and a PFN is
> 2**12, so a batch entry can describe 2**44 bytes of contiguous memory.
> 
> I don't think we need all this logic to try to do 'min'. If the thing
> we are trying to add doesn't fit then just skip trying to join it and
> continue on.

Gladly.  The return type becomes boolean, as either all or none of the folio
is accepted, which further simplifies its caller batch_from_folios.

- Steve

> 
> The next empty item will hold 2**44 and that can hold any single folio
> - folio npages is limited to an unsigned int.
> 
> One reason I bring this up is that we really don't want to split
> across folios, like if you get a 2M,2M,1G pattern then we don't want
> to split the 1G across batches as that will definately harm
> construction of the page table. Theoretical because of how big the
> size is but still.
> 
>> +static void batch_from_folios(struct pfn_batch *batch, struct folio ***folios_p,
>> +			      unsigned long *offset_p, unsigned long npages)
>> +{
>> +	unsigned long offset = *offset_p;
>> +	struct folio **folios = *folios_p;
>> +
>> +	while (npages) {
>> +		unsigned long n;
>> +		struct folio *folio = *folios;
>> +		unsigned long nr = folio_nr_pages(folio) - offset;
>> +		unsigned long pfn = page_to_pfn(folio_page(folio, offset));
>> +
>> +		nr = min(nr, npages);
> 
> Ah, npages is used for the trailing partial folio too..
> 
>> +		n = batch_add_pfn_num(batch, pfn, nr);
>> +		npages -= n;
>> +
>> +		if (n == nr) {
>> +			folios++;
>> +			offset = 0;
>> +		} else if (n) {
>> +			offset += n;
>> +		} else {
>> +			break;
>> +		}
> 
> Then this gets to be quite a bit simpler
> 
> And you'll put the refcount adjustment in here like you said?
> 
> Otherwise this patch looks like the right thing
> 
> Thanks,
> Jason

