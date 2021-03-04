Return-Path: <SRS0=KoUT=IC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B71C433DB
	for <iommu@archiver.kernel.org>; Thu,  4 Mar 2021 09:50:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6FB264F2D
	for <iommu@archiver.kernel.org>; Thu,  4 Mar 2021 09:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6FB264F2D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8484C84353;
	Thu,  4 Mar 2021 09:50:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C_TxAoNEBKss; Thu,  4 Mar 2021 09:50:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5DB9F83770;
	Thu,  4 Mar 2021 09:50:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C67CC000B;
	Thu,  4 Mar 2021 09:50:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A797EC0001
 for <iommu@lists.linux-foundation.org>; Thu,  4 Mar 2021 09:50:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9210D42FC4
 for <iommu@lists.linux-foundation.org>; Thu,  4 Mar 2021 09:50:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4GMl9RiaWRoW for <iommu@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 09:50:00 +0000 (UTC)
X-Greylist: delayed 14:41:58 by SQLgrey-1.8.0
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0D9174017F
 for <iommu@lists.linux-foundation.org>; Thu,  4 Mar 2021 09:49:59 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id a18so18682952wrc.13
 for <iommu@lists.linux-foundation.org>; Thu, 04 Mar 2021 01:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=iQerbh/hlkdrtsjN7CL+UDqe9kjn7+RgwXvAdE063Tw=;
 b=c1I+m/0DtFCg5CmzpYRMm65XG2djVckGjss/QdwbwALm2jelL+UcfSaOlKXASY2DFf
 8O7l1+7CFT5TntHXoE+osgboHAVci371/X+Qo9hR1VTwXxRaGzW78oKylgL4ZF8EqP+S
 JWnT0AW14TwIWZK/dJR1IFFmeMFA7IIJ+yRD88fK1onkRNqNGgxZ563tEk3qj4S7V0y6
 BiHCqu0Vf4ESb6a9dtNsXT57Q6X28Fp1sBU08nD36GWzxNFy2RUBGFYn+zT0Bf8h6vcX
 GawZr9AANuwyRlAQ8WM3BGRES39pOYipeDPR/+e+TdnTPreexow5BsnfGo+YRZFGZ3f0
 1hYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=iQerbh/hlkdrtsjN7CL+UDqe9kjn7+RgwXvAdE063Tw=;
 b=At18Bq/8A1ld4CRuTRlWe5Fm+Bc15/tOaytak4je7YpEtxW3gDXBBFzZdIrAvK6Oi/
 55038dV/cBwg1BQzPAGqhRz/Bn+ho3H4J2NGLqkjCz8M2e8+p1VLPMkvRCE+4YHPNiY0
 uE7cp12budjXrLBtsoQ5QaHUQelmKo2hf48RzOJeVA9ONXCK+rOpxGL8SPbRQRKN19TK
 jI9Y7SdVYV5zxg2qUo/GTi/r4MdMNNBD3qAaeOWbc8ItoNq+GGu3GxNxh7CyTI2EmkyQ
 rEXeL4rPY8M9ViuKqz9QEbga8dBOGO1+RxGtzhfZ8QZMYbGHNhY13Rumo6BOqe662/IS
 Azbg==
X-Gm-Message-State: AOAM532RUmg6XsPwJDMZK406btrUd3sH5E5sCj82eZmSt26d6pWkI96h
 KWpEEqoE4JHO80LdPJJvK2xbeg==
X-Google-Smtp-Source: ABdhPJwX2IuPcmlP6UueA7sCigE+XrV1z418UQSV521K63EqIq7GZyzJyAA/3mJXGPgiM+HaLZ2JWA==
X-Received: by 2002:adf:e4c7:: with SMTP id v7mr2996353wrm.245.1614851398265; 
 Thu, 04 Mar 2021 01:49:58 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id j16sm10609588wmi.2.2021.03.04.01.49.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Mar 2021 01:49:57 -0800 (PST)
Date: Thu, 4 Mar 2021 10:49:37 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [RFC PATCH 15/18] cgroup: Introduce ioasids controller
Message-ID: <YECtMZNqSgh7jkGP@myrica>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1614463286-97618-16-git-send-email-jacob.jun.pan@linux.intel.com>
 <YD+u3CXhwOi2LC+4@slm.duckdns.org>
 <20210303131726.7a8cb169@jacob-builder>
 <20210303160205.151d114e@jacob-builder>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210303160205.151d114e@jacob-builder>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Raj Ashok <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 iommu@lists.linux-foundation.org, Jason Gunthorpe <jgg@nvidia.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 cgroups@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
 David Woodhouse <dwmw2@infradead.org>
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

On Wed, Mar 03, 2021 at 04:02:05PM -0800, Jacob Pan wrote:
> Hi Jacob,
> 
> On Wed, 3 Mar 2021 13:17:26 -0800, Jacob Pan
> <jacob.jun.pan@linux.intel.com> wrote:
> 
> > Hi Tejun,
> > 
> > On Wed, 3 Mar 2021 10:44:28 -0500, Tejun Heo <tj@kernel.org> wrote:
> > 
> > > On Sat, Feb 27, 2021 at 02:01:23PM -0800, Jacob Pan wrote:  
> > > > IOASIDs are used to associate DMA requests with virtual address
> > > > spaces. They are a system-wide limited resource made available to the
> > > > userspace applications. Let it be VMs or user-space device drivers.
> > > > 
> > > > This RFC patch introduces a cgroup controller to address the following
> > > > problems:
> > > > 1. Some user applications exhaust all the available IOASIDs thus
> > > > depriving others of the same host.
> > > > 2. System admins need to provision VMs based on their needs for
> > > > IOASIDs, e.g. the number of VMs with assigned devices that perform
> > > > DMA requests with PASID.    
> > > 
> > > Please take a look at the proposed misc controller:
> > > 
> > >  http://lkml.kernel.org/r/20210302081705.1990283-2-vipinsh@google.com
> > > 
> > > Would that fit your bill?  
> > The interface definitely can be reused. But IOASID has a different
> > behavior in terms of migration and ownership checking. I guess SEV key
> > IDs are not tied to a process whereas IOASIDs are. Perhaps this can be
> > solved by adding
> > +	.can_attach	= ioasids_can_attach,
> > +	.cancel_attach	= ioasids_cancel_attach,
> > Let me give it a try and come back.
> > 
> While I am trying to fit the IOASIDs cgroup in to the misc cgroup proposal.
> I'd like to have a direction check on whether this idea of using cgroup for
> IOASID/PASID resource management is viable.

Yes, even for host SVA it would be good to have a cgroup. Currently the
number of shared address spaces is naturally limited by number of
processes, which can be controlled with rlimit and cgroup. But on Arm the
hardware limit on shared address spaces is 64k (number of ASIDs), easily
exhausted with the default PASID and PID limits. So a cgroup for managing
this resource is more than welcome.

It looks like your current implementation is very dependent on
IOASID_SET_TYPE_MM?  I'll need to do more reading about cgroup to see how
easily it can be adapted to host SVA which uses IOASID_SET_TYPE_NULL.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
