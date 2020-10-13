Return-Path: <SRS0=IGn4=DU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,HEADER_FROM_DIFFERENT_DOMAINS,HTML_FONT_FACE_BAD,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181F2C433E7
	for <iommu@archiver.kernel.org>; Tue, 13 Oct 2020 09:57:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F8D9205CA
	for <iommu@archiver.kernel.org>; Tue, 13 Oct 2020 09:57:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F8D9205CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B975B2E0F7;
	Tue, 13 Oct 2020 09:57:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rvzjE+oaT09O; Tue, 13 Oct 2020 09:57:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3E9D82E0F0;
	Tue, 13 Oct 2020 09:57:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 25F34C0052;
	Tue, 13 Oct 2020 09:57:15 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AA522C0051
 for <iommu@lists.linux-foundation.org>; Tue, 13 Oct 2020 09:57:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8FC7787A5C
 for <iommu@lists.linux-foundation.org>; Tue, 13 Oct 2020 09:57:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 53PaYX2Jqqqq for <iommu@lists.linux-foundation.org>;
 Tue, 13 Oct 2020 09:57:11 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from ZXSHCAS2.zhaoxin.com (ZXSHCAS2.zhaoxin.com [203.148.12.82])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6AEDF87A56
 for <iommu@lists.linux-foundation.org>; Tue, 13 Oct 2020 09:57:11 +0000 (UTC)
Received: from zxbjmbx3.zhaoxin.com (10.29.252.165) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 13 Oct
 2020 17:57:05 +0800
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by zxbjmbx3.zhaoxin.com
 (10.29.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 13 Oct
 2020 17:57:04 +0800
Received: from zxbjmbx1.zhaoxin.com ([fe80::290a:f538:51e7:1416]) by
 zxbjmbx1.zhaoxin.com ([fe80::290a:f538:51e7:1416%16]) with mapi id
 15.01.1979.003; Tue, 13 Oct 2020 17:57:04 +0800
From: FelixCui-oc <FelixCui-oc@zhaoxin.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "David
 Woodhouse" <dwmw2@infradead.org>, Dan Carpenter <dan.carpenter@oracle.com>,
 "kbuild@lists.01.org" <kbuild@lists.01.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIHYzIDAvMl0gQWRkIHN1cHBvcnQgZm9yIEFDUEkgZGV2?=
 =?gb2312?Q?ice_in_RMRR?=
Thread-Topic: [PATCH v3 0/2] Add support for ACPI device in RMRR
Thread-Index: AQHWntvCDm6U/FTRCU+FLr8500SBGamSu80AgAKNxAk=
Date: Tue, 13 Oct 2020 09:57:04 +0000
Message-ID: <d5ad1871ad26437181abc40c2b7badcc@zhaoxin.com>
References: <20201010080241.14642-1-FelixCui-oc@zhaoxin.com>,
 <06de2814-36c9-bea4-d0e1-0b6dddd1006e@linux.intel.com>
In-Reply-To: <06de2814-36c9-bea4-d0e1-0b6dddd1006e@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.29.8.40]
MIME-Version: 1.0
Cc: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
 CobeChen-oc <CobeChen-oc@zhaoxin.com>
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
Content-Type: multipart/mixed; boundary="===============6190076798007710617=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============6190076798007710617==
Content-Language: zh-CN
Content-Type: multipart/alternative;
	boundary="_000_d5ad1871ad26437181abc40c2b7badcczhaoxincom_"

--_000_d5ad1871ad26437181abc40c2b7badcczhaoxincom_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

