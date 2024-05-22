Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909F91BF40
	for <iommu@lists.linux.dev>; Wed, 22 May 2024 18:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716401751; cv=fail; b=DfFhH91G5vN6F7s3f4ZgB2m1x2N8o77qlTSlQzayopxTR16k/WynPTWz84/DIbXZY/I3t26OT/9hEkQkrnZPaXJGKN+kGC0f6KETqFmxKqi7AEe2/7SVvTdWp8DJhS7SWlmzZOB35wKbtVQqNTW/wDN/yYy5A+wCKFL+V0wcYbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716401751; c=relaxed/simple;
	bh=zqurcHI4RLU2GpYqojzLGIch/GjlhR9oygX0i94en2o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Eg8xg29A7Ux/50q2FE1a/sWqA91EgEnjn06d5HVt9Uxuh7W++smS2K6Sxc88gdyL43hgbwwqKusoyKtWme8nezwp7RIGojtd9d7lyfZ+diTUuphD8dZsgA5idDnCoa3qCI4w6tfI54NW8XR6ZA0buFzwilhGwZAV1U2bl3WoJtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aUKuR9Z8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GxSnOU08; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aUKuR9Z8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GxSnOU08"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44MHeRuu020779;
	Wed, 22 May 2024 18:15:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=4M+YbimWWm9HdDswIfW4xj8O8dmD2L7ldMnE80VXm+M=;
 b=aUKuR9Z8t3xS/41sWMtRkhOW6WOhpZmBaJDNFcodo1yf+wQtUJCM+MgMSc4XYN+SB3I0
 82T3C3Jld5ojblvCqwKtNyixdjGszx5ErwXwKEe4ZMKa1rhXnTozBVD/0OrZZRr5yF+G
 zuVVQYTpPfbQ+QrcNwaCaqV5hYdJzjRrxsbUEheUEpl0d+koz8QE4fKFFWFlKPfc3XoX
 lQQvlRrQ3lJvax4solcAx1gQbBA2302Kmk7tlsL6calyIhzkbMW5+PrvADzKSDvEy5Rf
 fjTaBonIVoCKLUAv9Qzyb3ck9utGFJ+qwXFOBqzWcsdHVfEKH9rf7qU/XmXmIwSYstbo 0Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6jrerb42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 18:15:18 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44MGheXV013815;
	Wed, 22 May 2024 18:15:17 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js913cm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 18:15:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mgtk4PhlPjSj/Xc3efUrxO2tqv8V2vfDB1wrsKaMzoaazaDT2UVsH/As+0XBb9YDlGkpiVH/7TyTQ6uKse97eTJD3/4KgP2rLMbCupI89pPkHjPUxXvRNHwqyFFASIY5XouPmyRCep25caFVv8Ttzl6Acts92T2o0zncErdaQ6TxhxPfytatM9SP3fEmM6gi1iWjQyM4IxfFjnKoMRAwteuMgh30cih43sxtLKTtsZzo33QfRyN7/hctXTbZ4kP/g8h/paE+DbiQbzLHB8baV7COxoL4WT5ZWuGX0KHvhLfKoDACeTM3pSDgdeMYKYOv3GEbm8xRautC+KEhKb2tOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4M+YbimWWm9HdDswIfW4xj8O8dmD2L7ldMnE80VXm+M=;
 b=eA1ifIPKrVk9e6VA4C9xR5dGqronuiHZ5qx7TqH0VCkruNVFbg9jj4sSmtyHgrOxrnH8BHyPRjY6X/D9//8RpfhdEqN48IjhnkL6U5bCElaoYSs2rvuqgPd2sgcRHjePV0HbShopqVKJ0eFtVfcnAQ6vUgVx5IGyguDmHh7UGpaFhRTdI8Uhn/bT+D4cUGQFDBSCqiihX4UMcIxXaUiZVe1RZV0tOqVup46vzCiD0jRRCt+jrxAIr8fI9TezqJLgDaJ9oxBn9hwY+eF1vbIBraMe0Kd+rkJLe0p4uhzyC51fkmkMYhK51PGzlkEXYAml2Zy467pqBrDsSkx7GcD5GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4M+YbimWWm9HdDswIfW4xj8O8dmD2L7ldMnE80VXm+M=;
 b=GxSnOU085oUMP4MqDdy+FqP3jdoB6Fsoow36rF/krQYDsxyzCh9qUaG1ax3fOHRaVjQzpiz2IXkPHFfBCsVGgu8YKtF3mpv45VLiRfK4mKfXPWbCDjSHl7ci607apTlSh/RCQJr9vWvEoGlIb8B/+3lGegyGAMlLjY7/RZIePY4=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by IA1PR10MB5899.namprd10.prod.outlook.com (2603:10b6:208:3d5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Wed, 22 May
 2024 18:15:15 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%4]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 18:15:15 +0000
