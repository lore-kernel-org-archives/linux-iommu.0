Return-Path: <SRS0=4FG6=EM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367EFC4741F
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 15:22:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96E26208C7
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 15:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96E26208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 044BC858C6;
	Fri,  6 Nov 2020 15:22:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uEH59XOnAKfM; Fri,  6 Nov 2020 15:22:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A6B06852F8;
	Fri,  6 Nov 2020 15:22:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94BABC088B;
	Fri,  6 Nov 2020 15:22:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08B82C0889
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 15:22:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E16D4871B1
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 15:22:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T3iJJB76aAog for <iommu@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 15:22:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9DDED870E2
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 15:22:07 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1C2914BF;
 Fri,  6 Nov 2020 07:22:06 -0800 (PST)
Received: from [192.168.1.179] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 419073F66E;
 Fri,  6 Nov 2020 07:22:03 -0800 (PST)
Subject: Re: [RFC PATCH 0/4] ACPI/IORT: Support for IORT RMR node
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "devel@acpica.org" <devel@acpica.org>
References: <20201027112646.44680-1-shameerali.kolothum.thodi@huawei.com>
 <f389e864-3d7a-3c96-8f51-c04f92759df1@arm.com>
 <36e3a0e58e334e6aa3c051000d742543@huawei.com>
From: Steven Price <steven.price@arm.com>
Message-ID: <ca4a8e2d-40d9-b08d-7ec9-6a50d37f9126@arm.com>
Date: Fri, 6 Nov 2020 15:22:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <36e3a0e58e334e6aa3c051000d742543@huawei.com>
Content-Language: en-GB
Cc: Linuxarm <linuxarm@huawei.com>,
 "Guohanjun \(Hanjun Guo\)" <guohanjun@huawei.com>,
 Sami Mujawar <Sami.Mujawar@arm.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 wanghuiqiang <wanghuiqiang@huawei.com>
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

