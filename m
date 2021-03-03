Return-Path: <SRS0=nNEG=IB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB2CC433E0
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 12:12:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8715064E41
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 12:12:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8715064E41
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 19D3E474F3;
	Wed,  3 Mar 2021 12:12:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FEOLamvVSzvu; Wed,  3 Mar 2021 12:12:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 918D242DAD;
	Wed,  3 Mar 2021 12:12:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 746D6C000A;
	Wed,  3 Mar 2021 12:12:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E582BC0001
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 12:12:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D3FFD837CD
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 12:12:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nHJSZCHISGtH for <iommu@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 12:12:09 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9EF2D83759
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 12:12:09 +0000 (UTC)
Received: from localhost.localdomain (ip5f5aecd2.dynamic.kabel-deutschland.de
 [95.90.236.210])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0B1FE206446A2;
 Wed,  3 Mar 2021 13:12:06 +0100 (CET)
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH] Revert "iommu/amd: Fix performance counter initialization"
Date: Wed,  3 Mar 2021 13:11:56 +0100
Message-Id: <20210303121156.76621-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, David Coe <david.coe@live.co.uk>,
 Alexander Monakov <amonakov@ispras.ru>, iommu@lists.linux-foundation.org,
 Shuah Khan <skhan@linuxfoundation.org>, Tj <ml.linux@elloe.vision>
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

