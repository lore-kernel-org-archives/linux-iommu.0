Return-Path: <SRS0=eMD9=K6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2686EC47425
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 16:20:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBA066140F
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 16:20:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBA066140F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9C9C4843C1;
	Fri,  4 Jun 2021 16:20:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OnBIL6nEM7_d; Fri,  4 Jun 2021 16:20:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 46A78843B1;
	Fri,  4 Jun 2021 16:20:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0CC3EC000E;
	Fri,  4 Jun 2021 16:20:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27990C0001
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 16:20:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 091D1843B1
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 16:20:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oMBySvtIZ3ep for <iommu@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 16:20:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 42A66843C1
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 16:20:08 +0000 (UTC)
IronPort-SDR: iO4FRmVNqcbrh1QnAOK92ctEIEfccAFkFpMovgLaUzF7YPweKApRrTwsZmDqCwIvJ99X94dSnI
 wqUFg+2FlZfA==
X-IronPort-AV: E=McAfee;i="6200,9189,10005"; a="202463055"
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; d="scan'208";a="202463055"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2021 09:20:05 -0700
IronPort-SDR: CTvtJdPKdL7KqXyLzIbdMrFdnFKp+Ju+OSzf2PnUoTrmxEGmg1uGDqEgovEeQOFzdWMSQpKoeJ
 wr0Z0gzGuBXA==
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; d="scan'208";a="446738781"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2021 09:20:05 -0700
Date: Fri, 4 Jun 2021 09:22:43 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210604092243.245bd0f4@jacob-builder>
In-Reply-To: <1175ebd5-9d8e-2000-6d05-baa93e960915@redhat.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <c9c066ae-2a25-0799-51a7-0ca47fff41a1@huawei.com>
 <aa1624bf-e472-2b66-1d20-54ca23c19fd2@linux.intel.com>
 <ed4f6e57-4847-3ed2-75de-cea80b2fbdb8@huawei.com>
 <01fe5034-42c8-6923-32f1-e287cc36bccc@linux.intel.com>
 <20210601173323.GN1002214@nvidia.com>
 <23a482f9-b88a-da98-3800-f3fd9ea85fbd@huawei.com>
 <20210603111914.653c4f61@jacob-builder>
 <1175ebd5-9d8e-2000-6d05-baa93e960915@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@nvidia.com>,
 "wanghaibin.wang@huawei.com" <wanghaibin.wang@huawei.com>, "Tian,
 Kevin" <kevin.tian@intel.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 David Woodhouse <dwmw2@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Shenming Lu <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>
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

