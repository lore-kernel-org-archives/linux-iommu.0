Return-Path: <SRS0=l9dJ=DG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59296C47423
	for <iommu@archiver.kernel.org>; Tue, 29 Sep 2020 23:03:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C51BF21924
	for <iommu@archiver.kernel.org>; Tue, 29 Sep 2020 23:03:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C51BF21924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2410F85F32;
	Tue, 29 Sep 2020 23:03:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DeA3eXdCODby; Tue, 29 Sep 2020 23:03:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B812685E91;
	Tue, 29 Sep 2020 23:03:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5208C0889;
	Tue, 29 Sep 2020 23:03:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDADEC0051
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 23:03:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B76C3203B4
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 23:03:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lY61k5AUiBOm for <iommu@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 23:03:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by silver.osuosl.org (Postfix) with ESMTPS id 300B420399
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 23:03:39 +0000 (UTC)
IronPort-SDR: 3Q3FhExhhOTlPfbijlt5T8npRc8Z8b9kSnKCcS9qrYx7LEXpYfakGBF26gQqxBUZ1tJv224T2C
 VXxMyX0igYsA==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="159647229"
X-IronPort-AV: E=Sophos;i="5.77,320,1596524400"; d="scan'208";a="159647229"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2020 16:03:38 -0700
IronPort-SDR: /EvObaL5A0efO+V3yWJ7n6DgRY4Jfn26hfbu0C8T5O1RjfwKjT7pd78ZVG7iKsEJ0UgybKhTke
 epnaRxRgrjvA==
X-IronPort-AV: E=Sophos;i="5.77,320,1596524400"; d="scan'208";a="415545172"
Received: from meghadey-mobl1.amr.corp.intel.com (HELO [10.209.163.104])
 ([10.209.163.104])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2020 16:03:36 -0700
Subject: Re: [patch V2 00/46] x86, PCI, XEN, genirq ...: Prepare for device MSI
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
References: <20200826111628.794979401@linutronix.de>
From: "Dey, Megha" <megha.dey@intel.com>
Message-ID: <10b5d933-f104-7699-341a-0afb16640d54@intel.com>
Date: Tue, 29 Sep 2020 16:03:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200826111628.794979401@linutronix.de>
Content-Language: en-US
Cc: Dimitri Sivanich <sivanich@hpe.com>, linux-hyperv@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>, linux-pci@vger.kernel.org,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Dan Williams <dan.j.williams@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, Baolu Lu <baolu.lu@intel.com>,
 Marc Zyngier <maz@kernel.org>, x86@kernel.org,
 Jason Gunthorpe <jgg@mellanox.com>, xen-devel@lists.xenproject.org,
 ravi.v.shankar@intel.com, Kevin Tian <kevin.tian@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, dave.jiang@intel.com,
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

