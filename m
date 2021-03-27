Return-Path: <SRS0=Y/a2=IZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507B8C433C1
	for <iommu@archiver.kernel.org>; Sat, 27 Mar 2021 02:41:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EBA861951
	for <iommu@archiver.kernel.org>; Sat, 27 Mar 2021 02:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EBA861951
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4683C60DC0;
	Sat, 27 Mar 2021 02:41:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aubJOKJPQ0Qc; Sat, 27 Mar 2021 02:41:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2BEF260629;
	Sat, 27 Mar 2021 02:41:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3AE3C000B;
	Sat, 27 Mar 2021 02:41:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8EAB5C000A
 for <iommu@lists.linux-foundation.org>; Sat, 27 Mar 2021 02:40:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 67F3560DA8
 for <iommu@lists.linux-foundation.org>; Sat, 27 Mar 2021 02:40:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R115rRoRmsi4 for <iommu@lists.linux-foundation.org>;
 Sat, 27 Mar 2021 02:40:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BF26660629
 for <iommu@lists.linux-foundation.org>; Sat, 27 Mar 2021 02:40:58 +0000 (UTC)
IronPort-SDR: OgGwJRbI1Fyeh9zhAUrXgyesa2sRovsEYgwi5kT9cMsnmYQUg4hSggokBrY3rZQxv8/B586NUM
 Pm63FSRfEXHQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="276399758"
X-IronPort-AV: E=Sophos;i="5.81,282,1610438400"; d="scan'208";a="276399758"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2021 19:40:58 -0700
IronPort-SDR: d14WaLxija5o/8mdOjY92Du6phvwkx02sNxLC9N44mZPFZ5Qeue1PGPo1BzjlsuRO9687m6Qjm
 JH+71DgQhY7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,282,1610438400"; d="scan'208";a="437098251"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 26 Mar 2021 19:40:55 -0700
Subject: =?UTF-8?Q?Re=3a_A_problem_of_Intel_IOMMU_hardware_=ef=bc=9f?=
To: Nadav Amit <nadav.amit@gmail.com>,
 "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)"
 <longpeng2@huawei.com>
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
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <14fe0083-cbff-884c-34db-ce3227e026f5@linux.intel.com>
Date: Sat, 27 Mar 2021 10:31:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <55E334BA-C6D2-4892-9207-32654FBF4360@gmail.com>
Content-Language: en-US
Cc: chenjiashang <chenjiashang@huawei.com>, "Tian,
 Kevin" <kevin.tian@intel.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
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

