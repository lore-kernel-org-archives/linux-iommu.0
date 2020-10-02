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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748E9C4363D
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 14:41:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1793320708
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 14:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBHfX3/p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1793320708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A7CF78679B;
	Fri,  2 Oct 2020 14:41:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J2KkjZe_juhd; Fri,  2 Oct 2020 14:41:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2640E86709;
	Fri,  2 Oct 2020 14:41:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C081C016F;
	Fri,  2 Oct 2020 14:41:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3CE7C0051
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 14:41:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DA28186B2C
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 14:41:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 15I8AAru+RJT for <iommu@lists.linux-foundation.org>;
 Fri,  2 Oct 2020 14:41:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com
 [209.85.167.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id EA21D8691E
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 14:41:53 +0000 (UTC)
Received: by mail-lf1-f68.google.com with SMTP id 197so2133718lfo.11
 for <iommu@lists.linux-foundation.org>; Fri, 02 Oct 2020 07:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ccwbBBraz+Mr+UjLyai2/AEGVDZQMyHCcB39LG9nrxQ=;
 b=SBHfX3/pT2BKGbai06QxirsVyqXhUdtuE8Kn/r/BfamZWOddnu3YI9/tPfKmAj1kAN
 ae85nkFGT4xWHWWJTVVjV6SmO+4L2rG07BnF8YLMsFqpuAYa+RpfCJ5EWZoFc1WSopuX
 jwdHE6mITo9/7bie5NHN5BIrdpxorLuUh1nnowqFFp/pEjm9k6DMb/RLFbVeTw6+4eNp
 gAD8NJSkDo9pCBi3JRMKgLFJD+GXMu+NVYnZFFWFUEJUAIuEoq2vVtgaOturpcAtZi8V
 iqP0fsiWkQ8z9yIIw8exFU48VkcbzIqteg1MEKw/ufT+Zjb1xIJabo05FVxNZ2FiDZCv
 BteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ccwbBBraz+Mr+UjLyai2/AEGVDZQMyHCcB39LG9nrxQ=;
 b=uaHwqwKSOxpujgSabdOPI540O8deypjCvbfsPDt9KwIaqBPkO/6WxkTR6u5YkE525w
 yfkus9NElVknpQdnbxGupep/AjGG2S9mRp1ZsLfdmOMAx871ZMFDD3sbANOem4cPhOpS
 F0TmPONSs6qE28Ebhq4DNlt2x0aTaT4HwmI/rjHXNyk5phZU0e5ICxilWrijFeU93iM4
 fIepKfKVH4LyVTMT+U3SjVzVdiC+ASj/w7sdlp4bgiJYoETiZRri1TPCBuAvueL394+H
 9/PjhQcnEs4eVy4aYmk89D6b8WZPxRpX9tRpXCvh3Eshts8jiihUvvSvVSV8C7YGA5aG
 YaNw==
X-Gm-Message-State: AOAM531M7ZZN1mwV51tMXa/THm2jLITLK5ATP/hrnqGjaNLXQSAOEE2r
 OaobRKgmLl7kI61F6efIYCc=
X-Google-Smtp-Source: ABdhPJyFaEhIGP8CV6uouv7gFIFfNYLAxZV3AIp2QrDCu0NFeJOxuzN/bUOZG+bynH73oCbGOT6Wyw==
X-Received: by 2002:a19:8a0a:: with SMTP id m10mr942761lfd.244.1601649712013; 
 Fri, 02 Oct 2020 07:41:52 -0700 (PDT)
Received: from [192.168.2.145] (109-252-91-252.nat.spd-mgts.ru.
 [109.252.91.252])
 by smtp.googlemail.com with ESMTPSA id q17sm324009lfn.145.2020.10.02.07.41.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2020 07:41:51 -0700 (PDT)
Subject: Re: [PATCH v4 1/3] iommu/tegra-smmu: Use fwspec in
 tegra_smmu_(de)attach_dev
To: Nicolin Chen <nicoleotsuka@gmail.com>, thierry.reding@gmail.com,
 joro@8bytes.org
References: <20201002060807.32138-1-nicoleotsuka@gmail.com>
 <20201002060807.32138-2-nicoleotsuka@gmail.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <de0b717f-af5c-8813-eb3e-07d19eff5271@gmail.com>
Date: Fri, 2 Oct 2020 17:41:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201002060807.32138-2-nicoleotsuka@gmail.com>
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

MDIuMTAuMjAyMCAwOTowOCwgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gIHN0YXRpYyBpbnQg
dGVncmFfc21tdV9hdHRhY2hfZGV2KHN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbiwKPiAgCQkJ
CSBzdHJ1Y3QgZGV2aWNlICpkZXYpCj4gIHsKPiArCXN0cnVjdCBpb21tdV9md3NwZWMgKmZ3c3Bl
YyA9IGRldl9pb21tdV9md3NwZWNfZ2V0KGRldik7Cj4gIAlzdHJ1Y3QgdGVncmFfc21tdSAqc21t
dSA9IGRldl9pb21tdV9wcml2X2dldChkZXYpOwo+ICAJc3RydWN0IHRlZ3JhX3NtbXVfYXMgKmFz
ID0gdG9fc21tdV9hcyhkb21haW4pOwo+IC0Jc3RydWN0IGRldmljZV9ub2RlICpucCA9IGRldi0+
b2Zfbm9kZTsKPiAtCXN0cnVjdCBvZl9waGFuZGxlX2FyZ3MgYXJnczsKPiAgCXVuc2lnbmVkIGlu
dCBpbmRleCA9IDA7Cj4gIAlpbnQgZXJyID0gMDsKPiAgCj4gLQl3aGlsZSAoIW9mX3BhcnNlX3Bo
YW5kbGVfd2l0aF9hcmdzKG5wLCAiaW9tbXVzIiwgIiNpb21tdS1jZWxscyIsIGluZGV4LAo+IC0J
CQkJCSAgICZhcmdzKSkgewo+IC0JCXVuc2lnbmVkIGludCBzd2dyb3VwID0gYXJncy5hcmdzWzBd
Owo+IC0KPiAtCQlpZiAoYXJncy5ucCAhPSBzbW11LT5kZXYtPm9mX25vZGUpIHsKPiAtCQkJb2Zf
bm9kZV9wdXQoYXJncy5ucCk7Cj4gLQkJCWNvbnRpbnVlOwo+IC0JCX0KPiAtCj4gLQkJb2Zfbm9k
ZV9wdXQoYXJncy5ucCk7Cj4gKwlpZiAoIWZ3c3BlYykKPiArCQlyZXR1cm4gLUVOT0VOVDsKCkNv
dWxkIHRoZSAhZndzcGVjIGV2ZXIgYmUgdHJ1ZSBoZXJlIGFzIHdlbGw/Cl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21t
dUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
