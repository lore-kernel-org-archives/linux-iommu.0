Return-Path: <SRS0=R8za=TV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B832C46460
	for <iommu@archiver.kernel.org>; Tue, 21 May 2019 16:11:44 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30A7721743
	for <iommu@archiver.kernel.org>; Tue, 21 May 2019 16:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+NTyOQl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A7721743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6E1DAC96;
	Tue, 21 May 2019 16:11:18 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 311D2C5C
	for <iommu@lists.linux-foundation.org>;
	Tue, 21 May 2019 16:11:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 91531E3
	for <iommu@lists.linux-foundation.org>;
	Tue, 21 May 2019 16:11:16 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id r4so19257006wro.10
	for <iommu@lists.linux-foundation.org>;
	Tue, 21 May 2019 09:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=ip1Ip/bBaI3oGl08+c/jPOf0AEvNzRwc1Jgyw/gygxk=;
	b=h+NTyOQl+TEZLatjt6/a4g2R3AMJacJWXFbf2ZmYrIGSFQCJi4uPljnwGSwgmmGSXh
	q+dpQUWud2oF76sb6BcbO5jnr/hX3M+t2lyopkcBTBo4zTkdZy1e+2qt+fzrMJ9zTofB
	aNReptxCaUUZiuLivNOiJlF6U2eWDnpacZ+APXCdXzFQcfHNVF+QQaHhauHH53xiECI6
	mhH/uPN2t54FSMwNEL+0ki3T1hOCvQkochF3w7oMvtDXDvpCJnwbboa0KJBiJCrTSAA9
	PLx83f6WUo1tjNIJjNkeNLzwfPMLQADkQqUiUP3Ga5iaUjDId+FULk5SV1wSczYgTf5p
	acVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=ip1Ip/bBaI3oGl08+c/jPOf0AEvNzRwc1Jgyw/gygxk=;
	b=fHSbeX6tOc4ALBqv7d3449JHhy6cNiSGKO9EnA00E4oNYQwpHnb3gcpLkgivkMTja1
	Zs4y4AeZgGK1wkziI66kDWMLOL4qoDurfjLEc/Dvdl2GyyuA/DzendJkBG3CYaZH88sl
	UptQUhsbU0yy59OI020ItrJQwGtY567GI0dY3XmK6IvoQWmUydXLkGtYOvZYjWiq35Lw
	SurjaGgQoKknEPQmXMhYpMGV24AIn0j+ge0q9eHTuVZWsP2ZXHAw2n7DUt45DgKYJmjh
	tb+oSLtwKFx8JZnhGucxwV6UEP0QEFtW8j1GMLdqMO6ICqGf9vYm7duUIHqSkXtZ9MKT
	aYLA==
X-Gm-Message-State: APjAAAVngGEU9ME5BbmxNph5aQ/1UO+d42anPqYjGnxJWke5W2+8Y0/B
	7V5Owr7LLpfNAwh3J3uCy7g=
X-Google-Smtp-Source: APXvYqy20A9dEOCcgXXitDLonYuo4h0Gko7h5PXdbB6eJStF5KSNRpJPD3LRRJAFRt/SXZ1+Ym8Efg==
X-Received: by 2002:adf:e80a:: with SMTP id o10mr22701577wrm.79.1558455075148; 
	Tue, 21 May 2019 09:11:15 -0700 (PDT)
Received: from localhost.localdomain (18.189-60-37.rdns.acropolistelecom.net.
	[37.60.189.18]) by smtp.gmail.com with ESMTPSA id
	n63sm3891094wmn.38.2019.05.21.09.11.14
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 21 May 2019 09:11:14 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
	Tomeu Vizoso <tomeu.vizoso@collabora.com>,
	Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Neil Armstrong <narmstrong@baylibre.com>,
	Steven Price <steven.price@arm.com>
Subject: [PATCH v6 6/6] arm64: dts: allwinner: Add mali GPU supply for H6
	boards
Date: Tue, 21 May 2019 18:11:02 +0200
Message-Id: <20190521161102.29620-7-peron.clem@gmail.com>
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
