Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C10EC433F5
	for <iommu@archiver.kernel.org>; Tue,  7 Dec 2021 10:28:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 018B040533;
	Tue,  7 Dec 2021 10:28:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5gdJAjtwll-g; Tue,  7 Dec 2021 10:28:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6AE2540104;
	Tue,  7 Dec 2021 10:28:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 168C4C002F;
	Tue,  7 Dec 2021 10:28:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2BBC5C0012
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 10:28:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2493840533
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 10:28:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UMSwsTq0paaV for <iommu@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 10:28:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D992740104
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 10:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638872917;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d58w/O9tmt4TQ0yEa0JhGzxmg+sZ/WD5ifzH3Bv9Ixg=;
 b=IOM5Is90cwql3d86jczDjOD67f0Jcw/ucdZw/Nx56hqdnC6YeU87Y3WBulVOhZPyyDAqiL
 7S4JuJiCA38UWpNQDTJ7BEg0WMZEkBmCPAWxx3zyAcvUgNeuvB8p8qJpJCArAJPpvdeWII
 T4EXGG20VXYnOKZMkzd+VpbTxFFewPU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-69-l9fuiU2iPgiilYrIEYiT-A-1; Tue, 07 Dec 2021 05:28:36 -0500
X-MC-Unique: l9fuiU2iPgiilYrIEYiT-A-1
Received: by mail-wr1-f72.google.com with SMTP id
 v17-20020adfedd1000000b0017c5e737b02so2765188wro.18
 for <iommu@lists.linux-foundation.org>; Tue, 07 Dec 2021 02:28:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=d58w/O9tmt4TQ0yEa0JhGzxmg+sZ/WD5ifzH3Bv9Ixg=;
 b=7+5bhR81bXUWqvzx/u6mlA3Q+NH9yMW8S3PS0gx1mzwTMhBaALyXxyBwekDz94WoM8
 UDDqctJa9lzP7zooZH4isC6YSIHpxnnXAXk2M+L574VcALG36cRtQz0vjxwK23Sl4FOY
 bHA0GxT9SZ9CcVn899ChazmeaT+AP/V04fHb65dpXhzK4rAggI8VYJhEhqDAK7GqsiRE
 y91sXUrJdT8IbKKMCi8W1WXTzwpPu77EuUlmBgZaxL2uxHdQOpthctXV0cZyc5xTxH+W
 sHYRWODEwL4b8Z4bvxj9A8XLfHUGH+Mc1aQVsJ7hBEnFyMMXlhwYigG3rgi9tYx/5yUC
 zC2Q==
X-Gm-Message-State: AOAM532OAYtWOvtSy1Nnqe5skNex9rAV1/tFlW3d3hjQVHnw3njPkfBV
 6Wb8BOZKtqTSxnuZERri4fqQxZyoTxq+sb4RMeKanBZn6IE2W5FCBh1GuNDldDKy5SllKa4mC2/
 AalOiABnXuDEpRyJeXIJl3w72s5b5zQ==
X-Received: by 2002:adf:d1cb:: with SMTP id b11mr50103331wrd.33.1638872915665; 
 Tue, 07 Dec 2021 02:28:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw9yqgtAotyRXCF75l+LBkff1xoYlfGD7TQ/mCawQyzCBi7p3cdMYW9aV0zdVcyfpRAAKmK1g==
X-Received: by 2002:adf:d1cb:: with SMTP id b11mr50103308wrd.33.1638872915426; 
 Tue, 07 Dec 2021 02:28:35 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id e24sm14675252wra.78.2021.12.07.02.28.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Dec 2021 02:28:34 -0800 (PST)
Subject: Re: [RFC v16 0/9] SMMUv3 Nested Stage Setup (IOMMU part)
To: Sumit Gupta <sumitg@nvidia.com>, eric.auger.pro@gmail.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, jean-philippe@linaro.org,
 zhukeqian1@huawei.com
References: <20211027104428.1059740-1-eric.auger@redhat.com>
 <4921cd06-065d-951d-d396-ee9843882c40@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
Message-ID: <780faf42-e035-4bfd-252d-8d009355bd6c@redhat.com>
Date: Tue, 7 Dec 2021 11:28:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <4921cd06-065d-951d-d396-ee9843882c40@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: peter.maydell@linaro.org, vivek.gautam@arm.com, alex.williamson@redhat.com,
 ashok.raj@intel.com, maz@kernel.org, vsethi@nvidia.com,
 zhangfei.gao@linaro.org, kevin.tian@intel.com,
 Pritesh Raithatha <praithatha@nvidia.com>, Sachin Nikam <Snikam@nvidia.com>,
 wangxingang5@huawei.com, lushenming@huawei.com
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

