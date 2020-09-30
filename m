Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3CCC4727E
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 15:22:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95FB92071E
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 15:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6vRBFSX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95FB92071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 174FF871ED;
	Wed, 30 Sep 2020 15:22:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JB8q9wIWxUYm; Wed, 30 Sep 2020 15:22:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 76E5686E48;
	Wed, 30 Sep 2020 15:22:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52574C0890;
	Wed, 30 Sep 2020 15:22:43 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57C1BC016F
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 15:22:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 45F6985D5F
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 15:22:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vQWUzx0D+7Px for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 15:22:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com
 [209.85.167.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8CF4E85B8A
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 15:22:40 +0000 (UTC)
Received: by mail-lf1-f68.google.com with SMTP id 197so2024558lfo.11
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 08:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xiKtvmX9hgv/pe1MEDHvp0vtG2v3tm61VnhmZJEUzgA=;
 b=O6vRBFSX3jndnk1it+JCHmJDlt2UGbZJFM87KbD//vjyUO1Gqd0QsDWolxBbJHJVWv
 dZxGx1d9loJYYkjmYRnGpN0pgd16yXmWJMitqoOwFHEzyrJhYla9YZamUHwWEsq0kMCo
 siv4g9jHw5HwSkYLM9WkQtI3hSFax0w4eQikWB1vEsEy1ctY6uUzfKa62jB7bSQw29oK
 Za3gTE1EgEUQGY5vFqL9fL1fZT87rrVdqXIn4xiWzylKISR+o7Kh3qND/bISNxZsDUd0
 bpBzEqub5VTzDLy9xKdkSHU/6iIMjSQyMtrg0QCcC9u90kgcwAYgcNhZeE7jygyXK/kn
 5v1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xiKtvmX9hgv/pe1MEDHvp0vtG2v3tm61VnhmZJEUzgA=;
 b=GjIryM4GE0c3KT9ur/4Vn0zaMnzyrCeWrHMXpl5ibNSM6d9w4Ogl87VgCg4dqBq3dQ
 p7TBTphUdb3BTEymr7DDxnQ+wjGZ8+SfVRjYRd+KiWgi7ou1qEwqdYI/zNg7ojq/wGml
 liPC64eTVeRIsoE0wkLN5uwWIVEDK/mIbd8c+oiAEgBTtdh8YbKrQIaR03+UlYq8383G
 weifqiQxfMe4hZUpdeIaVSV9Mu4isCwgiUZ9Lm7KZJKsZE+Gw+ZXZZcGUDOFWOWcMTH1
 XZLD47WHWXhy17dxQp6e9mPkPQVumsd31LU+vCgUKLm9AopyFBB5RCqSZUj9miPy3xRT
 A4ug==
X-Gm-Message-State: AOAM531QQVHCoaxXT1b7D6xidr8fXxydn0lWjMDA9GInF/JvuIrIDCzg
 w9sjB1QPfyEfoCt6Y8gaJFs=
X-Google-Smtp-Source: ABdhPJxnHzVE51GwnQB935ZA5ZgN3Z3BCeImMKqCMFWf3vkc7rfyplw5W15mZV5ZQcbbs8opUY+h9w==
X-Received: by 2002:ac2:4352:: with SMTP id o18mr972224lfl.496.1601479358712; 
 Wed, 30 Sep 2020 08:22:38 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru.
 [109.252.170.211])
 by smtp.googlemail.com with ESMTPSA id 80sm226170lff.61.2020.09.30.08.22.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2020 08:22:38 -0700 (PDT)
Subject: Re: [PATCH v3 1/3] memory: tegra: Add
 devm_tegra_get_memory_controller()
To: Krzysztof Kozlowski <krzk@kernel.org>
References: <20200930084258.25493-1-nicoleotsuka@gmail.com>
 <20200930084258.25493-2-nicoleotsuka@gmail.com>
 <f9712d4c-8497-ca84-0d8a-d33eb6abc513@gmail.com>
 <CAJKOXPfbCRDY7TUZ4HXphrd6boWYEKb_DMOxth3ucPTB2UCUtw@mail.gmail.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <257958e0-8359-4296-9653-ba821b39d813@gmail.com>
Date: Wed, 30 Sep 2020 18:22:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPfbCRDY7TUZ4HXphrd6boWYEKb_DMOxth3ucPTB2UCUtw@mail.gmail.com>
Content-Language: en-US
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, jonathanh@nvidia.com,
 thierry.reding@gmail.com, linux-tegra@vger.kernel.org
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

