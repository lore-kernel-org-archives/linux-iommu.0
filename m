Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32710DDCF
	for <iommu@lists.linux.dev>; Tue,  6 Feb 2024 18:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707244348; cv=fail; b=rfeNU+YJMOGYbNRVP32F/X4fvH8sO58bsEZLHAXubwDG5M/8ucaWjiMAg/sXoGiTZ46hUtUT1nnamo/9/90pGjQJwpgispjOQs+fPB6AiucZSXhjyCkqwVsFRWbrcvBxAFZpbo2N5ofguPOHwWsDR8dxdYXKIUHvPAHdPsS5gc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707244348; c=relaxed/simple;
	bh=UnLsug2j7Km5tjHZRUUQERbVFx6eaWcN/ouGIt88C0Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ErnqyBOLXagRlYdonAiRYgcomoX13tROHTIRagH31CeilxBYgdGYcPP3kIKaArIsNEnNvVuyX3vF6Gddpgb1xYQKCUunYl6szh037h1V/yEQniHawvp1A5I7SxMP64RE8EHRKM19p30FvZGjagr7uaOaNE7+QRmFSQLTaV261eg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YBBGzBO6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YoJNn6+U; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YBBGzBO6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YoJNn6+U"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 416IT664020051;
	Tue, 6 Feb 2024 18:32:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=+/JNcZ2GtiU9GyAqhXBiSqhkzpiPL5H+2MJQL4GHtBM=;
 b=YBBGzBO6wpr8Re+4omSS3MaCYxECFMBfJrL4cidxLPZoWD4QSrhqy/0y9Ls827nnoybL
 hHWCekBh8RCGncXYOW9HPJQ63jS/FJdKcAkFB/6WDf6PD654JA1UjVmJ23LgW3Uglpxd
 2DgQ8RubpvqFFzM8+ySh0DGiOlUkhd96ZYLjzRh4ZP1Orq2ZDkh8uEbw1tBtENR3YFXw
 jM71wdidM6pFd05OTAO2F+475aRsQ8XaYzbN0yYbR3HGsfchhCXrgNVbp3BLYpI6kxbS
 rZ3w2PoD8ll0XlQjh9mXsE3uxdW1S8g9OsWvuqq7r6o7olYvGIB1jEOfMMbg8isTXfOs dg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1bweqk72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 18:32:17 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 416HG2KT039623;
	Tue, 6 Feb 2024 18:32:16 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx7gfja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 18:32:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NvfHtqsYSY/N3PI9X4c0d/XKsxJo40BI4L5X/odInA9ZoGPrZ1gwNXWDOPs3mbgUlhU26bOuNHwZAlRpxBl7l2MQcUiXNVXAU30f7DMrKlCqhM7FBdky0W9PBg051gNIh4qF6eghZenm6pkKePQMF7s4aPaduZytrWmbqoyWV7aihqk7q8nsUn0qPOtzL9sI8swxLviFZvnSrtNHRlYaPxj+BplOTDAjscOXo6bVR35oFk2wt7l73Hjdz9pI9HzZOkE0QBtSG22dATTGor9B7WaAqKg7Dze+NZ8ufs3a1hD/IzqoVjT5WOP67zbZSd7mYUMLr5FpbdpmtKHaCqnR6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/JNcZ2GtiU9GyAqhXBiSqhkzpiPL5H+2MJQL4GHtBM=;
 b=VpFBQvbr8g/vE675ayowDIAIAmTSIi22lwYkDIIJVp73rGHuKzX2WuPgyvHXQtt7jxDxywMTGgP4xzlDBBua1QUybDYVjbpDiIRxKyFr+BnHOHuIOSK9VryE23n9SsreISbhC9Yl4/D8qIyCCdJ5oMlmDWAAQ67WrbXnbzfEx4Idgq+u4+Z7eimKGq4U3JCdfvWxn/5CqGHo3nYquHzSHqFBSPxIZIbLRJ6H/jFF4il7V80xPaAj151EqcZ864PTlyIJdGAMrMmosPDOWeOX2hLX2+Gi6JYNjhg9apWArVFsQp+CAe04EX6y0y42GuYU7ERK8sdyPF70xzAVw2KIsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/JNcZ2GtiU9GyAqhXBiSqhkzpiPL5H+2MJQL4GHtBM=;
 b=YoJNn6+U2vFPk9kit5qJG1a+/XusqdgrQrqFm1R0+j/8e2YS7wTf197qjMieAId1MYjJR2UE4DRNu3OYlAcmsAU4jGtyQFVr5uYErNvnjipzyAsBcx12QctAsyXi1M+VAFP8gTWWrxsgkcT19BPwA3yrAf0JSTbfrNXLST/m2lw=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by DS0PR10MB6272.namprd10.prod.outlook.com (2603:10b6:8:d0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 18:32:14 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::b787:9523:eb1b:4413]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::b787:9523:eb1b:4413%7]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 18:32:14 +0000
