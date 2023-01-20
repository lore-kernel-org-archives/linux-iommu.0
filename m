Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B51D17E6
	for <iommu@lists.linux.dev>; Fri, 20 Jan 2023 10:23:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1E4C433EF;
	Fri, 20 Jan 2023 10:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1674210198;
	bh=4DqJuaqYnQUzbKI9fdDrJ0+L9YbU5DcdCL9EUTYH51Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=de5qBTzjZ6upncynJLhZCDPDup/eo1j5JNxaK9aCISufhpvNxj5V1j6XiHbaSCPIn
	 yCbDzD+xumNWbtnAPPbizV6vdAAfpInoil7jg/oa3xPht9Ck6KhOWj6/UO/8JfX/Q8
	 nox8Rq+qeb0KFdIoJ9l8+7IxyGqomfL8ZjlLIHE0=
Date: Fri, 20 Jan 2023 11:23:15 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, hch@lst.de, jgg@nvidia.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 6/8] iommu: Retire bus ops
Message-ID: <Y8prk3YD/dMvxTOz@kroah.com>
References: <cover.1673978700.git.robin.murphy@arm.com>
 <a2db51f8f417bbe0032e2c4231579f8c4ce9a089.1673978700.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2db51f8f417bbe0032e2c4231579f8c4ce9a089.1673978700.git.robin.murphy@arm.com>

On Thu, Jan 19, 2023 at 07:18:24PM +0000, Robin Murphy wrote:
> With the rest of the API internals converted, it's time to finally
> tackle probe_device and how we bootstrap the per-device ops association
> to begin with. This ends up being disappointingly straightforward, since
> fwspec users are already doing it in order to find their of_xlate
> callback, and it works out that we can easily do the equivalent for
> other drivers too. Then shuffle the remaining awareness of iommu_ops
> into the couple of core headers that still need it, and breathe a sigh
> of relief...
> 
> Ding dong the bus ops are gone!
> 
> CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CC: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Nice work!

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
