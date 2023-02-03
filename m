Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C8529A2
	for <iommu@lists.linux.dev>; Fri,  3 Feb 2023 12:05:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D4BC433EF;
	Fri,  3 Feb 2023 12:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1675425917;
	bh=0lFtytynqLkq8kJIpsrWpdqTQgna4urzc2JF1yxsxnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f7LxKwIiJWDREcPzlQp1Nkr+1E8PUzD8RvgkDrmri/8BGgRxfmZZimGAEqBclIh5I
	 zbzwUvBvW7UzIhIQqprXumtriCc06ocpOHEMEQ+KyAo6s5uLjOlOhw+je87zQFS6vd
	 EmLglq/qb/MZD1/rX+U+WeRfI5BdgeG5/815jRCBAkI2zSXdPzy2gNlGjiv2eKB6ei
	 +kxZARRrrwiDwHcy+VmM9G7v1aUQp3evao/BqzVe+qQDQwN3gE2mijzgvYu2g6gKPz
	 tRSlmdT+XOD7p7PVi0wvUQNIwhr7DWTjVpeNKKleNRDPeZKABj9iLjzDd16z/YFchJ
	 UoxYycFh9AapA==
Date: Fri, 3 Feb 2023 12:05:11 +0000
From: Will Deacon <will@kernel.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, robin.murphy@arm.com, joro@8bytes.org,
	darren@os.amperecomputing.com, scott@os.amperecomputing.com
Subject: Re: [PATCH] iommu/arm-smmu-v3: Enable PCI ATS in passthrough mode as
 well
Message-ID: <20230203120511.GA6274@willie-the-truck>
References: <20230202124053.848792-1-gankulkarni@os.amperecomputing.com>
 <Y9z3UG+wEBn4i3G2@myrica>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9z3UG+wEBn4i3G2@myrica>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Feb 03, 2023 at 12:00:16PM +0000, Jean-Philippe Brucker wrote:
> On Thu, Feb 02, 2023 at 04:40:53AM -0800, Ganapatrao Kulkarni wrote:
> > The current smmu-v3 driver does not enable PCI ATS for physical functions
> > of ATS capable End Points when booted in smmu bypass mode
> > (iommu.passthrough=1). This will not allow virtual functions to enable
> > ATS(even though EP supports it) while they are attached to a VM using
> > VFIO driver.
> > 
> > This patch adds changes to enable ATS support for physical functions
> > in passthrough/bypass mode as well.
> [...]
> > @@ -2453,8 +2458,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
> >  
> >  	master->domain = smmu_domain;
> >  
> > -	if (smmu_domain->stage != ARM_SMMU_DOMAIN_BYPASS)
> > -		master->ats_enabled = arm_smmu_ats_supported(master);
> > +	master->ats_enabled = arm_smmu_ats_supported(master);
> 
> I should have added a comment for this. Only found the reason in an old
> cover letter [1]:
> 
> "When no translation stages are enabled (0b100), ATS Translation Requests
> (and Translated traffic, if SMMU_CR0.ATSCHK == 1) are denied as though
> EATS == 0b00; the actual value of the EATS field is IGNORED. Such a
> Translation Request causes F_BAD_ATS_TREQ and Translated traffic causes
> F_TRANSL_FORBIDDEN."
> 
> (See 3.9.1.1 "Responses to ATS Translation Requests and Translated
> transactions" and 5.2 "Stream Table Entry")
> 
> So I don't think we can enable ATS for bypass domains :/ The PF needs to
> be in translated mode in that case.
> 
> I can send a patch adding the comment next cycle.

Yes, please!

Will
