Return-Path: <SRS0=ylBP=CQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5A7C433E2
	for <iommu@archiver.kernel.org>; Mon,  7 Sep 2020 11:25:44 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E182206D4
	for <iommu@archiver.kernel.org>; Mon,  7 Sep 2020 11:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="j8sCN6WE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E182206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 037FA87117;
	Mon,  7 Sep 2020 11:25:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wagYM-CblKVI; Mon,  7 Sep 2020 11:25:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id CF19887116;
	Mon,  7 Sep 2020 11:25:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE2BAC0859;
	Mon,  7 Sep 2020 11:25:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E72D8C0051
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 11:25:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id CEAB08671F
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 11:25:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1eXX6wUbRfxC for <iommu@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 11:25:39 +0000 (UTC)
X-Greylist: delayed 00:15:14 by SQLgrey-1.7.6
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 925558671E
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 11:25:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QoTtfg9xAtE1rnEDShWPlE0BTnU580fGEiDziLGuGU9HVQZoF5n6y+QilUkA09M5PPREK0VCoFoctcuYDS2XYn/TkqX9FJXiuwZu5JZPJEWvbAMwBfy4EUaAu8kU/oy2wh/NMI4ujXtjbX9/6u/4vhLxd9G4h7hYo8KYIfpb37qWKb/OPAsjyEeXWWukWWo3wmsLJ8cE8qZmX/XBnD1BXXlQbIgMdTiTn0R7KtKKCEpKK5Y6bycYT8MJj/dqu+5vGMZ7yJI+iZPaDzjWtmFKTdL3z9Fkoq8sSd8ooAG3m+Ft5mmUk6O/cPR/SJ1kiL+DUN55ZwW5xVDIAur4rS5vsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G06hW8FfUbp5DI8xzd5xPt5Uu/cMM1xC+yNnu8X/TdE=;
 b=VM65JpVrj0vLTFwYQ78jd1DT+C/Vnic6IPZflfuv3FcZTr/Y4Hfv0XSi1JUZsRHj/kjmSKd5HuaiuYMa7yzFIFGJKlSPrfroBQQcoJa4vMrF2kwsBNZjzUjrx7shGoyGBczTLMy5o2PKtIapwTffaP/vL6hgUCnuZ/EWUn75qDmJI0qzWBkZfFmyB2Bx+Mo1cHVzOondqaENkJZm8GrAUxlhqqcFtmDMc+Mxo547P89gOxNovBQrAPfOHCqZUiia9NBZAkp9oPOXP5weBwVCYmP4wjSzDSqK6Zm2DyLY5gnGCXau0D4FHg6P9T4P4UDg3l5bUNTBwQU3GwGx6msBjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G06hW8FfUbp5DI8xzd5xPt5Uu/cMM1xC+yNnu8X/TdE=;
 b=j8sCN6WED5NS81KyChxU1bNawj5NRg++XwbsG+nIBA5MLydXPmTLXlxBt0W7sJLxf3sfUBYgM/i3M1T2VO9dk0pST3BAnr673pLNBn8ts2IJUc1PlZ1zqaXmXDxGRdQfi6xx1kD2VSv/uFgco+hDv5aXFeeYVogEB4c9B9Ioimk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4208.namprd12.prod.outlook.com (2603:10b6:208:1d0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Mon, 7 Sep
 2020 11:10:22 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60%6]) with mapi id 15.20.3348.019; Mon, 7 Sep 2020
 11:10:22 +0000
Subject: Re: [PATCH 0/2] iommu/amd: Fix IOMMUv2 devices when SME is active
To: Joerg Roedel <joro@8bytes.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <MN2PR12MB4488D6B7BBF98845DF796E0BF7540@MN2PR12MB4488.namprd12.prod.outlook.com>
 <34db343f-cd23-09af-3bc5-29b9d385f85d@amd.com>
 <MN2PR12MB4488BF7DDE700378F7B2776CF7540@MN2PR12MB4488.namprd12.prod.outlook.com>
 <20200828134639.GW3354@suse.de>
 <60067932-dbf4-d67b-cf11-4dd2b016ed63@amd.com>
 <MN2PR12MB448849D3AD019749DB64A146F7520@MN2PR12MB4488.namprd12.prod.outlook.com>
 <20200828152943.GY3354@suse.de>
 <MN2PR12MB4488BE2F12F85BDBC91E2C0CF7520@MN2PR12MB4488.namprd12.prod.outlook.com>
 <20200904100556.GU6714@8bytes.org>
 <MN2PR12MB448843EC6D3D5B71613BEAAFF72B0@MN2PR12MB4488.namprd12.prod.outlook.com>
 <20200907104431.GH16609@8bytes.org>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <63c70551-255f-2df9-af70-7965e80172af@amd.com>
