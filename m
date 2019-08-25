Return-Path: <SRS0=GEJm=WV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FACCC3A59E
	for <iommu@archiver.kernel.org>; Sun, 25 Aug 2019 02:07:35 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECC1F205C9
	for <iommu@archiver.kernel.org>; Sun, 25 Aug 2019 02:07:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECC1F205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id AEDA27F6;
	Sun, 25 Aug 2019 02:07:34 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B6A3872A
	for <iommu@lists.linux-foundation.org>;
	Sun, 25 Aug 2019 02:07:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 1176067F
	for <iommu@lists.linux-foundation.org>;
	Sun, 25 Aug 2019 02:07:32 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
	by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	24 Aug 2019 19:07:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,427,1559545200"; d="scan'208";a="173851547"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by orsmga008.jf.intel.com with ESMTP; 24 Aug 2019 19:07:27 -0700
Subject: Re: [BISECTED REGRESSION 5.3-rc2] Marvell 88SE9128 SATA controller
	unusable with intel_iommu=on
To: Stijn Tintel <stijn@linux-ipv6.be>, Joerg Roedel <joro@8bytes.org>
References: <8528653b-f2ad-a85d-437f-6e5dcb12042a@linux-ipv6.be>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <3dc80117-f67c-9b28-bef5-e7977a85b223@linux.intel.com>
Date: Sun, 25 Aug 2019 10:06:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8528653b-f2ad-a85d-437f-6e5dcb12042a@linux-ipv6.be>
Content-Language: en-US
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	iommu@lists.linux-foundation.org, Xu Pengfei <pengfei.xu@intel.com>,
	David Woodhouse <dwmw2@infradead.org>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

