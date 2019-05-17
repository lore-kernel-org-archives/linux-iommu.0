Return-Path: <SRS0=WrXO=TR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E35C04AB4
	for <iommu@archiver.kernel.org>; Fri, 17 May 2019 19:05:26 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 312082087B
	for <iommu@archiver.kernel.org>; Fri, 17 May 2019 19:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShU59QoS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 312082087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E3685B49;
	Fri, 17 May 2019 19:05:25 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 72311AB9
	for <iommu@lists.linux-foundation.org>;
	Fri, 17 May 2019 18:47:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C556D5E4
	for <iommu@lists.linux-foundation.org>;
	Fri, 17 May 2019 18:47:07 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id b18so8115358wrq.12
	for <iommu@lists.linux-foundation.org>;
	Fri, 17 May 2019 11:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=vDNkiLJjFXCawT5EirH0tC0q56cBKU4m+h7W3OArVyU=;
	b=ShU59QoSeaAR7MM+7sLznlllmGxphdG2LuoN/mvYJ3l7U35bfVO6bm+wBNKyK4OK6G
	93tikl9UxFB8ch6DwSy+eEwqbtuSTlHHqZCd8ZGqc5GTQAS/tc5WYIm01LGqQvgVv1U9
	Lil/TzFLIcxEtTDgAseMVGvAvVP7oFojlYTEr4hxASIS4sgS9UXbPfpL8hPC/kmUEYHF
	V4B9dQ60bm2eHS4EzoS24pHXg9ruZd5qWimFlVpKtk7B8MK6Nu/buXaGX3VhCT2HTllm
	ELDB1+fDfOkSX2Du3QxSDgcADYM00WisukoewX9/rIxEnyKMLbSi2oO43DoEWTeyu/Su
	vQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=vDNkiLJjFXCawT5EirH0tC0q56cBKU4m+h7W3OArVyU=;
	b=he0iG+4FVgPeCIrLwlQLU7R69Ea8bCfnRT5aEnGpvt5dLNi+65nM2G9Pp4Xt9+SDSV
	I64nIP5dQiPXBnvSgu/Dl1FBUsHPftwfeMQzZTfwc7ioPoayqS9V+bkP2TtOlD+IHT1i
	FQk+sgzITJl8ZJrSTLkVUDo5ofTrROm2a4k5/Mo1GmlMKL+ILLsdmU6zB0JxfrZr5/A3
	M3W4urP2dx6OFpIOTkK9gQxAFha0mQxg25A1+3wN3zFVY70sELw6GdJvJiqK+NqnZrWZ
	LHcGwtD8/0pCv46O/VhbS647wTL4M1zdqROOIpujvo2I0LXxo+S7Tn5T129D4t+Al/W4
	RzhA==
X-Gm-Message-State: APjAAAWMYDyUOhpdOl7WJ6Jb7kdBHdzwtacdM8iJ55BO7IliRBEKZu05
	d7mpqx7ylyS4tePfzi+zRDE=
X-Google-Smtp-Source: APXvYqwLBIK/ntjqXde729LnM1cq3YTMK/Br76X9joaZ7paAbpaKGQLbTHmzFx5IuUlAJiCxrcBC4A==
X-Received: by 2002:adf:f208:: with SMTP id p8mr16535297wro.160.1558118826182; 
	Fri, 17 May 2019 11:47:06 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
	by smtp.gmail.com with ESMTPSA id
	v20sm5801112wmj.10.2019.05.17.11.47.04
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 17 May 2019 11:47:05 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
	Tomeu Vizoso <tomeu.vizoso@collabora.com>,
	Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Neil Armstrong <narmstrong@baylibre.com>,
	Steven Price <steven.price@arm.com>
Subject: [PATCH v5 0/6] Allwinner H6 Mali GPU support
Date: Fri, 17 May 2019 20:46:53 +0200
Message-Id: <20190517184659.18828-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
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

