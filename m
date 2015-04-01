From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [GIT PULL] iommu: Kill off pgsize_bitmap field from struct
	iommu_ops
Date: Wed, 1 Apr 2015 17:36:18 +0100
Message-ID: <20150401163618.GN1552@arm.com>
References: <20150327171946.GL1562@arm.com>
	<1427894051.22236.6.camel@infradead.org>
	<20150401133908.GI1552@arm.com>
	<1427896377.22236.8.camel@infradead.org>
	<20150401140512.GJ1552@arm.com>
	<1427898490.22236.10.camel@infradead.org>
	<20150401143904.GL1552@arm.com>
	<1427899570.22236.14.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1427899570.22236.14.camel-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 01, 2015 at 03:46:10PM +0100, David Woodhouse wrote:
> On Wed, 2015-04-01 at 15:39 +0100, Will Deacon wrote:
> > However, once we have that, we run into the same problem that we've got
> > with the current pgsize_bitmap. Namely, that it needs to be a per-domain
> > property to avoid it changing dynamically following an initial map request
> > or a probe of a new IOMMU device.
> 
> That's not so much of a problem, surely? When adding devices to a new
> domain without any mappings, the minimum page size of the domain is the
> largest of all the IOMMUs participating in that domain.

The issue (speaking in terms of the ARM SMMU, since that's what I'm familiar
with) is that we don't know the page sizes until we've chosen our
translation regime.

For example, we may have an SMMU that supports the following page sizes

  1:  4k | 2M | 1G
  2: 16k | 32M
  3: 64k | 512M

so a domain on the SMMU can use one of those three regimes. Other domains
*on the same SMMU* may use a different regime. That means we've actually
got three minimum page sizes for the SMMU.

Therefore, the page size we end up using for a domain depends on both:

  (a) Whether or not we've probed another SMMU (using the same driver) that
      goes and further restricts iommu_ops->min_pgsize (or whatever it ends
      up being called)

  (b) Which one of the available regimes is chosen by the page-table code.

Currently (b) tries to get something close to the CPU page size, but you
could imagine adding an interface to bias the selection towards some other
size. We could pick the largest minimum page size of the supported regimes
(I can't word this better... it would be 64k in the example above), but I
worry that this will end up being too big in practice and we'll over-map
for most small mappings.

If we put the min_pgsize in the domain, we can just describe it using the
regime that domain is using.

> And if you try to add new devices after you've already started making
> mappings, we refuse the addition if it would raise the minimum page size
> higher than the page sizes you're already using.

Ok, so I think that solves (a) above, but means we have to keep track of
the min_pgsize in the domain anyway so that we can check against it, in
which case it may just as well be removed from iommu_ops.

Will
