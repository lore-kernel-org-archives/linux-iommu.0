Return-Path: <SRS0=69++=LC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E68C47095
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 01:20:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1137B61263
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 01:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1137B61263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CFBFF403CD;
	Tue,  8 Jun 2021 01:20:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AP2Mntunljbb; Tue,  8 Jun 2021 01:20:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 46DFF403C9;
	Tue,  8 Jun 2021 01:20:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C643C000E;
	Tue,  8 Jun 2021 01:20:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E357EC0001
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 01:20:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CA477402AB
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 01:20:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9ryVKdCTrqor for <iommu@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 01:20:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D9E3840140
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 01:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623115242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TCwzQn65+dgzBoFvWj2wr+QLjXlAu9EeWSx0GqEzC4M=;
 b=hj2ZlBF56qdE51oVdoOYR17j6mV4SpmuNhkGRKqNRM3m2j05SbCyN9DIw1y4WYcCakJkYR
 m/a5IE+RZoKEQLnPtuZdIf0ORQs1fTJr/YCXFwRUYsKIJpsU6RppO34rhpqjWpe8BbzmHG
 8EekV3O5u8f/b2ceS2Fayzp1LK3U2nM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-ltw9jZtlOUCyqAzHTE839A-1; Mon, 07 Jun 2021 21:20:41 -0400
X-MC-Unique: ltw9jZtlOUCyqAzHTE839A-1
Received: by mail-pj1-f71.google.com with SMTP id
 t8-20020a17090aba88b029016baed73c00so1117608pjr.5
 for <iommu@lists.linux-foundation.org>; Mon, 07 Jun 2021 18:20:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=TCwzQn65+dgzBoFvWj2wr+QLjXlAu9EeWSx0GqEzC4M=;
 b=t6gv4N3n4SACip2HAb1JCKmN4bAnJlFT5agy9gyeSRZ+JELsEgtiIJEcDGkQw4iY2W
 B1CdgxlPxkBCLx8FkwBMxCsluhYwL2WSrRlVsmJ/BJ/6Mu+/QtnX9LE2FGK8jkZWVqeN
 IUraGkJsQ8Vh28hv48r5oDOj4BBa1Rfp7uJqPAZ+JABJ0zWuFUnpFGGruKyREYfytaJJ
 m/TnHp2fWwfEu55y0/nP2TMYx6XMZ36XDvmqsm2aJKWvHt7E8ms9uTD38f52VjRnyYsk
 5+L5k1S4F6kcTbuhqGpEBBpYcp3c2dJCIwktqFNCzI52QdNcpO14xb2dk0nlRZEYgMuq
 Tf9g==
X-Gm-Message-State: AOAM530TaUa9byEWVTQkDt6ZqOMztgaIiOVq08YN3nqL+rPpQ5f/rbRF
 y1tI3iUZbEpZHG+mziadf+xIqM/NQlZ1M64VC1uMBIOiCN7LoDaEHMWjSJ6BqqLVfxHdDi7b9vh
 kMjCKmoShVX2fQEjBtHbsK6C4nigfyQ==
X-Received: by 2002:a17:90a:c20b:: with SMTP id
 e11mr2002397pjt.67.1623115240161; 
 Mon, 07 Jun 2021 18:20:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPiYk/pvMKx+vaHmZlDroPiezFsE2XFpj2cfJDKpSRv32vxsQprEkdJWoAQEkbam2OXdw2Rw==
X-Received: by 2002:a17:90a:c20b:: with SMTP id
 e11mr2002339pjt.67.1623115239324; 
 Mon, 07 Jun 2021 18:20:39 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id y5sm9342812pfb.19.2021.06.07.18.20.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Jun 2021 18:20:38 -0700 (PDT)
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To: Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>
References: <20210604155016.GR1002214@nvidia.com>
 <30e5c597-b31c-56de-c75e-950c91947d8f@redhat.com>
 <20210604160336.GA414156@nvidia.com>
 <2c62b5c7-582a-c710-0436-4ac5e8fd8b39@redhat.com>
 <20210604172207.GT1002214@nvidia.com>
 <20210604152918.57d0d369.alex.williamson@redhat.com>
 <20210604230108.GB1002214@nvidia.com>
 <20210607094148.7e2341fc.alex.williamson@redhat.com>
 <20210607181858.GM1002214@nvidia.com>
 <20210607125946.056aafa2.alex.williamson@redhat.com>
 <20210607190802.GO1002214@nvidia.com>
 <20210607134128.58c2ea31.alex.williamson@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <12631cf3-4ef8-7c38-73bb-649d57c0226b@redhat.com>
