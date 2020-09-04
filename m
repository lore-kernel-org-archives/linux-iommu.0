Return-Path: <SRS0=mVMG=CN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F4FC433E2
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 05:42:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80D33206C9
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 05:42:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80D33206C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 607EC86BDC;
	Fri,  4 Sep 2020 05:42:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ywJKgYPA9W1Z; Fri,  4 Sep 2020 05:42:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D95AA86BA1;
	Fri,  4 Sep 2020 05:42:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9C5AC07FF;
	Fri,  4 Sep 2020 05:42:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3D0CC0051
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 05:42:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9C17586C48
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 05:42:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wKS9vAG1t4kw for <iommu@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 05:42:28 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from ZXSHCAS2.zhaoxin.com (unknown [203.148.12.82])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id DB8F086C47
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 05:42:27 +0000 (UTC)
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 4 Sep 2020
 13:42:13 +0800
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 4 Sep 2020
 13:42:12 +0800
Received: from zxbjmbx1.zhaoxin.com ([fe80::290a:f538:51e7:1416]) by
 zxbjmbx1.zhaoxin.com ([fe80::290a:f538:51e7:1416%16]) with mapi id
 15.01.1979.003; Fri, 4 Sep 2020 13:42:12 +0800
From: FelixCui-oc <FelixCui-oc@zhaoxin.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "David
 Woodhouse" <dwmw2@infradead.org>, Dan Carpenter <dan.carpenter@oracle.com>,
 "kbuild@lists.01.org" <kbuild@lists.01.org>
Subject: =?gb2312?B?tPC4tDogtPC4tDogtPC4tDogW1BBVENIIHYzIDIvMl0gaW9tbXUvdnQtZDpB?=
 =?gb2312?Q?dd_support_for_probing_ACPI_device_in_RMRR?=
Thread-Topic: =?gb2312?B?tPC4tDogtPC4tDogW1BBVENIIHYzIDIvMl0gaW9tbXUvdnQtZDpBZGQgc3Vw?=
 =?gb2312?Q?port_for_probing_ACPI_device_in_RMRR?=
Thread-Index: AQHWfFkssCqC/uq8zUSrxxRHHTL9PKlSzvUAgAC26n+AAJ31AIAAkzS7gAFQDQCAAfosxQ==
Date: Fri, 4 Sep 2020 05:42:12 +0000
Message-ID: <ef34767ffd25491b94ed12f706047e4d@zhaoxin.com>
References: <20200827100217.21324-1-FelixCui-oc@zhaoxin.com>
 <20200827100217.21324-3-FelixCui-oc@zhaoxin.com>
 <e5b1daaf-f073-94c9-714c-832b10d284f4@linux.intel.com>
 <cde22f0f02f94efcae8bf044e2cd9441@zhaoxin.com>
 <7e5f2c33-c6c3-f344-9014-1f6a306c55aa@linux.intel.com>
 <cfdd29a882d140e5aec2e8c3b77f4968@zhaoxin.com>,
 <56fc76e5-a31c-36b6-c6f0-fd8370cd7a91@linux.intel.com>
In-Reply-To: <56fc76e5-a31c-36b6-c6f0-fd8370cd7a91@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.29.8.19]
MIME-Version: 1.0
Cc: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
 CobeChen-oc <CobeChen-oc@zhaoxin.com>, Ashok Raj <ashok.raj@intel.com>
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
Content-Type: multipart/mixed; boundary="===============6472877978139680436=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============6472877978139680436==
Content-Language: zh-CN
Content-Type: multipart/alternative;
	boundary="_000_ef34767ffd25491b94ed12f706047e4dzhaoxincom_"

--_000_ef34767ffd25491b94ed12f706047e4dzhaoxincom_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

