Return-Path: <SRS0=fnBl=5G=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D00FC4332D
	for <iommu@archiver.kernel.org>; Sat, 21 Mar 2020 18:29:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A8A720714
	for <iommu@archiver.kernel.org>; Sat, 21 Mar 2020 18:29:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A8A720714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lespocky.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E0F6086813;
	Sat, 21 Mar 2020 18:29:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WhXzuHnEKF2L; Sat, 21 Mar 2020 18:29:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1AB398623B;
	Sat, 21 Mar 2020 18:29:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08017C089F;
	Sat, 21 Mar 2020 18:29:56 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 387D7C07FF
 for <iommu@lists.linux-foundation.org>; Sat, 21 Mar 2020 18:29:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 26D5E20381
 for <iommu@lists.linux-foundation.org>; Sat, 21 Mar 2020 18:29:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DWO3+4wuLiod for <iommu@lists.linux-foundation.org>;
 Sat, 21 Mar 2020 18:29:52 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by silver.osuosl.org (Postfix) with ESMTPS id 102BB20336
 for <iommu@lists.linux-foundation.org>; Sat, 21 Mar 2020 18:29:51 +0000 (UTC)
Received: from methusalix.internal.home.lespocky.de ([109.250.103.118]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N3KgE-1jO4nw26K2-010MvO; Sat, 21 Mar 2020 19:29:14 +0100
Received: from lemmy.internal.home.lespocky.de ([192.168.243.175]
 helo=lemmy.home.lespocky.de)
 by methusalix.internal.home.lespocky.de with esmtpsa
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256) (Exim 4.92.3)
 (envelope-from <alex@home.lespocky.de>)
 id 1jFirv-0001nE-5w; Sat, 21 Mar 2020 19:29:12 +0100
Received: (nullmailer pid 2075 invoked by uid 2001);
 Sat, 21 Mar 2020 18:29:10 -0000
From: Alexander Dahl <post@lespocky.de>
To: x86@kernel.org
Subject: [PATCH v2] dma: Fix max PFN arithmetic overflow on 32 bit systems
Date: Sat, 21 Mar 2020 19:28:23 +0100
Message-Id: <20200321182823.1912-1-post@lespocky.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200319153154.usbqsk6uspegw5pr@falbala.internal.home.lespocky.de>
References: <20200319153154.usbqsk6uspegw5pr@falbala.internal.home.lespocky.de>
MIME-Version: 1.0
X-Scan-Signature: 2e89b8130284c79aa2484230574bb425
X-Provags-ID: V03:K1:BwocxLOhIIXx/bGnuVJFUi7zAE50Mb5DLFLlyuLG5Ay844jcgwI
 LQmCr8a3NyIY70JC5hnQ/5YRx7Zm3RKsrlAPyyXV2/6EUM31EZdZnbqYpbZZOFqiYV3fpzq
 PLEL8udppjzIByLsmu9NcHIS0o7vE9vl/d0mg0e8xLeky46vfdORyXdl3P5g6TIKHqv3SJT
 6yRaH1Iw2QZ/X/SnVBxhg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dmeT3XHEs7M=:2/5OPJDlT0razmHb6Xylsw
 Qw5t6oz4xwqNi13QsjhqSLhuPw5FsDeogLiMe7+tXP82d80tn0gNX05wFxZksNoOzuGc3rPGo
 x4YOjGTuhtgXnoE8FmZhiOGUoFer4yfB9+U64sxyWmYK4nnhG5Dd+mhTqNqaCN291RwzrccMB
 /8HtB8G8qYIRg+9HRA8ovq4cqkKBPzKAB3sUWTBI3rEgcI2J/V/FUi/v/BylQygUFlSbY+p32
 iRUIFTopteboi3CO6ar4Lvkd8sMAAQZvLmJmwRHVU/YaKrNaW5vckRVZCsPB4MENpyquq+xV0
 aqo5WC4ETbg3UZYM9/rZU5of29NS4mLE9xl0HOb1HeTC7z+1OYhuHjpdP1WKlxP1ztm5icRPc
 mzS292sFD0ao5tUYHP75zARgE5FBf+LCBdFNCmUi6i6lOfmgwM9SJO9RZRG8z1Qf5CrUBokfc
 HnR1Cl8hJ03lPOiMRZhOQ3PHNzY85OTohzWLqt1wvwRmb/ey69a837x1rXsGOR0mhkKmdmEHK
 FbSPp0lSMumvLTqaaVlotW4iq1clfHjM6B+tSHfIHNSqqHitz8hb00sj6IfaVRcKHqgX871s+
 yLkiR/M+wNecaazkQrzHGJL64ki3K2gDf5dqgHcLgWnzpIIiORPE6zTvYY0neBYc4A4glkJLg
 Uqq0RJizwlaJBtGHswNEhqcUbXVBER4FFNRA/MaKoo36f/nyTpzBo/5FPmgGHFVQYSup+pmOK
 +rwOqP+QXnW5b00VKgiALPW4qv9Npsffv1DPmVjGSTR8VyL5FXtnQhzTiYVkXoGFGjrTbONDV
 DkXxOyAIicJikQg0Z0iJWuopKLO+CSMdecpKYgMbFMwFfyAz+4KaZWGfszalTxAZRUOS0yi
