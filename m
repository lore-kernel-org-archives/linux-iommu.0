Return-Path: <SRS0=Fz8+=DJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C85C4363C
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 16:50:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D93820719
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 16:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZfXaFNF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D93820719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1A8E987396;
	Fri,  2 Oct 2020 16:50:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RozdxVyJ-Ics; Fri,  2 Oct 2020 16:50:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 338AB87393;
	Fri,  2 Oct 2020 16:50:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12DC3C016F;
	Fri,  2 Oct 2020 16:50:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B344DC0051
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 16:50:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A263186739
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 16:50:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8nIqnxnAg997 for <iommu@lists.linux-foundation.org>;
 Fri,  2 Oct 2020 16:50:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com
 [209.85.167.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D4E6A8672E
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 16:50:47 +0000 (UTC)
Received: by mail-lf1-f65.google.com with SMTP id m5so2666957lfp.7
 for <iommu@lists.linux-foundation.org>; Fri, 02 Oct 2020 09:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=QRWEjeEbuFdEUbHLrJcHri/+uwzAxhK+2VvSI2UEDUY=;
 b=aZfXaFNFroBLgaAQLsy9bCcVZYHecYX+qJBSoewHPNONlya3CL6UGG+l3t/X7D1nhT
 +g+B9tQUaN+nKVvtPHjpg0lIq9+XlztEm/llIJ2Ee21oIzC1xXIBt10Q9ItEFvnqpdvP
 QUgjlppMweEy9L/1fu9aPGoy3CExjEXTvEOMHbZxu/f2cOinLf8xrOnznbSJy2c8op+g
 YPMV/pT5nZ432svPxtEd/AOW6TPdCr6juyT5bdgLWTGE/kvrNrLis/3su45TQX7p6+r0
 /9gHwgELaFKt8Jhjf241q/MdEqmyxKwrNEBidGL4CXe/f7r3uf5iOPfGwkahi+n53/2A
 64/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QRWEjeEbuFdEUbHLrJcHri/+uwzAxhK+2VvSI2UEDUY=;
 b=uPieF/ewj3uHnIqJXln8QSzmAQ/i3cLb3KAkdzWp60xn8J1ft8txLiWysgwOtGPJVc
 b37Ns4AmreAL0TQaRzlXoVhU4xhjbHjx+OnCIIRm9nE0r/4dt+08epSq7jJoPvWNpQFY
 5HgT5cBL4qSXpCzLwyhnMjsX7Kn/P5r1KdqZJY9OgG2BTrnHCzilzcNYrqQU034Y/2q4
 9wtJ+tAtnUWgGQc14bJp5tXsdcwf2vdMIxAsCycLZYyv45eLsga3Z3AjbhxuJ5LbeStI
 T5qR2AH0nJDMUZY64JEG/l1zvbucqasLUk85doiERHWHzxU71c7dCI9P0UFBXERJEKmg
 LJFw==
X-Gm-Message-State: AOAM532HI5dOFN+LbgGWcgOwU90FJd9OKRpuxFeX5RPfMrZKv1Ywjcnb
 2IkpEQ/kvEpOrOJYe4OUu7s=
X-Google-Smtp-Source: ABdhPJxFVitdDoZ5WO/LmN/k/BoibzpVDviQVfLwO6sJ85oqa9Xnn6z8RhGV9+lrbA1hW3AAsHHHbQ==
X-Received: by 2002:ac2:548d:: with SMTP id t13mr1272540lfk.602.1601657445853; 
 Fri, 02 Oct 2020 09:50:45 -0700 (PDT)
Received: from [192.168.2.145] (109-252-91-252.nat.spd-mgts.ru.
 [109.252.91.252])
 by smtp.googlemail.com with ESMTPSA id u22sm316363lji.65.2020.10.02.09.50.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2020 09:50:45 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] iommu/tegra-smmu: Rework tegra_smmu_probe_device()
From: Dmitry Osipenko <digetx@gmail.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>, thierry.reding@gmail.com,
 joro@8bytes.org, Maxime Ripard <maxime@cerno.tech>
References: <20201002060807.32138-1-nicoleotsuka@gmail.com>
 <20201002060807.32138-3-nicoleotsuka@gmail.com>
 <99d322d0-efb5-8a34-ee83-b907b785ced3@gmail.com>
 <3ecfe9ae-fa32-8384-c912-4e17ff5fede7@gmail.com>
 <6018e1c5-9ddd-3e37-1d6b-3feb969a7474@gmail.com>
