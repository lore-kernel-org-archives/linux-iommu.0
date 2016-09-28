From: Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] iommu: narrow the search range by iterating on current bus
Date: Wed, 28 Sep 2016 19:51:41 +0000
Message-ID: <20160928195141.GA18803@vultr.guest>
References: <1469717579-8244-1-git-send-email-richard.weiyang@gmail.com>
	<20160728090132.42c6ebc1@t450s.home>
	<20160805140317.GA26921@vultr.guest>
	<20160818230026.GA2631@vultr.guest>
Reply-To: Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160818230026.GA2631-yrDqe6+Pica9sAcnBtTtJQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Ping~ Hope you like it :-)

On Thu, Aug 18, 2016 at 11:00:26PM +0000, Wei Yang wrote:
>Hi, Alex & Bjorn,
>
>I tried to measure the effect of the improvement and looks good.
>
>    +---------------+-----------+-----------+-----------+
>    |Platform Info  |Before(ns) |After(ns)  |Improvement|
>    +---------------+-----------+-----------+-----------+
>    |76 pci devices |1846600    |100289     |94.5%      |
>    +---------------+-----------+-----------+-----------+
>    |16 pci devices |46931      |23189      |53.0%      |
>    +---------------+-----------+-----------+-----------+
>
>Below is my raw result and the code to measure the time used. Willing to hear
>from you :-)
>
>Raw Data collected on a machine with 32 pci devices in the system.
>==================
>total time 46931 with 32 devices 1466.59 each
>total time 23189 with 32 devices 724.656 each
>
>Raw Data collected on a machine with 76 pci devices in the system.
>==================
>total time 1846600 with 152 devices 12148.7 each
>total time 100289 with 152 devices 659.796 each
>
>Script and diff to kernel to extract the raw data.
>==================
>awk ' {x += $9; y++} END {print "total time " x " with " y " devices " x/y " each"}' narrow.orig 
>
>diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>index d420d94d..63cda3d 100644
>--- a/drivers/iommu/iommu.c
>+++ b/drivers/iommu/iommu.c
>@@ -743,6 +743,7 @@ struct iommu_group *pci_device_group(struct device *dev)
> 	struct pci_bus *bus;
> 	struct iommu_group *group = NULL;
> 	u64 devfns[4] = { 0 };
>+	struct timespec ts1, ts2;
> 
> 	if (WARN_ON(!dev_is_pci(dev)))
> 		return ERR_PTR(-EINVAL);
>@@ -782,7 +783,11 @@ struct iommu_group *pci_device_group(struct device *dev)
> 	 * Look for existing groups on device aliases.  If we alias another
> 	 * device or another device aliases us, use the same group.
> 	 */
>+	getnstimeofday(&ts1);
> 	group = get_pci_alias_group(pdev, (unsigned long *)devfns);
>+	getnstimeofday(&ts2);
>+	dev_info(dev, "ywtest: %s: get_pci_alias_group			spend %lu sec %lu nsec\n",
>+			__func__, ts2.tv_sec - ts1.tv_sec, ts2.tv_nsec - ts1.tv_nsec);
> 	if (group)
> 		return group;
> 
>@@ -791,7 +796,11 @@ struct iommu_group *pci_device_group(struct device *dev)
> 	 * slot and aliases of those functions, if any. No need to clear
> 	 * the search bitmap, the tested devfns are still valid.
> 	 */
>+	getnstimeofday(&ts1);
> 	group = get_pci_function_alias_group(pdev, (unsigned long *)devfns);
>+	getnstimeofday(&ts2);
>+	dev_info(dev, "ywtest: %s: get_pci_function_alias_group		spend %lu sec %lu nsec\n",
>+			__func__, ts2.tv_sec - ts1.tv_sec, ts2.tv_nsec - ts1.tv_nsec);
> 	if (group)
> 		return group;
> 
>On Fri, Aug 05, 2016 at 02:03:17PM +0000, Wei Yang wrote:
>>On Thu, Jul 28, 2016 at 09:01:32AM -0600, Alex Williamson wrote:
>>>On Thu, 28 Jul 2016 14:52:59 +0000
>>>Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>>
>>>> According to the comments and code, get_pci_function_alias_group() and
>>>> get_pci_alias_group() do the search on the same pci bus. This means we can
>>>> just iterate on the bus the pci device attaches to.
>>>> 
>>>> This patch narrows the search range by just iterating on the current bus
>>>> and fix one typo in comment.
>>>> 
>>>> Signed-off-by: Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>>> ---
>>>>  drivers/iommu/iommu.c |   22 ++++++++--------------
>>>>  1 file changed, 8 insertions(+), 14 deletions(-)
>>>> 
>>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>>> index 3000051..0338a81 100644
>>>> --- a/drivers/iommu/iommu.c
>>>> +++ b/drivers/iommu/iommu.c
>>>> @@ -643,17 +643,15 @@ static struct iommu_group *get_pci_function_alias_group(struct pci_dev *pdev,
>>>>  	if (!pdev->multifunction || pci_acs_enabled(pdev, REQ_ACS_FLAGS))
>>>>  		return NULL;
>>>>  
>>>> -	for_each_pci_dev(tmp) {
>>>> -		if (tmp == pdev || tmp->bus != pdev->bus ||
>>>> +	list_for_each_entry(tmp, &pdev->bus->devices, bus_list) {
>>>
>>>I believe this was using for_each_pci_dev() exactly because it takes a
>>>reference to the device and therefore we can use it to get a reference
>>>to the group.  How do you justify removing these reference semantics?
>>>Thanks,
>>>
>>
>>Alex,
>>
>>With some investigation, I believe these reference are important. Thanks for
>>reminding.
>>
>>Well, the pci_dev and the bus->devices list are protected by pci_bus_sem and
>>we have already had a function to walk the pci bus safely by holding this
>>semaphore. While the pci_walk_bus() will continue the process when it sees a
>>bridge device.
>>
>>So I create another patch to export a function to walk just on the local bus
>>and then calling this from get_pci_function_alias_group() and
>>get_pci_alias_group().
>>
>>Since this change is related to pci subsystem, I include Bjorn.
>>
>>Hi, Bjorn,
>>
>>Haven't seen you for a long time. Hope you would like the idea.
>>
>>>Alex
>>>
>>>> +		if (tmp == pdev ||
>>>>  		    PCI_SLOT(tmp->devfn) != PCI_SLOT(pdev->devfn) ||
>>>>  		    pci_acs_enabled(tmp, REQ_ACS_FLAGS))
>>>>  			continue;
>>>>  
>>>>  		group = get_pci_alias_group(tmp, devfns);
>>>> -		if (group) {
>>>> -			pci_dev_put(tmp);
>>>> +		if (group)
>>>>  			return group;
>>>> -		}
>>>>  	}
>>>>  
>>>>  	return NULL;
>>>> @@ -681,23 +679,19 @@ static struct iommu_group *get_pci_alias_group(struct pci_dev *pdev,
>>>>  	if (group)
>>>>  		return group;
>>>>  
>>>> -	for_each_pci_dev(tmp) {
>>>> -		if (tmp == pdev || tmp->bus != pdev->bus)
>>>> +	list_for_each_entry(tmp, &pdev->bus->devices, bus_list) {
>>>> +		if (tmp == pdev)
>>>>  			continue;
>>>>  
>>>>  		/* We alias them or they alias us */
>>>>  		if (pci_devs_are_dma_aliases(pdev, tmp)) {
>>>>  			group = get_pci_alias_group(tmp, devfns);
>>>> -			if (group) {
>>>> -				pci_dev_put(tmp);
>>>> +			if (group)
>>>>  				return group;
>>>> -			}
>>>>  
>>>>  			group = get_pci_function_alias_group(tmp, devfns);
>>>> -			if (group) {
>>>> -				pci_dev_put(tmp);
>>>> +			if (group)
>>>>  				return group;
>>>> -			}
>>>>  		}
>>>>  	}
>>>>  
>>>> @@ -794,7 +788,7 @@ struct iommu_group *pci_device_group(struct device *dev)
>>>>  
>>>>  	/*
>>>>  	 * Look for existing groups on non-isolated functions on the same
>>>> -	 * slot and aliases of those funcions, if any.  No need to clear
>>>> +	 * slot and aliases of those functions, if any. No need to clear
>>>>  	 * the search bitmap, the tested devfns are still valid.
>>>>  	 */
>>>>  	group = get_pci_function_alias_group(pdev, (unsigned long *)devfns);
>>
>>-- 
>>Wei Yang
>>Help you, Help me
>
>-- 
>Wei Yang
>Help you, Help me

-- 
Wei Yang
Help you, Help me
