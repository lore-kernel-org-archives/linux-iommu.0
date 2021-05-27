Return-Path: <SRS0=nChL=KW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D13C4707F
	for <iommu@archiver.kernel.org>; Thu, 27 May 2021 05:08:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5690613CC
	for <iommu@archiver.kernel.org>; Thu, 27 May 2021 05:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5690613CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 733EB6078B;
	Thu, 27 May 2021 05:08:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KbSH6Gy17kZb; Thu, 27 May 2021 05:08:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 208CC60717;
	Thu, 27 May 2021 05:08:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05977C000E;
	Thu, 27 May 2021 05:08:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2872CC0001
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 05:08:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1631860733
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 05:08:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id neyPf3R5CM0b for <iommu@lists.linux-foundation.org>;
 Thu, 27 May 2021 05:08:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 24A9860717
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 05:08:44 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id j10so4187810edw.8
 for <iommu@lists.linux-foundation.org>; Wed, 26 May 2021 22:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=OSXVSdir/DQunBxCaZTpvHNoZRd/zQTm4r2dtcDMWtM=;
 b=Vvbum0ssCd8+XnEyC968VOahIXXgmU4IKNsN1jaAy3Xi/Zyluk86fXwOUkXVv5q7x/
 ozlOvBIfzB1Q0EnDWElPBUftNOhIElGXoPronS67+OqjMPJRl5M5HthQ16NOU+QVXTGl
 d06nj18jqbGi2FvwgruGJ5TDg5/5zzS4OhkjCOMPT0BW+QvZJONn/jHhKOjEitB/g9un
 uZ4zKJUR2lpgON/Vp7ZjI079lUM8BeSNTciJ42C49qtM/axt9XR+CcVSZ0458FatAO0r
 rAWLRS7Md7dgEprNMklW4zdtk0vbgfXqf5n3KcD2/HLY5Qk7sOX9RIcXkfOmt4k6eLvn
 ntFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OSXVSdir/DQunBxCaZTpvHNoZRd/zQTm4r2dtcDMWtM=;
 b=UI+cFZiLcCQe1F/uWpFgqMK8Oo32V1sMPHlnKssGSDK8CKPqeGoG462TCUQfkl3VWF
 d03ReEd6cI5gEb8/ZOL3XG99IsrIeY0R7QUKdMoe8SixQOcyMhQ4YjA/9X3Z+RX9ppRs
 +EfJ2vQl8WMGDgtg5rRAYfTzwCsKlm2ykYoYmsRGyZ9L+bqYKj64orcdA5LR9ASis5/j
 zRw3ZpNLk+IYrocuSE0RprRITHHma2YG89S2f8sScznMzqqcZsNn3Yvl2fcRXXaZk9tc
 dMoY3EzzV//GwaQXccjkRGV0GJJA40gEI11nr7wGLOXWJGSJK6RS9wYGeEqqXmEvojjB
 UMaQ==
X-Gm-Message-State: AOAM533msnM+3bl0RBUx4pNO2Y8pjxbMi8UgNw2V1HqMvHBHIXClEPyD
 aCmboga6gCEiff4wo3xk+8g66Tf+Mo9dhsW9NvZQ
X-Google-Smtp-Source: ABdhPJytcepFP+t2llkhnOjy77FXDbUbzl/ELg4KeaSs2pPDgpTzNqnNIXgN4Trhj3Sx1RCi2B01qTSVklc5dH0EiY8=
X-Received: by 2002:a05:6402:22fa:: with SMTP id
 dn26mr2005986edb.5.1622092123094; 
 Wed, 26 May 2021 22:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210517095513.850-1-xieyongji@bytedance.com>
 <20210517095513.850-12-xieyongji@bytedance.com>
 <3740c7eb-e457-07f3-5048-917c8606275d@redhat.com>
 <CACycT3uAqa6azso_8MGreh+quj-JXO1piuGnrV8k2kTfc34N2g@mail.gmail.com>
 <5a68bb7c-fd05-ce02-cd61-8a601055c604@redhat.com>
In-Reply-To: <5a68bb7c-fd05-ce02-cd61-8a601055c604@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Thu, 27 May 2021 13:08:32 +0800
Message-ID: <CACycT3ve7YvKF+F+AnTQoJZMPua+jDvGMs_ox8GQe_=SGdeCMA@mail.gmail.com>
Subject: Re: Re: [PATCH v7 11/12] vduse: Introduce VDUSE - vDPA Device in
 Userspace
