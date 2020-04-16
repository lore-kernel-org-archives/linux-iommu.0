Return-Path: <SRS0=meaX=6A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64D6C2D0EF
	for <iommu@archiver.kernel.org>; Thu, 16 Apr 2020 04:25:51 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C4132076D
	for <iommu@archiver.kernel.org>; Thu, 16 Apr 2020 04:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wydQ1wV/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C4132076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 20C0786430;
	Thu, 16 Apr 2020 04:25:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BsBRSF1owshC; Thu, 16 Apr 2020 04:25:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7273A838B8;
	Thu, 16 Apr 2020 04:25:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51CC6C1D7F;
	Thu, 16 Apr 2020 04:25:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 118D2C089E
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 04:25:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id F07C9203CA
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 04:25:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KKR5au62ZD28 for <iommu@lists.linux-foundation.org>;
 Thu, 16 Apr 2020 04:25:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com
 [209.85.216.68])
 by silver.osuosl.org (Postfix) with ESMTPS id 1C06D20354
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 04:25:48 +0000 (UTC)
Received: by mail-pj1-f68.google.com with SMTP id t40so826333pjb.3
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 21:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=rKdwxJq97I01y7ryQhSihbE5DvwLxtqugoVKkJX3ixQ=;
 b=wydQ1wV/OhVMd3QRFRKKNzkbsnXsrk7VwwEFQLbqM5ghK2myZ3rUwtN43+86ag5Yt2
 TOVAOmy3v83wlL5xBTadZIUPf+hW0tBsAuWepalWfrbGXhvYreeXUsNypMLEaIpgpwvr
 PdXGZjbSqpgXelubvmrELN3048hxl5mUCg3NnN2b4krIxxmP0EodZKg13/EFYF9wHYZu
 th6OcVEd1GYkAlpaK0/CDS+PavGH/YJhb9gM6FMd2Hn30UAhBpPttl/yVOnQckXFs1+9
 ByjKBlDgOAaMd4fSyIWUuB3lXPe1GalgZBYhX0Jk2ev8iAwwfXtj7rBzBsG2jmmx/old
 tBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=rKdwxJq97I01y7ryQhSihbE5DvwLxtqugoVKkJX3ixQ=;
 b=E3fv/xaPKWOpj3HM80R1kWQfK39r6zXP0jwlKZIIQKb5/Qa+hxowGFmtBzRExPw2kL
 xhuSoYVPJ94w7HzvIa08esGubaxQCQMyOuNwOdZgYg5NWzaYgmvawAoqzwXjS77iaBsa
 arV3H4xYHaoaz4Vy4OIIGRXQ37KsmZyf239QdXU5XQ5kp6s6nx/bhQCKaeG3WMHrXF66
 /KgzMijfdXtfT41i8giSvBif/Y8o2+u2Gl8/kCo7fGnmi6x0GOsau0vgvt/pH0uHQ3rY
 64FUcajv7g/LJvy6wAAXaY4jQdkoL6OVBv5/eY5XKy56a/GZ4OmAxMkWug2VlfCN5Zs5
 MvyA==
X-Gm-Message-State: AGi0PuaN6Odzogv4P4bPJN+OQxw+vIWgOE7OuhHgSkol6U+RIQqMmftN
 lI4lFNv+Q6GGaLc8MUXPfIJzgA==
X-Google-Smtp-Source: APiQypIcBT/ktZ74DASZLCa7QPuT/QUI+4S8qRnrlE/V9pcUl97OuPwTBQpFJ7Cl/s+5dnZ05jLWvw==
X-Received: by 2002:a17:90b:3547:: with SMTP id
 lt7mr2650982pjb.96.1587011147553; 
 Wed, 15 Apr 2020 21:25:47 -0700 (PDT)
Received: from [10.129.0.126] ([45.135.186.84])
 by smtp.gmail.com with ESMTPSA id e29sm10568241pgn.57.2020.04.15.21.25.38
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Apr 2020 21:25:47 -0700 (PDT)
Subject: Re: [PATCH v11 00/13] SMMUv3 Nested Stage Setup (IOMMU part)
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, will@kernel.org,
 joro@8bytes.org, maz@kernel.org, robin.murphy@arm.com
References: <20200414150607.28488-1-eric.auger@redhat.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <eb27f625-ad7a-fcb5-2185-5471e4666f09@linaro.org>
Date: Thu, 16 Apr 2020 12:25:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200414150607.28488-1-eric.auger@redhat.com>
Content-Language: en-US
Cc: jean-philippe@linaro.org, peter.maydell@linaro.org,
 alex.williamson@redhat.com, bbhushan2@marvell.com
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

