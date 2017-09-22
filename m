From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2] iommu/of: Remove PCI host bridge node check
Date: Fri, 22 Sep 2017 10:51:30 +0100
Message-ID: <49550b7b-b5bc-6687-dc5d-3a71605389ca@arm.com>
References: <7ff4e56719d2e90426d9338eab00396bb2b61995.1505988973.git.robin.murphy@arm.com>
 <56a797382ffc65243169205c36d9f9fb1173dddd.1505989095.git.robin.murphy@arm.com>
 <20170922085618.GI8398@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170922085618.GI8398@8bytes.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, jean-philippe.brucker@arm.com
List-Id: iommu@lists.linux-foundation.org

On 22/09/17 09:56, Joerg Roedel wrote:
> Hey Robin,
> 
> On Thu, Sep 21, 2017 at 11:20:58AM +0100, Robin Murphy wrote:
>> of_pci_iommu_init() tries to be clever and stop its alias walk at the
>> device represented by master_np, in case of weird PCI topologies where
>> the bridge to the IOMMU and the rest of the system is not at the root.
>> It turns out this is a bit short-sighted, since there are plenty of
>> other callers of pci_for_each_dma_alias() which would also need the same
>> behaviour in that situation, and the only platform so far with such a
>> topology (Cavium ThunderX2) already solves it more generally via a PCI
>> quirk. As this check is effectively redundant, and returning a boolean
>> value as an int is a bit broken anyway, let's just get rid of it.
>>
>> Reported-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> Can you send me a Fixes: tag for this please? No need to resend the
> whole patch, I just need the tag.

Sure, I'd go for:

Fixes: d87beb749281 ("iommu/of: Handle PCI aliases properly")

The check itself originally dates back to b996444cf35e ("iommu/of:
Handle iommu-map property for PCI") but it's really not worth
backporting past the above refactoring - it's only with da4b02750a9f
("iommu/of: Fix of_iommu_configure() for disabled IOMMUs") in 4.14-rc1
that it started to have noticeable ill effects.

Thanks,
Robin.
