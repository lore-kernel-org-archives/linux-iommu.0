Return-Path: <SRS0=uIbQ=ID=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FAAC433DB
	for <iommu@archiver.kernel.org>; Fri,  5 Mar 2021 08:31:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D11826501C
	for <iommu@archiver.kernel.org>; Fri,  5 Mar 2021 08:31:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D11826501C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8E1DD83FFD;
	Fri,  5 Mar 2021 08:31:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CrB9yKW93g40; Fri,  5 Mar 2021 08:31:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 41DE783F61;
	Fri,  5 Mar 2021 08:31:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1D1C2C000B;
	Fri,  5 Mar 2021 08:31:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E910CC0001
 for <iommu@lists.linux-foundation.org>; Fri,  5 Mar 2021 08:31:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CAA9843150
 for <iommu@lists.linux-foundation.org>; Fri,  5 Mar 2021 08:31:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nKBZiYQSm4Pv for <iommu@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 08:31:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A834C43095
 for <iommu@lists.linux-foundation.org>; Fri,  5 Mar 2021 08:31:12 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id d15so1125696wrv.5
 for <iommu@lists.linux-foundation.org>; Fri, 05 Mar 2021 00:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=XWbZV1xuaSmzet0/YcZif2T8HeoxQ88xDpPUR5wIaRM=;
 b=WDBYUW0qE+cgv+jlzpk/LkkEv5rrFExd/rNVN6CPNPszS2oiEe6l8WDOoPwMpJbJ9g
 ifcqD6jPV1lLiR4Yi/mjqfHszxBdJMcLo3KXRTXr9C02Sobabk+4owE0Z41bxe8ob0sf
 TXbIB7FE2gA0+Sjn4it3R8bHCBwJgU43j8xHmxrRaiGMOzXVU8OS4NipVF5fqrdwQXA2
 IIaotAllyZPnmz7mAt2JSTHTtIeJjXlLVUCSIhhKMkEA1E/BRRB28/j/UfjP/wIKBQS/
 GOSaXt0wygQ1kOygpUpLV5Q/GAhYxDax8i6p2F354NInZNYmwDxkG0X/3YVqPpdEXq1x
 imog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XWbZV1xuaSmzet0/YcZif2T8HeoxQ88xDpPUR5wIaRM=;
 b=DNhjKWxdrSNxw3OMp9zktT3gceCLNLyHE+ZUL4JRDcpYhBVqgUnvbdlAOvrEahKMC1
 p0KsAk2s+bGt/SaT17EV4e8YVT+od5hQnWWJ/26w8soNdvtEzhgN9bB2/0t6YrmPCgsL
 Hh1HVwOVihLiwdFXfVZy8TIjcoRAlhMvovs6hgqRdttJkCRUP4Kx53Q1D6R1o2R+dZUJ
 zRiQMDHgU9EK17R7e/vxg1b/LVqcPiTYzG3CZdSvosISWnE0VRmPuKNxkHzfzSkG2D+/
 glztQ8A+EUhSYO8yb+7z3rG/NGsM0VeozTC7fWHbKC93DGxEXpqLK0iiydf8iBhdeilP
 cpJw==
X-Gm-Message-State: AOAM530FbzkHrop+GCi8fqoAwC87z1zxbh6nJ1ZPQinqjDgnAL1fsZsC
 xofln5nWFHezKlegkPLQFwIXmw==
X-Google-Smtp-Source: ABdhPJzCbiuywdjtJ3FXU0Unm3zTVBYkDhWcAaYi2hSBAzjPryfkwbpNyTtMVd+8AZFWxtio6jLxmw==
X-Received: by 2002:adf:ded1:: with SMTP id i17mr8168897wrn.349.1614933070664; 
 Fri, 05 Mar 2021 00:31:10 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id w25sm3254177wmc.42.2021.03.05.00.31.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Mar 2021 00:31:10 -0800 (PST)
Date: Fri, 5 Mar 2021 09:30:49 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [RFC PATCH 15/18] cgroup: Introduce ioasids controller
Message-ID: <YEHsOR/XjDxQapE6@myrica>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1614463286-97618-16-git-send-email-jacob.jun.pan@linux.intel.com>
 <YD+u3CXhwOi2LC+4@slm.duckdns.org>
 <20210303131726.7a8cb169@jacob-builder>
 <20210303160205.151d114e@jacob-builder> <YECtMZNqSgh7jkGP@myrica>
 <20210304094603.4ab6c1c4@jacob-builder>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210304094603.4ab6c1c4@jacob-builder>
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