CgpPbiAyMDIwLzQvMTQg5LiL5Y2IMTE6MDUsIEVyaWMgQXVnZXIgd3JvdGU6Cj4gVGhpcyB2ZXJz
aW9uIGZpeGVzIGFuIGlzc3VlIG9ic2VydmVkIGJ5IFNoYW1lZXIgb24gYW4gU01NVSAzLjIsCj4g
d2hlbiBtb3ZpbmcgZnJvbSBkdWFsIHN0YWdlIGNvbmZpZyB0byBzdGFnZSAxIG9ubHkgY29uZmln
Lgo+IFRoZSAyIGhpZ2ggNjRiIG9mIHRoZSBTVEUgbm93IGdldCByZXNldC4gT3RoZXJ3aXNlLCBs
ZWF2aW5nIHRoZQo+IFMyVFRCIHNldCBtYXkgY2F1c2UgYSBDX0JBRF9TVEUgZXJyb3IuCj4KPiBU
aGlzIHNlcmllcyBjYW4gYmUgZm91bmQgYXQ6Cj4gaHR0cHM6Ly9naXRodWIuY29tL2VhdWdlci9s
aW51eC90cmVlL3Y1LjYtMnN0YWdlLXYxMV8xMC4xCj4gKGluY2x1ZGluZyB0aGUgVkZJTyBwYXJ0
KQo+IFRoZSBRRU1VIGZlbGxvdyBzZXJpZXMgc3RpbGwgY2FuIGJlIGZvdW5kIGF0Ogo+IGh0dHBz
Oi8vZ2l0aHViLmNvbS9lYXVnZXIvcWVtdS90cmVlL3Y0LjIuMC0yc3RhZ2UtcmZjdjYKPgo+IFVz
ZXJzIGhhdmUgZXhwcmVzc2VkIGludGVyZXN0IGluIHRoYXQgd29yayBhbmQgdGVzdGVkIHY5L3Yx
MDoKPiAtIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvY292ZXIvMTEwMzk5OTUvIzIzMDEy
MzgxCj4gLSBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL2NvdmVyLzExMDM5OTk1LyMyMzE5
NzIzNQo+Cj4gQmFja2dyb3VuZDoKPgo+IFRoaXMgc2VyaWVzIGJyaW5ncyB0aGUgSU9NTVUgcGFy
dCBvZiBIVyBuZXN0ZWQgcGFnaW5nIHN1cHBvcnQKPiBpbiB0aGUgU01NVXYzLiBUaGUgVkZJTyBw
YXJ0IGlzIHN1Ym1pdHRlZCBzZXBhcmF0ZWx5Lgo+Cj4gVGhlIElPTU1VIEFQSSBpcyBleHRlbmRl
ZCB0byBzdXBwb3J0IDIgbmV3IEFQSSBmdW5jdGlvbmFsaXRpZXM6Cj4gMSkgcGFzcyB0aGUgZ3Vl
c3Qgc3RhZ2UgMSBjb25maWd1cmF0aW9uCj4gMikgcGFzcyBzdGFnZSAxIE1TSSBiaW5kaW5ncwo+
Cj4gVGhlbiB0aG9zZSBjYXBhYmlsaXRpZXMgZ2V0cyBpbXBsZW1lbnRlZCBpbiB0aGUgU01NVXYz
IGRyaXZlci4KPgo+IFRoZSB2aXJ0dWFsaXplciBwYXNzZXMgaW5mb3JtYXRpb24gdGhyb3VnaCB0
aGUgVkZJTyB1c2VyIEFQSQo+IHdoaWNoIGNhc2NhZGVzIHRoZW0gdG8gdGhlIGlvbW11IHN1YnN5
c3RlbS4gVGhpcyBhbGxvd3MgdGhlIGd1ZXN0Cj4gdG8gb3duIHN0YWdlIDEgdGFibGVzIGFuZCBj
b250ZXh0IGRlc2NyaXB0b3JzIChzby1jYWxsZWQgUEFTSUQKPiB0YWJsZSkgd2hpbGUgdGhlIGhv
c3Qgb3ducyBzdGFnZSAyIHRhYmxlcyBhbmQgbWFpbiBjb25maWd1cmF0aW9uCj4gc3RydWN0dXJl
cyAoU1RFKS4KPgo+CgpUaGFua3MgRXJpYwoKVGVzdGVkIHYxMSBvbiBIaXNpbGljb24ga3VucGVu
ZzkyMCBib2FyZCB2aWEgaGFyZHdhcmUgemlwIGFjY2VsZXJhdG9yLgoxLiBuby1zdmEgd29ya3Ms
IHdoZXJlIGd1ZXN0IGFwcCBkaXJlY3RseSB1c2UgcGh5c2ljYWwgYWRkcmVzcyB2aWEgaW9jdGwu
CjIuIHZTVkEgc3RpbGwgbm90IHdvcmssIHNhbWUgYXMgdjEwLAozLsKgIHRoZSB2MTAgaXNzdWUg
cmVwb3J0ZWQgYnkgU2hhbWVlciBoYXMgYmVlbiBzb2x2ZWQswqAgZmlyc3Qgc3RhcnQgcWVtdSAK
d2l0aMKgIGlvbW11PXNtbXV2MywgdGhlbiBzdGFydCBxZW11IHdpdGhvdXTCoCBpb21tdT1zbW11
djMKNC4gbm8tc3ZhIGFsc28gd29ya3Mgd2l0aG91dMKgIGlvbW11PXNtbXV2MwoKVGVzdCBkZXRh
aWxzIGluIGh0dHBzOi8vZG9jcy5xcS5jb20vZG9jL0RSVTVvUjFOdFVFUnNlRk5MCgpUaGFua3MK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFp
bGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
