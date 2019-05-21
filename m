Return-Path: <SRS0=R8za=TV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41BEC04AAF
	for <iommu@archiver.kernel.org>; Tue, 21 May 2019 16:11:15 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78E6A21743
	for <iommu@archiver.kernel.org>; Tue, 21 May 2019 16:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrCzRXON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78E6A21743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5898BC3F;
	Tue, 21 May 2019 16:11:13 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id F0099BE4
	for <iommu@lists.linux-foundation.org>;
	Tue, 21 May 2019 16:11:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
	[209.85.128.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A8AD2E3
	for <iommu@lists.linux-foundation.org>;
	Tue, 21 May 2019 16:11:10 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id c77so3585026wmd.1
	for <iommu@lists.linux-foundation.org>;
	Tue, 21 May 2019 09:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=pcynCO3Bhnyyyh0AzkuL7DAz7yiCtTiW/mLXsFC4qdg=;
	b=YrCzRXON/0Vpkv9VFfnH6p1V3nggv/XRBoBPsx+/vqNSV/s+pu9R6XK+Hki1MeKXVW
	iOGxBpY077JEobnVKhTOfi+3VNke0nn8+CBJ+6RMQgVF13yL9mF58lbebM+srWUv5Ueg
	wtq1dzjsCXbsJC34G8ddp6z6u4O0ALYJbv0DY8YbsesAgEjukZJX+OV7OOF8M8/wXK9g
	+18b+uxQzEKtktq6PDkGvCDZQAyNx3bhgElXQN/NYDo821mt7JsqhHJ2tH1JJGKwc6V4
	ZnBBhOp7m8/U1xHIe+bNL1LXtKSr2t+xK+KGDrUju6zr127Tm3Ui+E56cxeDNrKttAPL
	2Xew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=pcynCO3Bhnyyyh0AzkuL7DAz7yiCtTiW/mLXsFC4qdg=;
	b=RNkWE8muR1nrgCrJVGRlyhvphSeXKiDMTGJkuoP4+a+9YNmclqcnV0yUvcUQO8FKhm
	hic/tEIDlXep4ZTEG3/3roc72A7/CQ6UOhLDNie1ikkN8ckapn0e7o6nlj0uUtoeQwJ/
	PbSma3Kc/PQd1ESNj2w4md2Op04kpTn3g7jK5nJfQE4/aVsJr9nS9YIwUhfIYhWRTluu
	mqeFZtQgAFt68BiEsjuahHIiGWGoJ+ASmf+tGKdqBPXzpFELtQdOFJRfMrRknsOyPaMq
	Euxc1JGi/2GbcxZhxsHf4f48HmEAQ0VQWAq37JOcSV6i0+Z+FEGSTIETg62qdSXbF3c5
	R+dQ==
X-Gm-Message-State: APjAAAVD34uZ27ZMgGrtgNqyEfmMgpLibu1mQpz4uGiZmcnyK7ADcyxe
	GI5jH04Hm8NDRqM9VNlW2Aw=
X-Google-Smtp-Source: APXvYqynBK31B9gGuYlYbOmFDLrVXZyQ7MV/LPrhgtP4OE0MWCnSyrxl5VmWGWjgIOMTzPaP4WdGOw==
X-Received: by 2002:a7b:c76b:: with SMTP id x11mr4416026wmk.22.1558455069253; 
	Tue, 21 May 2019 09:11:09 -0700 (PDT)
Received: from localhost.localdomain (18.189-60-37.rdns.acropolistelecom.net.
	[37.60.189.18]) by smtp.gmail.com with ESMTPSA id
	n63sm3891094wmn.38.2019.05.21.09.11.08
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 21 May 2019 09:11:08 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
	Tomeu Vizoso <tomeu.vizoso@collabora.com>,
	Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Neil Armstrong <narmstrong@baylibre.com>,
	Steven Price <steven.price@arm.com>
Subject: [PATCH v6 1/6] drm: panfrost: add optional bus_clock
Date: Tue, 21 May 2019 18:10:57 +0200
Message-Id: <20190521161102.29620-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190521161102.29620-1-peron.clem@gmail.com>
References: <20190521161102.29620-1-peron.clem@gmail.com>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
	=?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
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

QWxsd2lubmVyIEg2IGhhcyBhbiBBUk0gTWFsaS1UNzIwIE1QMiB3aGljaCByZXF1aXJlZCBhIGJ1
c19jbG9jay4KCkFkZCBhbiBvcHRpb25hbCBidXNfY2xvY2sgYXQgdGhlIGluaXQgb2YgdGhlIHBh
bmZyb3N0IGRyaXZlci4KClNpZ25lZC1vZmYtYnk6IENsw6ltZW50IFDDqXJvbiA8cGVyb24uY2xl
bUBnbWFpbC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL3BhbmZyb3N0L3BhbmZyb3N0X2Rldmlj
ZS5jIHwgMjIgKysrKysrKysrKysrKysrKysrKysrKwogZHJpdmVycy9ncHUvZHJtL3BhbmZyb3N0
L3BhbmZyb3N0X2RldmljZS5oIHwgIDEgKwogMiBmaWxlcyBjaGFuZ2VkLCAyMyBpbnNlcnRpb25z
KCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3BhbmZyb3N0L3BhbmZyb3N0X2Rldmlj
ZS5jIGIvZHJpdmVycy9ncHUvZHJtL3BhbmZyb3N0L3BhbmZyb3N0X2RldmljZS5jCmluZGV4IDNi
MmJjZWQxYjAxNS4uY2NiOGViMmE1MThjIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vcGFu
ZnJvc3QvcGFuZnJvc3RfZGV2aWNlLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL3BhbmZyb3N0L3Bh
bmZyb3N0X2RldmljZS5jCkBAIC01NSwxMSArNTUsMzMgQEAgc3RhdGljIGludCBwYW5mcm9zdF9j
bGtfaW5pdChzdHJ1Y3QgcGFuZnJvc3RfZGV2aWNlICpwZmRldikKIAlpZiAoZXJyKQogCQlyZXR1
cm4gZXJyOwogCisJcGZkZXYtPmJ1c19jbG9jayA9IGRldm1fY2xrX2dldF9vcHRpb25hbChwZmRl
di0+ZGV2LCAiYnVzIik7CisJaWYgKElTX0VSUihwZmRldi0+YnVzX2Nsb2NrKSkgeworCQlkZXZf
ZXJyKHBmZGV2LT5kZXYsICJnZXQgYnVzX2Nsb2NrIGZhaWxlZCAlbGRcbiIsCisJCQlQVFJfRVJS
KHBmZGV2LT5idXNfY2xvY2spKTsKKwkJcmV0dXJuIFBUUl9FUlIocGZkZXYtPmJ1c19jbG9jayk7
CisJfQorCisJaWYgKHBmZGV2LT5idXNfY2xvY2spIHsKKwkJcmF0ZSA9IGNsa19nZXRfcmF0ZShw
ZmRldi0+YnVzX2Nsb2NrKTsKKwkJZGV2X2luZm8ocGZkZXYtPmRldiwgImJ1c19jbG9jayByYXRl
ID0gJWx1XG4iLCByYXRlKTsKKworCQllcnIgPSBjbGtfcHJlcGFyZV9lbmFibGUocGZkZXYtPmJ1
c19jbG9jayk7CisJCWlmIChlcnIpCisJCQlnb3RvIGRpc2FibGVfY2xvY2s7CisJfQorCiAJcmV0
dXJuIDA7CisKK2Rpc2FibGVfY2xvY2s6CisJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKHBmZGV2LT5j
bG9jayk7CisKKwlyZXR1cm4gZXJyOwogfQogCiBzdGF0aWMgdm9pZCBwYW5mcm9zdF9jbGtfZmlu
aShzdHJ1Y3QgcGFuZnJvc3RfZGV2aWNlICpwZmRldikKIHsKKwljbGtfZGlzYWJsZV91bnByZXBh
cmUocGZkZXYtPmJ1c19jbG9jayk7CiAJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKHBmZGV2LT5jbG9j
ayk7CiB9CiAKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9wYW5mcm9zdC9wYW5mcm9zdF9k
ZXZpY2UuaCBiL2RyaXZlcnMvZ3B1L2RybS9wYW5mcm9zdC9wYW5mcm9zdF9kZXZpY2UuaAppbmRl
eCA1NmY0NTJkZmI0OTAuLjgwNzRmMjIxMDM0YiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L3BhbmZyb3N0L3BhbmZyb3N0X2RldmljZS5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9wYW5mcm9z
dC9wYW5mcm9zdF9kZXZpY2UuaApAQCAtNjYsNiArNjYsNyBAQCBzdHJ1Y3QgcGFuZnJvc3RfZGV2
aWNlIHsKIAogCXZvaWQgX19pb21lbSAqaW9tZW07CiAJc3RydWN0IGNsayAqY2xvY2s7CisJc3Ry
dWN0IGNsayAqYnVzX2Nsb2NrOwogCXN0cnVjdCByZWd1bGF0b3IgKnJlZ3VsYXRvcjsKIAlzdHJ1
Y3QgcmVzZXRfY29udHJvbCAqcnN0YzsKIAotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vaW9tbXU=
