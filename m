Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE7432AAA7
	for <iommu@lists.linux.dev>; Tue, 25 Nov 2025 18:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764093612; cv=none; b=DWrIgnwUZitOJTNNvrcmFfO9tasCXT4xDBLPXpbO7ECAapRG4t3i97N8rlGjXn3k4faUsBpUzd+t4waqLrTQ/xevxwjMol9N4SlmnzSG/epkDDhzlzqPj7NCC7BJ8//pUE8u3eRXokhSyYDTRBp/hethr717KfL2QKNk9RjIHwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764093612; c=relaxed/simple;
	bh=7aV5v3Js8JnD672c3H3QPHvgFhNwPE7FtnDcETPF26g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQQD/xXr3KoJyAifYXENlguBzu5ezzLbBQCNL92FF7cLi70BdMhg2eiKlrZWhBXasfDq6ExBnNbItEWhOh0FUrHwy83toxbXRDVZjmwoGYvJ98Iyua+2UybJLgwBF9DfSEL9bRt4E5rIpF5uUQN0fb4w8e143hgRG+Izl0Fwy6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAC7uF2P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAC7uF2P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A84C4CEF1;
	Tue, 25 Nov 2025 18:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764093612;
	bh=7aV5v3Js8JnD672c3H3QPHvgFhNwPE7FtnDcETPF26g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SAC7uF2PfTHFryBDj6ceTAhUjx/ouXXDJE0/qD1S5e4lvFp4gI40PANMgDhT6/xcT
	 nLtcaSzC6hTRB5Sg0dccifpWFye4+jdcsMefEcb7rUyIYE6gB4/SdjQO1BiMCqHf73
	 rQ+HiruE5/uFtCaYZ8qt4uUEXdZ58TdCP7mqouIuzxAVoeX7ojCR+AOrLgFiy1mNxs
	 tl8v0SoDu6Wjre/1nQCIITb7obRfx7anRMEoKee7B+2lVMioSvWEwSKyb8i58b1Kt9
	 Dhr4TM4P+H+TJdMkwK6vVsLAo8nyeh76OFgklDqE0OXcVsixW1Vlxs9pgFSl1Et6pQ
	 YkTiYsc9yTUIQ==
Date: Tue, 25 Nov 2025 18:00:07 +0000
From: Will Deacon <will@kernel.org>
To: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	jean-philippe@linaro.org, jgg@nvidia.com, praan@google.com,
	smostafa@google.com, robin.murphy@arm.com
Subject: Re: PRI support in arm-smmu-v3 driver
Message-ID: <aSXupxMeHLajOmDW@willie-the-truck>
References: <1256faaa-e9cd-46a6-9a42-25aa74b984a8@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1256faaa-e9cd-46a6-9a42-25aa74b984a8@quicinc.com>

[+iommu list and usual suspects]

Hi Pavan,

On Tue, Nov 25, 2025 at 02:22:05PM +0530, Pavan Kondeti wrote:
> I am trying to understand IO fault handling in Linux w/ SMMUv3. While reading
> the code, I understand that SVA domain creation allows taking IO pagefaults.
> arm_smmu_enable_iopf() checks if the master support stall upon fault
> feature or not. How do we handle page faults for PCIe devices, for which 
> transactions cannot safely be stalled? IIUC, The PRI handling in the
> driver i.e arm_smmu_priq_thread()->arm_smmu_handle_ppr() is not doing
> anything. In the SVA support for SMMUv3 series v7, I see the support for
> PRI via "Add support for PRI" patch [1] but it is not merged. 
> 
> Can you please clarify if we can support SVA with PCIe devices w/o
> pinning the memory?
> 
> [1]
> https://lore.kernel.org/all/20200519175502.2504091-25-jean-philippe@linaro.org/

The only SVA client we've had for SMMUv3 in the upstream kernel is the
"uacce" thing from HiSilicon which is a platform device (rather than a
PCIe device) and so I think the PRI support just fell by the wayside due
to lack of an upstream user and no ability to test it.

I'm not sure whether or not Jason has plans to implement PRI but maybe
it's something you could help with if you have hardware?

Will
