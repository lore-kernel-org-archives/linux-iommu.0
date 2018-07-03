From: "Hook, Gary" <ghook-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] iommu/amd: fix missing tag from dev_err message
Date: Tue, 3 Jul 2018 11:21:24 -0500
Message-ID: <f3e15437-68c1-58eb-bc34-93fa70e50dc9@amd.com>
References: <20180703064005.18908-1-colin.king@canonical.com>
	<6763ec382f8d629f5f356f4cc023f20c2f76b26a.camel@perches.com>
	<d27fe634-89cf-7d9a-3e3d-a2baafabf0be@amd.com>
	<d93bfa0f52d8907019b16336645986cd339ebf75.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <d93bfa0f52d8907019b16336645986cd339ebf75.camel-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
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
To: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, Colin King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 7/3/2018 10:55 AM, Joe Perches wrote:
> On Tue, 2018-07-03 at 07:56 -0500, Gary R Hook wrote:
>> On 07/03/2018 05:07 AM, Joe Perches wrote:
>>> On Tue, 2018-07-03 at 07:40 +0100, Colin King wrote:
>>>> Currently tag is being assigned but not used, it is missing from
>>>> the dev_err message, so add it in.
>>>>
>>>> Cleans up clang warning:
>>>> warning: variable 'tag' set but not used [-Wunused-but-set-variable]
>>>
>>> []
>>>> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
>>>
>>> []
>>>> @@ -616,9 +616,9 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
>>>>    		pasid = ((event[0] >> 16) & 0xFFFF)
>>>>    			| ((event[1] << 6) & 0xF0000);
>>>>    		tag = event[1] & 0x03FF;
>>>> -		dev_err(dev, "INVALID_PPR_REQUEST device=%02x:%02x.%x pasid=0x%05x address=0x%016llx flags=0x%04x]\n",
>>>> +		dev_err(dev, "INVALID_PPR_REQUEST device=%02x:%02x.%x pasid=0x%05x address=0x%016llx flags=0x%04x tag=0x%03x]\n",
>>>>    			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
>>>> -			pasid, address, flags);
>>>> +			pasid, address, flags, tag);
>>>
>>> Seems to have a superfluous ] that should be removed.
>>
>> Yeah, I pretty much messed up all of the log messages in that function.
>> My apologies. I'll create a patch for that problem; it shouldn't be
>> fixed here.

Well, no, I misremembered. The extraneous square brace has been there 
forever. Needs fixin', though.


> I also wonder why event is declared volatile and then
> dereferenced with [<constant>] multiple times.
> 
> Maybe each array dereference should be stored as a
> local variable instead.

(I know you know this, but as I understand it) Event is pointing into 
the (hardware's) event buffer, and the data structure has the potential 
of changing out from under us if the device does something without our 
knowledge. Since volatile hints to the compiler of this possibility, I 
believe the compiler should manage this situation. But I could be wrong.

I don't know that we need to atomically copy all 16 bytes into a local 
buffer, as I don't think it's possible for the device to step on itself. 
It will just stop recording events if the buffer gets full. At this 
moment I think volatile is overkill, at least for the EPYC/Ryzen IOMMU.
