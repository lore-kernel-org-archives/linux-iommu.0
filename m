From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: Any side effect if turn off amd_iommu
Date: Wed, 25 Mar 2015 15:04:10 +0100
Message-ID: <20150325140410.GS4441@8bytes.org>
References: <CAFv23QmxQ3vJnMEGN0TNR3vLAx1MN7ptB0y3QQLKciqfT3OBsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAFv23QmxQ3vJnMEGN0TNR3vLAx1MN7ptB0y3QQLKciqfT3OBsQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: AceLan Kao <acelan.kao-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Mar 25, 2015 at 11:30:20AM +0800, AceLan Kao wrote:
> We have some AMD machines(AMD cpu and graphics) that need to set
> amd_iommu=off to work.
> Some of them have wifi issue that it can't connect to any AP(no
> interrupt)(can set noapic to workaround it, too),
> and some of them have graphics issues.
> The only workaround we found is to set amd_iommu=off, and it fixes both issues.
> 
> I have 2 questions.
> 1. What kind of these issues would be, are they a driver issue or a
> BIOS issue? If it's a BIOS issue, what we should tell the BIOS
> engineers, so that they know how to fix it?
> 2. Some of the machines may not have the chance to get a BIOS update,
> do you think it's okay to add a quirk in amd_iommu driver to blacklist
> out those machines? Are there any side effects if we do so?

Hard to tell what the issue is. Can you please boot the affected machine
with AMD IOMMU enabled and amd_iommu_dump on the command line and send
me dmesg of the machine after boot?

Thanks,

	Joerg
