Return-Path: <SRS0=JfOd=4H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7A7C34022
	for <iommu@archiver.kernel.org>; Wed, 19 Feb 2020 08:58:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F4062176D
	for <iommu@archiver.kernel.org>; Wed, 19 Feb 2020 08:58:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F4062176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id F35E3878A4;
	Wed, 19 Feb 2020 08:58:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cBNokrWx6qlE; Wed, 19 Feb 2020 08:58:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5A1F2856B8;
	Wed, 19 Feb 2020 08:58:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 526B1C1D80;
	Wed, 19 Feb 2020 08:58:33 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8309DC013E
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 08:58:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 642312048C
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 08:58:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6f+8-IHuIspw for <iommu@lists.linux-foundation.org>;
 Wed, 19 Feb 2020 08:58:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by silver.osuosl.org (Postfix) with ESMTPS id 29E2220343
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 08:58:31 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 Feb 2020 00:58:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,459,1574150400"; d="scan'208";a="258856429"
Received: from wliu50-mobl.ccr.corp.intel.com (HELO [10.249.177.60])
 ([10.249.177.60])
 by fmsmga004.fm.intel.com with ESMTP; 19 Feb 2020 00:58:29 -0800
Subject: Re: dmar fault right around domain switch in iommu_need_mapping
To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <20200218154549.rcav24rkm7rc4hvp@cantor>
 <1215cfc2-cfa0-c0d7-01fb-8c5b12dd5a2e@linux.intel.com>
 <20200219043020.7tlj4f2ruwh52fjq@cantor>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <deef4aeb-fa94-fbec-d9a0-1d0b9ef71421@linux.intel.com>
Date: Wed, 19 Feb 2020 16:58:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200219043020.7tlj4f2ruwh52fjq@cantor>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org
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

