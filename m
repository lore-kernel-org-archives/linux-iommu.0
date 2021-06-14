Return-Path: <SRS0=DplC=LI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36C4C2B9F4
	for <iommu@archiver.kernel.org>; Mon, 14 Jun 2021 15:46:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65D0661356
	for <iommu@archiver.kernel.org>; Mon, 14 Jun 2021 15:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65D0661356
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2963283AA3;
	Mon, 14 Jun 2021 15:46:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xyiWbDVPCaBW; Mon, 14 Jun 2021 15:46:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8347983AEF;
	Mon, 14 Jun 2021 15:46:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5334AC000D;
	Mon, 14 Jun 2021 15:46:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9D9CC000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 15:45:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A89FE40100
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 15:45:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="KCUvgy6a";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="NeJYS48p"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8s0hqLp9a2yc for <iommu@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 15:45:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CE1C7400CB
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 15:45:58 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 15EFh660015718; Mon, 14 Jun 2021 15:45:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=t1qtCFv42Ehv8s+NNj+MyFNBqYrN7lrL8g47Ata/JRM=;
 b=KCUvgy6ayIKB6DfZAfEGR4lqztmC+cdXDzzGhPTX6PejPNQXFZl5SQdddDffC+Z62Wfh
 7RWGAMFTmwmuGeq6rpJs/yU6cdDik+waC8bmOsIMDZ//wLRiznepSXbKJKFamA6jZOhI
 ioW4JYiwVqMajv/5LilE2Q1tT9FHCGm6NiBDN1SUktCUEE+Zb6YuZ3tbVw4JlOtvWn5T
 QZ/PanAGrSvCmtwSyl6BI2q0UfxzTLT0bdiuxONvGkjcT+jbd27bEo7t2FVr9qskqX9D
 61MVJu7KK8AtfCwsOEMWYztcH346btIao8lP3XypOX/b8OAT+EVNRkCx7O8z5hu0zlp9 sg== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 395t6ug90j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Jun 2021 15:45:54 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
 by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 15EFiOkR028132;
 Mon, 14 Jun 2021 15:45:54 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by aserp3030.oracle.com with ESMTP id 3959cjh3jc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Jun 2021 15:45:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjP2co2IpBTx8GIrp208SOnXKoembSdA20V3JR6K8E0ZOhbBEs4hXxV9eqFUmUhg7yNFIEFMN4B9kmXg5oN+BeG+JDExm8ShJ6cWvfVpQSV+NrKOdYwD9X+fdj3bid2I8Lidq/0vdTZaNERREHmPZWZPWB9c73mehEb2gZachhX+dfuzDz73rmWPFzuNT+tSF0baV1IiC1EP5F+AXulL+iM95KKDhQ1A9yCfgP1+DbTJjey0cqqSU9bttoNWWOfj19rgDFgB+3mrV5vCR5OcdLJIygAU+OUSI5m01bRoydokcC19HLD4YSgoS45BH6hEwt3pvtpMVOTPAn05oe96+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t1qtCFv42Ehv8s+NNj+MyFNBqYrN7lrL8g47Ata/JRM=;
 b=jkv1zkU2bTisN/HS2HSgti5Ueu/houq800F2ZV8u2efs3r+Z/yHDYu10O7jH/9Gp2ToHuc1mLF176RFBNa0LZb1wjKUgi0XfXwpA599AUzzIy0ZGNLtHtYgDKWR9zumgWKYXKJBUdKQ4LoeLEMpCRPfDxKmeFX7EhXXuqB2aGlGPc52fzDjp6cIgIR8arGEWrpoQSDwz9wR4W1L5D4e8oDXh/NvnBd6gsetxLaVRXgHZQzqaLqx4R6fMp5ojNA+wOCKViAIeT3V04r7nh8eIzDCN1FT/DvqylIYpXXghBkdH9RtITmyBPPPfduTpVyLV5cUqeqbyP19rRlu4EaQQyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t1qtCFv42Ehv8s+NNj+MyFNBqYrN7lrL8g47Ata/JRM=;
 b=NeJYS48pM9EGXk0Zg6FynSAU3Rut451t3QxtXeC6w6XPbtrDGaxHIo6ODUF/f0FXGyZGyTmJJ3ZAhj/6yCxqyvqO9Y2V+RgragE3OGgeGYxE/TyNg7m9LKNaWQ/0IdJcmOq9/mnudbCdZiO72jVCRrSGcuCDIxGrOOItBbj7y0g=
Authentication-Results: epam.com; dkim=none (message not signed)
 header.d=none;epam.com; dmarc=none action=none header.from=oracle.com;
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by BL0PR10MB3012.namprd10.prod.outlook.com (2603:10b6:208:72::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Mon, 14 Jun
 2021 15:45:51 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::78a3:67d:a8ca:93cf]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::78a3:67d:a8ca:93cf%7]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 15:45:51 +0000