Message-ID: <91aee5f5-82ce-476a-bb53-cc65c369db2c@oracle.com>
Date: Tue, 6 Feb 2024 18:32:07 +0000
Subject: Re: [PATCH v1 0/9] iommufd/iova_bitmap: Bug fixes for IOMMU dirty
 tracking
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, Avihai Horon <avihaih@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
References: <20240202133415.23819-1-joao.m.martins@oracle.com>
 <20240206181333.GE10476@nvidia.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20240206181333.GE10476@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0008.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::18) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|DS0PR10MB6272:EE_
X-MS-Office365-Filtering-Correlation-Id: 59ffe370-71ba-406e-1293-08dc2741f03c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	e6O6VIqIcGNHkWKoY891N3IR1wzWWNPrXxL6kF2hajTuo6FGr5Z/EZ8vZd4nlHYFHaSRmgUXsJpcluHqA2tvpxE1xaldEUQYRzKz8ytU+FhqEjxuKVSh0v2qnlKlY6nTuuJ9o8CA21B0r99U1d9DE5QYbcVMgVgK3bV1+rRIIpvA7wKhuxWIuO6Hm/tF/C0jZvA58S5vavMfDxymDixXHdbASeEmtRW7j//QBzbx7SgXMV5i1MGy1wSzDs+nP6OTLy0o+hHaCc6j+uCQPD/qnT0UVyLWd6vzZ+d1byUgCDdnlPu6bHrqxryg1CLMeznEupLNx9NY020PtTZ4oLwsYM1+Wg4/i0L00pKRH1SEKbnI0rM/bfaIzxzqoFOV6gIYATUodj7qtvWQM58qj4HmB6a1wPy96zKXUvHJH21sjoc1sQ2q2QDMWpxtFii1Vl+uO5nIoWNoIsd2TnJ/OiBp+ufmVQ15CMhj/twmI2DQwXY9afo51RKKl3YeMbWzcKBk+JTzGFq3Hd5j6uqpxnQUp0UEgy0xvVXjzz/OmTbvfRjEP8Uhzl6vRJig1SJW9ykzOSTQOSaGEEzm2nWjlBtIbLW4PzwYsUkmcfaMYFByFqOQlwHJKwxB8nbYP1DOtVoG
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5893.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(366004)(39860400002)(376002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(38100700002)(53546011)(6506007)(6666004)(83380400001)(31686004)(31696002)(86362001)(26005)(66899024)(2616005)(41300700001)(316002)(4326008)(8676002)(8936002)(36756003)(6512007)(478600001)(2906002)(5660300002)(6486002)(6916009)(54906003)(66476007)(66946007)(66556008)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?S21vVUNKd1FCQWJGSUhRTnBsc1UxaGNlL3ROTFlqTmtzL2hOdEh3NWtKTHJa?=
 =?utf-8?B?ejVlWjk2QUlaSFQ5blNhdmI5OUdhTlFDNnd1NnZENm53TmRsNGlJNFZtZ1BD?=
 =?utf-8?B?TmVGd1k1cStpb0VPSFo1TXVJQkN3eGNqSklWZnErWnBsV21ZaVdSMjJOcHM3?=
 =?utf-8?B?M202ckx3K25QT0VLRGJDMGVSd082UXVWc1hTb3Z1LzFFVE5ibE50NDQ3VHhZ?=
 =?utf-8?B?NWFGa21CbSthNUFzZ0R1Uk54WWdLRmRjWFpmQm9DQlQ5TEVtS2R5RWtMa3RM?=
 =?utf-8?B?YlQ0dG5oTFA1S2JiRnR1aThsRnhoK3BVQWJDZllnYmtORXJzZUN0R1BUTzJK?=
 =?utf-8?B?cTAra1hpbGNvMXorNTVybXBNcHRqSHB6L0lLU214NXM4OTgweE1uZWo5QmEy?=
 =?utf-8?B?Z3crRCtzbXBNMVl2cUZFU1RWNktScDlPaXpyMm5sQzVDcTB2Yk5jRUdvY3E0?=
 =?utf-8?B?WEZ0SWZPTkQzbTJWV0hCb3BDakYreXpIa1AveHVZb3oyRE5RM0FIZXRzRmpU?=
 =?utf-8?B?cy9nS0pjOW1OandhMzNrMkJhWFJyK3QybGVCTERtUXdsQ3B4MlVFYTZtRE9t?=
 =?utf-8?B?emR3QytTNVZ5d0FEQWx1c2tqK3B5b05WYXpkdk1lS1BpUHI4Z3ZUcnVKRjdB?=
 =?utf-8?B?R3dEUlE5QzhqdHVmOXJuRDdKanRxQThFVTl0N2JqaVMyRTJCbWpGTmtjV3ZK?=
 =?utf-8?B?RFlLNVF6elRBaDhvamlkMTYyR1ZBMGdUUVVqdm9RbXNyZlBiSE41cmp0MHZ2?=
 =?utf-8?B?OWYrNlE2RmtqeTh1STZQSnRTcjdnd1R6d04zR0tzV2ZzNE9PV1dsVDF5Ump6?=
 =?utf-8?B?b29OWEg2YWd4MnNsOFFkR3d1R3k4WlNLUlhTcDN3QUkrWkNoSkV6clVoVW1l?=
 =?utf-8?B?NW9lSDNFT3dqU1BVeHB2UnRCT2J1M25UQUsreDZMZjdlNXF2RkJKUnpxSXBD?=
 =?utf-8?B?TjRVRVZCNW9kS3lHZU9ZRHY3SFNxNGRoUWVWVHlNQkVMQjNaUjFDdUZDcnIz?=
 =?utf-8?B?ZkZKZlRLWWZiTVY1Z0x1dndpYmNQOThkZEJsZUVIQmo1OHVGQ2ZSUkpZRTQ5?=
 =?utf-8?B?VFRES3VFSTZGdnYxdkpVbGxlUk5DVTNWZTErcWdDY0V5TkxDdkZ1VGt3UXBz?=
 =?utf-8?B?a1phbWtrZ3FQQ05PcXVmZjRzMVNRSW1vdFNuVXpPcUdrcm5qa3FqL1NFaHhM?=
 =?utf-8?B?ZEFLdFJvZGVjWjFzZzc4bjg3TENZeUhNYlcwMjN4MTRqNVV4SnBKWmpyT2xa?=
 =?utf-8?B?V2VnYUl5ZHpPUk51Qm5xTmlHOGRmLzQvRGJqbW5rTlVuekJuYTZIblJldTZz?=
 =?utf-8?B?bmlYa1Njb2srQ29odUd3QTh3b2hjQi84bVhwQzhPOFZCWkV2WFZVU2pJQWRB?=
 =?utf-8?B?NElISXgrbG1oSWlLSzNyelpsSmR6dGw0NlJxV0VqSDA1SzhJNGJTdEVZamc5?=
 =?utf-8?B?OTFjeE51d1Btb3RDRjlURWlLNkNabENIa0hPT2ZkOFBwR1lQZE5KU0F4cC9N?=
 =?utf-8?B?QnFaRUU0NGNhZG5Wd0RXcXd1NkxPdEtSL09Za3hyeFNWM3NPN0NXem1PUWhX?=
 =?utf-8?B?NVg4dnJ6L0NuRFd2QVBQZXBjOUdQazg5TDR1dGFyeDRnK21zQnNVVlZzNDFx?=
 =?utf-8?B?b2QySXNDU1BzNjBTZHRwYk8waW5tVjc1dVl2eS9uakFJMVpoOXM5VjJXWStj?=
 =?utf-8?B?WkVHdVNvN2N1RHE1MkJJb0dwR29Xemt1MjdjcDVwM05rMlYrcVNPR0kxUUtR?=
 =?utf-8?B?TjhwdFBsTjF4Tk15VjhNb1ZxWHJRZThQblNmbk91aTFrdHFVdXI0NnlGKzlH?=
 =?utf-8?B?NyszcGxLWHZBNFdCNE5FdVpoZzk5Q3ZlOXJGWURFV01KdHBlZ09pRE44Umtw?=
 =?utf-8?B?MFJXeUxkTmhZUUNSVzg5SkhYdlhVNkQ1TUtQQ2U4bjcyNkRmQjRyRmhFc3E2?=
 =?utf-8?B?dS8xNnJwWW0zc0RYUitBdUFBcHBSMjRJNkNPWGNHM2dsb05WTk5qMTQxeXJh?=
 =?utf-8?B?eXVLbjNLK2xZc25jbE1yZ0xmTUo0RTFSblNiZzhjRUp1NVhPRG5XMXZIaWRy?=
 =?utf-8?B?Qk53K09uU0dMbnU5dSttd213VmlZZjRpZXJ3ckVxc0tiRWlVcllpakJOb2Ra?=
 =?utf-8?B?QlkzTFVoTHhPS2dlWGJGVG0yaVhreVBWT0UvUnNNZ0kwUUVNaGpQSkVyMVBU?=
 =?utf-8?B?UGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ZoKRpJqXP2nHiMhBT75Wo0ao4oh+koq7mPlfyTdF6qpPzAeiUco6oiNVV6t37oAQVQo4hLPUJoSJ13pMXYuCsXiJhxmB0yZbrfd6Ez0qxNAcjFqlhckpLHuqHZTmb0i0olEZ0qs/ta5xTD3I4r+ab8FTNvKwF4n7HkGc1Z2FqyRFb0w2uSZQ+ZtN1PuKwFTxyBUfpW5yX1+bQD8PLAeVUXu4bdDCTxwhIdtfsYsIerR6FLJAdY3JPzRijzG/Dz22x5EZxi/m0UFqQboM0ipqbXmzR+2VWxS+WZM1r7uMee20eqwILTCaW9JkWqt2YHQYVWoeh7tJDd0McZLiDdOP5p04Igx/tHqmyHjtnNuvy1FZTw9ZJuU7i7rCu/JAcApyYuMvmrjvKEf6JpXh6cfR1rjcL7KadQy1HuWgJLS3H8IZ9XeaEINrrihcKHXS+dzApN6oCwh2gTSwLuaL2D1qHEULg9vTRdVRVrUJ4jCqo/uI5fXIctHort2DkUcycovwYfdV9Nc9qbx+iShLJD05vP0Z2Uc9GWB4wmebDDKX46Ze6XMtab0flTwTUAiKR+xDoZMIbx26mxAtI8FZWqwyxcRnE9Mg2jCc4YJCRljReQw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ffe370-71ba-406e-1293-08dc2741f03c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 18:32:13.9623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5WOZ2KuR1jOdlOj7hFu8OWUR3iW4H00owr+skwXl2PtsvYWgGCTLmR5Unb1qi+xcSASlNfkhEqs0tf/626nbBijVtYA2Y0XcAwnrl5cIV+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6272
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_11,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 adultscore=0 mlxlogscore=445 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402060128
X-Proofpoint-ORIG-GUID: cZxkyDOvoMlOwFzFBhodsNd7QVPRS3xn
X-Proofpoint-GUID: cZxkyDOvoMlOwFzFBhodsNd7QVPRS3xn

On 06/02/2024 18:13, Jason Gunthorpe wrote:
> On Fri, Feb 02, 2024 at 01:34:06PM +0000, Joao Martins wrote:
> 
>> I have a separate set of changes, that proved also instrumental in
>> reproducing some of these corner cases in a more predictable manner but
>> with IOMMU drivers instead, rather than IOMMUFD mock IOMMU driver...
>> without relying on VF specific behaviour. Though, it relies on being
>> able to map IOVAs as dirty. This is not included in this series, as I
>> am not sure yet if such direction would make sense (outside of testing).
>> Comments, appreciated.
> 
> I would love to have a test suite that could drive real HW. I think
> that would make a big improvement to iommu driver quality.
>  

Ideally we would merge the selftests to use real hw domain rather than mock
domain, and skip what's not supported when hardware lacks. Specially as we add
more and more features (IOPF, DPT, nesting) and underlying testing, it seems the
most natural point of consolidation.

Dirty tracking is a little strange because one needs some sort of block/packet
I/O done to hit the path of having something allocated, which usually requires
some driver operating to mark things dirty plus page allocator luck in picking
the right pages. So the straightforward way to manipulate all this without any
of this complexity on real hardware is this is to "map as dirty" and check if
something is missing. It proved useful in these bugs as I couldn't reproduce
this by just using the thing (even sharing the same test as Avihai). In any
case, the gotcha is consuming a new perm bit.

>> The selftests in this series (a large majority of the series changes)
>> are meant to be kept in this order to be more clear in history that the
>> selftests exercise a given fix added earlier in the series.
>> The last patch is an efficiency improvement, but can act as workaround if
>> the IOVA ranges are smaller than 64G, which is why it is placed last.
>>
>> [I think this should be targetted for -rc rather than -next]
> 
> OK, I took it for -rc
> 
> It is bit unfortunate that the number of huge pages needed to run the
> test has increased but it seems necessary to reach all of those
> corners...
> 

One thing that I have here as TODO is to make sure we check if the necessary
amount of hugepages is set and instead of 'scarying' the user with 'test failed'
we SKIP("...") with some reporting of how many are missing for the test.