aGkgYmFvbHUsDQoNCg0KPkJ5IHRoZSB3YXksIEkgZ3Vlc3MgdGhlIHByb2JsZW0geW91IGFyZSBm
YWNpbmcgY2FuIHN0aWxsIGJlIGhhbmRsZWQgd2VsbA0KPnVuZGVyIGN1cnJlbnQgUk1SUiBtZWNo
YW5pc20gYnkgc2ltcGxlIHB1dHRpbmcgdGhlIGRldmljZSBpbiB0aGUNCj5BQ1BJL0FOREQgdGFi
bGUuIEl0J3Mgd29ydGggdHJ5aW5nLg0KDQoNCkkgdW5kZXJzdGFuZCB3aGF0IHlvdSBtZWFuIGlz
IHRoYXQgIGp1c3QgcHV0IHRoZSBkZXZpY2UgaW4gdGhlIEFOREQgdGFibGUgYW5kIGRvbid0IHVz
ZSBSTVJSLCByaWdodD8NCg0KQnV0IHRoaXMgY2FuJ3Qgc29sdmUgbXkgcHJvYmxlbS4gQ2FuIHlv
dSBleHBsYWluIGl0IGluIGRldGFpbCBob3cgdG8gc29sdmUgbXkgcHJvYmxlbT8NCg0KDQpJbiBh
ZGRpdGlvbiwgdGhlIGxhdGVzdCBWVC1EIHNwZWMgc3RpbGwgaGFzIHN1cHBvcnQgZm9yIHRoZSB1
c2Ugb2YgYWNwaSBkZXZpY2UgdW5kZXIgUk1SUiBhbmQgQU5ERC4NCg0KRnJvbSB0aGUgcGVycGVj
dGl2ZSBvZiBzdXBwb3J0aW5nIHNwZWMgLCB0aGUgZHJpdmVyIHNob3VsZCBzdXBwb3J0IHRoZSBj
YXNlIHdlIHN1Ym1pdHRlZC4NCg0KDQpCZXN0IHJlZ2FyZHMNCg0KRmVsaXhjdWktb2MNCg0KDQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0Kt6K8/sjLOiBMdSBCYW9sdSA8YmFvbHUu
bHVAbGludXguaW50ZWwuY29tPg0Kt6LLzcqxvOQ6IDIwMjDE6jEw1MIxMsjVIDEwOjMxOjQwDQrK
1bz+yMs6IEZlbGl4Q3VpLW9jOyBKb2VyZyBSb2VkZWw7IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBEYXZpZCBXb29kaG91c2U7
IERhbiBDYXJwZW50ZXI7IGtidWlsZEBsaXN0cy4wMS5vcmcNCrOty806IGJhb2x1Lmx1QGxpbnV4
LmludGVsLmNvbTsgQ29iZUNoZW4tb2M7IFJheW1vbmRQYW5nLW9jOyBUb255IFcgV2FuZy1vYw0K
1vfM4jogUmU6IFtQQVRDSCB2MyAwLzJdIEFkZCBzdXBwb3J0IGZvciBBQ1BJIGRldmljZSBpbiBS
TVJSDQoNCkhpIEZlbGl4LA0KDQpPbiAxMC8xMC8yMCA0OjAyIFBNLCBGZWxpeEN1aW9jIHdyb3Rl
Og0KPiBCSU9TIGFsbG9jYXRlIHJlc2VydmVkIG1lbW9yeSByYW5nZXMgdGhhdCBtYXkgYmUgRE1B
IHRhcmdldHMuDQo+IEJJT1MgbWF5IHJlcG9ydCBlYWNoIHN1Y2ggcmVzZXJ2ZWQgbWVtb3J5IHJl
Z2lvbiB0aHJvdWdoIHRoZQ0KPiBSTVJSIHN0cnVjdHVyZXMsYWxvbmcgd2l0aCB0aGUgZGV2aWNl
cyB0aGF0IHJlcXVpcmVzIGFjY2VzcyB0bw0KPiB0aGUgc3BlY2lmaWVkIHJlc2VydmVkIG1lbW9y
eSByZWdpb24uDQo+DQo+IFRoZSBwdXJwb3NlIG9mIHRoaXMgc2VyaWVzIGlzIHRvIGFjaGlldmUg
QUNQSSBkZXZpY2UgaW4gUk1SUg0KPiBhY2Nlc3MgcmVzZXJ2ZWQgbWVtb3J5LlRoZXJlZm9yZSxp
dCBpcyBuZWNlc3NhcnkgdG8gaW5jcmVhc2UNCj4gdGhlIGFuYWx5c2lzIG9mIGFjcGkgZGV2aWNl
IGluIFJNUlIgYW5kIGVzdGFibGlzaCBhIG1hcHBpbmcNCj4gZm9yIHRoaXMgZGV2aWNlLg0KPg0K
PiBUaGUgZmlyc3QgcGF0Y2ggYWRkcyBpbnRlcmZhY2VzIGZvciBkZXRlY3RpbmcgQUNQSSBkZXZp
Y2UNCj4gaW4gUk1SUiBhbmQgaW4gb3JkZXIgdG8gZGlzdGluZ3Vpc2ggaXQgZnJvbSBwY2kgZGV2
aWNlLA0KPiBzb21lIGludGVyZmFjZSBmdW5jdGlvbnMgYXJlIG1vZGlmaWVkLg0KPg0KPiBUaGUg
c2Vjb25kIHBhdGNoIGFkZHMgc3VwcG9ydCBmb3IgcHJvYmluZyBBQ1BJIGRldmljZSBpbiBSTVJS
Lg0KPiBJbiBwcm9iZV9hY3BpX25hbWVzcGFjZV9kZXZpY2VzKCksYWRkIHN1cHBvcnQgZm9yIGRp
cmVjdCBtYXBwaW5nDQo+IG9mIEFDUEkgZGV2aWNlIGFuZCBhZGQgc3VwcG9ydCBmb3IgcGh5c2lj
YWwgbm9kZSBvZiBhY3BpIGRldmljZQ0KPiB0byBiZSBOVUxMLg0KDQpUaGFua3MgZm9yIHlvdXIg
cGF0Y2hlcy4gQXMgSSBleHBsYWluZWQgaW4gdGhlIHByZXZpb3VzIHJlcGx5LCBSTVJScw0Kd2Vy
ZSBhZGRlZCBhcyB3b3JrIGFyb3VuZCBmb3IgY2VydGFpbiBsZWdhY3kgZGV2aWNlIGFuZCB3ZSBo
YXZlIGJlZW4NCndvcmtpbmcgaGFyZCB0byBmaXggdGhvc2UgbGVnYWN5IGRldmljZXMgc28gdGhh
dCBSTVJSIGFyZSBubyBsb25nZXINCm5lZWRlZC4gQW55IG5ldyB1c2UgY2FzZSBvZiBSTVJSIGlz
IG5vdCBlbmNvdXJhZ2VkLg0KDQpCeSB0aGUgd2F5LCBJIGd1ZXNzIHRoZSBwcm9ibGVtIHlvdSBh
cmUgZmFjaW5nIGNhbiBzdGlsbCBiZSBoYW5kbGVkIHdlbGwNCnVuZGVyIGN1cnJlbnQgUk1SUiBt
ZWNoYW5pc20gYnkgc2ltcGxlIHB1dHRpbmcgdGhlIGRldmljZSBpbiB0aGUNCkFDUEkvQU5ERCB0
YWJsZS4gSXQncyB3b3J0aCB0cnlpbmcuDQoNCkJlc3QgcmVnYXJkcywNCmJhb2x1DQoNCj4NCj4g
djItPnYzOg0KPiAgICAgLSBBZGQgdGhlIGJsYW5rIGxpbmUgYmV0d2VlbiBmdW5jdGlvbnMuDQo+
ICAgICAtIE1ha2UgZG1hcl9hY3BpX2luc2VydF9kZXZfc2NvcGUoKSBib29sLGNoYW5nZSB0aGUg
MS8wIHRvIHRydWUvZmFsc2UNCj4gICAgICAgYW5kIGFkZCBhIGNvbW1lbnQgZXhwbGFpbmluZy4N
Cj4gICAgIC0gRGVsZXRlIHVudXNlZCBpbml0aWFsaXphdGlvbi4NCj4gICAgIC0gaWYgZG1hcl9h
Y3BpX2luc2VydF9kZXZfc2NvcGUoKSBhbHdheXMgcmV0dXJucyB6ZXJvLHdpbGwgbm90DQo+ICAg
ICAgIGNhbGwgZG1hcl9ybXJyX2FkZF9hY3BpX2RldigpLg0KPiAgICAgLSBVc2UgYSBwcm9wZXIg
ZXJyb3IgY29kZS4NCj4gICAgIC0gVXNlIGlmKCFwZGV2KS4NCj4gICAgIC0gVXNlIGdvdG8gdW5s
b2NrIGluc3RlYWQgb2YgbXV0ZXhfdW5sb2NrKCkuDQo+DQo+DQo+IEZlbGl4Q3Vpb2MgKDIpOg0K
PiAgICBpb21tdS92dC1kOkFkZCBzdXBwb3J0IGZvciBkZXRlY3RpbmcgQUNQSSBkZXZpY2UgaW4g
Uk1SUg0KPiAgICBpb21tdS92dC1kOkFkZCBzdXBwb3J0IGZvciBwcm9iaW5nIEFDUEkgZGV2aWNl
IGluIFJNUlINCj4NCj4gICBkcml2ZXJzL2lvbW11L2ludGVsL2RtYXIuYyAgfCA3NiArKysrKysr
KysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tDQo+ICAgZHJpdmVycy9pb21tdS9pbnRlbC9p
b21tdS5jIHwgNTIgKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiAgIGRyaXZlcnMvaW9tbXUv
aW9tbXUuYyAgICAgICB8ICA2ICsrKw0KPiAgIGluY2x1ZGUvbGludXgvZG1hci5oICAgICAgICB8
IDEyICsrKysrLQ0KPiAgIGluY2x1ZGUvbGludXgvaW9tbXUuaCAgICAgICB8ICAyICsNCj4gICA1
IGZpbGVzIGNoYW5nZWQsIDExMyBpbnNlcnRpb25zKCspLCAzNSBkZWxldGlvbnMoLSkNCj4NCg==

