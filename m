Return-Path: <SRS0=900o=ON=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B6AC4332F
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 09:48:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9589B6121F
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 09:48:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9589B6121F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5189640155;
	Thu, 23 Sep 2021 09:48:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YJ7kFPgALWJu; Thu, 23 Sep 2021 09:47:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1B6B940151;
	Thu, 23 Sep 2021 09:47:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E02AEC0011;
	Thu, 23 Sep 2021 09:47:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99C2CC000D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 09:47:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 717FC40155
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 09:47:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yFEtugPJ09Q2 for <iommu@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 09:47:56 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 09A4440151
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 09:47:55 +0000 (UTC)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4HFVhS1HTcz9sTZ;
 Thu, 23 Sep 2021 11:47:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N2iojAvTUjrW; Thu, 23 Sep 2021 11:47:52 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4HFVhS0G8Vz9sTX;
 Thu, 23 Sep 2021 11:47:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E65698B775;
 Thu, 23 Sep 2021 11:47:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id HEg50hnqH7U5; Thu, 23 Sep 2021 11:47:51 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.200])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 224928B763;
 Thu, 23 Sep 2021 11:47:50 +0200 (CEST)
Subject: Re: [PATCH 3/3] memblock: cleanup memblock_free interface
To: Mike Rapoport <rppt@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <20210923074335.12583-1-rppt@kernel.org>
 <20210923074335.12583-4-rppt@kernel.org>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <1101e3c7-fcb7-a632-8e22-47f4a01ea02e@csgroup.eu>
Date: Thu, 23 Sep 2021 11:47:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210923074335.12583-4-rppt@kernel.org>
Content-Language: fr-FR
Cc: devicetree@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, Mike Rapoport <rppt@linux.ibm.com>,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
 xen-devel@lists.xenproject.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org
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

