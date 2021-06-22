Return-Path: <SRS0=IFPa=LQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6D6C2B9F4
	for <iommu@archiver.kernel.org>; Tue, 22 Jun 2021 18:45:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11F1D61289
	for <iommu@archiver.kernel.org>; Tue, 22 Jun 2021 18:45:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11F1D61289
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CFE5D605A1;
	Tue, 22 Jun 2021 18:45:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ACkdt-QQYr-5; Tue, 22 Jun 2021 18:45:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9234160658;
	Tue, 22 Jun 2021 18:45:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3E9A5C001A;
	Tue, 22 Jun 2021 18:45:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 740C2C000E
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 18:45:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5E0E340283
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 18:45:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S__t1c807z0L for <iommu@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 18:45:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D41FA40234
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 18:45:46 +0000 (UTC)
Received: by mail-lf1-x129.google.com with SMTP id j4so193502lfc.8
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 11:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UmuRYxjET5EALM+FCT07y3AoMfWe7cxAE7p3HDo8x9A=;
 b=VzmzR6LCQB9s+J6u+Ao3+LmOdty+YPR7YmBp3X2hI8TbwEEk/ar3YTRCx9B/LT66Pf
 jBxcuU7PBhl/9joavTTcEIv0KIjyX8MgzBrWkO9OfbjTAjtVXBoq/WACzgfo8D7VRNVU
 GJpB+HdujoRkwmeLlmN3Hika9QSoTAoUhnxau2GtMI4ec0KLiNYWSIyfepWt9b2VdCgY
 lwDvQXxHH5v24ck7fvHS4cFrGgCKG192xepc9KRUfqp6dTOPrbKIj5XeBjR0LGo1JaOQ
 hVNDP5DWzygmDKqUgUnGB5dbYAhKOH4lCEEOrJZKF6+fPmqNS0Gj7tsS5l2mYSnoaSv4
 /1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UmuRYxjET5EALM+FCT07y3AoMfWe7cxAE7p3HDo8x9A=;
 b=nveA3LzvOUovbimwZ0HsfEDfOuReGEI9RH536s5vY57eF98vUSEGXgToO6hdm0Qr8T
 5N5HHmVfW78aKxJj2U2mkTZIkFJOkM/OMrjk2Rbp/Z/PSTqe3Ztm28rWJ0q0FkQtq7B3
 Ovu/N2+JtBKjxvfKObdjxQ2tFOftNNqOCG0cwA19H8qX6wRijP0xUHOUo4jnsbgcujKU
 T/wDW5LWzfU7fpthZncOWx8NEn3gTZMQ+3oIGHRQswRc6Samhd8M/x6UKM7COTtq7wPm
 4tS9NVJFQpbA+qTThsjDNmIvC+4FzK9N8E0GP62dymmJm6wjUDZiMbbo0mgcbJfF3eci
 BDEw==
X-Gm-Message-State: AOAM531N47S0RiJ7lNbq+avUpZWwjsgbpOYWj45pgFT4b7Ak/btr9Dxd
 2yhrkOE5N2uISj5l2QTEn2L+PwBcHt78nMj45NYWQw==
X-Google-Smtp-Source: ABdhPJz3y5Lck2F4f7THKOpZIcz1XSUJ+0RoljLMYdPiKKLuwBXCT/AqNHBFGoy6ZFXZQT9TlUO8qDUNhaWEm+sp2DE=
X-Received: by 2002:a05:6512:baa:: with SMTP id
 b42mr3799463lfv.487.1624387544227; 
 Tue, 22 Jun 2021 11:45:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210621235248.2521620-1-dianders@chromium.org>
 <20210621165230.4.Id84a954e705fcad3fdb35beb2bc372e4bf2108c7@changeid>
In-Reply-To: <20210621165230.4.Id84a954e705fcad3fdb35beb2bc372e4bf2108c7@changeid>
Date: Tue, 22 Jun 2021 11:45:03 -0700
Message-ID: <CACK8Z6EVmnMx4X8ZF7QSm58KCMMAkgSa+S9YkH+mC5RfmeyYoA@mail.gmail.com>
Subject: Re: [PATCH 4/6] iommu: Combine device strictness requests with the
 global default
