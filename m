Return-Path: <SRS0=mply=KV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0DBC4708A
	for <iommu@archiver.kernel.org>; Wed, 26 May 2021 02:43:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1570E61439
	for <iommu@archiver.kernel.org>; Wed, 26 May 2021 02:43:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1570E61439
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CE9C840134;
	Wed, 26 May 2021 02:43:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X9gPNw9OIUfk; Wed, 26 May 2021 02:43:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id B71F24000B;
	Wed, 26 May 2021 02:43:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5BC1EC000D;
	Wed, 26 May 2021 02:43:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1CB7DC0001
 for <iommu@lists.linux-foundation.org>; Wed, 26 May 2021 02:43:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F404283BDF
 for <iommu@lists.linux-foundation.org>; Wed, 26 May 2021 02:43:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xpDMX7kVWCIe for <iommu@lists.linux-foundation.org>;
 Wed, 26 May 2021 02:43:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A13E28386E
 for <iommu@lists.linux-foundation.org>; Wed, 26 May 2021 02:43:45 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id gb17so18404ejc.8
 for <iommu@lists.linux-foundation.org>; Tue, 25 May 2021 19:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=cyqKIBrVaRZ0+l7SzJYRtSgO5kugLUClFhe3a16fIks=;
 b=xKidA34PKHbdo2S/y22PDRHuVMfazORIWEYHJGkmXyiAr04A+1NKfCILQLnwTFsJTw
 lRVUQruT7CSfwCc2cJ2LKYGi325kEZ4NNyjn0UtAMMopoI0WzAE5ZrPqYsCmv/lbWb0c
 z7ZqeM601wal6FC3dk9EhBre/t358GYPWlBkbbUdYNaKqlAK5vqVByIYmyXwX/y93vzO
 bRNWCBb4JkU4DGAkIgbl4WTCvgU7CxcbWXya1+zo+mLJ+4sIWFlH/9XI6s69LnYlT6TH
 Md+EyrgGTL9No0zpG2C/7ZHuO/606d+nruZSCbn/IOzSAExbb+3m94kMbAuqlPQ0irwx
 J8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=cyqKIBrVaRZ0+l7SzJYRtSgO5kugLUClFhe3a16fIks=;
 b=J7Lrbsi9Ou6CdLkQlSVRUiNwbz6wZ7v7knlCNGlDMK6jdnjhUNFzumlmlWWb+Pxe+w
 5HxrU0Dhc7e1LFzwy7oRMym/qVDt/wWshPLFCOF09K7S5BTqn5MdT+jm3rOgWc9K1eUF
 lsMFMRvkxtSCoDFUKK2kPNxCPGQvaydTQqlOaLSh0ZPluqmslhj6dEZrrCYBQZ1l4fpV
 bGutbG/5028sP2qQX/4f1w+WiCfvzCU9tr/eBf0tlpN5RAvQYyHOvAXmKyWPPb63S/dk
 2fI6JVfoxKAyYYpW2JFC8NugDqJrlaggugFgF/jxN/ly1GGIzTkgdschZDb85XjTSIfE
 hxug==
X-Gm-Message-State: AOAM532uMfd/VmmzqQVFm7OVyV8dxRb50y3in0aYToDp7vUiT3R8mePz
 IJBYzJP5SFzNi63B8LxDOeVfH2BOijeTjSBtBAGn
X-Google-Smtp-Source: ABdhPJzi0wHuPmnuk+fERsSUwpHSaQvSPFz85+F584XY7DhSy3CxdOjcgz0J1YNwvp5PC9EH+9a60IN41oTUEUABAxo=
X-Received: by 2002:a17:906:456:: with SMTP id
 e22mr31013766eja.427.1621997023688; 
 Tue, 25 May 2021 19:43:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210517095513.850-1-xieyongji@bytedance.com>
 <20210517095513.850-2-xieyongji@bytedance.com>
 <6ca337fe-2c8c-95c9-672e-0d4f104f66eb@redhat.com>
In-Reply-To: <6ca337fe-2c8c-95c9-672e-0d4f104f66eb@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Wed, 26 May 2021 10:43:33 +0800
Message-ID: <CACycT3sA7jYr1TbBT+Q4wkiiqvk-sJppwzXvffeEUAgBMXOxfA@mail.gmail.com>
Subject: Re: Re: [PATCH v7 01/12] iova: Export alloc_iova_fast()
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

T24gV2VkLCBNYXkgMjYsIDIwMjEgYXQgMTA6MzYgQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4gd3JvdGU6Cj4KPgo+IOWcqCAyMDIxLzUvMTcg5LiL5Y2INTo1NSwgWGllIFlvbmdq
aSDlhpnpgZM6Cj4gPiBFeHBvcnQgYWxsb2NfaW92YV9mYXN0KCkgc28gdGhhdCBzb21lIG1vZHVs
ZXMgY2FuIHVzZSBpdAo+ID4gdG8gaW1wcm92ZSBpb3ZhIGFsbG9jYXRpb24gZWZmaWNpZW5jeS4K
PiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBYaWUgWW9uZ2ppIDx4aWV5b25namlAYnl0ZWRhbmNlLmNv
bT4KPiA+IC0tLQo+ID4gICBkcml2ZXJzL2lvbW11L2lvdmEuYyB8IDEgKwo+ID4gICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21t
dS9pb3ZhLmMgYi9kcml2ZXJzL2lvbW11L2lvdmEuYwo+ID4gaW5kZXggZTZlMmZhODUyNzFjLi4z
MTdlZWY2NGZmZWYgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL2lvbW11L2lvdmEuYwo+ID4gKysr
IGIvZHJpdmVycy9pb21tdS9pb3ZhLmMKPiA+IEBAIC00NTAsNiArNDUwLDcgQEAgYWxsb2NfaW92
YV9mYXN0KHN0cnVjdCBpb3ZhX2RvbWFpbiAqaW92YWQsIHVuc2lnbmVkIGxvbmcgc2l6ZSwKPiA+
Cj4gPiAgICAgICByZXR1cm4gbmV3X2lvdmEtPnBmbl9sbzsKPiA+ICAgfQo+ID4gK0VYUE9SVF9T
WU1CT0xfR1BMKGFsbG9jX2lvdmFfZmFzdCk7Cj4gPgo+ID4gICAvKioKPiA+ICAgICogZnJlZV9p
b3ZhX2Zhc3QgLSBmcmVlIGlvdmEgcGZuIHJhbmdlIGludG8gcmNhY2hlCj4KPgo+IEludGVyZXN0
aW5nLCBkbyB3ZSBuZWVkIGV4cG9ydCBmcmVlX2lvdmFfZmFzdCgpIGFzIHdlbGw/Cj4KCk9oLCB5
ZXMuIEkgbWlzc2VkIHRoaXMgY29tbWl0IDZlMWVhNTBhMDYgKCJpb21tdTogU3RvcCBleHBvcnRp
bmcKZnJlZV9pb3ZhX2Zhc3QoKSIpLiBXaWxsIHJlYmFzZSBvbiB0aGUgbmV3ZXN0IGtlcm5lbCB0
cmVlLgoKVGhhbmtzLApZb25namkKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2lvbW11
