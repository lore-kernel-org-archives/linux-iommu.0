From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/28] AMD IOMMU interrupt remapping support
Date: Fri, 6 Jul 2012 16:08:27 +0200
Message-ID: <20120706140827.GA2412@8bytes.org>
References: <1341491808-23083-1-git-send-email-joerg.roedel@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1341491808-23083-1-git-send-email-joerg.roedel-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Jul 05, 2012 at 02:36:20PM +0200, Joerg Roedel wrote:
> Hi,
> 
> this patch-set adds support for IRQ remapping to the AMD IOMMU driver in
> Linux. It works similar to the already present IRQ remapping code for
> VT-d. The IOAPIC, HPET and MSI interrupts have a fixed setup to index an
> interrupt remapping table entry and the real vector and destination is
> only configured in the IRQ remapping table. This means that also the IRQ
> affinity is only changed in the IOMMU. The code was heavily
> stress-tested on a lot of machines and no known issues are left.
> 
> I also pushed this code into a branch of the IOMMU tree:
> 
> 	git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git irq-remapping

Okay, I updated this branch (non-fast-forward) with my current state. It
includes the fixes for Joe's objection and for all problems reported by
Fengguang Wu. While at it I added a patch to fix most of the other
sparse warnings in the AMD IOMMU driver. Thanks again for the reports
guys :)

I will wait for more comments and fixes to come up (including the
rewrite of patch 3 as requested by Ingo) and repost the patch-set some
time next week.

Thanks so far,

       Joerg
