Return-Path: <SRS0=1bbG=JU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95640C433B4
	for <iommu@archiver.kernel.org>; Fri, 23 Apr 2021 15:23:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E55E613D5
	for <iommu@archiver.kernel.org>; Fri, 23 Apr 2021 15:23:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E55E613D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A46CD84388;
	Fri, 23 Apr 2021 15:23:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BKqAvOmS4KAN; Fri, 23 Apr 2021 15:23:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 974D98437F;
	Fri, 23 Apr 2021 15:23:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B96BC000F;
	Fri, 23 Apr 2021 15:23:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8101FC000B
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 15:23:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7C70940645
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 15:23:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q1_B8Kk7BEaW for <iommu@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 15:23:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 85AB640640
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 15:23:26 +0000 (UTC)
Received: by mail-lf1-x130.google.com with SMTP id g8so78140992lfv.12
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 08:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=n5/P3oLW/T875nhk38fWvvBcXE+/GVaIkWm4ulWT5wE=;
 b=W5cQCMg7NNkYQKAZqRvcb4c8g4HSECVX1Edc17mn3r0emGHFU3Z/4HKbnvPlLO5C07
 GkucuOR+TdOONwnH/ikfN+nQnJOvd1FqUu8by2KhZ/NjfEAtKOv9cIn6tfr7LS5qTMtB
 tCGaFtIMZC6hiTmkuOH42dUk3YOZzaxKsR1Hc0n2Wi7YK1WQegQNS6jcvKxOAfZvQ8AG
 RBeuBFoVvbOqnAG1+sERGib8EMpkNXAhCnhPlrsZEgKITr0S0LVoQ4xmbgNahqfQv4jT
 peix0RW3vtyN4lypDBjppnK7TFL6iRJPhlUm3dlHQP++mKkM2ANyxaUx8sFs9Nywh8hs
 vsbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=n5/P3oLW/T875nhk38fWvvBcXE+/GVaIkWm4ulWT5wE=;
 b=j3wWUMIDa/RjgMwCa27iFwI975TCAYOdrgV2TjyJhrJLiXjVgV5BcVgIrgWjOlTF+x
 S6d8zWC9ZBmXzOEPuo0F2JyNH5Kg62smNKd5XsXwlcnITWN71tLzgD0U9Dvx33Dp7bqD
 a7hjoTi/sj4a8jojUHpFVkLF2ddLmLEzUY3kIMyX+uY7WiudbmcDChIkv5YEFXt3gtEh
 I7jEVSxmWMenRFZI6GW/LkFUcLjf8pJ/5yT5fFMPi1gnGt93Ykv9bH52JOge18fA8wuH
 t39Dh9L8q0SVjVQP2o9gftY0kk6UaCFWEYyaL8ezmQKfclSsTiVrXR7g6RnVK5pIh+sV
 wYQg==
X-Gm-Message-State: AOAM530m0HgYtq7TMutVmtH/BlJpiUn2yvSe1NP7QvYmYm71NvDkhC8c
 RSffpzLRo9zak4EvrLrm70U=
X-Google-Smtp-Source: ABdhPJx7dckk2pxEp/9xgSTGhkwCinZbZk3SLiXmMuI4u5wtA2nNSFJjJcolacRxt2TyFsCkVflzfw==
X-Received: by 2002:ac2:5299:: with SMTP id q25mr3354496lfm.594.1619191404448; 
 Fri, 23 Apr 2021 08:23:24 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-103.dynamic.spd-mgts.ru.
 [109.252.193.103])
 by smtp.googlemail.com with ESMTPSA id c2sm581127lfi.143.2021.04.23.08.23.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Apr 2021 08:23:24 -0700 (PDT)
Subject: Re: [PATCH v1 2/2] iommu/tegra-smmu: Revert workaround that was
 needed for Nyan Big Chromebook
To: Guillaume Tucker <guillaume.tucker@collabora.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>
References: <20210328233256.20494-1-digetx@gmail.com>
 <20210328233256.20494-2-digetx@gmail.com>
 <20210401085549.GA31146@Asurada-Nvidia>
 <50a7e4c7-0e72-534a-a317-366e455213c1@gmail.com>
 <d01ccde4-5fa9-2aa7-c28b-b3899cc54c54@collabora.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <724e683f-5317-cdf7-7351-fcfd42b7b607@gmail.com>
Date: Fri, 23 Apr 2021 18:23:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <d01ccde4-5fa9-2aa7-c28b-b3899cc54c54@collabora.com>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>, linux-tegra@vger.kernel.org,
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

