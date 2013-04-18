From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2 V2] iommu/amd: Add workaround for ERBT1312
Date: Thu, 18 Apr 2013 22:06:13 +0200
Message-ID: <20130418200613.GB17148@8bytes.org>
References: <1366009666-44792-1-git-send-email-suravee.suthikulpanit@amd.com>
	<20130418160220.GA4153@8bytes.org> <51701B9F.10003@amd.com>
	<20130418162856.GA13891@8bytes.org> <5170268E.8080706@amd.com>
	<20130418183538.GA17148@8bytes.org> <517041EA.70407@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <517041EA.70407-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Apr 18, 2013 at 01:56:42PM -0500, Suthikulpanit, Suravee wrote:
> On 4/18/2013 1:35 PM, Joerg Roedel wrote:

> According to the "kernel/irq/handle.c:irq_wake_thread()", I thought
> that for the threaded IRQ, if the system getting a new interrupt
> from the device while the thread is running, it will just return and
> do nothing.

Yes, but the irq-thread function itself executes the handler function
repeatedly until the IRQTF_RUNTHREAD bit is cleared. And every new
interrupt will set this bit again. So when there is a new interrupt
while our handler function runs the handler will be called again by the
irq-thread.


	Joerg
