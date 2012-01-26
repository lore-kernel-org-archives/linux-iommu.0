From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/5] iommu/amd: Implement DOMAIN_ATTR_GEOMETRY attribute
Date: Thu, 26 Jan 2012 20:44:29 +0100
Message-ID: <20120126194428.GH6269@8bytes.org>
References: <1326983405-319-1-git-send-email-joerg.roedel@amd.com>
	<1326983405-319-3-git-send-email-joerg.roedel@amd.com>
	<C5ECD7A89D1DC44195F34B25E172658D038749@039-SN2MPN1-011.039d.mgd.msft.net>
	<20120120160344.GG2205@amd.com> <4F219A9C.8000400@freescale.com>
	<20120126183116.GI19255@amd.com> <4F219E82.106@freescale.com>
	<20120126185101.GJ19255@amd.com> <4F21A2D5.6000204@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4F21A2D5.6000204-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Wood Scott-B07421 <B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Hiroshi DOYU <Hiroshi.DOYU-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Sethi Varun-B16395 <B16395-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, David Brown <davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 26, 2012 at 01:00:37PM -0600, Scott Wood wrote:
> On 01/26/2012 12:51 PM, Joerg Roedel wrote:
> > Because this is a flag that makes sense for all IOMMU. Every IOMMU
> > either allows DMA outside its aperture or it doesn't.
> > 
> > Another reason why it must be in the generic struct is the intended
> > generic dma-ops layer on-top. This code can decide on this flag wheter a
> > address needs to be remapped at all.
> 
> So the DMA API would just read this, not write it?

The whole geometry thing is only implemented on the read side. There is
no implementation in domain_set_attr for it. So the geometry
information is read-only by default.

> Still no reason why it couldn't be a separate attribute.  Then if you
> get a failure trying to write it, it's more obvious why.

This would mean iommu specific hacks, which are not necessary in this
case.

> > Setting this flag wrong does not create unintended identity mappings.
> 
> Failing to set it means that DMA can go through that is not limited to
> explicitly created mappings.  In some contexts (e.g. vfio) this is a
> security hole.

No, when the hardware does not allow this, then software can't enforce
it. Again, the whole geometry attribute is only for iommu drivers to
export what the hardware can do. It is not for software to configure the
iommu driver.

> > But I don't understand what you mean by 'restrictions on possible values'. The
> > geometry attribute is filled by the IOMMU driver dependent on the
> > hardware capabilities. There are no limits from the iommu-code side.
> 
> How does the user of the iommu API discover the hardware capabilities?

Which hardware capabilities besides the geometry do you mean?


	Joerg
