Return-Path: <SRS0=1/OX=IR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5533C433DB
	for <iommu@archiver.kernel.org>; Fri, 19 Mar 2021 00:24:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AF6560201
	for <iommu@archiver.kernel.org>; Fri, 19 Mar 2021 00:24:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AF6560201
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2DA204E804;
	Fri, 19 Mar 2021 00:24:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MO-Z800ge_5M; Fri, 19 Mar 2021 00:24:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id B38E64E59F;
	Fri, 19 Mar 2021 00:24:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77E65C000A;
	Fri, 19 Mar 2021 00:24:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 952E6C0001
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 00:24:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6AFA14E59F
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 00:24:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w1NnQBCyPrZh for <iommu@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 00:24:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 75DE24E578
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 00:24:51 +0000 (UTC)
IronPort-SDR: pw8RhBDzfpy8Y9jtE+/Qda8eCdkZfsW2kyNQkxShpF7xTKC6dCqwi30iDbVFqr2NpnJLci3ADr
 ArCc0zLotXYA==
X-IronPort-AV: E=McAfee;i="6000,8403,9927"; a="176928665"
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; d="scan'208";a="176928665"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2021 17:24:50 -0700
IronPort-SDR: hIfyJd7NfvDTTF3A6e+o+p8zQyLtBTT4BdwNItraxk8PSUnAQQhxJLUXsdljRCukjriW1W6az0
 5x0Yw9TM75tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; d="scan'208";a="434067658"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 18 Mar 2021 17:24:47 -0700
Subject: =?UTF-8?Q?Re=3a_A_problem_of_Intel_IOMMU_hardware_=ef=bc=9f?=
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)"
 <longpeng2@huawei.com>, Nadav Amit <nadav.amit@gmail.com>
References: <670baaf8-4ff8-4e84-4be3-030b95ab5a5e@huawei.com>
 <FB4E11A5-84D4-4DAF-889E-FAA1BCD2E66F@gmail.com>
 <6a218e7fe42d41489d02f0b4e3ad2756@huawei.com>
 <98DB71EF-FF98-4509-85EC-26FF50825A58@gmail.com>
 <4d1c3bc0418e48b1b9d44799d65ea375@huawei.com>
 <MWHPR11MB18860801196A9319EBD96AF68C699@MWHPR11MB1886.namprd11.prod.outlook.com>
 <d7bb4ab26b8542c698926b7a0a3fc12c@huawei.com>
 <MWHPR11MB18861A144C085677931922018C699@MWHPR11MB1886.namprd11.prod.outlook.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <aa8b989d-458b-92a3-627b-0a88e430934d@linux.intel.com>
Date: Fri, 19 Mar 2021 08:15:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB18861A144C085677931922018C699@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Language: en-US
Cc: chenjiashang <chenjiashang@huawei.com>,
 David Woodhouse <dwmw2@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 "will@kernel.org" <will@kernel.org>
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

