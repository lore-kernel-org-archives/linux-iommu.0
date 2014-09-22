From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 1/2] iopoll: Introduce memory-mapped IO polling macros
Date: Mon, 22 Sep 2014 16:23:28 +0100
Message-ID: <20140922152328.GO25809@arm.com>
References: <1410460244-18943-1-git-send-email-mitchelh@codeaurora.org>
	<1410460244-18943-2-git-send-email-mitchelh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1410460244-18943-2-git-send-email-mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
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
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Matt Wagantall <mattw-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Mitch, Matt,

On Thu, Sep 11, 2014 at 07:30:43PM +0100, Mitchel Humpherys wrote:
> From: Matt Wagantall <mattw-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> 
> It is sometimes necessary to poll a memory-mapped register until its
> value satisfies some condition. Introduce a family of convenience macros
> that do this. Tight-loop and sleeping versions are provided with and
> without timeouts.

[...]

> +/**
> + * readl_poll_timeout_noirq - Periodically poll an address until a condition is met or a timeout occurs
> + * @addr: Address to poll
> + * @val: Variable to read the value into
> + * @cond: Break condition (usually involving @val)
> + * @max_reads: Maximum number of reads before giving up
> + * @time_between_us: Time to udelay() between successive reads
> + *
> + * Returns 0 on success and -ETIMEDOUT upon a timeout.
> + */
> +#define readl_poll_timeout_noirq(addr, val, cond, max_reads, time_between_us) \
> +({ \
> +	int count; \
> +	for (count = (max_reads); count > 0; count--) { \
> +		(val) = readl(addr); \
> +		if (cond) \
> +			break; \
> +		udelay(time_between_us); \
> +	} \
> +	(cond) ? 0 : -ETIMEDOUT; \
> +})

I think I'd just name this one readl_poll_timeout_atomic, then drop the
helper macros you define later on. Drivers should be able to figure out the
parameters they want pretty easily and it makes it more explicit imo.

Anyway, the rest of the patch looks fine.

Will
