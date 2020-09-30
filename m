Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7573C4727C
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 15:53:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7495820759
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 15:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6IOemkM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7495820759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id DAA4987213;
	Wed, 30 Sep 2020 15:53:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZY30-ZUyFaq5; Wed, 30 Sep 2020 15:53:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A17378720B;
	Wed, 30 Sep 2020 15:53:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81631C0890;
	Wed, 30 Sep 2020 15:53:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35BEAC016F
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 15:53:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1520B86658
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 15:53:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B5ARkSqZEu3U for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 15:53:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com
 [209.85.167.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 11DAA860CE
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 15:53:10 +0000 (UTC)
Received: by mail-lf1-f68.google.com with SMTP id x69so2766188lff.3
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 08:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=mUwr9+gr81AndshD5M4T6IEzStnM7KASijNGjOtwSAU=;
 b=k6IOemkMPjMAZCxLD1plzkMzJIDp4Dnbg88BPVOkT0Jd9tE3Hf1TfMM79+G4iVJf8t
 3oOavS4iHLKxRFGGnZI9RpRynmzN26ZPwAlE3nydZsbI3hMEvp6NX2rNaBZn3VRsa58p
 iSLO/n4TUXOuQ+Q6pHmP8dPCJfkcON+2yS9XIVsv6OTx5Xwfb51ADZfzKIFNLjMXNgC8
 AeBcMQchDka68QuNwVvQWQpBipsP6dKOIm/7LPvGjKQKV4hPgP3+J1nOpGwa9ZUU2MN8
 6qI2/zlVKVlVu83ML9EAiwvKAfxeoUhAdlMEO2v/Oivo4Dtil/zOe/dpNQ0e67qkPjcG
 uiYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mUwr9+gr81AndshD5M4T6IEzStnM7KASijNGjOtwSAU=;
 b=qQTCSPD1BAdxofVqweFcShgSrpUovDAoSijK0WwLlhX9zWeph9P3bPH9NkJRESS67i
 JIa3Rc2sD3E8O0mDIQCWiUOi3B7HWKG+/bPkTbsm/yxQe9h6qAkDsykNPUMqAOYdyKwF
 MnvLOR7/f7fEfltJGLPgyILwI4uBNAx+JzPQ9BhO2Z95qg+PULo1MCX3XC/VeB13tRrR
 0oCUll8cP4CBRLCnFqbQR+iiXdCnvVDoOxEC/WOWvh2LZOnxUMiHMq076ZTS48Rsatd1
 9XsUz+Mf7ydKOuPz8DDDrtsrcrjQuUfK/4iaIWnnCtVQuDmMR29qo05E/VRJehHYaCPo
 Idig==
X-Gm-Message-State: AOAM533PYyLomoYoB9ZSdJtBSr62rUY61ne9va4e6NaWjZgzn5efUeEh
 GuBlC7cW3LwvkhkRGcXO6HE=
X-Google-Smtp-Source: ABdhPJyynUROFkkXXDxzOL7zf+zV1pt1xWJJ4N7Stf4816L1rkJCjSAR2Qo9oTxetc+foSv+CBeNiQ==
X-Received: by 2002:a19:f50e:: with SMTP id j14mr1183122lfb.426.1601481188014; 
 Wed, 30 Sep 2020 08:53:08 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru.
 [109.252.170.211])
 by smtp.googlemail.com with ESMTPSA id g26sm191627ljl.116.2020.09.30.08.53.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2020 08:53:07 -0700 (PDT)
Subject: Re: [PATCH v3 1/3] memory: tegra: Add
 devm_tegra_get_memory_controller()
To: Thierry Reding <thierry.reding@gmail.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>
References: <20200930084258.25493-1-nicoleotsuka@gmail.com>
 <20200930084258.25493-2-nicoleotsuka@gmail.com>
 <20200930152320.GA3833404@ulmo>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ed7b4375-d06e-2750-e6fa-603ef2b60d36@gmail.com>