SGksCgpPbiAyMDIwLzIvMTkgMTI6MzAsIEplcnJ5IFNuaXRzZWxhYXIgd3JvdGU6Cj4gT24gV2Vk
IEZlYiAxOSAyMCwgTHUgQmFvbHUgd3JvdGU6Cj4+IEhpIEplcnJ5LAo+Pgo+PiBPbiAyMDIwLzIv
MTggMjM6NDUsIEplcnJ5IFNuaXRzZWxhYXIgd3JvdGU6Cj4+PiBIaSBKb2VyZyBhbmQgQmFvbHUs
Cj4+Pgo+Pj4gSSdtIGNoYXNpbmcgZG93biBvbmUgbGFzdCBpc3N1ZS4gSSdtIHdhaXRpbmcgdG8g
aGVhciBiYWNrIGZyb20gdGhlbQo+Pj4gdGVzdGluZyB3aXRoIEpvZXJnJ3MgcGF0Y2hzZXQsIGJ1
dCBJJ20gZ3Vlc3NpbmcgdGhpcyB3aWxsIHN0aWxsIHBvcAo+Pj4gdXAuIEl0IGxvb2tzIGxpa2Ug
cmlnaHQgYXJvdW5kIHdoZW4gdGhlIGRvbWFpbiBzd2l0Y2ggb2NjdXJzIGluCj4+PiBpb21tdV9u
ZWVkX21hcHBpbmcgdGhlcmUgYXJlIHNvbWUgZG1hciBmYXVsdHMgKGJlbG93IGlzIGZyb20gNS42
LXJjMQo+Pj4gcGx1cyBlYXJsaWVyIGZpeCBhdHRlbXB0IHRoYXQgbW92ZWQgZGVmZXJyZWQgYXR0
YWNoIHRvIGJlZ2lubmluZyBvZgo+Pj4gaW9tbXVfbmVlZF9tYXBwaW5nKToKPj4+Cj4+PiBbwqDC
oCAxMi41NDY5MjBdIERNQVI6IERSSEQ6IGhhbmRsaW5nIGZhdWx0IHN0YXR1cyByZWcgMgo+Pj4g
W8KgwqAgMTIuNTQ2OTIzXSBETUFSOiBbRE1BIFJlYWRdIFJlcXVlc3QgZGV2aWNlIFswMjowMC4w
XSBQQVNJRCAKPj4+IGZmZmZmZmZmIGZhdWx0IGFkZHIgNzkxZGQwMDAgW2ZhdWx0IHJlYXNvbiAw
Ml0gUHJlc2VudCBiaXQgaW4gY29udGV4dCAKPj4+IGVudHJ5IGlzIGNsZWFyCj4+PiBbwqDCoCAx
Mi42MzUxOTNdIGhwc2EgMDAwMDowMjowMC4wOiBVc2luZyBpb21tdSBkbWEgbWFwcGluZwo+Pj4g
W8KgwqAgMTIuNzc2NzEyXSBocHNhIDAwMDA6MDI6MDAuMDogRE1BUjogMzJiaXQgRE1BIHVzZXMg
bm9uLWlkZW50aXR5IAo+Pj4gbWFwcGluZwo+Pj4KPj4+IFvCoMKgIDE0LjA5MTIxOV0gRE1BUjog
W0RNQSBSZWFkXSBSZXF1ZXN0IGRldmljZSBbMDc6MDAuMF0gUEFTSUQgCj4+PiBmZmZmZmZmZiBm
YXVsdCBhZGRyIDc5MWRkMDAwIFtmYXVsdCByZWFzb24gMDJdIFByZXNlbnQgYml0IGluIGNvbnRl
eHQgCj4+PiBlbnRyeSBpcyBjbGVhcgo+Pj4gW8KgwqAgMTQuMTgwODQyXSBETUFSOiBEUkhEOiBo
YW5kbGluZyBmYXVsdCBzdGF0dXMgcmVnIDIwMgo+Pj4gW8KgwqAgMTQuMTgwODQ1XSBETUFSOiBb
RE1BIFJlYWRdIFJlcXVlc3QgZGV2aWNlIFswNzowMC4wXSBQQVNJRCAKPj4+IGZmZmZmZmZmIGZh
dWx0IGFkZHIgNzkxZGQwMDAgW2ZhdWx0IHJlYXNvbiAwMl0gUHJlc2VudCBiaXQgaW4gY29udGV4
dCAKPj4+IGVudHJ5IGlzIGNsZWFyCj4+PiBbwqDCoCAxNC4yNjg3NTZdIERNQVI6IERSSEQ6IGhh
bmRsaW5nIGZhdWx0IHN0YXR1cyByZWcgMzAyCj4+PiBbwqDCoCAxNS41NDI1NTFdIGhwc2EgMDAw
MDowNzowMC4wOiBVc2luZyBpb21tdSBkbWEgbWFwcGluZwo+Pj4gW8KgwqAgMTUuNTY3MjU2XSBo
cHNhIDAwMDA6MDc6MDAuMDogRE1BUjogMzJiaXQgRE1BIHVzZXMgbm9uLWlkZW50aXR5IAo+Pj4g
bWFwcGluZwo+Pj4KPj4+Cj4+PiBJdCBzZWVtcyB0byBvbmx5IGhhcHBlbiByaWdodCB0aGVuLCBh
bmQgdGhlbiB0aGluZ3MgYXJlIGZpbmUuIEhhcHBlbnMKPj4+IGR1cmluZyBib3RoIHJlZ3VsYXIg
YW5kIGtkdW1wIGJvb3QuwqAgV2l0aCB0aGUga2R1bXAgYm9vdCB0aGUgZmF1bHRzCj4+PiBhcmUg
ZnJvbSB0aGUgaHBpbG8gaW4gdGhlIGxvZ3MgSSdtIGxvb2tpbmcgYXQsIHNvIGl0IGRvZXNuJ3Qg
c2VlbSB0bwo+Pj4gYmUgdGllZCB0byBhIGRldmljZSwgb3IgY2VydGFpbiBybXJyLiBUaGUgZmF1
bHRpbmcgYWRkcmVzcyBhbHdheXMKPj4+IHNlZW1zIHRvIGJlIHRoZSBiYXNlIGFkZHJlc3Mgb2Yg
dGhlIHJtcnIuwqAgVGhlIGRtYXIgdGFibGVzIGxvb2sgc2FuZS4KPj4KPj4gUGVyaGFwcyBsaWtl
IHRoaXM/Cj4+Cj4+IFRoZSBkZXZpY2Ugd2FzIGJvb3Qgd2l0aCBhbiBpZGVudGl0eSBkb21haW4g
KGlvbW11PXB0KS4gV2hlbiBsb2FkaW5nIHRoZQo+PiBkcml2ZXIgZm9yIHRoaXMgZGV2aWNlLCBp
b21tdSBkcml2ZXIgZmluZHMgdGhhdCBpdCdzIGEgMzItYml0IGRldmljZSBhbmQKPj4gdHJpZXMg
dG8gY29udmVydCBpdCB0byBETUEgZG9tYWluLiBUaGUgcm1yciBpcyBzdGlsbCBhY3RpdmUgZHVy
aW5nIHRoZQo+PiBzd2l0Y2gsIGhlbmNlIHlvdSBzZWUgZG1hIGZhdWx0cyBkdXJpbmcgdGhhdCB0
aW1lIHdpbmRvdy4KPj4KPj4gQmVzdCByZWdhcmRzLAo+PiBiYW9sdQo+Pgo+IAo+IEl0IGxvb2tz
IGxpa2UgaXQgZG9lc24ndCBvY2N1ciB3aXRoIEpvZXJnJ3MgcGF0Y2hzZXQuCj4gCgpPa2F5LiBD
b29sIQoKQmVzdCByZWdhcmRzLApiYW9sdQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vaW9tbXU=
