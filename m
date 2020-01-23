Return-Path: <SRS0=99fx=3M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29930C2D0DB
	for <iommu@archiver.kernel.org>; Thu, 23 Jan 2020 14:55:49 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA58D21835
	for <iommu@archiver.kernel.org>; Thu, 23 Jan 2020 14:55:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA58D21835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A94E086B1D;
	Thu, 23 Jan 2020 14:55:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bYIxv3NjC5IN; Thu, 23 Jan 2020 14:55:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DA53386B13;
	Thu, 23 Jan 2020 14:55:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD697C0176;
	Thu, 23 Jan 2020 14:55:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94535C0174
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jan 2020 14:55:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 7D46920402
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jan 2020 14:55:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id llStNx93U4Hr for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jan 2020 14:55:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id EE9142000B
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jan 2020 14:55:44 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A9361FB;
 Thu, 23 Jan 2020 06:55:44 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0BB713F68E;
 Thu, 23 Jan 2020 06:55:42 -0800 (PST)
Subject: Re: [RFC PATCH 3/4] iommu: Preallocate iommu group when probing
 devices
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
References: <20200101052648.14295-1-baolu.lu@linux.intel.com>
 <20200101052648.14295-4-baolu.lu@linux.intel.com>
 <20200117102151.GF15760@8bytes.org>
 <25e2e7fa-487c-f951-4b2c-27bac5e30815@linux.intel.com>
 <b721d3f7-6292-35d6-a9eb-154d3233dcc0@arm.com>
 <f04c590b-d966-88e8-7309-e73b600d4e9f@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <c7c23d49-bd44-a78c-bb83-de665737a5f8@arm.com>
Date: Thu, 23 Jan 2020 14:55:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <f04c590b-d966-88e8-7309-e73b600d4e9f@linux.intel.com>
Content-Language: en-GB
Cc: kevin.tian@intel.com, ashok.raj@intel.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com,
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>
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

