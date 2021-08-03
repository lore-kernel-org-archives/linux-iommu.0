Return-Path: <SRS0=qwh6=M2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D168CC4338F
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 09:02:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AA1560C3F
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 09:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5AA1560C3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2557E606EF;
	Tue,  3 Aug 2021 09:02:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FM_-Jm1GhDog; Tue,  3 Aug 2021 09:02:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E8886605D0;
	Tue,  3 Aug 2021 09:02:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C54E5C0010;
	Tue,  3 Aug 2021 09:02:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 281DDC000E
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 09:02:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0F9014019B
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 09:02:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LuRpd2bh4MAn for <iommu@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 09:02:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 32EA4400E6
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 09:02:10 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id z11so5640451edb.11
 for <iommu@lists.linux-foundation.org>; Tue, 03 Aug 2021 02:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=3wZFhZTC8zZY+D9UvhMcL30+qrKHqoBqQtpm1vOADzM=;
 b=JKe8MBo/Q/9jJiWfNFv7/6FozVELAtit9lfH9d5TxXXMYzq/K+Pmkq5MZfy0MK2cFu
 cx6FhhWxNDc+0E1xzGVvot63Tu4Ur8FkAtBApXV5HGWA7B6YAue4z52aDqp2cPeuObcM
 NbvLlt0iETqmIH/loBFX6RmK5lnhTeVCMIO5KKZH9Z5CWgGXEldHbQTMQQrf9uJEnfFB
 86l/PEM0xk2vAai/1RJXq5azCxa1fJfFP2bTdkelMNkruzkW1VP4XZZrR/YihWu8I9cm
 wPq3kJhM7XQVmw7qPL2HCPQ0a2PjgZxJc4l7AroO/DlUf8xZiD0v/CMDlg12kwVoA4f6
 XDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3wZFhZTC8zZY+D9UvhMcL30+qrKHqoBqQtpm1vOADzM=;
 b=pHdQjQjWuRz9eI7Cw7nrjZQgND4ZxOWJjPSGWMPR5IsmSGIfQ9iYjPqBbytlBcgVav
 4Qew5epcBvzQk1Gyj27wCWOaRaWa5/+KvbGL+v5II2JOs6JKXSiP6wQ1nRAMVu/krr/x
 LN0hSKh0G2jqGFrYSAWRAlnPFpD1waewoL0PGSWF1sKxG90SdOLv7NrhOZnpaqPk2703
 W7BmanyOXI81pVSJRq/oKNNPvohQ62IUyz1KSvlPnSm0Ki+SxKz8HN8qo/YYJLJFjvcp
 U/DgRoqaZTBzVJ7FaRC8icncoZyhuoRfcticL90guACNw51cPHaogpNcBz5aUS/A8OCO
 4i3Q==
X-Gm-Message-State: AOAM532fRXA5CQr0OYbz99WuyNVg77y/qZZHg7IomoLOfOhh0ngcy6iK
 HQ8KkMWX5Wy56EWUF/vRo1NWFjDh63IBZn4qpbl9
X-Google-Smtp-Source: ABdhPJyS6bOrWfuvjmdwVRGONpMTv6Y0zVE0kh7I9sjtSTBg5XbDmv85P6yS8Pkoi3kNsB54rx4AF9ZFKn4Qu8vMSM8=
X-Received: by 2002:aa7:c50a:: with SMTP id o10mr23739559edq.118.1627981328237; 
 Tue, 03 Aug 2021 02:02:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210729073503.187-1-xieyongji@bytedance.com>
 <20210729073503.187-3-xieyongji@bytedance.com>
 <a0ab081a-db06-6b7a-b22e-4ace96a5c7db@redhat.com>
In-Reply-To: <a0ab081a-db06-6b7a-b22e-4ace96a5c7db@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Tue, 3 Aug 2021 17:01:57 +0800
Message-ID: <CACycT3sdx8nA8fh3pjO_=pbiM+Bs5y+h4fuGkFQEsRSaBnph7Q@mail.gmail.com>
Subject: Re: [PATCH v10 02/17] file: Export receive_fd() to modules
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

T24gVHVlLCBBdWcgMywgMjAyMSBhdCAzOjQ2IFBNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhh
dC5jb20+IHdyb3RlOgo+Cj4KPiDlnKggMjAyMS83LzI5IOS4i+WNiDM6MzQsIFhpZSBZb25namkg
5YaZ6YGTOgo+ID4gRXhwb3J0IHJlY2VpdmVfZmQoKSBzbyB0aGF0IHNvbWUgbW9kdWxlcyBjYW4g
dXNlCj4gPiBpdCB0byBwYXNzIGZpbGUgZGVzY3JpcHRvciBiZXR3ZWVuIHByb2Nlc3NlcyB3aXRo
b3V0Cj4gPiBtaXNzaW5nIGFueSBzZWN1cml0eSBzdHVmZnMuCj4gPgo+ID4gU2lnbmVkLW9mZi1i
eTogWGllIFlvbmdqaSA8eGlleW9uZ2ppQGJ5dGVkYW5jZS5jb20+Cj4gPiAtLS0KPiA+ICAgZnMv
ZmlsZS5jICAgICAgICAgICAgfCA2ICsrKysrKwo+ID4gICBpbmNsdWRlL2xpbnV4L2ZpbGUuaCB8
IDcgKysrLS0tLQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNCBkZWxl
dGlvbnMoLSkKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvZnMvZmlsZS5jIGIvZnMvZmlsZS5jCj4gPiBp
bmRleCA4NmRjOTk1NmFmMzIuLjIxMGU1NDA2NzJhYSAxMDA2NDQKPiA+IC0tLSBhL2ZzL2ZpbGUu
Ywo+ID4gKysrIGIvZnMvZmlsZS5jCj4gPiBAQCAtMTEzNCw2ICsxMTM0LDEyIEBAIGludCByZWNl
aXZlX2ZkX3JlcGxhY2UoaW50IG5ld19mZCwgc3RydWN0IGZpbGUgKmZpbGUsIHVuc2lnbmVkIGlu
dCBvX2ZsYWdzKQo+ID4gICAgICAgcmV0dXJuIG5ld19mZDsKPiA+ICAgfQo+ID4KPiA+ICtpbnQg
cmVjZWl2ZV9mZChzdHJ1Y3QgZmlsZSAqZmlsZSwgdW5zaWduZWQgaW50IG9fZmxhZ3MpCj4gPiAr
ewo+ID4gKyAgICAgcmV0dXJuIF9fcmVjZWl2ZV9mZChmaWxlLCBOVUxMLCBvX2ZsYWdzKTsKPgo+
Cj4gQW55IHJlYXNvbiB0aGF0IHJlY2VpdmVfZmRfdXNlcigpIGNhbiBsaXZlIGluIHRoZSBmaWxl
Lmg/Cj4KClNpbmNlIG5vIG1vZHVsZXMgdXNlIGl0LgoKVGhhbmtzLApZb25namkKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0
CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
