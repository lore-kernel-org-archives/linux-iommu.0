Return-Path: <SRS0=48ym=4V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79E9C3F2D7
	for <iommu@archiver.kernel.org>; Wed,  4 Mar 2020 14:10:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB6B520848
	for <iommu@archiver.kernel.org>; Wed,  4 Mar 2020 14:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g8SWXvPT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB6B520848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8867A85E65;
	Wed,  4 Mar 2020 14:10:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XkMliAriVbqW; Wed,  4 Mar 2020 14:10:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B51DB84F90;
	Wed,  4 Mar 2020 14:09:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9C5E6C1AE2;
	Wed,  4 Mar 2020 14:09:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9429DC013E
 for <iommu@lists.linux-foundation.org>; Wed,  4 Mar 2020 14:09:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8123087A2F
 for <iommu@lists.linux-foundation.org>; Wed,  4 Mar 2020 14:09:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yut7f75a99XB for <iommu@lists.linux-foundation.org>;
 Wed,  4 Mar 2020 14:09:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9582787A12
 for <iommu@lists.linux-foundation.org>; Wed,  4 Mar 2020 14:09:49 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id y17so2566233wrn.6
 for <iommu@lists.linux-foundation.org>; Wed, 04 Mar 2020 06:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=EpXtvX1PfW3FZz13OtRHOjQvZ2fsaz2TnoP+n0E2ZUg=;
 b=g8SWXvPTyPZzLcsUAC4+i3gEYS7VjOjujoBVioj8kKYK73oXfKh+MAvo8mRWnu071C
 gxiMmhvSdwjKzrw34AWvhgikZX0Hrhz4jre0uVLyzI7CZYL/VDsf5gHJObclPdLagxZi
 s+6qEVWA3DXyXew+YkVb+rgAVC49YN8D3mPAbPfbz2b2vq1fO6ty0UB+H65pdv6FjJ6Y
 v3/70bPC/jxD75YgWO2V9B7pyWv0bv8SImmbScC8XftPtCDEBeJXHlj8SYkcVTIy6y7V
 32lZyBoyNgNFy1f0QHfB5NbM0+cCHEojMhPDvMZmAXMM6fqrb+f7yzzdQe1b3vIru/ak
 r5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=EpXtvX1PfW3FZz13OtRHOjQvZ2fsaz2TnoP+n0E2ZUg=;
 b=h/xYmBtPDHAEPZPlnGaoCblClIa+yHFxFXuaJHzK/ZQyb1g0fpwUi/5CUR/iJEEgCy
 Vm5NHtNtxSdU1VpQ/WO5GkR8mQZVTz2pdn1w68bwDzeFACFh/DwUS3MUXAutLhiU7NXZ
 TJbw9gSg+yqHhT2EVP3oErc/F7eeEXm90hufcZHHNjJRJIMQjoKodCvGLU3iHhODvtLU
 QEMMmMaO2wZ6SB/YkoU0hg1wnKUCU85exFu1eqHJaE1qcnbR+Dnoo47elBngx3PESPFF
 9qHdmyyqY0lIM9avo00cnWcE0p5whpj0+AEmaVKR0FT1uOLJne81WEyWKn3Axq9/WVAe
 tfAw==
X-Gm-Message-State: ANhLgQ1y6xmmLvkrfW04GCm6z15PtvwSC2nhggEwOkH2INktyZLTbYb0
 UGVr4lbq5UGhNp9zZ0dLsGlCcA==
X-Google-Smtp-Source: ADFU+vtZMIq6Jg8tdrdLMObmNELyKi8gzYZ2wKQ8Qt7PTkGgWzXVAaeuMwK7RkrXzELghSD1BcL3DQ==
X-Received: by 2002:adf:e542:: with SMTP id z2mr4532686wrm.150.1583330987727; 
 Wed, 04 Mar 2020 06:09:47 -0800 (PST)
Received: from myrica ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id q12sm41792293wrg.71.2020.03.04.06.09.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2020 06:09:46 -0800 (PST)
Date: Wed, 4 Mar 2020 15:09:40 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Xu Zaibo <xuzaibo@huawei.com>
Subject: Re: [PATCH v4 23/26] iommu/arm-smmu-v3: Add stall support for
 platform devices
Message-ID: <20200304140940.GC646000@myrica>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
 <20200224182401.353359-24-jean-philippe@linaro.org>
 <db6fc8c2-2ff3-631f-2294-c1b49acd27aa@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <db6fc8c2-2ff3-631f-2294-c1b49acd27aa@huawei.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, kevin.tian@intel.com,
 will@kernel.org, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org, catalin.marinas@arm.com,
 zhangfei.gao@linaro.org, robin.murphy@arm.com, christian.koenig@amd.com,
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

On Wed, Feb 26, 2020 at 04:44:53PM +0800, Xu Zaibo wrote:
> Hi,
> 
> 
> On 2020/2/25 2:23, Jean-Philippe Brucker wrote:
> > From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> > 
> > The SMMU provides a Stall model for handling page faults in platform
> > devices. It is similar to PCI PRI, but doesn't require devices to have
> > their own translation cache. Instead, faulting transactions are parked and
> > the OS is given a chance to fix the page tables and retry the transaction.
> > 
> > Enable stall for devices that support it (opt-in by firmware). When an
> > event corresponds to a translation error, call the IOMMU fault handler. If
> > the fault is recoverable, it will call us back to terminate or continue
> > the stall.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> >   drivers/iommu/arm-smmu-v3.c | 271 ++++++++++++++++++++++++++++++++++--
> >   drivers/iommu/of_iommu.c    |   5 +-
> >   include/linux/iommu.h       |   2 +
> >   3 files changed, 269 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> > index 6a5987cce03f..da5dda5ba26a 100644
> > --- a/drivers/iommu/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm-smmu-v3.c
> > @@ -374,6 +374,13 @@
> >   #define CMDQ_PRI_1_GRPID		GENMASK_ULL(8, 0)
> >   #define CMDQ_PRI_1_RESP			GENMASK_ULL(13, 12)
> [...]
> > +static int arm_smmu_page_response(struct device *dev,
> > +				  struct iommu_fault_event *unused,
> > +				  struct iommu_page_response *resp)
> > +{
> > +	struct arm_smmu_cmdq_ent cmd = {0};
> > +	struct arm_smmu_master *master = dev_iommu_fwspec_get(dev)->iommu_priv;
> Here can use 'dev_to_master' ?

Certainly, good catch

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
