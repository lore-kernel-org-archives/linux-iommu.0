Return-Path: <SRS0=xT8t=45=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00A9C5ACBF
	for <iommu@archiver.kernel.org>; Thu, 12 Mar 2020 07:54:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4D36206B7
	for <iommu@archiver.kernel.org>; Thu, 12 Mar 2020 07:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EpWXmU25"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4D36206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7290989168;
	Thu, 12 Mar 2020 07:54:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Cj87vYFr+wrf; Thu, 12 Mar 2020 07:54:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C9A6E8852E;
	Thu, 12 Mar 2020 07:54:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC752C07FF;
	Thu, 12 Mar 2020 07:54:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 06AFDC0177
 for <iommu@lists.linux-foundation.org>; Thu, 12 Mar 2020 07:54:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E36E8889B7
 for <iommu@lists.linux-foundation.org>; Thu, 12 Mar 2020 07:54:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ltu-kwhQBc+e for <iommu@lists.linux-foundation.org>;
 Thu, 12 Mar 2020 07:54:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 141208852E
 for <iommu@lists.linux-foundation.org>; Thu, 12 Mar 2020 07:54:46 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id s14so6102145wrt.8
 for <iommu@lists.linux-foundation.org>; Thu, 12 Mar 2020 00:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=pr04BKgViz7j88JBgxuUWEhe3OvdyJ6JSxyYo6mbxRM=;
 b=EpWXmU25L0YGiiRM8vJA3DFaYTd2tQHV/7f1WBTrWn3S4r9BSEwymIHqNVZSw4dMvj
 iyFMVzICUPU+kCGh2X+TFBzft2lxPcpMbo2NwY076sG0P7S8cnI2qb5nx+YdVFbTNEKI
 Z7BthyeuRMPKwkqWfD4mJzybiJp3XzMU1lUrJoyP65Uc00FpC6n2iQcNwChNa9vNvld+
 k7pTldNv6wbqW9jcOZyltSbxgDfSmSCexv+/zHWUc0V2kqkQvsQi0AAyblBeXyXYdrQm
 tiByVIzqJB4Lcq46F6IOlGlYJts4l+kW8g962H+cWT1VTDfEKGKKH9N9Zr/wVINNVYVX
 QiYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pr04BKgViz7j88JBgxuUWEhe3OvdyJ6JSxyYo6mbxRM=;
 b=FsHlrI4HAtq+WqdwAPBzhy9P98xqZcB/4iyo0V9KKtmxEFgoyjT9FZUHtSSo9dnQCP
 70uRAS68wcA69kSAZYmNY8NdkmVPJ4qN+DOmACmDIWqHnmiONsevAl84veGKyEcdqV2v
 iwlXdEZEw2B69UPCRi5woj63jByOdh1XAWc/Hm0uagQfB+jIoyiFGVmkT1XnaagzDLnQ
 AblrXwAfdcyHH0XxKrC/q1d1iq0AWrLZ5ILrLlxJmVE9bnUjeRsjo2cAgdQxylXFZ+PZ
 qP95PNJ7PbM8XJUE/1kOSVCnriXnGLWquEx4ClAgHtqhjaY9+F/lXj3fxGqLUtOSv/Cw
 ROOw==
X-Gm-Message-State: ANhLgQ22hYz12CG8+CGR9gm5eXuDN57TkftsbjRG76oMV8vKi/oJzyun
 Dgvetb1+X4lyk+EctPLtpAbD9w==
X-Google-Smtp-Source: ADFU+vtT5PIgJyJgbHd5navhTh3TzppWQ7now/ZfW46dAJfhZnjJPv9XMBdkmY0dc+S4uOHKFCAEpQ==
X-Received: by 2002:a5d:474d:: with SMTP id o13mr9266723wrs.162.1583999684449; 
 Thu, 12 Mar 2020 00:54:44 -0700 (PDT)
Received: from myrica ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id f207sm12446498wme.9.2020.03.12.00.54.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 00:54:43 -0700 (PDT)
Date: Thu, 12 Mar 2020 08:54:36 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 08/11] iommu/vt-d: Use pci_ats_supported()
Message-ID: <20200312075436.GA568802@myrica>
References: <20200311124506.208376-1-jean-philippe@linaro.org>
 <20200311124506.208376-9-jean-philippe@linaro.org>
 <7019230c-3c56-e6db-6704-d73f23fa39b5@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7019230c-3c56-e6db-6704-d73f23fa39b5@linux.intel.com>
Cc: mark.rutland@arm.com, linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
 liviu.dudau@arm.com, guohanjun@huawei.com, frowand.list@gmail.com,
 corbet@lwn.net, will@kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org,
 devicetree@vger.kernel.org, robh+dt@kernel.org, bhelgaas@google.com,
 linux-arm-kernel@lists.infradead.org, dwmw2@infradead.org, rjw@rjwysocki.net,
 iommu@lists.linux-foundation.org, sudeep.holla@arm.com, robin.murphy@arm.com,
 amurray@thegoodpenguin.co.uk
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

Hi Baolu,

On Thu, Mar 12, 2020 at 09:44:16AM +0800, Lu Baolu wrote:
> Hi Jean,
> 
> On 2020/3/11 20:45, Jean-Philippe Brucker wrote:
> > The pci_ats_supported() function checks if a device supports ATS and is
> > allowed to use it.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> >   drivers/iommu/intel-iommu.c | 9 +++------
> >   1 file changed, 3 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> > index 6fa6de2b6ad5..17208280ef5c 100644
> > --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -1454,8 +1454,7 @@ static void iommu_enable_dev_iotlb(struct device_domain_info *info)
> >   	    !pci_reset_pri(pdev) && !pci_enable_pri(pdev, 32))
> >   		info->pri_enabled = 1;
> >   #endif
> > -	if (!pdev->untrusted && info->ats_supported &&
> > -	    pci_ats_page_aligned(pdev) &&
> > +	if (info->ats_supported && pci_ats_page_aligned(pdev) &&
> >   	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT)) {
> >   		info->ats_enabled = 1;
> >   		domain_update_iotlb(info->domain);
> > @@ -2611,10 +2610,8 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
> >   	if (dev && dev_is_pci(dev)) {
> >   		struct pci_dev *pdev = to_pci_dev(info->dev);
> > -		if (!pdev->untrusted &&
> > -		    !pci_ats_disabled() &&
> 
> The pci_ats_disabled() couldn't be replaced by pci_ats_supported(). Even
> pci_ats_supported() returns true, user still can disable it. Or move
> ats_disabled into pci_ats_supported()?

It is already there, but hidden behind the "if (!dev->ats_cap)":
pci_ats_init() only sets dev->ats_cap after checking that
pci_ats_disabled() returns false.

Thanks,
Jean

> 
> Best regards,
> baolu
> 
> > -		    ecap_dev_iotlb_support(iommu->ecap) &&
> > -		    pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ATS) &&
> > +		if (ecap_dev_iotlb_support(iommu->ecap) &&
> > +		    pci_ats_supported(pdev) &&
> >   		    dmar_find_matched_atsr_unit(pdev))
> >   			info->ats_supported = 1;
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
