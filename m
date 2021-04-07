Return-Path: <SRS0=DRkM=JE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6235C433ED
	for <iommu@archiver.kernel.org>; Wed,  7 Apr 2021 17:57:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EC1B61369
	for <iommu@archiver.kernel.org>; Wed,  7 Apr 2021 17:57:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EC1B61369
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E2582400BB;
	Wed,  7 Apr 2021 17:57:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4XAYY2yWGZGy; Wed,  7 Apr 2021 17:57:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id BAFAB4002B;
	Wed,  7 Apr 2021 17:57:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96C8EC000C;
	Wed,  7 Apr 2021 17:57:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C770C000A
 for <iommu@lists.linux-foundation.org>; Wed,  7 Apr 2021 17:57:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EF10084B65
 for <iommu@lists.linux-foundation.org>; Wed,  7 Apr 2021 17:57:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=vmware.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IETdJPKNAnLL for <iommu@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 17:57:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 00A9783EC0
 for <iommu@lists.linux-foundation.org>; Wed,  7 Apr 2021 17:57:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grKYxVxGnn6aAF98FBP58OuZsle4vQHCTh3Y25Yr3TmBwYfPDtUjzXWzu7lpssXYb1JUI97yH8MCuWeNnIlEvEyVu7xEam+2xsEtnpxIfq01jxUprG82mi7DpGjXtAxOUMShf5Hro2AZ89QhqXZZidkj6fUi6sf1ceSzDjLz34ociQFjVMBvaIiYBGhZbQI/SkW6LVpDPcucluqsqb3cdoAjP0pjrxx5rr0KM8l5TQd1tM0hs5dsIFMsrjRweH9LS4mjgceMzX5OcNkxNwnB2Oe/tu3tf3we60XsgG/Oa4LVTYG/gT/rgFiSH1BzsP7Nw6RbK1TrXbfNW5LutRFR/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VWoAfBzWt9g5EE3WJW9HTz49rGQAZMqzIq76vvYE4RE=;
 b=jMtCSyoFMhh3rQtB2R9PjW0vpMDS6zI0b0/8uQ5WTTpeYOFEbEqORFMOet13HfwD+QqFbSkUu+1zXpb8wP7mdz/cBWjY+eC54WeJTRRWCGsmjeixETg7K7qLfB0HgQFf8XyHuCoEuZ6qiVVjBIEPLa4s3qYi5vxMNIuHSq3uveJSGZyB3/gyX4X6Px8bF6dOnrSjrggs1dlN+bt6iqxnxzwofzBgRTbGAHf0Mb8UTS/tZaPCpykf7xwhti9gquwoEOANbeaVB+Y8zDiQaQdbkSn6FOQEP8AX38JAr8fzb9OOuCQ1EB+moroxmANUWFTpiFfJlT68V4UcYNopm28p3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VWoAfBzWt9g5EE3WJW9HTz49rGQAZMqzIq76vvYE4RE=;
 b=WKYKPt590dr+Uc+EJHh5vEuog36qVpnebp4rAV8TbemGlCAJpuljVsi2KTOJ6nuWs5kp8hqNnUzDwLm6jLtJgQScqFePBvL5vaHSXcdz44WLOY2aqXB3pKug+VNhf8bTaWrfrMyhtIDePrU4jK6OtiG2MjlFlqirMgE9QrFujwI=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (2603:10b6:a03:4a::18)
 by BYAPR05MB4247.namprd05.prod.outlook.com (2603:10b6:a02:fd::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.11; Wed, 7 Apr
 2021 17:57:31 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::3160:ae0e:f94e:26b]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::3160:ae0e:f94e:26b%7]) with mapi id 15.20.4020.014; Wed, 7 Apr 2021
 17:57:31 +0000
From: Nadav Amit <namit@vmware.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/amd: page-specific invalidations for more than one
 page
Thread-Topic: [PATCH] iommu/amd: page-specific invalidations for more than one
 page
Thread-Index: AQHXK5TyxLWX6NQ3A0yiL6P30rBhzaqpV8oA
Date: Wed, 7 Apr 2021 17:57:31 +0000
Message-ID: <71C74038-943D-4041-B6FF-09A8C40CA204@vmware.com>
References: <20210323210619.513069-1-namit@vmware.com>
 <YG2C42UdIEsWex2L@8bytes.org>
