Return-Path: <SRS0=Ze3H=LT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D6AC49EAB
	for <iommu@archiver.kernel.org>; Fri, 25 Jun 2021 04:19:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 943F06141F
	for <iommu@archiver.kernel.org>; Fri, 25 Jun 2021 04:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 943F06141F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6321F83CD1;
	Fri, 25 Jun 2021 04:19:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iQKvkbzYC2sK; Fri, 25 Jun 2021 04:19:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 51DED83CFB;
	Fri, 25 Jun 2021 04:19:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11CF6C001A;
	Fri, 25 Jun 2021 04:19:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 572F4C000E
 for <iommu@lists.linux-foundation.org>; Fri, 25 Jun 2021 04:19:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 51DC140187
 for <iommu@lists.linux-foundation.org>; Fri, 25 Jun 2021 04:19:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KOMH2A-kbHKp for <iommu@lists.linux-foundation.org>;
 Fri, 25 Jun 2021 04:19:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0B596400EC
 for <iommu@lists.linux-foundation.org>; Fri, 25 Jun 2021 04:19:27 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id hq39so12980856ejc.5
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 21:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=q34vFqngnB3t5A6Nz3+eYIAGYGv8OAQnO0GJ9ith6+k=;
 b=YyvepM16teRAmW69CrgpPvH41Kv8BofJj0cnZwPg1pUt8Kynigzda5WiVGgo+EUKSl
 MmN7Bs8/AinjxpLcVb8drAzPGwoEC/8SqEctQaOrgknExBKqugTu3nDd7XqY74F2MnUL
 +aOfvmk2a2zM5gOZvVHKyqfJUj9GoDM5evNKgotF30eKzWH9zKild6AjUCaJxDdxo3/0
 JIVSRc7orj7IUOn29Px1/HUAF2D7/UPboHOswMrNZPwXJ0Ib9KZYxz+XAxuLo/GeSNS5
 6Ws2t1iATvhbQUuJEkMXTiXk+zAp+ud2KhPhyz3bAmKGDboR4fY7Tvr/053rCSMrbt+9
 gKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=q34vFqngnB3t5A6Nz3+eYIAGYGv8OAQnO0GJ9ith6+k=;
 b=X6FpAZRQR4LVQ/n1A0ZBk9xflwBz0So+ivKJG6tGSDodZvpo9l6uII9D/ZCCHrbW+a
 0KwV3tzXJ3v0v+GrtCRwXdWcNefba2S5prshLFdYJcJZ11yUs5dDMNYRB7pSnul5Cgbp
 QHfWdSKG4MMm0GIQwWZTiYC5Ix1avNj+LFd4bN2Es66i9KuNN+Bnol8GuEBQ5Rxdbixu
 Bdlk8gBoDJAWZRMdEREfjh8fiCuLx8jZHE+mI1iBfPyIr3F5SHAN+RNWnLH88cjXiB0c
 qbN1grzwsngrpX05Kug3DG2V5oxASB2wQiaYoB+lZk6tcqGX18oT0sk1P5aBBBeXhpEt
 IIgA==
X-Gm-Message-State: AOAM530YMaphxYmMJ2ANU/2fxq81IxvL7FIXwR1G22Uw9qb7j/DRH+BD
 5Wi6a1vsox0oXoAdQeb3BVmxcylwpqbbM+cgv7bw
X-Google-Smtp-Source: ABdhPJwWo7LxCs+JJy5P3HQmX5kV8JvQwPmXrDO588SF0T6G/cjPM3gzbPTywA6iLqaSgqpcRjYDZsFvg/0Ua/XTQNc=
X-Received: by 2002:a17:906:7142:: with SMTP id
 z2mr8520729ejj.427.1624594765939; 
 Thu, 24 Jun 2021 21:19:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210615141331.407-1-xieyongji@bytedance.com>
 <20210615141331.407-10-xieyongji@bytedance.com>
 <adfb2be9-9ed9-ca37-ac37-4cd00bdff349@redhat.com>
 <CACycT3tAON+-qZev+9EqyL2XbgH5HDspOqNt3ohQLQ8GqVK=EA@mail.gmail.com>
 <1bba439f-ffc8-c20e-e8a4-ac73e890c592@redhat.com>
 <CACycT3uzMJS7vw6MVMOgY4rb=SPfT2srV+8DPdwUVeELEiJgbA@mail.gmail.com>
 <0aeb7cb7-58e5-1a95-d830-68edd7e8ec2e@redhat.com>
 <CACycT3uuooKLNnpPHewGZ=q46Fap2P4XCFirdxxn=FxK+X1ECg@mail.gmail.com>
 <e4cdee72-b6b4-d055-9aac-3beae0e5e3e1@redhat.com>
 <CACycT3u8=_D3hCtJR+d5BgeUQMce6S7c_6P3CVfvWfYhCQeXFA@mail.gmail.com>
 <d2334f66-907c-2e9c-ea4f-f912008e9be8@redhat.com>
 <CACycT3uCSLUDVpQHdrmuxSuoBDg-4n22t+N-Jm2GoNNp9JYB2w@mail.gmail.com>
 <48cab125-093b-2299-ff9c-3de8c7c5ed3d@redhat.com>
 <CACycT3tS=10kcUCNGYm=dUZsK+vrHzDvB3FSwAzuJCu3t+QuUQ@mail.gmail.com>
 <b10b3916-74d4-3171-db92-be0afb479a1c@redhat.com>
