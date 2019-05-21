Return-Path: <SRS0=R8za=TV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475F7C04AAF
	for <iommu@archiver.kernel.org>; Tue, 21 May 2019 16:11:21 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AE13217D7
	for <iommu@archiver.kernel.org>; Tue, 21 May 2019 16:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARZFb59f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AE13217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 894A8C6C;
	Tue, 21 May 2019 16:11:13 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 75291BE4
	for <iommu@lists.linux-foundation.org>;
	Tue, 21 May 2019 16:11:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
	[209.85.128.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id EDFD5821
	for <iommu@lists.linux-foundation.org>;
	Tue, 21 May 2019 16:11:11 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id j187so2685140wma.1
	for <iommu@lists.linux-foundation.org>;
	Tue, 21 May 2019 09:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=r8viNroRA5goE0iPj/ap53EgAXBGfEQtlqx5YkjMMp0=;
	b=ARZFb59f/TEGR4dKn2zPIsVrlQpgAN3MkGdMyYoenwZrYx//1w/GS1vxb/zR0DiMu4
	kFpEmoMA86LR7oMglGgowJVUCRWcB4uFwzjEjBzB/TClFDnUCsAYsZGfse3m9d3Elf0X
	LZXgLoTvu2klwbc97GLhdfLn9ItpsQuHfWTsjUtfW9vQRNNk+uobllA6qAZTnTm99Ugm
	n1r7iW/h9mU0lcFEX1q+b4LjCRuTE9urqhkK56b9ItVJIMrgMcJ4E0gF0t7oqfqCy6WU
	IMfY/wZLsXkxMjbx6rkgIiucVgB9E+aq2VD6BVtbZIJW4Dj9fkmrj2Upj/QMFHowPrYh
	TkYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=r8viNroRA5goE0iPj/ap53EgAXBGfEQtlqx5YkjMMp0=;
	b=T+ZbhC1W/nzuxxQqNIL+1EabvwCQS9j9a7GAAibCe3vBET51T+nHDH8PQxGtVaKBoI
	lgdorVPugKfQsR6/rB78xdTVvFLYN2usdsJF36eJcL0Oc+aW/HFTJJCAvsMp26A82EFU
	luO6dvk5GVdvNiTXjfr35rCyfOYVYJypSfBpSrO2gJDPTyf798zYA7U6MuoxCP2b/TIc
	RjO5FBV3kaAI01I1gjETwek0k9WlsWcX35TKE5tcR9Ea3p8+6Gy0z2k48/omFLHcsHmY
	2kLAYWeBNwSGfuoq0vOuXF4x6NMTZb3b2UnRpiyor2JxhBwYHZnCZ1JVw6d92wKLO8/0
	ESUg==
X-Gm-Message-State: APjAAAUuohQX0tDZguonOyvrtA/5weaA4Qre7iLTIDVrYZSYwP1UbC7I
	VbvKw6ounkj4aNCJaNm+kjU=
X-Google-Smtp-Source: APXvYqxfxJ6RsSMMKEQ8Whf7wf2BBbNOZyqWjeSvLocsSoko9vuDWmS1j0CXAq8lGvRTLD6FP4Blfw==
X-Received: by 2002:a7b:c4d2:: with SMTP id g18mr4212516wmk.78.1558455070526; 
	Tue, 21 May 2019 09:11:10 -0700 (PDT)
Received: from localhost.localdomain (18.189-60-37.rdns.acropolistelecom.net.
	[37.60.189.18]) by smtp.gmail.com with ESMTPSA id
	n63sm3891094wmn.38.2019.05.21.09.11.09
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 21 May 2019 09:11:09 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
	Tomeu Vizoso <tomeu.vizoso@collabora.com>,
	Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Neil Armstrong <narmstrong@baylibre.com>,
	Steven Price <steven.price@arm.com>
Subject: [PATCH v6 2/6] iommu: io-pgtable: fix sanity check for non 48-bit
	mali iommu
Date: Tue, 21 May 2019 18:10:58 +0200
Message-Id: <20190521161102.29620-3-peron.clem@gmail.com>
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
