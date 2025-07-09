Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0B72C187
	for <iommu@lists.linux.dev>; Wed,  9 Jul 2025 00:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752020783; cv=none; b=A5DLchf532FlrgRsmgo8m1LGoEGYDAWpZEDZjS0qnqmZARvQuPHY/KOnW2VjfOkRTC9pyCdasRMRfS1cZjUM1i1fZg3b4YEv47O2hp/J550F4qHDETUuVMi3zEA87b+EISyLeJdzp2RjeT4o6vleIYq1JJE/FE4maryokqTp3V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752020783; c=relaxed/simple;
	bh=xbbei7U6p6rKAO0csoP3ETOXHvHtulZ3jMXriqErwDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gAjunsScZ3UuTNfIBVF3ZH9+uflVeRB8tN0A6art/x6mfeUE7GAkbPCGUFJRaGqgaW2hg1rEZUcJ4XQeAcNdGYeStOHoaT7uhrj75qfpPsPjJ7YgnfWYszQ/ZCtzmd+KdXPUY5J2NKh/gGxOYBV+I5+pMBwahMzoejRTo7RXmI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=n6sGSF9n; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="n6sGSF9n"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4a4bb155edeso60958601cf.2
        for <iommu@lists.linux.dev>; Tue, 08 Jul 2025 17:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1752020780; x=1752625580; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4dAC1p+EwdmBHwbIWbaFVBlz5nVRbD9VkK1roJ2KD4g=;
        b=n6sGSF9ng5E/m9Gw0f1B7ujOc0NdS7qnK0PRdzM+SpVCQZokTg9zf/ZnsVcqu9knfO
         H30SKqIb+Bds1bI57kDpWP7oQY29WZ4dk5FSvAIoCFU2Z7QnqkODfwgUX3K4Hic4Pwqd
         6lTt/NLpf+AY6z9+fPQrdJ9dGcI31X4CYsLR1GtXNXwClnNBCHzXoJ7FqlhgqLK6XbQp
         XqAYvz3eARIu/zWPP3XR2wO7KfVc7F7vbo907bNbm11ootRZdj3p0Lnvx+qWVQYzaSLp
         fBYVwggSyiILJ1UnaA8YCCT5MWIRj4Beqxmys1U4iBYHrBwSG+WAKHq1hOnttzB90vJS
         MtYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752020780; x=1752625580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dAC1p+EwdmBHwbIWbaFVBlz5nVRbD9VkK1roJ2KD4g=;
        b=Ah4GxRwFqBIrVNn+4OUwxzu2VFZ6+9CFsqcAGoz5NozzUO3+utHkO0iqJPddnwCGQY
         tSe1N+66DixhoKlWlDMmPryCvT7Hr8gKhOLS5e2NNn3NZQ/EpGWd9Qo50GNJQYvle2bt
         VhrnqUQEUMhcaaO8DZ0mP6c3XwmYJCVGJp94efIFNUvx6YV7AGSQ75gikGVpfYtKZvnI
         TFryNhOb48JSR7T/2pgo9WD1N/NIa1YL1F3VoMXB+3q/JW9ouyJn2u4P8Q0YOxA6Cfnu
         MD7XhCHsOQaAp//TCEXuAw8nIRdiEijeQ6U+tH7yc/POqn6Cc5gvtDtNCNCe/HliKlNo
         luOg==
X-Gm-Message-State: AOJu0Yy8D4NKxxvaI3lDICQE7FrAgOpgTJ+gwqOOFg8iAwwl5R2y2AwV
	T1ucoRkLemqVees6813UU3oTicHbP9/ucr/zg5Amql+P42wnjzwZ9H8ObDEMCYMHBtpEP+fXDWP
	juczo
X-Gm-Gg: ASbGncui0ZjaTyfiUXBbjSa9TakinBc9vJGPKoJKkSwJQE3sosELzQqEhURMNM2wXqr
	+Ayij84HK/4e8uYQmPnC8UJPA8NkDAnPRvAu977vJH+OpSGvtP3SWBJXpS0+EWYGbIA5KrdcHx1
	WrdBtWPOpzjgqWCNI3bdqtpzefvyV2hSseMRkk+ZeqSv7oOGcdo09i6OX7KLL2xq446Bn+gIJXi
	7qBRkaULlvTSX+scr37345d1Teq9oIsBTOPimcrYcl7kDRlhEGDrdeIaoGbw/tIr9qS/+9LEpvF
	i/J1dsFH5YIAgxJDkb7L51JvLW426qVmaXXJ
X-Google-Smtp-Source: AGHT+IFSaVO7q7bu+dYOf1GVeKqZs7GLoxtb1NdzR9hlmeu1FRZsqxH2hLA4RP5hCtbSDnx4/dkebQ==
X-Received: by 2002:ac8:578c:0:b0:4a9:c2e1:8844 with SMTP id d75a77b69052e-4a9dec1f0bfmr6312041cf.10.1752020779702;
        Tue, 08 Jul 2025 17:26:19 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a994a8e083sm89289331cf.65.2025.07.08.17.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 17:26:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uZIde-00000006x1B-1jAi;
	Tue, 08 Jul 2025 21:26:18 -0300
Date: Tue, 8 Jul 2025 21:26:18 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Daniel Mentz <danielmentz@google.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>
Subject: Re: [PATCH] iommu/io-pgtable-arm: Remove unused macro iopte_prot
Message-ID: <20250709002618.GA1599899@ziepe.ca>
References: <20250708211705.1567787-1-danielmentz@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708211705.1567787-1-danielmentz@google.com>

On Tue, Jul 08, 2025 at 09:17:05PM +0000, Daniel Mentz wrote:
> Commit 33729a5fc0ca ("iommu/io-pgtable-arm: Remove split on unmap
> behavior") removed the last user of the macro iopte_prot. Remove the
> macro definition of iopte_prot as well as three other related
> definitions.
> 
> Fixes: 33729a5fc0ca ("iommu/io-pgtable-arm: Remove split on unmap behavior")
> Signed-off-by: Daniel Mentz <danielmentz@google.com>
> ---
>  drivers/iommu/io-pgtable-arm.c | 7 -------
>  1 file changed, 7 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
