Return-Path: <SRS0=7V87=LJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9769C48BE8
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 18:27:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D65F610A1
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 18:27:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D65F610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2F15860664;
	Tue, 15 Jun 2021 18:27:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lB_9CKCDWf-h; Tue, 15 Jun 2021 18:27:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0640A60799;
	Tue, 15 Jun 2021 18:27:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB8BCC000D;
	Tue, 15 Jun 2021 18:26:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0752AC000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 18:26:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E17BB83A6C
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 18:26:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=vmware.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TGeAFq2hWwJl for <iommu@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 18:26:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::608])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 135D883A4B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 18:26:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fp0ut11fVwKWEQMr86bRt972n+hLvUrSnC0BEXkQ/gHRQAN1RUCgXJjqKEt1m3jrk0Y6/x76M4KJeiC1SIKEwLW0T0UkbahEoHWx9aPWLvvdyuzBuPCc2m4m9psOfz6SvkdLhtmu83ZEJp85QRqzMvfpM+ks3OInG65RsYTp5wxXCQ0v01tsDhVlfGGYlAwFmaJD2Pq5In0YFZ0M4hyiHQLpzeNFvH87chj8nehxiAzq/skTnStVJFhNGCQwm/jVmzt9ILJ7YqzQeof7nKtUecBeszo39tDjSJGhhQ8lO6NuQwbFC7m1rf5qKuBrfWNMojZzQfxIyd4aiLVIchShzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okgxJ6qPkV8E89QdkgA3Wqdpgcntk1SACtCCv4uwCXU=;
 b=h4SIg5C13OJWL/E4lAAf20YAp0lp9AMJN1/cFVUJIwMb2HvatYuBa62WBcNrxx9wbPLeMtFDf7u1VBkNU+d1jar/QwRIvMJi1wTrqVueOQbXpos/QdoWLQ++kowM/7aLOeI8D07V7HQ7teHA3pThXL7BBxU5/wuFiiGTEc505HHnnQzlu6cVsKlMx0g/Fm+6UGTF/yBpllEBApjGejNGcD9Pec1XPoz5tcPRYNds/d2zHLUUtbp9UdLILiRww6OzB3i6ooV2v6AvJwNbihZRxY7/gitzP+ZfxrAIYxd9VybK07Nz6p6FPuZApoPPf3PA6oYl+03nPfaDm7KSUeaZ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okgxJ6qPkV8E89QdkgA3Wqdpgcntk1SACtCCv4uwCXU=;
 b=THFb+M3DvF3Pmqrh75KbqJr/SJVyCuKXh0/F7Nras1qkwCV0pExoBbhSQW9UIm3uTXlDfdbJ/QBdjzWus+gnZ3qJryWHAs1fNo49Q6iq9/+wLygnHRo3fjkJwEkcCsX31kiAYNW/l/mLoPcL7gui0FEmfLje2bxmVf5XBsa/lZ4=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by BYAPR05MB5942.namprd05.prod.outlook.com (2603:10b6:a03:c5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.12; Tue, 15 Jun
 2021 18:26:48 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::1c28:6a3d:d0d6:42fd]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::1c28:6a3d:d0d6:42fd%3]) with mapi id 15.20.4242.016; Tue, 15 Jun 2021
 18:26:48 +0000
From: Nadav Amit <namit@vmware.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 2/6] iommu/amd: Do not use flush-queue when NpCache is
 on
Thread-Topic: [PATCH v3 2/6] iommu/amd: Do not use flush-queue when NpCache is
 on
Thread-Index: AQHXYeeGFQSEW5jijEOqPsAjk0RPs6sVZDGA
Date: Tue, 15 Jun 2021 18:26:48 +0000
Message-ID: <13D6A169-4323-435A-A858-A9A78E85DF2D@vmware.com>
References: <20210607182541.119756-1-namit@vmware.com>
 <20210607182541.119756-3-namit@vmware.com>
 <afd4e764-a003-32eb-c50e-a77543772db0@arm.com>
