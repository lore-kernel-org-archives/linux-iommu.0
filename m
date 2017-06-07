From: Ray Jui <ray.jui@broadcom.com>
Subject: Re: Device address specific mapping of arm,mmu-500
Date: Tue, 6 Jun 2017 23:20:03 -0700
Message-ID: <41f12daa-b46c-83f1-9c9f-51de1cadf14f@broadcom.com>
References: <1b79efe2-6835-7a7a-f5ad-361391a7b967@broadcom.com>
 <20170530151437.GC23067@arm.com>
 <81637642-22d9-4868-156f-052f64bd042f@broadcom.com>
 <226bcebc-3902-90d3-24e5-51f2e1f3affb@arm.com>
 <a85b2e3f-93db-7c4d-cde8-32a57e69bef9@broadcom.com>
 <16e5fc9d-b014-af7c-dcda-527522ac5cc9@arm.com>
 <b47a379e-4a1b-42ff-8604-01b5becd685c@broadcom.com>
 <7bd03bf8-71d5-a974-bea2-a38b4349c547@broadcom.com>
 <20170531124418.GE9723@arm.com>
 <ee5bffb3-3aca-8214-1445-98f1f2d4ba09@broadcom.com>
 <498100e8-e94e-4a65-a9e1-ae59bd59fe2d@broadcom.com>
 <bc636388-9388-3582-23b0-9f4271cae4b2@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <bc636388-9388-3582-23b0-9f4271cae4b2@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

Hi Robin,


On 6/6/2017 3:02 AM, Robin Murphy wrote:
> I've currently got some experimental patches pushed out here:
>
>      git://linux-arm.org/linux-rm  iommu/pgtable
>
> So far, there's still one silly bug (which doesn't affect DMA ops usage)
> and an awkward race for non-coherent table walks which will need
> resolving before I have anything to post properly, which I hope will be
> within the next couple of weeks. In the meantime, though, it already
> seems to work well enough in practice, so any feedback is welcome!
>
> Robin.
Excellent! I'm going to find time to test it out (likely next week). 
I'll report back the test result after that.

Thanks,

Ray
