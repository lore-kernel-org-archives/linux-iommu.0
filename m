Return-Path: <SRS0=eogA=LY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C28C11F6B
	for <iommu@archiver.kernel.org>; Wed, 30 Jun 2021 09:47:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A533161D23
	for <iommu@archiver.kernel.org>; Wed, 30 Jun 2021 09:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A533161D23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6DBEC608C5;
	Wed, 30 Jun 2021 09:47:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id STzVd92HFUe8; Wed, 30 Jun 2021 09:47:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1853760A5D;
	Wed, 30 Jun 2021 09:47:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9012C0010;
	Wed, 30 Jun 2021 09:47:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10EB2C000E
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 09:47:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 82C3982BC8
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 09:47:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="IwebSOLh";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="Ey7G5BQ0"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5mkBJp6PcmST for <iommu@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 09:47:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 17601827AA
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 09:47:37 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 15U9l9lw016678; Wed, 30 Jun 2021 09:47:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=dT03i8scFTSa0UNwFfb5i8xwsLZ+UhjA+Ma/qTmmONk=;
 b=IwebSOLhjxrO7/poD4DJQws9XKYKfo9qRIi4XgFSg4OZ2kP8w9cKslZxc3xsYJ/54SIs
 VWlawFF9vtzFnr0nV6HspfDAULkypONK/ek2GQ7gRiZZvy1jpg0Izo1VFr65PGlSo6nN
 2J6i6Px1/jGR3uU3mn/l5N7Rl4e7wWxHqb9DmOQJnfg6HRZXRM+vh35Ydx9KgwHYkw9Z
 kcm6AQkDBb+Jh1hpH7qzDtrewp6cAMo9Lc6Muuf71bHdlJTEUekkec68SC94mNE3K2Jt
 UkgWrr8YtrY0jTwA3f2G75651rqyqCCb0ObFPzi9u1w95Q8Qs8QAi5Is6Rf6gAfnWWqn 6g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 39f6y3nkjh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Jun 2021 09:47:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15U9kOMU143389;
 Wed, 30 Jun 2021 09:47:13 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
 by aserp3030.oracle.com with ESMTP id 39dt9grfpd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Jun 2021 09:47:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iXKGUS7yQEqBwKQ0hAKA85cl0M9F9XN1N/CgT8puh2x0a5+TjbqsaDg41gJS7KDaCEKU/XME9bms6wTa0DCS/IayRHfRiF5kEN+scBaHCG8p9GYdibVL9QE8rmexsBKmvfV9tiYJP/cDhprvOAvid3iw2jGcoVTxHVrhhGvVi0FN1zgy+Lni9vLeclrXAadwhZW168sbonnz4KCK5s6xJswNkBDcIVAsqEZ7fBNJWT2PXCNr9mLK8gpMU3Gd3xyYP6mMg+idS4NIQK4ntFRD8Uxw1kxm1xwXKbKO6FhfiH1JJIdcWs61+lYKeyEs8KaV+qqTcezvj5TImBrrZU4QvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dT03i8scFTSa0UNwFfb5i8xwsLZ+UhjA+Ma/qTmmONk=;
 b=WTclpzddbzLf+XoNwQinOCoYSP9Yk+TxiBH4V926ef5DAC4Ic+XtjDHZD+gqm+EovFdrQDwv2n/iWYiGVG6kNNQPnUStAG3JSxYDLBbitPZc4W8VifvtkAflKNWlkk7TqDUfHxHu9JlZQBhFoP8q/ZIb4WY7dEJinhAIdP+y34TaI05w3QTg24OvWQ1pqfNFYigvkou9NuaUp+YZ4pyOF1WYCd6YW8GEliS9Lww7l/3nsYY6y65FBN/HfG27grHjRrufas9Bgoy7c7Sadvb4I/Ruo4Kcy0dNHsatKR0ZuxXnYNfc5N0GiNxEFa0HJtg66szMxDwHVyXTmWnpH7ZhsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dT03i8scFTSa0UNwFfb5i8xwsLZ+UhjA+Ma/qTmmONk=;
 b=Ey7G5BQ0Dqqy24dJX/mEhKGjuuHenmeB/MLxzjfTmMRcolGeWeUftlDY2igWLJmR5gZtAHXv2YRj6DLYuUm5lUZTM86264ys+hCV9fMH2yScZSrVrkR7O13QHeffYCjjJrUEEho0OAxGHzOIClrLcOacTi3F1NHSnAdXVeE39Tc=
