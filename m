Return-Path: <SRS0=vxCL=4F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776D7C34021
	for <iommu@archiver.kernel.org>; Mon, 17 Feb 2020 14:58:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CFD120679
	for <iommu@archiver.kernel.org>; Mon, 17 Feb 2020 14:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IInTlhnk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CFD120679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EBF8584995;
	Mon, 17 Feb 2020 14:58:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rZRQHj_CddBp; Mon, 17 Feb 2020 14:58:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3CAA3845A3;
	Mon, 17 Feb 2020 14:58:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24305C08A0;
	Mon, 17 Feb 2020 14:58:24 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA3D2C013E
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 14:58:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D33A184525
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 14:58:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AliIGxEyCJ8m for <iommu@lists.linux-foundation.org>;
 Mon, 17 Feb 2020 14:58:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 261BE844F1
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 14:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581951500;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q5XH3q1zVi4vo6tPwZ0LjNWFZagX0MCQTTViEYgCMBo=;
 b=IInTlhnk0vtI0jlAtXjTzJxXUaRoJJblwbcNlXyV+K0SUNj5EXQd52gTvrxJbmLgaiRvHp
 GzO9xZK/6+lJ1hkFo8AiEwO2dQ3TDbnejP0Oef4aGGlTIDvagDHDV0JwMtKINFY0F0HACw
 fnLSs6zzyTnKdj734i3ZH9QCyyq6UmQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-DQw2Z49WOXmRdfmy2B8h2A-1; Mon, 17 Feb 2020 09:58:15 -0500
Received: by mail-qt1-f198.google.com with SMTP id l1so11040760qtp.21
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 06:58:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to;
 bh=q5XH3q1zVi4vo6tPwZ0LjNWFZagX0MCQTTViEYgCMBo=;
 b=iQUfxUzgnRtCN6CJNfTAxb6VGn0aTJGAy36tBQsyhqajnARbWC+t7IcBW8rYR/YGoe
 79BEgJPgANTZfEbC4AaAfkhyOYtkC1tpX9syUVXBW3VaYSYtSaH/Arl3IQUdgzraoH57
 dgjfIEf509bKDBxx1F8EpaOOOizUFCE0uOUhjea0TNFyF1XlAVz8UZ4aq92fZi6QxGOt
 WWOE02rBbzWBwzFtKJ5VF/xwIoOwrpTbX0L71Bw1kx4uhx9zmXvjUa4JNc8TajlIFTKH
 r2D3gxw5DaUguWyS82kklfHVq6Jyxie6ondxV9yXt4gP+EJ3Q28S1AlFiE15wsNuAzNE
 W9ww==
X-Gm-Message-State: APjAAAWl8SAcFL0JAEbrwQIY2MOj+t1N4i6Dyppzch2IW5GSWkfFpysD
 fh5mtEC9CqUomJA/Sz/htL0ma8O2TfBH4qYg1yJca9IGgHUqv/h/NwjGIUOiIrmhRv2mdckN3fX
 Z89BLQ+LSJ279ss1KYgGHx0RQMgX4jw==
X-Received: by 2002:ac8:1415:: with SMTP id k21mr13713271qtj.300.1581951494849; 
 Mon, 17 Feb 2020 06:58:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqzWDXIhH9avVqr5m+pMflTbY1gwvERaA1WmIZi+X5spg7/ghQ6hRwSGV7aMzaGZ5QszHqhwrQ==
X-Received: by 2002:ac8:1415:: with SMTP id k21mr13713243qtj.300.1581951494510; 
 Mon, 17 Feb 2020 06:58:14 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id q25sm335317qkc.60.2020.02.17.06.58.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2020 06:58:13 -0800 (PST)
Date: Mon, 17 Feb 2020 07:58:12 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: arm-smmu.1.auto: Unhandled context fault starting with 5.4-rc1
Message-ID: <20200217145812.w77idhj3u6jgaeam@cantor>
References: <20200214201353.qlbqcvpztcx55qud@cantor>
 <7c9a234e-78b1-2385-84b8-50744b9c4066@arm.com>
 <20200216221110.zie3o5opbvarir3h@cantor>
 <efb6da9c-51a3-c35c-1bbf-ae6808006beb@arm.com>
