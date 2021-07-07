Return-Path: <SRS0=iPMr=L7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674EFC07E95
	for <iommu@archiver.kernel.org>; Wed,  7 Jul 2021 09:09:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E89F761CBF
	for <iommu@archiver.kernel.org>; Wed,  7 Jul 2021 09:09:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E89F761CBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B676440179;
	Wed,  7 Jul 2021 09:09:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R8S7uBi-Ubly; Wed,  7 Jul 2021 09:09:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7286A40140;
	Wed,  7 Jul 2021 09:09:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 563F1C0010;
	Wed,  7 Jul 2021 09:09:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F773C000E
 for <iommu@lists.linux-foundation.org>; Wed,  7 Jul 2021 09:09:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F40A240382
 for <iommu@lists.linux-foundation.org>; Wed,  7 Jul 2021 09:09:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KILHfX10k6KJ for <iommu@lists.linux-foundation.org>;
 Wed,  7 Jul 2021 09:09:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8BE294035C
 for <iommu@lists.linux-foundation.org>; Wed,  7 Jul 2021 09:09:26 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id y40so2458465ede.4
 for <iommu@lists.linux-foundation.org>; Wed, 07 Jul 2021 02:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=FtdRj0uqhbWYJv1fXc78UI5Oym+NbdH9ODlpZg+9HZI=;
 b=UP2gxo7E+OXts94W4XG8ov25acIgy16F7Xuv5WNUryBRLvnB1SUdOumUACfAPoJmFS
 52RE8R7P3qzg1tarx6KjKAKEHb0Dj5puUCLSt4CliZJpugu/J1PeSwvG09Sv8SfFplGU
 DBap5eLBxTmFKW9K2PAgbKQ4UW5jIafViUeCgIHHk0GQV9Tv4AoOXsa2pQcvvdtk0UEk
 qzg8jcE6bFOHgPnYLfHRZZTw0XzS/1JMmDSF7Xh2WYY8wHkQJK4LhvVclPWJCWFgWaoK
 6TQcVcEEhAqleM8ofZK+PMsZBBDsQDwSyML/MSyfSeinKDg97GhQwRNlPXflVJHElUst
 mqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=FtdRj0uqhbWYJv1fXc78UI5Oym+NbdH9ODlpZg+9HZI=;
 b=RSYwP0589yPL6FKqcGw1FRSV5VLgv+pkZkCxDl1E76KT+YaLmAGk1sj8DOYhiNcg9d
 hcywRdcvfGp7s1+bFQfvpijrJEDoQ1cI/fTLESwWTNtX2Fbg22gK+ZeD6eC5PlkBi94f
 Mxa3HqADscAXp4hQB0jlIytWpE2jNh6uvf2IHWYOzEHOKVTZ8NWdm3kWslvs9In+Ehby
 2SHso8fxI9/u1QorcfnykkJbySQoslSlzaUtlW861L5faY/2a/YrfnvcAwi1RS+6NCU2
 9yJXr1FpLQmsN/1x1L/5FSiI1KdOVJoLanlNYnn66sKbaIIr1nLLqM4o33h70HY+VftL
 YgRQ==
X-Gm-Message-State: AOAM533/ER/U2MOrMcNI6VPfs35I8fgDXHz6IxaFyRk1YuDVymyrhIRq
 0EHFoyh4AcJuxtaFumgay3A2YVeUktWtpRownxo/
X-Google-Smtp-Source: ABdhPJwtLvo0kWOr3LJJHVAL2cWB4hYaaS7KjefICks1FsWVhmQrnAQXN0teABT1P1UQsj+keI5UW3/FiAWPPwjYY38=
X-Received: by 2002:a05:6402:31ae:: with SMTP id
 dj14mr23195138edb.145.1625648964822; 
 Wed, 07 Jul 2021 02:09:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210615141331.407-11-xieyongji@bytedance.com>
 <YNSCH6l31zwPxBjL@stefanha-x1.localdomain>
 <CACycT3uxnQmXWsgmNVxQtiRhz1UXXTAJFY3OiAJqokbJH6ifMA@mail.gmail.com>
 <YNxCDpM3bO5cPjqi@stefanha-x1.localdomain>
 <CACycT3taKhf1cWp3Jd0aSVekAZvpbR-_fkyPLQ=B+jZBB5H=8Q@mail.gmail.com>
 <YN3ABqCMLQf7ejOm@stefanha-x1.localdomain>
 <CACycT3vo-diHgTSLw_FS2E+5ia5VjihE3qw7JmZR7JT55P-wQA@mail.gmail.com>
 <8320d26d-6637-85c6-8773-49553dfa502d@redhat.com>
 <YOL/9mxkJaokKDHc@stefanha-x1.localdomain>
 <CACycT3t-BTMrpNTwBUfbvaxTh6tLthxbo3OJwMk_iuiSpMuZPg@mail.gmail.com>
 <YOQu8dB6tlb9juNz@stefanha-x1.localdomain>
