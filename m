Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E563C7DE4
	for <iommu@lists.linux.dev>; Tue, 17 Mar 2026 13:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773752551; cv=none; b=kYuiWHDeKg1HNnXsr2F7KOU9vOoxogck2UAbtY8QZqsQVOwB7LUEZ4Tr2zIdo/qpm8dWtTi5vc2FWG5pN5lndHfbEdRSJZPeAhvvK4AzFXhI7rad4LbU4ITfOhguMGikNQcfC1BIxq+QvrkCdWdNQ9wAny7QSeNS1UACRrP0A0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773752551; c=relaxed/simple;
	bh=wtKQ/Ge1d4ndY7HfpKxAuUFQau1Vz1Yekpu7eRpQMOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OipIM3wrdNuUobOPP7fSqwv1D54+7hOh3lpY8y5i2ItTJdU5aNtj/vJIH7jvH4DX2UgNXepAyY4CellBnOccN/aET9pD6oV4kwusuIzvjiAkjIT+zASA+0IohaI/+qXo+Cp7PwiTh/VO/ToL3/8uHL+W23lg5u6cY0sExdUOD2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=2LnMCGfo; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="2LnMCGfo"
Received: from 8bytes.org (p4ffe051a.dip0.t-ipconnect.de [79.254.5.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id DEA6B1A52C5;
	Tue, 17 Mar 2026 14:02:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1773752549;
	bh=wtKQ/Ge1d4ndY7HfpKxAuUFQau1Vz1Yekpu7eRpQMOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2LnMCGfokihDhAHiXV0dD4USopGrUwml6tx5pnHm30yuFCF4E0zVKmh4wQs6nJLDO
	 NCt/dufeUdcZkBm62cVIf0JtUDKBjZDtwc05cdnp7nx3+eb6zthxSnQZyLvjtDCn06
	 0ppx6AzBNMXbidkde4GjIiEIxBHf93QIhKbtI6WcyuoiSJ+cqJ7228qE8wn39yX7OG
	 +QzxEnkydGDPBqg3P/42wx96JiihgnaIC9XEgSYbRVmA65CR+NzUO/hKceHZKHD3kp
	 Unpu50vk0A3ysNqm4uPih6TjX/wmjTyYx3vUFkDcnOkSLDIPpHvioSU6WF2sqzZy5s
	 9WCtsFuTmOvGQ==
Date: Tue, 17 Mar 2026 14:02:27 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Joe Damato <joe@dama.to>
Cc: iommu@lists.linux.dev, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org, 
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] iommu/amd: Block identity domain when SNP enabled
Message-ID: <3vljbmpverij4kak2i6lj5pajtp66ldfg7f5lebjwrzqte7j7j@rewhiw4xvllq>
References: <20260309235234.3367768-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309235234.3367768-1-joe@dama.to>

On Mon, Mar 09, 2026 at 04:52:33PM -0700, Joe Damato wrote:
>  drivers/iommu/amd/iommu.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)

Applied, thanks.
