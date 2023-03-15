Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03A4525D
	for <iommu@lists.linux.dev>; Wed, 15 Mar 2023 13:37:38 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so2008362pjz.1
        for <iommu@lists.linux.dev>; Wed, 15 Mar 2023 06:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678887458;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YePAT7cRSVCK2M5mNZ0SrXrbIX/sKHS6O/ir9QF/3YA=;
        b=sWwAOsbgy+eqbrZ35YrkSLBldjwCCxqfc/OtqiTkZhbNBBnoqgR26+xqgxk+vKQM9w
         a/rGmYCNTZtX0JtYPCXu4+mn488ZfVCHPnIIW5oCgnA4bd5MYmumJ2Eo0syFsNxrAs0x
         a5paUBLKgUBJNXJOIvt3nVSVO9qglDnUIFWGubuN+d3LB+y+dToOAanWfbnPCaCj8TZP
         QsCqx36GxIUgXRZ2ytHXfPBmQsE5tUvY6gS6jsqc/jBlHOS9IX5m9k0gQRa+coqtCVyo
         V8DhH+QUlHEXkwLEnvSebQeMj8vBGuPboKSqb/yresH1uCctR8z51d2T7fmW+zQgOspg
         mxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678887458;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YePAT7cRSVCK2M5mNZ0SrXrbIX/sKHS6O/ir9QF/3YA=;
        b=zgRlvxPrgZWD0RvHePk4/EdB06f3f3X/vGezyL7t1NhFY43mQRLO94HLDXi6Qg2cLg
         sR+rtk/oJ3ImiAcJUstKTmnS8ok+pLTuATxpVvZRiM+oRS0eBIPuTrzl05yi9oZIj/eW
         PYAngm8jq8mQeP36BJEVF0rX9nTk9sIR+QpFVIUq8QktM3hN0OHu34IC3nkVBWykXlmy
         yefI25l1R90VuzKTsqQB40U/Bvx7aeUNqFsN3uYDFZCzke48UAaYok7N800nGspEuM5I
         gSHXjlHU0doNP5AMThGXWq25TzfJ1E7DDodJXQBCidl7LyApVaAGN0bjVl/zBw8suWri
         MR/g==
X-Gm-Message-State: AO0yUKUzuythG/nLm+/+2mk7ZOwQQTbj25jsnSHSN/IOtynwlo/aJVBz
	92KImRS6wZfKbBMl4UtPLQkR
X-Google-Smtp-Source: AK7set+5E8xt64b6V5eMrpg1l077mbaN0K4ExGQ3kvL4USwI7EPfUzhMUK96WTT/fV9x7Pjs4/kmlw==
X-Received: by 2002:a17:902:d4cd:b0:19d:af20:3fe8 with SMTP id o13-20020a170902d4cd00b0019daf203fe8mr2841030plg.21.1678887458252;
        Wed, 15 Mar 2023 06:37:38 -0700 (PDT)
Received: from thinkpad ([117.207.30.24])
        by smtp.gmail.com with ESMTPSA id g2-20020a170902c38200b001a04d37a4acsm3691872plg.9.2023.03.15.06.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 06:37:37 -0700 (PDT)
Date: Wed, 15 Mar 2023 19:07:30 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: will@kernel.org, joro@8bytes.org, robin.murphy@arm.com,
	andersson@kernel.org, johan+linaro@kernel.org, steev@kali.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iommu/arm-smmu-qcom: Rework the logic finding the
 bypass quirk
Message-ID: <20230315133730.GB98059@thinkpad>
References: <20230314184659.176473-1-manivannan.sadhasivam@linaro.org>
 <ZBF1vFBWKXhHeD2v@hovoldconsulting.com>
 <20230315075958.GC25575@thinkpad>
 <ZBGEEk1d1WtNq4lT@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZBGEEk1d1WtNq4lT@hovoldconsulting.com>

On Wed, Mar 15, 2023 at 09:38:42AM +0100, Johan Hovold wrote:
> On Wed, Mar 15, 2023 at 01:29:58PM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Mar 15, 2023 at 08:37:32AM +0100, Johan Hovold wrote:
> 
> > > > +static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
> > > > +{
> > > > +	u32 smr;
> > > > +	int i;
> > > > +
> > > > +	/*
> > > > +	 * Limit the number of stream matching groups to 128 as the ARM SMMU architecture
> > > > +	 * specification defines NUMSMRG (Number of Stream Mapping Register Groups) in the
> > > > +	 * range of 0-127, but some Qcom platforms emulate more stream mapping groups. And
> > > > +	 * those groups don't exhibit the same behavior as the architecture supported ones.
> > > > +	 */
> > > 
> > > Please fix your editor so that it wraps lines at 80 columns, which is
> > > still the preferred (soft) limit.
> > > 
> > 
> > If exceeding 80 columns end up making the comment more readable (fewer lines),
> > then why should we limit ourselves?
> 
> Exceeding 80 column for comments does generally not improve readability.
> 

It all depends on the perspective/preference... But I can limit to 80 columns
here.

> That part of the coding standard has do to with not adding excessive
> line breaks to *code*, where it can sometimes impact readability.
> 
> > > > +	if (smmu->num_mapping_groups > 128) {
> > > > +		dev_warn(smmu->dev, "\tLimiting the stream matching groups to 128\n");
> > > 
> > > dev_notice() should do since there's nothing a user can do about this.
> > > 
> > 
> > Ok.
> > 
> > > > +		smmu->num_mapping_groups = 128;
> > > > +	}
> > > 
> > > So this hunk is really all that is needed to make the current quirk
> > > detection work on sc8280xp. Why not simply stick with the current logic
> > > and use the last group until there is a need for anything more?
> > > 
> > 
> > No! What if the bootloader had set up mapping for 128 groups? In that case
> > we'll overwrite the last group. It is still required to find the valid group
> > and use it for quirk detection. If no group is available, we'll skip it.
> 
> Yes, but that's also entirely hypothetical (and could perhaps also be
> handled by adding a warning for now).
> 
> If you want to rework the quirk handling for this you should at least do
> so in a separate patch as it is arguably a separate change from fixing
> the current quirk detection for newer SoCs by capping the number of
> groups (a minimal fix that could be backported).
> 

Using a separate patch makes sense to me. Will do that in v4.

Thanks,
Mani

> Johan

-- 
மணிவண்ணன் சதாசிவம்
