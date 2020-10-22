Return-Path: <SRS0=at/m=D5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF63C55178
	for <iommu@archiver.kernel.org>; Thu, 22 Oct 2020 02:56:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD895222E9
	for <iommu@archiver.kernel.org>; Thu, 22 Oct 2020 02:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VWQ6ajWR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD895222E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 371E920496;
	Thu, 22 Oct 2020 02:56:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t5M6kuLRgrZG; Thu, 22 Oct 2020 02:56:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id AA46220495;
	Thu, 22 Oct 2020 02:56:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96C91C088B;
	Thu, 22 Oct 2020 02:56:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7714EC0051
 for <iommu@lists.linux-foundation.org>; Thu, 22 Oct 2020 02:56:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 51D4F20495
 for <iommu@lists.linux-foundation.org>; Thu, 22 Oct 2020 02:56:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cXZ43trTr3ZY for <iommu@lists.linux-foundation.org>;
 Thu, 22 Oct 2020 02:56:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id ED2F120486
 for <iommu@lists.linux-foundation.org>; Thu, 22 Oct 2020 02:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603335393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Ebof72AAYUkpsZe+d7w21egOfOytLBoHlz0y4o/tgs=;
 b=VWQ6ajWRD6C/w2+R3182+Wzx270n2FC2VY2ftIdbS33KzOAzm9erE2xUamGEIq7L2o+ArS
 YML6K3XsrWbgk6WtHwYaFsNH3XBLdlka83wAGc/R+uM9atldBgfCL4pxj6Td2O1nIUIBN+
 jN7IYjhBHWcafSk3awdP9wQHCPcsDHY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-_x_WK2oLO_OHAr8IvqDeRg-1; Wed, 21 Oct 2020 22:56:29 -0400
X-MC-Unique: _x_WK2oLO_OHAr8IvqDeRg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57DDD835B49;
 Thu, 22 Oct 2020 02:56:27 +0000 (UTC)
Received: from [10.72.13.119] (ovpn-13-119.pek2.redhat.com [10.72.13.119])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D1D381002C05;
 Thu, 22 Oct 2020 02:55:56 +0000 (UTC)
Subject: Re: (proposal) RE: [PATCH v7 00/16] vfio: expose virtual Shared
 Virtual Addressing to VMs
To: "Raj, Ashok" <ashok.raj@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <DM5PR11MB14354A8A126E686A5F20FEC2C31F0@DM5PR11MB1435.namprd11.prod.outlook.com>
 <20201020140217.GI6219@nvidia.com> <20201020162430.GA85321@otc-nc-03>
 <20201020170336.GK6219@nvidia.com> <20201020195146.GA86371@otc-nc-03>
 <20201020195557.GO6219@nvidia.com> <20201020200844.GC86371@otc-nc-03>
 <20201020201403.GP6219@nvidia.com> <20201020202713.GF86371@otc-nc-03>
 <20201021114829.GR6219@nvidia.com> <20201021175146.GA92867@otc-nc-03>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <816799a0-49e4-a384-8990-eae9e67d4425@redhat.com>
Date: Thu, 22 Oct 2020 10:55:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201021175146.GA92867@otc-nc-03>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "stefanha@gmail.com" <stefanha@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "Zhu,
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

