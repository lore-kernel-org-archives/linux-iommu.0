From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH 1/2] iommu: Add driver for Renesas VMSA-compatible IPMMU
Date: Fri, 28 Feb 2014 15:37:00 +0000
Message-ID: <5310AD1C.1050101@codethink.co.uk>
References: <1393601099-4413-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1393601099-4413-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1393601099-4413-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: iommu@lists.linux-foundation.org, linux-sh@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

only minor issue so far:

> diff --git a/include/linux/platform_data/ipmmu-vmsa.h b/include/linux/platform_data/ipmmu-vmsa.h
> new file mode 100644
> index 0000000..8be27e0
> --- /dev/null
> +++ b/include/linux/platform_data/ipmmu-vmsa.h
> @@ -0,0 +1,24 @@
> +/*
> + * IPMMU VMSA Platform Data
> + *
> + * Copyright (C) 2014 Reneses Electronics Coporation

typo

> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; version 2 of the License.
> + */
> +
> +#ifndef __IPMMU_VMSA_H__
> +#define __IPMMU_VMSA_H__
> +
> +struct ipmmu_vmsa_master {
> +	const char *name;
> +	unsigned int utlb;
> +};
> +
> +struct ipmmu_vmsa_platform_data {
> +	const struct ipmmu_vmsa_master *masters;
> +	unsigned int num_masters;
> +};
> +
> +#endif /* __IPMMU_VMSA_H__ */

Also, what about the of-bindings?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
