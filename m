Return-Path: <SRS0=03l9=BB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04F6C433E1
	for <iommu@archiver.kernel.org>; Wed, 22 Jul 2020 10:58:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6314E206F5
	for <iommu@archiver.kernel.org>; Wed, 22 Jul 2020 10:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="b7Inxpy2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6314E206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0CF5588056;
	Wed, 22 Jul 2020 10:58:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ImvOo4GYF8Ba; Wed, 22 Jul 2020 10:57:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7FF0887FBE;
	Wed, 22 Jul 2020 10:57:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46700C004E;
	Wed, 22 Jul 2020 10:57:59 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74F3FC004C
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 10:57:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4F58C88494
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 10:57:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rrSdGQL4iFDF for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jul 2020 10:57:55 +0000 (UTC)
X-Greylist: delayed 08:31:22 by SQLgrey-1.7.6
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by hemlock.osuosl.org (Postfix) with ESMTPS id AB5FC88455
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 10:57:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFsdchfQDaBFnOXJJFFXeP4PDf2re/gBTxPglOYB4ZEgmJMz454mcOB35v1Di+3ntqVvcio7lxOMmEkAMyPg2NaBSKSOo6kf7gObHXcmjPYlvwB8QOJE9xht4DdzooE7gkt0Gouq3NKQZHIm9PATJmdH6sOWZ2dX0rQ0CAmJHGbnZncsLjfQ++8Gj2D1x9PMwIMRlSiUWqZtmCIdcX7mq24hd7Tt2MZMWLKcWDNVatpjOudziYehuVzwIVWiAMjwtfCGB7duaLG2zwn8HyKL5kSOqCdizVYzMa6tOPBnWcC4hWApWAKhF4YPksYnxy0mZfslxrbJF8/VtKrLVf3bMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQ/xrKHRS86cgb9FZC3c1Gk2V9xrb+iarPGCeznRE7Q=;
 b=BH7Lxb472D4TOJqqtUKsdgxBDQlyXRhCof2VblcYRdBRtdU6dfTQ+sL4OOTHmE3qeZpCzkxNEefHtXHXD7lERMZmzHLdbjPTMmWDuWs3RV/YmDK4lqsShwOMdb//79EyQwtYJEx2eet8N5nkWy3LcBPMrpyfcc8Pmt/p/1SzrXawhnhs6pM/SY1KdpfTXodozHdvEl6ILXq31coyesLwa5bk8QavMRZtazrbzOauFrE2M4L15hmr5WtDpAOaA15G0Z9tfbVFGPlIP3IaByOS1wlU+1AqRANNYdTH4XYK5lRUiN+U6nQI7CBv0lc4dl48go8oDnUQg8yN8Yu7JqlmHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQ/xrKHRS86cgb9FZC3c1Gk2V9xrb+iarPGCeznRE7Q=;
 b=b7Inxpy2r3+dXmU4ILWFYPWSTUF1xkmOytINZ/I/W6ksd1Yhnqdfz7FKYxxLK2Y41HYFRTr0tFvMGxbrLsOE00OyT6YR/sHVXmJaysnBcRGcql0iHvdRutbOriR40DtrS4hoqEWRrvF/wp6ZfIEuBG85BuOmGhC9Ei90CXCKDHI=
