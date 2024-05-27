Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5016D13A3EE
	for <iommu@lists.linux.dev>; Mon, 27 May 2024 09:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716803497; cv=fail; b=r1/kpbqqsbw3BrzS0ii2OFCI1m/sXuzmfEZzJ3rj21bdsokhfbAsy6FMBdRprX6wwyG9aGgQk6fR8Eut82snvmrQThI+MNmRnndQkPcb8HkjvAR9oINAGopym2/rJehBo85dSniMJM60Z7FUlS80N4/t1COu69C/RM53tqcQRHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716803497; c=relaxed/simple;
	bh=r0bRi97U2M7CQSDEbdWTSxc6t66kQi5B5zDydF4MHnU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VefGiB6ZPoxCb9yWb9W4sr3/yHHrdiv3bQ3vcXCiij7r+uXbO02NbqYB0L7wGNQp3cj6CZTfnP4ZDjKIRX7doMHlutGPYRVVUS9X0ua3PIE/dQIM3+h/AJFMOm25KHIseO6RzbOqklqtuEex3pMnqqobJWP1A3d3kpCRZXzF3Tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44R8Z5lS009453;
	Mon, 27 May 2024 09:50:52 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DSgboLbR7+rNqkWXNriYZuOIhIgETXSboqXBK2Wxt2j8=3D;_b?=
 =?UTF-8?Q?=3DTA+m48jfLi06jmB53nP+8ZC85nAzHJMSLHZ+raina6ClLwXG32ZevrtCPZRP?=
 =?UTF-8?Q?Ep6Py4es_ZTHESNL/EaJ27MspdmQjoXvWqoeUMV3UMZyf+VntYhSF5i/ULNZvl6?=
 =?UTF-8?Q?ujXg0mEZ1K3DDq_qPJ8ixP9Qv+GsSkfg72FD9Yol5htnyKCVzsDyeHTB9HXIUTz?=
 =?UTF-8?Q?s1df9pDXeHKzEypV7qCe_YtlfnEL2iQeJDApj1iognhYGIA5I074AnavRAYe/+o?=
 =?UTF-8?Q?xYcEBmfb4YUOJPRbM4Ro9BATXR_CsmC5QaU4vmeoaJ7tcJYucRWGTtWqZG2GYDu?=
 =?UTF-8?Q?fuITlwB0IN9KRUDOaZlMwy9cGU3EqOaS_Bg=3D=3D_?=
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8kb29e5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 May 2024 09:50:52 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44R9Wao7025922;
	Mon, 27 May 2024 09:50:51 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc50nn5cr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 May 2024 09:50:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCcDqhm4Sii7JdxkrDBjnQnHQHdfM5YkOvvcrx+1O6BHB6njyz8rmUONUXExjJFiZYaiB58qTszVgz9anEo0gC2nY+3noVoR0nOF64h7VA6MQo6iKge2LzY2CR00dqiCu0KQDEAXBVc7q4Pgs8or+LW4uaPL1io+DgPXdvYVbY6ko8N9Tv6Yk2r43CGdT8W+xYrbp1eEIJrzVmt64uauzR8cbOzYo4OvbICqC+kPagmyNDkK+xf1EzRgTwgemaUt2uQvZJO3jGrT9Fz3ViURlXQyZJJNDnO2Sxi0UEbExUgXIE8ztVmMRqAYFnB3UNC7fE5NW0L9dwVKG/PjczcPOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SgboLbR7+rNqkWXNriYZuOIhIgETXSboqXBK2Wxt2j8=;
 b=a5BnxOnPRgfD13gPWbjLfpqXagvVLazCYbTMFCohKMe+oO5gDLv3EybsCVgn5I6oKiw4EQsT1bUrdx5yfnDHnaItEVOQ9dIzhS4L+p6bIpEK0PtZsY7yRjRgrl1q9GcGBa/6IugLBbdERwogP78SaO02ItzipR1He7AqSXG8CD7VYe2ONDTO8WVodFEnFHy+bXcNLmjUWIAF4sYgvUAcN7TceHIO3JBTvp/hFRui9RAbNyEYYr/+7m0kpheOOd/zJn/RW3nAK/sQM4l0F5k5tsGchyThGIBcuggcURgytILzbNh9CIC6FzdzTVl/2XcXUzmQP5fJPGMB/krYdX3DOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SgboLbR7+rNqkWXNriYZuOIhIgETXSboqXBK2Wxt2j8=;
 b=dMwsn+ZFXH1Mu3Vj5AuYzuBDgDTZX5cI6hyhyYSYsXg8LV0I/J3LRPWu0a3sKD2ce/3lsY8uZ+BzhOzvtmTvh1FIZx+ELT5BIbAuro2WPnLTnN5S0E91ivMMr/Xz1Ua1UkHF6MtKxnVc0G8D1d5Yw5bpwxpsReR5LnLalv10Yx4=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by SJ2PR10MB7828.namprd10.prod.outlook.com (2603:10b6:a03:56c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Mon, 27 May
 2024 09:50:48 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%4]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 09:50:48 +0000
