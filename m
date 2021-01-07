Return-Path: <SRS0=iLvA=GK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_RED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DE2C433DB
	for <iommu@archiver.kernel.org>; Thu,  7 Jan 2021 14:40:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93C382311E
	for <iommu@archiver.kernel.org>; Thu,  7 Jan 2021 14:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93C382311E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5AAFB2746F;
	Thu,  7 Jan 2021 14:40:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zk4n0M63g0ko; Thu,  7 Jan 2021 14:40:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6B82C20464;
	Thu,  7 Jan 2021 14:40:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4F50AC088B;
	Thu,  7 Jan 2021 14:40:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1FDD7C013A
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 14:40:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0A1F68692E
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 14:40:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 18mqxFVghEmO for <iommu@lists.linux-foundation.org>;
 Thu,  7 Jan 2021 14:40:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7F22D86868
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 14:40:55 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id CBB6C22EBF;
 Thu,  7 Jan 2021 14:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610030455;
 bh=7xoap/F3JQH2zdQsxbhjQZFUy8PtJsSlYU5ujJ5re/g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=V4wQO1s3j6VY3fYuP2lfIcRxjVy/Hq9nglrO4dstJOWHliufituRvbOMyEKC3VKOO
 FALFeX2v3Uq8zhORbR+tXXwLi2UAruT572SCKW9i7MwstPDqCKLe2WEAz3JbWMl9f0
 81xVdHhntoR2cpbtLNMlstavXdbCkzf7vZCFAOI+d+TBKsf32RQkja0DVJyTbXPWqJ
 EJh8kwMpsXZNDdoOunw+kZoKKY3KL7+ZoAyvKqiBoHdmmX78/WEQq+16f2jXaahOJZ
 NwPEKY5T5BZSkk04Z3mCVlUUWSZHJMgYtYv0T6OkwC38sUHIEm5ESf2clVEtR/JRHJ
 jtdX2Eo6X9fXA==
Date: Thu, 7 Jan 2021 14:40:50 +0000
From: Will Deacon <will@kernel.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 3/5] iommu/vt-d: Remove unused dma map/unmap trace events
Message-ID: <20210107144049.GB3413@willie-the-truck>
References: <20201231005323.2178523-1-baolu.lu@linux.intel.com>
 <20201231005323.2178523-3-baolu.lu@linux.intel.com>
 <20210105190443.GB12182@willie-the-truck>
 <8bf33c93-3154-e832-1197-891c684d6ded@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8bf33c93-3154-e832-1197-891c684d6ded@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Guo Kaijie <Kaijie.Guo@intel.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gV2VkLCBKYW4gMDYsIDIwMjEgYXQgMDk6MTQ6MjJBTSArMDgwMCwgTHUgQmFvbHUgd3JvdGU6