SGksCgpUaGUgQWxsd2lubmVyIEg2IGhhcyBhIE1hbGktVDcyMCBNUDIgd2hpY2ggc2hvdWxkIGJl
IHN1cHBvcnRlZCBieQp0aGUgbmV3IHBhbmZyb3N0IGRyaXZlci4gVGhpcyBzZXJpZXMgZml4IHR3
byBpc3N1ZXMgYW5kIGludHJvZHVjZSB0aGUKZHQtYmluZGluZ3MgYnV0IGEgc2ltcGxlIGJlbmNo
bWFyayBzaG93IHRoYXQgaXQncyBzdGlsbCBOT1QgV09SS0lORy4KCkknbSBwdXNoaW5nIGl0IGlu
IGNhc2Ugc29tZW9uZSB3YW50IHRvIGNvbnRpbnVlIHRoZSB3b3JrLgoKVGhpcyBoYXMgYmVlbiB0
ZXN0ZWQgd2l0aCBNZXNhM0QgMTkuMS4wLVJDMiBhbmQgYSBHUFUgYml0bmVzcyBwYXRjaFsxXS4K
Ck9uZSBwYXRjaCBpcyBmcm9tIEljZW5vd3kgWmhlbmcgd2hlcmUgSSBjaGFuZ2VkIHRoZSBvcmRl
ciBoYXMgcmVxdWlyZWQKYnkgUm9iIEhlcnJpbmdbMl0uCgpUaGFua3MsCkNsZW1lbnQKClsxXSBo
dHRwczovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcva3N6YXEvbWVzYS90cmVlL3BhbmZyb3N0XzY0
XzMyClsyXSBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzEwNjk5ODI5LwoKWyAg
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
CkNoYW5nZXMgaW4gdjQ6CiAtIEFkZCBidXNfY2xvY2sgcHJvYmUKIC0gRml4IHNhbml0eSBjaGVj
ayBpbiBpby1wZ3RhYmxlCiAtIEFkZCB2cmFtcC1kZWxheQogLSBNZXJnZSBhbGwgYm9hcmRzIGlu
dG8gb25lIHBhdGNoCiAtIFJlbW92ZSB1cHN0cmVhbWVkIE5laWwgQS4gcGF0Y2gKCkNoYW5nZXMg
aW4gdjMgKFRoYW5rcyB0byBNYXhpbWUgUmlwYXJkKToKIC0gUmVhdXRob3IgSWNlbm93eSBmb3Ig
aGVyIHBhdGgKCkNoYW5nZXMgaW4gdjIgKFRoYW5rcyB0byBNYXhpbWUgUmlwYXJkKToKIC0gRHJv
cCBHUFUgT1BQIFRhYmxlCiAtIEFkZCBjbG9ja3MgYW5kIGNsb2NrLW5hbWVzIGluIHJlcXVpcmVk
CgpDbMOpbWVudCBQw6lyb24gKDUpOgogIGRybTogcGFuZnJvc3Q6IGFkZCBvcHRpb25hbCBidXNf
Y2xvY2sKICBpb21tdTogaW8tcGd0YWJsZTogZml4IHNhbml0eSBjaGVjayBmb3Igbm9uIDQ4LWJp
dCBtYWxpIGlvbW11CiAgZHQtYmluZGluZ3M6IGdwdTogbWFsaS1taWRnYXJkOiBBZGQgSDYgbWFs
aSBncHUgY29tcGF0aWJsZQogIGFybTY0OiBkdHM6IGFsbHdpbm5lcjogQWRkIEFSTSBNYWxpIEdQ
VSBub2RlIGZvciBINgogIGFybTY0OiBkdHM6IGFsbHdpbm5lcjogQWRkIG1hbGkgR1BVIHN1cHBs
eSBmb3IgSDYgYm9hcmRzCgpJY2Vub3d5IFpoZW5nICgxKToKICBkdC1iaW5kaW5nczogZ3B1OiBh
ZGQgYnVzIGNsb2NrIGZvciBNYWxpIE1pZGdhcmQgR1BVcwoKIC4uLi9iaW5kaW5ncy9ncHUvYXJt
LG1hbGktbWlkZ2FyZC50eHQgICAgICAgICB8IDE1ICsrKysrKysrKystCiAuLi4vZHRzL2FsbHdp
bm5lci9zdW41MGktaDYtYmVlbGluay1nczEuZHRzICAgfCAgNiArKysrKwogLi4uL2R0cy9hbGx3
aW5uZXIvc3VuNTBpLWg2LW9yYW5nZXBpLTMuZHRzICAgIHwgIDYgKysrKysKIC4uLi9kdHMvYWxs
d2lubmVyL3N1bjUwaS1oNi1vcmFuZ2VwaS5kdHNpICAgICB8ICA2ICsrKysrCiAuLi4vYm9vdC9k
dHMvYWxsd2lubmVyL3N1bjUwaS1oNi1waW5lLWg2NC5kdHMgfCAgNiArKysrKwogYXJjaC9hcm02
NC9ib290L2R0cy9hbGx3aW5uZXIvc3VuNTBpLWg2LmR0c2kgIHwgMTQgKysrKysrKysrKysKIGRy
aXZlcnMvZ3B1L2RybS9wYW5mcm9zdC9wYW5mcm9zdF9kZXZpY2UuYyAgICB8IDI1ICsrKysrKysr
KysrKysrKysrKy0KIGRyaXZlcnMvZ3B1L2RybS9wYW5mcm9zdC9wYW5mcm9zdF9kZXZpY2UuaCAg
ICB8ICAxICsKIGRyaXZlcnMvaW9tbXUvaW8tcGd0YWJsZS1hcm0uYyAgICAgICAgICAgICAgICB8
ICAyICstCiA5IGZpbGVzIGNoYW5nZWQsIDc4IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0p
CgotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
