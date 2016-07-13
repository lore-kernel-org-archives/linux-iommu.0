From: Linda Knippers <linda.knippers-ZPxbGqLxI0U@public.gmane.org>
Subject: Re: IOMMU+DMAR causing NMIs-s
Date: Wed, 13 Jul 2016 11:13:59 -0400
Message-ID: <1a4c4b65-c716-08a5-af89-1b0f551024ed@hpe.com>
References: <alpine.LRH.2.20.1607121525060.2088@math.ut.ee>
	<5630546.0MIYeGNSYG@vostro.rjw.lan>
	<alpine.LRH.2.20.1607121654490.2088@math.ut.ee>
	<alpine.LRH.2.20.1607130855210.11080@math.ut.ee>
	<20160713081817.GJ12639@8bytes.org>
	<alpine.LRH.2.20.1607131122010.20366@math.ut.ee>
	<20160713090332.GK12639@8bytes.org>
	<alpine.LRH.2.20.1607131239410.20366@math.ut.ee>
	<20160713094917.GM12639@8bytes.org>
	<alpine.LRH.2.20.1607131257390.20366@math.ut.ee>
	<20160713101859.GO12639@8bytes.org>
	<20160713084830.09453584@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160713084830.09453584-1yVPhWWZRC1BDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Meelis Roos <mroos-Y27EyoLml9s@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Linux Kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



On 7/13/2016 10:48 AM, Alex Williamson wrote:
> On Wed, 13 Jul 2016 12:18:59 +0200
> Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
> 
>> On Wed, Jul 13, 2016 at 12:58:24PM +0300, Meelis Roos wrote:
>>>>> Just got http://kodu.ut.ee/~mroos/4.6-dmar-fault2.png when playing with 
>>>>> BIOS settings (disabling NUMA). It is the first time I see at least some 
>>>>> info in NMI decode.  
>>>>
>>>> This looks interesting. Can you please post output of 'lspci -vvv' and
>>>> 'lspci -t'?  
>>>
>>> Here.  
>>
>> Thanks. So device 00:1e.0 is a PCI-bridge which has some 32-bit
>> PCI-devices behind it. One of these devices tries to read address
>> 0xb000, which is blocked by the IOMMU and causes the fault seen in the
>> screen-shot. The fault also causes a PCI-error which is then reported
>> through the NMI, causing your kernel panic.
>>
>> So the 32bit PCI devices behind the bridge are:
>>
>> 01:03.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] ES1000 (rev 02) (prog-if 00 [VGA controller])
>> 01:04.0 System peripheral: Compaq Computer Corporation Integrated Lights Out Controller (rev 03)
>> 01:04.2 System peripheral: Compaq Computer Corporation Integrated Lights Out  Processor (rev 03)
>> 01:04.4 USB controller: Hewlett-Packard Company Integrated Lights-Out Standard Virtual USB Controller (prog-if 00 [UHCI])
>> 01:04.6 IPMI SMIC interface: Hewlett-Packard Company Integrated Lights-Out Standard KCS Interface (prog-if 01)
>>
>> Can you try to disable this 'Lights Out' processor? Maybe it is causing
>> the issues. On the other side, the radeon driver for the ATI card is
>> also know for causing faults from time to time. Can you capture the
>> kernel messages right before a crash too?
> 
> IIRC, blacklisting the hpwdt module can defuse those NMIs and might
> help us see more of the actual DMAR faults.  Blacklist in modprobe.d
> and rebuild initrd. Thanks,
> 
> Alex
> 
> PS - never assume BIOS release notes are actually complete

I agree. I'd do the BIOS update and also make sure the iLO FW is current.

-- ljk
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
