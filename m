Return-Path: <SRS0=I0uF=LX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFBBC11F6C
	for <iommu@archiver.kernel.org>; Tue, 29 Jun 2021 07:34:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D584B61DBC
	for <iommu@archiver.kernel.org>; Tue, 29 Jun 2021 07:34:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D584B61DBC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 73F8441D15;
	Tue, 29 Jun 2021 07:34:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id thlJD5QbiHLv; Tue, 29 Jun 2021 07:34:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3B83041D13;
	Tue, 29 Jun 2021 07:34:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12D55C001A;
	Tue, 29 Jun 2021 07:34:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05AAEC000E
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 07:34:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D638741D15
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 07:34:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6uTVLsuSvKvK for <iommu@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 07:34:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1468F41D13
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 07:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624952042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X7aRa/ari9ndRrZW6yGfSw3dQvpOEYQN4vmyoY/ZeNU=;
 b=QDgeywfxmxZQEo7IQCYNxePBlSYwC86akw8fgAgO/QLSDydrDl2sqmap5r/QOLm97tjKTA
 T8xcDv1m+hsijuTv9FQpWP5yQqNGNAwvXE77vE1nYKL1yrHPgYMGAChsipVyqPyaavNvU0
 nX/PIZXaxUNcZNzrdh8syfJGh1brgIc=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-39zPAPJhNnC9Ny0vYE9QvA-1; Tue, 29 Jun 2021 03:34:01 -0400
X-MC-Unique: 39zPAPJhNnC9Ny0vYE9QvA-1
Received: by mail-pj1-f69.google.com with SMTP id
 t5-20020a17090a4485b029016f7fcb8a3dso1725283pjg.2
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 00:34:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=X7aRa/ari9ndRrZW6yGfSw3dQvpOEYQN4vmyoY/ZeNU=;
 b=umUXexvvEkqnn7DG6oh2GrcBCZ7vcCjBGQw7JpqKt619MIVCEiOg5/40RHujaWQwZA
 oH3/HXV7oeCuYgeuAuVlJxT+olYpEbZmfYx2HXy7cPH8zPwZBp9cUj/bq+b+BqFWlKYT
 wdk+cy5YIRXusm30lAOTc+xLy+5DzxdMlIewtf6G0acDuCCuVRwJ9h5tBKW1WB0z46vG
 67jAp8fSnffLzedK4mAGbBoC5ICLGK3YmJBTHMhNxQu82ZRDawTSzC96skEFihrMMXp2
 LZ2SKHnyFWjltSXkTiX1XKnz8Z9eb602hN69axXTNvOYzv7xEf0y0QQ6pKxFEiJxP+l9
 hE7Q==
X-Gm-Message-State: AOAM532G0GC/39IuxYHrz02O/rQWpMvXNIhRzqxZ7wWD5IFfRi+q90mI
 TZeTq4KT18sMcbzOrtJfnoRZfBieEkLqSPbfWEdhH+NlWefs3Ht8uf64c6euvA/Q4qXfkbXRNjc
 e1/gRI/qjnLpDpVGhoWZcWlA4QVHw7w==
X-Received: by 2002:a63:43c4:: with SMTP id
 q187mr12256871pga.172.1624952039993; 
 Tue, 29 Jun 2021 00:33:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7prtHQtaiL3wMVzoCQQ1u9za913WVNoujdQYVZqZ/2wS5MelCYOe6dyArhR9IgMLsZIzYyg==
X-Received: by 2002:a63:43c4:: with SMTP id
 q187mr12256834pga.172.1624952039684; 
 Tue, 29 Jun 2021 00:33:59 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id c2sm17127924pjv.10.2021.06.29.00.33.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Jun 2021 00:33:59 -0700 (PDT)
Subject: Re: [PATCH v8 00/10] Introduce VDUSE - vDPA Device in Userspace
To: Yongji Xie <xieyongji@bytedance.com>
References: <20210615141331.407-1-xieyongji@bytedance.com>
 <20210628103309.GA205554@storage2.sh.intel.com>
 <CAONzpcbjr2zKOAQrWa46Tv=oR1fYkcKLcqqm_tSgO7RkU20yBA@mail.gmail.com>
 <d5321870-ef29-48e2-fdf6-32d99a5fa3b9@redhat.com>
 <CACycT3vVhNdhtyohKJQuMXTic5m6jDjEfjzbzvp=2FJgwup8mg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <90e30d9e-5709-2a0b-0449-858eea9dfec9@redhat.com>
