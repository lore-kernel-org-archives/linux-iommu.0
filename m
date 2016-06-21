From: Brian Starkey <brian.starkey@arm.com>
Subject: Re: SMMU driver and stall vs terminate mode
Date: Tue, 21 Jun 2016 15:47:42 +0100
Message-ID: <20160621144742.GA23672@e106950-lin.cambridge.arm.com>
References: <HE1PR04MB1641B0F8442061E3437037628D2A0@HE1PR04MB1641.eurprd04.prod.outlook.com>
 <5768150D.2070705@arm.com> <20160621094237.GL29165@arm.com>
 <HE1PR04MB16414F95D83077B75F3000188D2B0@HE1PR04MB1641.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <HE1PR04MB16414F95D83077B75F3000188D2B0@HE1PR04MB1641.eurprd04.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stuart Yoder <stuart.yoder@nxp.com>
Cc: Bharat Bhushan <bharat.bhushan@nxp.com>, Will Deacon <will.deacon@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Nipun Gupta <nipun.gupta@nxp.com>, Robin Murphy <robin.murphy@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

On Tue, Jun 21, 2016 at 02:36:17PM +0000, Stuart Yoder wrote:
>
>
>> -----Original Message-----
>> From: Will Deacon [mailto:will.deacon@arm.com]
>> Sent: Tuesday, June 21, 2016 4:43 AM
>> To: Robin Murphy <robin.murphy@arm.com>
>> Cc: Stuart Yoder <stuart.yoder@nxp.com>; linux-arm-kernel@lists.infradead.org; iommu@lists.linux-
>> foundation.org; Nipun Gupta <nipun.gupta@nxp.com>; Bharat Bhushan <bharat.bhushan@nxp.com>; Brian
>> Starkey <brian.starkey@arm.com>
>> Subject: Re: SMMU driver and stall vs terminate mode
>>
>> On Mon, Jun 20, 2016 at 05:08:45PM +0100, Robin Murphy wrote:
>> > On 20/06/16 16:28, Stuart Yoder wrote:
>> > >Right now the SMMU driver is hardcoded to configure 'stall' mode for
>> > >context faults:
>> > >
>> > >       /* SCTLR */
>> > >       reg = SCTLR_CFCFG | SCTLR_CFIE | SCTLR_CFRE | SCTLR_M | SCTLR_EAE_SBOP;
>> > >
>> > >We are running into an issue with a device where it seems behave sanely
>> > >when SCTLR_CFCFG=0 ...i.e. 'terminate' mode, but in stall mode seems to be
>> > >unaware that an access violation occurred.
>> >
>> > Does the device keep issuing transactions after the initial faulting one, by
>> > any chance? Brian (+cc) has seen similar-sounding issues in the past (albeit
>> > with backports to some horrible Android kernel), and I think we concluded
>> > that there's an inherent race window between writing RESUME and acking the
>> > interrupt in which MMU-500 can process another faulting transaction and
>> > reassert the IRQ without Linux realising, which then gets lost and things go
>> > out of whack.

The problem in my case ended up being that one of the IRQ lines for the
MMU wasn't actually wired up - so the MMU driver never knew there was an
IRQ to handle and so never un-stalled the transactions.
I think it was the context bank's line, so global faults worked fine but
not context faults.

Of course, there may also be a race on RESUME.

>>
>> Do we not detect this with the MULTI bit in the FSR?
>>
>> > >Is there really some assumption that all devices that send transcactions
>> > >through the SMMU _must_ be able to handle stall mode?  I am trying to
>> > >find out from our hw designers what is going on at the signal level for
>> > >the device in question, but it seems to me that 'terminate' mode exists
>> > >for a reason and I wonder what your thoughts are about providing a
>> > >configuration option to allow configuration of terminate mode if a particular
>> > >SoC requires it.
>> >
>> > Personally, I'd quite happily leave it turned off (MMU-400/401 don't support
>> > stalling anyway), but I recall Will having a fairly reasonable-sounding
>> > argument in favour, which I now can't remember the details of. Hopefully he
>> > might remind us, unless his conference is too enthralling.
>>
>> Given that we don't do anything particularly useful in the context fault
>> handler, I also wouldn't object to turning this off (and removing the
>> retry/reporting machinery). However, I'd want t better description of
>> *why* it's causing problems first, so that we can justify the decision
>> in case anybody is using this out of tree.

Is map-on-fault a valid enough use-case?
Drivers can register their own fault handlers, so even if arm-smmu isn't
doing anything interesting, I think the master's driver might.

>
>I am trying to get more details from HW owners of this device as to
>its behavior in these 2 different SMMU modes.
>

My understanding is that it should be transparent to the hardware. It
just looks like translation is taking a particularly long time (before
ultimately faulting). As long as the MMU IRQ handler is running as it
should, the transactions will eventually fault as normal.

Thanks,
Brian

>Stuart
>
