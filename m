From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 01/11] iommu: Rename iommu_get_instance()
Date: Fri, 10 Feb 2017 16:36:08 +0100
Message-ID: <20170210153608.GL7339@8bytes.org>
References: <1486639981-32368-1-git-send-email-joro@8bytes.org>
	<1486639981-32368-2-git-send-email-joro@8bytes.org>
	<baf8d059-8c74-baa4-1806-ca1e3733cd93@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <baf8d059-8c74-baa4-1806-ca1e3733cd93-5wv7dgnIgG8@public.gmane.org>
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
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On Fri, Feb 10, 2017 at 02:12:54PM +0000, Robin Murphy wrote:
> I'm really liking this series! Superficially it doesn't seem to break
> anything on my Juno, but I'll give it a more thorough workout soon.

Great, thanks for testing! Any problems in this series should show up on
boot anyway.

> >  static inline const struct iommu_ops *of_iommu_get_ops(struct device_node *np)
> >  {
> > -	return iommu_get_instance(&np->fwnode);
> > +	return iommu_ops_from_fwnode(&np->fwnode);
> >  }
> 
> Note that you've already got Lorenzo's patch queued to remove these of_
> wrappers.

Yes, that was among the conflicts I resolved when merging this with the
rest of the iommu-tree.


	Joerg
