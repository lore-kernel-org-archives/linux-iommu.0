Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62254C43334
	for <iommu@archiver.kernel.org>; Tue, 14 Jun 2022 07:48:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 12077400BB;
	Tue, 14 Jun 2022 07:48:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GdqZbOXx2PfB; Tue, 14 Jun 2022 07:48:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DC3F140983;
	Tue, 14 Jun 2022 07:48:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ACACBC0032;
	Tue, 14 Jun 2022 07:48:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4E54C002D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 07:48:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 84EC360B77
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 07:48:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L951uHbu1RKQ for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jun 2022 07:48:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D3A0260758
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 07:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655192893; x=1686728893;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=JjBfmY6jMAFiAGXZ4FBSDiUOib4iBu1wkpXYBDiQX3I=;
 b=l1yImkrgyiBrLc30UyC6RyA5vktHECnxi8Lkbs4vZn4fsWQHSa/DlW9m
 xv0dobdh1G4vPL0D7ndsF1W5RtYi/L8YzEGzIbNLiTLlfM3L8YfKrDTly
 6YWt/CXVtqvvNUVxojlrU3e8E5xS7rXcCzHiKWwquus6EAUlMwQm2VsAL
 Nz4JSxhuMARffIk/jHYiTVSYFiwzQ24AcRtkeMnIPgd/722Fxzi9JbFNg
 +cA57+AV/rogkvlNh7DR6GN2w+g8viZ9wZbzn0oyvNgLzk5lwQINOT5l8
 RGoWOweNDy64ARVbVI16QzUHwX9B73coGkojx6rC0Y6bg2MWwhV43wyVO Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="342507989"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; d="scan'208";a="342507989"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2022 00:48:13 -0700
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; d="scan'208";a="910848920"
Received: from gren5-mobl1.ccr.corp.intel.com (HELO [10.255.29.39])
 ([10.255.29.39])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2022 00:48:10 -0700
Message-ID: <3b69098e-ec9c-42b1-24cb-c0b7052e1998@linux.intel.com>
Date: Tue, 14 Jun 2022 15:48:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/1] iommu/vt-d: Add set_dev_pasid callbacks for default
 domain
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 "Raj, Ashok" <ashok.raj@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20220614034411.1634238-1-baolu.lu@linux.intel.com>
 <DM4PR11MB5278EBE8FA26185D91ACCD118CAA9@DM4PR11MB5278.namprd11.prod.outlook.com>
 <2d2a52db-70a8-788e-fedc-197789caa145@linux.intel.com>
 <BN9PR11MB5276DF2C87451A1164A995FB8CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <3e2e6ee7-984f-254e-7a3e-e32d6256c8f2@linux.intel.com>
 <BN9PR11MB5276C675063DAF7349D3966E8CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276C675063DAF7349D3966E8CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>
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

T24gMjAyMi82LzE0IDE1OjE5LCBUaWFuLCBLZXZpbiB3cm90ZToKPj4gRnJvbTogQmFvbHUgTHUg
PGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4KPj4gU2VudDogVHVlc2RheSwgSnVuZSAxNCwgMjAy
MiAyOjEzIFBNCj4+Cj4+IE9uIDIwMjIvNi8xNCAxMzozNiwgVGlhbiwgS2V2aW4gd3JvdGU6Cj4+
Pj4gRnJvbTogQmFvbHUgTHU8YmFvbHUubHVAbGludXguaW50ZWwuY29tPgo+Pj4+IFNlbnQ6IFR1
ZXNkYXksIEp1bmUgMTQsIDIwMjIgMTI6NDggUE0KPj4+Pgo+Pj4+IE9uIDIwMjIvNi8xNCAxMjow
MiwgVGlhbiwgS2V2aW4gd3JvdGU6Cj4+Pj4+PiBGcm9tOiBMdSBCYW9sdTxiYW9sdS5sdUBsaW51
eC5pbnRlbC5jb20+Cj4+Pj4+PiBTZW50OiBUdWVzZGF5LCBKdW5lIDE0LCAyMDIyIDExOjQ0IEFN
Cj4+Pj4+Pgo+Pj4+Pj4gVGhpcyBhbGxvd3MgdGhlIHVwcGVyIGxheWVycyB0byBzZXQgYSBkb21h
aW4gdG8gYSBQQVNJRCBvZiBhIGRldmljZQo+Pj4+Pj4gaWYgdGhlIFBBU0lEIGZlYXR1cmUgaXMg
c3VwcG9ydGVkIGJ5IHRoZSBJT01NVSBoYXJkd2FyZS4gVGhlIHR5cGljYWwKPj4+Pj4+IHVzZSBj
YXNlcyBhcmUsIGZvciBleGFtcGxlLCBrZXJuZWwgRE1BIHdpdGggUEFTSUQgYW5kIGhhcmR3YXJl
Cj4+Pj4+PiBhc3Npc3RlZCBtZWRpYXRlZCBkZXZpY2UgZHJpdmVycy4KPj4+Pj4+Cj4+Pj4+IHdo
eSBpcyBpdCBub3QgcGFydCBvZiB0aGUgc2VyaWVzIGZvciB0aG9zZSB1c2UgY2FzZXM/IFRoZXJl
IGlzIG5vIGNvbnN1bWVyCj4+Pj4+IG9mIGFkZGVkIGNhbGxiYWNrcyBpbiB0aGlzIHBhdGNoLi4u
Cj4+Pj4gSXQgY291bGQgYmUuIEkganVzdCB3YW50ZWQgdG8gbWFpbnRhaW4gdGhlIGludGVncml0
eSBvZiBJbnRlbCBJT01NVQo+Pj4+IGRyaXZlciBpbXBsZW1lbnRhdGlvbi4KPj4+IGJ1dCBsZXQn
cyBub3QgYWRkIGRlYWQgY29kZS4gYW5kIHRoaXMgcGF0Y2ggaXMgYWN0dWFsbHkgYSByaWdodCBz
dGVwCj4+PiBzaW1wbHkgZnJvbSBzZXRfZGV2X3Bhc2lkKCkgcC5vLnYgaGVuY2UgeW91IHNob3Vs
ZCBpbmNsdWRlIGluIGFueQo+Pj4gc2VyaWVzIHdoaWNoIGZpcnN0IHRyaWVzIHRvIHVzZSB0aGF0
IGludGVyZmFjZS4KPj4+Cj4+Cj4+IFllcywgdGhhdCdzIG15IGludGVudGlvbi4gSWYgaXQgcmV2
aWV3cyB3ZWxsLCB3ZSBjYW4gaW5jbHVkZSBpdCBpbiB0aGUKPj4gZHJpdmVyJ3MgaW1wbGVtZW50
YXRpb24uCj4+Cj4gCj4gVGhlbiB5b3Ugc2hvdWxkIG1ha2UgaXQgY2xlYXIgaW4gdGhlIGZpcnN0
IHBsYWNlLiBvdGhlcndpc2UgYSBwYXRjaAo+IGxpa2UgdGhpcyBpbXBsaWVzIGEgcmV2aWV3IGZv
ciBtZXJnZS4g8J+YigoKWWVhaCEgV2lsbCB1cGRhdGUgdGhpcyBpbiB0aGUgbmV4dCB2ZXJzaW9u
LgoKQmVzdCByZWdhcmRzLApiYW9sdQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vaW9tbXU=
