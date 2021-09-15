Return-Path: <SRS0=KP5g=OF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C745AC433FE
	for <iommu@archiver.kernel.org>; Wed, 15 Sep 2021 22:27:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 653D261131
	for <iommu@archiver.kernel.org>; Wed, 15 Sep 2021 22:27:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 653D261131
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 21E4D406CB;
	Wed, 15 Sep 2021 22:27:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ATzENHAS407C; Wed, 15 Sep 2021 22:27:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0AF1C406CA;
	Wed, 15 Sep 2021 22:27:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA598C0011;
	Wed, 15 Sep 2021 22:27:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59615C000D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Sep 2021 22:27:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3A40540520
 for <iommu@lists.linux-foundation.org>; Wed, 15 Sep 2021 22:27:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jKXaYAMphJRo for <iommu@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 22:27:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 693F24010D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Sep 2021 22:27:19 +0000 (UTC)
Received: by mail-pg1-x52b.google.com with SMTP id k24so4202400pgh.8
 for <iommu@lists.linux-foundation.org>; Wed, 15 Sep 2021 15:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=Xjyd5hMkpqMPk7OhcHiCF4/y/tnGWYGZ0keB+odd2Ng=;
 b=PlXQITEvZmBc1n7tRBdgd+gUsoQd7z+WeqSbwCW0Y6fVI8yT/SQH/gZOWj1rEd5PGH
 swNw22KZC8xoIpuwIOQB0qBuBZBZVQWgdu04NyU6/ozEYdI57WYsUCIzwUwa/fXkskfb
 Alz/fQ0BjBNdtF+77mNK0GKHlJt/0rPr36QxGX+0/Gyr17UmSRlTyBf9gjrH2asTZyW/
 gBPr3uUgJJ/xedmcsnp7l2LPZ4ZTqdm51B1jx6lrUzYPnij2Wz8OZIQrhM6EroN8hPM3
 /F/NaGZD2ImE0QW0yTglhOgYeRTL9MoYcjhqUOgNuIyemHOGS5JDWeTfwft4goXa85x5
 gfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=Xjyd5hMkpqMPk7OhcHiCF4/y/tnGWYGZ0keB+odd2Ng=;
 b=RNa08tTcAaow2mY7G+XMOfsKLtc1qg2Pi5SZGJPaDiUMzMm7OR8oX/jNgeMhAJTY1C
 FxWAi7XRaoKvilZjl5zDkUNhpzTTz99y+Z8kaODWrdWpc7FiIjmN34ZzpQJdoGJlgAwU
 pQubyBrrlXsU3E3uJMoNqrIt0HoKveEsC3lnGvj3GxQ4oL/FLBM8VQTBEJzdtGvHYFhJ
 frxcRUlU176uLGyH2c4PyfzRaXOS3V3oiV+ud75GazxzGm6vNZn2H6PUwWjygY4r8VaK
 csivnFNghOgXjozZXxa1u+8YW72kqsRmmhTWL5VF6mqt8NWMfawCl4zLNKnir0rmRKjC
 vCmQ==
X-Gm-Message-State: AOAM5310dULEWGMYkaozGckErNGCrYZQl49EexZjx8BZAvzxLRHqqGJ7
 vlWgiraJPZgEXc/1xlu3O/I=
X-Google-Smtp-Source: ABdhPJw3biDmUuN9v1ueAp+vI6CP+EYWCLxdUEgAvtkkJ6srbsFEnvpRNyy9gQ4borOgaHrubiOtQg==
X-Received: by 2002:a63:555c:: with SMTP id f28mr1943370pgm.340.1631744838735; 
 Wed, 15 Sep 2021 15:27:18 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id m12sm556664pjv.29.2021.09.15.15.27.17
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 15 Sep 2021 15:27:18 -0700 (PDT)
Date: Wed, 15 Sep 2021 15:19:27 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v6 6/6] iommu/tegra-smmu: Add pagetable mappings to debugfs
Message-ID: <20210915221902.GA20845@Asurada-Nvidia>
References: <20210914013858.31192-1-nicoleotsuka@gmail.com>
 <20210914013858.31192-7-nicoleotsuka@gmail.com>
 <31501a62-3312-9f04-3bb8-790d0481746c@gmail.com>
 <20210914184933.GA32705@Asurada-Nvidia>
 <25d68aff-323a-df54-45f9-55b22f3089e0@gmail.com>
 <20210915043806.GA19185@Asurada-Nvidia>
 <a5a77169-8711-2983-d2cb-4b94061741b9@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a5a77169-8711-2983-d2cb-4b94061741b9@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, thierry.reding@gmail.com, linux-tegra@vger.kernel.org,
 will@kernel.org
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

