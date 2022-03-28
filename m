Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C991C433F5
	for <iommu@archiver.kernel.org>; Mon, 28 Mar 2022 14:25:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E81A18145A;
	Mon, 28 Mar 2022 14:25:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1-Yu3Bo-IDhr; Mon, 28 Mar 2022 14:25:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7542981429;
	Mon, 28 Mar 2022 14:25:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38E66C002C;
	Mon, 28 Mar 2022 14:25:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8FC68C0012
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 13:14:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6D24D40256
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 13:14:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w6upVt2PVSyK for <iommu@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 13:14:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7460D40114
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 13:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648473279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=id3+cYyJwDQgX1c25DGoHtnH1cIabKIAhEPaQc89vt4=;
 b=J6br1+LnzvBHrXSAMNSK8k4RNcpKn46cKDlSd//6GiIPL5puUK/S4MZ73cZqmqsNHUAdhQ
 DvG8I1AieLaT9AmUcPbvacj56BmPSaU7ROhOf3jL3P9Mt6RuGphDU2+zySERj9aV0avKcT
 ph0jiyjxwP9tJcsh0uoVKsXbw4I7wd8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-283-toqHoj8kON68hOIO15Cuag-1; Mon, 28 Mar 2022 09:14:31 -0400
X-MC-Unique: toqHoj8kON68hOIO15Cuag-1
Received: by mail-wm1-f72.google.com with SMTP id
 12-20020a05600c24cc00b0038c6caa95f7so5731541wmu.4
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 06:14:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=id3+cYyJwDQgX1c25DGoHtnH1cIabKIAhEPaQc89vt4=;
 b=gFPF/zH2uwf7lod0BiykNwTym0SIJPUdDWnfyJYVye2BUZCA3EurbyAsk8AYCqJaYC
 hx63jMDhi3IrBUUWDYRydGZu6z3v96aeDElMxW5MbkTv1IIZDppuvCrXpk+n+78smtC9
 EGcTFY1Y6l3vg9d3w8RZr5ibzAjMxZeNRp5Dr21UPRee2O1YkUttvB/X8m3hehCLlnww
 gZ1EJyVuH1cqM5mSKpWzG3mess3I4rPI4hgvAHezneQfBvY9SLGDAeJqUOkHMyj+CtA/
 ErttZXcLlzwFR5mm+GASxSsHAhXI5/5rMb4JZQexHXVgTDvzk4DzyG4KxwjIjWx7Be8a
 OwBw==
X-Gm-Message-State: AOAM533aLBXgNAVQ9+6kPGk2rkEV5pD2j10lxWvxmNgC5M04o9er9hca
 nEMLxdhB4/yhwhK+586+ElraYdbQpyon3zcFZJ+zkemKx7g7oWKjViEGvbWNm9hE7a1lDiWTNpH
 hSFWHA36OpDuTaitVhEphX9SxHWK1Qw==
X-Received: by 2002:adf:fe8d:0:b0:203:e02e:c6c7 with SMTP id
 l13-20020adffe8d000000b00203e02ec6c7mr23494500wrr.37.1648473269103; 
 Mon, 28 Mar 2022 06:14:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz44g4YmpRhkXqWB+XHp8AhWTMEFXzLczKSdQgiD7+lwnY0BZbX3RbX3nj8Y/+dkbTHLhKIvg==
X-Received: by 2002:adf:fe8d:0:b0:203:e02e:c6c7 with SMTP id
 l13-20020adffe8d000000b00203e02ec6c7mr23494443wrr.37.1648473268719; 
 Mon, 28 Mar 2022 06:14:28 -0700 (PDT)
Received: from [192.168.0.173]
 (86-44-155-110-dynamic.agg2.cty.lmk-pgs.eircom.net. [86.44.155.110])
 by smtp.gmail.com with ESMTPSA id
 l3-20020a1ced03000000b0038ce57d28a1sm8699773wmh.26.2022.03.28.06.14.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Mar 2022 06:14:27 -0700 (PDT)
