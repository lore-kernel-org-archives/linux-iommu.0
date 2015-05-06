From: Oded Gabbay <oded.gabbay@gmail.com>
Subject: Re: [git pull] IOMMU Updates for Linux v4.1
Date: Wed, 6 May 2015 15:03:11 +0300
Message-ID: <CAFCwf10kJoD1iCD0MrOComfJm_dfb6ukiWuxEwrc=xvrd5ofMA@mail.gmail.com>
References: <20150420023433.GA3719@8bytes.org> <55349B7C.2090109@amd.com>
 <5545027B.1010704@amd.com> <20150502221444.GB15736@8bytes.org>
 <5545BDB2.6020006@amd.com> <CA+5PVA63kPZcbzsjd1EE=rzL_CwF8yNXTdoZf=6RvGCpvtq04Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+5PVA63kPZcbzsjd1EE=rzL_CwF8yNXTdoZf=6RvGCpvtq04Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Josh Boyer <jwboyer@fedoraproject.org>
Cc: Oded Gabbay <oded.gabbay@amd.com>, Linus Torvalds <torvalds@linux-foundation.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On Tue, May 5, 2015 at 9:22 PM, Josh Boyer <jwboyer@fedoraproject.org> wrote:
> On Sun, May 3, 2015 at 2:18 AM, Oded Gabbay <oded.gabbay@amd.com> wrote:
>>
>>
>> On 05/03/2015 01:14 AM, Joerg Roedel wrote:
>>>
>>> Hi Oded,
>>>
>>> On Sat, May 02, 2015 at 07:59:39PM +0300, Oded Gabbay wrote:
>>>>
>>>> However, Joerg is not answering my emails for some reason
>>>> (vacation/sick?)
>>>
>>>
>>> Sorry, I was travelling for the last 3 weeks and had bad internet
>>> access. But I am back and will take care of this on Monday.
>>>
>>>
>>>         Joerg
>>>
>> Glad to hear it was vacation and not my other guess :)
>> Usually I'd be more patient, but as Fedora 22 already uses kernel 4.0, I
>> wanted to get this fix asap into stable.
>
> Is Fedora a particular concern here, or did you just happen to notice
> we're shipping with 4.0?  I'm curious if there is a Fedora bug that
> was reported for the issue you're concerned about that we may have
> missed.
>
> josh
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

AFAIK, this is not a reported bug.

When I encountered the bug, I knew F22 uses 4.0, so I'm assuming that
any user which installs F22 on Kaveri system AND executes an HSA
application, will encounter this bug.

-- 
          Oded
