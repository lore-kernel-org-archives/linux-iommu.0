Return-Path: <SRS0=qwh6=M2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FB9C4320A
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 09:31:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D68A60F94
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 09:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1D68A60F94
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D9F0A82BED;
	Tue,  3 Aug 2021 09:31:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4_r6bd3UaMry; Tue,  3 Aug 2021 09:31:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DB52582C38;
	Tue,  3 Aug 2021 09:31:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B0C9C001A;
	Tue,  3 Aug 2021 09:31:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4A13C000E
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 09:31:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CB51D40257
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 09:31:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vNNONsgXto3U for <iommu@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 09:31:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BE74640248
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 09:31:33 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id f13so28090740edq.13
 for <iommu@lists.linux-foundation.org>; Tue, 03 Aug 2021 02:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=XnFT0+T34CYtIhtj9AFRhRgp0BmU14hBeulSmSMqkco=;
 b=lnh5e5rtm1i3OI43NQE8IstmfTWykpBHTHoQHdfbzzsQX7nlQoH6dmaIGzGDt/3IpX
 hVaLY2SyXmPXkpBBd9scceDJf/zBQ4A76NX2+7ALhUhIU4ZBFN+VFm3yT5ahwH3xFnI5
 e4JmTQu0w1sKOfhaBUWL7fjXF1tZIaQNk1baawfU+UMg2Icf5373OPJbGCHz6/DLMbMX
 WiHewdxY/zEYYxZs2QOJhCw6f774C+Tq2heA/u+W2YvusHjifhzWyPmdNcLd7MathYyr
 f4iT9bjGEC8A90IGAxotEqF8N9hdUVOFaJEcIDHz/CheJ4AdYPep42urz4UhJ0ASDRKH
 BIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=XnFT0+T34CYtIhtj9AFRhRgp0BmU14hBeulSmSMqkco=;
 b=t5q9acn1wmoMubwAjkpYnNgFkfGnL5tcT9fxO8Epn/3Yeu8MTBcfPqsrpU9TKXbb6a
 e+YMmj30n1Eb5yEBEISB5j0Lcis/4ckXI/o4Wg1Tf/yYV5sqy8mhC+TBrHAyaIleY0bI
 3NTzmK4gZM31tEcqbT1kl7GU2ofWFcEtBOkueDgnGgGwdE659P+8x44WFPH30IMG40yZ
 swZ7Glg3a3OVkTPMDKavl8iXvohjUFpbGzHw3OGje0Onlw5T5NZuPGQVL/7w457ZRxFn
 WqA4GOYYS/+6ISvzv1Myf7QodDniETlsrXEEnC3DHadJNFytuxB+g9/0Ffk7oybjIX4x
 VmEg==
X-Gm-Message-State: AOAM531qPQjzN25EamWchZoJqBZJRU7HfAiYpS5EEEd1JbiNrRg2cg6g
 LmKy7v2T789eFaBYFEFjOMAJEIQI04ATFNmexDyO
X-Google-Smtp-Source: ABdhPJy+LxOFqB8YD73zckkZYLMc9dK6jQxb/4DjwmZe9c1z6ZeWREgaWSDzSR2aIdoSx6+rDpaFnlN8W0AAfJNPoJw=
X-Received: by 2002:a05:6402:74f:: with SMTP id
 p15mr24038732edy.195.1627983091785; 
 Tue, 03 Aug 2021 02:31:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210729073503.187-1-xieyongji@bytedance.com>
 <20210729073503.187-5-xieyongji@bytedance.com>
 <39a191f6-555b-d2e6-e712-735b540526d0@redhat.com>
In-Reply-To: <39a191f6-555b-d2e6-e712-735b540526d0@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Tue, 3 Aug 2021 17:31:20 +0800
Message-ID: <CACycT3sdH3zVzznsaMb0+3mzrLF7FjmB89U11fZv_23Y4_WbEw@mail.gmail.com>
Subject: Re: [PATCH v10 04/17] vdpa: Fail the vdpa_reset() if fail to set
 device status to zero
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

