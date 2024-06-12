Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3C117B417
	for <iommu@lists.linux.dev>; Wed, 12 Jun 2024 13:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718197392; cv=fail; b=Q8wgYNeutkzEVcUtAYyoJKt60AbGWBexrmjchwpss2oxVXKsebJpaE0GMUnh6CvjfVVaDx/hS7Ggtkh3kMiL6Wu63Sv+Q51ih7akrBYZJUsDtl87Q4BcRkxtIW1ypXu2Lzr7VHVYX8k/Pae36R6s9O/wxsouXO7wWFjXp9rrQ/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718197392; c=relaxed/simple;
	bh=cFmjDiN60+pWqX4/stmJR9lxHS+mhV7SdK9X/NPWMhE=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=SV+ZTGwV9EU/YRa0jKrhEVB4VNhoKI0CVGPKKZ8wryfnAvA9p1+cAjzvveo/LqydeDE9xWVCgU7DfECbRy2kTGXxUhRnmdKsRorCN3a12WfEQUqvXmKPOpBJOa4zpgbKYQOBZWop7voox/RNsLz50CNSN5dJD2CTvHswxbZ0LVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HypPQKFQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=m/qDzPft; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HypPQKFQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="m/qDzPft"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45C7BR6A029231;
	Wed, 12 Jun 2024 13:03:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:to:cc:from:subject:content-type
	:content-transfer-encoding:mime-version; s=corp-2023-11-20; bh=c
	FmjDiN60+pWqX4/stmJR9lxHS+mhV7SdK9X/NPWMhE=; b=HypPQKFQWpUY3Qnv2
	tOI3ddC3/ebS1ttkmeMZfKr99kVgzSdDT574aNUgPqOHi05jPfAgw4P9+6wsrCez
	nr8uwOxyWe9VqFaUdocmzRI/zjs3YC419Atpw9vx2+qe8OED0beuBE/ALEtINoBQ
	8umdne3dHfnbhgwM6Vgb+RsvNvfkrP0REDiHOWk4MZQcERnMcgBIl5zofi7dCATP
	Fr6Tt5AV18FTgUvvuBYUYbPWEOINfPWmGxPXWUvepFztr6GDz1EDNhGgoNqQMqt2
	TeaBn4qxPUb0zrKOgajwZsAbHTgr1F9Iu3JFzpnmB+nNS9mdy5+LIIkK20Nmfc8c
	Ad5gw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh7dq4k8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Jun 2024 13:03:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45CBNHMN021135;
	Wed, 12 Jun 2024 13:03:00 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yncavy84y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Jun 2024 13:03:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TO8/uQnb8LXnFmCXUKIbdOEy7ANWelINxjBYv5m1pv4dV2HIQ6gpx0Vn8zq/1/0Kq0HljNZ2S+y5nHGanPGrSMWPxwUMw1ngh4Ziy7RMZq9ZUtBVkqK/z3X94X3Az+j3eHX2GLNS531XclJ0rAumB5nyL+rvXpZpm4BBGpSGDzQ7NIlyDH4hLDVlgxyijXRAVBnZMhzggQLUTjw65G/qUVxF4dDXfJZ4GjpAEiu9HnOns29oPyBI2maTz7pkMXm46cTKicHlDJNfp2gTFyIQxwifC87534jiTe2+mQDfds6U9FrO6sfdvLI8S/bH4ymHP6pFVCiTV25X3/RmA05caA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFmjDiN60+pWqX4/stmJR9lxHS+mhV7SdK9X/NPWMhE=;
 b=VtDnGXvJiIkkULyaEHz9OGm2gJ2y7aXLrFW2BdbnTwN1leIPxnMm7NVEG9aP8LpdkZgwlm1Pn4dAc9JqlUa0HWwK7nfoV9tfwOZX864RbaL7SracHakwukeYIEvcnjuwSD1IEaDaCNsaYFYFcGyHHp4ILIx3jRTOSENuNbrSXnKC6ueLINFU11JLpDfpTeuyEuej2W8lviNJjL+tjr++V2gcgZN5x+9BwmV3HYWmwGgcHpb4CF7xAujy0Ohe/x+9vAh+J83NO5st8B8QDRq7fX+3HX7MgGi2n18wnJzarVC4CIWwNmVzhKeus9WulIUXLcDp6l7AbIC7/Bvf/pvgHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFmjDiN60+pWqX4/stmJR9lxHS+mhV7SdK9X/NPWMhE=;
 b=m/qDzPftX/cfbpxNMLKZjBOIAtfXL7G1TKAQ0qaYDMpNNvAzNa7FbrOXLrekjoFYJSrOHb6FjIyO0sTr6So+ArVGz6ilfFOSSB9AuhRrVC5jUjNcGgPDhiSuoR32NLRui6RV/Tr3SIXtTcozUjy/k8oSpoBBDDgKMhYZxVVN8f8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB6342.namprd10.prod.outlook.com (2603:10b6:806:255::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 13:02:57 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7633.036; Wed, 12 Jun 2024
 13:02:57 +0000
Message-ID: <7f8d95a1-9dde-492c-9eaa-84a17607495d@oracle.com>
Date: Wed, 12 Jun 2024 14:02:53 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: robin.murphy@arm.com
Cc: iommu@lists.linux.dev, vasant.hegde@amd.com
From: John Garry <john.g.garry@oracle.com>
Subject: About iommu_dma_alloc_iova() missing incremental change
Organization: Oracle Corporation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0077.eurprd04.prod.outlook.com
 (2603:10a6:208:be::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB6342:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cabc174-1fc0-4347-09cf-08dc8adffab3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|1800799016|366008|376006;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VGpkYkpmU1NSaVVHblE5d2JqWHF0Qzc1TVd6cDU5ejZXbkRHSmpjUEF2N0cv?=
 =?utf-8?B?UWI2aWwwNUU2dmpmNFVPZjJyRmFuSXFqclpISlFKb3UwMjVlcFdQVUpOUTdk?=
 =?utf-8?B?RTdWbUJHMXA3eUMxMTRwdjlPK2tPb3dtUUwwMEt2ZXlZSmY0ZTB2Rko4S3du?=
 =?utf-8?B?OVB0eDJBQlRyYkZ5Vk9xd29NdXNjTFBKRFU5S09TcnQ0VUFyb05icDRYYXkw?=
 =?utf-8?B?aFdDc3JHSWZzNWhYM3hjWDhPZWJkeTd1RWJ1ZnlyeTBxTEQrMm1oMWZGd28z?=
 =?utf-8?B?MWozSWRKMUNjNDJlRkNoTXdQcGhvMGUwTWxaRDk2OTcyOGdCanNQQUtCN09h?=
 =?utf-8?B?Q3FmeDNtZzZOTGRzVHJRRzRVT0JYYVJ2ZGE2RTlNbWF5YjZZdGRJNUs4djBy?=
 =?utf-8?B?UzJzUzV4c1k4RW5IY2VkYVkwVitVMXVGTWErT1NjWXNuMlYxdXlSSVBRdXk5?=
 =?utf-8?B?S2hMc0o0VlBkYWdaMUtJRVNjU3dSOERWNUhRZ25Pb0hlbUwrSWNJY2dwWS9M?=
 =?utf-8?B?ZXdXcU1ZUDBESGlqWHNtTEpKbWtaYmZicjNEOTJ5N01EeFFJZWJjK2paMGQ1?=
 =?utf-8?B?UlJtTVdXck9iNU5iMEQzVVNDZ0ZIR1dxV0NmcFRTbWkvbXR1REhzNkRCbUdS?=
 =?utf-8?B?aWlhYXhoNXMyZE1WQ1QxQzZZV2IxMnJHMm5nbExvN3J5cGhmOWFrMnFBTjR1?=
 =?utf-8?B?QS9HUjFDNTVUL0YveEJGaXVWaTIyY0w0SzdudzVTd3VTVVpDYTFkcVR6eXNa?=
 =?utf-8?B?RmZIVlJwcGgzQVIyMFRZZHFJZ0lxZWRMbWp6NW96UHBuREsxL2FHWk9JdVM5?=
 =?utf-8?B?aFRmbWtNM0VhdVdLR21RSGlkODd3a0J3Rnk5cWxnMGZsbzhqL1IxVllTeFhV?=
 =?utf-8?B?eFUzalo1cW9VWUpWSEFUSHd5QUFXMmVKd0pNVjE1RjhMcmMrNW9mYWtEMlcr?=
 =?utf-8?B?TWhiK0ppU1Z0REVMNnNYcVJZcjF1SEMrZnNsOU9tdWpxZTdrdXNnNTJDVVMz?=
 =?utf-8?B?dTV1QW13QUFTMVFmZWlWamczNDVub3JCNWd5cVpDWFZyUUk2UmxxZWRTVnhU?=
 =?utf-8?B?amd5dU84OHJ4Vmo0WFZjMWo3S1JYQytWK2RtMzFiZGpPbVJqd0I5MFl2UERw?=
 =?utf-8?B?UzEwZnVnNFNacklaYTQ4dVhFSHRMSE1jSkxYWjgwaWJkL05GcWJNdG54L2Mz?=
 =?utf-8?B?Vkk0YUlvY1BSc2V0M0MzVzdmRTlxU0ZtRnpaM1NKSFpDemwvWDhEMEd4TFZB?=
 =?utf-8?B?T05zWEZOZGJ1aEpVd3pQS0w5eCtmU0VPNjJIYmZFeEN4dXc5Rzl5cUg4MTBR?=
 =?utf-8?B?ZzhCN0lFUDk5UTRDdTlSaWF2NEVZM3dxeXlGeGlTMTJPb1VrYUtaMndOMGgy?=
 =?utf-8?B?bTVHeDJReXRLcjhFZHBSVWVRY0FqOTAzM1hHcFFYN1J2eTZNMnA0ZzZpRDRu?=
 =?utf-8?B?R3FVQ0t4N2c1STdUQXhlTk5zUFd6SDhJOUgrK1FNR2R4dlVmQkthdVl3dkM1?=
 =?utf-8?B?N3dBbUk5cDBiS3ZHQ1U2cGxvVjZXS1ZrSFo1YlU0K0FnRUozR2VMbGp2TWl1?=
 =?utf-8?B?YlpRaEJ4emZqeFlVblk3bHV5c2poZjhPN0w1ZXMvNVdVNHhZN2RINUNEQXJJ?=
 =?utf-8?B?cDY3NTIzL2x6QnU3VTlGRkNOSGxCdlFaaG83bkNPMy9nYUZ5SkFyZUw2bUdW?=
 =?utf-8?B?TlZ5Z2x3b3gyVWxBRzZ5VHNUajh6ZHdTMVg4VkpQZHFJcFNhcy9ZbXlaQ0FQ?=
 =?utf-8?Q?480FSY7URkf1Cd053ipZ0jVfjIJJJPrnQ6bg69Q?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(366008)(376006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Mm9HSERFc1lycHU0aEI5YVZpR1Ard0JDQkZEeE10KzNlbUVKU0ZZcmlrdTRi?=
 =?utf-8?B?dEVuV09xdkdVTWVlNGJsL25SUnYyVVZmL1JaaUd0eFJ3QWZMWVVXUDZJRVQy?=
 =?utf-8?B?QVVTcktVa1o3K3RBK1FEZjdCMGFUeEhTenlHT2hMRDRhZy9oUTZReWIySkNm?=
 =?utf-8?B?ZzBKZGh0OHYzWXV1Y3poeW9TdzFJNC9ETjBLUGpzek91MkxDMGhva1dEYjVh?=
 =?utf-8?B?REFpRUVOM2ptbnFLVmQwbDNOcWFBbFI3akZMT0dtbk9pUlNSYkxUaThlSEx4?=
 =?utf-8?B?T2xMQ2hLelljOGY1TGU2UkYvNjBUS0hLZ01FMVZTLy8ydktza2IwODZQbUhM?=
 =?utf-8?B?MUZJRFRKOGRhWEZCU1l2b01OYmtweHdYUUpPdUFLWXRJWkZmS25qd0NKektF?=
 =?utf-8?B?cSsyUnRTcnM5V0NzWG9aRk5jYWoxMzJFWS9FZGRHUFlQdUFoTlVuUENKNSsr?=
 =?utf-8?B?aVowSVZuQ3M5SjgxeGNKaG9jVC9aaytQTHFrMmlCS2xIb2NqMmdRVFBBU0kw?=
 =?utf-8?B?SmFxREtnbzJtY09NTG8yc1dqWlFQQUZXMmFmWUkra1dqRU5raHd1RDRMZWVu?=
 =?utf-8?B?b0QwL3FnbTFUOHJMcVpoNDZRdjBZazZza0U3clVsK0tucmJlaUZhTFJSWWZE?=
 =?utf-8?B?L0crUkJ0enJPWUZabWo4WTRHSWt0S3YwbzdLK2NWZjdLT3NNOHh6a3VRSUNm?=
 =?utf-8?B?Q0MxMUVkalpKMW16TC8zaEdOWG9KZDcwdG5Od0NPa3VWQkNRSHFMamM3TXI2?=
 =?utf-8?B?dEJjWGpMNWxsS0g4ZXpRNjdQcE92SU9sMVpJa0s0MmpIL2tTUktlV0pyZTlG?=
 =?utf-8?B?K1g0YTllMTU2VVduWkpkdDQxL3pjSVJ4bGo4S2tRSmVmMmMvVWhaZUZVb1FP?=
 =?utf-8?B?ZWk3Q25YMTlNbmU3U3htVjFqNUxvTE1PWCtsZExhazZNcG1ERWdURnFXQjNN?=
 =?utf-8?B?YTMwNXBUNld5b0tscXBESlNOM2FYdEZWak52NlUzUVFqeXlpRUUxMDc1RFBL?=
 =?utf-8?B?THZMdzRLOHlRd0lBVmRQbld3NWNWdEw2aFZhZUFnM1BaVGRpdThOQ2hxb1h2?=
 =?utf-8?B?V256VWwrYVFETm9TL0hvVHAzKzNwd1RIK1B0cjNwWmxpRGRITUpOWXUxYXBh?=
 =?utf-8?B?K0h3UzcyZUtDUDdsa2RuWjVsVVV2RHVkMk1Bd2xxSU9JOTg4aGdqV21ZN2VC?=
 =?utf-8?B?SWtSZG5PR2Z5MmQ3Sm9iMUc5d1ZtM1JTYXNERzBLY05nRUM1aitQc1VMUjMx?=
 =?utf-8?B?Z1JTUkkwd09Dbmx6VjZ5eEZIUVBwc3BpSVJnaTBGY1kxNnVlSFYxa0RxTnkv?=
 =?utf-8?B?WDNhTEJvYUk0dEVZYXpHbXZpc0FpTXZDZGFUUjNYMFVjVDZjRFU5UXlGM3dq?=
 =?utf-8?B?YUR1QjIwcFZ3MXlNZmdvY1RHN2JqM1hlT1Q0RWNiQnFOQU82eGl6VE03b0ZT?=
 =?utf-8?B?Z1FDTVhJUkdlTHJoRk80aW82eDY2YlNXKzJlNzExa0V6MU1oZ2FFRCtZVnB5?=
 =?utf-8?B?TnBGVjJWdGJhdTRKOERVc1VscnJxZC9waTBlcitBdkw2YXJTSnNKdWcvU0Nh?=
 =?utf-8?B?aHZjSkE3bDA1Zy96aVh0UlFLbXdTSUNGZTJJdExhWC8vczlrYzMzVUpBVUNT?=
 =?utf-8?B?MjdzSEJzQW5LSXd5bFlVYmp0UzZCd1pkMzQ3ZWcwZGUvc0dxWFdTdVRrU1V1?=
 =?utf-8?B?Zzl2R3BoK0trMkJkTUtPNWwvaU5OOXVwOWt0QTVWdnhySDA4T3AxeU5VMEJo?=
 =?utf-8?B?TmlEcmVLMGIrdENKRU4rMGNzZkcyOGptVUpvUTRmbDZ0NnRmUXZ2dC9uY1U4?=
 =?utf-8?B?azZlcXV3U0dXMW0vQmxaK2xpS2tWdXo5QTBYNEtsT2YzUk01cG9yMkQyZ1hC?=
 =?utf-8?B?dTNzU2Q0THF4RDJPeklnMlBQU3RidGozbHpnclNjNlVCcmJXcGNseXJSQTFG?=
 =?utf-8?B?WUIxWUJBTkpRSWtQSHhGS08xNGtxQmJzUm9qb2psRjIrdVFuVy96cWM1OWlQ?=
 =?utf-8?B?SmNwL3AvOUpOVmhJa0tPcFVaRTFYNnUwZUJoNi80bXpJN1FCUHkyejUwL29B?=
 =?utf-8?B?VFN1eUlNMlpxWjNId2d3SWFkc2F3WTVoYmxLdnpINVhOY1BoVFA3Wk1jSHkr?=
 =?utf-8?B?K3VSM2JuZUFEcmJQNExyVHVTbEpPcGowdkJXQW9MQXUzdWVFNHpQZ3RLRmhJ?=
 =?utf-8?B?NFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	TeQuyM0MyJACg5CjW3tr77b1AKuH50higWHq91Kv3DjP1ze9PMWHmrvTmfF2tKpc6xgdvOf6qR/XtEZ1tWksMnI8LO5v4RCNP0xav6mPL18ta1QOAHqfHSQ4W+5lqjQ5jU5LJ/uSu1w2fbbUoncPtDVTSeFCV7XauRka3uPj9DRC6EO2c2HsVoL4Vnvsr5i+Ac9qlmcBAynvWeRZHkfMYm+6FOqSEcdtQCuDuNODCnChvS7PeQIOSr98BmDva1vcOgmmo7/xvsuy0y4vgSwh4GsfaxfroCd42Vvv5NysXYAboNLIOPCKxoQmH1Z/rC/rzVCZwhxuJm4wlseu9bvOeVFIeg5axPTmJYxm1GF7KBVs/1QM1zFLlKKyoSLVM9WPpFoUaH3tU4TeUaGRHjqQ3MNyN8OLzKnJjXlARz56FyDVw21ft1/T8p2iZH+HcHIcSF3JjRCWR6eXxQR0S8qJCqM31uisjr3rkqQ2jEFVut7h8s+nD9/ZVa8Ey6JqhpsbyfzecG6nUmY123ZeSbTxMvtAnn9N3NyvKk7XcKlKlLo//Vt4A3duCswyxXhYcCYM4nIfpTEkdZB8Gm4ecAVZMMeWdYkdt7ZhKEp2zpmaE64=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cabc174-1fc0-4347-09cf-08dc8adffab3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 13:02:57.2186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ayzGJfbHo0vGUqku1N+uUhzZOcvjJwlVMJERr5GivCr01UZiYzbwndfsJF6QGdurOYszDywXrmo2wEcny24cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6342
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_06,2024-06-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=792
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406120093
X-Proofpoint-GUID: iuvNpVTb-_SCtIgI4NMzpDjeWkiFi1EB
X-Proofpoint-ORIG-GUID: iuvNpVTb-_SCtIgI4NMzpDjeWkiFi1EB

Hi Robin,

Was your code at the following missed for iommu_dma_alloc_iova():

https://lore.kernel.org/lkml/54083e3b-cba3-c719-651d-bf99d6eca16d@arm.com/

Maybe not, since no one has complained about it :)

I just noticed this code change again by chance.

Cheers,
John
