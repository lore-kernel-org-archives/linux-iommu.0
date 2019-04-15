Return-Path: <SRS0=E2BV=SR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EB6C10F0E
	for <iommu@archiver.kernel.org>; Mon, 15 Apr 2019 06:31:03 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B255220825
	for <iommu@archiver.kernel.org>; Mon, 15 Apr 2019 06:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Uoz1Da3E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B255220825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 70EB0A95;
	Mon, 15 Apr 2019 06:31:02 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E336AA7F
	for <iommu@lists.linux-foundation.org>;
	Mon, 15 Apr 2019 06:31:01 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id CA4DF1C0
	for <iommu@lists.linux-foundation.org>;
	Mon, 15 Apr 2019 06:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209;
	h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sBvvwLAlcvN1BhPYhrP92KdhFk9vL6RzAU/eyQJbtN8=;
	b=Uoz1Da3E3lLPQy37LZAVYDF9N0
	FSXo09rFri3MFfGg+C+zaoIiTI7eN36RlIbtThL04wK/u2kQpS2xzfhXM+Ud+O4Ct+mE1sfx7ZTFg
	YmGh5xTERnLVji2ukeZzbEtA7gINkw/hCLv2fzR/mRn8/McAi6nVF8zCRY5is1+KWsEqW5VdpA8qJ
	1neN7XXNcoXfY+iGVJGDg0QR7gaRMbyt930ySxIkwJ6IO7xW1qOMsPn451/zLxJrBCFQj+TpZS2Vi
	Mv7oUB3ugC3VMfWlUJo8zpi1b7fWnvWe9VqLpJBcJK5xUt6D1uRNlNOdta55hpw7VtYEaJ4OCfOJb
	xVDQp4Hw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
	Hat Linux)) id 1hFv8t-0001xP-1u; Mon, 15 Apr 2019 06:30:59 +0000
Date: Sun, 14 Apr 2019 23:30:58 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Tom Murphy <tmurphy@arista.com>
Subject: Re: [PATCH 1/9] iommu/dma-iommu: Add iommu_map_atomic
Message-ID: <20190415063058.GA1377@infradead.org>
References: <20190411184741.27540-1-tmurphy@arista.com>
	<20190411184741.27540-2-tmurphy@arista.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190411184741.27540-2-tmurphy@arista.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-samsung-soc@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
	dima@arista.com, Marc Zyngier <marc.zyngier@arm.com>,
	linux-arm-msm@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
	linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
	David Brown <david.brown@linaro.org>,
	iommu@lists.linux-foundation.org, Kukjin Kim <kgene@kernel.org>,
	linux-mediatek@lists.infradead.org, murphyt7@tcd.ie,
	Andy Gross <andy.gross@linaro.org>, linux-rockchip@lists.infradead.org,
	Thomas Gleixner <tglx@linutronix.de>, Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190415063058.I19sjqVhFEoPTVJD4wJq_04FCG7x2d5iMImqqJb13qg@z>

T24gVGh1LCBBcHIgMTEsIDIwMTkgYXQgMDc6NDc6MzBQTSArMDEwMCwgVG9tIE11cnBoeSB2aWEg
aW9tbXUgd3JvdGU6Cj4gVGhlIGlvbW11IG9wcyAubWFwIGZ1bmN0aW9uIChvciB0aGUgaW9tbXVf
bWFwIGZ1bmN0aW9uIHdoaWNoIGNhbGxzIGl0KQo+IHdhcyBhbHdheXMgc3VwcG9zZWQgdG8gYmUg
c2xlZXBhYmxlIChhY2NvcmRpbmcgdG8gSm9lcmcncyBjb21tZW50IGluCj4gdGhpcyB0aHJlYWQ6
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3BhdGNod29yay9wYXRjaC85Nzc1MjAvICkgYW5kIHNv
Cj4gc2hvdWxkIHByb2JhYmx5IGhhdmUgaGFkIGEgIm1pZ2h0X3NsZWVwKCkiIHNpbmNlIGl0IHdh
cyB3cml0dGVuLiBIb3dldmVyCj4gY3VycmVudGx5IHRoZSBkbWEtaW9tbXUgYXBpIGNhbiBjYWxs
IGlvbW11X21hcCBpbiBhbiBhdG9taWMgY29udGV4dCwKPiB3aGljaCBpdCBzaG91bGRuJ3QgZG8u
IFRoaXMgZG9lc24ndCBjYXVzZSBhbnkgcHJvYmxlbXMgYmVjYXVzZSBhbnkgaW9tbXUKPiBkcml2
ZXIgd2hpY2ggdXNlcyB0aGUgZG1hLWlvbW11IGFwaSB1c2VzIGdmcF9hdG9taWMgaW4gaXQncyBp
b21tdV9vcHMKPiAubWFwIGZ1bmN0aW9uLiBCdXQgZG9pbmcgdGhpcyB3YXN0ZXMgdGhlIG1lbW9y
eSBhbGxvY2F0b3JzIGF0b21pYyBwb29scy4KPiAKPiBBZGQgYSBuZXcgZnVuY3Rpb24gaW9tbXVf
bWFwX2F0b21pYywgdXNlIGl0IGluIHRoZSBkbWEtaW9tbXUgYXBpIGFuZCBhZGQKPiDigJxtaWdo
dF9zbGVlcCgp4oCdIHRvIHRoZSBpb21tdV9tYXAgZnVuY3Rpb24uCj4gCj4gQWZ0ZXIgdGhpcyBj
aGFuZ2UgYWxsIGRyaXZlcnMgd2hpY2ggdXNlIHRoZSBkbWEtaW9tbXUgYXBpIG5lZWQgdG8KPiBp
bXBsZW1lbnQgdGhlIG5ldyBpb21tdSBvcHMgLm1hcF9hdG9taWMgZnVuY3Rpb24uIEZvciB0aGUg
bW9tZW50IGp1c3QKPiByZXVzZSB0aGUgZHJpdmVyJ3MgaW9tbXVzIG9wcyAubWFwIGZ1bmN0aW9u
IGZvciAubWFwX2F0b21pYy4KCkluc3RlYWQgb2YgZHVwbGljYXRpbmcgdGhlIGNhbGxjaGFpbiBz
aG91bGRuJ3Qgd2UganVzdCBwYXNzIGRvd24gYSBmbGFnCnRvIGluZGljYXRlIGlmIHRoZSBjb250
ZXh0IGNhbiBzbGVlcCBvciBub3Q/ICBFc3BlY2lhbGx5IGFzIGFsbCB0aGUKZXhpc3RpbmcgYXJt
IGRyaXZlcnMgYWxyZWFkeSBpbXBsZW1lbnQgdGhlIGF0b21pYyBiZWhhdmlvciwgd2hpY2ggaXMK
YSBtYWpvcml0eSBvZiBzdHJ1Y3QgaW9tbXVfb3BzIGJhc2VkIGlvbW11IGRyaXZlcnMuCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcg
bGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
