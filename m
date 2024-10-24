Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB0C1D8A12
	for <iommu@lists.linux.dev>; Thu, 24 Oct 2024 13:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729775514; cv=none; b=gz5sthRZmQWNnRexvEI1d8bg4q+lAGfBscfjwiWJsv6SKA8gmlMIFMPctYGvgsFKvMb9I/fW4qfZ1w3RoW6TGI6f/myxx9il2iXumn4pq17I5FEdDDR0F+MDihkvDGEXh2PdvRcffV5fo5tsmaX5/8rN2PMRefckf3DXonFj6So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729775514; c=relaxed/simple;
	bh=si7ie2iyzZ4p1skBIRL8V/PyFmyU66bgLhDxnaHf+kA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYA+d+UkK1XC6tqo2I/OzD5ZD/iE7N5n696t/LvfihB0lyf+Vb3NzZPv1rilaVs/srcdBO64QMY2V94a2Y/SjT8HN29fRPdbwP/Y+vdMPEpmk/0OT+SZb489Cy9+sXyI3/kpaPI/8BwwvaZDcJ9lgHzFyFCeR00czlXqr+09x6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBihqrHF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBihqrHF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16005C4CEC7;
	Thu, 24 Oct 2024 13:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729775513;
	bh=si7ie2iyzZ4p1skBIRL8V/PyFmyU66bgLhDxnaHf+kA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZBihqrHF8NPLgL+00U/IE30G75tZtdZv8JcTWQA2D9NIvpyctQus7caT8NiSpahHB
	 YqzWW4R7A+De1e/NXxMYjx8SxdP+LpJgVeT7MQELESNaHH4qttSdDcIrxmr3f70Hcf
	 9az+IeOxLEuw3tr0euaWJ0WpTFrQN/uAItSipeWh7auEmBfJShApsukySzC8xWkJV4
	 N+ibPvkNwVM7ApcrqNma6ppNIEvP30iqYVXwRFueAFLyixnlGe+ei8ky9NL95F1C5L
	 9c90Sw+q70UPuz6SrlFZks9DV2YHnkc0CJK0Nbql0lUXZrpuuOYu/1wSJhqA9FtYHb
	 dDnZnTWhMEaiQ==
Date: Thu, 24 Oct 2024 14:11:48 +0100
From: Will Deacon <will@kernel.org>
To: Pranjal Shrivastava <praan@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>
Subject: Re: [PATCH v4 1/3] iommu/arm-smmu-v3: Introduce struct arm_smmu_event
Message-ID: <20241024131147.GG30704@willie-the-truck>
References: <20241018180022.807928-1-praan@google.com>
 <20241018180022.807928-2-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018180022.807928-2-praan@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Oct 18, 2024 at 06:00:20PM +0000, Pranjal Shrivastava wrote:
> +struct arm_smmu_event {
> +	struct arm_smmu_device		*smmu;
> +	u8				id;
> +	u8				class;
> +	u16				stag;
> +	u32				sid;
> +	u32				ssid;
> +	u64				iova;
> +	u64				ipa;
> +	u64				raw[EVTQ_ENT_DWORDS];
> +	bool				stall;
> +	bool				ssid_valid;
> +	bool				privileged;
> +	bool				instruction;
> +	bool				s2;
> +	bool				read;
> +};

minor nit, but it might be worth seeing what pahole says about the
layout of this structure in case you've got a bunch of wasted padding
thanks to the mixed-size fields.

Will
