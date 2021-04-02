Return-Path: <SRS0=DOhO=I7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEE6C43460
	for <iommu@archiver.kernel.org>; Fri,  2 Apr 2021 01:34:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A4AC6108B
	for <iommu@archiver.kernel.org>; Fri,  2 Apr 2021 01:34:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A4AC6108B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 33AEE40E95;
	Fri,  2 Apr 2021 01:34:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9k2Iuij_uS1j; Fri,  2 Apr 2021 01:34:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id BBDF540E92;
	Fri,  2 Apr 2021 01:34:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 86A88C000B;
	Fri,  2 Apr 2021 01:34:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 255E0C000A
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 01:34:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F04FD40613
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 01:34:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Km5zs5_HjqWm for <iommu@lists.linux-foundation.org>;
 Fri,  2 Apr 2021 01:34:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E8D9340145
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 01:34:14 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id bt4so2028343pjb.5
 for <iommu@lists.linux-foundation.org>; Thu, 01 Apr 2021 18:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=mMutIO+5Vq0+K4IsbVRAXhhUKaRfSoCin5JU2V1HQ9M=;
 b=AWm+56YMqZwsTjJBzqDLnhJYZvE6k2YrwwX5jiom8QWf83rVuMVaLjqEfRuEx5gTI0
 ha7tiFkiIwl2nqSF1NQPL/tOzUz2udc4VYg/PcPWay01oTW/hZHUiD2ZUfdAdrLGAbSC
 9tALuwiG1EFZt4dVzrYaoGiPTVzvJ7btQ4EyjPCrxXnNo0Fzsgw/o7z/tJw1zpf/ptMO
 +iaZSsLHm2FZx18STaffvK0eG/O3/7XEDpZlzu1UAjFLshWlGU9z4ss9JHaVJkdtgWBb
 MrebhzXvcjUrVlJhZDi2wxL6TKuzUjC60AbVxHZvkClgJdWzSnP7igmjXImQHBWzJuiB
 7CCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=mMutIO+5Vq0+K4IsbVRAXhhUKaRfSoCin5JU2V1HQ9M=;
 b=c49g/1yGT68hQViz718OKT/7fcxcuYWG+8JboZi6oe0wUU+3RrIdn8x6DN8MefcJr3
 sNcEVuBsx3V7cEy5lSy/CpoY7vRqZG+xziP/EQ7aroattq/+uRXdtUHjdnN1FncvVmfe
 f8IkZmCAHvTmTS4cwqfeLQI8CBmYsepliziz4C72Dm1Ja8hWcno7OVmd4A6OCCCr5ot+
 H6iNAL/cOlKByvXlMn1yOGm81dy94KurSvaAs7DJqjANckz8EYu/QObBZb4s9AI8Vq9Z
 ppg/j0t05SkIOhSmvNU7I52IBKCnSKfdCdj7JWK4wUqPDG/6+UlX0Zw+4xAhuKOpApub
 z/3Q==
X-Gm-Message-State: AOAM5309RTy4EYTRz2q/r2DOZj9c9dYff7nQM/7nevwPLn5+tjsovDPD
 Zb/9p6PwtI/NgwboeWcVndzn2w==
X-Google-Smtp-Source: ABdhPJzdC0JhNLL0BglP12LotW9VT9boXJNnlktYWSmNFLHMQEz5J1OK80HqA9Dv57lVCK19/6Y4ig==
X-Received: by 2002:a17:90b:4910:: with SMTP id
 kr16mr11344355pjb.26.1617327254287; 
 Thu, 01 Apr 2021 18:34:14 -0700 (PDT)
Received: from ?IPv6:240e:362:403:1700:58c5:c814:85bd:7d2e?
 ([240e:362:403:1700:58c5:c814:85bd:7d2e])
 by smtp.gmail.com with ESMTPSA id ha8sm6351510pjb.6.2021.04.01.18.34.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Apr 2021 18:34:13 -0700 (PDT)
Subject: Re: [PATCH v14 10/10] iommu/arm-smmu-v3: Add stall support for
 platform devices
