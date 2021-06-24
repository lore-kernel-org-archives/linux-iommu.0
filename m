Return-Path: <SRS0=kzsj=LS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2005CC49EA7
	for <iommu@archiver.kernel.org>; Thu, 24 Jun 2021 04:46:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A848F613D9
	for <iommu@archiver.kernel.org>; Thu, 24 Jun 2021 04:46:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A848F613D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6262A83BF5;
	Thu, 24 Jun 2021 04:46:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1kh6iXHliUZm; Thu, 24 Jun 2021 04:46:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4B6DA83AB5;
	Thu, 24 Jun 2021 04:46:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD6EEC001A;
	Thu, 24 Jun 2021 04:46:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8484FC001A
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 04:46:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5C43460804
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 04:46:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BXLlrdh57ltT for <iommu@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 04:46:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E674A607AB
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 04:46:43 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id hq39so7398670ejc.5
 for <iommu@lists.linux-foundation.org>; Wed, 23 Jun 2021 21:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=qV+mylXL/2SS4mJCMLehWyslEuC3Qq8x/PXCguBgY/I=;
 b=yLsRfVae0FF0DXCc80Qe7rbCzVIrdmQDyeaVXSgU7731bg1QMqw4lgqLCxjyZUZjwu
 TDH7cb0lIajOurwizpXzJMb1Ld/YEZ/vOZ/tKUWon1ytyFmk7qtEyniUaT9wfomHXaCZ
 Q5k7DOlqy4oW2+TRbKidZkfTZk1foP9dbr9CEZLKOgBzOUjNXSWZEPhSFmyl+eKMt16P
 UetkLAJ4Ll73DccWxMTSvwQYbyiWwHF4SXeF68p10765hT8FeXCxeTOqWo6XDYYUASaW
 U0fLxWjMmOWM2r455SZayrz6m1rBoWQox1axwCaI6sMaC6VcTv4xi2V6T6wMsgxpGUUR
 4qsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=qV+mylXL/2SS4mJCMLehWyslEuC3Qq8x/PXCguBgY/I=;
 b=CjLZ8hbXD2BitH2kY0Ux28ZObHuCOGPBKQFg4s8NbBz/dw+jXmKv0MuEFvS27a1KAo
 VCGPjabWZ8Se3fmRe2kTt/UeZ6lz6Xz4vIMFLjqWEqDS7IXg7/xDDBlXcg5cMwNMTDbp
 ns1iG36v7+tSahhkLuFE75LfRBzBmO9kTHewZRu5tfQOGCdBF0OTcMS0AlHK++f9DYKP
 W0lTUPoi3gfz8BW3u3n7soUaV3gu4hVczBHF1Otsmq+x5SxPn80/NfSIQI5ubBuyN1aZ
 i5J2f1l3sAt4XlKtz82Be2O+TisRjWV9fVVag3KuxCLJWViZv+Tb2+59Hs5i5B7XURaO
 4k3g==
X-Gm-Message-State: AOAM532jKxdzVQ3r5jtoybR3hursP2JbVlKmmiCxM8NFjNQ74zbFJxph
 +VTWj0j5DVQIa4DDNRUUrMx0ooV5elqWboZZ2OI9
X-Google-Smtp-Source: ABdhPJxLv6gMYjF4IzwXDzBGPms1QJcwsfrq54qSD0tH6LJ386sUw0R2U1ERHQHkfRm0DArekdU8YwZzZP3+ubsA+P4=
X-Received: by 2002:a17:906:3c4a:: with SMTP id
 i10mr3283231ejg.372.1624510001769; 
 Wed, 23 Jun 2021 21:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210615141331.407-1-xieyongji@bytedance.com>
 <20210615141331.407-10-xieyongji@bytedance.com>
 <adfb2be9-9ed9-ca37-ac37-4cd00bdff349@redhat.com>
 <CACycT3tAON+-qZev+9EqyL2XbgH5HDspOqNt3ohQLQ8GqVK=EA@mail.gmail.com>
 <1bba439f-ffc8-c20e-e8a4-ac73e890c592@redhat.com>
 <CACycT3uzMJS7vw6MVMOgY4rb=SPfT2srV+8DPdwUVeELEiJgbA@mail.gmail.com>
 <0aeb7cb7-58e5-1a95-d830-68edd7e8ec2e@redhat.com>
 <CACycT3uuooKLNnpPHewGZ=q46Fap2P4XCFirdxxn=FxK+X1ECg@mail.gmail.com>
 <e4cdee72-b6b4-d055-9aac-3beae0e5e3e1@redhat.com>
 <CACycT3u8=_D3hCtJR+d5BgeUQMce6S7c_6P3CVfvWfYhCQeXFA@mail.gmail.com>
 <d2334f66-907c-2e9c-ea4f-f912008e9be8@redhat.com>
