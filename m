Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1EC2C433F5
	for <iommu@archiver.kernel.org>; Tue,  7 Dec 2021 10:27:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 49F3140533;
	Tue,  7 Dec 2021 10:27:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5zWwGrz6BRD6; Tue,  7 Dec 2021 10:27:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D80CF40104;
	Tue,  7 Dec 2021 10:27:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0EF4C002F;
	Tue,  7 Dec 2021 10:27:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94637C0012
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 10:27:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8F65941C62
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 10:27:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xl2XIOEXKI_y for <iommu@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 10:27:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4982A41C59
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 10:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638872869;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WuGNH/dyVygpiGOJkCWGmo3DKhkMVbJWC9pFgiPTsyo=;
 b=BeY/pB6JBFzY59tmTdZe4AXopZACiSWFnLMm5ByGHxj4l18n9rPvASGok1s/vKma1NmW3+
 m4EDR83Dd97tKH3i+szdQWqGGpovYoftjC2L3dpRjA/vCdaDCGVGyp2oKjAEbMryQskZr1
 9xjFUrfKHrkwBvhRjL+4f2lXeqYSo54=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-89-ViLELDSbOku16I2uFpxnYw-1; Tue, 07 Dec 2021 05:27:46 -0500
X-MC-Unique: ViLELDSbOku16I2uFpxnYw-1
Received: by mail-wm1-f69.google.com with SMTP id
 a64-20020a1c7f43000000b003335e5dc26bso7509037wmd.8
 for <iommu@lists.linux-foundation.org>; Tue, 07 Dec 2021 02:27:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=WuGNH/dyVygpiGOJkCWGmo3DKhkMVbJWC9pFgiPTsyo=;
 b=aJwHbM4KXlcN73db9nuheypbBb6EHoPkuO/0pvc7dl5HdVOekFsygk5Lh79T432kLd
 M7vesv5nbCuDW5h1O1LBm6R8eERCK1/pd/qfOnmetfXCyr6baChS3rXOnna4Z070nAQ5
 1OdfV+VLcnOSZB39nlodaz2zTMSYrL852j0dZrROtSKMWLANF/xtD7zHTjHXi/XzD5kb
 M086Qr6MCN99ZAYuK4gJKY8mDhKiJduRhgctl9hFhxytE/fDyCGptXZVbJ69tGUXllwi
 u+bQjk3Z3fxlfZ/1mNsk+K2nCZ46yS9Khb0ucWqC4ux89W9v5pdD7rcctnsgUCqtCeh3
 MLag==
X-Gm-Message-State: AOAM533Yxttj/BXAm5sPcK3+BVHpseZhHuYsZDUUNwffAae1lcFqF0TD
 MMMc0bhhE5XPLCIK/vDzpTfn0KmmzPF2d8VB6m7gIFuWjDFM/OKeYRpY6Lf78q9Mn533A9PyGVm
 htoQG1W38gKbc6p8ZSof6+cCIsxktSA==
X-Received: by 2002:adf:d22a:: with SMTP id k10mr51871510wrh.80.1638872865021; 
 Tue, 07 Dec 2021 02:27:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw5SYKxnf/czGLnzekcByHTylqSUw2oDFUY77k108vZsKZFOCs+7tv9nPFdqCwIsIDIRwPszg==
X-Received: by 2002:adf:d22a:: with SMTP id k10mr51871467wrh.80.1638872864803; 
 Tue, 07 Dec 2021 02:27:44 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id d15sm18622235wri.50.2021.12.07.02.27.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Dec 2021 02:27:43 -0800 (PST)
Subject: Re: [RFC v16 0/9] SMMUv3 Nested Stage Setup (IOMMU part)
To: Zhangfei Gao <zhangfei.gao@linaro.org>, eric.auger.pro@gmail.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, jean-philippe@linaro.org,
 zhukeqian1@huawei.com
References: <20211027104428.1059740-1-eric.auger@redhat.com>
 <ee119b42-92b1-5744-4321-6356bafb498f@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
