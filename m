From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iommu/amd: Use raw_cpu_ptr() instead of get_cpu_ptr()
	for ->flush_queue
Date: Tue, 19 Sep 2017 11:41:19 +0200
Message-ID: <20170919094119.bibxslqyeefbx7gf@8bytes.org>
References: <20170906103459.oi2nn7jondjqdo5m@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170906103459.oi2nn7jondjqdo5m-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, vinadhy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Sebastian,

On Wed, Sep 06, 2017 at 12:34:59PM +0200, Sebastian Andrzej Siewior wrote:
> get_cpu_ptr() disables preemption and returns the ->flush_queue object
> of the current CPU. raw_cpu_ptr() does the same except that it not
> disable preemption which means the scheduler can move it to another CPU
> after it obtained the per-CPU object.
> In this case this is not bad because the data structure itself is
> protected with a spin_lock. This change shouldn't matter in general
> but on RT it does because the sleeping lock can't be accessed with
> disabled preemption.

I moved the flushing to driver/iommu/iova.c to share it with the Intel
IOMMU and possibly other drivers too, so this patch does no longer apply
to v4.14-rc1. Can you update the patch to these changes?

Regards,

	Joerg