Received: from DM6PR11MB2587.namprd11.prod.outlook.com (2603:10b6:5:c3::16) by
 DM5PR1101MB2138.namprd11.prod.outlook.com (2603:10b6:4:57::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.24; Wed, 22 Jul 2020 02:26:29 +0000
Received: from DM6PR11MB2587.namprd11.prod.outlook.com
 ([fe80::f0ce:7cda:308:fc2d]) by DM6PR11MB2587.namprd11.prod.outlook.com
 ([fe80::f0ce:7cda:308:fc2d%7]) with mapi id 15.20.3216.021; Wed, 22 Jul 2020
 02:26:29 +0000
From: "Miao, Jun" <Jun.Miao@windriver.com>
To: "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: Subject: Re: [PATCH 1/1] iommu/vt-d: Skip TE disabling on quirky gfx
 dedicated iommu
Thread-Topic: Subject: Re: [PATCH 1/1] iommu/vt-d: Skip TE disabling on quirky
 gfx dedicated iommu
Thread-Index: AQHWX8z4VG2VfHBd7EiOuWmKnK73Jw==
Date: Wed, 22 Jul 2020 02:26:29 +0000
Message-ID: <DM6PR11MB2587034DFBEDFB091CE9AAD58E790@DM6PR11MB2587.namprd11.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none
 header.from=windriver.com;
x-originating-ip: [223.72.38.229]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9767cfeb-4a38-4b4e-7122-08d82de6a438
x-ms-traffictypediagnostic: DM5PR1101MB2138:
x-microsoft-antispam-prvs: <DM5PR1101MB21388025FAF119E99E31AAE08E790@DM5PR1101MB2138.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:655;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NFgK16gjz7X7gue5Q7LwTyNFFESULbqhjoo5T+gDkp+8bR8+Z/2WWBPKsEkY0PhiHoTF0g0QlNmpXVWtomwdt5ZLy9oYgEUSJ71kgd4BtOkaGSKyyOLrwebMwKBn6Ek0iBUklEelg6bj9oTn2jJYc1yGJupr3SLcWsg4eN4yLQid1U2c0/3J9riAUjIols54s358us+P4PIh1VSAWhGLOaAPO1XwOrvOnc/G9ZWTH2DJiRmWdKkt7FxSKnbvBHh4m64fRF/GbtNwK251e7C82ITbuJiraGFhVPfZUTIDU2eng0slYtYyEHrmXeiQFcsRXP3aVdpl2pobw1FlftrRzQwEat4uEfNKlIfBj7LdEsIjTtx+r/dyB+furOfgRJLVTFOvVwbqaNswmQTNX6DWEQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR11MB2587.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(346002)(366004)(376002)(136003)(39850400004)(396003)(7696005)(86362001)(9686003)(186003)(966005)(26005)(2906002)(54906003)(8676002)(52536014)(478600001)(6916009)(66476007)(19627405001)(66946007)(64756008)(66446008)(66556008)(316002)(8936002)(33656002)(4326008)(76116006)(91956017)(5660300002)(55016002)(166002)(83380400001)(6506007)(53546011)(71200400001)(579004)(559001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: xBDrQBYuZEXwViFRE+xydjdLo6Lvan81iRcxiW88orNyQyJEh1Sz5d15C/gymZwybtwIKyNcoRP3N355DnLTM4JgytmfDB7ZeSQtLFZ3CXc2IL/5p94uw9I/hFyROzqWL5Cuc9f3vuLGNbCvjrh+1mJe3nEZDFkmeVlPdXS4qQX9Fr8DueZz+UKeJW8B9gMROFAdGhAFAOnSMUH3neitoCxVNkyiZBPbKFdWTsTwTKQ3JdaU86/tcVfPH3xqaMNKXlCE+d/EfB7Gts67X9wioC/RHHX1HqwcJZT4s2o1hcvPActFwL3saX5DQ3YRdjdWjWCng7QZzYyHedz2spg5+IkJrN1CQDOK6PAhfqghfu1PMZ8H3eEhi475RCbaw6I4rhPsZAToCA2J69i2drcoOKI0kUvl0GZ5FyaxoBHa7HXYwwZWsYQsPI7x1jKTnqMgrlFpQIK6wbDwJ/DdQZq0oh234ym5IW5zTX33bS/7Pao=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9767cfeb-4a38-4b4e-7122-08d82de6a438
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2020 02:26:29.2126 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SvkLgIGXSSMIu69W/1qVSRXUGZzD8yi0ikKZO7Zn3of2fqnase4qTQ/5vYYY0tUq/Db82XeRoLVIsOCoiSwXLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2138
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
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
Content-Type: multipart/mixed; boundary="===============3180327910994888855=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============3180327910994888855==
Content-Language: zh-CN
Content-Type: multipart/alternative;
	boundary="_000_DM6PR11MB2587034DFBEDFB091CE9AAD58E790DM6PR11MB2587namp_"

--_000_DM6PR11MB2587034DFBEDFB091CE9AAD58E790DM6PR11MB2587namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

SGkgTHUsICBsaW1vbmNpZWxsby4NCg0KWWVzdG9kYXkgaSBqdXN0IHZlcmlmaWVkIHRoZSBpc3N1
ZSB3aXRoIHRoZSBwYXRjaC4gYW5kIGp1c3QgaW9tbXUgU3Vic2NyaXB0aW9uIHRvZGF5LlRoaXMg
aXMgbXkgdGVzdCBsb2cuDQoNCltIYXJkd2FyZSBpbmZvXQ0KDQogSW50ZWwoUikgQ29yZShUTSkg
aTctMTA2NUc3IENQVSBAIDEuMzBHSHogICAgICAgICAgIDEuMjBHSHoNCiBJQ0xTRldSMS5SMDAu
MzE2Mi5BMDAuMTkwNDE2MjAwMA0KIEJJT1MgSW5mb3JtYXRpb24NCg0KIEJJT1MgVmVuZG8gSW50
ZWwNCg0KICAgICAgIENvcmUgVmVyc2lvbiAgICAgICAgICAgICAgICAgICAgIDEuNS4yLjAgUlAw
MQ0KICAgICAgIENsaWVudCBTaWxpY29uIFZlcnNpb24gICAgICAgICAgIDAuMi4wLjE1DQogICAg
ICAgUHJvamVjdCBWZXJzaW9uICAgICAgICAgICAgICAgICAgSUNMU0ZXUjEuUjAwLjMxNjIuQTAw
LjE5MDQxNjIwMDANCiAgICAgICBCdWlsZCBEYXRlICAgICAgICAgICAgICAgICAgICAgICAyMDow
MCAwNC8xNi8yMDE5DQoNCiAgICAgICBCb2FyZCBOYW1lICAgICAgICAgICAgICAgICAgICAgICBJ
Y2VMYWtlIFUgRERSNCBTT0RJTU0gUEQgUlZQIFRMQw0KDQogICAgICAgUHJvY2Vzc29yIEluZm9y
bWF0aW9uDQogICAgICAgTmFtZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSWNlTGFrZSBV
TA0KDQpbUzMobWVtKSBmYWlsZWRdDQoNCiQgZWNobyBkZWVwID4gL3N5cy9wb3dlci9tZW1fc2xl
ZXANCg0KJCBydGN3YWtlIC1tIG1lbSAtcyAxMA0KDQpBQ1BJOiBFQzogaW50ZXJydXB0IGJsb2Nr
ZWQNCmUxMDAwZSAwMDAwOjAwOjFmLjY6IHBjaV9wbV9zdXNwZW5kX25vaXJxKzB4MC8weDI1MCBy
ZXR1cm5lZCAwIGFmdGVyIDE0MzE3DQp1c2Vjcw0KZWMgUE5QMEMwOTowMDogYWNwaV9lY19zdXNw
ZW5kX25vaXJxKzB4MC8weDUwIHJldHVybmVkIDAgYWZ0ZXIgMzU1MzE5IHVzZWNzDQp3ZGF0X3dk
dCB3ZGF0X3dkdDogY2FsbGluZyB3ZGF0X3dkdF9zdXNwZW5kX25vaXJxKzB4MC8weDY2IFt3ZGF0
X3dkdF0gQCAzNDcsDQpwYXJlbnQ6IHBsYXRmb3JtDQphaGNpIDAwMDA6MDA6MTcuMDogcGNpX3Bt
X3N1c3BlbmRfbm9pcnErMHgwLzB4MjUwIHJldHVybmVkIDAgYWZ0ZXIgMzgzODQzDQp1c2Vjcw0K
aW50ZWwtbHBzcyAwMDAwOjAwOjFlLjM6IHBjaV9wbV9zdXNwZW5kX25vaXJxKzB4MC8weDI1MCBy
ZXR1cm5lZCAwIGFmdGVyDQozODQwNjIgdXNlY3MNCndkYXRfd2R0IHdkYXRfd2R0OiB3ZGF0X3dk
dF9zdXNwZW5kX25vaXJxKzB4MC8weDY2IFt3ZGF0X3dkdF0gcmV0dXJuZWQgMA0KYWZ0ZXIgMTEg
dXNlY3MNCmludGVsLWxwc3MgMDAwMDowMDoxZS4wOiBwY2lfcG1fc3VzcGVuZF9ub2lycSsweDAv
MHgyNTAgcmV0dXJuZWQgMCBhZnRlcg0KNDE0NDY2IHVzZWNzDQp4aGNpX2hjZCAwMDAwOjAwOjE0
LjA6IHBjaV9wbV9zdXNwZW5kX25vaXJxKzB4MC8weDI1MCByZXR1cm5lZCAwIGFmdGVyDQo0MTQw
MjMgdXNlY3MNCnNkaGNpLXBjaSAwMDAwOjAwOjE0LjU6IHBjaV9wbV9zdXNwZW5kX25vaXJxKzB4
MC8weDI1MCByZXR1cm5lZCAwIGFmdGVyDQo0MjkzMjUgdXNlY3MNCnBjaWVwb3J0IDAwMDA6MDA6
MDcuMzogcGNpX3BtX3N1c3BlbmRfbm9pcnErMHgwLzB4MjUwIHJldHVybmVkIDAgYWZ0ZXINCjQy
OTAyNiB1c2Vjcw0KcGNpZXBvcnQgMDAwMDowMDowNy4xOiBwY2lfcG1fc3VzcGVuZF9ub2lycSsw
eDAvMHgyNTAgcmV0dXJuZWQgMCBhZnRlcg0KNDI5Njc1IHVzZWNzDQpwY2llcG9ydCAwMDAwOjAw
OjA3LjI6IHBjaV9wbV9zdXNwZW5kX25vaXJxKzB4MC8weDI1MCByZXR1cm5lZCAwIGFmdGVyDQo0
MzAzMDkgdXNlY3MNCnBjaWVwb3J0IDAwMDA6MDA6MDcuMDogcGNpX3BtX3N1c3BlbmRfbm9pcnEr
MHgwLzB4MjUwIHJldHVybmVkIDAgYWZ0ZXINCjQzMDIxMyB1c2Vjcw0KdGh1bmRlcmJvbHQgMDAw
MDowMDowZC4yOiBwY2lfcG1fc3VzcGVuZF9ub2lycSsweDAvMHgyNTAgcmV0dXJuZWQgMCBhZnRl
cg0KNDMyNTIzIHVzZWNzDQp0aHVuZGVyYm9sdCAwMDAwOjAwOjBkLjM6IHBjaV9wbV9zdXNwZW5k
X25vaXJxKzB4MC8weDI1MCByZXR1cm5lZCAwIGFmdGVyDQo0MzI4MTUgdXNlY3MNCkFDUEk6IFBy
ZXBhcmluZyB0byBlbnRlciBzeXN0ZW0gc2xlZXAgc3RhdGUgUzMNCkFDUEk6IEVDOiBldmVudCBi
bG9ja2VkDQpBQ1BJOiBFQzogRUMgc3RvcHBlZA0KUE06IFNhdmluZyBwbGF0Zm9ybSBOVlMgbWVt
b3J5DQpEaXNhYmxpbmcgbm9uLWJvb3QgQ1BVcyAuLi4NCnNtcGJvb3Q6IENQVSAxIGlzIG5vdyBv
ZmZsaW5lDQpzbXBib290OiBDUFUgMiBpcyBub3cgb2ZmbGluZQ0Kc21wYm9vdDogQ1BVIDMgaXMg
bm93IG9mZmxpbmUNCnNtcGJvb3Q6IENQVSA0IGlzIG5vdyBvZmZsaW5lDQpzbXBib290OiBDUFUg
NSBpcyBub3cgb2ZmbGluZQ0Kc21wYm9vdDogQ1BVIDYgaXMgbm93IG9mZmxpbmUNCnNtcGJvb3Q6
IENQVSA3IGlzIG5vdyBvZmZsaW5lDQpQTTogQ2FsbGluZyBtY2Vfc3lzY29yZV9zdXNwZW5kKzB4
MC8weDIwDQpQTTogQ2FsbGluZyBubWlfc3VzcGVuZCsweDAvMHgyMA0KUE06IENhbGxpbmcgdGlt
ZWtlZXBpbmdfc3VzcGVuZCsweDAvMHgyZDANClBNOiBDYWxsaW5nIHNhdmVfaW9hcGljX2VudHJp
ZXMrMHgwLzB4OTANClBNOiBDYWxsaW5nIGk4MjU5QV9zdXNwZW5kKzB4MC8weDMwDQpQTTogQ2Fs
bGluZyBpb21tdV9zdXNwZW5kKzB4MC8weDFiMA0KS2VybmVsIHBhbmljIC0gbm90IHN5bmNpbmc6
IERNQVIgaGFyZHdhcmUgaXMgbWFsZnVuY3Rpb25pbmcNCkNQVTogMCBQSUQ6IDM0NyBDb21tOiBy
dGN3YWtlIE5vdCB0YWludGVkIDUuNC4wLXlvY3RvLXN0YW5kYXJkICMxMjQNCkhhcmR3YXJlIG5h
bWU6IEludGVsIENvcnBvcmF0aW9uIEljZSBMYWtlIENsaWVudCBQbGF0Zm9ybS9JY2VMYWtlIFUg
RERSNA0KU09ESU1NIFBEIFJWUCBUTEMsIEJJT1MgSUNMU0ZXUjEuUjAwLjMxNjIuQTAwLjE5MDQx
NjIwMDAgMDQvMTYvMjAxOQ0KQ2FsbCBUcmFjZToNCiAgZHVtcF9zdGFjaysweDU5LzB4NzUNCiAg
cGFuaWMrMHhmZi8weDJkNA0KICBpb21tdV9kaXNhYmxlX3RyYW5zbGF0aW9uKzB4ODgvMHg5MA0K
ICBpb21tdV9zdXNwZW5kKzB4MTJmLzB4MWIwDQogIHN5c2NvcmVfc3VzcGVuZCsweDZjLzB4MjIw
DQogIHN1c3BlbmRfZGV2aWNlc19hbmRfZW50ZXIrMHgzMTMvMHg4NDANCiAgcG1fc3VzcGVuZCsw
eDMwZC8weDM5MA0KICBzdGF0ZV9zdG9yZSsweDgyLzB4ZjANCiAga29ial9hdHRyX3N0b3JlKzB4
MTIvMHgyMA0KICBzeXNmc19rZl93cml0ZSsweDNjLzB4NTANCiAga2VybmZzX2ZvcF93cml0ZSsw
eDExZC8weDE5MA0KICBfX3Zmc193cml0ZSsweDFiLzB4NDANCiAgdmZzX3dyaXRlKzB4YzYvMHgx
ZDANCiAga3N5c193cml0ZSsweDVlLzB4ZTANCiAgX194NjRfc3lzX3dyaXRlKzB4MWEvMHgyMA0K
ICBkb19zeXNjYWxsXzY0KzB4NGQvMHgxNTANCiAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2Zy
YW1lKzB4NDQvMHhhOQ0KUklQOiAwMDMzOjB4N2Y5N2I4MDgwMTEzDQpDb2RlOiA4YiAxNSA4MSBi
ZCAwYyAwMCBmNyBkOCA2NCA4OSAwMiA0OCBjNyBjMCBmZiBmZiBmZiBmZiBlYiBiNyAwZiAxZiAw
MA0KNjQgOGIgMDQgMjUgMTggMDAgMDAgMDAgODUgYzAgNzUgMTQgYjggMDEgMDAgMDAgMDAgMGYg
MDUgPDQ4PiAzZCAwMCBmMCBmZiBmZg0KNzcgNTUgYzMgMGYgMWYgNDAgMDAgNDggODMgZWMgMjgg
NDggODkgNTQgMjQgMTgNClJTUDogMDAyYjowMDAwN2ZmY2ZhNmY0OGI4IEVGTEFHUzogMDAwMDAy
NDYgT1JJR19SQVg6IDAwMDAwMDAwMDAwMDAwMDENClJBWDogZmZmZmZmZmZmZmZmZmZkYSBSQlg6
IDAwMDAwMDAwMDAwMDAwMDQgUkNYOiAwMDAwN2Y5N2I4MDgwMTEzDQpSRFg6IDAwMDAwMDAwMDAw
MDAwMDQgUlNJOiAwMDAwNTVlN2RiMDNiNzAwIFJESTogMDAwMDAwMDAwMDAwMDAwNA0KUkJQOiAw
MDAwNTVlN2RiMDNiNzAwIFIwODogMDAwMDU1ZTdkYjAzYjcwMCBSMDk6IDAwMDAwMDAwMDAwMDAw
MDQNClIxMDogMDAwMDAwMDAwMDAwMDAwNCBSMTE6IDAwMDAwMDAwMDAwMDAyNDYgUjEyOiAwMDAw
MDAwMDAwMDAwMDA0DQpSMTM6IDAwMDA1NWU3ZGIwMzkzODAgUjE0OiAwMDAwMDAwMDAwMDAwMDA0
IFIxNTogMDAwMDdmOTdiODE0ZDcwMA0KS2VybmVsIE9mZnNldDogMHgzOGEwMDAwMCBmcm9tIDB4
ZmZmZmZmZmY4MTAwMDAwMCAocmVsb2NhdGlvbiByYW5nZToNCjB4ZmZmZmZmZmY4MDAwMDAwMC0w
eGZmZmZmZmZmYmZmZmZmZmYpDQotLS1bIGVuZCBLZXJuZWwgcGFuaWMgLSBub3Qgc3luY2luZzog
RE1BUiBoYXJkd2FyZSBpcyBtYWxmdW5jdGlvbmluZyBdLS0tDQoNCltTMyBzdWNjZXNzZnVsbHkg
d2l0aCB0aGUgcGF0Y2hdDQoNCnNoLTUuMCMgdW5hbWUgLWENCkxpbnV4IGludGVsLXg4Ni02NCA1
LjguMC1yYzYteW9jdG9kZXYtc3RhbmRhcmQrICMxMjggU01QIFBSRUVNUFQgVHVlIEp1bCAyMSAx
MjoxNDozOSBDU1QgMjAyMCB4ODZfNjQgeDg2XzY0IHg4Nl82NCBHTlUvTGludXgNCnNoLTUuMCMN
Cg0Kc2gtNS4wIyBsc21vZCB8Z3JlcCAtaSB0aHVuZGVyYm9sdA0KaW50ZWxfd21pX3RodW5kZXJi
b2x0ICAgIDE2Mzg0ICAwDQp0aHVuZGVyYm9sdCAgICAgICAgICAgMTY3OTM2ICAwDQp3bWkgICAg
ICAgICAgICAgICAgICAgIDI0NTc2ICAyIGludGVsX3dtaV90aHVuZGVyYm9sdCx3bWlfYm1vZg0K
c2gtNS4wIw0Kc2gtNS4wIw0Kc2gtNS4wIw0Kc2gtNS4wIyBtb2RpbmZvIHRodW5kZXJib2x0DQpm
aWxlbmFtZTogL2xpYi9tb2R1bGVzLzUuOC4wLXJjNi15b2N0b2Rldi1zdGFuZGFyZCsva2VybmVs
L2RyaXZlcnMvdGh1bmRlcmJvbHQvdGh1bmRlcmJvbHQua28NCmxpY2Vuc2U6ICAgICAgICBHUEwN
CmFsaWFzOiAgICAgICAgICBwY2k6dipkKnN2KnNkKmJjMENzYzAzaTQwKg0KYWxpYXM6ICAgICAg
ICAgIHBjaTp2MDAwMDgwODZkMDAwMDlBMURzdipzZCpiYypzYyppKg0KYWxpYXM6ICAgICAgICAg
IHBjaTp2MDAwMDgwODZkMDAwMDlBMUJzdipzZCpiYypzYyppKg0KYWxpYXM6ICAgICAgICAgIHBj
aTp2MDAwMDgwODZkMDAwMDhBMERzdipzZCpiYypzYyppKg0KYWxpYXM6ICAgICAgICAgIHBjaTp2
MDAwMDgwODZkMDAwMDhBMTdzdipzZCpiYypzYyppKg0KYWxpYXM6ICAgICAgICAgIHBjaTp2MDAw
MDgwODZkMDAwMDE1RUJzdipzZCpiYypzYyppKg0KYWxpYXM6ICAgICAgICAgIHBjaTp2MDAwMDgw
ODZkMDAwMDE1RThzdipzZCpiYypzYyppKg0KYWxpYXM6ICAgICAgICAgIHBjaTp2MDAwMDgwODZk
MDAwMDE1REVzdipzZCpiYypzYyppKg0KYWxpYXM6ICAgICAgICAgIHBjaTp2MDAwMDgwODZkMDAw
MDE1RDJzdipzZCpiYypzYyppKg0KYWxpYXM6ICAgICAgICAgIHBjaTp2MDAwMDgwODZkMDAwMDE1
RDlzdipzZCpiYypzYyppKg0KYWxpYXM6ICAgICAgICAgIHBjaTp2MDAwMDgwODZkMDAwMDE1RENz
dipzZCpiYypzYyppKg0KYWxpYXM6ICAgICAgICAgIHBjaTp2MDAwMDgwODZkMDAwMDE1QkZzdipz
ZCpiYypzYyppKg0KYWxpYXM6ICAgICAgICAgIHBjaTp2MDAwMDgwODZkMDAwMDE1RERzdipzZCpi
YypzYyppKg0KYWxpYXM6ICAgICAgICAgIHBjaTp2MDAwMDgwODZkMDAwMDE1NzdzdipzZCpiYypz
YyppKg0KYWxpYXM6ICAgICAgICAgIHBjaTp2MDAwMDgwODZkMDAwMDE1NzVzdipzZCpiYypzYypp
Kg0KYWxpYXM6ICAgICAgICAgIHBjaTp2MDAwMDgwODZkMDAwMDE1NkNzdipzZCpiYzA4c2M4MGkw
MCoNCmFsaWFzOiAgICAgICAgICBwY2k6djAwMDA4MDg2ZDAwMDAxNTZBc3Yqc2QqYmMwOHNjODBp
MDAqDQphbGlhczogcGNpOnYwMDAwODA4NmQwMDAwMTU0N3N2MDAwMDIyMjJzZDAwMDAxMTExYmMw
OHNjODBpMDAqDQphbGlhczogcGNpOnYwMDAwODA4NmQwMDAwMTUxM3N2MDAwMDIyMjJzZDAwMDAx
MTExYmMwOHNjODBpMDAqDQpkZXBlbmRzOg0KcmV0cG9saW5lOiAgICAgIFkNCmludHJlZTogICAg
ICAgICBZDQpuYW1lOiAgICAgICAgICAgdGh1bmRlcmJvbHQNCnZlcm1hZ2ljOiAgICAgICA1Ljgu
MC1yYzYteW9jdG9kZXYtc3RhbmRhcmQrIFNNUCBwcmVlbXB0IG1vZF91bmxvYWQNCnBhcm06ICAg
ICAgICAgICBzdGFydF9pY206c3RhcnQgSUNNIGZpcm13YXJlIGlmIGl0IGlzIG5vdCBydW5uaW5n
IChkZWZhdWx0OiBmYWxzZSkgKGJvb2wpDQpzaC01LjAjDQpzaC01LjAjDQpzaC01LjAjIGVjaG8g
ZGVlcCAgPiAvc3lzL3Bvd2VyL21lbV9zbGVlcA0Kc2gtNS4wIw0Kc2gtNS4wIyBydGN3YWtlIC1t
IG1lbSAtcyAxMA0KcnRjd2FrZTogYXNzdW1pbmcgUlRDIHVzZXMgVVRDIC4uLg0KcnRjd2FrZTog
d2FrZXVwIGZyb20gIm1lbSIgdXNpbmcgL2Rldi9ydGMwIGF0IE1vbiBKdWwgMjAgMjE6MTM6MDQg
MjAyMA0KUE06IHN1c3BlbmQgZW50cnkgKGRlZXApDQpGaWxlc3lzdGVtcyBzeW5jOiAwLjAwMCBz
ZWNvbmRzDQpGcmVlemluZyB1c2VyIHNwYWNlIHByb2Nlc3NlcyAuLi4gKGVsYXBzZWQgMC4wMTQg
c2Vjb25kcykgZG9uZS4NCk9PTSBraWxsZXIgZGlzYWJsZWQuDQpGcmVlemluZyByZW1haW5pbmcg
ZnJlZXphYmxlIHRhc2tzIC4uLiAoZWxhcHNlZCAwLjAwMSBzZWNvbmRzKSBkb25lLg0KaW5wdXQg
aW5wdXQxNDogY2FsbGluZyBpbnB1dF9kZXZfc3VzcGVuZCsweDAvMHg0MCBAIDMxMCwgcGFyZW50
OiBjYXJkMA0KaW5wdXQgaW5wdXQxNDogaW5wdXRfZGV2X3N1c3BlbmQrMHgwLzB4NDAgcmV0dXJu
ZWQgMCBhZnRlciAwIHVzZWNzDQppbnB1dCBpbnB1dDEzOiBjYWxsaW5nIGlucHV0X2Rldl9zdXNw
ZW5kKzB4MC8weDQwIEAgMzEwLCBwYXJlbnQ6IGNhcmQwDQppbnB1dCBpbnB1dDEzOiBpbnB1dF9k
ZXZfc3VzcGVuZCsweDAvMHg0MCByZXR1cm5lZCAwIGFmdGVyIDAgdXNlY3MNCmlucHV0IGlucHV0
MTI6IGNhbGxpbmcgaW5wdXRfZGV2X3N1c3BlbmQrMHgwLzB4NDAgQCAzMTAsIHBhcmVudDogY2Fy
ZDANCmlucHV0IGlucHV0MTI6IGlucHV0X2Rldl9zdXNwZW5kKzB4MC8weDQwIHJldHVybmVkIDAg
YWZ0ZXIgMCB1c2Vjcw0KaW5wdXQgaW5wdXQxMTogY2FsbGluZyBpbnB1dF9kZXZfc3VzcGVuZCsw
eDAvMHg0MCBAIDMxMCwgcGFyZW50OiBjYXJkMA0KaW5wdXQgaW5wdXQxMTogaW5wdXRfZGV2X3N1
c3BlbmQrMHgwLzB4NDAgcmV0dXJuZWQgMCBhZnRlciAwIHVzZWNzDQppbnB1dCBpbnB1dDEwOiBj
YWxsaW5nIGlucHV0X2Rldl9zdXNwZW5kKzB4MC8weDQwIEAgMzEwLCBwYXJlbnQ6IGNhcmQwDQpp
bnB1dCBpbnB1dDEwOiBpbnB1dF9kZXZfc3VzcGVuZCsweDAvMHg0MCByZXR1cm5lZCAwIGFmdGVy
IDAgdXNlY3MNCmlucHV0IGlucHV0OTogY2FsbGluZyBpbnB1dF9kZXZfc3VzcGVuZCsweDAvMHg0
MCBAIDMxMCwgcGFyZW50OiBjYXJkMA0KaW5wdXQgaW5wdXQ5OiBpbnB1dF9kZXZfc3VzcGVuZCsw
eDAvMHg0MCByZXR1cm5lZCAwIGFmdGVyIDAgdXNlY3MNCmlucHV0IGlucHV0ODogY2FsbGluZyBp
bnB1dF9kZXZfc3VzcGVuZCsweDAvMHg0MCBAIDMxMCwgcGFyZW50OiBjYXJkMA0KaW5wdXQgaW5w
dXQ4OiBpbnB1dF9kZXZfc3VzcGVuZCsweDAvMHg0MCByZXR1cm5lZCAwIGFmdGVyIDAgdXNlY3MN
CmlucHV0IGlucHV0NzogY2FsbGluZyBpbnB1dF9kZXZfc3VzcGVuZCsweDAvMHg0MCBAIDMxMCwg
cGFyZW50OiBjYXJkMA0KaW5wdXQgaW5wdXQ3OiBpbnB1dF9kZXZfc3VzcGVuZCsweDAvMHg0MCBy
ZXR1cm5lZCAwIGFmdGVyIDAgdXNlY3MNCmlucHV0IGlucHV0NjogY2FsbGluZyBpbnB1dF9kZXZf
c3VzcGVuZCsweDAvMHg0MCBAIDMxMCwgcGFyZW50OiBjYXJkMA0KDQouLi4gLi4uDQoNCmlucHV0
IGlucHV0MTM6IGlucHV0X2Rldl9yZXN1bWUrMHgwLzB4NDAgcmV0dXJuZWQgMCBhZnRlciAwIHVz
ZWNzDQppbnB1dCBpbnB1dDE0OiBjYWxsaW5nIGlucHV0X2Rldl9yZXN1bWUrMHgwLzB4NDAgQCAz
MTAsIHBhcmVudDogY2FyZDANCmlucHV0IGlucHV0MTQ6IGlucHV0X2Rldl9yZXN1bWUrMHgwLzB4
NDAgcmV0dXJuZWQgMCBhZnRlciAwIHVzZWNzDQphdGtiZCBzZXJpbzA6IEZhaWxlZCB0byBkZWFj
dGl2YXRlIGtleWJvYXJkIG9uIGlzYTAwNjAvc2VyaW8wDQplMTAwMGUgMDAwMDowMDoxZi42OiBw
Y2lfcG1fcmVzdW1lKzB4MC8weDkwIHJldHVybmVkIDAgYWZ0ZXIgMTAwMzU3MyB1c2Vjcw0KYXRr
YmQgc2VyaW8wOiBGYWlsZWQgdG8gZW5hYmxlIGtleWJvYXJkIG9uIGlzYTAwNjAvc2VyaW8wDQph
Y3BpIExOWFBPV0VSOjAzOiBUdXJuaW5nIE9GRg0KT09NIGtpbGxlciBlbmFibGVkLg0KUmVzdGFy
dGluZyB0YXNrcyAuLi4NCnN5c3RlbWQtam91cm5hbGRbMTc0XTogL2Rldi9rbXNnIGJ1ZmZlciBv
dmVycnVuLCBzb21lIG1lc3NhZ2VzIGxvc3QuDQpkb25lLg0KUE06IHN1c3BlbmQgZXhpdA0KZTEw
MDBlIDAwMDA6MDA6MWYuNiBldGgwOiBOSUMgTGluayBpcyBVcCAxMDAgTWJwcyBGdWxsIER1cGxl
eCwgRmxvdyBDb250cm9sOiBSeC9UeA0KZTEwMDBlIDAwMDA6MDA6MWYuNiBldGgwOiAxMC8xMDAg
c3BlZWQ6IGRpc2FibGluZyBUU08NCnNoLTUuMCMNCnNoLTUuMCMNCg0KDQoNCltFWFRFUk5BTCBF
TUFJTF0NCj4NCj4gSGkgTGltb25jaWVsbG8sDQo+DQo+IE9uIDcvMjEvMjAgMTA6NDQgUE0sIExp
bW9uY2llbGxvLCBNYXJpbyB3cm90ZToNCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gPj4gRnJvbTogaW9tbXU8aW9tbXUtYm91bmNlc0BsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
Zz4gIE9uIEJlaGFsZiBPZiBMdQ0KPiA+PiBCYW9sdQ0KPiA+PiBTZW50OiBNb25kYXksIEp1bHkg
MjAsIDIwMjAgNzoxNyBQTQ0KPiA+PiBUbzogSm9lcmcgUm9lZGVsDQo+ID4+IENjOiBBc2hvayBS
YWo7bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZztzdGFibGVAdmdlci5rZXJuZWwub3JnOyBL
b2JhDQo+ID4+IEtvO2lvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnDQo+ID4+IFN1Ympl
Y3Q6IFtQQVRDSCAxLzFdIGlvbW11L3Z0LWQ6IFNraXAgVEUgZGlzYWJsaW5nIG9uIHF1aXJreSBn
ZnggZGVkaWNhdGVkDQo+ID4+IGlvbW11DQo+ID4+DQo+ID4+IFRoZSBWVC1kIHNwZWMgcmVxdWly
ZXMgKDEwLjQuNCBHbG9iYWwgQ29tbWFuZCBSZWdpc3RlciwgVEUgZmllbGQpIHRoYXQ6DQo+ID4+
DQo+ID4+IEhhcmR3YXJlIGltcGxlbWVudGF0aW9ucyBzdXBwb3J0aW5nIERNQSBkcmFpbmluZyBt
dXN0IGRyYWluIGFueSBpbi1mbGlnaHQNCj4gPj4gRE1BIHJlYWQvd3JpdGUgcmVxdWVzdHMgcXVl
dWVkIHdpdGhpbiB0aGUgUm9vdC1Db21wbGV4IGJlZm9yZSBjb21wbGV0aW5nDQo+ID4+IHRoZSB0
cmFuc2xhdGlvbiBlbmFibGUgY29tbWFuZCBhbmQgcmVmbGVjdGluZyB0aGUgc3RhdHVzIG9mIHRo
ZSBjb21tYW5kDQo+ID4+IHRocm91Z2ggdGhlIFRFUyBmaWVsZCBpbiB0aGUgR2xvYmFsIFN0YXR1
cyByZWdpc3Rlci4NCj4gPj4NCj4gPj4gVW5mb3J0dW5hdGVseSwgc29tZSBpbnRlZ3JhdGVkIGdy
YXBoaWMgZGV2aWNlcyBmYWlsIHRvIGRvIHNvIGFmdGVyIHNvbWUNCj4gPj4ga2luZCBvZiBwb3dl
ciBzdGF0ZSB0cmFuc2l0aW9uLiBBcyB0aGUgcmVzdWx0LCB0aGUgc3lzdGVtIG1pZ2h0IHN0dWNr
IGluDQo+ID4+IGlvbW11X2Rpc2FibGVfdHJhbnNsYXRpb24oKSwgd2FpdGluZyBmb3IgdGhlIGNv
bXBsZXRpb24gb2YgVEUgdHJhbnNpdGlvbi4NCj4gPj4NCj4gPj4gVGhpcyBwcm92aWRlcyBhIHF1
aXJrIGxpc3QgZm9yIHRob3NlIGRldmljZXMgYW5kIHNraXBzIFRFIGRpc2FibGluZyBpZg0KPiA+
PiB0aGUgcXVyaWsgaGl0cy4NCj4gPj4NCj4gPj4gRml4ZXM6aHR0cHM6Ly9idWd6aWxsYS5rZXJu
ZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMDgzNjMNCj4gPiBUaGF0IG9uZSBpcyBmb3IgVEdMLg0K
PiA+DQo+ID4gSSB0aGluayB5b3UgYWxzbyB3YW50IHRvIGFkZCB0aGlzIG9uZSBmb3IgSUNMOg0K
PiA+IEZpeGVzOmh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjA2
NTcxDQo+ID4NCj4NCj4gRG8geW91IG1lYW4gc29tZW9uZSBoYXZlIHRlc3RlZCB0aGF0IHRoaXMg
cGF0Y2ggYWxzbyBmaXhlcyB0aGUgcHJvYmxlbQ0KPiBkZXNjcmliZWQgaW4gMjA2NTcxPw0KPg0K
DQpZZXMsIGNvbmZ1c2luZ2x5IGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5j
Z2k/aWQ9MjA4MzYzI2MzMSBhY3R1YWxseQ0KaXMgdGhlIFhQUyA5MzAwIElDTCBzeXN0ZW0gYW5k
IGlzc3VlLg0KDQpJIGFsc28gaGF2ZSBhIHByaXZhdGUgY29uZmlybWF0aW9uIGZyb20gYW5vdGhl
ciBwZXJzb24gdGhhdCBpdCByZXNvbHZlcyBpdCBmb3INCnRoZW0gb24gYW5vdGhlciBJQ0wgcGxh
dGZvcm0uDQoNCkNocmlzdGlhbiwgbWF5YmUgeW91IGNhbiBhZGQgYSB0ZXN0ZWQgYnkgY2xhdXNl
IGZvciB0aGUgSUNMIHRlc3RpbmcuDQoNCg==

--_000_DM6PR11MB2587034DFBEDFB091CE9AAD58E790DM6PR11MB2587namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<pre style=3D"font-size:13px; font-family:monospace"><span>Hi Lu,  limoncie=
llo.</span></pre>
<pre style=3D"font-size:13px; font-family:monospace"><span>Yestoday i just =
verified the issue with the patch. and just iommu Subscription today.This i=
s my test log.</span></pre>
<pre style=3D"font-size:13px; font-family:monospace"><span>[Hardware info]<=
/span></pre>
<pre style=3D"font-size:13px; font-family:monospace"><span><blockquote type=
=3D"cite" style=3D"color: rgb(32, 31, 30); font-family: &quot;Microsoft Yah=
ei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMac=
SystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 15px=
; background-color: rgb(255, 255, 255)"><pre><blockquote type=3D"cite"><pre=
> Intel(R) Core(TM) i7-1065G7 CPU @ 1.30GHz           1.20GHz=0A=
 ICLSFWR1.R00.3162.A00.1904162000=0A=
 BIOS Information</pre><pre> BIOS Vendo Intel</pre><pre>       Core Version=
                     1.5.2.0 RP01=0A=
       Client Silicon Version           0.2.0.15=0A=
       Project Version                  ICLSFWR1.R00.3162.A00.1904162000=0A=
       Build Date                       20:00 04/16/2019=0A=
=0A=
       Board Name                       IceLake U DDR4 SODIMM PD RVP TLC=0A=
=0A=
       Processor Information=0A=
       Name                             IceLake UL</pre></blockquote></pre>=
</blockquote>[S3(mem) failed]</span></pre>
<pre style=3D"font-size:13px; font-family:monospace"><span>$ echo deep &gt;=
 /sys/power/mem_sleep</span></pre>
<pre style=3D"font-size:13px; font-family:monospace"><span>$ rtcwake -m mem=
 -s 10</span></pre>
<pre style=3D"font-size:13px; font-family:monospace"><span><blockquote type=
=3D"cite" style=3D"color: rgb(32, 31, 30); font-family: &quot;Microsoft Yah=
ei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMac=
SystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 15px=
; background-color: rgb(255, 255, 255)"><pre><blockquote type=3D"cite"><pre=
>ACPI: EC: interrupt blocked=0A=
e1000e 0000:00:1f.6: pci_pm_suspend_noirq&#43;0x0/0x250 returned 0 after 14=
317=0A=
usecs=0A=
ec PNP0C09:00: acpi_ec_suspend_noirq&#43;0x0/0x50 returned 0 after 355319 u=
secs=0A=
wdat_wdt wdat_wdt: calling wdat_wdt_suspend_noirq&#43;0x0/0x66 [wdat_wdt] @=
 347,=0A=
parent: platform=0A=
ahci 0000:00:17.0: pci_pm_suspend_noirq&#43;0x0/0x250 returned 0 after 3838=
43=0A=
usecs=0A=
intel-lpss 0000:00:1e.3: pci_pm_suspend_noirq&#43;0x0/0x250 returned 0 afte=
r=0A=
384062 usecs=0A=
wdat_wdt wdat_wdt: wdat_wdt_suspend_noirq&#43;0x0/0x66 [wdat_wdt] returned =
0=0A=
after 11 usecs=0A=
intel-lpss 0000:00:1e.0: pci_pm_suspend_noirq&#43;0x0/0x250 returned 0 afte=
r=0A=
414466 usecs=0A=
xhci_hcd 0000:00:14.0: pci_pm_suspend_noirq&#43;0x0/0x250 returned 0 after=
=0A=
414023 usecs=0A=
sdhci-pci 0000:00:14.5: pci_pm_suspend_noirq&#43;0x0/0x250 returned 0 after=
=0A=
429325 usecs=0A=
pcieport 0000:00:07.3: pci_pm_suspend_noirq&#43;0x0/0x250 returned 0 after=
=0A=
429026 usecs=0A=
pcieport 0000:00:07.1: pci_pm_suspend_noirq&#43;0x0/0x250 returned 0 after=
=0A=
429675 usecs=0A=
pcieport 0000:00:07.2: pci_pm_suspend_noirq&#43;0x0/0x250 returned 0 after=
=0A=
430309 usecs=0A=
pcieport 0000:00:07.0: pci_pm_suspend_noirq&#43;0x0/0x250 returned 0 after=
=0A=
430213 usecs=0A=
thunderbolt 0000:00:0d.2: pci_pm_suspend_noirq&#43;0x0/0x250 returned 0 aft=
er=0A=
432523 usecs=0A=
thunderbolt 0000:00:0d.3: pci_pm_suspend_noirq&#43;0x0/0x250 returned 0 aft=
er=0A=
432815 usecs=0A=
ACPI: Preparing to enter system sleep state S3=0A=
ACPI: EC: event blocked=0A=
ACPI: EC: EC stopped=0A=
PM: Saving platform NVS memory=0A=
Disabling non-boot CPUs ...=0A=
smpboot: CPU 1 is now offline=0A=
smpboot: CPU 2 is now offline=0A=
smpboot: CPU 3 is now offline=0A=
smpboot: CPU 4 is now offline=0A=
smpboot: CPU 5 is now offline=0A=
smpboot: CPU 6 is now offline=0A=
smpboot: CPU 7 is now offline=0A=
PM: Calling mce_syscore_suspend&#43;0x0/0x20=0A=
PM: Calling nmi_suspend&#43;0x0/0x20=0A=
PM: Calling timekeeping_suspend&#43;0x0/0x2d0=0A=
PM: Calling save_ioapic_entries&#43;0x0/0x90=0A=
PM: Calling i8259A_suspend&#43;0x0/0x30=0A=
PM: Calling iommu_suspend&#43;0x0/0x1b0=0A=
Kernel panic - not syncing: DMAR hardware is malfunctioning=0A=
CPU: 0 PID: 347 Comm: rtcwake Not tainted 5.4.0-yocto-standard #124=0A=
Hardware name: Intel Corporation Ice Lake Client Platform/IceLake U DDR4=0A=
SODIMM PD RVP TLC, BIOS ICLSFWR1.R00.3162.A00.1904162000 04/16/2019=0A=
Call Trace:=0A=
  dump_stack&#43;0x59/0x75=0A=
  panic&#43;0xff/0x2d4=0A=
  iommu_disable_translation&#43;0x88/0x90=0A=
  iommu_suspend&#43;0x12f/0x1b0=0A=
  syscore_suspend&#43;0x6c/0x220=0A=
  suspend_devices_and_enter&#43;0x313/0x840=0A=
  pm_suspend&#43;0x30d/0x390=0A=
  state_store&#43;0x82/0xf0=0A=
  kobj_attr_store&#43;0x12/0x20=0A=
  sysfs_kf_write&#43;0x3c/0x50=0A=
  kernfs_fop_write&#43;0x11d/0x190=0A=
  __vfs_write&#43;0x1b/0x40=0A=
  vfs_write&#43;0xc6/0x1d0=0A=
  ksys_write&#43;0x5e/0xe0=0A=
  __x64_sys_write&#43;0x1a/0x20=0A=
  do_syscall_64&#43;0x4d/0x150=0A=
  entry_SYSCALL_64_after_hwframe&#43;0x44/0xa9=0A=
RIP: 0033:0x7f97b8080113=0A=
Code: 8b 15 81 bd 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00=
=0A=
64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 &lt;48&gt; 3d 00 f=
0 ff ff=0A=
77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18=0A=
RSP: 002b:00007ffcfa6f48b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001=0A=
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f97b8080113=0A=
RDX: 0000000000000004 RSI: 000055e7db03b700 RDI: 0000000000000004=0A=
RBP: 000055e7db03b700 R08: 000055e7db03b700 R09: 0000000000000004=0A=
R10: 0000000000000004 R11: 0000000000000246 R12: 0000000000000004=0A=
R13: 000055e7db039380 R14: 0000000000000004 R15: 00007f97b814d700=0A=
Kernel Offset: 0x38a00000 from 0xffffffff81000000 (relocation range:=0A=
0xffffffff80000000-0xffffffffbfffffff)=0A=
---[ end Kernel panic - not syncing: DMAR hardware is malfunctioning ]---</=
pre></blockquote></pre></blockquote></span></pre>
<pre style=3D"font-size:13px; font-family:monospace"><span>[S3 successfully=
 with the patch]</span></pre>
<pre style=3D"font-size:13px; font-family:monospace"><span><span style=3D"c=
olor: rgb(32, 31, 30); font-family: &quot;Microsoft Yahei UI&quot;, Verdana=
, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, =
&quot;Helvetica Neue&quot;, sans-serif; font-size: 15px; background-color: =
rgb(255, 255, 255); display: inline !important">sh-5.0# uname -a</span><br =
style=3D"color: rgb(32, 31, 30); font-family: &quot;Microsoft Yahei UI&quot=
;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont=
, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 15px; backgrou=
nd-color: rgb(255, 255, 255)"><span style=3D"color: rgb(32, 31, 30); font-f=
amily: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot=
;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, s=
ans-serif; font-size: 15px; background-color: rgb(255, 255, 255); display: =
inline !important">Linux intel-x86-64 5.8.0-rc6-yoctodev-standard&#43; #128=
 SMP PREEMPT Tue Jul 21 12:14:39 CST 2020 x86_64 x86_64 x86_64 GNU/Linux</s=
pan><br style=3D"color: rgb(32, 31, 30); font-family: &quot;Microsoft Yahei=
 UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSy=
stemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 15px; =
background-color: rgb(255, 255, 255)"><span style=3D"color: rgb(32, 31, 30)=
; font-family: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe=
 UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&=
quot;, sans-serif; font-size: 15px; background-color: rgb(255, 255, 255); d=
isplay: inline !important">sh-5.0#</span><br style=3D"color: rgb(32, 31, 30=
); font-family: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Sego=
e UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue=
&quot;, sans-serif; font-size: 15px; background-color: rgb(255, 255, 255)">=
<br style=3D"color: rgb(32, 31, 30); font-family: &quot;Microsoft Yahei UI&=
quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystem=
Font, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 15px; back=
ground-color: rgb(255, 255, 255)"><span style=3D"color: rgb(32, 31, 30); fo=
nt-family: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&=
quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot=
;, sans-serif; font-size: 15px; background-color: rgb(255, 255, 255); displ=
ay: inline !important">sh-5.0# lsmod |grep -i thunderbolt</span><br style=
=3D"color: rgb(32, 31, 30); font-family: &quot;Microsoft Yahei UI&quot;, Ve=
rdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Rob=
oto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 15px; background-co=
lor: rgb(255, 255, 255)"><span style=3D"color: rgb(32, 31, 30); font-family=
: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -a=
pple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-s=
erif; font-size: 15px; background-color: rgb(255, 255, 255); display: inlin=
e !important">intel_wmi_thunderbolt&nbsp;&nbsp;&nbsp; 16384&nbsp; 0</span><=
br style=3D"color: rgb(32, 31, 30); font-family: &quot;Microsoft Yahei UI&q=
uot;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemF=
ont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 15px; backg=
round-color: rgb(255, 255, 255)"><span style=3D"color: rgb(32, 31, 30); fon=
t-family: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&q=
uot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;=
, sans-serif; font-size: 15px; background-color: rgb(255, 255, 255); displa=
y: inline !important">thunderbolt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 167936&nbsp; 0</span><br style=3D"color: rgb(32, 31, 30)=
; font-family: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe=
 UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&=
quot;, sans-serif; font-size: 15px; background-color: rgb(255, 255, 255)"><=
span style=3D"color: rgb(32, 31, 30); font-family: &quot;Microsoft Yahei UI=
&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSyste=
mFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 15px; bac=
kground-color: rgb(255, 255, 255); display: inline !important">wmi&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 24576&nbsp; 2 intel_wmi_thunderbolt,wmi_bmof=
</span><br style=3D"color: rgb(32, 31, 30); font-family: &quot;Microsoft Ya=
hei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMa=
cSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 15p=
x; background-color: rgb(255, 255, 255)"><span style=3D"color: rgb(32, 31, =
30); font-family: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Se=
goe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Ne=
ue&quot;, sans-serif; font-size: 15px; background-color: rgb(255, 255, 255)=
; display: inline !important">sh-5.0#</span><br style=3D"color: rgb(32, 31,=
 30); font-family: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;S=
egoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica N=
eue&quot;, sans-serif; font-size: 15px; background-color: rgb(255, 255, 255=
)"><span style=3D"color: rgb(32, 31, 30); font-family: &quot;Microsoft Yahe=
i UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacS=
ystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 15px;=
 background-color: rgb(255, 255, 255); display: inline !important">sh-5.0#<=
/span><br style=3D"color: rgb(32, 31, 30); font-family: &quot;Microsoft Yah=
ei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMac=
SystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 15px=
; background-color: rgb(255, 255, 255)"><span style=3D"color: rgb(32, 31, 3=
0); font-family: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Seg=
oe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neu=
e&quot;, sans-serif; font-size: 15px; background-color: rgb(255, 255, 255);=
 display: inline !important">sh-5.0#</span><br style=3D"color: rgb(32, 31, =
30); font-family: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Se=
goe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Ne=
ue&quot;, sans-serif; font-size: 15px; background-color: rgb(255, 255, 255)=
"><span style=3D"color: rgb(32, 31, 30); font-family: &quot;Microsoft Yahei=
 UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSy=
stemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 15px; =
background-color: rgb(255, 255, 255); display: inline !important">sh-5.0# m=
odinfo thunderbolt</span><br style=3D"color: rgb(32, 31, 30); font-family: =
&quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -app=
le-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-ser=
if; font-size: 15px; background-color: rgb(255, 255, 255)"><span style=3D"c=
olor: rgb(32, 31, 30); font-family: &quot;Microsoft Yahei UI&quot;, Verdana=
, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, =
&quot;Helvetica Neue&quot;, sans-serif; font-size: 15px; background-color: =
rgb(255, 255, 255); display: inline !important">filename: /lib/modules/5.8.=
0-rc6-yoctodev-standard&#43;/kernel/drivers/thunderbolt/thunderbolt.ko</spa=
n><br style=3D"color: rgb(32, 31, 30); font-family: &quot;Microsoft Yahei U=
I&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSyst=
emFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 15px; ba=
ckground-color: rgb(255, 255, 255)"><span style=3D"color: rgb(32, 31, 30); =
font-family: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe U=
I&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&qu=
ot;, sans-serif; font-size: 15px; background-color: rgb(255, 255, 255); dis=
play: inline !important">license:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 GPL</span><br style=3D"color: rgb(32, 31, 30); font-family: &quot;Microsof=
t Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, Bli=
nkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size:=
 15px; background-color: rgb(255, 255, 255)"><span style=3D"color: rgb(32, =
31, 30); font-family: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quo=
t;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetic=
a Neue&quot;, sans-serif; font-size: 15px; background-color: rgb(255, 255, =
255); display: inline !important">alias:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pci:v*d*sv*sd*bc0Csc03i40*</span><br style=3D"color: rg=
b(32, 31, 30); font-family: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun=
, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;He=
lvetica Neue&quot;, sans-serif; font-size: 15px; background-color: rgb(255,=
 255, 255)"><span style=3D"color: rgb(32, 31, 30); font-family: &quot;Micro=
soft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, =
BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-si=
ze: 15px; background-color: rgb(255, 255, 255); display: inline !important"=
>alias:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci:v00008086=
d00009A1Dsv*sd*bc*sc*i*</span><br style=3D"color: rgb(32, 31, 30); font-fam=
ily: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;,=
 -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, san=
s-serif; font-size: 15px; background-color: rgb(255, 255, 255)"><span style=
=3D"color: rgb(32, 31, 30); font-family: &quot;Microsoft Yahei UI&quot;, Ve=
rdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Rob=
oto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 15px; background-co=
lor: rgb(255, 255, 255); display: inline !important">alias:&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci:v00008086d00009A1Bsv*sd*bc*sc*i*=
</span><br style=3D"color: rgb(32, 31, 30); font-family: &quot;Microsoft Ya=
hei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMa=
cSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 15p=
x; background-color: rgb(255, 255, 255)"><span style=3D"color: rgb(32, 31, =
30); font-family: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Se=
goe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Ne=
ue&quot;, sans-serif; font-size: 15px; background-color: rgb(255, 255, 255)=
; display: inline !important">alias:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pci:v00008086d00008A0Dsv*sd*bc*sc*i*</span><br style=3D"col=
or: rgb(32, 31, 30); font-family: &quot;Microsoft Yahei UI&quot;, Verdana, =
Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &q=
uot;Helvetica Neue&quot;, sans-serif; font-size: 15px; background-color: rg=
b(255, 255, 255)"><span style=3D"color: rgb(32, 31, 30); font-family: &quot=
;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-sy=
stem, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; f=
ont-size: 15px; background-color: rgb(255, 255, 255); display: inline !impo=
rtant">alias:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci:v00=
008086d00008A17sv*sd*bc*sc*i*</span><br style=3D"color: rgb(32, 31, 30); fo=
nt-family: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&=
quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot=
;, sans-serif; font-size: 15px; background-color: rgb(255, 255, 255)"><span=
 style=3D"color: rgb(32, 31, 30); font-family: &quot;Microsoft Yahei UI&quo=
t;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFon=
t, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 15px; backgro=
und-color: rgb(255, 255, 255); display: inline !important">alias:&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci:v00008086d000015EBsv*sd*bc=
*sc*i*</span><br style=3D"color: rgb(32, 31, 30); font-family: &quot;Micros=
oft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, B=
linkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-siz=
e: 15px; background-color: rgb(255, 255, 255)"><span style=3D"color: rgb(32=
, 31, 30); font-family: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &q=
uot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvet=
ica Neue&quot;, sans-serif; font-size: 15px; background-color: rgb(255, 255=
, 255); display: inline !important">alias:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pci:v00008086d000015E8sv*sd*bc*sc*i*</span><br style=
=3D"color: rgb(32, 31, 30); font-family: &quot;Microsoft Yahei UI&quot;, Ve=
rdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Rob=
oto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 15px; background-co=
lor: rgb(255, 255, 255)"><span style=3D"color: rgb(32, 31, 30); font-family=
: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -a=
pple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-s=
erif; font-size: 15px; background-color: rgb(255, 255, 255); display: inlin=
e !important">alias:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
pci:v00008086d000015DEsv*sd*bc*sc*i*</span><br style=3D"color: rgb(32, 31, =
30); font-family: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Se=
goe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Ne=
ue&quot;, sans-serif; font-size: 15px; background-color: rgb(255, 255, 255)=
"><span style=3D"color: rgb(32, 31, 30); font-family: &quot;Microsoft Yahei=
 UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSy=
stemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 15px; =
background-color: rgb(255, 255, 255); display: inline !important">alias:&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci:v00008086d000015D2s=
v*sd*bc*sc*i*</span><br style=3D"color: rgb(32, 31, 30); font-family: &quot=
;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-sy=
stem, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; f=
ont-size: 15px; background-color: rgb(255, 255, 255)"><span style=3D"color:=
 rgb(32, 31, 30); font-family: &quot;Microsoft Yahei UI&quot;, Verdana, Sim=
sun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot=
;Helvetica Neue&quot;, sans-serif; font-size: 15px; background-color: rgb(2=
55, 255, 255); display: inline !important">alias:&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; pci:v00008086d000015D9sv*sd*bc*sc*i*</span><br=
 style=3D"color: rgb(32, 31, 30); font-family: &quot;Microsoft Yahei UI&quo=
t;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFon=
t, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 15px; backgro=
und-color: rgb(255, 255, 255)"><span style=3D"color: rgb(32, 31, 30); font-=
family: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quo=
t;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, =
sans-serif; font-size: 15px; background-color: rgb(255, 255, 255); display:=
 inline !important">alias:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; pci:v00008086d000015DCsv*sd*bc*sc*i*</span><br style=3D"color: rgb(32=
, 31, 30); font-family: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &q=
uot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvet=
ica Neue&quot;, sans-serif; font-size: 15px; background-color: rgb(255, 255=
, 255)"><span style=3D"color: rgb(32, 31, 30); font-family: &quot;Microsoft=
 Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, Blin=
kMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: =
15px; background-color: rgb(255, 255, 255); display: inline !important">ali=
as:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci:v00008086d000=
015BFsv*sd*bc*sc*i*</span><br style=3D"color: rgb(32, 31, 30); font-family:=
 &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -ap=
ple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-se=
rif; font-size: 15px; background-color: rgb(255, 255, 255)"><span style=3D"=
color: rgb(32, 31, 30); font-family: &quot;Microsoft Yahei UI&quot;, Verdan=
a, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto,=
 &quot;Helvetica Neue&quot;, sans-serif; font-size: 15px; background-color:=
 rgb(255, 255, 255); display: inline !important">alias:&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci:v00008086d000015DDsv*sd*bc*sc*i*</sp=
an><br style=3D"color: rgb(32, 31, 30); font-family: &quot;Microsoft Yahei =
UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSys=
temFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 15px; b=
ackground-color: rgb(255, 255, 255)"><span style=3D"color: rgb(32, 31, 30);=
 font-family: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe =
UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&q=
uot;, sans-serif; font-size: 15px; background-color: rgb(255, 255, 255); di=
splay: inline !important">alias:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; pci:v00008086d00001577sv*sd*bc*sc*i*</span><br style=3D"color: =
rgb(32, 31, 30); font-family: &quot;Microsoft Yahei UI&quot;, Verdana, Sims=
un, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;=
Helvetica Neue&quot;, sans-serif; font-size: 15px; background-color: rgb(25=
5, 255, 255)"><span style=3D"color: rgb(32, 31, 30); font-family: &quot;Mic=
rosoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system=
, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-=
size: 15px; background-color: rgb(255, 255, 255); display: inline !importan=
t">alias:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci:v000080=
86d00001575sv*sd*bc*sc*i*</span><br style=3D"color: rgb(32, 31, 30); font-f=
amily: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot=
;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, s=
ans-serif; font-size: 15px; background-color: rgb(255, 255, 255)"><span sty=
le=3D"color: rgb(32, 31, 30); font-family: &quot;Microsoft Yahei UI&quot;, =
Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 15px; background-=
color: rgb(255, 255, 255); display: inline !important">alias:&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci:v00008086d0000156Csv*sd*bc08sc=
80i00*</span><br style=3D"color: rgb(32, 31, 30); font-family: &quot;Micros=
oft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, B=
linkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-siz=
e: 15px; background-color: rgb(255, 255, 255)"><span style=3D"color: rgb(32=
, 31, 30); font-family: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &q=
uot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvet=
ica Neue&quot;, sans-serif; font-size: 15px; background-color: rgb(255, 255=
, 255); display: inline !important">alias:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pci:v00008086d0000156Asv*sd*bc08sc80i00*</span><br st=
yle=3D"color: rgb(32, 31, 30); font-family: &quot;Microsoft Yahei UI&quot;,=
 Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, =
Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 15px; background=
-color: rgb(255, 255, 255)"><span style=3D"color: rgb(32, 31, 30); font-fam=
ily: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;,=
 -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, san=
s-serif; font-size: 15px; background-color: rgb(255, 255, 255); display: in=
line !important">alias: pci:v00008086d00001547sv00002222sd00001111bc08sc80i=
00*</span><br style=3D"color: rgb(32, 31, 30); font-family: &quot;Microsoft=
 Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, Blin=
kMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: =
15px; background-color: rgb(255, 255, 255)"><span style=3D"color: rgb(32, 3=
1, 30); font-family: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot=
;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica=
 Neue&quot;, sans-serif; font-size: 15px; background-color: rgb(255, 255, 2=
55); display: inline !important">alias: pci:v00008086d00001513sv00002222sd0=
0001111bc08sc80i00*</span><br style=3D"color: rgb(32, 31, 30); font-family:=
 &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -ap=
ple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-se=
rif; font-size: 15px; background-color: rgb(255, 255, 255)"><span style=3D"=
color: rgb(32, 31, 30); font-family: &quot;Microsoft Yahei UI&quot;, Verdan=
a, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto,=
 &quot;Helvetica Neue&quot;, sans-serif; font-size: 15px; background-color:=
 rgb(255, 255, 255); display: inline !important">depends:</span><br style=
=3D"color: rgb(32, 31, 30); font-family: &quot;Microsoft Yahei UI&quot;, Ve=
rdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Rob=
oto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 15px; background-co=
lor: rgb(255, 255, 255)"><span style=3D"color: rgb(32, 31, 30); font-family=
: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -a=
pple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-s=
erif; font-size: 15px; background-color: rgb(255, 255, 255); display: inlin=
e !important">retpoline:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Y</span><br style=3D=
"color: rgb(32, 31, 30); font-family: &quot;Microsoft Yahei UI&quot;, Verda=
na, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto=
, &quot;Helvetica Neue&quot;, sans-serif; font-size: 15px; background-color=
: rgb(255, 255, 255)"><span style=3D"color: rgb(32, 31, 30); font-family: &=
quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -appl=
e-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-seri=
f; font-size: 15px; background-color: rgb(255, 255, 255); display: inline !=
important">intree:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Y</span>=
<br style=3D"color: rgb(32, 31, 30); font-family: &quot;Microsoft Yahei UI&=
quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystem=
Font, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 15px; back=
ground-color: rgb(255, 255, 255)"><span style=3D"color: rgb(32, 31, 30); fo=
nt-family: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&=
quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot=
;, sans-serif; font-size: 15px; background-color: rgb(255, 255, 255); displ=
ay: inline !important">name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; thunderbolt</span><br style=3D"color: rgb(32, 31, 30); font-f=
amily: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot=
;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, s=
ans-serif; font-size: 15px; background-color: rgb(255, 255, 255)"><span sty=
le=3D"color: rgb(32, 31, 30); font-family: &quot;Microsoft Yahei UI&quot;, =
Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 15px; background-=
color: rgb(255, 255, 255); display: inline !important">vermagic:&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; 5.8.0-rc6-yoctodev-standard&#43; SMP preempt mod_=
unload</span><br style=3D"color: rgb(32, 31, 30); font-family: &quot;Micros=
oft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, B=
linkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-siz=
e: 15px; background-color: rgb(255, 255, 255)"><span style=3D"color: rgb(32=
, 31, 30); font-family: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &q=
uot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvet=
ica Neue&quot;, sans-serif; font-size: 15px; background-color: rgb(255, 255=
, 255); display: inline !important">parm:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; start_icm:start ICM firmware if it is not runnin=
g (default: false) (bool)</span><br style=3D"color: rgb(32, 31, 30); font-f=
amily: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot=
;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, s=
ans-serif; font-size: 15px; background-color: rgb(255, 255, 255)"><span sty=
le=3D"color: rgb(32, 31, 30); font-family: &quot;Microsoft Yahei UI&quot;, =
Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 15px; background-=
color: rgb(255, 255, 255); display: inline !important">sh-5.0#</span><br st=
yle=3D"color: rgb(32, 31, 30); font-family: &quot;Microsoft Yahei UI&quot;,=
 Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, =
Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 15px; background=
-color: rgb(255, 255, 255)"><span style=3D"color: rgb(32, 31, 30); font-fam=
ily: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;,=
 -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, san=
s-serif; font-size: 15px; background-color: rgb(255, 255, 255); display: in=
line !important">sh-5.0#</span><br style=3D"color: rgb(32, 31, 30); font-fa=
mily: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;=
, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sa=
ns-serif; font-size: 15px; background-color: rgb(255, 255, 255)"><span styl=
e=3D"color: rgb(32, 31, 30); font-family: &quot;Microsoft Yahei UI&quot;, V=
erdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Ro=
boto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 15px; background-c=
olor: rgb(255, 255, 255); display: inline !important">sh-5.0# echo deep&nbs=
p; &gt; /sys/power/mem_sleep</span><br style=3D"color: rgb(32, 31, 30); fon=
t-family: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&q=
uot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;=
, sans-serif; font-size: 15px; background-color: rgb(255, 255, 255)"><span =
style=3D"color: rgb(32, 31, 30); font-family: &quot;Microsoft Yahei UI&quot=
;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont=
, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 15px; backgrou=
nd-color: rgb(255, 255, 255); display: inline !important">sh-5.0#</span><br=
 style=3D"color: rgb(32, 31, 30); font-family: &quot;Microsoft Yahei UI&quo=
t;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFon=
t, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 15px; backgro=
und-color: rgb(255, 255, 255)"><span style=3D"color: rgb(32, 31, 30); font-=
family: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quo=
t;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, =
sans-serif; font-size: 15px; background-color: rgb(255, 255, 255); display:=
 inline !important">sh-5.0# rtcwake -m mem -s 10</span><br style=3D"color: =
rgb(32, 31, 30); font-family: &quot;Microsoft Yahei UI&quot;, Verdana, Sims=
un, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;=
Helvetica Neue&quot;, sans-serif; font-size: 15px; background-color: rgb(25=
5, 255, 255)"><span style=3D"color: rgb(32, 31, 30); font-family: &quot;Mic=
rosoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system=
, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-=
size: 15px; background-color: rgb(255, 255, 255); display: inline !importan=
t">rtcwake: assuming RTC uses UTC ...</span><br style=3D"color: rgb(32, 31,=
 30); font-family: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;S=
egoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica N=
eue&quot;, sans-serif; font-size: 15px; background-color: rgb(255, 255, 255=
)"><span style=3D"color: rgb(32, 31, 30); font-family: &quot;Microsoft Yahe=
i UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacS=
ystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 15px;=
 background-color: rgb(255, 255, 255); display: inline !important">rtcwake:=
 wakeup from &quot;mem&quot; using /dev/rtc0 at Mon Jul 20 21:13:04 2020</s=
pan><br style=3D"color: rgb(32, 31, 30); font-family: &quot;Microsoft Yahei=
 UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSy=
stemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 15px; =
background-color: rgb(255, 255, 255)"><span style=3D"color: rgb(32, 31, 30)=
; font-family: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe=
 UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&=
quot;, sans-serif; font-size: 15px; background-color: rgb(255, 255, 255); d=
isplay: inline !important">PM: suspend entry (deep)</span><br style=3D"colo=
r: rgb(32, 31, 30); font-family: &quot;Microsoft Yahei UI&quot;, Verdana, S=
imsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &qu=
ot;Helvetica Neue&quot;, sans-serif; font-size: 15px; background-color: rgb=
(255, 255, 255)"><span style=3D"color: rgb(32, 31, 30); font-family: &quot;=
Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-sys=
tem, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; fo=
nt-size: 15px; background-color: rgb(255, 255, 255); display: inline !impor=
tant">Filesystems sync: 0.000 seconds</span><br style=3D"color: rgb(32, 31,=
 30); font-family: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;S=
egoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica N=
eue&quot;, sans-serif; font-size: 15px; background-color: rgb(255, 255, 255=
)"><span style=3D"color: rgb(32, 31, 30); font-family: &quot;Microsoft Yahe=
i UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacS=
ystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 15px;=
 background-color: rgb(255, 255, 255); display: inline !important">Freezing=
 user space processes ... (elapsed 0.014 seconds) done.</span><br style=3D"=
color: rgb(32, 31, 30); font-family: &quot;Microsoft Yahei UI&quot;, Verdan=
a, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto,=
 &quot;Helvetica Neue&quot;, sans-serif; font-size: 15px; background-color:=
 rgb(255, 255, 255)"><span style=3D"color: rgb(32, 31, 30); font-family: &q=
uot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple=
-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif=
; font-size: 15px; background-color: rgb(255, 255, 255); display: inline !i=
mportant">OOM killer disabled.</span><br style=3D"color: rgb(32, 31, 30); f=
ont-family: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI=
&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quo=
t;, sans-serif; font-size: 15px; background-color: rgb(255, 255, 255)"><spa=
n style=3D"color: rgb(32, 31, 30); font-family: &quot;Microsoft Yahei UI&qu=
ot;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFo=
nt, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 15px; backgr=
ound-color: rgb(255, 255, 255); display: inline !important">Freezing remain=
ing freezable tasks ... (elapsed 0.001 seconds) done.</span><br style=3D"co=
lor: rgb(32, 31, 30); font-family: &quot;Microsoft Yahei UI&quot;, Verdana,=
 Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &=
quot;Helvetica Neue&quot;, sans-serif; font-size: 15px; background-color: r=
gb(255, 255, 255)"><span style=3D"color: rgb(32, 31, 30); font-family: &quo=
t;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-s=
ystem, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; =
font-size: 15px; background-color: rgb(255, 255, 255); display: inline !imp=
ortant">input input14: calling input_dev_suspend&#43;0x0/0x40 @ 310, parent=
: card0</span><br style=3D"color: rgb(32, 31, 30); font-family: &quot;Micro=
soft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, =
BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-si=
ze: 15px; background-color: rgb(255, 255, 255)"><span style=3D"color: rgb(3=
2, 31, 30); font-family: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &=
quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helve=
tica Neue&quot;, sans-serif; font-size: 15px; background-color: rgb(255, 25=
5, 255); display: inline !important">input input14: input_dev_suspend&#43;0=
x0/0x40 returned 0 after 0 usecs</span><br style=3D"color: rgb(32, 31, 30);=
 font-family: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe =
UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&q=
uot;, sans-serif; font-size: 15px; background-color: rgb(255, 255, 255)"><s=
pan style=3D"color: rgb(32, 31, 30); font-family: &quot;Microsoft Yahei UI&=
quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystem=
Font, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 15px; back=
ground-color: rgb(255, 255, 255); display: inline !important">input input13=
: calling input_dev_suspend&#43;0x0/0x40 @ 310, parent: card0</span><br sty=
le=3D"color: rgb(32, 31, 30); font-family: &quot;Microsoft Yahei UI&quot;, =
Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 15px; background-=
color: rgb(255, 255, 255)"><span style=3D"color: rgb(32, 31, 30); font-fami=
ly: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, =
-apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans=
-serif; font-size: 15px; background-color: rgb(255, 255, 255); display: inl=
ine !important">input input13: input_dev_suspend&#43;0x0/0x40 returned 0 af=
ter 0 usecs</span><br style=3D"color: rgb(32, 31, 30); font-family: &quot;M=
icrosoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-syst=
em, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; fon=
t-size: 15px; background-color: rgb(255, 255, 255)"><span style=3D"color: r=
gb(32, 31, 30); font-family: &quot;Microsoft Yahei UI&quot;, Verdana, Simsu=
n, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;H=
elvetica Neue&quot;, sans-serif; font-size: 15px; background-color: rgb(255=
, 255, 255); display: inline !important">input input12: calling input_dev_s=
uspend&#43;0x0/0x40 @ 310, parent: card0</span><br style=3D"color: rgb(32, =
31, 30); font-family: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quo=
t;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetic=
a Neue&quot;, sans-serif; font-size: 15px; background-color: rgb(255, 255, =
255)"><span style=3D"color: rgb(32, 31, 30); font-family: &quot;Microsoft Y=
ahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkM=
acSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 15=
px; background-color: rgb(255, 255, 255); display: inline !important">input=
 input12: input_dev_suspend&#43;0x0/0x40 returned 0 after 0 usecs</span><br=
 style=3D"color: rgb(32, 31, 30); font-family: &quot;Microsoft Yahei UI&quo=
