Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493D53ABD8E;
	Sun, 23 Aug 2026 19:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787511779; cv=none; b=GhMbP3+jeFri7XrexvOk1pJWoSbvIbvJRM0T5D86wC7tbgyGfOI9h6H7gUhIxsks3j9EIOwXt5t5guZckN4dj3L46r98GU4blo73LqBPjS1u0i9xPwqCoGxWcilvlQV8G11ReBBOhpGBx+nadV1Rth8wKepSVA8AYzK2C+CvHIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787511779; c=relaxed/simple;
	bh=5woxXNwZ3ie+kZe+jXbFqvqw12Znp/rzia6jkJsh+pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tp8aLWhjkS+ZqKgVPgck2pT9WiA7BPvc6RVGkF5tKRjtbZpUP/Zr4CotyLrpuuglDKiqIV8QEHPXHyi4VSMD6phZ279eYKuq3qTLLsN4hTrddLCPGJpZXj7yvNTcSAl73JOyK3Bc2q/2NVemQt5WoSQ79pEMWYDATNcAlj7wIvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbxzWPHf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbxzWPHf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926021F000E9;
	Sun, 23 Aug 2026 19:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787511777;
	bh=+MWPs2kA1onXfLcmEnNyBINtH0GKMep20TQq7xPn2Pk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CbxzWPHfiwOS3E+vU56nE0z4h5ZrHq6R5rNtsZmhtlOhNz8iBji5vzQlfQ7ZR6jsL
	 zzfuoJTth0oxILV6kY3Yh6Jp6eokHLymF7RFtdxUrbW34GX7/llO7FMMYd61JHaWmB
	 l8JGN34ifeHk058vvknKxhnSqVdXrMaER1SgqkEPZNcex/1GW0ciSZmnDprzwDgdgU
	 snxGk7HHdP/caCUudYmeb2Dg4pynf7iko2nouBDBYIFAWfmzbmsf+vXOIHSP4FrcsD
	 VRuUdb2jX9qdXGWRiO98uV63xsjLSX0wul0vjwEhXio5BhPseHMbCARl22k9KFJysW
	 uQVcu+pH4gn9A==
Date: Sun, 23 Aug 2026 12:02:56 -0700
From: Drew Fustini <fustini@kernel.org>
To: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Cc: joro@8bytes.org, palmer@dabbelt.com, tony.luck@intel.com,
	reinette.chatre@intel.com, tomasz.jeznach@linux.dev,
	will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
	aou@eecs.berkeley.edu, alex@ghiti.fr, Dave.Martin@arm.com,
	james.morse@arm.com, babu.moger@amd.com, corbet@lwn.net,
	shuah@kernel.org, jgg@ziepe.ca, kevin.tian@intel.com,
	cuiyunhui@bytedance.com, yuanzhu@bytedance.com,
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC PATCH 0/7] riscv: iommu: Add QoS ID support for resctrl
 device assignment
Message-ID: <aotD4FrUcw+7zK/e@x1>
References: <20260714130657.46963-1-zhangzhanpeng.jasper@bytedance.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714130657.46963-1-zhangzhanpeng.jasper@bytedance.com>