T24gV2VkLCBTZXAgMTUsIDIwMjEgYXQgMDM6MDk6NDhQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+IDE1LjA5LjIwMjEgMDc6MzgsIE5pY29saW4gQ2hlbiDQv9C40YjQtdGCOgo+ID4g
T24gVHVlLCBTZXAgMTQsIDIwMjEgYXQgMTA6MjA6MzBQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+ID4+IDE0LjA5LjIwMjEgMjE6NDksIE5pY29saW4gQ2hlbiDQv9C40YjQtdGCOgo+
ID4+PiBPbiBUdWUsIFNlcCAxNCwgMjAyMSBhdCAwNDoyOToxNVBNICswMzAwLCBEbWl0cnkgT3Np
cGVua28gd3JvdGU6Cj4gPj4+PiAxNC4wOS4yMDIxIDA0OjM4LCBOaWNvbGluIENoZW4g0L/QuNGI
0LXRgjoKPiA+Pj4+PiArc3RhdGljIHVuc2lnbmVkIGxvbmcgcGRfcHRfaW5kZXhfaW92YSh1bnNp
Z25lZCBpbnQgcGRfaW5kZXgsIHVuc2lnbmVkIGludCBwdF9pbmRleCkKPiA+Pj4+PiArewo+ID4+
Pj4+ICsJcmV0dXJuICgoZG1hX2FkZHJfdClwZF9pbmRleCAmIChTTU1VX05VTV9QREUgLSAxKSkg
PDwgU01NVV9QREVfU0hJRlQgfAo+ID4+Pj4+ICsJICAgICAgICgoZG1hX2FkZHJfdClwdF9pbmRl
eCAmIChTTU1VX05VTV9QVEUgLSAxKSkgPDwgU01NVV9QVEVfU0hJRlQ7Cj4gPj4+Pj4gK30KPiA+
Pj4+Cj4gPj4+PiBXZSBrbm93IHRoYXQgSU9WQSBpcyBmaXhlZCB0byB1MzIgZm9yIHRoaXMgY29u
dHJvbGxlci4gQ2FuIHdlIGF2b2lkIGFsbAo+ID4+Pj4gdGhlc2UgZG1hX2FkZHJfdCBjYXN0aW5n
cz8gSXQgc2hvdWxkIG1ha2UgY29kZSBjbGVhbmVyIGEgdGFkLCBJTU8uCj4gPj4+Cj4gPj4+IFRl
Z3JhMjEwIGFjdHVhbGx5IHN1cHBvcnRzIDM0LWJpdCBJT1ZBLi4uCj4gPj4+Cj4gPj4KPiA+PiBJ
dCBkb2Vzbid0LiAzNC1iaXQgaXMgUEEsIDMyLWJpdCBpcyBWQS4KPiA+Pgo+ID4+IFF1b3RlIGZy
b20gVDIxMCBUUk06Cj4gPj4KPiA+PiAiVGhlIFNNTVUgaXMgYSBjZW50cmFsaXplZCB2aXJ0dWFs
LXRvLXBoeXNpY2FsIHRyYW5zbGF0aW9uIGZvciBNU1MuIEl0Cj4gPj4gbWFwcyBhIDMyLWJpdCB2
aXJ0dWFsIGFkZHJlc3MgdG8gYSAzNC1iaXQgcGh5c2ljYWwgYWRkcmVzcy4gSWYgdGhlCj4gPj4g
Y2xpZW50IGFkZHJlc3MgaXMgNDAgYml0cyB0aGVuIGJpdHMgMzk6MzIgYXJlIGlnbm9yZWQuIgo+
ID4gCj4gPiBJZiB5b3Ugc2Nyb2xsIGRvd24gYnkgYSBjb3VwbGUgb2Ygc2VjdGlvbnMsIHlvdSBj
YW4gc2VlIDM0LWJpdAo+ID4gdmlydHVhbCBhZGRyZXNzZXMgaW4gc2VjdGlvbiAxOC42LjEuMjsg
YW5kIGlmIGNoZWNraW5nIG9uZSBBU0lECj4gPiByZWdpc3RlciwgeW91IGNhbiBzZWUgaXQgbWVu
dGlvbiB0aGUgZXh0cmEgdHdvIGJpdHMgdmFbMzM6MzJdLgo+IAo+IFRoYW5rcyBmb3IgdGhlIHBv
aW50ZXIuIEl0IHNheXMgdGhhdCBvbmx5IGNlcnRhaW4gbWVtb3J5IGNsaWVudHMgYWxsb3cKPiB0
byBjb21iaW5lIDQgQVNJRHMgdG8gZm9ybSAzNGJpdCBWQSBzcGFjZS4gSW4gdGhpcyBjYXNlIHRo
ZSBQQSBzcGFjZSBpcwo+IHNwbGl0IGludG8gNEdCIGFyZWFzIGFuZCB0aGVyZSBhcmUgYWRkaXRp
b25hbCBiaXRmaWVsZHMgd2hpY2ggY29uZmlndXJlCj4gdGhlIEFTSUQgbWFwcGluZyBvZiBlYWNo
IDRHQiBhcmVhLiBTdGlsbCBlYWNoIEFTSUQgaXMgMzJiaXQuCgpUcnVlLgoKPiBUaGlzIGlzIHdo
YXQgVFJNIHNheXM6Cj4gCj4gIkZvciB0aGUgR1BVIGFuZCBvdGhlciBjbGllbnRzIHdpdGggMzQt
Yml0IGFkZHJlc3MgaW50ZXJmYWNlcywgdGhlIEFTSUQKPiByZWdpc3RlcnMgYXJlIGV4dGVuZGVk
IHRvIHBvaW50IHRvIGZvdXIgQVNJRHMuIFRoZSBTTU1VIHN1cHBvcnRzIDRHQiBvZgo+IHZpcnR1
YWwgYWRkcmVzcyBzcGFjZSBwZXIgQVNJRCwgc28gbWFwcGluZyBhZGRyWzMzOjMyXSBpbnRvIEFT
SURbMTowXQo+IGV4dGVuZHMgdGhlIHZpcnR1YWwgYWRkcmVzcyBzcGFjZSBvZiBhIGNsaWVudCB0
byAxNkdCLiIKPiAKPiA+IEhvd2V2ZXIsIHRoZSBkcml2ZXIgY3VycmVudGx5IHNldHMgaXRzIGdl
b21ldHJ5LmFwZXJ0dXJlX2VuZCB0bwo+ID4gMzItYml0LCBhbmQgd2UgY2FuIG9ubHkgZ2V0IDMy
LWJpdCBJT1ZBcyB1c2luZyBQREUgYW5kIFBURSBvbmx5LAo+ID4gc28gSSB0aGluayBpdCBzaG91
bGQgYmUgc2FmZSB0byByZW1vdmUgdGhlIGNhc3RpbmdzIGhlcmUuIEknbGwKPiA+IHdhaXQgZm9y
IGEgY291cGxlIG9mIGRheXMgYW5kIHNlZSBpZiB0aGVyZSdkIGJlIG90aGVyIGNvbW1lbnRzCj4g
PiBmb3IgbWUgdG8gYWRkcmVzcyBpbiBuZXh0IHZlcnNpb24uCj4gCj4gWW91IHdpbGwgbmVlZCB0
byByZWFkIHRoZSBzcGVjaWFsICJBU0lEIEFzc2lnbm1lbnQgUmVnaXN0ZXIiIHdoaWNoCj4gc3Vw
cG9ydHMgNCBzdWItQVNJRHMgdG8gdHJhbnNsYXRlIHRoZSBQQSBhZGRyZXNzIGludG8gdGhlIGFj
dHVhbCBWQS4gQnkKPiBkZWZhdWx0IGFsbCBjbGllbnRzIGFyZSBsaW1pdGVkIHRvIGEgc2luZ2xl
IEFTSUQgYW5kIHVwc3RyZWFtIGtlcm5lbAo+IGRvZXNuJ3Qgc3VwcG9ydCBwcm9ncmFtbWluZyBv
ZiAzNGJpdCBWQXMuIFNvIGRvZXNuJ3Qgd29ydGggdGhlIGVmZm9ydCB0bwo+IGZ1bGx5IHRyYW5z
bGF0ZSB0aGUgVkEsIElNTy4KClllYS4gSXQnZCBiZSBlYXNpZXIgdG8ganVzdCBzdGF5IGluIDMy
LWJpdC4gSSB3aWxsIHJlbW92ZSB0aG9zZQpjYXN0aW5ncyBpbiB0aGUgbmV4dCB2ZXJzaW9uLCB3
YWl0aW5nIGZvciBUaGllcnJ5IHRha2luZyBhIGxvb2sKYXQgdGhpcyB2NiBmaXJzdC4KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBs
aXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
