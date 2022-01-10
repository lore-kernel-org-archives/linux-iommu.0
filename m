Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF49C433EF
	for <iommu@archiver.kernel.org>; Mon, 10 Jan 2022 15:24:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3708D60601;
	Mon, 10 Jan 2022 15:24:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cfTUTUf3wXU5; Mon, 10 Jan 2022 15:24:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B356C60C08;
	Mon, 10 Jan 2022 15:24:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8C613C002F;
	Mon, 10 Jan 2022 15:24:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E91DC001E
 for <iommu@lists.linux-foundation.org>; Mon, 10 Jan 2022 15:24:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EC502404C6
 for <iommu@lists.linux-foundation.org>; Mon, 10 Jan 2022 15:24:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jnZjqpFlM9nV for <iommu@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 15:24:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BF700400B9
 for <iommu@lists.linux-foundation.org>; Mon, 10 Jan 2022 15:24:53 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id q25so46361877edb.2
 for <iommu@lists.linux-foundation.org>; Mon, 10 Jan 2022 07:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Uz7H82wmAArl7fSroH8Zwvc58fiFt6Y8AKx2abF1okU=;
 b=yW+xlYWsp6YuKbRVJ3m+8ZOfhN62/bCBbtGssiGCJB8vlf1fAv0dbmlYPvL6q4n+Ea
 nPb7GrWV6e03Us51Tiw2EhBfVxotFJwxe8ZtQa08HUUv60tnVTPhWWvaEQFW4DZ5dHm+
 SJoOAJbZZ3n/1zAoQBhXAQucdvwdl0IxcroWq70ztUJZvuOS/8uwUqrVsodsfoF0E1hv
 KkT+aOwpAdqwmZ65hsJKPH71UZXw90Y0x1r1Kn9zomGyc+azmAot4Nm6wCYXRa5RNsfK
 fIPgCW+NLG+XuYKch8vx+zqTnfLDdhR93vIscfYKJv8Z7zNOWWFcU/OoamlU+GS7G/9j
 sjMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Uz7H82wmAArl7fSroH8Zwvc58fiFt6Y8AKx2abF1okU=;
 b=Z+QKeXC0nCT5wQwCpco0rL+/5V3LanrlsPK4I2XcieIbWEmoZl/80FAiZzF+DvbJ9y
 Hx/EdCcrxn88veohKMOe4GAVWl3XS9LPoC9/9UavVdaNg8k+aoqyZ4RZ+C6962yu0V4s
 0q36DthLjYqn10E44EP4m9icN+Y+f5aGEMNAjdGk8F2FjAGi8/G8Ezs83HBmZwkRfiqt
 PAJtRtZeXniYthE+dh+IUNzvkilkKM7v8fXnR2sAR7Iibbrw4VIxtj+tmmM1OX8t5N8f
 NlP9CxAEPIJ1/xzjWFEKrL2ZgqNgUuDMoWj0cunbhksUWmAs4q4ZEN71XADUd7spK3nt
 7yAw==
X-Gm-Message-State: AOAM5335s2iw0Hs6CR1GPEcAuc0BSH8rf9IuuOISYu6tOsM+wQa3sgIj
 Dd+FsKqa8sJhR5lhTEL2VIg5aQVnZOxV8YCHcD0Z
X-Google-Smtp-Source: ABdhPJxWc7Bx8VLhIHQS3wJbAlcpFOcvxY2PVIQaF1OaZfuWPMRHUePDwW0PsHzzOXUU3GVAxIYcBiOATO+er4Tf/LI=
X-Received: by 2002:a17:907:1b11:: with SMTP id
 mp17mr215607ejc.374.1641828291620; 
 Mon, 10 Jan 2022 07:24:51 -0800 (PST)
