From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH 2/4] iommu/arm-smmu-v3: Link domains and devices
Date: Fri, 5 Apr 2019 19:07:56 +0100
Message-ID: <b21e1dc0-c0c8-6c48-fd3f-cd6c9653434b@arm.com>
References: <20190320173634.21895-1-jean-philippe.brucker@arm.com>
 <20190320173634.21895-3-jean-philippe.brucker@arm.com>
 <20190404143924.GB27823@fuggles.cambridge.arm.com>
 <312d33a5-8eca-3fae-fd8b-8325e045761b@arm.com>
 <20190405163949.GA19828@fuggles.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190405163949.GA19828@fuggles.cambridge.arm.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>
Cc: linux-acpi@vger.kernel.org, zhongmiao@hisilicon.com, rjw@rjwysocki.net, okaya@kernel.org, "eric.auger@redhat.com" <eric.auger@redhat.com>, iommu@lists.linux-foundation.org, sudeep.holla@arm.com, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, lenb@kernel.org
List-Id: iommu@lists.linux-foundation.org

On 05/04/2019 17:39, Will Deacon wrote:
>>> I'm wondering whether we can't take this a bit further and re-organise the
>>> data structures to make this a little simpler overall. Something along the
>>> lines of:
>>>
>>> 	struct arm_smmu_master_data {
>>> 		struct list_head		list; // masters in the same domain
>>> 		struct arm_smmu_device		*smmu;
>>> 		unsigned int			num_sids;
>>> 		u32				*sids; // Points into fwspec
>>> 		struct arm_smmu_domain		*domain; // NULL -> !assigned
>>> 	};
>>>
>>> and then just add a list_head into struct arm_smmu_domain to track the
>>> masters that have been attached (if you're feeling brave, you could put
>>> this into the s1_cfg).
>>
>> I'm not sure about that last bit, shouldn't the list of masters apply to
>> both s1 and s2?
> 
> I was assuming that (a) we were only using ATS with stage-1 and (b) we only
> need the masters list for ATC invalidation. Did I go wrong somewhere?

Hmm, I messed that up in patch 3, actually. I'm still unsure about it,
but in the end I was meaning to enable ATS for both stage-1 and stage-2
domains. We could make it stage-1 only, but VFIO can assign a device
with a stage-1 domain to userspace. That's the case with QEMU, which
doesn't use VFIO_TYPE1_NESTING_IOMMU at the moment. So I don't think
limiting ATS to stage-1 protects against anything.


For (b), the master list will likely also be used for PASID support, to
invalidate cached CDs for each device in a domain, but that's only stage-1.

Then the current patchsets for nested translation also rely on the
master list to bind guest PASID tables to all devices attached
to a domain. But with those patches, s1_cfg and s2_cfg aren't in an enum
anymore and we could still keep the list in s1_cfg.

Thanks,
Jean
