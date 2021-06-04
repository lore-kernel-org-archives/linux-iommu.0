Return-Path: <SRS0=eMD9=K6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B36C4708F
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 08:18:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BBCC6141D
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 08:18:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BBCC6141D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 660F182F49;
	Fri,  4 Jun 2021 08:18:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gdfEMoXfo3po; Fri,  4 Jun 2021 08:17:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1DDDB8430F;
	Fri,  4 Jun 2021 08:17:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0217EC000D;
	Fri,  4 Jun 2021 08:17:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F039EC0001
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 08:17:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C8E3140623
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 08:17:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0GMPhby2M1EA for <iommu@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 08:17:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D0F5840633
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 08:17:51 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id s6so10125281edu.10
 for <iommu@lists.linux-foundation.org>; Fri, 04 Jun 2021 01:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=pA6kOnUwGdLjT+HtkefvlY6EKpZPlfWYliJZeTH5cjY=;
 b=lFADnsF9UsFoaDLFuDiE3qR4lJMI7Y7rpbFv5JEXZif3sE9d8YQ/mNyYh0aRuRfBgk
 5vuz3z36rznFoGquR3uZXfm7ikUjs6XlkUKvlJV2j03J9kBfJ8xZe1cP2Jlbt6CicVlG
 e6xeysQ/9sIGQmaN2+m9Gkaa49FOBsaOdz0fTQ3Ot97KcMDbjRb+b7XEN7yuRYRqyrEA
 r2MzPj+49IDhlieo3n2onlDQdV2deXczTLFcvXtDY7kBNyyyTKmNWdlE5lqgEXSVyOrI
 SaRRQ36GmcrpO10KPkJuwT7MtAHtafCuhVx4/qlKo0csmuy3sTJNqqBN0EFyRtslVpda
 uY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pA6kOnUwGdLjT+HtkefvlY6EKpZPlfWYliJZeTH5cjY=;
 b=I2/iky6rIVSrABaeXvfUFoIBeVFb/WJXznRsq3h2As+LGET1WnZBRg+Mz4UQJz9BoC
 UUAoFp9lAMnmih850/qBEG3pi6addLtdE7piJo0QgGs/kv1EKUa466AW8S0OGGhbdhd7
 zP/Zex1NIn0U73px5iwHMnMw407PVLrGevO0EganlFiTEUoah93LYpxeOoelbDZu92+r
 VrEuk83NLbAJ8L0UJJcsmgK/of1LB6+3V23KctIVjHTTdWUNEiMhvdAFk75R906GVwSW
 gzip9v+fY8AkIlNxIfF6lpjBKTht/O3FQURDG7T3phvetHRbaynDdD/pjDVDvLi9QxRQ
 p9fQ==
X-Gm-Message-State: AOAM533pU0wjHoeqPHsFJuu3vZVZTVmMU2JeGyYHh7fJjofvEBL1NEB9
 /ggXxE3G0QVaUM4cSBelkdbWLw==
X-Google-Smtp-Source: ABdhPJw58GrIl0M//k4Pi6xFOWNDjtRp84dO52fgTzB2d60XpXUPnEoWEYtxwESxba+7iC/zDodKCQ==
X-Received: by 2002:aa7:d8d8:: with SMTP id k24mr3365926eds.253.1622794669861; 
 Fri, 04 Jun 2021 01:17:49 -0700 (PDT)
Received: from myrica (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
 by smtp.gmail.com with ESMTPSA id am5sm2465979ejc.28.2021.06.04.01.17.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jun 2021 01:17:49 -0700 (PDT)
Date: Fri, 4 Jun 2021 10:17:30 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <YLnhmgLVPJR7LJmk@myrica>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528200311.GP1002214@nvidia.com>
 <MWHPR11MB188685D57653827B566BF9B38C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210601202834.GR1002214@nvidia.com>
 <MWHPR11MB1886172080807517E92A8EF68C3D9@MWHPR11MB1886.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MWHPR11MB1886172080807517E92A8EF68C3D9@MWHPR11MB1886.namprd11.prod.outlook.com>
Cc: "Alex Williamson \(alex.williamson@redhat.com\)"
 <alex.williamson@redhat.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 David Gibson <david@gibson.dropbear.id.au>, Jason Gunthorpe <jgg@nvidia.com>,
 "Jiang, Dave" <dave.jiang@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 Jason Wang <jasowang@redhat.com>
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

On Wed, Jun 02, 2021 at 01:25:00AM +0000, Tian, Kevin wrote:
> > > This implies that VFIO_BOUND_IOASID will be extended to allow user
> > > specify a device label. This label will be recorded in /dev/iommu to
> > > serve per-device invalidation request from and report per-device
> > > fault data to the user.
> > 
> > I wonder which of the user providing a 64 bit cookie or the kernel
> > returning a small IDA is the best choice here? Both have merits
> > depending on what qemu needs..
> 
> Yes, either way can work. I don't have a strong preference. Jean?

I don't see an issue with either solution, maybe it will show up while
prototyping. First one uses IDs that do mean something for someone, and
userspace may inject faults slightly faster since it doesn't need an
ID->vRID lookup, so that's my preference.

> > > In addition, vPASID (if provided by user) will
> > > be also recorded in /dev/iommu so vPASID<->pPASID conversion
> > > is conducted properly. e.g. invalidation request from user carries
> > > a vPASID which must be converted into pPASID before calling iommu
> > > driver. Vice versa for raw fault data which carries pPASID while the
> > > user expects a vPASID.
> > 
> > I don't think the PASID should be returned at all. It should return
> > the IOASID number in the FD and/or a u64 cookie associated with that
> > IOASID. Userspace should figure out what the IOASID & device
> > combination means.
> 
> This is true for Intel. But what about ARM which has only one IOASID
> (pasid table) per device to represent all guest I/O page tables?

In that case vPASID = pPASID though. The vPASID allocated by the guest is
the same from the vIOMMU inval to the pIOMMU inval. I don't think host
kernel or userspace need to alter it.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