--_000_d5ad1871ad26437181abc40c2b7badcczhaoxincom_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<meta content=3D"text/html; charset=3DUTF-8">
<style type=3D"text/css" style=3D"">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; col=
or:#000000; font-family:Calibri,Helvetica,sans-serif">
<p>hi baolu,</p>
<p><br>
</p>
<p><span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI=
&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">&gt;By the way, I g=
uess the problem you are facing can still be handled well</span><br style=
=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&quot;,&quot;M=
icrosoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-seri=
f,serif,EmojiFont; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">&gt;under current RMRR=
 mechanism by simple putting the device in the</span><br style=3D"color:rgb=
(33,33,33); font-family:&quot;Microsoft YaHei UI&quot;,&quot;Microsoft YaHe=
i&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-serif,serif,Emoji=
Font; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">&gt;ACPI/ANDD table. I=
t's worth trying.</span><br>
</p>
<p><span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI=
&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px"><br>
</span></p>
<p><span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI=
&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">I understand what y=
ou mean is that &nbsp;just put the device in the ANDD table and don't use R=
MRR, right?</span></p>
<p><span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI=
&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">But this can't solv=
e my problem. Can you explain it in detail how to solve my problem?</span><=
/p>
<p><span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI=
&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px"><br>
</span></p>
<p><font color=3D"#212121" face=3D"Microsoft YaHei UI, Microsoft YaHei, =CE=
=A2=C8=ED=D1=C5=BA=DA, SimSun, =CB=CE=CC=E5, sans-serif, serif, EmojiFont">=
<span style=3D"font-size:13.3333px">In addition, the latest VT-D spec still=
 has support for the use of acpi device under RMRR and ANDD.&nbsp;</span></=
