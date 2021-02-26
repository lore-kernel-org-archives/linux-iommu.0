Return-Path: <SRS0=CXUA=H4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35608C433DB
	for <iommu@archiver.kernel.org>; Fri, 26 Feb 2021 16:30:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A50764E09
	for <iommu@archiver.kernel.org>; Fri, 26 Feb 2021 16:30:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A50764E09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CEF714F03E;
	Fri, 26 Feb 2021 16:30:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 32M_cAyn7pbJ; Fri, 26 Feb 2021 16:30:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 02AE54F033;
	Fri, 26 Feb 2021 16:30:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CBF0AC000A;
	Fri, 26 Feb 2021 16:30:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3110C0001
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 16:30:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AA2E1842C5
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 16:30:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1jztBi86_SGz for <iommu@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 16:30:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2EAFB842C3
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 16:30:01 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id i9so7582725wml.0
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 08:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=YseGCzjDY6Y9V6UnbishTzBOzoHsbNnd9gsiT/rD4RA=;
 b=tQLe1JHOEXTleWsdIuaOOPFqSVPu3mCeA6TcjLifl2wxU/KM4XGpZX8Yx0dCAHaW6d
 mHtO5yeUCHv5fMJyKep3uAP8VRbo+AdHxyHU2nu2qrLU9zy83N57wRuJ9nvfuGbNsf1y
 t3JncbHK4lR5phiBL8itjkJ0H5JhbuqwVFBf2z0jPSvxspjx1oU6V0a+l4QTveikN+vb
 xxOoPYCFylLaPPwTTYRLg6ySIpLZbeQ+/AnNdVXf+9eBX7Aq52he62+DQQDDLb1z5n3t
 Sc55bZX3Lj7xktY12gN9f4AAwH14wmJW9bb/7X23mqX4EeJGpeplhVSs8fjYrDliYMU4
 gSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=YseGCzjDY6Y9V6UnbishTzBOzoHsbNnd9gsiT/rD4RA=;
 b=Ddf3YqcSrFu6QLrQnsShkg1/7y1++z1w0agLlE1eyQ3yjMkGi5DGEmXT4wvImRLapC
 61CFvEmbBiCwM2JYBNSPGXiwNezQOPzsPRrPB941lWIFlWNjB/NPwjmZYyTGZpIgURrL
 KB5eo2Rw9wk50bLr5M3l+VYT72ca1UOKR4X/2IoDAvaifmMpuQKPUEte6eO3BCFnoAq0
 MLOhmt33qDMFJuHPgvPsThQbd022joL6gyJYTPh3jYFNZ+k0Cd5AaepES63v4KINOrCI
 y1OR5mmAD0ZM6UBsbFVUUSOOA8OZxJkZwpO71JWrtyHwGjdvub3AOFuU5uZbISqIPvwz
 3dIw==
X-Gm-Message-State: AOAM531LeM81Q+DUq2QDlCDSJyyXJN61jceUawG7sp36Zs0EBd3DQgx9
 4E9mp7afvcAqzR+6j43RFORZ8g==
X-Google-Smtp-Source: ABdhPJznohOy8DU3GAcT3VQqrhXcbpg1fj10haa/AaOP7FATIiWNhrtlU7CTl34ihXGj7Pt2jEU/zw==
X-Received: by 2002:a1c:9a47:: with SMTP id c68mr3610043wme.63.1614356999337; 
 Fri, 26 Feb 2021 08:29:59 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id m11sm1326750wrz.40.2021.02.26.08.29.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Feb 2021 08:29:58 -0800 (PST)
Date: Fri, 26 Feb 2021 17:29:38 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Zhou Wang <wangzhou1@hisilicon.com>
Subject: Re: [PATCH v12 10/10] iommu/arm-smmu-v3: Add stall support for
 platform devices
