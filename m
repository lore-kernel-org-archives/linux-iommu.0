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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6724C04AAF
	for <iommu@archiver.kernel.org>; Tue, 21 May 2019 16:11:34 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BEED21743
	for <iommu@archiver.kernel.org>; Tue, 21 May 2019 16:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBYZazpR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BEED21743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0736DC83;
	Tue, 21 May 2019 16:11:17 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 11025C37
	for <iommu@lists.linux-foundation.org>;
	Tue, 21 May 2019 16:11:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8EB24E3
	for <iommu@lists.linux-foundation.org>;
	Tue, 21 May 2019 16:11:14 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id d9so6325853wrx.0
	for <iommu@lists.linux-foundation.org>;
	Tue, 21 May 2019 09:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=uWjp5N7/2gycMhkjj4F7Je3PI1NUTqU00O1ySy3vSNY=;
	b=mBYZazpRj6EVU7E58MdMi7y+AJ+HedRo3jJJlcg9GWps2CdOi9yPkeRg9EXQZMZ4w0
	lHyOVHvQG/bLCCwVRejE/7v04UpUP4UNkRSoaITOErYNy7bzb4VrnNwAyPY400UzjMIm
	izWERToMX4dzCYvZS7q6lhOmCb5swJ9Npb9pmBtTO4UqvMD73p7YaSOqPmcIuIIRS127
	HaB7/2461amKirTxJ9/9fSDjuy4xeFxCfkA/tMLFaytIcbIjoUhUlLL2E1booh329WNV
	yagjPAkc1KFlf0HzEennc6ozheuvQABWQgPSgZG/NsrQrg32jV46+A96j/6cedbM2qp4
	4SgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=uWjp5N7/2gycMhkjj4F7Je3PI1NUTqU00O1ySy3vSNY=;
	b=e7ABa+j702nRejA9YAIJ0N9JEF9Bs5rVBi/5LWedD6I9p9/ixiGpp0sd2gbVkPU6TD
	GWpsMfOAEdEqYfC/S4yjuxpEGpiFDoRfQ9QiDRRutmL+eo0jnkOlkkZfGfZcKGE7FajO
	Mj3ldMFxzf3NsWrcwIRNasDzowN14BP5DrzHshCIBX0KaQqHzgxS0YLBGpUGkGUJj6z4
	SVaZCg35j6JcKMBAtlnNd+LQvf3WdhoLvCMExm0CrafyweoPvP3aSY0j5BUMXx7P8lT3
	VlD9r8JsFq4Vor7OSRIXZwq1ah6RJke2umpUWDlIAQzW/b6/Rg4Tug6CsBVICWexEzGB
	jYew==
X-Gm-Message-State: APjAAAX1PUdkQKppdYoSPG0q7dIo3wJa9KTCDR/WLhqgPOR5eIr8C/JQ
	BSBp3BwDtmAgcsCBfNXMv/s=
X-Google-Smtp-Source: APXvYqzyKZ0rTYgJlTdwuX2CPB9g3HFvHZgguGxqods3XjUbGjAvqDQc2M25Gwzjc4EFEDphnvB5Pw==
X-Received: by 2002:adf:dfd0:: with SMTP id q16mr18856873wrn.235.1558455073159;
	Tue, 21 May 2019 09:11:13 -0700 (PDT)
Received: from localhost.localdomain (18.189-60-37.rdns.acropolistelecom.net.
	[37.60.189.18]) by smtp.gmail.com with ESMTPSA id
	n63sm3891094wmn.38.2019.05.21.09.11.11
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 21 May 2019 09:11:12 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
	Tomeu Vizoso <tomeu.vizoso@collabora.com>,
	Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Neil Armstrong <narmstrong@baylibre.com>,
	Steven Price <steven.price@arm.com>
Subject: [PATCH v6 4/6] dt-bindings: gpu: mali-midgard: Add H6 mali gpu
	compatible
Date: Tue, 21 May 2019 18:11:00 +0200
Message-Id: <20190521161102.29620-5-peron.clem@gmail.com>
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

