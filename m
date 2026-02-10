Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDA814B977
	for <iommu@lists.linux.dev>; Tue, 10 Feb 2026 13:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770729329; cv=none; b=EWvUXZtH4LfyjivCGMjxNGKPoOPQ3/1LpUw6zznOBmw7gcyRhe/ZGXWlqg8p2pMoKHe7CexrmDUelH9rqQ781PGnspaYoUskrBpF+RqGm0t135frs6CxWYGVR5NhtJ9Owde/3LJfqHgaIYwY5xCh9VO1KWO9nUBRMaiNDAzthAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770729329; c=relaxed/simple;
	bh=F8w4PX3YR2LBUt2iuysbbtlPZH7MbKvPtV4LF1y5x4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSWMeIVgdte4qkPLHUYjvUeVJFwXFpRDnaveuGLWAv0GLrDg78ctcS5YQ+u/Z2jB+a6jGAPFnCzjX/O9LNpmsTXNXr4jb5y3v4EB61WhBNzY0xAN+iIEbVyCTPdT/Nl3qsB7pD0ErQPdTDpWzYAKO6u6+ADshNBN0iVkOGplphU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0/LX8pyQ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0/LX8pyQ"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a76b39587aso72505ad.0
        for <iommu@lists.linux.dev>; Tue, 10 Feb 2026 05:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770729328; x=1771334128; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RX56B6Pzw6O0Q1rKBSh+0V8lVIPD4tWbCrOnzMgOsgU=;
        b=0/LX8pyQbYy496grothoCm39DRSG6dN3Y6l2rqUo+e01GxfZ5k3/h9bWLjO9Lza1PI
         zhi86NqRKDdmX3Xl5ZdK8YPnk907SQooj0AhGZE67Yg45yBF5SLEIRCoB0bEMuhAh95K
         lNRx7refFKFX9NOoBZpcol3Sv3HuDVg23sGJx2BZ7trXeF8tQec70HAg+Q06zdwY5+ZG
         S1/pNpAE8cUguLW/B4ADHmzMNZUlgxro1UsGpKVabHzQlom2fyklDyX5KoVF9TZdI0Nl
         wxfAw6jCjal8vNR3JdlJszzFIKdqnPwxlG3oGDOZ5dxhzayqM9mv8I2wLLuJ3maFTbUd
         jCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770729328; x=1771334128;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RX56B6Pzw6O0Q1rKBSh+0V8lVIPD4tWbCrOnzMgOsgU=;
        b=bbBtLLp9HQH/NHmX6yeX4ZG64/xCYwe2QfecaN48CAgKhwrZetaG89cG66LEZICCM6
         GkXSpptPdNpkxTc3+nOxBuuj+IVN3OCdNajg+hlz2OG9+lw0f5jPBmrsm48lYkNou//5
         Wv5w4YagjxkTOvJEdVUq9gCiZFMG57lOCD2YSd/JQFF3tZbjmLGtcrLwmjkvjE6y2+WZ
         rT2x2wT6YVRmwnWxIAopUt0qIRnKTAT+FfhXP5KanMJJswPf+lI6BLyI8sODY+/cyB2l
         RxXhwZ9wLQlUk+0ehG5SBuTgpuq20TxVMTFxx3VljQenJyAa6LvCePrIBr2wJSvlOmMA
         vr/w==
X-Forwarded-Encrypted: i=1; AJvYcCWXf6pxfXAc/ZLaA43XAGJTDYowr4+Mj7bnUChnmRkrcyDlF5AiHngXgDij3lqu+jekyBnl1g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxXT3mIBjb5308KRRtzjfJ/ZJqy4OggavkA/eiN3doPsFXtxBnU
	IQUntd2V5harjS0HDZF6O3c2u4d/unNl02x9Qy7davpoJEJC9PlvIUH/g8IKMy+4yg==
