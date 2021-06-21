Return-Path: <SRS0=Ta7z=LP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8A3C48BC2
	for <iommu@archiver.kernel.org>; Mon, 21 Jun 2021 12:00:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 683F860FE3
	for <iommu@archiver.kernel.org>; Mon, 21 Jun 2021 12:00:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 683F860FE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2A23B402BC;
	Mon, 21 Jun 2021 12:00:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ubwm4W9KfMip; Mon, 21 Jun 2021 12:00:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 71A4A402B3;
	Mon, 21 Jun 2021 12:00:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35BB3C0010;
	Mon, 21 Jun 2021 12:00:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F1E7BC000C
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 12:00:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D28996062D
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 12:00:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t1xp_PG1enzW for <iommu@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 11:59:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id BF34B600CA
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 11:59:58 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92EF51FB;
 Mon, 21 Jun 2021 04:59:57 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA86F3F718;
 Mon, 21 Jun 2021 04:59:55 -0700 (PDT)
Subject: Re: [PATCH v14 6/6] iommu: Remove mode argument from
 iommu_set_dma_strict()
To: John Garry <john.garry@huawei.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 joro@8bytes.org, will@kernel.org, dwmw2@infradead.org, corbet@lwn.net
References: <1624016058-189713-1-git-send-email-john.garry@huawei.com>
 <1624016058-189713-7-git-send-email-john.garry@huawei.com>
 <c062ef9e-c106-4218-ba2a-c94fdcb6d955@linux.intel.com>
 <60bdd7c3-d73e-c005-ddf7-069bc5065bce@huawei.com>
 <855dd109-1449-7bc6-3d25-7ffeeeffa82a@linux.intel.com>
 <fc52069d-46c5-5ca5-1b44-2fa7cf287d5a@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <2330bb52-1768-5122-9378-7923034c82bd@arm.com>
Date: Mon, 21 Jun 2021 12:59:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <fc52069d-46c5-5ca5-1b44-2fa7cf287d5a@huawei.com>
Content-Language: en-GB
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxarm@huawei.com, iommu@lists.linux-foundation.org
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