Cj4gT24gMjAyMS8xLzYgMzowNCwgV2lsbCBEZWFjb24gd3JvdGU6Cj4gPiBPbiBUaHUsIERlYyAz
MSwgMjAyMCBhdCAwODo1MzoyMUFNICswODAwLCBMdSBCYW9sdSB3cm90ZToKPiA+ID4gV2l0aCBj
b21taXQgYzU4ODA3MmJiYTZiNSAoImlvbW11L3Z0LWQ6IENvbnZlcnQgaW50ZWwgaW9tbXUgZHJp
dmVyIHRvCj4gPiA+IHRoZSBpb21tdSBvcHMiKSwgdGhlIHRyYWNlIGV2ZW50cyBmb3IgZG1hIG1h
cC91bm1hcCBoYXZlIG5vIHVzZXJzIGFueQo+ID4gPiBtb3JlLiBSZW1vdmUgdGhlbSBzbyB0aGF0
IHRoZXkgZG9uJ3Qgc2hvdyB1cCB1bmRlcgo+ID4gPiAvc3lzL2tlcm5lbC9kZWJ1Zy90cmFjaW5n
L2V2ZW50cy9pbnRlbF9pb21tdS4gVGhlIHVzZXJzIHNob3VsZCB1c2UgdGhlCj4gPiA+IG1hcC91
bm1hcCB0cmFjZXMgZGVmaW5lZCBpbiB0aGUgaW9tbXUgY29yZSBmcm9tIG5vdyBvbi4KPiA+ID4g
Cj4gPiA+IEZpeGVzOiBjNTg4MDcyYmJhNmI1ICgiaW9tbXUvdnQtZDogQ29udmVydCBpbnRlbCBp
b21tdSBkcml2ZXIgdG8gdGhlIGlvbW11IG9wcyIpCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEx1IEJh
b2x1IDxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+Cj4gPiA+IC0tLQo+ID4gPiAgIGluY2x1ZGUv
dHJhY2UvZXZlbnRzL2ludGVsX2lvbW11LmggfCAxMTkgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0KPiA+ID4gICAxIGZpbGUgY2hhbmdlZCwgMTE5IGRlbGV0aW9ucygtKQo+ID4gCj4gPiBJ
cyB0aGlzIG5lZWRlZCBpbiA1LjExLCBvciBjYW4gaXQgd2FpdCB1bnRpbCA1LjEyPwo+IAo+IEl0
J3MgbmVjZXNzYXJ5IGZvciA1LjExIGFzIGZhciBhcyBJIGNhbiBzZWUuIFdpdGhvdXQgdGhpcywg
dXNlcnMgc3RpbGwKPiBzZWUgdGhlIGV2ZW50cyB1bmRlciAvc3lzL2tlcm5lbC9kZWJ1Zy90cmFj
aW5nL2V2ZW50cy9pbnRlbF9pb21tdSwgYnV0Cj4gdGhleSB3aWxsIGdldCBub3RoaW5nIHRyYWNl
ZCBldmVuIHRoZXkgZW5hYmxlIHRoZSBldmVudHMuCgpJJ20ganVzdCBhIGJpdCB3YXJ5IGFib3V0
IGJyZWFraW5nIHVzZXJzcGFjZSBieSByZW1vdmluZyB0aGVtIGFsdG9nZXRoZXIsCmFsdGhvdWdo
IEkgc2VlIHRoYXQgdGhlcmUncyBwbGVudHkgb2YgcHJlY2VkZW50IGZvciByZW1vdmluZyBldmVu
dHMgZnJvbQp0aGUgaW5jbHVkZS90cmFjZS9ldmVudHMgZGlyZWN0b3J5LCBzbyBpdCdzIHByb2Jh
Ymx5IGZpbmUuCgpIb3dldmVyLCB0aGUgcGF0Y2ggYXMtaXMgcmVzdWx0cyBpbiB0aGlzIHdhcm5p
bmcgZm9yIG1lOgoKIHwgSW4gZmlsZSBpbmNsdWRlZCBmcm9tIGluY2x1ZGUvdHJhY2UvZGVmaW5l
X3RyYWNlLmg6MTAyLAogfCAgICAgICAgICAgICAgICAgIGZyb20gaW5jbHVkZS90cmFjZS9ldmVu
dHMvaW50ZWxfaW9tbXUuaDoyMiwKIHwgICAgICAgICAgICAgICAgICBmcm9tIGRyaXZlcnMvaW9t
bXUvaW50ZWwvdHJhY2UuYzoxNDoKIHwgaW5jbHVkZS90cmFjZS90cmFjZV9ldmVudHMuaDoyNzoy
Mzogd2FybmluZzog4oCYc3RyX19pbnRlbF9pb21tdV9fdHJhY2Vfc3lzdGVtX25hbWXigJkgZGVm
aW5lZCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWNvbnN0LXZhcmlhYmxlPV0KIHwgICAgMjcgfCAj
ZGVmaW5lIF9fYXBwX18oeCwgeSkgc3RyX18jI3gjI3kKIHwgICAgICAgfCAgICAgICAgICAgICAg
ICAgICAgICAgXn5+fn4KIHwgaW5jbHVkZS90cmFjZS90cmFjZV9ldmVudHMuaDoyODoyMTogbm90
ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKAmF9fYXBwX1/igJkKIHwgICAgMjggfCAjZGVmaW5l
IF9fYXBwKHgsIHkpIF9fYXBwX18oeCwgeSkKIHwgICAgICAgfCAgICAgICAgICAgICAgICAgICAg
IF5+fn5+fn4KIHwgaW5jbHVkZS90cmFjZS90cmFjZV9ldmVudHMuaDozMDoyOTogbm90ZTogaW4g
ZXhwYW5zaW9uIG9mIG1hY3JvIOKAmF9fYXBw4oCZCiB8ICAgIDMwIHwgI2RlZmluZSBUUkFDRV9T
WVNURU1fU1RSSU5HIF9fYXBwKFRSQUNFX1NZU1RFTV9WQVIsX190cmFjZV9zeXN0ZW1fbmFtZSkK
IHwgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn4KIHwgaW5jbHVkZS90
cmFjZS90cmFjZV9ldmVudHMuaDozMzoyMDogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKA
mFRSQUNFX1NZU1RFTV9TVFJJTkfigJkKIHwgICAgMzMgfCAgc3RhdGljIGNvbnN0IGNoYXIgVFJB
Q0VfU1lTVEVNX1NUUklOR1tdID0gXAogfCAgICAgICB8ICAgICAgICAgICAgICAgICAgICBefn5+
fn5+fn5+fn5+fn5+fn5+CiB8IGluY2x1ZGUvdHJhY2UvdHJhY2VfZXZlbnRzLmg6MzY6MTogbm90
ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKAmFRSQUNFX01BS0VfU1lTVEVNX1NUUuKAmQogfCAg
ICAzNiB8IFRSQUNFX01BS0VfU1lTVEVNX1NUUigpOwogfCAgICAgICB8IF5+fn5+fn5+fn5+fn5+
fn5+fn5+fgoKc28gSSdsbCBkcm9wIHRoaXMgZm9yIG5vdy4KCldpbGwKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
