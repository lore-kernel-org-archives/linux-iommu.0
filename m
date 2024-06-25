Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01CA152780
	for <iommu@lists.linux.dev>; Tue, 25 Jun 2024 12:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719317210; cv=none; b=a+pq1jMu7AT1Koi6/6o49uOdWikHKYt/uZ+xP9Hq74d+KdurUMMMrqTK52YS45y2vAtIAP/wKWseD0ovqOhC5HxV66V32KBLuZPJTs50F13sayuAq5zZ+LQnXn94wvfbx+vXM9sBmoH6qAP3FDD1T5SghdClGT3SB/NjfX96Qck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719317210; c=relaxed/simple;
	bh=Pr4NMFGDggwcU3MV95a+FwbLA9XmaTL/4lMFXE8uqxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GalbnIuKmDB3nPxT3mrl24rwHvTsgKubLkT7xk1ziwbW8c/EznDlBFKlu+87Z76UarA1fDaQ2nogftSKlGYXdOiJMZJ4K6upXnp7q7h7iknKt80KpA00nMECHkVwNT2PBnDimw8RzeQPqRZbvYQGH9JZPt2JFyVThW4iS+SKn6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=bYecgG6/; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="bYecgG6/"
Received: from 8bytes.org (p200300f6af01e500c6341f51fa179db0.dip0.t-ipconnect.de [IPv6:2003:f6:af01:e500:c634:1f51:fa17:9db0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id D404B1C8886;
	Tue, 25 Jun 2024 14:06:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1719317208;
	bh=Pr4NMFGDggwcU3MV95a+FwbLA9XmaTL/4lMFXE8uqxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bYecgG6/6CxvvjHC+6UInn80B9akCaA7AoPe9k5jRap1AAHUFcI7NvRbqSKjMK6jD
	 3V6rDbWyZr5qqkJvWhgUg0zaLRwfWGqXh5irD1h1JHV2hCnqUHPD+9IzlQgsjfVY+i
	 vdqj7FFjeMJP6O6o+zo2ft84w6k5sHpZQMuAsbwoAzZNgK4h8atuPQUjG5JCBfF1yA
	 O7qBecV0C21kpv6mDgNwFB3ymXpBoSN5jdp3NZMrManO3T6rn9aapHrUqiR/uc1iWS
	 UtsFDrP/VR/NUZV1Is6ObsFKGD2tDMvRyx8nOpv7oIR/Q2XAEs/S8fI4QVq8Rhrj6/
	 8jLfpZD5Nk5Uw==
Date: Tue, 25 Jun 2024 14:06:46 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Fix missed device TLB cache tag
Message-ID: <Znqy1ljDqv3WWvep@8bytes.org>
References: <20240620062940.201786-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620062940.201786-1-baolu.lu@linux.intel.com>

On Thu, Jun 20, 2024 at 02:29:40PM +0800, Lu Baolu wrote:
>  drivers/iommu/intel/iommu.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

Applied, thanks.
