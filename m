Return-Path: <SRS0=XPcP=LW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A21C11F66
	for <iommu@archiver.kernel.org>; Mon, 28 Jun 2021 22:31:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AEC761CF8
	for <iommu@archiver.kernel.org>; Mon, 28 Jun 2021 22:31:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AEC761CF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2F53A402AC;
	Mon, 28 Jun 2021 22:31:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6YoGr5Jhutjg; Mon, 28 Jun 2021 22:31:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B49BB402C1;
	Mon, 28 Jun 2021 22:31:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6889AC001A;
	Mon, 28 Jun 2021 22:31:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 551C1C000E
 for <iommu@lists.linux-foundation.org>; Mon, 28 Jun 2021 22:31:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3979982BF5
 for <iommu@lists.linux-foundation.org>; Mon, 28 Jun 2021 22:31:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e0stLHUufDoq for <iommu@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 22:31:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ED8298293F
 for <iommu@lists.linux-foundation.org>; Mon, 28 Jun 2021 22:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624919509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oG+hy7F4y4G5Ki5ZrHDrTCYzleu6iGOvnyW6nh8v7HI=;
 b=BywU7u4q2jBopHd4d7u2WPqOup6WF0SrQXmE8b1EZTGl1YC5ZkTPMQiUInDVG+QAdfJ4xH
 5fAL1HRcwnWUlKX8KW73x0/w+4EwTL34EPfl0INqzi1YmsgqztGfmviHS0D4M7O3YlWFUe
 2eiXKzQxIHqpBdBLd1CE/c4rAuBplgU=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-xuWkA1mDNr-wAqNhU9rdxg-1; Mon, 28 Jun 2021 18:31:48 -0400
X-MC-Unique: xuWkA1mDNr-wAqNhU9rdxg-1
Received: by mail-ot1-f72.google.com with SMTP id
 v5-20020a05683011c5b02903cb28b38d0aso14072301otq.19
 for <iommu@lists.linux-foundation.org>; Mon, 28 Jun 2021 15:31:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=f8XGtEdANUVt2mXeyRNxrhe0L7TYkYXWNRbYkehzeNA=;
 b=thvUfcLmYa7N6QtrK7J3GoEsVHFiHUj1cNwTbI+TmMzPEgXGbHhM4STFZ08RuS+wGF
 ojuYiNKV6OAzAURxsiaVURzEpXoz9ZaH2PLJ7bk8LVXJezLafqUeFtKxc9xgx3IPxIVM
 iEUJXllO5XkbIHqS0I0moz0NxeJwJ1e2psJOFn0c1fT/1ocuvhJh/vzBasyABs6yObBU
 ehqTH5OrJkPIY+rXkMeOpD8uLnt8RnpEorqLTvc+PQHghj8X6OrIUIbrZC5sWJuTXjLo
 YbSKSQpVBh84evXaUSYMfkM5eeYwDgWG3iVyh64i1kZI3lFj9iXqx/Lifb3BCBhounj6
 XGcQ==
X-Gm-Message-State: AOAM531qZeRDY3+5i+GNqgGma/Ra4VbmLdlUojud0O7chntpLx5JRskO
 Y81YaXL14swnO2mTYp7j7YyvGUpy0QHSVYddpzK/Nnn2SINMNEzYfuK9dmlzVrNa0c8WxXlRrXT
 zjUYIT/4pLiYxzLeHM7TOlv8mt98Y6A==
X-Received: by 2002:a9d:6219:: with SMTP id g25mr1586551otj.262.1624919507719; 
 Mon, 28 Jun 2021 15:31:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyseKceU6IT0HP1k2nx0wDzLm7HSSZMWZSAeWgAdz0mPZZLAzQ4VusQyiwpVah22Rg3tvX5pA==
