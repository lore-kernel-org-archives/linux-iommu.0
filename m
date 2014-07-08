From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iommu: Fix IOMMU sysfs stubs
Date: Tue, 8 Jul 2014 10:05:52 +0200
Message-ID: <20140708080552.GG1958@8bytes.org>
References: <20140707203054.28174.58508.stgit@gimli.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140707203054.28174.58508.stgit-GCcqpEzw8uZBDLzU/O5InQ@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Jul 07, 2014 at 02:31:36PM -0600, Alex Williamson wrote:
> 0-day kernel build testing reports:
> 
>    arch/x86/kvm/x86.o: In function `iommu_device_destroy':
> >> (.text+0x7a0a): multiple definition of `iommu_device_destroy'
>    arch/x86/kvm/../../../virt/kvm/vfio.o:vfio.c:(.text+0x490): first defined here
>    arch/x86/kvm/x86.o: In function `iommu_device_link':
> >> (.text+0x7a15): multiple definition of `iommu_device_link'
>    arch/x86/kvm/../../../virt/kvm/vfio.o:vfio.c:(.text+0x49b): first defined here
>    arch/x86/kvm/x86.o: In function `iommu_device_unlink':
> >> (.text+0x7a25): multiple definition of `iommu_device_unlink'
>    arch/x86/kvm/../../../virt/kvm/vfio.o:vfio.c:(.text+0x4ab): first defined here
>    arch/x86/kvm/x86.o: In function `iommu_device_create':
> >> (.text+0x79f8): multiple definition of `iommu_device_create'
>    arch/x86/kvm/../../../virt/kvm/vfio.o:vfio.c:(.text+0x47e): first defined here
> 
> These are due to failing to define the stubs as static inline.  Fix.
> 
> Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Applied, thanks.
