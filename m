Return-Path: <SRS0=Ta7z=LP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A218C49EA2
	for <iommu@archiver.kernel.org>; Mon, 21 Jun 2021 17:52:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 224CA61245
	for <iommu@archiver.kernel.org>; Mon, 21 Jun 2021 17:52:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 224CA61245
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CA42E404A3;
	Mon, 21 Jun 2021 17:52:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1_vVyZmb0tvR; Mon, 21 Jun 2021 17:52:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4368D4046C;
	Mon, 21 Jun 2021 17:52:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17532C0010;
	Mon, 21 Jun 2021 17:52:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 92CBFC000C
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 17:52:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 728DD83A74
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 17:52:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="pixXMVv4";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="cpexIIlh"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z-gHAW8bvs0M for <iommu@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 17:52:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 22D2283A73
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 17:52:00 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 15LHgAmi026542; Mon, 21 Jun 2021 17:51:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=JJ1Z/8zt6zlP4m1heqj9ye3ufMZxAzpzycnpIFKLSdw=;
 b=pixXMVv4KIjwcOh+D7GXH6oBxZnVMBa3UWQJcfwT6Y9v9w5rUCZH7cTO+BjgHPkrUhQV
 fWk4JtM7pJsBeCi4t/D+zdCNW3R6J1c9uX77dj2xjdK+R01S7E8YRcSOEM26UOkf0nbw
 SQgC5V/6wukKM6FUQLzaC7Lkio8Z6kjnPnIqiKvVWgOjQPrAzvQqr0HITdj3pYsu+SMc
 7vlLVc1WOWDe7ZZTJZ0pn2/fOLzn2M6OvLAadPm2KpVuw8ESgQqE3ZF4MUN3FOLIoDnk
 3Cn4FV/7AAPQzCcGaya0QS/XRjPxTxbpIMOEt1LKvlYMz8vIcOkKD+3ButlUArHZHJFA tg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 39acyqa05a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Jun 2021 17:51:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15LHpCpQ135172;
 Mon, 21 Jun 2021 17:51:41 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1anam02lp2041.outbound.protection.outlook.com [104.47.57.41])
 by userp3030.oracle.com with ESMTP id 3995puxn2w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Jun 2021 17:51:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2L9omrTetO/Ndqwo2zzVkmfruWGoJtl7gwBWbkTTHaGQOctO78sWsqpew6PAR+6Uj/LI42aT6QlJg7aZQd2TMh1hax15i2RrrsE1L99PA1/dEC/aF+0JmgbI4ciGdo4reCgn46WEoAlBzQt34IXVBYZOteRjz/vYkh0TZpP2OVOdw+NMmP68wsdUM/LRU1g0bWvF5kuTz/MSrgeQjcyTaSseDY6otSFowRi582qafopWR9EjxXHhfo8uDq8pd4bqtJmxK4eudnXdSikMpwE+S5gPwZVscXN2udlSayEE1gD+08Ug2QI2BbuYFoBMdrdNUlPlQlyZedvAwSDJriNog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJ1Z/8zt6zlP4m1heqj9ye3ufMZxAzpzycnpIFKLSdw=;
 b=Gy7YKmqcSyoWKLtt9o+e+jOyKQ+8SmjRhiANfiBglMWCbX8e3Pko9wETrAWQ4vI82u8NmoeiHGo41vwF0vWxotF3dU6N/At5/p6BWe47kP3Vazq15iyRwpheUZo7DLVNFYYIqHGjlqN7gmAjdBaFsDDW/WCjVcDGcw43gtpUU8gaslBBaykMADMOU6y1ALxLVhbP3v8dsGX0L1r3hDQOnILOgAlbPcjtfQKUadVi4gyEGfD5jjGN2bimwoUiR5be+LyUmOGtFUGwRjsboeVsXYfL41PTxAez7Ml6rtO+6QxYQ28+TMAl0O0zvR7PjsMA9pvmFAD/LKHehSY+qfSPSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJ1Z/8zt6zlP4m1heqj9ye3ufMZxAzpzycnpIFKLSdw=;
 b=cpexIIlh2AfAe9BjlATjsi68DElGwthTQfmrQxXmvhqJzX2KEyGUzx56PGkdrKqCgNqCZHhp7YLxiXd4s5jNWURDkDK5IS7sqicCBKCOjzGIF36AmwZ8f5EpfQU0MEoBEy5eIrqqJhyQ5oMJ6SrFGrSpiTZQDtX0eB9hNlA7nP8=
