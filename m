From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iommu/vt-d: Assign old irt entries a common valid vector
	in kdump kernel
Date: Wed, 2 Mar 2016 15:58:23 +0100
Message-ID: <20160302145823.GV22747@8bytes.org>
References: <1456912948-5052-1-git-send-email-xlpang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1456912948-5052-1-git-send-email-xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Xunlei Pang <xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, ZhenHua Li <zhen-hual-VXdhtT5mjnY@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Mar 02, 2016 at 06:02:28PM +0800, Xunlei Pang wrote:
> Currently, the kernel copies the old irt entries during iommu
> initialization for kdump, so old vectors in the first kernel are
> used but having no related kernel irq handlers set explicitly,
> this can lead to some problems after lapics are enabled:
>  - When some in-flight dma finished and triggered an interrupt,
>    the kernel will throw a warning message in do_IRQ() like "No
>    irq handler", because handle_irq() will return false with no
>    irq_desc handlers. This may confuse users.
>  - When the in-flight dma interrupt arrives, and if there happens
>    to be an irq with the same vector allocated in kdump kernel,
>    it will invoke the existing ISR registered in kdump kernel as
>    if one valid interrupt in the kdump kernel happens. This might
>    cause some wrong software logic, for example if the ISR always
>    wakes up a process.

Hmm, the current situation with misdirected irq messages in the kdump
kernel is not different from a situation without any iommu at all,
right?

And the goal of preserving the old mappings is to get as close as
possible to the situation without iommu. This seems to carry the VT-d
driver away from that.


	Joerg
