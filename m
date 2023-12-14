Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3303A5D48F
	for <iommu@lists.linux.dev>; Thu, 14 Dec 2023 16:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ydszxi2j";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JTVy+haE"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BEA03MO023734;
	Thu, 14 Dec 2023 16:29:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=I1Zdp9OsNvEpJbwBtZqptNhhEj+rRTnPB17pPMJAvTE=;
 b=Ydszxi2jOKo7K7k8pVCqjocZlEzKeTZ3ySB9T1S8nydlBr1I8kzywBdj69f4oRHzUA+1
 RmdzXGXdPJzxEAw/0k9dhmAGFinrg81G/18TJiWTPkg4PNcxS4R86T5ZIY3ONy0Jg4Xe
 Pj2SyLI4bcp+ZgvVDWF8njNKngKjVS2bMqlnXZwayt31koVIfhqaTH9i0lBetJtD8po/
 JGSQJXMhGYVKGrsdM1T47HkbAdE83lmdoEUH0+gNxxK8o+BhCtEMayU3dEX0avevG37+
 FBf4yAN3WzJdCk/aMI0A6NPCwhaq5ph/OG+uAJ1X94a1pbI6xbZmlUShiWaMRmUIeOfO oQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvgsukaj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Dec 2023 16:29:25 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BEGR7jP009766;
	Thu, 14 Dec 2023 16:29:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvepacpce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Dec 2023 16:29:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbS7BJkJLt5RY4venPPRiKrkMo9vUNpgjZo38WZfwzstmbN7JmXTRbiCK8DY+w0hFqsJHWfYvySwXUU5+dNCYhSmzDJOp5TZCTf5kEOzFMmyt251sLOtZOEnGgpvYLH7/s9E8zz6Rw9rCkS9PDetR/UoKNJvOi/M62ZNSaBfZfn0/JO53D+ZNJ4IimsqznznMMdThP7ZN5lhrgmgeQMCcD9jPoLgvIdqH0xEUMdAiOEgNhhfrjE7JHSct7X9KGx17DP5/cVdV+KEsBWzoXl95jwAKf8kwoHIVfgFgl80n027mEQJapvQfUeytuoMHkB9obdS/3yWm6DgSFOcsVlf8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1Zdp9OsNvEpJbwBtZqptNhhEj+rRTnPB17pPMJAvTE=;
 b=JGGw1cGAXaDN85De3rDIgpwYGW/Wa5g5qQrpYMx5vJWEur4GLjrQTvo5DcnED8ODUIBd0e03URaG7dkz4UYorH+FleRepOVu5D7WU6viWq5Vyf0jyiRMT+FHqwLm58EfkuCjc8TOG0EdJ+Ep04Wg6k/CJL7cN+4wlP4VKhVZD8G7QnJZRJ9IU24vvVArAhrkYspta4HDfOqxlYos14oLI/a5RglIhpzs4fS1lkHNJy4lXU+F5NpmI64GfI3eBXhQjih6KuE8lGc1ctCpqr+rkQuGVByTEJb1DyxmX1/ZLmhRinDYzrZUFwgEpDQhtLqtc+HPtOm2x/z4FodLBuOjCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1Zdp9OsNvEpJbwBtZqptNhhEj+rRTnPB17pPMJAvTE=;
 b=JTVy+haEpWjnTjUBk9l7qhbzAgCuSH2S/JqfReRMsg4KDUOpOKOJVqNIhQsrEJXtRoz9fxMiXhdgp4nRx8D+FszSKD8RIMjaTaimAcoOvFqZsSUaXSK3gQedc+i0TUPZkLQmCrS5h/QuIrgBG1pxAZjqrvNBhOzSvn/SASRB68M=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by PH0PR10MB7078.namprd10.prod.outlook.com (2603:10b6:510:288::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.38; Thu, 14 Dec
 2023 16:29:10 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::cd3c:99d7:861d:dd19]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::cd3c:99d7:861d:dd19%5]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 16:29:10 +0000
Message-ID: <b2911a1a-9dc1-477c-b003-cb078563f08e@oracle.com>
Date: Thu, 14 Dec 2023 16:29:03 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] iommu/arm-smmu-v3: Enforce dirty tracking in domain
 attach/alloc
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, jgg@nvidia.com,
        kevin.tian@intel.com, nicolinc@nvidia.com, mshavit@google.com,
        eric.auger@redhat.com, jiangkunkun@huawei.com, zhukeqian1@huawei.com,
        linuxarm@huawei.com, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org
