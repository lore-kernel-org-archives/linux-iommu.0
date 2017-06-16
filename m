From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 04/04] iommu/ipmmu-vmsa: Replace local utlb code with
	fwspec ids
Date: Fri, 16 Jun 2017 19:10:09 +0900
Message-ID: <CANqRtoRCewNxhf+BbBDQ1Skp_81xQ48p6ckTgFf+jnckyD6+Cw@mail.gmail.com>
References: <149752254550.21887.15183665699230243235.sendpatchset@little-apple>
	<149752258917.21887.4347773581840409774.sendpatchset@little-apple>
	<CAMuHMdXu=0L9GOB+4DWvSTnXZEeyw551JiJ0uro9eECDx4fX-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAMuHMdXu=0L9GOB+4DWvSTnXZEeyw551JiJ0uro9eECDx4fX-Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Geert,

On Fri, Jun 16, 2017 at 4:18 PM, Geert Uytterhoeven
<geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wrote:
> Hi Magnus,
>
> On Thu, Jun 15, 2017 at 12:29 PM, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> Now when both 32-bit and 64-bit code inside the driver is using
>> fwspec it is possible to replace the utlb handling with fwspec ids
>> that get populated from ->of_xlate().
>
> Thanks for your patch!

Thanks for the feedback!

>> --- 0013/drivers/iommu/ipmmu-vmsa.c
>> +++ work/drivers/iommu/ipmmu-vmsa.c     2017-06-15 18:32:27.580607110 +0900
>
>>  static int ipmmu_of_xlate(struct device *dev,
>>                           struct of_phandle_args *spec)
>>  {
>> -       return ipmmu_init_platform_device(dev);
>> +       iommu_fwspec_add_ids(dev, spec->args, 1);
>
> Does it hurt if iommu_fwspec_add_ids() is called multiple times, as this is
> done before the "Initialize once - xlate() will call multiple times" check?

The function needs to be called several times to populate the ids, so
that the "initialize once" check happens later is intentional and
correct. Perhaps a bit unclear though...

>> +
>> +       return ipmmu_init_platform_device(dev, spec);
>>  }

Cheers,

/ magnus
