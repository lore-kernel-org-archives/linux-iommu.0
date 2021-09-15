Return-Path: <SRS0=KP5g=OF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235CAC433EF
	for <iommu@archiver.kernel.org>; Wed, 15 Sep 2021 17:18:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C217361216
	for <iommu@archiver.kernel.org>; Wed, 15 Sep 2021 17:18:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C217361216
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8842060B28;
	Wed, 15 Sep 2021 17:18:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4ZYlWqqSfuEN; Wed, 15 Sep 2021 17:18:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6EB5C605CF;
	Wed, 15 Sep 2021 17:18:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4F02CC000F;
	Wed, 15 Sep 2021 17:18:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D093C000D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Sep 2021 17:18:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6EC3B4010D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Sep 2021 17:18:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t2O9iD9uU5hi for <iommu@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 17:18:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1D450400CC
 for <iommu@lists.linux-foundation.org>; Wed, 15 Sep 2021 17:18:39 +0000 (UTC)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4H8n4F0x0Hz9sV4;
 Wed, 15 Sep 2021 19:18:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PKzNyxImFUbI; Wed, 15 Sep 2021 19:18:37 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4H8n4D73HWz9sV3;
 Wed, 15 Sep 2021 19:18:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id D8C808B77C;
 Wed, 15 Sep 2021 19:18:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id QXqNkIx7zBCr; Wed, 15 Sep 2021 19:18:36 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.204.250])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 11BA38B763;
 Wed, 15 Sep 2021 19:18:34 +0200 (CEST)
Subject: Re: [PATCH v3 4/8] powerpc/pseries/svm: Add a powerpc version of
 cc_platform_has()
To: Borislav Petkov <bp@alien8.de>, Michael Ellerman <mpe@ellerman.id.au>
References: <cover.1631141919.git.thomas.lendacky@amd.com>
 <9d4fc3f8ea7b325aaa1879beab1286876f45d450.1631141919.git.thomas.lendacky@amd.com>
 <YUCOTIPPsJJpLO/d@zn.tnic> <87lf3yk7g4.fsf@mpe.ellerman.id.au>
 <YUHGDbtiGrDz5+NS@zn.tnic>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <f8388f18-5e90-5d0f-d681-0b17f8307dd4@csgroup.eu>
Date: Wed, 15 Sep 2021 19:18:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YUHGDbtiGrDz5+NS@zn.tnic>
Content-Language: fr-FR
Cc: linux-s390@vger.kernel.org, linux-efi@vger.kernel.org,
 Brijesh Singh <brijesh.singh@amd.com>, kvm@vger.kernel.org,
 Tom Lendacky <thomas.lendacky@amd.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 Andi Kleen <ak@linux.intel.com>, Paul Mackerras <paulus@samba.org>,
 amd-gfx@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
 linux-graphics-maintainer@vmware.com, linuxppc-dev@lists.ozlabs.org
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

