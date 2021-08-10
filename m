Return-Path: <SRS0=o4oj=NB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F863C4338F
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 07:44:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E674660F38
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 07:44:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E674660F38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A878D401B4;
	Tue, 10 Aug 2021 07:44:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 78TLXfFVHFii; Tue, 10 Aug 2021 07:44:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 427A84011C;
	Tue, 10 Aug 2021 07:44:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17EDEC001A;
	Tue, 10 Aug 2021 07:44:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B30EC000E
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 07:44:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EA6F6404F2
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 07:44:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uzm7kjndiIo6 for <iommu@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 07:44:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2CEB5404F5
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 07:44:09 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id go31so33767674ejc.6
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 00:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=elqUT9stw2J3iR2l4RxHnGypplqsV8TkYIJkIMW8hsY=;
 b=Dw2anpOlrs9rV2RbKN404Zn18rw9HV6mvfkE8M1kGMV2Ah+OI2rfEhpzsA9qdOawIF
 k8THbB9AABfuNY1MbNdd0AcLrxpPD246ArW/bPUC+pr03hqytJJD7OFvzo3N0q/tpZGO
 tH48kCvdWiYFfAcIV1f5yS5oQiNePxkq4fi3pXrnB2oNtBTWdXNxRQpFSbu0OmyXCusR
 +W05Ly+4a2nE2bv8/HwAQbH8fmJcv8+1juWLj995sdhCvh4wbwIAVnm3NRBqnxRlLOyy
 KEmSTLyK4NbrCSV7j939f/4v7zlRHpFqgOALTvOj2N1xjrfa63r8X64WZ/4zirZ1FwSG
 ug5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=elqUT9stw2J3iR2l4RxHnGypplqsV8TkYIJkIMW8hsY=;
 b=SdPPAFzqLa0NqKyO2k+OZdrzGSkp2OPTlJ8mhFqjKN/BjpDDaOn8a4G3AiK/UjpS4g
 jo/oU39V9E/Ch1//F0yTN/ED1IRQGPf9O2vKtZxhqxtAlXnr+eylEAGhuNU6ZDwOpwo7
 nWpdc2wZe/sNr7/zX15cmeaWDX5/oi1JT71sTQ13UPLQRpyR9exruMLHhX0PkAoOm7MH
 Isv9Yv4v5G12UmztBAYCDG+fwRNkSiwoQKFYNjXs2rzh8+qytXkFOG1t0oucXTSOsLW0
 shloZVHzsRCbU9go/QOOnFaP0XeE2vfEkbMb9iTvJiXu3QI+mQBcsrulu8GBSqH+b5Lp
 /bnA==
X-Gm-Message-State: AOAM530KkoxjV57hHNbnglWEAZPRmSABJtkP/RZyjNqY7XcITJxtRD50
 j2Er2gsNokbv+paJLv3tEaHRRRGDJ70F9kH/nva7
X-Google-Smtp-Source: ABdhPJx/TbMGjhieQzq1YqRjJBN7a9WTaXbFyhJM7EzEX+MXvLMAXR31L8+X5gM3dqLz8GqZFLUy0w3uIoYuvmPOUqE=
X-Received: by 2002:a17:906:8606:: with SMTP id
 o6mr26642389ejx.247.1628581447154; 
 Tue, 10 Aug 2021 00:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210729073503.187-1-xieyongji@bytedance.com>
 <20210729073503.187-2-xieyongji@bytedance.com>
 <43d88942-1cd3-c840-6fec-4155fd544d80@redhat.com>
 <CACycT3vcpwyA3xjD29f1hGnYALyAd=-XcWp8+wJiwSqpqUu00w@mail.gmail.com>
 <6e05e25e-e569-402e-d81b-8ac2cff1c0e8@arm.com>
 <CACycT3sm2r8NMMUPy1k1PuSZZ3nM9aic-O4AhdmRRCwgmwGj4Q@mail.gmail.com>
 <417ce5af-4deb-5319-78ce-b74fb4dd0582@arm.com>
 <CACycT3vARzvd4-dkZhDHqUkeYoSxTa2ty0z0ivE1znGti+n1-g@mail.gmail.com>
 <8c381d3d-9bbd-73d6-9733-0f0b15c40820@redhat.com>
 <CACycT3steXFeg7NRbWpo2J59dpYcumzcvM2zcPJAVe40-EvvEg@mail.gmail.com>
 <b427cf12-2ff6-e5cd-fe6a-3874d8622a29@redhat.com>
