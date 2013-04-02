From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] iommu/amd: Add IOMMU event log injection interface
	for testing event flag decoding logic
Date: Tue, 2 Apr 2013 16:35:22 +0200
Message-ID: <20130402143521.GC15687@8bytes.org>
References: <1364428294-2579-1-git-send-email-suravee.suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1364428294-2579-1-git-send-email-suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Mar 27, 2013 at 06:51:34PM -0500, suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
> 
> Add IOMMU event log injection interface for testing event flag decoding logic.
> This interface allows users to specify device id, event flag, and event types via debugfs.
> 
> echo 0x300 > /sys/kernel/debug/amd-iommu-evninj/devid // (e.g. Bus:Dev.fun 3:0.0)
> echo 0xfff > /sys/kernel/debug/amd-iommu-evninj/flags // (e.g. Specify flag value)
> echo 2 > /sys/kernel/debug/amd-iommu-evninj/type      // (e.g. for IO_PAGE_FAULT event)
> 
> Once the event is injected, IOMMU driver will parse and print out the event information
> in kernel log (dmesg) with the various information depending on the types of event and flag
> specified.

Why is this needed? I think the risk of regressions in the
event-handling code is to low to justify the need for an event-injection
mechanism.

	Joerg
