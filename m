Return-Path: <SRS0=qRzs=4A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0972C2BA83
	for <iommu@archiver.kernel.org>; Wed, 12 Feb 2020 03:24:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 835B120848
	for <iommu@archiver.kernel.org>; Wed, 12 Feb 2020 03:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="aiV+ED9Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 835B120848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4251D83335;
	Wed, 12 Feb 2020 03:24:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3Y8NiX6SbpkU; Wed, 12 Feb 2020 03:24:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1C6A8832C6;
	Wed, 12 Feb 2020 03:24:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F18A5C1D88;
	Wed, 12 Feb 2020 03:24:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0AE3DC07FE
 for <iommu@lists.linux-foundation.org>; Wed, 12 Feb 2020 03:24:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E549081496
 for <iommu@lists.linux-foundation.org>; Wed, 12 Feb 2020 03:24:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5m2g81SoVO2p for <iommu@lists.linux-foundation.org>;
 Wed, 12 Feb 2020 03:24:32 +0000 (UTC)
X-Greylist: delayed 00:06:56 by SQLgrey-1.7.6
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com
 [209.85.222.194])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 877878139D
 for <iommu@lists.linux-foundation.org>; Wed, 12 Feb 2020 03:24:32 +0000 (UTC)
Received: by mail-qk1-f194.google.com with SMTP id v2so760754qkj.2
 for <iommu@lists.linux-foundation.org>; Tue, 11 Feb 2020 19:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=endlessm-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HmaEf1+IzgDTd2NohFWTSwF80KzKrdWTMa26sPTwJ5Y=;
 b=aiV+ED9YuxrgIctP+Gmfy9AiBpHta4cG8Oc4XNILzWWqc7ZhnHMc9198wYzhNs9TOl
 0gso/0vld1zZsz0vrhFv/zyODhRFFUxjGEh2bTX9Um7BrD3O6ru6WYRpieneuvu1J2Gc
 8PC0NzZ1F9RjcQSBOCv6NZN81+S8A6pP5tCqkAXzDFKo52atUfpjwGQ5Zc8GUF9A/aFJ
 TP8YLItMNcXo4tIIZ+fZM+vaCPPuW/2nH47Zt4SV2vkQ47EVdxKyymLf9JYmreHaCCiM
 smyppg1LI35uXLsUtV89ZGvTmVjREZTgpJG2XJpqtPUw4IwH50wk1b0jFZA1ws1jo67n
 MGEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HmaEf1+IzgDTd2NohFWTSwF80KzKrdWTMa26sPTwJ5Y=;
 b=dBWSUTd3DBSJH4L0THqyIOXfH5VCnbUFEKUFL8wLePCnghIWxT2oce8Lo5ZGj7fkep
 0ZC+va2B1x2qt4dYOznXdH13fJRkpMjx04n/46kzijuSLRenrqS834KQRBMf/kyUdmbD
 hGVz4dBAfhDLw9WF+VO2C9/YGEo2wDEJsHyE8iy0zTlLGArrwnr9znxchA3PqgLL2crD
 0Db8mjx5a+o6Sn4mgSdipfjcXvs6NF1+vxpXFrccp9l1cZ3DLoIcZ/5MbUd72mp0Hbrk
 NJDYAoancMMHGrjYOIWrTuT/BvS35raj95/nxVzcpfFZgg/B24CjAxcWT1RMRanaNkuq
 QDkA==
X-Gm-Message-State: APjAAAXsz8Fb2hnYecvWDiWtCCLiHXfkQg34MmPtgSUF5GvxCR/dC3CH
 wh4smBir4VCNWRRX3BRQqXkQR9NCcWCCq1joou9/eIM4L50=
X-Google-Smtp-Source: APXvYqz+R3ThqP4ljbi4RSiZjmfYI2XhzA8qyoqjmelag/GF4joPHKxHEE7RR9DZhJ9fnibipF19dw1eAOdfre2ptYw=
X-Received: by 2002:a05:620a:12a5:: with SMTP id
 x5mr5659524qki.478.1581477455719; 
 Tue, 11 Feb 2020 19:17:35 -0800 (PST)
