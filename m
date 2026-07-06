Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D583F889E
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 21:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783374432; cv=none; b=juIjPIJlg0HQhcMZSHcff0m5JbJbLgLj6cgGVshzq5iYCRqSHeeuwzBUy2ZmPC7Mj15bTQh1wz4qq75C5f1qWVu5NUURRkAqvVUEYLxZ5eGgzesKIEbxyGRL1mR115G84FMxPprrGWnIESLxbcyfkNNMmIy3nqADrjI8js4ffPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783374432; c=relaxed/simple;
	bh=yOX/pngM4h8XtJJGYSyUJUmzf7y+QUF055lYu28wJHk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aJ51eGYV8rE6fSI7c6G5FD0D/y2lYgqmo8q6mVR9RAzhjd7ERzHqemNjfsOuRaM2njR7DIW9yW6eJDZi9kTDbv3V1dcKfKEhZfyAaM5zr9oPo0NjbVB/m1hHKT1xAXXy5fPh/JLpWMw25MdJGtObMwy4XN8C/GRQw/ddxZXwCYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=F1QKp5Vv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R7G0cDcZ; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="F1QKp5Vv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R7G0cDcZ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0809F7A00BD;
	Mon,  6 Jul 2026 17:47:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 06 Jul 2026 17:47:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1783374428;
	 x=1783460828; bh=dblZBFlOPQdOdcdQ+N50i9tH9O5Ky4enKZUwJMU8O7s=; b=
	F1QKp5Vv2E1BUAUJYKwAASO+N+qCzR+GGBA8lVSJu7Ld9nVYI+6jfH1BLx3fmQZU
	H2v4drbUYBgeAq+xN//Gpu3cOqUHD3WGsHGmX7Dr3GDX5wf8tjL8G+4TW3v+Rr+9
	ElpdD8XfjrsVVCZENpsLtV9bFzWrQPo+HzvP9AmFLyaHI7dDrRLxEUQ/5k5sxOhs
	RYtHpfPfKx3yL3IRRES7s/QSQmmXVNNU3bbEdpajNE4aoxT5MPs+8xDjLbFOovQF
	CZ5PkbjjpaNRNHpBaxeWgwrWVM/JFfJHG8BNtCCPvLUwYZfKH6/f1uoUnzZ5I7CX
	rJRLC2RLS4F7kQDp/maTGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783374428; x=
	1783460828; bh=dblZBFlOPQdOdcdQ+N50i9tH9O5Ky4enKZUwJMU8O7s=; b=R
	7G0cDcZ1MQP1fn8phZveBeDNJqti7/SvmTuub/mUhtjTUh+c4Ug5pdbgHnWuKLBp
	thcGYhh2w9hwrv3SBhStYCL+7rr21/4/dyQcTa6n2RxBR+gy5wuxV6pc+38r++3T
	a8b+IW7pzbwMGHnPxSh9iwFRxMxcX/In18+jgvqHnBN0D5W6kzOSsEWVBiVT6hNg
	FLIw8u+7EoEIDi1AqnLpOMny/1a3wq3KFByz84x2DYDZ+tPOMejQVecFtP8V99fc
	tWbOgPtEAP6/9B3W0H32jFnUlKeWLE8Kj83z3awVhzpMJ3FVT6V3O0ummsc+K8fI
	t2VGzz16QSkoQfFWVSlJA==
X-ME-Sender: <xms:WyJMapJadEtdkz_Ke-35YTK9kfgRDiHvdgNMiYNILrLFYOkqrkNlyA>
    <xme:WyJMahF7xg2-hEUMZDfnW0o9VvS8FTSSo-n-WeiSlDKqqAObIbN2W1IlS2J5CAddp
    E4PE_ixoOnxPi2F_H_xWqzYDpXK6m44c-OHK6y1ECrDnQs2Hreh_A>
X-ME-Received: <xmr:WyJMan1IoSTxxPHqvhA7iLk8n4JtcBZko6CZKprLVZM9tqacmcNnrwS9nY8>
X-ME-Proxy-Cause: dmFkZTGvNIjY2Vplghz8cgOyVSCztsxzD9OCzjLAwveJocuzaj+H0QJ98XBv4eElp0TtP+
    RqgqpQj8e9dcSGKKqPm+wbcFMfB0LaVti8lxcsPpgFpxh3XuzCDo64VWBVVkefORhZMKPp
    nhx6IbUJa5MEq0zpkpUEO7Mkj1VIyGKXgMLPHXigdSd2wngZxhCfcuUfAeLuQK0TtyCKXj
    ncBwOvpQkRGOW9Cf2QZ8mnK9TE7OHg3G8dd2J83h2hXW6SWgLzmIVrx8yjrj3lL63d/RBX
    Mxx1fD2HNmQn1fVcnPpbAjr++qb1illTzqKfxXfq2EIqGVR0okWr1g8gRwSz+CzJrn0IZn
    J5TAHRjz4VouLXH6QQ4BXtZuUch53rzMgSC9B51U8QfAwAPugcRxXUjohcl7b3bPyP9w7J
    97N4kT9nArSRKC5f+SlvcudTQpNKjlQe8CifC0+g7qcbH+GIJlI1hQkJwIWfXkc/rr80kH
    TLK7Y7gAbqYBX+LOSYtfnL9Juv/6BB1KI8o2DpDIphTOfxOiQzdDq1PfVT+4NugZatVz+H
    Z4UYBZCxV/z2abwvdpAQoWwrEiilA98wHChbReqVAmhp4t/IsX+D8nU2k/AV3SjIedCWxw
    mFmDP/A+1SGYGdLWWjJzN3KrUBxWe0/CjEg1lhb1zt4ne07uWe2v7OkTLnOQ
