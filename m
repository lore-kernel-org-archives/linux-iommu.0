From: Mason <slash.tmp@free.fr>
Subject: Re: [RFC PATCH v0.001] PCI: Add support for tango PCIe controller
Date: Tue, 21 Mar 2017 14:01:57 +0100
Message-ID: <d5062453-39cc-1435-bb13-87c81b6ef0b3@free.fr>
References: <ab110ce2-8678-9b34-6bd1-6cfaaa7fea04@free.fr>
 <f13c385d-dcc9-dacd-2b2c-ca098228f4f4@free.fr>
 <20170321123129.GB6816@e110455-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170321123129.GB6816@e110455-lin.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Liviu Dudau <liviu.dudau@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pci <linux-pci@vger.kernel.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, iommu <iommu@lists.linux-foundation.org>, David Laight <david.laight@aculab.com>, Bjorn Helgaas <helgaas@kernel.org>, Phuong Nguyen <phuong_nguyen@sigmadesigns.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

On 21/03/2017 13:31, Liviu Dudau wrote:

> On Tue, Mar 21, 2017 at 11:15:16AM +0100, Mason wrote:
>>
>> On 17/03/2017 17:11, Mason wrote:
>>
>>> + * QUIRK #5
>>> + * Only transfers within the BAR are forwarded to the host.
>>> + * By default, the DMA framework expects that
>>> + * PCI address 0x8000_0000 -> CPU address 0x8000_0000
>>> + * which is where DRAM0 is mapped.
>>
>> I have an additional question on this topic.
>>
>> In a typical system, PCI bus masters are able to access all of RAM,
>> unless there is some kind of IOMMU, right?
> 
> Depends where the ATS (Address translation service) lives and what gets
> programmed there, but usually one can restrict the RAM (or system address
> space, to be more precise) that can be accessed from the PCI bus masters
> by only providing PCI(e)-to-system bus mappings that make sense. Remember
> that on any PCI bus you can only see addresses that are a subset of your
> parent bus addresses. If the root PCI bus only allows access to a predefined
> range of addresses, then that is all you can access in the system.

Hmmm, where do I configure the range of addresses which the root
PCI bus allows access to? In the DT?

>> I suppose one may consider the above limitation ("Only transfers
>> within the BAR are forwarded to the host") as some form of weird
>> IOMMU? (There is, in fact, some remapping logic in the controller
>> setup which I haven't discussed so far.)
> 
> Not sure I understand the quirk. What BAR are you referring to when you say
> "within the BAR"? The bus master's? Are you saying that only if you write
> to a PCI bus address XXXXXXX that is in the range assigned by the parent
> bus then you can escape your bus hierarchy and target the system RAM? That
> sounds backwards to me.

My PCIe controller is b/d/f 0/0/0.
It ignores all PCI addresses that do not fall within the range
defined in BAR0 of b/d/f 0/0/0.

BAR0 has a configurable width of 2^(23+i) bytes, i < 8
It is implicitly split in 8 regions, which can map to
anywhere in CPU space. However, my understanding is that,
by default, the DMA framework expects PCI address X to
map to CPU address X...
(My understanding of that part is still a bit hazy.)

>> Since this SoC is used for TV, the media cartels mandate some way
>> to limit where PCI bus masters can peek/poke in RAM.
> 
> And that is usually done by either having a TrustZone controller on top of
> your PCI host bridge or by putting an IOMMU.

It seems we don't have this HW, therefore some kind of custom
HW quirk was required.

Regards.
