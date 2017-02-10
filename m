From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 06/11] iommu: Add iommu_device_set_fwnode() interface
Date: Fri, 10 Feb 2017 16:03:07 +0000
Message-ID: <f770249b-ad98-10d8-ea79-dc10cef7f4df@arm.com>
References: <1486639981-32368-1-git-send-email-joro@8bytes.org>
	<1486639981-32368-7-git-send-email-joro@8bytes.org>
	<417eee8c-4e1b-57f0-2c00-d6c3926ce66d@arm.com>
	<20170210152254.GI7339@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170210152254.GI7339-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 10/02/17 15:22, Joerg Roedel wrote:
> Hi Robin,
> 
> On Fri, Feb 10, 2017 at 02:16:54PM +0000, Robin Murphy wrote:
>>> +static inline void iommu_device_set_fwnode(struct iommu_device *iommu,
>>> +					   struct fwnode_handle *fwnode)
>>> +{
>>> +	iommu->fwnode = fwnode;
>>> +}
>>
>> Would it make sense to simply make the ops and fwnode additional
>> arguments to iommu_device_register() (permitting fwnode to be NULL)?
>> AFAICS they should typically all have the same effective lifetime so
>> there doesn't seem to be any real need to handle everything separately.
> 
> Well, it is not yet clear what other information will end up in
> 'struct iommu_device', and I don't want to add another parameter to
> iommu_device_register for every new struct member.

That's a fair point. I think the ops, as a core piece of the whole API,
would be sufficiently self-explanatory as part of registration, but then
we'd end up with a weird interface with different members initialised
through different paths, and I agree that ends up just as ugly.

> Also I think having these wrappers is more readable in the code, as it
> is clear what the code does without looking up the function prototypes
> in the header.

Yeah, on reflection explicit initialisation is certainly easier to read
than a bunch of arguments handled implicitly by register(), but then
from that angle, even more clear would be to simply have the drivers
write the relevant struct members directly - I'd be quite happy with
that, and we then don't have to add another setter to iommu.h for every
new struct member (and risk it looking like Java code...)

Robin.

> 
> It might make sense to set the mandatory struct members via
> iommu_device_register in the future, but we'll see :)
> 
> 
> 	Joerg
> 
