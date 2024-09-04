Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9931DA31D
	for <iommu@lists.linux.dev>; Wed,  4 Sep 2024 17:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725469947; cv=none; b=NZ97UyaNDvhGLPJGQoFXCyH2WpJEAyiYyNMJrpW7Omdiko0oIbuutJT5KQoiAaIstDiJ8uEudv96Itv2etPLsPCwgiIIbQjxDLNHGDe5H25GpjN4/OwS/vRHVIKreAtx2jDVrvsHoYCRhm0wwF1t0en0IsMlPqybDMRBqHk/TBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725469947; c=relaxed/simple;
	bh=YyBVaju+LKEXVnoxVu5mj5D/dy3jhLXGBMTUYPRw3B8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o6vXVWGPZj3UB0XOhtirWUrbvov2EgQsW0WT36lhORSK6m2CD+DUft/o5Xfr/qcsSkyaF4Yxjo2Z1Lbmldjyi/ec3K3DHProjKJEY9PDqDrwMn4bP70y9zwxVccJjSAqcFr+mv/8N3aGB/0ot8UrCK1U4jAvpXUNMdfabS1dttA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qa934bFG; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qa934bFG"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-374c962e5adso584721f8f.1
        for <iommu@lists.linux.dev>; Wed, 04 Sep 2024 10:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725469943; x=1726074743; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sufPgAffU6DtwuR+shMH9kjtLOalG94qLxuZDKPxPIQ=;
        b=qa934bFGnfdFKHpk+U3GB8xTkxTmlkoEPkUbmLj5u6KeyXf8C0CUGM5bL6Opb9Kjvf
         EcsnMT8KCiyuk44C+9GMSibvLINtPOYAxUJG0KpKO5viRLQgqk7MB7FLvIWELenrpxx+
         eREzLyBqvh7qnRC7tJeW1T/59UgcpzxS+yVnuGcT5ia9AzVMZUB4XVDkhdLCKhtATcON
         49Kx+d3vW786rlglq5z80bl4ck3GBdIKCyvwlZoeNc8bB34lAw5KMUYq1tMH4ftGQyAC
         HI/4SS1fsNDDxsOmtSqK3hs3UOwypQTq8pi14SOPi8HIgX7wvVUP7IO4SviJk7LyIu0R
         NOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725469943; x=1726074743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sufPgAffU6DtwuR+shMH9kjtLOalG94qLxuZDKPxPIQ=;
        b=wr9jBQq/JI2uvUmO72Maw7LbYxhXO2MpDx70xhWDuURmYPtREegNgOUbIe1Qbw9Rn2
         XaUjE8VZevDiLXG1fjXJqwHbWCUs18VkghPIel7t+5IqRiy0KjHvnlSTXVKfoRIluXuj
         am2Ohl2RxVvej7wffTS8QbGN/tWOJk8Ydkf6g48hJ+cG0YPB5y01+Ok1BMndx/WEL816
         LYq4PIk+ZE8F9jMsUIDsO76m/IzuL+6r6slNmIS2xyN8a31Kv62u3Jmy+Rhoa2wR72Hg
         aLhZldXoxpIC1d3X31xJdXcQG89yAttnF2sSEXXAHAZgbuhZ6RpMgzwr5yjOtGAxPk26
         XjBA==
X-Forwarded-Encrypted: i=1; AJvYcCXcyA6IzRWFaQrQ/xa5gfk8tc3zBUCcihsBlZ5oxEMA6ohIm9TFVneqlb2lT/AD+UN6CvKdpg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3RtRGcTyqGVjDQAwiex0IF36k/CPCNP5DSsklj4kRW+/fTpQw
	BM7CjSFArE3KiXaLZ3ZWjVgFs6VABQixMF30hTD01CH6CSh2uLpTnmQySWnuLL8=
X-Google-Smtp-Source: AGHT+IEjxGfZuPbhih0bctt9v26csC/sSYjllMJ6b4BHDYxK12zL/eLDqbq8jYX/ApH+OrlHTg34fA==
X-Received: by 2002:adf:e882:0:b0:374:cc89:174b with SMTP id ffacd0b85a97d-377998aafc7mr2033054f8f.4.1725469943121;
        Wed, 04 Sep 2024 10:12:23 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c046685fsm12291083f8f.79.2024.09.04.10.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 10:12:22 -0700 (PDT)
Date: Wed, 4 Sep 2024 20:12:19 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jgg@nvidia.com,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v14 08/10] iommu/arm-smmu-v3: Add in-kernel support for
 NVIDIA Tegra241 (Grace) CMDQV
Message-ID: <fcf44982-166a-4a25-acd0-02a142e205d7@stanley.mountain>
References: <cover.1724970714.git.nicolinc@nvidia.com>
 <dce50490b2c10b7254fb36aa73ed7ffd812b283a.1724970714.git.nicolinc@nvidia.com>
 <38b6ed33-886f-4ec7-9196-1728f1d8c1b3@stanley.mountain>
 <Zth59xLYZ4skc4yb@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zth59xLYZ4skc4yb@Asurada-Nvidia>

On Wed, Sep 04, 2024 at 08:17:11AM -0700, Nicolin Chen wrote:
> Hi Dan,
> 
> On Wed, Sep 04, 2024 at 10:29:26AM +0300, Dan Carpenter wrote:
>  
> > I was reviewing Smatch warnings:
> > 
> >     drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c:616 tegra241_cmdqv_init_vintf()
> >     error: Calling ida_alloc_max() with a 'max' argument which is a power of 2. -1 missing?
> > 
> > The problem is that we're calling ida_alloc_max() where max is always zero.
> > 
> > > +static int tegra241_cmdqv_init_vintf(struct tegra241_cmdqv *cmdqv, u16 max_idx,
> > > +                                  struct tegra241_vintf *vintf)
> > > +{
> > > +
> > > +     u16 idx;
> > > +     int ret;
> > > +
> > > +     ret = ida_alloc_max(&cmdqv->vintf_ids, max_idx, GFP_KERNEL);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +     idx = ret;
> > 
> > max_idx is always zero so idx is always zero.
> 
> There is a followup series adding support for max[1, max_vintf].
> And I guess that would make Smatch happy. I'd personally prefer
> keep this by ignoring the Smatch warning. But if you think the
> common practice is to drop it and add back, I'd be okay with it.
> 

I'm just reviewing static checker warnings so I don't know the back story...
How long are we going to have to wait for the follow on patchset?

Generally if someone had noticed this in review they would have asked that it
be dropped but now that it's in, you're probably in the clear.  No one else is
going to volunteer to refactor this code if you don't.  ;)

With regards, to ignoring static checker warnings.  These are one time emails.
There is always going to be a certain percent of false positives.  You're
*encouraged* to ignore static checker warnings unless it's a bug or it makes the
code cleaner.  The goal is never to silence the checker.

regards,
dan carpenter

