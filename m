Return-Path: <SRS0=5Lc9=HM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0F4C433DB
	for <iommu@archiver.kernel.org>; Wed, 10 Feb 2021 16:13:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE80C64E6B
	for <iommu@archiver.kernel.org>; Wed, 10 Feb 2021 16:13:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE80C64E6B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B117986B12;
	Wed, 10 Feb 2021 16:13:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nPRmTOYlo5jF; Wed, 10 Feb 2021 16:13:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0F0E086AD1;
	Wed, 10 Feb 2021 16:13:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0501C0174;
	Wed, 10 Feb 2021 16:13:32 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28929C013A
 for <iommu@lists.linux-foundation.org>; Wed, 10 Feb 2021 16:13:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1B1AC874B9
 for <iommu@lists.linux-foundation.org>; Wed, 10 Feb 2021 16:13:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BeOt97QKiS3D for <iommu@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 16:13:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 357B2874AB
 for <iommu@lists.linux-foundation.org>; Wed, 10 Feb 2021 16:13:28 +0000 (UTC)
IronPort-SDR: 9bLQGz0g5hjDKzuCS30A/59AA+f9NeuLg+itptdHgaJwq32IAL72dfCKGfjr3AR2fNh9YVOK/9
 rUdTV6uc36LQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="178592272"
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; d="scan'208";a="178592272"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2021 08:13:28 -0800
IronPort-SDR: u2kavugDTlOmEgCnUxJwb7V8DNnKAOrrs2HkCgM6AdyHVWi2q2Sk4gKvMkkCk7RtjwgP9Q13Jl
 mO2U3nmB75Iw==
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; d="scan'208";a="380191385"
Received: from mjyalung-mobl.amr.corp.intel.com (HELO
 jderrick-mobl.amr.corp.intel.com) ([10.209.178.245])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2021 08:13:27 -0800
From: Jon Derrick <jonathan.derrick@intel.com>
To: <linux-pci@vger.kernel.org>,
	<iommu@lists.linux-foundation.org>
Subject: [PATCH v4 2/2] PCI: vmd: Disable MSI-X remapping when possible
Date: Wed, 10 Feb 2021 09:13:15 -0700
Message-Id: <20210210161315.316097-3-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210210161315.316097-1-jonathan.derrick@intel.com>
References: <20210210161315.316097-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Cc: Krzysztof Wilczynski <kw@linux.com>, Nirmal Patel <nirmal.patel@intel.com>,
 Kapil Karkra <kapil.karkra@intel.com>, Joerg Roedel <jroedel@suse.de>,
 Bjorn Helgaas <helgaas@kernel.org>, Jon Derrick <jonathan.derrick@intel.com>
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