Message-ID: <7763531a-625d-10c6-c35e-2ce41e75f606@redhat.com>
Date: Tue, 7 Dec 2021 11:27:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <ee119b42-92b1-5744-4321-6356bafb498f@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Reply-To: eric.auger@redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SGkgWmhhbmdmZWksCgpPbiAxMi8zLzIxIDE6MjcgUE0sIFpoYW5nZmVpIEdhbyB3cm90ZToKPgo+
IEhpLCBFcmljCj4KPiBPbiAyMDIxLzEwLzI3IOS4i+WNiDY6NDQsIEVyaWMgQXVnZXIgd3JvdGU6
Cj4+IFRoaXMgc2VyaWVzIGJyaW5ncyB0aGUgSU9NTVUgcGFydCBvZiBIVyBuZXN0ZWQgcGFnaW5n
IHN1cHBvcnQKPj4gaW4gdGhlIFNNTVV2My4KPj4KPj4gVGhlIFNNTVV2MyBkcml2ZXIgaXMgYWRh
cHRlZCB0byBzdXBwb3J0IDIgbmVzdGVkIHN0YWdlcy4KPj4KPj4gVGhlIElPTU1VIEFQSSBpcyBl
eHRlbmRlZCB0byBjb252ZXkgdGhlIGd1ZXN0IHN0YWdlIDEKPj4gY29uZmlndXJhdGlvbiBhbmQg
dGhlIGhvb2sgaXMgaW1wbGVtZW50ZWQgaW4gdGhlIFNNTVV2MyBkcml2ZXIuCj4+Cj4+IFRoaXMg
YWxsb3dzIHRoZSBndWVzdCB0byBvd24gdGhlIHN0YWdlIDEgdGFibGVzIGFuZCBjb250ZXh0Cj4+
IGRlc2NyaXB0b3JzIChzby1jYWxsZWQgUEFTSUQgdGFibGUpIHdoaWxlIHRoZSBob3N0IG93bnMg
dGhlCj4+IHN0YWdlIDIgdGFibGVzIGFuZCBtYWluIGNvbmZpZ3VyYXRpb24gc3RydWN0dXJlcyAo
U1RFKS4KPj4KPj4gVGhpcyB3b3JrIG1haW5seSBpcyBwcm92aWRlZCBmb3IgdGVzdCBwdXJwb3Nl
IGFzIHRoZSB1cHBlcgo+PiBsYXllciBpbnRlZ3JhdGlvbiBpcyB1bmRlciByZXdvcmsgYW5kIGJv
dW5kIHRvIGJlIGJhc2VkIG9uCj4+IC9kZXYvaW9tbXUgaW5zdGVhZCBvZiBWRklPIHR1bm5lbGlu
Zy4gSW4gdGhpcyB2ZXJzaW9uIHdlIGFsc28gZ2V0Cj4+IHJpZCBvZiB0aGUgTVNJIEJJTkRJTkcg
aW9jdGwsIGFzc3VtaW5nIHRoZSBndWVzdCBlbmZvcmNlcwo+PiBmbGF0IG1hcHBpbmcgb2YgaG9z
dCBJT1ZBcyB1c2VkIHRvIGJpbmQgcGh5c2ljYWwgTVNJIGRvb3JiZWxscy4KPj4gSW4gdGhlIGN1
cnJlbnQgUUVNVSBpbnRlZ3JhdGlvbiB0aGlzIGlzIGFjaGlldmVkIGJ5IGV4cG9zaW5nCj4+IFJN
UnMgdG8gdGhlIGd1ZXN0LCB1c2luZyBTaGFtZWVyJ3Mgc2VyaWVzIFsxXS4gVGhpcyBhcHByb2Fj
aAo+PiBpcyBSRkMgYXMgdGhlIElPUlQgc3BlYyBpcyBub3QgcmVhbGx5IG1lYW50IHRvIGRvIHRo
YXQKPj4gKHNpbmdsZSBtYXBwaW5nIGZsYWcgbGltaXRhdGlvbikuCj4+Cj4+IEJlc3QgUmVnYXJk
cwo+Pgo+PiBFcmljCj4+Cj4+IFRoaXMgc2VyaWVzIChIb3N0KSBjYW4gYmUgZm91bmQgYXQ6Cj4+
IGh0dHBzOi8vZ2l0aHViLmNvbS9lYXVnZXIvbGludXgvdHJlZS92NS4xNS1yYzctbmVzdGVkLXYx
Ngo+PiBUaGlzIGluY2x1ZGVzIGEgcmViYXNlZCBWRklPIGludGVncmF0aW9uIChhbHRob3VnaCBu
b3QgbWVhbnQKPj4gdG8gYmUgdXBzdHJlYW1lZCkKPj4KPj4gR3Vlc3Qga2VybmVsIGJyYW5jaCBj
YW4gYmUgZm91bmQgYXQ6Cj4+IGh0dHBzOi8vZ2l0aHViLmNvbS9lYXVnZXIvbGludXgvdHJlZS9z
aGFtZWVyX3JtcnJfdjcKPj4gZmVhdHVyaW5nIFsxXQo+Pgo+PiBRRU1VIGludGVncmF0aW9uIChz
dGlsbCBiYXNlZCBvbiBWRklPIGFuZCBleHBvc2luZyBSTVJzKQo+PiBjYW4gYmUgZm91bmQgYXQ6
Cj4+IGh0dHBzOi8vZ2l0aHViLmNvbS9lYXVnZXIvcWVtdS90cmVlL3Y2LjEuMC1ybXItdjItbmVz
dGVkX3NtbXV2M192MTAKPj4gKHVzZSBpb21tdT1uZXN0ZWQtc21tdXYzIEFSTSB2aXJ0IG9wdGlv
bikKPj4KPj4gR3Vlc3QgZGVwZW5kZW5jeToKPj4gWzFdIFtQQVRDSCB2NyAwLzldIEFDUEkvSU9S
VDogU3VwcG9ydCBmb3IgSU9SVCBSTVIgbm9kZQo+Cj4gVGhhbmtzIGEgbG90IGZvciB1cGdyYWRp
bmcgdGhlc2UgcGF0Y2hlcy4KPgo+IEkgaGF2ZSBiYXNpY2FsbHkgdmVyaWZpZWQgdGhlc2UgcGF0
Y2hlcyBvbiBIaVNpbGljb24gS3VucGVuZzkyMC4KPiBBbmQgaW50ZWdyYXRlZCB0aGVtIHRvIHRo
ZXNlIGJyYW5jaGVzLgo+IGh0dHBzOi8vZ2l0aHViLmNvbS9MaW5hcm8vbGludXgta2VybmVsLXVh
ZGsvdHJlZS91YWNjZS1kZXZlbC01LjE2Cj4gaHR0cHM6Ly9naXRodWIuY29tL0xpbmFyby9xZW11
L3RyZWUvdjYuMS4wLXJtci12Mi1uZXN0ZWRfc21tdXYzX3YxMAo+Cj4gVGhvdWdoIHRoZXkgYXJl
IHByb3ZpZGVkIGZvciB0ZXN0IHB1cnBvc2UsCj4KPiBUZXN0ZWQtYnk6IFpoYW5nZmVpIEdhbyA8
emhhbmdmZWkuZ2FvQGxpbmFyby5vcmc+CgpUaGFuayB5b3UgdmVyeSBtdWNoLiBBcyB5b3UgbWVu
dGlvbmVkLCB1bnRpbCB3ZSBkbyBub3QgaGF2ZSB0aGUKL2Rldi9pb21tdSBpbnRlZ3JhdGlvbiB0
aGlzIGlzIG1haW50YWluZWQgZm9yIHRlc3RpbmcgcHVycG9zZS4gVGhlIFNNTVUKY2hhbmdlcyBz
aG91bGRuJ3QgYmUgbXVjaCBpbXBhY3RlZCB0aG91Z2guClRoZSBhZGRlZCB2YWx1ZSBvZiB0aGlz
IHJlc3BpbiB3YXMgdG8gcHJvcG9zZSBhbiBNU0kgYmluZGluZyBzb2x1dGlvbgpiYXNlZCBvbiBS
TVJScyB3aGljaCBzaW1wbGlmeSB0aGluZ3MgYXQga2VybmVsIGxldmVsLgoKVGhhbmtzIQoKRXJp
Ywo+Cj4gVGhhbmtzCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21t
dQ==