In-Reply-To: <b427cf12-2ff6-e5cd-fe6a-3874d8622a29@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Tue, 10 Aug 2021 15:43:56 +0800
Message-ID: <CACycT3vuBdmWdu4X9wjCO0hm+O0xH2Uf0S2ZTk4O_pL2jX6Y5g@mail.gmail.com>
Subject: Re: [PATCH v10 01/17] iova: Export alloc_iova_fast() and
 free_iova_fast()
To: Jason Wang <jasowang@redhat.com>, Robin Murphy <robin.murphy@arm.com>
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

T24gVHVlLCBBdWcgMTAsIDIwMjEgYXQgMTE6MDIgQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4gd3JvdGU6Cj4KPgo+IOWcqCAyMDIxLzgvOSDkuIvljYgxOjU2LCBZb25namkgWGll
IOWGmemBkzoKPiA+IE9uIFRodSwgQXVnIDUsIDIwMjEgYXQgOTozMSBQTSBKYXNvbiBXYW5nIDxq
YXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+Pgo+ID4+IOWcqCAyMDIxLzgvNSDkuIvljYg4
OjM0LCBZb25namkgWGllIOWGmemBkzoKPiA+Pj4+IE15IG1haW4gcG9pbnQsIHRob3VnaCwgaXMg
dGhhdCBpZiB5b3UndmUgYWxyZWFkeSBnb3Qgc29tZXRoaW5nIGVsc2UKPiA+Pj4+IGtlZXBpbmcg
dHJhY2sgb2YgdGhlIGFjdHVhbCBhZGRyZXNzZXMsIHRoZW4gdGhlIHdheSB5b3UncmUgdXNpbmcg
YW4KPiA+Pj4+IGlvdmFfZG9tYWluIGFwcGVhcnMgdG8gYmUgc29tZXRoaW5nIHlvdSBjb3VsZCBk
byB3aXRoIGEgdHJpdmlhbCBiaXRtYXAKPiA+Pj4+IGFsbG9jYXRvci4gVGhhdCdzIHdoeSBJIGRv
bid0IGJ1eSB0aGUgZWZmaWNpZW5jeSBhcmd1bWVudC4gVGhlIG1haW4KPiA+Pj4+IGRlc2lnbiBw
b2ludHMgb2YgdGhlIElPVkEgYWxsb2NhdG9yIGFyZSB0byBtYW5hZ2UgbGFyZ2UgYWRkcmVzcyBz
cGFjZXMKPiA+Pj4+IHdoaWxlIHRyeWluZyB0byBtYXhpbWlzZSBzcGF0aWFsIGxvY2FsaXR5IHRv
IG1pbmltaXNlIHRoZSB1bmRlcmx5aW5nCj4gPj4+PiBwYWdldGFibGUgdXNhZ2UsIGFuZCBhbGxv
Y2F0aW5nIHdpdGggYSBmbGV4aWJsZSBsaW1pdCB0byBzdXBwb3J0Cj4gPj4+PiBtdWx0aXBsZSBk
ZXZpY2VzIHdpdGggZGlmZmVyZW50IGFkZHJlc3NpbmcgY2FwYWJpbGl0aWVzIGluIHRoZSBzYW1l
Cj4gPj4+PiBhZGRyZXNzIHNwYWNlLiBJZiBub25lIG9mIHRob3NlIGFzcGVjdHMgYXJlIHJlbGV2
YW50IHRvIHRoZSB1c2UtY2FzZSAtCj4gPj4+PiB3aGljaCBBRkFJQ1MgYXBwZWFycyB0byBiZSB0
cnVlIGhlcmUgLSB0aGVuIGFzIGEgZ2VuZXJhbC1wdXJwb3NlCj4gPj4+PiByZXNvdXJjZSBhbGxv
Y2F0b3IgaXQncyBydWJiaXNoIGFuZCBoYXMgYW4gdW5yZWFzb25hYmx5IG1hc3NpdmUgbWVtb3J5
Cj4gPj4+PiBvdmVyaGVhZCBhbmQgdGhlcmUgYXJlIG1hbnksIG1hbnkgYmV0dGVyIGNob2ljZXMu
Cj4gPj4+Pgo+ID4+PiBPSywgSSBnZXQgeW91ciBwb2ludC4gQWN0dWFsbHkgd2UgdXNlZCB0aGUg
Z2VucG9vbCBhbGxvY2F0b3IgaW4gdGhlCj4gPj4+IGVhcmx5IHZlcnNpb24uIE1heWJlIHdlIGNh
biBmYWxsIGJhY2sgdG8gdXNpbmcgaXQuCj4gPj4KPiA+PiBJIHRoaW5rIG1heWJlIHlvdSBjYW4g
c2hhcmUgc29tZSBwZXJmIG51bWJlcnMgdG8gc2VlIGhvdyBtdWNoCj4gPj4gYWxsb2NfaW92YV9m
YXN0KCkgY2FuIGhlbHAuCj4gPj4KPiA+IEkgZGlkIHNvbWUgZmlvIHRlc3RzWzFdIHdpdGggYSBy
YW0tYmFja2VuZCB2ZHVzZSBibG9jayBkZXZpY2VbMl0uCj4gPgo+ID4gRm9sbG93aW5nIGFyZSBz
b21lIHBlcmZvcm1hbmNlIGRhdGE6Cj4gPgo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBudW1qb2JzPTEgICBudW1qb2JzPTIgICAgbnVtam9icz00ICAgbnVtam9icz04Cj4gPiBpb3Zh
X2FsbG9jX2Zhc3QgICAgMTQ1ayBpb3BzICAgICAgMjY1ayBpb3BzICAgICAgNTE0ayBpb3BzICAg
ICAgNzU4ayBpb3BzCj4gPgo+ID4gaW92YV9hbGxvYyAgICAgICAgICAgIDEzN2sgaW9wcyAgICAg
MTcwayBpb3BzICAgICAgMTI4ayBpb3BzICAgICAgMTEzayBpb3BzCj4gPgo+ID4gZ2VuX3Bvb2xf
YWxsb2MgICAxNDNrIGlvcHMgICAgICAyNzBrIGlvcHMgICAgICA0NThrIGlvcHMgICAgICA1MjFr
IGlvcHMKPiA+Cj4gPiBUaGUgaW92YV9hbGxvY19mYXN0KCkgaGFzIHRoZSBiZXN0IHBlcmZvcm1h
bmNlIHNpbmNlIHdlIGFsd2F5cyBoaXQgdGhlCj4gPiBwZXItY3B1IGNhY2hlLiBSZWdhcmRsZXNz
IG9mIHRoZSBwZXItY3B1IGNhY2hlLCB0aGUgZ2VucG9vbCBhbGxvY2F0b3IKPiA+IHNob3VsZCBi
ZSBiZXR0ZXIgdGhhbiB0aGUgaW92YSBhbGxvY2F0b3IuCj4KPgo+IEkgdGhpbmsgd2Ugc2VlIGNv
bnZpbmNpbmcgbnVtYmVycyBmb3IgdXNpbmcgaW92YV9hbGxvY19mYXN0KCkgdGhhbiB0aGUKPiBn
ZW5fcG9sbF9hbGxvYygpICg0NSUgaW1wcm92ZW1lbnQgb24gam9iPTgpLgo+CgpZZXMsIHNvIGFs
bG9jX2lvdmFfZmFzdCgpIHN0aWxsIHNlZW1zIHRvIGJlIHRoZSBiZXN0IGNob2ljZSBiYXNlZCBv
bgpwZXJmb3JtYW5jZSBjb25zaWRlcmF0aW9ucy4KCkhpIFJvYmluLCBhbnkgY29tbWVudHM/CgpU
aGFua3MsCllvbmdqaQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