MIME-Version: 1.0
References: <20210830141737.181-1-xieyongji@bytedance.com>
 <20220110075546-mutt-send-email-mst@kernel.org>
 <CACycT3v1aEViw7vV4x5qeGVPrSrO-BTDvQshEX35rx_X0Au2vw@mail.gmail.com>
 <20220110100911-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220110100911-mutt-send-email-mst@kernel.org>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Mon, 10 Jan 2022 23:24:40 +0800
Message-ID: <CACycT3v6jo3-8ATWUzf659vV94a2oRrm-zQtGNDZd6OQr-MENA@mail.gmail.com>
Subject: Re: [PATCH v12 00/13] Introduce VDUSE - vDPA Device in Userspace
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm <kvm@vger.kernel.org>, Jason Wang <jasowang@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christian Brauner <christian.brauner@canonical.com>,
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Liu Xiaodong <xiaodong.liu@intel.com>, linux-fsdevel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, Stefan Hajnoczi <stefanha@redhat.com>,
 songmuchun@bytedance.com, Jens Axboe <axboe@kernel.dk>,
 He Zhe <zhe.he@windriver.com>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 bcrl@kvack.org, Netdev <netdev@vger.kernel.org>, Joe Perches <joe@perches.com>,
 Robin Murphy <robin.murphy@arm.com>,
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

