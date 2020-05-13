Return-Path: <SRS0=oi3Z=63=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0947C2D0FA
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 10:03:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAA77206D6
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 10:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AYJ8yd5N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAA77206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 48CDE2076E;
	Wed, 13 May 2020 10:03:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Kog-a33xsioB; Wed, 13 May 2020 10:03:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1F0B5204A8;
	Wed, 13 May 2020 10:03:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F31E7C0178;
	Wed, 13 May 2020 10:03:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D45B9C016F
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 10:02:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C0A3E885B5
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 10:02:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tWU0l7FLyeUp for <iommu@lists.linux-foundation.org>;
 Wed, 13 May 2020 10:02:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 5D1ED884EF
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 10:02:57 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id d207so8508619wmd.0
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 03:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=m6npkSNSQsVCsMpMcC0lz1k4am3Pd5ep45Q5fu5Nptw=;
 b=AYJ8yd5N0EziUK34rRkqe3n2lzmslSv1/nfE+XR/DtpZRU8XpoyvW6pEuqqCirYFXb
 xFrebzvk8h2134/CD/HNPAsQm/b3oyUuY0GNWe1f/cdi/20gIXMGsrFdgNX6btOisC3A
 dgKrBY2KJ98UVkFdaZ7BJ6fCeTucEcTgqy3yd4bcPJ0BV4/x/RNswH2aeF1MqZ/n2NUE
 qOxnglQUTifg9rR+5NA0neYYjlmf39IbTS9Ot+hHbm9APZaxzB1GkokWz0/OTyx95RwW
 TBg22xIDAEOO8pobXPQX9Vm+1PhjpnT9XwhKAOnlYYWAuUfT/JcfZ5Fv568FuLSQVSzs
 qEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=m6npkSNSQsVCsMpMcC0lz1k4am3Pd5ep45Q5fu5Nptw=;
 b=RCSJBzd27h0VlaiokGgOb4zeBLo87bjd7U7qKqUXz+hbNA1RmhqaaiKrhvkbOSySgv
 BWZIurKB8ayOo3qC8wDt6abQ1YL3wW6Mun9tb3R2PHxyXozb0tY/H3dpIrqRwU+bXOHd
 UHtj3nAfUKw29HKXD5t1C8JoTLl5j1tqLq7noTZhOtgfBY4ZW35MphzOrJJO88Omn2MU
 qMjX+Qsp9tPljFem0xrBfF+5DJ0Pxjmix6d/x4hset1UG4UAB5Gp/oUtjaM0EApErogK
 1s0gHCkMpKtd/SduJE4/xX/5qQjM1o0ngeIQBYJHOFE0NYN0Tj4aNRmoEIs+SWURTsSa
 brDw==
X-Gm-Message-State: AGi0Puam1Qr/hd+tgMEazRdvStNYKQeSLOK/roCpKLGxFwzw/COWnaRH
 kT9L0tXioYQHJwxReWnpqZVu+w==
X-Google-Smtp-Source: APiQypJ0rQ7lzqYNr+yDzxDGOcMWgdTnjGTWl7ny9DhlK1VnGjq47izadjU9R0DB/xGz2lI8/ESxVA==
X-Received: by 2002:a1c:f211:: with SMTP id s17mr45903196wmc.168.1589364175644; 
 Wed, 13 May 2020 03:02:55 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id b2sm24029735wrm.30.2020.05.13.03.02.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 03:02:55 -0700 (PDT)
Date: Wed, 13 May 2020 12:02:45 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Don't reserve implementation defined
 register space
Message-ID: <20200513100245.GA214296@myrica>
References: <20200506174629.1504153-1-jean-philippe@linaro.org>
 <2c5b52c0-8be0-9c22-ed27-3a2acd2b570c@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2c5b52c0-8be0-9c22-ed27-3a2acd2b570c@arm.com>
Cc: iommu@lists.linux-foundation.org, will@kernel.org,
 linux-arm-kernel@lists.infradead.org, tuanphan@amperemail.onmicrosoft.com
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

On Mon, May 11, 2020 at 08:03:05PM +0100, Robin Murphy wrote:
> On 2020-05-06 6:46 pm, Jean-Philippe Brucker wrote:
> > Some SMMUv3 implementation embed the Perf Monitor Group Registers (PMCG)
> > inside the first 64kB region of the SMMU. Since PMCG are managed by a
> > separate driver, this layout causes resource reservation conflicts
> > during boot.
> > 
> > To avoid this conflict, only reserve the MMIO region we actually use:
> > the first 0xe0 bytes of page 0 and the first 0xd0 bytes of page 1.
> > Although devm_ioremap() still works on full pages under the hood, this
> > way we benefit from resource conflict checks.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> > A nicer (and hopefully working) solution to the problem dicussed here:
> > https://lore.kernel.org/linux-iommu/20200421155745.19815-1-jean-philippe@linaro.org/
> > ---
> >   drivers/iommu/arm-smmu-v3.c | 50 +++++++++++++++++++++++++++++++++----
> >   1 file changed, 45 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> > index 82508730feb7a1..fc85cdd5b62cca 100644
> > --- a/drivers/iommu/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm-smmu-v3.c
> > @@ -171,6 +171,9 @@
> >   #define ARM_SMMU_PRIQ_IRQ_CFG1		0xd8
> >   #define ARM_SMMU_PRIQ_IRQ_CFG2		0xdc
> > +#define ARM_SMMU_PAGE0_REG_SZ		0xe0
> > +#define ARM_SMMU_PAGE1_REG_SZ		0xd0
> 
> I wonder if we shouldn't still claim all the way up to 0xdff for good
> measure, since the IMP-DEF areas only start appearing beyond that.

