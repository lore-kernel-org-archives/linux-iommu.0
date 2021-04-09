Return-Path: <SRS0=LjD4=JG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8790C433ED
	for <iommu@archiver.kernel.org>; Fri,  9 Apr 2021 12:55:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 610BB610FB
	for <iommu@archiver.kernel.org>; Fri,  9 Apr 2021 12:55:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 610BB610FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2A0224048B;
	Fri,  9 Apr 2021 12:55:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 23idJrKk06kn; Fri,  9 Apr 2021 12:55:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3C42440454;
	Fri,  9 Apr 2021 12:55:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0CA67C000B;
	Fri,  9 Apr 2021 12:55:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D28A0C000A
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 12:55:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C0F4883DA9
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 12:55:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5K2tiJfussbf for <iommu@lists.linux-foundation.org>;
 Fri,  9 Apr 2021 12:55:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0A8F283DA0
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 12:55:43 +0000 (UTC)
Received: by mail-lj1-x22b.google.com with SMTP id y1so6320554ljm.10
 for <iommu@lists.linux-foundation.org>; Fri, 09 Apr 2021 05:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=z3wFYyzO04/nplltFnv9EO/HsXFohiYyEY626pT7Qy4=;
 b=N5IB0mR1anzwmgyEkin8MFYd382dilaOTkdDf6VE/2rpDe6d0ZysoE9kB8jS4+q0xd
 LF2D8V+5o6GHWlEvEP/CdfPGjzWqz7JAU/GV2dtNxJeNoMhWLurwp6wLT8HWLn7Aawyp
 B03xTraZmRE6YUiaIBjSetc1e/G48JEE07YH/V3iT6U9Sd7oYB0MfHt8bbM9soMdZrSf
 0pvkVvXu528gM2n0nb6jzgKMztZKLPrZN822mHmMNep4/dVCD6ZcEW2X/ibZir8NuBwW
 vXCByRcEy7pni3IOeVErQSny6Co1QrrMJ7bVIgerGokMhMkaN6FZiJ9WPbB5PZRuk6ie
 dmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=z3wFYyzO04/nplltFnv9EO/HsXFohiYyEY626pT7Qy4=;
 b=Be1/0fXhQn1j7oWZnMbgQ4bGNhKvg52yECcrCFgFO/AONNHvYfYkQwJb96PksSUWaX
 jQJhgmHrGX8NKdA7GH3EWgM7DsUMq6KbRwkUNmWcuuyV3C67RP0X1lL2Uo2CGoERmW7c
 tkmq69g9eg0C6pyxqCx6BypsmmlMgiaNAzVqEr7ZkoW1moRSLsoVYX5XbJMkYrIa3K2u
 UviUwB6/kYihOQxXjqhFhTjzuzEuAWgUM1YSCWy/98RfEyB/B8NzTDmsr3MIQeAz8MdB
 Ak6dIH3Mot2PvzTRwUOpHMDHRCzuTK8ioEhqi70Zg0E7DmNr/RGVoNMkSIbbd5ht81WK
 zybw==
X-Gm-Message-State: AOAM533HDLaHhmvCXA8pj6H7ZeSIjY6Ri9zWdFVmzlDG6Kr+oj1M0TPq
 irRrH0IeWIW7wc1vfLMAMRY=
X-Google-Smtp-Source: ABdhPJz185o6U1Q1rZo8rGSGiz0mC//A/ohSLg+d4znoLqHTwVSMCs3aWjc1dPVKJ2xmOIGZcaO7gg==
X-Received: by 2002:a2e:5417:: with SMTP id i23mr6189910ljb.112.1617972941990; 
 Fri, 09 Apr 2021 05:55:41 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-85.dynamic.spd-mgts.ru.
 [109.252.193.85])
 by smtp.googlemail.com with ESMTPSA id 13sm258278lfz.40.2021.04.09.05.55.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Apr 2021 05:55:41 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] iommu/tegra-smmu: Defer attachment of display
 clients
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
References: <20210328233256.20494-1-digetx@gmail.com>
 <YG75urcXAb90Jj12@orome.fritz.box>
 <c4b42a3d-d260-9a69-4ee7-8ad586741f8c@gmail.com>
Message-ID: <7c1ebbf2-5d27-fa2a-3cae-bedab4c8e30a@gmail.com>
Date: Fri, 9 Apr 2021 15:55:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <c4b42a3d-d260-9a69-4ee7-8ad586741f8c@gmail.com>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
 Will Deacon <will@kernel.org>
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

MDguMDQuMjAyMSAxNzowNywgRG1pdHJ5IE9zaXBlbmtvINC/0LjRiNC10YI6Cj4+IFdoYXRldmVy
IGhhcHBlbmVkIHRvIHRoZSBpZGVhIG9mIGNyZWF0aW5nIGlkZW50aXR5IG1hcHBpbmdzIGJhc2Vk
IG9uIHRoZQo+PiBvYnNjdXJlIHRlZ3JhX2ZiX21lbSAob3Igd2hhdGV2ZXIgaXQgd2FzIGNhbGxl
ZCkgY29tbWFuZC1saW5lIG9wdGlvbj8gSXMKPj4gdGhhdCBjb21tYW5kLWxpbmUgbm90IHVuaXZl
cnNhbGx5IHBhc3NlZCB0byB0aGUga2VybmVsIGZyb20gYm9vdGxvYWRlcnMKPj4gdGhhdCBpbml0
aWFsaXplIGRpc3BsYXk/Cj4gVGhpcyBpcyBzdGlsbCBhIGdvb2QgaWRlYSEgVGhlIGNvbW1hbmQt
bGluZSBpc24ndCB1bml2ZXJzYWxseSBwYXNzZWQKPiBqdXN0IGJlY2F1c2UgaXQncyB1cCB0byBh
IHVzZXIgdG8gb3ZlcnJpZGUgdGhlIGNtZGxpbmUgYW5kIHRoZW4gd2UgZ2V0IGEKPiBoYW5nIChh
IHZlcnkgc2xvdyBib290IGluIHJlYWxpdHkpIG9uIFQzMCBzaW5jZSBkaXNwbGF5IGNsaWVudCB0
YWtlcyBvdXQKPiB0aGUgd2hvbGUgbWVtb3J5IGJ1cyB3aXRoIHRoZSBjb25zdGFudCBTTU1VIGZh
dWx0cy4gRm9yIGV4YW1wbGUgSSBkb24ndAo+IGhhdmUgdGhhdCBjbWRsaW5lIG9wdGlvbiBpbiBt
eSBjdXJyZW50IHNldHVwcy4KPiAKClRoaW5raW5nIGEgYml0IG1vcmUgYWJvdXQgdGhlIGlkZW50
aXR5Li4gaGF2ZSB5b3UgY29uc3VsdGVkIHdpdGggdGhlCm1lbW9yeSBoL3cgcGVvcGxlIGFib3V0
IHdoZXRoZXIgaXQncyBhbHdheXMgc2FmZSB0byBlbmFibGUgQVNJRCBpbiBhCm1pZGRsZSBvZiBE
TUEgcmVxdWVzdD8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
