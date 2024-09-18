Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B5B1C231C
	for <iommu@lists.linux.dev>; Wed, 18 Sep 2024 14:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726671147; cv=fail; b=gTSPxQ/dwiMDpourTidgXk+or6G+K6+dG6EBL94TLLIM0m6dwgcZU2h8cecX7Wa8IwKVMfD05/uFq9Se1/6lUPUXwJFKlTIdE3Q7dXGZpWudBDv7lzWkI3aD0JzargrMR6g7UBIP83NTY6Zug7kg0sB0dA2O6E1XLOD77+uYdvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726671147; c=relaxed/simple;
	bh=xXdwuQ6zaGRVu6jczKm9Kc6r76OLEG0B/th3ze5bcYY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bNfQxnFmhh13uqjNBvv+BRCP7FDqUUGvfRM6dBnFxVNrJYtdIpSiwUs1WNZC/yfbp0rO3jbSMOj8x/OykZcvZUXYfQfqZ2i+r+rCk5So26a3h+IH8ExSIj9vtdu1wbQRfzGaW/vz3WWGHMeIyXshpUK9lXfncNxQUtE6Locp7S0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZwWdLbyb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pI/9uESc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZwWdLbyb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pI/9uESc"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48IEkwto027796;
	Wed, 18 Sep 2024 14:52:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=LmIH87D3I01W7JAV1gWyY0QPMkWWXbxwvvHFSpJxLBM=; b=
	ZwWdLbybCtgYMl+Kt/yFf0BxMiD1iUNek1RaEdrfZ7QpGi5MW/auSJFuh22wwZp3
	y/DRv8Doc55+Zjk1SBw/JfY4NSLeEI2BRjJU+Zs5fiS7al2qNHDZndMhpL71AH15
	MA1Vau/Z/PXGDOMFCKoCCPQ8MSnX/ARRzIuvxDBvM3gsC5ypKJOgWlMuzNDzuSHU
	uP4LCd2HQ1iuJo8m1rUPw2iOxK2+A7lAX9lc4tKrd9WiFPKkIpf8FZUESIwGF0rV
	5UzH5lZOjPLgLKyUBjQMH08r0bys2EGOoUfBTCI8pajRna1TWOphwc/5iy1HCW61
	3QpwtpGY9YjJZ7MUXFCUWA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3nfsh8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Sep 2024 14:52:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48IDSTiT011116;
	Wed, 18 Sep 2024 14:52:17 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41nyb8dh62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Sep 2024 14:52:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nwV3jV/RPpSDA0XLTPw+KbG2pvleJSJjpMHAFZkrlhWlNnh++Mwf8tluVElRODUtF1Cha0KBajVTaeDlvpYDFVY02AuUq9MCWIW/2LdxFKrN4Z/EAnubALNMcEO+SP6AGKOajaRFjHC+Ac09wtwmUzBkMNRVrs64j4ZPippfwutIi/0AZUcxNYSSVpNsIW7SSD2J0vKlFGyYxnVqH10awq5nH/ZeWIqVbyHFRTwpqikEwoe2Tgxopgf1c3ZOd0cAXB8XsIfXo7I+b7HFs41/XjkFe0anVir9egFwnzIy0YFM8vqSFFcQ23//aZX2d85RYX8ECh2AJOJhkL6Ee519Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmIH87D3I01W7JAV1gWyY0QPMkWWXbxwvvHFSpJxLBM=;
 b=FnYe2BqjpyoL7sxAZc7opZXnw6x0slLKBoMyvVKlc0OViVwEvT0KEKpNPhX2bX+X0rC2Zg/mbSOO9xE3EvAbhixHCGmbOBxLOPl9n6eRTGqDG41IoUogf6X5HaqcgKcXYtr+orouwdhb5lsBLjwh9jYWOzp3IIBXMIcqbSc0slsLxcYOkvLbqhZirRW1vnPBiYM9eHG8qyGks1qLBcyo5+ImmCwgsk29a2oixOB3H7Zy9xIcEIWRkr7gfZEGhY5gF1iQ1kcmSSf0iaChpb+GxrsKAnNasZmD35KqVKnQ4J6OBB1RQ+jpofP8mloY8mWDxI0PVAdO4QC+2tBy34u03Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmIH87D3I01W7JAV1gWyY0QPMkWWXbxwvvHFSpJxLBM=;
 b=pI/9uEScNcnKvT7aX9BXFzfySRjWY0C8Zs505BtmTor23Jok8zngYUTEtOhDn0S3vBISOwzniv8GEdJaIBlJZnp6yLHWGQGJ67o/K4r4nqWiHiBspVUXy0cQII56+0pr228YqhhwWYmZR4w4JueI+4KQVLuTQVWbCeZQmjobALE=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CY8PR10MB6825.namprd10.prod.outlook.com (2603:10b6:930:9c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Wed, 18 Sep
 2024 14:52:14 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7982.012; Wed, 18 Sep 2024
 14:52:14 +0000
Message-ID: <3e150dce-5ac4-4b60-9d27-7ec40e1a3164@oracle.com>
Date: Wed, 18 Sep 2024 10:52:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 9/9] iommufd: optimize file mapping
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>
References: <1726319158-283074-1-git-send-email-steven.sistare@oracle.com>
 <1726319158-283074-10-git-send-email-steven.sistare@oracle.com>
 <ZudKyNtw+sCcq/dK@nvidia.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZudKyNtw+sCcq/dK@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0057.prod.exchangelabs.com (2603:10b6:a03:94::34)
 To IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CY8PR10MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f1d361b-1e3a-4433-e03e-08dcd7f17bdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bDg5Q1RENVl3aXBLK25lYlZkMjdpRVoreDVDOEo3eXd0Zm1yd1Erd3FxZFZv?=
 =?utf-8?B?MHBZUDludFZ3aDJseWYvS3Q5TG90MGtkQks4NkxRSjVlelNPQmk0YmI2OFpO?=
 =?utf-8?B?dWxOUUZwR29TcUdXa0YyN1AzdWNCZ1RLSmp1UjNBSGYzRk1NWGhVSlhya2sv?=
 =?utf-8?B?TzdVMm5ZbDlDNXdVRjZXOUJLbUtQTGpuU1Z0eDZxaDE1SWNOWWtNdGN3aG54?=
 =?utf-8?B?UWtldTR4NUdiZnJQK2FzMUhLQUxGdDVKNW80blc3Q0tFWlc3aFErbFVJMHZk?=
 =?utf-8?B?UGdqanZDTklXcU9paGlnMCtZUkVvZUZ1VWpNRXJTZEZ1VlBxRUNXdmF6UFd5?=
 =?utf-8?B?cGtqMFEvZDZHQkU1Y2tXcThUblIraXRsNkswNitMTUtyL0R1TUVlZHIrNEF0?=
 =?utf-8?B?dWEvSVlvbks3UUdMUjk1dFdUZlI5ZFJuVXhWd0VMUWYrRTRiSVoyREJjdnhj?=
 =?utf-8?B?cTVsdWxSSWxGTXpWdSszR3Z4UUFOUTJiMXBNeHh3V0ZXTW5SVWwyYUdrcjFo?=
 =?utf-8?B?Sk9YVU5sSTdUNmFCTFB2U0gwOVFYaXRTWE90RWRaNEREeExSNjM2T0k1QUdk?=
 =?utf-8?B?cktabnZnSXRPYjVyY3Fhd0xjUE9uRW5hSld5aWlIZGFYNnNRcTlPRkJ6dUxY?=
 =?utf-8?B?UC9JU21vTkNzZVFJMVEyMXRHajg3SGliOFFVbG45UjNnb3ArRHBjVnpqWVp0?=
 =?utf-8?B?TmFHYjVRcG40TVBuOC8rR0paRmpmVGdBR0RyOS8yRUxHNUc3YStmUGE0bjlQ?=
 =?utf-8?B?YmJMQkVFc1hKSWpJYVlmTXhXMFgxOUNMQ3JMdnBnMlNib01QL24zOGszN0JZ?=
 =?utf-8?B?Q0UxMStwYU8wZDV3Qk56VHV2UHA0SDBzSUw3L2UvQXJoelFwZXh1ZytmNVg1?=
 =?utf-8?B?UjZ4cEc0UjVQTjRQUU5RbEg4aG9keHpiQkJFOEJpVFRiMENDeWdGU2hRZzVp?=
 =?utf-8?B?MzZ3bWwrVmNDUXYzb24xZFhwUG9MQ0JaSVRQcTUvelREMWswQWtDVkd6bmRW?=
 =?utf-8?B?TWU0UU5OeHNDbzJpMEFSZ2pPN2hlZ2g5NGVmeGZBNm5jMGR6Zk83eUt5RVlB?=
 =?utf-8?B?Mm51cmViQlVOenJzS1Y3c2pZNmkzbjh4QWJSS0JjY3JMYmZzUmFxTHVzb3Rq?=
 =?utf-8?B?SmV0WEhTREFyQVZXNmMvYjF6QkZwRGFSbVRtajBuNVREU1M3cDBxenFIbTVB?=
 =?utf-8?B?WWpMNWdrYUVoWVR0THpTZ1FDSlIzeTdkVE9MYW5LeWIycnh4QU1Tc2FxWE43?=
 =?utf-8?B?NTNKUUJzMTJuQ090U0pobHZURit0OXhYczkyaDlNWWVzUFNmZlBadXYva1hj?=
 =?utf-8?B?aTFiRjNqZ3IwaWR1Z3pyWDU3K3VjZzdCelBHcHQwTVdZSWFzZERpTEE5dk9o?=
 =?utf-8?B?bXNUc1hiOFpmZE01NGhIazZsa0gzQ2NOM3NoTFpyaDBhM3YyUTFLNUVld0JY?=
 =?utf-8?B?M3VuYjFETlpGSEUzZGZrdnh0UTZTM3M5ZkZKZXh2dEw2eGdMZlVUSzRkRGlE?=
 =?utf-8?B?SXBKSkJNUEhvRWVLcnJrLzZUcitUZTgzRllLWFhhMXFHc2NSdmZiUStBZ05y?=
 =?utf-8?B?enZUU3JybS83VTErZkp4NVZFWEdZTEREWkVsYXcwcVhuc1hnMGtnMzh2Yk5G?=
 =?utf-8?B?cU1taldCem5WYUtKWWtRWHhjcjVqb2R6UGtpcmpaQ1kycVNXcDYrbDVGSFZN?=
 =?utf-8?B?QWpmbm94TG1wcDVQSjRzeUQ4S3c1TTlFQUpPSmJ5TTdSTEt2dlpmMVBRSGF3?=
 =?utf-8?B?bEgyMnlLRFFNWmM2ZTFYT2ZxaXI1UVZ5KzNyT2NBTnFLeXdhNWJGMWVLSE02?=
 =?utf-8?B?WEthano2UDA5S1RpNVJyZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnhPa2dRUFRVdjJ5VENhT2VaUVltRTdpQmN1dHdSTlhQdHZMU2V6MnNNNkVk?=
 =?utf-8?B?cWJOY0tXR0NLY3lOK3h6RFVwVUh1M3lPQ3VYYy9yUG5RUVkwamw0cUZTNWdn?=
 =?utf-8?B?V2FnUEFzV2JRbTBRTXluLzUvYzlNOHY0U0IwWWd2bE04UHYvV3phWERkQzdp?=
 =?utf-8?B?NndRZ3JRTnlQMG1BNjE1M1UzSlVUNTJBSC9kaytKejJYN3o1bmUzUzEzTUI4?=
 =?utf-8?B?TEZCTDRCZG5FVlZYTUthWkc5QlNxOXp0bmVLWmNKeGhzK0RyY2NzN216SE9j?=
 =?utf-8?B?TVozQ1hObFJMV0djY2ZMU3YrcmVlTTdBakxRQW5OVHMwYWl2UXlYT05PYnd1?=
 =?utf-8?B?SVUvcVRjVzFLVzdvREdmTnlQSzhEbVVWdlBDYmwwMGNYZWdXbVdwV0k4aHRG?=
 =?utf-8?B?TjU5YWozdlJJS2Z4Tjd5bm94ZUx2TlRVTGJBa3FieGZtMTdjSFNFMDBNQ0hJ?=
 =?utf-8?B?V0YrZ1BXdmZmRWg4K1IzTzNRV0dEdUFMTnY1eTVWb0hCOXRjemk5Q3NROVhP?=
 =?utf-8?B?emF0Qk5SZndQSDlaN1dYeTBJL2wwSXlQVi9YUGF4cUptTWdnRmYrQisyZVFD?=
 =?utf-8?B?UEpCK2ZNWFd5VWNYOWFqTW5KczFHa1cyR29QSjFjWnlMMitUOGNwanBLemtV?=
 =?utf-8?B?Y3JpYk5tRCtQRFFHNEVaSmg5V2s3bGQ2enFmeFJ6bnJ4UDd0SHdyVGJXM0xG?=
 =?utf-8?B?SUVoV01xa3ZlbFJtMDRyRnJlMVBhQ1UrTUFDTVhodWJkNEVnTVJpTUFWMk9z?=
 =?utf-8?B?QmQzcWVkQ2c0aXdQd3VQMVd5VTBRcGk0Y01QTmJSeUxlMkduZGRTdHhSM3Vq?=
 =?utf-8?B?ditXVU1hU0VyaEdIdzViM1lZNjFVbzJHVllldlFETk9GemtEVTlnemxjTVZZ?=
 =?utf-8?B?ZkRwbFB0emZ0KzBtdTlMdDdCbzJvcDdZaHduTXdjNXQ2OGxoazNxL2ZENVQ2?=
 =?utf-8?B?bTB3a2RZRFE3dlB3NmVTNElkcFd2ZHVZWEpBVksrMk9NRnNyYnlwSDF6NS9J?=
 =?utf-8?B?WU4yeW4xWkFDQmlrcEdKdDViZ1JMaURVM1ovdmhNT3lYaW9kL3VxcmpNUUlT?=
 =?utf-8?B?aDBZenA1WVVuK1d0Q0RjZkt1VS90NE9VbWxvSVc1TWtmUGNhMjBMOVd0QjBM?=
 =?utf-8?B?ci9YamlMRUwrclV2NU5mYWdnQzZVVU1sT2QxelhhdUpod0VubVFLOHZpNGxJ?=
 =?utf-8?B?UmppNEdpcWNuWk5zekw4L0xBL2d0cERSaUJZbXhpVlIwa3pBUE1UVDFYcWxp?=
 =?utf-8?B?M0NHZEV0SFF6VWlDaEdFNHhjaEtyRndsdFRsMmtscW0zQkhDMmgvZjhEZnpa?=
 =?utf-8?B?Q1pzT0kwZ3pScjAyK0xyN2Z1S01XT0M1THBwRDNaUHNzS3VBK2U1ZVJFMHBv?=
 =?utf-8?B?TTdsRWcyVWZSVzc2ZWxvOWVDczN1RTU4VldwdTRCUEJYWjZhamtramhxU3J0?=
 =?utf-8?B?UXR1Q2phemxnZE5HSG5KZG9iekRoSFE5VGpoZW51djUzejBFbmFZR3hteitq?=
 =?utf-8?B?aThiYys5cFBKY01Kckhidnp1MmVWL0VzdGNwSjJTSVk2bzZoVmRXMUIrWlRl?=
 =?utf-8?B?SkN6SURIUmsyeTkycXpYcjg0VHIzWmwwR0lzRVdCWGlkYUhOa3NNNEtucGVt?=
 =?utf-8?B?U3JlWGF4VUsrbGZIcVptQWdZL2VkNzhzMVFLM3dwQ3I2T0FtZ3hhM3FHekky?=
 =?utf-8?B?TlpHcnJiVVlKS09sMVptY1VmK3gxb3RKK3htMldDWE1oZmJuV2NRaE1QY0pU?=
 =?utf-8?B?cDBadUNqNTQvbWFrWENpOEVVMzVqTlhXZnlWOTI4VGNwYjBNV3cvc29DdWVX?=
 =?utf-8?B?Zk1wd0t1Y1piSmZaSlRKVkoxcHJVR0tzZXV5bHZTTGM5YjlTSER2TS9pQUYw?=
 =?utf-8?B?VGJWNUN1dGlmZFloZnpMTUd5SjJaMmRTWnpKd0drSi9ubW40MzRuVTJBUFJl?=
 =?utf-8?B?Qm9lL3owSE9ZMmZmUEdubWJ6TitrNDZmVmlGMHdyUkN0cGV5ZEFvUWwzdE42?=
 =?utf-8?B?ci84d1l3YUpTUzZNckErSDhuZ0xwbHp3SFJvOVBSd3N1Z1o1eFBjZjdHdTRV?=
 =?utf-8?B?aTk4VEZ0REtqQ0svYkpOeG03UlFPVVB5ZUJCUHZ3TGJHRHdiaEZBeThQMkVr?=
 =?utf-8?B?OWVCMHNOVXJuTmh5Z0EzcVk1MVJDNDhBVU1wRXh2VmVNa2NTV3dPOHBic1po?=
 =?utf-8?B?MlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eHFxn521cry3ru2So6Z5ekJJCdq7BVF+VZyAGfc0RAdYGWcoX2MbHA3nHsdJ1+NvnqAHBWvQKoVia+fucCrEv6BIwOpYbpwh31+2Pp53DsPH6e8vG4Boq8fmDNFNwde1BBqjnO5O+TS963Bj3brQ5dZyJTvFOCcobTOKclQQHqdESVSVSx1HLQfqAPBSNhZRXX2KSLNbv40fhOH4y0cuEaFARcXAapsnRgdkrRJMDEMJ9GT72CNO4FdQWAucpsIfoR+68n0T1UbP9Fw23PM1vSkZ1nf4G9uirKceNKdEXRe2PoBg05L+55P5wspBQoeR7pUXnILxZORJrDzWlY3CmsZ9ikpZLXzAKvam+lX3PGgEb4WrIFSk7ni0Rj9rFdB/c4oDuftzI87egraO8FwvKOAr4SBcjY4tWTmWqkNozjk2fb9c3/Px8dIvhxvomEzxaEC5meRDfH+8IGLEWTtj8IPfZRisgbslamZ0cFMm80w/p68xQPnQRlHOcUHDgwnJDIk/0C2xX0kMjsgYI7fHxsCHjwJO2IlmZ/x/2kDcG0gqWJxkTMB13PLJflEgspp5apvJ7miI84viBbSuJagQaKz9cefycpj4YUDh0P+Eitk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f1d361b-1e3a-4433-e03e-08dcd7f17bdd
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 14:52:14.6521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WwkPUofYw2IFeuiNZCnmhjwl1GSBgUi2jnCphKDAOwDi7n3DoMAmSnaC79NWKQrkteoVr9t68jIiH5/WwsZc3YtGY6fvzbf3ebEs7HJ+p6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6825
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-18_10,2024-09-18_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=990 bulkscore=0
 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409180096
X-Proofpoint-GUID: VMq2hrkWsRNyZruwL4SU2NuVPgasMuYQ
X-Proofpoint-ORIG-GUID: VMq2hrkWsRNyZruwL4SU2NuVPgasMuYQ

On 9/15/2024 4:59 PM, Jason Gunthorpe wrote:
> On Sat, Sep 14, 2024 at 06:05:58AM -0700, Steve Sistare wrote:
>> Avoid expanding a huge folio into multiple upages[] in pin_memfd_pages by
>> adding a page count nupages[i] for each upages[i].  Provide the function
>> batch_from_pages_num to efficiently add counted pages to a pfn_batch.
> 
> 
>> @@ -695,6 +717,7 @@ static unsigned long batch_rw(struct pfn_batch *batch, void *data,
>>   struct pfn_reader_user {
>>   	struct page **upages;
>>   	unsigned long upages_num;
>> +	u32 *nupages;
> 
> I think you'd be better to have
> 
> union {
>     struct page **upages;
>     struct folio **ufolio;
> };
> 
> Add some batch_from_folios() to do the logic
> 
> The flow would want to work the same as the pages where you fill in
> the ufolios array and then trickle it out into the batch

Sounds good, will do - steve
