Return-Path: <SRS0=zShu=DV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A742FC433E7
	for <iommu@archiver.kernel.org>; Wed, 14 Oct 2020 07:19:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7A6C2078A
	for <iommu@archiver.kernel.org>; Wed, 14 Oct 2020 07:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="0LYJQWdo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7A6C2078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 44B9D2E249;
	Wed, 14 Oct 2020 07:19:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XzL3cS4CHal8; Wed, 14 Oct 2020 07:19:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C55B8203AB;
	Wed, 14 Oct 2020 07:19:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8161C07FF;
	Wed, 14 Oct 2020 07:19:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37C1DC0051
 for <iommu@lists.linux-foundation.org>; Wed, 14 Oct 2020 07:19:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 25BC5203AB
 for <iommu@lists.linux-foundation.org>; Wed, 14 Oct 2020 07:19:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UuJuKZsubfMX for <iommu@lists.linux-foundation.org>;
 Wed, 14 Oct 2020 07:19:10 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-il1-f193.google.com (mail-il1-f193.google.com
 [209.85.166.193])
 by silver.osuosl.org (Postfix) with ESMTPS id 686DA2E256
 for <iommu@lists.linux-foundation.org>; Wed, 14 Oct 2020 07:19:08 +0000 (UTC)
Received: by mail-il1-f193.google.com with SMTP id k1so758992ilc.10
 for <iommu@lists.linux-foundation.org>; Wed, 14 Oct 2020 00:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=dzOJ/swm9JGAByIHn/wEgfUebM+eNtx9/pR8X+4E4is=;
 b=0LYJQWdozCaK1EN3ItjEZqoVtwC5Y2vmWWI7cXZLqMIOGaE3Q3jLXN8eefIqw18imc
 63Np64Sl5g0aPt1Ww6Jl5YY6rmP1CRkWofUimrjqFpp26+KrkUebuTn7xmZcUrNF0awL
 JeMYF9NkGKH8Va2+YfH8wZEqMW+4JSww+jPMIQcSbU1Im9Dk4sdzY/94eMcBXZ4qC+ME
 q0+bCKzUu8LUBrmZmBHBKC1RMDNqEQxfDg/H1twem6upQPVY7le1b4e5NwXSfDipxsXY
 gCPrqO0LQ1fZpDTtYZhHxBV6UGf4bDWxvArR/1uZAFGSA3/jLlEfsNHni7e1ByMlhNMv
 ocYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=dzOJ/swm9JGAByIHn/wEgfUebM+eNtx9/pR8X+4E4is=;
 b=jCQfexZPOdI1osAYen6GxWZNsjMgoshIl4j38RG9l+jbaZ9CB9BFjOOLUozOdTJ+c9
 pjVHIn+uHeFGGJCElC/v1LtD6JKy9TKxL98MAZTG42L4tojjLlgZZWY4HmJ6t/EHA7l6
 aM68MXPE53U0EpDavzWh5q8k3ZvlNsukq+RTmZ9TOhOSnK/EsiVnTmaurzS5AYME5vsc
 j1QRzjikvfNZ/cQnlOXyYxOu+S/Mpkuk3YH4xY6gZpwEQhlgJPeidWACJaCXLbwNYFcC
 KGutkJd5eeI5B8YcCeaVfHiFe2A6b/dOxbw0Wu23NF1XklDjfvuB1UkepaBD+vtM4kKl
 rl3w==
X-Gm-Message-State: AOAM532H8/0Y/sZHdCa8GjyP1py7Vv9nxsQQ7T48gLBaFFZgJCJcxlLf
 zrmbc+hAjuxHFZbsxBz+kjHRafpVuAqFGUbasZAUtQ==
X-Google-Smtp-Source: ABdhPJwuTnKmbtckmY7mH0qDFEjoARiEYUtMovUJ9OGm8LgOhAhHFufHuSKcRL3BGBlZP3QHEXQ0W7kvI1j4bFo1uv4=
X-Received: by 2002:a92:bb58:: with SMTP id w85mr2963629ili.40.1602659947570; 
 Wed, 14 Oct 2020 00:19:07 -0700 (PDT)
MIME-Version: 1.0
References: <20201013073055.11262-1-brgl@bgdev.pl>
 <abd717c9-9eaa-d4bb-3fd8-ff7250d97ab7@linux.intel.com>
