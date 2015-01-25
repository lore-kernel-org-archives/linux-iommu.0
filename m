From: Oded Gabbay <oded.gabbay-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu/amd: use handle_mm_fault directly v2
Date: Sun, 25 Jan 2015 15:16:44 +0200
Message-ID: <54C4ECBC.5070301@amd.com>
References: <1415830228-7844-1-git-send-email-jbarnes@virtuousgeek.org>
	<1415830228-7844-2-git-send-email-jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1415830228-7844-2-git-send-email-jbarnes-Y1mF5jBUw70BENJcbMCuUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jesse Barnes <jbarnes-Y1mF5jBUw70BENJcbMCuUQ@public.gmane.org>
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, "Bridgman,
	John" <John.Bridgman-5C7GfCeVMHo@public.gmane.org>, "Elifaz, Dana" <Dana.Elifaz-5C7GfCeVMHo@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, "akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



On 11/13/2014 12:10 AM, Jesse Barnes wrote:
> This could be useful for debug in the future if we want to track
> major/minor faults more closely, and also avoids the put_page trick we
> used with gup.
>
> In order to do this, we also track the task struct in the PASID state
> structure.  This lets us update the appropriate task stats after the
> fault has been handled, and may aid with debug in the future as well.
>
> v2: drop task accounting; GPU activity may have been submitted by a
>      different thread than the one binding the PASID (Joerg)
>
> Tested-by: Oded Gabbay<oded.gabbay-5C7GfCeVMHo@public.gmane.org>
> Signed-off-by: Jesse Barnes<jbarnes-Y1mF5jBUw70BENJcbMCuUQ@public.gmane.org>

Hi Jesse,

I know I tested your patch a few months ago, but we have a new feature (still 
internally) in the driver, which has some conflicts with this patch.

Our feature is basically doing "exception handling" by registering a callback 
function with the iommu driver in inv_ppr_cb.

Now, with the old code (we used 3.17.2 until a few days ago), this callback 
function was called in, at least, three use-cases (which we are testing):

(1) Writing to a "bad" system memory address, which is *not* in the process's 
memory address space.

(2) Writing to a read-only page, which is inside the process's memory address space

(3) Reading from a page without permissions, which is inside the process's 
memory address space

With the new code (3.19-rc5), this callback is only called in the first 
use-case, while (2) and (3) are handled in handle_mm_fault(), which is now 
called from do_fault. The return value of handle_mm_fault() is 0, so 
handle_fault_error() is not called and amdkfd doesn't get notification, hence 
our test fails.

This is a problem for us as we want to propagate these exceptions to the user 
space HSA runtime, so it could handle them.

I have 2 questions:

1. Why don't we call inv_ppr_cb() in any case ?
2. How come handle_mm_fault() returns 0 in cases (2) and (3) ? Or in other 
words, what is considered to be a success in handle_mm_fault() and is it visible 
to the user-space process ?

Thanks,

	Oded
