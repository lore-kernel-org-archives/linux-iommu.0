From: Christian Melki <christian.melki-VBSoEI6PWPXQT0dZR+AlfA@public.gmane.org>
Subject: Re: Fwd: SWIOTLB on 32-bit PAE.
Date: Mon, 5 Oct 2015 14:14:27 +0200
Message-ID: <561269A3.1030008@t2data.com>
References: <560E9007.1000604@t2data.com> <560E92A0.9030707@t2data.com>
	<20151003143630.GB17684@localhost>
	<20151003180007.GA4732@localhost.localdomain>
	<5612607B.2050208@t2data.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5612607B.2050208-VBSoEI6PWPXQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Never mind my ranting.
The problem was in the extent disk format of ext4. I had forgot that 
ext4 uses extents for all new files by default. Old grub won't read extents.

Oh, well... nothing like wasting hard working peoples time with stupid 
things. Anyway. SWIOTLB for 32-bit PAE should be a good thing though. :)

Regards,
Christian

On 10/05/2015 01:35 PM, Christian Melki wrote:
> Hi.
>
> I think I rang the bell a bit early. The corruption is in grub legacy (I
> assumed that would be in Linux too, but it wasn't). The on disk format
> of ext4 apparently stores byte ordering somehow? I thought the on disk
> format of ext4 was a specific endian (little). Since only that file is
> unreadable in grub, but readable in Linux.. I am guessing endian issues
> somehow.. which still is strange.
>
> Regards,
> Christian
>
> On 10/03/2015 08:00 PM, Konrad Rzeszutek Wilk wrote:
>> On Sat, Oct 03, 2015 at 09:36:30AM -0500, Bjorn Helgaas wrote:
>>> [+cc Konrad, Joerg, iommu list]
>>>
>>> On Fri, Oct 02, 2015 at 04:20:16PM +0200, Christian Melki wrote:
>>>> I discovered a strange error on my machine. 32-bit PAE 4.2.0 without
>>>> IOMMU code (yeah, I know).
>>>> When writing to an ext4 filesystem on a USB disk my kernel would hang
>>>> and not return control to userspace. It would spew kernel messages to
>>>> syslog as fast as it could without giving userspace any time, ie "hang"
>>>> as far as a user sees it. The device itself is ok and the filesystem is
>>>> clean.
>>>> I get messages like this, millions of them.
>>>>
>>>> Oct  2 14:33:06 voodoochild kernel: [  223.287447] nommu_map_sg:
>>>> overflow 25dcac000+1024 of device mask ffffffff
>>>> Oct  2 14:33:06 voodoochild kernel: [  223.287448] nommu_map_sg:
>>>> overflow 25dcac000+1024 of device mask ffffffff
>>>> Oct  2 14:33:06 voodoochild kernel: [  223.287449] nommu_map_sg:
>>>> overflow 25dcac000+1024 of device mask ffffffff
>>>>
>>>> I disovered that SWIOTLB was not on. It is only provided for 64-bit
>>>> machines where it is default. On 32-bit SWIOTLB seems disabled
>>>> unless you are running with some IOMMU/AGPGART code.
>>>>
>>>> But what about 32-bit PAE? Would that not qualify for SWIOTLB
>>>> without IOMMU?
>>
>> It most certainly would!
>>>>
>>>> I am a novice in this area. Maybe this is a Kconfig "bug" for us
>>>> that like to hang ourselves with CONFIG_* rope? :) I'd like to think
>>>> that SWIOTLB should be default for 32-bit PAE too?
>>
>> Aye. I presume that you had done a small change already for this?
>> Would you be willing to post it on lkml and CC me ?
>>
>> Thank you.
>>>>
>>>> Best regards,
>>>> Christian
>>>>
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
