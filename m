From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 1/6] Docs: dt: add fsl-mc iommu-parent device-tree binding
Date: Mon, 5 Mar 2018 15:37:29 +0000
Message-ID: <f382e92a-8ab5-7c93-1f39-fe6797e5c876@arm.com>
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
	<1520260166-29387-2-git-send-email-nipun.gupta@nxp.com>
	<5cdeded1-ca3c-339a-bf73-73401e7dd4ed@arm.com>
	<HE1PR0401MB24254CBDB8B6F537D08B925DE6DA0@HE1PR0401MB2425.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <HE1PR0401MB24254CBDB8B6F537D08B925DE6DA0-B0v07Ae2taqTjcJO+iVGAo3W/0Ik+aLCnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
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
To: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "catalin.marinas-5wv7dgnIgG8@public.gmane.org" <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "stuyoder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <stuyoder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Leo Li <leoyang.li-3arQi8VN3Tc@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "hch-jcswGhMUV9g@public.gmane.org" <hch-jcswGhMUV9g@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 05/03/18 15:00, Nipun Gupta wrote:
> 
> 
>> -----Original Message-----
>> From: Robin Murphy [mailto:robin.murphy-5wv7dgnIgG8@public.gmane.org]
>> Sent: Monday, March 05, 2018 20:23
>> To: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>; will.deacon-5wv7dgnIgG8@public.gmane.org;
>> mark.rutland-5wv7dgnIgG8@public.gmane.org; catalin.marinas-5wv7dgnIgG8@public.gmane.org
>> Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; hch-jcswGhMUV9g@public.gmane.org;
>> m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org; gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org;
>> Leo Li <leoyang.li-3arQi8VN3Tc@public.gmane.org>; shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; linux-
>> kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-arm-
>> kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org; Bharat Bhushan
>> <bharat.bhushan-3arQi8VN3Tc@public.gmane.org>; stuyoder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; Laurentiu Tudor
>> <laurentiu.tudor-3arQi8VN3Tc@public.gmane.org>
>> Subject: Re: [PATCH 1/6] Docs: dt: add fsl-mc iommu-parent device-tree binding
>>
>> On 05/03/18 14:29, Nipun Gupta wrote:
>>> The existing IOMMU bindings cannot be used to specify the relationship
>>> between fsl-mc devices and IOMMUs. This patch adds a binding for
>>> mapping fsl-mc devices to IOMMUs, using a new iommu-parent property.
>>
>> Given that allowing "msi-parent" for #msi-cells > 1 is merely a
>> backward-compatibility bodge full of hard-coded assumptions, why would
>> we want to knowingly introduce a similarly unpleasant equivalent for
>> IOMMUs? What's wrong with "iommu-map"?
> 
> Hi Robin,
> 
> With 'msi-parent' the property is fixed up to have msi-map. In this case there is
> no fixup required and simple 'iommu-parent' property can be used, with MC bus
> itself providing the stream-id's (in the code execution via FW).
> 
> We can also use the iommu-map property similar to PCI, which will require u-boot
> fixup. But then it leads to little bit complications of u-boot - kernel compatibility.

What needs fixing up? With a stream-map-mask in place to ignore the 
upper Stream ID bits, you just need:

	iommu-map = <0 &smmu 0 0x80>;

to say that the lower bits of the ICID value map directly to the lower 
bits of the Stream ID value - that's the same fixed property of the 
hardware that you're wanting to assume in iommu-parent.

> If you suggest we can re-use the iommu-map property. What is your opinion?

I think it makes a lot more sense to directly use the property which 
already exists, than to introduce a new one to merely assume one 
hard-coded value of the existing one. Extending msi-parent to msi-map 
was a case of "oops, it turns out we need more flexibility here"; for 
the case of iommu-map I can't imagine any justification for saying 
"oops, we need less flexibility here" (saving 9 whole bytes in the DT 
really is irrelevant).

Robin.
