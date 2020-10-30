Return-Path: <SRS0=LARK=EF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4D2C00A89
	for <iommu@archiver.kernel.org>; Fri, 30 Oct 2020 10:47:49 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6257B22202
	for <iommu@archiver.kernel.org>; Fri, 30 Oct 2020 10:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VFde5+mz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6257B22202
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BD7EF86303;
	Fri, 30 Oct 2020 10:47:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rbmXcYfzFQ51; Fri, 30 Oct 2020 10:47:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3AD4C860CD;
	Fri, 30 Oct 2020 10:47:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F3133C088B;
	Fri, 30 Oct 2020 10:47:44 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00F00C0051
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 10:47:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E93FF87388
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 10:47:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nXVua2Pf1w2v for <iommu@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 10:47:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E59EC8737C
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 10:47:42 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id y12so5927806wrp.6
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 03:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=jQiudrT92RoT4MnO8l4PixRWHyCh7YwN2t6t0NWCl8I=;
 b=VFde5+mzL3XrpwutQuptYgGfpVk1egIssR+s26ty3ekZpYibBDTiuQV5zFapNyE8xz
 6v3A8xMfNiFzLTb2cZNXwVhfFARk+bgSkdGbO1edAjpGrdx5RQU69IAKu6NNVcwyG0PF
 womXcacbz9uNGUZOOgJZcSMSXlgQGCd9OLAmd/A0MLaIjmlAyAXznwmASzALVIyF50wC
 84Aa6i3GxiZKW4MuYqFzR9Synue4zXdlcG6itsZ2CxWa7iREgT0xl/I6wTenPtbWqOAZ
 9u++nR0d94pEaUBIH7tjNuyvVXlbrmkmFI2i4mOunI1OiwJyZvA9yxzHRXONpj+854wX
 DXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=jQiudrT92RoT4MnO8l4PixRWHyCh7YwN2t6t0NWCl8I=;
 b=p0cIk6g2vtv/k5889D6wW8iETuCBZgNexXTc+d2E8nfloyVq+qhKJCpWNU9lw1omD/
 PjCjXtGYc819XHbsoZUEFJL7oeASQImbhJHFRCM7eIN4k2pDdlozRlS3BcGKU1P4UM5O
 9wMtJPeB3Wcm9VnIaWVEi7uXQh7129KQKIYbvkQslNTauh+UFstcEe9iBsaTfPa/VY7p
 hZsS6zIhcaNb8ejlxivk6yp1IfJ/d/pz2ZYm4l2iNPPbs0PuSX+4X2ZjgqszKVluSYDP
 C67eewhjWt6iW34kXUK3GDH8YT0MlaNmc5sebY66/noVODi+GHQbcWA/t0/t8rlRRShO
 SLPg==
X-Gm-Message-State: AOAM530supbzp+HarhTKF5SFGD02Fse/YhRBWgMq3ILdtZ3WlUQkN2cV
 PdbB3G2gWSO/BOrtgiPRPknTeg==
X-Google-Smtp-Source: ABdhPJxoOQE0u2uOynQXeMQt4bBcTiACvEfnnakK42gV/IE5dKn3Hyesd2ExbFDOliawRXDUP6bYow==
X-Received: by 2002:adf:df02:: with SMTP id y2mr2428311wrl.403.1604054861343; 
 Fri, 30 Oct 2020 03:47:41 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id y201sm4495303wmd.27.2020.10.30.03.47.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 03:47:40 -0700 (PDT)
Date: Fri, 30 Oct 2020 11:47:20 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH v6 2/5] iommu: Use bus iommu ops for aux related callback
Message-ID: <20201030104720.GA294997@myrica>
References: <20201030045809.957927-1-baolu.lu@linux.intel.com>
 <20201030045809.957927-3-baolu.lu@linux.intel.com>
 <MWHPR11MB1645D795F7851F5894CB58D88C150@MWHPR11MB1645.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MWHPR11MB1645D795F7851F5894CB58D88C150@MWHPR11MB1645.namprd11.prod.outlook.com>
Cc: "Jiang, Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>
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

On Fri, Oct 30, 2020 at 05:55:53AM +0000, Tian, Kevin wrote:
> > From: Lu Baolu <baolu.lu@linux.intel.com>
> > Sent: Friday, October 30, 2020 12:58 PM
> > 
> > The aux-domain apis were designed for macro driver where the subdevices
> > are created and used inside a device driver. Use the device's bus iommu
> > ops instead of that in iommu domain for various callbacks.
> 
> IIRC there are only two users on these apis. One is VFIO, and the other
> is on the ARM side (not checked in yet). Jean, can you help confirm 
> whether ARM-side usage still relies on aux apis even with this change?

No, I have something out of tree but no plan to upstream it anymore, and
the SMMUv2 implementation is out as well:

https://lore.kernel.org/linux-iommu/20200713173556.GC3815@jcrouse1-lnx.qualcomm.com/

> If no, possibly they can be removed completely?

No objection from me. They can be added back later (I still belive adding
PASID to the DMA API would be nice to have once more HW implements it).

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
