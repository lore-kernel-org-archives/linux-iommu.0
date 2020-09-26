Return-Path: <SRS0=cnVx=DD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C274C2D0A8
	for <iommu@archiver.kernel.org>; Sat, 26 Sep 2020 21:25:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BEB521D7F
	for <iommu@archiver.kernel.org>; Sat, 26 Sep 2020 21:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nynDsskn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BEB521D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id AD5F2871A5;
	Sat, 26 Sep 2020 21:25:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PmwdK+koPGcD; Sat, 26 Sep 2020 21:25:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1EE568716A;
	Sat, 26 Sep 2020 21:25:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EFDA7C0889;
	Sat, 26 Sep 2020 21:25:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72AB7C0051
 for <iommu@lists.linux-foundation.org>; Sat, 26 Sep 2020 21:24:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5B80685F7E
 for <iommu@lists.linux-foundation.org>; Sat, 26 Sep 2020 21:24:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4ZkDzRMtKExv for <iommu@lists.linux-foundation.org>;
 Sat, 26 Sep 2020 21:24:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com
 [209.85.167.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id CF44F8535F
 for <iommu@lists.linux-foundation.org>; Sat, 26 Sep 2020 21:24:57 +0000 (UTC)
Received: by mail-lf1-f68.google.com with SMTP id x69so6736572lff.3
 for <iommu@lists.linux-foundation.org>; Sat, 26 Sep 2020 14:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6wrB9fto+I1fUbDhgF+w5avJWzjFlsE3ApMnh8XsGZM=;
 b=nynDsskn2v5Qu272LIVZKOws9vaysTXN5vZ6JQgTLmnYG1jrb3q4FxGnFq+y5VkL7g
 F+N1QjZGNJnUDcmqPg0DxMXiwjXcf8VG84KBs513JJt4z2Zd394TptCU8mBo9swAiPeo
 TjgKgJiUZZ6pMVRnm9NpPtt2m8UeTBDdWBpjLyxFWr/hVZvhKLm0FyCEGpIvroNUIZ2l
 hA4x8IOpmhQyxaaoYB1uew6JOlinbvr3kQ2L/0wPhi+attppdLmUtK/fZN/jbrm9/WhO
 XKIlXDf1CL1zOkSWm0v32SrO3w1L6YzBke7RR/+u0xI3/7337PnPXG5g76qoNtBu3aGQ
 F01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6wrB9fto+I1fUbDhgF+w5avJWzjFlsE3ApMnh8XsGZM=;
 b=FuynNUxOQNqEOeuX/C6eJXOQxPRT8CVnWDzJ3agALUNFAYj3KQ9Rri6rCarxdtKYL2
 +SzyekVkSClW8cmE1qCAzLas8s993ho/Ac7Lhcm+3mklcgGteOo7bNNohxnuBTavNpEr
 pvJ6m0gCrAWjs7FOeZjlObpk5H6rG65odaibw2f2KmDcnYAe9ctPb5tiLUd4g4cbKjBE
 P7A26TAGDu9k/Iy1gtbsMnH829HDk47Ks8QLvnh2pY+3Z9RujA+yD3tieWWFt0hkc3vd
 Gd7WK59b2jY6miAuQbynEsUGAxT2Fo+jjC8Ki/wtvBC6eBFo1ITChGUAjkPfMxn3P8DM
 qx6Q==
X-Gm-Message-State: AOAM531DsALJEGLEAXuIo6H0tlUuXNYD0wZAl3z7rxvXjz+HxNdR4fTp
 57cz7xMfnBVktPX4seBknOs=
X-Google-Smtp-Source: ABdhPJxT9fBzeCt7l5s5mHsDyMF6JTcv7kgGvdkxvGDECbJLHk4gNOOOtmGLdqsWW1tTLW51rYsfGA==
X-Received: by 2002:ac2:4559:: with SMTP id j25mr1442963lfm.484.1601155496084; 
 Sat, 26 Sep 2020 14:24:56 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru.
 [109.252.170.211])
 by smtp.googlemail.com with ESMTPSA id b8sm2124820lfq.144.2020.09.26.14.24.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Sep 2020 14:24:55 -0700 (PDT)
Subject: Re: [PATCH 5/5] iommu/tegra-smmu: Add pagetable mappings to debugfs
To: Nicolin Chen <nicoleotsuka@gmail.com>, thierry.reding@gmail.com,
 joro@8bytes.org, krzk@kernel.org
References: <20200926080719.6822-1-nicoleotsuka@gmail.com>
 <20200926080719.6822-6-nicoleotsuka@gmail.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0451e362-30eb-2ba2-33f1-e9ab3972cada@gmail.com>
