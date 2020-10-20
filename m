Return-Path: <SRS0=/c0m=D3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF07C433DF
	for <iommu@archiver.kernel.org>; Tue, 20 Oct 2020 09:20:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7355D22283
	for <iommu@archiver.kernel.org>; Tue, 20 Oct 2020 09:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OfvaBT0P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7355D22283
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1ED53872F3;
	Tue, 20 Oct 2020 09:20:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gxz6a52hKOXz; Tue, 20 Oct 2020 09:20:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4A1DB872E1;
	Tue, 20 Oct 2020 09:20:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24DCAC088B;
	Tue, 20 Oct 2020 09:20:43 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 515C6C0051
 for <iommu@lists.linux-foundation.org>; Tue, 20 Oct 2020 09:20:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3F9BD86B4F
 for <iommu@lists.linux-foundation.org>; Tue, 20 Oct 2020 09:20:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0S8Lm8TmHlg5 for <iommu@lists.linux-foundation.org>;
 Tue, 20 Oct 2020 09:20:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 688E086B4E
 for <iommu@lists.linux-foundation.org>; Tue, 20 Oct 2020 09:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603185639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HZrTt3RPheBVTMDXVvDc/OXdQNtnIu9P2NzODgtsSV0=;
 b=OfvaBT0PZZS7/kQrFN4iChq5kmUH/pPQbdz0rKlhmKq0whLVC25jFl3fNSEVplNh+KwJ4P
 YQu3P6NZcKExLx38gEFPwuKRk0IfYT54YnxW6NG9kQQR+dL/Ec4ttzsq/lkwwKb5wPi3Un
 /E6ZHyi57an3e+LwX4HNUGnBSHuJkP0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-570-aRgYslQlN8CC3xuq29C9PA-1; Tue, 20 Oct 2020 05:20:35 -0400
X-MC-Unique: aRgYslQlN8CC3xuq29C9PA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 436289CC1C;
 Tue, 20 Oct 2020 09:20:33 +0000 (UTC)
