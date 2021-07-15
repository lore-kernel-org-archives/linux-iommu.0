Return-Path: <SRS0=9Lhb=MH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287B4C07E96
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 16:59:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6E3B613F7
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 16:59:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6E3B613F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 97C9883D0C;
	Thu, 15 Jul 2021 16:59:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YT2OducQZWVn; Thu, 15 Jul 2021 16:59:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6E67983CC2;
	Thu, 15 Jul 2021 16:59:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45D19C0010;
	Thu, 15 Jul 2021 16:59:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E772FC000E
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 16:59:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D45B642209
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 16:59:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="wr4PMlUA";
 dkim=pass (2048-bit key) header.d=oracle.com header.b="OZmhzVkJ";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="tf/FwZLw"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2pOW9lARugKK for <iommu@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 16:59:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 21D96421E1
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 16:59:09 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 16FGudiS002755; Thu, 15 Jul 2021 16:59:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=PlO+aifXXEIa+z9v4xiUSYXOYqpLk/izVPxxiT30tas=;
 b=wr4PMlUADMX+pKNNeLS00LRJxeiFa9wtCCi94xqN1NfbZ/k1hzylUOOvPIncGDn70Ckz
 C3aCIPzsI9yMUUvfd9ZMkwO5ZoXFfhnPWdyHa+V9dAD44Ra8Kq+NIGKnhioX1SKBlf4F
 Raht9AI3sdtTaSWYMk/v91CHr5eJ8GbsMJuwgZ4aBilg96q/HOmavEe1pKKeRsBau07O
 9bRfczTRULdCaZOhsDPvzc8UqdljUpMxepZVYfRaUOj7hWr5WihQgM8Bap06iOMp23d8
 HESJXzYXSZLHo3t6T0tk/hV/Y7ZvkJYPpjC1SYGOZE6eueS8KVr4UJIuEuGBw+ABiIz/ 5g== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=PlO+aifXXEIa+z9v4xiUSYXOYqpLk/izVPxxiT30tas=;
 b=OZmhzVkJ/gp8jM+OSrb7h6PUPCGSGbyZIIQw+mRypFDR8skUkOuKhJ17GDA4Z/dguvhQ
 MtYelAIT5e7jAsOkLW3RxjDKULlpdR8qZtqzO6egFRdZZ+bbbxY0x24h9y7SPsRYTsed
 2T+xK+pYCn55eMwrp1GvLNoq5RNnQXkH93nyPGirvHD17EtxxnrpwgIvoKaXOTUjhauC
 tKtTotLjXuOqE/EiX1iwE/E+/JyFxKfYEq/tGE+ntMW/+h9cj6qFjgPh6QojSsZpqokG
 z/voMPAKRpQDP+McqhDH0TmMGc7SBaUKQ/rJD/kUGj+TBKu3C19g5q10nwL7/nqrn4k6 zA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 39t2tj2kc9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Jul 2021 16:59:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16FGtjEK114458;
 Thu, 15 Jul 2021 16:59:05 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
 by userp3020.oracle.com with ESMTP id 39qnb6a5a3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Jul 2021 16:59:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gg0RZaa7YGP/UlNzcolDVEdKn38h/DAbEyHS4agSBqEQVG7WoSpAcv+MiXeNJekqtXg+tXD05O8Bmz8xHIpPtIeL9YP+KZS1cJ82fMKcrRFioHlpRkNY5GLfcTS6qAJYAoQZDdk3HxyklsyXWGP0ul7Gzag/iB/Zx0H4aZBy7HBi6Mn7T38Dgtws9bIPE80Gpdq0pVqfckvBpOh5EgNLY8M6bJzBEwK6tXz1S1aNSIfNbvbyhuwMMQswXP1CEu88FAd6hB+P5AOgYEXy59PFz0FTOcU3RQ+HF7Xxg6hhVuB1XYCAWIqz9onuffraUWmXTp4Ed85qizbJs7C8fVaFEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PlO+aifXXEIa+z9v4xiUSYXOYqpLk/izVPxxiT30tas=;
 b=odx+95pMtGjDELlV0HniQHCmErEKFqSWDua0lQojaRysPRqwdTckJCFteJzc6xX9rX4doa/6hz5o6t787680mwe6o1YDlWBSHFkCi1+lGHP8S6J5BHRiHWIuspLc+B84/iWXQm3lspK5Y0aXNnyfDK+Y866ZIuu0mjFs0YbvFLwYx2BjAQRsCHT8sS00fYsW2YEj237u2ROsWhmVlVIRQinPDIgIc0h/m8prcngBENwVaMAFx2/fFBxysL3otqJSRA3yyaJtsyYBVEpqaAUqsyGR48w10DELKTo7F0f7dNBXw3a9Gn/kwYz7UcLGImrReefS3r7QbIa5HJi3IND0Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PlO+aifXXEIa+z9v4xiUSYXOYqpLk/izVPxxiT30tas=;
 b=tf/FwZLwPbrRzNCeZtO2dx6K9wCekqwHUgwgB9x8HWnNPmgUJ49L4b5XBUwWANb3MYEPvLx8y61GLa5rIQorP7Rlk+faQS+GMbEkqKU6MJtr4X3L9Fulotq5GihNdrBbJJd6nXtyofAZCoArSIYpAJjy01MsL4tqCEpoEQKDyNU=