On Thu, Mar 04, 2021 at 09:46:03AM -0800, Jacob Pan wrote:
> Hi Jean-Philippe,
> 
> On Thu, 4 Mar 2021 10:49:37 +0100, Jean-Philippe Brucker
> <jean-philippe@linaro.org> wrote:
> 
> > On Wed, Mar 03, 2021 at 04:02:05PM -0800, Jacob Pan wrote:
> > > Hi Jacob,
> > > 
> > > On Wed, 3 Mar 2021 13:17:26 -0800, Jacob Pan
> > > <jacob.jun.pan@linux.intel.com> wrote:
> > >   
> > > > Hi Tejun,
> > > > 
> > > > On Wed, 3 Mar 2021 10:44:28 -0500, Tejun Heo <tj@kernel.org> wrote:
> > > >   
> > > > > On Sat, Feb 27, 2021 at 02:01:23PM -0800, Jacob Pan wrote:    
> > > > > > IOASIDs are used to associate DMA requests with virtual address
> > > > > > spaces. They are a system-wide limited resource made available to
> > > > > > the userspace applications. Let it be VMs or user-space device
> > > > > > drivers.
> > > > > > 
> > > > > > This RFC patch introduces a cgroup controller to address the
> > > > > > following problems:
> > > > > > 1. Some user applications exhaust all the available IOASIDs thus
> > > > > > depriving others of the same host.
> > > > > > 2. System admins need to provision VMs based on their needs for
> > > > > > IOASIDs, e.g. the number of VMs with assigned devices that perform
> > > > > > DMA requests with PASID.      
> > > > > 
> > > > > Please take a look at the proposed misc controller:
> > > > > 
> > > > >  http://lkml.kernel.org/r/20210302081705.1990283-2-vipinsh@google.com
> > > > > 
> > > > > Would that fit your bill?    
> > > > The interface definitely can be reused. But IOASID has a different
> > > > behavior in terms of migration and ownership checking. I guess SEV key
> > > > IDs are not tied to a process whereas IOASIDs are. Perhaps this can be
> > > > solved by adding
> > > > +	.can_attach	= ioasids_can_attach,
> > > > +	.cancel_attach	= ioasids_cancel_attach,
> > > > Let me give it a try and come back.
> > > >   
> > > While I am trying to fit the IOASIDs cgroup in to the misc cgroup
> > > proposal. I'd like to have a direction check on whether this idea of
> > > using cgroup for IOASID/PASID resource management is viable.  
> > 
> > Yes, even for host SVA it would be good to have a cgroup. Currently the
> > number of shared address spaces is naturally limited by number of
> > processes, which can be controlled with rlimit and cgroup. But on Arm the
> > hardware limit on shared address spaces is 64k (number of ASIDs), easily
> > exhausted with the default PASID and PID limits. So a cgroup for managing
> > this resource is more than welcome.
> > 
> > It looks like your current implementation is very dependent on
> > IOASID_SET_TYPE_MM?  I'll need to do more reading about cgroup to see how
> > easily it can be adapted to host SVA which uses IOASID_SET_TYPE_NULL.
> > 
> Right, I was assuming have three use cases of IOASIDs:
> 1. host supervisor SVA (not a concern, just one init_mm to bind)
> 2. host user SVA, either one IOASID per process or perhaps some private
> IOASID for private address space
> 3. VM use for guest SVA, each IOASID is bound to a guest process
> 
> My current cgroup proposal applies to #3 with IOASID_SET_TYPE_MM, which is
> allocated by the new /dev/ioasid interface.
> 
> For #2, I was thinking you can limit the host process via PIDs cgroup? i.e.
> limit fork.

That works but isn't perfect, because the hardware resource of shared
address spaces can be much lower that PID limit - 16k ASIDs on Arm. To
allow an admin to fairly distribute that resource we could introduce
another cgroup just to limit the number of shared address spaces, but
limiting the number of IOASIDs does the trick.

> So the host IOASIDs are currently allocated from the system pool
> with quota of chosen by iommu_sva_init() in my patch, 0 means unlimited use
> whatever is available. https://lkml.org/lkml/2021/2/28/18

Yes that's sensible, but it would be good to plan the cgroup user
interface to work for #2 as well, even if we don't implement it right
away.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
