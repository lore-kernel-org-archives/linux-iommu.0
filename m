Return-Path: <SRS0=tLNU=5F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73477C4332B
	for <iommu@archiver.kernel.org>; Fri, 20 Mar 2020 06:34:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CC262072D
	for <iommu@archiver.kernel.org>; Fri, 20 Mar 2020 06:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="mlwq4CYA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC262072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tcd.ie
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0D3D6888B9;
	Fri, 20 Mar 2020 06:33:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m8NLTWaSiQFl; Fri, 20 Mar 2020 06:33:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5E80B88564;
	Fri, 20 Mar 2020 06:33:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4204EC089E;
	Fri, 20 Mar 2020 06:33:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EEBD5C07FF
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 06:33:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D3FDE888B5
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 06:33:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 98cLQi74+dyj for <iommu@lists.linux-foundation.org>;
 Fri, 20 Mar 2020 06:33:55 +0000 (UTC)
X-Greylist: delayed 00:05:33 by SQLgrey-1.7.6
Received: from mail-il1-f194.google.com (mail-il1-f194.google.com
 [209.85.166.194])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7491688564
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 06:33:55 +0000 (UTC)
Received: by mail-il1-f194.google.com with SMTP id k29so4635465ilg.0
 for <iommu@lists.linux-foundation.org>; Thu, 19 Mar 2020 23:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tcd-ie.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=iNXs70iQMmbCeWom+A/Tg16i/IbQyXAZI0Q/ppb6028=;
 b=mlwq4CYA+23qP9sIb47R10WlCGq2DIeqg0u1nZRI7nIlEwzdaBM16J0diAb1hlohhx
 6DmTCrAETojeuHxXASGkurUqmDfwjHRaPO4za7UkVii+FhFKjU1p/Uh7mi3KFwpjPhsb
 iUmifGiws8WLlb2N+d2f8DAIA3I+MwtdSl7QMUdRy6dZmidqOFzKWaoRrSqr4hGVvYFe
 lxvu2QhZ23+aceqTRPs5AhP4qiprkvMy5v6UfWHtbzwVFjivSqy8raQEj8IKp649aRSz
 OzRNio30MUjHUatFuFBVrSm+4Q22qFcnN1y399wmFgi4y40WUSo1BlDO9PO4lb7z5YMG
 C1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=iNXs70iQMmbCeWom+A/Tg16i/IbQyXAZI0Q/ppb6028=;
 b=VQ1if3zaQEY4yHIhzAgLS+F2pxVxMYoFu2898dYGBtmJG4huwfZh7jeCvPMYLXqHZf
 QkBsARXgATV1UHxfpYJkiWP909Hl/KX0iMt4keP943sOyuXhbgl5wfNbCi9g5170TdKf
 jkHiZRWeXBMSkDiaQ9bFlZ5/VQpjrgn1CFIMfeRXvOqI+QDqaT9vovKbEA+PJB7RsrK5
 xgy513ire0b8YGe1l7GRDfGqR3vwVI3UcLZwsgYOerCasnyqHyaCJVym9UZZmam4QHyl
 rS+Rku6rFkg8qVEu6STebO8SQcaZqIcQXDaz5Utd9D+VPi6DpiaiYd9RFGQUgCQ9FCQE
 fh9w==
X-Gm-Message-State: ANhLgQ0DM5/cRFUFSAKD5uHIO6CxYW21xSKOiLIP5M3PaWWMItc37Pmk
 j8/MDpIrx1WcA67HkpXaIJgGYryx8phT92d7FItwWEAbVb0=
X-Google-Smtp-Source: ADFU+vu5z05Ntsthh3MN1VmTHwq3rO5otoJoIS27t3cZsZdixT+HOBtJfxy3n0Krurf+ZkaYNXqDSZk62sBvXeLV7BQ=
X-Received: by 2002:a92:41c7:: with SMTP id o190mr6554977ila.11.1584685701013; 
 Thu, 19 Mar 2020 23:28:21 -0700 (PDT)
MIME-Version: 1.0
References: <20191221150402.13868-1-murphyt7@tcd.ie> <87blrzwcn8.fsf@intel.com>
 <432d306c-fe9f-75b2-f0f7-27698f1467ad@arm.com> <87o8vzuv4i.fsf@intel.com>
In-Reply-To: <87o8vzuv4i.fsf@intel.com>
From: Tom Murphy <murphyt7@tcd.ie>
Date: Thu, 19 Mar 2020 23:28:09 -0700
Message-ID: <CALQxJuujCe7TsqkbfusPnzef2SApDBNPa7wj=U4ozDJWCoBHOg@mail.gmail.com>
Subject: Re: [PATCH 0/8] Convert the intel iommu driver to the dma-iommu api
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Heiko Stuebner <heiko@sntech.de>, kvm@vger.kernel.org,
 David Airlie <airlied@linux.ie>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 dri-devel@lists.freedesktop.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 linux-tegra@vger.kernel.org, Julien Grall <julien.grall@arm.com>,
 Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 linux-samsung-soc@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 iommu@lists.linux-foundation.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-rockchip@lists.infradead.org,
 Andy Gross <agross@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, Alex Williamson <alex.williamson@redhat.com>,
 linux-mediatek@lists.infradead.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 virtualization@lists.linux-foundation.org,
 Gerald Schaefer <gerald.schaefer@de.ibm.com>,
 David Woodhouse <dwmw2@infradead.org>, Cornelia Huck <cohuck@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Kukjin Kim <kgene@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Robin Murphy <robin.murphy@arm.com>
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

