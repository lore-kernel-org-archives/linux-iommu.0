Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85721E1A2
	for <iommu@lists.linux.dev>; Thu, 10 Aug 2023 14:40:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F10C433C7;
	Thu, 10 Aug 2023 14:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691678457;
	bh=qIjgpMCMchGb8GSzUQvWxpoDDxQOmNK9dlfrexgl7S8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P9HdELJhhcOK5bhsUbkMOury6WbB2zebnKCKQG2KAbUtvi76HksnWxm3/V5V2KMQl
	 H6pU16EteNOTPbC49IeCG0peGkze+i7d2z6+jbNqsKmABWlMJtPtmOZAS1aruzXxDE
	 OB05/iZ4ELrUNserg3658J4p1s7a/M/VmrtdnY6b5edxzLZ1P1fSPoGIh5lFrGhvZ5
	 +p5VoG2bWJnCEgtaaJWqlHrViq5kohkkTnRr73+eHDoIuv9CA0KdWNGZ1jkF5A0U2K
	 kgmkeRoCk3Qu/nrQulymx74DBiw1QaOJpWTlx14XRFEJTu4Q/J+DzApCQZHrYOM/MH
	 0A0yvKeOSl1QA==
Date: Thu, 10 Aug 2023 15:40:52 +0100
From: Will Deacon <will@kernel.org>
To: Michael Shavit <mshavit@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	nicolinc@nvidia.com, jgg@nvidia.com, jean-philippe@linaro.org
Subject: Re: [PATCH v5 5/9] iommu/arm-smmu-v3: Refactor write_ctx_desc
Message-ID: <20230810144051.GD5795@willie-the-truck>
References: <20230808171446.2187795-1-mshavit@google.com>
 <20230809011204.v5.5.I219054a6cf538df5bb22f4ada2d9933155d6058c@changeid>
 <20230809134959.GB4226@willie-the-truck>
 <CAKHBV25CQYfqm80a1ztHXn3s6kj7KCuJBwJz4EZk5cog4n6R+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKHBV25CQYfqm80a1ztHXn3s6kj7KCuJBwJz4EZk5cog4n6R+A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Aug 10, 2023 at 05:15:50PM +0800, Michael Shavit wrote:
> On Wed, Aug 9, 2023 at 9:50 PM Will Deacon <will@kernel.org> wrote:
> >
> > > -     ret = arm_smmu_write_ctx_desc(smmu_domain, mm->pasid, cd);
> > > -     if (ret)
> > > +     ret = arm_smmu_write_ctx_desc_devices(smmu_domain, mm->pasid, cd);
> > > +     if (ret) {
> > > +             arm_smmu_write_ctx_desc_devices(smmu_domain, mm->pasid, NULL);
> >
> > Why is it safe to drop the lock between these two calls?
> 
> Hmmm this is a tricky question.
> Tracing through the SVA flow, it seems like there's a scenario where
> multiple masters (with the same upstream SMMU device) can be attached
> to the same primary/non-sva domain, in which case calling
> iommu_attach_device_pasid on one device will write the CD entry for
> both masters. This is still the case even with this patch series, and
> changing this behavior will be the subject of a separate follow-up.
> This is weird, especially since the second master need not even have
> the sva_enabled bit set. This also means that the list of attached
> masters can indeed change between these two calls if that second
> master (not the one used on the iommu_attach_device_pasid call leading
> to this code) is detached/attached at the same time. It's hard for me
> to reason about whether this is safe or not, since this is already
> weird behavior...

I really think the writing of the context descriptors should look atomic;
dropping the lock half way through a failed update and then coming back
to NULL them out definitely isn't correct. So I think you've probably pushed
the locking too far down the stack.

Will
