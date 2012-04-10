From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 00/10] vt-d irq_remap_ops patchset
Date: Tue, 10 Apr 2012 17:05:50 +0200
Message-ID: <20120410150550.GB2428@amd.com>
References: <1333133228-3134-1-git-send-email-suresh.b.siddha@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1333133228-3134-1-git-send-email-suresh.b.siddha-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Suresh Siddha <suresh.b.siddha-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

On Fri, Mar 30, 2012 at 11:46:58AM -0700, Suresh Siddha wrote:
> Ingo,
> 
> Here is the Joerg's irq_remap_ops patchset updated for the latest -tip.
> Simplified some of the naming conventions to follow the irq_remapping
> terminology. There are still some "if (irq_remapping_enabled)" checks in
> io_apic.c that I would like to roll into the new io_apic_ops. I will
> look into that shortly.
> 
> Joerg Roedel (8):
>   iommu: Rename intr_remapping files to intel_intr_remapping
>   iommu/vt-d: Make intr-remapping initialization generic
>   iommu/vt-d: Convert missing apic.c intr-remapping call to remap_ops
>   iommu/vt-d: Convert IR ioapic-setup to use remap_ops
>   iommu/vt-d: Convert IR set_affinity function to remap_ops
>   iommu/vt-d: Convert free_irte into a remap_ops callback
>   iommu/vt-d: Convert MSI remapping setup to remap_ops
>   x86, iommu/vt-d: Clean up interfaces for interrupt remapping
> 
> Suresh Siddha (2):
>   iommu: rename intr_remapping references to irq_remapping
>   iommu: rename intr_remapping.[ch] to irq_remapping.[ch]

Suresh, Yinghai, many thanks for testing this and pushing it forward. I
really appreciate it.

Ingo, Have these patches been applied to -tip or are there further
problems to be solved?


	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
