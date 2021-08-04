Return-Path: <SRS0=FZ/Z=M3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55EDC4320E
	for <iommu@archiver.kernel.org>; Wed,  4 Aug 2021 09:08:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3735E60E78
	for <iommu@archiver.kernel.org>; Wed,  4 Aug 2021 09:08:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3735E60E78
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F1CCF60747;
	Wed,  4 Aug 2021 09:08:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vspknV9S4Qw0; Wed,  4 Aug 2021 09:08:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D04AD6062F;
	Wed,  4 Aug 2021 09:08:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A732DC0010;
	Wed,  4 Aug 2021 09:08:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D8D1CC000E
 for <iommu@lists.linux-foundation.org>; Wed,  4 Aug 2021 09:08:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D2BF5405D4
 for <iommu@lists.linux-foundation.org>; Wed,  4 Aug 2021 09:08:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xWIVUOSKO-ka for <iommu@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 09:08:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6A896405E0
 for <iommu@lists.linux-foundation.org>; Wed,  4 Aug 2021 09:08:02 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id c25so2708913ejb.3
 for <iommu@lists.linux-foundation.org>; Wed, 04 Aug 2021 02:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=vHxgnDbRze3cfbummo1oFdspd0VXUkioTGyKAxbmjBY=;
 b=rrLb5avlbWWVVZAoiqSf4GuH1Tep3672/ZPFrJ1q2sFsUjVxFnNVB7tKQ6xXG4rhnv
 1PpAczmI/qacC7vsiZ2BEcntWSoQhW130Qwg+GEKxWvTPhhjdU0zMqHukOrvN7jIhUoV
 Nsn2eb0p8F8I1ZJcwL62tBSr6vb1HYCK7y/HkosE9AxRt7VX5in8838+OKYoj/JdigCO
 22pQ6zrUz1MLqHboxSN2WElTA63GZmG1OcBMMKNc/LoDbjlq6Lf4z01rVYSWbqkkn5bl
 mqGmd/oNyGjYpPMnG5vHW8RpUjXvzzZbHlRoL8cVzBdZSTws01CqFaXWZkQX3ftOVtMV
 f9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vHxgnDbRze3cfbummo1oFdspd0VXUkioTGyKAxbmjBY=;
 b=NjVsTdW6QhxAjT6TKyxCiuKvHRcMASVVdF3JKYGAZJdMQ0OZKLMz8YWYgZqw+0B313
 ba12OqLGFGqxnMLMX20lMwM3LIvyqfdVoexkD2KYQSCDejcztQoKDBoB67bsirE3NagL
 uCTTeJwMRxqkIuzSd9fFuNr6F0DCBtzz0BG+t2JwxK5At+HEvbwqN/gXIf0tKVdGCaCZ
 JVQOVjwK8mUzcyITQzK1jGVeluMnS9SqBAt2PA9v61pCh74DNwZJYMn2Xzu8JmnC4c6N
 NFQO+6ns3TdgRQV1yhzub8XrqBt/6oLLFewxnVTMVBL9Im/HO7CfotUSiKjNKjEt1TvI
 DqfA==
X-Gm-Message-State: AOAM532q2zqbHxusSbnR9Drrvd084Y8TiEMsXFIkrssSthA8wnutaikr
 4eRU7ZZJiN65HtJwuzxWHs1YbpDgwps4wBsJ0VCX
X-Google-Smtp-Source: ABdhPJz7ndtSUpcqEgNkoVHcDwP0fq03BR0Lre7qDAvevyBxeyuNZM0taxEDcIn1Kzh847IXKZfSmIisXg0eBWVCt2c=
X-Received: by 2002:a17:906:58c7:: with SMTP id
 e7mr24219405ejs.197.1628068080494; 
 Wed, 04 Aug 2021 02:08:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210729073503.187-1-xieyongji@bytedance.com>
 <20210729073503.187-11-xieyongji@bytedance.com>
 <6bb6c689-e6dd-cfa2-094b-a0ca4258aded@redhat.com>
 <CACycT3v7BHxYY0OFYJRFU41Bz1=_v8iMRwzYKgX6cJM-SiNH+A@mail.gmail.com>
 <fdcb0224-11f9-caf2-a44e-e6406087fd50@redhat.com>
 <CACycT3v0EQVrv_A1K1bKmiYu0q5aFE=t+0yRaWKC7T3_H3oB-Q@mail.gmail.com>
 <bd48ec76-0d5c-2efb-8406-894286b28f6b@redhat.com>
In-Reply-To: <bd48ec76-0d5c-2efb-8406-894286b28f6b@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Wed, 4 Aug 2021 17:07:49 +0800
Message-ID: <CACycT3tUwJXUV24PK7OvzPrHYYeQ5Q3qUW_vbuFMjwig0dBw2g@mail.gmail.com>
Subject: Re: [PATCH v10 10/17] virtio: Handle device reset failure in
 register_virtio_device()
