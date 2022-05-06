Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A660FC433F5
	for <iommu@archiver.kernel.org>; Fri,  6 May 2022 21:24:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4409B419CE;
	Fri,  6 May 2022 21:24:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lRj_cP9YXife; Fri,  6 May 2022 21:24:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CA61741891;
	Fri,  6 May 2022 21:24:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ABA91C0039;
	Fri,  6 May 2022 21:24:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A14B5C002D
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 21:09:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7ACDE60D79
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 21:09:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E0MrAWThVhDo for <iommu@lists.linux-foundation.org>;
 Fri,  6 May 2022 21:09:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E8F1960B73
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 21:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651871391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UC8PN3IHksXw4YLUl2DR5j2jd0ER+gWoSOxwPmBpqKg=;
 b=FWoRerSRmffaC1A6NDwhnwcJH3uWoiz+ydt/AUD6a2rTBsK0D5T4eE/V7auFlqyLXLa9ES
 2rFe/aB7r/G6UE96JYFNwFlLQiDZEnZayGS2JnTlE0OdBYo1tEtqDXcTPDIhjMIItAt3Iz
 1lfH2gdY4UwpocWTE2xXDT0WfAFsTJE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-283-kcLRUfvNP-OjoQhMZN-N8w-1; Fri, 06 May 2022 17:09:50 -0400
X-MC-Unique: kcLRUfvNP-OjoQhMZN-N8w-1
Received: by mail-qt1-f199.google.com with SMTP id
 x5-20020a05622a000500b002f37cb8b803so7028634qtw.9
 for <iommu@lists.linux-foundation.org>; Fri, 06 May 2022 14:09:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=UC8PN3IHksXw4YLUl2DR5j2jd0ER+gWoSOxwPmBpqKg=;
 b=mLlTU6bgZ1M7pcgg0OnWBQhojvCzweYokBAEfZMj+iVLgsjS7WbtPnRAyoGCTwDp4q
 erHksxf4YO5C5KS+W+TP2EsIayR5e7w179TsEggQhjkgk2PImqLO0ZQeU9NgsyK557IM
 iUdwrnLNyKxC3xpbvgNLCYS+mIkBQLH4Qs/MZuNlHmOptpyOwOa/IUxAKeB5LI4rQbq8
 6VOFhnDVAUqyOMnkj5bbDUzug+9wKQcyo2rlmEI1hSQ5GURQs/4PPyI5c2HSXWdeEi4k
 uHBMhRifoiDardmhWkhlyudp8/njPhvvB2yFX9zim4Z5rIuO5iHY64ovkpkttuSq4cFS
 8bLw==
X-Gm-Message-State: AOAM532/eaXuWfb3Cqaek6BrvpHcrauAAIYz1kLfc3By2rZid3Wev1oP
 zzz1WVFEneb6d/2oxluyAyXZd9+WTa3V1sLzhb2gc2lZETaPk5jJqT2axxih0KTAN2rPSh0HKDL
 84jkQjLteQ+QjFqFm2zjGxWW3yk+exg==
X-Received: by 2002:ac8:57d2:0:b0:2f3:b3b0:ecbe with SMTP id
 w18-20020ac857d2000000b002f3b3b0ecbemr4766061qta.29.1651871389817; 
 Fri, 06 May 2022 14:09:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXZnGn2kgpYuxbTXggVBq/gakbuX/nYQzG8wHJicm20zlfTeeC+kYw7imlv4ImNqRIYEC4Og==
X-Received: by 2002:ac8:57d2:0:b0:2f3:b3b0:ecbe with SMTP id
 w18-20020ac857d2000000b002f3b3b0ecbemr4766041qta.29.1651871389605; 
 Fri, 06 May 2022 14:09:49 -0700 (PDT)
Received: from [192.168.8.138] (static-71-184-137-158.bstnma.ftas.verizon.net.
 [71.184.137.158]) by smtp.gmail.com with ESMTPSA id
 de27-20020a05620a371b00b0069fe1fc72e7sm3030497qkb.90.2022.05.06.14.09.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 May 2022 14:09:49 -0700 (PDT)
