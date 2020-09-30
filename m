Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0868C4727C
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 05:50:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7294C2074B
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 05:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIcmcdsk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7294C2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DD4C1859EA;
	Wed, 30 Sep 2020 05:50:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k2CkdWnvBeOp; Wed, 30 Sep 2020 05:50:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7582185700;
	Wed, 30 Sep 2020 05:50:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59F04C0889;
	Wed, 30 Sep 2020 05:50:28 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 45575C0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 05:50:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 33E3D871AE
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 05:50:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qzSkwDA0nlIY for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 05:50:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
 [209.85.210.194])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A7B2E8708F
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 05:50:26 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id x123so400927pfc.7
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 22:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=KDJI1UdfvDBL6Dg4S57KOoqth3ucuI3HS03X3SOn/zY=;
 b=VIcmcdskQ86AfRy89+em/AsOvDdok8Z+IL0i4KLjiMwhMF7QDAYv2GtcenPvQ2mMdx
 JFx7ooYChVxbFy6b7zIyHOxkRiS1EH0vDUnAcwYhmrqSJ4+IuS9WGFqGqdfYF9X+NCGH
 EAZA1PcF1Ue2GxlWOIWAhWnyvAIGda7RiOz5GbHhJjgPZz3idbyMywGnK8Qf8hC/OSoK
 7pqn+e7IfY8D2KXS76PGtdpfZxyBPhsDAQPrYCkR75R2NWdRy33VVyZD/dIRSFwTUIc/
 ZXZPiebSHjBgOZTu8iNnAGmpOYJhVQ51em87vn3K6ADXNwtz0xhTo9HWY9PNPbL6sXjd
 1nrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=KDJI1UdfvDBL6Dg4S57KOoqth3ucuI3HS03X3SOn/zY=;
 b=YWpTRfiPxzgN4uuuaqIM2M/D3dlPRvCg+YVAr1eCF843hcKGx/A6FqzixaxLxK8LXC
 MXs1eibAZ8nbamlCLxqAAyLhfeTEFhlfSAAG83wdyGPnzv7MS5r5uVF6NACFtta3O1NS
 NoPB6x5uEgTk8z5AMvXqiFB56qGlIzjR7PRUtL2VFt0Qy5vr4bdMtwVv7nWQJzJhRVcT
 ct31z2XwvQKJetKXyiuOpS3Y2ceyTzVJ20N2KLkud2qBXeq2MaQdVu+D37t1NQTAH4yd
 54BuQHdpQHlLBQUotgNOUEX6l20PNOnF4Qrrl1jyG+zeleXjUoqo426oGuzfjAIvB3K1
 7dHA==
X-Gm-Message-State: AOAM531rkCJV/aViOI6J1gez+/OcrNylvWuZ3JVOBqHOTrOJTee1SYy6
 +zkh2DWn9OlbsBgq82znt58=
X-Google-Smtp-Source: ABdhPJz/L1MMK7NVUm1Vf+MPoZ/cbNAxRDW8TWSdQwxfslFWRQDLLzBAv75iqpbC41ReCW3RWdLh7A==
X-Received: by 2002:a63:161e:: with SMTP id w30mr873994pgl.255.1601445026190; 
 Tue, 29 Sep 2020 22:50:26 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id g206sm724587pfb.178.2020.09.29.22.50.25
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 29 Sep 2020 22:50:26 -0700 (PDT)
Date: Tue, 29 Sep 2020 22:44:55 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v2 1/3] memory: tegra: Add helper function
 tegra_get_memory_controller
Message-ID: <20200930054455.GF31821@Asurada-Nvidia>
References: <20200930003013.31289-1-nicoleotsuka@gmail.com>
 <20200930003013.31289-2-nicoleotsuka@gmail.com>
 <93803d8b-9863-e977-fa87-a03e877b095d@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <93803d8b-9863-e977-fa87-a03e877b095d@gmail.com>
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

T24gV2VkLCBTZXAgMzAsIDIwMjAgYXQgMDg6MTI6MTBBTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+IDMwLjA5LjIwMjAgMDM6MzAsIE5pY29saW4gQ2hlbiDQv9C40YjQtdGCOgo+IC4u
Lgo+ID4gIGludCB0ZWdyYV9tY193cml0ZV9lbWVtX2NvbmZpZ3VyYXRpb24oc3RydWN0IHRlZ3Jh
X21jICptYywgdW5zaWduZWQgbG9uZyByYXRlKTsKPiA+ICB1bnNpZ25lZCBpbnQgdGVncmFfbWNf
Z2V0X2VtZW1fZGV2aWNlX2NvdW50KHN0cnVjdCB0ZWdyYV9tYyAqbWMpOwo+ID4gK3N0cnVjdCB0
ZWdyYV9tYyAqdGVncmFfZ2V0X21lbW9yeV9jb250cm9sbGVyKHZvaWQpOwo+ID4gIAo+ID4gICNl
bmRpZiAvKiBfX1NPQ19URUdSQV9NQ19IX18gKi8KPiA+IAo+IAo+IFRoaXMgd2lsbCBjb25mbGlj
dCB3aXRoIHRoZSB0ZWdyYTIwLWRldmZyZXEgZHJpdmVyLCB5b3Ugc2hvdWxkIGNoYW5nZSBpdAo+
IGFzIHdlbGwuCgpXaWxsIHJlbW92ZSB0aGF0IGluIHYzLgoKVGhhbmtzCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21t
dUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
