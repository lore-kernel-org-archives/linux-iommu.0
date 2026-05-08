Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAE32F8EB8
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 17:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778260645; cv=none; b=j29Xk7hmpJ3pgygsuRd5DM9nnXuyjois9z0q0DUE+Cu/BkJwp7H239MbQ8eQbeEBn/cHak2Utzf5d7nww1KlvBiOcjVLQctqVqIyxu2YugW+ZngXVYQNslQlKO6x3HJOas1xa2LsP4BgAM9J7hc3zjIFamnERJWCxLEwbosXny8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778260645; c=relaxed/simple;
	bh=QvqG1+1JxnbU/5V2L4JChPDrJZMs7pfUYqcMmN79wGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N46A5+CqiJchgDCk2e1OA2G0dNAi2DMLSnj3yyhZ6kFw36Nn48MCKmh3pHxxSdFm1OkcGK7Ob3ShK+CWJ59FA1Qhf7tWrf2J1ZJM6ZFTPS7JU1qgwOmlC3Jsnvogdn6m2b5wf5Fs338qbtw7Q/3d91wDdEiEK0HciBBpACVX8wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pBaHG8dT; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pBaHG8dT"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b46da8c48eso1455ad.1
        for <iommu@lists.linux.dev>; Fri, 08 May 2026 10:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778260642; x=1778865442; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TI7X52J6aApGzF9MwcE5Wp5s+0QmxzGTZI8IYa2JNaY=;
        b=pBaHG8dTJLGJ94M9DF/nhWGXR7zVEM3Brov5dkQ7svUhVB2mL3W8urHNTLaWvlSCQZ
         hX6q+P1HpmfxVbo08Cs/GjAslLrynj7gfq19EqE+UFAkgP8q9lYMoBhSLCXwbXak/8gK
         knTMtWPSFCBr/Iqowt8kHCrUbqjwmlFcgKbP3dTkGP6eWR37ZDeZ977QPo3wwdbUuyve
         T/lnYQlHfFGip9hB/Ou/tLATGQrvAiCmjnYAc/D2NlJcliO+qMJcDfJyHuh3GfJ6gLaT
         NL0j8qSStDPD5pgBIQXyd432x/M+NCATgtrZkx/xOF8Nnoch8KeON50Y085manoG3FOn
         BTvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778260642; x=1778865442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TI7X52J6aApGzF9MwcE5Wp5s+0QmxzGTZI8IYa2JNaY=;
        b=rCu3gKhk+l/EzJ3jhgt1Qbby6NwIjBEoNdWrAYXuPpCrt+lH17/zFMe7pwizO26YJD
         wOzKuoayd78iArjUlTx+09Y5VsuK4DzllIbs57GP0fCGJzNKtqQXftsK+dBXts3u0ebI
         NR+QhtuK/m5JdP9bVnB8+WoGhvezPcYF1x5l0tiAi8pNs+xKs5S/6uJziWSAPYlA7Te+
         eUNukSynLsAzQr2ZzDwxjNr9itQXPdR/0RbA7tFKsFbFsczQw/G5RX8bKRTd2X/v5AiN
         zYXUknYWIFHFmoiJdzHS0zmuZj+SLoBBtXiCMeY6+OApZXEJ7BRagkGqvTX7bo2QqJhl
         gN0w==
X-Gm-Message-State: AOJu0YzXCSperDbjRKQqSYF/Zak4F7Xm3sqOSq1aFMZ7j1qzYCXDMC3r
	hWcK7l1YWdzz+xHzj2aEngZl8C0wCKiO1m0hYO9G7/7kLO6dYh6L2zLO2OCgFFUF4w==