In-Reply-To: <abd717c9-9eaa-d4bb-3fd8-ff7250d97ab7@linux.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 14 Oct 2020 09:18:56 +0200
Message-ID: <CAMRc=MdLXaPNUwbUPGJS1AY0pq5je9zsGM7eHShLT=f6mT5Dww@mail.gmail.com>
Subject: Re: [PATCH next] iommu: intel: don't dereference iommu_device if
 IOMMU_API is not built
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

T24gV2VkLCBPY3QgMTQsIDIwMjAgYXQgMjo0OSBBTSBMdSBCYW9sdSA8YmFvbHUubHVAbGludXgu
aW50ZWwuY29tPiB3cm90ZToKPgo+IE9uIDEwLzEzLzIwIDM6MzAgUE0sIEJhcnRvc3ogR29sYXN6
ZXdza2kgd3JvdGU6Cj4gPiBGcm9tOiBCYXJ0b3N6IEdvbGFzemV3c2tpIDxiZ29sYXN6ZXdza2lA
YmF5bGlicmUuY29tPgo+ID4KPiA+IFNpbmNlIGNvbW1pdCBjNDBhYWFhYzEwMTggKCJpb21tdS92
dC1kOiBHcmFjZWZ1bGx5IGhhbmRsZSBETUFSIHVuaXRzCj4gPiB3aXRoIG5vIHN1cHBvcnRlZCBh
ZGRyZXNzIHdpZHRocyIpIGRtYXIuYyBuZWVkcyBzdHJ1Y3QgaW9tbXVfZGV2aWNlIHRvCj4gPiBi
ZSBzZWxlY3RlZC4gV2UgY2FuIGRyb3AgdGhpcyBkZXBlbmRlbmN5IGJ5IG5vdCBkZXJlZmVyZW5j
aW5nIHN0cnVjdAo+ID4gaW9tbXVfZGV2aWNlIGlmIElPTU1VX0FQSSBpcyBub3Qgc2VsZWN0ZWQg
YW5kIGJ5IHJldXNpbmcgdGhlIGluZm9ybWF0aW9uCj4gPiBzdG9yZWQgaW4gaW9tbXUtPmRyaGQt
Pmlnbm9yZWQgaW5zdGVhZC4KPiA+Cj4gPiBUaGlzIGZpeGVzIHRoZSBmb2xsb3dpbmcgYnVpbGQg
ZXJyb3Igd2hlbiBJT01NVV9BUEkgaXMgbm90IHNlbGVjdGVkOgo+ID4KPiA+IGRyaXZlcnMvaW9t
bXUvaW50ZWwvZG1hci5jOiBJbiBmdW5jdGlvbiDigJhmcmVlX2lvbW114oCZOgo+ID4gZHJpdmVy
cy9pb21tdS9pbnRlbC9kbWFyLmM6MTEzOTo0MTogZXJyb3I6IOKAmHN0cnVjdCBpb21tdV9kZXZp
Y2XigJkgaGFzIG5vIG1lbWJlciBuYW1lZCDigJhvcHPigJkKPiA+ICAgMTEzOSB8ICBpZiAoaW50
ZWxfaW9tbXVfZW5hYmxlZCAmJiBpb21tdS0+aW9tbXUub3BzKSB7Cj4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgo+ID4KPiA+IEZpeGVzOiBjNDBh
YWFhYzEwMTggKCJpb21tdS92dC1kOiBHcmFjZWZ1bGx5IGhhbmRsZSBETUFSIHVuaXRzIHdpdGgg
bm8gc3VwcG9ydGVkIGFkZHJlc3Mgd2lkdGhzIikKPiA+IFNpZ25lZC1vZmYtYnk6IEJhcnRvc3og
R29sYXN6ZXdza2kgPGJnb2xhc3pld3NraUBiYXlsaWJyZS5jb20+Cj4KPiBXaXRoIGNvbW1pdCB0
aXRsZSBhZGp1c3RlZCB0byAiaW9tbXUvdnQtZDogRG9uJ3QgZGVyZWZlcmVuY2UKPiBpb21tdV9k
ZXZpY2UgaWYgSU9NTVVfQVBJIGlzIG5vdCBidWlsdCIsCj4KPiBBY2tlZC1ieTogTHUgQmFvbHUg
PGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4KPgoKRG8geW91IHdhbnQgbWUgdG8gcmVzZW5kIGl0
IGFnYWluIHdpdGggYSBjaGFuZ2VkIHRpdGxlIG9yIGNhbiB5b3UgZml4Cml0IHVwIHdoZW4gYXBw
bHlpbmc/IE9yIHNob3VsZCBzb21lb25lIGVsc2UgcGljayBpdCB1cD8KCkJhcnRvc3oKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBs
aXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
