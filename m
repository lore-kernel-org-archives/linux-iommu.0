Return-Path: <SRS0=kzsj=LS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DE4C48BDF
	for <iommu@archiver.kernel.org>; Thu, 24 Jun 2021 09:16:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C786613E3
	for <iommu@archiver.kernel.org>; Thu, 24 Jun 2021 09:16:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C786613E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C3E683CDC;
	Thu, 24 Jun 2021 09:16:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d4OzEppAya1Q; Thu, 24 Jun 2021 09:16:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1616783BC3;
	Thu, 24 Jun 2021 09:16:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DCA3BC001A;
	Thu, 24 Jun 2021 09:16:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D87DFC000E
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 09:16:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B93AA60B88
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 09:16:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HlGEVFktlJDD for <iommu@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 09:16:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ABC8F608D7
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 09:16:52 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id h17so7474703edw.11
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 02:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ToYKmnHgqk/66SzWjvRy2Lj5kh6aXbY58HiBGtTfTYc=;
 b=ZEweUXuAJoGCGMqY3z9xEzvHeOc45CgfE+oRLPnwvWDM8sEylSod/l69pmO1wTq6Fk
 dJ6IJffz8PwtlA84nAwOMbu/T24GwtdMUEWh7Wfy0A/5i4gI8Lx4GorjU0lFTf+6k/vp
 waHl9OMa0UhLOi5kJckBgVUzPJL/7362ZFcIUrXc9waM3czme6JE2Mo08y5M7V+vITDj
 FSMllieK9ieeAYx2zFLgwFaafNl51St8nhwF6tDUKXqzbB8XsjnOGrlgyKrhcMFFDR5E
 SiRzn5cHnpY863Xr8EDmjh2FISKPY1AoSdoR/zlJVxPQyBejxzBJIxXPRJBt624oRvsJ
 Nt6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ToYKmnHgqk/66SzWjvRy2Lj5kh6aXbY58HiBGtTfTYc=;
 b=K4b2iH8YYgh+0EyTk4ldNv5I4alHA1X8XxpDXFAQDH8pEM+NG1P11NxrT0GCYXGj9u
 5vmyUTvm2/z27jy3RmR8SFXIsqrBMqg3iCNjrOjXL/I0ba1sM+tcp6BP+WKLUTOnrA+l
 I5lJcx16qgRTxWstk/SoltBwavujS2DzM+yHLSCyKo72pwl21CLNJJe0DBq2EAuCe2uy
 VB7ffa+f+ZkK6PIcsXr8Wm8CdB109zj60HHDhW8V0r9C5Y8BU1Y5ZAqfcZw9ogYr89AC
 zN9WMnak4t4G3HRo/AGcO+9yUS6Izq4u9sZxAGSuEjZlOIuuH+0kDn8PSsNRPGE6NJLV
 3JTg==
X-Gm-Message-State: AOAM532IyLn2KVsSPjx5TkwUmQm/1ex6I7aW7QfAFZ6TluqfQFxNXySd
 9VYuHNResDIa0sG5ynhrxmTEaeFkwVxUqBjtifmP
X-Google-Smtp-Source: ABdhPJwzxlNtCT4qXONVb1tZWclCON16CNPSh2qEimKMjvYzH/fk8YJnTCoKh644GYgJY+nPjC5RJVk2i47qjgJpKlM=
X-Received: by 2002:a05:6402:27ce:: with SMTP id
 c14mr5750686ede.118.1624526210663; 
 Thu, 24 Jun 2021 02:16:50 -0700 (PDT)
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
In-Reply-To: <48cab125-093b-2299-ff9c-3de8c7c5ed3d@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Thu, 24 Jun 2021 17:16:39 +0800
Message-ID: <CACycT3tS=10kcUCNGYm=dUZsK+vrHzDvB3FSwAzuJCu3t+QuUQ@mail.gmail.com>
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

