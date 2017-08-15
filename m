From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] iommu/of: Fix of_iommu_configure() for disabled IOMMUs
Date: Tue, 15 Aug 2017 16:50:33 +0200
Message-ID: <20170815145033.GA25618@8bytes.org>
References: <318c01e2f27ff892f3edbafa10972b75f45c8b74.1501863753.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <318c01e2f27ff892f3edbafa10972b75f45c8b74.1501863753.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Aug 04, 2017 at 05:29:06PM +0100, Robin Murphy wrote:
> Sudeep reports that the logic got slightly broken when a PCI iommu-map
> entry targets an IOMMU marked as disabled in DT, since of_pci_map_rid()
> succeeds in following a phandle, and of_iommu_xlate() doesn't return an
> error value, but we miss checking whether ops was actually non-NULL.
> Whilst this could be solved with a point fix in of_pci_iommu_init(), it
> suggests that all the juggling of ERR_PTR values through the ops pointer
> is proving rather too complicated for its own good, so let's instead
> simplify the whole flow (with a side-effect of eliminating the cause of
> the bug).
> 
> The fact that we now rely on iommu_fwspec means that we no longer need
> to pass around an iommu_ops pointer at all - we can simply propagate a
> regular int return value until we know whether we have a viable IOMMU,
> then retrieve the ops from the fwspec if and when we actually need them.
> This makes everything a bit more uniform and certainly easier to follow.
> 
> Fixes: d87beb749281 ("iommu/of: Handle PCI aliases properly")
> Reported-by: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
> Tested-by: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
> 
> v2: Don't break the -EPROBE_DEFER case
> 
>  drivers/iommu/of_iommu.c | 59 ++++++++++++++++++++++++------------------------
>  1 file changed, 29 insertions(+), 30 deletions(-)

Applied, thanks.
