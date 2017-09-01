From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu: Introduce Interface for IOMMU TLB Flushing
Date: Fri, 1 Sep 2017 23:45:02 +0200
Message-ID: <20170901214502.GN19533@8bytes.org>
References: <1503496204-2527-1-git-send-email-joro@8bytes.org>
	<1503496204-2527-3-git-send-email-joro@8bytes.org>
	<20170901172044.GB20817@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170901172044.GB20817-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On Fri, Sep 01, 2017 at 06:20:45PM +0100, Will Deacon wrote:
> On Wed, Aug 23, 2017 at 03:50:04PM +0200, Joerg Roedel wrote:

> > +EXPORT_SYMBOL_GPL(iommu_unmap_fast);
> 
> Really minor nit, but I think that iommu_unmap_nosync is a more descriptive
> name (who wouldn't want to use the _fast version?!).

Yeah, but I wanted the name to motivate people to use it, or at least
think about why they are not using the _fast variant. Therefore I
decided for that name and not the more descriptive _sync version.

> But anyway, this looks like a really welcome change and it addresses most
> of my concerns on v1, so, modulo Robin's comments about map_sg:

Thanks, I removed the stale map_sg_sync stuff before applying.


Regards,

	Joerg