Message-ID: <1516a3e1-452f-6b40-ab34-4820c502c1c3@gmail.com>
Date: Fri, 2 Oct 2020 19:50:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6018e1c5-9ddd-3e37-1d6b-3feb969a7474@gmail.com>
Content-Language: en-US
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jonathanh@nvidia.com
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

MDIuMTAuMjAyMCAxOTozNywgRG1pdHJ5IE9zaXBlbmtvINC/0LjRiNC10YI6Cj4gMDIuMTAuMjAy
MCAxOTowMCwgRG1pdHJ5IE9zaXBlbmtvINC/0LjRiNC10YI6Cj4+IDAyLjEwLjIwMjAgMTg6MjMs
IERtaXRyeSBPc2lwZW5rbyDQv9C40YjQtdGCOgo+Pj4gMDIuMTAuMjAyMCAwOTowOCwgTmljb2xp
biBDaGVuINC/0LjRiNC10YI6Cj4+Pj4gVGhlbiB3aGVuIGEgY2xpZW50IGdldHMgcHJvYmVkLCBv
Zl9pb21tdV9jb25maWd1cmUoKSBpbgo+Pj4+IGlvbW11IGNvcmUgd2lsbCBzZWFyY2ggRFRCIGZv
ciBzd2dyb3VwIElEIGFuZCBjYWxsIC0+b2ZfeGxhdGUoKQo+Pj4+IHRvIHByZXBhcmUgYW4gZndz
cGVjLCBzaW1pbGFyIHRvIHRlZ3JhX3NtbXVfcHJvYmVfZGV2aWNlKCkgYW5kCj4+Pj4gdGVncmFf
c21tdV9jb25maWd1cmUoKS4gVGhlbiBpdCdsbCBjYWxsIHRlZ3JhX3NtbXVfcHJvYmVfZGV2aWNl
KCkKPj4+PiBhZ2FpbiwgYW5kIHRoaXMgdGltZSB3ZSBzaGFsbCByZXR1cm4gc21tdS0+aW9tbXUg
cG9pbnRlciBwcm9wZXJseS4KPj4+Cj4+PiBJIGRvbid0IHF1aXRlIHNlZSB3aGVyZSBJT01NVSBj
b3JlIGNhbGxzIG9mX3hsYXRlKCkuCj4+Pgo+Pj4gSGF2ZSB0cmllZCB0byBhdCBsZWFzdCBib290
LXRlc3QgdGhpcyBwYXRjaD8KPj4+Cj4+Cj4+IEkgZG9uJ3Qgc2VlIGhvdyBpdCBldmVyIGNvdWxk
IHdvcmsgYmVjYXVzZSBvZl94bGF0ZSgpIGlzIG9ubHkgaW52b2tlZCBmcm9tOgo+Pgo+PiBmc2xf
bWNfZG1hX2NvbmZpZ3VyZSgpLT5vZl9kbWFfY29uZmlndXJlX2lkKCktPm9mX2lvbW11X2NvbmZp
Z3VyZSgpCj4+Cj4+IExvb2tzIGxpa2UgdGhlIHRlZ3JhX3NtbXVfY29uZmlndXJlKCkgaXMgc3Rp
bGwgbmVlZGVkLgo+Pgo+PiBJIGRvbid0IGtub3cgaG93IHN1bjUwaSBkcml2ZXIgY291bGQgd29y
ayB0byBiZSBob25lc3QuIFNlZW1zIElPTU1VIGlzCj4+IGJyb2tlbiBvbiBzdW41MGksIGJ1dCBt
YXliZSBJJ20gbWlzc2luZyBzb21ldGhpbmcuCj4+Cj4+IEkgYWRkZWQgTWF4aW1lIFJpcGFyZCB0
byB0aGlzIHRocmVhZCwgd2hvIGlzIHRoZSBhdXRob3Igb2YgdGhlCj4+IHN1bjUwaS1pb21tdSBk
cml2ZXIuCj4+Cj4gCj4gQWN0dWFsbHksIEkgbm93IHNlZSB0aGF0IHRoZSBvdGhlciBJT01NVSBk
cml2ZXJzIChxY29tLCBleHlub3MsIGV0YykgZG8KPiB0aGUgc2FtZS4gU28gb2J2aW91c2x5IEkn
bSBtaXNzaW5nIHNvbWV0aGluZyBhbmQgaXQgc2hvdWxkIHdvcmsuLgo+IAoKT2theSwgc29tZWhv
dyBJIHdhcyBvYmxpdmlvdXMgdG8gdGhhdCBvZl9kbWFfY29uZmlndXJlKCkgaW52b2tlcwpvZl9k
bWFfY29uZmlndXJlX2lkKCkuIFNob3VsZCBiZSBnb29kIDopCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby9pb21tdQ==
