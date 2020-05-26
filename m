Return-Path: <SRS0=1lY2=7I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EBFC433DF
	for <iommu@archiver.kernel.org>; Tue, 26 May 2020 18:10:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0387220674
	for <iommu@archiver.kernel.org>; Tue, 26 May 2020 18:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0387220674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lespocky.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9D50F847DE;
	Tue, 26 May 2020 18:10:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a7Xip34cXkiv; Tue, 26 May 2020 18:10:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4E30C81E69;
	Tue, 26 May 2020 18:09:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2F5F7C0888;
	Tue, 26 May 2020 18:09:28 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 769CDC016F
 for <iommu@lists.linux-foundation.org>; Tue, 26 May 2020 18:09:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6647420554
 for <iommu@lists.linux-foundation.org>; Tue, 26 May 2020 18:09:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oCA2hStRjp4W for <iommu@lists.linux-foundation.org>;
 Tue, 26 May 2020 18:09:24 +0000 (UTC)
X-Greylist: delayed 00:05:34 by SQLgrey-1.7.6
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by silver.osuosl.org (Postfix) with ESMTPS id 3BFCF2041C
 for <iommu@lists.linux-foundation.org>; Tue, 26 May 2020 18:09:23 +0000 (UTC)
Received: from methusalix.internal.home.lespocky.de ([92.117.38.248]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MqbDs-1jHnZO2ljU-00mdJw; Tue, 26 May 2020 20:02:54 +0200
Received: from lemmy.internal.home.lespocky.de ([192.168.243.176]
 helo=lemmy.home.lespocky.de)
 by methusalix.internal.home.lespocky.de with esmtpsa (TLS1.3) tls
 TLS_AES_256_GCM_SHA384 (Exim 4.93.0.4)
 (envelope-from <alex@home.lespocky.de>)
 id 1jddub-00014I-G9; Tue, 26 May 2020 20:02:51 +0200
Received: (nullmailer pid 21056 invoked by uid 2001);
 Tue, 26 May 2020 18:02:49 -0000
From: Alexander Dahl <post@lespocky.de>
To: x86@kernel.org
Subject: [PATCH v3] dma: Fix max PFN arithmetic overflow on 32 bit systems
Date: Tue, 26 May 2020 19:57:49 +0200
Message-Id: <20200526175749.20742-1-post@lespocky.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Scan-Signature: da60a1f87c2bd0fec1a92ee75d71daf0
X-Provags-ID: V03:K1:RU0d4InmKG43aVsuzP1TdFNT000xXVh0lJi3Xhuudqtalhc25M0
 xrTsa0sXhkoBbi8Bf1GXwburAlDeTBs8b6toisYHzR8wvRgJ9w6m1JjofqU/liNHR6hqt7/
 48hSjW2bZCgyFjEyQP4mMduSvaLpBlu05UWXNnR6Fxz5SwsUCre6es2vOz66+/LQMSknaHT
 CYpOOaghPKt40QB77o+3Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:a9rBkMBD85I=:Bq8l83ZLcQLZsuxKvyWeRM
 E/vLqqzppvLQBjo+sR9nh2uQFNNMoRaWro8878Lg5ySQRRZGQ7b2oXtc/TLtIacVrZ1I9pajB
 RwAGng2AiDugmYy8ntvlZ8AS0BN3PoySN9n7kgnhgHngdkK67jTN1LdJ0z2Du6+3ER5EErs9S
 CzKSTUwvNAik8aluoX7nGAlRwEjrbcCBhZNuyEaiKXly/hwynMYIokLtoanSkVDKHQ2m2Dah1
 Nn/J+VKZENNKlNL0PEMXJMCCwy4tuIVQhcMBxPem1k9z2v+8YzPTOdQgGPpWk1XsFD3t7ZCqe
 tAX/eQTvXZ+s3bswJsn1BrLQsShvbB452Bd3aeahwEbeeEYS86ORis+44r2NFDu6s3qhvsIFJ
 dYVHsffxSfiarHEsUuF14iy51yoFc2vx6Pngksa26FRRAPoFyzVS8rsQk+Aou2rt93TcyqWtL
 nFH9vEOhLG8aiUTAHd6iVS4nVDKtrejezlmmQmnWTeeIGhjMbTtHI1PYp+WwX+uU4njfOGYzK
 YEKS5n+txEMoJME2AM9aZYloelXAaQqYUN7yfxIOUnGoHGj3qYoP5xFw7mhWhNCUPAXvXoOEN
 HoLQil2jMBIrtZkQKjpU1xZl7S+gJ3jy8u83Kn5uR754zVibJl1P+n/ODUwpJZxXc6RFxy1jZ
 auMwTRfiVPEDl1xPuJNmG0FZDLO9hISdSXZsw9rCHNpVunofiljfr/k7Mgpen0ma66GKbCAhQ
 jRac0Zpmxs2hhE5DssUxSeJ5Ry+MFadPS6gBH/Ut8VowsDJzaW/Oea/Ca6noRn3yKg2C4L9pZ
 RqcJYjqRCPh8o9GwuLvxl1w1T+Hz/Gk4imeDPAV2NC3Te2YQrC+xrQrDV14ULrr8L3O9D2t
Cc: Alexander Dahl <post@lespocky.de>, iommu@lists.linux-foundation.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alan Jenkins <alan.christopher.jenkins@gmail.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
 Robin Murphy <robin.murphy@arm.com>,
 Florian Wolters <florian@florian-wolters.de>
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

VGhlIGludGVybWVkaWF0ZSByZXN1bHQgb2YgdGhlIG9sZCB0ZXJtICg0VUwgKiAxMDI0ICogMTAy
NCAqIDEwMjQpIGlzCjQgMjk0IDk2NyAyOTYgb3IgMHgxMDAwMDAwMDAgd2hpY2ggaXMgbm8gcHJv
YmxlbSBvbiA2NCBiaXQgc3lzdGVtcy4gIFRoZQpwYXRjaCBkb2VzIG5vdCBjaGFuZ2UgdGhlIGxh
dGVyIG92ZXJhbGwgcmVzdWx0IG9mIDB4MTAwMDAwIGZvcgpNQVhfRE1BMzJfUEZOLiAgVGhlIG5l
dyBjYWxjdWxhdGlvbiB5aWVsZHMgdGhlIHNhbWUgcmVzdWx0LCBidXQgZG9lcyBub3QKcmVxdWly
ZSA2NCBiaXQgYXJpdGhtZXRpYy4KCk9uIDMyIGJpdCBzeXN0ZW1zIHRoZSBvbGQgY2FsY3VsYXRp
b24gc3VmZmVycyBmcm9tIGFuIGFyaXRobWV0aWMKb3ZlcmZsb3cgaW4gdGhhdCBpbnRlcm1lZGlh
dGUgdGVybSBpbiBicmFjZXM6IDRVTCBha2EgdW5zaWduZWQgbG9uZyBpbnQKaXMgNCBieXRlIHdp
ZGUgYW5kIGFuIGFyaXRobWV0aWMgb3ZlcmZsb3cgaGFwcGVucyAodGhlIDB4MTAwMDAwMDAwIGRv
ZXMKbm90IGZpdCBpbiA0IGJ5dGVzKSwgdGhlIGluIGJyYWNlcyByZXN1bHQgaXMgdHJ1bmNhdGVk
IHRvIHplcm8sIHRoZQpmb2xsb3dpbmcgcmlnaHQgc2hpZnQgZG9lcyBub3QgYWx0ZXIgdGhhdCwg
c28gTUFYX0RNQTMyX1BGTiBldmFsdWF0ZXMgdG8KMCBvbiAzMiBiaXQgc3lzdGVtcy4KClRoYXQg
d3JvbmcgdmFsdWUgaXMgYSBwcm9ibGVtIGluIGEgY29tcGFyaXNpb24gYWdhaW5zdCBNQVhfRE1B
MzJfUEZOIGluCnRoZSBpbml0IGNvZGUgZm9yIHN3aW90bGIgaW4gJ3BjaV9zd2lvdGxiX2RldGVj
dF80Z2IoKScgdG8gZGVjaWRlIGlmCnN3aW90bGIgc2hvdWxkIGJlIGFjdGl2ZS4gIFRoYXQgY29t
cGFyaXNvbiB5aWVsZHMgdGhlIG9wcG9zaXRlIHJlc3VsdCwKd2hlbiBjb21waWxpbmcgb24gMzIg
Yml0IHN5c3RlbXMuCgpUaGlzIHdhcyBub3QgcG9zc2libGUgYmVmb3JlIDFiN2UwM2VmNzU3MCAo
Ing4NiwgTlVNQTogRW5hYmxlIGVtdWxhdGlvbgpvbiAzMmJpdCB0b28iKSB3aGVuIHRoYXQgTUFY
X0RNQTMyX1BGTiB3YXMgZmlyc3QgbWFkZSB2aXNpYmxlIHRvIHg4Nl8zMgooYW5kIHdoaWNoIGxh
bmRlZCBpbiB2My4wKS4KCkluIHByYWN0aWNlIHRoaXMgd2Fzbid0IGEgcHJvYmxlbSwgdW5sZXNz
IHlvdSBhY3RpdmF0ZWQgQ09ORklHX1NXSU9UTEIKb24geDg2ICgzMiBiaXQpLgoKSG93ZXZlciBm
b3IgQVJDSD14ODYgKDMyIGJpdCkgYW5kIGlmIHlvdSBoYXZlIHNldCBDT05GSUdfSU9NTVVfSU5U
RUwsCnNpbmNlIGM1YTVkYzRjYmJmNCAoImlvbW11L3Z0LWQ6IERvbid0IHN3aXRjaCBvZmYgc3dp
b3RsYiBpZiBib3VuY2UgcGFnZQppcyB1c2VkIikgdGhlcmUncyBhIGRlcGVuZGVuY3kgb24gQ09O
RklHX1NXSU9UTEIsIHdoaWNoIHdhcyBub3QKbmVjZXNzYXJpbHkgYWN0aXZlIGJlZm9yZS4gIFRo
YXQgbGFuZGVkIGluIHY1LjQsIHdoZXJlIHdlIG5vdGljZWQgaXQgaW4KdGhlIGZsaTRsIExpbnV4
IGRpc3RyaWJ1dGlvbi4gIFdlIGhhdmUgQ09ORklHX0lPTU1VX0lOVEVMIGFjdGl2ZSBvbiBib3Ro
CjMyIGFuZCA2NCBiaXQga2VybmVsIGNvbmZpZ3MgdGhlcmUgKEkgY291bGQgbm90IGZpbmQgb3V0
IHdoeSwgc28gbGV0J3MKanVzdCBzYXkgaGlzdG9yaWNhbCByZWFzb25zKS4KClRoZSBlZmZlY3Qg
aXMgYXQgYm9vdCB0aW1lIDY0IE1pQiAoZGVmYXVsdCBzaXplKSB3ZXJlIGFsbG9jYXRlZCBmb3IK
Ym91bmNlIGJ1ZmZlcnMgbm93LCB3aGljaCBpcyBhIG5vdGljZWFibGUgYW1vdW50IG9mIG1lbW9y
eSBvbiBzbWFsbApzeXN0ZW1zIGxpa2UgcGNlbmdpbmVzIEFMSVggMkQzIHdpdGggMjU2IE1pQiBt
ZW1vcnksIHdoaWNoIGFyZSBzdGlsbApmcmVxdWVudGx5IHVzZWQgYXMgaG9tZSByb3V0ZXJzLgoK
V2Ugbm90aWNlZCB0aGlzIGVmZmVjdCB3aGVuIG1pZ3JhdGluZyBmcm9tIGtlcm5lbCB2NC4xOSAo
TFRTKSB0byB2NS40CihMVFMpIGluIGZsaTRsIGFuZCBnb3QgdGhhdCBrZXJuZWwgbWVzc2FnZXMg
Zm9yIGV4YW1wbGU6CgogIExpbnV4IHZlcnNpb24gNS40LjIyIChidWlsZHJvb3RAYnVpbGRyb290
KSAoZ2NjIHZlcnNpb24gNy4zLjAgKEJ1aWxkcm9vdCAyMDE4LjAyLjgpKSAjMSBTTVAgTW9uIE5v
diAyNiAyMzo0MDowMCBDRVQgMjAxOAogIOKApgogIE1lbW9yeTogMTgzNDg0Sy8yNjE3NTZLIGF2
YWlsYWJsZSAoNDU5NEsga2VybmVsIGNvZGUsIDM5M0sgcndkYXRhLCAxNjYwSyByb2RhdGEsIDUz
NksgaW5pdCwgNDU2SyBic3MgLCA3ODI3MksgcmVzZXJ2ZWQsIDBLIGNtYS1yZXNlcnZlZCwgMEsg
aGlnaG1lbSkKICDigKYKICBQQ0ktRE1BOiBVc2luZyBzb2Z0d2FyZSBib3VuY2UgYnVmZmVyaW5n
IGZvciBJTyAoU1dJT1RMQikKICBzb2Z0d2FyZSBJTyBUTEI6IG1hcHBlZCBbbWVtIDB4MGJiNzgw
MDAtMHgwZmI3ODAwMF0gKDY0TUIpCgpUaGUgaW5pdGlhbCBhbmFseXNpcyBhbmQgdGhlIHN1Z2dl
c3RlZCBmaXggd2FzIGRvbmUgYnkgdXNlciAnc291cmNlamVkaScKYXQgc3RhY2tvdmVyZmxvdyBh
bmQgZXhwbGljaXRseSBtYXJrZWQgYXMgR1BMdjIgZm9yIGluY2x1c2lvbiBpbiB0aGUKTGludXgg
a2VybmVsOgoKICBodHRwczovL3VuaXguc3RhY2tleGNoYW5nZS5jb20vYS81MjA1MjUvNTAwMDcK
ClRoZSBuZXcgY2FsY3VsYXRpb24sIHdoaWNoIGRvZXMgbm90IHN1ZmZlciBmcm9tIHRoYXQgb3Zl
cmZsb3csIGlzIHRoZQpzYW1lIGFzIGZvciBhcmNoL21pcHMgbm93IGFzIHN1Z2dlc3RlZCBieSBS
b2JpbiBNdXJwaHkuCgpUaGUgZml4IHdhcyB0ZXN0ZWQgYnkgZmxpNGwgdXNlcnMgb24gcm91bmQg
YWJvdXQgdHdvIGRvemVuIGRpZmZlcmVudApzeXN0ZW1zLCBpbmNsdWRpbmcgYm90aCAzMiBhbmQg
NjQgYml0IGFyY2hzLCBiYXJlIG1ldGFsIGFuZCB2aXJ0dWFsaXplZAptYWNoaW5lcy4KCkZpeGVz
OiAxYjdlMDNlZjc1NzAgKCJ4ODYsIE5VTUE6IEVuYWJsZSBlbXVsYXRpb24gb24gMzJiaXQgdG9v
IikKRml4ZXM6IGh0dHBzOi8vd2ViLm5ldHR3b3Jrcy5vcmcvYnVncy9icm93c2UvRkZMLTI1NjAK
Rml4ZXM6IGh0dHBzOi8vdW5peC5zdGFja2V4Y2hhbmdlLmNvbS9xLzUyMDA2NS81MDAwNwpSZXBv
cnRlZC1ieTogQWxhbiBKZW5raW5zIDxhbGFuLmNocmlzdG9waGVyLmplbmtpbnNAZ21haWwuY29t
PgpTdWdnZXN0ZWQtYnk6IFJvYmluIE11cnBoeSA8cm9iaW4ubXVycGh5QGFybS5jb20+ClNpZ25l
ZC1vZmYtYnk6IEFsZXhhbmRlciBEYWhsIDxwb3N0QGxlc3BvY2t5LmRlPgpDYzogc3RhYmxlQHZn
ZXIua2VybmVsLm9yZwotLS0KCk5vdGVzOgogICAgdjM6CiAgICAgIC0gcmV3cml0dGVuIGNvbW1p
dCBtZXNzYWdlIHRvIGJldHRlciBleHBsYWluIHRoYXQgYXJpdGhtZXRpYyBvdmVyZmxvdwogICAg
ICAgIGFuZCBhZGRlZCBGaXhlcyB0YWcgKEdyZWcgS3JvYWgtSGFydG1hbikKICAgICAgLSByZWJh
c2VkIG9uIHY1LjctcmM3CiAgICAKICAgIHYyOgogICAgICAtIHVzZSB0aGUgc2FtZSBjYWxjdWxh
dGlvbiBhcyB3aXRoIGFyY2gvbWlwcyAoUm9iaW4gTXVycGh5KQoKIGFyY2gveDg2L2luY2x1ZGUv
YXNtL2RtYS5oIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vZG1hLmggYi9hcmNoL3g4
Ni9pbmNsdWRlL2FzbS9kbWEuaAppbmRleCAwMGY3Y2Y0NWU2OTkuLjhlOTVhYTRiMGQxNyAxMDA2
NDQKLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vZG1hLmgKKysrIGIvYXJjaC94ODYvaW5jbHVk
ZS9hc20vZG1hLmgKQEAgLTc0LDcgKzc0LDcgQEAKICNkZWZpbmUgTUFYX0RNQV9QRk4gICAoKDE2
VUwgKiAxMDI0ICogMTAyNCkgPj4gUEFHRV9TSElGVCkKIAogLyogNEdCIGJyb2tlbiBQQ0kvQUdQ
IGhhcmR3YXJlIGJ1cyBtYXN0ZXIgem9uZSAqLwotI2RlZmluZSBNQVhfRE1BMzJfUEZOICgoNFVM
ICogMTAyNCAqIDEwMjQgKiAxMDI0KSA+PiBQQUdFX1NISUZUKQorI2RlZmluZSBNQVhfRE1BMzJf
UEZOICgxVUwgPDwgKDMyIC0gUEFHRV9TSElGVCkpCiAKICNpZmRlZiBDT05GSUdfWDg2XzMyCiAv
KiBUaGUgbWF4aW11bSBhZGRyZXNzIHRoYXQgd2UgY2FuIHBlcmZvcm0gYSBETUEgdHJhbnNmZXIg
dG8gb24gdGhpcyBwbGF0Zm9ybSAqLwotLSAKMi4yMC4xCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vaW9tbXU=
