Return-Path: <SRS0=at/m=D5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1585BC388F7
	for <iommu@archiver.kernel.org>; Thu, 22 Oct 2020 04:39:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FCB7223C7
	for <iommu@archiver.kernel.org>; Thu, 22 Oct 2020 04:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JSKciWcx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FCB7223C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D5AEC204B4;
	Thu, 22 Oct 2020 04:39:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6TlD9iCR7Ff0; Thu, 22 Oct 2020 04:39:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id CDBE820482;
	Thu, 22 Oct 2020 04:39:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92F49C0052;
	Thu, 22 Oct 2020 04:39:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98601C0051
 for <iommu@lists.linux-foundation.org>; Thu, 22 Oct 2020 04:39:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7FD428605E
 for <iommu@lists.linux-foundation.org>; Thu, 22 Oct 2020 04:39:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qG0IWt7v3qhU for <iommu@lists.linux-foundation.org>;
 Thu, 22 Oct 2020 04:39:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 410BE86054
 for <iommu@lists.linux-foundation.org>; Thu, 22 Oct 2020 04:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603341556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=siwhUMxivlmLeH5TYIGXWvfv+mhOu6A9HUz7iMu8arY=;
 b=JSKciWcxELgegAi0ZQjOeCC1dohOvWZUz2ssZEj4pcNhPdSd9nfqpy95smH2y2Ftv42/4t
 UDrP5h6wq/XoVMWmcs9qBbLs8SjlQv50XOJRPG1D0DFJwSCSsZSQeGwCJeBIgFcNWGNym0
 dK1CL6SzQP5U5ZdDhMF4dplcxQqrGPs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495--A9e5AmfMW2W1pglcPqElA-1; Thu, 22 Oct 2020 00:39:12 -0400
X-MC-Unique: -A9e5AmfMW2W1pglcPqElA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A47CA1007462;
 Thu, 22 Oct 2020 04:39:09 +0000 (UTC)
Received: from [10.72.13.119] (ovpn-13-119.pek2.redhat.com [10.72.13.119])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7700B60C04;
 Thu, 22 Oct 2020 04:38:44 +0000 (UTC)
Subject: Re: (proposal) RE: [PATCH v7 00/16] vfio: expose virtual Shared
 Virtual Addressing to VMs
To: "Liu, Yi L" <yi.l.liu@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>
References: <DM5PR11MB14354A8A126E686A5F20FEC2C31F0@DM5PR11MB1435.namprd11.prod.outlook.com>
 <20201020140217.GI6219@nvidia.com> <20201020162430.GA85321@otc-nc-03>
 <20201020170336.GK6219@nvidia.com> <20201020195146.GA86371@otc-nc-03>
 <20201020195557.GO6219@nvidia.com> <20201020200844.GC86371@otc-nc-03>
 <20201020201403.GP6219@nvidia.com> <20201020202713.GF86371@otc-nc-03>
 <20201021114829.GR6219@nvidia.com> <20201021175146.GA92867@otc-nc-03>
 <816799a0-49e4-a384-8990-eae9e67d4425@redhat.com>
 <DM5PR11MB14351121729909028D6EB365C31D0@DM5PR11MB1435.namprd11.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <047c28cb-95f5-5b58-d5b5-153c069818fc@redhat.com>
Date: Thu, 22 Oct 2020 12:38:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM5PR11MB14351121729909028D6EB365C31D0@DM5PR11MB1435.namprd11.prod.outlook.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "stefanha@gmail.com" <stefanha@gmail.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>, "Wu, Hao" <hao.wu@intel.com>, "Tian,
 Jun J" <jun.j.tian@intel.com>
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

Ck9uIDIwMjAvMTAvMjIg5LiK5Y2IMTE6NTQsIExpdSwgWWkgTCB3cm90ZToKPiBIaSBKYXNvbiwK
Pgo+PiBGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+PiBTZW50OiBUaHVy
c2RheSwgT2N0b2JlciAyMiwgMjAyMCAxMDo1NiBBTQo+Pgo+IFsuLi5dCj4+IElmIHlvdShJbnRl
bCkgZG9uJ3QgaGF2ZSBwbGFuIHRvIGRvIHZEUEEsIHlvdSBzaG91bGQgbm90IHByZXZlbnQgb3Ro
ZXIgdmVuZG9ycwo+PiBmcm9tIGltcGxlbWVudGluZyBQQVNJRCBjYXBhYmxlIGhhcmR3YXJlIHRo
cm91Z2ggbm9uLVZGSU8gc3Vic3lzdGVtL3VBUEkKPj4gb24gdG9wIG9mIHlvdXIgU0lPViBhcmNo
aXRlY3R1cmUuIElzbid0IGl0Pwo+IHllcywgdGhhdCdzIHRydWUuCj4KPj4gU28gaWYgSW50ZWwg
aGFzIHRoZSB3aWxsaW5nIHRvIGNvbGxhYm9yYXRlIG9uIHRoZSBQT0MsIEknZCBoYXBweSB0byBo
ZWxwLiBFLmcgaXQncyBub3QKPj4gaGFyZCB0byBoYXZlIGEgUEFTSUQgY2FwYWJsZSB2aXJ0aW8g
ZGV2aWNlIHRocm91Z2ggcWVtdSwgYW5kIHdlIGNhbiBzdGFydCBmcm9tCj4+IHRoZXJlLgo+IGFj
dHVhbGx5LCBJJ20gYWxyZWFkeSBkb2luZyBhIHBvYyB0byBtb3ZlIHRoZSBQQVNJRCBhbGxvY2F0
aW9uL2ZyZWUgaW50ZXJmYWNlCj4gb3V0IG9mIFZGSU8uIFNvIHRoYXQgb3RoZXIgdXNlcnMgY291
bGQgdXNlIGl0IGFzIHdlbGwuIEkgdGhpbmsgdGhpcyBpcyBhbHNvCj4gd2hhdCB5b3UgcmVwbGll
ZCBwcmV2aW91c2x5LiA6LSkgSSdsbCBzZW5kIG91dCB3aGVuIGl0J3MgcmVhZHkgYW5kIHNlZWsg
Zm9yCj4geW91ciBoZWxwIG9uIG1hdHVyZSBpdC4gZG9lcyBpdCBzb3VuZCBnb29kIHRvIHlvdT8K
CgpZZXMsIGZpbmUgd2l0aCBtZS4KClRoYW5rcwoKCj4KPiBSZWdhcmRzLAo+IFlpIExpdQo+Cj4+
IFRoYW5rcwo+Pgo+PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
