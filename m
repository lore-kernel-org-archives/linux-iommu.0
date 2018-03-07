From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/1] iommu/arm-smmu: Add support for qcom, smmu-500 variant
Date: Wed, 7 Mar 2018 10:30:09 -0600
Message-ID: <CAL_Jsq+WWR5r-RcuE2KGpswdRgwzOV_BZjEOzHj5bAULFD6_Xg@mail.gmail.com>
References: <20180307063219.14409-1-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180307063219.14409-1-vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "moderated list:ARM SMMU DRIVERS" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Mar 7, 2018 at 12:32 AM, Vivek Gautam
<vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
> Qualcomm's arm-smmu 500 implementation supports runtime pm
> so enable the same.

That's a driver detail unrelated to the binding.

>
> Signed-off-by: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---
>
>  Based on iommu/arm-smmu pm runtime support series [1]:
>  [PATCH v8 0/5] iommu/arm-smmu: Add runtime pm/sleep support
>
>  Tested on sdm845 with necessary support to enable the smmu
>  and with necessary user.
>
>  [1] https://lkml.org/lkml/2018/3/2/325
>
>  Documentation/devicetree/bindings/iommu/arm,smmu.txt | 14 ++++++++++++++

Please split bindings to separate patches.

>  drivers/iommu/arm-smmu.c                             |  8 ++++++++
>  2 files changed, 22 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> index 6ea27bd4f785..0b5c6d2a9865 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> @@ -18,6 +18,7 @@ conditions.
>                          "arm,mmu-500"
>                          "cavium,smmu-v2"
>                          "qcom,<soc>-smmu-v2", "qcom,smmu-v2"

I don't even see this one in the tree yet...

> +                        "qcom,<soc>-smmu-500", "qcom,smmu-500"

IIRC, the mmu-500 is SMMU v2 implementation, right? Having
qcom,smmu-500 seems kind of pointless.

Given that we're there's only 1 SoC for "qcom,<soc>-smmu-v2" and
you're already on to a new genericish compatible, just do SoC specific
compatible strings.

Rob
