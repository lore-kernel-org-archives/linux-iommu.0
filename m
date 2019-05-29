Return-Path: <SRS0=Uk+I=T5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1DFC28CC0
	for <iommu@archiver.kernel.org>; Wed, 29 May 2019 15:15:06 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A722D23BE2
	for <iommu@archiver.kernel.org>; Wed, 29 May 2019 15:15:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A722D23BE2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8000D26C9;
	Wed, 29 May 2019 15:15:05 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 94EE42667
	for <iommu@lists.linux-foundation.org>;
	Wed, 29 May 2019 15:09:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f68.google.com (mail-io1-f68.google.com
	[209.85.166.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2C194823
	for <iommu@lists.linux-foundation.org>;
	Wed, 29 May 2019 15:09:34 +0000 (UTC)
Received: by mail-io1-f68.google.com with SMTP id h6so2139978ioh.3
	for <iommu@lists.linux-foundation.org>;
	Wed, 29 May 2019 08:09:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=ZnaDev0tj+heu2iB5lB6hq5yDeKgLXO4KFHMV/Qt+5k=;
	b=iq3hlJ/4W07rVfnpU02K5fhzPSpTEuAf11hSSHFr7AIK6K6Fv6iqXUPBudFB5Up3bQ
	ZUgnII9YIA9xxDEd0to6o5VKg8Z/K1DUbR7PYj0eQYuzNN1HyiVI1MgZ+WwYjbOvBHYJ
	wKjQA7447U0Z1wyz8sLVabOVYppyVnCSjlYJ2i+fCj4m6cmRbBRR6CPLjZJ0g5hBdHYZ
	E0DzIOBk73oVPbYXt+sx6c43SGatTT4bJQ2vPT5bKjLi76no0BkEiqiC2G+lhSc1q/hW
	uG/2fz0lj+0SeGzuNeP+QmfORbGGlOXDOyN9TmtGMT4nqmhfzLBToS6/tpXBUl4LKwVx
	vW/w==
X-Gm-Message-State: APjAAAVdlkReoXJFpf3N3dmIxbtfdyrMOzq+sR+1tR1fKFYmuqWNas7J
	Ttfz5B18Rhtie1iqluKc2G3kbwAYjDCJ/U2Qwco=
X-Google-Smtp-Source: APXvYqySOnocW0FtjyGqwuP2FQxhmxY7P/texfW33GuY5PwHsuap8yTRqkoaWNnTkj3NpjtfrGddYcbbqyuWzUYQqNA=
X-Received: by 2002:a6b:7:: with SMTP id 7mr828192ioa.253.1559142573556; Wed,
	29 May 2019 08:09:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190521161102.29620-1-peron.clem@gmail.com>
In-Reply-To: <20190521161102.29620-1-peron.clem@gmail.com>
From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Date: Wed, 29 May 2019 17:09:22 +0200
Message-ID: <CAAObsKD8bij1ANLqX6y11Y6mDEXiymNjrDkmHmvGWiFLKWu_FA@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] Allwinner H6 Mali GPU support
To: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
	Linux IOMMU <iommu@lists.linux-foundation.org>,
	Neil Armstrong <narmstrong@baylibre.com>, David Airlie <airlied@linux.ie>,
	Will Deacon <will.deacon@arm.com>,
	open list <linux-kernel@vger.kernel.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	Steven Price <steven.price@arm.com>,
	Maxime Ripard <maxime.ripard@bootlin.com>,
	Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
	Daniel Vetter <daniel@ffwll.ch>, Robin Murphy <robin.murphy@arm.com>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
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

T24gVHVlLCAyMSBNYXkgMjAxOSBhdCAxODoxMSwgQ2zDqW1lbnQgUMOpcm9uIDxwZXJvbi5jbGVt
QGdtYWlsLmNvbT4gd3JvdGU6Cj4KW3NuaXBdCj4gWyAgMzQ1LjIwNDgxM10gcGFuZnJvc3QgMTgw
MDAwMC5ncHU6IG1tdSBpcnEgc3RhdHVzPTEKPiBbICAzNDUuMjA5NjE3XSBwYW5mcm9zdCAxODAw
MDAwLmdwdTogVW5oYW5kbGVkIFBhZ2UgZmF1bHQgaW4gQVMwIGF0IFZBCj4gMHgwMDAwMDAwMDAy
NDAwNDAwCgpGcm9tIHdoYXQgSSBjYW4gc2VlIGhlcmUsIDB4MDAwMDAwMDAwMjQwMDQwMCBwb2lu
dHMgdG8gdGhlIGZpcnN0IGJ5dGUKb2YgdGhlIGZpcnN0IHN1Ym1pdHRlZCBqb2IgZGVzY3JpcHRv
ci4KClNvIG1hcHBpbmcgYnVmZmVycyBmb3IgdGhlIEdQVSBkb2Vzbid0IHNlZW0gdG8gYmUgd29y
a2luZyBhdCBhbGwgb24KNjQtYml0IFQtNzYwLgoKU3RldmVuLCBSb2JpbiwgZG8geW91IGhhdmUg
YW55IGlkZWEgb2Ygd2h5IHRoaXMgY291bGQgYmU/CgpUaGFua3MsCgpUb21ldQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QK
aW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
