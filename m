Return-Path: <SRS0=ylBP=CQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B9AC433E2
	for <iommu@archiver.kernel.org>; Mon,  7 Sep 2020 03:45:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3CE620DD4
	for <iommu@archiver.kernel.org>; Mon,  7 Sep 2020 03:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="huJ7jIRI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3CE620DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 40C1F85551;
	Mon,  7 Sep 2020 03:45:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id upcEnV-q86yI; Mon,  7 Sep 2020 03:44:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D209285549;
	Mon,  7 Sep 2020 03:44:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6A1BC0052;
	Mon,  7 Sep 2020 03:44:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7AB5AC0051
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 03:44:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7682787044
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 03:44:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1s6ES3cQM8gU for <iommu@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 03:44:54 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [1.203.163.81])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2CF128703E
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 03:44:53 +0000 (UTC)
X-UUID: 67c0202fedb24456a1d94215fa618fd8-20200907
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=XRXXhcqlaKoeazFQWuyePFSc48YGvh1/wa2ngzE02tU=; 
 b=huJ7jIRI6qmqRuP+xsPeSYd7nd8iUBBFB2QG0jZ2hvRP2SmbN49sjDunVAaJuIzvW2qWBzEEfRiZHValM2bnpID3cg3aA5Of9aXXlDMd8/YrJfUKuF9oafiOB/9APhmnFlm9ScubhGAiclNdB1Zt1y1Ypu3x6WTlaPErE6Zynm0=;
X-UUID: 67c0202fedb24456a1d94215fa618fd8-20200907
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1140295167; Mon, 07 Sep 2020 11:44:46 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32DR.mediatek.inc
 (172.27.6.104) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Mon, 7 Sep 2020 11:44:41 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 7 Sep 2020 11:44:41 +0800
Message-ID: <1599450173.27773.11.camel@mhfsdcap03>
Subject: Re: [PATCH v3 2/3] iommu/mediatek: add flag for legacy ivrp paddr
From: Yong Wu <yong.wu@mediatek.com>
To: Fabien Parent <fparent@baylibre.com>
Date: Mon, 7 Sep 2020 11:42:53 +0800
In-Reply-To: <20200906151928.881209-2-fparent@baylibre.com>
References: <20200906151928.881209-1-fparent@baylibre.com>
 <20200906151928.881209-2-fparent@baylibre.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: ED62E0F9AF5FDE16DC7F93C00E5F1057CD16472A2F7C047359A21B5AAD6B73422000:8
X-MTK: N
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org,
 linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
 linux-arm-kernel@lists.infradead.org
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
Content-Type: multipart/mixed; boundary="===============2925078892297556930=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============2925078892297556930==
Content-Type: multipart/alternative; boundary="=-WtlvSa/6C0faa7vYEyei"

