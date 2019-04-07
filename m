From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: kernel BUG at drivers/iommu/intel-iommu.c:608
Date: Sun, 7 Apr 2019 17:31:32 -0600
Message-ID: <20190407173132.24032810@x1.home>
References: <a523ea10-3dab-fa2c-1ecf-5cf32077565f@acm.org>
	<20190407150650.060cc508@x1.home>
	<8d876549-21da-e027-0157-8737b10e26f8@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <8d876549-21da-e027-0157-8737b10e26f8-HInyCGIudOg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Bart Van Assche <bvanassche-HInyCGIudOg@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, James Smart <jsmart2021-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Sun, 7 Apr 2019 16:02:31 -0700
Bart Van Assche <bvanassche-HInyCGIudOg@public.gmane.org> wrote:

> On 4/7/19 2:06 PM, Alex Williamson wrote:
> > On Sun, 7 Apr 2019 12:10:38 -0700
> > Bart Van Assche <bvanassche-HInyCGIudOg@public.gmane.org> wrote:  
> >> If I tell qemu to use PCI pass-through for a PCI adapter and next load the
> >> lpfc driver for an lpfc adapter that has not been passed through to any VM
> >> a kernel bug is hit. Do you perhaps know whether it should be possible to
> >> a load kernel driver in this scenario? If so, do you know what should change
> >> to avoid that this kernel bug is hit? Should the iommu code be modified or
> >> should the lpfc code be modified? I'm asking you because I think that you
> >> introduced the BUG() statement that was hit. See also commit ab8dfe251571
> >> ("iommu/vt-d: Introduce helper functions to improve code readability"; v3.17).  
> > 
> > Do both of these lpfc devices belong to the same IOMMU group?
> > (/sys/kernel/iommu_groups/)  Thanks,  
> 
> Hi Alex,
> 
> Apparently the two Emulex (lpfc) and the two QLogic ports are in the same IOMMU group:
> 
> # lspci | grep -E 'QLogic|Emulex'
> 01:00.0 Fibre Channel: Emulex Corporation Lancer Gen6: LPe32000 Fibre Channel Host Adapter (rev 01)
> 01:00.1 Fibre Channel: Emulex Corporation Lancer Gen6: LPe32000 Fibre Channel Host Adapter (rev 01)
> 02:00.0 Fibre Channel: QLogic Corp. ISP2532-based 8Gb Fibre Channel to PCI Express HBA (rev 02)
> 02:00.1 Fibre Channel: QLogic Corp. ISP2532-based 8Gb Fibre Channel to PCI Express HBA (rev 02)
> 
> # ls -d /sys/kernel/iommu_groups/*/devices/0000:0[12]:00.*
> /sys/kernel/iommu_groups/1/devices/0000:01:00.0
> /sys/kernel/iommu_groups/1/devices/0000:01:00.1
> /sys/kernel/iommu_groups/1/devices/0000:02:00.0
> /sys/kernel/iommu_groups/1/devices/0000:02:00.1

It's not possible to do what you want with this configuration.  An IOMMU
group represents the smallest set of devices that are isolated from
other sets of devices and is also therefore the minimum granularity we
can assign devices to userspace (ex. QEMU).  The kernel reacts to
breaking the isolation of the group with a BUG_ON.  If you managed not
to hit the BUG_ON here, you'd hit the BUG_ON in vfio code when the loss
of isolation is detected there. IOMMU groups are formed at the highest
point in the topology which guarantees isolation.  This can be
indicated either via native PCIe ACS support or ACS-equivalent quirks
in the code.  If the root port provides neither of these, then all
devices downstream are grouped together as well as all peer root ports
in the same PCI slot and all devices downstream of those.  If a
multifunction endpoint does not provide ACS or equivalent quirks, the
functions will be grouped together. Not all endpoint devices or systems
are designed for minimum possible granularity.  You can learn more
here[1].  Thanks,

Alex

[1] http://vfio.blogspot.com/2014/08/iommu-groups-inside-and-out.html