T24gVHVlLCBBdWcgMywgMjAyMSBhdCAzOjU4IFBNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhh
dC5jb20+IHdyb3RlOgo+Cj4KPiDlnKggMjAyMS83LzI5IOS4i+WNiDM6MzQsIFhpZSBZb25namkg
5YaZ6YGTOgo+ID4gUmUtcmVhZCB0aGUgZGV2aWNlIHN0YXR1cyB0byBlbnN1cmUgaXQncyBzZXQg
dG8gemVybyBkdXJpbmcKPiA+IHJlc2V0dGluZy4gT3RoZXJ3aXNlLCBmYWlsIHRoZSB2ZHBhX3Jl
c2V0KCkgYWZ0ZXIgdGltZW91dC4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBYaWUgWW9uZ2ppIDx4
aWV5b25namlAYnl0ZWRhbmNlLmNvbT4KPiA+IC0tLQo+ID4gICBpbmNsdWRlL2xpbnV4L3ZkcGEu
aCB8IDE1ICsrKysrKysrKysrKysrLQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3Zk
cGEuaCBiL2luY2x1ZGUvbGludXgvdmRwYS5oCj4gPiBpbmRleCA0MDZkNTNhNjA2YWMuLmQxYTgw
ZWYwNTA4OSAxMDA2NDQKPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvdmRwYS5oCj4gPiArKysgYi9p
bmNsdWRlL2xpbnV4L3ZkcGEuaAo+ID4gQEAgLTYsNiArNiw3IEBACj4gPiAgICNpbmNsdWRlIDxs
aW51eC9kZXZpY2UuaD4KPiA+ICAgI2luY2x1ZGUgPGxpbnV4L2ludGVycnVwdC5oPgo+ID4gICAj
aW5jbHVkZSA8bGludXgvdmhvc3RfaW90bGIuaD4KPiA+ICsjaW5jbHVkZSA8bGludXgvZGVsYXku
aD4KPiA+Cj4gPiAgIC8qKgo+ID4gICAgKiBzdHJ1Y3QgdmRwYV9jYWxsbGJhY2sgLSB2RFBBIGNh
bGxiYWNrIGRlZmluaXRpb24uCj4gPiBAQCAtMzQwLDEyICszNDEsMjQgQEAgc3RhdGljIGlubGlu
ZSBzdHJ1Y3QgZGV2aWNlICp2ZHBhX2dldF9kbWFfZGV2KHN0cnVjdCB2ZHBhX2RldmljZSAqdmRl
dikKPiA+ICAgICAgIHJldHVybiB2ZGV2LT5kbWFfZGV2Owo+ID4gICB9Cj4gPgo+ID4gLXN0YXRp
YyBpbmxpbmUgdm9pZCB2ZHBhX3Jlc2V0KHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldikKPiA+ICsj
ZGVmaW5lIFZEUEFfUkVTRVRfVElNRU9VVF9NUyAxMDAwCj4gPiArCj4gPiArc3RhdGljIGlubGlu
ZSBpbnQgdmRwYV9yZXNldChzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYpCj4gPiAgIHsKPiA+ICAg
ICAgIGNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgKm9wcyA9IHZkZXYtPmNvbmZpZzsKPiA+
ICsgICAgIGludCB0aW1lb3V0ID0gMDsKPiA+Cj4gPiAgICAgICB2ZGV2LT5mZWF0dXJlc192YWxp
ZCA9IGZhbHNlOwo+ID4gICAgICAgb3BzLT5zZXRfc3RhdHVzKHZkZXYsIDApOwo+ID4gKyAgICAg
d2hpbGUgKG9wcy0+Z2V0X3N0YXR1cyh2ZGV2KSkgewo+ID4gKyAgICAgICAgICAgICB0aW1lb3V0
ICs9IDIwOwo+ID4gKyAgICAgICAgICAgICBpZiAodGltZW91dCA+IFZEUEFfUkVTRVRfVElNRU9V
VF9NUykKPiA+ICsgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTzsKPiA+ICsKPiA+ICsg
ICAgICAgICAgICAgbXNsZWVwKDIwKTsKPiA+ICsgICAgIH0KPgo+Cj4gSSB3b25kZXIgaWYgaXQn
cyBiZXR0ZXIgdG8gZG8gdGhpcyBpbiB0aGUgdkRQQSBwYXJlbnQ/Cj4KPiBUaGFua3MKPgoKU29y
cnksIEkgZGlkbid0IGdldCB5b3UgaGVyZS4gRG8geW91IG1lYW4gdkRQQSBwYXJlbnQgZHJpdmVy
IChlLmcuClZEVVNFKT8gQWN0dWFsbHkgSSBkaWRuJ3QgZmluZCBhbnkgb3RoZXIgcGxhY2Ugd2hl
cmUgSSBjYW4gZG8Kc2V0X3N0YXR1cygpIGFuZCBnZXRfc3RhdHVzKCkuCgpUaGFua3MsCllvbmdq
aQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBt
YWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
