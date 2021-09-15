Return-Path: <SRS0=KP5g=OF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246E2C433EF
	for <iommu@archiver.kernel.org>; Wed, 15 Sep 2021 13:38:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD6A361250
	for <iommu@archiver.kernel.org>; Wed, 15 Sep 2021 13:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CD6A361250
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9671340630;
	Wed, 15 Sep 2021 13:38:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kJ7LryzaODgG; Wed, 15 Sep 2021 13:38:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 518A94063B;
	Wed, 15 Sep 2021 13:38:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B9CCC000F;
	Wed, 15 Sep 2021 13:38:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4ECE8C000D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Sep 2021 13:38:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3D2F2827F3
 for <iommu@lists.linux-foundation.org>; Wed, 15 Sep 2021 13:38:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K7GS_VsU6FMH for <iommu@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 13:38:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E07A882778
 for <iommu@lists.linux-foundation.org>; Wed, 15 Sep 2021 13:38:03 +0000 (UTC)
Received: by mail-lf1-x136.google.com with SMTP id c8so6203840lfi.3
 for <iommu@lists.linux-foundation.org>; Wed, 15 Sep 2021 06:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=90+qKy1YudQ2sg99JcqAjO4XWW79ok13oTy+0jzPIvI=;
 b=pWJY3kidUzGHksDFRIpgQnf4vUWN1vgPE+o3cbP4wXlnippo7ZiDFotxHaC8MSXaBM
 vNBrYetAgN2CPPdEzmkQctsPVj8A3iaBtpri3qDtPhHZimSdqoxIXBwHRJRDZ9vLa9+l
 6IOMYqcz7bpn5ONSY+QYxShXmQzDkPGD/T6/5/G7BXQucNCmtwZedFKEyok2o+3RtKMT
 VYwk4lsdzuny2NPeElvxKJrkxvufY7mcR/p4HOMPjET8Cod2htJk0E0BgXmrdajk70T7
 2Y4F/c8Epyv0cRuYA92V37bdauX1teip9YtlFtwxREkMZ3NCMvlGEQnEq7M+z4J3naFs
 roXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=90+qKy1YudQ2sg99JcqAjO4XWW79ok13oTy+0jzPIvI=;
 b=7rEMAVgwZW52n4ujBwWy4qCErsQxj7PcNFX9b7ahfi0OhZg1WqBqfUFwF/un0cJPzn
 xaE72iV/wA41h4NKv8DzpVgIzIZseEVIzoXiCJb98gbZppdGUNkMmHaTmWq4z4VMDeTE
 y/5l/jjfntCnM9aIk+fBEN7eCXaV650CWTz5AG5cKbzggp0YcfpDWvPiMnPy/NGy47wC
 j/dG2PSaZi8cuau00l5dcQAE311udN2DSnWN9LX2LPTqnHHyujaBGrrW3+F1fOYg4qG2
 aXUzlm5lCYyG/tmXfVRCxbsjB9Jf0jVGpZrZFib/ra2PRUjX6ntK8NOS41JJPlu5SBmN
 5+3w==
X-Gm-Message-State: AOAM533P3p68cZLyJ3rN1jre53Y4gnl5BSjvrwT9oP6V3SbkWYS/zfhg
 sNxSH706va95C/zTx8DZwDCwNsIMn1snyi3lhA0=
X-Google-Smtp-Source: ABdhPJzbP5i7b7U9v8l9tinl5uV6Cg0SkKCsv8bPOpIyik8V6mpJ9yfrA9+wOAMT6A3UvlVyAreBHNtPKbPaFKDmJo4=
X-Received: by 2002:a19:491a:: with SMTP id w26mr17767806lfa.588.1631713081917; 
 Wed, 15 Sep 2021 06:38:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210914151016.3174924-1-Roman_Skakun@epam.com>
 <7c04db79-7de1-93ff-0908-9bad60a287b9@suse.com>
