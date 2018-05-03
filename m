From: Dmitry Safonov via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [PATCHv4 2/2] iommu/vt-d: Limit number of faults to clear in
	irq handler
Date: Thu, 03 May 2018 02:59:36 +0100
Message-ID: <1525312776.14025.29.camel@arista.com>
References: <20180331003312.6390-1-dima@arista.com>
	<20180331003312.6390-2-dima@arista.com>
	<5AE95BFF.5040306@linux.intel.com>
	<1525264687.14025.20.camel@arista.com>
	<5AEA4E84.6050609@linux.intel.com>
	<1525308755.14025.25.camel@arista.com>
	<5AEA66BC.5050202@linux.intel.com>
Reply-To: Dmitry Safonov <dima-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5AEA66BC.5050202-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, 0x7f454c46-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, 2018-05-03 at 09:32 +0800, Lu Baolu wrote:
> Hi,
> 
> On 05/03/2018 08:52 AM, Dmitry Safonov wrote:
> > AFAICS, we're doing fault-clearing in a loop inside irq handler.
> > That means that while we're clearing if a fault raises, it'll make
> > an irq level triggered (or on edge) on lapic. So, whenever we
> > return
> > from the irq handler, irq will raise again.
> > 
> 
> Uhm, double checked with the spec. Interrupts should be generated
> since we always clear the fault overflow bit.
> 
> Anyway, we can't clear faults in a limited loop, as the spec says in
> 7.3.1:

Mind to elaborate?
ITOW, I do not see a contradiction. We're still clearing faults in FIFO
fashion. There is no limitation to do some spare work in between
clearings (return from interrupt, then fault again and continue).

> Software is expected to process the non-recoverable faults reported
> through the Fault Recording
> Registers in a circular FIFO fashion starting from the Fault
> Recording Register referenced by the Fault
> Recording Index (FRI) field, until it finds a Fault Recording
> Register with no faults (F field Clear).
> 
> Best regards,
> Lu Baolu

-- 
Thanks,
             Dmitry