T24gTW9uLCBKYW4gMTAsIDIwMjIgYXQgMTE6MTAgUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiBNb24sIEphbiAxMCwgMjAyMiBhdCAwOTo1NDowOFBN
ICswODAwLCBZb25namkgWGllIHdyb3RlOgo+ID4gT24gTW9uLCBKYW4gMTAsIDIwMjIgYXQgODo1
NyBQTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4KPiA+
ID4gT24gTW9uLCBBdWcgMzAsIDIwMjEgYXQgMTA6MTc6MjRQTSArMDgwMCwgWGllIFlvbmdqaSB3
cm90ZToKPiA+ID4gPiBUaGlzIHNlcmllcyBpbnRyb2R1Y2VzIGEgZnJhbWV3b3JrIHRoYXQgbWFr
ZXMgaXQgcG9zc2libGUgdG8gaW1wbGVtZW50Cj4gPiA+ID4gc29mdHdhcmUtZW11bGF0ZWQgdkRQ
QSBkZXZpY2VzIGluIHVzZXJzcGFjZS4gQW5kIHRvIG1ha2UgdGhlIGRldmljZQo+ID4gPiA+IGVt
dWxhdGlvbiBtb3JlIHNlY3VyZSwgdGhlIGVtdWxhdGVkIHZEUEEgZGV2aWNlJ3MgY29udHJvbCBw
YXRoIGlzIGhhbmRsZWQKPiA+ID4gPiBpbiB0aGUga2VybmVsIGFuZCBvbmx5IHRoZSBkYXRhIHBh
dGggaXMgaW1wbGVtZW50ZWQgaW4gdGhlIHVzZXJzcGFjZS4KPiA+ID4gPgo+ID4gPiA+IFNpbmNl
IHRoZSBlbXVsZGF0ZWQgdkRQQSBkZXZpY2UncyBjb250cm9sIHBhdGggaXMgaGFuZGxlZCBpbiB0
aGUga2VybmVsLAo+ID4gPiA+IGEgbWVzc2FnZSBtZWNobmlzbSBpcyBpbnRyb2R1Y2VkIHRvIG1h
a2UgdXNlcnNwYWNlIGJlIGF3YXJlIG9mIHRoZSBkYXRhCj4gPiA+ID4gcGF0aCByZWxhdGVkIGNo
YW5nZXMuIFVzZXJzcGFjZSBjYW4gdXNlIHJlYWQoKS93cml0ZSgpIHRvIHJlY2VpdmUvcmVwbHkK
PiA+ID4gPiB0aGUgY29udHJvbCBtZXNzYWdlcy4KPiA+ID4gPgo+ID4gPiA+IEluIHRoZSBkYXRh
IHBhdGgsIHRoZSBjb3JlIGlzIG1hcHBpbmcgZG1hIGJ1ZmZlciBpbnRvIFZEVVNFIGRhZW1vbidz
Cj4gPiA+ID4gYWRkcmVzcyBzcGFjZSwgd2hpY2ggY2FuIGJlIGltcGxlbWVudGVkIGluIGRpZmZl
cmVudCB3YXlzIGRlcGVuZGluZyBvbgo+ID4gPiA+IHRoZSB2ZHBhIGJ1cyB0byB3aGljaCB0aGUg
dkRQQSBkZXZpY2UgaXMgYXR0YWNoZWQuCj4gPiA+ID4KPiA+ID4gPiBJbiB2aXJ0aW8tdmRwYSBj
YXNlLCB3ZSBpbXBsZW1lbnRzIGEgTU1VLWJhc2VkIHNvZnR3YXJlIElPVExCIHdpdGgKPiA+ID4g
PiBib3VuY2UtYnVmZmVyaW5nIG1lY2hhbmlzbSB0byBhY2hpZXZlIHRoYXQuIEFuZCBpbiB2aG9z
dC12ZHBhIGNhc2UsIHRoZSBkbWEKPiA+ID4gPiBidWZmZXIgaXMgcmVzaWRlIGluIGEgdXNlcnNw
YWNlIG1lbW9yeSByZWdpb24gd2hpY2ggY2FuIGJlIHNoYXJlZCB0byB0aGUKPiA+ID4gPiBWRFVT
RSB1c2Vyc3BhY2UgcHJvY2Vzc3MgdmlhIHRyYW5zZmVycmluZyB0aGUgc2htZmQuCj4gPiA+ID4K
PiA+ID4gPiBUaGUgZGV0YWlscyBhbmQgb3VyIHVzZXIgY2FzZSBpcyBzaG93biBiZWxvdzoKPiA+
ID4gPgo+ID4gPiA+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSAgICAtLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tICAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQo+ID4gPiA+IHwgICAgICAgICAgICBDb250YWluZXIgfCAgICB8ICAgICAgICAgICAgICBRRU1V
KFZNKSB8ICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBWRFVTRSBkYWVtb24gfAo+
ID4gPiA+IHwgICAgICAgLS0tLS0tLS0tICAgICAgfCAgICB8ICAtLS0tLS0tLS0tLS0tLS0tLS0t
ICB8ICAgfCAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tIC0tLS0tLS0tLS0tLS0tLS0gfAo+ID4g
PiA+IHwgICAgICAgfGRldi92ZHh8ICAgICAgfCAgICB8ICB8L2Rldi92aG9zdC12ZHBhLXh8ICB8
ICAgfCB8IHZEUEEgZGV2aWNlIGVtdWxhdGlvbiB8IHwgYmxvY2sgZHJpdmVyIHwgfAo+ID4gPiA+
IC0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLSAgICAgLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tICAg
LS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLQo+ID4gPiA+ICAg
ICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgfAo+ID4gPiA+ICAgICAgICAgICAgIHwg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
ICAgICAgICAgICAgICAgICAgICAgfAo+ID4gPiA+IC0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0t
LS0tLS0tLS0tKy0tLS0tLS0tLQo+ID4gPiA+IHwgICAgfCBibG9jayBkZXZpY2UgfCAgICAgICAg
ICAgfCAgdmhvc3QgZGV2aWNlIHwgICAgICAgICAgICB8IHZkdXNlIGRyaXZlciB8ICAgICAgICAg
IHwgVENQL0lQIHwgICAgfAo+ID4gPiA+IHwgICAgLS0tLS0tLSstLS0tLS0tLSAgICAgICAgICAg
LS0tLS0tLS0rLS0tLS0tLS0gICAgICAgICAgICAtLS0tLS0tKy0tLS0tLS0tICAgICAgICAgIC0t
LS0tKy0tLS0gICAgfAo+ID4gPiA+IHwgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAg
fCAgICAgICAgfAo+ID4gPiA+IHwgLS0tLS0tLS0tLSstLS0tLS0tLS0tICAgICAgIC0tLS0tLS0t
LS0rLS0tLS0tLS0tLS0gICAgICAgICAtLS0tLS0tKy0tLS0tLS0gICAgICAgICAgICAgICAgfCAg
ICAgICAgfAo+ID4gPiA+IHwgfCB2aXJ0aW8tYmxrIGRyaXZlciB8ICAgICAgIHwgIHZob3N0LXZk
cGEgZHJpdmVyIHwgICAgICAgICB8IHZkcGEgZGV2aWNlIHwgICAgICAgICAgICAgICAgfCAgICAg
ICAgfAo+ID4gPiA+IHwgLS0tLS0tLS0tLSstLS0tLS0tLS0tICAgICAgIC0tLS0tLS0tLS0rLS0t
LS0tLS0tLS0gICAgICAgICAtLS0tLS0tKy0tLS0tLS0gICAgICAgICAgICAgICAgfCAgICAgICAg
fAo+ID4gPiA+IHwgICAgICAgICAgIHwgICAgICB2aXJ0aW8gYnVzICAgICAgICAgICB8ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgfAo+
ID4gPiA+IHwgICAtLS0tLS0tLSstLS0tKy0tLS0tLS0tLS0tICAgICAgICAgICB8ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgfAo+ID4g
PiA+IHwgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgfAo+ID4gPiA+
IHwgICAgICAtLS0tLS0tLS0tKy0tLS0tLS0tLS0gICAgICAgICAgICB8ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgfAo+ID4gPiA+IHwg
ICAgICB8IHZpcnRpby1ibGsgZGV2aWNlIHwgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgfAo+ID4gPiA+IHwgICAg
ICAtLS0tLS0tLS0tKy0tLS0tLS0tLS0gICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgfAo+ID4gPiA+IHwgICAgICAg
ICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgfAo+ID4gPiA+IHwgICAgIC0tLS0t
LS0tLS0tKy0tLS0tLS0tLS0tICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAg
fCAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgfAo+ID4gPiA+IHwgICAgIHwgIHZpcnRp
by12ZHBhIGRyaXZlciB8ICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
ICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgfAo+ID4gPiA+IHwgICAgIC0tLS0tLS0tLS0t
Ky0tLS0tLS0tLS0tICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAg
ICAgICAgICAgICAgICAgICAgfCAgICAgICAgfAo+ID4gPiA+IHwgICAgICAgICAgICAgICAgfCAg
ICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICB2ZHBh
IGJ1cyAgICAgICAgICAgfCAgICAgICAgfAo+ID4gPiA+IHwgICAgIC0tLS0tLS0tLS0tKy0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0t
LSAgICAgICAgICAgfCAgICAgICAgfAo+ID4gPiA+IHwgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgLS0tKy0tLSAgICAgfAo+ID4gPiA+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tfCBOSUMgfC0tLS0tLQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
LS0tKy0tLQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfAo+ID4g
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0tLS0tLS0tKy0tLS0tLS0tLQo+ID4gPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCBSZW1vdGUgU3RvcmFnZXMgfAo+ID4gPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgLS0tLS0tLS0tLS0tLS0tLS0tLQo+ID4gPiA+Cj4gPiA+
ID4gV2UgbWFrZSB1c2Ugb2YgaXQgdG8gaW1wbGVtZW50IGEgYmxvY2sgZGV2aWNlIGNvbm5lY3Rp
bmcgdG8KPiA+ID4gPiBvdXIgZGlzdHJpYnV0ZWQgc3RvcmFnZSwgd2hpY2ggY2FuIGJlIHVzZWQg
Ym90aCBpbiBjb250YWluZXJzIGFuZAo+ID4gPiA+IFZNcy4gVGh1cywgd2UgY2FuIGhhdmUgYW4g
dW5pZmllZCB0ZWNobm9sb2d5IHN0YWNrIGluIHRoaXMgdHdvIGNhc2VzLgo+ID4gPiA+Cj4gPiA+
ID4gVG8gdGVzdCBpdCB3aXRoIG51bGwtYmxrOgo+ID4gPiA+Cj4gPiA+ID4gICAkIHFlbXUtc3Rv
cmFnZS1kYWVtb24gXAo+ID4gPiA+ICAgICAgIC0tY2hhcmRldiBzb2NrZXQsaWQ9Y2hhcm1vbml0
b3IscGF0aD0vdG1wL3FtcC5zb2NrLHNlcnZlcixub3dhaXQgXAo+ID4gPiA+ICAgICAgIC0tbW9u
aXRvciBjaGFyZGV2PWNoYXJtb25pdG9yIFwKPiA+ID4gPiAgICAgICAtLWJsb2NrZGV2IGRyaXZl
cj1ob3N0X2RldmljZSxjYWNoZS5kaXJlY3Q9b24sYWlvPW5hdGl2ZSxmaWxlbmFtZT0vZGV2L251
bGxiMCxub2RlLW5hbWU9ZGlzazAgXAo+ID4gPiA+ICAgICAgIC0tZXhwb3J0IHR5cGU9dmR1c2Ut
YmxrLGlkPXRlc3Qsbm9kZS1uYW1lPWRpc2swLHdyaXRhYmxlPW9uLG5hbWU9dmR1c2UtbnVsbCxu
dW0tcXVldWVzPTE2LHF1ZXVlLXNpemU9MTI4Cj4gPiA+ID4KPiA+ID4gPiBUaGUgcWVtdS1zdG9y
YWdlLWRhZW1vbiBjYW4gYmUgZm91bmQgYXQgaHR0cHM6Ly9naXRodWIuY29tL2J5dGVkYW5jZS9x
ZW11L3RyZWUvdmR1c2UKPiA+ID4KPiA+ID4gSXQncyBiZWVuIGhhbGYgYSB5ZWFyIC0gYW55IHBs
YW5zIHRvIHVwc3RyZWFtIHRoaXM/Cj4gPgo+ID4gWWVhaCwgdGhpcyBpcyBvbiBteSB0by1kbyBs
aXN0IHRoaXMgbW9udGguCj4gPgo+ID4gU29ycnkgZm9yIHRha2luZyBzbyBsb25nLi4uIEkndmUg
YmVlbiB3b3JraW5nIG9uIGFub3RoZXIgcHJvamVjdAo+ID4gZW5hYmxpbmcgdXNlcnNwYWNlIFJE
TUEgd2l0aCBWRFVTRSBmb3IgdGhlIHBhc3QgZmV3IG1vbnRocy4gU28gSQo+ID4gZGlkbid0IGhh
dmUgbXVjaCB0aW1lIGZvciB0aGlzLiBBbnl3YXksIEkgd2lsbCBzdWJtaXQgdGhlIGZpcnN0Cj4g
PiB2ZXJzaW9uIGFzIHNvb24gYXMgcG9zc2libGUuCj4gPgo+ID4gVGhhbmtzLAo+ID4gWW9uZ2pp
Cj4KPiBPaCBmdW4uIFlvdSBtZWFuIGxpa2UgdmlydGlvLXJkbWE/IE9yIFJETUEgYXMgYSBiYWNr
ZW5kIGZvciByZWd1bGFyCj4gdmlydGlvPwo+CgpZZXMsIGxpa2UgdmlydGlvLXJkbWEuIFRoZW4g
d2UgY2FuIGRldmVsb3Agc29tZXRoaW5nIGxpa2UgdXNlcnNwYWNlCnJ4ZeOAgXNpdyBvciBjdXN0
b20gcHJvdG9jb2wgd2l0aCBWRFVTRS4KClRoYW5rcywKWW9uZ2ppCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