MIME-Version: 1.0
References: <20200211091352.12031-1-drake@endlessm.com>
 <bf9337f8c4336ee3bdb123ff381ec1330bdc8150.camel@intel.com>
In-Reply-To: <bf9337f8c4336ee3bdb123ff381ec1330bdc8150.camel@intel.com>
From: Daniel Drake <drake@endlessm.com>
Date: Wed, 12 Feb 2020 11:17:24 +0800
Message-ID: <CAD8Lp47c=fq6dpGSZx3YqGk_T0CZwZcywqcA4CqDmH13d8vQzQ@mail.gmail.com>
Subject: Re: [PATCH] iommu/vt-d: consider real PCI device when checking if
 mapping is needed
To: "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc: "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux@endlessm.com" <linux@endlessm.com>
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

On Wed, Feb 12, 2020 at 12:03 AM Derrick, Jonathan
<jonathan.derrick@intel.com> wrote:
> On Tue, 2020-02-11 at 17:13 +0800, Daniel Drake wrote:
> > The PCI devices handled by intel-iommu may have a DMA requester on
> > another bus, such as VMD subdevices needing to use the VMD endpoint.
> >
> > The real DMA device is now used for the DMA mapping, but one case was
> > missed earlier, when allocating memory through (e.g.) intel_map_page().
> > Confusion ensues if the iommu domain type for the subdevice does not match
> > the iommu domain type for the real DMA device.
> Is there a way to force this situation for my testing?

I think you could hack device_def_domain_type() to return
IOMMU_DOMAIN_IDENTITY for the real device, and IOMMU_DOMAIN_DMA for
the subdevice.

But I got curious as to why my subdevice might be IOMMU_DOMAIN_DMA, so
I checked, and found out that my assumptions weren't quite correct.
The subdevice has no iommu domain recorded at all. Before applying any
patches here, what's actually happening is:

1. Real DMA device gets registered with the iommu as
IOMMU_DOMAIN_IDENTITY using si_domain.
2. When the subdevice gets registered, the relevant code flow is
inside dmar_insert_one_dev_info():
 - it creates a new device_domain_info and domain->domain.type == IDENTITY, but
 - it then calls find_domain(dev) which successfully defers to the
real DMA device and returns the real DMA device's dmar_domain
 - since found != NULL (dmar_domain was found for this device) the
function bails out before setting dev->archdata.iommu

The results at this point are that the real DMA device is fully
registered as IOMMU_DOMAIN_IDENTITY using si_domain, but all of the
subdevices will always have dev->archdata.iommu == NULL.

Then when intel_map_page() is reached for the subdevice, it calls
iommu_need_mapping() for the subdevice.
This calls identity_mapping() on the subdevice, but that will always
return 0 because dev->archdata.iommu == NULL.
Following on from there, iommu_need_mapping() will then *always*
return true (mapping needed) for subdevices.

That will then lead to the situation described in my last mail, where
later down the allocation chain the request for creating a mapping
will be handed towards the real DMA dev, but that will then fail
because the real DMA dev is using IOMMU_DOMAIN_IDENTITY where no
mapping is needed.

Unless I missed anything that seems pretty clear to me now, and I
guess the only reason why you may not have already faced this in the
vmd case is if the real DMA device is not using IOMMU_DOMAIN_IDENTITY.
(To check this, you could log the value of the real dev
domain->domain.type in dmar_insert_one_dev_info(), and/or observe the
return value of identity_mapping() in iommu_need_mapping for the real
dev).

In any case it seems increasingly clear to me that
iommu_need_mapping() should be consulting the real DMA device in the
identity_mapping check, and your patch likewise solves the problem
faced here.

Thanks
Daniel
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
