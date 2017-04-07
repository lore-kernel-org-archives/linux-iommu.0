From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/5] iommu/omap: Permanently keep iommu_dev pointer in
	arch_data
Date: Fri, 7 Apr 2017 16:35:20 +0200
Message-ID: <20170407143520.GB7266@8bytes.org>
References: <1490962248-12602-1-git-send-email-joro@8bytes.org>
	<1490962248-12602-3-git-send-email-joro@8bytes.org>
	<c3305742-b927-c789-c7c2-883f98a77ada@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <c3305742-b927-c789-c7c2-883f98a77ada-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Suman,

On Mon, Apr 03, 2017 at 03:35:46PM -0500, Suman Anna wrote:
> > +	iommu = platform_get_drvdata(pdev);
> > +	if (!iommu) {
> > +		of_node_put(np);
> > +		return -EINVAL;
> > +	}
> 
> This change is causing the issues. OMAP IOMMU driver is not probed yet,
> but this gets called during the driver's init function in
> bus_set_iommu() and bus's iommu_ops gets set to NULL. The add_device
> today is used to add the linking to an IOMMU device (currently name
> primarily to support the legacy non-DT mode which is no longer an issue,
> but a dev pointer can be used instead here, and the real enabling is
> done during the domain's attach_dev callback.

Yeah, okay. Solving this problem requires more sophisticated handling in
the iommu core code, which is not implemented yet.

I drop this patch for now and do the device-linking and group-handling
in attach_dev. This makes iommu-groups on omap useless for now, but it
is a start.


	Joerg