Message-ID: <914149e9-41cb-4ec1-a765-746a17fe4a12@oracle.com>
Date: Wed, 22 May 2024 19:15:07 +0100
Subject: Re: [PATCH v3 2/4] iommu/io-pgtable-arm: Add read_and_clear_dirty()
 support
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
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
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20240522175053.GF20229@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0128.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::45) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|IA1PR10MB5899:EE_
X-MS-Office365-Filtering-Correlation-Id: 895833ee-4b8f-4ea9-1ab9-08dc7a8b20d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RFNWZFE0QnRSOGxIUVVEM3JCcnJkUTBpUktlUGQxeUhmM1dXNzc1ME1zM3U3?=
 =?utf-8?B?UlBkSmpicHZGcXoyOGUxZWZWSDNTanVaTG5RMkhSdWVQZWczdWJnV3I0SDAr?=
 =?utf-8?B?RDBZOSttS3FwaGN5UG9NSm5pbzRteERwU0ZBMUthbVd3d2Rpb0UzeEppbTFN?=
 =?utf-8?B?RzI5VWpuTXZJckdhV0s2RXR2eXlPUThWWG9wZlF0VHNHdlJuVm1tdDh3Unc4?=
 =?utf-8?B?UDBPaGp0c1hGbStvY2VaZ1Z5Z25PWlNHVnRQU09VSWJuVXl4Rjhka21ZY3ZJ?=
 =?utf-8?B?V2p2eGNQaGlzRGRyRWNHd1hheWxDVGlLRVFkanB2ZXd0c04yMEJIenJTZnVj?=
 =?utf-8?B?UmxIRDdwV3BPakNVUk5iU243TG45WjY5MUQyemlKUzdZTWtmUGJCQi9IOXdF?=
 =?utf-8?B?dlh0UWlJdjBXNVg5anR5MUpEWVlqVytLRnp2K0xURkhZSFdaZDV4N0lzamQv?=
 =?utf-8?B?dG0yL2J2SjBRNHlHUTZ1cHJuTmRadTlMTUpYNys4amtVYUFzaVR3M0luUUJ0?=
 =?utf-8?B?RDdaZTZ1TUhZV3VQaXExaUpuWUE4NC9IMllkZGp4RENlN2NZT0JDWkxjVUdP?=
 =?utf-8?B?dmdHRnY4SjJDZDhEZWFCVE9RR1ZWcUVOQmJ5YzJSVGtrLzhZcHJHSmRDTVN1?=
 =?utf-8?B?cUZWenRlR3MrOFNNMEkzT1VBV2hsQ0hoQUVUQ2RXeDgybm5TVUZ2MloreTlu?=
 =?utf-8?B?dzd4NE5TOG5ianNOWWhTWTVYK2xHaWZxWjVmcFExYlVWUjlQamd3Rlk2cFlq?=
 =?utf-8?B?ZEc3YVhCZmZqVlQybnNsKzY2SWZGVlByWm9ZQk9JVURpUjc3TUhUaThXUkxF?=
 =?utf-8?B?WHhTbVBwdHhUUVRGSlIySHQ5NnRFL2I1Q1Z0SUc2a1pPRXBkME9RYzBteWx4?=
 =?utf-8?B?S2libllseHBaMVhndmY4RFNLblJuM2RsYURaSzZULysrMDZlNlZ5SnJQK3pY?=
 =?utf-8?B?Q2JOQkdzYVovaDlNNWovTVJXWGVVVkFjQkVKREJ0WU9lYW8ySFRMcmJreXdK?=
 =?utf-8?B?WVBFTUpEQkNDOE5QcldIUHJtTFJlQ3dQMDhvM3p4RGFXUXk1bHNaZ1l4OExS?=
 =?utf-8?B?Slpla1lGeWJ0UFVUVzNTQlo5T1RkQmFmdVVaNk56cmJTbURGVmY3Nm92YS9y?=
 =?utf-8?B?K1Z5ajBzcXppYUt3dUsrZ1BkSE1pbSs2YVR6aW5pZ0t4ZkhFeVcyMUtRakZT?=
 =?utf-8?B?OGQxQnhIQklXL0tmaHFheFZ0QVA1WGozSkErdWhCS1JqUnk0bXRTemJ5M1ZZ?=
 =?utf-8?B?c2NodDlucnhiUmw2UWV6aFI0Y05xRVNFVFRxWDNKUXJ4UmJaRUhxbUphbmt1?=
 =?utf-8?B?cW0weFYyVGhFN2d6RmR0QUNZbDIzOE9jczFrUCsrYXM0QUswNDRpOGVhNEo0?=
 =?utf-8?B?N1F1amdndHBZZ3dnM2NIYkozamJrUDVRZGZJRDh5UkVlZk1ZNzN6ZTBzQW9x?=
 =?utf-8?B?cUd2UC9YdWx3bXF6MDBrcVFWN1pRT2l6WTJ2cnhMMm9MM0NkaHVocVkxUmFZ?=
 =?utf-8?B?STY4eldZMW5tdVo3czRkSldFR1hwdnEvSTMwdC9CVlFRVnJmMG1KellQKzZn?=
 =?utf-8?B?clJhVG9HYnVZcElKWlFMY0d3UHYxN2wzOEhDMjZMTTltUXduTGlLRVJoajA2?=
 =?utf-8?B?aWVsVUtoaWk2eVhsTU9QYXovY1RqZFI4eGlsQkx1Z29rQm9BV2pFUGYvUGo1?=
 =?utf-8?B?VUs5RWprS1poRGhtclArSmdBdm16bzdOUE9JMXBlMWhtVnNJaXd3YThnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5893.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NVRHaUZVdCtYZFVNYjJSMmhnYlNhUW9sYXkzR1pJZlBMaTl6bURPbGRDeDN4?=
 =?utf-8?B?V2tidTRjR0RTNkFqaHJBc1lsYzIwQXlqYnd3a3paZzJZbEV2dUhYbkd4VzdY?=
 =?utf-8?B?VTJvejJSd2pwSm9PZkV4bktFOWw3TGsvMlpzcnROSFh1Z0Z4YkVldTBJZUFr?=
 =?utf-8?B?UFdscXdnWGtYdEtHQnptWG5VWVNDbEluRHQ3WUJmZEhUdjNmbFY5NzI5ZnV0?=
 =?utf-8?B?RGl2bVArM2toZS9TeDlMYVJvTEZUUkZLUVF2a21Ra1RlKzBKS0cxaWMyUmxo?=
 =?utf-8?B?dXpYeEdqRTlnb2VLanA4Y2lFM1ZBNDhFTGE0ZitxMXZVOFJXblErYUNWUStW?=
 =?utf-8?B?NGRtZVFRQ2V6MCtpZHQwOERhcEZXc3lKdForUmloS2tLMnMrWDdKRWl3YVZh?=
 =?utf-8?B?ZUNnWUoycEJWUzRCWTdoYlRQUk5ZNDZid205M2puSmluZ1YyS0x5RUY1QVNI?=
 =?utf-8?B?bzA3TVdmcmQvN1VsZFRueTltczBuRG9RTWtJNWR4Ly9FVmcvMDRZL3ZKTlRm?=
 =?utf-8?B?RGlvOWRxemZjaEgyRE84WDhjazExeUhUUEswZEQySFA2cDBXZkpmaHN2eXhG?=
 =?utf-8?B?Vy9RYzZVSHJMa3AwWUhmandvd1I3Wm45cXNNZ0pLN0s5aTFEL3ZiTlFGcG9j?=
 =?utf-8?B?UFRmWVVDb1h4QUd0ckVPNXJsdlVpeUE1ZDBramNYYWZiYVdSck01UWd0ZmNw?=
 =?utf-8?B?SWxHNmhLRlBBQVNUMlFqMGpyYXhrTXY4Z3V5U0J4d2NQYWJ6SS9uYWVpMFlK?=
 =?utf-8?B?cFlZaWFqWWphTlZuMlNNNHVvcy9lWWZsV3B3ODBDU2xwalQ1QkU1RTVhMXNh?=
 =?utf-8?B?YUJldHo1OXljRnNwYWs0S0tSanBXMWQxYTl1TS9uS1JDRlVqankyU0tBRlZC?=
 =?utf-8?B?WXA2TkdMOVBnODBhRVZvNWtUQ3J2cXY2Mm12Q2VadlpqMTZtSGQ2b05TTFBr?=
 =?utf-8?B?QmRPVE9iTXVFYWNJaGNqbTlHbyt6cDYzZmI2TE11aGNxTVlnZ2JWM3RUVnZU?=
 =?utf-8?B?SjdUTzI4Szk2L1VKWVVWTi9MK0NwQmpqdlE1ZzNsRndDa1BIU2krMzBQTEFa?=
 =?utf-8?B?di9BM2ZPbXl1dUNEZm5MVjNCTU9iSmoxR3ZDdlFxaTJNNlZNMlVEWXNZQTZ5?=
 =?utf-8?B?Yi9DdVZQNjVpL0Nmcml3U0VMaXNHOHBTcEI5Vm9sQ3p2aDJqNElIalBHejAy?=
 =?utf-8?B?M0ZGWkU4RTIwZm1STWVQV1BObmh6U1NaY1YwZC9rbXJKUFlpZlZiTm4xNkRY?=
 =?utf-8?B?MnIrQWptZDRGN05hZlB5dkJ2SFFUVis5SjZtS1dRWFl4RjIzODBoZ0haWm9z?=
 =?utf-8?B?M2poejR6cVdad0FrM3BlWlI0R05EYUNCUitwYmdhUzU5TGN6VmU0TmZWbmtq?=
 =?utf-8?B?WlVuUHN5VFVqZFhOcDVDamZqWjFvU2ZEeHd3TXd4OEdYSEZ5a216YnRpQTdy?=
 =?utf-8?B?NzNnb1diMFIyNUxMcmZUUkRhR0hpQ0RYQWlMdXRPVlJxZis1OW5qWTF6REtY?=
 =?utf-8?B?SGhtU25UUDVnYmlyRVV4OXJDVm14eTRyS3dwOHRybnVnUTNOQVZ6WEZuSWEy?=
 =?utf-8?B?bytBT2I4SjZQZDF5bnk1VXN4RTMwUGMyd2ROTHFYRjdiZmx6ZWMvcU5qZktu?=
 =?utf-8?B?RmhnUUJ2NXNKZ0JTcllFQm9lYm83aVg0NTRJQkNMTTd5VVJSZU1iSjRlUm92?=
 =?utf-8?B?dTBUdGliNU15cHNBWWJZN09lZkJ4eGVJSmJ0UWJYWjdhWkRzQWdMZ0ljOTZw?=
 =?utf-8?B?L1ZpdkZGQlJ2enEzV3B1bUthaHJvZy9UMTdyd3I0WFlkd2NrSVpkOU54UUFi?=
 =?utf-8?B?MW43UW9tdDErNFNYdW8wcUpBNzkvK1VuZllRdFpRWjRady93a3RJc0FoYTUr?=
 =?utf-8?B?ZElIYy9kaGNxQkszTFhISVpiVjRWaytWYzZDYWpEV01QTlJvbnV1TkdqWlVF?=
 =?utf-8?B?Rm5GbGVOVS9MTkFKem9mQ3d3ZnU2Q0FrcVNIYVQxd1RVQVRxdmNlL3VCaElN?=
 =?utf-8?B?dUl2OXBML1FPMmt0WUwwVmVjcmczbXhhSHRObDRiTWt0c0RjN3BMMUxiYXBF?=
 =?utf-8?B?OW12ZUxwUTBvSWJ3aGtqM0hZbDZKQmwyOU0wZndBSURXbk9yc1pNRUFxaDhK?=
 =?utf-8?B?S05ORi93WTNxRHFpcFZraVRVTmVneFMvK1Y3ODFuMEJvVmJodDhxMEVuQncr?=
 =?utf-8?B?TkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0+L2TSXm/ADLbHMnRDbgn0PUqZZ4Jl6BgMgbX2wbWAd44UGhqw6ePRztqg6G5MvOJxuL/xM4RLhxCpbfCy/3CezHR6qsqgUjvE+NEGkHQLyN6j4ajJs5swa6v2dWI6tfKxX1dq2kT8s/TlTh1D36Ii3z694BI+8d63N1AYfUK8LstBsaAosgqZQUoHzexBZ7ok896BccFICSYV+XuBuGxaGvGB2PJ0nU5V11lJHVjRr3vG+N8ztgohdIEMkob0697MfEzgWFYlqgjbE4uKr+PFrQQJY8Rzk/2TBFwanCppo1fnG+FFagWFLjt+ReFwL9prLmZwneHj86ZxM834hYljTk8hI8idAJEMfeBJgpRvIequA8UdqLu1p8192KgAuUoD1P89tmF9h+uhlP2JymtAkZ3de39t15WdusRa9iJbtNIwLx7cPl7m3JsAfiLocEiOzPxJ+x+bPZ+KtSuOLWujd4BbD11vecd1FPNIuUejsv9q9ucSHiJq9awjWfBzPUVQ7vizf2d2A/ZLGbpEbRl/Ktb5rFdSwKurmwUJSzcq1tH9RS97Qfurf7q5jf3FFvq6K2qlQYgNnMDZB5bCSqwKny5WTr2WdKTzOGIVrMViw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 895833ee-4b8f-4ea9-1ab9-08dc7a8b20d5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 18:15:15.2176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qYQd8wfbvcoOXFuFIuJnjrVrVScHngoZECeZzLQZKH0VAvY7E15nBP3q6W30ntGvakaeIG2V+A8a9sVYMw1KBIRhedXzC7Cp47LmecvPiXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5899
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_10,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405220125
X-Proofpoint-GUID: 6ndrau34Z7Ltil53c_g9RIYmN847gck3
X-Proofpoint-ORIG-GUID: 6ndrau34Z7Ltil53c_g9RIYmN847gck3

