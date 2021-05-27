Return-Path: <SRS0=nChL=KW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BD9C4707F
	for <iommu@archiver.kernel.org>; Thu, 27 May 2021 13:18:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEAD6611AE
	for <iommu@archiver.kernel.org>; Thu, 27 May 2021 13:18:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEAD6611AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C11B283DB0;
	Thu, 27 May 2021 13:18:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AkaQHSqFw1P1; Thu, 27 May 2021 13:18:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9C85383DB3;
	Thu, 27 May 2021 13:18:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C8F1C000D;
	Thu, 27 May 2021 13:18:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE906C0001
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 13:18:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CB77540224
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 13:18:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NoD-Mu_Gl84I for <iommu@lists.linux-foundation.org>;
 Thu, 27 May 2021 13:18:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 73BB940675
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 13:18:11 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id l1so29105ejb.6
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 06:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=nQgFn8dxliqZkV+84EDBr5D6XtzraqZ1JcCt4vcxaEg=;
 b=U+4BjfZGBFAb1qVG2dykR4pGeBdKBFy1a0gYiCM/bVIvP4FQgP0Rlv2zd+rc7Cb3qV
 pR+aE2uu9wEZvhgfWfZxsIR/HpvJ2SiNN/uDvKZIKLLr9rQzwjL8rIyIyDU6Qh6tshvo
 fPVAeH9h6ZTQlSdYq8Z3GN9z4duLY02ZtqKLyiXt4CnpYZLHuHaD5CywUaq9UxR1K9JO
 RCRP/QniKCl0pELJZt2SJ4/29wuT+lh8Gu/dnTU2TsNSQ7CgvIKF0SytFPqHlZAnOd0g
 949d1X4Aehx49vMb6axO60paWMz84o4PHz2KAygA9S9MxJyuPxN+bjMMCpX/d/j0cmuN
 lQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=nQgFn8dxliqZkV+84EDBr5D6XtzraqZ1JcCt4vcxaEg=;
 b=tlpkR1PZtI3okI4GJVRW8PIQhiFzLakTt3ilOExJw1Q1kXj/TGEI8y69y3ZsawkfO/
 Q8/mTiF+Kz0sZqZzMftzWTgNiJpFOsHAAyEjWpxjwam8ld9QL89fX2FcC1VEQIyc0+MX
 uAquYG5WDhBEcqqvW/rX344PKPPRchb6my3FOO6xnevjk5+kQbcOq21ZN4mAc03WnqvY
 Fk6lcni/AZBny+kaMMZh376QI/6YGbSvwQVcYUKpv23LtstppA4W82JWcq+VGVbiYwKY
 0KMrnNUnXJt4CnuzSHCBP4v/CFHsLWQvzhb8YVzdC+5NyxvzLCXNdl85KugH3UeOdgux
 2OQw==
X-Gm-Message-State: AOAM532nvYp/Qms1scoZlCjCyXUAzgvO4mC7hwSE/fvQuMb6WC67HyYL
 okpI6uffGBQuoxLALNraHTpPd5CPjrgCM77faYNj
X-Google-Smtp-Source: ABdhPJzONeuUPApTMkYwvFbbcILylmfJeY2yh2SKaw7NmLK0VfeRDhi2UdjgnlJsCGuc2sUrB8OCqSsNbGKNja1zLzI=
X-Received: by 2002:a17:907:1b11:: with SMTP id
 mp17mr3810051ejc.1.1622121484390; 
 Thu, 27 May 2021 06:18:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210517095513.850-1-xieyongji@bytedance.com>
 <20210517095513.850-12-xieyongji@bytedance.com>
 <3740c7eb-e457-07f3-5048-917c8606275d@redhat.com>
 <CACycT3uAqa6azso_8MGreh+quj-JXO1piuGnrV8k2kTfc34N2g@mail.gmail.com>
 <5a68bb7c-fd05-ce02-cd61-8a601055c604@redhat.com>
 <CACycT3ve7YvKF+F+AnTQoJZMPua+jDvGMs_ox8GQe_=SGdeCMA@mail.gmail.com>
 <ee00efca-b26d-c1be-68d2-f9e34a735515@redhat.com>
 <CACycT3ufok97cKpk47NjUBTc0QAyfauFUyuFvhWKmuqCGJ7zZw@mail.gmail.com>
 <00ded99f-91b6-ba92-5d92-2366b163f129@redhat.com>
In-Reply-To: <00ded99f-91b6-ba92-5d92-2366b163f129@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Thu, 27 May 2021 21:17:54 +0800
Message-ID: <CACycT3uK_Fuade-b8FVYkGCKZnne_UGGbYRFwv7WOH2oKCsXSg@mail.gmail.com>
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

