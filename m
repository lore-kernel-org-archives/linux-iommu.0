Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22228C43334
	for <iommu@archiver.kernel.org>; Fri, 10 Jun 2022 08:08:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A60F240CDB;
	Fri, 10 Jun 2022 08:08:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wze5kuoZQTgG; Fri, 10 Jun 2022 08:08:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 525DC404A0;
	Fri, 10 Jun 2022 08:08:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F8ECC002D;
	Fri, 10 Jun 2022 08:08:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2196FC002D
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jun 2022 08:08:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0395B40309
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jun 2022 08:08:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=baikalelectronics.ru
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GLBozzHBseBf for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jun 2022 08:08:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com
 [87.245.175.230])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2B47A410B4
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jun 2022 08:08:13 +0000 (UTC)
Received: from mail (mail.baikal.int [192.168.51.25])
 by mail.baikalelectronics.com (Postfix) with ESMTP id 9473516A0;
 Fri, 10 Jun 2022 11:08:57 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 9473516A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baikalelectronics.ru; s=mail; t=1654848540;
 bh=P0epdiQ2UfkKeER5KtOFqFsZ8/0xaqJ7ab4vUUQPTCw=;
 h=From:To:CC:Subject:Date:From;
 b=FES/RpZBcFEtKNYzfj2ZM1TKH3v4j1D1srCu1QFX0yo+vxrndl74dC/lOEO0AROoD
 E9WiAns/InODAMwuQ3yGDm0SYSUjNGDlAku4e4gJHtto+ZKLwtUZuRhTH6qiwi2G8o
 Wx1WzoKWULlo6KhIEebDed0WI8cU+7OfayCvYSmE=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 10 Jun 2022 11:08:05 +0300
To: Christoph Hellwig <hch@lst.de>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Vladimir
 Murzin <vladimir.murzin@arm.com>
Subject: [PATCH] dma-direct: take dma-ranges/offsets into account in resource
 mapping
Date: Fri, 10 Jun 2022 11:08:02 +0300
Message-ID: <20220610080802.11147-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Cc: Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>, David Airlie <airlied@linux.ie>,
 Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Linu Cherian <lcherian@marvell.com>, linux-renesas-soc@vger.kernel.org,
 Dave Jiang <dave.jiang@intel.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Magnus Damm <magnus.damm@gmail.com>, Srujana Challa <schalla@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>, Andy Gross <agross@kernel.org>,
 Sunil Goutham <sgoutham@marvell.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, Manivannan Sadhasivam <mani@kernel.org>,
 linux-arm-msm@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
 Arnaud Ebalard <arno@natisbad.org>,
 Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
 dmaengine@vger.kernel.org, ntb@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Boris Brezillon <bbrezillon@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Oded Gabbay <ogabbay@kernel.org>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 iommu@lists.linux-foundation.org, Serge Semin <fancer.lancer@gmail.com>,
 Li Yang <leoyang.li@nxp.com>, Serge Semin <Sergey.Semin@baikalelectronics.ru>,
 Vinod Koul <vkoul@kernel.org>, linux-crypto@vger.kernel.org,
 Alex Deucher <alexander.deucher@amd.com>, Shawn Guo <shawnguo@kernel.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Gerd Hoffmann <kraxel@redhat.com>
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
From: Serge Semin via iommu <iommu@lists.linux-foundation.org>
Reply-To: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

