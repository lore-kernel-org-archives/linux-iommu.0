Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51B3C2D0A8
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 06:32:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D99E2075F
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 06:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcQzy050"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D99E2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B02122046B;
	Wed, 30 Sep 2020 06:32:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DNltutDYBG1Y; Wed, 30 Sep 2020 06:32:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 4FD8B2041E;
	Wed, 30 Sep 2020 06:32:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 37007C0889;
	Wed, 30 Sep 2020 06:32:28 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9050C0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 06:32:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A166720446
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 06:32:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5oJPUNgjDPiU for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 06:32:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com
 [209.85.167.66])
 by silver.osuosl.org (Postfix) with ESMTPS id BD0092041E
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 06:32:23 +0000 (UTC)
Received: by mail-lf1-f66.google.com with SMTP id x69so764574lff.3
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 23:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=3VXdqYD5mLaS1mNtGut0e8DjZwBTzbu+70S04GgZNgE=;
 b=LcQzy050EZalf2qpmr9trF0VPQjIjWYoZb8sVqO80WQjOpquIS5pk4F54nzBliLaMv
 3olCtvJ+qtiMq9pezX6RxjDsuTt0jn4aKcPqaAIfz3WvylgNEWYdwNepowcRJcXVn6Gs
 Q6w+QQSVi/odYVYafmow53w972C4SVgaiYwGL0zVmg3M7dj1GsuTYaVtzz9aCpmebhU2
 pxf5PDCv+6NznBzQwmvzZFU5VCMDqJmml2TxQOneorLWc853lIclVFbo9dK4EcVydNrc
 VVvPsnVUdlSaSnoaaTvqKGABHmfoHlPGwV+EK0mxWiGmK/uWZt3BVtmfiVout8MD02IN
 6e+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3VXdqYD5mLaS1mNtGut0e8DjZwBTzbu+70S04GgZNgE=;
 b=XnPVTQEaDn7mN2SHEkWDKJrZqgZRt97aWiDs9miwaApork80qThEYERwKKPsHqqU3L
 Q/lGOjNGJKSnrNCmlQdTb3CO28PGI8PDe/XM4gTH82TD4rRvqfr6/wnz+8wgczxG0OU/
 fZr7EL/xYotyR9wWJCrE0qwSNHmfQLr9Vp13Z7hHO6VvLLLGr+h2uhNcidbSFScBRJvo
 F/01jM5GBt3WBdw7159jB8fd00WASN4n4Cgv184OBfgHLBFlR19G2BaF3zduZjKn6IHw
 sikFtjo/mKyaNcfEzH4T7uEzM35rM6FIJGDGxe7byy8zLDJJUIJtuW8Orz0FjGfl3omr
 oEpQ==
X-Gm-Message-State: AOAM530uNE+4VhCqhcPTqf8//oj23hoEgn8tdfu+7t+BpR7mya7PxSmQ
 j4tuKxVq2dT8eew02b8e2xg=
X-Google-Smtp-Source: ABdhPJxtz5X8Ydt5H29th5vtTUu5WnUXnmwg6pfBKoUvhlPcRiWNg7TvK0ExxmdCcyc2hvCHS2q3yQ==
X-Received: by 2002:ac2:5190:: with SMTP id u16mr313979lfi.314.1601447541818; 
 Tue, 29 Sep 2020 23:32:21 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru.
 [109.252.170.211])
 by smtp.googlemail.com with ESMTPSA id d24sm76325lfn.140.2020.09.29.23.32.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 23:32:21 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] memory: tegra: Add helper function
 tegra_get_memory_controller
To: Nicolin Chen <nicoleotsuka@gmail.com>
References: <20200930003013.31289-1-nicoleotsuka@gmail.com>
 <20200930003013.31289-2-nicoleotsuka@gmail.com>
 <93803d8b-9863-e977-fa87-a03e877b095d@gmail.com>
 <20200930054455.GF31821@Asurada-Nvidia>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <2f752179-5ad3-c000-8794-494c79f7b21f@gmail.com>
Date: Wed, 30 Sep 2020 09:32:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930054455.GF31821@Asurada-Nvidia>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 krzk@kernel.org, jonathanh@nvidia.com, thierry.reding@gmail.com,
 linux-tegra@vger.kernel.org
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

MzAuMDkuMjAyMCAwODo0NCwgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gT24gV2VkLCBTZXAg
MzAsIDIwMjAgYXQgMDg6MTI6MTBBTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+PiAz
MC4wOS4yMDIwIDAzOjMwLCBOaWNvbGluIENoZW4g0L/QuNGI0LXRgjoKPj4gLi4uCj4+PiAgaW50
IHRlZ3JhX21jX3dyaXRlX2VtZW1fY29uZmlndXJhdGlvbihzdHJ1Y3QgdGVncmFfbWMgKm1jLCB1
bnNpZ25lZCBsb25nIHJhdGUpOwo+Pj4gIHVuc2lnbmVkIGludCB0ZWdyYV9tY19nZXRfZW1lbV9k
ZXZpY2VfY291bnQoc3RydWN0IHRlZ3JhX21jICptYyk7Cj4+PiArc3RydWN0IHRlZ3JhX21jICp0
ZWdyYV9nZXRfbWVtb3J5X2NvbnRyb2xsZXIodm9pZCk7Cj4+PiAgCj4+PiAgI2VuZGlmIC8qIF9f
U09DX1RFR1JBX01DX0hfXyAqLwo+Pj4KPj4KPj4gVGhpcyB3aWxsIGNvbmZsaWN0IHdpdGggdGhl
IHRlZ3JhMjAtZGV2ZnJlcSBkcml2ZXIsIHlvdSBzaG91bGQgY2hhbmdlIGl0Cj4+IGFzIHdlbGwu
Cj4gCj4gV2lsbCByZW1vdmUgdGhhdCBpbiB2My4KPiAKPiBUaGFua3MKPiAKClBsZWFzZSBhbHNv
IGNvbnNpZGVyIHRvIGFkZCBhIHJlc291cmNlLW1hbmFnZWQgdmFyaWFudCwgc2ltaWxhciB0byB3
aGF0CkkgZGlkIGhlcmU6CgpodHRwczovL2dpdGh1Yi5jb20vZ3JhdGUtZHJpdmVyL2xpbnV4L2Nv
bW1pdC8yMTA1ZTc2NjQwNjM3NzJkNzJmZWZlOTY5NmJkYWIwYjY4OGI5ZGUyCgpJIHdhcyBnb2lu
ZyB0byB1c2UgaXQgaW4gdGhlIG5leHQgaXRlcmF0aW9uIG9mIHRoZSBtZW1vcnkgaW50ZXJjb25u
ZWN0CnNlcmllcy4KCkJ1dCBub3cgaXQgYWxzbyB3aWxsIGJlIGdvb2QgaWYgeW91IGNvdWxkIGFk
ZCB0aGUgZGV2bSB2YXJpYW50IHRvIHlvdXJzClNNTVUgcGF0Y2hzZXQgc2luY2UgeW91J3JlIGFs
cmVhZHkgYWJvdXQgdG8gdG91Y2ggdGhlIHRlZ3JhMjAtZGV2ZnJlcQpkcml2ZXIuIEknbGwgdGhl
biByZWJhc2UgbXkgcGF0Y2hlcyBvbiB0b3Agb2YgeW91cnMgcGF0Y2guCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21t
dUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
