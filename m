From: Lutz Vieweg <lvml@5t9.de>
Subject: Re: AMD-Vi: Event logged IO_PAGE_FAULT - ixgbe
 Detected Tx Unit Hang - Reset adapter - master disable timed out
Date: Thu, 09 Jun 2016 18:57:45 +0200
Message-ID: <5759A009.8040200@5t9.de>
References: <loom.20160606T232112-817@post.gmane.org>	<CAKgT0UfEGS_QzM1phGKRV1hDgcnAwX-BqMkyQ6KJUOv82_kCiA@mail.gmail.com>	<nj64hf$9v5$1@ger.gmane.org>	<CAKgT0UfKUkrsXqLm4KdjXgLZ6QXZp5Rf-yYA3pBSzc1=ghJ4CQ@mail.gmail.com>	<njbvjb$40r$1@ger.gmane.org>
	<CAKgT0UeFM1jYTU83YFohxUHWuJeTYfWDpdFM2CDQCutmf_vXvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <e1000-devel-bounces@lists.sourceforge.net>
In-Reply-To: <CAKgT0UeFM1jYTU83YFohxUHWuJeTYfWDpdFM2CDQCutmf_vXvA@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/e1000-devel>,
	<mailto:e1000-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=e1000-devel>
List-Post: <mailto:e1000-devel@lists.sourceforge.net>
List-Help: <mailto:e1000-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/e1000-devel>,
	<mailto:e1000-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: e1000-devel-bounces@lists.sourceforge.net
To: e1000-devel@lists.sourceforge.net
Cc: iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On 06/09/2016 06:03 PM, Alexander Duyck wrote:
>> This time I'll reboot the machine, and also try "iommu=pt" as suggested
>> in different places for use with 10G NICs.
>
> That might be a good place to start.
>
> I'm adding, or at least attempting to, the mailing list and maintainer
> for the IOMMU code.  You might want to check with the AMD-Vi IOMMU
> maintainers to see if they have any other advice as this seems like
> something that may have been introduced with changes to the IOMMU as
> the ixgbe driver hasn't had any updates to the DMA mapping/unmapping
> code in some time and it was working in the 4.4 kernel series and
> still works on my system which runs an Intel IOMMU so I am wondering
> if this may be something specifically related to changes in the AMD
> IOMMU code.

After having rebooted the system with "iommu=pt", the following change
of dmesg-output looks curious to me:

Without "iommu=pt":
> [    4.869591] iommu: Adding device 0000:04:00.0 to group 13
...
> [    4.873105] AMD-Vi: Found IOMMU at 0000:00:00.2 cap 0x40
> [    4.873347] AMD-Vi: Found IOMMU at 0000:40:00.2 cap 0x40
> [    4.873586] AMD-Vi: Interrupt remapping enabled
> [    4.874108] AMD-Vi: Lazy IO/TLB flushing enabled

With "iommu=pt":
> [    4.832580] iommu: Adding device 0000:04:00.0 to group 13
> [    4.832838] iommu: Using direct mapping for device 0000:04:00.0
...
> [    4.837074] AMD-Vi: Found IOMMU at 0000:00:00.2 cap 0x40
> [    4.837305] AMD-Vi: Found IOMMU at 0000:40:00.2 cap 0x40
> [    4.837535] AMD-Vi: Interrupt remapping enabled
> [    4.838062] AMD-Vi: Lazy IO/TLB flushing enabled
> [    4.838291] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> [    4.838533] software IO TLB [mem 0xd3e80000-0xd7e80000] (64MB) mapped at [ffff8800d3e80000-ffff8800d7e7ffff]

I hope that doesn't mean all my network data is now passing through
an additional copy-by-CPU... that would be kind of the opposite of what
"iommu=pt" seemed to promise :-)

One more thing I find curious, but this didn't change with "iommu=pt":
> [    0.000000] AGP: Checking aperture...
> [    0.000000] AGP: No AGP bridge found
> [    0.000000] AGP: Node 0: aperture [bus addr 0x00000000-0x01ffffff] (32MB)
> [    0.000000] AGP: Your BIOS doesn't leave an aperture memory hole
> [    0.000000] AGP: Please enable the IOMMU option in the BIOS setup
> [    0.000000] AGP: This costs you 64MB of RAM
> [    0.000000] AGP: Mapping aperture over RAM [mem 0xcc000000-0xcfffffff] (65536KB)
I checked and the IOMMU-option is definitely enabled in the BIOS setup.
So I assume right that these message are irrelevant (since AGP as a whole
is irrelevant on this server)?

Regards,

Lutz Vieweg



------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity 
planning reports. https://ad.doubleclick.net/ddm/clk/305295220;132659582;e
_______________________________________________
E1000-devel mailing list
E1000-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/e1000-devel
To learn more about Intel&#174; Ethernet, visit http://communities.intel.com/community/wired