T24gMjAyMS0wNi0yMSAxMTozNCwgSm9obiBHYXJyeSB3cm90ZToKPiBPbiAyMS8wNi8yMDIxIDEx
OjAwLCBMdSBCYW9sdSB3cm90ZToKPj4+IHZvaWQgaW9tbXVfc2V0X2RtYV9zdHJpY3QoYm9vbCBm
b3JjZSkKPj4+IHsKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoZm9yY2UgPT0gdHJ1ZSkKPj4+
IMKgwqDCoMKgwqDCoMKgwqAgaW9tbXVfZG1hX3N0cmljdCA9IHRydWU7Cj4+PiDCoMKgwqDCoMKg
ZWxzZSBpZiAoIShpb21tdV9jbWRfbGluZSAmIElPTU1VX0NNRF9MSU5FX1NUUklDVCkpCj4+PiDC
oMKgwqDCoMKgwqDCoMKgIGlvbW11X2RtYV9zdHJpY3QgPSB0cnVlOwo+Pj4gfQo+Pj4KPj4+IFNv
IHdlIHdvdWxkIHVzZSBpb21tdV9zZXRfZG1hX3N0cmljdCh0cnVlKSBmb3IgYSkgYW5kIGIpLCBi
dXQgCj4+PiBpb21tdV9zZXRfZG1hX3N0cmljdChmYWxzZSkgZm9yIGMpLgo+Pgo+PiBZZXMuIFdl
IG5lZWQgdG8gZGlzdGluZ3Vpc2ggdGhlICJtdXN0IiBhbmQgIm5pY2UtdG8taGF2ZSIgY2FzZXMg
b2YKPj4gc2V0dGluZyBzdHJpY3QgbW9kZS4KPj4KPj4+Cj4+PiBUaGVuIEkgYW0gbm90IHN1cmUg
d2hhdCB5b3Ugd2FudCB0byBkbyB3aXRoIHRoZSBhY2NvbXBhbnlpbmcgcHJpbnQgCj4+PiBmb3Ig
YykuIEl0IHdhczoKPj4+ICJJT01NVSBiYXRjaGluZyBpcyBkaXNhYmxlZCBkdWUgdG8gdmlydHVh
bGl6YXRpb24iCj4+Pgo+Pj4gQW5kIG5vdyBpcyBmcm9tIHRoaXMgc2VyaWVzOgo+Pj4gIklPTU1V
IGJhdGNoaW5nIGRpc2FsbG93ZWQgZHVlIHRvIHZpcnR1YWxpemF0aW9uIgo+Pj4KPj4+IFVzaW5n
IGlvbW11X2dldF9kbWFfc3RyaWN0KGRvbWFpbikgaXMgbm90IGFwcHJvcHJpYXRlIGhlcmUgdG8g
a25vdyAKPj4+IHRoZSBjdXJyZW50IG1vZGUgKHNvIHdlIGtub3cgd2hldGhlciB0byBwcmludCku
Cj4+Pgo+Pj4gTm90ZSB0aGF0IHRoaXMgY2hhbmdlIHdvdWxkIG1lYW4gdGhhdCB0aGUgY3VycmVu
dCBzZXJpZXMgd291bGQgCj4+PiByZXF1aXJlIG5vbi10cml2aWFsIHJld29yaywgd2hpY2ggd291
bGQgYmUgdW5mb3J0dW5hdGUgc28gbGF0ZSBpbiB0aGUgCj4+PiBjeWNsZS4KPj4KPj4gVGhpcyBw
YXRjaCBzZXJpZXMgbG9va3MgZ29vZCB0byBtZSBhbmQgSSBoYXZlIGFkZGVkIGJ5IHJldmlld2Vk
LWJ5Lgo+PiBQcm9iYWJseSB3ZSBjb3VsZCBtYWtlIGFub3RoZXIgcGF0Y2ggc2VyaWVzIHRvIGlt
cHJvdmUgaXQgc28gdGhhdCB0aGUKPj4ga2VybmVsIG9wdGltaXphdGlvbiBzaG91bGQgbm90IG92
ZXJyaWRlIHRoZSB1c2VyIHNldHRpbmcuCj4gCj4gT24gYSBwZXJzb25hbCBsZXZlbCBJIHdvdWxk
IGJlIGhhcHB5IHdpdGggdGhhdCBhcHByb2FjaCwgYnV0IEkgdGhpbmsgCj4gaXQncyBiZXR0ZXIg
dG8gbm90IHN0YXJ0IGNoYW5naW5nIHRoaW5ncyByaWdodCBhd2F5IGluIGEgZm9sbG93LXVwIHNl
cmllcy4KPiAKPiBTbyBob3cgYWJvdXQgd2UgYWRkIHRoaXMgcGF0Y2ggKHdoaWNoIHJlcGxhY2Vz
IDYvNiAiaW9tbXU6IFJlbW92ZSBtb2RlIAo+IGFyZ3VtZW50IGZyb20gaW9tbXVfc2V0X2RtYV9z
dHJpY3QoKSIpPwo+IAo+IFJvYmluLCBhbnkgb3Bpbmlvbj8KCkZvciBtZSBpdCBib2lscyBkb3du
IHRvIHdoZXRoZXIgdGhlcmUgYXJlIGFueSByZWFsaXN0aWMgd29ya2xvYWRzIHdoZXJlIApub24t
c3RyaWN0IG1vZGUgKndvdWxkKiBzdGlsbCBwZXJmb3JtIGJldHRlciB1bmRlciB2aXJ0dWFsaXNh
dGlvbi4gVGhlIApvbmx5IHJlYXNvbiBmb3IgdGhlIHVzZXIgdG8gZXhwbGljaXRseSBwYXNzICJp
b21tdS5zdHJpY3Q9MCIgaXMgYmVjYXVzZSAKdGhleSBleHBlY3QgaXQgdG8gaW5jcmVhc2UgdW5t
YXAgcGVyZm9ybWFuY2U7IGlmIGl0J3Mgb25seSBldmVyIGdvaW5nIHRvIApsZWFkIHRvIGFuIHVu
ZXhwZWN0ZWQgcGVyZm9ybWFuY2UgbG9zcywgSSBkb24ndCBzZWUgYW55IHZhbHVlIGluIApvdmVy
cmlkaW5nIHRoZSBrZXJuZWwncyBkZWNpc2lvbiBwdXJlbHkgZm9yIHRoZSBzYWtlIG9mIHN1YnNl
cnZpZW5jZS4KCklmIHRoZXJlICphcmUqIGNlcnRhaW4gdmFsaWQgY2FzZXMgZm9yIGFsbG93aW5n
IGl0IGZvciBwZW9wbGUgd2hvIHJlYWxseSAKa25vdyB3aGF0IHRoZXkncmUgZG9pbmcsIHRoZW4g
d2Ugc2hvdWxkIGFyZ3VhYmx5IGFsc28gbG9nIGEgY291bnRlcnBhcnQgCm1lc3NhZ2UgdG8gc2F5
ICJ3ZSdyZSBob25vdXJpbmcgeW91ciBvdmVycmlkZSBidXQgYmV3YXJlIGl0IG1heSBoYXZlIHRo
ZSAKb3Bwb3NpdGUgZWZmZWN0IHRvIHdoYXQgeW91IGV4cGVjdCIgZm9yIHRoZSBiZW5lZml0IG9m
IG90aGVyIHVzZXJzIHdobyAKYXNzdW1lIGl0J3MgYSBnZW5lcmljIGdvLWZhc3RlciBrbm9iLiBB
dCB0aGF0IHBvaW50IGl0IHN0YXJ0cyBnZXR0aW5nIApub24tdHJpdmlhbCBlbm91Z2ggdGhhdCBJ
J2Qgd2FudCB0byBrbm93IGZvciBzdXJlIGl0J3Mgd29ydGh3aGlsZS4KClRoZSBvdGhlciByZWFz
b24gdGhpcyBtaWdodCBiZSBiZXR0ZXIgdG8gcmV2aXNpdCBsYXRlciBpcyB0aGF0IGFuIEFNRCAK
ZXF1aXZhbGVudCBpcyBzdGlsbCBpbiBmbGlnaHRbMV0sIGFuZCB0aGVyZSBtaWdodCBiZSBtb3Jl
IHRoYXQgY2FuIApldmVudHVhbGx5IGJlIGZhY3RvcmVkIG91dC4gSSB0aGluayBib3RoIHNlcmll
cyBhcmUgcHJldHR5IG11Y2ggZ29vZCB0byAKbWVyZ2UgZm9yIDUuMTQsIGJ1dCB0aW1lJ3MgYWxy
ZWFkeSB0aWdodCB0byBzb3J0IG91dCB0aGUgY29uZmxpY3RzIHdoaWNoIApleGlzdCBhcy1pcywg
d2l0aG91dCBtYWtpbmcgdGhlbSBhbnkgd29yc2UuCgpSb2Jpbi4KClsxXSAKaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvbGludXgtaW9tbXUvMjAyMTA2MTYxMDA1MDAuMTc0NTA3LTMtbmFtaXRAdm13
YXJlLmNvbS8KCj4gCj4gLS0tLS0tLT44LS0tLS0tLS0tCj4gCj4gW1BBVENIXSBpb21tdS92dC1k
OiBNYWtlICJpb21tdS5zdHJpY3QiIG92ZXJyaWRlIGJhdGNoaW5nIGR1ZSB0bwo+ICDCoHZpcnR1
YWxpemF0aW9uCj4gCj4gQXMgYSBjaGFuZ2UgaW4gcG9saWN5LCBtYWtlIGlvbW11LnN0cmljdCBj
bWRsaW5lIGFyZ3VtZW50IG92ZXJyaWRlIAo+IHdoZXRoZXIgd2UgZGlzYWJsZSBiYXRjaGluZyBk
dWUgdG8gdmlydHVhbGl6YXRpb24uCj4gCj4gVGhlIEFQSSBvZiBpb21tdV9zZXRfZG1hX3N0cmlj
dCgpIGlzIGNoYW5nZWQgdG8gYWNjZXB0IGEgImZvcmNlIiAKPiBhcmd1bWVudCwgd2hpY2ggbWVh
bnMgdGhhdCB3ZSBhbHdheXMgc2V0IGlvbW11X2RtYV9zdHJpY3QgdHJ1ZSwgCj4gcmVnYXJkbGVz
cyBvZiB3aGV0aGVyIHdlIGFscmVhZHkgc2V0IHZpYSBjbWRsaW5lLiBBbHNvIHJldHVybiBhIGJv
b2xlYW4sIAo+IHRvIHRlbGwgd2hldGhlciBpb21tdV9kbWFfc3RyaWN0IHdhcyBzZXQgb3Igbm90
Lgo+IAo+IE5vdGUgdGhhdCBpbiBhbGwgcHJlLWV4aXN0aW5nIGNhbGxzaXRlcyBvZiBpb21tdV9z
ZXRfZG1hX3N0cmljdCgpLCAKPiBhcmd1bWVudCBzdHJpY3Qgd2FzIHRydWUsIHNvIHRoaXMgYXJn
dW1lbnQgaXMgZHJvcHBlZC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBKb2huIEdhcnJ5IDxqb2huLmdh
cnJ5QGh1YXdlaS5jb20+Cj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9t
bXUuYyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYwo+IGluZGV4IDA2NjY2ZjlkODExNi4u
ZThkNjUyMzliMzU5IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYwo+
ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYwo+IEBAIC00MzgwLDEwICs0MzgwLDgg
QEAgaW50IF9faW5pdCBpbnRlbF9pb21tdV9pbml0KHZvaWQpCj4gIMKgwqDCoMKgwqDCoMKgwqDC
oCAqIGlzIGxpa2VseSB0byBiZSBtdWNoIGxvd2VyIHRoYW4gdGhlIG92ZXJoZWFkIG9mIHN5bmNo
cm9uaXppbmcKPiAgwqDCoMKgwqDCoMKgwqDCoMKgICogdGhlIHZpcnR1YWwgYW5kIHBoeXNpY2Fs
IElPTU1VIHBhZ2UtdGFibGVzLgo+ICDCoMKgwqDCoMKgwqDCoMKgwqAgKi8KPiAtwqDCoMKgwqDC
oMKgwqAgaWYgKGNhcF9jYWNoaW5nX21vZGUoaW9tbXUtPmNhcCkpIHsKPiArwqDCoMKgwqDCoMKg
wqAgaWYgKGNhcF9jYWNoaW5nX21vZGUoaW9tbXUtPmNhcCkgJiYgaW9tbXVfc2V0X2RtYV9zdHJp
Y3QoZmFsc2UpKQo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcHJfaW5mb19vbmNlKCJJT01N
VSBiYXRjaGluZyBkaXNhbGxvd2VkIGR1ZSB0byAKPiB2aXJ0dWFsaXphdGlvblxuIik7Cj4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgaW9tbXVfc2V0X2RtYV9zdHJpY3QodHJ1ZSk7Cj4gLcKgwqDC
oMKgwqDCoMKgIH0KPiAgwqDCoMKgwqDCoMKgwqDCoCBpb21tdV9kZXZpY2Vfc3lzZnNfYWRkKCZp
b21tdS0+aW9tbXUsIE5VTEwsCj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgaW50ZWxfaW9tbXVfZ3JvdXBzLAo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICIlcyIsIGlvbW11LT5uYW1lKTsKPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9pb21tdS9pb21tdS5jIGIvZHJpdmVycy9pb21tdS9pb21tdS5jCj4gaW5kZXgg
NjBiMWVjNDJlNzNiLi4xNDM0YmVlNjRhZjMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9pb21tdS9p
b21tdS5jCj4gKysrIGIvZHJpdmVycy9pb21tdS9pb21tdS5jCj4gQEAgLTM0OSwxMCArMzQ5LDE0
IEBAIHN0YXRpYyBpbnQgX19pbml0IGlvbW11X2RtYV9zZXR1cChjaGFyICpzdHIpCj4gIMKgfQo+
ICDCoGVhcmx5X3BhcmFtKCJpb21tdS5zdHJpY3QiLCBpb21tdV9kbWFfc2V0dXApOwo+IAo+IC12
b2lkIGlvbW11X3NldF9kbWFfc3RyaWN0KGJvb2wgc3RyaWN0KQo+ICsvKiBSZXR1cm4gdHJ1ZSBp
ZiB3ZSBzZXQgaW9tbXVfZG1hX3N0cmljdCAqLwo+ICtib29sIGlvbW11X3NldF9kbWFfc3RyaWN0
KGJvb2wgZm9yY2UpCj4gIMKgewo+IC3CoMKgwqAgaWYgKHN0cmljdCB8fCAhKGlvbW11X2NtZF9s
aW5lICYgSU9NTVVfQ01EX0xJTkVfU1RSSUNUKSkKPiAtwqDCoMKgwqDCoMKgwqAgaW9tbXVfZG1h
X3N0cmljdCA9IHN0cmljdDsKPiArwqDCoMKgIGlmIChmb3JjZSB8fCAhKGlvbW11X2NtZF9saW5l
ICYgSU9NTVVfQ01EX0xJTkVfU1RSSUNUKSkgewo+ICvCoMKgwqDCoMKgwqDCoCBpb21tdV9kbWFf
c3RyaWN0ID0gdHJ1ZTsKPiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHRydWU7Cj4gK8KgwqDCoCB9
Cj4gK8KgwqDCoCByZXR1cm4gZmFsc2U7Cj4gIMKgfQo+IAo+ICDCoGJvb2wgaW9tbXVfZ2V0X2Rt
YV9zdHJpY3Qoc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluKQo+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL2xpbnV4L2lvbW11LmggYi9pbmNsdWRlL2xpbnV4L2lvbW11LmgKPiBpbmRleCAzMmQ0NDgw
NTBiZjcuLmYxN2IyMDIzNDI5NiAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2lvbW11LmgK
PiArKysgYi9pbmNsdWRlL2xpbnV4L2lvbW11LmgKPiBAQCAtNDc2LDcgKzQ3Niw3IEBAIGludCBp
b21tdV9lbmFibGVfbmVzdGluZyhzdHJ1Y3QgaW9tbXVfZG9tYWluICpkb21haW4pOwo+ICDCoGlu
dCBpb21tdV9zZXRfcGd0YWJsZV9xdWlya3Moc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluLAo+
ICDCoMKgwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcgcXVpcmtzKTsKPiAKPiAtdm9pZCBpb21t
dV9zZXRfZG1hX3N0cmljdChib29sIHZhbCk7Cj4gK2Jvb2wgaW9tbXVfc2V0X2RtYV9zdHJpY3Qo
Ym9vbCBmb3JjZSk7Cj4gIMKgYm9vbCBpb21tdV9nZXRfZG1hX3N0cmljdChzdHJ1Y3QgaW9tbXVf
ZG9tYWluICpkb21haW4pOwo+IAo+ICDCoGV4dGVybiBpbnQgcmVwb3J0X2lvbW11X2ZhdWx0KHN0
cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbiwgc3RydWN0IAo+IGRldmljZSAqZGV2LApfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxp
c3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
