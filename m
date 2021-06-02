Return-Path: <SRS0=kThj=K4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D79C4708F
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 20:37:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62CC261008
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 20:37:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62CC261008
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 28B6640544;
	Wed,  2 Jun 2021 20:37:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CghHXDuFGbKK; Wed,  2 Jun 2021 20:37:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 863FF4054A;
	Wed,  2 Jun 2021 20:37:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F72BC000E;
	Wed,  2 Jun 2021 20:37:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C707CC0001
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 20:37:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AD84183BD6
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 20:37:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P1rQdIsy7pPi for <iommu@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 20:37:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 846D982D85
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 20:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622666258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iJlh51bjI+f1OqmoNY6RCwcvjRmGzSQVTBsY3gR9pCY=;
 b=Gc45c6gv4R+E/WR7JCYX04i8cPkSwdF7ggoPYA6pOX0kG2jcDkYI3v0gE/+ZGI1brtbN5i
 hBZh/vNItx5RSkL3dDVChaN1FRPEsTKa91L7wdnSdxQTMc3H0ieclUwzRYfucrfoOHubZe
 e20ZijD2MjLRAHI+6lRPFes0AY8Y7WQ=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-ZQIGyCh8O9-QHAo1wDTjyg-1; Wed, 02 Jun 2021 16:37:37 -0400
X-MC-Unique: ZQIGyCh8O9-QHAo1wDTjyg-1
Received: by mail-oi1-f199.google.com with SMTP id
 e5-20020aca23050000b02901f0c4e00a29so1762270oie.18
 for <iommu@lists.linux-foundation.org>; Wed, 02 Jun 2021 13:37:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TL5RCeD6URaQW+iNoSmRFKX2AmrwBTs64Rz3fDPVQnU=;
 b=DQyY5FbnSEaajkMPzkE62IQR29dg0FpARsfTqFj+2ELRJ8dpbjNjwVTr5uAmMe/01f
 o+JXd/nmEvi++Q1DWn716l3P4sYVqPeuznCBd6TCBsX33dnv3A0VxVbAPrxxD4bdcAOV
 edHnqoFs0qeT+FjeZAVtdgpbVAPAlO7xNiMAxaRlKKPLaZ6iRWZevw0Z3c6wBJz2aNEN
 f0vCoRVAK9eJljXy7RmwEMDjiYszdkVAY62q8/jQKfaI24CdgafmHEB5CbfZTbtDsf0/
 ZflU1My/ZxuQVTg8hqwfPo5/L061y2gmHtn2lxEUtQd/4ypkAY0wEtzVc5piC0hcoB6d
 vFCA==
X-Gm-Message-State: AOAM530oaSbcZymuneBaKK4uNeJC5eYP27IGJQl0sdAYkviwO4uWYBuj
 T9NyzMTDNk0k+mCjWo9czJ9PTnuo0zN3RoxL3jigkozvX0nKihubq62nYO67FIq7OGbgx+GItpK
 sB4bg0McONC9E1lG4eAOEIFOYiCFuNg==
X-Received: by 2002:a05:6830:18ee:: with SMTP id
 d14mr2615013otf.347.1622666256093; 
 Wed, 02 Jun 2021 13:37:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTGOm/+QC96xO7+b3hYQUsHRLgYBQr4fcc4vLi2KEeMHHCtYSbE2eryQSUu9BcVRPF7Kuerw==
X-Received: by 2002:a05:6830:18ee:: with SMTP id
 d14mr2614981otf.347.1622666255750; 
 Wed, 02 Jun 2021 13:37:35 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
 by smtp.gmail.com with ESMTPSA id t39sm195560ooi.42.2021.06.02.13.37.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jun 2021 13:37:35 -0700 (PDT)