Subject: Re: [PATCH] swiotlb-xen: override common mmap and get_sgtable dma ops
To: Roman Skakun <rm.skakun@gmail.com>
References: <20210611095528.9230-1-roman_skakun@epam.com>
 <855a58e2-1e03-4763-cb56-81367b73762c@oracle.com>
 <CADu_u-MqALJkG8RJHrr65vC_sHu-UyvCGwwUfaBong0eir5+hQ@mail.gmail.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <fbaeaad5-ea8a-ff2d-2e62-d27b4d234e8e@oracle.com>
Date: Mon, 14 Jun 2021 11:45:46 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <CADu_u-MqALJkG8RJHrr65vC_sHu-UyvCGwwUfaBong0eir5+hQ@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [138.3.201.21]
X-ClientProxiedBy: SN4PR0201CA0011.namprd02.prod.outlook.com
 (2603:10b6:803:2b::21) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.74.101.149] (138.3.201.21) by
 SN4PR0201CA0011.namprd02.prod.outlook.com (2603:10b6:803:2b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Mon, 14 Jun 2021 15:45:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c73d10f5-f84e-4ce3-76da-08d92f4b7cc8
X-MS-TrafficTypeDiagnostic: BL0PR10MB3012:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR10MB3012E0D08B2AF5A6AF0840388A319@BL0PR10MB3012.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ShpcMXAD8stzTvaXdEy4f2R5h6rHIPkC2l15hiXvbVbbrBVoqcvbZmzh2/EXQeBHXfEG/MU4CZKY56zZSlveJa55XvgB6VhJENBA3Qy3SyFsr8Y4vtvGMcYEqeue3UAjbTFZJQaCz8K69U+3alh64i4wVlutgryqs64iyuCcLlIEJ+/u53j6fkAreY3V2i5fTTd28yU8XAa8KRNZf/mHWokiN5saqVyHKm8sOpGHaBPJFKwGO3yLmEQgzkkaktMG6n5RsLQ63LWNyd068egQKt0HaLG6MD7xzGbnnzxOoCIBSSsqqG9CYDgt+YVvlHH9K6vw2ly5PYou/TC9Vd8lTUPn3R+ZIcGdKYbIDGHEdbhb7MJ2j4TQqim8dm6DyUjsPh8Y8E4aybykloJ5GuNqZQT0YyvL9fK3DtS/a/ErqQZvRh1y6TqFwS/Ce6lq0Am0ErBKahgjpf8WhQT1EQ+7XKg5iMEWGA12fws/rOaiuqMX1KEmUs/JucWOgLYryPUihlabrhwKyWNrvxpUZH8T8y1t/B+inJAS8W0XBosGxY3VZZ7i3913Iya4snHJqtGvrrm/uTKlRi9afkY09vrexDgk2f6RySaZ24632PL1VDTgxbvDBA7A8rpsYJuYJJ/oLnr8PAloJg419MDCpUBLV7NvG1YsBav1DxTCdGyhSRk7njwa43M+XZdOD6IFunH6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5009.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(376002)(396003)(366004)(136003)(39860400002)(53546011)(66556008)(66476007)(478600001)(38100700002)(16526019)(4326008)(31686004)(6666004)(31696002)(186003)(36756003)(86362001)(956004)(8936002)(316002)(2906002)(44832011)(83380400001)(5660300002)(26005)(66946007)(54906003)(6486002)(4744005)(16576012)(2616005)(6916009)(7416002)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SytyNWRNYi9FUDBnTjZPaHRxdWJnQWxQaFF0R2tHR1Q4S3VYWXlOY3AzTmJw?=
 =?utf-8?B?bnM0U0FuczBVd2NuVFdkM0s5aDI2ZXVuS2ZKR2dianM2cE5BRWdJVFB6eW9a?=
 =?utf-8?B?SDF0aEJLRDBBbEV3bk9zWXN6OVBaUG03L1FKQ2pLY1JXTHRqY1lTQ2NHaW1I?=
 =?utf-8?B?RGFiV2V5YWV0Yll4cllNdThVN2lCODVaSTVhZENSenNIenIrZkZ4K1pKRUxW?=
 =?utf-8?B?b05CQS95dzFlVUoza01oR01UUUN1RGJMdnMweG96QzcxbnpYVm5sZzJzT2tp?=
 =?utf-8?B?ekpqaW92M09oYmlBamt3QTdQL2w4a1Vmb3hBWW5FQXEyZk9GTUlHTDV0M2wx?=
 =?utf-8?B?bnZYUXEzN2tXamJTUkYxbEdBVGRIMTNsWDlqdHl1VFJOakJzOWswUUt1NE1h?=
 =?utf-8?B?d0FVNzZqYzlvK0hkTGo5LzdXTy85N1NoVlNyM0RhYVcwcmxWSzVPcld4WFA4?=
 =?utf-8?B?Vm5YcktFekRkdysra1l4RVRrRmdVLzRrNHFMSDVlOUdsWVd3UWtNaWFncGhS?=
 =?utf-8?B?RE1pWTNaS1h1UWdJd1RKaWxQMEpNUXVnVUpCdGlrRFNUaTZ6ZTJ1NjM2bXpi?=
 =?utf-8?B?NkZEdVJGVVJBZXcyYXFSRFQ1S1FyU01qM2dHOEJpMXk0bDdRaTk5TWcrYzR3?=
 =?utf-8?B?c0djcFdITlM2dXhmY3hJa2U5YXBteVdNS3EvSmwrbmFrZEU0ZzdqUFordXFS?=
 =?utf-8?B?RWQrRnZIOTkyTzJzK0NyRGVVUFZWWkdPM0diUzJYVS9KTkoxWGNRTW15MHcr?=
 =?utf-8?B?anV1RS93TkZpOEZXUDM3WEZUajJEMVc5aTdCTzBEc2VRYnRFWERWaXRwQ1M0?=
 =?utf-8?B?SW5tSm9oOWF2SEl1eURJclBCbjJmblZKQ3VCZG51VVEyU1JXT0VmS1pFNFBS?=
 =?utf-8?B?RWdHNWNMTitIY0lHYzVqS1NVVVp5TXpNSmlDV2E3Qi9QK3JnNGJKY0xYRjhE?=
 =?utf-8?B?UmpjQU9OcFZLZEJ1SlVuRGNXbmJCN3lDM0pURFY3RUVFWXVpZnkzRi85dW1K?=
 =?utf-8?B?K29iYythcjQzSGc3eWRxcm1YRFdRR2RTa2toYW1leW9tMml5TkJtYTU3SENt?=
 =?utf-8?B?Z1JheUFWakppTmJLWm13dHpvNXZTVG9PdjZ0anRGczJlSm1IVzkwREJCQzAr?=
 =?utf-8?B?ZzU5VjBZMTlCdHZoS0s1KzVzanBEbHpsRUxHUmN3ZXJnQmVrR2gxdUtzTExx?=
 =?utf-8?B?NTJqRUhlZmczWHI1TEp6OUs2UmFwOEttTEFOT0JLRS9RbTJqbHBmdTkzSTYw?=
 =?utf-8?B?bG84bGE3SFRJOGgyYkthdFpVVDhSVXpTakdtQnVNOG82ZFV2UFRvWC9QWWky?=
 =?utf-8?B?dldpamo3dUt6eWtPbFlqMWl1b2ZaQmRCTmVTSytlU1MzVm9DSGJFV01EOENa?=
 =?utf-8?B?VlJndktaMmRka2liWWFveFFyTzlibnZQbzVaVi9HS1R4UnVScGVpcndYTjFr?=
 =?utf-8?B?NmtZVkJoOU5raWxKQ0l2ZU5Zc1FoOFAvYTVWN2JvbVpsK0JFZjVPN0dmTFBp?=
 =?utf-8?B?bStYdkxUMmpQcEJvRmJKd1pJOWpyb1p0Y0pkV2l6eFJmdDFzMlBvbFlPTG5r?=
 =?utf-8?B?T2M1cWVSMUN3aEVWTjZsYldMMHVoRzdsMGd6YnBpa2liczNXcXBxWlRhWlpR?=
 =?utf-8?B?emxGUUtqazBkbU5GWm9tMWJoUnFCUHQ0RytXTTBSa0VyR1piSHhaRTRlVUFR?=
 =?utf-8?B?WXJLTUxjVzFSdWVmNGlMekMvdUZZbHJxV1NDVEVNbjBQdjNoVEVrS2o2bTNh?=
 =?utf-8?Q?th+CK8KAQIDqv8OWWjqSxre8Vy40OVFDmjSA2r7?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c73d10f5-f84e-4ce3-76da-08d92f4b7cc8
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 15:45:51.4630 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sAZtYjKeywxXLISzbKKdBtadpe4JDoIVIEwgOaOtjs9hGgGYbVhoEAOsCoMkqCADwLEMvk80dIOQ1ddaz0mwfLOlIK9bhqORByrQkb8RFtk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3012
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10015
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106140100
X-Proofpoint-ORIG-GUID: EGjVKAP4kx5qywM8t1DC1JU7_YyRKcqv
X-Proofpoint-GUID: EGjVKAP4kx5qywM8t1DC1JU7_YyRKcqv
Cc: Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Andrii Anisov <andrii_anisov@epam.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 linux-kernel@vger.kernel.org,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 iommu@lists.linux-foundation.org, Roman Skakun <roman_skakun@epam.com>,
 xen-devel@lists.xenproject.org, Volodymyr Babchuk <volodymyr_babchuk@epam.com>
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


On 6/14/21 8:47 AM, Roman Skakun wrote:
> Hey, Boris!
> Thanks for the review.
>
> I have an additional question about current implementation that disturbed me.
> I think, that we can have cases when mapped memory can not be
> physically contiguous.
> In order to proceed this correctly need to apply some additional steps
> to current implementation as well.
>
> In mmap() :
> 1. Is the memory region physically contiguous?
> 2. Remap multiple ranges if it is not.
>
> In get_sgtable() :
> 1. Is the memory region physically contiguous?
> 2. Create sgt that will be included multiple contiguous ranges if it is not.
>
> What do you think about it?


We make sure that we allocate contiguous memory in xen_swiotlb_alloc_coherent().


-boris


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