CgpMZSAxNS8wOS8yMDIxIMOgIDEyOjA4LCBCb3Jpc2xhdiBQZXRrb3YgYSDDqWNyaXTCoDoKPiBP
biBXZWQsIFNlcCAxNSwgMjAyMSBhdCAxMDoyODo1OUFNICsxMDAwLCBNaWNoYWVsIEVsbGVybWFu
IHdyb3RlOgo+PiBJIGRvbid0IGxvdmUgaXQsIGEgbmV3IEMgZmlsZSBhbmQgYW4gb3V0LW9mLWxp
bmUgY2FsbCB0byB0aGVuIGNhbGwgYmFjawo+PiB0byBhIHN0YXRpYyBpbmxpbmUgdGhhdCBmb3Ig
bW9zdCBjb25maWd1cmF0aW9uIHdpbGwgcmV0dXJuIGZhbHNlIC4uLiBidXQKPj4gd2hhdGV2ZXIg
OikKPiAKPiBZZWFoLCBoY2ggdGhpbmtzIGl0J2xsIGNhdXNlIGEgYmlnIG1lc3Mgb3RoZXJ3aXNl
Ogo+IAo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvWVNTY1d2cFhlVlh3JTJGZWQ1QGlu
ZnJhZGVhZC5vcmcvCgpDb3VsZCB5b3UgcGxlYXNlIHByb3ZpZGUgbW9yZSBleHBsaWNpdCBleHBs
YW5hdGlvbiB3aHkgaW5saW5pbmcgc3VjaCBhbiAKaGVscGVyIGlzIGNvbnNpZGVyZWQgYXMgYmFk
IHByYWN0aWNlIGFuZCBtZXNzeSA/CgpCZWNhdXNlIGFzIGRlbW9uc3RyYXRlZCBpbiBteSBwcmV2
aW91cyByZXNwb25zZSBzb21lIGRheXMgYWdvLCB0YWtpbmcgCnRoYXQgb3V0bGluZSBlbmRzIHVw
IHdpdGggYW4gdW5uZWNjZXNzYXJ5IHVnbHkgZ2VuZXJhdGVkIGNvZGUgYW5kIHdlIApkb24ndCBi
ZW5lZml0IGZyb250IEdDQydzIGNhcGFiaWxpdHkgdG8gZm9sZCBpbiBhbmQgb3B0IG91dCB1bnJl
YWNoYWJsZSAKY29kZS4KCkFzIHBvaW50ZWQgYnkgTWljaGFlbCBpbiBtb3N0IGNhc2VzIHRoZSBm
dW5jdGlvbiB3aWxsIGp1c3QgcmV0dXJuIGZhbHNlIApzbyBiZWhpbmQgdGhlIHBlcmZvcm1hbmNl
IGNvbmNlcm4sIHRoZXJlIGlzIGFsc28gdGhlIGNvZGUgc2l6ZSBhbmQgY29kZSAKY292ZXJhZ2Ug
dG9waWMgdGhhdCBpcyB0byBiZSB0YWtlbiBpbnRvIGFjY291bnQuIEFuZCBldmVuIHdoZW4gdGhl
IApmdW5jdGlvbiBkb2Vzbid0IHJldHVybiBmYWxzZSwgdGhlIG9ubHkgdGhpbmcgaXQgZG9lcyBm
b2xkcyBpbnRvIGEgCnNpbmdsZSBwb3dlcnBjIGluc3RydWN0aW9uIHNvIHRoZXJlIGlzIHJlYWxs
eSBubyBwb2ludCBpbiBtYWtpbmcgYSAKZGVkaWNhdGVkIG91dC1vZi1saW5lIGZvbmN0aW9uIGZv
ciB0aGF0IGFuZCBzdWZmZXIgdGhlIGNvc3QgYW5kIHRoZSBzaXplIApvZiBhIGZ1bmN0aW9uIGNh
bGwgYW5kIHRvIGp1c3RpZnkgdGhlIGFkZGl0aW9uIG9mIGEgZGVkaWNhdGVkIEMgZmlsZS4KCgo+
IAo+IEkgZ3Vlc3MgbGVzcyBpZmRlZmZlcnkgaXMgbmljZSB0b28uCgpJIGNhbid0IHNlZSB5b3Vy
IHBvaW50IGhlcmUuIElubGluaW5nIHRoZSBmdW5jdGlvbiB3b3VsZG4ndCBhZGQgYW55IAppZmRl
ZmZlcnkgYXMgZmFyIGFzIEkgY2FuIHNlZS4KClNvLCB3b3VsZCB5b3UgbWluZCByZWNvbnNpZGVy
aW5nIHlvdXIgYXBwcm9hY2ggYW5kIGFsbG93IGFyY2hpdGVjdHVyZXMgCnRvIHByb3ZpZGUgaW5s
aW5lIGltcGxlbWVudGF0aW9uIGJ5IGp1c3Qgbm90IGVuZm9yY2luZyBhIGdlbmVyaWMgCnByb3Rv
dHlwZSA/IE9yIG90aGVyd2lzZSBwcm92aWRlIG1vcmUgZGV0YWlscyBhbmQgZXhlbXBsZSBvZiB3
aHkgdGhlIApjb25zIGFyZSBtb3JlIGltcG9ydGFudCB2ZXJzdXMgdGhlIHByb3MgPwoKVGhhbmtz
CkNocmlzdG9waGUKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
