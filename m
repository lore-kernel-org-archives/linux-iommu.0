Return-Path: <SRS0=Fz8+=DJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE24CC4363C
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 16:37:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7443B206FA
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 16:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MoUkOv1b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7443B206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1C00A872EA;
	Fri,  2 Oct 2020 16:37:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id opkAxEDBN2f4; Fri,  2 Oct 2020 16:37:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A167B872E4;
	Fri,  2 Oct 2020 16:37:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9173EC016F;
	Fri,  2 Oct 2020 16:37:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA7A2C0051
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 16:37:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id DD74886AC2
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 16:37:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YydDTIzZGQgj for <iommu@lists.linux-foundation.org>;
 Fri,  2 Oct 2020 16:37:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com
 [209.85.167.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0501186AAE
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 16:37:16 +0000 (UTC)
Received: by mail-lf1-f68.google.com with SMTP id z19so2627001lfr.4
 for <iommu@lists.linux-foundation.org>; Fri, 02 Oct 2020 09:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=3s1ndk5JJzpTHJbjvHEODJg7aasvsgC96M1MqYVGaPM=;
 b=MoUkOv1bLFhwxqvQ7eJEzuUDqCvfwIHhzGJ+sSsfpRCg3Uj1Sos89Zsz4k0HwLFKNd
 3tCzaQAjhTOVo8S339v+my5Lg7RGL4x8y7w6eD7Tr7PmQqPGn3S+H0lrZivY7JmXgfdL
 fFWqSt9VnLNGzqbZy4vqu8qxTLIWeyr0+RrrbOUwuPiLEoHeOf90eklJU7vmSvYcVxnb
 s+hrQgzG3nCq0iG4YAGJR4mpA75mHDFprpbaMEiv4018f1w4SUkLO2jtJoTHtOd1nE4S
 ldDiuedoWHw3Os8wYxuYgW+o7SHfB/V/aYQ1IZbQBg8iuT2LKSlBppPnzJbn3xz1WtXa
 +7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3s1ndk5JJzpTHJbjvHEODJg7aasvsgC96M1MqYVGaPM=;
 b=GNbc9Zfttqgk927DVsNoj8ZEDi46O125Sg/FxcUgxqESdh+5Zthm8/g+pYUs345Ub5
 7J0s10VDuDoyp80HYCsUNKPPQCWVtIAwFQv4sV/Bsab7vWYYMxUFM+CWkHRHoZhdeNsZ
 NTOm/kXU+w4DDgpVBalPGPl7fNabUVPhCcjkc7Skl8w8UwFO+Xn/idO/RM9dU9Z/t+IJ
 qqC4FHsr8tN/NRNYh7esetH00BfwHb4RiDrPhC7fJrwDrTyyi3I57NGDXHien7Fdh7Tl
 ZNS+8+r8IWuw8CNuZ9eKfOyT1wHjEAoZ5ATlcZrJ5y3vlUTjLPTIaSVw3obG2Mab6OGw
 taWA==
X-Gm-Message-State: AOAM531HHhKMLtarCiNWTTz3bfkkDEskX3Jd9ymgJSuLHqWgjwq53lJV
 cUjEmsoVnI7gvB9ie3E4R30=
X-Google-Smtp-Source: ABdhPJy/fW4T4c5bEdSHlIQMolsrKNHfJpbkIgXELKvWNr4fzP2VwyMb8ATYDhe/UyfiJ1XfjaPfrQ==
X-Received: by 2002:ac2:538c:: with SMTP id g12mr1092249lfh.326.1601656633904; 
 Fri, 02 Oct 2020 09:37:13 -0700 (PDT)
Received: from [192.168.2.145] (109-252-91-252.nat.spd-mgts.ru.
 [109.252.91.252])
 by smtp.googlemail.com with ESMTPSA id t14sm383650lfp.77.2020.10.02.09.37.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2020 09:37:12 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] iommu/tegra-smmu: Rework tegra_smmu_probe_device()
From: Dmitry Osipenko <digetx@gmail.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>, thierry.reding@gmail.com,
 joro@8bytes.org, Maxime Ripard <maxime@cerno.tech>
References: <20201002060807.32138-1-nicoleotsuka@gmail.com>
 <20201002060807.32138-3-nicoleotsuka@gmail.com>
 <99d322d0-efb5-8a34-ee83-b907b785ced3@gmail.com>
 <3ecfe9ae-fa32-8384-c912-4e17ff5fede7@gmail.com>
