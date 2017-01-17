From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iommu: Handle default domain attach failure
Date: Tue, 17 Jan 2017 16:51:04 +0100
Message-ID: <20170117155104.GW17255@8bytes.org>
References: <f5e5f1f1c3c37a36ea44eb8b2767b257ac97210d.1484571306.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <f5e5f1f1c3c37a36ea44eb8b2767b257ac97210d.1484571306.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Jan 16, 2017 at 12:58:07PM +0000, Robin Murphy wrote:
> We wouldn't normally expect ops->attach_dev() to fail, but on IOMMUs
> with limited hardware resources, or generally misconfigured systems,
> it is certainly possible. We report failure correctly from the external
> iommu_attach_device() interface, but do not do so in iommu_group_add()
> when attaching to the default domain. The result of failure there is
> that the device, group and domain all get left in a broken,
> part-configured state which leads to weird errors and misbehaviour down
> the line when IOMMU API calls sort-of-but-don't-quite work.
> 
> Check the return value of __iommu_attach_device() on the default domain,
> and refactor the error handling paths to cope with its failure and clean
> up correctly in such cases.
> 
> Fixes: e39cb8a3aa98 ("iommu: Make sure a device is always attached to a domain")
> Reported-by: Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org>
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/iommu/iommu.c | 37 ++++++++++++++++++++++++-------------
>  1 file changed, 24 insertions(+), 13 deletions(-)

Nice cleanup along the fix! Applied, thanks.
