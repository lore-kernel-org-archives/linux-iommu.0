Return-Path: <SRS0=/C+/=P4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0D9C433F5
	for <iommu@archiver.kernel.org>; Tue,  9 Nov 2021 20:25:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37D1B61168
	for <iommu@archiver.kernel.org>; Tue,  9 Nov 2021 20:25:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 37D1B61168
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E7A4A4044D;
	Tue,  9 Nov 2021 20:25:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id orA19edzk8Uj; Tue,  9 Nov 2021 20:25:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DE6634044A;
	Tue,  9 Nov 2021 20:25:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF50AC0012;
	Tue,  9 Nov 2021 20:25:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28D0BC000E
 for <iommu@lists.linux-foundation.org>; Tue,  9 Nov 2021 20:25:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E604D4044B
 for <iommu@lists.linux-foundation.org>; Tue,  9 Nov 2021 20:25:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ShZEZSrVciu9 for <iommu@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 20:25:52 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 13E524044A
 for <iommu@lists.linux-foundation.org>; Tue,  9 Nov 2021 20:25:51 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5aef56.dynamic.kabel-deutschland.de
 [95.90.239.86])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id AD90461EA1931;
 Tue,  9 Nov 2021 21:25:48 +0100 (CET)
Message-ID: <4ec8db2c-295a-5060-1c0e-184ee072571e@molgen.mpg.de>
Date: Tue, 9 Nov 2021 21:25:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: How to reduce PCI initialization from 5 s (1.5 s adding them to
 IOMMU groups)
Content-Language: en-US
To: =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
References: <de6706b2-4ea5-ce68-6b72-02090b98630f@molgen.mpg.de>
 <YYlb2w1UVaiVYigW@rocinante>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <YYlb2w1UVaiVYigW@rocinante>
Cc: linux-pci@vger.kernel.org, x86@kernel.org,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>
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

