Return-Path: <SRS0=acbz=LZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD27C11F64
	for <iommu@archiver.kernel.org>; Thu,  1 Jul 2021 09:11:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9140D61585
	for <iommu@archiver.kernel.org>; Thu,  1 Jul 2021 09:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9140D61585
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5B83A401E7;
	Thu,  1 Jul 2021 09:11:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lV5avzcoB7dG; Thu,  1 Jul 2021 09:11:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 406E640118;
	Thu,  1 Jul 2021 09:11:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F301DC001A;
	Thu,  1 Jul 2021 09:11:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EBE0BC000E
 for <iommu@lists.linux-foundation.org>; Thu,  1 Jul 2021 09:11:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C8C4483BB0
 for <iommu@lists.linux-foundation.org>; Thu,  1 Jul 2021 09:11:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E06lfqjQayZj for <iommu@lists.linux-foundation.org>;
 Thu,  1 Jul 2021 09:11:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id D8DCD83BAA
 for <iommu@lists.linux-foundation.org>; Thu,  1 Jul 2021 09:11:08 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EED21D6E;
 Thu,  1 Jul 2021 02:11:07 -0700 (PDT)
Received: from [10.57.40.45] (unknown [10.57.40.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8231E3F5A1;
 Thu,  1 Jul 2021 02:11:06 -0700 (PDT)
Subject: Re: [PATCH] iommu/arm: Cleanup resources in case of probe error path
To: Will Deacon <will@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>
References: <20210608164559.204023-1-ameynarkhede03@gmail.com>
 <CGME20210630124816eucas1p27563f0a456c0196e20937619aa2f8d26@eucas1p2.samsung.com>
 <26f6a765-37c8-d63a-a779-384f095d5770@samsung.com>
 <20210630125940.GA8515@willie-the-truck>
 <4e3b1685-323e-2a7e-3aae-7c21b28fc65f@samsung.com>
 <bc07bd52-ed2e-0a44-80a7-36b581018b40@arm.com>
 <d3fee5f3-a435-7aa8-62ae-060e9b2aa532@samsung.com>
 <20210701090112.GA9489@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <bf8d3101-1db7-ee5a-377c-2196e3ce84e3@arm.com>
Date: Thu, 1 Jul 2021 10:11:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210701090112.GA9489@willie-the-truck>
Content-Language: en-GB
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 linux-kernel@vger.kernel.org, Amey Narkhede <ameynarkhede03@gmail.com>,
 Jon Hunter <jonathanh@nvidia.com>, iommu@lists.linux-foundation.org,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

T24gMjAyMS0wNy0wMSAxMDowMSwgV2lsbCBEZWFjb24gd3JvdGU6Cj4gT24gVGh1LCBKdWwgMDEs
IDIwMjEgYXQgMTA6Mjk6MjlBTSArMDIwMCwgTWFyZWsgU3p5cHJvd3NraSB3cm90ZToKPj4gSGkg
Um9iaW4sCj4+Cj4+IE9uIDMwLjA2LjIwMjEgMTY6MDEsIFJvYmluIE11cnBoeSB3cm90ZToKPj4+
IE9uIDIwMjEtMDYtMzAgMTQ6NDgsIE1hcmVrIFN6eXByb3dza2kgd3JvdGU6Cj4+Pj4gT24gMzAu
MDYuMjAyMSAxNDo1OSwgV2lsbCBEZWFjb24gd3JvdGU6Cj4+Pj4+IE9uIFdlZCwgSnVuIDMwLCAy
MDIxIGF0IDAyOjQ4OjE1UE0gKzAyMDAsIE1hcmVrIFN6eXByb3dza2kgd3JvdGU6Cj4+Pj4+PiBP
biAwOC4wNi4yMDIxIDE4OjQ1LCBBbWV5IE5hcmtoZWRlIHdyb3RlOgo+Pj4+Pj4+IElmIGRldmlj
ZSByZWdpc3RyYXRpb24gZmFpbHMsIHJlbW92ZSBzeXNmcyBhdHRyaWJ1dGUKPj4+Pj4+PiBhbmQg
aWYgc2V0dGluZyBidXMgY2FsbGJhY2tzIGZhaWxzLCB1bnJlZ2lzdGVyIHRoZSBkZXZpY2UKPj4+
Pj4+PiBhbmQgY2xlYW51cCB0aGUgc3lzZnMgYXR0cmlidXRlLgo+Pj4+Pj4+Cj4+Pj4+Pj4gU2ln
bmVkLW9mZi1ieTogQW1leSBOYXJraGVkZSA8YW1leW5hcmtoZWRlMDNAZ21haWwuY29tPgo+Pj4+
Pj4gVGhpcyBwYXRjaCBsYW5kZWQgaW4gbGludXgtbmV4dCBzb21lIHRpbWUgYWdvIGFzIGNvbW1p
dCAyNDljOWRjNmFhMGQKPj4+Pj4+ICgiaW9tbXUvYXJtOiBDbGVhbnVwIHJlc291cmNlcyBpbiBj
YXNlIG9mIHByb2JlIGVycm9yIHBhdGgiKS4gQWZ0ZXIKPj4+Pj4+IGJpc2VjdGluZyBhbmQgc29t
ZSBtYW51YWwgc2VhcmNoaW5nIEkgZmluYWxseSBmb3VuZCB0aGF0IGl0IGlzCj4+Pj4+PiByZXNw
b25zaWJsZSBmb3IgYnJlYWtpbmcgczJpZGxlIG9uIERyYWdvbkJvYXJkIDQxMGMuIEhlcmUgaXMg
dGhlIGxvZwo+Pj4+Pj4gKGNhcHR1cmVkIHdpdGggbm9fY29uc29sZV9zdXNwZW5kKToKPj4+Pj4+
Cj4+Pj4+PiAjIHRpbWUgcnRjd2FrZSAtczEwIC1tbWVtCj4+Pj4+PiBydGN3YWtlOiB3YWtldXAg
ZnJvbSAibWVtIiB1c2luZyAvZGV2L3J0YzAgYXQgVGh1IEphbsOvwr/CvSAxIDAwOjAyOjEzIDE5
NzAKPj4+Pj4+IFBNOiBzdXNwZW5kIGVudHJ5IChzMmlkbGUpCj4+Pj4+PiBGaWxlc3lzdGVtcyBz
eW5jOiAwLjAwMiBzZWNvbmRzCj4+Pj4+PiBGcmVlemluZyB1c2VyIHNwYWNlIHByb2Nlc3NlcyAu
Li4gKGVsYXBzZWQgMC4wMDYgc2Vjb25kcykgZG9uZS4KPj4+Pj4+IE9PTSBraWxsZXIgZGlzYWJs
ZWQuCj4+Pj4+PiBGcmVlemluZyByZW1haW5pbmcgZnJlZXphYmxlIHRhc2tzIC4uLiAoZWxhcHNl
ZCAwLjAwNCBzZWNvbmRzKSBkb25lLgo+Pj4+Pj4gVW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgTlVM
TCBwb2ludGVyIGRlcmVmZXJlbmNlIGF0IHZpcnR1YWwgYWRkcmVzcwo+Pj4+Pj4gMDAwMDAwMDAw
MDAwMDA3MAo+Pj4+Pj4gTWVtIGFib3J0IGluZm86Cj4+Pj4+PiDDr8K/wr3Dr8K/wr0gw6/Cv8K9
IEVTUiA9IDB4OTYwMDAwMDYKPj4+Pj4+IMOvwr/CvcOvwr/CvSDDr8K/wr0gRUMgPSAweDI1OiBE
QUJUIChjdXJyZW50IEVMKSwgSUwgPSAzMiBiaXRzCj4+Pj4+PiDDr8K/wr3Dr8K/wr0gw6/Cv8K9
IFNFVCA9IDAsIEZuViA9IDAKPj4+Pj4+IMOvwr/CvcOvwr/CvSDDr8K/wr0gRUEgPSAwLCBTMVBU
VyA9IDAKPj4+Pj4+IMOvwr/CvcOvwr/CvSDDr8K/wr0gRlNDID0gMHgwNjogbGV2ZWwgMiB0cmFu
c2xhdGlvbiBmYXVsdAo+Pj4+Pj4gRGF0YSBhYm9ydCBpbmZvOgo+Pj4+Pj4gw6/Cv8K9w6/Cv8K9
IMOvwr/CvSBJU1YgPSAwLCBJU1MgPSAweDAwMDAwMDA2Cj4+Pj4+PiDDr8K/wr3Dr8K/wr0gw6/C
v8K9IENNID0gMCwgV25SID0gMAo+Pj4+Pj4gdXNlciBwZ3RhYmxlOiA0ayBwYWdlcywgNDgtYml0
IFZBcywgcGdkcD0wMDAwMDAwMDhhZDA4MDAwCj4+Pj4+PiBbMDAwMDAwMDAwMDAwMDA3MF0gcGdk
PTA4MDAwMDAwODVjM2MwMDMsIHA0ZD0wODAwMDAwMDg1YzNjMDAzLAo+Pj4+Pj4gcHVkPTA4MDAw
MDAwODhkY2YwMDMsIHBtZD0wMDAwMDAwMDAwMDAwMDAwCj4+Pj4+PiBJbnRlcm5hbCBlcnJvcjog
T29wczogOTYwMDAwMDYgWyMxXSBQUkVFTVBUIFNNUAo+Pj4+Pj4gTW9kdWxlcyBsaW5rZWQgaW46
IGJsdWV0b290aCBlY2RoX2dlbmVyaWMgZWNjIHJma2lsbCBpcHY2IGF4ODg3OTZiCj4+Pj4+PiB2
ZW51c19lbmMgdmVudXNfZGVjIHZpZGVvYnVmMl9kbWFfY29udGlnIGFzaXggY3JjdDEwZGlmX2Nl
IGFkdjc1MTEKPj4+Pj4+IHNuZF9zb2NfbXNtODkxNl9hbmFsb2cgcWNvbV9zcG1pX3RlbXBfYWxh
cm0gcnRjX3BtOHh4eCBxY29tX3Bvbgo+Pj4+Pj4gcWNvbV9jYW1zcyBxY29tX3NwbWlfdmFkYyB2
aWRlb2J1ZjJfZG1hX3NnIHFjb21fdmFkY19jb21tb24gbXNtCj4+Pj4+PiB2ZW51c19jb3JlIHY0
bDJfZndub2RlIHY0bDJfYXN5bmMgc25kX3NvY19tc204OTE2X2RpZ2l0YWwKPj4+Pj4+IHZpZGVv
YnVmMl9tZW1vcHMgc25kX3NvY19scGFzc19hcHE4MDE2IHNuZF9zb2NfbHBhc3NfY3B1IHY0bDJf
bWVtMm1lbQo+Pj4+Pj4gc25kX3NvY19scGFzc19wbGF0Zm9ybSBzbmRfc29jX2FwcTgwMTZfc2Jj
IHZpZGVvYnVmMl92NGwyCj4+Pj4+PiBzbmRfc29jX3Fjb21fY29tbW9uIHFjb21fcm5nIHZpZGVv
YnVmMl9jb21tb24gaTJjX3Fjb21fY2NpCj4+Pj4+PiBxbm9jX21zbTg5MTYKPj4+Pj4+IHZpZGVv
ZGV2IG1jIGljY19zbWRfcnBtIG1kdF9sb2FkZXIgc29jaW5mbyBkaXNwbGF5X2Nvbm5lY3RvciBy
bXRmc19tZW0KPj4+Pj4+IENQVTogMSBQSUQ6IDE1MjIgQ29tbTogcnRjd2FrZSBOb3QgdGFpbnRl
ZCA1LjEzLjAtbmV4dC0yMDIxMDYyOSAjMzU5Mgo+Pj4+Pj4gSGFyZHdhcmUgbmFtZTogUXVhbGNv
bW0gVGVjaG5vbG9naWVzLCBJbmMuIEFQUSA4MDE2IFNCQyAoRFQpCj4+Pj4+PiBwc3RhdGU6IDgw
MDAwMDA1IChOemN2IGRhaWYgLVBBTiAtVUFPIC1UQ08gQlRZUEU9LS0pCj4+Pj4+PiBwYyA6IG1z
bV9ydW50aW1lX3N1c3BlbmQrMHgxYy8weDYwIFttc21dCj4+Pj4+PiBsciA6IG1zbV9wbV9zdXNw
ZW5kKzB4MTgvMHgzOCBbbXNtXQo+Pj4+Pj4gLi4uCj4+Pj4+PiBDYWxsIHRyYWNlOgo+Pj4+Pj4g
w6/Cv8K9w6/Cv8K9IMOvwr/CvW1zbV9ydW50aW1lX3N1c3BlbmQrMHgxYy8weDYwIFttc21dCj4+
Pj4+PiDDr8K/wr3Dr8K/wr0gw6/Cv8K9bXNtX3BtX3N1c3BlbmQrMHgxOC8weDM4IFttc21dCj4+
Pj4+PiDDr8K/wr3Dr8K/wr0gw6/Cv8K9ZHBtX3J1bl9jYWxsYmFjaysweDg0LzB4Mzc4Cj4+Pj4+
IEkgd29uZGVyIGlmIHdlJ3JlIG1pc3NpbmcgYSBwbV9ydW50aW1lX2Rpc2FibGUoKSBjYWxsIG9u
IHRoZSBmYWlsdXJlCj4+Pj4+IHBhdGg/Cj4+Pj4+IGkuZS4gc29tZXRoaW5nIGxpa2UgdGhlIGRp
ZmYgYmVsb3cuLi4KPj4+Pgo+Pj4+IEkndmUgY2hlY2tlZCBhbmQgaXQgZG9lc24ndCBmaXggYW55
dGhpbmcuCj4+Pgo+Pj4gV2hhdCdzIGhhcHBlbmVkIHByZXZpb3VzbHk/IEhhcyBhbiBJT01NVSBh
Y3R1YWxseSBmYWlsZWQgdG8gcHJvYmUsIG9yCj4+PiBpcyB0aGlzIGEgZmlkZGx5ICJjb2RlIG1v
dmVtZW50IHVudmVpbHMgbGF0ZW50IGJ1ZyBlbHNld2hlcmUiIGtpbmQgb2YKPj4+IHRoaW5nPyBU
aGVyZSBkb2Vzbid0IGxvb2sgdG8gYmUgbXVjaCBjYXBhYmxlIG9mIGdvaW5nIHdyb25nIGluCj4+
PiBtc21fcnVudGltZV9zdXNwZW5kKCkgaXRzZWxmLCBzbyBpcyB0aGUgRFJNIGRyaXZlciBhbHNv
IGluIGEgYnJva2VuCj4+PiBoYWxmLXByb2JlZCBzdGF0ZSB3aGVyZSBpdCdzIGxlZnQgaXRzIHBt
X3J1bnRpbWVfb3BzIGJlaGluZCB3aXRob3V0Cj4+PiBpdHMgZHJ2ZGF0YSBiZWluZyB2YWxpZD8K
Pj4+Cj4+IEkgZmluYWxseSBoYWQgc29tZSB0aW1lIHRvIGFuYWx5emUgdGhpcyBpc3N1ZS4gSXQg
dHVybmVkIG91dCB0aGF0IHdpdGgKPj4gdGhpcyBwYXRjaCwgaW9tbXUgZmFpbHMgdG8gcHJvYmUg
Zm9yIHNvYzppb21tdUAxZjA4MDAwIGRldmljZSwgd2hpbGUgaXQKPj4gd29ya2VkIGZpbmUgYmVm
b3JlLiBUaGlzIGhhcHBlbnMgYmVjYXVzZSB0aGlzIHBhdGNoIGFkZHMgYSBjaGVjayBmb3IgdGhl
Cj4+IHJldHVybiB2YWx1ZSBvZiB0aGUgYnVzX3NldF9pb21tdSgpIGluCj4+IGRyaXZlcnMvaW9t
bXUvYXJtL2FybS1zbW11L3Fjb21faW9tbXUuYy4gV2hlbiBJIHJlbW92ZWQgdGhhdCBjaGVjaywg
aXQKPj4gcHJvYmVzIHN1Y2Nlc3NmdWxseSBhZ2Fpbi4gSXQgbG9va3MgdGhhdCB0aGVyZSBhcmUg
YWxyZWFkeSBpb21tdSBvcHMKPj4gcmVnaXN0ZXJlZCBmb3IgcGxhdGZvcm0gYnVzLCBiZWZvcmUg
cWNvbV9pb21tdSBwcm9iZXMuIE9uIHRoZSBvdGhlcgo+PiBoYW5kLCBpZiBJIHJlbWVtYmVyIGNv
cnJlY3RseSB0aGV5IGFyZSBub3QgdXNlZCBkdXJpbmcgdGhlIGRldmljZQo+PiByZWdpc3RyYXRp
b24sIGJ1dCB0aGV5IGFyZSBuZWVkZWQgZm9yIHNvbWUgbGVnYWN5IHN0dWZmLiBJIGNhbiBzZW5k
IGEKPj4gcGF0Y2ggcmVzdG9yaW5nIG9sZCBjb2RlIGZsb3cgaWYgeW91IHRoaW5rIHRoYXQgdGhp
cyBpcyBhIHJpZ2h0IHNvbHV0aW9uLgo+IAo+IFllcywgbGV0J3MganVzdCByZXZlcnQgdGhlIHFj
b21faW9tbXUuYyBjaGFuZ2VzIGZyb20gdGhhdCBwYXRjaCBmb3Igbm93Lgo+IFRoZSBwbSBydW50
aW1lIHN0dWZmIGxvb2tzIGRvZGd5IGFueXdheSBzbyBJIHRoaW5rIHRoaXMgbmVlZHMgbW9yZSB0
aG91Z2h0LgoKT2gsIHJpZ2h0LCBibGluZGx5IHJldHVybmluZyB0aGUgLUVCVVNZIGZyb20gYnVz
X3NldF9pb21tdSgpIGJlY2F1c2UgCndlJ3JlIG5vdCB0aGUgZmlyc3QgaW5zdGFuY2UgdG8gcHJv
YmUgaXMgZGVmaW5pdGVseSB0aGUgd3JvbmcgdGhpbmcgdG8gCmRvIGFzIHdlbGwuIEl0J3Mgc3Rp
bGwgbm90IGNsZWFyIHdoeSBmYWlsaW5nIG1ha2VzIHRoZSBEUk0gZHJpdmVyIGZhbGwgCm92ZXIs
IGJ1dCArMSB0byBxY29tLWlvbW11IG5lZWRpbmcgc29tZSBkZWVwZXIgY29uc2lkZXJhdGlvbi4K
ClJvYmluLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpp
b21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
