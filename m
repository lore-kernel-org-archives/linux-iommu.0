From: "Chalamarla, Tirumalesh" <Tirumalesh.Chalamarla@caviumnetworks.com>
Subject: Re: Master-aware devices and sideband ID data
Date: Fri, 29 May 2015 17:46:07 +0000
Message-ID: <E342D737-5DD5-48C7-BB01-B83C29CB6E31@caviumnetworks.com>
References: <20150324155007.GC23005@leverpostej>
 <26BE36EF-2C5B-4DA6-8950-8FEBB031ED1B@caviumnetworks.com>
 <20150527173953.GC23176@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150527173953.GC23176@leverpostej>
Content-Language: en-US
Content-ID: <A5EA07B24674914E93488525E7500B7B@namprd07.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "robh@kernel.org" <robh@kernel.org>, Marc Zyngier <Marc.Zyngier@arm.com>, "joro@8bytes.org" <joro@8bytes.org>, Will Deacon <Will.Deacon@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Chalamarla, Tirumalesh" <Tirumalesh.Chalamarla@caviumnetworks.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>, "olof@lixom.net" <olof@lixom.net>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "hdoyu@nvidia.com" <hdoyu@nvidia.com>
List-Id: iommu@lists.linux-foundation.org


> On May 27, 2015, at 10:39 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> 
> On Tue, May 26, 2015 at 11:20:59PM +0100, Chalamarla, Tirumalesh wrote:
>> This is some thing we also like to see in ITS and SMMU drivers. 
>>> On Mar 24, 2015, at 8:50 AM, Mark Rutland <mark.rutland@arm.com> wrote:
>>> 
>>> Hi all,
>>> 
>>> For some devices, identification of particular masters is critical to
>>> their operation (e.g. IOMMUs, MSI controllers). The identity of masters
>>> is determined from sideband signals on the bus, and it may or may not be
>>> possible to probe and/or configure this information. Worse still, these
>>> information may be rewritten by intermediate buses, so the
>>> information for a given master may differ at different points in the bus
>>> hierarchy.
>>> 
>>> We currently describe this master information for devices attached to
>>> IOMMUs, with a master ID being encoded in the iommu-cells. However this
>>> only covers the ID between the master and its IOMMU(s), and we don't
>>> currently have a mechanism to describe the master IDs as they are seen
>>> by devices beyond the IOMMU(s), or in the absence of any IOMMU(s).
>>> 
>>> The following are example of master IDs:
>>> * PCIe Requester IDs (RIDs) (bus:device.function AKA BDF)
>>> * SMMU Stream IDs (SIDs)
>>> * GICv3 ITS Device IDs (DIDs)
>>> 
>>> In the case of a system with PCIe, SMMU and GICv3, the master IDs are
>>> rewritten in a chain of RID=>SID=>DID, as in the following diagram:
>>> 
>>> +-------------+
>>> | PCIe master |
>>> +-------------+
>>>   ||
>>>   || Requester ID (RID)
>>>   || Probeable from RC.
>>>   \/
>>> +-------------------+
>>> | PCIe Root Complex |
>>> +-------------------+
>>>   ||
>>>   || SMMU Stream ID (SID)
>>>   || Derived from RID, static non-probeable mapping.
>>>   \/
>>> +--------------+
>>> | SMMU (IOMMU) |
>>> +--------------+
>>>   ||
>>>   || ITS Device ID (DID)
>>>   || Derived from SID, static non-probeable mapping.
>>>   \/
>>> +----------------------------+
>>> | GICv3 ITS (MSI controller) |
>>> +----------------------------+
>>> 
>>> In simpler cases, you might have a simpler set of master ID
>>> translations, e.g. just a DID:
>>> 
>>> +-----------------+
>>> | Platform device |
>>> +-----------------+
>>>   ||
>>>   || ITS Device ID (DID)
>>>   || Hard-wired on the bus.
>>>   \/
>>> +----------------------------+
>>> | GICv3 ITS (MSI controller) |
>>> +----------------------------+
>>> 
>>> Ignoring current bindings for the moment, I can see how we can describe
>>> this with a generic master id-binding, with master-id-map along the
>>> lines of interrupt-map, with a tuple format like:
>>> <child-id-base child-id-length parent parent-id-base>
>>> 
>>> For the PCIe example, this would look something like the following (with
>>> properties omitted for brevity):
>>> 
>>> PCI: pci@af000000 {
>>> 	...
>>> 	
>>> 	/* Requester ID of PCIe endpoints, implicit at runtime */
>>> 	master-id-cells = <1>;
>>> 
>>> 	/* RIDS idmapped to SIDS @ SMMU */
>>> 	master-id-map = <0 0x10000 &SMMU 0>;
>>> }
>>> 
>>> SMMU: iommu@bf000000 {
>>> 	...
>>> 
>>> 	/* SID, derived from RID */
>>> 	master-id-cells = <1>;
>>> 
>>> 	/* 
>>> 	 * For some reason the high bit of the ID was negated.
>>> 	 */
>>> 	master-id-map = <0x0000 0x8000 &ITS 0x0 0x8000>,
>>> 	                <0x8000 0x8000 &ITS 0x0 0x0000>;
>>> 
>>> };
>>> 
>>> ITS: its@cf000000 {
>>> 	...
>>> 
>>> 	/* DID, derived from SID */
>>> 	master-id-cells = <2>;
>>> 
>>> 	/* 
>>> 	 * Master traffic not propagated beyond this point, so no
>>> 	 * master-id-ranges
>>> 	 */
>>> };
>> 
>> I think it is nice to have max IDs supported by masters. so that drivers can check and enforce.  
> 
> The set of IDs that we expect to transform (i.e. those masters use)
> would be implicit in the first master-id-map from a master. In the PCI
> example above, no master is expected to generate an ID outside of the
> range 0-0x10000 inclusive (and that's all the SMMU would see).
> 
> For devices which are not hotpluggable, the nodes for those devices
> would describe the specific set of IDs they use.
> 
> Generally, between a master and a slave there might not be one
> contiguous set of valid IDs as these may be rewritten along the way (as
> happens at the SMMU between the PCI root complex and the ITS in the
> example above).
> 
> Which drivers do you think need this information? What exactly are they
> trying to check and enforce?
> 

I think, i miss understood by the names, so it is not base it is some thing like

x => f(x) => y           (and f(x) is bitwise | )

ok now i see it. 


>>> For the simpler case, this would look something like:
>>> 
>>> DEV: device@af000000 {
>>> 	master-id-cells = <1>;
>>> 	master-ids = <0xf>, <0xb>;
>>> 	master-id-map = <0 0xf &ITS 0 0>;
>>> };
>>> 
>>> ITS: its@cf000000 {
>>> 	...
>>> 
>>> 	/* DID */
>>> 	master-id-cells = <2>;
>>> };
>>> 
>> Is this is not depending heavily on discover order, how do drivers
>> know which device to get which ID. is it implicitly assumed in
>> discovery order? 
> 
> I'm not sure I follow the question. Could you elaborate?
> 
>> what happens to hot pluggable devices.  
> 
> It would be necessary to be able to discover the ID assigned to the
> device by the hotpluggable bus. For example, this could depend on which
> slot the device is plugged into.
> 
> If you can't discover the ID associated with a hotpluggable device from
> the bus it is plugged into I can't see how hotplug could work.
> 
> From that point on I would expect the ID transformations to be static as
> in the example.
> 

what if i have an SMMU with two ITS masters and i want to decide which one to use based on runtime like which CPU i am serving.

i am thinking in terms go NUMA based systems, where my pci device is on node 0, if the interrupt is targeted to CPU on node 1, i would like to use ITS1, otherwise 
ITS0. 

is it possible to specify some thing like that or do you think its is best to leave to ITS driver. 

Thanks,
Tirumalesh. 

> Thanks,
> Mark.