MIME-Version: 1.0
In-Reply-To: <efb6da9c-51a3-c35c-1bbf-ae6808006beb@arm.com>
X-MC-Unique: DQw2Z49WOXmRdfmy2B8h2A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>
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
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gTW9uIEZlYiAxNyAyMCwgUm9iaW4gTXVycGh5IHdyb3RlOgo+T24gMTYvMDIvMjAyMCAxMDox
MSBwbSwgSmVycnkgU25pdHNlbGFhciB3cm90ZToKPj5PbiBGcmkgRmViIDE0IDIwLCBSb2JpbiBN
dXJwaHkgd3JvdGU6Cj4+PkhpIEplcnJ5LAo+Pj4KPj4+T24gMjAyMC0wMi0xNCA4OjEzIHBtLCBK
ZXJyeSBTbml0c2VsYWFyIHdyb3RlOgo+Pj4+SGkgV2lsbCwKPj4+Pgo+Pj4+T24gYSBnaWdhYnl0
ZSBzeXN0ZW0gd2l0aCBDYXZpdW0gQ044eHgsIHdoZW4gZG9pbmcgYSBmaW8gdGVzdCBhZ2FpbnN0
Cj4+Pj5hbiBudm1lIGRyaXZlIHdlIGFyZSBzZWVpbmcgdGhlIGZvbGxvd2luZzoKPj4+Pgo+Pj4+
W8KgIDYzNy4xNjExOTRdIGFybS1zbW11IGFybS1zbW11LjEuYXV0bzogVW5oYW5kbGVkIGNvbnRl
eHQgCj4+Pj5mYXVsdDogZnNyPTB4ODAwMDA0MDIsIGlvdmE9MHg4MDEwMDAzZjYwMDAsIGZzeW5y
PTB4NzAwOTEsIAo+Pj4+Y2JmcnN5bnJhPTB4OTAwMCwgY2I9Nwo+Pj4+W8KgIDYzNy4xNzQzMjld
IGFybS1zbW11IGFybS1zbW11LjEuYXV0bzogVW5oYW5kbGVkIGNvbnRleHQgCj4+Pj5mYXVsdDog
ZnNyPTB4ODAwMDA0MDIsIGlvdmE9MHg4MDEwMDAwMzYwMDAsIGZzeW5yPTB4NzAwOTEsIAo+Pj4+
Y2JmcnN5bnJhPTB4OTAwMCwgY2I9Nwo+Pj4+W8KgIDYzNy4xODY4ODddIGFybS1zbW11IGFybS1z
bW11LjEuYXV0bzogVW5oYW5kbGVkIGNvbnRleHQgCj4+Pj5mYXVsdDogZnNyPTB4ODAwMDA0MDIs
IGlvdmE9MHg4MDEwMDAyZWUwMDAsIGZzeW5yPTB4NzAwOTEsIAo+Pj4+Y2JmcnN5bnJhPTB4OTAw
MCwgY2I9Nwo+Pj4+W8KgIDYzNy4xOTkyNzVdIGFybS1zbW11IGFybS1zbW11LjEuYXV0bzogVW5o
YW5kbGVkIGNvbnRleHQgCj4+Pj5mYXVsdDogZnNyPTB4ODAwMDA0MDIsIGlvdmE9MHg4MDEwMDAz
YzcwMDAsIGZzeW5yPTB4NzAwOTEsIAo+Pj4+Y2JmcnN5bnJhPTB4OTAwMCwgY2I9Nwo+Pj4+W8Kg
IDYzNy4yMTE4ODVdIGFybS1zbW11IGFybS1zbW11LjEuYXV0bzogVW5oYW5kbGVkIGNvbnRleHQg
Cj4+Pj5mYXVsdDogZnNyPTB4ODAwMDA0MDIsIGlvdmE9MHg4MDEwMDAzOTIwMDAsIGZzeW5yPTB4
NzAwOTEsIAo+Pj4+Y2JmcnN5bnJhPTB4OTAwMCwgY2I9Nwo+Pj4+W8KgIDYzNy4yMjQ1ODBdIGFy
bS1zbW11IGFybS1zbW11LjEuYXV0bzogVW5oYW5kbGVkIGNvbnRleHQgCj4+Pj5mYXVsdDogZnNy
PTB4ODAwMDA0MDIsIGlvdmE9MHg4MDEwMDAwMTgwMDAsIGZzeW5yPTB4NzAwOTEsIAo+Pj4+Y2Jm
cnN5bnJhPTB4OTAwMCwgY2I9Nwo+Pj4+W8KgIDYzNy4yMzcyNDFdIGFybS1zbW11IGFybS1zbW11
LjEuYXV0bzogVW5oYW5kbGVkIGNvbnRleHQgCj4+Pj5mYXVsdDogZnNyPTB4ODAwMDA0MDIsIGlv
dmE9MHg4MDEwMDAzNjAwMDAsIGZzeW5yPTB4NzAwOTEsIAo+Pj4+Y2JmcnN5bnJhPTB4OTAwMCwg
Y2I9Nwo+Pj4+W8KgIDYzNy4yNDk2NTddIGFybS1zbW11IGFybS1zbW11LjEuYXV0bzogVW5oYW5k
bGVkIGNvbnRleHQgCj4+Pj5mYXVsdDogZnNyPTB4ODAwMDA0MDIsIGlvdmE9MHg4MDEwMDAwYmEw
MDAsIGZzeW5yPTB4NzAwOTEsIAo+Pj4+Y2JmcnN5bnJhPTB4OTAwMCwgY2I9Nwo+Pj4+W8KgIDYz
Ny4yNjIxMjBdIGFybS1zbW11IGFybS1zbW11LjEuYXV0bzogVW5oYW5kbGVkIGNvbnRleHQgCj4+
Pj5mYXVsdDogZnNyPTB4ODAwMDA0MDIsIGlvdmE9MHg4MDEwMDAwM2UwMDAsIGZzeW5yPTB4NzAw
OTEsIAo+Pj4+Y2JmcnN5bnJhPTB4OTAwMCwgY2I9Nwo+Pj4+W8KgIDYzNy4yNzQ0NjhdIGFybS1z
bW11IGFybS1zbW11LjEuYXV0bzogVW5oYW5kbGVkIGNvbnRleHQgCj4+Pj5mYXVsdDogZnNyPTB4
ODAwMDA0MDIsIGlvdmE9MHg4MDEwMDAzMDQwMDAsIGZzeW5yPTB4NzAwOTEsIAo+Pj4+Y2JmcnN5
bnJhPTB4OTAwMCwgY2I9Nwo+Pj4KPj4+VGhvc2UgIklPVkFzIiBkb24ndCBsb29rIG11Y2ggbGlr
ZSBJT1ZBcyBmcm9tIHRoZSBETUEgYWxsb2NhdG9yIC0gCj4+PmlmIHRoZXkgd2VyZSBwaHlzaWNh
bCBhZGRyZXNzZXMsIHdvdWxkIHRoZXkgY29ycmVzcG9uZCB0byBhbiAKPj4+ZXhwZWN0ZWQgcmVn
aW9uIG9mIHRoZSBwaHlzaWNhbCBtZW1vcnkgbWFwPwo+Pj4KPj4+SSB3b3VsZCBzdXNwZWN0IHRo
YXQgdGhpcyBpcyBtb3N0IGxpa2VseSBtaXNiZWhhdmlvdXIgaW4gdGhlIE5WTWUgCj4+PmRyaXZl
ciAoaXNzdWluZyBhIHdyaXRlIHRvIGEgbm9uLURNQS1tYXBwZWQgYWRkcmVzcyksIGFuZCB0aGUg
U01NVSAKPj4+aXMganVzdCBkb2luZyBpdHMgam9iIGluIGJsb2NraW5nIGFuZCByZXBvcnRpbmcg
aXQuCj4+Pgo+Pj4+SSBhbHNvIHJlcHJvZHVjZWQgd2l0aCA1LjUtcmM3LCBhbmQgd2lsbCBjaGVj
ayA1LjYtcmMxIGxhdGVyIAo+Pj4+dG9kYXkuIEkgY291bGRuJ3QgbmFycm93IGl0IGRvd24gZnVy
dGhlciBpbnRvIDUuNC1yYzEuCj4+Pj5JIGRvbid0IGtub3cgc21tdSBvciB0aGUgY29kZSB3ZWxs
LCBhbnkgdGhvdWdodHMgb24gd2hlcmUgdG8gCj4+Pj5zdGFydCBkaWdnaW5nIGludG8gdGhpcz8K
Pj4+Pgo+Pj4+ZmlvIHRlc3QgdGhhdCBpcyBiZWluZyBydW4gaXM6Cj4+Pj4KPj4+PiNmaW8gLWZp
bGVuYW1lPS9kZXYvbnZtZTBuMSAtaW9kZXB0aD02NCAtdGhyZWFkIC1ydz1yYW5kd3JpdGUgCj4+
Pj4taW9lbmdpbmU9bGliYWlvIC1icz00ayAtcnVudGltZT00MzIwMCAtc2l6ZT0tZ3JvdXBfcmVw
b3J0aW5nIAo+Pj4+LW5hbWU9bXl0ZXN0IC1udW1qb2JzPTMyCj4+Pgo+Pj5KdXN0IHRvIGNsYXJp
ZnksIGRvIG90aGVyIHRlc3RzIHdvcmsgT0sgb24gdGhlIHNhbWUgZGV2aWNlPwo+Pj4KPj4+VGhh
bmtzLAo+Pj5Sb2Jpbi4KPj4+Cj4+Cj4+SSB3YXMgYWJsZSB0byBnZXQgYmFjayBvbiB0aGUgc3lz
dGVtIHRvZGF5LiBJIHRoaW5rIEkga25vdyB3aGF0IHRoZSAKPj5wcm9ibGVtIGlzOgo+Pgo+PlvC
oMKgwqAgMC4wMzYxODldIGlvbW11OiBHaWdhYnl0ZSBSMTIwLVQzNC0wMCBkZXRlY3RlZCwgZm9y
Y2UgaW9tbXUgCj4+cGFzc3Rocm91Z2ggbW9kZQo+PlvCoMKgwqAgNi4zMjQyODJdIGlvbW11OiBE
ZWZhdWx0IGRvbWFpbiB0eXBlOiBUcmFuc2xhdGVkCj4+Cj4+U28gdGhlIG5ldyBkZWZhdWx0IGRv
bWFpbiBjb2RlIGluIDUuNCBvdmVycmlkZXMgdGhlIGlvbW11IHF1aXJrIGNvZGUgCj4+c2V0dGlu
ZyBkZWZhdWx0Cj4+cGFzc3Rocm91Z2guIFRlc3RpbmcgYSBxdWljayBwYXRjaCB0aGF0IHRyYWNr
cyB3aGV0aGVyIHRoZSBkZWZhdWx0IAo+PmRvbWFpbiB3YXMgc2V0Cj4+aW4gdGhlIHF1aXJrIGNv
ZGUsIGFuZCBsZWF2ZXMgaXQgYWxvbmUgaWYgaXQgd2FzLiBTbyBmYXIgaXQgc2VlbXMgdG8gCj4+
YmUgd29ya2luZy4KPgo+QWgsIE9LLiBDb3VsZCB5b3UgcG9pbnQgbWUgYXQgdGhhdCBxdWlyayBj
b2RlPyBJIGNhbid0IHNlZW0gdG8gdHJhY2sgCj5pdCBkb3duIGluIG1haW5saW5lLCBhbmQgc2Vl
aW5nIHRoaXMgbXVjaCBsZWF2ZXMgbWUgZHViaW91cyB0aGF0IGl0J3MgCj5ldmVuIGNvcnJlY3Qg
LSBtYXRjaGluZyBhIHBhcnRpY3VsYXIgYm9hcmQgaW1wbGllcyB0aGF0IGl0J3MgYSAKPmZpcm13
YXJlIGlzc3VlIChhcyBmYXIgYXMgSSdtIGF3YXJlIHRoZSBTTU1VcyBpbiBDTjg4eHggU29DcyBh
cmUgCj51c2FibGUgaW4gZ2VuZXJhbCksIGJ1dCBpZiB0aGUgZmlybXdhcmUgZGVzY3JpcHRpb24g
aXMgd3JvbmcgdG8gdGhlIAo+cG9pbnQgdGhhdCBETUEgb3BzIHRyYW5zbGF0aW9uIGRvZXNuJ3Qg
d29yaywgdGhlbiBubyBvdGhlciB0cmFuc2xhdGlvbiAKPihlLmcuIFZGSU8pIGlzIGxpa2VseSB0
byB3b3JrIGVpdGhlci4gSW4gdGhhdCBjYXNlIGl0J3Mgc2ltcGx5IG5vdCAKPnNhZmUgdG8gZW5h
YmxlIHRoZSBTTU1VIGF0IGFsbCwgYW5kIGZ1ZGdpbmcgdGhlIGRlZmF1bHQgZG9tYWluIHR5cGUg
Cj5tZXJlbHkgaGlkZXMgb25lIHN5bXB0b20gb2YgdGhlIHByb2JsZW0uCj4KPlJvYmluLgo+CgpV
Z2guIEl0IGlzIGEgUkhFTCBvbmx5IHBhdGNoLCBidXQgZm9yIHNvbWUgcmVhc29uIGl0IGlzIGFw
cGxpZWQgdG8gdGhlCmFyayBrZXJuZWwgYnVpbGRzIGFzIHdlbGwuIFNvcnJ5IGZvciB0aGUgbm9p
c2UuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21t
dSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
