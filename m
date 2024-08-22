Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925D9EC5
	for <iommu@lists.linux.dev>; Thu, 22 Aug 2024 21:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724360791; cv=fail; b=Sa62Y/EWF3R6VMYb5n/qN/p/zbCMMsIsdSdO5r7aJNjiP+gBcO5z8xuNMkTi/25XQkSZXE6rtf7W9iSJHdT1ZK9u1YiUNGM/8Cdqp+oKf+Lg2AFUIrjNxSmQvYF9uygo53pLj6ow+Ypjus3MGhL7+7GENaXAuhpRvgTA4KUtiRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724360791; c=relaxed/simple;
	bh=uAikid3S57ugwZ7u0ndw6tWPHMHuJ0aFhTrJ9elku7A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=blW52ZG9nt9+4cu3MkDd4vxo6bc3OonLRVjzOcbC3I5rvAHYnOb+hLVGSKizx4k9B4Xv+vNrxyCkmIpWAJySn4PbCPNUyVuZ7oLm41ayEA9mrBGQMc3yiAHhDUQgS8QOxGqqM61sA5CGKLEHzLdZcTcFp5MY/bbZJYC81BEHFYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=odCFzZvZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UBjKVaoM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="odCFzZvZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UBjKVaoM"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47MIMUbL021051;
	Thu, 22 Aug 2024 21:06:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=HlyRJa6OKpflcMyrTzWDdb0c4oMdtQD5DU1ixE4sOZc=; b=
	odCFzZvZbn6cHf9PPsCTqpLTnPnIVvq2bSZvBDonLLsimF9cY10FYLvNQ5mSTFmI
	QS/cTbOOku80fooSceAHI1+c6CXU01qTaxW0jkjSg+b4pL2mo95qIR2swYbjSPTg
	afeq7XzVCQFZfYYxQ3EOdsFd1oRLNj/EDpPhuzojyd3oy7Iw9U2cvDPKE+yHXLHx
	0WSw7f+LUj0CnjkjWYa2foY8hdfznKWHENQxYmGnDe9sVmDppyxZX9ZpgKHFpwFs
	qpDC3JCc2+csJL9xCtSAquH9iSnTx+2IVfd6/GrrfD5NFqhFq/ASh7NPfzrYecQD
	6JwUiyAqPy0BQAtBi7Up1w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412mdt32nu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 21:06:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47MKs1pG039322;
	Thu, 22 Aug 2024 21:06:27 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 416cs80epe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 21:06:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cyrhjJ8nDKwL+rEZi1NDS8tnpJioZZyNcqb38vZ7OfnVmCjzB/hN9ttPICLIPgQ+Gsd6cRuckvXwIeCWa8dMUsN0Oq85VRQr5E3F5k/MeE8HNK4rGDw3b0Dp7QJ37170HTjEj42YR/zCy+jKaWDv8RsIPodnZ9AlTQTGjRwoTk4t6SzVVofH1mPA9Dax3msVfv9yAfjkhu1LlWTsRUL/6BVHhSz7L6ZbmQTm/yoXt/SSn7NDbxe1q250BhQ99X5J+MchPF4Zlit0H8VRztCK8FMn1YkGrQVQHFaEDaMPw7P+xsqH0rpXhzs6LmPNLc2/bjRj9yiF9+nZT9JBA6ZwPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HlyRJa6OKpflcMyrTzWDdb0c4oMdtQD5DU1ixE4sOZc=;
 b=DClXTV451KCLLEYG6wRY/FusrPSuIjpw+0THXd0UT2FvgQMsmZHfHyu9dRly3ZQ8axnU0eRBwAfzSv6B/vxSO6hDmIp6jLsHeZYuPdSQYiWGHRXCkMFnVKDZJoaO0EHpXPNRvMAX68H/svxzH4zyIyTdYhWZKL13QGoPaHbsYAgKerPrxqtEGaIZl8+fGf7rcpkOFv6EIq4qcuv8HVbRS5tTCSGVHVVh4be69cclqL8LrIrJh+kFZAgR/9LBxvQcIkEduKctxcHf2bUc/z8+d0cDbPYwYsLbm99vHIx808Q7xDEJpg18Zrps25jaIW9TmBruegLRd4wb71FSxcQhWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlyRJa6OKpflcMyrTzWDdb0c4oMdtQD5DU1ixE4sOZc=;
 b=UBjKVaoMcrrPeDBTm1FvG9wkxpvCi3l1AgNODq3J05fqCKwN8YNhBYc/oySjwP5SeVmeLp7QkvmxROauVMMXtkp9JDw2Ixhlnra6Cta/kvubMcrolg6R5fiFGj5BLWHMbvJDI0xebG+dJoa4sPO65KHWC+rGswX2mkZr/rDgqrY=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SJ0PR10MB4478.namprd10.prod.outlook.com (2603:10b6:a03:2d4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Thu, 22 Aug
 2024 21:05:24 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7897.010; Thu, 22 Aug 2024
 21:05:24 +0000
Message-ID: <1fd5610b-998b-438a-8959-2dc7f3ed8afa@oracle.com>
Date: Thu, 22 Aug 2024 17:05:19 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 0/4] iommufd live update
To: Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Cornelia Huck <cohuck@redhat.com>
References: <1721501805-86928-1-git-send-email-steven.sistare@oracle.com>
 <20240722155500.GI3371438@nvidia.com>
 <3329e042-e4b1-40b3-9875-623f26386609@oracle.com>
 <20240806125602.GJ478300@nvidia.com>
 <54f33881-26e4-4b7f-bbdb-89f4cb207be9@oracle.com>
 <20240808195252.GE8378@nvidia.com>
 <53e7ab6b-9419-4808-b429-a88faeb3f6a7@oracle.com>
 <20240819145908.GH2032816@nvidia.com>
 <ffa07fb2-6554-40cc-8af6-e6b3a2cfacdc@oracle.com>
 <20240821180400.GM3773488@nvidia.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240821180400.GM3773488@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0241.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::6) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SJ0PR10MB4478:EE_