T24gMy8xOC8yMSA0OjU2IFBNLCBUaWFuLCBLZXZpbiB3cm90ZToKPj4gRnJvbTogTG9uZ3Blbmcg
KE1pa2UsIENsb3VkIEluZnJhc3RydWN0dXJlIFNlcnZpY2UgUHJvZHVjdCBEZXB0LikKPj4gPGxv
bmdwZW5nMkBodWF3ZWkuY29tPgo+Pgo+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPj4+
IEZyb206IFRpYW4sIEtldmluIFttYWlsdG86a2V2aW4udGlhbkBpbnRlbC5jb21dCj4+PiBTZW50
OiBUaHVyc2RheSwgTWFyY2ggMTgsIDIwMjEgNDoyNyBQTQo+Pj4gVG86IExvbmdwZW5nIChNaWtl
LCBDbG91ZCBJbmZyYXN0cnVjdHVyZSBTZXJ2aWNlIFByb2R1Y3QgRGVwdC4pCj4+PiA8bG9uZ3Bl
bmcyQGh1YXdlaS5jb20+OyBOYWRhdiBBbWl0IDxuYWRhdi5hbWl0QGdtYWlsLmNvbT4KPj4+IENj
OiBjaGVuamlhc2hhbmcgPGNoZW5qaWFzaGFuZ0BodWF3ZWkuY29tPjsgRGF2aWQgV29vZGhvdXNl
Cj4+PiA8ZHdtdzJAaW5mcmFkZWFkLm9yZz47IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnOyBMS01MCj4+PiA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IGFsZXgud2lsbGlh
bXNvbkByZWRoYXQuY29tOyBHb25nbGVpCj4+IChBcmVpKQo+Pj4gPGFyZWkuZ29uZ2xlaUBodWF3
ZWkuY29tPjsgd2lsbEBrZXJuZWwub3JnCj4+PiBTdWJqZWN0OiBSRTogQSBwcm9ibGVtIG9mIElu
dGVsIElPTU1VIGhhcmR3YXJlIO+8nwo+Pj4KPj4+PiBGcm9tOiBpb21tdSA8aW9tbXUtYm91bmNl
c0BsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZz4gT24gQmVoYWxmIE9mCj4+Pj4gTG9uZ3Blbmcg
KE1pa2UsIENsb3VkIEluZnJhc3RydWN0dXJlIFNlcnZpY2UgUHJvZHVjdCBEZXB0LikKPj4+Pgo+
Pj4+PiAyLiBDb25zaWRlciBlbnN1cmluZyB0aGF0IHRoZSBwcm9ibGVtIGlzIG5vdCBzb21laG93
IHJlbGF0ZWQgdG8KPj4+Pj4gcXVldWVkIGludmFsaWRhdGlvbnMuIFRyeSB0byB1c2UgX19pb21t
dV9mbHVzaF9pb3RsYigpIGluc3RlYWQgb2YKPj4+IHFpX2ZsdXNoX2lvdGxiKCkuCj4+Pj4+Cj4+
Pj4KPj4+PiBJIHRyaWVkIHRvIGZvcmNlIHRvIHVzZSBfX2lvbW11X2ZsdXNoX2lvdGxiKCksIGJ1
dCBtYXliZSBzb21ldGhpbmcKPj4+PiB3cm9uZywgdGhlIHN5c3RlbSBjcmFzaGVkLCBzbyBJIHBy
ZWZlciB0byBsb3dlciB0aGUgcHJpb3JpdHkgb2YgdGhpcwo+PiBvcGVyYXRpb24uCj4+Pj4KPj4+
Cj4+PiBUaGUgVlQtZCBzcGVjIGNsZWFybHkgc2F5cyB0aGF0IHJlZ2lzdGVyLWJhc2VkIGludmFs
aWRhdGlvbiBjYW4gYmUgdXNlZCBvbmx5Cj4+IHdoZW4KPj4+IHF1ZXVlZC1pbnZhbGlkYXRpb25z
IGFyZSBub3QgZW5hYmxlZC4gSW50ZWwtSU9NTVUgZHJpdmVyIGRvZXNuJ3QgcHJvdmlkZQo+PiBh
bgo+Pj4gb3B0aW9uIHRvIGRpc2FibGUgcXVldWVkLWludmFsaWRhdGlvbiB0aG91Z2gsIHdoZW4g
dGhlIGhhcmR3YXJlIGlzCj4+IGNhcGFibGUuIElmIHlvdQo+Pj4gcmVhbGx5IHdhbnQgdG8gdHJ5
LCB0d2VhayB0aGUgY29kZSBpbiBpbnRlbF9pb21tdV9pbml0X3FpLgo+Pj4KPj4KPj4gSGkgS2V2
aW4sCj4+Cj4+IFRoYW5rcyB0byBwb2ludCBvdXQgdGhpcy4gRG8geW91IGhhdmUgYW55IGlkZWFz
IGFib3V0IHRoaXMgcHJvYmxlbSA/IEkgdHJpZWQKPj4gdG8gZGVzY3JpcHQgdGhlIHByb2JsZW0g
bXVjaCBjbGVhciBpbiBteSByZXBseSB0byBBbGV4LCBob3BlIHlvdSBjb3VsZCBoYXZlCj4+IGEg
bG9vayBpZiB5b3UncmUgaW50ZXJlc3RlZC4KPj4KPiAKPiBidHcgSSBzYXcgeW91IHVzZWQgNC4x
OCBrZXJuZWwgaW4gdGhpcyB0ZXN0LiBXaGF0IGFib3V0IGxhdGVzdCBrZXJuZWw/Cj4gCj4gQWxz
byBvbmUgd2F5IHRvIHNlcGFyYXRlIHN3L2h3IGJ1ZyBpcyB0byB0cmFjZSB0aGUgbG93IGxldmVs
IGludGVyZmFjZSAoZS5nLiwKPiBxaV9mbHVzaF9pb3RsYikgd2hpY2ggYWN0dWFsbHkgc2VuZHMg
aW52YWxpZGF0aW9uIGRlc2NyaXB0b3JzIHRvIHRoZSBJT01NVQo+IGhhcmR3YXJlLiBDaGVjayB0
aGUgd2luZG93IGJldHdlZW4gYikgYW5kIGMpIGFuZCBzZWUgd2hldGhlciB0aGUKPiBzb2Z0d2Fy
ZSBkb2VzIHRoZSByaWdodCB0aGluZyBhcyBleHBlY3RlZCB0aGVyZS4KClllcy4gSXQncyBiZXR0
ZXIgaWYgd2UgY2FuIHJlcHJvZHVjZSB0aGlzIHdpdGggdGhlIGxhdGVzdCBrZXJuZWwgd2hpY2gK
aGFzIGRlYnVnZnMgZmlsZXMgdG8gZXhwb3NlIHBhZ2UgdGFibGVzIGFuZCB0aGUgaW52YWxpZGF0
aW9uIHF1ZXVlcyBldGMuCgpCZXN0IHJlZ2FyZHMsCmJhb2x1Cl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby9pb21tdQ==
