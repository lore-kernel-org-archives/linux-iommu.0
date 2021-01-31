Return-Path: <SRS0=ctPp=HC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_ADSP_DISCARD,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72EBDC433DB
	for <iommu@archiver.kernel.org>; Sun, 31 Jan 2021 16:06:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 386D264E0F
	for <iommu@archiver.kernel.org>; Sun, 31 Jan 2021 16:06:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 386D264E0F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0243B86977;
	Sun, 31 Jan 2021 16:06:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cFtr-so+ocDF; Sun, 31 Jan 2021 16:06:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 19C088694E;
	Sun, 31 Jan 2021 16:06:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 010D2C0FA7;
	Sun, 31 Jan 2021 16:06:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16C61C013A
 for <iommu@lists.linux-foundation.org>; Sun, 31 Jan 2021 11:39:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 020D987085
 for <iommu@lists.linux-foundation.org>; Sun, 31 Jan 2021 11:39:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KrxnQxFGqnfb for <iommu@lists.linux-foundation.org>;
 Sun, 31 Jan 2021 11:39:45 +0000 (UTC)
X-Greylist: delayed 00:08:37 by SQLgrey-1.7.6
Received: from services.gouders.net (services.gouders.net [141.101.32.176])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 29FFA87084
 for <iommu@lists.linux-foundation.org>; Sun, 31 Jan 2021 11:39:44 +0000 (UTC)
Received: from localhost (ltea-047-066-000-239.pools.arcor-ip.net
 [47.66.0.239]) (authenticated bits=0)
 by services.gouders.net (8.14.8/8.14.8) with ESMTP id 10VBT2Wt023944
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 31 Jan 2021 12:29:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
 t=1612092543; bh=1UOfvjPVadRcsEZblv5wgGiNEHF3VcM77+wzdncuBgA=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=KiUPO1FdL0u3/gLN1egAt6CCGIfPUf0RwjH8Wg8wop+kiHxzA10nVNAmYGdXH9nwI
 XbgT3daRdKWLOtZcUOlyLGg+Fnh8KsqWeckj1CMIs9ZsxyhwJ5ZJkoeGEUOo3Iya5W
 ZAeb3C2il36MlpRKI9TXVeoChHo5fS3NLkt1XDgU=
From: Dirk Gouders <dirk@gouders.net>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Add qi_submit trace event
In-Reply-To: <20210114090400.736104-1-baolu.lu@linux.intel.com> (Lu Baolu's
 message of "Thu, 14 Jan 2021 17:04:00 +0800")
References: <20210114090400.736104-1-baolu.lu@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date: Sun, 31 Jan 2021 12:27:26 +0100
Message-ID: <gh1re1wdlt.fsf@gouders.net>
MIME-Version: 1.0
X-Mailman-Approved-At: Sun, 31 Jan 2021 16:06:15 +0000
Cc: Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
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

THUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4gd3JpdGVzOgoKPiBUaGlzIGFkZHMg
YSBuZXcgdHJhY2UgZXZlbnQgdG8gdHJhY2sgdGhlIHN1Ym1pc3Npb25zIG9mIHJlcXVlc3RzIHRv
IHRoZQo+IGludmFsaWRhdGlvbiBxdWV1ZS4gVGhpcyBldmVudCB3aWxsIHByb3ZpZGUgdGhlIGlu
Zm9ybWF0aW9uIGxpa2U6Cj4gLSBJT01NVSBuYW1lCj4gLSBJbnZhbGlkYXRpb24gdHlwZQo+IC0g
RGVzY3JpcHRvciByYXcgZGF0YQo+Cj4gQSBzYW1wbGUgb3V0cHV0IGxpa2U6Cj4gfCBxaV9zdWJt
aXQ6IGlvdGxiX2ludiBkbWFyMTogMHgxMDBlMiAweDAgMHgwIDB4MAo+IHwgcWlfc3VibWl0OiBk
ZXZfdGxiX2ludiBkbWFyMTogMHgxMDAwMDAwMDAzIDB4N2ZmZmZmZmZmZmZmZjAwMSAweDAgMHgw
Cj4gfCBxaV9zdWJtaXQ6IGlvdGxiX2ludiBkbWFyMjogMHg4MDBmMiAweGY5YTAwMDA1IDB4MCAw
eDAKPgo+IFRoaXMgd2lsbCBiZSBoZWxwZnVsIGZvciBxdWV1ZWQgaW52YWxpZGF0aW9uIHJlbGF0
ZWQgZGVidWdnaW5nLgo+Cj4gU2lnbmVkLW9mZi1ieTogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4
LmludGVsLmNvbT4KCldoaWxlIGNvbXBpbGluZyBjdXJyZW50IGxpbnV4LW5leHQgZm9yIHNvbWUg
b3RoZXIgdGVzdCBJIG5vdGljZWQgYQpjb21waWxlciBlcnJvciBiZWNhdXNlIG9mIHRoaXMgcGF0
Y2g6Cgpkcml2ZXJzL2lvbW11L2ludGVsL2RtYXIuYzogSW4gZnVuY3Rpb24g4oCYcWlfc3VibWl0
X3N5bmPigJk6CmRyaXZlcnMvaW9tbXUvaW50ZWwvZG1hci5jOjEzMTE6MzogZXJyb3I6IGltcGxp
Y2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIOKAmHRyYWNlX3FpX3N1Ym1pdOKAmSBbLVdlcnJv
cj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0KIDEzMTEgfCAgIHRyYWNlX3FpX3N1Ym1p
dChpb21tdSwgZGVzY1tpXS5xdzAsIGRlc2NbaV0ucXcxLAogICAgICB8ICAgXn5+fn5+fn5+fn5+
fn5+CmNjMTogc29tZSB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwoKT24gbXkgbWFj
aGluZSBDT05GSUdfSU5URUxfSU9NTVUgaXMgbm90IHNldCBzbwojaW5jbHVkZSA8dHJhY2UvZXZl
bnRzL2ludGVsX2lvbW11Lmg+IGNhbm5vdCBwcm92aWRlIHRoZSBwcm90b3R5cGUgZm9yCnRoYXQg
ZnVuY3Rpb24uCgpEaXJrCgo+IC0tLQo+ICBkcml2ZXJzL2lvbW11L2ludGVsL2RtYXIuYyAgICAg
ICAgIHwgIDMgKysrCj4gIGluY2x1ZGUvdHJhY2UvZXZlbnRzL2ludGVsX2lvbW11LmggfCAzNyAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPiAgMiBmaWxlcyBjaGFuZ2VkLCA0MCBpbnNl
cnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pbnRlbC9kbWFyLmMgYi9k
cml2ZXJzL2lvbW11L2ludGVsL2RtYXIuYwo+IGluZGV4IDAwNGZlYWVkM2M3Mi4uYmQ1MWYzMzY0
MmUwIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvZG1hci5jCj4gKysrIGIvZHJp
dmVycy9pb21tdS9pbnRlbC9kbWFyLmMKPiBAQCAtMzEsNiArMzEsNyBAQAo+ICAjaW5jbHVkZSA8
bGludXgvbGltaXRzLmg+Cj4gICNpbmNsdWRlIDxhc20vaXJxX3JlbWFwcGluZy5oPgo+ICAjaW5j
bHVkZSA8YXNtL2lvbW11X3RhYmxlLmg+Cj4gKyNpbmNsdWRlIDx0cmFjZS9ldmVudHMvaW50ZWxf
aW9tbXUuaD4KPiAgCj4gICNpbmNsdWRlICIuLi9pcnFfcmVtYXBwaW5nLmgiCj4gIAo+IEBAIC0x
MzA3LDYgKzEzMDgsOCBAQCBpbnQgcWlfc3VibWl0X3N5bmMoc3RydWN0IGludGVsX2lvbW11ICpp
b21tdSwgc3RydWN0IHFpX2Rlc2MgKmRlc2MsCj4gIAkJb2Zmc2V0ID0gKChpbmRleCArIGkpICUg
UUlfTEVOR1RIKSA8PCBzaGlmdDsKPiAgCQltZW1jcHkocWktPmRlc2MgKyBvZmZzZXQsICZkZXNj
W2ldLCAxIDw8IHNoaWZ0KTsKPiAgCQlxaS0+ZGVzY19zdGF0dXNbKGluZGV4ICsgaSkgJSBRSV9M
RU5HVEhdID0gUUlfSU5fVVNFOwo+ICsJCXRyYWNlX3FpX3N1Ym1pdChpb21tdSwgZGVzY1tpXS5x
dzAsIGRlc2NbaV0ucXcxLAo+ICsJCQkJZGVzY1tpXS5xdzIsIGRlc2NbaV0ucXczKTsKPiAgCX0K
PiAgCXFpLT5kZXNjX3N0YXR1c1t3YWl0X2luZGV4XSA9IFFJX0lOX1VTRTsKPiAgCj4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvdHJhY2UvZXZlbnRzL2ludGVsX2lvbW11LmggYi9pbmNsdWRlL3RyYWNl
L2V2ZW50cy9pbnRlbF9pb21tdS5oCj4gaW5kZXggMTEyYmQwNjQ4N2JmLi5hYWQyZmYwYzFlMmUg
MTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS90cmFjZS9ldmVudHMvaW50ZWxfaW9tbXUuaAo+ICsrKyBi
L2luY2x1ZGUvdHJhY2UvZXZlbnRzL2ludGVsX2lvbW11LmgKPiBAQCAtMTM1LDYgKzEzNSw0MyBA
QCBERUZJTkVfRVZFTlQoZG1hX21hcF9zZywgYm91bmNlX21hcF9zZywKPiAgCQkgc3RydWN0IHNj
YXR0ZXJsaXN0ICpzZyksCj4gIAlUUF9BUkdTKGRldiwgaW5kZXgsIHRvdGFsLCBzZykKPiAgKTsK
PiArCj4gK1RSQUNFX0VWRU5UKHFpX3N1Ym1pdCwKPiArCVRQX1BST1RPKHN0cnVjdCBpbnRlbF9p
b21tdSAqaW9tbXUsIHU2NCBxdzAsIHU2NCBxdzEsIHU2NCBxdzIsIHU2NCBxdzMpLAo+ICsKPiAr
CVRQX0FSR1MoaW9tbXUsIHF3MCwgcXcxLCBxdzIsIHF3MyksCj4gKwo+ICsJVFBfU1RSVUNUX19l
bnRyeSgKPiArCQlfX2ZpZWxkKHU2NCwgcXcwKQo+ICsJCV9fZmllbGQodTY0LCBxdzEpCj4gKwkJ
X19maWVsZCh1NjQsIHF3MikKPiArCQlfX2ZpZWxkKHU2NCwgcXczKQo+ICsJCV9fc3RyaW5nKGlv
bW11LCBpb21tdS0+bmFtZSkKPiArCSksCj4gKwo+ICsJVFBfZmFzdF9hc3NpZ24oCj4gKwkJX19h
c3NpZ25fc3RyKGlvbW11LCBpb21tdS0+bmFtZSk7Cj4gKwkJX19lbnRyeS0+cXcwID0gcXcwOwo+
ICsJCV9fZW50cnktPnF3MSA9IHF3MTsKPiArCQlfX2VudHJ5LT5xdzIgPSBxdzI7Cj4gKwkJX19l
bnRyeS0+cXczID0gcXczOwo+ICsJKSwKPiArCj4gKwlUUF9wcmludGsoIiVzICVzOiAweCVsbHgg
MHglbGx4IDB4JWxseCAweCVsbHgiLAo+ICsJCSAgX19wcmludF9zeW1ib2xpYyhfX2VudHJ5LT5x
dzAgJiAweGYsCj4gKwkJCQkgICB7IFFJX0NDX1RZUEUsCSJjY19pbnYiIH0sCj4gKwkJCQkgICB7
IFFJX0lPVExCX1RZUEUsCSJpb3RsYl9pbnYiIH0sCj4gKwkJCQkgICB7IFFJX0RJT1RMQl9UWVBF
LAkiZGV2X3RsYl9pbnYiIH0sCj4gKwkJCQkgICB7IFFJX0lFQ19UWVBFLAkiaWVjX2ludiIgfSwK
PiArCQkJCSAgIHsgUUlfSVdEX1RZUEUsCSJpbnZfd2FpdCIgfSwKPiArCQkJCSAgIHsgUUlfRUlP
VExCX1RZUEUsCSJwX2lvdGxiX2ludiIgfSwKPiArCQkJCSAgIHsgUUlfUENfVFlQRSwJInBjX2lu
diIgfSwKPiArCQkJCSAgIHsgUUlfREVJT1RMQl9UWVBFLAkicF9kZXZfdGxiX2ludiIgfSwKPiAr
CQkJCSAgIHsgUUlfUEdSUF9SRVNQX1RZUEUsCSJwYWdlX2dycF9yZXNwIiB9KSwKPiArCQlfX2dl
dF9zdHIoaW9tbXUpLAo+ICsJCV9fZW50cnktPnF3MCwgX19lbnRyeS0+cXcxLCBfX2VudHJ5LT5x
dzIsIF9fZW50cnktPnF3Mwo+ICsJKQo+ICspOwo+ICAjZW5kaWYgLyogX1RSQUNFX0lOVEVMX0lP
TU1VX0ggKi8KPiAgCj4gIC8qIFRoaXMgcGFydCBtdXN0IGJlIG91dHNpZGUgcHJvdGVjdGlvbiAq
LwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBt
YWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
