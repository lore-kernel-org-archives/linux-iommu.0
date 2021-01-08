Return-Path: <SRS0=te8u=GL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_RED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C736FC433DB
	for <iommu@archiver.kernel.org>; Fri,  8 Jan 2021 00:00:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 729B9236F9
	for <iommu@archiver.kernel.org>; Fri,  8 Jan 2021 00:00:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 729B9236F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 117A786CBF;
	Fri,  8 Jan 2021 00:00:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WmhzZchhiAIo; Fri,  8 Jan 2021 00:00:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id F423186CC5;
	Fri,  8 Jan 2021 00:00:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8072C0891;
	Fri,  8 Jan 2021 00:00:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A8BEC013A
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 00:00:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id F29DF86FC6
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 00:00:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wkBiXU8eUfLk for <iommu@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 00:00:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B092F86FA6
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 00:00:05 +0000 (UTC)
IronPort-SDR: 9QA/YRcXyeTHO9YILoWpi0YhQRaHAuZb49pGJaCeSfkXZUPHE7jwJ/yZLBRf18C3UWlZf1oadh
 44ocsoOvis9Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9857"; a="177614817"
X-IronPort-AV: E=Sophos;i="5.79,330,1602572400"; d="scan'208";a="177614817"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jan 2021 16:00:04 -0800
IronPort-SDR: 6JFQMRWF/KBXXX0hd/QgIrgA7QCfQXw80JWsEERH3iTsHJHY72M1OCYy4cu7O0i0qi74F2aSQI
 XHWEnKaPTtcA==
X-IronPort-AV: E=Sophos;i="5.79,330,1602572400"; d="scan'208";a="379909949"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.255.31.120])
 ([10.255.31.120])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jan 2021 16:00:02 -0800
Subject: Re: [PATCH 3/5] iommu/vt-d: Remove unused dma map/unmap trace events
To: Will Deacon <will@kernel.org>
References: <20201231005323.2178523-1-baolu.lu@linux.intel.com>
 <20201231005323.2178523-3-baolu.lu@linux.intel.com>
 <20210105190443.GB12182@willie-the-truck>
 <8bf33c93-3154-e832-1197-891c684d6ded@linux.intel.com>
 <20210107144049.GB3413@willie-the-truck>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <ab546a36-2403-f400-a354-edfd21795e0d@linux.intel.com>
