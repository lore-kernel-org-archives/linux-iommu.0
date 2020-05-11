Return-Path: <SRS0=Mzfx=6Z=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F77C47255
	for <iommu@archiver.kernel.org>; Mon, 11 May 2020 11:14:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C36720736
	for <iommu@archiver.kernel.org>; Mon, 11 May 2020 11:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="mVVHgVBH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C36720736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7BC4D86A44;
	Mon, 11 May 2020 11:14:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KSJmVtJtjKO4; Mon, 11 May 2020 11:14:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 741CD86982;
	Mon, 11 May 2020 11:14:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58BACC0178;
	Mon, 11 May 2020 11:14:27 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EACC8C016F
 for <iommu@lists.linux-foundation.org>; Mon, 11 May 2020 11:14:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E0420888FC
 for <iommu@lists.linux-foundation.org>; Mon, 11 May 2020 11:14:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i5NBl+07Qsii for <iommu@lists.linux-foundation.org>;
 Mon, 11 May 2020 11:14:25 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail26.static.mailgun.info (mail26.static.mailgun.info
 [104.130.122.26])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9F68788912
 for <iommu@lists.linux-foundation.org>; Mon, 11 May 2020 11:14:22 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1589195664; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: References: Cc: To: From:
 Subject: Sender; bh=9u8N99k1vcfk6hizX5mCjz6icu5JY2q9ybf2Dfz1tcs=;
 b=mVVHgVBHr+PhPr2BDS8vUZl6+B+9Tiv73CWum7dsEkCbcYpYnzK43EH+TNF6P2yJf6PYW8JD
 yhGKsp3wWa5RppKMynqai1gbY9uYcHxKe6scYVZ3xdNxNhf18W0gqCEePC+LekNXMXCnFLhx
 0t008q11atnojouuX3b6yaoJ890=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb93385.7fe5fd58a6f8-smtp-out-n05;
 Mon, 11 May 2020 11:14:13 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id E0AACC43637; Mon, 11 May 2020 11:14:12 +0000 (UTC)
