Return-Path: <SRS0=MNdo=WU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E72C3A59E
	for <iommu@archiver.kernel.org>; Sat, 24 Aug 2019 14:57:22 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3512021670
	for <iommu@archiver.kernel.org>; Sat, 24 Aug 2019 14:57:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3512021670
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 778CE941;
	Sat, 24 Aug 2019 14:57:18 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id AD25EB43
	for <iommu@lists.linux-foundation.org>;
	Sat, 24 Aug 2019 13:44:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[85.220.165.71])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 3AABCA7
	for <iommu@lists.linux-foundation.org>;
	Sat, 24 Aug 2019 13:44:36 +0000 (UTC)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
	by metis.ext.pengutronix.de with esmtps
	(TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1i1W6P-0006OD-5g; Sat, 24 Aug 2019 15:29:09 +0200
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1i1W6L-0002FP-2q; Sat, 24 Aug 2019 15:29:05 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH v1 2/2] of: Let of_for_each_phandle fallback to non-negative
	cell_count
Date: Sat, 24 Aug 2019 15:28:46 +0200
Message-Id: <20190824132846.8589-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190824132846.8589-1-u.kleine-koenig@pengutronix.de>
References: <20190824132846.8589-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
	SAEximRunCond expanded to false
X-PTX-Original-Recipient: iommu@lists.linux-foundation.org
X-Mailman-Approved-At: Sat, 24 Aug 2019 14:57:17 +0000
Cc: devicetree@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	linux-mediatek@lists.infradead.org, kernel@pengutronix.de,
	Matthias Brugger <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

