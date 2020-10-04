Return-Path: <SRS0=qGVY=DL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8150BC4363C
	for <iommu@archiver.kernel.org>; Sun,  4 Oct 2020 22:14:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13B16207BC
	for <iommu@archiver.kernel.org>; Sun,  4 Oct 2020 22:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DH/iZhPk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13B16207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B5F0E84E38;
	Sun,  4 Oct 2020 22:14:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ew0u6phzspVO; Sun,  4 Oct 2020 22:14:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3BDD481F20;
	Sun,  4 Oct 2020 22:14:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2551EC07FF;
	Sun,  4 Oct 2020 22:14:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10B02C0051
 for <iommu@lists.linux-foundation.org>; Sun,  4 Oct 2020 22:14:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id F38D584E2E
 for <iommu@lists.linux-foundation.org>; Sun,  4 Oct 2020 22:14:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fG3eqE-GXJtI for <iommu@lists.linux-foundation.org>;
 Sun,  4 Oct 2020 22:14:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com
 [209.85.216.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8AB4281F20
 for <iommu@lists.linux-foundation.org>; Sun,  4 Oct 2020 22:14:28 +0000 (UTC)
Received: by mail-pj1-f67.google.com with SMTP id az3so760014pjb.4
 for <iommu@lists.linux-foundation.org>; Sun, 04 Oct 2020 15:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=t9W1RzmizWeCwBcYpakzTx6FYovueP73ElzCFRmABT8=;
 b=DH/iZhPkp/SdkIc0Fg3xf7KBcnb3LPPWkCJA/yu/jKcsTV/hCsNnw1Mop59QL7n661
 ahtzLWTKQoflFATRY5mClO6mpybiHX7Et9KzAaRLN6fE/Bkz6VY5jo09Yb1LMHMhWWev
 yUSRANmnU3JPgSY9tu7Avsm1cZmRj0sBonQ8czsMAoE1X0GP6b5W5kBFOeqYch052Hpr
 Tm2AnbIdZ4n3koIgnc+AalznLukLf32GLPNbMo62CiLKAvcihoplTeJrtshX0vgoCvFg
 yFFTUw/WneDy9ic0F5vAomRFNPgqpkqTJLOZ/OfUFrN3v++CMMzRRfVER65gZG1kGA5a
 g3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=t9W1RzmizWeCwBcYpakzTx6FYovueP73ElzCFRmABT8=;
 b=Fii5L8F75CNFgJqP9IhFkQid2vOkyV4ws5Xa3WUTbQStY35WhvTvmoodBj/IGxvhkr
 w1n08/jp4FmgPj7jiSuiFIDaNcutFPxmmvHdDzfGS8X73yP0azcLcyucTyGYt5rP3RWs
 q2+/pL90nJ+jMSrs+aAslbvdmZdllfW/jo+TORVjQ301Kd0vsj2gNDOiu0sRDXE9TEcp
 K2CFM0qAFeypazaGWtRYfBaIANdQ7F8+d/qRMshCkhpYy2yOvUu7cwwiDaAA59EFme10
 aMDfrFhDyF3Pw5jIoojij1SnzL0XyJGqjZ8NNSoXXjhrT8eVuvFGBwnSY0D15O6QyB9u
 gGCA==
X-Gm-Message-State: AOAM533hVnFrvLvjsHmZa6EVm98Hx1dh0QIehxXxNt0Gbll3HbpjuJu1
 JeEFf1nZN4t0GxEmkoxEz+E=
X-Google-Smtp-Source: ABdhPJzLRV/ERzVRE2GX2LnZKQYMmKld3PsAVlA9FYquXZiXzIlgOFrIPvC2/eufW1it39x7s4bFdA==
X-Received: by 2002:a17:90b:118d:: with SMTP id
 gk13mr8139580pjb.57.1601849668165; 
 Sun, 04 Oct 2020 15:14:28 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id f12sm9139290pjm.5.2020.10.04.15.14.27
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 04 Oct 2020 15:14:27 -0700 (PDT)
Date: Sun, 4 Oct 2020 15:08:08 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v5 3/3] iommu/tegra-smmu: Add PCI support
Message-ID: <20201004220807.GC21420@Asurada-Nvidia>
References: <20201003065947.18671-1-nicoleotsuka@gmail.com>
 <20201003065947.18671-4-nicoleotsuka@gmail.com>
 <8b028e6a-de6a-6ca1-79c7-5b9c6e86c021@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8b028e6a-de6a-6ca1-79c7-5b9c6e86c021@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, thierry.reding@gmail.com, linux-tegra@vger.kernel.org
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

T24gU2F0LCBPY3QgMDMsIDIwMjAgYXQgMDU6MTY6MjBQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+IDAzLjEwLjIwMjAgMDk6NTksIE5pY29saW4gQ2hlbiDQv9C40YjQtdGCOgo+ID4g
VGhpcyBwYXRjaCBzaW1wbHkgYWRkcyBzdXBwb3J0IGZvciBQQ0kgZGV2aWNlcy4KPiA+IAo+ID4g
U2lnbmVkLW9mZi1ieTogTmljb2xpbiBDaGVuIDxuaWNvbGVvdHN1a2FAZ21haWwuY29tPgo+ID4g
UmV2aWV3ZWQtYnk6IERtaXRyeSBPc2lwZW5rbyA8ZGlnZXR4QGdtYWlsLmNvbT4KPiAKPiBTbWFs
bCBuaXQ6IHlvdXJzIHMtYiB0YWcgYWx3YXlzIHNob3VsZCBiZSB0aGUgbGFzdCBsaW5lIG9mIHRo
ZSBjb21taXQKPiBtZXNzYWdlIGJlY2F1c2UgeW91J3JlICJzaWduaW5nIHVwIiB3b3JkcyB0aGF0
IHdlcmUgd3JpdHRlbiBieSB5b3UuCj4gCj4gVGVzdGVkLWJ5OiBEbWl0cnkgT3NpcGVua28gPGRp
Z2V0eEBnbWFpbC5jb20+CgpPSy4gVGhhbmtzIGZvciB0ZXN0aW5nLCBidHcuCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdApp
b21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