Received: from [192.168.0.104] (unknown [103.248.210.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: vjitta)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 982BAC433F2;
 Mon, 11 May 2020 11:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 982BAC433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=vjitta@codeaurora.org
Subject: Re: [PATCH] iommu/iova: Retry from last rb tree node if iova search
 fails
From: Vijayanand Jitta <vjitta@codeaurora.org>
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <1588795317-20879-1-git-send-email-vjitta@codeaurora.org>
 <d9bfde9f-8f16-bf1b-311b-ea6c2b8ab93d@arm.com>
 <b80fdf37-e635-2d65-c523-8e1d0bd8085b@codeaurora.org>
Message-ID: <821c666b-ddf8-8b5c-1e8c-69a06ae1c727@codeaurora.org>
Date: Mon, 11 May 2020 16:44:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <b80fdf37-e635-2d65-c523-8e1d0bd8085b@codeaurora.org>
Content-Language: en-GB
Cc: vinmenon@codeaurora.org, kernel-team@android.com
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

CgpPbiA1LzkvMjAyMCAxMjoyNSBBTSwgVmlqYXlhbmFuZCBKaXR0YSB3cm90ZToKPiAKPiAKPiBP
biA1LzcvMjAyMCA2OjU0IFBNLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+IE9uIDIwMjAtMDUtMDYg
OTowMSBwbSwgdmppdHRhQGNvZGVhdXJvcmEub3JnIHdyb3RlOgo+Pj4gRnJvbTogVmlqYXlhbmFu
ZCBKaXR0YSA8dmppdHRhQGNvZGVhdXJvcmEub3JnPgo+Pj4KPj4+IFdoZW4gZXZlciBhIG5ldyBp
b3ZhIGFsbG9jIHJlcXVlc3QgY29tZXMgaW92YSBpcyBhbHdheXMgc2VhcmNoZWQKPj4+IGZyb20g
dGhlIGNhY2hlZCBub2RlIGFuZCB0aGUgbm9kZXMgd2hpY2ggYXJlIHByZXZpb3VzIHRvIGNhY2hl
ZAo+Pj4gbm9kZS4gU28sIGV2ZW4gaWYgdGhlcmUgaXMgZnJlZSBpb3ZhIHNwYWNlIGF2YWlsYWJs
ZSBpbiB0aGUgbm9kZXMKPj4+IHdoaWNoIGFyZSBuZXh0IHRvIHRoZSBjYWNoZWQgbm9kZSBpb3Zh
IGFsbG9jYXRpb24gY2FuIHN0aWxsIGZhaWwKPj4+IGJlY2F1c2Ugb2YgdGhpcyBhcHByb2FjaC4K
Pj4+Cj4+PiBDb25zaWRlciB0aGUgZm9sbG93aW5nIHNlcXVlbmNlIG9mIGlvdmEgYWxsb2MgYW5k
IGZyZWVzIG9uCj4+PiAxR0Igb2YgaW92YSBzcGFjZQo+Pj4KPj4+IDEpIGFsbG9jIC0gNTAwTUIK
Pj4+IDIpIGFsbG9jIC0gMTJNQgo+Pj4gMykgYWxsb2MgLSA0OTlNQgo+Pj4gNCkgZnJlZSAtwqAg
MTJNQiB3aGljaCB3YXMgYWxsb2NhdGVkIGluIHN0ZXAgMgo+Pj4gNSkgYWxsb2MgLSAxM01CCj4+
Pgo+Pj4gQWZ0ZXIgdGhlIGFib3ZlIHNlcXVlbmNlIHdlIHdpbGwgaGF2ZSAxMk1CIG9mIGZyZWUg
aW92YSBzcGFjZSBhbmQKPj4+IGNhY2hlZCBub2RlIHdpbGwgYmUgcG9pbnRpbmcgdG8gdGhlIGlv
dmEgcGZuIG9mIGxhc3QgYWxsb2Mgb2YgMTNNQgo+Pj4gd2hpY2ggd2lsbCBiZSB0aGUgbG93ZXN0
IGlvdmEgcGZuIG9mIHRoYXQgaW92YSBzcGFjZS4gTm93IGlmIHdlIGdldCBhbgo+Pj4gYWxsb2Mg
cmVxdWVzdCBvZiAyTUIgd2UganVzdCBzZWFyY2ggZnJvbSBjYWNoZWQgbm9kZSBhbmQgdGhlbiBs
b29rCj4+PiBmb3IgbG93ZXIgaW92YSBwZm4ncyBmb3IgZnJlZSBpb3ZhIGFuZCBhcyB0aGV5IGFy
ZW4ndCBhbnksIGlvdmEgYWxsb2MKPj4+IGZhaWxzIHRob3VnaCB0aGVyZSBpcyAxMk1CIG9mIGZy
ZWUgaW92YSBzcGFjZS4KPj4KPj4gWXVwLCB0aGlzIGNvdWxkIGRlZmluaXRlbHkgZG8gd2l0aCBp
bXByb3ZpbmcuIFVuZm9ydHVuYXRlbHkgSSB0aGluayB0aGlzCj4+IHBhcnRpY3VsYXIgaW1wbGVt
ZW50YXRpb24gaXMgc2xpZ2h0bHkgZmxhd2VkLi4uCj4+Cj4+PiBUbyBhdm9pZCBzdWNoIGlvdmEg
c2VhcmNoIGZhaWx1cmVzIGRvIGEgcmV0cnkgZnJvbSB0aGUgbGFzdCByYiB0cmVlIG5vZGUKPj4+
IHdoZW4gaW92YSBzZWFyY2ggZmFpbHMsIHRoaXMgd2lsbCBzZWFyY2ggdGhlIGVudGlyZSB0cmVl
IGFuZCBnZXQgYW4gaW92YQo+Pj4gaWYgaXRzIGF2YWlsYWJsZQo+Pj4KPj4+IFNpZ25lZC1vZmYt
Ynk6IFZpamF5YW5hbmQgSml0dGEgPHZqaXR0YUBjb2RlYXVyb3JhLm9yZz4KPj4+IC0tLQo+Pj4g
wqAgZHJpdmVycy9pb21tdS9pb3ZhLmMgfCAxMSArKysrKysrKysrKwo+Pj4gwqAgMSBmaWxlIGNo
YW5nZWQsIDExIGluc2VydGlvbnMoKykKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21t
dS9pb3ZhLmMgYi9kcml2ZXJzL2lvbW11L2lvdmEuYwo+Pj4gaW5kZXggMGU2YTk1My4uMjk4NTIy
MiAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW92YS5jCj4+PiArKysgYi9kcml2ZXJz
L2lvbW11L2lvdmEuYwo+Pj4gQEAgLTE4Niw2ICsxODYsNyBAQCBzdGF0aWMgaW50IF9fYWxsb2Nf
YW5kX2luc2VydF9pb3ZhX3JhbmdlKHN0cnVjdAo+Pj4gaW92YV9kb21haW4gKmlvdmFkLAo+Pj4g
wqDCoMKgwqDCoCB1bnNpZ25lZCBsb25nIGZsYWdzOwo+Pj4gwqDCoMKgwqDCoCB1bnNpZ25lZCBs
b25nIG5ld19wZm47Cj4+PiDCoMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcgYWxpZ25fbWFzayA9IH4w
VUw7Cj4+PiArwqDCoMKgIGJvb2wgcmV0cnkgPSBmYWxzZTsKPj4+IMKgIMKgwqDCoMKgwqAgaWYg
KHNpemVfYWxpZ25lZCkKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBhbGlnbl9tYXNrIDw8PSBmbHNf
bG9uZyhzaXplIC0gMSk7Cj4+PiBAQCAtMTk4LDYgKzE5OSw4IEBAIHN0YXRpYyBpbnQgX19hbGxv
Y19hbmRfaW5zZXJ0X2lvdmFfcmFuZ2Uoc3RydWN0Cj4+PiBpb3ZhX2RvbWFpbiAqaW92YWQsCj4+
PiDCoCDCoMKgwqDCoMKgIGN1cnIgPSBfX2dldF9jYWNoZWRfcmJub2RlKGlvdmFkLCBsaW1pdF9w
Zm4pOwo+Pj4gwqDCoMKgwqDCoCBjdXJyX2lvdmEgPSByYl9lbnRyeShjdXJyLCBzdHJ1Y3QgaW92
YSwgbm9kZSk7Cj4+PiArCj4+PiArcmV0cnlfc2VhcmNoOgo+Pj4gwqDCoMKgwqDCoCBkbyB7Cj4+
PiDCoMKgwqDCoMKgwqDCoMKgwqAgbGltaXRfcGZuID0gbWluKGxpbWl0X3BmbiwgY3Vycl9pb3Zh
LT5wZm5fbG8pOwo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIG5ld19wZm4gPSAobGltaXRfcGZuIC0g
c2l6ZSkgJiBhbGlnbl9tYXNrOwo+Pj4gQEAgLTIwNyw2ICsyMTAsMTQgQEAgc3RhdGljIGludCBf
X2FsbG9jX2FuZF9pbnNlcnRfaW92YV9yYW5nZShzdHJ1Y3QKPj4+IGlvdmFfZG9tYWluICppb3Zh
ZCwKPj4+IMKgwqDCoMKgwqAgfSB3aGlsZSAoY3VyciAmJiBuZXdfcGZuIDw9IGN1cnJfaW92YS0+
cGZuX2hpKTsKPj4+IMKgIMKgwqDCoMKgwqAgaWYgKGxpbWl0X3BmbiA8IHNpemUgfHwgbmV3X3Bm
biA8IGlvdmFkLT5zdGFydF9wZm4pIHsKPj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoIXJldHJ5KSB7
Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjdXJyID0gcmJfbGFzdCgmaW92YWQtPnJicm9v
dCk7Cj4+Cj4+IFdoeSB3YWxrIHdoZW4gdGhlcmUncyBhbiBhbmNob3Igbm9kZSB0aGVyZSBhbHJl
YWR5PyBIb3dldmVyLi4uCj4+Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjdXJyX2lvdmEg
PSByYl9lbnRyeShjdXJyLCBzdHJ1Y3QgaW92YSwgbm9kZSk7Cj4+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBsaW1pdF9wZm4gPSBjdXJyX2lvdmEtPnBmbl9sbzsKPj4KPj4gLi4udGhpcyBkb2Vz
bid0IGxvb2sgcmlnaHQsIGFzIGJ5IG5vdyB3ZSd2ZSBsb3N0IHRoZSBvcmlnaW5hbCBsaW1pdF9w
Zm4KPj4gc3VwcGxpZWQgYnkgdGhlIGNhbGxlciwgc28gYXJlIGhpZ2hseSBsaWtlbHkgdG8gYWxs
b2NhdGUgYmV5b25kIHRoZQo+PiByYW5nZSBvdXIgY2FsbGVyIGFza2VkIGZvci4gSW4gZmFjdCBB
RkFJQ1Mgd2UnZCBzdGFydCBhbGxvY2F0aW5nIGZyb20KPj4gZGlyZWN0bHkgZGlyZWN0bHkgYmVs
b3cgdGhlIGFuY2hvciBub2RlLCBiZXlvbmQgdGhlIGVuZCBvZiB0aGUgZW50aXJlCj4+IGFkZHJl
c3Mgc3BhY2UuCj4+Cj4+IFRoZSBsb2dpYyBJIHdhcyBpbWFnaW5pbmcgd2Ugd2FudCBoZXJlIHdh
cyBzb21ldGhpbmcgbGlrZSB0aGUgcmFwaWRseQo+PiBoYWNrZWQgdXAgKGFuZCB1bnRlc3RlZCkg
ZGlmZiBiZWxvdy4KPj4KPj4gVGhhbmtzLAo+PiBSb2Jpbi4KPj4KPiAKPiBUaGFua3MgZm9yIHlv
dXIgY29tbWVudHMgLEkgaGF2ZSBnb25lIHRocm91Z2ggYmVsb3cgbG9naWMgYW5kIEkgc2VlIHNv
bWUKPiBpc3N1ZSB3aXRoIHJldHJ5IGNoZWNrIGFzIHRoZXJlIGNvdWxkIGJlIGNhc2Ugd2hlcmUg
YWxsb2NfbG8gaXMgc2V0IHRvCj4gc29tZSBwZm4gb3RoZXIgdGhhbiBzdGFydF9wZm4gaW4gdGhh
dCBjYXNlIHdlIGRvbid0IHJldHJ5IGFuZCB0aGVyZSBjYW4KPiBzdGlsbCBiZSBpb3ZhIGF2YWls
YWJsZS4gSSB1bmRlcnN0YW5kIGl0cyBhIGhhY2tlZCB1cCB2ZXJzaW9uLCBJIGNhbgo+IHdvcmsg
b24gdGhpcy4KPiAKPiBCdXQgaG93IGFib3V0IHdlIGp1c3Qgc3RvcmUgbGltaXRfcGZuIGFuZCBn
ZXQgdGhlIG5vZGUgdXNpbmcgdGhhdCBhbmQKPiByZXRyeSBmb3Igb25jZSBmcm9tIHRoYXQgbm9k
ZSwgaXQgd291bGQgYmUgc2ltaWxhciB0byBteSBwYXRjaCBqdXN0Cj4gY29ycmVjdGluZyB0aGUg
Y3VyciBub2RlIGFuZCBsaW1pdF9wZm4gdXBkYXRlIGluIHJldHJ5IGNoZWNrLiBkbyB5b3Ugc2Vl
Cj4gYW55IGlzc3VlIHdpdGggdGhpcyBhcHByb2FjaCA/Cj4gCj4gCj4gVGhhbmtzLAo+IFZpamF5
LgoKSSBmb3VuZCBvbmUgaXNzdWUgd2l0aCBteSBlYXJsaWVyIGFwcHJvYWNoLCB3aGVyZSB3ZSBz
ZWFyY2ggdHdpY2UgZnJvbQpjYWNoZWQgbm9kZSB0byB0aGUgc3RhcnRfcGZuLCB0aGlzIGNhbiBi
ZSBhdm9pZGVkIGlmIHdlIHN0b3JlIHRoZSBwZm5faGkKb2YgdGhlIGNhY2hlZCBub2RlIG1ha2Ug
dGhpcyBhcyBhbGxvY19sbyB3aGVuIHdlIHJldHJ5LiBJIHNlZSB0aGUgYmVsb3cKZGlmZiBhbHNv
IGRvZXMgdGhlIHNhbWUsIEkgaGF2ZSBwb3N0ZWQgdjIgdmVyc2lvbiBvZiB0aGUgcGF0Y2ggYWZ0
ZXIKZ29pbmcgdGhyb3VnaCB0aGUgY29tbWVudHMgYW5kIHRoZSBiZWxvdyBkaWZmLiBjYW4geW91
IHBsZWFzZSByZXZpZXcgdGhhdC4KClRoYW5rcywKVmlqYXkKPj4gLS0tLS0+OC0tLS0tCj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2lvdmEuYyBiL2RyaXZlcnMvaW9tbXUvaW92YS5jCj4+
IGluZGV4IDBlNmE5NTM2ZWNhNi4uMzU3NGMxOTI3MmQ2IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJz
L2lvbW11L2lvdmEuYwo+PiArKysgYi9kcml2ZXJzL2lvbW11L2lvdmEuYwo+PiBAQCAtMTg2LDYg
KzE4Niw3IEBAIHN0YXRpYyBpbnQgX19hbGxvY19hbmRfaW5zZXJ0X2lvdmFfcmFuZ2Uoc3RydWN0
Cj4+IGlvdmFfZG9tYWluICppb3ZhZCwKPj4gwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZyBm
bGFnczsKPj4gwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZyBuZXdfcGZuOwo+PiDCoMKgwqDC
oMKgwqDCoCB1bnNpZ25lZCBsb25nIGFsaWduX21hc2sgPSB+MFVMOwo+PiArwqDCoMKgwqDCoMKg
IHVuc2lnbmVkIGxvbmcgYWxsb2NfaGksIGFsbG9jX2xvOwo+Pgo+PiDCoMKgwqDCoMKgwqDCoCBp
ZiAoc2l6ZV9hbGlnbmVkKQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYWxpZ25f
bWFzayA8PD0gZmxzX2xvbmcoc2l6ZSAtIDEpOwo+PiBAQCAtMTk2LDE3ICsxOTcsMjcgQEAgc3Rh
dGljIGludCBfX2FsbG9jX2FuZF9pbnNlcnRfaW92YV9yYW5nZShzdHJ1Y3QKPj4gaW92YV9kb21h
aW4gKmlvdmFkLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHNpemUgPj0gaW92YWQtPm1heDMyX2FsbG9jX3NpemUpCj4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBnb3RvIGlvdmEzMl9mdWxsOwo+Pgo+PiArwqDCoMKgwqDCoMKgIGFsbG9j
X2hpID0gSU9WQV9BTkNIT1I7Cj4+ICvCoMKgwqDCoMKgwqAgYWxsb2NfbG8gPSBpb3ZhZC0+c3Rh
cnRfcGZuOwo+PiArcmV0cnk6Cj4+IMKgwqDCoMKgwqDCoMKgIGN1cnIgPSBfX2dldF9jYWNoZWRf
cmJub2RlKGlvdmFkLCBsaW1pdF9wZm4pOwo+PiDCoMKgwqDCoMKgwqDCoCBjdXJyX2lvdmEgPSBy
Yl9lbnRyeShjdXJyLCBzdHJ1Y3QgaW92YSwgbm9kZSk7Cj4+ICvCoMKgwqDCoMKgwqAgaWYgKGFs
bG9jX2hpIDwgY3Vycl9pb3ZhLT5wZm5faGkpIHsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgYWxsb2NfbG8gPSBjdXJyX2lvdmEtPnBmbl9oaTsKPj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgYWxsb2NfaGkgPSBsaW1pdF9wZm47Cj4+ICvCoMKgwqDCoMKgwqAgfQo+PiAr
Cj4+IMKgwqDCoMKgwqDCoMKgIGRvIHsKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
bGltaXRfcGZuID0gbWluKGxpbWl0X3BmbiwgY3Vycl9pb3ZhLT5wZm5fbG8pOwo+PiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBuZXdfcGZuID0gKGxpbWl0X3BmbiAtIHNpemUpICYgYWxp
Z25fbWFzazsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYWxsb2NfaGkgPSBtaW4o
YWxsb2NfaGksIGN1cnJfaW92YS0+cGZuX2xvKTsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgbmV3X3BmbiA9IChhbGxvY19oaSAtIHNpemUpICYgYWxpZ25fbWFzazsKPj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHByZXYgPSBjdXJyOwo+PiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgY3VyciA9IHJiX3ByZXYoY3Vycik7Cj4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBjdXJyX2lvdmEgPSByYl9lbnRyeShjdXJyLCBzdHJ1Y3QgaW92YSwgbm9k
ZSk7Cj4+IMKgwqDCoMKgwqDCoMKgIH0gd2hpbGUgKGN1cnIgJiYgbmV3X3BmbiA8PSBjdXJyX2lv
dmEtPnBmbl9oaSk7Cj4+Cj4+IC3CoMKgwqDCoMKgwqAgaWYgKGxpbWl0X3BmbiA8IHNpemUgfHwg
bmV3X3BmbiA8IGlvdmFkLT5zdGFydF9wZm4pIHsKPj4gK8KgwqDCoMKgwqDCoCBpZiAobGltaXRf
cGZuIDwgc2l6ZSB8fCBuZXdfcGZuIDwgYWxsb2NfbG8pIHsKPj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgaWYgKGFsbG9jX2xvID09IGlvdmFkLT5zdGFydF9wZm4pCj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIHJldHJ5Owo+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW92YWQtPm1heDMyX2FsbG9jX3NpemUgPSBzaXpl
Owo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBpb3ZhMzJfZnVsbDsKPj4g
wqDCoMKgwqDCoMKgwqAgfQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9t
bXU=
