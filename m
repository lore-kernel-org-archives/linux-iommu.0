From: Manfred Schwarb <manfred99-OI3hZJvNYWs@public.gmane.org>
Subject: Re: [PATCH] iommu/amd: Add quirk for broken Marvell 88SE91xx SATA
Date: Fri, 02 Aug 2013 11:29:44 +0200
Message-ID: <51FB7C08.40708@gmx.ch>
References: <519A93F0.8070606@gmx.ch> <20130521203526.GE7424@8bytes.org>
	<51D3E691.8030307@gmx.ch> <20130730113659.GJ28811@8bytes.org>
	<51F92832.2070102@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <51F92832.2070102-OI3hZJvNYWs@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Am 31.07.2013 17:07, schrieb Manfred Schwarb:
>
> Thanks, Joerg!
>
> Am 30.07.2013 13:37, schrieb Joerg Roedel:
>> Hi Manfred,
>>
>> On Wed, Jul 03, 2013 at 10:53:37AM +0200, Manfred Schwarb wrote:
>>>> I will look into the best way to port this to the AMD IOMMU driver. Will
>>>> send you a patch for testing when I have somthing.
>>>>
>>>
>>> Any news on this? Had you time to look at this issue?
>>
>> Can you test the attached patch please? It applies to v3.11-rc3. I
>> compiled and boot-tested it, but I don't have a broken Marvell
>> controller myself, so not sure if the patch works.
>>
>
> I tried this patch with 3.11-rc3 on opensuse 12.1, doing an "make oldconfig"
> and choosing defaults for the new items.
> This linux version seems to have some issues with my somewhat ancient user
> space, boot hangs quite early without any special messages (independent of
> iommu settings). However, in the "failsafe" mode I was able to boot.
>
> When turning on iommu support in BIOS, I got a timeout at fsck/mount time
> for the second disk on the Marvell controller. The first one did work
> straight on. Then I got to the rescue prompt, where I did a "mount -a", and
> hey, also the second disk started working, I could read and write to this
> disk also.
>
> Things seem to work halfway therefore. The timeout for the second attached
> disk is repeatable. When doing the "mount -a", first some kernel boot messages
> appeared, as if this command unblocked some unfinished disk initialization
> or so.


Sorry, I completely goofed my testing, my apology.
I thought both disks I looked at were hanging on the builtin Marvell 88SE9172,
but one disk is attached to a Marvell 88SE9123 PCIe card.

So the picture is much clearer now:

The disk hanging on the Marvell 88SE9123 PCIe card gives without the patch
   ata14.00 failed to IDENTIFY(I/O Error, err_mask=0x4)
With the patch, this controller works flawless.

The disk hanging on the built-in Marvell 88SE9172 (soldered on the mainboard)
gives with and without the patch
   ata20.00 failed to IDENTIFY(INIT_DEV_PARAMS failed, err_mask=0x80)

So the patch works for my PCIe card, but not for my mainboard controller.

HTH,
Manfred


BTW, I also backported this patch to linux 3.1.10, same result, PCIe card
works, mainboard controller does not.