Date: Tue, 8 Jun 2021 09:20:29 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210607134128.58c2ea31.alex.williamson@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, David Woodhouse <dwmw2@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>, Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvNi84IMnPzuczOjQxLCBBbGV4IFdpbGxpYW1zb24g0LS1wDoKPiBPbiBNb24sIDcg
SnVuIDIwMjEgMTY6MDg6MDIgLTAzMDAKPiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29t
PiB3cm90ZToKPgo+PiBPbiBNb24sIEp1biAwNywgMjAyMSBhdCAxMjo1OTo0NlBNIC0wNjAwLCBB
bGV4IFdpbGxpYW1zb24gd3JvdGU6Cj4+Cj4+Pj4gSXQgaXMgdXAgdG8gcWVtdSBpZiBpdCB3YW50
cyB0byBwcm9jZWVkIG9yIG5vdC4gVGhlcmUgaXMgbm8gaXNzdWUgd2l0aAo+Pj4+IGFsbG93aW5n
IHRoZSB1c2Ugb2Ygbm8tc25vb3AgYW5kIGJsb2NraW5nIHdiaW52ZCwgb3RoZXIgdGhhbiBzb21l
Cj4+Pj4gZHJpdmVycyBtYXkgbWFsZnVuY3Rpb24uIElmIHRoZSB1c2VyIGlzIGNlcnRhaW4gdGhl
eSBkb24ndCBoYXZlCj4+Pj4gbWFsZnVuY3Rpb25pbmcgZHJpdmVycyB0aGVuIG5vIGlzc3VlIHRv
IGdvIGFoZWFkLgo+Pj4gQSBkcml2ZXIgdGhhdCBrbm93cyBob3cgdG8gdXNlIHRoZSBkZXZpY2Ug
aW4gYSBjb2hlcmVudCB3YXkgY2FuCj4+PiBjZXJ0YWlubHkgcHJvY2VlZCwgYnV0IEkgc3VzcGVj
dCB0aGF0J3Mgbm90IHNvbWV0aGluZyB3ZSBjYW4gYXNrIG9mCj4+PiBRRU1VLiAgUUVNVSBoYXMg
bm8gdmlzaWJpbGl0eSB0byB0aGUgaW4tdXNlIGRyaXZlciBhbmQgc2tldGNoeSBhYmlsaXR5Cj4+
PiB0byB2aXJ0dWFsaXplIHRoZSBuby1zbm9vcCBlbmFibGUgYml0IHRvIHByZXZlbnQgbm9uLWNv
aGVyZW50IERNQSBmcm9tCj4+PiB0aGUgZGV2aWNlLiAgVGhlcmUgbWlnaHQgYmUgYW4gZXhwZXJp
bWVudGFsICgieC0iIHByZWZpeGVkKSBRRU1VIGRldmljZQo+Pj4gb3B0aW9uIHRvIGFsbG93IHVz
ZXIgb3ZlcnJpZGUsIGJ1dCBRRU1VIHNob3VsZCBkaXNhbGxvdyB0aGUgcG9zc2liaWxpdHkKPj4+
IG9mIG1hbGZ1bmN0aW9uaW5nIGRyaXZlcnMgYnkgZGVmYXVsdC4gIElmIHdlIGhhdmUgZGV2aWNl
cyB0aGF0IHByb2JlIGFzCj4+PiBzdXBwb3J0aW5nIG5vLXNub29wLCBidXQgYWN0dWFsbHkgY2Fu
J3QgZ2VuZXJhdGUgc3VjaCB0cmFmZmljLCB3ZSBtaWdodAo+Pj4gbmVlZCBhIHF1aXJrIGxpc3Qg
c29tZXdoZXJlLgo+PiBDb21wYXRpYmlsaXR5IGlzIGltcG9ydGFudCwgYnV0IHdoZW4gSSBsb29r
IGluIHRoZSBrZXJuZWwgY29kZSBJIHNlZQo+PiB2ZXJ5IGZldyBwbGFjZXMgdGhhdCBjYWxsIHdi
aW52ZCgpLiBCYXNpY2FsbHkgYWxsIERSTSBmb3Igc29tZXRoaW5nCj4+IHJlbGF2ZW50IHRvIHFl
bXUuCj4+Cj4+IFRoYXQgdGVsbHMgbWUgdGhhdCB0aGUgdmFzdCBtYWpvcml0eSBvZiBQQ0kgZGV2
aWNlcyBkbyBub3QgZ2VuZXJhdGUKPj4gbm8tc25vb3AgdHJhZmZpYy4KPiBVbmZvcnR1bmF0ZWx5
LCBldmVuIGp1c3QgbG9va2luZyBhdCBkZXZpY2VzIGFjcm9zcyBhIGNvdXBsZSBsYXB0b3BzCj4g
bW9zdCBkZXZpY2VzIGRvIHN1cHBvcnQgYW5kIGhhdmUgTm9Tbm9vcCsgc2V0IGJ5IGRlZmF1bHQu
ICBJIGRvbid0Cj4gbm90aWNlIGFueXRoaW5nIGluIHRoZSBrZXJuZWwgdGhhdCBhY3R1YWxseSB0
cmllcyB0byBzZXQgdGhpcyBlbmFibGUgKGEKPiBoYW5kZnVsIHRoYXQgYWN0aXZlbHkgZGlzYWJs
ZSksIHNvIEkgYXNzdW1lIGl0J3MgZG9uZSBieSB0aGUgZmlybXdhcmUuCgoKSSB3b25kZXIgd2hl
dGhlciBvciBub3QgaXQgd2FzIGRvbmUgdmlhIEFDUEk6CgoiCgo2LjIuMTcgX0NDQSAoQ2FjaGUg
Q29oZXJlbmN5IEF0dHJpYnV0ZSkgVGhlIF9DQ0Egb2JqZWN0IHJldHVybnMgd2hldGhlciAKb3Ig
bm90IGEgYnVzLW1hc3RlciBkZXZpY2Ugc3VwcG9ydHMgaGFyZHdhcmUgbWFuYWdlZCBjYWNoZSBj
b2hlcmVuY3kuIApFeHBlY3RlZCB2YWx1ZXMgYXJlIDAgdG8gaW5kaWNhdGUgaXQgaXMgbm90IHN1
cHBvcnRlZCwgYW5kIDEgdG8gaW5kaWNhdGUgCnRoYXQgaXQgaXMgc3VwcG9ydGVkLiBBbGwgb3Ro
ZXIgdmFsdWVzIGFyZSByZXNlcnZlZC4KCi4uLgoKT24gSW50ZWwgcGxhdGZvcm1zLCBpZiB0aGUg
X0NDQSBvYmplY3QgaXMgbm90IHN1cHBsaWVkLCB0aGUgT1NQTSB3aWxsIAphc3N1bWUgdGhlIGRl
dmljZXMgYXJlIGhhcmR3YXJlIGNhY2hlIGNvaGVyZW50LgoKIgoKVGhhbmtzCgoKPiBJdCdzIG5v
dCBzYWZlIGZvciBRRU1VIHRvIG1ha2UgYW4gYXNzdW1wdGlvbiB0aGF0IG9ubHkgR1BVcyB3aWxs
Cj4gYWN0dWFsbHkgbWFrZSB1c2Ugb2YgaXQuCj4KPj4+PiBJIHRoaW5rIGl0IG1ha2VzIHRoZSBz
b2Z0d2FyZSBkZXNpZ24gbXVjaCBzaW1wbGVyIGlmIHRoZSBzZWN1cml0eQo+Pj4+IGNoZWNrIGlz
IHZlcnkgc2ltcGxlLiBQb3NzZXNzaW5nIGEgc3VpdGFibGUgZGV2aWNlIGluIGFuIGlvYXNpZCBm
ZAo+Pj4+IGNvbnRhaW5lciBpcyBlbm91Z2ggdG8gZmxpcCBvbiB0aGUgZmVhdHVyZSBhbmQgd2Ug
ZG9uJ3QgbmVlZCB0byB0cmFjawo+Pj4+IGNoYW5nZXMgZnJvbSB0aGF0IHBvaW50IG9uLiBXZSBk
b24ndCBuZWVkIHRvIHJldm9rZSB3YmludmQgaWYgdGhlCj4+Pj4gaW9hc2lkIGZkIGNoYW5nZXMs
IGZvciBpbnN0YW5jZS4gQmV0dGVyIHRvIGtlZXAgdGhlIGtlcm5lbCB2ZXJ5IHNpbXBsZQo+Pj4+
IGluIHRoaXMgcmVnYXJkLgo+Pj4gWW91J3JlIHN1Z2dlc3RpbmcgdGhhdCBhIHVzZXIgaXNuJ3Qg
Zm9yY2VkIHRvIGdpdmUgdXAgd2JpbnZkIGVtdWxhdGlvbgo+Pj4gaWYgdGhleSBsb3NlIGFjY2Vz
cyB0byB0aGVpciBkZXZpY2U/Cj4+IFN1cmUsIHdoeSBkbyB3ZSBuZWVkIHRvIGJlIHN0cmljdGVy
PyBJdCBpcyB0aGUgc2FtZSBsb2dpYyBJIGdhdmUKPj4gZWFybGllciwgb25jZSBhbiBhdHRhY2tl
ciBwcm9jZXNzIGhhcyBhY2Nlc3MgdG8gd2JpbnZkIGFuIGF0dGFja2VyIGNhbgo+PiBqdXN0IGtl
ZXAgaXRzIGFjY2VzcyBpbmRlZmluaXRlbHkuCj4+Cj4+IFRoZSBtYWluIHVzZSBjYXNlIGZvciBy
ZXZva2F0aW9uIGFzc3VtZXMgdGhhdCBxZW11IHdvdWxkIGJlCj4+IGNvbXByb21pc2VkIGFmdGVy
IGEgZGV2aWNlIGlzIGhvdC11bnBsdWdnZWQgYW5kIHlvdSB3YW50IHRvIGJsb2NrIG9mZgo+PiB3
YmludmQuIEJ1dCBJIGhhdmUgYSBoYXJkIHRpbWUgc2VlaW5nIHRoYXQgYXMgdXNlZnVsIGVub3Vn
aCB0byBqdXN0aWZ5Cj4+IGFsbCB0aGUgY29tcGxpY2F0ZWQgY29kZSB0byBkbyBpdC4uLgo+IEl0
J3MgY3VycmVudGx5IGp1c3QgYSBtYXR0ZXIgb2YgdGhlIGt2bS12ZmlvIGRldmljZSBob2xkaW5n
IGEgcmVmZXJlbmNlCj4gdG8gdGhlIGdyb3VwIHNvIHRoYXQgaXQgY2Fubm90IGJlIHVzZWQgZWxz
ZXdoZXJlIHNvIGxvbmcgYXMgaXQncyBiZWluZwo+IHVzZWQgdG8gZWxldmF0ZSBwcml2aWxlZ2Vz
IG9uIGEgZ2l2ZW4gS1ZNIGluc3RhbmNlLiAgSWYgd2UgY29uY2x1ZGUgdGhhdAo+IGFjY2VzcyB0
byBhIGRldmljZSB3aXRoIHRoZSByaWdodCBjYXBhYmlsaXR5IGlzIHJlcXVpcmVkIHRvIGdhaW4g
YQo+IHByaXZpbGVnZSwgSSBkb24ndCByZWFsbHkgc2VlIGhvdyB3ZSBjYW4gd2F2ZSBhc2lkZSB0
aGF0IHRoZSBwcml2aWxlZ2UKPiBpc24ndCBsb3N0IHdpdGggdGhlIGRldmljZS4KPgo+PiBGb3Ig
S1ZNIHFlbXUgY2FuIHR1cm4gb24vb2ZmIG9uIGhvdCBwbHVnIGV2ZW50cyBhcyBpdCByZXF1aXJl
cyB0byBnaXZlCj4+IFZNIHNlY3VyaXR5LiBJdCBkb2Vzbid0IG5lZWQgdG8gcmVseSBvbiB0aGUg
a2VybmVsIHRvIGNvbnRyb2wgdGhpcy4KPiBZZXMsIFFFTVUgY2FuIHJlamVjdCBhIGhvdC11bnBs
dWcgZXZlbnQsIGJ1dCB0aGVuIFFFTVUgcmV0YWlucyB0aGUKPiBwcml2aWxlZ2UgdGhhdCB0aGUg
ZGV2aWNlIGdyYW50cyBpdC4gIFJlbGVhc2luZyB0aGUgZGV2aWNlIGFuZAo+IHJldGFpbmluZyB0
aGUgcHJpdmlsZWdlZCBnYWluZWQgYnkgaXQgc2VlbXMgd3JvbmcuICBUaGFua3MsCj4KPiBBbGV4
Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11
IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
