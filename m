Return-Path: <SRS0=Ppoz=A4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D16C433E5
	for <iommu@archiver.kernel.org>; Fri, 17 Jul 2020 09:09:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A05A5206F4
	for <iommu@archiver.kernel.org>; Fri, 17 Jul 2020 09:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LaZvUjdg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A05A5206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8882F86222;
	Fri, 17 Jul 2020 09:09:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mc8KilF7NNSq; Fri, 17 Jul 2020 09:09:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9115386224;
	Fri, 17 Jul 2020 09:09:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 780ABC07FF;
	Fri, 17 Jul 2020 09:09:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 411D4C0733
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jul 2020 09:09:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2FC228601B
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jul 2020 09:09:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8ju9eNmYTbCS for <iommu@lists.linux-foundation.org>;
 Fri, 17 Jul 2020 09:09:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
 [209.85.208.66])
 by whitealder.osuosl.org (Postfix) with ESMTPS id F3F7386018
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jul 2020 09:09:14 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id g20so7111925edm.4
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jul 2020 02:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=5hAp7/Ut6hK4YsA1k2zD1LY3Swf7sq8YHylKSXCzPJI=;
 b=LaZvUjdgoZgnkJNplfexj1+VySl/Bvb12VUGBJbdN9LkSfjRY0gSDagxsUKxtavwl5
 DSzVMGBRyg4xpS8GFJvxFhosd8bddV2YPKMkeXSIF8/E2ZAxdxxljL09VIJVYcRdKRgP
 gLHKv6Xq+V9ce7jucMxM8s30rLw8GUIGtJ3iNoDqb0HJ+0CsRkT4xp5/jBDYtGIweWBg
 Bwwqqhp11dQD2I4shX9GDTkA11VNRAjodljLnTCdSR7VYivTZbDljPpQ0sitVuAYUknO
 EnOYnw4D3KtJhh6Aw2JdVCN6eY7QaezKNk7xNcg5ioL2BvjOc6azurQ6eFwDhwv95ZrC
 0QCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=5hAp7/Ut6hK4YsA1k2zD1LY3Swf7sq8YHylKSXCzPJI=;
 b=qrb4+3DhUIQiRCHr7/SHgd4ftK3usHBDawvkDD6KHe71EgwqL9tSfXMSaDgx/X1w0q
 3waY4Lk7a3SWT7xC2V+pn3ANljMxEnFruT3WCOI9hLNwHGzlJsZyjlNpNX5eHKRGRdvB
 Nlu8LX89M2MLVOyjQ+UQ6dKRbkx1RqpkHKEFTupj2AL1Rt1yG1NFcMOMXL4llije2b5V
 sCxWSFsTRYMx3Gu9qI5L6iXHD6nhVYwkZw9pXA0FupaSL1wj2hah4tB2x5YxLfyFH1XC
 d8+5IhaU1wXBXMVwvHKqqHwS2WgyXS8jMCnYtZjoztZ0uOEWfprLuMEai6SExi0/8jt6
 dGPA==
X-Gm-Message-State: AOAM531hboQm8WBBYSvQCSRjtiorAHCOQrvSqyhPZoRa3VvKy0NVS+6U
 eVD5eMv/O6ju8+0JuSW+8xJrrw==
X-Google-Smtp-Source: ABdhPJxujtV7hysPeFOIoqKwGlmSd8lfEd8PTxDutsJIVtdPPbK+E0Gu8GwztgA2bbvp1ZvOpUskzQ==
X-Received: by 2002:a50:e8c8:: with SMTP id l8mr8512571edn.386.1594976953280; 
 Fri, 17 Jul 2020 02:09:13 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id b14sm7271529ejg.18.2020.07.17.02.09.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2020 02:09:12 -0700 (PDT)
