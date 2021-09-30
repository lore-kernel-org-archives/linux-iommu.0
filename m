Return-Path: <SRS0=YF8t=OU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD051C433EF
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 09:48:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E30B61875
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 09:48:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5E30B61875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1C965840A8;
	Thu, 30 Sep 2021 09:48:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id baKh7NuX03jK; Thu, 30 Sep 2021 09:48:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D097F8406C;
	Thu, 30 Sep 2021 09:48:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95308C000F;
	Thu, 30 Sep 2021 09:48:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DBA76C000D
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 09:48:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BC06640154
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 09:48:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x0lC7MM_uONc for <iommu@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 09:48:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 10A6F400DD
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 09:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632995285;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AkERdnxjQvWX8y2vZWvMiljBX7L/3S/wCVIkI75JXx8=;
 b=eRA6rNDbfXQ+CHQ4prJEGkj3iHFbsP44iYL+I2aLayIdDWaLxQ7lav6x5n+rSoYOw+PnOH
 pZRSVB60HmUk+kTvvvD510ug4S+547lEdgc9qMZhRq3Y93jnNkdamItdfo6FeKSldbqS3c
 j752mrlFkM7YdROCFpV956uxh3dhMWA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-hYkGxI6vMy257GJq23dlUA-1; Thu, 30 Sep 2021 05:48:02 -0400
X-MC-Unique: hYkGxI6vMy257GJq23dlUA-1
Received: by mail-wm1-f71.google.com with SMTP id
 75-20020a1c004e000000b00307b9b32cc9so883022wma.1
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 02:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=AkERdnxjQvWX8y2vZWvMiljBX7L/3S/wCVIkI75JXx8=;
 b=a2cA2iDZrpFRl+zAtR6pzxon5w7lJq63R78hJ+nMEQEDiEs3zZxqZNA1RUD4EZ4XHf
 tmm6Ii8pW5jcyp29VzsKessN22rA9acg2M4mGE0L7lzx4DKnr4pJ8QtSSSqwNM7ZR1k4
 pkWv3yXcRaSQB4lsMSi2xn7S4bQLIHRBKtyL4eEYRuGfBk808HWXW1qNtViS0Xi97le9
 iK8wm3beeIFuFGizbuh1ALodP94PCLv350PBVrI7yMc92HAmUttv56LwXH98abO3Saoa
 W2ddsw4yxv124lMd7UFl8ErVSkKfVu1WjilolGlq9FNSUmgHIPpMyQfKz+VeUNEJSvQz
 +X5A==
X-Gm-Message-State: AOAM531S+KpGLJj7HvKRLpACKX8LVdNJMFLmfFKQ0EOlpiT2qYWfgLNQ
 iy4nOaZMhlOh/shV/dGAQVsf+NQFq8JMiRpxUeDAP98cnIhi7crq36dmWGKFwWwkgXhIstAV6KY
 tC1kVnxfnu3jkLwyZGlE6kHQI82bQvw==
X-Received: by 2002:a5d:4a4e:: with SMTP id v14mr4994005wrs.271.1632995281421; 
 Thu, 30 Sep 2021 02:48:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzaDvcFZ2x9w+vQ0EkZIMR3CDNEjtRYvJj08zAq6M2jLFo3lEyLjpSfSP2fGPPBTZ+aX+mPiw==
X-Received: by 2002:a5d:4a4e:: with SMTP id v14mr4993985wrs.271.1632995281178; 
 Thu, 30 Sep 2021 02:48:01 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id c18sm2430699wmb.27.2021.09.30.02.47.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Sep 2021 02:48:00 -0700 (PDT)
Subject: Re: [PATCH v7 0/9] ACPI/IORT: Support for IORT RMR node
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org,
 Jean-Philippe Brucker <Jean-Philippe.Brucker@arm.com>
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
Message-ID: <b546b40c-d047-87a4-1892-1bb9575ecab7@redhat.com>
Date: Thu, 30 Sep 2021 11:47:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: robin.murphy@arm.com, jon@solid-run.com, linuxarm@huawei.com,
 steven.price@arm.com, guohanjun@huawei.com, yangyicong@huawei.com,
 Sami.Mujawar@arm.com, will@kernel.org, wanghuiqiang@huawei.com
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