MjMuMDQuMjAyMSAxODowMSwgR3VpbGxhdW1lIFR1Y2tlciDQv9C40YjQtdGCOgo+IE9uIDAyLzA0
LzIwMjEgMTU6NDAsIERtaXRyeSBPc2lwZW5rbyB3cm90ZToKPj4gMDEuMDQuMjAyMSAxMTo1NSwg
Tmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4+PiBPbiBNb24sIE1hciAyOSwgMjAyMSBhdCAwMjoz
Mjo1NkFNICswMzAwLCBEbWl0cnkgT3NpcGVua28gd3JvdGU6Cj4+Pj4gVGhlIHByZXZpb3VzIGNv
bW1pdCBmaXhlcyBwcm9ibGVtIHdoZXJlIGRpc3BsYXkgY2xpZW50IHdhcyBhdHRhY2hpbmcgdG9v
Cj4+Pj4gZWFybHkgdG8gSU9NTVUgZHVyaW5nIGtlcm5lbCBib290IGluIGEgbXVsdGktcGxhdGZv
cm0ga2VybmVsIGNvbmZpZ3VyYXRpb24KPj4+PiB3aGljaCBlbmFibGVzIENPTkZJR19BUk1fRE1B
X1VTRV9JT01NVT15LiBUaGUgd29ya2Fyb3VuZCB0aGF0IGhlbHBlZCB0bwo+Pj4+IGRlZmVyIHRo
ZSBJT01NVSBhdHRhY2htZW50IGZvciBOeWFuIEJpZyBDaHJvbWVib29rIGlzbid0IG5lZWRlZCBh
bnltb3JlLAo+Pj4+IHJldmVydCBpdC4KPj4+Cj4+PiBTb3JyeSBmb3IgdGhlIGxhdGUgcmVwbHku
IEkgaGF2ZSBiZWVuIGJ1c3kgd2l0aCBkb3duc3RyZWFtIHRhc2tzLgo+Pj4KPj4+IEkgd2lsbCBn
aXZlIHRoZW0gYSB0cnkgYnkgdGhlIGVuZCBvZiB0aGUgd2Vlay4gWWV0LCBwcm9iYWJseSBpdCdk
Cj4+PiBiZSBiZXR0ZXIgdG8gaW5jbHVkZSBHdWlsbGF1bWUgYWxzbyBhcyBoZSBoYXMgdGhlIE55
YW4gcGxhdGZvcm0uCj4+Pgo+Pgo+PiBJbmRlZWQsIHRoYW5rcy4gQWx0aG91Z2gsIEknbSBwcmV0
dHkgc3VyZSB0aGF0IGl0J3MgdGhlIHNhbWUgaXNzdWUgd2hpY2gKPj4gSSByZXByb2R1Y2VkIG9u
IE5leHVzIDcuCj4+Cj4+IEd1aWxsYXVtZSwgY291bGQgeW91IHBsZWFzZSBnaXZlIGEgdGVzdCB0
byB0aGVzZSBwYXRjaGVzIG9uIE55YW4gQmlnPwo+PiBUaGVyZSBzaG91bGQgYmUgbm8gRU1FTSBl
cnJvcnMgaW4gdGhlIGtlcm5lbCBsb2cgd2l0aCB0aGlzIHBhdGNoZXMuCj4+Cj4+IGh0dHBzOi8v
cGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC9saW51eC10ZWdyYS9saXN0Lz9zZXJpZXM9MjM2
MjE1Cj4gCj4gU28gc29ycnkgZm9yIHRoZSB2ZXJ5IGxhdGUgcmVwbHkuICBJIGhhdmUgdHJpZWQg
dGhlIHBhdGNoZXMgYnV0Cj4gaGl0IHNvbWUgaXNzdWVzIG9uIGxpbnV4LW5leHQsIGl0J3Mgbm90
IHJlYWNoaW5nIGEgbG9naW4gcHJvbXB0Cj4gd2l0aCBuZXh0LTIwMjEwNDIyLiAgU28gSSB0aGVu
IHRyaWVkIHdpdGggbmV4dC0yMDIxMDQxOSB3aGljaAo+IGRvZXMgYm9vdCBidXQgc2hvd3MgdGhl
IElPTU1VIGVycm9yOgo+IAo+IDw2PlsgICAgMi45OTUzNDFdIHRlZ3JhLWRjIDU0MjAwMDAwLmRj
OiBBZGRpbmcgdG8gaW9tbXUgZ3JvdXAgMQo+IDw0PlsgICAgMy4wMDEwNzBdIEZhaWxlZCB0byBh
dHRhY2hlZCBkZXZpY2UgNTQyMDAwMDAuZGMgdG8gSU9NTVVfbWFwcGluZyAgCj4gCj4gICBodHRw
czovL2xhdmEuY29sbGFib3JhLmNvLnVrL3NjaGVkdWxlci9qb2IvMzU3MDA1MiNMMTEyMAo+IAo+
IFRoZSBicmFuY2ggSSdtIHVzaW5nIHdpdGggdGhlIHBhdGNoZXMgYXBwbGllZCBjYW4gYmUgZm91
bmQgaGVyZToKPiAKPiAgIGh0dHBzOi8vZ2l0bGFiLmNvbGxhYm9yYS5jb20vZ3R1Y2tlci9saW51
eC8tL2NvbW1pdHMvbmV4dC0yMDIxMDQxOS1ueWFuLWJpZy1kcm0tcmVhZC8KPiAKPiBIb3BlIHRo
aXMgaGVscHMsIGxldCBtZSBrbm93IGlmIHlvdSBuZWVkIGFueXRoaW5nIGVsc2UgdG8gYmUKPiB0
ZXN0ZWQuCgoKSGVsbG8gR3VpbGxhdW1lLAoKVGhlIGN1cnJlbnQgbGludXgtbmV4dCBkb2Vzbid0
IGJvb3Qgb24gYWxsIEFSTSAoQUZBSUspLCB0aGUgb2xkZXIKbmV4dC0yMDIxMDQxMyB3b3Jrcy4g
VGhlIGFib3ZlIG1lc3NhZ2Ugc2hvdWxkIGJlIHVucmVsYXRlZCB0byB0aGUgYm9vdApwcm9ibGVt
LiBJdCBzaG91bGQgYmUgb2theSB0byBpZ25vcmUgdGhhdCBtZXNzYWdlIGFzIGl0IHNob3VsZCBi
ZQpoYXJtbGVzcyBpbiB5b3VycyBjYXNlLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vaW9tbXU=
