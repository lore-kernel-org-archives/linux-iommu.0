From: Stuart Yoder <stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 2/3] Docs: dt: Add PCI MSI map bindings
Date: Tue, 8 Sep 2015 15:53:07 +0000
Message-ID: <CY1PR0301MB07484C8F1DE26A5EAFE9C7FD87530@CY1PR0301MB0748.namprd03.prod.outlook.com>
References: <1437670365-20704-1-git-send-email-mark.rutland@arm.com>
	<1437670365-20704-3-git-send-email-mark.rutland@arm.com>
	<55B5E8C1.4030707@arm.com> <55EA1C3F.1030300@caviumnetworks.com>
	<20150907180516.GC18079@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150907180516.GC18079@leverpostej>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi-5wv7dgnIgG8@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Chintakuntla, Radha" <Radha.Chintakuntla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "tirumalesh.chalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org" <tirumalesh.chalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Richter,
	Robert" <Robert.Richter-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "majun258-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <majun258-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


> -----Original Message-----
> From: Mark Rutland [mailto:mark.rutland-5wv7dgnIgG8@public.gmane.org]
> Sent: Monday, September 07, 2015 1:05 PM
> To: David Daney
> Cc: Marc Zyngier; tirumalesh.chalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org; Richter, Robert; Chintakuntla, Radha;
> devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-arm-
> kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; Will Deacon; Robin Murphy; Lorenzo Pieralisi; arnd-r2nGTMty4D4@public.gmane.org; treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org;
> majun258-hv44wF8Li93QT0dZR+AlfA@public.gmane.org; thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org; laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org; Yoder Stuart-B08248
> Subject: Re: [PATCH 2/3] Docs: dt: Add PCI MSI map bindings
> 
> On Fri, Sep 04, 2015 at 11:33:35PM +0100, David Daney wrote:
> > Hi Mark,
> 
> Hi David,
> 
> > I now have a prototype implementation for irq-gic-v3-its.c that is using
> > this binding on Cavium's ThunderX platform.
> >
> > Q: Have you guys had any more thoughts on this that might require
> > changing the binding?
> 
> Having discussed this with Stuart and others at Linux Plumbers, I think
> that the binding is sufficient, and unlikely to change greatly unless
> there is a strong objection (Stuart, please correct me if I am wrong).
> 
> Per Marc's comments there are probably some edge cases and/or wording
> details to sort out, but I think the common/simple case is sorted. I'll
> send a v2 once those have been settled.

I think the binding as-is, is sufficient for the static description
of RID to SID.

I think the binding can be extended in a backwards compatible way
to support dynamic RID->SID mappings if we need that in the future.

The case that we (Freescale) are concerned with are where someone
plugs an SRIOV card into an SoC and enables, say 64 VFs.  It's
like hot-plugging 64 new PCI devices at once.  If all those devices
that show up belong to the host they belong to one 'isolation context' and
could share the same streamID, same SMMU mappings, and the same
ITT in the GIC ITS.  So a static mapping could work.

But, as soon as I want to assign VF#5 to a virtual machine I need
a new RID->SID mapping for VF#5.  To require firmware to do that mapping
ahead of time is a _real_ pain.  I think longer term we need some
mechanism to allow lazy, dynamic RID->SID mappings by Linux.

We can start with the static approach, but we need to keep in the
back of our minds that there may be cases in the near future
where a static mapping is too inflexible.

Thanks,
Stuart
