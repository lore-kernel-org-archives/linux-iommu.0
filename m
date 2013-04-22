From: Suravee Suthikulanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2 V2] iommu/amd: Add workaround for ERBT1312
Date: Mon, 22 Apr 2013 16:43:55 -0500
Message-ID: <5175AF1B.2010409@amd.com>
References: <1366009666-44792-1-git-send-email-suravee.suthikulpanit@amd.com>
	<20130418160220.GA4153@8bytes.org> <51701B9F.10003@amd.com>
	<20130418162856.GA13891@8bytes.org> <5170268E.8080706@amd.com>
	<20130418183538.GA17148@8bytes.org> <517041EA.70407@amd.com>
	<20130418200613.GB17148@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130418200613.GB17148-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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

On 4/18/2013 3:06 PM, Joerg Roedel wrote:
> Yes, but the irq-thread function itself executes the handler function
> repeatedly until the IRQTF_RUNTHREAD bit is cleared. And every new
> interrupt will set this bit again. So when there is a new interrupt
> while our handler function runs the handler will be called again by the
> irq-thread.
>
>
> 	Joerg
Thank you for the clarification.  I have submitted a new patch based on 
the new workaround code. 
(http://lists.linuxfoundation.org/pipermail/iommu/2013-April/005574.html)

Suravee