font></p>
<p><font color=3D"#212121" face=3D"Microsoft YaHei UI, Microsoft YaHei, =CE=
=A2=C8=ED=D1=C5=BA=DA, SimSun, =CB=CE=CC=E5, sans-serif, serif, EmojiFont">=
<span style=3D"font-size:13.3333px">From the perpective of supporting spec =
, the driver should support the case we submitted.&nbsp;</span></font></p>
<p><font color=3D"#212121" face=3D"Microsoft YaHei UI, Microsoft YaHei, =CE=
=A2=C8=ED=D1=C5=BA=DA, SimSun, =CB=CE=CC=E5, sans-serif, serif, EmojiFont">=
<span style=3D"font-size:13.3333px"><br>
</span></font></p>
<p><font color=3D"#212121" face=3D"Microsoft YaHei UI, Microsoft YaHei, =CE=
=A2=C8=ED=D1=C5=BA=DA, SimSun, =CB=CE=CC=E5, sans-serif, serif, EmojiFont">=
<span style=3D"font-size:13.3333px">Best regards</span></font></p>
<p><font color=3D"#212121" face=3D"Microsoft YaHei UI, Microsoft YaHei, =CE=
=A2=C8=ED=D1=C5=BA=DA, SimSun, =CB=CE=CC=E5, sans-serif, serif, EmojiFont">=
<span style=3D"font-size:13.3333px">Felixcui-oc</span></font></p>
<p><span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI=
&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px"><br>
</span></p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>=B7=A2=BC=FE=C8=CB:</b> Lu Ba=
olu &lt;baolu.lu@linux.intel.com&gt;<br>
<b>=B7=A2=CB=CD=CA=B1=BC=E4:</b> 2020=C4=EA10=D4=C212=C8=D5 10:31:40<br>
<b>=CA=D5=BC=FE=C8=CB:</b> FelixCui-oc; Joerg Roedel; iommu@lists.linux-fou=
ndation.org; linux-kernel@vger.kernel.org; David Woodhouse; Dan Carpenter; =
kbuild@lists.01.org<br>
<b>=B3=AD=CB=CD:</b> baolu.lu@linux.intel.com; CobeChen-oc; RaymondPang-oc;=
 Tony W Wang-oc<br>
