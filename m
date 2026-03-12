Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB8F34AB03
	for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 13:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773323157; cv=none; b=knr8B7xB/qNhralGhKKqPWojjFGXAGwPcOBBgWunVqKBx8jidwrtpg+ogu4sLy+zNE0ce+ouj7oQcw6Ir3l/eWNLs7TDdVuHXxEmQQKZCrWRl3BnvCjEDVXY6hKkaNvMWPmI1k5kkhmIAG6v7OkvGi3Kj7kIFIfpQeKFDigBOa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773323157; c=relaxed/simple;
	bh=Uk1eaYDxwOnXFe0hwehMJCK9C/PQO7sHzmbsbGmxH5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ni4xOrzjUmsKO+J1buXBRizLtnwIKGDA4d5XXI65n2q+8Nn1ttxTL76KedOyxrZlB6lNwqgff7P+7N+yEcHCMYwkOVCzC4b7IYIN+8stin2tMJujiAOclWtglRxQd1W7JXABPhNenmzfxdq2FVeljGt+WfYmIjTlWFulNC9PH7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=R6Ax8cFV; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="R6Ax8cFV"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-899e43ae2e1so7896316d6.2
        for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 06:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773323153; x=1773927953; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KZDiw0IT1ijhJVTsklLTZr5XMWeDhUL7eVQ3gusiaQ0=;
        b=R6Ax8cFV1JA05iVhYYKiMC0D92opmmem01ifJFzGV5GAFI1ZF7FG1RBXkvu+PRaqGr
         eDNJNQRBQWI1a/3F1PG3ZiCkZ7RSWZHJgochWrAY8Mest3mdgfhsbyo67UC/McWB9NV8
         cVEY6Q2BdHFtFN9A473/99KrmXi/lC/oDteVpZLIncuV/6akB36sWFte2QIaYGoO8dD8
         S3x8LjgWOaFstpRYy565oFAkT91pOsQzTau7Q2VzWlL/2d4SZ3M4aKhdD7PrvwS6EszB
         /yIV6vBzr5bCe/eGM491fyYR22AKR59PSlE1dLjP/rkQWLG8ohdOAsUJfEios711e85c
         Yc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773323153; x=1773927953;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KZDiw0IT1ijhJVTsklLTZr5XMWeDhUL7eVQ3gusiaQ0=;
        b=Lgg15HxpSzRrS69Ub1yzcRWYKpDqpt6jYa7vLgIGOpaL1u5SrbOzThz+7U2xBbPnk5
         y6JZ2HJy7KU7NhG6rdEwa5WLWUSU0sRGFN3MHnMNW4wQuAm0mhwlsfaamsMqVDcJv/PN
         6f0un1K+YjyeYMrTkQrBicDu1WqDbtE5BQuaQfl2gzBHhIGimtqZZ9eTbK69mwH68/bN
         4DuXXZauaK2ZRdd4ZNu/jcS1KRuWIYvhY1cscEJgbuTjW/Izip1wZOoMMLh4x5vbhDbV
         w/HcA4U/9mxyz/vd0B2wMD5kkd+wxakQkUGoA7XB//+B7oHgO9pqhkxdrEsPZLyOwlcG
         Bc5w==
X-Gm-Message-State: AOJu0Yzi+4WPniMH4KQPI5HOvY33AnsfcVKQ4K9wYwczMjW9a//vZ+la
	2nwDZM5KjDSnVeIko3p9hib4aq02+NuXxaeAVqFhKAj5SxHX7vw6o7+W2/ktZXIaZ3c=
X-Gm-Gg: ATEYQzwMKkCzk/dqvUt9U6KtvdU5OrGzT98qcLOPGv62airmPXT8NQJO7Wf/tHHJhu5
	OWo3LhP4b/ivMWubDTdHGgLW3R4EM29iEnYT3f7o+3HRHx51f4+W7CMt4S+Ca+Nk+t0RxBoqqNR
	G5GL+Hnx/hEjtZlDLWifVhBP/Fzyeb+maA8XXT46lU2TI9V3zhv/F/ZgbJQgJ33gIQZVlGADnQJ
	6Ha8YBwS48Oa7ANx4oe+BGHuWpOg0HDz9wAN+ANS6Km0MsmBSu627ye61QDFjGU0rSHKeynOYCq
	owy6Lx2gb60wAio8wg8KoU69xMWDJGVRn3nDeFLbZJYOmdz84Y5V6afutEOnS4RDgCcY6dqc166
	sb9JUz1Qzyq4buM6zEzQVPo2CZKM/d/2UeWcchj/J1cSeSoluv9cijenvaqOb51DsH310TbpYl6
	S3RttgIE1J3p6IBallFXIqmcGqL1GqiQ1taHYEa+E6xgA9LkxXQ8JJQme7osz/h41BXMzAQLVhP
	rrGS5nY
X-Received: by 2002:a05:6214:400d:b0:89a:ff2:b8da with SMTP id 6a1803df08f44-89a66a85c85mr88443906d6.47.1773323153208;
        Thu, 12 Mar 2026 06:45:53 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65bd5603sm34499696d6.2.2026.03.12.06.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 06:45:52 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w0gMK-00000006fmW-0475;
	Thu, 12 Mar 2026 10:45:52 -0300
Date: Thu, 12 Mar 2026 10:45:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: iommu@lists.linux.dev, vasant.hegde@amd.com,
	suravee.suthikulpanit@amd.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iommu/amd: Adhere to IVINFO[VASIZE] for address
 limits
Message-ID: <20260312134551.GL1469476@ziepe.ca>
References: <cover.1773058553.git.Ankit.Soni@amd.com>
 <b1dc7207fbfc46d6bad89bc484d2034cd2bdd2db.1773058553.git.Ankit.Soni@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1dc7207fbfc46d6bad89bc484d2034cd2bdd2db.1773058553.git.Ankit.Soni@amd.com>

On Mon, Mar 09, 2026 at 02:05:28PM +0000, Ankit Soni wrote:
> ACPI IVRS IVHD’s IVINFO field reports the maximum virtual address
> size (VASIZE) supported by the IOMMU. The AMD IOMMU driver currently
> caps this with pagetable level reported by EFR[HATS] when configuring
> paging domains (hw_max_vasz_lg2). On systems where firmware or VM
> advertises smaller or different limits, the driver may over-advertise
> capabilities and create domains outside the hardware’s actual bounds.
> 
> Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h       |  2 +-
>  drivers/iommu/amd/amd_iommu_types.h |  1 +
>  drivers/iommu/amd/init.c            | 13 +++++++++----
>  drivers/iommu/amd/iommu.c           |  3 +--
>  4 files changed, 12 insertions(+), 7 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