SGksCgpJIGFtIGxvb2tpbmcgaW50byB0aGlzIGFuZCB3aWxsIGNvbWUgdXAgd2l0aCBhIGZpeC4K
CkJlc3QgcmVnYXJkcywKQmFvbHUKCk9uIDgvMjUvMTkgMTI6MjAgQU0sIFN0aWpuIFRpbnRlbCB3
cm90ZToKPiBIaSwKPiAKPiBUaGVyZSBpcyBhIGJ1ZyBpbiBrZXJuZWwgNS4zLXJjMiBhbmQgbGF0
ZXIgdGhhdCBicmVha3MgbXkgTWFydmVsbAo+IDg4U0U5MTI4IFNBVEEgY29udHJvbGxlci4gVGhl
IHByb2JsZW0gZG9lcyBub3Qgb2NjdXIgd2hlbiBJIGJvb3Qgd2l0aAo+IGludGVsX2lvbW11PW9m
Zi4gVGhpcyBzZWVtcyB0byBiZSBhIHJlZ3Jlc3Npb24gb2YKPiBodHRwczovL2J1Z3ppbGxhLmtl
cm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTQyNjc5LiBBIHF1aXJrIHdhcyBhZGRlZCB0bwo+IGZp
eCB0aGlzLCBpbiBjYzM0NmE0NzE0YTU5ZDA4YzExOGU4ZjMzZmQ4NjY5MmQzNTYzMTMzLiBUaGlz
IHF1aXJrIGlzCj4gc3RpbGwgaW4gcGxhY2UsIGJ1dCBpdCBhcHBlYXJzIHRoYXQgaXQgaXMgbm8g
bG9uZ2VyIHdvcmtpbmcuCj4gCj4gYXVnIDIzIDE4OjA0OjE3IHRheiBrZXJuZWw6IERNQVI6IERS
SEQ6IGhhbmRsaW5nIGZhdWx0IHN0YXR1cyByZWcgMgo+IGF1ZyAyMyAxODowNDoxNyB0YXoga2Vy
bmVsOiBhdGE3OiBTQVRBIGxpbmsgdXAgNi4wIEdicHMgKFNTdGF0dXMgMTMzCj4gU0NvbnRyb2wg
MzAwKQo+IGF1ZyAyMyAxODowNDoxNyB0YXoga2VybmVsOiBhdGE5OiBTQVRBIGxpbmsgZG93biAo
U1N0YXR1cyAwIFNDb250cm9sIDMwMCkKPiBhdWcgMjMgMTg6MDQ6MTcgdGF6IGtlcm5lbDogYXRh
ODogU0FUQSBsaW5rIGRvd24gKFNTdGF0dXMgMCBTQ29udHJvbCAzMDApCj4gYXVnIDIzIDE4OjA0
OjE3IHRheiBrZXJuZWw6IGF0YTEwOiBTQVRBIGxpbmsgZG93biAoU1N0YXR1cyAwIFNDb250cm9s
IDMwMCkKPiBhdWcgMjMgMTg6MDQ6MTcgdGF6IGtlcm5lbDogYXRhMTE6IFNBVEEgbGluayBkb3du
IChTU3RhdHVzIDAgU0NvbnRyb2wgMzAwKQo+IGF1ZyAyMyAxODowNDoxNyB0YXoga2VybmVsOiBh
dGE1LjAwOiAxOTUzNTI1MTY4IHNlY3RvcnMsIG11bHRpIDE2OiBMQkE0OAo+IE5DUSAoZGVwdGgg
MzIpLCBBQQo+IGF1ZyAyMyAxODowNDoxNyB0YXoga2VybmVsOiBETUFSOiBbRE1BIFJlYWRdIFJl
cXVlc3QgZGV2aWNlIFswOTowMC4xXQo+IGZhdWx0IGFkZHIgZmZmMDAwMDAgW2ZhdWx0IHJlYXNv
biAwMl0gUHJlc2VudCBiaXQgaW4gY29udGV4dCBlbnRyeSBpcyBjbGVhcgo+IC4uLgo+IGF1ZyAy
MyAxODowNDoxNyB0YXoga2VybmVsOiBzZCA1OjA6MDowOiBbc2RlXSBBdHRhY2hlZCBTQ1NJIGRp
c2sKPiBhdWcgMjMgMTg6MDQ6MTcgdGF6IGtlcm5lbDogYXRhMTQuMDA6IHFjIHRpbWVvdXQgKGNt
ZCAweGExKQo+IGF1ZyAyMyAxODowNDoxNyB0YXoga2VybmVsOiBhdGE3LjAwOiBxYyB0aW1lb3V0
IChjbWQgMHhlYykKPiBhdWcgMjMgMTg6MDQ6MTcgdGF6IGtlcm5lbDogYXRhMTQuMDA6IGZhaWxl
ZCB0byBJREVOVElGWSAoSS9PIGVycm9yLAo+IGVycl9tYXNrPTB4NCkKPiBhdWcgMjMgMTg6MDQ6
MTcgdGF6IGtlcm5lbDogYXRhNy4wMDogZmFpbGVkIHRvIElERU5USUZZIChJL08gZXJyb3IsCj4g
ZXJyX21hc2s9MHg0KQo+IGF1ZyAyMyAxODowNDoxNyB0YXoga2VybmVsOiBhdGExNDogU0FUQSBs
aW5rIHVwIDEuNSBHYnBzIChTU3RhdHVzIDExMwo+IFNDb250cm9sIDMwMCkKPiBhdWcgMjMgMTg6
MDQ6MTcgdGF6IGtlcm5lbDogYXRhNzogbGluayBpcyBzbG93IHRvIHJlc3BvbmQsIHBsZWFzZSBi
ZQo+IHBhdGllbnQgKHJlYWR5PTApCj4gYXVnIDIzIDE4OjA0OjE3IHRheiBrZXJuZWw6IGF0YTc6
IENPTVJFU0VUIGZhaWxlZCAoZXJybm89LTE2KQo+IGF1ZyAyMyAxODowNDoxNyB0YXoga2VybmVs
OiBhdGExNC4wMDogcWMgdGltZW91dCAoY21kIDB4YTEpCj4gYXVnIDIzIDE4OjA0OjE3IHRheiBr
ZXJuZWw6IGF0YTE0LjAwOiBmYWlsZWQgdG8gSURFTlRJRlkgKEkvTyBlcnJvciwKPiBlcnJfbWFz
az0weDQpCj4gYXVnIDIzIDE4OjA0OjE3IHRheiBrZXJuZWw6IGF0YTE0OiBTQVRBIGxpbmsgdXAg
MS41IEdicHMgKFNTdGF0dXMgMTEzCj4gU0NvbnRyb2wgMzAwKQo+IGF1ZyAyMyAxODowNDoxNyB0
YXoga2VybmVsOiBhdGE3OiBsaW5rIGlzIHNsb3cgdG8gcmVzcG9uZCwgcGxlYXNlIGJlCj4gcGF0
aWVudCAocmVhZHk9MCkKPiBhdWcgMjMgMTg6MDQ6MTcgdGF6IGtlcm5lbDogYXRhNzogQ09NUkVT
RVQgZmFpbGVkIChlcnJubz0tMTYpCj4gYXVnIDIzIDE4OjA0OjE3IHRheiBrZXJuZWw6IGF0YTc6
IGxpbmsgaXMgc2xvdyB0byByZXNwb25kLCBwbGVhc2UgYmUKPiBwYXRpZW50IChyZWFkeT0wKQo+
IGF1ZyAyMyAxODowNDoxNyB0YXoga2VybmVsOiBhdGExNC4wMDogcWMgdGltZW91dCAoY21kIDB4
YTEpCj4gYXVnIDIzIDE4OjA0OjE3IHRheiBrZXJuZWw6IGF0YTE0LjAwOiBmYWlsZWQgdG8gSURF
TlRJRlkgKEkvTyBlcnJvciwKPiBlcnJfbWFzaz0weDQpCj4gYXVnIDIzIDE4OjA0OjE3IHRheiBr
ZXJuZWw6IGF0YTE0OiBTQVRBIGxpbmsgdXAgMS41IEdicHMgKFNTdGF0dXMgMTEzCj4gU0NvbnRy
b2wgMzAwKQo+IGF1ZyAyMyAxODowNDoxNyB0YXoga2VybmVsOiBhdGE3OiBDT01SRVNFVCBmYWls
ZWQgKGVycm5vPS0xNikKPiBhdWcgMjMgMTg6MDQ6MTcgdGF6IGtlcm5lbDogYXRhNzogbGltaXRp
bmcgU0FUQSBsaW5rIHNwZWVkIHRvIDMuMCBHYnBzCj4gYXVnIDIzIDE4OjA0OjE3IHRheiBrZXJu
ZWw6IGF0YTc6IENPTVJFU0VUIGZhaWxlZCAoZXJybm89LTE2KQo+IGF1ZyAyMyAxODowNDoxNyB0
YXoga2VybmVsOiBhdGE3OiByZXNldCBmYWlsZWQsIGdpdmluZyB1cAo+IAo+IAo+IFRoaXMgaXMg
dGhlIG91dGNvbWUgb2YgZ2l0IGJpc2VjdDoKPiAKPiA1NTc1Mjk0OTRkNzlmM2YxZmFkZDQ4NmRk
MThkMmRlMGIxOWJlNGRhIGlzIHRoZSBmaXJzdCBiYWQgY29tbWl0Cj4gY29tbWl0IDU1NzUyOTQ5
NGQ3OWYzZjFmYWRkNDg2ZGQxOGQyZGUwYjE5YmU0ZGEKPiBBdXRob3I6IEx1IEJhb2x1IDxiYW9s
dS5sdUBsaW51eC5pbnRlbC5jb20+Cj4gRGF0ZTrCoMKgIFR1ZSBKdWwgOSAxMzoyMjo0NSAyMDE5
ICswODAwCj4gCj4gIMKgwqDCoCBpb21tdS92dC1kOiBBdm9pZCBkdXBsaWNhdGVkIHBjaSBkbWEg
YWxpYXMgY29uc2lkZXJhdGlvbgo+IAo+ICDCoMKgwqAgQXMgd2UgaGF2ZSBhYmFuZG9uZWQgdGhl
IGhvbWUtbWFkZSBsYXp5IGRvbWFpbiBhbGxvY2F0aW9uCj4gIMKgwqDCoCBhbmQgZGVsZWdhdGVk
IHRoZSBETUEgZG9tYWluIGxpZmUgY3ljbGUgdXAgdG8gdGhlIGRlZmF1bHQKPiAgwqDCoMKgIGRv
bWFpbiBtZWNoYW5pc20gZGVmaW5lZCBpbiB0aGUgZ2VuZXJpYyBpb21tdSBsYXllciwgd2UKPiAg
wqDCoMKgIG5lZWRuJ3QgY29uc2lkZXIgcGNpIGFsaWFzIGFueW1vcmUgd2hlbiBtYXBwaW5nL3Vu
bWFwcGluZwo+ICDCoMKgwqAgdGhlIGNvbnRleHQgZW50cmllcy4gV2l0aG91dCB0aGlzIGZpeCwg
d2Ugc2VlIGtlcm5lbCBOVUxMCj4gIMKgwqDCoCBwb2ludGVyIGRlcmVmZXJlbmNlIGR1cmluZyBw
Y2kgZGV2aWNlIGhvdC1wbHVnIHRlc3QuCj4gCj4gIMKgwqDCoCBDYzogQXNob2sgUmFqIDxhc2hv
ay5yYWpAaW50ZWwuY29tPgo+ICDCoMKgwqAgQ2M6IEphY29iIFBhbiA8amFjb2IuanVuLnBhbkBs
aW51eC5pbnRlbC5jb20+Cj4gIMKgwqDCoCBDYzogS2V2aW4gVGlhbiA8a2V2aW4udGlhbkBpbnRl
bC5jb20+Cj4gIMKgwqDCoCBGaXhlczogZmE5NTRlNjgzMTc4OSAoImlvbW11L3Z0LWQ6IERlbGVn
YXRlIHRoZSBkbWEgZG9tYWluIHRvIHVwcGVyCj4gbGF5ZXIiKQo+ICDCoMKgwqAgU2lnbmVkLW9m
Zi1ieTogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4KPiAgwqDCoMKgIFJlcG9y
dGVkLWFuZC10ZXN0ZWQtYnk6IFh1IFBlbmdmZWkgPHBlbmdmZWkueHVAaW50ZWwuY29tPgo+ICDC
oMKgwqAgU2lnbmVkLW9mZi1ieTogSm9lcmcgUm9lZGVsIDxqcm9lZGVsQHN1c2UuZGU+Cj4gCj4g
OjA0MDAwMCAwNDAwMDAgMDEwZTcwNTdiODQwMTQ4MWU3MjU4OTQ4Nzg2YTI2NThmOWYxNDAzNwo+
IDE4YWVhYzUwYTYwZDhiODQyNGZjZGNjZDBiMzExOGY1NjVjZTM5MDkgTcKgwqDCoMKgwqAgZHJp
dmVycwo+IAo+IFN0aWpuCj4gCj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by9pb21tdQ==
