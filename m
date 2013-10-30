From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCHv3 01/19] [HACK] of: dev_node has struct device pointer
Date: Wed, 30 Oct 2013 15:47:43 -0600
Message-ID: <52717E7F.1060807@wwwdotorg.org>
References: <20131024.122115.1035609747068925560.hdoyu@nvidia.com>
	<20131025001038.77299C403B6@trevor.secretlab.ca>
	<20131025075652.GB19622@ulmo.nvidia.com>
	<20131025.112202.47792301040951621.hdoyu@nvidia.com>
	<20131025132051.GD9999@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20131025132051.GD9999-MRww78TxoiP5vMa5CHWGZ34zcgK1vI+I0E9HWUfgJXw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 10/25/2013 07:20 AM, Will Deacon wrote:
> On Fri, Oct 25, 2013 at 09:22:02AM +0100, Hiroshi Doyu wrote:
>> Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote @ Fri, 25 Oct 2013 09:56:55 +0200:
>>
>>> I suspect that there will be enough differences between the various
>>> IOMMU implementations that we won't be able to have a unified binding
>>> (especially for how to associate devices with a particular virtual
>>> address space), but perhaps that could be solved with something like an
>>> .of_xlate() that IOMMU drivers implement, much like we've done with most
>>> other subsystems too.
>>>
>>> The binding for Tegra's IOMMU currently only uses the HW IDs (or a mask)
>>> to put a device into a given address space, but I think that could be
>>> easily extended to something like:
>>>
>>> 	memory-clients = <&iommu MASK>;
>>>
>>> Or similar. If other information is required, we could encode that into
>>> a multi-cell specifier. Perhaps we could even leave away the phandle
>>> since typically there will only be a single IOMMU in the system?
>>>
>>> Does that sound reasonable? Hiroshi is much more familiar with IOMMUs,
>>> so I'd like to get his opinion on the above as well.
>>
>> I think that the above may be possible, but I'd like to listen from
>> other IOMMU SOC maintainers.
>>
>> A brief explanation for "memory-clients":
>>
>> In tegra, every H/W has its own memory-client ID, and it can be
>> associated to any address spaces. The above "memory-cilents" is used
>> to indicate which ID a device has in DT. If the other SOC IOMMUs need
>> this kind of "memory-clients", this would be standarized. Any comment?
>>
>> At least arm-smmu seems to have the following. multiple IOMMUs can be
>> handled with this.
>>
>>
>> - smmu-parent   : When multiple SMMUs are chained together, this
>>                   property can be used to provide a phandle to the
>>                   parent SMMU (that is the next SMMU on the path going
>>                   from the mmu-masters towards memory) node for this
>>                   SMMU.
> 
> This property is for the case when IOMMUs are connected in series, which is
> fairly horrendous. However, it is extremely common to have multiple IOMMU
> instances within an Soc (Exynos SoCs have one IOMMU per device iirc), so
> that certainly needs to be handled.

That property sounds a bit scary; is the value a single parent IOMMU?
What if an IOMMU splits its requests between two different parent IOMMUs
based on some property of the request. I hope smmu-parent isn't going to
get us into another interrupts -vs- interrupts-extended situation.

(/me checks the documentation of that property)

I suppose smmu-parent is documented in a device-specific binding rather
than as a generic property, although there's no vendor-prefix on the
property name:-(, so we havne't cornered ourselves too much here; any
IOMMU device which actually has multiple parents can always define its
own custom property to represent that.