X-Received: by 2002:a9d:6219:: with SMTP id g25mr1586520otj.262.1624919507429; 
 Mon, 28 Jun 2021 15:31:47 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
 by smtp.gmail.com with ESMTPSA id p18sm1091723oth.60.2021.06.28.15.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jun 2021 15:31:47 -0700 (PDT)
Date: Mon, 28 Jun 2021 16:31:45 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: Plan for /dev/ioasid RFC v2
Message-ID: <20210628163145.1a21cca9.alex.williamson@redhat.com>
In-Reply-To: <BN9PR11MB5433D40116BC1939B6B297EA8C039@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <MWHPR11MB1886239C82D6B66A732830B88C309@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210615101215.4ba67c86.alex.williamson@redhat.com>
 <MWHPR11MB188692A6182B1292FADB3BDB8C0F9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210616133937.59050e1a.alex.williamson@redhat.com>
 <MWHPR11MB18865DF9C50F295820D038798C0E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210617151452.08beadae.alex.williamson@redhat.com>
 <20210618001956.GA1987166@nvidia.com>
 <MWHPR11MB1886A17124605251DF394E888C0D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210618182306.GI1002214@nvidia.com>
 <BN9PR11MB5433B9C0577CF0BD8EFCC9BC8C069@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210625143616.GT2371267@nvidia.com>
 <BN9PR11MB5433D40116BC1939B6B297EA8C039@BN9PR11MB5433.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jason Wang <jasowang@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@nvidia.com>,
 "parav@mellanox.com" <parav@mellanox.com>, "Enrico Weigelt, metux IT
 consult" <lkml@metux.net>, David Gibson <david@gibson.dropbear.id.au>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Shenming Lu <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>
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

