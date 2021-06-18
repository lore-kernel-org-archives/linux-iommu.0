Return-Path: <SRS0=sMz+=LM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8343C48BDF
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 09:18:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D728613CB
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 09:18:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D728613CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 723E882A29;
	Fri, 18 Jun 2021 09:18:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rJ5UJJvoxVlE; Fri, 18 Jun 2021 09:18:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7563C828D1;
	Fri, 18 Jun 2021 09:18:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4CBD1C000D;
	Fri, 18 Jun 2021 09:18:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EEEF0C000B
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 09:18:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DD21C60595
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 09:18:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iy1Ikk1DbANA for <iommu@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 09:18:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0CBB0600CB
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 09:18:29 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id d7so7775077edx.0
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 02:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=HRCq4fgN0aqqkE/8MiANC+rXlD39PnksNydgp1NHMj8=;
 b=aAUvntb9wvjm5kq0+mzAEZrxmcfn0Uq6awR26z3mwJ9WN1M1UjStHyT0vq8IcMR2EZ
 YxniL1472HHUuFHpCT4Db/CdB4znRz4U6otxHDqPVYY4PhZGWvbraoQiLsJuCHDa97IJ
 pAZAUDbKDzrRBTvSVZKktiKPq5qvcGKyS+O0va+boqerEOciWdv2r2f7C4hzYA84v6gY
 uSKEQ2lvdbsyFwYQAKuNzyCzIdc5SLkVvSfX/qfi2PpTE5ZwgTkkzNmyGR4CY5qpoAhU
 eza97I+5UquHK1GJTNy5RKMkp5vlkITwHBoqUozjghYNSwNUVDNig2XyJndsi03pl73M
 9Plg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=HRCq4fgN0aqqkE/8MiANC+rXlD39PnksNydgp1NHMj8=;
 b=jN66RrM+ww6irWEzxeF55P1tqodAvxSTtpD4Lb520GzA8YRGbslytdvDW6/CfPVu5j
 e/yq2w3aM7i2J3Eea4Xtep9BuEftT5kg1QMPkHM9ibjdk9ynOKxXqJDcbBgDHQOvPHfZ
 v38DBXTUAYN6oQmR1r/hAhCoTwtOu5sqqwXURu6zbZl0HqI+Njq3sHe7gjAwk1+JuL4f
 RTxlpVa7FhcrcaTXMSBlybtep+zRlEXKJfi3cXuZkbvT7EmGajFFcfMAZwcW3pUhcf8T
 EsseYjV5SgWZJEx9FJH/YlxbVLe+wEyNiFcKieRQEeSB8lFr9PI4cATk9mxjz5TPk6pV
 xLgA==
X-Gm-Message-State: AOAM533Wuhq4+QdpYn7SIB3NH3e1ZzKDa1TTlfNZUgBNrlbSPZMP1vTU
 YM5fW6yz5ORH8xIb6U1kE0XVmw==
X-Google-Smtp-Source: ABdhPJwkM7MFKtctHz8EhEAN6FWomn+q375ZFzmKixM6u9jPqqm7bxiCxZcxkEywq+sBmzBudXNXiw==
X-Received: by 2002:a05:6402:2714:: with SMTP id
 y20mr3735609edd.41.1624007908152; 
 Fri, 18 Jun 2021 02:18:28 -0700 (PDT)
Received: from myrica (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
 by smtp.gmail.com with ESMTPSA id u12sm788646eje.40.2021.06.18.02.18.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jun 2021 02:18:27 -0700 (PDT)
Date: Fri, 18 Jun 2021 11:18:08 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v4 4/6] iommu/dma: Pass address limit rather than size to
 iommu_setup_dma_ops()
Message-ID: <YMxk0Na2yuRNwPT7@myrica>
References: <20210610075130.67517-1-jean-philippe@linaro.org>
 <20210610075130.67517-5-jean-philippe@linaro.org>
 <6d139529-9539-fbe4-8f85-da39461047ba@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6d139529-9539-fbe4-8f85-da39461047ba@redhat.com>
Cc: kevin.tian@intel.com, mst@redhat.com, catalin.marinas@arm.com,
 sudeep.holla@arm.com, rjw@rjwysocki.net, robin.murphy@arm.com,
 virtualization@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, sebastien.boeuf@intel.com,
 guohanjun@huawei.com, will@kernel.org, dwmw2@infradead.org,
 linux-arm-kernel@lists.infradead.org, lenb@kernel.org
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

T24gV2VkLCBKdW4gMTYsIDIwMjEgYXQgMDU6Mjg6NTlQTSArMDIwMCwgRXJpYyBBdWdlciB3cm90
ZToKPiBIaSBKZWFuLAo+IAo+IE9uIDYvMTAvMjEgOTo1MSBBTSwgSmVhbi1QaGlsaXBwZSBCcnVj
a2VyIHdyb3RlOgo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvbW0vZG1hLW1hcHBpbmcuYyBi
L2FyY2gvYXJtNjQvbW0vZG1hLW1hcHBpbmcuYwo+ID4gaW5kZXggNGJmMWRkM2ViMDQxLi43YmQx
ZDIxOTkxNDEgMTAwNjQ0Cj4gPiAtLS0gYS9hcmNoL2FybTY0L21tL2RtYS1tYXBwaW5nLmMKPiA+
ICsrKyBiL2FyY2gvYXJtNjQvbW0vZG1hLW1hcHBpbmcuYwo+ID4gQEAgLTUwLDcgKzUwLDcgQEAg
dm9pZCBhcmNoX3NldHVwX2RtYV9vcHMoc3RydWN0IGRldmljZSAqZGV2LCB1NjQgZG1hX2Jhc2Us
IHU2NCBzaXplLAo+ID4gIAo+ID4gIAlkZXYtPmRtYV9jb2hlcmVudCA9IGNvaGVyZW50Owo+ID4g
IAlpZiAoaW9tbXUpCj4gPiAtCQlpb21tdV9zZXR1cF9kbWFfb3BzKGRldiwgZG1hX2Jhc2UsIHNp
emUpOwo+ID4gKwkJaW9tbXVfc2V0dXBfZG1hX29wcyhkZXYsIGRtYV9iYXNlLCBzaXplIC0gZG1h
X2Jhc2UgLSAxKTsKPiBJIGRvbid0IGdldMKgIHNpemUgLSBkbWFfYmFzZSAtIDE/CgpCZWNhdXNl
IGl0J3Mgd3JvbmcsIHNob3VsZCBiZSBkbWFfYmFzZSArIHNpemUgLSAxLiBUaGFua3MgZm9yIGNh
dGNoaW5nIGl0IQoKVGhhbmtzLApKZWFuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vaW9tbXU=