RGVhciBLcnp5c3p0b2YsCgoKVGhhbmsgeW91IGZvciB5b3VyIHJlcGx5LgoKCkFtIDA4LjExLjIx
IHVtIDE4OjE4IHNjaHJpZWIgS3J6eXN6dG9mIFdpbGN6ecWEc2tpOgoKPj4gT24gYSBQb3dlckVk
Z2UgVDQ0MC8wMjFLQ0QsIEJJT1MgMi4xMS4yIDA0LzIyLzIwMjEsIExpbnV4IDUuMTAuNzAgdGFr
ZXMKPj4gYWxtb3N0IGZpdmUgc2Vjb25kcyB0byBpbml0aWFsaXplIFBDSS4gQWNjb3JkaW5nIHRv
IHRoZSB0aW1lc3RhbXBzLCAxLjUgcwo+PiBhcmUgZnJvbSBhc3NpZ25pbmcgdGhlIFBDSSBkZXZp
Y2VzIHRvIHRoZSAxNDIgSU9NTVUgZ3JvdXBzLgo+IFsuLi5dCj4+IElzIHRoZXJlIGFueXRoaW5n
IHRoYXQgY291bGQgYmUgZG9uZSB0byByZWR1Y2UgdGhlIHRpbWU/Cj4gCj4gSSBhbSBjdXJpb3Vz
IC0gd2h5IGlzIHRoaXMgYSBwcm9ibGVtPyAgQXJlIHlvdSBwb3dlci1jeWNsaW5nIHlvdXIgc2Vy
dmVycwo+IHNvIG9mdGVuIHRvIHRoZSBwb2ludCB3aGVyZSB0aGUgY3VtdWxhdGl2ZSB0aW1lIHNw
ZW50IGluIGVudW1lcmF0aW5nIFBDSQo+IGRldmljZXMgYW5kIGFkZGluZyB0aGVtIGxhdGVyIHRv
IElPTU1VIGdyb3VwcyBpcyBhIHByb2JsZW0/Cj4gCj4gSSBhbSBzaW1wbHkgd29uZGVyaW5nIHdo
eSB5b3UgZGVjaWRlZCB0byBzaWduYWwgb3V0IHRoZSBQQ0kgZW51bWVyYXRpb24gYXMKPiBzbG93
IGluIHBhcnRpY3VsYXIsIGVzcGVjaWFsbHkgZ2l2ZW4gdGhhdCBhIGxhcmdlIHNlcnZlciBoYXJk
d2FyZSB0ZW5kcyB0bwo+IGhhdmUgKG1vc3Qgb2YgdGhlIHRpbWUsIGFzIHBlciBteSBleHBlcmll
bmNlKSByYXRoZXIgbG9uZyBpbml0aWFsaXNhdGlvbgo+IHRpbWUgZWl0aGVyIGZyb20gYmVpbmcg
cG93ZXJlZCBvZmYgb3IgYWZ0ZXIgYmVpbmcgcG93ZXIgY3ljbGVkLiAgSSBjYW4gdGFrZQo+IGEg
d2hpbGUgYmVmb3JlIHRoZSBhY3R1YWwgb3BlcmF0aW5nIHN5c3RlbSBpdHNlbGYgd2lsbCBzdGFy
dC4KCkl04oCZcyBub3QgYSBwcm9ibGVtIHBlciBzZSwgYW5kIG1vcmUgYSBwZXQgcGVldmUgb2Yg
bWluZS4gU3lzdGVtcyBnZXQgCmZhc3RlciBhbmQgZmFzdGVyLCBhbmQgYm9vdHRpbWUgc2xvd2Vy
IGFuZCBzbG93ZXIuIE9uIGRlc2t0b3Agc3lzdGVtcywgCml04oCZcyBtdWNoIG1vcmUgaW1wb3J0
YW50IHdpdGggZmlybXdhcmUgbGlrZSBjb3JlYm9vdCB0YWtpbmcgbGVzcyB0aGFuIApvbmUgc2Vj
b25kIHRvIGluaXRpYWxpemUgdGhlIGhhcmR3YXJlIGFuZCBwYXNzaW5nIGNvbnRyb2wgdG8gdGhl
IApwYXlsb2FkL29wZXJhdGluZyBzeXN0ZW0uIElmIHdlIGFyZSBsdWNreSwgd2UgYXJlIGdvaW5n
IHRvIGhhdmUgc2VydmVycyAKd2l0aCBGTE9TUyBmaXJtd2FyZS4KCkJ1dCwgYWxyZWFkeSBub3cs
IHVzaW5nIGtleGVjIHRvIHJlYm9vdCBhIHN5c3RlbSwgYXZvaWRzIHRoZSBwcm9ibGVtcyAKeW91
IHBvaW50ZWQgb3V0IG9uIHNlcnZlcnMsIGFuZCBiZWluZyBhYmxlIHRvIHJlYm9vdCBhIHN5c3Rl
bSBhcyBxdWlja2x5IAphcyBwb3NzaWJsZSwgbG93ZXJzIHRoZSBiYXIgZm9yIHBlb3BsZSB0byBy
ZWJvb3Qgc3lzdGVtcyBtb3JlIG9mdGVuIHRvLCAKZm9yIGV4YW1wbGUsIHNvIHVwZGF0ZXMgdGFr
ZSBlZmZlY3QuCgo+IFdlIHRhbGtlZCBhYm91dCB0aGlzIGJyaWVmbHkgd2l0aCBCam9ybiwgYW5k
IHRoZXJlIG1pZ2h0IGJlIGFuIG9wdGlvbiB0bwo+IHBlcmhhcHMgYWRkIHNvbWUgY2FjaGluZywg
YXMgd2Ugc3VzcGVjdCB0aGF0IHRoZSBjdWxwcml0IGhlcmUgaXMgZG9pbmcgUENJCj4gY29uZmln
dXJhdGlvbiBzcGFjZSByZWFkIGZvciBlYWNoIGRldmljZSwgd2hpY2ggY2FuIGJlIHNsb3cgb24g
c29tZQo+IHBsYXRmb3Jtcy4KPiAKPiBIb3dldmVyLCB3ZSB3b3VsZCBuZWVkIHRvIHByb2ZpbGUg
dGhpcyB0byBnZXQgc29tZSBxdWFudGl0YXRpdmUgZGF0YSB0byBzZWUKPiB3aGV0aGVyIGRvaW5n
IGFueXRoaW5nIHdvdWxkIGV2ZW4gYmUgd29ydGh3aGlsZS4gIEl0IHdvdWxkIGRlZmluaXRlbHkg
aGVscAo+IHVzIHVuZGVyc3RhbmQgYmV0dGVyIHdoZXJlIHRoZSBib3R0bGVuZWNrcyByZWFsbHkg
YXJlIGFuZCBvZiB3aGF0IG1hZ25pdHVkZS4KPiAKPiBJIHBlcnNvbmFsbHkgZG9uJ3QgaGF2ZSBh
Y2Nlc3MgdG8gc3VjaCBhIGxhcmdlIGhhcmR3YXJlIGxpa2UgdGhlIG9uZSB5b3UKPiBoYXZlIGFj
Y2VzcyB0bywgdGh1cyBJIHdhcyB3b25kZXJpbmcgd2hldGhlciB5b3Ugd291bGQgaGF2ZSBzb21l
IHRpbWUsIGFuZAo+IGJlIHdpbGxpbmcsIHRvIHByb2ZpbGUgdGhpcyBmb3IgdXMgb24gdGhlIGhh
cmR3YXJlIHlvdSBoYXZlLgo+IAo+IExldCBtZSBrbm93IHdoYXQgZG8geW91IHRoaW5rPwoKU291
bmRzIGdvb2QuIEnigJlkIGJlIHdpbGxpbmcgdG8gaGVscC4gTm90ZSwgdGhhdCBJIHdvbuKAmXQg
aGF2ZSB0aW1lIGJlZm9yZSAKV2VkbmVzZGF5IG5leHQgd2VlayB0aG91Z2guCgoKS2luZCByZWdh
cmRzLAoKUGF1bApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
