From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 1/2] iommu/io-pgtable: Add MTK 4GB mode in Short-descriptor
Date: Fri, 11 Mar 2016 14:45:46 +0000
Message-ID: <56E2DA1A.9010902@arm.com>
References: <1456268552-16635-1-git-send-email-yong.wu@mediatek.com>
	<1456268552-16635-2-git-send-email-yong.wu@mediatek.com>
	<56D6DD2E.4030207@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <56D6DD2E.4030207-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, milton.chiang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, youhua.li-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 02/03/16 12:31, Robin Murphy wrote:
> Hi Yong,
>
> On 23/02/16 23:02, Yong Wu wrote:
>> Mediatek extend bit9 in the lvl1 and lvl2 pgtable descriptor of the
>> Short-descriptor as the 4GB mode in which the dram size will be
>> over 4GB.
>>
>> We add a special quirk for this MTK-4GB mode, And in the standard
>> spec, Bit9 in the lvl1 is "IMPLEMENTATION DEFINED", while it's AP[2]
>> in the lvl2, therefore if this quirk is enabled, NO_PERMS is also
>> expected.
>
> Would you be able to explain exactly what this "4GB mode" actually is?
> I've been trying to make sense of it from the original M4U patches and
> the patch for the I2C driver, but it has me completely baffled.

Many thanks to Joe for the explanation!

[...]
>> diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
>> index d4f5027..a84a60a 100644
>> --- a/drivers/iommu/io-pgtable.h
>> +++ b/drivers/iommu/io-pgtable.h
>> @@ -60,10 +60,16 @@ struct io_pgtable_cfg {
>>        * IO_PGTABLE_QUIRK_TLBI_ON_MAP: If the format forbids caching
>> invalid
>>        *    (unmapped) entries but the hardware might do so anyway,
>> perform
>>        *    TLB maintenance when mapping as well as when unmapping.
>> +     *
>> +     * IO_PGTABLE_QUIRK_MTK_4GB_EXT: Mediatek extend bit9 in the lvl1
>> and
>> +     *    lvl2 descriptor of the Short-descriptor as the 4GB mode.
>> +     *    Note that: Bit9 in the lvl1 is "IMPLEMENTATION DEFINED", while
>> +     *    it is AP[2] in the lvl2.
>
> Unfortunately that comment doesn't really explain anything - I'd be
> happy to suggest a more helpful wording, If only I understood what it
> actually did.

OK, now that I think I've got it, how about this?

    IO_PGTABLE_QUIRK_ARM_MTK_4GB: (ARM v7s format) Set bit 9 in all
	PTEs, for Mediatek IOMMUs which treat it as a 33rd address bit
	when the SoC is in "4GB mode" and they can only access the high
	remap of DRAM (0x1_00000000 to 0x1_ffffffff).

Robin.