Authentication-Results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=oracle.com;
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by MN2PR10MB4029.namprd10.prod.outlook.com (2603:10b6:208:186::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Thu, 15 Jul
 2021 16:58:59 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::f10d:29d2:cb38:ed0]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::f10d:29d2:cb38:ed0%8]) with mapi id 15.20.4331.021; Thu, 15 Jul 2021
 16:58:59 +0000
Subject: Re: [PATCH v2] dma-mapping: use vmalloc_to_page for vmalloc addresses
To: Roman Skakun <rm.skakun@gmail.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
References: <20210616154436.GA7619@lst.de>
 <20210622133414.132754-1-rm.skakun@gmail.com> <YO4si0to/XYximwM@fedora>
 <CADu_u-OMx6Pj4DQDoOsdh6aNAzYys-+R=o+OzHYtLm=nECgkyQ@mail.gmail.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <fb262a14-a69c-030b-1f39-d924553ddbd2@oracle.com>
Date: Thu, 15 Jul 2021 12:58:53 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <CADu_u-OMx6Pj4DQDoOsdh6aNAzYys-+R=o+OzHYtLm=nECgkyQ@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: SN4PR0501CA0033.namprd05.prod.outlook.com
 (2603:10b6:803:40::46) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.74.100.129] (138.3.201.1) by
 SN4PR0501CA0033.namprd05.prod.outlook.com (2603:10b6:803:40::46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.9 via Frontend
 Transport; Thu, 15 Jul 2021 16:58:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0c6d445-d103-424f-cd70-08d947b1d6cd
X-MS-TrafficTypeDiagnostic: MN2PR10MB4029:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR10MB402910554450C444A6F24A6B8A129@MN2PR10MB4029.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qdnqgzTkhK55yUP3ToNYVOAxKmtGviRCmGuVPi0OZMqjQ8aLb5hq2RDOEz+gg20erxVl53NPHL61Do3wdxham6bas3MnwRmmXbhE8YG4JL2rvabY1Phsun6kXzvP7MRasfonZ+8W5xB0bUEaPAjrsFaI28Kq6ywLP9/dpU+0uEK1WZS9/5/X/2OYIZNQMvAAenjgIr6pfGxcZzWgtnIvG/ipucrHv6krvI4R3cmbe1dz9u/vukZGglHVrirhEfaoIAs437lhAsoyCo56Rbxjdojo/qx06UQyMXyYl4+ATS1j+Pc/R55P48j6FuPQZiVeyAnm0Fq0UG7bZiy5sD+1H2VjL0jsG3CneadgiuNK76n4kNDuHpiC+RvPce+f0Hm9dzcz56JPLLNFuMvTG5Fzaw78x+OvsNB1nj+5a8wlDS3lxzZvLAfYMuSHeLxBp5pRO/vowW3ul6MqJC4O3A+m4QJrrkFFPLt6/qlUlHbMHt8+BH0vKotwI3CYpR9rUC708gjZy8kZHcmIeS/imXaUz2CmfDFUpMiiXmzubjpmj/k60uJ7V6JVxlCCGgTctzkl4aiG+3R+TQvvYiBDAhXipAmALAeJ1s73UQyeSdDpLj4ZYyfyQhMKKTKgm1GXPvXYcguQCTzZ5z3Z+jAaTXugII5gq+cJN6QXTGlYMTFC1niEqkwWAQ9vM3u1NhTlgSOJtTzl6wM+qqYQ5SL8PbQ5YrB3tZEaeDcIum6KpYfPAyk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5009.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(376002)(396003)(39860400002)(136003)(366004)(86362001)(83380400001)(31696002)(4326008)(26005)(53546011)(66556008)(66476007)(478600001)(186003)(5660300002)(110136005)(54906003)(66946007)(31686004)(16576012)(2616005)(956004)(8676002)(316002)(44832011)(38100700002)(7416002)(6636002)(36756003)(2906002)(6666004)(6486002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWg1eVBBQ0g0K1BRclgzMHg4UWxpa3Fzc3VoTHYvTGljWWU1bVhPNGxMeVd0?=
 =?utf-8?B?Wmt6OGZDckM3MXZOdzJuNHp4ZGpHTENVdEpJQzhBRDR5a3BzZUFiU000czdH?=
 =?utf-8?B?V3B5NzlEaHlUVmcwUWZvSHhXd2IyOCsvZjBwT25OaEFKYUYvRFZMY0laNHdU?=
 =?utf-8?B?SDV1ZndJcGpTU3ZkWlhJQzJJalJQTWFSMXNyT0tXbEhGbHpGaDUzb1ZtdUVs?=
 =?utf-8?B?SjNqV3drZXdwRGxTZ2M2NlNhRkJpanM0VUNIeURzb1diM3lCS2tkU1l0cXI5?=
 =?utf-8?B?UDFzUmdtb29pT2o3RytpalllVEd0OGVKVDF4L01ZUXNqL2V5WUg0bDhEU0pr?=
 =?utf-8?B?bXIxZGM4ZGh2Zkt1bHNaTEJyUkh1Ky9QTlR2VTE3RDhXNytraWZuRnBMU01O?=
 =?utf-8?B?a2hRS3hlazArTjNvYTljMXZWMmFYMG1PVi9RWjA4Q3NUVEMxb2JnbXRidFVZ?=
 =?utf-8?B?eXNseUxHaXJhanl3Wk5MNkJpbzBLQ3hsRGdLbldOOE9TbktvVGJaZE55VEZD?=
 =?utf-8?B?a1VYSTlmbGtyWnRjeFVNb1Q2dSthYjFmMmZMeGVqSkhUZHh0T0Z3dDdKVC9D?=
 =?utf-8?B?NlN5d3NsaTlnV3JmNWhBRy9xQytnY3JoUGVGandqNDlraE1WNWFESmxWYXJW?=
 =?utf-8?B?RjJLVXlJcVdVcGZzRFpIN1pWVFhwdjhwU09MVEQvKzlKSzNiZWFMcmtlZTIw?=
 =?utf-8?B?L3d6WTFkU0ZTc2F6NzQwY3M4RGFVRGhpc3JSZC9uc29jWVMxNXlFNzZJMkYr?=
 =?utf-8?B?VDlpNHk2TGI2L096N0NNZ29qcy8vVVZQUU5sNmVpbmN4WHQwMUpZRHdaeEd2?=
 =?utf-8?B?ZnBwbGd4VDhZamJ4d3RIQW4zMEgwUkFPQU96cEpZR0RsWVVNMlBBTVpVbm9t?=
 =?utf-8?B?ZVJrT0NNZjJxTk55MlI3QnU5N3hmRDRwVC9kdVZFLzBJbG1sb1U3eDNlZ0tL?=
 =?utf-8?B?bnZMUVhpdCs0dkllYjhiZTM4Vk5uTURkV3VmZzZ4SFptUDlSVlJUS1haSkFi?=
 =?utf-8?B?NDZ5WlF6ajg5b3MrUU9STVVRbmRaT25od1ZKQjBROTV4cndsZm13TnVxdlZN?=
 =?utf-8?B?a2FDWDM5VldYeUtaV3FLMVE5SkZkd1FxTXl3VXJ4bVpZTm53RmhWVGJUd3Fw?=
 =?utf-8?B?N2dOalI1WjZwaElpTEVnUVFGeTk1NlhVS0hVdldwMWtCUmhzTFphU29ITnNT?=
 =?utf-8?B?YnBGTTh1REpwU2VkTXJ4RVh6c2piMGJldWpKZlpMdldiUlNqOGl0b0U0a2xv?=
 =?utf-8?B?RzlEUi9KMk9taG0wZzZXMFR5dU9CWThsWkhscE1kYy9qeXQ3QWwvREhiSDdO?=
 =?utf-8?B?bmJLSjZCYjI1TEc3bkE4NlA2SjJBbktSMHk3bXNRdmQvNU9PUGcrdDEySnhn?=
 =?utf-8?B?eEt4bmwrRGJiZDRZUDMzNlI4d3o5RWtENXFEMjFxKzY5bm5QWnRuSU56QzVC?=
 =?utf-8?B?dTh5djBGQTBsMEZWb0pTSGhTSVduRTZmRi9qUnJvR1JIaFJJT01sT3BnTVVi?=
 =?utf-8?B?aHhEZ1JDclNKY1ZhVENrK29Ma3orbS9wcklSdmRCbG45ZmJEQ1czZVVGaHow?=
 =?utf-8?B?RWt5Y1lpZjJmb3J4aGlzTHFXMFRLdmZibUFRTkgxMjRGbFRYbldOVkQ4OURZ?=
 =?utf-8?B?NEhLcDlmNkk4N3lZUmJFTHIvTDZJZmNVbm5FVkFmQ2h2VXNEZUdvdE9EY1ZL?=
 =?utf-8?B?T1FHK0hkK2JwK2dtV3JHaDJZbG4wMW1tclR1S09LL1ZXN3g3UXFyVDJUQXEv?=
 =?utf-8?Q?JsWBKspGTSZPzFgUJ/XDdB9Y4YypmU4chCYu3mf?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0c6d445-d103-424f-cd70-08d947b1d6cd
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 16:58:59.0082 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n+/aIE9t+mfQQfHCoaVaQeITm4FACotAsQJkjFakxWUzmLcIEtlQgvY90vf8YXZiX4SxAJDNcY6cW27XtG912DTd8g9h798M01j2fqRQdxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4029
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10046
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107150116
X-Proofpoint-GUID: bdsWZfvxQy0DFOdpS8eLfimtmJJWt2xt
X-Proofpoint-ORIG-GUID: bdsWZfvxQy0DFOdpS8eLfimtmJJWt2xt
Cc: Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Andrii Anisov <andrii_anisov@epam.com>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 linux-kernel@vger.kernel.org,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 iommu@lists.linux-foundation.org, Roman Skakun <roman_skakun@epam.com>,
 xen-devel@lists.xenproject.org, Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
 Christoph Hellwig <hch@lst.de>
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

Ck9uIDcvMTUvMjEgMzozOSBBTSwgUm9tYW4gU2tha3VuIHdyb3RlOgo+PiBUaGlzIGxvb2tzIGxp
a2UgaXQgd2Fzbid0IHBpY2tlZCB1cD8gU2hvdWxkIGl0IGdvIGluIHJjMT8KPiBIaSwgS29ucmFk
IQo+Cj4gVGhpcyBsb29rcyBsaWtlIGFuIHVuYW1iaWd1b3VzIGJ1ZywgYW5kIHNob3VsZCBiZSBp
biByYzEuCgoKTG9va3MgbGlrZSB5b3UgZGlkbid0IGNvcHkgQ2hyaXN0b3BoIHdoaWNoIGNvdWxk
IGJlIHBhcnQgb2YgdGhlIHByb2JsZW0uIEFkZGluZyBoaW0uCgoKLWJvcmlzCgoKCj4KPiBDaGVl
cnMhCj4KPiDRgdGALCAxNCDQuNGO0LsuIDIwMjEg0LMuINCyIDAzOjE1LCBLb25yYWQgUnplc3p1
dGVrIFdpbGsgPGtvbnJhZC53aWxrQG9yYWNsZS5jb20+Ogo+PiBPbiBUdWUsIEp1biAyMiwgMjAy
MSBhdCAwNDozNDoxNFBNICswMzAwLCBSb21hbiBTa2FrdW4gd3JvdGU6Cj4+PiBUaGlzIGNvbW1p
dCBpcyBkZWRpY2F0ZWQgdG8gZml4IGluY29ycmVjdCBjb252ZXJzaW9uIGZyb20KPj4+IGNwdV9h
ZGRyIHRvIHBhZ2UgYWRkcmVzcyBpbiBjYXNlcyB3aGVuIHdlIGdldCB2aXJ0dWFsCj4+PiBhZGRy
ZXNzIHdoaWNoIGFsbG9jYXRlZCBpbiB0aGUgdm1hbGxvYyByYW5nZS4KPj4+IEFzIHRoZSByZXN1
bHQsIHZpcnRfdG9fcGFnZSgpIGNhbm5vdCBjb252ZXJ0IHRoaXMgYWRkcmVzcwo+Pj4gcHJvcGVy
bHkgYW5kIHJldHVybiBpbmNvcnJlY3QgcGFnZSBhZGRyZXNzLgo+Pj4KPj4+IE5lZWQgdG8gZGV0
ZWN0IHN1Y2ggY2FzZXMgYW5kIG9idGFpbnMgdGhlIHBhZ2UgYWRkcmVzcyB1c2luZwo+Pj4gdm1h
bGxvY190b19wYWdlKCkgaW5zdGVhZC4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBSb21hbiBTa2Fr
dW4gPHJvbWFuX3NrYWt1bkBlcGFtLmNvbT4KPj4+IFJldmlld2VkLWJ5OiBBbmRyaWkgQW5pc292
IDxhbmRyaWlfYW5pc292QGVwYW0uY29tPgo+Pj4gLS0tCj4+PiBIZXkhCj4+PiBUaGFua3MgZm9y
IHN1Z2dlc3Rpb25zLCBDaHJpc3RvcGghCj4+PiBJIHVwZGF0ZWQgdGhlIHBhdGNoIGFjY29yZGlu
ZyB0byB5b3VyIGFkdmljZS4KPj4+IEJ1dCwgSSdtIHNvIHN1cnByaXNlZCBiZWNhdXNlIG5vYm9k
eSBjYXRjaGVzIHRoaXMgcHJvYmxlbQo+Pj4gaW4gdGhlIGNvbW1vbiBjb2RlIGJlZm9yZS4gSXQg
bG9va3MgYSBiaXQgc3RyYW5nZSBhcyBmb3IgbWUuCj4+IFRoaXMgbG9va3MgbGlrZSBpdCB3YXNu
J3QgcGlja2VkIHVwPyBTaG91bGQgaXQgZ28gaW4gcmMxPwo+Pj4KPj4+ICBrZXJuZWwvZG1hL29w
c19oZWxwZXJzLmMgfCAxMiArKysrKysrKysrLS0KPj4+ICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEva2VybmVsL2Rt
YS9vcHNfaGVscGVycy5jIGIva2VybmVsL2RtYS9vcHNfaGVscGVycy5jCj4+PiBpbmRleCA5MTBh
ZTY5Y2FlNzcuLjc4MjcyOGQ4YTM5MyAxMDA2NDQKPj4+IC0tLSBhL2tlcm5lbC9kbWEvb3BzX2hl
bHBlcnMuYwo+Pj4gKysrIGIva2VybmVsL2RtYS9vcHNfaGVscGVycy5jCj4+PiBAQCAtNSw2ICs1
LDE0IEBACj4+PiAgICovCj4+PiAgI2luY2x1ZGUgPGxpbnV4L2RtYS1tYXAtb3BzLmg+Cj4+Pgo+
Pj4gK3N0YXRpYyBzdHJ1Y3QgcGFnZSAqY3B1X2FkZHJfdG9fcGFnZSh2b2lkICpjcHVfYWRkcikK
Pj4+ICt7Cj4+PiArICAgICBpZiAoaXNfdm1hbGxvY19hZGRyKGNwdV9hZGRyKSkKPj4+ICsgICAg
ICAgICAgICAgcmV0dXJuIHZtYWxsb2NfdG9fcGFnZShjcHVfYWRkcik7Cj4+PiArICAgICBlbHNl
Cj4+PiArICAgICAgICAgICAgIHJldHVybiB2aXJ0X3RvX3BhZ2UoY3B1X2FkZHIpOwo+Pj4gK30K
Pj4+ICsKPj4+ICAvKgo+Pj4gICAqIENyZWF0ZSBzY2F0dGVyLWxpc3QgZm9yIHRoZSBhbHJlYWR5
IGFsbG9jYXRlZCBETUEgYnVmZmVyLgo+Pj4gICAqLwo+Pj4gQEAgLTEyLDcgKzIwLDcgQEAgaW50
IGRtYV9jb21tb25fZ2V0X3NndGFibGUoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3Qgc2dfdGFi
bGUgKnNndCwKPj4+ICAgICAgICAgICAgICAgIHZvaWQgKmNwdV9hZGRyLCBkbWFfYWRkcl90IGRt
YV9hZGRyLCBzaXplX3Qgc2l6ZSwKPj4+ICAgICAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcgYXR0
cnMpCj4+PiAgewo+Pj4gLSAgICAgc3RydWN0IHBhZ2UgKnBhZ2UgPSB2aXJ0X3RvX3BhZ2UoY3B1
X2FkZHIpOwo+Pj4gKyAgICAgc3RydWN0IHBhZ2UgKnBhZ2UgPSBjcHVfYWRkcl90b19wYWdlKGNw
dV9hZGRyKTsKPj4+ICAgICAgIGludCByZXQ7Cj4+Pgo+Pj4gICAgICAgcmV0ID0gc2dfYWxsb2Nf
dGFibGUoc2d0LCAxLCBHRlBfS0VSTkVMKTsKPj4+IEBAIC00Myw3ICs1MSw3IEBAIGludCBkbWFf
Y29tbW9uX21tYXAoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZt
YSwKPj4+ICAgICAgICAgICAgICAgcmV0dXJuIC1FTlhJTzsKPj4+Cj4+PiAgICAgICByZXR1cm4g
cmVtYXBfcGZuX3JhbmdlKHZtYSwgdm1hLT52bV9zdGFydCwKPj4+IC0gICAgICAgICAgICAgICAg
ICAgICBwYWdlX3RvX3Bmbih2aXJ0X3RvX3BhZ2UoY3B1X2FkZHIpKSArIHZtYS0+dm1fcGdvZmYs
Cj4+PiArICAgICAgICAgICAgICAgICAgICAgcGFnZV90b19wZm4oY3B1X2FkZHJfdG9fcGFnZShj
cHVfYWRkcikpICsgdm1hLT52bV9wZ29mZiwKPj4+ICAgICAgICAgICAgICAgICAgICAgICB1c2Vy
X2NvdW50IDw8IFBBR0VfU0hJRlQsIHZtYS0+dm1fcGFnZV9wcm90KTsKPj4+ICAjZWxzZQo+Pj4g
ICAgICAgcmV0dXJuIC1FTlhJTzsKPj4+IC0tCj4+PiAyLjI1LjEKPj4+Cj4KPgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QK
aW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
