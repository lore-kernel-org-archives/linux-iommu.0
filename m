From: Bart Van Assche <bvanassche-HInyCGIudOg@public.gmane.org>
Subject: Re: kernel BUG at drivers/iommu/intel-iommu.c:608
Date: Sun, 7 Apr 2019 16:02:31 -0700
Message-ID: <8d876549-21da-e027-0157-8737b10e26f8@acm.org>
References: <a523ea10-3dab-fa2c-1ecf-5cf32077565f@acm.org>
	<20190407150650.060cc508@x1.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190407150650.060cc508-hfcDOgR9qeA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, James Smart <jsmart2021-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 4/7/19 2:06 PM, Alex Williamson wrote:
> On Sun, 7 Apr 2019 12:10:38 -0700
> Bart Van Assche <bvanassche-HInyCGIudOg@public.gmane.org> wrote:
>> If I tell qemu to use PCI pass-through for a PCI adapter and next load the
>> lpfc driver for an lpfc adapter that has not been passed through to any VM
>> a kernel bug is hit. Do you perhaps know whether it should be possible to
>> a load kernel driver in this scenario? If so, do you know what should change
>> to avoid that this kernel bug is hit? Should the iommu code be modified or
>> should the lpfc code be modified? I'm asking you because I think that you
>> introduced the BUG() statement that was hit. See also commit ab8dfe251571
>> ("iommu/vt-d: Introduce helper functions to improve code readability"; v3.17).
> 
> Do both of these lpfc devices belong to the same IOMMU group?
> (/sys/kernel/iommu_groups/)  Thanks,

Hi Alex,

Apparently the two Emulex (lpfc) and the two QLogic ports are in the same IOMMU group:

# lspci | grep -E 'QLogic|Emulex'
01:00.0 Fibre Channel: Emulex Corporation Lancer Gen6: LPe32000 Fibre Channel Host Adapter (rev 01)
01:00.1 Fibre Channel: Emulex Corporation Lancer Gen6: LPe32000 Fibre Channel Host Adapter (rev 01)
02:00.0 Fibre Channel: QLogic Corp. ISP2532-based 8Gb Fibre Channel to PCI Express HBA (rev 02)
02:00.1 Fibre Channel: QLogic Corp. ISP2532-based 8Gb Fibre Channel to PCI Express HBA (rev 02)

# ls -d /sys/kernel/iommu_groups/*/devices/0000:0[12]:00.*
/sys/kernel/iommu_groups/1/devices/0000:01:00.0
/sys/kernel/iommu_groups/1/devices/0000:01:00.1
/sys/kernel/iommu_groups/1/devices/0000:02:00.0
/sys/kernel/iommu_groups/1/devices/0000:02:00.1

Thanks,

Bart.