Message-ID: <6018e1c5-9ddd-3e37-1d6b-3feb969a7474@gmail.com>
Date: Fri, 2 Oct 2020 19:37:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3ecfe9ae-fa32-8384-c912-4e17ff5fede7@gmail.com>
Content-Language: en-US
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jonathanh@nvidia.com
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

MDIuMTAuMjAyMCAxOTowMCwgRG1pdHJ5IE9zaXBlbmtvINC/0LjRiNC10YI6Cj4gMDIuMTAuMjAy
MCAxODoyMywgRG1pdHJ5IE9zaXBlbmtvINC/0LjRiNC10YI6Cj4+IDAyLjEwLjIwMjAgMDk6MDgs
IE5pY29saW4gQ2hlbiDQv9C40YjQtdGCOgo+Pj4gVGhlbiB3aGVuIGEgY2xpZW50IGdldHMgcHJv
YmVkLCBvZl9pb21tdV9jb25maWd1cmUoKSBpbgo+Pj4gaW9tbXUgY29yZSB3aWxsIHNlYXJjaCBE
VEIgZm9yIHN3Z3JvdXAgSUQgYW5kIGNhbGwgLT5vZl94bGF0ZSgpCj4+PiB0byBwcmVwYXJlIGFu
IGZ3c3BlYywgc2ltaWxhciB0byB0ZWdyYV9zbW11X3Byb2JlX2RldmljZSgpIGFuZAo+Pj4gdGVn
cmFfc21tdV9jb25maWd1cmUoKS4gVGhlbiBpdCdsbCBjYWxsIHRlZ3JhX3NtbXVfcHJvYmVfZGV2
aWNlKCkKPj4+IGFnYWluLCBhbmQgdGhpcyB0aW1lIHdlIHNoYWxsIHJldHVybiBzbW11LT5pb21t
dSBwb2ludGVyIHByb3Blcmx5Lgo+Pgo+PiBJIGRvbid0IHF1aXRlIHNlZSB3aGVyZSBJT01NVSBj
b3JlIGNhbGxzIG9mX3hsYXRlKCkuCj4+Cj4+IEhhdmUgdHJpZWQgdG8gYXQgbGVhc3QgYm9vdC10
ZXN0IHRoaXMgcGF0Y2g/Cj4+Cj4gCj4gSSBkb24ndCBzZWUgaG93IGl0IGV2ZXIgY291bGQgd29y
ayBiZWNhdXNlIG9mX3hsYXRlKCkgaXMgb25seSBpbnZva2VkIGZyb206Cj4gCj4gZnNsX21jX2Rt
YV9jb25maWd1cmUoKS0+b2ZfZG1hX2NvbmZpZ3VyZV9pZCgpLT5vZl9pb21tdV9jb25maWd1cmUo
KQo+IAo+IExvb2tzIGxpa2UgdGhlIHRlZ3JhX3NtbXVfY29uZmlndXJlKCkgaXMgc3RpbGwgbmVl
ZGVkLgo+IAo+IEkgZG9uJ3Qga25vdyBob3cgc3VuNTBpIGRyaXZlciBjb3VsZCB3b3JrIHRvIGJl
IGhvbmVzdC4gU2VlbXMgSU9NTVUgaXMKPiBicm9rZW4gb24gc3VuNTBpLCBidXQgbWF5YmUgSSdt
IG1pc3Npbmcgc29tZXRoaW5nLgo+IAo+IEkgYWRkZWQgTWF4aW1lIFJpcGFyZCB0byB0aGlzIHRo
cmVhZCwgd2hvIGlzIHRoZSBhdXRob3Igb2YgdGhlCj4gc3VuNTBpLWlvbW11IGRyaXZlci4KPiAK
CkFjdHVhbGx5LCBJIG5vdyBzZWUgdGhhdCB0aGUgb3RoZXIgSU9NTVUgZHJpdmVycyAocWNvbSwg
ZXh5bm9zLCBldGMpIGRvCnRoZSBzYW1lLiBTbyBvYnZpb3VzbHkgSSdtIG1pc3Npbmcgc29tZXRo
aW5nIGFuZCBpdCBzaG91bGQgd29yay4uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby9pb21tdQ==
