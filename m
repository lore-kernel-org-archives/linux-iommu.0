Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856521C9B62
	for <iommu@lists.linux.dev>; Thu, 24 Oct 2024 15:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729783583; cv=none; b=ehvbL+2bJzH25oxfrY+vp3+myF2zxdh0J1UKdj9lkzwMDvkvU75pngM26s7aSiV1eysm22JAleMDVhaVdyaW5eZlBsui0pVWW00fEmk14sU1+sxoXBa2VOADQegvkxGdmgd+I0HH7PZkHVDO+MzW5fojmN8ts1zxVgIWHNWFo/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729783583; c=relaxed/simple;
	bh=Gq0ikCQiE1isVb8GtYfDFuJIVE2wu5PvdoEqek8DL2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SEVQ5i90eMjc1wkfIkJi9Zk5bIjCyoA7wPrF7ra9Bcj+cudi1HUVeienPwVL4a5mX1lQ7MV77ubxBH/2Y4hHQnYl7OXj+XmIlyfxPf5eu4ZUEO5Ks7zxBfuDu3rN50AFt1ii5hehMv8xX8vQUZ6Cl0O9gR24tfjjivzEphMsvQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rqaqKY4o; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rqaqKY4o"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20ca03687fdso139775ad.0
        for <iommu@lists.linux.dev>; Thu, 24 Oct 2024 08:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729783581; x=1730388381; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wi4glAx+wEgGST5LdDDBKp+Mkl9kiSGTU6STDe7K1/o=;
        b=rqaqKY4oWpl1y7vqc721H+Ag7E+2fHZ8fdejjIU0QyRWvb5aG9QFFHXY07Qd2qt3Ga
         PsIndyzO89AElRX7w+XQQ37yVfmsdXnEvWIaSvotKVbySZt2D7Xe8AuMyU66nt2a2RWj
         GrOON979F1vj/wdGtyxKp7y2Lp7b8MXjt8HmDFnF4oU1cYJFPts/03bIOEvZM8wRuG8i
         gqStfAkuswyPpFok7/8f1cCnG62ISwy63cZZ0Jmtlb6S+X2yLsXKrK9K8XD6rqGMl1bf
         wQCFrgd7elpvWB3euti4seTm35OIRlwax/6Kq20i9OOJYLi7jJxtEWVAIQpo8DFsjOSl
         KCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729783581; x=1730388381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wi4glAx+wEgGST5LdDDBKp+Mkl9kiSGTU6STDe7K1/o=;
        b=ZRebXHmsnp9cRG2/dNJikErtIxiGgEa71ZYyeHh5tb/HeO2fBO+Tf34j+nktzbxh3W
         xnzZbnHjMcnCEjBnGa1OdP8Aqli6TBlqsWClvp23v9SNvP1G0T3SiNknhjktruojQlp+
         djwyqrxzt28s/irGQQuSisLLBdtfgK+/4EqHc8oHBXQLPzsfUHqp8rH1MFcszeY4v7nF
         xc+UKsvkULr77KkcVUV1SJX9c8taa4DrF45hMA4OYRKKIkhZd7TGawettj11gjii87w8
         vu/DuIjxgSvE5RDWllt7tS1+Eobujmv+UHHI/86EHaf1aFSWel3g4l1hzrUPfdpg+sA8
         UbUw==
X-Forwarded-Encrypted: i=1; AJvYcCVNl9LqvpajcjGJ1KBUcaIoqzTBuw+T+X8hgPylYWgHrms7uGjAey5qWlRXb+2P48tNv5C7qA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzMhJ+xLErJD4wWshsF9dKZDmVzRIfzW9GxUkGm6nQl6FuIB2yA
	6opfitzTpwdkUWzawMvzfRIE1JRCdYTGRopG5fb0CA+B1fKpvYopnEb/ksvJ3A==
X-Google-Smtp-Source: AGHT+IG9fIxEp3nE+7sh8sAPl79Ygp1jwOjhJKusBS4VmwGbdjSog8+lupqcuyio5msUO7yn6X4epA==
X-Received: by 2002:a17:903:2304:b0:20c:e169:eb8c with SMTP id d9443c01a7336-20fb76b7b3emr2448315ad.1.1729783580393;
        Thu, 24 Oct 2024 08:26:20 -0700 (PDT)
