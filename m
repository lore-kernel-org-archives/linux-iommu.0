From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v9 1/5] driver core: Find an existing link between two
	devices
Date: Tue, 20 Mar 2018 13:26:52 +0530
Message-ID: <726cf34b-568f-55c9-0459-ff34176f9927@codeaurora.org>
References: <20180313085534.11650-1-vivek.gautam@codeaurora.org>
	<2217404.A2W3Iek6du@aspire.rjw.lan>
	<CAAFQd5CQXY0Efv+2MC1kTVW5q4eZjJ=gwVaR-LA=3agnSSHzUw@mail.gmail.com>
	<2705105.V6KYPvoJqj@aspire.rjw.lan>
	<11eae0bc-7921-e598-9c01-63498400c85b@arm.com>
	<20180314122759.GB19651@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180314122759.GB19651-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
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
To: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Lukasz,


On 3/14/2018 5:57 PM, Lukas Wunner wrote:
> On Wed, Mar 14, 2018 at 12:14:15PM +0000, Robin Murphy wrote:
>>>> On Wed, Mar 14, 2018 at 8:12 PM, Rafael J. Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org> wrote:
>>>>> On Tuesday, March 13, 2018 12:23:34 PM CET Tomasz Figa wrote:
>>>>>> On Tue, Mar 13, 2018 at 7:34 PM, Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
>>>>>>> On Tue, Mar 13, 2018 at 3:45 PM, Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
>>>>>>>> On Tue, Mar 13, 2018 at 5:55 PM, Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
>>>>>>>>> The lists managing the device-links can be traversed to
>>>>>>>>> find the link between two devices. The device_link_add() APIs
>>>>>>>>> does traverse these lists to check if there's already a link
>>>>>>>>> setup between the two devices.
>>>>>>>>> So, add a new APIs, device_link_find(), to find an existing
>>>>>>>>> device link between two devices - suppliers and consumers.
>>>>>>>> I'm wondering if this API would be useful for anything else that the
>>>>>>>> problem we're trying to solve with deleting links without storing them
>>>>>>>> anywhere. Perhaps a device_link_del_dev(consumer, supplier) would be a
>>>>>>>> better alternative?
>>>>>>> Yea, that sounds simpler i think. Will add this API instead of
>>>>>>> find_link(). Thanks.
>>>>>> Perhaps let's wait for a moment to see if there are other opinions. :)
>>>>>>
>>>>>> Rafael, Lucas, any thoughts?
>>>>> It is not clear to me what the device_link_del_dev(consumer, supplier)
>>>>> would do.
>> Not quite - the issue here is that we have one supplier with an arbitrarily
>> large number of consumers, and would prefer that supplier not to have to
>> spend a whole bunch of memory to store all the struct device_link pointers
>> for the sole reason of having something to give to device_link_del() at the
>> end, given that the device links code is already keeping track of everything
>> internally anyway.
> Makes sense to me.  How about an additional flag which autoremoves the
> link on provider unbind?

If I understand this correctly, if we create the device link with 
DL_FLAG_AUTOREMOVE, the link is deleted after a consumer unbind. During 
a supplier unbind all we get is a WARN_ON with DL_FLAG_AUTOREMOVE. I 
guess that's an intended behavior?

If this is the case, then the consumer/supplier drivers just don't have 
to take care of deleting the device link explicitly.
Is my understanding correct?

regards
Vivek

>
> Thanks,
>
> Lukas
