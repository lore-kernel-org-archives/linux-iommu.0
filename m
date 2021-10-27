Return-Path: <SRS0=XM0R=PP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DC5C433F5
	for <iommu@archiver.kernel.org>; Wed, 27 Oct 2021 17:19:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE5636058D
	for <iommu@archiver.kernel.org>; Wed, 27 Oct 2021 17:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AE5636058D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7F83C6071D;
	Wed, 27 Oct 2021 17:19:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fjo1OMk-RoRD; Wed, 27 Oct 2021 17:19:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6617D605F2;
	Wed, 27 Oct 2021 17:19:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47DABC0012;
	Wed, 27 Oct 2021 17:19:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99DB6C000E
 for <iommu@lists.linux-foundation.org>; Wed, 27 Oct 2021 17:19:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7671540501
 for <iommu@lists.linux-foundation.org>; Wed, 27 Oct 2021 17:19:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Lxddl6MSy9sk for <iommu@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 17:19:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 17E0A40317
 for <iommu@lists.linux-foundation.org>; Wed, 27 Oct 2021 17:19:02 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40864ED1;
 Wed, 27 Oct 2021 10:19:02 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CB533F70D;
 Wed, 27 Oct 2021 10:19:00 -0700 (PDT)
Subject: Re: I got an IOMMU IO page fault. What to do now?
To: Paul Menzel <pmenzel@molgen.mpg.de>
References: <7a5123b0-6370-59dc-f0c2-8be5b370d9ba@molgen.mpg.de>
 <0cfccc44-6cc6-98f5-ecd6-2f376839ec18@gmail.com>
 <bc7142a1-82d3-43bf-dee2-25f9297e7182@arm.com>
 <3c2de089-8f80-3644-7735-7df1c6151d70@molgen.mpg.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <82fccb9d-43e8-4485-0ddb-7ff260f3ed32@arm.com>
Date: Wed, 27 Oct 2021 18:18:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <3c2de089-8f80-3644-7735-7df1c6151d70@molgen.mpg.de>
Content-Language: en-GB
Cc: x86@kernel.org,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Alex Deucher <alexander.deucher@amd.com>, it+linux-iommu@molgen.mpg.de,
 Thomas Gleixner <tglx@linutronix.de>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
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

