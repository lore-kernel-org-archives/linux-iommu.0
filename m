From: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2 01/13] iommu/rockchip: Request irqs in rk_iommu_probe()
Date: Wed, 17 Jan 2018 13:21:44 +0900
Message-ID: <CAAFQd5AO6_GYMs0xac-4ECFH9pn_ssg8jsFVoif0WDQ-daSuRA@mail.gmail.com>
References: <20180116132540.18939-1-jeffy.chen@rock-chips.com>
	<20180116132540.18939-2-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180116132540.18939-2-jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ricky Liang <jcliang-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Jeffy,

Thanks for the patch. Please see my comments inline.

On Tue, Jan 16, 2018 at 10:25 PM, Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:

Please add patch description.

> Suggested-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> Signed-off-by: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> ---
[snip]
> -       for (i = 0; i < iommu->num_irq; i++) {
> -               iommu->irq[i] = platform_get_irq(pdev, i);
> -               if (iommu->irq[i] < 0) {
> -                       dev_err(dev, "Failed to get IRQ, %d\n", iommu->irq[i]);
> +       num_irq = of_irq_count(dev->of_node);
> +       for (i = 0; i < num_irq; i++) {
> +               irq = platform_get_irq(pdev, i);

This lacks consistency. of_irq_count() is used for counting, but
platform_get_irq() is used for getting. Either platform_ or of_ API
should be used for both and I'd lean for platform_, since it's more
general.

> +               if (irq < 0) {
> +                       dev_err(dev, "Failed to get IRQ, %d\n", irq);
>                         return -ENXIO;
>                 }
> +               err = devm_request_irq(iommu->dev, irq, rk_iommu_irq,
> +                                      IRQF_SHARED, dev_name(dev), iommu);
> +               if (err)
> +                       return err;
>         }

Looks like there is some more initialization below. Is the driver okay
with the IRQ being potentially fired right here? (Shared IRQ handlers
might be run at request_irq() time for testing.)

>
>         iommu->reset_disabled = device_property_read_bool(dev,

^^

Best regards,
Tomasz
