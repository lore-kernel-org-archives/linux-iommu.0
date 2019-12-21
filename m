Return-Path: <SRS0=gCe8=2L=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3377CC2D0C0
	for <iommu@archiver.kernel.org>; Sat, 21 Dec 2019 15:09:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2AF82063A
	for <iommu@archiver.kernel.org>; Sat, 21 Dec 2019 15:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="neV87FDz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2AF82063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tcd.ie
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8662E20483;
	Sat, 21 Dec 2019 15:09:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4j8KK2pHVEHo; Sat, 21 Dec 2019 15:09:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6587C2010E;
	Sat, 21 Dec 2019 15:09:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55C73C1D7F;
	Sat, 21 Dec 2019 15:09:42 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2AD7C077D
 for <iommu@lists.linux-foundation.org>; Sat, 21 Dec 2019 15:09:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id BAC5520334
 for <iommu@lists.linux-foundation.org>; Sat, 21 Dec 2019 15:09:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iCDugeEDZh34 for <iommu@lists.linux-foundation.org>;
 Sat, 21 Dec 2019 15:09:39 +0000 (UTC)
X-Greylist: delayed 00:05:24 by SQLgrey-1.7.6
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com
 [209.85.208.65])
 by silver.osuosl.org (Postfix) with ESMTPS id 38B1D2010E
 for <iommu@lists.linux-foundation.org>; Sat, 21 Dec 2019 15:09:39 +0000 (UTC)
Received: by mail-ed1-f65.google.com with SMTP id l8so11411304edw.1
 for <iommu@lists.linux-foundation.org>; Sat, 21 Dec 2019 07:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tcd-ie.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Wrv1jKXMHqqWHNzOL/6EYVPe/DHxphPiIOsjGB9s2BI=;
 b=neV87FDzcGxEtXMGvHrtTmbUOLtYtU+7I9MOQqfdQ+hsUXA8p8rI9n+KxmtaOLCADC
 oqzQwM+E41sGIEhE26+tkV5wTeVqusoqBdHCsFTHLhlkaDp++P9e9+/8rjVQr/Wsf9hN
 kPbAbKsiSsT63+7OMPlwjagzVfM0swjA056jVZJc1EqBSggoujvgAZK6bAD1VYJYtXeD
 ft7DHsq/EkMf9BhDvmD36g1hqGBWyqNIVG1DfNnWrfT4s1zi4GMzfbjEz0QIobV6kmY1
 laD6eUJQwGoQ0UWRg2PHTAA5VDA0M3C2Amsc74c9QymUHI36GRshkavBOusZCLhvlyeT
 csig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Wrv1jKXMHqqWHNzOL/6EYVPe/DHxphPiIOsjGB9s2BI=;
 b=Ed/TfmOjFRSXU4IcEajC9JJJtYYmde3qjU8lGGjWt6ZrMom3DCZNPgtYnMpDRFm9VA
 ss8JgMpDKGcD3ww7IHArgawi7yT35DL5Iz+mRQyYRxBG1boO+TSS769CTAp3TwqOX7sx
 s2zI+xN6P2Rt3v/AAM33KVexBorSEzJvPx9oCjLsD45JVCQTgvyPu3joW343zSg2lr1B
 RtebIn1v5diuPaaSG32jk3BMVmvUSu64ehbuz9cj3acZIoF0VP5YixFjrHg0u8ZRMAPT
 0Rg4MWUY89WCURZiyQedlwcWPUXxfO3LR83y0CnjV2yT7R0Pc3tZiMSblxA8lfDWnNQX
 /A0w==
X-Gm-Message-State: APjAAAWSVekcWefWnt6ZybcgX0nP3slycaJw5nguXSyyHZtBUJssAFAa
 Y0V+2SNb8FIJoHBHsE3NF4j69/anGYRhIg==
X-Google-Smtp-Source: APXvYqzVFV+nAZt2efpFSBwn8fHDfarT+lNLK2u/m6P0Ib5tJlSKcUyhpXmrMgKd3Rdn4f4Yf8qeow==
X-Received: by 2002:a17:906:2e53:: with SMTP id
 r19mr22235209eji.306.1576940652743; 
 Sat, 21 Dec 2019 07:04:12 -0800 (PST)
Received: from localhost.localdomain ([80.233.37.20])
 by smtp.googlemail.com with ESMTPSA id u13sm1517639ejz.69.2019.12.21.07.04.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Dec 2019 07:04:12 -0800 (PST)