Ck9uIDIwMjAvMTAvMjIg5LiK5Y2IMTo1MSwgUmFqLCBBc2hvayB3cm90ZToKPiBPbiBXZWQsIE9j
dCAyMSwgMjAyMCBhdCAwODo0ODoyOUFNIC0wMzAwLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6Cj4+
IE9uIFR1ZSwgT2N0IDIwLCAyMDIwIGF0IDAxOjI3OjEzUE0gLTA3MDAsIFJhaiwgQXNob2sgd3Jv
dGU6Cj4+PiBPbiBUdWUsIE9jdCAyMCwgMjAyMCBhdCAwNToxNDowM1BNIC0wMzAwLCBKYXNvbiBH
dW50aG9ycGUgd3JvdGU6Cj4+Pj4gT24gVHVlLCBPY3QgMjAsIDIwMjAgYXQgMDE6MDg6NDRQTSAt
MDcwMCwgUmFqLCBBc2hvayB3cm90ZToKPj4+Pj4gT24gVHVlLCBPY3QgMjAsIDIwMjAgYXQgMDQ6
NTU6NTdQTSAtMDMwMCwgSmFzb24gR3VudGhvcnBlIHdyb3RlOgo+Pj4+Pj4gT24gVHVlLCBPY3Qg
MjAsIDIwMjAgYXQgMTI6NTE6NDZQTSAtMDcwMCwgUmFqLCBBc2hvayB3cm90ZToKPj4+Pj4+PiBJ
IHRoaW5rIHdlIGFncmVlZCAob3IgYWdyZWUgdG8gZGlzYWdyZWUgYW5kIGNvbW1pdCkgZm9yIGRl
dmljZSB0eXBlcyB0aGF0Cj4+Pj4+Pj4gd2UgaGF2ZSBmb3IgU0lPViwgVkZJTyBiYXNlZCBhcHBy
b2FjaCB3b3JrcyB3ZWxsIHdpdGhvdXQgaGF2aW5nIHRvIHJlLWludmVudAo+Pj4+Pj4+IGFub3Ro
ZXIgd2F5IHRvIGRvIHRoZSBzYW1lIHRoaW5ncy4gTm90IGxvb2tpbmcgZm9yIGEgc2hvcnRjdXQg
YnkgYW55IG1lYW5zLAo+Pj4+Pj4+IGJ1dCB3ZSBuZWVkIHRvIHBsYW4gYXJvdW5kIGV4aXN0aW5n
IGhhcmR3YXJlIHRob3VnaC4gTG9va3MgbGlrZSB2RFBBIHRvb2sKPj4+Pj4+PiBzb21lIHNob3J0
Y3V0cyB0aGVuIHRvIG5vdCBhYnN0cmFjdCBpb21tdSB1QVBJIGluc3RlYWQgOi0pPyBXaGVuIGFs
bAo+Pj4+Pj4+IG5lY2Vzc2FyeSBoYXJkd2FyZSB3YXMgYXZhaWxhYmxlLi4gVGhpcyB3b3VsZCBi
ZSBhIHNvbHZlZCBwdXp6bGUuCj4+Pj4+PiBJIHRoaW5rIGl0IGlzIHRoZSBvcHBvc2l0ZSwgdklP
TU1VIGFuZCByZWxhdGVkIGhhcyBvdXRncm93biBWRklPIGFzCj4+Pj4+PiB0aGUgImhvbWUiIGFu
ZCBuZWVkcyB0byBzdGFuZCBhbG9uZS4KPj4+Pj4+Cj4+Pj4+PiBBcHBhcmVudGx5IHRoZSBIVyB0
aGF0IHdpbGwgbmVlZCBQQVNJRCBmb3IgdkRQQSBpcyBJbnRlbCBIVywgc28gaWYKPj4+Pj4gU28g
anVzdCB0byBtYWtlIHRoaXMgY2xlYXIsIEkgZGlkIGNoZWNrIGludGVybmFsbHkgaWYgdGhlcmUg
YXJlIGFueSBwbGFucwo+Pj4+PiBmb3IgdkRQQSArIFNWTS4gVGhlcmUgYXJlIG5vbmUgYXQgdGhl
IG1vbWVudC4KPj4+PiBOb3QgU1ZNLCBTSU9WLgo+Pj4gLi4uIEFuZCB0aGF0IGluY2x1ZGVkLi4g
SSBzaG91bGQgaGF2ZSBzYWlkIHZEUEEgKyBQQVNJRCwgTm8gY3VycmVudCBwbGFucy4KPj4+IEkg
aGF2ZSBubyBpZGVhIHdobyBzZXQgZXhwZWN0YXRpb25zIHdpdGggeW91LiBDYW4geW91IHBsZWFz
ZSBwdXQgbWUgaW4gdG91Y2gKPj4+IHdpdGggdGhhdCBwZXJzb24sIHByaXZhdGVseSBpcyBmaW5l
Lgo+PiBJdCB3YXMgdGhlIHRlYW0gdGhhdCBhcnVnZWQgVkRQQSBoYWQgdG8gYmUgZG9uZSB0aHJv
dWdoIFZGSU8gLSBTSU9WCj4+IGFuZCBQQVNJRCB3YXMgb25lIG9mIHRoZWlyIHJlYXNvbnMgaXQg
aGFkIHRvIGJlIFZGSU8sIGNoZWNrIHRoZSBsaXN0Cj4+IGFyY2hpdmVzCj4gSHVtbS4uLiBJIGNv
dWxkIHNlYXJjaCB0aGUgYXJoaXZlcywgYnV0IHRoZSBwb2ludCBpcyBJJ20gY29uZmlybWluZyB0
aGF0Cj4gdGhlcmUgaXMgbm8gZm9yd2FyZCBsb29raW5nIHBsYW4hCj4KPiBBbmQgd2hvIGV2ZXIg
ZGlkIHdhcyBpdCB3YXMgYmFzZWQgb24gcHJvYmFibHkgc3RyYXdtYW4gaHlwb3RoZXRpY2FsIGFy
Z3VtZW50IHRoYXQgd2Fzbid0Cj4gZ3JvdW5kZWQgaW4gcmVhbGl0eS4KPgo+PiBJZiB0aGV5IGRp
ZG4ndCBwbGFuIHRvIHVzZSBpdCwgYml0IG9mIGEgc3RyYXdtYW4gYXJndW1lbnQsIHJpZ2h0Pwo+
IFRoaXMgZG9lc24ndCBuZWVkIHRvIGNvbnRpbnVlIGxpa2UgdGhlIGRlYmF0ZXMgOi0pIFB1biBp
bnRlbmRlZCA6LSkKPgo+IEkgZG9uJ3QgdGhpbmsgaXQgbWFrZXMgYW55IHNlbnNlIHRvIGhhdmUg
YW4gYWJzdHJhY3Qgc3RyYXdtYW4gYXJndW1lbnQKPiBkZXNpZ24gZGlzY3Vzc2lvbi4gWWkgaXMg
bG9va2luZyBpbnRvIGZvciBwYXNpZCBtYW5hZ2VtZW50IGFsb25lLiBSZXN0Cj4gb2YgdGhlIElP
TU1VIHJlbGF0ZWQgdG9waWNzIHNob3VsZCB3YWl0IHVudGlsIHdlIGhhdmUgYW5vdGhlcgo+ICpy
ZWFsKiB1c2UgcmVxdWlyaW5nIGNvbnNvbGlkYXRpb24uCj4KPiBDb250cmFyeSB0byB5b3VyIGFy
Z3VtZW50LCB2RFBBIHdlbnQgd2l0aCBhIGhhbGYgYmxvd24gZGV2aWNlIG9ubHkKPiBpb21tdSB1
c2VyIHdpdGhvdXQgY29uc2lkZXJpbmcgZXhpc3RpbmcgYWJzdHJhY3Rpb25zIGxpa2UgY29udGFp
bmVycwo+IGFuZCBzdWNoIGluIFZGSU8gaXMgcGFydCBvZiB0aGUgcmVhc29uIHRoZSBnYXAgaXMg
YmlnIGF0IHRoZSBtb21lbnQuCj4gQW5kIHlvdSBtaWdodCBub3QgYWdyZWUsIGJ1dCB0aGF0J3Mg
YmVzaWRlIHRoZSBwb2ludC4KCgpDYW4geW91IGV4cGxhaW4gd2h5IGl0IG11c3QgY2FyZSBWRklP
IGFic3RyYWN0aW9ucz8gdkRQQSBpcyB0cnlpbmcgdG8gCmhpZGUgZGV2aWNlIGRldGFpbHMgd2hp
Y2ggaXMgZnVuZGFtZW50YWxseSBkaWZmZXJlbnQgd2l0aCB3aGF0IFZGSU8gCndhbnRzIHRvIGRv
LiB2RFBBIGFsbG93cyB0aGUgcGFyZW50IHRvIGRlYWwgd2l0aCBJT01NVSBzdHVmZnMsIGFuZCBp
ZiAKbmVjZXNzYXJ5LCB0aGUgcGFyZW50IGNhbiB0YWxrIHdpdGggSU9NTVUgZHJpdmVycyBkaXJl
Y3RseSB2aWEgSU9NTVUgQVBJcy4KCgo+ICAgCj4KPiBSYXRoZXIgdGhhbiBwaXZvdCBvdXJzZWx2
ZXMgYXJvdW5kIGh5cG90aGV0aWNhbCwgc3RyYXdtYW4sCj4gbm9uLWludGVyc2VjdGluZywgc3Vn
Z2VzdGluZyBhcmNoaXRlY3R1cmUgd2l0aG91dCBoYXZpbmcgZG9uZSBhIHByb29mIG9mCj4gY29u
Y2VwdCB0byB2YWxpZGF0ZSB0aGUgcHJvcG9zYWwgc2hvdWxkIHN0b3AuIFdlIGhhdmUgdG8gZ3Jv
dW5kIG91cnNlbHZlcwo+IGluIHJlYWxpdHkuCgoKVGhlIHJlYWxpdHkgaXMgVkZJTyBzaG91bGQg
bm90IGJlIHRoZSBvbmx5IHVzZXIgZm9yICh2KVNWQS9TSU9WL1BBU0lELiAKVGhlIGtlcm5lbCBo
YXJkIGFscmVhZHkgaGFkIHVzZXJzIGxpa2UgR1BVIG9yIHVhY2NlLgoKCj4KPiBUaGUgdXNlIGNh
c2VzIHdlIGhhdmUgc28gZmFyIGZvciBTSU9WLCBWRklPIGFuZCBtZGV2IHNlZW0gdG8gYmUgdGhl
IHJpZ2h0Cj4gY2FuZGlkYXRlcyBhbmQgYWRkcmVzc2VzIHRoZW0gd2VsbC4gTm93IHlvdSBtaWdo
dCBkaXNhZ3JlZSwgYnV0IGFzIG5vdGVkIHdlCj4gYWxsIGFncmVlZCB0byBtb3ZlIHBhc3QgdGhp
cy4KCgpUaGUgbWRldiBpcyBub3QgcGVyZmVjdCBmb3Igc3VyZSwgYnV0IGl0J3MgYW5vdGhlciB0
b3BpYy4KCklmIHlvdShJbnRlbCkgZG9uJ3QgaGF2ZSBwbGFuIHRvIGRvIHZEUEEsIHlvdSBzaG91
bGQgbm90IHByZXZlbnQgb3RoZXIgCnZlbmRvcnMgZnJvbSBpbXBsZW1lbnRpbmcgUEFTSUQgY2Fw
YWJsZSBoYXJkd2FyZSB0aHJvdWdoIG5vbi1WRklPIApzdWJzeXN0ZW0vdUFQSSBvbiB0b3Agb2Yg
eW91ciBTSU9WIGFyY2hpdGVjdHVyZS4gSXNuJ3QgaXQ/CgpTbyBpZiBJbnRlbCBoYXMgdGhlIHdp
bGxpbmcgdG8gY29sbGFib3JhdGUgb24gdGhlIFBPQywgSSdkIGhhcHB5IHRvIApoZWxwLiBFLmcg
aXQncyBub3QgaGFyZCB0byBoYXZlIGEgUEFTSUQgY2FwYWJsZSB2aXJ0aW8gZGV2aWNlIHRocm91
Z2ggCnFlbXUsIGFuZCB3ZSBjYW4gc3RhcnQgZnJvbSB0aGVyZS4KClRoYW5rcwoKCj4KCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcg
bGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
