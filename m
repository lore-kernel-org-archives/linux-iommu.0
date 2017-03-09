From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 01/09] iommu/ipmmu-vmsa: Introduce features,
	break out alias
Date: Thu, 9 Mar 2017 13:01:59 +0900
Message-ID: <CANqRtoR6VVJGuYZaQVqpE+=83Sjyp5=8BKKr3tDcVc_gS0dYxw@mail.gmail.com>
References: <148897088333.16106.13237004440297956899.sendpatchset@little-apple>
	<148897089355.16106.305846051553789544.sendpatchset@little-apple>
	<fe78313c-5cb8-d6d3-428e-deff2851d938@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <fe78313c-5cb8-d6d3-428e-deff2851d938-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On Wed, Mar 8, 2017 at 8:53 PM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
> Hi Magnus,
>
> On 08/03/17 11:01, Magnus Damm wrote:
>> From: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
>>
>> Introduce struct ipmmu_features to track various hardware
>> and software implementation changes inside the driver for
>> different kinds of IPMMU hardware. Add use_ns_alias_offset
>> as a first example of a feature to control if the secure
>> register bank offset should be used or not.
>>
>> Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
>> ---
>>
>>  Changes since V2:
>>  - None
>>
>>  Changes since V1:
>>  - Moved patch to front of the series
>>
>>  drivers/iommu/ipmmu-vmsa.c |   35 ++++++++++++++++++++++++++++-------
>>  1 file changed, 28 insertions(+), 7 deletions(-)
>>
>> --- 0007/drivers/iommu/ipmmu-vmsa.c
>> +++ work/drivers/iommu/ipmmu-vmsa.c   2017-03-07 12:25:47.000000000 +0900
>> @@ -32,11 +32,15 @@
>>
>>  #define IPMMU_CTX_MAX 1
>>
>> +struct ipmmu_features {
>> +     bool use_ns_alias_offset;
>> +};
>> +
>>  struct ipmmu_vmsa_device {
>>       struct device *dev;
>>       void __iomem *base;
>>       struct list_head list;
>> -
>> +     const struct ipmmu_features *features;
>>       unsigned int num_utlbs;
>>       spinlock_t lock;                        /* Protects ctx and domains[] */
>>       DECLARE_BITMAP(ctx, IPMMU_CTX_MAX);
>> @@ -999,13 +1003,33 @@ static void ipmmu_device_reset(struct ip
>>               ipmmu_write(mmu, i * IM_CTX_SIZE + IMCTR, 0);
>>  }
>>
>> +static const struct ipmmu_features ipmmu_features_default = {
>> +     .use_ns_alias_offset = true,
>> +};
>> +
>> +static const struct of_device_id ipmmu_of_ids[] = {
>> +     {
>> +             .compatible = "renesas,ipmmu-vmsa",
>> +             .data = &ipmmu_features_default,
>> +     }, {
>> +             /* Terminator */
>> +     },
>> +};
>> +
>> +MODULE_DEVICE_TABLE(of, ipmmu_of_ids);
>> +
>>  static int ipmmu_probe(struct platform_device *pdev)
>>  {
>>       struct ipmmu_vmsa_device *mmu;
>> +     const struct of_device_id *match;
>>       struct resource *res;
>>       int irq;
>>       int ret;
>>
>> +     match = of_match_node(ipmmu_of_ids, pdev->dev.of_node);
>
> of_device_get_match_data() makes this a lot easier.
>
>> +     if (!match)
>> +             return -EINVAL;
>
> Also, if the driver is DT-only per the other series, note that this
> cannot happen anyway, since of_driver_match_device() would have to have
> found a match for your probe function to be called in the first place.

Yeah, you are right. As you know, in the IPMMU driver (with the
r8a7795 V3 series applied) the init handling is a bit special with
ARM32 and ARM64 being treated differently. I would like to clean it up
and share a common implementation.

Until that happens, how do you think we should handle the (!match)
case? BUG_ON()?

Cheers,

/ magnus
