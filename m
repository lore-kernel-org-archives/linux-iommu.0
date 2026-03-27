Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC39D3D6CA9
	for <iommu@lists.linux.dev>; Fri, 27 Mar 2026 08:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774600510; cv=none; b=DV/5egn3KZv5h93CSbcZtpz3NjRRMjueGVh4VnT/eAuAecN2s3e3AMbTFo0C3P8KJTm3gXTJkCs0I4tHs1MGuYsVZ6H7oVQHBvTfNYrobSv6a0pNoHn45cXoKgpVNMibvk2/RnBF2+LxHDe27LEepKd6PlH2zTAqqlUcte17MXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774600510; c=relaxed/simple;
	bh=Bmlj2evGzvCDdXu2zq4w5fQ4NVFEoYZiaircgvtA79A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QvFmM/zXAO49frENDJFdStFBDlvwQyLR9kkA7NnxOg8wGLO+KhmcZP+Lj7OPy0irabOyrM96s9L86TqrOn5UTvTu1NP7+UgyMZt4i6q9U7NjRBE9426hy+oTwZj44dK4SJ7P3jzfe9R1hNeYr+lOzKNm98YaQExkeabXvhEO09A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=DIgjQjuy; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="DIgjQjuy"
Received: from 8bytes.org (p4ffe051a.dip0.t-ipconnect.de [79.254.5.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 4842C1A62FE;
	Fri, 27 Mar 2026 09:35:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1774600506;
	bh=Bmlj2evGzvCDdXu2zq4w5fQ4NVFEoYZiaircgvtA79A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DIgjQjuyYayoXKvqB+948SitiIzqSV+efXrNqpt51iCznBGPtadZ1Vxv+iPSnc707
	 Xhu5v7axyumulbmQvOoOVXCqZwZBLY1sFe7YkXcav+0V0UyYoRVjFJNtJUkhVcAROA
	 AibN2Q0XeLDG2ehsRwcYCmo/DncWzE4lWfvrPgh42GZs9TPF9iYAW7ucE6Bn9/HogS
	 5dtJjcyGgextBm9DQuUm+TuEbJ1QlL4MDvqm4dJ71fj2u5hfW4FiahDDJ+oGNNUvwz
	 L8u9uknJ/2s0k0aOGpbX7iGnAe6uFh90plpJS9b+Cv4zRBzYR7qq5DVfnpFRYr1hI8
	 1EycyFgheibUQ==
Date: Fri, 27 Mar 2026 09:35:05 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: Tomasz Jeznach <tjeznach@rivosinc.com>, Will Deacon <will@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Robin Murphy <robin.murphy@arm.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, Yaxing Guo <guoyaxing@bosc.ac.cn>, 
	Andrew Jones <andrew.jones@oss.qualcomm.com>, iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/riscv: Fix signedness bug
Message-ID: <gbresi4jgjmt3cydjftumy7f3afrk2ondap4mx6xfjmrtdnvsq@fpv4htqzdcvz>
References: <20260319182644.1082740-1-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319182644.1082740-1-ethantidmore06@gmail.com>

On Thu, Mar 19, 2026 at 01:26:44PM -0500, Ethan Tidmore wrote:
>  drivers/iommu/riscv/iommu-platform.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Applied, thanks.
