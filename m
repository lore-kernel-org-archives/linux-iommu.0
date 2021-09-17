Return-Path: <SRS0=dQER=OH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F985C433EF
	for <iommu@archiver.kernel.org>; Fri, 17 Sep 2021 09:36:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D98B76120D
	for <iommu@archiver.kernel.org>; Fri, 17 Sep 2021 09:36:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D98B76120D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 925E1404BA;
	Fri, 17 Sep 2021 09:36:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kixbp0usDFPU; Fri, 17 Sep 2021 09:36:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 32ECC40294;
	Fri, 17 Sep 2021 09:36:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D207C000D;
	Fri, 17 Sep 2021 09:36:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1797C000D
 for <iommu@lists.linux-foundation.org>; Fri, 17 Sep 2021 09:36:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C7EAC60B91
 for <iommu@lists.linux-foundation.org>; Fri, 17 Sep 2021 09:36:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GpYhKocWcwOm for <iommu@lists.linux-foundation.org>;
 Fri, 17 Sep 2021 09:36:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B3B95605E3
 for <iommu@lists.linux-foundation.org>; Fri, 17 Sep 2021 09:36:17 +0000 (UTC)
Received: by mail-lf1-x12f.google.com with SMTP id m3so28659974lfu.2
 for <iommu@lists.linux-foundation.org>; Fri, 17 Sep 2021 02:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=iK4mpVKVVYi9/BGqZbaVX4RSahiZlKiCXLvFBZ3uV8Y=;
 b=MN1/jjZbppwReGdyLZpyF5ymRtRGFu/Up778Ys6rsxRU6QdZsKzVvIV1Q5LMSVHi6Z
 LMWOqEixSS5S1UiNP6owwflUknFLs1ErQafLBTm1cdf5WCbo14UWSsE6/KV+DIGfOqjV
 AyKGWKq6Yh+vZ9xqARQDEgXI+FhmqY29Z33fH6+Ub3CcWbHN7pydnuuP4botigVFYLMy
 33nx/CbANxIL6zJDEYOpA2yEgz1OMqNEISlQrFUuBE6towtd9HN1UqjyGBakn7j61ZaJ
 GLIWXE28d5uJ2toCULBsue8DI3bB0s7qDKIuYv8KsoZ9U2hiDf3PWxFEWtOdeGEfcBVA
 03Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=iK4mpVKVVYi9/BGqZbaVX4RSahiZlKiCXLvFBZ3uV8Y=;
 b=vGRVzQbDff6ByTtP1xBt5U7tq3S1nFa5n1W3nmXjjqVR0oa4P/rAEbfp5loDChS0hv
 6JulBh5ZvFaMJG3xizri/b02Yx3BI0OajsPmX9yDle1QGr0RkjFbVs4gTZVcq7pR4iVW
 W5N8i7Iat5nX2ofVEboy/FxSn6pGRM9XNqcUXBkFOjJJ2M8qiZc3B0B61RECnCrv2OYA
 BMsaMe2UZ3RtEniWJU2f3PwumsZY8k+Lm71n4BjkoFzhz/YKZ5Dz1mP2A1oFmzN1x4uO
 eEJYTd39fr2dlRzbANgJI/tS1MWctYlbK4tTVwxQKEuJeYvT6ug9c2slMVElqz4OhKMN
 pYdw==
X-Gm-Message-State: AOAM533PGSiG+HuXS2v91YnfvBvCMaU9U8XTFukQfknX3r2LTAtUYhRf
 zV4o3To2HJ1Nc500HK8ybPDQ8QVEVcn5OmRIACE=
X-Google-Smtp-Source: ABdhPJzQUNFm8ZGVYUpqQ4Z42IbxHswXEbwr86F8d6HCMiXlqvVN8bj/2/tgPLfPn2KT6aH0vcM4FCwUBAENJfLsLbE=
X-Received: by 2002:a2e:586:: with SMTP id 128mr8467207ljf.310.1631871375448; 
 Fri, 17 Sep 2021 02:36:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210914151016.3174924-1-Roman_Skakun@epam.com>
 <7c04db79-7de1-93ff-0908-9bad60a287b9@suse.com>
 <CADu_u-Ou08tMFm5xU871ae8ct+2YOuvn4rQ=83CMTbg2bx87Pg@mail.gmail.com>
 <84ef7ff7-2c9c-113a-4a2c-cef54a6ded51@suse.com>
 <20210915135321.GA15216@lst.de>
