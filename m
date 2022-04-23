Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B65C433EF
	for <iommu@archiver.kernel.org>; Sat, 23 Apr 2022 11:14:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6B46583F06;
	Sat, 23 Apr 2022 11:14:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 21nHvNSWirm4; Sat, 23 Apr 2022 11:13:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8517B83EE7;
	Sat, 23 Apr 2022 11:13:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C44EC0039;
	Sat, 23 Apr 2022 11:13:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 123D3C002D
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 11:13:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EC8D840101
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 11:13:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=foxmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q0K5S1faZBFE for <iommu@lists.linux-foundation.org>;
 Sat, 23 Apr 2022 11:13:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com
 [203.205.221.221])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 597AE400EA
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 11:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1650712424;
 bh=+7VnTMAvj4C28OEILNT3dhdWx4ONbyFVnB8idZPZUfk=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To;
 b=hZ1VRVplfpK/1ll46iyhW4+jUxJHnjTdTBa0aviWL0xLsv1MfYRVW8l/6E1/m7Q64
 nboYvdelItyAEFvptk9DEwjhH5Xh+zfioCt5jNQtOTPqpLhQ6KiVptmNu1gD5Hivfc
 Qu+OSraPCMldV8Rkh2jo8H2/AcoQZxrrmhDfmYTg=
Received: from [192.168.0.110] ([36.57.134.8])
 by newxmesmtplogicsvrsza8.qq.com (NewEsmtp) with SMTP
 id 3679A236; Sat, 23 Apr 2022 19:13:39 +0800
X-QQ-mid: xmsmtpt1650712419tjjfr8ek0
Message-ID: <tencent_2922DAB6F3D5789A1CD3A21A843B4007ED09@qq.com>
X-QQ-XMAILINFO: MKPSrEIbElLqQamjPv0ecbEGyFZP81f1fAj6O5j4qXvMSnjDIQ5a+AHWBJeYwZ
 MIow/FglXG9oJMflNCE8fA0RHkfaOOE4JOyUsthCK0MRQlOv+KejPZRrKR80pmrLofrYnQK8emai
 BE5hbiSoAW0RvUost+0NeBcOie7owMyq9sN02gDb4Cz/vTFPE6SHeHTxa1xqykD0wOZKCZ+3pnNn
 54eKUJ8BTND9+YIYnpho3sXsBhiQXoACtxBj6v4hrD/O6K+GX7WSIHZfl1J0HxN60TZaBKPjlUJI
 i0+Hjvwsbrub7vBiLjPN6crtNW8VhJ/IKQq4j/2Wyrf8IK8GpcdglmzM1/2JiEoG5nHNFxjmpWOR
 vH1GciqFkuvKkddlxG/chlmwCha+y4EIyGJuGOK1S0h7m03uzcXGVafwV7xG8JcB9R2WXOeE41XI
 fPDtNkLz2RP7YACetot9C96xnMazm7OSthsIrSXxPzMhH55VDlE47Rc/bElv/B0Q3h/k+Ir2zd0o
 SawWtrpDtM4JVl8YkVqwLwpsbXTNgy1KRemTYznK32oACfx7FELrmxoI9HJD5Zf2luLl5NFCjG/L
 UrZx+HM7diL1b/o39Ee43rpkusWED5G3pkZVdIVlblGwRkf04tv6mEmPPMMN3Pj3C9s2pqfU3/XC
 RgEwdVWKBKSYYf+RnM2m71m6cp/lULcGiEurhiwP75j/eKEkbwrmxX7EBt1baw6HUZ7+oBxdQkCX
 1k3kAZhu+IJR9MPkCsnesXjdj5bSBffHysFvnPqhxIsWSSKyqEsK9rvOwfyKmwBgl7USsqHW4dke
 5qhxUYZKQ/n7H9/SsQHHSoTAUDLvNpJBCFhsRR32IlGLl08lrBHEuGvVZGs8JFsmOBeMlvcafsFu
 GUnYQDHFmtT7cSpwG68L93Fmwk7wwjLVNFHW3v+SH4/iQTaiexeQTVhD8O17JKbBYnkHn8sP4JRc
 wfDns9nguH+CiK7l0isuylPRpyJE/eDjWhRfdpynY=
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
 <YlWBkyGeb2ZOGLKl@fyu1.sc.intel.com>
 <tencent_A9458C6CEBAADD361DA765356477B00E920A@qq.com>
 <tencent_8B6D7835F62688B4CD069C0EFC41B308B407@qq.com>
 <YllADL6uMoLllzQo@fyu1.sc.intel.com> <YmA4pbgevqln/jSO@myrica>
 <tencent_76E043C4D1B6A21A5253579A61034107EB06@qq.com>
 <tencent_7477100F8A445C6CAFA8F13601A55134480A@qq.com>
 <YmJ/WA6KAQU/xJjA@myrica>
 <tencent_A4E83BA6071B2204B6F5D4E69A50D21C1A09@qq.com>
 <YmLOznyBF0f7COYT@myrica>
