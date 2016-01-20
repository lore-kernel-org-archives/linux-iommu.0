From: Mark Hounschell <markh-n2QNKt385d+sTnJN9+BGXg@public.gmane.org>
Subject: Re: Can't boot new 4.4 kernel with IOMMU enabled
Date: Wed, 20 Jan 2016 10:56:57 -0500
Message-ID: <569FAE49.9050405@compro.net>
References: <56957209.1080202@compro.net>
	<20160113030950.GB11902@dhcp-128-28.nay.redhat.com>
	<56966244.80700@compro.net> <20160114000520.GA2449@x1.redhat.com>
	<5697AAD8.1000105@compro.net> <20160120153823.GG18805@8bytes.org>
Reply-To: markh-n2QNKt385d+sTnJN9+BGXg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160120153823.GG18805-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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

On 01/20/2016 10:38 AM, Joerg Roedel wrote:
> On Thu, Jan 14, 2016 at 09:04:08AM -0500, Mark Hounschell wrote:
>> OK, I verified the 2 disks are hanging off the Marvel chips.
>> Here is the dmesg from booting with your patch and the 2
>> disks not showing up.
>
> Does it boot with iommu=soft?
>

Yes. It does boot with  iommu=soft

>> These appear to be the 2 failing disks
>> #dmesg | grep -i fail
>> [    1.899572] ata8.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
>> [    6.898365] ata7.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
>> [    7.369344] ata8.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
>> [   12.363887] ata7.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
>> [   12.842392] ata8.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
>> [   17.836405] ata7.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
>
> The err_mask indicates that the device fetched an invalid command, so
> likely it read some garbage from memory it shouldn't read it from.
> Unfortunatly there are no IO_PAGE_FAULTs which could give us any clue.
>
>> Here are the pci-ids of the Marvel chips
>> #lspci | grep -i marvel
>> 07:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9172 SATA 6Gb/s Controller (rev 12)
>> 13:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9172 SATA 6Gb/s Controller (rev 12)
>
> Your disks seem to be connected to the SATA controler at 13:00.0, which
> is in an iommu group with devices 00:15.*, 00:11.0 and 00:12.0.
>
> For testing you could try to connect the disks to the SATA controler at
> 07:00.0. This one is alone in its group.
>

That one must be the 2 external sata ports. I can't easily connect to 
them as I have no external sata drives.

> Otherwise it would be good if you could bisect the issue to find the
> broken commit.
>

I can do this if there is no other option for me.

Mark
