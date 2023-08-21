Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1270D1C3D
	for <iommu@lists.linux.dev>; Mon, 21 Aug 2023 10:42:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A863C433C8;
	Mon, 21 Aug 2023 10:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692614572;
	bh=XnwUB514PPCDbHd6aAR29S9FdVfiRdORES8i2CcbAFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a5QpjJIWaWBVQFquS5BaAK1jjl/dAdClZj/ZErMCv8PiBda1NJF2FCHOz4u1Tz7qm
	 lBteEy+WFVjjQHs2OsVdWPMhJB2XhqyJyVJqCXiTpMQV4cO4MJYKwGkrnd053nlkfH
	 0TNzt9SWggDfAlMt2sW7/1Cat4SRWzGW1MC3jReg/gDKqgnp274GDjanq5LEQuYwKK
	 o8blznHtlaLByL3ZzrLNBNpqTZUlN/pPryWWywztYgVF98KrkLbkaqnr2XzL3z2oCi
	 5cceIc8VhkyhGIhtkF7KK0JX8dBZL5+GsL8hb44pxzMwIDnmz+xlKOwwuqSuLAtm4W
	 /WgoCS8wD9CFQ==
Date: Mon, 21 Aug 2023 11:42:47 +0100
From: Will Deacon <will@kernel.org>
To: Michael Shavit <mshavit@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	jean-philippe@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com
Subject: Re: [PATCH v6 09/10] iommu/arm-smmu-v3: Skip cd sync if CD table
 isn't active
Message-ID: <20230821104247.GA19469@willie-the-truck>
References: <20230816131925.2521220-1-mshavit@google.com>
 <20230816211849.v6.9.Idedc0f496231e2faab3df057219c5e2d937bbfe4@changeid>
 <CAKHBV274tBz2ydskRfghR2C_u-ibxh9MuEn3dGSaS7tGm8FuTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKHBV274tBz2ydskRfghR2C_u-ibxh9MuEn3dGSaS7tGm8FuTQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Aug 21, 2023 at 06:16:08PM +0800, Michael Shavit wrote:
> On Wed, Aug 16, 2023 at 9:20 PM Michael Shavit <mshavit@google.com> wrote:
> >
> > This commit explicitly keeps track of whether a CD table is installed in
> > an STE so that arm_smmu_sync_cd can skip the sync when unnecessary. This
> > was previously achieved through the domain->devices list, but we are
> > moving to a model where arm_smmu_sync_cd directly operates on a master
> > and the master's CD table instead of a domain.
> >
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> > Signed-off-by: Michael Shavit <mshavit@google.com>
> > ---
> > Happy to drop this commit if we don't think it's useful.
> 
> Hi Will,
> Do you have any recommendations for keeping or dropping this commit in
> the end? It's only purpose is to minimize any potential performance
> impact from the refactor but can certainly be dropped if you don't
> think it's worth the complication.

I'd prefer to drop it unless somebody can measure the benefits that it
brings.

Will