<b>=D6=F7=CC=E2:</b> Re: [PATCH v3 0/2] Add support for ACPI device in RMRR=
</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">Hi Felix,<br>
<br>
On 10/10/20 4:02 PM, FelixCuioc wrote:<br>
&gt; BIOS allocate reserved memory ranges that may be DMA targets.<br>
&gt; BIOS may report each such reserved memory region through the<br>
&gt; RMRR structures,along with the devices that requires access to<br>
&gt; the specified reserved memory region.<br>
&gt; <br>
&gt; The purpose of this series is to achieve ACPI device in RMRR<br>
&gt; access reserved memory.Therefore,it is necessary to increase<br>
&gt; the analysis of acpi device in RMRR and establish a mapping<br>
&gt; for this device.<br>
&gt; <br>
&gt; The first patch adds interfaces for detecting ACPI device<br>
&gt; in RMRR and in order to distinguish it from pci device,<br>
&gt; some interface functions are modified.<br>
&gt; <br>
&gt; The second patch adds support for probing ACPI device in RMRR.<br>
&gt; In probe_acpi_namespace_devices(),add support for direct mapping<br>
&gt; of ACPI device and add support for physical node of acpi device<br>
&gt; to be NULL.<br>
<br>
Thanks for your patches. As I explained in the previous reply, RMRRs<br>
were added as work around for certain legacy device and we have been<br>
working hard to fix those legacy devices so that RMRR are no longer<br>
needed. Any new use case of RMRR is not encouraged.<br>
<br>
By the way, I guess the problem you are facing can still be handled well<br=
>
under current RMRR mechanism by simple putting the device in the<br>
ACPI/ANDD table. It's worth trying.<br>
<br>
Best regards,<br>
baolu<br>
<br>
&gt; <br>
&gt; v2-&gt;v3:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; - Add the blank line between functions.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; - Make dmar_acpi_insert_dev_scope() bool,chang=
e the 1/0 to true/false<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; and add a comment explaining.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; - Delete unused initialization.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; - if dmar_acpi_insert_dev_scope() always retur=
ns zero,will not<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; call dmar_rmrr_add_acpi_dev().<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; - Use a proper error code.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; - Use if(!pdev).<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; - Use goto unlock instead of mutex_unlock().<b=
r>
&gt; <br>
&gt; <br>
&gt; FelixCuioc (2):<br>
&gt;&nbsp;&nbsp;&nbsp; iommu/vt-d:Add support for detecting ACPI device in =
RMRR<br>
&gt;&nbsp;&nbsp;&nbsp; iommu/vt-d:Add support for probing ACPI device in RM=
RR<br>
&gt; <br>
&gt;&nbsp;&nbsp; drivers/iommu/intel/dmar.c&nbsp; | 76 &#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;----------------<br>
&gt;&nbsp;&nbsp; drivers/iommu/intel/iommu.c | 52 &#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;-<br>
&gt;&nbsp;&nbsp; drivers/iommu/iommu.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
|&nbsp; 6 &#43;&#43;&#43;<br>
&gt;&nbsp;&nbsp; include/linux/dmar.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; | 12 &#43;&#43;&#43;&#43;&#43;-<br>
&gt;&nbsp;&nbsp; include/linux/iommu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
|&nbsp; 2 &#43;<br>
&gt;&nbsp;&nbsp; 5 files changed, 113 insertions(&#43;), 35 deletions(-)<br=
>
&gt; <br>
</div>
</span></font>
</body>
</html>

--_000_d5ad1871ad26437181abc40c2b7badcczhaoxincom_--

--===============6190076798007710617==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6190076798007710617==--
