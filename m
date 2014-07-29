From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] iommu/vt-d: race setting IRQ CPU affinity while
	freeing IRQ
Date: Tue, 29 Jul 2014 12:45:31 +0200
Message-ID: <20140729104531.GB9809@8bytes.org>
References: <20140722142719.GA28143@psuche.datadirectnet.com>
	<20140723144024.GA14017@8bytes.org>
	<20140723144917.GA26986@psuche.datadirectnet.com>
	<20140723151040.GB14017@8bytes.org>
	<20140723161326.GB32422@psuche.datadirectnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140723161326.GB32422-+5IcJesBrg1QnCaYh1JbbuXjVpU8mP+x@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Greg Edwards <gedwards-LfVdkaOWEx8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Jul 23, 2014 at 10:13:26AM -0600, Greg Edwards wrote:
> A user process setting the CPU affinity of an IRQ for a KVM
> direct-assigned device via /proc/irq/<IRQ#>/smp_affinity can race with
> the IRQ being released by QEMU, resulting in a NULL iommu pointer
> dereference in get_irte().

Maybe I wasn't clear enough, what I am missing is a panic message with a
backtrace from the NULL pointer deref you are seeing in the commit
message.

Also I am still wondering why it is possible to set affinity from
userspace while the irq is about to be freed. Shouldn't the proc files
are already unregistered when the irq is freed?


	Joerg