Date: Wed, 2 Jun 2021 14:37:34 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210602143734.72fb4fa4.alex.williamson@redhat.com>
In-Reply-To: <20210602195404.GI1002214@nvidia.com>
References: <20210528200311.GP1002214@nvidia.com>
 <MWHPR11MB188685D57653827B566BF9B38C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210601162225.259923bc.alex.williamson@redhat.com>
 <MWHPR11MB1886E8454A58661DC2CDBA678C3D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210602160140.GV1002214@nvidia.com>
 <20210602111117.026d4a26.alex.williamson@redhat.com>
 <20210602173510.GE1002214@nvidia.com>
 <20210602120111.5e5bcf93.alex.williamson@redhat.com>
 <20210602180925.GH1002214@nvidia.com>
 <20210602130053.615db578.alex.williamson@redhat.com>
 <20210602195404.GI1002214@nvidia.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj, 
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, David Woodhouse <dwmw2@infradead.org>,
 Jason Wang <jasowang@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>,
 David Gibson <david@gibson.dropbear.id.au>
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

T24gV2VkLCAyIEp1biAyMDIxIDE2OjU0OjA0IC0wMzAwCkphc29uIEd1bnRob3JwZSA8amdnQG52
aWRpYS5jb20+IHdyb3RlOgoKPiBPbiBXZWQsIEp1biAwMiwgMjAyMSBhdCAwMTowMDo1M1BNIC0w
NjAwLCBBbGV4IFdpbGxpYW1zb24gd3JvdGU6Cj4gPiAKPiA+IFJpZ2h0LCB0aGUgZGV2aWNlIGNh
biBnZW5lcmF0ZSB0aGUgbm8tc25vb3AgdHJhbnNhY3Rpb25zLCBidXQgaXQncyB0aGUKPiA+IElP
TU1VIHRoYXQgZXNzZW50aWFsbHkgZGV0ZXJtaW5lcyB3aGV0aGVyIHRob3NlIHRyYW5zYWN0aW9u
cyBhcmUKPiA+IGFjdHVhbGx5IHN0aWxsIGNhY2hlIGNvaGVyZW50LCBBSVVJLiAgCj4gCj4gV293
LCB0aGlzIGlzIHJlYWxseSBjb25mdXNpbmcgc3R1ZmYgaW4gdGhlIGNvZGUuCj4gCj4gQXQgdGhl
IFBDSSBsZXZlbCB0aGVyZSBpcyBhIFRMUCBiaXQgY2FsbGVkIG5vLXNub29wIHRoYXQgaXMgcGxh
dGZvcm0KPiBzcGVjaWZpYy4gVGhlIGdlbmVyYWwgaW50ZW50aW9uIGlzIHRvIGFsbG93IGRldmlj
ZXMgdG8gc2VsZWN0aXZlbHkKPiBieXBhc3MgdGhlIENQVSBjYWNoaW5nIGZvciBETUFzLiBHUFVz
IGxpa2UgdG8gdXNlIHRoaXMgZmVhdHVyZSBmb3IKPiBwZXJmb3JtYW5jZS4KClllcwoKPiBJIGFz
c3VtZSB0aGVyZSBpcyBzb21lIGV4Y2l0aW5nIHNlY3VyaXR5IGlzc3VlcyBoZXJlLiBMb29rcyBs
aWtlCj4gYWxsb3dpbmcgY2FjaGUgYnlwYXNzIGRvZXMgc29tZXRoaW5nIGJhZCBpbnNpZGUgVk1z
PyBMb29rcyBsaWtlCj4gYWxsb3dpbmcgdGhlIFZNIHRvIHVzZSB0aGUgY2FjaGUgY2xlYXIgaW5z
dHJ1Y3Rpb24gdGhhdCBpcyBtYW5kYXRvcnkKPiB3aXRoIGNhY2hlIGJ5cGFzcyBETUEgY2F1c2Vz
IHNvbWUgUU9TIGlzc3Vlcz8gT0suCgpJSVJDLCBsYXJnZWx5IGEgRG9TIGlzc3VlIGlmIHVzZXJz
cGFjZSBnZXRzIHRvIGNob29zZSB3aGVuIHRvIGVtdWxhdGUKd2JpbnZkIHJhdGhlciB0aGFuIGl0
IGJlaW5nIGRlbWFuZGVkIGZvciBjb3JyZWN0IG9wZXJhdGlvbi4KCj4gU28gaG93IGRvZXMgaXQg
d29yaz8KPiAKPiBXaGF0IEkgc2VlIGluIHRoZSBpbnRlbC9pb21tdS5jIGlzIHRoYXQgc29tZSBk
b21haW5zIHN1cHBvcnQgInNub29wCj4gY29udHJvbCIgb3Igbm90LCBiYXNlZCBvbiBzb21lIEhX
IGZsYWcuIFRoaXMgaW5kaWNhdGVzIGlmIHRoZQo+IERNQV9QVEVfU05QIGJpdCBpcyBzdXBwb3J0
ZWQgb24gYSBwYWdlIGJ5IHBhZ2UgYmFzaXMgb3Igbm90Lgo+IAo+IFNpbmNlIHg4NiBhbHdheXMg
bGVhbnMgdG93YXJkICJETUEgY2FjaGUgY29oZXJlbnQiIEknbSByZWFkaW5nIHNvbWUKPiB0ZWEg
bGVhdmVzIGhlcmU6Cj4gCj4gCUlPTU1VX0NBUF9DQUNIRV9DT0hFUkVOQ1ksCS8qIElPTU1VIGNh
biBlbmZvcmNlIGNhY2hlIGNvaGVyZW50IERNQQo+IAkJCQkJICAgdHJhbnNhY3Rpb25zICovCj4g
Cj4gQW5kIGd1ZXNzaW5nIHRoYXQgSU9NTVVzIHRoYXQgaW1wbGVtZW50IERNQV9QVEVfU05QIHdp
bGwgaWdub3JlIHRoZQo+IHNub29wIGJpdCBpbiBUTFBzIGZvciBJT1ZBJ3MgdGhhdCBoYXZlIERN
QV9QVEVfU05QIHNldD8KClRoYXQncyBteSB1bmRlcnN0YW5kaW5nIGFzIHdlbGwuCgo+IEZ1cnRo
ZXIsIEkgZ3Vlc3MgSU9NTVVzIHRoYXQgZG9uJ3Qgc3VwcG9ydCBQVEVfU05QLCBvciBoYXZlCj4g
RE1BX1BURV9TTlAgY2xlYXIgd2lsbCBhbHdheXMgaG9ub3VyIHRoZSBzbm9vcCBiaXQuIChiYWNr
d2FyZHMgY29tcGF0Cj4gYW5kIGFsbCkKClllcy4KCj4gU28sIElPTU1VX0NBUF9DQUNIRV9DT0hF
UkVOQ1kgZG9lcyBub3QgbWVhbiB0aGUgSU9NTVUgaXMgRE1BCj4gaW5jb2hlcmVudCB3aXRoIHRo
ZSBDUFUgY2FjaGVzLCBpdCBqdXN0IG1lYW5zIHRoYXQgdGhhdCBzbm9vcCBiaXQgaW4KPiB0aGUg
VExQIGNhbm5vdCBiZSBlbmZvcmNlZC4gaWUgdGhlIGRldmljZSAqY291bGQqIGRvIG5vLXNob29w
IERNQQo+IGlmIGl0IHdhbnRzLiBEZXZpY2VzIHRoYXQgbmV2ZXIgZG8gbm8tc25vb3AgcmVtYWlu
IERNQSBjb2hlcmVudCBvbgo+IHg4NiwgYXMgdGhleSBhbHdheXMgaGF2ZSBiZWVuLgoKWWVzLCBJ
T01NVV9DQVBfQ0FDSEVfQ09IRVJFTkNZPWZhbHNlIG1lYW5zIHdlIGNhbm5vdCBmb3JjZSB0aGUg
ZGV2aWNlCkRNQSB0byBiZSBjb2hlcmVudCB2aWEgdGhlIElPTU1VLgoKPiBJT01NVV9DQUNIRSBk
b2VzIG5vdCBtZWFuIHRoZSBJT01NVSBpcyBETUEgY2FjaGUgY29oZXJlbnQsIGl0IG1lYW5zCj4g
dGhlIFBDSSBkZXZpY2UgaXMgYmxvY2tlZCBmcm9tIHVzaW5nIG5vLXNub29wIGluIGl0cyBUTFBz
Lgo+IAo+IEkgd29uZGVyIGlmIEFSTSBpbXBsZW1lbnRlZCB0aGlzIGNvbnNpc3RlbnRseT8gSSBz
ZWUgVkRQQSBpcwo+IGNvbmZ1c2VkLi4gSSB3YXMgY29uZnVzZWQuIFdoYXQgYSB0ZXJyaWJsZSBz
ZXQgb2YgbmFtZXMuCj4gCj4gSW4gVkZJTyBnZW5lcmljIGNvZGUgSSBzZWUgaXQgYWx3YXlzIHNl
dHMgSU9NTVVfQ0FDSEU6Cj4gCj4gICAgICAgICBpZiAoaW9tbXVfY2FwYWJsZShidXMsIElPTU1V
X0NBUF9DQUNIRV9DT0hFUkVOQ1kpKQo+ICAgICAgICAgICAgICAgICBkb21haW4tPnByb3QgfD0g
SU9NTVVfQ0FDSEU7Cj4gCj4gQW5kIHRodXMgYWxzbyBhbHdheXMgcHJvdmlkZXMgSU9NTVVfQ0FD
SEUgdG8gaW9tbXVfbWFwOgo+IAo+ICAgICAgICAgICAgICAgICByZXQgPSBpb21tdV9tYXAoZC0+
ZG9tYWluLCBpb3ZhLCAocGh5c19hZGRyX3QpcGZuIDw8IFBBR0VfU0hJRlQsCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBucGFnZSA8PCBQQUdFX1NISUZULCBwcm90IHwgZC0+cHJv
dCk7Cj4gCj4gU28gd2hlbiB0aGUgSU9NTVUgc3VwcG9ydHMgdGhlIG5vLXNub29wIGJsb2NraW5n
IHNlY3VyaXR5IGZlYXR1cmUgVkZJTwo+IHR1cm5zIGl0IG9uIGFuZCBibG9ja3Mgbm8tc25vb3Ag
dG8gYWxsIHBhZ2VzPyBPay4uCgpZZXAsIEknZCBmb3Jnb3R0ZW4gdGhpcyBudWFuY2UgdGhhdCB3
ZSBuZWVkIHRvIGVuYWJsZSBpdCB2aWEgdGhlCm1hcHBpbmcgZmxhZ3MuCgo+IEJ1dCBJIG11c3Qg
YmUgbWlzc2luZyBzb21ldGhpbmcgYmlnIGJlY2F1c2UgKnNvbWV0aGluZyogaW4gdGhlIElPVkEK
PiBtYXAgc2hvdWxkIHdvcmsgd2l0aCBuby1zbm9vcGFibGUgRE1BLCByaWdodD8gT3RoZXJ3aXNl
IHdoYXQgaXMgdGhlCj4gcG9pbnQgb2YgZXhwb3NpbmcgdGhlIGludmFsaWRhdGUgaW5zdHJ1Y3Rp
b24gdG8gdGhlIGd1ZXN0Pwo+IAo+IEkgd291bGQgdGhpbmsgdXNlcnNwYWNlIHNob3VsZCBiZSBy
ZWxheWluZyB0aGUgRE1BX1BURV9TTlAgYml0IGZyb20KPiB0aGUgZ3Vlc3QncyBwYWdlIHRhYmxl
cyB1cCB0byBoZXJlPz8KPiAKPiBUaGUgS1ZNIGhvb2t1cCBpcyBkcml2ZW4gYnkgSU9NTVVfQ0FD
SEUgd2hpY2ggaXMgZHJpdmVuIGJ5Cj4gSU9NTVVfQ0FQX0NBQ0hFX0NPSEVSRU5DWS4gU28gd2Ug
dHVybiBvbiB0aGUgc3BlY2lhbCBLVk0gc3VwcG9ydCBvbmx5Cj4gaWYgdGhlIElPTU1VIGNhbiBi
bG9jayB0aGUgU05QIGJpdD8gQW5kIHRoZW4gd2UgbWFwIGFsbCB0aGUgcGFnZXMgdG8KPiBibG9j
ayB0aGUgc25vb3AgYml0PyBIdWg/CgpSaWdodC4gIEkgZG9uJ3QgZm9sbG93IHdoZXJlIHlvdSdy
ZSBqdW1waW5nIHRvIHJlbGF5aW5nIERNQV9QVEVfU05QCmZyb20gdGhlIGd1ZXN0IHBhZ2UgdGFi
bGUuLi4gd2hhdCBwYWdlIHRhYmxlPyAgV2UgZG9uJ3QgbmVjZXNzYXJpbHkKaGF2ZSBhIHZJT01N
VSB0byBleHBvc2Ugc3VjaCB0aGluZ3MsIEkgZG9uJ3QgdGhpbmsgaXQgZXZlbiBleGlzdGVkIHdo
ZW4KdGhpcyB3ZSBhZGRlZC4gIEVzc2VudGlhbGx5IGlmIHdlIGNhbiBpZ25vcmUgbm8tc25vb3Ag
YXQgdGhlIElPTU1VLAp0aGVuIEtWTSBkb2Vzbid0IG5lZWQgdG8gd29ycnkgYWJvdXQgZW11bGF0
aW5nIHdiaW52ZCBiZWNhdXNlIG9mIGFuCmFzc2lnbmVkIGRldmljZSwgd2hldGhlciB0aGF0IGRl
dmljZSB1c2VzIGl0IG9yIG5vdC4gIFdpbi13aW4uCgo+IFlvdXIgZXhwbGFuYXRpb24gbWFrZXMg
cGVyZmVjdCBzZW5zZTogQmxvY2sgZ3Vlc3RzIGZyb20gdXNpbmcgdGhlCj4gZGFuZ2Vyb3VzIGNh
Y2hlIGludmFsaWRhdGUgaW5zdHJ1Y3Rpb24gdW5sZXNzIGEgZGV2aWNlIHRoYXQgdXNlcwo+IG5v
LXNub29wIGlzIHBsdWdnZWQgaW4uIEJsb2NrIGRldmljZXMgZnJvbSB1c2luZyBuby1zbm9vcCBi
ZWNhdXNlCj4gc29tZXRoaW5nIGFib3V0IGl0IGlzIGluc2VjdXJlLiBPay4KCk5vLXNub29wIGl0
c2VsZiBpcyBub3QgaW5zZWN1cmUsIGJ1dCB0byBzdXBwb3J0IG5vLXNub29wIGluIGEgVk0gS1ZN
CmNhbid0IGlnbm9yZSB3YmludmQsIHdoaWNoIGhhcyBvdmVyaGVhZCBhbmQgYWJ1c2UgaW1wbGlj
YXRpb25zLgoKPiBCdXQgdGhlIGNvbmRpdGlvbnMgSSdtIGxvb2tpbmcgZm9yICJkZXZpY2UgdGhh
dCB1c2VzIG5vLXNub29wIiBpczoKPiAgLSBUaGUgZGV2aWNlIHdpbGwgaXNzdWUgbm8tc25vb3Ag
VExQcyBhdCBhbGwKCldlIGNhbid0IHJlYWxseSBrbm93IHRoaXMgZ2VuZXJpY2FsbHkuICBXZSBj
YW4gdHJ5IHRvIHNldCB0aGUgZW5hYmxlCmJpdCB0byBzZWUgaWYgdGhlIGRldmljZSBpcyBjYXBh
YmxlIG9mIG5vLXNub29wLCBidXQgdGhhdCBkb2Vzbid0IG1lYW4KaXQgd2lsbCB1c2Ugbm8tc25v
b3AuCgo+ICAtIFRoZSBJT01NVSB3aWxsIGxldCBuby1zbm9vcCB0aHJvdWdoCj4gIC0gVGhlIHBs
YXRmb3JtIHdpbGwgaG9ub3Igbm8tc25vb3AKPiAKPiBPbmx5IGlmIGFsbCB0aHJlZSBhcmUgbWV0
IHdlIHNob3VsZCBhbGxvdyB0aGUgZGFuZ2Vyb3VzIGluc3RydWN0aW9uIGluCj4gS1ZNLCByaWdo
dD8KCldlIHRlc3QgYXQgdGhlIElPTU1VIGFuZCBhc3N1bWUgdGhhdCB0aGUgSU9NTVUga25vd2xl
ZGdlIGVuY29tcGFzc2VzCndoZXRoZXIgdGhlIHBsYXRmb3JtIGhvbm9ycyBuby1zbm9vcCAobm90
ZSBmb3IgZXhhbXBsZSBob3cgYW1kIGFuZCBhcm0KcmVwb3J0IHRydWUgZm9yIElPTU1VX0NBUF9D
QUNIRV9DT0hFUkVOQ1kgYnV0IHNlZW0gdG8gaWdub3JlIHRoZQpJT01NVV9DQUNIRSBmbGFnKS4g
IFdlIGNvdWxkIHByb2JhYmx5IHVzZSBhbiBpb21tdV9ncm91cF9mb3JfZWFjaF9kZXYKdG8gdGVz
dCBpZiBhbnkgZGV2aWNlcyB3aXRoaW4gdGhlIGdyb3VwIGFyZSBjYXBhYmxlIG9mIG5vLXNub29w
IGlmIHRoZQpJT01NVSBjYW4ndCBwcm90ZWN0IHVzLCBidXQgYXQgdGhlIHRpbWUgaXQgZGlkbid0
IHNlZW0gd29ydGh3aGlsZS4gIEknbQpzdGlsbCBub3Qgc3VyZSBpZiBpdCBpcy4KIAo+IFdoaWNo
IGJyaW5ncyBtZSBiYWNrIHRvIG15IG9yaWdpbmFsIHBvaW50IC0gdGhpcyBpcyBhdCBsZWFzdCBw
YXJ0aWFsbHkKPiBhIGRldmljZSBzcGVjaWZpYyBiZWhhdmlvci4gSXQgZGVwZW5kcyBvbiB0aGUg
Y29udGVudCBvZiB0aGUgSU9NTVUKPiBwYWdlIHRhYmxlLCBpdCBkZXBlbmRzIGlmIHRoZSBkZXZp
Y2UgZXZlbiBzdXBwb3J0cyBuby1zbm9vcCBhdCBhbGwuCj4gCj4gTXkgZ3Vlc3MgaXMgdGhpcyB3
b3JrcyBjb3JyZWN0bHkgZm9yIHRoZSBtZGV2IEludGVsIGt2bWd0IHdoaWNoCj4gcHJvYmFibHkg
c29tZWhvdyBhbGxvd3Mgbm8tc25vb3AgRE1BIHRocm91Z2h0IHRoZSBtZGV2IFNXIGlvbW11Cj4g
bWFwcGluZ3MuIChhc3N1bWluZyBJIGRpZG4ndCBtaXNzIGEgdHJpY2t5IGlvbW11X21hcCB3aXRo
b3V0Cj4gSU9NTVVfQ0FDSGUgc2V0IGluIHRoZSB0eXBlMSBjb2RlPykKClRoaXMgc3VwcG9ydCBl
eGlzdGVkIGJlZm9yZSBtZGV2LCBJSVJDIHdlIG5lZWRlZCBpdCBmb3IgZGlyZWN0CmFzc2lnbm1l
bnQgb2YgTlZJRElBIEdQVXMuCiAKPiBCdXQgd2h5IGlzIHZmaW8tcGNpIHVzaW5nIGl0PyBIbW0/
CgpVc2UgdGhlIElPTU1VIHRvIHJlZHVjZSBoeXBlcnZpc29yIG92ZXJoZWFkLCBsZXQgdGhlIGh5
cGVydmlzb3IgbGVhcm4KYWJvdXQgaXQsIGlnbm9yZSB0aGUgc3VidGxldGllcyBvZiB3aGV0aGVy
IHRoZSBkZXZpY2UgYWN0dWFsbHkgdXNlcwpuby1zbm9vcCBhcyBpbXByZWNpc2UgYW5kIHBvb3Ig
Uk9JIGdpdmVuIHRoZSBhcHBhcmVudCBkaXJlY3Rpb24gb2YKaGFyZHdhcmUuCgrCr1xfKOODhClf
L8KvLApBbGV4CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
