Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7168BC433EF
	for <iommu@archiver.kernel.org>; Fri, 29 Apr 2022 12:06:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E50F960D5A;
	Fri, 29 Apr 2022 12:06:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nU0zSWf9sjaS; Fri, 29 Apr 2022 12:06:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A5DB660782;
	Fri, 29 Apr 2022 12:06:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 588A7C0032;
	Fri, 29 Apr 2022 12:06:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4CA18C002D
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 12:06:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 331E9813A0
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 12:06:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="EgE80jru";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="n68OzvMZ"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wxOi-Xzu2HtN for <iommu@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 12:06:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5B0C581367
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 12:06:48 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23T9v5DJ003699;
 Fri, 29 Apr 2022 12:06:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=2+CrKOxYCWptp21/HglhzBIYkx0ssKAf4W+v63ALOs8=;
 b=EgE80jrulARp4R3WwM8eX4+xnM3dykxHIm8LMsAtsktd5/8LwHUmUXIWmUWX6GSu06fP
 mV/ENE/ZSgWHmiofwexjAUxKBscSuTXyKyMgG6aeEOw3HOXGqx4YO4maAMUXrVUfKybO
 kw+vpgtMTREenb2ReBeiM1JLlcFS3H1BW5l4h3Kqs++AoUWJJU0eG0xg6yYND5M5U74u
 aXL7BT/AkK1fKUogdP3wtdCGsm5SG+SUXmgFXyJ59M4sbd7BtO50Ou+0TDPiWT1gIRI8
 FyP9Nr2SlQYm7aaZDuI0vbpIlSe2TNncQJElOsJiGwCQVuje1U0SkOwd2kpOt/nDrIYX ww== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmbb4x3tu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 29 Apr 2022 12:06:18 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 23TC0FPY016028; Fri, 29 Apr 2022 12:06:17 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id
 3fm7w7xpmh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 29 Apr 2022 12:06:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzrd51bg1jK0O6yCmQ+wzqHNrucZEY573FVa8G6xCEHAMtw5EMvv07Zq/p10LhbsKNM0I5fLeG2puIHSxENal8TjIAdpZiGEpA4pK7NyBMvu7oK+B0uH+Uxnuiu1k+n6GrRWdIIuC+pTyWC91XapS/ZwR0VHZDTt7CPQNe5GbmrtEZZerjIhOJt2IcULrHA28W9RNmzCUGa+e4hGzMHLjzUpdVH9unRZIWVU3pElf9m+T+bJsCN/pW4h6Qo1a7DrrFYwQ+jWhLTTc+KsQd0tIwgxdIMP52XD9inqmdh/37ZF8qSN3vNVrqB90a9hShJgDIGAGn2FmjnqatUuF45kvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+CrKOxYCWptp21/HglhzBIYkx0ssKAf4W+v63ALOs8=;
 b=R+nb2Ve4VX0ribGA0+cc5KFLOaleQ77sWmfetv8h0LXiYWKWs8uyenOMwp4bgXPxO5YopxHf2ldw5yUa5RO7raAuec5hzy0xutgjfufvruO/DhBNRTLwqAK76xVJwYf6JUCW0OzRduqOlmZvGonQDaUBhj5Di5GfyF0kpM2hzLrc3jgpt3C86EmfrezxPtNkch/3n6BTnMdemExenoPHIoHFgn8huyFQrtrUaMAMTdxoXAnZm/xHqf6V+AL12QGamlE4iejV+/kVZJ+nVU++ixF+ssBIcpO4v0/KCPHu05w9m/ZcM0Js+2I1zNV1C/etm+u1i9Qkmk1KrbdXa979qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+CrKOxYCWptp21/HglhzBIYkx0ssKAf4W+v63ALOs8=;
 b=n68OzvMZZWPk92IgqaNV0MbzUEd9EkIfv0p25s2y5Khg/h0ToVr+LYubdvqnDtulPc/EOXu+fc5ikQN9J5Q6i7HIDNukLyLoH6L5U3Pza9ghEAGFYeFwycis2TXuy/fHgBXzPcgWLmPa7agCWqBCUGCguMq7tRaCwUozb8Vqybg=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by DM5PR10MB1756.namprd10.prod.outlook.com (2603:10b6:4:7::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.15; Fri, 29 Apr 2022 12:06:15 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::b9e5:d1b6:b4be:f9d]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::b9e5:d1b6:b4be:f9d%5]) with mapi id 15.20.5206.013; Fri, 29 Apr 2022
 12:06:14 +0000
