Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F132C369D45
	for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 21:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787608086; cv=none; b=VeVg5dJYPSZYWEI+P3Qx2ElmycwAzqJIdCOEyuUAWnNqBIDVFH5V5WaKGa3qHwHAi/j+YSX3bsmo12L+s2Hl3XqO1fukHp+L7BXn6ca/aN+4iE8IOh9PIb2pRnYUYS40Kjb279yMnX8W1qhEMOJn+qyVWbNb/bUeBUe8BlDjS9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787608086; c=relaxed/simple;
	bh=1AB/9p6Nv9TlqGlJhz19Hzzvkd1Gcyyk/aG7q9mZ3wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ufck76/fYg/c7Xn6IAK9oTaihHMmlsysr2nMxez+ExU9fuHw/AOQZ1cdiPpNm9nsJCEjOhsd8n9+2V/sqOUKpEekHs/m6VexyFRbkvAE7MrIwjb8iRc243jGC/rcewywgqdn7IEhrhZXaN+Ja8jG5D35O51QS0o3gNUePadYRD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=owdFDG9/; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="owdFDG9/"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d3b445a84fso16635ad.1
        for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 14:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787608084; x=1788212884; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1AB/9p6Nv9TlqGlJhz19Hzzvkd1Gcyyk/aG7q9mZ3wk=;
        b=owdFDG9/11jSjWmViY9SwZaJC69hZ6junFX1HsCRmA1Ve2wxL+yF5pfPNEgQs7phag
         FTAfOOKcRw3OMQ4PmodKfjGVm2XGVbJ/7RG9TNeaWpBjmD1giWdmfY4OC5zfmMmegw2i
         Y+NrGDXOcVnFWiwiJpaFFCS/jXxS+Mi7333BC0jqEaTjcQcNVunB5oYuttQUdOcjHPML
         5pa14ab9u5KWzPz+xve7n5oCSKsLMYu6jcuPWDjqZ7QQWwNne4IKMiqL2eDFCNmJKw69
         nafxXnoxbCVMJRkNeHQc9klt5Ld/64WAfVL0eOE3GGe2l2p3/cEFhvBcAWNBO4JsbsQ6
         jxjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787608084; x=1788212884;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1AB/9p6Nv9TlqGlJhz19Hzzvkd1Gcyyk/aG7q9mZ3wk=;
        b=oqE9IMr1WHEadbaqONSjpJQ0qlr4AMV5tzBi1NWJuHcy/R3YEyZMcI/92JSwKCZQxI
         L7r7aLTkQfBac7jPF9K2ePjFASVwF0BMhoahw7vtR9nLLTSPZi1lrJmJx5NcWJ7tuapG
         outbUKe4XSFUayUC19hW6ALK1G4Qldb0cEJggOn4DJhi/trRD8go2f6aGNcax1dvr5He
         l6msrydR8HgWBOz8kLisvcqc171mHc7oGrED5JU/Zrn7jtnzbNsiM0kfPooo6WpJ/r98
         jUV+z6BS8Njqji7uA5TRXgLfDOqgzDcOOKSW8v9hLl9Ulhw1iwECd7doYuA6RVQ4b84L
         UviA==
X-Gm-Message-State: AFuF++ndH6/S3OekYLjCz9h2iZRhm/1MD1t3r34Ljzx/YtFn7yxMRvc3
	2cYEgky1W4YwlS0mjlr455PmgVkzUcwbOzAg/tTUVD4Fb5Wxw4L3hjiPo49ScVWDAQ==
X-Gm-Gg: AR+sD13j82FcCeMMerhS1Zy+2fl/m6usNBgwedOgRCHDCw30ZbnBrcC0XNR78Bu8KCZ
	T1h+BmlwsorR37eCxUR0t7aAxhKn9/pl/3dElsqavH3EykqulANywQhY9IznNBO0zh7UR3YhIs0
	fk/LGaBZlzJ4/QCC1PTybysaKsYW6H1YyUzE+rO5jnFuP1po1Z/D6iLhhYc6iyhszfx3COt1wQk
	8t03i3TZ3gG12XJg/qk0lTvvC1PyLBsDcg5ilsBj9r2uBOZKQ+3TLQ8XNQqIfEKYlujjjMxr6QS
	Wl+T72GNyyiM5XLJWYZ4vwBodWLdmjCk8M/7rdZzsaBT6OHA4fb+VV0+y8CVNl4bvc2Y6RtNXbS
	3WqWJYkCXNMSx1eW0nmfPPaSKrxFY/Xz3BqqpJAMIkOiWLtVqu4aEWZQd0APuvctyr2lbtuxE0B
	Dn9MPBi0eJLPm46uZKBLNRrrb3lfJhvctqX07mFJs8xDSD9EyJ0L9AutGM4RILKOUUMSklJfUNk
	RwevGdQ2/fwVM+/uW7yQyrgzqB33ZeGIJEH2P/iuoGFzYa2nYUr4e5MBRA=
X-Received: by 2002:a17:903:98b:b0:2ce:b436:272a with SMTP id d9443c01a7336-2d6e07f16demr2108015ad.3.1787608083516;
        Mon, 24 Aug 2026 14:48:03 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645b64c48sm1054146a91.8.2026.08.24.14.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 14:48:02 -0700 (PDT)
Date: Mon, 24 Aug 2026 21:47:59 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Ankit Soni <ankit.soni@amd.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] iommu/amd: Fix DTE clearing and rename
 iommu_ignore_device()
Message-ID: <aoy8BdBFMVNPEi9K@google.com>
References: <20260824122347.1588592-1-praan@google.com>
 <20260824122347.1588592-3-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260824122347.1588592-3-praan@google.com>

On Mon, Aug 24, 2026 at 12:23:44PM +0000, Pranjal Shrivastava wrote:
>The iommu_ignore_device() function currently uses memset() to manually
>clear the primary Device Table Entry (DTE), which risks torn writes as
>the hardware reads DTEs as atomic 256-bit qwords. Furthermore, clearing
>the primary devid in the lookup table before calling setup_aliases()
>causes rlookup_amd_iommu() to fail for aliases. This prevents clearing
>the DTEs for DMA aliases.
>
>Fix this by replacing the manual memset with a dedicated helper that
>invalidates the DTE by clearing the lower 128 bits (having the Valid bit)
>first, followed by the upper 128 bits. The cleared state is then
>explicitly cloned to all aliases before the lookup tables are nullified.
>
>Rename the function to iommu_disable_device() more accurately
>reflects its intent, as we still support IRQ remapping for these devices)
>
>Fixes: 99fc4ac3d297 ("iommu/amd: Introduce per PCI segment alias_table")
>Reported-by: sashiko-bot@kernel.org
>Closes: https://lore.kernel.org/all/20260529153216.2AD1E1F00899@smtp.kernel.org/
>Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>Signed-off-by: Pranjal Shrivastava <praan@google.com>
>---
> drivers/iommu/amd/iommu.c | 53 ++++++++++++++++++++++++++-------------
> 1 file changed, 36 insertions(+), 17 deletions(-)
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
