Return-Path: <SRS0=I0uF=LX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFE4C11F6A
	for <iommu@archiver.kernel.org>; Tue, 29 Jun 2021 08:14:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CD9361DC2
	for <iommu@archiver.kernel.org>; Tue, 29 Jun 2021 08:14:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CD9361DC2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D9350402BF;
	Tue, 29 Jun 2021 08:14:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i7rLT0S6Rn2d; Tue, 29 Jun 2021 08:14:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2CFD040223;
	Tue, 29 Jun 2021 08:14:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07454C0010;
	Tue, 29 Jun 2021 08:14:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C9E97C000E
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 08:14:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AFC906075F
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 08:14:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lsqwcl81Ue3I for <iommu@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 08:14:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 313516058B
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 08:14:47 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id c17so8939092ejk.13
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 01:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=uptPqcgshGnCftIWPnxGiyLOnUUUIP0/+ojiVFO1k00=;
 b=DRDFZWTpGi9GCyTDEZBHK+CH/M843cbtTy9vUm8a5IsHg/jkfiUZbd4xYJX6iZu6cW
 9GFiPjoCONUMKxg5SnLXbhDBJ/pjzDoy1JqsZXHVy8Kr2mESTA8qWpG1fam0YYiIMbhU
 9GQywd2enJcCN300YNcOenjqf+z61wovjpxOBODz/aIV6xIqUGQr1Ssg3Hyiv4mAs1Cc
 kfrvmN8IkAPcaOiP2ZLt/twpqM4r/ihXgA9G7NK7+twdlzhXEEjkO9OxziYqElX+Wri1
 /EcksaYxLEvAl4P9igdr5L643F8OFvKS3ZRNWd9sxRl+uBkLH/YyNWfUL3Qa4HWi9OmH
 NBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=uptPqcgshGnCftIWPnxGiyLOnUUUIP0/+ojiVFO1k00=;
 b=EFHn2yt9cqQ5zEUhX4ELUP7zzIfbfGsTuBPiSwBFVEkL/jL49IMWewrA4azcycA82d
 ovpJRJwv1zlkpMGLWofeynoZVf5hYFR3dlwqBX3fO4P7sEh4yEYIPWiaFi+0dJjj4oIM
 R9vhbuQCZ3mgi3I1iiMpQJh/2gbEAyPPXI2CscNW6uCKQgoPWqD4dXRxEPkEfFECLtXt
 8LphDuw7TV+nl2Tm+pW7khujTIStcEwL2K3ciWpHmJClUJC64fdmcJ7BK5gS628fojah
 E/7uwzQ0zKBLW9gAFgHvpY2UK/lqTyZ3oGe9QXct5aWl5zSUKWYfLHelTetxGyf1nShb
 qHHQ==
X-Gm-Message-State: AOAM533sPqHaliOEqPT++qjMJk7FhC79qqv/zmqpk16594Gu4uhJWdSP
 ID5hyJ1t3f+TPyulLn29SEI442I1OUYVno+ytCgV
X-Google-Smtp-Source: ABdhPJzdlnMCYGA3kLT4t5c8ykTQcQqn/qmqlv/E8TGGEpG2riZ7T0plVIhIHa9FvZNn80TVOmuS6b2nFy6yQNioXsA=
X-Received: by 2002:a17:906:7142:: with SMTP id
 z2mr28262180ejj.427.1624954486045; 
 Tue, 29 Jun 2021 01:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210615141331.407-1-xieyongji@bytedance.com>
 <20210628103309.GA205554@storage2.sh.intel.com>
 <bdbe3a79-e5ce-c3a5-4c68-c11c65857377@redhat.com>
 <BYAPR11MB2662FFF6140A4C634648BB2E8C039@BYAPR11MB2662.namprd11.prod.outlook.com>
 <41cc419e-48b5-6755-0cb0-9033bd1310e4@redhat.com>
 <BYAPR11MB266276002F42D91FCE6E83CE8C029@BYAPR11MB2662.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB266276002F42D91FCE6E83CE8C029@BYAPR11MB2662.namprd11.prod.outlook.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Tue, 29 Jun 2021 16:14:35 +0800
