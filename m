From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v2 02/12] iommu/vt-d: Manage scalalble mode PASID tables
Date: Thu, 6 Sep 2018 11:05:01 +0800
Message-ID: <3eb98f00-6bf2-0c2b-fb95-74505c7fd917@linux.intel.com>
References: <20180830013524.28743-1-baolu.lu@linux.intel.com>
	<20180830013524.28743-3-baolu.lu@linux.intel.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D1912F2A85@SHSMSX101.ccr.corp.intel.com>
	<44298d5c-5720-a382-07d1-a90a072ff24b@linux.intel.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D1912F2BBC@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D1912F2BBC-0J0gbvR4kThpB2pF5aRoyrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, "Kumar,
	Sanjay K" <sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Sun, Yi Y" <yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Pan,
	Jacob jun" <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

On 09/06/2018 10:52 AM, Tian, Kevin wrote:
>> From: Lu Baolu [mailto:baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org]
>> Sent: Thursday, September 6, 2018 10:46 AM
>>
> [...]
>>>> @@ -143,8 +142,9 @@ int intel_pasid_alloc_table(struct device *dev)
>>>>    		return -ENOMEM;
>>>>    	INIT_LIST_HEAD(&pasid_table->dev);
>>>>
>>>> -	size = sizeof(struct pasid_entry);
>>>> +	size = sizeof(struct pasid_dir_entry);
>>>>    	count = min_t(int, pci_max_pasids(to_pci_dev(dev)),
>>>> intel_pasid_max_id);
>>>> +	count >>= PASID_PDE_SHIFT;
>>>>    	order = get_order(size * count);
>>>>    	pages = alloc_pages_node(info->iommu->node,
>>>>    				 GFP_ATOMIC | __GFP_ZERO,
>>>> @@ -154,7 +154,7 @@ int intel_pasid_alloc_table(struct device *dev)
>>>>
>>>>    	pasid_table->table = page_address(pages);
>>>>    	pasid_table->order = order;
>>>> -	pasid_table->max_pasid = count;
>>>> +	pasid_table->max_pasid = count << PASID_PDE_SHIFT;
>>>
>>> are you sure of that count is PDE_SHIFT aligned? otherwise >>
>>> then << would lose some bits. If sure, then better add some check.
>>
>> I am making the max_pasid PDE_SHIFT aligned as the result of shift
>> operations.
>>
> 
> earlier:
>>>>    	count = min_t(int, pci_max_pasids(to_pci_dev(dev)),
>>>> intel_pasid_max_id);
> 
> so you decided to truncate count to be PDE_SHIFT aligned. Is PASID
> value user configurable? if not, then it's fine.

Here @count is the count of PASID directory entries, so it must be
truncated from the original max_pasid. PASID value is not configurable
anyway.

> 
>>>
>>>>
>>>>    attach_out:
>>>>    	device_attach_pasid_table(info, pasid_table);
>>>> @@ -162,14 +162,33 @@ int intel_pasid_alloc_table(struct device *dev)
>>>>    	return 0;
>>>>    }
>>>>
>>>> +/* Get PRESENT bit of a PASID directory entry. */
>>>> +static inline bool
>>>> +pasid_pde_is_present(struct pasid_dir_entry *pde)
>>>> +{
>>>> +	return READ_ONCE(pde->val) & PASID_PTE_PRESENT;
>>>
>>> curious why adding READ_ONCE specifically for PASID structure,
>>> but not used for any other existing vtd structures? Is it to address
>>> some specific requirement on PASID structure as defined in spec?
>>
>> READ/WRITE_ONCE are used in pasid entry read/write to prevent the
>> compiler from merging, refetching or reordering successive instances of
>> read/write.
>>
> 
> that's fine. I'm just curious why this is the first user of such macros
> in intel-iommu driver. Even before with ecs we have PASID table too.
> 

Best regards,
Lu Baolu
