Return-Path: <SRS0=ZrTS=4T=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80664C3F2CD
	for <iommu@archiver.kernel.org>; Mon,  2 Mar 2020 18:23:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E30720842
	for <iommu@archiver.kernel.org>; Mon,  2 Mar 2020 18:23:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E30720842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lespocky.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1F14F8782E;
	Mon,  2 Mar 2020 18:23:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ll-f7R0TYBdB; Mon,  2 Mar 2020 18:23:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id BD8B385656;
	Mon,  2 Mar 2020 18:23:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 879F6C07FE;
	Mon,  2 Mar 2020 18:23:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6EC88C013E
 for <iommu@lists.linux-foundation.org>; Mon,  2 Mar 2020 18:22:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 57F3F204B5
 for <iommu@lists.linux-foundation.org>; Mon,  2 Mar 2020 18:22:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rVweS+YYMKEg for <iommu@lists.linux-foundation.org>;
 Mon,  2 Mar 2020 18:22:57 +0000 (UTC)
X-Greylist: delayed 00:05:26 by SQLgrey-1.7.6
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by silver.osuosl.org (Postfix) with ESMTPS id 11D2A2048F
 for <iommu@lists.linux-foundation.org>; Mon,  2 Mar 2020 18:22:56 +0000 (UTC)
Received: from methusalix.internal.home.lespocky.de ([109.250.99.45]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MhCq4-1jeKsj2SoM-00eP3P; Mon, 02 Mar 2020 19:16:51 +0100
Received: from lemmy.internal.home.lespocky.de ([192.168.243.175]
 helo=lemmy.home.lespocky.de)
 by methusalix.internal.home.lespocky.de with esmtpsa
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256) (Exim 4.92.3)
 (envelope-from <alex@home.lespocky.de>)
 id 1j8pcV-00019g-Di; Mon, 02 Mar 2020 19:16:48 +0100
Received: (nullmailer pid 21156 invoked by uid 2001);
 Mon, 02 Mar 2020 18:16:47 -0000
From: Alexander Dahl <post@lespocky.de>
To: x86@kernel.org
Subject: [PATCH] dma: Fix max PFN arithmetic overflow on 32 bit systems
Date: Mon,  2 Mar 2020 19:16:12 +0100
Message-Id: <20200302181612.20597-1-post@lespocky.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Scan-Signature: 7719f4cb0a203ae1a5f64d3866c1573d
X-Provags-ID: V03:K1:8B37tE9F2d8izwA/UGPTWbhBuKeo+jRutJy6I7/WLDKVHQsW/DV
 iO1kegFF2RaNOdoRni9TU0dRHbMUJ+9k6MAoADpjWanR5E/IJ3yKmUSHB9nQTMtU4j0mFzk
 Kj8TCvHP9wnYrUG2gIITeaGUAaDG8HcLt0iTCr9RT+VCz1KwuWOtQRu4sWCTBRz3y/XCza/
 qxffYem9wHCi6lbSMMYnw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mCV6oPdgR1g=:AMaQ5z0n3jcoDdduxw4s+T
 nay0jQTDWYylLD2JAQ7zOt0/i9+xW55XWjicHuaMJXnBcKEtHXNv2OlyjgqmWnIbSK0i+rMOi
 WUAzknOw0ElobL/8usoqhXnZZjoa6g9I6Z/zEutmSDHAjL1PwNot/qVEshkLcSGhCGLDwsZkZ
 A399FweDxdXsWhJLJoPC8gy+fL4gofq7HLf3klvUcAyON0kRTRWp+mb0Z3ObZlULdiCrlDH07
 E7atET9c8iuUdUtWeLUtWppx2Yz6U0WeHq0kF662noV7UINuWKXTAT84bb8pbFlmvgb9BJTPd
 6EGKlGpMqTO2P/GD4yx26kcbGvykgtepSSkSL0x+HYzSRxFhdfTXyVYP72k01qgkb5v6L3fRy
 n1h1GcZlOsJ/x3vqq/+WgjekTca/Ar0e/a1sYLmYWiGpUrmJMw1D7S9cqdHUl3+lHY+AQTBou
 aW8psMI7+FW5/lhJLoGBUKItKcy4d7xSb90t6uT4PlXXPEvFyY9NXOldz5B3FXaLsEcKu+SZ8
 x47paBapG+7yBAlkevqsSXRrM3to+uNy71EJV4Bm6tMLVKoC7FaXY0IFC7XzTLBvlaDlew9B5
 JAMtX3Kf9LEARQuhCXmKvXY7f+UHnYZSp2kXXo4r2KszKKF5bq/ty6XByDJ2+qNE93udmd0Ff
 8nHppJPd6yJZXFFO2p6jNrykEfZQaQPq+e8v1yj9etKeK6Ow5lIiAbAFzVkmOghqtk+JpCadW
 GIftO+w5wVzjxOjeoCxGN2zqMwonQTTPmuiojor/sJc0hw6v6k91GSYc6nbaG+o9OhQC4nySd
 xyDCU4WigapknXSD29Cy4vfuaVNFcLglCIBzSvkWq6EvRM3viEJCT5Ck1rGE8lKTcBm13xF
