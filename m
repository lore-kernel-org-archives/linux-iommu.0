Return-Path: <SRS0=nChL=KW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDFFC4707F
	for <iommu@archiver.kernel.org>; Thu, 27 May 2021 10:14:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83C56613B5
	for <iommu@archiver.kernel.org>; Thu, 27 May 2021 10:14:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83C56613B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 43A43402D2;
	Thu, 27 May 2021 10:14:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4C3Wsn4GJsIH; Thu, 27 May 2021 10:14:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id DD3DD401EA;
	Thu, 27 May 2021 10:14:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F4C5C000E;
	Thu, 27 May 2021 10:14:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 326AAC0001
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 10:14:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 16134826FF
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 10:14:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bjcU-rOnUn8m for <iommu@lists.linux-foundation.org>;
 Thu, 27 May 2021 10:14:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CE2318267C
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 10:14:41 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id df21so223569edb.3
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 03:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=o38M2BO4ULC4BwKVVDJHYXw+IueHUfFLXYDhWYbT5Ig=;
 b=bk97lq21A/Gg9EU/Cabtt5Dqiuz3zBqg0ZUgn7vHbNo202Sf8zs+esbsZi1472wnDw
 S7tg6T6IbhEKaYeIj4ycsX234NuYYQ0O03FJH5OuiLMpN12/IGb9B/GLV656R4LkrXT7
 zQXhfkYtCReY5f9nCUn7YrhTXkoz5KTPkbYMp2eVWnOvCvOgMk7Ao4RZ5Kt3v2UB38LU
 FgaCGvVGlM5kjH6PanAP74M5XXJO0vEBEDZcBdVLoVPKz7aiDJuuycVw1/jPmGZ/Y2Zw
 NVvS36r16Wba8DeiGMEViGPX9yGp3JsaaE96mEEaPQwksZ0ldz0nzt72uYtVn0AqNCTd
 81Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=o38M2BO4ULC4BwKVVDJHYXw+IueHUfFLXYDhWYbT5Ig=;
 b=VZ9HNhC1tmP1BXfzaQ+GN/AIigwuL3uluwWxkAEDQeqUsO6D3wfwCoe7v5LsCXGBFO
 0wZ6L7amwy+rPhgqwSbuOx8DGPnQI8qlxFVNC2Dzl4HLWVqdbAemWIS7qGclbUzOCO5B
 gkNLgbwAgudi3pws9hrjSn7Ch3MFAlveluVOY1xsD577A3Ky8AkG6h8pVPmlI/UBRcgE
 TG6IkI9SFFu0msceQnwVnqZxVpj71cmJkrivR6gnffYFQ7fTTjPrSN4hmUQgr8KPS0Eq
 cSWoJ1nEfMFeyYef4deD/hkwQ2hR9CmzYVW06MnHJ89IG34l/no3IFcTh87JoC1sT4Ag
 DexA==
X-Gm-Message-State: AOAM531XKTBaR1Mpn4e54TIuP/3iocVMagz5XC1kgxngdvy4yA+xsba8
 hYRCA03WnoRKYN9mO9EJqiI4OfJEHzDJXcCEFSdW
X-Google-Smtp-Source: ABdhPJxWXHvU/O2LATe1oBP0kHpNNov+YKoz7byZgiRDTGMJZExbTJNux7H0l7VRJaIaAseiGKHKWtgXJ2fM2OTaKZE=
X-Received: by 2002:a05:6402:4252:: with SMTP id
 g18mr3221715edb.195.1622110479663; 
 Thu, 27 May 2021 03:14:39 -0700 (PDT)
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
 <3cc7407d-9637-227e-9afa-402b6894d8ac@redhat.com>
In-Reply-To: <3cc7407d-9637-227e-9afa-402b6894d8ac@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Thu, 27 May 2021 18:14:27 +0800
Message-ID: <CACycT3s6SkER09KL_Ns9d03quYSKOuZwd3=HJ_s1SL7eH7y5gA@mail.gmail.com>
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

