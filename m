From: Sunil Kovvuri <sunil.kovvuri@gmail.com>
Subject: Re: [RFC PATCH 2/7] iommu/arm-smmu-v3: Do resource size checks based
 on smmu option PAGE0_REGS_ONLY
Date: Tue, 11 Apr 2017 22:09:39 +0530
Message-ID: <CA+sq2CfN0QOrcT9Nv3wkf-NwWwV4uO46UmDaObzmhs7W-407qA@mail.gmail.com>
References: <1491921765-29475-1-git-send-email-linucherian@gmail.com>
 <1491921765-29475-3-git-send-email-linucherian@gmail.com> <802c0a38-f5a6-e584-5795-42d8d3fd7603@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <802c0a38-f5a6-e584-5795-42d8d3fd7603@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: linucherian@gmail.com, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, hanjun.guo@linaro.org, sudeep.holla@arm.com, "Goutham, Sunil" <Sunil.Goutham@cavium.com>, Geethasowjanya.Akula@cavium.com, Joerg Roedel <joro@8bytes.org>, rjw@rjwysocki.net, robert.moore@intel.com, robert.richter@cavium.com, linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org, lv.zheng@intel.com, linu.cherian@cavium.com, devel@acpica.org, LAKML <linux-arm-kernel@lists.infradead.org>, lenb@kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 11, 2017 at 9:13 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 11/04/17 15:42, linucherian@gmail.com wrote:
>> From: Linu Cherian <linu.cherian@cavium.com>
>>
>> With implementations supporting only page 0 of register space,
>> resource size can be 64k as well and hence perform size checks
>> based on smmu option PAGE0_REGS_ONLY.
>
> What harm comes of mapping page 1 if we don't access it?
>
> Robin.
>

There are multiple SMMUs on the silicon and CSRs of each SMMU are
64K apart. Hence can't map page-1 even though it's not accessed.

Thanks,
Sunil.