T24gVGh1LCBKdW4gMjQsIDIwMjEgYXQgNDoxNCBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPgo+Cj4g5ZyoIDIwMjEvNi8yNCDkuIvljYgxMjo0NiwgWW9uZ2ppIFhp
ZSDlhpnpgZM6Cj4gPj4gU28gd2UgbmVlZCB0byBkZWFsIHdpdGggYm90aCBGRUFUVVJFU19PSyBh
bmQgcmVzZXQsIGJ1dCBwcm9iYWJseSBub3QKPiA+PiBEUklWRVJfT0suCj4gPj4KPiA+IE9LLCBJ
IHNlZS4gVGhhbmtzIGZvciB0aGUgZXhwbGFuYXRpb24uIE9uZSBtb3JlIHF1ZXN0aW9uIGlzIGhv
dyBhYm91dAo+ID4gY2xlYXJpbmcgdGhlIGNvcnJlc3BvbmRpbmcgc3RhdHVzIGJpdCBpbiBnZXRf
c3RhdHVzKCkgcmF0aGVyIHRoYW4KPiA+IG1ha2luZyBzZXRfc3RhdHVzKCkgZmFpbC4gU2luY2Ug
dGhlIHNwZWMgcmVjb21tZW5kcyB0aGlzIHdheSBmb3IKPiA+IHZhbGlkYXRpb24gd2hpY2ggaXMg
ZG9uZSBpbiB2aXJ0aW9fZGV2X3JlbW92ZSgpIGFuZAo+ID4gdmlydGlvX2ZpbmFsaXplX2ZlYXR1
cmVzKCkuCj4gPgo+ID4gVGhhbmtzLAo+ID4gWW9uZ2ppCj4gPgo+Cj4gSSB0aGluayB5b3UgY2Fu
LiBPciBpdCB3b3VsZCBiZSBldmVuIGJldHRlciB0aGF0IHdlIGp1c3QgZG9uJ3Qgc2V0IHRoZQo+
IGJpdCBkdXJpbmcgc2V0X3N0YXR1cygpLgo+CgpZZXMsIHRoYXQncyB3aGF0IEkgbWVhbi4KCj4g
SSBqdXN0IHJlYWxpemUgdGhhdCBpbiB2ZHBhX3Jlc2V0KCkgd2UgaGFkOgo+Cj4gc3RhdGljIGlu
bGluZSB2b2lkIHZkcGFfcmVzZXQoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2KQo+IHsKPiAgICAg
ICAgICBjb25zdCBzdHJ1Y3QgdmRwYV9jb25maWdfb3BzICpvcHMgPSB2ZGV2LT5jb25maWc7Cj4K
PiAgICAgICAgICB2ZGV2LT5mZWF0dXJlc192YWxpZCA9IGZhbHNlOwo+ICAgICAgICAgIG9wcy0+
c2V0X3N0YXR1cyh2ZGV2LCAwKTsKPiB9Cj4KPiBXZSBwcm9iYWJseSBuZWVkIHRvIGFkZCB0aGUg
c3luY2hyb25pemF0aW9uIGhlcmUuIEUuZyByZS1yZWFkIHdpdGggYQo+IHRpbWVvdXQuCj4KCkxv
b2tzIGxpa2UgdGhlIHRpbWVvdXQgaXMgYWxyZWFkeSBpbiBzZXRfc3RhdHVzKCkuIERvIHdlIHJl
YWxseSBuZWVkIGEKZHVwbGljYXRlZCBvbmUgaGVyZT8gQW5kIGhvdyB0byBoYW5kbGUgZmFpbHVy
ZT8gQWRkaW5nIGEgcmV0dXJuIHZhbHVlCnRvIHZpcnRpb19jb25maWdfb3BzLT5yZXNldCgpIGFu
ZCBwYXNzaW5nIHRoZSBlcnJvciB0byB0aGUgdXBwZXIKbGF5ZXI/CgpUaGFua3MsCllvbmdqaQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWls
aW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