Cc: Alexander Dahl <post@lespocky.de>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org,
 Alan Jenkins <alan.christopher.jenkins@gmail.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
 Robin Murphy <robin.murphy@arm.com>
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
Z2UuY29tL2EvNTIwNTI1LzUwMDA3CgpUaGUgYWN0dWFsIGNhbGN1bGF0aW9uIGhvd2V2ZXIgaXMg
dGhlIHNhbWUgYXMgZm9yIGFyY2gvbWlwcyBub3cgYXMKc3VnZ2VzdGVkIGJ5IFJvYmluIE11cnBo
eS4KCkZpeGVzOiBodHRwczovL3dlYi5uZXR0d29ya3Mub3JnL2J1Z3MvYnJvd3NlL0ZGTC0yNTYw
CkZpeGVzOiBodHRwczovL3VuaXguc3RhY2tleGNoYW5nZS5jb20vcS81MjAwNjUvNTAwMDcKUmVw
b3J0ZWQtYnk6IEFsYW4gSmVua2lucyA8YWxhbi5jaHJpc3RvcGhlci5qZW5raW5zQGdtYWlsLmNv
bT4KU3VnZ2VzdGVkLWJ5OiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPgpTaWdu
ZWQtb2ZmLWJ5OiBBbGV4YW5kZXIgRGFobCA8cG9zdEBsZXNwb2NreS5kZT4KLS0tCgpOb3RlczoK
ICAgIHYxIC0+IHYyOgogICAgICAtIHVzZSB0aGUgc2FtZSBjYWxjdWxhdGlvbiBhcyB3aXRoIGFy
Y2gvbWlwcyAoUm9iaW4gTXVycGh5KQoKIGFyY2gveDg2L2luY2x1ZGUvYXNtL2RtYS5oIHwgMiAr
LQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0t
Z2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vZG1hLmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9k
bWEuaAppbmRleCAwMGY3Y2Y0NWU2OTkuLjhlOTVhYTRiMGQxNyAxMDA2NDQKLS0tIGEvYXJjaC94
ODYvaW5jbHVkZS9hc20vZG1hLmgKKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vZG1hLmgKQEAg
LTc0LDcgKzc0LDcgQEAKICNkZWZpbmUgTUFYX0RNQV9QRk4gICAoKDE2VUwgKiAxMDI0ICogMTAy
NCkgPj4gUEFHRV9TSElGVCkKIAogLyogNEdCIGJyb2tlbiBQQ0kvQUdQIGhhcmR3YXJlIGJ1cyBt
YXN0ZXIgem9uZSAqLwotI2RlZmluZSBNQVhfRE1BMzJfUEZOICgoNFVMICogMTAyNCAqIDEwMjQg
KiAxMDI0KSA+PiBQQUdFX1NISUZUKQorI2RlZmluZSBNQVhfRE1BMzJfUEZOICgxVUwgPDwgKDMy
IC0gUEFHRV9TSElGVCkpCiAKICNpZmRlZiBDT05GSUdfWDg2XzMyCiAvKiBUaGUgbWF4aW11bSBh
ZGRyZXNzIHRoYXQgd2UgY2FuIHBlcmZvcm0gYSBETUEgdHJhbnNmZXIgdG8gb24gdGhpcyBwbGF0
Zm9ybSAqLwotLSAKMi4yMC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
aW9tbXU=
