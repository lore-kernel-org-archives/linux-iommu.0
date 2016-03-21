From: Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Patch V2 1/4] iommu/vt-d: replace *hdr with hdr[0] in struct
	dmar_drhd_unit
Date: Mon, 21 Mar 2016 14:46:46 +0000
Message-ID: <20160321144646.GA12947@vultr.guest>
References: <1458482251-7939-1-git-send-email-richard.weiyang@gmail.com>
	<1458482251-7939-2-git-send-email-richard.weiyang@gmail.com>
	<alpine.DEB.2.11.1603201631280.3978@nanos>
Reply-To: Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1603201631280.3978@nanos>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi, Thomas

Glad to receive your comment. Please see my reply below.

On Sun, Mar 20, 2016 at 04:42:29PM +0100, Thomas Gleixner wrote:
>On Sun, 20 Mar 2016, Wei Yang wrote:
>
>> hdr in struct dmar_drhd_unit is used to point the DMAR hardware unit copied
>> at the end of struct dmar_drhd_unit. One zero-sized array may be more
>> elegant for this purpose.
>
>You forget to tell why. 
> 

One possible benefit is to save some space.

Before commit 6b1972493a84 "iommu/vt-d: Implement DMAR unit hotplug framework",
dmaru->hdr just points to the memory region of DMA remapping hardware
definition. In this case, it would have no difference to where we put hdr.

After this commit, DMA remapping hardware definition is copied and
attach to the end of dmaru structure. By replacing a pointer with a zero-sized
array, that would save some space for this structure.

>> This patch replace *hdr with hdr[0] in struct dmar_drhd_unit.
>> 
>> Besides this, this patch includes other two changes:
>> 1. remove unnecessary type cast in dmar_table_detect()
>
>Again. Why is it not necessary?
>

The second parameter's type of function acpi_get_table_with_size() is "struct
acpi_table_header **", and type of dmar_tbl is "struct acpi_table_header *".

So without the type cast, the type of parameter and the function definition
matches.

That's why I want to remove it.

>> 2. type cast from acpi_dmar_header to acpi_dmar_hardware_unit directly
>
>Don't even think about doing that. container_of() is there for a reason.
>
>Your change works today, because the embedded structure is the first one in
>the containing structure. If the containing structure gets reordered later,
>the whole thing will explode in hard to debug ways.
>
>Even if such a reordering is unlikely in that ACPI case, we just don't do
>that. It's bad and sloppy coding style. The generated code is the same.
>

Yes, I agree with you that make this change should be very careful, while I
think the original usage of container_of() is not necessary.

Literally, it converts "struct acpi_dmar_header" to "struct
acpi_dmar_hardware_unit", because the first one is an element "header" of the
second one. While let's look at how the dmaru->hdr is initialized in
dmar_parse_one_drhd(), we copy the memory of "struct acpi_dmar_hardware_unit"
to a region where dmaru->hdr points to. So the code itself implies "struct
acpi_dmar_header" is the first element of "struct acpi_dmar_hardware_unit".
Otherwise, we can't do this memcpy in dmar_parse_one_drhd().

BTW, I am thinking changing the type of dmaru->hdr from "struct
acpi_dmar_header *" to "struct acpi_dmar_hardware_unit *". By doing so the
code would be more self explain, and it doesn't need to cast back and forth.

Thanks again for your review, have a good day~

>Thanks,
>
>	tglx

-- 
Wei Yang
Help you, Help me
