From: Mitchel Humpherys <mitchelh@codeaurora.org>
Subject: Re: How to keep PCI-e endpoints and RCs in distinct IOMMU groups?
Date: Thu, 02 Jun 2016 12:33:22 -0700
Message-ID: <vnkwa8j3fksd.fsf@codeaurora.org>
References: <vnkwoa7ty89k.fsf@codeaurora.org>
	<20160525204558.08c30a34@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20160525204558.08c30a34@ul30vt.home> (Alex Williamson's message
	of "Wed, 25 May 2016 20:45:58 -0600")
Sender: linux-pci-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>
Cc: iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, Tony Truong <truong@codeaurora.org>, Yan He <yanhe@codeaurora.org>, Pratik Patel <pratikp@codeaurora.org>, Hamad Kadmany <hkadmany@codeaurora.org>, Maya Erez <qca_merez@qca.qualcomm.com>
List-Id: iommu@lists.linux-foundation.org

On Wed, May 25 2016 at 08:45:58 PM, Alex Williamson <alex.williamson@redhat.com> wrote:
>> Why do we do that?  If the devices have different BDFs can't we safely
>> say that they're protected from peer-to-peer DMA (assuming no DMA
>> aliasing quirks)?  Even as I write that out it seems wrong though since
>> the RC can probably do whatever it wants...
>> 
>> Maybe the IOMMU framework can't actually know whether the devices should
>> be kept in separate groups and we just need to do something custom in
>> the arm-smmu driver?
>
> You're only considering the visibility of devices to the IOMMU, not the
> isolation between devices.  Without ACS peer-to-peer can be re-routed
> between devices before the IOMMU even knows about it.  That's why the
> root port is included in the group.  I'm confused why your driver is
> using the IOMMU API instead of the much more common DMA API anyway
> though.  Thanks,
>
> Alex

Ah ok, thanks for the explanation!

The driver *is* using the DMA API.  I'm actually working on the DMA APIs
themselves (a hacked-up version of the arm32 DMA APIs that have been
forklifted into arm64, to be exact).  Anyways, it looks like the best
route for us long-term is to try and align with Robin's arm64 IOMMU DMA
API mapper and take it from there.


-Mitch

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