On 22/05/2024 18:50, Jason Gunthorpe wrote:
> On Wed, May 22, 2024 at 06:10:59PM +0100, Joao Martins wrote:
>> On 22/05/2024 17:56, Jason Gunthorpe wrote:
>>> On Wed, May 22, 2024 at 03:37:57PM +0100, Joao Martins wrote:
>>>  
>>>> This is just to catch the case where IOMMUFD can call into read_and_clear()
>>>> without dirty tracking enabled and without a bitmap structure to clear dirty
>>>> bits -- in order to ensure a clean PTE data snapshot after start(). 
>>>
>>> Is that broken then?
>>>
>>
>> It's not: The check errors out the caller ends up calling read-and-clear with a
>> bitmap but without having started dirty tracking. the iopt_clear_dirty_data()
>> passes a null bitmap, it goes through and it walks and clears the IOPTEs
>> *without* recording them in the bitmap.
> 
> It is not "without recording them in the bitmap", saying that is the
> confusing thing. The purpose of that 'if' is to return -EINVAL if
> dirty tracking is not turned on and we query the bitmap.
> 
Right.

> More like this puts it in the common code and writes it in a more
> straightforward way with better locking:
> 
Yes, This snip you pasted would be the equivalent to the current way indeed.
Looks good

I think I was trying too hard not to duplicate 'state of dirty tracking' between
iommu driver and iommufd core that I unintendedly ended up convoluting with this
check in the driver :/

> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index d35c1b8c8e65ce..b2cb557d3ea427 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2645,13 +2645,6 @@ static int amd_iommu_read_and_clear_dirty(struct iommu_domain *domain,
>  	if (!ops || !ops->read_and_clear_dirty)
>  		return -EOPNOTSUPP;
>  
> -	spin_lock_irqsave(&pdomain->lock, lflags);
> -	if (!pdomain->dirty_tracking && dirty->bitmap) {
> -		spin_unlock_irqrestore(&pdomain->lock, lflags);
> -		return -EINVAL;
> -	}
> -	spin_unlock_irqrestore(&pdomain->lock, lflags);
> -
>  	return ops->read_and_clear_dirty(ops, iova, size, flags, dirty);
>  }
>  
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 50eb9aed47cc58..844f2cf061911f 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4797,15 +4797,6 @@ static int intel_iommu_read_and_clear_dirty(struct iommu_domain *domain,
>  	unsigned long end = iova + size - 1;
>  	unsigned long pgsize;
>  
> -	/*
> -	 * IOMMUFD core calls into a dirty tracking disabled domain without an
> -	 * IOVA bitmap set in order to clean dirty bits in all PTEs that might
> -	 * have occurred when we stopped dirty tracking. This ensures that we
> -	 * never inherit dirtied bits from a previous cycle.
> -	 */
> -	if (!dmar_domain->dirty_tracking && dirty->bitmap)
> -		return -EINVAL;
> -
>  	do {
>  		struct dma_pte *pte;
>  		int lvl = 0;
> diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
> index 05fd9d3abf1b80..d116179809042d 100644
> --- a/drivers/iommu/iommufd/io_pagetable.c
> +++ b/drivers/iommu/iommufd/io_pagetable.c
> @@ -536,7 +536,10 @@ int iopt_read_and_clear_dirty_data(struct io_pagetable *iopt,
>  		return ret;
>  
>  	down_read(&iopt->iova_rwsem);
> -	ret = iommu_read_and_clear_dirty(domain, iopt, flags, bitmap);
> +	if (!iopt->dirty_tracking_enabled)
> +		ret = -EINVAL;
> +	else
> +		ret = iommu_read_and_clear_dirty(domain, iopt, flags, bitmap);
>  	up_read(&iopt->iova_rwsem);
>  
>  	return ret;
> @@ -580,7 +583,11 @@ int iopt_set_dirty_tracking(struct io_pagetable *iopt,
>  	if (!ops)
>  		return -EOPNOTSUPP;
>  
> -	down_read(&iopt->iova_rwsem);
> +	down_write(&iopt->iova_rwsem);
> +	if (iopt->dirty_tracking_enabled == enable) {
> +		ret = 0;
> +		goto out_unlock;
> +	}
>  
>  	/* Clear dirty bits from PTEs to ensure a clean snapshot */
>  	if (enable) {
> @@ -590,9 +597,11 @@ int iopt_set_dirty_tracking(struct io_pagetable *iopt,
>  	}
>  
>  	ret = ops->set_dirty_tracking(domain, enable);
> -
> +	if (ret)
> +		goto out_unlock;
> +	iopt->dirty_tracking_enabled = enable;
>  out_unlock:
> -	up_read(&iopt->iova_rwsem);
> +	up_write(&iopt->iova_rwsem);
>  	return ret;
>  }
>  
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index 991f864d1f9bc1..de3761e15cab54 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -52,6 +52,7 @@ struct io_pagetable {
>  	/* IOVA that cannot be allocated, struct iopt_reserved */
>  	struct rb_root_cached reserved_itree;
>  	u8 disable_large_pages;
> +	u8 dirty_tracking_enabled;
>  	unsigned long iova_alignment;
>  };
>  

