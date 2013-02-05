From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 5/5] iommu: Add DOMAIN_ATTR_WINDOWS domain attribute
Date: Tue, 5 Feb 2013 14:05:34 +0100
Message-ID: <20130205130534.GS25591@8bytes.org>
References: <1359983924-28952-1-git-send-email-joro@8bytes.org>
	<1359983924-28952-6-git-send-email-joro@8bytes.org>
	<C5ECD7A89D1DC44195F34B25E172658D373D2B@039-SN2MPN1-013.039d.mgd.msft.net>
	<20130205104155.GR25591@8bytes.org>
	<C5ECD7A89D1DC44195F34B25E172658D3752B1@039-SN2MPN1-013.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <C5ECD7A89D1DC44195F34B25E172658D3752B1-RL0Hj/+nBVDYdknt8GnhQq4g8xLGJsHaLnY5E4hWTkheoWH0uzbU5w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sethi Varun-B16395 <B16395-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Wood Scott-B07421 <B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Feb 05, 2013 at 10:52:03AM +0000, Sethi Varun-B16395 wrote:
> DOMAIN_ATTR_PAMU_ENABLE is required to enable a particular DMA window.
> My point is about the domain geometry, which is incomplete in case of
> PAMU without the number of subwindows. Geometry parameters are used
> for initializing the PAMU window settings. Individual subwindows can
> only be enabled, once the PAMU window has been initialized using the
> geometry settings.

I understand that. What you do is:

	/* Set geometry */
	set_attr(domain, DOMAIN_ATTR_GEOMETRY);

	/* Set number of PAMU subwindows */
	set_attr(domain, DOMAIN_ATTR_WINDOWS);

	/* Commit changes to hardware and enable the window */
	set_attr(domain, DOMAIN_ATTR_PAMU_ENABLE);

And I don't see any problem with that. The domain_attr interface was
introduced to cope with device specifics, we don't change global
interface data structures for that.


	Joerg