T24gMjgvMTAvMjAyMCAxODoyNCwgU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaSB3cm90ZToKPiBI
aSBTdGV2ZSwKPiAKPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPj4gRnJvbTogU3RldmVu
IFByaWNlIFttYWlsdG86c3RldmVuLnByaWNlQGFybS5jb21dCj4+IFNlbnQ6IDI4IE9jdG9iZXIg
MjAyMCAxNjo0NAo+PiBUbzogU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaSA8c2hhbWVlcmFsaS5r
b2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPjsKPj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnOyBsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZzsKPj4gaW9tbXVAbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmc7IGRldmVsQGFjcGljYS5vcmcKPj4gQ2M6IGxvcmVuem8ucGllcmFs
aXNpQGFybS5jb207IGpvcm9AOGJ5dGVzLm9yZzsgSm9uYXRoYW4gQ2FtZXJvbgo+PiA8am9uYXRo
YW4uY2FtZXJvbkBodWF3ZWkuY29tPjsgTGludXhhcm0gPGxpbnV4YXJtQGh1YXdlaS5jb20+Owo+
PiBHdW9oYW5qdW4gKEhhbmp1biBHdW8pIDxndW9oYW5qdW5AaHVhd2VpLmNvbT47IHJvYmluLm11
cnBoeUBhcm0uY29tOwo+PiB3YW5naHVpcWlhbmcgPHdhbmdodWlxaWFuZ0BodWF3ZWkuY29tPjsg
U2FtaSBNdWphd2FyCj4+IDxTYW1pLk11amF3YXJAYXJtLmNvbT4KPj4gU3ViamVjdDogUmU6IFtS
RkMgUEFUQ0ggMC80XSBBQ1BJL0lPUlQ6IFN1cHBvcnQgZm9yIElPUlQgUk1SIG5vZGUKPj4KPj4g
T24gMjcvMTAvMjAyMCAxMToyNiwgU2hhbWVlciBLb2xvdGh1bSB3cm90ZToKPj4+IFRoZSBzZXJp
ZXMgYWRkcyBzdXBwb3J0IHRvIElPUlQgUk1SIG5vZGVzIHNwZWNpZmllZCBpbiBJT1JUCj4+PiBS
ZXZpc2lvbiBFIC1BUk0gREVOIDAwNDlFWzBdLiBSTVIgbm9kZXMgYXJlwqB1c2VkIHRvwqBkZXNj
cmliZSBtZW1vcnkKPj4+IHJhbmdlcyB0aGF0IGFyZSB1c2VkIGJ5IGVuZHBvaW50cyBhbmQgcmVx
dWlyZSBhIHVuaXR5IG1hcHBpbmcKPj4+IGluIFNNTVUuCj4+Cj4+IEhpIFNoYW1lZXIsCj4+Cj4+
IEkndmUgYWxzbyBiZWVuIHRha2luZyBhIGxvb2sgYXQgUk1SLCBhbmQgU2FtaSBpcyBoZWxwaW5n
IG1lIGdldCBzZXQgdXAKPj4gc28gdGhhdCBJIGNhbiBkbyBzb21lIHRlc3RpbmcuIFdlJ3JlIGhv
cGluZyB0byBiZSBhYmxlIHRvIHRlc3QgYW4gRUZJCj4+IGZyYW1lYnVmZmVyIG9yIHNwbGFzaCBz
Y3JlZW4gLSB3aGljaCBoYXMgdGhlIGFkZGVkIGNvbXBsaWNhdGlvbiBvZiB0aGUKPj4gdW5pdHkg
bWFwcGluZyBiZWNvbWluZyByZWR1bmRhbnQgaWYgYSBuYXRpdmUgZGlzcGxheSBkcml2ZXIgdGFr
ZXMgb3Zlcgo+PiB0aGUgZGlzcGxheSBjb250cm9sbGVyLgo+Pgo+PiBJJ3ZlIGxvb2tlZCB0aHJv
dWdoIHlvdXIgc2VyaWVzIGFuZCB0aGUgY29kZSBsb29rcyBjb3JyZWN0IHRvIG1lLgo+IAo+IFRo
YW5rcyBmb3IgdGFraW5nIGEgbG9vayBhbmQgdGhlIGRldGFpbHMuCj4gCj4+IEhvcGVmdWxseSBJ
J2xsIGJlIGFibGUgdG8gZ2l2ZSBpdCBzb21lIHRlc3Rpbmcgc29vbi4KPiAKPiBDb29sLiBQbGVh
c2UgdXBkYXRlIG9uY2UgeW91IGdldCBhIGNoYW5jZSBydW4gdGhlIHRlc3RzLgoKSGkgU2hhbWVl
ciwKCkp1c3QgdG8gdXBkYXRlIG9uIHRoaXMsIGZvciB0aGUgRUZJIGZyYW1lYnVmZmVyIHVzZSBj
YXNlIEkgaGl0IGV4YWN0bHkgCnRoZSBpc3N1ZSB0aGF0IFJvYmluIGhhcyBtZW50aW9uZWQgaW4g
YW5vdGhlciB0aHJlYWQgLSB0aGUgUk1SIGlzIAplZmZlY3RpdmVseSBpZ25vcmVkIGJlY2F1c2Ug
dGhlIGRpc3BsYXkgY29udHJvbGxlciBpc24ndCBiZWluZyBoYW5kbGVkIApieSBMaW51eCAoc28g
dGhlcmUncyBubyBkZXZpY2UgdG8gbGluayBpdCB0bykuIFRoZSBzcGxhc2ggc2NyZWVuIG1pZ2h0
IApzaW1pbGFybHkgZmxpY2tlciBhcyB0aGUgU01NVSByZXNldCB3aWxsIGluaXRpYWxseSBibG9j
ayB0aGUgdHJhZmZpYyAKYmVmb3JlIHRoZSBSTVIgcmVnaW9uIGlzIGVuYWJsZWQuCgpTdGV2ZQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWls
aW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
