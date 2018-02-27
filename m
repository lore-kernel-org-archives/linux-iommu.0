From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 1/4] iommu/arm-smmu-v3: Clean up address masking
Date: Tue, 27 Feb 2018 13:28:31 +0000
Message-ID: <0734679d-d94a-92e7-8cea-dcf0c07b0620@arm.com>
References: <cover.1512038236.git.robin.murphy@arm.com>
	<24f90689e35a90a337601943a48902a7ab6a7c4d.1512038236.git.robin.murphy@arm.com>
	<20180226180455.GB26147@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180226180455.GB26147-5wv7dgnIgG8@public.gmane.org>
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
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kristina.martsenko-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, steve.capper-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On 26/02/18 18:04, Will Deacon wrote:
> Hi Robin,
> 
> On Thu, Dec 14, 2017 at 04:58:50PM +0000, Robin Murphy wrote:
>> Before trying to add the SMMUv3.1 support for 52-bit addresses, make
>> things bearable by cleaning up the various address mask definitions to
>> use GENMASK_ULL() consistently. The fact that doing so reveals (and
>> fixes) a latent off-by-one in Q_BASE_ADDR_MASK only goes to show what a
>> jolly good idea it is...
>>
>> Tested-by: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>> ---
>>
>> v2: Clean up one more now-unnecessary linewrap
>>
>>   drivers/iommu/arm-smmu-v3.c | 53 ++++++++++++++++++---------------------------
>>   1 file changed, 21 insertions(+), 32 deletions(-)
> 
> Whilst I agree that using GENMASK is better, this patch does mean that the
> driver is (more) inconsistent with its _MASK terminology in that you can't
> generally tell whether a definition that ends in _MASK is shifted or not,
> and this isn't even consistent for fields within the same register.

The apparently slightly-less-than-obvious internal consistency is that 
every mask used for an *address field* is now in-place, while other 
types of field are still handled as inconsistently as they were before. 
It should also be the case that every x_MASK without a corresponding 
x_SHIFT defined next to it is unshifted.

Either way it's certainly no *worse* than the current situation where 
address masks sometimes have a nonzero shift, sometimes have zero bits 
at the bottom and a shift of 0, and sometimes have no shift defined at all.

Thinking about it some more, the address masks should only ever be 
needed when *extracting* an address from a register/structure word, or 
validating them in the context of an address *before* inserting into a 
field - if we can't trust input to be correct then just silently masking 
off bits probably isn't the best idea either way - so IMHO there is 
plenty of contextual disambiguation too.

> Should we be using GENMASK/BIT for all fields instead and removing all of
> the _SHIFT definitions?

I'm all aboard using BIT() consistently for single-bit boolean fields, 
but for multi-bit fields in general we do have to keep an explicit shift 
defined *somewhere* in order to make sensible use of the value, i.e. either:

	val = (reg >> 22) & 0x1f;
	reg = (val & 0x1f) << 22;

or:
	val = (reg & 0x07c00000) >> 22;
	reg = (val << 22) & 0x07c00000;

[ but ideally not this mess we currently have in some places:

	val = (reg & 0x1f << 22) >> 22;
]

Again, I'd gladly clean everything up to at least be self-consistent 
(and line up more with how we did things in SMMUv2) if you think it's 
worthwhile. Although I guess that means I'd get the job of fixing up 
future stable backport conflicts too ;)

Robin.