CgpMZSAyMy8wOS8yMDIxIMOgIDA5OjQzLCBNaWtlIFJhcG9wb3J0IGEgw6ljcml0wqA6Cj4gRnJv
bTogTWlrZSBSYXBvcG9ydCA8cnBwdEBsaW51eC5pYm0uY29tPgo+IAo+IEZvciBhZ2VzIG1lbWJs
b2NrX2ZyZWUoKSBpbnRlcmZhY2UgZGVhbHQgd2l0aCBwaHlzaWNhbCBhZGRyZXNzZXMgZXZlbgo+
IGRlc3BpdGUgdGhlIGV4aXN0ZW5jZSBvZiBtZW1ibG9ja19hbGxvY194eCgpIGZ1bmN0aW9ucyB0
aGF0IHJldHVybiBhCj4gdmlydHVhbCBwb2ludGVyLgo+IAo+IEludHJvZHVjZSBtZW1ibG9ja19w
aHlzX2ZyZWUoKSBmb3IgZnJlZWluZyBwaHlzaWNhbCByYW5nZXMgYW5kIHJlcHVycG9zZQo+IG1l
bWJsb2NrX2ZyZWUoKSB0byBmcmVlIHZpcnR1YWwgcG9pbnRlcnMgdG8gbWFrZSB0aGUgZm9sbG93
aW5nIHBhaXJpbmcKPiBhYnVuZGFudGx5IGNsZWFyOgo+IAo+IAlpbnQgbWVtYmxvY2tfcGh5c19m
cmVlKHBoeXNfYWRkcl90IGJhc2UsIHBoeXNfYWRkcl90IHNpemUpOwo+IAlwaHlzX2FkZHJfdCBt
ZW1ibG9ja19waHlzX2FsbG9jKHBoeXNfYWRkcl90IGJhc2UsIHBoeXNfYWRkcl90IHNpemUpOwo+
IAo+IAl2b2lkICptZW1ibG9ja19hbGxvYyhwaHlzX2FkZHJfdCBzaXplLCBwaHlzX2FkZHJfdCBh
bGlnbik7Cj4gCXZvaWQgbWVtYmxvY2tfZnJlZSh2b2lkICpwdHIsIHNpemVfdCBzaXplKTsKPiAK
PiBSZXBsYWNlIGludGVybWVkaWF0ZSBtZW1ibG9ja19mcmVlX3B0cigpIHdpdGggbWVtYmxvY2tf
ZnJlZSgpIGFuZCBkcm9wCj4gdW5uZWNlc3NhcnkgYWxpYXNlcyBtZW1ibG9ja19mcmVlX2Vhcmx5
KCkgYW5kIG1lbWJsb2NrX2ZyZWVfZWFybHlfbmlkKCkuCj4gCj4gU3VnZ2VzdGVkLWJ5OiBMaW51
cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+Cj4gU2lnbmVkLW9mZi1i
eTogTWlrZSBSYXBvcG9ydCA8cnBwdEBsaW51eC5pYm0uY29tPgo+IC0tLQoKPiBkaWZmIC0tZ2l0
IGEvYXJjaC9zMzkwL2tlcm5lbC9zbXAuYyBiL2FyY2gvczM5MC9rZXJuZWwvc21wLmMKPiBpbmRl
eCAxYTA0ZTViZGY2NTUuLjM3ODI2ZDhjNGY3NCAxMDA2NDQKPiAtLS0gYS9hcmNoL3MzOTAva2Vy
bmVsL3NtcC5jCj4gKysrIGIvYXJjaC9zMzkwL2tlcm5lbC9zbXAuYwo+IEBAIC03MjMsNyArNzIz
LDcgQEAgdm9pZCBfX2luaXQgc21wX3NhdmVfZHVtcF9jcHVzKHZvaWQpCj4gICAJCQkvKiBHZXQg
dGhlIENQVSByZWdpc3RlcnMgKi8KPiAgIAkJCXNtcF9zYXZlX2NwdV9yZWdzKHNhLCBhZGRyLCBp
c19ib290X2NwdSwgcGFnZSk7Cj4gICAJfQo+IC0JbWVtYmxvY2tfZnJlZShwYWdlLCBQQUdFX1NJ
WkUpOwo+ICsJbWVtYmxvY2tfcGh5c19mcmVlKHBhZ2UsIFBBR0VfU0laRSk7Cj4gICAJZGlhZ19h
bW9kZTMxX29wcy5kaWFnMzA4X3Jlc2V0KCk7Cj4gICAJcGNwdV9zZXRfc210KDApOwo+ICAgfQo+
IEBAIC04ODAsNyArODgwLDcgQEAgdm9pZCBfX2luaXQgc21wX2RldGVjdF9jcHVzKHZvaWQpCj4g
ICAKPiAgIAkvKiBBZGQgQ1BVcyBwcmVzZW50IGF0IGJvb3QgKi8KPiAgIAlfX3NtcF9yZXNjYW5f
Y3B1cyhpbmZvLCB0cnVlKTsKPiAtCW1lbWJsb2NrX2ZyZWVfZWFybHkoKHVuc2lnbmVkIGxvbmcp
aW5mbywgc2l6ZW9mKCppbmZvKSk7Cj4gKwltZW1ibG9ja19mcmVlKGluZm8sIHNpemVvZigqaW5m
bykpOwo+ICAgfQo+ICAgCj4gICAvKgoKSSdtIGEgYml0IGxvc3QuIElJVUMgbWVtYmxvY2tfZnJl
ZV9lYXJseSgpIGFuZCBtZW1ibG9ja19mcmVlKCkgd2hlcmUgCmlkZW50aWNhbC4KCkluIHRoZSBm
aXJzdCBodW5rIG1lbWJsb2NrX2ZyZWUoKSBnZXRzIHJlcGxhY2VkIGJ5IG1lbWJsb2NrX3BoeXNf
ZnJlZSgpCkluIHRoZSBzZWNvbmQgaHVuayBtZW1ibG9ja19mcmVlX2Vhcmx5KCkgZ2V0cyByZXBs
YWNlZCBieSBtZW1ibG9ja19mcmVlKCkKCkkgdGhpbmsgaXQgd291bGQgYmUgZWFzaWVyIHRvIGZv
bGxvdyBpZiB5b3UgY291bGQgc3BsaXQgaXQgaW4gc2V2ZXJhbCAKcGF0Y2hlczoKLSBGaXJzdCBw
YXRjaDogQ3JlYXRlIG1lbWJsb2NrX3BoeXNfZnJlZSgpIGFuZCBjaGFuZ2UgYWxsIHJlbGV2YW50
IAptZW1ibG9ja19mcmVlKCkgdG8gbWVtYmxvY2tfcGh5c19mcmVlKCkgLSBPciBjaGFuZ2UgbWVt
YmxvY2tfZnJlZSgpIHRvIAptZW1ibG9ja19waHlzX2ZyZWUoKSBhbmQgbWFrZSBtZW1ibG9ja19m
cmVlKCkgYW4gYWxpYXMgb2YgaXQuCi0gU2Vjb25kIHBhdGNoOiBNYWtlIG1lbWJsb2NrX2ZyZWVf
cHRyKCkgYmVjb21lIG1lbWJsb2NrX2ZyZWUoKSBhbmQgCmNoYW5nZSBhbGwgcmVtYWluaW5nIGNh
bGxlcnMgdG8gdGhlIG5ldyBzZW1hbnRpY3MgKElJVUMgCm1lbWJsb2NrX2ZyZWUoX19wYShwdHIp
KSBiZWNvbWVzIG1lbWJsb2NrX2ZyZWUocHRyKSBhbmQgbWFrZSAKbWVtYmxvY2tfZnJlZV9wdHIo
KSBhbiBhbGlhcyBvZiBtZW1ibG9ja19mcmVlKCkKLSBGb3VydGggcGF0Y2g6IFJlcGxhY2UgYW5k
IGRyb3AgbWVtYmxvY2tfZnJlZV9wdHIoKQotIEZpZnRoIHBhdGNoOiBEcm9wIG1lbWJsb2NrX2Zy
ZWVfZWFybHkoKSBhbmQgbWVtYmxvY2tfZnJlZV9lYXJseV9uaWQoKSAKKEFsbCB1c2VycyBzaG91
bGQgaGF2ZSBiZWVuIHVwZ3JhZGVkIHRvIG1lbWJsb2NrX2ZyZWVfcGh5cygpIGluIHBhdGNoIDEg
Cm9yIG1lbWJsb2NrX2ZyZWUoKSBpbiBwYXRjaCAyKQoKQ2hyaXN0b3BoZQpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9t
bXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