T24gTW9uLCAyOCBKdW4gMjAyMSAwMTowOToxOCArMDAwMAoiVGlhbiwgS2V2aW4iIDxrZXZpbi50
aWFuQGludGVsLmNvbT4gd3JvdGU6Cgo+ID4gRnJvbTogSmFzb24gR3VudGhvcnBlIDxqZ2dAbnZp
ZGlhLmNvbT4KPiA+IFNlbnQ6IEZyaWRheSwgSnVuZSAyNSwgMjAyMSAxMDozNiBQTQo+ID4gCj4g
PiBPbiBGcmksIEp1biAyNSwgMjAyMSBhdCAxMDoyNzoxOEFNICswMDAwLCBUaWFuLCBLZXZpbiB3
cm90ZToKPiA+ICAgCj4gPiA+IC0gICBXaGVuIHJlY2VpdmluZyB0aGUgYmluZGluZyBjYWxsIGZv
ciB0aGUgMXN0IGRldmljZSBpbiBhIGdyb3VwLCBpb21tdV9mZAo+ID4gPiAgICAgY2FsbHMgaW9t
bXVfZ3JvdXBfc2V0X2Jsb2NrX2RtYShncm91cCwgZGV2LT5kcml2ZXIpIHdoaWNoIGRvZXMKPiA+
ID4gICAgIHNldmVyYWwgdGhpbmdzOiAgCj4gPiAKPiA+IFRoZSB3aG9sZSBwcm9ibGVtIGhlcmUg
aXMgdHJ5aW5nIHRvIG1hdGNoIHRoaXMgbmV3IHdvcmxkIHdoZXJlIHdlIHdhbnQKPiA+IGRldmlj
ZXMgdG8gYmUgaW4gY2hhcmdlIG9mIHRoZWlyIG93biBJT01NVSBjb25maWd1cmF0aW9uIGFuZCB0
aGUgb2xkCj4gPiB3b3JsZCB3aGVyZSBncm91cHMgYXJlIGluIGNoYXJnZS4KPiA+IAo+ID4gSW5z
ZXJ0aW5nIHRoZSBncm91cCBmZCBhbmQgdGhlbiBjYWxsaW5nIGEgZGV2aWNlLWNlbnRyaWMKPiA+
IFZGSU9fR1JPVVBfR0VUX0RFVklDRV9GRF9ORVcgZG9lc24ndCBzb2x2ZSB0aGlzIGNvbmZsaWN0
LCBhbmQgaXNuJ3QKPiA+IG5lY2Vzc2FyeS4gICAKPiAKPiBObywgdGhpcyB3YXMgbm90IHdoYXQg
SSBtZWFudC4gVGhlcmUgaXMgbm8gZ3JvdXAgZmQgcmVxdWlyZWQgd2hlbgo+IGNhbGxpbmcgdGhp
cyBkZXZpY2UtY2VudHJpYyBpbnRlcmZhY2UuIEkgd2FzIGFjdHVhbGx5IHRhbGtpbmcgYWJvdXQ6
Cj4gCj4gCWlvbW11X2dyb3VwX3NldF9ibG9ja19kbWEoZGV2LT5ncm91cCwgZGV2LT5kcml2ZXIp
Cj4gCj4ganVzdCBiZWNhdXNlIGN1cnJlbnQgaW9tbXUgbGF5ZXIgQVBJIGlzIGdyb3VwLWNlbnRy
aWMuIFdoZXRoZXIgdGhpcwo+IHNob3VsZCBiZSBpbXByb3ZlZCBjb3VsZCBiZSBuZXh0LWxldmVs
IHRoaW5nLiBTb3JyeSBmb3Igbm90IG1ha2luZwo+IGl0IGNsZWFyIGluIHRoZSBmaXJzdCBwbGFj
ZS4KPiAKPiA+IFdlIGNhbiBhbHdheXMgZ2V0IHRoZSBncm91cCBiYWNrIGZyb20gdGhlIGRldmlj
ZSBhdCBhbnkKPiA+IHBvaW50IGluIHRoZSBzZXF1ZW5jZSBkbyB0byBhIGdyb3VwIHdpZGUgb3Bl
cmF0aW9uLiAgCj4gCj4geWVzLgo+IAo+ID4gCj4gPiBXaGF0IEkgc2F3IGFzIHRoZSBhcHBlYWwg
b2YgdGhlIHNvcnQgb2YgaWRlYSB3YXMgdG8ganVzdCBjb21wbGV0ZWx5Cj4gPiBsZWF2ZSBhbGwg
dGhlIGRpZmZpY3VsdCBtdWx0aS1kZXZpY2UtZ3JvdXAgc2NlbmFyaW9zIGJlaGluZCBvbiB0aGUg
b2xkCj4gPiBncm91cCBjZW50cmljIEFQSSBhbmQgdGhlbiB3ZSBkb24ndCBoYXZlIHRvIGRlYWwg
d2l0aCB0aGVtIGF0IGFsbCwgb3IKPiA+IGxlYXN0IG5vdCByaWdodCBhd2F5LiAgCj4gCj4geWVz
LCB0aGlzIGlzIHRoZSBzdGFnZWQgYXBwcm9hY2ggdGhhdCB3ZSBkaXNjdXNzZWQgZWFybGllci4g
YW5kCj4gdGhlIHJlYXNvbiB3aHkgSSByZWZpbmVkIHRoaXMgcHJvcG9zYWwgYWJvdXQgbXVsdGkt
ZGV2aWNlcyBncm91cCAKPiBoZXJlIGlzIGJlY2F1c2UgeW91IHdhbnQgdG8gc2VlIHNvbWUgY29u
ZmlkZW5jZSBhbG9uZyB0aGlzCj4gZGlyZWN0aW9uLiBUaHVzIEkgZXhwYW5kZWQgeW91ciBpZGVh
IGFuZCBob3BlIHRvIGFjaGlldmUgY29uc2Vuc3VzCj4gd2l0aCBBbGV4L0pvZXJnIHdobyBvYnZp
b3VzbHkgaGF2ZSBub3QgYmVlbiBjb252aW5jZWQgeWV0Lgo+IAo+ID4gCj4gPiBJJ2Qgc2VlIHNv
bWUgcHJvZ3Jlc3Npb24gd2hlcmUgaW9tbXVfZmQgb25seSB3b3JrcyB3aXRoIDE6MSBncm91cHMg
YXQKPiA+IHRoZSBzdGFydC4gT3RoZXIgc2NlbmFyaW9zIGNvbnRpbnVlIHdpdGggdGhlIG9sZCBB
UEkuICAKPiAKPiBPbmUgdUFQSSBvcGVuIGFmdGVyIGNvbXBsZXRpbmcgdGhpcyBuZXcgc2tldGNo
LiB2MSBwcm9wb3NlZCB0bwo+IGNvbmR1Y3QgYmluZGluZyAoVkZJT19CSU5EX0lPTU1VX0ZEKSBh
ZnRlciBkZXZpY2VfZmQgaXMgYWNxdWlyZWQuCj4gV2l0aCB0aGlzIHNrZXRjaCB3ZSBuZWVkIGEg
bmV3IFZGSU9fR1JPVVBfR0VUX0RFVklDRV9GRF9ORVcKPiB0byBjb21wbGV0ZSBib3RoIGluIG9u
ZSBzdGVwLiBJIHdhbnQgdG8gZ2V0IEFsZXgncyBjb25maXJtYXRpb24gd2hldGhlcgo+IGl0IHNv
dW5kcyBnb29kIHRvIGhpbSwgc2luY2UgaXQncyBiZXR0ZXIgdG8gdW5pZnkgdGhlIHVBUEkgYmV0
d2VlbiAxOjEgCj4gZ3JvdXAgYW5kIDE6TiBncm91cCBldmVuIGlmIHdlIGRvbid0IHN1cHBvcnQg
MTpOIGluIHRoZSBzdGFydC4gCgpJIGRvbid0IGxpa2UgaXQuICBJdCBkb2Vzbid0IG1ha2Ugc2Vu
c2UgdG8gbWUuICBZb3UgaGF2ZSB0aGUKZ3JvdXAtY2VudHJpYyB3b3JsZCwgd2hpY2ggbXVzdCBj
b250aW51ZSB0byBleGlzdCBhbmQgY2Fubm90IGNoYW5nZQpiZWNhdXNlIHdlIGNhbm5vdCBicmVh
ayB0aGUgdmZpbyB1YXBpLiAgV2UgY2FuIG1ha2UgZXh0ZW5zaW9ucywgd2UgY2FuCmRlZmluZSBh
IG5ldyBwYXJhbGxlbCB1YXBpLCB3ZSBjYW4gZGVwcmVjYXRlIHRoZSB1YXBpLCBidXQgaW4gdGhl
IHNob3J0CnRlcm0sIGl0IGNhbid0IGNoYW5nZS4KCkFJVUksIHRoZSBuZXcgZGV2aWNlLWNlbnRy
aWMgbW9kZWwgc3RhcnRzIHdpdGggdmZpbyBkZXZpY2UgZmlsZXMgdGhhdApjYW4gYmUgb3BlbmVk
IGRpcmVjdGx5LiAgU28gd2hhdCB0aGVuIGlzIHRoZSBwdXJwb3NlIG9mIGEgKkdST1VQKiBnZXQK
ZGV2aWNlIGZkPyAgV2h5IGlzIGEgdmZpbyB1YXBpIGludm9sdmVkIGluIHNldHRpbmcgYSBkZXZp
Y2UgY29va2llIGZvcgphbm90aGVyIHN1YnN5c3RlbT8KCkknZCBleHBlY3QgdGhhdCAvZGV2L2lv
bW11IHdpbGwgYmUgdXNlZCBieSBtdWx0aXBsZSBzdWJzeXN0ZW1zLiAgQWxsCndpbGwgd2FudCB0
byBiaW5kIGRldmljZXMgdG8gYWRkcmVzcyBzcGFjZXMsIHNvIHNob3VsZG4ndCBiaW5kaW5nIGEK
ZGV2aWNlIHRvIGFuIGlvbW11ZmQgYmUgYW4gaW9jdGwgb24gdGhlIGlvbW11ZmQsIGllLgpJT01N
VV9CSU5EX1ZGSU9fREVWSUNFX0ZELiAgTWF5YmUgd2UgZG9uJ3QgZXZlbiBuZWVkICJWRklPIiBp
biB0aGVyZSBhbmQKdGhlIGlvbW11ZmQgY29kZSBjYW4gZmlndXJlIGl0IG91dCBpbnRlcm5hbGx5
LgoKWW91J3JlIGVzc2VudGlhbGx5IHRyeWluZyB0byByZWR1Y2UgdmZpbyB0byB0aGUgZGV2aWNl
IGludGVyZmFjZS4gIFRoYXQKbmVjZXNzYXJpbHkgaW1wbGllcyB0aGF0IGlvY3RscyBvbiB0aGUg
Y29udGFpbmVyLCBncm91cCwgb3IgcGFzc2VkCnRocm91Z2ggdGhlIGNvbnRhaW5lciB0byB0aGUg
aW9tbXUgbm8gbG9uZ2VyIGV4aXN0LiAgRnJvbSBteQpwZXJzcGVjdGl2ZSwgdGhlcmUgc2hvdWxk
IGlkZWFsbHkgYmUgbm8gbmV3IHZmaW8gaW9jdGxzLiAgVGhlIHVzZXIgZ2V0cwphIGxpbWl0ZWQg
YWNjZXNzIHZmaW8gZGV2aWNlIGZkIGFuZCBlbmFibGVzIGZ1bGwgYWNjZXNzIHRvIHRoZSBkZXZp
Y2UKYnkgcmVnaXN0ZXJpbmcgaXQgdG8gdGhlIGlvbW11ZmQgc3Vic3lzdGVtICgxMDAlIHRoaXMg
bmVlZHMgdG8gYmUKZW5mb3JjZWQgdW50aWwgY2xvc2UoKSB0byBhdm9pZCByZXZva2UgaXNzdWVz
KS4gIFRoZSB1c2VyIGludGVyYWN0cwpleGNsdXNpdmVseSB3aXRoIHZmaW8gdmlhIHRoZSBkZXZp
Y2UgZmQgYW5kIHBlcmZvcm1zIGFsbCBETUEgYWRkcmVzcwpzcGFjZSByZWxhdGVkIG9wZXJhdGlv
bnMgdGhyb3VnaCB0aGUgaW9tbXVmZC4KCj4gPiBUaGVuIG1heWJlIGdyb3VwcyB3aGVyZSBhbGwg
ZGV2aWNlcyB1c2UgdGhlIHNhbWUgSU9BU0lELgo+ID4gCj4gPiBUaGVuIDE6TiBncm91cHMgaWYg
dGhlIHNvdXJjZSBkZXZpY2UgaXMgcmVsaWFibHkgaWRlbnRpZmlhYmxlLCB0aGlzCj4gPiByZXF1
aXJlcyBpb21tdSBzdWJ5c3RlbSB3b3JrIHRvIGF0dGFjaCBkb21haW5zIHRvIHN1Yi1ncm91cCBv
YmplY3RzIC0KPiA+IG5vdCBzdXJlIGl0IGlzIHdvcnRod2hpbGUuCj4gPiAKPiA+IEJ1dCBhdCBs
ZWFzdCB3ZSBjYW4gdGFsayBhYm91dCBlYWNoIHN0ZXAgd2l0aCB3ZWxsIHRob3VnaHQgb3V0IHBh
dGNoZXMKPiA+IAo+ID4gVGhlIG9ubHkgdGhpbmcgdGhhdCBuZWVkcyB0byBiZSBkb25lIHRvIGdl
dCB0aGUgMToxIHN0ZXAgaXMgdG8gYnJvYWRseQo+ID4gZGVmaW5lIGhvdyB0aGUgb3RoZXIgdHdv
IGNhc2VzIHdpbGwgd29yayBzbyB3ZSBkb24ndCBnZXQgaW50byB0cm91YmxlCj4gPiBhbmQgc2V0
IHNvbWUgd2F5IHRvIGV4Y2x1ZGUgdGhlIHByb2JsZW1hdGljIGNhc2VzIGZyb20gZXZlbiBnZXR0
aW5nIHRvCj4gPiBpb21tdV9mZCBpbiB0aGUgZmlyc3QgcGxhY2UuCj4gPiAKPiA+IEZvciBpbnN0
YW5jZSBpZiB3ZSBnbyBhaGVhZCBhbmQgY3JlYXRlIC9kZXYvdmZpby9kZXZpY2Ugbm9kZXMgd2Ug
Y291bGQKPiA+IGRvIHRoaXMgb25seSBpZiB0aGUgZ3JvdXAgd2FzIDE6MSwgb3RoZXJ3aXNlIHRo
ZSBncm91cCBjZGV2IGhhcyB0byBiZQo+ID4gdXNlZCwgYWxvbmcgd2l0aCBpdHMgQVBJLiAgCj4g
Cj4gSSBmZWVsIGZvciBWRklPIHBvc3NpYmx5IHdlIGRvbid0IG5lZWQgc2lnbmlmaWNhbnQgY2hh
bmdlIHRvIGl0cyB1QVBJIAo+IHNlcXVlbmNlLCBzaW5jZSBpdCBhbnl3YXkgbmVlZHMgdG8gc3Vw
cG9ydCBleGlzdGluZyBzZW1hbnRpY3MgZm9yIAo+IGJhY2t3YXJkIGNvbXBhdGliaWxpdHkuIFdp
dGggdGhpcyBza2V0Y2ggd2UgY2FuIGtlZXAgdmZpbyBjb250YWluZXIvCj4gZ3JvdXAgYnkgaW50
cm9kdWNpbmcgYW4gZXh0ZXJuYWwgaW9tbXUgdHlwZSB3aGljaCBpbXBsaWVzIGEgZGlmZmVyZW50
Cj4gR0VUX0RFVklDRV9GRCBzZW1hbnRpY3MuIC9kZXYvaW9tbXUgY2FuIHJlcG9ydCBhIGZkLXdp
ZGUgY2FwYWJpbGl0eQo+IGZvciB3aGV0aGVyIDE6TiBncm91cCBpcyBzdXBwb3J0ZWQgdG8gdmZp
byB1c2VyLgoKSWRlYWxseSB2ZmlvIHdvdWxkIGFsc28gYXQgbGVhc3QgYmUgYWJsZSB0byByZWdp
c3RlciBhIHR5cGUxIElPTU1VCmJhY2tlbmQgdGhyb3VnaCB0aGUgZXhpc3RpbmcgdWFwaSwgYmFj
a2VkIGJ5IHRoaXMgaW9tbXUgY29kZSwgaWUuIHdlJ2QKY3JlYXRlIGEgbmV3ICJpb21tdWZkIiAo
YnV0IHdpdGhvdXQgdGhlIHVzZXIgdmlzaWJsZSBmZCksIGJpbmQgYWxsIHRoZQpncm91cCBkZXZp
Y2VzIHRvIGl0LCBnZW5lcmF0aW5nIG91ciBvd24gZGV2aWNlIGNvb2tpZXMsIGNyZWF0ZSBhIHNp
bmdsZQppb2FzaWQgYW5kIGF0dGFjaCBhbGwgdGhlIGRldmljZXMgdG8gaXQgKGFsbCBpbnRlcm5h
bCkuICBXaGVuIHVzaW5nIHRoZQpjb21wYXRpYmlsaXR5IG1vZGUsIHVzZXJzcGFjZSBkb2Vzbid0
IGdldCBkZXZpY2UgY29va2llcywgZG9lc24ndCBnZXQKYW4gaW9tbXVmZCwgdGhleSBkbyBtYXBw
aW5ncyB0aHJvdWdoIHRoZSBjb250YWluZXIsIHdoZXJlIHZmaW8gb3ducyB0aGUKY29va2llcyBh
bmQgaW9hc2lkLgogCj4gRm9yIG5ldyBzdWJzeXN0ZW1zIHRoZXkgY2FuIGRpcmVjdGx5IGNyZWF0
ZSBkZXZpY2Ugbm9kZXMgYW5kIHJlbHkgb24KPiBpb21tdSBmZCB0byBtYW5hZ2UgZ3JvdXAgaXNv
bGF0aW9uLCB3aXRob3V0IGludHJvZHVjaW5nIGFueSBncm91cCAKPiBzZW1hbnRpY3MgaW4gaXRz
IHVBUEkuCgpDcmVhdGUgZGV2aWNlIG5vZGVzLCBiaW5kIHRoZW0gdG8gaW9tbXVmZCwgYXNzb2Np
YXRlIGNvb2tpZXMsIGF0dGFjaAppb2FzaWRzLCBldGMuICBUaGF0IHNob3VsZCBiZSB0aGUgc2Ft
ZSBmb3IgYWxsIHN1YnN5c3RlbXMsIGluY2x1ZGluZwp2ZmlvLCBpdCdzIGp1c3QgdGhlIG1hZ2lj
IGludGVybmFsIGhhbmRzaGFrZSBiZXR3ZWVuIHRoZSBkZXZpY2UKc3Vic3lzdGVtIGFuZCB0aGUg
aW9tbXVmZCBzdWJzeXN0ZW0gdGhhdCBjaGFuZ2VzLgoKPiA+ID4gICAgICAgICBhKSBDaGVjayBn
cm91cCB2aWFiaWxpdHkuIEEgZ3JvdXAgaXMgdmlhYmxlIG9ubHkgd2hlbiBhbGwgZGV2aWNlcyBp
bgo+ID4gPiAgICAgICAgICAgICB0aGUgZ3JvdXAgYXJlIGluIG9uZSBvZiBiZWxvdyBzdGF0ZXM6
Cj4gPiA+Cj4gPiA+ICAgICAgICAgICAgICAgICAqIGRyaXZlci1sZXNzCj4gPiA+ICAgICAgICAg
ICAgICAgICAqIGJvdW5kIHRvIGEgZHJpdmVyIHdoaWNoIGlzIHNhbWUgYXMgZGV2LT5kcml2ZXIg
KHZmaW8gaW4gdGhpcyBjYXNlKQo+ID4gPiAgICAgICAgICAgICAgICAgKiBib3VuZCB0byBhbiBv
dGhlcndpc2UgYWxsb3dlZCBkcml2ZXIgKHNhbWUgbGlzdCBhcyBpbiB2ZmlvKSAgCj4gPiAKPiA+
IFRoaXMgcmVhbGx5IHNob3VsZG4ndCB1c2UgaGFyZHdpcmVkIGRyaXZlciBjaGVja3MuIEF0dGFj
aGVkIGRyaXZlcnMKPiA+IHNob3VsZCBnZW5lcmljYWxseSBpbmRpY2F0ZSB0byB0aGUgaW9tbXUg
bGF5ZXIgdGhhdCB0aGV5IGFyZSBzYWZlIGZvcgo+ID4gaW9tbXVfZmQgdXNhZ2UgYnkgY2FsbGlu
ZyBzb21lIGZ1bmN0aW9uIGFyb3VuZCBwcm9iZSgpICAKPiAKPiBnb29kIGlkZWEuCj4gCj4gPiAK
PiA+IFRodXMgYSBncm91cCBtdXN0IGNvbnRhaW4gb25seSBpb21tdV9mZCBzYWZlIGRyaXZlcnMs
IG9yIGRyaXZlcnMtbGVzcwo+ID4gZGV2aWNlcyBiZWZvcmUgYW55IG9mIGl0IGNhbiBiZSB1c2Vk
LiBJdCBpcyB0aGUgbW9yZSBnZW5lcmFsCj4gPiByZWZhY3RvcmluZyBvZiB3aGF0IFZGSU8gaXMg
ZG9pbmcuCj4gPiAgIAo+ID4gPiAgICAgICAgIGMpIFRoZSBpb21tdSBsYXllciBhbHNvIHZlcmlm
aWVzIGdyb3VwIHZpYWJpbGl0eSBvbiBCVVNfTk9USUZZXwo+ID4gPiAgICAgICAgICAgICBCT1VO
RF9EUklWRVIgZXZlbnQuIEJVR19PTiBpZiB2aWFiaWxpdHkgaXMgYnJva2VuIHdoaWxlICAKPiA+
IGJsb2NrX2RtYSAgCj4gPiA+ICAgICAgICAgICAgIGlzIHNldC4gIAo+ID4gCj4gPiBBbmQgd2l0
aCB0aGlzIGNvbmNlcHQgb2YgaW9tbXVfZmQgc2FmZXR5IGJlaW5nIGZpcnN0LWNsYXNzIG1heWJl
IHdlCj4gPiBjYW4gc29tZWhvdyBlbGltaW5hdGUgdGhpcyBncm9zcyBCVUdfT04gKGFuZCB0aGUg
MTAwJ3Mgb2YgbGluZXMgb2YKPiA+IGNvZGUgdGhhdCBhcmUgdXNlZCB0byBjcmVhdGUgaXQpIGJ5
IGRlbnlpbmcgcHJvYmUgdG8gbm9uLWlvbW11LXNhZmUKPiA+IGRyaXZlcnMsIHNvbWVob3cuICAK
PiAKPiB5ZXMuCj4gCj4gPiAgIAo+ID4gPiAtICAgQmluZGluZyBvdGhlciBkZXZpY2VzIGluIHRo
ZSBncm91cCB0byBpb21tdV9mZCBqdXN0IHN1Y2NlZWRzIHNpbmNlCj4gPiA+ICAgICB0aGUgZ3Jv
dXAgaXMgYWxyZWFkeSBpbiBibG9ja19kbWEuICAKPiA+IAo+ID4gSSB0aGluayB0aGUgcmVzdCBv
ZiB0aGlzIG1vcmUgb3IgbGVzcyBkZXNjcmliZXMgdGhlIGRldmljZSBjZW50cmljCj4gPiBsb2dp
YyBmb3IgbXVsdGktZGV2aWNlIGdyb3VwcyB3ZSd2ZSBhbHJlYWR5IHRhbGtlZCBhYm91dC4gSSBk
b24ndAo+ID4gdGhpbmsgaXQgYmVuaWZpdHMgZnJvbSBoYXZpbmcgdGhlIGdyb3VwIGZkCj4gPiAg
IAo+IAo+IHN1cmUuIEFsbCBvZiB0aGlzIG5ldyBza2V0Y2ggZG9lc24ndCBoYXZlIGdyb3VwIGZk
IGluIGFueSBpb21tdSBmZAo+IEFQSS4gSnVzdCB0cnkgdG8gZWxhYm9yYXRlIGEgZnVsbCBza2V0
Y2ggdG8gc3luYyB0aGUgYmFzZS4KPiAKPiBBbGV4L0pvZXJnLCBsb29rIGZvcndhcmQgdG8geW91
ciB0aG91Z2h0cyBub3cuIPCfmIoKClNvbWUgcHJvdmlkZWQuICBUaGFua3MsCgpBbGV4CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5n
IGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
