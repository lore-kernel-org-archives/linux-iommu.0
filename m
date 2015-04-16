From: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
Subject: Re: Error: DMA: Out of SW-IOMMU space [was: External USB drives
	become unresponsive after few hours.]
Date: Thu, 16 Apr 2015 19:54:58 +0530
Message-ID: <CAOHikRBADL3upuSgcdhnwzzQ+caS3vtF4POKYLaDofxoNKwK9A@mail.gmail.com>
References: <CAJ2095qWQ7S2W9i1NiM6C-0cM=wnceyA9n-0UVLygUXHJ7yxzA@mail.gmail.com>
	<Pine.LNX.4.44L0.1504161010370.1391-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1504161010370.1391-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dorian Gray <yourfavouritegod-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kernel development list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, 16 Apr 2015, Dorian Gray wrote:

> I have tested the following kernel versions:
> - 3.18.4, 3.18.6, 3.18.7, 3.19.4 [all affected]
> - 3.17.1 [unaffected]
> - 3.17.8 [probably the last unaffected version; I'm using it currently]
>
> Also, I've been using the very same configuration (hardware) along
> with 2.6.x, 3.2.x, 3.4.x, 3.10.x and have never encountered such a
> behavior before.
>
> And the problem is:
>
> When at least one external drive is plugged-in AND mounted, after ~2-4
> hours the following occurs (@11315.681561):
>
> [ 5570.110523] usb 2-1.2: new high-speed USB device number 5 using ehci-pci
> [ 5570.852917] usb 2-1.2: New USB device found, idVendor=1058, idProduct=0730
> [ 5570.852923] usb 2-1.2: New USB device strings: Mfr=1, Product=2,
> SerialNumber=3
> [ 5570.852927] usb 2-1.2: Product: My Passport 0730
> [ 5570.852930] usb 2-1.2: Manufacturer: Western Digital
> [ 5570.852933] usb 2-1.2: SerialNumber:
> [ 5570.853517] usb-storage 2-1.2:1.0: USB Mass Storage device detected
> [ 5570.853691] scsi host8: usb-storage 2-1.2:1.0
> [ 5572.932659] scsi 8:0:0:0: Direct-Access     WD       My Passport
> 0730 1012 PQ: 0 ANSI: 6
> [ 5572.933013] sd 8:0:0:0: Attached scsi generic sg5 type 0
> [ 5575.306801] scsi 8:0:0:1: Enclosure         WD       SES Device
>   1012 PQ: 0 ANSI: 6
> [ 5575.307160] sd 8:0:0:0: [sdc] 976707584 512-byte logical blocks:
> (500 GB/465 GiB)
> [ 5575.308405] sd 8:0:0:0: [sdc] Write Protect is off
> [ 5575.308416] sd 8:0:0:0: [sdc] Mode Sense: 47 00 10 08
> [ 5575.309772] sd 8:0:0:0: [sdc] No Caching mode page found
> [ 5575.309776] sd 8:0:0:0: [sdc] Assuming drive cache: write through
> [ 5575.311176] scsi 8:0:0:1: Attached scsi generic sg6 type 13
> [ 5575.328540]  sdc: sdc1
> [ 5575.331026] sd 8:0:0:0: [sdc] Attached SCSI disk
> [11315.681561] ehci-pci 0000:00:1d.0: swiotlb buffer is full (sz: 32768 bytes)
> [11315.681565] DMA: Out of SW-IOMMU space for 32768 bytes at device 0000:00:1d.0
> [11315.681874] ehci-pci 0000:00:1d.0: swiotlb buffer is full (sz: 32768 bytes)
> [11315.681876] DMA: Out of SW-IOMMU space for 32768 bytes at device 0000:00:1d.0
> [11315.682171] ehci-pci 0000:00:1d.0: swiotlb buffer is full (sz: 32768 bytes)
> [11315.682174] DMA: Out of SW-IOMMU space for 32768 bytes at device 0000:00:1d.0
> [...and so on...]

This appears to be a problem with the IOMMU or SWIOTLB subsystems, not
the USB subsystem.  I have CC'ed the appropriate mailing lists.

Try increasing the SWIOTLB size to 128MB .Default is 64MB.

Alan Stern

On Thu, Apr 16, 2015 at 7:45 PM, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> wrote:
> On Thu, 16 Apr 2015, Dorian Gray wrote:
>
>> I have tested the following kernel versions:
>> - 3.18.4, 3.18.6, 3.18.7, 3.19.4 [all affected]
>> - 3.17.1 [unaffected]
>> - 3.17.8 [probably the last unaffected version; I'm using it currently]
>>
>> Also, I've been using the very same configuration (hardware) along
>> with 2.6.x, 3.2.x, 3.4.x, 3.10.x and have never encountered such a
>> behavior before.
>>
>> And the problem is:
>>
>> When at least one external drive is plugged-in AND mounted, after ~2-4
>> hours the following occurs (@11315.681561):
>>
>> [ 5570.110523] usb 2-1.2: new high-speed USB device number 5 using ehci-pci
>> [ 5570.852917] usb 2-1.2: New USB device found, idVendor=1058, idProduct=0730
>> [ 5570.852923] usb 2-1.2: New USB device strings: Mfr=1, Product=2,
>> SerialNumber=3
>> [ 5570.852927] usb 2-1.2: Product: My Passport 0730
>> [ 5570.852930] usb 2-1.2: Manufacturer: Western Digital
>> [ 5570.852933] usb 2-1.2: SerialNumber:
>> [ 5570.853517] usb-storage 2-1.2:1.0: USB Mass Storage device detected
>> [ 5570.853691] scsi host8: usb-storage 2-1.2:1.0
>> [ 5572.932659] scsi 8:0:0:0: Direct-Access     WD       My Passport
>> 0730 1012 PQ: 0 ANSI: 6
>> [ 5572.933013] sd 8:0:0:0: Attached scsi generic sg5 type 0
>> [ 5575.306801] scsi 8:0:0:1: Enclosure         WD       SES Device
>>   1012 PQ: 0 ANSI: 6
>> [ 5575.307160] sd 8:0:0:0: [sdc] 976707584 512-byte logical blocks:
>> (500 GB/465 GiB)
>> [ 5575.308405] sd 8:0:0:0: [sdc] Write Protect is off
>> [ 5575.308416] sd 8:0:0:0: [sdc] Mode Sense: 47 00 10 08
>> [ 5575.309772] sd 8:0:0:0: [sdc] No Caching mode page found
>> [ 5575.309776] sd 8:0:0:0: [sdc] Assuming drive cache: write through
>> [ 5575.311176] scsi 8:0:0:1: Attached scsi generic sg6 type 13
>> [ 5575.328540]  sdc: sdc1
>> [ 5575.331026] sd 8:0:0:0: [sdc] Attached SCSI disk
>> [11315.681561] ehci-pci 0000:00:1d.0: swiotlb buffer is full (sz: 32768 bytes)
>> [11315.681565] DMA: Out of SW-IOMMU space for 32768 bytes at device 0000:00:1d.0
>> [11315.681874] ehci-pci 0000:00:1d.0: swiotlb buffer is full (sz: 32768 bytes)
>> [11315.681876] DMA: Out of SW-IOMMU space for 32768 bytes at device 0000:00:1d.0
>> [11315.682171] ehci-pci 0000:00:1d.0: swiotlb buffer is full (sz: 32768 bytes)
>> [11315.682174] DMA: Out of SW-IOMMU space for 32768 bytes at device 0000:00:1d.0
>> [...and so on...]
>
> This appears to be a problem with the IOMMU or SWIOTLB subsystems, not
> the USB subsystem.  I have CC'ed the appropriate mailing lists.
>
> Alan Stern
>
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



-- 
Thanks,
with regards,
Suman Tripathi
