From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [GIT PULL] iommu: Kill off pgsize_bitmap field from struct
	iommu_ops
Date: Wed, 1 Apr 2015 14:39:09 +0100
Message-ID: <20150401133908.GI1552@arm.com>
References: <20150327171946.GL1562@arm.com>
	<1427894051.22236.6.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1427894051.22236.6.camel-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
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

On Wed, Apr 01, 2015 at 02:14:11PM +0100, David Woodhouse wrote:
> On Fri, 2015-03-27 at 17:19 +0000, Will Deacon wrote:
> > 
> > Please can you pull the following IOMMU changes for 4.1? They move the
> > per-iommu_ops pgsize_bitmap field into the iommu_domain, which allows
> > IOMMUs such as the ARM SMMU to support different page sizes within a
> > given SoC.
> 
> Can't we kill it entirely? It's always been horrid. Just let the IOMMU
> driver fill the page tables as it sees according to the virtual/physical
> size and alignment of the range it's asked to map.
> 
> We already lie about the supported page sizes in the Intel VT-d driver
> and claim to support everything, just to make the caller "Just Ask" as
> it should.
> 
> We might have to fix the loop that KVM uses to unmap pages, and
> potentially the bizarre unmap() API which returns the page size that it
> unmapped, but we should do that anyway :)

We'd also need to update any page-table code that relies on being called
one page at a time (i.e. the new io-pgtable stuff we merged for 4.0) so
that we iterate over the requested range. That shouldn't be too difficult
(i.e. just inline the iommu_map logic into each driver), but it would
need some testing.

In fact, that would also allow us to nuke the whole TLB on VFIO unmap of
large ranges. We currently iterate over the range page-by-page, which takes
ages (minutes) in simulation.

Will
