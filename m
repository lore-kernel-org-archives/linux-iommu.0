Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CCF3596E8
	for <iommu@lists.linux.dev>; Fri,  9 Jan 2026 09:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767950830; cv=none; b=e4dCHJzt5e4cS2QyvgPgPzER87Cz/sG0+A7yF/VWA70Pz0VBSteNVlHWBYQ+HknJyPjzmDFikXp3Yqb99DrXeqwdd4pyNAyrkC07xFL5YFzIo7zyKUDimPjQzzNZX/2C5ioUhDsYEGF2f5/+5ce6p7/11VvsRW9RSxpNLlgUa60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767950830; c=relaxed/simple;
	bh=ttAsDYBjr9+AAKnLH15MfAvzPA3bn3B6sE13eniF7OA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUtnnyZDAe8i5BzATYSes0uRS9MnCQE1ES4eEKLNfIl4QEmh3YLS6LMjnAIDsOfVs+BCLLWQ5yspPj0nNomrihOJpFxxoex0wQNcsOGwyfR0M7vSQ54pKQzfgZJkub9AGudTJCQwNKGYwD6Vf0Mh6bd67Rfcv66fUcgm9gx5zIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m7HVSe8o; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m7HVSe8o"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-4327555464cso2312053f8f.1
        for <iommu@lists.linux.dev>; Fri, 09 Jan 2026 01:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767950827; x=1768555627; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z056gdaBGJYpZh5RAuVD8uudiJ6oWt4yO8116qnzGIA=;
        b=m7HVSe8oIGNkgNXN3UvNm3w6eqcOTI8LTFy9E5fwGc9/ar+qwMqlzsMl/h2SEyHlI4
         tBHEElF2eBCwdtdWYaSU9rhpn3D29dm4dHMfz85vAb0vB0QeLMww+pJevLI1QBzCuPEg
         FsFwY8XCN9Xy1ayKVBrDDkSEPW6TsKxg7++0rlfMpv0DYYL8os2NgyELVyhtySSMD7Ow
         Oo80txqsdT+deebu7u5+frKPhCtAoiOQOlL45h7sZ482VklAj17TO2F2WzfcJu4qW2y7
         /qeCDtnEpLE4K+R1BBiV+E3ehPTlBbQhGo6ySEIRzZGDHbzB+p88Q2SR7MaJDIdh4Lv2
         qxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767950827; x=1768555627;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z056gdaBGJYpZh5RAuVD8uudiJ6oWt4yO8116qnzGIA=;
        b=IZ2Pvz4aZ7mXy5tNEeZSJFPC8UI1Dv2HjTYwlXW3Jd1UFX3EeazoQZacjC0adV443q
         c8MkhJWXF22Jpc8+c0NSJG6n8Pfawhf3S6Fx1Q6w/gp9d8tfDb1iH4sAM+swKvpKnNSg
         P+dDo+gmcRbTEX3/kWaoJ8V4c2wlqfJ3+qykzcmkRs064UBGT6B/wNrIeQG25Cs3DYr9
         lGXz6BlxGQ0LmoO5cCFa29xOkcuP8MXJvzfLjFM8NKM/ooRvmnhXRCVfy8iYJPq6rPp1
         /Nzl3Fy8zJy1jFAUCjKbScEL4OmzdiD2z5ESGj4htNi9FiH4tyFMtKsuTV0Y69GYDQo1
         iFnA==
X-Forwarded-Encrypted: i=1; AJvYcCUy/HFyb9iz7KKDanM90400qFprQDPPUW8gJI5tnDfc47vLuP6roeEcR958yl1PcznE8cGU2g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyrpzeyGNLMUz5zhdc6h30yH4InqkLyKblOZQR/tXy1rrplg3X1
	GpS8jWEKFbu3gDl49hdQYROZ+n3v8g9UVLwDahA7FANv8eBDWF3SkluL7+Bn43WnJyw=
