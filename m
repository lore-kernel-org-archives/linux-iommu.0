Return-Path: <SRS0=5edT=4J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45C0C35647
	for <iommu@archiver.kernel.org>; Fri, 21 Feb 2020 13:20:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C216524650
	for <iommu@archiver.kernel.org>; Fri, 21 Feb 2020 13:20:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C216524650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 926EF87F44;
	Fri, 21 Feb 2020 13:20:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DfhstF6ojMYq; Fri, 21 Feb 2020 13:20:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9DEAA87F3F;
	Fri, 21 Feb 2020 13:20:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E1DAC1D81;
	Fri, 21 Feb 2020 13:20:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C67A1C013E
 for <iommu@lists.linux-foundation.org>; Fri, 21 Feb 2020 13:20:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B59CC85F8D
 for <iommu@lists.linux-foundation.org>; Fri, 21 Feb 2020 13:20:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gkgaT66Az-H7 for <iommu@lists.linux-foundation.org>;
 Fri, 21 Feb 2020 13:19:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3A32581B71
 for <iommu@lists.linux-foundation.org>; Fri, 21 Feb 2020 13:19:43 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 21 Feb 2020 05:19:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,468,1574150400"; d="scan'208";a="409134428"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.211.156])
 ([10.254.211.156])
 by orsmga005.jf.intel.com with ESMTP; 21 Feb 2020 05:19:40 -0800
Subject: Re: [PATCH] iommu/dmar: ignore devices with out-of-spec domain number
To: Daniel Drake <drake@endlessm.com>, dwmw2@infradead.org, joro@8bytes.org
References: <20200211090325.11423-1-drake@endlessm.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <2e5913f9-05d3-933b-9e94-153f334da1e4@linux.intel.com>
Date: Fri, 21 Feb 2020 21:19:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200211090325.11423-1-drake@endlessm.com>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, linux@endlessm.com
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

SGksCgpPbiAyMDIwLzIvMTEgMTc6MDMsIERhbmllbCBEcmFrZSB3cm90ZToKPiBWTUQgc3ViZGV2
aWNlcyBhcmUgY3JlYXRlZCB3aXRoIGEgUENJIGRvbWFpbiBJRCBvZiAweDEwMDAwIG9yCj4gaGln
aGVyLgo+IAo+IFRoZXNlIHN1YmRldmljZXMgYXJlIGFsc28gaGFuZGxlZCBsaWtlIGFsbCBvdGhl
ciBQQ0kgZGV2aWNlcyBieQo+IGRtYXJfcGNpX2J1c19ub3RpZmllcigpLgo+IAo+IEhvd2V2ZXIs
IHdoZW4gZG1hcl9hbGxvY19wY2lfbm90aWZ5X2luZm8oKSB0YWtlIHJlY29yZHMgb2Ygc3VjaCBk
ZXZpY2VzLAo+IGl0IHdpbGwgdHJ1bmNhdGUgdGhlIGRvbWFpbiBJRCB0byBhIHUxNiB2YWx1ZSAo
aW4gaW5mby0+c2VnKS4KPiBUaGUgZGV2aWNlIGF0IChlLmcuKSAxMDAwMDowMDowMi4wIGlzIHRo
ZW4gdHJlYXRlZCBieSB0aGUgRE1BUiBjb2RlIGFzIGlmCj4gaXQgaXMgMDAwMDowMDowMi4wLgo+
IAo+IEluIHRoZSB1bmx1Y2t5IGV2ZW50IHRoYXQgYSByZWFsIGRldmljZSBhbHNvIGV4aXN0cyBh
dCAwMDAwOjAwOjAyLjAgYW5kCj4gYWxzbyBoYXMgYSBkZXZpY2Utc3BlY2lmaWMgZW50cnkgaW4g
dGhlIERNQVIgdGFibGUsCj4gZG1hcl9pbnNlcnRfZGV2X3Njb3BlKCkgd2lsbCBjcmFzaCBvbjoK
PiAgIMKgIEJVR19PTihpID49IGRldmljZXNfY250KTsKPiAKPiBUaGF0J3MgYmFzaWNhbGx5IGEg
c2FuaXR5IGNoZWNrIHRoYXQgb25seSBvbmUgUENJIGRldmljZSBtYXRjaGVzIGEKPiBzaW5nbGUg
RE1BUiBlbnRyeTsgaW4gdGhpcyBjYXNlIHdlIHNlZW0gdG8gaGF2ZSB0d28gbWF0Y2hpbmcgZGV2
aWNlcy4KPiAKPiBGaXggdGhpcyBieSBpZ25vcmluZyBkZXZpY2VzIHRoYXQgaGF2ZSBhIGRvbWFp
biBudW1iZXIgaGlnaGVyIHRoYW4KPiB3aGF0IGNhbiBiZSBsb29rZWQgdXAgaW4gdGhlIERNQVIg
dGFibGUuCj4gCj4gVGhpcyBwcm9ibGVtIHdhcyBjYXJlZnVsbHkgZGlhZ25vc2VkIGJ5IEppYW4t
SG9uZyBQYW4uCj4gCj4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIERyYWtlPGRyYWtlQGVuZGxlc3Nt
LmNvbT4KClF1ZXVlZCBmb3IgdjUuNy4gVGhhbmtzIQoKQmVzdCByZWdhcmRzLApiYW9sdQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5n
IGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