From: "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
X-OQ-MSGID: <940439f7-33e5-ba32-c977-6517271c9445@foxmail.com>
Date: Sat, 23 Apr 2022 19:13:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YmLOznyBF0f7COYT@myrica>
Content-Language: en-US
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, robin.murphy@arm.com,
 Dave Hansen <dave.hansen@linux.intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, iommu <iommu@lists.linux-foundation.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 zhangfei.gao@linaro.org, Thomas Gleixner <tglx@linutronix.de>, will@kernel.org
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

SGksIEplYW4KCk9uIDIwMjIvNC8yMiDkuIvljYgxMTo1MCwgSmVhbi1QaGlsaXBwZSBCcnVja2Vy
IHdyb3RlOgo+IE9uIEZyaSwgQXByIDIyLCAyMDIyIGF0IDA5OjE1OjAxUE0gKzA4MDAsIHpoYW5n
ZmVpLmdhb0Bmb3htYWlsLmNvbSB3cm90ZToKPj4+IEknbSB0cnlpbmcgdG8gcGllY2UgdG9nZXRo
ZXIgd2hhdCBoYXBwZW5zIGZyb20gdGhlIGtlcm5lbCBwb2ludCBvZiB2aWV3Lgo+Pj4KPj4+ICog
bWFzdGVyIHByb2Nlc3Mgd2l0aCBtbSBBIG9wZW5zIGEgcXVldWUgZmQgdGhyb3VnaCB1YWNjZSwg
d2hpY2ggY2FsbHMKPj4+ICAgICBpb21tdV9zdmFfYmluZF9kZXZpY2UoZGV2LCBBKSAtPiBQQVNJ
RCAxCj4+Pgo+Pj4gKiBtYXN0ZXIgZm9ya3MgYW5kIGV4aXRzLiBDaGlsZCAoZGFlbW9uKSBnZXRz
IG1tIEIsIGluaGVyaXRzIHRoZSBxdWV1ZSBmZC4KPj4+ICAgICBUaGUgZGV2aWNlIGlzIHN0aWxs
IGJvdW5kIHRvIG1tIEEgd2l0aCBQQVNJRCAxLCBzaW5jZSB0aGUgcXVldWUgZmQgaXMKPj4+ICAg
ICBzdGlsbCBvcGVuLgo+Pj4gV2UgZGlzY3Vzc2VkIHRoaXMgYmVmb3JlLCBidXQgSSBkb24ndCBy
ZW1lbWJlciB3aGVyZSB3ZSBsZWZ0IG9mZi4gVGhlCj4+PiBjaGlsZCBjYW4ndCB1c2UgdGhlIHF1
ZXVlIGJlY2F1c2UgaXRzIG1hcHBpbmdzIGFyZSBub3QgY29waWVkIG9uIGZvcmsoKSwKPj4+IGFu
ZCB0aGUgcXVldWUgaXMgc3RpbGwgYm91bmQgdG8gdGhlIHBhcmVudCBtbSBBLiBUaGUgY2hpbGQg
ZWl0aGVyIG5lZWRzIHRvCj4+PiBvcGVuIGEgbmV3IHF1ZXVlIG9yIHRha2Ugb3duZXJzaGlwIG9m
IHRoZSBvbGQgb25lIHdpdGggYSBuZXcgdWFjY2UgaW9jdGwuCj4+IFllcywgY3VycmVudGx5IG5n
aW54IGFsaWduZWQgd2l0aCB0aGUgY2FzZS4KPj4gQ2hpbGQgcHJvY2VzcyAod29ya2VyIHByb2Nl
c3MpIHJlb3BlbiB1YWNjZSwKPj4KPj4gTWFzdGVyIHByb2Nlc3MgKGRvIGluaXQpIG9wZW4gdWFj
Y2UsIGlvbW11X3N2YV9iaW5kX2RldmljZShkZXYsIEEpIC0+IFBBU0lECj4+IDEKPj4gTWFzdGVy
IHByb2Nlc3MgZm9yayBDaGlsZCAoZGFlbW9uKSBhbmQgZXhpdC4KPj4KPj4gQ2hpbGQgKGRhZW1v
binCoCBkb2VzIG5vdCB1c2UgUEFTSUQgMSBhbnkgbW9yZSwgb25seSBmb3JrIGFuZCBtYW5hZ2Ug
d29ya2VyCj4+IHByb2Nlc3MuCj4+IFdvcmtlciBwcm9jZXNzIHJlb3BlbiB1YWNjZSwgaW9tbXVf
c3ZhX2JpbmRfZGV2aWNlKGRldiwgQikgUEFTSUQgMgo+Pgo+PiBTbyBpdCBpcyBleHBlY3RlZC4K
PiBZZXMsIHRoYXQncyBmaW5lCj4KPj4+IElzIHRoYXQgdGhlICJJTVBMRU1FTlRfRFlOQU1JQ19C
SU5EX0ZOKCkiIHlvdSBtZW50aW9uLCBzb21ldGhpbmcgb3V0IG9mCj4+PiB0cmVlPyAgVGhpcyBv
cGVyYXRpb24gc2hvdWxkIHVuYmluZCBmcm9tIEEgYmVmb3JlIGJpbmRpbmcgdG8gQiwgbm8/Cj4+
PiBPdGhlcndpc2Ugd2UgbGVhayBQQVNJRCAxLgo+PiBJbiA1LjE2IFBBU0lEIDEgZnJvbSBtYXN0
ZXIgaXMgaG9sZCB1bnRpbCBuZ2lueCBzZXJ2aWNlIHN0b3AuCj4+IG5naW54IHN0YXJ0Cj4+IG1h
c3RlcjoKPj4gaW9tbXVfc3ZhX2FsbG9jX3Bhc2lkIG1tLT5wYXNpZD0xwqDCoMKgIMKgIC8vIG1h
c3RlciBwcm9jZXNzCj4+Cj4+IGx5bnggaHR0cHMgc3RhcnQ6Cj4+IGlvbW11X3N2YV9hbGxvY19w
YXNpZCBtbS0+cGFzaWQ9MsKgwqDCoCAvL3dvcmtlciBwcm9jZXNzCj4+Cj4+IG5naW54IHN0b3A6
wqAgZnJvbSBmb3BzX3JlbGVhc2UKPj4gaW9tbXVfc3ZhX2ZyZWVfcGFzaWQgbW0tPnBhc2lkPTLC
oMKgIC8vIHdvcmtlciBwcm9jZXNzCj4+IGlvbW11X3N2YV9mcmVlX3Bhc2lkIG1tLT5wYXNpZD0x
wqAgLy8gbWFzdGVyIHByb2Nlc3MKPiBUaGF0J3MgdGhlIGV4cGVjdGVkIGJlaGF2aW9yIChtYXN0
ZXIgY291bGQgY2xvc2UgaXRzIGZkIGJlZm9yZSBmb3JraW5nLCBpbgo+IG9yZGVyIHRvIGZyZWUg
dGhpbmdzIHVwIGVhcmxpZXIsIGJ1dCBpdCdzIG5vdCBtYW5kYXRvcnkpCkN1cnJlbnRseSB3ZSB1
bmJpbmQgaW4gZm9wc19yZWxlYXNlLCBzbyB0aGUgaW9hc2lkIGFsbG9jYXRlZCBpbiBtYXN0ZXIg
CmNhbiBvbmx5IGJlIGZyZWVkIHdoZW4gbmdpbnggc3RvcCwKd2hlbiBhbGwgZm9ya2VkIGZkIGFy
ZSBjbG9zZWQuCgo+Cj4+IEhhdmUgb25lIHNpbGx5IHF1ZXN0aW9uLgo+Pgo+PiBrZXJuZSBkcml2
ZXIKPj4gZm9wc19vcGVuCj4+IGlvbW11X3N2YV9iaW5kX2RldmljZQo+Pgo+PiBmb3BzX3JlbGVh
c2UKPj4gaW9tbXVfc3ZhX3VuYmluZF9kZXZpY2UKPj4KPj4gYXBwbGljYXRpb24KPj4gbWFpbigp
Cj4+IGZkID0gb3Blbgo+PiByZXR1cm47Cj4+Cj4+IEFwcGxpY2F0aW9uIGV4aXQgYnV0IG5vdCBj
bG9zZShmZCksIGlzIGl0IGV4cGVjdGVkIGZvcHNfcmVsZWFzZSB3aWxsIGJlCj4+IGNhbGxlZCBh
dXRvbWF0aWNhbGx5IGJ5IHN5c3RlbT8KPiBZZXMsIHRoZSBhcHBsaWNhdGlvbiBkb2Vzbid0IGhh
dmUgdG8gY2FsbCBjbG9zZSgpIGV4cGxpY2l0bHksIHRoZSBmaWxlCj4gZGVzY3JpcHRvciBpcyBj
bG9zZWQgYXV0b21hdGljYWxseSBvbiBleGl0LiBOb3RlIHRoYXQgdGhlIGZkIGlzIGNvcGllZCBv
bgo+IGZvcmsoKSwgc28gaXQgaXMgb25seSByZWxlYXNlZCBvbmNlIHBhcmVudCBhbmQgYWxsIGNo
aWxkIHByb2Nlc3NlcyBleGl0LgpZZXMsIGluIGNhc2UgdGhlIGFwcGxpY2F0aW9uIGVuZGVkIHVu
ZXhwZWN0ZWQsIGxpa2UgY3RybCtjCj4KPj4gT24gNS4xNwo+PiBmb3BzX3JlbGVhc2UgaXMgY2Fs
bGVkIGF1dG9tYXRpY2FsbHksIGFzIHdlbGwgYXMgaW9tbXVfc3ZhX3VuYmluZF9kZXZpY2UuCj4+
IE9uIDUuMTgtcmMxLgo+PiBmb3BzX3JlbGVhc2UgaXMgbm90IGNhbGxlZCwgaGF2ZSB0byBtYW51
YWxseSBjYWxsIGNsb3NlKGZkKQo+IFJpZ2h0IHRoYXQncyB3ZWlyZApMb29rcyBpdCBpcyBjYXVz
ZWQgYnkgdGhlIGZpeCBwYXRjaCwgdmlhIG1tZ2V0LCB3aGljaCBtYXkgYWRkIHJlZmNvdW50IApv
ZiBmZC4KClNvbWUgZXhwZXJpbWVudHMKMS4gNS4xNywgZXZlcnl0aGluZyB3b3JrcyB3ZWxsLgoK
Mi4gNS4xNyArIHBhdGNoc2V0IG9mICJpb21tdS9zdmE6IEFzc2lnbiBhIFBBU0lEIHRvIG1tIG9u
IFBBU0lEIAphbGxvY2F0aW9uIGFuZCBmcmVlIGl0IG9uIG1tIGV4aXQiCgpUZXN0IGFwcGxpY2F0
aW9uLCBleGl0IHdpdGhvdXQgY2xvc2UgdWFjY2UgZmQKRmlyc3QgdGltZTrCoCBmb3BzX3JlbGVh
c2UgY2FuIGJlIGNhbGxlZCBhdXRvbWF0aWNhbGx5LgoKbG9nOgppb2FzaWRfYWxsb2MgaW9hc2lk
PTEKaW9tbXVfc3ZhX2FsbG9jX3Bhc2lkIHBhc2lkPTEKaW9tbXVfc3ZhX2JpbmRfZGV2aWNlIGhh
bmRsZT0wMDAwMDAwMDI2M2EyZWU4CmlvYXNpZF9mcmVlIGlvYXNpZD0xCnVhY2NlX2ZvcHNfcmVs
ZWFzZSBxPTAwMDAwMDAwNTVjYTNjZGYKaW9tbXVfc3ZhX3VuYmluZF9kZXZpY2UgaGFuZGxlPTAw
MDAwMDAwMjYzYTJlZTgKClNlY29uZCB0aW1lOiBoYXJkd2FyZSByZXBvcnRzIGVycm9yCgp1YWNj
ZV9mb3BzX29wZW4gcT0wMDAwMDAwMDhlNGQ2Zjc4CmlvYXNpZF9hbGxvYyBpb2FzaWQ9MQppb21t
dV9zdmFfYWxsb2NfcGFzaWQgcGFzaWQ9MQppb21tdV9zdmFfYmluZF9kZXZpY2UgaGFuZGxlPTAw
MDAwMDAwY2ZkMTE3ODgKLy8gSGFyZWR3YXJlIHJlcG9ydHMgZXJyb3IKaGlzaV9zZWMyIDAwMDA6
YjY6MDAuMDogcW1fYWNjX2RvX3Rhc2tfdGltZW91dCBbZXJyb3Igc3RhdHVzPTB4MjBdIGZvdW5k
Cmhpc2lfc2VjMiAwMDAwOmI2OjAwLjA6IHFtX2FjY193Yl9ub3RfcmVhZHlfdGltZW91dCBbZXJy
b3Igc3RhdHVzPTB4NDBdIApmb3VuZApoaXNpX3NlYzIgMDAwMDpiNjowMC4wOiBzZWNfZnNtX2hi
ZWF0X3JpbnQgW2Vycm9yIHN0YXR1cz0weDIwXSBmb3VuZApoaXNpX3NlYzIgMDAwMDpiNjowMC4w
OiBDb250cm9sbGVyIHJlc2V0dGluZy4uLgpoaXNpX3NlYzIgMDAwMDpiNjowMC4wOiBRTSBtYWls
Ym94IG9wZXJhdGlvbiB0aW1lb3V0IQpoaXNpX3NlYzIgMDAwMDpiNjowMC4wOiBGYWlsZWQgdG8g
ZHVtcCBzcWMhCmhpc2lfc2VjMiAwMDAwOmI2OjAwLjA6IEZhaWxlZCB0byBkcmFpbiBvdXQgZGF0
YSBmb3Igc3RvcHBpbmchCmhpc2lfc2VjMiAwMDAwOmI2OjAwLjA6IEJ1cyBsb2NrISBQbGVhc2Ug
cmVzZXQgc3lzdGVtLgpoaXNpX3NlYzIgMDAwMDpiNjowMC4wOiBDb250cm9sbGVyIHJlc2V0IGZh
aWxlZCAoLTExMCkKaGlzaV9zZWMyIDAwMDA6YjY6MDAuMDogY29udHJvbGxlciByZXNldCBmYWls
ZWQgKC0xMTApCgozLiBBZGQgdGhlIGZpeCBwYXRjaCBvZiB1c2luZyBtbWdldCBpbiBiaW5kLgpU
ZXN0IGFwcGxpY2F0aW9uLCBleGl0IHdpdGhvdXQgY2xvc2UgdWFjY2UgZmQKCmZvcHNfcmVsZWFz
ZSBjYW4gTk9UIGJlIGNhbGxlZCBhdXRvbWF0aWNhbGx5LCBsb29rcyBtbWdldCBhZGRzIHJlZmNv
dW50IApvZiBmZC4KClNvIHRoZSBmaXggbWV0aG9kIG9mIHVzaW5nIG1tZ2V0IGJsb2NrcyBmb3Bz
X3JlbGVhc2UgdG8gYmUgY2FsbGVkIG9uY2UgCmZkIGlzIGNsb3NlZCB3aXRob3V0IHVuYmluZC4K
Cj4+IFNpbmNlIG5naW54IG1heSBoYXZlIGEgaXNzdWUsIGl0IGRvZXMgbm90IGNhbGwgY2xvc2Uo
ZmQpIHdoZW4gbmdpbnggLXMgcXVpdC4KPiBBbmQgeW91J3JlIHN1cmUgdGhhdCBub25lIG9mIHRo
ZSBwcm9jZXNzZXMgYXJlIHN0aWxsIGFsaXZlIG9yIGluIHpvbWJpZQo+IHN0YXRlPyAgSnVzdCB0
byBjb3ZlciBldmVyeSBwb3NzaWJpbGl0eS4KSXQgY2FuIGFsc28gcmVwcm9kdWNlZCBieSBhIHNp
bXBsZSBhcHBsaWNhdGlvbiBleGl0IHdpdGhvdXQgY2xvc2UodWFjY2VfZmQpCgpUaGFua3MKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxp
bmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
