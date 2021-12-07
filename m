Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C18C2C433EF
	for <iommu@archiver.kernel.org>; Tue,  7 Dec 2021 10:35:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BAD1160799;
	Tue,  7 Dec 2021 10:35:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QZS-1kfMn1gd; Tue,  7 Dec 2021 10:35:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2FA8B607C6;
	Tue,  7 Dec 2021 10:35:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1019C002F;
	Tue,  7 Dec 2021 10:35:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 92B3DC0012
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 10:35:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6CEED41C62
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 10:35:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GmwPN-yiKGCl for <iommu@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 10:35:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 313BD41C50
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 10:35:37 +0000 (UTC)
Received: by mail-pj1-x102a.google.com with SMTP id
 y14-20020a17090a2b4e00b001a5824f4918so1564588pjc.4
 for <iommu@lists.linux-foundation.org>; Tue, 07 Dec 2021 02:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=JxiMwx4C7x5k8y2Xl9TOjw2NlxLDyAqVmINHy5bpGck=;
 b=vK5p9DHLGcOw0yiyBwJ9laMSSiVhDZQCvmpDM1iH75e2UfhLDYH/mf7e2HrefL/sMv
 fhAra2Bm7cbrxeJgUQNpQ12hDCle+9SXTLYbiM/gw88s5dtwt+0nnivf4XJuwXg6Ninb
 QSHEiaoZSstIGC2u3byuj1+L3cvdSkzGWuh2L6DBWe5yDmt9EbHOF47NYdZG8yq0KxCj
 VPIxhqGjsxNJ2uUnhPpAblUNr8sjLY3nb7KpYeFPQYSSuKMUNWtZUIB+sUlCmkMtyJyQ
 RZ1FrGLgkEUTcsMN1wKyAmyuWlOXBASfTDmzMQLTSA9EpwcFt8NZ221OOL4/vrP9wrdN
 gMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=JxiMwx4C7x5k8y2Xl9TOjw2NlxLDyAqVmINHy5bpGck=;
 b=RGpgbnKQyMfdvQMqCkzGO6Xz9i/EWZn/U8kK8gke+elJzVp309DPLPisbIwNirjPA6
 aOGcvzHwUkSWJd4txVbyBcsktzitKn8NfOun6IcQJ7i1Be+ZEIshYQ0siD7OsJ5GhjPB
 cfc/6CXJStGX5UFXaOwCEd2qEBUgQHBT+uNE7Bz0UZuJTtqkgt/s0ENeguZ4AimmLR0V
 WNGktKk8FtQKsi/644KpiZAI0KT183LNKjcugr1AE00tysOMqmxAgP1N2EMtZEIgUTQz
 bCSTuLF+vKOSl+ZMKt6yP+YjpQAkkWni1hOs3rKkRKRr23OWc2oqEibM9nLHOPo5P4sn
 NlHw==
X-Gm-Message-State: AOAM531lCYNWqtfwWv1zxr2p2SDmyPWCxw4OsZHDFFPyKAxp/pdCmqUv
 KN+eM7s+RiDlfOMvf/MceU9ZFA==
X-Google-Smtp-Source: ABdhPJxVXLdqIw+lDiAPUjGajLKImI1eWzIJDKJ3QTpNQZ82cEF0W15LjnO9lyFohe3k4lFOhliP3g==
X-Received: by 2002:a17:90a:cb98:: with SMTP id
 a24mr5558447pju.153.1638873336553; 
 Tue, 07 Dec 2021 02:35:36 -0800 (PST)
Received: from [10.59.0.6] ([94.177.118.48])
 by smtp.gmail.com with ESMTPSA id y22sm9020940pfa.107.2021.12.07.02.35.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Dec 2021 02:35:36 -0800 (PST)
Subject: Re: [RFC v16 0/9] SMMUv3 Nested Stage Setup (IOMMU part)
To: eric.auger@redhat.com, eric.auger.pro@gmail.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, jean-philippe@linaro.org,
 zhukeqian1@huawei.com
References: <20211027104428.1059740-1-eric.auger@redhat.com>
 <ee119b42-92b1-5744-4321-6356bafb498f@linaro.org>
 <7763531a-625d-10c6-c35e-2ce41e75f606@redhat.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <c1e9dd67-0000-28b5-81c0-239ceda560ed@linaro.org>
Date: Tue, 7 Dec 2021 18:35:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7763531a-625d-10c6-c35e-2ce41e75f606@redhat.com>
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

