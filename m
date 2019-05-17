Return-Path: <SRS0=WrXO=TR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506F3C04AB4
	for <iommu@archiver.kernel.org>; Fri, 17 May 2019 19:05:31 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FDD22087B
	for <iommu@archiver.kernel.org>; Fri, 17 May 2019 19:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzX0fpNh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FDD22087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1BEB0C6C;
	Fri, 17 May 2019 19:05:26 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4A8E1AB9
	for <iommu@lists.linux-foundation.org>;
	Fri, 17 May 2019 18:47:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id BC8365E4
	for <iommu@lists.linux-foundation.org>;
	Fri, 17 May 2019 18:47:08 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id g12so7872640wro.8
	for <iommu@lists.linux-foundation.org>;
	Fri, 17 May 2019 11:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=4QRWDFkVz3xUnUzR3+DHbkRCIRl8pbjmxCa/vhR9hvo=;
	b=IzX0fpNh7WWzngetTRMHcGGlBKa4/Y10ND0MNxVowv35ASa6AyO+qLIiBx3oorQdoE
	gIMiRRTn12Vsg2PSpAtRil1uUy8xkxChgYigzhBilxkZX68upC2GKDNyLfBUb7Z2bHUQ
	l3UW0QKhlFhotuDCigGjT0urbWePYMe8D/Pqzy4lHHDPtWu2SCcAKN5A52dsJNj3f/9u
	wkbw9NIvOfWOihlEVc51Vd3gqhyPPlvGT64PX4ziAJrrUtqwzN1IUvq1Nm5N1J3wTFtQ
	EAhiuVgi6wE0rGJSFc9r5guK7YM9/7d0ISQhpYx5+RHA1MbYhrZU48H4aCLkI/T/pxBx
	RsxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=4QRWDFkVz3xUnUzR3+DHbkRCIRl8pbjmxCa/vhR9hvo=;
	b=HbdWwqyNbnOKe6hcIfH42S0IECK/Fc9B61e6LcoRUmcCZNJRZsJ2TzzsYfK4tDWxUu
	Wdc1vB2avjd+2hLLJj9FMNVgtsw+K+r5Hwd/rROpBeyBQypcbfERzxAZVGgKFdX02QyX
	cmiJOBXeEphL2fbO0us+53Tfx+EwD+eKvQHFf++EJACUlVaGG8LwKKBhqUlKLooS3whQ
	GZgEjy7a3Ko/rHCK0n36x4exOt/PEGkzo/Dkczz16lR+y5gJCeEHBLQx9MUie45FpEto
	J54yY94C1bgBU7XApNjmdf2oK+dh9m0KOZQed0txfa8lln/xB4hiw8qUDohmpFwg9Ywk
	HTvQ==
X-Gm-Message-State: APjAAAVTPYwr8yxpSQDhgyFnFThjNOXtoLB2J8Ehf2HGudkMJbswSIRd
	gu3ZztqMrEAi5pTt88XxxhA=
X-Google-Smtp-Source: APXvYqzQ3Rol+3txTzhDDbnTRdYC6TTbSHhpgNCNWdrgxxOScCII+60hVNsOpiwPvn2YYuVJGvfLtA==
X-Received: by 2002:a5d:658d:: with SMTP id q13mr19937938wru.61.1558118827335; 
	Fri, 17 May 2019 11:47:07 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
	by smtp.gmail.com with ESMTPSA id
	v20sm5801112wmj.10.2019.05.17.11.47.06
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 17 May 2019 11:47:06 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
	Tomeu Vizoso <tomeu.vizoso@collabora.com>,
	Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Neil Armstrong <narmstrong@baylibre.com>,
	Steven Price <steven.price@arm.com>
