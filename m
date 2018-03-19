From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH 00/10 v2] iommu/amd: lock splitting & GFP_KERNEL allocation
Date: Mon, 19 Mar 2018 13:15:27 +0100
Message-ID: <20180319121527.zdmuwid4i3mjpwjw@linutronix.de>
References: <20180316201836.7864-1-bigeasy@linutronix.de>
	<1521316194.3722.74.camel@redhat.com>
	<20180317211013.rlou66s542ad4y2i@linutronix.de>
	<1521323019.3722.98.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1521323019.3722.98.camel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Scott Wood <swood-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 2018-03-17 16:43:39 [-0500], Scott Wood wrote:
> If that's worth the lock dropping then fine (though why does only one
> of the two allocations use GFP_KERNEL?), but it doesn't need to be a
That was a mistake, I planned to keep both as GFP_KERNEL.

> raw lock if the non-allocating users are separated.  Keeping them
> separate will also preserve the WARNs if we somehow end up in an atomic
> context with no table (versus relying on atomic sleep debugging that
> may or may not be enabled), and make the code easier to understand by
> being explicit about which functions can be used from RT-atomic
> context.

That separated part is okay. We could keep it. However, I am not sure if
looking at the table irq_lookup_table[devid] without the lock is okay.
The pointer is assigned without DTE entry/iommu-flush to be completed. 
This does not look "okay".

> -Scott
> 
Sebastian