MzAuMDkuMjAyMCAxNzo0NSwgS3J6eXN6dG9mIEtvemxvd3NraSDQv9C40YjQtdGCOgo+IE9uIFdl
ZCwgMzAgU2VwIDIwMjAgYXQgMTY6NDEsIERtaXRyeSBPc2lwZW5rbyA8ZGlnZXR4QGdtYWlsLmNv
bT4gd3JvdGU6Cj4+Cj4+IC4uLgo+Pj4gK3N0cnVjdCB0ZWdyYV9tYyAqZGV2bV90ZWdyYV9nZXRf
bWVtb3J5X2NvbnRyb2xsZXIoc3RydWN0IGRldmljZSAqZGV2KQo+Pj4gK3sKPj4+ICsgICAgIHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXY7Cj4+PiArICAgICBzdHJ1Y3QgZGV2aWNlX25vZGUg
Km5wOwo+Pj4gKyAgICAgc3RydWN0IHRlZ3JhX21jICptYzsKPj4+ICsgICAgIGludCBlcnI7Cj4+
PiArCj4+PiArICAgICBucCA9IG9mX2ZpbmRfbWF0Y2hpbmdfbm9kZV9hbmRfbWF0Y2goTlVMTCwg
dGVncmFfbWNfb2ZfbWF0Y2gsIE5VTEwpOwo+Pj4gKyAgICAgaWYgKCFucCkKPj4+ICsgICAgICAg
ICAgICAgcmV0dXJuIEVSUl9QVFIoLUVOT0VOVCk7Cj4+PiArCj4+PiArICAgICBwZGV2ID0gb2Zf
ZmluZF9kZXZpY2VfYnlfbm9kZShucCk7Cj4+PiArICAgICBvZl9ub2RlX3B1dChucCk7Cj4+PiAr
ICAgICBpZiAoIXBkZXYpCj4+PiArICAgICAgICAgICAgIHJldHVybiBFUlJfUFRSKC1FTk9ERVYp
Owo+Pj4gKwo+Pj4gKyAgICAgbWMgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KTsKPj4+ICsg
ICAgIGlmICghbWMpIHsKPj4+ICsgICAgICAgICAgICAgcHV0X2RldmljZShtYy0+ZGV2KTsKPj4K
Pj4gVGhpcyBzaG91bGQgYmUgcHV0X2RldmljZSgmcGRldi0+ZGV2KS4gUGxlYXNlIGFsd2F5cyBi
ZSBjYXJlZnVsIHdoaWxlCj4+IGNvcHlpbmcgc29tZW9uZXMgZWxzZSBjb2RlIDopCj4gCj4gR29v
ZCBjYXRjaC4gSSBndWVzcyBkZXZtX2FkZF9hY3Rpb25fb3JfcmVzZXQoKSB3b3VsZCBhbHNvIHdv
cmsuLi4gb3IKPiBydW5uaW5nIFNtYXRjaCBvbiBuZXcgY29kZS4gU21hdGNoIHNob3VsZCBwb2lu
dCBpdCBvdXQuCgpUaGUgZGV2bV9hZGRfYWN0aW9uX29yX3Jlc2V0KCkgc2hvdWxkbid0IGhlbHAg
bXVjaCBpbiB0aGlzIHBhcnRpY3VsYXIKY2FzZSBiZWNhdXNlIGl0J3MgdG9vIGVhcmx5IGZvciB0
aGUgZGV2bV9hZGRfYWN0aW9uIGhlcmUuCgpIYXZpbmcgYW4gZXhwbGljaXQgcHV0X2RldmljZSgp
IGluIGFsbCBlcnJvciBjb2RlIHBhdGhzIGFsc28gaGVscHMgd2l0aAppbXByb3ZpbmcgcmVhZGFi
aWxpdHkgb2YgdGhlIGNvZGUgYSB0YWQsIElNTy4KClNtYXRjaCBpbmRlZWQgc2hvdWxkIGNhdGNo
IHRoaXMgYnVnLCBidXQgU21hdGNoIHVzdWFsbHkgaXNuJ3QgYSBwYXJ0IG9mCnRoZSBkZXZlbG9w
ZXJzIHdvcmtmbG93LiBNb3JlIG9mdGVuIFNtYXRjaCBpcyBhIHBhcnQgb2YgbWFpbnRhaW5lcnMK
d29ya2Zsb3csIGhlbmNlIHN1Y2ggcHJvYmxlbXMgdXN1YWxseSBhcmUgZ2V0dGluZyBjYXVnaHQg
YmVmb3JlIHBhdGNoZXMKYXJlIGFwcGxpZWQuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby9pb21tdQ==