In-Reply-To: <7c04db79-7de1-93ff-0908-9bad60a287b9@suse.com>
From: Roman Skakun <rm.skakun@gmail.com>
Date: Wed, 15 Sep 2021 16:37:50 +0300
Message-ID: <CADu_u-Ou08tMFm5xU871ae8ct+2YOuvn4rQ=83CMTbg2bx87Pg@mail.gmail.com>
Subject: Re: [PATCH] swiotlb: set IO TLB segment size via cmdline
To: Jan Beulich <jbeulich@suse.com>
Cc: Roman Skakun <rm.skakun@gmail.com>, linux-doc@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Will Deacon <will@kernel.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Michael Ellerman <mpe@ellerman.id.au>, Christoph Hellwig <hch@lst.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@kernel.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Muchun Song <songmuchun@bytedance.com>, Thomas Gleixner <tglx@linutronix.de>,
 Juergen Gross <jgross@suse.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Andrii Anisov <andrii_anisov@epam.com>, linuxppc-dev@lists.ozlabs.org,
 Randy Dunlap <rdunlap@infradead.org>, linux-mips@vger.kernel.org,
 iommu <iommu@lists.linux-foundation.org>, Roman Skakun <roman_skakun@epam.com>,
 Andrew Morton <akpm@linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>,
 Mike Rapoport <rppt@kernel.org>, "Maciej W. Rozycki" <macro@orcam.me.uk>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SGkgSmFuLAoKVGhhbmtzIGZvciB0aGUgYW5zd2VyLgoKPj4gRnJvbTogUm9tYW4gU2tha3VuIDxy