Received: from google.com (62.166.143.34.bc.googleusercontent.com. [34.143.166.62])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeabb83easm8788835a12.72.2024.10.24.08.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 08:26:19 -0700 (PDT)
Date: Thu, 24 Oct 2024 15:26:12 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Will Deacon <will@kernel.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Rob Clark <robdclark@chromium.org>,
	Georgi Djakov <quic_c_gdjako@quicinc.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [PATCH 22/51] iommu/arm-smmu: Switch to
 __pm_runtime_put_autosuspend()
Message-ID: <ZxpnFPsk2OBC8vqd@google.com>
References: <20241004094101.113349-1-sakari.ailus@linux.intel.com>
 <20241004094123.113725-1-sakari.ailus@linux.intel.com>
 <ZwfztwoGAcvyvlWL@google.com>
 <20241023164835.GF29251@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023164835.GF29251@willie-the-truck>

On Wed, Oct 23, 2024 at 05:48:36PM +0100, Will Deacon wrote:
> On Thu, Oct 10, 2024 at 03:33:11PM +0000, Pranjal Shrivastava wrote:
> > On Fri, Oct 04, 2024 at 12:41:23PM +0300, Sakari Ailus wrote:
> > > pm_runtime_put_autosuspend() will soon be changed to include a call to
> > > pm_runtime_mark_last_busy(). This patch switches the current users to
> > > __pm_runtime_put_autosuspend() which will continue to have the
> > > functionality of old pm_runtime_put_autosuspend().
> > > 
> > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > ---
> > >  drivers/iommu/arm/arm-smmu/arm-smmu.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > > index 8321962b3714..cad02d5dc6d2 100644
> > > --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > > @@ -79,7 +79,7 @@ static inline int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
> > >  static inline void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
> > >  {
> > >  	if (pm_runtime_enabled(smmu->dev))
> > > -		pm_runtime_put_autosuspend(smmu->dev);
> > > +		__pm_runtime_put_autosuspend(smmu->dev);
> > >  }
> > 
> > Seems like a straightforward change as a result of [1].
> > Although, I had a few things to discuss:
> > 
> > 1. The `rpm_resume` in drivers/base/power/runtime.c seems to call
> > `pm_runtime_mark_last_busy` in case the ->runtime_resume callback
> > returned successfully. In such a case, why would we want to move
> > `pm_runtime_mark_last_busy` within `pm_runtime_put_autosuspend` ?
> > 
> > 2. In the arm-smmu driver, we seem to rely on the rpm_resume to call
> > `pm_runtime_mark_last_busy` as a part of the ->runtime_resume callback.
> > The only other case, where we might wanna `*mark_last_busy` is if we
> > want the autosuspend timer to be re-started in case of a failed suspend.
> > However, the `arm_smmu_runtime_suspend` doesn't return errno in any case
> > hence, I don't see any other case where we'd benefit from using
> > `mark_last_busy` in the arm-smmu driver. 
> > 
> > On the other hand, I don't see a problem with using it either :)
> > Any thoughts Will/Rob/Robin?
> 
> To be honest, I think the current driver code is pretty weird. We're
> calling arm_smmu_rpm_use_autosuspend() during device attach and that
> does:
> 
> 	pm_runtime_set_autosuspend_delay(smmu->dev, 20);
> 	pm_runtime_use_autosuspend(smmu->dev);
> 
> whereas I would've expected these autosuspend parameters to be configured
> once during SMMU probe and then for attach to do something like:
> 
> 	pm_runtime_mark_last_busy();
> 	__pm_runtime_put_autosuspend();
> 

Ack. I had missed the `*set_autosuspend` call during attach, there's no
need for that to happen with each attach. I agree that we should setup
autosuspend delay once during the smmu probe and mark_last_busy on
attach to retain the current behaviour.

> So I think we should probably rework the code we have slightly, which
> will hopefully make this giant refactoring series a little more
> straightforward.

+1.

> 
> Will

Thanks,
Pranjal
