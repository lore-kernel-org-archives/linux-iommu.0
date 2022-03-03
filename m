Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D90C433EF
	for <iommu@archiver.kernel.org>; Thu,  3 Mar 2022 19:07:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 547AE60B5C;
	Thu,  3 Mar 2022 19:07:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LnksB8VYzaDR; Thu,  3 Mar 2022 19:07:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3D8B060AC1;
	Thu,  3 Mar 2022 19:07:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18BB1C0012;
	Thu,  3 Mar 2022 19:07:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38032C000B
 for <iommu@lists.linux-foundation.org>; Thu,  3 Mar 2022 19:07:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 260FB4155A
 for <iommu@lists.linux-foundation.org>; Thu,  3 Mar 2022 19:07:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="adzYkNLy";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="Af0i/ypc"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C8QAgc2JyigY for <iommu@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 19:07:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 49195410AC
 for <iommu@lists.linux-foundation.org>; Thu,  3 Mar 2022 19:07:28 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 223IOAVd031661; 
 Thu, 3 Mar 2022 19:06:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=P8oNb7HfKhhqHimy8j5x9hz0CtdsioYwtGSC7OY68zo=;
 b=adzYkNLyJutENI9rww6Nyi4orTX2wSCUSnmxtFHplMRDUc0n3pMBPUyPDQnRLGLA7UPI
 r+AqHa/cvmj9fNEEugp12NsdDoU5cnU6AFWwjfLDzaNUz74TBDF4DtArLo7LItR13hBh
 6Y/N4FMMOIRPOIH7DoHjE1b6sNIVXD1S9XCIrSUuJvMiK4SsSGPja5LDAcT2/me78DIw
 3/S0vxkUWzwB8cThIr/rHRG0CnsiXpGKe3YvhqD0k/dLiSxhbgNmYLBNgHKYzyn9YC95
 X6UcpuvsBNLw/xSCajXjgCwzGAKpiG+pBfaS7z2hwBSfO7Il8UZ901vE0Q/kNugD8L9J yQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3eh14c1wwq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 03 Mar 2022 19:06:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 223J1RPP123285;
 Thu, 3 Mar 2022 19:06:57 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam08lp2044.outbound.protection.outlook.com [104.47.73.44])
 by userp3020.oracle.com with ESMTP id 3efdnt9gt8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 03 Mar 2022 19:06:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/DpUfdaXG1df0EIv4jmbU+ai9oEr5D2pSGUtVjZ+g9V9Jgc4JYDXKk3zqrGA2KLOXIxdMT/faMrN7EZFJFoKKe0GVUbrP0QMSryvA+29DkGWfcWg80z7INaD+muMc7i0P7p2fNE0loiMsdwqkm9bA1NoecmwKAr/+9hCPNZbEG14Ii5AZxyEabHZIL51ikWEY/dmhcxJXhv9QvJVPUwZ9t50B8r0qPrHmTF4LNyRCv6NqlxhoSNdLFxi9331SlWno/FUttinKq3ggkpvyxA3uJUjY8UFpMZGHEWkNTqpL+iXzo7kOYeUfP3oYshu3gltnyJytKsnStia1nHdFMGnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8oNb7HfKhhqHimy8j5x9hz0CtdsioYwtGSC7OY68zo=;
 b=XDCJmReIClkImh3vIKD79uLIVF1B65WoTPDbq4yIgBSKk1nyReLI0KHAsaM8f+pRtqGMgUESlJ5Z+1L4DMcY51mJzoRtKhi1F9rWtEAjclRDZGj+G527hFqj8BW7dnHgwR6f8pN7TLPthlfJw4pmtJwSR+lwcd5QApu5ryYLKjrR5PGG40M4btaB5I171Qov67dGMBTn4OUziJ0cBlYo5qcPOnXHvKedxaeQB1NxMx8lVkWaoZCeQaD5B8KIufOZEy3R4YqA0DtoaHjziTFvHPOhVR5hbY2GAkl2+5iVRkmGT9FYOyvanZZYCo05jzoBDtcS3TwNWbsyq2c40OqyaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8oNb7HfKhhqHimy8j5x9hz0CtdsioYwtGSC7OY68zo=;
 b=Af0i/ypcPBm8/2wgHg/C/xTlIyxa0CLiuTNWNLQDtrNRBGGi4BnRFwIm0DLZSaST7eFV3cILIjuwEoSqDIj/4GeNphY8uEfofCx+YVn7lT/mp/HeEdG6Dfb1mX0okGYT9mxmJAMGJwSYNnTYdxzhzE1lMYe5GBJ5VkrdMDjPK5U=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by BL0PR10MB2801.namprd10.prod.outlook.com (2603:10b6:208:74::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Thu, 3 Mar
 2022 19:06:55 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::6d20:6694:a16:56f7]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::6d20:6694:a16:56f7%3]) with mapi id 15.20.5038.015; Thu, 3 Mar 2022
 19:06:55 +0000
