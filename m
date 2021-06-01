Return-Path: <SRS0=UGJ5=K3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377B1C47080
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 06:07:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9EAA61263
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 06:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9EAA61263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 79CB54035B;
	Tue,  1 Jun 2021 06:07:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pB4Xa8RgIGDL; Tue,  1 Jun 2021 06:07:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2B179401E6;
	Tue,  1 Jun 2021 06:07:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F34C1C000E;
	Tue,  1 Jun 2021 06:07:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6188CC0001
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 06:07:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4082F6060F
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 06:07:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EKF0ghEESB3x for <iommu@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 06:07:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1FA3860602
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 06:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622527637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WBtT6QfhiDgonj2vvLPkT9r7vtcFNwuVXyhZCxDQcFk=;
 b=g3QgaCw5HTnjmQFssW/gZqX/BdxT0PiPrInkzqb5sDFCrlZW/UeDGH6QYMkAJzZSfUbhHC
 56mj8tPmO1GnMd1xQ9AIwflyXoIKdg18G7XVDGza8kx41G5M1pjk7cDnA+OMq+o+ccdix9
 np7eeJfiaqV8rO/jl/rZd7wDFV8JtuI=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-LHUEIDYrNhm5zZOz31r0iQ-1; Tue, 01 Jun 2021 02:07:16 -0400
X-MC-Unique: LHUEIDYrNhm5zZOz31r0iQ-1
Received: by mail-pg1-f199.google.com with SMTP id
 135-20020a63038d0000b0290220201658a7so2351751pgd.21
 for <iommu@lists.linux-foundation.org>; Mon, 31 May 2021 23:07:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=WBtT6QfhiDgonj2vvLPkT9r7vtcFNwuVXyhZCxDQcFk=;
 b=tscxQvs/A/dyXzLeLYBU+Nj1g0dVKAYzB08lEkdL98sFb181PJFVqbv0oFLYEARIXx
 NXJgPh3g76+fhTc6UnBJg8dvx5TL7k7htbnrNvveKfFDSM8ecnxxDfnhHeOLt+Z6uunz
 /990ul9UHa7Sr4b3PlYCfea0e/MQDbHQ/ikkdzRfLGHAaKcLu6jF0opFKnU8Wj+G+65l
 bZVaSbYUUgCrXKrdlrLEnMDWSxhzgA+eMTycfVHlwSOGOhC4D49VjFnl+RmB3f9MHxu1
 5aQlS8nDcVmA5IDisveU3D4oVkiKveT2e9KS5oXmyBi6Tpu8R8+MQFxbJplLAXTZuUAS
 wxPQ==
X-Gm-Message-State: AOAM530Ox+wO5DVMS5eBRoC9HkbKQ60gc4F/t7Q5rTzyM+ImY7dSK8ur
 4XyBHcJS3XOuhd3OjGmpV63Cw1tmSqwxjlUjI2lzSD0/4r0+wgj5yyBRPoiw4u8YmqadY4uGzCx
 FOGWXOY5yXMv0lX0EwPDsrjgU3/lZhw==
X-Received: by 2002:a62:1856:0:b029:2e9:c6ef:3b34 with SMTP id
 83-20020a6218560000b02902e9c6ef3b34mr10235745pfy.65.1622527635282; 
 Mon, 31 May 2021 23:07:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy061Dy19iHLayhC8IX/sic1Xj79JCDr5oreU6IxvFEXjUpr+lVQ790JMBSTMUZPvKcvJ5VZQ==
X-Received: by 2002:a62:1856:0:b029:2e9:c6ef:3b34 with SMTP id
 83-20020a6218560000b02902e9c6ef3b34mr10235727pfy.65.1622527635026; 
 Mon, 31 May 2021 23:07:15 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 25sm12058529pfh.39.2021.05.31.23.07.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 May 2021 23:07:14 -0700 (PDT)
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To: "Tian, Kevin" <kevin.tian@intel.com>, Lu Baolu
 <baolu.lu@linux.intel.com>, Liu Yi L <yi.l.liu@linux.intel.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <f510f916-e91c-236d-e938-513a5992d3b5@redhat.com>
 <20210531164118.265789ee@yiliu-dev>
 <78ee2638-1a03-fcc8-50a5-81040f677e69@redhat.com>
 <20210601113152.6d09e47b@yiliu-dev>
 <164ee532-17b0-e180-81d3-12d49b82ac9f@redhat.com>
 <64898584-a482-e6ac-fd71-23549368c508@linux.intel.com>
 <429d9c2f-3597-eb29-7764-fad3ec9a934f@redhat.com>
 <MWHPR11MB1886FC7A46837588254794048C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <05d7f790-870d-5551-1ced-86926a0aa1a6@redhat.com>
