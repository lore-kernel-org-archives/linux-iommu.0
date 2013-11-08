From: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/1] IOMMU: Save pci device id instead of pci_dev* pointer
	for DMAR devices
Date: Fri, 8 Nov 2013 08:46:55 -0700
Message-ID: <CAErSpo73N2Th-4D5G8-60tMuGwqthfu-VNHVf3LF9+s2mQp53w@mail.gmail.com>
References: <1383639898-48776-1-git-send-email-wangyijing@huawei.com>
	<1383639898-48776-2-git-send-email-wangyijing@huawei.com>
	<20131107180713.GA2955@google.com> <527C5D36.7050206@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <527C5D36.7050206-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:INTEL IOMMU (VT-d)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Hanjun Guo <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Nov 7, 2013 at 8:40 PM, Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org> wrote:
> HI Bjorn,
>    Thanks for your review and comments very much!
>
>>> +            list_for_each_entry(dmar_dev, head, list)
>>> +                if (dmar_dev->segment == pci_domain_nr(dev->bus)
>>> +                        && dmar_dev->bus == dev->bus->number
>>> +                        && dmar_dev->devfn == dev->devfn)
>>> +                    return 1;
>>> +
>>>              /* Check our parent */
>>>              dev = dev->bus->self;
>>
>> You didn't change this, but it looks like this may have the same problem
>> we've been talking about here:
>>
>> http://lkml.kernel.org/r/20131105232903.3790.8738.stgit-1RhO1Y9PlrlHTL0Zs8A6p5iNqAH0jzoTYJqu5kTmcBRl57MIdRCFDg@public.gmane.org
>>
>> Namely, if "dev" is a VF on a virtual bus, "dev->bus->self == NULL", so
>> we won't search for any of the bridges leading to the VF.  I proposed a
>> pci_upstream_bridge() interface that could be used like this:
>>
>>       /* Check our parent */
>>       dev = pci_upstream_bridge(dev);
>>
>
> It looks good to me, because pci_upstream_bridge() is still in your next branch, I think maybe
> I can split this changes in a separate patch after 3.13-rc1.

Yep, that would be a fix for a separate issue and should be a separate patch.

>>>  static struct intel_iommu *device_to_iommu(int segment, u8 bus, u8 devfn)
>>>  {
>>>      struct dmar_drhd_unit *drhd = NULL;
>>> -    int i;
>>> +    struct dmar_device *dmar_dev;
>>> +    struct pci_dev *pdev;
>>>
>>>      for_each_drhd_unit(drhd) {
>>>              if (drhd->ignored)
>>> @@ -658,16 +659,22 @@ static struct intel_iommu *device_to_iommu(int segment, u8 bus, u8 devfn)
>>>              if (segment != drhd->segment)
>>>                      continue;
>>>
>>> -            for (i = 0; i < drhd->devices_cnt; i++) {
>>> -                    if (drhd->devices[i] &&
>>> -                        drhd->devices[i]->bus->number == bus &&
>>> -                        drhd->devices[i]->devfn == devfn)
>>> -                            return drhd->iommu;
>>> -                    if (drhd->devices[i] &&
>>> -                        drhd->devices[i]->subordinate &&
>>> -                        drhd->devices[i]->subordinate->number <= bus &&
>>> -                        drhd->devices[i]->subordinate->busn_res.end >= bus)
>>> -                            return drhd->iommu;
>>> +            list_for_each_entry(dmar_dev, &drhd->head, list) {
>>> +                if (dmar_dev->bus == bus &&
>>> +                        dmar_dev->devfn == devfn)
>>> +                    return drhd->iommu;
>>> +
>>> +                pdev = pci_get_domain_bus_and_slot(dmar_dev->segment,
>>> +                        dmar_dev->bus, dmar_dev->devfn);
>>> +                if (pdev->subordinate &&
>>> +                        pdev->subordinate->number <= bus &&
>>> +                        pdev->subordinate->busn_res.end >= bus) {
>>> +                    pci_dev_put(pdev);
>>> +                    return drhd->iommu;
>>
>> I don't know the details of how device_to_iommu() is used, but this
>> style (acquire ref to pci_dev, match it to some other object, drop
>> pci_dev ref, return object) makes me nervous.  How do we know the
>> caller isn't depending on pci_dev to remain attached to the object?
>> What happens if the pci_dev disappears when we do the pci_dev_put()
>> here?
>
> Hmmm, this is the thing I am most worried about. If we just only use
> (pci_dev *) poninter in drhd->devices array as a identification. Change
> (pci_dev *) pointer instead of pci device id segment:bus:devfn is safe.
> Or, this is a wrong way to fix this issue. I don't know IOMMU driver much now,
> so IOMMU guys any comments on this issue is welcome.
>
> If this is not safe, what about we both save pci device id and (pci_dev *) pointer
> in drhd. So we can put pci_dev ref and set pci_dev * = NULL during device removed by bus notify, and
> update (pci_dev *)pointer during device add.

I don't know the IOMMU drivers well either, but it seems like they
rely on notifications of device addition and removal (see
iommu_bus_notifier()).  It doesn't seem right for them to also use the
generic PCI interfaces like pci_get_domain_bus_and_slot() because the
IOMMU driver should already know what devices exist and their
lifetimes.  It seems like confusion to mix the two.  But I don't have
a concrete suggestion.

Bjorn
