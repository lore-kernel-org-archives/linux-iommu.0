Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B2AC433EF
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 07:33:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5F23E409FB;
	Wed,  8 Dec 2021 07:33:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1kDjAnPCkkTB; Wed,  8 Dec 2021 07:33:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CF950409F2;
	Wed,  8 Dec 2021 07:33:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E880C002F;
	Wed,  8 Dec 2021 07:33:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71666C0012
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 07:33:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 48F66409FB
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 07:33:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Qv9U27mCJntB for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 07:33:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6F025409F2
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 07:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638948821;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VaQgBFKDWPtyW4rX+GpfnPjaazD4SfZz/ToOHd0Wuzc=;
 b=gcRXlv6l0vxLKUIniuzzSOPmVUXPUji0uvDnpC2LmQZvB0YxEISb3HxUqHQVkvP2xHKswv
 hXS/zgRwpKONE89uy+bdwUR+QOQ8cfpsF3IP7JWn5j5SQd2mjUKmLH+QOnKv2ZFd/41ZNr
 ouT0NnHEtV+y5itfWMuPcD6D9R+jc2o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-Zdt0ml0OMX25uAQOcjwVUw-1; Wed, 08 Dec 2021 02:33:37 -0500
X-MC-Unique: Zdt0ml0OMX25uAQOcjwVUw-1
Received: by mail-wr1-f69.google.com with SMTP id
 c4-20020adfed84000000b00185ca4eba36so157914wro.21
 for <iommu@lists.linux-foundation.org>; Tue, 07 Dec 2021 23:33:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=VaQgBFKDWPtyW4rX+GpfnPjaazD4SfZz/ToOHd0Wuzc=;
 b=B+8vR5vwMXRlksjbz45NdKQuFH76FDpVVKlvAswb/v8g6th+e1cvYBpfHDjDftsNLh
 dZl48w33qc94RDMgqxoWkzC/1lDkAQ+nUCGBi6no8Wln+mwvlUm/muVHvnV4eO5YMPfG
 mqzm72pYaDf7oOQlHS1haOpKwWYUBHcfqwj+3dn6RnA/TiM/IXfwx58gnP5pxQ9QV+0j
 C6xNdUfVRKFKEpVuMBkhlVdtdm21FvuW4SNhSf14IJ4Gjo2W57f2WnWmBdx/1y2PGOFT
 4e12JgaETtSqIjcH/iMtyhf3+mqr9sJgxY3vh1X3M9pOsNZIpSdXcq36lZ2lfu+8un5Q
 70IQ==
X-Gm-Message-State: AOAM531a3JFCT1AlDhXuRQo/7GKZpx6eJ6Bq4GAtd6rKAZU2tL0DdGzu
 qgGJZ5sFftHmkNkUqI9aR87QD5zXOOdPILOX9NqTVfav0iFIH2DKfZOocxYE8SyPbIxn+xrRt5b
 SaXhcKG6c2X9FWvPqIYSK2kN6OtNyXw==
X-Received: by 2002:adf:f708:: with SMTP id r8mr57333465wrp.198.1638948816619; 
 Tue, 07 Dec 2021 23:33:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy7KoV5p8PVF3If5VE3e/tXMfPoPdiN58LX+mhb+Qk/apSQFS8E5N4maEwm2dxUTEGR+YL9hQ==
X-Received: by 2002:adf:f708:: with SMTP id r8mr57333432wrp.198.1638948816394; 
 Tue, 07 Dec 2021 23:33:36 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id l3sm2033529wmq.46.2021.12.07.23.33.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Dec 2021 23:33:35 -0800 (PST)
Subject: Re: [RFC v16 1/9] iommu: Introduce attach/detach_pasid_table API
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
References: <20211027104428.1059740-1-eric.auger@redhat.com>
 <20211027104428.1059740-2-eric.auger@redhat.com>
 <Ya3qd6mT/DpceSm8@8bytes.org>
 <c7e26722-f78c-a93f-c425-63413aa33dde@redhat.com>
 <e6733c59-ffcb-74d4-af26-273c1ae8ce68@linux.intel.com>
From: Eric Auger <eric.auger@redhat.com>
Message-ID: <fbeabcff-a6d4-dcc5-6687-7b32d6358fe3@redhat.com>
Date: Wed, 8 Dec 2021 08:33:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <e6733c59-ffcb-74d4-af26-273c1ae8ce68@linux.intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, lushenming@huawei.com,
 ashok.raj@intel.com, kvm@vger.kernel.org, jean-philippe@linaro.org,
 maz@kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 vsethi@nvidia.com, vivek.gautam@arm.com, alex.williamson@redhat.com,
 Jason Gunthorpe <jgg@nvidia.com>, wangxingang5@huawei.com,
 zhangfei.gao@linaro.org, robin.murphy@arm.com, will@kernel.org,
 kvmarm@lists.cs.columbia.edu, eric.auger.pro@gmail.com
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

