Return-Path: <SRS0=unsG=4I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9387C11D0C
	for <iommu@archiver.kernel.org>; Thu, 20 Feb 2020 17:35:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A28852071E
	for <iommu@archiver.kernel.org>; Thu, 20 Feb 2020 17:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A28852071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4DAD787476;
	Thu, 20 Feb 2020 17:35:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9pSfUXipF8Wt; Thu, 20 Feb 2020 17:35:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 676CB86D82;
	Thu, 20 Feb 2020 17:35:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50652C1D84;
	Thu, 20 Feb 2020 17:35:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9269C013E
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 17:35:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id AEB8B207A8
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 17:35:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CgyWt3aPRzQV for <iommu@lists.linux-foundation.org>;
 Thu, 20 Feb 2020 17:35:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id 6127020341
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 17:35:41 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC7F831B;
 Thu, 20 Feb 2020 09:35:40 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8EFF93F68F;
 Thu, 20 Feb 2020 09:35:39 -0800 (PST)
Subject: Re: [RFC PATCH] iommu/iova: Support limiting IOVA alignment
To: Liam Mark <lmark@codeaurora.org>, Will Deacon <will@kernel.org>
References: <alpine.DEB.2.10.2002141223510.27047@lmark-linux.qualcomm.com>
 <e9ae618c-58d4-d245-be80-e62fbde4f907@arm.com>
 <20200219123704.GC19400@willie-the-truck>
 <alpine.DEB.2.10.2002191517150.636@lmark-linux.qualcomm.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <f0d4312b-a451-691a-3fcd-e9c90f6c5308@arm.com>
