Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94918259B
	for <iommu@lists.linux.dev>; Sun,  4 Dec 2022 10:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670151542; x=1701687542;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2FvkjXhvsE24dnPr4S1RPCbyCxxrCseUazftBUtT+x8=;
  b=Biw0mps5EHq/jSeC6jeIfsPbsKwCeScQ+f2e3APDr0CNDypgRc2405aO
   twKFvx2vIel5zPHSkqV/NwOZqSD0skcTpnjB3Cb2VtUkzRYX1O4StDYBd
   4fTgDPOnUslYG+HeTxjhkfei8UMahgLczlS62qUlLCNOnM+YW402JvRj+
   ThYYeiB517aqyJ0nH5dKjUbWn38fMW85QlmqGL19l4ybelGLbl0vpr/LH
   mN/zAJ89GM/1CyLZ2ZZgyOKunAeuf1+MIE1un4Wk64FLezlorsX/JKqva
   I/+BmE9tgTlZUMRmQK9HUM9UHohu4uQAwwwVZolcLrePemSs53/s+Tdz2
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10550"; a="296542090"
X-IronPort-AV: E=Sophos;i="5.96,217,1665471600"; 
   d="scan'208";a="296542090"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2022 02:59:01 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10550"; a="819888958"
X-IronPort-AV: E=Sophos;i="5.96,217,1665471600"; 
   d="scan'208";a="819888958"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.249.172.62]) ([10.249.172.62])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2022 02:58:54 -0800
Message-ID: <6a557dd1-b19e-e78a-58f0-544ce134ca31@linux.intel.com>
Date: Sun, 4 Dec 2022 18:58:52 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v6 06/19] iommufd: File descriptor, context, kconfig and
 makefiles
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Anthony Krowiak <akrowiak@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, Cornelia Huck
 <cohuck@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Daniel Jordan <daniel.m.jordan@oracle.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eric Auger <eric.auger@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 iommu@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Jason Herne <jjherne@linux.ibm.com>, Joao Martins
 <joao.m.martins@oracle.com>, Kevin Tian <kevin.tian@intel.com>,
 kvm@vger.kernel.org, Lixiao Yang <lixiao.yang@intel.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Halil Pasic <pasic@linux.ibm.com>, Niklas Schnelle <schnelle@linux.ibm.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Yi Liu <yi.l.liu@intel.com>, Yu He <yu.he@intel.com>,
 Keqian Zhu <zhukeqian1@huawei.com>
References: <6-v6-a196d26f289e+11787-iommufd_jgg@nvidia.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <6-v6-a196d26f289e+11787-iommufd_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/30/2022 4:29 AM, Jason Gunthorpe wrote:
> diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
> new file mode 100644
> index 00000000000000..d1817472c27373
> --- /dev/null
> +++ b/include/linux/iommufd.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2021 Intel Corporation
> + * Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
> + */
> +#ifndef __LINUX_IOMMUFD_H
> +#define __LINUX_IOMMUFD_H
> +
> +#include <linux/types.h>
> +#include <linux/errno.h>
> +#include <linux/err.h>
> +
> +struct iommufd_ctx;
> +struct file;
> +
> +void iommufd_ctx_get(struct iommufd_ctx *ictx);
> +
> +#if IS_ENABLED(CONFIG_IOMMUFD)
> +struct iommufd_ctx *iommufd_ctx_from_file(struct file *file);
> +void iommufd_ctx_put(struct iommufd_ctx *ictx);
> +#else /* !CONFIG_IOMMUFD */
> +static inline struct iommufd_ctx *iommufd_ctx_from_file(struct file *file)
> +{
> +	return ERR_PTR(-EOPNOTSUPP);
> +}
> +
> +static inline void iommufd_ctx_put(struct iommufd_ctx *ictx)
> +{
> +}

Although iommufd_ctx_get is not callded when !CONFIG_IOMMUFD, but from 
the view of code iommufd_ctx_get and iommufd_ctx_put are not symmetric 
when !CONFIG_IOMMUFD.
I am not sure if it is a common style in kernel code.


> +#endif /* CONFIG_IOMMUFD */
> +#endif
>
