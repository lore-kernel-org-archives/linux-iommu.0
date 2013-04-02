From: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: RFC: vfio API changes needed for powerpc
Date: Tue, 2 Apr 2013 16:55:34 -0500
Message-ID: <1364939734.24520.24@snotra>
References: <1364934737.2882.149.camel@bling.home> <1364936236.24520.23@snotra>
	<CALRxmdCe-RMZuhPSviQsQUxWZbxXABOZDsM8ZoNaqrp=xH+TaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="Flowed"; DelSp="Yes"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CALRxmdCe-RMZuhPSviQsQUxWZbxXABOZDsM8ZoNaqrp=xH+TaA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
	(from b08248-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org on Tue Apr  2 16:08:27 2013)
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
To: Stuart Yoder <b08248-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wood Scott-B07421 <B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "agraf-l3A5Bk7waGM@public.gmane.org" <agraf-l3A5Bk7waGM@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org" <qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org>, Yoder Stuart-B08248 <B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Bhushan Bharat-R65777 <R65777-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 04/02/2013 04:08:27 PM, Stuart Yoder wrote:
> On Tue, Apr 2, 2013 at 3:57 PM, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>  
> wrote:
> >> This could also be done as another "type2" ioctl extension.
> >
> >
> > Again, what is "type2", specifically?  If someone else is adding  
> their own
> > IOMMU that is kind of, sort of like PAMU, how would they know if  
> it's close
> > enough?  What assumptions can a user make when they see that  
> they're dealing
> > with "type2"?
> 
> We will define that as part of the type2 implementation.   Highly  
> unlikely
> anything but a PAMU will comply.

So then why not just call it "pamu" instead of being obfuscatory?

> > There's going to be special stuff no matter what.  This would keep  
> it
> > separated from the IOMMU map code.
> >
> > I'm not sure what you mean by "overhead" here... the runtime  
> overhead of
> > setting things up is not particularly relevant as long as it's  
> reasonable.
> > If you mean development and maintenance effort, keeping things well
> > separated should help.
> 
> We don't need to change DMA_MAP.  If we can simply add a new "type 2"
> ioctl that allows user space to set which windows are MSIs,

And what specifically does that ioctl do?  It causes new mappings to be  
created, right?  So you're changing (or at least adding to) the DMA map  
mechanism.

> it seems vastly less complex than an ioctl to supply a new fd, mmap  
> of it, etc.

I don't see enough complexity in the mmap approach for anything to be  
"vastly less complex" in comparison.  I think you're building the mmap  
approach up in your head to be a lot worse that it would actually be.

-Scott
