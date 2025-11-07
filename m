Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32127494;
	Fri,  7 Nov 2025 08:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762502829; cv=none; b=SDD2Z/2xsZOJzQCk3p9QluvkhMISeSxscRJ4V0rexWUKjIdz6Wuy9i++pXv0G5XIgeRnFiyUMGlvAdvNoPOU5WY21YfO1BWWB93nl3WulOQgIY26+EC44tHddBJYVoW9wzWgeMFo1yWln7gqvIQwWVLS/PAUsVVkCGG35F5MhQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762502829; c=relaxed/simple;
	bh=HBIK1GiJMOogWFE7QnovK5jtCIImRIAOv5n/huCbSt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dj5Fc9RqUapS3eGevrqtHrlGfH1KQlSFs3YaM3P7WBXeAcmU7fQtZd5a1oV+hU2faXcjM8vho7GI7LA1+yjcqGv/0WoBJeuFZjaWFJYcpa8Ju7jo0w39JzndYVfhEIh+yARi9IW40hXpkyPYIGhg6ka5NbJAVzwo73Z4kY2s+b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=akH+XDkX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="akH+XDkX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4EF6C116B1;
	Fri,  7 Nov 2025 08:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762502828;
	bh=HBIK1GiJMOogWFE7QnovK5jtCIImRIAOv5n/huCbSt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=akH+XDkXoTVbqWlRInUz6loheIC4pAhoEucFetdLhZ2KMww65IIvBFLlHYkUJbh6q
	 jbZ7ETmrPkOdB9ah5Jz2OooWo9EoilXHUVBOh9cUu2MTdp61OCJF7HT+uSVnJpSVJ5
	 qcDU5HqYog9rMy41ZAt3GlOMSPYomJ776izVRkTusMtF1xaDelE7WaRY8Yv43BU3a2
	 VseZIZ4hHbZ27dj2HvZyXBD4n3PEvDIP6gvWRnO+fh717y4wMc4nOO97szersggjNP
	 Y6o4OW0fnK7TEeasnHHpKVZGYnPRDxaMqjpgOnDB8HEIFakO+T7rdACGS/mFgmk8l0
	 d7uWlbaIM/Pgg==
Date: Fri, 7 Nov 2025 09:07:05 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
Cc: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, 
	robh@kernel.org, dmitry.baryshkov@oss.qualcomm.com, 
	konrad.dybcio@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com, bod@kernel.org, 
	conor+dt@kernel.org, krzk+dt@kernel.org, saravanak@google.com, 
	prakash.gupta@oss.qualcomm.com, vikash.garodia@oss.qualcomm.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/6] of: iommu-map parsing for multi-cell IOMMU
Message-ID: <20251107-active-uber-impala-8d9118@kuoka>
References: <cover.1762235099.git.charan.kalla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1762235099.git.charan.kalla@oss.qualcomm.com>

On Tue, Nov 04, 2025 at 02:20:59PM +0530, Charan Teja Kalla wrote:
> The iommu-map property has been defined for the PCIe usecase and has
> been hardcoded to assume single cell for IOMMU specification, ignoring
> the #iommu-cells completely. Since the initial definition the iommu-maps
> property has been reused for other usecases and we can no longer assume
> that the single IOMMU cell properly describes the necessary IOMMU
> streams. Expand the iommu-map to take #iommu-cells into account, while
> keeping the compatibility with the existing DTs, which assume single
> argument. 
> 
> Unlike single iommu-cell, it is complex to establish a linear relation
> between input 'id' and output specifier for multi iommu-cells. To handle
> such cases, rely on arch-specific drivers called through
> of_iommu_xlate() from of_iommu layer, aswell it is expected the 'len'
> passed is always 1. In the of_iommu layer, the below relation is
> established before calling into vendor specific driver: 
> 
> a) For platform devices, 'rid' defined in the iommu-map tuple indicates
> a function, through a bit position, which is compared against passed
> input 'id' that represents a bitmap of functions represented by the
> device.
> 
> b) For others, 'rid' is compared against the input 'id' as an integer
> value.
> 
> Thus the final representation when #iommu-cells=n is going to be,
> iommu-map = <rid/functionid IOMMU_phandle cell0 .. celln len>;, where
> len = 1.
> 
> The RFC for this patch set is found at [2].

So that's a v2 or v3? Then number your patchsets correctly.

Try yourself -  b4 diff cover.1762235099.git.charan.kalla@oss.qualcomm.com

Works? No.

Where is the changelog?

Best regards,
Krzysztof

