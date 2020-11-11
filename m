Return-Path: <SRS0=hwFB=ER=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FDAC388F9
	for <iommu@archiver.kernel.org>; Wed, 11 Nov 2020 16:53:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4D36206FB
	for <iommu@archiver.kernel.org>; Wed, 11 Nov 2020 16:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vrWvgsCU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4D36206FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 134A086785;
	Wed, 11 Nov 2020 16:53:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s90n2RPk2Vmp; Wed, 11 Nov 2020 16:53:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id F1A5086778;
	Wed, 11 Nov 2020 16:53:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E65DFC0889;
	Wed, 11 Nov 2020 16:53:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 002D8C016F
 for <iommu@lists.linux-foundation.org>; Wed, 11 Nov 2020 16:53:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E084786785
 for <iommu@lists.linux-foundation.org>; Wed, 11 Nov 2020 16:53:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IJjkC5uDbfYu for <iommu@lists.linux-foundation.org>;
 Wed, 11 Nov 2020 16:53:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9A9EF86778
 for <iommu@lists.linux-foundation.org>; Wed, 11 Nov 2020 16:53:01 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C1B6F20791
 for <iommu@lists.linux-foundation.org>; Wed, 11 Nov 2020 16:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605113581;
 bh=JmHvo1SzasskdROAWMoAgJ6ASA6flz7HfKula4/+Rxc=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=vrWvgsCUe3WUikOynKF6WlqA5l0n3Ae1O6V5ZPQigDunSwUXIaYX8ZofQhXb9U4LG
 Esja9EsroullITulSAV8dkBDv3SOgb7xsRWgGf6oTesxapQG9ngNCNgSOZufBQADRR
 PvjNyIoTkRIvuA/Pa4Or0KVFxrn9OX8zEqdV9Jjg=
Received: by mail-ej1-f49.google.com with SMTP id s25so3675833ejy.6
 for <iommu@lists.linux-foundation.org>; Wed, 11 Nov 2020 08:53:00 -0800 (PST)
X-Gm-Message-State: AOAM531mfqzkFCS723byIBSboeq0by53gI1w/RFAwmrk5N91+miYCu9p
 8ssbCwhiIov193Ljx3goQ08uti1vg3mlNHgx/w==
X-Google-Smtp-Source: ABdhPJzdRmYGXhqdGMuO0dJRFroeBzeq9MJGO2EU8QQlLa+CkCedj+n4fq3F2ISZsjzb4o981Dy2VwbcJ3xH0AIJoko=
X-Received: by 2002:a17:906:5f8d:: with SMTP id
 a13mr26062667eju.194.1605113579120; 
 Wed, 11 Nov 2020 08:52:59 -0800 (PST)
MIME-Version: 1.0
References: <20201111123838.15682-1-yong.wu@mediatek.com>
 <20201111123838.15682-25-yong.wu@mediatek.com>
In-Reply-To: <20201111123838.15682-25-yong.wu@mediatek.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Thu, 12 Nov 2020 00:52:48 +0800
X-Gmail-Original-Message-ID: <CAAOTY_85-PWMVh3k+P_984irVVLaEWjPSyw1amFkRaQ+x=wg=A@mail.gmail.com>
Message-ID: <CAAOTY_85-PWMVh3k+P_984irVVLaEWjPSyw1amFkRaQ+x=wg=A@mail.gmail.com>
Subject: Re: [PATCH v4 24/24] MAINTAINERS: Add entry for MediaTek IOMMU
To: Yong Wu <yong.wu@mediatek.com>
Cc: youlin.pei@mediatek.com, DTML <devicetree@vger.kernel.org>,
 Nicolas Boichat <drinkcat@chromium.org>,
 srv_heupstream <srv_heupstream@mediatek.com>, kernel-team@android.com,
 Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@google.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Evan Green <evgreen@chromium.org>,
 iommu@lists.linux-foundation.org, chao.hao@mediatek.com,
 Tomasz Figa <tfiga@google.com>, Rob Herring <robh+dt@kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
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

SGkgWW9uZzoKCllvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPiDmlrwgMjAyMOW5tDEx5pyI
MTHml6Ug6YCx5LiJIOS4i+WNiDg6NTPlr6vpgZPvvJoKPgo+IEkgYW0gdGhlIGF1dGhvciBvZiBN
ZWRpYVRlayBpb21tdSBkcml2ZXIsIGFuZCB3aWxsIHRvIG1haW50YWluIGFuZAo+IGRldmVsb3Ag
aXQgZnVydGhlci4KPiBBZGQgbXlzZWxmIHRvIGNvdmVyIHRoZXNlIGl0ZW1zLgoKUmV2aWV3ZWQt
Ynk6IENodW4tS3VhbmcgSHUgPGNodW5rdWFuZy5odUBrZXJuZWwub3JnPgoKPgo+IFNpZ25lZC1v
ZmYtYnk6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPgo+IC0tLQo+ICBNQUlOVEFJTkVS
UyB8IDkgKysrKysrKysrCj4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKykKPgo+IGRp
ZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJTCj4gaW5kZXggZTczNjM2Yjc1ZjI5
Li40NjJhODdlZTE5YzggMTAwNjQ0Cj4gLS0tIGEvTUFJTlRBSU5FUlMKPiArKysgYi9NQUlOVEFJ
TkVSUwo+IEBAIC0xMTA1Niw2ICsxMTA1NiwxNSBAQCBTOiAgICAgTWFpbnRhaW5lZAo+ICBGOiAg
ICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2kyYy9pMmMtbXQ2NXh4LnR4dAo+
ICBGOiAgICAgZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1tdDY1eHguYwo+Cj4gK01FRElBVEVLIElP
TU1VIERSSVZFUgo+ICtNOiAgICAgWW9uZyBXdSA8eW9uZy53dUBtZWRpYXRlay5jb20+Cj4gK0w6
ICAgICBpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwo+ICtMOiAgICAgbGludXgtbWVk
aWF0ZWtAbGlzdHMuaW5mcmFkZWFkLm9yZyAobW9kZXJhdGVkIGZvciBub24tc3Vic2NyaWJlcnMp
Cj4gK1M6ICAgICBTdXBwb3J0ZWQKPiArRjogICAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9pb21tdS9tZWRpYXRlayoKPiArRjogICAgIGRyaXZlcnMvaW9tbXUvbXRrLWlvbW11
Kgo+ICtGOiAgICAgaW5jbHVkZS9kdC1iaW5kaW5ncy9tZW1vcnkvbXQqLWxhcmItcG9ydC5oCj4g
Kwo+ICBNRURJQVRFSyBKUEVHIERSSVZFUgo+ICBNOiAgICAgUmljayBDaGFuZyA8cmljay5jaGFu
Z0BtZWRpYXRlay5jb20+Cj4gIE06ICAgICBCaW4gTGl1IDxiaW4ubGl1QG1lZGlhdGVrLmNvbT4K
PiAtLQo+IDIuMTguMAo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCj4gTGludXgtbWVkaWF0ZWsgbWFpbGluZyBsaXN0Cj4gTGludXgtbWVkaWF0ZWtAbGlz
dHMuaW5mcmFkZWFkLm9yZwo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtbWVkaWF0ZWsKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2lvbW11