Received: from [10.72.13.171] (ovpn-13-171.pek2.redhat.com [10.72.13.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 05AEC6EF6E;
 Tue, 20 Oct 2020 09:19:57 +0000 (UTC)
Subject: Re: (proposal) RE: [PATCH v7 00/16] vfio: expose virtual Shared
 Virtual Addressing to VMs
To: "Liu, Yi L" <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
 "joro@8bytes.org" <joro@8bytes.org>
References: <MWHPR11MB1645CFB0C594933E92A844AC8C070@MWHPR11MB1645.namprd11.prod.outlook.com>
 <45faf89a-0a40-2a7a-0a76-d7ba76d0813b@redhat.com>
 <MWHPR11MB1645CF252CF3493F4A9487508C050@MWHPR11MB1645.namprd11.prod.outlook.com>
 <9c10b681-dd7e-2e66-d501-7fcc3ff1207a@redhat.com>
 <MWHPR11MB164501E77BDB0D5AABA8487F8C020@MWHPR11MB1645.namprd11.prod.outlook.com>
 <21a66a96-4263-7df2-3bec-320e6f38a9de@redhat.com>
 <DM5PR11MB143531293E4D65028801FDA1C3020@DM5PR11MB1435.namprd11.prod.outlook.com>
 <a43d47f5-320b-ef60-e2be-a797942ea9f2@redhat.com>
 <DM5PR11MB1435D55CAE858CC8EC2AFA47C31F0@DM5PR11MB1435.namprd11.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <6e478a9e-2051-c0cd-b6fd-624ff5ef0f53@redhat.com>
Date: Tue, 20 Oct 2020 17:19:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM5PR11MB1435D55CAE858CC8EC2AFA47C31F0@DM5PR11MB1435.namprd11.prod.outlook.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "stefanha@gmail.com" <stefanha@gmail.com>, "Tian,
 Jun J" <jun.j.tian@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Sun,
 Yi Y" <yi.y.sun@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, "Wu,
 Hao" <hao.wu@intel.com>
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
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SGkgWWk6CgpPbiAyMDIwLzEwLzIwIOS4i+WNiDQ6MTksIExpdSwgWWkgTCB3cm90ZToKPj4gWWVz
LCBidXQgc2luY2UgUEFTSUQgaXMgYSBnbG9iYWwgaWRlbnRpZmllciBub3csIEkgdGhpbmsga2Vy
bmVsIHNob3VsZAo+PiB0cmFjayB0aGUgYSBkZXZpY2UgbGlzdCBwZXIgUEFTSUQ/Cj4gV2UgaGF2
ZSBzdWNoIHRyYWNrLiBJdCdzIGRvbmUgaW4gaW9tbXUgZHJpdmVyLiBZb3UgY2FuIHJlZmVyIHRv
IHRoZQo+IHN0cnVjdCBpbnRlbF9zdm0uIFBBU0lEIGlzIGEgZ2xvYmFsIGlkZW50aWZpZXIsIGJ1
dCBpdCBkb2VzbuKAmXQgYWZmZWN0IHRoYXQKPiB0aGUgUEFTSUQgdGFibGUgaXMgcGVyLWRldmlj
ZS4KPgo+PiBTbyBmb3Igc3VjaCBiaW5kaW5nLCBQQVNJRCBzaG91bGQgYmUKPj4gc3VmZmljaWVu
dCBmb3IgdUFQSS4KPiBub3QgcXVpdGUgZ2V0IGl0LiBQQVNJRCBtYXkgYmUgYm91bmQgdG8gbXVs
dGlwbGUgZGV2aWNlcywgaG93IGRvCj4geW91IGZpZ3VyZSBvdXQgdGhlIHRhcmdldCBkZXZpY2Ug
aWYgeW91IGRvbuKAmXQgcHJvdmlkZSBzdWNoIGluZm8uCgoKSSBtYXkgbWlzcyBzb2VtdGhpbmcg
YnV0IGlzIHRoZXJlIGFueSByZWFzb24gdGhhdCB1c2Vyc3BhY2UgbmVlZCB0byAKZmlndXJlIG91
dCB0aGUgdGFyZ2V0IGRldmljZT8gUEFTSUQgaXMgYWJvdXQgYWRkcmVzcyBzcGFjZSBub3QgYSAK
c3BlY2lmaWMgZGV2aWNlIEkgdGhpbmsuCgoKPgo+Pj4+PiBUaGUgYmluZGluZyByZXF1ZXN0IGlz
IGluaXRpYXRlZCBieSB0aGUgdmlydHVhbCBJT01NVSwgd2hlbiBjYXB0dXJpbmcKPj4+Pj4gZ3Vl
c3QgYXR0ZW1wdCBvZiBiaW5kaW5nIHBhZ2UgdGFibGUgdG8gYSB2aXJ0dWFsIFBBU0lEIGVudHJ5
IGZvciBhCj4+Pj4+IGdpdmVuIGRldmljZS4KPj4+PiBBbmQgZm9yIEwyIHBhZ2UgdGFibGUgcHJv
Z3JhbW1pbmcsIGlmIFBBU0lEIGlzIHVzZSBieSBib3RoIGUuZyBWRklPIGFuZAo+Pj4+IHZEUEEs
IHVzZXIgbmVlZCB0byBjaG9vc2Ugb25lIG9mIHVBUEkgdG8gYnVpbGQgbDIgbWFwcGluZ3M/Cj4+
PiBmb3IgTDIgcGFnZSB0YWJsZSBtYXBwaW5ncywgaXQncyBkb25lIGJ5IFZGSU8gTUFQL1VOTUFQ
LiBmb3IgdmRwYSwgSSBndWVzcwo+Pj4gaXQgaXMgdGxiIGZsdXNoLiBzbyB5b3UgYXJlIHJpZ2h0
LiBLZWVwaW5nIEwxL0wyIHBhZ2UgdGFibGUgbWFuYWdlbWVudCBpbgo+Pj4gYSBzaW5nbGUgdUFQ
SSBzZXQgaXMgYWxzbyBhIHJlYXNvbiBmb3IgbXkgY3VycmVudCBzZXJpZXMgd2hpY2ggZXh0ZW5k
cyBWRklPCj4+PiBmb3IgTDEgbWFuYWdlbWVudC4KPj4gSSdtIGFmcmFpZCB0aGF0IHdvdWxkIGlu
dHJvZHVjZSBjb25mdXNpbmcgdG8gdXNlcnNwYWNlLiBFLmc6Cj4+Cj4+IDEpIHdoZW4gaGF2aW5n
IG9ubHkgdkRQQSBkZXZpY2UsIGl0IHVzZXMgdkRQQSB1QVBJIHRvIGRvIGwyIG1hbmFnZW1lbnQK
Pj4gMikgd2hlbiB2RFBBIHNoYXJlcyBQQVNJRCB3aXRoIFZGSU8sIGl0IHdpbGwgdXNlIFZGSU8g
dUFQSSB0byBkbyB0aGUgbDIKPj4gbWFuYWdlbWVudD8KPiBJIHRoaW5rIHZEUEEgd2lsbCBzdGls
bCB1c2UgaXRzIG93biBsMiBmb3IgdGhlIGwyIG1hcHBpbmdzLiBub3Qgc3VyZSB3aHkgeW91Cj4g
bmVlZCB2RFBBIHVzZSBWRklPJ3MgbDIgbWFuYWdlbWVudC4gSSBkb24ndCB0aGluayBpdCBpcyB0
aGUgY2FzZS4KCgpTZWUgcHJldmlvdXMgZGlzY3Vzc2lvbiB3aXRoIEtldmluLiBJZiBJIHVuZGVy
c3RhbmQgY29ycmVjdGx5LCB5b3UgCmV4cGVjdCBhIHNoYXJlZCBMMiB0YWJsZSBpZiB2RFBBIGFu
ZCBWRklPIGRldmljZSBhcmUgdXNpbmcgdGhlIHNhbWUgUEFTSUQuCgpJbiB0aGlzIGNhc2UsIGlm
IGwyIGlzIHN0aWxsIG1hbmFnZWQgc2VwYXJhdGVseSwgdGhlcmUgd2lsbCBiZSAKZHVwbGljYXRl
ZCByZXF1ZXN0IG9mIG1hcCBhbmQgdW5tYXAuCgpUaGFua3MKCgo+Cj4gUmVnYXJkcywKPiBZaSBM
aXUKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9t
bXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