Message-ID: <2e7e834a-11e0-49ae-bac7-30ad46aba7bf@oracle.com>
Date: Mon, 27 May 2024 10:50:39 +0100
Subject: Re: [PATCH v3 2/4] iommu/io-pgtable-arm: Add read_and_clear_dirty()
 support
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "mshavit@google.com" <mshavit@google.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        jiangkunkun <jiangkunkun@huawei.com>,
        zhukeqian <zhukeqian1@huawei.com>, Linuxarm <linuxarm@huawei.com>,
        "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20240430134308.1604-1-shameerali.kolothum.thodi@huawei.com>
 <20240430134308.1604-3-shameerali.kolothum.thodi@huawei.com>
 <BN9PR11MB5276ABF99FDF6CF0F863501C8CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <13e93238f21b42539097d7e347be684e@huawei.com>
 <4618c24f-aaa8-453f-aa9d-67a864e1c93b@oracle.com>
 <20240522165640.GD20229@nvidia.com>
 <cb2ab7ee-9e31-468d-85cb-71e70d7a7e0e@oracle.com>
 <20240522175053.GF20229@nvidia.com>
 <BN9PR11MB527660CCD250C176DF86F9EB8CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
 <2d949dfb-ea40-418b-81f2-f2711b796d4a@oracle.com>
 <20240524140754.GZ20229@nvidia.com>
 <BN9PR11MB52761D4122B818A05B508BB28CF02@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <BN9PR11MB52761D4122B818A05B508BB28CF02@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0210.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:237::33) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|SJ2PR10MB7828:EE_
