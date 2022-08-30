Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7248442C
	for <iommu@lists.linux.dev>; Tue, 30 Aug 2022 17:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661879190; x=1693415190;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WGjrEl22Aq56liEypn1scjKGRY/wkDI6MWC1UBsr848=;
  b=dRMSVtBzm1vZqi8hQl1t2+LHtZzcT1nRIujvmWWFiA9sI7G073+qpf91
   2GKQkNa7KiFJ47UsVQe+Vgkvl1YaUbFq0PyCVHn9Pv7H1O9GRgCLZPOkb
   0yNY3NwjxL5WFaJN7UEdrk3L9N4GubbwgkzDHp/jBUZ8DWeXMfl/byaYc
   YRbMG7VHFUWqbv4FR4wRHiFPRgRzXny4fTVE7JwswfGak1s9oHAzdSPo9
   fHuKeYiByuaz8RL9AoaZfzS07XuvyxVzZFkqIZa4fg8nMoVVr2efVjQNf
   1UVJBVdoaSsj8nBI5WXWg98GIKk8nA344gjPX3yRcrSNZOooZYtdPK3h3
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="296522951"
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="296522951"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 10:05:33 -0700
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="737807762"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 10:05:33 -0700
Date: Tue, 30 Aug 2022 10:08:49 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
 x86@kernel.org, Joerg Roedel <joro@8bytes.org>, "Lu Baolu"
 <baolu.lu@linux.intel.com>
Cc: Raj Ashok <ashok.raj@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@intel.com>, "Borislav Petkov" <bp@alien8.de>,
 "Ingo Molnar" <mingo@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>, Yi
 Liu <yi.l.liu@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 0/2] Use the correct page tables for SVA under PTI
Message-ID: <20220830100849.63751271@jacob-builder>
In-Reply-To: <20220822201213.352289-1-jacob.jun.pan@linux.intel.com>
References: <20220822201213.352289-1-jacob.jun.pan@linux.intel.com>
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

Hi Baolu/Joerg,

Just wondering if you have any comments? Thanks.

On Mon, 22 Aug 2022 13:12:11 -0700, Jacob Pan
<jacob.jun.pan@linux.intel.com> wrote:

> Shared virtual addressing allows DMA to user virtual address, But the
> x86 IOMMU drivers are using the kernel copy of the process page tables
> when PTI is enabled. This patchset tightens the security intended by
> PTI by performing SVA binding with the appropriate process PGDs.
> 
> I have tested on Intel platform only, would appreciate itif someone
> could help with testing SVA-KPTI on an AMD system.
> 
> Jacob Pan (2):
>   x86: mm: Allow PTI helpers to be used outside x86/mm
>   iommu: Use the user PGD for SVA if PTI is enabled
> 
>  arch/x86/include/asm/pgtable.h | 5 +++++
>  drivers/iommu/amd/iommu_v2.c   | 4 +++-
>  drivers/iommu/intel/svm.c      | 5 ++++-
>  3 files changed, 12 insertions(+), 2 deletions(-)
> 


Thanks,

Jacob
