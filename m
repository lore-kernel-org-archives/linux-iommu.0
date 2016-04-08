From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Subject: Re: AMD-Vi regression with PCIe/PCI bridges in 4.4
Date: Fri, 8 Apr 2016 21:01:11 +0200
Message-ID: <20160408190111.GF4203@suse.de>
References: <57038D1F.7040205@ladisch.de> <20160405101530.GA4203@suse.de>
	<5703AEE6.4010304@ladisch.de> <5703B1F3.6000505@math.uwb.edu.pl>
	<5703BA5E.3060005@ladisch.de> <1459926391.2346.6.camel@gmail.com>
	<20160406154729.GD4203@suse.de> <570530D9.6010109@math.uwb.edu.pl>
	<20160408132355.GE4203@suse.de> <5707D0BD.3070905@math.uwb.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5707D0BD.3070905-FRiIMV821htubak7+UBa2Q@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tomasz Golinski <tomaszg-FRiIMV821htubak7+UBa2Q@public.gmane.org>
Cc: bellamorte42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>, Martin Haiden <haiden.tracking-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Apr 08, 2016 at 05:39:41PM +0200, Tomasz Golinski wrote:
> > Okay, with this card I was able to reproduce the problem myself. Can you
> > guys please test if the attached patch fixes the issues for you as it
> > did for me?
> 
> Sorry for asking (maybe) stupid question. This patch doesn't apply
> against 4.5 kernel. Should I apply it against current git head or maybe
> IOMMU branch?

The patch is against v4.6-rc2.


Thanks,

	Joerg
