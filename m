From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/arm-smmu: use a threaded handler for context
	interrupts
Date: Wed, 4 Feb 2015 11:33:05 +0000
Message-ID: <20150204113305.GA28902@arm.com>
References: <1421970482-11722-1-git-send-email-mitchelh@codeaurora.org>
	<20150123112415.GD23058@arm.com>
	<vnkw61bx2klr.fsf@mitchelh-linux.qualcomm.com>
	<20150128120738.GJ1569@arm.com>
	<vnkwa90why79.fsf@mitchelh-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <vnkwa90why79.fsf-Yf+dfxj6toJBVvN7MMdr1KRtKmQZhJ7pQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Feb 02, 2015 at 08:10:02PM +0000, Mitchel Humpherys wrote:
> On Wed, Jan 28 2015 at 04:07:39 AM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> > With a shared handler (e.g. a bunch of context banks have the same IRQ)
> > then I assume that we don't want to end up with multiple handler threads
> > all tripping over each other. I'd rather have one thread that handles work
> > queued up by multiple low-level handlers.
> >
> > Do you have a preference either way?
> 
> Ok I think I understand the scenario you're describing.  If multiple
> context banks are sharing an interrupt line their handlers currently
> execute serially, but with threaded handlers they would all be woken up
> and possibly execute concurrently.  I hadn't really considered this
> because none of our targets have CBs sharing interrupts.  In any case,
> the CBs that aren't interrupting should quickly return IRQ_NONE when
> they notice that !(fsr & FSR_FAULT), so is this really a concern?

Well, with my stall-mode hat on, the FSR check could be done in the
low-level handler, with the actual page fault handling or whatever done
in the thread.

> Anyways, we can always hold off on this until we have a more compelling
> motivation for it.  For example, if we need to enable clocks to read
> registers then threaded IRQs seem like the best solution.  Hopefully
> I'll find time to have another go at the clocks stuff soon, which is the
> real reason why we're using threaded IRQs for context interrupts in our
> msm tree.

Okey doke. Having the clocks stuff supported in iommu core would be my
preference.

Will
