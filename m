Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6572C433EF
	for <iommu@archiver.kernel.org>; Tue, 14 Dec 2021 15:31:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5328F40563;
	Tue, 14 Dec 2021 15:31:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hkT6aziNO2PA; Tue, 14 Dec 2021 15:31:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1135F40125;
	Tue, 14 Dec 2021 15:31:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DCA5AC002F;
	Tue, 14 Dec 2021 15:31:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0FADC0012
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 15:31:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A183F812E5
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 15:31:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zBYdcONq4O26 for <iommu@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 15:31:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DE9C080C28
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 15:31:16 +0000 (UTC)
Received: by mail-lf1-x129.google.com with SMTP id l22so37469526lfg.7
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 07:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Cew1bsVh+uPPxFCPvivLMvnMySnBo7QVXMyLf4NUogc=;
 b=EIBs/m05yVAVjNZxKsVu8Oh0Ra+ssLFinvG7LKfMOy1Tb+DDQFa83JoEpSp/kyJ20f
 vtvaLZfleYaQEdO83kKRrCP8Y1G2P1VVBd1C8H/rC2FEvRABY4qZuLZF9MfzdbRNDmow
 cGRJTZrbJmdGnvJe7MN8XhbpvUlkpK10PBqiVAoE8HuxHw13OwKud0XkPDg5fcAHJYnV
 DUKRpnGNMPgJ7sbEiuJYUCWQTbbeQh0lDx39iMitKSXkglOeja3j0JlYaUtRccSzzC+C
 igtqlbPFWaGY1CMcs+PW8sdRnRh3ONs1rCgNZ4xxe4sqUVtqBu0PNS8azfyALy+nPF5r
 Y88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Cew1bsVh+uPPxFCPvivLMvnMySnBo7QVXMyLf4NUogc=;
 b=TYE08cM8suRqgaQZg0V+BAzAD3EWNMVjawja5WNfpPhkf66jKdA1g9ChBKtJaElxBD
 QHvcm8DX3TB/KHw9pjvDkUJgBvQNkHsR4rBsU6we/CxdyKCzgKWWCEIjIslVYZEbIrBE
 cZZv/re1PCmWp9va/+OU8t5ilKqJhIe6x6Dh1EC1bKvwFdkM54FIbDGNZVYNlte8YFkO
 zL8VFnmDO0JWyVMUdxY/7qoTgsZ5T5cdlhHl7w3u4SxxW1kYuvb4ydVcgU6CeJygDOiC
 jobe+/vsufo3K69KBRoDpD8xep6SXSsol0el6inWQHoZJklRlhc3nJkkMwby7CFAGP2L
 IfRw==
X-Gm-Message-State: AOAM530fWJpMOyXYIpm1oAjdtBV5euD3OlurJsIRK3jg03+4kfUHZGKI
 KjbbvXRNEF8DFGD6D3cToMs=
X-Google-Smtp-Source: ABdhPJxmQNB9Dr/Fnytdwhc2WP3yKSVRtKMT+07lahidhyWpm3qWdRsLiGLH2I4Htvoh4G+FR0Ibzw==
X-Received: by 2002:a05:6512:3053:: with SMTP id
 b19mr5387718lfb.276.1639495874691; 
 Tue, 14 Dec 2021 07:31:14 -0800 (PST)
Received: from [192.168.2.145] (94-29-63-156.dynamic.spd-mgts.ru.
 [94.29.63.156])
 by smtp.googlemail.com with ESMTPSA id s4sm11501lfp.198.2021.12.14.07.31.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Dec 2021 07:31:14 -0800 (PST)
Subject: Re: [PATCH v2 0/8] Host1x context isolation support
To: Mikko Perttunen <cyndis@kapsi.fi>, Jon Hunter <jonathanh@nvidia.com>,
 joro@8bytes.org, will@kernel.org, robh+dt@kernel.org, robin.murphy@arm.com,
 Mikko Perttunen <mperttunen@nvidia.com>
References: <20210916143302.2024933-1-mperttunen@nvidia.com>
 <10de82cf-27a5-8890-93a5-0e58c74e5bcc@kapsi.fi>
 <c382fb0e-6b73-5ca0-7f63-d2843351325e@nvidia.com>
 <91dddccd-a6c1-21b3-34d6-6a8082a386e7@nvidia.com>
 <a507b10b-395b-1f6d-87b9-7c7c436cab0e@gmail.com>
 <a62602df-91f6-783d-60f3-d9eba10da543@kapsi.fi>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <be8aec02-8651-0b12-ff13-237c75a5b29d@gmail.com>
Date: Tue, 14 Dec 2021 18:31:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <a62602df-91f6-783d-60f3-d9eba10da543@kapsi.fi>
Content-Language: en-US
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 thierry.reding@gmail.com, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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

MTQuMTIuMjAyMSAxNzo1MywgTWlra28gUGVydHR1bmVuINC/0LjRiNC10YI6Cj4gT24gMTIvMTQv
MjEgMTY6MzUsIERtaXRyeSBPc2lwZW5rbyB3cm90ZToKPj4gMTQuMTIuMjAyMSAxMTowNSwgSm9u
IEh1bnRlciDQv9C40YjQtdGCOgo+Pj4gSGkgYWxsLAo+Pj4KPj4+IFN0aWxsIG5vIHJlc3BvbnNl
IG9uIHRoaXMgOi0oCj4+Cj4+IEkgc2VlIG9ubHkgdHdvIHBhdGNoZXMgb24gVGVncmEgTUwgYW5k
IG90aGVycyBvbiBEUkkgTUwuIE1pZ2h0IGJlIGdvb2QKPj4gdG8gc3RhcnQgd2l0aCByZS1zZW5k
aW5nIHRoaXMgd2hvbGUgc2VyaWVzIGFuZCBDQ2luZyBNTHMgcHJvcGVybHkuCj4+Cj4gCj4gQWxs
IHBhdGNoZXMgc2hvdWxkIGhhdmUgYmVlbiBzZW50IHRvIHRoZSBzYW1lIHNldCBvZiBhZGRyZXNz
ZXMuIEF0IGxlYXN0Cj4gTFdOJ3MgYXJjaGl2ZSBzZWVtcyB0byBhZ3JlZS4uCgpJbmRlZWQsIEkg
c2VlIHRoYXQgVGVncmEgTUwgd2FzIENDZWQgYW5kIEkgc2VlIGFsbCBwYXRjaGVzIG9uIFRlZ3Jh
CnBhdGNod29yaywgYnV0IEkgZG9uJ3Qgc2VlIHRoZW0gYWxsIG9uIGxvcmUgYW5kIGdtYW5lLgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWls
aW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
