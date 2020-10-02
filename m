Return-Path: <SRS0=Fz8+=DJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383D6C35257
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 17:51:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6ABB206DD
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 17:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iR4dVeX6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6ABB206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7A46D868E7;
	Fri,  2 Oct 2020 17:51:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UEeO0A0d7Jq7; Fri,  2 Oct 2020 17:51:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 19DF2868D3;
	Fri,  2 Oct 2020 17:51:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06ACDC0889;
	Fri,  2 Oct 2020 17:51:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2FDEC0051
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 17:51:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D20E2868D3
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 17:51:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YGalzPE11TqQ for <iommu@lists.linux-foundation.org>;
 Fri,  2 Oct 2020 17:51:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com
 [209.85.216.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2C41C868CE
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 17:51:32 +0000 (UTC)
Received: by mail-pj1-f68.google.com with SMTP id gm14so1321937pjb.2
 for <iommu@lists.linux-foundation.org>; Fri, 02 Oct 2020 10:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=PnAopDPoMZi0dRcrP3NcJfF5hKVlLOzrzm1DdVKLhR0=;
 b=iR4dVeX6+D3IklROSom59UJ0jVN/HSI9HYBhftutQ7t/p9Sc93B6dsD2bggivEaekj
 mdROrHJ32eSroJ+v72lDTgS95D15OBGgLQ0tlMbZ5SwUHmiY9T82W2hULzi03LF3XS4l
 re6HEUDChFGGoPbUCHHBDTJ6qS4JrZpd4k3KXJz7pT+CMEDI2kqlx92vtXXoBkG/OK/M
 18tVRTqtcSiTt/6rD9JfglugpC7jckj8Q/ZXmK33ZpnKSasV8z8EEPWsGxyyPOsRHYH6
 KnjClTRyFZo/0O50SDaqd7JsuP6JXk+sLbXIwYojiy3BNm+Y+Ig1EYYS8PcOsHgSJa/S
 YrHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=PnAopDPoMZi0dRcrP3NcJfF5hKVlLOzrzm1DdVKLhR0=;
 b=cQ9PwrlR7sxEkbBy7PlNsaaQVyVpujUf3msG1J2RVTiJrTbyZeNHnzw+fnDuj2Peqh
 JOoGRafaOs6VLiAUjsPlcGEHwaIQRhoaoxRaqy0m9waPgU0DXOrxwkDjKZ0FG0gdR7LO
 9rViVyVNl4f+FNij0MbhEgmOLe8H0Ed8VfQQOFdHFBOMe0hB9ZvzTsklMRVrKy8zuGqP
 fhQJ+E4siajIZczPaPnKey9J4lbWB/x9INn9NKv3Ne0bQw0gd/srzgCxRBIFzjMLmqi9
 KsMbu11EYFPYd6gSQQsbjhFqMy331eLDKcLBTL1mmZmYRMTBNpDPSm9vfg+Lvr9qMQHn
 5vig==
X-Gm-Message-State: AOAM5302mYQsh0pPFnmIJQvNVqHFYsgLCnPN6rnLwOW1Bey07QKxRm+u
 fbOxjtnLACqptRZrt16WQpE=
X-Google-Smtp-Source: ABdhPJwlv/hIGmASSyoKCV7NfPLJj/nUKPUI5UhUDO2/qVQbgPa0oKgv034ju05VtBMeh5p5Y/QqXA==
X-Received: by 2002:a17:90a:62c3:: with SMTP id
 k3mr3841487pjs.157.1601661091645; 
 Fri, 02 Oct 2020 10:51:31 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id x13sm2625375pfj.199.2020.10.02.10.51.31
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 02 Oct 2020 10:51:31 -0700 (PDT)
Date: Fri, 2 Oct 2020 10:45:32 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v4 3/3] iommu/tegra-smmu: Add PCI support
Message-ID: <20201002174532.GA29706@Asurada-Nvidia>
References: <20201002060807.32138-1-nicoleotsuka@gmail.com>
 <20201002060807.32138-4-nicoleotsuka@gmail.com>
 <eba0d5ff-dfb2-7c17-50c2-5709c506f62e@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <eba0d5ff-dfb2-7c17-50c2-5709c506f62e@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, thierry.reding@gmail.com, linux-tegra@vger.kernel.org
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

