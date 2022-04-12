Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C58AC433F5
	for <iommu@archiver.kernel.org>; Tue, 12 Apr 2022 07:04:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E509A60F32;
	Tue, 12 Apr 2022 07:04:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nyNllDkxmC18; Tue, 12 Apr 2022 07:04:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C4EB060593;
	Tue, 12 Apr 2022 07:04:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B4B2C0082;
	Tue, 12 Apr 2022 07:04:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B78FBC002F
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 07:04:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 96F9282FE7
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 07:04:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=foxmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZcJ5G3IoAYUd for <iommu@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 07:04:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com
 [203.205.221.190])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ECA4082FB1
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 07:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1649747054;
 bh=+Nw/81EzAzg32b0b63hZbzdAlSaSPQJFfPDQ8bOr+dk=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To;
 b=WHDhRlFLuUtf+6qTzyJUKuWWTm6bnZVNTBSWGCX+2v67SVOCTiMyZ29lCUUuzJLKA
 Aa6dPwx66T/YxtIdPvwmc9CaEr56j1Ep5w2IDuEcmbf5C+yW/iiFdM8woqYRGrQ44X
 Ck0LZ9SjG7iO7jZcH/Fsc1ay7IvkP3+7RFanF5io=
Received: from [IPv6:240e:362:406:cc00:1037:1d58:2ba:46b6]
 ([240e:362:406:cc00:1037:1d58:2ba:46b6])
 by newxmesmtplogicsvrsza5.qq.com (NewEsmtp) with SMTP
 id 10A1781B; Tue, 12 Apr 2022 15:04:10 +0800
X-QQ-mid: xmsmtpt1649747050t25c06aya
Message-ID: <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
X-QQ-XMAILINFO: OZZSS56D9fAjkkO1MRHXn0IzBI/HiOM9PhWrX0Q2YE3pYwi5OJHPJwDADUq060
 vN3f2kY/K3AoMyxnFfz+KUdn/3oa1F2UFhhm+Fk217AR30+hGKu58xLK6H1ct8aOp8SwHdqaNbjU
 Ar2QQCFmrOcGNaNDoo58jF2+jMsJkeOs59nreUY9Jtr9YDeOxMKiHjGeRO3vCSUmGfs0y5TlT1GD
 f3Exyc0uE9ubv0Eof325Jq7rqD9e4UV+ggOA/3+eD7IoMn2DriA1RbxYNA3nktXX+UUoJG86HqbM
 qCIrQjLM/VkhR76cuSlwVDML7Pm8sAxsTF2Zy6JzCtzK3nfllO/aStqIdYzOUC7+r4GDJLaGgVl4
 X1yBFXzvfZcpmihWgHsm27aeBnW3xlAteQIJoXy+GdBBu4DPbfHKDmwnMuf5+dLbMiToz1+NHFmM
 FQt0aYat1iIF5WSUL0/A2wI5vsW9/Fy7O7g3SoXvs9/MEk0ALYqCWLv+IkH7ZA//F7ncfxvi7IqW
 TGNTY1u9M0IHj4rjr5r4By0oVG/8pkou+wnUns4mjdxsUgTFapjVV+QeWshgHh3tl7DKTUZVQtW/
 RCfogvyi15C87hQ47jC0jCPb4tQ7xgRmmVgphFSR8DJJhMYuKVRIHdykJMYSpiPckIbQsLA3sjGx
 piIpA1ivk1K52u1h39hyT3LST29Cf36FpFMc11FZKb7tPDNm3BFkOgBQUKqHeMZ8ZF6ed9oFZuUD
 HhtR1HEFR0mxZjOffYQzvC6xgPvNIpH6RxbSzXyFrJo9vJHKYQZUAKhOYPNesLOzu5OPho5V1aAR
 n8J0UuhisSqvlq6FKL3IHNLsB3s6ny/r8IcjLHF8/vieoWFV7AZYAH9GRmYvBEpgSp+ILrI/xzk8
 nhYwrHHpUyI1EFlXZHDx+VCHHdSUGUiBhbvqJ2/3DmxqNKyxvxog3W1TDrnqT9rVJILKA2RTAdnq
 WPz1Q2HZc=
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
To: Dave Hansen <dave.hansen@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Fenghua Yu <fenghua.yu@intel.com>, jean-philippe <jean-philippe@linaro.org>
References: <20220207230254.3342514-1-fenghua.yu@intel.com>
 <20220207230254.3342514-6-fenghua.yu@intel.com> <Ygt4h0PgYzKOiB38@8bytes.org>
 <tencent_F6830A1196DB4C6A904D7C691F0D961D1108@qq.com>
 <56ed509d-a7cf-1fde-676c-a28eb204989b@intel.com>
 <tencent_9920B633D50E9B80D3A41A723BCE06972309@qq.com>
 <f439dde5-0eaa-52e4-9cf7-2ed1f62ea07f@intel.com>
 <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
 <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
