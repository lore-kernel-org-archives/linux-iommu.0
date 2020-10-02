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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08728C47423
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 14:35:32 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72A2A206A5
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 14:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDLaS+CF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72A2A206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 124F72D268;
	Fri,  2 Oct 2020 14:35:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uLTL0Wre38H8; Fri,  2 Oct 2020 14:35:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1A09F2010C;
	Fri,  2 Oct 2020 14:35:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4CD8C016F;
	Fri,  2 Oct 2020 14:35:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF0C7C0051
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 14:35:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D6B0D8672E
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 14:35:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mwXsMUOf0Q_z for <iommu@lists.linux-foundation.org>;
 Fri,  2 Oct 2020 14:35:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com
 [209.85.167.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 1201E86709
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 14:35:27 +0000 (UTC)
Received: by mail-lf1-f67.google.com with SMTP id b22so2102541lfs.13
 for <iommu@lists.linux-foundation.org>; Fri, 02 Oct 2020 07:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=nMMO21NGQohJ9bqWbYFSMA1hjk7n59RS3N1fM462izU=;
 b=hDLaS+CFrLkGzrGXeTn3pNGf1DvIlMbXEcEk8FJJ0EuMOD4Xj4lxl2Smemd3ETzxO9
 CZyI9wpcWnpNtRMolA0T1qzwvl+at34sqrN/HKJzbRJnTOlT5Rg37JjDIN8ddb0/O1gp
 9XzldlJbHouij2See9rmbKnM8HX7asREsX4nDtBlbdMrW8QZslX0WaHJuqvl1SRIl5xj
 0hHUNhtE36x8AEHQMaX3pZveOmY1G22s92RKf1bbLT1r9RUKKg/fiJjH+2EpK9n2M5fr
 HRfcwxj5p1S7ml37tqD5tc2Sykd3vxA0z/KTAcenf5VYySJMph2ZaGkS5kpA/LgjVzQJ
 qGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nMMO21NGQohJ9bqWbYFSMA1hjk7n59RS3N1fM462izU=;
 b=eTfkEK5O3ZH43MfzDUp7cvOGlIsq96IX2yXWZhcb+k+yzEtaTtJTaa+wZA3/QhF4Xy
 QrYzVackEqkhYFQuv8YT1AtjJdgH2j4p3kI4pq9PVvzNeyAqQ7gNCluotoMAlLlqMC7a
 qqh+ITIkcazzV7QLc6ug49Hl2qPbWbaTflfXcLFqxTd07e8/wkXIX+bNvlVlWDSM9eSH
 aYYga+Z95P/2l3qy7onIqtstXluoJP1urbm/y6ZEBlcKXJ5HRvbRxdYDh+8uttUtQ+td
 tbdn9N+dlqyS9lIv8plysRchTR4F5FjPZosSRUZP9E/3VN8NWPSwe5VefF8ThgEAassL
 lYfg==
X-Gm-Message-State: AOAM532z5DOMiLp9k2S/1bRuKp2Znq/zzyCTjuR1WUgmjGdmG9krXY05
 wPgZJtpUxL64TLxUCg+MByU=
X-Google-Smtp-Source: ABdhPJw1g7K2tJz51ldPxPgHLCyl68AFUOvce119apKPVPHnp6oe13Q3cBIqaNXKI470Du7pJRs7mg==
X-Received: by 2002:a19:4a58:: with SMTP id x85mr956117lfa.168.1601649325320; 
 Fri, 02 Oct 2020 07:35:25 -0700 (PDT)
Received: from [192.168.2.145] (109-252-91-252.nat.spd-mgts.ru.
 [109.252.91.252])
 by smtp.googlemail.com with ESMTPSA id 78sm330330lfn.20.2020.10.02.07.35.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2020 07:35:24 -0700 (PDT)
Subject: Re: [PATCH v4 3/3] iommu/tegra-smmu: Add PCI support
To: Nicolin Chen <nicoleotsuka@gmail.com>, thierry.reding@gmail.com,
 joro@8bytes.org
References: <20201002060807.32138-1-nicoleotsuka@gmail.com>
 <20201002060807.32138-4-nicoleotsuka@gmail.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <eba0d5ff-dfb2-7c17-50c2-5709c506f62e@gmail.com>
Date: Fri, 2 Oct 2020 17:35:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201002060807.32138-4-nicoleotsuka@gmail.com>
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

MDIuMTAuMjAyMCAwOTowOCwgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gQEAgLTg2NSw3ICs4
NjYsMTEgQEAgc3RhdGljIHN0cnVjdCBpb21tdV9ncm91cCAqdGVncmFfc21tdV9kZXZpY2VfZ3Jv
dXAoc3RydWN0IGRldmljZSAqZGV2KQo+ICAJZ3JvdXAtPnNtbXUgPSBzbW11Owo+ICAJZ3JvdXAt
PnNvYyA9IHNvYzsKPiAgCj4gLQlncm91cC0+Z3JvdXAgPSBpb21tdV9ncm91cF9hbGxvYygpOwo+
ICsJaWYgKGRldl9pc19wY2koZGV2KSkKPiArCQlncm91cC0+Z3JvdXAgPSBwY2lfZGV2aWNlX2dy
b3VwKGRldik7Cj4gKwllbHNlCj4gKwkJZ3JvdXAtPmdyb3VwID0gZ2VuZXJpY19kZXZpY2VfZ3Jv
dXAoZGV2KTsKPiArCj4gIAlpZiAoSVNfRVJSKGdyb3VwLT5ncm91cCkpIHsKPiAgCQlkZXZtX2tm
cmVlKHNtbXUtPmRldiwgZ3JvdXApOwo+ICAJCW11dGV4X3VubG9jaygmc21tdS0+bG9jayk7Cj4g
QEAgLTEwNjksMjIgKzEwNzQsMzIgQEAgc3RydWN0IHRlZ3JhX3NtbXUgKnRlZ3JhX3NtbXVfcHJv
YmUoc3RydWN0IGRldmljZSAqZGV2LAo+ICAJaW9tbXVfZGV2aWNlX3NldF9md25vZGUoJnNtbXUt
PmlvbW11LCBkZXYtPmZ3bm9kZSk7Cj4gIAo+ICAJZXJyID0gaW9tbXVfZGV2aWNlX3JlZ2lzdGVy
KCZzbW11LT5pb21tdSk7Cj4gLQlpZiAoZXJyKSB7Cj4gLQkJaW9tbXVfZGV2aWNlX3N5c2ZzX3Jl
bW92ZSgmc21tdS0+aW9tbXUpOwo+IC0JCXJldHVybiBFUlJfUFRSKGVycik7Cj4gLQl9Cj4gKwlp
ZiAoZXJyKQo+ICsJCWdvdG8gZXJyX3N5c2ZzOwo+ICAKPiAgCWVyciA9IGJ1c19zZXRfaW9tbXUo
JnBsYXRmb3JtX2J1c190eXBlLCAmdGVncmFfc21tdV9vcHMpOwo+IC0JaWYgKGVyciA8IDApIHsK
PiAtCQlpb21tdV9kZXZpY2VfdW5yZWdpc3Rlcigmc21tdS0+aW9tbXUpOwo+IC0JCWlvbW11X2Rl
dmljZV9zeXNmc19yZW1vdmUoJnNtbXUtPmlvbW11KTsKPiAtCQlyZXR1cm4gRVJSX1BUUihlcnIp
Owo+IC0JfQo+ICsJaWYgKGVyciA8IDApCj4gKwkJZ290byBlcnJfdW5yZWdpc3RlcjsKPiArCj4g
KyNpZmRlZiBDT05GSUdfUENJCj4gKwllcnIgPSBidXNfc2V0X2lvbW11KCZwY2lfYnVzX3R5cGUs
ICZ0ZWdyYV9zbW11X29wcyk7Cj4gKwlpZiAoZXJyIDwgMCkKPiArCQlnb3RvIGVycl9idXNfc2V0
Owo+ICsjZW5kaWYKPiAgCj4gIAlpZiAoSVNfRU5BQkxFRChDT05GSUdfREVCVUdfRlMpKQo+ICAJ
CXRlZ3JhX3NtbXVfZGVidWdmc19pbml0KHNtbXUpOwo+ICAKPiAgCXJldHVybiBzbW11Owo+ICsK
PiArZXJyX2J1c19zZXQ6IF9fbWF5YmVfdW51c2VkOwoKX19tYXliZV91bnVzZWQ/Cl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlz
dAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
