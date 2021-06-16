Return-Path: <SRS0=eGnl=LK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BC5C48BE6
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 15:34:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D530061076
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 15:34:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D530061076
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A13E560AAB;
	Wed, 16 Jun 2021 15:34:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7NQuyQKSYOdw; Wed, 16 Jun 2021 15:34:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8FAA560AAD;
	Wed, 16 Jun 2021 15:34:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64F5DC000D;
	Wed, 16 Jun 2021 15:34:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91178C000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 15:34:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7EFEA60AB0
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 15:34:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8DeUsocKKsHs for <iommu@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 15:34:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4263860AA3
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 15:34:05 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 15GFWNBK009743; Wed, 16 Jun 2021 15:34:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=0UVoaecywuccJw/TpunixyYtBjn6fc61YbswWJ1qBDg=;
 b=xzYNaGlmS81YcWGLdCXWjDeqK3qHaVRTaZppPscrNcgiQKthPyTEvrLp12IleqbFchCn
 3fqHKLCzrP0WtIayRpQXHVxDEUs6DMX9Pub1WZG+/WPzDhOyei4Wu95RYOMHm9RKjet+
 0sKNFEO9vYUHY1sPPHz4dWPtGapHn8zbd/AKJ4NaCbeCvAwrQmw0CscTiTBZvywQA47b
 6Zcj0bwKMj5K3Mc8/3TNv3yKGKgXrEJHnZon39SIZe6XhhHG1eaqiy6eXdIvkPuDtQ9d
 oywuvdPaitRcty5oBqunOWGpME60nQMD0wFNBffuN5IO59VxsuG5nHePAPhSVD/7j/lf uA== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 397h4bgenf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Jun 2021 15:34:00 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
 by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 15GFXw3m083559;
 Wed, 16 Jun 2021 15:33:58 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
 by userp3020.oracle.com with ESMTP id 396wawf7yw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Jun 2021 15:33:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rg2n1noyrhwtCwVqdSSlxhvxsIrcvjeGHvnlXovhVl0qIPcq+tsEHWYnOGqA8lbum1UHUqjsmi7gDpo6zf86ArJk/KhUk+wdqXvt1DevePru21nrG67BRVaHg7W4jq53YnrUoz00zbnTMGL3HSCLDyg7BwCQhh2NLmdHBdSExhecJs8xvzHKOGdRhK1Na04e1puxSLOnmU0qsplwR2Bo9RL3CGZmQkotq9LhzQdArDX9ZIUrUE3FA8VitciAHhEa8IRzVs+CqZZe5W/S0bb6mxwW2Q8OADbt7ouBMHFd/MZdqigPw65/dQxC/LT7dNUsB3KwUv2IJQSeCs/YJvhZEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UVoaecywuccJw/TpunixyYtBjn6fc61YbswWJ1qBDg=;
 b=HeNgp0assIB3YXP+Dlyn0Ha0p85OqyXh5tgI1WYn3tQyqqc5ON0fIXbD8EKJCUnCBX4zmI5MxIFQvAS2pvCqizgxM9yCB7UtNbTXIjZEK6nfbwqi8w4PvlStwwwyBAek+vHNR9N/pTjq6F8hCQzFCwC27wXG2kDzJ6sKQeDqkt1IogDXn2grnH3yxW6mR3hoPKR0/C5JS2eDCSGP2RfHuoOG0S4eJkn74k82adNar0MglDBmkhEM+5hpTyl4BUzu3vD8Z/hm5ohCF2r566IMAhXJd/52qgPwDxJ3Aa6gLpRV/jc+JKPhCxyciIPuLKseiZ0o084cfFAg6GM1cZ+nNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UVoaecywuccJw/TpunixyYtBjn6fc61YbswWJ1qBDg=;
 b=WwYocbkNqIm7NTJS71Za0BtUV0/8JymR9QDiJEJqMn7AeGUDQKKzQyJ9YEoiC2+8hMmu6xlhkrlvY0Kaslwo6r2KfMcTE9AAUlbXFVj4q0UDWHSxDIVMS0/fu+z+m+j+9zxUgANfkmen8kyBj7cTDhbBZ9pdjlOuFzWELx8XFaQ=