Date: Fri, 8 Jan 2021 08:00:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210107144049.GB3413@willie-the-truck>
Content-Language: en-US
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SGkgV2lsbCwKCk9uIDIwMjEvMS83IDIyOjQwLCBXaWxsIERlYWNvbiB3cm90ZToKPiBPbiBXZWQs
IEphbiAwNiwgMjAyMSBhdCAwOToxNDoyMkFNICswODAwLCBMdSBCYW9sdSB3cm90ZToKPj4gT24g
MjAyMS8xLzYgMzowNCwgV2lsbCBEZWFjb24gd3JvdGU6Cj4+PiBPbiBUaHUsIERlYyAzMSwgMjAy
MCBhdCAwODo1MzoyMUFNICswODAwLCBMdSBCYW9sdSB3cm90ZToKPj4+PiBXaXRoIGNvbW1pdCBj
NTg4MDcyYmJhNmI1ICgiaW9tbXUvdnQtZDogQ29udmVydCBpbnRlbCBpb21tdSBkcml2ZXIgdG8K
Pj4+PiB0aGUgaW9tbXUgb3BzIiksIHRoZSB0cmFjZSBldmVudHMgZm9yIGRtYSBtYXAvdW5tYXAg
aGF2ZSBubyB1c2VycyBhbnkKPj4+PiBtb3JlLiBSZW1vdmUgdGhlbSBzbyB0aGF0IHRoZXkgZG9u
J3Qgc2hvdyB1cCB1bmRlcgo+Pj4+IC9zeXMva2VybmVsL2RlYnVnL3RyYWNpbmcvZXZlbnRzL2lu
dGVsX2lvbW11LiBUaGUgdXNlcnMgc2hvdWxkIHVzZSB0aGUKPj4+PiBtYXAvdW5tYXAgdHJhY2Vz
IGRlZmluZWQgaW4gdGhlIGlvbW11IGNvcmUgZnJvbSBub3cgb24uCj4+Pj4KPj4+PiBGaXhlczog
YzU4ODA3MmJiYTZiNSAoImlvbW11L3Z0LWQ6IENvbnZlcnQgaW50ZWwgaW9tbXUgZHJpdmVyIHRv
IHRoZSBpb21tdSBvcHMiKQo+Pj4+IFNpZ25lZC1vZmYtYnk6IEx1IEJhb2x1IDxiYW9sdS5sdUBs
aW51eC5pbnRlbC5jb20+Cj4+Pj4gLS0tCj4+Pj4gICAgaW5jbHVkZS90cmFjZS9ldmVudHMvaW50
ZWxfaW9tbXUuaCB8IDExOSAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+Pj4+ICAgIDEg
ZmlsZSBjaGFuZ2VkLCAxMTkgZGVsZXRpb25zKC0pCj4+Pgo+Pj4gSXMgdGhpcyBuZWVkZWQgaW4g
NS4xMSwgb3IgY2FuIGl0IHdhaXQgdW50aWwgNS4xMj8KPj4KPj4gSXQncyBuZWNlc3NhcnkgZm9y
IDUuMTEgYXMgZmFyIGFzIEkgY2FuIHNlZS4gV2l0aG91dCB0aGlzLCB1c2VycyBzdGlsbAo+PiBz
ZWUgdGhlIGV2ZW50cyB1bmRlciAvc3lzL2tlcm5lbC9kZWJ1Zy90cmFjaW5nL2V2ZW50cy9pbnRl
bF9pb21tdSwgYnV0Cj4+IHRoZXkgd2lsbCBnZXQgbm90aGluZyB0cmFjZWQgZXZlbiB0aGV5IGVu
YWJsZSB0aGUgZXZlbnRzLgo+IAo+IEknbSBqdXN0IGEgYml0IHdhcnkgYWJvdXQgYnJlYWtpbmcg
dXNlcnNwYWNlIGJ5IHJlbW92aW5nIHRoZW0gYWx0b2dldGhlciwKPiBhbHRob3VnaCBJIHNlZSB0
aGF0IHRoZXJlJ3MgcGxlbnR5IG9mIHByZWNlZGVudCBmb3IgcmVtb3ZpbmcgZXZlbnRzIGZyb20K
PiB0aGUgaW5jbHVkZS90cmFjZS9ldmVudHMgZGlyZWN0b3J5LCBzbyBpdCdzIHByb2JhYmx5IGZp
bmUuCj4gCj4gSG93ZXZlciwgdGhlIHBhdGNoIGFzLWlzIHJlc3VsdHMgaW4gdGhpcyB3YXJuaW5n
IGZvciBtZToKPiAKPiAgIHwgSW4gZmlsZSBpbmNsdWRlZCBmcm9tIGluY2x1ZGUvdHJhY2UvZGVm
aW5lX3RyYWNlLmg6MTAyLAo+ICAgfCAgICAgICAgICAgICAgICAgIGZyb20gaW5jbHVkZS90cmFj
ZS9ldmVudHMvaW50ZWxfaW9tbXUuaDoyMiwKPiAgIHwgICAgICAgICAgICAgICAgICBmcm9tIGRy
aXZlcnMvaW9tbXUvaW50ZWwvdHJhY2UuYzoxNDoKPiAgIHwgaW5jbHVkZS90cmFjZS90cmFjZV9l
dmVudHMuaDoyNzoyMzogd2FybmluZzog4oCYc3RyX19pbnRlbF9pb21tdV9fdHJhY2Vfc3lzdGVt
X25hbWXigJkgZGVmaW5lZCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWNvbnN0LXZhcmlhYmxlPV0K
PiAgIHwgICAgMjcgfCAjZGVmaW5lIF9fYXBwX18oeCwgeSkgc3RyX18jI3gjI3kKPiAgIHwgICAg
ICAgfCAgICAgICAgICAgICAgICAgICAgICAgXn5+fn4KPiAgIHwgaW5jbHVkZS90cmFjZS90cmFj
ZV9ldmVudHMuaDoyODoyMTogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKAmF9fYXBwX1/i
gJkKPiAgIHwgICAgMjggfCAjZGVmaW5lIF9fYXBwKHgsIHkpIF9fYXBwX18oeCwgeSkKPiAgIHwg
ICAgICAgfCAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn4KPiAgIHwgaW5jbHVkZS90cmFjZS90
cmFjZV9ldmVudHMuaDozMDoyOTogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKAmF9fYXBw
4oCZCj4gICB8ICAgIDMwIHwgI2RlZmluZSBUUkFDRV9TWVNURU1fU1RSSU5HIF9fYXBwKFRSQUNF
X1NZU1RFTV9WQVIsX190cmFjZV9zeXN0ZW1fbmFtZSkKPiAgIHwgICAgICAgfCAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgXn5+fn4KPiAgIHwgaW5jbHVkZS90cmFjZS90cmFjZV9ldmVudHMu
aDozMzoyMDogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKAmFRSQUNFX1NZU1RFTV9TVFJJ
TkfigJkKPiAgIHwgICAgMzMgfCAgc3RhdGljIGNvbnN0IGNoYXIgVFJBQ0VfU1lTVEVNX1NUUklO
R1tdID0gXAo+ICAgfCAgICAgICB8ICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+
fn5+Cj4gICB8IGluY2x1ZGUvdHJhY2UvdHJhY2VfZXZlbnRzLmg6MzY6MTogbm90ZTogaW4gZXhw
YW5zaW9uIG9mIG1hY3JvIOKAmFRSQUNFX01BS0VfU1lTVEVNX1NUUuKAmQo+ICAgfCAgICAzNiB8
IFRSQUNFX01BS0VfU1lTVEVNX1NUUigpOwo+ICAgfCAgICAgICB8IF5+fn5+fn5+fn5+fn5+fn5+
fn5+fgo+IAo+IHNvIEknbGwgZHJvcCB0aGlzIGZvciBub3cuCgpPa2F5LCBJIHdpbGwgcmV3b3Jr
IHRoaXMuIFRoYW5rcyEKCj4gCj4gV2lsbAo+IAoKQmVzdCByZWdhcmRzLApiYW9sdQpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxp
c3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