To: Jason Wang <jasowang@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>, iommu@lists.linux-foundation.org,
 Matthew Wilcox <willy@infradead.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christoph Hellwig <hch@infradead.org>,
 Christian Brauner <christian.brauner@canonical.com>, bcrl@kvack.org,
 Al Viro <viro@zeniv.linux.org.uk>, Stefan Hajnoczi <stefanha@redhat.com>,
 linux-fsdevel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
 =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>,
 Stefano Garzarella <sgarzare@redhat.com>
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

T24gVGh1LCBNYXkgMjcsIDIwMjEgYXQgMTowMCBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPgo+Cj4g5ZyoIDIwMjEvNS8yNyDkuIvljYgxMjo1NywgWW9uZ2ppIFhp
ZSDlhpnpgZM6Cj4gPiBPbiBUaHUsIE1heSAyNywgMjAyMSBhdCAxMjoxMyBQTSBKYXNvbiBXYW5n
IDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+Pgo+ID4+IOWcqCAyMDIxLzUvMTcg5LiL
5Y2INTo1NSwgWGllIFlvbmdqaSDlhpnpgZM6Cj4gPj4+ICsKPiA+Pj4gK3N0YXRpYyBpbnQgdmR1
c2VfZGV2X21zZ19zeW5jKHN0cnVjdCB2ZHVzZV9kZXYgKmRldiwKPiA+Pj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHN0cnVjdCB2ZHVzZV9kZXZfbXNnICptc2cpCj4gPj4+ICt7Cj4gPj4+
ICsgICAgIGluaXRfd2FpdHF1ZXVlX2hlYWQoJm1zZy0+d2FpdHEpOwo+ID4+PiArICAgICBzcGlu
X2xvY2soJmRldi0+bXNnX2xvY2spOwo+ID4+PiArICAgICB2ZHVzZV9lbnF1ZXVlX21zZygmZGV2
LT5zZW5kX2xpc3QsIG1zZyk7Cj4gPj4+ICsgICAgIHdha2VfdXAoJmRldi0+d2FpdHEpOwo+ID4+
PiArICAgICBzcGluX3VubG9jaygmZGV2LT5tc2dfbG9jayk7Cj4gPj4+ICsgICAgIHdhaXRfZXZl
bnRfa2lsbGFibGUobXNnLT53YWl0cSwgbXNnLT5jb21wbGV0ZWQpOwo+ID4+Cj4gPj4gV2hhdCBo
YXBwZW5zIGlmIHRoZSB1c2Vyc3BhY2UobWFsaWNvdXMpIGRvZXNuJ3QgZ2l2ZSBhIHJlc3BvbnNl
IGZvcmV2ZXI/Cj4gPj4KPiA+PiBJdCBsb29rcyBsaWtlIGEgRE9TLiBJZiB5ZXMsIHdlIG5lZWQg
dG8gY29uc2lkZXIgYSB3YXkgdG8gZml4IHRoYXQuCj4gPj4KPiA+IEhvdyBhYm91dCB1c2luZyB3
YWl0X2V2ZW50X2tpbGxhYmxlX3RpbWVvdXQoKSBpbnN0ZWFkPwo+Cj4KPiBQcm9iYWJseSwgYW5k
IHRoZW4gd2UgbmVlZCBjaG9vc2UgYSBzdWl0YWJsZSB0aW1lb3V0IGFuZCBtb3JlIGltcG9ydGFu
dCwKPiBuZWVkIHRvIHJlcG9ydCB0aGUgZmFpbHVyZSB0byB2aXJ0aW8uCj4KCk1ha2VzIHNlbnNl
IHRvIG1lLiBCdXQgaXQgbG9va3MgbGlrZSBzb21lCnZkcGFfY29uZmlnX29wcy92aXJ0aW9fY29u
ZmlnX29wcyBzdWNoIGFzIHNldF9zdGF0dXMoKSBkaWRuJ3QgaGF2ZSBhCnJldHVybiB2YWx1ZS4g
IE5vdyBJIGFkZCBhIFdBUk5fT04oKSBmb3IgdGhlIGZhaWx1cmUuIERvIHlvdSBtZWFuIHdlCm5l
ZWQgdG8gYWRkIHNvbWUgY2hhbmdlIGZvciB2aXJ0aW8gY29yZSB0byBoYW5kbGUgdGhlIGZhaWx1
cmU/CgpUaGFua3MsCllvbmdqaQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
aW9tbXU=