Message-ID: <CACycT3sfZCpWqB+GKQYMi3WjOkU0jAkBPU-u+MHHDCbLUvvu4w@mail.gmail.com>
Subject: Re: RE: [PATCH v8 00/10] Introduce VDUSE - vDPA Device in Userspace
To: "Liu, Xiaodong" <xiaodong.liu@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "christian.brauner@canonical.com" <christian.brauner@canonical.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "willy@infradead.org" <willy@infradead.org>,
 "hch@infradead.org" <hch@infradead.org>,
 "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
 "sgarzare@redhat.com" <sgarzare@redhat.com>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "rdunlap@infradead.org" <rdunlap@infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "bcrl@kvack.org" <bcrl@kvack.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "mika.penttila@nextfour.com" <mika.penttila@nextfour.com>
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

T24gVHVlLCBKdW4gMjksIDIwMjEgYXQgMzo1NiBQTSBMaXUsIFhpYW9kb25nIDx4aWFvZG9uZy5s
aXVAaW50ZWwuY29tPiB3cm90ZToKPgo+Cj4KPiA+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0K
PiA+RnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPiA+U2VudDogVHVlc2Rh
eSwgSnVuZSAyOSwgMjAyMSAxMjoxMSBQTQo+ID5UbzogTGl1LCBYaWFvZG9uZyA8eGlhb2Rvbmcu
bGl1QGludGVsLmNvbT47IFhpZSBZb25namkKPiA+PHhpZXlvbmdqaUBieXRlZGFuY2UuY29tPjsg
bXN0QHJlZGhhdC5jb207IHN0ZWZhbmhhQHJlZGhhdC5jb207Cj4gPnNnYXJ6YXJlQHJlZGhhdC5j
b207IHBhcmF2QG52aWRpYS5jb207IGhjaEBpbmZyYWRlYWQub3JnOwo+ID5jaHJpc3RpYW4uYnJh
dW5lckBjYW5vbmljYWwuY29tOyByZHVubGFwQGluZnJhZGVhZC5vcmc7IHdpbGx5QGluZnJhZGVh
ZC5vcmc7Cj4gPnZpcm9AemVuaXYubGludXgub3JnLnVrOyBheGJvZUBrZXJuZWwuZGs7IGJjcmxA
a3ZhY2sub3JnOyBjb3JiZXRAbHduLm5ldDsKPiA+bWlrYS5wZW50dGlsYUBuZXh0Zm91ci5jb207
IGRhbi5jYXJwZW50ZXJAb3JhY2xlLmNvbTsgam9yb0A4Ynl0ZXMub3JnOwo+ID5ncmVna2hAbGlu
dXhmb3VuZGF0aW9uLm9yZwo+ID5DYzogc29uZ211Y2h1bkBieXRlZGFuY2UuY29tOyB2aXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZzsKPiA+bmV0ZGV2QHZnZXIua2VybmVs
Lm9yZzsga3ZtQHZnZXIua2VybmVsLm9yZzsgbGludXgtZnNkZXZlbEB2Z2VyLmtlcm5lbC5vcmc7
Cj4gPmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnCj4gPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjggMDAvMTBdIEludHJvZHVjZSBWRFVT
RSAtIHZEUEEgRGV2aWNlIGluIFVzZXJzcGFjZQo+ID4KPiA+Cj4gPuWcqCAyMDIxLzYvMjgg5LiL
5Y2IMTo1NCwgTGl1LCBYaWFvZG9uZyDlhpnpgZM6Cj4gPj4+IFNldmVyYWwgaXNzdWVzOgo+ID4+
Pgo+ID4+PiAtIFZEVVNFIG5lZWRzIHRvIGxpbWl0IHRoZSB0b3RhbCBzaXplIG9mIHRoZSBib3Vu
Y2UgYnVmZmVycyAoNjRNIGlmIEkgd2FzIG5vdAo+ID4+PiB3cm9uZykuIERvZXMgaXQgd29yayBm
b3IgU1BESz8KPiA+PiBZZXMsIEphc29uLiBJdCBpcyBlbm91Z2ggYW5kIHdvcmtzIGZvciBTUERL
Lgo+ID4+IFNpbmNlIGl0J3MgYSBraW5kIG9mIGJvdW5jZSBidWZmZXIgbWFpbmx5IGZvciBpbi1m
bGlnaHQgSU8sIHNvIGxpbWl0ZWQgc2l6ZSBsaWtlCj4gPj4gNjRNQiBpcyBlbm91Z2guCj4gPgo+
ID4KPiA+T2suCj4gPgo+ID4KPiA+Pgo+ID4+PiAtIFZEVVNFIGNhbiB1c2UgaHVnZXBhZ2VzIGJ1
dCBJJ20gbm90IHN1cmUgd2UgY2FuIG1hbmRhdGUgaHVnZXBhZ2VzIChvcgo+ID53ZQo+ID4+PiBu
ZWVkIGludHJvZHVjZSBuZXcgZmxhZ3MgZm9yIHN1cHBvcnRpbmcgdGhpcykKPiA+PiBTYW1lIHdp
dGggeW91ciB3b3JyeSwgSSdtIGFmcmFpZCB0b28gdGhhdCBpdCBpcyBhIGhhcmQgZm9yIGEga2Vy
bmVsIG1vZHVsZQo+ID4+IHRvIGRpcmVjdGx5IHByZWFsbG9jYXRlIGh1Z2VwYWdlIGludGVybmFs
Lgo+ID4+IFdoYXQgSSB0cmllZCBpcyB0aGF0Ogo+ID4+IDEuIEEgc2ltcGxlIGFnZW50IGRhZW1v
biAocmVwcmVzZW50cyBmb3Igb25lIGRldmljZSkgIGBwcmVhbGxvY2F0ZXNgIGFuZCBtYXBzCj4g
Pj4gICAgICBkb3plbnMgb2YgMk1CIGh1Z2VwYWdlcyAobGlrZSA2NE1CKSBmb3Igb25lIGRldmlj
ZS4KPiA+PiAyLiBUaGUgZGFlbW9uIHBhc3NlcyBpdHMgbWFwcGluZyBhZGRyJmxlbiBhbmQgaHVn
ZXBhZ2UgZmQgdG8ga2VybmVsCj4gPj4gICAgICBtb2R1bGUgdGhyb3VnaCBjcmVhdGVkIElPQ1RM
Lgo+ID4+IDMuIEtlcm5lbCBtb2R1bGUgcmVtYXBzIHRoZSBodWdlcGFnZXMgaW5zaWRlIGtlcm5l
bC4KPiA+Cj4gPgo+ID5TdWNoIG1vZGVsIHNob3VsZCB3b3JrLCBidXQgdGhlIG1haW4gImlzc3Vl
IiBpcyB0aGF0IGl0IGludHJvZHVjZQo+ID5vdmVyaGVhZHMgaW4gdGhlIGNhc2Ugb2Ygdmhvc3Qt
dkRQQS4KPiA+Cj4gPk5vdGUgdGhhdCBpbiB0aGUgY2FzZSBvZiB2aG9zdC12RFBBLCB3ZSBkb24n
dCB1c2UgYm91bmNlIGJ1ZmZlciwgdGhlCj4gPnVzZXJzcGFjZSBwYWdlcyB3ZXJlIHNoYXJlZCBk
aXJlY3RseS4KPiA+Cj4gPkFuZCBzaW5jZSBETUEgaXMgbm90IGRvbmUgcGVyIHBhZ2UsIGl0IHBy
ZXZlbnRzIHVzIGZyb20gdXNpbmcgdHJpY2tzCj4gPmxpa2Ugdm1faW5zZXJ0X3BhZ2UoKSBpbiB0
aG9zZSBjYXNlcy4KPiA+Cj4KPiBZZXMsIHJlYWxseSwgaXQncyBhIHByb2JsZW0gdG8gaGFuZGxl
IHZob3N0LXZEUEEgY2FzZS4KPiBCdXQgdGhlcmUgYXJlIGFscmVhZHkgc2V2ZXJhbCBzb2x1dGlv
bnMgdG8gZ2V0IFZNIHNlcnZlZCwgbGlrZSB2aG9zdC11c2VyLAo+IHZmaW8tdXNlciwgc28gYXQg
bGVhc3QgZm9yIFNQREssIGl0IHdvbid0IHNlcnZlIFZNIHRocm91Z2ggVkRVU0UuIElmIGEgdXNl
cgo+IHN0aWxsIHdhbnQgdG8gZG8gdGhhdCwgdGhlbiB0aGUgdXNlciBzaG91bGQgdG9sZXJhdGUg
SW50cm9kdWNlZCBvdmVyaGVhZC4KPgo+IEluIG90aGVyIHdvcmRzLCBzb2Z0d2FyZSBiYWNrZW5k
IGxpa2UgU1BESywgd2lsbCBhcHByZWNpYXRlIHRoZSB2aXJ0aW8KPiBkYXRhcGF0aCBvZiBWRFVT
RSB0byBzZXJ2ZSBsb2NhbCBob3N0IGluc3RlYWQgb2YgVk0uIFRoYXQncyB3aHkgSSBhbHNvIGRy
YWZ0ZWQKPiBhICJ2aXJ0aW8tbG9jYWwiIHRvIGJyaWRnZSB2aG9zdC11c2VyIHRhcmdldCBhbmQg
bG9jYWwgaG9zdCBrZXJuZWwgdmlydGlvLWJsay4KPgo+ID4KPiA+PiA0LiBWaG9zdCB1c2VyIHRh
cmdldCBnZXRzIGFuZCBtYXBzIGh1Z2VwYWdlIGZkIGZyb20ga2VybmVsIG1vZHVsZQo+ID4+ICAg
ICAgaW4gdmhvc3QtdXNlciBtc2cgdGhyb3VnaCBVbml4IERvbWFpbiBTb2NrZXQgY21zZy4KPiA+
PiBUaGVuIGtlcm5lbCBtb2R1bGUgYW5kIHRhcmdldCBtYXAgb24gdGhlIHNhbWUgaHVnZXBhZ2Ug
YmFzZWQKPiA+PiBib3VuY2UgYnVmZmVyIGZvciBpbi1mbGlnaHQgSU8uCj4gPj4KPiA+PiBJZiB0
aGVyZSBpcyBvbmUgb3B0aW9uIGluIFZEVVNFIHRvIG1hcCB1c2Vyc3BhY2UgcHJlYWxsb2NhdGVk
IG1lbW9yeSwgdGhlbgo+ID4+IFZEVVNFIHNob3VsZCBiZSBhYmxlIHRvIG1hbmRhdGUgaXQgZXZl
biBpdCBpcyBodWdlcGFnZSBiYXNlZC4KPiA+Pgo+ID4KPiA+QXMgYWJvdmUsIHRoaXMgcmVxdWly
ZXMgc29tZSBraW5kIG9mIHJlLWRlc2lnbiBzaW5jZSBWRFVTRSBkZXBlbmRzIG9uCj4gPnRoZSBt
b2RlbCBvZiBtbWFwKE1BUF9TSEFSRUQpIGluc3RlYWQgb2YgdW1lbSByZWdpc3RlcmluZy4KPgo+
IEdvdCBpdCwgSmFzb24sIHRoaXMgbWF5IGJlIGhhcmQgZm9yIGN1cnJlbnQgdmVyc2lvbiBvZiBW
RFVTRS4KPiBNYXliZSB3ZSBjYW4gY29uc2lkZXIgdGhlc2Ugb3B0aW9ucyBhZnRlciBWRFVTRSBt
ZXJnZWQgbGF0ZXIuCj4KPiBTaW5jZSBpZiBWRFVTRSBkYXRhcGF0aCBjb3VsZCBiZSBkaXJlY3Rs
eSBsZXZlcmFnZWQgYnkgdmhvc3QtdXNlciB0YXJnZXQsCj4gaXRzIHZhbHVlIHdpbGwgYmUgcHJv
cGFnYXRlZCBpbW1lZGlhdGVseS4KPgoKQWdyZWVk77yBCgpUaGFua3MsCllvbmdqaQpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxp
c3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
