Return-Path: <SRS0=IFPa=LQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B254C48BC2
	for <iommu@archiver.kernel.org>; Tue, 22 Jun 2021 02:56:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B63D610EA
	for <iommu@archiver.kernel.org>; Tue, 22 Jun 2021 02:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B63D610EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C96574025D;
	Tue, 22 Jun 2021 02:56:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qXZ4uJ0ts0rA; Tue, 22 Jun 2021 02:56:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9213D4016D;
	Tue, 22 Jun 2021 02:56:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72483C0010;
	Tue, 22 Jun 2021 02:56:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13687C000E
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 02:56:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 08CCD4017C
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 02:56:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OS2BhRBr_K2f for <iommu@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 02:56:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1387F4016D
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 02:56:31 +0000 (UTC)
Received: by mail-qk1-x734.google.com with SMTP id q190so33164575qkd.2
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 19:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=o7WniBxc7u8I3jtLWFb2QyQubQrJgur3uSaTIY2hHpY=;
 b=IlhIu8fFZb/00DISAJcThl4zsHWxZQu1Oa/M3ahKUhWaxlkRjELVIGBWjVa/lOqm5w
 R8ijcCQtXUjJKTXjsyL8XC9IeSNYcoE/hXhy0707xoE6Bp7mwCrtqvMSIwg7XRSkNIE+
 41oC8qsSXK/w+ICTlHHEk6csKeMmNkBnGKqC4mrBOzIjGGVZUX6Nspzkfc0P0dg2TAX0
 qGjTjgj9xBimf62Siz9ycYnskVpQcN4f68bXYa47M7lrcmqv9sUfStAIPZ+oYS0gQPSS
 axREBBohkOyHxdZVxh0tmhTQ6DCvRJCFxRlsELoVQjr6rZofiDiCLzoIC+fkMke5eZXb
 KOyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=o7WniBxc7u8I3jtLWFb2QyQubQrJgur3uSaTIY2hHpY=;
 b=UXRgoh2CsSj6Kce4+7lze+d91tS8PUen53/c3zUDtPYsyCo42C9bLnHO3UXkLNP6Xc
 Q0W6hO93exU/n/x69vnLes1E2uMsrzwAKTm3H9q2EOwXtBkYiIhB/dFs9NdlxJxqS80B
 H9swM1IIzJ35FZrR5BBRsDEOXzLzmNbxPnIz5I5NdBpBoiNmggxn9OvdyVGIi3cDe0E7
 mzDrVNvoJSlFcrNpytrW5VR7Yd9UWFN01xjjQHYGdShg2iQvxAv86R/qwI9PHkA8KMSA
 DXpN0THze8poki6VyEQ5qghwt7D+6cfxuf6O0fukA/wMCC1zo1harQn7llLdtReSSZdz
 doNw==
X-Gm-Message-State: AOAM531NkJtotttW9rHVPQ4XEvjd1eHVTzB4Cc08v7g6Ys7TTkkMy7ol
 BVplF9bVLs9iNNpcjmuwY8vWkILeSyAK8mzqq2r02w==
X-Google-Smtp-Source: ABdhPJyQjeT6WzR5lehTnPxseq2wdji+PgNfDU28Fwy5MqjJ3yxJk8R8kSGnjCwg/Kmk7+Pz3hc0ucfFrwGQ91Xpnkk=
X-Received: by 2002:a25:bcb:: with SMTP id 194mr1812975ybl.32.1624330590627;
 Mon, 21 Jun 2021 19:56:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210621235248.2521620-1-dianders@chromium.org>
 <20210621165230.4.Id84a954e705fcad3fdb35beb2bc372e4bf2108c7@changeid>
In-Reply-To: <20210621165230.4.Id84a954e705fcad3fdb35beb2bc372e4bf2108c7@changeid>
Date: Mon, 21 Jun 2021 19:55:52 -0700
Message-ID: <CAGETcx-dZ_Wwjafk+5akWJwbrFx2rYNKZAU8tWhFUunEyn8sqQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] iommu: Combine device strictness requests with the
 global default
To: Douglas Anderson <dianders@chromium.org>
Cc: ulf.hansson@linaro.org, rafael@kernel.org, linux-pci@vger.kernel.org,
 joel@joelfernandes.org, rajatja@google.com, will@kernel.org,
 robdclark@chromium.org, rafael.j.wysocki@intel.com, quic_c_gdjako@quicinc.com,
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
From: Saravana Kannan via iommu <iommu@lists.linux-foundation.org>
Reply-To: Saravana Kannan <saravanak@google.com>
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

If iommu.strict is not set in the command line, upstream treats it as
iommu.strict=1. Meaning, no drivers can override it.

If I understand it correctly, with your series, if iommu.strict=1 is
not set, drivers can override the "default strict mode" and ask for
non-strict mode for their domain. So if this series gets in and future
driver changes start asking for non-strict mode, systems that are
expected to operate in fully strict mode will now have devices
operating in non-strict mode.

That's breaking backward compatibility for the kernel command line
param. It looks like what you really need is to change iommu.strict
from 0/1 to lazy (previously 0), strict preferred, strict enforced
(previously 1) and you need to default it to "enforced".

Alternately (and potentially a better option?), you really should be
changing/extending dev_is_untrusted() so that it applies for any
struct device (not just PCI device) and then have this overridden in
DT (or ACPI or any firmware) to indicate a specific device is safe to
use non-strict mode on. What you are trying to capture (if the device
safe enough) really isn't a function of the DMA device's driver, but a
function of the DMA device.



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
