Return-Path: <SRS0=cHis=CZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D23FC433E2
	for <iommu@archiver.kernel.org>; Wed, 16 Sep 2020 14:11:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7341C22240
	for <iommu@archiver.kernel.org>; Wed, 16 Sep 2020 14:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hAS45VSz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7341C22240
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2B4DE86A47;
	Wed, 16 Sep 2020 14:11:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tZkrvyeMc-Ox; Wed, 16 Sep 2020 14:11:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A93FD869EF;
	Wed, 16 Sep 2020 14:11:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F5CEC0859;
	Wed, 16 Sep 2020 14:11:51 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 342D7C0051
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 14:11:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 07C3F272E0
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 14:11:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ry3N5GesbktP for <iommu@lists.linux-foundation.org>;
 Wed, 16 Sep 2020 14:11:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 by silver.osuosl.org (Postfix) with ESMTPS id B8AA12725F
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 14:11:48 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id w1so6459998edr.3
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 07:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=LlUrkn99PMIYQmVGLdB0+eN+QkGnfm38LGdCqXub4Ao=;
 b=hAS45VSzPObmCMHNxGfkG+NDKM1TzVnv7KNEr8vj9xy4MrtNPbVMnP3E+c0FUzYGVO
 wPqjGd58SjTgvD4ElwGMVTkJ/vQJgVksPrNujXbUCvaSYAR+nYUFKIv9GmdPmsAeTw1w
 SLEokVTwh41c06RWTQK8ga+0WnZtxqNFStmhRekL0xLKWTqn8cVn6iVyLbEJCK4D+afx
 gIcqGW5V3Meio++Xlq1PULg8xgNkm9FJhgcaQPYCFJl1o7cQZmddSIXGNjtX54ocOxnB
 XkpAgcnLOKialpbNRhtfkofkZ/QjghU36lEKLA39h4h8TVkfr6on/E7w7xYxDBzj+JkY
 +i2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=LlUrkn99PMIYQmVGLdB0+eN+QkGnfm38LGdCqXub4Ao=;
 b=I5RkpCilbLvD5dgLTir17RmTPhDsTbJvc/I63myJuw99hVgQUhBMILFvDnVxe823sD
 CFTnlcEUvjQbB4Yebe5EbBQIJevoOq0iZm1osrVl8wiS9Q9WZZE4MhUyppXuT+ABzLhJ
 z+04YL/zlSSPB0JLtriAA71t24YQ0tCTiIZ+cjCU3MV+VHp50eOciPTX2PI0LF0E37i+
 kO9EbqUxhWnWEZcbY2YW28oVJ7voEMVBUJrFlewsNWdeS7T0/vlf35Z4tKXteDWpqxsX
 2pPDrFdWt5D5SEr4bf73LXAorNu/ccM/+NK8kHyyTyBp8Icz7CwZ1wmKvCXKOeb4ly/L
 BK/w==
X-Gm-Message-State: AOAM530Jo0a2pz1Aza4GjbUQ31zvNM0njoCjE/g3PAdUSjKzBtXO26Dz
 VQhxLdpG3rJ8p56uM7Lmb1OgeA==
X-Google-Smtp-Source: ABdhPJxCXAJVT89OOq1cTZqdGdXIDr/MyyoQoJRJeCQxhnHcd7r64qYaYdWt6ztGRzTK/qlOZ2O25Q==
X-Received: by 2002:a05:6402:2c7:: with SMTP id
 b7mr28642771edx.125.1600265507151; 
 Wed, 16 Sep 2020 07:11:47 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id y25sm13933983edv.15.2020.09.16.07.11.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 07:11:46 -0700 (PDT)
Date: Wed, 16 Sep 2020 16:11:28 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v7 18/24] iommu/arm-smmu-v3: Add support for Hardware
 Translation Table Update
Message-ID: <20200916141128.GC5316@myrica>
References: <20200519175502.2504091-1-jean-philippe@linaro.org>
 <20200519175502.2504091-19-jean-philippe@linaro.org>
 <472fdcf6-f306-60bc-5813-4ad421ee03f2@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <472fdcf6-f306-60bc-5813-4ad421ee03f2@huawei.com>
Cc: devicetree@vger.kernel.org, kevin.tian@intel.com, will@kernel.org,
 fenghua.yu@intel.com, jgg@ziepe.ca, linux-pci@vger.kernel.org,
 christian.koenig@amd.com, hch@infradead.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, catalin.marinas@arm.com,
 zhangfei.gao@linaro.org, robin.murphy@arm.com, felix.kuehling@amd.com,
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

On Fri, Aug 28, 2020 at 05:28:22PM +0800, Zenghui Yu wrote:
> On 2020/5/20 1:54, Jean-Philippe Brucker wrote:
> > @@ -4454,6 +4470,12 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
> >   			smmu->features |= ARM_SMMU_FEAT_E2H;
> >   	}
> > +	if (reg & (IDR0_HA | IDR0_HD)) {
> > +		smmu->features |= ARM_SMMU_FEAT_HA;
> > +		if (reg & IDR0_HD)
> > +			smmu->features |= ARM_SMMU_FEAT_HD;
> > +	}
> > +
> 
> nitpick:
> 
> As per the IORT spec (DEN0049D, 3.1.1.2 SMMUv3 node, Table 10), the
> "HTTU Override" flag of the SMMUv3 node can override the value in
> SMMU_IDR0.HTTU. You may want to check this bit before selecting the
> {HA,HD} features and shout if there is a mismatch between firmware and
> the SMMU implementation. Just like how ARM_SMMU_FEAT_COHERENCY is
> selected.

Thanks for pointing this out, I didn't know about these flags but have
added them to the patch now.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