In-Reply-To: <YG2C42UdIEsWex2L@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: 8bytes.org; dkim=none (message not signed)
 header.d=none;8bytes.org; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [24.6.216.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 05564657-13d1-4c8e-1492-08d8f9ee9daa
x-ms-traffictypediagnostic: BYAPR05MB4247:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR05MB424705B73AC45EC0A8E91451D0759@BYAPR05MB4247.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sgK+KOhz/td529rBW5y96j5BzS73MTQaKn7Vtklnq2JfhWneFy/0FKGxRZ8Z5JIBwPMDut5x1qafkSVNW5/nWOvJdbuWMWvR01X5Ccvi1o9+u6PkkvKqr1SIy7U4cnDZ1Zibs3Ojfq53IGC9sJV1pX8MU2McHOr47ydmfquz9drSxMipwsMgR7q6ZsZcfnnmcx01p3irskkBzXUE36FakvXWm1l23r/PwGcBnmrVYGuQuEPa0sr9hMNA/p5PPwktQaL4T5RFNQNCXvnn8ZtAv4SYII5k9TS3h6EYnFCtYWIGgaQ/TDuMX5arilRzeZi12afGrf8J9nhViPDbTdXiuAVvcHkRdR8xf0ql/BvTX7py9J5EQfwEj2kw4QUfhgDhtv70aGHghY+O9KQNZXQ2UrnlTsmvm05c05LlQ3p6WSe4f1fe1iqlWAZFcxqXOj/DCLVrFITPIQHwI0kBCO93JpCyjiPfJWzFYbjF9w6WDKs6/TcFTsEpxArOJH5PXgRUNkMc4lCdikoLCSBF5KFVOlKQQ/yTigonu9PPfBvMCuK3YBfZAPSW++zf0TDA25O7zlP5JZjwp8yvntiioXx6nOsar8jcptsXH6BgZXIk1WJ/LVsCLEnzhkaxw9+bxJNkDMtULCLdPKESVuqMueQW7lUNNLlzJ7waZMs0LLlvctwemMfN29/v1APaOIwQnJab
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR05MB4776.namprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(6916009)(6506007)(8936002)(53546011)(186003)(76116006)(54906003)(33656002)(6512007)(2906002)(6486002)(478600001)(38100700001)(86362001)(83380400001)(26005)(4326008)(5660300002)(66946007)(71200400001)(66476007)(66556008)(8676002)(64756008)(36756003)(66446008)(2616005)(316002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?EMDXjLAMER9JNNfzxBoHqtkg3AcefHoY7MWRQUHmj15ubR7INLFtJoYx+FBs?=
 =?us-ascii?Q?8Lvk1FRjzTK6TzFreyr/0CiDuwG7juc4SUwD0msE8f/Svu/PraXCKb251JEJ?=
 =?us-ascii?Q?3dTHeEIkqvZe1NXrYJfrEtkneP9qS8KKMKej8f00v8Qvu+COKs8b6hAlGscL?=
 =?us-ascii?Q?YiUWEruf9Zzn4drxD66B640jdYDXzFJULV7MeTL253NYBUmDcIu8b9NmcRqH?=
 =?us-ascii?Q?XE1yH/ChCprcrKFJrbMe4qamRdj6C4qpwEnvmJcbHJxUgAPkB7o+cU9EyfKm?=
 =?us-ascii?Q?nZjjW8JfjpFESjat4TSHpcOrxCW4882ZnwB7uTDKamlPLkH4CWz+l0R8DFmK?=
 =?us-ascii?Q?hQvRIV/yS2wZuhpjtx2XSijIlzKG7P2PUtwH9GimSMXw1I9iT5z4KR0equzE?=
 =?us-ascii?Q?WcJu9OSPbktLpnniPQcOHZZKcJAtPeagwApRfLN2z0VzpMdiQOBldCkW8pDV?=
 =?us-ascii?Q?JTh1QsDF0Plm923iuQKua6Ap0EOBISMuQjQ9ZuynVgHG9iSilipkgATa8jAi?=
 =?us-ascii?Q?DvfR08helHT1JerOx/9LL5rEgHZZoV/juD113uqioDSpClfCDbcvsBL0jlLA?=
 =?us-ascii?Q?9whesgOABig6tjwXvfhgER2ZfT3STA4rkNXy1Tv0Zr3sM+eymOyBPLORNhbH?=
 =?us-ascii?Q?qdmBbP49/o+LmN2brIoJwaW7UUAvxfswYpJWfyRceURzJ4GS3kyGnz7GfDtj?=
 =?us-ascii?Q?aJGYQDFXqnk+NiQJsUgqPNm+7KrrYtN/lMmqYr6ko7XM8KvosuQUvZJomMVG?=
 =?us-ascii?Q?qjv7+yZbevgfmRIaOM/2HxYCie7Nv4jTFidtvs/UAKugfOFPxZO5O42hqEfM?=
 =?us-ascii?Q?QY6+doIy8mU2sJ9AkgMfTNbITV3ZCcmBUo6Qhxm8IaznAStmMCVzhhcayuf6?=
 =?us-ascii?Q?/s8QV9EGFouiZY5aLuMe0lDnWUKiKGBbHA0X5qF03B0F7fCUYsojrP1lrnZ4?=
 =?us-ascii?Q?MzI2kMoJuZo7OLcd2IqFOL69BtefUQ4c0jyBKPx1CHF5jL5FoImZ452gl42k?=
 =?us-ascii?Q?OqpsnJ9KrkjYJrj1xneyIq2g/1QgLe9V2ccO078edwBbx8M6+WmY3CiU8M6Q?=
 =?us-ascii?Q?RxMLeruPUda1oEJPduxQTKFQ74xbgvDlDmQJqkhO8yqK7m5o6Db+b2CFV4IS?=
 =?us-ascii?Q?wPA05476OWYMP5k0b31+C2mu5MlfK/Uz3BiD4aKCTHGFWQjbS2LPc3hRVOgR?=
 =?us-ascii?Q?gVeiFB/8Dbjr0k4lz46cQEZOPVliGCMe9/fdn4+IlrM5yacUa4yqyWqhRjsj?=
 =?us-ascii?Q?c528AxgwzTDLwLG3grtPgiWIj/56FUwTPcTCghORoJDOdaQZjbKNcp9T3Ntc?=
 =?us-ascii?Q?pahWHcbKJ7qJB6n0+gv6Lqof?=
Content-ID: <467294B44FA1614E98EE78DE5B06327F@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB4776.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05564657-13d1-4c8e-1492-08d8f9ee9daa
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2021 17:57:31.4897 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sumJMsr4qg/9ZKeMQ3MtWyFImrkZBbIQhHelErrgYMc7nwvW/MUdBLAN8XPn/9BgQBAbH/ewoALI+a69J642wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4247
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Will Deacon <will@kernel.org>, Jiajun Cao <caojiajun@vmware.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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



> On Apr 7, 2021, at 3:01 AM, Joerg Roedel <joro@8bytes.org> wrote:
> 
> On Tue, Mar 23, 2021 at 02:06:19PM -0700, Nadav Amit wrote:
>> From: Nadav Amit <namit@vmware.com>
>> 
>> Currently, IOMMU invalidations and device-IOTLB invalidations using
>> AMD IOMMU fall back to full address-space invalidation if more than a
>> single page need to be flushed.
>> 
>> Full flushes are especially inefficient when the IOMMU is virtualized by
>> a hypervisor, since it requires the hypervisor to synchronize the entire
>> address-space.
>> 
>> AMD IOMMUs allow to provide a mask to perform page-specific
>> invalidations for multiple pages that match the address. The mask is
>> encoded as part of the address, and the first zero bit in the address
>> (in bits [51:12]) indicates the mask size.
>> 
>> Use this hardware feature to perform selective IOMMU and IOTLB flushes.
>> Combine the logic between both for better code reuse.
>> 
>> The IOMMU invalidations passed a smoke-test. The device IOTLB
>> invalidations are untested.
> 
> Have you thoroughly tested this on real hardware? I had a patch-set
> doing the same many years ago and it lead to data corruption under load.
> Back then it could have been a bug in my code of course, but it made me
> cautious about using targeted invalidations.

I tested it on real bare-metal hardware. I ran some basic I/O workloads
with the IOMMU enabled, checkers enabled/disabled, and so on.

However, I only tested the IOMMU-flushes and I did not test that the
device-IOTLB flush work, since I did not have the hardware for that.

If you can refer me to the old patches, I will have a look and see
whether I can see a difference in the logic or test them. If you want
me to run different tests - let me know. If you want me to remove
the device-IOTLB invalidations logic - that is also fine with me.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