Date: Sun, 27 Sep 2020 00:24:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200926080719.6822-6-nicoleotsuka@gmail.com>
Content-Language: en-US
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, jonathanh@nvidia.com
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

MjYuMDkuMjAyMCAxMTowNywgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Ci4uLgo+ICsJZm9yIChw
ZF9pbmRleCA9IDA7IHBkX2luZGV4IDwgU01NVV9OVU1fUERFOyBwZF9pbmRleCsrKSB7Cj4gKwkJ
c3RydWN0IHBhZ2UgKnB0Owo+ICsJCXUzMiAqYWRkcjsKPiArCj4gKwkJaWYgKCFhcy0+Y291bnRb
cGRfaW5kZXhdIHx8ICFwZFtwZF9pbmRleF0pCj4gKwkJCWNvbnRpbnVlOwoKSSBndWVzcyB0aGUg
aWRlYSBvZiB0aGlzIHBhdGNoIGlzIHRvIHByaW50IG91dCB0aGUgaGFyZHdhcmUgc3RhdGUsIGlz
bid0Cml0PyBIZW5jZSB0aGUgYXMtPmNvdW50IHNob3VsZG4ndCBiZSBjaGVja2VkIGhlcmUuCgo+
ICsJCXBkZV9jb3VudCsrOwo+ICsJCXB0ZV9jb3VudCArPSBhcy0+Y291bnRbcGRfaW5kZXhdOwo+
ICsJCXNlcV9wcmludGYocywgIlx0WyVkXSAweCV4ICglZClcbiIsCj4gKwkJCSAgIHBkX2luZGV4
LCBwZFtwZF9pbmRleF0sIGFzLT5jb3VudFtwZF9pbmRleF0pOwo+ICsJCXB0ID0gYXMtPnB0c1tw
ZF9pbmRleF07Cj4gKwkJYWRkciA9IHBhZ2VfYWRkcmVzcyhwdCk7Cj4gKwo+ICsJCXNlcV9wdXRz
KHMsICJcdHtcbiIpOwo+ICsJCXNlcV9wcmludGYocywgIlx0XHQlLTVzICUtNHMgJTEycyAlMTJz
XG4iLCAiUERFIiwgIkFUVFIiLCAiUEhZUyIsICJJT1ZBIik7Cj4gKwkJZm9yIChwdF9pbmRleCA9
IDA7IHB0X2luZGV4IDwgU01NVV9OVU1fUFRFOyBwdF9pbmRleCsrKSB7Cj4gKwkJCXU2NCBpb3Zh
Owo+ICsKPiArCQkJaWYgKCFhZGRyW3B0X2luZGV4XSkKPiArCQkJCWNvbnRpbnVlOwo+ICsKPiAr
CQkJaW92YSA9ICgoZG1hX2FkZHJfdClwZF9pbmRleCAmIChTTU1VX05VTV9QREUgLSAxKSkgPDwg
U01NVV9QREVfU0hJRlQ7Cj4gKwkJCWlvdmEgfD0gKChkbWFfYWRkcl90KXB0X2luZGV4ICYgKFNN
TVVfTlVNX1BURSAtIDEpKSA8PCBTTU1VX1BURV9TSElGVDsKPiArCj4gKwkJCXNlcV9wcmludGYo
cywgIlx0XHQjJS00ZCAweCUtNHggMHglLTEybGx4IDB4JS0xMmxseFxuIiwKPiArCQkJCSAgIHB0
X2luZGV4LCBhZGRyW3B0X2luZGV4XSA+PiBTTU1VX1BURV9BVFRSX1NISUZULAo+ICsJCQkJICAg
U01NVV9QRk5fUEhZUyhhZGRyW3B0X2luZGV4XSAmIH5TTU1VX1BURV9BVFRSKSwgaW92YSk7Cj4K
CldvdWxkIGJlIG5pY2UgaWYgeW91IGNvdWxkIGltcHJvdmUgdGhlIG91dHB1dCBmb3JtYXR0aW5n
IGJ5IHByaW50aW5nIG91dApjb250aWd1b3VzIHJhbmdlcyB0aGF0IGhhdmUgdGhlIHNhbWUgQVRU
UnMsIG90aGVyd2lzZSBpdCBjb3VsZCBiZSBhIGJpdAp0b28gbGFyZ2UgYW5kIHVucHJhY3RpY2Fs
IG91dHB1dCBpbiBhIGNhc2UgaWYgbG90cyBvZiBwYWdlcyBhcmUgbWFwcGVkLgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QK
aW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
