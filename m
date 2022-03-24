Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E19FC433EF
	for <iommu@archiver.kernel.org>; Thu, 24 Mar 2022 22:41:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2C4D141CCB;
	Thu, 24 Mar 2022 22:41:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R3MPA0731FvA; Thu, 24 Mar 2022 22:41:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CF6F941CC7;
	Thu, 24 Mar 2022 22:41:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D80BC0012;
	Thu, 24 Mar 2022 22:41:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA8B4C000B
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 22:41:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A3DB360AF4
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 22:41:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S-KnYq7yaXYy for <iommu@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 22:41:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D41AA60ADC
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 22:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648161677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0+hoh4jfjE01vsVfZmT2GJ8qlpm5OtKcpQZnExTmPL0=;
 b=RKNWe3tegusMXJ8zxPj/bEjxByiOHoSuHoNtt0JFLeTsccfJckmEfdzRj9WsSCRY8pWWCw
 /5MK5kFwOLVNc1V2KuN9gDFFBqOxBGbrRDNltKuDJcC+rMU2poVXcd/bPcqTyUABCcu4Iq
 /j8jn9peTClZDX1YpQjNNzvE5BSsevg=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-448-iFeR59PhM1Oh0WqTIIDAKA-1; Thu, 24 Mar 2022 18:41:16 -0400
X-MC-Unique: iFeR59PhM1Oh0WqTIIDAKA-1
Received: by mail-io1-f72.google.com with SMTP id
 f5-20020a6be805000000b00649b9faf257so3974415ioh.9
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 15:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=l9WNoz/FzvLksUXnj3LwqVUaZSJ8tKS3cuqgqvhdHn0=;
 b=RTiAEdkHRpv7ZJOYBn0JxUjQjazKn2r2cONmuBXusVeNjZ59BsljBaPGobE5n9aTzp
 52VQG23dOJKAA//8Spd9oZ7TqRTo0FvF4LNFuzmbIKL+Oea4dHfdz5RRDCRWuKAAW+y+
 SzdxaQFZYgQK3nxWkJWkMWpsLi/FKJr1W7C53Ydxu1F1T7yZDwKTHLNhnK85xTz1QiSc
 FNpizcDA4D0QuXNwZYa43XsshCGIScVFvTSTlA5P0QKXPfAwA7XcZGBKtiPeuqRHDPZB
 6jFRbcBagS1dc0dcpt1KzReX1kNN33s508wIA5XMxIbcRaa5iQ3os9LQi3X7uCLdMqKB
 ywDA==
X-Gm-Message-State: AOAM532fUpFNpZWbmxZWg5KzQYZZ1tuMdGqd6mufHu0Jl383D32eVZcJ
 xItoHrFtS/7iwQan06euIIk5UrAvGyBvFmpA1kYaICOZcU2lk5k7LmGn5Up6PtOLOvzcZyvaIdE
 gkwFL14jQYok9OsvFl9/K1v9yGuwFZQ==
X-Received: by 2002:a05:6638:371f:b0:31a:8654:e49c with SMTP id
 k31-20020a056638371f00b0031a8654e49cmr3994486jav.197.1648161675851; 
 Thu, 24 Mar 2022 15:41:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8BahSZl1L2C0PBuAAPzP0FUv2fHadswqtKoqwYknCJfEeQpET1HU5FEk+lcbhTyW3Tu6Gjg==
X-Received: by 2002:a05:6638:371f:b0:31a:8654:e49c with SMTP id
 k31-20020a056638371f00b0031a8654e49cmr3994469jav.197.1648161675601; 
 Thu, 24 Mar 2022 15:41:15 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 q197-20020a6b8ece000000b00648d615e80csm2082175iod.41.2022.03.24.15.41.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Mar 2022 15:41:15 -0700 (PDT)
Date: Thu, 24 Mar 2022 16:41:14 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH RFC 04/12] kernel/user: Allow user::locked_vm to be
 usable for iommufd
