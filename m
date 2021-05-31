Return-Path: <SRS0=AF0h=K2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D095EC47096
	for <iommu@archiver.kernel.org>; Mon, 31 May 2021 04:27:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4202B61003
	for <iommu@archiver.kernel.org>; Mon, 31 May 2021 04:27:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4202B61003
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0613440134;
	Mon, 31 May 2021 04:27:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7mOU-Rlu_6aJ; Mon, 31 May 2021 04:27:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id D185D40185;
	Mon, 31 May 2021 04:27:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9223EC000D;
	Mon, 31 May 2021 04:27:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 024EBC000D
 for <iommu@lists.linux-foundation.org>; Mon, 31 May 2021 04:27:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CF69A40185
 for <iommu@lists.linux-foundation.org>; Mon, 31 May 2021 04:27:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aZRfPbJhiCfo for <iommu@lists.linux-foundation.org>;
 Mon, 31 May 2021 04:27:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6C64C40134
 for <iommu@lists.linux-foundation.org>; Mon, 31 May 2021 04:27:40 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id l3so14673446ejc.4
 for <iommu@lists.linux-foundation.org>; Sun, 30 May 2021 21:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=j6WTPEiBQdPonWFjY55x7ZuSzgTUsPLMHH6aX/4/Gw8=;
 b=EXENnrfEXaCiPMCaojpc5es9c4FAJrIpcPU8gJJf9odMOs7D8t1cPqCLzQVxVp8cbn
 W2gadoISAhB0Zx5YzlO7O3crhw6O+npP4SIchdHydbmf7MhAaAqn6OY+orHyvKJxMtPC
 TG1LHwL6aBkBg/I5k0qODQ82E0gszg399vZza4Ktkk+3QsObwVcYhvDRjwfgSKUKbz0H
 ZdvrMAvKDBRKfx7j1LyV2vpm5rLOHjEpJKpDIut/0u2C0r7wm7TLozEeYbmmy+s+3mBm
 UgmsyRSKfdyCLeq1aVgJCnko00wNUy6PRwe3GG2SIQIMzBpr9nDRNHEQHrxA3n7H0jef
 l+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=j6WTPEiBQdPonWFjY55x7ZuSzgTUsPLMHH6aX/4/Gw8=;
 b=MaUkRoYOhjQCMTsP8ZwLff4E/ykHdKfzg4s8PI/+YgpIbfQoMmmgQqXMfuDrgF750C
 X9HU0u7Pgv9VfgE/CVhl5hE769wcFn/Nd5XxfVPHI+w8563QC45f/Yi/T2DQWfAmYmHB
 LB8g0T0JlyIkol+WwQZ1AwR6oIoJ1LLE0zP62WCao0gxCXGdkKqbk4tNoc/JCXVgf+8t
 HOFNcnda2WrM0pJyfFAf0rRZNjTqFC/XvZ1te9NtxNmcExCx4sW5k0ALZbs5kCWP0uUO
 DMhSMP2YIQVm+HVaSf2HlBn6MrQJvJv3OL9YVgn9eUg685s3zvEqtzo7HDxw5fSBo5c6
 2qbQ==
X-Gm-Message-State: AOAM531dKrSKJ96YixI9w3JShpGHeLfCMAv68pDq5QJC6ry0f6YWJKee
 qiRC+jLObDNi/mp/Va6OYjinlodVtIrY3CG+SecG
X-Google-Smtp-Source: ABdhPJwhWkGN+YD4HVomVtgpj6PoKjpLAKuMwiNQd38DxcDTR1RBUa8K6flHPHMrV8WCVdAdhenY0lyPQ9+3KiWhFNo=
X-Received: by 2002:a17:906:c211:: with SMTP id
 d17mr21087083ejz.247.1622435258309; 
 Sun, 30 May 2021 21:27:38 -0700 (PDT)
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
 <CACycT3uK_Fuade-b8FVYkGCKZnne_UGGbYRFwv7WOH2oKCsXSg@mail.gmail.com>
 <f20edd55-20cb-c016-b347-dd71c5406ed8@redhat.com>
In-Reply-To: <f20edd55-20cb-c016-b347-dd71c5406ed8@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Mon, 31 May 2021 12:27:27 +0800
Message-ID: <CACycT3tLj6a7-tbqO9SzCLStwYrOALdkfnt1jxQBv3s0VzD6AQ@mail.gmail.com>
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

