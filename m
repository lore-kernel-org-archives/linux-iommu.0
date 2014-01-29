From: Suravee Suthikulanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2 08/11] of: Increase MAX_PHANDLE_ARGS
Date: Wed, 29 Jan 2014 11:26:35 -0600
Message-ID: <52E939CB.1020705@amd.com>
References: <1389876263-25759-1-git-send-email-andreas.herrmann@calxeda.com> <1389876263-25759-9-git-send-email-andreas.herrmann@calxeda.com> <20140117110830.GW3471@alberich> <52E92842.3000001@amd.com> <CAL_JsqLhzp5jUJPA91rNkQ07kCDYCDZLxw8LxxFEVP9b12e1Jw@mail.gmail.com> <52E93360.1000904@amd.com> <20140129171611.GB13543@alberich>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140129171611.GB13543@alberich>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 1/29/2014 11:16 AM, Andreas Herrmann wrote:
> On Wed, Jan 29, 2014 at 11:59:12AM -0500, Suravee Suthikulanit wrote:
>> On 1/29/2014 10:57 AM, Rob Herring wrote:
>>>>> diff --git a/include/linux/of.h b/include/linux/of.h
>>>>>>> index 276c546..24e1b28 100644
>>>>>>> --- a/include/linux/of.h
>>>>>>> +++ b/include/linux/of.h
>>>>>>> @@ -67,7 +67,7 @@ struct device_node {
>>>>>>>    #endif
>>>>>>>    };
>>>>>>>
>>>>>>> -#define MAX_PHANDLE_ARGS 8
>>>>>>> +#define MAX_PHANDLE_ARGS 16
>>>>>
>>>>>
>>>>> Since the MMU-500 specify "Number of SMRs" upto 128 registers, shouldn't
>>>>> this be changed to be able to support 128 StreamIDs as well?  Although I am
>>>>> not sure if this would be too big to have on the stack per Rob's comment in
>>>>> the previous patch set.
>>> Do you actually need 128 now? If not, then we can deal with that when
>>> we get there. There are lots of things in spec's that are not actually
>>> implemented or supported.
>>
>> Actually, we are using 32 on the AMD system. So, do you think we can set
>> this to 32 instead?
>
> I think that's ok.
>
> But are we really talking about number of SMRs or number of StreamIDs
> per master device here? Ie. are you just having 32 SMRs for an SMMU on
> your AMD system or do you have master devices which have 32 StreamIDs?
>
> If it's just number of SMRs we don't need to modify this macro.
>
>
> Andreas
>

I am referring to the case where each mmu-master can have upto 32 streamID.

Suravee

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
