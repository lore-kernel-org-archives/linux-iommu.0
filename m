Return-Path: <SRS0=eGnl=LK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBC7C48BE6
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 14:13:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F2C961107
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 14:13:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F2C961107
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 27F1D403D6;
	Wed, 16 Jun 2021 14:13:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XjLmPbBPZbau; Wed, 16 Jun 2021 14:13:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A8F5E40107;
	Wed, 16 Jun 2021 14:13:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75EE1C000E;
	Wed, 16 Jun 2021 14:13:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 777B5C000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 14:13:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 57B126082A
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 14:13:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="L3orx3mm";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="XIcmjUsy"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id owGWkLwHRYzt for <iommu@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 14:13:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AAD1160662
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 14:13:10 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 15GECaps016432; Wed, 16 Jun 2021 14:13:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=T7vY73bDKI8WFO+pocnsgZkd5Hzn8Ef9UwS+QEQ96XI=;
 b=L3orx3mmYJhIbf79pqmBUu7jWhw4O2m3Hypxr0EZ7O1pWPYslDqvkGB59U31R2URIz7P
 4Lls7X+mnvFjdoLOyebS64piS4LrHIsvlatPszRTwZsW26pQTSV8ZDbD8u9EcKFPcaxz
 M2IBIc1FdmGyZW74sSzq2KIUkPXFTQ9gYa/ceWvU7xl5Fg5nP8mP8zxGe6u0CmzhBw5g
 XXoOVrL50DC80sYIahsXLl6yDwmJYkOjo4Qh+WY07ZUCwz1gi75q+Jkir6WYxwZL2u9R
 qT1MEW57C8eQ3YFXntlv4c6Yy4zODex1XW/qiw+h2AotOSyS/8CzdCeJfannRxARLa5U 3g== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 39770h96h1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Jun 2021 14:13:06 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
 by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 15GED5Ev037081;
 Wed, 16 Jun 2021 14:13:05 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam07lp2045.outbound.protection.outlook.com [104.47.51.45])
 by userp3030.oracle.com with ESMTP id 396wanweed-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Jun 2021 14:13:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ICmAjzJDhqyZfQVlnvCMP6XCHZhXO+cebuhjrZnBokz+6/+D0lIqywSqyXEKb2tlBVopKplvvgAousMeYR27ots5RQ1XQXrr/0oRfTHWOIduRYD1bgGUz6SBEvbxH1gUR490iTZx6ASnPz0sDKc/VIiG6qIWXPecPIqY/hsaKlALDgtiz1iA34T6Tyd6bvuti7up/exiSW4tf1zhpxnxEK9BQe2BUq2eBukZqq3GSstGtDbdx332aAQDR6leN9/rL/nYly7i5JghrnAVxGb7C7lHptl8njEFURttGRo5PqL6h9Fmpth66IZgEjp6qEh/j3nF0ReKJV4AanmmDPB8Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7vY73bDKI8WFO+pocnsgZkd5Hzn8Ef9UwS+QEQ96XI=;
 b=Jw/xO06fEdGtF551RGlSRhzrwxnQyloFXfV3yDjXwXUvjU+kly2YGjb9Wi07a2wPiBtGDSa0gWEIFaddD12qU4cyLBpTalRJRF8YSZ3j2R3DRnO+t/M2bRAVmUXTUXTlWjHua8Nj3KO6O/Llr0jd2tKJGg3OCeSnrot23IsO1/nGtpWTZNABr4pJlOEI/z+aDfjBgRt/05SljOqrAkBJTIVfl/SLvw4vswofidP/RnlA3a3l6uzczr2RiH9pJ/LfULxjxTQAiNUBFsvBBzAQT08iGTIjtHLDi+IKT+75riv0r784s90ORZunRMZ83cx9JBQ4Jon57bVi499QSYKq5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7vY73bDKI8WFO+pocnsgZkd5Hzn8Ef9UwS+QEQ96XI=;
 b=XIcmjUsypaJuzpQ5GWgStVOAwIoxnUuvUYvFNyTU89XO7oMLqUlU0UJ6qpVqWrUKkydm03kGaIak7IP4cNE/2W2ZK4RkQdyjVmJ4vZ2embwbHA6YopJztbs8MDdV2kagxrYPxbNQjDr+mZgOkLbN8c7KGbi75GTEWoRw8JMpFB4=