CgpPbiAyMDIxLzEyLzcg5LiL5Y2INjoyNywgRXJpYyBBdWdlciB3cm90ZToKPiBIaSBaaGFuZ2Zl
aSwKPgo+IE9uIDEyLzMvMjEgMToyNyBQTSwgWmhhbmdmZWkgR2FvIHdyb3RlOgo+PiBIaSwgRXJp
Ywo+Pgo+PiBPbiAyMDIxLzEwLzI3IOS4i+WNiDY6NDQsIEVyaWMgQXVnZXIgd3JvdGU6Cj4+PiBU
aGlzIHNlcmllcyBicmluZ3MgdGhlIElPTU1VIHBhcnQgb2YgSFcgbmVzdGVkIHBhZ2luZyBzdXBw
b3J0Cj4+PiBpbiB0aGUgU01NVXYzLgo+Pj4KPj4+IFRoZSBTTU1VdjMgZHJpdmVyIGlzIGFkYXB0
ZWQgdG8gc3VwcG9ydCAyIG5lc3RlZCBzdGFnZXMuCj4+Pgo+Pj4gVGhlIElPTU1VIEFQSSBpcyBl
eHRlbmRlZCB0byBjb252ZXkgdGhlIGd1ZXN0IHN0YWdlIDEKPj4+IGNvbmZpZ3VyYXRpb24gYW5k
IHRoZSBob29rIGlzIGltcGxlbWVudGVkIGluIHRoZSBTTU1VdjMgZHJpdmVyLgo+Pj4KPj4+IFRo
aXMgYWxsb3dzIHRoZSBndWVzdCB0byBvd24gdGhlIHN0YWdlIDEgdGFibGVzIGFuZCBjb250ZXh0
Cj4+PiBkZXNjcmlwdG9ycyAoc28tY2FsbGVkIFBBU0lEIHRhYmxlKSB3aGlsZSB0aGUgaG9zdCBv
d25zIHRoZQo+Pj4gc3RhZ2UgMiB0YWJsZXMgYW5kIG1haW4gY29uZmlndXJhdGlvbiBzdHJ1Y3R1
cmVzIChTVEUpLgo+Pj4KPj4+IFRoaXMgd29yayBtYWlubHkgaXMgcHJvdmlkZWQgZm9yIHRlc3Qg
cHVycG9zZSBhcyB0aGUgdXBwZXIKPj4+IGxheWVyIGludGVncmF0aW9uIGlzIHVuZGVyIHJld29y
ayBhbmQgYm91bmQgdG8gYmUgYmFzZWQgb24KPj4+IC9kZXYvaW9tbXUgaW5zdGVhZCBvZiBWRklP
IHR1bm5lbGluZy4gSW4gdGhpcyB2ZXJzaW9uIHdlIGFsc28gZ2V0Cj4+PiByaWQgb2YgdGhlIE1T
SSBCSU5ESU5HIGlvY3RsLCBhc3N1bWluZyB0aGUgZ3Vlc3QgZW5mb3JjZXMKPj4+IGZsYXQgbWFw
cGluZyBvZiBob3N0IElPVkFzIHVzZWQgdG8gYmluZCBwaHlzaWNhbCBNU0kgZG9vcmJlbGxzLgo+
Pj4gSW4gdGhlIGN1cnJlbnQgUUVNVSBpbnRlZ3JhdGlvbiB0aGlzIGlzIGFjaGlldmVkIGJ5IGV4
cG9zaW5nCj4+PiBSTVJzIHRvIHRoZSBndWVzdCwgdXNpbmcgU2hhbWVlcidzIHNlcmllcyBbMV0u
IFRoaXMgYXBwcm9hY2gKPj4+IGlzIFJGQyBhcyB0aGUgSU9SVCBzcGVjIGlzIG5vdCByZWFsbHkg
bWVhbnQgdG8gZG8gdGhhdAo+Pj4gKHNpbmdsZSBtYXBwaW5nIGZsYWcgbGltaXRhdGlvbikuCj4+
Pgo+Pj4gQmVzdCBSZWdhcmRzCj4+Pgo+Pj4gRXJpYwo+Pj4KPj4+IFRoaXMgc2VyaWVzIChIb3N0
KSBjYW4gYmUgZm91bmQgYXQ6Cj4+PiBodHRwczovL2dpdGh1Yi5jb20vZWF1Z2VyL2xpbnV4L3Ry
ZWUvdjUuMTUtcmM3LW5lc3RlZC12MTYKPj4+IFRoaXMgaW5jbHVkZXMgYSByZWJhc2VkIFZGSU8g
aW50ZWdyYXRpb24gKGFsdGhvdWdoIG5vdCBtZWFudAo+Pj4gdG8gYmUgdXBzdHJlYW1lZCkKPj4+
Cj4+PiBHdWVzdCBrZXJuZWwgYnJhbmNoIGNhbiBiZSBmb3VuZCBhdDoKPj4+IGh0dHBzOi8vZ2l0
aHViLmNvbS9lYXVnZXIvbGludXgvdHJlZS9zaGFtZWVyX3JtcnJfdjcKPj4+IGZlYXR1cmluZyBb
MV0KPj4+Cj4+PiBRRU1VIGludGVncmF0aW9uIChzdGlsbCBiYXNlZCBvbiBWRklPIGFuZCBleHBv
c2luZyBSTVJzKQo+Pj4gY2FuIGJlIGZvdW5kIGF0Ogo+Pj4gaHR0cHM6Ly9naXRodWIuY29tL2Vh
dWdlci9xZW11L3RyZWUvdjYuMS4wLXJtci12Mi1uZXN0ZWRfc21tdXYzX3YxMAo+Pj4gKHVzZSBp
b21tdT1uZXN0ZWQtc21tdXYzIEFSTSB2aXJ0IG9wdGlvbikKPj4+Cj4+PiBHdWVzdCBkZXBlbmRl
bmN5Ogo+Pj4gWzFdIFtQQVRDSCB2NyAwLzldIEFDUEkvSU9SVDogU3VwcG9ydCBmb3IgSU9SVCBS
TVIgbm9kZQo+PiBUaGFua3MgYSBsb3QgZm9yIHVwZ3JhZGluZyB0aGVzZSBwYXRjaGVzLgo+Pgo+
PiBJIGhhdmUgYmFzaWNhbGx5IHZlcmlmaWVkIHRoZXNlIHBhdGNoZXMgb24gSGlTaWxpY29uIEt1
bnBlbmc5MjAuCj4+IEFuZCBpbnRlZ3JhdGVkIHRoZW0gdG8gdGhlc2UgYnJhbmNoZXMuCj4+IGh0
dHBzOi8vZ2l0aHViLmNvbS9MaW5hcm8vbGludXgta2VybmVsLXVhZGsvdHJlZS91YWNjZS1kZXZl
bC01LjE2Cj4+IGh0dHBzOi8vZ2l0aHViLmNvbS9MaW5hcm8vcWVtdS90cmVlL3Y2LjEuMC1ybXIt
djItbmVzdGVkX3NtbXV2M192MTAKPj4KPj4gVGhvdWdoIHRoZXkgYXJlIHByb3ZpZGVkIGZvciB0
ZXN0IHB1cnBvc2UsCj4+Cj4+IFRlc3RlZC1ieTogWmhhbmdmZWkgR2FvIDx6aGFuZ2ZlaS5nYW9A
bGluYXJvLm9yZz4KPiBUaGFuayB5b3UgdmVyeSBtdWNoLiBBcyB5b3UgbWVudGlvbmVkLCB1bnRp
bCB3ZSBkbyBub3QgaGF2ZSB0aGUKPiAvZGV2L2lvbW11IGludGVncmF0aW9uIHRoaXMgaXMgbWFp
bnRhaW5lZCBmb3IgdGVzdGluZyBwdXJwb3NlLiBUaGUgU01NVQo+IGNoYW5nZXMgc2hvdWxkbid0
IGJlIG11Y2ggaW1wYWN0ZWQgdGhvdWdoLgo+IFRoZSBhZGRlZCB2YWx1ZSBvZiB0aGlzIHJlc3Bp
biB3YXMgdG8gcHJvcG9zZSBhbiBNU0kgYmluZGluZyBzb2x1dGlvbgo+IGJhc2VkIG9uIFJNUlJz
IHdoaWNoIHNpbXBsaWZ5IHRoaW5ncyBhdCBrZXJuZWwgbGV2ZWwuCgpDdXJyZW50IFJNUlIgc29s
dXRpb24gcmVxdWlyZXMgdWVmaSBlbmFibGVkLAphbmQgUUVNVV9FRkkuZmTCoCBoYXMgdG8gYmUg
cHJvdmlkZWQgdG8gc3RhcnQgcWVtdS4KCkFueSBwbGFuIHRvIHN1cHBvcnQgZHRiIGFzIHdlbGws
IHdoaWNoIHdpbGwgYmUgc2ltcGxlciBzaW5jZSBubyBuZWVkIApRRU1VX0VGSS5mZCBhbnltb3Jl
LgoKVGhhbmtzCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