X-MS-Office365-Filtering-Correlation-Id: b7b37219-bcd7-4320-f381-08dcc2ee2412
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bm1zc01aSlNMazhranUxdHpIeHZxSVpIVHkvZnBIcVlLNzB5aWFic2tsTzZV?=
 =?utf-8?B?U1FYSDl0NjJHL01kRTdNbXNkR3EyTzhXeUZRNG1YZ2JkUk9pajNsdWk3V2pO?=
 =?utf-8?B?ZkM4Rm5BczJyb2xyNGF0MnRqTXNGd3FVWDladEs2WWI0Y0lRN3pxRDZqbkE3?=
 =?utf-8?B?dzMyb3BUQWtNcS8ycFEvQkQ1SVVGTzh3RTE2R2JWVTljcnNzeGJxZjVSZCtB?=
 =?utf-8?B?TnVtUkI5K0JrUHA5UjFnM1dWamIvUXVnd29jVXpIUENvUk9VeGIwd1oxb29W?=
 =?utf-8?B?bUU3cTRodkVxWURMcER5Y3RoNWhDU2tIVzVyVFN4b2tBRVdzVzBlWnl0b1N0?=
 =?utf-8?B?MHZWODhRcmZ4SmQyY25GZTZkcUd5Z1lqSXpLYlpsbTZuU3M3OG4yMEkzaTlI?=
 =?utf-8?B?eDg5cW9pSWwrbk11QmVVd2VuS2hoU1NPd1E5SjYrN1hEYmJjaW8vS0xNTFVE?=
 =?utf-8?B?RUxKUkdRb2FzWCtBYnN1QmVwSzdkeVowNFRxMDIvY3ErVGk3dkNiU3NxZzBl?=
 =?utf-8?B?REZDZ29JSUduRHRyYUl1K3pLdFUwdVpVejZLVmFkSVlqYUJlcVpqTjdtbFNs?=
 =?utf-8?B?TEZjNGdWamRDZkxIT2Nha0xjRDJQcFRNWmxIMk8zaXl2cG53RGwycXRPTlhO?=
 =?utf-8?B?MzA1M1FkVkpObGFyK2RYQmdqSU1hWTEvNHNzdDYyOHlUei8wYkNyZlZmZlds?=
 =?utf-8?B?bXd0QlB4MnZZV3lldkRpeSt1cWJDalZHVlJvR2Rnd0lkNGIrV3BaTnhtTm1o?=
 =?utf-8?B?RmdrVVRzNUlxekt2UDdJNWFNaktjNmM2bUFveGxrczl0WnRFVGo1cGRRcVZp?=
 =?utf-8?B?Q2gxaS9JSTkrbGpKb21ZNmRLalpKUjFrcEI3YjJYQzF0R05kOUw5My92VUZV?=
 =?utf-8?B?MGFlSzhkdS90NzV4c0dxcmtFQmF0TytwUW1jcm9CK210Qms1SHJxTmdFMmkv?=
 =?utf-8?B?M09Gc0ZDMm9iSjU1SnhJak9Za1JFVFNvSDA1UjNnbEx5dmZ5OHdROEdlZUJo?=
 =?utf-8?B?YVA1bVEzTUJyV0RMWDFCR2k5RXFndnNwS3JXa2Z2aHNCdFlUNWJUaVpNWlNj?=
 =?utf-8?B?RHY0dGpxQTdLZzBpRFB5WkNMVm03dTJLWEhURGY0ZTRkc3phNk12SWJIWnZ2?=
 =?utf-8?B?TTV2VUJwamo0U1RldThCQ0sva29FcUZSRVdJN0NTSnNlNVNQZzNEMXRpb1lm?=
 =?utf-8?B?SnFkOEw4eEFmUnFQandnV0NCVzNKNXdURkhld0pKanpaeWdnQ0RmbWl3V2NU?=
 =?utf-8?B?eVB0LzdncUNwU0J1bTI2amQ4ZGZ0T0VYVldXaERDMmJGQm0rMlZ0VUw1bUJ4?=
 =?utf-8?B?RU5MUHZnL0t2MG1QbHRpTEQ0ZDlwc041aGROZ3BqaW4wNUpycURvRjgxU055?=
 =?utf-8?B?ajBsUkpzSXExQVFiaUVrcUFlZnBMQUJLbk01NGxmYjNOMFV3ekhXTDBvem1V?=
 =?utf-8?B?MGEvY1hvZFZXdUM2a2pBeW14TUpBWlMvTEZESnpIWXdWdTVBWkt3cU11Nnll?=
 =?utf-8?B?dzBWWHhnY3g3ZVkweW1JZmVSTlVHOTRmc21wSjBjd2dtZ2J3U2IxUmJucnFL?=
 =?utf-8?B?dEdxMXJEVTZEWWo1bExNTVMxeHQ4Y1BRVk1OZjgrendSMTBIOGxGSVpCaDgw?=
 =?utf-8?B?enNwUy9VMEY3S3o4c29WaGZPUmhKN2NGZ2dDaXBEdExpRnY0U1NMVVdFR0gv?=
 =?utf-8?B?YnFCQ0VZVkt1eEIrQUFsV0o5OUlNc2xidXd3dFRNTnpUaTdlS2UrZ0UydW1J?=
 =?utf-8?B?d0pGYmxFQ29BdUxKQUNYNEtnTXhqYzBQK2x3SEkxWFhPcHdZVFVnemJZckJl?=
 =?utf-8?B?aFIvUFE5WEZxSnhWSFBKQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OTk0U2tDTVFvWmhFYjlteFdHU0h0bnYydWhQcG9qMTk2SXlsYnczZjlsSGNi?=
 =?utf-8?B?d0ZBZEpKUjZwaHJScEU1OUp0RWV5aTA0VG01cHY3aUNUYy9XOXhVSW1qQ21J?=
 =?utf-8?B?VWNFQTNkdEVWSFBlTGVGZjJoUVYxMS9mSmRnczR5Wk5USFNKS3FIQVhJUVg4?=
 =?utf-8?B?dzVSbTB5UE5pMUlCOXpQbmpkMENKdFByVk0ybTVMRWdIdVlnN2sxelpLNmlk?=
 =?utf-8?B?MUJBTXdrbXpwS1ZIWExvYlorN2VMa2NDWDJQRkdoZWRNWW9xZ1Z2dXZmaS91?=
 =?utf-8?B?Uzlzc2YrME5NdWpYSjVkS25OMmtuTEl1REdrcnZnWkdFcmlDeHo2bDJSTzQ0?=
 =?utf-8?B?d2NyTU5CaTdvcmxWK01mWEdWNnVWQllxOWdoYi96UFlrS0VFOTFEejhkYkNV?=
 =?utf-8?B?Rm5mWHczSU9NblRZQ1BBRHUzU0FZK3JiS1NCbDlVZVlPcTdhRDhBeEhkSWlU?=
 =?utf-8?B?YmxYOXFuQlp2ckhuSHM3ZTJvQWFmVEVRd3JxL00vaG1ReWpEYTlSNXRqT081?=
 =?utf-8?B?RzFJSktlZ0d3OVdEU1RMdFcrOHdwLzBtcVBDRkM4UmhDS0JEMzdpKy9HTWZk?=
 =?utf-8?B?NEpRbVViNFR4TERGYTZRb3dORkZlRDh3emNKQytRN1laWFJwczU1NmRtUHZt?=
 =?utf-8?B?aDI2N2QvZHMySFVQMDYrWnZrQ21JbzV1N2VGWThudVc0ckxDTFp6NXR6cE5n?=
 =?utf-8?B?MVpaWXZ0eHUyYVRoZHRJWnZ3cUtrVUU2aWE4bm9qenRaakNibU1iZGd2VnZP?=
 =?utf-8?B?WnB5bi82d1ZXOGNXR0VzZnFjZUlXQXdKQy8zeFJIb3JDRm5aZlpVcldNR1Ft?=
 =?utf-8?B?QkFNSEtBUk0zQXVkTW0yRDh0QnhDWlFjRzU4K1QyUjlZK01hQ1JSWmROWjFk?=
 =?utf-8?B?ZFJkaE5YNGcrTjBWQzNwcW0wUUI0aTk5dlNTWWo3N05GejBRQUhGTmNaMmRR?=
 =?utf-8?B?T0c4NE1MOW5QKzZjajBZOHVudGZYSXdJL3FOSHRyOHNZYzRwZDhEcTNkZ3VD?=
 =?utf-8?B?VGVjZnR3WFhnWCsxbklkdThJbkNQWGpuWUh1N01EU1Z0enZ3a0VtM3hvZUVY?=
 =?utf-8?B?VlRwMmZaT1dyd0hHWksyc3hESnJoZ3ZiTWRMM1UvRCtsdUFMb1NpQWVNMEVs?=
 =?utf-8?B?d2VUWXBPSjMxTnRuVXd2VTFnbTdsNUpEZGZLTDFIeTF1OFE1eWVKUE5wT0pq?=
 =?utf-8?B?SkdIMFdoYTAzTDcycEZyVWtkVXFhVjZYa3hwU3M4Sng2QnpkOUpham5rUFNv?=
 =?utf-8?B?M3IzME9ZOHpuQzVCRHlsaEV4Y01FNWxCeDNwUE8zRWlIMER1WVA0UGo4L2hO?=
 =?utf-8?B?ZUhpTlFid3lsTXdYcy93RkJPM0tjU2liT0pGMTNVaEtXczg3bWFXRUFKNm14?=
 =?utf-8?B?R3R5S1N3Q0pvbW1ZWTY5ZGJjbnVrOGxlQ05NQUtQd0o0OFRxdy9xMXhYaDlM?=
 =?utf-8?B?Mnk1V0RLZXpPS1V4RFdrQ0QzM3FhU0J0VXVJRmIzeXREUG5VY084UTdkam5y?=
 =?utf-8?B?UGJIMzlpalJqM2FFdTlLZ09yRHlDZSsyU0R1S1VpcU9SMkk3c2N2cllTZWxX?=
 =?utf-8?B?Z1pyR0NzYngwK2hkdFVnc3M3OURKZWFuTWhqU2FKaDkyL0NFWE1EQVlhcWtH?=
 =?utf-8?B?Q2p2blg5allBZGMwU3Q0Q3V6YnJuUUFCZ1YvU2FWWGZTM3hZSlREQWJaV1Nk?=
 =?utf-8?B?QWEzSkI2ZXpnM05LM0JVenFmaVhWekp0ang2dXpEWTZmWGVPeVR5RzAyYkhy?=
 =?utf-8?B?Zk5NWkYweFJ0azRVRkpJTzFRVEZCMk1tQi9NdUh5cTh5STNFWjdJS0pMdjBQ?=
 =?utf-8?B?Z3ZrZU1RRTJuUmRmTmswRGhNWHM3WUpmbmFkVDVsK1QwekwrSUhndU9XdUhG?=
 =?utf-8?B?Q2FGdlRKSlNrd0JOMEhPeVJ4Q1NqU2pFMGtpU2tLMHhacUNqT0l3dlJSUWs0?=
 =?utf-8?B?N05QdFlrcXB0ODM4eXNvK2lBWWJnWFFwQUx4OUxuUmZQaWFHQVBFdjZ1UmhY?=
 =?utf-8?B?Z3I4ZTNTVFhDNzlFcUpTMG5EbnYxdXV1RzBwR24xZXMxcE1nQVgrRURuM1Zq?=
 =?utf-8?B?azBuU1BHM3FlcXgxYnlpK2diNFZ2WCttajVVVXM0MGpiM3ZRQjJiV3BoQmpD?=
 =?utf-8?B?SFJyMUVGNGg1RFE1NUxaVnNJTUpyYkp4bGFUejVuUnIzRjR2amUxR3BtdjY5?=
 =?utf-8?B?bEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	C9TRQMeHVY92zMS3fTWWlVdpyiqGv1eS8jIkP4rRfuxsLgq+Q12Zsx/MUur84U6OT7FfQytHV50KtCYGq8BtmXE9pkU8vGlJ/L3sSjkQfQL+Gw5BkUhhc3T7FnjzEgAHigNUYzfZbxSFAvzdTQ/glu36GBoq7QSuESvms6/qMIwwqDNl/6UUit2XbZUSp042+xzWzd6DE/xhphQyw8L7B7zRJ0yE7EdqFaXvRNLkIU4JynJDz++RSOcFnR3wZKloMi+t1/6JBZOrWoj832Ukrr0uZq61UNYJVuBJEDFF/MUfHDF+z10qZ4jIh5Qtt9BdGOelVjZ8kuPgvUwsrGdgi7fu6QdJw4Zt3HNh8fG1hLcyzb9fiTSS5x3OgLjtvl8GY64DvgGSyyUg+wkc55DbJAn9B6A3DncI54YZToLFgDU46pkLlm1Ra+Kl22zdUO7nU7lBCh2uei7GrjbCK4MnzqQi6rsq1zxWNFa2CkC8GufFhApg/P6jI9px7hsGac3++cFgQSG0OauscHqd5surlWJnvcTbClI4sEKDv4ifDlrzEh1vClnCNrn2B4dx+XzaMA5+s0yt5W+hzMmtRrzDI88AURXEVj+GLapNHQDVRdw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b37219-bcd7-4320-f381-08dcc2ee2412
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 21:05:24.5233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3iO44r4/XkhjuW4wOyToA7Mq5Hd1+bscMa7UX4gCtBDQH09PEl1ma6lu+oA0ARVcLKI0EXlIiI0+8tpEemAZiq8qAfNSjZezoRvZMIZnors=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4478
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-22_14,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408220158
X-Proofpoint-ORIG-GUID: XI1tnH1SFMbWrDxg3RNsxH8LaOpomnkE
X-Proofpoint-GUID: XI1tnH1SFMbWrDxg3RNsxH8LaOpomnkE