Works for me, the 0xe0 limit was arbitrary. I'll set both reg sizes to
0xe00.

> > +
> >   /* Common MSI config fields */
> >   #define MSI_CFG0_ADDR_MASK		GENMASK_ULL(51, 2)
> >   #define MSI_CFG2_SH			GENMASK(5, 4)
> > @@ -628,6 +631,7 @@ struct arm_smmu_strtab_cfg {
> >   struct arm_smmu_device {
> >   	struct device			*dev;
> >   	void __iomem			*base;
> > +	void __iomem			*page1;
> >   #define ARM_SMMU_FEAT_2_LVL_STRTAB	(1 << 0)
> >   #define ARM_SMMU_FEAT_2_LVL_CDTAB	(1 << 1)
> > @@ -733,11 +737,14 @@ static struct arm_smmu_option_prop arm_smmu_options[] = {
> >   static inline void __iomem *arm_smmu_page1_fixup(unsigned long offset,
> >   						 struct arm_smmu_device *smmu)
> >   {
> > -	if ((offset > SZ_64K) &&
> > -	    (smmu->options & ARM_SMMU_OPT_PAGE0_REGS_ONLY))
> > -		offset -= SZ_64K;
> > +	void __iomem *base = smmu->base;
> > -	return smmu->base + offset;
> > +	if (offset > SZ_64K) {
> > +		offset -= SZ_64K;
> > +		if (smmu->page1)
> > +			base = smmu->page1;
> > +	}
> > +	return base + offset;
> >   }
> 
> Why not just assign page1 = base in the Cavium case and let this simply be:
> 
> 	if (offset > SZ_64K)
> 		return smmu->page1 + offset - SZ_64K;
> 	return smmu->base + offset;
> 
> Then it's only one step further to get rid of the fixup and use page1
> directly where relevant, but that could be a cleanup on top, since we
> probably want a minimal change here for the sake of backporting (I believe
> this deserves to go to stable, now that MMU-600 hardware is reaching the
> field and will go wonky otherwise).

Yes looks much better. As it is the SMMUv3 driver isn't really wrong, but
I'll still add a Fixes: tag to ease backporting.

> 
> >   static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
> > @@ -4021,6 +4028,28 @@ err_reset_pci_ops: __maybe_unused;
> >   	return err;
> >   }
> > +static void __iomem *arm_smmu_ioremap(struct device *dev,
> > +				      resource_size_t start,
> > +				      resource_size_t size)
> > +{
> > +	void __iomem *dest_ptr;
> > +	struct resource *res;
> > +
> > +	res = devm_request_mem_region(dev, start, size, dev_name(dev));
> > +	if (!res) {
> > +		dev_err(dev, "can't request SMMU region %pa\n", &start);
> > +		return IOMEM_ERR_PTR(-EINVAL);
> > +	}
> > +
> > +	dest_ptr = devm_ioremap(dev, start, size);
> > +	if (!dest_ptr) {
> > +		dev_err(dev, "ioremap failed for SMMU region %pR\n", res);
> > +		devm_release_mem_region(dev, start, size);
> > +		dest_ptr = IOMEM_ERR_PTR(-ENOMEM);
> > +	}
> > +	return dest_ptr;
> > +}
> 
> Would it be any less complicated to stick with devm_ioremap_resource() and
> fix up the resource itself for each call, rather than open-coding it?

Much better as well.

> > +
> >   static int arm_smmu_device_probe(struct platform_device *pdev)
> >   {
> >   	int irq, ret;
> > @@ -4056,10 +4085,21 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
> >   	}
> >   	ioaddr = res->start;
> > -	smmu->base = devm_ioremap_resource(dev, res);
> > +	/*
> > +	 * Only map what we need, because the IMPLEMENTATION DEFINED registers
> > +	 * may be used for the PMCGs, which are reserved by the PMU driver.
> > +	 */
> > +	smmu->base = arm_smmu_ioremap(dev, ioaddr, ARM_SMMU_PAGE0_REG_SZ);
> >   	if (IS_ERR(smmu->base))
> >   		return PTR_ERR(smmu->base);
> > +	if (arm_smmu_resource_size(smmu) > SZ_64K) {
> > +		smmu->page1 = arm_smmu_ioremap(dev, ioaddr + SZ_64K,
> > +					       ARM_SMMU_PAGE1_REG_SZ);
> > +		if (IS_ERR(smmu->page1))
> > +			return PTR_ERR(smmu->page1);
> > +	}
> 
> As above,
> 
> 	} else {
> 		smmu->page1 = smmu->base;
> 	}
> 
> Either way, those are just cleanliness nitpicks; I've no real objection to
> the patch in its current state. Getting MMU-600 systems un-broken at all is
> more important, there will always be time for cleanup :)

Thanks for the review, I'll test and resend.

Thanks,
Jean

> 
> Robin.
> 
> > +
> >   	/* Interrupt lines */
> >   	irq = platform_get_irq_byname_optional(pdev, "combined");
> > 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
