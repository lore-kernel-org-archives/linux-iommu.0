From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCHv7 04/12] driver/core: populate devices in order for IOMMUs
Date: Mon, 16 Dec 2013 11:26:35 -0700
Message-ID: <52AF45DB.9050302@wwwdotorg.org>
References: <1386835033-4701-1-git-send-email-hdoyu@nvidia.com>
	<1386835033-4701-5-git-send-email-hdoyu@nvidia.com>
	<20131212113920.70E8BC40637@trevor.secretlab.ca>
	<20131213021402.GB14192@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20131213021402.GB14192-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 12/12/2013 07:14 PM, Greg KH wrote:
> On Thu, Dec 12, 2013 at 11:39:20AM +0000, Grant Likely wrote:
>> On Thu, 12 Dec 2013 09:57:05 +0200, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>>> IOMMU devices on the bus need to be poplulated first, then iommu
>>> master devices are done later.
>>>
>>> With CONFIG_OF_IOMMU, "iommus=" DT binding would be used to identify
>>> whether a device can be an iommu msater or not. If a device can, we'll
>>> defer to populate that device till an iommu device is populated. Then,
>>> those deferred iommu master devices are populated and configured with
>>> help of the already populated iommu device.

>>> This is related to the following discussion:
>>>   [RFC PATCH] Documentation: devicetree: add description for generic bus properties
>>>   http://lists.infradead.org/pipermail/linux-arm-kernel/2013-November/215042.html

>>> diff --git a/drivers/base/dd.c b/drivers/base/dd.c

>>> @@ -273,6 +274,10 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>>>  
>>>  	dev->driver = drv;
>>>  
>>> +	ret = of_iommu_attach(dev);
>>> +	if (ret)
>>> +		goto probe_failed;
>>> +
>>
>> As discussed before, I really don't think hooking in to dd.c is the
>> right thing to do here, and certainly not as a device tree specific
>> function. ACPI or PCI described devices may have the same constraints
>> and those won't have DT descriptions.
> 
> I agree, this shouldn't be in the driver core.

I don't think I agree. It'd greatly simplify driver probe() routines if
the driver core could acquire/set up as many resources as it could on
behalf of drivers. It'd be nice if it pre-mapped any registers, acquired
clocks, regulators, ... That way, we wouldn't need to write all that
code in each individual driver's probe() routine. Now, in many cases
this is rather difficult since there's currently no way for the driver
core to know which resources a driver needs, but when the driver core
can/does know this, shouldn't it simplify the life of drivers?
Longer-term, perhaps drivers can provide the driver core with some
specification of the resources it needs (such as a list of clock,
regulator, ... names), to fill in the missing information.