Date: Tue, 29 Jun 2021 15:33:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CACycT3vVhNdhtyohKJQuMXTic5m6jDjEfjzbzvp=2FJgwup8mg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christian Brauner <christian.brauner@canonical.com>,
 Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
 Christoph Hellwig <hch@infradead.org>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Liu Xiaodong <xiaodong.liu@intel.com>, Yongji Xie <elohimes@gmail.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Stefan Hajnoczi <stefanha@redhat.com>,
 songmuchun@bytedance.com, Jens Axboe <axboe@kernel.dk>,
 Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 bcrl@kvack.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
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

CuWcqCAyMDIxLzYvMjkg5LiL5Y2IMjo0MCwgWW9uZ2ppIFhpZSDlhpnpgZM6Cj4gT24gVHVlLCBK
dW4gMjksIDIwMjEgYXQgMTI6MTMgUE0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4g
d3JvdGU6Cj4+Cj4+IOWcqCAyMDIxLzYvMjgg5LiL5Y2INjozMiwgWW9uZ2ppIFhpZSDlhpnpgZM6
Cj4+Pj4gVGhlIGxhcmdlIGJhcnJpZXIgaXMgYm91bmNlLWJ1ZmZlciBtYXBwaW5nOiBTUERLIHJl
cXVpcmVzIGh1Z2VwYWdlcwo+Pj4+IGZvciBOVk1lIG92ZXIgUENJZSBhbmQgUkRNQSwgc28gdGFr
ZSBzb21lIHByZWFsbGNvYXRlZCBodWdlcGFnZXMgdG8KPj4+PiBtYXAgYXMgYm91bmNlIGJ1ZmZl
ciBpcyBuZWNlc3NhcnkuIE9yIGl0J3MgaGFyZCB0byBhdm9pZCBhbiBleHRyYQo+Pj4+IG1lbWNw
eSBmcm9tIGJvdW5jZS1idWZmZXIgdG8gaHVnZXBhZ2UuCj4+Pj4gSWYgeW91IGNhbiBhZGQgYW4g
b3B0aW9uIHRvIG1hcCBodWdlcGFnZXMgYXMgYm91bmNlLWJ1ZmZlciwKPj4+PiB0aGVuIFNQREsg
Y291bGQgYWxzbyBiZSBhIHBvdGVudGlhbCB1c2VyIG9mIHZkdXNlLgo+Pj4+Cj4+PiBJIHRoaW5r
IHdlIGNhbiBzdXBwb3J0IHJlZ2lzdGVyaW5nIHVzZXIgc3BhY2UgbWVtb3J5IGZvciBib3VuY2Ut
YnVmZmVyCj4+PiB1c2UgbGlrZSBYRFAgZG9lcy4gQnV0IHRoaXMgbmVlZHMgdG8gcGluIHRoZSBw
YWdlcywgc28gSSBkaWRuJ3QKPj4+IGNvbnNpZGVyIGl0IGluIHRoaXMgaW5pdGlhbCB2ZXJzaW9u
Lgo+Pj4KPj4gTm90ZSB0aGF0IHVzZXJzcGFjZSBzaG91bGQgYmUgdW5hd2FyZSBvZiB0aGUgZXhp
c3RlbmNlIG9mIHRoZSBib3VuY2UgYnVmZmVyLgo+Pgo+IElmIHNvLCBpdCBtaWdodCBiZSBoYXJk
IHRvIHVzZSB1bWVtLiBCZWNhdXNlIHdlIGNhbid0IHVzZSB1bWVtIGZvcgo+IGNvaGVyZW50IG1h
cHBpbmcgd2hpY2ggbmVlZHMgcGh5c2ljYWwgYWRkcmVzcyBjb250aWd1b3VzIHNwYWNlLgo+Cj4g
VGhhbmtzLAo+IFlvbmdqaQoKCldlIHByb2JhYmx5IGNhbiB1c2UgdW1lbSBmb3IgbWVtb3J5IG90
aGVyIHRoYW4gdGhlIHZpcnRxdWV1ZSAoc3RpbGwgdmlhIAptbWFwKCkpLgoKVGhhbmtzCgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGlu
ZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
