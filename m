Return-Path: <SRS0=4FG6=EM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEB1C2D0A3
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 17:09:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B66412072E
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 17:09:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B66412072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 38B958489C;
	Fri,  6 Nov 2020 17:09:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b61IjMik1B1B; Fri,  6 Nov 2020 17:09:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D9D2E84973;
	Fri,  6 Nov 2020 17:09:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C25BDC0893;
	Fri,  6 Nov 2020 17:09:26 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47485C0889
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 17:09:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2F5C587534
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 17:09:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Dmdr8Vr96iWO for <iommu@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 17:09:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id C3F2987533
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 17:09:24 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 090FC1474;
 Fri,  6 Nov 2020 09:09:24 -0800 (PST)
Received: from [10.57.54.223] (unknown [10.57.54.223])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 76B013F66E;
 Fri,  6 Nov 2020 09:09:21 -0800 (PST)
Subject: Re: [RFC PATCH 0/4] ACPI/IORT: Support for IORT RMR node
To: Steven Price <steven.price@arm.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "devel@acpica.org" <devel@acpica.org>
References: <20201027112646.44680-1-shameerali.kolothum.thodi@huawei.com>
 <f389e864-3d7a-3c96-8f51-c04f92759df1@arm.com>
 <36e3a0e58e334e6aa3c051000d742543@huawei.com>
 <ca4a8e2d-40d9-b08d-7ec9-6a50d37f9126@arm.com>
 <ad2f8ea7821f4b728ab32b61e4a6121e@huawei.com>
 <5ce01d8d-c2dc-8c13-0f48-b3b35254c810@arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <fa51fe8a-9c69-6800-7ccc-9b7f6ef52790@arm.com>
Date: Fri, 6 Nov 2020 17:09:19 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <5ce01d8d-c2dc-8c13-0f48-b3b35254c810@arm.com>
Content-Language: en-GB
Cc: Linuxarm <linuxarm@huawei.com>,
 "Guohanjun \(Hanjun Guo\)" <guohanjun@huawei.com>,
 Sami Mujawar <Sami.Mujawar@arm.com>, wanghuiqiang <wanghuiqiang@huawei.com>
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

