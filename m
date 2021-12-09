Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87725C433EF
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 09:44:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 18C4681CC3;
	Thu,  9 Dec 2021 09:44:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bfse51uYpSoL; Thu,  9 Dec 2021 09:44:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9DD7D81BC6;
	Thu,  9 Dec 2021 09:44:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78CB9C001E;
	Thu,  9 Dec 2021 09:44:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3EBB5C0012
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 09:44:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2B6A2605F1
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 09:44:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GkrfwyN3gvSO for <iommu@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 09:44:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E9E5C605EA
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 09:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639043051;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v7QNiQkm4JpmXjlb9xd1Ey78eIbVoq+bdtr4jOgwpkc=;
 b=OkbG+MKMtVOYOZPPZUYL2Ofqd1cutEunv7EGe9hAquagqN3gTqk4jLlNm9qcAOR6ottpr8
 nAvJjx2tk2jLKOCN0Ycql4wI5dgJnPi5cxuKNczpBZYkUdquCUDpYKkk7IZepiW1kEvVMY
 cIQeJMyDt5gSeeTa6wV1BACBj2k/9bw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-443--oq_AH4jMkCah_HGIzIESg-1; Thu, 09 Dec 2021 04:44:09 -0500
X-MC-Unique: -oq_AH4jMkCah_HGIzIESg-1
Received: by mail-wm1-f70.google.com with SMTP id
 o18-20020a05600c511200b00332fa17a02eso2245206wms.5
 for <iommu@lists.linux-foundation.org>; Thu, 09 Dec 2021 01:44:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=v7QNiQkm4JpmXjlb9xd1Ey78eIbVoq+bdtr4jOgwpkc=;
 b=XrhVgePxF+ZKECKOor+bDyMNVDUOeRbOMD9/JqItbfdxylgEfxPa7S38Bip9QRS4Gk
 fefFuaVw2bkSuUcQfDIaenwU9xmI8fqaPGoNtrdvRNxM/84Se1erc0phzPs8gBXcIkZ8
 loi4Wwx2WSvD7gyAOR6wgNJVspSwn0N4q45Vg4s+eY8QW2t6uhjlN314PQKdSYDTO9zn
 mockVircEBnUIOiCVknc4EGVDE1psSoLeHDqkvKyYqY4kO5UCbIt4psA7FIEuo6SbSDO
 Yy/ixHzatwu9Y7+P3+obEgRpiqQLi2K/58Ba3uZYqr3QTSVBmuT7v/d1adKWlYqFxy9y
 WWjg==
X-Gm-Message-State: AOAM532w0yrO3ubiuUsy2A6aL9ag4wY+h1rlmH1RNbplsRmnyiKeL7TO
 ICIWtCUIwbyjbKkFBqYVth4UiH78wjNGC3rvw/n8ry7dyHvdvi0pJbnQcZj5rMf73Gkk/DqKHX8
 YCS3m07255TAERFkr4dD62zgrNMHO1Q==
X-Received: by 2002:adf:f602:: with SMTP id t2mr5135698wrp.539.1639043047490; 
 Thu, 09 Dec 2021 01:44:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxNkNDQt3yChW2LUPSakGrA3WpwiI2Mo0kl4bKJueL/Ht/+/n6Myy+zN8xmOe8F1FBXlSDz5Q==
X-Received: by 2002:adf:f602:: with SMTP id t2mr5135665wrp.539.1639043047277; 
 Thu, 09 Dec 2021 01:44:07 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id p27sm4984658wmi.28.2021.12.09.01.44.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Dec 2021 01:44:06 -0800 (PST)
Subject: Re: [RFC v16 1/9] iommu: Introduce attach/detach_pasid_table API
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20211027104428.1059740-1-eric.auger@redhat.com>
 <20211027104428.1059740-2-eric.auger@redhat.com>
 <Ya3qd6mT/DpceSm8@8bytes.org>
 <c7e26722-f78c-a93f-c425-63413aa33dde@redhat.com>
 <e6733c59-ffcb-74d4-af26-273c1ae8ce68@linux.intel.com>
 <fbeabcff-a6d4-dcc5-6687-7b32d6358fe3@redhat.com>
 <20211208125616.GN6385@nvidia.com>
 <BN9PR11MB5276E882C5CC5946CA0D4C6A8C709@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