To: Will Deacon <will@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20210401154718.307519-1-jean-philippe@linaro.org>
 <20210401154718.307519-11-jean-philippe@linaro.org>
 <20210401171101.GB9447@willie-the-truck>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <0292a8fb-9408-9c2b-0875-0b71e5f6e170@linaro.org>
Date: Fri, 2 Apr 2021 09:34:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210401171101.GB9447@willie-the-truck>
Content-Language: en-US
Cc: devicetree@vger.kernel.org, kevin.tian@intel.com,
 linux-acpi@vger.kernel.org, sudeep.holla@arm.com, rjw@rjwysocki.net,
 vivek.gautam@arm.com, iommu@lists.linux-foundation.org, robh+dt@kernel.org,
 linux-accelerators@lists.ozlabs.org, guohanjun@huawei.com,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, lenb@kernel.org
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

SGksIFdpbGwKCk9uIDIwMjEvNC8yIOS4iuWNiDE6MTEsIFdpbGwgRGVhY29uIHdyb3RlOgo+IE9u
IFRodSwgQXByIDAxLCAyMDIxIGF0IDA1OjQ3OjE5UE0gKzAyMDAsIEplYW4tUGhpbGlwcGUgQnJ1
Y2tlciB3cm90ZToKPj4gVGhlIFNNTVUgcHJvdmlkZXMgYSBTdGFsbCBtb2RlbCBmb3IgaGFuZGxp
bmcgcGFnZSBmYXVsdHMgaW4gcGxhdGZvcm0KPj4gZGV2aWNlcy4gSXQgaXMgc2ltaWxhciB0byBQ
Q0llIFBSSSwgYnV0IGRvZXNuJ3QgcmVxdWlyZSBkZXZpY2VzIHRvIGhhdmUKPj4gdGhlaXIgb3du
IHRyYW5zbGF0aW9uIGNhY2hlLiBJbnN0ZWFkLCBmYXVsdGluZyB0cmFuc2FjdGlvbnMgYXJlIHBh
cmtlZAo+PiBhbmQgdGhlIE9TIGlzIGdpdmVuIGEgY2hhbmNlIHRvIGZpeCB0aGUgcGFnZSB0YWJs
ZXMgYW5kIHJldHJ5IHRoZQo+PiB0cmFuc2FjdGlvbi4KPj4KPj4gRW5hYmxlIHN0YWxsIGZvciBk
ZXZpY2VzIHRoYXQgc3VwcG9ydCBpdCAob3B0LWluIGJ5IGZpcm13YXJlKS4gV2hlbiBhbgo+PiBl
dmVudCBjb3JyZXNwb25kcyB0byBhIHRyYW5zbGF0aW9uIGVycm9yLCBjYWxsIHRoZSBJT01NVSBm
YXVsdCBoYW5kbGVyLgo+PiBJZiB0aGUgZmF1bHQgaXMgcmVjb3ZlcmFibGUsIGl0IHdpbGwgY2Fs
bCB1cyBiYWNrIHRvIHRlcm1pbmF0ZSBvcgo+PiBjb250aW51ZSB0aGUgc3RhbGwuCj4gV2hpY2gg
aGFyZHdhcmUgaXMgdGhpcyB1c2VmdWwgZm9yPyBTdGFsbGluZyBhZGRzIGEgZmFpciBhbW91bnQg
b2YgY29tcGxleGl0eQo+IHRvIHRoZSBkcml2ZXIsIHNvIEkgZG9uJ3QgdGhpbmsgd2Ugc2hvdWxk
IHN1cHBvcnQgaXQgdW5sZXNzIHdlJ3JlIGxpa2VseSB0bwo+IHNlZSBwbGF0Zm9ybXMgdGhhdCBi
b3RoIGltcGxlbWVudCBpdCBhbmQgZG8gc29tZXRoaW5nIHVzZWZ1bCB3aXRoIGl0LgpJIGhhdmUg
dGVzdGVkIHRoZSBzdGFsbCBtb2RlIG9uIEhpc2lsaWNvbiBLdW5wZW5nOTIwIGJvYXJkLCBhcyB3
ZWxsIGFzIAp1c2luZyBkcml2ZXJzL21pc2MvdWFjY2UvdWFjY2UuYy4KClRoYW5rcwpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxp
c3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