T24gVGh1LCBNYXkgMjcsIDIwMjEgYXQgNDo0MSBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPgo+Cj4g5ZyoIDIwMjEvNS8yNyDkuIvljYgzOjM0LCBZb25namkgWGll
IOWGmemBkzoKPiA+IE9uIFRodSwgTWF5IDI3LCAyMDIxIGF0IDE6NDAgUE0gSmFzb24gV2FuZyA8
amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPj4KPiA+PiDlnKggMjAyMS81LzI3IOS4i+WN
iDE6MDgsIFlvbmdqaSBYaWUg5YaZ6YGTOgo+ID4+PiBPbiBUaHUsIE1heSAyNywgMjAyMSBhdCAx
OjAwIFBNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4+Pj4g5Zyo
IDIwMjEvNS8yNyDkuIvljYgxMjo1NywgWW9uZ2ppIFhpZSDlhpnpgZM6Cj4gPj4+Pj4gT24gVGh1
LCBNYXkgMjcsIDIwMjEgYXQgMTI6MTMgUE0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNv
bT4gd3JvdGU6Cj4gPj4+Pj4+IOWcqCAyMDIxLzUvMTcg5LiL5Y2INTo1NSwgWGllIFlvbmdqaSDl
hpnpgZM6Cj4gPj4+Pj4+PiArCj4gPj4+Pj4+PiArc3RhdGljIGludCB2ZHVzZV9kZXZfbXNnX3N5
bmMoc3RydWN0IHZkdXNlX2RldiAqZGV2LAo+ID4+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHN0cnVjdCB2ZHVzZV9kZXZfbXNnICptc2cpCj4gPj4+Pj4+PiArewo+ID4+Pj4+Pj4g
KyAgICAgaW5pdF93YWl0cXVldWVfaGVhZCgmbXNnLT53YWl0cSk7Cj4gPj4+Pj4+PiArICAgICBz
cGluX2xvY2soJmRldi0+bXNnX2xvY2spOwo+ID4+Pj4+Pj4gKyAgICAgdmR1c2VfZW5xdWV1ZV9t
c2coJmRldi0+c2VuZF9saXN0LCBtc2cpOwo+ID4+Pj4+Pj4gKyAgICAgd2FrZV91cCgmZGV2LT53
YWl0cSk7Cj4gPj4+Pj4+PiArICAgICBzcGluX3VubG9jaygmZGV2LT5tc2dfbG9jayk7Cj4gPj4+
Pj4+PiArICAgICB3YWl0X2V2ZW50X2tpbGxhYmxlKG1zZy0+d2FpdHEsIG1zZy0+Y29tcGxldGVk
KTsKPiA+Pj4+Pj4gV2hhdCBoYXBwZW5zIGlmIHRoZSB1c2Vyc3BhY2UobWFsaWNvdXMpIGRvZXNu
J3QgZ2l2ZSBhIHJlc3BvbnNlIGZvcmV2ZXI/Cj4gPj4+Pj4+Cj4gPj4+Pj4+IEl0IGxvb2tzIGxp
a2UgYSBET1MuIElmIHllcywgd2UgbmVlZCB0byBjb25zaWRlciBhIHdheSB0byBmaXggdGhhdC4K
PiA+Pj4+Pj4KPiA+Pj4+PiBIb3cgYWJvdXQgdXNpbmcgd2FpdF9ldmVudF9raWxsYWJsZV90aW1l
b3V0KCkgaW5zdGVhZD8KPiA+Pj4+IFByb2JhYmx5LCBhbmQgdGhlbiB3ZSBuZWVkIGNob29zZSBh
IHN1aXRhYmxlIHRpbWVvdXQgYW5kIG1vcmUgaW1wb3J0YW50LAo+ID4+Pj4gbmVlZCB0byByZXBv
cnQgdGhlIGZhaWx1cmUgdG8gdmlydGlvLgo+ID4+Pj4KPiA+Pj4gTWFrZXMgc2Vuc2UgdG8gbWUu
IEJ1dCBpdCBsb29rcyBsaWtlIHNvbWUKPiA+Pj4gdmRwYV9jb25maWdfb3BzL3ZpcnRpb19jb25m
aWdfb3BzIHN1Y2ggYXMgc2V0X3N0YXR1cygpIGRpZG4ndCBoYXZlIGEKPiA+Pj4gcmV0dXJuIHZh
bHVlLiAgTm93IEkgYWRkIGEgV0FSTl9PTigpIGZvciB0aGUgZmFpbHVyZS4gRG8geW91IG1lYW4g
d2UKPiA+Pj4gbmVlZCB0byBhZGQgc29tZSBjaGFuZ2UgZm9yIHZpcnRpbyBjb3JlIHRvIGhhbmRs
ZSB0aGUgZmFpbHVyZT8KPiA+Pgo+ID4+IE1heWJlLCBidXQgSSdtIG5vdCBzdXJlIGhvdyBoYXJk
IHdlIGNhbiBkbyB0aGF0Lgo+ID4+Cj4gPiBXZSBuZWVkIHRvIGNoYW5nZSBhbGwgdmlydGlvIGRl
dmljZSBkcml2ZXJzIGluIHRoaXMgd2F5Lgo+Cj4KPiBQcm9iYWJseS4KPgo+Cj4gPgo+ID4+IFdl
IGhhZCBORUVEU19SRVNFVCBidXQgaXQgbG9va3Mgd2UgZG9uJ3QgaW1wbGVtZW50IGl0Lgo+ID4+
Cj4gPiBDb3VsZCBpdCBoYW5kbGUgdGhlIGZhaWx1cmUgb2YgZ2V0X2ZlYXR1cmUoKSBhbmQgZ2V0
L3NldF9jb25maWcoKT8KPgo+Cj4gTG9va3Mgbm90Ogo+Cj4gIgo+Cj4gVGhlIGRldmljZSBTSE9V
TEQgc2V0IERFVklDRV9ORUVEU19SRVNFVCB3aGVuIGl0IGVudGVycyBhbiBlcnJvciBzdGF0ZQo+
IHRoYXQgYSByZXNldCBpcyBuZWVkZWQuIElmIERSSVZFUl9PSyBpcyBzZXQsIGFmdGVyIGl0IHNl
dHMKPiBERVZJQ0VfTkVFRFNfUkVTRVQsIHRoZSBkZXZpY2UgTVVTVCBzZW5kIGEgZGV2aWNlIGNv
bmZpZ3VyYXRpb24gY2hhbmdlCj4gbm90aWZpY2F0aW9uIHRvIHRoZSBkcml2ZXIuCj4KPiAiCj4K
PiBUaGlzIGxvb2tzIGltcGxpZXMgdGhhdCBORUVEU19SRVNFVCBtYXkgb25seSB3b3JrIGFmdGVy
IGRldmljZSBpcwo+IHByb2JlZC4gQnV0IGluIHRoZSBjdXJyZW50IGRlc2lnbiwgZXZlbiB0aGUg
cmVzZXQoKSBpcyBub3QgcmVsaWFibGUuCj4KPgo+ID4KPiA+PiBPciBhIHJvdWdoIGlkZWEgaXMg
dGhhdCBtYXliZSBuZWVkIHNvbWUgcmVsYXhpbmcgdG8gYmUgY291cGxlZCBsb29zZWx5Cj4gPj4g
d2l0aCB1c2Vyc3BhY2UuIEUuZyB0aGUgZGV2aWNlIChjb250cm9sIHBhdGgpIGlzIGltcGxlbWVu
dGVkIGluIHRoZQo+ID4+IGtlcm5lbCBidXQgdGhlIGRhdGFwYXRoIGlzIGltcGxlbWVudGVkIGlu
IHRoZSB1c2Vyc3BhY2UgbGlrZSBUVU4vVEFQLgo+ID4+Cj4gPiBJIHRoaW5rIGl0IGNhbiB3b3Jr
IGZvciBtb3N0IGNhc2VzLiBPbmUgcHJvYmxlbSBpcyB0aGF0IHRoZSBzZXRfY29uZmlnCj4gPiBt
aWdodCBjaGFuZ2UgdGhlIGJlaGF2aW9yIG9mIHRoZSBkYXRhIHBhdGggYXQgcnVudGltZSwgZS5n
Lgo+ID4gdmlydG5ldF9zZXRfbWFjX2FkZHJlc3MoKSBpbiB0aGUgdmlydGlvLW5ldCBkcml2ZXIg
YW5kCj4gPiBjYWNoZV90eXBlX3N0b3JlKCkgaW4gdGhlIHZpcnRpby1ibGsgZHJpdmVyLiBOb3Qg
c3VyZSBpZiB0aGlzIHBhdGggaXMKPiA+IGFibGUgdG8gcmV0dXJuIGJlZm9yZSB0aGUgZGF0YXBh
dGggaXMgYXdhcmUgb2YgdGhpcyBjaGFuZ2UuCj4KPgo+IEdvb2QgcG9pbnQuCj4KPiBCdXQgc2V0
X2NvbmZpZygpIHNob3VsZCBiZSByYXJlOgo+Cj4gRS5nIGluIHRoZSBjYXNlIG9mIHZpcnRpby1u
ZXQgd2l0aCBWRVJTSU9OXzEsIGNvbmZpZyBzcGFjZSBpcyByZWFkIG9ubHksCj4gYW5kIGl0IHdh
cyBzZXQgdmlhIGNvbnRyb2wgdnEuCj4KPiBGb3IgYmxvY2ssIHdlIGNhbgo+Cj4gMSkgc3RhcnQg
ZnJvbSB3aXRob3V0IFdDRSBvcgo+IDIpIHdlIGFkZCBhIGNvbmZpZyBjaGFuZ2Ugbm90aWZpY2F0
aW9uIHRvIHVzZXJzcGFjZSBvcgoKSSBwcmVmZXIgdGhpcyB3YXkuIEFuZCBJIHRoaW5rIHdlIGFs
c28gbmVlZCB0byBkbyBzaW1pbGFyIHRoaW5ncyBmb3IKc2V0L2dldF92cV9zdGF0ZSgpLgoKVGhh
bmtzLApZb25namkKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
