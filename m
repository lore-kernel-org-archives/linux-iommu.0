Return-Path: <SRS0=kThj=K4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A81EC4708F
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 16:03:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 127CD61603
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 16:03:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 127CD61603
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CFB7F40500;
	Wed,  2 Jun 2021 16:03:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PnrOvlmyD9da; Wed,  2 Jun 2021 16:03:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 053C1404F4;
	Wed,  2 Jun 2021 16:03:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8D2EC000D;
	Wed,  2 Jun 2021 16:03:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 649A0C0001
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 16:03:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4540183C9D
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 16:03:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="C+sZK792";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="ZY9rTj1M"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IG0fAPlD7gud for <iommu@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 16:03:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F3C9683C8A
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 16:03:32 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 152G2fGe024614; Wed, 2 Jun 2021 16:02:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=FhZo5TqOLCbYFE8dfIq/wsTGIaXUBJx1ifBYy0FfxBs=;
 b=C+sZK792DEg+Pm4h9rvBrh/2zdQHOQuoQRm/do27x7/HA48MmNPxtwD8W8ObfoLMplRs
 /yZ6eNFS2mql4jkDtI9LML+8ktzng7QRgsUU0skT2Cpilxjq3tB5JSchNSY0AKjS8Fy6
 x4De18C4zCD0FAKBKSC5sM2eWIpCkTD/qT3+qcNR26gjxRg3ubY436S2elTPL0VxAt4Y
 KWaaaocDSggOSG6ltI50ME1AyilI0OY+lvTxuII95TCSYtHpirJISkVx6N3q3ow+wwNG
 SEKEigOvPMw29jxVGBOMBgAFSbj56PecqHZUARI1RWzYpMKpes7u4MubXYtMeq6vx/6e HA== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 38wx9fra8e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jun 2021 16:02:40 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
 by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 152G2duL074339;
 Wed, 2 Jun 2021 16:02:39 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam08lp2171.outbound.protection.outlook.com [104.47.73.171])
 by aserp3020.oracle.com with ESMTP id 38udecap7t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jun 2021 16:02:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJMvBgWS66jGwJGc2xlCo1rGKiYxBBzM2VzGY+HsNEhweBknL+pGn0yBqLdE0ciE3uupEG0vYQ3aPLW19xUYG2XCOfEDxWxGqsk/mo6BuTQWDCw8fmXfNBDJS2tsFq4t5/PaWaBp1LhxHuiYL4KVYUt1gmZI4lC6X9oRNdCfDM4cMyiemRrraoS2SUw6JTuLGttt1FXByTgXxS1Cj+JYIPE2OUd7xm4Mq+IhiGgE9Bk5fJM5SJuv68hAUwThIDKKmkEbZBVfMHBQBiSylIlQ3cOszjQi1mbxkuv1c48tZ5K4RviM8HSvjk2fQDB2QIyqoiGQS8TTcGKCjs+pzor2cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhZo5TqOLCbYFE8dfIq/wsTGIaXUBJx1ifBYy0FfxBs=;
 b=oQAV4EZMJY/pnqtfE0mtTPspIJVNFCQMydHqGvL++XEkzxbi7uFwKMpBuk44f1ipTwBQGXj+bLQXhj8iJfRXjNw9corb+MhK//9uAd9rZVnLBz/fkoMmn7iuF5lUiTeLxWFIWsJbknqMcVxM2zLVMsO81Zji8TUBhmEccsJKuOePqICBGUQQ5fs2bn2I0m/5lcIxiXYxOvmoIN/xWGXaBwgPReu0QtIm58t2ClE7+EvYFfYhEtJhkjiPJfJ+lATlxlFK93aZWmUp2GPEqnDu9L6yLPy5TpNj3+qaG4AWyNUBujNeEcbouQMbw4DH02kQJ3w5RPWPptVTbjos0WjLTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhZo5TqOLCbYFE8dfIq/wsTGIaXUBJx1ifBYy0FfxBs=;
 b=ZY9rTj1M6I4whNd1GbkVOBxUHuFh1wdxbd6A8LmJBy5jwsEXhW+HAaLAo0I0ma/5t2PhXABnTt71WqBdwuKj4p3MYQflGAMFdQdpepmAl41X6PhgdjrnXj2yEiKd9XD4Q7NEaRtmIfXxeNirsm7YT8LJXkefefcn42u7/b4+mGQ=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none header.from=oracle.com;
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by BL0PR10MB2948.namprd10.prod.outlook.com (2603:10b6:208:7b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 2 Jun
 2021 16:02:17 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::78a3:67d:a8ca:93cf]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::78a3:67d:a8ca:93cf%7]) with mapi id 15.20.4195.020; Wed, 2 Jun 2021
 16:02:17 +0000