T24gRnJpLCBPY3QgMDIsIDIwMjAgYXQgMDU6MzU6MjRQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+IDAyLjEwLjIwMjAgMDk6MDgsIE5pY29saW4gQ2hlbiDQv9C40YjQtdGCOgo+ID4g
QEAgLTg2NSw3ICs4NjYsMTEgQEAgc3RhdGljIHN0cnVjdCBpb21tdV9ncm91cCAqdGVncmFfc21t
dV9kZXZpY2VfZ3JvdXAoc3RydWN0IGRldmljZSAqZGV2KQo+ID4gIAlncm91cC0+c21tdSA9IHNt
bXU7Cj4gPiAgCWdyb3VwLT5zb2MgPSBzb2M7Cj4gPiAgCj4gPiAtCWdyb3VwLT5ncm91cCA9IGlv
bW11X2dyb3VwX2FsbG9jKCk7Cj4gPiArCWlmIChkZXZfaXNfcGNpKGRldikpCj4gPiArCQlncm91
cC0+Z3JvdXAgPSBwY2lfZGV2aWNlX2dyb3VwKGRldik7Cj4gPiArCWVsc2UKPiA+ICsJCWdyb3Vw
LT5ncm91cCA9IGdlbmVyaWNfZGV2aWNlX2dyb3VwKGRldik7Cj4gPiArCj4gPiAgCWlmIChJU19F
UlIoZ3JvdXAtPmdyb3VwKSkgewo+ID4gIAkJZGV2bV9rZnJlZShzbW11LT5kZXYsIGdyb3VwKTsK
PiA+ICAJCW11dGV4X3VubG9jaygmc21tdS0+bG9jayk7Cj4gPiBAQCAtMTA2OSwyMiArMTA3NCwz
MiBAQCBzdHJ1Y3QgdGVncmFfc21tdSAqdGVncmFfc21tdV9wcm9iZShzdHJ1Y3QgZGV2aWNlICpk
ZXYsCj4gPiAgCWlvbW11X2RldmljZV9zZXRfZndub2RlKCZzbW11LT5pb21tdSwgZGV2LT5md25v
ZGUpOwo+ID4gIAo+ID4gIAllcnIgPSBpb21tdV9kZXZpY2VfcmVnaXN0ZXIoJnNtbXUtPmlvbW11
KTsKPiA+IC0JaWYgKGVycikgewo+ID4gLQkJaW9tbXVfZGV2aWNlX3N5c2ZzX3JlbW92ZSgmc21t
dS0+aW9tbXUpOwo+ID4gLQkJcmV0dXJuIEVSUl9QVFIoZXJyKTsKPiA+IC0JfQo+ID4gKwlpZiAo
ZXJyKQo+ID4gKwkJZ290byBlcnJfc3lzZnM7Cj4gPiAgCj4gPiAgCWVyciA9IGJ1c19zZXRfaW9t
bXUoJnBsYXRmb3JtX2J1c190eXBlLCAmdGVncmFfc21tdV9vcHMpOwo+ID4gLQlpZiAoZXJyIDwg
MCkgewo+ID4gLQkJaW9tbXVfZGV2aWNlX3VucmVnaXN0ZXIoJnNtbXUtPmlvbW11KTsKPiA+IC0J
CWlvbW11X2RldmljZV9zeXNmc19yZW1vdmUoJnNtbXUtPmlvbW11KTsKPiA+IC0JCXJldHVybiBF
UlJfUFRSKGVycik7Cj4gPiAtCX0KPiA+ICsJaWYgKGVyciA8IDApCj4gPiArCQlnb3RvIGVycl91
bnJlZ2lzdGVyOwo+ID4gKwo+ID4gKyNpZmRlZiBDT05GSUdfUENJCj4gPiArCWVyciA9IGJ1c19z
ZXRfaW9tbXUoJnBjaV9idXNfdHlwZSwgJnRlZ3JhX3NtbXVfb3BzKTsKPiA+ICsJaWYgKGVyciA8
IDApCj4gPiArCQlnb3RvIGVycl9idXNfc2V0Owo+ID4gKyNlbmRpZgo+ID4gIAo+ID4gIAlpZiAo
SVNfRU5BQkxFRChDT05GSUdfREVCVUdfRlMpKQo+ID4gIAkJdGVncmFfc21tdV9kZWJ1Z2ZzX2lu
aXQoc21tdSk7Cj4gPiAgCj4gPiAgCXJldHVybiBzbW11Owo+ID4gKwo+ID4gK2Vycl9idXNfc2V0
OiBfX21heWJlX3VudXNlZDsKPiAKPiBfX21heWJlX3VudXNlZD8KCkluIG9yZGVyIHRvIG11dGUg
YSBidWlsZCB3YXJuaW5nIHdoZW4gQ09ORklHX1BDST1uLi4uCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby9pb21tdQ==
