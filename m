From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2 V2] iommu/amd: Add workaround for ERBT1312
Date: Thu, 18 Apr 2013 13:56:42 -0500
Message-ID: <517041EA.70407@amd.com>
References: <1366009666-44792-1-git-send-email-suravee.suthikulpanit@amd.com>
	<20130418160220.GA4153@8bytes.org> <51701B9F.10003@amd.com>
	<20130418162856.GA13891@8bytes.org> <5170268E.8080706@amd.com>
	<20130418183538.GA17148@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130418183538.GA17148-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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

On 4/18/2013 1:35 PM, Joerg Roedel wrote:
> On Thu, Apr 18, 2013 at 11:59:58AM -0500, Suthikulpanit, Suravee wrote:
>> One last concern I have for this patch is the case when we re-enable
>> the interrupt, then another interrupt happens while we processing
>> the log and set the bit.  If the interrupt thread doesn't check this
>> right before the thread exits the handler.  We could still end up
>> leaving the interrupt disabled.
> That can't happen, the patch checks whether the bit is really 0 and then
> it processes the event/ppr-log entries. If any new entry is queued while
> we process the logs another interrupt will be fired and the irq-thread
> will run again. So we will not miss any log entry.
According to the "kernel/irq/handle.c:irq_wake_thread()", I thought that 
for the threaded IRQ, if the system getting a new interrupt from the 
device while the thread is running, it will just return and do nothing.

Suravee

> 	Joerg
>
>
>
