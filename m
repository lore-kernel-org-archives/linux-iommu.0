Return-Path: <SRS0=Xx/3=YV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C8BCA9EC1
	for <iommu@archiver.kernel.org>; Mon, 28 Oct 2019 16:06:29 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F590208C0
	for <iommu@archiver.kernel.org>; Mon, 28 Oct 2019 16:06:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F590208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4435C1151;
	Mon, 28 Oct 2019 16:06:29 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 361901132
	for <iommu@lists.linux-foundation.org>;
	Mon, 28 Oct 2019 16:06:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id BA39187B
	for <iommu@lists.linux-foundation.org>;
	Mon, 28 Oct 2019 16:06:27 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	28 Oct 2019 09:06:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,240,1569308400"; d="scan'208";a="210903910"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
	by fmsmga001.fm.intel.com with ESMTP; 28 Oct 2019 09:06:26 -0700
Date: Mon, 28 Oct 2019 09:10:49 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH v7 11/11] iommu/vt-d: Add svm/sva invalidate function
Message-ID: <20191028091049.04f2d83f@jacob-builder>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D5DB7D9@SHSMSX104.ccr.corp.intel.com>
References: <1571946904-86776-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1571946904-86776-12-git-send-email-jacob.jun.pan@linux.intel.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19D5CDE06@SHSMSX104.ccr.corp.intel.com>
	<5e9d2372-a8b5-9a26-1438-c1a608bfad6d@linux.intel.com>
	<d0375121-7893-bb06-45f3-209a0cff12de@linux.intel.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19D5DB7D9@SHSMSX104.ccr.corp.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Raj, Ashok" <ashok.raj@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>, Jonathan Cameron <jic23@kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

T24gTW9uLCAyOCBPY3QgMjAxOSAwNjowNjozMyArMDAwMAoiVGlhbiwgS2V2aW4iIDxrZXZpbi50
aWFuQGludGVsLmNvbT4gd3JvdGU6Cgo+ID4gPj4+ICvCoMKgwqAgLyogUEFTSUQgYmFzZWQgZGV2
IFRMQnMsIG9ubHkgc3VwcG9ydCBhbGwgUEFTSURzIG9yIHNpbmdsZQo+ID4gPj4+IFBBU0lEICov
Cj4gPiA+Pj4gK8KgwqDCoCB7MSwgMSwgMH0sICAKPiA+ID4+Cj4gPiA+PiBJIGZvcmdvdCBwcmV2
aW91cyBkaXNjdXNzaW9uLiBpcyBpdCBuZWNlc3NhcnkgdG8gcGFzcyBkb3duIGRldgo+ID4gPj4g
VExCIGludmFsaWRhdGlvbgo+ID4gPj4gcmVxdWVzdHM/IENhbiBpdCBiZSBoYW5kbGVkIGJ5IGhv
c3QgaU9NTVUgZHJpdmVyIGF1dG9tYXRpY2FsbHk/ICAKPiA+ID4KPiA+ID4gT24gaG9zdCBTVkEs
IHdoZW4gYSBtZW1vcnkgaXMgdW5tYXBwZWQsIGRyaXZlciBjYWxsYmFjayB3aWxsCj4gPiA+IGlu
dmFsaWRhdGUgZGV2IElPVExCIGV4cGxpY2l0bHkuIFNvIEkgZ3Vlc3Mgd2UgbmVlZCB0byBwYXNz
IGRvd24KPiA+ID4gaXQgZm9yIGd1ZXN0IGNhc2UuIFRoaXMgaXMgYWxzbyByZXF1aXJlZCBmb3Ig
Z3Vlc3QgaW92YSBvdmVyIDFzdAo+ID4gPiBsZXZlbCB1c2FnZSBhcyBmYXIgYXMgY2FuIHNlZS4K
PiA+ID4gIAo+ID4gCj4gPiBTb3JyeSwgSSBjb25mdXNlZCBndWVzdCB2SU9WQSBhbmQgZ3Vlc3Qg
dlNWQS4gRm9yIGd1ZXN0IHZJT1ZBLCBubwo+ID4gZGV2aWNlIFRMQiBpbnZhbGlkYXRpb24gcGFz
cyBkb3duLiBCdXQgY3VycmVudGx5IGZvciBndWVzdCB2U1ZBLAo+ID4gZGV2aWNlIFRMQiBpbnZh
bGlkYXRpb24gaXMgcGFzc2VkIGRvd24uIFBlcmhhcHMgd2UgY2FuIGF2b2lkCj4gPiBwYXNzaW5n
IGRvd24gZGV2IFRMQiBmbHVzaCBqdXN0IGxpa2Ugd2hhdCB3ZSBhcmUgZG9pbmcgZm9yIGd1ZXN0
Cj4gPiBJT1ZBLiAKPiAKPiBJIHRoaW5rIGRldiBUTEIgaXMgZnVsbHkgaGFuZGxlZCB3aXRoaW4g
SU9NTVUgZHJpdmVyIHRvZGF5LiBJdCBkb2Vzbid0Cj4gcmVxdWlyZSBkZXZpY2UgZHJpdmVyIHRv
IGV4cGxpY2l0IHRvZ2dsZS4gV2l0aCB0aGlzIHRoZW4gd2UgY2FuIGZ1bGx5Cj4gdmlydHVhbGl6
ZSBndWVzdCBkZXYgVExCIGludmFsaWRhdGlvbiByZXF1ZXN0IHRvIHNhdmUgb25lIHN5c2NhbGws
Cj4gc2luY2UgdGhlIGhvc3QgaXMgc3VwcG9zZWQgdG8gZmx1c2ggZGV2IFRMQiB3aGVuIHNlcnZp
bmcgdGhlIGVhcmxpZXIKPiBJT1RMQiBpbnZhbGlkYXRpb24gcGFzcy1kb3duLgoKSW4gdGhlIHBy
ZXZpb3VzIGRpc2N1c3Npb25zLCB3ZSB0aG91Z2h0IGFib3V0IG1ha2luZyBJT1RMQiBmbHVzaApp
bmNsdXNpdmUsIHdoZXJlIElPVExCIGZsdXNoIHdvdWxkIGFsd2F5cyBpbmNsdWRlIGRldmljZSBU
TEIgZmx1c2guIEJ1dAp3ZSB0aG91Z2h0IHN1Y2ggYmVoYXZpb3IgY2Fubm90IGJlIGFzc3VtZWQg
Zm9yIGFsbCBWTU1zLCBzb21lIG1heSBzdGlsbApkbyBleHBsaWNpdCBkZXYgVExCIGZsdXNoLiBT
byBmb3IgY29tcGxldGVuZXNzLCB3ZSBpbmNsdWRlZCBkZXYgVExCCmhlcmUuCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdApp
b21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