From: "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
X-OQ-MSGID: <dfc3a641-ed8a-a534-f80c-f391f5e825c8@foxmail.com>
Date: Tue, 12 Apr 2022 15:04:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
Content-Language: en-US
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>, Tony Luck <tony.luck@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 iommu <iommu@lists.linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>
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

CgpPbiAyMDIyLzQvMTEg5LiL5Y2IMTA6NTIsIERhdmUgSGFuc2VuIHdyb3RlOgo+IE9uIDQvMTEv
MjIgMDc6NDQsIHpoYW5nZmVpLmdhb0Bmb3htYWlsLmNvbSB3cm90ZToKPj4gT24gMjAyMi80LzEx
IOS4i+WNiDEwOjM2LCBEYXZlIEhhbnNlbiB3cm90ZToKPj4+IE9uIDQvMTEvMjIgMDc6MjAsIHpo
YW5nZmVpLmdhb0Bmb3htYWlsLmNvbSB3cm90ZToKPj4+Pj4gSXMgdGhlcmUgbm90aGluZyBiZWZv
cmUgdGhpcyBjYWxsIHRyYWNlP8KgIFVzdWFsbHkgdGhlcmUgd2lsbCBiZSBhdCBsZWFzdAo+Pj4+
PiBzb21lIHdhcm5pbmcgdGV4dC4KPj4+PiBJIGFkZGVkIGR1bXBfc3RhY2soKSBpbiBpb2FzaWRf
ZnJlZS4KPj4+IEhvbGQgb24gYSBzZWMsIHRob3VnaC4uLgo+Pj4KPj4+IFdoYXQncyB0aGUgKnBy
b2JsZW0qIGhlcmU/wqAgRGlkIHNvbWV0aGluZyBicmVhayBvciBhcmUgeW91IGp1c3Qgc2F5aW5n
Cj4+PiB0aGF0IHNvbWV0aGluZyBsb29rcyB3ZWlyZCB0byBfeW91Xz8KPj4gQWZ0ZXIgdGhpcywg
bmdpbnggaXMgbm90IHdvcmtpbmcgYXQgYWxsLCBhbmQgaGFyZHdhcmUgcmVwb3J0cyBlcnJvci4K
Pj4gU3VwcG9zZSB0aGUgdGhlIG1hc3RlciB1c2UgdGhlIGlvYXNpZCBmb3IgaW5pdCwgYnV0IGdv
dCBmcmVlZC4KPj4KPj4gaGFyZHdhcmUgcmVwb3J0czoKPj4gW8KgIDE1Mi43MzE4NjldIGhpc2lf
c2VjMiAwMDAwOjc2OjAwLjA6IHFtX2FjY19kb190YXNrX3RpbWVvdXQgW2Vycm9yIHN0YXR1cz0w
eDIwXSBmb3VuZAo+PiBbwqAgMTUyLjczOTY1N10gaGlzaV9zZWMyIDAwMDA6NzY6MDAuMDogcW1f
YWNjX3diX25vdF9yZWFkeV90aW1lb3V0IFtlcnJvciBzdGF0dXM9MHg0MF0gZm91bmQKPj4gW8Kg
IDE1Mi43NDc4NzddIGhpc2lfc2VjMiAwMDAwOjc2OjAwLjA6IHNlY19mc21faGJlYXRfcmludCBb
ZXJyb3Igc3RhdHVzPTB4MjBdIGZvdW5kCj4+IFvCoCAxNTIuNzU1MzQwXSBoaXNpX3NlYzIgMDAw
MDo3NjowMC4wOiBDb250cm9sbGVyIHJlc2V0dGluZy4uLgo+PiBbwqAgMTUyLjc2MjA0NF0gaGlz
aV9zZWMyIDAwMDA6NzY6MDAuMDogUU0gbWFpbGJveCBvcGVyYXRpb24gdGltZW91dCEKPj4gW8Kg
IDE1Mi43NjgxOThdIGhpc2lfc2VjMiAwMDAwOjc2OjAwLjA6IEZhaWxlZCB0byBkdW1wIHNxYyEK
Pj4gW8KgIDE1Mi43NzM0OTBdIGhpc2lfc2VjMiAwMDAwOjc2OjAwLjA6IEZhaWxlZCB0byBkcmFp
biBvdXQgZGF0YSBmb3Igc3RvcHBpbmchCj4+IFvCoCAxNTIuNzgxNDI2XSBoaXNpX3NlYzIgMDAw
MDo3NjowMC4wOiBRTSBtYWlsYm94IGlzIGJ1c3kgdG8gc3RhcnQhCj4+IFvCoCAxNTIuNzg3NDY4
XSBoaXNpX3NlYzIgMDAwMDo3NjowMC4wOiBGYWlsZWQgdG8gZHVtcCBzcWMhCj4+IFvCoCAxNTIu
NzkyNzUzXSBoaXNpX3NlYzIgMDAwMDo3NjowMC4wOiBGYWlsZWQgdG8gZHJhaW4gb3V0IGRhdGEg
Zm9yIHN0b3BwaW5nIQo+PiBbwqAgMTUyLjgwMDY4NV0gaGlzaV9zZWMyIDAwMDA6NzY6MDAuMDog
UU0gbWFpbGJveCBpcyBidXN5IHRvIHN0YXJ0IQo+PiBbwqAgMTUyLjgwNjczMF0gaGlzaV9zZWMy
IDAwMDA6NzY6MDAuMDogRmFpbGVkIHRvIGR1bXAgc3FjIQo+PiBbwqAgMTUyLjgxMjAxN10gaGlz
aV9zZWMyIDAwMDA6NzY6MDAuMDogRmFpbGVkIHRvIGRyYWluIG91dCBkYXRhIGZvciBzdG9wcGlu
ZyEKPj4gW8KgIDE1Mi44MTk5NDZdIGhpc2lfc2VjMiAwMDAwOjc2OjAwLjA6IFFNIG1haWxib3gg
aXMgYnVzeSB0byBzdGFydCEKPj4gW8KgIDE1Mi44MjU5OTJdIGhpc2lfc2VjMiAwMDAwOjc2OjAw
LjA6IEZhaWxlZCB0byBkdW1wIHNxYyEKPiBUaGF0IHdvdWxkIGhhdmUgYmVlbiBhd2Z1bGx5IGhh
bmR5IGluZm9ybWF0aW9uIHRvIGhhdmUgaW4gYW4gaW5pdGlhbCBidWcgcmVwb3J0LiA6KQo+IElz
IHRoZXJlIGEgY2hhbmNlIHlvdSBjb3VsZCBkdW1wIG91dCB0aGF0IGlvYXNpZCBhbGxvYyAqYW5k
KiBmcmVlIGluZm9ybWF0aW9uIGluIGlvYXNpZF9hbGxvYy9mcmVlKCk/ICBUaGlzIGNvdWxkIGJl
IHNvbWUga2luZCBvZiBwcm9ibGVtIHdpdGggdGhlIGFsbG9jYXRvciwgb3Igd2l0aCBjb3B5aW5n
IHRoZSBpb2FzaWQgYXQgZm9yay4KVGhlIGlzc3VlIGlzIG5naW54IG1hc3RlciBwcm9jZXNzIGlu
aXQgcmVzb3VyY2UsIHN0YXJ0IGRhZW1vbiBwcm9jZXNzLCAKdGhlbiBtYXN0ZXIgcHJvY2VzcyBx
dWl0IGFuZCBmcmVlIGlvYXNpZC4KVGhlIGRhZW1vbiBuZ2lueCBwcm9jZXNzIGlzIG5vdCB0aGUg
b3JpZ2luYWwgbWFzdGVyIHByb2Nlc3MuCgptYXN0ZXIgcHJvY2VzczrCoCBpbml0IHJlc291cmNl
CmRyaXZlciAtPiBpb21tdV9zdmFfYmluZF9kZXZpY2UgLT4gaW9hc2lkX2FsbG9jCgpuZ2lueCA6
IG5neF9kYWVtb24KZm9yayBkYWVtb24sIHdpdGhvdXQgYWRkIG1tJ3MgcmVmY291bnQuCgpzcmMv
b3MvdW5peC9uZ3hfZGFlbW9uLmMKbmd4X2RhZW1vbihuZ3hfbG9nX3QgKmxvZykKewogwqDCoMKg
IGludMKgIGZkOwoKIMKgwqDCoCBzd2l0Y2ggKGZvcmsoKSkgewogwqDCoMKgIGNhc2UgLTE6CiDC
oMKgwqDCoMKgwqDCoCBuZ3hfbG9nX2Vycm9yKE5HWF9MT0dfRU1FUkcsIGxvZywgbmd4X2Vycm5v
LCAiZm9yaygpIGZhaWxlZCIpOwogwqDCoMKgwqDCoMKgwqAgcmV0dXJuIE5HWF9FUlJPUjsKCiDC
oMKgwqAgY2FzZSAwOsKgwqDCoCDCoMKgwqAgLy8gaGVyZSBtYXN0ZXIgcHJvY2VzcyBpcyBxdWl0
IGRpcmVjdGx5IGFuZCB3aWxsIGJlIApyZWxlYXNlZC4KIMKgwqDCoMKgwqDCoMKgIGJyZWFrOwoK
IMKgwqDCoCBkZWZhdWx0OgogwqDCoMKgwqDCoMKgwqAgZXhpdCgwKTsKIMKgwqDCoCB9Ci8vIGhl
cmUgZGFlbW9uIHByb2Nlc3MgdGFrZSBjb250cm9sLgogwqDCoMKgIG5neF9wYXJlbnQgPSBuZ3hf
cGlkOwogwqDCoMKgIG5neF9waWQgPSBuZ3hfZ2V0cGlkKCk7CgoKZm9yay5jCmNvcHlfbW0KIMKg
wqDCoMKgwqDCoMKgIGlmIChjbG9uZV9mbGFncyAmIENMT05FX1ZNKSB7CiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgbW1nZXQob2xkbW0pOwogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIG1tID0gb2xkbW07CiDCoMKgwqDCoMKgwqDCoCB9IGVsc2UgewogwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIG1tID0gZHVwX21tKHRzaywgY3VycmVudC0+bW0pO8KgwqDCoCAv
LyBoZXJlIGRhZW1vbiAKcHJvY2VzcyBoYW5kbGluZyB3aXRob3V0IG1tZ2V0LgoKbWFzdGVyIHBy
b2Nlc3MgcXVpdCwgbW1wdXQgLT7CoCBtbV9wYXNpZF9kcm9wLT5pb2FzaWRfZnJlZQpCdXQgdGhp
cyBpZ25vcmUgZHJpdmVyJ3MgaW9tbXVfc3ZhX3VuYmluZF9kZXZpY2UgZnVuY3Rpb24sCmlvbW11
X3N2YV9iaW5kX2RldmljZSBhbmQgaW9tbXVfc3ZhX3VuYmluZF9kZXZpY2UgYXJlIG5vdCBwYWly
LMKgIFNvIApkcml2ZXIgZG9lcyBub3Qga25vdyBpb2FzaWQgaXMgZnJlZWQuCgpBbnkgc3VnZ2Vz
dGlvbj8KT3IgY2FuIHdlIHN0aWxsIHVzZSB0aGUgb3JpZ2luYWwgaW9hc2lkIHJlZmNvdW50IG1l
Y2hhbmlzbT8KClRoYW5rcwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9t
bXU=
