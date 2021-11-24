Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE1FC4332F
	for <iommu@archiver.kernel.org>; Wed, 24 Nov 2021 08:25:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5FE7D81775;
	Wed, 24 Nov 2021 08:25:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LgzOZpCor3GW; Wed, 24 Nov 2021 08:25:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 60F69814B7;
	Wed, 24 Nov 2021 08:25:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3E34CC002E;
	Wed, 24 Nov 2021 08:25:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E47CC0012
 for <iommu@lists.linux-foundation.org>; Wed, 24 Nov 2021 08:25:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6F344404BF
 for <iommu@lists.linux-foundation.org>; Wed, 24 Nov 2021 08:25:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=fail (2048-bit key) reason="fail (bad RSA signature)"
 header.d=collabora.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Yb9OhBaXi3u3 for <iommu@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 08:25:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9C21940437
 for <iommu@lists.linux-foundation.org>; Wed, 24 Nov 2021 08:25:40 +0000 (UTC)
Received: from [IPv6:2a01:e0a:120:3210:4f87:f4f0:a34a:671f] (unknown
 [IPv6:2a01:e0a:120:3210:4f87:f4f0:a34a:671f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: benjamin.gaignard)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 9972E1F4546D;
 Wed, 24 Nov 2021 08:25:37 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
 t=1637742337; bh=vRI49dQQwsck28Fum3XIvDQAfd/iwxihc8UsPhq3ZWc=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=XG2omBbppW8i4p4VZZh1zKY+NKk5++WhfkWyQiJIuKIlXVAOQPC+cjbVPK5t7bsQb
 xCRax8AIOAlAbTRBRWrqvW60/yjDajFXff7pxQy3o1FHmrrzwPM2vMRvBYHFEFoNYh
 MYbMb5tWSyVjhCopdaVHw3kCoTD3MNRT69MiA/dDeUSDZEG4eij3LrzYeJdae/Bx3K
 docplAecOWcrrQl34BYSo0XivLSkF8zQENSIOgoy8RWp3U50+ZC85K58tYYXUOsam1
 06nT7sN39xkGlt97eFiXI3wUXXDGCMkTmstZdcmZoTofxr3iLfn+L3yfgdXr9zccyk
 wbdG6MQdHuEhA==
Subject: Re: [PATCH] iommu/rockchip: Fix PAGE_DESC_HI_MASKs for RK3568
To: Alex Bee <knaerzche@gmail.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Heiko Stuebner <heiko@sntech.de>
References: <20211124021325.858139-1-knaerzche@gmail.com>
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Message-ID: <ce137254-eee4-3241-a977-84cccb44b7cd@collabora.com>
Date: Wed, 24 Nov 2021 09:25:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211124021325.858139-1-knaerzche@gmail.com>
Content-Language: en-US
Cc: linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

CkxlIDI0LzExLzIwMjEgw6AgMDM6MTMsIEFsZXggQmVlIGEgw6ljcml0wqA6Cj4gV2l0aCB0aGUg
c3VibWlzc2lvbiBvZiBpb21tdSBkcml2ZXIgZm9yIFJLMzU2OCBhIHN1YnRsZSBidWcgd2FzCj4g
aW50cm9kdWNlZDogUEFHRV9ERVNDX0hJX01BU0sxIGFuZCBQQUdFX0RFU0NfSElfTUFTSzIgaGF2
ZSB0byBiZQo+IHRoZSBvdGhlciB3YXkgYXJyb3VuZCAtIHRoYXQgbGVhZHMgdG8gcmFuZG9tIGVy
cm9ycywgZXNwZWNpYWxseSB3aGVuCj4gYWRkcmVzc2VzIGJleW9uZCAzMiBiaXQgYXJlIHVzZWQu
Cj4KPiBGaXggaXQuCj4KPiBGaXhlczogYzU1MzU2YzUzNGFhICgiaW9tbXU6IHJvY2tjaGlwOiBB
ZGQgc3VwcG9ydCBmb3IgaW9tbXUgdjIiKQo+IFNpZ25lZC1vZmYtYnk6IEFsZXggQmVlIDxrbmFl
cnpjaGVAZ21haWwuY29tPgoKVGhhbmtzIGZvciB0aGUgZml4LgoKUmV2aWV3ZWQtYnk6IEJlbmph
bWluIEdhaWduYXJkIDxiZW5qYW1pbi5nYWlnbmFyZEBjb2xsYWJvcmEuY29tPgoKPiAtLS0KPgo+
IEkndmUgZm91bmQgdGhpcyBidWcsIHdoZW4gdGVzdGluZyB0aGUgcmVjZW50IFZPUDIgc3VibWlz
c2lvbiwgd2hpY2ggaXMKPiB0aGUgZmlyc3QgcGVycGhlcmlhbCB3aGljaCB1c2VzIGlvbW11IGZv
ciBSSzM1NnguIEkgY291bGQgdXNlIGl0IG9uIG15Cj4gcXVhcnR6NjQgOEdCIGJvYXJkIG9ubHks
IHdoZW4gbGltaXRpbmcgdGhlIGF2YWlsYWJsZSBtZW1vcnkgdG8gbGVzcyA0R0IuCj4KPiBUaGlz
IHBhdGNoIGZpeGVzIGl0Lgo+Cj4gICBkcml2ZXJzL2lvbW11L3JvY2tjaGlwLWlvbW11LmMgfCA0
ICsrLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
Cj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9yb2NrY2hpcC1pb21tdS5jIGIvZHJpdmVy
cy9pb21tdS9yb2NrY2hpcC1pb21tdS5jCj4gaW5kZXggNWNiMjYwODIwZWRhLi43ZjIzYWQ2MWMw
OTQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9pb21tdS9yb2NrY2hpcC1pb21tdS5jCj4gKysrIGIv
ZHJpdmVycy9pb21tdS9yb2NrY2hpcC1pb21tdS5jCj4gQEAgLTIwMCw4ICsyMDAsOCBAQCBzdGF0
aWMgaW5saW5lIHBoeXNfYWRkcl90IHJrX2R0ZV9wdF9hZGRyZXNzKHUzMiBkdGUpCj4gICAjZGVm
aW5lIERURV9ISV9NQVNLMglHRU5NQVNLKDcsIDQpCj4gICAjZGVmaW5lIERURV9ISV9TSElGVDEJ
MjQgLyogc2hpZnQgYml0IDggdG8gYml0IDMyICovCj4gICAjZGVmaW5lIERURV9ISV9TSElGVDIJ
MzIgLyogc2hpZnQgYml0IDQgdG8gYml0IDM2ICovCj4gLSNkZWZpbmUgUEFHRV9ERVNDX0hJX01B
U0sxCUdFTk1BU0tfVUxMKDM5LCAzNikKPiAtI2RlZmluZSBQQUdFX0RFU0NfSElfTUFTSzIJR0VO
TUFTS19VTEwoMzUsIDMyKQo+ICsjZGVmaW5lIFBBR0VfREVTQ19ISV9NQVNLMQlHRU5NQVNLX1VM
TCgzNSwgMzIpCj4gKyNkZWZpbmUgUEFHRV9ERVNDX0hJX01BU0syCUdFTk1BU0tfVUxMKDM5LCAz
NikKPiAgIAo+ICAgc3RhdGljIGlubGluZSBwaHlzX2FkZHJfdCBya19kdGVfcHRfYWRkcmVzc192
Mih1MzIgZHRlKQo+ICAgewpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9t
bXU=