Subject: Re: [RFC PATCH V3 09/11] HV/IOMMU: Enable swiotlb bounce buffer for
 Isolation VM
To: Tianyu Lan <ltykernel@gmail.com>, kys@microsoft.com,
 haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, x86@kernel.org, hpa@zytor.com, arnd@arndb.de,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
 rppt@kernel.org, hannes@cmpxchg.org, cai@lca.pw,
 krish.sadhukhan@oracle.com, saravanand@fb.com,
 Tianyu.Lan@microsoft.com, konrad.wilk@oracle.com, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com, jgross@suse.com,
 sstabellini@kernel.org, joro@8bytes.org, will@kernel.org,
 xen-devel@lists.xenproject.org, davem@davemloft.net, kuba@kernel.org,
 jejb@linux.ibm.com, martin.petersen@oracle.com
References: <20210530150628.2063957-1-ltykernel@gmail.com>
 <20210530150628.2063957-10-ltykernel@gmail.com>
 <9488c114-81ad-eb67-79c0-5ed319703d3e@oracle.com>
 <a023ee3f-ce85-b54f-79c3-146926bf3279@gmail.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <d6714e8b-dcb6-798b-59a4-5bb68f789564@oracle.com>
Date: Wed, 2 Jun 2021 12:02:03 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
In-Reply-To: <a023ee3f-ce85-b54f-79c3-146926bf3279@gmail.com>
Content-Language: en-US
X-Originating-IP: [160.34.89.155]
X-ClientProxiedBy: SJ0PR03CA0275.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::10) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.74.103.155] (160.34.89.155) by
 SJ0PR03CA0275.namprd03.prod.outlook.com (2603:10b6:a03:39e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20 via Frontend
 Transport; Wed, 2 Jun 2021 16:02:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e880f785-c80a-4594-9961-08d925dfcb81
X-MS-TrafficTypeDiagnostic: BL0PR10MB2948:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR10MB2948E5F3684F7BB4EF7F01718A3D9@BL0PR10MB2948.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HJL3AnD7x/9PGpxjrgiyQBj/KirmlfRaYrGHtjr3cgyzQIc/Fc0RmeioXFo2lfpVibPJcQ9r58P7xtGkhF4eaFDZreeA0GQ90s3Wo+pmh9ansrYimIOspvJ1zUmXFLKsVaMTfvIw7nhDE90bqdKuAO1MbKrtttn9+W+hQJ2wYgBvGV67tN2wT5g2Rlwp7UK7LjGoeoH4t2WsY4gPxvUJLsiUZP2Af6C6k1pEL2fz8kwEH8UDixN/eFDFI6epDF5tWQoFf1UWvBrmlH1kTXTdJmFAxEXcnvu97K8ODRBbd8cUI82pVSqETJUxbA/Zh0hYTzJ6Q89Y+c52vHkfO77EoH7Rv3pq80qHqlxSLK+ox/f3Lzeu73mgTSy4EqCUB5hMcr3CfcvS5PFrsKLG657V+DeXzCBhfxqtfKPcUzcs99tU+Sb9KVSJm1o+QSBAOtuXoEvctK1iEpYlc9GQ2gIh7hnBFYFYoM0DuzSks2msc9lGrhm1AgVDMhjSrYsEzzvOwY8/qyhoWp86YUnMP637N2sCy5vgZlko6itldn8fwpDjWf72FzXPM7hiRw6bOSYj5bSsbsP7Mdh/6L2zRsrfue3z/e0xUaZXCUo+8mbMKqD1CqHQnRNTIzolx2hIcHcubX9CFOOtoPpzqXhJrLApmk7UvBDbh4wjiTYi86havgHX4l3IH0BQ1WCrrPbqV4/Fo1pXDpm1gduHQQrE+XhLdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5009.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(39860400002)(366004)(396003)(376002)(346002)(26005)(6636002)(16526019)(186003)(86362001)(2616005)(956004)(83380400001)(44832011)(31696002)(66476007)(8676002)(7406005)(478600001)(53546011)(16576012)(66946007)(31686004)(38100700002)(8936002)(66556008)(6666004)(316002)(4326008)(2906002)(921005)(5660300002)(36756003)(6486002)(7416002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MDZyeStwMFFoR2J0SEc2bW9rbVR3cm51Nm96UzJ1NU9KNDczNmhNZHZIbnF4?=
 =?utf-8?B?ZFA3TlNzR1dLd1FTTVdqWlZuMXVmWTFjMWZVSTlIdDhFM0FhTU9HallxVFNa?=
 =?utf-8?B?dlcxWGRQaEg0S3RQY2ozTGhSRlpnZTNpUzR2TW83amc0ZVV5cTJkbzQzUERS?=
 =?utf-8?B?Y0VqZXFWc01Rd2xKc0NnTmJxUk5vcVZDemdBaThxVDZwUm1abWxldVE5U2ZX?=
 =?utf-8?B?ZjQzVzk2QVZGVEdQYjdxZ0R3RFF4b2tENEJtQ3hhU2tITUdDTENsaUt3OS9Q?=
 =?utf-8?B?T2pTTDFodXVBNktZRGIxV3AxUElTVDExSnRQa1FHTUt6TGhIcGFNNjVaTjFs?=
 =?utf-8?B?K3g4UmRZa2ROYjlGOWRBYkRWZk5YR1VPRmhlcW5YZTJJWTN3MU5NRjU5b2hy?=
 =?utf-8?B?cDlIeGhyejFxNFRMbDlhODljNlUyVFBDa3ptL2dMd3ZwMmd4azZjZDZjc3J5?=
 =?utf-8?B?dG5HZzd1LzhWOVVpdSsyZjJ1VU43QVdOaFBqdTFLQ2MxZHd4NWpmSjlLcDhk?=
 =?utf-8?B?UmN3blRXWloyT2pDVkRsamlJU0pNWDNIc3dwZ0IrLzd4WTNMWFAxdHdMd1Bp?=
 =?utf-8?B?TXRYclRBWG1xeUlEcHlhVnpDMUdHK0lBL21PZk9KaWZYNmtabmpheDVIMFly?=
 =?utf-8?B?L21XcVJ4M2psdkNEeEcvSmQ3ZW1IbEVwWHo1RmNwUmFUS2RwMHRsWVI3UjBR?=
 =?utf-8?B?aWJUanYyOEFhbGZKMXpCU0FGT3ZSbDNzWFdpcnIxL3hsSkYwSTNvUVc2bnZv?=
 =?utf-8?B?cnk5eGpQbnpTV3R3L011NjMxaTFjTWZZTmtVbWlrNFNnMzN5K0RieFRPcWE0?=
 =?utf-8?B?cXExRmJlWVBNbXhad010Nmd6d0h0QkZWZ1NWeXRqa2dVUG0xRHZaU3NJNTEz?=
 =?utf-8?B?RVRHWU9rVGFDRHVtWFJyYTFMVnNWYzM5Mm1FTnVSTldRY2tEZUphZys1ZFhz?=
 =?utf-8?B?b2tENmMrNWErZmk0V2dQcHlUZi8weFdWbE4zaTEwSnArVFc3eGVVTUJYUjFt?=
 =?utf-8?B?cVA2WlpQYlJ2L2RERzFybVY2dEdBWFlVWTNEWVBKSFh1UytXMlN3TXlSSkV3?=
 =?utf-8?B?MEVBVkkvZFBwWGwrVUVieVVxc2Z3bDBic203bjJKU1REQVN4K0w3T2FIMEY5?=
 =?utf-8?B?a1M5VEhYSE12MHp6SXEzRThWWTRPVkNNdS8rSEFUY3dSVWlrMXV4RXJFNVZs?=
 =?utf-8?B?WWJVTHZTZHh0SVZJNGlYQkZXbEd4OUVQMlE0bGdRS3RCT1pxdVhNNmEyZk5B?=
 =?utf-8?B?WG42VlNqK2MvU3MzYUwvSVo3ZndYZmptMmFqVFI4S3RVNlNlNFZ2RXA3VElI?=
 =?utf-8?B?MW1PTEJMYzQvOG9SM2YrNkR2bWllUXVpVWN0dkdWTVgwNVUwc0dkU0JVNFhB?=
 =?utf-8?B?TGFpVkEzOTZJbW5lSVNhY1JHSlE1a2tVQlJxRFRFMHpqanl0aGk1eFdrNmRX?=
 =?utf-8?B?ZjJXRUpudHNXQkU1R0M5NWl1eFpiWTIrWnRXOU9jL1phcyt6d1JWMzdMUGVa?=
 =?utf-8?B?dEE0eWx2RlBISWo3WWQrRHo4M3hTMGZ2Z1ZoZnRjUjJpOThRQVJ5SjB5TWlP?=
 =?utf-8?B?WjRacEw4L3E5SGJWblVDRHhoNEJpcCtXWVAxMXIyTTJOODh2dmJaNzNnLzdk?=
 =?utf-8?B?bm0zM0gzR0x6MGViS0VPalZNUFBOS2NVajBPQ1dMT2FvS2F3UjdnRzhHS2Ju?=
 =?utf-8?B?cnBkd3daaHR6Vjc0dDhWV0JGRDY2alJJK1ZkNEU2LzgzaDJlWWFSTWErOE94?=
 =?utf-8?Q?gXM4EeYi+eZIPZA3pmX/wNZ1x05ij1DuSnROjtp?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e880f785-c80a-4594-9961-08d925dfcb81
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:02:17.5711 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y2gXOzzbZ7MMkWZnLPMBjTsCziTkYJjn8DI5EWzgfUUM3mB9fJXC1BCiBLmVmLPBRFNvBCvRFwdczV3oJioOpqVJxQ1juVJOh1BkAxeEGsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2948
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10003
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106020101
X-Proofpoint-GUID: D2nKtgwgUzB4I8NO5gn7GykhtJc5Pd7z
X-Proofpoint-ORIG-GUID: D2nKtgwgUzB4I8NO5gn7GykhtJc5Pd7z
Cc: linux-arch@vger.kernel.org, thomas.lendacky@amd.com,
 linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 linux-scsi@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 vkuznets@redhat.com, sunilmut@microsoft.com
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

Ck9uIDYvMi8yMSAxMTowMSBBTSwgVGlhbnl1IExhbiB3cm90ZToKPiBIaSBCb3JpczoKPiDCoMKg
wqDCoFRoYW5rcyBmb3IgeW91ciByZXZpZXcuCj4KPiBPbiA2LzIvMjAyMSA5OjE2IEFNLCBCb3Jp
cyBPc3Ryb3Zza3kgd3JvdGU6Cj4+Cj4+IE9uIDUvMzAvMjEgMTE6MDYgQU0sIFRpYW55dSBMYW4g
d3JvdGU6Cj4+PiBAQCAtOTEsNiArOTIsNiBAQCBpbnQgcGNpX3hlbl9zd2lvdGxiX2luaXRfbGF0
ZSh2b2lkKQo+Pj4gwqAgRVhQT1JUX1NZTUJPTF9HUEwocGNpX3hlbl9zd2lvdGxiX2luaXRfbGF0
ZSk7Cj4+PiDCoCDCoCBJT01NVV9JTklUX0ZJTklTSCgyLAo+Pj4gLcKgwqDCoMKgwqDCoMKgwqDC
oCBOVUxMLAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoCBoeXBlcnZfc3dpb3RsYl9kZXRlY3QsCj4+
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBjaV94ZW5fc3dpb3RsYl9pbml0LAo+Pj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBOVUxMKTsKPj4KPj4KPj4gQ291bGQgeW91IGV4cGxhaW4gdGhpcyBj
aGFuZ2U/Cj4KPiBIeXBlci1WIGFsbG9jYXRlcyBpdHMgb3duIHN3aW90bGIgYm91bmNlIGJ1ZmZl
ciBhbmQgdGhlIGRlZmF1bHQKPiBzd2lvdGxiIGJ1ZmZlciBzaG91bGQgbm90IGJlIGFsbG9jYXRl
ZC4gc3dpb3RsYl9pbml0KCkgaW4gcGNpX3N3aW90bGJfaW5pdCgpIGlzIHRvIGFsbG9jYXRlIGRl
ZmF1bHQgc3dpb3RsYiBidWZmZXIuCj4gVG8gYWNoaWV2ZSB0aGlzLCBwdXQgaHlwZXJ2X3N3aW90
bGJfZGV0ZWN0KCkgYXMgdGhlIGZpcnN0IGVudHJ5IGluIHRoZSBpb21tdV90YWJsZV9lbnRyeSBs
aXN0LiBUaGUgZGV0ZWN0IGxvb3AgaW4gdGhlIHBjaV9pb21tdV9hbGxvYygpIHdpbGwgZXhpdCBv
bmNlIGh5cGVydl9zd2lvdGxiX2RldGVjdCgpIGlzIGNhbGxlZCBpbiBIeXBlci1WIFZNIGFuZCBv
dGhlciBpb21tdV90YWJsZV9lbnRyeSBjYWxsYmFjayB3aWxsIG5vdCBiZSBjYWxsZWQuCgoKClJp
Z2h0LiBCdXQgcGNpX3hlbl9zd2lvdGxiX2RldGVjdCgpIHdpbGwgb25seSBkbyBzb21ldGhpbmcg
Zm9yIFhlbiBQViBndWVzdHMsIGFuZCB0aG9zZSBndWVzdHMgZG9uJ3QgcnVuIG9uIGh5cGVyVi4g
SXQncyBlaXRoZXIgeGVuX3B2X2RvbWFpbigpIChpLmUuIGh5cGVydmlzb3JfaXNfdHlwZShYODZf
SFlQRVJfWEVOX1BWKSkgb3IgaHlwZXJ2aXNvcl9pc190eXBlKFg4Nl9IWVBFUl9NU19IWVBFUlYp
IGJ1dCBuZXZlciBib3RoLiBTbyBJIGRvbid0IHRoaW5rIHRoZXJlIG5lZWRzIHRvIGJlIGEgZGVw
ZW5kZW5jeSBiZXR3ZWVuIHRoZSB0d28gY2FsbGJhY2tzLgoKCgotYm9yaXMKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdApp
b21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
