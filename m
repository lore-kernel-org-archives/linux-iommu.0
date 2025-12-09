Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2111A724C;
	Tue,  9 Dec 2025 20:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765310537; cv=none; b=OOEDEA87s6o+u8MjElchouF7CCcjoohAWsT4O0nqDScWoZhHNEIIiA9krKi99hLNBFTkU+rVlQkTkSX1DYjR9IDL3S64brOu20UtKrJL2GRFO1/dOmfHxfF4QM/7B6mq9fyGuTDm8Px9kxdMucfqC8J/5wi/3IdhmuxZCtnwBFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765310537; c=relaxed/simple;
	bh=3fjhK4NU5jyQ8ANEp66EaQAaZFjJM+TqoFt4C58Wq/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMpz7MpjLjH7n3eoar++B2vmp9MoRVS4oo4IBJkisM9xs1FUQ67fze4YDxvFXwW5Lis04AyzUQ+UMzWeXQ1CpAiOQkGgQFvHew4a7JRWvmto1FrpXZcaWE2LyEFKV2/F41TuM3KZs2LCIivJ9U21rm0alcg2krR9/mDbuh/7n/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V61gOwjl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V61gOwjl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C45C4CEF5;
	Tue,  9 Dec 2025 20:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765310537;
	bh=3fjhK4NU5jyQ8ANEp66EaQAaZFjJM+TqoFt4C58Wq/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V61gOwjlAvQ+uqPqMdMtONPCV4IiB2rifhFM1Xor2IRRSAre9E9i/KskvVWbKleVV
	 FTi49IZrva8ibljHVn8L+tQzZrk+2SwLCqXsZSfLI+ciJ9pjBDg1FMlxUn6BHnZpEQ
	 3MZM92l0vz1YNa6v1rnqzVQ9CJ7I7siZV4jzBld7trS51LsebPjRGwWAmf0lRvTACw
	 YcDIJG+yqmCoWbUTJU9cVWW7P4RTF0GvpKVHcQ8+IJ/Tp+gnhnkctKHbw7LxCGarRv
	 /dOnNtT9qVSom0cWbNjdSzLVWadN1d11Iv2feSTErJn5SMQCwuiG2MgvyNVdYkPxLI
	 FMa1FJ/xg24tg==
Date: Tue, 9 Dec 2025 14:02:14 -0600
From: Rob Herring <robh@kernel.org>
To: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	robin.murphy@arm.com, will@kernel.org, joro@8bytes.org,
	konrad.dybcio@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com,
	bod@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
	charan.kalla@oss.qualcomm.com, prakash.gupta@oss.qualcomm.com,
	vikash.garodia@oss.qualcomm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] of: factor arguments passed to of_map_id() into a
 struct
Message-ID: <20251209200214.GA1015230-robh@kernel.org>
References: <20251204095530.8627-1-vijayanand.jitta@oss.qualcomm.com>
 <20251204095530.8627-3-vijayanand.jitta@oss.qualcomm.com>
 <75d44bf2-c518-444d-9b15-fca067e25877@oss.qualcomm.com>
 <837be315-2eca-4990-94e8-6d0765a8ba44@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <837be315-2eca-4990-94e8-6d0765a8ba44@oss.qualcomm.com>

On Mon, Dec 08, 2025 at 07:10:32PM +0530, Vijayanand Jitta wrote:
> 
> 
> On 12/5/2025 10:17 PM, Dmitry Baryshkov wrote:
> > On 04/12/2025 11:55, Vijayanand Jitta wrote:
> >> From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
> >>
> >> Introduce a new struct type where the optional arguments passed to
> >> of_map_id() are in struct. Subsequent patches add additional arguments
> >> to the struct that the caller expects to be filled of_map_id().
> > 
> > Why do we need a separate struct? Can't we use of_phandle_args instead?
> > 
> 
> The idea is to use it for multi-map support mentioned in the cover letter,
> where we need to pass additional context (callback, dev etc..). Having a
> seperate structure here makes of_map_id() interface easier to extend.

Then perhaps?:

struct of_map_id_args {
	struct of_phandle_args args;
        ...
}

> 
> >>
> >> Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
> >> Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
> >> ---
> >>   drivers/iommu/of_iommu.c              |  6 +++++-
> >>   drivers/of/base.c                     | 31 ++++++++++++++-------------
> >>   drivers/pci/controller/dwc/pci-imx6.c |  6 +++++-
> >>   drivers/pci/controller/pcie-apple.c   |  5 ++++-
> >>   drivers/xen/grant-dma-ops.c           |  5 ++++-
> >>   include/linux/of.h                    | 23 ++++++++++++++------
> >>   6 files changed, 50 insertions(+), 26 deletions(-)
> >>
> 
