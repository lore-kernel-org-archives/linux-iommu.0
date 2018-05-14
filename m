From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: Difference between IOVA and bus address when SMMU is enabled
Date: Mon, 14 May 2018 11:45:26 +0100
Message-ID: <c6521bad-04c9-7bc6-0e7c-b4965de6ff3b@arm.com>
References: <c4fe00a3-33b1-7cd4-f613-768dee06ef6b@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c4fe00a3-33b1-7cd4-f613-768dee06ef6b@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: valmiki <valmikibow@gmail.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Hi Valmiki,

On 12/05/18 13:55, valmiki wrote:
> Hi All,
> 
> What is the difference between IOVA address and bus address
> when SMMU is enabled ?

They are the same. You'll use one term or the other depending on what
system component you're talking about. "IOVA" only means something when
talking about IOMMUs, where it represents the input address. If you're
discussing bus transactions without caring whether an SMMU is enabled or
not, then "bus address" makes more sense.

We distinguish "IOVA" from "VA", which represents the input address of
the CPU's MMU (e.g. any userspace pointer). The distinction is useful
because the SMMU page tables are usually separate from the CPU page
tables. In this case if you want to share a buffer between application
and device, you'll have to allocate and map both a VA on the CPU side,
and an IOVA on the device side. When sharing MMU page tables with the
SMMU (see the SVA work), then we tend to talk about VA instead of IOVA,
because they are identical.

> Is IOVA address term used only when hypervisor is present ?

No, the term is used in bare-metal setups as well.

Thanks,
Jean