Date: Fri, 17 Jul 2020 11:09:00 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v5 03/15] iommu/smmu: Report empty domain nesting info
Message-ID: <20200717090900.GC4850@myrica>
References: <1594552870-55687-1-git-send-email-yi.l.liu@intel.com>
 <1594552870-55687-4-git-send-email-yi.l.liu@intel.com>
 <20200713131454.GA2739@willie-the-truck>
 <CY4PR11MB1432226D0A52D099249E95A0C3610@CY4PR11MB1432.namprd11.prod.outlook.com>
 <20200716153959.GA447208@myrica>
 <f3779a69-0295-d668-5f2f-746b6ff2bdce@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f3779a69-0295-d668-5f2f-746b6ff2bdce@redhat.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "stefanha@gmail.com" <stefanha@gmail.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>, "Wu, Hao" <hao.wu@intel.com>,
 Will Deacon <will@kernel.org>, "Tian, Jun J" <jun.j.tian@intel.com>
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

On Thu, Jul 16, 2020 at 10:38:17PM +0200, Auger Eric wrote:
> Hi Jean,
> 
> On 7/16/20 5:39 PM, Jean-Philippe Brucker wrote:
> > On Tue, Jul 14, 2020 at 10:12:49AM +0000, Liu, Yi L wrote:
> >>> Have you verified that this doesn't break the existing usage of
> >>> DOMAIN_ATTR_NESTING in drivers/vfio/vfio_iommu_type1.c?
> >>
> >> I didn't have ARM machine on my hand. But I contacted with Jean
> >> Philippe, he confirmed no compiling issue. I didn't see any code
> >> getting DOMAIN_ATTR_NESTING attr in current drivers/vfio/vfio_iommu_type1.c.
> >> What I'm adding is to call iommu_domai_get_attr(, DOMAIN_ATTR_NESTIN)
> >> and won't fail if the iommu_domai_get_attr() returns 0. This patch
> >> returns an empty nesting info for DOMAIN_ATTR_NESTIN and return
> >> value is 0 if no error. So I guess it won't fail nesting for ARM.
> > 
> > I confirm that this series doesn't break the current support for
> > VFIO_IOMMU_TYPE1_NESTING with an SMMUv3. That said...
> > 
> > If the SMMU does not support stage-2 then there is a change in behavior
> > (untested): after the domain is silently switched to stage-1 by the SMMU
> > driver, VFIO will now query nesting info and obtain -ENODEV. Instead of
> > succeding as before, the VFIO ioctl will now fail. I believe that's a fix
> > rather than a regression, it should have been like this since the
> > beginning. No known userspace has been using VFIO_IOMMU_TYPE1_NESTING so
> > far, so I don't think it should be a concern.
> But as Yi mentioned ealier, in the current vfio code there is no
> DOMAIN_ATTR_NESTING query yet.

That's why something that would have succeeded before will now fail:
Before this series, if user asked for a VFIO_IOMMU_TYPE1_NESTING, it would
have succeeded even if the SMMU didn't support stage-2, as the driver
would have silently fallen back on stage-1 mappings (which work exactly
the same as stage-2-only since there was no nesting supported). After the
series, we do check for DOMAIN_ATTR_NESTING so if user asks for
VFIO_IOMMU_TYPE1_NESTING and the SMMU doesn't support stage-2, the ioctl
fails.

I believe it's a good fix and completely harmless, but wanted to make sure
no one objects because it's an ABI change.

Thanks,
Jean

> In my SMMUV3 nested stage series, I added
> such a query in vfio-pci.c to detect if I need to expose a fault region
> but I already test both the returned value and the output arg. So to me
> there is no issue with that change.
> > 
> > And if userspace queries the nesting properties using the new ABI
> > introduced in this patchset, it will obtain an empty struct. I think
> > that's acceptable, but it may be better to avoid adding the nesting cap if
> > @format is 0?
> agreed
> 
> Thanks
> 
> Eric
> > 
> > Thanks,
> > Jean
> > 
> >>
> >> @Eric, how about your opinion? your dual-stage vSMMU support may
> >> also share the vfio_iommu_type1.c code.
> >>
> >> Regards,
> >> Yi Liu
> >>
> >>> Will
> > 
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