Message-ID: <5accdd9074f20e8fef30984285a23366b7025497.camel@redhat.com>
Subject: Re: [PATCH RFC 04/12] kernel/user: Allow user::locked_vm to be
 usable for iommufd
From: Sean Mooney <smooney@redhat.com>
To: Jason Wang <jasowang@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>
Date: Mon, 28 Mar 2022 14:14:26 +0100
In-Reply-To: <CACGkMEtTVMuc-JebEbTrb3vRUVaNJ28FV_VyFRdRquVQN9VeQA@mail.gmail.com>
References: <808a871b3918dc067031085de3e8af6b49c6ef89.camel@linux.ibm.com>
 <20220322145741.GH11336@nvidia.com>
 <20220322092923.5bc79861.alex.williamson@redhat.com>
 <20220322161521.GJ11336@nvidia.com>
 <BN9PR11MB5276BED72D82280C0A4C6F0C8C199@BN9PR11MB5276.namprd11.prod.outlook.com>
 <CACGkMEutpbOc_+5n3SDuNDyHn19jSH4ukSM9i0SUgWmXDydxnA@mail.gmail.com>
 <BN9PR11MB5276E3566D633CEE245004D08C199@BN9PR11MB5276.namprd11.prod.outlook.com>
 <CACGkMEvTmCFqAsc4z=2OXOdr7X--0BSDpH06kCiAP5MHBjaZtg@mail.gmail.com>
 <BN9PR11MB5276ECF1F1C7D0A80DA086D18C199@BN9PR11MB5276.namprd11.prod.outlook.com>
 <CACGkMEtpWemw6tj=suxNjvSHuixyzhMJBYmqdbhQkinuWNADCQ@mail.gmail.com>
 <20220324114605.GX11336@nvidia.com>
 <CACGkMEtTVMuc-JebEbTrb3vRUVaNJ28FV_VyFRdRquVQN9VeQA@mail.gmail.com>
User-Agent: Evolution 3.42.1
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=smooney@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Mailman-Approved-At: Mon, 28 Mar 2022 14:25:53 +0000
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Niklas Schnelle <schnelle@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Daniel Jordan <daniel.m.jordan@oracle.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, "Martins,
 Joao" <joao.m.martins@oracle.com>, David Gibson <david@gibson.dropbear.id.au>
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

