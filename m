From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH v3] iommu: Add driver for Renesas VMSA-compatible IPMMU
Date: Tue, 03 Jun 2014 19:39:05 +0200
Message-ID: <1837932.hUVa08Puz4@avalon>
References: <1396435657-3922-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<538D55C2.3090209@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <538D55C2.3090209-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Khiem Nguyen <khiem.nguyen.xt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

On Tuesday 03 June 2014 13:57:38 Khiem Nguyen wrote:
> Hi Laurent,
> 
> Thanks for the patch.
> 
> > +	if (!iommu_present(&platform_bus_type))
> > +		bus_set_iommu(&platform_bus_type, &ipmmu_ops);
> 
> With this code, if error occurs, it's hidden.
> 
> I think it should be like below,
> 
> > +	ret = bus_set_iommu(&platform_bus_type, &ipmmu_ops);
> > +	if (ret < 0)
> > +		return ret;
> 
> In this case, if error occurs, -EBUSY is returned.
> It's easier for troubleshooting the issue.
> 
> How do you think ?

I agree that we have a problem, but the problem is broader than this. Only one 
IOMMU type can be associated with a given bus, so things will break as soon as 
we will compile multiple IOMMU drivers in a multiplatform kernel. I'd like to 
fix this properly, but it requires IOMMU framework changes, and thus time. In 
the meantime we could apply your proposed modification, but it needs an 
additional platform_driver_unregister() call in the bus_set_iommu() error 
path.

-- 
Regards,

Laurent Pinchart