QSBiYXNpYyBkZXZpY2Utc3BlY2lmaWMgbGluZWFyIG1lbW9yeSBtYXBwaW5nIHdhcyBpbnRyb2R1
Y2VkIGJhY2sgaW4KY29tbWl0ICgiZG1hOiBUYWtlIGludG8gYWNjb3VudCBkbWFfcGZuX29mZnNl
dCIpIGFzIGEgc2luZ2xlLXZhbHVlZCBvZmZzZXQKcHJlc2VydmVkIGluIHRoZSBkZXZpY2UuZG1h
X3Bmbl9vZmZzZXQgZmllbGQsIHdoaWNoIHdhcyBpbml0aWFsaXplZCBmb3IKaW5zdGFuY2UgYnkg
bWVhbnMgb2YgdGhlICJkbWEtcmFuZ2VzIiBEVCBwcm9wZXJ0eS4gQWZ0ZXJ3YXJkcyB0aGUKZnVu
Y3Rpb25hbGl0eSB3YXMgZXh0ZW5kZWQgdG8gc3VwcG9ydCBtb3JlIHRoYW4gb25lIGRldmljZS1z
cGVjaWZpYyByZWdpb24KZGVmaW5lZCBpbiB0aGUgZGV2aWNlLmRtYV9yYW5nZV9tYXAgbGlzdCBv
ZiBtYXBzLiBCdXQgYWxsIG9mIHRoZXNlCmltcHJvdmVtZW50cyBjb25jZXJuZWQgYSBzaW5nbGUg
cG9pbnRlciwgcGFnZSBvciBzZyBETUEtbWFwcGluZyBtZXRob2RzLAp3aGlsZSB0aGUgc3lzdGVt
IHJlc291cmNlIG1hcHBpbmcgZnVuY3Rpb24gdHVybmVkIHRvIG1pc3MgdGhlCmNvcnJlc3BvbmRp
bmcgbW9kaWZpY2F0aW9uLiBUaHVzIHRoZSBkbWFfZGlyZWN0X21hcF9yZXNvdXJjZSgpIG1ldGhv
ZCBub3cKanVzdCBjYXN0cyB0aGUgQ1BVIHBoeXNpY2FsIGFkZHJlc3MgdG8gdGhlIGRldmljZSBE
TUEgYWRkcmVzcyB3aXRoIG5vCmRtYS1yYW5nZXMtYmFzZWQgbWFwcGluZyB0YWtpbmcgaW50byBh
Y2NvdW50LCB3aGljaCBpcyBvYnZpb3VzbHkgd3JvbmcuCkxldCdzIGZpeCBpdCBieSB1c2luZyB0
aGUgcGh5c190b19kbWFfZGlyZWN0KCkgbWV0aG9kIHRvIGdldCB0aGUKZGV2aWNlLXNwZWNpZmlj
IGJ1cyBhZGRyZXNzIGZyb20gdGhlIHBhc3NlZCBtZW1vcnkgcmVzb3VyY2UgZm9yIHRoZSBjYXNl
Cm9mIHRoZSBkaXJlY3RseSBtYXBwZWQgRE1BLgoKRml4ZXM6IDI1ZjFlMTg4NzA4OCAoImRtYTog
VGFrZSBpbnRvIGFjY291bnQgZG1hX3Bmbl9vZmZzZXQiKQpTaWduZWQtb2ZmLWJ5OiBTZXJnZSBT
ZW1pbiA8U2VyZ2V5LlNlbWluQGJhaWthbGVsZWN0cm9uaWNzLnJ1PgoKLS0tCgpBZnRlciBhIGxv
bmcgZGlzY3Vzc2lvbiB3aXRoIENocmlzdG9waCBhbmQgUm9iaW4gcmVnYXJkaW5nIHRoaXMgcGF0
Y2gKaGVyZToKaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIyMDMyNDAxNDgzNi4xOTE0
OS00LVNlcmdleS5TZW1pbkBiYWlrYWxlbGVjdHJvbmljcy5ydQphbmQgaGVyZQpodHRwczovL2xv
cmUua2VybmVsLm9yZy9saW51eC1wY2kvMjAyMjA1MDMyMjUxMDQuMTIxMDgtMi1TZXJnZXkuU2Vt
aW5AYmFpa2FsZWxlY3Ryb25pY3MucnUvCkl0IHdhcyBkZWNpZGVkIHRvIGNvbnN1bHQgd2l0aCB3
aWRlciBtYWludGFpbmVycyBhdWRpZW5jZSB3aGV0aGVyIGl0J3Mgb2sKdG8gYWNjZXB0IHRoZSBj
aGFuZ2UgYXMgaXMgb3IgYSBtb3JlIHNvcGhpc3RpY2F0ZWQgc29sdXRpb24gbmVlZHMgdG8gYmUK
Zm91bmQgZm9yIHRoZSBub24tbGluZWFyIGRpcmVjdCBNTUlPIG1hcHBpbmcuCgpDYzogQ2hyaXN0
b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+CkNjOiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBh
cm0uY29tPgpDYzogTWFuaXZhbm5hbiBTYWRoYXNpdmFtIDxtYW5pdmFubmFuLnNhZGhhc2l2YW1A
bGluYXJvLm9yZz4KCmZpbGU6IGFyY2gvYXJtL21hY2gtb3Jpb241eC9ib2FyZC1kdC5jCkNjOiBB
bmRyZXcgTHVubiA8YW5kcmV3QGx1bm4uY2g+CkNjOiBTZWJhc3RpYW4gSGVzc2VsYmFydGggPHNl
YmFzdGlhbi5oZXNzZWxiYXJ0aEBnbWFpbC5jb20+CkNjOiBHcmVnb3J5IENsZW1lbnQgPGdyZWdv
cnkuY2xlbWVudEBib290bGluLmNvbT4KQ2M6IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZwoKZmlsZTogZHJpdmVycy9jcnlwdG8vbWFydmVsbC9jZXNhL2Nlc2EuYwpDYzogU3J1
amFuYSBDaGFsbGEgPHNjaGFsbGFAbWFydmVsbC5jb20+CkNjOiBBcm5hdWQgRWJhbGFyZCA8YXJu
b0BuYXRpc2JhZC5vcmc+CkNjOiBCb3JpcyBCcmV6aWxsb24gPGJicmV6aWxsb25Aa2VybmVsLm9y
Zz4KQ2M6IGxpbnV4LWNyeXB0b0B2Z2VyLmtlcm5lbC5vcmcKCmZpbGU6IGRyaXZlcnMvZG1hL3tm
c2wtZWRtYS1jb21tb24uYyxwbDMzMC5jLHNoL3JjYXItZG1hYy5jfQpDYzogVmlub2QgS291bCA8
dmtvdWxAa2VybmVsLm9yZz4KQ2M6IGRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmcKCmZpbGU6IGFy
Y2gvYXJtL2Jvb3QvZHRzL3t2Znh4eC5kdHNpLGxzMTAyMWEuZHRzaSxpbXg3dWxwLmR0c2ksZnNs
LWxzMTA0M2EuZHRzaX0KQ2M6IFNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz4KQ2M6IFNh
c2NoYSBIYXVlciA8cy5oYXVlckBwZW5ndXRyb25peC5kZT4KQ2M6IExpIFlhbmcgPGxlb3lhbmcu
bGlAbnhwLmNvbT4KQ2M6IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwoKZmls
ZTogYXJjaC9hcm0vYm9vdC9kdHMvcjhhNzcqLmR0c2ksIGFyY2gvYXJtNjQvYm9vdC9kdHMvcmVu
ZXNhcy9yOGE3NyouZHRzaQpDYzogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2FzQGds
aWRlci5iZT4KQ2M6IE1hZ251cyBEYW1tIDxtYWdudXMuZGFtbUBnbWFpbC5jb20+CkNjOiBsaW51
eC1yZW5lc2FzLXNvY0B2Z2VyLmtlcm5lbC5vcmcKCmZpbGU6IGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92cmFtX21nci5jCkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVj
aGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1k
LmNvbT4KQ2M6ICJQYW4sIFhpbmh1aSIgPFhpbmh1aS5QYW5AYW1kLmNvbT4KCmZpbGU6IGRyaXZl
cnMvZ3B1L2RybS92aXJ0aW8vdmlydGdwdV92cmFtLmMKQ2M6IERhdmlkIEFpcmxpZSA8YWlybGll
ZEBsaW51eC5pZT4KQ2M6IEdlcmQgSG9mZm1hbm4gPGtyYXhlbEByZWRoYXQuY29tPgoKZmlsZTog
ZHJpdmVycy9tZWRpYS9jb21tb24vdmlkZW9idWYyL3ZpZGVvYnVmMi1kbWEtY29udGlnLmMKQ2M6
IFRvbWFzeiBGaWdhIDx0ZmlnYUBjaHJvbWl1bS5vcmc+CkNjOiBNYXJlayBTenlwcm93c2tpIDxt
LnN6eXByb3dza2lAc2Ftc3VuZy5jb20+CgpmaWxlOiBkcml2ZXJzL21pc2MvaGFiYW5hbGFicy9j
b21tb24vbWVtb3J5LmMKQ2M6IE9kZWQgR2FiYmF5IDxvZ2FiYmF5QGtlcm5lbC5vcmc+CkNjOiBB
cm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPgpDYzogR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVn
a2hAbGludXhmb3VuZGF0aW9uLm9yZz4KCmZpbGU6IGRyaXZlcnMvbXRkL25hbmQvcmF3L3Fjb21f
bmFuZGMuYwpDYzogTWFuaXZhbm5hbiBTYWRoYXNpdmFtIDxtYW5pQGtlcm5lbC5vcmc+CgpmaWxl
OiBhcmNoL2FybTY0L2Jvb3QvZHRzL3Fjb20ve2lwcTgwNzQuZHRzaSxpcHE2MDE4LmR0c2kscWNv
bS1zZHg1NS5kdHNpLHFjb20taXBxNDAxOS5kdHNpLHFjb20taXBxODA2NC5kdHNpfQpDYzogQW5k
eSBHcm9zcyA8YWdyb3NzQGtlcm5lbC5vcmc+CkNjOiBCam9ybiBBbmRlcnNzb24gPGJqb3JuLmFu
ZGVyc3NvbkBsaW5hcm8ub3JnPgpDYzogbGludXgtYXJtLW1zbUB2Z2VyLmtlcm5lbC5vcmcKCmZp
bGU6IGRyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL2FmL3J2dS5jCkNjOiBT
dW5pbCBHb3V0aGFtIDxzZ291dGhhbUBtYXJ2ZWxsLmNvbT4KQ2M6IExpbnUgQ2hlcmlhbiA8bGNo
ZXJpYW5AbWFydmVsbC5jb20+CkNjOiBHZWV0aGEgc293amFueWEgPGdha3VsYUBtYXJ2ZWxsLmNv
bT4KCmZpbGU6IGRyaXZlcnMvbnRiL250Yl90cmFuc3BvcnQuYwpDYzogSm9uIE1hc29uIDxqZG1h
c29uQGt1ZHp1LnVzPgpDYzogRGF2ZSBKaWFuZyA8ZGF2ZS5qaWFuZ0BpbnRlbC5jb20+CkNjOiBu
dGJAbGlzdHMubGludXguZGV2Ci0tLQoga2VybmVsL2RtYS9kaXJlY3QuYyB8IDIgKy0KIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2tl
cm5lbC9kbWEvZGlyZWN0LmMgYi9rZXJuZWwvZG1hL2RpcmVjdC5jCmluZGV4IDk3NDNjNmNjY2Ux
YS4uYmMwNmRiNzRkZmRiIDEwMDY0NAotLS0gYS9rZXJuZWwvZG1hL2RpcmVjdC5jCisrKyBiL2tl
cm5lbC9kbWEvZGlyZWN0LmMKQEAgLTQ5Nyw3ICs0OTcsNyBAQCBpbnQgZG1hX2RpcmVjdF9tYXBf
c2coc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnNnbCwgaW50IG5lbnRz
LAogZG1hX2FkZHJfdCBkbWFfZGlyZWN0X21hcF9yZXNvdXJjZShzdHJ1Y3QgZGV2aWNlICpkZXYs
IHBoeXNfYWRkcl90IHBhZGRyLAogCQlzaXplX3Qgc2l6ZSwgZW51bSBkbWFfZGF0YV9kaXJlY3Rp
b24gZGlyLCB1bnNpZ25lZCBsb25nIGF0dHJzKQogewotCWRtYV9hZGRyX3QgZG1hX2FkZHIgPSBw
YWRkcjsKKwlkbWFfYWRkcl90IGRtYV9hZGRyID0gcGh5c190b19kbWFfZGlyZWN0KGRldiwgcGFk
ZHIpOwogCiAJaWYgKHVubGlrZWx5KCFkbWFfY2FwYWJsZShkZXYsIGRtYV9hZGRyLCBzaXplLCBm
YWxzZSkpKSB7CiAJCWRldl9lcnJfb25jZShkZXYsCi0tIAoyLjM1LjEKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21t
dUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