From: Tom Murphy <murphyt7@tcd.ie>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 0/8] Convert the intel iommu driver to the dma-iommu api
Date: Sat, 21 Dec 2019 15:03:52 +0000
Message-Id: <20191221150402.13868-1-murphyt7@tcd.ie>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: Heiko Stuebner <heiko@sntech.de>, kvm@vger.kernel.org,
 David Airlie <airlied@linux.ie>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 dri-devel@lists.freedesktop.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 linux-tegra@vger.kernel.org, Julien Grall <julien.grall@arm.com>,
 Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 linux-samsung-soc@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
 linux-rockchip@lists.infradead.org, Andy Gross <agross@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 linux-mediatek@lists.infradead.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 virtualization@lists.linux-foundation.org,
 Gerald Schaefer <gerald.schaefer@de.ibm.com>,
 David Woodhouse <dwmw2@infradead.org>, Cornelia Huck <cohuck@redhat.com>,
 linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>,
 Kukjin Kim <kgene@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Robin Murphy <robin.murphy@arm.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

VGhpcyBwYXRjaHNldCBjb252ZXJ0cyB0aGUgaW50ZWwgaW9tbXUgZHJpdmVyIHRvIHRoZSBkbWEt
aW9tbXUgYXBpLgoKV2hpbGUgY29udmVydGluZyB0aGUgZHJpdmVyIEkgZXhwb3NlZCBhIGJ1ZyBp
biB0aGUgaW50ZWwgaTkxNSBkcml2ZXIgd2hpY2ggY2F1c2VzIGEgaHVnZSBhbW91bnQgb2YgYXJ0
aWZhY3RzIG9uIHRoZSBzY3JlZW4gb2YgbXkgbGFwdG9wLiBZb3UgY2FuIHNlZSBhIHBpY3R1cmUg
b2YgaXQgaGVyZToKaHR0cHM6Ly9naXRodWIuY29tL3BpcHB5MzYwL2tlcm5lbFBhdGNoZXMvYmxv
Yi9tYXN0ZXIvSU1HXzIwMTkxMjE5XzIyNTkyMi5qcGcKClRoaXMgaXNzdWUgaXMgbW9zdCBsaWtl
bHkgaW4gdGhlIGk5MTUgZHJpdmVyIGFuZCBpcyBtb3N0IGxpa2VseSBjYXVzZWQgYnkgdGhlIGRy
aXZlciBub3QgcmVzcGVjdGluZyB0aGUgcmV0dXJuIHZhbHVlIG9mIHRoZSBkbWFfbWFwX29wczo6
bWFwX3NnIGZ1bmN0aW9uLiBZb3UgY2FuIHNlZSB0aGUgZHJpdmVyIGlnbm9yaW5nIHRoZSByZXR1
cm4gdmFsdWUgaGVyZToKaHR0cHM6Ly9naXRodWIuY29tL3RvcnZhbGRzL2xpbnV4L2Jsb2IvN2Uw
MTY1YjJmMWE5MTJhMDZlMzgxZTkxZjBmNGU0OTVmNGFjMzczNi9kcml2ZXJzL2dwdS9kcm0vaTkx
NS9nZW0vaTkxNV9nZW1fZG1hYnVmLmMjTDUxCgpQcmV2aW91c2x5IHRoaXMgZGlkbuKAmXQgY2F1
c2UgaXNzdWVzIGJlY2F1c2UgdGhlIGludGVsIG1hcF9zZyBhbHdheXMgcmV0dXJuZWQgdGhlIHNh
bWUgbnVtYmVyIG9mIGVsZW1lbnRzIGFzIHRoZSBpbnB1dCBzY2F0dGVyIGdhdGhlciBsaXN0IGJ1
dCB3aXRoIHRoZSBjaGFuZ2UgdG8gdGhpcyBkbWEtaW9tbXUgYXBpIHRoaXMgaXMgbm8gbG9uZ2Vy
IHRoZSBjYXNlLiBJIHdhc27igJl0IGFibGUgdG8gdHJhY2sgdGhlIGJ1ZyBkb3duIHRvIGEgc3Bl
Y2lmaWMgbGluZSBvZiBjb2RlIHVuZm9ydHVuYXRlbHkuICAKCkNvdWxkIHNvbWVvbmUgZnJvbSB0
aGUgaW50ZWwgdGVhbSBsb29rIGF0IHRoaXM/CgoKSSBoYXZlIGJlZW4gdGVzdGluZyBvbiBhIGxl
bm92byB4MSBjYXJib24gNXRoIGdlbmVyYXRpb24uIExldCBtZSBrbm93IGlmIHRoZXJl4oCZcyBh
bnkgbW9yZSBpbmZvcm1hdGlvbiB5b3UgbmVlZC4KClRvIGFsbG93IG15IHBhdGNoIHNldCB0byBi
ZSB0ZXN0ZWQgSSBoYXZlIGFkZGVkIGEgcGF0Y2ggKHBhdGNoIDgvOCkgaW4gdGhpcyBzZXJpZXMg
dG8gZGlzYWJsZSBjb21iaW5pbmcgc2cgc2VnbWVudHMgaW4gdGhlIGRtYS1pb21tdSBhcGkgd2hp
Y2ggZml4ZXMgdGhlIGJ1ZyBidXQgaXQgZG9lc24ndCBmaXggdGhlIGFjdHVhbCBwcm9ibGVtLgoK
QXMgcGFydCBvZiB0aGlzIHBhdGNoIHNlcmllcyBJIGNvcGllZCB0aGUgaW50ZWwgYm91bmNlIGJ1
ZmZlciBjb2RlIHRvIHRoZSBkbWEtaW9tbXUgcGF0aC4gVGhlIGFkZGl0aW9uIG9mIHRoZSBib3Vu
Y2UgYnVmZmVyIGNvZGUgdG9vayBtZSBieSBzdXJwcmlzZS4gSSBkaWQgbW9zdCBvZiBteSBkZXZl
bG9wbWVudCBvbiB0aGlzIHBhdGNoIHNlcmllcyBiZWZvcmUgdGhlIGJvdW5jZSBidWZmZXIgY29k
ZSB3YXMgYWRkZWQgYW5kIG15IHJlaW1wbGVtZW50YXRpb24gaW4gdGhlIGRtYS1pb21tdSBwYXRo
IGlzIHZlcnkgcnVzaGVkIGFuZCBub3QgcHJvcGVybHkgdGVzdGVkIGJ1dCBJ4oCZbSBydW5uaW5n
IG91dCBvZiB0aW1lIHRvIHdvcmsgb24gdGhpcyBwYXRjaCBzZXQuCgpPbiB0b3Agb2YgdGhhdCBJ
IGFsc28gZGlkbuKAmXQgcG9ydCBvdmVyIHRoZSBpbnRlbCB0cmFjaW5nIGNvZGUgZnJvbSB0aGlz
IGNvbW1pdDoKaHR0cHM6Ly9naXRodWIuY29tL3RvcnZhbGRzL2xpbnV4L2NvbW1pdC8zYjUzMDM0
YzI2OGQ1NTBkOWU4NTIyZTYxM2ExNGFiNTNiODg0MGQ4I2RpZmYtNmIzZTdjNDk5M2YwNWU3NjMz
MWU0NjNhYjFmYzg3ZTEKU28gYWxsIHRoZSB3b3JrIGluIHRoYXQgY29tbWl0IGlzIG5vdyB3YXN0
ZWQuIFRoZSBjb2RlIHdpbGwgbmVlZCB0byBiZSByZW1vdmVkIGFuZCByZWltcGxlbWVudGVkIGlu
IHRoZSBkbWEtaW9tbXUgcGF0aC4gSSB3b3VsZCBsaWtlIHRvIHRha2UgdGhlIHRpbWUgdG8gZG8g
dGhpcyBidXQgSSByZWFsbHkgZG9u4oCZdCBoYXZlIHRoZSB0aW1lIGF0IHRoZSBtb21lbnQgYW5k
IEkgd2FudCB0byBnZXQgdGhlc2UgY2hhbmdlcyBvdXQgYmVmb3JlIHRoZSBpb21tdSBjb2RlIGNo
YW5nZXMgYW55IG1vcmUuCgoKVG9tIE11cnBoeSAoOCk6CiAgaW9tbXUvdnQtZDogY2xlYW4gdXAg
MzJiaXQgc2lfZG9tYWluIGFzc2lnbm1lbnQKICBpb21tdS92dC1kOiBVc2UgZGVmYXVsdCBkbWFf
ZGlyZWN0XyogbWFwcGluZyBmdW5jdGlvbnMgZm9yIGRpcmVjdAogICAgbWFwcGVkIGRldmljZXMK
ICBpb21tdS92dC1kOiBSZW1vdmUgSU9WQSBoYW5kbGluZyBjb2RlIGZyb20gbm9uLWRtYV9vcHMg
cGF0aAogIGlvbW11OiBIYW5kbGUgZnJlZWxpc3RzIHdoZW4gdXNpbmcgZGVmZXJyZWQgZmx1c2hp
bmcgaW4gaW9tbXUgZHJpdmVycwogIGlvbW11OiBBZGQgaW9tbXVfZG1hX2ZyZWVfY3B1X2NhY2hl
ZF9pb3ZhcyBmdW5jdGlvbgogIGlvbW11OiBhbGxvdyB0aGUgZG1hLWlvbW11IGFwaSB0byB1c2Ug
Ym91bmNlIGJ1ZmZlcnMKICBpb21tdS92dC1kOiBDb252ZXJ0IGludGVsIGlvbW11IGRyaXZlciB0
byB0aGUgaW9tbXUgb3BzCiAgRE8gTk9UIE1FUkdFOiBpb21tdTogZGlzYWJsZSBsaXN0IGFwcGVu
ZGluZyBpbiBkbWEtaW9tbXUKCiBkcml2ZXJzL2lvbW11L0tjb25maWcgICAgICAgICAgIHwgICAx
ICsKIGRyaXZlcnMvaW9tbXUvYW1kX2lvbW11LmMgICAgICAgfCAgMTQgKy0KIGRyaXZlcnMvaW9t
bXUvYXJtLXNtbXUtdjMuYyAgICAgfCAgIDMgKy0KIGRyaXZlcnMvaW9tbXUvYXJtLXNtbXUuYyAg
ICAgICAgfCAgIDMgKy0KIGRyaXZlcnMvaW9tbXUvZG1hLWlvbW11LmMgICAgICAgfCAxODMgKysr
KystLQogZHJpdmVycy9pb21tdS9leHlub3MtaW9tbXUuYyAgICB8ICAgMyArLQogZHJpdmVycy9p
b21tdS9pbnRlbC1pb21tdS5jICAgICB8IDkzNiArKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQogZHJpdmVycy9pb21tdS9pb21tdS5jICAgICAgICAgICB8ICAzOSArLQogZHJpdmVycy9p
b21tdS9pcG1tdS12bXNhLmMgICAgICB8ICAgMyArLQogZHJpdmVycy9pb21tdS9tc21faW9tbXUu
YyAgICAgICB8ICAgMyArLQogZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyAgICAgICB8ICAgMyAr
LQogZHJpdmVycy9pb21tdS9tdGtfaW9tbXVfdjEuYyAgICB8ICAgMyArLQogZHJpdmVycy9pb21t
dS9vbWFwLWlvbW11LmMgICAgICB8ICAgMyArLQogZHJpdmVycy9pb21tdS9xY29tX2lvbW11LmMg
ICAgICB8ICAgMyArLQogZHJpdmVycy9pb21tdS9yb2NrY2hpcC1pb21tdS5jICB8ICAgMyArLQog
ZHJpdmVycy9pb21tdS9zMzkwLWlvbW11LmMgICAgICB8ICAgMyArLQogZHJpdmVycy9pb21tdS90
ZWdyYS1nYXJ0LmMgICAgICB8ICAgMyArLQogZHJpdmVycy9pb21tdS90ZWdyYS1zbW11LmMgICAg
ICB8ICAgMyArLQogZHJpdmVycy9pb21tdS92aXJ0aW8taW9tbXUuYyAgICB8ICAgMyArLQogZHJp
dmVycy92ZmlvL3ZmaW9faW9tbXVfdHlwZTEuYyB8ICAgMiArLQogaW5jbHVkZS9saW51eC9kbWEt
aW9tbXUuaCAgICAgICB8ICAgMyArCiBpbmNsdWRlL2xpbnV4L2ludGVsLWlvbW11LmggICAgIHwg
ICAxIC0KIGluY2x1ZGUvbGludXgvaW9tbXUuaCAgICAgICAgICAgfCAgMzIgKy0KIDIzIGZpbGVz
IGNoYW5nZWQsIDM0NSBpbnNlcnRpb25zKCspLCA5MDggZGVsZXRpb25zKC0pCgotLSAKMi4yMC4x
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBt
YWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
