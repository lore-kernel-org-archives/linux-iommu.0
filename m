Return-Path: <SRS0=khdJ=LR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FABC48BC2
	for <iommu@archiver.kernel.org>; Wed, 23 Jun 2021 07:23:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49B566102A
	for <iommu@archiver.kernel.org>; Wed, 23 Jun 2021 07:23:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49B566102A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 17286831EF;
	Wed, 23 Jun 2021 07:23:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AOkDyBwtBYOt; Wed, 23 Jun 2021 07:23:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 13AD382BA1;
	Wed, 23 Jun 2021 07:23:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D470BC0010;
	Wed, 23 Jun 2021 07:23:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9B4AC000E
 for <iommu@lists.linux-foundation.org>; Wed, 23 Jun 2021 07:23:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CD15C402F0
 for <iommu@lists.linux-foundation.org>; Wed, 23 Jun 2021 07:23:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O48E9wfrxdN8 for <iommu@lists.linux-foundation.org>;
 Wed, 23 Jun 2021 07:23:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8CA3A402EF
 for <iommu@lists.linux-foundation.org>; Wed, 23 Jun 2021 07:23:05 +0000 (UTC)
IronPort-SDR: mpttKjxpJTQGXdVFa4WPF1PjnzdevMf9J38txKAp8kZNoSPFZhhnDZdr3oLxXdlf77dC4DNAMT
 z+KU8XZVT8CA==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="194350348"
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; d="scan'208";a="194350348"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2021 00:23:04 -0700
IronPort-SDR: 5p2hsF6F1g10FIA+84l+UYLpV4WLkIZZYHvLdM3kKNv95RLieT9SKgJaHWsSwrvraxNXUaRyTV
 4yFCcsE/s7Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; d="scan'208";a="490587560"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga002.fm.intel.com with ESMTP; 23 Jun 2021 00:23:00 -0700
Subject: Re: [PATCH v14 6/6] iommu: Remove mode argument from
 iommu_set_dma_strict()
To: Robin Murphy <robin.murphy@arm.com>, John Garry <john.garry@huawei.com>,
 joro@8bytes.org, will@kernel.org, dwmw2@infradead.org, corbet@lwn.net
References: <1624016058-189713-1-git-send-email-john.garry@huawei.com>
 <1624016058-189713-7-git-send-email-john.garry@huawei.com>
 <c062ef9e-c106-4218-ba2a-c94fdcb6d955@linux.intel.com>
 <60bdd7c3-d73e-c005-ddf7-069bc5065bce@huawei.com>
 <855dd109-1449-7bc6-3d25-7ffeeeffa82a@linux.intel.com>
 <fc52069d-46c5-5ca5-1b44-2fa7cf287d5a@huawei.com>
 <2330bb52-1768-5122-9378-7923034c82bd@arm.com>
 <5564e4b7-99af-c357-594a-1a6efe0c1464@linux.intel.com>
 <cff9f6ef-0f51-797d-0853-5237f5c10555@arm.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <3f8b003a-98bd-df7b-eacc-50c04e0177b1@linux.intel.com>
Date: Wed, 23 Jun 2021 15:21:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <cff9f6ef-0f51-797d-0853-5237f5c10555@arm.com>
Content-Language: en-US
Cc: linux-doc@vger.kernel.org, linuxarm@huawei.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
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