To: Douglas Anderson <dianders@chromium.org>
Cc: ulf.hansson@linaro.org, rafael@kernel.org, linux-pci@vger.kernel.org,
 joel@joelfernandes.org, will@kernel.org, robdclark@chromium.org,
 saravanak@google.com, rafael.j.wysocki@intel.com, quic_c_gdjako@quicinc.com,
 vbadigan@codeaurora.org, linux-arm-msm@vger.kernel.org, bhelgaas@google.com,
 adrian.hunter@intel.com, sonnyrao@chromium.org, gregkh@linuxfoundation.org,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com
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
From: Rajat Jain via iommu <iommu@lists.linux-foundation.org>
Reply-To: Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, Jun 21, 2021 at 4:53 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> In the patch ("drivers: base: Add bits to struct device to control
> iommu strictness") we add the ability for devices to tell us about
> their IOMMU strictness requirements. Let's now take that into account
> in the IOMMU layer.
>
> A few notes here:
> * Presumably this is always how iommu_get_dma_strict() was intended to
>   behave. Had this not been the intention then it never would have
>   taken a domain as a parameter.
> * The iommu_set_dma_strict() feels awfully non-symmetric now. That
>   function sets the _default_ strictness globally in the system
>   whereas iommu_get_dma_strict() returns the value for a given domain
>   (falling back to the default). Presumably, at least, the fact that
>   iommu_set_dma_strict() doesn't take a domain makes this obvious.
>
> The function iommu_get_dma_strict() should now make it super obvious
> where strictness comes from and who overides who. Though the function
> changed a bunch to make the logic clearer, the only two new rules
> should be:
> * Devices can force strictness for themselves, overriding the cmdline
>   "iommu.strict=0" or a call to iommu_set_dma_strict(false)).
> * Devices can request non-strictness for themselves, assuming there
>   was no cmdline "iommu.strict=1" or a call to
>   iommu_set_dma_strict(true).

Along the same lines, I believe a platform (device tree / ACPI) should
also be able to have a say in this. I assume in your proposal, a
platform would expose a property in device tree which the device
driver would need to parse and then use it to set these bits in the
"struct device"?

Thanks,

Rajat



