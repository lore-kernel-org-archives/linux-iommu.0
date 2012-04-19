From: Jon Mayo <jmayo-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC 0/4] Add NVIDIA Tegra DRM support
Date: Thu, 19 Apr 2012 13:59:39 -0700
Message-ID: <4F907CBB.4080705@nvidia.com>
References: <1334146230-1795-1-git-send-email-thierry.reding@avionic-design.de> <20120419173537.GA7692@avionic-0098.adnet.avionic-design.de> <CAPM=9tzK83yYS33eNruvFDwb62ycZxJMC31davVRN=yaZD53YA@mail.gmail.com> <20120419204016.GA8954@avionic-0098.mockup.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120419204016.GA8954-RM9K5IK7kjIQXX3q8xo1gnVAuStQJXxyR5q1nwbD4aMs9pC9oP6+/A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Cc: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 04/19/2012 01:40 PM, Thierry Reding wrote:
> * PGP Signed by an unknown key
>
> * Dave Airlie wrote:
>> On Thu, Apr 19, 2012 at 6:35 PM, Thierry Reding
>> <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>  wrote:
>>> Before posting the next round of patches I wanted to clarify whether we need
>>> to take the Tegra driver through staging. Lucas brought this up referring to
>>> previous experience with Nouveau where Linus used to complain that userspace
>>> ABI was broken for non-staging drivers. I don't know how relevant that is
>>> for Tegra. We could also keep it in drivers/gpu/drm and only add userspace
>>> interfaces that we are sure are not going to change. Currently there isn't
>>> isn't anything that could be easily broken as only some of the standard DRM
>>> interfaces are supported anyway.
>>>
>>> Alternatively we could keep the driver in a separate tree until it becomes
>>> mature enough.
>>>
>>> Any thoughts?
>>
>> It's probably okay to avoid staging if it doesn't add any userspace ioctls.
>>
>> A KMS driver that just supports the dumb ioctls so -modesetting works,
>> would be the first thing to aim for I suppose, like how the exynos
>> guys did it.
>>
>> Adding userspace interfaces is where you'll get into ABI guarantees
>> etc, and these are normally required only for the accel engines.
>
> I think this is what Lucas was concerned about. The plan is to look at how
> much can be used from the Nouveau code and make it work on the Tegra. So
> would it be possible to get a basic dumb KMS driver into mainline
> (non-staging) and phase in acceleration later on, with ABI guarantees? I
> guess development can go on in separate trees until the ABI is stable and can
> subsequently be ported to the mainline driver.
>
> Is that an acceptable approach?
>
> Thierry
>

That certainly seems like the most reasonable approach to me. Get KMS 
only in first. It's a useful driver as-is, and has the lowest barrier to 
entry into upstream.

Then later we can phase in enhancements. We certainly have plenty of 
places internally and externally to hash out acceleration interfaces, 
and come to some consensus at at later date (either on linux-tegra or 
direct email).

We have a lot of concerns here. What is best for X11, what is best for 
Android, how do we keep healthy open source implementations, and how 
does NVIDIA move forward with supporting new Tegra on an open source 
implementation. (My vote is NVIDIA starts using this DRM in-house and 
builds new extensions on top of it, sharing patches on LKML when the 
hardware is released)
