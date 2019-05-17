Return-Path: <SRS0=WrXO=TR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE836C04AB4
	for <iommu@archiver.kernel.org>; Fri, 17 May 2019 19:06:03 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD36A2087B
	for <iommu@archiver.kernel.org>; Fri, 17 May 2019 19:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qt8cxJxO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD36A2087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 478DDC87;
	Fri, 17 May 2019 19:05:27 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4DA72AB9
	for <iommu@lists.linux-foundation.org>;
	Fri, 17 May 2019 18:47:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
	[209.85.128.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A16E85E4
	for <iommu@lists.linux-foundation.org>;
	Fri, 17 May 2019 18:47:14 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id 7so7677932wmo.2
	for <iommu@lists.linux-foundation.org>;
	Fri, 17 May 2019 11:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=ip1Ip/bBaI3oGl08+c/jPOf0AEvNzRwc1Jgyw/gygxk=;
	b=Qt8cxJxOi8qJ77aqBKyjG/lWcVYYzL6/07gSZutuPuFlBoJoe9yuGAZwcmZZLSHMl2
	YwyJMeCaJwKKUK1oUilHidMuNNn0Z34/PaJSaoJemKOp4QhfVOlfxz+PFpJrrGLq6jCY
	T/n2HF9paCpLR/Ig0BTK8cH/fuJDirjiXDPsAk7Wp63GSaUMyoCoLuFHXO2iVULQNFX1
	4BUDjbYEVkDAO9DHEKgRrqi5eUWO7JB3owY86c3Q4pqYmdntLGXl99w2B1l2PMQXy7gs
	numgqR10zZKf9niYesBego+VhtkRJsOHyd6hdIANTCeHgY5UvNhdC3i7b6JTR72z0ghq
	BukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=ip1Ip/bBaI3oGl08+c/jPOf0AEvNzRwc1Jgyw/gygxk=;
	b=t9BkllFkUFBWV72I8aOCsiDculqiZzjjQhqioNPJYgBkVS/FehgXDUF8FsoZzTf9Ms
	wcUt9YLXGrO+fLhAsp5O3FEBAw2+uoeUA6THlJG7hBFAyTlwHHMNbS3PSCccElsgpimF
	MxUkdA3r4kIQ7/cbd9/yglpYpb5oHBXf1D0BjKyYQZAJ6hHl8zw41KQn3B5Ld8SG098G
	Ks05NC54w+VbFU0vg7x80fbYtMUtig+gCHjnGaMpsuwCih4G8VdOsVnPZlRjrx80A+nX
	eBDWYAnJps+CANOxCmaXenp2Qx2ciEV8innRr7jw0vuH4X0lG7PZ1ZMUXZkYZy2fn/46
	APKw==
X-Gm-Message-State: APjAAAUMJd2NRLLBpnrHBorSdhuLcBM83Lp8W+4Usz5RmQEcFS0frdHp
	vE2B1uUhoYMO0931LSPPP5s=
X-Google-Smtp-Source: APXvYqysPSutaA4puP30zGOzEsfbUgHw1Z4xAikm5f80rIquhXkmO9Pv2pFIkeYXnsuBeQvRIr5jOQ==
X-Received: by 2002:a1c:1f47:: with SMTP id f68mr22674115wmf.57.1558118833163; 
	Fri, 17 May 2019 11:47:13 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
	by smtp.gmail.com with ESMTPSA id
	v20sm5801112wmj.10.2019.05.17.11.47.12
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 17 May 2019 11:47:12 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
	Tomeu Vizoso <tomeu.vizoso@collabora.com>,
	Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Neil Armstrong <narmstrong@baylibre.com>,
	Steven Price <steven.price@arm.com>
Subject: [PATCH v5 6/6] arm64: dts: allwinner: Add mali GPU supply for H6
	boards
Date: Fri, 17 May 2019 20:46:59 +0200
Message-Id: <20190517184659.18828-7-peron.clem@gmail.com>
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

RW5hYmxlIGFuZCBhZGQgc3VwcGx5IHRvIHRoZSBNYWxpIEdQVSBub2RlIG9uIGFsbCB0aGUKSDYg
Ym9hcmRzLgoKUmVnYXJkaW5nIHRoZSBkYXRhc2hlZXQgdGhlIG1heGltdW0gdGltZSBmb3Igc3Vw
cGx5IHRvIHJlYWNoCml0cyB2b2x0YWdlIGlzIDMybXMuCgpTaWduZWQtb2ZmLWJ5OiBDbMOpbWVu
dCBQw6lyb24gPHBlcm9uLmNsZW1AZ21haWwuY29tPgotLS0KIGFyY2gvYXJtNjQvYm9vdC9kdHMv
YWxsd2lubmVyL3N1bjUwaS1oNi1iZWVsaW5rLWdzMS5kdHMgfCA2ICsrKysrKwogYXJjaC9hcm02
NC9ib290L2R0cy9hbGx3aW5uZXIvc3VuNTBpLWg2LW9yYW5nZXBpLTMuZHRzICB8IDYgKysrKysr
CiBhcmNoL2FybTY0L2Jvb3QvZHRzL2FsbHdpbm5lci9zdW41MGktaDYtb3JhbmdlcGkuZHRzaSAg
IHwgNiArKysrKysKIGFyY2gvYXJtNjQvYm9vdC9kdHMvYWxsd2lubmVyL3N1bjUwaS1oNi1waW5l
LWg2NC5kdHMgICAgfCA2ICsrKysrKwogNCBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCsp
CgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9hbGx3aW5uZXIvc3VuNTBpLWg2LWJl
ZWxpbmstZ3MxLmR0cyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvYWxsd2lubmVyL3N1bjUwaS1oNi1i
ZWVsaW5rLWdzMS5kdHMKaW5kZXggMGRjMzNjOTBkZDYwLi5mZTM2YzY1ODhkOGUgMTAwNjQ0Ci0t
LSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvYWxsd2lubmVyL3N1bjUwaS1oNi1iZWVsaW5rLWdzMS5k
dHMKKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9hbGx3aW5uZXIvc3VuNTBpLWg2LWJlZWxpbmst
Z3MxLmR0cwpAQCAtNzAsNiArNzAsMTEgQEAKIAlzdGF0dXMgPSAib2theSI7CiB9OwogCismZ3B1
IHsKKwltYWxpLXN1cHBseSA9IDwmcmVnX2RjZGNjPjsKKwlzdGF0dXMgPSAib2theSI7Cit9Owor
CiAmaGRtaSB7CiAJc3RhdHVzID0gIm9rYXkiOwogfTsKQEAgLTIwNiw2ICsyMTEsNyBAQAogCQkJ
fTsKIAogCQkJcmVnX2RjZGNjOiBkY2RjYyB7CisJCQkJcmVndWxhdG9yLWVuYWJsZS1yYW1wLWRl
bGF5ID0gPDMyMDAwPjsKIAkJCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDw4MTAwMDA+Owog
CQkJCXJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDEwODAwMDA+OwogCQkJCXJlZ3VsYXRvci1u
YW1lID0gInZkZC1ncHUiOwpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9hbGx3aW5u
ZXIvc3VuNTBpLWg2LW9yYW5nZXBpLTMuZHRzIGIvYXJjaC9hcm02NC9ib290L2R0cy9hbGx3aW5u
ZXIvc3VuNTBpLWg2LW9yYW5nZXBpLTMuZHRzCmluZGV4IDE3ZDQ5Njk5MDEwOC4uZWE0ODY2YjBm
YTdhIDEwMDY0NAotLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2FsbHdpbm5lci9zdW41MGktaDYt
b3JhbmdlcGktMy5kdHMKKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9hbGx3aW5uZXIvc3VuNTBp
LWg2LW9yYW5nZXBpLTMuZHRzCkBAIC01OCw2ICs1OCwxMSBAQAogCXN0YXR1cyA9ICJva2F5IjsK
IH07CiAKKyZncHUgeworCW1hbGktc3VwcGx5ID0gPCZyZWdfZGNkY2M+OworCXN0YXR1cyA9ICJv
a2F5IjsKK307CisKICZtbWMwIHsKIAl2bW1jLXN1cHBseSA9IDwmcmVnX2NsZG8xPjsKIAljZC1n
cGlvcyA9IDwmcGlvIDUgNiBHUElPX0FDVElWRV9MT1c+OyAvKiBQRjYgKi8KQEAgLTE2NSw2ICsx
NzAsNyBAQAogCQkJfTsKIAogCQkJcmVnX2RjZGNjOiBkY2RjYyB7CisJCQkJcmVndWxhdG9yLWVu
YWJsZS1yYW1wLWRlbGF5ID0gPDMyMDAwPjsKIAkJCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9
IDw4MTAwMDA+OwogCQkJCXJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDEwODAwMDA+OwogCQkJ
CXJlZ3VsYXRvci1uYW1lID0gInZkZC1ncHUiOwpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290
L2R0cy9hbGx3aW5uZXIvc3VuNTBpLWg2LW9yYW5nZXBpLmR0c2kgYi9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL2FsbHdpbm5lci9zdW41MGktaDYtb3JhbmdlcGkuZHRzaQppbmRleCA2MmUyNzk0OGEzZmEu
LmVjNzcwZjA3YWE4MiAxMDA2NDQKLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9hbGx3aW5uZXIv
c3VuNTBpLWg2LW9yYW5nZXBpLmR0c2kKKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9hbGx3aW5u
ZXIvc3VuNTBpLWg2LW9yYW5nZXBpLmR0c2kKQEAgLTU1LDYgKzU1LDExIEBACiAJc3RhdHVzID0g
Im9rYXkiOwogfTsKIAorJmdwdSB7CisJbWFsaS1zdXBwbHkgPSA8JnJlZ19kY2RjYz47CisJc3Rh
dHVzID0gIm9rYXkiOworfTsKKwogJm1tYzAgewogCXZtbWMtc3VwcGx5ID0gPCZyZWdfY2xkbzE+
OwogCWNkLWdwaW9zID0gPCZwaW8gNSA2IEdQSU9fQUNUSVZFX0xPVz47CkBAIC0xNjMsNiArMTY4
LDcgQEAKIAkJCX07CiAKIAkJCXJlZ19kY2RjYzogZGNkY2MgeworCQkJCXJlZ3VsYXRvci1lbmFi
bGUtcmFtcC1kZWxheSA9IDwzMjAwMD47CiAJCQkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8
ODEwMDAwPjsKIAkJCQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwxMDgwMDAwPjsKIAkJCQly
ZWd1bGF0b3ItbmFtZSA9ICJ2ZGQtZ3B1IjsKZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9k
dHMvYWxsd2lubmVyL3N1bjUwaS1oNi1waW5lLWg2NC5kdHMgYi9hcmNoL2FybTY0L2Jvb3QvZHRz
L2FsbHdpbm5lci9zdW41MGktaDYtcGluZS1oNjQuZHRzCmluZGV4IDQ4MDI5MDJlMTI4Zi4uNjI1
YTI5YTI1YzUyIDEwMDY0NAotLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2FsbHdpbm5lci9zdW41
MGktaDYtcGluZS1oNjQuZHRzCisrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvYWxsd2lubmVyL3N1
bjUwaS1oNi1waW5lLWg2NC5kdHMKQEAgLTg1LDYgKzg1LDExIEBACiAJc3RhdHVzID0gIm9rYXki
OwogfTsKIAorJmdwdSB7CisJbWFsaS1zdXBwbHkgPSA8JnJlZ19kY2RjYz47CisJc3RhdHVzID0g
Im9rYXkiOworfTsKKwogJmhkbWkgewogCXN0YXR1cyA9ICJva2F5IjsKIH07CkBAIC0yMTUsNiAr
MjIwLDcgQEAKIAkJCX07CiAKIAkJCXJlZ19kY2RjYzogZGNkY2MgeworCQkJCXJlZ3VsYXRvci1l
bmFibGUtcmFtcC1kZWxheSA9IDwzMjAwMD47CiAJCQkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQg
PSA8ODEwMDAwPjsKIAkJCQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwxMDgwMDAwPjsKIAkJ
CQlyZWd1bGF0b3ItbmFtZSA9ICJ2ZGQtZ3B1IjsKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