QW55IG5ld3Mgb24gdGhpcz8gSXMgdGhlcmUgYW55b25lIHdobyB3YW50cyB0byB0cnkgYW5kIGZp
eCB0aGlzIHBvc3NpYmxlIGJ1Zz8KCk9uIE1vbiwgMjMgRGVjIDIwMTkgYXQgMDM6NDEsIEphbmkg
TmlrdWxhIDxqYW5pLm5pa3VsYUBsaW51eC5pbnRlbC5jb20+IHdyb3RlOgo+Cj4gT24gTW9uLCAy
MyBEZWMgMjAxOSwgUm9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4gd3JvdGU6Cj4g
PiBPbiAyMDE5LTEyLTIzIDEwOjM3IGFtLCBKYW5pIE5pa3VsYSB3cm90ZToKPiA+PiBPbiBTYXQs
IDIxIERlYyAyMDE5LCBUb20gTXVycGh5IDxtdXJwaHl0N0B0Y2QuaWU+IHdyb3RlOgo+ID4+PiBU
aGlzIHBhdGNoc2V0IGNvbnZlcnRzIHRoZSBpbnRlbCBpb21tdSBkcml2ZXIgdG8gdGhlIGRtYS1p
b21tdSBhcGkuCj4gPj4+Cj4gPj4+IFdoaWxlIGNvbnZlcnRpbmcgdGhlIGRyaXZlciBJIGV4cG9z
ZWQgYSBidWcgaW4gdGhlIGludGVsIGk5MTUgZHJpdmVyCj4gPj4+IHdoaWNoIGNhdXNlcyBhIGh1
Z2UgYW1vdW50IG9mIGFydGlmYWN0cyBvbiB0aGUgc2NyZWVuIG9mIG15Cj4gPj4+IGxhcHRvcC4g
WW91IGNhbiBzZWUgYSBwaWN0dXJlIG9mIGl0IGhlcmU6Cj4gPj4+IGh0dHBzOi8vZ2l0aHViLmNv
bS9waXBweTM2MC9rZXJuZWxQYXRjaGVzL2Jsb2IvbWFzdGVyL0lNR18yMDE5MTIxOV8yMjU5MjIu
anBnCj4gPj4+Cj4gPj4+IFRoaXMgaXNzdWUgaXMgbW9zdCBsaWtlbHkgaW4gdGhlIGk5MTUgZHJp
dmVyIGFuZCBpcyBtb3N0IGxpa2VseSBjYXVzZWQKPiA+Pj4gYnkgdGhlIGRyaXZlciBub3QgcmVz
cGVjdGluZyB0aGUgcmV0dXJuIHZhbHVlIG9mIHRoZQo+ID4+PiBkbWFfbWFwX29wczo6bWFwX3Nn
IGZ1bmN0aW9uLiBZb3UgY2FuIHNlZSB0aGUgZHJpdmVyIGlnbm9yaW5nIHRoZQo+ID4+PiByZXR1
cm4gdmFsdWUgaGVyZToKPiA+Pj4gaHR0cHM6Ly9naXRodWIuY29tL3RvcnZhbGRzL2xpbnV4L2Js
b2IvN2UwMTY1YjJmMWE5MTJhMDZlMzgxZTkxZjBmNGU0OTVmNGFjMzczNi9kcml2ZXJzL2dwdS9k
cm0vaTkxNS9nZW0vaTkxNV9nZW1fZG1hYnVmLmMjTDUxCj4gPj4+Cj4gPj4+IFByZXZpb3VzbHkg
dGhpcyBkaWRu4oCZdCBjYXVzZSBpc3N1ZXMgYmVjYXVzZSB0aGUgaW50ZWwgbWFwX3NnIGFsd2F5
cwo+ID4+PiByZXR1cm5lZCB0aGUgc2FtZSBudW1iZXIgb2YgZWxlbWVudHMgYXMgdGhlIGlucHV0
IHNjYXR0ZXIgZ2F0aGVyIGxpc3QKPiA+Pj4gYnV0IHdpdGggdGhlIGNoYW5nZSB0byB0aGlzIGRt
YS1pb21tdSBhcGkgdGhpcyBpcyBubyBsb25nZXIgdGhlCj4gPj4+IGNhc2UuIEkgd2FzbuKAmXQg
YWJsZSB0byB0cmFjayB0aGUgYnVnIGRvd24gdG8gYSBzcGVjaWZpYyBsaW5lIG9mIGNvZGUKPiA+
Pj4gdW5mb3J0dW5hdGVseS4KPiA+Pj4KPiA+Pj4gQ291bGQgc29tZW9uZSBmcm9tIHRoZSBpbnRl
bCB0ZWFtIGxvb2sgYXQgdGhpcz8KPiA+Pgo+ID4+IExldCBtZSBnZXQgdGhpcyBzdHJhaWdodC4g
VGhlcmUgaXMgY3VycmVudCBBUEkgdGhhdCBvbiBzdWNjZXNzIGFsd2F5cwo+ID4+IHJldHVybnMg
dGhlIHNhbWUgbnVtYmVyIG9mIGVsZW1lbnRzIGFzIHRoZSBpbnB1dCBzY2F0dGVyIGdhdGhlcgo+
ID4+IGxpc3QuIFlvdSBwcm9wb3NlIHRvIGNoYW5nZSB0aGUgQVBJIHNvIHRoYXQgdGhpcyBpcyBu
byBsb25nZXIgdGhlIGNhc2U/Cj4gPgo+ID4gTm8sIHRoZSBBUEkgZm9yIGRtYV9tYXBfc2coKSBo
YXMgYWx3YXlzIGJlZW4gdGhhdCBpdCBtYXkgcmV0dXJuIGZld2VyCj4gPiBETUEgc2VnbWVudHMg
dGhhbiBuZW50cyAtIHNlZSBEb2N1bWVudGF0aW9uL0RNQS1BUEkudHh0IChhbmQgb3RoZXJ3aXNl
LAo+ID4gdGhlIHJldHVybiB2YWx1ZSB3b3VsZCBzdXJlbHkgYmUgYSBzaW1wbGUgc3VjY2Vzcy9m
YWlsIGNvbmRpdGlvbikuCj4gPiBSZWx5aW5nIG9uIGEgcGFydGljdWxhciBpbXBsZW1lbnRhdGlv
biBiZWhhdmlvdXIgaGFzIG5ldmVyIGJlZW4gc3RyaWN0bHkKPiA+IGNvcnJlY3QsIGV2ZW4gaWYg
aXQgZG9lcyBoYXBwZW4gdG8gYmUgYSB2ZXJ5IGNvbW1vbiBiZWhhdmlvdXIuCj4gPgo+ID4+IEEg
cXVpY2sgY2hlY2sgb2YgdmFyaW91cyBkbWFfbWFwX3NnKCkgY2FsbHMgaW4gdGhlIGtlcm5lbCBz
ZWVtcyB0bwo+ID4+IGluZGljYXRlIGNoZWNraW5nIGZvciAwIGZvciBlcnJvcnMgYW5kIHRoZW4g
aWdub3JpbmcgdGhlIG5vbi16ZXJvIHJldHVybgo+ID4+IGlzIGEgY29tbW9uIHBhdHRlcm4uIEFy
ZSB5b3Ugc3VyZSBpdCdzIG9rYXkgdG8gbWFrZSB0aGUgY2hhbmdlIHlvdSdyZQo+ID4+IHByb3Bv
c2luZz8KPiA+Cj4gPiBWYXJpb3VzIGNvZGUgdXNlcyB0cmlja3MgbGlrZSBqdXN0IGl0ZXJhdGlu
ZyB0aGUgbWFwcGVkIGxpc3QgdW50aWwgdGhlCj4gPiBmaXJzdCBzZWdtZW50IHdpdGggemVybyBz
Z19kbWFfbGVuKCkuIE90aGVycyBtYXkgd2VsbCBzaW1wbHkgaGF2ZSBidWdzLgo+Cj4gVGhhbmtz
IGZvciB0aGUgY2xhcmlmaWNhdGlvbi4KPgo+IEJSLAo+IEphbmkuCj4KPiA+Cj4gPiBSb2Jpbi4K
PiA+Cj4gPj4gQW55d2F5LCBkdWUgdG8gdGhlIHRpbWUgb2YgeWVhciBhbmQgYWxsLCBJJ2QgbGlr
ZSB0byBhc2sgeW91IHRvIGZpbGUgYQo+ID4+IGJ1ZyBhZ2FpbnN0IGk5MTUgYXQgWzFdIHNvIHRo
aXMgaXMgbm90IGZvcmdvdHRlbiwgYW5kIHBsZWFzZSBsZXQncyBub3QKPiA+PiBtZXJnZSB0aGUg
Y2hhbmdlcyBiZWZvcmUgdGhpcyBpcyByZXNvbHZlZC4KPiA+Pgo+ID4+Cj4gPj4gVGhhbmtzLAo+
ID4+IEphbmkuCj4gPj4KPiA+Pgo+ID4+IFsxXSBodHRwczovL2dpdGxhYi5mcmVlZGVza3RvcC5v
cmcvZHJtL2ludGVsL2lzc3Vlcy9uZXcKPiA+Pgo+ID4+Cj4KPiAtLQo+IEphbmkgTmlrdWxhLCBJ
bnRlbCBPcGVuIFNvdXJjZSBHcmFwaGljcyBDZW50ZXIKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2lvbW11
