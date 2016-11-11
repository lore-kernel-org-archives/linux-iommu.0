From: Don Dutile <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Summary of LPC guest MSI discussion in Santa Fe
Date: Fri, 11 Nov 2016 11:25:25 -0500
Message-ID: <5825F0F5.3070001@redhat.com>
References: <20161109151709.74927f83@t450s.home>
	<20161109222522.GS17771@arm.com> <20161109162458.39594fdb@t450s.home>
	<20161109233847.GT17771@arm.com> <20161109165957.62c1eb61@t450s.home>
	<83b6440a-31eb-c1b4-642c-a4c311f37ef2@redhat.com>
	<20161109175517.174e7803@t450s.home> <20161110020130.GA19108@arm.com>
	<ddd8af9d-ad8f-78d8-3048-3d640b74470e@redhat.com>
	<20161110104601.0939ba9a@t450s.home> <20161111111944.GO2078@8bytes.org>
	<20161111085056.4cf8989d@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20161111085056.4cf8989d-1yVPhWWZRC1BDLzU/O5InQ@public.gmane.org>
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
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, dwmw-vV1OtcyAfmbQXOPxS62xeg@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, Christoffer Dall <christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 11/11/2016 10:50 AM, Alex Williamson wrote:
> On Fri, 11 Nov 2016 12:19:44 +0100
> Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
>
>> On Thu, Nov 10, 2016 at 10:46:01AM -0700, Alex Williamson wrote:
>>> In the case of x86, we know that DMA mappings overlapping the MSI
>>> doorbells won't be translated correctly, it's not a valid mapping for
>>> that range, and therefore the iommu driver backing the IOMMU API
>>> should describe that reserved range and reject mappings to it.
>>
>> The drivers actually allow mappings to the MSI region via the IOMMU-API,
>> and I think it should stay this way also for other reserved ranges.
>> Address space management is done by the IOMMU-API user already (and has
>> to be done there nowadays), be it a DMA-API implementation which just
>> reserves these regions in its address space allocator or be it VFIO with
>> QEMU, which don't map RAM there anyway. So there is no point of checking
>> this again in the IOMMU drivers and we can keep that out of the
>> mapping/unmapping fast-path.
>
> It's really just a happenstance that we don't map RAM over the x86 MSI
> range though.  That property really can't be guaranteed once we mix
> architectures, such as running an aarch64 VM on x86 host via TCG.
> AIUI, the MSI range is actually handled differently than other DMA
> ranges, so a iommu_map() overlapping a range that the iommu cannot map
> should fail just like an attempt to map beyond the address width of the
> iommu.
>
+1. As was stated at Plumbers, x86 MSI is in a fixed, hw location, so:
1) that memory space is never a valid page to the system to be used for IOVA,
    therefore, nothing to micro-manage in the iommu mapping (fast) path.
2) migration btwn different systems isn't an issue b/c all x86 systems have this mapping.
3) ACS resolves DMA writes to mem going to a device(-mmio space).

For aarch64, without such a 'fixed' MSI location, whatever hole/used-space-struct
concept that is contrived for MSI (DMA) writes on aarch64 won't guarantee migration
failure across mixed aarch64 systems (migrate guest-G from sys-vendor-A to
sys-vendor-B; sys-vendor-A has MSI at addr-A; sys-vendor-B has MSI at addr-B).
Without agreement, migration only possilbe across the same systems (can even
be broken btwn two sytems from same vendor).  ACS in the PCIe path handles
the iova->dev-mmio collision problem. q.e.d.

ergo, my proposal to put MSI space as the upper-most, space of any system....
FFFF.FFFF.FFFE0.0000 ... and hw drops the upper 1's/F's, and uses that for MSI.
Allows it to vary on each system based on max-memory.  pseudo-fixed, but not
right smack in the middle of mem-space.

There is an inverse scenario for host phys addr's as well:
     Wiring the upper-most bit of HPA to be 1==mmio, 0=mem simplifies a lot of
     design issues in the cores & chipsets as well.  Alpha-EV6, case in point
     (18+ yr old design decision). another q.e.d.

I hate to admit it, but jcm has it right wrt 'fixed sys addr map', at least in this IO area.


>>> For PCI devices userspace can examine the topology of the iommu group
>>> and exclude MMIO ranges of peer devices based on the BARs, which are
>>> exposed in various places, pci-sysfs as well as /proc/iomem.  For
>>> non-PCI or MSI controllers... ???
>>
>> Right, the hardware resources can be examined. But maybe this can be
>> extended to also cover RMRR ranges? Then we would be able to assign
>> devices with RMRR mappings to guests.
>
> RMRRs are special in a different way, the VT-d spec requires that the
> OS honor RMRRs, the user has no responsibility (and currently no
> visibility) to make that same arrangement.  In order to potentially
> protect the physical host platform, the iommu drivers should prevent a
> user from remapping RMRRS.  Maybe there needs to be a different
> interface used by untrusted users vs in-kernel drivers, but I think the
> kernel really needs to be defensive in the case of user mappings, which
> is where the IOMMU API is rooted.  Thanks,
>
> Alex
>
