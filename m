From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 0/8] io-pgtable lock removal
Date: Fri, 7 Jul 2017 13:46:49 +0100
Message-ID: <20170707124648.GH6735@arm.com>
References: <e43ba1fe-696e-fabb-a800-52fadaa2fa93@broadcom.com>
	<20170628114609.GD11053@arm.com>
	<87d53115-3d80-5a3d-6632-c31986cb7018@broadcom.com>
	<20170704173155.GN22175@arm.com>
	<6814b246-22f0-bfaa-5002-a269b2735116@broadcom.com>
	<2d5f5ef3-32b1-76c6-6869-ff980557f8e8@broadcom.com>
	<20170705084143.GA9378@arm.com>
	<5149280b-a214-249c-c5e2-3712b1f941d2@broadcom.com>
	<20170706150838.GB15574@arm.com>
	<94ba5d4a-0dae-9394-79ef-90da86e49c86@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <94ba5d4a-0dae-9394-79ef-90da86e49c86-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Ray Jui <ray.jui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: sunil.goutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Jul 06, 2017 at 11:14:00AM -0700, Ray Jui wrote:
> On 7/6/17 8:08 AM, Will Deacon wrote:
> > On Wed, Jul 05, 2017 at 04:24:22PM -0700, Ray Jui wrote:
> >> However, with the fix patch, I can still see the deadlock message when I
> >> have > 32 iperf TX threads active in the system:
> > 
> > Damn. We've been going over this today and the only plausible theory seems
> > to be that concurrent TLB syncs are causing the completion to be pushed out,
> > resulting in timeouts.
> > 
> > Can you try this patch below, instead of the one I sent before, please?
> > 
> > Thanks,
> > 
> > Will
> > 
> > --->8
> 
> Good news! I can confirm that with the new patch below, the error log of
> "TLB sync timed out" is now gone. I ran 20 iterations of the iperf
> client test with 64 threads spread across 8 CPUs. The error message used
> to coming out very quickly with just one iteration. But now it's
> completely gone.

Good, I'll queue this is as a fix then. Thanks for testing!

> At the same time, I do seem to observe a slight impact on performance
> when multiple threads are used, but I guess that is expected, given that
> a spin lock is added to protect the TLB sync.

Hopefully that performance will pick up again once we defer the sync
to the end of iommu_unmap.

Will
