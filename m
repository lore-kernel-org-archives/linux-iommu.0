Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772781E51F
	for <iommu@lists.linux.dev>; Thu, 10 Aug 2023 16:27:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AEA2C433C8;
	Thu, 10 Aug 2023 16:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691684870;
	bh=dTku1OjG3tbVRFq4kPSk5Upl89gZucyzeix7zMe8F4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iNo3vyzOHxV6dXUgQTscPsYAGXN8vOsYys+mEl3VLZ9agM6D+LtxCdFoZQzwdYFtr
	 jn9SukqhEh1T4ariWZ9YMyZrCIyrx8qXWt1Ei4+gYsWkfpe3dF7USgCbeUfh1L4TfB
	 HToZvdGHnVb4wqMrrzXFaaj96huazjiZa8PnkB2lDB4myCP9VUCaIcLj99w2oRO+oB
	 kgMJPYvaB2eGjvaDhJ35SZY/UamKdQRYhsnKr7Tzw0SeBB2MTOM1SQxUMnpDXSJYHH
	 9iu6GJpgbEOLSLvd5UJ+f17sOF9NhX/ekXceAxZhB3b15eerMLGW06daUCQDyjMWhL
	 P/ANLN3Sefi/w==
Date: Thu, 10 Aug 2023 17:27:45 +0100
From: Will Deacon <will@kernel.org>
To: Michael Shavit <mshavit@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	nicolinc@nvidia.com, jgg@nvidia.com, jean-philippe@linaro.org
Subject: Re: [PATCH v5 8/9] iommu/arm-smmu-v3: Skip cd sync if CD table isn't
 active
Message-ID: <20230810162745.GB5951@willie-the-truck>
References: <20230808171446.2187795-1-mshavit@google.com>
 <20230809011204.v5.8.Idedc0f496231e2faab3df057219c5e2d937bbfe4@changeid>
 <20230809135011.GC4226@willie-the-truck>
 <CAKHBV27LROax9-biR4ius2sXBYM+oJA82GTxsBo_LCd6zxVNgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKHBV27LROax9-biR4ius2sXBYM+oJA82GTxsBo_LCd6zxVNgA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Aug 10, 2023 at 04:34:39PM +0800, Michael Shavit wrote:
> On Wed, Aug 9, 2023 at 9:50 PM Will Deacon <will@kernel.org> wrote:
> >
> > On Wed, Aug 09, 2023 at 01:12:04AM +0800, Michael Shavit wrote:
> > > This commit explicitly keeps track of whether a CD table is installed in
> > > an STE so that arm_smmu_sync_cd can skip the sync when unnecessary. This
> > > was previously achieved through the domain->devices list, but we are
> > > moving to a model where arm_smmu_sync_cd directly operates on a master
> > > and the master's CD table instead of a domain.
> >
> > Why is this path worth optimising?
> 
> I have no idea what the practical impact of this optimization is, but
> the motivation here was to make the overall series as close to a nop
> as possible. This optimization existed before but is "broken" by the
> previous patch. This patch restores it.

I'm not sure it's necessary, tbh. It's not like we're calling
arm_smmu_sync_cd() all over the place -- it's used when we're actually
working with the CD.

> > Doesn't this interact badly with the sync in arm_smmu_detach_dev(), which I
> > think happens after zapping the STE?
> 
> The arm_smmu_write_ctx_desc call added in arm_smmu_detach_dev() was
> inserted after zapping the STE precisely so that we could skip the
> sync. Is there a concern that a stale CD could be used when the
> CDtable is re-inserted into the STE?

Ah, sorry, I went and looked at the architecture and it says for
CMD_CFGI_STE:

  | This command invalidates all Context descriptors (including L1CD)
  | that were cached using the given StreamID.

so as long as we make the CD unreachable in the STE before the STE
invalidation (which I think we do by setting the Config field to bypass or
abort), then I agree that we don't need the subsequent CD invalidation.

> > >               /*
> > > -              * STE is live, and the SMMU might read dwords of this CD in any
> > > +              * STE may be live, and the SMMU might read dwords of this CD in any
> > >                * order. Ensure that it observes valid values before reading
> > >                * V=1.
> > >                */
> >
> > Why does this patch need to update this comment?
> 
> This is a drive-by to make this comment more accurate. Note how
> (before this patch series) arm_smmu_domain_finalise_s1 explicitly
> mentions that it calls arm_smmu_write_ctx_desc while the STE isn't
> installed yet. Yet this comment asserts the STE *is* live.

Can you do it as its own patch then, please?

Will
