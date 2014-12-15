From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 10/10] ARM: shmobile: r8a7791: Add IPMMU DT nodes
Date: Tue, 16 Dec 2014 07:44:32 +0900
Message-ID: <CANqRtoSYX10aaWu0r9GOPe+EvO2NkS4UJdLbST-aoHrv4XjG4A@mail.gmail.com>
References: <1418602429-11276-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<1418602429-11276-11-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<CAMuHMdWtkk=Q=Mfcyz03LBzXMuBOr8BZGNyCsQb9bwDty-4OiQ@mail.gmail.com>
	<1521122.WC5DkGVrBt@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1521122.WC5DkGVrBt@avalon>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, iommu@lists.linux-foundation.org, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

Hi Laurent,

On Tue, Dec 16, 2014 at 3:44 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Geert,
>
> On Monday 15 December 2014 14:07:52 Geert Uytterhoeven wrote:
>> On Mon, Dec 15, 2014 at 1:13 AM, Laurent Pinchart wrote:
>> > Add the seven IPMMU instances found in the r8a7791 to DT with a disabled
>> > status.
>> >
>> > Signed-off-by: Laurent Pinchart
>> > <laurent.pinchart+renesas@ideasonboard.com>
>>
>> The addresses and interrupt numbers look OK to me.
>> However, my comment about the "0x800" offset is still valid.
>> Shouldn't we have two register blocks, and let the driver use only the
>> second one?
>>
>> If you ignore, feel free to add my
>> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> I don't want to ignore your comment, but I don't know what to do here :-/ The
> datasheet lacks detailed information about secure vs. non-secure mode and how
> the two register sets are supposed to interoperate and be handled by the
> operating system.

I don't know about that either.

But how about differences within R-Car Gen2 series so far? If there
are known differences then perhaps we should use part number in the
compatible string?

Thanks,

/ magnus
