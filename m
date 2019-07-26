Return-Path: <SRS0=gbr8=VX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DBAC41517
	for <iommu@archiver.kernel.org>; Fri, 26 Jul 2019 11:28:30 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAF81216C8
	for <iommu@archiver.kernel.org>; Fri, 26 Jul 2019 11:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vhHmCUXb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAF81216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 687A3C9F;
	Fri, 26 Jul 2019 11:28:30 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3277A9EE
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Jul 2019 11:28:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com
	[209.85.208.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B38EC709
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Jul 2019 11:28:27 +0000 (UTC)
Received: by mail-lj1-f196.google.com with SMTP id d24so51132037ljg.8
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Jul 2019 04:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=qXAXo0fvFfroRZgYWsv3eTIS6UJVzpeVoAbknFGsjMk=;
	b=vhHmCUXbOqW0ShlZ/0VDIpjuqPN+yllwC23Y3r37PVgVfm8QzAufXGqQE2M+e3bBXW
	Sa6agtYW/J24tzUmmzQjuBIoBrEixhf2OJJIwLPQWd9lzYXcR2RWUkVbv4kyj5McBBh8
	VCM3fRX1y9DZW93ANmXw5P15g2/wydbxmnos6SrNyEQldDQEgLri8kEg4Rc43TnBR8aU
	AF47mTvHieO1vcSgJNotQg7LAhRptdA3m/4kyvTmUukb0G6X/fGd+q4RKWD6SqLlU4Ic
	PjQCc0/aPxCrzqEw94q1kEOcur207rRqjYV3LPtB5ntt2FqDgvmoASo8zndwPTG1O1JC
	GTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=qXAXo0fvFfroRZgYWsv3eTIS6UJVzpeVoAbknFGsjMk=;
	b=pB7kKegAMciCPMaSWaQt2hs7pCTiqsT12+ZS0QQGYtbG7R7807hK/witJX0NhtKKvu
	OmloUb14D/b68gKGhH7mDYUUzHiKN7Nz5t7EbxrtfGNrhF/FCePw1IkehAH2UIzZYTL4
	pFwoaFxv67OkRsHCuG8GsOH+BJ9A0muvCeAhcUOt8Tao1yB0ErEy/hYFfXxXd+21c8YW
	3ag5CXcTuGJPr7B2KOxqR5VxaxKXoGglB1Odv5VuIaMbROVCf7dG01M2GNKl2+dvNZ40
	EzR5m6hEwmIp0DBOHWnsh/+KQCJ1Bgv8OuGq+6Ap7qWBZJB1gRhVv2iWPjaXIVIzoxuK
	O2fw==
X-Gm-Message-State: APjAAAU5h7rAoOFwkNZuVlba/dz/YbMkfAqvd+ae7QA9m2xYm/KeIdg4
	5wcSjDCHLu/fTYZr++ijFIHsPw==
X-Google-Smtp-Source: APXvYqxRcpeZfOkhl+kP2goAmuAtJQrE6rFVOEMWhCTxNELXPLbMSsa8XPVrXecSGADSpL4vrWzCFA==
X-Received: by 2002:a2e:301a:: with SMTP id w26mr48094531ljw.76.1564140506079; 
	Fri, 26 Jul 2019 04:28:26 -0700 (PDT)
Received: from localhost (c-243c70d5.07-21-73746f28.bbcust.telenor.se.
	[213.112.60.36]) by smtp.gmail.com with ESMTPSA id
	s26sm10008774ljs.77.2019.07.26.04.28.25
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 26 Jul 2019 04:28:25 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: will@kernel.org,
	joro@8bytes.org
Subject: [PATCH] iommu: arm-smmu-v3: Mark expected switch fall-through
Date: Fri, 26 Jul 2019 13:28:21 +0200
Message-Id: <20190726112821.19775-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: stable@vger.kernel.org, iommu@lists.linux-foundation.org,
	Anders Roxell <anders.roxell@linaro.org>, linux-kernel@vger.kernel.org,
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

V2hlbiBmYWxsLXRocm91Z2ggd2FybmluZ3Mgd2FzIGVuYWJsZWQgYnkgZGVmYXVsdCwgY29tbWl0
IGQ5MzUxMmVmMGYwZQooIk1ha2VmaWxlOiBHbG9iYWxseSBlbmFibGUgZmFsbC10aHJvdWdoIHdh
cm5pbmciKSwgdGhlIGZvbGxvd2luZwp3YXJuaW5nIHdhcyBzdGFydGluZyB0byBzaG93IHVwOgoK
Li4vZHJpdmVycy9pb21tdS9hcm0tc21tdS12My5jOiBJbiBmdW5jdGlvbiDigJhhcm1fc21tdV93
cml0ZV9zdHJ0YWJfZW504oCZOgouLi9kcml2ZXJzL2lvbW11L2FybS1zbW11LXYzLmM6MTE4OTo3
OiB3YXJuaW5nOiB0aGlzIHN0YXRlbWVudCBtYXkgZmFsbAogdGhyb3VnaCBbLVdpbXBsaWNpdC1m
YWxsdGhyb3VnaD1dCiAgICBpZiAoZGlzYWJsZV9ieXBhc3MpCiAgICAgICBeCi4uL2RyaXZlcnMv
aW9tbXUvYXJtLXNtbXUtdjMuYzoxMTkxOjM6IG5vdGU6IGhlcmUKICAgZGVmYXVsdDoKICAgXn5+
fn5+fgoKUmV3b3JrIHNvIHRoYXQgdGhlIGNvbXBpbGVyIGRvZXNuJ3Qgd2FybiBhYm91dCBmYWxs
LXRocm91Z2guIE1ha2UgaXQKY2xlYXJlciBieSBjYWxsaW5nICdCVUcoKScgd2hlbiBkaXNhYmxl
X2J5cGFzcyBpcyBzZXQsIGFuZCBhbHdheXMKJ2JyZWFrOycKCkNjOiBzdGFibGVAdmdlci5rZXJu
ZWwub3JnICMgdjQuMisKRml4ZXM6IDViYzBhMTE2NjRlMSAoImlvbW11L2FybS1zbW11OiBEb24n
dCBCVUcoKSBpZiB3ZSBmaW5kIGFib3J0aW5nIFNURXMgd2l0aCBkaXNhYmxlX2J5cGFzcyIpClNp
Z25lZC1vZmYtYnk6IEFuZGVycyBSb3hlbGwgPGFuZGVycy5yb3hlbGxAbGluYXJvLm9yZz4KLS0t
CiBkcml2ZXJzL2lvbW11L2FybS1zbW11LXYzLmMgfCA1ICsrKy0tCiAxIGZpbGUgY2hhbmdlZCwg
MyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9t
bXUvYXJtLXNtbXUtdjMuYyBiL2RyaXZlcnMvaW9tbXUvYXJtLXNtbXUtdjMuYwppbmRleCBhOWE5
ZmFiZDM5NjguLjhlNWYwNTY1OTk2ZCAxMDA2NDQKLS0tIGEvZHJpdmVycy9pb21tdS9hcm0tc21t
dS12My5jCisrKyBiL2RyaXZlcnMvaW9tbXUvYXJtLXNtbXUtdjMuYwpAQCAtMTE4Niw4ICsxMTg2
LDkgQEAgc3RhdGljIHZvaWQgYXJtX3NtbXVfd3JpdGVfc3RydGFiX2VudChzdHJ1Y3QgYXJtX3Nt
bXVfbWFzdGVyICptYXN0ZXIsIHUzMiBzaWQsCiAJCQlzdGVfbGl2ZSA9IHRydWU7CiAJCQlicmVh
azsKIAkJY2FzZSBTVFJUQUJfU1RFXzBfQ0ZHX0FCT1JUOgotCQkJaWYgKGRpc2FibGVfYnlwYXNz
KQotCQkJCWJyZWFrOworCQkJaWYgKCFkaXNhYmxlX2J5cGFzcykKKwkJCQlCVUcoKTsKKwkJCWJy
ZWFrOwogCQlkZWZhdWx0OgogCQkJQlVHKCk7IC8qIFNURSBjb3JydXB0aW9uICovCiAJCX0KLS0g
CjIuMjAuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
aW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