Date: Tue, 1 Jun 2021 14:07:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB1886FC7A46837588254794048C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "Alex Williamson \(alex.williamson@redhat.com\)\"\""
 <alex.williamson@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 David Woodhouse <dwmw2@infradead.org>
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

CuWcqCAyMDIxLzYvMSDkuIvljYgxOjQyLCBUaWFuLCBLZXZpbiDlhpnpgZM6Cj4+IEZyb206IEph
c29uIFdhbmcKPj4gU2VudDogVHVlc2RheSwgSnVuZSAxLCAyMDIxIDE6MzAgUE0KPj4KPj4g5Zyo
IDIwMjEvNi8xIOS4i+WNiDE6MjMsIEx1IEJhb2x1IOWGmemBkzoKPj4+IEhpIEphc29uIFcsCj4+
Pgo+Pj4gT24gNi8xLzIxIDE6MDggUE0sIEphc29uIFdhbmcgd3JvdGU6Cj4+Pj4+PiAyKSBJZiB5
ZXMsIHdoYXQncyB0aGUgcmVhc29uIGZvciBub3Qgc2ltcGx5IHVzZSB0aGUgZmQgb3BlbmVkIGZy
b20KPj4+Pj4+IC9kZXYvaW9hcy4gKFRoaXMgaXMgdGhlIHF1ZXN0aW9uIHRoYXQgaXMgbm90IGFu
c3dlcmVkKSBhbmQgd2hhdAo+Pj4+Pj4gaGFwcGVucwo+Pj4+Pj4gaWYgd2UgY2FsbCBHRVRfSU5G
TyBmb3IgdGhlIGlvYXNpZF9mZD8KPj4+Pj4+IDMpIElmIG5vdCwgaG93IEdFVF9JTkZPIHdvcms/
Cj4+Pj4+IG9oLCBtaXNzZWQgdGhpcyBxdWVzdGlvbiBpbiBwcmlvciByZXBseS4gUGVyc29uYWxs
eSwgbm8gc3BlY2lhbCByZWFzb24KPj4+Pj4geWV0LiBCdXQgdXNpbmcgSUQgbWF5IGdpdmUgdXMg
b3Bwb3J0dW5pdHkgdG8gY3VzdG9taXplIHRoZSBtYW5hZ2VtZW50Cj4+Pj4+IG9mIHRoZSBoYW5k
bGUuIEZvciBvbmUsIGJldHRlciBsb29rdXAgZWZmaWNpZW5jeSBieSB1c2luZyB4YXJyYXkgdG8K
Pj4+Pj4gc3RvcmUgdGhlIGFsbG9jYXRlZCBJRHMuIEZvciB0d28sIGNvdWxkIGNhdGVnb3JpemUg
dGhlIGFsbG9jYXRlZCBJRHMKPj4+Pj4gKHBhcmVudCBvciBuZXN0ZWQpLiBHRVRfSU5GTyBqdXN0
IHdvcmtzIHdpdGggYW4gaW5wdXQgRkQgYW5kIGFuIElELgo+Pj4+Cj4+Pj4gSSdtIG5vdCBzdXJl
IEkgZ2V0IHRoaXMsIGZvciBuZXN0aW5nIGNhc2VzIHlvdSBjYW4gc3RpbGwgbWFrZSB0aGUKPj4+
PiBjaGlsZCBhbiBmZC4KPj4+Pgo+Pj4+IEFuZCBhIHF1ZXN0aW9uIHN0aWxsLCB1bmRlciB3aGF0
IGNhc2Ugd2UgbmVlZCB0byBjcmVhdGUgbXVsdGlwbGUKPj4+PiBpb2FzaWRzIG9uIGEgc2luZ2xl
IGlvYXNpZCBmZD8KPj4+IE9uZSBwb3NzaWJsZSBzaXR1YXRpb24gd2hlcmUgbXVsdGlwbGUgSU9B
U0lEcyBwZXIgRkQgY291bGQgYmUgdXNlZCBpcwo+Pj4gdGhhdCBkZXZpY2VzIHdpdGggZGlmZmVy
ZW50IHVuZGVybHlpbmcgSU9NTVUgY2FwYWJpbGl0aWVzIGFyZSBzaGFyaW5nIGEKPj4+IHNpbmds
ZSBGRC4gSW4gdGhpcyBjYXNlLCBvbmx5IGRldmljZXMgd2l0aCBjb25zaXN0ZW50IHVuZGVybHlp
bmcgSU9NTVUKPj4+IGNhcGFiaWxpdGllcyBjb3VsZCBiZSBwdXQgaW4gYW4gSU9BU0lEIGFuZCBt
dWx0aXBsZSBJT0FTSURzIHBlciBGRCBjb3VsZAo+Pj4gYmUgYXBwbGllZC4KPj4+Cj4+PiBUaG91
Z2gsIEkgc3RpbGwgbm90IHN1cmUgYWJvdXQgIm11bHRpcGxlIElPQVNJRCBwZXItRkQiIHZzICJt
dWx0aXBsZQo+Pj4gSU9BU0lEIEZEcyIgZm9yIHN1Y2ggY2FzZS4KPj4KPj4gUmlnaHQsIHRoYXQn
cyBleGFjdGx5IG15IHF1ZXN0aW9uLiBUaGUgbGF0dGVyIHNlZW1zIG11Y2ggbW9yZSBlYXNpZXIg
dG8KPj4gYmUgdW5kZXJzdG9vZCBhbmQgaW1wbGVtZW50ZWQuCj4+Cj4gQSBzaW1wbGUgcmVhc29u
IGRpc2N1c3NlZCBpbiBwcmV2aW91cyB0aHJlYWQgLSB0aGVyZSBjb3VsZCBiZSAxTSdzCj4gSS9P
IGFkZHJlc3Mgc3BhY2VzIHBlciBkZXZpY2Ugd2hpbGUgI0ZEJ3MgYXJlIHByZWNpb3VzIHJlc291
cmNlLgoKCklzIHRoZSBjb25jZXJuIGZvciB1bGltaXQgb3IgcGVyZm9ybWFuY2U/IE5vdGUgdGhh
dCB3ZSBoYWQKCiNkZWZpbmUgTlJfT1BFTl9NQVggfjBVCgpBbmQgd2l0aCB0aGUgZmQgc2VtYW50
aWMsIHlvdSBjYW4gZG8gYSBsb3Qgb2Ygb3RoZXIgc3R1ZmZzOiBjbG9zZSBvbiAKZXhlYywgcGFz
c2luZyB2aWEgU0NNX1JJR0hUUy4KCkZvciB0aGUgY2FzZSBvZiAxTSwgSSB3b3VsZCBsaWtlIHRv
IGtub3cgd2hhdCdzIHRoZSB1c2UgY2FzZSBmb3IgYSAKc2luZ2xlIHByb2Nlc3MgdG8gaGFuZGxl
IDFNKyBhZGRyZXNzIHNwYWNlcz8KCgo+IFNvIHRoaXMgUkZDIHRyZWF0cyBmZCBhcyBhIGNvbnRh
aW5lciBvZiBhZGRyZXNzIHNwYWNlcyB3aGljaCBpcyBlYWNoCj4gdGFnZ2VkIGJ5IGFuIElPQVNJ
RC4KCgpJZiB0aGUgY29udGFpbmVyIGFuZCBhZGRyZXNzIHNwYWNlIGlzIDE6MSB0aGVuIHRoZSBj
b250YWluZXIgc2VlbXMgdXNlbGVzcy4KClRoYW5rcwoKCj4KPiBUaGFua3MKPiBLZXZpbgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGlu
ZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