References: <20231128094940.1344-1-shameerali.kolothum.thodi@huawei.com>
 <20231128094940.1344-6-shameerali.kolothum.thodi@huawei.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20231128094940.1344-6-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0149.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::10) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|PH0PR10MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: 308abf05-897b-42e5-f32c-08dbfcc1cd1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	IT3n3D28a0EgoEtvzNoY9Th3UfgsbRg8E1ECfjRfyS+VWq4LFig1SM0sGpXvrKwJ2+ZgW5mThMmDb7kEg0Cv1iFLnH9yMTO/A5Q76rvRWRsmf2dUsJet7K7Dn2jbf7HwKh9Rmw35eBMFV03GI2JHmjZ+Fi7iOruFFQsoPOYVsb+2hFW6YKSoTrx2TReukdSPxG8sRVjTfieV0NhbpRnKGRAOWaaUY5XEdxH39Mg5a6vuyG0P9/ic7dQRHcIoYw06RoDA9BwO18xB+D9nmS6+C5BRzpH0KTglqqaiM6fgAlp9e8dNgK0Inm1dJ3Hjlr8vFgQnWCmqX6RixjwgjpGhKU3XLJR1cto9Ah6thRjhYfFVKRUVGx75RSn5f2770IgXJAvxUw6sA154ajgXmgGV/gk7bv99SXI0j4zryk4sb+zXBf6nbesXeFx+3leJvdv6oInzi8XJ/9Ei+oe8RLc1gQ03EIdNsjdmLq5S5dSoAQbJwVVLzBSy+GtVKBrYtraPlr6H894R7EjWyL+v309UO8HiBLp2cn6o9gYr6jXYiOwiwGq2oSS8miZ584LhzoMp8Jt7s3/5gVqh0PGyp8k1XiopUlIQATkOH48+yhrVrXWUVCrqvwyxTEInF8zNTQKZ5qzRhfQSNL68kBnPNddNzOSosaucUf7o5N73VwfsEZA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5893.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(4326008)(8936002)(8676002)(38100700002)(36756003)(5660300002)(7416002)(2906002)(6486002)(478600001)(2616005)(26005)(6506007)(53546011)(31696002)(6666004)(6512007)(41300700001)(31686004)(6916009)(86362001)(83380400001)(316002)(66476007)(66556008)(66946007)(14143004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bFZ1RFM2QkZYTWJQYlFPMk80aVpZcjMxNkpWWEJlWWhseFpLcHRhaTdEc0Yy?=
 =?utf-8?B?OHEwVzNSMWd6eEIvNVE3R1dsWm9OczdHcXd4UGF3dHcwYU9vREd4K1d0clhT?=
 =?utf-8?B?WFJ0ZjRBZHl3WWhTaFBraVZSWk9TV0ZaRjZNNXJGUHduQ2ZydjVUdFFITm9K?=
 =?utf-8?B?MEpRejdSQ2hRcjZ0WWR5NDhxZFcrVVJVcUFZTnprMWZZZUdLWUhTSFI3S2l0?=
 =?utf-8?B?Z3hodU12OE1tZndZeng4T3hGMzd1eGVsVDRHVnVRZlhzL2dDaTdCVnVxWkFG?=
 =?utf-8?B?b1VsaGZScVdQY2pLU1JyZ1FML0pzSHFxVlk1aXc4d1dyYjNwNmtoYlBYK3oy?=
 =?utf-8?B?L2N6ZzViTlRCN0RVeEZRNytFM2p6N2F3SVpJMVY4NFQ4eG4zc0ZvaDh6OXFm?=
 =?utf-8?B?VlNpaUJEVFNrTEpBYnZ2eUxXMHVXR055TkZIY0hnV040eldkR3ZWWXJML2V0?=
 =?utf-8?B?MWRwZDgwUW5QVWpwS2V4L3ZnR0NDSWpHODhKS2RrN1g4YS9SNHBSL3c3N2NF?=
 =?utf-8?B?c3g5WkhRV29EVDc0NlhsYWVpemRSckI5MU9RK3ZoUEoyUUVqSkdKWnhycHVp?=
 =?utf-8?B?c3JlYndlUDhsdWhVcmJkSHpwbC8rNS9UUmNZcTdVNXJzVzJZZ2dTd29rUkYz?=
 =?utf-8?B?MnJTSjFuQ3dqMklhQWYzd2Z1NE1iQWpPZHBRL05IeG43VU41bU14SUVyTTdP?=
 =?utf-8?B?aE8yc2N5c0ZsRUdXNmJMRUt2SWNpMXF0SlF1V0pqbHlsYW9pTHVtMW85UmRn?=
 =?utf-8?B?RTZrN3RYNnpKUWZVZ0J5T3JLVUY1Q1BzQjE2Rnh4dGRNOHA1OUpvbVgyVGVR?=
 =?utf-8?B?OEpvR2VCQWVpVk1BR1Y0K3VsVGxOT1oxQW43WG1wRVFBVGt0YjlsanZ0NmYy?=
 =?utf-8?B?TUczd1dhZ3pYY2owTTdVVWtrR0lPRnJBNXBnYk9teEdqNm91cUJOeVVmcjlP?=
 =?utf-8?B?emJlYVBpV2xROGtpWkdnUkkvbEcrOURjeHJUeHlzY1JoRlcxd1JOelFGUHkv?=
 =?utf-8?B?Wkp4c3VkVThQcEc1aGVYbWJBaXdCaEFBQVkyRHRBVnpDcTRSeStsYTFBaXpr?=
 =?utf-8?B?bi9wT1NPbCtLejV0QnlKMklsM2RFck5nZjJ0Qk5aWXhDSVQ2V3NKYUVtcjQx?=
 =?utf-8?B?cjlEQjMzRXFuSVV6V1d6eUVNTzM2dHRaK0ZlQU1ISE9ReE5HcGM4M0puY0NI?=
 =?utf-8?B?dDBSQzRkMGlHendERTBDWGJoRHl1enNrc0R4RVZjbjNXUU5DOXh6UmRER2Jw?=
 =?utf-8?B?c2dGR0NwWkV6TCsraUE1UUFDTWJGdUJjQXhyTkhsTW5aNmhBV1dzWEZJM1or?=
 =?utf-8?B?SGxFRm90SXlvemhwOEVkd1VPT1JjZmZVdzkyVlVvSFJGeVFKUmlJZjRUdFZG?=
 =?utf-8?B?Uk9EZlhhSFZNWlNBdHNKeFF5cGh4aGJLVUdwTGZKR3BuaE5COTdMaWw0dmU5?=
 =?utf-8?B?Mm1hWitmSElRZittRFhYcU1FVWdYbUtXNDFndkVyaVgySjZFQVBWdUxNMTV1?=
 =?utf-8?B?MGdVenhmY1pRT2hId3pWR1g1TEdGUWJxNEcydzRicUdGV1Z0bFcwaTVudmw1?=
 =?utf-8?B?ZFZVeUxkRTNpVVRiUE9vayttdTN5TDJDZFVBdHZVR1BybktiTGd1cWtBY29Q?=
 =?utf-8?B?enVqMjBxZEVicFNNUElQbHN4bkIyZkdtWFRwQ3YvYTVqbkZrVWlOTXpHUFBW?=
 =?utf-8?B?RDJKa2VEbStrTlZlUGh2cndROXJXbTV1RGo3ek4wdUxweTJ6NDVMSDdVNlpN?=
 =?utf-8?B?Q3BDSGpQMTZsdkFLNjJTZVZsUTBCSG9GSmNORnNOQXhWdDk3cC9yR29IK092?=
 =?utf-8?B?UDlnc1ZjQVM0TDBSSENVMEdWRDR3RGVnZkcxdjdkT0dyeE1ydnN5c2IzSTA2?=
 =?utf-8?B?c05tbWdsRTZlTHBFODB6cGd1dmZMbW5IWEFOVkJDdkg1WHAxcHgrZmNBcTQz?=
 =?utf-8?B?OXJaSnZYT3g2TVRKU05yc2ZvZU5tZTYxanJIaFVHTytoWnFsNXlISHB5eVlw?=
 =?utf-8?B?clRMU0V2aUFvSVlVckhjSjl0NnB5elF2Uk9IaG1qd2lQcFFNU2ZWMmgyNUFK?=
 =?utf-8?B?Mm55a0ZwNlZNZzc0dlhiS3hCMFRpMkNBWlFkdmQ1aVFuTkd2SUpsZTN4TFV5?=
 =?utf-8?B?R00yQTJCWTVESnpMMGpMMmxZd3hrSTBnOEh1ZEQwTmxIU1k0SkxEaStoNkk2?=
 =?utf-8?B?Unc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?ZHZYQmpwaFM3M0htTzB2RUxFSmQyamwzaDg4S0dZck5OdjBvbnpTWUNpRVIx?=
 =?utf-8?B?YnNBTmtJSFk3NWFpMHEwRDQyT0dQNEFqYXYrNlBabVlEeFhKNTFTY0dqRGFx?=
 =?utf-8?B?Z3NML29JQUtZMzhkTWpvYlNENFlodW53V3JKcU1SUWN2MVNvQWRNYUtYbDJ3?=
 =?utf-8?B?cnZic0xtWnR6M0ZaSk9za3NyWkUxQnRubUxMSFNkc0s5anBxeFFKRk5Zcllv?=
 =?utf-8?B?Q0p0MEJ2dmdJT0hCbERZQnVPMjM4alIrSEZvVDAyenJ1b25OYmNwdHV0eEdO?=
 =?utf-8?B?ZEozV3NkTER1cFM0dFM4ODdHUkwwWmhicUtvcDQrT2QzeHNkcFhneUZUZHNH?=
 =?utf-8?B?Z0pOS0wydkE0ZU1EcjFGamxiVW1ZNnFoVnNOdENRNGxOb3FyL0lDRCsxSklm?=
 =?utf-8?B?c3Q1cjkvU0cxRnFHVk1vT2IxNDk3V0lSbzEreGVJTFN5cW8vTW8ya3NhbVdJ?=
 =?utf-8?B?K1V1ZUJDQ0hKWmJ4d25vdzY1MXRwaTNydG9LcjFxR1RzU1ByTkd6QStyMlZE?=
 =?utf-8?B?STRKTmRvU3kvZ3lhcDFYaVFlUGpkY3U3WnIxVGZVZi9xMWNDR2o0MnM1cXV5?=
 =?utf-8?B?aHpXZ1ExcWl2aWt5aVZVQ1V0SUQwSnBDMzc1VlQ5UHRIRCtUS0RsTzNacjl3?=
 =?utf-8?B?QW9XRG9NSUtTenMyaEJCbU9DeFI2NkV6UXQyemJjdGlMaDBPUlRKNjlBQXdZ?=
 =?utf-8?B?TkFjSGl0Y2RNeWt6MFRub2dXb2g0ZTRtSzhCUmY2bFphemVuK0J3cm5hbzBv?=
 =?utf-8?B?R2YvcFJDNi93TnhkYmZveUZpSjlpcHYyOGcwc1hCdk5lNEZTNk5PVWJnL29L?=
 =?utf-8?B?UnJhaS9FUGI5ODRsdk5kRys2Z0VhWDVKaDZrUW8vcisrRHBjKy9SaVVKaXVS?=
 =?utf-8?B?N1QxOW5lS1loZmpSK1M0SjVlZzVZOVhEbG91ZThidzJwUGVQVXByS21XL0tF?=
 =?utf-8?B?blJnRXEvQ2N0MUZVTGF4NHBNZlVkTDBWRUxGNXpqdEQ5aTF4Z1RMZVZGS0lQ?=
 =?utf-8?B?cTdKT1Yrbng1STRyOTMzVnBGZ1lVQy9SRHBlaWI1eGVyT0lUajkraGFDcGY3?=
 =?utf-8?B?WjM3WGFvd0VkeVp6eHhES0dKaWIvVWJINnFBVGJBVkdiR1VPT210RitsWkFX?=
 =?utf-8?B?TlRGcWhkMEE3ZjRFZE9WdTI0RlRxNFFkN3BzeFhsRTZSUW9LVkFFTmFOL2wz?=
 =?utf-8?B?SkZIUWNDR2IvMEx2U2pwclFVU2w5MDNSYmF1THBtN21MMDl5QWM2eGZRekhL?=
 =?utf-8?B?OHNSYlk1eUswSzhlWlV1NHFIZEVLUnJRYXUySzQ0aEUvZGRJUTZaa1pmVytx?=
 =?utf-8?B?V2ZmdFJUV20rR0EzU0JHT2ZUY21jaFczN3dzSm5ZN09EK2RjdnZyeGthSCt5?=
 =?utf-8?Q?/uctgFoIIPAf2HYf1Jg6XjNeDbCsGeH8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 308abf05-897b-42e5-f32c-08dbfcc1cd1b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 16:29:10.5884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YXSMV06m3h6jcqEZrlolpVWEthE1lhuhgFhyrLwBRMBrNRN9zJrPHB0CmEa4BjOnbMHc7Jbh9ZNovvtooW/3eMF/xW0w+AZys5oOnKd/JzA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7078
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-14_11,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312140117
X-Proofpoint-ORIG-GUID: 1Bp2BaLKBVwElRSAAp_WUSJaiDeLqEsX
X-Proofpoint-GUID: 1Bp2BaLKBVwElRSAAp_WUSJaiDeLqEsX

On 28/11/2023 09:49, Shameer Kolothum wrote:
> From: Joao Martins <joao.m.martins@oracle.com>
> 
> SMMUv3 implements all requirements of revoking device
> attachment if smmu does not support dirty tracking.
> 
> Finally handle the IOMMU_CAP_DIRTY in iommu_capable for
> IOMMUFD_DEVICE_GET_HW_INFO.
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 22 ++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index c5eabdc29ba5..2c100f2136bc 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2244,6 +2244,8 @@ static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
>  	case IOMMU_CAP_NOEXEC:
>  	case IOMMU_CAP_DEFERRED_FLUSH:
>  		return true;
> +	case IOMMU_CAP_DIRTY_TRACKING:
> +		return arm_smmu_dbm_capable(master->smmu);
>  	default:
>  		return false;
>  	}
> @@ -2701,6 +2703,9 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  	master = dev_iommu_priv_get(dev);
>  	smmu = master->smmu;
>  
> +	if (domain->dirty_ops && !arm_smmu_dbm_capable(smmu))
> +		return -EINVAL;
> +
>  	mutex_lock(&smmu_domain->init_mutex);
>  
>  	if (!smmu_domain->smmu) {
> @@ -3077,7 +3082,9 @@ arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
>  			   const struct iommu_user_data *user_data)
>  {
>  	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> -	const u32 paging_flags = IOMMU_HWPT_ALLOC_NEST_PARENT;
> +	const u32 paging_flags = IOMMU_HWPT_ALLOC_NEST_PARENT |
> +				 IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
> +	bool enforce_dirty = flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>  	struct arm_smmu_domain *smmu_domain;
>  	int ret;
>  
> @@ -3090,6 +3097,10 @@ arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
>  	if (user_data)
>  		return ERR_PTR(-EINVAL);
>  
> +	if (enforce_dirty &&
> +	    !device_iommu_capable(dev, IOMMU_CAP_DIRTY_TRACKING))
> +		return ERR_PTR(-EOPNOTSUPP);
> +
>  	smmu_domain = arm_smmu_domain_alloc();
>  	if (!smmu_domain)
>  		return ERR_PTR(-ENOMEM);
> @@ -3104,6 +3115,9 @@ arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
>  
>  	smmu_domain->domain.type = IOMMU_DOMAIN_UNMANAGED;
>  	smmu_domain->domain.ops = arm_smmu_ops.default_domain_ops;
> +	if (enforce_dirty)
> +		smmu_domain->domain.dirty_ops = &arm_smmu_dirty_ops;
> +
>  	ret = arm_smmu_domain_finalise(smmu_domain, master->smmu);
>  	if (ret)
>  		goto err_free;

Perhaps it would be better to limit the blast radius of the always-on mode, to
just enable it in the context descriptor depending on passing the
HWPT_ALLOC_DIRTY_TRACKING flag instead of enabling for everybody.
Something like this in arm_smmu_domain_finalise():

	if (arm_smmu_dbm_capable(smmu) && smmu_domain->domain.dirty_ops &&
	    smmu_domain->stage == ARM_SMMU_DOMAIN_S1)
		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_ARM_HD;


For bisectability perhaps the second patch of this series should be the last,
while bringing the implementation of arm_smmu_dbm_capable() to this patch.
