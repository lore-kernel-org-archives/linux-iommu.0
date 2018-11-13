From: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH 06/10] swiotlb: use swiotlb_map_page in swiotlb_map_sg_attrs
Date: Mon, 12 Nov 2018 16:26:19 -0800
Message-ID: <CALAqxLV8u7rFKRc19J7z_TKLbkG4YbAfj8HjOnPeDH3-uYXPDQ@mail.gmail.com>
References: <20181008080246.20543-1-hch@lst.de> <20181008080246.20543-7-hch@lst.de>
 <CANcMJZAzrxA9LGNvP-epv2DwsUacEM_hcgA1n5gmaPuWRJG4iw@mail.gmail.com>
 <20181109074955.GA27489@lst.de> <CALAqxLVSDkv4faF3ta_ue9AA9s8B=-8cAMxC_sow+wZYtrfxeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALAqxLVSDkv4faF3ta_ue9AA9s8B=-8cAMxC_sow+wZYtrfxeQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Robin Murphy <robin.murphy@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Valentin Schneider <valentin.schneider@arm.com>
List-Id: iommu@lists.linux-foundation.org

On Mon, Nov 12, 2018 at 4:07 PM, John Stultz <john.stultz@linaro.org> wrote:
> On Thu, Nov 8, 2018 at 11:49 PM, Christoph Hellwig <hch@lst.de> wrote:
>> On Tue, Nov 06, 2018 at 05:27:14PM -0800, John Stultz wrote:
>>> But at that point if I just re-apply "swiotlb: use swiotlb_map_page in
>>> swiotlb_map_sg_attrs", I reproduce the hangs.
>>>
>>> Any suggestions for how to further debug what might be going wrong
>>> would be appreciated!
>>
>> Very odd.  In the end map_sg and map_page are defined to do the same
>> things to start with.  The only real issue we had in this area was:
>>
>> "[PATCH v2] of/device: Really only set bus DMA mask when appropriate"
>>
>> so with current mainline + that you still see a problem, and if you
>> rever the commit we are replying to it still goes away?
>
> Just to confirm, as of 4.20-rc2 (which includes the of/device patch
> above), I'm still seeing this issue, but it isn't as reliable to
> reproduce as before.
>
> With "swiotlb: use swiotlb_map_page in swiotlb_map_sg_attrs" reverted
> (along with the dependent swiotlb patches) it doesn't seem to trigger
> (no matter what I try).  But re-applying that patch it tends to
> trigger by itself at boot up, but sometimes I have to run "find /" to
> trigger the io hang/stall.

Also, I wanted to mention I've not seen this issue on the original
hikey board. So far only on the hikey960, which might mean this is
tied to something in the hisi UFS driver?

thanks
-john
