Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27EC37C0F1;
	Mon, 16 Mar 2026 09:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773654719; cv=none; b=uU43hS+ivkFdVVT26/h2AoaEaFetClI8xxRcMczV6foDVVAhFFfnn121GKifM6FKohNnvXOXQIk6bM/VBOb6pmd4Sg2q4jJLYN9hFsF/wgKDXunX6EazXlony9GtDAF80wzLv3hJSlBS2j4xOIFv2ZwD7QTcy/auaLRSxu5E7uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773654719; c=relaxed/simple;
	bh=dWqTxPEv0rJnbD0A/giMkq8rXWjxwOit5RWD2M0x6Kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekgglF+ZyLCSIC06biIpjQgpi9IR//8/VW3F1GvZNkRrDvHTZrupKvoDX7CFnIMUmz1tcY7UoZeCX4wt4OkEn5GMCDhanoWzDay8hIkSX7CIJZ3LsDaKNBnw6mPV8XInxdMeP/RvNHRHTT1Oa1HV7qoVhSk11zXFJ8VULqWyAZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfJ7JRHo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfJ7JRHo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74F0C19421;
	Mon, 16 Mar 2026 09:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773654718;
	bh=dWqTxPEv0rJnbD0A/giMkq8rXWjxwOit5RWD2M0x6Kk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UfJ7JRHo//YxiHNKZxas9fCeACoLF5pyxb79vS82a3/N/IcGjfdsMPPiu1BfQNNVV
	 XHoQnppZgQDLn9+1wB7kytU8AkfADKa641zIcUKnB7j+8vL5ZGFF3IF+eIk3Y3PLCE
	 EjZmmz+DykNzNiiD1Pc+Ux7MyC78Aucq1iq6KPZLqSYUiYGE44hGEHsIkULAgtxL7x
	 4wUqtLhS4Gv69bF+8uQKpiNo+VDjL4ORgwnhOfFkEKVJ2jffKBv3adpJxZo+ftbAB2
	 +e1KEjzFqVL4lShD4eSeT4jur3l9W1fIJFP9D1zY7Mw5MG1F6oOqltIkVwWs4flCwU
	 YQfDpJYqabL5Q==
Date: Mon, 16 Mar 2026 09:51:51 +0000
From: Will Deacon <will@kernel.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Dmytro Maluka <dmaluka@chromium.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] iommu: Lift and generalize the STE/CD update code
 from SMMUv3
Message-ID: <abfStwmSjgy--e4H@willie-the-truck>
References: <20260309060648.276762-1-baolu.lu@linux.intel.com>
 <20260309060648.276762-2-baolu.lu@linux.intel.com>
 <aa9W4ZKYWHr9-UNy@google.com>
 <aa9fQchZJER8QvY0@google.com>
 <61267acf-e42e-4d1e-9942-e241ccffa606@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <61267acf-e42e-4d1e-9942-e241ccffa606@linux.intel.com>

On Sat, Mar 14, 2026 at 04:13:27PM +0800, Baolu Lu wrote:
> On 3/10/26 08:06, Samiullah Khawaja wrote:
> > On Mon, Mar 09, 2026 at 11:33:23PM +0000, Samiullah Khawaja wrote:
> > > On Mon, Mar 09, 2026 at 02:06:41PM +0800, Lu Baolu wrote:
> > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > 
> > > > Many IOMMU implementations store data structures in host memory that can
> > > > be quite big. The iommu is able to DMA read the host memory using an
> > > > atomic quanta, usually 64 or 128 bits, and will read an entry using
> > > > multiple quanta reads.
> > > > 
> > > > Updating the host memory datastructure entry while the HW is
> > > > concurrently
> > > > DMA'ing it is a little bit involved, but if you want to do this
> > > > hitlessly,
> > > > while never making the entry non-valid, then it becomes quite
> > > > complicated.
> > > > 
> > > > entry_sync is a library to handle this task. It works on the notion of
> > > > "used bits" which reflect which bits the HW is actually sensitive to and
> > > > which bits are ignored by hardware. Many hardware specifications say
> > > > things like 'if mode is X then bits ABC are ignored'.
> > > > 
> > > > Using the ignored bits entry_sync can often compute a series of ordered
> > > > writes and flushes that will allow the entry to be updated while keeping
> > > > it valid. If such an update is not possible then entry will be made
> > > > temporarily non-valid.
> > > > 
> > > > A 64 and 128 bit quanta version is provided to support existing iommus.
> > > > 
> > > > Co-developed-by: Lu Baolu <baolu.lu@linux.intel.com>
> > > > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > > > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > > > ---
> > > > drivers/iommu/Kconfig               |  14 +++
> > > > drivers/iommu/Makefile              |   1 +
> > > > drivers/iommu/entry_sync.h          |  66 +++++++++++++
> > > > drivers/iommu/entry_sync_template.h | 143 ++++++++++++++++++++++++++++
> > > > drivers/iommu/entry_sync.c          |  68 +++++++++++++
> > > > 5 files changed, 292 insertions(+)
> > > > create mode 100644 drivers/iommu/entry_sync.h
> > > > create mode 100644 drivers/iommu/entry_sync_template.h
> > > > create mode 100644 drivers/iommu/entry_sync.c

Shouldn't we move the SMMU driver over to this, rather than copy-pasting
everything? If not, then why is it in generic IOMMU code?

Will