Date: Mon, 7 Sep 2020 13:10:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200907104431.GH16609@8bytes.org>
Content-Language: en-US
X-ClientProxiedBy: AM0PR02CA0024.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::37) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR02CA0024.eurprd02.prod.outlook.com (2603:10a6:208:3e::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.16 via Frontend Transport; Mon, 7 Sep 2020 11:10:20 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9814f62f-f875-477c-4120-08d8531e9cfb
X-MS-TrafficTypeDiagnostic: MN2PR12MB4208:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4208F5CE6E901C7A860FF6F983280@MN2PR12MB4208.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:127;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: opPKFq9EbNwXNkXfLtGupiSrbVo4BLx6kD2wACBTtJxMXw7rPfHLqCfIVZ1216+y+b0b+JJDjMwPS85xR/XgrMUc1Q5lHBFqI2pu+1zs+n4+NFh8/I4y297pFWPWjL14c++wSzbGWSBYQ0lSZ8ZpcCsxQ6tK/lEqVDn8UrLiefmFYRrMBCefLmti0SaeZznzBt4Iv5x9GzGVBSkQMzdZBFosFT4Dg37wkn8lDaS8Bp+oGXojXce8FKL1tbfpzv+BOwQPCZ/0/15lJRgdT/XHH6QgibK7L4v00/tUBHa2ATpPbmjn9Z3MC8oea/fbqEgdnbXCTOpT1Qkk+Fx5hdnk+uWqdLMCmwiG6fONahLOmDWLMwgKFJa4nKLhlygISEIX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(8676002)(31696002)(2616005)(8936002)(316002)(52116002)(4326008)(2906002)(6666004)(86362001)(6636002)(54906003)(110136005)(478600001)(66946007)(66476007)(66556008)(6486002)(16526019)(53546011)(5660300002)(66574015)(186003)(31686004)(36756003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: /Yje+yEWniw+YhiIsy2pV78fxTFvAxzm0mwasd9acTpGzsDuKjRLEaNypPAjmZ856md5LFXc8FTH2jazwZfOpjCtsiG4JqAkG19x2TcpklNjHmCETJOUY+ai5AnsqOhBHB+FPyFAYM6jRdZUK0SB9JFKvP+udIRpR5lvUr4yAzhf9BytHotcT1FS3KUhLfVbtGV3aeMGAEGkVe98e5W7ZHzYX6DSkCBjYE5VKWWLqTQdNWIFgVJCbFMt9R3zl9cPqAjaGg8B1f9Cwi7DWEZIfPa4cIpnjhh6qB9NrDb0Aje+IQt6D0v1mw/ktEDqJqZiZ/zG2vwlj3kmykkbf1MFjrVfGXIkAgyf7gfi+8HgBX6tOc/wfKhEjh8UoAC2Lk256yYzxoPFPBH6w9Q0uvwbpas3u5XVM9QqEbPtoqjLRBwXv+vKMRE3Eu7wPBcVsHpwCimJIjwSb/iY7ABUg+6pPfxOgv74UlLFMHvgf9ux/6d+OSfhIxXMd0Afk1c3nV2Usg9wyWK31Bq+sRawk4R5tq9ckmVVmqVYAvkJN8FQGXAr/R1AqcYxpyI1w8g/wOBA1KjXcUEgjR5gGu9VHV3p4KR9TtAkYjMTMECn1QDfjfBof0MEQEb/eutKisAJfJpw2oNIGLghqJoGa3Foiu1vP7Aq5mdyocVlhFPZ8mi+Aeiu9oxR4bNtV+YRuQ0KOVWXWwS9C+N30MNlSqf2qoYRkg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9814f62f-f875-477c-4120-08d8531e9cfb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2020 11:10:22.3959 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1jETjDDFtVjDjv2EcRoemDVU8HyeDGctz3+V1RztqtT6u+8rGU5H1IXD15R3EFTb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4208
Cc: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
 "jroedel@suse.de" <jroedel@suse.de>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Huang,
 Ray" <Ray.Huang@amd.com>
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

QW0gMDcuMDkuMjAgdW0gMTI6NDQgc2NocmllYiBKb2VyZyBSb2VkZWw6Cj4gT24gU3VuLCBTZXAg
MDYsIDIwMjAgYXQgMDQ6MDg6NThQTSArMDAwMCwgRGV1Y2hlciwgQWxleGFuZGVyIHdyb3RlOgo+
PiAgRnJvbSBmNDc5YjlkYTM1M2MyNTQ3YzI2ZWJhYzg5MzBhNWRjZDlhMTM0ZWI3IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQo+PiBGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVy
QGFtZC5jb20+Cj4+IERhdGU6IFN1biwgNiBTZXAgMjAyMCAxMjowNToxMiAtMDQwMAo+PiBTdWJq
ZWN0OiBbUEFUQ0hdIGRybS9hbWRncHU6IEZhaWwgdG8gbG9hZCBvbiBSQVZFTiBpZiBTTUUgaXMg
YWN0aXZlCj4+Cj4+IER1ZSB0byBoYXJkd2FyZSBidWdzLCBzY2F0dGVyL2dhdGhlciBkaXNwbGF5
IG9uIHJhdmVuIHJlcXVpcmVzCj4+IGEgMToxIElPTU1VIG1hcHBpbmcsIGhvd2V2ZXIsIFNNRSAo
U3lzdGVtIE1lbW9yeSBFbmNyeXB0aW9uKQo+PiByZXF1aXJlcyBhbiBpbmRpcmVjdCBJT01NVSBt
YXBwaW5nIGJlY2F1c2UgdGhlIGVuY3J5cHRpb24gYml0Cj4+IGlzIGJleW9uZCB0aGUgRE1BIG1h
c2sgb2YgdGhlIGNoaXAuICBBcyBzdWNoLCB0aGUgdHdvIGFyZQo+PiBpbmNvbXBhdGlibGUuCj4+
Cj4+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNv
bT4KPj4gLS0tCj4+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jIHwg
MTAgKysrKysrKysrKwo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspCj4+Cj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMKPj4gaW5kZXggMTJlMTY0NDVk
ZjdjLi5kODdkMzdjMjUzMjkgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kcnYuYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZHJ2LmMKPj4gQEAgLTExMDIsNiArMTEwMiwxNiBAQCBzdGF0aWMgaW50IGFtZGdwdV9wY2lf
cHJvYmUoc3RydWN0IHBjaV9kZXYgKnBkZXYsCj4+ICAgCQlyZXR1cm4gLUVOT0RFVjsKPj4gICAJ
fQo+PiAgIAo+PiArCS8qIER1ZSB0byBoYXJkd2FyZSBidWdzLCBTL0cgRGlzcGxheSBvbiByYXZl
biByZXF1aXJlcyBhIDE6MSBJT01NVSBtYXBwaW5nLAo+PiArCSAqIGhvd2V2ZXIsIFNNRSByZXF1
aXJlcyBhbiBpbmRpcmVjdCBJT01NVSBtYXBwaW5nIGJlY2F1c2UgdGhlIGVuY3J5cHRpb24KPj4g
KwkgKiBiaXQgaXMgYmV5b25kIHRoZSBETUEgbWFzayBvZiB0aGUgY2hpcC4KPj4gKwkgKi8KPj4g
KwlpZiAobWVtX2VuY3J5cHRfYWN0aXZlKCkgJiYgKChmbGFncyAmIEFNRF9BU0lDX01BU0spID09
IENISVBfUkFWRU4pKSB7Cj4+ICsJCWRldl9pbmZvKCZwZGV2LT5kZXYsCj4+ICsJCQkgIlNNRSBp
cyBub3QgY29tcGF0aWJsZSB3aXRoIFJBVkVOXG4iKTsKPj4gKwkJcmV0dXJuIC1FTk9UU1VQUDsK
Pj4gKwl9Cj4+ICsKPj4gICAjaWZkZWYgQ09ORklHX0RSTV9BTURHUFVfU0kKPj4gICAJaWYgKCFh
bWRncHVfc2lfc3VwcG9ydCkgewo+PiAgIAkJc3dpdGNoIChmbGFncyAmIEFNRF9BU0lDX01BU0sp
IHsKPj4gLS0gCj4+IDIuMjUuNAo+Pgo+IExvb2tzIGdvb2QgdG8gbWUsIHRoYW5rcy4KPgo+IEFj
a2VkLWJ5OiBKb2VyZyBSb2VkZWwgPGpyb2VkZWxAc3VzZS5kZT4KClRoaXMgaXMgcmVhbGx5IHVu
Zm9ydHVuYXRlLCBidXQgSSBkb24ndCBzZWUgYW55IG90aGVyIHNvbHV0aW9uIGVpdGhlci4KClJl
dmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxp
bmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