SGkgU2hhbWVlciwKCk9uIDgvNS8yMSAxMDowNyBBTSwgU2hhbWVlciBLb2xvdGh1bSB3cm90ZToK
PiBIaSwKPgo+IFRoZSBzZXJpZXMgYWRkcyBzdXBwb3J0IHRvIElPUlQgUk1SIG5vZGVzIHNwZWNp
ZmllZCBpbiBJT1JUCj4gUmV2aXNpb24gRS5iIC1BUk0gREVOIDAwNDlFWzBdLiBSTVIgbm9kZXMg
YXJlIHVzZWQgdG8gZGVzY3JpYmUKPiBtZW1vcnkgcmFuZ2VzIHRoYXQgYXJlIHVzZWQgYnkgZW5k
cG9pbnRzIGFuZCByZXF1aXJlIGEgdW5pdHkKPiBtYXBwaW5nIGluIFNNTVUuCgpJIHVzZWQgeW91
ciBzZXJpZXMgYW5kIFJNUnMgdG8gZm9yY2UgYSBndWVzdCBpb21tdSAodlNNTVV2MyBuZXN0ZWQg
c3RhZ2UKdXNlIGNhc2UpIHRvIGhhdmUgYSBmbGF0IG1hcHBpbmcgZm9yIElPVkFzIHdpdGhpbiBb
MHg4MDAwMDAwLCAweDgxMDAwMDBdCihtYXRjaGluZyBNU0lfSU9WQV9CQVNFIGFuZCBNU0lfSU9W
QV9MRU5HVEgpIHVzZWQgYnkgdGhlIGhvc3QgdG8gbWFwIE1TSQpwaHlzaWNhbCBkb29yYmVsbHMu
CgpUaGF0IHdheSB3aGVuIGFuIGFzc2lnbmVkIGRldmljZSBwcm90ZWN0ZWQgYnkgYSB2U01NVXYz
IGltcGxlbWVudGVkIHVwb24KbmVzdGVkIHN0YWdlIGlzc3VlcyBhbiBNU0kgdHJhbnNhY3Rpb24s
IGxldCdzIHNheSB1c2luZyBJT1ZBPTB4ODAwMDAwMCwKd2Ugd291bGQgZ2V0OgrCoMKgwqAgwqDC
oMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIFMxIChndWVzdCkgwqDCoCDCoMKgwqAgwqDCoCBTMiAo
aG9zdCkKMHg4MDAwMDAwwqDCoMKgIMKgwqDCoCDCoMKgwqAgMHg4MDAwMDAwwqDCoMKgIMKgwqDC
oCDCoMKgwqAgUGh5c2ljYWwgREIKClRoaXMgbWV0aG9kIHdhcyBzdWdnZXN0ZWQgYnkgSmVhbi1Q
aGlsaXBwZSAoYWRkZWQgaW4gQ0MpIGFuZCBpdApzaW1wbGlmaWVzIHRoZSBuZXN0ZWQgc3RhZ2Ug
aW50ZWdyYXRpb24gYmVjYXVzZSB3ZSBkb24ndCBoYXZlIHRvIGNhcmUKYWJvdXQgbmVzdGVkIHN0
YWdlIE1TSSBiaW5kaW5ncy4KCkhvd2V2ZXIgaWYgSSB1bmRlcnN0YW5kIGNvcnJlY3RseSB3ZSBj
YW5ub3QgZGVmaW5lIGEgcmFuZ2Ugb2YgU0lEcyB1c2luZwp0aGUgc2FtZSBSTVIgKGR1ZSB0byB0
aGUgc2luZ2xlIG1hcHBpbmcgYml0IHdoaWNoIG11c3QgYmUgc2V0LCBUYWJsZSA1CmZsYWdzIGZv
cm1hdCkuIFRoaXMgaXMgYSBzcGVjIHJlc3RyaWN0aW9uIGFuZCBub3QgYW4gaXNzdWUgd2l0aCB5
b3VyIHNlcmllcy4KCkFzIFZGSU8gZGV2aWNlcyBjYW4gYmUgaG90LXBsdWdnZWQgd2UgdGh1cyBu
ZWVkIHRvIGNyZWF0ZSBhcyBtYW55IFJNUgpub2RlcyBhcyBwb3RlbnRpYWwgQkRGcywgbGVhZGlu
ZyB0byAyNTYgKiA2ID0gMTUzNiBSTVIgbm9kZXMgaWYgeW91IGhhdmUKNSBwY2llIHJvb3QgcG9y
dHMgYXMgaXQgaXMgdXN1YWwgaW4gVk1zLiBUaGVuIHRoaXMgY2F1c2VzIHNvbWUgdHJvdWJsZQph
dCBxZW11IGxldmVsIGZvciBpbnN0YW5jZSwgd3J0IG1pZ3JhdGlvbi4gU2VlIFtSRkNdCmh3L2Fy
bS92aXJ0LWFjcGktYnVpbGQ6IEFkZCBJT1JUIFJNUiByZWdpb25zIHRvIGhhbmRsZSBNU0kgbmVz
dGVkIGJpbmRpbmcuCgpEbyB5b3Uga25vdyBpZiB0aGVyZSBpcyBhIHBsYW4gdG8gcmVtb3ZlIHRo
ZSBzaW5nbGUgbWFwcGluZyBsaW1pdGF0aW9uCmluIHRoZSBzcGVjPwoKVGhhbmtzCgpFcmljCj4K
PiBXZSBoYXZlIGZhY2VkIGlzc3VlcyB3aXRoIDM0MDhpTVIgUkFJRCBjb250cm9sbGVyIGNhcmRz
IHdoaWNoCj4gZmFpbCB0byBib290IHdoZW4gU01NVSBpcyBlbmFibGVkLiBUaGlzIGlzIGJlY2F1
c2UgdGhlc2UKPiBjb250cm9sbGVycyBtYWtlIHVzZSBvZiBob3N0IG1lbW9yeSBmb3IgdmFyaW91
cyBjYWNoaW5nIHJlbGF0ZWQKPiBwdXJwb3NlcyBhbmQgd2hlbiBTTU1VIGlzIGVuYWJsZWQgdGhl
IGlNUiBmaXJtd2FyZSBmYWlscyB0byAKPiBhY2Nlc3MgdGhlc2UgbWVtb3J5IHJlZ2lvbnMgYXMg
dGhlcmUgaXMgbm8gbWFwcGluZyBmb3IgdGhlbS4KPiBJT1JUIFJNUiBwcm92aWRlcyBhIHdheSBm
b3IgVUVGSSB0byBkZXNjcmliZSBhbmQgcmVwb3J0IHRoZXNlCj4gbWVtb3J5IHJlZ2lvbnMgc28g
dGhhdCB0aGUga2VybmVsIGNhbiBtYWtlIGEgdW5pdHkgbWFwcGluZyBmb3IKPiB0aGVzZSBpbiBT
TU1VLgo+Cj4gQ2hhbmdlIEhpc3Rvcnk6IAo+Cj4gdjYgLS0+IHY3Cj4KPiBUaGUgb25seSBjaGFu
Z2UgZnJvbSB2NiBpcyB0aGUgZml4IHBvaW50ZWQgb3V0IGJ5IFN0ZXZlIHRvCj4gdGhlIFNNTVV2
MiBTTVIgYnlwYXNzIGluc3RhbGwgaW4gcGF0Y2ggIzguCj4KPiBUaGFua3MgdG8gdGhlIFRlc3Rl
ZC1ieSB0YWdzIGJ5IExhdXJlbnRpdSB3aXRoIFNNTVV2MiBhbmQKPiBIYW5qdW4vSHVpcWlhbmcg
d2l0aCBTTU1VdjMgZm9yIHY2LiBJIGhhdmVuJ3QgYWRkZWQgdGhlIHRhZ3MKPiB5ZXQgYXMgdGhl
IHNlcmllcyBzdGlsbCBuZWVkcyBtb3JlIHJldmlld1sxXS4KPgo+IEZlZWRiYWNrIGFuZCB0ZXN0
cyBvbiB0aGlzIHNlcmllcyBpcyB2ZXJ5IG11Y2ggYXBwcmVjaWF0ZWQuCj4KPiB2NSAtLT4gdjYK
PiAtIEFkZHJlc3NlZCBjb21tZW50cyBmcm9tIFJvYmluICYgTG9yZW56by4KPiAgIDogTW92ZWQg
aW9ydF9wYXJzZV9ybXIoKSB0byBhY3BpX2lvcnRfaW5pdCgpIGZyb20KPiAgICAgaW9ydF9pbml0
X3BsYXRmb3JtX2RldmljZXMoKS4KPiAgIDogUmVtb3ZlZCB1c2Ugb2Ygc3RydWN0IGlvcnRfcm1y
X2VudHJ5IGR1cmluZyB0aGUgaW5pdGlhbAo+ICAgICBwYXJzZS4gVXNpbmcgc3RydWN0IGlvbW11
X3Jlc3ZfcmVnaW9uIGluc3RlYWQuCj4gICA6IFJlcG9ydCBSTVIgYWRkcmVzcyBhbGlnbm1lbnQg
YW5kIG92ZXJsYXAgZXJyb3JzLCBidXQgY29udGludWUuCj4gICA6IFJld29ya2VkIGFybV9zbW11
X2luaXRfYnlwYXNzX3N0ZXMoKSAocGF0Y2ggIyA2KS4KPiAtIFVwZGF0ZWQgU01NVXYyIGJ5cGFz
cyBTTVIgY29kZS4gVGhhbmtzIHRvIEpvbiBOIChwYXRjaCAjOCkuCj4gLSBTZXQgSU9NTVUgcHJv
dGVjdGlvbiBmbGFncyhJT01NVV9DQUNIRSwgSU9NTVVfTU1JTykgYmFzZWQKPiAgIG9uIFR5cGUg
b2YgUk1SIHJlZ2lvbi4gU3VnZ2VzdGVkIGJ5IEpvbiBOLgo+Cj4gVGhhbmtzLAo+IFNoYW1lZXIK
PiBbMF0gaHR0cHM6Ly9kZXZlbG9wZXIuYXJtLmNvbS9kb2N1bWVudGF0aW9uL2RlbjAwNDkvbGF0
ZXN0Lwo+IFsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1hY3BpLzIwMjEwNzE2MDgz
NDQyLjE3MDgtMS1zaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20vVC8jbTA0M2M5
NWI4Njk5NzNhODM0YjJmZDU3ZjNlMWVkMDMyNWM4NGYzYjcKPiAtLS0tLS0KPiB2NCAtLT4gdjUK
PiAgLUFkZGVkIGEgZndfZGF0YSB1bmlvbiB0byBzdHJ1Y3QgaW9tbXVfcmVzdl9yZWdpb24gYW5k
IHJlbW92ZWQKPiAgIHN0cnVjdCBpb21tdV9ybXIgKEJhc2VkIG9uIGNvbW1lbnRzIGZyb20gSm9l
cmcvUm9iaW4pLgo+ICAtQWRkZWQgaW9tbXVfcHV0X3JtcnMoKSB0byByZWxlYXNlIG1lbS4KPiAg
LVRoYW5rcyB0byBTdGV2ZSBmb3IgdmVyaWZ5aW5nIG9uIFNNTVV2MiwgYnV0IG5vdCBhZGRlZCB0
aGUgVGVzdGVkLWJ5Cj4gICB5ZXQgYmVjYXVzZSBvZiB0aGUgYWJvdmUgY2hhbmdlcy4KPgo+IHYz
IC0tPnY0Cj4gLUluY2x1ZGVkIHRoZSBTTU1VdjIgU01SIGJ5cGFzcyBpbnN0YWxsIGNoYW5nZXMg
c3VnZ2VzdGVkIGJ5Cj4gIFN0ZXZlKHBhdGNoICM3KQo+IC1BcyBwZXIgUm9iaW4ncyBjb21tZW50
cywgUk1SIHJlc2VydmUgaW1wbGVtZW50YXRpb24gaXMgbm93Cj4gIG1vcmUgZ2VuZXJpYyAgKHBh
dGNoICM4KSBhbmQgZHJvcHBlZCB2MyBwYXRjaGVzIDggYW5kIDEwLgo+IC1SZWJhc2UgdG8gNS4x
My1yYzEKPgo+IFJGQyB2MiAtLT4gdjMKPiAgLURyb3BwZWQgUkZDIHRhZyBhcyB0aGUgQUNQSUNB
IGhlYWRlciBjaGFuZ2VzIGFyZSBub3cgcmVhZHkgdG8gYmUKPiAgIHBhcnQgb2YgNS4xM1swXS4g
QnV0IHRoaXMgc2VyaWVzIHN0aWxsIGhhcyBhIGRlcGVuZGVuY3kgb24gdGhhdCBwYXRjaC4KPiAg
LUFkZGVkIElPUlQgRS5iIHJlbGF0ZWQgY2hhbmdlcyhub2RlIGZsYWdzLCBfRFNNIGZ1bmN0aW9u
IDUgY2hlY2tzIGZvcgo+ICAgUENJZSkuCj4gIC1DaGFuZ2VkIFJNUiB0byBzdHJlYW0gaWQgbWFw
cGluZyBmcm9tIE06TiB0byBNOjEgYXMgcGVyIHRoZSBzcGVjIGFuZAo+ICAgZGlzY3Vzc2lvbiBo
ZXJlWzFdLgo+ICAtTGFzdCB0d28gcGF0Y2hlcyBhZGQgc3VwcG9ydCBmb3IgU01NVXYyKFRoYW5r
cyB0byBKb24gTmV0dGxldG9uISkKPiAtLS0tLS0KPgo+IEpvbiBOZXR0bGV0b24gKDEpOgo+ICAg
aW9tbXUvYXJtLXNtbXU6IEdldCBhc3NvY2lhdGVkIFJNUiBpbmZvIGFuZCBpbnN0YWxsIGJ5cGFz
cyBTTVIKPgo+IFNoYW1lZXIgS29sb3RodW0gKDgpOgo+ICAgaW9tbXU6IEludHJvZHVjZSBhIHVu
aW9uIHRvIHN0cnVjdCBpb21tdV9yZXN2X3JlZ2lvbgo+ICAgQUNQSS9JT1JUOiBBZGQgc3VwcG9y
dCBmb3IgUk1SIG5vZGUgcGFyc2luZwo+ICAgaW9tbXUvZG1hOiBJbnRyb2R1Y2UgZ2VuZXJpYyBo
ZWxwZXIgdG8gcmV0cmlldmUgUk1SIGluZm8KPiAgIEFDUEkvSU9SVDogQWRkIGEgaGVscGVyIHRv
IHJldHJpZXZlIFJNUiBtZW1vcnkgcmVnaW9ucwo+ICAgaW9tbXUvYXJtLXNtbXUtdjM6IEludHJv
ZHVjZSBzdHJ0YWIgaW5pdCBoZWxwZXIKPiAgIGlvbW11L2FybS1zbW11LXYzOiBSZWZhY3RvcsKg
YXJtX3NtbXVfaW5pdF9ieXBhc3Nfc3RlcygpIHRvIGZvcmNlCj4gICAgIGJ5cGFzcwo+ICAgaW9t
bXUvYXJtLXNtbXUtdjM6IEdldCBhc3NvY2lhdGVkIFJNUiBpbmZvIGFuZCBpbnN0YWxsIGJ5cGFz
cyBTVEUKPiAgIGlvbW11L2RtYTogUmVzZXJ2ZSBhbnkgUk1SIHJlZ2lvbnMgYXNzb2NpYXRlZCB3
aXRoIGEgZGV2Cj4KPiAgZHJpdmVycy9hY3BpL2FybTY0L2lvcnQuYyAgICAgICAgICAgICAgICAg
ICB8IDE3MiArKysrKysrKysrKysrKysrKysrLQo+ICBkcml2ZXJzL2lvbW11L2FybS9hcm0tc21t
dS12My9hcm0tc21tdS12My5jIHwgIDc2ICsrKysrKystLQo+ICBkcml2ZXJzL2lvbW11L2FybS9h
cm0tc21tdS9hcm0tc21tdS5jICAgICAgIHwgIDQ4ICsrKysrKwo+ICBkcml2ZXJzL2lvbW11L2Rt
YS1pb21tdS5jICAgICAgICAgICAgICAgICAgIHwgIDg5ICsrKysrKysrKy0KPiAgaW5jbHVkZS9s
aW51eC9hY3BpX2lvcnQuaCAgICAgICAgICAgICAgICAgICB8ICAgNyArCj4gIGluY2x1ZGUvbGlu
dXgvZG1hLWlvbW11LmggICAgICAgICAgICAgICAgICAgfCAgMTMgKysKPiAgaW5jbHVkZS9saW51
eC9pb21tdS5oICAgICAgICAgICAgICAgICAgICAgICB8ICAxMSArKwo+ICA3IGZpbGVzIGNoYW5n
ZWQsIDM5MyBpbnNlcnRpb25zKCspLCAyMyBkZWxldGlvbnMoLSkKPgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
