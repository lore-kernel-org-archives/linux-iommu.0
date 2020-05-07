Return-Path: <SRS0=32yV=6V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334A8C4724C
	for <iommu@archiver.kernel.org>; Thu,  7 May 2020 11:06:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE8ED20736
	for <iommu@archiver.kernel.org>; Thu,  7 May 2020 11:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="RMvxfuoQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE8ED20736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8C78226242;
	Thu,  7 May 2020 11:06:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Nuyk0DTWICWU; Thu,  7 May 2020 11:06:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D1D572045A;
	Thu,  7 May 2020 11:06:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BFBA9C0859;
	Thu,  7 May 2020 11:06:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C79BBC07FF
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 11:06:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C0EBD8937B
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 11:06:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fP3oqi0dvhpO for <iommu@lists.linux-foundation.org>;
 Thu,  7 May 2020 11:06:04 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail26.static.mailgun.info (mail26.static.mailgun.info
 [104.130.122.26])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8D4BC88C62
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 11:05:58 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1588849564; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=KUkv11UrsJT4bCOAv4o9yBeyPANsHJVXo3wLqp+3x3w=;
 b=RMvxfuoQiKh+KU12YlPijlNu1pVum11gFHCzx49R/8xaaVgNjZ0Mw8Y6CZBD19oLBILddQX+
 YIAAlmvUWPhV3pY/yOszNMe4IZZ+UGa1B1sNdzTxq6roblWp0umH2Piv7q6EmL92oO5L2cQc
 b5gxIx5+K85S8HAkPD03InC4PXs=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb3eb89.7fcd11868458-smtp-out-n03;
 Thu, 07 May 2020 11:05:45 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 3874EC44791; Thu,  7 May 2020 11:05:45 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 5D6E4C433F2;
 Thu,  7 May 2020 11:05:44 +0000 (UTC)
MIME-Version: 1.0
Date: Thu, 07 May 2020 16:35:44 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCHv2] iommu/arm-smmu: Make remove callback message more
 informative
In-Reply-To: <2f3cd963-dffe-290b-02bf-819687713738@arm.com>
References: <20200423095531.9868-1-saiprakash.ranjan@codeaurora.org>
 <CAD=FV=W=d=KrTwgMOO-ukFc7ZhkE92qGYumUEDrtjmhQOpdWbg@mail.gmail.com>
 <CAD=FV=U0Hhae3D1-P8kbcZafHeuqng11BNAbOb2YWPx+M7X5Gw@mail.gmail.com>
 <0b5098c28360d018f390a97155b9776c@codeaurora.org>
 <2f3cd963-dffe-290b-02bf-819687713738@arm.com>
Message-ID: <7c3fd8c1d5b26ac277b8729d59531474@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Doug Anderson <dianders@chromium.org>, LKML <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
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

