Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3EDAD51
	for <iommu@lists.linux.dev>; Wed,  2 Jul 2025 01:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751420325; cv=none; b=pQoDviRGSzTtzP83Sk2ppK5oYitF3p5patB1XZXNSjYXrm0qq/4dwrxXa2UFggQnlXOaHR3x4sz4E6yCmWTus9KOTXHki5pXmsdaE9qMbmXJSiNIEFhsc34lr36oPc29+9oJzs5OiFpE1OgljCx6TH/jclUmQ/tMm+QRiqB87BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751420325; c=relaxed/simple;
	bh=vPktWFba1CaphVOiurjNVMsrvjbgo6h4NsplM3lBGxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWVjqfq6M/Z9B7KmulWowmYPRSWrh2Jc8HAeTshiMRcWcBGCHIyLEE5WzLLll9W58NnNRGVjPWYAoUJyc+mzufoXWSAtGuqifQ/Wdu6fB/6Nawf+XQkByP+6LbIMX56ducH3dsNyT0U7fgVH5pqY6KeeevAKc00puB2Jsah2zMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l+ik+NHg; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l+ik+NHg"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-237f18108d2so319225ad.0
        for <iommu@lists.linux.dev>; Tue, 01 Jul 2025 18:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751420323; x=1752025123; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kp2cPDX2Gx1yqqbKf91cIrL6zATVqvS/PN2+ecRrrmc=;
        b=l+ik+NHgmz2d3TXzEWNXWOsIkUjSVCH9Nb5gvq2UKemHtCjPyO/Ox7b6JX7GJbqvp6
         yC/BvqzPE/Z9m0xpgkN9SEcKMdXPM5AZt1X8dIzysHAHamAOInA8Rn2W1rBVJ0jdfv5d
         Yk6vVAseBtHD1QDlApYCRil8sJFjOJgDlKcP8SbPyGtF/BTeHUXQK6Iz19XZZQ3EnG2i
         xPZokgjjn5SlM6VKmDs3WJlj1uIsTnY+FxS/q6zwfpZMsMGAiVcv7DZMrjD7Ax2Hsyfb
         j2P1hkDYwT1zaK/+howsD94LDAhCPSUILAGEKnMdXV4txdOEqPk9dVhcsjoV6Zgdyz3V
         UcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751420323; x=1752025123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kp2cPDX2Gx1yqqbKf91cIrL6zATVqvS/PN2+ecRrrmc=;
        b=JjrSU6rxC39Pee4DHDoR1BqpVnCYY7aVt+ZwazP8xsbDKFVPIHF3Y6g/DbCZArWHDf
         oU1HpOn0MGdburYzLVddJPoG/Bc1NSRnlBAR1EH1nCVOPALOkciS9XuBPIfBjdw3Hm8S
         MWc4b7qRkZ+H9F+ANR8EPcThxOCAFx0+16XJdSZQCGknsWd2o66jM2tkgQz2erGfOY5W
         e5/s5Yn9r1LElpU2AFLKjEJMZkdf5N1MOiVIGhR0fEqHYD8Yri5WhQlBdtW5iFkm6n4O
         1BfdfIQsUua3Pu2fJ+L46/6z8IvAGi98rluO1oLCLix0KTUWx+pxgoMLxbTQsFq6mtGd
         vVNw==
X-Forwarded-Encrypted: i=1; AJvYcCXUxvRVAFaR1QhlhS+3B+tqlsp3jDoIMkOsteVVs/qHFYTkrBqcE/hWnOY32TKuwnAoBQOhjQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxG+EOE2LaXTd6oZjs6Yv3lodm5OQ4l8BLMaAmDbnIyVoN1MnWe
	FNUU3SILgYQiyx2tACXQkcTvzrIhYJ4bZ4CfoOTRk53WxRgDy0AEUJwD6bJpRWdn5g==
