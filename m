From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: Master-aware devices and sideband ID data
Date: Mon, 11 May 2015 10:52:36 +0100
Message-ID: <20150511095236.GC1549@arm.com>
References: <20150324155007.GC23005@leverpostej>
 <CALRxmdAE_=SubN7dY-W1K44cjVVRhKLKknpgG9af_g64+GHPtw@mail.gmail.com>
 <20150508154903.GH25587@arm.com>
 <CALRxmdAEvQPGN_xvwU5Xb4eNfKegPfTyM-GKXg4jRD7JyRxHJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CALRxmdAEvQPGN_xvwU5Xb4eNfKegPfTyM-GKXg4jRD7JyRxHJA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stuart Yoder <b08248-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, May 08, 2015 at 08:30:00PM +0100, Stuart Yoder wrote:
> On Fri, May 8, 2015 at 10:49 AM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> > On Thu, May 07, 2015 at 06:49:32PM +0100, Stuart Yoder wrote:
> >> The FSL LS2085A SoC has an actual RID->SID mapping table in the PCI
> >> controller, but it is not static in the sense of fixed in hardware or
> >> firmware.  It's
> >> a programmable mapping table, and we envision Linux programming this table.
> >
> > Ok, so I assume you're not planning to use ACPI with this system?
> 
> Not initially, but perhaps in the future.  I guess I don't know the implications
> to ACPI yet.

Well, I suggest you take a look at the IORT spec[1] asap, because I don't think
it can describe your system if you want to go in the direction of dynamic
mappings.

> > Also, we can't just program this table willy-nilly, as I'm sure you're
> > aware. For example, updating a the SMRs in a live SMMU is a big no-no,
> > so although Linux may initialise the table, it can only be safely changed
> > at device init/teardown time, surely?
> 
> Correct.  That would not be updated when a device is live.

Ok, so the best way for Linux is probably to abstract this in the bus code
and have that allocate the IDs when a device is `hotplugged' on. This would
also fit well with consolidating the group creation for platform and PCI
devices.

Will

[1] http://infocenter.arm.com/help/topic/com.arm.doc.den0049a/DEN0049A_IO_Remapping_Table.pdf
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
