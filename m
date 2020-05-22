Return-Path: <SRS0=4l6Q=7E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76900C433E2
	for <iommu@archiver.kernel.org>; Fri, 22 May 2020 10:18:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4078F206C3
	for <iommu@archiver.kernel.org>; Fri, 22 May 2020 10:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WVJ//CKH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4078F206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0D8BC878E2;
	Fri, 22 May 2020 10:18:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oIc-GPoEVxp7; Fri, 22 May 2020 10:18:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 646B087853;
	Fri, 22 May 2020 10:18:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4BDDEC0863;
	Fri, 22 May 2020 10:18:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 304A6C0176
 for <iommu@lists.linux-foundation.org>; Fri, 22 May 2020 10:18:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0CAE087D76
 for <iommu@lists.linux-foundation.org>; Fri, 22 May 2020 10:18:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fJSdhB74yU5z for <iommu@lists.linux-foundation.org>;
 Fri, 22 May 2020 10:18:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C92F887B5D
 for <iommu@lists.linux-foundation.org>; Fri, 22 May 2020 10:18:07 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id l11so9666759wru.0
 for <iommu@lists.linux-foundation.org>; Fri, 22 May 2020 03:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=rDNDKX0HkLYt94EgaC8KrXxbFTf0b5UZDhkhcEUmDsA=;
 b=WVJ//CKH4dmTBE0aqIBZXt0aAGFbLb2/HSsz+TTszSD504939LXSss4CoipdpB/CaP
 UYEC49gciPAa156HBkX3vD6agGFcawT7wJGuqinqgdldtVpJcnYlHy8kYO+4r5wUGW4N
 dybibnHmXgJPE6Yx//FGirSeVMwet4YQ4pqdD8PfOkmlAM9lkmxvRxK8W5pq10wP/QdV
 nPZKGtAyqCQjPtUOqPpWTpK7PWQ7g8PDTvbQ9eAr9/mGFFzSg02tY1TfCtIKZQykmP7N
 B8ikx09FYbHX1EDesimTPNwCJGF8URn5yiI0zH0eo0dpPE+4HsehFV61iZGVMleox6n1
 gTbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rDNDKX0HkLYt94EgaC8KrXxbFTf0b5UZDhkhcEUmDsA=;
 b=SXERmscPxVFVKZeqsS52WEuM4nSobvwCryixc685gZS+8xlxsSyurKeKhy3b/w9Ewq
 Pt8IrNsK3DPoR7k3pJphVQEu8CTBUmOKBWGGuzO/8hcPD0b0cUVlgHSyG39dcrORneRf
 5coxdTYMormnNImVpkdmb4oenG+3mw7MQZ4KFOJX33G41+Dq01lVOY7dLBUNx9h016qb
 RNKgi/rDBC5A7HgRg6/AMBUhRZKcZRwtv3gIax7lul93rwmUnCZwEqHE4mFv6HmKu8c/
 dxW8ZPGQ/CtQIpLi0x3lnXE2LoruNB0wvRn6pDOJMryN87biBBFpvKLyp5geD7YuLjBM
 2o+A==
X-Gm-Message-State: AOAM531mo33lPpq3Z2I09BuHi3tbP9wa0esFsyg6pUc9A2YKL74fux4s
 SYZICDIEnuwfP6hS7LT0c9YBZw==
X-Google-Smtp-Source: ABdhPJzB2HI5kI/EmFJDdYOUgVosMpdPIKY9IaspD/NoZu4lv6KFYPamr6Pcq0PBpjpQXhtZ+2g/kQ==
X-Received: by 2002:a5d:66c5:: with SMTP id k5mr2740621wrw.17.1590142686217;
 Fri, 22 May 2020 03:18:06 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id d126sm9765981wmd.32.2020.05.22.03.18.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 03:18:05 -0700 (PDT)
Date: Fri, 22 May 2020 12:17:55 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v7 13/24] iommu/arm-smmu-v3: Enable broadcast TLB
 maintenance
Message-ID: <20200522101755.GA3453945@myrica>
References: <20200519175502.2504091-1-jean-philippe@linaro.org>
 <20200519175502.2504091-14-jean-philippe@linaro.org>
 <20200521141730.GJ6608@willie-the-truck>
 <0c896ad27b43b2de554cf772f9453d0a@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0c896ad27b43b2de554cf772f9453d0a@kernel.org>
Cc: devicetree@vger.kernel.org, kevin.tian@intel.com, jgg@ziepe.ca,
 linux-pci@vger.kernel.org, robin.murphy@arm.com, fenghua.yu@intel.com,
 hch@infradead.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 zhangfei.gao@linaro.org, catalin.marinas@arm.com, felix.kuehling@amd.com,
 Will Deacon <will@kernel.org>, christian.koenig@amd.com,
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

[+Eric]

On Thu, May 21, 2020 at 03:38:35PM +0100, Marc Zyngier wrote:
> On 2020-05-21 15:17, Will Deacon wrote:
> > [+Marc]
> > 
> > On Tue, May 19, 2020 at 07:54:51PM +0200, Jean-Philippe Brucker wrote:
> > > The SMMUv3 can handle invalidation targeted at TLB entries with shared
> > > ASIDs. If the implementation supports broadcast TLB maintenance,
> > > enable it
> > > and keep track of it in a feature bit. The SMMU will then be
> > > affected by
> > > inner-shareable TLB invalidations from other agents.
> > > 
> > > A major side-effect of this change is that stage-2 translation
> > > contexts
> > > are now affected by all invalidations by VMID. VMIDs are all shared
> > > and
> > > the only ways to prevent over-invalidation, since the stage-2 page
> > > tables
> > > are not shared between CPU and SMMU, are to either disable BTM or
> > > allocate
> > > different VMIDs. This patch does not address the problem.
> > 
> > This sounds like a potential performance issue, particularly as we
> > expose
> > stage-2 contexts via VFIO directly.

Yes it's certainly going to affect SMMU performance, though I haven't
measured it. QEMU and kvmtool currently use stage-1 translations instead
of stage-2, so it won't be a problem until they start using nested
translation (and unless the SMMU only supports stage-2).

In the coming month I'd like to have a look at coordinating VMID
allocation between KVM and SMMU, for guest SVA. If the guest wants to
share page tables with the SMMU, the SMMU has to use the same VMIDs as the
VM to receive broadcast TLBI.

Similarly to patch 06 ("arm64: mm: Pin down ASIDs for sharing mm with
devices") the SMMU would request a VMID allocated by KVM, when setting up
a nesting VFIO container. One major downside is that the VMID is pinned
and cannot be recycled on rollover while it's being used for DMA.

I wonder if we could use this even when page tables aren't shared between
CPU and SMMU, to avoid splitting the VMID space.

> > Maybe we could reserve some portion
> > of
> > VMID space for the SMMU? Marc, what do you reckon?
> 
> Certainly doable when we have 16bits VMIDs. With smaller VMID spaces (like
> on
> v8.0), this is a bit more difficult (we do have pretty large v8.0 systems
> around).

It's only an issue if those systems have an SMMUv3 supporting DVM. With
any luck that doesn't exist?

> How many VMID bits are we talking about?

That's anyone's guess... One passed-through device per VM would halve the
VMID space. But the SMMU allocates one VMID for each device assigned to a
guest, not one per VM (well one per domain, or VFIO container, but I think
it boils down to one per device with QEMU). So with SR-IOV for example it
should be pretty easy to reach 256 VMIDs in the SMMU.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