t;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFon=
t, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 15px; backgro=
und-color: rgb(255, 255, 255)"><span style=3D"color: rgb(32, 31, 30); font-=
family: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quo=
t;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, =
sans-serif; font-size: 15px; background-color: rgb(255, 255, 255); display:=
 inline !important">input input11: calling input_dev_suspend&#43;0x0/0x40 @=
 310, parent: card0</span><br style=3D"color: rgb(32, 31, 30); font-family:=
 &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -ap=
ple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-se=
rif; font-size: 15px; background-color: rgb(255, 255, 255)"><span style=3D"=
color: rgb(32, 31, 30); font-family: &quot;Microsoft Yahei UI&quot;, Verdan=
a, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto,=
 &quot;Helvetica Neue&quot;, sans-serif; font-size: 15px; background-color:=
 rgb(255, 255, 255); display: inline !important">input input11: input_dev_s=
uspend&#43;0x0/0x40 returned 0 after 0 usecs</span><br style=3D"color: rgb(=
32, 31, 30); font-family: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, =
&quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helv=
etica Neue&quot;, sans-serif; font-size: 15px; background-color: rgb(255, 2=
55, 255)"><span style=3D"color: rgb(32, 31, 30); font-family: &quot;Microso=
ft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, Bl=
inkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size=
: 15px; background-color: rgb(255, 255, 255); display: inline !important">i=
nput input10: calling input_dev_suspend&#43;0x0/0x40 @ 310, parent: card0</=
span><br style=3D"color: rgb(32, 31, 30); font-family: &quot;Microsoft Yahe=
i UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacS=
ystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 15px;=
 background-color: rgb(255, 255, 255)"><span style=3D"color: rgb(32, 31, 30=
); font-family: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Sego=
e UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue=
&quot;, sans-serif; font-size: 15px; background-color: rgb(255, 255, 255); =
display: inline !important">input input10: input_dev_suspend&#43;0x0/0x40 r=
eturned 0 after 0 usecs</span><br style=3D"color: rgb(32, 31, 30); font-fam=
ily: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;,=
 -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, san=