In-Reply-To: <d2334f66-907c-2e9c-ea4f-f912008e9be8@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Thu, 24 Jun 2021 12:46:30 +0800
Message-ID: <CACycT3uCSLUDVpQHdrmuxSuoBDg-4n22t+N-Jm2GoNNp9JYB2w@mail.gmail.com>
Subject: Re: Re: [PATCH v8 09/10] vduse: Introduce VDUSE - vDPA Device in
 Userspace
To: Jason Wang <jasowang@redhat.com>
Cc: kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christian Brauner <christian.brauner@canonical.com>,
 Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
 Christoph Hellwig <hch@infradead.org>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Stefan Hajnoczi <stefanha@redhat.com>, songmuchun@bytedance.com,
 Jens Axboe <axboe@kernel.dk>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
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

T24gVGh1LCBKdW4gMjQsIDIwMjEgYXQgMTE6MzUgQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4gd3JvdGU6Cj4KPgo+IOWcqCAyMDIxLzYvMjMg5LiL5Y2IMTo1MCwgWW9uZ2ppIFhp
ZSDlhpnpgZM6Cj4gPiBPbiBXZWQsIEp1biAyMywgMjAyMSBhdCAxMTozMSBBTSBKYXNvbiBXYW5n
IDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+Pgo+ID4+IOWcqCAyMDIxLzYvMjIg5LiL
5Y2INDoxNCwgWW9uZ2ppIFhpZSDlhpnpgZM6Cj4gPj4+IE9uIFR1ZSwgSnVuIDIyLCAyMDIxIGF0
IDM6NTAgUE0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPj4+PiDl
nKggMjAyMS82LzIyIOS4i+WNiDM6MjIsIFlvbmdqaSBYaWUg5YaZ6YGTOgo+ID4+Pj4+PiBXZSBu
ZWVkIGZpeCBhIHdheSB0byBwcm9wYWdhdGUgdGhlIGVycm9yIHRvIHRoZSB1c2Vyc3BhY2UuCj4g
Pj4+Pj4+Cj4gPj4+Pj4+IEUuZyBpZiB3ZSB3YW50IHRvIHN0b3AgdGhlIGRlaXZjZSwgd2Ugd2ls
bCBkZWxheSB0aGUgc3RhdHVzIHJlc2V0IHVudGlsCj4gPj4+Pj4+IHdlIGdldCByZXNwb3NlIGZy
b20gdGhlIHVzZXJzcGFjZT8KPiA+Pj4+Pj4KPiA+Pj4+PiBJIGRpZG4ndCBnZXQgaG93IHRvIGRl
bGF5IHRoZSBzdGF0dXMgcmVzZXQuIEFuZCBzaG91bGQgaXQgYmUgYSBEb1MKPiA+Pj4+PiB0aGF0
IHdlIHdhbnQgdG8gZml4IGlmIHRoZSB1c2Vyc3BhY2UgZG9lc24ndCBnaXZlIGEgcmVzcG9uc2Ug
Zm9yZXZlcj8KPiA+Pj4+IFlvdSdyZSByaWdodC4gU28gbGV0J3MgbWFrZSBzZXRfc3RhdHVzKCkg
Y2FuIGZhaWwgZmlyc3QsIHRoZW4gcHJvcGFnYXRlCj4gPj4+PiBpdHMgZmFpbHVyZSB2aWEgVkhP
U1RfVkRQQV9TRVRfU1RBVFVTLgo+ID4+Pj4KPiA+Pj4gT0suIFNvIHdlIG9ubHkgbmVlZCB0byBw
cm9wYWdhdGUgdGhlIGZhaWx1cmUgaW4gdGhlIHZob3N0LXZkcGEgY2FzZSwgcmlnaHQ/Cj4gPj4K
PiA+PiBJIHRoaW5rIG5vdCwgd2UgbmVlZCB0byBkZWFsIHdpdGggdGhlIHJlc2V0IGZvciB2aXJ0
aW8gYXMgd2VsbDoKPiA+Pgo+ID4+IEUuZyBpbiByZWdpc3Rlcl92aXJ0aW9fZGV2aWNlcygpLCB3
ZSBoYXZlOgo+ID4+Cj4gPj4gICAgICAgICAgIC8qIFdlIGFsd2F5cyBzdGFydCBieSByZXNldHRp
bmcgdGhlIGRldmljZSwgaW4gY2FzZSBhIHByZXZpb3VzCj4gPj4gICAgICAgICAgICAqIGRyaXZl
ciBtZXNzZWQgaXQgdXAuICBUaGlzIGFsc28gdGVzdHMgdGhhdCBjb2RlIHBhdGggYQo+ID4+IGxp
dHRsZS4gKi8KPiA+PiAgICAgICAgIGRldi0+Y29uZmlnLT5yZXNldChkZXYpOwo+ID4+Cj4gPj4g
V2UgcHJvYmFibHkgbmVlZCB0byBtYWtlIHJlc2V0IGNhbiBmYWlsIGFuZCB0aGVuIGZhaWwgdGhl
Cj4gPj4gcmVnaXN0ZXJfdmlydGlvX2RldmljZSgpIGFzIHdlbGwuCj4gPj4KPiA+IE9LLCBsb29r
cyBsaWtlIHZpcnRpb19hZGRfc3RhdHVzKCkgYW5kIHZpcnRpb19kZXZpY2VfcmVhZHkoKVsxXSBz
aG91bGQKPiA+IGJlIGFsc28gbW9kaWZpZWQgaWYgd2UgbmVlZCB0byBwcm9wYWdhdGUgdGhlIGZh
aWx1cmUgaW4gdGhlCj4gPiB2aXJ0aW8tdmRwYSBjYXNlLiBPciBkbyB3ZSBvbmx5IG5lZWQgdG8g
Y2FyZSBhYm91dCB0aGUgcmVzZXQgY2FzZT8KPiA+Cj4gPiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGttbC8yMDIxMDUxNzA5MzQyOC42NzAtMS14aWV5b25namlAYnl0ZWRhbmNlLmNvbS8K
Pgo+Cj4gTXkgdW5kZXJzdGFuZGluZyBpcyBEUklWRVJfT0sgaXMgbm90IHNvbWV0aGluZyB0aGF0
IG5lZWRzIHRvIGJlIHZhbGlkYXRlZDoKPgo+ICIKPgo+IERSSVZFUl9PSyAoNCkKPiBJbmRpY2F0
ZXMgdGhhdCB0aGUgZHJpdmVyIGlzIHNldCB1cCBhbmQgcmVhZHkgdG8gZHJpdmUgdGhlIGRldmlj
ZS4KPgo+ICIKPgo+IFNpbmNlIHRoZSBzcGVjIGRvZXNuJ3QgcmVxdWlyZSB0byByZS1yZWFkIHRo
ZSBhbmQgY2hlY2sgaWYgRFJJVkVSX09LIGlzCj4gc2V0IGluIDMuMS4xIERyaXZlciBSZXF1aXJl
bWVudHM6IERldmljZSBJbml0aWFsaXphdGlvbi4KPgo+IEl0J3MgbW9yZSBhYm91dCAidGVsbGlu
ZyB0aGUgZGV2aWNlIHRoYXQgZHJpdmVyIGlzIHJlYWR5LiIKPgo+IEJ1dCB3ZSBkb24gaGF2ZSBz
b21lIHN0YXR1cyBiaXQgdGhhdCByZXF1aXJlcyB0aGUgc3luY2hyb25pemF0aW9uIHdpdGgKPiB0
aGUgZGV2aWNlLgo+Cj4gMSkgRkVBVFVSRVNfT0ssIHNwZWMgcmVxdWlyZXMgdG8gcmUtcmVhZCB0
aGUgc3RhdHVzIGJpdCB0byBjaGVjayB3aGV0aGVyCj4gb3IgaXQgaXQgd2FzIHNldCBieSB0aGUg
ZGV2aWNlOgo+Cj4gIgo+Cj4gUmUtcmVhZCBkZXZpY2Ugc3RhdHVzIHRvIGVuc3VyZSB0aGUgRkVB
VFVSRVNfT0sgYml0IGlzIHN0aWxsIHNldDoKPiBvdGhlcndpc2UsIHRoZSBkZXZpY2UgZG9lcyBu
b3Qgc3VwcG9ydCBvdXIgc3Vic2V0IG9mIGZlYXR1cmVzIGFuZCB0aGUKPiBkZXZpY2UgaXMgdW51
c2FibGUuCj4KPiAiCj4KPiBUaGlzIGlzIHVzZWZ1bCBmb3Igc29tZSBkZXZpY2Ugd2hpY2ggY2Fu
IG9ubHkgc3VwcG9ydCBhIHN1YnNldCBvZiB0aGUKPiBmZWF0dXJlcy4gRS5nIGEgZGV2aWNlIHRo
YXQgY2FuIG9ubHkgd29yayBmb3IgcGFja2VkIHZpcnRxdWV1ZS4gVGhpcwo+IG1lYW5zIHRoZSBj
dXJyZW50IGRlc2lnbiBvZiBzZXRfZmVhdHVyZXMgd29uJ3Qgd29yaywgd2UgbmVlZCBlaXRoZXI6
Cj4KPiAxYSkgcmVsYXkgdGhlIHNldF9mZWF0dXJlcyByZXF1ZXN0IHRvIHVzZXJzcGFjZQo+Cj4g
b3IKPgo+IDFiKSBpbnRyb2R1Y2UgYSBtYW5kYXRlZF9kZXZpY2VfZmVhdHVyZXMgZHVyaW5nIGRl
dmljZSBjcmVhdGlvbiBhbmQKPiB2YWxpZGF0ZSB0aGUgZHJpdmVyIGZlYXR1cmVzIGR1cmluZyB0
aGUgc2V0X2ZlYXR1cmVzKCksIGFuZCBkb24ndCBzZXQKPiBGRUFUVVJFU19PSyBpZiB0aGV5IGRv
bid0IG1hdGNoLgo+Cj4KPiAyKSBTb21lIHRyYW5zcG9ydHMgKFBDSSkgcmVxdWlyZXMgdG8gcmUt
cmVhZCB0aGUgc3RhdHVzIHRvIGVuc3VyZSB0aGUKPiBzeW5jaHJvbml6YXRpb24uCj4KPiAiCj4K
PiBBZnRlciB3cml0aW5nIDAgdG8gZGV2aWNlX3N0YXR1cywgdGhlIGRyaXZlciBNVVNUIHdhaXQg
Zm9yIGEgcmVhZCBvZgo+IGRldmljZV9zdGF0dXMgdG8gcmV0dXJuIDAgYmVmb3JlIHJlaW5pdGlh
bGl6aW5nIHRoZSBkZXZpY2UuCj4KPiAiCj4KPiBTbyB3ZSBuZWVkIHRvIGRlYWwgd2l0aCBib3Ro
IEZFQVRVUkVTX09LIGFuZCByZXNldCwgYnV0IHByb2JhYmx5IG5vdAo+IERSSVZFUl9PSy4KPgoK
T0ssIEkgc2VlLiBUaGFua3MgZm9yIHRoZSBleHBsYW5hdGlvbi4gT25lIG1vcmUgcXVlc3Rpb24g
aXMgaG93IGFib3V0CmNsZWFyaW5nIHRoZSBjb3JyZXNwb25kaW5nIHN0YXR1cyBiaXQgaW4gZ2V0
X3N0YXR1cygpIHJhdGhlciB0aGFuCm1ha2luZyBzZXRfc3RhdHVzKCkgZmFpbC4gU2luY2UgdGhl
IHNwZWMgcmVjb21tZW5kcyB0aGlzIHdheSBmb3IKdmFsaWRhdGlvbiB3aGljaCBpcyBkb25lIGlu
IHZpcnRpb19kZXZfcmVtb3ZlKCkgYW5kCnZpcnRpb19maW5hbGl6ZV9mZWF0dXJlcygpLgoKVGhh
bmtzLApZb25namkKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
