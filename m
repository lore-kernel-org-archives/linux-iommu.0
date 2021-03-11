Return-Path: <SRS0=X4VR=IJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E98C4332D
	for <iommu@archiver.kernel.org>; Thu, 11 Mar 2021 12:06:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3316164FCD
	for <iommu@archiver.kernel.org>; Thu, 11 Mar 2021 12:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3316164FCD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AFEF96074D;
	Thu, 11 Mar 2021 12:06:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p6HGNB6zDTJq; Thu, 11 Mar 2021 12:06:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8F933605BF;
	Thu, 11 Mar 2021 12:06:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 66F04C000B;
	Thu, 11 Mar 2021 12:06:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97BF9C0001
 for <iommu@lists.linux-foundation.org>; Thu, 11 Mar 2021 12:06:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 70BBA447DA
 for <iommu@lists.linux-foundation.org>; Thu, 11 Mar 2021 12:06:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LOp8i2XX8sUp for <iommu@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 12:06:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 39C8B44352
 for <iommu@lists.linux-foundation.org>; Thu, 11 Mar 2021 12:06:29 +0000 (UTC)
Received: by mail-lf1-x130.google.com with SMTP id e7so39407499lft.2
 for <iommu@lists.linux-foundation.org>; Thu, 11 Mar 2021 04:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=cz3qHn16lIPc6Bvf+yNu/XUkZnLJ8XOdvMZnsOmsGnY=;
 b=a8DPjScMZmz1pro+pLVDtwvqiGnZRmG6Xms7jxGZ2yv19dDL5etamVTUAwCE5aE5UB
 WbfnH6YY/EmKPQsJERMn1xtj0OSb//1hnrbLkefJhRdxD9GN/kVO0V4Jsl4c0Vwghv6I
 g7yYUiaAR9RYkkfJBYpTqBxIDtyeyH5u7v3TR9HbmJbqo+FxEQMpJuZy629zbUSOO1jV
 xMgr+qePicNIjbQWe1AqK/OplgsPrJUH5ywEeTL23vD/12wK7vtTHnCVnJiMkHygNpHS
 fRP/TajOeAjwmbeayCi1L85VH8A56VRc27jaTd8TSw/Adpz3OWDLIttY8iFBzhudfEAr
 0pvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cz3qHn16lIPc6Bvf+yNu/XUkZnLJ8XOdvMZnsOmsGnY=;
 b=nfKTBBmoVkEq3J1Y0gz0u7VQ4Yd+Dd2fCBDSdI3yQUXdIytk0NmCE3fh0NfP+wIEei
 /el0Oq71sYroX+fLxYBBYFPGtddxwiFJ5/rLAAoGGidiZL7STdRRLy1wnPOHHiqE5Rsu
 JwheGQn3sHmxfPhivavBNpCmoTGHD5PX7WZJwEirI6fKIx9c5Hab8t7qECa5nmM2NW6X
 uIdCfu9YLLAH3KVRcs6KcxlFF7IpTRNO6+n6GrI2s1AW0msxgtkKWfk6rldwPvWvOpK9
 tXqu5b3pnebKU3GV/WbjIyY6oxeWbn0Jk/gSpw7v2tMAN7PVjm2IedKRkl4aq22lNw/k
 Aqlg==
X-Gm-Message-State: AOAM531lNXOgUhtGgZyRE8cdJtnWRCwubR6L9f3Do9gdpOAT0LWphe5J
 CcEIYUJsQgy5IMtlVOzPqxA=
X-Google-Smtp-Source: ABdhPJz5kk96u5mzTVzWD+Rqjk1vE/7c+3MwUfCcYcQA+Y7MilwieSJz6w4fEDuz7IuHKIpk6czCaQ==
X-Received: by 2002:a19:22d6:: with SMTP id i205mr2097509lfi.352.1615464387156; 
 Thu, 11 Mar 2021 04:06:27 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-52.dynamic.spd-mgts.ru.
 [109.252.193.52])
 by smtp.googlemail.com with ESMTPSA id g6sm759501lfh.232.2021.03.11.04.06.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Mar 2021 04:06:26 -0800 (PST)
Subject: Re: [PATCH] iommu/tegra-smmu: Fix mc errors on tegra124-nyan
To: Nicolin Chen <nicoleotsuka@gmail.com>
References: <20210218220702.1962-1-nicoleotsuka@gmail.com>
 <a8a7a0af-895f-9d79-410d-5dd03ebbd6dd@gmail.com>
 <7714f272-3862-84ac-306d-86363a1c4880@gmail.com>
 <20210310221707.GB10431@Asurada-Nvidia>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <8c2f5d94-8835-9994-21aa-660df29d383c@gmail.com>
Date: Thu, 11 Mar 2021 15:06:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20210310221707.GB10431@Asurada-Nvidia>
Content-Language: en-US
Cc: guillaume.tucker@collabora.com, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, thierry.reding@gmail.com, linux-tegra@vger.kernel.org,
 will@kernel.org, linux-kernel@vger.kernel.org
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

