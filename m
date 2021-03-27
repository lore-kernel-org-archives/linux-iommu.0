Return-Path: <SRS0=Y/a2=IZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12227C433DB
	for <iommu@archiver.kernel.org>; Sat, 27 Mar 2021 05:37:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88FD461A0D
	for <iommu@archiver.kernel.org>; Sat, 27 Mar 2021 05:37:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88FD461A0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4114140296;
	Sat, 27 Mar 2021 05:37:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bxgNV9ppTOaU; Sat, 27 Mar 2021 05:37:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 25A654028B;
	Sat, 27 Mar 2021 05:37:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3FFDC000C;
	Sat, 27 Mar 2021 05:37:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59D9BC000A
 for <iommu@lists.linux-foundation.org>; Sat, 27 Mar 2021 05:37:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4EEC74028F
 for <iommu@lists.linux-foundation.org>; Sat, 27 Mar 2021 05:37:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rz3ZQ9a2-408 for <iommu@lists.linux-foundation.org>;
 Sat, 27 Mar 2021 05:37:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9135E4028B
 for <iommu@lists.linux-foundation.org>; Sat, 27 Mar 2021 05:37:30 +0000 (UTC)
IronPort-SDR: glHwIjR+0DrKxnvVD3of+M1Mxv7PKjMuY0OjpwKjcp+KNvdXUEFvXyXq9AHmKGwmOh2nfcXRgK
 IMOVfz90jiCw==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="170651593"
X-IronPort-AV: E=Sophos;i="5.81,282,1610438400"; d="scan'208";a="170651593"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2021 22:37:27 -0700
IronPort-SDR: bgF6J/eTFtCsGnhomTqp8fKEOdrPLkhq+Gv4zxNugwHsoY99GhSq49Lz7y9Tvi3KwXbRYRNjDD
 9Z+7P4gvWVHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,282,1610438400"; d="scan'208";a="437134133"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 26 Mar 2021 22:37:24 -0700
Subject: =?UTF-8?Q?Re=3a_A_problem_of_Intel_IOMMU_hardware_=ef=bc=9f?=
To: Nadav Amit <nadav.amit@gmail.com>
References: <670baaf8-4ff8-4e84-4be3-030b95ab5a5e@huawei.com>
 <FB4E11A5-84D4-4DAF-889E-FAA1BCD2E66F@gmail.com>
 <6a218e7fe42d41489d02f0b4e3ad2756@huawei.com>
 <98DB71EF-FF98-4509-85EC-26FF50825A58@gmail.com>
 <4d1c3bc0418e48b1b9d44799d65ea375@huawei.com>
 <MWHPR11MB18860801196A9319EBD96AF68C699@MWHPR11MB1886.namprd11.prod.outlook.com>
 <d7bb4ab26b8542c698926b7a0a3fc12c@huawei.com>
 <MWHPR11MB18861A144C085677931922018C699@MWHPR11MB1886.namprd11.prod.outlook.com>
 <e5b262c1ee14481ab68074be2a76b9d9@huawei.com>
 <55E334BA-C6D2-4892-9207-32654FBF4360@gmail.com>
 <14fe0083-cbff-884c-34db-ce3227e026f5@linux.intel.com>
 <55A4B205-BC38-4F16-9EB9-54026C326E60@gmail.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <a49ec650-5dae-0045-1ea3-1978009b3b1f@linux.intel.com>
Date: Sat, 27 Mar 2021 13:27:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <55A4B205-BC38-4F16-9EB9-54026C326E60@gmail.com>
Content-Language: en-US
Cc: chenjiashang <chenjiashang@huawei.com>, "Tian,
 Kevin" <kevin.tian@intel.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>, "Longpeng \(Mike,
 Cloud Infrastructure Service Product Dept.\)" <longpeng2@huawei.com>,
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