Subject: [PATCH v5 1/6] drm: panfrost: add optional bus_clock
Date: Fri, 17 May 2019 20:46:54 +0200
Message-Id: <20190517184659.18828-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190517184659.18828-1-peron.clem@gmail.com>
References: <20190517184659.18828-1-peron.clem@gmail.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 17 May 2019 19:05:24 +0000
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
ZS5jIHwgMjUgKysrKysrKysrKysrKysrKysrKysrLQogZHJpdmVycy9ncHUvZHJtL3BhbmZyb3N0
L3BhbmZyb3N0X2RldmljZS5oIHwgIDEgKwogMiBmaWxlcyBjaGFuZ2VkLCAyNSBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3BhbmZyb3N0
L3BhbmZyb3N0X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL3BhbmZyb3N0L3BhbmZyb3N0X2Rl
dmljZS5jCmluZGV4IDNiMmJjZWQxYjAxNS4uOGRhNmU2MTJkMzg0IDEwMDY0NAotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vcGFuZnJvc3QvcGFuZnJvc3RfZGV2aWNlLmMKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL3BhbmZyb3N0L3BhbmZyb3N0X2RldmljZS5jCkBAIC00NCw3ICs0NCw4IEBAIHN0YXRpYyBp
bnQgcGFuZnJvc3RfY2xrX2luaXQoc3RydWN0IHBhbmZyb3N0X2RldmljZSAqcGZkZXYpCiAKIAlw
ZmRldi0+Y2xvY2sgPSBkZXZtX2Nsa19nZXQocGZkZXYtPmRldiwgTlVMTCk7CiAJaWYgKElTX0VS
UihwZmRldi0+Y2xvY2spKSB7Ci0JCWRldl9lcnIocGZkZXYtPmRldiwgImdldCBjbG9jayBmYWls
ZWQgJWxkXG4iLCBQVFJfRVJSKHBmZGV2LT5jbG9jaykpOworCQlkZXZfZXJyKHBmZGV2LT5kZXYs
ICJnZXQgY2xvY2sgZmFpbGVkICVsZFxuIiwKKwkJCVBUUl9FUlIocGZkZXYtPmNsb2NrKSk7CiAJ
CXJldHVybiBQVFJfRVJSKHBmZGV2LT5jbG9jayk7CiAJfQogCkBAIC01NSwxMSArNTYsMzMgQEAg
c3RhdGljIGludCBwYW5mcm9zdF9jbGtfaW5pdChzdHJ1Y3QgcGFuZnJvc3RfZGV2aWNlICpwZmRl
dikKIAlpZiAoZXJyKQogCQlyZXR1cm4gZXJyOwogCisJcGZkZXYtPmJ1c19jbG9jayA9IGRldm1f
Y2xrX2dldF9vcHRpb25hbChwZmRldi0+ZGV2LCAiYnVzIik7CisJaWYgKElTX0VSUihwZmRldi0+
YnVzX2Nsb2NrKSkgeworCQlkZXZfZXJyKHBmZGV2LT5kZXYsICJnZXQgYnVzX2Nsb2NrIGZhaWxl
ZCAlbGRcbiIsCisJCQlQVFJfRVJSKHBmZGV2LT5idXNfY2xvY2spKTsKKwkJcmV0dXJuIFBUUl9F
UlIocGZkZXYtPmJ1c19jbG9jayk7CisJfQorCisJaWYgKHBmZGV2LT5idXNfY2xvY2spIHsKKwkJ
cmF0ZSA9IGNsa19nZXRfcmF0ZShwZmRldi0+YnVzX2Nsb2NrKTsKKwkJZGV2X2luZm8ocGZkZXYt
PmRldiwgImJ1c19jbG9jayByYXRlID0gJWx1XG4iLCByYXRlKTsKKworCQllcnIgPSBjbGtfcHJl
cGFyZV9lbmFibGUocGZkZXYtPmJ1c19jbG9jayk7CisJCWlmIChlcnIpCisJCQlnb3RvIGRpc2Fi
bGVfY2xvY2s7CisJfQorCiAJcmV0dXJuIDA7CisKK2Rpc2FibGVfY2xvY2s6CisJY2xrX2Rpc2Fi
bGVfdW5wcmVwYXJlKHBmZGV2LT5jbG9jayk7CisKKwlyZXR1cm4gZXJyOwogfQogCiBzdGF0aWMg
dm9pZCBwYW5mcm9zdF9jbGtfZmluaShzdHJ1Y3QgcGFuZnJvc3RfZGV2aWNlICpwZmRldikKIHsK
KwljbGtfZGlzYWJsZV91bnByZXBhcmUocGZkZXYtPmJ1c19jbG9jayk7CiAJY2xrX2Rpc2FibGVf
dW5wcmVwYXJlKHBmZGV2LT5jbG9jayk7CiB9CiAKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9wYW5mcm9zdC9wYW5mcm9zdF9kZXZpY2UuaCBiL2RyaXZlcnMvZ3B1L2RybS9wYW5mcm9zdC9w
YW5mcm9zdF9kZXZpY2UuaAppbmRleCA1NmY0NTJkZmI0OTAuLjgwNzRmMjIxMDM0YiAxMDA2NDQK
LS0tIGEvZHJpdmVycy9ncHUvZHJtL3BhbmZyb3N0L3BhbmZyb3N0X2RldmljZS5oCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9wYW5mcm9zdC9wYW5mcm9zdF9kZXZpY2UuaApAQCAtNjYsNiArNjYsNyBA
QCBzdHJ1Y3QgcGFuZnJvc3RfZGV2aWNlIHsKIAogCXZvaWQgX19pb21lbSAqaW9tZW07CiAJc3Ry
dWN0IGNsayAqY2xvY2s7CisJc3RydWN0IGNsayAqYnVzX2Nsb2NrOwogCXN0cnVjdCByZWd1bGF0
b3IgKnJlZ3VsYXRvcjsKIAlzdHJ1Y3QgcmVzZXRfY29udHJvbCAqcnN0YzsKIAotLSAKMi4xNy4x
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBt
YWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
