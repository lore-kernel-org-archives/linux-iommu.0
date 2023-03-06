Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B70F566C
	for <iommu@lists.linux.dev>; Mon,  6 Mar 2023 17:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678123985; x=1709659985;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DUxKUZFXlH9ieOprWzSIsATKqQ+Kr3d5N+BZv+HPjN8=;
  b=Jo2/7qx9L5fphGvMwy5wYUHTsTyiqFakOvIRtwigFWnoL09mAmhIhdp/
   8q47B3rEIBzHpLYayvtDCqFRVmLfu2/Vu0GlL+KdcrPbc23WSDYNpI/Oa
   N8v/VSz2Hzn+6fjtgMZgdgZisi90rKB7SJ3SvDaYW+CRFPibIMMqxW+xC
   5cHjMda2NMh5nm/3XTfZRskZpO0F7+jPOMifET6lz8IS/cR13oCewvumM
   5ISFvf5Wmdp5wPkBkOTsbR1YwWxZdogaNq99xChbf1UdVeHSY3kka++rj
   cIfg9f6P8E5SJQqaW/Tgm9P+MZ8xXig6BUz/+Ex6JHxhOSViPaEpNGNqg
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="363240591"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="363240591"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 09:32:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="745155575"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="745155575"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 09:32:36 -0800
Date: Mon, 6 Mar 2023 09:36:26 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev, Lu Baolu
 <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 dmaengine@vger.kernel.org, vkoul@kernel.org, Robin Murphy
 <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, David Woodhouse
 <dwmw2@infradead.org>, Raj Ashok <ashok.raj@intel.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>, "Yu, Fenghua"
 <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>, Tony Luck
 <tony.luck@intel.com>, "Zanussi, Tom" <tom.zanussi@intel.com>,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 1/4] iommu/vt-d: Implement set device pasid op for
 default domain
Message-ID: <20230306093626.31c1573e@jacob-builder>
In-Reply-To: <ZAXjVaucrkEvrfsw@nvidia.com>
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
	<20230302005959.2695267-2-jacob.jun.pan@linux.intel.com>
	<ZAXjVaucrkEvrfsw@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Jason,

On Mon, 6 Mar 2023 08:57:57 -0400, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Mar 01, 2023 at 04:59:56PM -0800, Jacob Pan wrote:
> > On VT-d platforms, legacy DMA requests without PASID use device=E2=80=
=99s
> > default domain, where RID_PASID is always attached. Device drivers
> > can then use the DMA API for all in-kernel DMA on the RID.
> >=20
> > Ideally, devices capable of using ENQCMDS can also transparently use the
> > default domain, consequently DMA API. However, VT-d architecture
> > dictates that the PASID used by ENQCMDS must be different from the
> > RID_PASID value.
> >=20
> > To provide support for transparent use of DMA API with non-RID_PASID
> > value, this patch implements the set_dev_pasid() function for the
> > default domain. The idea is that device drivers wishing to use ENQCMDS
> > to submit work on buffers mapped by DMA API will call
> > iommu_attach_device_pasid() beforehand.
> >=20
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/intel/iommu.c | 32 ++++++++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >=20
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index 10f657828d3a..a0cb3bc851ac 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -4665,6 +4665,10 @@ static void intel_iommu_remove_dev_pasid(struct
> > device *dev, ioasid_t pasid) case IOMMU_DOMAIN_SVA:
> >  			intel_svm_remove_dev_pasid(dev, pasid);
> >  			break;
> > +		case IOMMU_DOMAIN_DMA:
> > +		case IOMMU_DOMAIN_DMA_FQ:
> > +		case IOMMU_DOMAIN_IDENTITY: =20
>=20
> Why do we need this switch statement anyhow?
For DMA API pasid, there is nothing special just let it fall through and
call=20
	intel_pasid_tear_down_entry(iommu, dev, pasid, false);

> Something seems to have
> gone wrong here.. SVM shouldn't be special,=20
I think all the trouble is caused by  the asymmetrical setup of
iommu_op.remove_dev_pasid() and iommu_domain_ops.set_dev_pasid()
Perhaps, we should "demote" remove_dev_pasid to iommu_domain_ops then we
don't have to check SVA specific things.

> and why does this call intel_pasid_tear_down_entry() twice on the SVA
> path?
Good catch, that seems to be unnecessary.

> It seems like all this is doing is flushing the PRI queue.
> A domain should have a dedicated flag unrelated to the type if it is
> using PRI and all PRI using domains should have the PRI queue flushed
> here, using the same code as flushing the PRI for a RID attachment.
Yes, or if the teardown op is domain-specific, then it works too?


Thanks,

Jacob
