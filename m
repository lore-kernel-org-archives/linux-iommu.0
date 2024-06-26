Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4EAD27A
	for <iommu@lists.linux.dev>; Wed, 26 Jun 2024 13:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719409445; cv=fail; b=ZDDoMYSZsnQY++DscpBKkuRIoYaUvZuCzYHJXkqaD5RByzg5uU866J1KdjYD+Mhspexb+MASfXUImblS6mmfhTpVt1YdTHJIqeDfLzh//2sicD5O8m80bVa0Ckp2DBtWS1FtHn5E+Dr6JAYGQthUFgJILVcBMmzqoKmsooQDkpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719409445; c=relaxed/simple;
	bh=3yaKFDG//b+sl0ufzvSwwpTOFusqb5nKlJ9te1VcwGI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SQymQCaZMyQ/FmUQRJJhec6zWOoUMm5TTEIrAohAIzD/pGDeWC0qvuyGt2ohoGBg1yjbPgz0BfLuQJf9bZB5KZ8OGzvHlKC+nu6FQGQzCbOjJUWjhRhCxe/KUJ9uqaX3LPlvCPHaoEjIgwWwBAq6P4KSNUEfD49cRmI6SizhgAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ED1n+t9Y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Yw1btv44; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ED1n+t9Y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Yw1btv44"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45Q9sqUb013369;
	Wed, 26 Jun 2024 13:43:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=7rUs6wcghU5UwuKJxobtdzP7COU0EvoNyDtOQ7eonRU=; b=
	ED1n+t9YDU2XqYmJPATBaqQcXp3XUpSukOnT9DeXGjDw6P9tDn88EtggovkEmKyc
	90HnQ5BLThoPhlcJx6/0lVFHSobsHpmiYQ0oXK8UTl4FtesNU+XWpRjQFKIk4HEe
	X3k0pTXTlVxbld/m86cI6gtK3GM8m4yhNJUK7s7y8+tu6+J63/0k1VtCJv/rtZhQ
	I6vt2Ms88Jajl1FXdo0eD6STlr/q//I1qL7CJT+Qmd/perlDEvcyZDwn+IJTKy5U
	bwbyddE1RSOCYy5+9FdUtrvTqWCIExA1wY3ZjZR0vrcgXMD39NxiLgyNAVVQKkKF
	D80CyHz0hLgYgLuDpU337w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywpncbmqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 13:43:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45QDfYsx023355;
	Wed, 26 Jun 2024 13:43:52 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2fkefw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 13:43:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=drsEeq2pHfhsAEnLrLd9IoIzWM7gA+0kBRR6TUG5BHKU83XaSkqhlQ4kv8ZAxVnPL6grQqV3GZS+tIvuz3KI3SpyAHPThT45u0Vy79TROFyZpK966uRmmR1t699CeQpBuvwNreqR8k6DuSPpVk/ug2e1a0blV2PFPmyjNdR1k60HRQevP1ik6sfzIts1vvhR7s+TNJ5+0wLDHG+xN/qLsHzXW41cQZ63oS9rSSM1OlpsMyuS0GbXAVewIjVmjGz1QuJ3fMREbYBdfgGOAUBMt4TIdZKjWX45yM4Mq9gyzBXw0mVMxrsMzw9zHNd3q29VUhhfUKMsXCQwl2FzhZnH8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7rUs6wcghU5UwuKJxobtdzP7COU0EvoNyDtOQ7eonRU=;
 b=N1DV6kWTBPINqwoK8DQmJHJylNfegYPZ/QnY96FvliKWSd5IkbuCX2TvGU2zg/j963WZnOAh+/Xkzyba5evZrtL1Bp2+YTNPjBk1uJg6wwhqvNmPoRKgBltiuTq4z/u9yayUG8kEJHDZx5xbAr5KjCsqRRVG1DWBckKInbxeMZgT98/34aJ91Cz+P2C6RPDkHMBbDJBhHk4N40MjoB4GZOGKoiragLW09243zS1lxzEmh9FLOsQMDXtIizYkFGnZXr9VuVd9dmwL2xfWeovJKnMxWXObpdsRB6psNbwYVketEe4SFzIVrhTSw33wZkahbRzQNH9pAEr3SsyhQdvpHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rUs6wcghU5UwuKJxobtdzP7COU0EvoNyDtOQ7eonRU=;
 b=Yw1btv44HBOSTDyOcXSqWovGF0W4kRHpSWOZndaS9S8Fv+IzNzGrhnldPx/9wsjgH3P/lpcuWOIZ/GFOGvsC22sKR62H0ostkp106yASnoCAvQdEDg9I8p14Y2briVc7lIpeNtkzc1qtEUHy00E5nm0WkF3cWmE39UqVDmLIOnA=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by IA0PR10MB7135.namprd10.prod.outlook.com (2603:10b6:208:401::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 13:43:48 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%5]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 13:43:48 +0000
