Return-Path: <SRS0=I0uF=LX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D2AC11F68
	for <iommu@archiver.kernel.org>; Tue, 29 Jun 2021 03:56:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E298D61D4C
	for <iommu@archiver.kernel.org>; Tue, 29 Jun 2021 03:56:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E298D61D4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AACB283490;
	Tue, 29 Jun 2021 03:56:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9i4e-CPGNxh5; Tue, 29 Jun 2021 03:56:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9EA9983455;
	Tue, 29 Jun 2021 03:56:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7375CC001D;
	Tue, 29 Jun 2021 03:56:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2F4DC000E
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 03:56:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 90593403D8
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 03:56:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jdb1FYBknM1i for <iommu@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 03:56:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 46107403D6
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 03:56:40 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id hc16so33706446ejc.12
 for <iommu@lists.linux-foundation.org>; Mon, 28 Jun 2021 20:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=D86WnvUg/Gf6HvI1cRKKP6mYttXzkG9si4A9EUDsAM8=;
 b=ktycy0u3fd2n2LkkSyJRlmSxqWEZlI+BMvbBCygDsyL4bIVPtYgv5F3+OlCovp8IE5
 YdPYVKSMPNv8K2fsE7c+BMChTcNAl5zpMojzsBvnVkL4PPrg7fnB0m/BFLGeBU0lzU1m
 MU7KsdUKUmnRFvYuD/eV+6Db6BPIOkjzmSt9osG/AWuczpiHFJ2Bu4tU+ciassk5Ffh/
 eGTomGEeKsvnc7O2JYvkMtm4pMXolMCXY87xsSrpS765Ssqow1gwNrBX4Dxq/qiRbqeG
 izQopD22vjrMYv+U6MDcAo2FarGQHBrWmq+Nm6+vmwbR1xRB/et+FjzeuFqj2ugygP0H
 WDGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=D86WnvUg/Gf6HvI1cRKKP6mYttXzkG9si4A9EUDsAM8=;
 b=tV8OzYFAtvHzAt8jtTuAjqE+BEMrM2FemXnjkxdaTAGk15AAfU1bcvTx/QNN5zNZWM
 25gbZ3oBTRWxhdzaORdq8l71hCt4Fe15g07AtpOLOfWlXZo3gnpHwdODPE5nr3khHCE+
 nd6ncszyyKmDTafIu5e2ySxJ7lBLD2d6K3MFTDWK6XkMN09EbQEsNLnDkwmTFcc9d5Tq
 FPX2Wz7CGs9ZPiw/yeRGe8C7B4f4vbvG0CTNDXpa5vz0epkkHogrLmXowZnG4CEI5Nse
 C2GiziUU+lKIVOCn7wvBOOZ+00J8MFC1Cif0YZwpc7R0xDpep7ubIhU5v0H1qbClvfLe
 edvw==
X-Gm-Message-State: AOAM531myMG2RmevXRnl9zkNBSVZKWsr/5KJnkAIWob8c86gC0kujZHs
 o2MzCBlRE4qLCuh3fXDsNi1ZprLMnlMZasGxO9RK
X-Google-Smtp-Source: ABdhPJwtp85h6QY/GJlNTdlYZ5BUszc1XLhwmkDVnzLYJaYJYGPEVbGPDY3rOdmLE4oNkfRjGeiuf2gOtKcicAsxgrk=
X-Received: by 2002:a17:906:7142:: with SMTP id
 z2mr27152930ejj.427.1624938998259; 
 Mon, 28 Jun 2021 20:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210615141331.407-1-xieyongji@bytedance.com>
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
 <CACycT3vpMFbc9Fzuo9oksMaA-pVb1dEVTEgjNoft16voryPSWQ@mail.gmail.com>
 <d7e42109-0ba6-3e1a-c42a-898b6f33c089@redhat.com>
 <CACycT3u9-id2DxPpuVLtyg4tzrUF9xCAGr7nBm=21HfUJJasaQ@mail.gmail.com>
 <e82766ff-dc6b-2cbb-3504-0ef618d538e2@redhat.com>
In-Reply-To: <e82766ff-dc6b-2cbb-3504-0ef618d538e2@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Tue, 29 Jun 2021 11:56:27 +0800
Message-ID: <CACycT3ucVz3D4Tcr1C6uzWyApZy7Xk4o17VH2gvLO3w1Ra+skg@mail.gmail.com>
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

