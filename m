From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] dma-mapping: move all DMA mapping code to kernel/dma
Date: Thu, 14 Jun 2018 15:13:46 +0300
Message-ID: <CAHp75Vcpmx=GLU087Et+LA0_LOCF-xu1beKzb4iLxoOOi91Qmg@mail.gmail.com>
References: <20180614120029.27315-1-hch@lst.de>
	<20180614120029.27315-3-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180614120029.27315-3-hch-jcswGhMUV9g@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jun 14, 2018 at 3:00 PM, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org> wrote:
> Currently the code is split over various files with dma- prefixes in the
> lib/ and drives/base directories, and the number of files keeps growing.
> Move them into a single directory to keep the code together and remove
> the file name prefixes.  To match the irq infrastructure this directory
> is placed under the kernel/ directory.

For my point of view, makes sense!

> +config HAS_DMA
> +       bool
> +       depends on !NO_DMA
> +       default y

I see it's just move from other file, though we might switch to
  def_bool y
instead of two lines.

-- 
With Best Regards,
Andy Shevchenko
