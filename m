Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F59212F89;
	Mon, 15 Jun 2026 11:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781523921; cv=none; b=CR/PHty0FgHttqDokugE1ky9km8xZZr5U3Oahd8L+QfUN2TPu6oqRB7TPTyVmtPgAu/I/FMKcbu12/Rx3PyTdS1L+LqJw8vqkaRnlLcYozFFM7PJkxRx9kWBMoC2h396wFp+n3GOtC3Ef15YokdcNsdmuhHBLSlM3DSs6EflkuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781523921; c=relaxed/simple;
	bh=KYfrvDcDWNFjsXDVASxGC/jaOyt3DNHJhAlec2Q0COY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B+5prPr/fuxFy/Xo2aSLtvnT0hWi0WZi4vZ68VcbXD90bevpM9aMz+UCezNXckxUhxdIzkgmIHKQoyVC0XkGgJbS/lwGjdJTcLC/MO/giUiyO+B90UnSJJHtJAD/JjevVqqQ2NvED9WpzmBgPbdqKg6y85e4DEzi/Po/XK8oDeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5QbNGLy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5QbNGLy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA4AA1F000E9;
	Mon, 15 Jun 2026 11:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781523920;
	bh=RR8KTcEsfskTnKRFhpXpiF0qZKR1fK8uVS31R/MoZ7A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=L5QbNGLybWNIJewG+yVzRwO8jT4nFbqHsKGNY+dh/29xuW8KCcJBme6hoRwo0igpV
	 OhG+M/TdvefeW+g0lq4kR69Dij9/fRj6nQMhnRvAeYQqfN2guQ1DrpGues4IpECpf1
	 IyrV4pGK/W/YM0RJfVygkGgob0H/j08VhcsYGc8Qmfc69JGqNvu/Mc1KPMWWlCM3PM
	 tQCMIGT4VbG8R7TU3dhFkRahtMJegfLtN9jrsSMV/8+vLt3L2Hnc6Nq2UAUA4qoPKs
	 tYxkPgiB0wPUGTq+uvgoOhVv/UizzqBJBPQnib7FpcD6Cib1itIeSGE/IoKUAoJJxt
	 /qERVSqiiOzUg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,  Lu Baolu
 <baolu.lu@linux.intel.com>,  Joerg Roedel <joro@8bytes.org>,  Will Deacon
 <will@kernel.org>,  Jason Gunthorpe <jgg@ziepe.ca>,  Robin Murphy
 <robin.murphy@arm.com>,  Kevin Tian <kevin.tian@intel.com>,  Alex
 Williamson <alex@shazbot.org>,  Shuah Khan <shuah@kernel.org>,
  iommu@lists.linux.dev,  linux-kernel@vger.kernel.org,
  kvm@vger.kernel.org,  Pratyush Yadav <pratyush@kernel.org>,  Pasha
 Tatashin <pasha.tatashin@soleen.com>,  David Matlack
 <dmatlack@google.com>,  Andrew Morton <akpm@linux-foundation.org>,
  Pranjal Shrivastava <praan@google.com>,  Vipin Sharma
 <vipinsh@google.com>
Subject: Re: [PATCH v3 01/18] memfd: export memfd_get_seals()
In-Reply-To: <20260614233728.2212104-2-skhawaja@google.com> (Samiullah
	Khawaja's message of "Sun, 14 Jun 2026 23:37:11 +0000")
References: <20260614233728.2212104-1-skhawaja@google.com>
	<20260614233728.2212104-2-skhawaja@google.com>
Date: Mon, 15 Jun 2026 13:45:16 +0200
Message-ID: <2vxzfr2oqb77.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Jun 14 2026, Samiullah Khawaja wrote:

> memfd_get_seals() is used by iommufd during preservation to make sure
> that he preserved memfd was sealed when it was mapped into iommufd.
> Since iommufd can be built as a module, export memfd_get_seals() to
> avoid linker error.
>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
>
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>

Acked-by: Pratyush Yadav (Google) <pratyush@kernel.org>

-- 
Regards,
Pratyush Yadav
