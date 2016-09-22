From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH/RFC] iommu/ipmmu-vmsa: Update ->add_device() return value
Date: Thu, 22 Sep 2016 16:56:43 +0100
Message-ID: <12f65b42-2113-9036-dfe7-c12ec28f172e@arm.com>
References: <20160920124144.8629.22575.sendpatchset@little-apple>
 <3759bb9c-c482-4fae-d588-7c946ebeecae@arm.com>
 <CANqRtoQ_3PNobXuSd9hxMw2uZepErLoVadXbq6G4UZXnrPiEpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CANqRtoQ_3PNobXuSd9hxMw2uZepErLoVadXbq6G4UZXnrPiEpA@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: iommu@lists.linux-foundation.org, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: iommu@lists.linux-foundation.org

On 20/09/16 16:03, Magnus Damm wrote:
> Hi Robin,
> 
> Thanks for your feedback!!
> 
> On Tue, Sep 20, 2016 at 10:18 PM, Robin Murphy <robin.murphy@arm.com> wrote:
>> Hi Magnus,
>>
>> On 20/09/16 13:41, Magnus Damm wrote:
>>> From: Magnus Damm <damm+renesas@opensource.se>
>>>
>>> Update the IPMMU driver to return -ENODEV when adding devices
>>> not hooked up a particular IPMMU instance.
>>>
>>> Currently the ->add_device() callback implementation in the IPMMU
>>> driver returns -ENODEV for devices with no "iommus" property,
>>> however the function ipmmu_find_utlbs() may return -EINVAL.
>>
>> If there were no "iommus" property at all, of_parse_phandle_with_args()
>> should return -ENOENT - that probably does want to be caught and passed
>> back as -ENODEV to imply an untranslated device. On the other hand,
>> -EINVAL would stem from the existence of the property, but in a somehow
>> erroneous manner - other than the "args.np != mmu->dev->of_node" check
>> (which could legitimately fail and be safely ignored if there are
>> multiple IOMMUs in the system), any other reason implies a DT error
>> which probably shouldn't be papered over.
> 
> Regarding -ENOENT to -ENODEV, I agree but I believe this case is
> already handled. The ->add_device() callback seems to be using
> of_count_phandle_with_args() to check for the presence of "iommus"
> property before calling ipmmu_find_utlbs(). So for the case with no
> "iommus" property at all it is returned as -ENODEV as you suggest.

Ah, right you are, I missed that there was a separate check earlier.

> The ->add_device() callback has the ret variable initialised to
> -ENODEV by default. In case there is only one IPMMU device on the
> ipmmu_device list and it matches the struct device passed to the
> ipmmu_add_device() function then all is fine. However when there are
> more than one IPMMU device on the ipmmu_device list then
> ipmmu_find_utlbs() may return -EINVAL. Judging by the code this seems
> to happen when the order of the IPMMU devices on the "iommus" property
> does not match the IPMMU order on the ipmmu_device list.
> 
> Hm, I wonder if all this should be replaced with ->xlate() somehow?

Ideally, yes - the core code already has most of this covered, so taking
advantage of it would be good. I think the only slight hiccup is that
the 32-bit DMA code is then going to call attach_dev() with a domain you
probably don't want, before you get your add_device() call. Other than
handling that vs. group-based default domains for 64-bit, though, there
shouldn't be anything else to special-case, I don't think.

I'm finally starting to have a look into converting the arch/arm code
over to use groups and default domains sensibly, but I suspect that's
ultimately going to have some dependency on the probe deferral stuff,
rather than introduce the same bus notifier bodge we currently have on
arm64.

Robin.

> 
> Thanks,
> 
> / magnus
> 
