Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29EB1DCB0E;
	Tue, 26 Nov 2024 21:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732655989; cv=none; b=Fi6JcfTP6Fs+Qx8tB2ETHmmVSB7L+Sal7CHjQPxEDrTKHmHc0AGyvH/kwlQcM+HG4fe3HN8VkEaMRFvM2t7YxV0m2MrudwWrdnqC2sDAt/5kCGHnf72xYGc/XLpVn7X1N9zMw0luUbxwpGdyGsJVIrcvXj0J9xEhqV0BaH51N4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732655989; c=relaxed/simple;
	bh=mmuFtOHabxwPpmephB/M1yuaSQ1Oc5r5dI4eOHy148w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tfOhyCaTef5jZRkGFWuVIMQPEYlztiYGMxi+O7mBzSHt0WlR1Wv1noZ+7KwRVF21iGJT5SNzyr2pRvwuoJAmLyrJZWN69DBRHTdPCeqI32n0FW+Ad1JUJFgv2f8b96N3uEhmOmqxIE2dxt1z2/Qt3Qq3Z291UzkM/AjGBJjWqUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbWRYta0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbWRYta0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037A8C4CECF;
	Tue, 26 Nov 2024 21:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732655989;
	bh=mmuFtOHabxwPpmephB/M1yuaSQ1Oc5r5dI4eOHy148w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UbWRYta0wqlWJCgOLWxqJ4VShVyIYWDu+TdifwElbVlovS6elfJTDI4nnqFFsiYez
	 dJwNc1416sj04W1k4cENRGdu7WD4ruG3S1kEmWe0r5BWs59BH3AXVDqoXGG884Nn4s
	 oP914tTDEuE4QHG+LBijmz3Sf/WpHdpFGGQTMV5t9M4slCfUJgAehkDNwrZ1WjEe0j
	 9QR4v01FStpYwZn9rHInHXXMLyFp4yTX1fynT0RSiZUr7iX8QJq/AeT6i5+qd4toPL
	 qU2iOFwr4H6NcwhitCIlZ3kkFTM/xCjlb0NCGCcyQ2slB/+aFGAOMcML9pjP98Yx13
	 flC3irWDBM0FA==
Date: Tue, 26 Nov 2024 15:19:47 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Cc: joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
	robin.murphy@arm.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, vasant.hegde@amd.com
Subject: Re: [PATCH v2 8/8] iommu/amd: Add documentation for AMD IOMMU
 debugfs support
Message-ID: <20241126211947.GA2654254@bhelgaas>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106074639.2039-9-dheerajkumar.srivastava@amd.com>

On Wed, Nov 06, 2024 at 01:16:39PM +0530, Dheeraj Kumar Srivastava wrote:
> Add documentation describing how to use AMD IOMMU debugfs support to
> dump IOMMU data structures - IRT table, Device table, Registers (MMIO and
> Capability) and command buffer.

> +What:		/sys/kernel/debug/iommu/devtbl

I guess you meant /sys/kernel/debug/iommu/amd/devtbl here?

> +What:		/sys/kernel/debug/iommu/irqtbl

and /sys/kernel/debug/iommu/amd/irqtbl here?