Message-ID: <e1c92dad-c672-51c6-5acc-1a50218347ff@oracle.com>
Date: Fri, 29 Apr 2022 13:06:06 +0100
Subject: Re: [PATCH RFC 15/19] iommu/arm-smmu-v3: Add
 set_dirty_tracking_range() support
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, "Tian, Kevin" <kevin.tian@intel.com>
References: <20220428210933.3583-1-joao.m.martins@oracle.com>
 <20220428210933.3583-16-joao.m.martins@oracle.com>
 <BN9PR11MB5276AEDA199F2BC7F13035B98CFC9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <f37924f3-ee44-4579-e4e2-251bb0557bfc@oracle.com>
 <a0331f20-9cf4-708e-a30d-6198dadd1b23@arm.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <a0331f20-9cf4-708e-a30d-6198dadd1b23@arm.com>
X-ClientProxiedBy: AM0PR01CA0165.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::34) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3c495c1-53df-4b9b-4907-08da29d8a8b3
X-MS-TrafficTypeDiagnostic: DM5PR10MB1756:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB1756AA96BFCB0200451AFBBDBBFC9@DM5PR10MB1756.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: emDQ7/hB+O5H5AFTdNEwpBJV34KHDdsgVQm2Btq7xX8hEGiJvJDFXIrfr7ihkNilh/JOWlmla6FESacjaYMzeFe301ENoHyQSZk3vnCsmCzCL9c0b5hlg0B3/qsqMW4HyTN/WBXpkcvmuQzLtAkrip56OXkvZXt1F8Oul/cDnDhqgl6BSUwoz4YjQF9Wag3oyWbXGqRcHUztcUByjZF3AGArtUo/8LUCpt1YefA1sCHwWZFRu5ZzATWRmWtHk90U26bqPAMLLFcc0l73TvkS7A8YbxgcOOYgTYCGQNPxDEi6dJZ3lr1YhUIRr4phcM6OEs8LC0ipVaK8Jvfwb8dTXDEJdzrC4Qv4TGHHHgIDwDYAcUMB+pwUMe2/NWOk8hT1eD7rrAiB4GlWCmPsqa/uMV+n/EdADK/uJoqIuSFTHUTwVHEUvoSKHMn11SPc/mE9jSiczDl2qTWUEyvBmNqbbVtIq30uMXbnyuhVjJcdfqqtnhyidItw3Jy5MEtxxC4hcRJJ76XI3ptS1wqpYSxIysn4I3AR5IHfqwxfX1HgzlsVTWtAkRthk8WbTQGG/FtWs50HKjJCGo3Oh75jqUK1w7E0hWKECEdr4dspw2Jg743ATqpGZEpRVuq38wmtCCDiMJq8lOJvMHViSddmdTZU6Cx2LyQzjVE2+aDsSsTohIAnwdTS6nNaYbXMnze/OY5KRQqP5dfhSYMlo2k8y+nvXU+M68sGF2PTsH6GvI2gDu4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(26005)(4326008)(86362001)(6512007)(6506007)(6666004)(36756003)(66556008)(66476007)(66946007)(316002)(2616005)(54906003)(31686004)(110136005)(186003)(508600001)(7416002)(8936002)(8676002)(6486002)(2906002)(83380400001)(53546011)(31696002)(5660300002)(38100700002)(14143004)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGI0ckRiYi9wWVVPWGN6SDdPRnN0TllxR1BEZVR2UTU0M1lUcEl4ajE0OEdB?=
 =?utf-8?B?aDVGaEFVQnJUaUluMlI1VDJuN3VlY3F3cDdZbktUb0Z5cG9YMmhEWW0ramlQ?=
 =?utf-8?B?V3QzczduNXBDOGN2OXNXM0FJNG9VOVdIZjcrb1lMbm9NVE5LM3dLUEg4Vk1U?=
 =?utf-8?B?ZXhTdURPKzR6SmFXdlRpdm9mS3lDeUdHWCszZkR2aFBQZTZ2emZIeUVGOE5h?=
 =?utf-8?B?UW9hUGRTR2VGUWk2MFZwLzlSSHlGeVNmU0dBY3BacmNsaUx3enEySkhOZHQr?=
 =?utf-8?B?dUlETlRqalBDblRGdFVRMUE0S3lFSTdvc0Rvc0t1ZW1BRUtkeWZFWlJhWU83?=
 =?utf-8?B?eWVMUjhHYkdNcUIyalhXbmo2cXAxNHV0NmF3eFpxTWRGRXN5bkF0bUtRMVZa?=
 =?utf-8?B?b2R2SXZORmJGQ2NCRjdSS2lWbGVRWVA1eUMwTFg3c2J1WHV5aW1GSXFDazN3?=
 =?utf-8?B?QnZwODliRm9UdytaUFJTR0VlTHMzZ3duMVhaSzZSSHlacm03Tkd3S2FZWnUx?=
 =?utf-8?B?S1oxZ0tOL0dibWl6WEROVGlvelhVYmFYekRFTVkvSEpvT2wydEhRdGFsUlZx?=
 =?utf-8?B?Uk81cTNMam5yTm1kTEY5YUwzbEYvUmMyUSswL1g1UHk3dmk3R205TnhsaUgv?=
 =?utf-8?B?R2FHNFE0NzFTYUVrOHZ2Z2ZoUmdIL0ZPUnZFYWx1Z0lMUVFib2M2Y3ByWndu?=
 =?utf-8?B?ZVZrQzFuMVZxL2NjdHk2SEh0WCtpZTdhMFo2M0pDV2t6Uzk4TFhiaW9qRmI2?=
 =?utf-8?B?RUxnUm94K0xkS1B3VjBaa0hJNFUwRGZ0YldaN2RvN1NmbjM0K2F2QytuOTBX?=
 =?utf-8?B?eHluRWVhMGpaa0hiZ2tnKzkrdFpKMUVlMzlleWczeEx5dnZYVlZlWDVtc0N1?=
 =?utf-8?B?YUdlQnNheWhaMDdHVEl6Mldoa1pvemhKazVudHpJME1Oc1BpNEZMWDBSNG9t?=
 =?utf-8?B?QVFIblprNy96amlSQ0JJOVpZT1lyVkszTlpOai9hOXY5dG5FRGJ2RU9HZEY5?=
 =?utf-8?B?eXNqaFZWcWNGRlJZV1hwdFV5Vk41eUJ3YWxJT04rbkphcTJrampSbE0zT2Rm?=
 =?utf-8?B?UGZpMnZaamhIVXlJRy84WWZ6WUREM0UxWDllSmE0K3FiMXA4VHFTRk1YSjIx?=
 =?utf-8?B?ODNVS0ZOdWdLLzRYdkFsOVgxK2Z2QnZOZGptNFlTMnJla1ZocS9HeHAwYjVt?=
 =?utf-8?B?QXVVZkFzdm1YTjFZOW01d1ZqZVhmRk1BbGRhTkR1TjQxODNLbnU3WHQvdUdl?=
 =?utf-8?B?SjZxR1FXRTVpM2RoSXNHQTF0cU5XU2xJWDNiSjBTU05zVENOTjk2TDlJWm1G?=
 =?utf-8?B?MlgvTndJL2UvR3lhSVJ6VnN0QTFhRHB1aVlyS0R3U0QyUUtsbnZNZ0JtNDhF?=
 =?utf-8?B?RzVFcFB1am5PZjJtaDRZZEszNDgwaXJwdUgrK2dUbDM3eWcwNXR3NGw4aTBX?=
 =?utf-8?B?U01XTU9LK2FHT3MyRklPd3lwSzdNcGIvNlBEOWRhS2FvOWYzSW9yTjljV2cx?=
 =?utf-8?B?b0R1ODdmNllaNU5sVGtwb2VlRldZMHUzWHZRQ25DMXliMU5kT3VhN3IrWkUv?=
 =?utf-8?B?MlFFM1ZkQW1qSS9rOExRY3VvVE00dFNxNHNtVmExTnRWY2ZVWUt4OUFEMEJ6?=
 =?utf-8?B?QTRWYUJ3eGJJL2pRZkR3aGVMRTlRUnRoWlRTWVhuNU1HRGpraDlhYnhYSzNF?=
 =?utf-8?B?WEtZWnJidE82QXlQQ0tBdjJ2ejRmNXIyUVAxckhhaEJKdk8vdWs4QWxqd0VF?=
 =?utf-8?B?djEzc24xTDYzNE1zdWl2ZWVtYlN4NWgvVjRkbUR4L29QSytFdlFuVjBkdFZE?=
 =?utf-8?B?QUhjZ3BoUzNaenBDWWJGRFcwWE0zdVNNcjZXZHRGVVZzcVJLNHpTanpSTnRO?=
 =?utf-8?B?Y2x1cTdHbXZWZTZhcTQvT1J2dndnVDBmS3pGUDgyTDVkOG9LQVQ3alQ1M2pl?=
 =?utf-8?B?OWhKeEd2MVdXSEJlL1lucUF5dUlQbm5VTjBLLzFEL2laWUJhT1BqeFJtc05U?=
 =?utf-8?B?NDdhdVgzTThudUVjb0NDbHhob2U1WllMaFBVWXJXZXRpY2VlUWRyTTMzNjky?=
 =?utf-8?B?TURyL2hDTlVhUnFhNEtLLzFDWG4rdjBzVXRpNTd3RXd6Uk4rRUtiUWJxUVk4?=
 =?utf-8?B?NXQwTzdkWFNlNEgxOENCM0t2V3BRY055ZFgxU3lwK3RFU0NBV1ZadW5WT3gw?=
 =?utf-8?B?ektLU0ROQU1JUGVLeUQ0cklKeXFlYlJKNzZpemNKVk9KK2NhdTdhcExRUDdm?=
 =?utf-8?B?NUYxRERoUWdMYllCblJZVXdrZEZ3VU5HZFYwKzlBTHh6b21XVHpPaEc4cURi?=
 =?utf-8?B?V3FzTXJzakNOQWVpOEpQbGxXNUR3RDZiMDVaQ2xQajRoRXRPd3RpbzFEOGJL?=
 =?utf-8?Q?Fh9xjxPiynnXi4ig=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c495c1-53df-4b9b-4907-08da29d8a8b3
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 12:06:14.8217 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n4AmGws8XKt6ty0BnRy7h0DiTNxMDiyNmsyjqVgSrr2jPv9m7ihu5PaXeabc9ETIVvVpFRqwSQX75NjdmBbKFqEmG0jhhPq2gqzMz8oX9wg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1756
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486, 18.0.858
 definitions=2022-04-29_04:2022-04-28,
 2022-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204290070