SGkgVGhvbWFzLAoKT24gOC8yNi8yMDIwIDQ6MTYgQU0sIFRob21hcyBHbGVpeG5lciB3cm90ZToK
PiBUaGlzIGlzIHRoZSBzZWNvbmQgdmVyc2lvbiBvZiBwcm92aWRpbmcgYSBiYXNlIHRvIHN1cHBv
cnQgZGV2aWNlIE1TSSAobm9uCj4gUENJIGJhc2VkKSBhbmQgb24gdG9wIG9mIHRoYXQgc3VwcG9y
dCBmb3IgSU1TIChJbnRlcnJ1cHQgTWVzc2FnZSBTdG9ybSkKPiBiYXNlZCBkZXZpY2VzIGluIGEg
aGFsZndheXMgYXJjaGl0ZWN0dXJlIGluZGVwZW5kZW50IHdheS4KPgo+IFRoZSBmaXJzdCB2ZXJz
aW9uIGNhbiBiZSBmb3VuZCBoZXJlOgo+Cj4gICAgICBodHRwczovL2xvcmUua2VybmVsLm9yZy9y
LzIwMjAwODIxMDAyNDI0LjExOTQ5MjIzMUBsaW51dHJvbml4LmRlCj4KPiBJdCdzIHN0aWxsIGEg
bWl4ZWQgYmFnIG9mIGJ1ZyBmaXhlcywgY2xlYW51cHMgYW5kIGdlbmVyYWwgaW1wcm92ZW1lbnRz
Cj4gd2hpY2ggYXJlIHdvcnRod2hpbGUgaW5kZXBlbmRlbnQgb2YgZGV2aWNlIE1TSS4KPgo+IFRo
ZXJlIGFyZSBxdWl0ZSBhIGJ1bmNoIG9mIGlzc3VlcyB0byBzb2x2ZToKPgo+ICAgIC0gWDg2IGRv
ZXMgbm90IHVzZSB0aGUgZGV2aWNlOjptc2lfZG9tYWluIHBvaW50ZXIgZm9yIGhpc3RvcmljYWwg
cmVhc29ucwo+ICAgICAgYW5kIGR1ZSB0byBYRU4sIHdoaWNoIG1ha2VzIGl0IGltcG9zc2libGUg
dG8gY3JlYXRlIGFuIGFyY2hpdGVjdHVyZQo+ICAgICAgYWdub3N0aWMgZGV2aWNlIE1TSSBpbmZy
YXN0cnVjdHVyZS4KPgo+ICAgIC0gWDg2IGhhcyBpdCdzIG93biBtc2lfYWxsb2NfaW5mbyBkYXRh
IHR5cGUgd2hpY2ggaXMgcG9pbnRsZXNzbHkKPiAgICAgIGRpZmZlcmVudCBmcm9tIHRoZSBnZW5l
cmljIHZlcnNpb24gYW5kIGRvZXMgbm90IGFsbG93IHRvIHNoYXJlIGNvZGUuCj4KPiAgICAtIFRo
ZSBsb2dpYyBvZiBjb21wb3NpbmcgTVNJIG1lc3NhZ2VzIGluIGFuIGhpZXJhcmNoeSBpcyBidXN0
ZWQgYXQgdGhlCj4gICAgICBjb3JlIGxldmVsIGFuZCBvZiBjb3Vyc2Ugc29tZSAoeDg2KSBkcml2
ZXJzIGRlcGVuZCBvbiB0aGF0Lgo+Cj4gICAgLSBBIGZldyBtaW5vciBzaG9ydGNvbWluZ3MgYXMg
dXN1YWwKPgo+IFRoaXMgc2VyaWVzIGFkZHJlc3NlcyB0aGF0IGluIHNldmVyYWwgc3RlcHM6Cj4K
PiAgIDEpIEFjY2lkZW50YWwgYnVnIGZpeGVzCj4KPiAgICAgICAgaW9tbXUvYW1kOiBQcmV2ZW50
IE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZQo+Cj4gICAyKSBKYW5pdG9yaW5nCj4KPiAgICAgICAg
eDg2L2luaXQ6IFJlbW92ZSB1bnVzZWQgaW5pdCBvcHMKPiAgICAgICAgUENJOiB2bWQ6IERvbnQg
YWJ1c2UgdmVjdG9yIGlycW9tYWluIGFzIHBhcmVudAo+ICAgICAgICB4ODYvbXNpOiBSZW1vdmUg
cG9pbnRsZXNzIHZjcHVfYWZmaW5pdHkgY2FsbGJhY2sKPgo+ICAgMykgU2FuaXRpemluZyB0aGUg
Y29tcG9zaXRpb24gb2YgTVNJIG1lc3NhZ2VzIGluIGEgaGllcmFyY2h5Cj4gICAKPiAgICAgICAg
Z2VuaXJxL2NoaXA6IFVzZSB0aGUgZmlyc3QgY2hpcCBpbiBpcnFfY2hpcF9jb21wb3NlX21zaV9t
c2coKQo+ICAgICAgICB4ODYvbXNpOiBNb3ZlIGNvbXBvc2UgbWVzc2FnZSBjYWxsYmFjayB3aGVy
ZSBpdCBiZWxvbmdzCj4KPiAgIDQpIFNpbXBsaWZpY2F0aW9uIG9mIHRoZSB4ODYgc3BlY2lmaWMg
aW50ZXJydXB0IGFsbG9jYXRpb24gbWVjaGFuaXNtCj4KPiAgICAgICAgeDg2L2lycTogUmVuYW1l
IFg4Nl9JUlFfQUxMT0NfVFlQRV9NU0kqIHRvIHJlZmxlY3QgUENJIGRlcGVuZGVuY3kKPiAgICAg
ICAgeDg2L2lycTogQWRkIGFsbG9jYXRpb24gdHlwZSBmb3IgcGFyZW50IGRvbWFpbiByZXRyaWV2
YWwKPiAgICAgICAgaW9tbXUvdnQtZDogQ29uc29saWRhdGUgaXJxIGRvbWFpbiBnZXR0ZXIKPiAg
ICAgICAgaW9tbXUvYW1kOiBDb25zb2xpZGF0ZSBpcnEgZG9tYWluIGdldHRlcgo+ICAgICAgICBp
b21tdS9pcnFfcmVtYXBwaW5nOiBDb25zb2xpZGF0ZSBpcnEgZG9tYWluIGxvb2t1cAo+Cj4gICA1
KSBDb25zb2xpZGF0aW9uIG9mIHRoZSBYODYgc3BlY2lmaWMgaW50ZXJydXB0IGFsbG9jYXRpb24g
bWVjaGFuaXNtIHRvIGJlIGFzIGNsb3NlCj4gICAgICBhcyBwb3NzaWJsZSB0byB0aGUgZ2VuZXJp
YyBNU0kgYWxsb2NhdGlvbiBtZWNoYW5pc20gd2hpY2ggYWxsb3dzIHRvIGdldCByaWQKPiAgICAg
IG9mIHF1aXRlIGEgYnVuY2ggb2YgeDg2J2lzbXMgd2hpY2ggYXJlIHBvaW50bGVzcwo+Cj4gICAg
ICAgIHg4Ni9pcnE6IFByZXBhcmUgY29uc29saWRhdGlvbiBvZiBpcnFfYWxsb2NfaW5mbwo+ICAg
ICAgICB4ODYvbXNpOiBDb25zb2xpZGF0ZSBIUEVUIGFsbG9jYXRpb24KPiAgICAgICAgeDg2L2lv
YXBpYzogQ29uc29saWRhdGUgSU9BUElDIGFsbG9jYXRpb24KPiAgICAgICAgeDg2L2lycTogQ29u
c29saWRhdGUgRE1BUiBpcnEgYWxsb2NhdGlvbgo+ICAgICAgICB4ODYvaXJxOiBDb25zb2xpZGF0
ZSBVViBkb21haW4gYWxsb2NhdGlvbgo+ICAgICAgICBQQ0kvTVNJOiBSZXdvcmsgcGNpX21zaV9k
b21haW5fY2FsY19od2lycSgpCj4gICAgICAgIHg4Ni9tc2k6IENvbnNvbGlkYXRlIE1TSSBhbGxv
Y2F0aW9uCj4gICAgICAgIHg4Ni9tc2k6IFVzZSBnZW5lcmljIE1TSSBkb21haW4gb3BzCj4KPiAg
ICA2KSB4ODYgc3BlY2lmaWMgY2xlYW51cHMgdG8gcmVtb3ZlIHRoZSBkZXBlbmRlbmN5IG9uIGFy
Y2hfKl9tc2lfaXJxcygpCj4KPiAgICAgICAgeDg2L2lycTogTW92ZSBhcGljX3Bvc3RfaW5pdCgp
IGludm9jYXRpb24gdG8gb25lIHBsYWNlCj4gICAgICAgIHg4Ni9wY2k6IFJlZHVjZGUgI2lmZGVm
ZmVyeSBpbiBQQ0kgaW5pdCBjb2RlCj4gICAgICAgIHg4Ni9pcnE6IEluaXRpYWxpemUgUENJL01T
SSBkb21haW4gYXQgUENJIGluaXQgdGltZQo+ICAgICAgICBpcnFkb21haW4vbXNpOiBQcm92aWRl
IERPTUFJTl9CVVNfVk1EX01TSQo+ICAgICAgICBQQ0k6IHZtZDogTWFyayBWTUQgaXJxZG9tYWlu
IHdpdGggRE9NQUlOX0JVU19WTURfTVNJCj4gICAgICAgIFBDSS9NU0k6IFByb3ZpZGUgcGNpX2Rl
dl9oYXNfc3BlY2lhbF9tc2lfZG9tYWluKCkgaGVscGVyCj4gICAgICAgIHg4Ni94ZW46IE1ha2Ug
eGVuX21zaV9pbml0KCkgc3RhdGljIGFuZCByZW5hbWUgaXQgdG8geGVuX2h2bV9tc2lfaW5pdCgp
Cj4gICAgICAgIHg4Ni94ZW46IFJld29yayBNU0kgdGVhcmRvd24KPiAgICAgICAgeDg2L3hlbjog
Q29uc29saWRhdGUgWEVOLU1TSSBpbml0Cj4gICAgICAgIGlycWRvbWFpbi9tc2k6IEFsbG93IHRv
IG92ZXJyaWRlIG1zaV9kb21haW5fYWxsb2MvZnJlZV9pcnFzKCkKPiAgICAgICAgeDg2L3hlbjog
V3JhcCBYRU4gTVNJIG1hbmFnZW1lbnQgaW50byBpcnFkb21haW4KPiAgICAgICAgaW9tbW0vdnQt
ZDogU3RvcmUgaXJxIGRvbWFpbiBpbiBzdHJ1Y3QgZGV2aWNlCj4gICAgICAgIGlvbW1tL2FtZDog
U3RvcmUgaXJxIGRvbWFpbiBpbiBzdHJ1Y3QgZGV2aWNlCj4gICAgICAgIHg4Ni9wY2k6IFNldCBk
ZWZhdWx0IGlycSBkb21haW4gaW4gcGNpYmlvc19hZGRfZGV2aWNlKCkKPiAgICAgICAgUENJL01T
STogTWFrZSBhcmNoXy4qX21zaV9pcnFbc10gZmFsbGJhY2tzIHNlbGVjdGFibGUKPiAgICAgICAg
eDg2L2lycTogQ2xlYW51cCB0aGUgYXJjaF8qX21zaV9pcnFzKCkgbGVmdG92ZXJzCj4gICAgICAg
IHg4Ni9pcnE6IE1ha2UgbW9zdCBNU0kgb3BzIFhFTiBwcml2YXRlCj4gICAgICAgIGlvbW11L3Z0
LWQ6IFJlbW92ZSBkb21haW4gc2VhcmNoIGZvciBQQ0kvTVNJW1hdCj4gICAgICAgIGlvbW11L2Ft
ZDogUmVtb3ZlIGRvbWFpbiBzZWFyY2ggZm9yIFBDSS9NU0kKPgo+ICAgIDcpIFg4NiBzcGVjaWZp
YyBwcmVwYXJhdGlvbiBmb3IgZGV2aWNlIE1TSQo+Cj4gICAgICAgIHg4Ni9pcnE6IEFkZCBERVZf
TVNJIGFsbG9jYXRpb24gdHlwZQo+ICAgICAgICB4ODYvbXNpOiBSZW5hbWUgYW5kIHJld29yayBw
Y2lfbXNpX3ByZXBhcmUoKSB0byBjb3ZlciBub24tUENJIE1TSQo+Cj4gICAgOCkgR2VuZXJpYyBk
ZXZpY2UgTVNJIGluZnJhc3RydWN0dXJlCj4gICAgICAgIHBsYXRmb3JtLW1zaTogUHJvdmlkZSBk
ZWZhdWx0IGlycV9jaGlwOjogQWNrCj4gICAgICAgIGdlbmlycS9wcm9jOiBUYWtlIGJ1c2xvY2sg
b24gYWZmaW5pdHkgd3JpdGUKPiAgICAgICAgZ2VuaXJxL21zaTogUHJvdmlkZSBhbmQgdXNlIG1z
aV9kb21haW5fc2V0X2RlZmF1bHRfaW5mb19mbGFncygpCj4gICAgICAgIHBsYXRmb3JtLW1zaTog
QWRkIGRldmljZSBNU0kgaW5mcmFzdHJ1Y3R1cmUKPiAgICAgICAgaXJxZG9tYWluL21zaTogUHJv
dmlkZSBtc2lfYWxsb2MvZnJlZV9zdG9yZSgpIGNhbGxiYWNrcwo+Cj4gICAgOSkgUE9DIG9mIElN
UyAoSW50ZXJydXB0IE1lc3NhZ2UgU3Rvcm0pIGlycSBkb21haW4gYW5kIGlycWNoaXAKPiAgICAg
ICBpbXBsZW1lbnRhdGlvbnMgZm9yIGJvdGggZGV2aWNlIGFycmF5IGFuZCBxdWV1ZSBzdG9yYWdl
Lgo+Cj4gICAgICAgIGlycWNoaXA6IEFkZCBJTVMgKEludGVycnVwdCBNZXNzYWdlIFN0b3JtKSBk
cml2ZXIgLSBOT1QgRk9SIE1FUkdJTkcKPgo+IENoYW5nZXMgdnMuIFYxOgo+Cj4gICAgIC0gQWRk
cmVzc2VkIHZhcmlvdXMgcmV2aWV3IGNvbW1lbnRzIGFuZCBhZGRyZXNzZWQgdGhlIDBkYXkgZmFs
bG91dC4KPiAgICAgICAtIENvcnJlY3RlZCB0aGUgWEVOIGxvZ2ljIChKw7xyZ2VuKQo+ICAgICAg
IC0gTWFrZSB0aGUgYXJjaCBmYWxsYmFjayBpbiBQQ0kvTVNJIG9wdC1pbiBub3Qgb3B0LW91dCAo
Qmpvcm4pCj4KPiAgICAgLSBGaXhlZCB0aGUgY29tcG9zZSBNU0kgbWVzc2FnZSBpbmNvbnNpc3Rl
bmN5Cj4KPiAgICAgLSBFbnN1cmUgdGhhdCB0aGUgbmVjZXNzYXJ5IGZsYWdzIGFyZSBzZXQgZm9y
IGRldmljZSBTTUkKPgo+ICAgICAtIE1ha2UgdGhlIGlycSBidXMgbG9naWMgd29yayBmb3IgYWZm
aW5pdHkgc2V0dGluZyB0byBwcmVwYXJlCj4gICAgICAgc3VwcG9ydCBmb3IgSU1TIHN0b3JhZ2Ug
aW4gcXVldWUgbWVtb3J5LiBJdCB0dXJuZWQgb3V0IHRvIGJlCj4gICAgICAgbGVzcyBzY2FyeSB0
aGFuIEkgZmVhcmVkLgo+Cj4gICAgIC0gUmVtb3ZlIGxlZnRvdmVycyBpbiBpb21tdS9pbnRlbHxh
bWQKPgo+ICAgICAtIFJld29ya2VkIHRoZSBJTVMgUE9DIGRyaXZlciB0byBjb3ZlciBxdWV1ZSBz
dG9yYWdlIHNvIEphc29uIGNhbiBoYXZlIGEKPiAgICAgICBsb29rIHdoZXRoZXIgdGhhdCBmaXRz
IHRoZSBuZWVkcyBvZiBNTFggZGV2aWNlcy4KPgo+IFRoZSB3aG9sZSBsb3QgaXMgYWxzbyBhdmFp
bGFibGUgZnJvbSBnaXQ6Cj4KPiAgICAgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51
eC9rZXJuZWwvZ2l0L3RnbHgvZGV2ZWwuZ2l0IGRldmljZS1tc2kKPgo+IFRoaXMgaGFzIGJlZW4g
dGVzdGVkIG9uIEludGVsL0FNRC9LVk0gYnV0IGxhY2tzIHRlc3Rpbmcgb246Cj4KPiAgICAgIC0g
SFlQRVJWICgtRU5PREVWKQo+ICAgICAgLSBWTUQgZW5hYmxlZCBzeXN0ZW1zICgtRU5PREVWKQo+
ICAgICAgLSBYRU4gKC1FTk9DTFVFKQo+ICAgICAgLSBJTVMgKC1FTk9ERVYpCj4KPiAgICAgIC0g
QW55IG5vbi1YODYgY29kZSB3aGljaCBtaWdodCBkZXBlbmQgb24gdGhlIGJyb2tlbiBjb21wb3Nl
IE1TSSBtZXNzYWdlCj4gICAgICAgIGxvZ2ljLiBNYXJjIGV4Y3BlY3RzIG5vdCBtdWNoIGZhbGxv
dXQsIGJ1dCBhZ3JlZXMgdGhhdCB3ZSBuZWVkIHRvIGZpeAo+ICAgICAgICBpdCBhbnl3YXkuCj4K
PiAjMSAtICMzIHNob3VsZCBiZSBhcHBsaWVkIHVuY29uZGl0aW9uYWxseSBmb3Igb2J2aW91cyBy
ZWFzb25zCj4gIzQgLSAjNiBhcmUgd29ydHdoaWxlIGNsZWFudXBzIHdoaWNoIHNob3VsZCBiZSBk
b25lIGluZGVwZW5kZW50IG9mIGRldmljZSBNU0kKPgo+ICM3IC0gIzggbG9vayBwcm9taXNpbmcg
dG8gY2xlYW51cCB0aGUgcGxhdGZvcm0gTVNJIGltcGxlbWVudGF0aW9uCj4gICAgICAgCWluZGVw
ZW5kZW50IG9mICM4LCBidXQgSSBuZWl0aGVyIGhhZCBjeWNsZXMgbm9yIHRoZSBzdG9tYWNoIHRv
Cj4gICAgICAgCXRhY2tsZSB0aGF0Lgo+Cj4gIzkJaXMgb2J2aW91c2x5IGp1c3QgZm9yIHRoZSBm
b2xrcyBpbnRlcmVzdGVkIGluIElNUwo+Cj4gVGhhbmtzLAo+Cj4gCXRnbHgKCkkgc2VlIHRoYXQg
dGhlIHRpcCB0cmVlIChhcyBvZiA5LzI5KSBoYXMgbW9zdCBvZiB0aGVzZSBwYXRjaGVzIGJ1dCAK
bm90aWNlIHRoYXQgdGhlIERFVl9NU0kgcmVsYXRlZCBwYXRjaGVzCgpoYXZlbid0IG1hZGUgaXQu
IEkgaGF2ZSB0ZXN0ZWQgdGhlIHRpcCB0cmVlKHg4Ni9pcnEgYnJhbmNoKSB3aXRoIHlvdXIgCkRF
Vl9NU0kgaW5mcmEgcGF0Y2hlcyBhbmQgb3VyIElNUwoKcGF0Y2hlcyB3aXRoIHRoZSBJRFhEIGRy
aXZlciBhbmQgd2FzIHdvbmRlcmluZyBpZiB3ZSBzaG91bGQgcHVzaCBvdXQgCnRob3NlIHBhdGNo
ZXMgYXMgcGFydCBvZiBvdXIgcGF0Y2hzZXQ/CgpUaGFua3MsCgpNZWdoYQoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0Cmlv
bW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
