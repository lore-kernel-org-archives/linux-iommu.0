Return-Path: <SRS0=WrXO=TR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49913C04AB4
	for <iommu@archiver.kernel.org>; Fri, 17 May 2019 19:05:37 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19B132087B
	for <iommu@archiver.kernel.org>; Fri, 17 May 2019 19:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sYa1xSeq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19B132087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 52932C75;
	Fri, 17 May 2019 19:05:26 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B2CC6AD1
	for <iommu@lists.linux-foundation.org>;
	Fri, 17 May 2019 18:47:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
	[209.85.128.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0C63E710
	for <iommu@lists.linux-foundation.org>;
	Fri, 17 May 2019 18:47:09 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id j187so7672825wmj.1
	for <iommu@lists.linux-foundation.org>;
	Fri, 17 May 2019 11:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=r8viNroRA5goE0iPj/ap53EgAXBGfEQtlqx5YkjMMp0=;
	b=sYa1xSeqBijyACT713JrcPfeJ6i1pId1XJ8eV7bYFwQOvCKVI9hU6X6rsi5VoYuOYt
	0D2cTJcpZWhDRkgW3lFeqzAiU5xxh8pXYkjduO+E3yB4kURp14tlb4FYguNJ6mVXxr/o
	7sNEuSmlziet3wBZ3p1LC4/4XDskX8RjgeFVzrsZZncbZNeV30kdefMoGz1GhCiM5MVN
	77LwiSFwRps5gRv+r0TY4n6TYH1qIYzplYaT0WGD17Sd2DddZ0Ra8tJkdfzHukxZ9Emq
	OxPUS2T4geuoPK9oiBP1tfS0VhtC7+6ZAjb7E2YjmdJZy2Hapy3h2XjQMFiCW1W0RPGZ
	OXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=r8viNroRA5goE0iPj/ap53EgAXBGfEQtlqx5YkjMMp0=;
	b=TbKCF7KcXYeGga8Ot91eVEbN9iSIv7X2HRD5Lje8X0bAs0fLXkVb2oF9Q4BkGRwb4b
	rZvnuKRwoZQLXVl+zYhA6HBzFC0zT1xGmwjMQRzjdSFncIuEag7GymmAAW2bq/E0rHTp
	zpc2Z1k9ixwTXRth3z1rmH5MEOVa+9oqA97NNedYE22JqEFv/ghiXKo1cz5HmC3mOtXn
	HUiYrDkVP/6hdE+GKz/h0+X8JMkVPbOAu5BHlHtJwVGeZ8bmc4ga6FqjwZVt95zm9d5C
	qNaEKfBbwgG3+IYZQpdvJKV8tthfeTyjKP+K7/YQR3m82zE/9qiftwA7wzYssHhT6bIq
	y92g==
X-Gm-Message-State: APjAAAWVGEBl/5sZf+LD1ugV+J4e4lADoqaefkWhs+VGLxU8SI0nOzy+
	a+yiHXFIPaVW9STzDty8oQw=
X-Google-Smtp-Source: APXvYqx5WYQ+/UFX3j4mg5Ayc/w6LeLH6Wy8mGmkZ59Hw5REOLqHmfti245ovfZ/JrzJoGg3/ubYNA==
X-Received: by 2002:a1c:7c0d:: with SMTP id x13mr3111380wmc.89.1558118828555; 
	Fri, 17 May 2019 11:47:08 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
	by smtp.gmail.com with ESMTPSA id
	v20sm5801112wmj.10.2019.05.17.11.47.07
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 17 May 2019 11:47:07 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
	Tomeu Vizoso <tomeu.vizoso@collabora.com>,
	Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Neil Armstrong <narmstrong@baylibre.com>,
	Steven Price <steven.price@arm.com>
Subject: [PATCH v5 2/6] iommu: io-pgtable: fix sanity check for non 48-bit
	mali iommu
Date: Fri, 17 May 2019 20:46:55 +0200
Message-Id: <20190517184659.18828-3-peron.clem@gmail.com>
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

QWxsd2lubmVyIEg2IFNvQyBoYXMgYSBNYWxpIFQ3MjBNUDIgd2l0aCBhIDMzLWJpdCBpb21tdSB3
aGljaAp0cmlnIHRoZSBzYW5pdHkgY2hlY2sgZHVyaW5nIHRoZSBhbGxvYyBvZiB0aGUgcGd0YWJs
ZS4KCkNoYW5nZSB0aGUgc2FuaXR5IGNoZWNrIHRvIGFsbG93IG5vbiA0OC1iaXQgY29uZmlndXJh
dGlvbi4KClN1Z2dlc3RlZC1ieTogUm9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4K
U2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgUMOpcm9uIDxwZXJvbi5jbGVtQGdtYWlsLmNvbT4KLS0t
CiBkcml2ZXJzL2lvbW11L2lvLXBndGFibGUtYXJtLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11
L2lvLXBndGFibGUtYXJtLmMgYi9kcml2ZXJzL2lvbW11L2lvLXBndGFibGUtYXJtLmMKaW5kZXgg
NGUyMWVmYmM0NDU5Li43NGYyY2U4MDJlNmYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaW9tbXUvaW8t
cGd0YWJsZS1hcm0uYworKysgYi9kcml2ZXJzL2lvbW11L2lvLXBndGFibGUtYXJtLmMKQEAgLTEw
MTYsNyArMTAxNiw3IEBAIGFybV9tYWxpX2xwYWVfYWxsb2NfcGd0YWJsZShzdHJ1Y3QgaW9fcGd0
YWJsZV9jZmcgKmNmZywgdm9pZCAqY29va2llKQogewogCXN0cnVjdCBpb19wZ3RhYmxlICppb3A7
CiAKLQlpZiAoY2ZnLT5pYXMgIT0gNDggfHwgY2ZnLT5vYXMgPiA0MCkKKwlpZiAoY2ZnLT5pYXMg
PiA0OCB8fCBjZmctPm9hcyA+IDQwKQogCQlyZXR1cm4gTlVMTDsKIAogCWNmZy0+cGdzaXplX2Jp
dG1hcCAmPSAoU1pfNEsgfCBTWl8yTSB8IFNaXzFHKTsKLS0gCjIuMTcuMQoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0Cmlv
bW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