X-Proofpoint-ORIG-GUID: 5XJVxRpLDIirzh5AauIjuWZp1XkJNg76
X-Proofpoint-GUID: 5XJVxRpLDIirzh5AauIjuWZp1XkJNg76
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>, Will Deacon <will@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 4/29/22 12:19, Robin Murphy wrote:
> On 2022-04-29 12:05, Joao Martins wrote:
>> On 4/29/22 09:28, Tian, Kevin wrote:
>>>> From: Joao Martins <joao.m.martins@oracle.com>
>>>> Sent: Friday, April 29, 2022 5:09 AM
>>>>
>>>> Similar to .read_and_clear_dirty() use the page table
>>>> walker helper functions and set DBM|RDONLY bit, thus
>>>> switching the IOPTE to writeable-clean.
>>>
>>> this should not be one-off if the operation needs to be
>>> applied to IOPTE. Say a map request comes right after
>>> set_dirty_tracking() is called. If it's agreed to remove
>>> the range op then smmu driver should record the tracking
>>> status internally and then apply the modifier to all the new
>>> mappings automatically before dirty tracking is disabled.
>>> Otherwise the same logic needs to be kept in iommufd to
>>> call set_dirty_tracking_range() explicitly for every new
>>> iopt_area created within the tracking window.
>>
>> Gah, I totally missed that by mistake. New mappings aren't
>> carrying over the "DBM is set". This needs a new io-pgtable
>> quirk added post dirty-tracking toggling.
>>
>> I can adjust, but I am at odds on including this in a future
>> iteration given that I can't really test any of this stuff.
>> Might drop the driver until I have hardware/emulation I can
>> use (or maybe others can take over this). It was included
>> for revising the iommu core ops and whether iommufd was
>> affected by it.
>>
>> I'll delete the range op, and let smmu v3 driver walk its
>> own IO pgtables.
> 
> TBH I'd be inclined to just enable DBM unconditionally in 
> arm_smmu_domain_finalise() if the SMMU supports it. Trying to toggle it 
> dynamically (especially on a live domain) seems more trouble that it's 
> worth.

Hmmm, but then it would strip userland/VMM from any sort of control (contrary
to what we can do on the CPU/KVM side). e.g. the first time you do
GET_DIRTY_IOVA it would return all dirtied IOVAs since the beginning
of guest time, as opposed to those only after you enabled dirty-tracking.

We do add the TCR values unconditionally if supported, but not
the actual dirty tracking.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
