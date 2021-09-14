Return-Path: <SRS0=mcPB=OE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9FEC433F5
	for <iommu@archiver.kernel.org>; Tue, 14 Sep 2021 14:47:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77B72603E8
	for <iommu@archiver.kernel.org>; Tue, 14 Sep 2021 14:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 77B72603E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4588580E64;
	Tue, 14 Sep 2021 14:47:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HKV9AP9zxqht; Tue, 14 Sep 2021 14:47:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0E03980D60;
	Tue, 14 Sep 2021 14:47:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC644C000F;
	Tue, 14 Sep 2021 14:47:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23C7DC000D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 14:47:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0CAD540293
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 14:47:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XSlNSckwZzfN for <iommu@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 14:47:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E81474027F
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 14:47:47 +0000 (UTC)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4H85mc3stlz9sTZ;
 Tue, 14 Sep 2021 16:47:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GO3bOpvNkxSJ; Tue, 14 Sep 2021 16:47:44 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4H85mc2pnkz9sTY;
 Tue, 14 Sep 2021 16:47:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 475E88B773;
 Tue, 14 Sep 2021 16:47:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 6uDZRDL0dNLX; Tue, 14 Sep 2021 16:47:44 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.204.207])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 86DA68B763;
 Tue, 14 Sep 2021 16:47:42 +0200 (CEST)
Subject: Re: [PATCH v3 4/8] powerpc/pseries/svm: Add a powerpc version of
 cc_platform_has()
To: Borislav Petkov <bp@alien8.de>, Michael Ellerman <mpe@ellerman.id.au>
References: <cover.1631141919.git.thomas.lendacky@amd.com>
 <9d4fc3f8ea7b325aaa1879beab1286876f45d450.1631141919.git.thomas.lendacky@amd.com>
 <YUCOTIPPsJJpLO/d@zn.tnic>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <41b93dae-2f10-15a3-a079-c632381bec73@csgroup.eu>
Date: Tue, 14 Sep 2021 16:47:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YUCOTIPPsJJpLO/d@zn.tnic>
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

