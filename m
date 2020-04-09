Return-Path: <SRS0=CVo8=5Z=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA752C2BB1D
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 08:24:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C6C9212CC
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 08:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vLrAAclO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C6C9212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7A8468654D;
	Thu,  9 Apr 2020 08:15:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 72Nm1Etz8xbu; Thu,  9 Apr 2020 08:14:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B3E1C85168;
	Thu,  9 Apr 2020 08:14:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93859C089F;
	Thu,  9 Apr 2020 08:14:59 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2BD8C0177
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 08:14:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DC98B878F7
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 08:14:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xT2fzEA4cZRz for <iommu@lists.linux-foundation.org>;
 Thu,  9 Apr 2020 08:14:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D426F878E5
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 08:14:54 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id f10so1155280wrr.9
 for <iommu@lists.linux-foundation.org>; Thu, 09 Apr 2020 01:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ZlTF/KafXlJgMPlRdN0G/mkK/4LzjBx/AGs4C/dxm9w=;
 b=vLrAAclOkO4iGm6s+MQ5nyroD7N3UCquUO8bDswFNMDWivwTEnrCUSy9Bpax0xxEX+
 zNeV3rAPs6TD8o1rfFyk9bhJeamRtxbDzwRdKSboiD3TpcxJ3OeE4wa2iTF/PR8NjWG4
 ECsTsuZEMeV6KnrXb34BwmebUUPnTfRi8bjrslKQqitgVff8FRgMqDHVD4bL0DXrx+cy
 BULpYVT7PNivcVyx1949ICtMl3Z/n8kw1WGOjcj1nBReB663wD+JH7Uy2mEDMqtXJwpn
 6W7KRDRKpMZh0SBlcNtuItov0+c4MPFBXo+zRR8zH3ZgjQkPaikWSmpbRkAAmmUt9+fV
 KSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ZlTF/KafXlJgMPlRdN0G/mkK/4LzjBx/AGs4C/dxm9w=;
 b=chxmhGiDo9jo7ol/LNGj4xWxEppd8LYXOw8DPVdbzTekvFYBrA6lJODwWEfCfYo6D3
 /Zu/uNm5xZaPo32HBmHFfRpKrsAUo3Y1TZVMloqwzjqUfIEEzrzGUmvAwyvdmSvxNK+p
 lrPYMXnLU0kfJ8nAQzSyHXccHcCPTtdtzMPrYyTMbHHQwuw08n/XQP3yn5qigX0T/4kT
 yhuJKABVQgTKG74U+Y+p8UTynr0cyLra6aS8/lj4xiCTfEeloeg2SoqEoITbyiMWr2Mv
 TPyBeB3T58PR/e4hNFutBgCHd59OFfr4WNf/ERZgpRiqGABdIGHkyfcfSfgC59tcIyK+
 uRBQ==
X-Gm-Message-State: AGi0PubjEc6WxHhleJF0YC7yrQYGPQqXLb0ChVgNfAR06uhpSL1kmxwv
 vjLKseKonkGYDURc07b5M/FZGA==
X-Google-Smtp-Source: APiQypJemfydeaVCk96UzkWnWUlTWfH71DnX8DVMs/2o85G9/BiV9p3xiyhSRllpGeBIVPIEZJ8UfQ==
X-Received: by 2002:a5d:4081:: with SMTP id o1mr13432498wrp.114.1586420091068; 
 Thu, 09 Apr 2020 01:14:51 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id o16sm39322467wrs.44.2020.04.09.01.14.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2020 01:14:50 -0700 (PDT)
Date: Thu, 9 Apr 2020 10:14:42 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v1 5/8] vfio/type1: Report 1st-level/stage-1 format to
 userspace
Message-ID: <20200409081442.GD2435@myrica>
References: <1584880325-10561-1-git-send-email-yi.l.liu@intel.com>
 <1584880325-10561-6-git-send-email-yi.l.liu@intel.com>
 <cb68e9ab-77b0-7e97-a661-4836962041d9@redhat.com>
 <A2975661238FB949B60364EF0F2C25743A21DB4E@SHSMSX104.ccr.corp.intel.com>
 <b47891b1-ece6-c263-9c07-07c09c7d3752@redhat.com>
 <20200403082305.GA1269501@myrica>
 <A2975661238FB949B60364EF0F2C25743A2249DF@SHSMSX104.ccr.corp.intel.com>
 <acf8c809-8d29-92d6-2445-3a94fc8b82fd@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <acf8c809-8d29-92d6-2445-3a94fc8b82fd@redhat.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Sun,
 Yi Y" <yi.y.sun@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "Tian,
 Jun J" <jun.j.tian@intel.com>, "Wu, Hao" <hao.wu@intel.com>
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