s-serif; font-size: 15px; background-color: rgb(255, 255, 255)"><span style=
=3D"color: rgb(32, 31, 30); font-family: &quot;Microsoft Yahei UI&quot;, Ve=
rdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Rob=
oto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 15px; background-co=
lor: rgb(255, 255, 255); display: inline !important">input input9: calling =
input_dev_suspend&#43;0x0/0x40 @ 310, parent: card0</span><br style=3D"colo=
r: rgb(32, 31, 30); font-family: &quot;Microsoft Yahei UI&quot;, Verdana, S=
imsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &qu=
ot;Helvetica Neue&quot;, sans-serif; font-size: 15px; background-color: rgb=
(255, 255, 255)"><span style=3D"color: rgb(32, 31, 30); font-family: &quot;=
Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-sys=
tem, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; fo=
nt-size: 15px; background-color: rgb(255, 255, 255); display: inline !impor=
tant">input input9: input_dev_suspend&#43;0x0/0x40 returned 0 after 0 usecs=
</span><br style=3D"color: rgb(32, 31, 30); font-family: &quot;Microsoft Ya=
hei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMa=
cSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 15p=
x; background-color: rgb(255, 255, 255)"><span style=3D"color: rgb(32, 31, =
30); font-family: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Se=
goe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Ne=
ue&quot;, sans-serif; font-size: 15px; background-color: rgb(255, 255, 255)=
; display: inline !important">input input8: calling input_dev_suspend&#43;0=
x0/0x40 @ 310, parent: card0</span><br style=3D"color: rgb(32, 31, 30); fon=
t-family: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&q=
uot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;=
, sans-serif; font-size: 15px; background-color: rgb(255, 255, 255)"><span =
style=3D"color: rgb(32, 31, 30); font-family: &quot;Microsoft Yahei UI&quot=
;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont=
, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 15px; backgrou=
nd-color: rgb(255, 255, 255); display: inline !important">input input8: inp=
ut_dev_suspend&#43;0x0/0x40 returned 0 after 0 usecs</span><br style=3D"col=
or: rgb(32, 31, 30); font-family: &quot;Microsoft Yahei UI&quot;, Verdana, =
Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &q=
uot;Helvetica Neue&quot;, sans-serif; font-size: 15px; background-color: rg=
b(255, 255, 255)"><span style=3D"color: rgb(32, 31, 30); font-family: &quot=
;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-sy=
stem, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; f=
ont-size: 15px; background-color: rgb(255, 255, 255); display: inline !impo=
rtant">input input7: calling input_dev_suspend&#43;0x0/0x40 @ 310, parent: =
card0</span><br style=3D"color: rgb(32, 31, 30); font-family: &quot;Microso=
ft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, Bl=
inkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size=
: 15px; background-color: rgb(255, 255, 255)"><span style=3D"color: rgb(32,=
 31, 30); font-family: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &qu=
