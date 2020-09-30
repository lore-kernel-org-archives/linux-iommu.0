Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20639C4727F
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 06:40:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A56F52076E
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 06:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdyYML4L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A56F52076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5E9E386792;
	Wed, 30 Sep 2020 06:40:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hjt3EqVQyy17; Wed, 30 Sep 2020 06:40:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B482D86760;
	Wed, 30 Sep 2020 06:40:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99B99C0889;
	Wed, 30 Sep 2020 06:40:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D5F4C0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 06:40:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 25C6085FB9
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 06:40:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vn5YocfYcebY for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 06:40:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
 [209.85.215.195])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6EA6186148
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 06:40:07 +0000 (UTC)
Received: by mail-pg1-f195.google.com with SMTP id d13so475043pgl.6
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 23:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=CuQL0DR3SznyNcaZUnBt+RDDBya3xXYL9URyxcOJ1YQ=;
 b=gdyYML4LIy0Pdw++JhCkK7u4U1wFZnA8uJbeuQA1lieBfwc2mWJTImgPa4okxwBwU+
 7Cpxg11IVNDt9c4MxpyzPsF9hkNa0mZKIuYUOauANppORHKXO6F7IM0ANyN8xFPbGJbY
 GDNTZYHcrsPEyjwtwGq8h0wLRZNrdy15dGdFGHa4MuPOzhEY/XSpH3yaHv1KTpJxajWe
 JIPS02rpuLzl2fohPPRlCImqKeYswcD7WvW8qh5cowrqufAoOLb8IEr+z9NcavRVYzYz
 GP4FsvYYyRim3Jw0EVz+AYp9R1xoP8VadFXh3Fk4VbC5COmQcn3YvD52NQHeI+73MnTl
 qFmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=CuQL0DR3SznyNcaZUnBt+RDDBya3xXYL9URyxcOJ1YQ=;
 b=oFInTEGiBghvrBcYhsEseyFPaknsEmuDR748/Kv8My80OkhhKupBuJFanGGj7rG3yI
 OYPk61AAZcjaigxbPSEZFyxAymVZBWTa1f6y3u5y0Kbxt1guZW/GpoWaDvEqE8XGbzVF
 eb58rIzZPncci49qqn1e5w4z+KjoYbHhYcVfjIcvgMAfxcaqLCYgi6uvrMQTTAKxOmAC
 k6WeRc2tJJCRp2ZjE9YpCxbytqOYw+oNCWv6KOx/kr5tbw5/laTvab8CUug0XbXDAlWi
 aNNuUzccFDfAY2WiOY4Q76pstuaFNdjyzKCWEG8zT2ppNmoTMNYlBZrbBDFlCoQ8p67e
 rTLg==
X-Gm-Message-State: AOAM530OIi4izmbrvZq+N8rpgtxFH++0v+FRdiM56kSbUKvNxjy8jCtz
 NItQzOmRQ1Mnk5eXAt1zE10=
X-Google-Smtp-Source: ABdhPJwMXyQIrNYgvg/rRxGeX/z84x0C4XNLbkL7O43oL1U271A5d0VsrXfDRcCHFORysZTBfTZ0oA==
X-Received: by 2002:a63:5b5c:: with SMTP id l28mr993289pgm.243.1601448007009; 
 Tue, 29 Sep 2020 23:40:07 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id v21sm905557pgl.39.2020.09.29.23.40.06
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 29 Sep 2020 23:40:06 -0700 (PDT)
Date: Tue, 29 Sep 2020 23:34:36 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v2 2/3] iommu/tegra-smmu: Rework .probe_device and
 .attach_dev
Message-ID: <20200930063435.GC16460@Asurada-Nvidia>
References: <20200930003013.31289-1-nicoleotsuka@gmail.com>
 <20200930003013.31289-3-nicoleotsuka@gmail.com>
 <db183fdf-d566-599a-94ff-cfab0e08aa7a@gmail.com>
 <931eb16b-4529-2c20-c696-c57a9138aded@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <931eb16b-4529-2c20-c696-c57a9138aded@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 krzk@kernel.org, jonathanh@nvidia.com, thierry.reding@gmail.com,
 linux-tegra@vger.kernel.org
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

T24gV2VkLCBTZXAgMzAsIDIwMjAgYXQgMDg6MjA6NTBBTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+IDMwLjA5LjIwMjAgMDg6MTAsIERtaXRyeSBPc2lwZW5rbyDQv9C40YjQtdGCOgo+
ID4gMzAuMDkuMjAyMCAwMzozMCwgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gPj4gIHN0YXRp
YyB2b2lkIHRlZ3JhX3NtbXVfcmVsZWFzZV9kZXZpY2Uoc3RydWN0IGRldmljZSAqZGV2KQo+ID4g
Cj4gPiBUaGUgdGVncmFfZ2V0X21lbW9yeV9jb250cm9sbGVyKCkgdXNlcyBvZl9maW5kX2Rldmlj
ZV9ieV9ub2RlKCksIGhlbmNlCj4gPiB0ZWdyYV9zbW11X3JlbGVhc2VfZGV2aWNlKCkgc2hvdWxk
IHB1dF9kZXZpY2UobWMpIGluIG9yZGVyIHRvIGJhbGFuY2UKPiA+IGJhY2sgdGhlIHJlZmNvdW50
aW5nLgo+ID4gCj4gCj4gQWN0dWFsbHksIHRoZSBwdXRfZGV2aWNlKG1jKSBzaG91bGQgYmUgcmln
aHQgYWZ0ZXIKPiB0ZWdyYV9nZXRfbWVtb3J5X2NvbnRyb2xsZXIoKSBpbiB0ZWdyYV9zbW11X3By
b2JlX2RldmljZSgpIGJlY2F1c2UgU01NVQo+IGlzIGEgcGFydCBvZiBNQywgaGVuY2UgTUMgY2Fu
J3QganVzdCBnbyBhd2F5LgoKSG1tLi5JIGZvdW5kIHRoYXQgdGhlcmUgaXMgbm8gcHV0X2Rldmlj
ZSgpIGNhbGwgaW4gdGVncmEyMC1kZXZmcmVxLgpTaG91bGQgd2UganVzdCBwdXRfZGV2aWNlKHBk
ZXYtPmRldikgaW4gdGVncmFfZ2V0X21lbW9yeV9jb250cm9sbGVyPwpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVA
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