>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/iommu/iommu.c | 56 +++++++++++++++++++++++++++++++++----------
>  include/linux/iommu.h |  2 ++
>  2 files changed, 45 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 808ab70d5df5..0c84a4c06110 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -28,8 +28,19 @@
>  static struct kset *iommu_group_kset;
>  static DEFINE_IDA(iommu_group_ida);
>
> +enum iommu_strictness {
> +       IOMMU_DEFAULT_STRICTNESS = -1,
> +       IOMMU_NOT_STRICT = 0,
> +       IOMMU_STRICT = 1,
> +};
> +static inline enum iommu_strictness bool_to_strictness(bool strictness)
> +{
> +       return (enum iommu_strictness)strictness;
> +}
> +
>  static unsigned int iommu_def_domain_type __read_mostly;
> -static bool iommu_dma_strict __read_mostly = true;
> +static enum iommu_strictness cmdline_dma_strict __read_mostly = IOMMU_DEFAULT_STRICTNESS;
> +static enum iommu_strictness driver_dma_strict __read_mostly = IOMMU_DEFAULT_STRICTNESS;
>  static u32 iommu_cmd_line __read_mostly;
>
>  struct iommu_group {
> @@ -69,7 +80,6 @@ static const char * const iommu_group_resv_type_string[] = {
>  };
>
>  #define IOMMU_CMD_LINE_DMA_API         BIT(0)
> -#define IOMMU_CMD_LINE_STRICT          BIT(1)
>
>  static int iommu_alloc_default_domain(struct iommu_group *group,
>                                       struct device *dev);
> @@ -336,25 +346,38 @@ early_param("iommu.passthrough", iommu_set_def_domain_type);
>
>  static int __init iommu_dma_setup(char *str)
>  {
> -       int ret = kstrtobool(str, &iommu_dma_strict);
> +       bool strict;
> +       int ret = kstrtobool(str, &strict);
>
>         if (!ret)
> -               iommu_cmd_line |= IOMMU_CMD_LINE_STRICT;
> +               cmdline_dma_strict = bool_to_strictness(strict);
>         return ret;
>  }
>  early_param("iommu.strict", iommu_dma_setup);
>
>  void iommu_set_dma_strict(bool strict)
>  {
> -       if (strict || !(iommu_cmd_line & IOMMU_CMD_LINE_STRICT))
> -               iommu_dma_strict = strict;
> +       /* A driver can request strictness but not the other way around */
> +       if (driver_dma_strict != IOMMU_STRICT)
> +               driver_dma_strict = bool_to_strictness(strict);
>  }
>
>  bool iommu_get_dma_strict(struct iommu_domain *domain)
>  {
> -       /* only allow lazy flushing for DMA domains */
> -       if (domain->type == IOMMU_DOMAIN_DMA)
> -               return iommu_dma_strict;
> +       /* Non-DMA domains or anyone forcing it to strict makes it strict */
> +       if (domain->type != IOMMU_DOMAIN_DMA ||
> +           cmdline_dma_strict == IOMMU_STRICT ||
> +           driver_dma_strict == IOMMU_STRICT ||
> +           domain->force_strict)
> +               return true;
> +
> +       /* Anyone requesting non-strict (if no forces) makes it non-strict */
> +       if (cmdline_dma_strict == IOMMU_NOT_STRICT ||
> +           driver_dma_strict == IOMMU_NOT_STRICT ||
> +           domain->request_non_strict)
> +               return false;
> +
> +       /* Nobody said anything, so it's strict by default */
>         return true;
>  }
>  EXPORT_SYMBOL_GPL(iommu_get_dma_strict);
> @@ -1519,7 +1542,8 @@ static int iommu_get_def_domain_type(struct device *dev)
>
>  static int iommu_group_alloc_default_domain(struct bus_type *bus,
>                                             struct iommu_group *group,
> -                                           unsigned int type)
> +                                           unsigned int type,
> +                                           struct device *dev)
>  {
>         struct iommu_domain *dom;
>
> @@ -1534,6 +1558,12 @@ static int iommu_group_alloc_default_domain(struct bus_type *bus,
>         if (!dom)
>                 return -ENOMEM;
>
> +       /* Save the strictness requests from the device */
> +       if (dev && type == IOMMU_DOMAIN_DMA) {
> +               dom->request_non_strict = dev->request_non_strict_iommu;
> +               dom->force_strict = dev->force_strict_iommu;
> +       }
> +
>         group->default_domain = dom;
>         if (!group->domain)
>                 group->domain = dom;
> @@ -1550,7 +1580,7 @@ static int iommu_alloc_default_domain(struct iommu_group *group,
>
>         type = iommu_get_def_domain_type(dev) ? : iommu_def_domain_type;
>
> -       return iommu_group_alloc_default_domain(dev->bus, group, type);
> +       return iommu_group_alloc_default_domain(dev->bus, group, type, dev);
>  }
>
>  /**
> @@ -1721,7 +1751,7 @@ static void probe_alloc_default_domain(struct bus_type *bus,
>         if (!gtype.type)
>                 gtype.type = iommu_def_domain_type;
>
> -       iommu_group_alloc_default_domain(bus, group, gtype.type);
> +       iommu_group_alloc_default_domain(bus, group, gtype.type, NULL);
>
>  }
>
> @@ -3130,7 +3160,7 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
>         }
>
>         /* Sets group->default_domain to the newly allocated domain */
> -       ret = iommu_group_alloc_default_domain(dev->bus, group, type);
> +       ret = iommu_group_alloc_default_domain(dev->bus, group, type, dev);
>         if (ret)
>                 goto out;
>
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 32d448050bf7..0bddef77f415 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -81,6 +81,8 @@ struct iommu_domain_geometry {
>
>  struct iommu_domain {
>         unsigned type;
> +       bool force_strict:1;
> +       bool request_non_strict:1;
>         const struct iommu_ops *ops;
>         unsigned long pgsize_bitmap;    /* Bitmap of page sizes in use */
>         iommu_fault_handler_t handler;
> --
> 2.32.0.288.g62a8d224e6-goog
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