In-Reply-To: <20210915135321.GA15216@lst.de>
From: Roman Skakun <rm.skakun@gmail.com>
Date: Fri, 17 Sep 2021 12:36:04 +0300
Message-ID: <CADu_u-OZzgVj+z=iD6kUQOZxUufF5QSMR6-MmpN_hLZ9PyQJhQ@mail.gmail.com>
Subject: Re: [PATCH] swiotlb: set IO TLB segment size via cmdline
To: Christoph Hellwig <hch@lst.de>
Cc: Roman Skakun <rm.skakun@gmail.com>, linux-doc@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Jan Beulich <jbeulich@suse.com>,
 Will Deacon <will@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Michael Ellerman <mpe@ellerman.id.au>,
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

SGksIENocmlzdG9waAoKSSB1c2UgWGVuIFBWIGRpc3BsYXkuIEluIG15IGNhc2UsIFBWIGRpc3Bs
YXkgYmFja2VuZChEb20wKSBhbGxvY2F0ZXMKY29udGlndW91cyBidWZmZXIgdmlhIERNQS1BUEkg
dG8KdG8gaW1wbGVtZW50IHplcm8tY29weSBiZXR3ZWVuIERvbTAgYW5kIERvbVUuCgpXaGVuIEkg
c3RhcnQgV2VzdG9uIHVuZGVyIERvbVUsIEkgZ290IHRoZSBuZXh0IGxvZyBpbiBEb20wOgpgYGAK
WyAxMTIuNTU0NDcxXSBDUFU6IDAgUElEOiAzNjcgQ29tbTogd2VzdG9uIFRhaW50ZWQ6IEcgTwo1
LjEwLjAteW9jdG8tc3RhbmRhcmQrICMzMTIKWyAxMTIuNTc1MTQ5XSBDYWxsIHRyYWNlOgpbIDEx
Mi41Nzc2NjZdIGR1bXBfYmFja3RyYWNlKzB4MC8weDFiMApbIDExMi41ODEzNzNdIHNob3dfc3Rh
Y2srMHgxOC8weDcwClsgMTEyLjU4NDc0Nl0gZHVtcF9zdGFjaysweGQwLzB4MTJjClsgMTEyLjU4
ODIwMF0gc3dpb3RsYl90YmxfbWFwX3NpbmdsZSsweDIzNC8weDM2MApbIDExMi41OTI3ODFdIHhl
bl9zd2lvdGxiX21hcF9wYWdlKzB4ZTQvMHg0YzAKWyAxMTIuNTk3MDk1XSB4ZW5fc3dpb3RsYl9t
YXBfc2crMHg4NC8weDEyYwpbIDExMi42MDEyNDldIGRtYV9tYXBfc2dfYXR0cnMrMHg1NC8weDYw
ClsgMTEyLjYwNTEzOF0gdnNwMV9kdV9tYXBfc2crMHgzMC8weDYwClsgMTEyLjYwODg1MV0gcmNh
cl9kdV92c3BfbWFwX2ZiKzB4MTM0LzB4MTcwClsgMTEyLjYxMzA4Ml0gcmNhcl9kdV92c3BfcGxh
bmVfcHJlcGFyZV9mYisweDQ0LzB4NjQKWyAxMTIuNjE4MDA3XSBkcm1fYXRvbWljX2hlbHBlcl9w
cmVwYXJlX3BsYW5lcysweGFjLzB4MTYwClsgMTEyLjYyMzM2Ml0gZHJtX2F0b21pY19oZWxwZXJf
Y29tbWl0KzB4ODgvMHgzOTAKWyAxMTIuNjI4MDI5XSBkcm1fYXRvbWljX25vbmJsb2NraW5nX2Nv
bW1pdCsweDRjLzB4NjAKWyAxMTIuNjMzMDQzXSBkcm1fbW9kZV9hdG9taWNfaW9jdGwrMHg5YTgv
MHhiMGMKWyAxMTIuNjM3NTMyXSBkcm1faW9jdGxfa2VybmVsKzB4YzQvMHgxMWMKWyAxMTIuNjQx
NTA2XSBkcm1faW9jdGwrMHgyMWMvMHg0NjAKWyAxMTIuNjQ0OTY3XSBfX2FybTY0X3N5c19pb2N0
bCsweGE4LzB4ZjAKWyAxMTIuNjQ4OTM5XSBlbDBfc3ZjX2NvbW1vbi5jb25zdHByb3AuMCsweDc4
LzB4MWEwClsgMTEyLjY1Mzc3NV0gZG9fZWwwX3N2YysweDI0LzB4OTAKWyAxMTIuNjU3MTQ4XSBl
bDBfc3ZjKzB4MTQvMHgyMApbIDExMi42NjAyNTRdIGVsMF9zeW5jX2hhbmRsZXIrMHgxYTQvMHgx
YjAKWyAxMTIuNjY0MzE1XSBlbDBfc3luYysweDE3NC8weDE4MApbIDExMi42NjgxNDVdIHJjYXIt
ZmNwIGZlYTJmMDAwLmZjcDogc3dpb3RsYiBidWZmZXIgaXMgZnVsbCAoc3o6CjM2ODY0MDAgYnl0
ZXMpLCB0b3RhbCA2NTUzNiAoc2xvdHMpLCB1c2VkIDExMiAoc2xvdHMpCmBgYApUaGUgcHJvYmxl
bSBpcyBoYXBwZW5lZCBoZXJlOgpodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92NS4x
NC40L3NvdXJjZS9kcml2ZXJzL2dwdS9kcm0vcmNhci1kdS9yY2FyX2R1X3ZzcC5jI0wyMDIKClNn
dCB3YXMgY3JlYXRlZCBpbiBkbWFfZ2V0X3NndGFibGUoKSBieSBkbWFfY29tbW9uX2dldF9zZ3Rh
YmxlKCkgYW5kCmluY2x1ZGVzIGEgc2luZ2xlIHBhZ2UgY2h1bmsKYXMgc2hvd24gaGVyZToKaHR0
cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjUuMTQuNS9zb3VyY2Uva2VybmVsL2RtYS9v
cHNfaGVscGVycy5jI0wxOAoKQWZ0ZXIgY3JlYXRpbmcgYSBuZXcgc2d0LCB3ZSB0cmllZCB0byBt
YXAgdGhpcyBzZ3QgdGhyb3VnaCB2c3AxX2R1X21hcF9zZygpLgpJbnRlcm5hbGx5LCB2c3AxX2R1
X21hcF9zZygpIHVzaW5nIG9wcy0+bWFwX3NnIChlLmcKeGVuX3N3aW90bGJfbWFwX3NnKSB0byBw
ZXJmb3JtCm1hcHBpbmcuCgpJIHJlYWxpemVkIHRoYXQgcmVxdWlyZWQgc2VnbWVudCBpcyB0b28g
YmlnIHRvIGJlIGZpdHRlZCB0byBkZWZhdWx0CnN3aW90bGIgc2VnbWVudCBhbmQgY29uZGl0aW9u
Cmh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L2xhdGVzdC9zb3VyY2Uva2VybmVsL2Rt
YS9zd2lvdGxiLmMjTDQ3NAppcyBhbHdheXMgZmFsc2UuCgpJIGtub3cgdGhhdCBJIHVzZSBhIGxh
cmdlIGJ1ZmZlciwgYnV0IHdoeSBjYW4ndCBJIG1hcCB0aGlzIGJ1ZmZlciBpbiBvbmUgY2h1bms/
CgpUaGFua3MhCgrRgdGALCAxNSDRgdC10L3Rgi4gMjAyMSDQsy4g0LIgMTY6NTMsIENocmlzdG9w
aCBIZWxsd2lnIDxoY2hAbHN0LmRlPjoKPgo+IE9uIFdlZCwgU2VwIDE1LCAyMDIxIGF0IDAzOjQ5
OjUyUE0gKzAyMDAsIEphbiBCZXVsaWNoIHdyb3RlOgo+ID4gQnV0IHRoZSBxdWVzdGlvbiByZW1h
aW5zOiBXaHkgZG9lcyB0aGUgZnJhbWVidWZmZXIgbmVlZCB0byBiZSBtYXBwZWQKPiA+IGluIGEg
c2luZ2xlIGdpYW50IGNodW5rPwo+Cj4gTW9yZSBpbXBvcnRhbnRseTogaWYgeW91IHVzZSBkeW5h
bWljIGRtYSBtYXBwaW5ncyBmb3IgeW91ciBmcmFtZWJ1ZmZlcgo+IHlvdSdyZSBkb2luZyBzb21l
dGhpbmcgd3JvbmcuCgoKCi0tIApCZXN0IFJlZ2FyZHMsIFJvbWFuLgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVA
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