X-Gm-Gg: Acq92OFnTABPdf1JGBYcjGhKod91EVAFLODPc0IPufcE1vzYqROq62XLDe3oW9lbdaN
	h0y9h955PsCPZPDW2oH4WV0Tx2Q7eZusFIDb3DL9X6MjMYVCBwyXBEJAbobuDtBrYuxe+Lvalxp
	zeCjQLO0hJjJL6VwgvZ7BzvJ1X3wctuWPnyvC3fRxZN4oPgKVXKL+T1bUL5FZPB4Oam0xT0D0t5
	Q5iKGa0NNvwsFUqGYXd3baBsRGhG9xhnb9tO7qqCGZgDizmcERNLatdReQUza4jaf30guXYJeYP
	ZkmqrLv3kdp8FNUoKSdRabctawrPXGAegvn+KmmuG3rMLlKs4Cx9e21TeBZEuETayabDtqPBtIL
	DLIRN2nUN0+qNeJArx+RNdJi5PEdBOAqd/e7/yYAerUv5wlyl7uB9y5v1wdd3s7sHnRx5/N56W8
	7RUzC04PafMgP0A2XnMDtsXsi5Lh2UYs5jOe4zfEvenx1Qptt+ejLyf0qzFtmJYFkzTkuR
X-Received: by 2002:a17:902:cecd:b0:2ae:45cc:aeb6 with SMTP id d9443c01a7336-2bc74753517mr64435ad.6.1778260641297;
        Fri, 08 May 2026 10:17:21 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367c2ccfbeasm311186a91.13.2026.05.08.10.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 10:17:20 -0700 (PDT)
Date: Fri, 8 May 2026 17:17:14 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Jonathan Hunter <jonathanh@nvidia.com>,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Krishna Reddy <vdumpa@nvidia.com>, Will Deacon <will@kernel.org>,
	David Matlack <dmatlack@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	Samiullah Khawaja <skhawaja@google.com>,
	Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH 5/9] iommu/arm-smmu-v3: Remove CMDQ_OP_CFGI_CD_ALL from
 arm_smmu_cmdq_build_cmd()
Message-ID: <af4amt7Pzmq-xpLf@google.com>
References: <0-v1-b7dc0a0d4aa0+3723d-smmu_no_cmdq_ent_jgg@nvidia.com>
 <5-v1-b7dc0a0d4aa0+3723d-smmu_no_cmdq_ent_jgg@nvidia.com>
 <af2w01YI01Av0Wg5@google.com>
 <20260508160236.GG9254@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508160236.GG9254@nvidia.com>

On Fri, May 08, 2026 at 01:02:36PM -0300, Jason Gunthorpe wrote:
> On Fri, May 08, 2026 at 09:45:55AM +0000, Pranjal Shrivastava wrote:
> > On Fri, May 01, 2026 at 11:29:14AM -0300, Jason Gunthorpe wrote:
> > > Nothing uses this, just dead code.
> > > 
> > > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > > ---
> > >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 3 ---
> > >  1 file changed, 3 deletions(-)
> > > 
> > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > index b3ef001ce80d23..ef0907b1a2204f 100644
> > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > @@ -290,9 +290,6 @@ static int arm_smmu_cmdq_build_cmd(struct arm_smmu_cmd *cmd_out,
> > >  		cmd[0] |= FIELD_PREP(CMDQ_CFGI_0_SID, ent->cfgi.sid);
> > >  		cmd[1] |= FIELD_PREP(CMDQ_CFGI_1_LEAF, ent->cfgi.leaf);
> > >  		break;
> > > -	case CMDQ_OP_CFGI_CD_ALL:
> > > -		cmd[0] |= FIELD_PREP(CMDQ_CFGI_0_SID, ent->cfgi.sid);
> > > -		break;
> > >  	case CMDQ_OP_CFGI_ALL:
> > >  		/* Cover the entire SID range */
> > >  		cmd[1] |= FIELD_PREP(CMDQ_CFGI_1_RANGE, 31);
> > 
> > CMDQ_OP_CFGI_CD_ALL is also present in arm-smmu-v3-iommufd.c
> > I'm wondering if we should remove this from the iommufd.c file too?
> 
> > This op code seems to be unused since 5.15, if a guest is running the
> > same Linux driver, it will never generate this command anyway.
> 
> Yes
>  
> > Unless we care about Guest VMs running non-Linux OSes, 
> 
> We certainly do :)
> 
> And who knows, Linux might start using it someday!
> 
> Guest emulation has to cover all the commands a guest is allowed to
> execute, and that is what the iommufd code is doing.

Alright, it makes sense to keep it in iommufd fir diverse guests.
No further concerns.

Thanks,
Praan
