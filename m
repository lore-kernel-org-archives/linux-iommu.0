From: Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V4 0/4] Code refine for Intel IOMMU
Date: Mon, 9 May 2016 22:20:59 +0000
Message-ID: <20160509222059.GA21601@vultr.guest>
References: <1460645710-22656-1-git-send-email-richard.weiyang@gmail.com>
	<20160508132253.GA2708@vultr.guest>
	<20160509112401.GC13275@8bytes.org>
Reply-To: Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160509112401.GC13275-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, May 09, 2016 at 01:24:02PM +0200, Joerg Roedel wrote:
>On Sun, May 08, 2016 at 01:22:53PM +0000, Wei Yang wrote:
>> >Wei Yang (4):
>> >  iommu/vt-d: replace *hdr with {drhd/atsr}[0] in struct
>> >    dmar_{drhd/atsr}_unit
>> >  iommu/vt-d: use zero-sized array in DMAR related ACPI structures
>> >  iommu/vt-d: check Register Base Address at the beginning of
>> >    dmar_parse_one_drhd()
>> >  iommu/vt-d: refine dmar_acpi_dev_scope_init() with
>> >    dmar_walk_dmar_table()
>
>Okay, I've ignored this so far as I don't see where you are going with
>this refactoring. The patches as-is don't make much sense to me other
>than creating conflicts with other vt-d driver changes.
>

Hi, Joerg

Thanks for your comments. 

Generally, the purpose of these patches is to make the code more audience
friendly. Below is my thoughts for each patch.

For Patch 1, the zero-sized drhd/atsr would save some space in
dmar_{drhd/atsr}_unit. As in the change log explained, before commit
<6b1972493a84> ("iommu/vt-d: Implement DMAR unit hotplug framework"), it is
necessary to have a pointer. While after this commit, we just need a place
holder.

For Patch 2, I add a zero-sized array at the end of related structures to
represent variable length elements. By doing so, our code could use this field
to be a parameter for a function instead of casting and add 1. I think this
would let audience understand the variable elements is used here instead of go
through SPEC to check which part it means, which is not that reader friendly.

For Patch 3, when you go through the code, Register Base Address will be
checked to see whether this is a valid dmar. Since this is what we have to do,
I move this step a little bit ahead, so that we can avoid related setups at
the first place.

For Patch 4, dmar_acpi_dev_scope_init() initialize dev_scope by iterate on the
remapping structure. We can see this is just what dmar_walk_dmar_table() does.
So I reuse the code in this place.

In my mind, those changes are dmar internal changes, which will not be seen
outside. Would you mind pointing me the conflicts you saw? Maybe I missed some
thing :-)

Thanks, have a good day.

>
>
>	Joerg

-- 
Wei Yang
Help you, Help me