VGhpcyBhZGQgdGhlIEg2IG1hbGkgY29tcGF0aWJsZSBpbiB0aGUgZHQtYmluZGluZ3MgdG8gbGF0
ZXIgc3VwcG9ydApzcGVjaWZpYyBpbXBsZW1lbnRhdGlvbi4KClNpZ25lZC1vZmYtYnk6IENsw6lt
ZW50IFDDqXJvbiA8cGVyb24uY2xlbUBnbWFpbC5jb20+ClJldmlld2VkLWJ5OiBSb2IgSGVycmlu
ZyA8cm9iaEBrZXJuZWwub3JnPgotLS0KIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2dwdS9hcm0s
bWFsaS1taWRnYXJkLnR4dCAgICAgICAgIHwgOSArKysrKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA4
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvZ3B1L2FybSxtYWxpLW1pZGdhcmQudHh0IGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2dwdS9hcm0sbWFsaS1taWRnYXJkLnR4dAppbmRleCAy
ZThiYmNlMzU2OTUuLjRiZjE3ZTFjZjU1NSAxMDA2NDQKLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2dwdS9hcm0sbWFsaS1taWRnYXJkLnR4dAorKysgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZ3B1L2FybSxtYWxpLW1pZGdhcmQudHh0CkBAIC0xNSw2
ICsxNSw3IEBAIFJlcXVpcmVkIHByb3BlcnRpZXM6CiAgICAgKyAiYXJtLG1hbGktdDg2MCIKICAg
ICArICJhcm0sbWFsaS10ODgwIgogICAqIHdoaWNoIG11c3QgYmUgcHJlY2VkZWQgYnkgb25lIG9m
IHRoZSBmb2xsb3dpbmcgdmVuZG9yIHNwZWNpZmljczoKKyAgICArICJhbGx3aW5uZXIsc3VuNTBp
LWg2LW1hbGkiCiAgICAgKyAiYW1sb2dpYyxtZXNvbi1neG0tbWFsaSIKICAgICArICJyb2NrY2hp
cCxyazMyODgtbWFsaSIKICAgICArICJyb2NrY2hpcCxyazMzOTktbWFsaSIKQEAgLTQ5LDkgKzUw
LDE1IEBAIFZlbmRvci1zcGVjaWZpYyBiaW5kaW5ncwogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
CiAKIFRoZSBNYWxpIEdQVSBpcyBpbnRlZ3JhdGVkIHZlcnkgZGlmZmVyZW50bHkgZnJvbSBvbmUg
U29DIHRvCi1hbm90aGVyLiBJbiBvcmRlciB0byBhY2NvbW9kYXRlIHRob3NlIGRpZmZlcmVuY2Vz
LCB5b3UgaGF2ZSB0aGUgb3B0aW9uCithbm90aGVyLiBJbiBvcmRlciB0byBhY2NvbW1vZGF0ZSB0
aG9zZSBkaWZmZXJlbmNlcywgeW91IGhhdmUgdGhlIG9wdGlvbgogdG8gc3BlY2lmeSBvbmUgbW9y
ZSB2ZW5kb3Itc3BlY2lmaWMgY29tcGF0aWJsZSwgYW1vbmc6CiAKKy0gImFsbHdpbm5lcixzdW41
MGktaDYtbWFsaSIKKyAgUmVxdWlyZWQgcHJvcGVydGllczoKKyAgLSBjbG9ja3MgOiBwaGFuZGxl
cyB0byBjb3JlIGFuZCBidXMgY2xvY2tzCisgIC0gY2xvY2stbmFtZXMgOiBtdXN0IGNvbnRhaW4g
ImNvcmUiIGFuZCAiYnVzIgorICAtIHJlc2V0czogcGhhbmRsZSB0byBHUFUgcmVzZXQgbGluZQor
CiAtICJhbWxvZ2ljLG1lc29uLWd4bS1tYWxpIgogICBSZXF1aXJlZCBwcm9wZXJ0aWVzOgogICAt
IHJlc2V0cyA6IFNob3VsZCBjb250YWluIHBoYW5kbGVzIG9mIDoKLS0gCjIuMTcuMQoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBs
aXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
