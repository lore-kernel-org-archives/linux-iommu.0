From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 1/7] iommu/of: Respect disabled IOMMUs
Date: Tue, 14 Jun 2016 16:04:22 +0100
Message-ID: <57601CF6.6000308@arm.com>
References: <cover.1464966939.git.robin.murphy@arm.com>
	<aca0b44206c87f6cb75d156a53e08aa968981119.1464966939.git.robin.murphy@arm.com>
	<20160614141148.GH19407@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160614141148.GH19407-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 14/06/16 15:11, Will Deacon wrote:
> On Fri, Jun 03, 2016 at 06:15:36PM +0100, Robin Murphy wrote:
>> If an IOMMU node is present in the DT but marked as disabled, we should
>> avoid trying to do anything with it. We currently sort-of get away with
>> this by virtue of a disabled device probably not having called
>> of_iommu_set_ops(), but that is hardly safe to rely upon in general, and
>> either way we don't want to treat it as an error condition with the
>> resulting "Failed to initialise IOMMU" message.
>
> What's the use-case for this? I ask because epapr says that the device
> binding should provide details as to exactly what "disabled" means for
> that device.

Right now, it's mostly a case of making things behave as expected - the 
OF platform code is already assigning the implicit meaning of "don't 
probe or do anything with this device", so playing along with that 
prevents slightly confusing errors or potential null-dereference-style 
crashes as above.

Longer term, I was also thinking back to the probe ordering problem, and 
the sticky case of differentiating "this IOMMU isn't probed yet" from 
"this IOMMU will never probe, continue without it". Being able to make 
that decision from the bootloader (by disabling nodes) in at least a 
subset of cases seemed like a useful tool. I'm still open to other 
points of view, though.

Robin.

>
> Will
>
