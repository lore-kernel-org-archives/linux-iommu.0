Return-Path: <SRS0=En+E=3E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3555DC33CB1
	for <iommu@archiver.kernel.org>; Wed, 15 Jan 2020 07:57:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EECAE214AF
	for <iommu@archiver.kernel.org>; Wed, 15 Jan 2020 07:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i8ACrPmC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EECAE214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A964B2039E;
	Wed, 15 Jan 2020 07:57:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XTldLNbRpNUs; Wed, 15 Jan 2020 07:57:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id CB8F12010A;
	Wed, 15 Jan 2020 07:57:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9881AC18DD;
	Wed, 15 Jan 2020 07:57:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8027C077D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 07:57:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DE80686E88
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 07:57:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CEcuVah5wny7 for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jan 2020 07:57:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7E0BE86E2C
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 07:57:53 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id u2so16639640wmc.3
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jan 2020 23:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=6Ia3VncVrF7c3ZybtE0PPF5JK9Ck+5/tRhdE7y0iz1s=;
 b=i8ACrPmCSBs+LYW5GnsySs7+9Wv84u6t9RSSW45kj5ZeFcp32dD8ehSZC7Xt1/5Bqg
 h1DjGveoSyal45wtXHcZT12ieGr2xy/e8wo3G3CDUp4cnmrVk2dBMBHelGHp79Fony6U
 PzxYeHpAPCO7OJlHOgT9kJnoaQxA/TYufvx/R4aFz+DWsO6XAAmRO/6BrT+Ih8WgpQdu
 c6ekNSgZ6GiY2J08rJXJvTGQ1oEZ9kxZNs4IRe/nMDFb9UnQ9GcYUYMB+eaE+qqao7xg
 33CsbG7zAeSpBNRqs3YmXjFWPmjtHKVWEZJY7FefO2sA/OEizZXaufWIgyH59yrGNt8Q
 Yk/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6Ia3VncVrF7c3ZybtE0PPF5JK9Ck+5/tRhdE7y0iz1s=;
 b=EzSs+OQv8Ry6yO2TSBwpiNBs17VUKHZyiz+agY4RJMTcr7j/+pLcDDxpifxTh3D61K
 3EUMLaHQwkYcqvB81bhET23aASHgb5v/vGCoym0NUmllPkKYZKfY/G22EWVAfpidcqrt
 cui5HrNPS4N1AhMPpgfehAhUqzJWLC0IUeLVF9JSOEQ+io+bPxANvmrm/gVvOS7/isOi
 YhL79WsABPI0QYHdAjpe1m0M9DG4oDoRM1zGovP/lqvgE+IPeXmM4eSqimJHwgeVcTv3
 FLoNYl/BFMWD6uPaBvv+7v2MIsOSmOT3BBNeYqigc5Zb0fXnIleRcCHGn9elGV2I+P/R
 ep3A==
X-Gm-Message-State: APjAAAWVUMlF3fqDspEZWScEWnGn3Q+2iJRY9WaFjCj5wVie3ixWxVL9
 gYbNNPd48sLIAbTAWxkR25Amkw==
X-Google-Smtp-Source: APXvYqyNEYvahUX2hjnKrrpMAXYUfqqL20FGP88ce7WRH3XP7tUR3FPmbPiIfTuZpy5b/JjF1w/zZg==
X-Received: by 2002:a7b:cd07:: with SMTP id f7mr30916595wmj.37.1579075071790; 
 Tue, 14 Jan 2020 23:57:51 -0800 (PST)
Received: from myrica ([2001:171b:2266:ba60:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id h2sm23782648wrv.66.2020.01.14.23.57.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2020 23:57:51 -0800 (PST)
Date: Wed, 15 Jan 2020 08:57:46 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 13/13] iommu/arm-smmu-v3: Add support for PCI PASID
Message-ID: <20200115075746.GA32782@myrica>
References: <20191219163033.2608177-1-jean-philippe@linaro.org>
 <20191219163033.2608177-14-jean-philippe@linaro.org>
 <20200114124541.GE29222@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200114124541.GE29222@willie-the-truck>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 sudeep.holla@arm.com, rjw@rjwysocki.net, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org, guohanjun@huawei.com,
 bhelgaas@google.com, zhangfei.gao@linaro.org, robin.murphy@arm.com,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, Jan 14, 2020 at 12:45:42PM +0000, Will Deacon wrote:
> On Thu, Dec 19, 2019 at 05:30:33PM +0100, Jean-Philippe Brucker wrote:
> > Enable PASID for PCI devices that support it. Since the SSID tables are
> > allocated by arm_smmu_attach_dev(), PASID has to be enabled early enough.
> > arm_smmu_dev_feature_enable() would be too late, since by that time the
> 
> What is arm_smmu_dev_feature_enable()?

It's the implementation of the IOMMU op .dev_enable_feat(), which I'll add
later (called by a device driver to enable the SVA feature). I'll reword
this comment, since the only real requirement is enabling PASID before
ATS.

> >  static void arm_smmu_detach_dev(struct arm_smmu_master *master)
> >  {
> >  	unsigned long flags;
> > @@ -2852,13 +2899,16 @@ static int arm_smmu_add_device(struct device *dev)
> >  
> >  	master->ssid_bits = min(smmu->ssid_bits, fwspec->num_pasid_bits);
> >  
> > +	/* Note that PASID must be enabled before, and disabled after ATS */
> > +	arm_smmu_enable_pasid(master);
> 
> Is that part of the PCIe specs? If so, please can you add a citation to the
> comment?

Yes (PCIe 4.0r1.0 10.5.1.3 ATS Control register).

> Are there any other ordering requirements, i.e. with respect to enabling
> substreams at the SMMU? For example, can a speculative ATS request provide
> a PASID?

You recent fix bfff88ec1afe ("iommu/arm-smmu-v3: Rework enabling/disabling
of ATS for PCI masters") should prevent from speculative ATS requests.
More generally both ATS and SSID are enabled and disabled at the same time
in the SMMU, when toggling STE.V, so any request arriving before STE
enablement will be aborted regardless of SSID.

Thanks,
Jean

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