Date: Thu, 20 Feb 2020 17:35:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.2002191517150.636@lmark-linux.qualcomm.com>
Content-Language: en-GB
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>,
 Pratik Patel <pratikp@codeaurora.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, kernel-team@android.com
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
Content-Type: text/plain; charset="iso8859-7"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gMTkvMDIvMjAyMCAxMToyMiBwbSwgTGlhbSBNYXJrIHdyb3RlOgo+IE9uIFdlZCwgMTkgRmVi
IDIwMjAsIFdpbGwgRGVhY29uIHdyb3RlOgo+IAo+PiBPbiBNb24sIEZlYiAxNywgMjAyMCBhdCAw
NDo0NjoxNFBNICswMDAwLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+PiBPbiAxNC8wMi8yMDIwIDg6
MzAgcG0sIExpYW0gTWFyayB3cm90ZToKPj4+Pgo+Pj4+IFdoZW4gdGhlIElPVkEgZnJhbWV3b3Jr
IGFwcGxpZXMgSU9WQSBhbGlnbm1lbnQgaXQgYWxpZ25zIGFsbAo+Pj4+IElPVkFzIHRvIHRoZSBz
bWFsbGVzdCBQQUdFX1NJWkUgb3JkZXIgd2hpY2ggaXMgZ3JlYXRlciB0aGFuIG9yCj4+Pj4gZXF1
YWwgdG8gdGhlIHJlcXVlc3RlZCBJT1ZBIHNpemUuCj4+Pj4KPj4+PiBXZSBzdXBwb3J0IHVzZSBj
YXNlcyB0aGF0IHJlcXVpcmVzIGxhcmdlIGJ1ZmZlcnMgKD4gNjQgTUIgaW4KPj4+PiBzaXplKSB0
byBiZSBhbGxvY2F0ZWQgYW5kIG1hcHBlZCBpbiB0aGVpciBzdGFnZSAxIHBhZ2UgdGFibGVzLgo+
Pj4+IEhvd2V2ZXIsIHdpdGggdGhpcyBhbGlnbm1lbnQgc2NoZW1lIHdlIGZpbmQgb3Vyc2VsdmVz
IHJ1bm5pbmcKPj4+PiBvdXQgb2YgSU9WQSBzcGFjZSBmb3IgMzIgYml0IGRldmljZXMsIHNvIHdl
IGFyZSBwcm9wb3NpbmcgdGhpcwo+Pj4+IGNvbmZpZywgYWxvbmcgdGhlIHNpbWlsYXIgdmVpbiBh
cyBDT05GSUdfQ01BX0FMSUdOTUVOVCBmb3IgQ01BCj4+Pj4gYWxsb2NhdGlvbnMuCj4+Pgo+Pj4g
QXMgcGVyIFsxXSwgSSdkIHJlYWxseSBsaWtlIHRvIGJldHRlciB1bmRlcnN0YW5kIHRoZSBhbGxv
Y2F0aW9uIHBhdHRlcm5zCj4+PiB0aGF0IGxlYWQgdG8gc3VjaCBhIHNwYXJzZWx5LW9jY3VwaWVk
IGFkZHJlc3Mgc3BhY2UgdG8gYmVnaW4gd2l0aCwgZ2l2ZW4KPj4+IHRoYXQgdGhlIHJidHJlZSBh
bGxvY2F0b3IgaXMgc3VwcG9zZWQgdG8gdHJ5IHRvIG1haW50YWluIGxvY2FsaXR5IGFzIGZhciBh
cwo+Pj4gcG9zc2libGUsIGFuZCB0aGUgcmNhY2hlcyBzaG91bGQgZnVydGhlciBpbXByb3ZlIG9u
IHRoYXQuIEFyZSB5b3UgYWxzbwo+Pj4gZnJlcXVlbnRseSBjeWNsaW5nIGludGVybWVkaWF0ZS1z
aXplZCBidWZmZXJzIHdoaWNoIGFyZSBzbWFsbGVyIHRoYW4gNjRNQgo+Pj4gYnV0IHN0aWxsIHRv
byBiaWcgdG8gYmUgY2FjaGVkPyAgQXJlIHRoZXJlIGEgbG90IG9mIG5vbi1wb3dlci1vZi10d28K
Pj4+IGFsbG9jYXRpb25zPwo+Pgo+PiBSaWdodCwgaW5mb3JtYXRpb24gb24gdGhlIGFsbG9jYXRp
b24gcGF0dGVybiB3b3VsZCBoZWxwIHdpdGggdGhpcyBjaGFuZ2UKPj4gYW5kIGFsc28gdGhlIGNo
b2ljZSBvZiBJT1ZBIGFsbG9jYXRpb24gYWxnb3JpdGhtLiBXaXRob3V0IGl0LCB3ZSdyZSBqdXN0
Cj4+IHNob290aW5nIGluIHRoZSBkYXJrLgo+Pgo+IAo+IFRoYW5rcyBmb3IgdGhlIHJlc3BvbnNl
cy4KPiAKPiBJIGFtIGxvb2tpbmcgaW50byBob3cgbXVjaCBvZiBvdXIgYWxsb2NhdGlvbiBwYXR0
ZXJuIGRldGFpbHMgSSBjYW4gc2hhcmUuCj4gCj4gTXkgZ2VuZXJhbCB1bmRlcnN0YW5kaW5nIGlz
IHRoYXQgdGhpcyBpc3N1ZSBvY2N1cnMgb24gYSAzMmJpdCBkZXZpY2VzCj4gd2hpY2ggaGF2ZSBh
ZGRpdGlvbmFsIHJlc3RyaWN0aW9ucyBvbiB0aGUgSU9WQSByYW5nZSB0aGV5IGNhbiB1c2Ugd2l0
aGluIHRob3NlCj4gMzJiaXRzLgo+IAo+IEFuIGV4YW1wbGUgaXMgYSB1c2UgY2FzZSB3aGljaCBp
bnZvbHZlcyBhbGxvY2F0aW5nIGEgbG90IG9mIGJ1ZmZlcnMgfjgwTUIKPiBpcyBzaXplLCB0aGUg
Y3VycmVudCBhbGdvcml0aG0gd2lsbCByZXF1aXJlIGFuIGFsaWdubWVudCBvZiAxMjhNQiBmb3IK
PiB0aG9zZSBidWZmZXJzLiBNeSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgaXQgc2ltcGx5IGNhbid0
IGFjY29tbW9kYXRlIHRoZSBudW1iZXIgb2YgODBNQgo+IGJ1ZmZlcnMgdGhhdCBhcmUgcmVxdWly
ZWQgYmVjYXVzZSB0aGUgb2YgYW1vdW50IG9mIElPVkEgc3BhY2Ugd2hpY2ggY2FuJ3QKPiBiZSB1
c2VkIGJlY2F1c2Ugb2YgdGhlIDEyOE1CIGFsaWdubWVudCByZXF1aXJlbWVudC4KCk9LLCB0aGF0
J3MgYSBjYXNlIEkgY2FuIHVuZGVyc3RhbmQgOikKCj4+Pj4gQWRkIENPTkZJR19JT01NVV9MSU1J
VF9JT1ZBX0FMSUdOTUVOVCB0byBsaW1pdCB0aGUgYWxpZ25tZW50IG9mCj4+Pj4gSU9WQXMgdG8g
c29tZSBkZXNpcmVkIFBBR0VfU0laRSBvcmRlciwgc3BlY2lmaWVkIGJ5Cj4+Pj4gQ09ORklHX0lP
TU1VX0lPVkFfQUxJR05NRU5ULiBUaGlzIGhlbHBzIHJlZHVjZSB0aGUgaW1wYWN0IG9mCj4+Pj4g
ZnJhZ21lbnRhdGlvbiBjYXVzZWQgYnkgdGhlIGN1cnJlbnQgSU9WQSBhbGlnbm1lbnQgc2NoZW1l
LCBhbmQKPj4+PiBnaXZlcyBiZXR0ZXIgSU9WQSBzcGFjZSB1dGlsaXphdGlvbi4KPj4+Cj4+PiBF
dmVuIGlmIHRoZSBnZW5lcmFsIGNoYW5nZSBkaWQgcHJvdmUgcmVhc29uYWJsZSwgdGhpcyBJT1ZB
IGFsbG9jYXRvciBpcyBub3QKPj4+IG93bmVkIGJ5IHRoZSBETUEgQVBJLCBzbyBlbnRpcmVseSBy
ZW1vdmluZyB0aGUgb3B0aW9uIG9mIHN0cmljdAo+Pj4gc2l6ZS1hbGlnbm1lbnQgZmVlbHMgYSBi
aXQgdW5jb21mb3J0YWJsZS4gUGVyc29uYWxseSBJJ2QgcmVwbGFjZSB0aGUgYm9vbAo+Pj4gYXJn
dW1lbnQgd2l0aCBhbiBhY3R1YWwgYWxpZ25tZW50IHZhbHVlIHRvIGF0IGxlYXN0IGhhbmQgdGhl
IGF1dGhvcml0eSBvdXQKPj4+IHRvIGluZGl2aWR1YWwgY2FsbGVycy4KPj4+Cj4+PiBGdXJ0aGVy
bW9yZSwgZXZlbiBpbiBETUEgQVBJIHRlcm1zLCBpcyBhbnlvbmUgcmVhbGx5IGV2ZXIgZ29pbmcg
dG8gYm90aGVyCj4+PiB0dW5pbmcgdGhhdCBjb25maWc/IFNpbmNlIGlvbW11LWRtYSBpcyBzdXBw
b3NlZCB0byBiZSBhIHRyYW5zcGFyZW50IGxheWVyLAo+Pj4gYXJndWFibHkgaXQgc2hvdWxkbid0
IGJlaGF2ZSB1bm5lY2Vzc2FyaWx5IGRpZmZlcmVudGx5IGZyb20gQ01BLCBzbyBzaW1wbHkKPj4+
IHBpZ2d5LWJhY2tpbmcgb2ZmIENPTkZJR19DTUFfQUxJR05NRU5UIHdvdWxkIHNlZW0gbG9naWNh
bC4KPj4KPj4gQWdyZWVkLCByZXVzaW5nIENPTkZJR19DTUFfQUxJR05NRU5UIG1ha2VzIGEgbG90
IG9mIHNlbnNlIGhlcmUgYXMgY2FsbGVycwo+PiByZWx5aW5nIG9uIG5hdHVyYWwgYWxpZ25tZW50
IG9mIERNQSBidWZmZXIgYWxsb2NhdGlvbnMgYWxyZWFkeSBoYXZlIHRvCj4+IGRlYWwgd2l0aCB0
aGF0IGxpbWl0YXRpb24uIFdlIGNvdWxkIGZpeCBpdCBhcyBhbiBvcHRpb25hbCBwYXJhbWV0ZXIg
YXQKPj4gaW5pdCB0aW1lIChpbml0X2lvdmFfZG9tYWluKCkpLCBhbmQgaGF2ZSB0aGUgRE1BIElP
TU1VIGltcGxlbWVudGF0aW9uCj4+IHBhc3MgaXQgaW4gdGhlcmUuCj4+Cj4gCj4gTXkgY29uY2Vy
biB3aXRoIHVzaW5nIENPTkZJR19DTUFfQUxJR05NRU5UIGFsaWdubWVudCBpcyB0aGF0IGZvciB1
cyB0aGlzCj4gd291bGQgZWl0aGVyIGludm9sdmUgZnVydGhlciBmcmFnbWVudGluZyBvdXIgQ01B
IHJlZ2lvbnMgKG1vdmluZyBvdXIgQ01BCj4gbWF4IGFsaWdubWVudCBmcm9tIDFNQiB0byBtYXgg
Mk1CKSBvciBsb3Npbmcgc28gb2Ygb3VyIDJNQiBJT1ZBIGJsb2NrCj4gbWFwcGluZ3MgKGNoYW5n
aW5nIG91ciBJT1ZBIG1heCBhbGlnbm1lbnQgZm9ybSAyTUIgdG8gMU1CKS4KPiAKPiBBdCBsZWFz
dCBmb3IgdXMgQ01BIGFsbG9jYXRpb25zIGFyZSBvZnRlbiBub3QgRE1BIG1hcHBlZCBpbnRvIHN0
YWdlIDEgcGFnZQo+IHRhYmxlcyBzbyBtb3ZpbmcgdGhlIENNQSBtYXggYWxpZ25tZW50IHRvIDJN
QiBpbiBvdXIgY2FzZSB3b3VsZCwgSSB0aGluaywKPiBvbmx5IHByb3ZpZGUgdGhlIGRpc2FkdmFu
dGFnZSBvZiBoYXZpbmcgdG8gaW5jcmVhc2UgdGhlIHNpemUgb3VyIENNQQo+IHJlZ2lvbnMgdG8g
YWNjb21tb2RhdGUgdGhpcyBsYXJnZSBhbGlnbm1lbnQgKHdoaWNoIGlzbqJ0IG9wdGltYWwgZm9y
Cj4gbWVtb3J5IHV0aWxpemF0aW9uIHNpbmNlIENNQSByZWdpb25zIGNhbid0IHNhdGlzZnkgdW5t
b3ZhYmxlIHBhZ2UKPiBhbGxvY2F0aW9ucykuCj4gCj4gQXMgYW4gYWx0ZXJuYXRpdmUgd291bGQg
aXQgYmUgcG9zc2libGUgZm9yIHRoZSBkbWEtaW9tbXUgbGF5ZXIgdG8gdXNlIHRoZQo+IHNpemUg
b2YgdGhlIGFsbG9jYXRpb24gYW5kIHRoZSBkb21haW4gcGdzaXplX2JpdG1hcCBmaWVsZCB0byBw
aWNrIGEgbWF4Cj4gSU9WQSBhbGlnbm1lbnQsIHdoaWNoIGl0IGNhbiBwYXNzIGluIGZvciB0aGF0
IElPVkEgYWxsb2NhdGlvbiwgd2hpY2ggd2lsbAo+IG1heGltaXplIGJsb2NrIG1hcHBpbmdzIGJ1
dCBub3Qgd2FzdGUgSU9WQSBzcGFjZT8KCkdpdmVuIHRoYXQgd2UgYWxyZWFkeSBoYXZlIERNQV9B
VFRSX0FMT0NfU0lOR0xFX1BBR0VTIGZvciB2aWRlbyBkcml2ZXJzIAphbmQgc3VjaGxpa2UgdGhh
dCBrbm93IGVub3VnaCB0byBrbm93IHRoZXkgd2FudCAibGFyZ2UgYnVmZmVyIiAKYWxsb2NhdGlv
biBiZWhhdmlvdXIsIHdvdWxkIGl0IHN1ZmZpY2UgdG8gaGF2ZSBhIHNpbWlsYXIgYXR0cmlidXRl
IHRoYXQgCnNheXMgIkknbSBub3QgdG9vIGZ1c3NlZCBhYm91dCBhbGlnbm1lbnQiPyBUaGF0IHdh
eSB0aGVyZSdzIG5vIHZpc2libGUgCmNoYW5nZSBmb3IgYW55b25lIHdobyBkb2Vzbid0IG9wdCBp
biBhbmQgbWlnaHQgYmUgcmVseWluZyBvbiB0aGUgCmV4aXN0aW5nIGJlaGF2aW91ciwgaW50ZW50
aW9uYWxseSBvciBvdGhlcndpc2UuCgpUaGVuIGlmIG5lY2Vzc2FyeSwgdGhlIGltcGxlbWVudGF0
aW9uIGNhbiBjb25zaWRlciBib3RoIGZsYWdzIHRvZ2V0aGVyIAp0byBkZWNpZGUgd2hldGhlciB0
byB0cnkgdG8gcm91bmQgZG93biB0byB0aGUgbmV4dCBibG9jayBzaXplIG9yIGp1c3QgCnNob3Zl
IGl0IGluIGFueXdoZXJlLgoKUm9iaW4uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby9pb21tdQ==