SGkgU3VtaXQsCgpPbiAxMi8zLzIxIDI6MTMgUE0sIFN1bWl0IEd1cHRhIHdyb3RlOgo+IEhpIEVy
aWMsCj4KPj4gVGhpcyBzZXJpZXMgYnJpbmdzIHRoZSBJT01NVSBwYXJ0IG9mIEhXIG5lc3RlZCBw
YWdpbmcgc3VwcG9ydAo+PiBpbiB0aGUgU01NVXYzLgo+Pgo+PiBUaGUgU01NVXYzIGRyaXZlciBp
cyBhZGFwdGVkIHRvIHN1cHBvcnQgMiBuZXN0ZWQgc3RhZ2VzLgo+Pgo+PiBUaGUgSU9NTVUgQVBJ
IGlzIGV4dGVuZGVkIHRvIGNvbnZleSB0aGUgZ3Vlc3Qgc3RhZ2UgMQo+PiBjb25maWd1cmF0aW9u
IGFuZCB0aGUgaG9vayBpcyBpbXBsZW1lbnRlZCBpbiB0aGUgU01NVXYzIGRyaXZlci4KPj4KPj4g
VGhpcyBhbGxvd3MgdGhlIGd1ZXN0IHRvIG93biB0aGUgc3RhZ2UgMSB0YWJsZXMgYW5kIGNvbnRl
eHQKPj4gZGVzY3JpcHRvcnMgKHNvLWNhbGxlZCBQQVNJRCB0YWJsZSkgd2hpbGUgdGhlIGhvc3Qg
b3ducyB0aGUKPj4gc3RhZ2UgMiB0YWJsZXMgYW5kIG1haW4gY29uZmlndXJhdGlvbiBzdHJ1Y3R1
cmVzIChTVEUpLgo+Pgo+PiBUaGlzIHdvcmsgbWFpbmx5IGlzIHByb3ZpZGVkIGZvciB0ZXN0IHB1
cnBvc2UgYXMgdGhlIHVwcGVyCj4+IGxheWVyIGludGVncmF0aW9uIGlzIHVuZGVyIHJld29yayBh
bmQgYm91bmQgdG8gYmUgYmFzZWQgb24KPj4gL2Rldi9pb21tdSBpbnN0ZWFkIG9mIFZGSU8gdHVu
bmVsaW5nLiBJbiB0aGlzIHZlcnNpb24gd2UgYWxzbyBnZXQKPj4gcmlkIG9mIHRoZSBNU0kgQklO
RElORyBpb2N0bCwgYXNzdW1pbmcgdGhlIGd1ZXN0IGVuZm9yY2VzCj4+IGZsYXQgbWFwcGluZyBv
ZiBob3N0IElPVkFzIHVzZWQgdG8gYmluZCBwaHlzaWNhbCBNU0kgZG9vcmJlbGxzLgo+PiBJbiB0
aGUgY3VycmVudCBRRU1VIGludGVncmF0aW9uIHRoaXMgaXMgYWNoaWV2ZWQgYnkgZXhwb3NpbmcK
Pj4gUk1ScyB0byB0aGUgZ3Vlc3QsIHVzaW5nIFNoYW1lZXIncyBzZXJpZXMgWzFdLiBUaGlzIGFw
cHJvYWNoCj4+IGlzIFJGQyBhcyB0aGUgSU9SVCBzcGVjIGlzIG5vdCByZWFsbHkgbWVhbnQgdG8g
ZG8gdGhhdAo+PiAoc2luZ2xlIG1hcHBpbmcgZmxhZyBsaW1pdGF0aW9uKS4KPj4KPj4gQmVzdCBS
ZWdhcmRzCj4+Cj4+IEVyaWMKPj4KPj4gVGhpcyBzZXJpZXMgKEhvc3QpIGNhbiBiZSBmb3VuZCBh
dDoKPj4gaHR0cHM6Ly9naXRodWIuY29tL2VhdWdlci9saW51eC90cmVlL3Y1LjE1LXJjNy1uZXN0
ZWQtdjE2Cj4+IFRoaXMgaW5jbHVkZXMgYSByZWJhc2VkIFZGSU8gaW50ZWdyYXRpb24gKGFsdGhv
dWdoIG5vdCBtZWFudAo+PiB0byBiZSB1cHN0cmVhbWVkKQo+Pgo+PiBHdWVzdCBrZXJuZWwgYnJh
bmNoIGNhbiBiZSBmb3VuZCBhdDoKPj4gaHR0cHM6Ly9naXRodWIuY29tL2VhdWdlci9saW51eC90
cmVlL3NoYW1lZXJfcm1ycl92Nwo+PiBmZWF0dXJpbmcgWzFdCj4+Cj4+IFFFTVUgaW50ZWdyYXRp
b24gKHN0aWxsIGJhc2VkIG9uIFZGSU8gYW5kIGV4cG9zaW5nIFJNUnMpCj4+IGNhbiBiZSBmb3Vu
ZCBhdDoKPj4gaHR0cHM6Ly9naXRodWIuY29tL2VhdWdlci9xZW11L3RyZWUvdjYuMS4wLXJtci12
Mi1uZXN0ZWRfc21tdXYzX3YxMAo+PiAodXNlIGlvbW11PW5lc3RlZC1zbW11djMgQVJNIHZpcnQg
b3B0aW9uKQo+Pgo+PiBHdWVzdCBkZXBlbmRlbmN5Ogo+PiBbMV0gW1BBVENIIHY3IDAvOV0gQUNQ
SS9JT1JUOiBTdXBwb3J0IGZvciBJT1JUIFJNUiBub2RlCj4+Cj4+IEhpc3Rvcnk6Cj4+Cj4+IHYx
NSAtPiB2MTY6Cj4+IC0gZ3Vlc3QgUklMIG11c3Qgc3VwcG9ydCBSSUwKPj4gLSBhZGRpdGlvbmFs
IGNoZWNrcyBpbiB0aGUgY2FjaGUgaW52YWxpZGF0aW9uIGhvb2sKPj4gLSByZW1vdmFsIG9mIHRo
ZSBNU0kgQklORElORyBpb2N0bCAodGVudGF0aXZlIHJlcGxhY2VtZW50Cj4+IMKgwqAgYnkgUk1S
cykKPj4KPj4KPj4gRXJpYyBBdWdlciAoOSk6Cj4+IMKgwqAgaW9tbXU6IEludHJvZHVjZSBhdHRh
Y2gvZGV0YWNoX3Bhc2lkX3RhYmxlIEFQSQo+PiDCoMKgIGlvbW11OiBJbnRyb2R1Y2UgaW9tbXVf
Z2V0X25lc3RpbmcKPj4gwqDCoCBpb21tdS9zbW11djM6IEFsbG93IHMxIGFuZCBzMiBjb25maWdz
IHRvIGNvZXhpc3QKPj4gwqDCoCBpb21tdS9zbW11djM6IEdldCBwcmVwYXJlZCBmb3IgbmVzdGVk
IHN0YWdlIHN1cHBvcnQKPj4gwqDCoCBpb21tdS9zbW11djM6IEltcGxlbWVudCBhdHRhY2gvZGV0
YWNoX3Bhc2lkX3RhYmxlCj4+IMKgwqAgaW9tbXUvc21tdXYzOiBBbGxvdyBzdGFnZSAxIGludmFs
aWRhdGlvbiB3aXRoIHVubWFuYWdlZCBBU0lEcwo+PiDCoMKgIGlvbW11L3NtbXV2MzogSW1wbGVt
ZW50IGNhY2hlX2ludmFsaWRhdGUKPj4gwqDCoCBpb21tdS9zbW11djM6IHJlcG9ydCBhZGRpdGlv
bmFsIHJlY292ZXJhYmxlIGZhdWx0cwo+PiDCoMKgIGlvbW11L3NtbXV2MzogRGlzYWxsb3cgbmVz
dGVkIG1vZGUgaW4gcHJlc2VuY2Ugb2YgSFcgTVNJIHJlZ2lvbnMKPiBIaSBFcmljLAo+Cj4gSSB2
YWxpZGF0ZWQgdGhlIHJld29ya2VkIHRlc3QgcGF0Y2hlcyBpbiB2MTYgZnJvbSB0aGUgZ2l2ZW4K
PiBicmFuY2hlcyB3aXRoIEtlcm5lbCB2NS4xNSAmIFFlbXUgdjYuMi4gVmVyaWZpZWQgdGhlbSB3
aXRoCj4gTlZNZSBQQ0kgZGV2aWNlIGFzc2lnbmVkIHRvIEd1ZXN0IFZNLgo+IFNvcnJ5LCBmb3Jn
b3QgdG8gdXBkYXRlIGVhcmxpZXIuCj4KPiBUZXN0ZWQtYnk6IFN1bWl0IEd1cHRhIDxzdW1pdGdA
bnZpZGlhLmNvbT4KClRoYW5rIHlvdSB2ZXJ5IG11Y2ghCgpCZXN0IFJlZ2FyZHMKCkVyaWMKPgo+
IFRoYW5rcywKPiBTdW1pdCBHdXB0YQo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vaW9tbXU=
