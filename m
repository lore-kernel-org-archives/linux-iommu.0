Return-Path: <SRS0=dQER=OH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139FDC433FE
	for <iommu@archiver.kernel.org>; Fri, 17 Sep 2021 10:44:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B00FF6120D
	for <iommu@archiver.kernel.org>; Fri, 17 Sep 2021 10:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B00FF6120D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 79B5E80D21;
	Fri, 17 Sep 2021 10:44:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X4s3BpyB7yGi; Fri, 17 Sep 2021 10:44:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 58F3B80D09;
	Fri, 17 Sep 2021 10:44:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E957C0011;
	Fri, 17 Sep 2021 10:44:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E5C2C000D
 for <iommu@lists.linux-foundation.org>; Fri, 17 Sep 2021 10:44:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2A03780CE5
 for <iommu@lists.linux-foundation.org>; Fri, 17 Sep 2021 10:44:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xyJOKNrpDIv7 for <iommu@lists.linux-foundation.org>;
 Fri, 17 Sep 2021 10:44:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from de-smtp-delivery-102.mimecast.com
 (de-smtp-delivery-102.mimecast.com [194.104.111.102])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 473EC80CD6
 for <iommu@lists.linux-foundation.org>; Fri, 17 Sep 2021 10:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1631875442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3fkICs2NUVZw+X2zzeXCMA7XH+sCYDVqsCZWlrdy5Ss=;
 b=C7yDkLc/0T8/5YgOp/fYUFJIZuf5CWVTNek44KiBVMFUmLfrl08fI8SnL2s5IZ9J6UQ+Am
 vYHkn9M77BL/9w+H5UESSbntP9H+MS7ItmXHMXuZTy7vsgosRrzaNsWQuKGwexwxSjKgwT
 UfdophElqd/njBExs4tppXsByXh+r+w=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2051.outbound.protection.outlook.com [104.47.13.51]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-16-DiK1aySnOY6fT0fXkH_g7Q-2; Fri, 17 Sep 2021 12:44:01 +0200
X-MC-Unique: DiK1aySnOY6fT0fXkH_g7Q-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EG3bnqdiIIvcL4mJmgRBBqpzMwrrZJ4QeuWPEaA+caDYfYCdtDEhuHxExVBE/Fl6GbSvg6NxXDTn0SZO17eOvHwezoOv1gGUXJTxgzn38oVTYJnuZ59sDG8ofgIF5zTJpxTkXtEE1pzfNzGHr/mPyWAoSXbvYKkNhPo8RnDwjiS3Ye9bUacKCnRChtnqsfvIJUp8vnzA6pg6RfBddbXUT2hXsIHAXw2Dok5Z+Vg76vHv6sVz6fY9aPGshJjtJEGxHgNiy744oXA/Ty4GVC/uk43danmx53MVJgBxJnkldQQxWBPv3vsTASewOx6IUHyq4ouTVFI42itBZC+wUFk8Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=3fkICs2NUVZw+X2zzeXCMA7XH+sCYDVqsCZWlrdy5Ss=;
 b=eoiwDI3QqZn5G6TkbbWM2bMI0/XyH5iDwUBYmqSnjKtzkpc+ROkSyDsRGSi+i0HGtL6zLJNh4+KXCB8gdrQbcEROB0SuMC3M382YJHyJg7uK3H4V3zwt9R5IJ42b2TFvqgbKAoxL235gYZ0TgSm7CSxfs5SwRwdkfqbvrgMyZsFFcygSW3TcpyHE9LVEOjpbPgFRH9x2x0mbmRsUNOkgiIvOyC0IRSy6LNaNUubajbu8oWo/1nD+0yV9J15w1fcL0KSFI8tjBArGrxoGQ7AoG6c4LqlJSYYE7ACX+k+VwOFEnhoBj4EixwrGQFS/ZsaT6svZr8rm0mHmu1EMk7XgCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=none action=none
 header.from=suse.com;
