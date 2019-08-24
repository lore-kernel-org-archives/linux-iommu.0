Return-Path: <SRS0=MNdo=WU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B7EC3A59E
	for <iommu@archiver.kernel.org>; Sat, 24 Aug 2019 14:57:18 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9639621670
	for <iommu@archiver.kernel.org>; Sat, 24 Aug 2019 14:57:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9639621670
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4D1B88B1;
	Sat, 24 Aug 2019 14:57:18 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id AF7398BF
	for <iommu@lists.linux-foundation.org>;
	Sat, 24 Aug 2019 13:44:34 +0000 (UTC)
X-Greylist: delayed 00:15:23 by SQLgrey-1.7.6
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[85.220.165.71])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 3A4F2735
	for <iommu@lists.linux-foundation.org>;
	Sat, 24 Aug 2019 13:44:34 +0000 (UTC)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
	by metis.ext.pengutronix.de with esmtps
	(TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1i1W6P-0006OC-4U; Sat, 24 Aug 2019 15:29:09 +0200
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1i1W6L-0002FN-24; Sat, 24 Aug 2019 15:29:05 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH v1 1/2] iommu: pass cell_count = -1 to of_for_each_phandle
	with cells_name
Date: Sat, 24 Aug 2019 15:28:45 +0200
Message-Id: <20190824132846.8589-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
	SAEximRunCond expanded to false
X-PTX-Original-Recipient: iommu@lists.linux-foundation.org
X-Mailman-Approved-At: Sat, 24 Aug 2019 14:57:17 +0000
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org,
	linux-mediatek@lists.infradead.org, kernel@pengutronix.de,
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

Q3VycmVudGx5IG9mX2Zvcl9lYWNoX3BoYW5kbGUgaWdub3JlcyB0aGUgY2VsbF9jb3VudCBwYXJh
bWV0ZXIgd2hlbiBhCmNlbGxzX25hbWUgaXMgZ2l2ZW4uIEkgaW50ZW5kIHRvIGNoYW5nZSB0aGF0
IGFuZCBsZXQgdGhlIGl0ZXJhdG9yIGZhbGwKYmFjayB0byBhIG5vbi1uZWdhdGl2ZSBjZWxsX2Nv
dW50IGlmIHRoZSBjZWxsc19uYW1lIHByb3BlcnR5IGlzIG1pc3NpbmcKaW4gdGhlIHJlZmVyZW5j
ZWQgbm9kZS4KClRvIG5vdCBjaGFuZ2UgaG93IGV4aXN0aW5nIG9mX2Zvcl9lYWNoX3BoYW5kbGUn
cyB1c2VycyBpdGVyYXRlLCBmaXggdGhlbQp0byBwYXNzIGNlbGxfY291bnQgPSAtMSB3aGVuIGFs
c28gY2VsbHNfbmFtZSBpcyBnaXZlbiB3aGljaCB5aWVsZHMgdGhlCmV4cGVjdGVkIGJlaGF2aW91
ciB3aXRoIGFuZCB3aXRob3V0IG15IGNoYW5nZS4KClNpZ25lZC1vZmYtYnk6IFV3ZSBLbGVpbmUt
S8O2bmlnIDx1LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+Ci0tLQogZHJpdmVycy9pb21t
dS9hcm0tc21tdS5jICAgICB8IDIgKy0KIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11X3YxLmMgfCAy
ICstCiAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2FybS1zbW11LmMgYi9kcml2ZXJzL2lvbW11L2FybS1z
bW11LmMKaW5kZXggNjQ5NzdjMTMxZWU2Li44MWI3NzM0NjU0YjMgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvaW9tbXUvYXJtLXNtbXUuYworKysgYi9kcml2ZXJzL2lvbW11L2FybS1zbW11LmMKQEAgLTMz
Myw3ICszMzMsNyBAQCBzdGF0aWMgaW50IF9fZmluZF9sZWdhY3lfbWFzdGVyX3BoYW5kbGUoc3Ry
dWN0IGRldmljZSAqZGV2LCB2b2lkICpkYXRhKQogCWludCBlcnI7CiAKIAlvZl9mb3JfZWFjaF9w
aGFuZGxlKGl0LCBlcnIsIGRldi0+b2Zfbm9kZSwgIm1tdS1tYXN0ZXJzIiwKLQkJCSAgICAiI3N0
cmVhbS1pZC1jZWxscyIsIDApCisJCQkgICAgIiNzdHJlYW0taWQtY2VsbHMiLCAtMSkKIAkJaWYg
KGl0LT5ub2RlID09IG5wKSB7CiAJCQkqKHZvaWQgKiopZGF0YSA9IGRldjsKIAkJCXJldHVybiAx
OwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXVfdjEuYyBiL2RyaXZlcnMvaW9t
bXUvbXRrX2lvbW11X3YxLmMKaW5kZXggYWJlZWFjNDg4MzcyLi42OGQxZGU3MGRlMGMgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11X3YxLmMKKysrIGIvZHJpdmVycy9pb21tdS9t
dGtfaW9tbXVfdjEuYwpAQCAtNDI2LDcgKzQyNiw3IEBAIHN0YXRpYyBpbnQgbXRrX2lvbW11X2Fk
ZF9kZXZpY2Uoc3RydWN0IGRldmljZSAqZGV2KQogCWludCBlcnI7CiAKIAlvZl9mb3JfZWFjaF9w
aGFuZGxlKCZpdCwgZXJyLCBkZXYtPm9mX25vZGUsICJpb21tdXMiLAotCQkJIiNpb21tdS1jZWxs
cyIsIDApIHsKKwkJCSIjaW9tbXUtY2VsbHMiLCAtMSkgewogCQlpbnQgY291bnQgPSBvZl9waGFu
ZGxlX2l0ZXJhdG9yX2FyZ3MoJml0LCBpb21tdV9zcGVjLmFyZ3MsCiAJCQkJCU1BWF9QSEFORExF
X0FSR1MpOwogCQlpb21tdV9zcGVjLm5wID0gb2Zfbm9kZV9nZXQoaXQubm9kZSk7Ci0tIAoyLjIw
LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11
IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