X-Gm-Gg: ASbGnct0/7grL5nBxH0C7eSRrG3yPJ5M6vPt7Us54IDVvC7SMm+VZCeNDvBNOvula6F
	WR5d11vSwgC2yXRGzxeOoBZHxotx9qi70oTMPaAJAvbnOxsw/UX+oSWKmXeoadyE8sxHy+Jyytk
	UHcIv69RH7D1XYB4kFzk6O9NKp97jywvCgJRAOvb+MFH3rIPzYIk00f/rCweum6oDBQIDAgrjkw
	HELRKTReX/GCT+SNFeS92FmtShgPZh8a7eiDwZkAXi5ARuDIqtinuuF8EXxn49uQco2e2eKIUTa
	ijka7sm0kr2jDLScZCMxhrq+no7UrG9DIM5ezHz3pSulBCZ6RYu8E+hiuVfulLX7Br3eV6NE801
	S5Fe4tOKeLB4RQYxTJNWb
X-Google-Smtp-Source: AGHT+IGlz2Z9E445R3idcc5ZRjEaWuytfr7E4KLC8vSsZvwO+Dw22SVfjYoD7L1quVzpUqXy09mcbA==
X-Received: by 2002:a17:902:c401:b0:235:e1fa:1fbc with SMTP id d9443c01a7336-23c5fd70ee8mr4718365ad.0.1751420322911;
        Tue, 01 Jul 2025 18:38:42 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af540b394sm13073470b3a.36.2025.07.01.18.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 18:38:42 -0700 (PDT)
Date: Wed, 2 Jul 2025 01:38:33 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
	peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
	zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v7 27/28] iommu/tegra241-cmdqv: Add user-space use support
Message-ID: <aGSNmf5Q82xEbDpX@google.com>
References: <aGQGm1-i4M75b9Qp@google.com>
 <aGQ6KCI9OZEwHdxS@Asurada-Nvidia>
 <aGQ_F7Qx3scbbA-J@google.com>
 <aGRDtYRXFLoT+PrI@Asurada-Nvidia>
 <aGRIctg4T6cQECx4@google.com>
 <aGRcPSwaJkTeUrMx@Asurada-Nvidia>
 <aGRmaOORg-YDfncY@google.com>
 <aGRozoIDIlgl9H9x@Asurada-Nvidia>
 <aGR55PUBnwb8qT8U@google.com>
 <aGSBTpY0nkdp2TTL@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGSBTpY0nkdp2TTL@Asurada-Nvidia>

On Tue, Jul 01, 2025 at 05:46:06PM -0700, Nicolin Chen wrote:
> On Wed, Jul 02, 2025 at 12:14:28AM +0000, Pranjal Shrivastava wrote:
> > Thus, coming back to the two initial points:
> > 
> > 1) Issuing "non-invalidation" commands through .cache_invalidate could
> >    be confusing, I'm not asking to change the op name here, but if we
> >    plan to label it, let's label them as "Trapped commands" OR
> >    "non-accelerated" commands as you suggested.
> 
> VCMDQ only accelerates limited invalidation commands, not all of
> them: STE cache invalidation and CD cache invalidation commands
> still go down to that op.
> 

Right, I'm just saying the "other" non-accelerated commands that are
NOT invalidations also go down that op. So, if we add a comment, let's 
not call them "non-invalidation" commands.

> > 2) The "FIXME" confusion: The comment in arm_vsmmu_cache_invalidate
> >    mentions we'd like to "fix" the issuing of commands through the main
> >    cmdq and instead like to group by "type", if that "type" is the queue
> >    type (which I assume it is because IOMMU_TYPE has to be arm-smmu-v3),
> 
> I recall that FIXME is noted by Jason at that time. And it should
> be interpreted as "group by opcode", IIUIC.

I see.. I misunderstood that..

> 
> The thing is that for a host kernel that enabled in-kernel VCMDQs,
> those trapped user commands can be just issued to the smmu->cmdq
> or a vcmdq (picked via the get_secondary_cmdq impl_op).
> 

Ohh.. so maybe some sort of a load balancing thing?

> >    what do we plan to do differently there, given that the op is only
> >    for trapped commands *have* to go through the main CMDQ?
> 
> If we do something differently there, it could just do a one-time
> get_secondary_cmdq call to pick a in-kernel vcmdq over smmu->cmdq
> to fill in all the trapped commands.
> 

Alright.

> And this is not related to this series at all.

Agreed, sorry for the confusion then.. I thought that the "type" meant
the queue type.. I guess it's all done then. I have no further questions

Thanks for the clarification!

> 
> Nicolin

Praan
