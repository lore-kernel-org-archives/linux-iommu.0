Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429E27F
	for <iommu@lists.linux.dev>; Wed, 14 Jun 2023 17:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686762908; x=1718298908;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+axceMY/sA0RUPEI/SsihcSDgTCdjPx1bekyxvK9JBw=;
  b=g6U1Vxt1Lv8Q/pnZkrGJDdazA1YO+3U8rVCgln6wXVcixeVseYiixNar
   9qyoeZoE+uwv9SWO30f//+TlC02vcd52Xmug1UI1te0Yy01308OTNcQ72
   bn6FTmg3AM7OG3/MSTWFGK41XBusHTsa99E6yFleeyUnJmAZJHhU+JcYM
   VHL4mzUON93GUPvSuVgYFJa7cA4VK6e5D4F8mSNEuQSWf3CuuXrGBDKO2
   zDeOj0A/vhRksacSbCHq8zmNFlbn/RlqMMW7EEJbKInuu0xpYaHNIaCXi
   gMYM4ymk3jjLemlCsb2v8y2FWMEb2kBI/HryH+OdY5vC6VMy7Mj8BG7Uy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="358678786"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="358678786"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 10:15:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="801998912"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="801998912"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 10:15:06 -0700
Date: Wed, 14 Jun 2023 10:19:49 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev, Jason
 Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Robin Murphy
 <robin.murphy@arm.com>, Jean-Philippe Brucker <jean-philippe@linaro.com>,
 dmaengine@vger.kernel.org, vkoul@kernel.org, Will Deacon <will@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Raj Ashok <ashok.raj@intel.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>, "Yu,
 Fenghua" <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>, Tony
 Luck <tony.luck@intel.com>, "Zanussi, Tom" <tom.zanussi@intel.com>,
 rex.zhang@intel.com, xiaochen.shen@intel.com,
 narayan.ranganathan@intel.com, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v8 2/7] iommu: Move global PASID allocation from SVA to
 core
Message-ID: <20230614101949.1164f33f@jacob-builder>
In-Reply-To: <b5a6a7ad-bfad-b550-f4be-f5ec0679f3d2@linux.intel.com>
References: <20230602182212.150825-1-jacob.jun.pan@linux.intel.com>
	<20230602182212.150825-3-jacob.jun.pan@linux.intel.com>
	<08830c11-5528-0c42-0bc3-89c3796611fe@linux.intel.com>
	<b5a6a7ad-bfad-b550-f4be-f5ec0679f3d2@linux.intel.com>
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

Hi Baolu,

On Tue, 13 Jun 2023 11:06:03 +0800, Baolu Lu <baolu.lu@linux.intel.com>
wrote:

> On 6/10/23 8:13 PM, Baolu Lu wrote:
> > On 6/3/23 2:22 AM, Jacob Pan wrote: =20
> >> +ioasid_t iommu_alloc_global_pasid_dev(struct device *dev)
> >> +{
> >> +=C2=A0=C2=A0=C2=A0 int ret;
> >> +=C2=A0=C2=A0=C2=A0 ioasid_t max;
> >> +
> >> +=C2=A0=C2=A0=C2=A0 max =3D dev->iommu->max_pasids;
> >> +=C2=A0=C2=A0=C2=A0 /*
> >> +=C2=A0=C2=A0=C2=A0=C2=A0 * max_pasids is set up by vendor driver base=
d on number of PASID=20
> >> bits
> >> +=C2=A0=C2=A0=C2=A0=C2=A0 * supported but the IDA allocation is inclus=
ive.
> >> +=C2=A0=C2=A0=C2=A0=C2=A0 */
> >> +=C2=A0=C2=A0=C2=A0 ret =3D ida_alloc_range(&iommu_global_pasid_ida,=20
> >> IOMMU_FIRST_GLOBAL_PASID, max - 1, GFP_KERNEL);
> >> +=C2=A0=C2=A0=C2=A0 if (ret < 0)
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return IOMMU_PASID_INVALID;
> >> +
> >> +=C2=A0=C2=A0=C2=A0 return ret;
> >> +}
> >> +EXPORT_SYMBOL_GPL(iommu_alloc_global_pasid_dev); =20
> >=20
> > "dev->iommu->max_pasids =3D=3D 0" indicates no pasid support on the dev=
ice.
> > The code should return IOMMU_PASID_INVALID explicitly. Perhaps we can
> > make this function like this:
> >=20
> > ioasid_t iommu_alloc_global_pasid_dev(struct device *dev)
> > {
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> >=20
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!dev->iommu->max_pasids)
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return IOMMU_PASID_INVALID;
> >=20
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * max_pasids is set u=
p by vendor driver based on number of=20
> > PASID bits
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * supported but the I=
DA allocation is inclusive.
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D ida_alloc_range(&io=
mmu_global_pasid_ida,=20
> > IOMMU_FIRST_GLOBAL_PASID,
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev->iommu->max_pasids - 1, GFP_KERNEL);
> >=20
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret < 0 ? IOMMU_PASI=
D_INVALID : ret;
> > }
> > EXPORT_SYMBOL_GPL(iommu_alloc_global_pasid_dev);
> >=20
> > Other change in this series looks good to me.
> >=20
> > I hope I can queue this series including above change as part of my VT-d
> > update for v6.5 to Joerg if no objection.
> >=20
> > Let's try to re-enable this key feature of Intel idxd driver in v6.5. =
=20
>=20
> This series didn't pass my test.
>=20
> The first time when I run "idxd_ktest.sh -c 1 -t 1 -i 100 -m shared", it
> passed. But when I run it again, the idxd hardware operation resulted in
> timed-out issues.
>=20
Hmm, not sure what happened. Are you using the out of tree idxd_ktest
kernel module or the dmaengine test sysfs?

e.g.
echo "Config params for DMA test"                  =20
echo $1 > /sys/module/dmatest/parameters/iterations=20
#echo 1 > /sys/module/dmatest/parameters/noverify  =20
echo "" > /sys/module/dmatest/parameters/channel   =20
echo 1 > /sys/module/dmatest/parameters/run        =20
sleep 2                                            =20
echo 0 > /sys/module/dmatest/parameters/run        =20
echo "Completed!"                                  =20

It passed my test many iterations for shared
in-kernel DSA test, will get your tree and test again.


Thanks,

Jacob
