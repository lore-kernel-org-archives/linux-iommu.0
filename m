Return-Path: <SRS0=qwh6=M2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D6DC4338F
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 09:18:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9947A60F01
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 09:18:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9947A60F01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 648EB6071B;
	Tue,  3 Aug 2021 09:18:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iEHk9nsy8Gdi; Tue,  3 Aug 2021 09:18:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3E0D060717;
	Tue,  3 Aug 2021 09:18:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1316DC001A;
	Tue,  3 Aug 2021 09:18:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5AA3EC000E
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 09:18:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 48F338300C
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 09:18:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iznljuzOSckT for <iommu@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 09:18:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8A5CC82F9B
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 09:18:07 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id o5so35372535ejy.2
 for <iommu@lists.linux-foundation.org>; Tue, 03 Aug 2021 02:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=bNa7n1tZtuJcEEYiLTNeGKslKTEJs+rtFT0YV9yNlew=;
 b=Jd+UZ5AGs0Ooq/66KM+jA4m9HwVi+MRm7XqkaGbn4V3hh5RUeGnjXO4FB7ez9GAPYi
 tgsVUEl0qxA7yF00ZHW+ZQiwCQ+LlBhQO7XW9c8IihoDB7j2kIzgHGgN0wPJWzhpaSye
 JNwP1w89B3rYkEiXk/GkfLl0DR/lZ5VVGVH+IgILe+GxDSLM0KE2pbBO9vokfAg1Y2DJ
 4RPjt/85Mviy7n69snrUtKkUS9Z6/N8O0sY0KgvcM19Hi4Hbb6ldZkvVVYKFbXNgIOAM
 fo/TUivWwXaMC+0AFsFKUL9/T5bEBtf2ZUMRUza95oSJ9q2/NCozwY/+6bIvFMxUfevT
 EO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bNa7n1tZtuJcEEYiLTNeGKslKTEJs+rtFT0YV9yNlew=;
 b=kJP4NRUpKTiX1F3a3EL6SOUnEhxDcVesm60eI9RBHWbL+pfHx2nU8Wua57WxUxqc1f
 jWSRg/FkYJx45ZNmWLoBAY++6nfPgw/wJwFkK/psp1ZFced9TbXu1rOrrPgZn8MNDtXa
 qDRgds+uY2HwiCkdFH72335lzw8GUY1VJmOXtAt1Y8AElbfeTrbP0a8E6fi8+kYGGJ2I
 vlhdtM0eZGfoeZhXFXpgxKsSoomc++KdygEVEmt8ygIqGPqyMI9Zrt2T8KWnSr9ePt7d
 6ZF3unsuiWRWyxBpBhTzT6wPe1YjHHKUCJnuMFSb08STmIjUl/j1sbf4ECk8FnvxH30F
 g+FQ==
X-Gm-Message-State: AOAM5325zakHGIl7FM2n3m6cLryzS+7p24XR4OXd6GrcJyDQ4xCZ3SSJ
 Y1qgge90dHb61wlQ854vqguKdTpeawc29u7gsuJK
X-Google-Smtp-Source: ABdhPJz+l/RWTi/cEp9hIjcvn9xzMhjrwXVoQzQni85Wf2XRf3qnbCHSQTs5k/IZl5rLuZZ4G+B/tk85r0HL53eNKZg=
X-Received: by 2002:a17:906:af77:: with SMTP id
 os23mr19120305ejb.427.1627982285614; 
 Tue, 03 Aug 2021 02:18:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210729073503.187-1-xieyongji@bytedance.com>
 <20210729073503.187-8-xieyongji@bytedance.com>
 <487ed840-f417-e1b6-edb3-15f19969de51@redhat.com>
In-Reply-To: <487ed840-f417-e1b6-edb3-15f19969de51@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Tue, 3 Aug 2021 17:17:54 +0800
Message-ID: <CACycT3ujOQ84mNMEjE-H93cgVvrWeKaDcAabg7GPvMzU-rSPYw@mail.gmail.com>
Subject: Re: [PATCH v10 07/17] virtio: Don't set FAILED status bit on device
 index allocation failure
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

T24gVHVlLCBBdWcgMywgMjAyMSBhdCA0OjAzIFBNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhh
dC5jb20+IHdyb3RlOgo+Cj4KPiDlnKggMjAyMS83LzI5IOS4i+WNiDM6MzQsIFhpZSBZb25namkg
5YaZ6YGTOgo+ID4gV2UgZG9uJ3QgbmVlZCB0byBzZXQgRkFJTEVEIHN0YXR1cyBiaXQgb24gZGV2
aWNlIGluZGV4IGFsbG9jYXRpb24KPiA+IGZhaWx1cmUgc2luY2UgdGhlIGRldmljZSBpbml0aWFs
aXphdGlvbiBoYXNuJ3QgYmVlbiBzdGFydGVkIHlldC4KPiA+IFRoaXMgZG9lc24ndCBhZmZlY3Qg
cnVudGltZSwgZm91bmQgaW4gY29kZSByZXZpZXcuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogWGll
IFlvbmdqaSA8eGlleW9uZ2ppQGJ5dGVkYW5jZS5jb20+Cj4KPgo+IERvZXMgaXQgcmVhbGx5IGhh
cm0/Cj4KCkFjdHVhbGx5IG5vdC4gSSB0aGluayBJIGNhbiByZW1vdmUgdGhpcyBwYXRjaCBpZiB3
ZSBkb24ndCBuZWVkIGl0LgoKVGhhbmtzLApZb25namkKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2lvbW11
