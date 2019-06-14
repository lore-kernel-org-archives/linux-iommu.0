Return-Path: <SRS0=ZdmF=UN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCF5C31E44
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 11:36:08 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B22021473
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 11:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o6LPSm3Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B22021473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 57491109A;
	Fri, 14 Jun 2019 11:36:08 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5AA49F7C
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 11:36:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com
	[209.85.160.181])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id BB81787D
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 11:36:06 +0000 (UTC)
Received: by mail-qt1-f181.google.com with SMTP id h21so1963423qtn.13
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 04:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=iYWTfHNOGy0zCm7qjiECEcfyYn0UNGZv0fcAcGdSdgg=;
	b=o6LPSm3YPDMrL/3E2NtKGfuENLZmMWBdAt0M2fXDRjTnM/hpNZZD+gQx4nuzZRErRi
	OOXafc/BXwn0ssoqtMNrRgteXvsZ9xAn9QCgJjykO7RCluQFxU248dF6f0gsXfVgDHhP
	trxyZq65xhrp0csV+D/zOKyYqleu7RIq0madxSfNVQW1qIL/UK4qUV1OFM0dwJf4YXvR
	bI5jwS6oaZJ3+a3+myzITXwleNevb9W5SCrLkZM05SU8z3xCk3LixFOIvODGbEXUMe0Y
	Hbl5Q0UCcaVzqBAHmIEpHRa57mo6U0i5aO1uDLd2NJTI9uLJ1jQ8pufjjrNYqf7PyLNr
	KWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=iYWTfHNOGy0zCm7qjiECEcfyYn0UNGZv0fcAcGdSdgg=;
	b=iRz26JYWCWICzI1kNpW6DiE4MXFUSaA4qJChJgUSoPBFvTf1SFbSAvfCovoVujoRIy
	a/Bg3BZ/huM+bCeZ/Ls5KYff0Ub6OnExWN5fDgLriDDyNCnQDGjm/N7tediFtbEU9aNZ
	ZiiU/a9zy6zzqOavOUYUkV6ekOJp2LVaKM78I634ln327Hm0yf6oBkAA03DTf7s7Gv8K
	O0dZp43adElFDtZbWO/VqxGQmdNN0aRSthg6ESjTgTAcu2OIvcKo/LA8KTdU2Fa5A+kn
	PyS6H23SLGYZuvJmOIf7Oi28JLkWOlYIqQKQhVyhd8CHbHHWyxxCsVGTzsfC0rJMxjlH
	MQRA==
X-Gm-Message-State: APjAAAU1T2AlpgN3JowsIVE47Fv33UqEWHtsm0k27YVjMlrH1yFwQeOP
	TPcyekJM5VZokrMxoa0ghcGKWCP0qskKIZkjwHk=
X-Google-Smtp-Source: APXvYqw4LNT9mOOlCh6RRAJMYCnVol0xQsRuD2GZQqReLTW7gc+Qtdxocgbn/MDYypq5T/Qb1tgZsEIDbXySavtO6ts=
X-Received: by 2002:a05:6214:2b0:: with SMTP id
	m16mr7805135qvv.23.1560512165862; 
	Fri, 14 Jun 2019 04:36:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190614100928.9791-1-hch@lst.de>
In-Reply-To: <20190614100928.9791-1-hch@lst.de>
From: Greentime Hu <green.hu@gmail.com>
Date: Fri, 14 Jun 2019 19:35:29 +0800
Message-ID: <CAEbi=3dnZNfMeLeuf9Y-d0HxTe_v1F_45Tb_TZwaat_LJq66SQ@mail.gmail.com>
Subject: Re: [RFC] switch nds32 to use the generic remapping DMA allocator
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, Vincent Chen <deanbo422@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Q2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+IOaWvCAyMDE55bm0NuaciDE05pelIOmAseS6
lCDkuIvljYg2OjA55a+r6YGT77yaCj4KPiBIaSBHcmVlbnRpbWUgYW5kIFZpY2VudCwKPgo+IGNh
biB5b3UgdGFrZSBhIGxvb2sgYXQgdGhlICh1bnRlc3RlZCkgcGF0Y2ggYmVsb3c/ICBJdCBjb252
ZXJ0cyBuZHMzMgo+IHRvIHVzZSB0aGUgZ2VuZXJpYyByZW1hcHBpbmcgRE1BIGFsbG9jYXRvciwg
d2hpY2ggaXMgYWxzbyB1c2VkIGJ5Cj4gYXJtNjQgYW5kIGNza3kuCgpIaSBDaHJpc3RvcGgsCgpJ
dCBsb29rcyBnb29kIHRvIG1lLiBJIGp1c3QgdmVyaWZpZWQgaW4gbmRzMzIgcGxhdGZvcm0gYW5k
IGl0IHdvcmtzIGZpbmUuClNob3VsZCBJIHB1dCBpdCBpbiBteSBuZXh0LXRyZWUgb3IgeW91IHdp
bGwgcGljayBpdCB1cCBpbiB5b3VyIHRyZWU/IDopCgpUZXN0ZWQtYnk6IEdyZWVudGltZSBIdSA8
Z3JlZW50aW1lQGFuZGVzdGVjaC5jb20+ClJldmlld2VkLWJ5OiBHcmVlbnRpbWUgSHUgPGdyZWVu
dGltZUBhbmRlc3RlY2guY29tPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
aW9tbXU=
