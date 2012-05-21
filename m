From: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] iommu/core: pass user-provided token when handling faults
Date: Mon, 21 May 2012 17:14:02 +0300
Message-ID: <CAK=WgbY-BwQZicAd+Rj1qpSdv=ZU-qhKaskRJz33v93xtVxrSg@mail.gmail.com>
References: <1337505311-25697-1-git-send-email-ohad@wizery.com>
	<20120521132517.GE2604@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120521132517.GE2604-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <Joerg.Roedel-5C7GfCeVMHo@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Fernando Guzman Lugo <fernando.lugo-l0cyMroinI0@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, May 21, 2012 at 4:25 PM, Joerg Roedel <Joerg.Roedel-5C7GfCeVMHo@public.gmane.org> wrote:
> May break compilation for !CONFIG_IOMMU_API.

Good point. I'll squash this in:

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index eb72d3b..450293f 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -193,7 +193,7 @@ static inline int domain_has_cap(struct iommu_domain *domain
 }

 static inline void iommu_set_fault_handler(struct iommu_domain *domain,
-                                       iommu_fault_handler_t handler)
+                               iommu_fault_handler_t handler, void *token)
 {
 }

Or did you have something else in mind?

> Where is remoteproc changed?

In a subsequent patch set coming from Fernando (cc'ed). Fernando will
also carry this patch with him, and will cc you when the patch set is
submitted (should be very soon). I wanted your general opinion before
we start relying on this patch (sorry, should have mentioned it
earlier).

Thanks for your feedback!
Ohad.
