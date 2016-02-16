From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: DMAR error messages after 'shutdown -r'.
Date: Tue, 16 Feb 2016 17:47:45 +0100
Message-ID: <20160216164745.GZ18805@8bytes.org>
References: <38172.1455047940@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <38172.1455047940-+bZmOdGhbsPr6rcHtW+onFJE71vCis6O@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Valdis Kletnieks <Valdis.Kletnieks-PjAqaU27lzQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Feb 09, 2016 at 02:59:00PM -0500, Valdis Kletnieks wrote:
> [    0.027629] Freeing SMP alternatives memory: 28K (ffffffff8e111000 - ffffffff8e118000)
> [    0.048199] ftrace: allocating 31090 entries in 122 pages
> [    0.061837] DMAR: Host address width 36
> [    0.061841] DMAR: DRHD base: 0x000000fed90000 flags: 0x1
> [    0.061894] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap c9008020660262 ecap f0105a
> [    0.061896] DMAR: RMRR base: 0x000000cdb11000 end: 0x000000cdb30fff
> [    0.061899] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed90000 IOMMU 0
> [    0.061901] DMAR-IR: HPET id 0 under DRHD base 0xfed90000
> [    0.061903] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
> ---- Error here....
> [    0.062027] DMAR: DRHD: handling fault status reg 2
> [    0.062034] DMAR: DMAR:[DMA Read] Request device [00:1f.2] fault addr cdacd000
>                DMAR:[fault reason 06] PTE Read access is not set
> ----

This is probably from a missing RMRR entry for device 00:1f.2. Can you
please post full dmesg after boot?

Thanks,

	Joerg