T24gMjIvMDEvMjAyMCA1OjM5IGFtLCBMdSBCYW9sdSB3cm90ZToKPiBIaSBSb2JpbiwKPiAKPiBP
biAxLzIxLzIwIDg6NDUgUE0sIFJvYmluIE11cnBoeSB3cm90ZToKPj4gT24gMTkvMDEvMjAyMCA2
OjI5IGFtLCBMdSBCYW9sdSB3cm90ZToKPj4+IEhpIEpvZXJnLAo+Pj4KPj4+IE9uIDEvMTcvMjAg
NjoyMSBQTSwgSm9lcmcgUm9lZGVsIHdyb3RlOgo+Pj4+IE9uIFdlZCwgSmFuIDAxLCAyMDIwIGF0
IDAxOjI2OjQ3UE0gKzA4MDAsIEx1IEJhb2x1IHdyb3RlOgo+Pj4+PiBUaGlzIHNwbGl0cyBpb21t
dSBncm91cCBhbGxvY2F0aW9uIGZyb20gYWRkaW5nIGRldmljZXMuIFRoaXMgbWFrZXMKPj4+Pj4g
aXQgcG9zc2libGUgdG8gZGV0ZXJtaW5lIHRoZSBkZWZhdWx0IGRvbWFpbiB0eXBlIGZvciBlYWNo
IGdyb3VwIGFzCj4+Pj4+IGFsbCBkZXZpY2VzIGJlbG9uZ2luZyB0byB0aGUgZ3JvdXAgaGF2ZSBi
ZWVuIGRldGVybWluZWQuCj4+Pj4KPj4+PiBJIHRoaW5rIGl0cyBiZXR0ZXIgdG8ga2VlcCBncm91
cCBhbGxvY2F0aW9uIGFzIGl0IGlzIGFuZCBqdXN0IGRlZmVyCj4+Pj4gZGVmYXVsdCBkb21haW4g
YWxsb2NhdGlvbiBhZnRlciBlYWNoIGRldmljZSBpcyBpbiBpdHMgZ3JvdXAuIEJ1dCB0YWtlCj4+
Pgo+Pj4gSSB0cmllZCBkZWZlcmluZyBkZWZhdWx0IGRvbWFpbiBhbGxvY2F0aW9uLCBidXQgaXQg
c2VlbXMgbm90IHBvc3NpYmxlLgo+Pj4KPj4+IFRoZSBjYWxsIHBhdGggb2YgYWRkaW5nIGRldmlj
ZXMgaW50byB0aGVpciBncm91cHM6Cj4+Pgo+Pj4gaW9tbXVfcHJvYmVfZGV2aWNlCj4+PiAtPiBv
cHMtPmFkZF9kZXZpY2UoZGV2KQo+Pj4gwqDCoMKgIC0+IChpb21tdSB2ZW5kb3IgZHJpdmVyKSBp
b21tdV9ncm91cF9nZXRfZm9yX2RldihkZXYpCj4+Pgo+Pj4gQWZ0ZXIgZG9pbmcgdGhpcywgdGhl
IHZlbmRvciBkcml2ZXIgd2lsbCBnZXQgdGhlIGRlZmF1bHQgZG9tYWluIGFuZAo+Pj4gYXBwbHkg
ZG1hX29wcyBhY2NvcmRpbmcgdG8gdGhlIGRvbWFpbiB0eXBlLiBJZiB3ZSBkZWZlciB0aGUgZG9t
YWluCj4+PiBhbGxvY2F0aW9uLCB0aGV5IHdpbGwgZ2V0IGEgTlVMTCBkZWZhdWx0IGRvbWFpbiBh
bmQgY2F1c2UgcGFuaWMgaW4KPj4+IHRoZSB2ZW5kb3IgZHJpdmVyLgo+Pj4KPj4+IEFueSBzdWdn
ZXN0aW9ucz8KPj4KPj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtaW9tbXUvNmRiYmZj
MTAtMzI0Ny03NDRjLWFlOGQtNDQzYTMzNmUwYzUwQGxpbnV4LmludGVsLmNvbS8gCj4+Cj4+Cj4+
IEhhdmVuJ3Qgd2UgYmVlbiBoZXJlIGJlZm9yZT8gOykKPj4KPj4gU2luY2Ugd2UgY2FuJ3QgKHNh
ZmVseSBvciByZWFzb25hYmx5KSBjaGFuZ2UgYSBncm91cCdzIGRlZmF1bHQgZG9tYWluIAo+PiBh
ZnRlciBvcHMtPmFkZF9kZXZpY2UoKSBoYXMgcmV0dXJuZWQsIGFuZCBpbiBnZW5lcmFsIGl0IGdl
dHMgCj4+IGltcHJhY3RpY2FsIHRvIGV2YWx1YXRlICJhbGwgZGV2aWNlIGluIGEgZ3JvdXAiIG9u
Y2UgeW91IGxvb2sgYmV5b25kIAo+PiAmcGNpX2J1c190eXBlIChvciBjb25zaWRlciBob3RwbHVn
IGFzIG1lbnRpb25lZCksIHRoZW4gQUZBSUNTIHRoZXJlJ3MgCj4+IG5vIHJlYXNvbmFibGUgd2F5
IHRvIGdldCBhd2F5IGZyb20gdGhlIGRlZmF1bHQgZG9tYWluIHR5cGUgYmVpbmcgCj4+IGRlZmlu
ZWQgYnkgdGhlIGZpcnN0IGRldmljZSB0byBhdHRhY2guCj4gCj4gWWVzLCBhZ3JlZWQuCj4gCj4+
IEJ1dCBpbiBwcmFjdGljZSBpdCdzIGhhcmRseSBhIHByb2JsZW0gYW55d2F5IC0gaWYgZXZlcnkg
ZGV2aWNlIGluIGEgCj4+IGdpdmVuIGdyb3VwIHJlcXVlc3RzIHRoZSBzYW1lIGRvbWFpbiB0eXBl
IHRoZW4gaXQgZG9lc24ndCBtYXR0ZXIgd2hpY2ggCj4+IGNvbWVzIGZpcnN0LCBhbmQgaWYgdGhl
eSBkb24ndCB0aGVuIHdlIHVsdGltYXRlbHkgZW5kIHVwIHdpdGggYW4gCj4+IGltcG9zc2libGUg
c2V0IG9mIGNvbnN0cmFpbnRzLCBzbyBhcmUgZG9vbWVkIHRvIGRvIHRoZSAnd3JvbmcnIHRoaW5n
IAo+PiByZWdhcmRsZXNzLgo+IAo+IFRoZSB0aGlyZCBjYXNlIGlzLCBmb3IgZXhhbXBsZSwgdGhy
ZWUgZGV2aWNlcyBBLCBCLCBDIGluIGEgZ3JvdXAuIFRoZQo+IGZpcnN0IGRldmljZSBBIGlzIG5l
dXRyYWwgYWJvdXQgd2hpY2ggdHlwZSBvZiBkZWZhdWx0IGRvbWFpbiB0eXBlIGlzCj4gdXNlZC4g
U28gdGhlIGlvbW11IGZyYW1ld29yayB3aWxsIHVzZSBhIHN0YXRpYyBkZWZhdWx0IGRvbWFpbi4g
QnV0IHRoZQo+IGRldmljZSBCIHJlcXVpcmVzIHRvIHVzZSBhIHNwZWNpZmljIG9uZSB3aGljaCBp
cyBkaWZmZXJlbnQgZnJvbSB0aGUKPiBkZWZhdWx0LiBDdXJyZW50bHksIHRoaXMgaXMgaGFuZGxl
ZCBpbiB0aGUgdmVuZG9yIGlvbW11IGRyaXZlciBhbmQgb25lCj4gbW90aXZhdGlvbiBvZiB0aGlz
IHBhdGNoIHNldCBpcyB0byBoYW5kbGUgdGhpcyBpbiB0aGUgZ2VuZXJpYyBsYXllci4KClllcywg
SSB3YXNuJ3QgZXhwbGljaXRseSBjb25zaWRlcmluZyB0aGF0IHBhcnRpY3VsYXIgY2FzZSwgYnV0
IGl0IG1vc3RseSAKZmFsbHMgb3V0IG1vcmUgb3IgbGVzcyB0aGUgc2FtZSB3YXkuIEdpdmVuIHRo
YXQgbXVsdGktZGV2aWNlIGdyb3VwcyAKKnNob3VsZCogYmUgcmVsYXRpdmVseSByYXJlLCBmb3Ig
dGhlIHVzZXIgb3ZlcnJpZGUgaXQgc2VlbXMgcmVhc29uYWJsZSAKdG8gZXhwZWN0IHRoZSB1c2Vy
IHRvIHNlZSB3aGVuIGRldmljZXMgZ2V0IGdyb3VwZWQgYW5kIHNwZWNpZnkgYWxsIG9mIAp0aGVt
IHRvIGFjaGlldmUgdGhlIGRlc2lyZWQgcmVzdWx0OyB0aGUgdHJ1c3RlZC91bnRydXN0ZWQgYXR0
cmlidXRlIApkZWZpbml0ZWx5IHNob3VsZG4ndCBkaWZmZXIgd2l0aGluIGFueSBnaXZlbiBncm91
cDsgYW5kIApvcHBvcnR1bmlzdGljYWxseSByZXBsYWNpbmcgcGFzc3Rocm91Z2ggZG9tYWlucyB3
aXRoIHRyYW5zbGF0aW9uIGRvbWFpbnMgCmZvciBETUEtbGltaXRlZCBkZXZpY2VzIGNhbiBvbmx5
IGV2ZXIgYmUgYSBiZXN0LWVmZm9ydCB0aGluZyB3aXRob3V0IApjb25zaXN0ZW50IHJlc3VsdHMs
IHNpbmNlIGF0IGJlc3QgdGhhdCBzdGlsbCBjb21lcyBkb3duIHRvIHdoaWNoIGRyaXZlciAKcHJv
YmVkIGFuZCBjYWxsZWQgZG1hX3NldF9tYXNrKCkgZmlyc3QuCgpQbGF0Zm9ybS1zcGVjaWZpYyBl
eGNlcHRpb25zIGxpa2UgaW4gZGV2aWNlX2RlZl9kb21haW5fdHlwZSgpIHByb2JhYmx5IApkbyB3
YW50IHRvIHN0YXkgaW4gdGhlIGluZGl2aWR1YWwgZHJpdmVycywgYnV0IHJvbGxpbmcgdGhhdCB1
cCBpbnRvIApkZWZhdWx0IGRvbWFpbiBhbGxvY2F0aW9uIHdvdWxkIGJlIG5lYXQsIGFuZCBmdW5j
dGlvbmFsbHkgbm8gd29yc2UgdGhhbiAKdGhlIGV4aXN0aW5nIHByb2Nlc3MuCgpJbiBwcmluY2lw
bGUgd2UgY291bGQgZmFpcmx5IGVhc2lseSBkZWxheSBhbGxvY2F0aW5nIGEgZ3JvdXAncyBkZWZh
dWx0IApkb21haW4gdW50aWwgdGhlIGZpcnN0IGRyaXZlciBiaW5kIGV2ZW50LiBJdCB3b3VsZG4n
dCBoZWxwIHVuaXZlcnNhbGx5IC0gCmluIHRoZSBhYnNvbHV0ZSB3b3JzdCBjYXNlLCBkZXZpY2Ug
QiBtaWdodCBvbmx5IGJlIGNyZWF0ZWQgYXQgYWxsIGJ5IApkZXZpY2UgQSdzIGRyaXZlciBwcm9i
aW5nIC0gYW5kIGl0IG1pZ2h0IG5lZWQgY2FyZWZ1bCBjb29yZGluYXRpb24gaW4gCmFyZWFzIGxp
a2UgdGhlIGJ1cy0+ZG1hX2NvbmZpZ3VyZSgpIGZsb3csIGJ1dCBpdCBjb3VsZCBhdCBsZWFzdCBo
ZWxwIAphY2NvbW1vZGF0ZSB0aGUgbW9yZSBjb21tb24gUENJIGNhc2UuCgpSb2Jpbi4KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBs
aXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