Authentication-Results: epam.com; dkim=none (message not signed)
 header.d=none;epam.com; dmarc=none action=none header.from=oracle.com;
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by BLAPR10MB5010.namprd10.prod.outlook.com (2603:10b6:208:30d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Wed, 16 Jun
 2021 14:13:02 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::78a3:67d:a8ca:93cf]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::78a3:67d:a8ca:93cf%7]) with mapi id 15.20.4242.019; Wed, 16 Jun 2021
 14:13:02 +0000
Subject: Re: [PATCH 2/2] swiotlb-xen: override common mmap and get_sgtable dma
 ops
To: Roman Skakun <rm.skakun@gmail.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <855a58e2-1e03-4763-cb56-81367b73762c@oracle.com>
 <20210616114205.38902-1-roman_skakun@epam.com>
 <20210616114205.38902-2-roman_skakun@epam.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <2834cdc0-534c-4f07-1901-e468a7713c1f@oracle.com>
Date: Wed, 16 Jun 2021 10:12:55 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <20210616114205.38902-2-roman_skakun@epam.com>
Content-Language: en-US
X-Originating-IP: [160.34.88.136]
X-ClientProxiedBy: SJ0PR05CA0152.namprd05.prod.outlook.com
 (2603:10b6:a03:339::7) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.74.102.136] (160.34.88.136) by
 SJ0PR05CA0152.namprd05.prod.outlook.com (2603:10b6:a03:339::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.7 via Frontend Transport; Wed, 16 Jun 2021 14:12:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa76d82e-ff93-4f88-4148-08d930d0da67
X-MS-TrafficTypeDiagnostic: BLAPR10MB5010:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BLAPR10MB5010217FBC106EA9B3FC25A78A0F9@BLAPR10MB5010.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9WqY3a8BulNSroI+92f5uZf/SbIOjBy6tQJalZafuswYUfzDfGhopKg2h45D4ezJKbdtrpGZtsee0TPFaVXxlm5eo3RsQEic9UukS5kSaGrAUVdnyNgkeeBNdVs9qjFt0rmx6k/xxPNr7+1i4Q1I/O/cy5dP1jXSAcvQDkd2beSy9C0bu3r7EFeDlVcU2RENdvNaBKdyTg71fLq0ms+MFBIL7wxxvit/+3bgTTjOMuMG88zUjm80eQt5lEAnuAtala6hrFQQctDCfiMxlvB+71HzMBbzU+x8ENcOjwJn1h3hx1X3SBUBLfJx2IvpkKF6p8JRz2/JzukZrUhqr9J9vmA1czOt92ID14S+GtcAlnA8xEwyBHk+cgXIvT/PwMH9zCHhdhkjary7odRH+Bof1/1Wp4HqebauBUhz4XISaM3w2rcA+6vdwICf0GkxZg9/c3xMOS4N5llhPqGg76DuUeK9C+XJaRzWBWoWP8VLWQuzRt0qjl03UyIl3FSZwTGaj6fXGZFjmkJa2VvuXe+dXv0AYgjJG04zQwfE8QXRvUMMiigg5adDU43DnXAS/b7lD4kK7XK3AWYWAQEkzAfPBdt/P2lZwvkGKkowRXRXMQul9Ben3xmoGLxPDpDsNoum+8O4rh7QHp3OZ8RdSCMI0QfYkRqEEDC2F2ANk6HdjdOU/+rIe/kLo+tmG2Wj4dYu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5009.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(376002)(396003)(346002)(39860400002)(366004)(66476007)(66556008)(8936002)(2906002)(4326008)(44832011)(16526019)(478600001)(6666004)(83380400001)(186003)(7416002)(8676002)(38100700002)(54906003)(110136005)(5660300002)(2616005)(16576012)(26005)(31696002)(316002)(956004)(86362001)(31686004)(53546011)(6486002)(36756003)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clVQVTRkTUlHcERvdFFvMDUwZ3RmRDZ5c1RQQUdNNVV3dmsrUEVVRFF2dzVn?=
 =?utf-8?B?VUhvQ0I2NlIveDBCVkV5Ti9qMlFUdldkWDFaQmkrNUp3ck12NHhZTHZmUDVs?=
 =?utf-8?B?Zk02UmJqMHVkOWxiYmlOWFpGanZTZFF4ZU8rOFJuZHpTUjVOdXluczlLR0RQ?=
 =?utf-8?B?QkdKMFRQMG1rVmpJbGltOEpXNjd5TEhsU3lRZ0gxMWp3V1JjTFlBUTE0M3N6?=
 =?utf-8?B?S1ZreEQ4RUxiaWVnSFdkbEVjdTM1NU1GU3orTlVjN3ZFdEh0akJvejdNZ2dq?=
 =?utf-8?B?aDZiclZwSmpXYk9JdEgxWVk4bnMwNlRsdEVGTW1pN25kN2NJQm8rQTVJUDhF?=
 =?utf-8?B?WUtPcmVxQ3c1anJBQVRqcFFLT2V4R1lNczl4WkZHT2pkNjNjRXdyZWJiTUdm?=
 =?utf-8?B?WnNXNmFwbGd6VzRXeHJvYlU2c2NXazVLVzlTVGhBNnYwU2dhU250dFR5cmN0?=
 =?utf-8?B?QllySEpKYUJVdHE5N2NYZmVaNGkrZlRweE9MNmppaWhjdXpZNWVzQkVsRTJk?=
 =?utf-8?B?c1NLbHZLU214VU9vUkxtUE5EQnJ2VmVQOVVobHQ1T210RmxzNllEcHBHRHhG?=
 =?utf-8?B?aW9XZDk3OFNFRHdxakU3OHMzVjVETWFPTHQyNmpucTkwOHZDa3RwWDJQeE8y?=
 =?utf-8?B?NjVlb29BUkh2MW1peklQYWZ4VEpvNTRNK0l2U2srbFBtTWdCN1VuOXZwTHdB?=
 =?utf-8?B?MFBueDVTaHZsTzJ5ci9ZVnN4YXZIdGVLcEl3ZlBkNmFBSUtxRlJMaFlLaVhy?=
 =?utf-8?B?ekhBNUVKNkdYM2x4Yk8wMEdPQUhCNmhNeE1NMDdmczdVdWs1QjlNaURjaHpF?=
 =?utf-8?B?Ty9NdUZrcUVVWU1na3d2YnVhWFZ5RmMzOHpBVTdVRnkybHlSU1Nldks5Y3Iv?=
 =?utf-8?B?T1puT1RGMHhjVWdSdGRzcjVOUHRTSzR4ejZSa3JISWovZHdTN1pKUHdkbUtv?=
 =?utf-8?B?MUxsK2ZjWTVidUJvOWN4SWl2SW9rd3ZndzdNWFhzV3NmVVNpamhNTVVPWE9x?=
 =?utf-8?B?bzhVdHhLaERmV1ZEQ01obTVLUHJWMDhva2tMSHQ4VDZjYVl0SFN6eXovbG5p?=
 =?utf-8?B?eFBEVldGRlhCcnk3b0NYQit2eHJ1MjdHU2NzMUE2T2VxNmdCdDdCVTZmWXNm?=
 =?utf-8?B?SkNEL1loTGFVL3ovUHE1aU9tMGxDZDY1T1pjbHNGMzVMR1pkdFIyWjkwc1Jm?=
 =?utf-8?B?UEdQWDhIV1liNlZ3Q2ZNdXpRcWh6RnhjMkRuZ3UvVDlLQmVra1YyaW9VK2c4?=
 =?utf-8?B?dzdhWFEwOHM4VGhsS2ZjU1dSK3lJTzZSaTZqVW5kdUdEWWh5QnJLTXFXSXVM?=
 =?utf-8?B?R2w2TkViMDdIbzJrOG8xbzBaZFVVaVdaRG1SZ3F1YkFLZGFSaFArTml3aHZV?=
 =?utf-8?B?UnNmSEhpeFZnaHRhQVg3eU1YRTdGM1I5ZHBhRU9pZ3hOK2F2ZUxBdnZ2RTB3?=
 =?utf-8?B?QjNPMG5QRmdyOW9IOU5OVGs1Yk8vYkZnaDl4cHhCYkNVUDF2QndrTThxWVF0?=
 =?utf-8?B?THZmSmVVeG0xQy9EdWxoemZ2RW9aL0phRDhTeWtiNmRYVXhpb2ZaQ1BOTXNU?=
 =?utf-8?B?OE8xUEY4SndhWXd3U2tUc3B5TGsyMjQ3WlZFUHJRaGs3azZlS2J6TGYrdmFH?=
 =?utf-8?B?Rm05cEJhenFPZ3hGWStJeDhDY3NYMEYrc0V4WDY2ZWlRSEFiRVFkdkhNYmQ5?=
 =?utf-8?B?aVlzQ2RQSTRlWDl1L01sV1BpYWZ5M3h2R0V5bzltN01HZnBWR2JKbmx0RmNO?=
 =?utf-8?Q?J47h/hknymDYuAMp0nsYTfBEX2wXjP7lpNQP+zV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa76d82e-ff93-4f88-4148-08d930d0da67
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 14:13:02.6670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4DUX2/d7H8Nh5WUow0Xu3IguO83SfOSSzhqDZ07uad5oABLIdAgDloOyH1RbwZbHLKcvanyfgUOQMGjwCLpE4a0/MPgz6CkPsyMEGQeeLGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5010
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10016
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106160083
X-Proofpoint-GUID: 8eyhWaWUFcFNEW6BVBQAZX7jHMuNc9vm
X-Proofpoint-ORIG-GUID: 8eyhWaWUFcFNEW6BVBQAZX7jHMuNc9vm
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
 Andrii Anisov <andrii_anisov@epam.com>, Roman Skakun <roman_skakun@epam.com>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Ck9uIDYvMTYvMjEgNzo0MiBBTSwgUm9tYW4gU2tha3VuIHdyb3RlOgo+IFRoaXMgY29tbWl0IGlz
IGRlZGljYXRlZCB0byBmaXggaW5jb3JyZWN0IGNvbnZlcnNpb24gZnJvbQo+IGNwdV9hZGRyIHRv
IHBhZ2UgYWRkcmVzcyBpbiBjYXNlcyB3aGVuIHdlIGdldCB2aXJ0dWFsCj4gYWRkcmVzcyB3aGlj
aCBhbGxvY2F0ZWQgdGhyb3VnaCB4ZW5fc3dpb3RsYl9hbGxvY19jb2hlcmVudCgpCj4gYW5kIGNh
biBiZSBtYXBwZWQgaW4gdGhlIHZtYWxsb2MgcmFuZ2UuCj4gQXMgdGhlIHJlc3VsdCwgdmlydF90
b19wYWdlKCkgY2Fubm90IGNvbnZlcnQgdGhpcyBhZGRyZXNzCj4gcHJvcGVybHkgYW5kIHJldHVy
biBpbmNvcnJlY3QgcGFnZSBhZGRyZXNzLgo+Cj4gTmVlZCB0byBkZXRlY3Qgc3VjaCBjYXNlcyBh
bmQgb2J0YWlucyB0aGUgcGFnZSBhZGRyZXNzIHVzaW5nCj4gdm1hbGxvY190b19wYWdlKCkgaW5z
dGVhZC4KPgo+IFRoZSByZWZlcmVuY2UgY29kZSBmb3IgbW1hcCgpIGFuZCBnZXRfc2d0YWJsZSgp
IHdhcyBjb3BpZWQKPiBmcm9tIGtlcm5lbC9kbWEvb3BzX2hlbHBlcnMuYyBhbmQgbW9kaWZpZWQg
dG8gcHJvdmlkZQo+IGFkZGl0aW9uYWwgZGV0ZWN0aW9ucyBhcyBkZXNjcmliZWQgYWJvdmUuCj4K
PiBJbiBvcmRlciB0byBzaW1wbGlmeSBjb2RlIHRoZXJlIHdhcyBhZGRlZCBhIG5ldwo+IGRtYV9j
cHVfYWRkcl90b19wYWdlKCkgaGVscGVyLgo+Cj4gU2lnbmVkLW9mZi1ieTogUm9tYW4gU2tha3Vu
IDxyb21hbl9za2FrdW5AZXBhbS5jb20+Cj4gUmV2aWV3ZWQtYnk6IEFuZHJpaSBBbmlzb3YgPGFu
ZHJpaV9hbmlzb3ZAZXBhbS5jb20+Cj4gLS0tCj4gIGRyaXZlcnMveGVuL3N3aW90bGIteGVuLmMg
fCA0MiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0KPiAgMSBmaWxlIGNo
YW5nZWQsIDM0IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy94ZW4vc3dpb3RsYi14ZW4uYyBiL2RyaXZlcnMveGVuL3N3aW90bGIteGVuLmMKPiBp
bmRleCA5MGJjNWZjMzIxYmMuLjkzMzFhODUwMDU0NyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3hl
bi9zd2lvdGxiLXhlbi5jCj4gKysrIGIvZHJpdmVycy94ZW4vc3dpb3RsYi14ZW4uYwo+IEBAIC0x
MTgsNiArMTE4LDE0IEBAIHN0YXRpYyBpbnQgaXNfeGVuX3N3aW90bGJfYnVmZmVyKHN0cnVjdCBk
ZXZpY2UgKmRldiwgZG1hX2FkZHJfdCBkbWFfYWRkcikKPiAgCXJldHVybiAwOwo+ICB9Cj4gIAo+
ICtzdGF0aWMgc3RydWN0IHBhZ2UgKmNwdV9hZGRyX3RvX3BhZ2Uodm9pZCAqY3B1X2FkZHIpCj4g
K3sKPiArCWlmIChpc192bWFsbG9jX2FkZHIoY3B1X2FkZHIpKQo+ICsJCXJldHVybiB2bWFsbG9j
X3RvX3BhZ2UoY3B1X2FkZHIpOwo+ICsJZWxzZQo+ICsJCXJldHVybiB2aXJ0X3RvX3BhZ2UoY3B1
X2FkZHIpOwo+ICt9Cj4gKwo+ICBzdGF0aWMgaW50Cj4gIHhlbl9zd2lvdGxiX2ZpeHVwKHZvaWQg
KmJ1Ziwgc2l6ZV90IHNpemUsIHVuc2lnbmVkIGxvbmcgbnNsYWJzKQo+ICB7Cj4gQEAgLTMzNyw3
ICszNDUsNyBAQCB4ZW5fc3dpb3RsYl9mcmVlX2NvaGVyZW50KHN0cnVjdCBkZXZpY2UgKmh3ZGV2
LCBzaXplX3Qgc2l6ZSwgdm9pZCAqdmFkZHIsCj4gIAlpbnQgb3JkZXIgPSBnZXRfb3JkZXIoc2l6
ZSk7Cj4gIAlwaHlzX2FkZHJfdCBwaHlzOwo+ICAJdTY0IGRtYV9tYXNrID0gRE1BX0JJVF9NQVNL
KDMyKTsKPiAtCXN0cnVjdCBwYWdlICpwYWdlOwo+ICsJc3RydWN0IHBhZ2UgKnBhZ2UgPSBjcHVf
YWRkcl90b19wYWdlKHZhZGRyKTsKPiAgCj4gIAlpZiAoaHdkZXYgJiYgaHdkZXYtPmNvaGVyZW50
X2RtYV9tYXNrKQo+ICAJCWRtYV9tYXNrID0gaHdkZXYtPmNvaGVyZW50X2RtYV9tYXNrOwo+IEBA
IC0zNDksMTEgKzM1Nyw2IEBAIHhlbl9zd2lvdGxiX2ZyZWVfY29oZXJlbnQoc3RydWN0IGRldmlj
ZSAqaHdkZXYsIHNpemVfdCBzaXplLCB2b2lkICp2YWRkciwKPiAgCS8qIENvbnZlcnQgdGhlIHNp
emUgdG8gYWN0dWFsbHkgYWxsb2NhdGVkLiAqLwo+ICAJc2l6ZSA9IDFVTCA8PCAob3JkZXIgKyBY
RU5fUEFHRV9TSElGVCk7Cj4gIAo+IC0JaWYgKGlzX3ZtYWxsb2NfYWRkcih2YWRkcikpCj4gLQkJ
cGFnZSA9IHZtYWxsb2NfdG9fcGFnZSh2YWRkcik7Cj4gLQllbHNlCj4gLQkJcGFnZSA9IHZpcnRf
dG9fcGFnZSh2YWRkcik7Cj4gLQo+ICAJaWYgKCFXQVJOX09OKChkZXZfYWRkciArIHNpemUgLSAx
ID4gZG1hX21hc2spIHx8Cj4gIAkJICAgICByYW5nZV9zdHJhZGRsZXNfcGFnZV9ib3VuZGFyeShw
aHlzLCBzaXplKSkgJiYKPiAgCSAgICBUZXN0Q2xlYXJQYWdlWGVuUmVtYXBwZWQocGFnZSkpCj4g
QEAgLTU3Myw3ICs1NzYsMjMgQEAgeGVuX3N3aW90bGJfZG1hX21tYXAoc3RydWN0IGRldmljZSAq
ZGV2LCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwKPiAgCQkgICAgIHZvaWQgKmNwdV9hZGRy
LCBkbWFfYWRkcl90IGRtYV9hZGRyLCBzaXplX3Qgc2l6ZSwKPiAgCQkgICAgIHVuc2lnbmVkIGxv
bmcgYXR0cnMpCj4gIHsKPiAtCXJldHVybiBkbWFfY29tbW9uX21tYXAoZGV2LCB2bWEsIGNwdV9h
ZGRyLCBkbWFfYWRkciwgc2l6ZSwgYXR0cnMpOwo+ICsJdW5zaWduZWQgbG9uZyB1c2VyX2NvdW50
ID0gdm1hX3BhZ2VzKHZtYSk7Cj4gKwl1bnNpZ25lZCBsb25nIGNvdW50ID0gUEFHRV9BTElHTihz
aXplKSA+PiBQQUdFX1NISUZUOwo+ICsJdW5zaWduZWQgbG9uZyBvZmYgPSB2bWEtPnZtX3Bnb2Zm
Owo+ICsJc3RydWN0IHBhZ2UgKnBhZ2UgPSBjcHVfYWRkcl90b19wYWdlKGNwdV9hZGRyKTsKPiAr
CWludCByZXQ7Cj4gKwo+ICsJdm1hLT52bV9wYWdlX3Byb3QgPSBkbWFfcGdwcm90KGRldiwgdm1h
LT52bV9wYWdlX3Byb3QsIGF0dHJzKTsKPiArCj4gKwlpZiAoZG1hX21tYXBfZnJvbV9kZXZfY29o
ZXJlbnQoZGV2LCB2bWEsIGNwdV9hZGRyLCBzaXplLCAmcmV0KSkKPiArCQlyZXR1cm4gcmV0Owo+
ICsKPiArCWlmIChvZmYgPj0gY291bnQgfHwgdXNlcl9jb3VudCA+IGNvdW50IC0gb2ZmKQo+ICsJ
CXJldHVybiAtRU5YSU87Cj4gKwo+ICsJcmV0dXJuIHJlbWFwX3Bmbl9yYW5nZSh2bWEsIHZtYS0+
dm1fc3RhcnQsCj4gKwkJCXBhZ2VfdG9fcGZuKHBhZ2UpICsgdm1hLT52bV9wZ29mZiwKPiArCQkJ
dXNlcl9jb3VudCA8PCBQQUdFX1NISUZULCB2bWEtPnZtX3BhZ2VfcHJvdCk7Cj4gIH0KCgpJIHdv
bmRlciBub3cgd2hldGhlciB3ZSBjb3VsZCBhdm9pZCBjb2RlIGR1cGxpY2F0aW9uIGJldHdlZW4g
aGVyZSBhbmQgZG1hX2NvbW1vbl9tbWFwKCkvZG1hX2NvbW1vbl9nZXRfc2d0YWJsZSgpIGFuZCB1
c2UgeW91ciBoZWxwZXIgdGhlcmUuCgoKQ2hyaXN0b3BoLCB3b3VsZCB0aGF0IHdvcms/wqAgSS5l
LiBzb21ldGhpbmcgbGlrZQoKCmRpZmYgLS1naXQgYS9rZXJuZWwvZG1hL29wc19oZWxwZXJzLmMg
Yi9rZXJuZWwvZG1hL29wc19oZWxwZXJzLmMKaW5kZXggOTEwYWU2OWNhZTc3Li40MzQxMWMyZmE0
N2IgMTAwNjQ0Ci0tLSBhL2tlcm5lbC9kbWEvb3BzX2hlbHBlcnMuYworKysgYi9rZXJuZWwvZG1h
L29wc19oZWxwZXJzLmMKQEAgLTEyLDcgKzEyLDcgQEAgaW50IGRtYV9jb21tb25fZ2V0X3NndGFi
bGUoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3Qgc2dfdGFibGUgKnNndCwKwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgdm9pZCAqY3B1X2FkZHIsIGRtYV9hZGRyX3QgZG1hX2FkZHIs
IHNpemVfdCBzaXplLArCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBs
b25nIGF0dHJzKQrCoHsKLcKgwqDCoMKgwqDCoCBzdHJ1Y3QgcGFnZSAqcGFnZSA9IHZpcnRfdG9f
cGFnZShjcHVfYWRkcik7CivCoMKgwqDCoMKgwqAgc3RydWN0IHBhZ2UgKnBhZ2UgPSBjcHVfYWRk
cl90b19wYWdlKGNwdV9hZGRyKTsKwqDCoMKgwqDCoMKgwqAgaW50IHJldDsKwqAKwqDCoMKgwqDC
oMKgwqAgcmV0ID0gc2dfYWxsb2NfdGFibGUoc2d0LCAxLCBHRlBfS0VSTkVMKTsKQEAgLTQzLDcg
KzQzLDcgQEAgaW50IGRtYV9jb21tb25fbW1hcChzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCB2
bV9hcmVhX3N0cnVjdCAqdm1hLArCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJu
IC1FTlhJTzsKwqAKwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJlbWFwX3Bmbl9yYW5nZSh2bWEsIHZt
YS0+dm1fc3RhcnQsCi3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBwYWdlX3RvX3Bmbih2aXJ0X3RvX3BhZ2UoY3B1X2FkZHIpKSArIHZtYS0+dm1fcGdvZmYsCivC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwYWdlX3RvX3Bmbihj
cHVfYWRkcl90b19wYWdlKGNwdV9hZGRyKSkgKyB2bWEtPnZtX3Bnb2ZmLArCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVzZXJfY291bnQgPDwgUEFHRV9TSElG
VCwgdm1hLT52bV9wYWdlX3Byb3QpOwrCoCNlbHNlCsKgwqDCoMKgwqDCoMKgIHJldHVybiAtRU5Y
SU87CgoKLWJvcmlzCgoKPiAgCj4gIC8qCj4gQEAgLTU4NSw3ICs2MDQsMTQgQEAgeGVuX3N3aW90
bGJfZ2V0X3NndGFibGUoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3Qgc2dfdGFibGUgKnNndCwK
PiAgCQkJdm9pZCAqY3B1X2FkZHIsIGRtYV9hZGRyX3QgaGFuZGxlLCBzaXplX3Qgc2l6ZSwKPiAg
CQkJdW5zaWduZWQgbG9uZyBhdHRycykKPiAgewo+IC0JcmV0dXJuIGRtYV9jb21tb25fZ2V0X3Nn
dGFibGUoZGV2LCBzZ3QsIGNwdV9hZGRyLCBoYW5kbGUsIHNpemUsIGF0dHJzKTsKPiArCXN0cnVj
dCBwYWdlICpwYWdlID0gY3B1X2FkZHJfdG9fcGFnZShjcHVfYWRkcik7Cj4gKwlpbnQgcmV0Owo+
ICsKPiArCXJldCA9IHNnX2FsbG9jX3RhYmxlKHNndCwgMSwgR0ZQX0tFUk5FTCk7Cj4gKwlpZiAo
IXJldCkKPiArCQlzZ19zZXRfcGFnZShzZ3QtPnNnbCwgcGFnZSwgUEFHRV9BTElHTihzaXplKSwg
MCk7Cj4gKwo+ICsJcmV0dXJuIHJldDsKPiAgfQo+ICAKPiAgY29uc3Qgc3RydWN0IGRtYV9tYXBf
b3BzIHhlbl9zd2lvdGxiX2RtYV9vcHMgPSB7Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby9pb21tdQ==
