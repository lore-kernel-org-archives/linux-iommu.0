From: Don Dutile <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH v2 1/2] pci: Create PCIe requester ID interface
Date: Fri, 26 Jul 2013 16:04:59 -0400
Message-ID: <51F2D66B.8040607@redhat.com>
References: <20130711204439.1701.90503.stgit@bling.home>
	<20130711210326.1701.56478.stgit@bling.home>
	<20130723223533.GB19765@google.com> <51F03C1B.2070002@redhat.com>
	<20130725171958.GB9272@google.com> <51F16D80.5040208@redhat.com>
	<20130726194813.GA20021@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130726194813.GA20021-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 07/26/2013 03:48 PM, Bjorn Helgaas wrote:
> On Thu, Jul 25, 2013 at 02:25:04PM -0400, Don Dutile wrote:
>> On 07/25/2013 01:19 PM, Bjorn Helgaas wrote:
>>> On Wed, Jul 24, 2013 at 04:42:03PM -0400, Don Dutile wrote:
>>>> On 07/23/2013 06:35 PM, Bjorn Helgaas wrote:
>>>>> On Thu, Jul 11, 2013 at 03:03:27PM -0600, Alex Williamson wrote:
>>>>>> + * pcie_for_each_requester - Call callback @fn on each devices and DMA source
>>>>>> + *                           from @requestee to the PCIe requester ID visible
>>>>>> + *                           to @bridge.
>>>>>
>>>>> Transactions from a device may appear with one of several requester IDs,
>>>>> but there's not necessarily an actual pci_dev for each ID, so I think the
>>>> ditto above; have to have a pdev for each id....
>>>
>>> This *might* be true, but I don't think we should rely on it.  For
>>> example:
>>>
>>>    00:1c.0 PCIe to PCI bridge to [bus 01]
>>>    01:01.0 PCI endpoint
>>>
>>> The bridge will take ownership of DMA transactions from the 01:01.0
>>> endpoint.  An IOMMU on bus 00 will see a bridge-assigned requester
>>> ID of 01:00.0 (subordinate bus number, devfn zero), but there is no
>>> 01:00.0 device.
>>>
>> Clarification:
>> I meant that each requester-id must have at least 1 PCI device associated
>> with it.
>
> I don't think that's true, as in the example above.  Requester ID
> 0x0100 has no pci_dev associated with it.  What am I missing?
>
> Maybe you mean that requester ID 0x0100 is associated with pci_dev
> 01:01.0 in the sense that DMAs from 01:01.0 appear with that ID?
yes.
> That's true, but I can't think of a reason why we would start with
> ID 0x0100 and try to look up 01:01.0 from it.  And of course, if you
other than to figure out errant device behavior, or a bug in sw. ;)

> *did* try to look up the device, there could be several of them.
>
> Bjorn
What's most important for the consumers (IOMMUs) is to get all the requester-id's
related to a (p)dev for mapping & unmapping setup & teardown, resp.
