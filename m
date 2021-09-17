Return-Path: <SRS0=dQER=OH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96CBC433FE
	for <iommu@archiver.kernel.org>; Fri, 17 Sep 2021 10:53:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D57460F43
	for <iommu@archiver.kernel.org>; Fri, 17 Sep 2021 10:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9D57460F43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6CB9C83FB8;
	Fri, 17 Sep 2021 10:53:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1Xi4uuJlqGQl; Fri, 17 Sep 2021 10:53:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3E00F817FD;
	Fri, 17 Sep 2021 10:53:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12723C0011;
	Fri, 17 Sep 2021 10:53:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF85AC000D
 for <iommu@lists.linux-foundation.org>; Fri, 17 Sep 2021 10:53:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C11C660744
 for <iommu@lists.linux-foundation.org>; Fri, 17 Sep 2021 10:53:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F_ek7TS-KNiN for <iommu@lists.linux-foundation.org>;
 Fri, 17 Sep 2021 10:53:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AE7B3606C9
 for <iommu@lists.linux-foundation.org>; Fri, 17 Sep 2021 10:53:18 +0000 (UTC)
Received: by mail-lf1-x12c.google.com with SMTP id i25so31508997lfg.6
 for <iommu@lists.linux-foundation.org>; Fri, 17 Sep 2021 03:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=GwPKvHPa7SWPdAxFNaWPHxr/qhyv9zoje0np7fedQKE=;
 b=WPqhGp7YFJx9AUCevICXrAodjCpr6nIpm2Ih1DUPRgTO2JIO4D88GB1S962YfHO9vm
 DRezWJVTxjj9rs0AZRWxJOWrvy9r+qKMeskCPE927IzPuRXFDgRa2iadYLcTMOd/64+4
 nzSruXNpaJKUZ/QJMboU8PnvfhM3HxH1/+n2Hxdlkx7TK9deyd8BenrLblqAQ+bMgzVD
 B6WKlUg0EoDvkkaNdaR+KyTdmSq6OG0BlpLoAPZbqIl9QPO8MWAsO5TjFbpFLhkwDdr4
 XYe66QAT2Ou7DTn+qqH8GubuMGhG8e16UInR2xW2MYta03lHYWn05LHNPgYs5vhLU3q9
 bpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=GwPKvHPa7SWPdAxFNaWPHxr/qhyv9zoje0np7fedQKE=;
 b=hL62ScBOLxXSnbrscu1fkRikOWichNniSmC4oMsk4oM7gcVVhtP/jXkqsNP80bLEuf
 NYjCcAm6dX2KE8+5GRcdt3gkzNOjSuBptk90KBvRrBMLfcWDsmz8r+J5baNooAZrn1nt
 RGY9GWRVAaMh5+KR5Flox3VSXchFGuBj1mox1ROZDtg/ZHayK34cSX8cUB2hRYRll/tc
 C496ki5NQ9OjJOF5LJJ+hNExZmun5/14DMU4QZ68SrMDUxJMzAR5vEBTT22H6dvwXrJF
 +V9plseSBpjm7YpHguaggB4vxGupLo73kzJIPV2Jk3JS2UCTZNbx7cgCrZvJfQQ1/A6b
 5B4w==
X-Gm-Message-State: AOAM530euwCTSpJeQwjZORm7iwOX01xSb/T+n/j+7oWQGDyf18gC67gs
 ioi0b8XBUXP9LrlXS+gzBLxDIhjWoMdc50gQ9Fw=
X-Google-Smtp-Source: ABdhPJxECw0V3jWNF/BA8gW1zDMxBYDkGOJs8qFL3/XqUc3j9ICvKltI4RP4oRxJGpZWee5/Y+mW8GOAZO8FS/BZnHE=
X-Received: by 2002:ac2:5310:: with SMTP id c16mr7346042lfh.393.1631875996413; 
 Fri, 17 Sep 2021 03:53:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210914151016.3174924-1-Roman_Skakun@epam.com>
 <7c04db79-7de1-93ff-0908-9bad60a287b9@suse.com>
 <CADu_u-Ou08tMFm5xU871ae8ct+2YOuvn4rQ=83CMTbg2bx87Pg@mail.gmail.com>
 <84ef7ff7-2c9c-113a-4a2c-cef54a6ded51@suse.com>