T24gTW9uLCAyMDIyLTAzLTI4IGF0IDA5OjUzICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+IE9u
IFRodSwgTWFyIDI0LCAyMDIyIGF0IDc6NDYgUE0gSmFzb24gR3VudGhvcnBlIDxqZ2dAbnZpZGlh
LmNvbT4gd3JvdGU6Cj4gPiAKPiA+IE9uIFRodSwgTWFyIDI0LCAyMDIyIGF0IDExOjUwOjQ3QU0g
KzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiAKPiA+ID4gSXQncyBzaW1wbHkgYmVjYXVzZSB3
ZSBkb24ndCB3YW50IHRvIGJyZWFrIGV4aXN0aW5nIHVzZXJzcGFjZS4gWzFdCj4gPiAKPiA+IEkn
bSBzdGlsbCB3YWl0aW5nIHRvIGhlYXIgd2hhdCBleGFjdGx5IGJyZWFrcyBpbiByZWFsIHN5c3Rl
bXMuCj4gPiAKPiA+IEFzIEkgZXhwbGFpbmVkIHRoaXMgaXMgbm90IGEgc2lnbmlmaWNhbnQgY2hh
bmdlLCBidXQgaXQgY291bGQgYnJlYWsKPiA+IHNvbWV0aGluZyBpbiBhIGZldyBzcGVjaWFsIHNj
ZW5hcmlvcy4KPiA+IAo+ID4gQWxzbyB0aGUgb25lIHBsYWNlIHdlIGRvIGhhdmUgQUJJIGJyZWFr
cyBpcyBzZWN1cml0eSwgYW5kIHVsaW1pdCBpcyBhCj4gPiBzZWN1cml0eSBtZWNoYW5pc20gdGhh
dCBpc24ndCB3b3JraW5nIHJpZ2h0LiBTbyB3ZSBkbyBjbGVhcmx5IG5lZWQgdG8KPiA+IHVuZGVy
c3RhbmQgKmV4YWN0bHkqIHdoYXQgcmVhbCB0aGluZyBicmVha3MgLSBpZiBhbnl0aGluZy4KPiA+
IAo+ID4gSmFzb24KPiA+IAo+IAo+IFRvIHRlbGwgdGhlIHRydXRoLCBJIGRvbid0IGtub3cuIEkg
cmVtZW1iZXIgdGhhdCBPcGVuc3RhY2sgbWF5IGRvIHNvbWUKPiBhY2NvdW50aW5nIHNvIGFkZGlu
ZyBTZWFuIGZvciBtb3JlIGNvbW1lbnRzLiBCdXQgd2UgcmVhbGx5IGNhbid0IGltYWdlCj4gb3Bl
bnN0YWNrIGlzIHRoZSBvbmx5IHVzZXJzcGFjZSB0aGF0IG1heSB1c2UgdGhpcy4Kc29ycnkgdGhl
cmUgaXMgYSBsb3Qgb2YgY29udGV4dCB0byB0aGlzIGRpc2N1c3Npb24gaSBoYXZlIHRyaWVkIHRv
IHJlYWQgYmFjayB0aGUKdGhyZWFkIGJ1dCBpIG1heSBoYXZlIG1pc3NlZCBwYXJ0IG9mIGl0LgoK
dGw7ZHIgb3BlbnN0YWNrIGRvZXMgbm90IGN1cnJlbnRseSB0cmFjayBsb2NrZWQvcGlubmVkIG1l
bW9yeSBwZXIgdXNlIG9yIHBlciB2bSBiZWNhdXNlIHdlIGhhdmUKbm8gaWRlYSB3aGVuIGxpYnZp
cnQgd2lsbCByZXF1ZXN0IGl0IG9yIGhvdyBtdWNoIGlzIG5lZWRlZCBwZXIgZGV2aWNlLiB3aGVu
IHVsaW1pdHMgYXJlIGNvbmZpZ3VyZWQKdG9kYXkgZm9yIG5vdmEvb3BlbnN0YWNrIGl0cyBkb25l
IGF0IHRlaCBxZW11IHVzZXIgbGV2ZWwgb3V0c2lkZSBvZiBvcGVuc3RhY2sgaW4gb3VyIGluc3Rh
bGxlciB0b29saW5nLgplLmcuIGluIHRyaXBsZW8gdGhlIHVsaW1pdHMgd291ZGwgYmUgc2V0IG9u
IHRoZSBub3ZhX2xpYnZpcnQgY29udGFpZW5yIHRvIGNvbnN0cmFpbiBhbGwgdm1zIHNwYXduZWQK
bm90IHBlciB2bS9wcm9jZXNzLgoKZnVsbCByZXNwb25jZSBiZWxvdwotLS0tLS0tLS0tLS0tLS0t
LS0tCgpvcGVuc3RhY2tzIGhpc3Rvcnkgd2l0aCBsb2NrZWQvcGlubmVkL3Vuc3dhcGFibGUgbWVt
b3J5IGlzIGEgYml0IGNvbXBsaWNhdGVkLgp3ZSBjdXJyZW50bHkgb25seSByZXF1ZXN0IGxvY2tl
ZCBtZW1vcnkgZXhwbGljdGx5IGluIDIgY2FzZXMgZGlyZWN0bHkKaHR0cHM6Ly9naXRodWIuY29t
L29wZW5zdGFjay9ub3ZhL2Jsb2IvNTBmZGJjNzUyYTljYTljMzE0ODgxNDBlZjI5OTdlZDU5ZDg2
MWE0MS9ub3ZhL3ZpcnQvbGlidmlydC9kcml2ZXIucHkjTDU3NjktTDU3ODQ9CndoZW4gdGhlIGFk
bWluc3RhcnRvciBjb25maWd1cmUgdGhlIHZtIGZsYW92ciB0byByZXF1c3QgYW1kJ3MgU0VWIGZl
YXR1cmUgb3IgY29uZmlndXJlcyB0aGUgZmxhdm9yIGZvciByZWFsdGltZSBzY2hlZHVsaW5nIHBp
cm9yb3RpeS4KaSBzYXkgZXhwbGljdGx5IGFzIGxpYnZpcnQgaW52ZW50ZWQgYSByZXF1ZXN0IGZv
ciBsb2NrZWQvcGlubmVkIHBhZ2VzIGltcGxpY3RseSBmb3Igc3Jpb3YgVkZzIGFuZCBhIG51bWJl
ciBvZiBvdGhlciBjYXNlcwp3aGljaCB3ZSB3ZXJlIG5vdCBhd2FyZSBvZiBpbXBsaWN0bHkuIHRo
aXMgb25seSBiZWNhbWUgYXBwcmVudCB3aGVuIHdlIHdlbnQgdG8gYWRkIHZkcGEgc3VwcHJvdCB0
byBvcGVuc3RhY2sgYW5kIGxpYnZpcnQKZGlkIG5vdCBtYWtlIHRoYXQgaW1wbGljdCByZXF1ZXN0
IGFuZCB3ZSBoYWQgdG8gZmFsbCBiYWNrIHRvIHJlcXVlc3RpbmcgcmVhbHRpbWUgaW5zdGFuY2Vz
IGFzIGEgd29ya2Fyb3VuZC4KCm5vdmEvb3BlbnN0YWNrIGRvZXMgaGF2ZSB0aGUgYWJsaXR5IHRv
IGdlbmVyYXRlIHRoZSBsaWJ2aXJ0IHhtbCBlbGVtZW50IHRoYXQgY29uZmlndXJlIGhhcmQgYW5k
IHNvZnQgbGltdGlzIApodHRwczovL2dpdGh1Yi5jb20vb3BlbnN0YWNrL25vdmEvYmxvYi81MGZk
YmM3NTJhOWNhOWMzMTQ4ODE0MGVmMjk5N2VkNTlkODYxYTQxL25vdmEvdmlydC9saWJ2aXJ0L2Nv
bmZpZy5weSNMMjU1OS1MMjU5MApob3dldmVyIGl0IGlzIG9ubHkgZXZlciB1c2VkIGluIG91ciB0
ZXN0IGNvZGUKaHR0cHM6Ly9naXRodWIuY29tL29wZW5zdGFjay9ub3ZhL3NlYXJjaD9xPUxpYnZp
cnRDb25maWdHdWVzdE1lbW9yeVR1bmUKCnRoZSBkZXNjaXJwdGlvbiBvZiBoYXJkIGxpbWl0IGlu
IHRoZSBsaWJ2aXJ0IGRvY3Mgc3RvbmdseSBkaWN1cmFnZXMgaXRzIHVzZSB3aXRoIGEgc21hbGwg
Y2F2ZWF0IGZvciBsb2NrZWQgbWVtb3J5Cmh0dHBzOi8vbGlidmlydC5vcmcvZm9ybWF0ZG9tYWlu
Lmh0bWwjbWVtb3J5LXR1bmluZwoKICAgaGFyZF9saW1pdAogICAKICAgICAgIFRoZSBvcHRpb25h
bCBoYXJkX2xpbWl0IGVsZW1lbnQgaXMgdGhlIG1heGltdW0gbWVtb3J5IHRoZSBndWVzdCBjYW4g
dXNlLiBUaGUgdW5pdHMgZm9yIHRoaXMgdmFsdWUgYXJlIGtpYmlieXRlcyAoaS5lLiBibG9ja3Mg
b2YgMTAyNCBieXRlcykuIFVzZXJzCiAgIG9mIFFFTVUgYW5kIEtWTSBhcmUgc3Ryb25nbHkgYWR2
aXNlZCBub3QgdG8gc2V0IHRoaXMgbGltaXQgYXMgZG9tYWluIG1heSBnZXQga2lsbGVkIGJ5IHRo
ZSBrZXJuZWwgaWYgdGhlIGd1ZXNzIGlzIHRvbyBsb3csIGFuZCBkZXRlcm1pbmluZyB0aGUgbWVt
b3J5CiAgIG5lZWRlZCBmb3IgYSBwcm9jZXNzIHRvIHJ1biBpcyBhbiB1bmRlY2lkYWJsZSBwcm9i
bGVtOyB0aGF0IHNhaWQsIGlmIHlvdSBhbHJlYWR5IHNldCBsb2NrZWQgaW4gbWVtb3J5IGJhY2tp
bmcgYmVjYXVzZSB5b3VyIHdvcmtsb2FkIGRlbWFuZHMgaXQsIHlvdSdsbAogICBoYXZlIHRvIHRh
a2UgaW50byBhY2NvdW50IHRoZSBzcGVjaWZpY3Mgb2YgeW91ciBkZXBsb3ltZW50IGFuZCBmaWd1
cmUgb3V0IGEgdmFsdWUgZm9yIGhhcmRfbGltaXQgdGhhdCBpcyBsYXJnZSBlbm91Z2ggdG8gc3Vw
cG9ydCB0aGUgbWVtb3J5CiAgIHJlcXVpcmVtZW50cyBvZiB5b3VyIGd1ZXN0LCBidXQgc21hbGwg
ZW5vdWdoIHRvIHByb3RlY3QgeW91ciBob3N0IGFnYWluc3QgYSBtYWxpY2lvdXMgZ3Vlc3QgbG9j
a2luZyBhbGwgbWVtb3J5LgogICAKd2UgY291ZGwgbm90IGZpZ3VyZSBvdXQgaG93IHRvIGF1dG9t
YXRpY2FsbHkgY29tcHR1ZSBhIGhhcmRfbGltaXQgaW4gbm92YSB0aGF0IHdvdWxkIHdvcmsgZm9y
IGV2ZXJ5b25lIGFuZCB3ZSBmZWx0IGV4cG9zaWduIHRoaXMgdG8gb3VyCnVzZXJzL29wZXJhdG9y
cyB3YXMgIGJpdCBvZiBhIGNvcCBvdXQgd2hlbiB0aGV5IGxpa2VseSBjYW50IGNhbHVhdGUgdGhh
dCBwcm9wZXJseSBlaXRoZXIuwqBBcyBhIHJlc3VsdCB3ZSBjYW50IGFjdHVsbHkgYWNjb3VudCBm
b3IgdGhlbSB0b2RheSB3aGVuCnNjaGR1aWxpZ24gd29ya2xvYWRzIHRvIGEgaG9zdC4gSW0gbm90
IHN1cmUgdGhpcyB3b3VkbCBjaGFnbmUgZXZlbiBpZiB5b3UgZXhwb3NlZCBuZXcgdXNlciBzcGFj
ZSBhcGlzIHVubGVzcyB3ZcKgCmhhZCBhIHdheSB0byBpbnNwZWN0IGVhY2ggVkYgdG8ga25vdyBo
b3cgbXVjaCBsb2NrZWQgbWVtb3J5IHRoYXQgVkYgd291ZGwgbmVlZCB0byBsb2NrPyBzYW1lIGZv
ciB2ZHBhIGRldmljZXMsCm1kZXZzIGVjdHJhLiBjbG91ZCBzeXN0ZW0gZG9udCBub3JtYWx5IGhh
dmUgcXVvdGFzIG9uICJsb2NrZWQiIG1lbW9yeSB1c2VkIHRyYXNpdGl2bHkgdmlhIHBhc3N0aG9n
dWggZGV2aWNlcyBzbyBldmVuIGlmIHdlIGhhZCB0aGlzIGluZm8KaXRzIG5vdCBpbWVkaXRseSBh
cHBlcmFudCBob3cgd2Ugd291ZGwgY29uc3VtZSBpdCB3aXRob3V0IGFsdGVyaW5nIG91ciBleGlz
dGluZyBxdW90YXMuIE9wZW5zdGFjayBpcyBhIHNlbGYgc2VydmljZSBjbG91ZCBwbGF0aGZvcm0K
d2hlcmUgZW5kdXNlciBjYW4gdXBsb2FkIHRoZXJlIG93biB3b3Jsb2FkIGlhbWdlIHNvIGl0cyBi
YXNpY2FseSBpbXBvc3NpYmVsIGZvciB0aGUgb2VwcmF0b3Igb2YgdGhlIGNsb3VkIHRvIGtub3cg
aG93IG11Y2ggbWVtcm95IHRvIHNldCB0ZWggYXJkIGxpbWl0CnRvbyB3aXRob3V0IHNldHRpbmcg
aXQgb3Zlcmx5IGxhcmdlIGluIG1vc3QgY2FzZXMuIGZyb20gYSBtYW5hZ2VtZW50IGFwcGxjaWF0
b24gcG9pbnQgb2YgdmlldyB3ZSBjdXJyZW50bHkgaGF2ZSBubyBpbnNpZ3RoIGludG8gaG93Cm1l
bW9yeSB3aWxsIGJlIHBpbm5lZCBpbiB0aGUga2VybmVsIG9yIHdoZW4gbGlidmlydCB3aWxsIGlu
dmVudCBhZGR0aW9uYWwgcmVxdWVzdCBmb3IgcGlubmVkL2xvY2tlZCBtZW1lb3J5IG9yIGhvdyBs
YXJnZSB0aGV5IGFyZS4gCgppbnN0ZWFkIG9mIGdvaW5nIGRvd24gdGhhdCByb3V0ZSBvcGVyYXRv
cnMgYXJlIGVuY3VyYWdlZCB0byB1c2UgdWxpbWl0IHRvIHNldCBhIGdsb2JhbCBsaW1pdCBvbiB0
aGUgYW1vdW50IG9mIG1lbW9yeSB0aGUgbm92YS9xZW11IHVzZXIgY2FuIHVzZS4Kd2hpbGUgbm92
YS9vcGVuc3RhY2sgc3VwcG9ydCBtdWx0aSB0ZW5hbmN5IHdlIGRvIG5vdCBleHBvc2UgdGhhdCBt
dWx0aSB0ZW5hbmN5IHRvIGh0ZSB1bmRlcmx5aW5nIGh5cGVydmlvciBob3N0cy4gdGhlIGFnZW50
cyBhcmUgdHlwaWNseQpkZXBsb3kgYXMgdGhlIG5vdmEgdXNlciB3aGljaCBpcyBhIG1lbWJlciBv
ZiB0aGUgbGlidmlydCBhbmQgcWVtdSBncm91cHMuIHRoZSB2bXMgdGhhdCBhcmUgY3JlYXRlZCBm
b3Igb3VyIHRlYW50cyBhcmUgYWxsIGNyZWF0ZWQgYXMgdW5kZXIgdGhlIHFlbXUKdXNlci9ncm91
cCBhcyBhIHJlc3VsdC4gc28gdGhlIHFlbXUgdXNlciBpcyBnb2JhbCB1bGltaXQgb24gcmVhbHRp
bWUgc3lzdGVtcyB3b3VkbCBuZWVkIHRvIGJlIHNldCAidG8gcHJvdGVjdCB5b3VyIGhvc3QgYWdh
aW5zdCBhIG1hbGljaW91cyBndWVzdApsb2NraW5nIGFsbCBtZW1vcnkiIGJ1dCB3ZSBkbyBub3Qg
ZG8gdGhpcyBvbiBhIHBlciB2bSBvciBwZXIgcHJvY2VzcyBiYXNpcy4KCnRvIGF2b2lkIG1lbW9y
eSBzdGFydmF0aW9uIHdlIGdlbmVyYWxseSByZWNvbW1lbmQgdXNpbmcgaHVnZXBhZ2VzIHdoZW4g
ZXZlciB5b3UgYXJlIGxvY2tpbmcgbWVtcm95IGFzIHdlIGF0IGxlYXN0IHRyYWNrIHRob3NlIHBl
ciBudW1hIG5vZGUgYW5kCmhhdmUgdGhlIG1lbXJveSB0cmFja2lnbiBpbiBwbGFjZSB0byBrbm93
IHRoYXQgdGhleSBhcmUgbm90IG92ZXJzdWJzY2liZWFibGUuIGkuZS4gdGhleSBjYW50IGJlIHN3
YXBwZWQgc28gdGhlIGFyZSBlZmZlY3Rpdmx5IHRoZSBzYW1lIGFzIGJlaW5nIGxvY2tlZApmb3Jt
IGEgdXNlciBzcGFjZSBwb2ludCBvZiB2aWV3LiB1c2luZyBodWdlcGFnZSBtZW1vcnkgYXMgYSB3
b3JrYXJvdW5kIHdoZW5ldmVyIHdlIG5lZWQgdG8gYWNjb3VudCBmb3IgbWVtb3J5IGxvY2tpZ24g
aXMgbm90IGlkZWFsIGJ1dCBtb3N0IG9mIG91cgp1c2VyIHRoYXQgbmVlZCBzcmlvdiBvciB2ZHBh
IGFyZSB0ZWxjb3Mgc28gdGhleSBhcmUgYWxyZWF5ZCB1c2lnbiBodWdlcGFnZXMgYW5kIGNwdSBw
aW5uaW5nIGluIG1vc3QgY2FzZXMgc28gaXQga2luZCBvZiB3b3Jrcy4KCnNpbmNlIHdlIGRvbnQg
Y3VycmVudGx5IHN1cHBvcnQgcGVyIGluc3RhbmNlIGhhcmRfbGltaXRzIGFuZCBkb250IHBsYW4g
dG8gaW50b3J1Y2UgdGhlbSBpbiB0aGUgZnV0dXJlIHdlaHRlciB0aGlzIGlzIHRyYWNrIHBlciBw
cm9jZXNzKHZtKSBvciBwZXIKdXNlcihxZW11KSBpcyBub3QgZ29pbmcgdG8gYnJlYWsgb3BlbnN0
YWNrIHRvZGF5LiBpdCBtYXkgY29tcGxpY2F0ZSBhbnkgZnV0dXJlIHVzZSBvZiB0aGUgbWVtdHVu
ZSBlbGVtZW50IGluIGxpYnZpcnQgYnV0IHdlIGRvIG5vdCBjdXJyZW50bHkgaGF2ZQpjdXN0b21l
ci91c2VyIGFza2luZyB1c2UgdG8gZXhwb3NlIHRoaXMgYW5kIGFzIGEgY2xvdWQgc29sdXRpb24g
dGhpcyBzdXBlciBsb3cgbGV2ZWwgY3VzdG9taWF0aW9uIGlzIG5vdCByZWFsbHkgc29tZXRoaWdu
IHdlCndhbnQgdG8gZXhwb3NlIGluIG91ciBhcGkgYW55d2F5LgoKcmVnYXJkcwpzZWFuCgo+IAo+
IFRvIG1lLCBpdCBsb29rcyBtb3JlIGVhc2llciB0byBub3QgYW5zd2VyIHRoaXMgcXVlc3Rpb24g
YnkgbGV0dGluZwo+IHVzZXJzcGFjZSBrbm93IGFib3V0IHRoZSBjaGFuZ2UsCj4gCj4gVGhhbmtz
Cj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21t
dSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
