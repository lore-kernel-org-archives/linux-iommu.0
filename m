From: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/5] AMD IOMMU Fixes for v4.2-rc4
Date: Thu, 30 Jul 2015 13:12:29 +0300
Message-ID: <CAFCwf11rB_VsmXQmJDumUNf_1y=i5KsMM6dPBSrk3BV=Enna7w@mail.gmail.com>
References: <1438095531-26777-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1438095531-26777-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jul 28, 2015 at 5:58 PM, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
> Hi,
>
> here are a couple of fixes for the AMD IOMMU driver for
> issues found recently. The issues were introduced by the
> default-domain conversion in this development cycle. I plan
> to send these fixes upstream by the end of the week.
>
> Please review!
>
> Thanks,
>
>         Joerg
>
> Joerg Roedel (5):
>   iommu/amd: Use iommu_attach_group()
>   iommu/amd: Use iommu core for passthrough mode
>   iommu/amd: Allow non-IOMMUv2 devices in IOMMUv2 domains
>   iommu/amd: Use swiotlb in passthrough mode
>   iommu/amd: Set global dma_ops if swiotlb is disabled
>
>  drivers/iommu/amd_iommu.c      | 91 +++++++++++-------------------------------
>  drivers/iommu/amd_iommu_init.c | 10 +----
>  drivers/iommu/amd_iommu_v2.c   | 24 +++++++++--
>  3 files changed, 45 insertions(+), 80 deletions(-)
>
> --
> 1.9.1
>
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

This series, with the additional patch, is:
Tested-by: "Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>"
