From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Regression in kernel 4.2.3+ (relative to 4.1.10) on AMD 990FX
	system with IOMMU enabled
Date: Wed, 18 Nov 2015 16:18:41 +0100
Message-ID: <20151118151841.GA2517@suse.de>
References: <563A3F64.50808@redhat.com>
 <5644CD81.2020304@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5644CD81.2020304-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Laine Stump <laine-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hello Laine,

On Thu, Nov 12, 2015 at 12:33:53PM -0500, Laine Stump wrote:
> After a crash course in kernel building from Alex, I bisected down
> to commit aafd8ba - a kernel built without this commit succeeds in
> setting up all the devices mentioned, adding it causes failure (and
> a very long delay during boot). Joerg, do you have any ideas for
> debugging the problem further to see what in the commit causes this
> problem? (note that 2 other people with the same chipset but
> slightly different hardware plugged into it report no failure - see
> the other replies to the parent of this message for more detail).
> I'm happy to build a kernel with any suggested patches and report
> results...
> 
> commit aafd8ba0ca74894b9397e412bbd7f8ea2662ead8
> Author: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> Date:   Thu May 28 18:41:39 2015 +0200
> 
>     iommu/amd: Implement add_device and remove_device
> 
>     Implement these two iommu-ops call-backs to make use of the
>     initialization and notifier features of the iommu core.
> 
>     Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

I have no idea yet how this patch causes your regression. You certainly
already posted it, but since I was not on Cc, can you please give me an
overview about the problem you are seeing with this patch?



	Joerg