Authentication-Results: googlegroups.com; dkim=none (message not signed)
 header.d=none;googlegroups.com; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BYAPR10MB2839.namprd10.prod.outlook.com (2603:10b6:a03:85::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Mon, 21 Jun
 2021 17:51:39 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e859:fa81:bf13:66b6]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e859:fa81:bf13:66b6%7]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 17:51:38 +0000
Subject: Re: [PATCH v2 12/12] iommu: Do not allow IOMMU passthrough with
 Secure Launch
To: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, iommu@lists.linux-foundation.org,
 linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org
References: <1624032777-7013-1-git-send-email-ross.philipson@oracle.com>
 <1624032777-7013-13-git-send-email-ross.philipson@oracle.com>
 <53edcf0e-c094-876c-ac3d-7c9752e9ea99@arm.com>
From: Ross Philipson <ross.philipson@oracle.com>
Message-ID: <34d05f0e-b24c-b8cf-c521-8b30cc1df532@oracle.com>
Date: Mon, 21 Jun 2021 13:51:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <53edcf0e-c094-876c-ac3d-7c9752e9ea99@arm.com>
Content-Language: en-US
X-Originating-IP: [209.17.40.46]
X-ClientProxiedBy: MN2PR20CA0019.namprd20.prod.outlook.com
 (2603:10b6:208:e8::32) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.106] (209.17.40.46) by
 MN2PR20CA0019.namprd20.prod.outlook.com (2603:10b6:208:e8::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.16 via Frontend Transport; Mon, 21 Jun 2021 17:51:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81f32813-648d-41d1-3656-08d934dd3852
X-MS-TrafficTypeDiagnostic: BYAPR10MB2839:
X-Microsoft-Antispam-PRVS: <BYAPR10MB28396C416F8B81AACB353DECE60A9@BYAPR10MB2839.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lArACPSUAWgRT45DSUjNMd95no7OgsDxJ7IXZH3s5wMRwtr7HNFEkpJxOAyTlZXAD/vUNHut2jbQbcMi6XZynrlbynXweZzhyfRuRQY6GZUJQaEM3K39bat6JylG5GyAysbKgz7Dn/FEnA6Xxq0UEjEgE7eXcUKcTFKBWaoxrN/5Stlan8YMb8WGqYbyH8UceheqDIPlY4i4yNI+fwT1qYKkIfkvsVOwyEA8Tigl4mxu8bmyvvDec3llcwGCZvEnIZ5qcPElB41ksGc+k9r7oIZhaQFqbQOgbIGOlVgKyXkz7vVjWzaSTVEFkCNwYggXrhG2HXoX2v/fRTe5dB7r0XSliFuEQS/o+goEIqQC4Ktuj9jbvdIEQb4FJ9ulfh6urpQikFK+/1XzV2dR878D61kEuLMXhKsvvBJ8kK60WT8P1HuS0/nlVFvCtSkABgGdHfh4Xfmb4xuDTchQ7vbiTGIL734IstBFKvoMnR7PcB8AjDXVesrh1c4wolBD+mvJwZAH7xHbRCFGK2VgpsrMYWdf8XXuDeaZM1zjMc7fwWPewPZefjD62sMMtgvJPVp/fMprS6e27JASkRlSVNSD4uNz78CA4qdT+fQ1pdhiF+yDM90uHe2LL4Un/BqiLL8vcRUFIF57og7hL0g3nPjHrBWkrYMR/HAgeCiaZsnhpA+8kZYp2MPOrW8RyUmTINfR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR10MB3793.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(346002)(136003)(39860400002)(376002)(366004)(316002)(83380400001)(16576012)(26005)(53546011)(8936002)(4326008)(6486002)(2906002)(86362001)(478600001)(956004)(66946007)(66556008)(8676002)(66476007)(36756003)(31696002)(38100700002)(2616005)(7416002)(16526019)(186003)(5660300002)(44832011)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmpOYnMzM0UvSU1jL3pUN1lML0xqdnRJWWpBbVdPT3BTY0R1Y1lwRm9iNmFy?=
 =?utf-8?B?RVlaQ2dLZkgrTUhiQnI3NTlielNTUlUvZWhVcGdhSStvRnI0WUpTU3NCMmpQ?=
 =?utf-8?B?L2hINUpiRnU0MG5GelBZQ0JkUC9KdnR2cHhZU2F3T3NMYVBIMThjcHZUV0E5?=
 =?utf-8?B?VWhzMmZ5S2xUY0Z0LzZsZmFUSVdHZ0YwREJlUFJWT2hWcGVBemRCTklBME1I?=
 =?utf-8?B?emZmSzVtRGVWQXVsdWxsOUVmMlF2djdwZnFHc1pHd01pUFlFa3BMTVpSdFB0?=
 =?utf-8?B?VmhZdXA3SDM5QThCeGxDV1RDMkRvNVZxZmRJL2NiUTFMZDdzUld5dWg4L0c0?=
 =?utf-8?B?QzRDSnM3U0swdFo2bm50bzZZdlhKeG4wTG83MGhoaERhKzBicDFoNlBTc09x?=
 =?utf-8?B?Rmk1Q3VpT2l5OHltTkpZNDNHZ3FXY1JZN0lENTZENVI5MDZTaGJwZzBMMHR6?=
 =?utf-8?B?TUE3SXhtb3hmQWM5V1o5SWwwOXFMWW81SDJkaWpCeHhYWnZzSmJYQjRjUWZk?=
 =?utf-8?B?UGRzQkRZd09jVmpoQVFKRklTQ1QxcnhaSm1VWDdkeVpiNTJ1NVhucjNwWjZF?=
 =?utf-8?B?VVpVN2pyOTBJQ3hvUUlMME83S0N4RjEzdjVld1RVNFQwYndURDVoKzZLRUt2?=
 =?utf-8?B?SlZQdHQ0S0RNM0dKLzJkSXRwemVMdDFnMGs5a2QrSW1EYmlzT0IzTFIxb2Za?=
 =?utf-8?B?eGFvUkRsZ29GSzFIdzNKME5yd3EwUHpkbjRndXAvVTJMb21OQkZydUR4cmdk?=
 =?utf-8?B?UXJRYnp5VTM4VWhFcmxiM3grTXJrMUVUc1hjM0xHNlhSK3VEMVlSdERjZmhK?=
 =?utf-8?B?dXJzVkJVWENDM01BdHVKZDMwd1NlYy9RRGxDZGVUekxxbWx6Kzc5L1ZxeE5J?=
 =?utf-8?B?cDQ2clRyaVNpdlZPTmUrQzhscG9Fc3VnanZkVGM3OTYzMURMZXBKc1FENjhx?=
 =?utf-8?B?NnVON0RyL2dCV2N3V3FEa0xKQ3ZDTUF1VXU4VlhGRmxUb1k4K3IreStjZjhk?=
 =?utf-8?B?dTdDVEM4a1pPZVJ2SzRRQlhHNmg3NUFRUVhUYjhhTktiRmkwMFdmRFVSRTRU?=
 =?utf-8?B?VFZHYTFIWVdpZ0JkWFptejFpN2pSZ2MrNVp4RUN2N2xLN3dMUlh2NnY0TUJL?=
 =?utf-8?B?N2VRNnRleGszWE11ZE1YMHdUUlNIUW5kanFCdG5WVkoyem5jM1Jqd3BUc3dB?=
 =?utf-8?B?Ulc5ZUZlZEhpSEwwMWZUNDk0MTRnenJpMVdBdm1yN1Z2eEtHMTZkWGdKdmNE?=
 =?utf-8?B?a1VVTHlTeVAyZDlpeHVicWlKMXYwd05HS0FQeVV5VCtQL2VIRTh5eExlU2c5?=
 =?utf-8?B?UWo1MkFNMWxCbVVEdUQxR2FWWUpFMWRCYmw3ZHdENHY3QzI4T3ZEVkdHbjBT?=
 =?utf-8?B?WkNBTjNkRGpjek01S0VIa1JnQW9NQi90MVlnZHJJOUZxSzdRUjdMODRNS0Fx?=
 =?utf-8?B?YlJ2MXVlWnpubnB5eWtuS0hqRzJ2QkxHT3hiQ0FzeHdGSnZSaEVuSW9IT1FD?=
 =?utf-8?B?cVUxS2VOYWUzQ0hMSjF1TmFxQlNmc1RLcjJ1M09EZDJYZXJWTTgrQkFNc3ox?=
 =?utf-8?B?dFN3RzlxZUJUYlJrNmtSMllmbm0xZDFzRzd3aUFkcGdtK1cxSFpRNlZLalU0?=
 =?utf-8?B?T0VNUGdZMERWUTdjd1VCakdQUTY1OU8yRUZrOUI4TXJ4WkdRR2t6Mjg5TEsw?=
 =?utf-8?B?em8rU1ZabWFabHdkdHdjN0ZEMEVES1FOOWxpN0x0RHhCSWJwMzRWanExaVlZ?=
 =?utf-8?Q?tw0DGj7SySINiK9k/zj4lpjPrqTQ5yqdwfmjQpa?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f32813-648d-41d1-3656-08d934dd3852
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 17:51:38.8153 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D4oskz+NUr2UiML0IMm5LY36HRq9O6qUtmfw+LQsE53jedqSUBYai/9xIXCE+gnLtKJl87Maad3/SY1ChJ94YNgqgqNF7lhVYDJcNaaiwa8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2839
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10022
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106210105
X-Proofpoint-GUID: dqtMx429LrGN5JBmBnFm9dBgIfUE1rT8
X-Proofpoint-ORIG-GUID: dqtMx429LrGN5JBmBnFm9dBgIfUE1rT8
Cc: dpsmith@apertussolutions.com, luto@amacapital.net, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, tglx@linutronix.de,
 trenchboot-devel@googlegroups.com
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

T24gNi8xOC8yMSAyOjMyIFBNLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4gT24gMjAyMS0wNi0xOCAx
NzoxMiwgUm9zcyBQaGlsaXBzb24gd3JvdGU6Cj4+IFRoZSBJT01NVSBzaG91bGQgYWx3YXlzIGJl
IHNldCB0byBkZWZhdWx0IHRyYW5zbGF0ZWQgdHlwZSBhZnRlcgo+PiB0aGUgUE1ScyBhcmUgZGlz
YWJsZWQgdG8gcHJvdGVjdCB0aGUgTUxFIGZyb20gRE1BLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBS
b3NzIFBoaWxpcHNvbiA8cm9zcy5waGlsaXBzb25Ab3JhY2xlLmNvbT4KPj4gLS0tCj4+IMKgIGRy
aXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYyB8IDUgKysrKysKPj4gwqAgZHJpdmVycy9pb21tdS9p
b21tdS5jwqDCoMKgwqDCoMKgIHwgNiArKysrKy0KPj4gwqAgMiBmaWxlcyBjaGFuZ2VkLCAxMCBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lv
bW11L2ludGVsL2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMKPj4gaW5kZXgg
YmUzNTI4NC4uNGYwMjU2ZCAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9pb21tdS9pbnRlbC9pb21t
dS5jCj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYwo+PiBAQCAtNDEsNiArNDEs
NyBAQAo+PiDCoCAjaW5jbHVkZSA8bGludXgvZG1hLWRpcmVjdC5oPgo+PiDCoCAjaW5jbHVkZSA8
bGludXgvY3Jhc2hfZHVtcC5oPgo+PiDCoCAjaW5jbHVkZSA8bGludXgvbnVtYS5oPgo+PiArI2lu
Y2x1ZGUgPGxpbnV4L3NsYXVuY2guaD4KPj4gwqAgI2luY2x1ZGUgPGFzbS9pcnFfcmVtYXBwaW5n
Lmg+Cj4+IMKgICNpbmNsdWRlIDxhc20vY2FjaGVmbHVzaC5oPgo+PiDCoCAjaW5jbHVkZSA8YXNt
L2lvbW11Lmg+Cj4+IEBAIC0yODc3LDYgKzI4NzgsMTAgQEAgc3RhdGljIGJvb2wgZGV2aWNlX2lz
X3JtcnJfbG9ja2VkKHN0cnVjdCBkZXZpY2UKPj4gKmRldikKPj4gwqDCoCAqLwo+PiDCoCBzdGF0
aWMgaW50IGRldmljZV9kZWZfZG9tYWluX3R5cGUoc3RydWN0IGRldmljZSAqZGV2KQo+PiDCoCB7
Cj4+ICvCoMKgwqAgLyogRG8gbm90IGFsbG93IGlkZW50aXR5IGRvbWFpbiB3aGVuIFNlY3VyZSBM
YXVuY2ggaXMgY29uZmlndXJlZCAqLwo+PiArwqDCoMKgIGlmIChzbGF1bmNoX2dldF9mbGFncygp
ICYgU0xfRkxBR19BQ1RJVkUpCj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gSU9NTVVfRE9NQUlO
X0RNQTsKPiAKPiBJcyB0aGlzIHNwZWNpZmljIHRvIEludGVsPyBJdCBzZWVtcyBsaWtlIGl0IGNv
dWxkIGVhc2lseSBiZSBkb25lCj4gY29tbW9ubHkgbGlrZSB0aGUgY2hlY2sgZm9yIHVudHJ1c3Rl
ZCBleHRlcm5hbCBkZXZpY2VzLgoKSXQgaXMgY3VycmVudGx5IEludGVsIG9ubHkgYnV0IHRoYXQg
d2lsbCBjaGFuZ2UuIEkgd2lsbCBsb29rIGludG8gd2hhdAp5b3Ugc3VnZ2VzdC4KCj4gCj4+ICsK
Pj4gwqDCoMKgwqDCoCBpZiAoZGV2X2lzX3BjaShkZXYpKSB7Cj4+IMKgwqDCoMKgwqDCoMKgwqDC
oCBzdHJ1Y3QgcGNpX2RldiAqcGRldiA9IHRvX3BjaV9kZXYoZGV2KTsKPj4gwqAgZGlmZiAtLWdp
dCBhL2RyaXZlcnMvaW9tbXUvaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvaW9tbXUuYwo+PiBpbmRl
eCA4MDhhYjcwZC4uZDQ5YjdkZCAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9pb21tdS9pb21tdS5j
Cj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW9tbXUuYwo+PiBAQCAtMjMsNiArMjMsNyBAQAo+PiDC
oCAjaW5jbHVkZSA8bGludXgvcHJvcGVydHkuaD4KPj4gwqAgI2luY2x1ZGUgPGxpbnV4L2ZzbC9t
Yy5oPgo+PiDCoCAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+Cj4+ICsjaW5jbHVkZSA8bGludXgv
c2xhdW5jaC5oPgo+PiDCoCAjaW5jbHVkZSA8dHJhY2UvZXZlbnRzL2lvbW11Lmg+Cj4+IMKgIMKg
IHN0YXRpYyBzdHJ1Y3Qga3NldCAqaW9tbXVfZ3JvdXBfa3NldDsKPj4gQEAgLTI3NjEsNyArMjc2
MiwxMCBAQCB2b2lkIGlvbW11X3NldF9kZWZhdWx0X3Bhc3N0aHJvdWdoKGJvb2wgY21kX2xpbmUp
Cj4+IMKgIHsKPj4gwqDCoMKgwqDCoCBpZiAoY21kX2xpbmUpCj4+IMKgwqDCoMKgwqDCoMKgwqDC
oCBpb21tdV9jbWRfbGluZSB8PSBJT01NVV9DTURfTElORV9ETUFfQVBJOwo+PiAtwqDCoMKgIGlv
bW11X2RlZl9kb21haW5fdHlwZSA9IElPTU1VX0RPTUFJTl9JREVOVElUWTsKPj4gKwo+PiArwqDC
oMKgIC8qIERvIG5vdCBhbGxvdyBpZGVudGl0eSBkb21haW4gd2hlbiBTZWN1cmUgTGF1bmNoIGlz
IGNvbmZpZ3VyZWQgKi8KPj4gK8KgwqDCoCBpZiAoIShzbGF1bmNoX2dldF9mbGFncygpICYgU0xf
RkxBR19BQ1RJVkUpKQo+PiArwqDCoMKgwqDCoMKgwqAgaW9tbXVfZGVmX2RvbWFpbl90eXBlID0g
SU9NTVVfRE9NQUlOX0lERU5USVRZOwo+IAo+IFF1aWV0bHkgaWdub3JpbmcgdGhlIHNldHRpbmcg
YW5kIHBvc3NpYmx5IGxlYXZpbmcgaW9tbXVfZGVmX2RvbWFpbl90eXBlCj4gdW5pbml0aWFsaXNl
ZCAobm90ZSB0aGF0IDAgaXMgbm90IGFjdHVhbGx5IGEgdXNhYmxlIHR5cGUpIGRvZXNuJ3Qgc2Vl
bQo+IGdyZWF0LiBBRkFJQ1MgdGhpcyBwcm9iYWJseSB3YXJyYW50cyBzaW1pbGFyIHRyZWF0bWVu
dCB0byB0aGUKCk9rIHNvIEkgZ3Vlc3MgaXQgd291bGQgYmUgYmV0dGVyIHRvIHNldCBpdCB0byBJ
T01NVV9ET01BSU5fRE1BIGV2ZW50CnRob3VnaCBwYXNzdGhyb3VnaCB3YXMgcmVxdWVzdGVkLiBP
ciBwZXJoYXBzIHNvbWV0aGluZyBtb3JlIGlzIG5lZWRlZCBoZXJlPwoKPiBtZW1fZW5jcnlwdF9h
Y3RpdmUoKSBjYXNlIC0gdGhlcmUgZG9lc24ndCBzZWVtIGEgZ3JlYXQgZGVhbCBvZiB2YWx1ZSBp
bgo+IHRyeWluZyB0byBzYXZlIHVzZXJzIGZyb20gdGhlbXNlbHZlcyBpZiB0aGV5IGNhcmUgYWJv
dXQgbWVhc3VyZWQgYm9vdAo+IHlldCBleHBsaWNpdGx5IHBhc3Mgb3B0aW9ucyB3aGljaCBtYXkg
Y29tcHJvbWlzZSBtZWFzdXJlZCBib290LiBJZiB5b3UKPiByZWFsbHkgd2FudCB0byBnbyBkb3du
IHRoYXQgcm91dGUgdGhlcmUncyBhdCBsZWFzdCB0aGUgc3lzZnMgaW50ZXJmYWNlCj4geW91J2Qg
bmVlZCB0byBub2JibGUgYXMgd2VsbCwgbm90IHRvIG1lbnRpb24gdGhlIHZhcmlvdXMgd2F5cyBv
Zgo+IGNvbXBsZXRlbHkgZGlzYWJsaW5nIElPTU1Vcy4uLgoKRG9pbmcgYSBzZWN1cmUgbGF1bmNo
IHdpdGggdGhlIGtlcm5lbCBpcyBub3QgYSBnZW5lcmFsIHB1cnBvc2UgdXNlciB1c2UKY2FzZS4g
QSBsb3Qgb2Ygd29yayBpcyBkb25lIHRvIHNlY3VyZSB0aGUgZW52aXJvbm1lbnQuIEFsbG93aW5n
CnBhc3N0aHJvdWdoIG1vZGUgd291bGQgbGVhdmUgdGhlIHNlY3VyZSBsYXVuY2gga2VybmVsIGV4
cG9zZWQgdG8gRE1BLiBJCnRoaW5rIHdoYXQgd2UgYXJlIHRyeWluZyB0byBkbyBoZXJlIGlzIHdo
YXQgd2UgaW50ZW5kIHRob3VnaCB0aGVyZSBtYXkKYmUgYSBiZXR0ZXIgd2F5IG9yIHBlcmhhcHMg
aXQgaXMgaW5jb21wbGV0ZSBhcyB5b3Ugc3VnZ2VzdC4KCj4gCj4gSXQgbWlnaHQgYmUgcmVhc29u
YWJsZSB0byBtYWtlIElPTU1VX0RFRkFVTFRfUEFTU1RIUk9VR0ggZGVwZW5kIG9uCj4gIVNFQ1VS
RV9MQVVOQ0ggZm9yIGNsYXJpdHkgdGhvdWdoLgoKVGhpcyBjYW1lIGZyb20gYSBzcGVjaWZpYyBy
ZXF1ZXN0IHRvIG5vdCBtYWtlIGRpc2FibGluZyBJT01NVSBtb2RlcwpidWlsZCB0aW1lIGRlcGVu
ZGVudC4gVGhpcyBpcyBiZWNhdXNlIGEgc2VjdXJlIGxhdW5jaCBlbmFibGVkIGtlcm5lbCBjYW4K
YWxzbyBiZSBib290ZWQgYXMgYSBnZW5lcmFsIHB1cnBvc2Uga2VybmVsIGluIGNhc2VzIHdoZXJl
IHRoaXMgaXMgZGVzaXJlZC4KClRoYW5rIHlvdSwKUm9zcwoKPiAKPiBSb2Jpbi4KPiAKPj4gwqAg
fQo+PiDCoCDCoCB2b2lkIGlvbW11X3NldF9kZWZhdWx0X3RyYW5zbGF0ZWQoYm9vbCBjbWRfbGlu
ZSkKPj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlv
bW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