Authentication-Results: epam.com; dkim=none (message not signed)
 header.d=none;epam.com; dmarc=none action=none header.from=oracle.com;
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by MN2PR10MB4302.namprd10.prod.outlook.com (2603:10b6:208:199::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Wed, 16 Jun
 2021 15:33:56 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::78a3:67d:a8ca:93cf]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::78a3:67d:a8ca:93cf%7]) with mapi id 15.20.4242.019; Wed, 16 Jun 2021
 15:33:56 +0000
Subject: Re: [PATCH 2/2] swiotlb-xen: override common mmap and get_sgtable dma
 ops
To: Christoph Hellwig <hch@lst.de>
References: <855a58e2-1e03-4763-cb56-81367b73762c@oracle.com>
 <20210616114205.38902-1-roman_skakun@epam.com>
 <20210616114205.38902-2-roman_skakun@epam.com>
 <2834cdc0-534c-4f07-1901-e468a7713c1f@oracle.com>
 <20210616142148.GA764@lst.de>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <83353b34-2abb-9dfc-bed6-21d500abf49f@oracle.com>
Date: Wed, 16 Jun 2021 11:33:50 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <20210616142148.GA764@lst.de>
Content-Language: en-US
X-Originating-IP: [138.3.201.8]
X-ClientProxiedBy: SN4PR0201CA0056.namprd02.prod.outlook.com
 (2603:10b6:803:20::18) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.74.102.136] (138.3.201.8) by
 SN4PR0201CA0056.namprd02.prod.outlook.com (2603:10b6:803:20::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Wed, 16 Jun 2021 15:33:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccfe135f-8924-4ce1-5686-08d930dc2757
X-MS-TrafficTypeDiagnostic: MN2PR10MB4302:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR10MB4302657A2BD264A00DC6F4C28A0F9@MN2PR10MB4302.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IkwnElf5yfGgg7noxftFNzPVp08pj/U0UCUGUYm/PJljPJxJwy+tr3zvTwcYYrQgWeupXHEN+NmhF+G9smoCUZQfsLhndz4qKN6qereBElAwod6M6SsDKEzf9NTZwzasxO+Rcmvzb5yJtiQC6OhendVZymQLbY9VOu1tMaHdifjpiMNhg9YxbxWFM/QO0rSqv+hNqNDSgJ+DI+tAw5vK7SzgFlXk0DFepC2t58Qs5Jlrt0BS8xOs5LcZFKpFyCnR/pd1geGoKeWB2GoPx2B0ui04LP/htq42HjfaFdUzBD1DcthY5b4kGLLYadWrhAeMV1ZhzAd6ImC8YgxA2VcxAc+yc/aw7AfMjYskIJCrIf6Rs3TO953sfpLaibccs9BCbgwc+vPLXt9etKqZDa9dHDXjhty2VCfsTVby3raDH1faVTdG9MZineFCpWALwuneU8DZO8PGo54lZMXRnA70/1VEz9Yzi/8Z0H5NX7v7grEBkJZUWVCiXlaihSXaHGiFKS9jYqeZ8amDoWkFgQy0+W/BBgXNUZIBERHNf/golH2ZsUk5u+zdklY52H57dPC/NZ7olkdNLfZoX2w2/J0TltQnv2rX/y4ulFkZtLn9lCFrMUjWud6nLGB+DfZwBLBT44Frvh7jPqPWwqAWP9xY+gojZxmwq8DPKf0LhCTPUr7qEoeqALk6cxGC4odJ6+Co
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5009.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(39860400002)(346002)(136003)(366004)(396003)(2906002)(8676002)(316002)(4744005)(4326008)(36756003)(54906003)(186003)(2616005)(8936002)(956004)(16526019)(31686004)(44832011)(7416002)(31696002)(86362001)(6916009)(66946007)(5660300002)(6486002)(478600001)(16576012)(66556008)(6666004)(53546011)(38100700002)(66476007)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGw3a05mdjZiNFEvV3l4S1lkck1HWUttdVdYZVNra3hFazRhdGw2bGw0eWtV?=
 =?utf-8?B?T2I5czBPRWsrdWFiUDB6QUxkc0dvT050Q09SaHh6bkViR01EWmYwVXN0VkZM?=
 =?utf-8?B?WkxxeVFCZTdhVDdtWU1sT09tbWdLNFlMUTRFT3ZId2FTTVlMZklEcmUxOWZp?=
 =?utf-8?B?bmt4ZFhpU3E2YXlKR0xIbVhwM2lZYzdscWcwTnNhK1JHaFg5WFk3WTJhcURo?=
 =?utf-8?B?L2UvV1RWcW1nbVc4RE1qcTB6RHR4cVEzbXZKcU9iVkt1cjVVdEhPamh4TGpH?=
 =?utf-8?B?NWRHQi9LYTlWZmFVZFVVd2VsRlFpeXNmSWdFUDJ4MEs2REMrdGJleE1lWXpU?=
 =?utf-8?B?aDdQZTh1RUJsVnFCUUxVWWpLZE5yQ3JpSStxeWxxZ0ZsNDJnZ1pHY0NXWXBs?=
 =?utf-8?B?Y0NWcW52QnYxSFliRnA4Y00wYjN1THQ5RHhsUnNyUzlSTVVkdjB2dGtKY2dV?=
 =?utf-8?B?S2U2Q3RrY2JUcC9kcnplbkpDaHBUVm8wZWdGS3Z0dGdDNXVBNXlxVlRUc1N2?=
 =?utf-8?B?d0pJdWk3WXVZOXdIdHYwS04zdFRNVGFidys3aHdCMlhHbUJ4R3llRWtYU3lK?=
 =?utf-8?B?ZnpZZ211SFZRWWZaSlFNVEVoSUs2bFQxZzE0N1V0VE5YajdPRWp0M2ZOY016?=
 =?utf-8?B?bEtuMUNrRnZGZThJSUdnT1hrTlNWditMVERucS9aWk9KTW9HSi9HNGZodVhq?=
 =?utf-8?B?RTJ5WDZvWjAySEFCcDRPMkN6NkVOR3FTU2xPbFRkRzdEenJmK01xM1dYSXBJ?=
 =?utf-8?B?SGhOZVlTaUZpcnlOb3c3VmJMait6QjZXSnE5cldxQTNKRUtKNGt1ME9jUTRy?=
 =?utf-8?B?UFNlNHl1K1p5cDN3b2k5Mlc3QnBBY0ZkaWgvYUdvMlR3V0hXN2M5dkN3VnNI?=
 =?utf-8?B?VzgyZzQyZm81NDBYRnJhbDgrVFpMNS9qQW9oVWI2b3BOUlVySlFMMmNkNVNv?=
 =?utf-8?B?NG42L0wrOE9MMW5YeXpkME1xN1JOY0E3Y2dJbVJ1QXZDTDhoNGxTSHU1NUwy?=
 =?utf-8?B?WmhEVEtCSE5maEdTenJDeVdSdDgxMXI1Z3lySllXMHY2b0lTTjI4OHdBNUZ6?=
 =?utf-8?B?OW1vRWlZcG50NWl6MXZvWmU1bm5lZkE1aEtiSkpCclJNc0hVK2hkQm5OMlB5?=
 =?utf-8?B?T3IrN25EVFhhRkpkQm95R25oSEVLTXB6SXRLV2p4YUVTOENZT05qeTVsRnRK?=
 =?utf-8?B?d2FISEEzdEt2T0VVcW44K0JZMC9FR2xuQU1IZndESDlKaVdJcFExVENtbWF2?=
 =?utf-8?B?dTViT3NIMm4xU3liNUpXSFBtYXNzdTBrb0pBUUQ0R0VYM2lZaWtJczhkTHlo?=
 =?utf-8?B?SnZzd3dFQlVhUE5iT05TZDcva1REMGNNYm1nVWNLUjh4UU1YZy8xaEpiL2E5?=
 =?utf-8?B?VjIyTzNGQzZpVzVCcEo3Tmg5NmxRSnBRbHVzT3lGelpWTm5TRnplelVLWjRB?=
 =?utf-8?B?ZVpEc1pPcXdqVlVqTUh4a2hBRnd5TmxoUHVSWkZKNkQ5YWxqZFpBRmNhOWZG?=
 =?utf-8?B?aGFuaWlQZE4yWXVaR1ZuM2NMV1VWaUJCWlZIODZxOXB3S1ZseUI3UDl0cS9j?=
 =?utf-8?B?YmQyTGJ0OHJLM1hldXlraWFwY0drTklybnlVZkttYWErb1Zrb1Q4VVAzdE1T?=
 =?utf-8?B?QStXYnc4VE9Camp2Y1l1QWk3S0lBcWlydHBXbVdxT3BZK1ZjbGNsSWJBSDFE?=
 =?utf-8?B?OEtwSUVqRTF5L1ZzWHQ4Q0RpU2JRN1V2cXdPbVU1MW5oakJKNXlUMFZ3d1J1?=
 =?utf-8?Q?WSNHruuYoNZyWdLKt+pYnAFdULGUq060N5TkWCA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccfe135f-8924-4ce1-5686-08d930dc2757
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 15:33:56.2451 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: erxKNzPRbruHC/K18avd5iS39eZ0XqN14JHxHYH5TUulaKNdM4zBFHW58NtPXdqKdjmt7MQcNIfqJb+3L5RaqaknhiqjWpfrsOnXuNM0uJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4302
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10016
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106160089
X-Proofpoint-ORIG-GUID: Lv6eqeZvCVRLAZrZKufO7wDmYVG0EeVG
X-Proofpoint-GUID: Lv6eqeZvCVRLAZrZKufO7wDmYVG0EeVG
Cc: Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Roman Skakun <rm.skakun@gmail.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 linux-kernel@vger.kernel.org,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 iommu@lists.linux-foundation.org, Andrii Anisov <andrii_anisov@epam.com>,
 Roman Skakun <roman_skakun@epam.com>, xen-devel@lists.xenproject.org,
 Volodymyr Babchuk <volodymyr_babchuk@epam.com>
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

Ck9uIDYvMTYvMjEgMTA6MjEgQU0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+IE9uIFdlZCwg
SnVuIDE2LCAyMDIxIGF0IDEwOjEyOjU1QU0gLTA0MDAsIEJvcmlzIE9zdHJvdnNreSB3cm90ZToK
Pj4gSSB3b25kZXIgbm93IHdoZXRoZXIgd2UgY291bGQgYXZvaWQgY29kZSBkdXBsaWNhdGlvbiBi
ZXR3ZWVuIGhlcmUgYW5kIGRtYV9jb21tb25fbW1hcCgpL2RtYV9jb21tb25fZ2V0X3NndGFibGUo
KSBhbmQgdXNlIHlvdXIgaGVscGVyIHRoZXJlLgo+Pgo+Pgo+PiBDaHJpc3RvcGgsIHdvdWxkIHRo
YXQgd29yaz/CoCBJLmUuIHNvbWV0aGluZyBsaWtlCj4gWW91IHNob3VsZCBub3QgZHVwbGljYXRl
IHRoZSBjb2RlIGF0IGFsbCwgYW5kIGp1c3QgbWFrZSB0aGUgY29tbW9uCj4gaGVscGVycyB3b3Jr
IHdpdGggdm1hbGxvYyBhZGRyZXNzZXMuCgoKSXNuJ3QgdGhlIGV4cGVjdGF0aW9uIG9mIHZpcnRf
dG9fcGFnZSgpIHRoYXQgaXQgb25seSB3b3JrcyBvbiBub24tdm1hbGxvYydkIGFkZHJlc3Nlcz8g
KFRoaXMgaXMgbm90IGEgcmhldG9yaWNhbCBxdWVzdGlvbiwgSSBhY3R1YWxseSBkb24ndCBrbm93
KS4KCgoKLWJvcmlzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
