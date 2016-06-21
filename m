From: Stuart Yoder <stuart.yoder-3arQi8VN3Tc@public.gmane.org>
Subject: RE: SMMU driver and stall vs terminate mode
Date: Tue, 21 Jun 2016 14:33:35 +0000
Message-ID: <HE1PR04MB1641D09BBF8029ED98BE18D38D2B0@HE1PR04MB1641.eurprd04.prod.outlook.com>
References: <HE1PR04MB1641B0F8442061E3437037628D2A0@HE1PR04MB1641.eurprd04.prod.outlook.com>
	<5768150D.2070705@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5768150D.2070705-5wv7dgnIgG8@public.gmane.org>
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
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Bharat Bhushan <bharat.bhushan-3arQi8VN3Tc@public.gmane.org>, Brian Starkey <brian.starkey-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy-5wv7dgnIgG8@public.gmane.org]
> Sent: Monday, June 20, 2016 11:09 AM
> To: Stuart Yoder <stuart.yoder-3arQi8VN3Tc@public.gmane.org>; Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>
> Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; Nipun Gupta
> <nipun.gupta-3arQi8VN3Tc@public.gmane.org>; Bharat Bhushan <bharat.bhushan-3arQi8VN3Tc@public.gmane.org>; Brian Starkey <brian.starkey-5wv7dgnIgG8@public.gmane.org>
> Subject: Re: SMMU driver and stall vs terminate mode
> 
> Hi Stuart,
> 
> On 20/06/16 16:28, Stuart Yoder wrote:
> > Robin/Will,
> >
> > Right now the SMMU driver is hardcoded to configure 'stall' mode for
> > context faults:
> >
> >        /* SCTLR */
> >        reg = SCTLR_CFCFG | SCTLR_CFIE | SCTLR_CFRE | SCTLR_M | SCTLR_EAE_SBOP;
> >
> > We are running into an issue with a device where it seems behave sanely
> > when SCTLR_CFCFG=0 ...i.e. 'terminate' mode, but in stall mode seems to be
> > unaware that an access violation occurred.
> 
> Does the device keep issuing transactions after the initial faulting
> one, by any chance?

In the case we are seeing, it is a unit test type scenario and I think
there is only one transaction, so software doesn't try to continue issuing
transactions.

Stuart