CgpMZSAxNC8wOS8yMDIxIMOgIDEzOjU4LCBCb3Jpc2xhdiBQZXRrb3YgYSDDqWNyaXTCoDoKPiBP
biBXZWQsIFNlcCAwOCwgMjAyMSBhdCAwNTo1ODozNVBNIC0wNTAwLCBUb20gTGVuZGFja3kgd3Jv
dGU6Cj4+IEludHJvZHVjZSBhIHBvd2VycGMgdmVyc2lvbiBvZiB0aGUgY2NfcGxhdGZvcm1faGFz
KCkgZnVuY3Rpb24uIFRoaXMgd2lsbAo+PiBiZSB1c2VkIHRvIHJlcGxhY2UgdGhlIHBvd2VycGMg
bWVtX2VuY3J5cHRfYWN0aXZlKCkgaW1wbGVtZW50YXRpb24sIHNvCj4+IHRoZSBpbXBsZW1lbnRh
dGlvbiB3aWxsIGluaXRpYWxseSBvbmx5IHN1cHBvcnQgdGhlIENDX0FUVFJfTUVNX0VOQ1JZUFQK
Pj4gYXR0cmlidXRlLgo+Pgo+PiBDYzogTWljaGFlbCBFbGxlcm1hbiA8bXBlQGVsbGVybWFuLmlk
LmF1Pgo+PiBDYzogQmVuamFtaW4gSGVycmVuc2NobWlkdCA8YmVuaEBrZXJuZWwuY3Jhc2hpbmcu
b3JnPgo+PiBDYzogUGF1bCBNYWNrZXJyYXMgPHBhdWx1c0BzYW1iYS5vcmc+Cj4+IFNpZ25lZC1v
ZmYtYnk6IFRvbSBMZW5kYWNreSA8dGhvbWFzLmxlbmRhY2t5QGFtZC5jb20+Cj4+IC0tLQo+PiAg
IGFyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvcHNlcmllcy9LY29uZmlnICAgICAgIHwgIDEgKwo+PiAg
IGFyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvcHNlcmllcy9NYWtlZmlsZSAgICAgIHwgIDIgKysKPj4g
ICBhcmNoL3Bvd2VycGMvcGxhdGZvcm1zL3BzZXJpZXMvY2NfcGxhdGZvcm0uYyB8IDI2ICsrKysr
KysrKysrKysrKysrKysrCj4+ICAgMyBmaWxlcyBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspCj4+
ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvcHNlcmllcy9jY19w
bGF0Zm9ybS5jCj4gCj4gTWljaGFlbCwKPiAKPiBjYW4gSSBnZXQgYW4gQUNLIGZvciB0aGUgcHBj
IGJpdHMgdG8gY2FycnkgdGhlbSB0aHJvdWdoIHRoZSB0aXAgdHJlZQo+IHBscz8KPiAKPiBCdHcs
IG9uIGEgcmVsYXRlZCBub3RlLCBjcm9zcy1jb21waWxpbmcgdGhpcyB0aHJvd3MgdGhlIGZvbGxv
d2luZyBlcnJvciBoZXJlOgo+IAo+ICQgbWFrZSBDUk9TU19DT01QSUxFPS9ob21lL3NoYXJlL3Ny
Yy9jcm9zc3Rvb2wvZ2NjLTkuNC4wLW5vbGliYy9wb3dlcnBjNjQtbGludXgvYmluL3Bvd2VycGM2
NC1saW51eC0gVj0xIEFSQ0g9cG93ZXJwYwo+IAo+IC4uLgo+IAo+IC9ob21lL3NoYXJlL3NyYy9j
cm9zc3Rvb2wvZ2NjLTkuNC4wLW5vbGliYy9wb3dlcnBjNjQtbGludXgvYmluL3Bvd2VycGM2NC1s
aW51eC1nY2MgLVdwLC1NRCxhcmNoL3Bvd2VycGMvYm9vdC8uY3J0MC5vLmQgLURfX0FTU0VNQkxZ
X18gLVdhbGwgLVd1bmRlZiAtV3N0cmljdC1wcm90b3R5cGVzIC1Xbm8tdHJpZ3JhcGhzIC1mbm8t
c3RyaWN0LWFsaWFzaW5nIC1PMiAtbXNvZnQtZmxvYXQgLW1uby1hbHRpdmVjIC1tbm8tdnN4IC1w
aXBlIC1mb21pdC1mcmFtZS1wb2ludGVyIC1mbm8tYnVpbHRpbiAtZlBJQyAtbm9zdGRpbmMgLWlu
Y2x1ZGUgLi9pbmNsdWRlL2xpbnV4L2NvbXBpbGVyX2F0dHJpYnV0ZXMuaCAtSS4vYXJjaC9wb3dl
cnBjL2luY2x1ZGUgLUkuL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2dlbmVyYXRlZCAgLUkuL2luY2x1
ZGUgLUkuL2FyY2gvcG93ZXJwYy9pbmNsdWRlL3VhcGkgLUkuL2FyY2gvcG93ZXJwYy9pbmNsdWRl
L2dlbmVyYXRlZC91YXBpIC1JLi9pbmNsdWRlL3VhcGkgLUkuL2luY2x1ZGUvZ2VuZXJhdGVkL3Vh
cGkgLWluY2x1ZGUgLi9pbmNsdWRlL2xpbnV4L2NvbXBpbGVyLXZlcnNpb24uaCAtaW5jbHVkZSAu
L2luY2x1ZGUvbGludXgva2NvbmZpZy5oIC1tMzIgLWlzeXN0ZW0gL2hvbWUvc2hhcmUvc3JjL2Ny
b3NzdG9vbC9nY2MtOS40LjAtbm9saWJjL3Bvd2VycGM2NC1saW51eC9iaW4vLi4vbGliL2djYy9w
b3dlcnBjNjQtbGludXgvOS40LjAvaW5jbHVkZSAtbWJpZy1lbmRpYW4gLW5vc3RkaW5jIC1jIC1v
IGFyY2gvcG93ZXJwYy9ib290L2NydDAubyBhcmNoL3Bvd2VycGMvYm9vdC9jcnQwLlMKPiBJbiBm
aWxlIGluY2x1ZGVkIGZyb20gPGNvbW1hbmQtbGluZT46Cj4gLi8uL2luY2x1ZGUvbGludXgvY29t
cGlsZXJfYXR0cmlidXRlcy5oOjYyOjU6IHdhcm5pbmc6ICJfX2hhc19hdHRyaWJ1dGUiIGlzIG5v
dCBkZWZpbmVkLCBldmFsdWF0ZXMgdG8gMCBbLVd1bmRlZl0KPiAgICAgNjIgfCAjaWYgX19oYXNf
YXR0cmlidXRlKF9fYXNzdW1lX2FsaWduZWRfXykKPiAgICAgICAgfCAgICAgXn5+fn5+fn5+fn5+
fn5+Cj4gLi8uL2luY2x1ZGUvbGludXgvY29tcGlsZXJfYXR0cmlidXRlcy5oOjYyOjIwOiBlcnJv
cjogbWlzc2luZyBiaW5hcnkgb3BlcmF0b3IgYmVmb3JlIHRva2VuICIoIgo+ICAgICA2MiB8ICNp
ZiBfX2hhc19hdHRyaWJ1dGUoX19hc3N1bWVfYWxpZ25lZF9fKQo+ICAgICAgICB8ICAgICAgICAg
ICAgICAgICAgICBeCj4gLi8uL2luY2x1ZGUvbGludXgvY29tcGlsZXJfYXR0cmlidXRlcy5oOjg4
OjU6IHdhcm5pbmc6ICJfX2hhc19hdHRyaWJ1dGUiIGlzIG5vdCBkZWZpbmVkLCBldmFsdWF0ZXMg
dG8gMCBbLVd1bmRlZl0KPiAgICAgODggfCAjaWYgX19oYXNfYXR0cmlidXRlKF9fY29weV9fKQo+
ICAgICAgICB8ICAgICBefn5+fn5+fn5+fn5+fn4KPiAuLi4KPiAKPiBLbm93biBpc3N1ZT8KPiAK
PiBUaGlzIF9faGFzX2F0dHJpYnV0ZSgpIHRoaW5nIGlzIHN1cHBvc2VkIHRvIGJlIHN1cHBvcnRl
ZAo+IGluIGdjYyBzaW5jZSA1LjEgYW5kIEknbSB1c2luZyB0aGUgY3Jvc3N0b29sIHN0dWZmIGZy
b20KPiBodHRwczovL3d3dy5rZXJuZWwub3JnL3B1Yi90b29scy9jcm9zc3Rvb2wvIGFuZCBnY2Mt
OS40IGFib3ZlIGlzIHByZXR0eQo+IG5ldyBzbyB0aGF0IHNob3VsZCBub3QgaGFwcGVuIGFjdHVh
bGx5Lgo+IAo+IEJ1dCBpdCBkb2VzLi4uCj4gCj4gSG1tbS4KPiAKCgpZZXMsIHNlZSAKaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGludXhwcGMtZGV2LzIwMjEwOTE0MTIzOTE5LjU4MjAzZWVmQGNh
bmIuYXV1Zy5vcmcuYXUvVC8jdAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2lvbW11
