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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8CFC04AAF
	for <iommu@archiver.kernel.org>; Tue, 21 May 2019 16:11:27 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 342E421743
	for <iommu@archiver.kernel.org>; Tue, 21 May 2019 16:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfdW1XdD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 342E421743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C5189C5D;
	Tue, 21 May 2019 16:11:15 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D7785C64
	for <iommu@lists.linux-foundation.org>;
	Tue, 21 May 2019 16:11:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 56FCDE3
	for <iommu@lists.linux-foundation.org>;
	Tue, 21 May 2019 16:11:13 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id s17so19304939wru.3
	for <iommu@lists.linux-foundation.org>;
	Tue, 21 May 2019 09:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=2w/o0YvWj4GW2dKc8xosf8L/TwKxnX3w/M6Sh7NSyHk=;
	b=DfdW1XdDhItosbvciVXVrDVugIjIifv3cMUMU94Jp8X2FK0ZQxxAZxbv2Qn6Fn5cQw
	49oQd6X322hDf8QS0nhTjEWv5J8P0acGtDtNKgQZuxIKRTV9u11Hl+bRwOWopyqopQ+Y
	Lonri78CM6AFUOHPJRHIFr/dOLafFuQxH2L5XPIYZqgW3eN7bPO9qFdCmfynZBpAgiLx
	Xqs7gEgHeQrAWN7IkS+ExBahYnEL7Dy2Cq0ITBOFdyerMgXruyGZs3ON566JrInM7H17
	YfImRCPSTYENl1tnCSf11UodIQ3LinQlSKeR8WR7i6XeC618r8r7hUfdpgHQDMKqPUrG
	VkoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=2w/o0YvWj4GW2dKc8xosf8L/TwKxnX3w/M6Sh7NSyHk=;
	b=NsAb5O6CQNBSV/l1nEjdXwRgAoKi/fBrvHEtATIaeFrwbK3x4AW2s0bFE1BFWyGopI
	wDRigLrX5Loxk66rtFaBxcZkNxdd4rltQ5w3SX7+dbHxC15fnQndKw9LCXBFlM4B/2CD
	MiLs57X5l2aFbEzn42Fq+g204etz6nh9GiM1iKSDmejP8i9/xMQwVYC07NJ6LLC7yoVQ
	taV/oMIH4fPIYTk/J0HgDTIOkyUu1J0/4mgOSI8LtR6CCS6uUnMe0G42kOZ2Psb+UpVA
	raASxUXtHEQqJuvsNzd++icnzwEBezRfR8kTVlV0Lnt0s4Fs2pETOG3OiGoqiEk7AFWW
	+e5Q==
X-Gm-Message-State: APjAAAUcPipN0PSItitpFjzc4nNgFj0dzEh6vmIb5NBjE5QjUj3inehv
	oWXWhSiq8UqC1FXhhXpvUy0=
X-Google-Smtp-Source: APXvYqz4fOGHvkVpsU0vd/YhoaBrRo3VTMc09JZktSMeJdb5LD0oTWIQjOnhKTvCK0VzAq2eMZnopQ==
X-Received: by 2002:adf:f78d:: with SMTP id q13mr1959297wrp.220.1558455071876; 
	Tue, 21 May 2019 09:11:11 -0700 (PDT)
Received: from localhost.localdomain (18.189-60-37.rdns.acropolistelecom.net.
	[37.60.189.18]) by smtp.gmail.com with ESMTPSA id
	n63sm3891094wmn.38.2019.05.21.09.11.10
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 21 May 2019 09:11:11 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
	Tomeu Vizoso <tomeu.vizoso@collabora.com>,
	Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Neil Armstrong <narmstrong@baylibre.com>,
	Steven Price <steven.price@arm.com>
Subject: [PATCH v6 3/6] dt-bindings: gpu: add bus clock for Mali Midgard GPUs
Date: Tue, 21 May 2019 18:10:59 +0200
Message-Id: <20190521161102.29620-4-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190521161102.29620-1-peron.clem@gmail.com>
References: <20190521161102.29620-1-peron.clem@gmail.com>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
	=?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
	linux-arm-kernel@lists.infradead.org, Icenowy Zheng <icenowy@aosc.io>
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

RnJvbTogSWNlbm93eSBaaGVuZyA8aWNlbm93eUBhb3NjLmlvPgoKU29tZSBTb0NzIGFkZHMgYSBi
dXMgY2xvY2sgZ2F0ZSB0byB0aGUgTWFsaSBNaWRnYXJkIEdQVS4KCkFkZCB0aGUgYmluZGluZyBm
b3IgdGhlIGJ1cyBjbG9jay4KClNpZ25lZC1vZmYtYnk6IEljZW5vd3kgWmhlbmcgPGljZW5vd3lA
YW9zYy5pbz4KU2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgUMOpcm9uIDxwZXJvbi5jbGVtQGdtYWls
LmNvbT4KUmV2aWV3ZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+Ci0tLQogRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2dwdS9hcm0sbWFsaS1taWRnYXJkLnR4dCB8
IDYgKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2dwdS9hcm0sbWFsaS1taWRnYXJkLnR4
dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ncHUvYXJtLG1hbGktbWlkZ2Fy
ZC50eHQKaW5kZXggMWIxYTc0MTI5MTQxLi4yZThiYmNlMzU2OTUgMTAwNjQ0Ci0tLSBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ncHUvYXJtLG1hbGktbWlkZ2FyZC50eHQKKysr
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2dwdS9hcm0sbWFsaS1taWRnYXJk
LnR4dApAQCAtMzEsNiArMzEsMTIgQEAgT3B0aW9uYWwgcHJvcGVydGllczoKIAogLSBjbG9ja3Mg
OiBQaGFuZGxlIHRvIGNsb2NrIGZvciB0aGUgTWFsaSBNaWRnYXJkIGRldmljZS4KIAorLSBjbG9j
ay1uYW1lcyA6IFNwZWNpZnkgdGhlIG5hbWVzIG9mIHRoZSBjbG9ja3Mgc3BlY2lmaWVkIGluIGNs
b2NrcworICB3aGVuIG11bHRpcGxlIGNsb2NrcyBhcmUgcHJlc2VudC4KKyAgICAqIGNvcmU6IGNs
b2NrIGRyaXZpbmcgdGhlIEdQVSBpdHNlbGYgKFdoZW4gb25seSBvbmUgY2xvY2sgaXMgcHJlc2Vu
dCwKKyAgICAgIGFzc3VtZSBpdCdzIHRoaXMgY2xvY2suKQorICAgICogYnVzOiBidXMgY2xvY2sg
Zm9yIHRoZSBHUFUKKwogLSBtYWxpLXN1cHBseSA6IFBoYW5kbGUgdG8gcmVndWxhdG9yIGZvciB0
aGUgTWFsaSBkZXZpY2UuIFJlZmVyIHRvCiAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9yZWd1bGF0b3IvcmVndWxhdG9yLnR4dCBmb3IgZGV0YWlscy4KIAotLSAKMi4xNy4xCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWls
aW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