ot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helveti=
ca Neue&quot;, sans-serif; font-size: 15px; background-color: rgb(255, 255,=
 255); display: inline !important">input input7: input_dev_suspend&#43;0x0/=
0x40 returned 0 after 0 usecs</span><br style=3D"color: rgb(32, 31, 30); fo=
nt-family: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&=
quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot=
;, sans-serif; font-size: 15px; background-color: rgb(255, 255, 255)"><span=
 style=3D"color: rgb(32, 31, 30); font-family: &quot;Microsoft Yahei UI&quo=
t;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFon=
t, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 15px; backgro=
und-color: rgb(255, 255, 255); display: inline !important">input input6: ca=
lling input_dev_suspend&#43;0x0/0x40 @ 310, parent: card0</span></span></pr=
e>
<pre style=3D"font-size:13px; font-family:monospace"><span><span style=3D"c=
olor: rgb(32, 31, 30); font-family: &quot;Microsoft Yahei UI&quot;, Verdana=
, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, =
&quot;Helvetica Neue&quot;, sans-serif; font-size: 15px; background-color: =
rgb(255, 255, 255); display: inline !important">... ...</span></span></pre>
<pre style=3D"font-size:13px; font-family:monospace"><span><span style=3D"c=
olor: rgb(32, 31, 30); font-family: &quot;Microsoft Yahei UI&quot;, Verdana=
, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, =
&quot;Helvetica Neue&quot;, sans-serif; font-size: 15px; background-color: =
rgb(255, 255, 255); display: inline !important"><span style=3D"font-family:=
 &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -ap=