--=-WtlvSa/6C0faa7vYEyei
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gU3VuLCAyMDIwLTA5LTA2IGF0IDE3OjE5ICswMjAwLCBGYWJpZW4gUGFyZW50IHdyb3RlOg0K
DQo+IEFkZCBhIG5ldyBmbGFnIGluIG9yZGVyIHRvIHNlbGVjdCB3aGljaCBJVlJQX1BBRERSIGZv
cm1hdCBpcyB1c2VkDQo+IGJ5IGFuIFNvQy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEZhYmllbiBQ
YXJlbnQgPGZwYXJlbnRAYmF5bGlicmUuY29tPg0KDQoNClJldmlld2VkLWJ5OiBZb25nIFd1IDx5
b25nLnd1QG1lZGlhdGVrLmNvbT4NCg0KDQo+IC0tLQ0KPiANCj4gdjM6IHNldCBMRUdBQ1lfSVZS
UF9QQUREUiBhcyBhIGZsYWcgaW5zdGVhZCBvZiBwbGF0Zm9ybSBkYXRhDQo+IHYyOiBuZXcgcGF0
Y2gNCj4gDQo+IC0tLQ0KPiAgZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyB8IDYgKysrKy0tDQo+
ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L210
a19pb21tdS5jDQo+IGluZGV4IDc4NWIyMjhkMzlhNi4uYjFmODVhN2U5MzQ2IDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQo+ICsrKyBiL2RyaXZlcnMvaW9tbXUvbXRr
X2lvbW11LmMNCj4gQEAgLTExNiw2ICsxMTYsNyBAQA0KPiAgI2RlZmluZSBPVVRfT1JERVJfV1Jf
RU4JCQlCSVQoNCkNCj4gICNkZWZpbmUgSEFTX1NVQl9DT01NCQkJQklUKDUpDQo+ICAjZGVmaW5l
IFdSX1RIUk9UX0VOCQkJQklUKDYpDQo+ICsjZGVmaW5lIEhBU19MRUdBQ1lfSVZSUF9QQUREUgkJ
QklUKDcpDQo+ICANCj4gICNkZWZpbmUgTVRLX0lPTU1VX0hBU19GTEFHKHBkYXRhLCBfeCkgXA0K
PiAgCQkoKCgocGRhdGEpLT5mbGFncykgJiAoX3gpKSA9PSAoX3gpKQ0KPiBAQCAtNTgyLDcgKzU4
Myw3IEBAIHN0YXRpYyBpbnQgbXRrX2lvbW11X2h3X2luaXQoY29uc3Qgc3RydWN0IG10a19pb21t
dV9kYXRhICpkYXRhKQ0KPiAgCQlGX0lOVF9QUkVURVRDSF9UUkFOU0FUSU9OX0ZJRk9fRkFVTFQ7
DQo+ICAJd3JpdGVsX3JlbGF4ZWQocmVndmFsLCBkYXRhLT5iYXNlICsgUkVHX01NVV9JTlRfTUFJ
Tl9DT05UUk9MKTsNCj4gIA0KPiAtCWlmIChkYXRhLT5wbGF0X2RhdGEtPm00dV9wbGF0ID09IE00
VV9NVDgxNzMpDQo+ICsJaWYgKE1US19JT01NVV9IQVNfRkxBRyhkYXRhLT5wbGF0X2RhdGEsIEhB
U19MRUdBQ1lfSVZSUF9QQUREUikpDQo+ICAJCXJlZ3ZhbCA9IChkYXRhLT5wcm90ZWN0X2Jhc2Ug
Pj4gMSkgfCAoZGF0YS0+ZW5hYmxlXzRHQiA8PCAzMSk7DQo+ICAJZWxzZQ0KPiAgCQlyZWd2YWwg
PSBsb3dlcl8zMl9iaXRzKGRhdGEtPnByb3RlY3RfYmFzZSkgfA0KPiBAQCAtODE4LDcgKzgxOSw4
IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0YSBtdDY3NzlfZGF0YSA9
IHsNCj4gIA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfaW9tbXVfcGxhdF9kYXRhIG10ODE3
M19kYXRhID0gew0KPiAgCS5tNHVfcGxhdCAgICAgPSBNNFVfTVQ4MTczLA0KPiAtCS5mbGFncwkg
ICAgICA9IEhBU180R0JfTU9ERSB8IEhBU19CQ0xLIHwgUkVTRVRfQVhJLA0KPiArCS5mbGFncwkg
ICAgICA9IEhBU180R0JfTU9ERSB8IEhBU19CQ0xLIHwgUkVTRVRfQVhJIHwNCj4gKwkJCUhBU19M
RUdBQ1lfSVZSUF9QQUREUiwNCj4gIAkuaW52X3NlbF9yZWcgID0gUkVHX01NVV9JTlZfU0VMX0dF
TjEsDQo+ICAJLmxhcmJpZF9yZW1hcCA9IHt7MH0sIHsxfSwgezJ9LCB7M30sIHs0fSwgezV9fSwg
LyogTGluZWFyIG1hcHBpbmcuICovDQo+ICB9Ow0KDQoNCg==

