From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: WARNING: at drivers/iommu/dmar.c:484 warn_invalid_dmar with
	Intel Motherboard
Date: Tue, 9 Jul 2013 17:18:28 -0700
Message-ID: <20130710001828.GA32072@roeck-us.net>
References: <20130709202406.GA11867@roeck-us.net>
	<CAErSpo6Ma1TnBP-UGGhWFN1rj48y+yTS=VmVw_s30_FWgjfdpg@mail.gmail.com>
	<20130709223106.GA16429@roeck-us.net>
	<20130709232252.GB2676@sequoia2.sous-sol.org>
	<20130709234331.GA10833@roeck-us.net>
	<20130710000511.GC2676@sequoia2.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130710000511.GC2676-k0AF34rgNAQdGiBX8rKX95cPDiHTxzko@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Chris Wright <chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org>
Cc: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "open list:INTEL IOMMU (VT-d)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jul 09, 2013 at 05:05:11PM -0700, Chris Wright wrote:
> * Guenter Roeck (linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org) wrote:
> > On Tue, Jul 09, 2013 at 04:22:52PM -0700, Chris Wright wrote:
> > > * Guenter Roeck (linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org) wrote:
> > > > On Tue, Jul 09, 2013 at 03:05:39PM -0600, Bjorn Helgaas wrote:
> > > > > [+cc Joerg, David, iommu list]
> > > > > 
> > > > > On Tue, Jul 9, 2013 at 2:24 PM, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org> wrote:
> > > > > > I started seeing this problem after updating the BIOS trying fix another issue,
> > > > > > though I may have missed it earlier.
> > > > > >
> > > > > > I understand this is a BIOS bug. Would be great if someone can pass this on
> > > > > > to Intel BIOS engineers.
> > > > > 
> > > > > Maybe.  It'd be nice if Linux handled it better, though.
> > > > > 
> > > > If anyone has an idea how to do that, I'll be happy to write a patch.
> > > 
> > > I'm not sure there's much you can do.  The BIOS is saying there's a DMAR
> > > unit, and then saying the registers are at addr 0x0.  The kernel is
> > > simply warning you about the invalid DMAR table entry.
> > > 
> > > One thing I've seen is the BIOS zeroing the base register address when
> > > VT-d is disabled in BIOS.  So, Guenter, a "fix" may be simply enabling
> > > VT-d in the BIOS.
> >
> > Ah, yes, I think I may have that disabled. I'll check it tonight.
> > 
> > Does that really warrant a traceback, or would a warning message be more
> > appropriate (possibly telling the user to enable VT-d) ?
> 
> Bottom line, the BIOS is providing what we're seeing as invalid tables.
> If it's a BIOS attempt to disable VT-d is hard to glean from invalid
> tables, and not all BIOS give interface to enable/disable VT-d.
> 
> It is a warning message, BTW.  Guess I'd be inclined to leave as it is.
> 
I meant warning as in pr_warn or dev_warn, not WARNING as in traceback.
Keep in mind that a casual user doesn't expect to see a traceback and will tend
to get alarmed. Several bugs have been filed against this "issue" in various
distributions, which is not surprising given the alarmist message.
What is the point of that ?

Guenter