SGkgSmFzb24sCgpPbiBGcmksIDQgSnVuIDIwMjEgMDk6MzA6MzcgKzA4MDAsIEphc29uIFdhbmcg
PGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgoKPiDlnKggMjAyMS82LzQg5LiK5Y2IMjoxOSwg
SmFjb2IgUGFuIOWGmemBkzoKPiA+IEhpIFNoZW5taW5nLAo+ID4KPiA+IE9uIFdlZCwgMiBKdW4g
MjAyMSAxMjo1MDoyNiArMDgwMCwgU2hlbm1pbmcgTHUgPGx1c2hlbm1pbmdAaHVhd2VpLmNvbT4K
PiA+IHdyb3RlOgo+ID4gIAo+ID4+IE9uIDIwMjEvNi8yIDE6MzMsIEphc29uIEd1bnRob3JwZSB3
cm90ZTogIAo+ID4+PiBPbiBUdWUsIEp1biAwMSwgMjAyMSBhdCAwODozMDozNVBNICswODAwLCBM
dSBCYW9sdSB3cm90ZToKPiA+Pj4gICAgICAKPiA+Pj4+IFRoZSBkcml2ZXJzIHJlZ2lzdGVyIHBl
ciBwYWdlIHRhYmxlIGZhdWx0IGhhbmRsZXJzIHRvIC9kZXYvaW9hc2lkCj4gPj4+PiB3aGljaCB3
aWxsIHRoZW4gcmVnaXN0ZXIgaXRzZWxmIHRvIGlvbW11IGNvcmUgdG8gbGlzdGVuIGFuZCByb3V0
ZQo+ID4+Pj4gdGhlIHBlci0gZGV2aWNlIEkvTyBwYWdlIGZhdWx0cy4gIAo+ID4+PiBJJ20gc3Rp
bGwgY29uZnVzZWQgd2h5IGRyaXZlcnMgbmVlZCBmYXVsdCBoYW5kbGVycyBhdCBhbGw/ICAKPiA+
PiBFc3NlbnRpYWxseSBpdCBpcyB0aGUgdXNlcnNwYWNlIHRoYXQgbmVlZHMgdGhlIGZhdWx0IGhh
bmRsZXJzLAo+ID4+IG9uZSBjYXNlIGlzIHRvIGRlbGl2ZXIgdGhlIGZhdWx0cyB0byB0aGUgdklP
TU1VLCBhbmQgYW5vdGhlcgo+ID4+IGNhc2UgaXMgdG8gZW5hYmxlIElPUEYgb24gdGhlIEdQQSBh
ZGRyZXNzIHNwYWNlIGZvciBvbi1kZW1hbmQKPiA+PiBwYWdpbmcsIGl0IHNlZW1zIHRoYXQgYm90
aCBjb3VsZCBiZSBzcGVjaWZpZWQgaW4vdGhyb3VnaCB0aGUKPiA+PiBJT0FTSURfQUxMT0MgaW9j
dGw/Cj4gPj4gIAo+ID4gSSB3b3VsZCB0aGluayBJT0FTSURfQklORF9QR1RBQkxFIGlzIHdoZXJl
IGZhdWx0IGhhbmRsZXIgc2hvdWxkIGJlCj4gPiByZWdpc3RlcmVkLiBUaGVyZSB3b3VsZG4ndCBi
ZSBhbnkgSU8gcGFnZSBmYXVsdCB3aXRob3V0IHRoZSBiaW5kaW5nCj4gPiBhbnl3YXkuCj4gPgo+
ID4gSSBhbHNvIGRvbid0IHVuZGVyc3RhbmQgd2h5IGRldmljZSBkcml2ZXJzIHNob3VsZCByZWdp
c3RlciB0aGUgZmF1bHQKPiA+IGhhbmRsZXIsIHRoZSBmYXVsdCBpcyBkZXRlY3RlZCBieSB0aGUg
cElPTU1VIGFuZCBpbmplY3RlZCB0byB0aGUKPiA+IHZJT01NVS4gU28gSSB0aGluayBpdCBzaG91
bGQgYmUgdGhlIElPQVNJRCBpdHNlbGYgcmVnaXN0ZXIgdGhlIGhhbmRsZXIuCj4gPiAgCj4gCj4g
Cj4gQXMgZGlzY3Vzc2VkIGluIGFub3RoZXIgdGhyZWFkLgo+IAo+IEkgdGhpbmsgdGhlIHJlYXNv
biBpcyB0aGF0IEFUUyBkb2Vzbid0IGZvcmJpZCB0aGUgI1BGIHRvIGJlIHJlcG9ydGVkIHZpYSAK
PiBhIGRldmljZSBzcGVjaWZpYyB3YXkuCj4gClllcywgaW4gdGhhdCBjYXNlIHdlIHNob3VsZCBz
dXBwb3J0IGJvdGguIEdpdmUgdGhlIGRldmljZSBkcml2ZXIgYSBjaGFuY2UKdG8gaGFuZGxlIHRo
ZSBJT1BGIGlmIGl0IGNhbi4KCj4gVGhhbmtzCj4gCj4gCj4gPiAgCj4gPj4gVGhhbmtzLAo+ID4+
IFNoZW5taW5nCj4gPj4gIAo+ID4KPiA+IFRoYW5rcywKPiA+Cj4gPiBKYWNvYgo+ID4gIAo+IAoK
ClRoYW5rcywKCkphY29iCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21t
dQ==