--=-WtlvSa/6C0faa7vYEyei
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PCFET0NUWVBFIEhUTUwgUFVCTElDICItLy9XM0MvL0RURCBIVE1MIDQuMCBUUkFOU0lUSU9OQUwv
L0VOIj4NCjxIVE1MPg0KPEhFQUQ+DQogIDxNRVRBIEhUVFAtRVFVSVY9IkNvbnRlbnQtVHlwZSIg
Q09OVEVOVD0idGV4dC9odG1sOyBDSEFSU0VUPVVURi04Ij4NCiAgPE1FVEEgTkFNRT0iR0VORVJB
VE9SIiBDT05URU5UPSJHdGtIVE1MLzQuNi42Ij4NCjwvSEVBRD4NCjxCT0RZPg0KT24gU3VuLCAy
MDIwLTA5LTA2IGF0IDE3OjE5ICswMjAwLCBGYWJpZW4gUGFyZW50IHdyb3RlOg0KPEJMT0NLUVVP
VEUgVFlQRT1DSVRFPg0KPFBSRT4NCkFkZCBhIG5ldyBmbGFnIGluIG9yZGVyIHRvIHNlbGVjdCB3
aGljaCBJVlJQX1BBRERSIGZvcm1hdCBpcyB1c2VkDQpieSBhbiBTb0MuDQoNClNpZ25lZC1vZmYt
Ynk6IEZhYmllbiBQYXJlbnQgJmx0OzxBIEhSRUY9Im1haWx0bzpmcGFyZW50QGJheWxpYnJlLmNv
bSI+ZnBhcmVudEBiYXlsaWJyZS5jb208L0E+Jmd0Ow0KPC9QUkU+DQo8L0JMT0NLUVVPVEU+DQo8
QlI+DQpSZXZpZXdlZC1ieTogWW9uZyBXdSAmbHQ7PEEgSFJFRj0ibWFpbHRvOnlvbmcud3VAbWVk
aWF0ZWsuY29tIj55b25nLnd1QG1lZGlhdGVrLmNvbTwvQT4mZ3Q7PEJSPg0KPEJSPg0KPEJMT0NL
UVVPVEUgVFlQRT1DSVRFPg0KPFBSRT4NCi0tLQ0KDQp2Mzogc2V0IExFR0FDWV9JVlJQX1BBRERS
IGFzIGEgZmxhZyBpbnN0ZWFkIG9mIHBsYXRmb3JtIGRhdGENCnYyOiBuZXcgcGF0Y2gNCg0KLS0t
DQogZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyB8IDYgKysrKy0tDQogMSBmaWxlIGNoYW5nZWQs
IDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
aW9tbXUvbXRrX2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQppbmRleCA3ODVi
MjI4ZDM5YTYuLmIxZjg1YTdlOTM0NiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lv
bW11LmMNCisrKyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCkBAIC0xMTYsNiArMTE2LDcg
QEANCiAjZGVmaW5lIE9VVF9PUkRFUl9XUl9FTgkJCUJJVCg0KQ0KICNkZWZpbmUgSEFTX1NVQl9D
T01NCQkJQklUKDUpDQogI2RlZmluZSBXUl9USFJPVF9FTgkJCUJJVCg2KQ0KKyNkZWZpbmUgSEFT
X0xFR0FDWV9JVlJQX1BBRERSCQlCSVQoNykNCiANCiAjZGVmaW5lIE1US19JT01NVV9IQVNfRkxB
RyhwZGF0YSwgX3gpIFwNCiAJCSgoKChwZGF0YSktJmd0O2ZsYWdzKSAmYW1wOyAoX3gpKSA9PSAo
X3gpKQ0KQEAgLTU4Miw3ICs1ODMsNyBAQCBzdGF0aWMgaW50IG10a19pb21tdV9od19pbml0KGNv
bnN0IHN0cnVjdCBtdGtfaW9tbXVfZGF0YSAqZGF0YSkNCiAJCUZfSU5UX1BSRVRFVENIX1RSQU5T
QVRJT05fRklGT19GQVVMVDsNCiAJd3JpdGVsX3JlbGF4ZWQocmVndmFsLCBkYXRhLSZndDtiYXNl
ICsgUkVHX01NVV9JTlRfTUFJTl9DT05UUk9MKTsNCiANCi0JaWYgKGRhdGEtJmd0O3BsYXRfZGF0
YS0mZ3Q7bTR1X3BsYXQgPT0gTTRVX01UODE3MykNCisJaWYgKE1US19JT01NVV9IQVNfRkxBRyhk
YXRhLSZndDtwbGF0X2RhdGEsIEhBU19MRUdBQ1lfSVZSUF9QQUREUikpDQogCQlyZWd2YWwgPSAo
ZGF0YS0mZ3Q7cHJvdGVjdF9iYXNlICZndDsmZ3Q7IDEpIHwgKGRhdGEtJmd0O2VuYWJsZV80R0Ig
Jmx0OyZsdDsgMzEpOw0KIAllbHNlDQogCQlyZWd2YWwgPSBsb3dlcl8zMl9iaXRzKGRhdGEtJmd0
O3Byb3RlY3RfYmFzZSkgfA0KQEAgLTgxOCw3ICs4MTksOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0
IG10a19pb21tdV9wbGF0X2RhdGEgbXQ2Nzc5X2RhdGEgPSB7DQogDQogc3RhdGljIGNvbnN0IHN0
cnVjdCBtdGtfaW9tbXVfcGxhdF9kYXRhIG10ODE3M19kYXRhID0gew0KIAkubTR1X3BsYXQgICAg
ID0gTTRVX01UODE3MywNCi0JLmZsYWdzCSAgICAgID0gSEFTXzRHQl9NT0RFIHwgSEFTX0JDTEsg
fCBSRVNFVF9BWEksDQorCS5mbGFncwkgICAgICA9IEhBU180R0JfTU9ERSB8IEhBU19CQ0xLIHwg
UkVTRVRfQVhJIHwNCisJCQlIQVNfTEVHQUNZX0lWUlBfUEFERFIsDQogCS5pbnZfc2VsX3JlZyAg
PSBSRUdfTU1VX0lOVl9TRUxfR0VOMSwNCiAJLmxhcmJpZF9yZW1hcCA9IHt7MH0sIHsxfSwgezJ9
LCB7M30sIHs0fSwgezV9fSwgLyogTGluZWFyIG1hcHBpbmcuICovDQogfTsNCjwvUFJFPg0KPC9C
TE9DS1FVT1RFPg0KPEJSPg0KPC9CT0RZPg0KPC9IVE1MPg0K

--=-WtlvSa/6C0faa7vYEyei--


--===============2925078892297556930==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2925078892297556930==--

