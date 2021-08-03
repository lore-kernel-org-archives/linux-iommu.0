Return-Path: <SRS0=qwh6=M2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2964C4320E
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 09:51:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 704E760FC2
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 09:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 704E760FC2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 312C9605A8;
	Tue,  3 Aug 2021 09:51:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kN99HLlGzqJW; Tue,  3 Aug 2021 09:51:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1E6D2605A3;
	Tue,  3 Aug 2021 09:51:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0B27C001A;
	Tue,  3 Aug 2021 09:51:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3533C000E
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 09:50:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9058D82BD6
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 09:50:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X6-L65o1j_Yl for <iommu@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 09:50:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 71FC582B75
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 09:50:57 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id y12so28235252edo.6
 for <iommu@lists.linux-foundation.org>; Tue, 03 Aug 2021 02:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=jILE4iG7Hf5kzSZ86WpBt9OleoKnKxcD0AIYcg4CDWg=;
 b=UYLK3kL70/wbKlpjOzW8UaU540qw0H/BDGz2GAidxIH+0Tbdq0r3XuevQhcMlSwF58
 U+YHGLL8f22QDEunPk9DqMq1eT1/Yz2ExXO9GDS/ufNbqgnesYijDgUYNyUBGpqkPBK0
 jc6z0LopU31KIzZFUVhnBr86QNVcAec5ZQBL5MTDd8HrrSV4ZRwjz36IsOtuGmnH5X6A
 jYcjFh70UmazEs1b8oePF1wJDVsQ8glRQ/glBwJR4GBZ9yTuI1WAaizqZ05szzG1Ixmq
 2ctXvL00wRUev+FoavAHzmKe4yzO/7Bj+vNrO7PmMnz9qL1uqQVTrFk5IPvZ//M0qMCj
 v22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=jILE4iG7Hf5kzSZ86WpBt9OleoKnKxcD0AIYcg4CDWg=;
 b=ouqKEavBYvyHcVydmuvhkgmIxtHGqVsrHIy5eWY2Rl/EDxurMcEQewCc5EcXt7hrIw
 a5xO2ZwCSEcKn4B50gN4jva529wyOEwoHAqj5bRrT5w6NFcSeAFSgOKA+ksPrdn90oay
 ZWX1Q8zUheTz0c9VG7lSDzLELGZABNUxvDn0A53h40eqtM/HR7jc6fO6yspxl98Rs5yy
 rsg8ji9+uWX0aBQ5tJstQ8rIZMXUkD86sBgPq0MXVoQEW56RXghWzlrAnQgsomQPB4MG
 ZVfHfkypnxOGkd7j6hQ9s/+0fyDobPMPQu97M10ldNt4FvzQvgk69cb5MGzIXg9rAAa1
 Wq2g==
X-Gm-Message-State: AOAM533AM2nKXHWo1ST8fvepT4nnZgYrlCAMK9Bc7sZL4b0hav1XPfBj
 CtN/tGh9T2LktucSqL/YLKZmGYi5PvFfZ6BG3LTL
X-Google-Smtp-Source: ABdhPJy97k/uCbx6CjOrhsXKJtmjljacfy1qGYT4R+qrgPXqN+DQqG/xN8Jl5mhRS2KKa0ZWZzj3JvoQucqDWlc+mNo=
X-Received: by 2002:a05:6402:18c1:: with SMTP id
 x1mr24603324edy.145.1627984255528; 
 Tue, 03 Aug 2021 02:50:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210729073503.187-1-xieyongji@bytedance.com>
 <20210729073503.187-6-xieyongji@bytedance.com>
 <55191de0-1a03-ff0d-1a49-afc419014bab@redhat.com>
In-Reply-To: <55191de0-1a03-ff0d-1a49-afc419014bab@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Tue, 3 Aug 2021 17:50:44 +0800
Message-ID: <CACycT3sfiFizYQckHi5k4MpVpOOQCEwJhC-cToAnXaBVHTDPQQ@mail.gmail.com>
Subject: Re: [PATCH v10 05/17] vhost-vdpa: Fail the vhost_vdpa_set_status() on
 reset failure
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

