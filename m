From: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: RFC: vfio API changes needed for powerpc (v3)
Date: Thu, 11 Apr 2013 14:53:24 -0500
Message-ID: <1365710004.3640.8@snotra>
References: <20130411125659.GL6858@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="Flowed"; DelSp="Yes"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130411125659.GL6858-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> (from joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org on Thu
	Apr 11 07:56:59 2013)
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Wood Scott-B07421 <B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "agraf-l3A5Bk7waGM@public.gmane.org" <agraf-l3A5Bk7waGM@public.gmane.org>, "qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org" <qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org>, Yoder Stuart-B08248 <B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Bhushan Bharat-R65777 <R65777-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 04/11/2013 07:56:59 AM, Joerg Roedel wrote:
> On Tue, Apr 09, 2013 at 01:22:15AM +0000, Yoder Stuart-B08248 wrote:
> > > What happens if a normal unmap call is done on the MSI iova?  Do  
> we
> > > need a separate unmap?
> >
> > I was thinking a normal unmap on an MSI windows would be an  
> error...but
> > I'm not set on that.   I put the msi unmap there to make things  
> symmetric,
> > a normal unmap would work as well...and then we could drop the msi  
> unmap.
> 
> Hmm, this API semantic isn't very clean. When you explicitly map the  
> MSI
> banks a clean API would also allow to unmap them. But that is not
> possible in your design because the kernel is responsible for mapping
> MSIs and you can't unmap a MSI bank that is in use by the kernel.

Why is it not possible to unmap them?  Once they've been mapped,  
they're just like any other IOMMU mapping.  If the user breaks MSI for  
their own devices by unmapping the MSI page, that's their problem.

> So since the kernel owns the MSI setup anyways it should also take  
> care
> of mapping the MSI banks. What is the reason to not let the kernel
> allocate the MSI banks top-down from the end of the DMA window space?

It's less flexible, and possibly more complicated.

-Scott