In-Reply-To: <afd4e764-a003-32eb-c50e-a77543772db0@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [24.6.216.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 60392745-632c-48d7-b4ae-08d9302b2336
x-ms-traffictypediagnostic: BYAPR05MB5942:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR05MB594224B87545071A70B57F3AD0309@BYAPR05MB5942.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TXxyeFddOYcAZQamPEk3GcUWXl75Q7TRKuj2fLiRVtbjzWCvy2Q//OEAmI/6olo4ctcv8alCCkzBxKUjc7okmq4S8lSBdARJklSOUJc5lGFk9r3F+AsyueUsLINZ3+TLyyQWDSCeImcXE6NYCPsc6O8bOtolZiQsP1Y824Lz/3sTjJy5JplwXsMvMf2fx44P+hT8l+1ktW2JdMAG3+4B05DdQBy8C8DlR1oGssGkiLXQeslx2MA4EQ8AZnyuiZ+oh2JTQtYdR8WxID37iJr240bHatIwx0UJbgo1Y9q2tYvqXWFd17xfHv7ifO/KhdIAp/btshZqkO83ml6XQL9Jxl0Rt4KB2btA6puLGjzgSu9zag1pWcMwzaOquBZhpbqorjArg5BEjZ/bBWszCfehHPdSng5YoDleYyZ3ABo2dqfd5hSyaCnNgWSEaCDmNPm6IsUJqtywqyu0Lm9AlpOxUg4/zrmYywnEIBdaBDcKZmf7zGrmkIWngOygB97esbCwEE5ry7huYjiKNEQfQDxLcaLWwTq6UnKPp7rsDhidwyBhTFPOn2kYyu6ja/e78xRpAUkrIhC/5GgAq2GSBJy/eKYHZjRHI95CEV3Exlwlq3u5IR/y2k6OzEbIrbO6sny0UTD2Y5/mB+PdtceXHue6/Nf0Y/5Oq9W+RMeBuTki9/o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR05MB8531.namprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(6029001)(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(38100700002)(122000001)(4326008)(8676002)(36756003)(6486002)(54906003)(478600001)(316002)(6916009)(186003)(2616005)(33656002)(66556008)(83380400001)(5660300002)(8936002)(66476007)(66446008)(53546011)(6506007)(86362001)(6512007)(26005)(71200400001)(76116006)(2906002)(66946007)(64756008)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUxKMnNRcXd0cE9JcjBPYjJjcEp0MnQrTkN5THBBTG85S3UzaDlXbmFWckNX?=
 =?utf-8?B?b2xlK1FaaVlwOGJqK2QxN3dBRXBYL3N0K3dnRm5nVmZReTRMckg5UEJDTGUy?=
 =?utf-8?B?RHF3TkpxbHMzcUpDV0NTbUg1eWtmM3dFZGtuQlZsdlNrQnJDckNBRUtVdVY5?=
 =?utf-8?B?QUsxcEJQeTVuK2I0OS9rNUl5M0xJcHdYR0psWlV0YmdFUFY4cGhkVnM4Kyts?=
 =?utf-8?B?ZGNJVlJWUkt4MjdQN3RaNTE5T2sxWENYRVd5WmlEdzdyY2tGZDdLc3JmVC95?=
 =?utf-8?B?NWdVOFZoeDZpNzZHTmR5T2U3SXdRdStUU0s0dXo2cUhPelRWWkZGMzV6VXNM?=
 =?utf-8?B?UE00bEIyRDF6ZEFHRyt5NlAwTVBuN0loRVNYZDJMOEtFUCtIR2YzY3IwS0Zs?=
 =?utf-8?B?bVpKU2lRZitMUGlhdS9ERUdCZDVTdW4xU0xwRzRYWnNBNHF5VW5kamhIYWVL?=
 =?utf-8?B?T0l6b1lSRmVnWDJGSXYxb0ZqNE4zTWVGeWZuVGJiZFdWWGZHQXNFeXJyVXJO?=
 =?utf-8?B?M01XYSt4UVl0ZlY5d3VCU05zeFczQkorTlV1VFF1OFFhODZoaUdyNmlpYndZ?=
 =?utf-8?B?b3BnVklHTEd2ZEhDMWdYbXJ1TTJXY05SYVBVdDA1dDVUUjg0VVFVc3VtSExS?=
 =?utf-8?B?L2w1aTN3VVFwNEhzRGZ4dnMrVHgxN2RFUVFPeWgxQnBhczRKTk5BNlF3QVZx?=
 =?utf-8?B?QVdSUVZmNWg0WGVrUVB5N1hBTjltajM4clo1cUUwV1V3eTVJd2tLMWR1NGJ5?=
 =?utf-8?B?Q1FFdGdYaUNhaGF6bisyRHlXSDNxemNxWXVQait3d3NqMWNhalphbzRRam1J?=
 =?utf-8?B?K3NZaTF6MUZyZGU0WWhpRnE1bUZsUDFmNnEyZWFwV0MvUUVOVGVSVDFUakIx?=
 =?utf-8?B?NVFzLysyZVFTcTZNMmxZUkw5UWFWQTQ1akkyT2RoZFY2UkRNU1N2dkx1QTNG?=
 =?utf-8?B?VUJMUmViVHpRZit3ZnBPaW9wb0wycGJvUThjdDhOblZUaERoaW5NWWsyTVND?=
 =?utf-8?B?ZTdKMUsyYjZTcEsxRlNpLytFTHgyQUpPOWxaK0ROM0s1d2x4aVh5Mm1vZGdE?=
 =?utf-8?B?NWwxKzNWQmdISTVCSDFpTEhVZlJWaG9sR29PdGFJMzhBS2trVmhNZHIrVjhK?=
 =?utf-8?B?MXRic2tVNm5zWm1kUTMwZ1FVdjRuRGJIUDNOZmxleEVxRzFNbXNZU2J4VEFN?=
 =?utf-8?B?dHBLa1BLK3JHREVmVHJCaXRaMk95WnJTVFFpLy9HVG1md25PRC9md0s4Tlgy?=
 =?utf-8?B?NkhsUmFNQmlWa1huajhYMG5QbzJ4NzZjK254RWpFRE9pellDTG9iUVp4MXRo?=
 =?utf-8?B?bXJ6RWYvTkE2MTI5SUJqeXdWQ1hvVTc0Vmp0cUJocktCNmNjMmpmQk5pQUdW?=
 =?utf-8?B?Z3J0WVJBbUdVcSs5MjZDbVZMTi9vcGpoNVdsQjErUFYrLzRaZ2Y5N0NBUkdV?=
 =?utf-8?B?SkF2T0pnRVh4MjgzNEd2NHdTTW1vd2FrK2RKMGVxelc1eXJPaXZtTVZwZ1U2?=
 =?utf-8?B?U0wvQkhFUHZ5ZlhhNkNsaEErMVNFSGNVTFMyZE9ZTFlkZkxJakNWR0VEMEE4?=
 =?utf-8?B?b3RyL1RKODlwVXZBL1MvalFTT2E0SVQyQURlZlhwQ1FoSXlJeEZnbzVjZDJk?=
 =?utf-8?B?QnV0eXFqckNtRGg0SkZ1T2E3YnJIaDB1T1Y0YW5ZUTVFbFhNYml4YTFNUXNI?=
 =?utf-8?B?eTkvbXJBYXV5Q0FOb1kxQW9hMlVqOGlEdmxCbnVRWXpoTytzd1pCR3k0YVFy?=
 =?utf-8?Q?yz9QXXU66xD9hVvB7XXqJKrpN7VTWUS9P35Z9h1?=
Content-ID: <8C9F3EFB7CEFD04084935D57FEE8301C@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60392745-632c-48d7-b4ae-08d9302b2336
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2021 18:26:48.1453 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qQSKc4oUxofr8HwADq8HowoxGowTsM/x8lOZZZmDQJxkU2gKn0KHmol2wJTXK3I/0Z2r04csIbGxe81Ey2tC2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5942
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Jiajun Cao <caojiajun@vmware.com>, Will Deacon <will@kernel.org>
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

DQoNCj4gT24gSnVuIDE1LCAyMDIxLCBhdCA2OjA4IEFNLCBSb2JpbiBNdXJwaHkgPHJvYmluLm11
cnBoeUBhcm0uY29tPiB3cm90ZToNCj4gDQo+IE9uIDIwMjEtMDYtMDcgMTk6MjUsIE5hZGF2IEFt
aXQgd3JvdGU6DQo+PiBGcm9tOiBOYWRhdiBBbWl0IDxuYW1pdEB2bXdhcmUuY29tPg0KPj4gRG8g
bm90IHVzZSBmbHVzaC1xdWV1ZSBvbiB2aXJ0dWFsaXplZCBlbnZpcm9ubWVudHMsIHdoZXJlIHRo
ZSBOcENhY2hlDQo+PiBjYXBhYmlsaXR5IG9mIHRoZSBJT01NVSBpcyBzZXQuIFRoaXMgaXMgcmVx
dWlyZWQgdG8gcmVkdWNlDQo+PiB2aXJ0dWFsaXphdGlvbiBvdmVyaGVhZHMuDQo+PiBUaGlzIGNo
YW5nZSBmb2xsb3dzIGEgc2ltaWxhciBjaGFuZ2UgdG8gSW50ZWwncyBWVC1kIGFuZCBhIGRldGFp
bGVkDQo+PiBleHBsYW5hdGlvbiBhcyBmb3IgdGhlIHJhdGlvbmFsZSBpcyBkZXNjcmliZWQgaW4g
Y29tbWl0IDI5YjMyODM5NzI1Zg0KPj4gKCJpb21tdS92dC1kOiBEbyBub3QgdXNlIGZsdXNoLXF1
ZXVlIHdoZW4gY2FjaGluZy1tb2RlIGlzIG9uIikuDQo+PiBDYzogSm9lcmcgUm9lZGVsIDxqb3Jv
QDhieXRlcy5vcmc+DQo+PiBDYzogV2lsbCBEZWFjb24gPHdpbGxAa2VybmVsLm9yZz4NCj4+IENj
OiBKaWFqdW4gQ2FvIDxjYW9qaWFqdW5Adm13YXJlLmNvbT4NCj4+IENjOiBSb2JpbiBNdXJwaHkg
PHJvYmluLm11cnBoeUBhcm0uY29tPg0KPj4gQ2M6IEx1IEJhb2x1IDxiYW9sdS5sdUBsaW51eC5p
bnRlbC5jb20+DQo+PiBDYzogaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcNCj4+IENj
OiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+PiBTaWduZWQtb2ZmLWJ5OiBOYWRhdiBB
bWl0IDxuYW1pdEB2bXdhcmUuY29tPg0KPj4gLS0tDQo+PiAgZHJpdmVycy9pb21tdS9hbWQvaW5p
dC5jIHwgNyArKysrKystDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvYW1kL2luaXQuYyBiL2Ry
aXZlcnMvaW9tbXUvYW1kL2luaXQuYw0KPj4gaW5kZXggZDAwNjcyNGY0ZGMyLi5iYTNiNzZlZDc3
NmQgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2lvbW11L2FtZC9pbml0LmMNCj4+ICsrKyBiL2Ry
aXZlcnMvaW9tbXUvYW1kL2luaXQuYw0KPj4gQEAgLTE4NTAsOCArMTg1MCwxMyBAQCBzdGF0aWMg
aW50IF9faW5pdCBpb21tdV9pbml0X3BjaShzdHJ1Y3QgYW1kX2lvbW11ICppb21tdSkNCj4+ICAJ
aWYgKHJldCkNCj4+ICAJCXJldHVybiByZXQ7DQo+PiAgLQlpZiAoaW9tbXUtPmNhcCAmICgxVUwg
PDwgSU9NTVVfQ0FQX05QQ0FDSEUpKQ0KPj4gKwlpZiAoaW9tbXUtPmNhcCAmICgxVUwgPDwgSU9N
TVVfQ0FQX05QQ0FDSEUpKSB7DQo+PiArCQlpZiAoIWFtZF9pb21tdV91bm1hcF9mbHVzaCkNCj4+
ICsJCQlwcl93YXJuX29uY2UoIklPTU1VIGJhdGNoaW5nIGlzIGRpc2FibGVkIGR1ZSB0byB2aXJ0
dWFsaXphdGlvbiIpOw0KPiANCj4gTml0OiB5b3UgY2FuIGp1c3QgdXNlIHByX3dhcm4oKSAob3Ig
YXJndWFibHkgcHJfaW5mbygpKSBzaW5jZSB0aGUgZXhwbGljaXQgY29uZGl0aW9ucyBhbHJlYWR5
IG9ubHkgbWF0Y2ggb25jZS4NCg0KWWVzLCBteSBiYWQuIEkgd2lsbCBmaXggaXQgaW4gdGhlIG5l
eHQgdmVyc2lvbi4NCg0KPiBTcGVha2luZyBvZiB3aGljaCwgaXQgbWlnaHQgYmUgYmV0dGVyIHRv
IHVzZSBhbWRfaW9tbXVfbnBfY2FjaGUgaW5zdGVhZCwgc2luY2Ugb3RoZXIgcGF0Y2hlcyBhcmUg
cGxhbm5pbmcgdG8gY2xlYW4gdXAgdGhlIGxhc3QgcmVtbmFudHMgb2YgYW1kX2lvbW11X3VubWFw
X2ZsdXNoLg0KDQpJIHByZWZlciB0aGF0IHRoZSBvdGhlciBwYXRjaGVzICh0aGF0IHJlbW92ZSBh
bWRfaW9tbXVfdW5tYXBfZmx1c2gpIHdvdWxkIGFkZHJlc3MgdGhpcyBjb2RlIGFzIHdlbGwuIEkg
Y2VydGFpbmx5IGRvIG5vdCB3YW50IHRvIGVtYmVkIGFtZF9pb21tdV9ucF9jYWNoZSBkZWVwIGlu
dG8gdGhlIGZsdXNoaW5nIGxvZ2ljLiBJT1c6IEkgZG9u4oCZdCBrbm93IHdoYXQgeW91IGhhdmUg
ZXhhY3RseSBpbiBtaW5kLCBidXQgSSBwcmVmZXIgdGhlIGNvZGUgd291bGQgYmUgY2xlYXIuDQoN
ClRoaXMgY29kZSBmb2xsb3dzIChjb3BpZXM/KSB0aGUgc2FtZSBwYXR0ZXJuK2xvZ2ljIGZyb20g
Y29tbWl0IDVmMzExNmVhOGI1ICgiaW9tbXUvdnQtZDogRG8gbm90IHVzZSBmbHVzaC1xdWV1ZSB3
aGVuIGNhY2hpbmctbW9kZSBpcyBvbuKAnSkuIEkgc2VlIHRoYXQgY2hhbmdlZCB0aGUgY29kZSBp
biBjb21taXQgNTMyNTVlNTQ1ODA3YyAoImlvbW11OiByZW1vdmUgRE9NQUlOX0FUVFJfRE1BX1VT
RV9GTFVTSF9RVUVVReKAnSksIGJ1dCBkaWQgbm90IGdldCByaWQgb2YgaW50ZWxfaW9tbXVfc3Ry
aWN0LCBzbyBwbGVhc2UgYWxsb3cgbWUgdG8gdXNlIGFtZF9pb21tdV91bm1hcF9mbHVzaC4NCg0K
VG8gcmVtaW5kIHlvdS9tZS93aG9ldmVyOiBkaXNhYmxpbmcgYmF0Y2hpbmcgZHVlIHRvIGNhY2hp
bmctbW9kZS9OUC1jYWNoZSBpcyBub3QgaW5oZXJlbnRseSBuZWVkZWQuIEl0IHdhcyBub3QgbmVl
ZGVkIGZvciBxdWl0ZSBzb21lIHRpbWUgb24gSW50ZWwsIGJ1dCBzb21laG93IGFsb25nIHRoZSB3
YXkgdGhlIGNvbnNvbGlkYXRlZCBmbHVzaGluZyBjb2RlIGJyb2tlIGl0LCBhbmQgbm93IGl0IGlz
IG5lZWRlZCAod2l0aG91dCBpbnRydXNpdmUgY29kZSBjaGFuZ2VzKS4NCg0KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0Cmlv
bW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
