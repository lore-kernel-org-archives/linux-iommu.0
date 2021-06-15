Return-Path: <SRS0=7V87=LJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E73C48BE8
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 19:36:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEB27613C7
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 19:36:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEB27613C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9148940148;
	Tue, 15 Jun 2021 19:36:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LNJF_dyp9UWg; Tue, 15 Jun 2021 19:36:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 69DBA40133;
	Tue, 15 Jun 2021 19:36:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1B09EC000E;
	Tue, 15 Jun 2021 19:36:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39802C000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 19:36:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1364D606D0
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 19:36:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iXctHFpUDuX3 for <iommu@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 19:36:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 104AB60873
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 19:36:15 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4300FED1;
 Tue, 15 Jun 2021 12:36:15 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27A963F694;
 Tue, 15 Jun 2021 12:36:14 -0700 (PDT)
Subject: Re: [PATCH v3 2/6] iommu/amd: Do not use flush-queue when NpCache is
 on
To: Nadav Amit <namit@vmware.com>
References: <20210607182541.119756-1-namit@vmware.com>
 <20210607182541.119756-3-namit@vmware.com>
 <afd4e764-a003-32eb-c50e-a77543772db0@arm.com>
 <13D6A169-4323-435A-A858-A9A78E85DF2D@vmware.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <3c9a7293-75eb-cd76-7592-a23554c6e458@arm.com>
Date: Tue, 15 Jun 2021 20:36:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <13D6A169-4323-435A-A858-A9A78E85DF2D@vmware.com>
Content-Language: en-GB
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Jiajun Cao <caojiajun@vmware.com>, Will Deacon <will@kernel.org>
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