On 8/21/2024 2:04 PM, Jason Gunthorpe wrote:
> On Wed, Aug 21, 2024 at 01:54:04PM -0400, Steven Sistare wrote:
> 
>> memfd_pin_folios() returns an array of folios which must be saved and
>> later passed back to unpin_folios().   That's a slight bummer, since
>> currently you save memory by retrieving PFNs from the iommu as needed,
>> rather than saving all of them explicitly (with the exception of pinned_pfns).
> 
> You wouldn't save the folios directly. The existing PFN mechanism is
> fine and already works with folios memory.
> 
> The mismatch betwen gup returning pages and memfd_pin_folios returning
> folios is fixed up by adjusting the folio refcount back to page
> granularity, then treating it the same as a bunch of pages and using
> unpin_user_pages() as normal.
> 
> gup.c already has code that can do this adjustment it would probably
> need to be exported. Something like:
> 
> folio_refs_to_pages(folio, len);
> 
> Then don't change very much in iommufd, just stuff the folio's PFNs
> into the existing reader mechanism the same as the pin_user_pages()
> flow after fixing the refcount.

Thanks, I will keep working on it.

I found a screw case -- PCI BARs.
When iommufd supports mapping them (I assume someone is working on that?),
mdev access to those mappings must work after live update.  We must be
able to translate iova to PFN without using va, by recognizing the mapping
is special and calling something special to generate the PFN, such as
the extracted guts of vfio_pci_mmap_fault.

- Steve
