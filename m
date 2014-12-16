From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 10/10] ARM: shmobile: r8a7791: Add IPMMU DT nodes
Date: Tue, 16 Dec 2014 11:02:03 +0100
Message-ID: <CAMuHMdWnOgN+rmDTo7S+o3AS2hyjgzKEza0vuUYnWz7CbksfSA@mail.gmail.com>
References: <1418602429-11276-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<1418602429-11276-11-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<CAMuHMdWtkk=Q=Mfcyz03LBzXMuBOr8BZGNyCsQb9bwDty-4OiQ@mail.gmail.com>
	<1521122.WC5DkGVrBt@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1521122.WC5DkGVrBt@avalon>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Laurent,

On Mon, Dec 15, 2014 at 7:44 PM, Laurent Pinchart
<laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> wrote:
> On Monday 15 December 2014 14:07:52 Geert Uytterhoeven wrote:
>> On Mon, Dec 15, 2014 at 1:13 AM, Laurent Pinchart wrote:
>> > Add the seven IPMMU instances found in the r8a7791 to DT with a disabled
>> > status.
>> >
>> > Signed-off-by: Laurent Pinchart
>> > <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
>>
>> The addresses and interrupt numbers look OK to me.
>> However, my comment about the "0x800" offset is still valid.
>> Shouldn't we have two register blocks, and let the driver use only the
>> second one?
>>
>> If you ignore, feel free to add my
>> Acked-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
>
> I don't want to ignore your comment, but I don't know what to do here :-/ The
> datasheet lacks detailed information about secure vs. non-secure mode and how
> the two register sets are supposed to interoperate and be handled by the
> operating system.

When in doubt, the safest thing to do is "describe the hardware in DT".

The datasheet says there are two register sets of size 0x800, so IMHO we
should have both in DT. Whether the driver only uses the second bank due to
our limited understanding of the hardware is something different.
We can still fix the driver later, if needed.
Fixing the DT is, ... well... complicated ;-)

Following the rule "describe the hardware in DT", I would also add the second
interrupt (marked "SEC") for the DS0, MX, SY0, and GP IPMMU instances.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
