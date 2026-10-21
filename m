Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792563888;
	b=F13HCJs72xS+782LrOhUoJIoiH3+1ZqH1rTpC3UxFzs9FgnAuUgOx96mdTnK5x1vibbM
	 7+BLWSdpuxGoPhMCjAH1nX/qjQ/LH0uDOAmg4x97ETl02xR0ThC7BGvCg1Kk9XEo6Sq5P
	 lf2pDpK8+Tij4OEGY3ZwI+/EsEV7NeWAvC4fnZYYU1pBNGBAHfIfrvhsnVao16kcvcT1c
	 jBSGfb8m+lnQpUbYi9WRcjoajbN4Cn1K8Tt8m5xXjS1JCNz4cABZ9F3KJviYZlCy+C76H
	 GMT7dDYz4eGnP9QynnnDMS7mi7uoxLEkM5uyBRVheUePy6CChWiAFKgjRpCWTD3KXfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792563888;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Organization:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=E+IRa9wNJWXrSGrbvCRMFg+wbUn2D0oUuc66h4jh7sU=;
	b=r+G+z/GCHwoIsLmV6OEFGwTCkymH/ZxrgcBQbJ5HRVCKT6+VMWYqOjACAyosKfO3eo2f
	 N/WkbfsBkorsGsMp27koVeso/aUpBCTkgBVxfdjrKZ779URedJuxdur9oSaysi5zzZ8WN
	 x7BM5Iy2yXmVjpI1yoyjVotTubD/NmnO5K6yO28OZJ1p+VTeazUbKLQN89wPjXR8/OPkv
	 i+1B/ydAGzVuuNmknrnRK55xaXHillIrBJiTH9pIuvFumhZIYYJT5SduXjGNrdcN6nAMF
	 HUcvGnxwLHMeeHWgTWsYCrWGel+r12COfOBEcxOASlCEXJZsrtecMu40E0su8cQB8Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mIsSzgpv;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43663606A31B
	for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 06:24:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43663606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mIsSzgpv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792563888; x=1824099888;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=eH8ym7L9MqMKfNwF1lkBsHx5+/zoqru2l/kfm0X4fes=;
  b=mIsSzgpv9xygcYoe7ZUKc57bjkk68pp2n6yNa633ax6UJUhQAO+n+Q6o
   4EjYqetNABu0GMysB+pJOfzUt6d/eh53/Warod6Ta6M9xGEHsWSB+YtT8
   XyH2Q6CCjscmaZYe0+gLbCDznTxSMqO1vuwcXS0aOci/XkMrfoUK4vOkf
   +kXmaQr7+HXWTenH/h5rlrJ/lPTM3cpcZ8SuqHq2Z4S+Aukwqg2AFQRgI
   WbmQNvyEUGd+5qAFfq8r0ujQod4wexVswwlFLZlWI19gkI4zPyT5fUFv2
   PAqZDOv1mipw5gRiObuP5L6DBIea8JLFdgN1Y5OniJdIJciPVnxRWPUqy
   Q==;
X-CSE-ConnectionGUID: JrL2jq8FTTOPiY9USMnGxg==
X-CSE-MsgGUID: BoWZnTLLRdmo5pop7pM1cA==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1291271"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1291271"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 23:24:48 -0700
X-CSE-ConnectionGUID: 4e9gZWBUTIOG24qx8dQa3w==
X-CSE-MsgGUID: dV6fqYLYTz+FJNF0OM9DZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="3109569"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO [10.245.245.16]) ([10.245.245.16])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 23:24:44 -0700
Message-ID: <b5d1bc79fae01fd9b511e06ed796130314ff841b.camel@linux.intel.com>
Subject: Re: [PATCH RFC 01/26] dma-buf: Introduce DMA-buf mapping types
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Alistair Popple <apopple@nvidia.com>
Cc: Christian Koenig <christian.koenig@amd.com>, Dongwon Kim	
 <dongwon.kim@intel.com>, dri-devel@lists.freedesktop.org, 
	intel-xe@lists.freedesktop.org, iommu@lists.linux.dev, Kevin Tian	
 <kevin.tian@intel.com>, Leon Romanovsky <leonro@nvidia.com>, 
	linaro-mm-sig@lists.linaro.org, linux-media@vger.kernel.org, Matthew Brost	
 <matthew.brost@intel.com>, Simona Vetter <simona.vetter@ffwll.ch>, Sumit
 Semwal	 <sumit.semwal@linaro.org>, Vivek Kasireddy
 <vivek.kasireddy@intel.com>
