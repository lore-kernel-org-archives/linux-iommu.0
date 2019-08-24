Return-Path: <SRS0=MNdo=WU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B39AC3A5A2
	for <iommu@archiver.kernel.org>; Sat, 24 Aug 2019 03:21:35 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6825C2133F
	for <iommu@archiver.kernel.org>; Sat, 24 Aug 2019 03:21:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6825C2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 53165BE4;
	Sat, 24 Aug 2019 03:21:35 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id DEE7BBB3
	for <iommu@lists.linux-foundation.org>;
	Sat, 24 Aug 2019 03:21:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 0893AA7
	for <iommu@lists.linux-foundation.org>;
	Sat, 24 Aug 2019 03:21:33 +0000 (UTC)
X-UUID: c0d77b2941dd40dcb855e1276ae0dffc-20190824
X-UUID: c0d77b2941dd40dcb855e1276ae0dffc-20190824
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by
	mailgw02.mediatek.com (envelope-from <yong.wu@mediatek.com>)
	(Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
	with ESMTP id 772859647; Sat, 24 Aug 2019 11:06:51 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
	mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server
	(TLS) id 15.0.1395.4; Sat, 24 Aug 2019 11:06:43 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
	(172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
	Transport; Sat, 24 Aug 2019 11:06:42 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
Subject: [PATCH v11 21/23] iommu/mediatek: Fix VLD_PA_RNG register backup when
	suspend
Date: Sat, 24 Aug 2019 11:02:06 +0800
Message-ID: <1566615728-26388-22-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1566615728-26388-1-git-send-email-yong.wu@mediatek.com>
References: <1566615728-26388-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
	Nicolas Boichat <drinkcat@chromium.org>, cui.zhang@mediatek.com,
	srv_heupstream@mediatek.com, chao.hao@mediatek.com,
	linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
	Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
	Rob Herring <robh+dt@kernel.org>,
	linux-mediatek@lists.infradead.org, ming-fan.chen@mediatek.com,
	anan.sun@mediatek.com, Matthias Kaehlcke <mka@chromium.org>,
	linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: multipart/mixed; boundary="===============6682487861970783855=="
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

--===============6682487861970783855==
Content-Type: multipart/alternative;
	boundary="__=_Part_Boundary_002_1287252294.1592834265"

--__=_Part_Boundary_002_1287252294.1592834265
Content-Type: text/html
Content-Transfer-Encoding: base64

PHByZT4NClRoZSByZWdpc3RlciBWTERfUEFfUk5HKDB4MTE4KSB3YXMgZm9yZ290IHRvIGJhY2t1
cCB3aGlsZSBhZGRpbmcgNEdCDQptb2RlIHN1cHBvcnQgZm9yIG10MjcxMi4gdGhpcyBwYXRjaCBh
ZGQgaXQuDQoNCkZpeGVzOiAzMGUyZmNjZjk1MTIgKCZxdW90O2lvbW11L21lZGlhdGVrOiBFbmxh
cmdlIHRoZSB2YWxpZGF0ZSBQQSByYW5nZQ0KZm9yIDRHQiBtb2RlJnF1b3Q7KQ0KU2lnbmVkLW9m
Zi1ieTogWW9uZyBXdSAmbHQ7eW9uZy53dUBtZWRpYXRlay5jb20mZ3Q7DQpSZXZpZXdlZC1ieTog
RXZhbiBHcmVlbiAmbHQ7ZXZncmVlbkBjaHJvbWl1bS5vcmcmZ3Q7DQpSZXZpZXdlZC1ieTogTWF0
dGhpYXMgQnJ1Z2dlciAmbHQ7bWF0dGhpYXMuYmdnQGdtYWlsLmNvbSZndDsNCi0tLQ0KIGRyaXZl
cnMvaW9tbXUvbXRrX2lvbW11LmMgfCAyICsrDQogZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaCB8
IDEgKw0KIDIgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2lvbW11L210a19pb21tdS5jIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KaW5k
ZXggNDcwZGU4Yi4uNWQ1MzQxYyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11
LmMNCisrKyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCkBAIC03NDIsNiArNzQyLDcgQEAg
c3RhdGljIGludCBfX21heWJlX3VudXNlZCBtdGtfaW9tbXVfc3VzcGVuZChzdHJ1Y3QgZGV2aWNl
ICpkZXYpDQogCXJlZy0mZ3Q7aW50X2NvbnRyb2wwID0gcmVhZGxfcmVsYXhlZChiYXNlICsgUkVH
X01NVV9JTlRfQ09OVFJPTDApOw0KIAlyZWctJmd0O2ludF9tYWluX2NvbnRyb2wgPSByZWFkbF9y
ZWxheGVkKGJhc2UgKyBSRUdfTU1VX0lOVF9NQUlOX0NPTlRST0wpOw0KIAlyZWctJmd0O2l2cnBf
cGFkZHIgPSByZWFkbF9yZWxheGVkKGJhc2UgKyBSRUdfTU1VX0lWUlBfUEFERFIpOw0KKwlyZWct
Jmd0O3ZsZF9wYV9ybmcgPSByZWFkbF9yZWxheGVkKGJhc2UgKyBSRUdfTU1VX1ZMRF9QQV9STkcp
Ow0KIAljbGtfZGlzYWJsZV91bnByZXBhcmUoZGF0YS0mZ3Q7YmNsayk7DQogCXJldHVybiAwOw0K
IH0NCkBAIC03NjYsNiArNzY3LDcgQEAgc3RhdGljIGludCBfX21heWJlX3VudXNlZCBtdGtfaW9t
bXVfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCiAJd3JpdGVsX3JlbGF4ZWQocmVnLSZndDtp
bnRfY29udHJvbDAsIGJhc2UgKyBSRUdfTU1VX0lOVF9DT05UUk9MMCk7DQogCXdyaXRlbF9yZWxh
eGVkKHJlZy0mZ3Q7aW50X21haW5fY29udHJvbCwgYmFzZSArIFJFR19NTVVfSU5UX01BSU5fQ09O
VFJPTCk7DQogCXdyaXRlbF9yZWxheGVkKHJlZy0mZ3Q7aXZycF9wYWRkciwgYmFzZSArIFJFR19N
TVVfSVZSUF9QQUREUik7DQorCXdyaXRlbF9yZWxheGVkKHJlZy0mZ3Q7dmxkX3BhX3JuZywgYmFz
ZSArIFJFR19NTVVfVkxEX1BBX1JORyk7DQogCWlmIChtNHVfZG9tKQ0KIAkJd3JpdGVsKG00dV9k
b20tJmd0O2NmZy5hcm1fdjdzX2NmZy50dGJyWzBdICZhbXA7IE1NVV9QVF9BRERSX01BU0ssDQog
CQkgICAgICAgYmFzZSArIFJFR19NTVVfUFRfQkFTRV9BRERSKTsNCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2lvbW11L210a19pb21tdS5oIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaA0KaW5kZXgg
NmIxZjgzMy4uNTZiNTc5YyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmgN
CisrKyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmgNCkBAIC0yNCw2ICsyNCw3IEBAIHN0cnVj
dCBtdGtfaW9tbXVfc3VzcGVuZF9yZWcgew0KIAl1MzIJCQkJaW50X2NvbnRyb2wwOw0KIAl1MzIJ
CQkJaW50X21haW5fY29udHJvbDsNCiAJdTMyCQkJCWl2cnBfcGFkZHI7DQorCXUzMgkJCQl2bGRf
cGFfcm5nOw0KIH07DQogDQogZW51bSBtdGtfaW9tbXVfcGxhdCB7DQotLSANCjEuOS4xDQoNCjwv
cHJlPjwhLS10eXBlOnRleHQtLT48IS0tey0tPjxwcmU+KioqKioqKioqKioqKiBNRURJQVRFSyBD
b25maWRlbnRpYWxpdHkgTm90aWNlICoqKioqKioqKioqKioqKioqKioqDQpUaGUgaW5mb3JtYXRp
b24gY29udGFpbmVkIGluIHRoaXMgZS1tYWlsIG1lc3NhZ2UgKGluY2x1ZGluZyBhbnkgDQphdHRh
Y2htZW50cykgbWF5IGJlIGNvbmZpZGVudGlhbCwgcHJvcHJpZXRhcnksIHByaXZpbGVnZWQsIG9y
IG90aGVyd2lzZQ0KZXhlbXB0IGZyb20gZGlzY2xvc3VyZSB1bmRlciBhcHBsaWNhYmxlIGxhd3Mu
IEl0IGlzIGludGVuZGVkIHRvIGJlIA0KY29udmV5ZWQgb25seSB0byB0aGUgZGVzaWduYXRlZCBy
ZWNpcGllbnQocykuIEFueSB1c2UsIGRpc3NlbWluYXRpb24sIA0KZGlzdHJpYnV0aW9uLCBwcmlu
dGluZywgcmV0YWluaW5nIG9yIGNvcHlpbmcgb2YgdGhpcyBlLW1haWwgKGluY2x1ZGluZyBpdHMg
DQphdHRhY2htZW50cykgYnkgdW5pbnRlbmRlZCByZWNpcGllbnQocykgaXMgc3RyaWN0bHkgcHJv
aGliaXRlZCBhbmQgbWF5IA0KYmUgdW5sYXdmdWwuIElmIHlvdSBhcmUgbm90IGFuIGludGVuZGVk
IHJlY2lwaWVudCBvZiB0aGlzIGUtbWFpbCwgb3IgYmVsaWV2ZSANCnRoYXQgeW91IGhhdmUgcmVj
ZWl2ZWQgdGhpcyBlLW1haWwgaW4gZXJyb3IsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciANCmlt
bWVkaWF0ZWx5IChieSByZXBseWluZyB0byB0aGlzIGUtbWFpbCksIGRlbGV0ZSBhbnkgYW5kIGFs
bCBjb3BpZXMgb2YgDQp0aGlzIGUtbWFpbCAoaW5jbHVkaW5nIGFueSBhdHRhY2htZW50cykgZnJv
bSB5b3VyIHN5c3RlbSwgYW5kIGRvIG5vdA0KZGlzY2xvc2UgdGhlIGNvbnRlbnQgb2YgdGhpcyBl
LW1haWwgdG8gYW55IG90aGVyIHBlcnNvbi4gVGhhbmsgeW91IQ0KPC9wcmU+PCEtLX0tLT4=

--__=_Part_Boundary_002_1287252294.1592834265
Content-Type: text/plain
Content-Transfer-Encoding: base64

VGhlIHJlZ2lzdGVyIFZMRF9QQV9STkcoMHgxMTgpIHdhcyBmb3Jnb3QgdG8gYmFja3VwIHdoaWxl
IGFkZGluZyA0R0INCm1vZGUgc3VwcG9ydCBmb3IgbXQyNzEyLiB0aGlzIHBhdGNoIGFkZCBpdC4N
Cg0KRml4ZXM6IDMwZTJmY2NmOTUxMiAoImlvbW11L21lZGlhdGVrOiBFbmxhcmdlIHRoZSB2YWxp
ZGF0ZSBQQSByYW5nZQ0KZm9yIDRHQiBtb2RlIikNClNpZ25lZC1vZmYtYnk6IFlvbmcgV3UgPHlv
bmcud3VAbWVkaWF0ZWsuY29tPg0KUmV2aWV3ZWQtYnk6IEV2YW4gR3JlZW4gPGV2Z3JlZW5AY2hy
b21pdW0ub3JnPg0KUmV2aWV3ZWQtYnk6IE1hdHRoaWFzIEJydWdnZXIgPG1hdHRoaWFzLmJnZ0Bn
bWFpbC5jb20+DQotLS0NCiBkcml2ZXJzL2lvbW11L210a19pb21tdS5jIHwgMiArKw0KIGRyaXZl
cnMvaW9tbXUvbXRrX2lvbW11LmggfCAxICsNCiAyIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9u
cygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyBiL2RyaXZlcnMv
aW9tbXUvbXRrX2lvbW11LmMNCmluZGV4IDQ3MGRlOGIuLjVkNTM0MWMgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL2lvbW11L210a19pb21tdS5jDQorKysgYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5j
DQpAQCAtNzQyLDYgKzc0Miw3IEBAIHN0YXRpYyBpbnQgX19tYXliZV91bnVzZWQgbXRrX2lvbW11
X3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KQ0KIAlyZWctPmludF9jb250cm9sMCA9IHJlYWRs
X3JlbGF4ZWQoYmFzZSArIFJFR19NTVVfSU5UX0NPTlRST0wwKTsNCiAJcmVnLT5pbnRfbWFpbl9j
b250cm9sID0gcmVhZGxfcmVsYXhlZChiYXNlICsgUkVHX01NVV9JTlRfTUFJTl9DT05UUk9MKTsN
CiAJcmVnLT5pdnJwX3BhZGRyID0gcmVhZGxfcmVsYXhlZChiYXNlICsgUkVHX01NVV9JVlJQX1BB
RERSKTsNCisJcmVnLT52bGRfcGFfcm5nID0gcmVhZGxfcmVsYXhlZChiYXNlICsgUkVHX01NVV9W
TERfUEFfUk5HKTsNCiAJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGRhdGEtPmJjbGspOw0KIAlyZXR1
cm4gMDsNCiB9DQpAQCAtNzY2LDYgKzc2Nyw3IEBAIHN0YXRpYyBpbnQgX19tYXliZV91bnVzZWQg
bXRrX2lvbW11X3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQogCXdyaXRlbF9yZWxheGVkKHJl
Zy0+aW50X2NvbnRyb2wwLCBiYXNlICsgUkVHX01NVV9JTlRfQ09OVFJPTDApOw0KIAl3cml0ZWxf
cmVsYXhlZChyZWctPmludF9tYWluX2NvbnRyb2wsIGJhc2UgKyBSRUdfTU1VX0lOVF9NQUlOX0NP
TlRST0wpOw0KIAl3cml0ZWxfcmVsYXhlZChyZWctPml2cnBfcGFkZHIsIGJhc2UgKyBSRUdfTU1V
X0lWUlBfUEFERFIpOw0KKwl3cml0ZWxfcmVsYXhlZChyZWctPnZsZF9wYV9ybmcsIGJhc2UgKyBS
RUdfTU1VX1ZMRF9QQV9STkcpOw0KIAlpZiAobTR1X2RvbSkNCiAJCXdyaXRlbChtNHVfZG9tLT5j
ZmcuYXJtX3Y3c19jZmcudHRiclswXSAmIE1NVV9QVF9BRERSX01BU0ssDQogCQkgICAgICAgYmFz
ZSArIFJFR19NTVVfUFRfQkFTRV9BRERSKTsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210
a19pb21tdS5oIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaA0KaW5kZXggNmIxZjgzMy4uNTZi
NTc5YyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmgNCisrKyBiL2RyaXZl
cnMvaW9tbXUvbXRrX2lvbW11LmgNCkBAIC0yNCw2ICsyNCw3IEBAIHN0cnVjdCBtdGtfaW9tbXVf
c3VzcGVuZF9yZWcgew0KIAl1MzIJCQkJaW50X2NvbnRyb2wwOw0KIAl1MzIJCQkJaW50X21haW5f
Y29udHJvbDsNCiAJdTMyCQkJCWl2cnBfcGFkZHI7DQorCXUzMgkJCQl2bGRfcGFfcm5nOw0KIH07
DQogDQogZW51bSBtdGtfaW9tbXVfcGxhdCB7DQotLSANCjEuOS4xDQo=

--__=_Part_Boundary_002_1287252294.1592834265--


--===============6682487861970783855==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6682487861970783855==--

