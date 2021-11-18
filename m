Return-Path: <SRS0=SEpV=QF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5BFC433F5
	for <iommu@archiver.kernel.org>; Thu, 18 Nov 2021 19:48:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2FB861A56
	for <iommu@archiver.kernel.org>; Thu, 18 Nov 2021 19:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A2FB861A56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 56C30404D4;
	Thu, 18 Nov 2021 19:48:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G5VbDe3kZG3Z; Thu, 18 Nov 2021 19:48:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AD330400F2;
	Thu, 18 Nov 2021 19:48:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84292C001E;
	Thu, 18 Nov 2021 19:48:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 679E5C0012
 for <iommu@lists.linux-foundation.org>; Thu, 18 Nov 2021 19:48:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 48DB980C67
 for <iommu@lists.linux-foundation.org>; Thu, 18 Nov 2021 19:48:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nohiWlSDBytp for <iommu@lists.linux-foundation.org>;
 Thu, 18 Nov 2021 19:48:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3904180C5B
 for <iommu@lists.linux-foundation.org>; Thu, 18 Nov 2021 19:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637264920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c0+NsifhTXitxgpUIcrd+BYwKTpzMlRq6BBLU9w7ZN8=;
 b=ePcYaJyR1j5b0VmEUgmk5WmbJ8GAkaD2Mnh7SrPEZqtfT6Gk6siv3W/GV+uvfNT08s/Bs/
 Llz2xe2nNchHtr7WSzhVEtKh/hYMGuM5GapcNMEHjjtQslDW1RHzlpmZ8wfVqSDqhBJOhe
 pHSd2zIHTT5dmXjAmcYaOzz0RDT5Bf4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-421-XQ9Ro5S_MMqKlK_qSsvyTA-1; Thu, 18 Nov 2021 14:48:38 -0500
X-MC-Unique: XQ9Ro5S_MMqKlK_qSsvyTA-1
Received: by mail-pj1-f70.google.com with SMTP id
 x18-20020a17090a789200b001a7317f995cso5432445pjk.4
 for <iommu@lists.linux-foundation.org>; Thu, 18 Nov 2021 11:48:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=c0+NsifhTXitxgpUIcrd+BYwKTpzMlRq6BBLU9w7ZN8=;
 b=hyh2Z29C7EgjXrBGgKGnoUXVg/iCY5WTp8JyZ3st1DpSsj0ck5qmApjHQKVqHkunPr
 1fxEZ179vLpsdLKETWYGvJuCgwzB0CJuLZqEkaS88qp0758OIDBMX1nXHboqSkyaUsAq
 1e0uCHTyNamzC3fdDkTi+iExM7sqX8qIYETCf3gQ0X7z5MIMTmUmgjGrGHl0xoWeaMMp
 TId37oYqOMIl+wgSSzpieXyuubFt8R8txSoDJ+MB4MIYeBcAnKt4rH6BbnWo3DuGpenJ
 YebqxHGeyeyVoCwFlw0vcfvsPjVtGjzB4ZIw1gAibSDrdgj8m6jN0IK3ot4xJdY/241q
 JhWw==
X-Gm-Message-State: AOAM531cW1iZMNrMAcBycC+vWAcPpOLRmDCU5o3IciKiwiNoaEpG59YC
 x96QLdHkuaJZW+sd+2oShzbk28qtWvyWK8wJbwrwc2th/Lj2EC98lQ2/rGrTl12hACKenjAGLOh
 UEP6q7ZHxspe1I9cm5ZG5bOJbQLT5Qw==
X-Received: by 2002:a05:6a00:1344:b0:49f:f357:ac9 with SMTP id
 k4-20020a056a00134400b0049ff3570ac9mr17480705pfu.62.1637264916962; 
 Thu, 18 Nov 2021 11:48:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyanQH4YEX68BMYuegfbCt8/Ea6983YT1KPOn5R0kfbRwv5kuex5A07Fcz0kFTpI0FgxnYQyg==
X-Received: by 2002:a05:6a00:1344:b0:49f:f357:ac9 with SMTP id
 k4-20020a056a00134400b0049ff3570ac9mr17480676pfu.62.1637264916648; 
 Thu, 18 Nov 2021 11:48:36 -0800 (PST)