Vk1EIHdpbGwgcmV0cmFuc21pdCBjaGlsZCBkZXZpY2UgTVNJLVggdXNpbmcgaXRzIG93biBNU0kt
WCB0YWJsZSBhbmQKcmVxdWVzdGVyLWlkLiBUaGlzIGxpbWl0cyB0aGUgbnVtYmVyIG9mIE1TSS1Y
IGF2YWlsYWJsZSB0byB0aGUgd2hvbGUKY2hpbGQgZGV2aWNlIGRvbWFpbiB0byB0aGUgbnVtYmVy
IG9mIFZNRCBNU0ktWCBpbnRlcnJ1cHRzLgoKU29tZSBWTUQgZGV2aWNlcyBoYXZlIGEgbW9kZSB3
aGVyZSB0aGlzIHJlbWFwcGluZyBjYW4gYmUgZGlzYWJsZWQsCmFsbG93aW5nIGNoaWxkIGRldmlj
ZSBpbnRlcnJ1cHRzIHRvIGJ5cGFzcyBwcm9jZXNzaW5nIHdpdGggdGhlIFZNRCBNU0ktWApkb21h
aW4gaW50ZXJydXB0IGhhbmRsZXIgYW5kIGdvaW5nIHN0cmFpZ2h0IHRoZSBjaGlsZCBkZXZpY2Ug
aW50ZXJydXB0CmhhbmRsZXIsIGFsbG93aW5nIGZvciBiZXR0ZXIgcGVyZm9ybWFuY2UgYW5kIHNj
YWxpbmcuIFRoZSByZXF1ZXN0ZXItaWQKc3RpbGwgZ2V0cyBjaGFuZ2VkIHRvIHRoZSBWTUQgZW5k
cG9pbnQncyByZXF1ZXN0ZXItaWQsIGFuZCB0aGUgaW50ZXJydXB0CnJlbWFwcGluZyBoYW5kbGVy
cyBoYXZlIGJlZW4gdXBkYXRlZCB0byBwcm9wZXJseSBzZXQgSVJURSBmb3IgY2hpbGQKZGV2aWNl
IGludGVycnVwdHMgdG8gdGhlIFZNRCBlbmRwb2ludCdzIGNvbnRleHQuCgpTb21lIFZNRCBwbGF0
Zm9ybXMgaGF2ZSBleGlzdGluZyBwcm9kdWN0aW9uIEJJT1Mgd2hpY2ggcmVseSBvbiBNU0ktWApy
ZW1hcHBpbmcgYW5kIHdvbid0IGV4cGxpY2l0bHkgcHJvZ3JhbSB0aGUgTVNJLVggcmVtYXBwaW5n
IGJpdC4gVGhpcwpyZS1lbmFibGVzIE1TSS1YIHJlbWFwcGluZyBvbiB1bmxvYWQuCgpBY2tlZC1i
eTogSm9lcmcgUm9lZGVsIDxqcm9lZGVsQHN1c2UuZGU+ClJldmlld2VkLWJ5OiBLcnp5c3p0b2Yg
V2lsY3p5xYRza2kgPGt3QGxpbnV4LmNvbT4KU2lnbmVkLW9mZi1ieTogSm9uIERlcnJpY2sgPGpv
bmF0aGFuLmRlcnJpY2tAaW50ZWwuY29tPgotLS0KIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvdm1k
LmMgfCA2MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0KIDEgZmlsZSBjaGFu
Z2VkLCA1MSBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL3ZtZC5jIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci92bWQuYwpp
bmRleCA1ZTgwZjI4ZjAxMTkuLmUzZmNkZmVjNThiMyAxMDA2NDQKLS0tIGEvZHJpdmVycy9wY2kv
Y29udHJvbGxlci92bWQuYworKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3ZtZC5jCkBAIC0y
OCw2ICsyOCw3IEBACiAjZGVmaW5lIEJVU19SRVNUUklDVF9DQVAodm1jYXApCSh2bWNhcCAmIDB4
MSkKICNkZWZpbmUgUENJX1JFR19WTUNPTkZJRwkweDQ0CiAjZGVmaW5lIEJVU19SRVNUUklDVF9D
Rkcodm1jZmcpCSgodm1jZmcgPj4gOCkgJiAweDMpCisjZGVmaW5lIFZNQ09ORklHX01TSV9SRU1B
UAkweDIKICNkZWZpbmUgUENJX1JFR19WTUxPQ0sJCTB4NzAKICNkZWZpbmUgTUIyX1NIQURPV19F
Tih2bWxvY2spCSh2bWxvY2sgJiAweDIpCiAKQEAgLTU5LDYgKzYwLDEzIEBAIGVudW0gdm1kX2Zl
YXR1cmVzIHsKIAkgKiBiZSB1c2VkIGZvciBNU0kgcmVtYXBwaW5nCiAJICovCiAJVk1EX0ZFQVRf
T0ZGU0VUX0ZJUlNUX1ZFQ1RPUgkJPSAoMSA8PCAzKSwKKworCS8qCisJICogRGV2aWNlIGNhbiBi
eXBhc3MgcmVtYXBwaW5nIE1TSS1YIHRyYW5zYWN0aW9ucyBpbnRvIGl0cyBNU0ktWCB0YWJsZSwK
KwkgKiBhdm9pZGluZyB0aGUgcmVxdWlyZW1lbnQgb2YgYSBWTUQgTVNJIGRvbWFpbiBmb3IgY2hp
bGQgZGV2aWNlCisJICogaW50ZXJydXB0IGhhbmRsaW5nLgorCSAqLworCVZNRF9GRUFUX0NBTl9C
WVBBU1NfTVNJX1JFTUFQCQk9ICgxIDw8IDQpLAogfTsKIAogLyoKQEAgLTMwNiw2ICszMTQsMTYg
QEAgc3RhdGljIHN0cnVjdCBtc2lfZG9tYWluX2luZm8gdm1kX21zaV9kb21haW5faW5mbyA9IHsK
IAkuY2hpcAkJPSAmdm1kX21zaV9jb250cm9sbGVyLAogfTsKIAorc3RhdGljIHZvaWQgdm1kX3Nl
dF9tc2lfcmVtYXBwaW5nKHN0cnVjdCB2bWRfZGV2ICp2bWQsIGJvb2wgZW5hYmxlKQoreworCXUx
NiByZWc7CisKKwlwY2lfcmVhZF9jb25maWdfd29yZCh2bWQtPmRldiwgUENJX1JFR19WTUNPTkZJ
RywgJnJlZyk7CisJcmVnID0gZW5hYmxlID8gKHJlZyAmIH5WTUNPTkZJR19NU0lfUkVNQVApIDoK
KwkJICAgICAgIChyZWcgfCBWTUNPTkZJR19NU0lfUkVNQVApOworCXBjaV93cml0ZV9jb25maWdf
d29yZCh2bWQtPmRldiwgUENJX1JFR19WTUNPTkZJRywgcmVnKTsKK30KKwogc3RhdGljIGludCB2
bWRfY3JlYXRlX2lycV9kb21haW4oc3RydWN0IHZtZF9kZXYgKnZtZCkKIHsKIAlzdHJ1Y3QgZndu
b2RlX2hhbmRsZSAqZm47CkBAIC0zMjUsNiArMzQzLDEzIEBAIHN0YXRpYyBpbnQgdm1kX2NyZWF0
ZV9pcnFfZG9tYWluKHN0cnVjdCB2bWRfZGV2ICp2bWQpCiAKIHN0YXRpYyB2b2lkIHZtZF9yZW1v
dmVfaXJxX2RvbWFpbihzdHJ1Y3Qgdm1kX2RldiAqdm1kKQogeworCS8qCisJICogU29tZSBwcm9k
dWN0aW9uIEJJT1Mgd29uJ3QgZW5hYmxlIHJlbWFwcGluZyBiZXR3ZWVuIHNvZnQgcmVib290cy4K
KwkgKiBFbnN1cmUgcmVtYXBwaW5nIGlzIHJlc3RvcmVkIGJlZm9yZSB1bmxvYWRpbmcgdGhlIGRy
aXZlci4KKwkgKi8KKwlpZiAoIXZtZC0+bXNpeF9jb3VudCkKKwkJdm1kX3NldF9tc2lfcmVtYXBw
aW5nKHZtZCwgdHJ1ZSk7CisKIAlpZiAodm1kLT5pcnFfZG9tYWluKSB7CiAJCXN0cnVjdCBmd25v
ZGVfaGFuZGxlICpmbiA9IHZtZC0+aXJxX2RvbWFpbi0+Zndub2RlOwogCkBAIC02NzksMTUgKzcw
NCwzMiBAQCBzdGF0aWMgaW50IHZtZF9lbmFibGVfZG9tYWluKHN0cnVjdCB2bWRfZGV2ICp2bWQs
IHVuc2lnbmVkIGxvbmcgZmVhdHVyZXMpCiAKIAlzZC0+bm9kZSA9IHBjaWJ1c190b19ub2RlKHZt
ZC0+ZGV2LT5idXMpOwogCi0JcmV0ID0gdm1kX2NyZWF0ZV9pcnFfZG9tYWluKHZtZCk7Ci0JaWYg
KHJldCkKLQkJcmV0dXJuIHJldDsKLQogCS8qCi0JICogT3ZlcnJpZGUgdGhlIGlycSBkb21haW4g
YnVzIHRva2VuIHNvIHRoZSBkb21haW4gY2FuIGJlIGRpc3Rpbmd1aXNoZWQKLQkgKiBmcm9tIGEg
cmVndWxhciBQQ0kvTVNJIGRvbWFpbi4KKwkgKiBDdXJyZW50bHkgTVNJIHJlbWFwcGluZyBtdXN0
IGJlIGVuYWJsZWQgaW4gZ3Vlc3QgcGFzc3Rocm91Z2ggbW9kZQorCSAqIGR1ZSB0byBzb21lIG1p
c3NpbmcgaW50ZXJydXB0IHJlbWFwcGluZyBwbHVtYmluZy4gVGhpcyBpcyBwcm9iYWJseQorCSAq
IGFjY2VwdGFibGUgYmVjYXVzZSB0aGUgZ3Vlc3QgaXMgdXN1YWxseSBDUFUtbGltaXRlZCBhbmQg
TVNJCisJICogcmVtYXBwaW5nIGRvZXNuJ3QgYmVjb21lIGEgcGVyZm9ybWFuY2UgYm90dGxlbmVj
ay4KIAkgKi8KLQlpcnFfZG9tYWluX3VwZGF0ZV9idXNfdG9rZW4odm1kLT5pcnFfZG9tYWluLCBE
T01BSU5fQlVTX1ZNRF9NU0kpOworCWlmICghKGZlYXR1cmVzICYgVk1EX0ZFQVRfQ0FOX0JZUEFT
U19NU0lfUkVNQVApIHx8CisJICAgIG9mZnNldFswXSB8fCBvZmZzZXRbMV0pIHsKKwkJcmV0ID0g
dm1kX2FsbG9jX2lycXModm1kKTsKKwkJaWYgKHJldCkKKwkJCXJldHVybiByZXQ7CisKKwkJdm1k
X3NldF9tc2lfcmVtYXBwaW5nKHZtZCwgdHJ1ZSk7CisKKwkJcmV0ID0gdm1kX2NyZWF0ZV9pcnFf
ZG9tYWluKHZtZCk7CisJCWlmIChyZXQpCisJCQlyZXR1cm4gcmV0OworCisJCS8qCisJCSAqIE92
ZXJyaWRlIHRoZSBJUlEgZG9tYWluIGJ1cyB0b2tlbiBzbyB0aGUgZG9tYWluIGNhbiBiZQorCQkg
KiBkaXN0aW5ndWlzaGVkIGZyb20gYSByZWd1bGFyIFBDSS9NU0kgZG9tYWluLgorCQkgKi8KKwkJ
aXJxX2RvbWFpbl91cGRhdGVfYnVzX3Rva2VuKHZtZC0+aXJxX2RvbWFpbiwgRE9NQUlOX0JVU19W
TURfTVNJKTsKKwl9IGVsc2UgeworCQl2bWRfc2V0X21zaV9yZW1hcHBpbmcodm1kLCBmYWxzZSk7
CisJfQogCiAJcGNpX2FkZF9yZXNvdXJjZSgmcmVzb3VyY2VzLCAmdm1kLT5yZXNvdXJjZXNbMF0p
OwogCXBjaV9hZGRfcmVzb3VyY2Vfb2Zmc2V0KCZyZXNvdXJjZXMsICZ2bWQtPnJlc291cmNlc1sx
XSwgb2Zmc2V0WzBdKTsKQEAgLTc1MywxMCArNzk1LDYgQEAgc3RhdGljIGludCB2bWRfcHJvYmUo
c3RydWN0IHBjaV9kZXYgKmRldiwgY29uc3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQgKmlkKQogCWlm
IChmZWF0dXJlcyAmIFZNRF9GRUFUX09GRlNFVF9GSVJTVF9WRUNUT1IpCiAJCXZtZC0+Zmlyc3Rf
dmVjID0gMTsKIAotCWVyciA9IHZtZF9hbGxvY19pcnFzKHZtZCk7Ci0JaWYgKGVycikKLQkJcmV0
dXJuIGVycjsKLQogCXNwaW5fbG9ja19pbml0KCZ2bWQtPmNmZ19sb2NrKTsKIAlwY2lfc2V0X2Ry
dmRhdGEoZGV2LCB2bWQpOwogCWVyciA9IHZtZF9lbmFibGVfZG9tYWluKHZtZCwgZmVhdHVyZXMp
OwpAQCAtODI1LDcgKzg2Myw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCB2
bWRfaWRzW10gPSB7CiAJCS5kcml2ZXJfZGF0YSA9IFZNRF9GRUFUX0hBU19NRU1CQVJfU0hBRE9X
X1ZTQ0FQLH0sCiAJe1BDSV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9JTlRFTCwgUENJX0RFVklDRV9J
RF9JTlRFTF9WTURfMjhDMCksCiAJCS5kcml2ZXJfZGF0YSA9IFZNRF9GRUFUX0hBU19NRU1CQVJf
U0hBRE9XIHwKLQkJCQlWTURfRkVBVF9IQVNfQlVTX1JFU1RSSUNUSU9OUyx9LAorCQkJCVZNRF9G
RUFUX0hBU19CVVNfUkVTVFJJQ1RJT05TIHwKKwkJCQlWTURfRkVBVF9DQU5fQllQQVNTX01TSV9S
RU1BUCx9LAogCXtQQ0lfREVWSUNFKFBDSV9WRU5ET1JfSURfSU5URUwsIDB4NDY3ZiksCiAJCS5k
cml2ZXJfZGF0YSA9IFZNRF9GRUFUX0hBU19NRU1CQVJfU0hBRE9XX1ZTQ0FQIHwKIAkJCQlWTURf
RkVBVF9IQVNfQlVTX1JFU1RSSUNUSU9OUyB8Ci0tIAoyLjI3LjAKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
