From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: WARNING: at drivers/iommu/dmar.c:484 warn_invalid_dmar with
	Intel Motherboard
Date: Wed, 14 Aug 2013 11:36:12 +0200
Message-ID: <20130814093607.GB4491@8bytes.org>
References: <20130709202406.GA11867@roeck-us.net>
	<CAErSpo6Ma1TnBP-UGGhWFN1rj48y+yTS=VmVw_s30_FWgjfdpg@mail.gmail.com>
	<20130709223106.GA16429@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130709223106.GA16429-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "open list:INTEL IOMMU (VT-d)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jul 09, 2013 at 03:31:06PM -0700, Guenter Roeck wrote:
> On Tue, Jul 09, 2013 at 03:05:39PM -0600, Bjorn Helgaas wrote:
> > [+cc Joerg, David, iommu list]
> > 
> > On Tue, Jul 9, 2013 at 2:24 PM, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org> wrote:
> > > I started seeing this problem after updating the BIOS trying fix another issue,
> > > though I may have missed it earlier.
> > >
> > > I understand this is a BIOS bug. Would be great if someone can pass this on
> > > to Intel BIOS engineers.
> > 
> > Maybe.  It'd be nice if Linux handled it better, though.
> > 
> If anyone has an idea how to do that, I'll be happy to write a patch.

I doubt that we can do anything meaningful here. The BIOS is broken in a
way so that we can't use the IOMMU in Linux. We can patch away the
WARN_ON and make it a sumple FW_BUG message, but the noise a WARN_ON
makes maybe help getting this issue fixed.

But I may be convinced otherwise, if people think this WARN_ON is not
worth it.


	Joerg