In-Reply-To: <b10b3916-74d4-3171-db92-be0afb479a1c@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Fri, 25 Jun 2021 12:19:15 +0800
Message-ID: <CACycT3vpMFbc9Fzuo9oksMaA-pVb1dEVTEgjNoft16voryPSWQ@mail.gmail.com>
Subject: Re: Re: [PATCH v8 09/10] vduse: Introduce VDUSE - vDPA Device in
 Userspace
To: Jason Wang <jasowang@redhat.com>
Cc: kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christian Brauner <christian.brauner@canonical.com>,
 Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
 Christoph Hellwig <hch@infradead.org>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Stefan Hajnoczi <stefanha@redhat.com>, songmuchun@bytedance.com,
 Jens Axboe <axboe@kernel.dk>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 bcrl@kvack.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>
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

T24gRnJpLCBKdW4gMjUsIDIwMjEgYXQgMTE6MDkgQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4gd3JvdGU6Cj4KPgo+IOWcqCAyMDIxLzYvMjQg5LiL5Y2INToxNiwgWW9uZ2ppIFhp
ZSDlhpnpgZM6Cj4gPiBPbiBUaHUsIEp1biAyNCwgMjAyMSBhdCA0OjE0IFBNIEphc29uIFdhbmcg
PGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4+Cj4gPj4g5ZyoIDIwMjEvNi8yNCDkuIvl
jYgxMjo0NiwgWW9uZ2ppIFhpZSDlhpnpgZM6Cj4gPj4+PiBTbyB3ZSBuZWVkIHRvIGRlYWwgd2l0
aCBib3RoIEZFQVRVUkVTX09LIGFuZCByZXNldCwgYnV0IHByb2JhYmx5IG5vdAo+ID4+Pj4gRFJJ
VkVSX09LLgo+ID4+Pj4KPiA+Pj4gT0ssIEkgc2VlLiBUaGFua3MgZm9yIHRoZSBleHBsYW5hdGlv
bi4gT25lIG1vcmUgcXVlc3Rpb24gaXMgaG93IGFib3V0Cj4gPj4+IGNsZWFyaW5nIHRoZSBjb3Jy
ZXNwb25kaW5nIHN0YXR1cyBiaXQgaW4gZ2V0X3N0YXR1cygpIHJhdGhlciB0aGFuCj4gPj4+IG1h
a2luZyBzZXRfc3RhdHVzKCkgZmFpbC4gU2luY2UgdGhlIHNwZWMgcmVjb21tZW5kcyB0aGlzIHdh
eSBmb3IKPiA+Pj4gdmFsaWRhdGlvbiB3aGljaCBpcyBkb25lIGluIHZpcnRpb19kZXZfcmVtb3Zl
KCkgYW5kCj4gPj4+IHZpcnRpb19maW5hbGl6ZV9mZWF0dXJlcygpLgo+ID4+Pgo+ID4+PiBUaGFu
a3MsCj4gPj4+IFlvbmdqaQo+ID4+Pgo+ID4+IEkgdGhpbmsgeW91IGNhbi4gT3IgaXQgd291bGQg
YmUgZXZlbiBiZXR0ZXIgdGhhdCB3ZSBqdXN0IGRvbid0IHNldCB0aGUKPiA+PiBiaXQgZHVyaW5n
IHNldF9zdGF0dXMoKS4KPiA+Pgo+ID4gWWVzLCB0aGF0J3Mgd2hhdCBJIG1lYW4uCj4gPgo+ID4+
IEkganVzdCByZWFsaXplIHRoYXQgaW4gdmRwYV9yZXNldCgpIHdlIGhhZDoKPiA+Pgo+ID4+IHN0
YXRpYyBpbmxpbmUgdm9pZCB2ZHBhX3Jlc2V0KHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldikKPiA+
PiB7Cj4gPj4gICAgICAgICAgIGNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgKm9wcyA9IHZk
ZXYtPmNvbmZpZzsKPiA+Pgo+ID4+ICAgICAgICAgICB2ZGV2LT5mZWF0dXJlc192YWxpZCA9IGZh
bHNlOwo+ID4+ICAgICAgICAgICBvcHMtPnNldF9zdGF0dXModmRldiwgMCk7Cj4gPj4gfQo+ID4+
Cj4gPj4gV2UgcHJvYmFibHkgbmVlZCB0byBhZGQgdGhlIHN5bmNocm9uaXphdGlvbiBoZXJlLiBF
LmcgcmUtcmVhZCB3aXRoIGEKPiA+PiB0aW1lb3V0Lgo+ID4+Cj4gPiBMb29rcyBsaWtlIHRoZSB0
aW1lb3V0IGlzIGFscmVhZHkgaW4gc2V0X3N0YXR1cygpLgo+Cj4KPiBEbyB5b3UgbWVhbiB0aGUg
VkRVU0UncyBpbXBsZW1lbnRhdGlvbj8KPgoKWWVzLgoKPgo+ID4gICBEbyB3ZSByZWFsbHkgbmVl
ZCBhCj4gPiBkdXBsaWNhdGVkIG9uZSBoZXJlPwo+Cj4KPiAxKSB0aGlzIGlzIHRoZSB0aW1lb3V0
IGF0IHRoZSB2RFBBIGxheWVyIGluc3RlYWQgb2YgdGhlIFZEVVNFIGxheWVyLgoKT0ssIEkgZ2V0
IGl0LgoKPiAyKSBpdCByZWFsbHkgZGVwZW5kcyBvbiB3aGF0J3MgdGhlIG1lYW5pbmcgb2YgdGhl
IHRpbWVvdXQgZm9yIHNldF9zdGF0dXMKPiBvZiBWRFVTRS4KPgo+IERvIHdlIHdhbnQ6Cj4KPiAy
YSkgZm9yIHNldF9zdGF0dXMoKTogcmVsYXkgdGhlIG1lc3NhZ2UgdG8gdXNlcnNwYWNlIGFuZCB3
YWl0IGZvciB0aGUKPiB1c2Vyc3BhY2UgdG8gcXVpZXNjZW5jZSB0aGUgZGF0YXBhdGgKPgo+IG9y
Cj4KPiAyYikgZm9yIHNldF9zdGF0dXMoKTogc2ltcGx5IHJlbGF5IHRoZSBtZXNzYWdlIHRvIHVz
ZXJzcGFjZSwgcmVwbHkgaXMgbm8KPiBuZWVkZWQuIFVzZXJzcGFjZSB3aWxsIHVzZSBhIGNvbW1h
bmQgdG8gdXBkYXRlIHRoZSBzdGF0dXMgd2hlbiB0aGUKPiBkYXRhcGF0aCBpcyBzdG9wLiBUaGUg
dGhlIHN0YXR1cyBjb3VsZCBiZSBmZXRjaGVkIHZpYSBnZXRfc3RhdHMoKS4KPgo+IDJiIGxvb2tz
IG1vcmUgc3BlYyBjb21wbGFpbnQuCj4KCkxvb2tzIGdvb2QgdG8gbWUuIEFuZCBJIHRoaW5rIHdl
IGNhbiB1c2UgdGhlIHJlcGx5IG9mIHRoZSBtZXNzYWdlIHRvCnVwZGF0ZSB0aGUgc3RhdHVzIGlu
c3RlYWQgb2YgaW50cm9kdWNpbmcgYSBuZXcgY29tbWFuZC4KCj4gPiBBbmQgaG93IHRvIGhhbmRs
ZSBmYWlsdXJlPyBBZGRpbmcgYSByZXR1cm4gdmFsdWUKPiA+IHRvIHZpcnRpb19jb25maWdfb3Bz
LT5yZXNldCgpIGFuZCBwYXNzaW5nIHRoZSBlcnJvciB0byB0aGUgdXBwZXIKPiA+IGxheWVyPwo+
Cj4KPiBTb21ldGhpbmcgbGlrZSB0aGlzLgo+CgpPSy4KClRoYW5rcywKWW9uZ2ppCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlz
dAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