Authentication-Results: googlegroups.com; dkim=none (message not signed)
 header.d=none;googlegroups.com; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BYAPR10MB3430.namprd10.prod.outlook.com (2603:10b6:a03:8f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Wed, 30 Jun
 2021 09:47:11 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e859:fa81:bf13:66b6]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e859:fa81:bf13:66b6%7]) with mapi id 15.20.4287.022; Wed, 30 Jun 2021
 09:47:11 +0000
Subject: Re: [PATCH v2 12/12] iommu: Do not allow IOMMU passthrough with
 Secure Launch
To: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, iommu@lists.linux-foundation.org,
 linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org
References: <1624032777-7013-1-git-send-email-ross.philipson@oracle.com>
 <1624032777-7013-13-git-send-email-ross.philipson@oracle.com>
 <53edcf0e-c094-876c-ac3d-7c9752e9ea99@arm.com>
 <34d05f0e-b24c-b8cf-c521-8b30cc1df532@oracle.com>
 <8376f5ec-f228-0e82-a032-401f91b6aa3b@arm.com>
From: Ross Philipson <ross.philipson@oracle.com>
Message-ID: <d97164e4-b776-0efe-d243-8a71b085d897@oracle.com>
Date: Wed, 30 Jun 2021 05:47:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <8376f5ec-f228-0e82-a032-401f91b6aa3b@arm.com>
Content-Language: en-US
X-Originating-IP: [2601:191:8500:cff0::722e]
X-ClientProxiedBy: BLAPR03CA0133.namprd03.prod.outlook.com
 (2603:10b6:208:32e::18) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2601:191:8500:cff0::722e] (2601:191:8500:cff0::722e) by
 BLAPR03CA0133.namprd03.prod.outlook.com (2603:10b6:208:32e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend
 Transport; Wed, 30 Jun 2021 09:47:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a82440f-7ff6-45f8-ade0-08d93bac0879
X-MS-TrafficTypeDiagnostic: BYAPR10MB3430:
X-Microsoft-Antispam-PRVS: <BYAPR10MB34302BA53A92617A595DB04CE6019@BYAPR10MB3430.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xCjxrnc0Dm0aVXfdCOnYVNajK3bd7KmpWECD9dU9bgCrkKSkYVjFhbzj5JrQzvAIkshR/PNy3q2lr4oBAS+sRm75lSIe5hJYO16Gu7/IgeoxZ1T5xtlPkwfaoQRsfXfNfgJCeB9gJaeG3iGpwbniNBxOOQuamsquCrqz4YnwFtB0vM2x0powb1wOVXdMBESSyNjfZl/kt0gc/MtIkm10yVLVpI0aoLugyvrfWW3g2FWnQIDUoRA/skLAnpzoilOyh+zn+jkc3svLdhTql2W6iBSZTIVz7zytvd4SEuaFKkqbIWGZfhNYaq60IFya4mnvTKHNLmyUTYK+Be7UKKuXtIcOUnamAsUAo8fcfHOpHIttcRybl6gd3TVKyzTLN+rvgjHV0oko+DeIDdZkbqrfT8V7zmWrgrEN3UiUsuuke6LWecf7T5J6r5hz2S1npAxgV5qCKss9Spj7DO5NbPiAZqe0P+WnoxLnfX/4nxCtG+Vti7nWGYSm6wXgvfLohGE3gT2oKfop877htSpz8utgT8uaThmTFjpcf6VKaO2f4utMa/aoR7x+ZnWdEdw35DpSZmY1xImhAIaUAKgIqOD8HMEv7ko0aRi8BDtJYiZsVJm30/dTLU/tyPKTsPRqT9tyrHjGpc72NjOtf7C9pujqzGRcdBZ3ib1DvCKSf/NSA05xhNgSX0v5lSoIrXtNb1auivmVEw3uzakyiStNhqJtd5pSfAFkz2SxxTXVj0MjE08=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR10MB3793.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(136003)(39860400002)(366004)(376002)(396003)(53546011)(186003)(16526019)(38100700002)(7416002)(86362001)(83380400001)(4326008)(31696002)(66556008)(66476007)(66946007)(44832011)(36756003)(316002)(31686004)(5660300002)(2616005)(6486002)(478600001)(8676002)(2906002)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QldsNWJZbHFQRXB1MlFPWnZTR3o4aXNTOXJDY0EwbkJTOW9jeXRwdVRCSEJx?=
 =?utf-8?B?dzJmL0JpMXZsRmJyMGNZSndZWEFBYXdUMkdlNkxoTzFXRldSb1BYajFnUnk2?=
 =?utf-8?B?Nm9WS3dQUzZpZVNIdUxzNzUxM0p3Qm5QV1hGb29lQUhndWFTMjRWQnlEWVhq?=
 =?utf-8?B?ellBWXhjVi9pZERkZUZHL0I4dkZGamkwc2tpckZDZUVtbjN0TDRoeDFDeXc1?=
 =?utf-8?B?TFhhUTlVbklJdSt0YnRZL2YzdE9nOXlnaDQ2MVltVU83akhrUmN1RUhqcUlF?=
 =?utf-8?B?VDIwR2x3WEExNmVMWmdIQkYvM2JNeUtWMC9IUGZDbWNXUld5bHdZYW1ucGti?=
 =?utf-8?B?cjlBR0NaR29BVTJJd0RBTXFwK3R5ZmJLNXE2cXdkb0VCMDBXWjlwZHV2UE9L?=
 =?utf-8?B?VFV1aGdScDYzRXBObGZPL3JNUDRYejVTNWwyYVg0TjlIWEtpOHFaSEd3UUtF?=
 =?utf-8?B?UFZhQzRtRzE1ZklPVTVDUTlsWXZsNE13TTVRZDJnMW5xdXlsWHN6QThzZUdt?=
 =?utf-8?B?ZDlzY3VQZ0tMb2I5MTFXd1JIVWNPZXMvMnhLMlMwUXZuR0F4TDYvTSsvekdk?=
 =?utf-8?B?bUNTc202QzJCNTJIN3RlaTJSTFExNUJvREJZRlZlUlFmY1pjNkZuZ1JOSDRX?=
 =?utf-8?B?M0Zkc2VjaE5WWXFKbzFJdEFTVEhlTXowNm1CR3NsdHRKbThWWVFjRHdISVlT?=
 =?utf-8?B?RC9iazB3d3BRYXB4YXlzY1lvbzdiYWcrMFhJZHd1Zm5Ra0JTYWhwampVZzMv?=
 =?utf-8?B?eFRXcUwzYTRhRlRnOEFTSXhRb0ptSnV5d21LZnBMVzhYR0I5UUFFbW5rTDJV?=
 =?utf-8?B?SS8zWEFoeEdpL1ZTUTVQbTJOSVZrV3dQaFhZL0JjRDZYVnZ5d3JBODNDMUs3?=
 =?utf-8?B?dHhJWXBOMXZrYzczbEVPM051NFRudkVZN2dhUkRlbmVjK2dnbTlaMkVlVnlF?=
 =?utf-8?B?NTlTZjJQQUlhczFjQ1BhVW4wc0hnRGUydUNCN1VIM0hkUkgxQnovUXYvdEVN?=
 =?utf-8?B?QXFhUVArSlRHblBKcU1YMWc2Q0JwdmFVUWFLRm41bHZIRHZPWW1PR2c5VEQ0?=
 =?utf-8?B?ZnpUNHh0UWNtUTF1U3NzYnlJZEtTZ1QvSEQxSStUdXFYaFE1TGZhcmxTMjI2?=
 =?utf-8?B?V2hxeHR1TWZrWlBjcUVsZTJaN0FUWTRNQ1RUS21kajJua3hMc0dhbm9LSlp3?=
 =?utf-8?B?a2JGZUVXVTYwekN0T0FTdk5SN2E0OUlXd3Rwa2Rjd1pxMlNoZVF2QStnMHU0?=
 =?utf-8?B?MGg5K2lQd1pXOUl4SUZCODRWN1VxTDBQQVBBeHNCOWNSVkEybEVxUm5TYnNM?=
 =?utf-8?B?dFhvQkdvc285ZWtxUWlLTklKS1R2MlBjTTFMMlNuQnQ1TW5qU2c3emNsSnJl?=
 =?utf-8?B?M3ZXRkdqeG5RZEcyRWw5QzNKNXZVclJ1MnliUGFYR0MzRncvK2VGbVBmY2tC?=
 =?utf-8?B?bkNYQjZVNlJMT0VRTUhQOTRzU3VSOEhtaHNSejExMmZpL1lDR1VZWHBxNDc0?=
 =?utf-8?B?bDhWNlhIU1Y0SC9iYzFNSnN1MFllYjdQNXFWempoRmRjWXhNYWJZM1Uxaktv?=
 =?utf-8?B?U3NHeWs2MGNTaUdwMEFSdlMySDFMcG1IcWZ6eGhlVHNwMTJrMU1WTEY5NGRZ?=
 =?utf-8?B?cDE5M0ViK1pwNWVoUk1mK0VnZzZJTFEvTm1qdUF1THRXUGZCNlN1ajdVdHNW?=
 =?utf-8?B?NVFic2xxbGg2QjU3MWVuaHYzTTZoR1dGc0p6ZmJodTdKR0YrY1dudVRJa3VX?=
 =?utf-8?B?L25OUnQzWU9hMlI5QWF2cko5TDZNU3VDTHJPZ3FES1d4cU1rNVRoNXJ2VkY5?=
 =?utf-8?B?K2ZjTFFLN2dLSXIyMHVndz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a82440f-7ff6-45f8-ade0-08d93bac0879
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 09:47:11.3960 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fN8dKYNi9pTLLWg5M+aTYQj8rsp/Vvt3niXvpzGe6YbQCJFqYIDJHFW8WE2bgIWDOVK4gC1J1naMQ3vyjT2Tul31PCifD1NxHAQgKAkX5ww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3430
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10030
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106300063
X-Proofpoint-GUID: lWlbXib7r8eQ2zn5B1Wj7izu56EIquq7
X-Proofpoint-ORIG-GUID: lWlbXib7r8eQ2zn5B1Wj7izu56EIquq7
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gNi8yMi8yMSA3OjA2IEFNLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4gT24gMjAyMS0wNi0yMSAx
ODo1MSwgUm9zcyBQaGlsaXBzb24gd3JvdGU6Cj4+IE9uIDYvMTgvMjEgMjozMiBQTSwgUm9iaW4g
TXVycGh5IHdyb3RlOgo+Pj4gT24gMjAyMS0wNi0xOCAxNzoxMiwgUm9zcyBQaGlsaXBzb24gd3Jv
dGU6Cj4+Pj4gVGhlIElPTU1VIHNob3VsZCBhbHdheXMgYmUgc2V0IHRvIGRlZmF1bHQgdHJhbnNs
YXRlZCB0eXBlIGFmdGVyCj4+Pj4gdGhlIFBNUnMgYXJlIGRpc2FibGVkIHRvIHByb3RlY3QgdGhl
IE1MRSBmcm9tIERNQS4KPj4+Pgo+Pj4+IFNpZ25lZC1vZmYtYnk6IFJvc3MgUGhpbGlwc29uIDxy
b3NzLnBoaWxpcHNvbkBvcmFjbGUuY29tPgo+Pj4+IC0tLQo+Pj4+IMKgwqAgZHJpdmVycy9pb21t
dS9pbnRlbC9pb21tdS5jIHwgNSArKysrKwo+Pj4+IMKgwqAgZHJpdmVycy9pb21tdS9pb21tdS5j
wqDCoMKgwqDCoMKgIHwgNiArKysrKy0KPj4+PiDCoMKgIDIgZmlsZXMgY2hhbmdlZCwgMTAgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Pj4+Cj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
aW9tbXUvaW50ZWwvaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYwo+Pj4+IGlu
ZGV4IGJlMzUyODQuLjRmMDI1NmQgMTAwNjQ0Cj4+Pj4gLS0tIGEvZHJpdmVycy9pb21tdS9pbnRl
bC9pb21tdS5jCj4+Pj4gKysrIGIvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jCj4+Pj4gQEAg
LTQxLDYgKzQxLDcgQEAKPj4+PiDCoMKgICNpbmNsdWRlIDxsaW51eC9kbWEtZGlyZWN0Lmg+Cj4+
Pj4gwqDCoCAjaW5jbHVkZSA8bGludXgvY3Jhc2hfZHVtcC5oPgo+Pj4+IMKgwqAgI2luY2x1ZGUg
PGxpbnV4L251bWEuaD4KPj4+PiArI2luY2x1ZGUgPGxpbnV4L3NsYXVuY2guaD4KPj4+PiDCoMKg
ICNpbmNsdWRlIDxhc20vaXJxX3JlbWFwcGluZy5oPgo+Pj4+IMKgwqAgI2luY2x1ZGUgPGFzbS9j
YWNoZWZsdXNoLmg+Cj4+Pj4gwqDCoCAjaW5jbHVkZSA8YXNtL2lvbW11Lmg+Cj4+Pj4gQEAgLTI4
NzcsNiArMjg3OCwxMCBAQCBzdGF0aWMgYm9vbCBkZXZpY2VfaXNfcm1ycl9sb2NrZWQoc3RydWN0
IGRldmljZQo+Pj4+ICpkZXYpCj4+Pj4gwqDCoMKgICovCj4+Pj4gwqDCoCBzdGF0aWMgaW50IGRl
dmljZV9kZWZfZG9tYWluX3R5cGUoc3RydWN0IGRldmljZSAqZGV2KQo+Pj4+IMKgwqAgewo+Pj4+
ICvCoMKgwqAgLyogRG8gbm90IGFsbG93IGlkZW50aXR5IGRvbWFpbiB3aGVuIFNlY3VyZSBMYXVu
Y2ggaXMgCj4+Pj4gY29uZmlndXJlZCAqLwo+Pj4+ICvCoMKgwqAgaWYgKHNsYXVuY2hfZ2V0X2Zs
YWdzKCkgJiBTTF9GTEFHX0FDVElWRSkKPj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIElPTU1V
X0RPTUFJTl9ETUE7Cj4+Pgo+Pj4gSXMgdGhpcyBzcGVjaWZpYyB0byBJbnRlbD8gSXQgc2VlbXMg
bGlrZSBpdCBjb3VsZCBlYXNpbHkgYmUgZG9uZQo+Pj4gY29tbW9ubHkgbGlrZSB0aGUgY2hlY2sg
Zm9yIHVudHJ1c3RlZCBleHRlcm5hbCBkZXZpY2VzLgo+Pgo+PiBJdCBpcyBjdXJyZW50bHkgSW50
ZWwgb25seSBidXQgdGhhdCB3aWxsIGNoYW5nZS4gSSB3aWxsIGxvb2sgaW50byB3aGF0Cj4+IHlv
dSBzdWdnZXN0Lgo+IAo+IFllYWgsIGl0J3Mgc2ltcGxlIGFuZCB1bm9idHJ1c2l2ZSBlbm91Z2gg
dGhhdCBJIHJlY2tvbiBpdCdzIHdvcnRoIGdvaW5nIAo+IHN0cmFpZ2h0IHRvIHRoZSBjb21tb24g
dmVyc2lvbiBpZiBpdCdzIHdvcnRoIGRvaW5nIGF0IGFsbC4KPiAKPj4+PiArCj4+Pj4gwqDCoMKg
wqDCoMKgIGlmIChkZXZfaXNfcGNpKGRldikpIHsKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCBz
dHJ1Y3QgcGNpX2RldiAqcGRldiA9IHRvX3BjaV9kZXYoZGV2KTsKPj4+PiDCoMKgIGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2lvbW11L2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L2lvbW11LmMKPj4+PiBp
bmRleCA4MDhhYjcwZC4uZDQ5YjdkZCAxMDA2NDQKPj4+PiAtLS0gYS9kcml2ZXJzL2lvbW11L2lv
bW11LmMKPj4+PiArKysgYi9kcml2ZXJzL2lvbW11L2lvbW11LmMKPj4+PiBAQCAtMjMsNiArMjMs
NyBAQAo+Pj4+IMKgwqAgI2luY2x1ZGUgPGxpbnV4L3Byb3BlcnR5Lmg+Cj4+Pj4gwqDCoCAjaW5j
bHVkZSA8bGludXgvZnNsL21jLmg+Cj4+Pj4gwqDCoCAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+
Cj4+Pj4gKyNpbmNsdWRlIDxsaW51eC9zbGF1bmNoLmg+Cj4+Pj4gwqDCoCAjaW5jbHVkZSA8dHJh
Y2UvZXZlbnRzL2lvbW11Lmg+Cj4+Pj4gwqDCoCDCoCBzdGF0aWMgc3RydWN0IGtzZXQgKmlvbW11
X2dyb3VwX2tzZXQ7Cj4+Pj4gQEAgLTI3NjEsNyArMjc2MiwxMCBAQCB2b2lkIGlvbW11X3NldF9k
ZWZhdWx0X3Bhc3N0aHJvdWdoKGJvb2wgCj4+Pj4gY21kX2xpbmUpCj4+Pj4gwqDCoCB7Cj4+Pj4g
wqDCoMKgwqDCoMKgIGlmIChjbWRfbGluZSkKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpb21t
dV9jbWRfbGluZSB8PSBJT01NVV9DTURfTElORV9ETUFfQVBJOwo+Pj4+IC3CoMKgwqAgaW9tbXVf
ZGVmX2RvbWFpbl90eXBlID0gSU9NTVVfRE9NQUlOX0lERU5USVRZOwo+Pj4+ICsKPj4+PiArwqDC
oMKgIC8qIERvIG5vdCBhbGxvdyBpZGVudGl0eSBkb21haW4gd2hlbiBTZWN1cmUgTGF1bmNoIGlz
IAo+Pj4+IGNvbmZpZ3VyZWQgKi8KPj4+PiArwqDCoMKgIGlmICghKHNsYXVuY2hfZ2V0X2ZsYWdz
KCkgJiBTTF9GTEFHX0FDVElWRSkpCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGlvbW11X2RlZl9kb21h
aW5fdHlwZSA9IElPTU1VX0RPTUFJTl9JREVOVElUWTsKPj4+Cj4+PiBRdWlldGx5IGlnbm9yaW5n
IHRoZSBzZXR0aW5nIGFuZCBwb3NzaWJseSBsZWF2aW5nIGlvbW11X2RlZl9kb21haW5fdHlwZQo+
Pj4gdW5pbml0aWFsaXNlZCAobm90ZSB0aGF0IDAgaXMgbm90IGFjdHVhbGx5IGEgdXNhYmxlIHR5
cGUpIGRvZXNuJ3Qgc2VlbQo+Pj4gZ3JlYXQuIEFGQUlDUyB0aGlzIHByb2JhYmx5IHdhcnJhbnRz
IHNpbWlsYXIgdHJlYXRtZW50IHRvIHRoZQo+Pgo+PiBPayBzbyBJIGd1ZXNzIGl0IHdvdWxkIGJl
IGJldHRlciB0byBzZXQgaXQgdG8gSU9NTVVfRE9NQUlOX0RNQSBldmVudAo+PiB0aG91Z2ggcGFz
c3Rocm91Z2ggd2FzIHJlcXVlc3RlZC4gT3IgcGVyaGFwcyBzb21ldGhpbmcgbW9yZSBpcyBuZWVk
ZWQgCj4+IGhlcmU/Cj4+Cj4+PiBtZW1fZW5jcnlwdF9hY3RpdmUoKSBjYXNlIC0gdGhlcmUgZG9l
c24ndCBzZWVtIGEgZ3JlYXQgZGVhbCBvZiB2YWx1ZSBpbgo+Pj4gdHJ5aW5nIHRvIHNhdmUgdXNl
cnMgZnJvbSB0aGVtc2VsdmVzIGlmIHRoZXkgY2FyZSBhYm91dCBtZWFzdXJlZCBib290Cj4+PiB5
ZXQgZXhwbGljaXRseSBwYXNzIG9wdGlvbnMgd2hpY2ggbWF5IGNvbXByb21pc2UgbWVhc3VyZWQg
Ym9vdC4gSWYgeW91Cj4+PiByZWFsbHkgd2FudCB0byBnbyBkb3duIHRoYXQgcm91dGUgdGhlcmUn
cyBhdCBsZWFzdCB0aGUgc3lzZnMgaW50ZXJmYWNlCj4+PiB5b3UnZCBuZWVkIHRvIG5vYmJsZSBh
cyB3ZWxsLCBub3QgdG8gbWVudGlvbiB0aGUgdmFyaW91cyB3YXlzIG9mCj4+PiBjb21wbGV0ZWx5
IGRpc2FibGluZyBJT01NVXMuLi4KPj4KPj4gRG9pbmcgYSBzZWN1cmUgbGF1bmNoIHdpdGggdGhl
IGtlcm5lbCBpcyBub3QgYSBnZW5lcmFsIHB1cnBvc2UgdXNlciB1c2UKPj4gY2FzZS4gQSBsb3Qg
b2Ygd29yayBpcyBkb25lIHRvIHNlY3VyZSB0aGUgZW52aXJvbm1lbnQuIEFsbG93aW5nCj4+IHBh
c3N0aHJvdWdoIG1vZGUgd291bGQgbGVhdmUgdGhlIHNlY3VyZSBsYXVuY2gga2VybmVsIGV4cG9z
ZWQgdG8gRE1BLiBJCj4+IHRoaW5rIHdoYXQgd2UgYXJlIHRyeWluZyB0byBkbyBoZXJlIGlzIHdo
YXQgd2UgaW50ZW5kIHRob3VnaCB0aGVyZSBtYXkKPj4gYmUgYSBiZXR0ZXIgd2F5IG9yIHBlcmhh
cHMgaXQgaXMgaW5jb21wbGV0ZSBhcyB5b3Ugc3VnZ2VzdC4KPiAKPiBPbiBzZWNvbmQgdGhvdWdo
dHMgdGhpcyBpcyBvdmVya2lsbCBhbnl3YXkgLSBpZiB5b3UgZG8gaG9vayAKPiBpb21tdV9nZXRf
ZGVmX2RvbWFpbl90eXBlKCksIHlvdSdyZSBkb25lIChpbiB0ZXJtcyBvZiB0aGUga2VybmVsLW1h
bmFnZWQgCj4gc2V0dGluZywgYXQgbGVhc3QpOyBpdCBkb2Vzbid0IG1hdHRlciB3aGF0IGlvbW11
X2RlZl9kb21haW5fdHlwZSBnZXRzIAo+IHNldCB0byBpZiB3aWxsIG5ldmVyIGdldCB1c2VkLiBI
b3dldmVyLCBzaW5jZSB0aGlzIGlzbid0IHJlYWxseSBhIAo+IHBlci1kZXZpY2UgdGhpbmcsIGl0
IG1pZ2h0IGJlIG1vcmUgc2VtYW50aWNhbGx5IGFwcHJvcHJpYXRlIHRvIGxlYXZlIAo+IHRoYXQg
YWxvbmUgYW5kIGluc3RlYWQgb25seSBtYXNzYWdlIHRoZSBkZWZhdWx0IHR5cGUgaW4gCj4gaW9t
bXVfc3Vic3lzX2luaXQoKSwgYXMgZm9yIG1lbW9yeSBlbmNyeXB0aW9uLgo+IAo+IFdoZW4geW91
IHNheSAic2VjdXJlIHRoZSBlbnZpcm9ubWVudCIsIHdoYXQncyB0aGUgYWN0dWFsIHRocmVhdCBt
b2RlbCAKPiBoZXJlLCBpLmUuIHdobydzIHNlY3VyaW5nIHdoYXQgYWdhaW5zdCB3aG9tPyBJZiBp
dCdzIGEgZGV2aWNlIGxvY2tkb3duIAo+IHR5cGUgdGhpbmcgd2hlcmUgdGhlIHN5c3RlbSBvd25l
ciB3YW50cyB0byBkZWZlbmQgYWdhaW5zdCB0aGUgZW5kIHVzZXIgCj4gdHJ5aW5nIHRvIG1lc3Mg
d2l0aCB0aGUgc29mdHdhcmUgc3RhY2sgb3IgZ2FpbiBhY2Nlc3MgdG8gcGFydHMgdGhleSAKPiBz
aG91bGRuJ3QsIHRoZW4gcG9zc2libHkgeW91IGNhbiB0cnVzdCB0aGUgY29tbWFuZCBsaW5lLCBi
dXQgdGhlcmUgYXJlIAo+IGRlZmluaXRlbHkgb3RoZXIgcGxhY2VzIHdoaWNoIG5lZWQgY29uc2lk
ZXJhdGlvbi4gSWYgb24gdGhlIG90aGVyIGhhbmQgCj4gaXQncyBtb3JlIGFib3V0IGdpdmluZyB0
aGUgZW5kIHVzZXIgY29uZmlkZW5jZSB0aGF0IHRoZWlyIGNob2ljZSBvZiAKPiBzb2Z0d2FyZSBz
dGFjayBpc24ndCBiZWluZyBpbnRlcmZlcmVkIHdpdGggYnkgYSBtYWxpY2lvdXMgaG9zdCBvciAK
PiBleHRlcm5hbCB0aGlyZCBwYXJ0aWVzLCB0aGVuIGl0IHByb2JhYmx5IGxlYW5zIHRvd2FyZHMg
dGhlIG9wcG9zaXRlIAo+IGJlaW5nIHRydWUuLi4KPiAKPiBJZiB0aGUgY29tbWFuZCBsaW5lICpp
cyogd2l0aGluIHRoZSB0aHJlYXQgbW9kZWwsIGNvbnNpZGVyICJpb21tdT1vZmYiIAo+IGFuZC9v
ciAiaW50ZWxfaW9tbXU9b2ZmIiBmb3IgZXhhbXBsZTogSSBkb24ndCBrbm93IGhvdyBQTVJzIHdv
cmssIGJ1dCBJIAo+IGNhbiBvbmx5IGltYWdpbmUgdGhhdCB0aGF0J3MgbGlhYmxlIHRvIGxlYXZl
IHRoaW5ncyBlaXRoZXIgd2lkZSBvcGVuLCBvciAKPiBibG9ja2VkIHRvIHRoZSBwb2ludCBvZiBu
byBETUEgd29ya2luZyBhdCBhbGwsIG5laXRoZXIgb2Ygd2hpY2ggc2VlbXMgdG8gCj4gYmUgd2hh
dCB5b3Ugd2FudC4gSSdtIGd1ZXNzaW5nICJpbnRlbF9pb21tdT10Ym9vdF9ub2ZvcmNlIiBtaWdo
dCBoYXZlIAo+IHNvbWUgcmVsZXZhbnQgaW1wbGljYXRpb25zIHRvby4KCgpUaGFuayB5b3UgZm9y
IHlvdSBzdWdnZXN0aW9ucyBhbmQgZmVlZGJhY2suIFNvcnJ5IHdlIGRpZCBub3QgZ2V0IGJhY2sg
CnNvb25lci4gQWZ0ZXIgdGhlIGNvbW1lbnRzIGZyb20geW91IGFuZCBBbmR5IEx1dG9taXJza2kg
d2UgZGVjaWRlZCB3ZSAKbmVlZGVkIHRvIHJlLWltYWdpbmUgd2hhdCB3ZSBhcmUgdHJ5aW5nIHRv
IGFjY29tcGxpc2ggaGVyZSBhbmQgaG93IGVsc2UgCndlIG1pZ2h0IGFwcHJvYWNoIGl0LgoKUm9z
cwoKPiAKPj4+IEl0IG1pZ2h0IGJlIHJlYXNvbmFibGUgdG8gbWFrZSBJT01NVV9ERUZBVUxUX1BB
U1NUSFJPVUdIIGRlcGVuZCBvbgo+Pj4gIVNFQ1VSRV9MQVVOQ0ggZm9yIGNsYXJpdHkgdGhvdWdo
Lgo+Pgo+PiBUaGlzIGNhbWUgZnJvbSBhIHNwZWNpZmljIHJlcXVlc3QgdG8gbm90IG1ha2UgZGlz
YWJsaW5nIElPTU1VIG1vZGVzCj4+IGJ1aWxkIHRpbWUgZGVwZW5kZW50LiBUaGlzIGlzIGJlY2F1
c2UgYSBzZWN1cmUgbGF1bmNoIGVuYWJsZWQga2VybmVsIGNhbgo+PiBhbHNvIGJlIGJvb3RlZCBh
cyBhIGdlbmVyYWwgcHVycG9zZSBrZXJuZWwgaW4gY2FzZXMgd2hlcmUgdGhpcyBpcyAKPj4gZGVz
aXJlZC4KPiAKPiBBaCwgdGhhbmtzIGZvciBjbGFyaWZ5aW5nIC0gSSB3YXMgd29uZGVyaW5nIGFi
b3V0IHRoYXQgYXNwZWN0LiBGV0lXLCAKPiBub3RlIHRoYXQgdGhhdCB3b3VsZG4ndCBhY3R1YWxs
eSBjaGFuZ2UgYW55IGZ1bmN0aW9uYWxpdHkgLSBpdCdzIGEgCj4gbm9uLWRlZmF1bHQgY29uZmln
IG9wdGlvbiBhbnl3YXksIGFuZCB1c2VycyBjb3VsZCBzdGlsbCBvdmVycmlkZSBpdCAKPiBlaXRo
ZXIgd2F5IGluIGEgbm9uLXNlY3VyZS1sYXVuY2ggc2V0dXAgLSBidXQgaXQgc291bmRzIGxpa2Ug
aXQgbWlnaHQgYmUgCj4gZWZmZWN0aXZlbHkgc3VwZXJmbHVvdXMgaWYgeW91IGRvIG5lZWQgdG8g
bWFrZSBhIG1vcmUgYWN0aXZlIHJ1bnRpbWUgCj4gZGVjaXNpb24gYW55d2F5Lgo+IAo+IENoZWVy
cywKPiBSb2Jpbi4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
