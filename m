From: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH 1/3] iommu/amd: Add logic to decode AMD IOMMU event flag
Date: Tue, 2 Apr 2013 21:32:40 +0200
Message-ID: <20130402193240.GF17675@pd.tnic>
References: <1364428283-2548-1-git-send-email-suravee.suthikulpanit@amd.com>
	<20130402143335.GB15687@8bytes.org> <20130402144037.GE5488@pd.tnic>
	<20130402150302.GF15687@8bytes.org> <20130402152956.GE4391@pd.tnic>
	<20130402160400.GP30540@8bytes.org>
	<20130402161757.GC17519@pd.tnic>
	<20130402163318.GS30540@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130402163318.GS30540-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 02, 2013 at 06:33:18PM +0200, Joerg Roedel wrote:
> I can't find out in the driver whether the fix works or not. It will
> be noticed later when the x86 code tries to setup the timers and finds
> out that they don't work, which causes a kernel panic.
>
> Okay, in theory I could implement a feedback loop between timer-setup
> and intremap code and try fixups until it works. But that seems not to
> be worth it to work around a buggy BIOS.

Yeah, same here. It's not like we really need intremap to work - we're
only trying to fix the annoying error message currently. :-)

> What I actually thought about was providing an IVRS-override on the
> kernel command line. So that you can specify the IOAPIC_ID->DEVID
> mapping there and make it work this way. What do you think?

I guess that is workable. I can imagine people wanting this if they want
to do the intremap thing on such b0rked BIOSen. So how do I specify this
IOAPIC_ID->DEVID mapping on the cmdline exactly?

> > And yes, I'm very sceptical about having a WARN_ON and it starts
> > screaming on machines all over the place. Good luck explaining to
> > people that you actually wanted to prod BIOS vendors to fix their
> > monkey-on-crack code but they weren't listening in the first place.
> 
> Yeah, that's my fear too. So we leave it better as it is...

Hohumm.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
