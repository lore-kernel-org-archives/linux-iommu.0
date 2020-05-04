Return-Path: <SRS0=OemM=6S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DEEC4725B
	for <iommu@archiver.kernel.org>; Mon,  4 May 2020 14:12:18 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFC862078E
	for <iommu@archiver.kernel.org>; Mon,  4 May 2020 14:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vq2ie4yP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC862078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8E34022EE7;
	Mon,  4 May 2020 14:12:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ygEGiJDHZ3Rz; Mon,  4 May 2020 14:12:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id F259420381;
	Mon,  4 May 2020 14:12:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3C82C088C;
	Mon,  4 May 2020 14:12:15 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13C59C0175
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 14:12:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 04B5C20430
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 14:12:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5woQ-nq0+X4e for <iommu@lists.linux-foundation.org>;
 Mon,  4 May 2020 14:12:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by silver.osuosl.org (Postfix) with ESMTPS id 6EF3B20381
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 14:12:13 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id g12so9213721wmh.3
 for <iommu@lists.linux-foundation.org>; Mon, 04 May 2020 07:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=cBYi8j74hWiNZr+qveo+/wt9+YdcPXbPEFJvXHtn9pk=;
 b=Vq2ie4yP/X47QYD6lxsDV5syeThtLJI2ewNwfJLRuRvqg9UoVTEgtYRgWLvaBdnVPa
 0wxiY2Klubhm0nN4CMoAjyALlAO50NfO102r/fy+H5GCSi63zznRgC0xu4L85wpV03xu
 DfhamtALWXxNYB9JgzXyAATJJmNT8UEf6XEH6k0T1kswbiEY71Yel0l1afn0RX60zeBH
 aqxDJDIPxXQSFKQhe8Dd/PnFMhfN2602ltmhdR00hWRbv/fHUel+9cX1FVpDN6rRaZVF
 s/UX7jAgy7BBd0Tzf4XpwroHU3tmThERIbg1xf8cdc1LjpguouxRX8TELXLyxcryX5LF
 R2oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=cBYi8j74hWiNZr+qveo+/wt9+YdcPXbPEFJvXHtn9pk=;
 b=SXZ0fV2ASOdzE6BgL3ZhqtZlu1VvO1zUnALfSI7zIuitPPmybz8KY7svWVLroccZq2
 eTBSAcZ4VWKppAk6RxKaMEqkEIdsiZwsmrC+pASUJVnYbpYjOQsIco6HZ3eZa1gMM09u
 ez8QH+j7OQ67aSAgkldRhqt6ity062nVlgHQJs6Uk5+ZU0dfsiANl+rRF+hI+ao0cumk
 w2isKFDBNwVkd5fOSlKLsiqTV/BosjQPMr7qB+N1oahSpL9f6Qiyc93Jt9P8l5EzWpzG
 2krQohcO3zEfzF8Brh/VyPq1f/7o5er0rA6lQ4tNVr2++2jCVZvD3bamq68jabDVvBMM
 dfqA==
X-Gm-Message-State: AGi0PuYgGzudheSGusnTdCtLAHtAMFd6ZWaV+3rjz9oCbdMdOXzLXwNp
 uKLf1aBgx8IWMowjYAjY8lpO4Q==
X-Google-Smtp-Source: APiQypJGsU7OdMfQlFADSEeYP/iyop6F2RgiIW4sMbSjpQ+r/TAhN3MWxBAEOgHp3eUgHcwFPiU/5w==
X-Received: by 2002:a05:600c:290f:: with SMTP id
 i15mr14075509wmd.167.1588601531837; 
 Mon, 04 May 2020 07:12:11 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id r23sm13017379wra.74.2020.05.04.07.11.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 07:11:52 -0700 (PDT)
Date: Mon, 4 May 2020 16:11:37 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH v6 11/25] iommu/arm-smmu-v3: Share process page tables
Message-ID: <20200504141137.GA170104@myrica>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
 <20200430143424.2787566-12-jean-philippe@linaro.org>
 <580a915f-f8bf-3b3e-c77d-6d0c2ea4bd02@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <580a915f-f8bf-3b3e-c77d-6d0c2ea4bd02@arm.com>
Cc: devicetree@vger.kernel.org, kevin.tian@intel.com, jgg@ziepe.ca,
 linux-pci@vger.kernel.org, robin.murphy@arm.com, fenghua.yu@intel.com,
 hch@infradead.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 zhangfei.gao@linaro.org, catalin.marinas@arm.com, felix.kuehling@amd.com,
 will@kernel.org, christian.koenig@amd.com,
 linux-arm-kernel@lists.infradead.org
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

On Thu, Apr 30, 2020 at 04:39:53PM +0100, Suzuki K Poulose wrote:
> On 04/30/2020 03:34 PM, Jean-Philippe Brucker wrote:
> > With Shared Virtual Addressing (SVA), we need to mirror CPU TTBR, TCR,
> > MAIR and ASIDs in SMMU contexts. Each SMMU has a single ASID space split
> > into two sets, shared and private. Shared ASIDs correspond to those
> > obtained from the arch ASID allocator, and private ASIDs are used for
> > "classic" map/unmap DMA.
> > 
> > Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> 
> > +
> > +	tcr = FIELD_PREP(CTXDESC_CD_0_TCR_T0SZ, 64ULL - VA_BITS) |
> > +	      FIELD_PREP(CTXDESC_CD_0_TCR_IRGN0, ARM_LPAE_TCR_RGN_WBWA) |
> > +	      FIELD_PREP(CTXDESC_CD_0_TCR_ORGN0, ARM_LPAE_TCR_RGN_WBWA) |
> > +	      FIELD_PREP(CTXDESC_CD_0_TCR_SH0, ARM_LPAE_TCR_SH_IS) |
> > +	      CTXDESC_CD_0_TCR_EPD1 | CTXDESC_CD_0_AA64;
> > +
> > +	switch (PAGE_SIZE) {
> > +	case SZ_4K:
> > +		tcr |= FIELD_PREP(CTXDESC_CD_0_TCR_TG0, ARM_LPAE_TCR_TG0_4K);
> > +		break;
> > +	case SZ_16K:
> > +		tcr |= FIELD_PREP(CTXDESC_CD_0_TCR_TG0, ARM_LPAE_TCR_TG0_16K);
> > +		break;
> > +	case SZ_64K:
> > +		tcr |= FIELD_PREP(CTXDESC_CD_0_TCR_TG0, ARM_LPAE_TCR_TG0_64K);
> > +		break;
> > +	default:
> > +		WARN_ON(1);
> > +		ret = -EINVAL;
> > +		goto err_free_asid;
> > +	}
> > +
> > +	reg = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
> > +	par = cpuid_feature_extract_unsigned_field(reg, ID_AA64MMFR0_PARANGE_SHIFT);
> > +	tcr |= FIELD_PREP(CTXDESC_CD_0_TCR_IPS, par);
> > +
> > +	cd->ttbr = virt_to_phys(mm->pgd);
> 
> Does the TTBR follow the same layout as TTBR_ELx for 52bit IPA ? i.e,
> TTBR[5:2] = BADDR[51:48] ? Are you covered for that ?

Good point, I don't remember checking this. The SMMU TTBR doesn't have the
same layout as the CPU's, and we don't need to swizzle the bits. For the
lower bits, the alignment requirements on the pgd are identical to the
MMU.

Thanks,
Jean

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