T24gMjAyMC0wNS0wNyAxNjowMywgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIwMjAtMDUtMDcg
MTE6MDQgYW0sIFNhaSBQcmFrYXNoIFJhbmphbiB3cm90ZToKPj4gSGksCj4+IAo+PiBPbiAyMDIw
LTA1LTA3IDA1OjQwLCBEb3VnIEFuZGVyc29uIHdyb3RlOgo+Pj4gSGksCj4+PiAKPj4+IE9uIFRo
dSwgQXByIDIzLCAyMDIwIGF0IDc6MzUgQU0gRG91ZyBBbmRlcnNvbiA8ZGlhbmRlcnNAY2hyb21p
dW0ub3JnPiAKPj4+IHdyb3RlOgo+Pj4+IAo+Pj4+IEhpLAo+Pj4+IAo+Pj4+IE9uIFRodSwgQXBy
IDIzLCAyMDIwIGF0IDI6NTUgQU0gU2FpIFByYWthc2ggUmFuamFuCj4+Pj4gPHNhaXByYWthc2gu
cmFuamFuQGNvZGVhdXJvcmEub3JnPiB3cm90ZToKPj4+PiA+Cj4+Pj4gPiBDdXJyZW50bHkgb24g
cmVib290L3NodXRkb3duLCB0aGUgZm9sbG93aW5nIG1lc3NhZ2VzIGFyZQo+Pj4+ID4gZGlzcGxh
eWVkIG9uIHRoZSBjb25zb2xlIGFzIGVycm9yIG1lc3NhZ2VzIGJlZm9yZSB0aGUKPj4+PiA+IHN5
c3RlbSByZWJvb3RzL3NodXRkb3duIGFzIHBhcnQgb2YgcmVtb3ZlIGNhbGxiYWNrLgo+Pj4+ID4K
Pj4+PiA+IE9uIFNDNzE4MDoKPj4+PiA+Cj4+Pj4gPsKgwqAgYXJtLXNtbXUgMTUwMDAwMDAuaW9t
bXU6IHJlbW92aW5nIGRldmljZSB3aXRoIGFjdGl2ZSBkb21haW5zIQo+Pj4+ID7CoMKgIGFybS1z
bW11IDUwNDAwMDAuaW9tbXU6IHJlbW92aW5nIGRldmljZSB3aXRoIGFjdGl2ZSBkb21haW5zIQo+
Pj4+ID4KPj4+PiA+IE1ha2UgdGhpcyBlcnJvciBtZXNzYWdlIG1vcmUgaW5mb3JtYXRpdmUgYW5k
IGxlc3Mgc2NhcnkuCj4+Pj4gPgo+Pj4+ID4gUmVwb3J0ZWQtYnk6IERvdWdsYXMgQW5kZXJzb24g
PGRpYW5kZXJzQGNocm9taXVtLm9yZz4KPj4+PiA+IFN1Z2dlc3RlZC1ieTogUm9iaW4gTXVycGh5
IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4KPj4+PiA+IFNpZ25lZC1vZmYtYnk6IFNhaSBQcmFrYXNo
IFJhbmphbiA8c2FpcHJha2FzaC5yYW5qYW5AY29kZWF1cm9yYS5vcmc+Cj4+Pj4gPiAtLS0KPj4+
PiA+wqAgZHJpdmVycy9pb21tdS9hcm0tc21tdS5jIHwgMiArLQo+Pj4+ID7CoCAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPj4+PiAKPj4+PiBSZXZpZXdlZC1i
eTogRG91Z2xhcyBBbmRlcnNvbiA8ZGlhbmRlcnNAY2hyb21pdW0ub3JnPgo+Pj4gCj4+PiBJcyB0
aGlzIHBhdGNoIHdhaXRpbmcgb24gYW55dGhpbmcgaW4gcGFydGljdWxhciBub3c/wqAgRG8gd2Ug
bmVlZAo+Pj4gcmV2aWV3cyBmcm9tIFJvYmluIGFuZC9vciBXaWxsPwo+Pj4gCj4+IAo+PiBXYWl0
aW5nIGZvciB0aGVpciByZXZpZXdzIGFzIHRoZXkgYXJlIHRoZSBtYWludGFpbmVycy9yZXZpZXdl
cnMgOikKPiAKPiBTb3JyeSwgdGhpcyBkaWQgcmVnaXN0ZXIgYXQgdGhlIHRpbWUsIEkganVzdCBm
ZWx0IHRoYXQgaXQncyBhIGJpdAo+IHJlZHVuZGFudCB0byBnaXZlIGEgcmV2aWV3IHRhZyB0byBz
YXkgInllcywgdGhpcyBpcyBleGFjdGx5IHdoYXQgSQo+IHN1Z2dlc3RlZCIgOikKPiAKPiBUaGF0
IHNhaWQsIEkgZG8gd2lzaCBJIGhhZG4ndCBmb3Jnb3R0ZW4gYWJvdXQgdGhlIGRldl9ub3RpY2Ug
bWVzc2FnZQo+IGxldmVsLCBidXQgSSB0aGluayB0aGF0IGxpZXMgb3ZlciBpbiB0aGUgY29uY2Vw
dHVhbCBwdXJpdHkgY29ybmVyCj4gcmF0aGVyIHRoYW4gbWFraW5nIGFueSBwcmFjdGljYWwgZGlm
ZmVyZW5jZSwgc28gSSdtIHN0aWxsIE9LIHdpdGggdGhlCj4gcGF0Y2ggYXMtaXMuIFdpbGw/Cj4g
CgpJIGNhbiBjaGFuZ2UgdG8gZGV2X25vdGljZSBpZiB5b3UgaGF2ZSBzdHJvbmcgcHJlZmVyZW5j
ZSBmb3IgdGhhdC4KSSBjaG9zZSBkZXZfaW5mbyBzaW5jZSB3ZSBzZWUgdGhlIG1lc3NhZ2VzIG9u
IGV2ZXJ5IHJlYm9vdCBhbmQgdGhhdCAKbWFrZXMKaXQgbW9yZSBpbmZvcm1hdGlvbmFsIHRoYW4g
c29tZXRoaW5nIHRvIG5vdGljZSBldmVyeXRpbWUuCgo+IAo+IHAucy4gd2hvZXZlciBoYXMgdGhp
cyBlbnRyeSBpbiB0aGVpciBhZGRyZXNzIGJvb2sgZm9yIHRoZSBJT01NVSBsaXN0IAo+IChEb3Vn
Pyk6Cj4gCj4gImxpc3RAMjYzLm5ldDpJT01NVSBEUklWRVJTIDxpb21tdUBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZz4sIEpvZXJnCj4gUm9lZGVsIDxqb3JvQDhieXRlcy5vcmc+LCIgPGlvbW11
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnPgo+IAo+IGl0IHJlYWxseSBtZXNzZXMgdXAgVGh1
bmRlcmJpcmQncyBhYmlsaXR5IHRvIGdlbmVyYXRlIHdvcmtpbmcgaGVhZGVycwo+IGZvciBhIHJl
cGx5IDspCgpOb3QgbWUgOykKClRoYW5rcywKU2FpCi0tIApRVUFMQ09NTSBJTkRJQSwgb24gYmVo
YWxmIG9mIFF1YWxjb21tIElubm92YXRpb24gQ2VudGVyLCBJbmMuIGlzIGEgCm1lbWJlcgpvZiBD
b2RlIEF1cm9yYSBGb3J1bSwgaG9zdGVkIGJ5IFRoZSBMaW51eCBGb3VuZGF0aW9uCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlz
dAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