On Tue, Jul 14, 2026 at 09:06:50PM +0800, Zhanpeng Zhang wrote:
> This RFC extends RISC-V CBQRI/resctrl support to external requesters
> behind a RISC-V IOMMU.
> 
> The RISC-V IOMMU QoS ID extension associates a resource-control ID
> (RCID) and monitoring ID (MCID) with IOMMU-related memory requests [2].
> For a translated device request, the IOMMU obtains the IDs from the
> device context translation attributes (DC.ta) and supplies them to the
> I/O bridge after a successful translation. The bridge and downstream
> CBQRI-controlled resources can then apply their existing allocation and
> monitoring policy to the request.
> 
> The series is based directly on Drew Fustini's v4 RISC-V Ssqosid and
> CBQRI resctrl series [1]. That dependency provides CPU-side QoS ID
> plumbing and CBQRI-backed resctrl support. This series extends the same
> resctrl identity to device requests translated by a RISC-V IOMMU.
> 
> The RISC-V names map to the existing resctrl identifiers as follows:
> 
>     resctrl CLOSID  ->  RISC-V RCID
>     resctrl RMID    ->  RISC-V MCID
> 
> Userspace first creates a resctrl resource group. The new "devices"
> file then assigns an external requester to that group:
> 
>     userspace
>        |
>        | mkdir /sys/fs/resctrl/<group>
>        |
>        | echo "iommu_group:<id>" > /sys/fs/resctrl/<group>/devices
>        v
>     generic resctrl devices file
>        |
>        | (closid, rmid)
>        v
>     RISC-V CBQRI IOMMU binding backend
>        |
>        | (rcid, mcid)
>        v
>     RISC-V IOMMU DC.ta.{RCID,MCID}
> 
> The "devices" file is an assignment and membership interface only. It
> does not describe a new resctrl resource, schema, or monitoring domain;
> resource policy remains in the existing schemata and info files.
> 
> Common IOMMU helpers:
> 
> The userspace ABI names an IOMMU group by the numeric ID already used by
> /sys/kernel/iommu_groups. Patch 1 adds iommu_group_get_by_id() as a
> narrow, reference-counted lookup for that existing identifier.
> 
> Updating a group also needs stronger iteration semantics than separate
> iommu_group_for_each_dev() calls can provide. All devices must be
> validated before any device context is changed, and group membership
> must not change between validation and update. Patch 2 therefore adds
> iommu_group_update_devices():
> 
>     lock group->mutex
>       for each device: check()          /* may fail, no state changed */
>       for each device: update()         /* non-failing callback */
>     unlock group->mutex
> 
> The helper contains no resctrl or QoS policy. It only provides an
> all-or-none validation boundary for a group-wide update while keeping
> IOMMU group internals private. The RISC-V IOMMU QoS code is its first
> caller.
> 
> RISC-V IOMMU programming:
> 
> For translated device requests, the per-device-context QoS IDs are
> programmed in DC.ta. Active contexts are invalidated after an update so
> cached translations do not retain stale IDs. BARE mode cannot safely
> represent per-IOMMU-group assignment because only the per-IOMMU
> iommu_qosid global default is available, so group assignment rejects
> BARE mode.
> 
> The RISC-V IOMMU also has a per-IOMMU iommu_qosid register. The series
> exposes it as:
> 
>     /sys/class/iommu/<iommu>/qosid
> 
> This sysfs attribute programs the global RCID and MCID used for
> IOMMU-originated DDT, CQ, FQ, PQ, and MSI accesses. In BARE mode,
> device-originated requests also use these IDs. It is not a resctrl group
> assignment interface.
> 
> Open questions for this RFC:
> 
>   * whether a common resctrl "devices" file is the right ABI for
>     associating external requesters with a resource group;
>   * whether iommu_group_get_by_id() is an acceptable narrow common
>     helper for resolving the numeric IOMMU group ID passed through that
>     ABI; and
>   * whether iommu_group_update_devices() provides the right common
>     contract for checked group-wide updates.
> 
> [1] Drew Fustini's CBQRI v4 series:
> https://lore.kernel.org/linux-riscv/20260706-dfustini-atl-sc-cbqri-dt-v4-0-e75c20201d64@kernel.org/

FYI - the 3 Ssqosid patches from my v6 series have been merged into
mainline:

3ec6f50a91bd ("dt-bindings: riscv: Add Ssqosid extension description")
5a17eb5f1c4c ("riscv: Detect the Ssqosid extension")
326ba66db949 ("riscv: Add support for srmcfg CSR from Ssqosid extension")

I'll send a rebased series once v7.3-rc1 is tagged.

Thanks,
Drew