T24gVHVlLCBKdW4gMjksIDIwMjEgYXQgMTE6MjkgQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4gd3JvdGU6Cj4KPgo+IOWcqCAyMDIxLzYvMjkg5LiK5Y2IMTA6MjYsIFlvbmdqaSBY
aWUg5YaZ6YGTOgo+ID4gT24gTW9uLCBKdW4gMjgsIDIwMjEgYXQgMTI6NDAgUE0gSmFzb24gV2Fu
ZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPj4KPiA+PiDlnKggMjAyMS82LzI1IOS4
i+WNiDEyOjE5LCBZb25namkgWGllIOWGmemBkzoKPiA+Pj4+IDJiKSBmb3Igc2V0X3N0YXR1cygp
OiBzaW1wbHkgcmVsYXkgdGhlIG1lc3NhZ2UgdG8gdXNlcnNwYWNlLCByZXBseSBpcyBubwo+ID4+
Pj4gbmVlZGVkLiBVc2Vyc3BhY2Ugd2lsbCB1c2UgYSBjb21tYW5kIHRvIHVwZGF0ZSB0aGUgc3Rh
dHVzIHdoZW4gdGhlCj4gPj4+PiBkYXRhcGF0aCBpcyBzdG9wLiBUaGUgdGhlIHN0YXR1cyBjb3Vs
ZCBiZSBmZXRjaGVkIHZpYSBnZXRfc3RhdHMoKS4KPiA+Pj4+Cj4gPj4+PiAyYiBsb29rcyBtb3Jl
IHNwZWMgY29tcGxhaW50Lgo+ID4+Pj4KPiA+Pj4gTG9va3MgZ29vZCB0byBtZS4gQW5kIEkgdGhp
bmsgd2UgY2FuIHVzZSB0aGUgcmVwbHkgb2YgdGhlIG1lc3NhZ2UgdG8KPiA+Pj4gdXBkYXRlIHRo
ZSBzdGF0dXMgaW5zdGVhZCBvZiBpbnRyb2R1Y2luZyBhIG5ldyBjb21tYW5kLgo+ID4+Pgo+ID4+
IEp1c3Qgbm90aWNlIHRoaXMgcGFydCBpbiB2aXJ0aW9fZmluYWxpemVfZmVhdHVyZXMoKToKPiA+
Pgo+ID4+ICAgICAgICAgICB2aXJ0aW9fYWRkX3N0YXR1cyhkZXYsIFZJUlRJT19DT05GSUdfU19G
RUFUVVJFU19PSyk7Cj4gPj4gICAgICAgICAgIHN0YXR1cyA9IGRldi0+Y29uZmlnLT5nZXRfc3Rh
dHVzKGRldik7Cj4gPj4gICAgICAgICAgIGlmICghKHN0YXR1cyAmIFZJUlRJT19DT05GSUdfU19G
RUFUVVJFU19PSykpIHsKPiA+Pgo+ID4+IFNvIHdlIG5vIHJlcGx5IGRvZXNuJ3Qgd29yayBmb3Ig
RkVBVFVSRVNfT0suCj4gPj4KPiA+PiBTbyBteSB1bmRlcnN0YW5kaW5nIGlzOgo+ID4+Cj4gPj4g
MSkgV2UgbXVzdCBub3QgdXNlIG5vcmVwbHkgZm9yIHNldF9zdGF0dXMoKQo+ID4+IDIpIFdlIGNh
biB1c2Ugbm9yZXBseSBmb3IgZ2V0X3N0YXR1cygpLCBidXQgaXQgcmVxdWlyZXMgYSBuZXcgaW9j
dGwgdG8KPiA+PiB1cGRhdGUgdGhlIHN0YXR1cy4KPiA+Pgo+ID4+IFNvIGl0IGxvb2tzIHRvIG1l
IHdlIG5lZWQgc3luY2hyb25pemUgZm9yIGJvdGggZ2V0X3N0YXR1cygpIGFuZAo+ID4+IHNldF9z
dGF0dXMoKS4KPiA+Pgo+ID4gV2Ugc2hvdWxkIG5vdCBzZW5kIG1lc3NhZ2VzIHRvIHVzZXJzcGFj
ZSBpbiB0aGUgRkVBVFVSRVNfT0sgY2FzZS4gU28KPiA+IHRoZSBzeW5jaHJvbml6YXRpb24gaXMg
bm90IG5lY2Vzc2FyeS4KPgo+Cj4gQXMgZGlzY3Vzc2VkIHByZXZpb3VzbHksIHRoZXJlIGNvdWxk
IGJlIGEgZGV2aWNlIHRoYXQgbWFuZGF0ZXMgc29tZQo+IGZlYXR1cmVzIChWSVJUSU9fRl9SSU5H
X1BBQ0tFRCkuIFNvIGl0IGNhbiBjaG9vc2UgdG8gbm90IGFjY2VwdAo+IEZFQVRVUkVTX09LIGlz
IHBhY2tlZCB2aXJ0cXVldWUgaXMgbm90IG5lZ290aWF0ZWQuCj4KPiBJbiB0aGlzIGNhc2Ugd2Ug
bmVlZCB0byByZWxheSB0aGUgbWVzc2FnZSB0byB1c2Vyc3BhY2UuCj4KCk9LLCBJIHNlZS4gSWYg
c28sIEkgcHJlZmVyIHRvIG9ubHkgdXNlIG5vcmVwbHkgZm9yIHNldF9zdGF0dXMoKS4gV2UgZG8K
bm90IHNldCB0aGUgc3RhdHVzIGJpdCBpZiB0aGUgbWVzc2FnZSBpcyBmYWlsZWQuIEluIHRoaXMg
d2F5LCB3ZSBkb24ndApuZWVkIHRvIGNoYW5nZSBsb3RzIG9mIHZpcnRpbyBjb3JlIGNvZGVzIHRv
IGhhbmRsZSB0aGUgZmFpbHVyZSBvZgpzZXRfc3RhdHVzKCkvZ2V0X3N0YXR1cygpLgoKVGhhbmtz
LApZb25namkKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
aW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