Message-ID: <30c5fe13-f0ba-4f49-bbb9-88e54d80151b@oracle.com>
Date: Wed, 26 Jun 2024 14:43:40 +0100
Subject: Re: [PATCH v1 00/10] iommufd/{iova_bitmap,selftest}: Fix dirty
 hugepages tracking and selftests
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, Avihai Horon <avihaih@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
References: <20240621184254.45477-1-joao.m.martins@oracle.com>
 <20240626134137.GF2494510@nvidia.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20240626134137.GF2494510@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0621.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::21) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|IA0PR10MB7135:EE_
X-MS-Office365-Filtering-Correlation-Id: ed69b905-d915-46af-1fe6-08dc95e6018f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|376012|366014|1800799022;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OVlmdk1VYTFSREJwMWVFWXJmazZmZG5ITnNmam0xNVpaZHRhbzduUmk0OGQ4?=
 =?utf-8?B?T0NjRWtUbVl1NTU3YTBlVk1PLzNneFIySHJJYXNtdi9YVE5SL1lDN1M0TnBa?=
 =?utf-8?B?VkpIZUhoTVlNZ1VWM2lYdmNacXFjTTlsaE5VTm1pVWNoaDNBUlM3YVpkMTh2?=
 =?utf-8?B?WVA5ZUkvTkhGUkNVaEVDN1huUnlvZzRwLzBCVGdEd0MyTHZTb1d3VzhDUlB0?=
 =?utf-8?B?TXRxVk9aUGNFKytBR1ZZcXNnaU96WEFHOXBwcWhRZUYxaTBpaWhOSVJYcVBB?=
 =?utf-8?B?YmJzdFlHYm5nS0M1cWNacDRML29oNlhJRUd4bytGbHZFUzVTSGFsQ3hPem5x?=
 =?utf-8?B?YnRDaVdNQ1FsSTErNE9sMk42cUo1a2NGZVRqL3lHYldrbmlLTFFzTldUNkVw?=
 =?utf-8?B?c08yUGdIcHFHb25XOUFvb3NSU1pLVzh3dVJPN1YxTlRSYTQza25EYWhzNHQx?=
 =?utf-8?B?QjVpZFM5QkQwR3puTjRCZ29hZ1UwbUtYN1NQaU1hWHBQY0RaOGxPYyt4Uys2?=
 =?utf-8?B?SVR1b1BtSzRDeUo0L3h4cVZHdVNuTnRKSkNjQ1lkQ2RBeFFpaXhFWk9yQ0N6?=
 =?utf-8?B?dzdVNTIvVmcrM2xVZ0YwZ0FoalpYTDdrN1R5TW0yU3IyNmoyRXpkZEt3T2E2?=
 =?utf-8?B?QXVybHVrVElXWlg1RVNHK25hd3h4cmlvYU5SOUEzTHZ0UzJ5c0RZVDhEakpk?=
 =?utf-8?B?REpSYVgwZkovY2JtR01DYlIvMGxxL0JMTHQrd1AxOVZsdzZiZ1l6cm55N2xs?=
 =?utf-8?B?a1E5d0R2SlVZc1hZeFJNRkZPZ25ZdFBJQzJ4U3dLeUY2bnI4LytHcGdLYWs2?=
 =?utf-8?B?emQrcTduODBjVWZ4LzEwQzFEVm1wNmdFUXZ0NWk4WFFXRk84UFdwQXNUamdS?=
 =?utf-8?B?blp4Z01keWFWR1FDTmE5UmpiZjlJaHQ3cEFVNml5cFc5eEtkK05mMTI3WGFD?=
 =?utf-8?B?M1orVmZ1cEZ4MnFjdU1GTVJzVFFtNS81QktEZkduYWhoVDJLdXg3N0VUbUFQ?=
 =?utf-8?B?VkRxcmRBSzE5OW9XTDZyNlFGeVloM21FWUNLWTQ1QjJRc01tOEd5MWpnQnE2?=
 =?utf-8?B?dXZDVmY5QjdxczBYSEwrUE4zVC8xNGZhT2VqMEQrWlI4ZmxKZks4dHEvdGww?=
 =?utf-8?B?dEJOaTl4SXJwajU2bWhCcmRGZk9CbWtra0Qwd0xPTGl1MlkrdytGQVZSNEZ4?=
 =?utf-8?B?QTBQRHQycUdrVWF0dnc3Vk1Mc05mc080MG44eVNQVG5hTFFGZm9yOGlkdFpo?=
 =?utf-8?B?dDlPTHlOazA2UVA0UzA5SUxQWVBCNXFFeENzZVFKWHh2ZGZLTnJvSHZ0NWlV?=
 =?utf-8?B?dXNnV3ErQTN3bkpPc0d5R2RUZWpwYlNNSEZVL2FHVTVsNGNXclBZbVFUZmd5?=
 =?utf-8?B?YVhPWlBFZFArNHlQWWhVN0ZCdGxXbVVHZDllVGYvZ25rR0t2bmNCQjg3QjhG?=
 =?utf-8?B?S1NBdVZLeVVNdkROMlF5b2syRzVJelpJV0FScVEzOXJYS09mdjBqa2dIWWpl?=
 =?utf-8?B?RUpVcnBvRFd5N2NFM0dmc1JnYm01TUQ3QlliZVpGQVlXYmJBd3R4bU5jS2hs?=
 =?utf-8?B?TW1iZmxCemJEakxucm9tRjFqOFBFZ2pIQklDMGwxemQyUVNuaUlVUld2a2h2?=
 =?utf-8?B?ak9qZ3lwTHZSTFhZczJSWmVrNDZRYmpBb25kcnYrcDhMOWw1QURHVEg5Wlhr?=
 =?utf-8?B?aGZYWE9oQnBOOUVwOWdveEJpRzMrYTR2Y2JEZStBcWNNL240ZDJPMGpXdHdw?=
 =?utf-8?B?N1dyNk5XbU9mbGsxcHZiaUhkODZUT0FCRUlQQXRCOE1YTXZPcW5ROVY5c0Zk?=
 =?utf-8?B?dXdCUkcyR1BYeU9vUHBRQT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5893.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(376012)(366014)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?a3J6RXhQbjllS096cUxnMW1JbkpGTm03VzRwOTh4eTFnbGJmK3o3VUt6WDRm?=
 =?utf-8?B?QkdhVnR3dHZrSEdtcmd6aDdVdVlkVHIvWGVhRFdpckYybFhBeVV6K2xwRkEx?=
 =?utf-8?B?dk5JcERhd25mQkpPRTRqcEV2NmdFVXFvNlc0WEZvdDhjUDBlbjd5L1BUWnFo?=
 =?utf-8?B?M0tNVDJUbEVnTUQ0YWROUlJOR05vY1Z3V0R2MlRkL3Y2Ky93RWxLbXYwQzJF?=
 =?utf-8?B?RERLTE95d21NRmlVb0pqV0dlT1VwU3NMZkg5ZzJ2UGRjdktpaVFuV1YrbU91?=
 =?utf-8?B?OUpNeGJrWGdPeDZvWkVoLzRjeGdWTFZCZlBocHdyVnl6SzVPaGFlcGpVYWRC?=
 =?utf-8?B?cnVmSktMUU9yR0IxZ24zYkZ4dzkvY1NSOFdnaC91TTFpMWtvYkhnanIwcVZ5?=
 =?utf-8?B?bVZyT2doSjlIeU1ESXBWRTh3Ujk1RU51UjJZRDdEL2s3d0lJRndiUmMxeFRM?=
 =?utf-8?B?SGFUQnhqSWtvMVJKVjZZaW1BUE1PNFFuOFJha0I0ZHBmKzdIa0laREl1SlFo?=
 =?utf-8?B?cG94b3l1bDZLRnFCVUFsN2U2d0FaQVhENHlWV0VsdzI4NytVNG1BTXZVVktO?=
 =?utf-8?B?cGxMVFFwUzlOUFczV2RSWmF6bFZQVUNDcGtYYy9XKzRiNk1ZRkZnNXJNclQ5?=
 =?utf-8?B?MXBhVEdrN28zZTFYSlV1N3pyZEZyaHZubktjSUZDT1RCQWZVc2RWWk5zUmlI?=
 =?utf-8?B?c2o2SENOM3ozbDdMS00wdWp4VjJuZ0hLVXZJWUI0aktoQjFMb1QrOXROOWFT?=
 =?utf-8?B?NFc2TXlldDluQ1FBMWJyY0NRVzlXR21rc1RBOTBxeElHNHZSOXQ0bks3QUtp?=
 =?utf-8?B?ZnhwUXhUUlZmb3JWUXFWTGd6Sll0NHhlZWJ4aGgzQ09SZWZKUEd0Zmwyc21E?=
 =?utf-8?B?UWRaellDN2h1UG03blRxUzBaV3U5d0dMRFFMK0tvOXVlN1dzSXlpQzlZbGI5?=
 =?utf-8?B?MkRJdWFoTTJnQkNvV20zZHpzRVY2bFNFdWQ4bjVqVmN3MWxPUUtRNUhxb2h3?=
 =?utf-8?B?R1ZXRFNHbGRCUFBEZjBVcEVrYU1PbjB0U28wQ0lIaDBWZ1psTWU5R3I1cmpk?=
 =?utf-8?B?MVVCOGc0aFFoQXN5eWRscDJucWFwL2NaQk9HYkRUeUprb0UzUnVnd0h1SkVl?=
 =?utf-8?B?RTlQcmRPNXZIU3UrS3dQdVBYNEt6RGlZUUdFMmpUQUNFSlJYM0puMjlqc0lS?=
 =?utf-8?B?SFpTcGVZcXoxaG9KMnAvSEpndEQ4cW13WTFPbmRCM0UweFU2b3crT3k2dUxV?=
 =?utf-8?B?S0ZVb0lFdnFFVGhnb0E0bzZ1RHdpNFFNRzc4Z1lOVEtXZmpQUyt4aTc4UTRp?=
 =?utf-8?B?U3NoNjR1N0lDMk1ieDFMdjJlMVVyN0J3N0JqSzgzMnRvRUhFazVkeGVkRGMz?=
 =?utf-8?B?bXArNEJhVHJYN3ZrMHZyNVp4VFloaUViTTFwSnpQYm9NK2YvT2pEd3hHd3VI?=
 =?utf-8?B?LzZoZXByci9VaWVUdDFDN2JPN003M09xMWxzNXA0YjZOSVMyNkl3c2JvS016?=
 =?utf-8?B?WS9Gd1hKazlyb3BZV2dQVXNQcElIanlKVHUwdXJxbnN4eUErb0FIcmxQd1RX?=
 =?utf-8?B?UCt2Z2w0MGJPSFlmcG1sTVdYcE1oMmw5blpGVE5OTjBLckNzRlU1cmJJTlpz?=
 =?utf-8?B?Y0pTNytSdHlxQVJ6eUUxSmRlRVRvVnp1TjBTNlJPRjdRcENPK0cyay9ObCtD?=
 =?utf-8?B?Y1QwbHZNMXBSbjJ4VHJMNEJFSzZJQzRpb1pWNFZ6bzVwcERpaGR4UzZyTkZn?=
 =?utf-8?B?cDRObTB2aWdBQ3N6TlRMbjA0S0ppTjlvL2gyWjJWcFpIOTNJaDc4b1FTUi9D?=
 =?utf-8?B?Rk9uYVpxZnpmUjhkZVJOMWhCUEExc1REbWF1TndFcnU0Z01JSWdQeFFYY3hJ?=
 =?utf-8?B?a3N6eGVxNnFucEFxWFVBVS9XdHk1cTAxcFFoclJhRmVMclpxdjIrUlVLOXJz?=
 =?utf-8?B?NmZ5Q2hJMDgyQzNKeDZQTGxYcExHcWhtbGpIVkJVQ1pXMXFsVkVWcm1Samlk?=
 =?utf-8?B?U2swa1VTY0F2dnBPZTNlRUk5emZEWEYyOUZhMk9xUzBzSTU3NGJMYklDcGxn?=
 =?utf-8?B?YThuVFBNZ2QrazJvMzYzOXVoZTIvaStZcUkrUWZnTkNsR05DWEdUeisrWjdI?=
 =?utf-8?B?bnBUYzRhNCsxOS9Lby9tQVFpcWN1ODNTNjFMazIxNDRlM2pWbWN3RmJqV2Vw?=
 =?utf-8?B?Ymc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	5BZsHn/QhMrtvz6K43qNCTJYHKuWQ4nGO8G0rjDQFreRrmgtbTmXWQeNnlxVbKBjHlkR4zEY2VJeEgelNv+z+dc1Y/KPa/K3tp7Ha4n60GTupEnTx1DA1LBQy5Mr8UYaf7Qx2Q0WCXwhEx1v5N8A7Q1MrSMBcB87BYAH0ttBfZ69LEbWeo/7k1YhAQqJXLuWjobj6uAs4eaIWtslcRRTSgDDZpprw4AAyY6n7lcB1es1spnCTWfVlkROOwmgECvNQfv/L7a49VmTYg5Jemzq+HcfZB7qOfaPqjq4DEI8TMqssfNjKClD+AKWUMkrYiIGPLorgRY5A/4Gx7ilzA3MId53srzY113gbBlg8NPiQvCW6xyjt+RiPvyR1A+eSpM2Zuc6Q7OA/4726yqZNnMSXdAc8ntxrG6VvZt5rwhZfuMX+n8+xlmnR49pU1Z5FnpuNM2CIg9PicRAVL2OeRacqadWXcZRBWpctcvcCkjRvTXiEnHeC/p07Urzy7b9ASrvD4z1qVJ2q3UN6nwD0r0WtKvhIOvxw8I9LxrnurOJS5l3AHFJkupt31w7hz7uPS1K1R04VhoSO/cRYESdDN0h2+K+bgLPX0WzHvvGRbivZVs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed69b905-d915-46af-1fe6-08dc95e6018f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 13:43:48.3504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yTFbo1e8PAXGejxnf4QjSMcKpgiktvBOeBS5ttKtLHRotU5Kqx67UjcHRu7QCiI2t3scD2cNKbU1YE+00RVbRpJu6K95ifFf0F8Q5W2P7dQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7135
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_07,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=814
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406260102
X-Proofpoint-GUID: 8E2i5s_n8Ix7rxlHm9ef9W1n0sFFvcya
X-Proofpoint-ORIG-GUID: 8E2i5s_n8Ix7rxlHm9ef9W1n0sFFvcya

On 26/06/2024 14:41, Jason Gunthorpe wrote:
> On Fri, Jun 21, 2024 at 07:42:44PM +0100, Joao Martins wrote:
>> Joao Martins (10):
>>   iommufd/selftest: Fix dirty bitmap tests with u8 bitmaps
>>   iommufd/selftest: Fix iommufd_test_dirty() to handle <u8 bitmaps
>>   iommufd/selftest: Add tests for <= u8 bitmap sizes
>>   iommufd/selftest: Do not record head iova to better match iommu drivers
>>   iommufd/iova_bitmap: Check iova_bitmap_done() after set ahead
>>   iommufd/iova_bitmap: Cache mapped length in iova_bitmap_map struct
>>   iommufd/iova_bitmap: Move initial pinning to iova_bitmap_for_each()
>>   iommufd/iova_bitmap: Consolidate iova_bitmap_set exit conditionals
>>   iommufd/iova_bitmap: Dynamic pinning on iova_bitmap_set()
>>   iommufd/iova_bitmap: Remove iterator logic
> 
> It seems OK, you'll send a v2 with the little updates?

Yeap