T24gVHVlLCBBdWcgMywgMjAyMSBhdCA0OjEwIFBNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhh
dC5jb20+IHdyb3RlOgo+Cj4KPiDlnKggMjAyMS83LzI5IOS4i+WNiDM6MzQsIFhpZSBZb25namkg
5YaZ6YGTOgo+ID4gUmUtcmVhZCB0aGUgZGV2aWNlIHN0YXR1cyB0byBlbnN1cmUgaXQncyBzZXQg
dG8gemVybyBkdXJpbmcKPiA+IHJlc2V0dGluZy4gT3RoZXJ3aXNlLCBmYWlsIHRoZSB2aG9zdF92
ZHBhX3NldF9zdGF0dXMoKSBhZnRlciB0aW1lb3V0Lgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IFhp
ZSBZb25namkgPHhpZXlvbmdqaUBieXRlZGFuY2UuY29tPgo+ID4gLS0tCj4gPiAgIGRyaXZlcnMv
dmhvc3QvdmRwYS5jIHwgMTEgKysrKysrKysrKy0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEwIGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92
aG9zdC92ZHBhLmMgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+ID4gaW5kZXggYjA3YWExNjFmN2Fk
Li5kZDA1YzFlMTEzM2MgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+ID4g
KysrIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPiA+IEBAIC0xNTcsNyArMTU3LDcgQEAgc3RhdGlj
IGxvbmcgdmhvc3RfdmRwYV9zZXRfc3RhdHVzKHN0cnVjdCB2aG9zdF92ZHBhICp2LCB1OCBfX3Vz
ZXIgKnN0YXR1c3ApCj4gPiAgICAgICBzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEgPSB2LT52ZHBh
Owo+ID4gICAgICAgY29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyAqb3BzID0gdmRwYS0+Y29u
ZmlnOwo+ID4gICAgICAgdTggc3RhdHVzLCBzdGF0dXNfb2xkOwo+ID4gLSAgICAgaW50IG52cXMg
PSB2LT5udnFzOwo+ID4gKyAgICAgaW50IHRpbWVvdXQgPSAwLCBudnFzID0gdi0+bnZxczsKPiA+
ICAgICAgIHUxNiBpOwo+ID4KPiA+ICAgICAgIGlmIChjb3B5X2Zyb21fdXNlcigmc3RhdHVzLCBz
dGF0dXNwLCBzaXplb2Yoc3RhdHVzKSkpCj4gPiBAQCAtMTczLDYgKzE3MywxNSBAQCBzdGF0aWMg
bG9uZyB2aG9zdF92ZHBhX3NldF9zdGF0dXMoc3RydWN0IHZob3N0X3ZkcGEgKnYsIHU4IF9fdXNl
ciAqc3RhdHVzcCkKPiA+ICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7Cj4gPgo+ID4gICAg
ICAgb3BzLT5zZXRfc3RhdHVzKHZkcGEsIHN0YXR1cyk7Cj4gPiArICAgICBpZiAoc3RhdHVzID09
IDApIHsKPiA+ICsgICAgICAgICAgICAgd2hpbGUgKG9wcy0+Z2V0X3N0YXR1cyh2ZHBhKSkgewo+
ID4gKyAgICAgICAgICAgICAgICAgICAgIHRpbWVvdXQgKz0gMjA7Cj4gPiArICAgICAgICAgICAg
ICAgICAgICAgaWYgKHRpbWVvdXQgPiBWRFBBX1JFU0VUX1RJTUVPVVRfTVMpCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTzsKPiA+ICsKPiA+ICsgICAgICAgICAg
ICAgICAgICAgICBtc2xlZXAoMjApOwo+ID4gKyAgICAgICAgICAgICB9Cj4KPgo+IFNwZWMgaGFz
IGludHJvZHVjZWQgdGhlIHJlc2V0IGEgb25lIG9mIHRoZSBiYXNpYyBmYWNpbGl0eS4gQW5kIGNv
bnNpZGVyCj4gd2UgZGlmZmVyIHJlc2V0IGhlcmUuCj4KPiBUaGlzIG1ha2VzIG1lIHRoaW5rIGlm
IGl0J3MgYmV0dGVyIHRvIGludHJvZHVjZSBhIGRlZGljYXRlZCB2ZHBhIG9wcyBmb3IKPiByZXNl
dD8KPgoKRG8geW91IG1lYW4gcmVwbGFjZSB0aGUgb3BzLnNldF9zdGF0dXModmRldiwgMCkgd2l0
aCB0aGUgb3BzLnJlc2V0KCk/ClRoZW4gd2UgY2FuIHJlbW92ZSB0aGUgdGltZW91dCBwcm9jZXNz
aW5nIHdoaWNoIGlzIGRldmljZSBzcGVjaWZpYwpzdHVmZi4KClRoYW5rcywKWW9uZ2ppCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcg
bGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
