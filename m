Return-Path: <SRS0=DEPd=UE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D4DC282DE
	for <iommu@archiver.kernel.org>; Wed,  5 Jun 2019 05:50:30 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2967F2083E
	for <iommu@archiver.kernel.org>; Wed,  5 Jun 2019 05:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FOh08iBo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2967F2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D0C56B8E;
	Wed,  5 Jun 2019 05:50:29 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 199DEAE0
	for <iommu@lists.linux-foundation.org>;
	Wed,  5 Jun 2019 05:50:28 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 7EFF334F
	for <iommu@lists.linux-foundation.org>;
	Wed,  5 Jun 2019 05:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209;
	h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OjIrnGQGCOhzp7rHkVNxq6gEHvDiczQ7n+SWfkZXfuA=;
	b=FOh08iBoGdxd0TgZxWZAe6HY72
	/y1hc0WRaI1KV40nBnCVCTOhmnFS1h4bSdNQSrxJOcNtvxu9PmbP/uk1SBAVW477UVP8nRBqs8cbF
	J5rNRQNgZgLlmWRdm3illrkt8ckb3/2rN9ec5hh+jO5+vHItXKFdgfmAJFEuqyf+sww13/3n97E7S
	vmtMhW40lznrYzWF2YPcOysOUiar1cIRSChCJkFf0lIO4NYUTTy0cr1p0wB2J5Fcp87h6zNekn8aN
	GFTzn57fRV37XuUpKUTT7A5+IWgfzWtQwvq+XOvRwiMRtJIxwiUQHM5iDrSZzCiFK2UrdsiP5ne72
	HRloGgdA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
	Hat Linux)) id 1hYOoX-0005Al-PR; Wed, 05 Jun 2019 05:50:21 +0000
Date: Tue, 4 Jun 2019 22:50:21 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Tom Murphy <tmurphy@arista.com>
Subject: Re: [PATCH v3 1/4] iommu: Add gfp parameter to iommu_ops::map
Message-ID: <20190605055021.GA15036@infradead.org>
References: <20190506185207.31069-1-tmurphy@arista.com>
	<20190506185207.31069-2-tmurphy@arista.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190506185207.31069-2-tmurphy@arista.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Heiko Stuebner <heiko@sntech.de>, Will Deacon <will.deacon@arm.com>,
	David Brown <david.brown@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-rockchip@lists.infradead.org,
	Kukjin Kim <kgene@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	Gerald Schaefer <gerald.schaefer@de.ibm.com>,
	Andy Gross <andy.gross@linaro.org>, linux-arm-msm@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	David Woodhouse <dwmw2@infradead.org>,
	linux-kernel@vger.kernel.org, murphyt7@tcd.ie,
	iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
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

T24gTW9uLCBNYXkgMDYsIDIwMTkgYXQgMDc6NTI6MDNQTSArMDEwMCwgVG9tIE11cnBoeSB2aWEg
aW9tbXUgd3JvdGU6Cj4gV2UgY2FuIHJlbW92ZSB0aGUgbXV0ZXggbG9jayBmcm9tIGFtZF9pb21t
dV9tYXAgYW5kIGFtZF9pb21tdV91bm1hcC4KPiBpb21tdV9tYXAgZG9lc27igJl0IGxvY2sgd2hp
bGUgbWFwcGluZyBhbmQgc28gbm8gdHdvIGNhbGxzIHNob3VsZCB0b3VjaAo+IHRoZSBzYW1lIGlv
dmEgcmFuZ2UuIFRoZSBBTUQgZHJpdmVyIGFscmVhZHkgaGFuZGxlcyB0aGUgcGFnZSB0YWJsZSBw
YWdlCj4gYWxsb2NhdGlvbnMgd2l0aG91dCBsb2NrcyBzbyB3ZSBjYW4gc2FmZWx5IHJlbW92ZSB0
aGUgbG9ja3MuCgpCdHcsIHRoaXMgcmVhbGx5IHNob3VsZCBiZSBhIHNlcGFyYXRlIHBhdGNoLgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWls
aW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