SGkgTmFkYXYsCgpPbiAzLzE5LzIxIDEyOjQ2IEFNLCBOYWRhdiBBbWl0IHdyb3RlOgo+IFNvIGhl
cmUgaXMgbXkgZ3Vlc3M6Cj4gCj4gSW50ZWwgcHJvYmFibHkgdXNlZCBhcyBhIGJhc2lzIGZvciB0
aGUgSU9UTEIgYW4gaW1wbGVtZW50YXRpb24gb2YKPiBzb21lIG90aGVyIChyZWd1bGFyKSBUTEIg
ZGVzaWduLgo+IAo+IEludGVsIFNETSBzYXlzIHJlZ2FyZGluZyBUTEJzICg0LjEwLjQuMiDigJxS
ZWNvbW1lbmRlZCBJbnZhbGlkYXRpb27igJ0pOgo+IAo+ICJTb2Z0d2FyZSB3aXNoaW5nIHRvIHBy
ZXZlbnQgdGhpcyB1bmNlcnRhaW50eSBzaG91bGQgbm90IHdyaXRlIHRvCj4gYSBwYWdpbmctc3Ry
dWN0dXJlIGVudHJ5IGluIGEgd2F5IHRoYXQgd291bGQgY2hhbmdlLCBmb3IgYW55IGxpbmVhcgo+
IGFkZHJlc3MsIGJvdGggdGhlIHBhZ2Ugc2l6ZSBhbmQgZWl0aGVyIHRoZSBwYWdlIGZyYW1lLCBh
Y2Nlc3MgcmlnaHRzLAo+IG9yIG90aGVyIGF0dHJpYnV0ZXMu4oCdCj4gCj4gCj4gTm93IHRoZSBh
Zm9yZW1lbnRpb25lZCB1bmNlcnRhaW50eSBpcyBhIGJpdCBkaWZmZXJlbnQgKG11bHRpcGxlCj4g
KnZhbGlkKiAgdHJhbnNsYXRpb25zIG9mIGEgc2luZ2xlIGFkZHJlc3MpLiBZZXQsIHBlcmhhcHMg
dGhpcyBpcwo+IHlldCBhbm90aGVyIHRoaW5nIHRoYXQgbWlnaHQgaGFwcGVuLgo+IAo+ICBGcm9t
IGEgYnJpZWYgbG9vayBvbiB0aGUgaGFuZGxpbmcgb2YgTU1VIChub3QgSU9NTVUpIGh1Z2VwYWdl
cwo+IGluIExpbnV4LCBpbmRlZWQgdGhlIFBNRCBpcyBmaXJzdCBjbGVhcmVkIGFuZCBmbHVzaGVk
IGJlZm9yZSBhCj4gbmV3IHZhbGlkIFBNRCBpcyBzZXQuIFRoaXMgaXMgcG9zc2libGUgZm9yIE1N
VXMgc2luY2UgdGhleQo+IGFsbG93IHRoZSBzb2Z0d2FyZSB0byBoYW5kbGUgc3B1cmlvdXMgcGFn
ZS1mYXVsdHMgZ3JhY2VmdWxseS4KPiBUaGlzIGlzIG5vdCB0aGUgY2FzZSBmb3IgdGhlIElPTU1V
IHRob3VnaCAod2l0aG91dCBQUkkpLgo+IAo+IE5vdCBzdXJlIHRoaXMgZXhwbGFpbnMgZXZlcnl0
aGluZyB0aG91Z2guIElmIHRoYXQgaXMgdGhlIHByb2JsZW0sCj4gdGhlbiBkdXJpbmcgYSBtYXBw
aW5nIHRoYXQgY2hhbmdlcyBwYWdlLXNpemVzLCBhIFRMQiBmbHVzaCBpcwo+IG5lZWRlZCwgc2lt
aWxhcmx5IHRvIHRoZSBvbmUgTG9uZ3BlbmcgZGlkIG1hbnVhbGx5LgoKSSBoYXZlIGJlZW4gd29y
a2luZyB3aXRoIExvbmdwZW5nIG9uIHRoaXMgaXNzdWUgdGhlc2UgZGF5cy4gSXQgdHVybmVkCm91
dCB0aGF0IHlvdXIgZ3Vlc3MgaXMgcmlnaHQuIFRoZSBQTUQgaXMgZmlyc3QgY2xlYXJlZCBidXQg
bm90IGZsdXNoZWQKYmVmb3JlIGEgbmV3IHZhbGlkIG9uZSBpcyBzZXQuIFRoZSBwcmV2aW91cyBl
bnRyeSBtaWdodCBiZSBjYWNoZWQgaW4gdGhlCnBhZ2luZyBzdHJ1Y3R1cmUgY2FjaGVzIGhlbmNl
IGxlYWRzIHRvIGRpc2FzdGVyLgoKSW4gX19kb21haW5fbWFwcGluZygpOgoKMjM1MiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIC8qCjIzNTMgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgKiBFbnN1cmUgdGhhdCBvbGQgc21hbGwgcGFnZSAKdGFibGVzIGFyZQoyMzU0ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICogcmVtb3ZlZCB0byBtYWtlIHJvb20gZm9y
IApzdXBlcnBhZ2UocykuCjIzNTUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKiBX
ZSdyZSBhZGRpbmcgbmV3IGxhcmdlIHBhZ2VzLCBzbyAKbWFrZSBzdXJlCjIzNTYgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgKiB3ZSBkb24ndCByZW1vdmUgdGhlaXIgcGFyZW50IHRh
Ymxlcy4KMjM1NyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqLwoyMzU4ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgZG1hX3B0ZV9mcmVlX3BhZ2V0YWJsZShkb21haW4s
IAppb3ZfcGZuLCBlbmRfcGZuLAoyMzU5IApsYXJnZXBhZ2VfbHZsICsgMSk7CgpJIGd1ZXNzIGFk
ZGluZyBhIGNhY2hlIGZsdXNoIG9wZXJhdGlvbiBhZnRlciBQTUQgc3dpdGNoaW5nIHNob3VsZCBz
b2x2ZQp0aGUgcHJvYmxlbS4KCkkgYW0gc3RpbGwgbm90IGNsZWFyIGFib3V0IHRoaXMgY29tbWVu
dDoKCiIKICBUaGlzIGlzIHBvc3NpYmxlIGZvciBNTVVzIHNpbmNlIHRoZXkgYWxsb3cgdGhlIHNv
ZnR3YXJlIHRvIGhhbmRsZQogIHNwdXJpb3VzIHBhZ2UtZmF1bHRzIGdyYWNlZnVsbHkuIFRoaXMg
aXMgbm90IHRoZSBjYXNlIGZvciB0aGUgSU9NTVUKICB0aG91Z2ggKHdpdGhvdXQgUFJJKS4KIgoK
Q2FuIHlvdSBwbGVhc2Ugc2hlZCBtb3JlIGxpZ2h0IG9uIHRoaXM/CgpCZXN0IHJlZ2FyZHMsCmJh
b2x1Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11
IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
