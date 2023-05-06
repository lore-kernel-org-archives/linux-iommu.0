Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3547E
	for <iommu@lists.linux.dev>; Sat,  6 May 2023 04:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683345878; x=1714881878;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ed3akQEIL1crzDxXFl10Zc/WGefAeiNqKCh0SoU+1S0=;
  b=eMQF3fEOw49H5TLm+e4M/ZqcVReoQfcGCwPbQaLoSMFg2akvkgkgtfDS
   pYQZT+sNSdH50zoEeD1OUtQWrXvklOARch63fsXCs3MApmg3qHdECl6Oz
   1XO1vWeNmae1bW8mcrNBaxtFPFYK/v+RresynL3FoCCFXml4JP4APRbQ5
   sqi2k7HxKuLqMvQaFSKmOMD1NhrqCqUjYdqK1H3aKhJXunj6TflfPRN/u
   0cc6xpspsySwvQPtuq3qVgYedP2U+WUft4hfbcr3mPyeOVJ/o1d25YMT8
   cSvpSLzgmtwXMzctElS5Rm48gGxxqWdCr/Kb8FMppBM06+T+c1QsdgwXq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="338547824"
X-IronPort-AV: E=Sophos;i="5.99,254,1677571200"; 
   d="scan'208";a="338547824"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 21:04:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="697829696"
X-IronPort-AV: E=Sophos;i="5.99,254,1677571200"; 
   d="scan'208";a="697829696"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 21:04:37 -0700
Date: Fri, 5 May 2023 21:09:00 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Joerg Roedel
 <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 jacob.jun.pan@linux.intel.com
Subject: Re: [git pull] IOMMU Updates for Linux v6.4
Message-ID: <20230505210900.0764fa83@jacob-builder>
In-Reply-To: <ZE70doFi8X3KgfrV@ziepe.ca>
References: <ZE5NR5Ml8I2/Ze0f@8bytes.org>
	<CAHk-=wiriLmq6OgLLF9seANqCJqjCrgUC384zcJUFtv3xJgVkQ@mail.gmail.com>
	<ZE70doFi8X3KgfrV@ziepe.ca>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Jason,

On Sun, 30 Apr 2023 20:06:30 -0300, Jason Gunthorpe <jgg@ziepe.ca> wrote:

> We've had this longstanding confusion in the iommu layer that SVA and
> PASID are one and the same thing, we are slowly reorganizing it.. For
> now it is fine for IOMMU_SVA to cover the PASID allocator as the only
> drivers that support PASID also support SVA.
> 
> Arguably the design is backwards and IOMMU_SVA should be user
> selectable and it should turn off the SVA code entirely including the
> driver code.
> 
> > Somebody should double-check my result, in other words.  
> 
> I didn't notice anything wrong, I'm sure Lu and Yi will test it!
FWIW, I did a quick test with SVA ENQCMD on an Intel Data Streaming
Accelerator (DSA) shared work queue, seems to work fine. Code looks good to
me too.

Thanks,

Jacob