MTEuMDMuMjAyMSAwMToxNywgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gT24gV2VkLCBNYXIg
MTAsIDIwMjEgYXQgMTE6MjI6NTdQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+PiAx
MC4wMy4yMDIxIDIyOjEzLCBEbWl0cnkgT3NpcGVua28g0L/QuNGI0LXRgjoKPj4+IEkgZm91bmQg
dGhhdCB0aGlzIHBhdGNoIGludHJvZHVjZWQgYSBzZXJpb3VzIHJlZ3Jlc3Npb24gb24gVGVncmEz
MCB1c2luZwo+Pj4gdG9kYXkncyBsaW51eC1uZXh0LiBUZWdyYTMwIGhhcyB0d28gM2QgaC93IGJs
b2NrcyBjb25uZWN0ZWQgaW4gU0xJIGFuZAo+Pj4gb25seSBvbmUgb2YgdGhlIGJsb2NrcyBpcyBu
b3cgYXR0YWNoZWQgdG8gSU9NTVUgZG9tYWluLCBtZWFuaW5nIHRoYXQgR1BVCj4+PiBpcyB1bnVz
YWJsZSBub3cuIEFsbCAzZCwgMmQgYW5kIGRpc3BsYXkgZGV2aWNlcyBzaGFyZSB0aGUgc2FtZSAi
RFJNIgo+Pj4gZ3JvdXAgb24gVGVncmEzMC4KPj4+Cj4+PiBOaWNvbGluLCBwbGVhc2UgbGV0IG1l
IGtub3cgaWYgaGF2ZSBhbnkgc3VnZ2VzdGlvbnMuIEkgbWF5IHRha2UgYSBjbG9zZXIKPj4+IGxv
b2sgYSBkYXkgbGF0ZXIsIGZvciBub3cgSSdsbCBqdXN0IHJldmVydCB0aGlzIHBhdGNoIGxvY2Fs
bHkuIFRoYW5rcyBpbgo+Pj4gYWR2YW5jZS4KPj4+Cj4+Cj4+IEFjdHVhbGx5LCB0aGlzIHdhcyBl
YXN5IHRvIGZpeDoKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvdGVncmEtc21tdS5j
IGIvZHJpdmVycy9pb21tdS90ZWdyYS1zbW11LmMKPj4gaW5kZXggOTdlYjYyZjY2N2QyLi42Mzlk
NWNlYWI2MGIgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvdGVncmEtc21tdS5jCj4+ICsr
KyBiL2RyaXZlcnMvaW9tbXUvdGVncmEtc21tdS5jCj4+IEBAIC04NTMsOCArODUzLDYgQEAgc3Rh
dGljIHN0cnVjdCBpb21tdV9kZXZpY2UKPj4gKnRlZ3JhX3NtbXVfcHJvYmVfZGV2aWNlKHN0cnVj
dCBkZXZpY2UgKmRldikKPj4KPj4gIAkJCWlmIChlcnIgPCAwKQo+PiAgCQkJCXJldHVybiBFUlJf
UFRSKGVycik7Cj4+IC0KPj4gLQkJCWJyZWFrOwo+IAo+IEhtbS4uSSBkb24ndCB1bmRlcnN0YW5k
IHdoeSB0aGlzICJicmVhayIgY2F1c2VzIHByb2JsZW1zIG9uIFRlZ3JhMzAuCj4gVGhlIG9sZGVy
IHZlcnNpb25zIHRoYXQgdXNlZCBfZmluZCgpK2NvbmZpZ3VyZSgpIGhhZCBpdCBhbHNvLCBlLmcu
Ogo+IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y1LjkuMTYvc291cmNlL2RyaXZl
cnMvaW9tbXUvdGVncmEtc21tdS5jI0w3NjAKPiAKPiBEbWl0cnksIGRvIHlvdSBoYXZlIGFueSBp
ZGVhPwo+IAoKVGhlIG9sZGVyIHZhcmlhbnQgb2YgdGVncmFfc21tdV9hdHRhY2hfZGV2KCkgZGlk
bid0IHVzZSBmd3NwZWMgWzFdLCB0aGF0Cm1ha2VzIHRoZSBkaWZmZXJlbmNlLiBJbiBvdGhlciB3
b3JkcywgdGhlIG9sZGVyIHZhcmlhbnQgb2YKdGVncmFfc21tdV9wcm9iZV9kZXZpY2UoKSB3YXMg
YWxyZWFkeSBidWdneSwgYnV0IHRoZSBidWcgd2FzIG1hc2tlZCBieQp0aGUgdGVncmFfc21tdV9h
dHRhY2hfZGV2KCkgdGhhdCBkaWRuJ3QgdXNlIHRoZSBmd3NwZWMuCgpbMV0KaHR0cHM6Ly9lbGl4
aXIuYm9vdGxpbi5jb20vbGludXgvdjUuMTAuMjIvc291cmNlL2RyaXZlcnMvaW9tbXUvdGVncmEt
c21tdS5jI0w0NzYKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