Date: Wed, 21 Oct 2026 08:24:40 +0200
In-Reply-To: <1-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com>
References: <1-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43) 
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

On Tue, 2026-02-17 at 20:11 -0400, Jason Gunthorpe wrote:
> DMA-buf mapping types allow the importer and exporter to negotiate
> the
> format of the map/unmap to be used during the attachment.
>=20
> Currently DMA-buf only supports struct scatterlist as the attachment
> map
> operation.=C2=A0 This is not sufficient for all use cases as dma_addr_t i=
s
> a
> very specific and limited type.
>=20
> With mapping types the importing driver can declare what it supports.
> For
> example:
>=20
> 	struct dma_buf_mapping_match imp_match[] =3D {
> 		DMA_BUF_IMAPPING_MY_DRIVER(dev, ...),
> 		DMA_BUF_IMAPPING_SGT(dev, false),
> 	};
> 	attach =3D dma_buf_mapping_attach(dmabuf, imp_match, ...)
>=20
> And the exporting driver can declare what it supports:
>=20
> int exporter_match_mapping(struct dma_buf_match_args *args)
> {
> 	struct dma_buf_mapping_match exp_match[] =3D {
> 		DMA_BUF_EMAPPING_MY_DRIVER(my_ops, dev, ...),
> 		DMA_BUF_EMAPPING_SGT(sgt_ops, dev, false),
> 		DMA_BUF_EMAPPING_PAL(PAL_ops),
> 	};
> 	return dma_buf_match_mapping(args, exp_match, ...);
> }
>=20
> During dma_buf_mapping_attach() the core code will select a mutual
> match
> between the importer and exporter and record it in the attach-
> >map_type.
>=20
> Add the basic types:
>=20
> struct dma_buf_mapping_type
> =C2=A0=C2=A0 Type tag and ops for each mapping type.
>=20
> struct dma_buf_mapping_match
> =C2=A0=C2=A0 Entry in a list of importer or exporter match specifications=
.
> =C2=A0=C2=A0 The match specification can be extended by the mapping type =
with
> =C2=A0=C2=A0 unique data.
>=20
> dma_buf_match_mapping() / struct dma_buf_match_args
> =C2=A0=C2=A0 Helper to do the matching. Called by the exporting driver
> =C2=A0=C2=A0 via a dma_buf_ops callback.
>=20
> struct dma_buf_mapping_exp_ops
> =C2=A0=C2=A0 Base type for the per-mapping type exporter provided functio=
ns.
> This
> =C2=A0=C2=A0 would be the map/unmap callbacks. Each mapping type can prov=
ide
> its own
> =C2=A0=C2=A0 functions for map/unmap type operations with optimal type
> signatures.

Does it make sense to try to land this patch first, plus a conversion
of pcie_p2p so we could agree on what the contract should look like?

s/mapping/interconnect/? My gut feeling is that "interconnect" best
describes what's typically going on, but "mapping" perhaps better
describes all cases.

Location of common protocols which typically carry cross-subsystem
dependencies?
drivers/dma-buf/mapping_types? drivers/dma-buf/interconnects?

As discussed previously:=20
Agree on theoretically possible matches at attach time, Match at
mapping time and guarantee the match is valid until
invalidate_mappings().


