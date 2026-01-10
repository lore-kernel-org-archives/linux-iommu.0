Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F6D2D6E78
	for <iommu@lists.linux.dev>; Sat, 10 Jan 2026 09:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768039152; cv=none; b=ccy165WIlJeWn89Hn0yTHNEV8Ik/cnFKXU6rBCJ5M1g7hwe35vKxKj3zFgsEZ0cMQb8TCkVL/SjuFo6EC1qlIw4bk06uRXQaIFOQ9aGaGnvJf0x6yoyI/foqFM3nfFgmre31Lq14SKoS2lPyyqhooF+PdtxuMUqhKTarpkCCnHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768039152; c=relaxed/simple;
	bh=BF8RvD6QBTl20oh2S+3VxV4SPJA9i9UAJor7HmK/998=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMvJ2tZ15gqV01/PJgKQNSXTFyDbXYh8NNdihHmACXK4e3EPmQCVkMEg0t1CgtDE2ADs0fxqMBomhE0m8I7eprtO+Dlp1I0rFj5O3OPssqWJ2bV0iAoUeW/uetCBI4QLHV6zEce8dmZ3h5ROFWJDQFpi03eGZBxvDjzHNJDcDA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=UxRTFbs9; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="UxRTFbs9"
Received: from 8bytes.org (p200300f6af1d9600dfc71246d978d903.dip0.t-ipconnect.de [IPv6:2003:f6:af1d:9600:dfc7:1246:d978:d903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id CEA195F02F;
	Sat, 10 Jan 2026 10:59:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1768039149;
	bh=BF8RvD6QBTl20oh2S+3VxV4SPJA9i9UAJor7HmK/998=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UxRTFbs99qD0FHEZyLcUX8u4koyxqFJSax44SUIVXPvobq+jEuo0un5laTvStwpvn
	 kN3r3lgGK33zTYA2lm5Qjf7njMI+aaikzND48fQNyH2adF9re5UWQjfwof/xgXsLNI
	 m8fny3Uus92fjJ26GdgB3g6tefKhvVDl2lgrv6x7VdKFAXCJ3a6r1xNKgS/RBQPIQW
	 MFqkwyzxlgLeYAS7vu/gHQvpYXq+t+N/IzZf8calX5SO3HeJLgazsPzifNCbV9JxTt
	 4V+RdH+zjckdDLgEGbVCkbZVVi/5uW+0/y/TQrDFf06XId9nbOuoL9ed2w7dNV2s3b
	 sPMQrzs44rVAA==
Date: Sat, 10 Jan 2026 10:59:08 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Can Peng <pengcan@kylinos.cn>
Cc: will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: simplify list initialization in
 iommu_create_device_direct_mappings()
Message-ID: <stpavkxy3sbevk7zmt4kxyecqy5gc6phubvcfutbtnuk7vphlh@a7aimtvk423i>
References: <20251209071513.3105610-1-pengcan@kylinos.cn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209071513.3105610-1-pengcan@kylinos.cn>

On Tue, Dec 09, 2025 at 03:15:13PM +0800, Can Peng wrote:
> Use LIST_HEAD() to declare and initialize the 'mappings' list head in
> iommu_create_device_direct_mappings() instead of separate declaration and
> INIT_LIST_HEAD(). This simplifies the code by combining declaration and
> initialization into a single idiomatic form, improving readability without
> changing functionality.
> 
> Signed-off-by: Can Peng <pengcan@kylinos.cn>
> ---
>  drivers/iommu/iommu.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thanks.