T24gMjAyMC0xMS0wNiAxNjoyNiwgU3RldmVuIFByaWNlIHdyb3RlOgo+IE9uIDA2LzExLzIwMjAg
MTY6MTcsIFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkgd3JvdGU6Cj4+Cj4+Cj4+PiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQo+Pj4gRnJvbTogU3RldmVuIFByaWNlIFttYWlsdG86c3RldmVu
LnByaWNlQGFybS5jb21dCj4+PiBTZW50OiAwNiBOb3ZlbWJlciAyMDIwIDE1OjIyCj4+PiBUbzog
U2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaSA8c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3
ZWkuY29tPjsKPj4+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgt
YWNwaUB2Z2VyLmtlcm5lbC5vcmc7Cj4+PiBpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZzsgZGV2ZWxAYWNwaWNhLm9yZwo+Pj4gQ2M6IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IGpv
cm9AOGJ5dGVzLm9yZzsgSm9uYXRoYW4gQ2FtZXJvbgo+Pj4gPGpvbmF0aGFuLmNhbWVyb25AaHVh
d2VpLmNvbT47IExpbnV4YXJtIDxsaW51eGFybUBodWF3ZWkuY29tPjsKPj4+IEd1b2hhbmp1biAo
SGFuanVuIEd1bykgPGd1b2hhbmp1bkBodWF3ZWkuY29tPjsgU2FtaSBNdWphd2FyCj4+PiA8U2Ft
aS5NdWphd2FyQGFybS5jb20+OyByb2Jpbi5tdXJwaHlAYXJtLmNvbTsgd2FuZ2h1aXFpYW5nCj4+
PiA8d2FuZ2h1aXFpYW5nQGh1YXdlaS5jb20+Cj4+PiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCAw
LzRdIEFDUEkvSU9SVDogU3VwcG9ydCBmb3IgSU9SVCBSTVIgbm9kZQo+Pj4KPj4+IE9uIDI4LzEw
LzIwMjAgMTg6MjQsIFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkgd3JvdGU6Cj4+Pj4gSGkgU3Rl
dmUsCj4+Pj4KPj4+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPj4+Pj4gRnJvbTogU3Rl
dmVuIFByaWNlIFttYWlsdG86c3RldmVuLnByaWNlQGFybS5jb21dCj4+Pj4+IFNlbnQ6IDI4IE9j
dG9iZXIgMjAyMCAxNjo0NAo+Pj4+PiBUbzogU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaSA8c2hh
bWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPjsKPj4+Pj4gbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZzsKPj4+Pj4g
aW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7IGRldmVsQGFjcGljYS5vcmcKPj4+Pj4g
Q2M6IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IGpvcm9AOGJ5dGVzLm9yZzsgSm9uYXRoYW4g
Q2FtZXJvbgo+Pj4+PiA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPjsgTGludXhhcm0gPGxp
bnV4YXJtQGh1YXdlaS5jb20+Owo+Pj4+PiBHdW9oYW5qdW4gKEhhbmp1biBHdW8pIDxndW9oYW5q
dW5AaHVhd2VpLmNvbT47Cj4+PiByb2Jpbi5tdXJwaHlAYXJtLmNvbTsKPj4+Pj4gd2FuZ2h1aXFp
YW5nIDx3YW5naHVpcWlhbmdAaHVhd2VpLmNvbT47IFNhbWkgTXVqYXdhcgo+Pj4+PiA8U2FtaS5N
dWphd2FyQGFybS5jb20+Cj4+Pj4+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIDAvNF0gQUNQSS9J
T1JUOiBTdXBwb3J0IGZvciBJT1JUIFJNUiBub2RlCj4+Pj4+Cj4+Pj4+IE9uIDI3LzEwLzIwMjAg
MTE6MjYsIFNoYW1lZXIgS29sb3RodW0gd3JvdGU6Cj4+Pj4+PiBUaGUgc2VyaWVzIGFkZHMgc3Vw
cG9ydCB0byBJT1JUIFJNUiBub2RlcyBzcGVjaWZpZWQgaW4gSU9SVAo+Pj4+Pj4gUmV2aXNpb24g
RSAtQVJNIERFTiAwMDQ5RVswXS4gUk1SIG5vZGVzIGFyZcKgdXNlZCB0b8KgZGVzY3JpYmUgbWVt
b3J5Cj4+Pj4+PiByYW5nZXMgdGhhdCBhcmUgdXNlZCBieSBlbmRwb2ludHMgYW5kIHJlcXVpcmUg
YSB1bml0eSBtYXBwaW5nCj4+Pj4+PiBpbiBTTU1VLgo+Pj4+Pgo+Pj4+PiBIaSBTaGFtZWVyLAo+
Pj4+Pgo+Pj4+PiBJJ3ZlIGFsc28gYmVlbiB0YWtpbmcgYSBsb29rIGF0IFJNUiwgYW5kIFNhbWkg
aXMgaGVscGluZyBtZSBnZXQgc2V0IHVwCj4+Pj4+IHNvIHRoYXQgSSBjYW4gZG8gc29tZSB0ZXN0
aW5nLiBXZSdyZSBob3BpbmcgdG8gYmUgYWJsZSB0byB0ZXN0IGFuIEVGSQo+Pj4+PiBmcmFtZWJ1
ZmZlciBvciBzcGxhc2ggc2NyZWVuIC0gd2hpY2ggaGFzIHRoZSBhZGRlZCBjb21wbGljYXRpb24g
b2YgdGhlCj4+Pj4+IHVuaXR5IG1hcHBpbmcgYmVjb21pbmcgcmVkdW5kYW50IGlmIGEgbmF0aXZl
IGRpc3BsYXkgZHJpdmVyIHRha2VzIG92ZXIKPj4+Pj4gdGhlIGRpc3BsYXkgY29udHJvbGxlci4K
Pj4+Pj4KPj4+Pj4gSSd2ZSBsb29rZWQgdGhyb3VnaCB5b3VyIHNlcmllcyBhbmQgdGhlIGNvZGUg
bG9va3MgY29ycmVjdCB0byBtZS4KPj4+Pgo+Pj4+IFRoYW5rcyBmb3IgdGFraW5nIGEgbG9vayBh
bmQgdGhlIGRldGFpbHMuCj4+Pj4KPj4+Pj4gSG9wZWZ1bGx5IEknbGwgYmUgYWJsZSB0byBnaXZl
IGl0IHNvbWUgdGVzdGluZyBzb29uLgo+Pj4+Cj4+Pj4gQ29vbC4gUGxlYXNlIHVwZGF0ZSBvbmNl
IHlvdSBnZXQgYSBjaGFuY2UgcnVuIHRoZSB0ZXN0cy4KPj4+Cj4+PiBIaSBTaGFtZWVyLAo+Pgo+
PiBIaSBTdGV2ZSwKPj4KPj4+IEp1c3QgdG8gdXBkYXRlIG9uIHRoaXMsIGZvciB0aGUgRUZJIGZy
YW1lYnVmZmVyIHVzZSBjYXNlIEkgaGl0IGV4YWN0bHkKPj4+IHRoZSBpc3N1ZSB0aGF0IFJvYmlu
IGhhcyBtZW50aW9uZWQgaW4gYW5vdGhlciB0aHJlYWQgLSB0aGUgUk1SIGlzCj4+PiBlZmZlY3Rp
dmVseSBpZ25vcmVkIGJlY2F1c2UgdGhlIGRpc3BsYXkgY29udHJvbGxlciBpc24ndCBiZWluZyBo
YW5kbGVkCj4+PiBieSBMaW51eCAoc28gdGhlcmUncyBubyBkZXZpY2UgdG8gbGluayBpdCB0byku
Cj4+Cj4+IFRoYW5rcyBmb3IgdGhlIHVwZGF0ZS4gSGVyZSwgYnkgImlnbm9yZWQgInlvdSBtZWFu
dCBnZXRfcmVzdl9yZWdpb25zKCkKPj4gaXMgbm90IGNhbGxlZCBvciBub3Q/Cj4gCj4gZ2V0X3Jl
c3ZfcmVnaW9ucygpIGlzbid0IGNhbGxlZC4KClJpZ2h0LCBBSVVJIHRoZSBFRkkgZnJhbWVidWZm
ZXIgImRldmljZSIgcHJldHR5IG11Y2gganVzdCByZXByZXNlbnRzIGEgCm1hZ2ljIHJlZ2lvbiBv
ZiBSQU0sIHdob3NlIGV4aXN0ZW5jZSBpcyBiYXNlZCBvbiBFRkkgc2VydmljZXMgLSBzZWUgCnJl
Z2lzdGVyX2dvcF9kZXZpY2UoKSAtIHJlZ2FyZGxlc3Mgb2Ygd2hldGhlciB0aGUgdW5kZXJseWlu
ZyBwaHlzaWNhbCAKaGFyZHdhcmUgaXMgZGVzY3JpYmVkIGluIERTRFQgYW5kIElPUlQgc3VjaCB0
aGF0IGEgdGFuZ2VudGlhbCAKaW9tbXVfcHJvYmVfZGV2aWNlKCkgY2FsbCBtaWdodCBoYXBwZW4g
YXQgYWxsLgoKUm9iaW4uCgo+PiDCoCBUaGUgc3BsYXNoIHNjcmVlbiBtaWdodAo+Pj4gc2ltaWxh
cmx5IGZsaWNrZXIgYXMgdGhlIFNNTVUgcmVzZXQgd2lsbCBpbml0aWFsbHkgYmxvY2sgdGhlIHRy
YWZmaWMKPj4+IGJlZm9yZSB0aGUgUk1SIHJlZ2lvbiBpcyBlbmFibGVkLgo+Pgo+PiBEb2VzIHRo
YXQgbWVhbiB5b3Ugc29tZWhvdyBtYW5hZ2VkIHRvIG1ha2UgdGhlIHVuaXR5Cj4+IG1hcHBpbmcg
YnV0IHRoZXJlIHdhcyBmbGlja2VyIGR1cmluZyB0aGUgU01NVSByZXNldCB0bwo+PiB1bml0eSBt
YXBwaW5nIHNldHVwIHBlcmlvZC4gU29ycnkgSSBhbSB0cnlpbmcgdG8gdW5kZXJzdGFuZAo+PiB0
aGUgZXhhY3QgYmVoYXZpb3Igb2JzZXJ2ZWQgaW4gdGhpcyBjYXNlLgo+IAo+IEkgaGF2ZW4ndCB5
ZXQgZ290IHRoaXMgY29tcGxldGVseSB3b3JraW5nIChvbiB0aGUgYm9hcmQgd2hpY2ggSSdtIAo+
IHRlc3RpbmcgdGhlIGRpc3BsYXkgY29udHJvbGxlciBkb2Vzbid0IGhhdmUgYW55IGV4aXN0aW5n
IEFDUEkgYmluZGluZ3MpLiAKPiBIb3dldmVyIGZyb20gd2hhdCBJIHVuZGVyc3RhbmQgdGhlIFNN
TVUgcmVzZXQgd291bGQgYmxvY2sgYWxsIG1lbW9yeSAKPiBhY2Nlc3MgZm9yIHRoZSBkaXNwbGF5
IGNvbnRyb2xsZXIgYmVmb3JlIHRoZSBSTVIgcmVnaW9uIHdvdWxkIGJlIHNldHVwLiAKPiBJJ20g
Z29pbmcgdG8gdHJ5IHRvIGdldCB0aGUgZGlzcGxheSBjb250cm9sbGVyIHdvcmtpbmcgd2l0aCBB
Q1BJIHNvIEkgCj4gY2FuIHRlc3QgdGhpcyBwcm9wZXJseS4KPiAKPiBTdGV2ZQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QK
aW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
