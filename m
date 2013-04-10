From: Shuah Khan <shuahkhan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/9] AMD IOMMU cleanups, fixes and IVRS bug workarounds
Date: Wed, 10 Apr 2013 10:06:02 -0600
Message-ID: <CAKocOOP5tMsDLS8Wotu0kMNjSVJpN+pPhE9zj+n9ZKS9EcVR+A@mail.gmail.com>
References: <1365538384-12426-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1365538384-12426-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 9, 2013 at 2:12 PM, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
> Hi,
>
> this patch-set contains some cleanups and patches for the
> AMD IOMM driver. The most important part is a workaround
> that can be used to get interrupt remapping working even the
> the IVRS table provided by the BIOS is broken.
>
>
>         Joerg
>
> Joerg Roedel (9):
>   iommu/amd: Remove map_sg_no_iommu()
>   iommu/amd: Use AMD specific data structure for irq remapping
>   iommu/amd: Properly initialize irq-table lock
>   iommu/amd: Move add_special_device() to __init
>   iommu/amd: Extend IVRS special device data structure
>   iommu/amd: Add early maps for ioapic and hpet
>   iommu/amd: Add ioapic and hpet ivrs override
>   iommu/amd: Don't report firmware bugs with cmd-line ivrs overrides
>   iommu/amd: Document ivrs_ioapic and ivrs_hpet parameters
>
>  Documentation/kernel-parameters.txt |   14 ++++
>  drivers/iommu/amd_iommu.c           |   79 +++++++-----------
>  drivers/iommu/amd_iommu_init.c      |  151 +++++++++++++++++++++++++++++++----
>  drivers/iommu/amd_iommu_types.h     |    1 +
>  4 files changed, 182 insertions(+), 63 deletions(-)
>

Joerg,

Reviewed all the patches in this set. No longer have access to test machine. :(

Reviewed-by: Shuah Khan <shuahkhan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

-- Shuah
