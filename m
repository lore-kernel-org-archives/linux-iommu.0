Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DADBC433EF
	for <iommu@archiver.kernel.org>; Wed,  6 Apr 2022 15:54:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4AC5A60ED7;
	Wed,  6 Apr 2022 15:54:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H1ith8CbG-Fu; Wed,  6 Apr 2022 15:54:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 16C3260ED2;
	Wed,  6 Apr 2022 15:54:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0D62C001D;
	Wed,  6 Apr 2022 15:54:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B495C0012
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 15:54:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3A3C540517
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 15:54:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UhagG7d4-uUY for <iommu@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 15:54:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6EFAF40141
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 15:54:12 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E47F712FC;
 Wed,  6 Apr 2022 08:54:11 -0700 (PDT)
Received: from lpieralisi (unknown [10.57.21.160])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C11083F73B;
 Wed,  6 Apr 2022 08:54:09 -0700 (PDT)
Date: Wed, 6 Apr 2022 16:54:10 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v9 04/11] ACPI/IORT: Provide a generic helper to retrieve
 reserve regions
Message-ID: <20220406155410.GE27518@lpieralisi>
References: <20220404124209.1086-1-shameerali.kolothum.thodi@huawei.com>
 <20220404124209.1086-5-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220404124209.1086-5-shameerali.kolothum.thodi@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: will@kernel.org, jon@solid-run.com, linuxarm@huawei.com,
 steven.price@arm.com, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, wanghuiqiang@huawei.com,
 guohanjun@huawei.com, yangyicong@huawei.com, Sami.Mujawar@arm.com,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, Apr 04, 2022 at 01:42:02PM +0100, Shameer Kolothum wrote:
> Currently IORT provides a helper to retrieve HW MSI reserve regions.
> Change this to a generic helper to retrieve=A0any IORT related reserve
> regions. This will be useful when we=A0add support for RMR nodes in
> subsequent patches.
> =

> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/acpi/arm64/iort.c | 23 +++++++++++++++--------
>  drivers/iommu/dma-iommu.c |  2 +-
>  include/linux/acpi_iort.h |  4 ++--
>  3 files changed, 18 insertions(+), 11 deletions(-)

Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> # for ACPI
IORT

> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index c5ebb2be9a19..63acc3c5b275 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -830,16 +830,13 @@ static struct acpi_iort_node *iort_get_msi_resv_iom=
mu(struct device *dev)
>  	return NULL;
>  }
>  =

> -/**
> - * iort_iommu_msi_get_resv_regions - Reserved region driver helper
> - *                                   for HW MSI regions.
> - * @dev: Device from iommu_get_resv_regions()
> - * @head: Reserved region list from iommu_get_resv_regions()
> - *
> +/*
> + * Retrieve platform specific HW MSI reserve regions.
>   * The ITS interrupt translation spaces (ITS_base + SZ_64K, SZ_64K)
>   * associated with the device are the HW MSI reserved regions.
>   */
> -void iort_iommu_msi_get_resv_regions(struct device *dev, struct list_hea=
d *head)
> +static void
> +iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *he=
ad)
>  {
>  	struct iommu_fwspec *fwspec =3D dev_iommu_fwspec_get(dev);
>  	struct acpi_iort_its_group *its;
> @@ -888,6 +885,16 @@ void iort_iommu_msi_get_resv_regions(struct device *=
dev, struct list_head *head)
>  	}
>  }
>  =

> +/**
> + * iort_iommu_get_resv_regions - Generic helper to retrieve reserved reg=
ions.
> + * @dev: Device from iommu_get_resv_regions()
> + * @head: Reserved region list from iommu_get_resv_regions()
> + */
> +void iort_iommu_get_resv_regions(struct device *dev, struct list_head *h=
ead)
> +{
> +	iort_iommu_msi_get_resv_regions(dev, head);
> +}
> +
>  static inline bool iort_iommu_driver_enabled(u8 type)
>  {
>  	switch (type) {
> @@ -1052,7 +1059,7 @@ int iort_iommu_configure_id(struct device *dev, con=
st u32 *id_in)
>  }
>  =

>  #else
> -void iort_iommu_msi_get_resv_regions(struct device *dev, struct list_hea=
d *head)
> +void iort_iommu_get_resv_regions(struct device *dev, struct list_head *h=
ead)
>  { }
>  int iort_iommu_configure_id(struct device *dev, const u32 *input_id)
>  { return -ENODEV; }
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 09f6e1c0f9c0..93d76b666888 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -384,7 +384,7 @@ void iommu_dma_get_resv_regions(struct device *dev, s=
truct list_head *list)
>  {
>  =

>  	if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode))
> -		iort_iommu_msi_get_resv_regions(dev, list);
> +		iort_iommu_get_resv_regions(dev, list);
>  =

>  }
>  EXPORT_SYMBOL(iommu_dma_get_resv_regions);
> diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
> index a8198b83753d..e5d2de9caf7f 100644
> --- a/include/linux/acpi_iort.h
> +++ b/include/linux/acpi_iort.h
> @@ -36,7 +36,7 @@ int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_i=
d);
>  /* IOMMU interface */
>  int iort_dma_get_ranges(struct device *dev, u64 *size);
>  int iort_iommu_configure_id(struct device *dev, const u32 *id_in);
> -void iort_iommu_msi_get_resv_regions(struct device *dev, struct list_hea=
d *head);
> +void iort_iommu_get_resv_regions(struct device *dev, struct list_head *h=
ead);
>  phys_addr_t acpi_iort_dma_get_max_cpu_address(void);
>  #else
>  static inline void acpi_iort_init(void) { }
> @@ -52,7 +52,7 @@ static inline int iort_dma_get_ranges(struct device *de=
v, u64 *size)
>  static inline int iort_iommu_configure_id(struct device *dev, const u32 =
*id_in)
>  { return -ENODEV; }
>  static inline
> -void iort_iommu_msi_get_resv_regions(struct device *dev, struct list_hea=
d *head)
> +void iort_iommu_get_resv_regions(struct device *dev, struct list_head *h=
ead)
>  { }
>  =

>  static inline phys_addr_t acpi_iort_dma_get_max_cpu_address(void)
> -- =

> 2.25.1
> =

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