Message-ID: <588b2378-cac4-79cb-e520-a535422cd04f@oracle.com>
Date: Thu, 3 Mar 2022 14:06:45 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH 11/12] swiotlb: merge swiotlb-xen initialization into
 swiotlb
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
References: <20220301105311.885699-1-hch@lst.de>
 <20220301105311.885699-12-hch@lst.de>
 <alpine.DEB.2.22.394.2203011720150.3261@ubuntu-linux-20-04-desktop>
 <ca748512-12bb-7d75-13f1-8d5ec9703e26@oracle.com>
 <20220303105714.GB15103@lst.de>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <20220303105714.GB15103@lst.de>
X-ClientProxiedBy: BYAPR02CA0048.namprd02.prod.outlook.com
 (2603:10b6:a03:54::25) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95efbe20-0874-42e5-dc4d-08d9fd48fb9a
X-MS-TrafficTypeDiagnostic: BL0PR10MB2801:EE_
X-Microsoft-Antispam-PRVS: <BL0PR10MB2801D4987DE53ACEC6E93EF58A049@BL0PR10MB2801.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UEcJVw10SoExCuxyvNtEwRfpb7TgGnc5OvBpKkdljxHLPLW/Ec4VVERyTQ6GCLXum91K+vRt2JmDTSIf6ln+d1fyQCT+oj08+pA11Of8qy7Po0lOSBoxtv1THiu4LYTQX40KsOqlntwAIG1P+vIknLLkd9hB2sR5x5enlGmIIPW/xfcTSNWpoPwmVBVYx5s44ndhXudWF3XDFltaYQTS+dpo9/SnvC4/5dlEW5eWRV85AEGrFhW3vFKLhaFug6a6kdlkgIs+HcCaWV7kMhrSMxD3NGMTL20Osm5+CG1Fg2lJm5zXP3qBle6gCEEViw4+2dLNCavp4fICQsfBxxhISykWnwG3y01/9kMB4o6cRyp+MXesr8a3JUUtQjMHuTFwdQvHwfOm6xFdySVNwxLvyj7KpUGi84DILA9mG056+gxdNo87cEsrdLeczcMfo8c4B2HUmhC7QTJbu9efAd6OQO0XfCoS1oa3FUb0bmFKa2vy1fiKf9uOeBt9SjZJnPW7BoC4yYxdSbRtbIZTRWnSTRLo2rYZ5HSOOlaMrOe5WgUqpEjjUErZ7GXZXto1d8AufqGqy0G14HVnD8GKtpqwybrb7D6+4H1wkc8zuIEomjdimmudIqp8NoKwTuWc9AmvrUs/1CvuQQ3DIW7dPJfGGQBp+3FZhZBkULyIXo03KvUp2oJ3lkNOU5e1IvZf+bytaoQXeXvZcEI7Csg6VslkSsMJB/8Tjtogob6FlwtEB401FFRygTBqX3PEtj85QVGC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5009.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(36756003)(66476007)(38100700002)(2906002)(86362001)(31696002)(6486002)(26005)(186003)(2616005)(508600001)(53546011)(31686004)(6512007)(6506007)(6666004)(8676002)(6916009)(7416002)(44832011)(8936002)(4326008)(66556008)(5660300002)(83380400001)(316002)(66946007)(54906003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUVZclYwZlkwWURhWEIvUUZPMXhXa0d2bUhQY1d0Rk94em1tcnAySWhDZk5W?=
 =?utf-8?B?QXpxSzg2YWRuRkR5RFFSV2xCbTFhRlVVaFNRVDJ0ZCtGTGZycU5DK05zT0o1?=
 =?utf-8?B?S0JTZlhzcUV3dkJHWERBaXV5ek1xdmt1M2ZaZzV4YnZ0bGFMUVhiaFJQREM3?=
 =?utf-8?B?Y1lFR1YwbzR2dFE0a2o2U0RDUTR4ZjdsVkVsSkZGL1BiVmlCR1lNNlA0YVRF?=
 =?utf-8?B?VXpnci8weTdSNExVL2taY1IvdHZKazkzN0hEaW5mRTNUSFBZYmROM1h5SDVt?=
 =?utf-8?B?S1BSRkNSbEFQbnk0My9IenBCMFNQMTZVMjUyK2lINzdJVGduYWJqRXE1N1p6?=
 =?utf-8?B?d3RGMnZnVjZCbDhDUUtWRTBYRWhmQ1A1aEk5NEsvMXJHWjJtT2JvS3RVbmdD?=
 =?utf-8?B?QVNZU092c1BUODVITVRpSUJFWWczME13NWJ4Y1RnL2VGVjRSdi9PY3FzMHpv?=
 =?utf-8?B?dWRDZzFQQU9pemM2RXBIZU1wVFRjVmI1bjVMdmJGS0R0dE9RSUVSWW1qSHdB?=
 =?utf-8?B?Z2ozRHhKZnQySUxTWmhBVTExcnc2RUtNeksvNEEzYUZwN3Brc1BRdVFma3Yz?=
 =?utf-8?B?RVNRNkFYSEpLa3ZlZkhVQ3pDOHArakFUWnVMdUVIU2dkUHBLR3p4OWtiSkl4?=
 =?utf-8?B?cHZ0WGZzbDN2Sy9JNEpoQ2U0RkgrSmVmTkkwUjFrTnQyNVMrUUp3T2x3ZXB4?=
 =?utf-8?B?SUQ0UmpYbk1zU3ZJVGxwNTkxTmYvWm1kL0trZ2hWcVp6Vmt6cjduUk52dWlT?=
 =?utf-8?B?VmpldjllRmx1aHBTWnBLaWVHTnV6TGJtNWg1di9NSDAxbERuSkpCdXBYdjVu?=
 =?utf-8?B?bW5WZmlBUTJrSldISG9Jd2dUOUlhNG0wQ2NMK3d1azZ5NktYQ1ZEWlBWdjJo?=
 =?utf-8?B?NDJrOVBNclM4aVk3NUNMbVBUWVZLWWZZVkhaTWdUU3NVSmt4UHJJYnYvWkly?=
 =?utf-8?B?MVhKTytFRU0vV1BCTFZUQk0rVkFtNkVXNzR3VDR6cGh1VjdLMHZSOTRweVQx?=
 =?utf-8?B?MFBwbmdHRXA1QjE2bGphY1BHTW5lODBpZHdFZTFTVTRNV2ZqeEpQQytoY3JW?=
 =?utf-8?B?cUNFckRxZjdCZ2dkSWM5cmFkcWhVSVVObnhyS2dsdis2YUJxc0N2WTlRVmVN?=
 =?utf-8?B?aG1iL2ZxQmRPZE81OEEwV1lYZ1o5Z1RRZTg4enR3VmVNZ3RaNFNQYk5QN0lF?=
 =?utf-8?B?UG5DSkZmTjZxL0swSDZpWFNlYkwvZllIRUExWU9VczBGbWRKQ2NhYmlpazRa?=
 =?utf-8?B?WDh3aUFmaFNCd0JSQ0tiWEdJU3ZRK0RaRHd6a0ZnWWhMRzhKRnA2Q3lvWUJQ?=
 =?utf-8?B?K3h5TEJQMkpFaDc0bXJRUkNERzNncmxYbXRvVHZzWHJuOFlYUTU0ckNrcHZa?=
 =?utf-8?B?WGwzc1QvUXNsREx5MXRldTBuWU5yZVpFTnJVQjBxMHN4aVd1VXFSaDlTNVhK?=
 =?utf-8?B?ZWZxSm5aNlZIamc5S1JSdzk2WFVoOEYzK2VISEtTdEFUbDZLb2ZiSmlaQ0dO?=
 =?utf-8?B?cFBRK2J0RVFxWUNVb3ZvczJBU2FFYnN2SURCMVE4MENBck9VL0F6ZmJZRkF0?=
 =?utf-8?B?T0xOVWN5Y0F5VjNqNW52dkVqa3ZYUCtjWnJPbGF3YS9ta0Y1UjhEQUdiOHN0?=
 =?utf-8?B?YnQ5YUNHOHVKT2pKS09RZk1zSUhaeW9abkg1b0lQSFZOZDRnejNsNHRWUTJH?=
 =?utf-8?B?RzB0Wkw1Mk56cUZHUWVPQzVub2VnQ2VrMW5HcGF4WXJreHgvOWYrMC9SUmpU?=
 =?utf-8?B?SGtYa0k4V2FkVVlmcFhZS1N3Zlc1ZnhwdmQ5RUhqb2dhOEhxS3pJZHlweG9n?=
 =?utf-8?B?bDFVWGlyOHlzbDZ0a0ZpNnNVc1NuOFlpTk1LV3FxbU11TitVTzFXekRnMHg1?=
 =?utf-8?B?L21LWW1uZGlpR1QzU2F1a2gxdVdxM2xMRmtUeXg2MmVZZGw1aC9NSUxUZUxw?=
 =?utf-8?B?djByQlRyZ29HOEFNcnFhQmpxUVJpWVBSWWpsbTVYMStoWWZBd0w3aGp1QUV4?=
 =?utf-8?B?eldvZ2FCbEplcU44WUR3NEcxclp2ZStzVDVMMEE3aS9YMVRXVU5kNTZYR2pl?=
 =?utf-8?B?NTd1NVBMRjk0R1VKZ1p2emovUXlEYm11UDF1OGJkdnNrNFJJWVZLN0RFakV4?=
 =?utf-8?B?QmxBWmFvR1RkQU5QS1l3RmxCenFzVkhYVVhCTkJQTFBGZXJwZXBYTVcrTmd2?=
 =?utf-8?B?UUtVcFBpalhwdy9QbFdacFJwZ1hzQWMwUjBYQ0hBVG9GTUUxa1dOdUxJNVVa?=
 =?utf-8?Q?Y1spidh/YprpH/MPhXXiGsKEk9w5vPQSqwsgvAFAA4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95efbe20-0874-42e5-dc4d-08d9fd48fb9a
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 19:06:55.1744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /wq2I55WnEWJzPzZPikwGFw10oNM0tIUpqPNREFNUHH8jHRWO+PrJOuABArjfVDgsu9vNK+tjpK11JT0YNvGlmHX1pLDJP/Rp0gfavEZV4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2801
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10275
 signatures=686983
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203030086
X-Proofpoint-GUID: wMGNRfAWjzQls01j7dcE8rVGfqOA7VHH
X-Proofpoint-ORIG-GUID: wMGNRfAWjzQls01j7dcE8rVGfqOA7VHH
Cc: Juergen Gross <jgross@suse.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 linux-s390@vger.kernel.org, Stefano Stabellini <sstabellini@kernel.org>,
 linux-ia64@vger.kernel.org, Anshuman Khandual <anshuman.khandual@arm.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Robin Murphy <robin.murphy@arm.com>, x86@kernel.org,
 linux-mips@vger.kernel.org, tboot-devel@lists.sourceforge.net,
 linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
 linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-riscv@lists.infradead.org,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Ck9uIDMvMy8yMiA1OjU3IEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBPbiBXZWQsIE1h
ciAwMiwgMjAyMiBhdCAwODoxNTowM0FNIC0wNTAwLCBCb3JpcyBPc3Ryb3Zza3kgd3JvdGU6Cj4+
IE5vdCBmb3IgbWUsIEkgZmFpbCB0byBib290IHdpdGgKPj4KPj4gWyAgIDUyLjIwMjAwMF0gYm54
dF9lbiAwMDAwOjMxOjAwLjA6IHN3aW90bGIgYnVmZmVyIGlzIGZ1bGwgKHN6OiAyNTYgYnl0ZXMp
LCB0b3RhbCAwIChzbG90cyksIHVzZWQgMCAoc2xvdHMpCj4+Cj4+ICh0aGlzIGlzIGlzY3NpIHJv
b3Qgc28gSSBuZWVkIHRoZSBOSUMpLgo+Pgo+Pgo+PiBJIGJpc2VjdGVkIGl0IHRvICJ4ODY6IHJl
bW92ZSB0aGUgSU9NTVUgdGFibGUgaW5mcmFzdHJ1Y3R1cmUiIGJ1dCBoYXZlbid0IGFjdHVhbGx5
IGxvb2tlZCBhdCB0aGUgY29kZSB5ZXQuCj4gVGhhbmtzLiBMb29rcyBsaWtlIHRoZSBzaXppbmcg
aXMgZ29pbmcgd3JvbmcuICBKdXN0IHRvIGNvbmZpcm0sIHRoaXMgaXMKPiBkb20wIG9uIHg4NiBh
bmQgbm8gc3BlY2lhbCBjb21tYW5kIGxpbmUgb3B0aW9ucz8KCgpSaWdodC4KCgptb2R1bGUyIC9i
b290L3ZtbGludXotNS4xNy4wLXJjNnN3aW90bGIgcGxhY2Vob2xkZXIgcm9vdD1VVUlEPWRiZWYx
MjYyLThjOGEtNDNkYi04MDU1LTdkOWJlYzdiZWNlMCBybyBjcmFzaGtlcm5lbD1hdXRvIExBTkc9
ZW5fVVMuVVRGLTggcmQubHVrcz0wIHJkLmx2bT0wIHJkLm1kPTAgcmQuZG09MCBuZXRyb290PWlz
Y3NpOjE2OS4yNTQuMC4yOjo6MTppcW4uMjAxNS0wMi5vcmFjbGUuYm9vdDp1ZWZpIGlzY3NpX3Bh
cmFtPW5vZGUuc2Vzc2lvbi50aW1lby5yZXBsYWNlbWVudF90aW1lb3V0PTYwMDAgbmV0LmlmbmFt
ZXM9MSBudm1lX2NvcmUuc2h1dGRvd25fdGltZW91dD0xMCBpcG1pX3NpLnRyeWFjcGk9MCBpcG1p
X3NpLnRyeWRtaT0wIGlwbWlfc2kudHJ5ZGVmYXVsdHM9MCBsaWJpc2NzaS5kZWJ1Z19saWJpc2Nz
aV9laD0xwqAgcGFuaWM9MjAgbm9rYXNsciBlYXJseXByaW50az14ZW4gY29uc29sZT1odmMwIGxv
Z2xldmVsPTggNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