Message-ID: <20220324164114.78f2e63a.alex.williamson@redhat.com>
In-Reply-To: <20220324222739.GZ11336@nvidia.com>
References: <4-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
 <808a871b3918dc067031085de3e8af6b49c6ef89.camel@linux.ibm.com>
 <20220322145741.GH11336@nvidia.com>
 <20220322092923.5bc79861.alex.williamson@redhat.com>
 <20220322161521.GJ11336@nvidia.com>
 <20220324144015.031ca277.alex.williamson@redhat.com>
 <20220324222739.GZ11336@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 kvm@vger.kernel.org, Niklas Schnelle <schnelle@linux.ibm.com>,
 Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Kevin Tian <kevin.tian@intel.com>, Daniel Jordan <daniel.m.jordan@oracle.com>,
 Jason Gunthorpe via iommu <iommu@lists.linux-foundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
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

T24gVGh1LCAyNCBNYXIgMjAyMiAxOToyNzozOSAtMDMwMApKYXNvbiBHdW50aG9ycGUgPGpnZ0Bu
dmlkaWEuY29tPiB3cm90ZToKCj4gT24gVGh1LCBNYXIgMjQsIDIwMjIgYXQgMDI6NDA6MTVQTSAt
MDYwMCwgQWxleCBXaWxsaWFtc29uIHdyb3RlOgo+ID4gT24gVHVlLCAyMiBNYXIgMjAyMiAxMzox
NToyMSAtMDMwMAo+ID4gSmFzb24gR3VudGhvcnBlIHZpYSBpb21tdSA8aW9tbXVAbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmc+IHdyb3RlOgo+ID4gICAKPiA+ID4gT24gVHVlLCBNYXIgMjIsIDIw
MjIgYXQgMDk6Mjk6MjNBTSAtMDYwMCwgQWxleCBXaWxsaWFtc29uIHdyb3RlOgo+ID4gPiAgIAo+
ID4gPiA+IEknbSBzdGlsbCBwaWNraW5nIG15IHdheSB0aHJvdWdoIHRoZSBzZXJpZXMsIGJ1dCB0
aGUgbGF0ZXIgY29tcGF0Cj4gPiA+ID4gaW50ZXJmYWNlIGRvZXNuJ3QgbWVudGlvbiB0aGlzIGRp
ZmZlcmVuY2UgYXMgYW4gb3V0c3RhbmRpbmcgaXNzdWUuCj4gPiA+ID4gRG9lc24ndCB0aGlzIGRp
ZmZlcmVuY2UgbmVlZCB0byBiZSBhY2NvdW50ZWQgaW4gaG93IGxpYnZpcnQgbWFuYWdlcyBWTQo+
ID4gPiA+IHJlc291cmNlIGxpbWl0cz8gICAgICAKPiA+ID4gCj4gPiA+IEFGQUNJVCwgbm8sIGJ1
dCBpdCBzaG91bGQgYmUgY2hlY2tlZC4KPiA+ID4gICAKPiA+ID4gPiBBSVVJIGxpYnZpcnQgdXNl
cyBzb21lIGZvcm0gb2YgcHJsaW1pdCgyKSB0byBzZXQgcHJvY2VzcyBsb2NrZWQKPiA+ID4gPiBt
ZW1vcnkgbGltaXRzLiAgICAKPiA+ID4gCj4gPiA+IFllcywgYW5kIHVsaW1pdCBkb2VzIHdvcmsg
ZnVsbHkuIHBybGltaXQgYWRqdXN0cyB0aGUgdmFsdWU6Cj4gPiA+IAo+ID4gPiBpbnQgZG9fcHJs
aW1pdChzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRzaywgdW5zaWduZWQgaW50IHJlc291cmNlLAo+ID4g
PiAJCXN0cnVjdCBybGltaXQgKm5ld19ybGltLCBzdHJ1Y3QgcmxpbWl0ICpvbGRfcmxpbSkKPiA+
ID4gewo+ID4gPiAJcmxpbSA9IHRzay0+c2lnbmFsLT5ybGltICsgcmVzb3VyY2U7Cj4gPiA+IFsu
Ll0KPiA+ID4gCQlpZiAobmV3X3JsaW0pCj4gPiA+IAkJCSpybGltID0gKm5ld19ybGltOwo+ID4g
PiAKPiA+ID4gV2hpY2ggdmZpbyByZWFkcyBiYWNrIGhlcmU6Cj4gPiA+IAo+ID4gPiBkcml2ZXJz
L3ZmaW8vdmZpb19pb21tdV90eXBlMS5jOiAgICAgICAgdW5zaWduZWQgbG9uZyBwZm4sIGxpbWl0
ID0gcmxpbWl0KFJMSU1JVF9NRU1MT0NLKSA+PiBQQUdFX1NISUZUOwo+ID4gPiBkcml2ZXJzL3Zm
aW8vdmZpb19pb21tdV90eXBlMS5jOiAgICAgICAgdW5zaWduZWQgbG9uZyBsaW1pdCA9IHJsaW1p
dChSTElNSVRfTUVNTE9DSykgPj4gUEFHRV9TSElGVDsKPiA+ID4gCj4gPiA+IEFuZCBpb21tdWZk
IGRvZXMgdGhlIHNhbWUgcmVhZCBiYWNrOgo+ID4gPiAKPiA+ID4gCWxvY2tfbGltaXQgPQo+ID4g
PiAJCXRhc2tfcmxpbWl0KHBhZ2VzLT5zb3VyY2VfdGFzaywgUkxJTUlUX01FTUxPQ0spID4+IFBB
R0VfU0hJRlQ7Cj4gPiA+IAlucGFnZXMgPSBwYWdlcy0+bnBpbm5lZCAtIHBhZ2VzLT5sYXN0X25w
aW5uZWQ7Cj4gPiA+IAlkbyB7Cj4gPiA+IAkJY3VyX3BhZ2VzID0gYXRvbWljX2xvbmdfcmVhZCgm
cGFnZXMtPnNvdXJjZV91c2VyLT5sb2NrZWRfdm0pOwo+ID4gPiAJCW5ld19wYWdlcyA9IGN1cl9w
YWdlcyArIG5wYWdlczsKPiA+ID4gCQlpZiAobmV3X3BhZ2VzID4gbG9ja19saW1pdCkKPiA+ID4g
CQkJcmV0dXJuIC1FTk9NRU07Cj4gPiA+IAl9IHdoaWxlIChhdG9taWNfbG9uZ19jbXB4Y2hnKCZw
YWdlcy0+c291cmNlX3VzZXItPmxvY2tlZF92bSwgY3VyX3BhZ2VzLAo+ID4gPiAJCQkJICAgICBu
ZXdfcGFnZXMpICE9IGN1cl9wYWdlcyk7Cj4gPiA+IAo+ID4gPiBTbyBpdCBkb2VzIHdvcmsgZXNz
ZW50aWFsbHkgdGhlIHNhbWUuICAKPiA+IAo+ID4gV2VsbCwgZXhjZXB0IGZvciB0aGUgcGFydCBh
Ym91dCB2ZmlvIHVwZGF0aW5nIG1tLT5sb2NrZWRfdm0gYW5kIGlvbW11ZmQKPiA+IHVwZGF0aW5n
IHVzZXItPmxvY2tlZF92bSwgYSBwZXItcHJvY2VzcyBjb3VudGVyIHZlcnN1cyBhIHBlci11c2Vy
Cj4gPiBjb3VudGVyLiAgcHJsaW1pdCBzcGVjaWZpY2FsbHkgc2V0cyBwcm9jZXNzIHJlc291cmNl
IGxpbWl0cywgd2hpY2ggZ2V0Cj4gPiByZWZsZWN0ZWQgaW4gdGFza19ybGltaXQuICAKPiAKPiBJ
bmRlZWQsIGJ1dCB0aGF0IGlzIG5vdCBob3cgdGhlIG1ham9yaXR5IG9mIG90aGVyIHRoaW5ncyBz
ZWVtIHRvCj4gb3BlcmF0ZSBpdC4KPiAKPiA+IEZvciBleGFtcGxlLCBsZXQncyBzYXkgYSB1c2Vy
IGhhcyB0d28gNEdCIFZNcyBhbmQgdGhleSdyZSBob3QtYWRkaW5nCj4gPiB2ZmlvIGRldmljZXMg
dG8gZWFjaCBvZiB0aGVtLCBzbyBsaWJ2aXJ0IG5lZWRzIHRvIGR5bmFtaWNhbGx5IG1vZGlmeQo+
ID4gdGhlIGxvY2tlZCBtZW1vcnkgbGltaXQgZm9yIGVhY2ggVk0uICBBSVVJLCBsaWJ2aXJ0IHdv
dWxkIGxvb2sgYXQgdGhlCj4gPiBWTSBzaXplIGFuZCBjYWxsIHBybGltaXQgdG8gc2V0IHRoYXQg
dmFsdWUuICBJZiBsaWJ2aXJ0IGRvZXMgdGhpcyB0bwo+ID4gYm90aCBWTXMsIHRoZW4gZWFjaCBo
YXMgYSB0YXNrX3JsaW1pdCBvZiA0R0IuICBJbiB2ZmlvIHdlIGFkZCBwaW5uZWQKPiA+IHBhZ2Vz
IHRvIG1tLT5sb2NrZWRfdm0sIHNvIHRoaXMgd29ya3Mgd2VsbC4gIEluIHRoZSBpb21tdWZkIGxv
b3AgYWJvdmUsCj4gPiB3ZSdyZSBjb21wYXJpbmcgYSBwZXItdGFzay9wcm9jZXNzIGxpbWl0IHRv
IGEgcGVyLXVzZXIgY291bnRlci4gIFNvIEknbQo+ID4gYSBiaXQgbG9zdCBob3cgYm90aCBWTXMg
Y2FuIHBpbiB0aGVpciBwYWdlcyBoZXJlLiAgCj4gCj4gSSBkb24ndCBrbm93IGFueXRoaW5nIGFi
b3V0IGxpYnZpcnQgLSBpdCBzZWVtcyBzdHJhbmdlIHRvIHVzZSBhCj4gc2VjdXJpdHlpc2ggZmVh
dHVyZSBsaWtlIHVsaW1pdCBidXQgbm90IHNlY3VyaXR5IGlzb2xhdGUgcHJvY2Vzc2VzCj4gd2l0
aCByZWFsIHVzZXJzLgo+IAo+IEJ1dCBpZiBpdCByZWFsbHkgZG9lcyB0aGlzIHRoZW4gaXQgcmVh
bGx5IGRvZXMgdGhpcy4KPiAKPiBTbyBhdCB0aGUgdmVyeSBsZWFzdCBWRklPIGNvbnRhaW5lciBo
YXMgdG8ga2VlcCB3b3JraW5nIHRoaXMgd2F5Lgo+IAo+IFRoZSBuZXh0IHF1ZXN0aW9uIGlzIGlm
IHdlIHdhbnQgaW9tbXVmZCdzIG93biBkZXZpY2Ugbm9kZSB0byB3b3JrIHRoaXMKPiB3YXkgYW5k
IHRyeSB0byBjaGFuZ2UgbGlidmlydCBzb21laG93LiBJdCBzZWVtcyBsaWJ2aXJ0IHdpbGwgaGF2
ZSB0bwo+IGRlYWwgd2l0aCB0aGlzIGF0IHNvbWUgcG9pbnQgYXMgaW91cmluZyB3aWxsIHRyaWdn
ZXIgdGhlIHNhbWUgcHJvYmxlbS4KPiAKPiA+ID4gVGhpcyB3aG9sZSBhcmVhIGlzIGEgYml0IHBl
Y3VsaWFyIChlZyBtbG9jayBpdHNlbGYgd29ya3MgZGlmZmVyZW50bHkpLAo+ID4gPiBJTUhPLCBi
dXQgd2l0aCBtb3N0IG9mIHRoZSBwbGFjZXMgZG9pbmcgcGlucyB2b3RpbmcgdG8gdXNlCj4gPiA+
IHVzZXItPmxvY2tlZF92bSBhcyB0aGUgY2hhcmdlIGl0IHNlZW1zIHRoZSByaWdodCBwYXRoIGlu
IHRvZGF5J3MKPiA+ID4ga2VybmVsLiAgCj4gPiAKPiA+IFRoZSBwaGlsb3NvcGh5IG9mIHdoZXRo
ZXIgaXQncyB1bHRpbWF0ZWx5IGEgYmV0dGVyIGNob2ljZSBmb3IgdGhlCj4gPiBrZXJuZWwgYXNp
ZGUsIGlmIHVzZXJzcGFjZSBicmVha3MgYmVjYXVzZSB3ZSdyZSBhY2NvdW50aW5nIGluIGEKPiA+
IHBlci11c2VyIHBvb2wgcmF0aGVyIHRoYW4gYSBwZXItcHJvY2VzcyBwb29sLCB0aGVuIG91ciBj
b21wYXRpYmlsaXR5Cj4gPiBsYXllciBhaW4ndCBzbyB0cmFuc3BhcmVudC4gIAo+IAo+IFN1cmUs
IGlmIGl0IGRvZXNuJ3Qgd29yayBpdCBkb2Vzbid0IHdvcmsuIExldHMgYmUgc3VyZSBhbmQgY2xl
YXJseQo+IGRvY3VtZW50IHdoYXQgdGhlIGNvbXBhdGFiaWxpdHkgaXNzdWUgaXMgYW5kIHRoZW4g
d2UgaGF2ZSB0byBrZWVwIGl0Cj4gcGVyLXByb2Nlc3MuCj4gCj4gQW5kIHRoZSBzYW1lIHJlYXNv
bmluZyBsaWtlbHkgbWVhbnMgSSBjYW4ndCBjaGFuZ2UgUkRNQSBlaXRoZXIgYXMgcWVtdQo+IHdp
bGwgYnJlYWsganVzdCBhcyB3ZWxsIHdoZW4gcWVtdSB1c2VzIHJkbWEgbW9kZS4KPiAKPiBXaGlj
aCBpcyBwcmV0dHkgc3Vja3ksIGJ1dCBpdCBpcyB3aGF0IGl0IGlzLi4KCkkgYWRkZWQgRGFuaWVs
IEJlcnJhbmfDqSB0byB0aGUgY2MgbGlzdCBmb3IgbXkgcHJldmlvdXMgcmVwbHksIGhvcGVmdWxs
eQpoZSBjYW4gY29tbWVudCB3aGV0aGVyIGxpYnZpcnQgaGFzIHRoZSBzb3J0IG9mIHVzZXIgc2Vj
dXJpdHkgbW9kZWwgeW91CmFsbHVkZSB0byBhYm92ZSB0aGF0IG1heWJlIG1ha2VzIHRoaXMgYSBu
b24taXNzdWUgZm9yIHRoaXMgdXNlIGNhc2UuClVuZm9ydHVuYXRlbHkgaXQncyBleHRyZW1lbHkg
ZGlmZmljdWx0IHRvIHByb3ZlIHRoYXQgdGhlcmUgYXJlIG5vIHN1Y2gKdXNlIGNhc2VzIG91dCB0
aGVyZSBldmVuIGlmIGxpYnZpcnQgaXMgb2suICBUaGFua3MsCgpBbGV4CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9t
bXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
