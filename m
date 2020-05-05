Return-Path: <SRS0=kPPe=6T=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C14C47247
	for <iommu@archiver.kernel.org>; Tue,  5 May 2020 17:14:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7708206B9
	for <iommu@archiver.kernel.org>; Tue,  5 May 2020 17:14:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7708206B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7FA388799D;
	Tue,  5 May 2020 17:14:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l2dGqtqcT3cI; Tue,  5 May 2020 17:14:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E9C4A87954;
	Tue,  5 May 2020 17:14:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D48CCC088B;
	Tue,  5 May 2020 17:14:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C1B6CC0175
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 17:14:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B0C7087954
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 17:14:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HEWE-w6Pe22C for <iommu@lists.linux-foundation.org>;
 Tue,  5 May 2020 17:13:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 93FAF87855
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 17:13:59 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F208031B;
 Tue,  5 May 2020 10:13:58 -0700 (PDT)
Received: from [192.168.2.22] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 881A83F305;
 Tue,  5 May 2020 10:13:52 -0700 (PDT)
Subject: Re: [PATCH 00/16] dts/dt-bindings: Fix Arm Ltd. ARMv8 "boards"
To: Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
 Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20200505165212.76466-1-andre.przywara@arm.com>
 <20200505165212.76466-3-andre.przywara@arm.com>
 <468a97b2-ed4d-382b-262b-6c0cd3025696@arm.com>
From: =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Organization: ARM Ltd.
Message-ID: <071f00e4-0658-d007-f70c-d2b9e4e3e5c6@arm.com>
Date: Tue, 5 May 2020 18:13:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <468a97b2-ed4d-382b-262b-6c0cd3025696@arm.com>
Content-Language: en-US
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
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

T24gMDUvMDUvMjAyMCAxODowNiwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIwMjAtMDUtMDUg
NTo1MSBwbSwgQW5kcmUgUHJ6eXdhcmEgd3JvdGU6Cj4+IERhdGU6IE1vbiwgNCBNYXkgMjAyMCAx
Mjo0Mjo0OSArMDEwMAo+PiBTdWJqZWN0OiBbUEFUQ0ggMDIvMTZdIGR0LWJpbmRpbmdzOiBhcm0t
c21tdTogQWxsb3cgbW11LTQwMCxzbW11LXYxCj4+IGNvbXBhdGlibGUKPiAKPiBeXiBub3Qgc3Vy
ZSBob3cgeW91IG1hbmFnZWQgdGhhdC4uLgoKSW1wcmVzc2l2ZSwgaHVoPyA7LSkKQWN0dWFsbHkg
anVzdCBhbiBhY2NpZGVudGFsIGVtcHR5IGxpbmUgd2hlbiBhZGRpbmcgQ2M6IGxpbmVzIHRvIHRo
ZQpoZWFkZXIgKGNvcHkgJiBwYXN0ZSB3aXRoIEVPTCkuIFVzaW5nIHRoZSBwcmV2aW91cyBzdWJq
ZWN0IGxpbmUgaXMKcHJvYmFibHkgYW4gYXJ0ZWZhY3Qgb2YgaG93IGdpdCBzZW5kLWVtYWlsIHdv
cmtzLgoKU29ycnkgZm9yIHRoYXQhCkkgZmlndXJlZCB0aGF0IHJlcGx5aW5nIHdvdWxkIGNyZWF0
ZSBtb3JlIGNodXJuLCBhcyB0aGUgYWN0dWFsIHN1YmplY3QKbGluZSBpcyBzdGlsbCBpbiB0aGUg
ZW1haWwuCgo+IAo+PiBUaGUgQXJtIFNNTVV2MSBEVCBiaW5kaW5nIG9ubHkgYWxsb3dzIGNvbWJp
bmluZyBhcm0sbW11LTQwMSB3aXRoCj4+IGFybSxzbW11LXYxLCBldmVuIHRob3VnaCB0aGUgTU1V
LTQwMCBpcyBjb21wYXRpYmxlIGFzIHdlbGwuCj4+Cj4+IEFsbG93IHRoaXMgY29tYmluYXRpb24g
YXMgd2VsbCB0byBsZXQgdGhlIEFybSBKdW5vIGJvYXJkIHBhc3MgdGhlIHRlc3QuCj4gCj4gQWNr
ZWQtYnk6IFJvYmluIE11cnBoeSA8cm9iaW4ubXVycGh5QGFybS5jb20+CgpUaGFua3MhCgpDaGVl
cnMsCkFuZHJlCgo+IAo+PiBTaWduZWQtb2ZmLWJ5OiBBbmRyZSBQcnp5d2FyYSA8YW5kcmUucHJ6
eXdhcmFAYXJtLmNvbT4KPj4gLS0tCj4+IMKgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9pb21tdS9hcm0sc21tdS55YW1sIHwgNCArKystCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAz
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPj4KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pb21tdS9hcm0sc21tdS55YW1sCj4+IGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lvbW11L2FybSxzbW11LnlhbWwKPj4gaW5kZXgg
NjUxNWRiZTQ3NTA4Li5lM2VmMWM2OWQxMzIgMTAwNjQ0Cj4+IC0tLSBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9pb21tdS9hcm0sc21tdS55YW1sCj4+ICsrKyBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pb21tdS9hcm0sc21tdS55YW1sCj4+IEBAIC00MSw3
ICs0MSw5IEBAIHByb3BlcnRpZXM6Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLSBjb25zdDog
YXJtLG1tdS01MDAKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIGNvbnN0OiBhcm0sc21tdS12
Mgo+PiDCoMKgwqDCoMKgwqDCoCAtIGl0ZW1zOgo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgIC0gY29u
c3Q6IGFybSxtbXUtNDAxCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqAgLSBlbnVtOgo+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgLSBhcm0sbW11LTQwMAo+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgLSBhcm0sbW11LTQwMQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0gY29uc3Q6
IGFybSxzbW11LXYxCj4+IMKgwqDCoMKgwqDCoMKgIC0gZW51bToKPj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAtIGFybSxzbW11LXYxCj4+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vaW9tbXU=
