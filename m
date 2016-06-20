From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: SMMU driver and stall vs terminate mode
Date: Mon, 20 Jun 2016 17:08:45 +0100
Message-ID: <5768150D.2070705@arm.com>
References: <HE1PR04MB1641B0F8442061E3437037628D2A0@HE1PR04MB1641.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <HE1PR04MB1641B0F8442061E3437037628D2A0-6LN7OEpIatU5tNmRkpaxD89NdZoXdze2vxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Stuart Yoder <stuart.yoder-3arQi8VN3Tc@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Bharat Bhushan <bharat.bhushan-3arQi8VN3Tc@public.gmane.org>, Brian Starkey <brian.starkey-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Stuart,

On 20/06/16 16:28, Stuart Yoder wrote:
> Robin/Will,
>
> Right now the SMMU driver is hardcoded to configure 'stall' mode for
> context faults:
>
>        /* SCTLR */
>        reg = SCTLR_CFCFG | SCTLR_CFIE | SCTLR_CFRE | SCTLR_M | SCTLR_EAE_SBOP;
>
> We are running into an issue with a device where it seems behave sanely
> when SCTLR_CFCFG=0 ...i.e. 'terminate' mode, but in stall mode seems to be
> unaware that an access violation occurred.

Does the device keep issuing transactions after the initial faulting 
one, by any chance? Brian (+cc) has seen similar-sounding issues in the 
past (albeit with backports to some horrible Android kernel), and I 
think we concluded that there's an inherent race window between writing 
RESUME and acking the interrupt in which MMU-500 can process another 
faulting transaction and reassert the IRQ without Linux realising, which 
then gets lost and things go out of whack.

> Is there really some assumption that all devices that send transcactions
> through the SMMU _must_ be able to handle stall mode?  I am trying to
> find out from our hw designers what is going on at the signal level for
> the device in question, but it seems to me that 'terminate' mode exists
> for a reason and I wonder what your thoughts are about providing a
> configuration option to allow configuration of terminate mode if a particular
> SoC requires it.

Personally, I'd quite happily leave it turned off (MMU-400/401 don't 
support stalling anyway), but I recall Will having a fairly 
reasonable-sounding argument in favour, which I now can't remember the 
details of. Hopefully he might remind us, unless his conference is too 
enthralling.

Robin.

>
> Thanks,
> Stuart
>