In-Reply-To: <84ef7ff7-2c9c-113a-4a2c-cef54a6ded51@suse.com>
From: Roman Skakun <rm.skakun@gmail.com>
Date: Fri, 17 Sep 2021 13:53:05 +0300
Message-ID: <CADu_u-NvDrKkYJXoPSH8BL2GzKmCUNtsSz=6mn1yA+pPcUMpLA@mail.gmail.com>
Subject: Re: [PATCH] swiotlb: set IO TLB segment size via cmdline
To: Jan Beulich <jbeulich@suse.com>
Cc: linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
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

SGkgSmFuLAoKPj4+ICBJbiBvcmRlciB0byBiZSBzdXJlIHRvIGNhdGNoIGFsbCB1c2VzIGxpa2Ug
dGhpcyBvbmUgKGluY2x1ZGluZyBvbmVzCj4+PiAgd2hpY2ggbWFrZSBpdCB1cHN0cmVhbSBpbiBw
YXJhbGxlbCB0byB5b3VycyksIEkgdGhpbmsgeW91IHdpbGwgd2FudAo+Pj4gIHRvIHJlbmFtZSB0
aGUgb3JpZ2luYWwgSU9fVExCX1NFR1NJWkUgdG8gZS5nLiBJT19UTEJfREVGQVVMVF9TRUdTSVpF
Lgo+Pgo+PiBJIGRvbid0IHVuZGVyc3RhbmQgeW91ciBwb2ludC4gQ2FuIHlvdSBjbGFyaWZ5IHRo
aXM/Cj4KPiBUaGVyZSdzIGEgY29uY3JldGUgcHJlc2VudCBleGFtcGxlOiBJIGhhdmUgYSBwYXRj
aCBwZW5kaW5nIGFkZGluZwo+IGFub3RoZXIgdXNlIG9mIElPX1RMQl9TRUdTSVpFLiBUaGlzIHVz
ZSB3b3VsZCBuZWVkIHRvIGJlIHJlcGxhY2VkCj4gbGlrZSB5b3UgZG8gaGVyZSBpbiBzZXZlcmFs
IHBsYWNlcy4gVGhlIG5lZWQgZm9yIHRoZSBhZGRpdGlvbmFsCj4gcmVwbGFjZW1lbnQgd291bGQg
YmUgcXVpdGUgb2J2aW91cyAoZnJvbSBhIGJ1aWxkIGZhaWx1cmUpIGlmIHlvdQo+IHJlbmFtZWQg
dGhlIG1hbmlmZXN0IGNvbnN0YW50LiBXaXRob3V0IHJlbmFtaW5nLCBpdCdsbCB0YWtlCj4gc29t
ZW9uZSBydW5uaW5nIGludG8gYW4gaXNzdWUgb24gYSBsaXZlIHN5c3RlbSwgd2hpY2ggSSBjb25z
aWRlcgo+IGZhciB3b3JzZS4gVGhpcyBpcyBiZWNhdXNlIGEgc2ltcGxlIHJlLWJhc2luZyBvZiBv
bmUgb2YgdGhlCj4gcGF0Y2hlcyBvbiB0b3Agb2YgdGhlIG90aGVyIHdpbGwgbm90IHBvaW50IG91
dCB0aGUgbmVlZCBmb3IgdGhlCj4gZXh0cmEgcmVwbGFjZW1lbnQsIG5vciB3b3VsZCBhIHRlc3Qg
YnVpbGQgKHdpdGggYm90aCBwYXRjaGVzIGluCj4gcGxhY2UpLgoKSXQncyByZWFzb25hYmxlLgpJ
IHdpbGwgY2hhbmdlIHRoZSBvcmlnaW5hbCBJT19UTEJfU0VHU0laRSB0byBJT19UTEJfREVGQVVM
VF9TRUdTSVpFIGluIHRoZQpuZXh0IHBhdGNoIHNlcmllcy4KClRoYW5rcy4KCtGB0YAsIDE1INGB
0LXQvdGCLiAyMDIxINCzLiDQsiAxNjo1MCwgSmFuIEJldWxpY2ggPGpiZXVsaWNoQHN1c2UuY29t
PjoKPgo+IE9uIDE1LjA5LjIwMjEgMTU6MzcsIFJvbWFuIFNrYWt1biB3cm90ZToKPiA+Pj4gRnJv
bTogUm9tYW4gU2tha3VuIDxyb21hbl9za2FrdW5AZXBhbS5jb20+Cj4gPj4+Cj4gPj4+IEl0IGlz
IHBvc3NpYmxlIHdoZW4gZGVmYXVsdCBJTyBUTEIgc2l6ZSBpcyBub3QKPiA+Pj4gZW5vdWdoIHRv
IGZpdCBhIGxvbmcgYnVmZmVycyBhcyBkZXNjcmliZWQgaGVyZSBbMV0uCj4gPj4+Cj4gPj4+IFRo
aXMgcGF0Y2ggbWFrZXMgYSB3YXkgdG8gc2V0IHRoaXMgcGFyYW1ldGVyCj4gPj4+IHVzaW5nIGNt
ZGxpbmUgaW5zdGVhZCBvZiByZWNvbXBpbGluZyBhIGtlcm5lbC4KPiA+Pj4KPiA+Pj4gWzFdIGh0
dHBzOi8vd3d3LnhpbGlueC5jb20vc3VwcG9ydC9hbnN3ZXJzLzcyNjk0Lmh0bWwKPiA+Pgo+ID4+
ICBJJ20gbm90IGNvbnZpbmNlZCB0aGUgc3dpb3RsYiB1c2UgZGVzY3JpYmUgdGhlcmUgZmFsbHMg
dW5kZXIgImludGVuZGVkCj4gPj4gIHVzZSIgLSBtYXBwaW5nIGEgMTI4MHg3MjAgZnJhbWVidWZm
ZXIgaW4gYSBzaW5nbGUgY2h1bms/Cj4gPgo+ID4gSSBoYWQgdGhlIHNhbWUgaXNzdWUgd2hpbGUg
bWFwcGluZyBETUEgY2h1Y2sgfjRNQiBmb3IgZ2VtIGZiIHdoZW4KPiA+IHVzaW5nIHhlbiB2ZGlz
cGwuCj4gPiBJIGdvdCB0aGUgbmV4dCBsb2c6Cj4gPiBbIDE0Mi4wMzA0MjFdIHJjYXItZmNwIGZl
YTJmMDAwLmZjcDogc3dpb3RsYiBidWZmZXIgaXMgZnVsbCAoc3o6Cj4gPiAzNjg2NDAwIGJ5dGVz
KSwgdG90YWwgMzI3NjggKHNsb3RzKSwgdXNlZCAzMiAoc2xvdHMpCj4gPgo+ID4gSXQgaGFwcGVu
ZWQgd2hlbiBJIHRyaWVkIHRvIG1hcCBib3VuY2UgYnVmZmVyLCB3aGljaCBoYXMgYSBsYXJnZSBz
aXplLgo+ID4gVGhlIGRlZmF1bHQgc2l6ZSBpZiAxMjgoSU9fVExCX1NFR1NJWkUpICogMjA0OChJ
T19UTEJfU0hJRlQpID0gMjYyMTQ0Cj4gPiBieXRlcywgYnV0IHdlIHJlcXVlc3RlZCAzNjg2NDAw
IGJ5dGVzLgo+ID4gV2hlbiBJIGNoYW5nZSBJT19UTEJfU0VHU0laRSB0byAyMDQ4LiAoMjA0OChJ
T19UTEJfU0VHU0laRSkgICoKPiA+IDIwNDgoSU9fVExCX1NISUZUKSA9IDQxOTQzMDRieXRlcyku
Cj4gPiBJdCBtYWtlcyBwb3NzaWJsZSB0byByZXRyaWV2ZSBhIGJvdW5jZSBidWZmZXIgZm9yIHJl
cXVlc3RlZCBzaXplLgo+ID4gQWZ0ZXIgY2hhbmdpbmcgdGhpcyB2YWx1ZSwgdGhlIHByb2JsZW0g
aXMgZ29uZS4KPgo+IEJ1dCB0aGUgcXVlc3Rpb24gcmVtYWluczogV2h5IGRvZXMgdGhlIGZyYW1l
YnVmZmVyIG5lZWQgdG8gYmUgbWFwcGVkCj4gaW4gYSBzaW5nbGUgZ2lhbnQgY2h1bms/Cj4KPiA+
PiAgSW4gb3JkZXIgdG8gYmUgc3VyZSB0byBjYXRjaCBhbGwgdXNlcyBsaWtlIHRoaXMgb25lIChp
bmNsdWRpbmcgb25lcwo+ID4+ICB3aGljaCBtYWtlIGl0IHVwc3RyZWFtIGluIHBhcmFsbGVsIHRv
IHlvdXJzKSwgSSB0aGluayB5b3Ugd2lsbCB3YW50Cj4gPj4gIHRvIHJlbmFtZSB0aGUgb3JpZ2lu
YWwgSU9fVExCX1NFR1NJWkUgdG8gZS5nLiBJT19UTEJfREVGQVVMVF9TRUdTSVpFLgo+ID4KPiA+
IEkgZG9uJ3QgdW5kZXJzdGFuZCB5b3VyIHBvaW50LiBDYW4geW91IGNsYXJpZnkgdGhpcz8KPgo+
IFRoZXJlJ3MgYSBjb25jcmV0ZSBwcmVzZW50IGV4YW1wbGU6IEkgaGF2ZSBhIHBhdGNoIHBlbmRp
bmcgYWRkaW5nCj4gYW5vdGhlciB1c2Ugb2YgSU9fVExCX1NFR1NJWkUuIFRoaXMgdXNlIHdvdWxk
IG5lZWQgdG8gYmUgcmVwbGFjZWQKPiBsaWtlIHlvdSBkbyBoZXJlIGluIHNldmVyYWwgcGxhY2Vz
LiBUaGUgbmVlZCBmb3IgdGhlIGFkZGl0aW9uYWwKPiByZXBsYWNlbWVudCB3b3VsZCBiZSBxdWl0
ZSBvYnZpb3VzIChmcm9tIGEgYnVpbGQgZmFpbHVyZSkgaWYgeW91Cj4gcmVuYW1lZCB0aGUgbWFu
aWZlc3QgY29uc3RhbnQuIFdpdGhvdXQgcmVuYW1pbmcsIGl0J2xsIHRha2UKPiBzb21lb25lIHJ1
bm5pbmcgaW50byBhbiBpc3N1ZSBvbiBhIGxpdmUgc3lzdGVtLCB3aGljaCBJIGNvbnNpZGVyCj4g
ZmFyIHdvcnNlLiBUaGlzIGlzIGJlY2F1c2UgYSBzaW1wbGUgcmUtYmFzaW5nIG9mIG9uZSBvZiB0
aGUKPiBwYXRjaGVzIG9uIHRvcCBvZiB0aGUgb3RoZXIgd2lsbCBub3QgcG9pbnQgb3V0IHRoZSBu
ZWVkIGZvciB0aGUKPiBleHRyYSByZXBsYWNlbWVudCwgbm9yIHdvdWxkIGEgdGVzdCBidWlsZCAo
d2l0aCBib3RoIHBhdGNoZXMgaW4KPiBwbGFjZSkuCj4KPiBKYW4KPgoKCi0tIApCZXN0IFJlZ2Fy
ZHMsIFJvbWFuLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
