From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V7 08/11] drivers: acpi: Handle IOMMU lookup failure with
 deferred probing or error
Date: Wed, 1 Feb 2017 14:10:51 -0500
Message-ID: <e547421e-caeb-2e13-e72c-a954450da971@codeaurora.org>
References: <f2370671-ece8-fbee-de19-350dd625088f@codeaurora.org>
 <93e79759-d614-9b36-d5ab-63e8eb725009@arm.com>
 <14751205-f034-7f0d-442a-854c3909425c@codeaurora.org>
 <5ba9f366d6e25397cdef8ad95b49e199@codeaurora.org>
 <175a3798-b824-ef1a-e112-9f6f472973ae@codeaurora.org>
 <20170130143851.GJ16461@arm.com>
 <b2e50c17de156341deab9fb8e91a8dec@codeaurora.org>
 <1e048aff-0d77-b9f2-ebf8-2ba315b90ca7@codeaurora.org>
 <20170130165124.GA11712@red-moon>
 <f401e27e-d619-0eec-2401-50d8e2fc2f0f@codeaurora.org>
 <20170201185230.GA1922@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20170201185230.GA1922@red-moon>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Nate Watterson <nwatters@codeaurora.org>, Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, Sricharan R <sricharan@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, bhelgaas@google.com, Tomasz Nowicki <tn@semihalf.com>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On 2/1/2017 1:52 PM, Lorenzo Pieralisi wrote:
>> Sure, send it to both Nate and me.
> I debugged the issue and Nate's fix is correct, the fact that you
> can't it hit it with mainline is just a matter of timing because it has
> to do with the CTX pointer value (we OR it with the existing value), so
> it may work or not depending on how the cdptr memory allocation
> pattern turns out to be (which explains why Nate and I can hit it with
> simple PCI device remove/add execution too).
> 
> So it is neither an ACPI nor an IOMMU probe deferral issue per-se,
> fix is already queued, so it is all good.
> 
> What about USB stalls ?
> 
> Thanks !
> Lorenzo
> 

I'll get a hold of Nate and debug this. We were waiting for you to send us
debug code.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
