Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD08117C219;
	Tue, 26 Nov 2024 21:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732654959; cv=none; b=GSEJXvq4vAaJYiWj/Do4zySFcaH5VYe59UeflXFZlowhrT2rjAFfJ1sCVoQrSpHhvL7hI+Tdlpnbqg92E3uEeAHne3DhfoKxPuge7kHM+nHphPIgkGN/VQLhutCn1r78vzPIdTqfm+93C4fH3ly8n/x3OFoRmhgx2oudnUwn250=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732654959; c=relaxed/simple;
	bh=P3OCIg52Gl/uzjqnC4f6fBucEymHpuyao1jG/kFItkE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bxTcAM4hVPrAwi0Aag6hrzvPfUxilviPhRTDeeECtbQ1UsUVPvzzPfDK5JHWG33PM/wdeHwJPRzcVVALibuYvLlCpRjpGL7yM4IZ78NVJ0laOf8TFfM06z9Uxs9szxJsJ3Ze2x2iu9tPrXk6fNyWcOVQwshw0+XEmS6gfRDewgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgCUVfxB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgCUVfxB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FDAAC4CECF;
	Tue, 26 Nov 2024 21:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732654959;
	bh=P3OCIg52Gl/uzjqnC4f6fBucEymHpuyao1jG/kFItkE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=PgCUVfxBTqykaStfr1b1fgFU9BCa+5GuLxkNug6corRyiPMgyUmnLllEMNCnsQM4a
	 aYV16MQPukuLw4vK72gZIIXlsVNMKI/EJ+7ZPWhR6QVqa/xw9hqSjAppAiR03ikZF8
	 yZJLcrmvDBYmpNKOYK+n6RV0lbdoOi6LmYQQlezFVtfmDZPVWFjajsuvmAxKT6mJxe
	 tRut3XOThgukAaTuHjR5Sd5af57oUmtr/xIiRbAtTtnHqJmyHEbnl/9mPJ33MH5Rfz
	 hHScvLfP/21+Qbr6iogsofKn2iQIeOJO6aFFUWEgfwDBh+OXPvjW189uSqnUbcU0IJ
	 npqvSNlLWyjyw==
Date: Tue, 26 Nov 2024 15:02:37 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Cc: joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
	robin.murphy@arm.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, vasant.hegde@amd.com
Subject: Re: [PATCH v2 5/8] iommu/amd: Add support for device id user input
Message-ID: <20241126210237.GA2656401@bhelgaas>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106074639.2039-6-dheerajkumar.srivastava@amd.com>

On Wed, Nov 06, 2024 at 01:16:36PM +0530, Dheeraj Kumar Srivastava wrote:
> Device id user input is needed for dumping IOMMU data structures like
> device table, IRT etc in AMD IOMMU debugfs.
> 
> eg.
> 1. # echo 0000:01:00.0 > /sys/kernel/debug/iommu/amd/devid
>    # cat /sys/kernel/debug/iommu/amd/devid
>    Output : 0000:01:00.0
> 
> 2. # echo 01:00.0 > /sys/kernel/debug/iommu/amd/devid
>    # cat /sys/kernel/debug/iommu/amd/devid
>    Output : 0000:01:00.0

The corresponding Intel IOMMU debugfs support encodes the BDF in the
pathname, e.g.,

  /sys/kernel/debug/iommu/intel/<bdf>/domain_translation_struct

Can you do the same?  I think it would be nicer to use a similar
style, and it would also make the code simpler.

Bjorn