VGhpcyByZXZlcnRzIGNvbW1pdCA2Nzc4ZmY1YjIxYmQ4ZTc4YzhiZDU0N2ZkNjY0MzdjZjI2NTdm
ZDliLgoKVGhlIGNvbW1pdCBhZGRzIHVwIHRvIDEwMCBtcyB0byB0aGUgYm9vdCBwcm9jZXNzLCB3
aGljaCBpcyBub3QgbWVudGlvbmVkCmluIHRoZSBjb21taXQgbWVzc2FnZSwgYW5kIGlzIG1ha2lu
ZyB1cCBtb3JlIHRoYW4gMjAgJSBvbiBjdXJyZW50CnN5c3RlbXMsIHdoZXJlIHRoZSBMaW51eCBr
ZXJuZWwgdGFrZXMgNTAwIG1zLgoKICAgIFsgICAgMC4wMDAwMDBdIExpbnV4IHZlcnNpb24gNS4x
MS4wLTEwMjgxLWcxOWI0ZjNlZGQ1YzkgKHJvb3RAYTJhYjY2M2Q5MzdlKSAoZ2NjIChEZWJpYW4g
MTAuMi4xLTYpIDEwLjIuMSAyMDIxMDExMCwgR05VIGxkIChHTlUgQmludXRpbHMgZm9yIERlYmlh
bikgMi4zNS4xKSAjMTM4IFNNUCBXZWQgRmViIDI0IDExOjI4OjE3IFVUQyAyMDIxCiAgICBb4oCm
XQogICAgWyAgICAwLjEwNjQyMl0gc21wYm9vdDogQ1BVMDogQU1EIFJ5emVuIDMgMjIwMEcgd2l0
aCBSYWRlb24gVmVnYSBHcmFwaGljcyAoZmFtaWx5OiAweDE3LCBtb2RlbDogMHgxMSwgc3RlcHBp
bmc6IDB4MCkKICAgIFvigKZdCiAgICBbICAgIDAuMjkxMjU3XSBwY2kgMDAwMDowMDowMC4yOiBB
TUQtVmk6IFVuYWJsZSB0byByZWFkL3dyaXRlIHRvIElPTU1VIHBlcmYgY291bnRlci4KICAgIFvi
gKZdCgpBbHNvLCBpdCBkb2VzIG5vdCBmaXggdGhlIHByb2JsZW0gb24gYW4gTVNJIEIzNTBNIE1P
UlRBUiB3aXRoIEFNRCBSeXplbgozIDIyMDBHIChldmVuIHdpdGggdGVuIHJldHJpZXMsIHJlc3Vs
dGluZyBpbiAyMDAgbXMgdGltZS1vdXQpLgoKICAgIFsgICAgMC40MDExNTJdIHBjaSAwMDAwOjAw
OjAwLjI6IEFNRC1WaTogVW5hYmxlIHRvIHJlYWQvd3JpdGUgdG8gSU9NTVUgcGVyZiBjb3VudGVy
LgoKQWRkaXRpb25hbGx5LCBhbHRlcm5hdGl2ZSBwcm9wb3NlZCBzb2x1dGlvbnMgWzFdIHdlcmUg
bm90IGNvbnNpZGVyZWQgb3IKZGlzY3Vzc2VkLgoKWzFdOiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9saW51eC1pb21tdS9hbHBpbmUuTE5YLjIuMjAuMTMuMjAwNjAzMDkzNTU3MC4zMTgxQG1vbm9w
b2QuaW50cmEuaXNwcmFzLnJ1LwoKQ2M6IFN1cmF2ZWUgU3V0aGlrdWxwYW5pdCA8c3VyYXZlZS5z
dXRoaWt1bHBhbml0QGFtZC5jb20+CkNjOiBUaiAoRWxsb2UgTGludXgpIDxtbC5saW51eEBlbGxv
ZS52aXNpb24+CkNjOiBTaHVhaCBLaGFuIDxza2hhbkBsaW51eGZvdW5kYXRpb24ub3JnPgpDYzog
QWxleGFuZGVyIE1vbmFrb3YgPGFtb25ha292QGlzcHJhcy5ydT4KQ2M6IERhdmlkIENvZSA8ZGF2
aWQuY29lQGxpdmUuY28udWs+CkNjOiBpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpT
aWduZWQtb2ZmLWJ5OiBQYXVsIE1lbnplbCA8cG1lbnplbEBtb2xnZW4ubXBnLmRlPgotLS0KIGRy
aXZlcnMvaW9tbXUvYW1kL2luaXQuYyB8IDQ1ICsrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAzNCBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2FtZC9pbml0LmMgYi9kcml2ZXJzL2lv
bW11L2FtZC9pbml0LmMKaW5kZXggOTEyNmVmY2JhZjJjLi5hZjE5NWYxMWQyNTQgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvaW9tbXUvYW1kL2luaXQuYworKysgYi9kcml2ZXJzL2lvbW11L2FtZC9pbml0
LmMKQEAgLTEyLDcgKzEyLDYgQEAKICNpbmNsdWRlIDxsaW51eC9hY3BpLmg+CiAjaW5jbHVkZSA8
bGludXgvbGlzdC5oPgogI2luY2x1ZGUgPGxpbnV4L2JpdG1hcC5oPgotI2luY2x1ZGUgPGxpbnV4
L2RlbGF5Lmg+CiAjaW5jbHVkZSA8bGludXgvc2xhYi5oPgogI2luY2x1ZGUgPGxpbnV4L3N5c2Nv
cmVfb3BzLmg+CiAjaW5jbHVkZSA8bGludXgvaW50ZXJydXB0Lmg+CkBAIC0yNTcsOCArMjU2LDYg
QEAgc3RhdGljIGVudW0gaW9tbXVfaW5pdF9zdGF0ZSBpbml0X3N0YXRlID0gSU9NTVVfU1RBUlRf
U1RBVEU7CiBzdGF0aWMgaW50IGFtZF9pb21tdV9lbmFibGVfaW50ZXJydXB0cyh2b2lkKTsKIHN0
YXRpYyBpbnQgX19pbml0IGlvbW11X2dvX3RvX3N0YXRlKGVudW0gaW9tbXVfaW5pdF9zdGF0ZSBz
dGF0ZSk7CiBzdGF0aWMgdm9pZCBpbml0X2RldmljZV90YWJsZV9kbWEodm9pZCk7Ci1zdGF0aWMg
aW50IGlvbW11X3BjX2dldF9zZXRfcmVnKHN0cnVjdCBhbWRfaW9tbXUgKmlvbW11LCB1OCBiYW5r
LCB1OCBjbnRyLAotCQkJCXU4IGZ4biwgdTY0ICp2YWx1ZSwgYm9vbCBpc193cml0ZSk7CiAKIHN0
YXRpYyBib29sIGFtZF9pb21tdV9wcmVfZW5hYmxlZCA9IHRydWU7CiAKQEAgLTE3MTcsMTEgKzE3
MTQsMTMgQEAgc3RhdGljIGludCBfX2luaXQgaW5pdF9pb21tdV9hbGwoc3RydWN0IGFjcGlfdGFi
bGVfaGVhZGVyICp0YWJsZSkKIAlyZXR1cm4gMDsKIH0KIAotc3RhdGljIHZvaWQgX19pbml0IGlu
aXRfaW9tbXVfcGVyZl9jdHIoc3RydWN0IGFtZF9pb21tdSAqaW9tbXUpCitzdGF0aWMgaW50IGlv
bW11X3BjX2dldF9zZXRfcmVnKHN0cnVjdCBhbWRfaW9tbXUgKmlvbW11LCB1OCBiYW5rLCB1OCBj
bnRyLAorCQkJCXU4IGZ4biwgdTY0ICp2YWx1ZSwgYm9vbCBpc193cml0ZSk7CisKK3N0YXRpYyB2
b2lkIGluaXRfaW9tbXVfcGVyZl9jdHIoc3RydWN0IGFtZF9pb21tdSAqaW9tbXUpCiB7Ci0JaW50
IHJldHJ5OwogCXN0cnVjdCBwY2lfZGV2ICpwZGV2ID0gaW9tbXUtPmRldjsKLQl1NjQgdmFsID0g
MHhhYmNkLCB2YWwyID0gMCwgc2F2ZV9yZWcsIHNhdmVfc3JjOworCXU2NCB2YWwgPSAweGFiY2Qs
IHZhbDIgPSAwLCBzYXZlX3JlZyA9IDA7CiAKIAlpZiAoIWlvbW11X2ZlYXR1cmUoaW9tbXUsIEZF
QVRVUkVfUEMpKQogCQlyZXR1cm47CkBAIC0xNzI5LDM5ICsxNzI4LDE3IEBAIHN0YXRpYyB2b2lk
IF9faW5pdCBpbml0X2lvbW11X3BlcmZfY3RyKHN0cnVjdCBhbWRfaW9tbXUgKmlvbW11KQogCWFt
ZF9pb21tdV9wY19wcmVzZW50ID0gdHJ1ZTsKIAogCS8qIHNhdmUgdGhlIHZhbHVlIHRvIHJlc3Rv
cmUsIGlmIHdyaXRhYmxlICovCi0JaWYgKGlvbW11X3BjX2dldF9zZXRfcmVnKGlvbW11LCAwLCAw
LCAwLCAmc2F2ZV9yZWcsIGZhbHNlKSB8fAotCSAgICBpb21tdV9wY19nZXRfc2V0X3JlZyhpb21t
dSwgMCwgMCwgOCwgJnNhdmVfc3JjLCBmYWxzZSkpCi0JCWdvdG8gcGNfZmFsc2U7Ci0KLQkvKgot
CSAqIERpc2FibGUgcG93ZXIgZ2F0aW5nIGJ5IHByb2dyYW1pbmcgdGhlIHBlcmZvcm1hbmNlIGNv
dW50ZXIKLQkgKiBzb3VyY2UgdG8gMjAgKGkuZS4gY291bnRzIHRoZSByZWFkcyBhbmQgd3JpdGVz
IGZyb20vdG8gSU9NTVUKLQkgKiBSZXNlcnZlZCBSZWdpc3RlciBbTU1JTyBPZmZzZXQgMUZGOGhd
IHRoYXQgYXJlIGlnbm9yZWQuKSwKLQkgKiB3aGljaCBuZXZlciBnZXQgaW5jcmVtZW50ZWQgZHVy
aW5nIHRoaXMgaW5pdCBwaGFzZS4KLQkgKiAoTm90ZTogVGhlIGV2ZW50IGlzIGFsc28gZGVwcmVj
YXRlZC4pCi0JICovCi0JdmFsID0gMjA7Ci0JaWYgKGlvbW11X3BjX2dldF9zZXRfcmVnKGlvbW11
LCAwLCAwLCA4LCAmdmFsLCB0cnVlKSkKKwlpZiAoaW9tbXVfcGNfZ2V0X3NldF9yZWcoaW9tbXUs
IDAsIDAsIDAsICZzYXZlX3JlZywgZmFsc2UpKQogCQlnb3RvIHBjX2ZhbHNlOwogCiAJLyogQ2hl
Y2sgaWYgdGhlIHBlcmZvcm1hbmNlIGNvdW50ZXJzIGNhbiBiZSB3cml0dGVuIHRvICovCi0JdmFs
ID0gMHhhYmNkOwotCWZvciAocmV0cnkgPSA1OyByZXRyeTsgcmV0cnktLSkgewotCQlpZiAoaW9t
bXVfcGNfZ2V0X3NldF9yZWcoaW9tbXUsIDAsIDAsIDAsICZ2YWwsIHRydWUpIHx8Ci0JCSAgICBp
b21tdV9wY19nZXRfc2V0X3JlZyhpb21tdSwgMCwgMCwgMCwgJnZhbDIsIGZhbHNlKSB8fAotCQkg
ICAgdmFsMikKLQkJCWJyZWFrOwotCi0JCS8qIFdhaXQgYWJvdXQgMjAgbXNlYyBmb3IgcG93ZXIg
Z2F0aW5nIHRvIGRpc2FibGUgYW5kIHJldHJ5LiAqLwotCQltc2xlZXAoMjApOwotCX0KLQotCS8q
IHJlc3RvcmUgKi8KLQlpZiAoaW9tbXVfcGNfZ2V0X3NldF9yZWcoaW9tbXUsIDAsIDAsIDAsICZz
YXZlX3JlZywgdHJ1ZSkgfHwKLQkgICAgaW9tbXVfcGNfZ2V0X3NldF9yZWcoaW9tbXUsIDAsIDAs
IDgsICZzYXZlX3NyYywgdHJ1ZSkpCisJaWYgKChpb21tdV9wY19nZXRfc2V0X3JlZyhpb21tdSwg
MCwgMCwgMCwgJnZhbCwgdHJ1ZSkpIHx8CisJICAgIChpb21tdV9wY19nZXRfc2V0X3JlZyhpb21t
dSwgMCwgMCwgMCwgJnZhbDIsIGZhbHNlKSkgfHwKKwkgICAgKHZhbCAhPSB2YWwyKSkKIAkJZ290
byBwY19mYWxzZTsKIAotCWlmICh2YWwgIT0gdmFsMikKKwkvKiByZXN0b3JlICovCisJaWYgKGlv
bW11X3BjX2dldF9zZXRfcmVnKGlvbW11LCAwLCAwLCAwLCAmc2F2ZV9yZWcsIHRydWUpKQogCQln
b3RvIHBjX2ZhbHNlOwogCiAJcGNpX2luZm8ocGRldiwgIklPTU1VIHBlcmZvcm1hbmNlIGNvdW50
ZXJzIHN1cHBvcnRlZFxuIik7Ci0tIAoyLjMwLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby9pb21tdQ==