SGkgQmFvbHUsCgpPbiAxMi84LzIxIDM6NDQgQU0sIEx1IEJhb2x1IHdyb3RlOgo+IEhpIEVyaWMs
Cj4KPiBPbiAxMi83LzIxIDY6MjIgUE0sIEVyaWMgQXVnZXIgd3JvdGU6Cj4+IE9uIDEyLzYvMjEg
MTE6NDggQU0sIEpvZXJnIFJvZWRlbCB3cm90ZToKPj4+IE9uIFdlZCwgT2N0IDI3LCAyMDIxIGF0
IDEyOjQ0OjIwUE0gKzAyMDAsIEVyaWMgQXVnZXIgd3JvdGU6Cj4+Pj4gU2lnbmVkLW9mZi1ieTog
SmVhbi1QaGlsaXBwZSBCcnVja2VyPGplYW4tcGhpbGlwcGUuYnJ1Y2tlckBhcm0uY29tPgo+Pj4+
IFNpZ25lZC1vZmYtYnk6IExpdSwgWWkgTDx5aS5sLmxpdUBsaW51eC5pbnRlbC5jb20+Cj4+Pj4g
U2lnbmVkLW9mZi1ieTogQXNob2sgUmFqPGFzaG9rLnJhakBpbnRlbC5jb20+Cj4+Pj4gU2lnbmVk
LW9mZi1ieTogSmFjb2IgUGFuPGphY29iLmp1bi5wYW5AbGludXguaW50ZWwuY29tPgo+Pj4+IFNp
Z25lZC1vZmYtYnk6IEVyaWMgQXVnZXI8ZXJpYy5hdWdlckByZWRoYXQuY29tPgo+Pj4gVGhpcyBT
aWduZWQtb2YtYnkgY2hhaW4gbG9va3MgZHViaW91cywgeW91IGFyZSB0aGUgYXV0aG9yIGJ1dCB0
aGUgbGFzdAo+Pj4gb25lIGluIHRoZSBjaGFpbj8KPj4gVGhlIDFzdCBSRkMgaW4gQXVnIDIwMTgK
Pj4gKGh0dHBzOi8vbGlzdHMuY3MuY29sdW1iaWEuZWR1L3BpcGVybWFpbC9rdm1hcm0vMjAxOC1B
dWd1c3QvMDMyNDc4Lmh0bWwpCj4+IHNhaWQgdGhpcyB3YXMgYSBnZW5lcmFsaXphdGlvbiBvZiBK
YWNvYidzIHBhdGNoCj4+Cj4+Cj4+IMKgwqAgW1BBVENIIHY1IDAxLzIzXSBpb21tdTogaW50cm9k
dWNlIGJpbmRfcGFzaWRfdGFibGUgQVBJIGZ1bmN0aW9uCj4+Cj4+Cj4+IMKgwqAKPj4gaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL3BpcGVybWFpbC9pb21tdS8yMDE4LU1heS8wMjc2
NDcuaHRtbAo+Pgo+PiBTbyBpbmRlZWQgSmFjb2Igc2hvdWxkIGJlIHRoZSBhdXRob3IuIEkgZ3Vl
c3MgdGhlIG11bHRpcGxlIHJlYmFzZXMgZ290Cj4+IHRoaXMgZXZlbnR1YWxseSByZXBsYWNlZCBh
dCBzb21lIHBvaW50LCB3aGljaCBpcyBub3QgYW4gZXhjdXNlLiBQbGVhc2UKPj4gZm9yZ2l2ZSBt
ZSBmb3IgdGhhdC4KPj4gTm93IHRoZSBvcmlnaW5hbCBwYXRjaCBhbHJlYWR5IGhhZCB0aGlzIGxp
c3Qgb2YgU29CIHNvIEkgZG9uJ3Qga25vdyBpZiBJCj4+IHNoYWxsIHNpbXBsaWZ5IGl0Lgo+Cj4g
QXMgd2UgaGF2ZSBkZWNpZGVkIHRvIG1vdmUgdGhlIG5lc3RlZCBtb2RlIChkdWFsIHN0YWdlcykg
aW1wbGVtZW50YXRpb24KPiBvbnRvIHRoZSBkZXZlbG9waW5nIGlvbW11ZmQgZnJhbWV3b3JrLCB3
aGF0J3MgdGhlIHZhbHVlIG9mIGFkZGluZyB0aGlzCj4gaW50byBpb21tdSBjb3JlPwoKVGhlIGlv
bW11X3VhcGlfYXR0YWNoX3Bhc2lkX3RhYmxlIHVhcGkgc2hvdWxkIGRpc2FwcGVhciBpbmRlZWQg
YXMgaXQgaXMKaXMgYm91bmQgdG8gYmUgcmVwbGFjZWQgYnkgL2Rldi9pb21tdSBmZWxsb3cgQVBJ
LgpIb3dldmVyIHVudGlsIEkgY2FuIHJlYmFzZSBvbiAvZGV2L2lvbW11IGNvZGUgSSBhbSBvYmxp
Z2VkIHRvIGtlZXAgaXQgdG8KbWFpbnRhaW4gdGhpcyBpbnRlZ3JhdGlvbiwgaGVuY2UgdGhlIFJG
Qy4KClRoYW5rcwoKRXJpYwo+Cj4gQmVzdCByZWdhcmRzLAo+IGJhb2x1Cj4KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdApp
b21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