Received: from [192.168.1.52] (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
 by smtp.gmail.com with ESMTPSA id e14sm340663pga.76.2021.11.18.11.48.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Nov 2021 11:48:35 -0800 (PST)
Message-ID: <a68f646759351becc665896b72a308c734295892.camel@redhat.com>
Subject: Re: [PATCH] iommu/vt-d: Fix unmap_pages support
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Alex Williamson
 <alex.williamson@redhat.com>
Date: Thu, 18 Nov 2021 12:48:34 -0700
In-Reply-To: <511aa70f-0646-bd90-b14e-ba1cfaa517d0@linux.intel.com>
References: <163659074748.1617923.12716161410774184024.stgit@omen>
 <511aa70f-0646-bd90-b14e-ba1cfaa517d0@linux.intel.com>
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnitsel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: iommu@lists.linux-foundation.org, dwmw2@infradead.org
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

T24gRnJpLCAyMDIxLTExLTEyIGF0IDEwOjU5ICswODAwLCBMdSBCYW9sdSB3cm90ZToKPiBIaSBB
bGV4LAo+IAo+IE9uIDExLzExLzIxIDg6MzIgQU0sIEFsZXggV2lsbGlhbXNvbiB3cm90ZToKPiA+
IFdoZW4gc3VwcG9ydGluZyBvbmx5IHRoZSAubWFwIGFuZCAudW5tYXAgY2FsbGJhY2tzIG9mIGlv
bW11X29wcywKPiA+IHRoZSBJT01NVSBkcml2ZXIgY2FuIG1ha2UgYXNzdW1wdGlvbnMgYWJvdXQg
dGhlIHNpemUgYW5kIGFsaWdubWVudAo+ID4gdXNlZCBmb3IgbWFwcGluZ3MgYmFzZWQgb24gdGhl
IGRyaXZlciBwcm92aWRlZCBwZ3NpemVfYml0bWFwLsKgIFZULWQKPiA+IHByZXZpb3VzbHkgdXNl
ZCBlc3NlbnRpYWxseSBQQUdFX01BU0sgZm9yIHRoaXMgYml0bWFwIGFzIGFueSBwb3dlcgo+ID4g
b2YgdHdvIG1hcHBpbmcgd2FzIGFjY2VwdGFibHkgZmlsbGVkIGJ5IG5hdGl2ZSBwYWdlIHNpemVz
Lgo+ID4gCj4gPiBIb3dldmVyLCB3aXRoIHRoZSAubWFwX3BhZ2VzIGFuZCAudW5tYXBfcGFnZXMg
aW50ZXJmYWNlIHdlJ3JlIG5vdwo+ID4gZ2V0dGluZyBwYWdlLXNpemUgYW5kIGNvdW50IGFyZ3Vt
ZW50cy7CoCBJZiB3ZSBzaW1wbHkgY29tYmluZSB0aGVzZQo+ID4gYXMgKHBhZ2Utc2l6ZSAqIGNv
dW50KSBhbmQgbWFrZSB1c2Ugb2YgdGhlIHByZXZpb3VzIG1hcC91bm1hcAo+ID4gZnVuY3Rpb25z
IGludGVybmFsbHksIGFueSBzaXplIGFuZCBhbGlnbm1lbnQgYXNzdW1wdGlvbnMgYXJlIHZlcnkK
PiA+IGRpZmZlcmVudC4KPiA+IAo+ID4gQXMgYW4gZXhhbXBsZSwgYSBnaXZlbiB2ZmlvIGRldmlj
ZSBhc3NpZ25tZW50IFZNIHdpbGwgb2Z0ZW4gY3JlYXRlCj4gPiBhIDRNQiBtYXBwaW5nIGF0IElP
VkEgcGZuIFsweDNmZTAwIC0gMHg0MDFmZl0uwqAgT24gYSBzeXN0ZW0gdGhhdAo+ID4gZG9lcyBu
b3Qgc3VwcG9ydCBJT01NVSBzdXBlciBwYWdlcywgdGhlIHVubWFwX3BhZ2VzIGludGVyZmFjZSB3
aWxsCj4gPiBhc2sgdG8gdW5tYXAgMTAyNCA0S0IgcGFnZXMgYXQgdGhlIGJhc2UgSU9WQS7CoAo+
ID4gZG1hX3B0ZV9jbGVhcl9sZXZlbCgpCj4gPiB3aWxsIHJlY3Vyc2UgZG93biB0byBsZXZlbCAy
IG9mIHRoZSBwYWdlIHRhYmxlIHdoZXJlIHRoZSBmaXJzdCBoYWxmCj4gPiBvZiB0aGUgcGZuIHJh
bmdlIGV4YWN0bHkgbWF0Y2hlcyB0aGUgZW50aXJlIHB0ZSBsZXZlbC7CoCBXZSBjbGVhcgo+ID4g
dGhlCj4gPiBwdGUsIGluY3JlbWVudCB0aGUgcGZuIGJ5IHRoZSBsZXZlbCBzaXplLCBidXQgKG9v
cHMpIHRoZSBuZXh0IHB0ZQo+ID4gaXMKPiA+IG9uIGEgbmV3IHBhZ2UsIHNvIHdlIGV4aXQgdGhl
IGxvb3AgYW4gcG9wIGJhY2sgdXAgYSBsZXZlbC7CoCBXaGVuIHdlCj4gPiB0aGVuIHVwZGF0ZSB0
aGUgcGZuIGJhc2VkIG9uIHRoYXQgaGlnaGVyIGxldmVsLCB3ZSBzZWVtIHRvIGFzc3VtZQo+ID4g
dGhhdCB0aGUgcHJldmlvdXMgcGZuIHZhbHVlIHdhcyBhdCB0aGUgc3RhcnQgb2YgdGhlIGxldmVs
LsKgIEluIHRoaXMKPiA+IGNhc2UgdGhlIGxldmVsIHNpemUgaXMgMjU2SyBwZm5zLCB3aGljaCB3
ZSBhZGQgdG8gdGhlIGJhc2UgcGZuIGFuZAo+ID4gZ2V0IGEgcmVzdWx0cyBvZiAweDdmZTAwLCB3
aGljaCBpcyBjbGVhcmx5IGdyZWF0ZXIgdGhhbiAweDQwMWZmLAo+ID4gc28gd2UncmUgZG9uZS7C
oCBNZWFud2hpbGUgd2UgbmV2ZXIgY2xlYXJlZCB0aGUgcHRlcyBmb3IgdGhlCj4gPiByZW1haW5k
ZXIKPiA+IG9mIHRoZSByYW5nZS7CoCBXaGVuIHRoZSBWTSByZW1hcHMgdGhpcyByYW5nZSwgd2Un
cmUgb3ZlcndyaXRpbmcKPiA+IHZhbGlkCj4gPiBwdGVzIGFuZCB0aGUgVlQtZCBkcml2ZXIgY29t
cGxhaW5zIGxvdWRseSwgYXMgcmVwb3J0ZWQgYnkgdGhlIHVzZXIKPiA+IHJlcG9ydCBsaW5rZWQg
YmVsb3cuCj4gPiAKPiA+IFRoZSBmaXggZm9yIHRoaXMgc2VlbXMgcmVsYXRpdmVseSBzaW1wbGUs
IGlmIGVhY2ggaXRlcmF0aW9uIG9mIHRoZQo+ID4gbG9vcCBpbiBkbWFfcHRlX2NsZWFyX2xldmVs
KCkgaXMgYXNzdW1lZCB0byBjbGVhciB0byB0aGUgZW5kIG9mIHRoZQo+ID4gbGV2ZWwgcHRlIHBh
Z2UsIHRoZW4gb3VyIG5leHQgcGZuIHNob3VsZCBiZSBjYWxjdWxhdGVkIGZyb20KPiA+IGxldmVs
X3Bmbgo+ID4gcmF0aGVyIHRoYW4gb3VyIHdvcmtpbmcgcGZuLgo+ID4gCj4gPiBGaXhlczogM2Yz
NGYxMjU5Nzc2ICgiaW9tbXUvdnQtZDogSW1wbGVtZW50IG1hcC91bm1hcF9wYWdlcygpCj4gPiBp
b21tdV9vcHMgY2FsbGJhY2siKQo+ID4gUmVwb3J0ZWQtYnk6IEFqYXkgR2FyZyA8YWpheWdhcmdu
c2l0QGdtYWlsLmNvbT4KPiA+IExpbms6Cj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwv
MjAyMTEwMDIxMjQwMTIuMTgxODYtMS1hamF5Z2FyZ25zaXRAZ21haWwuY29tLwo+ID4gU2lnbmVk
LW9mZi1ieTogQWxleCBXaWxsaWFtc29uIDxhbGV4LndpbGxpYW1zb25AcmVkaGF0LmNvbT4KPiAK
PiBUaGFuayB5b3UgZm9yIGZpeGluZyB0aGlzISBJIHdpbGwgcXVldWUgaXQgZm9yIHY1LjE2Lgo+
IAo+IEJlc3QgcmVnYXJkcywKPiBiYW9sdQo+IAoKSGkgQmFvbHUsCgpEbyB5b3UgaGF2ZSBhbiBl
c3RpbWF0ZSBvZiB3aGVuIHRoaXMgd2lsbCBiZSBzdWJtaXR0ZWQ/CgpSZWdhcmRzLApKZXJyeQoK
Cj4gPiAtLS0KPiA+IMKgIGRyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYyB8wqDCoMKgIDIgKy0K
PiA+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+ID4g
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jCj4gPiBiL2RyaXZl
cnMvaW9tbXUvaW50ZWwvaW9tbXUuYwo+ID4gaW5kZXggZDc1ZjU5YWUyOGU2Li5mNjM5NWY1NDI1
ZjAgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMKPiA+ICsrKyBi
L2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYwo+ID4gQEAgLTEyNDksNyArMTI0OSw3IEBAIHN0
YXRpYyBzdHJ1Y3QgcGFnZQo+ID4gKmRtYV9wdGVfY2xlYXJfbGV2ZWwoc3RydWN0IGRtYXJfZG9t
YWluICpkb21haW4sIGludCBsZXZlbCwKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmcmVlbGlzdCk7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoH0KPiA+IMKgIG5leHQ6Cj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgcGZuICs9IGxldmVsX3NpemUobGV2ZWwpOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHBmbiA9IGxldmVsX3BmbiArIGxldmVsX3NpemUobGV2ZWwpOwo+ID4gwqDCoMKg
wqDCoMKgwqDCoH0gd2hpbGUgKCFmaXJzdF9wdGVfaW5fcGFnZSgrK3B0ZSkgJiYgcGZuIDw9IGxh
c3RfcGZuKTsKPiA+IMKgIAo+ID4gwqDCoMKgwqDCoMKgwqDCoGlmIChmaXJzdF9wdGUpCj4gPiAK
PiA+IAo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4g
aW9tbXUgbWFpbGluZyBsaXN0Cj4gaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKPiBo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1h
aWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