X-Gm-Gg: AZuq6aI0FoscKW9A+fsihe0ksdnFWsHXaBMbDJM6+gjip6OjV0QSsBBuJcEI6vRkDEu
	4/+aclcl0uXmgF9YiIRwP908H8X+Y6Bc8gja40Q30WnfHcm0z2NimMeVkYctpaQ3doMZLvnqugg
	Vtz/7h7GhwJiXFu99wnvAO64J4kFYdK/5j2eIR9biZfbLYJ1vJgyHY54Pv+K7lLePqeT4WmDCG5
	rqgOb+fqUoC9Szx3YBz0jbpWOMDWYNS8NcyGUQWGmFzHiOIFQGlC9Y0urcJwG/BFoFg9DzGPZRJ
	TgHFY5b0Lea6ESyVoAASFLFdyoqmDKI7jP3u/utClq7W4TTyfnh9epvPsu3fW/7SdCByEC7vdfh
	ftGNJxQkPcrta4hqxzQFL94FOFadJxRbg4mbr76L4Zvt0k+FSjODDqq6Zo6mKUWkeV1gtIgZuQH
	AVHu/fF2tMhxjpzTIAmGvnq7bqAUShJwnc69jVvigw+5dfEz3A8xxDL2CMBHbU
X-Received: by 2002:a17:903:32cf:b0:2a7:d266:d84a with SMTP id d9443c01a7336-2ab10104509mr2092735ad.17.1770729327080;
        Tue, 10 Feb 2026 05:15:27 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824418dd7a2sm13128886b3a.59.2026.02.10.05.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 05:15:26 -0800 (PST)
Date: Tue, 10 Feb 2026 13:15:21 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Prakash Gupta <prakash.gupta@oss.qualcomm.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Connor Abbott <cwabbott0@gmail.com>, linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Akhil P Oommen <akhilpo@oss.qualcomm.com>,
	Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
Subject: Re: [PATCH] iommu/arm-smmu: Use pm_runtime in fault handlers
Message-ID: <aYsvacmKoLroXlrZ@google.com>
References: <20260127-smmu-rpm-v1-1-2ef2f4c85305@oss.qualcomm.com>
 <9fb8f661-a235-4f86-bc10-f80a21a8fa9d@arm.com>
 <00fcbcf2-3f48-410d-88a3-88dc834c1ed7@oss.qualcomm.com>
 <d6bc7f38-b41d-4e89-b484-0e699981b8b4@arm.com>
 <aYEFop8CJiLYzhLw@google.com>
 <7720d215-9f92-4f0f-83af-c992e1cbe531@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7720d215-9f92-4f0f-83af-c992e1cbe531@oss.qualcomm.com>

On Tue, Feb 10, 2026 at 04:39:56PM +0530, Prakash Gupta wrote:
> 
> 
> On 2/3/2026 1:44 AM, Pranjal Shrivastava wrote:
> > On Wed, Jan 28, 2026 at 06:44:35PM +0000, Robin Murphy wrote:
> >> [ +Pranjal as this might matter for v3 too... ]
> >>
> > 
> > Hi Robin,
> > 
> > To weigh in from the arm-smmu-v3 side, we’ve attempted to address the
> > "can of worms" regarding power races by leaning on these differences:
> > 
> >  - Threaded IRQs for PRI/Events: In the recent series[1], the PRI and
> >    event handlers are fully threaded. This allows us to call 
> >    arm_smmu_rpm_get() safely, as the handler can sleep while waiting for
> >    the hardware to resume.
> > 
> >  - GERROR Handling: Since GERROR remains a hard IRQ, we handle any
> >    pending gerrors in the suspend callback before the SMMU actually
> >    powers down. Any GERROR interrupts received while the device was
> >    suspended are treated as spurious and ignored.
> > 
> > Thanks,
> > Praan
> 
> [1] refer to case where SMMU state is not retained during smmu device
> power down, this I think is equally applicable for both context and
> global faults.
> 
> Since the ARM SMMU runtime resume triggers a device reset, any pending
> faults would be cleared during resume. Here the solution can be to
> handle both global and context faults before allowing the SMMU device to
> suspend.
> With this approach, any hard or threaded IRQ scheduled after the SMMU
> device has suspended can be safely ignored.
> One concern I see is iommu fault reporting to clients while handling
> fault during smmu device suspend.

I believe by the time we've reached suspend it's safe to assume that all
clients have been suspended. Thus, we could simply not report the error
and instead scream by having a dev_warn_ratelimited about the situation.

Thanks,
Praan

> 
> Thanks,
> Prakash
> 
> [1] https://lore.kernel.org/all/20260126151157.3418145-9-praan@google.com/
> 
