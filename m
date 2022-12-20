Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B801859
	for <iommu@lists.linux.dev>; Tue, 20 Dec 2022 14:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671548283; x=1703084283;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=vwUKN1/weYQ7e+JpH0fGZo7ZcRb7Zd8KPmAQp/z+Z+0=;
  b=Hs6MyjUXSmOBPbgD7QxRGwFY6mS5G0cV1DAipQrL8n+foL5UP3KzXPd1
   uKExKCUNmMxjFlOgEpC5Yj4Abo9EvSUNi+lp4k48RhQ1slRRk9HTbWk1u
   JHcZ5SuG2UpD6xL9nlgKDJG941nTgjLC+qgigISsoVLrYa/vk8QMdv5UM
   84U/gIPdFqOWuytKXVkQfkRSwlyf3KtVInVBuY/KPTo/RCXseTpzZVlrt
   EoX8SheSdhc8/OLfA1bD+NLgkcRYUvapPIg/gOtZ9cOfsIpuxAa2un/rb
   ZHWtjkN1VTUYCaLIueTQEhGM1PBshA/nbANTqiXJ3BNbm9X0bqoDEc1QL
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="299972191"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="299972191"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 06:57:56 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="601122249"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="601122249"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 06:57:53 -0800
Date: Tue, 20 Dec 2022 16:57:25 +0200 (EET)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To: Christoph Hellwig <hch@lst.de>
cc: iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>, 
    Robin Murphy <robin.murphy@arm.com>, Jaroslav Kysela <perex@perex.cz>, 
    Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, 
    Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, 
    Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH 2/2] dma-mapping: reject GFP_COMP for noncohernt
 allocaions
In-Reply-To: <20221220082009.569785-3-hch@lst.de>
Message-ID: <alpine.DEB.2.22.394.2212201653520.3532114@eliteleevi.tm.intel.com>
References: <20221220082009.569785-1-hch@lst.de> <20221220082009.569785-3-hch@lst.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hey,

On Tue, 20 Dec 2022, Christoph Hellwig wrote:

> While not quite as bogus as for the dma-coherent allocations that were
> fixed earlier, GFP_COMP for these allocations has no benefits for
> the dma-direct case, and can't be supported at all by dma dma-iommu

tested the series and this fixes the issue:
Tested-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>

Minor nit, typo "noncohernt allocaions" in subject of this second patch.

Br, Kai
