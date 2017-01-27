From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH V7 01/11] iommu/of: Refactor of_iommu_configure() for
	error handling
Date: Fri, 27 Jan 2017 18:19:51 +0000
Message-ID: <d27f04da-7d34-9640-1639-790d0732ed93@arm.com>
References: <1485188293-20263-1-git-send-email-sricharan@codeaurora.org>
	<1485188293-20263-2-git-send-email-sricharan@codeaurora.org>
	<4388779a-0e83-fadc-83f4-98c46c88d42e@semihalf.com>
	<c7bad124-d9f2-0ddf-168f-0b1950d3e1ed@arm.com>
	<009901d278c7$34fee230$9efca690$@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <009901d278c7$34fee230$9efca690$@codeaurora.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sricharan <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, 'Tomasz Nowicki' <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 27/01/17 18:00, Sricharan wrote:
> Hi Robin,
> 
> [..]
> 
>>>> +const struct iommu_ops *of_iommu_configure(struct device *dev,
>>>> +                       struct device_node *master_np)
>>>> +{
>>>> +    const struct iommu_ops *ops;
>>>> +
>>>> +    if (!master_np)
>>>> +        return NULL;
>>>> +
>>>> +    if (dev_is_pci(dev))
>>>> +        ops = of_pci_iommu_init(to_pci_dev(dev), master_np);
>>>
>>> I gave the whole patch set a try on ThunderX. really_probe() is failing
>>> on dma_configure()->of_pci_iommu_init() for each PCI device.
>>
>> When you say "failing", do you mean cleanly, or with a crash? I've
>> managed to hit __of_match_node() dereferencing NULL from
>> of_iommu_xlate() in a horribly complicated chain of events, which I'm
>> trying to figure out now, and I wonder if the two might be related.
> 
> Sorry that there is crash still. __of_match_node seems to checking
> for NULL arguments , feels like some invalid pointer was passed in.
> Is there any particular sequence to try for this ?

Ah, I did figure it out - it wasn't actually a NULL dereference, but an
unmapped address. Turns out __iommu_of_table is in initdata, so any
driver probing after init, connected to an unprobed IOMMU (in this case
disabled in DT), trips over trying to match the now-freed table. I'm
working on the fix - technically the bug's in my patch (#2) anyway ;)

Robin.

> 
> Regards,
>  Sricharan
> 
> 
> 
> 
