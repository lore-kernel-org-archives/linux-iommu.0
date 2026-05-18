Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C055480357;
	Mon, 18 May 2026 14:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779113407; cv=none; b=JEaJ8Eulb7wopg6J+Ua4J8ZRtzNT0WD0X92upLBxqG1gjv7hpHuAMOMJ8QixrZfHMMVGbLM0ybsWxeznVpSaU81WmB2iNIim8NDMHlkWKy+8UdTc0+O85WrPSNzELuKQd8weBOQpX2XpCkDA/MoyuiMicexnBr5q2OhS3W9rsCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779113407; c=relaxed/simple;
	bh=kxVEe11BsH+KHwDUxwymmvMpjuVx6wc5UyApit0w8Yg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X/IWxKFE7jZjQ24pa//o65m5sQzhmfIHdkCswG+qBXuhN4mGA62/+Sida/IF0Nas8KJGjKfSd/Daw5sgMq6FtNuyQyhR54QrDXxvOoEMgHky7ozBfAOvVLPw75IfGb0QU/2UYNzrVyg4y52SUVOh7Hu/krglqsiSv1iv8XAuv4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sa5ywM1T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sa5ywM1T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F17AC2BCB7;
	Mon, 18 May 2026 14:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779113407;
	bh=kxVEe11BsH+KHwDUxwymmvMpjuVx6wc5UyApit0w8Yg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Sa5ywM1TwsEsBjTEzIyQCMmai4xGWWWlt4O97ydlQZmsmlFwhhmkxWHotw+4Vcw+W
	 UHKEhRlylzly1xAE5hlfDPqB5dGopvhf2QFitxxLMTB0eOpRgSPH52ot0tVg/OIc7C
	 fak00yRoZDWwn1FZgmJbfwO0MkpDuuFQXCi+Qh5rm3Ybj3l2XISVbdS6nXbJpYmF54
	 kdpDeJgVlFfOY/X6DNQNWSvANLhQSv4TjIFAcylpoBmXMKJC2MEQuKNMDGu7PL8l49
	 N1Ld0gpTtP3Cr44PQdaE40qR2ONq48GJDvQ4+jJVWysk21HiPmKsZsGa4eGyEC85lw
	 5K230KLW3p6NA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pranjal Shrivastava <praan@google.com>
Cc: David Matlack <dmatlack@google.com>,  Samiullah Khawaja
 <skhawaja@google.com>,  David Woodhouse <dwmw2@infradead.org>,  Lu Baolu
 <baolu.lu@linux.intel.com>,  Joerg Roedel <joro@8bytes.org>,  Will Deacon
 <will@kernel.org>,  Jason Gunthorpe <jgg@ziepe.ca>,  Robin Murphy
 <robin.murphy@arm.com>,  Kevin Tian <kevin.tian@intel.com>,  Alex
 Williamson <alex@shazbot.org>,  Shuah Khan <shuah@kernel.org>,
  iommu@lists.linux.dev,  linux-kernel@vger.kernel.org,
  kvm@vger.kernel.org,  Saeed Mahameed <saeedm@nvidia.com>,  Adithya
 Jayachandran <ajayachandra@nvidia.com>,  Parav Pandit <parav@nvidia.com>,
  Leon Romanovsky <leonro@nvidia.com>,  William Tu <witu@nvidia.com>,
  Pratyush Yadav <pratyush@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Andrew Morton <akpm@linux-foundation.org>,
  Chris Li <chrisl@kernel.org>,  Vipin Sharma <vipinsh@google.com>,  YiFei
 Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 02/16] iommu: Implement IOMMU Live update FLB callbacks
In-Reply-To: <agr9ggdY3GYltteV@google.com> (Pranjal Shrivastava's message of
	"Mon, 18 May 2026 11:52:34 +0000")
References: <20260427175633.1978233-1-skhawaja@google.com>
	<20260427175633.1978233-3-skhawaja@google.com>
	<afUe71D8JfgmA0BG@google.com> <agr9ggdY3GYltteV@google.com>
Date: Mon, 18 May 2026 16:10:01 +0200
Message-ID: <2vxz8q9gajwm.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, May 18 2026, Pranjal Shrivastava wrote:

> On Fri, May 01, 2026 at 09:45:19PM +0000, David Matlack wrote:
>
> [...]
>
>> > +
>> > +/**
>> > + * struct iommu_hdr_ser - Common header for all serialized IOMMU objects
>> > + * @ref_count: Reference count for the object
>> > + * @deleted: Flag indicating if the object is deleted
>> > + * @incoming: Flag indicating if the object was preserved in previous kernel
>> > + */
>> > +struct iommu_hdr_ser {
>> > +	u32 ref_count;
>> > +	u32 deleted:1;
>> > +	u32 incoming:1;
>> 
>> Are C bitfields safe to use in Live Update ABI?
>> 
>
> AFAIU, they aren't. The C standard does not dictate how bitfields are
> packed into their underlying types (e.g., whether they are packed MSB to
> LSB or vice-versa), making them highly dependent on the compiler and arch
> endianness.

I had the same question and Jason told me otherwise:
https://lore.kernel.org/linux-mm/20250909155044.GN789684@nvidia.com/

I took him at his word and didn't really look much deeper. I use them
for memfd preservation as well. See struct memfd_luo_folio_ser in
include/linux/kho/abi/memfd.h.

>
> I agree that we cannot rely on bitfields. Let's convert this to something
> like u32 flags; field and define explicit bitmasks.
>
>> > +} __packed;

-- 
Regards,
Pratyush Yadav