UmVmZXJlbmNpbmcgZGV2aWNlIHRyZWUgbm9kZXMgZnJvbSBhIHByb3BlcnR5IGFsbG93cyB0byBw
YXNzIGFyZ3VtZW50cy4KVGhpcyBpcyBmb3IgZXhhbXBsZSB1c2VkIGZvciByZWZlcmVuY2luZyBn
cGlvcy4gVGhpcyBsb29rcyBhcyBmb2xsb3dzOgoKCWdwaW9fY3RybDogZ3Bpby1jb250cm9sbGVy
IHsKCQkjZ3Bpby1jZWxscyA9IDwyPgoJCS4uLgoJfQoKCXNvbWVvdGhlcm5vZGUgewoJCWdwaW9z
ID0gPCZncGlvX2N0cmwgNSAwICZncGlvX2N0cmwgMyAwPjsKCQkuLi4KCX0KClRvIGtub3cgdGhl
IG51bWJlciBvZiBhcmd1bWVudHMgdGhpcyBtdXN0IGJlIGVpdGhlciBmaXhlZCwgb3IgdGhlCnJl
ZmVyZW5jZWQgbm9kZSBpcyBjaGVja2VkIGZvciBhICRjZWxsc19uYW1lIChoZXJlOiAiI2dwaW8t
Y2VsbHMiKQpwcm9wZXJ0eSBhbmQgd2l0aCB0aGlzIGluZm9ybWF0aW9uIHRoZSBzdGFydCBvZiB0
aGUgc2Vjb25kIHJlZmVyZW5jZSBjYW4KYmUgZGV0ZXJtaW5lZC4KCkN1cnJlbnRseSByZWd1bGF0
b3JzIGFyZSByZWZlcmVuY2VkIHdpdGggbm8gYWRkaXRpb25hbCBhcmd1bWVudHMuIFRvCmFsbG93
IHNvbWUgb3B0aW9uYWwgYXJndW1lbnRzIHdpdGhvdXQgaGF2aW5nIHRvIGNoYW5nZSBhbGwgcmVm
ZXJlbmNlZApub2RlcyB0aGlzIGNoYW5nZSBpbnRyb2R1Y2VzIGEgd2F5IHRvIHNwZWNpZnkgYSBk
ZWZhdWx0IGNlbGxfY291bnQuIFNvCndoZW4gYSBwaGFuZGxlIGlzIHBhcnNlZCB3ZSBjaGVjayBm
b3IgdGhlICRjZWxsc19uYW1lIHByb3BlcnR5IGFuZCB1c2UKaXQgYXMgYmVmb3JlIGlmIHByZXNl
bnQuIElmIGl0IGlzIG5vdCBwcmVzZW50IHdlIGZhbGwgYmFjayB0bwpjZWxsc19jb3VudCBpZiBu
b24tbmVnYXRpdmUgYW5kIG9ubHkgZmFpbCBpZiBjZWxsc19jb3VudCBpcyBzbWFsbGVyIHRoYW4K
emVyby4KClNpZ25lZC1vZmYtYnk6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1LmtsZWluZS1rb2VuaWdA
cGVuZ3V0cm9uaXguZGU+Ci0tLQogZHJpdmVycy9vZi9iYXNlLmMgfCAyNSArKysrKysrKysrKysr
KysrKy0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL29mL2Jhc2UuYyBiL2RyaXZlcnMvb2YvYmFzZS5j
CmluZGV4IDU1ZTdmNWJiMDU0OS4uMmYyNWQyZGZlY2ZhIDEwMDY0NAotLS0gYS9kcml2ZXJzL29m
L2Jhc2UuYworKysgYi9kcml2ZXJzL29mL2Jhc2UuYwpAQCAtMTMzNSwxMSArMTMzNSwyMCBAQCBp
bnQgb2ZfcGhhbmRsZV9pdGVyYXRvcl9uZXh0KHN0cnVjdCBvZl9waGFuZGxlX2l0ZXJhdG9yICpp
dCkKIAogCQkJaWYgKG9mX3Byb3BlcnR5X3JlYWRfdTMyKGl0LT5ub2RlLCBpdC0+Y2VsbHNfbmFt
ZSwKIAkJCQkJCSAmY291bnQpKSB7Ci0JCQkJcHJfZXJyKCIlcE9GOiBjb3VsZCBub3QgZ2V0ICVz
IGZvciAlcE9GXG4iLAotCQkJCSAgICAgICBpdC0+cGFyZW50LAotCQkJCSAgICAgICBpdC0+Y2Vs
bHNfbmFtZSwKLQkJCQkgICAgICAgaXQtPm5vZGUpOwotCQkJCWdvdG8gZXJyOworCQkJCS8qCisJ
CQkJICogSWYgYm90aCBjZWxsX2NvdW50IGFuZCBjZWxsc19uYW1lIGlzIGdpdmVuLAorCQkJCSAq
IGZhbGwgYmFjayB0byBjZWxsX2NvdW50IGluIGFic2VuY2UKKwkJCQkgKiBvZiB0aGUgY2VsbHNf
bmFtZSBwcm9wZXJ0eQorCQkJCSAqLworCQkJCWlmIChpdC0+Y2VsbF9jb3VudCA+PSAwKSB7CisJ
CQkJCWNvdW50ID0gaXQtPmNlbGxfY291bnQ7CisJCQkJfSBlbHNlIHsKKwkJCQkJcHJfZXJyKCIl
cE9GOiBjb3VsZCBub3QgZ2V0ICVzIGZvciAlcE9GXG4iLAorCQkJCQkgICAgICAgaXQtPnBhcmVu
dCwKKwkJCQkJICAgICAgIGl0LT5jZWxsc19uYW1lLAorCQkJCQkgICAgICAgaXQtPm5vZGUpOwor
CQkJCQlnb3RvIGVycjsKKwkJCQl9CiAJCQl9CiAJCX0gZWxzZSB7CiAJCQljb3VudCA9IGl0LT5j
ZWxsX2NvdW50OwpAQCAtMTUwNSw3ICsxNTE0LDcgQEAgaW50IG9mX3BhcnNlX3BoYW5kbGVfd2l0
aF9hcmdzKGNvbnN0IHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAsIGNvbnN0IGNoYXIgKmxpc3RfbmEK
IHsKIAlpZiAoaW5kZXggPCAwKQogCQlyZXR1cm4gLUVJTlZBTDsKLQlyZXR1cm4gX19vZl9wYXJz
ZV9waGFuZGxlX3dpdGhfYXJncyhucCwgbGlzdF9uYW1lLCBjZWxsc19uYW1lLCAwLAorCXJldHVy
biBfX29mX3BhcnNlX3BoYW5kbGVfd2l0aF9hcmdzKG5wLCBsaXN0X25hbWUsIGNlbGxzX25hbWUs
IC0xLAogCQkJCQkgICAgaW5kZXgsIG91dF9hcmdzKTsKIH0KIEVYUE9SVF9TWU1CT0wob2ZfcGFy
c2VfcGhhbmRsZV93aXRoX2FyZ3MpOwpAQCAtMTU4OCw3ICsxNTk3LDcgQEAgaW50IG9mX3BhcnNl
X3BoYW5kbGVfd2l0aF9hcmdzX21hcChjb25zdCBzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wLAogCWlm
ICghcGFzc19uYW1lKQogCQlnb3RvIGZyZWU7CiAKLQlyZXQgPSBfX29mX3BhcnNlX3BoYW5kbGVf
d2l0aF9hcmdzKG5wLCBsaXN0X25hbWUsIGNlbGxzX25hbWUsIDAsIGluZGV4LAorCXJldCA9IF9f
b2ZfcGFyc2VfcGhhbmRsZV93aXRoX2FyZ3MobnAsIGxpc3RfbmFtZSwgY2VsbHNfbmFtZSwgLTEs
IGluZGV4LAogCQkJCQkgICBvdXRfYXJncyk7CiAJaWYgKHJldCkKIAkJZ290byBmcmVlOwpAQCAt
MTc1Niw3ICsxNzY1LDcgQEAgaW50IG9mX2NvdW50X3BoYW5kbGVfd2l0aF9hcmdzKGNvbnN0IHN0
cnVjdCBkZXZpY2Vfbm9kZSAqbnAsIGNvbnN0IGNoYXIgKmxpc3RfbmEKIAlzdHJ1Y3Qgb2ZfcGhh
bmRsZV9pdGVyYXRvciBpdDsKIAlpbnQgcmMsIGN1cl9pbmRleCA9IDA7CiAKLQlyYyA9IG9mX3Bo
YW5kbGVfaXRlcmF0b3JfaW5pdCgmaXQsIG5wLCBsaXN0X25hbWUsIGNlbGxzX25hbWUsIDApOwor
CXJjID0gb2ZfcGhhbmRsZV9pdGVyYXRvcl9pbml0KCZpdCwgbnAsIGxpc3RfbmFtZSwgY2VsbHNf
bmFtZSwgLTEpOwogCWlmIChyYykKIAkJcmV0dXJuIHJjOwogCi0tIAoyLjIwLjEKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlz
dAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
