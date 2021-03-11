Return-Path: <SRS0=X4VR=IJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9672C433E6
	for <iommu@archiver.kernel.org>; Thu, 11 Mar 2021 10:03:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 394DB64EB2
	for <iommu@archiver.kernel.org>; Thu, 11 Mar 2021 10:03:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 394DB64EB2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C8265400D6;
	Thu, 11 Mar 2021 10:03:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tox2djD5zgdB; Thu, 11 Mar 2021 10:03:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id B8B95414EF;
	Thu, 11 Mar 2021 10:03:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A3BEC000F;
	Thu, 11 Mar 2021 10:03:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97096C000B
 for <iommu@lists.linux-foundation.org>; Thu, 11 Mar 2021 10:03:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7A7BF4EC26
 for <iommu@lists.linux-foundation.org>; Thu, 11 Mar 2021 10:03:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8B66FwTOqFq3 for <iommu@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 10:03:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B5AC34E95A
 for <iommu@lists.linux-foundation.org>; Thu, 11 Mar 2021 10:03:02 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D6D464EB2
 for <iommu@lists.linux-foundation.org>; Thu, 11 Mar 2021 10:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615456982;
 bh=IZhUOXZQW97SEt7AhdlCVGpiMiD01alkMKMxSkgoqA4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=hhek4bkZm18w24Okb8oRsTjg5ku5rDQgBkrVhj2p+trM4twZ9ySmIxuMmhbdD07dM
 KSbVuS7Ng+FRzsd0WwIc/nPAZBcZoysXO3BuhR5D2IfYEa9HR4fn+CYiljdIzBnfdx
 /4PdKrScmDZRhZHrJrsGiMj7WhQE/PHdYz2ii41HlKQJMyneMtKwf1HvL9rKWTetOK
 djQuxxxmJgmT8/ojlZPnhTVBrhuf2YsNbiAMP5ZepBqDLFJWOlXDzFdIOT/dX/QjL4
 qSSdJwUhwNgjRNwcz7OHrn1rRQTJG7+mnaDnfRWyFo7x216lrwoIpcGBa0VxmTpX7a
 8PkPlb829MINQ==
Received: by mail-oi1-f177.google.com with SMTP id q130so3584093oif.13
 for <iommu@lists.linux-foundation.org>; Thu, 11 Mar 2021 02:03:02 -0800 (PST)
X-Gm-Message-State: AOAM530tiW2XsJsDGBTerzwoc0+HkBAORql7MOIsAWsbWSo1og/Au+I4
 oh5u66ZGwPPg5N17nFcKmjSNWisyBg90bUQkXpw=
X-Google-Smtp-Source: ABdhPJxLTmcDG+0JhaCSbXj4D7tIF854J7GKcMpDtXvjaR2X2Vi+hMCv3Iykk8MoF7qSYLVxBL/Byug4zmEzJ80cyYA=
X-Received: by 2002:aca:1218:: with SMTP id 24mr61853ois.11.1615456981295;
 Thu, 11 Mar 2021 02:03:01 -0800 (PST)
MIME-Version: 1.0
References: <4c692eff-9d57-278e-8da4-36bc2c293506@amd.com>
 <20210309032356.20800-1-Felix.Kuehling@amd.com>
 <CAK8P3a1EeHimbufajcHzV+-bBarWtLHzzFSsa=qdUDsip=Wz_A@mail.gmail.com>
 <8023bb6b-b6aa-230c-afa5-871ce32782c6@amd.com> <YEexf0/V/YF394bf@myrica>
 <CADnq5_OTeK7-nN57+F+WE+Hdg86uiuTN8c_n0bmCtx40N_wraQ@mail.gmail.com>
 <7831d401-d1ec-13bb-0b3f-b0e0a1a63f7c@amd.com>
In-Reply-To: <7831d401-d1ec-13bb-0b3f-b0e0a1a63f7c@amd.com>
From: Arnd Bergmann <arnd@kernel.org>
Date: Thu, 11 Mar 2021 11:02:44 +0100
X-Gmail-Original-Message-ID: <CAK8P3a05c8nyYXwy0L65vZaAofdjD3DzuKiyNVsUVeWWQaQDEA@mail.gmail.com>
Message-ID: <CAK8P3a05c8nyYXwy0L65vZaAofdjD3DzuKiyNVsUVeWWQaQDEA@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/amdkfd: fix build error with AMD_IOMMU_V2=m
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 David Airlie <airlied@linux.ie>, Felix Kuehling <felix.kuehling@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexdeucher@gmail.com>, Will Deacon <will@kernel.org>
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

T24gVHVlLCBNYXIgOSwgMjAyMSBhdCA3OjM0IFBNIENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlh
bi5rb2VuaWdAYW1kLmNvbT4gd3JvdGU6Cj4gQW0gMDkuMDMuMjEgdW0gMTg6NTkgc2NocmllYiBB
bGV4IERldWNoZXI6Cj4KPiBUaGVyZSBoYXMgYmVlbiBxdWl0ZSBzb21lIGVmZm9ydCBmb3IgdGhp
cyBhbHJlYWR5IGZvciBnZW5lcmljIFBBU0lECj4gaW50ZXJmYWNlIGV0Yy4uIEJ1dCBpdCBsb29r
cyBsaWtlIHRoYXQgZWZmb3J0IGlzIHN0YWxsZWQgYnkgbm93Lgo+Cj4gQW55d2F5IGF0IGxlYXN0
IEknbSBwZXJmZWN0bHkgZmluZSB0byBoYXZlIHRoZSBJT01NVXYyIHx8ICFJT01NVXYyCj4gZGVw
ZW5kZW5jeSBvbiB0aGUgY29yZSBhbWRncHUgZHJpdmVyIGZvciB4ODYuCj4KPiBUaGF0IHNob3Vs
ZCBzb2x2ZSB0aGUgYnVpbGQgcHJvYmxlbSBhdCBoYW5kIHF1aXRlIG5pY2VseS4KClJpZ2h0LCB0
aGF0IHNvdW5kcyBiZXR0ZXIgdGhhbiB0aGUgSVNfUkVBQ0hBQkxFKCkgaGFjaywgYW5kIHdvdWxk
IGZpeAp0aGUgaW1tZWRpYXRlIGJ1aWxkIHJlZ3Jlc3Npb24gdW50aWwgdGhlIGRyaXZlciBpcyBj
aGFuZ2VkIHRvIHVzZSB0aGUgcHJvcGVyCklPTU1VIGludGVyZmFjZXMuCgogICAgICAgQXJuZApf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWls
aW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
