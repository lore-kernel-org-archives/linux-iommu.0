Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0375C433EF
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 19:40:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3338C4ECEA;
	Thu,  9 Dec 2021 19:40:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fCqCpmvZTDhJ; Thu,  9 Dec 2021 19:40:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1BA3A4ECE6;
	Thu,  9 Dec 2021 19:40:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2693C001E;
	Thu,  9 Dec 2021 19:40:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83D64C0012
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 19:40:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 71D024ECE9
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 19:40:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rneZh6JVVDIF for <iommu@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 19:40:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B4FF04ECE6
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 19:40:45 +0000 (UTC)
Received: by mail-lf1-x133.google.com with SMTP id cf39so1936609lfb.8
 for <iommu@lists.linux-foundation.org>; Thu, 09 Dec 2021 11:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7e4wPhBpHhYcL4TNHjTq6GfxBUZhweLfxcnZCfxNmD0=;
 b=kx0CzCpM7B18oC7QqVp3vpnqp9czqNUFHoA2bD/13SOmPSLpXfnGusM07Ge5JLunbJ
 9QkHy3yixBqpBDwSBgS7OU9mfK0byvztX0LPJ7k5RUcD0t9pObVR9K6hakgZqmRLoFMg
 3ZsSxuPOZUyJDMKa+aaKpskTHBH0Hq9xeLVXlzmdgbrwRqz4HraO/uiKg1twyPxvwEag
 lNW9Plx1vS7dvlYw4F+GCUlX2XpMqQghtbQtwF5XhicqFh4bWeJj180Z5oYOfhc+rwAR
 5vAz780e1rZWX9o0PLV5Qz3lnR3SfNfn93g6KevrV4jDAk0buKHm10H8qaKP7g/I8ImJ
 IQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7e4wPhBpHhYcL4TNHjTq6GfxBUZhweLfxcnZCfxNmD0=;
 b=VAMfHM+787AbBdFpEXh37G70ReP3BvtBgonEQMSR+AerwWD+vp/qTSMhmmxqvuppCP
 x5rC1JH0XxMN1ZURzCZ3HmIcxs9Rlo/A0w96vPVkyd5xYHXxg9WnRRHVooC1pKC6NfCc
 ElafQWeT89DHm7K7lavHO/0YGyyWIBfLPhTFa2/tNI7SWNNLLhBUz614ONBx+GWCer7U
 pjiuJFzUZuEopjbq8bkXmvDrwjgld52jzRquZZmfkGbPY3w2SC7r1p6TuDNyIZWGPd/z
 3jwd/GXdqEXsdIkQtBL0NLnJqOx+45GHCvAlhhJ+g8QjlBS2qpozt46TQEGsPZj4Fyxw
 L5LA==
X-Gm-Message-State: AOAM533n352iLkxdZrmA3gT31qY0gvnaMCKBVPxxzq7RBvcPw0zmVjCz
 8KT0ECnN/IEEDFLvkeMVQ3U=
X-Google-Smtp-Source: ABdhPJya6K3A+oUSCP6WXn/UJfIBjZHyRWdgszR22IMDqvOAXepYBTyL4q4uAlCO5kEr8GD3/wMW8A==
X-Received: by 2002:a05:6512:2082:: with SMTP id
 t2mr8285209lfr.186.1639078843695; 
 Thu, 09 Dec 2021 11:40:43 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru.
 [94.29.46.111])
 by smtp.googlemail.com with ESMTPSA id x5sm69577ljm.101.2021.12.09.11.40.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Dec 2021 11:40:43 -0800 (PST)
Subject: Re: [PATCH v8 6/6] iommu/tegra-smmu: Add pagetable mappings to debugfs
To: Nicolin Chen <nicolinc@nvidia.com>
References: <20211209073822.26728-1-nicolinc@nvidia.com>
 <20211209073822.26728-7-nicolinc@nvidia.com>
 <5713902d-823b-63ca-00c9-aa6c64c1af41@gmail.com>
 <20211209193253.GB34762@Asurada-Nvidia>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <97a32c9a-2ec7-6579-7d8d-026d6f820a3e@gmail.com>
Date: Thu, 9 Dec 2021 22:40:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211209193253.GB34762@Asurada-Nvidia>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, thierry.reding@gmail.com, linux-tegra@vger.kernel.org,
 will@kernel.org
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

MDkuMTIuMjAyMSAyMjozMiwgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gT24gVGh1LCBEZWMg
MDksIDIwMjEgYXQgMDU6NDc6MThQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+PiBF
eHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cwo+
Pgo+Pgo+PiAwOS4xMi4yMDIxIDEwOjM4LCBOaWNvbGluIENoZW4g0L/QuNGI0LXRgjoKPj4+IEBA
IC01NDUsNiArNzE5LDE1IEBAIHN0YXRpYyB2b2lkIHRlZ3JhX3NtbXVfZGV0YWNoX2FzKHN0cnVj
dCB0ZWdyYV9zbW11ICpzbW11LAo+Pj4gICAgICAgICAgICAgICBpZiAoZ3JvdXAtPnN3Z3JwICE9
IHN3Z3JwKQo+Pj4gICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOwo+Pj4gICAgICAgICAg
ICAgICBncm91cC0+YXMgPSBOVUxMOwo+Pj4gKwo+Pj4gKyAgICAgICAgICAgICBpZiAoc21tdS0+
ZGVidWdmc19tYXBwaW5ncykgewo+PiBEbyB3ZSByZWFsbHkgbmVlZCB0aGlzIGNoZWNrPwo+Pgo+
PiBMb29rcyBsaWtlIGFsbCBkZWJ1Z2ZzX2NyZWF0ZV9kaXIoKSB1c2FnZXMgaW4gdGhpcyBkcml2
ZXIgYXJlIGluY29ycmVjdCwKPj4gdGhhdCBmdW5jdGlvbiBuZXZlciByZXR1cm5zIE5VTEwuIFBs
ZWFzZSBmaXggdGhpcy4KPiBkZWJ1Z2ZzX2NyZWF0ZV9kaXIgcmV0dXJucyBFUlJfUFRSIG9uIGZh
aWx1cmUuIFNvIGhlcmUgc2hvdWxkIGJlCj4gdG8gY2hlY2sgIUlTX0VSUi4gVGhhbmtzIGZvciBw
b2ludGluZyBpdCBvdXQhCj4gCgpBbGwgZGVidWdmcyBmdW5jdGlvbnMgaGFuZGxlIElTX0VSUigp
LiBHcmVnS0ggcmVtb3ZlcyBhbGwgc3VjaCBjaGVja3MKYWxsIG92ZXIgdGhlIGtlcm5lbC4gU28g
dGhlIGNoZWNrIHNob3VsZG4ndCBiZSBuZWVkZWQgYXQgYWxsLCBwbGVhc2UKcmVtb3ZlIGl0IGlm
IGl0J3MgdW5uZWVkZWQgb3IgcHJvdmUgdGhhdCBpdCdzIG5lZWRlZC4KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
