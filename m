Return-Path: <SRS0=U/E5=CJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4DEC433E2
	for <iommu@archiver.kernel.org>; Mon, 31 Aug 2020 00:57:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0FCA2071B
	for <iommu@archiver.kernel.org>; Mon, 31 Aug 2020 00:57:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0FCA2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7A85587627;
	Mon, 31 Aug 2020 00:57:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t5lOtHBqpBvr; Mon, 31 Aug 2020 00:57:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5B096875C2;
	Mon, 31 Aug 2020 00:57:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A982C0052;
	Mon, 31 Aug 2020 00:57:28 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9BEDFC0051
 for <iommu@lists.linux-foundation.org>; Mon, 31 Aug 2020 00:57:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 7D193204F3
 for <iommu@lists.linux-foundation.org>; Mon, 31 Aug 2020 00:57:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Rhgc3ADxk6tC for <iommu@lists.linux-foundation.org>;
 Mon, 31 Aug 2020 00:57:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by silver.osuosl.org (Postfix) with ESMTPS id 6A754204D2
 for <iommu@lists.linux-foundation.org>; Mon, 31 Aug 2020 00:57:24 +0000 (UTC)
IronPort-SDR: WDFTScviaqawI5VzhbsDjFurhxnB6LU4h175+AfyZBJL12CJGVw19LUQ53ESyGc8QDoYwwzsF3
 GO1LET02y+7w==
X-IronPort-AV: E=McAfee;i="6000,8403,9729"; a="144575004"
X-IronPort-AV: E=Sophos;i="5.76,373,1592895600"; d="scan'208";a="144575004"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2020 17:57:22 -0700
IronPort-SDR: 4OdmrwWzHpxy5SU28G19puRzaUVrwQ6SaYDcVYtCuqXECE/O82FD21j5tLXsYl1EtHADFe5kjw
 371F55ZZl/MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,373,1592895600"; d="scan'208";a="324738088"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by fmsmga004.fm.intel.com with ESMTP; 30 Aug 2020 17:57:15 -0700
Subject: Re: [patch V2 00/46] x86, PCI, XEN, genirq ...: Prepare for device MSI
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
References: <20200826111628.794979401@linutronix.de>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <02e30654-714b-520a-0d20-fca20794df93@linux.intel.com>
Date: Mon, 31 Aug 2020 08:51:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200826111628.794979401@linutronix.de>
Content-Language: en-US
Cc: Dimitri Sivanich <sivanich@hpe.com>, linux-hyperv@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>, linux-pci@vger.kernel.org,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Dan Williams <dan.j.williams@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, Baolu Lu <baolu.lu@intel.com>,
 Marc Zyngier <maz@kernel.org>, x86@kernel.org,
 Jason Gunthorpe <jgg@mellanox.com>, Megha Dey <megha.dey@intel.com>,
 xen-devel@lists.xenproject.org, Kevin Tian <kevin.tian@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Jon Derrick <jonathan.derrick@intel.com>, Juergen Gross <jgross@suse.com>,
 Russ Anderson <rja@hpe.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 iommu@lists.linux-foundation.org, Jacob Pan <jacob.jun.pan@intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
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

