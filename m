From: Stuart Yoder <stuart.yoder-3arQi8VN3Tc@public.gmane.org>
Subject: RE: SMMU driver and stall vs terminate mode
Date: Tue, 21 Jun 2016 14:36:17 +0000
Message-ID: <HE1PR04MB16414F95D83077B75F3000188D2B0@HE1PR04MB1641.eurprd04.prod.outlook.com>
References: <HE1PR04MB1641B0F8442061E3437037628D2A0@HE1PR04MB1641.eurprd04.prod.outlook.com>
	<5768150D.2070705@arm.com> <20160621094237.GL29165@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160621094237.GL29165-5wv7dgnIgG8@public.gmane.org>
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
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Bharat Bhushan <bharat.bhushan-3arQi8VN3Tc@public.gmane.org>, Brian Starkey <brian.starkey-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Will Deacon [mailto:will.deacon-5wv7dgnIgG8@public.gmane.org]
> Sent: Tuesday, June 21, 2016 4:43 AM
> To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> Cc: Stuart Yoder <stuart.yoder-3arQi8VN3Tc@public.gmane.org>; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; iommu-cunTk1MwBs/ROKNJybVBZg@public.gmane.org
> foundation.org; Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>; Bharat Bhushan <bharat.bhushan-3arQi8VN3Tc@public.gmane.org>; Brian
> Starkey <brian.starkey-5wv7dgnIgG8@public.gmane.org>
> Subject: Re: SMMU driver and stall vs terminate mode
> 
> On Mon, Jun 20, 2016 at 05:08:45PM +0100, Robin Murphy wrote:
> > On 20/06/16 16:28, Stuart Yoder wrote:
> > >Right now the SMMU driver is hardcoded to configure 'stall' mode for
> > >context faults:
> > >
> > >       /* SCTLR */
> > >       reg = SCTLR_CFCFG | SCTLR_CFIE | SCTLR_CFRE | SCTLR_M | SCTLR_EAE_SBOP;
> > >
> > >We are running into an issue with a device where it seems behave sanely
> > >when SCTLR_CFCFG=0 ...i.e. 'terminate' mode, but in stall mode seems to be
> > >unaware that an access violation occurred.
> >
> > Does the device keep issuing transactions after the initial faulting one, by
> > any chance? Brian (+cc) has seen similar-sounding issues in the past (albeit
> > with backports to some horrible Android kernel), and I think we concluded
> > that there's an inherent race window between writing RESUME and acking the
> > interrupt in which MMU-500 can process another faulting transaction and
> > reassert the IRQ without Linux realising, which then gets lost and things go
> > out of whack.
> 
> Do we not detect this with the MULTI bit in the FSR?
> 
> > >Is there really some assumption that all devices that send transcactions
> > >through the SMMU _must_ be able to handle stall mode?  I am trying to
> > >find out from our hw designers what is going on at the signal level for
> > >the device in question, but it seems to me that 'terminate' mode exists
> > >for a reason and I wonder what your thoughts are about providing a
> > >configuration option to allow configuration of terminate mode if a particular
> > >SoC requires it.
> >
> > Personally, I'd quite happily leave it turned off (MMU-400/401 don't support
> > stalling anyway), but I recall Will having a fairly reasonable-sounding
> > argument in favour, which I now can't remember the details of. Hopefully he
> > might remind us, unless his conference is too enthralling.
> 
> Given that we don't do anything particularly useful in the context fault
> handler, I also wouldn't object to turning this off (and removing the
> retry/reporting machinery). However, I'd want t better description of
> *why* it's causing problems first, so that we can justify the decision
> in case anybody is using this out of tree.

I am trying to get more details from HW owners of this device as to
its behavior in these 2 different SMMU modes.

Stuart