aGkgYmFvbHUsDQoNCiAgICAgICAgICAgICAgIFdlIHJ1biB0aGlzIG9uIHpoYW94aW4gWDg2IHBh
bHRmb3JtLg0KDQogICAgICAgICAgICAgICBUaGVyZSBhcmUgc29tZSBNQ1VTIG9uIG91ciBwbGF0
Zm9ybXMgdGhhdCByZWFkIGFuZCB3cml0ZSBkYXRhIHRvIHRoZSBzeXN0ZW0gbWVtb3J5Lg0KDQpE
dXJpbmcgdGhpcyBwcm9jZXNzLCB0aGUgTUNVIGlzIGludmlzaWJsZSB0byB0aGUgaG9zdCBrZXJu
ZWwuIEFuZCB0aGUgTUNVIG5lZWRzIHRvIHJlcG9ydCB0aHJvdWdoIEFDUElfTkFNRVNQQUNFX0RF
VklDRSBpbiBSTVJSLg0KDQoNCkJlc3QgcmVnYXJkcw0KDQpGZWxpeGN1aS1vYw0KDQpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXw0Kt6K8/sjLOiBMdSBCYW9sdSA8YmFvbHUubHVAbGlu
dXguaW50ZWwuY29tPg0Kt6LLzcqxvOQ6IDIwMjDE6jnUwjPI1SAxNToyMjoxNA0KytW8/sjLOiBG
ZWxpeEN1aS1vYzsgSm9lcmcgUm9lZGVsOyBpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgRGF2aWQgV29vZGhvdXNlOyBEYW4gQ2Fy
cGVudGVyOyBrYnVpbGRAbGlzdHMuMDEub3JnDQqzrcvNOiBiYW9sdS5sdUBsaW51eC5pbnRlbC5j
b207IENvYmVDaGVuLW9jOyBSYXltb25kUGFuZy1vYzsgVG9ueSBXIFdhbmctb2M7IEFzaG9rIFJh
ag0K1vfM4jogUmU6ILTwuLQ6ILTwuLQ6IFtQQVRDSCB2MyAyLzJdIGlvbW11L3Z0LWQ6QWRkIHN1
cHBvcnQgZm9yIHByb2JpbmcgQUNQSSBkZXZpY2UgaW4gUk1SUg0KDQpIaSBGZWxpeCwNCg0KT24g
OS8yLzIwIDExOjI0IEFNLCBGZWxpeEN1aS1vYyB3cm90ZToNCj4gaGkgYmFvbHUsDQo+DQo+PiBT
byB5b3UgaGF2ZSBhIGhpZGRlbiBkZXZpY2UgKGludmlzaWJsZSB0byBob3N0IGtlcm5lbCkuIEJ1
dCB5b3UgbmVlZCB0bw0KPg0KPj5zZXR1cCBzb21lIGlkZW50aXR5IG1hcHBpbmdzIGZvciB0aGlz
IGRldmljZSwgc28gdGhhdCB0aGUgZmlybXdhcmUNCj4+Y291bGQga2VlcCB3b3JraW5nLCByaWdo
dD8NCj4NCj4+VGhlIHBsYXRmb3JtIGRlc2lnbnMgdGhpcyBieSBwdXR0aW5nIHRoYXQgcmFuZ2Ug
aW4gdGhlIFJNUlIgdGFibGUgYW5kDQo+PmV4cGVjdGluZyB0aGUgT1Mga2VybmVsIHRvIHNldHVw
IGlkZW50aXR5IG1hcHBpbmdzIGR1cmluZyBib290Lg0KPg0KPj5EbyBJIHVuZGVyc3RhbmQgaXQg
cmlnaHQ/DQo+DQo+DQo+IFllcy4gV2hhdCB5b3UgdW5kZXJzdGFuZCBpcyBjb3JyZWN0Lg0KDQpU
aGlzIGFwcGVhcnMgdG8gYmUgYSBuZXcgdXNhZ2UgbW9kZWwgb2YgUk1SUi4gSSBuZWVkIHRvIGRp
c2N1c3MgdGhpcw0Kd2l0aCB0aGUgVlQtZCBzcGVjIG1haW50YWluZXIuIERvIHlvdSBtaW5kIHRl
bGxpbmcgd2hpY2ggcGxhdGZvcm0gYXJlDQp5b3UgZ29pbmcgdG8gcnVuIHRoaXMgb24/IFdoYXQg
aXMgdGhlIG1vdGl2YXRpb24gb2YgY3JlYXRpbmcgc3VjaCBoaWRkZW4NCmRldmljZT8NCg0KQmFz
aWNhbGx5LCBSTVJScyB3ZXJlIGFkZGVkIGFzIHdvcmsgYXJvdW5kIGZvciBjZXJ0YWluIGxlZ2Fj
eSBkZXZpY2UgYW5kDQp3ZSBoYXZlIGJlZW4gd29ya2luZyBoYXJkIHRvIGZpeCB0aG9zZSBsZWdh
Y3kgZGV2aWNlcyBzbyB0aGF0IFJNUlIgYXJlDQpubyBsb25nZXIgbmVlZGVkLg0KDQpCZXN0IHJl
Z2FyZHMsDQpiYW9sdQ0K

