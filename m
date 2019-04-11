Return-Path: <SRS0=HOzV=SO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93CCC10F13
	for <iommu@archiver.kernel.org>; Fri, 12 Apr 2019 00:03:57 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 885DC2184B
	for <iommu@archiver.kernel.org>; Fri, 12 Apr 2019 00:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arista.com header.i=@arista.com header.b="eQ4Yac+o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 885DC2184B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1B3FC2D07;
	Fri, 12 Apr 2019 00:03:22 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 095C82491
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 18:49:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com
	[209.85.208.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6F3B163D
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 18:49:13 +0000 (UTC)
Received: by mail-ed1-f65.google.com with SMTP id d46so1339028eda.7
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 11:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=arista.com; s=googlenew;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=lX2MVOfiam4gxtJM5rz0M+xQIQGKu992FM3+lagPerc=;
	b=eQ4Yac+opjGEBMpNwcIhE+BWp72NvMbMpxtmojUTpE9/rOYjMILcbpoRJOSkm78WBk
	Aff06hpFM7720IPoJiqJyT63C+/E8qw6EX81NozIpVIX1tteropdJH6LFlD3Eh/+bnxp
	TqdoMoiwgIxQtWMiOGAc90uv+qOUf34JAI/T0ybJD/E7UmC1cFWzDvL9PTwU99FOa2Cq
	uBtmAEg9IcB2Z+rtiVJG0Mt+tgtzmiJ3TreKGg24TfCmsdd0CwQJXJinK6O+48LvF5v/
	TMCo/yA7WVatb4O5GCP0DxBkXEFa1ZseoyB+vX5EoAJETdaxDHDXc+uPIuWnEbhC9q2H
	SvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=lX2MVOfiam4gxtJM5rz0M+xQIQGKu992FM3+lagPerc=;
	b=mnWjHwj0jOomxsFdBjUouJcOm64+258v8LjLi5eOZJ3sz5QQgAx/eCwZKjdaUFnu2g
	jirkf2IcC0rn+1c39HN6ssqt4u1zpkkr0RDiSZK8a9uSNk5YEIzbJ9MFdH0HcjwpZ2bV
	2qXv+5L6xgWQ4JOcaFPznaT/4c7IEFH5IRCtz7fb6szLec6H1SoIAaF9UfW2ix05xQWJ
	NmxyY86//fzAlJDwZkINx04vU7bDyyGtxmWu91A96ChRctlbgJ26bpr+utvAyQ/SdSh0
	QiiYVafEpb94zqSYUyZBa/QjEjxo70q7RDWMVo5j8zXLI37OLcObDZGnNNu+SLlXtHab
	cnPw==
X-Gm-Message-State: APjAAAX2gk8UlkmxPlhTuYpSgJqTfCd3FRNqOhf7RWagsFZcM3Jve9V/
	yo7i4n8L+tK9XDdT5Mha61OLqiiut4OOZXWM
X-Google-Smtp-Source: APXvYqw1ZpBKkZJS1pdF6BGZGDt7JAfIqiI9pMC84S3fxuGG7Kvy3jG4mkJy+S81q/cfVwljARoScw==
X-Received: by 2002:aa7:d954:: with SMTP id l20mr32634023eds.156.1555008551931;
	Thu, 11 Apr 2019 11:49:11 -0700 (PDT)
Received: from localhost.localdomain ([80.233.32.123])
	by smtp.gmail.com with ESMTPSA id
	b10sm1285130edi.28.2019.04.11.11.49.09
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 11 Apr 2019 11:49:11 -0700 (PDT)
To: iommu@lists.linux-foundation.org
Subject: [PATCH 6/9] iommu/amd: Implement map_atomic
Date: Thu, 11 Apr 2019 19:47:35 +0100
Message-Id: <20190411184741.27540-7-tmurphy@arista.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411184741.27540-1-tmurphy@arista.com>
References: <20190411184741.27540-1-tmurphy@arista.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 12 Apr 2019 00:02:45 +0000
Cc: Heiko Stuebner <heiko@sntech.de>, Will Deacon <will.deacon@arm.com>,
	David Brown <david.brown@linaro.org>,
	linux-samsung-soc@vger.kernel.org, dima@arista.com,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-rockchip@lists.infradead.org,
	Kukjin Kim <kgene@kernel.org>, Andy Gross <andy.gross@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>, linux-arm-msm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
	Tom Murphy <tmurphy@arista.com>, linux-kernel@vger.kernel.org,
	murphyt7@tcd.ie, Robin Murphy <robin.murphy@arm.com>
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
From: Tom Murphy via iommu <iommu@lists.linux-foundation.org>
Reply-To: Tom Murphy <tmurphy@arista.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190411184735._bVhKj3SPP0dAsT488G5WLG1YgpJru0JRRX3UWZNcKo@z>

SW5zdGVhZCBvZiB1c2luZyBhIHNwaW4gbG9jayBJIHJlbW92ZWQgdGhlIG11dGV4IGxvY2sgZnJv
bSBib3RoIHRoZQphbWRfaW9tbXVfbWFwIGFuZCBhbWRfaW9tbXVfdW5tYXAgcGF0aCBhcyB3ZWxs
LiBpb21tdV9tYXAgZG9lc27igJl0IGxvY2sKd2hpbGUgbWFwcGluZyBhbmQgc28gaWYgaW9tbXVf
bWFwIGlzIGNhbGxlZCBieSB0d28gZGlmZmVyZW50IHRocmVhZHMgb24KdGhlIHNhbWUgaW92YSBy
ZWdpb24gaXQgcmVzdWx0cyBpbiBhIHJhY2UgY29uZGl0aW9uIGV2ZW4gd2l0aCB0aGUgbG9ja3Mu
ClNvIHRoZSBsb2NraW5nIGluIGFtZF9pb21tdV9tYXAgYW5kIGFtZF9pb21tdV91bm1hcCBkb2Vz
bid0IGFkZCBhbnkgcmVhbApwcm90ZWN0aW9uLiBUaGUgc29sdXRpb24gdG8gdGhpcyBpcyBmb3Ig
d2hhdGV2ZXIgbWFuYWdlcyB0aGUgYWxsb2NhdGVkCmlvdmHigJlzIGV4dGVybmFsbHkgdG8gbWFr
ZSBzdXJlIGlvbW11X21hcCBpc27igJl0IGNhbGxlZCB0d2ljZSBvbiB0aGUgc2FtZQpyZWdpb24g
YXQgdGhlIHNhbWUgdGltZS4KClNpZ25lZC1vZmYtYnk6IFRvbSBNdXJwaHkgPHRtdXJwaHlAYXJp
c3RhLmNvbT4KLS0tCiBkcml2ZXJzL2lvbW11L2FtZF9pb21tdS5jIHwgMjUgKysrKysrKysrKysr
KysrKysrLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDcgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9hbWRfaW9tbXUuYyBiL2RyaXZlcnMv
aW9tbXUvYW1kX2lvbW11LmMKaW5kZXggMmQ0ZWUxMDYyNmI0Li5iNDVlMGUwMzNhZGMgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvaW9tbXUvYW1kX2lvbW11LmMKKysrIGIvZHJpdmVycy9pb21tdS9hbWRf
aW9tbXUuYwpAQCAtMzA4OSwxMiArMzA4OSwxMiBAQCBzdGF0aWMgaW50IGFtZF9pb21tdV9hdHRh
Y2hfZGV2aWNlKHN0cnVjdCBpb21tdV9kb21haW4gKmRvbSwKIAlyZXR1cm4gcmV0OwogfQogCi1z
dGF0aWMgaW50IGFtZF9pb21tdV9tYXAoc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tLCB1bnNpZ25l
ZCBsb25nIGlvdmEsCi0JCQkgcGh5c19hZGRyX3QgcGFkZHIsIHNpemVfdCBwYWdlX3NpemUsIGlu
dCBpb21tdV9wcm90KQorc3RhdGljIGludCBfX2FtZF9pb21tdV9tYXAoc3RydWN0IGlvbW11X2Rv
bWFpbiAqZG9tLCB1bnNpZ25lZCBsb25nIGlvdmEsCisJCQkgcGh5c19hZGRyX3QgcGFkZHIsIHNp
emVfdCBwYWdlX3NpemUsIGludCBpb21tdV9wcm90LAorCQkJIGdmcF90IGdmcCkKIHsKIAlzdHJ1
Y3QgcHJvdGVjdGlvbl9kb21haW4gKmRvbWFpbiA9IHRvX3Bkb21haW4oZG9tKTsKIAlpbnQgcHJv
dCA9IDA7Ci0JaW50IHJldDsKIAogCWlmIChkb21haW4tPm1vZGUgPT0gUEFHRV9NT0RFX05PTkUp
CiAJCXJldHVybiAtRUlOVkFMOwpAQCAtMzEwNCwxMSArMzEwNCwyMSBAQCBzdGF0aWMgaW50IGFt
ZF9pb21tdV9tYXAoc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tLCB1bnNpZ25lZCBsb25nIGlvdmEs
CiAJaWYgKGlvbW11X3Byb3QgJiBJT01NVV9XUklURSkKIAkJcHJvdCB8PSBJT01NVV9QUk9UX0lX
OwogCi0JbXV0ZXhfbG9jaygmZG9tYWluLT5hcGlfbG9jayk7Ci0JcmV0ID0gaW9tbXVfbWFwX3Bh
Z2UoZG9tYWluLCBpb3ZhLCBwYWRkciwgcGFnZV9zaXplLCBwcm90LCBHRlBfS0VSTkVMKTsKLQlt
dXRleF91bmxvY2soJmRvbWFpbi0+YXBpX2xvY2spOworCXJldHVybiBpb21tdV9tYXBfcGFnZShk
b21haW4sIGlvdmEsIHBhZGRyLCBwYWdlX3NpemUsIHByb3QsIGdmcCk7Cit9CiAKLQlyZXR1cm4g
cmV0Oworc3RhdGljIGludCBhbWRfaW9tbXVfbWFwKHN0cnVjdCBpb21tdV9kb21haW4gKmRvbSwg
dW5zaWduZWQgbG9uZyBpb3ZhLAorCQkJIHBoeXNfYWRkcl90IHBhZGRyLCBzaXplX3QgcGFnZV9z
aXplLCBpbnQgaW9tbXVfcHJvdCkKK3sKKwlyZXR1cm4gX19hbWRfaW9tbXVfbWFwKGRvbSwgaW92
YSwgcGFkZHIsIHBhZ2Vfc2l6ZSwgaW9tbXVfcHJvdCwKKwkJCUdGUF9LRVJORUwpOworfQorCitz
dGF0aWMgaW50IGFtZF9pb21tdV9tYXBfYXRvbWljKHN0cnVjdCBpb21tdV9kb21haW4gKmRvbSwg
dW5zaWduZWQgbG9uZyBpb3ZhLAorCQkJIHBoeXNfYWRkcl90IHBhZGRyLCBzaXplX3QgcGFnZV9z
aXplLCBpbnQgaW9tbXVfcHJvdCkKK3sKKwlyZXR1cm4gX19hbWRfaW9tbXVfbWFwKGRvbSwgaW92
YSwgcGFkZHIsIHBhZ2Vfc2l6ZSwgaW9tbXVfcHJvdCwKKwkJCUdGUF9BVE9NSUMpOwogfQogCiBz
dGF0aWMgc2l6ZV90IGFtZF9pb21tdV91bm1hcChzdHJ1Y3QgaW9tbXVfZG9tYWluICpkb20sIHVu
c2lnbmVkIGxvbmcgaW92YSwKQEAgLTMyNjIsNiArMzI3Miw3IEBAIGNvbnN0IHN0cnVjdCBpb21t
dV9vcHMgYW1kX2lvbW11X29wcyA9IHsKIAkuYXR0YWNoX2RldiA9IGFtZF9pb21tdV9hdHRhY2hf
ZGV2aWNlLAogCS5kZXRhY2hfZGV2ID0gYW1kX2lvbW11X2RldGFjaF9kZXZpY2UsCiAJLm1hcCA9
IGFtZF9pb21tdV9tYXAsCisJLm1hcF9hdG9taWMgPSBhbWRfaW9tbXVfbWFwX2F0b21pYywKIAku
dW5tYXAgPSBhbWRfaW9tbXVfdW5tYXAsCiAJLmlvdmFfdG9fcGh5cyA9IGFtZF9pb21tdV9pb3Zh
X3RvX3BoeXMsCiAJLmFkZF9kZXZpY2UgPSBhbWRfaW9tbXVfYWRkX2RldmljZSwKLS0gCjIuMTcu
MQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUg
bWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
