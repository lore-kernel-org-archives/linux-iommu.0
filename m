From: Chris Wright <chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org>
Subject: Re: WARNING: at drivers/iommu/dmar.c:484 warn_invalid_dmar with
	Intel Motherboard
Date: Tue, 9 Jul 2013 16:22:52 -0700
Message-ID: <20130709232252.GB2676@sequoia2.sous-sol.org>
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

* Guenter Roeck (linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org) wrote:
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

I'm not sure there's much you can do.  The BIOS is saying there's a DMAR
unit, and then saying the registers are at addr 0x0.  The kernel is
simply warning you about the invalid DMAR table entry.

One thing I've seen is the BIOS zeroing the base register address when
VT-d is disabled in BIOS.  So, Guenter, a "fix" may be simply enabling
VT-d in the BIOS.

thanks,
-chris
