From: tedheadster <tedheadster-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] x86: enable swiotlb for > 4GiG ram on 32-bit kernels
Date: Tue, 16 Oct 2018 09:11:09 -0400
Message-ID: <CAP8WD_Zj5aMcTCVtV-hot3zLNfNuMzHyeogm0Lqb=+XZ1LdkKw@mail.gmail.com>
References: <20181014075208.2715-1-hch@lst.de>
Reply-To: whiteheadm-HInyCGIudOg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181014075208.2715-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Sun, Oct 14, 2018 at 3:52 AM Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org> wrote:
>
> We already build the swiotlb code for 32b-t kernels with PAE support,
> but the code to actually use swiotlb has only been enabled for 64-bit
> kernel for an unknown reason.
>
> Before Linux 4.18 we papers over this fact because the networking code,
> the scsi layer and some random block drivers implenented their own
> bounce buffering scheme.
>
> Fixes: 21e07dba ("scsi: reduce use of block bounce buffers")
> Fixes: ab74cfeb ("net: remove the PCI_DMA_BUS_IS_PHYS check in illegal_highdma")
> Reported-by: tedheadster <tedheadster-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Tested-by: tedheadster <tedheadster-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>

Christoph,
  this fix has causes performance to decrease dramatically. Kernel
builds that used to take 10-15 minutes are now taking 45-60 minutes on
the same machine.

- Matthew Whitehead