To: Jason Wang <jasowang@redhat.com>
Cc: kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christian Brauner <christian.brauner@canonical.com>,
 Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
 Christoph Hellwig <hch@infradead.org>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Liu Xiaodong <xiaodong.liu@intel.com>, linux-fsdevel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, Stefan Hajnoczi <stefanha@redhat.com>,
 songmuchun@bytedance.com, Jens Axboe <axboe@kernel.dk>,
 He Zhe <zhe.he@windriver.com>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 bcrl@kvack.org, netdev@vger.kernel.org, Joe Perches <joe@perches.com>,
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

T24gV2VkLCBBdWcgNCwgMjAyMSBhdCA0OjU0IFBNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhh
dC5jb20+IHdyb3RlOgo+Cj4KPiDlnKggMjAyMS84LzQg5LiL5Y2INDo1MCwgWW9uZ2ppIFhpZSDl
hpnpgZM6Cj4gPiBPbiBXZWQsIEF1ZyA0LCAyMDIxIGF0IDQ6MzIgUE0gSmFzb24gV2FuZyA8amFz
b3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPj4KPiA+PiDlnKggMjAyMS84LzMg5LiL5Y2INToz
OCwgWW9uZ2ppIFhpZSDlhpnpgZM6Cj4gPj4+IE9uIFR1ZSwgQXVnIDMsIDIwMjEgYXQgNDowOSBQ
TSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+Pj4+IOWcqCAyMDIx
LzcvMjkg5LiL5Y2IMzozNCwgWGllIFlvbmdqaSDlhpnpgZM6Cj4gPj4+Pj4gVGhlIGRldmljZSBy
ZXNldCBtYXkgZmFpbCBpbiB2aXJ0aW8tdmRwYSBjYXNlIG5vdywgc28gYWRkIGNoZWNrcyB0bwo+
ID4+Pj4+IGl0cyByZXR1cm4gdmFsdWUgYW5kIGZhaWwgdGhlIHJlZ2lzdGVyX3ZpcnRpb19kZXZp
Y2UoKS4KPiA+Pj4+IFNvIHRoZSByZXNldCgpIHdvdWxkIGJlIGNhbGxlZCBieSB0aGUgZHJpdmVy
IGR1cmluZyByZW1vdmUgYXMgd2VsbCwgb3IKPiA+Pj4+IGlzIGl0IHN1ZmZpY2llbnQgdG8gZGVh
bCBvbmx5IHdpdGggdGhlIHJlc2V0IGR1cmluZyBwcm9iZT8KPiA+Pj4+Cj4gPj4+IEFjdHVhbGx5
IHRoZXJlIGlzIG5vIHdheSB0byBoYW5kbGUgZmFpbHVyZSBkdXJpbmcgcmVtb3ZhbC4gQW5kIGl0
Cj4gPj4+IHNob3VsZCBiZSBzYWZlIHdpdGggdGhlIHByb3RlY3Rpb24gb2Ygc29mdHdhcmUgSU9U
TEIgZXZlbiBpZiB0aGUKPiA+Pj4gcmVzZXQoKSBmYWlscy4KPiA+Pj4KPiA+Pj4gVGhhbmtzLAo+
ID4+PiBZb25namkKPiA+Pgo+ID4+IElmIHRoaXMgaXMgdHJ1ZSwgZG9lcyBpdCBtZWFuIHdlIGRv
bid0IGV2ZW4gbmVlZCB0byBjYXJlIGFib3V0IHJlc2V0Cj4gPj4gZmFpbHVyZT8KPiA+Pgo+ID4g
QnV0IHdlIG5lZWQgdG8gaGFuZGxlIHRoZSBmYWlsdXJlIGluIHRoZSB2aG9zdC12ZHBhIGNhc2Us
IGlzbid0IGl0Pwo+Cj4KPiBZZXMsIGJ1dDoKPgo+IC0gVGhpcyBwYXRjaCBpcyBmb3IgdmlydGlv
IG5vdCBmb3Igdmhvc3QsIGlmIHdlIGRvbid0IGNhcmUgdmlydGlvLCB3ZQo+IGNhbiBhdm9pZCB0
aGUgY2hhbmdlcwo+IC0gRm9yIHZob3N0LCB0aGVyZSBjb3VsZCBiZSB0d28gd2F5cyBwcm9iYWJs
eToKPgo+IDEpIGxldCB0aGUgc2V0X3N0YXR1cyB0byByZXBvcnQgZXJyb3IKPiAyKSByZXF1aXJl
IHVzZXJzcGFjZSB0byByZS1yZWFkIGZvciBzdGF0dXMKPgo+IEl0IGxvb2tzIHRvIG1lIHlvdSB3
YW50IHRvIGdvIHdpdGggMSkgYW5kIEknbSBub3Qgc3VyZSB3aGV0aGVyIG9yIG5vdAo+IGl0J3Mg
dG9vIGxhdGUgdG8gZ28gd2l0aCAyKS4KPgoKTG9va3MgbGlrZSAyKSBjYW4ndCB3b3JrIGlmIHJl
c2V0IGZhaWx1cmUgaGFwcGVucyBpbgp2aG9zdF92ZHBhX3JlbGVhc2UoKSBhbmQgdmhvc3RfdmRw
YV9vcGVuKCkuCgpUaGFua3MsCllvbmdqaQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vaW9tbXU=
