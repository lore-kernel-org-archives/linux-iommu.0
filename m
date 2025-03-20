Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558D11A5BBA
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 17:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742490379; cv=none; b=MXfwTUBu0iDUMYurGs0DcCTbgqBOj18eK4iFSrFUOM5+kICyRAV5zD5epQVk8MA9YXHTz5zWLJ0TOP58pCysNq3mHmt/ToiJKNhNSndFHdfYTaaHVzAHTpN33pACZzuSre7enyGrT1am1hUgENnB5yLUhHxQH7MFvjRm59iAMLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742490379; c=relaxed/simple;
	bh=2IDzzPQ9Eg3WAC4Dm8+n336cmDTzfTWGtQW42fjuVmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W8wFQqM0cEK0SG4/D4fupqYNakRnAKn9w2g597O0DhU9CkhVLhxrUlh3K9dDO05fiFDTSu3BOyNOZb0Of0JGTj6bPn7DaCSQgrb8g6j/cONIurB+PigBmRMnc//RXPDi7lOrLgs8EKQuG03Wdyy1NwFQbQpRJv8hgbJyiFRb5Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67E00113E;
	Thu, 20 Mar 2025 10:06:25 -0700 (PDT)
Received: from e133081.arm.com (unknown [10.57.15.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F41B93F673;
	Thu, 20 Mar 2025 10:06:12 -0700 (PDT)
Date: Thu, 20 Mar 2025 17:06:10 +0000
From: =?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: ryan.roberts@arm.com, suzuki.poulose@arm.com,
	yang@os.amperecomputing.com, corbet@lwn.net,
	catalin.marinas@arm.com, will@kernel.org, jean-philippe@linaro.org,
	robin.murphy@arm.com, joro@8bytes.org, akpm@linux-foundation.org,
	mark.rutland@arm.com, joey.gouly@arm.com, maz@kernel.org,
	james.morse@arm.com, broonie@kernel.org, oliver.upton@linux.dev,
	baohua@kernel.org, david@redhat.com, ioworker0@gmail.com,
	jgg@ziepe.ca, nicolinc@nvidia.com, mshavit@google.com,
	jsnitsel@redhat.com, smostafa@google.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH v4 1/3] arm64: Add BBM Level 2 cpu feature
Message-ID: <20250320170610.GA487465@e133081.arm.com>
References: <20250319150533.37440-2-miko.lenczewski@arm.com>
 <20250319150533.37440-3-miko.lenczewski@arm.com>
 <CAMj1kXFOofRCiVHxxxBZMGQHRH-ghtqNxgd=uww9D4sr4vvjEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMj1kXFOofRCiVHxxxBZMGQHRH-ghtqNxgd=uww9D4sr4vvjEQ@mail.gmail.com>

On Thu, Mar 20, 2025 at 02:37:08PM +0100, Ard Biesheuvel wrote:
> On Wed, 19 Mar 2025 at 16:06, Mikołaj Lenczewski
> <miko.lenczewski@arm.com> wrote:
> > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > index d561cf3b8ac7..1a4adcda267b 100644
> > --- a/arch/arm64/kernel/cpufeature.c
> > +++ b/arch/arm64/kernel/cpufeature.c
> > @@ -2176,6 +2176,67 @@ static bool hvhe_possible(const struct arm64_cpu_capabilities *entry,
> >         return arm64_test_sw_feature_override(ARM64_SW_FEATURE_OVERRIDE_HVHE);
> >  }
> >
> > +static bool cpu_has_bbml2_noabort(unsigned int cpu_midr)
> > +{
> 
> We generally start these block comments with just /* on the first line

My bad for the oversight. Will fix this, thanks.

-- 
Kind regards,
Mikołaj Lenczewski
