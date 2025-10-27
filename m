Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3140226463A
	for <iommu@lists.linux.dev>; Mon, 27 Oct 2025 11:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761563953; cv=none; b=NQSgpjEvOTi446ktQBiSpCg8d5H1Uqlx7tSWst1sDfECX1WvGj+wT24wiH1FWXaZK44EsYEHtwCMP+L54jlEDoqpy24PotctQ6DDLSSp2wy8xMLSYmvG0cmKNbeOrO1d7a07OvSiHJVmy/6SxCUTDXKqzs7hLA9HwLTT8kevLJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761563953; c=relaxed/simple;
	bh=MQoqgKIcXabEG3IJOE0Zlq9sjR0Zv33ybRzFW94DkfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eA+jw/MoasAnBGe99xz2gXfTjA3e7KnQIv6vCVLtdc2dMXaDsONlQWX9lyjbjsL7hE9Tgimva3XyMgt3HkPBK89afVIPt1LbZKn8P0ehDcOM0w9DzbUs8/36MlnnJGKs/g0w4AjZ1L+LseTUKBdAGCRWqzc6UDtsIk6PWrwDSPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=3XiBz3/0; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="3XiBz3/0"
Received: from 8bytes.org (p549214ac.dip0.t-ipconnect.de [84.146.20.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 204835996E;
	Mon, 27 Oct 2025 12:19:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1761563949;
	bh=MQoqgKIcXabEG3IJOE0Zlq9sjR0Zv33ybRzFW94DkfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=3XiBz3/0H6MvT3b7/0ckkS/9wNqaTiL1fa3lwMzYGqjU1G0DmPjJ+6D2KNsG1Wfkj
	 5BkDKeR9Le3l88z7RlvPKnnZHmzfntT4X6Pi6OiMs8J7EukmtFUvuvFtubRzYaGM8q
	 4IbfsIQEeRj9MkhGNKYQdiBXkrKxwulUlqwKb2t/zmVWOaIVSyqwtItXFSackOofdU
	 Er1rtbH8+hU4GPezAGDb2tSkCbJ3DKrLUZIL1IGhcxUx0J9+L0RRqS+el0vDm++PiK
	 TTTu+hGkj+93FZFmgRff1wWE2PpTGALKe6Oxiaxt+kV9oT7M1AZmrXmKveEjeUa6QY
	 DVdwPtnpMMWug==
Date: Mon, 27 Oct 2025 12:19:07 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Johan Hovold <johan@kernel.org>
Cc: Will Deacon <will@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iommu: tegra: enable compile testing
Message-ID: <bmltuzzfdumy5ralderaox72gvgp4vhcrv3sq7vfsl6pp3h2zb@656plvt77nyk>
References: <20250925153120.7129-1-johan@kernel.org>
 <20250925153120.7129-3-johan@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925153120.7129-3-johan@kernel.org>

On Thu, Sep 25, 2025 at 05:31:20PM +0200, Johan Hovold wrote:
> There seems to be nothing preventing this driver from being compile
> tested so enable that to increase build coverage.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/iommu/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