--_000_ef34767ffd25491b94ed12f706047e4dzhaoxincom_
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
<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;We run this on zh=
aoxin X86 paltform.</p>
<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;There are some MC=
US on our platforms that read and write data to the system memory.</p>
<p>During this process, the MCU is invisible to the host kernel. And the MC=
U needs to report through ACPI_NAMESPACE_DEVICE&nbsp;in RMRR.</p>
<p><br>
</p>
<p>Best regards</p>
<p>Felixcui-oc</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>=B7=A2=BC=FE=C8=CB:</b> Lu Ba=
olu &lt;baolu.lu@linux.intel.com&gt;<br>
<b>=B7=A2=CB=CD=CA=B1=BC=E4:</b> 2020=C4=EA9=D4=C23=C8=D5 15:22:14<br>
<b>=CA=D5=BC=FE=C8=CB:</b> FelixCui-oc; Joerg Roedel; iommu@lists.linux-fou=
ndation.org; linux-kernel@vger.kernel.org; David Woodhouse; Dan Carpenter; =
kbuild@lists.01.org<br>
<b>=B3=AD=CB=CD:</b> baolu.lu@linux.intel.com; CobeChen-oc; RaymondPang-oc;=
 Tony W Wang-oc; Ashok Raj<br>
<b>=D6=F7=CC=E2:</b> Re: =B4=F0=B8=B4: =B4=F0=B8=B4: [PATCH v3 2/2] iommu/v=
t-d:Add support for probing ACPI device in RMRR</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">Hi Felix,<br>
<br>
On 9/2/20 11:24 AM, FelixCui-oc wrote:<br>
&gt; hi baolu,<br>
&gt; <br>
&gt;&gt; So you have a hidden device (invisible to host kernel). But you ne=
ed to<br>
&gt; <br>
&gt;&gt;setup some identity mappings for this device, so that the firmware<=
br>
&gt;&gt;could keep working, right?<br>
&gt; <br>
&gt;&gt;The platform designs this by putting that range in the RMRR table a=
nd<br>
&gt;&gt;expecting the OS kernel to setup identity mappings during boot.<br>
&gt; <br>
&gt;&gt;Do I understand it right?<br>
&gt; <br>
&gt; <br>
&gt; Yes. What you understand is correct.<br>
<br>
This appears to be a new usage model of RMRR. I need to discuss this<br>
with the VT-d spec maintainer. Do you mind telling which platform are<br>
you going to run this on? What is the motivation of creating such hidden<br=
>
device?<br>
<br>
Basically, RMRRs were added as work around for certain legacy device and<br=
>
we have been working hard to fix those legacy devices so that RMRR are<br>
no longer needed.<br>
<br>
Best regards,<br>
baolu<br>
</div>
</span></font>
</body>
</html>

--_000_ef34767ffd25491b94ed12f706047e4dzhaoxincom_--

--===============6472877978139680436==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6472877978139680436==--