SGkgVGhvbWFzLAoKT24gOC8yNi8yMCA3OjE2IFBNLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6Cj4g
VGhpcyBpcyB0aGUgc2Vjb25kIHZlcnNpb24gb2YgcHJvdmlkaW5nIGEgYmFzZSB0byBzdXBwb3J0
IGRldmljZSBNU0kgKG5vbgo+IFBDSSBiYXNlZCkgYW5kIG9uIHRvcCBvZiB0aGF0IHN1cHBvcnQg
Zm9yIElNUyAoSW50ZXJydXB0IE1lc3NhZ2UgU3Rvcm0pCj4gYmFzZWQgZGV2aWNlcyBpbiBhIGhh
bGZ3YXlzIGFyY2hpdGVjdHVyZSBpbmRlcGVuZGVudCB3YXkuCgpBZnRlciBhcHBseWluZyB0aGlz
IHBhdGNoIHNlcmllcywgdGhlIGRtYXJfYWxsb2NfaHdpcnEoKSBoZWxwZXIgZG9lc24ndAp3b3Jr
IGFueW1vcmUgZHVyaW5nIGJvb3QuIFRoaXMgY2F1c2VzIHRoZSBJT01NVSBkcml2ZXIgdG8gZmFp
bCB0bwpyZWdpc3RlciB0aGUgRE1BIGZhdWx0IGhhbmRsZXIgYW5kIGFib3J0IHRoZSBJT01NVSBw
cm9iZSBwcm9jZXNzaW5nLgpJcyB0aGlzIGEga25vd24gaXNzdWU/CgpCZXN0IHJlZ2FyZHMsCmJh
b2x1Cgo+IAo+IFRoZSBmaXJzdCB2ZXJzaW9uIGNhbiBiZSBmb3VuZCBoZXJlOgo+IAo+ICAgICAg
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDIwMDgyMTAwMjQyNC4xMTk0OTIyMzFAbGludXRy
b25peC5kZQo+IAo+IEl0J3Mgc3RpbGwgYSBtaXhlZCBiYWcgb2YgYnVnIGZpeGVzLCBjbGVhbnVw
cyBhbmQgZ2VuZXJhbCBpbXByb3ZlbWVudHMKPiB3aGljaCBhcmUgd29ydGh3aGlsZSBpbmRlcGVu
ZGVudCBvZiBkZXZpY2UgTVNJLgo+IAo+IFRoZXJlIGFyZSBxdWl0ZSBhIGJ1bmNoIG9mIGlzc3Vl
cyB0byBzb2x2ZToKPiAKPiAgICAtIFg4NiBkb2VzIG5vdCB1c2UgdGhlIGRldmljZTo6bXNpX2Rv
bWFpbiBwb2ludGVyIGZvciBoaXN0b3JpY2FsIHJlYXNvbnMKPiAgICAgIGFuZCBkdWUgdG8gWEVO
LCB3aGljaCBtYWtlcyBpdCBpbXBvc3NpYmxlIHRvIGNyZWF0ZSBhbiBhcmNoaXRlY3R1cmUKPiAg
ICAgIGFnbm9zdGljIGRldmljZSBNU0kgaW5mcmFzdHJ1Y3R1cmUuCj4gCj4gICAgLSBYODYgaGFz
IGl0J3Mgb3duIG1zaV9hbGxvY19pbmZvIGRhdGEgdHlwZSB3aGljaCBpcyBwb2ludGxlc3NseQo+
ICAgICAgZGlmZmVyZW50IGZyb20gdGhlIGdlbmVyaWMgdmVyc2lvbiBhbmQgZG9lcyBub3QgYWxs
b3cgdG8gc2hhcmUgY29kZS4KPiAKPiAgICAtIFRoZSBsb2dpYyBvZiBjb21wb3NpbmcgTVNJIG1l
c3NhZ2VzIGluIGFuIGhpZXJhcmNoeSBpcyBidXN0ZWQgYXQgdGhlCj4gICAgICBjb3JlIGxldmVs
IGFuZCBvZiBjb3Vyc2Ugc29tZSAoeDg2KSBkcml2ZXJzIGRlcGVuZCBvbiB0aGF0Lgo+IAo+ICAg
IC0gQSBmZXcgbWlub3Igc2hvcnRjb21pbmdzIGFzIHVzdWFsCj4gCj4gVGhpcyBzZXJpZXMgYWRk
cmVzc2VzIHRoYXQgaW4gc2V2ZXJhbCBzdGVwczoKPiAKPiAgIDEpIEFjY2lkZW50YWwgYnVnIGZp
eGVzCj4gCj4gICAgICAgIGlvbW11L2FtZDogUHJldmVudCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVu
Y2UKPiAKPiAgIDIpIEphbml0b3JpbmcKPiAKPiAgICAgICAgeDg2L2luaXQ6IFJlbW92ZSB1bnVz
ZWQgaW5pdCBvcHMKPiAgICAgICAgUENJOiB2bWQ6IERvbnQgYWJ1c2UgdmVjdG9yIGlycW9tYWlu
IGFzIHBhcmVudAo+ICAgICAgICB4ODYvbXNpOiBSZW1vdmUgcG9pbnRsZXNzIHZjcHVfYWZmaW5p
dHkgY2FsbGJhY2sKPiAKPiAgIDMpIFNhbml0aXppbmcgdGhlIGNvbXBvc2l0aW9uIG9mIE1TSSBt
ZXNzYWdlcyBpbiBhIGhpZXJhcmNoeQo+ICAgCj4gICAgICAgIGdlbmlycS9jaGlwOiBVc2UgdGhl
IGZpcnN0IGNoaXAgaW4gaXJxX2NoaXBfY29tcG9zZV9tc2lfbXNnKCkKPiAgICAgICAgeDg2L21z
aTogTW92ZSBjb21wb3NlIG1lc3NhZ2UgY2FsbGJhY2sgd2hlcmUgaXQgYmVsb25ncwo+IAo+ICAg
NCkgU2ltcGxpZmljYXRpb24gb2YgdGhlIHg4NiBzcGVjaWZpYyBpbnRlcnJ1cHQgYWxsb2NhdGlv
biBtZWNoYW5pc20KPiAKPiAgICAgICAgeDg2L2lycTogUmVuYW1lIFg4Nl9JUlFfQUxMT0NfVFlQ
RV9NU0kqIHRvIHJlZmxlY3QgUENJIGRlcGVuZGVuY3kKPiAgICAgICAgeDg2L2lycTogQWRkIGFs
bG9jYXRpb24gdHlwZSBmb3IgcGFyZW50IGRvbWFpbiByZXRyaWV2YWwKPiAgICAgICAgaW9tbXUv
dnQtZDogQ29uc29saWRhdGUgaXJxIGRvbWFpbiBnZXR0ZXIKPiAgICAgICAgaW9tbXUvYW1kOiBD
b25zb2xpZGF0ZSBpcnEgZG9tYWluIGdldHRlcgo+ICAgICAgICBpb21tdS9pcnFfcmVtYXBwaW5n
OiBDb25zb2xpZGF0ZSBpcnEgZG9tYWluIGxvb2t1cAo+IAo+ICAgNSkgQ29uc29saWRhdGlvbiBv
ZiB0aGUgWDg2IHNwZWNpZmljIGludGVycnVwdCBhbGxvY2F0aW9uIG1lY2hhbmlzbSB0byBiZSBh
cyBjbG9zZQo+ICAgICAgYXMgcG9zc2libGUgdG8gdGhlIGdlbmVyaWMgTVNJIGFsbG9jYXRpb24g
bWVjaGFuaXNtIHdoaWNoIGFsbG93cyB0byBnZXQgcmlkCj4gICAgICBvZiBxdWl0ZSBhIGJ1bmNo
IG9mIHg4Nidpc21zIHdoaWNoIGFyZSBwb2ludGxlc3MKPiAKPiAgICAgICAgeDg2L2lycTogUHJl
cGFyZSBjb25zb2xpZGF0aW9uIG9mIGlycV9hbGxvY19pbmZvCj4gICAgICAgIHg4Ni9tc2k6IENv
bnNvbGlkYXRlIEhQRVQgYWxsb2NhdGlvbgo+ICAgICAgICB4ODYvaW9hcGljOiBDb25zb2xpZGF0
ZSBJT0FQSUMgYWxsb2NhdGlvbgo+ICAgICAgICB4ODYvaXJxOiBDb25zb2xpZGF0ZSBETUFSIGly
cSBhbGxvY2F0aW9uCj4gICAgICAgIHg4Ni9pcnE6IENvbnNvbGlkYXRlIFVWIGRvbWFpbiBhbGxv
Y2F0aW9uCj4gICAgICAgIFBDSS9NU0k6IFJld29yayBwY2lfbXNpX2RvbWFpbl9jYWxjX2h3aXJx
KCkKPiAgICAgICAgeDg2L21zaTogQ29uc29saWRhdGUgTVNJIGFsbG9jYXRpb24KPiAgICAgICAg
eDg2L21zaTogVXNlIGdlbmVyaWMgTVNJIGRvbWFpbiBvcHMKPiAKPiAgICA2KSB4ODYgc3BlY2lm
aWMgY2xlYW51cHMgdG8gcmVtb3ZlIHRoZSBkZXBlbmRlbmN5IG9uIGFyY2hfKl9tc2lfaXJxcygp
Cj4gCj4gICAgICAgIHg4Ni9pcnE6IE1vdmUgYXBpY19wb3N0X2luaXQoKSBpbnZvY2F0aW9uIHRv
IG9uZSBwbGFjZQo+ICAgICAgICB4ODYvcGNpOiBSZWR1Y2RlICNpZmRlZmZlcnkgaW4gUENJIGlu
aXQgY29kZQo+ICAgICAgICB4ODYvaXJxOiBJbml0aWFsaXplIFBDSS9NU0kgZG9tYWluIGF0IFBD
SSBpbml0IHRpbWUKPiAgICAgICAgaXJxZG9tYWluL21zaTogUHJvdmlkZSBET01BSU5fQlVTX1ZN
RF9NU0kKPiAgICAgICAgUENJOiB2bWQ6IE1hcmsgVk1EIGlycWRvbWFpbiB3aXRoIERPTUFJTl9C
VVNfVk1EX01TSQo+ICAgICAgICBQQ0kvTVNJOiBQcm92aWRlIHBjaV9kZXZfaGFzX3NwZWNpYWxf
bXNpX2RvbWFpbigpIGhlbHBlcgo+ICAgICAgICB4ODYveGVuOiBNYWtlIHhlbl9tc2lfaW5pdCgp
IHN0YXRpYyBhbmQgcmVuYW1lIGl0IHRvIHhlbl9odm1fbXNpX2luaXQoKQo+ICAgICAgICB4ODYv
eGVuOiBSZXdvcmsgTVNJIHRlYXJkb3duCj4gICAgICAgIHg4Ni94ZW46IENvbnNvbGlkYXRlIFhF
Ti1NU0kgaW5pdAo+ICAgICAgICBpcnFkb21haW4vbXNpOiBBbGxvdyB0byBvdmVycmlkZSBtc2lf
ZG9tYWluX2FsbG9jL2ZyZWVfaXJxcygpCj4gICAgICAgIHg4Ni94ZW46IFdyYXAgWEVOIE1TSSBt
YW5hZ2VtZW50IGludG8gaXJxZG9tYWluCj4gICAgICAgIGlvbW1tL3Z0LWQ6IFN0b3JlIGlycSBk
b21haW4gaW4gc3RydWN0IGRldmljZQo+ICAgICAgICBpb21tbS9hbWQ6IFN0b3JlIGlycSBkb21h
aW4gaW4gc3RydWN0IGRldmljZQo+ICAgICAgICB4ODYvcGNpOiBTZXQgZGVmYXVsdCBpcnEgZG9t
YWluIGluIHBjaWJpb3NfYWRkX2RldmljZSgpCj4gICAgICAgIFBDSS9NU0k6IE1ha2UgYXJjaF8u
Kl9tc2lfaXJxW3NdIGZhbGxiYWNrcyBzZWxlY3RhYmxlCj4gICAgICAgIHg4Ni9pcnE6IENsZWFu
dXAgdGhlIGFyY2hfKl9tc2lfaXJxcygpIGxlZnRvdmVycwo+ICAgICAgICB4ODYvaXJxOiBNYWtl
IG1vc3QgTVNJIG9wcyBYRU4gcHJpdmF0ZQo+ICAgICAgICBpb21tdS92dC1kOiBSZW1vdmUgZG9t
YWluIHNlYXJjaCBmb3IgUENJL01TSVtYXQo+ICAgICAgICBpb21tdS9hbWQ6IFJlbW92ZSBkb21h
aW4gc2VhcmNoIGZvciBQQ0kvTVNJCj4gCj4gICAgNykgWDg2IHNwZWNpZmljIHByZXBhcmF0aW9u
IGZvciBkZXZpY2UgTVNJCj4gCj4gICAgICAgIHg4Ni9pcnE6IEFkZCBERVZfTVNJIGFsbG9jYXRp
b24gdHlwZQo+ICAgICAgICB4ODYvbXNpOiBSZW5hbWUgYW5kIHJld29yayBwY2lfbXNpX3ByZXBh
cmUoKSB0byBjb3ZlciBub24tUENJIE1TSQo+IAo+ICAgIDgpIEdlbmVyaWMgZGV2aWNlIE1TSSBp
bmZyYXN0cnVjdHVyZQo+ICAgICAgICBwbGF0Zm9ybS1tc2k6IFByb3ZpZGUgZGVmYXVsdCBpcnFf
Y2hpcDo6IEFjawo+ICAgICAgICBnZW5pcnEvcHJvYzogVGFrZSBidXNsb2NrIG9uIGFmZmluaXR5
IHdyaXRlCj4gICAgICAgIGdlbmlycS9tc2k6IFByb3ZpZGUgYW5kIHVzZSBtc2lfZG9tYWluX3Nl
dF9kZWZhdWx0X2luZm9fZmxhZ3MoKQo+ICAgICAgICBwbGF0Zm9ybS1tc2k6IEFkZCBkZXZpY2Ug
TVNJIGluZnJhc3RydWN0dXJlCj4gICAgICAgIGlycWRvbWFpbi9tc2k6IFByb3ZpZGUgbXNpX2Fs
bG9jL2ZyZWVfc3RvcmUoKSBjYWxsYmFja3MKPiAKPiAgICA5KSBQT0Mgb2YgSU1TIChJbnRlcnJ1
cHQgTWVzc2FnZSBTdG9ybSkgaXJxIGRvbWFpbiBhbmQgaXJxY2hpcAo+ICAgICAgIGltcGxlbWVu
dGF0aW9ucyBmb3IgYm90aCBkZXZpY2UgYXJyYXkgYW5kIHF1ZXVlIHN0b3JhZ2UuCj4gCj4gICAg
ICAgIGlycWNoaXA6IEFkZCBJTVMgKEludGVycnVwdCBNZXNzYWdlIFN0b3JtKSBkcml2ZXIgLSBO
T1QgRk9SIE1FUkdJTkcKPiAKPiBDaGFuZ2VzIHZzLiBWMToKPiAKPiAgICAgLSBBZGRyZXNzZWQg
dmFyaW91cyByZXZpZXcgY29tbWVudHMgYW5kIGFkZHJlc3NlZCB0aGUgMGRheSBmYWxsb3V0Lgo+
ICAgICAgIC0gQ29ycmVjdGVkIHRoZSBYRU4gbG9naWMgKErDvHJnZW4pCj4gICAgICAgLSBNYWtl
IHRoZSBhcmNoIGZhbGxiYWNrIGluIFBDSS9NU0kgb3B0LWluIG5vdCBvcHQtb3V0IChCam9ybikK
PiAKPiAgICAgLSBGaXhlZCB0aGUgY29tcG9zZSBNU0kgbWVzc2FnZSBpbmNvbnNpc3RlbmN5Cj4g
Cj4gICAgIC0gRW5zdXJlIHRoYXQgdGhlIG5lY2Vzc2FyeSBmbGFncyBhcmUgc2V0IGZvciBkZXZp
Y2UgU01JCj4gCj4gICAgIC0gTWFrZSB0aGUgaXJxIGJ1cyBsb2dpYyB3b3JrIGZvciBhZmZpbml0
eSBzZXR0aW5nIHRvIHByZXBhcmUKPiAgICAgICBzdXBwb3J0IGZvciBJTVMgc3RvcmFnZSBpbiBx
dWV1ZSBtZW1vcnkuIEl0IHR1cm5lZCBvdXQgdG8gYmUKPiAgICAgICBsZXNzIHNjYXJ5IHRoYW4g
SSBmZWFyZWQuCj4gCj4gICAgIC0gUmVtb3ZlIGxlZnRvdmVycyBpbiBpb21tdS9pbnRlbHxhbWQK
PiAKPiAgICAgLSBSZXdvcmtlZCB0aGUgSU1TIFBPQyBkcml2ZXIgdG8gY292ZXIgcXVldWUgc3Rv
cmFnZSBzbyBKYXNvbiBjYW4gaGF2ZSBhCj4gICAgICAgbG9vayB3aGV0aGVyIHRoYXQgZml0cyB0
aGUgbmVlZHMgb2YgTUxYIGRldmljZXMuCj4gCj4gVGhlIHdob2xlIGxvdCBpcyBhbHNvIGF2YWls
YWJsZSBmcm9tIGdpdDoKPiAKPiAgICAgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51
eC9rZXJuZWwvZ2l0L3RnbHgvZGV2ZWwuZ2l0IGRldmljZS1tc2kKPiAKPiBUaGlzIGhhcyBiZWVu
IHRlc3RlZCBvbiBJbnRlbC9BTUQvS1ZNIGJ1dCBsYWNrcyB0ZXN0aW5nIG9uOgo+IAo+ICAgICAg
LSBIWVBFUlYgKC1FTk9ERVYpCj4gICAgICAtIFZNRCBlbmFibGVkIHN5c3RlbXMgKC1FTk9ERVYp
Cj4gICAgICAtIFhFTiAoLUVOT0NMVUUpCj4gICAgICAtIElNUyAoLUVOT0RFVikKPiAKPiAgICAg
IC0gQW55IG5vbi1YODYgY29kZSB3aGljaCBtaWdodCBkZXBlbmQgb24gdGhlIGJyb2tlbiBjb21w
b3NlIE1TSSBtZXNzYWdlCj4gICAgICAgIGxvZ2ljLiBNYXJjIGV4Y3BlY3RzIG5vdCBtdWNoIGZh
bGxvdXQsIGJ1dCBhZ3JlZXMgdGhhdCB3ZSBuZWVkIHRvIGZpeAo+ICAgICAgICBpdCBhbnl3YXku
Cj4gCj4gIzEgLSAjMyBzaG91bGQgYmUgYXBwbGllZCB1bmNvbmRpdGlvbmFsbHkgZm9yIG9idmlv
dXMgcmVhc29ucwo+ICM0IC0gIzYgYXJlIHdvcnR3aGlsZSBjbGVhbnVwcyB3aGljaCBzaG91bGQg
YmUgZG9uZSBpbmRlcGVuZGVudCBvZiBkZXZpY2UgTVNJCj4gCj4gIzcgLSAjOCBsb29rIHByb21p
c2luZyB0byBjbGVhbnVwIHRoZSBwbGF0Zm9ybSBNU0kgaW1wbGVtZW50YXRpb24KPiAgICAgICAJ
aW5kZXBlbmRlbnQgb2YgIzgsIGJ1dCBJIG5laXRoZXIgaGFkIGN5Y2xlcyBub3IgdGhlIHN0b21h
Y2ggdG8KPiAgICAgICAJdGFja2xlIHRoYXQuCj4gCj4gIzkJaXMgb2J2aW91c2x5IGp1c3QgZm9y
IHRoZSBmb2xrcyBpbnRlcmVzdGVkIGluIElNUwo+IAo+IFRoYW5rcywKPiAKPiAJdGdseAo+IApf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWls
aW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