ple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-se=
rif; background-color: rgb(255, 255, 255); display: inline !important">inpu=
t input13: input_dev_resume&#43;0x0/0x40 returned 0 after 0 usecs</span><br=
 style=3D"font-family: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &qu=
ot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helveti=
ca Neue&quot;, sans-serif; background-color: rgb(255, 255, 255)"><span styl=
e=3D"font-family: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Se=
goe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Ne=
ue&quot;, sans-serif; background-color: rgb(255, 255, 255); display: inline=
 !important">input input14: calling input_dev_resume&#43;0x0/0x40 @ 310, pa=
rent: card0</span><br style=3D"font-family: &quot;Microsoft Yahei UI&quot;,=
 Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, =
Roboto, &quot;Helvetica Neue&quot;, sans-serif; background-color: rgb(255, =
255, 255)"><span style=3D"font-family: &quot;Microsoft Yahei UI&quot;, Verd=
ana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Robot=
o, &quot;Helvetica Neue&quot;, sans-serif; background-color: rgb(255, 255, =
255); display: inline !important">input input14: input_dev_resume&#43;0x0/0=
x40 returned 0 after 0 usecs</span><br style=3D"font-family: &quot;Microsof=
t Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, Bli=
nkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; background=
-color: rgb(255, 255, 255)"><span style=3D"font-family: &quot;Microsoft Yah=
ei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMac=
SystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; background-colo=
r: rgb(255, 255, 255); display: inline !important">atkbd serio0: Failed to =
deactivate keyboard on isa0060/serio0</span><br style=3D"font-family: &quot=
;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-sy=
stem, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; b=
ackground-color: rgb(255, 255, 255)"><span style=3D"font-family: &quot;Micr=
osoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system,=
 BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; backgr=
