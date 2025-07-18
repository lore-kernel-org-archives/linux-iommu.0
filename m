Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC8D2949E5;
	Fri, 18 Jul 2025 09:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752830027; cv=none; b=iIuAcASKFkt0C8kL6JR6CJVlOSJ69ya+LFILWGR94mN2T+IXuWr051huhE/B/TpvWNmoqiE5wS5ymBHXwwbnFkasIG7fHXzlwBqCGXSqR68/r+AZhfREk5kCPOBoK9iGOuEepKxVWKiwiffytVszijv4HU3/h6qNv7LoUU3E5u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752830027; c=relaxed/simple;
	bh=fQjBr8J+HuO7FW9XTKJjG8LoJCVWfRGB+DTD8fc6mJs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MehIobpd823bp2BFPBBjaJbf9khxCxIsm7ejHXOG/3/XRFWHfia/LFn+Emd5NAuTVxQmykIPlnuusTB1O4qmxhysZGmL0qfWnFGKPlquhKhdjfL+L7V4UFhZokv8NNuLnqoBv6Ll8Iu/wKg12s15ZOdttxK19qQQ/+reorkY22I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cImDF7PL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cImDF7PL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B887C4CEEB;
	Fri, 18 Jul 2025 09:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752830026;
	bh=fQjBr8J+HuO7FW9XTKJjG8LoJCVWfRGB+DTD8fc6mJs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cImDF7PLXvE3iTzm6YhrYsQLSTUie1no75NRd8DI9VcGUTCjrk2DYxjlhvKzOieJb
	 hHIBva3+XF5bTIie/f76u29AB2P6AoLMfj58TGrlMgkJYA+rhremXi2aDAdId5FIN9
	 9e77c8Br+OiRfTG0tm2i5CFlHRt8HweNnDVAmybhT1c1g/HobjRAqxtS+7ly/MF2XA
	 a0GjI4/5qonwAIQf2wukzr+NAF7rOamrVpXoZzcM2GBxxfE/GMrFD+Sgz7uhhjh9um
	 WYuqZdnUdgixZXBQNevw0SlslxB8hwym6kuYi5P08JoR2nD0D8+st3nQbk5AEdSIKf
	 kPMrDRMVTnppA==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Xu Yilun <yilun.xu@linux.intel.com>, jgg@nvidia.com, jgg@ziepe.ca,
	kevin.tian@intel.com, will@kernel.org
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, joro@8bytes.org,
	robin.murphy@arm.com, shuah@kernel.org, nicolinc@nvidia.com,
	aik@amd.com, dan.j.williams@intel.com, baolu.lu@linux.intel.com,
	yilun.xu@intel.com
Subject: Re: [PATCH v6 0/8] iommufd: Destroy vdevice on device unbind
In-Reply-To: <20250716070349.1807226-1-yilun.xu@linux.intel.com>
References: <20250716070349.1807226-1-yilun.xu@linux.intel.com>
Date: Fri, 18 Jul 2025 14:43:35 +0530
Message-ID: <yq5ajz45275s.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Xu Yilun <yilun.xu@linux.intel.com> writes:

> It is to solve the lifecycle issue that vdevice may outlive idevice. It
> is a prerequisite for TIO, to ensure extra secure configurations (e.g.
> TSM Bind/Unbind) against vdevice could be rolled back on idevice unbind,
> so that VFIO could still work on the physical device without surprise.
>
> Changelog:
> v6:
>  - Fix compile error for ARM platform in Patch 5
>  - Adjust some more line wrappings in Patch 6
>  - Add review tags.
>
> v5: https://lore.kernel.org/linux-iommu/aHdFWV9k9M7tRpD0@yilunxu-OptiPlex-7050/
>  - Further rebase to iommufd for-next 601b1d0d9395
>  - Keep the xa_empty() check in iommufd_fops_release(), update comments
>  - Move the *idev next to *viommu for struct iommufd_vdevice
>  - Update the description about IOMMUFD_CMD_VDEVICE_ALLOC for lifecycle
>  - Remove Baolu's tag for patch 4 because of big changes since v3
>  - Add changelog about idev->destroying
>  - Adjust line wrappings for tools/testing/selftests/iommu/iommufd.c
>  - Clarify that no testing for tombstoned ID repurposing.
>  - Add review tags.
>
> v4: https://lore.kernel.org/linux-iommu/20250709040234.1773573-1-yilun.xu@linux.intel.com/
>  - Rebase to iommufd for-next.
>  - A new patch to roll back iommufd_object_alloc_ucmd() for vdevice.
>  - Fix the mistake trying to xa_destroy ictx->groups on
>    iommufd_fops_release().
>  - Move 'empty' flag inside destroy loop for iommufd_fops_release().
>  - Refactor vdev/idev destroy syncing.
>    - Drop the iommufd_vdevice_abort() reentrant idea.
>    - A new patch that adds pre_destroy() op.
>    - Hold short term reference during the whole vdevice's lifecycle.
>    - Wait on short term reference on idev's pre_destroy().
>    - Add a 'destroying' flag for idev to prevent new reference after
>      pre_destroy().
>  - Rephrase/fix some comments.
>  - Add review tags.
>
> v3: https://lore.kernel.org/linux-iommu/20250627033809.1730752-1-yilun.xu@linux.intel.com/
>  - No bother clean each tombstone in iommufd_fops_release().
>  - Drop vdev->ictx initialization fix patch.
>  - Optimize control flow in iommufd_device_remove_vdev().
>  - Make iommufd_vdevice_abort() reentrant.
>  - Call iommufd_vdevice_abort() directly instead of waiting for it.
>  - Rephrase/fix some comments.
>  - A new patch to remove vdev->dev.
>  - A new patch to explicitly skip existing viommu tests for no_iommu.
>  - Also skip vdevice tombstone test for no_iommu.
>  - Allow me to add SoB from Aneesh.
>
> v2: https://lore.kernel.org/linux-iommu/20250623094946.1714996-1-yilun.xu@linux.intel.com/
>
> v1/rfc: https://lore.kernel.org/linux-iommu/20250610065146.1321816-1-aneesh.kumar@kernel.org/
>
> The series is based on iommufd for-next
>
>
> Xu Yilun (8):
>   iommufd/viommu: Roll back to use iommufd_object_alloc() for vdevice
>   iommufd: Add iommufd_object_tombstone_user() helper
>   iommufd: Add a pre_destroy() op for objects
>   iommufd: Destroy vdevice on idevice destroy
>   iommufd/vdevice: Remove struct device reference from struct vdevice
>   iommufd/selftest: Explicitly skip tests for inapplicable variant
>   iommufd/selftest: Add coverage for vdevice tombstone
>   iommufd: Rename some shortterm-related identifiers
>
>  .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    |   3 +-
>  drivers/iommu/iommufd/device.c                |  51 +++
>  drivers/iommu/iommufd/driver.c                |  10 +-
>  drivers/iommu/iommufd/iommufd_private.h       |  49 ++-
>  drivers/iommu/iommufd/main.c                  |  69 +++-
>  drivers/iommu/iommufd/viommu.c                |  69 +++-
>  include/linux/iommufd.h                       |  17 +-
>  include/uapi/linux/iommufd.h                  |   5 +
>  tools/testing/selftests/iommu/iommufd.c       | 377 +++++++++---------
>  9 files changed, 419 insertions(+), 231 deletions(-)
>

Can you share the commit id these patches are against.

-aneesh