b21hbl9za2FrdW5AZXBhbS5jb20+Cj4+Cj4+IEl0IGlzIHBvc3NpYmxlIHdoZW4gZGVmYXVsdCBJ
TyBUTEIgc2l6ZSBpcyBub3QKPj4gZW5vdWdoIHRvIGZpdCBhIGxvbmcgYnVmZmVycyBhcyBkZXNj
cmliZWQgaGVyZSBbMV0uCj4+Cj4+IFRoaXMgcGF0Y2ggbWFrZXMgYSB3YXkgdG8gc2V0IHRoaXMg
cGFyYW1ldGVyCj4+IHVzaW5nIGNtZGxpbmUgaW5zdGVhZCBvZiByZWNvbXBpbGluZyBhIGtlcm5l
bC4KPj4KPj4gWzFdIGh0dHBzOi8vd3d3LnhpbGlueC5jb20vc3VwcG9ydC9hbnN3ZXJzLzcyNjk0
Lmh0bWwKPgo+ICBJJ20gbm90IGNvbnZpbmNlZCB0aGUgc3dpb3RsYiB1c2UgZGVzY3JpYmUgdGhl
cmUgZmFsbHMgdW5kZXIgImludGVuZGVkCj4gIHVzZSIgLSBtYXBwaW5nIGEgMTI4MHg3MjAgZnJh
bWVidWZmZXIgaW4gYSBzaW5nbGUgY2h1bms/CgpJIGhhZCB0aGUgc2FtZSBpc3N1ZSB3aGlsZSBt
YXBwaW5nIERNQSBjaHVjayB+NE1CIGZvciBnZW0gZmIgd2hlbgp1c2luZyB4ZW4gdmRpc3BsLgpJ
IGdvdCB0aGUgbmV4dCBsb2c6ClsgMTQyLjAzMDQyMV0gcmNhci1mY3AgZmVhMmYwMDAuZmNwOiBz
d2lvdGxiIGJ1ZmZlciBpcyBmdWxsIChzejoKMzY4NjQwMCBieXRlcyksIHRvdGFsIDMyNzY4IChz
bG90cyksIHVzZWQgMzIgKHNsb3RzKQoKSXQgaGFwcGVuZWQgd2hlbiBJIHRyaWVkIHRvIG1hcCBi
b3VuY2UgYnVmZmVyLCB3aGljaCBoYXMgYSBsYXJnZSBzaXplLgpUaGUgZGVmYXVsdCBzaXplIGlm
IDEyOChJT19UTEJfU0VHU0laRSkgKiAyMDQ4KElPX1RMQl9TSElGVCkgPSAyNjIxNDQKYnl0ZXMs
IGJ1dCB3ZSByZXF1ZXN0ZWQgMzY4NjQwMCBieXRlcy4KV2hlbiBJIGNoYW5nZSBJT19UTEJfU0VH
U0laRSB0byAyMDQ4LiAoMjA0OChJT19UTEJfU0VHU0laRSkgICoKMjA0OChJT19UTEJfU0hJRlQp
ID0gNDE5NDMwNGJ5dGVzKS4KSXQgbWFrZXMgcG9zc2libGUgdG8gcmV0cmlldmUgYSBib3VuY2Ug
YnVmZmVyIGZvciByZXF1ZXN0ZWQgc2l6ZS4KQWZ0ZXIgY2hhbmdpbmcgdGhpcyB2YWx1ZSwgdGhl
IHByb2JsZW0gaXMgZ29uZS4KCj4gIHRoZSBib3R0b20gb2YgdGhpcyBwYWdlIGlzIGFsc28gY29u
ZnVzaW5nLCBhcyBmb2xsb3dpbmcgIlRoZW4gd2UgY2FuCj4gIGNvbmZpcm0gdGhlIG1vZGlmaWVk
IHN3aW90bGIgc2l6ZSBpbiB0aGUgYm9vdCBsb2c6IiB0aGVyZSBpcyBhIGxvZwo+ICBmcmFnbWVu
dCBzaG93aW5nIHRoZSBzYW1lIG9yaWdpbmFsIHNpemUgb2YgNjRNYi4KCkkgc3VzcGVjdCwgdGhp
cyBpcyBhIG1pc3Rha2UgaW4gdGhlIGFydGljbGUuCkFjY29yZGluZyB0byBodHRwczovL2VsaXhp
ci5ib290bGluLmNvbS9saW51eC92NS4xNC40L3NvdXJjZS9rZXJuZWwvZG1hL3N3aW90bGIuYyNM
MjE0CmFuZApodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92NS4xNS1yYzEvc291cmNl
L2tlcm5lbC9kbWEvc3dpb3RsYi5jI0wxODIKVGhlIElPX1RMQl9TRUdTSVpFIGlzIG5vdCB1c2Vk
IHRvIGNhbGN1bGF0ZSB0b3RhbCBzaXplIG9mIHN3aW90bGIgYXJlYS4KVGhpcyBleHBsYWlucyB3
aHkgd2UgaGF2ZSB0aGUgc2FtZSB0b3RhbCBzaXplIGJlZm9yZSBhbmQgYWZ0ZXIgY2hhbmdpbmcg
b2YKVExCIHNlZ21lbnQgc2l6ZS4KCj4gIEluIG9yZGVyIHRvIGJlIHN1cmUgdG8gY2F0Y2ggYWxs
IHVzZXMgbGlrZSB0aGlzIG9uZSAoaW5jbHVkaW5nIG9uZXMKPiAgd2hpY2ggbWFrZSBpdCB1cHN0
cmVhbSBpbiBwYXJhbGxlbCB0byB5b3VycyksIEkgdGhpbmsgeW91IHdpbGwgd2FudAo+ICB0byBy
ZW5hbWUgdGhlIG9yaWdpbmFsIElPX1RMQl9TRUdTSVpFIHRvIGUuZy4gSU9fVExCX0RFRkFVTFRf
U0VHU0laRS4KCkkgZG9uJ3QgdW5kZXJzdGFuZCB5b3VyIHBvaW50LiBDYW4geW91IGNsYXJpZnkg
dGhpcz8KCj4+ICsgICAgIC8qIGdldCBtYXggSU8gVExCIHNlZ21lbnQgc2l6ZSAqLwo+PiArICAg
ICBpZiAoaXNkaWdpdCgqc3RyKSkgewo+PiArICAgICAgICAgICAgIHRtcCA9IHNpbXBsZV9zdHJ0
b3VsKHN0ciwgJnN0ciwgMCk7Cj4+ICsgICAgICAgICAgICAgaWYgKHRtcCkKPj4gKyAgICAgICAg
ICAgICAgICAgICAgIGlvX3RsYl9zZWdfc2l6ZSA9IEFMSUdOKHRtcCwgSU9fVExCX1NFR1NJWkUp
Owo+Cj4gRnJvbSBhbGwgSSBjYW4gdGVsbCBpb190bGJfc2VnX3NpemUgd2FudHMgdG8gYmUgYSBw
b3dlciBvZiAyLiBNZXJlbHkKPiBhbGlnbmluZyB0byBhIG11bHRpcGxlIG9mIElPX1RMQl9TRUdT
SVpFIGlzbid0IGdvaW5nIHRvIGJlIGVub3VnaC4KClllcywgcmlnaHQsIHRoYW5rcyEKCkNoZWVy
cywKUm9tYW4uCgrQstGCLCAxNCDRgdC10L3Rgi4gMjAyMSDQsy4g0LIgMTg6MjksIEphbiBCZXVs
aWNoIDxqYmV1bGljaEBzdXNlLmNvbT46Cj4KPiBPbiAxNC4wOS4yMDIxIDE3OjEwLCBSb21hbiBT
a2FrdW4gd3JvdGU6Cj4gPiBGcm9tOiBSb21hbiBTa2FrdW4gPHJvbWFuX3NrYWt1bkBlcGFtLmNv
bT4KPiA+Cj4gPiBJdCBpcyBwb3NzaWJsZSB3aGVuIGRlZmF1bHQgSU8gVExCIHNpemUgaXMgbm90
Cj4gPiBlbm91Z2ggdG8gZml0IGEgbG9uZyBidWZmZXJzIGFzIGRlc2NyaWJlZCBoZXJlIFsxXS4K
PiA+Cj4gPiBUaGlzIHBhdGNoIG1ha2VzIGEgd2F5IHRvIHNldCB0aGlzIHBhcmFtZXRlcgo+ID4g
dXNpbmcgY21kbGluZSBpbnN0ZWFkIG9mIHJlY29tcGlsaW5nIGEga2VybmVsLgo+ID4KPiA+IFsx
XSBodHRwczovL3d3dy54aWxpbnguY29tL3N1cHBvcnQvYW5zd2Vycy83MjY5NC5odG1sCj4KPiBJ
J20gbm90IGNvbnZpbmNlZCB0aGUgc3dpb3RsYiB1c2UgZGVzY3JpYmUgdGhlcmUgZmFsbHMgdW5k
ZXIgImludGVuZGVkCj4gdXNlIiAtIG1hcHBpbmcgYSAxMjgweDcyMCBmcmFtZWJ1ZmZlciBpbiBh
IHNpbmdsZSBjaHVuaz8gKEFzIGFuIGFzaWRlLAo+IHRoZSBib3R0b20gb2YgdGhpcyBwYWdlIGlz
IGFsc28gY29uZnVzaW5nLCBhcyBmb2xsb3dpbmcgIlRoZW4gd2UgY2FuCj4gY29uZmlybSB0aGUg
bW9kaWZpZWQgc3dpb3RsYiBzaXplIGluIHRoZSBib290IGxvZzoiIHRoZXJlIGlzIGEgbG9nCj4g
ZnJhZ21lbnQgc2hvd2luZyB0aGUgc2FtZSBvcmlnaW5hbCBzaXplIG9mIDY0TWIuCj4KPiA+IC0t
LSBhL2FyY2gvbWlwcy9jYXZpdW0tb2N0ZW9uL2RtYS1vY3Rlb24uYwo+ID4gKysrIGIvYXJjaC9t
aXBzL2Nhdml1bS1vY3Rlb24vZG1hLW9jdGVvbi5jCj4gPiBAQCAtMjM3LDcgKzIzNyw3IEBAIHZv
aWQgX19pbml0IHBsYXRfc3dpb3RsYl9zZXR1cCh2b2lkKQo+ID4gICAgICAgICAgICAgICBzd2lv
dGxic2l6ZSA9IDY0ICogKDE8PDIwKTsKPiA+ICAjZW5kaWYKPiA+ICAgICAgIHN3aW90bGJfbnNs
YWJzID0gc3dpb3RsYnNpemUgPj4gSU9fVExCX1NISUZUOwo+ID4gLSAgICAgc3dpb3RsYl9uc2xh
YnMgPSBBTElHTihzd2lvdGxiX25zbGFicywgSU9fVExCX1NFR1NJWkUpOwo+ID4gKyAgICAgc3dp
b3RsYl9uc2xhYnMgPSBBTElHTihzd2lvdGxiX25zbGFicywgc3dpb3RsYl9pb19zZWdfc2l6ZSgp
KTsKPgo+IEluIG9yZGVyIHRvIGJlIHN1cmUgdG8gY2F0Y2ggYWxsIHVzZXMgbGlrZSB0aGlzIG9u
ZSAoaW5jbHVkaW5nIG9uZXMKPiB3aGljaCBtYWtlIGl0IHVwc3RyZWFtIGluIHBhcmFsbGVsIHRv
IHlvdXJzKSwgSSB0aGluayB5b3Ugd2lsbCB3YW50Cj4gdG8gcmVuYW1lIHRoZSBvcmlnaW5hbCBJ
T19UTEJfU0VHU0laRSB0byBlLmcuIElPX1RMQl9ERUZBVUxUX1NFR1NJWkUuCj4KPiA+IEBAIC04
MSwxNSArODYsMzAgQEAgc3RhdGljIHVuc2lnbmVkIGludCBtYXhfc2VnbWVudDsKPiA+ICBzdGF0
aWMgdW5zaWduZWQgbG9uZyBkZWZhdWx0X25zbGFicyA9IElPX1RMQl9ERUZBVUxUX1NJWkUgPj4g
SU9fVExCX1NISUZUOwo+ID4KPiA+ICBzdGF0aWMgaW50IF9faW5pdAo+ID4gLXNldHVwX2lvX3Rs
Yl9ucGFnZXMoY2hhciAqc3RyKQo+ID4gK3NldHVwX2lvX3RsYl9wYXJhbXMoY2hhciAqc3RyKQo+
ID4gIHsKPiA+ICsgICAgIHVuc2lnbmVkIGxvbmcgdG1wOwo+ID4gKwo+ID4gICAgICAgaWYgKGlz
ZGlnaXQoKnN0cikpIHsKPiA+IC0gICAgICAgICAgICAgLyogYXZvaWQgdGFpbCBzZWdtZW50IG9m
IHNpemUgPCBJT19UTEJfU0VHU0laRSAqLwo+ID4gLSAgICAgICAgICAgICBkZWZhdWx0X25zbGFi
cyA9Cj4gPiAtICAgICAgICAgICAgICAgICAgICAgQUxJR04oc2ltcGxlX3N0cnRvdWwoc3RyLCAm
c3RyLCAwKSwgSU9fVExCX1NFR1NJWkUpOwo+ID4gKyAgICAgICAgICAgICBkZWZhdWx0X25zbGFi
cyA9IHNpbXBsZV9zdHJ0b3VsKHN0ciwgJnN0ciwgMCk7Cj4gPiAgICAgICB9Cj4gPiAgICAgICBp
ZiAoKnN0ciA9PSAnLCcpCj4gPiAgICAgICAgICAgICAgICsrc3RyOwo+ID4gKwo+ID4gKyAgICAg
LyogZ2V0IG1heCBJTyBUTEIgc2VnbWVudCBzaXplICovCj4gPiArICAgICBpZiAoaXNkaWdpdCgq
c3RyKSkgewo+ID4gKyAgICAgICAgICAgICB0bXAgPSBzaW1wbGVfc3RydG91bChzdHIsICZzdHIs
IDApOwo+ID4gKyAgICAgICAgICAgICBpZiAodG1wKQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
IGlvX3RsYl9zZWdfc2l6ZSA9IEFMSUdOKHRtcCwgSU9fVExCX1NFR1NJWkUpOwo+Cj4gRnJvbSBh
bGwgSSBjYW4gdGVsbCBpb190bGJfc2VnX3NpemUgd2FudHMgdG8gYmUgYSBwb3dlciBvZiAyLiBN
ZXJlbHkKPiBhbGlnbmluZyB0byBhIG11bHRpcGxlIG9mIElPX1RMQl9TRUdTSVpFIGlzbid0IGdv
aW5nIHRvIGJlIGVub3VnaC4KPgo+IEphbgo+CgoKLS0gCkJlc3QgUmVnYXJkcywgUm9tYW4uCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxp
bmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
