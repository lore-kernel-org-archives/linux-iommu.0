From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 09/09] iommu/ipmmu-vmsa: Hook up r8a7795 DT matching
	code
Date: Thu, 9 Mar 2017 13:20:56 +0900
Message-ID: <CANqRtoQ0uBVPxSLkDu35Hw-YcL+=0QdAw7JzWpg6p2ya5vZRoA@mail.gmail.com>
References: <148897088333.16106.13237004440297956899.sendpatchset@little-apple>
	<148897097336.16106.17118406255063350893.sendpatchset@little-apple>
	<CAMuHMdVQgdZyn0YGYCWEwnhvkxKMGG_T0vDL5ir=vC-pvLOY6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAMuHMdVQgdZyn0YGYCWEwnhvkxKMGG_T0vDL5ir=vC-pvLOY6A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Geert,

On Wed, Mar 8, 2017 at 10:58 PM, Geert Uytterhoeven
<geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wrote:
> Hi Magnus,
>
> On Wed, Mar 8, 2017 at 12:02 PM, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> From: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
>>
>> Tie in r8a7795 features and update the IOMMU_OF_DECLARE
>> compat string to include the updated compat string.
>>
>> TODO:
>>  - Consider making use of iommu_fwspec_add_ids() for uTLB handling
>>      Needed to coexist with non-OF R-Car Gen2 somehow...
>>  - Break out stuff useful for R-Car Gen2 from this series
>>      Fix up the Gen2 IPMMU support code
>>        and/or
>>      Fold more stuff into the multi-arch series
>>  - Add support for sysfs and iommu_device_link()/unlink()
>>
>> Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
>
>> --- 0018/drivers/iommu/ipmmu-vmsa.c
>> +++ work/drivers/iommu/ipmmu-vmsa.c     2017-03-08 19:11:53.600607110 +0900
>
>> @@ -1043,6 +1048,17 @@ static struct iommu_group *ipmmu_find_gr
>>         return group;
>>  }
>>
>> +static bool ipmmu_slave_whitelist(struct device *dev)
>> +{
>> +       /* By default, do not allow use of IPMMU */
>> +       return false;
>> +}
>> +
>> +static const struct soc_device_attribute soc_r8a7795[] = {
>> +       { .soc_id = "r8a7795", },
>
> If/when the whitelist is/becomes device/revision specific, you probably want
> to store a  pointer to the *_slave_whitelist() function in the .data member?

Yeah, for sure. It is a bit early to tell exactly how the code will
look like at this point, but I think it will become more clear in the
future. Just want to send out a new version of r8a7796 IPMMU support
and some r8a7795 DT integration to get a coherent working set of patch
series out of the door first.

>> +       { /* sentinel */ }
>> +};
>> +
>>  static int ipmmu_of_xlate_dma(struct device *dev,
>>                               struct of_phandle_args *spec)
>>  {
>> @@ -1053,6 +1069,18 @@ static int ipmmu_of_xlate_dma(struct dev
>>         if (!of_device_is_available(spec->np))
>>                 return -ENODEV;
>>
>> +       /* Failing in ->attach_device() results in a hang, so make
>> +        * sure the root device is installed before going there
>> +        */
>> +       if (!__ipmmu_find_root()) {
>> +               dev_info(dev, "Unable to locate IPMMU root device\n");
>
> dev_err?

Good idea. Will fix.

>> +               return -ENODEV;
>> +       }
>> +
>> +       /* For R-Car Gen3 use a white list to opt-in slave devices */
>> +       if (soc_device_match(soc_r8a7795) && !ipmmu_slave_whitelist(dev))
>> +               return -ENODEV;

This will have to be updated for r8a7796 somehow as well.

Thanks for your help!

Cheers,

/ magnus