T24gMjcvMTAvMjAyMSA1OjQ1IHBtLCBQYXVsIE1lbnplbCB3cm90ZToKPiBEZWFyIFJvYmluLAo+
IAo+IAo+IE9uIDI1LjEwLjIxIDE4OjAxLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+IE9uIDIwMjEt
MTAtMjUgMTI6MjMsIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gCj4+PiBub3Qgc3VyZSBob3cg
dGhlIElPTU1VIGdpdmVzIG91dCBhZGRyZXNzZXMsIGJ1dCB0aGUgcHJpbnRlZCBvbmVzIGxvb2sg
Cj4+PiBzdXNwaWNpb3VzIHRvIG1lLiBTb21ldGhpbmcgbGlrZSB3ZSBhcmUgdXNpbmcgYW4gaW52
YWxpZCBhZGRyZXNzIGxpa2UgCj4+PiAtMSBvciBzaW1pbGFyLgo+Pgo+PiBGV0lXIHRob3NlIGxv
b2sgbGlrZSBiZWxpZXZhYmxlIERNQSBhZGRyZXNzZXMgdG8gbWUsIGFzc3VtaW5nIHRoYXQgdGhl
IAo+PiBETUEgbWFwcGluZyBBUElzIGFyZSBiZWluZyBiYWNrZWQgaW9tbXVfZG1hX29wcyBhbmQg
dGhlIGRldmljZSBoYXMgYSAKPj4gNDAtYml0IERNQSBtYXNrLCBzaW5jZSB0aGUgSU9WQSBhbGxv
Y2F0b3Igd29ya3MgdG9wLWRvd24uCj4+Cj4+IExpa2VseSBjYXVzZXMgYXJlIGVpdGhlciBhIHJh
Y2Ugd2hlcmUgdGhlIGRtYV91bm1hcF8qKCkgY2FsbCBoYXBwZW5zIAo+PiBiZWZvcmUgdGhlIGhh
cmR3YXJlIGhhcyByZWFsbHkgc3RvcHBlZCBhY2Nlc3NpbmcgdGhlIHJlbGV2YW50IAo+PiBhZGRy
ZXNzZXMsIG9yIHRoZSBkZXZpY2UncyBETUEgbWFzayBoYXMgYmVlbiBzZXQgbGFyZ2VyIHRoYW4g
aXQgc2hvdWxkIAo+PiBiZSwgYW5kIHRodXMgdGhlIHVwcGVyIGJpdHMgaGF2ZSBiZWVuIHRydW5j
YXRlZCBpbiB0aGUgcm91bmQtdHJpcCAKPj4gdGhyb3VnaCB0aGUgaGFyZHdhcmUuCj4+Cj4+IEdp
dmVuIHRoZSBhZGRyZXNzZXMgaW52b2x2ZWQsIG15IHN1c3BpY2lvbnMgd291bGQgaW5pdGlhbGx5
IGxlYW4gCj4+IHRvd2FyZHMgdGhlIGxhdHRlciBjYXNlIC0gdGhlIGZhdWx0cyBhcmUgaW4gdGhl
IHZlcnkgdG9wbW9zdCBwYWdlcyAKPj4gd2hpY2ggaW1wbHkgdGhleSdyZSB0aGUgZmlyc3QgdGhp
bmdzIG1hcHBlZCBpbiB0aGF0IHJhbmdlLiBUaGUgb3RoZXIgCj4+IGNvbnRyaWJ1dGluZyBmYWN0
b3IgYmVpbmcgdGhlIHRyaWNrIHRoYXQgdGhlIElPVkEgYWxsb2NhdG9yIHBsYXlzIGZvciAKPj4g
UENJIGRldmljZXMsIHdoZXJlIGl0IHRyaWVzIHRvIHByZWZlciAzMi1iaXQgYWRkcmVzc2VzLiBU
aHVzIHlvdSdyZSAKPj4gb25seSBsaWtlbHkgdG8gc2VlIHRoaXMgaGFwcGVuIG9uY2UgeW91IGFs
cmVhZHkgaGF2ZSB+My41LTRHQiBvZiBsaXZlIAo+PiBETUEtbWFwcGVkIG1lbW9yeSB0byBleGhh
dXN0IHRoZSAzMi1iaXQgSU9WQSBzcGFjZSAobWludXMgc29tZSAKPj4gcmVzZXJ2ZWQgYXJlYXMp
IGFuZCBzdGFydCBhbGxvY2F0aW5nIGZyb20gdGhlIGZ1bGwgRE1BIG1hc2suIFlvdSAKPj4gc2hv
dWxkIGJlIGFibGUgdG8gY2hlY2sgdGhhdCB3aXRoIGEgNS4xMyBvciBuZXdlciBrZXJuZWwgYnkg
Ym9vdGluZyAKPj4gd2l0aCAiaW9tbXUuZm9yY2VkYWM9MSIgYW5kIHNlZWluZyBpZiBpdCBicmVh
a3MgaW1tZWRpYXRlbHkgCj4+ICh1bmZvcnR1bmF0ZWx5IHdpdGggYW4gb2xkZXIga2VybmVsIHlv
dSdkIGhhdmUgdG8gbWFudWFsbHkgaGFjayAKPj4gaW9tbXVfZG1hX2FsbG9jX2lvdmEoKSB0byB0
aGUgc2FtZSBlZmZlY3QpLgo+IAo+IEkgYm9vdGVkIExpbnV4IDUuMTUtcmM3IHdpdGggYGlvbW11
LmZvcmNlZGFjPTFgIGFuZCB0aGUgc3lzdGVtIGJvb3RlZCwgCj4gYW5kIEkgY291bGQgbG9nIGlu
IHJlbW90ZWx5IG92ZXIgU1NILiBQbGVhc2UgZmluZCB0aGUgTGludXgga2VybmVsIAo+IG1lc3Nh
Z2VzIGF0dGFjaGVkLiAoVGhlIHN5c3RlbSBsb2dzIHNheSBsaWdodGRtIGZhaWxlZCB0byBzdGFy
dCwgYnV0IGl0IAo+IG1pZ2h0IGJlIHNvbWUgb3RoZXIgaXNzdWUgZHVlIHRvIGEgY2hhbmdlIGlu
IHRoZSBvcGVyYXRpbmcgc3lzdGVtLikKCk9LLCB0aGF0IGxvb2tzIGxpa2UgaXQncyBtYWRlIHRo
ZSBHUFUgYmxvdyB1cCBzdHJhaWdodCBhd2F5LCB3aGljaCBpcyAKd2hhdCBJIHdhcyBob3Bpbmcg
Zm9yIChhbmQgYWxzbyBhcHBlYXJzIHRvIHJldmVhbCBhbm90aGVyIGJ1ZyB3aGVyZSBpdCdzIApu
b3QgaGFuZGxpbmcgcHJvYmUgZmFpbHVyZSB2ZXJ5IHdlbGwgLSBwb3NzaWJseSB0cnlpbmcgdG8g
cmVtb3ZlIGEgCm5vbi1leGlzdGVudCBhdWRpbyBkZXZpY2U/KS4gTGlnaHRkbSBwcmVzdW1hYmx5
IGZhaWxzIHRvIHN0YXJ0IGJlY2F1c2UgCml0IGRvZXNuJ3QgZmluZCBhbnkgZGlzcGxheSBkZXZp
Y2VzLCBzaW5jZSBhbWRncHUgZmFpbGVkIHRvIHByb2JlLgoKSWYgeW91IGNhbiBib290IHRoZSBz
YW1lIGtlcm5lbCB3aXRob3V0ICJpb21tdS5mb3JjZWRhYyIgYW5kIGdldCBhIApzdWNjZXNzZnVs
IHByb2JlIGFuZCB3b3JraW5nIGRpc3BsYXksIHRoYXQgd2lsbCBpbXBseSB0aGF0IGl0IGlzIApt
YW5hZ2luZyB0byB3b3JrIE9LIHdpdGggMzItYml0IERNQSBhZGRyZXNzZXMsIGF0IHdoaWNoIHBv
aW50IEknZCBoYXZlIAp0byBsZWF2ZSBpdCB0byBDaHJpc3RpYW4gYW5kIEFsZXggdG8gZmlndXJl
IG91dCBleGFjdGx5IHdoZXJlIERNQSAKYWRkcmVzc2VzIGFyZSBnZXR0aW5nIG1hbmdsZWQuIFRo
ZSBvbmx5IHRoaW5nIHRoYXQgc3RhbmRzIG91dCB0byBtZSBpcyAKdGhlIHJlZmVyZW5jZSB0byAi
Z2Z4X3Y2XzAiLCB3aGljaCBtYWtlcyBtZSB3b25kZXIgd2hldGhlciBpdCdzIHJlbGF0ZWQgCnRv
IGdtY192Nl8wX3N3X2luaXQoKSB3aGVyZSBhIDQ0LWJpdCBETUEgbWFzayBnZXRzIHNldC4gSWYg
c28sIHRoYXQgCndvdWxkIHN1Z2dlc3QgdGhhdCBlaXRoZXIgdGhpcyBwYXJ0aWN1bGFyIG1vZGVs
IG9mIEdQVSBpcyBtb3JlIGxpbWl0ZWQgCnRoYW4gZXhwZWN0ZWQsIG9yIHRoYXQgU29DIG9ubHkg
aGFzIDQwIGJpdHMgb2YgYWRkcmVzcyB3aXJlZCB1cCBiZXR3ZWVuIAp0aGUgUENJIGhvc3QgYnJp
ZGdlIGFuZCB0aGUgSU9NTVUuCgpDaGVlcnMsClJvYmluLgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vaW9tbXU=
