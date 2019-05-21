Return-Path: <SRS0=R8za=TV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C6AC04AAF
	for <iommu@archiver.kernel.org>; Tue, 21 May 2019 16:11:11 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41C1921743
	for <iommu@archiver.kernel.org>; Tue, 21 May 2019 16:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRVai1T8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41C1921743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 27363C4E;
	Tue, 21 May 2019 16:11:11 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 69FA8BE4
	for <iommu@lists.linux-foundation.org>;
	Tue, 21 May 2019 16:11:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
	[209.85.128.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id AA802E3
	for <iommu@lists.linux-foundation.org>;
	Tue, 21 May 2019 16:11:09 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id 198so3576580wme.3
	for <iommu@lists.linux-foundation.org>;
	Tue, 21 May 2019 09:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=v1KBi6qqP9EGBxX48fTi6KulOfsUgVuB2MNi/ParILE=;
	b=dRVai1T8gwETI5/fzjSqe8AAgm5d+9JKj0lCvTp44DKAxqPXkAJsbnpAfkaDBrRrh4
	jn7VRBDyVr1x2rk+QTLGqyAkgq5Fqp3egFWKGlh+H+TEDRbyGYTlPws4+ex4/X4Cwqfm
	WqNC2UHEkv/CuIg5MphCgSUSEuY6Yv9sZ9qqR8yaqh02ooNXjkJg2iontuV71habufQ4
	DFT/XugmCdba/HZ1Vdm2tFIPxi+Ooz1kc1MUa/TDWI7D7vKh36ygoFk2wR0IyWnE5UBq
	ZGFxScYi4/1zfKL0PIG3bCbz3lk7F4a9PDxPm6ysFc3XwNYOXrMdzNA/Vd6v3f1FbRBb
	s60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=v1KBi6qqP9EGBxX48fTi6KulOfsUgVuB2MNi/ParILE=;
	b=dhnEgZ96TmXrEtLdcIct6Z7g+HT9XGy/tbzh2+Vm72bSauYZtnugB9jlJvpUsK0+uI
	wBeRHn+ZPly0ar/R3k3y2SVuu/x5bdu4elqOmfuNXB2OSTUpiBgVgDkFvfIuOnmJqITv
	VzUc/ff750UB8XiXCcCmIX/OULQyjZ2g3pGeBlWG1fausB/BoehqQKHCWFcDhOY1sYA9
	Aj+qiZoCCnCoT3zdgOtpW9BYecAT8C4zaCdPJDnCxboXAgsUTApKAaS8M+Vww7viCPDg
	fCPjrxleZcsF1yOV5xx+xUgywJa8YybDz3NXIJM16IT+AtRrC+wIlAYK72n5474UbScd
	gQAQ==
X-Gm-Message-State: APjAAAXluPErQhmYv5jY+Q3DfBt7fqIugDFZnYmJX8gBacmsPE5pRL5l
	pRhKoVd7pLLQ9+go5Ac2bC4=
X-Google-Smtp-Source: APXvYqxzJh2R7WO4N4CR6Z7NWsbiVf7u/9TEGUdJ5mcXxXr27xkPEERbRL7FqUk2kZM5+H2JkAx1RQ==
X-Received: by 2002:a1c:b3c3:: with SMTP id c186mr3968354wmf.93.1558455068018; 
	Tue, 21 May 2019 09:11:08 -0700 (PDT)
Received: from localhost.localdomain (18.189-60-37.rdns.acropolistelecom.net.
	[37.60.189.18]) by smtp.gmail.com with ESMTPSA id
	n63sm3891094wmn.38.2019.05.21.09.11.06
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 21 May 2019 09:11:07 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
	Tomeu Vizoso <tomeu.vizoso@collabora.com>,
	Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Neil Armstrong <narmstrong@baylibre.com>,
	Steven Price <steven.price@arm.com>
Subject: [PATCH v6 0/6] Allwinner H6 Mali GPU support
Date: Tue, 21 May 2019 18:10:56 +0200
Message-Id: <20190521161102.29620-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
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

SGksCgpUaGUgQWxsd2lubmVyIEg2IGhhcyBhIE1hbGktVDcyMCBNUDIgd2hpY2ggc2hvdWxkIGJl
IHN1cHBvcnRlZCBieQp0aGUgbmV3IHBhbmZyb3N0IGRyaXZlci4gVGhpcyBzZXJpZXMgZml4IHR3
byBpc3N1ZXMgYW5kIGludHJvZHVjZSB0aGUKZHQtYmluZGluZ3MgYnV0IGEgc2ltcGxlIGJlbmNo
bWFyayBzaG93IHRoYXQgaXQncyBzdGlsbCBOT1QgV09SS0lORy4KCkknbSBwdXNoaW5nIGl0IGlu
IGNhc2Ugc29tZW9uZSB3YW50IHRvIGNvbnRpbnVlIHRoZSB3b3JrLgoKVGhpcyBoYXMgYmVlbiB0
ZXN0ZWQgd2l0aCBNZXNhM0QgMTkuMS4wLVJDMiBhbmQgYSBHUFUgYml0bmVzcyBwYXRjaFsxXS4K
Ck9uZSBwYXRjaCBpcyBmcm9tIEljZW5vd3kgWmhlbmcgd2hlcmUgSSBjaGFuZ2VkIHRoZSBvcmRl
ciBhcyByZXF1aXJlZApieSBSb2IgSGVycmluZ1syXS4KClRoYW5rcywKQ2xlbWVudAoKWzFdIGh0
dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9yZy9rc3phcS9tZXNhL3RyZWUvcGFuZnJvc3RfNjRf
MzIKWzJdIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTA2OTk4MjkvCgoKWyAg
MzQ1LjIwNDgxM10gcGFuZnJvc3QgMTgwMDAwMC5ncHU6IG1tdSBpcnEgc3RhdHVzPTEKWyAgMzQ1
LjIwOTYxN10gcGFuZnJvc3QgMTgwMDAwMC5ncHU6IFVuaGFuZGxlZCBQYWdlIGZhdWx0IGluIEFT
MCBhdCBWQQoweDAwMDAwMDAwMDI0MDA0MDAKWyAgMzQ1LjIwOTYxN10gUmVhc29uOiBUT0RPClsg
IDM0NS4yMDk2MTddIHJhdyBmYXVsdCBzdGF0dXM6IDB4ODAwMDAyQzEKWyAgMzQ1LjIwOTYxN10g
ZGVjb2RlZCBmYXVsdCBzdGF0dXM6IFNMQVZFIEZBVUxUClsgIDM0NS4yMDk2MTddIGV4Y2VwdGlv
biB0eXBlIDB4QzE6IFRSQU5TTEFUSU9OX0ZBVUxUX0xFVkVMMQpbICAzNDUuMjA5NjE3XSBhY2Nl
c3MgdHlwZSAweDI6IFJFQUQKWyAgMzQ1LjIwOTYxN10gc291cmNlIGlkIDB4ODAwMApbICAzNDUu
NzI5OTU3XSBwYW5mcm9zdCAxODAwMDAwLmdwdTogZ3B1IHNjaGVkIHRpbWVvdXQsIGpzPTAsCnN0
YXR1cz0weDgsIGhlYWQ9MHgyNDAwNDAwLCB0YWlsPTB4MjQwMDQwMCwgc2NoZWRfam9iPTAwMDAw
MDAwOWUyMDRkZTkKWyAgMzQ2LjA1NTg3Nl0gcGFuZnJvc3QgMTgwMDAwMC5ncHU6IG1tdSBpcnEg
c3RhdHVzPTEKWyAgMzQ2LjA2MDY4MF0gcGFuZnJvc3QgMTgwMDAwMC5ncHU6IFVuaGFuZGxlZCBQ
YWdlIGZhdWx0IGluIEFTMCBhdCBWQQoweDAwMDAwMDAwMDJDMDBBMDAKWyAgMzQ2LjA2MDY4MF0g
UmVhc29uOiBUT0RPClsgIDM0Ni4wNjA2ODBdIHJhdyBmYXVsdCBzdGF0dXM6IDB4ODEwMDAyQzEK
WyAgMzQ2LjA2MDY4MF0gZGVjb2RlZCBmYXVsdCBzdGF0dXM6IFNMQVZFIEZBVUxUClsgIDM0Ni4w
NjA2ODBdIGV4Y2VwdGlvbiB0eXBlIDB4QzE6IFRSQU5TTEFUSU9OX0ZBVUxUX0xFVkVMMQpbICAz
NDYuMDYwNjgwXSBhY2Nlc3MgdHlwZSAweDI6IFJFQUQKWyAgMzQ2LjA2MDY4MF0gc291cmNlIGlk
IDB4ODEwMApbICAzNDYuNTYxOTU1XSBwYW5mcm9zdCAxODAwMDAwLmdwdTogZ3B1IHNjaGVkIHRp
bWVvdXQsIGpzPTEsCnN0YXR1cz0weDgsIGhlYWQ9MHgyYzAwYTAwLCB0YWlsPTB4MmMwMGEwMCwg
c2NoZWRfam9iPTAwMDAwMDAwYjU1YTlhODUKWyAgMzQ2LjU3MzkxM10gcGFuZnJvc3QgMTgwMDAw
MC5ncHU6IG1tdSBpcnEgc3RhdHVzPTEKWyAgMzQ2LjU3ODcwN10gcGFuZnJvc3QgMTgwMDAwMC5n
cHU6IFVuaGFuZGxlZCBQYWdlIGZhdWx0IGluIEFTMCBhdCBWQQoweDAwMDAwMDAwMDJDMDBCODAK
CkNoYW5nZSBpbiB2NToKIC0gUmVtb3ZlIGZpeCBpbmRlbnQKCkNoYW5nZXMgaW4gdjQ6CiAtIEFk
ZCBidXNfY2xvY2sgcHJvYmUKIC0gRml4IHNhbml0eSBjaGVjayBpbiBpby1wZ3RhYmxlCiAtIEFk
ZCB2cmFtcC1kZWxheQogLSBNZXJnZSBhbGwgYm9hcmRzIGludG8gb25lIHBhdGNoCiAtIFJlbW92
ZSB1cHN0cmVhbWVkIE5laWwgQS4gcGF0Y2gKCkNoYW5nZSBpbiB2MyAoVGhhbmtzIHRvIE1heGlt
ZSBSaXBhcmQpOgogLSBSZWF1dGhvciBJY2Vub3d5IGZvciBoZXIgcGF0aAoKQ2hhbmdlcyBpbiB2
MiAoVGhhbmtzIHRvIE1heGltZSBSaXBhcmQpOgogLSBEcm9wIEdQVSBPUFAgVGFibGUKIC0gQWRk
IGNsb2NrcyBhbmQgY2xvY2stbmFtZXMgaW4gcmVxdWlyZWQKCkNsw6ltZW50IFDDqXJvbiAoNSk6
CiAgZHJtOiBwYW5mcm9zdDogYWRkIG9wdGlvbmFsIGJ1c19jbG9jawogIGlvbW11OiBpby1wZ3Rh
YmxlOiBmaXggc2FuaXR5IGNoZWNrIGZvciBub24gNDgtYml0IG1hbGkgaW9tbXUKICBkdC1iaW5k
aW5nczogZ3B1OiBtYWxpLW1pZGdhcmQ6IEFkZCBINiBtYWxpIGdwdSBjb21wYXRpYmxlCiAgYXJt
NjQ6IGR0czogYWxsd2lubmVyOiBBZGQgQVJNIE1hbGkgR1BVIG5vZGUgZm9yIEg2CiAgYXJtNjQ6
IGR0czogYWxsd2lubmVyOiBBZGQgbWFsaSBHUFUgc3VwcGx5IGZvciBINiBib2FyZHMKCkljZW5v
d3kgWmhlbmcgKDEpOgogIGR0LWJpbmRpbmdzOiBncHU6IGFkZCBidXMgY2xvY2sgZm9yIE1hbGkg
TWlkZ2FyZCBHUFVzCgogLi4uL2JpbmRpbmdzL2dwdS9hcm0sbWFsaS1taWRnYXJkLnR4dCAgICAg
ICAgIHwgMTUgKysrKysrKysrKysrLQogLi4uL2R0cy9hbGx3aW5uZXIvc3VuNTBpLWg2LWJlZWxp
bmstZ3MxLmR0cyAgIHwgIDYgKysrKysKIC4uLi9kdHMvYWxsd2lubmVyL3N1bjUwaS1oNi1vcmFu
Z2VwaS0zLmR0cyAgICB8ICA2ICsrKysrCiAuLi4vZHRzL2FsbHdpbm5lci9zdW41MGktaDYtb3Jh
bmdlcGkuZHRzaSAgICAgfCAgNiArKysrKwogLi4uL2Jvb3QvZHRzL2FsbHdpbm5lci9zdW41MGkt
aDYtcGluZS1oNjQuZHRzIHwgIDYgKysrKysKIGFyY2gvYXJtNjQvYm9vdC9kdHMvYWxsd2lubmVy
L3N1bjUwaS1oNi5kdHNpICB8IDE0ICsrKysrKysrKysrKwogZHJpdmVycy9ncHUvZHJtL3BhbmZy
b3N0L3BhbmZyb3N0X2RldmljZS5jICAgIHwgMjIgKysrKysrKysrKysrKysrKysrKwogZHJpdmVy
cy9ncHUvZHJtL3BhbmZyb3N0L3BhbmZyb3N0X2RldmljZS5oICAgIHwgIDEgKwogZHJpdmVycy9p
b21tdS9pby1wZ3RhYmxlLWFybS5jICAgICAgICAgICAgICAgIHwgIDIgKy0KIDkgZmlsZXMgY2hh
bmdlZCwgNzYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCi0tIAoyLjE3LjEKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcg
bGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