Message-ID: <8ec2715e36dbd1fab8a31b4b12660ae83e29303d.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/tegra: Stop using iommu_present()
From: Lyude Paul <lyude@redhat.com>
To: Robin Murphy <robin.murphy@arm.com>, bskeggs@redhat.com, kherbst@redhat.com
Date: Fri, 06 May 2022 17:09:47 -0400
In-Reply-To: <70d40ea441da3663c2824d54102b471e9a621f8a.1649168494.git.robin.murphy@arm.com>
References: <70d40ea441da3663c2824d54102b471e9a621f8a.1649168494.git.robin.murphy@arm.com>
Organization: Red Hat Inc.
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lyude@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Mailman-Approved-At: Fri, 06 May 2022 21:24:51 +0000
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 jonathanh@nvidia.com, iommu@lists.linux-foundation.org,
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

V2hvb3BzISBXYXMgZ29pbmcgdGhyb3VnaCBteSB1bnJlYWQgZW1haWxzIGFuZCBub3RpY2VkIEkg
c29tZWhvdyBtaXNzZWQgdGhpcwpwYXRjaCBsYXN0IG1vbnRoLgoKUmV2aWV3ZWQtYnk6IEx5dWRl
IFBhdWwgPGx5dWRlQHJlZGhhdC5jb20+CgpJIHdpbGwgcHVzaCB0aGlzIHRvIGRybS1taXNjLWZp
eGVzIGluIGEgbGl0dGxlIGJpdCAoYXNzdW1pbmcgSSBkb24ndCBmaW5kIGl0CnRoZXJlIGFscmVh
ZHkpCgpPbiBUdWUsIDIwMjItMDQtMDUgYXQgMTU6MjEgKzAxMDAsIFJvYmluIE11cnBoeSB3cm90
ZToKPiBFdmVuIGlmIHNvbWUgSU9NTVUgaGFzIHJlZ2lzdGVyZWQgaXRzZWxmIG9uIHRoZSBwbGF0
Zm9ybSAiYnVzIiwgdGhhdAo+IGRvZXNuJ3QgbmVjZXNzYXJpbHkgbWVhbiBpdCBwcm92aWRlcyB0
cmFuc2xhdGlvbiBmb3IgdGhlIGRldmljZSB3ZQo+IGNhcmUgYWJvdXQuIFJlcGxhY2UgaW9tbXVf
cHJlc2VudCgpIHdpdGggYSBtb3JlIGFwcHJvcHJpYXRlIGNoZWNrLgo+IAo+IFNpZ25lZC1vZmYt
Ynk6IFJvYmluIE11cnBoeSA8cm9iaW4ubXVycGh5QGFybS5jb20+Cj4gLS0tCj4gwqBkcml2ZXJz
L2dwdS9kcm0vbm91dmVhdS9udmttL2VuZ2luZS9kZXZpY2UvdGVncmEuYyB8IDIgKy0KPiDCoDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vbm91dmVhdS9udmttL2VuZ2luZS9kZXZpY2UvdGVncmEuYwo+
IGIvZHJpdmVycy9ncHUvZHJtL25vdXZlYXUvbnZrbS9lbmdpbmUvZGV2aWNlL3RlZ3JhLmMKPiBp
bmRleCA5OTJjYzI4NWYyZmUuLjJlZDUyOGMwNjVmYSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vbm91dmVhdS9udmttL2VuZ2luZS9kZXZpY2UvdGVncmEuYwo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9ub3V2ZWF1L252a20vZW5naW5lL2RldmljZS90ZWdyYS5jCj4gQEAgLTEyMyw3ICsx
MjMsNyBAQCBudmttX2RldmljZV90ZWdyYV9wcm9iZV9pb21tdShzdHJ1Y3QgbnZrbV9kZXZpY2Vf
dGVncmEKPiAqdGRldikKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqBtdXRleF9pbml0KCZ0ZGV2LT5p
b21tdS5tdXRleCk7Cj4gwqAKPiAtwqDCoMKgwqDCoMKgwqBpZiAoaW9tbXVfcHJlc2VudCgmcGxh
dGZvcm1fYnVzX3R5cGUpKSB7Cj4gK8KgwqDCoMKgwqDCoMKgaWYgKGRldmljZV9pb21tdV9tYXBw
ZWQoZGV2KSkgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdGRldi0+aW9tbXUu
ZG9tYWluID0gaW9tbXVfZG9tYWluX2FsbG9jKCZwbGF0Zm9ybV9idXNfdHlwZSk7Cj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoIXRkZXYtPmlvbW11LmRvbWFpbikKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIGVycm9yOwoK
LS0gCkNoZWVycywKIEx5dWRlIFBhdWwgKHNoZS9oZXIpCiBTb2Z0d2FyZSBFbmdpbmVlciBhdCBS
ZWQgSGF0CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpp
b21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
