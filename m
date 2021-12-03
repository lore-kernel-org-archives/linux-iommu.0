Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 393BFC433EF
	for <iommu@archiver.kernel.org>; Fri,  3 Dec 2021 12:27:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8708D824DD;
	Fri,  3 Dec 2021 12:27:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h7QJDuRSocfc; Fri,  3 Dec 2021 12:27:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5FFFD824A4;
	Fri,  3 Dec 2021 12:27:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D8CBC006E;
	Fri,  3 Dec 2021 12:27:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC622C0012
 for <iommu@lists.linux-foundation.org>; Fri,  3 Dec 2021 12:27:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 99F2540132
 for <iommu@lists.linux-foundation.org>; Fri,  3 Dec 2021 12:27:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SafLNAfDGvaV for <iommu@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 12:27:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1D3FB400D8
 for <iommu@lists.linux-foundation.org>; Fri,  3 Dec 2021 12:27:48 +0000 (UTC)
Received: by mail-pg1-x531.google.com with SMTP id q16so2836214pgq.10
 for <iommu@lists.linux-foundation.org>; Fri, 03 Dec 2021 04:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=EA1du2e/ZPRzAt8K2DwIBgKjt5fsYwCbvSbLazp7FLA=;
 b=LnM14K0IH4hYWcx02Er5ag2+HMiyqlgR3Q0bBB0hoE/Yc+j2TzxgPYYBQHoDDQVheC
 2a1bjHXoHd+TLSDN5O7+t0DRX69uBDy1EpyIyLNnxRNBGd2czsiIHVDxr5tuI7xBzqYB
 /zTgw0PRoCeM4qOjNA7MACeNFmJfs7LtjmdeeHv7B+nhBnrKOEMjQtDmTh2gWHD+pkAG
 NCQfOnkp188m9zVsO6H4hFy6PPLm3lptrOhWxNYp//2esTtA4RfdwB6rAbNuhzZmdTJb
 jKTb7az+bf+exKCMGMRr61twCq1sgAWX500Y21LfOvfxR4xiz15JmzzH0kxo7NXy8oup
 Yj5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=EA1du2e/ZPRzAt8K2DwIBgKjt5fsYwCbvSbLazp7FLA=;
 b=LZRDtxAE0H6DMxg1G2UBqqfIr1tkYXTT9l1myYwYqS15P/nJdtMtu4FBAK8xkAA3AY
 Tk9ZCjOXU7ifp0AZxTEXFdAOsR8mwJSPbiiECKAIBF9lx91mxs+JlB7qHA2YRBTJndDM
 R4oW46RlEufcgObWG7oH/u2nE+iVXy7nyw65WyWKUcx5bEBRPWKslIadqe1NLQoMbaZQ
 JUtqbWzXFNPEbjUcOl3BlqJTIlzakRXe6N3eS+BrONAhdLFIv9/AZK112Sm52+N6Wv/G
 E6B1muwXUiWI+PbP5dctlQAjMrlk9oK6ia6dFW5yFVlvRbkgrL1k1PZW4KwzQuGoE8Xz
 UozQ==
X-Gm-Message-State: AOAM53070BZDf/hRiEwzjIcwkUQAE8YxyCUZxge1MXNBVqgJ8T3cGFZl
 Cy48JyvKuH4b8a6NClppYh3pug==
X-Google-Smtp-Source: ABdhPJyrxTUXmZtazjCg/eZ+NyB0KowH4QAVCWqZOWtphbHo3fiDsky8cC6Lf9QHm8d5ncPuLQ4aIg==
X-Received: by 2002:a63:6687:: with SMTP id a129mr4131270pgc.477.1638534468248; 
 Fri, 03 Dec 2021 04:27:48 -0800 (PST)
Received: from [10.152.0.6] ([94.177.118.64])
 by smtp.gmail.com with ESMTPSA id mp12sm5226964pjb.39.2021.12.03.04.27.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Dec 2021 04:27:47 -0800 (PST)
Subject: Re: [RFC v16 0/9] SMMUv3 Nested Stage Setup (IOMMU part)
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, jean-philippe@linaro.org,
 zhukeqian1@huawei.com
References: <20211027104428.1059740-1-eric.auger@redhat.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <ee119b42-92b1-5744-4321-6356bafb498f@linaro.org>
Date: Fri, 3 Dec 2021 20:27:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211027104428.1059740-1-eric.auger@redhat.com>
Content-Language: en-US
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, ashok.raj@intel.com,
 maz@kernel.org, vivek.gautam@arm.com, alex.williamson@redhat.com,
 vsethi@nvidia.com, lushenming@huawei.com, wangxingang5@huawei.com
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