Date: Wed, 30 Sep 2020 18:53:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930152320.GA3833404@ulmo>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, krzk@kernel.org, jonathanh@nvidia.com,
 iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org
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

MzAuMDkuMjAyMCAxODoyMywgVGhpZXJyeSBSZWRpbmcg0L/QuNGI0LXRgjoKPiBPbiBXZWQsIFNl
cCAzMCwgMjAyMCBhdCAwMTo0Mjo1NkFNIC0wNzAwLCBOaWNvbGluIENoZW4gd3JvdGU6Cj4+IEZy
b206IERtaXRyeSBPc2lwZW5rbyA8ZGlnZXR4QGdtYWlsLmNvbT4KPj4KPj4gTXVsdGlwbGUgVGVn
cmEgZHJpdmVycyBuZWVkIHRvIHJldHJpZXZlIE1lbW9yeSBDb250cm9sbGVyIGFuZCBoZW5jZSB0
aGVyZQo+PiBpcyBxdWl0ZSBzb21lIGR1cGxpY2F0aW9uIG9mIHRoZSByZXRyaWV2YWwgY29kZSBh
bW9uZyB0aGUgZHJpdmVycy4gTGV0J3MKPj4gYWRkIGEgbmV3IGNvbW1vbiBoZWxwZXIgZm9yIHRo
ZSByZXRyaWV2YWwgb2YgdGhlIE1DLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBEbWl0cnkgT3NpcGVu
a28gPGRpZ2V0eEBnbWFpbC5jb20+Cj4+IFNpZ25lZC1vZmYtYnk6IE5pY29saW4gQ2hlbiA8bmlj
b2xlb3RzdWthQGdtYWlsLmNvbT4KPj4gLS0tCj4+Cj4+IENoYW5nZWxvZwo+PiB2Mi0+djM6Cj4+
ICAqIFJlcGxhY2VkIHdpdGggRGltdHJ5J3MgZGV2bV90ZWdyYV9nZXRfbWVtb3J5X2NvbnRyb2xs
ZXIoKQo+PiB2MS0+djI6Cj4+ICAqIE4vQQo+Pgo+PiAgZHJpdmVycy9tZW1vcnkvdGVncmEvbWMu
YyB8IDM5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+PiAgaW5jbHVk
ZS9zb2MvdGVncmEvbWMuaCAgICB8IDE3ICsrKysrKysrKysrKysrKysrCj4+ICAyIGZpbGVzIGNo
YW5nZWQsIDU2IGluc2VydGlvbnMoKykKPiAKPiBMZXQncyBub3QgYWRkIHRoaXMgaGVscGVyLCBw
bGVhc2UuIElmIGEgZGV2aWNlIG5lZWRzIGEgcmVmZXJlbmNlIHRvIHRoZQo+IG1lbW9yeSBjb250
cm9sbGVyLCBpdCBzaG91bGQgaGF2ZSBhIHBoYW5kbGUgdG8gdGhlIG1lbW9yeSBjb250cm9sbGVy
IGluCj4gZGV2aWNlIHRyZWUgc28gdGhhdCBpdCBjYW4gYmUgbG9va2VkIHVwIGV4cGxpY2l0bHku
Cj4gCj4gQWRkaW5nIHRoaXMgaGVscGVyIGlzIG9mZmljaWFsbHkgc2FuY3Rpb25pbmcgdGhhdCBp
dCdzIG9rYXkgbm90IHRvIGhhdmUKPiB0aGF0IHJlZmVyZW5jZSBhbmQgdGhhdCdzIGEgYmFkIGlk
ZWEuCgpBbmQgcGxlYXNlIGV4cGxhaW4gd2h5IGl0J3MgYSBiYWQgaWRlYSwgSSBkb24ndCBzZWUg
YW55dGhpbmcgYmFkIGhlcmUgYXQKYWxsLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vaW9tbXU=