T24gRnJpLCBNYXkgMjgsIDIwMjEgYXQgMTA6MzEgQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4gd3JvdGU6Cj4KPgo+IOWcqCAyMDIxLzUvMjcg5LiL5Y2IOToxNywgWW9uZ2ppIFhp
ZSDlhpnpgZM6Cj4gPiBPbiBUaHUsIE1heSAyNywgMjAyMSBhdCA0OjQxIFBNIEphc29uIFdhbmcg
PGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4+Cj4gPj4g5ZyoIDIwMjEvNS8yNyDkuIvl
jYgzOjM0LCBZb25namkgWGllIOWGmemBkzoKPiA+Pj4gT24gVGh1LCBNYXkgMjcsIDIwMjEgYXQg
MTo0MCBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+Pj4+IOWc
qCAyMDIxLzUvMjcg5LiL5Y2IMTowOCwgWW9uZ2ppIFhpZSDlhpnpgZM6Cj4gPj4+Pj4gT24gVGh1
LCBNYXkgMjcsIDIwMjEgYXQgMTowMCBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29t
PiB3cm90ZToKPiA+Pj4+Pj4g5ZyoIDIwMjEvNS8yNyDkuIvljYgxMjo1NywgWW9uZ2ppIFhpZSDl
hpnpgZM6Cj4gPj4+Pj4+PiBPbiBUaHUsIE1heSAyNywgMjAyMSBhdCAxMjoxMyBQTSBKYXNvbiBX
YW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+Pj4+Pj4+PiDlnKggMjAyMS81LzE3
IOS4i+WNiDU6NTUsIFhpZSBZb25namkg5YaZ6YGTOgo+ID4+Pj4+Pj4+PiArCj4gPj4+Pj4+Pj4+
ICtzdGF0aWMgaW50IHZkdXNlX2Rldl9tc2dfc3luYyhzdHJ1Y3QgdmR1c2VfZGV2ICpkZXYsCj4g
Pj4+Pj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgdmR1c2VfZGV2X21z
ZyAqbXNnKQo+ID4+Pj4+Pj4+PiArewo+ID4+Pj4+Pj4+PiArICAgICBpbml0X3dhaXRxdWV1ZV9o
ZWFkKCZtc2ctPndhaXRxKTsKPiA+Pj4+Pj4+Pj4gKyAgICAgc3Bpbl9sb2NrKCZkZXYtPm1zZ19s
b2NrKTsKPiA+Pj4+Pj4+Pj4gKyAgICAgdmR1c2VfZW5xdWV1ZV9tc2coJmRldi0+c2VuZF9saXN0
LCBtc2cpOwo+ID4+Pj4+Pj4+PiArICAgICB3YWtlX3VwKCZkZXYtPndhaXRxKTsKPiA+Pj4+Pj4+
Pj4gKyAgICAgc3Bpbl91bmxvY2soJmRldi0+bXNnX2xvY2spOwo+ID4+Pj4+Pj4+PiArICAgICB3
YWl0X2V2ZW50X2tpbGxhYmxlKG1zZy0+d2FpdHEsIG1zZy0+Y29tcGxldGVkKTsKPiA+Pj4+Pj4+
PiBXaGF0IGhhcHBlbnMgaWYgdGhlIHVzZXJzcGFjZShtYWxpY291cykgZG9lc24ndCBnaXZlIGEg
cmVzcG9uc2UgZm9yZXZlcj8KPiA+Pj4+Pj4+Pgo+ID4+Pj4+Pj4+IEl0IGxvb2tzIGxpa2UgYSBE
T1MuIElmIHllcywgd2UgbmVlZCB0byBjb25zaWRlciBhIHdheSB0byBmaXggdGhhdC4KPiA+Pj4+
Pj4+Pgo+ID4+Pj4+Pj4gSG93IGFib3V0IHVzaW5nIHdhaXRfZXZlbnRfa2lsbGFibGVfdGltZW91
dCgpIGluc3RlYWQ/Cj4gPj4+Pj4+IFByb2JhYmx5LCBhbmQgdGhlbiB3ZSBuZWVkIGNob29zZSBh
IHN1aXRhYmxlIHRpbWVvdXQgYW5kIG1vcmUgaW1wb3J0YW50LAo+ID4+Pj4+PiBuZWVkIHRvIHJl
cG9ydCB0aGUgZmFpbHVyZSB0byB2aXJ0aW8uCj4gPj4+Pj4+Cj4gPj4+Pj4gTWFrZXMgc2Vuc2Ug
dG8gbWUuIEJ1dCBpdCBsb29rcyBsaWtlIHNvbWUKPiA+Pj4+PiB2ZHBhX2NvbmZpZ19vcHMvdmly
dGlvX2NvbmZpZ19vcHMgc3VjaCBhcyBzZXRfc3RhdHVzKCkgZGlkbid0IGhhdmUgYQo+ID4+Pj4+
IHJldHVybiB2YWx1ZS4gIE5vdyBJIGFkZCBhIFdBUk5fT04oKSBmb3IgdGhlIGZhaWx1cmUuIERv
IHlvdSBtZWFuIHdlCj4gPj4+Pj4gbmVlZCB0byBhZGQgc29tZSBjaGFuZ2UgZm9yIHZpcnRpbyBj
b3JlIHRvIGhhbmRsZSB0aGUgZmFpbHVyZT8KPiA+Pj4+IE1heWJlLCBidXQgSSdtIG5vdCBzdXJl
IGhvdyBoYXJkIHdlIGNhbiBkbyB0aGF0Lgo+ID4+Pj4KPiA+Pj4gV2UgbmVlZCB0byBjaGFuZ2Ug
YWxsIHZpcnRpbyBkZXZpY2UgZHJpdmVycyBpbiB0aGlzIHdheS4KPiA+Pgo+ID4+IFByb2JhYmx5
Lgo+ID4+Cj4gPj4KPiA+Pj4+IFdlIGhhZCBORUVEU19SRVNFVCBidXQgaXQgbG9va3Mgd2UgZG9u
J3QgaW1wbGVtZW50IGl0Lgo+ID4+Pj4KPiA+Pj4gQ291bGQgaXQgaGFuZGxlIHRoZSBmYWlsdXJl
IG9mIGdldF9mZWF0dXJlKCkgYW5kIGdldC9zZXRfY29uZmlnKCk/Cj4gPj4KPiA+PiBMb29rcyBu
b3Q6Cj4gPj4KPiA+PiAiCj4gPj4KPiA+PiBUaGUgZGV2aWNlIFNIT1VMRCBzZXQgREVWSUNFX05F
RURTX1JFU0VUIHdoZW4gaXQgZW50ZXJzIGFuIGVycm9yIHN0YXRlCj4gPj4gdGhhdCBhIHJlc2V0
IGlzIG5lZWRlZC4gSWYgRFJJVkVSX09LIGlzIHNldCwgYWZ0ZXIgaXQgc2V0cwo+ID4+IERFVklD
RV9ORUVEU19SRVNFVCwgdGhlIGRldmljZSBNVVNUIHNlbmQgYSBkZXZpY2UgY29uZmlndXJhdGlv
biBjaGFuZ2UKPiA+PiBub3RpZmljYXRpb24gdG8gdGhlIGRyaXZlci4KPiA+Pgo+ID4+ICIKPiA+
Pgo+ID4+IFRoaXMgbG9va3MgaW1wbGllcyB0aGF0IE5FRURTX1JFU0VUIG1heSBvbmx5IHdvcmsg
YWZ0ZXIgZGV2aWNlIGlzCj4gPj4gcHJvYmVkLiBCdXQgaW4gdGhlIGN1cnJlbnQgZGVzaWduLCBl
dmVuIHRoZSByZXNldCgpIGlzIG5vdCByZWxpYWJsZS4KPiA+Pgo+ID4+Cj4gPj4+PiBPciBhIHJv
dWdoIGlkZWEgaXMgdGhhdCBtYXliZSBuZWVkIHNvbWUgcmVsYXhpbmcgdG8gYmUgY291cGxlZCBs
b29zZWx5Cj4gPj4+PiB3aXRoIHVzZXJzcGFjZS4gRS5nIHRoZSBkZXZpY2UgKGNvbnRyb2wgcGF0
aCkgaXMgaW1wbGVtZW50ZWQgaW4gdGhlCj4gPj4+PiBrZXJuZWwgYnV0IHRoZSBkYXRhcGF0aCBp
cyBpbXBsZW1lbnRlZCBpbiB0aGUgdXNlcnNwYWNlIGxpa2UgVFVOL1RBUC4KPiA+Pj4+Cj4gPj4+
IEkgdGhpbmsgaXQgY2FuIHdvcmsgZm9yIG1vc3QgY2FzZXMuIE9uZSBwcm9ibGVtIGlzIHRoYXQg
dGhlIHNldF9jb25maWcKPiA+Pj4gbWlnaHQgY2hhbmdlIHRoZSBiZWhhdmlvciBvZiB0aGUgZGF0
YSBwYXRoIGF0IHJ1bnRpbWUsIGUuZy4KPiA+Pj4gdmlydG5ldF9zZXRfbWFjX2FkZHJlc3MoKSBp
biB0aGUgdmlydGlvLW5ldCBkcml2ZXIgYW5kCj4gPj4+IGNhY2hlX3R5cGVfc3RvcmUoKSBpbiB0
aGUgdmlydGlvLWJsayBkcml2ZXIuIE5vdCBzdXJlIGlmIHRoaXMgcGF0aCBpcwo+ID4+PiBhYmxl
IHRvIHJldHVybiBiZWZvcmUgdGhlIGRhdGFwYXRoIGlzIGF3YXJlIG9mIHRoaXMgY2hhbmdlLgo+
ID4+Cj4gPj4gR29vZCBwb2ludC4KPiA+Pgo+ID4+IEJ1dCBzZXRfY29uZmlnKCkgc2hvdWxkIGJl
IHJhcmU6Cj4gPj4KPiA+PiBFLmcgaW4gdGhlIGNhc2Ugb2YgdmlydGlvLW5ldCB3aXRoIFZFUlNJ
T05fMSwgY29uZmlnIHNwYWNlIGlzIHJlYWQgb25seSwKPiA+PiBhbmQgaXQgd2FzIHNldCB2aWEg
Y29udHJvbCB2cS4KPiA+Pgo+ID4+IEZvciBibG9jaywgd2UgY2FuCj4gPj4KPiA+PiAxKSBzdGFy
dCBmcm9tIHdpdGhvdXQgV0NFIG9yCj4gPj4gMikgd2UgYWRkIGEgY29uZmlnIGNoYW5nZSBub3Rp
ZmljYXRpb24gdG8gdXNlcnNwYWNlIG9yCj4gPiBJIHByZWZlciB0aGlzIHdheS4gQW5kIEkgdGhp
bmsgd2UgYWxzbyBuZWVkIHRvIGRvIHNpbWlsYXIgdGhpbmdzIGZvcgo+ID4gc2V0L2dldF92cV9z
dGF0ZSgpLgo+Cj4KPiBZZXMsIEkgYWdyZWUuCj4KCkhpIEphc29uLAoKTm93IEknbSB3b3JraW5n
IG9uIHRoaXMuIEJ1dCBJIGZvdW5kIHRoZSBjb25maWcgY2hhbmdlIG5vdGlmaWNhdGlvbgptdXN0
IGJlIHN5bmNocm9ub3VzIGluIHRoZSB2aXJ0aW8tYmxrIGNhc2UsIHdoaWNoIG1lYW5zIHRoZSBr
ZXJuZWwKc3RpbGwgbmVlZHMgdG8gd2FpdCBmb3IgdGhlIHJlc3BvbnNlIGZyb20gdXNlcnNwYWNl
IGluIHNldF9jb25maWcoKS4KT3RoZXJ3aXNlLCBzb21lIEkvT3MgbWlnaHQgc3RpbGwgcnVuIHRo
ZSBvbGQgd2F5IGFmdGVyIHdlIGNoYW5nZSB0aGUKY2FjaGVfdHlwZSBpbiBzeXNmcy4KClRoZSBz
aW1wbGUgd2F5cyB0byBzb2x2ZSB0aGlzIHByb2JsZW0gYXJlOgoKMS4gT25seSBzdXBwb3J0IHJl
YWQtb25seSBjb25maWcgc3BhY2UsIGRpc2FibGUgV0NFIGFzIHlvdSBzdWdnZXN0ZWQKMi4gQWRk
IGEgcmV0dXJuIHZhbHVlIHRvIHNldF9jb25maWcoKSBhbmQgaGFuZGxlIHRoZSBmYWlsdXJlIG9u
bHkgaW4KdmlydGlvLWJsayBkcml2ZXIKMy4gUHJpbnQgc29tZSB3YXJuaW5ncyBhZnRlciB0aW1l
b3V0IHNpbmNlIGl0IG9ubHkgYWZmZWN0cyB0aGUKZGF0YXBsYW5lIHdoaWNoIGlzIHVuZGVyIHVz
ZXJzcGFjZSdzIGNvbnRyb2wKCkFueSBzdWdnZXN0aW9ucz8KClRoYW5rcywKWW9uZ2ppCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcg
bGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