X-MS-Office365-Filtering-Correlation-Id: 28c51d78-e9f0-4d91-9fb9-08dc7e327c54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MWpBNXNxeTJUZ0FSZmg5bjBOZUxRMDdEaGJQQUNNS1h4K3pUMXp3Q201bTJG?=
 =?utf-8?B?dVdnZWw0cDc1azBsdnEyMzF6NGhVWWZjQXJ3b2JoK2RnNEYzRFNUb1N1WGZL?=
 =?utf-8?B?bkxoOXJ3akU5VUNKdnlDeTlKazVIZ1pLL2xHdnBUcHNYTHVXQjltR0RVdWJ2?=
 =?utf-8?B?T0tDSEVMbmhHZ0xvelVQN3dramVxZFhrZm9xOUNwVWpudms4VWc3L0JTR1Rl?=
 =?utf-8?B?Vk5HOUc1Tk9GZEtuZ0dtRVV3QjNiclhlUGM5TEd4aGVXV0VFc2pMcTE5ZEUx?=
 =?utf-8?B?ZithYmhuL1J6eXJHUmc0ZzlMMDRyZHFZQnRKMmtlTUpNNGRlRHlzR01CVVRz?=
 =?utf-8?B?YmlDd2lQcWpGMFVBcVVjSmtUT01LdVlsem1tNFZwb0tLZUtXZERjVDUwZFpY?=
 =?utf-8?B?YXhqOFFpZ1kwZGZiWWVBZlgvKzE0MTRVYi9TcnNpZitVYzd4S0tTakxqK25K?=
 =?utf-8?B?ejFySUFyTk55cklJbld4UVdrelpUMXVRblV6WmF1Nkp2cTUxL2JiZUJUdHl5?=
 =?utf-8?B?T2hINU5nV2szUzdQdlVoMjUzQzY0b0RrRGZ2RE5CTUViaXdPRDNPSzBQOXFV?=
 =?utf-8?B?Rmt6dkFhRDQ1VXZBblJuakE3ZjQ3UTBvdkdmb2Zxc1F5cUgybThSRWtoZ1Mr?=
 =?utf-8?B?UW5ZWThaei9obkZhUC9YSjJYQmlsbUg1WDF3Y015S1g0Rmx2MVozaVBHYm1k?=
 =?utf-8?B?dDFpcStUdTdmT01FZndOSnRRWXNPQ29sNE1IeWpsdmxoOWliNWZ0QTNEMEtE?=
 =?utf-8?B?aklLejg1TzBJK05oMDFBMWpXNVRFMDJ6cCt0a1hUZGZ1UnFmb3hxNzIrcFJM?=
 =?utf-8?B?RktpdlB1ZXAycGxTU1pnQ01Lb1JiRG01ZW1JSTRsc0R5TVdLenFBQXVqOWpK?=
 =?utf-8?B?K3VhdERabjZ4ampGbmZXQnV4eGNDV1RMVllqL0Ivcm1KNlI3a09YSUtTcDhH?=
 =?utf-8?B?a21VcmZpMWVSQlMxcnJLZXM1SVF0RUt5S1QwZWdmUG5GVmthRHczOHZoeHlU?=
 =?utf-8?B?QzY5NHRzcDZwZmVnNzVLRWNDWUdJaUQ2T1Y3ekY4cDA2SjJXbUV2aU5xQlVi?=
 =?utf-8?B?Qkg1TVYxUjZ3QjRzNUk0ZkUxMnc3Q1FCM05sQWhhekJtSXE4TUNsYThoQnRC?=
 =?utf-8?B?RTlDZGdheHI4cjZrcE5iMmN3dXVYeTRUbUl6SlN5Ry9oR0xNUUt5dGdpRzN3?=
 =?utf-8?B?TWRCTjQyUVA4M015REtJOFg2QW9vSWVnWE1nTHVhbk5ReXRBZlR1TWxVR1Nt?=
 =?utf-8?B?T0pGQkJpYWhnaVk1S0hWenlSUC9uZ2VHK0ZRbFU1M0doSFhQaFdPTzdXUlEy?=
 =?utf-8?B?ODFJRURVOWRWczlPbTZZQThDdnZzK3I0RVJGaEIxRTBaaDczV0pycXAxc3pG?=
 =?utf-8?B?MGNRcHMySmQ5RmtVMGhvdVZoeW9rWUwxQ0dJS2hJSFhtZEk5cTlMTE1XRG5s?=
 =?utf-8?B?N0FCajNkaS9vc3ZxOExxVDRRZTB3TnIyYTN0VjEyNkNYUVQrcVVKRC9IQW5Z?=
 =?utf-8?B?TElNWFY0THRUSXNsNmNheXhGNVp0Rm02TjFNV0dkdUw4c2xsNk50cFNhUmJN?=
 =?utf-8?B?NFJkUStwM1IvTUtPTlI0RG1mcHRWWTYxZGJHWEI5OENiWE41VUIxZ3B6MEFI?=
 =?utf-8?B?eUxMUGgvcmMyaHJYRG1tTmxBREVUOU1CZjF2MHpzSTJQYU9DN1QvMnFlL0tk?=
 =?utf-8?B?UGFSSzZWYW5QaEtpdVozS1R3eEFodUczTis5ZUJWQVJaSkRvYno2cXNRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5893.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WVkzQ04yL1hpY28rSDExNFAvY2FVVFlzaWU5QXc4ZXo5dHdWWE8rSlRpUkhE?=
 =?utf-8?B?bTFQcnNKRmdCOTBBSmp4dyt2b2w2dTZLUFNHVUhYdklRamtKNEhKdjAyeVEv?=
 =?utf-8?B?TlFsbnJ6WG10bzg1WUxrQkV0aVVmZzllZkx3VDZDamhtZHVYNk1pbVNHSmtZ?=
 =?utf-8?B?SkdlY1hpUG8rS2lnZ2hvUUdvc0RnM3JLSmg4eXQ3Wmw5OGNaOE9JczZ3YVZR?=
 =?utf-8?B?VG82NTNzYjY5LzRlWldSdkNxS2R0MmQxeG1KRndqc3A1RzhlSFJ2SVljUWMv?=
 =?utf-8?B?QTVoczdYam9UbDRqbzNGSmR2bnJ6NjVVeURmS0FJc1ptMHJDcmlQR1orMFBk?=
 =?utf-8?B?bjNYbzgrUlRFOTZCWGtjcVovUXdvSUNOOFk2TUR4L29IZE5FUlVZMXc2RkVr?=
 =?utf-8?B?bEZtOWFVUkFLR3J4alRhN0U3K1M2OXE2Q1JsOGVXK0dWSlp4dXNaTTk2SGtr?=
 =?utf-8?B?MVdoQU0vZnZEQW0zYjRpRituaGJHVlJOOGpxTGtvTFpRT1d3SXl6RWJNMjRj?=
 =?utf-8?B?NWNUZEhYMVJ4NGNsaExDMVhnVjlIc2RoUmJPQ200dGthTDJTMzlhbXp4VS9u?=
 =?utf-8?B?Ky81Z3JyMm1jT255MTU1d09tVVBUY0NHQlBIbnFqSkZHVGN2ejI5RkFmU1lY?=
 =?utf-8?B?Z2Y3Q01aMWNZTE5BZTY0U09XMzJvR09maDEzbWloT1lKSFZQYmFNT2tKYXE3?=
 =?utf-8?B?blowenNBN0E2MjJERkdpM3RwWkI2ZjVxb1MrY2c3bUVTcWdOcGlYQlVaSEhM?=
 =?utf-8?B?Q3RBeWlCaWJCVGlVVC9NcXZiajZZaGh5VzhmN1BiaVoxVHFIRVJYU0FvWkdD?=
 =?utf-8?B?bnlvaFpDU2tHU01uY1RBQ2s3bHhCVzRjUXJCQisweHc0SXEwNW5qT1dkYXpw?=
 =?utf-8?B?b3NiZ29KOFltRjJ3V09OR2t4SHFRU0FPSzFuWW1mRk9mY0tCeDlHOEp0RHhl?=
 =?utf-8?B?eTN1bFdXL1p3dVpVcS9BMVQ2Y3NpUE9ENTBxZWZ1Qnp5aTNZTGRZL1dhU2ND?=
 =?utf-8?B?UDNLSFYxZXJEWWx4eHVKSC91SVBLMGRkR0lHYW81UlFiYnhyZmk0K0NMYSs1?=
 =?utf-8?B?SGgvd1FCc01qdlJkSm1qSld6YTN4NlNxaEFxSWVhSDV4WFhKWGlkSVFWMUZX?=
 =?utf-8?B?VG1VRUFKNnp4UWQ3Z0lnVkZyeGppa0VyUGJHSUkzMXM2K3hpL1lZWjVUbks4?=
 =?utf-8?B?N0s0VFBpdUM1Y0lvTmd1bW9Kd0lDUWFIWTZFWUlYOXltTllwaVRCMUp6RzNp?=
 =?utf-8?B?NTVPa3d3U3lSYUdoRCtieUplWGpJdGhob291YTk4RUd2VU4rZHozVlVwSGdT?=
 =?utf-8?B?MERtWFVQbXhBVDczT2hRclJjYmx0cm5PL0ozVGdlRnlNeW1FNzVrREhkOGQ3?=
 =?utf-8?B?N2gwalVQWUl1ZWpZczc2c05oQ1RhMU9kbnhUL1hsUHV4cGVadWwySGpwekVC?=
 =?utf-8?B?R0tSbWZVakYvVHhLV3ZYeVk4T2I1L3VGV3VzZU01VXByQzZ2NkZ0ckFPTHJ5?=
 =?utf-8?B?aDB1K3dLNC9sRGlMdmhDU1N3L29CM3JtendUUUJLVmxlL3MxcUc5VVdiTXU5?=
 =?utf-8?B?RHU0eHNMUEQ2RnJ6N3MxOENxNjdTeEIrT3FHdC9qWlc0VTkydnFxK281WGhh?=
 =?utf-8?B?VEl4bkxnMXliQlBwZFdZVzZXWm9TaXBNMXQybDRqamx1QWJ4bGptWHFJb29i?=
 =?utf-8?B?V1NYR1pwWHBObmd3UkYzL2NnOWxpeTlSRGx3ZVA3bjN2TEd3eWVwWC9iQ0l5?=
 =?utf-8?B?MnhjKzdRcWlCVGxCdTlkbXFZKzh5TEszSm1wMmhlbHBUY1MwMU85d2wzKzE2?=
 =?utf-8?B?MUduK210dDdNZERCUEpqVTVBMFZSTVV6N2llVVJ0WERrNExzdUZYSE52ZjV6?=
 =?utf-8?B?UlptbitKQk1xYkdZZ0orNHhaZTJLUTBweGpqN0swWHBpTnh4STJ6SWpYcjM2?=
 =?utf-8?B?WDA1QXBxblJEOWJiL3RyWHlGbHRZcE9ReTdQVmw5Y2dZalZCYlZZNDQ1aTZs?=
 =?utf-8?B?TWJJT1QyaDJxbUpPbUFraFRqaTl4U1dPRk9VL09vdGVTUXF1bmdsbnVXRi9j?=
 =?utf-8?B?enB1ZkpJMUc2VEZWSlhNcFZrQzFkNm5EMThybGwvakhicEV1Q2JUWFJRRjF2?=
 =?utf-8?B?REhsWUFmWURpNjBPK0lZSnhSNDI1dTFYcjhyMit6NlF4RVlrWlhHWGJNckJi?=
 =?utf-8?B?cUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ZZ1jD/mNhhl+HLhiNqd3V00fy+BQxmfJdUhN2vHt1KXpQ5oebKIhLUZu64TdlSmbCM05oEk+XLHhdtvxuxu+M7/xaOG9Mo8zbCnqQdkFoOI3R2JQZFiNu/a3cqTRgRPAmGH5tR9t+vqJfBkSZSGN8Y0LkoV0o5AhCz2TSqQ/5HUj11y29I5/PXUa4VpCIlQwmKE0gKJuXbNEccjlOOdQSIvU/AlBhbDOYr6ZYu17eXeow4wXPhx8G6AnbpYRCc2Vh3eeObJzoxLIu23qmWjbAW4Mb8HJGsWoKESNmyOZtOY18Q0pVvqfGSdOk9D/BvpjZOwYktku087UMVHUFaYeDDfW8BdE0Fwxd4iP6yLBT7xQNNUte9EIFNoYu9CtP80sCPoMNkmy5EsAN4lxyJxXYPCpYC/C0aY1anypfjBnOM7KEllBmkc6F7NCI9KMrypB+0on+XiR/IkpZeJXq7eE7jbwJIm9lSF/dMy5tH6QNR4zHa4bl156Jm02nCuder+FeTdruvcampJfT97BsqGSbsjEFdav7hyfpSS75o2yhtGImFAf51pRhevMJgb117EJAcqITP1x/X1gcTcNLH/HztIrKTrUmPZWscz/u6PTjr8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c51d78-e9f0-4d91-9fb9-08dc7e327c54
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 09:50:48.1624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GmQ8OnS8UkPzk/SVnQAO61JbVSYlnr5O50jkvt9dKgl+nGgCxBJMrcTn0WqD+JA4AzgeqfmnvlbdABRPbAvYNxutBO2uWMVez1ZFgayQ0xU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7828
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-26_09,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405270080
X-Proofpoint-GUID: HTqEOiQ5g5NCXNPyAlQVSFKnkbeMDuAT
X-Proofpoint-ORIG-GUID: HTqEOiQ5g5NCXNPyAlQVSFKnkbeMDuAT