On Wed, Apr 08, 2020 at 12:27:58PM +0200, Auger Eric wrote:
> Hi Yi,
> 
> On 4/7/20 11:43 AM, Liu, Yi L wrote:
> > Hi Jean,
> > 
> >> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> >> Sent: Friday, April 3, 2020 4:23 PM
> >> To: Auger Eric <eric.auger@redhat.com>
> >> userspace
> >>
> >> On Wed, Apr 01, 2020 at 03:01:12PM +0200, Auger Eric wrote:
> >>>>>>  	header = vfio_info_cap_add(caps, sizeof(*nesting_cap),
> >>>>>>  				   VFIO_IOMMU_TYPE1_INFO_CAP_NESTING, 1);
> >> @@ -2254,6 +2309,7
> >>>>>> @@ static int vfio_iommu_info_add_nesting_cap(struct
> >>>>> vfio_iommu *iommu,
> >>>>>>  		/* nesting iommu type supports PASID requests (alloc/free) */
> >>>>>>  		nesting_cap->nesting_capabilities |= VFIO_IOMMU_PASID_REQS;
> >>>>> What is the meaning for ARM?
> >>>>
> >>>> I think it's just a software capability exposed to userspace, on
> >>>> userspace side, it has a choice to use it or not. :-) The reason
> >>>> define it and report it in cap nesting is that I'd like to make the
> >>>> pasid alloc/free be available just for IOMMU with type
> >>>> VFIO_IOMMU_TYPE1_NESTING. Please feel free tell me if it is not good
> >>>> for ARM. We can find a proper way to report the availability.
> >>>
> >>> Well it is more a question for jean-Philippe. Do we have a system wide
> >>> PASID allocation on ARM?
> >>
> >> We don't, the PASID spaces are per-VM on Arm, so this function should consult the
> >> IOMMU driver before setting flags. As you said on patch 3, nested doesn't
> >> necessarily imply PASID support. The SMMUv2 does not support PASID but does
> >> support nesting stages 1 and 2 for the IOVA space.
> >> SMMUv3 support of PASID depends on HW capabilities. So I think this needs to be
> >> finer grained:
> >>
> >> Does the container support:
> >> * VFIO_IOMMU_PASID_REQUEST?
> >>   -> Yes for VT-d 3
> >>   -> No for Arm SMMU
> >> * VFIO_IOMMU_{,UN}BIND_GUEST_PGTBL?
> >>   -> Yes for VT-d 3
> >>   -> Sometimes for SMMUv2
> >>   -> No for SMMUv3 (if we go with BIND_PASID_TABLE, which is simpler due to
> >>      PASID tables being in GPA space.)
> >> * VFIO_IOMMU_BIND_PASID_TABLE?
> >>   -> No for VT-d
> >>   -> Sometimes for SMMUv3
> >>
> >> Any bind support implies VFIO_IOMMU_CACHE_INVALIDATE support.
> > 
> > good summary. do you expect to see any 
> > 
> >>
> >>>>>> +	nesting_cap->stage1_formats = formats;
> >>>>> as spotted by Kevin, since a single format is supported, rename
> >>>>
> >>>> ok, I was believing it may be possible on ARM or so. :-) will rename
> >>>> it.
> >>
> >> Yes I don't think an u32 is going to cut it for Arm :( We need to describe all sorts of
> >> capabilities for page and PASID tables (granules, GPA size, ASID/PASID size, HW
> >> access/dirty, etc etc.) Just saying "Arm stage-1 format" wouldn't mean much. I
> >> guess we could have a secondary vendor capability for these?
> > 
> > Actually, I'm wondering if we can define some formats to stands for a set of
> > capabilities. e.g. VTD_STAGE1_FORMAT_V1 which may indicates the 1st level
> > page table related caps (aw, a/d, SRE, EA and etc.). And vIOMMU can parse
> > the capabilities.
> 
> But eventually do we really need all those capability getters? I mean
> can't we simply rely on the actual call to VFIO_IOMMU_BIND_GUEST_PGTBL()
> to detect any mismatch? Definitively the error handling may be heavier
> on userspace but can't we manage.

I think we need to present these capabilities at boot time, long before
the guest triggers a bind(). For example if the host SMMU doesn't support
16-bit ASID, we need to communicate that to the guest using vSMMU ID
registers or PROBE properties. Otherwise a bind() will succeed, but if the
guest uses 16-bit ASIDs in its CD, DMA will result in C_BAD_CD events
which we'll inject into the guest, for no apparent reason from their
perspective.

In addition some VMMs may have fallbacks if shared page tables are not
available. They could fall back to a MAP/UNMAP interface, or simply not
present a vIOMMU to the guest.

Thanks,
Jean

> My fear is we end up with an overly
> complex series. This capability getter may be interesting if we can
> switch to a fallback implementation but here I guess we don't have any
> fallback. With smmuv3 nested stage we don't have any fallback solution
> either. For the versions, it is different because the userspace shall be
> able to adapt (or not) to the max version supported by the kernel.
> 
> Thanks
> 
> Eric
> > 
> > Regards,
> > Yi Liu
> > 
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