X-Gm-Gg: AY/fxX7xZm4OzOw6VfpPhZBy0sQJj8EraNVPJfH9V6kdzoJfbqjnX44AWIDACUlMjEv
	LbJ6uw4BUd3YY5tMEPgAxyBGi6wm8S0fBbioaVEufBzh4OhBrs3SdG1KytgFY5jQIPqD6BsU93U
	6bUHGYM/3mMRoxQt02UgdVbEbNxSqLTBfeLg87mtvQU12mLCPAL33ugGIbyD6ahwBnGz5aNfKo+
	rojY5JTmbKKutU0++Jv6sNMoufM2rFhHwI/gS9DEPuADeauo5h6Gvh/G5oMsJzrgwKGv6cSvuPr
	OCslYG3vEvpf6z53q7GN/zd3O0GrdyQxtUJHHalAX3pJlQCI2hy2DdfjRRU5FUwy3vwOELj7bjn
	ia9OzmHG0Z9/SYmmSy9ipV5J6xU8gHndB6bn9K3CCfU3aedlY78aj0zY0gQ5woO/qYgUFak9PvF
	ttTlXllgGwziVaEK+I
X-Google-Smtp-Source: AGHT+IHGEE558Ypawf1N0D/PfF+kFXDSmDZa1cnIjVVu45cBHmCPRkreIC0JvO646k8QflO4jCUK0w==
X-Received: by 2002:a05:6000:26c2:b0:431:8f8:7f24 with SMTP id ffacd0b85a97d-432c379d19emr10849333f8f.39.1767950827126;
        Fri, 09 Jan 2026 01:27:07 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e19bfsm20920486f8f.18.2026.01.09.01.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 01:27:06 -0800 (PST)
Date: Fri, 9 Jan 2026 12:27:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Cc: joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
	robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Vasant.Hegde@amd.com,
	Sairaj Kodilkar <Sairaj.ArunKodilkar@amd.com>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH] iommu/amd: Use array_index_nospec() for rlookup_table
 index
Message-ID: <aWDJ50AUsjwtrI1j@stanley.mountain>
References: <20260109052040.938-1-dheerajkumar.srivastava@amd.com>
 <aWCakni4dwgJpuE_@stanley.mountain>
 <c591995e-7b4d-4246-ac8f-2bc96d44a2bc@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c591995e-7b4d-4246-ac8f-2bc96d44a2bc@amd.com>

On Fri, Jan 09, 2026 at 02:19:03PM +0530, Dheeraj Kumar Srivastava wrote:
> Hi Dan,
> 
> On 1/9/2026 11:35 AM, Dan Carpenter wrote:
> > On Fri, Jan 09, 2026 at 10:50:40AM +0530, Dheeraj Kumar Srivastava wrote:
> > > Use array_index_nospec() to prevent speculative out-of-bounds
> > > access when indexing pci_seg->rlookup_table with a user provided
> > > device id.
> > > 
> > > Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
> > > Reviewed-by: Sairaj Kodilkar <Sairaj.ArunKodilkar@amd.com>
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Reported-by: Dan Carpenter <error27@gmail.com>
> > > Closes: https://lore.kernel.org/r/202510281233.q4cBnp3z-lkp@intel.com/
> > 
> > This is interesting because more and more people are using lei to
> > recieve email and now they get unfiltered Smatch warnings from zero day
> > bot.
> > 
> > Normally, I just ignore these warnings because they're hard to review
> > and I recently modified Smatch to stop the zero day bot from warning
> > about them.
> > 
> > The problem is that I've tried to contact people from Intel to help
> > review some of the warnings but I've never recieved a response.  I've
> > heard that Intel has a handful of people that deal with Spectre v1 bugs
> > but I've never seen any evidence of that...  I've never tried reaching
> > out to AMD.
> > 
> > > ---
> > >   drivers/iommu/amd/debugfs.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
> > > index 10fa217a7119..4990f6db99ef 100644
> > > --- a/drivers/iommu/amd/debugfs.c
> > > +++ b/drivers/iommu/amd/debugfs.c
> > > @@ -174,6 +174,7 @@ static ssize_t devid_write(struct file *filp, const char __user *ubuf,
> > >   			kfree(srcid_ptr);
> > >   			return -EINVAL;
> > >   		}
> > > +		devid = array_index_nospec(devid, (u32)pci_seg->last_bdf + 1);
> > 
> > This is debugfs so it's already root only.  The cast to (u32) is
> > unnecessary.
> > 
> 
> I agree that the (u32) cast is unnecessary here and will remove it.
> 
> When you mentioned that this is debugfs and therefore root-only, could you
> clarify the context of that comment? I just want to make sure I’m
> interpreting the rationale correctly.
> 

Debugfs is always read only unless you are root.  Anything else is insane.
So it's like sure, this patch is correct from a correctness point of view
but in terms of is this exploitable?  No.

regards,
dan carpenter