T24gNi8yMy8yMSA2OjI1IEFNLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4gT24gMjAyMS0wNi0yMSAx
NTozMiwgTHUgQmFvbHUgd3JvdGU6Cj4+IEhpIFJvYmluLAo+Pgo+PiBPbiAyMDIxLzYvMjEgMTk6
NTksIFJvYmluIE11cnBoeSB3cm90ZToKPj4+IE9uIDIwMjEtMDYtMjEgMTE6MzQsIEpvaG4gR2Fy
cnkgd3JvdGU6Cj4+Pj4gT24gMjEvMDYvMjAyMSAxMTowMCwgTHUgQmFvbHUgd3JvdGU6Cj4+Pj4+
PiB2b2lkIGlvbW11X3NldF9kbWFfc3RyaWN0KGJvb2wgZm9yY2UpCj4+Pj4+PiB7Cj4+Pj4+PiDC
oMKgwqDCoMKgwqDCoMKgwqAgaWYgKGZvcmNlID09IHRydWUpCj4+Pj4+PiDCoMKgwqDCoMKgwqDC
oMKgIGlvbW11X2RtYV9zdHJpY3QgPSB0cnVlOwo+Pj4+Pj4gwqDCoMKgwqDCoGVsc2UgaWYgKCEo
aW9tbXVfY21kX2xpbmUgJiBJT01NVV9DTURfTElORV9TVFJJQ1QpKQo+Pj4+Pj4gwqDCoMKgwqDC
oMKgwqDCoCBpb21tdV9kbWFfc3RyaWN0ID0gdHJ1ZTsKPj4+Pj4+IH0KPj4+Pj4+Cj4+Pj4+PiBT
byB3ZSB3b3VsZCB1c2UgaW9tbXVfc2V0X2RtYV9zdHJpY3QodHJ1ZSkgZm9yIGEpIGFuZCBiKSwg
YnV0IAo+Pj4+Pj4gaW9tbXVfc2V0X2RtYV9zdHJpY3QoZmFsc2UpIGZvciBjKS4KPj4+Pj4KPj4+
Pj4gWWVzLiBXZSBuZWVkIHRvIGRpc3Rpbmd1aXNoIHRoZSAibXVzdCIgYW5kICJuaWNlLXRvLWhh
dmUiIGNhc2VzIG9mCj4+Pj4+IHNldHRpbmcgc3RyaWN0IG1vZGUuCj4+Pj4+Cj4+Pj4+Pgo+Pj4+
Pj4gVGhlbiBJIGFtIG5vdCBzdXJlIHdoYXQgeW91IHdhbnQgdG8gZG8gd2l0aCB0aGUgYWNjb21w
YW55aW5nIHByaW50IAo+Pj4+Pj4gZm9yIGMpLiBJdCB3YXM6Cj4+Pj4+PiAiSU9NTVUgYmF0Y2hp
bmcgaXMgZGlzYWJsZWQgZHVlIHRvIHZpcnR1YWxpemF0aW9uIgo+Pj4+Pj4KPj4+Pj4+IEFuZCBu
b3cgaXMgZnJvbSB0aGlzIHNlcmllczoKPj4+Pj4+ICJJT01NVSBiYXRjaGluZyBkaXNhbGxvd2Vk
IGR1ZSB0byB2aXJ0dWFsaXphdGlvbiIKPj4+Pj4+Cj4+Pj4+PiBVc2luZyBpb21tdV9nZXRfZG1h
X3N0cmljdChkb21haW4pIGlzIG5vdCBhcHByb3ByaWF0ZSBoZXJlIHRvIGtub3cgCj4+Pj4+PiB0
aGUgY3VycmVudCBtb2RlIChzbyB3ZSBrbm93IHdoZXRoZXIgdG8gcHJpbnQpLgo+Pj4+Pj4KPj4+
Pj4+IE5vdGUgdGhhdCB0aGlzIGNoYW5nZSB3b3VsZCBtZWFuIHRoYXQgdGhlIGN1cnJlbnQgc2Vy
aWVzIHdvdWxkIAo+Pj4+Pj4gcmVxdWlyZSBub24tdHJpdmlhbCByZXdvcmssIHdoaWNoIHdvdWxk
IGJlIHVuZm9ydHVuYXRlIHNvIGxhdGUgaW4gCj4+Pj4+PiB0aGUgY3ljbGUuCj4+Pj4+Cj4+Pj4+
IFRoaXMgcGF0Y2ggc2VyaWVzIGxvb2tzIGdvb2QgdG8gbWUgYW5kIEkgaGF2ZSBhZGRlZCBieSBy
ZXZpZXdlZC1ieS4KPj4+Pj4gUHJvYmFibHkgd2UgY291bGQgbWFrZSBhbm90aGVyIHBhdGNoIHNl
cmllcyB0byBpbXByb3ZlIGl0IHNvIHRoYXQgdGhlCj4+Pj4+IGtlcm5lbCBvcHRpbWl6YXRpb24g
c2hvdWxkIG5vdCBvdmVycmlkZSB0aGUgdXNlciBzZXR0aW5nLgo+Pj4+Cj4+Pj4gT24gYSBwZXJz
b25hbCBsZXZlbCBJIHdvdWxkIGJlIGhhcHB5IHdpdGggdGhhdCBhcHByb2FjaCwgYnV0IEkgdGhp
bmsgCj4+Pj4gaXQncyBiZXR0ZXIgdG8gbm90IHN0YXJ0IGNoYW5naW5nIHRoaW5ncyByaWdodCBh
d2F5IGluIGEgZm9sbG93LXVwIAo+Pj4+IHNlcmllcy4KPj4+Pgo+Pj4+IFNvIGhvdyBhYm91dCB3
ZSBhZGQgdGhpcyBwYXRjaCAod2hpY2ggcmVwbGFjZXMgNi82ICJpb21tdTogUmVtb3ZlIAo+Pj4+
IG1vZGUgYXJndW1lbnQgZnJvbSBpb21tdV9zZXRfZG1hX3N0cmljdCgpIik/Cj4+Pj4KPj4+PiBS
b2JpbiwgYW55IG9waW5pb24/Cj4+Pgo+Pj4gRm9yIG1lIGl0IGJvaWxzIGRvd24gdG8gd2hldGhl
ciB0aGVyZSBhcmUgYW55IHJlYWxpc3RpYyB3b3JrbG9hZHMgCj4+PiB3aGVyZSBub24tc3RyaWN0
IG1vZGUgKndvdWxkKiBzdGlsbCBwZXJmb3JtIGJldHRlciB1bmRlciAKPj4+IHZpcnR1YWxpc2F0
aW9uLiBUaGUgCj4+Cj4+IEF0IHByZXNlbnQsIHdlIHNlZSB0aGF0IHN0cmljdCBtb2RlIGhhcyBi
ZXR0ZXIgcGVyZm9ybWFuY2UgaW4gdGhlCj4+IHZpcnR1YWxpemF0aW9uIGVudmlyb25tZW50IGJl
Y2F1c2UgaXQgd2lsbCBtYWtlIHRoZSBzaGFkb3cgcGFnZSB0YWJsZQo+PiBtYW5hZ2VtZW50IG1v
cmUgZWZmaWNpZW50LiBXaGVuIHRoZSBoYXJkd2FyZSBzdXBwb3J0cyBuZXN0ZWQKPj4gdHJhbnNs
YXRpb24sIHdlIG1heSBoYXZlIHRvIHJlLWV2YWx1YXRlIHRoaXMgc2luY2UgdGhlcmUncyBubyBu
ZWVkIGZvcgo+PiBhIHNoYWRvd2luZyBwYWdlIHRhYmxlIGFueW1vcmUuCj4gCj4gSSBndWVzcyBJ
IHdhcyBhc3N1bWluZyB0aGF0IGluIG1vc3QgY2FzZXMsIHByb3BlciBuZXN0ZWQgbW9kZSBjb3Vs
ZCBsb29rIAo+IGRpc3RpbmN0IGVub3VnaCB0aGF0IHdlJ2QgYmUgYWJsZSB0byB0cmVhdCBpdCBk
aWZmZXJlbnRseSBpbiB0aGUgZmlyc3QgCj4gcGxhY2UuIEZvciBpbnN0YW5jZSwgaWYgaXQncyBo
YW5kaW5nIGd1ZXN0IHRhYmxlcyBkaXJlY3RseSB0byB0aGUgCj4gaGFyZHdhcmUsIHdvdWxkIHRo
ZSBob3N0IGhhdmUgYW55IHJlYXNvbiB0byBzdGlsbCBzZXQgdGhlICJjYWNoaW5nIG1vZGUiIAo+
IElEIGJpdD8KCkZvciBJbnRlbCBWVC1kLCB5ZXMsIHNpbXBseSBmb3IgY29tcGF0aWJsZSBwdXJw
b3NlLiBUaGUgZ3Vlc3Qga2VybmVsCm1heSB1c2UgcGFnZSB0YWJsZXMgdGhhdCBhcmUgbm90IGNv
bXBhdGlibGUgd2l0aCB0aGUgZmlyc3QgbGV2ZWwKdHJhbnNsYXRpb24uIEluIHRoaXMgY2FzZSwg
d2UgbXVzdCByb2xsIGJhY2sgdG8gc2hhZG93IHBhZ2UgdGFibGUuCgo+IAo+IFJvYmluLgoKQmVz
dCByZWdhcmRzLApiYW9sdQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9t
bXU=
