Return-Path: <SRS0=JEM9=V3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BC2C0650F
	for <iommu@archiver.kernel.org>; Tue, 30 Jul 2019 15:30:47 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ABC9206E0
	for <iommu@archiver.kernel.org>; Tue, 30 Jul 2019 15:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jnDSm1kT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ABC9206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1F2E82F8E;
	Tue, 30 Jul 2019 15:30:47 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 965D92F8A
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Jul 2019 15:20:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com
	[209.85.208.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E70D4D3
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Jul 2019 15:20:25 +0000 (UTC)
Received: by mail-lj1-f196.google.com with SMTP id m8so28868619lji.7
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Jul 2019 08:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=7Bm8TrbVGw472rHZ96Q2MRXayJlnL67ZSjInVLj2+c0=;
	b=jnDSm1kThBj9/KTO+yzj/l4jRVeijOOMciJDemA7qx5oWy2BpzWea2X6F5jthNRmCw
	hfSr2Qo5grf2ao4WI/Rv/6+JTx8Lp2t8YQx1HHN4CC4S9uuRVtlR2o7K9LcnXvuZEkSw
	ec1Ra6Ri4dsy/dQyYDxBu/SQQy1IvuJ5YSJ3iiW0rRp2izDyYu/4SYd/rAXB1yQcv7ct
	KV1w1w6hnwy/LLNozmJxpZK29XuUCZbPtjkCgyfhrcrZfvjz4pREBM71j9UO/xGx0rzO
	dZBHBS0BHiPTLjCzdPBdV3ZJfizcSx3il5IcKCZLDwkvQXjY19CQe0JDNTqtdDwr3wUo
	wkFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=7Bm8TrbVGw472rHZ96Q2MRXayJlnL67ZSjInVLj2+c0=;
	b=Le7r2iPkVVqpI/+dmAFFyDZsLFAPfuu9jd7e5YV3p8yNPpBgOKKIERxEy86FgsqQ6Q
	opno6Q/QMfceJm+ohp3w5b3Z+QENr8IZXic3xulLg415gEyL+CD3wGX/gA5+lFwE3DPN
	eNUBH9a+9oajJ/wUc3Yo2i+ONyVDdSKPKFbEIQIu9RqJBlX4B6mrYffDS9DCgHhyq6/E
	581Vw+JJDqGGJ1gge0vZ0eMj7XcWH9nEpg1Seuecu9XFnRxvzrRMnzq4RFkNjylNrg6J
	ajyb66GIHamm6lvMNj9XLzzpTX7UVawmJPVQiLoY+2Tn0Zcj8Di+vRbKJKMeFw9ovLTy
	IKGA==
X-Gm-Message-State: APjAAAWQ/VTL120TFeBSIi2a9CK7vE8O5/cBYCcV4Xx40T1CdxLk4Fdw
	a0BdFHX4/n6w3Sz/FNstJQeRTw==
X-Google-Smtp-Source: APXvYqw8cNQwIuVo3MyhmOP8pwoiYmj+MEq273fNs7PYTrH2vLKbLF+Kndi+zZObbX2ZtiI8cgVutg==
X-Received: by 2002:a2e:65ca:: with SMTP id e71mr1547102ljf.61.1564500024139; 
	Tue, 30 Jul 2019 08:20:24 -0700 (PDT)
Received: from localhost (c-243c70d5.07-21-73746f28.bbcust.telenor.se.
	[213.112.60.36]) by smtp.gmail.com with ESMTPSA id
	q17sm11266522lfn.71.2019.07.30.08.20.23
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Tue, 30 Jul 2019 08:20:23 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: will@kernel.org,
	joro@8bytes.org
Subject: [PATCH v2] iommu: arm-smmu-v3: Mark expected switch fall-through
Date: Tue, 30 Jul 2019 17:20:11 +0200
Message-Id: <20190730152012.2615-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: Anders Roxell <anders.roxell@linaro.org>, iommu@lists.linux-foundation.org,
	robin.murphy@arm.com, linux-kernel@vger.kernel.org,
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

Tm93IHRoYXQgLVdpbXBsaWNpdC1mYWxsdGhyb3VnaCBpcyBwYXNzZWQgdG8gR0NDIGJ5IGRlZmF1
bHQsIHRoZQpmb2xsb3dpbmcgd2FybmluZyBzaG93cyB1cDoKCi4uL2RyaXZlcnMvaW9tbXUvYXJt
LXNtbXUtdjMuYzogSW4gZnVuY3Rpb24g4oCYYXJtX3NtbXVfd3JpdGVfc3RydGFiX2VudOKAmToK
Li4vZHJpdmVycy9pb21tdS9hcm0tc21tdS12My5jOjExODk6Nzogd2FybmluZzogdGhpcyBzdGF0
ZW1lbnQgbWF5IGZhbGwKIHRocm91Z2ggWy1XaW1wbGljaXQtZmFsbHRocm91Z2g9XQogICAgaWYg
KGRpc2FibGVfYnlwYXNzKQogICAgICAgXgouLi9kcml2ZXJzL2lvbW11L2FybS1zbW11LXYzLmM6
MTE5MTozOiBub3RlOiBoZXJlCiAgIGRlZmF1bHQ6CiAgIF5+fn5+fn4KClJld29yayBzbyB0aGF0
IHRoZSBjb21waWxlciBkb2Vzbid0IHdhcm4gYWJvdXQgZmFsbC10aHJvdWdoLiBNYWtlIGl0CmNs
ZWFyZXIgYnkgY2FsbGluZyAnQlVHX09OKCknIHdoZW4gZGlzYWJsZV9ieXBhc3MgaXMgc2V0LCBh
bmQgYWx3YXlzCidicmVhazsnCgpTaWduZWQtb2ZmLWJ5OiBBbmRlcnMgUm94ZWxsIDxhbmRlcnMu
cm94ZWxsQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVycy9pb21tdS9hcm0tc21tdS12My5jIHwgNCAr
Ky0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvYXJtLXNtbXUtdjMuYyBiL2RyaXZlcnMvaW9tbXUvYXJt
LXNtbXUtdjMuYwppbmRleCBhOWE5ZmFiZDM5NjguLmM1YzkzZTQ4YjRkYiAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9pb21tdS9hcm0tc21tdS12My5jCisrKyBiL2RyaXZlcnMvaW9tbXUvYXJtLXNtbXUt
djMuYwpAQCAtMTE4Niw4ICsxMTg2LDggQEAgc3RhdGljIHZvaWQgYXJtX3NtbXVfd3JpdGVfc3Ry
dGFiX2VudChzdHJ1Y3QgYXJtX3NtbXVfbWFzdGVyICptYXN0ZXIsIHUzMiBzaWQsCiAJCQlzdGVf
bGl2ZSA9IHRydWU7CiAJCQlicmVhazsKIAkJY2FzZSBTVFJUQUJfU1RFXzBfQ0ZHX0FCT1JUOgot
CQkJaWYgKGRpc2FibGVfYnlwYXNzKQotCQkJCWJyZWFrOworCQkJQlVHX09OKCFkaXNhYmxlX2J5
cGFzcyk7CisJCQlicmVhazsKIAkJZGVmYXVsdDoKIAkJCUJVRygpOyAvKiBTVEUgY29ycnVwdGlv
biAqLwogCQl9Ci0tIAoyLjIwLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by9pb21tdQ==
