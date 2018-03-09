From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 5/6] dma-mapping: support fsl-mc bus
Date: Fri, 9 Mar 2018 18:50:05 +0000
Message-ID: <579b3df0-f78b-3c77-7a8a-9cd69848f1af@arm.com>
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
	<1520260166-29387-6-git-send-email-nipun.gupta@nxp.com>
	<20180305150814.GA15918@lst.de>
	<7b4f9972-6aaa-fc9d-3854-d48b19a8051c@arm.com>
	<20180305183938.GB20086@lst.de>
	<1729ae21-d08c-b413-51a3-f22c394b388d@arm.com>
	<HE1PR0401MB24251E99564CAA526F719ECCE6D90@HE1PR0401MB2425.eurprd04.prod.outlook.com>
	<20180308074115.GB15748@lst.de>
	<HE1PR0401MB2425871215B13AD0EFDCA5C3E6DE0@HE1PR0401MB2425.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <HE1PR0401MB2425871215B13AD0EFDCA5C3E6DE0-B0v07Ae2taqTjcJO+iVGAo3W/0Ik+aLCnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "stuyoder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <stuyoder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "catalin.marinas-5wv7dgnIgG8@public.gmane.org" <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Leo Li <leoyang.li-3arQi8VN3Tc@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 09/03/18 18:29, Nipun Gupta wrote:
> 
> 
>> -----Original Message-----
>> From: Christoph Hellwig [mailto:hch-jcswGhMUV9g@public.gmane.org]
>> Sent: Thursday, March 08, 2018 13:11
>>
>> On Tue, Mar 06, 2018 at 04:41:56AM +0000, Nipun Gupta wrote:
>>> Sorry for asking a trivial question - looking into dma_configure() I see that
>>> PCI is used in the start and the end of the API.
>>> In the end part pci_put_host_bridge_device() is called.
>>> So are two bus callbacks something like 'dma_config_start' &
>> 'dma_config_end'
>>> will be required where the former one will return "dma_dev"?
>>
>> I'd just use dma_configure as the callback.
> 
> This would be a decent stuff.

Yes, the PCI version should end up looking a lot like the old 
pci_dma_configure() used to, before everything got pulled together.

>> Currently the of_dma_configure and acpi_dma_configure are only used
>> for PCI anyway, as no one else sets a non-NULL dma dev.
> 
> My understanding is that even the platform bus uses the of_dma_configure
> and probably acpi_dma_configure too. So platform bus may also need the
> callback implemented. Please correct me if my understanding is wrong.

Indeed, platform and AMBA will want an implementation to dispatch 
between {of,acpi}_dma_configre() per the current logic. Host1x doesn't 
seem to care about ACPI so probably wants its own just calling 
of_dma_configure().

> I will submit the patch with 'dma_configure' callback implemented for
> the busses shortly.

Cheers - I've been trying to find some time to take a look myself, but 
having something to review instead would certainly be easier :)

Robin.