ound-color: rgb(255, 255, 255); display: inline !important">e1000e 0000:00:=
1f.6: pci_pm_resume&#43;0x0/0x90 returned 0 after 1003573 usecs</span><br s=
tyle=3D"font-family: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot=
;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica=
 Neue&quot;, sans-serif; background-color: rgb(255, 255, 255)"><span style=
=3D"font-family: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Seg=
oe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neu=
e&quot;, sans-serif; background-color: rgb(255, 255, 255); display: inline =
!important">atkbd serio0: Failed to enable keyboard on isa0060/serio0</span=
><br style=3D"font-family: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun,=
 &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Hel=
vetica Neue&quot;, sans-serif; background-color: rgb(255, 255, 255)"><span =
style=3D"font-family: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quo=
t;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetic=
a Neue&quot;, sans-serif; background-color: rgb(255, 255, 255); display: in=
line !important">acpi LNXPOWER:03: Turning OFF</span><br style=3D"font-fami=
ly: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, =
-apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans=
-serif; background-color: rgb(255, 255, 255)"><span style=3D"font-family: &=
quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -appl=
e-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-seri=
f; background-color: rgb(255, 255, 255); display: inline !important">OOM ki=
ller enabled.</span><br style=3D"font-family: &quot;Microsoft Yahei UI&quot=
;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont=
, Roboto, &quot;Helvetica Neue&quot;, sans-serif; background-color: rgb(255=
, 255, 255)"><span style=3D"font-family: &quot;Microsoft Yahei UI&quot;, Ve=
rdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Rob=
oto, &quot;Helvetica Neue&quot;, sans-serif; background-color: rgb(255, 255=
, 255); display: inline !important">Restarting tasks ...</span><br style=3D=
"font-family: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe =
UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&q=
uot;, sans-serif; background-color: rgb(255, 255, 255)"><span style=3D"font=
-family: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&qu=
ot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;,=
 sans-serif; background-color: rgb(255, 255, 255); display: inline !importa=