Message-ID: <0dd640fc-18d9-9730-6210-1e4786290aec@redhat.com>
Date: Thu, 9 Dec 2021 10:44:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <BN9PR11MB5276E882C5CC5946CA0D4C6A8C709@BN9PR11MB5276.namprd11.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "lushenming@huawei.com" <lushenming@huawei.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "maz@kernel.org" <maz@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "vsethi@nvidia.com" <vsethi@nvidia.com>,
 "vivek.gautam@arm.com" <vivek.gautam@arm.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "wangxingang5@huawei.com" <wangxingang5@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "will@kernel.org" <will@kernel.org>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>
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

SGkgS2V2aW4sCgpPbiAxMi85LzIxIDQ6MjEgQU0sIFRpYW4sIEtldmluIHdyb3RlOgo+PiBGcm9t
OiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPgo+PiBTZW50OiBXZWRuZXNkYXksIERl
Y2VtYmVyIDgsIDIwMjEgODo1NiBQTQo+Pgo+PiBPbiBXZWQsIERlYyAwOCwgMjAyMSBhdCAwODoz
MzozM0FNICswMTAwLCBFcmljIEF1Z2VyIHdyb3RlOgo+Pj4gSGkgQmFvbHUsCj4+Pgo+Pj4gT24g
MTIvOC8yMSAzOjQ0IEFNLCBMdSBCYW9sdSB3cm90ZToKPj4+PiBIaSBFcmljLAo+Pj4+Cj4+Pj4g
T24gMTIvNy8yMSA2OjIyIFBNLCBFcmljIEF1Z2VyIHdyb3RlOgo+Pj4+PiBPbiAxMi82LzIxIDEx
OjQ4IEFNLCBKb2VyZyBSb2VkZWwgd3JvdGU6Cj4+Pj4+PiBPbiBXZWQsIE9jdCAyNywgMjAyMSBh
dCAxMjo0NDoyMFBNICswMjAwLCBFcmljIEF1Z2VyIHdyb3RlOgo+Pj4+Pj4+IFNpZ25lZC1vZmYt
Ynk6IEplYW4tUGhpbGlwcGUgQnJ1Y2tlcjxqZWFuLXBoaWxpcHBlLmJydWNrZXJAYXJtLmNvbT4K
Pj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBMaXUsIFlpIEw8eWkubC5saXVAbGludXguaW50ZWwuY29t
Pgo+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEFzaG9rIFJhajxhc2hvay5yYWpAaW50ZWwuY29tPgo+
Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEphY29iIFBhbjxqYWNvYi5qdW4ucGFuQGxpbnV4LmludGVs
LmNvbT4KPj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBFcmljIEF1Z2VyPGVyaWMuYXVnZXJAcmVkaGF0
LmNvbT4KPj4+Pj4+IFRoaXMgU2lnbmVkLW9mLWJ5IGNoYWluIGxvb2tzIGR1YmlvdXMsIHlvdSBh
cmUgdGhlIGF1dGhvciBidXQgdGhlIGxhc3QKPj4+Pj4+IG9uZSBpbiB0aGUgY2hhaW4/Cj4+Pj4+
IFRoZSAxc3QgUkZDIGluIEF1ZyAyMDE4Cj4+Pj4+IChodHRwczovL2xpc3RzLmNzLmNvbHVtYmlh
LmVkdS9waXBlcm1haWwva3ZtYXJtLzIwMTgtCj4+IEF1Z3VzdC8wMzI0NzguaHRtbCkKPj4+Pj4g
c2FpZCB0aGlzIHdhcyBhIGdlbmVyYWxpemF0aW9uIG9mIEphY29iJ3MgcGF0Y2gKPj4+Pj4KPj4+
Pj4KPj4+Pj4gwqDCoCBbUEFUQ0ggdjUgMDEvMjNdIGlvbW11OiBpbnRyb2R1Y2UgYmluZF9wYXNp
ZF90YWJsZSBBUEkgZnVuY3Rpb24KPj4+Pj4KPj4+Pj4KPj4+Pj4KPj4+Pj4gaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL3BpcGVybWFpbC9pb21tdS8yMDE4LQo+PiBNYXkvMDI3NjQ3
Lmh0bWwKPj4+Pj4gU28gaW5kZWVkIEphY29iIHNob3VsZCBiZSB0aGUgYXV0aG9yLiBJIGd1ZXNz
IHRoZSBtdWx0aXBsZSByZWJhc2VzIGdvdAo+Pj4+PiB0aGlzIGV2ZW50dWFsbHkgcmVwbGFjZWQg
YXQgc29tZSBwb2ludCwgd2hpY2ggaXMgbm90IGFuIGV4Y3VzZS4gUGxlYXNlCj4+Pj4+IGZvcmdp
dmUgbWUgZm9yIHRoYXQuCj4+Pj4+IE5vdyB0aGUgb3JpZ2luYWwgcGF0Y2ggYWxyZWFkeSBoYWQg
dGhpcyBsaXN0IG9mIFNvQiBzbyBJIGRvbid0IGtub3cgaWYgSQo+Pj4+PiBzaGFsbCBzaW1wbGlm
eSBpdC4KPj4+PiBBcyB3ZSBoYXZlIGRlY2lkZWQgdG8gbW92ZSB0aGUgbmVzdGVkIG1vZGUgKGR1
YWwgc3RhZ2VzKQo+PiBpbXBsZW1lbnRhdGlvbgo+Pj4+IG9udG8gdGhlIGRldmVsb3BpbmcgaW9t
bXVmZCBmcmFtZXdvcmssIHdoYXQncyB0aGUgdmFsdWUgb2YgYWRkaW5nIHRoaXMKPj4+PiBpbnRv
IGlvbW11IGNvcmU/Cj4+PiBUaGUgaW9tbXVfdWFwaV9hdHRhY2hfcGFzaWRfdGFibGUgdWFwaSBz
aG91bGQgZGlzYXBwZWFyIGluZGVlZCBhcyBpdCBpcwo+Pj4gaXMgYm91bmQgdG8gYmUgcmVwbGFj
ZWQgYnkgL2Rldi9pb21tdSBmZWxsb3cgQVBJLgo+Pj4gSG93ZXZlciB1bnRpbCBJIGNhbiByZWJh
c2Ugb24gL2Rldi9pb21tdSBjb2RlIEkgYW0gb2JsaWdlZCB0byBrZWVwIGl0IHRvCj4+PiBtYWlu
dGFpbiB0aGlzIGludGVncmF0aW9uLCBoZW5jZSB0aGUgUkZDLgo+PiBJbmRlZWQsIHdlIGFyZSBn
ZXR0aW5nIHByZXR0eSBjbG9zZSB0byBoYXZpbmcgdGhlIGJhc2UgaW9tbXVmZCB0aGF0IHdlCj4+
IGNhbiBzdGFydCBhZGRpbmcgc3R1ZmYgbGlrZSB0aGlzIGludG8uIE1heWJlIGluIEphbnVhcnks
IHlvdSBjYW4gbG9vawo+PiBhdCBzb21lIHBhcnRzIG9mIHdoYXQgaXMgZXZvbHZpbmcgaGVyZToK
Pj4KPj4gaHR0cHM6Ly9naXRodWIuY29tL2pndW50aG9ycGUvbGludXgvY29tbWl0cy9pb21tdWZk
Cj4+IGh0dHBzOi8vZ2l0aHViLmNvbS9MdUJhb2x1L2ludGVsLWlvbW11L2NvbW1pdHMvaW9tbXUt
ZG1hLW93bmVyc2hpcC0KPj4gdjIKPj4gaHR0cHM6Ly9naXRodWIuY29tL2x1eGlzMTk5OS9pb21t
dWZkL2NvbW1pdHMvaW9tbXVmZC12NS4xNi1yYzIKPj4KPj4gRnJvbSBhIHByb2dyZXNzIHBlcnNw
ZWN0aXZlIEkgd291bGQgbGlrZSB0byBzdGFydCB3aXRoIHNpbXBsZSAncGFnZQo+PiB0YWJsZXMg
aW4gdXNlcnNwYWNlJywgaWUgbm8gUEFTSUQgaW4gdGhpcyBzdGVwLgo+Pgo+PiAncGFnZSB0YWJs
ZXMgaW4gdXNlcnNwYWNlJyBtZWFucyBhbiBpb21tdWZkIGlvY3RsIHRvIGNyZWF0ZSBhbgo+PiBp
b21tdV9kb21haW4gd2hlcmUgdGhlIElPTU1VIEhXIGlzIGRpcmVjdGx5IHRyYXZlc2VyaW5nIGEK
Pj4gZGV2aWNlLXNwZWNpZmljIHBhZ2UgdGFibGUgc3RydWN0dXJlIGluIHVzZXIgc3BhY2UgbWVt
b3J5LiBBbGwgdGhlIEhXCj4+IHRvZGF5IGltcGxlbWVudHMgdGhpcyBieSB1c2luZyBhbm90aGVy
IGlvbW11X2RvbWFpbiB0byBhbGxvdyB0aGUgSU9NTVUKPj4gSFcgRE1BIGFjY2VzcyB0byB1c2Vy
IG1lbW9yeSAtIGllIG5lc3Rpbmcgb3IgbXVsdGktc3RhZ2Ugb3Igd2hhdGV2ZXIuCj4gT25lIGNs
YXJpZmljYXRpb24gaGVyZSBpbiBjYXNlIHBlb3BsZSBtYXkgZ2V0IGNvbmZ1c2VkIGJhc2VkIG9u
IHRoZQo+IGN1cnJlbnQgaW9tbXVfZG9tYWluIGRlZmluaXRpb24uIEphc29uIGJyYWluc3Rvcm1l
ZCB3aXRoIHVzIG9uIGhvdwo+IHRvIHJlcHJlc2VudCAndXNlciBwYWdlIHRhYmxlJyBpbiB0aGUg
SU9NTVUgc3ViLXN5c3RlbS4gT25lIGlzIHRvCj4gZXh0ZW5kIGlvbW11X2RvbWFpbiBhcyBhIGdl
bmVyYWwgcmVwcmVzZW50YXRpb24gZm9yIGFueSBwYWdlIHRhYmxlCj4gaW5zdGFuY2UuIFRoZSBv
dGhlciBvcHRpb24gaXMgdG8gY3JlYXRlIG5ldyByZXByZXNlbnRhdGlvbnMgZm9yIHVzZXIKPiBw
YWdlIHRhYmxlcyBhbmQgdGhlbiBsaW5rIHRoZW0gdW5kZXIgZXhpc3RpbmcgaW9tbXVfZG9tYWlu
Lgo+Cj4gVGhpcyBjb250ZXh0IGlzIGJhc2VkIG9uIHRoZSAxc3Qgb3B0aW9uLiBhbmQgQXMgSmFz
b24gc2FpZCBpbiB0aGUgYm90dG9tCj4gd2Ugc3RpbGwgbmVlZCB0byBza2V0Y2ggb3V0IHdoZXRo
ZXIgaXQgd29ya3MgYXMgZXhwZWN0ZWQuIPCfmIoKPgo+PiBUaGlzIHdvdWxkIGNvbWUgYWxvbmcg
d2l0aCBzb21lIGlvY3RscyB0byBpbnZhbGlkYXRlIHRoZSBJT1RMQi4KPj4KPj4gSSdtIGltYWdp
bmluZyB0aGlzIHN0ZXAgYXMgYSBpb21tdV9ncm91cC0+b3AtPmNyZWF0ZV91c2VyX2RvbWFpbigp
Cj4+IGRyaXZlciBjYWxsYmFjayB3aGljaCB3aWxsIGNyZWF0ZSBhIG5ldyBraW5kIG9mIGRvbWFp
biB3aXRoCj4+IGRvbWFpbi11bmlxdWUgb3BzLiBJZSBtYXAvdW5tYXAgcmVsYXRlZCBzaG91bGQg
YWxsIGJlIE5VTEwgYXMgdGhvc2UKPj4gYXJlIGltcG9zc2libGUgb3BlcmF0aW9ucy4KPj4KPj4g
RnJvbSB0aGVyZSB0aGUgdXN1YWwgc3RydWN0IGRldmljZSAoaWUgUklEKSBhdHRhY2gvZGV0YXRj
aCBzdHVmZiBuZWVkcwo+PiB0byB0YWtlIGNhcmUgb2Ygcm91dGluZyBETUFzIHRvIHRoaXMgaW9t
bXVfZG9tYWluLgo+IFVzYWdlLXdpc2UgdGhpcyBjb3ZlcnMgdGhlIGd1ZXN0IElPVkEgcmVxdWly
ZW1lbnRzIGkuZS4gd2hlbiB0aGUgZ3Vlc3QKPiBrZXJuZWwgZW5hYmxlcyB2SU9NTVUgZm9yIGtl
cm5lbCBETUEtQVBJIG1hcHBpbmdzIG9yIGZvciBkZXZpY2UKPiBhc3NpZ25tZW50IHRvIGd1ZXN0
IHVzZXJzcGFjZS4KPgo+IEZvciBpbnRlbCB0aGlzIG1lYW5zIG9wdGltaXphdGlvbiB0byB0aGUg
ZXhpc3Rpbmcgc2hhZG93LWJhc2VkIHZJT01NVQo+IGltcGxlbWVudGF0aW9uLgo+Cj4gRm9yIEFS
TSB0aGlzIGFjdHVhbGx5IGVuYWJsZXMgZ3Vlc3QgSU9WQSB1c2FnZSBmb3IgdGhlIGZpcnN0IHRp
bWUgKGNvcnJlY3QKPiBtZSBFcmljPykuClllcyB0aGF0J3MgY29ycmVjdC4gVGhpcyBpcyB0aGUg
c2NvcGUgb2YgdGhpcyBzZXJpZXMgKHNpbmdsZSBQQVNJRCkKPiAgSUlSQyBTTU1VIGRvZXNuJ3Qg
c3VwcG9ydCBjYWNoaW5nIG1vZGUgd2hpbGUgd3JpdGUtcHJvdGVjdGluZwo+IGd1ZXN0IEkvTyBw
YWdlIHRhYmxlIHdhcyBjb25zaWRlcmVkIGEgbm8tZ28uIFNvIG5lc3RpbmcgaXMgY29uc2lkZXJl
ZCBhcwo+IHRoZSBvbmx5IG9wdGlvbiB0byBzdXBwb3J0IHRoYXQuCnRoYXQncyBjb3JyZWN0IHRv
by4gTm8gJ2NhY2hpbmcgbW9kZScgcHJvdmlzaW9ubmVkIGluIHRoZSBTTU1VIHNwZWMuIEkKdGhv
dWdodCBpdCB3b3VsZCBqdXN0IGJlIGEgbWF0dGVyIG9mIGFkZGluZyAxIGJpdCBpbiBhbiBJRCBy
ZWcgdGhvdWdoLgoKVGhhbmtzCgpFcmljCj4KPiBhbmQgb25jZSAndXNlciBwYXNpZCB0YWJsZScg
aXMgaW5zdGFsbGVkLCB0aGlzIGFjdHVhbGx5IG1lYW5zIGd1ZXN0IFNWQSB1c2FnZQo+IGNhbiBh
bHNvIHBhcnRpYWxseSB3b3JrIGZvciBBUk0gaWYgSS9PIHBhZ2UgZmF1bHQgaXMgbm90IGluY3Vy
cmVkLgo+Cj4+IFN0ZXAgdHdvIHdvdWxkIGJlIHRvIGFkZCB0aGUgYWJpbGl0eSBmb3IgYW4gaW9t
bXVmZCB1c2luZyBkcml2ZXIgdG8KPj4gcmVxdWVzdCB0aGF0IGEgUklEJlBBU0lEIGlzIGNvbm5l
Y3RlZCB0byBhbiBpb21tdV9kb21haW4uIFRoaXMKPj4gY29ubmVjdGlvbiBjYW4gYmUgcmVxdWVz
dGVkIGZvciBhbnkga2luZCBvZiBpb21tdV9kb21haW4sIGtlcm5lbCBvd25lZAo+PiBvciB1c2Vy
IG93bmVkLgo+Pgo+PiBJIGRvbid0IHF1aXRlIGhhdmUgYW4gYW5zd2VyIGhvdyBleGFjdGx5IHRo
ZSBTTU1VdjMgdnMgSW50ZWwKPj4gZGlmZmVyZW5jZSBpbiBQQVNJRCByb3V0aW5nIHNob3VsZCBi
ZSByZXNvbHZlZC4KPiBGb3Iga2VybmVsIG93bmVkIHRoZSBpb21tdWZkIGludGVyZmFjZSBzaG91
bGQgYmUgZ2VuZXJpYyBhcyB0aGUKPiB2ZW5kb3IgZGlmZmVyZW5jZSBpcyBtYW5hZ2VkIGJ5IHRo
ZSBrZXJuZWwgaXRzZWxmLgo+Cj4gRm9yIHVzZXIgb3duZWQgd2UnbGwgbmVlZCBuZXcgdUFQSXMg
Zm9yIHVzZXIgdG8gc3BlY2lmeSBQQVNJRC4gCj4gQXMgSSByZXBsaWVkIGluIGFub3RoZXIgdGhy
ZWFkIG9ubHkgSW50ZWwgY3VycmVudGx5IHJlcXVpcmVzIGl0IGR1ZSB0bwo+IG1kZXYuIEJ1dCBv
dGhlciB2ZW5kb3JzIGNvdWxkIGFsc28gZG8gc28gd2hlbiB0aGV5IGRlY2lkZSB0byAKPiBzdXBw
b3J0IG1kZXYgb25lIGRheS4KPgo+PiB0byBnZXQgYW5zd2VycyBJJ20gaG9waW5nIHRvIHN0YXJ0
IGJ1aWxkaW5nIHNvbWUgc2tldGNoIFJGQ3MgZm9yIHRoZXNlCj4+IGRpZmZlcmVudCB0aGluZ3Mg
b24gaW9tbXVmZCwgaG9wZWZ1bGx5IGluIEphbnVhcnkuIEknbSBsb29raW5nIGF0IHVzZXIKPj4g
cGFnZSB0YWJsZXMsIFBBU0lELCBkaXJ0eSB0cmFja2luZyBhbmQgdXNlcnNwYWNlIElPIGZhdWx0
IGhhbmRsaW5nIGFzCj4+IHRoZSBtYWluIGZlYXR1cmVzIGlvbW11ZmQgbXVzdCB0YWNrbGUuCj4g
TWFrZSBzZW5zZS4KPgo+PiBUaGUgcHVycG9zZSBvZiB0aGUgc2tldGNoZXMgd291bGQgYmUgdG8g
dmFsaWRhdGUgdGhhdCB0aGUgSFcgZmVhdHVyZXMKPj4gd2Ugd2FudCB0byBleHBvc2VkIGNhbiB3
b3JrIHdpbGwgd2l0aCB0aGUgY2hvaWNlcyB0aGUgYmFzZSBpcyBtYWtpbmcuCj4+Cj4+IEphc29u
Cj4gVGhhbmtzCj4gS2V2aW4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9p
b21tdQ==