On 27/05/2024 02:21, Tian, Kevin wrote:
>> From: Jason Gunthorpe <jgg@nvidia.com>
>> Sent: Friday, May 24, 2024 10:08 PM
>>
>> On Fri, May 24, 2024 at 12:30:22PM +0100, Joao Martins wrote:
>>> On 23/05/2024 04:30, Tian, Kevin wrote:
>>>>> From: Jason Gunthorpe <jgg@nvidia.com>
>>>>> Sent: Thursday, May 23, 2024 1:51 AM
>>>>>
>>>>> diff --git a/drivers/iommu/iommufd/iommufd_private.h
>>>>> b/drivers/iommu/iommufd/iommufd_private.h
>>>>> index 991f864d1f9bc1..de3761e15cab54 100644
>>>>> --- a/drivers/iommu/iommufd/iommufd_private.h
>>>>> +++ b/drivers/iommu/iommufd/iommufd_private.h
>>>>> @@ -52,6 +52,7 @@ struct io_pagetable {
>>>>>  	/* IOVA that cannot be allocated, struct iopt_reserved */
>>>>>  	struct rb_root_cached reserved_itree;
>>>>>  	u8 disable_large_pages;
>>>>> +	u8 dirty_tracking_enabled;
>>>>>  	unsigned long iova_alignment;
>>>>>  };
>>>>>
>>>>
>>>> should it be a hwpt flag instead?
>>>>
>>>
>>> Most of this deals with iopt locks and walking iopt areas to clear dirty. So
>>> this being a iopt attribute looks cleaner in implementation. But I think I see
>>> your point suggestion considering it represents a iommu domain property.
>>
>> Yeah, the original idea of the hwpt/iopt split was to keep code that
>> was principly iommu_domain related away from the code which was
>> principally attachment and lifetime related. Since this value is
>> covered by iopt locks it makes sense in this struct.
>>
>> Not sure the split will stand the test of time as we keep finding
>> reasons to muddle the boundary :\
>>
> 
> emmm there could be multiple domains under a iopt while the dirty
> tracking toggling must be done per domain.
> 
> with a iopt flag like this only the 1st domain under the iopt will be
> properly configured?
> 

Using intel as the reference given that it's the only one that has that
implemented: so far seems to be the other way around i.e. a parent domain sets
its childs' DPT in the iommu driver?

	Joao