Message-ID: <YDkh8qR7csPB68sC@myrica>
References: <20210127154322.3959196-1-jean-philippe@linaro.org>
 <20210127154322.3959196-11-jean-philippe@linaro.org>
 <8adc79cc-7afb-dfe8-4f7b-07fa6dc5b905@hisilicon.com>
 <YBfij71tyYvh8LhB@myrica>
 <fabffd28-7497-2758-c2bf-9d31aa562085@hisilicon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fabffd28-7497-2758-c2bf-9d31aa562085@hisilicon.com>
Cc: devicetree@vger.kernel.org, kevin.tian@intel.com,
 linux-acpi@vger.kernel.org, robin.murphy@arm.com, sudeep.holla@arm.com,
 rjw@rjwysocki.net, vivek.gautam@arm.com, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, linux-accelerators@lists.ozlabs.org, guohanjun@huawei.com,
 zhangfei.gao@linaro.org, will@kernel.org, linux-arm-kernel@lists.infradead.org,
 lenb@kernel.org
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

Hi Zhou,

On Fri, Feb 26, 2021 at 05:43:27PM +0800, Zhou Wang wrote:
> On 2021/2/1 19:14, Jean-Philippe Brucker wrote:
> > Hi Zhou,
> > 
> > On Mon, Feb 01, 2021 at 09:18:42AM +0800, Zhou Wang wrote:
> >>> @@ -1033,8 +1076,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
> >>>  			FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid) |
> >>>  			CTXDESC_CD_0_V;
> >>>  
> >>> -		/* STALL_MODEL==0b10 && CD.S==0 is ILLEGAL */
> >>> -		if (smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
> >>> +		if (smmu_domain->stall_enabled)
> >>
> >> Could we add ssid checking here? like: if (smmu_domain->stall_enabled && ssid).
> >> The reason is if not CD.S will also be set when ssid is 0, which is not needed.
> > 
> > Some drivers may want to get stall events on SSID 0:
> > https://lore.kernel.org/kvm/20210125090402.1429-1-lushenming@huawei.com/#t
> > 
> > Are you seeing an issue with stall events on ssid 0?  Normally there
> > shouldn't be any fault on this context, but if they happen and no handler
> > is registered, the SMMU driver will just abort them and report them like a
> > non-stall event.
> 
> Hi Jean,
> 
> I notice that there is problem. In my case, I expect that CD0 is for kernel
> and other CDs are for user space. Normally there shouldn't be any fault in
> kernel, however, we have RAS case which is for some reason there may has
> invalid address access from hardware device.
> 
> So at least there are two different address access failures: 1. hardware RAS problem;
> 2. software fault fail(e.g. kill process when doing DMA). Handlings for these
> two are different: for 1, we should reset hardware device; for 2, stop related
> DMA is enough.

Right, and in case 2 there should be no report printed since it can be
triggered by user, while you probably want to be loud in case 1.

> Currently if SMMU returns the same signal(by SMMU resume abort), master device
> driver can not tell these two kinds of cases.

This part I don't understand. So the SMMU sends a RESUME(abort) command,
and then the master reports the DMA error to the device driver, which
cannot differentiate 1 from 2?  (I guess there is no SSID in this report?)
But how does disabling stall change this?  The invalid DMA access will
still be aborted by the SMMU.

Hypothetically, would it work if all stall events that could not be
handled went to the device driver?  Those reports would contain the SSID
(or lack thereof), so you could reset the device in case 1 and ignore case
2. Though resetting the device in the middle of a stalled transaction
probably comes with its own set of problems.

> From the basic concept, if a CD is used for kernel, its S bit should not be set.
> How about we add iommu domain check here too, if DMA domain we do not set S bit for
> CD0, if unmanaged domain we set S bit for all CDs?

I think disabling stall for CD0 of a DMA domain makes sense in general,
even though I don't really understand how that fixes your issue. But
someone might come up with a good use-case for receiving stall events on
DMA mappings, so I'm wondering whether the alternative solution where we
report unhandled stall events to the device driver would also work for
you.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