In-Reply-To: <YOQu8dB6tlb9juNz@stefanha-x1.localdomain>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Wed, 7 Jul 2021 17:09:13 +0800
Message-ID: <CACycT3t=V-VV7LYDda8mt=QxN_Ay-N+3dgWp382TObkeei9MOg@mail.gmail.com>
Subject: Re: [PATCH v8 10/10] Documentation: Add documentation for VDUSE
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christian Brauner <christian.brauner@canonical.com>,
 Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
 Christoph Hellwig <hch@infradead.org>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
 songmuchun@bytedance.com, Jens Axboe <axboe@kernel.dk>,
 Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
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

T24gVHVlLCBKdWwgNiwgMjAyMSBhdCA2OjIyIFBNIFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiBUdWUsIEp1bCAwNiwgMjAyMSBhdCAxMTowNDoxOEFN
ICswODAwLCBZb25namkgWGllIHdyb3RlOgo+ID4gT24gTW9uLCBKdWwgNSwgMjAyMSBhdCA4OjUw
IFBNIFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+Cj4g
PiA+IE9uIE1vbiwgSnVsIDA1LCAyMDIxIGF0IDExOjM2OjE1QU0gKzA4MDAsIEphc29uIFdhbmcg
d3JvdGU6Cj4gPiA+ID4KPiA+ID4gPiDlnKggMjAyMS83LzQg5LiL5Y2INTo0OSwgWW9uZ2ppIFhp
ZSDlhpnpgZM6Cj4gPiA+ID4gPiA+ID4gT0ssIEkgZ2V0IHlvdSBub3cuIFNpbmNlIHRoZSBWSVJU
SU8gc3BlY2lmaWNhdGlvbiBzYXlzICJEZXZpY2UKPiA+ID4gPiA+ID4gPiBjb25maWd1cmF0aW9u
IHNwYWNlIGlzIGdlbmVyYWxseSB1c2VkIGZvciByYXJlbHktY2hhbmdpbmcgb3IKPiA+ID4gPiA+
ID4gPiBpbml0aWFsaXphdGlvbi10aW1lIHBhcmFtZXRlcnMiLiBJIGFzc3VtZSB0aGUgVkRVU0Vf
REVWX1NFVF9DT05GSUcKPiA+ID4gPiA+ID4gPiBpb2N0bCBzaG91bGQgbm90IGJlIGNhbGxlZCBm
cmVxdWVudGx5Lgo+ID4gPiA+ID4gPiBUaGUgc3BlYyB1c2VzIE1VU1QgYW5kIG90aGVyIHRlcm1z
IHRvIGRlZmluZSB0aGUgcHJlY2lzZSByZXF1aXJlbWVudHMuCj4gPiA+ID4gPiA+IEhlcmUgdGhl
IGxhbmd1YWdlIChlc3BlY2lhbGx5IHRoZSB3b3JkICJnZW5lcmFsbHkiKSBpcyB3ZWFrZXIgYW5k
IG1lYW5zCj4gPiA+ID4gPiA+IHRoZXJlIG1heSBiZSBleGNlcHRpb25zLgo+ID4gPiA+ID4gPgo+
ID4gPiA+ID4gPiBBbm90aGVyIHR5cGUgb2YgYWNjZXNzIHRoYXQgZG9lc24ndCB3b3JrIHdpdGgg
dGhlIFZEVVNFX0RFVl9TRVRfQ09ORklHCj4gPiA+ID4gPiA+IGFwcHJvYWNoIGlzIHJlYWRzIHRo
YXQgaGF2ZSBzaWRlLWVmZmVjdHMuIEZvciBleGFtcGxlLCBpbWFnaW5lIGEgZmllbGQKPiA+ID4g
PiA+ID4gY29udGFpbmluZyBhbiBlcnJvciBjb2RlIGlmIHRoZSBkZXZpY2UgZW5jb3VudGVycyBh
IHByb2JsZW0gdW5yZWxhdGVkIHRvCj4gPiA+ID4gPiA+IGEgc3BlY2lmaWMgdmlydHF1ZXVlIHJl
cXVlc3QuIFJlYWRpbmcgZnJvbSB0aGlzIGZpZWxkIHJlc2V0cyB0aGUgZXJyb3IKPiA+ID4gPiA+
ID4gY29kZSB0byAwLCBzYXZpbmcgdGhlIGRyaXZlciBhbiBleHRyYSBjb25maWd1cmF0aW9uIHNw
YWNlIHdyaXRlIGFjY2Vzcwo+ID4gPiA+ID4gPiBhbmQgcG9zc2libHkgcmFjZSBjb25kaXRpb25z
LiBJdCBpc24ndCBwb3NzaWJsZSB0byBpbXBsZW1lbnQgdGhvc2UKPiA+ID4gPiA+ID4gc2VtYW50
aWNzIHN1aW5nIFZEVVNFX0RFVl9TRVRfQ09ORklHLiBJdCdzIGFub3RoZXIgY29ybmVyIGNhc2Us
IGJ1dCBpdAo+ID4gPiA+ID4gPiBtYWtlcyBtZSB0aGluayB0aGF0IHRoZSBpbnRlcmZhY2UgZG9l
cyBub3QgYWxsb3cgZnVsbCBWSVJUSU8gc2VtYW50aWNzLgo+ID4gPiA+Cj4gPiA+ID4KPiA+ID4g
PiBOb3RlIHRoYXQgdGhvdWdoIHlvdSdyZSBjb3JyZWN0LCBteSB1bmRlcnN0YW5kaW5nIGlzIHRo
YXQgY29uZmlnIHNwYWNlIGlzCj4gPiA+ID4gbm90IHN1aXRhYmxlIGZvciB0aGlzIGtpbmQgb2Yg
ZXJyb3IgcHJvcGFnYXRpbmcuIEFuZCBpdCB3b3VsZCBiZSB2ZXJ5IGhhcmQKPiA+ID4gPiB0byBp
bXBsZW1lbnQgc3VjaCBraW5kIG9mIHNlbWFudGljIGluIHNvbWUgdHJhbnNwb3J0cy4gIFZpcnRx
dWV1ZSBzaG91bGQgYmUKPiA+ID4gPiBtdWNoIGJldHRlci4gQXMgWW9uZyBKaSBxdW90ZWQsIHRo
ZSBjb25maWcgc3BhY2UgaXMgdXNlZCBmb3IKPiA+ID4gPiAicmFyZWx5LWNoYW5naW5nIG9yIGlu
dGlhbGl6YXRpb24tdGltZSBwYXJhbWV0ZXJzIi4KPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPiBB
Z3JlZWQuIEkgd2lsbCB1c2UgVkRVU0VfREVWX0dFVF9DT05GSUcgaW4gdGhlIG5leHQgdmVyc2lv
bi4gQW5kIHRvCj4gPiA+ID4gPiBoYW5kbGUgdGhlIG1lc3NhZ2UgZmFpbHVyZSwgSSdtIGdvaW5n
IHRvIGFkZCBhIHJldHVybiB2YWx1ZSB0bwo+ID4gPiA+ID4gdmlydGlvX2NvbmZpZ19vcHMuZ2V0
KCkgYW5kIHZpcnRpb19jcmVhZF8qIEFQSSBzbyB0aGF0IHRoZSBlcnJvciBjYW4KPiA+ID4gPiA+
IGJlIHByb3BhZ2F0ZWQgdG8gdGhlIHZpcnRpbyBkZXZpY2UgZHJpdmVyLiBUaGVuIHRoZSB2aXJ0
aW8tYmxrIGRldmljZQo+ID4gPiA+ID4gZHJpdmVyIGNhbiBiZSBtb2RpZmllZCB0byBoYW5kbGUg
dGhhdC4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBKYXNvbiBhbmQgU3RlZmFuLCB3aGF0IGRvIHlvdSB0
aGluayBvZiB0aGlzIHdheT8KPiA+ID4KPiA+ID4gV2h5IGRvZXMgVkRVU0VfREVWX0dFVF9DT05G
SUcgbmVlZCB0byBzdXBwb3J0IGFuIGVycm9yIHJldHVybiB2YWx1ZT8KPiA+ID4KPiA+Cj4gPiBX
ZSBhZGQgYSB0aW1lb3V0IGFuZCByZXR1cm4gZXJyb3IgaW4gY2FzZSB1c2Vyc3BhY2UgbmV2ZXIg
cmVwbGllcyB0bwo+ID4gdGhlIG1lc3NhZ2UuCj4gPgo+ID4gPiBUaGUgVklSVElPIHNwZWMgcHJv
dmlkZXMgbm8gd2F5IGZvciB0aGUgZGV2aWNlIHRvIHJlcG9ydCBlcnJvcnMgZnJvbQo+ID4gPiBj
b25maWcgc3BhY2UgYWNjZXNzZXMuCj4gPiA+Cj4gPiA+IFRoZSBRRU1VIHZpcnRpby1wY2kgaW1w
bGVtZW50YXRpb24gcmV0dXJucyAtMSBmcm9tIGludmFsaWQKPiA+ID4gdmlydGlvX2NvbmZpZ19y
ZWFkKigpIGFuZCBzaWxlbnRseSBkaXNjYXJkcyB2aXJ0aW9fY29uZmlnX3dyaXRlKigpCj4gPiA+
IGFjY2Vzc2VzLgo+ID4gPgo+ID4gPiBWRFVTRSBjYW4gdGFrZSB0aGUgc2FtZSBhcHByb2FjaCB3
aXRoCj4gPiA+IFZEVVNFX0RFVl9HRVRfQ09ORklHL1ZEVVNFX0RFVl9TRVRfQ09ORklHLgo+ID4g
Pgo+ID4KPiA+IEkgbm90aWNlZCB0aGF0IHZpcnRpb19jb25maWdfcmVhZCooKSBvbmx5IHJldHVy
bnMgLTEgd2hlbiB3ZSBhY2Nlc3MgYQo+ID4gaW52YWxpZCBmaWVsZC4gQnV0IGluIHRoZSBWRFVT
RSBjYXNlLCBWRFVTRV9ERVZfR0VUX0NPTkZJRyBtaWdodCBmYWlsCj4gPiB3aGVuIHdlIGFjY2Vz
cyBhIHZhbGlkIGZpZWxkLiBOb3Qgc3VyZSBpZiBpdCdzIG9rIHRvIHNpbGVudGx5IGlnbm9yZQo+
ID4gdGhpcyBraW5kIG9mIGVycm9yLgo+Cj4gVGhhdCdzIGEgZ29vZCBwb2ludCBidXQgaXQncyBh
IGdlbmVyYWwgVklSVElPIGlzc3VlLiBBbnkgZGV2aWNlCj4gaW1wbGVtZW50YXRpb24gKFFFTVUg
dXNlcnNwYWNlLCBoYXJkd2FyZSB2RFBBLCBldGMpIGNhbiBmYWlsLCBzbyB0aGUKPiBWSVJUSU8g
c3BlY2lmaWNhdGlvbiBuZWVkcyB0byBwcm92aWRlIGEgd2F5IGZvciB0aGUgZHJpdmVyIHRvIGRl
dGVjdAo+IHRoaXMuCj4KPiBJZiB1c2Vyc3BhY2UgdmlvbGF0ZXMgdGhlIGNvbnRyYWN0IHRoZW4g
VkRVU0UgbmVlZHMgdG8gbWFyayB0aGUgZGV2aWNlCj4gYnJva2VuLiBRRU1VJ3MgZGV2aWNlIGVt
dWxhdGlvbiBkb2VzIHNvbWV0aGluZyBzaW1pbGFyIHdpdGggdGhlCj4gdmRldi0+YnJva2VuIGZs
YWcuCj4KPiBUaGUgVklSVElPIERldmljZSBTdGF0dXMgZmllbGQgREVWSUNFX05FRURTX1JFU0VU
IGJpdCBjYW4gYmUgc2V0IGJ5Cj4gdkRQQS9WRFVTRSB0byBpbmRpY2F0ZSB0aGF0IHRoZSBkZXZp
Y2UgaXMgbm90IG9wZXJhdGlvbmFsIGFuZCBtdXN0IGJlCj4gcmVzZXQuCj4KCkl0IG1pZ2h0IGJl
IGEgc29sdXRpb24uIEJ1dCBERVZJQ0VfTkVFRFNfUkVTRVQgIGlzIG5vdCBpbXBsZW1lbnRlZApj
dXJyZW50bHkuIFNvIEknbSB0aGlua2luZyB3aGV0aGVyIGl0J3Mgb2sgdG8gYWRkIGEgY2hlY2sg
b2YKREVWSUNFX05FRURTX1JFU0VUIHN0YXR1cyBiaXQgaW4gcHJvYmUgZnVuY3Rpb24gb2Ygdmly
dGlvIGRldmljZQpkcml2ZXIgKGUuZy4gdmlydGlvLWJsayBkcml2ZXIpLiBUaGVuIFZEVVNFIGNh
biBtYWtlIHVzZSBvZiBpdCB0byBmYWlsCmRldmljZSBpbml0YWlsaXphdGlvbiB3aGVuIGNvbmZp
Z3VyYXRpb24gc3BhY2UgYWNjZXNzIGZhaWxlZC4KClRoYW5rcywKWW9uZ2ppCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdApp
b21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