X-ME-Proxy: <xmx:WyJMagwErtsru0D1hY-ERDMmR2g5q3uDzSkBFtbOp6JJggOm58xfbQ>
    <xmx:WyJMaugzihDdO59uDyqDVcqr5p2wUQvnSjETFabfjaY4nzbBH2JRNw>
    <xmx:WyJManwlg9w63akD7JY9Nqdxh0_dTn4WpwlhVYtzNb2JFW3XN_X9Yg>
    <xmx:WyJMakx9cxj2RRcBR75WYFno8Y3W63O9-2LRh7beK56cgrD7yKrrNg>
    <xmx:XCJMav2wXRaqK9ZUImqvSYKlWnEv_vPGmVgOYMfiINR5yskUMrcS_NpD>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 17:47:06 -0400 (EDT)
Date: Mon, 6 Jul 2026 15:47:04 -0600
From: Alex Williamson <alex@shazbot.org>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel
 <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, David Matlack
 <dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
 <nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu
 <yi.l.liu@intel.com>, Baolu Lu <baolu.lu@linux.intel.com>, Saurabh Sengar
 <ssengar@linux.microsoft.com>, skhawaja@google.com,
 pasha.tatashin@soleen.com, Will Deacon <will@kernel.org>, alex@shazbot.org
Subject: Re: [PATCH v10 6/6] Documentation: Update VFIO NOIOMMU mode
Message-ID: <20260706154704.20ae47cf@shazbot.org>
In-Reply-To: <7d4a050505317a29f7f2c32d024333b7b5c7d4fd.1783360051.git.jacob.pan@linux.microsoft.com>
References: <cover.1783360051.git.jacob.pan@linux.microsoft.com>
	<7d4a050505317a29f7f2c32d024333b7b5c7d4fd.1783360051.git.jacob.pan@linux.microsoft.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  6 Jul 2026 11:48:34 -0700
Jacob Pan <jacob.pan@linux.microsoft.com> wrote:

> Document the NOIOMMU mode with newly added cdev support under iommufd.
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> ---
>  v9:
>  - Clarify VFIO cdev no-IOMMU Kconfig limits
>  V8:
>  - Remove reference about self test.
>  v7:
>  - Added Kconfig matrix
>  v6:
>  - Generalize device node names (noiommu-vfioX, noiommu-Y) in the tree
>    example (Yi)
>  - Clarify table column descriptions for Yes/No meanings (Yi)
> ---
>  Documentation/driver-api/vfio.rst | 89 ++++++++++++++++++++++++++++++-
>  1 file changed, 87 insertions(+), 2 deletions(-)


Reviewed-by: Alex Williamson <alex@shazbot.org>