T24gMjAyMS0wNi0xNSAxOToyNiwgTmFkYXYgQW1pdCB3cm90ZToKPiAKPiAKPj4gT24gSnVuIDE1
LCAyMDIxLCBhdCA2OjA4IEFNLCBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPiB3
cm90ZToKPj4KPj4gT24gMjAyMS0wNi0wNyAxOToyNSwgTmFkYXYgQW1pdCB3cm90ZToKPj4+IEZy
b206IE5hZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+Cj4+PiBEbyBub3QgdXNlIGZsdXNoLXF1
ZXVlIG9uIHZpcnR1YWxpemVkIGVudmlyb25tZW50cywgd2hlcmUgdGhlIE5wQ2FjaGUKPj4+IGNh
cGFiaWxpdHkgb2YgdGhlIElPTU1VIGlzIHNldC4gVGhpcyBpcyByZXF1aXJlZCB0byByZWR1Y2UK
Pj4+IHZpcnR1YWxpemF0aW9uIG92ZXJoZWFkcy4KPj4+IFRoaXMgY2hhbmdlIGZvbGxvd3MgYSBz
aW1pbGFyIGNoYW5nZSB0byBJbnRlbCdzIFZULWQgYW5kIGEgZGV0YWlsZWQKPj4+IGV4cGxhbmF0
aW9uIGFzIGZvciB0aGUgcmF0aW9uYWxlIGlzIGRlc2NyaWJlZCBpbiBjb21taXQgMjliMzI4Mzk3
MjVmCj4+PiAoImlvbW11L3Z0LWQ6IERvIG5vdCB1c2UgZmx1c2gtcXVldWUgd2hlbiBjYWNoaW5n
LW1vZGUgaXMgb24iKS4KPj4+IENjOiBKb2VyZyBSb2VkZWwgPGpvcm9AOGJ5dGVzLm9yZz4KPj4+
IENjOiBXaWxsIERlYWNvbiA8d2lsbEBrZXJuZWwub3JnPgo+Pj4gQ2M6IEppYWp1biBDYW8gPGNh
b2ppYWp1bkB2bXdhcmUuY29tPgo+Pj4gQ2M6IFJvYmluIE11cnBoeSA8cm9iaW4ubXVycGh5QGFy
bS5jb20+Cj4+PiBDYzogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4KPj4+IENj
OiBpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwo+Pj4gQ2M6IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmcKPj4+IFNpZ25lZC1vZmYtYnk6IE5hZGF2IEFtaXQgPG5hbWl0QHZtd2Fy
ZS5jb20+Cj4+PiAtLS0KPj4+ICAgZHJpdmVycy9pb21tdS9hbWQvaW5pdC5jIHwgNyArKysrKyst
Cj4+PiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2FtZC9pbml0LmMgYi9kcml2ZXJzL2lvbW11L2Ft
ZC9pbml0LmMKPj4+IGluZGV4IGQwMDY3MjRmNGRjMi4uYmEzYjc2ZWQ3NzZkIDEwMDY0NAo+Pj4g
LS0tIGEvZHJpdmVycy9pb21tdS9hbWQvaW5pdC5jCj4+PiArKysgYi9kcml2ZXJzL2lvbW11L2Ft
ZC9pbml0LmMKPj4+IEBAIC0xODUwLDggKzE4NTAsMTMgQEAgc3RhdGljIGludCBfX2luaXQgaW9t
bXVfaW5pdF9wY2koc3RydWN0IGFtZF9pb21tdSAqaW9tbXUpCj4+PiAgIAlpZiAocmV0KQo+Pj4g
ICAJCXJldHVybiByZXQ7Cj4+PiAgIC0JaWYgKGlvbW11LT5jYXAgJiAoMVVMIDw8IElPTU1VX0NB
UF9OUENBQ0hFKSkKPj4+ICsJaWYgKGlvbW11LT5jYXAgJiAoMVVMIDw8IElPTU1VX0NBUF9OUENB
Q0hFKSkgewo+Pj4gKwkJaWYgKCFhbWRfaW9tbXVfdW5tYXBfZmx1c2gpCj4+PiArCQkJcHJfd2Fy
bl9vbmNlKCJJT01NVSBiYXRjaGluZyBpcyBkaXNhYmxlZCBkdWUgdG8gdmlydHVhbGl6YXRpb24i
KTsKPj4KPj4gTml0OiB5b3UgY2FuIGp1c3QgdXNlIHByX3dhcm4oKSAob3IgYXJndWFibHkgcHJf
aW5mbygpKSBzaW5jZSB0aGUgZXhwbGljaXQgY29uZGl0aW9ucyBhbHJlYWR5IG9ubHkgbWF0Y2gg
b25jZS4KPiAKPiBZZXMsIG15IGJhZC4gSSB3aWxsIGZpeCBpdCBpbiB0aGUgbmV4dCB2ZXJzaW9u
Lgo+IAo+PiBTcGVha2luZyBvZiB3aGljaCwgaXQgbWlnaHQgYmUgYmV0dGVyIHRvIHVzZSBhbWRf
aW9tbXVfbnBfY2FjaGUgaW5zdGVhZCwgc2luY2Ugb3RoZXIgcGF0Y2hlcyBhcmUgcGxhbm5pbmcg
dG8gY2xlYW4gdXAgdGhlIGxhc3QgcmVtbmFudHMgb2YgYW1kX2lvbW11X3VubWFwX2ZsdXNoLgo+
IAo+IEkgcHJlZmVyIHRoYXQgdGhlIG90aGVyIHBhdGNoZXMgKHRoYXQgcmVtb3ZlIGFtZF9pb21t
dV91bm1hcF9mbHVzaCkgd291bGQgYWRkcmVzcyB0aGlzIGNvZGUgYXMgd2VsbC4gSSBjZXJ0YWlu
bHkgZG8gbm90IHdhbnQgdG8gZW1iZWQgYW1kX2lvbW11X25wX2NhY2hlIGRlZXAgaW50byB0aGUg
Zmx1c2hpbmcgbG9naWMuIElPVzogSSBkb27igJl0IGtub3cgd2hhdCB5b3UgaGF2ZSBleGFjdGx5
IGluIG1pbmQsIGJ1dCBJIHByZWZlciB0aGUgY29kZSB3b3VsZCBiZSBjbGVhci4KPiAKPiBUaGlz
IGNvZGUgZm9sbG93cyAoY29waWVzPykgdGhlIHNhbWUgcGF0dGVybitsb2dpYyBmcm9tIGNvbW1p
dCA1ZjMxMTZlYThiNSAoImlvbW11L3Z0LWQ6IERvIG5vdCB1c2UgZmx1c2gtcXVldWUgd2hlbiBj
YWNoaW5nLW1vZGUgaXMgb27igJ0pLiBJIHNlZSB0aGF0IGNoYW5nZWQgdGhlIGNvZGUgaW4gY29t
bWl0IDUzMjU1ZTU0NTgwN2MgKCJpb21tdTogcmVtb3ZlIERPTUFJTl9BVFRSX0RNQV9VU0VfRkxV
U0hfUVVFVUXigJ0pLCBidXQgZGlkIG5vdCBnZXQgcmlkIG9mIGludGVsX2lvbW11X3N0cmljdCwg
c28gcGxlYXNlIGFsbG93IG1lIHRvIHVzZSBhbWRfaW9tbXVfdW5tYXBfZmx1c2guCgpTdXJlLCBp
dCB3YXMganVzdCBhIHN1Z2dlc3Rpb24gdG8gcHJlLXJlc29sdmUgb25lIGxpbmUgb2YgbWVyZ2Ug
Y29uZmxpY3QgCndpdGggYW5vdGhlciBzZXJpZXNbMV0gd2hpY2ggaXMgYWxzbyBhbG1vc3QgcmVh
ZHksIGFuZCByZW1vdmVzIHRob3NlIApsb2NhbCB2YXJpYWJsZXMgZm9yIGJvdGggQU1EIGFuZCBJ
bnRlbC4gQnV0IHRoZXJlIHdpbGwgc3RpbGwgYmUgb3RoZXIgCmNvbmZsaWN0cyBlaXRoZXIgd2F5
LCBzbyBpdCdzIG5vdCBhIGJpZyBkZWFsLgoKUm9iaW4uCgpbMV0gCmh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xpbnV4LWlvbW11LzE2MjM0MTQwNDMtNDA3NDUtNS1naXQtc2VuZC1lbWFpbC1qb2hu
LmdhcnJ5QGh1YXdlaS5jb20vCgo+IFRvIHJlbWluZCB5b3UvbWUvd2hvZXZlcjogZGlzYWJsaW5n
IGJhdGNoaW5nIGR1ZSB0byBjYWNoaW5nLW1vZGUvTlAtY2FjaGUgaXMgbm90IGluaGVyZW50bHkg
bmVlZGVkLiBJdCB3YXMgbm90IG5lZWRlZCBmb3IgcXVpdGUgc29tZSB0aW1lIG9uIEludGVsLCBi
dXQgc29tZWhvdyBhbG9uZyB0aGUgd2F5IHRoZSBjb25zb2xpZGF0ZWQgZmx1c2hpbmcgY29kZSBi
cm9rZSBpdCwgYW5kIG5vdyBpdCBpcyBuZWVkZWQgKHdpdGhvdXQgaW50cnVzaXZlIGNvZGUgY2hh
bmdlcykuCj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
