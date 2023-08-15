Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AF1101F2
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 10:19:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D65C433C8;
	Tue, 15 Aug 2023 10:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692094758;
	bh=e3RTHya1UOALxBcGLFqnI0iuhaDpwjhJ2Bpe8CJ5PAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fvYDYh2ixAEgo17/j0lP3XWYLHUgCFnKLFClqWVDLhgWScDu1cSfeVdSuO01gXKo3
	 Q2zz2OAlKv+63jwj/hohwq08LB2DTTlsYFXWaYOsEZUK7w+rN/nDHLe/L8yP/kJQ8I
	 tRM8dR/Jw6cbl6TzObd6UKYVRPc+rCGywKHDf8w/yr20zbcbB0ztLFB2LiIIu36wRz
	 p+xR1ibaJMTIjq4QueT8YoZeVb9b4iEA0gfqO9CGi3+aFZiW9BaGhDtUn75zkI6WLx
	 BhBE4/O9fOuieZ1ZS0+TymH6zTCS8TQTm/ec5Pmo5DcAURuBR34wwcM1cuoOi15jOW
	 //4ROxwX365Pw==
Date: Tue, 15 Aug 2023 11:19:11 +0100
From: Will Deacon <will@kernel.org>
To: Michael Shavit <mshavit@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	nicolinc@nvidia.com, jgg@nvidia.com, jean-philippe@linaro.org
Subject: Re: [PATCH v5 5/9] iommu/arm-smmu-v3: Refactor write_ctx_desc
Message-ID: <20230815101911.GA11399@willie-the-truck>
References: <20230808171446.2187795-1-mshavit@google.com>
 <20230809011204.v5.5.I219054a6cf538df5bb22f4ada2d9933155d6058c@changeid>
 <20230809134959.GB4226@willie-the-truck>
 <CAKHBV25CQYfqm80a1ztHXn3s6kj7KCuJBwJz4EZk5cog4n6R+A@mail.gmail.com>
 <CAKHBV27iMDaU3RgJSVFva0UBmyKD8oJEtzDU7PJ4LuPGWAjCCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKHBV27iMDaU3RgJSVFva0UBmyKD8oJEtzDU7PJ4LuPGWAjCCA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Aug 15, 2023 at 01:04:43PM +0800, Michael Shavit wrote:
> On Thu, Aug 10, 2023 at 5:15 PM Michael Shavit <mshavit@google.com> wrote:
> > On Wed, Aug 9, 2023 at 9:50 PM Will Deacon <will@kernel.org> wrote:
> > >
> > > Since you're dropping this and relying on the lock being taken higher up
> > > callstack, can we add a lockdep assertion that we do actually hold the
> > > devices_lock, please?
> >
> > Will do!
> 
> I spoke too soon; the point of this change was to remove the
> dependency on the arm_smmu_domain, piping the devices_lock would
> defeat this. In fact, this section is really depending on the iommu
> group lock not the devices_lock.

Sorry, but I'm not following you here. What is the devices_lock protecting
if we're depending on the group lock?

Will
