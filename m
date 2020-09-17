Return-Path: <SRS0=xf59=C2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDE6C433E2
	for <iommu@archiver.kernel.org>; Thu, 17 Sep 2020 14:39:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE5E92223C
	for <iommu@archiver.kernel.org>; Thu, 17 Sep 2020 14:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GFTFOf9K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE5E92223C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7BC1120428;
	Thu, 17 Sep 2020 14:39:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VHwP7u5Kfn5a; Thu, 17 Sep 2020 14:39:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 686F320431;
	Thu, 17 Sep 2020 14:39:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F15FC0864;
	Thu, 17 Sep 2020 14:39:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E3A3C0051
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 14:39:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 49F88877BF
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 14:39:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9Bqy5UwHmBVk for <iommu@lists.linux-foundation.org>;
 Thu, 17 Sep 2020 14:39:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4FDF086A91
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 14:39:07 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id z4so2356335wrr.4
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 07:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=blq2eWz1TJY2NfaOXXK0EtWvwOCukS98JLYvKkk93sM=;
 b=GFTFOf9KQo9OYFZDXVIhEsIqyfD0L+/FflZiDJdF9RcHJ5dOvFWQzNepjcs7Ivc/ma
 QWd66lW5nQX7igMeeWoP1qZ61ZaEvQuOkN5I/O8d8sP+nemrwyPJETg9H7nPSP5rRuf0
 e5JebqaoNMJe8Uy9S/AutgpgQOycEmMXKtwlJX+xi7JV8+igu0AY+sAmYUNhi8hN36ui
 H1WDDLMZP1vYQSjlYBEuWqXwOHjA4+I4Dt7fueOmsgmQgq3AgKAA6nOinN/7Frj0gPfr
 sG5RYsh7UJEHIx/Y+JtEkzG/HmRUtBA2mp8PUlAJNxRN23FixjhML1gh1Fg5/Af1sAVs
 coTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=blq2eWz1TJY2NfaOXXK0EtWvwOCukS98JLYvKkk93sM=;
 b=Pk7OCPGjPQabzboYUGBQWjwinklJoxV5N2/BF5YxDCPZDLv7tU9Q9aVB/F19ZbS69d
 xQWfVZxXZ9yvC9Z+aSk0pW/GszOPYVuKydhWfOLQ3pHhS+w+79VSZul9CGMh/WIOv2k3
 OYrSf3x73q6MmHvu+rjq3K6Y45xDAV+p52IkHvQfh1ZzQo/TxjOynV4onGE7suSRbhyl
 vqRyn6qUa/hop6nPQ8Af66i2dzIHqiwns+c2Y68ylSyE5AvKEruPKv1bNXoVv0LdChmI
 VMvRVFl1layxSZF4zvRO8GRgoW80Y3VqxO4cck88vjLRVnpnI0A7EEHcIh358PnziWy3
 U5+Q==
X-Gm-Message-State: AOAM530VgL5ABmucWrhCBANlBWeyeo+V4TRUcAY1yv75gspfDIv8j3SD
 g6nJh+fcnd9uifFOW9kKW6CmGQ==
X-Google-Smtp-Source: ABdhPJwT7jNG6KNnNsiF2CoCm68Ve7JQv1AJXwjyTV/nuEqz1zbskGeAhcfQ5nK/wfDSAhXGLzRoww==
X-Received: by 2002:a5d:470f:: with SMTP id y15mr32317774wrq.420.1600353545804; 
 Thu, 17 Sep 2020 07:39:05 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id m10sm11033383wmi.9.2020.09.17.07.39.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 07:39:05 -0700 (PDT)
Date: Thu, 17 Sep 2020 16:38:46 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH RESEND v9 09/13] iommu/arm-smmu-v3: Seize private ASID
Message-ID: <20200917143846.GD134903@myrica>
References: <20200817171558.325917-1-jean-philippe@linaro.org>
 <20200817171558.325917-10-jean-philippe@linaro.org>
 <7a67022c-a33a-5ea1-1bfb-4154d83ca009@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7a67022c-a33a-5ea1-1bfb-4154d83ca009@redhat.com>
Cc: fenghua.yu@intel.com, will@kernel.org, catalin.marinas@arm.com,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org, zhangfei.gao@linaro.org,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
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

On Mon, Sep 07, 2020 at 06:41:11PM +0200, Auger Eric wrote:
> > +/*
> > + * Try to reserve this ASID in the SMMU. If it is in use, try to steal it from
> > + * the private entry. Careful here, we may be modifying the context tables of
> > + * another SMMU!
> Not sure I got what you meant by this comment.

That comment does need refreshing:

/*
 * Check if the CPU ASID is available on the SMMU side. If a private context
 * descriptor is using it, try to replace it.
 */

> > + */
> >  static struct arm_smmu_ctx_desc *
> >  arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
> >  {
> > +	int ret;
> > +	u32 new_asid;
> >  	struct arm_smmu_ctx_desc *cd;
> > +	struct arm_smmu_device *smmu;
> > +	struct arm_smmu_domain *smmu_domain;
> >  
> >  	cd = xa_load(&arm_smmu_asid_xa, asid);
> >  	if (!cd)
> > @@ -27,8 +36,31 @@ arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
> >  		return cd;
> >  	}
> >  
> > -	/* Ouch, ASID is already in use for a private cd. */
> > -	return ERR_PTR(-EBUSY);
> > +	smmu_domain = container_of(cd, struct arm_smmu_domain, s1_cfg.cd);
> > +	smmu = smmu_domain->smmu;
> > +
> > +	ret = xa_alloc(&arm_smmu_asid_xa, &new_asid, cd,
> > +		       XA_LIMIT(1, 1 << smmu->asid_bits), GFP_KERNEL);
> XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNEL)

Good catch

Thanks,
Jean

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