Cc: Alan Jenkins <alan.christopher.jenkins@gmail.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
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

Rm9yIEFSQ0g9eDg2ICgzMiBiaXQpIHdoZW4geW91IHNldCBDT05GSUdfSU9NTVVfSU5URUwgc2lu
Y2UgYzVhNWRjNGNiYmY0CigiaW9tbXUvdnQtZDogRG9uJ3Qgc3dpdGNoIG9mZiBzd2lvdGxiIGlm
IGJvdW5jZSBwYWdlIGlzIHVzZWQiKSB0aGVyZSdzCmEgZGVwZW5kZW5jeSBvbiBDT05GSUdfU1dJ
T1RMQiwgd2hpY2ggd2FzIG5vdCBuZWNlc3NhcmlseSBhY3RpdmUgYmVmb3JlLgoKVGhlIGluaXQg
Y29kZSBmb3Igc3dpb3RsYiBpbiAncGNpX3N3aW90bGJfZGV0ZWN0XzRnYigpJyBjb21wYXJlcwpz
b21ldGhpbmcgYWdhaW5zdCBNQVhfRE1BMzJfUEZOIHRvIGRlY2lkZSBpZiBpdCBzaG91bGQgYmUg
YWN0aXZlLgpIb3dldmVyIHRoYXQgZGVmaW5lIHN1ZmZlcnMgZnJvbSBhbiBhcml0aG1ldGljIG92
ZXJmbG93IHNpbmNlCjFiN2UwM2VmNzU3MCAoIng4NiwgTlVNQTogRW5hYmxlIGVtdWxhdGlvbiBv
biAzMmJpdCB0b28iKSB3aGVuIGl0IHdhcwpmaXJzdCBtYWRlIHZpc2libGUgdG8geDg2XzMyLgoK
VGhlIGVmZmVjdCBpcyBhdCBib290IHRpbWUgNjQgTWlCIChkZWZhdWx0IHNpemUpIHdlcmUgYWxs
b2NhdGVkIGZvcgpib3VuY2UgYnVmZmVycyBub3csIHdoaWNoIGlzIGEgbm90aWNlYWJsZSBhbW91
bnQgb2YgbWVtb3J5IG9uIHNtYWxsCnN5c3RlbXMuIFdlIG5vdGljZWQgdGhpcyBlZmZlY3Qgb24g
dGhlIGZsaTRsIExpbnV4IGRpc3RyaWJ1dGlvbiB3aGVuCm1pZ3JhdGluZyBmcm9tIGtlcm5lbCB2
NC4xOSAoTFRTKSB0byB2NS40IChMVFMpIG9uIGJvYXJkcyBsaWtlIHBjZW5naW5lcwpBTElYIDJE
MyB3aXRoIDI1NiBNaUIgbWVtb3J5IGZvciBleGFtcGxlOgoKICBMaW51eCB2ZXJzaW9uIDUuNC4y
MiAoYnVpbGRyb290QGJ1aWxkcm9vdCkgKGdjYyB2ZXJzaW9uIDcuMy4wIChCdWlsZHJvb3QgMjAx
OC4wMi44KSkgIzEgU01QIE1vbiBOb3YgMjYgMjM6NDA6MDAgQ0VUIDIwMTgKICDigKYKICBNZW1v
cnk6IDE4MzQ4NEsvMjYxNzU2SyBhdmFpbGFibGUgKDQ1OTRLIGtlcm5lbCBjb2RlLCAzOTNLIHJ3
ZGF0YSwgMTY2MEsgcm9kYXRhLCA1MzZLIGluaXQsIDQ1NksgYnNzICwgNzgyNzJLIHJlc2VydmVk
LCAwSyBjbWEtcmVzZXJ2ZWQsIDBLIGhpZ2htZW0pCiAg4oCmCiAgUENJLURNQTogVXNpbmcgc29m
dHdhcmUgYm91bmNlIGJ1ZmZlcmluZyBmb3IgSU8gKFNXSU9UTEIpCiAgc29mdHdhcmUgSU8gVExC
OiBtYXBwZWQgW21lbSAweDBiYjc4MDAwLTB4MGZiNzgwMDBdICg2NE1CKQoKVGhlIGluaXRpYWwg
YW5hbHlzaXMgYW5kIHRoZSBzdWdnZXN0ZWQgZml4IHdhcyBkb25lIGJ5IHVzZXIgJ3NvdXJjZWpl
ZGknCmF0IHN0YWNrb3ZlcmZsb3cgYW5kIGV4cGxpY2l0bHkgbWFya2VkIGFzIEdQTHYyIGZvciBp
bmNsdXNpb24gaW4gdGhlCkxpbnV4IGtlcm5lbDoKCiAgaHR0cHM6Ly91bml4LnN0YWNrZXhjaGFu
Z2UuY29tL2EvNTIwNTI1LzUwMDA3CgpGaXhlczogaHR0cHM6Ly93ZWIubmV0dHdvcmtzLm9yZy9i
dWdzL2Jyb3dzZS9GRkwtMjU2MApGaXhlczogaHR0cHM6Ly91bml4LnN0YWNrZXhjaGFuZ2UuY29t
L3EvNTIwMDY1LzUwMDA3ClN1Z2dlc3RlZC1ieTogQWxhbiBKZW5raW5zIDxhbGFuLmNocmlzdG9w
aGVyLmplbmtpbnNAZ21haWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kZXIgRGFobCA8cG9z
dEBsZXNwb2NreS5kZT4KLS0tCldlIHRlc3RlZCB0aGlzIGluIHFlbXUgYW5kIG9uIHJlYWwgaGFy
ZHdhcmUgd2l0aCBmbGk0bCBvbiB0b3Agb2YgdjUuNCwKdjUuNSwgYW5kIHY1LjYtcmMga2VybmVs
cywgYnV0IG9ubHkgYXMgZmFyIGFzIHRoZSByZXNlcnZlZCBtZW1vcnkgZ29lcy4KVGhlIHBhdGNo
IGl0c2VsZiBpcyBiYXNlZCBvbiB2NS42LXJjMyAoSUlSQykuCgpBIHF1aWNrIGdyZXAgb3ZlciB0
aGUga2VybmVsIGNvZGUgc2hvd2VkIG1lIHRoaXMgZGVmaW5lIE1BWF9ETUEzMl9QRk4gaXMKdXNl
ZCBpbiBvdGhlciBwbGFjZXMgYXMgd2VsbC4gSSB3b3VsZCBhcHByZWNpYXRlIGZlZWRiYWNrIG9u
IHRoaXMsCmJlY2F1c2UgSSBjYW4gbm90IG92ZXJzZWUgYWxsIHNpZGUgZWZmZWN0cyB0aGlzIG1p
Z2h0IGhhdmU/IQoKVGhhbmtzIGFnYWluIHRvIEFsYW4gd2hvIHByb3Bvc2VkIHRoZSBmaXgsIGFu
ZCBmb3IgaGlzIHBlcm1pc3Npb24gdG8Kc2VuZCBpdCB1cHN0cmVhbS4KCkdyZWV0cwpBbGV4Ci0t
LQogYXJjaC94ODYvaW5jbHVkZS9hc20vZG1hLmggfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRl
L2FzbS9kbWEuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2RtYS5oCmluZGV4IDAwZjdjZjQ1ZTY5
OS4uZTI1NTE0ZWNhOGQ2IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9kbWEuaAor
KysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9kbWEuaApAQCAtNzQsNyArNzQsNyBAQAogI2RlZmlu
ZSBNQVhfRE1BX1BGTiAgICgoMTZVTCAqIDEwMjQgKiAxMDI0KSA+PiBQQUdFX1NISUZUKQogCiAv
KiA0R0IgYnJva2VuIFBDSS9BR1AgaGFyZHdhcmUgYnVzIG1hc3RlciB6b25lICovCi0jZGVmaW5l
IE1BWF9ETUEzMl9QRk4gKCg0VUwgKiAxMDI0ICogMTAyNCAqIDEwMjQpID4+IFBBR0VfU0hJRlQp
CisjZGVmaW5lIE1BWF9ETUEzMl9QRk4gKDRVTCAqICgoMTAyNCAqIDEwMjQgKiAxMDI0KSA+PiBQ
QUdFX1NISUZUKSkKIAogI2lmZGVmIENPTkZJR19YODZfMzIKIC8qIFRoZSBtYXhpbXVtIGFkZHJl
c3MgdGhhdCB3ZSBjYW4gcGVyZm9ybSBhIERNQSB0cmFuc2ZlciB0byBvbiB0aGlzIHBsYXRmb3Jt
ICovCi0tIAoyLjIwLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21t
dQ==
