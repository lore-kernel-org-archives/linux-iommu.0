Return-Path: <SRS0=0/W0=IO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6BAC433DB
	for <iommu@archiver.kernel.org>; Tue, 16 Mar 2021 23:43:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D70C964EFC
	for <iommu@archiver.kernel.org>; Tue, 16 Mar 2021 23:43:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D70C964EFC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A548C600C4;
	Tue, 16 Mar 2021 23:43:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UgGG7AT8ncUd; Tue, 16 Mar 2021 23:43:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9E73960073;
	Tue, 16 Mar 2021 23:43:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 858DAC000B;
	Tue, 16 Mar 2021 23:43:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ABB4BC000A
 for <iommu@lists.linux-foundation.org>; Tue, 16 Mar 2021 23:43:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8C844600C4
 for <iommu@lists.linux-foundation.org>; Tue, 16 Mar 2021 23:43:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wIt-OyGcZnVS for <iommu@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 23:43:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B6A4A60073
 for <iommu@lists.linux-foundation.org>; Tue, 16 Mar 2021 23:43:03 +0000 (UTC)
Received: by mail-lj1-x231.google.com with SMTP id 15so1022411ljj.0
 for <iommu@lists.linux-foundation.org>; Tue, 16 Mar 2021 16:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=jYFeGyHV2zNDVLbB4/9V9Cq/DhTaZRm/v1+BiD8VFOw=;
 b=pNUpWJquTOQ7GETDBARhVTlBvYZv2Ugf0ssuCBNJrHVNUldN7HWfC9c3HLEKrZqUp7
 3WqcHiK53HI/HzDw+ttHJIqIsBGt/9JoRFsni32AWrM1diyNRlPOs8DDgk9EhFi2aOB7
 2IT6ivIlQ6RGScxniU6NBKnLIKHAyJkFfT3ltQ0OFA3SiOvd7s46m52XmeHEZHxVOeTc
 uev4xIbU7Ajc9lLWY2li5KX9bB4q49TxEU1KbPcIYeI8DskKwoN+ti1IZGGndq+lsAVZ
 LUU0NQ89catzxMdN+QYiyKt30a2USwIHp2RpeEA/Njr5EdSDXTmIPgnfPQlcsLkUHHMX
 ZxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jYFeGyHV2zNDVLbB4/9V9Cq/DhTaZRm/v1+BiD8VFOw=;
 b=t75NW95Q/XeY7xkOZVjXCBSYXtdFuO7327gxYq6AtSeecwvUa4wIDv7hM+gCOfyDil
 qtab5VO9a4gmNKf7R+JkLYhpLntinPAWNwjIHQw90BujGktq/zBHHvFxgeAcZ7GpaM3X
 kRiX8Co+bStoSs/p5FAZYE2CjjXi5S1xPeP8cSIWB/x7lYvXDP4ayFNcDVVXB+dmh0et
 cMfDgwLDiqgwvSwK1BSUXAiSQf2Il4/ihpivcs25BtSZLZ50/ztQVditOMYwRSucpHl5
 9raeMNxnpfaj5JZ87jcziSkP7CO3T8xQNTO8O81KZZhGzAe1WfOwTrthwzcAg6L6XGvM
 SuvQ==
X-Gm-Message-State: AOAM532RxiE+CBppGiewJyUZmH//if50Hp0X/U/CXH5sKqk6tNZQ2y1V
 AxL6OjE/DRTre86zFRchOPo=
X-Google-Smtp-Source: ABdhPJyTPkrSBR9a2SBJrGXgEoF451Mw3ymhO/O7kZzEk4Swq8DINxPlGHhlhFvHwvHa1KMSWekwCw==
X-Received: by 2002:a2e:b6c6:: with SMTP id m6mr640889ljo.411.1615938181757;
 Tue, 16 Mar 2021 16:43:01 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-52.dynamic.spd-mgts.ru.
 [109.252.193.52])
 by smtp.googlemail.com with ESMTPSA id k1sm3207658lfe.208.2021.03.16.16.43.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Mar 2021 16:43:01 -0700 (PDT)
Subject: Re: [PATCH v5] iommu/tegra-smmu: Add pagetable mappings to debugfs
To: Nicolin Chen <nicoleotsuka@gmail.com>, joro@8bytes.org,
 thierry.reding@gmail.com, will@kernel.org
References: <20210315203631.24990-1-nicoleotsuka@gmail.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <acad1a15-b4ad-e74e-647e-d50d15d8d3d1@gmail.com>
Date: Wed, 17 Mar 2021 02:43:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210315203631.24990-1-nicoleotsuka@gmail.com>
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

MTUuMDMuMjAyMSAyMzozNiwgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gK3N0YXRpYyBpbnQg
dGVncmFfc21tdV9tYXBwaW5nc19zaG93KHN0cnVjdCBzZXFfZmlsZSAqcywgdm9pZCAqZGF0YSkK
PiArewo+ICsJc3RydWN0IHRlZ3JhX3NtbXVfZ3JvdXBfZGVidWcgKmdyb3VwX2RlYnVnID0gcy0+
cHJpdmF0ZTsKPiArCWNvbnN0IHN0cnVjdCB0ZWdyYV9zbW11X3N3Z3JvdXAgKmdyb3VwOwo+ICsJ
c3RydWN0IHRlZ3JhX3NtbXVfYXMgKmFzOwo+ICsJc3RydWN0IHRlZ3JhX3NtbXUgKnNtbXU7Cj4g
Kwl1bnNpZ25lZCBpbnQgcGRfaW5kZXg7Cj4gKwl1bnNpZ25lZCBpbnQgcHRfaW5kZXg7Cj4gKwl1
bnNpZ25lZCBsb25nIGZsYWdzOwo+ICsJdTY0IHB0ZV9jb3VudCA9IDA7Cj4gKwl1MzIgcGRlX2Nv
dW50ID0gMDsKPiArCXUzMiB2YWwsIHB0Yl9yZWc7Cj4gKwl1MzIgKnBkOwo+ICsKPiArCWlmICgh
Z3JvdXBfZGVidWcgfHwgIWdyb3VwX2RlYnVnLT5wcml2IHx8ICFncm91cF9kZWJ1Zy0+Z3JvdXAp
Cj4gKwkJcmV0dXJuIDA7CgpJJ20gYWxzbyBub3cgY3VyaW91cyBob3cgZGlmZmljdWx0IHdvdWxk
IGJlIHRvIHJlYWQgb3V0IHRoZSBhY3R1YWwgaC93CnN0YXRlLCBpLmUuIGNoZWNrIHdoZXRoZXIg
QVNJRCBpcyBlbmFibGVkIGFuZCB0aGVuIGR5bmFtaWNhbGx5IG1hcCB0aGUKcG9pbnRlZCBwYWdl
cyBpbnN0ZWFkIG9mIHVzaW5nIHBhZ2VzIGFsbG9jYXRlZCBieSBkcml2ZXIuIFRoaXMgd2lsbCBz
aG93CnVzIHRoZSByZWFsIGgvdyBzdGF0ZS4gRm9yIGV4YW1wbGUgdGhpcyBtYXkgc2hvdyBtYXBw
aW5ncyBsZWZ0IGFmdGVyCmJvb3Rsb2FkZXIgb3IgYWZ0ZXIgcmVib290L2tleGVjLCB3aGljaCBj
b3VsZCBiZSBoYW5keSB0byBzZWUuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by9pb21tdQ==