SGkgTmFkYXYsCgpPbiAzLzI3LzIxIDEyOjM2IFBNLCBOYWRhdiBBbWl0IHdyb3RlOgo+IAo+IAo+
PiBPbiBNYXIgMjYsIDIwMjEsIGF0IDc6MzEgUE0sIEx1IEJhb2x1IDxiYW9sdS5sdUBsaW51eC5p
bnRlbC5jb20+IHdyb3RlOgo+Pgo+PiBIaSBOYWRhdiwKPj4KPj4gT24gMy8xOS8yMSAxMjo0NiBB
TSwgTmFkYXYgQW1pdCB3cm90ZToKPj4+IFNvIGhlcmUgaXMgbXkgZ3Vlc3M6Cj4+PiBJbnRlbCBw
cm9iYWJseSB1c2VkIGFzIGEgYmFzaXMgZm9yIHRoZSBJT1RMQiBhbiBpbXBsZW1lbnRhdGlvbiBv
Zgo+Pj4gc29tZSBvdGhlciAocmVndWxhcikgVExCIGRlc2lnbi4KPj4+IEludGVsIFNETSBzYXlz
IHJlZ2FyZGluZyBUTEJzICg0LjEwLjQuMiDigJxSZWNvbW1lbmRlZCBJbnZhbGlkYXRpb27igJ0p
Ogo+Pj4gIlNvZnR3YXJlIHdpc2hpbmcgdG8gcHJldmVudCB0aGlzIHVuY2VydGFpbnR5IHNob3Vs
ZCBub3Qgd3JpdGUgdG8KPj4+IGEgcGFnaW5nLXN0cnVjdHVyZSBlbnRyeSBpbiBhIHdheSB0aGF0
IHdvdWxkIGNoYW5nZSwgZm9yIGFueSBsaW5lYXIKPj4+IGFkZHJlc3MsIGJvdGggdGhlIHBhZ2Ug
c2l6ZSBhbmQgZWl0aGVyIHRoZSBwYWdlIGZyYW1lLCBhY2Nlc3MgcmlnaHRzLAo+Pj4gb3Igb3Ro
ZXIgYXR0cmlidXRlcy7igJ0KPj4+IE5vdyB0aGUgYWZvcmVtZW50aW9uZWQgdW5jZXJ0YWludHkg
aXMgYSBiaXQgZGlmZmVyZW50IChtdWx0aXBsZQo+Pj4gKnZhbGlkKiAgdHJhbnNsYXRpb25zIG9m
IGEgc2luZ2xlIGFkZHJlc3MpLiBZZXQsIHBlcmhhcHMgdGhpcyBpcwo+Pj4geWV0IGFub3RoZXIg
dGhpbmcgdGhhdCBtaWdodCBoYXBwZW4uCj4+PiAgRnJvbSBhIGJyaWVmIGxvb2sgb24gdGhlIGhh
bmRsaW5nIG9mIE1NVSAobm90IElPTU1VKSBodWdlcGFnZXMKPj4+IGluIExpbnV4LCBpbmRlZWQg
dGhlIFBNRCBpcyBmaXJzdCBjbGVhcmVkIGFuZCBmbHVzaGVkIGJlZm9yZSBhCj4+PiBuZXcgdmFs
aWQgUE1EIGlzIHNldC4gVGhpcyBpcyBwb3NzaWJsZSBmb3IgTU1VcyBzaW5jZSB0aGV5Cj4+PiBh
bGxvdyB0aGUgc29mdHdhcmUgdG8gaGFuZGxlIHNwdXJpb3VzIHBhZ2UtZmF1bHRzIGdyYWNlZnVs
bHkuCj4+PiBUaGlzIGlzIG5vdCB0aGUgY2FzZSBmb3IgdGhlIElPTU1VIHRob3VnaCAod2l0aG91
dCBQUkkpLgo+Pj4gTm90IHN1cmUgdGhpcyBleHBsYWlucyBldmVyeXRoaW5nIHRob3VnaC4gSWYg
dGhhdCBpcyB0aGUgcHJvYmxlbSwKPj4+IHRoZW4gZHVyaW5nIGEgbWFwcGluZyB0aGF0IGNoYW5n
ZXMgcGFnZS1zaXplcywgYSBUTEIgZmx1c2ggaXMKPj4+IG5lZWRlZCwgc2ltaWxhcmx5IHRvIHRo
ZSBvbmUgTG9uZ3BlbmcgZGlkIG1hbnVhbGx5Lgo+Pgo+PiBJIGhhdmUgYmVlbiB3b3JraW5nIHdp
dGggTG9uZ3Blbmcgb24gdGhpcyBpc3N1ZSB0aGVzZSBkYXlzLiBJdCB0dXJuZWQKPj4gb3V0IHRo
YXQgeW91ciBndWVzcyBpcyByaWdodC4gVGhlIFBNRCBpcyBmaXJzdCBjbGVhcmVkIGJ1dCBub3Qg
Zmx1c2hlZAo+PiBiZWZvcmUgYSBuZXcgdmFsaWQgb25lIGlzIHNldC4gVGhlIHByZXZpb3VzIGVu
dHJ5IG1pZ2h0IGJlIGNhY2hlZCBpbiB0aGUKPj4gcGFnaW5nIHN0cnVjdHVyZSBjYWNoZXMgaGVu
Y2UgbGVhZHMgdG8gZGlzYXN0ZXIuCj4+Cj4+IEluIF9fZG9tYWluX21hcHBpbmcoKToKPj4KPj4g
MjM1MiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC8qCj4+IDIzNTMgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgKiBFbnN1cmUgdGhhdCBvbGQgc21hbGwgcGFnZSB0YWJs
ZXMgYXJlCj4+IDIzNTQgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKiByZW1vdmVk
IHRvIG1ha2Ugcm9vbSBmb3Igc3VwZXJwYWdlKHMpLgo+PiAyMzU1ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICogV2UncmUgYWRkaW5nIG5ldyBsYXJnZSBwYWdlcywgc28gbWFrZSBz
dXJlCj4+IDIzNTYgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKiB3ZSBkb24ndCBy
ZW1vdmUgdGhlaXIgcGFyZW50IHRhYmxlcy4KPj4gMjM1NyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAqLwo+PiAyMzU4ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZG1h
X3B0ZV9mcmVlX3BhZ2V0YWJsZShkb21haW4sIGlvdl9wZm4sIGVuZF9wZm4sCj4+IDIzNTkgbGFy
Z2VwYWdlX2x2bCArIDEpOwo+Pgo+PiBJIGd1ZXNzIGFkZGluZyBhIGNhY2hlIGZsdXNoIG9wZXJh
dGlvbiBhZnRlciBQTUQgc3dpdGNoaW5nIHNob3VsZCBzb2x2ZQo+PiB0aGUgcHJvYmxlbS4KPj4K
Pj4gSSBhbSBzdGlsbCBub3QgY2xlYXIgYWJvdXQgdGhpcyBjb21tZW50Ogo+Pgo+PiAiCj4+IFRo
aXMgaXMgcG9zc2libGUgZm9yIE1NVXMgc2luY2UgdGhleSBhbGxvdyB0aGUgc29mdHdhcmUgdG8g
aGFuZGxlCj4+IHNwdXJpb3VzIHBhZ2UtZmF1bHRzIGdyYWNlZnVsbHkuIFRoaXMgaXMgbm90IHRo
ZSBjYXNlIGZvciB0aGUgSU9NTVUKPj4gdGhvdWdoICh3aXRob3V0IFBSSSkuCj4+ICIKPj4KPj4g
Q2FuIHlvdSBwbGVhc2Ugc2hlZCBtb3JlIGxpZ2h0IG9uIHRoaXM/Cj4gCj4gSSB3YXMgbG9va2lu
ZyBhdCB0aGUgY29kZSBpbiBtb3JlIGRldGFpbCwgYW5kIGFwcGFyZW50bHkgbXkgY29uY2Vybgo+
IGlzIGluY29ycmVjdC4KPiAKPiBJIHdhcyB1bmRlciB0aGUgYXNzdW1wdGlvbiB0aGF0IHRoZSBJ
T01NVSBtYXAvdW5tYXAgY2FuIG1lcmdlL3NwbGl0Cj4gKHNwZWNpZmljYWxseSBzcGxpdCkgaHVn
ZS1wYWdlcy4gRm9yIGluc3RhbmNlLCBpZiB5b3UgbWFwIDJNQiBhbmQKPiB0aGVuIHVubWFwIDRL
QiBvdXQgb2YgdGhlIDJNQiwgdGhlbiB5b3Ugd291bGQgc3BsaXQgdGhlIGh1Z2VwYWdlCj4gYW5k
IGtlZXAgdGhlIHJlc3Qgb2YgdGhlIG1hcHBpbmdzIGFsaXZlLiBUaGlzIGlzIHRoZSB3YXkgTU1V
IGlzCj4gdXN1YWxseSBtYW5hZ2VkLiBUbyBteSBkZWZlbnNlLCBJIGFsc28gc2F3IHN1Y2ggcGFy
dGlhbCB1bm1hcHBpbmdzCj4gaW4gTG9uZ3BlbmfigJlzIGZpcnN0IHNjZW5hcmlvLgo+IAo+IElm
IHRoaXMgd2FzIHBvc3NpYmxlLCB0aGVuIHlvdSB3b3VsZCBoYXZlIGEgY2FzZSBpbiB3aGljaCBv
dXQgb2YgMk1CCj4gKGZvciBpbnN0YW5jZSksIDRLQiB3ZXJlIHVubWFwcGVkLCBhbmQgeW91IG5l
ZWQgdG8gc3BsaXQgdGhlIDJNQgo+IGh1Z2VwYWdlIGludG8gNEtCIHBhZ2VzLiBJZiB5b3UgdHJ5
IHRvIGNsZWFyIHRoZSBQTUQsIGZsdXNoLCBhbmQgdGhlbgo+IHNldCB0aGUgUE1EIHRvIHBvaW50
IHRvIHRhYmxlIHdpdGggbGl2ZSA0S0IgUFRFUywgeW91IGNhbiBoYXZlCj4gYW4gaW50ZXJpbSBz
dGF0ZSBpbiB3aGljaCB0aGUgUE1EIGlzIG5vdCBwcmVzZW50LiBETUFzIHRoYXQgYXJyaXZlCj4g
YXQgdGhpcyBzdGFnZSBtaWdodCBmYXVsdCwgYW5kIHdpdGhvdXQgUFJJIChhbmQgZGV2aWNlIHN1
cHBvcnQpCj4geW91IGRvIG5vdCBoYXZlIGEgd2F5IG9mIHJlc3RhcnRpbmcgdGhlIERNQSBhZnRl
ciB0aGUgaHVnZXBhZ2Ugc3BsaXQKPiBpcyBjb21wbGV0ZWQuCgpHZXQgeW91IGFuZCB0aGFua3Mg
YSBsb3QgZm9yIHNoYXJpbmcuCgpGb3IgY3VycmVudCBJT01NVSB1c2FnZSwgSSBjYW4ndCBzZWUg
YW55IGNhc2UgdG8gc3BsaXQgYSBodWdlIHBhZ2UgaW50bwo0S0IgcGFnZXMsIGJ1dCBpbiB0aGUg
bmVhciBmdXR1cmUsIHdlIGRvIGhhdmUgYSBuZWVkIG9mIHNwbGl0dGluZyBodWdlCnBhZ2VzLiBG
b3IgZXhhbXBsZSwgd2hlbiB3ZSB3YW50IHRvIHVzZSB0aGUgQS9EIGJpdCB0byB0cmFjayB0aGUg
RE1BCmRpcnR5IHBhZ2VzIGR1cmluZyBWTSBtaWdyYXRpb24sIGl0J3MgYW4gb3B0aW1pemF0aW9u
IGlmIHdlIGNvdWxkIHNwbGl0CmEgaHVnZSBwYWdlIGludG8gNEsgb25lcy4gU28gZmFyLCB0aGUg
c29sdXRpb24gSSBoYXZlIGNvbnNpZGVyZWQgaXM6CgoxKSBQcmVwYXJlIHRoZSBzcGxpdCBzdWJ0
YWJsZXMgaW4gYWR2YW5jZTsKICAgIFtpdCdzIGlkZW50aWNhbCB0byB0aGUgZXhpc3Rpbmcgb25l
IG9ubHkgdXNlIDRrIHBhZ2VzIGluc3RlYWQgb2YgaHVnZQogICAgIHBhZ2UuXQoyKSBTd2l0Y2gg
dGhlIHN1cGVyIChodWdlKSBwYWdlJ3MgbGVhZiBlbnRyeTsKICAgIFthdCB0aGlzIHBvaW50LCBo
YXJkd2FyZSBjb3VsZCB1c2UgYm90aCBzdWJ0YWJsZXMuIEkgYW0gbm90IHN1cmUKICAgICB3aGV0
aGVyIHRoZSBoYXJkd2FyZSBhbGxvd3MgYSBkeW5hbWljIHN3aXRjaCBvZiBwYWdlIHRhYmxlIGVu
dHJ5CiAgICAgZnJvbSBvbiB2YWxpZCBlbnRyeSB0byBhbm90aGVyIHZhbGlkIG9uZS5dCjMpIEZs
dXNoIHRoZSBjYWNoZS4KICAgIFtoYXJkd2FyZSB3aWxsIHVzZSB0aGUgbmV3IHN1YnRhYmxlXQoK
QXMgbG9uZyBhcyB3ZSBjYW4gbWFrZSBzdXJlIHRoYXQgdGhlIG9sZCBzdWJ0YWJsZSB3b24ndCBi
ZSB1c2VkIGJ5CmhhcmR3YXJlLCB3ZSBjYW4gc2FmZWx5IHJlbGVhc2UgdGhlIG9sZCB0YWJsZS4K
Cj4gCj4gQW55aG93LCB0aGlzIGNvbmNlcm4gaXMgYXBwYXJlbnRseSBub3QgcmVsZXZhbnQuIEkg
Z3Vlc3MgSSB3YXMgdG9vCj4gbmFpdmUgdG8gYXNzdW1lIHRoZSBJT01NVSBtYW5hZ2VtZW50IGlz
IHNpbWlsYXIgdG8gdGhlIE1NVS4gSSBub3cKPiBzZWUgdGhhdCB0aGVyZSBpcyBhIGNvbW1lbnQg
aW4gaW50ZWxfaW9tbXVfdW5tYXAoKSBzYXlpbmc6Cj4gCj4gICAgICAgICAgLyogQ29wZSB3aXRo
IGhvcnJpZCBBUEkgd2hpY2ggcmVxdWlyZXMgdXMgdG8gdW5tYXAgbW9yZSB0aGFuIHRoZQo+ICAg
ICAgICAgICAgIHNpemUgYXJndW1lbnQgaWYgaXQgaGFwcGVucyB0byBiZSBhIGxhcmdlLXBhZ2Ug
bWFwcGluZy4gKi8KPiAKPiBSZWdhcmRzLAo+IE5hZGF2Cj4gCgpCZXN0IHJlZ2FyZHMsCmJhb2x1
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1h
aWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