nt">systemd-journald[174]: /dev/kmsg buffer overrun, some messages lost.</s=
pan><br style=3D"font-family: &quot;Microsoft Yahei UI&quot;, Verdana, Sims=
un, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;=
Helvetica Neue&quot;, sans-serif; background-color: rgb(255, 255, 255)"><sp=
an style=3D"font-family: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &=
quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helve=
tica Neue&quot;, sans-serif; background-color: rgb(255, 255, 255); display:=
 inline !important">done.</span><br style=3D"font-family: &quot;Microsoft Y=
ahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkM=
acSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; background-co=
lor: rgb(255, 255, 255)"><span style=3D"font-family: &quot;Microsoft Yahei =
UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSys=
temFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; background-color: =
rgb(255, 255, 255); display: inline !important">PM: suspend exit</span><br =
style=3D"font-family: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quo=
t;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetic=
a Neue&quot;, sans-serif; background-color: rgb(255, 255, 255)"><span style=
=3D"font-family: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Seg=
oe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neu=
e&quot;, sans-serif; background-color: rgb(255, 255, 255); display: inline =
!important">e1000e 0000:00:1f.6 eth0: NIC Link is Up 100 Mbps Full Duplex, =
Flow Control: Rx/Tx</span><br style=3D"font-family: &quot;Microsoft Yahei U=
I&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSyst=
emFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; background-color: r=
gb(255, 255, 255)"><span style=3D"font-family: &quot;Microsoft Yahei UI&quo=
t;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFon=
t, Roboto, &quot;Helvetica Neue&quot;, sans-serif; background-color: rgb(25=
5, 255, 255); display: inline !important">e1000e 0000:00:1f.6 eth0: 10/100 =
speed: disabling TSO</span><br style=3D"font-family: &quot;Microsoft Yahei =
UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSys=
temFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; background-color: =
rgb(255, 255, 255)"><span style=3D"font-family: &quot;Microsoft Yahei UI&qu=
ot;, Verdana, Simsun, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFo=
nt, Roboto, &quot;Helvetica Neue&quot;, sans-serif; background-color: rgb(2=
55, 255, 255); display: inline !important">sh-5.0#</span><br style=3D"font-=
family: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quo=
t;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, =
sans-serif; background-color: rgb(255, 255, 255)"><span style=3D"font-famil=
y: &quot;Microsoft Yahei UI&quot;, Verdana, Simsun, &quot;Segoe UI&quot;, -=
apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-=
serif; background-color: rgb(255, 255, 255); display: inline !important">sh=
-5.0#</span><br></span></span></pre>
<pre style=3D"font-size:13px; font-family:monospace"><span><br></span></pre=
>
<pre style=3D"font-size:13px; font-family:monospace"><span><br></span></pre=
>
<pre style=3D"font-size:13px; font-family:monospace"><span>[EXTERNAL EMAIL]=
=0A=
&gt; =0A=
&gt; Hi Limonciello,=0A=
&gt; =0A=
&gt; On 7/21/20 10:44 PM, Limonciello, Mario wrote:=0A=
&gt; &gt;&gt; -----Original Message-----=0A=
&gt; &gt;&gt; From: iommu&lt;iommu-bounces@lists.linux-foundation.org&gt;  =
On Behalf Of Lu=0A=
&gt; &gt;&gt; Baolu=0A=
&gt; &gt;&gt; Sent: Monday, July 20, 2020 7:17 PM=0A=
&gt; &gt;&gt; To: Joerg Roedel=0A=
&gt; &gt;&gt; Cc: Ashok Raj;linux-kernel@vger.kernel.org;stable@vger.kernel=
.org; Koba=0A=
&gt; &gt;&gt; Ko;iommu@lists.linux-foundation.org=0A=
&gt; &gt;&gt; Subject: [PATCH 1/1] iommu/vt-d: Skip TE disabling on quirky =
gfx dedicated=0A=
&gt; &gt;&gt; iommu=0A=
&gt; &gt;&gt;=0A=
&gt; &gt;&gt; The VT-d spec requires (10.4.4 Global Command Register, TE fi=
eld) that:=0A=
&gt; &gt;&gt;=0A=
&gt; &gt;&gt; Hardware implementations supporting DMA draining must drain a=
ny in-flight=0A=
&gt; &gt;&gt; DMA read/write requests queued within the Root-Complex before=
 completing=0A=
&gt; &gt;&gt; the translation enable command and reflecting the status of t=
he command=0A=
&gt; &gt;&gt; through the TES field in the Global Status register.=0A=
&gt; &gt;&gt;=0A=
&gt; &gt;&gt; Unfortunately, some integrated graphic devices fail to do so =
after some=0A=
&gt; &gt;&gt; kind of power state transition. As the result, the system mig=
ht stuck in=0A=
&gt; &gt;&gt; iommu_disable_translation(), waiting for the completion of TE=
 transition.=0A=
&gt; &gt;&gt;=0A=
&gt; &gt;&gt; This provides a quirk list for those devices and skips TE dis=
abling if=0A=
&gt; &gt;&gt; the qurik hits.=0A=
&gt; &gt;&gt;=0A=
&gt; &gt;&gt; Fixes:<a href=3D"https://bugzilla.kernel.org/show_bug.cgi?id=
=3D208363">https://bugzilla.kernel.org/show_bug.cgi?id=3D208363</a>=0A=
&gt; &gt; That one is for TGL.=0A=
&gt; &gt;=0A=
&gt; &gt; I think you also want to add this one for ICL:=0A=
&gt; &gt; Fixes:<a href=3D"https://bugzilla.kernel.org/show_bug.cgi?id=3D20=
6571">https://bugzilla.kernel.org/show_bug.cgi?id=3D206571</a>=0A=
&gt; &gt;=0A=
&gt; =0A=
&gt; Do you mean someone have tested that this patch also fixes the problem=
=0A=
&gt; described in 206571?=0A=
&gt; =0A=
</span>=0A=
Yes, confusingly <a href=3D"https://bugzilla.kernel.org/show_bug.cgi?id=3D2=
08363#c31">https://bugzilla.kernel.org/show_bug.cgi?id=3D208363#c31</a> act=
ually=0A=
is the XPS 9300 ICL system and issue.=0A=
=0A=
I also have a private confirmation from another person that it resolves it =
for=0A=
them on another ICL platform.=0A=
=0A=
Christian, maybe you can add a tested by clause for the ICL testing.</pre>
<br>
</div>
</body>
</html>

--_000_DM6PR11MB2587034DFBEDFB091CE9AAD58E790DM6PR11MB2587namp_--

--===============3180327910994888855==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============3180327910994888855==--