> 
> diff --git a/Documentation/driver-api/vfio.rst b/Documentation/driver-api/vfio.rst
> index 2a21a42c9386..07192386f7a6 100644
> --- a/Documentation/driver-api/vfio.rst
> +++ b/Documentation/driver-api/vfio.rst
> @@ -275,8 +275,6 @@ in a VFIO group.
>  With CONFIG_VFIO_DEVICE_CDEV=y the user can now acquire a device fd
>  by directly opening a character device /dev/vfio/devices/vfioX where
>  "X" is the number allocated uniquely by VFIO for registered devices.
> -cdev interface does not support noiommu devices, so user should use
> -the legacy group interface if noiommu is wanted.
>  
>  The cdev only works with IOMMUFD.  Both VFIO drivers and applications
>  must adapt to the new cdev security model which requires using
> @@ -370,6 +368,93 @@ IOMMUFD IOAS/HWPT to enable userspace DMA::
>  
>  	/* Other device operations as stated in "VFIO Usage Example" */
>  
> +VFIO NOIOMMU mode
> +-------------------------------------------------------------------------------
> +VFIO also supports a no-IOMMU mode, intended for usages where unsafe DMA can
> +be performed by userspace drivers w/o physical IOMMU protection. This mode
> +is controlled by the parameter:
> +
> +/sys/module/vfio/parameters/enable_unsafe_noiommu_mode
> +
> +Upon enabling this mode, with an assigned device, the user will be presented
> +with a VFIO group and device file, e.g.::
> +
> +  /dev/vfio/
> +  |-- devices
> +  |   `-- noiommu-vfioX	/* VFIO device cdev */
> +  |-- noiommu-Y		/* VFIO group */
> +  `-- vfio
> +
> +The capabilities vary depending on the device programming interface and kernel
> +configuration used. The following table summarizes the differences ("Yes" means
> +the UAPI is accessible and functional in noiommu mode, "No" means the UAPI is
> +not supported):
> +
> ++-------------------+---------------------+----------------------+
> +| Feature           | VFIO group          | VFIO device cdev     |
> ++===================+=====================+======================+
> +| VFIO device UAPI  | Yes                 | Yes                  |
> ++-------------------+---------------------+----------------------+
> +| VFIO container    | No                  | No                   |
> ++-------------------+---------------------+----------------------+
> +| IOMMUFD IOAS      | No                  | Yes*                 |
> ++-------------------+---------------------+----------------------+
> +
> +Note that the VFIO container case includes IOMMUFD provided VFIO compatibility
> +interfaces when either CONFIG_VFIO_CONTAINER or CONFIG_IOMMUFD_VFIO_CONTAINER is
> +enabled.
> +
> +* IOMMUFD UAPI is available for VFIO device cdev to pin and map user memory with
> +  the ability to retrieve physical addresses for DMA command submission.
> +
> +Kconfig Support Matrix
> +^^^^^^^^^^^^^^^^^^^^^^
> +
> +The visibility of CONFIG_VFIO_NOIOMMU depends on the combination of
> +CONFIG_VFIO_GROUP, CONFIG_VFIO_DEVICE_CDEV, and whether a container backend
> +(CONFIG_VFIO_CONTAINER or CONFIG_IOMMUFD_VFIO_CONTAINER) is configured.  The
> +Kconfig dependencies enforce the following constraints:
> +
> +- At least one access path (group or cdev) must be available.
> +- If VFIO_GROUP is enabled, a container backend is required; otherwise the
> +  group node would be unusable in noiommu mode.
> +- The cdev noiommu path requires CONFIG_GENERIC_ATOMIC64=n because it depends
> +  on CONFIG_IOMMUFD_NOIOMMU.
> +
> +The resulting support matrix:
> +
> ++------+-------+-----------+------+---------+---------------------------+
> +| Case | GROUP | Container | CDEV | NOIOMMU | Notes                     |
> ++======+=======+===========+======+=========+===========================+
> +|  1   |   y   |     y     |  n   |   yes   | Group noiommu works       |
> ++------+-------+-----------+------+---------+---------------------------+
> +|  2   |   y   |     n     |  n   |   no    | Blocked - no container    |
> ++------+-------+-----------+------+---------+---------------------------+
> +|  3   |   y   |     y     |  y   |   yes   | Both paths work [#cdev]_  |
> ++------+-------+-----------+------+---------+---------------------------+
> +|  4   |   y   |     n     |  y   |   no    | Blocked - no container    |
> ++------+-------+-----------+------+---------+---------------------------+
> +|  5   |   n   |     -     |  y   |   yes   | Cdev-only works [#cdev]_  |
> ++------+-------+-----------+------+---------+---------------------------+
> +|  6   |   n   |     -     |  n   |   no    | No access path            |
> ++------+-------+-----------+------+---------+---------------------------+
> +
> +Container = CONFIG_VFIO_CONTAINER or CONFIG_IOMMUFD_VFIO_CONTAINER (either
> +suffices).  Case 4 is intentionally blocked: allowing NOIOMMU with GROUP
> +enabled but no container would create unusable group nodes.  Users who want
> +cdev-only noiommu should set CONFIG_VFIO_GROUP=n (case 5).
> +
> +.. [#cdev] The cdev noiommu path requires CONFIG_GENERIC_ATOMIC64=n.  When
> +   CONFIG_VFIO_GROUP=y, CONFIG_VFIO_DEVICE_CDEV=y, and
> +   CONFIG_GENERIC_ATOMIC64=y, CONFIG_VFIO_NOIOMMU remains selectable for the
> +   group path, but no noiommu device cdev is registered.  Cdev-only noiommu is
> +   not selectable on those platforms.
> +
> +A new IOMMUFD ioctl IOMMU_IOAS_NOIOMMU_GET_PA is added to retrieve the physical
> +address for a given IOVA. Although there is no physical DMA remapping hardware,
> +IOMMU_IOAS_MAP_FIXED_IOVA is still used to establish IOVA-to-PA mappings in the
> +software page table for later IOMMU_IOAS_NOIOMMU_GET_PA lookups.
> +
>  VFIO User API
>  -------------------------------------------------------------------------------
>  

