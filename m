From: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v6 0/7] PCI: get DMA configuration from parent device
Date: Mon, 23 Feb 2015 16:15:08 -0600
Message-ID: <CAErSpo6fWjibM-Lm54ESBpgMUi8w2q6YVzNAK5rHvR4+ydq6ZA@mail.gmail.com>
References: <1423173179-10227-1-git-send-email-m-karicheri2@ti.com>
 <20150206151542.GD23190@e104818-lin.cambridge.arm.com> <54D4DD95.7000303@ti.com>
 <CAErSpo6GOXHeKKfU8s5jCS3+Mui=HupZd=jpkLEyWAE94Ory5w@mail.gmail.com>
 <54D509C9.9010204@ti.com> <54DB8960.9010707@ti.com> <54DB8A4C.9050002@ti.com> <54EBA4D0.1060705@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54EBA4D0.1060705-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org" <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Feb 23, 2015 at 4:08 PM, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org> wrote:
> On 02/11/2015 11:58 AM, Murali Karicheri wrote:
>>
>> On 02/11/2015 11:54 AM, Murali Karicheri wrote:
>>>
>>> On 02/06/2015 01:36 PM, Murali Karicheri wrote:
>>>>
>>>> On 02/06/2015 12:53 PM, Bjorn Helgaas wrote:
>>>>>
>>>>> On Fri, Feb 6, 2015 at 9:28 AM, Murali Karicheri<m-karicheri2-l0cyMroinI0@public.gmane.org>
>>>>> wrote:
>>>>>>
>>>>>> On 02/06/2015 10:15 AM, Catalin Marinas wrote:
>>>>>>>
>>>>>>>
>>>>>>> On Thu, Feb 05, 2015 at 09:52:52PM +0000, Murali Karicheri wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> This patch add an important capability to PCI driver on Keystone. I
>>>>>>>> hope
>>>>>>>> to
>>>>>>>> have this merged to the upstream branch so that it is available for
>>>>>>>> v3.20.
>>>>>>>
>>>>>>>
>>>>>>> It's very late for 3.20 and the code hasn't been in linux-next at all
>>>>>>> (but it's not me who's merging this code), unless you can squeeze
>>>>>>> it in
>>>>>>> as a bug-fix.
>>>>>>
>>>>>>
>>>>>> This is in fact a bug fix as PCI on Keystone is broken without this.
>>>>>
>>>>>
>>>>> Oh, sorry, I didn't realize that this was so urgent. I guess I read
>>>>> "this adds an important capability" in the cover letter and concluded
>>>>> that it was new functionality.
>>>>
>>>> Bjorn,
>>>>
>>>> Thanks for responding.
>>>>
>>>> Let me give you some context on this without which my explanation won't
>>>> be complete. For using PCI driver on Keystone, I had submitted patches
>>>> related to machine and DTS to the arm mailing list to enable the driver
>>>> on Keystone. Subsequenty one of the patch from my series was Nack-ed and
>>>> I was asked to implememented in a different way and started this series.
>>>> You can refer to the discussion of this at
>>>>
>>>> http://www.gossamer-threads.com/lists/linux/kernel/2024591
>>>>
>>>> The PCI driver enablement on Keystone is still a working in progress and
>>>> I am trying to get it fully functional on the upstream. Another missing
>>>> piece is the SerDes phy driver patch. We have started working on the
>>>> other part (SerDes phy driver) already as the initial one was not
>>>> accepted. So it is fine if we are too late for the v3.20 merge window to
>>>> merge this series and this can be applied to the next branch for v3.21.
>>>>
>>>>>
>>>>> Anyway, if it's broken, presumably PCI on Keystone *did* work at one
>>>>> point. Can you identify the commit that broke it and requires these
>>>>> fixes, so we can figure out how far the fixes need to be backported?
>>>>>
>>>>
>>>> I am trying to get this driver enabled on Keystone by adding the missing
>>>> pieces as described above. So I guess we don't have to back port
>>>> anything here.
>>>>
>>>>> If I merge it, I would like to get into my for-linus branch and get a
>>>>> little time in -next before asking Linus to pull it. The merge window
>>>>> is a little wrinkle there -- I don't like to add new things to the mix
>>>>> during the window. But if it's an important fix we can still get it
>>>>> in before the final v3.20.
>>>>
>>>>
>>>> Please apply this to next branch for v3.21. It currently apply cleanly
>>>> to v3.19-rc7. If you want me rebase to another branch, let me know I can
>>>> apply and send you an updated patch.
>>>>
>>> Bjorn, Arnd,
>>>
>>> I am assuming, Bjorn is going to merge this to his next branch for
>>> v3.21. If not, it might have to be merged through the arm soc? There are
>>> a couple of Tested-by and Acked-by received after v7. Do you want me to
>>> post v8 with these updated in the patches?
>>
>> FYI.
>>
>> These are the updates.
>> Series was
>>
>> 1) Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
>> (on AMD Seattle platform w/ PCI Generic Host controller)
>> 2) Acked-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
>> 3) Reviewed-by: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
>>
> Bjorn,
>
> I haven't seen a reply from my above email. As soon as you are ready to pull
> this to v4.1 next (originally requested for v3.21 as per above email)branch,
> please let me know and I can send you an updated version rebased to your
> next branch and with the above acks.

My "next" and "for-linus" branches will be based on v4.0-rc1, so
that's the ideal base for patches.  I don't expect any significant
changes that would require a rebase, so unless something in your
patches themselves has changed since you last posted them, you don't
need to repost them just for a rebase.

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