>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
> =C2=A0drivers/dma-buf/dma-buf-mapping.c | 46 +++++++++++++++++++
> =C2=A0include/linux/dma-buf-mapping.h=C2=A0=C2=A0 | 76
> +++++++++++++++++++++++++++++++
> =C2=A0include/linux/dma-buf.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 18 ++++++++
> =C2=A03 files changed, 140 insertions(+)
>=20
> diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-
> buf-mapping.c
> index b7352e609fbdfa..459c204cabb803 100644
> --- a/drivers/dma-buf/dma-buf-mapping.c
> +++ b/drivers/dma-buf/dma-buf-mapping.c
> @@ -5,6 +5,7 @@
> =C2=A0 */
> =C2=A0#include <linux/dma-buf-mapping.h>
> =C2=A0#include <linux/dma-resv.h>
> +#include <linux/dma-buf.h>
> =C2=A0
> =C2=A0static struct scatterlist *fill_sg_entry(struct scatterlist *sgl,
> size_t length,
> =C2=A0					 dma_addr_t addr)
> @@ -246,3 +247,48 @@ void dma_buf_free_sgt(struct dma_buf_attachment
> *attach, struct sg_table *sgt,
> =C2=A0
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_NS_GPL(dma_buf_free_sgt, "DMA_BUF");
> +
> +/**
> + * dma_buf_match_mapping - Select a mapping type agreed upon by
> exporter and
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 importer
> + * @args: Match arguments from attach. On success this is updated
> with the
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 matched exporter and import=
er entries.
> + * @exp: Array of mapping types supported by the exporter, in
> priority order
> + * @exp_len: Number of entries in @exp
> + *
> + * Iterate over the exporter's supported mapping types and for each
> one search
> + * the importer's list for a compatible matching type. args and
> args->attach are
> + * populated with the resulting match.
> + *
> + * Because the exporter list is walked in order, the exporter
> controls the
> + * priority of mapping types.
> + */
> +int dma_buf_match_mapping(struct dma_buf_match_args *args,
> +			=C2=A0 const struct dma_buf_mapping_match *exp,
> +			=C2=A0 size_t exp_len)
> +{
> +	const struct dma_buf_mapping_match *exp_end =3D exp + exp_len;
> +	const struct dma_buf_mapping_match *imp_end =3D
> +		args->imp_matches + args->imp_len;
> +	int ret;
> +
> +	for (; exp !=3D exp_end; exp++) {
> +		const struct dma_buf_mapping_match *imp =3D args-
> >imp_matches;
> +
> +		for (; imp !=3D imp_end; imp++) {
> +			if (exp->type !=3D imp->type)
> +				continue;
> +			if (exp->type->match) {
> +				ret =3D exp->type->match(args->dmabuf,
> exp, imp);
> +				if (ret =3D=3D -EOPNOTSUPP)
> +					continue;
> +				if (ret !=3D 0)
> +					return ret;
> +			}
> +			exp->type->finish_match(args, exp, imp);
> +			return 0;
> +		}
> +	}
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL_NS_GPL(dma_buf_match_mapping, "DMA_BUF");
> diff --git a/include/linux/dma-buf-mapping.h b/include/linux/dma-buf-
> mapping.h
> index a3c0ce2d3a42fe..080ccbf3a3f8b8 100644
> --- a/include/linux/dma-buf-mapping.h
> +++ b/include/linux/dma-buf-mapping.h
> @@ -7,6 +7,77 @@
> =C2=A0#define __DMA_BUF_MAPPING_H__
> =C2=A0#include <linux/dma-buf.h>
> =C2=A0
> +struct device;
> +struct dma_buf;
> +struct dma_buf_attachment;
> +struct dma_buf_mapping_exp_ops;
> +
> +/* Type tag for all mapping operations */
> +struct dma_buf_mapping_exp_ops {};
> +
> +/*
> + * Internal struct to pass arguments from the attach function to the
> matching
> + * function
> + */
> +struct dma_buf_match_args {
> +	struct dma_buf *dmabuf;
> +	struct dma_buf_attachment *attach;
> +	const struct dma_buf_mapping_match *imp_matches;
> +	size_t imp_len;
> +};
> +
> +/**
> + * struct dma_buf_mapping_type - Operations for a DMA-buf mapping
> type
> + *
> + * Each mapping type provides a singleton instance of this struct to
> describe
> + * the mapping type and its operations.
> + */
> +struct dma_buf_mapping_type {
> +	/**
> +	 * @name: Human-readable name for this mapping type, used in
> debugfs
> +	 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 output
> +	 */
> +	const char *name;
> +
> +	/**
> +	 * @match:
> +	 *
> +	 * Called during attach from dma_buf_match_mapping(). &exp
> and &imp are
> +	 * single items from the importer and exporter mapping match
> lists.
> +	 * Both will have the same instance of this struct as their
> type member.
> +	 *
> +	 * It determines if the exporter/importer are compatible.
> +	 *
> +	 * Returns: 0 on success
> +	 *=C2=A0=C2=A0 -EOPNOTSUPP means ignore the failure and continue
> +	 *=C2=A0=C2=A0 Everything else aborts the search and returns the -
> errno
> +	 */
> +	int (*match)(struct dma_buf *dmabuf,
> +		=C2=A0=C2=A0=C2=A0=C2=A0 const struct dma_buf_mapping_match *exp,
> +		=C2=A0=C2=A0=C2=A0=C2=A0 const struct dma_buf_mapping_match *imp);
> +
> +	/**
> +	 * @finish_match:
> +	 *
> +	 * Called by dma_buf_match_mapping() after a successful
> match to store
> +	 * the negotiated result in @args->attach. The matched @exp
> and @imp
> +	 * entries are provided so the callback can copy type-
> specific data into
> +	 * the attachment.
> +	 */
> +	void (*finish_match)(struct dma_buf_match_args *args,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 const struct dma_buf_mapping_match
> *exp,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 const struct dma_buf_mapping_match
> *imp);
> +
> +	/**
> +	 * @debugfs_dump:
> +	 *
> +	 * Optional callback to write mapping-type-specific
> diagnostic
> +	 * information about @attach to the debugfs seq_file @s.
> +	 */
> +	void (*debugfs_dump)(struct seq_file *s,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 struct dma_buf_attachment *attach);
> +};
> +
> =C2=A0struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment
> *attach,
> =C2=A0					 struct p2pdma_provider
> *provider,
> =C2=A0					 struct dma_buf_phys_vec
> *phys_vec,
> @@ -14,4 +85,9 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct
> dma_buf_attachment *attach,
> =C2=A0					 enum dma_data_direction
> dir);
> =C2=A0void dma_buf_free_sgt(struct dma_buf_attachment *attach, struct
> sg_table *sgt,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum dma_data_direction dir);
> +
> +int dma_buf_match_mapping(struct dma_buf_match_args *args,
> +			=C2=A0 const struct dma_buf_mapping_match
> *exp_mappings,
> +			=C2=A0 size_t exp_len);
> +
> =C2=A0#endif
> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> index 0bc492090237ed..a2b01b13026810 100644
> --- a/include/linux/dma-buf.h
> +++ b/include/linux/dma-buf.h
> @@ -27,6 +27,21 @@
> =C2=A0struct device;
> =C2=A0struct dma_buf;
> =C2=A0struct dma_buf_attachment;
> +struct dma_buf_mapping_type;
> +struct dma_buf_mapping_exp_ops;
> +
> +/*
> + * Match items are generated by the importer using the
> DMA_BUF_IMAPPING_*() and
> + * the exporter using the DMA_BUF_EMAPPING_*() functions. Each
> mapping type
> + * defines its own signature with its own data to make the match and
> attachment.
> + */
> +struct dma_buf_mapping_match {
> +	const struct dma_buf_mapping_type *type;
> +	const struct dma_buf_mapping_exp_ops *exp_ops;
> +	union {
> +		/* Each mapping_type has unique match parameters
> here */
> +	};

Do we really need to add all global mapping types here? Then we'd need
something for driver-private mapping types as well.

What about just defining a=20

struct dma_buf_mapping_priv {
};

And let the mapping type subclass from it, and add a pointer to such a
structure?

Thanks,
Thomas