CkhpLCBFcmljCgpPbiAyMDIxLzEwLzI3IOS4i+WNiDY6NDQsIEVyaWMgQXVnZXIgd3JvdGU6Cj4g
VGhpcyBzZXJpZXMgYnJpbmdzIHRoZSBJT01NVSBwYXJ0IG9mIEhXIG5lc3RlZCBwYWdpbmcgc3Vw
cG9ydAo+IGluIHRoZSBTTU1VdjMuCj4KPiBUaGUgU01NVXYzIGRyaXZlciBpcyBhZGFwdGVkIHRv
IHN1cHBvcnQgMiBuZXN0ZWQgc3RhZ2VzLgo+Cj4gVGhlIElPTU1VIEFQSSBpcyBleHRlbmRlZCB0
byBjb252ZXkgdGhlIGd1ZXN0IHN0YWdlIDEKPiBjb25maWd1cmF0aW9uIGFuZCB0aGUgaG9vayBp
cyBpbXBsZW1lbnRlZCBpbiB0aGUgU01NVXYzIGRyaXZlci4KPgo+IFRoaXMgYWxsb3dzIHRoZSBn
dWVzdCB0byBvd24gdGhlIHN0YWdlIDEgdGFibGVzIGFuZCBjb250ZXh0Cj4gZGVzY3JpcHRvcnMg
KHNvLWNhbGxlZCBQQVNJRCB0YWJsZSkgd2hpbGUgdGhlIGhvc3Qgb3ducyB0aGUKPiBzdGFnZSAy
IHRhYmxlcyBhbmQgbWFpbiBjb25maWd1cmF0aW9uIHN0cnVjdHVyZXMgKFNURSkuCj4KPiBUaGlz
IHdvcmsgbWFpbmx5IGlzIHByb3ZpZGVkIGZvciB0ZXN0IHB1cnBvc2UgYXMgdGhlIHVwcGVyCj4g
bGF5ZXIgaW50ZWdyYXRpb24gaXMgdW5kZXIgcmV3b3JrIGFuZCBib3VuZCB0byBiZSBiYXNlZCBv
bgo+IC9kZXYvaW9tbXUgaW5zdGVhZCBvZiBWRklPIHR1bm5lbGluZy4gSW4gdGhpcyB2ZXJzaW9u
IHdlIGFsc28gZ2V0Cj4gcmlkIG9mIHRoZSBNU0kgQklORElORyBpb2N0bCwgYXNzdW1pbmcgdGhl
IGd1ZXN0IGVuZm9yY2VzCj4gZmxhdCBtYXBwaW5nIG9mIGhvc3QgSU9WQXMgdXNlZCB0byBiaW5k
IHBoeXNpY2FsIE1TSSBkb29yYmVsbHMuCj4gSW4gdGhlIGN1cnJlbnQgUUVNVSBpbnRlZ3JhdGlv
biB0aGlzIGlzIGFjaGlldmVkIGJ5IGV4cG9zaW5nCj4gUk1ScyB0byB0aGUgZ3Vlc3QsIHVzaW5n
IFNoYW1lZXIncyBzZXJpZXMgWzFdLiBUaGlzIGFwcHJvYWNoCj4gaXMgUkZDIGFzIHRoZSBJT1JU
IHNwZWMgaXMgbm90IHJlYWxseSBtZWFudCB0byBkbyB0aGF0Cj4gKHNpbmdsZSBtYXBwaW5nIGZs
YWcgbGltaXRhdGlvbikuCj4KPiBCZXN0IFJlZ2FyZHMKPgo+IEVyaWMKPgo+IFRoaXMgc2VyaWVz
IChIb3N0KSBjYW4gYmUgZm91bmQgYXQ6Cj4gaHR0cHM6Ly9naXRodWIuY29tL2VhdWdlci9saW51
eC90cmVlL3Y1LjE1LXJjNy1uZXN0ZWQtdjE2Cj4gVGhpcyBpbmNsdWRlcyBhIHJlYmFzZWQgVkZJ
TyBpbnRlZ3JhdGlvbiAoYWx0aG91Z2ggbm90IG1lYW50Cj4gdG8gYmUgdXBzdHJlYW1lZCkKPgo+
IEd1ZXN0IGtlcm5lbCBicmFuY2ggY2FuIGJlIGZvdW5kIGF0Ogo+IGh0dHBzOi8vZ2l0aHViLmNv
bS9lYXVnZXIvbGludXgvdHJlZS9zaGFtZWVyX3JtcnJfdjcKPiBmZWF0dXJpbmcgWzFdCj4KPiBR
RU1VIGludGVncmF0aW9uIChzdGlsbCBiYXNlZCBvbiBWRklPIGFuZCBleHBvc2luZyBSTVJzKQo+
IGNhbiBiZSBmb3VuZCBhdDoKPiBodHRwczovL2dpdGh1Yi5jb20vZWF1Z2VyL3FlbXUvdHJlZS92
Ni4xLjAtcm1yLXYyLW5lc3RlZF9zbW11djNfdjEwCj4gKHVzZSBpb21tdT1uZXN0ZWQtc21tdXYz
IEFSTSB2aXJ0IG9wdGlvbikKPgo+IEd1ZXN0IGRlcGVuZGVuY3k6Cj4gWzFdIFtQQVRDSCB2NyAw
LzldIEFDUEkvSU9SVDogU3VwcG9ydCBmb3IgSU9SVCBSTVIgbm9kZQoKVGhhbmtzIGEgbG90IGZv
ciB1cGdyYWRpbmcgdGhlc2UgcGF0Y2hlcy4KCkkgaGF2ZSBiYXNpY2FsbHkgdmVyaWZpZWQgdGhl
c2UgcGF0Y2hlcyBvbiBIaVNpbGljb24gS3VucGVuZzkyMC4KQW5kIGludGVncmF0ZWQgdGhlbSB0
byB0aGVzZSBicmFuY2hlcy4KaHR0cHM6Ly9naXRodWIuY29tL0xpbmFyby9saW51eC1rZXJuZWwt
dWFkay90cmVlL3VhY2NlLWRldmVsLTUuMTYKaHR0cHM6Ly9naXRodWIuY29tL0xpbmFyby9xZW11
L3RyZWUvdjYuMS4wLXJtci12Mi1uZXN0ZWRfc21tdXYzX3YxMAoKVGhvdWdoIHRoZXkgYXJlIHBy
b3ZpZGVkIGZvciB0ZXN0IHB1cnBvc2UsCgpUZXN0ZWQtYnk6IFpoYW5nZmVpIEdhbyA8emhhbmdm
ZWkuZ2FvQGxpbmFyby5vcmc+CgpUaGFua3MKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2lvbW11