T24gVGh1LCBNYXkgMjcsIDIwMjEgYXQgNDo0MyBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPgo+Cj4g5ZyoIDIwMjEvNS8yNyDkuIvljYg0OjQxLCBKYXNvbiBXYW5n
IOWGmemBkzoKPiA+Cj4gPiDlnKggMjAyMS81LzI3IOS4i+WNiDM6MzQsIFlvbmdqaSBYaWUg5YaZ
6YGTOgo+ID4+IE9uIFRodSwgTWF5IDI3LCAyMDIxIGF0IDE6NDAgUE0gSmFzb24gV2FuZyA8amFz
b3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPj4+Cj4gPj4+IOWcqCAyMDIxLzUvMjcg5LiL5Y2I
MTowOCwgWW9uZ2ppIFhpZSDlhpnpgZM6Cj4gPj4+PiBPbiBUaHUsIE1heSAyNywgMjAyMSBhdCAx
OjAwIFBNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4gPj4+PiB3cm90ZToKPiA+
Pj4+PiDlnKggMjAyMS81LzI3IOS4i+WNiDEyOjU3LCBZb25namkgWGllIOWGmemBkzoKPiA+Pj4+
Pj4gT24gVGh1LCBNYXkgMjcsIDIwMjEgYXQgMTI6MTMgUE0gSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4KPiA+Pj4+Pj4gd3JvdGU6Cj4gPj4+Pj4+PiDlnKggMjAyMS81LzE3IOS4i+WN
iDU6NTUsIFhpZSBZb25namkg5YaZ6YGTOgo+ID4+Pj4+Pj4+ICsKPiA+Pj4+Pj4+PiArc3RhdGlj
IGludCB2ZHVzZV9kZXZfbXNnX3N5bmMoc3RydWN0IHZkdXNlX2RldiAqZGV2LAo+ID4+Pj4+Pj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgdmR1c2VfZGV2X21zZyAqbXNnKQo+
ID4+Pj4+Pj4+ICt7Cj4gPj4+Pj4+Pj4gKyAgICAgaW5pdF93YWl0cXVldWVfaGVhZCgmbXNnLT53
YWl0cSk7Cj4gPj4+Pj4+Pj4gKyAgICAgc3Bpbl9sb2NrKCZkZXYtPm1zZ19sb2NrKTsKPiA+Pj4+
Pj4+PiArICAgICB2ZHVzZV9lbnF1ZXVlX21zZygmZGV2LT5zZW5kX2xpc3QsIG1zZyk7Cj4gPj4+
Pj4+Pj4gKyAgICAgd2FrZV91cCgmZGV2LT53YWl0cSk7Cj4gPj4+Pj4+Pj4gKyAgICAgc3Bpbl91
bmxvY2soJmRldi0+bXNnX2xvY2spOwo+ID4+Pj4+Pj4+ICsgICAgIHdhaXRfZXZlbnRfa2lsbGFi
bGUobXNnLT53YWl0cSwgbXNnLT5jb21wbGV0ZWQpOwo+ID4+Pj4+Pj4gV2hhdCBoYXBwZW5zIGlm
IHRoZSB1c2Vyc3BhY2UobWFsaWNvdXMpIGRvZXNuJ3QgZ2l2ZSBhIHJlc3BvbnNlCj4gPj4+Pj4+
PiBmb3JldmVyPwo+ID4+Pj4+Pj4KPiA+Pj4+Pj4+IEl0IGxvb2tzIGxpa2UgYSBET1MuIElmIHll
cywgd2UgbmVlZCB0byBjb25zaWRlciBhIHdheSB0byBmaXggdGhhdC4KPiA+Pj4+Pj4+Cj4gPj4+
Pj4+IEhvdyBhYm91dCB1c2luZyB3YWl0X2V2ZW50X2tpbGxhYmxlX3RpbWVvdXQoKSBpbnN0ZWFk
Pwo+ID4+Pj4+IFByb2JhYmx5LCBhbmQgdGhlbiB3ZSBuZWVkIGNob29zZSBhIHN1aXRhYmxlIHRp
bWVvdXQgYW5kIG1vcmUKPiA+Pj4+PiBpbXBvcnRhbnQsCj4gPj4+Pj4gbmVlZCB0byByZXBvcnQg
dGhlIGZhaWx1cmUgdG8gdmlydGlvLgo+ID4+Pj4+Cj4gPj4+PiBNYWtlcyBzZW5zZSB0byBtZS4g
QnV0IGl0IGxvb2tzIGxpa2Ugc29tZQo+ID4+Pj4gdmRwYV9jb25maWdfb3BzL3ZpcnRpb19jb25m
aWdfb3BzIHN1Y2ggYXMgc2V0X3N0YXR1cygpIGRpZG4ndCBoYXZlIGEKPiA+Pj4+IHJldHVybiB2
YWx1ZS4gIE5vdyBJIGFkZCBhIFdBUk5fT04oKSBmb3IgdGhlIGZhaWx1cmUuIERvIHlvdSBtZWFu
IHdlCj4gPj4+PiBuZWVkIHRvIGFkZCBzb21lIGNoYW5nZSBmb3IgdmlydGlvIGNvcmUgdG8gaGFu
ZGxlIHRoZSBmYWlsdXJlPwo+ID4+Pgo+ID4+PiBNYXliZSwgYnV0IEknbSBub3Qgc3VyZSBob3cg
aGFyZCB3ZSBjYW4gZG8gdGhhdC4KPiA+Pj4KPiA+PiBXZSBuZWVkIHRvIGNoYW5nZSBhbGwgdmly
dGlvIGRldmljZSBkcml2ZXJzIGluIHRoaXMgd2F5Lgo+ID4KPiA+Cj4gPiBQcm9iYWJseS4KPiA+
Cj4gPgo+ID4+Cj4gPj4+IFdlIGhhZCBORUVEU19SRVNFVCBidXQgaXQgbG9va3Mgd2UgZG9uJ3Qg
aW1wbGVtZW50IGl0Lgo+ID4+Pgo+ID4+IENvdWxkIGl0IGhhbmRsZSB0aGUgZmFpbHVyZSBvZiBn
ZXRfZmVhdHVyZSgpIGFuZCBnZXQvc2V0X2NvbmZpZygpPwo+ID4KPiA+Cj4gPiBMb29rcyBub3Q6
Cj4gPgo+ID4gIgo+ID4KPiA+IFRoZSBkZXZpY2UgU0hPVUxEIHNldCBERVZJQ0VfTkVFRFNfUkVT
RVQgd2hlbiBpdCBlbnRlcnMgYW4gZXJyb3Igc3RhdGUKPiA+IHRoYXQgYSByZXNldCBpcyBuZWVk
ZWQuIElmIERSSVZFUl9PSyBpcyBzZXQsIGFmdGVyIGl0IHNldHMKPiA+IERFVklDRV9ORUVEU19S
RVNFVCwgdGhlIGRldmljZSBNVVNUIHNlbmQgYSBkZXZpY2UgY29uZmlndXJhdGlvbiBjaGFuZ2UK
PiA+IG5vdGlmaWNhdGlvbiB0byB0aGUgZHJpdmVyLgo+ID4KPiA+ICIKPiA+Cj4gPiBUaGlzIGxv
b2tzIGltcGxpZXMgdGhhdCBORUVEU19SRVNFVCBtYXkgb25seSB3b3JrIGFmdGVyIGRldmljZSBp
cwo+ID4gcHJvYmVkLiBCdXQgaW4gdGhlIGN1cnJlbnQgZGVzaWduLCBldmVuIHRoZSByZXNldCgp
IGlzIG5vdCByZWxpYWJsZS4KPiA+Cj4gPgo+ID4+Cj4gPj4+IE9yIGEgcm91Z2ggaWRlYSBpcyB0
aGF0IG1heWJlIG5lZWQgc29tZSByZWxheGluZyB0byBiZSBjb3VwbGVkIGxvb3NlbHkKPiA+Pj4g
d2l0aCB1c2Vyc3BhY2UuIEUuZyB0aGUgZGV2aWNlIChjb250cm9sIHBhdGgpIGlzIGltcGxlbWVu
dGVkIGluIHRoZQo+ID4+PiBrZXJuZWwgYnV0IHRoZSBkYXRhcGF0aCBpcyBpbXBsZW1lbnRlZCBp
biB0aGUgdXNlcnNwYWNlIGxpa2UgVFVOL1RBUC4KPiA+Pj4KPiA+PiBJIHRoaW5rIGl0IGNhbiB3
b3JrIGZvciBtb3N0IGNhc2VzLiBPbmUgcHJvYmxlbSBpcyB0aGF0IHRoZSBzZXRfY29uZmlnCj4g
Pj4gbWlnaHQgY2hhbmdlIHRoZSBiZWhhdmlvciBvZiB0aGUgZGF0YSBwYXRoIGF0IHJ1bnRpbWUs
IGUuZy4KPiA+PiB2aXJ0bmV0X3NldF9tYWNfYWRkcmVzcygpIGluIHRoZSB2aXJ0aW8tbmV0IGRy
aXZlciBhbmQKPiA+PiBjYWNoZV90eXBlX3N0b3JlKCkgaW4gdGhlIHZpcnRpby1ibGsgZHJpdmVy
LiBOb3Qgc3VyZSBpZiB0aGlzIHBhdGggaXMKPiA+PiBhYmxlIHRvIHJldHVybiBiZWZvcmUgdGhl
IGRhdGFwYXRoIGlzIGF3YXJlIG9mIHRoaXMgY2hhbmdlLgo+ID4KPiA+Cj4gPiBHb29kIHBvaW50
Lgo+ID4KPiA+IEJ1dCBzZXRfY29uZmlnKCkgc2hvdWxkIGJlIHJhcmU6Cj4gPgo+ID4gRS5nIGlu
IHRoZSBjYXNlIG9mIHZpcnRpby1uZXQgd2l0aCBWRVJTSU9OXzEsIGNvbmZpZyBzcGFjZSBpcyBy
ZWFkCj4gPiBvbmx5LCBhbmQgaXQgd2FzIHNldCB2aWEgY29udHJvbCB2cS4KPiA+Cj4gPiBGb3Ig
YmxvY2ssIHdlIGNhbgo+ID4KPiA+IDEpIHN0YXJ0IGZyb20gd2l0aG91dCBXQ0Ugb3IKPiA+IDIp
IHdlIGFkZCBhIGNvbmZpZyBjaGFuZ2Ugbm90aWZpY2F0aW9uIHRvIHVzZXJzcGFjZSBvcgo+ID4g
MykgZXh0ZW5kIHRoZSBzcGVjIHRvIHVzZSB2cSBpbnN0ZWFkIG9mIGNvbmZpZyBzcGFjZQo+ID4K
PiA+IFRoYW5rcwo+Cj4KPiBBbm90aGVyIHRoaW5nIGlmIHdlIHdhbnQgdG8gZ28gdGhpcyB3YXk6
Cj4KPiBXZSBuZWVkIGZpbmQgYSB3YXkgdG8gdGVybWluYXRlIHRoZSBkYXRhIHBhdGggZnJvbSB0
aGUga2VybmVsIHNpZGUsIHRvCj4gaW1wbGVtZW50IHRvIHJlc2V0IHNlbWFudGljLgo+CgpEbyB5
b3UgbWVhbiB0ZXJtaW5hdGUgdGhlIGRhdGEgcGF0aCBpbiB2ZHBhX3Jlc2V0KCkuIElzIGl0IG9r
IHRvIGp1c3QKbm90aWZ5IHVzZXJzcGFjZSB0byBzdG9wIGRhdGEgcGF0aCBhc3luY2hyb25vdXNs
eT8gVXNlcnNwYWNlIHNob3VsZApub3QgYmUgYWJsZSB0byBkbyBhbnkgSS9PIGF0IHRoYXQgdGlt
ZSBiZWNhdXNlIHRoZSBpb3RsYiBtYXBwaW5nIGlzCmFscmVhZHkgcmVtb3ZlZC4KClRoYW5rcywK
WW9uZ2ppCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlv
bW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