Received: from VI1PR04MB5600.eurprd04.prod.outlook.com (2603:10a6:803:e7::16)
 by VI1PR04MB7087.eurprd04.prod.outlook.com (2603:10a6:800:12a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Fri, 17 Sep
 2021 10:43:57 +0000
Received: from VI1PR04MB5600.eurprd04.prod.outlook.com
 ([fe80::4d37:ec64:4e90:b16b]) by VI1PR04MB5600.eurprd04.prod.outlook.com
 ([fe80::4d37:ec64:4e90:b16b%7]) with mapi id 15.20.4523.016; Fri, 17 Sep 2021
 10:43:57 +0000
Subject: [PATCH v2 0/4] swiotlb-xen: remaining fixes and adjustments
To: Juergen Gross <jgross@suse.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <164e58ff-2edd-2c99-ac3d-e18eb06ff731@suse.com>
Date: Fri, 17 Sep 2021 12:43:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0041.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::21) To VI1PR04MB5600.eurprd04.prod.outlook.com
 (2603:10a6:803:e7::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.156.60.236] (37.24.206.209) by
 AM0PR10CA0041.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16 via Frontend
 Transport; Fri, 17 Sep 2021 10:43:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ad8c43a-c84c-47b7-8258-08d979c80d0b
X-MS-TrafficTypeDiagnostic: VI1PR04MB7087:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB70875114D12052171888F5CDB3DD9@VI1PR04MB7087.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IRQwFcetYoGR3tRBeWr+YtIloZxjnKjyVhV/sOKN+zMr8anVIoZeLGCp/cHQmBmdMhow06JNz11oZrbni4bOKpcS0v2f6LoZ2ULKFf6ThNujsrkxl9oOWo+yDPLEqvAEKn4HvI+Z82bSSpMPmbpyUfUojjIqBb8ffkH+IbEPkjQc7Vy3yCBeTt4NLibAr4KvxCA8DCJIZvxOYdW+wP31rupjWH2LEv9rsIhIxfynB5nb6J5K804TQZTQ/ZyjCwmbRemDKgIx0IxvdCrlauDfie+xvuJufSqOM0lI/WraeI5Alf/3s58x546K5CqUxCBO1w7fqHhhTdV2QYoDu5QpxqhRD5DjivRMfnRls2KQLouMzL8ueKsZfVeWsZbU7GzlK0KKD1N2I4eYdmIDL6vJPSmqbAX07toj3G1n3kc7yPENglowPSvwJFdAtW2vbrN4vJTg7xC64Pl3MyY+NrEfAqUJ3NZkSZfBCPFruvDA19kJCK/xySZBPSGt0uczpS1fsfK+DPLL0mxNeLNu+NV6yzHRPdVH9IzxeP0oBGMbQCYpP+scnpxvAgRIiuEoYtKHfazQ9McWn/U3VGBYGWZpO3rB4f2ToMgQM3hQ+pQXYb3cquKnh7p3B4b6ekBtWzMUwu/QxeoNCcbgwS+dD8vRb7G/R/oBEjqjHcCkfUT8CiQs3rrt9wH9Xz1io/Qp/uO/bwnP1xBh+zFJrOeCj1cUZAxuDW4Pa67uWgV1tC3zmfY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB5600.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(396003)(346002)(136003)(376002)(39860400002)(6486002)(36756003)(186003)(5660300002)(8676002)(956004)(26005)(86362001)(2616005)(110136005)(4326008)(16576012)(4744005)(66556008)(2906002)(38100700002)(316002)(66476007)(54906003)(31696002)(83380400001)(8936002)(478600001)(31686004)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnV4VXp6SE9mSFNldkJoZ05xcmhaYnJvMEJXUWRxY0kyOWU4Y2d2RkF0cVZQ?=
 =?utf-8?B?Y3FleisvYXd1ZGJpdXBTUjZsRG9lSXlyaHl6TnJWL1lSbFhCVXRvOEdMandm?=
 =?utf-8?B?cHdkclAxZi9hTzF5WnFCUmdPakIzK1Z4OU91MUJYVlYwVGMxQkRTbW1YV0hQ?=
 =?utf-8?B?eDJGUkxXVUwzS1lYRnhwbnFFRU1HQXJOemkyQVRxM25oNDFvL1lXZFNXMGVH?=
 =?utf-8?B?V2piMTdiaGFpcTNQbnA4L0wyRjF1a0paV21SUERVM0c0LzBKblk1QXBhMmFR?=
 =?utf-8?B?MGRxMTgzS3g5Qy80MUtPNjdzRGxLYWpROTQybHBDWFI2M3Jla0xhU2FXejFR?=
 =?utf-8?B?U2luZmJXalhsSkJDbGlUZTJNOHZTckdQMWJLeExBRGJpUHNjUWowOWkwU1g0?=
 =?utf-8?B?aFVFSU9LNS9zbS9paVVocnMvY2xUUDk5b29yWHlYd21VOUlUTURKejZ0SEEv?=
 =?utf-8?B?UkxveGR3ZmdGeDgxbE85aGN0L25KNmlmQkxMUS9NRTEzQUVaVXNYNlh2eHpT?=
 =?utf-8?B?U0hFN0dCNmVRQ2NiaFlYR1c1Qmg2dTc3NnpvQVlvTTlRWFNUVjhmSjF0STBm?=
 =?utf-8?B?Uzdla21sN3FxaUk1K3BSenNGVGRGSDgzb0MyM29KZmtnck1IUFh0K2x6dm1N?=
 =?utf-8?B?Nlc0MTgvZjZDNDVNNE15aDluYTR0OFFnb25hUExiWnR3bXM1cWZRTUx1VkNy?=
 =?utf-8?B?S2F0eUtZM1lDVDZqcWpsblViaDhoR3J6WHZlMUU0eGNrMEF0TFRXK2dRZXJ1?=
 =?utf-8?B?MlV5K042dm5tU2prVm44VGZwNGxUTGt5MDd3b25GWjRaeWVPWU4yai9XTndw?=
 =?utf-8?B?NnNBeFdvUTBsZmFzNGtka3VYVEtuaEJvazh0Skl5SFJpWFBtdHR3UWF3aitQ?=
 =?utf-8?B?Q1hkMUxFVTI1ekJPRlRVRk16VnlkdHprb0JyNGdSTHlGSVAzYlI0bHU2VVMr?=
 =?utf-8?B?bEo1NytBUzRSczJSbVM2V08wS2NhMGZZVlRlT2RjbE9qSEdHMkU3ZGIwZGtx?=
 =?utf-8?B?cXEwclBhK0FzVkIvY05BanJaMTh4akdxK1N4Vjc4Rm9PRFY2ckRuZVdsQUdo?=
 =?utf-8?B?QWhoOSszaGZ4QWluZnZVczM2QlhjaHJNSzdqL28zWGJDUkROcmJ6NTJlSjhp?=
 =?utf-8?B?TUM1Z1lETG50Z3NxbzRUSlJJZm5yckV6cWdaWUJPSVVUeG5BVDN0UWlKcE5a?=
 =?utf-8?B?SlEyWHhOeFVCU1FwUjN2SmoyM2VYNXBHcXdVelJxV2RGNldqeWtpbzF0R1Nv?=
 =?utf-8?B?QVZwMy8yMVgxNDczN2pwMy83R09KdlZiTEI0Z3paWHFPNm9TNGZzUFRrZlRz?=
 =?utf-8?B?NU44WHJBc3BJS0cxNjNjRHdjUUN2S3R2Y2l5THg0OEdIYmUwbmhwZFhnejkz?=
 =?utf-8?B?akdyZDlFKzB5RXlLSTNWc1FndVlxVmRVQU8vd1dyUXRHSjRubHRyWkhmVW5U?=
 =?utf-8?B?NXVEb1BTTkZjSDFwdVFQN2RzcmJpSmNpRkVOSlMxeUFmZDZJZWl3UW9kdTVV?=
 =?utf-8?B?THJPUUViL08xa1oxeHhydmwvZGpwdzFGc01UOWdGL2NBNzhocEhqVGxYY1Mw?=
 =?utf-8?B?WVZRY1lpOVBnOGUxZUZ3eldxQSttYkJFNFZrOHhvRllreWlGUXRCQU9wOGdq?=
 =?utf-8?B?dlh5ZHRtSHc4b3BMK0NRM3EvNW1TcGRsd0dodHdralJOK1dqTFkxQVA2OTc5?=
 =?utf-8?B?QUY3WEY3ZFR2bjRxYnM4c2JPUzUwOElGZlB3T0hYRWNPQU1QZkZZU1pjcG9L?=
 =?utf-8?Q?21TaPGaJ6xAhpr62qCt52smv5IZm/AEGvAJOCra?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad8c43a-c84c-47b7-8258-08d979c80d0b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5600.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 10:43:56.9593 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AWGIGYVkloBgfHZ6GNeFSicjF0b+mu48RUrOma40TZQqqdWTYF/JyRCi/2mtc4ez8CKMO+5valWTjm1qLcoYPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7087
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Konrad Wilk <konrad.wilk@oracle.com>, lkml <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "hch@lst.de" <hch@lst.de>
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
From: Jan Beulich via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jan Beulich <jbeulich@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The primary intention really was the last patch, there you go (on top
of what is already in xen/tip.git for-linus-5.15) ...

1: swiotlb-xen: ensure to issue well-formed XENMEM_exchange requests
2: PCI: only build xen-pcifront in PV-enabled environments
3: xen/pci-swiotlb: reduce visibility of symbols
4: swiotlb-xen: this is PV-only on x86

Jan

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
