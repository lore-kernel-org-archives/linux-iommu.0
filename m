From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 1/2] ACPICA: IORT: Update SMMU models for IORT rev. C
Date: Wed, 31 May 2017 13:21:18 +0100
Message-ID: <c4be5ea8-2ada-e625-6152-3c2751d1ee02@arm.com>
References: <11ef7d28c535c01d42b7b3c8e632934f0e0f1048.1495459319.git.robin.murphy@arm.com>
 <20170530091205.GB2764@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170530091205.GB2764@8bytes.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: will.deacon@arm.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, gakula@caviumnetworks.com, linu.cherian@cavium.com, rrichter@cavium.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, john.garry@huawei.com, shameerali.kolothum.thodi@huawei.com, gabriele.paoloni@huawei.com, rjw@rjwysocki.net, robert.moore@intel.com, lv.zheng@intel.com
List-Id: iommu@lists.linux-foundation.org

On 30/05/17 10:12, Joerg Roedel wrote:
> On Mon, May 22, 2017 at 04:06:37PM +0100, Robin Murphy wrote:
>> IORT revision C has been published with a number of new SMMU
>> implementation identifiers. Since IORT doesn't have any way of falling
>> back to a more generic model code, we really need Linux to know about
>> these before vendors start updating their firmware tables to use them.
>>
>> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
>> CC: Robert Moore <robert.moore@intel.com>
>> CC: Lv Zheng <lv.zheng@intel.com>
>> Acked-by: Robert Richter <rrichter@cavium.com>
>> Tested-by: Robert Richter <rrichter@cavium.com>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>
>> v2: Update more comments, add Robert's tags.
> 
> I generally prefer 'Fixes'-tags, can you please add them too?

This patch isn't a fix, though, it's merely adding some new stuff from a
new release of the IORT spec.

Either way, since I discovered we do actually have approval to
contribute to ACPICA directly, I now intend to route the header change
that way per Rafaels' preference[1] - patch 2/2 will take care of itself
in the meantime.

Thanks,
Robin.

[1]:https://www.mail-archive.com/iommu@lists.linux-foundation.org/msg17602.html

